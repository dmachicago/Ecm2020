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

using System.IO;
using Microsoft.VisualBasic.CompilerServices;

//Imports System.Data.Sql
//Imports System.Data.SqlClient

namespace EcmArchiveClcSetup
{
	public class clsGenerator
	{
		
		bool dDeBug = false;
		public int TopRows = 0;
		public bool UseWeights = false;
		private string SortOrder = "";
		
		public string genDocPagingByRowHeader()
		{
			
			string S = " WITH xContent AS (" + "\r\n";
			return S;
			
		}
		public string genDocPagingByRowFooter(int StartNbr, int EndNbr)
		{
			
			string S = "";
			S = S + " )" + "\r\n";
			S = S + " SELECT * FROM xContent" + "\r\n";
			S = S + " WHERE ROWID BETWEEN " + StartNbr.ToString() + " AND " + EndNbr.ToString() + "\r\n";
			return S;
			
		}
		
		public string DocSearchMetaData(string MetaDataName, string MetaDataValue, bool Mandatory)
		{
			
			if (MetaDataValue.Length == 0)
			{
				return string.Empty;
			}
			else if (MetaDataName.Length == 0)
			{
				return string.Empty;
			}
			
			MetaDataValue = FixSingleQuote(MetaDataValue);
			
			string S = "";
			string CH = "";
			string WhereClause = "";
			//Dim MetaDataType  = DB.getAttributeDataType(MetaDataName )
			//Dim QuotesNeeded As Boolean = DB.QuotesRequired(MetaDataType )
			
			if (Mandatory)
			{
				S = S + " and SourceGuid in ";
				S = S + " (";
				S = S + " Select D.SourceGuid";
				S = S + " FROM DataSource AS D INNER JOIN";
				S = S + " SourceAttribute AS S ON D.SourceGuid = S.SourceGuid";
				S = S + " WHERE (S.AttributeName = \'" + MetaDataName + "\' and AttributeValue like \'" + MetaDataValue + "\')";
				S = S + " )";
			}
			else
			{
				S = S + " OR SourceGuid in ";
				S = S + " (";
				S = S + " Select D.SourceGuid";
				S = S + " FROM DataSource AS D INNER JOIN";
				S = S + " SourceAttribute AS S ON D.SourceGuid = S.SourceGuid";
				S = S + " WHERE (S.AttributeName = \'" + MetaDataName + "\' and AttributeValue like \'" + MetaDataValue + "\')";
				S = S + " )";
			}
			
			return S;
			
		}
		
		
		public string DocSearchCreatedWithinLastXDays(bool ckLimitTodays, string DaysOld, bool Mandatory)
		{
			string S = "";
			if (ckLimitTodays)
			{
				if (Mandatory)
				{
					S = " AND (LastWriteTime >= GETDATE() - " + DaysOld + " OR CreateDate >= GETDATE() - " + DaysOld.ToString() + ")" + "\r\n";
				}
				else
				{
					S = " OR (LastWriteTime >= GETDATE() - " + DaysOld + " OR CreateDate >= GETDATE() - " + DaysOld.ToString() + ")" + "\r\n";
				}
			}
			return S;
		}
		
		public string DocSearchLimitToCurrentGuids(string CurrUserID, bool ckLimitToExisting, List<string> CurrentGuids)
		{
			string S = "";
			if (ckLimitToExisting)
			{
				//DB.LimitToExistingRecs(CurrentGuids)
				S = " AND (SourceGuid in (SELECT [DocGuid] FROM ActiveSearchGuids where  UserID = \'" + CurrUserID + "\'))";
			}
			return S;
		}
		
		public string DocSearchCreateDate(bool ckDate, string DATECODE, bool Mandatory, bool bReceived, bool bCreated, DateTime Startdate, DateTime EndDate)
		{
			
			if (! ckDate)
			{
				return string.Empty;
			}
			
			string S = string.Empty;
			
			switch (DATECODE)
			{
				case "AFTER":
					if (Mandatory == true)
					{
						S += " AND ";
					}
					else
					{
						S += " OR ";
					}
					S += " (CreateDate > \'" + (Startdate).ToString() + "\')" + "\r\n";
					break;
				case "BEFORE":
					if (Mandatory == true)
					{
						S += " AND ";
					}
					else
					{
						S += " OR ";
					}
					S += " (CreateDate < \'" + (Startdate).ToString() + "\')" + "\r\n";
					break;
				case "BETWEEN":
					if (Mandatory == true)
					{
						S += " AND ";
					}
					else
					{
						S += " OR ";
					}
					S += " (CreateDate >= \'" + (Startdate).ToString() + "\' AND CreateDate <= \'" + (EndDate).ToString() + "\')" + "\r\n";
					break;
				case "NOT BETWEEN":
					if (Mandatory == true)
					{
						S += " AND ";
					}
					else
					{
						S += " OR ";
					}
					S += " (CreateDate <= \'" + (Startdate).ToString() + "\' AND CreateDate >= \'" + (EndDate).ToString() + "\')" + "\r\n";
					break;
				case "ON":
					if (Mandatory == true)
					{
						S += " AND ";
					}
					else
					{
						S += " OR ";
					}
					S += " (CreateDate = \'" + (Startdate).ToString() + "\')" + "\r\n";
					break;
				default:
					S = string.Empty;
					break;
			}
			
			return S;
			
		}
		
		public string DocSearchDateLastWriteTime(bool ckDate, string DATECODE, bool Mandatory, bool bReceived, bool bCreated, DateTime Startdate, DateTime EndDate)
		{
			
			if (! ckDate)
			{
				return string.Empty;
			}
			
			string S = string.Empty;
			
			switch (DATECODE)
			{
				case "AFTER":
					if (Mandatory == true)
					{
						S += " AND ";
					}
					else
					{
						S += " OR ";
					}
					S += " (LastWriteTime > \'" + (Startdate).ToString() + "\')" + "\r\n";
					break;
				case "BEFORE":
					if (Mandatory == true)
					{
						S += " AND ";
					}
					else
					{
						S += " OR ";
					}
					S += " (LastWriteTime < \'" + (Startdate).ToString() + "\')" + "\r\n";
					break;
				case "BETWEEN":
					if (Mandatory == true)
					{
						S += " AND ";
					}
					else
					{
						S += " OR ";
					}
					S += " (LastWriteTime >= \'" + (Startdate).ToString() + "\' AND LastWriteTime <= \'" + (EndDate).ToString() + "\')" + "\r\n";
					break;
				case "NOT BETWEEN":
					if (Mandatory == true)
					{
						S += " AND ";
					}
					else
					{
						S += " OR ";
					}
					S += " (LastWriteTime <= \'" + (Startdate).ToString() + "\' AND LastWriteTime >= \'" + (EndDate).ToString() + "\')" + "\r\n";
					break;
				case "ON":
					if (Mandatory == true)
					{
						S += " AND ";
					}
					else
					{
						S += " OR ";
					}
					S += " (LastWriteTime = \'" + (Startdate).ToString() + "\')" + "\r\n";
					break;
				default:
					S = string.Empty;
					break;
			}
			
			return S;
			
		}
		
		
		public string DocSearchFileDirectory(string FileDirectory, bool Mandatory)
		{
			
			if (FileDirectory.Trim().Length == 0)
			{
				return string.Empty;
			}
			FileDirectory = FixSingleQuote(FileDirectory);
			string S = string.Empty;
			if (Mandatory)
			{
				S += " AND (FileDirectory like \'" + FileDirectory + "\' )";
			}
			else
			{
				S += " OR (FileDirectory like \'" + FileDirectory + "\' )";
			}
			return S;
			
		}
		
