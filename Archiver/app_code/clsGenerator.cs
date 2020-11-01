using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using global::System.IO;
using Microsoft.VisualBasic;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{
    // Imports System.Data.Sql
    // Imports System.Data.SqlClient

    public class clsGenerator
    {
        private bool ddebug = false;
        public int TopRows = 0;
        public bool UseWeights = false;
        private string SortOrder = "";

        public string genDocPagingByRowHeader()
        {
            string S = " WITH xContent AS (" + Constants.vbCrLf;
            return S;
        }

        public string genDocPagingByRowFooter(int StartNbr, int EndNbr)
        {
            string S = "";
            S = S + " )" + Constants.vbCrLf;
            S = S + " SELECT * FROM xContent" + Constants.vbCrLf;
            S = S + " WHERE ROWID BETWEEN " + StartNbr.ToString() + " AND " + EndNbr.ToString() + Constants.vbCrLf;
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
            // Dim MetaDataType  = DBARCH.getAttributeDataType(MetaDataName )
            // Dim QuotesNeeded As Boolean = DBARCH.QuotesRequired(MetaDataType )

            if (Mandatory)
            {
                S = S + " and SourceGuid in ";
                S = S + " (";
                S = S + " Select D.SourceGuid";
                S = S + " FROM DataSource AS D INNER JOIN";
                S = S + " SourceAttribute AS S ON D.SourceGuid = S.SourceGuid";
                S = S + " WHERE (S.AttributeName = '" + MetaDataName + "' and AttributeValue like '" + MetaDataValue + "')";
                S = S + " )";
            }
            else
            {
                S = S + " OR SourceGuid in ";
                S = S + " (";
                S = S + " Select D.SourceGuid";
                S = S + " FROM DataSource AS D INNER JOIN";
                S = S + " SourceAttribute AS S ON D.SourceGuid = S.SourceGuid";
                S = S + " WHERE (S.AttributeName = '" + MetaDataName + "' and AttributeValue like '" + MetaDataValue + "')";
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
                    S = " AND (LastWriteTime >= GETDATE() - " + DaysOld + " OR CreateDate >= GETDATE() - " + DaysOld.ToString() + ")" + Constants.vbCrLf;
                }
                else
                {
                    S = " OR (LastWriteTime >= GETDATE() - " + DaysOld + " OR CreateDate >= GETDATE() - " + DaysOld.ToString() + ")" + Constants.vbCrLf;
                }
            }

            return S;
        }

        public string DocSearchLimitToCurrentGuids(string CurrUserID, bool ckLimitToExisting, List<string> CurrentGuids)
        {
            string S = "";
            if (ckLimitToExisting)
            {
                // DBARCH.LimitToExistingRecs(CurrentGuids)
                S = " AND (SourceGuid in (SELECT [DocGuid] FROM ActiveSearchGuids where  UserID = '" + CurrUserID + "'))";
            }

            return S;
        }

        public string DocSearchCreateDate(bool ckDate, string DATECODE, bool Mandatory, bool bReceived, bool bCreated, DateTime Startdate, DateTime EndDate)





        {
            if (!ckDate)
            {
                return string.Empty;
            }

            string S = string.Empty;
            switch (DATECODE ?? "")
            {
                case "AFTER":
                    {
                        if (Mandatory == true)
                        {
                            S += " AND ";
                        }
                        else
                        {
                            S += " OR ";
                        }

                        S += " (CreateDate > '" + Conversions.ToDate(Startdate).ToString() + "')" + Constants.vbCrLf;
                        break;
                    }

                case "BEFORE":
                    {
                        if (Mandatory == true)
                        {
                            S += " AND ";
                        }
                        else
                        {
                            S += " OR ";
                        }

                        S += " (CreateDate < '" + Conversions.ToDate(Startdate).ToString() + "')" + Constants.vbCrLf;
                        break;
                    }

                case "BETWEEN":
                    {
                        if (Mandatory == true)
                        {
                            S += " AND ";
                        }
                        else
                        {
                            S += " OR ";
                        }

                        S += " (CreateDate >= '" + Conversions.ToDate(Startdate).ToString() + "' AND CreateDate <= '" + Conversions.ToDate(EndDate).ToString() + "')" + Constants.vbCrLf;
                        break;
                    }

                case "NOT BETWEEN":
                    {
                        if (Mandatory == true)
                        {
                            S += " AND ";
                        }
                        else
                        {
                            S += " OR ";
                        }

                        S += " (CreateDate <= '" + Conversions.ToDate(Startdate).ToString() + "' AND CreateDate >= '" + Conversions.ToDate(EndDate).ToString() + "')" + Constants.vbCrLf;
                        break;
                    }

                case "ON":
                    {
                        if (Mandatory == true)
                        {
                            S += " AND ";
                        }
                        else
                        {
                            S += " OR ";
                        }

                        S += " (CreateDate = '" + Conversions.ToDate(Startdate).ToString() + "')" + Constants.vbCrLf;
                        break;
                    }

                default:
                    {
                        S = string.Empty;
                        break;
                    }
            }

            return S;
        }

        public string DocSearchDateLastWriteTime(bool ckDate, string DATECODE, bool Mandatory, bool bReceived, bool bCreated, DateTime Startdate, DateTime EndDate)





        {
            if (!ckDate)
            {
                return string.Empty;
            }

            string S = string.Empty;
            switch (DATECODE ?? "")
            {
                case "AFTER":
                    {
                        if (Mandatory == true)
                        {
                            S += " AND ";
                        }
                        else
                        {
                            S += " OR ";
                        }

                        S += " (LastWriteTime > '" + Conversions.ToDate(Startdate).ToString() + "')" + Constants.vbCrLf;
                        break;
                    }

                case "BEFORE":
                    {
                        if (Mandatory == true)
                        {
                            S += " AND ";
                        }
                        else
                        {
                            S += " OR ";
                        }

                        S += " (LastWriteTime < '" + Conversions.ToDate(Startdate).ToString() + "')" + Constants.vbCrLf;
                        break;
                    }

                case "BETWEEN":
                    {
                        if (Mandatory == true)
                        {
                            S += " AND ";
                        }
                        else
                        {
                            S += " OR ";
                        }

                        S += " (LastWriteTime >= '" + Conversions.ToDate(Startdate).ToString() + "' AND LastWriteTime <= '" + Conversions.ToDate(EndDate).ToString() + "')" + Constants.vbCrLf;
                        break;
                    }

                case "NOT BETWEEN":
                    {
                        if (Mandatory == true)
                        {
                            S += " AND ";
                        }
                        else
                        {
                            S += " OR ";
                        }

                        S += " (LastWriteTime <= '" + Conversions.ToDate(Startdate).ToString() + "' AND LastWriteTime >= '" + Conversions.ToDate(EndDate).ToString() + "')" + Constants.vbCrLf;
                        break;
                    }

                case "ON":
                    {
                        if (Mandatory == true)
                        {
                            S += " AND ";
                        }
                        else
                        {
                            S += " OR ";
                        }

                        S += " (LastWriteTime = '" + Conversions.ToDate(Startdate).ToString() + "')" + Constants.vbCrLf;
                        break;
                    }

                default:
                    {
                        S = string.Empty;
                        break;
                    }
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
                S += " AND (FileDirectory like '" + FileDirectory + "' )";
            }
            else
            {
                S += " OR (FileDirectory like '" + FileDirectory + "' )";
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
            S += " and KEY_TBL.RANK >= " + MinWeight + Constants.vbCrLf;
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
                S += " AND (OriginalFileType like '" + EXT + "' )";
            }
            else
            {
                S += " OR (OriginalFileType like '" + EXT + "' )";
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
                S += " AND (SourceName like '" + FQN + "' )";
            }
            else
            {
                S += " OR (SourceName like '" + FQN + "' )";
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
                S = S + "Select " + Constants.vbCrLf;
                S += Constants.vbTab + " KEY_TBL.RANK, DS.SourceName 	" + Constants.vbCrLf;
                S += Constants.vbTab + ",DS.CreateDate " + Constants.vbCrLf;
                S += Constants.vbTab + ",DS.VersionNbr 	" + Constants.vbCrLf;
                S += Constants.vbTab + ",DS.LastAccessDate " + Constants.vbCrLf;
                S += Constants.vbTab + ",DS.FileLength " + Constants.vbCrLf;
                S += Constants.vbTab + ",DS.LastWriteTime " + Constants.vbCrLf;
                S += Constants.vbTab + ",DS.OriginalFileType 		" + Constants.vbCrLf;
                S += Constants.vbTab + ",DS.isPublic " + Constants.vbCrLf;
                S += Constants.vbTab + ",DS.FQN " + Constants.vbCrLf;
                S += Constants.vbTab + ",DS.SourceGuid " + Constants.vbCrLf;
                S += Constants.vbTab + ",DS.DataSourceOwnerUserID, DS.FileDirectory, DS.RetentionExpirationDate, DS.isMaster, DS.StructuredData, DS.RepoSvrName " + Constants.vbCrLf;
                S += "FROM DataSource as DS " + Constants.vbCrLf;
                S += genIsAbout(ckWeighted, ckBusiness, searchCriteria.Trim(), false);
            }

            // If bSaveToClipBoard Then
            // Clipboard.SetText(s)
            // End If

            else
            {
                S = S + "Select " + Constants.vbCrLf;
                S += Constants.vbTab + "[SourceName] 	" + Constants.vbCrLf;
                S += Constants.vbTab + ",[CreateDate] " + Constants.vbCrLf;
                S += Constants.vbTab + ",[VersionNbr] 	" + Constants.vbCrLf;
                S += Constants.vbTab + ",[LastAccessDate] " + Constants.vbCrLf;
                S += Constants.vbTab + ",[FileLength] " + Constants.vbCrLf;
                S += Constants.vbTab + ",[LastWriteTime] " + Constants.vbCrLf;
                S += Constants.vbTab + ",[OriginalFileType] 		" + Constants.vbCrLf;
                S += Constants.vbTab + ",[isPublic] " + Constants.vbCrLf;
                S += Constants.vbTab + ",[FQN] " + Constants.vbCrLf;
                S += Constants.vbTab + ",[SourceGuid] " + Constants.vbCrLf;
                S += Constants.vbTab + ",[DataSourceOwnerUserID], FileDirectory, RetentionExpirationDate, isMaster, StructuredData, RepoSvrName " + Constants.vbCrLf;
                S += "FROM DataSource " + Constants.vbCrLf;
                // If bSaveToClipBoard Then
                // Clipboard.SetText(s)
                // End If
            }

            return S;
        }

        public string DocSearchGenColsPaging(bool ckWeighted, string searchCriteria)
        {
            bool ckBusiness = false;
            string S = "";
            if (ckWeighted == true)
            {
                S = S + "Select " + Constants.vbCrLf;
                S += Constants.vbTab + "KEY_TBL.RANK (";
                S += Constants.vbTab + ",DS.SourceName" + Constants.vbCrLf;
                S += Constants.vbTab + ",DS.CreateDate " + Constants.vbCrLf;
                S += Constants.vbTab + ",DS.VersionNbr 	" + Constants.vbCrLf;
                S += Constants.vbTab + ",DS.LastAccessDate " + Constants.vbCrLf;
                S += Constants.vbTab + ",DS.FileLength " + Constants.vbCrLf;
                S += Constants.vbTab + ",DS.LastWriteTime " + Constants.vbCrLf;
                S += Constants.vbTab + ",DS.OriginalFileType 		" + Constants.vbCrLf;
                S += Constants.vbTab + ",DS.isPublic " + Constants.vbCrLf;
                S += Constants.vbTab + ",DS.FQN " + Constants.vbCrLf;
                S += Constants.vbTab + ",DS.SourceGuid " + Constants.vbCrLf;
                S += Constants.vbTab + ",DS.DataSourceOwnerUserID, ";
                S += Constants.vbTab + ",DS.FileDirectory ";
                S += Constants.vbTab + ",DS.RetentionExpirationDate ";
                S += Constants.vbTab + ",DS.isMaster ";
                S += Constants.vbTab + ",DS.StructuredData" + Constants.vbCrLf;
                S += Constants.vbTab + ",ROW_NUMBER() OVER (ORDER BY SourceName ASC) AS ROWID, RepoSvrName  )" + Constants.vbCrLf;
                S += "FROM DataSource as DS " + Constants.vbCrLf;
                S += genIsAbout(ckWeighted, ckBusiness, searchCriteria.Trim(), false);
            }

            // If bSaveToClipBoard Then
            // Clipboard.SetText(s)
            // End If

            else
            {
                S = S + "Select " + Constants.vbCrLf;
                S += Constants.vbTab + "[SourceName] 	" + Constants.vbCrLf;
                S += Constants.vbTab + ",[CreateDate] " + Constants.vbCrLf;
                S += Constants.vbTab + ",[VersionNbr] 	" + Constants.vbCrLf;
                S += Constants.vbTab + ",[LastAccessDate] " + Constants.vbCrLf;
                S += Constants.vbTab + ",[FileLength] " + Constants.vbCrLf;
                S += Constants.vbTab + ",[LastWriteTime] " + Constants.vbCrLf;
                S += Constants.vbTab + ",[OriginalFileType] 		" + Constants.vbCrLf;
                S += Constants.vbTab + ",[isPublic] " + Constants.vbCrLf;
                S += Constants.vbTab + ",[FQN] " + Constants.vbCrLf;
                S += Constants.vbTab + ",[SourceGuid] " + Constants.vbCrLf;
                S += Constants.vbTab + ",[DataSourceOwnerUserID]";
                S += Constants.vbTab + ", FileDirectory";
                S += Constants.vbTab + ", RetentionExpirationDate";
                S += Constants.vbTab + ", isMaster";
                S += Constants.vbTab + ", StructuredData " + Constants.vbCrLf;
                S += Constants.vbTab + ",ROW_NUMBER() OVER (ORDER BY SourceName ASC) AS ROWID, RepoSvrName  " + Constants.vbCrLf;
                S += "FROM DataSource " + Constants.vbCrLf;
                // If bSaveToClipBoard Then
                // Clipboard.SetText(s)
                // End If
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
            CorrectedSearchClause = CorrectedSearchClause.Trim();
            if (CorrectedSearchClause.Length > 2)
            {
                string C = Strings.Mid(CorrectedSearchClause, CorrectedSearchClause.Length, 1);
                if (C.Equals(","))
                {
                    CorrectedSearchClause = Strings.Mid(CorrectedSearchClause, 1, CorrectedSearchClause.Length - 1);
                    CorrectedSearchClause = CorrectedSearchClause.Trim();
                }
            }

            if (isEmailSearch == true)
            {
                if (useFreetext == true)
                {
                    // INNER JOIN FREETEXTTABLE(dataSource, *,
                    // 'ISABOUT ("dale miller", "susan miller", jessica )' ) AS KEY_TBL
                    // ON DS.SourceGuid = KEY_TBL.[KEY]
                    isAboutClause += "INNER JOIN FREETEXTTABLE(EMAIL, *, " + Constants.vbCrLf;
                    isAboutClause += "     'ISABOUT (";
                    isAboutClause += CorrectedSearchClause;
                    isAboutClause += ")' ) as KEY_TBL" + Constants.vbCrLf;
                    isAboutClause += "          ON DS.EmailGuid = KEY_TBL.[KEY]" + Constants.vbCrLf;
                }
                else
                {
                    // INNER JOIN CONTAINSTABLE(dataSource, *,
                    // 'ISABOUT ("dale miller", 
                    // "susan miller", jessica )' ) AS KEY_TBL
                    // ON DS.SourceGuid = KEY_TBL.[KEY]
                    isAboutClause += "INNER JOIN CONTAINSTABLE(EMAIL, *, " + Constants.vbCrLf;
                    isAboutClause += "     'ISABOUT (";
                    isAboutClause += CorrectedSearchClause;
                    isAboutClause += ")' ) as KEY_TBL" + Constants.vbCrLf;
                    isAboutClause += "          ON DS.EmailGuid = KEY_TBL.[KEY]" + Constants.vbCrLf;
                }
            }
            else if (useFreetext == true)
            {
                // INNER JOIN FREETEXTTABLE(dataSource, *,
                // 'ISABOUT ("dale miller", "susan miller", jessica )' ) AS KEY_TBL
                // ON DS.SourceGuid = KEY_TBL.[KEY]
                isAboutClause += "INNER JOIN FREETEXTTABLE(dataSource, SourceImage, " + Constants.vbCrLf;
                isAboutClause += "     'ISABOUT (";
                isAboutClause += CorrectedSearchClause;
                isAboutClause += ")' ) as KEY_TBL" + Constants.vbCrLf;
                isAboutClause += "          ON DS.SourceGuid = KEY_TBL.[KEY]" + Constants.vbCrLf;
            }
            else
            {
                // INNER JOIN CONTAINSTABLE(dataSource, *,
                // 'ISABOUT ("dale miller", 
                // "susan miller", jessica )' ) AS KEY_TBL
                // ON DS.SourceGuid = KEY_TBL.[KEY]
                isAboutClause += "INNER JOIN CONTAINSTABLE(dataSource, *, " + Constants.vbCrLf;
                isAboutClause += "     'ISABOUT (";
                isAboutClause += CorrectedSearchClause;
                isAboutClause += ")' ) as KEY_TBL" + Constants.vbCrLf;
                isAboutClause += "          ON DS.SourceGuid = KEY_TBL.[KEY]" + Constants.vbCrLf;
            }

            return isAboutClause;
        }

        public string CleanIsAboutSearchText(string SearchText)
        {
            int I = 0;
            var A = new ArrayList();
            string CH = "";
            string Token = "";
            string S = "";
            bool SkipNextToken = false;
            var loopTo = SearchText.Trim().Length;
            for (I = 1; I <= loopTo; I++)
            {
                REEVAL:
                ;
                CH = Strings.Mid(SearchText, I, 1);
                if (CH.Equals(Conversions.ToString('"')))
                {
                    // ** Get the token in quotes
                    bool PreceedingPlusSign = false;
                    bool PreceedingMinusSign = false;
                    if (Token.Equals("+") | Token.Equals("-"))
                    {
                        PreceedingPlusSign = true;
                        Token = "";
                    }
                    else if (Token.Equals("+") | Token.Equals("-"))
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


                    // ** go to the next one
                    I += 1;
                    CH = Strings.Mid(SearchText, I, 1);
                    Token += CH;
                    while (CH != Conversions.ToString('"') & I <= SearchText.Length)
                    {
                        I += 1;
                        CH = Strings.Mid(SearchText, I, 1);
                        Token += CH;
                    }
                    // Token = Chr(34) + Token
                    if (PreceedingPlusSign == true)
                    {
                        Token = "+" + Conversions.ToString('"') + Token;
                    }
                    // Dim NextChar  = getNextChar(SearchText , I)
                    // If NextChar  = "-" Then
                    // '** We skip the next token in the stmt
                    // End If
                    else if (PreceedingMinusSign == true)
                    {
                        Token = "-" + Conversions.ToString('"') + Token;
                    }
                    // Dim NextChar  = getNextChar(SearchText , I)
                    // If NextChar  = "+" Then
                    // '** We skip the next token in the stmt
                    // End If
                    else
                    {
                        Token = Conversions.ToString('"') + Token;
                    }

                    A.Add(Token);
                    Token = "";
                }
                else if (CH.Equals(" ") | CH == " ")
                {
                    // ** Skip the blank spaces
                    if (Token.Equals("+") | Token.Equals("-"))
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


                    // ** go to the next one
                    I += 1;
                    CH = Strings.Mid(SearchText, I, 1);
                    while (CH == " " & I <= SearchText.Length)
                    {
                        I += 1;
                        CH = Strings.Mid(SearchText, I, 1);
                    }

                    goto REEVAL;
                }
                else if (CH.Equals(","))
                {
                    // ** Skip the blank spaces
                    if (Token.Length > 0)
                    {
                        A.Add(Token);
                    }

                    Token = "";
                }
                else if (CH.Equals("+"))
                {
                    // ** Skip the blank spaces
                    string NextChar = getNextChar(SearchText, I);
                    if (NextChar == "-")
                    {
                        // ** We skip the next token in the stmt
                        SkipNextToken = true;
                        A.Add("~");
                    }

                    Token += "";
                }
                else if (CH.Equals("^"))
                {
                    // ** Skip the blank spaces
                    Token += "";
                }
                else if (CH.Equals("~"))
                {
                    // ** Skip the blank spaces
                    Token += "";
                }
                else if (CH.Equals("(") | CH.Equals(")"))
                {
                    // ** Skip the blank spaces
                    Token += "";
                }
                else if (CH.Equals("-"))
                {
                    // ** Skip the blank spaces
                    string NextChar = getNextChar(SearchText, I);
                    if (NextChar == "+")
                    {
                        // ** We skip the next token in the stmt
                        SkipNextToken = true;
                        A.Add("~");
                    }

                    Token += "";
                }
                else if (CH.Equals("|"))
                {
                    // ** Skip the blank spaces
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
            var loopTo1 = A.Count - 1;
            for (I = 0; I <= loopTo1; I++)
            {
                string tWord = Conversions.ToString(A[I]);
                tWord = Strings.UCase(tWord);
                if (tWord.Equals("~"))
                {
                    // ** we skip the next word period
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
                else if (skipNextWord)
                {
                    skipNextWord = false;
                }
                else if (I == A.Count - 1)
                {
                    S = S + A[I].ToString();
                }
                else
                {
                    S = S + A[I].ToString() + ", ";
                }
            }

            return S;
        }

        public string getNextChar(string S, int i)
        {
            string CH = "";
            if (S.Trim().Length > i + 1)
            {
                i += 1;
                CH = Strings.Mid(S, i, 1);
            }

            while (CH == " " & i <= S.Length)
            {
                i += 1;
                if (S.Trim().Length < i + 1)
                {
                    CH = Strings.Mid(S, i, 1);
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

            S = S + " (AllRecipients like '" + FixSingleQuote(Name) + "' or " + Constants.vbCrLf;
            S = S + "      CC like '" + FixSingleQuote(Name) + "' or " + Constants.vbCrLf;
            S = S + "      BCC like '" + FixSingleQuote(Name) + "') " + Constants.vbCrLf;
            return S;
        }

        public string EmailSearchMyEmailsOnly(string CurrUserID, bool bLimitReturn, bool isGlobalSearcher)
        {
            string S = string.Empty;
            if (isGlobalSearcher == false)
            {
                S += " AND (where UserID = '" + CurrUserID + "' or isPublic = 'Y' )";
                return S;
            }

            if (bLimitReturn == false)
            {
                return string.Empty;
            }

            S += " AND (where UserID = '" + CurrUserID + "' or isPublic = 'Y' )";
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

            S = S + " (CC like '" + FixSingleQuote(Name) + "' or " + Constants.vbCrLf;
            S = S + " BCC like '" + FixSingleQuote(Name) + "')  " + Constants.vbCrLf;
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

            S = S + " (SUBJECT Like '" + Name + "') " + Constants.vbCrLf;
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

            S = S + " (OriginalFolder LIKE '" + FixSingleQuote(Name) + "') " + Constants.vbCrLf;
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

            S = S + " (ReceivedByName like '" + FixSingleQuote(Name) + "') " + Constants.vbCrLf;
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

            S = S + " (SenderName like '" + FixSingleQuote(Name) + "') " + Constants.vbCrLf;
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

            S = S + " ( SentTO like '" + FixSingleQuote(EmailAddr) + "' or" + Constants.vbCrLf;
            S = S + " AllRecipients like '" + FixSingleQuote(EmailAddr) + "') " + Constants.vbCrLf;
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

            S = S + " (SenderEmailAddress like '" + FixSingleQuote(EmailAddr) + "') " + Constants.vbCrLf;
            return S;
        }

        public string EmailSearchDateLimits(bool ckDate, string DATECODE, bool Mandatory, bool bSent, bool bReceived, bool bCreated, DateTime Startdate, DateTime EndDate)






        {
            if (!ckDate)
            {
                return string.Empty;
            }

            string S = string.Empty;
            switch (DATECODE ?? "")
            {
                case "AFTER":
                    {
                        if (bSent)       // SentOn
                        {
                            if (Mandatory == true)
                            {
                                S += " AND ";
                            }
                            else
                            {
                                S += " OR ";
                            }

                            S += " (SentOn > '" + Conversions.ToDate(Startdate).ToString() + "')" + Constants.vbCrLf;
                        }

                        if (bReceived)   // ReceivedTime
                        {
                            if (Mandatory == true)
                            {
                                S += " AND ";
                            }
                            else
                            {
                                S += " OR ";
                            }

                            S += " (ReceivedTime > '" + Conversions.ToDate(Startdate).ToString() + "')" + Constants.vbCrLf;
                        }

                        if (bCreated)    // CreateDate
                        {
                            if (Mandatory == true)
                            {
                                S += " AND ";
                            }
                            else
                            {
                                S += " OR ";
                            }

                            S += " (CreateDate > '" + Conversions.ToDate(Startdate).ToString() + "')" + Constants.vbCrLf;
                        }

                        break;
                    }

                case "BEFORE":
                    {
                        if (bSent)       // SentOn
                        {
                            if (Mandatory == true)
                            {
                                S += " AND ";
                            }
                            else
                            {
                                S += " OR ";
                            }

                            S += " (SentOn < '" + Conversions.ToDate(Startdate).ToString() + "')" + Constants.vbCrLf;
                        }

                        if (bReceived)   // ReceivedTime
                        {
                            if (Mandatory == true)
                            {
                                S += " AND ";
                            }
                            else
                            {
                                S += " OR ";
                            }

                            S += " (ReceivedTime < '" + Conversions.ToDate(Startdate).ToString() + "')" + Constants.vbCrLf;
                        }

                        if (bCreated)    // CreateDate
                        {
                            if (Mandatory == true)
                            {
                                S += " AND ";
                            }
                            else
                            {
                                S += " OR ";
                            }

                            S += " (CreateDate < '" + Conversions.ToDate(Startdate).ToString() + "')" + Constants.vbCrLf;
                        }

                        break;
                    }

                case "BETWEEN":
                    {
                        if (bSent)       // SentOn
                        {
                            if (Mandatory == true)
                            {
                                S += " AND ";
                            }
                            else
                            {
                                S += " OR ";
                            }

                            S += " (SentOn >= '" + Conversions.ToDate(Startdate).ToString() + "' AND SentOn <= '" + Conversions.ToDate(EndDate).ToString() + "')" + Constants.vbCrLf;
                        }

                        if (bReceived)   // ReceivedTime
                        {
                            if (Mandatory == true)
                            {
                                S += " AND ";
                            }
                            else
                            {
                                S += " OR ";
                            }

                            S += " (ReceivedTime >= '" + Conversions.ToDate(Startdate).ToString() + "' AND ReceivedTime <= '" + Conversions.ToDate(EndDate).ToString() + "')" + Constants.vbCrLf;
                        }

                        if (bCreated)    // CreateDate
                        {
                            if (Mandatory == true)
                            {
                                S += " AND ";
                            }
                            else
                            {
                                S += " OR ";
                            }

                            S += " (CreateDate >= '" + Conversions.ToDate(Startdate).ToString() + "' AND CreateDate <= '" + Conversions.ToDate(EndDate).ToString() + "')" + Constants.vbCrLf;
                        }

                        break;
                    }

                case "NOT BETWEEN":
                    {
                        if (bSent)       // SentOn
                        {
                            if (Mandatory == true)
                            {
                                S += " AND ";
                            }
                            else
                            {
                                S += " OR ";
                            }

                            S += " (SentOn <= '" + Conversions.ToDate(Startdate).ToString() + "' AND SentOn >= '" + Conversions.ToDate(EndDate).ToString() + "')" + Constants.vbCrLf;
                        }

                        if (bReceived)   // ReceivedTime
                        {
                            if (Mandatory == true)
                            {
                                S += " AND ";
                            }
                            else
                            {
                                S += " OR ";
                            }

                            S += " (ReceivedTime <= '" + Conversions.ToDate(Startdate).ToString() + "' AND ReceivedTime >= '" + Conversions.ToDate(EndDate).ToString() + "')" + Constants.vbCrLf;
                        }

                        if (bCreated)    // CreateDate
                        {
                            if (Mandatory == true)
                            {
                                S += " AND ";
                            }
                            else
                            {
                                S += " OR ";
                            }

                            S += " (CreateDate <= '" + Conversions.ToDate(Startdate).ToString() + "' AND CreateDate >= '" + Conversions.ToDate(EndDate).ToString() + "')" + Constants.vbCrLf;
                        }

                        break;
                    }

                case "ON":
                    {
                        if (bSent)       // SentOn
                        {
                            if (Mandatory == true)
                            {
                                S += " AND ";
                            }
                            else
                            {
                                S += " OR ";
                            }

                            S += " (SentOn = '" + Conversions.ToDate(Startdate).ToString() + "')" + Constants.vbCrLf;
                        }

                        if (bReceived)   // ReceivedTime
                        {
                            if (Mandatory == true)
                            {
                                S += " AND ";
                            }
                            else
                            {
                                S += " OR ";
                            }

                            S += " (ReceivedTime = '" + Conversions.ToDate(Startdate).ToString() + "')" + Constants.vbCrLf;
                        }

                        if (bCreated)    // CreateDate
                        {
                            if (Mandatory == true)
                            {
                                S += " AND ";
                            }
                            else
                            {
                                S += " OR ";
                            }

                            S += " (CreateDate = '" + Conversions.ToDate(Startdate).ToString() + "')" + Constants.vbCrLf;
                        }

                        break;
                    }

                default:
                    {
                        S = string.Empty;
                        break;
                    }
            }

            return S;
        }

        public string EmailGenColsNoWeights(string ContainsClause)
        {
            string S = "";
            ContainsClause = FixSingleQuote(ContainsClause);
            S = S + " SELECT     Email.SentOn, Email.ShortSubj, Email.SenderEmailAddress, Email.SenderName, Email.SentTO, SUBSTRING(Email.Body, 1, 100) AS Body, Email.CC, Email.Bcc, " + Constants.vbCrLf;
            S = S + "                       Email.CreationTime, Email.AllRecipients, Email.ReceivedByName, Email.ReceivedTime, Email.MsgSize, Email.SUBJECT, Email.OriginalFolder, Email.EmailGuid, " + Constants.vbCrLf;
            S = S + "                       Email.RetentionExpirationDate, Email.isPublic, Email.ConvertEmlToMSG, Email.UserID, Email.NbrAttachments, Email.SourceTypeCode, 'N' AS FoundInAttachment," + Constants.vbCrLf;
            S = S + "                       EmailAttachment.RowID" + Constants.vbCrLf;
            S = S + " FROM         Email FULL OUTER JOIN" + Constants.vbCrLf;
            S = S + "                       EmailAttachment ON Email.EmailGuid = EmailAttachment.EmailGuid" + Constants.vbCrLf;
            S = S + " WHERE" + Constants.vbCrLf;
            S = S + " (" + Constants.vbCrLf;
            S = S + " CONTAINS(Email.*, '" + ContainsClause + "') OR" + Constants.vbCrLf;
            S = S + " CONTAINS(EmailAttachment.*, '" + ContainsClause + "') " + Constants.vbCrLf;
            S = S + " ) " + Constants.vbCrLf;
            return S;
        }

        public string EmailGenColsNoWeights()
        {
            string S = "";
            S = S + " SELECT     Email.SentOn, Email.ShortSubj, Email.SenderEmailAddress, Email.SenderName, Email.SentTO, SUBSTRING(Email.Body, 1, 100) AS Body, Email.CC, Email.Bcc, " + Constants.vbCrLf;
            S = S + "                       Email.CreationTime, Email.AllRecipients, Email.ReceivedByName, Email.ReceivedTime, Email.MsgSize, Email.SUBJECT, Email.OriginalFolder, Email.EmailGuid, " + Constants.vbCrLf;
            S = S + "                       Email.RetentionExpirationDate, Email.isPublic, Email.ConvertEmlToMSG, Email.UserID, Email.NbrAttachments, Email.SourceTypeCode, 'N' AS FoundInAttachment," + Constants.vbCrLf;
            S = S + "                       EmailAttachment.RowID" + Constants.vbCrLf;
            S = S + " FROM         Email FULL OUTER JOIN" + Constants.vbCrLf;
            S = S + "                       EmailAttachment ON Email.EmailGuid = EmailAttachment.EmailGuid" + Constants.vbCrLf;
            S = S + " WHERE" + Constants.vbCrLf;
            return S;
        }

        public void genNewEmailQuery(ref string GeneratedSql)
        {
            var a = GeneratedSql.Split(Conversions.ToChar(Constants.vbCrLf));
            string S = "";
            bool bNextWhereStmt = false;
            bool bGenNewSql = false;
            string NewSql = "";
            string StdQueryCols = genStdEmailQqueryCols();
            bool doNotAppend = false;
            bool bContainsTable = false;
            for (int i = 0, loopTo = Information.UBound(a); i <= loopTo; i++)
            {
                S = a[i];
                S = S.Trim();
                if (Strings.InStr(S, "FROM EMAIL ", CompareMethod.Text) > 0)
                {
                    bNextWhereStmt = true;
                }

                if (Strings.InStr(S, "INNER JOIN CONTAINSTABLE", CompareMethod.Text) > 0 & bNextWhereStmt == true)
                {
                    bGenNewSql = true;
                }

                if (Strings.InStr(S, "WHERE", CompareMethod.Text) > 0 & bNextWhereStmt == true)
                {
                    if (Strings.Left(S, 5).ToUpper().Equals("WHERE"))
                    {
                        bNextWhereStmt = false;
                        bGenNewSql = true;
                    }
                }

                // If UseWeights = True Then
                // S = S + vbTab + "FROM Email as DS "
                // S = ReplacePrefix(Prefix, "email.", S)
                // Else
                // S = S + vbTab + "FROM Email "
                // End If

                if (Strings.InStr(S, "CONTAINS", CompareMethod.Text) > 0)
                {
                    if (Strings.Left(S, "CONTAINS".Length).ToUpper().Equals("CONTAINS"))
                    {
                        string TempStr = RemoveSpaces(S);
                        TempStr = TempStr.ToUpper();
                        if (Strings.InStr(TempStr, "CONTAINS(*", CompareMethod.Text) > 0)
                        {
                            int k = Strings.InStr(S, "*");
                            string S1 = "";
                            string S2 = "";
                            S1 = Strings.Mid(S, 1, k - 1);
                            S2 = Strings.Mid(S, k + 1);
                            S = S1 + "Email.*" + S2;
                            a[i] = S;
                        }
                    }
                }

                if (Strings.InStr(S, "order by", CompareMethod.Text) > 0 & bGenNewSql == true)
                {
                    if (Strings.Left(S, 8).ToUpper().Equals("ORDER BY"))
                    {
                        doNotAppend = true;
                        a[i] = "";
                        break;
                    }
                }

                if (bGenNewSql == true & doNotAppend == false & a[i].Trim().Length > 0)
                {
                    NewSql = NewSql + Constants.vbCrLf + a[i];
                }
            }

            NewSql = StdQueryCols + Constants.vbCrLf + NewSql;
            GeneratedSql = NewSql;

            // Clipboard.Clear()
            // Clipboard.SetText(NewSql)

        }

        public void genNewEmailAttachmentQuery(ref string GeneratedSql)
        {
            var a = GeneratedSql.Split(Conversions.ToChar(Constants.vbCrLf));
            string S = "";
            bool bNextWhereStmt = false;
            bool bGenNewSql = false;
            string NewSql = "";
            string StdQueryCols = genStdEmailAttachmentQqueryCols();
            bool doNotAppend = false;
            for (int i = 0, loopTo = Information.UBound(a); i <= loopTo; i++)
            {
                S = a[i];
                S = S.Trim();
                if (Strings.InStr(S, "FROM EMAIL ", CompareMethod.Text) > 0)
                {
                    bNextWhereStmt = true;
                }

                if (Strings.InStr(S, "JOIN CONTAINSTABLE", CompareMethod.Text) > 0 & bNextWhereStmt == true)
                {
                    bGenNewSql = true;
                }

                if (Strings.InStr(S, "WHERE", CompareMethod.Text) > 0 & bNextWhereStmt == true)
                {
                    if (Strings.Left(S, 5).ToUpper().Equals("WHERE"))
                    {
                        bNextWhereStmt = false;
                        bGenNewSql = true;
                    }
                }

                if (Strings.InStr(S, "CONTAINS(body", CompareMethod.Text) > 0)
                {
                    string TempStr = RemoveSpaces(S);
                    int k = Strings.InStr(S, "CONTAINS(body", CompareMethod.Text);
                    k = Strings.InStr(k + 1, S, "(", CompareMethod.Text);
                    int L = Strings.InStr(k + 1, S, ",");
                    string S1 = "";
                    string S2 = "";
                    string tPart = Strings.Mid(S, k, L - k + 1);
                    S1 = Strings.Mid(S, 1, k);
                    S2 = Strings.Mid(S, L);
                    S = S1 + "Attachment" + S2;
                    a[i] = S;
                }

                if (Strings.InStr(S, "or CONTAINS(", CompareMethod.Text) > 0)
                {
                    a[i] = "";
                }

                if (Strings.InStr(S, "order by", CompareMethod.Text) > 0 & bGenNewSql == true)
                {
                    if (Strings.Left(S, 8).ToUpper().Equals("ORDER BY"))
                    {
                        doNotAppend = true;
                        a[i] = "";
                        break;
                    }
                }

                if (Strings.InStr(S, "Select EmailGuid from EmailAttachmentSearchList", CompareMethod.Text) > 0)
                {
                    a[i] = "";
                }

                if (Strings.InStr(S, "OR", CompareMethod.Text) > 0)
                {
                    if (Strings.InStr(S, "select", CompareMethod.Text) > 0)
                    {
                        if (Strings.InStr(S, "EmailGuid", CompareMethod.Text) > 0)
                        {
                            if (Strings.InStr(S, "EmailAttachmentSearchList", CompareMethod.Text) > 0)
                            {
                                a[i] = "";
                            }
                        }
                    }
                }

                if (bGenNewSql == true & doNotAppend == false & a[i].Trim().Length > 0)
                {
                    NewSql = NewSql + Constants.vbCrLf + a[i];
                }
            }

            NewSql = StdQueryCols + Constants.vbCrLf + NewSql;
            GeneratedSql = NewSql;

            // Clipboard.Clear()
            // Clipboard.SetText(NewSql)

        }

        public void genNewDocQuery(ref string GeneratedSql)
        {
            var a = GeneratedSql.Split(Conversions.ToChar(Constants.vbCrLf));
            string S = "";
            bool bNextWhereStmt = false;
            bool bGenNewSql = false;
            string NewSql = "";
            string StdQueryCols = genStdDocQueryCols();
            bool doNotAppend = false;
            for (int i = 0, loopTo = Information.UBound(a); i <= loopTo; i++)
            {
                S = a[i];
                S = S.Trim();
                if (Strings.InStr(S, "FROM ", CompareMethod.Text) > 0)
                {
                    if (Strings.InStr(S, "DataSource", CompareMethod.Text) > 0)
                    {
                        if (Strings.Left(S, "FROM".Length).ToUpper().Equals("FROM"))
                        {
                            bNextWhereStmt = true;
                        }
                    }
                }

                if (Strings.InStr(S, "JOIN CONTAINSTABLE", CompareMethod.Text) > 0 & bNextWhereStmt == true)
                {
                    Console.WriteLine("Here");
                    bGenNewSql = true;
                }

                if (Strings.InStr(S, "WHERE", CompareMethod.Text) > 0 & bNextWhereStmt == true)
                {
                    if (Strings.Left(S, 5).ToUpper().Equals("WHERE"))
                    {
                        bNextWhereStmt = false;
                        bGenNewSql = true;
                    }
                }

                if (Strings.InStr(S, "CONTAINS", CompareMethod.Text) > 0)
                {
                    if (Strings.Left(S, "CONTAINS".Length).ToUpper().Equals("CONTAINS"))
                    {
                        string TempStr = RemoveSpaces(S);
                        TempStr = TempStr.ToUpper();
                        if (Strings.InStr(TempStr, "CONTAINS(*", CompareMethod.Text) > 0)
                        {
                            int k = Strings.InStr(S, "*");
                            string S1 = "";
                            string S2 = "";
                            S1 = Strings.Mid(S, 1, k - 1);
                            S2 = Strings.Mid(S, k + 1);
                            S = S1 + "DataSource.*" + S2;
                            a[i] = S;
                        }
                    }
                }

                if (Strings.InStr(S, "order by", CompareMethod.Text) > 0 & bGenNewSql == true)
                {
                    if (Strings.Left(S, 8).ToUpper().Equals("ORDER BY"))
                    {
                        doNotAppend = true;
                        a[i] = "";
                        break;
                    }
                }

                if (bGenNewSql == true & doNotAppend == false & a[i].Trim().Length > 0)
                {
                    NewSql = NewSql + Constants.vbCrLf + a[i];
                }
            }

            NewSql = StdQueryCols + Constants.vbCrLf + NewSql;
            GeneratedSql = NewSql;

            // Clipboard.Clear()
            // Clipboard.SetText(GeneratedSql)

        }

        public string genStdEmailQqueryCols()
        {
            string S = "";
            string Prefix = "";
            if (TopRows > 0)
            {
                S = S + "Select top " + TopRows.ToString() + " " + Constants.vbCrLf;
            }
            else
            {
                S = S + "Select " + Constants.vbCrLf;
            }

            if (UseWeights == true)
            {
                S = S + Constants.vbTab + "KEY_TBL.RANK as Weight, " + Constants.vbCrLf;
                Prefix = "DS.";
            }
            else
            {
                S = S + Constants.vbTab + "null as Weight, " + Constants.vbCrLf;
                Prefix = "";
            }

            S = S + Constants.vbTab + "Email.ShortSubj as ContentTitle, " + Constants.vbCrLf;
            S = S + Constants.vbTab + "(select COUNT(*) from EmailAttachment where EmailAttachment.EmailGuid = Email.EmailGuid) as NbrOfAttachments, " + Constants.vbCrLf;
            S = S + Constants.vbTab + "Email.SenderEmailAddress AS ContentAuthor, " + Constants.vbCrLf;
            S = S + Constants.vbTab + "Email.SourceTypeCode as  ContentExt, " + Constants.vbCrLf;
            S = S + Constants.vbTab + "Email.CreationTime AS CreateDate, " + Constants.vbCrLf;
            S = S + Constants.vbTab + "Email.ShortSubj as  FileName, " + Constants.vbCrLf;
            S = S + Constants.vbTab + "Email.AllRecipients, " + Constants.vbCrLf;
            S = S + Constants.vbTab + "Email.EmailGuid as ContentGuid, " + Constants.vbCrLf;
            S = S + Constants.vbTab + "Email.MsgSize  as FileSize, " + Constants.vbCrLf;
            S = S + Constants.vbTab + "Email.SenderEmailAddress AS FromEmailAddress, " + Constants.vbCrLf;
            // S = S + vbTab + "Users.UserLoginID, " + vbCrLf
            S = S + "(Select UserLoginID from Users where email.UserID = Users.UserID) as UserLoginUD, " + Constants.vbCrLf;
            S = S + Constants.vbTab + "Email.USERID, " + Constants.vbCrLf;
            S = S + Constants.vbTab + "null as RowID, " + Constants.vbCrLf;
            S = S + Constants.vbTab + "'EMAIL' AS Classification, " + Constants.vbCrLf;
            S = S + Constants.vbTab + "null as isZipFileEntry, " + Constants.vbCrLf;
            S = S + Constants.vbTab + "null as OcrText, " + Constants.vbCrLf;
            S = S + Constants.vbTab + "email.ispublic " + Constants.vbCrLf;
            if (UseWeights == true)
            {
                S = S + Constants.vbTab + "FROM Email as DS ";
                S = ReplacePrefix(Prefix, "email.", S);
            }
            else
            {
                S = S + Constants.vbTab + "FROM Email ";
            }

            return S;
        }

        public string genStdEmailAttachmentQqueryCols()
        {
            string Prefix = "DS.";
            string S = "";
            if (TopRows > 0)
            {
                S = S + "Select top " + TopRows.ToString() + " " + Constants.vbCrLf;
            }
            else
            {
                S = S + "Select " + Constants.vbCrLf;
            }

            if (UseWeights == true)
            {
                S = S + Constants.vbTab + "KEY_TBL.RANK as Weight, " + Constants.vbCrLf;
            }
            else
            {
                S = S + Constants.vbTab + "null as Weight, " + Constants.vbCrLf;
            }

            S = S + Constants.vbTab + "EmailAttachment.AttachmentName as ContentTitle, " + Constants.vbCrLf;
            S = S + Constants.vbTab + "null as NbrOfAttachments, " + Constants.vbCrLf;
            S = S + Constants.vbTab + "(select SenderEmailAddress from EMAIL where EmailAttachment.EmailGuid = EMAIL.EmailGuid) as ContentAuthor, " + Constants.vbCrLf;
            S = S + Constants.vbTab + "EmailAttachment.AttachmentCode as ContentExt, " + Constants.vbCrLf;
            S = S + Constants.vbTab + "(select CreationTime from EMAIL where EmailAttachment.EmailGuid = EMAIL.EmailGuid) as CreateDate, " + Constants.vbCrLf;
            S = S + Constants.vbTab + "EmailAttachment.AttachmentName as FileName, " + Constants.vbCrLf;
            S = S + Constants.vbTab + "null as AllRecipients, " + Constants.vbCrLf;
            S = S + Constants.vbTab + "EmailAttachment.EmailGuid as ContentGuid, " + Constants.vbCrLf;
            S = S + Constants.vbTab + "DATALENGTH(EmailAttachment.Attachment) as FileSize, " + Constants.vbCrLf;
            S = S + Constants.vbTab + "(select SenderEmailAddress  from EMAIL where EmailAttachment.EmailGuid = EMAIL.EmailGuid) as FromEmailAddress, " + Constants.vbCrLf;
            S = S + Constants.vbTab + "(Select UserLoginID from Users where EmailAttachment.UserID = Users.UserID) as UserLoginUD, " + Constants.vbCrLf;
            S = S + Constants.vbTab + "EmailAttachment.UserID, " + Constants.vbCrLf;
            S = S + Constants.vbTab + "EmailAttachment.RowID, " + Constants.vbCrLf;
            S = S + Constants.vbTab + "'Attachment' as Classification, " + Constants.vbCrLf;
            S = S + Constants.vbTab + "EmailAttachment.isZipFileEntry, " + Constants.vbCrLf;
            S = S + Constants.vbTab + "EmailAttachment.OcrText, " + Constants.vbCrLf;
            S = S + Constants.vbTab + "EmailAttachment.isPublic ";
            if (UseWeights == true)
            {
                S = S + Constants.vbTab + "FROM EmailAttachment as DS " + Constants.vbCrLf;
                S = ReplacePrefix(Prefix, "EmailAttachment.", S);
            }
            else
            {
                S = S + Constants.vbTab + "FROM EmailAttachment " + Constants.vbCrLf;
            }

            return S;
        }

        public string genStdDocQueryCols()
        {
            string Prefix = "DS.";
            string S = "";
            if (TopRows > 0)
            {
                S = S + "Select top " + TopRows.ToString() + " " + Constants.vbCrLf;
            }
            else
            {
                S = S + "Select " + Constants.vbCrLf;
            }

            if (UseWeights == true)
            {
                S = S + Constants.vbTab + "KEY_TBL.RANK as Weight, " + Constants.vbCrLf;
            }
            else
            {
                S = S + Constants.vbTab + "null as Weight, " + Constants.vbCrLf;
            }

            S = S + Constants.vbTab + "DataSource.SourceName as ContentTitle, " + Constants.vbCrLf;
            S = S + Constants.vbTab + "null as NbrOfAttachments, " + Constants.vbCrLf;
            S = S + Constants.vbTab + "null as ContentAuthor, " + Constants.vbCrLf;
            S = S + Constants.vbTab + "DataSource.OriginalFileType as ContentExt, " + Constants.vbCrLf;
            S = S + Constants.vbTab + "DataSource.CreateDate, " + Constants.vbCrLf;
            S = S + Constants.vbTab + "DataSource.FQN as FileName, " + Constants.vbCrLf;
            S = S + Constants.vbTab + "null as AllRecipients, " + Constants.vbCrLf;
            S = S + Constants.vbTab + "DataSource.SourceGuid as ContentGuid, " + Constants.vbCrLf;
            S = S + Constants.vbTab + "DataSource.FileLength  as FileSize, " + Constants.vbCrLf;
            S = S + Constants.vbTab + "null as FromEmailAddress, " + Constants.vbCrLf;
            // S = S + vbTab + "Users.UserLoginID, " + vbCrLf
            S = S + "(Select UserLoginID from Users where DataSource.DataSourceOwnerUserID = Users.UserID) as UserLoginUD, " + Constants.vbCrLf;
            S = S + Constants.vbTab + "DataSource.DataSourceOwnerUserID as UserID, " + Constants.vbCrLf;
            S = S + Constants.vbTab + "null as RowID, " + Constants.vbCrLf;
            S = S + Constants.vbTab + "'Content' as Classification, " + Constants.vbCrLf;
            S = S + Constants.vbTab + "DataSource.isZipFileEntry, " + Constants.vbCrLf;
            S = S + Constants.vbTab + "null as OcrText, " + Constants.vbCrLf;
            S = S + Constants.vbTab + "DataSource.isPublic, DataSource.RepoSvrName  " + Constants.vbCrLf;
            if (UseWeights == true)
            {
                S = S + Constants.vbTab + "FROM DataSource as DS ";
                S = ReplacePrefix(Prefix, "DataSource.", S);
            }
            else
            {
                S = S + Constants.vbTab + "FROM DataSource ";
            }

            return S;
        }

        public string RemoveSpaces(string sText)
        {
            var A = Strings.Split(sText, " + vbcrlf ");
            string S = "";
            for (int i = 0, loopTo = Information.UBound(A); i <= loopTo; i++)
                S = S + A[i];
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
            while (Strings.InStr(S, PrefixToReplace, CompareMethod.Text) > 0)
            {
                I = Strings.InStr(S, PrefixToReplace, CompareMethod.Text);
                J = Strings.InStr(S, PrefixToReplace, CompareMethod.Text) + PrefixToReplace.Length;
                S1 = Strings.Mid(S, 1, I - 1);
                S2 = Strings.Mid(S, J);
                S = S1 + NewPrefix + S2;
                // Console.WriteLine(S)
            }

            return S;
        }

        public void ReplaceStar(ref string tVal)
        {
            string CH = "";
            if (Strings.InStr(tVal, "*") == 0)
            {
                return;
            }

            if (tVal.Length > 0)
            {
                if (tVal.Length > 1)
                {
                    CH = Strings.Mid(tVal, 1, 1);
                    if (CH.Equals("*"))
                    {
                        StringType.MidStmtStr(ref tVal, 1, 1, "%");
                    }

                    CH = Strings.Mid(tVal, tVal.Length, 1);
                    if (CH.Equals("*"))
                    {
                        StringType.MidStmtStr(ref tVal, tVal.Length, 1, "%");
                    }
                }
            }
        }

        public string FixSingleQuote(string tVal)
        {
            if (Strings.InStr(tVal, "''") > 0)
            {
                return tVal;
            }

            if (Strings.InStr(tVal, "'") == 0)
            {
                return tVal;
            }

            string SS = tVal;
            tVal = SS;
            try
            {
                int i = Strings.Len(tVal);
                string ch = "";
                string NewStr = "";
                string S1 = "";
                string S2 = "";
                string[] A;
                string PrevCH = "@";
                i = Strings.InStr(1, tVal, "'");
                while (Strings.InStr(1, tVal, "'") > 0)
                {
                    i = Strings.InStr(1, tVal, "'");
                    S1 = Strings.Mid(tVal, 1, i);
                    var midTmp = Conversions.ToString('þ');
                    StringType.MidStmtStr(ref S1, S1.Length, 1, midTmp);
                    S2 = Conversions.ToString('þ') + Strings.Mid(tVal, i + 1);
                    tVal = S1 + S2;
                }

                var loopTo = Strings.Len(tVal);
                for (i = 1; i <= loopTo; i++)
                {
                    ch = Strings.Mid(tVal, i, 1);
                    if (ch == Conversions.ToString('þ'))
                    {
                        StringType.MidStmtStr(ref tVal, i, 1, "'");
                    }
                }
            }
            catch (Exception ex)
            {
                WriteToLog("ERROR: FixSingleQuote - " + ex.Message + Constants.vbCrLf + ex.StackTrace);
            }

            return tVal;
        }

        public void WriteToLog(string Msg)
        {
            try
            {
                string cPath = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);
                string TempFolder = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);
                string M = DateAndTime.Now.Month.ToString().Trim();
                string D = DateAndTime.Now.Day.ToString().Trim();
                string Y = DateAndTime.Now.Year.ToString().Trim();
                string SerialNo = M + "." + D + "." + Y + ".";
                string tFQN = TempFolder + @"\ECMLibrary.Generator.Log." + SerialNo + "txt";
                // Create an instance of StreamWriter to write text to a file.
                using (var sw = new StreamWriter(tFQN, true))
                {
                    // Add some text to the file.                                    
                    sw.WriteLine(DateAndTime.Now.ToString() + ": " + Msg + Constants.vbCrLf);
                    sw.Close();
                }
            }
            // If gRunUnattended = True Then
            // gUnattendedErrors += 1
            // FrmMDIMain.SB4.Text = " " + gUnattendedErrors.ToString
            // FrmMDIMain.SB4.BackColor = Color.Silver
            // End If
            catch (Exception ex)
            {
                Console.WriteLine("clsGenerator : WriteToLog : 688 : " + ex.Message);
            }
        }

        public string buildContainsSyntax(string SearchCriteria, ref ArrayList ThesaurusWords)
        {
            // ** Get all the OR'SearchCriteria and build a search term then
            // ** get all the AND'SearchCriteria and build a search term then
            // ** Apply any NEAR'SearchCriteria to the mess.


            // "dale miller" "susan miller" near Jessie
            // "dale miller" "susan miller" +Jessie Shelby
            // "dale miller" +"susan miller" +Jessie
            // Dale Susan near Jessie
            // +dale +susan near Jessie
            // +dale +susan Jessie
            // +dale +susan +Jessie


            // WHERE CONTAINS(*, '"ECA" or "Enterprise Content" AND "Content*" and "state" NEAR "State Farm"')
            // ** '"ECA" or "Enterprise Content" AND "Content*" and "state" NEAR "State Farm" and "Corporate"'
            // ** 'ECA or "Enterprise Content" AND Content* and state NEAR "State Farm" and Corporate'
            // ** 'ECA "Enterprise Content" +Content* +state NEAR "State Farm" +Corporate'
            // ** WHERE CONTAINS(Description, ' FORMSOF (INFLECTIONAL, ride) ');


            var A = new ArrayList();
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
            string DQ = Conversions.ToString('"');
            bool FirstEntry = true;
            string QuotedString = "";
            bool OrNeeded = false;
            bool AndNeeded = false;
            ThesaurusWords.Clear();
            SearchCriteria = SearchCriteria.Trim();
            var loopTo = SearchCriteria.Length;
            for (I = 1; I <= loopTo; I++)
            {
                StartNextWord:
                ;
                Ch = Strings.Mid(SearchCriteria, I, 1);
                if (FirstEntry)
                {
                    if (Ch.Equals("~") | Ch.Equals("^") | Ch.Equals("^") | Ch.Equals("#"))
                    {
                    }
                    // ** DO nothing - it belongs here
                    else if (isDelimiter(Ch))
                    {
                        SkipTokens(SearchCriteria, I, ref J);
                        I = J;
                        goto StartNextWord;
                    }

                    FirstEntry = false;
                }

                TokenAlreadyAcquired:
                ;
                if (Ch == Conversions.ToString('"'))
                {
                    QuotedString = "";
                    J = 0;
                    GetQuotedString(SearchCriteria, ref I, ref J, ref QuotedString);
                    if (QuotedString.Equals(Conversions.ToString('"') + Conversions.ToString('"')))
                    {
                        if (ddebug)
                            Console.WriteLine("Skipping null double quotes.");
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
                    if (ddebug)
                        Console.WriteLine("Skipping: " + Ch);
                    A.Add("(");
                }
                else if (Ch.Equals(")"))
                {
                    if (ddebug)
                        Console.WriteLine("Skipping: " + Ch);
                    A.Add(")");
                }
                else if (Ch.Equals(","))
                {
                    if (ddebug)
                        Console.WriteLine("Skipping: " + Ch);
                }
                else if (Ch == "^")
                {
                    // ** Then this will be an inflectional term
                    // ** One term using the AND operator will be built for each inflectional term provided.
                    string SubstituteString = "FORMSOF (INFLECTIONAL, " + Conversions.ToString('"') + "@" + Conversions.ToString('"') + ")";
                    I += 1;
                    string ReturnedDelimiter = "";
                    tWord = getNextToken(SearchCriteria, ref I, ref ReturnedDelimiter);
                    string C = Strings.Mid(SearchCriteria, I, 1);
                    SubIn(ref SubstituteString, "@", tWord);
                    tWord = SubstituteString;
                    SubIn(ref tWord, Conversions.ToString('"') + Conversions.ToString('"'), Conversions.ToString('"'));
                    if (OrNeeded)
                    {
                        A.Add("Or");
                    }

                    if (ddebug)
                        Console.WriteLine(I.ToString() + ":" + Strings.Mid(SearchCriteria, I, 1));
                    A.Add(tWord);
                    OrNeeded = true;
                    tWord = "";
                    goto StartNextWord;
                }
                else if (Ch == "~")
                {
                    // ** Then this will be an THESAURUS term
                    // ** One term using the AND operator will be built for each inflectional term provided.
                    string SubstituteString = "FORMSOF (THESAURUS, " + Conversions.ToString('"') + "@" + Conversions.ToString('"') + ")";
                    I += 1;
                    string ReturnedDelimiter = "";
                    tWord = getNextToken(SearchCriteria, ref I, ref ReturnedDelimiter);
                    SubIn(ref SubstituteString, "@", tWord);
                    tWord = SubstituteString;
                    SubIn(ref tWord, Conversions.ToString('"') + Conversions.ToString('"'), Conversions.ToString('"'));
                    // If A.Count > 1 Then
                    // A.Add("AND")
                    // OrNeeded = False
                    // End If
                    if (OrNeeded)
                    {
                        A.Add("Or");
                    }

                    if (ddebug)
                        Console.WriteLine(I.ToString() + ":" + Strings.Mid(SearchCriteria, I, 1));
                    A.Add(tWord);
                    OrNeeded = true;
                    tWord = "";
                    goto StartNextWord;
                }
                else if (Ch == "#")
                {
                    // ** Then this will be an THESAURUS term
                    // ** One term using the AND operator will be built for each inflectional term provided.
                    string SubstituteString = "FORMSOF (THESAURUS, " + Conversions.ToString('"') + "@" + Conversions.ToString('"') + ")";
                    I += 1;
                    string ReturnedDelimiter = "";
                    tWord = getNextToken(SearchCriteria, ref I, ref ReturnedDelimiter);
                    if (!ThesaurusWords.Contains(tWord))
                    {
                        ThesaurusWords.Add(tWord);
                    }

                    goto ProcessImmediately;
                }
                else if (Ch == " " | Ch == ",")
                {
                    I += 1;
                    Ch = Strings.Mid(SearchCriteria, I, 1);
                    if (isSyntaxChar(Ch))
                    {
                        goto TokenAlreadyAcquired;
                    }

                    while (Ch == " " & I < SearchCriteria.Length)
                    {
                        Ch = Strings.Mid(SearchCriteria, I, 1);
                        I += 1;
                    }

                    if (isSyntaxChar(Ch))
                    {
                        I = I - 1;
                        goto TokenAlreadyAcquired;
                    }

                    isOr = true;
                    tWord = getTheRestOfTheToken(SearchCriteria, ref I);
                    if (ddebug)
                        Console.WriteLine(tWord);
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
                    I = I - 1;
                }
                else
                {
                    string ReturnedDelimiter = "";
                    tWord = getNextToken(SearchCriteria, ref I, ref ReturnedDelimiter);
                    if (ddebug)
                        Console.WriteLine(tWord);
                    A.Add(tWord);
                    if (Strings.UCase(tWord).Equals("OR"))
                    {
                        OrNeeded = false;
                    }
                    else if (Strings.UCase(tWord).Equals("AND"))
                    {
                        OrNeeded = false;
                    }
                    else if (Strings.UCase(tWord).Equals("NOT"))
                    {
                        OrNeeded = false;
                    }
                    else
                    {
                        OrNeeded = true;
                    }

                    tWord = "";
                    I = I - 1;
                }

                ProcessImmediately:
                ;
                if (ddebug)
                    Console.WriteLine(I.ToString() + ":" + tWord);
                if (ddebug)
                    Console.WriteLine(SearchCriteria);
                tWord = "";
                // isOr = True
                for (int II = 0, loopTo1 = A.Count - 1; II <= loopTo1; II++)
                {
                    if (Conversions.ToBoolean(Operators.ConditionalCompareObjectEqual(A[II], null, false)))
                    {
                        if (ddebug)
                            Console.WriteLine(II.ToString() + ":Nothing");
                    }
                    else if (ddebug)
                        Console.WriteLine(II.ToString() + ":" + A[II].ToString());
                }

                NextWord:
                ;
            }

            int XX = A.Count;
            for (XX = A.Count - 1; XX >= 0; XX -= 1)
            {
                tWord = Conversions.ToString(A[XX].trim);
                if (isKeyWord(tWord))
                {
                    A.RemoveAt(XX);
                }
                else
                {
                    break;
                }
            }

            string Stmt = "";
            var loopTo2 = A.Count - 1;
            for (I = 0; I <= loopTo2; I++)
            {
                if (I == A.Count - 1)
                {
                    tWord = Conversions.ToString(A[I].trim);
                    if (isKeyWord(tWord))
                    {
                        if (ddebug)
                            Console.WriteLine("Do nothing");
                    }
                    else
                    {
                        Stmt = Conversions.ToString(Operators.AddObject(Stmt + " ", A[I]));
                        if (ddebug)
                            Console.WriteLine(I.ToString() + ": " + Stmt);
                    }
                }
                else
                {
                    Stmt = Conversions.ToString(Operators.AddObject(Stmt + " ", A[I]));
                    if (ddebug)
                        Console.WriteLine(I.ToString() + ": " + Stmt);
                }
            }

            return Stmt;
        }

        public void GetQuotedString(string tstr, ref int i, ref int j, ref string QuotedString)
        {
            int X = tstr.Trim().Length;
            string Q = Conversions.ToString('"');
            string CH = "";
            string Alphabet = " |+-^";
            string S = "";
            QuotedString = Q;
            i += 1;
            CH = Strings.Mid(tstr, i, 1);
            while (CH != Conversions.ToString('"') & i <= tstr.Length)
            {
                QuotedString = QuotedString + CH;
                i += 1;
                CH = Strings.Mid(tstr, i, 1);
            }

            QuotedString = QuotedString + Q;
        }

        public bool isNotDelimiter(string CH)
        {
            string Alphabet = " |+-^";
            if (Strings.InStr(1, Alphabet, CH) == 0)
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
            if (Strings.InStr(1, Alphabet, CH) > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public void SkipTokens(string tstr, int i, ref int j)
        {
            int X = tstr.Trim().Length;
            string Q = Conversions.ToString('"');
            string CH = "";
            string Alphabet = " |+-^";
            string S = "";
            var loopTo = X;
            for (j = i + 1; j <= loopTo; j++)
            {
                CH = Strings.Mid(tstr, j, 1);
                if (Strings.InStr(1, Alphabet, CH) == 0)
                {
                    break;
                    // We found the string
                }
            }
        }

        public string getNextToken(string S, ref int I, ref string ReturnedDelimiter)
        {
            string Delimiters = " ,:+-^|()";
            S = S.Trim();
            string Token = "";
            string CH = "";
            CH = Strings.Mid(S, I, 1);
            int KK = S.Length;


            // ** If CH is a blank char, skip to the start of the next token
            if (CH == " ")
            {
                while (!(CH != " " & I <= KK))
                {
                    I += 1;
                    CH = Strings.Mid(S, I, 1);
                }
            }

            if (CH == Conversions.ToString('"'))
            {
                Token = "";
                Token += Conversions.ToString('"');
                I += 1;
                CH = Strings.Mid(S, I, 1);
                KK = S.Length;
                while (!(CH == Conversions.ToString('"') & I <= KK))
                {
                    Token += CH;
                    I += 1;
                    CH = Strings.Mid(S, I, 1);
                    if (I > S.Length)
                    {
                        break;
                    }
                }

                Token += Conversions.ToString('"');
            }
            // WDM May need to put back I += 1
            else
            {
                Token = CH;
                I += 1;
                CH = Strings.Mid(S, I, 1);
                KK = S.Length;
                while (!(Strings.InStr(Delimiters, CH) > 0 & I <= KK))
                {
                    Token += CH;
                    I += 1;
                    CH = Strings.Mid(S, I, 1);
                    ReturnedDelimiter = CH;
                    if (I > S.Length)
                    {
                        break;
                    }
                }
                // WDM May need to put back I += 1
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
            M = WhatToChange.Length;
            N = ChangeCharsToThis.Length;
            while (Strings.InStr(ParentString, WhatToChange, CompareMethod.Text) > 0)
            {
                I = Strings.InStr(ParentString, WhatToChange, CompareMethod.Text);
                S1 = Strings.Mid(ParentString, 1, I - 1);
                S2 = Strings.Mid(ParentString, I + M);
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
            CH = Strings.Mid(S, I, 1);
            int KK = S.Length;
            Token = "";
            I += 1;
            CH = Strings.Mid(S, I, 1);
            KK = S.Length;
            if (CH.Length > 0 & Strings.InStr(Delimiters, CH) == 0)
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

            while (!(Strings.InStr(Delimiters, CH) == 0 & I <= KK))
            {
                Token += CH;
                I += 1;
                CH = Strings.Mid(S, I, 1);
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
            if (Strings.InStr(1, Alphabet, CH) > 0)
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
            // We are sitting at the next character in the token, so go back to the beginning
            I = I - 1;
            string Delimiters = " ,:+-^|";
            S = S.Trim();
            string Token = "";
            string CH = "";
            CH = Strings.Mid(S, I, 1);
            int KK = S.Length;


            // ** If CH is a blank char, skip to the start of the next token
            if (CH == " ")
            {
                while (!(CH != " " & I <= KK))
                {
                    I += 1;
                    CH = Strings.Mid(S, I, 1);
                }
            }

            if (CH == Conversions.ToString('"'))
            {
                Token = "";
                Token += Conversions.ToString('"');
                I += 1;
                CH = Strings.Mid(S, I, 1);
                KK = S.Length;
                while (!(CH == Conversions.ToString('"') & I <= KK))
                {
                    Token += CH;
                    I += 1;
                    CH = Strings.Mid(S, I, 1);
                    if (I > S.Length)
                    {
                        break;
                    }
                }

                Token += Conversions.ToString('"');
                I += 1;
            }
            else
            {
                Token = CH;
                I += 1;
                CH = Strings.Mid(S, I, 1);
                KK = S.Length;
                while (!(Strings.InStr(Delimiters, CH) > 0 & I <= KK))
                {
                    Token += CH;
                    I += 1;
                    CH = Strings.Mid(S, I, 1);
                    if (I > S.Length)
                    {
                        break;
                    }
                }

                I += 1;
            }

            return Token;
        }

        public bool isKeyWord(string KW)
        {
            bool B = false;
            KW = Strings.UCase(KW);
            switch (KW ?? "")
            {
                case "AND":
                    {
                        return true;
                    }

                case "OR":
                    {
                        return true;
                    }

                case "NOT":
                    {
                        return true;
                    }

                case var @case when @case == "AND":
                    {
                        return true;
                    }
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
            if (SearchCode.Equals("E") | SearchCode.Equals("EMAIL"))
            {
                if (bGlobalSearcher == true)
                {
                    S = S + Conversions.ToString('\t') + "/* This is where the library search would go - you have global rights, think about it.*/" + Conversions.ToString('\t') + Conversions.ToString('\t') + " /*KEEP*/" + Constants.vbCrLf;
                    S = S + Conversions.ToString('\t') + " AND (UserID IS NOT NULL)" + Conversions.ToString('\t') + Conversions.ToString('\t') + " /*KEEP*/" + Constants.vbCrLf;
                    return S;
                }
                else
                {
                    S = S + " AND (UserID = '" + CurrUserID + "'" + Conversions.ToString('\t') + Conversions.ToString('\t') + " /*KEEP*/" + Constants.vbCrLf;
                    S = S + Conversions.ToString('\t') + " or isPublic = 'Y'" + " /*KEEP*/" + Constants.vbCrLf;
                }
            }

            if (SearchCode.Equals("S") | SearchCode.Equals("EMAIL"))
            {
                if (bGlobalSearcher == true)
                {
                    S = S + Conversions.ToString('\t') + "/* This is where the library search would go - you have global rights, think about it.*/" + Conversions.ToString('\t') + Conversions.ToString('\t') + " /*KEEP*/" + Constants.vbCrLf;
                    S = S + Conversions.ToString('\t') + " AND (DataSourceOwnerUserID IS NOT NULL)" + Conversions.ToString('\t') + Conversions.ToString('\t') + " /*KEEP*/" + Constants.vbCrLf;
                    return S;
                }
                else
                {
                    S = S + " AND (DataSourceOwnerUserID = '" + CurrUserID + "'" + Conversions.ToString('\t') + Conversions.ToString('\t') + " /*KEEP*/" + Constants.vbCrLf;
                    S = S + Conversions.ToString('\t') + " or isPublic = 'Y'" + " /*KEEP*/" + Constants.vbCrLf;
                }
            }

            S = S + Conversions.ToString('\t') + Conversions.ToString('\t') + " /* GENID:" + LocationID + "*/" + Conversions.ToString('\t') + Conversions.ToString('\t') + " /*KEEP*/" + Constants.vbCrLf;
            if (SearchCode.Equals("E") | SearchCode.Equals("EMAIL"))
            {
                S = S + Conversions.ToString('\t') + Conversions.ToString('\t') + " or EmailGuid in (" + " /*KEEP*/" + Constants.vbCrLf;
            }
            else
            {
                S = S + Conversions.ToString('\t') + Conversions.ToString('\t') + " or SourceGuid in (" + " /*KEEP*/" + Constants.vbCrLf;
            }

            S = S + Conversions.ToString('\t') + " SELECT LibraryItems.SourceGuid" + Conversions.ToString('\t') + Conversions.ToString('\t') + " /*KEEP*/" + Constants.vbCrLf;
            S = S + Conversions.ToString('\t') + " FROM   LibraryItems INNER JOIN" + Conversions.ToString('\t') + Conversions.ToString('\t') + " /*KEEP*/" + Constants.vbCrLf;
            S = S + Conversions.ToString('\t') + "        Library ON LibraryItems.LibraryName = Library.LibraryName INNER JOIN" + Conversions.ToString('\t') + Conversions.ToString('\t') + " /*KEEP*/" + Constants.vbCrLf;
            S = S + Conversions.ToString('\t') + "        LibraryUsers ON Library.LibraryName = LibraryUsers.LibraryName INNER JOIN" + Conversions.ToString('\t') + Conversions.ToString('\t') + " /*KEEP*/" + Constants.vbCrLf;
            S = S + Conversions.ToString('\t') + "        GroupLibraryAccess ON Library.LibraryName = GroupLibraryAccess.LibraryName INNER JOIN" + Conversions.ToString('\t') + Conversions.ToString('\t') + " /*KEEP*/" + Constants.vbCrLf;
            S = S + Conversions.ToString('\t') + "        GroupUsers ON GroupLibraryAccess.GroupName = GroupUsers.GroupName" + Conversions.ToString('\t') + Conversions.ToString('\t') + " /*KEEP*/" + Constants.vbCrLf;
            S = S + Conversions.ToString('\t') + " where " + Conversions.ToString('\t') + Conversions.ToString('\t') + " /*KEEP*/" + Constants.vbCrLf;
            S = S + Conversions.ToString('\t') + "        libraryusers.userid ='" + CurrUserID + "' " + Conversions.ToString('\t') + Conversions.ToString('\t') + " /*KEEP*/   /*ID55*/" + Constants.vbCrLf;
            S = S + Conversions.ToString('\t') + "UNION " + Conversions.ToString('\t') + Conversions.ToString('\t') + " /*KEEP*/" + Constants.vbCrLf;
            S = S + Conversions.ToString('\t') + "Select LI.SourceGuid" + Conversions.ToString('\t') + Conversions.ToString('\t') + " /*KEEP*/" + Constants.vbCrLf;
            S = S + Conversions.ToString('\t') + "FROM         LibraryItems AS LI INNER JOIN" + Conversions.ToString('\t') + Conversions.ToString('\t') + " /*KEEP*/" + Constants.vbCrLf;
            S = S + Conversions.ToString('\t') + "             LibraryUsers AS LU ON LI.LibraryName = LU.LibraryName" + Conversions.ToString('\t') + Conversions.ToString('\t') + " /*KEEP*/" + Constants.vbCrLf;
            S = S + Conversions.ToString('\t') + "WHERE     (LU.UserID = '" + CurrUserID + "')" + Conversions.ToString('\t') + Conversions.ToString('\t') + " /*KEEP*/   /*ID56*/" + Constants.vbCrLf;
            S = S + Conversions.ToString('\t') + "))" + " /*KEEP*/" + Constants.vbCrLf;
            S = S + Conversions.ToString('\t') + " /* GLOBAL Searcher = " + bGlobalSearcher.ToString() + "  */" + Conversions.ToString('\t') + Conversions.ToString('\t') + " /*KEEP*/" + Constants.vbCrLf;
            return S;
        }

        public string genLibrarySearch(string CurrUserID, bool GlobalSearcher, string LibraryName, string LocationID)
        {
            string S = "";
            // S = S + " SELECT GroupUsers.GroupName, Library.LibraryName, LibraryUsers.UserID, LibraryItems.SourceGuid" + chr(9) + chr(9) + " /*KEEP*/" + vbCrLf
            S = S + " /* GENID:" + LocationID + " *KEEP*/" + Constants.vbCrLf;
            S = S + " SELECT LibraryItems.SourceGuid" + Conversions.ToString('\t') + Conversions.ToString('\t') + " /*KEEP*/" + Constants.vbCrLf;
            S = S + Conversions.ToString('\t') + " FROM   LibraryItems INNER JOIN" + Conversions.ToString('\t') + Conversions.ToString('\t') + " /*KEEP*/" + Constants.vbCrLf;
            S = S + Conversions.ToString('\t') + "        Library ON LibraryItems.LibraryName = Library.LibraryName INNER JOIN" + Conversions.ToString('\t') + Conversions.ToString('\t') + " /*KEEP*/" + Constants.vbCrLf;
            S = S + Conversions.ToString('\t') + "        LibraryUsers ON Library.LibraryName = LibraryUsers.LibraryName INNER JOIN" + Conversions.ToString('\t') + Conversions.ToString('\t') + " /*KEEP*/" + Constants.vbCrLf;
            S = S + Conversions.ToString('\t') + "        GroupLibraryAccess ON Library.LibraryName = GroupLibraryAccess.LibraryName INNER JOIN" + Conversions.ToString('\t') + Conversions.ToString('\t') + " /*KEEP*/" + Constants.vbCrLf;
            S = S + Conversions.ToString('\t') + "        GroupUsers ON GroupLibraryAccess.GroupName = GroupUsers.GroupName" + Conversions.ToString('\t') + Conversions.ToString('\t') + " /*KEEP*/" + Constants.vbCrLf;
            S = S + Conversions.ToString('\t') + " where " + Conversions.ToString('\t') + Conversions.ToString('\t') + " /*KEEP*/" + Constants.vbCrLf;
            S = S + Conversions.ToString('\t') + "        Library.LibraryName ='" + LibraryName + "' " + Conversions.ToString('\t') + Conversions.ToString('\t') + " /*KEEP*/   /*ID57*/" + Constants.vbCrLf;
            if (GlobalSearcher == false)
            {
                S = S + Conversions.ToString('\t') + " AND    libraryusers.userid ='" + CurrUserID + "' " + Conversions.ToString('\t') + Conversions.ToString('\t') + " /*KEEP*/" + Constants.vbCrLf;
            }

            S = S + Conversions.ToString('\t') + "        /* GLOBAL Searcher = " + GlobalSearcher.ToString() + "  */" + Conversions.ToString('\t') + Conversions.ToString('\t') + " /*KEEP*/" + Constants.vbCrLf;
            S = S + Conversions.ToString('\t') + "UNION " + Conversions.ToString('\t') + Conversions.ToString('\t') + " /*KEEP*/" + Constants.vbCrLf;
            S = S + Conversions.ToString('\t') + "Select LI.SourceGuid" + Conversions.ToString('\t') + Conversions.ToString('\t') + " /*KEEP*/" + Constants.vbCrLf;
            S = S + Conversions.ToString('\t') + "FROM   LibraryItems AS LI INNER JOIN" + Conversions.ToString('\t') + Conversions.ToString('\t') + " /*KEEP*/" + Constants.vbCrLf;
            S = S + Conversions.ToString('\t') + "       LibraryUsers AS LU ON LI.LibraryName = LU.LibraryName" + Conversions.ToString('\t') + Conversions.ToString('\t') + " /*KEEP*/   /*ID58*/" + Constants.vbCrLf;
            if (GlobalSearcher == false)
            {
                S = S + Conversions.ToString('\t') + "WHERE     LI.LibraryName = '" + LibraryName + "'" + Conversions.ToString('\t') + Conversions.ToString('\t') + " /*KEEP*/" + Constants.vbCrLf;
                S = S + Conversions.ToString('\t') + "    AND LU.UserID = '" + CurrUserID + "'" + Conversions.ToString('\t') + Conversions.ToString('\t') + " /*KEEP*/" + Constants.vbCrLf;
            }
            else
            {
                S = S + Conversions.ToString('\t') + "WHERE     LI.LibraryName = '" + LibraryName + "'" + Conversions.ToString('\t') + Conversions.ToString('\t') + " /*KEEP*/" + Constants.vbCrLf;
            }

            return S;
        }
    }
}