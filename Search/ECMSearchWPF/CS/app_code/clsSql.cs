// VBConversions Note: VB project level imports
using System.Windows.Input;
using System.Windows.Data;
using System.Windows.Documents;
using System.Xml.Linq;
using System.Collections.Generic;
using System.Windows.Navigation;
using System.Windows.Media.Imaging;
using System.Windows;
using Microsoft.VisualBasic;
using System.Windows.Media;
using System.Collections;
using System;
using System.Windows.Shapes;
using System.Windows.Controls;
using System.Threading.Tasks;
using System.Linq;
using System.Diagnostics;
// End of VB project level imports

using System.Configuration;
using System.Collections.Specialized;
using System.Collections.ObjectModel;
using System.IO;
using System.Threading;

//Imports System.Data.SqlClient

namespace ECMSearchWPF
{
	public class clsSql
	{
		//Dim DB As New clsDatabase
		
		
		
		//Dim proxy As New SVCSearch.Service1Client
		SVCSearch.Service1Client proxy2 = new SVCSearch.Service1Client();
		SVCSearch.Service1Client proxy3 = new SVCSearch.Service1Client();
		
		clsDma DMA = new clsDma();
		clsGenerator GEN = new clsGenerator();
		//Dim EP As New clsEndPoint
		clsEncryptV2 ENC2 = new clsEncryptV2();
		
		clsUtility UTIL = new clsUtility();
		clsLogging LOG = new clsLogging();
		
		List<string> ExpandedWords = new List<string>();
		string ListOfPhrases = "";
		bool bRunningSql = false;
		
		bool gettingThesaurusWords = false;
		
		bool dDeBug = true;
		bool bSaveToClipBoard = true;
		
		object txtSearch = null;
		bool getCountOnly = System.Convert.ToBoolean(null);
		bool UseExistingRecordsOnly = System.Convert.ToBoolean(null);
		bool ckWeighted = System.Convert.ToBoolean(null);
		string GeneratedSQL = null;
		bool isAdmin = System.Convert.ToBoolean(null);
		bool ckBusiness = System.Convert.ToBoolean(null);
		bool isInflectionalTerm = false;
		bool InflectionalToken = false;
		List<string> ThesaurusList = new List<string>();
		List<string> ThesaurusWords = new List<string>();
		
		string SecureID = "-1";
		public clsSql()
		{
			
			SecureID = GLOBALS._SecureID.ToString();
			
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted += new System.EventHandler(client_ExecuteSqlNewConn);
			proxy2.ExecuteSqlNewConnSecureCompleted += new System.EventHandler(client_ExecuteSqlNewConn);
			proxy3.ExecuteSqlNewConnSecureCompleted += new System.EventHandler(client_ExecuteSqlNewConn);
			GLOBALS.ProxySearch.getSynonymsCompleted += new System.EventHandler(client_getSynonyms);
			
			//EP.setSearchSvcEndPoint(proxy)
			
		}
		
		public string pInflectionalToken
		{
			get
			{
				return InflectionalToken;
			}
			set
			{
				InflectionalToken = bool.Parse(value);
			}
		}
		public bool bInflectionalTerm
		{
			get
			{
				return isInflectionalTerm;
			}
			set
			{
				isInflectionalTerm = value;
			}
		}
		