		public string SearchByMinWeight(string MinWeight, bool SetWeight)
		{
			
			if (SetWeight == false)
			{
				return string.Empty;
			}
			
			string S = string.Empty;
			S += " and KEY_TBL.RANK >= " + MinWeight + "\r\n";
			
			return S;
		}
		
		public string DocSearchByFileExt(string EXT, bool Mandatory)
		{
			if (EXT.Trim().Length == 0)
			{
				return string.Empty;
			}
			EXT = FixSingleQuote(EXT);
			string S = string.Empty;
			if (Mandatory)
			{
				S += " AND (OriginalFileType like \'" + EXT + "\' )";
			}
			else
			{
				S += " OR (OriginalFileType like \'" + EXT + "\' )";
			}
			
			return S;
		}
		
		public string DocSearchByFileName(string FQN, bool Mandatory)
		{
			if (FQN.Trim().Length == 0)
			{
				return string.Empty;
			}
			FQN = FixSingleQuote(FQN);
			string S = string.Empty;
			if (Mandatory)
			{
				S += " AND (SourceName like \'" + FQN + "\' )";
			}
			else
			{
				S += " OR (SourceName like \'" + FQN + "\' )";
			}
			return S;
		}
		
		public string DocSearchOrderByWeights()
		{
			string S = string.Empty;
			S = " and KEY_TBL.RANK >= 0 ORDER BY KEY_TBL.RANK DESC ";
			return S;
		}
		
		public string DocSearchGenCols(bool ckWeighted, string searchCriteria)
		{
			
			bool ckBusiness = false;
			string S = "";
			
			if (ckWeighted == true)
			{
				S = S + "Select " + "\r\n";
				S += "\t" + " KEY_TBL.RANK, DS.SourceName 	" + "\r\n";
				S += "\t" + ",DS.CreateDate " + "\r\n";
				S += "\t" + ",DS.VersionNbr 	" + "\r\n";
				S += "\t" + ",DS.LastAccessDate " + "\r\n";
				S += "\t" + ",DS.FileLength " + "\r\n";
				S += "\t" + ",DS.LastWriteTime " + "\r\n";
				S += "\t" + ",DS.OriginalFileType 		" + "\r\n";
				S += "\t" + ",DS.isPublic " + "\r\n";
				S += "\t" + ",DS.FQN " + "\r\n";
				S += "\t" + ",DS.SourceGuid " + "\r\n";
				S += "\t" + ",DS.DataSourceOwnerUserID, DS.FileDirectory, DS.RetentionExpirationDate, DS.isMaster, DS.StructuredData, DS.RepoSvrName " + "\r\n";
				S += "FROM DataSource as DS " + "\r\n";
				
				S += genIsAbout(ckWeighted, ckBusiness, searchCriteria.Trim(), false);
				
				//If bSaveToClipBoard Then
				//Clipboard.SetText(s)
				//End If
				
			}
			else
			{
				S = S + "Select " + "\r\n";
				S += "\t" + "[SourceName] 	" + "\r\n";
				S += "\t" + ",[CreateDate] " + "\r\n";
				S += "\t" + ",[VersionNbr] 	" + "\r\n";
				S += "\t" + ",[LastAccessDate] " + "\r\n";
				S += "\t" + ",[FileLength] " + "\r\n";
				S += "\t" + ",[LastWriteTime] " + "\r\n";
				S += "\t" + ",[OriginalFileType] 		" + "\r\n";
				S += "\t" + ",[isPublic] " + "\r\n";
				S += "\t" + ",[FQN] " + "\r\n";
				S += "\t" + ",[SourceGuid] " + "\r\n";
				S += "\t" + ",[DataSourceOwnerUserID], FileDirectory, RetentionExpirationDate, isMaster, StructuredData, RepoSvrName " + "\r\n";
				S += "FROM DataSource " + "\r\n";
				//If bSaveToClipBoard Then
				//Clipboard.SetText(s)
				//End If
			}
			
			return S;
			
		}
		
		public string DocSearchGenColsPaging(bool ckWeighted, string searchCriteria)
		{
			
			bool ckBusiness = false;
			string S = "";
			
			if (ckWeighted == true)
			{
				S = S + "Select " + "\r\n";
				S += "\t" + "KEY_TBL.RANK (";
				S += "\t" + ",DS.SourceName" + "\r\n";
				S += "\t" + ",DS.CreateDate " + "\r\n";
				S += "\t" + ",DS.VersionNbr 	" + "\r\n";
				S += "\t" + ",DS.LastAccessDate " + "\r\n";
				S += "\t" + ",DS.FileLength " + "\r\n";
				S += "\t" + ",DS.LastWriteTime " + "\r\n";
				S += "\t" + ",DS.OriginalFileType 		" + "\r\n";
				S += "\t" + ",DS.isPublic " + "\r\n";
				S += "\t" + ",DS.FQN " + "\r\n";
				S += "\t" + ",DS.SourceGuid " + "\r\n";
				S += "\t" + ",DS.DataSourceOwnerUserID, ";
				S += "\t" + ",DS.FileDirectory ";
				S += "\t" + ",DS.RetentionExpirationDate ";
				S += "\t" + ",DS.isMaster ";
				S += "\t" + ",DS.StructuredData" + "\r\n";
				S += "\t" + ",ROW_NUMBER() OVER (ORDER BY SourceName ASC) AS ROWID, RepoSvrName  )" + "\r\n";
				S += "FROM DataSource as DS " + "\r\n";
				
				S += genIsAbout(ckWeighted, ckBusiness, searchCriteria.Trim(), false);
				
				//If bSaveToClipBoard Then
				//Clipboard.SetText(s)
				//End If
				
			}
			else
			{
				S = S + "Select " + "\r\n";
				S += "\t" + "[SourceName] 	" + "\r\n";
				S += "\t" + ",[CreateDate] " + "\r\n";
				S += "\t" + ",[VersionNbr] 	" + "\r\n";
				S += "\t" + ",[LastAccessDate] " + "\r\n";
				S += "\t" + ",[FileLength] " + "\r\n";
				S += "\t" + ",[LastWriteTime] " + "\r\n";
				S += "\t" + ",[OriginalFileType] 		" + "\r\n";
				S += "\t" + ",[isPublic] " + "\r\n";
				S += "\t" + ",[FQN] " + "\r\n";
				S += "\t" + ",[SourceGuid] " + "\r\n";
				S += "\t" + ",[DataSourceOwnerUserID]";
				S += "\t" + ", FileDirectory";
				S += "\t" + ", RetentionExpirationDate";
				S += "\t" + ", isMaster";
				S += "\t" + ", StructuredData " + "\r\n";
				S += "\t" + ",ROW_NUMBER() OVER (ORDER BY SourceName ASC) AS ROWID, RepoSvrName  " + "\r\n";
				S += "FROM DataSource " + "\r\n";
				//If bSaveToClipBoard Then
				//Clipboard.SetText(s)
				//End If
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
					}
				}
			}
			
