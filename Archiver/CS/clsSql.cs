// VBConversions Note: VB project level imports
using System.Collections.Generic;
using System;
using System.Drawing;
using System.Linq;
using System.Diagnostics;
using System.Data;
using Microsoft.VisualBasic;
using MODI;
using System.Xml.Linq;
using System.Collections;
using System.Windows.Forms;
// End of VB project level imports

using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using Microsoft.VisualBasic.CompilerServices;



namespace EcmArchiveClcSetup
{
	public class clsSql
	{
		clsDatabase DB = new clsDatabase();
		clsDma DMA = new clsDma();
		clsGenerator GEN = new clsGenerator();
		
		clsUtility UTIL = new clsUtility();
		clsLogging LOG = new clsLogging();
		
		clsDb TREX = new clsDb();
		
		bool dDeBug = true;
		bool bSaveToClipBoard = true;
		
		string txtSearch = null;
		bool getCountOnly = System.Convert.ToBoolean(null);
		bool UseExistingRecordsOnly = System.Convert.ToBoolean(null);
		bool ckWeighted = System.Convert.ToBoolean(null);
		string GeneratedSQL = null;
		bool isAdmin = System.Convert.ToBoolean(null);
		bool ckBusiness = System.Convert.ToBoolean(null);
		bool isInflectionalTerm = false;
		bool InflectionalToken = false;
		ArrayList ThesaurusList = new ArrayList();
		ArrayList ThesaurusWords = new ArrayList();
		