		public string GenDocSearchSql(string SearchString, bool ckLimitToExisting, string txtThesaurus, string cbThesaurusText, bool ckLimitToLib, string LibraryName)
		{
			var WhereClause = "";
			bool bCopyToClipboard = true;
			var UserSql = "";
			
			if (SearchString == null)
			{
				LOG.WriteToSqlLog("All required variables not set to call this function.");
				//return ""
			}
			if (getCountOnly == null)
			{
				getCountOnly = false;
				//LOG.WriteToSqlLog("All required variables not set to call this function.")
				//return ""
			}
			if (ckWeighted == null)
			{
				ckWeighted = true;
				LOG.WriteToSqlLog("ckWeighted 201: All required variables not set to call this function.");
				//return ""
			}
			
			
			GeneratedSQL = "";
			//**WDM Removed 7/12/2009 GeneratedSQL$ = genHeader()
			GeneratedSQL += "\r\n";
			
			
			if (getCountOnly)
			{
				GeneratedSQL += genContenCountSql();
			}
			else
			{
				
				GeneratedSQL += getContentTblCols(ckWeighted);
				if (ckWeighted)
				{
					GeneratedSQL += genIsAbout(ckWeighted, ckBusiness, SearchString, false);
				}
				
				GeneratedSQL += " WHERE " + "\r\n";
				
				//genDocWhereClause(WhereClause as string)
				var ContainsClause = "";
				//************************************************************************************************************************************************************
				ContainsClause = genContainsClause(SearchString, ckBusiness, ckWeighted, false, ckLimitToExisting, ThesaurusList, txtThesaurus, cbThesaurusText, "DOC");
				//************************************************************************************************************************************************************
				
				ContainsClause = ContainsClause + genUseExistingRecordsOnly(UseExistingRecordsOnly, "SourceGuid");
				
				//***********************************************************************
				//isAdmin = gisadmin
				if (modGlobals.gIsAdmin == false)
				{
					modGlobals.gIsAdmin = modGlobals.gIsGlobalSearcher;
				}
				UserSql = genAdminContentSql(isAdmin, ckLimitToLib, LibraryName);
				//***********************************************************************
				if (ContainsClause.Length)
				{
					GeneratedSQL = GeneratedSQL + "\r\n" + ContainsClause;
				}
				
				if (bCopyToClipboard)
				{
					var tClip = "/* Part2 */ " + "\r\n";
					tClip += GeneratedSQL;
				}
				
				
				if (UserSql.Length > 0)
				{
					GeneratedSQL += (string) ("\r\n" + UserSql);
				}
			}
			
			
			if (getCountOnly)
			{
			}
			else
			{
				if (ckWeighted == true)
				{
					GeneratedSQL = GeneratedSQL + " and KEY_TBL.RANK >= " + modGlobals.MinRating.ToString() + "\r\n";
				}
				else
				{
				}
				
				
				if (ckWeighted)
				{
					//GeneratedSQL$ += vbCrLf + " or isPublic = 'Y' "
					GeneratedSQL += "\r\n" + " ORDER BY KEY_TBL.RANK DESC ";
				}
				else
				{
					//GeneratedSQL$ += vbCrLf + " or isPublic = 'Y' "
					GeneratedSQL += "\r\n" + " order by [SourceName] ";
				}
			}
			
			
			if (bCopyToClipboard)
			{
				var tClip = "/* Final */ " + "\r\n";
				tClip += GeneratedSQL;
			}
			
			
			ValidateNotClauses(ref GeneratedSQL);
			
			DMA.ckFreetextRemoveOr(ref GeneratedSQL, " FREETEXT (");
			return GeneratedSQL;
			
			
		}
		
		
		public string pGeneratedSQL
		{
			get
			{
				return GeneratedSQL;
			}
			set
			{
				GeneratedSQL = value;
			}
		}
		public bool pCkBusiness
		{
			get
			{
				return ckBusiness;
			}
			set
			{
				ckBusiness = value;
			}
		}
		public bool pIsAdmin
		{
			get
			{
				return isAdmin;
			}
			set
			{
				isAdmin = value;
			}
		}
		public bool pCkWeighted
		{
			get
			{
				return ckWeighted;
			}
			set
			{
				ckWeighted = value;
			}
		}
		public bool pUseExistingRecordsOnly
		{
			get
			{
				return UseExistingRecordsOnly;
			}
			set
			{
				UseExistingRecordsOnly = value;
			}
		}
		public bool pGetCountOnly
		{
			get
			{
				return getCountOnly;
			}
			set
			{
				getCountOnly = value;
			}
		}
		public string pTxtSearch
		{
			get
			{
				return txtSearch;
			}
			set
			{
				txtSearch = value;
			}
		}
		
		
		public string GenEmailGeneratedSQL(bool ckLimitToExisting, string txtThesaurus, string cbThesaurusText, bool ckWeighted, bool ckBusiness, string txtSearch, bool ckLimitToLib, string LibraryName, int MinWeight, bool bIncludeAllLibs, bool getCountOnly, bool UseExistingRecordsOnly, string GeneratedSQL)
		{
			//ByVal txtSearch as string, byval getCountOnly As Boolean, ByVal UseExistingRecordsOnly As Boolean, ByVal ckWeighted As Boolean, ByRef GeneratedSQL As String
			
			if (txtSearch == null)
			{
				LOG.WriteToSqlLog("All required variables not set to call this function.");
				//return ""
			}
			else
			{
				
			}
			if (getCountOnly == null)
			{
				getCountOnly = false;
				//LOG.WriteToSqlLog("All required variables not set to call this function.")
				//return ""
			}
			if (UseExistingRecordsOnly == null)
			{
				UseExistingRecordsOnly = false;
				//LOG.WriteToSqlLog("All required variables not set to call this function.")
				//return ""
			}
			else
			{
				UseExistingRecordsOnly = ckLimitToExisting;
			}
			if (! ckWeighted)
			{
				ckWeighted = false;
			}
			else if (ckWeighted)
			{
				ckWeighted = true;
			}
			else if (ckWeighted == null)
			{
				ckWeighted = false;
			}
			if (GeneratedSQL == null)
			{
				//LOG.WriteToSqlLog("All required variables not set to call this function.")
				//return ""
			}
			if (modGlobals.gIsAdmin == false)
			{
				modGlobals.gIsAdmin = modGlobals.gIsGlobalSearcher;
			}
			if (modGlobals.gIsAdmin == null)
			{
				LOG.WriteToSqlLog("All required variables not set to call this function.");
				//return ""
			}
			if (ckBusiness == null)
			{
				ckBusiness = false;
			}
			
			var EmailSql = "";
			var WhereClause = "";
			bool bCopyToClipboard = true;
			
			string UserSql = genAdminEmailSql(isAdmin, ckLimitToLib, LibraryName);
			//**WDM Removed 7/12/2009 GeneratedSQL$ = genHeader()
			
			if (getCountOnly)
			{
				GeneratedSQL += genEmailCountSql();
			}
			else
			{
				GeneratedSQL += getEmailTblCols(ckWeighted, ckBusiness, txtSearch);
			}
			
			
			GeneratedSQL = GeneratedSQL + " WHERE " + "\r\n";
			
			
			var ContainsClause = "";
			ContainsClause = genContainsClause(txtSearch, ckBusiness, ckWeighted, true, ckLimitToExisting, ThesaurusList, txtThesaurus, cbThesaurusText, "EMAIL");
			
			if (ContainsClause.Length > 0)
			{
				GeneratedSQL = GeneratedSQL + "\r\n" + ContainsClause;
			}
			
			
			if (bCopyToClipboard)
			{
				var tClip = "/* WhereClause$ */ " + "\r\n";
				tClip += WhereClause;
			}
			
			EmailSql = GeneratedSQL + "\r\n";
			if (bCopyToClipboard)
			{
				var tClip = "/* ContainsClause */ " + "\r\n";
				tClip += EmailSql;
			}
			
			
			if (ContainsClause.Trim().Length > 0)
			{
				
				EmailSql = GeneratedSQL + "\r\n";
				EmailSql += " " + "\r\n" + WhereClause + "\r\n";
				
				if (getCountOnly)
				{
					EmailSql += UserSql;
				}
				else
				{
					EmailSql += (string) ("\r\n" + UserSql);
					
					if (ckWeighted == true)
					{
						//EmailSql += " and KEY_TBL.RANK >= " + MinRating.ToString + vbCrLf
						//EmailSql += vbCrLf + " ORDER BY KEY_TBL.RANK DESC "
						
						//**WDM 6/1/2008 EmailSql += " /* and KEY_TBL.RANK >= " + MinRating.ToString + " */" + vbCrLf
						EmailSql += "    and KEY_TBL.RANK >= " + modGlobals.MinRating.ToString() + "\r\n";
						
						string IncludeEmailAttachmentsQry = EmailSql + "\r\n";
						//If ckIncludeAttachments.Checked Then
						bool ckIncludeAttachments = true;
						
						//If ckWeighted = True Then
						//    IncludeEmailAttachmentsSearchWeighted(ckIncludeAttachments, ckWeighted, ckBusiness, txtSearch, ckLimitToExisting, txtThesaurus, cbThesaurusText, MinWeight)
						//Else
						//    IncludeEmailAttachmentsSearch(ckIncludeAttachments, ckWeighted, ckBusiness, txtSearch, ckLimitToExisting, txtThesaurus, cbThesaurusText, LibraryName$, bIncludeAllLibs)
						//End If
						
						if (ckIncludeAttachments == true && ckLimitToLib == false)
						{
							//** ECM EmailAttachmentSearchList
							if (modGlobals.gMasterContentOnly == true)
							{
							}
							else
							{
								//IncludeEmailAttachmentsQry$ = vbCrLf + " OR " + "([EmailGuid] in (select EmailGuid from EmailAttachmentSearchList where UserID = '" + gCurrUserGuidID + "'))" + vbCrLf
							}
							
							//EmailSql = EmailSql + vbCrLf + IncludeEmailAttachmentsQry$ + vbCrLf
							EmailSql = EmailSql + genUseExistingRecordsOnly(UseExistingRecordsOnly, "EmailGuid");
							
							//Clipboard.Clear()
							//Clipboard.SetText(EmailSql)
						}
						//EmailSql += vbCrLf + " or isPublic = 'Y' "
						EmailSql += "\r\n" + " ORDER BY KEY_TBL.RANK DESC " + "\r\n";
						
					}
					else
					{
						var IncludeEmailAttachmentsQry = EmailSql + "\r\n";
						//If ckIncludeAttachments.Checked Then
						bool ckIncludeAttachments = true;
						IncludeEmailAttachmentsSearch(ckIncludeAttachments, ckWeighted, ckBusiness, txtSearch, ckLimitToExisting, txtThesaurus, cbThesaurusText, LibraryName, bIncludeAllLibs);
						//If ckIncludeAttachments = True And ckLimitToLib = False Then
						//    '** ECM EmailAttachmentSearchList
						//    If gMasterContentOnly = True Then
						//    Else
						//        IncludeEmailAttachmentsQry$ = vbCrLf + " OR " + "([EmailGuid] in (select EmailGuid from EmailAttachmentSearchList where UserID = '" + gCurrUserGuidID + "'))" + vbCrLf
						//    End If
						
						//    EmailSql = EmailSql + vbCrLf + IncludeEmailAttachmentsQry$ + vbCrLf
						//    EmailSql = EmailSql + genUseExistingRecordsOnly(UseExistingRecordsOnly, "EmailGuid")
						//End If
						//EmailSql += vbCrLf + " or isPublic = 'Y' "
						EmailSql += "\r\n" + " order by [ShortSubj] ";
					}
				}
			}
			else
			{
				EmailSql = "";
			}
			if (bCopyToClipboard)
			{
				var tClip = "/* Final */ " + "\r\n";
				tClip += EmailSql;
			}
			
			ValidateNotClauses(ref EmailSql);
			DMA.ckFreetextRemoveOr(ref EmailSql, "freetext ((Body, Description, KeyWords, Subject, Attachment, Ocrtext)");
			DMA.ckFreetextRemoveOr(ref EmailSql, "freetext (body");
			DMA.ckFreetextRemoveOr(ref EmailSql, "freetext (subject");
			
			return EmailSql;
		}
		public void SubIn(ref string ParentString, string WhatToChange, string ChangeCharsToThis)
		{
			int I = 0;
			int J = 0;
			int M = 0;
			int N = 0;
			var S1 = "";
			var S2 = "";
			
			
			M = WhatToChange.Length;
			N = ChangeCharsToThis.Length;
			
			
			while (ParentString.IndexOf(WhatToChange) + 1 > 0)
			{
				I = ParentString.IndexOf(WhatToChange) + 1;
				S1 = ParentString.Substring(0, I - 1);
				S2 = ParentString.Substring(I + M - 1);
				var NewLine = S1 + ChangeCharsToThis + S2;
				ParentString = NewLine;
			}
		}
		public void SkipToNextToken(string S, ref int I)
		{
			string Delimiters = " ,:+-^|";
			S = S.Trim();
			var Token = "";
			var CH = "";
			CH = S.Substring(I - 1, 1);
			int KK = S.Length;
			
			
			Token = "";
			I++;
			CH = S.Substring(I - 1, 1);
			KK = S.Length;
			if (CH.Length > 0 && Delimiters.IndexOf(CH) + 1 == 0)
			{
				return;
			}
			if (CH.Equals("-"))
			{
				return;
			}
			if (CH.Equals("^"))
			{
				return;
			}
			if (CH.Equals("~"))
			{
				return;
			}
			if (CH.Equals("+"))
			{
				return;
			}
			if (CH.Equals("|"))
			{
				return;
			}
			while (!(Delimiters.IndexOf(CH) + 1 == 0 && I <= KK))
			{
				Token += CH;
				I++;
				CH = S.Substring(I - 1, 1);
				LOG.WriteToSqlLog(Token);
				if (I > S.Length)
				{
					break;
				}
			}
			
			
		}
		public string getNextToken(string S, ref int I, ref string ReturnedDelimiter)
		{
			string Delimiters = " ,:+-^|()";
			S = S.Trim();
			var Token = "";
			var CH = "";
			CH = S.Substring(I - 1, 1);
			int KK = S.Length;
			
			
			//** If CH is a blank char, skip to the start of the next token
			if (CH == " ")
			{
				while (!(CH != " " && I <= KK))
				{
					I++;
					CH = S.Substring(I - 1, 1);
				}
			}
			
			
			if (CH == Strings.ChrW(34))
			{
				Token = "";
				Token += Strings.ChrW(34);
				I++;
				CH = S.Substring(I - 1, 1);
				KK = S.Length;
				while (!(CH == Strings.ChrW(34) && I <= KK))
				{
					Token += CH;
					I++;
					CH = S.Substring(I - 1, 1);
					if (I > S.Length)
					{
						break;
					}
				}
				Token += Strings.ChrW(34);
				//WDM May need to put back I += 1
			}
			else
			{
				Token = CH;
				I++;
				CH = S.Substring(I - 1, 1);
				KK = S.Length;
				while (!(Delimiters.IndexOf(CH) + 1 > 0 && I <= KK))
				{
					Token += CH;
					I++;
					CH = S.Substring(I - 1, 1);
					ReturnedDelimiter = CH;
					if (I > S.Length)
					{
						break;
					}
				}
				//WDM May need to put back I += 1
			}
			return Token;
		}
		public string getTheRestOfTheToken(string S, ref int I)
		{
			//We are sitting at the next character in the token, so go back to the beginning
			I--;
			string Delimiters = " ,:+-^|";
			S = S.Trim();
			var Token = "";
			var CH = "";
			CH = S.Substring(I - 1, 1);
			int KK = S.Length;
			
			
			//** If CH is a blank char, skip to the start of the next token
			if (CH == " ")
			{
				while (!(CH != " " && I <= KK))
				{
					I++;
					CH = S.Substring(I - 1, 1);
				}
			}
			
			
			if (CH == Strings.ChrW(34))
			{
				Token = "";
				Token += Strings.ChrW(34);
				I++;
				CH = S.Substring(I - 1, 1);
				KK = S.Length;
				while (!(CH == Strings.ChrW(34) && I <= KK))
				{
					Token += CH;
					I++;
					CH = S.Substring(I - 1, 1);
					if (I > S.Length)
					{
						break;
					}
				}
				Token += Strings.ChrW(34);
				I++;
			}
			else
			{
				Token = CH;
				I++;
				CH = S.Substring(I - 1, 1);
				KK = S.Length;
				while (!(Delimiters.IndexOf(CH) + 1 > 0 && I <= KK))
				{
					Token += CH;
					I++;
					CH = S.Substring(I - 1, 1);
					if (I > S.Length)
					{
						break;
					}
				}
				I++;
			}
			return Token;
		}
		public void GetToken(int I, int k, string tStr)
		{
			int X = tStr.Trim().Length;
			string CH = "";
			var Alphabet = " |+-^";
			for (var I = I; I <= X; I++)
			{
				CH = tStr.Substring(I - 1, 1);
				if (Alphabet.IndexOf(CH) + 1 > 0)
				{
					//We found the next word
				}
			}
		}
		public bool isKeyWord(string KW)
		{
			bool B = false;
			KW = KW.ToUpper();
			switch (KW)
			{
				case "AND":
					return true;
				case "OR":
					return true;
				case "NOT":
					return true;
				case "AND":
					return true;
			}
			return B;
		}
		public void TranslateDelimiter(string CH, ref string Translateddel)
		{
			Translateddel = "";
			switch (CH)
			{
				case "+":
					Translateddel = "And";
					break;
				case "-":
					Translateddel = "Not";
					break;
				case "|":
					Translateddel = "Or";
					break;
			}
		}
		public void GetQuotedString(string tstr, ref int i, int j, ref string QuotedString)
		{
			int X = tstr.Trim().Length;
			var Q = Strings.ChrW(34);
			string CH = "";
			var Alphabet = " |+-^";
			string S = "";
			QuotedString = Q;
			i++;
			CH = tstr.Substring(i - 1, 1);
			while (CH != Strings.ChrW(34) && i <= tstr.Length)
			{
				QuotedString = QuotedString + CH;
				i++;
				CH = tstr.Substring(i - 1, 1);
			}
			QuotedString = QuotedString + Q;
		}
		public void SkipTokens(string tstr, int i, int j)
		{
			int X = tstr.Trim().Length;
			var Q = Strings.ChrW(34);
			string CH = "";
			var Alphabet = " |+-^";
			string S = "";
			for (var j = i + 1; j <= X; j++)
			{
				CH = tstr.Substring(j - 1, 1);
				if (Alphabet.IndexOf(CH) + 1 == 0)
				{
					break;
					//We found the string
				}
			}
		}
		public bool isNotDelimiter(string CH)
		{
			var Alphabet = " |+-^";
			if (Alphabet.IndexOf(CH) + 1 == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		public bool isDelimiter(string CH)
		{
			var Alphabet = " |+-^";
			if (Alphabet.IndexOf(CH) + 1 > 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		public bool isSyntaxChar(string CH)
		{
			var Alphabet = "#|+-^~";
			if (Alphabet.IndexOf(CH) + 1 > 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		public string buildContainsSyntax(string SearchCriteria, List<string> ThesaurusWords)
		{
			//** Get all the OR'SearchCriteria and build a search term then
			//** get all the AND'SearchCriteria and build a search term then
			//** Apply any NEAR'SearchCriteria to the mess.
			
			
			// "dale miller" "susan miller" near Jessie
			// "dale miller" "susan miller" +Jessie Shelby
			// "dale miller" +"susan miller" +Jessie
			//Dale Susan near Jessie
			//+dale +susan near Jessie
			//+dale +susan Jessie
			//+dale +susan +Jessie
			
			
			//WHERE CONTAINS(*, '"ECA" or "Enterprise Content" AND "Content*" and "state" NEAR "State Farm"')
			//** '"ECA" or "Enterprise Content" AND "Content*" and "state" NEAR "State Farm" and "Corporate"'
			//** 'ECA or "Enterprise Content" AND Content* and state NEAR "State Farm" and Corporate'
			//** 'ECA "Enterprise Content" +Content* +state NEAR "State Farm" +Corporate'
			//** WHERE CONTAINS(Description, ' FORMSOF (INFLECTIONAL, ride) ');
			
			
			List<string> A = new List<string>();
			int I = 0;
			int J = 0;
			var Ch = "";
			var tWord = "";
			int WordCnt = 0;
			bool isOr = false;
			bool isAnd = false;
			bool isNear = false;
			bool isPhrase = false;
			bool isAndNot = false;
			string Delimiters = " ,:";
			string DQ = Strings.ChrW(34);
			bool FirstEntry = true;
			var QuotedString = "";
			bool OrNeeded = false;
			bool AndNeeded = false;
			
			ThesaurusWords.Clear();
			
			SearchCriteria = SearchCriteria.Trim();
			
			
			for (I = 1; I <= SearchCriteria.Length; I++)
			{
				
				
StartNextWord:
				Ch = SearchCriteria.Substring(I - 1, 1);
				if (FirstEntry)
				{
					if (Ch.Equals("~") || Ch.Equals("^") || Ch.Equals("^") || Ch.Equals("#"))
					{
						//** DO nothing - it belongs here
					}
					else
					{
						if (isDelimiter(Ch))
						{
							SkipTokens(SearchCriteria, I, J);
							I = J;
							goto StartNextWord;
						}
					}
					
					FirstEntry = false;
				}
TokenAlreadyAcquired:
				if (Ch == Strings.ChrW(34))
				{
					QuotedString = "";
					J = 0;
					GetQuotedString(SearchCriteria, ref I, J, ref QuotedString);
					if (QuotedString.Equals(Strings.ChrW(34) + Strings.ChrW(34)))
					{
						if (dDeBug)
						{
							Console.WriteLine("Skipping null double quotes.");
						}
					}
					else
					{
						A.Add(QuotedString);
					}
					
					OrNeeded = true;
				}
				else if (Ch.Equals("|"))
				{
					OrNeeded = false;
					A.Add("Or");
				}
				else if (Ch.Equals("+"))
				{
					A.Add("And");
					OrNeeded = false;
				}
				else if (Ch.Equals("-"))
				{
					A.Add("Not");
					OrNeeded = false;
				}
				else if (Ch.Equals("("))
				{
					if (dDeBug)
					{
						Console.WriteLine("Skipping: " + Ch);
					}
					A.Add("(");
				}
				else if (Ch.Equals(")"))
				{
					if (dDeBug)
					{
						Console.WriteLine("Skipping: " + Ch);
					}
					A.Add(")");
				}
				else if (Ch.Equals(","))
				{
					if (dDeBug)
					{
						Console.WriteLine("Skipping: " + Ch);
					}
				}
				else if (Ch == "^")
				{
					//** Then this will be an inflectional term
					//** One term using the AND operator will be built for each inflectional term provided.
					string SubstituteString = "FORMSOF (INFLECTIONAL, " + Strings.ChrW(34) + "@" + Strings.ChrW(34) + ")";
					I++;
					
					var ReturnedDelimiter = "";
					
					tWord = getNextToken(SearchCriteria, ref I, ref ReturnedDelimiter);
					var C = SearchCriteria.Substring(I - 1, 1);
					SubIn(ref SubstituteString, "@", tWord);
					tWord = SubstituteString;
					SubIn(ref tWord, (string) (Strings.ChrW(34) + Strings.ChrW(34)), Strings.ChrW(34));
					
					if (OrNeeded)
					{
						A.Add("Or");
					}
					
					if (dDeBug)
					{
						Console.WriteLine(I.ToString() + ":" + SearchCriteria.Substring(I - 1, 1));
					}
					A.Add(tWord);
					OrNeeded = true;
					tWord = "";
					goto StartNextWord;
				}
				else if (Ch == "~")
				{
					//** Then this will be an THESAURUS term
					//** One term using the AND operator will be built for each inflectional term provided.
					string SubstituteString = "FORMSOF (THESAURUS, " + Strings.ChrW(34) + "@" + Strings.ChrW(34) + ")";
					I++;
					var ReturnedDelimiter = "";
					tWord = getNextToken(SearchCriteria, ref I, ref ReturnedDelimiter);
					SubIn(ref SubstituteString, "@", tWord);
					tWord = SubstituteString;
					SubIn(ref tWord, (string) (Strings.ChrW(34) + Strings.ChrW(34)), Strings.ChrW(34));
					//If A.Count > 1 Then
					//    A.Add("AND")
					//    OrNeeded = False
					//End If
					if (OrNeeded)
					{
						A.Add("Or");
					}
					if (dDeBug)
					{
						Console.WriteLine(I.ToString() + ":" + SearchCriteria.Substring(I - 1, 1));
					}
					A.Add(tWord);
					OrNeeded = true;
					tWord = "";
					goto StartNextWord;
				}
				else if (Ch == "#")
				{
					//** Then this will be an THESAURUS term
					//** One term using the AND operator will be built for each inflectional term provided.
					string SubstituteString = "FORMSOF (THESAURUS, " + Strings.ChrW(34) + "@" + Strings.ChrW(34) + ")";
					I++;
					var ReturnedDelimiter = "";
					tWord = getNextToken(SearchCriteria, ref I, ref ReturnedDelimiter);
					if (! ThesaurusWords.Contains(tWord))
					{
						ThesaurusWords.Add(tWord);
					}
					goto ProcessImmediately;
				}
				else if (Ch == " " || Ch == ",")
				{
					I++;
					Ch = SearchCriteria.Substring(I - 1, 1);
					if (isSyntaxChar(Ch))
					{
						goto TokenAlreadyAcquired;
					}
					while (Ch == " " && I < SearchCriteria.Length)
					{
						Ch = SearchCriteria.Substring(I - 1, 1);
						I++;
					}
					if (isSyntaxChar(Ch))
					{
						I--;
						goto TokenAlreadyAcquired;
					}
					isOr = true;
					tWord = getTheRestOfTheToken(SearchCriteria, ref I);
					if (dDeBug)
					{
						Console.WriteLine(tWord);
					}
					A.Add(tWord);
					bool BB = false;
					BB = isKeyWord(tWord);
					
					
					if (BB == true)
					{
						OrNeeded = false;
					}
					else
					{
						OrNeeded = true;
					}
					tWord = "";
					I--;
				}
				else
				{
					var ReturnedDelimiter = "";
					tWord = getNextToken(SearchCriteria, ref I, ref ReturnedDelimiter);
					if (dDeBug)
					{
						Console.WriteLine(tWord);
					}
					A.Add(tWord);
					if (tWord.ToUpper().Equals("OR"))
					{
						OrNeeded = false;
					}
					else if (tWord.ToUpper().Equals("AND"))
					{
						OrNeeded = false;
					}
					else if (tWord.ToUpper().Equals("NOT"))
					{
						OrNeeded = false;
					}
					else
					{
						OrNeeded = true;
					}
					
					
					tWord = "";
					I--;
				}
ProcessImmediately:
				
				
				if (dDeBug)
				{
					Console.WriteLine(I.ToString() + ":" + tWord);
				}
				if (dDeBug)
				{
					Console.WriteLine(SearchCriteria);
				}
				tWord = "";
				//isOr = True
				for (int II = 0; II <= A.Count - 1; II++)
				{
					if (A(II) == null)
					{
						if (dDeBug)
						{
							Console.WriteLine(II.ToString() + ":Nothing");
						}
					}
					else
					{
						if (dDeBug)
						{
							Console.WriteLine(II.ToString() + ":" + A(II).ToString());
						}
					}
				}
NextWord:
				1.GetHashCode() ; //VBConversions note: C# requires an executable line here, so a dummy line was added.
			}
			
			int XX = System.Convert.ToInt32(A.Count);
			for (XX = A.Count() - 1; XX >= 0; XX--)
			{
				tWord = (string) (A(XX).Trim);
				if (this.isKeyWord(tWord))
				{
					A.RemoveAt(XX);
				}
				else
				{
					break;
				}
			}
			var Stmt = "";
			for (I = 0; I <= A.Count - 1; I++)
			{
				if (I == A.Count - 1)
				{
					tWord = (string) (A(I).Trim);
					if (this.isKeyWord(tWord))
					{
						if (dDeBug)
						{
							Console.WriteLine("Do nothing");
						}
					}
					else
					{
						Stmt = Stmt + " " + A(I);
						if (dDeBug)
						{
							Console.WriteLine(I.ToString() + ": " + Stmt);
						}
					}
				}
				else
				{
					Stmt = Stmt + " " + A(I);
					if (dDeBug)
					{
						Console.WriteLine(I.ToString() + ": " + Stmt);
					}
				}
				
			}
			return Stmt;
			
			
		}
		
		public void getThesaurusWords(List<string> ThesaurusList, List<string> ThesaurusWords)
		{
			gettingThesaurusWords = true;
			var AllWords = "";
			string ThesaurusName = "";
			
			if (modGlobals.gThesauri.Count == 1)
			{
				for (int kk = 0; kk <= modGlobals.gThesauri.Count - 1; kk++)
				{
					ThesaurusName = gThesauri(kk).ToString();
					ThesaurusList.Add(ThesaurusName);
				}
				//'FrmMDIMain.SB.Text = "Custom thesauri used"
			}
			else if (modGlobals.gThesauri.Count > 0)
			{
				for (int kk = 0; kk <= modGlobals.gThesauri.Count - 1; kk++)
				{
					ThesaurusName = gThesauri(kk).ToString();
					ThesaurusList.Add(ThesaurusName);
				}
				//'FrmMDIMain.SB.Text = "Custom thesauri used"
			}
			
			if (ThesaurusList.Count == 0)
			{
				//** Get and use the default Thesaurus'
				if (modGlobals.gClipBoardActive)
				{
					Console.WriteLine("No thesauri specified - using default.");
				}
				//** System parms MUST b loaded at startup time - we need a "Startup" splash screen that can be used for rebranding and loading all the intialization parameters.
				//ThesaurusName = DB.getSystemParm("Default Thesaurus")
				//If ThesaurusName.Equals("NA") Then
				//Return ""
				//Else
				//  ThesaurusList.Add(ThesaurusName)
				//End If
				ThesaurusList.Add("Roget");
			}
			
			//** Get and use the default Thesaurus
			foreach (string T in ThesaurusList)
			{
				ThesaurusName = T;
				
				GLOBALS.ProxySearch.getThesaurusIDCompleted += new System.EventHandler(client_getThesaurusID);
				//EP.setSearchSvcEndPoint(proxy)
				GLOBALS.ProxySearch.getThesaurusIDAsync(SecureID, ThesaurusName);
			}
			
			
		}
		
		public void client_getThesaurusID(object sender, SVCSearch.getThesaurusIDCompletedEventArgs e)
		{
			
			ExpandedWords.Clear();
			
			if (e.Error == null)
			{
				string ThesaurusID = (string) e.Result;
				foreach (string token in ThesaurusWords)
				{
					if (! ExpandedWords.Contains(token))
					{
						ExpandedWords.Add(token);
					}
					//Dim proxy As New SVCSearch.Service1Client
					string[] lExpandedWords = ExpandedWords.ToArray;
					GLOBALS.ProxySearch.getSynonymsAsync(SecureID, ThesaurusID, token, lExpandedWords);
				}
				
			}
			else
			{
				modGlobals.gErrorCount++;
				LOG.WriteToSqlLog((string) ("ERROR clsSql- client_getThesaurusID 100: " + e.Error.Message));
			}
			GLOBALS.ProxySearch.getThesaurusIDCompleted -= new System.EventHandler(client_getThesaurusID);
		}
		
		public void client_getSynonyms(object sender, SVCSearch.getSynonymsCompletedEventArgs e)
		{
			string[] words = null;
			string s = "";
			ExpandedWords.Clear();
			if (e.Error == null)
			{
				//ExpandedWords = e.lbSynonyms
				s = (string) e.Result;
				words = s.Split(",".ToCharArray());
				foreach (string SS in words)
				{
					string tWord = SS;
					ExpandedWords.Add(s);
					tWord = tWord.Trim();
					if (tWord.IndexOf((Strings.ChrW(34)).ToString()) + 1 == 0)
					{
						tWord = (string) (Strings.ChrW(34) + tWord + Strings.ChrW(34));
					}
					ListOfPhrases = ListOfPhrases + Strings.ChrW(9) + tWord + " or " + "\r\n";
				}
				if (ListOfPhrases == null)
				{
					
				}
				else
				{
					ListOfPhrases = ListOfPhrases.Trim();
					ListOfPhrases = ListOfPhrases.Substring(0, ListOfPhrases.Length - 3);
				}
				gettingThesaurusWords = false;
			}
			else
			{
				LOG.WriteToSqlLog((string) ("ERROR client_getSynonyms 100: " + e.Error.Message));
				ExpandedWords.Clear();
			}
		}
		public bool ValidateContainsList(ref string ContainsList)
		{
			ContainsList = ContainsList.Trim();
			if (ContainsList.Trim().Length == 0)
			{
				return false;
			}
			if (isKeyWord(ContainsList))
			{
				return false;
			}
			bool b = true;
			if (ContainsList.IndexOf("body, \' \')") + 1 > 0)
			{
				//** It is a null where clause in effect
				ContainsList = "";
				b = false;
			}
			if (ContainsList.IndexOf("body, \' or") + 1 > 0)
			{
				//** It is a null where clause in effect
				ContainsList = "";
				b = false;
			}
			if (ContainsList.IndexOf("body, \' and") + 1 > 0)
			{
				//** It is a null where clause in effect
				ContainsList = "";
				b = false;
			}
			return b;
		}
		public string PopulateThesaurusList(List<string> ThesaurusList, ref List<string> ThesaurusWords, string txtThesaurus, string cbThesaurusText)
		{
			
			object[] A1 = new object[1];
			object[] A2 = new object[1];
			var Token = "";
			var ExpandedWords = "";
			
			if (txtThesaurus.IndexOf(",") + 1 > 0)
			{
				A1 = txtThesaurus.Split(",".ToCharArray());
			}
			else
			{
				A1[0] = txtThesaurus;
			}
			
			for (int i = 0; i <= (A1.Length - 1); i++)
			{
				Token = (string) (A1[i].Trim);
				if (Token.IndexOf((Strings.ChrW(34)).ToString()) + 1 > 0)
				{
					ThesaurusWords.Add(Token);
				}
				else
				{
					A2 = Token.Split(" ".ToCharArray());
					for (int ii = 0; ii <= (A2.Length - 1); ii++)
					{
						ThesaurusWords.Add(A2[ii].Trim);
					}
				}
				
			}
			
			getThesaurusWords(ThesaurusList, ThesaurusWords);
			
			return ExpandedWords;
			
		}
		public string genContainsClause(string InputSearchString, bool useFreetext, bool ckWeighted, bool isEmail, bool LimitToCurrRecs, List<string> ThesaurusList, string txtThesaurus, string cbThesaurusText, string calledBy)
		{
			
			var WhereClause = "";
			string S = "";
			//Dim ThesaurusList As New list(of string)
			List<string> ThesaurusWords = new List<string>();
			var ContainsClause = "";
			bool isValidContainsClause = false;
			int lParens = 0;
			int rParens = 0;
			
			if (InputSearchString.Length == 0)
			{
				//** NO Search criteria was specified send back something that will return everything
				if (calledBy.Equals("EMAIL"))
				{
					WhereClause = " UserID is not null ";
				}
				else
				{
					WhereClause = " DataSourceOwnerUserID is not null ";
				}
				return WhereClause;
			}
			
			if (ckWeighted)
			{
				
				if (InputSearchString.Length == 0)
				{
					if (modGlobals.gIsAdmin || modGlobals.gIsGlobalSearcher)
					{
						ContainsClause = " DataSourceOwnerUserID is not null ";
					}
					else
					{
						ContainsClause = " DataSourceOwnerUserID = \'" + modGlobals.gCurrUserGuidID + "\' ";
					}
					
				}
				else
				{
					ContainsClause = buildContainsSyntax(InputSearchString, ThesaurusWords);
				}
				
				
				isValidContainsClause = ValidateContainsList(ref ContainsClause);
				
				if (isEmail)
				{
					if (useFreetext == true)
					{
						//** This is FREETEXT searching, remove noise words
						UTIL.RemoveFreetextStopWords(ref InputSearchString);
						if (InputSearchString.Length > 0 || txtThesaurus.Trim().Length > 0)
						{
							if (isValidContainsClause)
							{
								//(Body, Description, KeyWords, Subject, Attachment, Ocrtext)
								WhereClause += " ( FREETEXT ((Body, SUBJECT, KeyWords, Description), \'";
								S = InputSearchString;
								WhereClause += buildContainsSyntax(S, ThesaurusWords);
								WhereClause += "\') ";
								rParens++;
							}
							
							if (txtThesaurus.Trim().Length > 0)
							{
								string ExpandedWordList = PopulateThesaurusList(ThesaurusList, ref ThesaurusWords, txtThesaurus, cbThesaurusText);
								if (ExpandedWordList.Trim().Length > 0)
								{
									WhereClause += (string) ("\r\n" + Strings.ChrW(9) + cbThesaurusText + " FREETEXT ((Body, SUBJECT, KeyWords, Description), \'" + ExpandedWordList);
									WhereClause += "\')" + "\r\n" + "/* 0A1 */ " + "\r\n";
									rParens++;
								}
							}
							
							//** 5/29/2008 by WDM now, get the SUBJECT searched too.
							if (isValidContainsClause)
							{
								WhereClause += " or FREETEXT ((Body, SUBJECT, KeyWords, Description), \'";
								S = InputSearchString;
								WhereClause += buildContainsSyntax(S, ThesaurusWords);
								WhereClause += "\') " + "\r\n" + " /* 00 */ " + "\r\n";
								rParens++;
							}
							
							if (txtThesaurus.Trim().Length > 0)
							{
								string ExpandedWordList = PopulateThesaurusList(ThesaurusList, ref ThesaurusWords, txtThesaurus, cbThesaurusText);
								if (ExpandedWordList.Trim().Length > 0)
								{
									WhereClause += (string) ("\r\n" + Strings.ChrW(9) + " OR FREETEXT ((Body, SUBJECT, KeyWords, Description), \'" + ExpandedWordList);
									WhereClause += "\') ";
									rParens++;
								}
							}
							WhereClause += ")" + "\r\n" + "  /* #2 */" + "\r\n";
						}
					}
					else
					{
						//Processing a weighted set of documents
						lParens = 0;
						if (InputSearchString.Length > 0 || txtThesaurus.Trim().Length > 0)
						{
							WhereClause += " ( CONTAINS(BODY, \'";
							S = InputSearchString;
							WhereClause += buildContainsSyntax(S, ThesaurusWords);
							WhereClause += "\')   /*YY00a*/ " + "\r\n";
							
							lParens++;
							
							if (txtThesaurus.Trim().Length > 0)
							{
								string ExpandedWordList = PopulateThesaurusList(ThesaurusList, ref ThesaurusWords, txtThesaurus, cbThesaurusText);
								if (ExpandedWordList.Trim().Length > 0)
								{
									WhereClause = WhereClause + "\r\n";
									WhereClause += (string) ("\r\n" + Strings.ChrW(9) + cbThesaurusText + " (CONTAINS (body, \'" + ExpandedWordList);
									WhereClause += "\')   /*YY00*/" + "\r\n";
									lParens++;
								}
							}
							
							WhereClause += " or CONTAINS(SUBJECT, \'";
							S = InputSearchString;
							WhereClause += buildContainsSyntax(S, ThesaurusWords);
							WhereClause += "\')   /*XX01*/" + "\r\n";
							
							if (txtThesaurus.Trim().Length > 0)
							{
								getThesaurusWords(ThesaurusList, ThesaurusWords);
								string ExpandedThesaurusWords = "";
								for (int IX = 0; IX <= ThesaurusList.Count - 1; IX++)
								{
									ExpandedThesaurusWords += (string) (ThesaurusList.Item(IX) + " ");
								}
								
								string ExpandedWordList = PopulateThesaurusList(ThesaurusList, ref ThesaurusWords, txtThesaurus, cbThesaurusText);
								if (ExpandedWordList.Trim().Length > 0)
								{
									WhereClause = WhereClause + "\r\n";
									WhereClause += (string) ("\r\n" + Strings.ChrW(9) + cbThesaurusText + " (CONTAINS (subject, \'" + ExpandedThesaurusWords);
									WhereClause += "\')   /*YY01*/" + "\r\n";
									lParens++;
								}
							}
							if (lParens == 1)
							{
								WhereClause += ")     /*XX02a*/" + "\r\n";
							}
							else if (lParens == 2)
							{
								WhereClause += "))     /*XX02b*/" + "\r\n";
							}
							else if (lParens == 3)
							{
								WhereClause += ")))     /*XX02c*/" + "\r\n";
							}
						}
					}
				}
				else
				{
					//** Processing documents, not emails
					if (useFreetext == true)
					{
						if (InputSearchString.Length > 0 || txtThesaurus.Trim().Length > 0)
						{
							Console.WriteLine("FIX THIS NOW - 200.22a");
							//DB.RemoveFreetextStopWords(InputSearchString  )
							//DB.RemoveFreetextStopWords(txtThesaurus  )
							//WhereClause += " FREETEXT (SourceImage, '"
							//WhereClause += " FREETEXT (DataSource.*, '"
							WhereClause += " FREETEXT ((Description, KeyWords, Notes, SourceImage, SourceName), \'";
							S = InputSearchString;
							WhereClause += buildContainsSyntax(S, ThesaurusWords);
							WhereClause += "\')";
							
							if (txtThesaurus.Trim().Length > 0)
							{
								string ExpandedWordList = PopulateThesaurusList(ThesaurusList, ref ThesaurusWords, txtThesaurus, cbThesaurusText);
								if (ExpandedWordList.Trim().Length > 0)
								{
									//WhereClause += vbCrLf + ChrW(9) + cbThesaurusText + " freetext (SourceImage, '" + ExpandedWordList
									//WhereClause += vbCrLf + ChrW(9) + cbThesaurusText + " freetext (DataSource.*, '" + ExpandedWordList
									WhereClause += (string) ("\r\n" + Strings.ChrW(9) + cbThesaurusText + " freetext ((Description, KeyWords, Notes, SourceImage, SourceName), \'" + ExpandedWordList);
									WhereClause += "\')" + "\r\n" + "/* 0A2 */ " + "\r\n";
									rParens++;
								}
							}
						}
					}
					else
					{
						if (InputSearchString.Length > 0 || txtThesaurus.Trim().Length > 0)
						{
							WhereClause += " (CONTAINS(SourceImage, \'";
							S = InputSearchString;
							WhereClause += buildContainsSyntax(S, ThesaurusWords);
							WhereClause += "\'))     /*XX03*/ ";
							
							if (txtThesaurus.Trim().Length > 0)
							{
								string ExpandedWordList = PopulateThesaurusList(ThesaurusList, ref ThesaurusWords, txtThesaurus, cbThesaurusText);
								if (ExpandedWordList.Trim().Length > 0)
								{
									WhereClause += (string) ("\r\n" + Strings.ChrW(9) + cbThesaurusText + " CONTAINS (SourceImage, \'" + ExpandedWordList);
									WhereClause += "\')" + "\r\n" + "/* 0A3 */ " + "\r\n";
									rParens++;
								}
							}
						}
					}
				}
			}
			else
			{
				//** No weightings used in this query
				if (InputSearchString.Length == 0)
				{
					if (modGlobals.gIsAdmin || modGlobals.gIsGlobalSearcher == true)
					{
						ContainsClause = " DataSourceOwnerUserID is not null ";
					}
					else
					{
						ContainsClause = " DataSourceOwnerUserID = \'" + modGlobals.gCurrUserGuidID + "\' ";
					}
				}
				else if (useFreetext == true)
				{
					if (InputSearchString.Length > 0 || txtThesaurus.Trim().Length > 0)
					{
						
						//DB.RemoveFreetextStopWords(InputSearchString  )
						//DB.RemoveFreetextStopWords(txtThesaurus  )
						Console.WriteLine("FIX THIS 100.100.22");
						
						WhereClause += " FREETEXT ((Body, SUBJECT, KeyWords, Description), \'";
						S = InputSearchString;
						WhereClause += buildContainsSyntax(S, ThesaurusWords);
						WhereClause += "\')" + "\r\n";
						
						if (txtThesaurus.Trim().Length > 0)
						{
							string ExpandedWordList = PopulateThesaurusList(ThesaurusList, ref ThesaurusWords, txtThesaurus, cbThesaurusText);
							if (ExpandedWordList.Trim().Length > 0)
							{
								WhereClause += (string) ("\r\n" + Strings.ChrW(9) + cbThesaurusText + " FREETEXT ((Body, SUBJECT, KeyWords, Description), \'" + ExpandedWordList);
								WhereClause += "\')" + "\r\n" + "/* 0A4 */ " + "\r\n";
								rParens++;
							}
						}
						//WhereClause += ")  /* XX  Final Quotes */"
					}
				}
				else
				{
					if (InputSearchString.Length > 0 || txtThesaurus.Trim().Length > 0)
					{
						WhereClause += " CONTAINS(EMAIL.*, \'";
						S = InputSearchString;
						WhereClause += buildContainsSyntax(S, ThesaurusWords);
						WhereClause += "\')     /*XX04*/ ";
						
						if (txtThesaurus.Trim().Length > 0)
						{
							string ExpandedWordList = PopulateThesaurusList(ThesaurusList, ref ThesaurusWords, txtThesaurus, cbThesaurusText);
							if (ExpandedWordList.Trim().Length > 0)
							{
								WhereClause += (string) ("\r\n" + Strings.ChrW(9) + cbThesaurusText + " CONTAINS (*, \'" + ExpandedWordList);
								WhereClause += "\')" + "\r\n" + "/* 0A5 */ " + "\r\n";
								rParens++;
							}
						}
						//WhereClause += ")" + vbCrLf + "/* 9A */ " + vbCrLf
					}
				}
			}
			ThesaurusList = null;
			ThesaurusWords = null;
			return WhereClause;
		}
		public string getNextChar(string S, int i)
		{
			var CH = "";
			
			
			if (S.Trim().Length > (i + 1))
			{
				i++;
				CH = S.Substring(i - 1, 1);
			}
			
			
			while (CH == " " && i <= S.Length)
			{
				i++;
				if (S.Trim().Length < (i + 1))
				{
					CH = S.Substring(i - 1, 1);
				}
			}
			
			
			return CH;
		}
		public string CleanIsAboutSearchText(string SearchText)
		{
			int I = 0;
			List<string> A = new List<string>();
			string CH = "";
			var Token = "";
			string S = "";
			bool SkipNextToken = false;
			for (I = 1; I <= SearchText.Trim().Length; I++)
			{
REEVAL:
				CH = SearchText.Substring(I - 1, 1);
				if (CH.Equals(Strings.ChrW(34)))
				{
					//** Get the token in quotes
					bool PreceedingPlusSign = false;
					bool PreceedingMinusSign = false;
					if (Token.Equals("+") || Token.Equals("-"))
					{
						PreceedingPlusSign = true;
						Token = "";
					}
					else if (Token.Equals("+") || Token.Equals("-"))
					{
						PreceedingMinusSign = true;
						Token = "";
					}
					else
					{
						if (Token.Length > 0)
						{
							A.Add(Token);
						}
						Token = "";
					}
					
					
					//** go to the next one
					I++;
					CH = SearchText.Substring(I - 1, 1);
					Token += CH;
					while (CH != Strings.ChrW(34) && I <= SearchText.Length)
					{
						I++;
						CH = SearchText.Substring(I - 1, 1);
						Token += CH;
					}
					//Token = ChrW(34) + Token
					if (PreceedingPlusSign == true)
					{
						Token = (string) ("+" + Strings.ChrW(34) + Token);
						//Dim NextChar$ = getNextChar(SearchText, I)
						//If NextChar$ = "-" Then
						//    '** We skip the next token in the stmt
						//End If
					}
					else if (PreceedingMinusSign == true)
					{
						Token = (string) ("-" + Strings.ChrW(34) + Token);
						//Dim NextChar$ = getNextChar(SearchText, I)
						//If NextChar$ = "+" Then
						//    '** We skip the next token in the stmt
						//End If
					}
					else
					{
						Token = (string) (Strings.ChrW(34) + Token);
					}
					A.Add(Token);
					
					
					Token = "";
				}
				else if (CH.Equals(" ") || CH == " ")
				{
					//** Skip the blank spaces
					if (Token.Equals("+") || Token.Equals("-"))
					{
						LOG.WriteToSqlLog("Should not be here.");
					}
					else
					{
						if (Token.Length > 0)
						{
							A.Add(Token);
						}
						Token = "";
					}
					
					
					//** go to the next one
					I++;
					CH = SearchText.Substring(I - 1, 1);
					while (CH == " " && I <= SearchText.Length)
					{
						I++;
						CH = SearchText.Substring(I - 1, 1);
					}
					goto REEVAL;
				}
				else if (CH.Equals(","))
				{
					//** Skip the blank spaces
					if (Token.Length > 0)
					{
						A.Add(Token);
					}
					Token = "";
				}
				else if (CH.Equals("+"))
				{
					//** Skip the blank spaces
					var NextChar = getNextChar(SearchText, I);
					if (NextChar == "-")
					{
						//** We skip the next token in the stmt
						SkipNextToken = true;
						A.Add("~");
					}
					Token += "";
				}
				else if (CH.Equals("^"))
				{
					//** Skip the blank spaces
					Token += "";
				}
				else if (CH.Equals("~"))
				{
					//** Skip the blank spaces
					Token += "";
				}
				else if (CH.Equals("(") || CH.Equals(")"))
				{
					//** Skip the blank spaces
					Token += "";
				}
				else if (CH.Equals("-"))
				{
					//** Skip the blank spaces
					var NextChar = getNextChar(SearchText, I);
					if (NextChar == "+")
					{
						//** We skip the next token in the stmt
						SkipNextToken = true;
						A.Add("~");
					}
					Token += "";
				}
				else if (CH.Equals("|"))
				{
					//** Skip the blank spaces
					Token += "";
				}
				else
				{
					Token += CH;
				}
			}
			if (Token.Length > 0)
			{
				A.Add(Token);
			}
			S = "";
			bool skipNextWord = false;
			for (I = 0; I <= A.Count - 1; I++)
			{
				var tWord = A(I);
				tWord = Strings.UCase(tWord);
				if (tWord.Equals("~"))
				{
					//** we skip the next word period
					skipNextWord = true;
				}
				else if (tWord.Equals("AND"))
				{
				}
				else if (tWord.Equals("OR"))
				{
				}
				else if (tWord.Equals("NOT"))
				{
					skipNextWord = true;
				}
				else if (tWord.Equals("NEAR"))
				{
				}
				else
				{
					if (skipNextWord)
					{
						skipNextWord = false;
					}
					else
					{
						if (I == A.Count - 1)
						{
							S = S + A(I).ToString();
						}
						else
						{
							S = S + A(I).ToString() + ", ";
						}
						if (dDeBug)
						{
							LOG.WriteToSqlLog(S);
						}
					}
					
					
				}
			}
			
			
			return S;
			
			
		}
		
		public string genIsAbout(bool ckWeighted, bool useFreetext, string SearchText, bool isEmailSearch)
		{
			if (ckWeighted == false)
			{
				return "";
			}
			var isAboutClause = "";
			var SearchStr = SearchText;
			string CorrectedSearchClause = CleanIsAboutSearchText(SearchText);
			CorrectedSearchClause = CorrectedSearchClause.Trim();
			if (CorrectedSearchClause.Length > 2)
			{
				var C = CorrectedSearchClause.Substring(CorrectedSearchClause.Length - 1, 1);
				if (C.Equals(","))
				{
					CorrectedSearchClause = CorrectedSearchClause.Substring(0, CorrectedSearchClause.Length - 1);
					CorrectedSearchClause = CorrectedSearchClause.Trim();
				}
			}
			if (isEmailSearch == true)
			{
				if (useFreetext == true)
				{
					//INNER JOIN FREETEXTTABLE(dataSource, *,
					//    'ISABOUT ("dale miller", "susan miller", jessica )' ) AS KEY_TBL
					//    ON DS.SourceGuid = KEY_TBL.[KEY]
					isAboutClause += "INNER JOIN FREETEXTTABLE(EMAIL, *, " + "\r\n";
					isAboutClause += "     \'ISABOUT (";
					isAboutClause += CorrectedSearchClause;
					isAboutClause += ")\' ) as KEY_TBL" + "\r\n";
					isAboutClause += "          ON DS.EmailGuid = KEY_TBL.[KEY]" + "\r\n";
				}
				else
				{
					//    INNER JOIN CONTAINSTABLE(dataSource, *,
					//    'ISABOUT ("dale miller",
					//"susan miller", jessica )' ) AS KEY_TBL
					//    ON DS.SourceGuid = KEY_TBL.[KEY]
					isAboutClause += "INNER JOIN CONTAINSTABLE(EMAIL, *, " + "\r\n";
					isAboutClause += "     \'ISABOUT (";
					isAboutClause += CorrectedSearchClause;
					isAboutClause += ")\' ) as KEY_TBL" + "\r\n";
					isAboutClause += "          ON DS.EmailGuid = KEY_TBL.[KEY]" + "\r\n";
				}
			}
			else
			{
				if (useFreetext == true)
				{
					//INNER JOIN FREETEXTTABLE(dataSource, *,
					//    'ISABOUT ("dale miller", "susan miller", jessica )' ) AS KEY_TBL
					//    ON DS.SourceGuid = KEY_TBL.[KEY]
					isAboutClause += "INNER JOIN FREETEXTTABLE(dataSource, SourceImage, " + "\r\n";
					isAboutClause += "     \'ISABOUT (";
					isAboutClause += CorrectedSearchClause;
					isAboutClause += ")\' ) as KEY_TBL" + "\r\n";
					isAboutClause += "          ON DS.SourceGuid = KEY_TBL.[KEY]" + "\r\n";
				}
				else
				{
					//    INNER JOIN CONTAINSTABLE(dataSource, *,
					//    'ISABOUT ("dale miller",
					//"susan miller", jessica )' ) AS KEY_TBL
					//    ON DS.SourceGuid = KEY_TBL.[KEY]
					isAboutClause += "INNER JOIN CONTAINSTABLE(dataSource, *, " + "\r\n";
					isAboutClause += "     \'ISABOUT (";
					isAboutClause += CorrectedSearchClause;
					isAboutClause += ")\' ) as KEY_TBL" + "\r\n";
					isAboutClause += "          ON DS.SourceGuid = KEY_TBL.[KEY]" + "\r\n";
				}
			}
			
			
			return isAboutClause;
			
			
		}
		public string getAllTablesSql()
		{
			string S = "Select * from sysobjects where xtype = \'U\'";
			return S;
		}
		//Public Function getAllColsSql(ByVal TblID as string) As SqlDataReader
		//    Dim S as string = "Select C.name, C.column_id, "
		//    s = s + " C.system_type_id , C.max_length, "
		//    s = s + " C.precision, C.scale, C.is_nullable,"
		//    s = s + " C.is_identity, T.name  "
		//    s = s + " from sys.objects T,  sys.columns C"
		//    s = s + " where T.type = 'U' and"
		//    s = s + " C.object_id = T.object_id and"
		//    s = s + " T.object_id = " + TblID$ + " "
		//    s = s + " order by C.column_id"
		
		
		//    Dim rsData As SqlDataReader = Nothing
		
		
		//    Try
		//        Dim CS$ = DB.getConnStr() : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader()
		//    Catch ex As Exception
		//        LOG.WriteToSqlLog("clsSql : getAllColsSql : 677 : " + ex.Message)
		//    End Try
		//    Return rsData
		//End Function
		public string genAdminContentSql(bool isAdmin, bool ckLimitToLib, string LibraryName)
		{
			var UserSql = "";
			LibraryName = UTIL.RemoveSingleQuotes(LibraryName);
			if (modGlobals.gIsAdmin || modGlobals.gIsGlobalSearcher == true)
			{
				//** ECM WhereClause
				if (ckLimitToLib == true)
				{
					//UserSql = UserSql + " AND SourceGuid in (SELECT [SourceGuid] FROM [LibraryItems] where LibraryName = '" + LibraryName$ + "')" + vbCrLf
					//** DO NOT PUT vbcrlf at the end of the below lines. That will cause problems in inserting PAGING.
					UserSql = UserSql + " AND SourceGuid in (" + GEN.genLibrarySearch(modGlobals.gCurrUserGuidID, true, LibraryName, "Gen@13") + ")";
				}
				else
				{
					if (modGlobals.gMyContentOnly == true)
					{
						UserSql = UserSql + " and ( DataSourceOwnerUserID = \'" + modGlobals.gCurrUserGuidID + "\') " + "\r\n";
					}
					else
					{
						bool gSearcher = false;
						if (modGlobals.gIsAdmin || modGlobals.gIsGlobalSearcher)
						{
							gSearcher = true;
						}
						string IncludeLibsSql = GEN.genLibrarySearch(modGlobals.gCurrUserGuidID, true, gSearcher, "@Gen31");
						UserSql = UserSql + IncludeLibsSql;
					}
					if (modGlobals.gMasterContentOnly == true)
					{
						UserSql = UserSql + " and ( isMaster = \'Y\' )       /*KEEP*/" + "\r\n";
					}
				}
				
				//'** Removed by WDM 7/12/2008
				//UserSql = UserSql + " OR" + vbCrLf
				//UserSql = UserSql + " DataSourceOwnerUserID in (select distinct UserID from LibraryUsers " + vbCrLf
				//UserSql = UserSql + "             where(LibraryName)" + vbCrLf
				//UserSql = UserSql + " in (Select LibraryName from LibrariesContainingUser))" + vbCrLf
				//UserSql = UserSql + " )" + vbCrLf
			}
			else
			{
				if (ckLimitToLib == true)
				{
					bool gSearcher = false;
					if (modGlobals.gIsAdmin == true || modGlobals.gIsGlobalSearcher == true)
					{
						gSearcher = true;
					}
					UserSql = " AND SourceGuid in (" + GEN.genLibrarySearch(modGlobals.gCurrUserGuidID, gSearcher, LibraryName, "Gen@01") + ")";
					
				}
				else
				{
					//UserSql = UserSql + " and ( DataSourceOwnerUserID is not null OR isPublic = 'Y' )" + vbCrLf
					//** ECM WhereClause
					if (modGlobals.gMyContentOnly == true)
					{
						UserSql = UserSql + " and ( DataSourceOwnerUserID = \'" + modGlobals.gCurrUserGuidID + "\') " + "\r\n";
					}
					else
					{
						bool gSearcher = false;
						if (modGlobals.gIsAdmin == true || modGlobals.gIsGlobalSearcher == true)
						{
							gSearcher = true;
						}
						string IncludeLibsSql = GEN.genLibrarySearch(modGlobals.gCurrUserGuidID, true, gSearcher, "@Gen32");
						UserSql = UserSql + IncludeLibsSql;
					}
					
					if (modGlobals.gMasterContentOnly == true)
					{
						UserSql = UserSql + " and ( isMaster = \'Y\' )      /*KEEP*/" + "\r\n";
					}
					
				}
				
				//UserSql = UserSql + " OR isPublic = 'Y' " + vbCrLf    '** WDM Add 7/9/2009
				//** Removed by WDM 7/12/2008
				//UserSql = UserSql + " OR DataSourceOwnerUserID in (select distinct UserID from LibraryUsers " + vbCrLf
				//UserSql = UserSql + "             where(LibraryName)" + vbCrLf
				//UserSql = UserSql + " in (Select LibraryName from LibrariesContainingUser))" + vbCrLf
				//UserSql = UserSql + " )" + vbCrLf
			}
			return UserSql;
		}
		public string genAdminEmailSql(bool isAdmin, bool ckLimitToLib, string LibraryName)
		{
			var UserSql = "";
			if (modGlobals.gIsAdmin || modGlobals.gIsGlobalSearcher)
			{
				//** ECM WhereClause
				if (ckLimitToLib == true)
				{
					//** DO NOT PUT vbcrlf at the end of the below lines. That will cause problems in inserting PAGING.
					bool gSearcher = false;
					if (modGlobals.gIsAdmin == true || modGlobals.gIsGlobalSearcher == true)
					{
						gSearcher = true;
					}
					UserSql = UserSql + " AND EmailGuid in (" + GEN.genLibrarySearch(modGlobals.gCurrUserGuidID, gSearcher, LibraryName, "Gen@10") + ")";
					
				}
				else
				{
					if (modGlobals.gMyContentOnly == true)
					{
						UserSql = UserSql + " and ( UserID = \'" + modGlobals.gCurrUserGuidID + "\') " + "\r\n";
					}
					else
					{
						bool gSearcher = false;
						if (modGlobals.gIsAdmin == true || modGlobals.gIsGlobalSearcher == true)
						{
							gSearcher = true;
						}
						string IncludeLibsSql = GEN.genLibrarySearch(modGlobals.gCurrUserGuidID, false, gSearcher, "@Gen34");
						UserSql = UserSql + IncludeLibsSql;
					}
					if (modGlobals.gMasterContentOnly == true)
					{
						UserSql = UserSql + " and ( isMaster = \'Y\' )     /*KEEP*/" + "\r\n";
					}
				}
				//UserSql = UserSql + " OR" + vbCrLf
				//'UserSql = UserSql + " UserID in (select distinct UserID from LibraryUsers " + vbCrLf
				//** Removed by WDM 7/12/2008
				//UserSql = UserSql + " '" + gCurrUserGuidID + "' in (select distinct UserID from LibraryUsers " + vbCrLf
				//UserSql = UserSql + "             where(LibraryName)" + vbCrLf
				//UserSql = UserSql + " in (Select LibraryName from LibrariesContainingUser))" + vbCrLf
				//UserSql = UserSql + " )" + vbCrLf
			}
			else
			{
				if (ckLimitToLib == true)
				{
					bool gSearcher = false;
					if (modGlobals.gIsAdmin == true || modGlobals.gIsGlobalSearcher == true)
					{
						gSearcher = true;
					}
					UserSql = UserSql + " AND EmailGuid in (" + GEN.genLibrarySearch(modGlobals.gCurrUserGuidID, gSearcher, LibraryName, "Gen@11") + ")";
				}
				else
				{
					//** ECM WhereClause
					if (modGlobals.gMyContentOnly == true)
					{
						UserSql = UserSql + " and ( UserID = \'" + modGlobals.gCurrUserGuidID + "\') " + "\r\n";
					}
					else
					{
						bool gSearcher = false;
						if (modGlobals.gIsAdmin == true || modGlobals.gIsGlobalSearcher == true)
						{
							gSearcher = true;
						}
						string IncludeLibsSql = GEN.genLibrarySearch(modGlobals.gCurrUserGuidID, false, gSearcher, "@Gen30");
						UserSql = UserSql + IncludeLibsSql;
					}
					
					if (modGlobals.gMasterContentOnly == true)
					{
						UserSql = UserSql + " and ( isMaster = \'Y\' )      /*KEEP*/" + "\r\n";
					}
					
				}
				//'** Removed by WDM 7/12/2008
				//UserSql = UserSql + " OR isPublic = 'Y' " + vbCrLf
				//UserSql = UserSql + " OR '" + gCurrUserGuidID + "' in (select distinct UserID from LibraryUsers " + vbCrLf
				//UserSql = UserSql + "             where(LibraryName)" + vbCrLf
				//UserSql = UserSql + " in (Select LibraryName from LibrariesContainingUser))" + vbCrLf
				//UserSql = UserSql + " )" + vbCrLf
			}
			return UserSql;
		}
		public string getContentTblCols(bool ckWeighted)
		{
			var DocsSql = "";
			
			
			if (ckWeighted)
			{
				if (modGlobals.gMaxRecordsToFetch.Length > 0)
				{
					if (val[modGlobals.gMaxRecordsToFetch] > 0)
					{
						DocsSql = (string) (" SELECT TOP " + modGlobals.gMaxRecordsToFetch);
					}
					else
					{
						DocsSql = " SELECT ";
					}
				}
				DocsSql += "\t" + " KEY_TBL.RANK, DS.SourceName 	" + "\r\n";
				DocsSql += "\t" + ",DS.CreateDate " + "\r\n";
				DocsSql += "\t" + ",DS.VersionNbr 	" + "\r\n";
				DocsSql += "\t" + ",DS.LastAccessDate " + "\r\n";
				DocsSql += "\t" + ",DS.FileLength " + "\r\n";
				DocsSql += "\t" + ",DS.LastWriteTime " + "\r\n";
				DocsSql += "\t" + ",DS.OriginalFileType 		" + "\r\n";
				DocsSql += "\t" + ",DS.isPublic " + "\r\n";
				DocsSql += "\t" + ",DS.FQN " + "\r\n";
				DocsSql += "\t" + ",DS.SourceGuid " + "\r\n";
				DocsSql += "\t" + ",DS.DataSourceOwnerUserID, DS.FileDirectory, DS.RetentionExpirationDate, DS.isMaster, DS.StructuredData, DS.RepoSvrName " + "\r\n";
				DocsSql += "FROM DataSource as DS " + "\r\n";
				
				
			}
			else
			{
				if (modGlobals.gMaxRecordsToFetch.Length > 0)
				{
					if (val[modGlobals.gMaxRecordsToFetch] > 0)
					{
						DocsSql = (string) (" SELECT TOP " + modGlobals.gMaxRecordsToFetch);
					}
					else
					{
						DocsSql = " SELECT ";
					}
				}
				DocsSql += "\t" + "[SourceName] 	" + "\r\n";
				DocsSql += "\t" + ",[CreateDate] " + "\r\n";
				DocsSql += "\t" + ",[VersionNbr] 	" + "\r\n";
				DocsSql += "\t" + ",[LastAccessDate] " + "\r\n";
				DocsSql += "\t" + ",[FileLength] " + "\r\n";
				DocsSql += "\t" + ",[LastWriteTime] " + "\r\n";
				DocsSql += "\t" + ",[SourceTypeCode] 		" + "\r\n";
				DocsSql += "\t" + ",[isPublic] " + "\r\n";
				DocsSql += "\t" + ",[FQN] " + "\r\n";
				DocsSql += "\t" + ",[SourceGuid] " + "\r\n";
				DocsSql += "\t" + ",[DataSourceOwnerUserID], FileDirectory, StructuredData, RepoSvrName " + "\r\n";
				DocsSql += "FROM DataSource " + "\r\n";
			}
			
			
			return DocsSql;
		}
		
		
		public string getEmailTblColsMainSearch(bool ckWeighted, bool ckBusiness, string SearchText)
		{
			var GenSql = "";
			
			
			if (ckWeighted == true)
			{
				if (modGlobals.gMaxRecordsToFetch.Length > 0)
				{
					if (val[modGlobals.gMaxRecordsToFetch] > 0)
					{
						GenSql = (string) (" SELECT TOP " + modGlobals.gMaxRecordsToFetch);
					}
					else
					{
						GenSql = " SELECT ";
					}
				}
				GenSql = GenSql + "  KEY_TBL.RANK, DS.SentOn " + "\r\n";
				GenSql = GenSql + " ,DS.ShortSubj" + "\r\n";
				GenSql = GenSql + " ,DS.SenderEmailAddress" + "\r\n";
				GenSql = GenSql + " ,DS.SenderName" + "\r\n";
				GenSql = GenSql + " ,DS.SentTO" + "\r\n";
				GenSql = GenSql + " ,substring(DS.Body,1,100) as Body" + "\r\n";
				GenSql = GenSql + " ,DS.CC " + "\r\n";
				GenSql = GenSql + " ,DS.Bcc " + "\r\n";
				GenSql = GenSql + " ,DS.CreationTime" + "\r\n";
				GenSql = GenSql + " ,DS.AllRecipients" + "\r\n";
				GenSql = GenSql + " ,DS.ReceivedByName" + "\r\n";
				GenSql = GenSql + " ,DS.ReceivedTime " + "\r\n";
				GenSql = GenSql + " ,DS.MsgSize" + "\r\n";
				GenSql = GenSql + " ,DS.SUBJECT" + "\r\n";
				GenSql = GenSql + " ,DS.OriginalFolder " + "\r\n";
				GenSql = GenSql + " ,DS.EmailGuid, DS.RetentionExpirationDate, DS.isPublic, DS.ConvertEmlToMSG, DS.UserID, DS.NbrAttachments, DS.SourceTypeCode, \'N\' as FoundInAttachment, \' \' as RID, RepoSvrName  " + "\r\n";
				GenSql = GenSql + " FROM EMAIL AS DS " + "\r\n";
				GenSql += genIsAbout(ckWeighted, ckBusiness, SearchText, true);
			}
			else
			{
				if (modGlobals.gMaxRecordsToFetch.Length > 0)
				{
					if (val[modGlobals.gMaxRecordsToFetch] > 0)
					{
						GenSql = (string) (" SELECT TOP " + modGlobals.gMaxRecordsToFetch);
					}
					else
					{
						GenSql = " SELECT ";
					}
				}
				
				GenSql = GenSql + " [SentOn] " + "\r\n";
				GenSql = GenSql + " ,[ShortSubj]" + "\r\n";
				GenSql = GenSql + " ,[SenderEmailAddress]" + "\r\n";
				GenSql = GenSql + " ,[SenderName]" + "\r\n";
				GenSql = GenSql + " ,[SentTO]" + "\r\n";
				GenSql = GenSql + " ,substring(Body,1,100) as Body " + "\r\n";
				GenSql = GenSql + " ,[CC] " + "\r\n";
				GenSql = GenSql + " ,[Bcc] " + "\r\n";
				GenSql = GenSql + " ,[CreationTime]" + "\r\n";
				GenSql = GenSql + " ,[AllRecipients]" + "\r\n";
				GenSql = GenSql + " ,[ReceivedByName]" + "\r\n";
				GenSql = GenSql + " ,[ReceivedTime] " + "\r\n";
				GenSql = GenSql + " ,[MsgSize]" + "\r\n";
				GenSql = GenSql + " ,[SUBJECT]" + "\r\n";
				GenSql = GenSql + " ,[OriginalFolder] " + "\r\n";
				GenSql = GenSql + " ,[EmailGuid], RetentionExpirationDate, isPublic, ConvertEmlToMSG, UserID, NbrAttachments, SourceTypeCode, \'N\' as FoundInAttachment, \' \' as RID, RepoSvrName, 0 as RANK   " + "\r\n";
				GenSql = GenSql + " FROM EMAIL " + "\r\n";
			}
			
			GenSql = GenSql + " WHERE " + "\r\n";
			
			return GenSql;
		}
		public string getEmailTblCols(bool ckWeighted, bool ckBusiness, string SearchText)
		{
			var SearchSql = "";
			
			
			if (ckWeighted == true)
			{
				if (modGlobals.gMaxRecordsToFetch.Length > 0)
				{
					if (val[modGlobals.gMaxRecordsToFetch] > 0)
					{
						SearchSql = (string) (" SELECT TOP " + modGlobals.gMaxRecordsToFetch);
					}
					else
					{
						SearchSql = " SELECT ";
					}
				}
				SearchSql = SearchSql + "  KEY_TBL.RANK, DS.SentOn " + "\r\n";
				SearchSql = SearchSql + " ,DS.ShortSubj" + "\r\n";
				SearchSql = SearchSql + " ,DS.SenderEmailAddress" + "\r\n";
				SearchSql = SearchSql + " ,DS.SenderName" + "\r\n";
				SearchSql = SearchSql + " ,DS.SentTO" + "\r\n";
				SearchSql = SearchSql + " ,DS.Body " + "\r\n";
				SearchSql = SearchSql + " ,DS.CC " + "\r\n";
				SearchSql = SearchSql + " ,DS.Bcc " + "\r\n";
				SearchSql = SearchSql + " ,DS.CreationTime" + "\r\n";
				SearchSql = SearchSql + " ,DS.AllRecipients" + "\r\n";
				SearchSql = SearchSql + " ,DS.ReceivedByName" + "\r\n";
				SearchSql = SearchSql + " ,DS.ReceivedTime " + "\r\n";
				SearchSql = SearchSql + " ,DS.MsgSize" + "\r\n";
				SearchSql = SearchSql + " ,DS.SUBJECT" + "\r\n";
				SearchSql = SearchSql + " ,DS.OriginalFolder " + "\r\n";
				SearchSql = SearchSql + " ,DS.EmailGuid, DS.RetentionExpirationDate, DS.isPublic, DS.UserID, DS.SourceTypeCode, DS.NbrAttachments , \' \' as RID, RepoSvrName " + "\r\n";
				SearchSql = SearchSql + " FROM EMAIL AS DS " + "\r\n";
				SearchSql += genIsAbout(ckWeighted, ckBusiness, SearchText, true);
			}
			else
			{
				if (modGlobals.gMaxRecordsToFetch.Length > 0)
				{
					if (val[modGlobals.gMaxRecordsToFetch] > 0)
					{
						SearchSql = (string) (" SELECT TOP " + modGlobals.gMaxRecordsToFetch);
					}
					else
					{
						SearchSql = " SELECT ";
					}
				}
				SearchSql = SearchSql + " [SentOn] " + "\r\n";
				SearchSql = SearchSql + " ,[ShortSubj]" + "\r\n";
				SearchSql = SearchSql + " ,[SenderEmailAddress]" + "\r\n";
				SearchSql = SearchSql + " ,[SenderName]" + "\r\n";
				SearchSql = SearchSql + " ,[SentTO]" + "\r\n";
				SearchSql = SearchSql + " ,[Body] " + "\r\n";
				SearchSql = SearchSql + " ,[CC] " + "\r\n";
				SearchSql = SearchSql + " ,[Bcc] " + "\r\n";
				SearchSql = SearchSql + " ,[CreationTime]" + "\r\n";
				SearchSql = SearchSql + " ,[AllRecipients]" + "\r\n";
				SearchSql = SearchSql + " ,[ReceivedByName]" + "\r\n";
				SearchSql = SearchSql + " ,[ReceivedTime] " + "\r\n";
				SearchSql = SearchSql + " ,[MsgSize]" + "\r\n";
				SearchSql = SearchSql + " ,[SUBJECT]" + "\r\n";
				SearchSql = SearchSql + " ,[OriginalFolder] " + "\r\n";
				SearchSql = SearchSql + " ,[EmailGuid], RetentionExpirationDate, isPublic, UserID, SourceTypeCode, NbrAttachments, \' \' as RID, RepoSvrName, 0 as RANK " + "\r\n";
				SearchSql = SearchSql + " FROM EMAIL " + "\r\n";
			}
			return SearchSql;
		}
		public string xgenHeader()
		{
			var DocsSql = "WITH LibrariesContainingUser (LibraryName) AS" + "\r\n";
			DocsSql += " (" + "\r\n";
			DocsSql += "    select LibraryName from LibraryUsers L1 where userid = \'" + modGlobals.gCurrUserGuidID + "\' " + "\r\n";
			DocsSql += " )" + "\r\n";
			return DocsSql;
		}
		public string genContenCountSql()
		{
			var DocsSql = "Select count(*) " + "\r\n";
			DocsSql += "FROM DataSource " + "\r\n";
			return DocsSql;
		}
		public string genEmailCountSql()
		{
			var DocsSql = "Select count(*) " + "\r\n";
			DocsSql += "FROM [email] " + "\r\n";
			return DocsSql;
		}
		public string genUseExistingRecordsOnly(bool bUseExisting, string GuidColName)
		{
			if (bUseExisting == false)
			{
				return "";
			}
			var DocsSql = " and " + GuidColName + " in (SELECT [DocGuid] FROM ActiveSearchGuids where  UserID = \'" + modGlobals.gCurrUserGuidID + "\')" + "\r\n";
			return DocsSql;
		}
		public string genSelectEmailCounts(bool ckWeighted)
		{
			var SearchSql = "";
			if (ckWeighted == true)
			{
				SearchSql = SearchSql + " SELECT count(*) ";
				//SearchSql = SearchSql + "  KEY_TBL.RANK, DS.SentOn " + vbCrLf
				SearchSql = SearchSql + " FROM EMAIL AS DS " + "\r\n";
			}
			else
			{
				SearchSql = SearchSql + " SELECT count(*) ";
				SearchSql = SearchSql + " FROM EMAIL " + "\r\n";
			}
			
			
			SearchSql = SearchSql + " WHERE " + "\r\n";
			
			
			return SearchSql;
		}
		
		public void IncludeEmailAttachmentsSearch(bool ckIncludeAttachments, bool ckWeighted, bool ckBusiness, string SearchText, bool ckLimitToExisting, string txtThesaurus, string cbThesaurusText, string LibraryName, bool bIncludeAllLibs)
		{
			
			if (ckIncludeAttachments)
			{
				
				if (bIncludeAllLibs == true)
				{
					LibraryName = "";
				}
				
				
				string SS = "delete FROM [EmailAttachmentSearchList] where [UserID] = \'" + modGlobals.gCurrUserGuidID + "\'";
				SS = ENC2.EncryptPhrase(SS, GLOBALS.ContractID);
				GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(SecureID, GLOBALS.gRowID, SS, GLOBALS._UserID, GLOBALS.ContractID);
				
				bool bb = true;
				if (! bb)
				{
					MessageBox.Show("Failed to initialize Attachment Content Search. Content search is not included in the results.");
				}
				else
				{
					
					string EmailContentWhereClause = "";
					string insertSql = "";
					
					EmailContentWhereClause = genContainsClause(SearchText, ckBusiness, ckWeighted, true, ckLimitToExisting, ThesaurusList, txtThesaurus, cbThesaurusText, "EMAIL");
					
					isAdmin = modGlobals.gIsAdmin;
					
					if (! modGlobals.gIsAdmin && modGlobals.gIsGlobalSearcher == false)
					{
						EmailContentWhereClause = EmailContentWhereClause + "\r\n" + " And DataSourceOwnerUserID = \'" + modGlobals.gCurrUserGuidID + "\' ";
					}
					else
					{
						EmailContentWhereClause = EmailContentWhereClause + "\r\n" + " And DataSourceOwnerUserID IS NOT null ";
					}
					if (dDeBug)
					{
						Console.WriteLine(EmailContentWhereClause);
					}
					insertSql = EmailContentWhereClause;
					
					if (ckBusiness)
					{
						SearchEmailAttachments(ref insertSql, true);
					}
					else
					{
						SearchEmailAttachments(ref insertSql, false);
					}
					
					if (! modGlobals.gIsAdmin && modGlobals.gIsGlobalSearcher == false)
					{
						//** If not an ADMIN, then limit to USER content only
						insertSql = insertSql + "\r\n" + " AND UserID = \'" + modGlobals.gCurrUserGuidID + "\' ";
					}
					
					
					//AddHandler proxy2.ExecuteSqlNewConnCompleted, AddressOf client_ExecuteSqlNewConn
					insertSql = ENC2.EncryptPhrase(insertSql, GLOBALS.ContractID);
					proxy2.ExecuteSqlNewConnSecureAsync(SecureID, GLOBALS.gRowID, insertSql, GLOBALS._UserID, GLOBALS.ContractID);
					
					bb = true;
					if (! bb)
					{
						LOG.WriteToSqlLog("clsSQl:IncludeEmailAttachmentsSearch : Failed to insert Attachment Content Search. Content search is not included in the results.");
						LOG.WriteToSqlLog((string) ("clsSQl:IncludeEmailAttachmentsSearch : The SQL Stmt: " + insertSql));
						modGlobals.NbrOfErrors++;
						//'FrmMDIMain.SB.Text = "Errors: " + NbrOfErrors.ToString
					}
					
					
				}
			}
		}
		public void IncludeEmailAttachmentsSearchWeighted(bool ckIncludeAttachments, bool ckWeighted, bool ckBusiness, string SearchText, bool ckLimitToExisting, string txtThesaurus, string cbThesaurusText, int MinWeight)
		{
			if (ckIncludeAttachments)
			{
				string SS = "delete FROM [EmailAttachmentSearchList] where [UserID] = \'" + modGlobals.gCurrUserGuidID + "\'";
				bool BB = true;
				
				//Dim proxy2 As New SVCSearch.Service1Client
				//AddHandler proxy2.ExecuteSqlNewConnCompleted, AddressOf client_ExecuteSqlNewConn
				SS = ENC2.EncryptPhrase(SS, GLOBALS.ContractID);
				proxy2.ExecuteSqlNewConnSecureAsync(SecureID, GLOBALS.gRowID, SS, GLOBALS._UserID, GLOBALS.ContractID);
				
				if (! BB)
				{
					MessageBox.Show("Failed to initialize Attachment Content Search. Content search is not included in the results.");
				}
				else
				{
					string EmailContentWhereClause = "";
					string insertSql = "";
					EmailContentWhereClause = genContainsClause(SearchText, ckBusiness, ckWeighted, true, ckLimitToExisting, ThesaurusList, txtThesaurus, cbThesaurusText, "EMAIL");
					
					string SS1 = EmailContentWhereClause.Replace("CONTAINS(BODY", "CONTAINS(Attachment");
					string SS2 = SS1.Replace("CONTAINS(SUBJECT", "CONTAINS(OcrText");
					SS1 = SS2;
					
					insertSql = SS1;
					if (ckBusiness)
					{
						GetSubContainsClauseWeighted(SearchText, ref insertSql, true, MinWeight);
					}
					else
					{
						GetSubContainsClauseWeighted(SearchText, ref insertSql, false, MinWeight);
					}
					
					insertSql = ENC2.EncryptPhrase(insertSql, GLOBALS.ContractID);
					proxy3.ExecuteSqlNewConnSecureAsync(SecureID, GLOBALS.gRowID, insertSql, GLOBALS._UserID, GLOBALS.ContractID);
					
					BB = true;
					if (! BB)
					{
						LOG.WriteToSqlLog("clsSQl:IncludeEmailAttachmentsSearch : Failed to insert Attachment Content Search. Content search is not included in the results.");
						LOG.WriteToSqlLog((string) ("clsSQl:IncludeEmailAttachmentsSearch : The SQL Stmt: " + insertSql));
						modGlobals.NbrOfErrors++;
						//'FrmMDIMain.SB.Text = "Errors: " + NbrOfErrors.ToString
					}
				}
			}
		}
		
		
		
		
		public void GetSubContainsClauseWeighted(string SearchText, ref string ContainsClause, bool isFreetext, int MinWeight)
		{
			string S = "";
			
			int I = 0;
			
			try
			{
				string CorrectedSearchClause = CleanIsAboutSearchText(SearchText);
				CorrectedSearchClause = CorrectedSearchClause.Trim();
				if (CorrectedSearchClause.Length > 2)
				{
					var C = CorrectedSearchClause.Substring(CorrectedSearchClause.Length - 1, 1);
					if (C.Equals(","))
					{
						CorrectedSearchClause = CorrectedSearchClause.Substring(0, CorrectedSearchClause.Length - 1);
						CorrectedSearchClause = CorrectedSearchClause.Trim();
					}
				}
				
				//CorrectedSearchClause = UTIL.RemoveOcrProblemChars(CorrectedSearchClause as string)
				
				S = "insert EmailAttachmentSearchList ([EmailGuid], [UserID], Weight, RowID) " + "\r\n";
				
				S = S + "   SELECT [EmailGuid] ,[UserID], KEY_TBL.RANK, RowID " + "\r\n";
				S = S + "   FROM EmailAttachment " + "\r\n";
				S = S + "      INNER JOIN CONTAINSTABLE(EmailAttachment,attachment, \'ISABOUT (" + CorrectedSearchClause + ")\' ) as KEY_TBL" + "\r\n";
				S = S + "        ON rowid = KEY_TBL.[KEY]" + "\r\n";
				S = S + "   WHERE " + "\r\n";
				
				if (isFreetext == false)
				{
					ContainsClause = ContainsClause + " and ((UserID is not null) and UserID = \'" + modGlobals.gCurrUserGuidID + "\' and KEY_TBL.RANK > " + MinWeight.ToString() + " or isPublic = \'Y\')";
					ContainsClause = S + ContainsClause + "\r\n";
					return;
				}
				
				S = ContainsClause;
				I = 0;
				I = S.IndexOf("(") + 1;
				//Mid(ContainsClause, I, 1) = " "
				modGlobals.MidX(ContainsClause, I, " ");
				S = S.Trim();
				I = S.IndexOf(",") + 1;
				S = S.Substring(I - 1);
				I = S.IndexOf("/*") + 1;
				if (I > 0)
				{
					S = S.Substring(0, I - 1);
				}
				if (isFreetext)
				{
					S = (string) ("FREETEXT ((Attachment, OcrText)" + S);
				}
				else
				{
					S = ContainsClause;
				}
				
				ContainsClause = S + S + "\r\n";
				
			}
			catch (Exception ex)
			{
				Console.WriteLine(ex.Message);
			}
		}
		
		public void ParseSearchString(ref System.Windows.Documents.List<string> A, string S)
		{
			int I = 0;
			int J = 0;
			int K = S.Trim().Length;
			var S1 = "";
			var S2 = "";
			var CH = "";
			var Token = "";
			
			S = S.Trim();
			
			for (I = 1; I <= K; I++)
			{
reeval:
				CH = S.Substring(I - 1, 1);
				if (CH == Strings.ChrW(34))
				{
					Token += CH;
					I++;
					CH = S.Substring(I - 1, 1);
					while (CH != Strings.ChrW(34) && I <= K)
					{
						Token += CH;
						I++;
						CH = S.Substring(I - 1, 1);
					}
					Token += CH;
					A.Add(Token.Trim());
					Token = "";
				}
				else if (CH == "+")
				{
					if (Token.Trim().Length > 0)
					{
						A.Add(Token.Trim());
						Token = "";
					}
					A.Add(CH);
					Token = "";
				}
				else if (CH == "|")
				{
					if (Token.Trim().Length > 0)
					{
						A.Add(Token.Trim());
						Token = "";
					}
					A.Add(" ");
					Token = "";
				}
				else if (CH == "(")
				{
					if (Token.Trim().Length > 0)
					{
						A.Add(Token.Trim());
						Token = "";
					}
					A.Add(CH);
					Token = "";
				}
				else if (CH == ")")
				{
					if (Token.Trim().Length > 0)
					{
						A.Add(Token.Trim());
						Token = "";
					}
					A.Add(CH);
					Token = "";
				}
				else if (CH == "-")
				{
					if (Token.Trim().Length > 0)
					{
						A.Add(Token.Trim());
						Token = "";
					}
					A.Add(CH);
					Token = "";
				}
				else if (CH == "~")
				{
					if (Token.Trim().Length > 0)
					{
						A.Add(Token.Trim());
						Token = "";
					}
					A.Add(CH);
					Token = "";
				}
				else if (CH == "^")
				{
					if (Token.Trim().Length > 0)
					{
						A.Add(Token.Trim());
						Token = "";
					}
					A.Add(CH);
					Token = "";
				}
				else if (CH == " ")
				{
					if (Token.Trim().Length > 0)
					{
						A.Add(Token.Trim());
						Token = "";
					}
					I++;
					CH = S.Substring(I - 1, 1);
					while (CH == " " && I <= K)
					{
						Token += CH;
						I++;
						CH = S.Substring(I - 1, 1);
					}
					goto reeval;
				}
				else
				{
					Token += CH;
				}
			}
			if (Token.Trim().Length > 0)
			{
				A.Add(Token.Trim());
			}
			
			var T1 = "";
			var P1 = "";
			
			for (I = 0; I <= A.Count - 1; I++)
			{
				if (dDeBug)
				{
					Console.WriteLine(A(I));
				}
				T1 = A(I);
				if (P1.Equals("-") && T1.Equals("+"))
				{
					A(I - 1) = "+" && A(I) == "-";
				}
				if (P1.Equals("NOT") && T1.Equals("AND"))
				{
					A(I - 1) = "AND" && A(I) == "NOT";
				}
				if (P1.Equals("-") && T1.Equals("AND"))
				{
					A(I - 1) = "AND" && A(I) == "NOT";
				}
				if (P1.Equals("NOT") && T1.Equals("+"))
				{
					A(I - 1) = "AND" && A(I) == "NOT";
				}
				P1 = T1;
			}
		}
		public void RebuildString(System.Windows.Documents.List<string> A, ref string S)
		{
			
			int I = 0;
			int J = 0;
			
			var S1 = "";
			var S2 = "";
			var CH = "";
			var Token = "";
			var PrevToken = "";
			var PrevSymbol = "";
			var CurrSymbol = "";
			bool CurrSymbolIsKeyWord = false;
			bool PrevSymbolIsKeyWord = false;
			bool OrMayBeNeeded = false;
			
			S = "";
			
			for (I = 0; I <= A.Count - 1; I++)
			{
				if (dDeBug)
				{
					Console.WriteLine(A(I));
				}
				Token = A(I);
				if (Token.ToUpper() == "OR")
				{
					CurrSymbol = "|";
					Token = "OR";
					CurrSymbolIsKeyWord = true;
				}
				else if (Token.ToUpper() == "+")
				{
					CurrSymbol = "+";
					Token = "AND";
					CurrSymbolIsKeyWord = true;
				}
				else if (Token.ToUpper() == "AND")
				{
					CurrSymbol = "+";
					Token = "AND";
					CurrSymbolIsKeyWord = true;
				}
				else if (Token.ToUpper() == "NEAR")
				{
					CurrSymbol = "+";
					Token = "NEAR";
					CurrSymbolIsKeyWord = true;
				}
				else if (Token.ToUpper() == "(")
				{
					CurrSymbol = "";
					Token = "(";
					CurrSymbolIsKeyWord = true;
				}
				else if (Token.ToUpper() == ")")
				{
					CurrSymbol = "";
					Token = ")";
					CurrSymbolIsKeyWord = true;
				}
				else if (Token.ToUpper() == "-")
				{
					CurrSymbol = "-";
					Token = "NOT";
					CurrSymbolIsKeyWord = true;
				}
				else if (Token.ToUpper() == "NOT")
				{
					CurrSymbol = "-";
					Token = "NOT";
					CurrSymbolIsKeyWord = true;
				}
				else if (Token.ToUpper() == "~")
				{
					CurrSymbol = "~";
					Token = "~";
					CurrSymbolIsKeyWord = true;
				}
				else if (Token.ToUpper() == "^")
				{
					CurrSymbol = "^";
					Token = "^";
					CurrSymbolIsKeyWord = true;
				}
				else if (Token.ToUpper() == Strings.ChrW(254))
				{
					CurrSymbol = Strings.ChrW(254);
					Token = "";
					OrMayBeNeeded = true;
				}
				else
				{
					CurrSymbol = "";
					CurrSymbol = "";
					Token = A(I);
					CurrSymbolIsKeyWord = false;
				}
				if (PrevSymbol == ")" && CurrSymbol == "^")
				{
					//** Skip this line
					S = S + " OR ";
					goto ProcessNextToken;
				}
				if (PrevSymbol == ")" && CurrSymbol == "~")
				{
					//** Skip this line
					S = S + " OR ";
					goto ProcessNextToken;
				}
				if (OrMayBeNeeded && CurrSymbolIsKeyWord == false)
				{
					S = S + " oR ";
				}
				if (OrMayBeNeeded && CurrSymbolIsKeyWord == true)
				{
					OrMayBeNeeded = false;
				}
				if (PrevSymbol == Strings.ChrW(254) && CurrSymbol == Strings.ChrW(254))
				{
					//** Skip this line
					goto ProcessNextToken;
				}
				if (PrevSymbol == Strings.ChrW(254) && CurrSymbolIsKeyWord)
				{
					S = S.Trim() + " " + Token;
					goto ProcessNextToken;
				}
				if (PrevSymbol == Strings.ChrW(254) && CurrSymbolIsKeyWord == false)
				{
					S = S + " Or " + Token;
					
				}
				if (PrevSymbol == Strings.ChrW(254) && CurrSymbolIsKeyWord == false)
				{
					S = S + " Or " + Token;
					
				}
				if (PrevSymbol.Equals("~") && CurrSymbolIsKeyWord == false)
				{
					S = S + Token;
					goto ProcessNextToken;
				}
				if (PrevSymbol.Equals("^") && CurrSymbolIsKeyWord == false)
				{
					S = S + Token;
					goto ProcessNextToken;
				}
				if (CurrSymbolIsKeyWord == true && CurrSymbol == Strings.ChrW(254))
				{
					//** Skip this line
					goto ProcessNextToken;
				}
				if (PrevSymbolIsKeyWord == false && CurrSymbolIsKeyWord == false && I > 0)
				{
					//** do nothing
					S = S + " or " + Token;
					goto ProcessNextToken;
				}
				if (PrevSymbolIsKeyWord == false && CurrSymbolIsKeyWord == false && I == 0)
				{
					//** do nothing
					S = Token + " ";
					goto ProcessNextToken;
				}
				if (PrevSymbolIsKeyWord == true && CurrSymbolIsKeyWord == false)
				{
					S = S.Trim() + " " + Token;
				}
				if (PrevSymbolIsKeyWord == false && CurrSymbolIsKeyWord == true)
				{
					S = S.Trim() + " " + Token;
				}
				if (PrevSymbolIsKeyWord == true && CurrSymbolIsKeyWord == true)
				{
					if (PrevSymbol == "NOT" && CurrSymbol == "OR")
					{
						S = S + "";
					}
					else if (PrevSymbol == "OR" && CurrSymbol == "NOT")
					{
						S = S + "";
					}
					else
					{
						S = S.Trim() + " " + Token;
					}
				}
ProcessNextToken:
				PrevToken = Token;
				PrevSymbol = CurrSymbol;
				PrevSymbolIsKeyWord = CurrSymbolIsKeyWord;
				if (dDeBug)
				{
					Console.WriteLine(S);
				}
			}
			
			S = S.Trim();
		}
		public bool CountDoubleQuotes(string S)
		{
			S = S.Trim();
			if (S.Trim().Length == 0)
			{
				return true;
			}
			int I = 0;
			var CH = "";
			int iCnt = 0;
			if (S.IndexOf((Strings.ChrW(34)).ToString()) + 1 == 0)
			{
				return true;
			}
			for (I = 1; I <= S.Trim().Length; I++)
			{
				CH = S.Substring(I - 1, 1);
				if (CH.Equals(Strings.ChrW(34)))
				{
					iCnt++;
				}
			}
			if (iCnt % 2 == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		public bool PreProcessSearch(ref string S, bool bFullTextSearch)
		{
			//S = S.Trim
			bool B = true;
			try
			{
				int I = 0;
				string S1 = "";
				string S2 = "";
				string CH = "";
				List<string> aList = new List<string>();
				int K = K;
				
				ParseSearchString(ref aList, S);
				RebuildString(aList, ref S);
				
reeval:
				K = S.Trim().Length;
				var NewStr = "";
				
				for (I = 1; I <= K; I++)
				{
					var CurrChar = S.Substring(I - 1, 1);
EvalCurrChar:
					var PrevChar = "";
					if (I > 1)
					{
						PrevChar = S.Substring(I - 1 - 1, 1);
					}
					else
					{
					}
					if (CurrChar.Equals(Strings.ChrW(34)))
					{
						NewStr += CurrChar;
						I++;
						CurrChar = S.Substring(I - 1, 1);
						while (CurrChar != Strings.ChrW(34) && I <= S.Trim().Length)
						{
							NewStr += CurrChar;
							I++;
							CurrChar = S.Substring(I - 1, 1);
						}
						NewStr += CurrChar;
						goto GetNextChar;
					}
					if (CurrChar.Equals(" "))
					{
						NewStr += CurrChar;
						I++;
						CurrChar = S.Substring(I - 1, 1);
						while (CurrChar.Equals(" ") && I <= S.Trim().Length)
						{
							NewStr += Strings.ChrW(254);
							I++;
							CurrChar = S.Substring(I - 1, 1);
						}
						if (CurrChar.Equals(")"))
						{
							if (dDeBug)
							{
								Console.WriteLine("Here xxx1");
							}
						}
						goto EvalCurrChar;
					}
					if (CurrChar.Equals("-") || CurrChar.Equals("+") || CurrChar.Equals("|") || CurrChar.Equals("^") || CurrChar.Equals("~") || CurrChar.Equals("("))
					{
						NewStr += CurrChar;
						I++;
						CurrChar = S.Substring(I - 1, 1);
						while (CurrChar.Equals(" ") && I <= S.Trim().Length)
						{
							NewStr += Strings.ChrW(254);
							I++;
							CurrChar = S.Substring(I - 1, 1);
						}
						goto EvalCurrChar;
					}
					
					if (CurrChar.Equals("+") && PrevChar.Equals("-"))
					{
						//Mid(S, I, 1) = "-"
						modGlobals.MidX(S, I, "-");
						//Mid(S, I - 1, 1) = "+"
						modGlobals.MidX(S, I - 1, "+");
					}
					if (CurrChar.Equals("+") && PrevChar.Equals("+"))
					{
						goto GetNextChar;
					}
					if (CurrChar.Equals("-") && PrevChar.Equals("-"))
					{
						goto GetNextChar;
					}
					if (CurrChar.Equals("^") && PrevChar.Equals("^"))
					{
						goto GetNextChar;
					}
					if (CurrChar.Equals("~") && PrevChar.Equals("~"))
					{
						goto GetNextChar;
					}
					if (CurrChar.Equals(")") && (PrevChar.Equals(" ") || PrevChar.Equals(Strings.ChrW(254))))
					{
						var C = "";
						int II = NewStr.Length;
						C = S.Substring(II - 1, 1);
						while ((C.Equals(" ") || C.Equals(Strings.ChrW(254))) && II > 0)
						{
							//Mid(NewStr, II, 1) = ChrW(254)
							modGlobals.MidX(NewStr, II, Strings.ChrW(254));
							II--;
							C = NewStr.Substring(II - 1, 1);
						}
						//GoTo EvalCurrChar
						C = "";
					}
					
					
					NewStr += CurrChar;
GetNextChar:
					1.GetHashCode() ; //VBConversions note: C# requires an executable line here, so a dummy line was added.
				}
				NewStr = DMA.RemoveChar(NewStr, Strings.ChrW(254));
				S = NewStr;
			}
			catch (Exception)
			{
				B = false;
			}
			
			return B;
			
		}
		public void ValidateNotClauses(ref string SqlText)
		{
			if (SqlText.Trim().Length == 0)
			{
				return;
			}
			
			
			bool DoThis = false;
			
			
			if (! DoThis)
			{
				return;
			}
			
			
			int I = 0;
			string prevWord = "";
			string currWord = "";
			string CH = "";
			List<string> aList = new List<string>();
			for (I = 1; I <= SqlText.Length; I++)
			{
				CH = SqlText.Substring(I - 1, 1);
				if (CH == Strings.ChrW(34))
				{
					I++;
					CH = SqlText.Substring(I - 1, 1);
					while (CH != Strings.ChrW(34) && I <= SqlText.Length)
					{
						I++;
						CH = SqlText.Substring(I - 1, 1);
					}
				}
				else if (CH == " ")
				{
					//Mid(SqlText, I, 1) = ChrW(254)
					modGlobals.MidX(SqlText, I, Strings.ChrW(254));
				}
			}
			object[] A = SqlText.Split(Strings.ChrW(254).ToString().ToCharArray());
			currWord = "";
			prevWord = "";
			for (I = 0; I <= (A.Length - 1); I++)
			{
				currWord = A[I];
				if (currWord.ToUpper().Equals("NOT") && prevWord.ToUpper().Equals("AND"))
				{
					aList.Add(currWord);
				}
				else if (currWord.ToUpper().Equals("OR") && prevWord.ToUpper().Equals("OR"))
				{
					//** DO nothing - user supplied multiple blanks
				}
				else if (currWord.ToUpper().Equals("AND") && prevWord.ToUpper().Equals("OR"))
				{
					//** DO nothing - user supplied multiple blanks
				}
				else if (currWord.ToUpper().Equals("OR") && prevWord.ToUpper().Equals("AND"))
				{
					aList.Add(currWord);
				}
				else if (currWord.ToUpper().Equals("NOT") && prevWord.ToUpper().Equals("IS"))
				{
					aList.Add(currWord);
				}
				else if (currWord.ToUpper().Equals("NOT") && ! prevWord.ToUpper().Equals("AND"))
				{
					currWord = "And Not";
					aList.Add(currWord);
				}
				else if (currWord.ToUpper().Equals("FORMSOF") && ! prevWord.ToUpper().Equals("AND"))
				{
					currWord = "FormsOF";
					aList.Add(currWord);
				}
				else
				{
					aList.Add(currWord);
				}
				prevWord = currWord;
			}
			SqlText = "";
			for (I = 0; I <= aList.Count - 1; I++)
			{
				try
				{
					//If aList(I) = Nothing Then
					//    LOG.WriteToSqlLog("nothing")
					//    Dim X# = 1
					//Else
					var tWord = aList(I);
					var EOL = "";
					switch (Strings.LCase(tWord))
					{
						case "select":
							EOL = "\r\n";
							break;
						case "from":
							EOL = "\r\n";
							break;
						case "where":
							EOL = "\r\n";
							break;
						case "order":
							EOL = "\r\n";
							break;
						case "and":
							EOL = "\r\n";
							break;
						case "or":
							EOL = "\r\n";
							break;
					}
					if (tWord.ToString().IndexOf(",") + 1 > 0)
					{
						EOL = "\r\n" + "\t";
					}
					if (tWord.ToString().IndexOf("not") + 1 > 0)
					{
						double x = 1;
					}
					if (I == 0)
					{
						SqlText += EOL + aList(0).Trim;
					}
					else
					{
						SqlText += (string) (" " + EOL + aList(I).Trim);
					}
					//End If
				}
				catch (Exception ex)
				{
					LOG.WriteToSqlLog(ex.Message);
				}
			}
		}
		public bool genIsInLibrariesSql()
		{
			
			bool B = false;
			string S = "";
			S = S + " delete from TempUserLibItems where UserID = \'" + modGlobals.gCurrUserGuidID + "\'";
			try
			{
				//B = DB.ExecuteSqlNewConn(S)
				//Dim proxy As New SVCSearch.Service1Client
				
				S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
				GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(SecureID, GLOBALS.gRowID, S, GLOBALS.UserID, GLOBALS.ContractID);
				
			}
			catch (Exception ex)
			{
				B = false;
				LOG.WriteToSqlLog((string) ("ERROR genIsInLibrariesSql: " + ex.Message + "\r\n" + S));
			}
			
			return B;
			
		}
		
		public string genAllLibrariesSql()
		{
			
			string S = "";
			S = S + " select distinct SourceGuid, \'" + modGlobals.gCurrUserGuidID + "\' from LibraryItems" + "\r\n";
			S = S + "  where LibraryName in (" + "\r\n";
			S = S + "  select distinct LibraryName from GroupLibraryAccess " + "\r\n";
			S = S + "  where GroupName in ";
			S = S + "  (select distinct GroupName from GroupUsers where UserID = \'wmiller\')" + "\r\n";
			S = S + "  union " + "\r\n";
			S = S + "  select distinct LibraryName from LibraryUsers where UserID = \'wmiller\' )" + "\r\n";
			
			return S;
			
		}
		
		public void AddPaging(int StartPageNo, int EndPageNo, ref string SqlQuery, bool bIncludeLibraryFilesInSearch)
		{
			
			bool WeightedSearch = false;
			List<string> L = new List<string>();
			
			object[] A = SqlQuery.Split("\r\n".ToCharArray());
			string S = SqlQuery;
			bool xContentAdded = false;
			bool ContainsUnion = false;
			bool ContainsLimitToLibrary = false;
			
			int iSelect = 0;
			
			for (int i = 0; i <= (A.Length - 1); i++)
			{
				S = (string) (A[i].Trim);
				if (modGlobals.gClipBoardActive == true)
				{
					Console.WriteLine(S);
				}
				if (S.IndexOf("SELECT   distinct  LibraryItems.SourceGuid") + 1 > 0)
				{
					Console.WriteLine("XXX1 Here");
				}
				if (S.IndexOf("LibraryUsers") + 1 > 0)
				{
					Console.WriteLine("XXX1 Here");
				}
				if (S.IndexOf("FROM TempUserLibItems") + 1 > 0)
				{
					Console.WriteLine("Here 22,22,1");
				}
				if (S.IndexOf("UNION") + 1 > 0)
				{
					ContainsUnion = true;
				}
				
				if (S.IndexOf("/*") + 1 > 0 && S.IndexOf("*/") + 1 > 0)
				{
					L.Add(Strings.ChrW(9) + S + "\r\n");
					goto NEXTLINE;
				}
				
				if (S.IndexOf("EmailAttachmentSearchList") + 1 > 0)
				{
					//Console.WriteLine("Here xx0011")
					L.Add(Strings.ChrW(9) + S + "\r\n");
					goto NEXTLINE;
				}
				//SELECT TOP 1000  KEY_TBL.RANK
				if (S.IndexOf("SELECT") + 1 > 0 && S.IndexOf("KEY_TBL.RANK") + 1 > 0)
				{
					WeightedSearch = true;
					//Else
					//    WeightedSearch = False
				}
				if (S.IndexOf("ORDER BY KEY_TBL.RANK DESC") + 1 > 0)
				{
					WeightedSearch = true;
					S = (string) (Strings.ChrW(9) + "/* " + S + " */" + "\r\n" + Strings.ChrW(9) + "/* above commented out by Pagination Module */");
				}
				if (S.IndexOf("/*KEPP*/") + 1 > 0)
				{
					ContainsLimitToLibrary = true;
				}
				else
				{
					ContainsLimitToLibrary = false;
				}
				if (ContainsLimitToLibrary == true)
				{
					S = (string) (Strings.ChrW(9) + S);
					L.Add(Strings.ChrW(9) + S + "\r\n");
				}
				else if (ContainsUnion == false && S.IndexOf("select") + 1 > 0 && S.IndexOf("*") + 1 == 0 && S.IndexOf("FROM [LibraryItems]") + 1 == 0 && S.IndexOf("FROM TempUserLibItems") + 1 == 0)
				{
					if (S.Length >= "select".Length)
					{
						if (S.IndexOf("or EmailGuid in (SELECT   distinct  LibraryItems.SourceGuid") + 1 > 0)
						{
							L.Add(S + "\r\n");
							Console.WriteLine("XX2 Do nothing here.");
						}
						else if (S.IndexOf("or SourceGuid in (SELECT   distinct  LibraryItems.SourceGuid") + 1 > 0)
						{
							L.Add(S + "\r\n");
							Console.WriteLine("XX3 Do nothing here.");
						}
						else if (S.Substring(0, 6).ToUpper().Equals("SELECT"))
						{
							L.Add("WITH xContent AS" + "\r\n");
							L.Add("(" + "\r\n");
							L.Add(S + "\r\n");
							xContentAdded = false;
						}
					}
				}
				else if (S.IndexOf("FROM datasource") + 1 > 0 || S.IndexOf("FROM DataSource") + 1 > 0)
				{
					if (WeightedSearch == true)
					{
						L.Add(Strings.ChrW(9) + ",ROW_NUMBER() OVER (ORDER BY Rank DESC) AS ROWID" + "\r\n");
					}
					else
					{
						L.Add(Strings.ChrW(9) + ",ROW_NUMBER() OVER (ORDER BY SourceName ASC) AS ROWID" + "\r\n");
					}
					
					L.Add(S + "\r\n");
				}
				else if (S.IndexOf("FROM EMAIL") + 1 > 0)
				{
					if (WeightedSearch == true)
					{
						L.Add(Strings.ChrW(9) + ",ROW_NUMBER() OVER (ORDER BY Rank DESC) AS ROWID" + "\r\n");
					}
					else
					{
						L.Add(Strings.ChrW(9) + ",ROW_NUMBER() OVER (ORDER BY SentOn ASC) AS ROWID" + "\r\n");
					}
					
					L.Add(S + "\r\n");
				}
				else if (ContainsUnion == false && (Strings.ChrW(9) + S).ToString().IndexOf("order by") + 1 > 0)
				{
					//If WeightedSearch = False Then
					S = (string) ("--" + S);
					//End If
					
					L.Add(S + "\r\n");
					L.Add(")" + "\r\n");
					L.Add("Select * " + "\r\n");
					L.Add("FROM xContent" + "\r\n");
					L.Add("WHERE ROWID BETWEEN " + StartPageNo.ToString() + " AND " + EndPageNo.ToString() + "\r\n");
					WeightedSearch = false;
					xContentAdded = true;
				}
				else if (ContainsUnion == true && (Strings.ChrW(9) + S).ToString().IndexOf("order by [SourceName]") + 1 > 0)
				{
					//If WeightedSearch = False Then
					S = (string) ("--" + S);
				}
				else
				{
					L.Add(Strings.ChrW(9) + S + "\r\n");
				}
NEXTLINE:
				1.GetHashCode() ; //VBConversions note: C# requires an executable line here, so a dummy line was added.
			}
			if (xContentAdded == false)
			{
				L.Add(")" + "\r\n");
				L.Add("Select * " + "\r\n");
				L.Add("FROM xContent" + "\r\n");
				L.Add("WHERE ROWID BETWEEN " + StartPageNo.ToString() + " AND " + EndPageNo.ToString() + "\r\n");
			}
			//** Rebuild the statement
			int II = 0;
			SqlQuery = "";
			foreach (string tempLoopVar_S in L)
			{
				S = tempLoopVar_S;
				II++;
				if (modGlobals.gClipBoardActive)
				{
					Console.WriteLine(II.ToString() + ": " + S);
				}
				if (S.IndexOf("\r\n") + 1 == 0)
				{
					S = S + "\r\n";
				}
				SqlQuery += S;
			}
			
		}
		
		public string genAttachmentSearchSQLAdmin(string EmailContainsClause)
		{
			
			var S = "";
			
			S += (string) (" select EmailGuid from EmailAttachment where " + EmailContainsClause);
			
			return S;
		}
		
		public string genAttachmentSearchSQLUser(string EmailContainsClause)
		{
			
			var S = "";
			
			S += " select EmailGuid from EmailAttachment where " + EmailContainsClause + "\r\n" + " and UserID = \'" + modGlobals.gCurrUserGuidID + "\'";
			
			return S;
		}
		
		public string genAllLibrariesSelect(string EmailContainsClause)
		{
			
			var AllLibSql = "";
			
			AllLibSql += " SELECT distinct SourceGuid FROM [LibraryItems] where LibraryName in " + "\r\n";
			AllLibSql += " (" + "\r\n";
			AllLibSql += " select distinct LibraryName from LibraryUsers where UserID = \'" + modGlobals.gCurrUserGuidID + "\'" + "\r\n";
			AllLibSql += " )" + "\r\n";
			
			
			string S = "";
			S = S + " and EmailGuid in (" + AllLibSql + ")";
			
			return S;
		}
		public string genSingleLibrarySelect(string EmailContainsClause, string LibraryName)
		{
			string S = "";
			
			//S = S + " and EmailGuid in (SELECT [SourceGuid] FROM [LibraryItems] where LibraryName = '" + LibraryName$ + "')"
			//** DO NOT PUT vbcrlf at the end of the below lines. That will cause problems in inserting PAGING.
			bool gSearcher = false;
			if (modGlobals.gIsAdmin == true || modGlobals.gIsGlobalSearcher == true)
			{
				gSearcher = true;
			}
			
			S = S + " AND EmailGuid in (" + GEN.genLibrarySearch(modGlobals.gCurrUserGuidID, gSearcher, LibraryName, "Gen@12") + ")";
			
			return S;
		}
		
		public void SearchEmailAttachments(ref string ContainsClause, bool isFreetext)
		{
			
			var tSql = "";
			string S = "";
			int I = 0;
			
			S = "delete from EmailAttachmentSearchList where UserID = \'" + modGlobals.gCurrUserGuidID + "\' ";
			bRunningSql = true;
			//Dim proxy As New SVCSearch.Service1Client
			S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(SecureID, GLOBALS.gRowID, S, GLOBALS._UserID, GLOBALS.ContractID);
			
			try
			{
				
				tSql = "insert EmailAttachmentSearchList ([UserID],[EmailGuid], RowID) " + "\r\n";
				tSql = tSql + " select \'" + modGlobals.gCurrUserGuidID + "\',[EmailGuid], RowID  " + "\r\n";
				tSql = tSql + "FROM EmailAttachment " + "\r\n";
				tSql = tSql + "where " + "\r\n";
				S = ContainsClause;
				I = 0;
				I = S.IndexOf("(") + 1;
				//Mid(ContainsClause, I, 1) = " "
				modGlobals.MidX(ContainsClause, I, " ");
				S = S.Trim();
				I = S.IndexOf(",") + 1;
				S = S.Substring(I - 1);
				I = S.IndexOf("/*") + 1;
				if (I > 0)
				{
					S = S.Substring(0, I - 1);
				}
				if (isFreetext)
				{
					S = (string) ("FREETEXT ((Body, SUBJECT, KeyWords, Description)" + S);
				}
				else
				{
					S = (string) ("contains(EmailAttachment.*" + S);
				}
				
				ContainsClause = tSql + S + "\r\n";
			}
			catch (Exception ex)
			{
				Console.WriteLine(ex.Message);
			}
			
			//Clipboard.Clear()
			//Clipboard.SetText(ContainsClause as string)
			
		}
		
		public void client_ExecuteSqlNewConn(object sender, SVCSearch.ExecuteSqlNewConnSecureCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				bool B = System.Convert.ToBoolean(e.Result);
			}
			else
			{
				modGlobals.gErrorCount++;
				LOG.WriteToSqlLog((string) ("ERROR clsSql 100: " + e.Error.Message));
			}
		}
		public void client_ExecuteSqlNewConn2(object sender, SVCSearch.ExecuteSqlNewConnSecureCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				string S = "";
				S = "";
				S = S + " INSERT INTO TempUserLibItems (SourceGuid, Userid)" + "\r\n";
				S = S + " select distinct SourceGuid, \'" + modGlobals.gCurrUserGuidID + "\' from LibraryItems" + "\r\n";
				S = S + " where LibraryName in (" + "\r\n";
				S = S + " select distinct LibraryName from GroupLibraryAccess " + "\r\n";
				S = S + " where GroupName in " + "\r\n";
				S = S + " (select distinct GroupName from GroupUsers where UserID = \'" + modGlobals.gCurrUserGuidID + "\')" + "\r\n";
				S = S + " union " + "\r\n";
				S = S + " select distinct LibraryName from LibraryUsers where UserID = \'" + modGlobals.gCurrUserGuidID + "\'";
				S = S + " )" + "\r\n";
				
				//Dim proxy As New SVCSearch.Service1Client
				S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
				GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(SecureID, GLOBALS.gRowID, S, GLOBALS._UserID, GLOBALS.ContractID);
				
			}
			else
			{
				modGlobals.gErrorCount++;
				LOG.WriteToSqlLog((string) ("ERROR clsSql 100: " + e.Error.Message));
			}
		}
		public void client_ExecuteSqlNewConn3(object sender, SVCSearch.ExecuteSqlNewConnSecureCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				bool B = System.Convert.ToBoolean(e.Result);
			}
			else
			{
				modGlobals.gErrorCount++;
				LOG.WriteToSqlLog((string) ("ERROR clsSql 100: " + e.Error.Message));
			}
		}
		public void client_ExecuteSqlNewConn5(object sender, SVCSearch.ExecuteSqlNewConnSecureCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				bool B = System.Convert.ToBoolean(e.Result);
			}
			else
			{
				modGlobals.gErrorCount++;
				LOG.WriteToSqlLog((string) ("ERROR clsSql 100: " + e.Error.Message));
			}
		}
		public void client_ExecuteSqlNewConn6(object sender, SVCSearch.ExecuteSqlNewConnSecureCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				bool B = System.Convert.ToBoolean(e.Result);
			}
			else
			{
				modGlobals.gErrorCount++;
				LOG.WriteToSqlLog((string) ("ERROR clsSql 100: " + e.Error.Message));
			}
		}
		~clsSql()
		{
			try
			{
			}
			finally
			{
				base.Finalize(); //define the destructor
				GLOBALS.ProxySearch.getSynonymsCompleted -= new System.EventHandler(client_getSynonyms);
				GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted -= new System.EventHandler(client_ExecuteSqlNewConn);
				proxy2.ExecuteSqlNewConnSecureCompleted -= new System.EventHandler(client_ExecuteSqlNewConn);
				proxy3.ExecuteSqlNewConnSecureCompleted -= new System.EventHandler(client_ExecuteSqlNewConn);
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
		}
		
		private void setXXSearchSvcEndPoint()
		{
			
			if (GLOBALS.SearchEndPoint.Length == 0)
			{
				return;
			}
			
			Uri ServiceUri = new Uri(GLOBALS.SearchEndPoint);
			System.ServiceModel.EndpointAddress EPA = new System.ServiceModel.EndpointAddress(ServiceUri, null);
			
			GLOBALS.ProxySearch.Endpoint.Address = EPA;
			proxy2.Endpoint.Address = EPA;
			proxy3.Endpoint.Address = EPA;
			GC.Collect();
			GC.WaitForPendingFinalizers();
		}
		
	}
	
}