			return S;
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
		
		public string EmailSearchWithinLastXDays(string DaysOld, bool SetWeight)
		{
			if (SetWeight == false)
			{
				return string.Empty;
			}
			
			string S = string.Empty;
			S += " and (CreationTime >= GETDATE() - " + DaysOld + " or SentOn  >= GETDATE() - " + DaysOld.ToString() + " )";
			
			return S;
		}
		
		
		public string EmailSearchAllReceipients(string Name, bool Mandatory)
		{
			
			Name = Name.Trim();
			if (Name.Length == 0)
			{
				return string.Empty;
			}
			
			string S = string.Empty;
			
			if (Mandatory == true)
			{
				S += " AND ";
			}
			else
			{
				S += " OR ";
			}
			
			S = S + " (AllRecipients like \'" + FixSingleQuote(Name) + "\' or " + "\r\n";
			S = S + "      CC like \'" + FixSingleQuote(Name) + "\' or " + "\r\n";
			S = S + "      BCC like \'" + FixSingleQuote(Name) + "\') " + "\r\n";
			
			return S;
		}
		
		public string EmailSearchMyEmailsOnly(string CurrUserID, bool bLimitReturn, bool isGlobalSearcher)
		{
			
			string S = string.Empty;
			
			if (isGlobalSearcher == false)
			{
				S += " AND (where UserID = \'" + CurrUserID + "\' or isPublic = \'Y\' )";
				return S;
			}
			
			if (bLimitReturn == false)
			{
				return string.Empty;
			}
			
			S += " AND (where UserID = \'" + CurrUserID + "\' or isPublic = \'Y\' )";
			
			return S;
		}
		
		public string EmailSearchCcBcc(string Name, bool Mandatory)
		{
			
			Name = Name.Trim();
			if (Name.Length == 0)
			{
				return string.Empty;
			}
			
			string S = string.Empty;
			
			if (Mandatory == true)
			{
				S += " AND ";
			}
			else
			{
				S += " OR ";
			}
			
			S = S + " (CC like \'" + FixSingleQuote(Name) + "\' or " + "\r\n";
			S = S + " BCC like \'" + FixSingleQuote(Name) + "\')  " + "\r\n";
			
			return S;
		}
		
		public string EmailSearchSubject(string Name, bool Mandatory)
		{
			
			Name = Name.Trim();
			if (Name.Length == 0)
			{
				return string.Empty;
			}
			
			string S = string.Empty;
			
			if (Mandatory == true)
			{
				S += " AND ";
			}
			else
			{
				S += " OR ";
			}
			
			S = S + " (SUBJECT Like \'" + Name + "\') " + "\r\n";
			
			return S;
		}
		
		public string EmailSearchByFolder(string Name, bool Mandatory)
		{
			
			Name = Name.Trim();
			if (Name.Length == 0)
			{
				return string.Empty;
			}
			
			string S = string.Empty;
			
			if (Mandatory == true)
			{
				S += " AND ";
			}
			else
			{
				S += " OR ";
			}
			
			S = S + " (OriginalFolder LIKE \'" + FixSingleQuote(Name) + "\') " + "\r\n";
			
			return S;
		}
		
		public string EmailSearchReceivedByName(string Name, bool Mandatory)
		{
			
			Name = Name.Trim();
			if (Name.Length == 0)
			{
				return string.Empty;
			}
			
			string S = string.Empty;
			
			if (Mandatory == true)
			{
				S += " AND ";
			}
			else
			{
				S += " OR ";
			}
			
			S = S + " (ReceivedByName like \'" + FixSingleQuote(Name) + "\') " + "\r\n";
			
			return S;
		}
		
		public string EmailAccount(string Name, bool Mandatory)
		{
			
			return EmailSearchReceivedByName(Name, Mandatory);
			
		}
		
		public string EmailSearchFromName(string Name, bool Mandatory)
		{
			
			Name = Name.Trim();
			if (Name.Length == 0)
			{
				return string.Empty;
			}
			
			string S = string.Empty;
			
			if (Mandatory == true)
			{
				S += " AND ";
			}
			else
			{
				S += " OR ";
			}
			
			S = S + " (SenderName like \'" + FixSingleQuote(Name) + "\') " + "\r\n";
			
			return S;
		}
		
		public string EmailSearchToEmailAddr(string EmailAddr, bool Mandatory)
		{
			
			EmailAddr = EmailAddr.Trim();
			if (EmailAddr.Length == 0)
			{
				return string.Empty;
			}
			
			string S = string.Empty;
			
			if (Mandatory == true)
			{
				S += " AND ";
			}
			else
			{
				S += " OR ";
			}
			
			S = S + " ( SentTO like \'" + FixSingleQuote(EmailAddr) + "\' or" + "\r\n";
			S = S + " AllRecipients like \'" + FixSingleQuote(EmailAddr) + "\') " + "\r\n";
			
			return S;
		}
		
		public string EmailSearchFromEmailAddr(string EmailAddr, bool Mandatory)
		{
			
			EmailAddr = EmailAddr.Trim();
			if (EmailAddr.Length == 0)
			{
				return string.Empty;
			}
			
			string S = string.Empty;
			
			if (Mandatory == true)
			{
				S += " AND ";
			}
			else
			{
				S += " OR ";
			}
			
			S = S + " (SenderEmailAddress like \'" + FixSingleQuote(EmailAddr) + "\') " + "\r\n";
			
			return S;
		}
		