		public clsSql()
		{
			//Dim sDebug  = System.Configuration.ConfigurationManager.AppSettings("debug_clsSql")
			string sDebug = DB.getUserParm("debug_clsSql");
			if (sDebug.Equals("1"))
			{
				dDeBug = true;
				LOG.WriteToArchiveLog("Debug set ON for: clsSql");
			}
			else
			{
				//log.WriteToArchiveLog("Debug set OFF for: clsSql")
				dDeBug = false;
			}
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
			string WhereClause = "";
			bool bCopyToClipboard = true;
			string UserSql = "";
			
			if (SearchString == null)
			{
				Debug.Print("All required variables not set to call this function.");
				//return ""
			}
			if (getCountOnly == null)
			{
				Debug.Print("All required variables not set to call this function.");
				//return ""
			}
			if (ckWeighted == null)
			{
				Debug.Print("All required variables not set to call this function.");
				//return ""
			}
			
			
			GeneratedSQL = "";
			//**WDM Removed 7/12/2009 GeneratedSQL  = genHeader()
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
				
				//genDocWhereClause(WhereClause )
				string ContainsClause = "";
				//************************************************************************************************************************************************************
				ContainsClause = genContainsClause(SearchString, ckBusiness, ckWeighted, false, ckLimitToExisting, ThesaurusList, txtThesaurus, cbThesaurusText, "DOC");
				//************************************************************************************************************************************************************
				
				ContainsClause = ContainsClause + genUseExistingRecordsOnly(UseExistingRecordsOnly, "SourceGuid");
				
				//***********************************************************************
				isAdmin = DB.isAdmin(modGlobals.gCurrUserGuidID);
				if (isAdmin == false)
				{
					isAdmin = DB.isGlobalSearcher(modGlobals.gCurrUserGuidID);
				}
				UserSql = genAdminContentSql(isAdmin, ckLimitToLib, LibraryName);
				//***********************************************************************
				if (ContainsClause.Length)
				{
					GeneratedSQL = GeneratedSQL + "\r\n" + ContainsClause;
					if (bSaveToClipBoard)
					{
						modGlobals.SetToClipBoard(GeneratedSQL);
					}
				}
				
				if (bCopyToClipboard)
				{
					string tClip = "/* Part2 */ " + "\r\n";
					tClip += GeneratedSQL;
					if (bSaveToClipBoard)
					{
						modGlobals.SetToClipBoard(tClip);
					}
					Debug.Print(tClip);
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
					//**WDM 6/1/2009 GeneratedSQL  = GeneratedSQL  + " /* and KEY_TBL.RANK >= " + MinRating.ToString + " */" + vbCrLf
					if (bSaveToClipBoard)
					{
						modGlobals.SetToClipBoard(GeneratedSQL);
					}
				}
				else
				{
				}
				
				
				if (ckWeighted)
				{
					//GeneratedSQL  += vbCrLf + " or isPublic = 'Y' "
					GeneratedSQL += "\r\n" + " ORDER BY KEY_TBL.RANK DESC ";
				}
				else
				{
					//GeneratedSQL  += vbCrLf + " or isPublic = 'Y' "
					GeneratedSQL += "\r\n" + " order by [SourceName] ";
				}
			}
			
			
			if (bCopyToClipboard)
			{
				string tClip = "/* Final */ " + "\r\n";
				tClip += GeneratedSQL;
				if (bSaveToClipBoard)
				{
					modGlobals.SetToClipBoard(tClip);
				}
				if (bSaveToClipBoard)
				{
					LOG.WriteToArchiveLog(tClip);
				}
				Debug.Print(tClip);
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
		
		
		public string GenEmailGeneratedSQL(bool ckLimitToExisting, string txtThesaurus, string cbThesaurusText, bool ckWeighted, bool ckBusiness, string txtSearch, bool ckLimitToLib, string LibraryName, int MinWeight, bool bIncludeAllLibs)
		{
			//ByVal txtSearch as string , ByVal getCountOnly As Boolean, ByVal UseExistingRecordsOnly As Boolean, ByVal ckWeighted As Boolean, ByRef GeneratedSQL As String
			
			if (txtSearch == null)
			{
				Debug.Print("All required variables not set to call this function.");
				//return ""
			}
			else
			{
				
			}
			if (getCountOnly == null)
			{
				Debug.Print("All required variables not set to call this function.");
				//return ""
			}
			if (UseExistingRecordsOnly == null)
			{
				Debug.Print("All required variables not set to call this function.");
				//return ""
			}
			else
			{
				UseExistingRecordsOnly = ckLimitToExisting;
			}
			if (ckWeighted == null)
			{
				Debug.Print("All required variables not set to call this function.");
				//return ""
			}
			if (GeneratedSQL == null)
			{
				Debug.Print("All required variables not set to call this function.");
				//return ""
			}
			isAdmin = DB.isAdmin(modGlobals.gCurrUserGuidID);
			if (isAdmin == false)
			{
				isAdmin = DB.isGlobalSearcher(modGlobals.gCurrUserGuidID);
			}
			if (isAdmin == null)
			{
				Debug.Print("All required variables not set to call this function.");
				//return ""
			}
			if (ckBusiness == null)
			{
				Debug.Print("All required variables not set to call this function.");
				//return ""
			}
			
			var EmailSql = "";
			string WhereClause = "";
			bool bCopyToClipboard = true;
			
			string UserSql = genAdminEmailSql(isAdmin, ckLimitToLib, LibraryName);
			//**WDM Removed 7/12/2009 GeneratedSQL  = genHeader()
			
			if (getCountOnly)
			{
				GeneratedSQL += genEmailCountSql();
			}
			else
			{
				GeneratedSQL += getEmailTblCols(ckWeighted, ckBusiness, txtSearch);
			}
			
			
			GeneratedSQL = GeneratedSQL + " WHERE " + "\r\n";
			if (bSaveToClipBoard)
			{
				modGlobals.SetToClipBoard(GeneratedSQL);
			}
			
			
			string ContainsClause = "";
			ContainsClause = genContainsClause(txtSearch, ckBusiness, ckWeighted, true, ckLimitToExisting, ThesaurusList, txtThesaurus, cbThesaurusText, "EMAIL");
			
			if (ContainsClause.Length > 0)
			{
				GeneratedSQL = GeneratedSQL + "\r\n" + ContainsClause;
				if (bSaveToClipBoard)
				{
					modGlobals.SetToClipBoard(GeneratedSQL);
				}
			}
			
			
			if (bCopyToClipboard)
			{
				string tClip = "/* WhereClause  */ " + "\r\n";
				tClip += WhereClause;
				if (bSaveToClipBoard)
				{
					modGlobals.SetToClipBoard(tClip);
				}
				Debug.Print(tClip);
			}
			
			EmailSql = GeneratedSQL + "\r\n";
			if (bCopyToClipboard)
			{
				string tClip = "/* ContainsClause */ " + "\r\n";
				tClip += EmailSql;
				if (bSaveToClipBoard)
				{
					modGlobals.SetToClipBoard(tClip);
				}
				Debug.Print(tClip);
			}
			
			
			if (ContainsClause.Trim().Length > 0)
			{
				
				EmailSql = GeneratedSQL + "\r\n";
				EmailSql += " " + "\r\n" + WhereClause + "\r\n";
				
				if (bSaveToClipBoard)
				{
					modGlobals.SetToClipBoard(EmailSql);
				}
				
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
						
						if (ckWeighted == true)
						{
							IncludeEmailAttachmentsSearchWeighted(ckIncludeAttachments, ckWeighted, ckBusiness, txtSearch, ckLimitToExisting, txtThesaurus, cbThesaurusText, MinWeight);
						}
						else
						{
							IncludeEmailAttachmentsSearch(ckIncludeAttachments, ckWeighted, ckBusiness, txtSearch, ckLimitToExisting, txtThesaurus, cbThesaurusText, LibraryName, bIncludeAllLibs);
						}
						
						if (ckIncludeAttachments == true && ckLimitToLib == false)
						{
							//** ECM EmailAttachmentSearchList
							if (modGlobals.gMasterContentOnly == true)
							{
							}
							else
							{
								//IncludeEmailAttachmentsQry  = vbCrLf + " OR " + "([EmailGuid] in (select EmailGuid from EmailAttachmentSearchList where UserID = '" + gCurrUserGuidID + "'))" + vbCrLf
							}
							
							//EmailSql = EmailSql + vbCrLf + IncludeEmailAttachmentsQry  + vbCrLf
							EmailSql = EmailSql + genUseExistingRecordsOnly(UseExistingRecordsOnly, "EmailGuid");
							
							//Clipboard.Clear()
							//Clipboard.SetText(EmailSql)
						}
						//EmailSql += vbCrLf + " or isPublic = 'Y' "
						EmailSql += "\r\n" + " ORDER BY KEY_TBL.RANK DESC " + "\r\n";
						
					}
					else
					{
						string IncludeEmailAttachmentsQry = EmailSql + "\r\n";
						//If ckIncludeAttachments.Checked Then
						bool ckIncludeAttachments = true;
						IncludeEmailAttachmentsSearch(ckIncludeAttachments, ckWeighted, ckBusiness, txtSearch, ckLimitToExisting, txtThesaurus, cbThesaurusText, LibraryName, bIncludeAllLibs);
						//If ckIncludeAttachments = True And ckLimitToLib = False Then
						//    '** ECM EmailAttachmentSearchList
						//    If gMasterContentOnly = True Then
						//    Else
						//        IncludeEmailAttachmentsQry  = vbCrLf + " OR " + "([EmailGuid] in (select EmailGuid from EmailAttachmentSearchList where UserID = '" + gCurrUserGuidID + "'))" + vbCrLf
						//    End If
						
						//    EmailSql = EmailSql + vbCrLf + IncludeEmailAttachmentsQry  + vbCrLf
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
				string tClip = "/* Final */ " + "\r\n";
				tClip += EmailSql;
				if (bSaveToClipBoard)
				{
					modGlobals.SetToClipBoard(tClip);
				}
				//Debug.Print(tClip)
			}
			
			
			//txtSearch  = Nothing
			//getCountOnly = Nothing
			//UseExistingRecordsOnly = Nothing
			//ckWeighted = Nothing
			//GeneratedSQL = Nothing
			//isAdmin = Nothing
			//ckBusiness = Nothing
			
			
			ValidateNotClauses(ref EmailSql);
			DMA.ckFreetextRemoveOr(ref EmailSql, "freetext ((Body, Description, KeyWords, Subject, Attachment, Ocrtext)");
			DMA.ckFreetextRemoveOr(ref EmailSql, "freetext (body");
			DMA.ckFreetextRemoveOr(ref EmailSql, "freetext (subject");
			//SetToClipBoard(EmailSql)
			return EmailSql;
		}
		public void SubIn(ref string ParentString, string WhatToChange, string ChangeCharsToThis)
		{
			int I = 0;
			int J = 0;
			int M = 0;
			int N = 0;
			string S1 = "";
			string S2 = "";
			
			
			M = int.Parse(WhatToChange.Length);
			N = int.Parse(ChangeCharsToThis.Length);
			
			
			while (ParentString.IndexOf(WhatToChange) + 1 > 0)
			{
				I = ParentString.IndexOf(WhatToChange) + 1;
				S1 = ParentString.Substring(0, I - 1);
				S2 = ParentString.Substring(I + M - 1);
				string NewLine = S1 + ChangeCharsToThis + S2;
				ParentString = NewLine;
			}
		}
		public void SkipToNextToken(string S, ref int I)
		{
			string Delimiters = " ,:+-^|";
			S = S.Trim();
			string Token = "";
			string CH = "";
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
				Debug.Print(Token);
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
			string Token = "";
			string CH = "";
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
			
			
			if (CH == '\u0022')
			{
				Token = "";
				Token += '\u0022';
				I++;
				CH = S.Substring(I - 1, 1);
				KK = S.Length;
				while (!(CH == '\u0022' && I <= KK))
				{
					Token += CH;
					I++;
					CH = S.Substring(I - 1, 1);
					if (I > S.Length)
					{
						break;
					}
				}
				Token += '\u0022';
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
			string Token = "";
			string CH = "";
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
			
			
			if (CH == '\u0022')
			{
				Token = "";
				Token += '\u0022';
				I++;
				CH = S.Substring(I - 1, 1);
				KK = S.Length;
				while (!(CH == '\u0022' && I <= KK))
				{
					Token += CH;
					I++;
					CH = S.Substring(I - 1, 1);
					if (I > S.Length)
					{
						break;
					}
				}
				Token += '\u0022';
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
			string Alphabet = " |+-^";
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
			string Q = '\u0022';
			string CH = "";
			string Alphabet = " |+-^";
			string S = "";
			QuotedString = Q;
			i++;
			CH = tstr.Substring(i - 1, 1);
			while (CH != '\u0022' && i <= tstr.Length)
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
			string Q = '\u0022';
			string CH = "";
			string Alphabet = " |+-^";
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
			string Alphabet = " |+-^";
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
			string Alphabet = " |+-^";
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
			string Alphabet = "#|+-^~";
			if (Alphabet.IndexOf(CH) + 1 > 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		public string buildContainsSyntax(string SearchCriteria, ArrayList ThesaurusWords)
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
			
			
			ArrayList A = new ArrayList();
			int I = 0;
			int J = 0;
			string Ch = "";
			string tWord = "";
			int WordCnt = 0;
			bool isOr = false;
			bool isAnd = false;
			bool isNear = false;
			bool isPhrase = false;
			bool isAndNot = false;
			string Delimiters = " ,:";
			string DQ = '\u0022';
			bool FirstEntry = true;
			string QuotedString = "";
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
				if (Ch == '\u0022')
				{
					QuotedString = "";
					J = 0;
					GetQuotedString(SearchCriteria, ref I, J, ref QuotedString);
					if (QuotedString.Equals('\u0022' + '\u0022'))
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
					string SubstituteString = "FORMSOF (INFLECTIONAL, " + '\u0022' + "@" + '\u0022' + ")";
					I++;
					
					string ReturnedDelimiter = "";
					
					tWord = getNextToken(SearchCriteria, ref I, ref ReturnedDelimiter);
					string C = SearchCriteria.Substring(I - 1, 1);
					SubIn(ref SubstituteString, "@", tWord);
					tWord = SubstituteString;
					SubIn(ref tWord, (string) ('\u0022' + '\u0022'), '\u0022');
					
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
					string SubstituteString = "FORMSOF (THESAURUS, " + '\u0022' + "@" + '\u0022' + ")";
					I++;
					string ReturnedDelimiter = "";
					tWord = getNextToken(SearchCriteria, ref I, ref ReturnedDelimiter);
					SubIn(ref SubstituteString, "@", tWord);
					tWord = SubstituteString;
					SubIn(ref tWord, (string) ('\u0022' + '\u0022'), '\u0022');
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
					string SubstituteString = "FORMSOF (THESAURUS, " + '\u0022' + "@" + '\u0022' + ")";
					I++;
					string ReturnedDelimiter = "";
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
					string ReturnedDelimiter = "";
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
					if (A[II] == null)
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
							Console.WriteLine(II.ToString() + ":" + A[II].ToString());
						}
					}
				}
NextWord:
				1.GetHashCode() ; //VBConversions note: C# requires an executable line here, so a dummy line was added.
			}
			
			int XX = A.Count;
			for (XX = A.Count- 1; XX >= 0; XX--)
			{
				tWord = (string) (A[XX].trim);
				if (this.isKeyWord(tWord))
				{
					A.RemoveAt(XX);
				}
				else
				{
					break;
				}
			}
			string Stmt = "";
			for (I = 0; I <= A.Count - 1; I++)
			{
				if (I == A.Count - 1)
				{
					tWord = (string) (A[I].trim);
					if (this.isKeyWord(tWord))
					{
						if (dDeBug)
						{
							Console.WriteLine("Do nothing");
						}
					}
					else
					{
						Stmt = Stmt + " " + A[I];
						if (dDeBug)
						{
							Console.WriteLine(I.ToString() + ": " + Stmt);
						}
					}
				}
				else
				{
					Stmt = Stmt + " " + A[I];
					if (dDeBug)
					{
						Console.WriteLine(I.ToString() + ": " + Stmt);
					}
				}
				
			}
			return Stmt;
			
			
		}
		public string getThesaurusWords(ArrayList ThesaurusList, ArrayList ThesaurusWords)
		{
			
			string AllWords = "";
			string ThesaurusName = "";
			
			if (modGlobals.gThesauri.Count == 1)
			{
				for (int kk = 0; kk <= modGlobals.gThesauri.Count - 1; kk++)
				{
					ThesaurusName = modGlobals.gThesauri[kk].ToString();
					ThesaurusList.Add(ThesaurusName);
				}
				//FrmMDIMain.SB.Text = "Custom thesauri used"
			}
			else if (modGlobals.gThesauri.Count > 0)
			{
				for (int kk = 0; kk <= modGlobals.gThesauri.Count - 1; kk++)
				{
					ThesaurusName = modGlobals.gThesauri[kk].ToString();
					ThesaurusList.Add(ThesaurusName);
				}
				//FrmMDIMain.SB.Text = "Custom thesauri used"
			}
			
			string ListOfPhrases = "";
			ArrayList ExpandedWords = new ArrayList();
			
			if (ThesaurusList.Count == 0)
			{
				//** Get and use the default Thesaurus'
				if (modGlobals.gClipBoardActive)
				{
					Console.WriteLine("No thesauri specified - using default.");
				}
				//FrmMDIMain.SB.Text = "Default thesauri used"
				ThesaurusName = DB.getSystemParm("Default Thesaurus");
				if (ThesaurusName.Equals("NA"))
				{
					return "";
				}
				else
				{
					ThesaurusList.Add(ThesaurusName);
				}
			}
			
			//** Get and use the default Thesaurus
			foreach (string T in ThesaurusList)
			{
				ThesaurusName = T;
				string ThesaurusID = TREX.getThesaurusID(ThesaurusName);
				foreach (string token in ThesaurusWords)
				{
					if (! ExpandedWords.Contains(token))
					{
						ExpandedWords.Add(token);
					}
					TREX.getSynonyms(ThesaurusID, token, ExpandedWords, true);
				}
			}
			foreach (string SS in ExpandedWords)
			{
				string tWord = SS;
				tWord = tWord.Trim();
				if (tWord.IndexOf(('\u0022').ToString()) + 1 == 0)
				{
					tWord = (string) ('\u0022' + tWord + '\u0022');
				}
				ListOfPhrases = ListOfPhrases + '\t' + tWord + " or " + "\r\n";
			}
			if (ListOfPhrases == null)
			{
				return "";
			}
			else
			{
				ListOfPhrases = ListOfPhrases.Trim;
				ListOfPhrases = ListOfPhrases.Substring(0, ListOfPhrases.Length - 3);
				return ListOfPhrases;
			}
			
		}
		public bool ValidateContainsList(ref string ContainsList)
		{
			ContainsList = ContainsList.Trim;
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
		public string PopulateThesaurusList(ArrayList ThesaurusList, ref ArrayList ThesaurusWords, string txtThesaurus, string cbThesaurusText)
		{
			
			string[] A1 = new string[1];
			string[] A2 = new string[1];
			string Token = "";
			string ExpandedWords = "";
			
			if (txtThesaurus.IndexOf(",") + 1 > 0)
			{
				A1 = txtThesaurus.Split(",");
			}
			else
			{
				A1[0] = txtThesaurus;
			}
			
			for (int i = 0; i <= (A1.Length - 1); i++)
			{
				Token = A1[i].Trim();
				if (Token.IndexOf(('\u0022').ToString()) + 1 > 0)
				{
					ThesaurusWords.Add(Token);
				}
				else
				{
					A2 = Token.Split(" ".ToCharArray());
					for (int ii = 0; ii <= (A2.Length - 1); ii++)
					{
						ThesaurusWords.Add(A2[ii].Trim());
					}
				}
				
			}
			
			ExpandedWords = getThesaurusWords(ThesaurusList, ThesaurusWords);
			
			return ExpandedWords;
			
		}
		public string genContainsClause(string InputSearchString, bool useFreetext, bool ckWeighted, bool isEmail, bool LimitToCurrRecs, ArrayList ThesaurusList, string txtThesaurus, string cbThesaurusText, string calledBy)
		{
			
			string WhereClause = "";
			string S = "";
			//Dim ThesaurusList As New ArrayList
			ArrayList ThesaurusWords = new ArrayList();
			string ContainsClause = "";
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
					if (DB.isAdmin(modGlobals.gCurrUserGuidID) || DB.isGlobalSearcher(modGlobals.gCurrUserGuidID) == true)
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
						DB.RemoveFreetextStopWords(ref InputSearchString);
						if (InputSearchString.Length > 0 || txtThesaurus.Trim.Length > 0)
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
							
							if (txtThesaurus.Trim.Length > 0)
							{
								string ExpandedWordList = PopulateThesaurusList(ThesaurusList, ref ThesaurusWords, txtThesaurus, cbThesaurusText);
								if (ExpandedWordList.Trim.Length > 0)
								{
									WhereClause += (string) ("\r\n" + '\t' + cbThesaurusText + " FREETEXT ((Body, SUBJECT, KeyWords, Description), \'" + ExpandedWordList);
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
							
							if (txtThesaurus.Trim.Length > 0)
							{
								string ExpandedWordList = PopulateThesaurusList(ThesaurusList, ref ThesaurusWords, txtThesaurus, cbThesaurusText);
								if (ExpandedWordList.Trim.Length > 0)
								{
									WhereClause += (string) ("\r\n" + '\t' + " OR FREETEXT ((Body, SUBJECT, KeyWords, Description), \'" + ExpandedWordList);
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
						if (InputSearchString.Length > 0 || txtThesaurus.Trim.Length > 0)
						{
							WhereClause += " ( CONTAINS(BODY, \'";
							S = InputSearchString;
							WhereClause += buildContainsSyntax(S, ThesaurusWords);
							WhereClause += "\')   /*YY00a*/ " + "\r\n";
							
							lParens++;
							
							if (txtThesaurus.Trim.Length > 0)
							{
								string ExpandedWordList = PopulateThesaurusList(ThesaurusList, ref ThesaurusWords, txtThesaurus, cbThesaurusText);
								if (ExpandedWordList.Trim.Length > 0)
								{
									WhereClause = WhereClause + "\r\n";
									WhereClause += (string) ("\r\n" + '\t' + cbThesaurusText + " (CONTAINS (body, \'" + ExpandedWordList);
									WhereClause += "\')   /*YY00*/" + "\r\n";
									lParens++;
								}
							}
							
							WhereClause += " or CONTAINS(SUBJECT, \'";
							S = InputSearchString;
							WhereClause += buildContainsSyntax(S, ThesaurusWords);
							WhereClause += "\')   /*XX01*/" + "\r\n";
							
							if (txtThesaurus.Trim.Length > 0)
							{
								string ExpandedWordList = PopulateThesaurusList(ThesaurusList, ref ThesaurusWords, txtThesaurus, cbThesaurusText);
								if (ExpandedWordList.Trim.Length > 0)
								{
									WhereClause = WhereClause + "\r\n";
									WhereClause += (string) ("\r\n" + '\t' + cbThesaurusText + " (CONTAINS (subject, \'" + getThesaurusWords(ThesaurusList, ThesaurusWords));
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
						if (InputSearchString.Length > 0 || txtThesaurus.Trim.Length > 0)
						{
							DB.RemoveFreetextStopWords(ref InputSearchString);
							DB.RemoveFreetextStopWords(ref txtThesaurus);
							//WhereClause += " FREETEXT (SourceImage, '"
							//WhereClause += " FREETEXT (DataSource.*, '"
							WhereClause += " FREETEXT ((Description, KeyWords, Notes, SourceImage, SourceName), \'";
							S = InputSearchString;
							WhereClause += buildContainsSyntax(S, ThesaurusWords);
							WhereClause += "\')";
							
							if (txtThesaurus.Trim.Length > 0)
							{
								string ExpandedWordList = PopulateThesaurusList(ThesaurusList, ref ThesaurusWords, txtThesaurus, cbThesaurusText);
								if (ExpandedWordList.Trim.Length > 0)
								{
									//WhereClause += vbCrLf + Chr(9) + cbThesaurusText  + " freetext (SourceImage, '" + ExpandedWordList
									//WhereClause += vbCrLf + Chr(9) + cbThesaurusText  + " freetext (DataSource.*, '" + ExpandedWordList
									WhereClause += (string) ("\r\n" + '\t' + cbThesaurusText + " freetext ((Description, KeyWords, Notes, SourceImage, SourceName), \'" + ExpandedWordList);
									WhereClause += "\')" + "\r\n" + "/* 0A2 */ " + "\r\n";
									rParens++;
								}
							}
						}
					}
					else
					{
						if (InputSearchString.Length > 0 || txtThesaurus.Trim.Length > 0)
						{
							WhereClause += " (CONTAINS(SourceImage, \'";
							S = InputSearchString;
							WhereClause += buildContainsSyntax(S, ThesaurusWords);
							WhereClause += "\'))     /*XX03*/ ";
							
							if (txtThesaurus.Trim.Length > 0)
							{
								string ExpandedWordList = PopulateThesaurusList(ThesaurusList, ref ThesaurusWords, txtThesaurus, cbThesaurusText);
								if (ExpandedWordList.Trim.Length > 0)
								{
									WhereClause += (string) ("\r\n" + '\t' + cbThesaurusText + " CONTAINS (SourceImage, \'" + ExpandedWordList);
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
					if (DB.isAdmin(modGlobals.gCurrUserGuidID) || DB.isGlobalSearcher(modGlobals.gCurrUserGuidID) == true)
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
					if (InputSearchString.Length > 0 || txtThesaurus.Trim.Length > 0)
					{
						DB.RemoveFreetextStopWords(ref InputSearchString);
						DB.RemoveFreetextStopWords(ref txtThesaurus);
						
						WhereClause += " FREETEXT ((Body, SUBJECT, KeyWords, Description), \'";
						S = InputSearchString;
						WhereClause += buildContainsSyntax(S, ThesaurusWords);
						WhereClause += "\')" + "\r\n";
						
						if (txtThesaurus.Trim.Length > 0)
						{
							string ExpandedWordList = PopulateThesaurusList(ThesaurusList, ref ThesaurusWords, txtThesaurus, cbThesaurusText);
							if (ExpandedWordList.Trim.Length > 0)
							{
								WhereClause += (string) ("\r\n" + '\t' + cbThesaurusText + " FREETEXT ((Body, SUBJECT, KeyWords, Description), \'" + ExpandedWordList);
								WhereClause += "\')" + "\r\n" + "/* 0A4 */ " + "\r\n";
								rParens++;
							}
						}
						//WhereClause += ")  /* XX  Final Quotes */"
					}
				}
				else
				{
					if (InputSearchString.Length > 0 || txtThesaurus.Trim.Length > 0)
					{
						WhereClause += " CONTAINS(*, \'";
						S = InputSearchString;
						WhereClause += buildContainsSyntax(S, ThesaurusWords);
						WhereClause += "\')     /*XX04*/ ";
						
						if (txtThesaurus.Trim.Length > 0)
						{
							string ExpandedWordList = PopulateThesaurusList(ThesaurusList, ref ThesaurusWords, txtThesaurus, cbThesaurusText);
							if (ExpandedWordList.Trim.Length > 0)
							{
								WhereClause += (string) ("\r\n" + '\t' + cbThesaurusText + " CONTAINS (*, \'" + ExpandedWordList);
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
			string CH = "";
			
			
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
			ArrayList A = new ArrayList();
			string CH = "";
			string Token = "";
			string S = "";
			bool SkipNextToken = false;
			for (I = 1; I <= SearchText.Trim().Length; I++)
			{
REEVAL:
				CH = SearchText.Substring(I - 1, 1);
				if (CH.Equals('\u0022'))
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
					while (CH != '\u0022' && I <= SearchText.Length)
					{
						I++;
						CH = SearchText.Substring(I - 1, 1);
						Token += CH;
					}
					//Token = Chr(34) + Token
					if (PreceedingPlusSign == true)
					{
						Token = (string) ("+" + '\u0022' + Token);
						//Dim NextChar  = getNextChar(SearchText , I)
						//If NextChar  = "-" Then
						//    '** We skip the next token in the stmt
						//End If
					}
					else if (PreceedingMinusSign == true)
					{
						Token = (string) ("-" + '\u0022' + Token);
						//Dim NextChar  = getNextChar(SearchText , I)
						//If NextChar  = "+" Then
						//    '** We skip the next token in the stmt
						//End If
					}
					else
					{
						Token = (string) ('\u0022' + Token);
					}
					A.Add(Token);
					
					
					Token = "";
				}
				else if (CH.Equals(" ") || CH == " ")
				{
					//** Skip the blank spaces
					if (Token.Equals("+") || Token.Equals("-"))
					{
						Debug.Print("Should not be here.");
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
					string NextChar = getNextChar(SearchText, I);
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
					string NextChar = getNextChar(SearchText, I);
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
				string tWord = A[I];
				tWord = tWord.ToUpper();
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
							S = S + A[I].ToString();
						}
						else
						{
							S = S + A[I].ToString() + ", ";
						}
						if (dDeBug)
						{
							Debug.Print(S);
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
			string isAboutClause = "";
			string SearchStr = SearchText;
			string CorrectedSearchClause = CleanIsAboutSearchText(SearchText);
			CorrectedSearchClause = CorrectedSearchClause.Trim;
			if (CorrectedSearchClause.Length > 2)
			{
				string C = CorrectedSearchClause.Substring(CorrectedSearchClause.Length - 1, 1);
				if (C.Equals(","))
				{
					CorrectedSearchClause = CorrectedSearchClause.Substring(0, CorrectedSearchClause.Length - 1);
					CorrectedSearchClause = CorrectedSearchClause.Trim;
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
			string s = "Select * from sysobjects where xtype = \'U\'";
			return s;
		}
		public SqlDataReader getAllColsSql(string TblID)
		{
			string s = "Select C.name, C.column_id, ";
			s = s + " C.system_type_id , C.max_length, ";
			s = s + " C.precision, C.scale, C.is_nullable,";
			s = s + " C.is_identity, T.name  ";
			s = s + " from sys.objects T,  sys.columns C";
			s = s + " where T.type = \'U\' and";
			s = s + " C.object_id = T.object_id and";
			s = s + " T.object_id = " + TblID + " ";
			s = s + " order by C.column_id";
			
			
			SqlDataReader rsData = null;
			
			
			try
			{
				string CS = DB.getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(s, CONN);
				rsData = command.ExecuteReader();
			}
			catch (Exception ex)
			{
				if (dDeBug)
				{
					Console.WriteLine("Exception Type: {0}", ex.GetType());
				}
				if (dDeBug)
				{
					Console.WriteLine("  Message: {0}", ex.Message);
				}
				if (dDeBug)
				{
					Console.WriteLine(s);
				}
				Clipboard.Clear();
				if (dDeBug)
				{
					modGlobals.SetToClipBoard(s);
				}
				if (dDeBug)
				{
					Console.WriteLine(" SQL in clipboard", s);
				}
				Debug.Print(" SQL in clipboard", s);
				MessageBox.Show(ex.Message);
				LOG.WriteToArchiveLog((string) ("clsSql : getAllColsSql : 677 : " + ex.Message));
			}
			return rsData;
		}
		public string genAdminContentSql(bool isAdmin, bool ckLimitToLib, string LibraryName)
		{
			string UserSql = "";
			LibraryName = UTIL.RemoveSingleQuotes(LibraryName);
			if (DB.isAdmin(modGlobals.gCurrUserGuidID) || DB.isGlobalSearcher(modGlobals.gCurrUserGuidID) == true)
			{
				//** ECM WhereClause
				if (ckLimitToLib == true)
				{
					//UserSql = UserSql + " AND SourceGuid in (SELECT [SourceGuid] FROM [LibraryItems] where LibraryName = '" + LibraryName  + "')" + vbCrLf
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
						if (DB.isAdmin(modGlobals.gCurrUserGuidID) == true || DB.isGlobalSearcher(modGlobals.gCurrUserGuidID) == true)
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
					if (DB.isAdmin(modGlobals.gCurrUserGuidID) == true || DB.isGlobalSearcher(modGlobals.gCurrUserGuidID) == true)
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
						if (DB.isAdmin(modGlobals.gCurrUserGuidID) == true || DB.isGlobalSearcher(modGlobals.gCurrUserGuidID) == true)
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
				///** Removed by WDM 7/12/2008
				//UserSql = UserSql + " OR DataSourceOwnerUserID in (select distinct UserID from LibraryUsers " + vbCrLf
				//UserSql = UserSql + "             where(LibraryName)" + vbCrLf
				//UserSql = UserSql + " in (Select LibraryName from LibrariesContainingUser))" + vbCrLf
				//UserSql = UserSql + " )" + vbCrLf
			}
			return UserSql;
		}
		public string genAdminEmailSql(bool isAdmin, bool ckLimitToLib, string LibraryName)
		{
			string UserSql = "";
			modGlobals.isGlobalSearcher = DB.isGlobalSearcher(modGlobals.gCurrUserGuidID);
			if (DB.isAdmin(modGlobals.gCurrUserGuidID) || DB.isGlobalSearcher(modGlobals.gCurrUserGuidID) == true)
			{
				//** ECM WhereClause
				if (ckLimitToLib == true)
				{
					//** DO NOT PUT vbcrlf at the end of the below lines. That will cause problems in inserting PAGING.
					bool gSearcher = false;
					if (DB.isAdmin(modGlobals.gCurrUserGuidID) == true || DB.isGlobalSearcher(modGlobals.gCurrUserGuidID) == true)
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
						if (DB.isAdmin(modGlobals.gCurrUserGuidID) == true || DB.isGlobalSearcher(modGlobals.gCurrUserGuidID) == true)
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
				///** Removed by WDM 7/12/2008
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
					if (DB.isAdmin(modGlobals.gCurrUserGuidID) == true || DB.isGlobalSearcher(modGlobals.gCurrUserGuidID) == true)
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
						if (DB.isAdmin(modGlobals.gCurrUserGuidID) == true || DB.isGlobalSearcher(modGlobals.gCurrUserGuidID) == true)
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
			string DocsSql = "";
			
			
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
		
		public void MergeEmailAttachments(bool ckWeighted, string Weight, DataSet DS, bool PaginateData, int LowerPageNbr, int UpperPageNbr)
		{
			if (PaginateData == true && LowerPageNbr > 1)
			{
				return;
			}
			
			string S = "";
			if (ckWeighted == true)
			{
				if (PaginateData == true)
				{
					S = S + " SELECT     Email.SentOn, Email.ShortSubj, Email.SenderEmailAddress, Email.SenderName, Email.SentTO, SUBSTRING(Email.Body, 1, 100) AS Body, Email.CC, Email.Bcc, " + "\r\n";
					S = S + "                       Email.CreationTime, Email.AllRecipients, Email.ReceivedByName, Email.ReceivedTime, Email.MsgSize, Email.SUBJECT, Email.OriginalFolder, Email.EmailGuid, " + "\r\n";
					S = S + "                       Email.RetentionExpirationDate, Email.isPublic,  \' \' as ConvertEmailToMsg, Email.UserID, Email.NbrAttachments, Email.SourceTypeCode, \'Y\' AS FoundInAttachment, " + "\r\n";
					S = S + "                       CONVERT(varchar, EmailAttachment.RowID) AS RID, EmailAttachment.RepoSvrName, 9999999 as RowID  " + "\r\n";
					S = S + " FROM         Email INNER JOIN" + "\r\n";
					S = S + "                       EmailAttachmentSearchList ON Email.EmailGuid = EmailAttachmentSearchList.EmailGuid INNER JOIN" + "\r\n";
					S = S + "                       EmailAttachment ON EmailAttachmentSearchList.EmailGuid = EmailAttachment.EmailGuid AND EmailAttachmentSearchList.RowID = EmailAttachment.RowID" + "\r\n";
					S = S + " WHERE     (EmailAttachmentSearchList.UserID = \'" + modGlobals.gCurrUserGuidID + "\')" + "\r\n";
				}
				else
				{
					S = "Select     EmailAttachmentSearchList.Weight AS RANK, Email.SentOn, Email.ShortSubj, Email.SenderEmailAddress, Email.SenderName, Email.SentTO, ";
					S = S + "                       SUBSTRING(Email.Body, 1, 100) AS Body, Email.CC, Email.Bcc, Email.CreationTime, Email.AllRecipients, Email.ReceivedByName, Email.ReceivedTime, ";
					S = S + "                       Email.MsgSize, Email.SUBJECT, Email.OriginalFolder, Email.EmailGuid, Email.RetentionExpirationDate, Email.isPublic, \' \' as ConvertEmailToMsg, Email.UserID, Email.NbrAttachments, ";
					S = S + "                       Email.SourceTypeCode, \'Y\' AS FoundInAttachment, CONVERT(varchar, EmailAttachment.RowID) AS RID";
					S = S + " FROM         Email INNER JOIN";
					S = S + "                       EmailAttachmentSearchList ON Email.EmailGuid = EmailAttachmentSearchList.EmailGuid INNER JOIN";
					S = S + "                       EmailAttachment ON EmailAttachmentSearchList.EmailGuid = EmailAttachment.EmailGuid AND EmailAttachmentSearchList.RowID = EmailAttachment.RowID";
					S = S + " WHERE     (EmailAttachmentSearchList.UserID = \'" + modGlobals.gCurrUserGuidID + "\') AND (EmailAttachmentSearchList.Weight >= 0)";
				}
			}
			else
			{
				if (PaginateData == true)
				{
					S = S + " SELECT     Email.SentOn, Email.ShortSubj, Email.SenderEmailAddress, Email.SenderName, Email.SentTO, SUBSTRING(Email.Body, 1, 100) AS Body, Email.CC, Email.Bcc, " + "\r\n";
					S = S + "                       Email.CreationTime, Email.AllRecipients, Email.ReceivedByName, Email.ReceivedTime, Email.MsgSize, Email.SUBJECT, Email.OriginalFolder, Email.EmailGuid, " + "\r\n";
					S = S + "                       Email.RetentionExpirationDate, Email.isPublic,  \' \' as ConvertEmailToMsg, Email.UserID, Email.NbrAttachments, Email.SourceTypeCode, \'Y\' AS FoundInAttachment, " + "\r\n";
					S = S + "                       CONVERT(varchar, EmailAttachment.RowID) AS RID, EmailAttachment.RepoSvrName, 9999999 as RowID  " + "\r\n";
					S = S + " FROM         Email INNER JOIN" + "\r\n";
					S = S + "                       EmailAttachmentSearchList ON Email.EmailGuid = EmailAttachmentSearchList.EmailGuid INNER JOIN" + "\r\n";
					S = S + "                       EmailAttachment ON EmailAttachmentSearchList.EmailGuid = EmailAttachment.EmailGuid AND EmailAttachmentSearchList.RowID = EmailAttachment.RowID" + "\r\n";
					S = S + " WHERE     (EmailAttachmentSearchList.UserID = \'" + modGlobals.gCurrUserGuidID + "\')" + "\r\n";
				}
				else
				{
					S = S + " SELECT     Email.SentOn, Email.ShortSubj, Email.SenderEmailAddress, Email.SenderName, Email.SentTO, SUBSTRING(Email.Body, 1, 100) AS Body, Email.CC, Email.Bcc, " + "\r\n";
					S = S + "                       Email.CreationTime, Email.AllRecipients, Email.ReceivedByName, Email.ReceivedTime, Email.MsgSize, Email.SUBJECT, Email.OriginalFolder, Email.EmailGuid, " + "\r\n";
					S = S + "                       Email.RetentionExpirationDate, Email.isPublic,  \' \' as ConvertEmailToMsg, Email.UserID, Email.NbrAttachments, Email.SourceTypeCode, \'Y\' AS FoundInAttachment, " + "\r\n";
					S = S + "                       CONVERT(varchar, EmailAttachment.RowID) AS RID, EmailAttachment.RepoSvrName  " + "\r\n";
					S = S + " FROM         Email INNER JOIN" + "\r\n";
					S = S + "                       EmailAttachmentSearchList ON Email.EmailGuid = EmailAttachmentSearchList.EmailGuid INNER JOIN" + "\r\n";
					S = S + "                       EmailAttachment ON EmailAttachmentSearchList.EmailGuid = EmailAttachment.EmailGuid AND EmailAttachmentSearchList.RowID = EmailAttachment.RowID" + "\r\n";
					S = S + " WHERE     (EmailAttachmentSearchList.UserID = \'" + modGlobals.gCurrUserGuidID + "\')" + "\r\n";
				}
				
			}
			
			//Clipboard.Clear()
			//Clipboard.SetText(S)
			
			if (modGlobals.gHiveEnabled == true)
			{
				if (modGlobals.gHiveServersList.Count > 0)
				{
					UTIL.AddHiveSearch(ref S, modGlobals.gHiveServersList);
					Clipboard.Clear();
					Clipboard.SetText(S);
				}
			}
			
			if (modGlobals.gClipBoardActive == true)
			{
				Clipboard.Clear();
			}
			if (modGlobals.gClipBoardActive == true)
			{
				Clipboard.SetText(S);
			}
			if (modGlobals.gClipBoardActive == true)
			{
				MessageBox.Show("Email Attachments SQL in clipboard.");
			}
			
			string CS = DB.getGateWayConnStr(modGlobals.gGateWayID);
			System.Data.SqlClient.SqlConnection sqlConn = new System.Data.SqlClient.SqlConnection(CS);
			DataSet dsAttach = new DataSet();
			System.Data.SqlClient.SqlDataAdapter SQLAdapter = new System.Data.SqlClient.SqlDataAdapter(S, CS);
			//sadapt.Fill(ds, "Email")
			SQLAdapter.Fill(dsAttach, "Email");
			
			DS.Merge(dsAttach);
			
		}
		public string getEmailTblColsMainSearch(bool ckWeighted, bool ckBusiness, string SearchText)
		{
			string GenSql = "";
			
			
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
				GenSql = GenSql + " ,[EmailGuid], RetentionExpirationDate, isPublic, ConvertEmlToMSG, UserID, NbrAttachments, SourceTypeCode, \'N\' as FoundInAttachment, \' \' as RID, RepoSvrName   " + "\r\n";
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
				SearchSql = SearchSql + " ,DS.EmailGuid, DS.RetentionExpirationDate, DS.isPublic, DS.UserID, DS.SourceTypeCode, DS.NbrAttachments , \' \' as RID, RepoSvrName  " + "\r\n";
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
				SearchSql = SearchSql + " ,[EmailGuid], RetentionExpirationDate, isPublic, UserID, SourceTypeCode, NbrAttachments, \' \' as RID, RepoSvrName " + "\r\n";
				SearchSql = SearchSql + " FROM EMAIL " + "\r\n";
			}
			return SearchSql;
		}
		public string xgenHeader()
		{
			string DocsSql = "WITH LibrariesContainingUser (LibraryName) AS" + "\r\n";
			DocsSql += " (" + "\r\n";
			DocsSql += "    select LibraryName from LibraryUsers L1 where userid = \'" + modGlobals.gCurrUserGuidID + "\' " + "\r\n";
			DocsSql += " )" + "\r\n";
			return DocsSql;
		}
		public string genContenCountSql()
		{
			string DocsSql = "Select count(*) " + "\r\n";
			DocsSql += "FROM DataSource " + "\r\n";
			return DocsSql;
		}
		public string genEmailCountSql()
		{
			string DocsSql = "Select count(*) " + "\r\n";
			DocsSql += "FROM [email] " + "\r\n";
			return DocsSql;
		}
		public string genUseExistingRecordsOnly(bool bUseExisting, string GuidColName)
		{
			if (bUseExisting == false)
			{
				return "";
			}
			string DocsSql = " and " + GuidColName + " in (SELECT [DocGuid] FROM ActiveSearchGuids where  UserID = \'" + modGlobals.gCurrUserGuidID + "\')" + "\r\n";
			return DocsSql;
		}
		public string genSelectEmailCounts(bool ckWeighted)
		{
			string SearchSql = "";
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
				bool BB = DB.ExecuteSqlNewConn(SS, false);
				if (! BB)
				{
					MessageBox.Show("Failed to initialize Attachment Content Search. Content search is not included in the results.");
				}
				else
				{
					
					string EmailContentWhereClause = "";
					string insertSql = "";
					
					EmailContentWhereClause = genContainsClause(SearchText, ckBusiness, ckWeighted, true, ckLimitToExisting, ThesaurusList, txtThesaurus, cbThesaurusText, "EMAIL");
					
					isAdmin = DB.isAdmin(modGlobals.gCurrUserGuidID);
					
					if (! DB.isAdmin(modGlobals.gCurrUserGuidID) && DB.isGlobalSearcher(modGlobals.gCurrUserGuidID) == false)
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
						// or EmailGuid in (SELECT EmailGuid FROM EmailAttachmentSearchList where userid = 'wmiller')
						//If LibraryName.Trim.Length > 0 Then
						//    'DO SOMETHING - EVEN IF IT IS WRONG <WRITTEN BY STUPIDOUS MAXIMUS> 03/10/2008
						//    LibraryName = UTIL.RemoveSingleQuotes(LibraryName)
						//    insertSql = insertSql + genSingleLibrarySelect(EmailContentWhereClause , LibraryName )
						//ElseIf bIncludeAllLibs = True Then
						//    insertSql = insertSql + vbCrLf + Chr(9) + genAllLibrariesSelect(EmailContentWhereClause )
						//    'Else
						//    '    If isAdmin Then
						//    '        insertSql = insertSql + vbCrLf + genAttachmentSearchSQLAdmin(EmailContentWhereClause )
						//    '    Else
						//    '        insertSql = insertSql + vbCrLf + genAttachmentSearchSQLUser(EmailContentWhereClause )
						//    '    End If
						//End If
					}
					else
					{
						SearchEmailAttachments(ref insertSql, false);
						//AND EmailGuid in (SELECT [SourceGuid] FROM [LibraryItems] where LibraryName = 'Chicago Lib')
						//If LibraryName.Trim.Length > 0 Then
						//    'DO SOMETHING - EVEN IF IT IS WRONG <WRITTEN BY STUPIDOUS MAXIMUS> 03/10/2008
						//    LibraryName = UTIL.RemoveSingleQuotes(LibraryName)
						//    insertSql = insertSql + genSingleLibrarySelect(EmailContentWhereClause , LibraryName )
						//ElseIf bIncludeAllLibs = True Then
						//    insertSql = insertSql + vbCrLf + Chr(9) + genAllLibrariesSelect(EmailContentWhereClause )
						//    'Else
						//    '    If isAdmin Then
						//    '        insertSql = insertSql + vbCrLf + genAttachmentSearchSQLAdmin(EmailContentWhereClause )
						//    '    Else
						//    '        insertSql = insertSql + vbCrLf + genAttachmentSearchSQLUser(EmailContentWhereClause )
						//    '    End If
						//End If
						
					}
					
					if (! DB.isAdmin(modGlobals.gCurrUserGuidID) && DB.isGlobalSearcher(modGlobals.gCurrUserGuidID) == false)
					{
						//** If not an ADMIN, then limit to USER content only
						insertSql = insertSql + "\r\n" + " AND UserID = \'" + modGlobals.gCurrUserGuidID + "\' ";
					}
					
					if (modGlobals.gClipBoardActive == true)
					{
						Clipboard.Clear();
					}
					if (modGlobals.gClipBoardActive == true)
					{
						Clipboard.SetText(insertSql);
					}
					
					BB = DB.ExecuteSqlNewConn(insertSql, false);
					
					if (! BB)
					{
						LOG.WriteToArchiveLog("clsSQl:IncludeEmailAttachmentsSearch : Failed to insert Attachment Content Search. Content search is not included in the results.");
						LOG.WriteToArchiveLog((string) ("clsSQl:IncludeEmailAttachmentsSearch : The SQL Stmt: " + insertSql));
						modGlobals.NbrOfErrors++;
						//FrmMDIMain.SB.Text = "Errors: " + NbrOfErrors.ToString
					}
					
					
				}
			}
		}
		public void IncludeEmailAttachmentsSearchWeighted(bool ckIncludeAttachments, bool ckWeighted, bool ckBusiness, string SearchText, bool ckLimitToExisting, string txtThesaurus, string cbThesaurusText, int MinWeight)
		{
			if (ckIncludeAttachments)
			{
				string SS = "delete FROM [EmailAttachmentSearchList] where [UserID] = \'" + modGlobals.gCurrUserGuidID + "\'";
				bool BB = DB.ExecuteSqlNewConn(SS, false);
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
					
					LOG.WriteToAttachmentSearchyLog("EmailAttachmentsSearch Weighted: " + insertSql + "\r\n" + "\r\n");
					
					Clipboard.Clear();
					Clipboard.SetText(insertSql);
					
					BB = DB.ExecuteSqlNewConn(insertSql, false);
					if (! BB)
					{
						LOG.WriteToArchiveLog("clsSQl:IncludeEmailAttachmentsSearch : Failed to insert Attachment Content Search. Content search is not included in the results.");
						LOG.WriteToArchiveLog((string) ("clsSQl:IncludeEmailAttachmentsSearch : The SQL Stmt: " + insertSql));
						modGlobals.NbrOfErrors++;
						//FrmMDIMain.SB.Text = "Errors: " + NbrOfErrors.ToString
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
				CorrectedSearchClause = CorrectedSearchClause.Trim;
				if (CorrectedSearchClause.Length > 2)
				{
					string C = CorrectedSearchClause.Substring(CorrectedSearchClause.Length - 1, 1);
					if (C.Equals(","))
					{
						CorrectedSearchClause = CorrectedSearchClause.Substring(0, CorrectedSearchClause.Length - 1);
						CorrectedSearchClause = CorrectedSearchClause.Trim;
					}
				}
				
				//CorrectedSearchClause  = UTIL.RemoveOcrProblemChars(CorrectedSearchClause )
				
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
					if (modGlobals.gClipBoardActive == true)
					{
						Clipboard.Clear();
					}
					if (modGlobals.gClipBoardActive == true)
					{
						Clipboard.SetText(ContainsClause);
					}
					return;
				}
				
				S = ContainsClause;
				I = 0;
				I = S.IndexOf("(") + 1;
				StringType.MidStmtStr(ref ContainsClause, I, 1, " ");
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
				if (modGlobals.gClipBoardActive == true)
				{
					Clipboard.Clear();
				}
				if (modGlobals.gClipBoardActive == true)
				{
					Clipboard.SetText(ContainsClause);
				}
			}
			catch (Exception ex)
			{
				Console.WriteLine(ex.Message);
			}
		}
		
		public void ParseSearchString(ref ArrayList A, string S)
		{
			int I = 0;
			int J = 0;
			int K = S.Trim().Length;
			string S1 = "";
			string S2 = "";
			string CH = "";
			string Token = "";
			
			S = S.Trim;
			
			for (I = 1; I <= K; I++)
			{
reeval:
				CH = S.Substring(I - 1, 1);
				if (CH == '\u0022')
				{
					Token += CH;
					I++;
					CH = S.Substring(I - 1, 1);
					while (CH != '\u0022' && I <= K)
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
			
			string T1 = "";
			string P1 = "";
			
			for (I = 0; I <= A.Count - 1; I++)
			{
				if (dDeBug)
				{
					Console.WriteLine(A[I]);
				}
				T1 = A[I];
				if (P1.Equals("-") && T1.Equals("+"))
				{
					A[I - 1] = "+" && A[I] == "-";
				}
				if (P1.Equals("NOT") && T1.Equals("AND"))
				{
					A[I - 1] = "AND" && A[I] == "NOT";
				}
				if (P1.Equals("-") && T1.Equals("AND"))
				{
					A[I - 1] = "AND" && A[I] == "NOT";
				}
				if (P1.Equals("NOT") && T1.Equals("+"))
				{
					A[I - 1] = "AND" && A[I] == "NOT";
				}
				P1 = T1;
			}
		}
		public void RebuildString(ArrayList A, ref string S)
		{
			
			int I = 0;
			int J = 0;
			
			string S1 = "";
			string S2 = "";
			string CH = "";
			string Token = "";
			string PrevToken = "";
			string PrevSymbol = "";
			string CurrSymbol = "";
			bool CurrSymbolIsKeyWord = false;
			bool PrevSymbolIsKeyWord = false;
			bool OrMayBeNeeded = false;
			
			S = "";
			
			for (I = 0; I <= A.Count - 1; I++)
			{
				if (dDeBug)
				{
					Console.WriteLine(A[I]);
				}
				Token = A[I];
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
				else if (Token.ToUpper() == Strings.Chr(254))
				{
					CurrSymbol = Strings.Chr(254);
					Token = "";
					OrMayBeNeeded = true;
				}
				else
				{
					CurrSymbol = "";
					CurrSymbol = "";
					Token = A[I];
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
				if (PrevSymbol == Strings.Chr(254) && CurrSymbol == Strings.Chr(254))
				{
					//** Skip this line
					goto ProcessNextToken;
				}
				if (PrevSymbol == Strings.Chr(254) && CurrSymbolIsKeyWord)
				{
					S = S.Trim() + " " + Token;
					goto ProcessNextToken;
				}
				if (PrevSymbol == Strings.Chr(254) && CurrSymbolIsKeyWord == false)
				{
					S = S + " Or " + Token;
					
				}
				if (PrevSymbol == Strings.Chr(254) && CurrSymbolIsKeyWord == false)
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
				if (CurrSymbolIsKeyWord == true && CurrSymbol == Strings.Chr(254))
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
			
			S = S.Trim;
		}
		public bool CountDoubleQuotes(string S)
		{
			S = S.Trim;
			if (S.Trim().Length == 0)
			{
				return true;
			}
			int I = 0;
			string CH = "";
			int iCnt = 0;
			if (S.IndexOf(('\u0022').ToString()) + 1 == 0)
			{
				return true;
			}
			for (I = 1; I <= S.Trim().Length; I++)
			{
				CH = S.Substring(I - 1, 1);
				if (CH.Equals('\u0022'))
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
			bool B = false;
			try
			{
				int I = 0;
				string S1 = "";
				string S2 = "";
				string CH = "";
				ArrayList aList = new ArrayList();
				int K = K;
				
				ParseSearchString(ref aList, S);
				RebuildString(aList, ref S);
				
reeval:
				K = S.Trim().Length;
				string NewStr = "";
				
				for (I = 1; I <= K; I++)
				{
					string CurrChar = S.Substring(I - 1, 1);
EvalCurrChar:
					string PrevChar = "";
					if (I > 1)
					{
						PrevChar = S.Substring(I - 1 - 1, 1);
					}
					else
					{
					}
					if (CurrChar.Equals('\u0022'))
					{
						NewStr += CurrChar;
						I++;
						CurrChar = S.Substring(I - 1, 1);
						while (CurrChar != '\u0022' && I <= S.Trim().Length)
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
							NewStr += Strings.Chr(254);
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
							NewStr += Strings.Chr(254);
							I++;
							CurrChar = S.Substring(I - 1, 1);
						}
						goto EvalCurrChar;
					}
					
					if (CurrChar.Equals("+") && PrevChar.Equals("-"))
					{
						StringType.MidStmtStr(ref S, I, 1, "-");
						StringType.MidStmtStr(ref S, I - 1, 1, "+");
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
					if (CurrChar.Equals(")") && (PrevChar.Equals(" ") || PrevChar.Equals(Strings.Chr(254))))
					{
						string C = "";
						int II = NewStr.Length;
						C = S.Substring(II - 1, 1);
						while ((C.Equals(" ") || C.Equals(Strings.Chr(254))) && II > 0)
						{
							StringType.MidStmtStr(ref NewStr, II, 1, Strings.Chr(254));
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
				NewStr = DMA.RemoveChar(NewStr, Strings.Chr(254));
				S = NewStr;
			}
			catch (Exception)
			{
				
			}
			
			
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
			ArrayList aList = new ArrayList();
			for (I = 1; I <= SqlText.Length; I++)
			{
				CH = SqlText.Substring(I - 1, 1);
				if (CH == '\u0022')
				{
					I++;
					CH = SqlText.Substring(I - 1, 1);
					while (CH != '\u0022' && I <= SqlText.Length)
					{
						I++;
						CH = SqlText.Substring(I - 1, 1);
					}
				}
				else if (CH == " ")
				{
					StringType.MidStmtStr(ref SqlText, I, 1, Strings.Chr(254));
				}
			}
			string[] A = SqlText.Split(Strings.Chr(254).ToString().ToCharArray());
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
					//    Debug.Print("nothing")
					//    Dim X# = 1
					//Else
					string tWord = aList[I];
					string EOL = "";
					switch (tWord.ToLower())
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
					if (tWord.IndexOf(",") + 1 > 0)
					{
						EOL = "\r\n" + "\t";
					}
					if (tWord.IndexOf("not") + 1 > 0)
					{
						double x = 1;
					}
					if (I == 0)
					{
						SqlText += EOL + aList[0].Trim;
					}
					else
					{
						SqlText += (string) (" " + EOL + aList[I].Trim);
					}
					//End If
				}
				catch (Exception ex)
				{
					LOG.WriteToArchiveLog(ex.Message);
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
				B = DB.ExecuteSqlNewConn(S);
				if (B)
				{
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
					B = DB.ExecuteSqlNewConn(S);
					
					if (modGlobals.gClipBoardActive == true)
					{
						Clipboard.Clear();
					}
					if (modGlobals.gClipBoardActive == true)
					{
						Clipboard.SetText(S);
					}
					
				}
			}
			catch (Exception ex)
			{
				B = false;
				LOG.WriteToArchiveLog((string) ("ERROR genIsInLibrariesSql: " + ex.Message + "\r\n" + S));
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
			
		}
		
		public void AddPaging(int StartPageNo, int EndPageNo, ref string SqlQuery, bool bIncludeLibraryFilesInSearch)
		{
			
			bool WeightedSearch = false;
			List<string> L = new List<string>();
			
			string[] A = SqlQuery.Split("\r\n".ToCharArray());
			string S = SqlQuery;
			bool xContentAdded = false;
			bool ContainsUnion = false;
			bool ContainsLimitToLibrary = false;
			
			//gClipBoardActive = True
			if (modGlobals.gClipBoardActive == true)
			{
				Clipboard.Clear();
			}
			if (modGlobals.gClipBoardActive == true)
			{
				Clipboard.SetText(SqlQuery);
			}
			if (modGlobals.gClipBoardActive == true)
			{
				MessageBox.Show("Step3: ADD Pagination STARTING Query in clipboard.");
			}
			int iSelect = 0;
			
			for (int i = 0; i <= (A.Length - 1); i++)
			{
				S = A[i].Trim();
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
					L.Add('\t' + S + "\r\n");
					goto NEXTLINE;
				}
				
				if (S.IndexOf("EmailAttachmentSearchList") + 1 > 0)
				{
					//Console.WriteLine("Here xx0011")
					L.Add('\t' + S + "\r\n");
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
					S = (string) ('\t' + "/* " + S + " */" + "\r\n" + '\t' + "/* above commented out by Pagination Module */");
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
					S = (string) ('\t' + S);
					L.Add('\t' + S + "\r\n");
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
						L.Add('\t' + ",ROW_NUMBER() OVER (ORDER BY Rank DESC) AS ROWID" + "\r\n");
					}
					else
					{
						L.Add('\t' + ",ROW_NUMBER() OVER (ORDER BY SourceName ASC) AS ROWID" + "\r\n");
					}
					
					L.Add(S + "\r\n");
				}
				else if (S.IndexOf("FROM EMAIL") + 1 > 0)
				{
					if (WeightedSearch == true)
					{
						L.Add('\t' + ",ROW_NUMBER() OVER (ORDER BY Rank DESC) AS ROWID" + "\r\n");
					}
					else
					{
						L.Add('\t' + ",ROW_NUMBER() OVER (ORDER BY SentOn ASC) AS ROWID" + "\r\n");
					}
					
					L.Add(S + "\r\n");
				}
				else if (ContainsUnion == false && ('\t' + S).ToString().IndexOf("order by") + 1 > 0)
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
				else if (ContainsUnion == true && ('\t' + S).ToString().IndexOf("order by [SourceName]") + 1 > 0)
				{
					//If WeightedSearch = False Then
					S = (string) ("--" + S);
				}
				else
				{
					L.Add('\t' + S + "\r\n");
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
			
			if (modGlobals.gClipBoardActive == true)
			{
				Clipboard.Clear();
			}
			if (modGlobals.gClipBoardActive == true)
			{
				Clipboard.SetText(SqlQuery);
			}
			if (modGlobals.gClipBoardActive == true)
			{
				Console.WriteLine("HERE 222");
			}
			if (modGlobals.gClipBoardActive == true)
			{
				MessageBox.Show("Step4: ADD Pagination in clipboard.");
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
			
			string AllLibSql = "";
			
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
			
			//S = S + " and EmailGuid in (SELECT [SourceGuid] FROM [LibraryItems] where LibraryName = '" + LibraryName  + "')"
			//** DO NOT PUT vbcrlf at the end of the below lines. That will cause problems in inserting PAGING.
			bool gSearcher = false;
			if (DB.isAdmin(modGlobals.gCurrUserGuidID) == true || DB.isGlobalSearcher(modGlobals.gCurrUserGuidID) == true)
			{
				gSearcher = true;
			}
			
			S = S + " AND EmailGuid in (" + GEN.genLibrarySearch(modGlobals.gCurrUserGuidID, gSearcher, LibraryName, "Gen@12") + ")";
			
			return S;
		}
		
		public void SearchEmailAttachments(ref string ContainsClause, bool isFreetext)
		{
			
			string tSql = "";
			string S = "";
			int I = 0;
			
			S = "delete from EmailAttachmentSearchList where UserID = \'" + modGlobals.gCurrUserGuidID + "\' ";
			bool B = DB.ExecuteSqlNewConn(S);
			if (B == false)
			{
				LOG.WriteToArchiveLog("Notice: Failed to delete user records from EmailAttachmentSearchList.");
			}
			
			try
			{
				//INSERT INTO EmailAttachmentSearchList
				//                      (UserID, EmailGuid, RowID)
				//SELECT     'wmiller' AS Expr1, EmailGuid, RowID
				//FROM         EmailAttachment
				//WHERE     CONTAINS(*, ' alaska')
				
				tSql = "insert EmailAttachmentSearchList ([UserID],[EmailGuid], RowID) " + "\r\n";
				tSql = tSql + " select \'" + modGlobals.gCurrUserGuidID + "\',[EmailGuid], RowID  " + "\r\n";
				tSql = tSql + "FROM EmailAttachment " + "\r\n";
				tSql = tSql + "where " + "\r\n";
				S = ContainsClause;
				I = 0;
				I = S.IndexOf("(") + 1;
				StringType.MidStmtStr(ref ContainsClause, I, 1, " ");
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
					S = (string) ("contains(*" + S);
				}
				
				ContainsClause = tSql + S + "\r\n";
			}
			catch (Exception ex)
			{
				Console.WriteLine(ex.Message);
			}
			
			//Clipboard.Clear()
			//Clipboard.SetText(ContainsClause )
			
		}
		
	}
	
}