		public string EmailSearchDateLimits(bool ckDate, string DATECODE, bool Mandatory, bool bSent, bool bReceived, bool bCreated, DateTime Startdate, DateTime EndDate)
		{
			
			if (! ckDate)
			{
				return string.Empty;
			}
			
			string S = string.Empty;
			
			switch (DATECODE)
			{
				case "AFTER":
					if (bSent) //SentOn
					{
						if (Mandatory == true)
						{
							S += " AND ";
						}
						else
						{
							S += " OR ";
						}
						S += " (SentOn > \'" + (Startdate).ToString() + "\')" + "\r\n";
					}
					if (bReceived) //ReceivedTime
					{
						if (Mandatory == true)
						{
							S += " AND ";
						}
						else
						{
							S += " OR ";
						}
						S += " (ReceivedTime > \'" + (Startdate).ToString() + "\')" + "\r\n";
					}
					if (bCreated) //CreateDate
					{
						if (Mandatory == true)
						{
							S += " AND ";
						}
						else
						{
							S += " OR ";
						}
						S += " (CreateDate > \'" + (Startdate).ToString() + "\')" + "\r\n";
					}
					break;
				case "BEFORE":
					if (bSent) //SentOn
					{
						if (Mandatory == true)
						{
							S += " AND ";
						}
						else
						{
							S += " OR ";
						}
						S += " (SentOn < \'" + (Startdate).ToString() + "\')" + "\r\n";
					}
					if (bReceived) //ReceivedTime
					{
						if (Mandatory == true)
						{
							S += " AND ";
						}
						else
						{
							S += " OR ";
						}
						S += " (ReceivedTime < \'" + (Startdate).ToString() + "\')" + "\r\n";
					}
					if (bCreated) //CreateDate
					{
						if (Mandatory == true)
						{
							S += " AND ";
						}
						else
						{
							S += " OR ";
						}
						S += " (CreateDate < \'" + (Startdate).ToString() + "\')" + "\r\n";
					}
					break;
				case "BETWEEN":
					if (bSent) //SentOn
					{
						if (Mandatory == true)
						{
							S += " AND ";
						}
						else
						{
							S += " OR ";
						}
						S += " (SentOn >= \'" + (Startdate).ToString() + "\' AND SentOn <= \'" + (EndDate).ToString() + "\')" + "\r\n";
					}
					if (bReceived) //ReceivedTime
					{
						if (Mandatory == true)
						{
							S += " AND ";
						}
						else
						{
							S += " OR ";
						}
						S += " (ReceivedTime >= \'" + (Startdate).ToString() + "\' AND ReceivedTime <= \'" + (EndDate).ToString() + "\')" + "\r\n";
					}
					if (bCreated) //CreateDate
					{
						if (Mandatory == true)
						{
							S += " AND ";
						}
						else
						{
							S += " OR ";
						}
						S += " (CreateDate >= \'" + (Startdate).ToString() + "\' AND CreateDate <= \'" + (EndDate).ToString() + "\')" + "\r\n";
					}
					break;
				case "NOT BETWEEN":
					if (bSent) //SentOn
					{
						if (Mandatory == true)
						{
							S += " AND ";
						}
						else
						{
							S += " OR ";
						}
						S += " (SentOn <= \'" + (Startdate).ToString() + "\' AND SentOn >= \'" + (EndDate).ToString() + "\')" + "\r\n";
					}
					if (bReceived) //ReceivedTime
					{
						if (Mandatory == true)
						{
							S += " AND ";
						}
						else
						{
							S += " OR ";
						}
						S += " (ReceivedTime <= \'" + (Startdate).ToString() + "\' AND ReceivedTime >= \'" + (EndDate).ToString() + "\')" + "\r\n";
					}
					if (bCreated) //CreateDate
					{
						if (Mandatory == true)
						{
							S += " AND ";
						}
						else
						{
							S += " OR ";
						}
						S += " (CreateDate <= \'" + (Startdate).ToString() + "\' AND CreateDate >= \'" + (EndDate).ToString() + "\')" + "\r\n";
					}
					break;
				case "ON":
					if (bSent) //SentOn
					{
						if (Mandatory == true)
						{
							S += " AND ";
						}
						else
						{
							S += " OR ";
						}
						S += " (SentOn = \'" + (Startdate).ToString() + "\')" + "\r\n";
					}
					if (bReceived) //ReceivedTime
					{
						if (Mandatory == true)
						{
							S += " AND ";
						}
						else
						{
							S += " OR ";
						}
						S += " (ReceivedTime = \'" + (Startdate).ToString() + "\')" + "\r\n";
					}
					if (bCreated) //CreateDate
					{
						if (Mandatory == true)
						{
							S += " AND ";
						}
						else
						{
							S += " OR ";
						}
						S += " (CreateDate = \'" + (Startdate).ToString() + "\')" + "\r\n";
					}
					break;
				default:
					S = string.Empty;
					break;
			}
			
			return S;
			
		}
		public string EmailGenColsNoWeights(string ContainsClause)
		{
			string S = "";
			
			ContainsClause = FixSingleQuote(ContainsClause);
			
			S = S + " SELECT     Email.SentOn, Email.ShortSubj, Email.SenderEmailAddress, Email.SenderName, Email.SentTO, SUBSTRING(Email.Body, 1, 100) AS Body, Email.CC, Email.Bcc, " + "\r\n";
			S = S + "                       Email.CreationTime, Email.AllRecipients, Email.ReceivedByName, Email.ReceivedTime, Email.MsgSize, Email.SUBJECT, Email.OriginalFolder, Email.EmailGuid, " + "\r\n";
			S = S + "                       Email.RetentionExpirationDate, Email.isPublic, Email.ConvertEmlToMSG, Email.UserID, Email.NbrAttachments, Email.SourceTypeCode, \'N\' AS FoundInAttachment," + "\r\n";
			S = S + "                       EmailAttachment.RowID" + "\r\n";
			S = S + " FROM         Email FULL OUTER JOIN" + "\r\n";
			S = S + "                       EmailAttachment ON Email.EmailGuid = EmailAttachment.EmailGuid" + "\r\n";
			S = S + " WHERE" + "\r\n";
			S = S + " (" + "\r\n";
			S = S + " CONTAINS(Email.*, \'" + ContainsClause + "\') OR" + "\r\n";
			S = S + " CONTAINS(EmailAttachment.*, \'" + ContainsClause + "\') " + "\r\n";
			S = S + " ) " + "\r\n";
			
			return S;
			
		}
		
		public string EmailGenColsNoWeights()
		{
			
			string S = "";
			
			S = S + " SELECT     Email.SentOn, Email.ShortSubj, Email.SenderEmailAddress, Email.SenderName, Email.SentTO, SUBSTRING(Email.Body, 1, 100) AS Body, Email.CC, Email.Bcc, " + "\r\n";
			S = S + "                       Email.CreationTime, Email.AllRecipients, Email.ReceivedByName, Email.ReceivedTime, Email.MsgSize, Email.SUBJECT, Email.OriginalFolder, Email.EmailGuid, " + "\r\n";
			S = S + "                       Email.RetentionExpirationDate, Email.isPublic, Email.ConvertEmlToMSG, Email.UserID, Email.NbrAttachments, Email.SourceTypeCode, \'N\' AS FoundInAttachment," + "\r\n";
			S = S + "                       EmailAttachment.RowID" + "\r\n";
			S = S + " FROM         Email FULL OUTER JOIN" + "\r\n";
			S = S + "                       EmailAttachment ON Email.EmailGuid = EmailAttachment.EmailGuid" + "\r\n";
			S = S + " WHERE" + "\r\n";
			
			return S;
			
		}
		
		public void genNewEmailQuery(ref string GeneratedSql)
		{
			string[] a = GeneratedSql.Split("\r\n".ToCharArray());
			string S = "";
			bool bNextWhereStmt = false;
			bool bGenNewSql = false;
			string NewSql = "";
			string StdQueryCols = this.genStdEmailQqueryCols();
			bool doNotAppend = false;
			bool bContainsTable = false;
			
			
			
			for (int i = 0; i <= (a.Length - 1); i++)
			{
				S = a[i];
				S = S.Trim();
				
				if (S.IndexOf("FROM EMAIL ") + 1 > 0)
				{
					bNextWhereStmt = true;
				}
				
				if (S.IndexOf("INNER JOIN CONTAINSTABLE") + 1 > 0 && bNextWhereStmt == true)
				{
					bGenNewSql = true;
				}
				
				if (S.IndexOf("WHERE") + 1 > 0 && bNextWhereStmt == true)
				{
					if (S.Substring(0, 5).ToUpper().Equals("WHERE"))
					{
						bNextWhereStmt = false;
						bGenNewSql = true;
					}
				}
				
				//If UseWeights = True Then
				//    S = S + vbTab + "FROM Email as DS "
				//    S = ReplacePrefix(Prefix, "email.", S)
				//Else
				//    S = S + vbTab + "FROM Email "
				//End If
				
				if (S.IndexOf("CONTAINS") + 1 > 0)
				{
					if (S.Substring(0, "CONTAINS".Length).ToUpper().Equals("CONTAINS"))
					{
						string TempStr = RemoveSpaces(S);
						TempStr = TempStr.ToUpper;
						if (TempStr.IndexOf("CONTAINS(*") + 1 > 0)
						{
							int k = S.IndexOf("*") + 1;
							string S1 = "";
							string S2 = "";
							S1 = S.Substring(0, k - 1);
							S2 = S.Substring(k + 1 - 1);
							S = S1 + "Email.*" + S2;
							a[i] = S;
						}
					}
				}
				
				if (S.IndexOf("order by") + 1 > 0 && bGenNewSql == true)
				{
					if (S.Substring(0, 8).ToUpper().Equals("ORDER BY"))
					{
						doNotAppend = true;
						a[i] = "";
						break;
					}
				}
				
				if (bGenNewSql == true && doNotAppend == false && a[i].Trim().Length > 0)
				{
					NewSql = NewSql + "\r\n" + a[i];
				}
				
			}
			
			NewSql = StdQueryCols + "\r\n" + NewSql;
			GeneratedSql = NewSql;
			
			//Clipboard.Clear()
			//Clipboard.SetText(NewSql)
			
		}
		
		public void genNewEmailAttachmentQuery(ref string GeneratedSql)
		{
			string[] a = GeneratedSql.Split("\r\n".ToCharArray());
			string S = "";
			bool bNextWhereStmt = false;
			bool bGenNewSql = false;
			string NewSql = "";
			string StdQueryCols = genStdEmailAttachmentQqueryCols();
			bool doNotAppend = false;
			
			for (int i = 0; i <= (a.Length - 1); i++)
			{
				S = a[i];
				S = S.Trim();
				
				if (S.IndexOf("FROM EMAIL ") + 1 > 0)
				{
					bNextWhereStmt = true;
				}
				
				if (S.IndexOf("JOIN CONTAINSTABLE") + 1 > 0 && bNextWhereStmt == true)
				{
					bGenNewSql = true;
				}
				
				if (S.IndexOf("WHERE") + 1 > 0 && bNextWhereStmt == true)
				{
					if (S.Substring(0, 5).ToUpper().Equals("WHERE"))
					{
						bNextWhereStmt = false;
						bGenNewSql = true;
					}
				}
				
				if (S.IndexOf("CONTAINS(body") + 1 > 0)
				{
					string TempStr = RemoveSpaces(S);
					int k = S.IndexOf("CONTAINS(body") + 1;
					k = S.IndexOf("(", k + 1 - 1) + 1;
					int L = S.IndexOf(",", k + 1 - 1) + 1;
					string S1 = "";
					string S2 = "";
					string tPart = S.Substring(k - 1, L - k + 1);
					S1 = S.Substring(0, k);
					S2 = S.Substring(L - 1);
					S = S1 + "Attachment" + S2;
					a[i] = S;
				}
				
				if (S.IndexOf("or CONTAINS(") + 1 > 0)
				{
					a[i] = "";
				}
				
				if (S.IndexOf("order by") + 1 > 0 && bGenNewSql == true)
				{
					if (S.Substring(0, 8).ToUpper().Equals("ORDER BY"))
					{
						doNotAppend = true;
						a[i] = "";
						break;
					}
				}
				
				if (S.IndexOf("Select EmailGuid from EmailAttachmentSearchList") + 1 > 0)
				{
					a[i] = "";
				}
				if (S.IndexOf("OR") + 1 > 0)
				{
					if (S.IndexOf("select") + 1 > 0)
					{
						if (S.IndexOf("EmailGuid") + 1 > 0)
						{
							if (S.IndexOf("EmailAttachmentSearchList") + 1 > 0)
							{
								a[i] = "";
							}
						}
					}
				}
				
				if (bGenNewSql == true && doNotAppend == false && a[i].Trim().Length > 0)
				{
					NewSql = NewSql + "\r\n" + a[i];
				}
				
			}
			
			NewSql = StdQueryCols + "\r\n" + NewSql;
			GeneratedSql = NewSql;
			
			//Clipboard.Clear()
			//Clipboard.SetText(NewSql)
			
		}
		
		public void genNewDocQuery(ref string GeneratedSql)
		{
			string[] a = GeneratedSql.Split("\r\n".ToCharArray());
			string S = "";
			bool bNextWhereStmt = false;
			bool bGenNewSql = false;
			string NewSql = "";
			string StdQueryCols = genStdDocQueryCols();
			bool doNotAppend = false;
			
			for (int i = 0; i <= (a.Length - 1); i++)
			{
				S = a[i];
				S = S.Trim();
				
				if (S.IndexOf("FROM ") + 1 > 0)
				{
					if (S.IndexOf("DataSource") + 1 > 0)
					{
						if (S.Substring(0, "FROM".Length).ToUpper().Equals("FROM"))
						{
							bNextWhereStmt = true;
						}
					}
				}
				
				if (S.IndexOf("JOIN CONTAINSTABLE") + 1 > 0 && bNextWhereStmt == true)
				{
					Console.WriteLine("Here");
					bGenNewSql = true;
				}
				
				if (S.IndexOf("WHERE") + 1 > 0 && bNextWhereStmt == true)
				{
					if (S.Substring(0, 5).ToUpper().Equals("WHERE"))
					{
						bNextWhereStmt = false;
						bGenNewSql = true;
					}
				}
				
				if (S.IndexOf("CONTAINS") + 1 > 0)
				{
					if (S.Substring(0, "CONTAINS".Length).ToUpper().Equals("CONTAINS"))
					{
						string TempStr = RemoveSpaces(S);
						TempStr = TempStr.ToUpper;
						if (TempStr.IndexOf("CONTAINS(*") + 1 > 0)
						{
							int k = S.IndexOf("*") + 1;
							string S1 = "";
							string S2 = "";
							S1 = S.Substring(0, k - 1);
							S2 = S.Substring(k + 1 - 1);
							S = S1 + "DataSource.*" + S2;
							a[i] = S;
						}
					}
				}
				
				if (S.IndexOf("order by") + 1 > 0 && bGenNewSql == true)
				{
					if (S.Substring(0, 8).ToUpper().Equals("ORDER BY"))
					{
						doNotAppend = true;
						a[i] = "";
						break;
					}
				}
				
				if (bGenNewSql == true && doNotAppend == false && a[i].Trim().Length > 0)
				{
					NewSql = NewSql + "\r\n" + a[i];
				}
				
			}
			
			NewSql = StdQueryCols + "\r\n" + NewSql;
			GeneratedSql = NewSql;
			
			//Clipboard.Clear()
			//Clipboard.SetText(GeneratedSql)
			
		}
		
		
		public string genStdEmailQqueryCols()
		{
			string S = "";
			string Prefix = "";
			if (TopRows > 0)
			{
				S = S + "Select top " + TopRows.ToString() + " " + "\r\n";
			}
			else
			{
				S = S + "Select " + "\r\n";
			}
			
			if (UseWeights == true)
			{
				S = S + "\t" + "KEY_TBL.RANK as Weight, " + "\r\n";
				Prefix = "DS.";
			}
			else
			{
				S = S + "\t" + "null as Weight, " + "\r\n";
				Prefix = "";
			}
			
			S = S + "\t" + "Email.ShortSubj as ContentTitle, " + "\r\n";
			S = S + "\t" + "(select COUNT(*) from EmailAttachment where EmailAttachment.EmailGuid = Email.EmailGuid) as NbrOfAttachments, " + "\r\n";
			S = S + "\t" + "Email.SenderEmailAddress AS ContentAuthor, " + "\r\n";
			S = S + "\t" + "Email.SourceTypeCode as  ContentExt, " + "\r\n";
			S = S + "\t" + "Email.CreationTime AS CreateDate, " + "\r\n";
			S = S + "\t" + "Email.ShortSubj as  FileName, " + "\r\n";
			S = S + "\t" + "Email.AllRecipients, " + "\r\n";
			S = S + "\t" + "Email.EmailGuid as ContentGuid, " + "\r\n";
			S = S + "\t" + "Email.MsgSize  as FileSize, " + "\r\n";
			S = S + "\t" + "Email.SenderEmailAddress AS FromEmailAddress, " + "\r\n";
			//S = S + vbTab + "Users.UserLoginID, " + vbCrLf
			S = S + "(Select UserLoginID from Users where email.UserID = Users.UserID) as UserLoginUD, " + "\r\n";
			S = S + "\t" + "Email.USERID, " + "\r\n";
			S = S + "\t" + "null as RowID, " + "\r\n";
			S = S + "\t" + "\'EMAIL\' AS Classification, " + "\r\n";
			S = S + "\t" + "null as isZipFileEntry, " + "\r\n";
			S = S + "\t" + "null as OcrText, " + "\r\n";
			S = S + "\t" + "email.ispublic " + "\r\n";
			
			if (UseWeights == true)
			{
				S = S + "\t" + "FROM Email as DS ";
				S = ReplacePrefix(Prefix, "email.", S);
			}
			else
			{
				S = S + "\t" + "FROM Email ";
			}
			
			
			return S;
		}
		
		public string genStdEmailAttachmentQqueryCols()
		{
			
			string Prefix = "DS.";
			string S = "";
			if (TopRows > 0)
			{
				S = S + "Select top " + TopRows.ToString() + " " + "\r\n";
			}
			else
			{
				S = S + "Select " + "\r\n";
			}
			
			if (UseWeights == true)
			{
				S = S + "\t" + "KEY_TBL.RANK as Weight, " + "\r\n";
			}
			else
			{
				S = S + "\t" + "null as Weight, " + "\r\n";
			}
			
			S = S + "\t" + "EmailAttachment.AttachmentName as ContentTitle, " + "\r\n";
			S = S + "\t" + "null as NbrOfAttachments, " + "\r\n";
			S = S + "\t" + "(select SenderEmailAddress from EMAIL where EmailAttachment.EmailGuid = EMAIL.EmailGuid) as ContentAuthor, " + "\r\n";
			S = S + "\t" + "EmailAttachment.AttachmentCode as ContentExt, " + "\r\n";
			S = S + "\t" + "(select CreationTime from EMAIL where EmailAttachment.EmailGuid = EMAIL.EmailGuid) as CreateDate, " + "\r\n";
			S = S + "\t" + "EmailAttachment.AttachmentName as FileName, " + "\r\n";
			S = S + "\t" + "null as AllRecipients, " + "\r\n";
			S = S + "\t" + "EmailAttachment.EmailGuid as ContentGuid, " + "\r\n";
			S = S + "\t" + "DATALENGTH(EmailAttachment.Attachment) as FileSize, " + "\r\n";
			S = S + "\t" + "(select SenderEmailAddress  from EMAIL where EmailAttachment.EmailGuid = EMAIL.EmailGuid) as FromEmailAddress, " + "\r\n";
			S = S + "\t" + "(Select UserLoginID from Users where EmailAttachment.UserID = Users.UserID) as UserLoginUD, " + "\r\n";
			S = S + "\t" + "EmailAttachment.UserID, " + "\r\n";
			S = S + "\t" + "EmailAttachment.RowID, " + "\r\n";
			S = S + "\t" + "\'Attachment\' as Classification, " + "\r\n";
			S = S + "\t" + "EmailAttachment.isZipFileEntry, " + "\r\n";
			S = S + "\t" + "EmailAttachment.OcrText, " + "\r\n";
			S = S + "\t" + "EmailAttachment.isPublic ";
			
			if (UseWeights == true)
			{
				S = S + "\t" + "FROM EmailAttachment as DS " + "\r\n";
				S = ReplacePrefix(Prefix, "EmailAttachment.", S);
			}
			else
			{
				S = S + "\t" + "FROM EmailAttachment " + "\r\n";
			}
			
			return S;
		}
		
		public string genStdDocQueryCols()
		{
			
			string Prefix = "DS.";
			string S = "";
			if (TopRows > 0)
			{
				S = S + "Select top " + TopRows.ToString() + " " + "\r\n";
			}
			else
			{
				S = S + "Select " + "\r\n";
			}
			
			if (UseWeights == true)
			{
				S = S + "\t" + "KEY_TBL.RANK as Weight, " + "\r\n";
			}
			else
			{
				S = S + "\t" + "null as Weight, " + "\r\n";
			}
			
			
			S = S + "\t" + "DataSource.SourceName as ContentTitle, " + "\r\n";
			S = S + "\t" + "null as NbrOfAttachments, " + "\r\n";
			S = S + "\t" + "null as ContentAuthor, " + "\r\n";
			S = S + "\t" + "DataSource.OriginalFileType as ContentExt, " + "\r\n";
			S = S + "\t" + "DataSource.CreateDate, " + "\r\n";
			S = S + "\t" + "DataSource.FQN as FileName, " + "\r\n";
			S = S + "\t" + "null as AllRecipients, " + "\r\n";
			S = S + "\t" + "DataSource.SourceGuid as ContentGuid, " + "\r\n";
			S = S + "\t" + "DataSource.FileLength  as FileSize, " + "\r\n";
			S = S + "\t" + "null as FromEmailAddress, " + "\r\n";
			//S = S + vbTab + "Users.UserLoginID, " + vbCrLf
			S = S + "(Select UserLoginID from Users where DataSource.DataSourceOwnerUserID = Users.UserID) as UserLoginUD, " + "\r\n";
			S = S + "\t" + "DataSource.DataSourceOwnerUserID as UserID, " + "\r\n";
			S = S + "\t" + "null as RowID, " + "\r\n";
			S = S + "\t" + "\'Content\' as Classification, " + "\r\n";
			S = S + "\t" + "DataSource.isZipFileEntry, " + "\r\n";
			S = S + "\t" + "null as OcrText, " + "\r\n";
			S = S + "\t" + "DataSource.isPublic, DataSource.RepoSvrName  " + "\r\n";
			
			if (UseWeights == true)
			{
				S = S + "\t" + "FROM DataSource as DS ";
				S = ReplacePrefix(Prefix, "DataSource.", S);
			}
			else
			{
				S = S + "\t" + "FROM DataSource ";
			}
			
			return S;
		}
		public string RemoveSpaces(string sText)
		{
			string[] A = sText.Split(" + vbcrlf ".ToCharArray()[0]);
			string S = "";
			for (int i = 0; i <= (A.Length - 1); i++)
			{
				S = S + A[i];
			}
			return S;
		}
		
		public string ReplacePrefix(string NewPrefix, string PrefixToReplace, string tgtStr)
		{
			string NewStr = "";
			int I = 0;
			int J = 0;
			string S = tgtStr;
			string S1 = "";
			string S2 = "";
			
			while (S.IndexOf(PrefixToReplace) + 1 > 0)
			{
				I = S.IndexOf(PrefixToReplace) + 1;
				J = System.Convert.ToInt32(S.IndexOf(PrefixToReplace) + 1 + PrefixToReplace.Length);
				S1 = S.Substring(0, I - 1);
				S2 = S.Substring(J - 1);
				S = S1 + NewPrefix + S2;
				//Console.WriteLine(S)
			}
			
			return S;
			
		}
		
		public void ReplaceStar(ref string tVal)
		{
			string CH = "";
			if (tVal.IndexOf("*") + 1 == 0)
			{
				return;
			}
			if (tVal.Length > 0)
			{
				if (tVal.Length > 1)
				{
					CH = tVal.Substring(0, 1);
					if (CH.Equals("*"))
					{
						StringType.MidStmtStr(ref tVal, 1, 1, "%");
					}
					CH = tVal.Substring(tVal.Length - 1, 1);
					if (CH.Equals("*"))
					{
						StringType.MidStmtStr(ref tVal, tVal.Length, 1, "%");
					}
				}
			}
		}
		
		public string FixSingleQuote(string tVal)
		{
			
			if (tVal.IndexOf("\'\'") + 1 > 0)
			{
				return (tVal);
			}
			if (tVal.IndexOf("\'") + 1 == 0)
			{
				return (tVal);
			}
			
			string SS = tVal;
			tVal = SS;
			try
			{
				int i = tVal.Length;
				string ch = "";
				string NewStr = "";
				string S1 = "";
				string S2 = "";
				string[] A;
				string PrevCH = "@";
				i = tVal.IndexOf("\'") + 1;
				while (tVal.IndexOf("\'") + 1 > 0)
				{
					i = tVal.IndexOf("\'") + 1;
					S1 = tVal.Substring(0, i);
					StringType.MidStmtStr(ref S1, S1.Length, 1, Strings.Chr(254));
					S2 = (string) (Strings.Chr(254) + tVal.Substring(i + 1 - 1));
					tVal = S1 + S2;
				}
				
				for (i = 1; i <= tVal.Length; i++)
				{
					ch = tVal.Substring(i - 1, 1);
					if (ch == Strings.Chr(254))
					{
						StringType.MidStmtStr(ref tVal, i, 1, "\'");
					}
				}
			}
			catch (Exception ex)
			{
				WriteToLog((string) ("ERROR: FixSingleQuote - " + ex.Message + "\r\n" + ex.StackTrace));
			}
			
			return tVal;
		}
		
		public void WriteToLog(string Msg)
		{
			try
			{
				string cPath = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);
				string TempFolder = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);
				string M = DateTime.Now.Month.ToString().Trim();
				string D = DateTime.Now.Day.ToString().Trim();
				string Y = DateTime.Now.Year.ToString().Trim();
				
				string SerialNo = M + "." + D + "." + Y + ".";
				
				string tFQN = TempFolder + "\\ECMLibrary.Generator.Log." + SerialNo + "txt";
				// Create an instance of StreamWriter to write text to a file.
				using (StreamWriter sw = new StreamWriter(tFQN, true))
				{
					// Add some text to the file.
					sw.WriteLine(DateTime.Now.ToString() + ": " + Msg + "\r\n");
					sw.Close();
				}
				
				//If gRunUnattended = True Then
				//    gUnattendedErrors += 1
				//    FrmMDIMain.SB4.Text = " " + gUnattendedErrors.ToString
				//    FrmMDIMain.SB4.BackColor = Color.Silver
				//End If
			}
			catch (Exception ex)
			{
				Console.WriteLine("clsGenerator : WriteToLog : 688 : " + ex.Message);
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
		
		public string genLibrarySearch(string CurrUserID, bool bSourceSearch, bool bGlobalSearcher, string LocationID)
		{
			
			string SearchCode = "";
			if (bSourceSearch == true)
			{
				SearchCode = "S";
			}
			else
			{
				SearchCode = "E";
			}
			
			string S = "";
			
			if (SearchCode.Equals("E") || SearchCode.Equals("EMAIL"))
			{
				if (bGlobalSearcher == true)
				{
					S = S + '\t' + "/* This is where the library search would go - you have global rights, think about it.*/" + '\t' + '\t' + " /*KEEP*/" + "\r\n";
					S = S + '\t' + " AND (UserID IS NOT NULL)" + '\t' + '\t' + " /*KEEP*/" + "\r\n";
					return S;
				}
				else
				{
					S = S + " AND (UserID = \'" + CurrUserID + "\'" + '\t' + '\t' + " /*KEEP*/" + "\r\n";
					S = S + '\t' + " or isPublic = \'Y\'" + " /*KEEP*/" + "\r\n";
				}
			}
			if (SearchCode.Equals("S") || SearchCode.Equals("EMAIL"))
			{
				if (bGlobalSearcher == true)
				{
					S = S + '\t' + "/* This is where the library search would go - you have global rights, think about it.*/" + '\t' + '\t' + " /*KEEP*/" + "\r\n";
					S = S + '\t' + " AND (DataSourceOwnerUserID IS NOT NULL)" + '\t' + '\t' + " /*KEEP*/" + "\r\n";
					return S;
				}
				else
				{
					S = S + " AND (DataSourceOwnerUserID = \'" + CurrUserID + "\'" + '\t' + '\t' + " /*KEEP*/" + "\r\n";
					S = S + '\t' + " or isPublic = \'Y\'" + " /*KEEP*/" + "\r\n";
				}
			}
			
			S = S + '\t' + '\t' + " /* GENID:" + LocationID + "*/" + '\t' + '\t' + " /*KEEP*/" + "\r\n";
			if (SearchCode.Equals("E") || SearchCode.Equals("EMAIL"))
			{
				S = S + '\t' + '\t' + " or EmailGuid in (" + " /*KEEP*/" + "\r\n";
			}
			else
			{
				S = S + '\t' + '\t' + " or SourceGuid in (" + " /*KEEP*/" + "\r\n";
			}
			
			S = S + '\t' + " SELECT LibraryItems.SourceGuid" + '\t' + '\t' + " /*KEEP*/" + "\r\n";
			S = S + '\t' + " FROM   LibraryItems INNER JOIN" + '\t' + '\t' + " /*KEEP*/" + "\r\n";
			S = S + '\t' + "        Library ON LibraryItems.LibraryName = Library.LibraryName INNER JOIN" + '\t' + '\t' + " /*KEEP*/" + "\r\n";
			S = S + '\t' + "        LibraryUsers ON Library.LibraryName = LibraryUsers.LibraryName INNER JOIN" + '\t' + '\t' + " /*KEEP*/" + "\r\n";
			S = S + '\t' + "        GroupLibraryAccess ON Library.LibraryName = GroupLibraryAccess.LibraryName INNER JOIN" + '\t' + '\t' + " /*KEEP*/" + "\r\n";
			S = S + '\t' + "        GroupUsers ON GroupLibraryAccess.GroupName = GroupUsers.GroupName" + '\t' + '\t' + " /*KEEP*/" + "\r\n";
			S = S + '\t' + " where " + '\t' + '\t' + " /*KEEP*/" + "\r\n";
			S = S + '\t' + "        libraryusers.userid =\'" + CurrUserID + "\' " + '\t' + '\t' + " /*KEEP*/   /*ID55*/" + "\r\n";
			
			S = S + '\t' + "UNION " + '\t' + '\t' + " /*KEEP*/" + "\r\n";
			S = S + '\t' + "Select LI.SourceGuid" + '\t' + '\t' + " /*KEEP*/" + "\r\n";
			S = S + '\t' + "FROM         LibraryItems AS LI INNER JOIN" + '\t' + '\t' + " /*KEEP*/" + "\r\n";
			S = S + '\t' + "             LibraryUsers AS LU ON LI.LibraryName = LU.LibraryName" + '\t' + '\t' + " /*KEEP*/" + "\r\n";
			S = S + '\t' + "WHERE     (LU.UserID = \'" + CurrUserID + "\')" + '\t' + '\t' + " /*KEEP*/   /*ID56*/" + "\r\n";
			
			S = S + '\t' + "))" + " /*KEEP*/" + "\r\n";
			
			S = S + '\t' + " /* GLOBAL Searcher = " + bGlobalSearcher.ToString() + "  */" + '\t' + '\t' + " /*KEEP*/" + "\r\n";
			
			return S;
			
		}
		
		public string genLibrarySearch(string CurrUserID, bool GlobalSearcher, string LibraryName, string LocationID)
		{
			
			string S = "";
			//S = S + " SELECT GroupUsers.GroupName, Library.LibraryName, LibraryUsers.UserID, LibraryItems.SourceGuid" + chr(9) + chr(9) + " /*KEEP*/" + vbCrLf
			S = S + " /* GENID:" + LocationID + " *KEEP*/" + "\r\n";
			S = S + " SELECT LibraryItems.SourceGuid" + '\t' + '\t' + " /*KEEP*/" + "\r\n";
			S = S + '\t' + " FROM   LibraryItems INNER JOIN" + '\t' + '\t' + " /*KEEP*/" + "\r\n";
			S = S + '\t' + "        Library ON LibraryItems.LibraryName = Library.LibraryName INNER JOIN" + '\t' + '\t' + " /*KEEP*/" + "\r\n";
			S = S + '\t' + "        LibraryUsers ON Library.LibraryName = LibraryUsers.LibraryName INNER JOIN" + '\t' + '\t' + " /*KEEP*/" + "\r\n";
			S = S + '\t' + "        GroupLibraryAccess ON Library.LibraryName = GroupLibraryAccess.LibraryName INNER JOIN" + '\t' + '\t' + " /*KEEP*/" + "\r\n";
			S = S + '\t' + "        GroupUsers ON GroupLibraryAccess.GroupName = GroupUsers.GroupName" + '\t' + '\t' + " /*KEEP*/" + "\r\n";
			S = S + '\t' + " where " + '\t' + '\t' + " /*KEEP*/" + "\r\n";
			S = S + '\t' + "        Library.LibraryName =\'" + LibraryName + "\' " + '\t' + '\t' + " /*KEEP*/   /*ID57*/" + "\r\n";
			
			if (GlobalSearcher == false)
			{
				S = S + '\t' + " AND    libraryusers.userid =\'" + CurrUserID + "\' " + '\t' + '\t' + " /*KEEP*/" + "\r\n";
			}
			S = S + '\t' + "        /* GLOBAL Searcher = " + GlobalSearcher.ToString() + "  */" + '\t' + '\t' + " /*KEEP*/" + "\r\n";
			
			S = S + '\t' + "UNION " + '\t' + '\t' + " /*KEEP*/" + "\r\n";
			
			S = S + '\t' + "Select LI.SourceGuid" + '\t' + '\t' + " /*KEEP*/" + "\r\n";
			S = S + '\t' + "FROM   LibraryItems AS LI INNER JOIN" + '\t' + '\t' + " /*KEEP*/" + "\r\n";
			S = S + '\t' + "       LibraryUsers AS LU ON LI.LibraryName = LU.LibraryName" + '\t' + '\t' + " /*KEEP*/   /*ID58*/" + "\r\n";
			if (GlobalSearcher == false)
			{
				S = S + '\t' + "WHERE     LI.LibraryName = \'" + LibraryName + "\'" + '\t' + '\t' + " /*KEEP*/" + "\r\n";
				S = S + '\t' + "    AND LU.UserID = \'" + CurrUserID + "\'" + '\t' + '\t' + " /*KEEP*/" + "\r\n";
			}
			else
			{
				S = S + '\t' + "WHERE     LI.LibraryName = \'" + LibraryName + "\'" + '\t' + '\t' + " /*KEEP*/" + "\r\n";
			}
			
			return S;
			
		}
		
	}
	
}
