using global::System;
using global::System.Collections;
using System.Collections.Generic;
using System.Data;
using global::System.Data.SqlClient;
using System.Diagnostics;
using System.Windows.Forms;
using Microsoft.VisualBasic;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{
    public class clsSql
    {
        private clsDatabaseARCH DBARCH = new clsDatabaseARCH();
        private clsDma DMA = new clsDma();
        private clsGenerator GEN = new clsGenerator();
        private clsUtility UTIL = new clsUtility();
        private clsLogging LOG = new clsLogging();
        private clsDb TREX = new clsDb();
        private bool ddebug = true;
        private bool bSaveToClipBoard = true;
        private string txtSearch = null;
        private bool getCountOnly = default;
        private bool UseExistingRecordsOnly = default;
        private bool ckWeighted = default;
        private string GeneratedSQL = null;
        private bool isAdmin = default;
        private bool ckBusiness = default;
        private bool isInflectionalTerm = false;
        private bool InflectionalToken = false;
        private ArrayList ThesaurusList = new ArrayList();
        private ArrayList ThesaurusWords = new ArrayList();

        public clsSql()
        {
            // Dim sDebug  = System.Configuration.ConfigurationManager.AppSettings("debug_clsSql")
            string sDebug = DBARCH.getUserParm("debug_clsSql");
            if (sDebug.Equals("1"))
            {
                ddebug = true;
                LOG.WriteToArchiveLog("Debug set ON for: clsSql");
            }
            else
            {
                // log.WriteToArchiveLog("Debug set OFF for: clsSql")
                ddebug = false;
            }
        }

        public string PInflectionalToken
        {
            get
            {
                return Conversions.ToString(InflectionalToken);
            }

            set
            {
                InflectionalToken = Conversions.ToBoolean(value);
            }
        }

        public bool BInflectionalTerm
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
                // return ""
            }

            if (getCountOnly == default)
            {
                Debug.Print("All required variables not set to call this function.");
                // return ""
            }

            if (ckWeighted == default)
            {
                Debug.Print("All required variables not set to call this function.");
                // return ""
            }

            GeneratedSQL = "";
            // **WDM Removed 7/12/2009 GeneratedSQL  = genHeader()
            GeneratedSQL += Constants.vbCrLf;
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

                GeneratedSQL += " WHERE " + Constants.vbCrLf;

                // genDocWhereClause(WhereClause )
                string ContainsClause = "";
                // ************************************************************************************************************************************************************
                ContainsClause = genContainsClause(SearchString, ckBusiness, ckWeighted, false, ckLimitToExisting, ThesaurusList, txtThesaurus, cbThesaurusText, "DOC");
                // ************************************************************************************************************************************************************

                ContainsClause = ContainsClause + genUseExistingRecordsOnly(UseExistingRecordsOnly, "SourceGuid");

                // ***********************************************************************
                isAdmin = DBARCH.isAdmin(modGlobals.gCurrUserGuidID);
                if (isAdmin == false)
                {
                    isAdmin = DBARCH.isGlobalSearcher(modGlobals.gCurrUserGuidID);
                }

                UserSql = genAdminContentSql(isAdmin, ckLimitToLib, LibraryName);
                // ***********************************************************************
                if (Conversions.ToBoolean(ContainsClause.Length))
                {
                    GeneratedSQL = GeneratedSQL + Constants.vbCrLf + ContainsClause;
                    if (bSaveToClipBoard)
                        modGlobals.SetToClipBoard(GeneratedSQL);
                }

                if (bCopyToClipboard)
                {
                    string tClip = "/* Part2 */ " + Constants.vbCrLf;
                    tClip += GeneratedSQL;
                    if (bSaveToClipBoard)
                        modGlobals.SetToClipBoard(tClip);
                    Debug.Print(tClip);
                }

                if (UserSql.Length > 0)
                {
                    GeneratedSQL += Constants.vbCrLf + UserSql;
                }
            }

            if (getCountOnly)
            {
            }
            else
            {
                if (ckWeighted == true)
                {
                    GeneratedSQL = GeneratedSQL + " and KEY_TBL.RANK >= " + modGlobals.MinRating.ToString() + Constants.vbCrLf;
                    // **WDM 6/1/2009 GeneratedSQL  = GeneratedSQL  + " /* and KEY_TBL.RANK >= " + MinRating.ToString + " */" + vbCrLf
                    if (bSaveToClipBoard)
                        modGlobals.SetToClipBoard(GeneratedSQL);
                }
                else
                {
                }

                if (ckWeighted)
                {
                    // GeneratedSQL  += vbCrLf + " or isPublic = 'Y' "
                    GeneratedSQL += Constants.vbCrLf + " ORDER BY KEY_TBL.RANK DESC ";
                }
                else
                {
                    // GeneratedSQL  += vbCrLf + " or isPublic = 'Y' "
                    GeneratedSQL += Constants.vbCrLf + " order by [SourceName] ";
                }
            }

            if (bCopyToClipboard)
            {
                string tClip = "/* Final */ " + Constants.vbCrLf;
                tClip += GeneratedSQL;
                if (bSaveToClipBoard)
                    modGlobals.SetToClipBoard(tClip);
                if (bSaveToClipBoard)
                    LOG.WriteToArchiveLog(tClip);
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
            // ByVal txtSearch as string , ByVal getCountOnly As Boolean, ByVal UseExistingRecordsOnly As Boolean, ByVal ckWeighted As Boolean, ByRef GeneratedSQL As String

            if (txtSearch == null)
            {
                Debug.Print("All required variables not set to call this function.");
            }
            // return ""
            else
            {
            }

            if (getCountOnly == default)
            {
                Debug.Print("All required variables not set to call this function.");
                // return ""
            }

            if (UseExistingRecordsOnly == default)
            {
                Debug.Print("All required variables not set to call this function.");
            }
            // return ""
            else
            {
                UseExistingRecordsOnly = ckLimitToExisting;
            }

            if (ckWeighted == default)
            {
                Debug.Print("All required variables not set to call this function.");
                // return ""
            }

            if (GeneratedSQL == null)
            {
                Debug.Print("All required variables not set to call this function.");
                // return ""
            }

            isAdmin = DBARCH.isAdmin(modGlobals.gCurrUserGuidID);
            if (isAdmin == false)
            {
                isAdmin = DBARCH.isGlobalSearcher(modGlobals.gCurrUserGuidID);
            }

            if (isAdmin == default)
            {
                Debug.Print("All required variables not set to call this function.");
                // return ""
            }

            if (ckBusiness == default)
            {
                Debug.Print("All required variables not set to call this function.");
                // return ""
            }

            string EmailSql = "";
            string WhereClause = "";
            bool bCopyToClipboard = true;
            string UserSql = genAdminEmailSql(isAdmin, ckLimitToLib, LibraryName);
            // **WDM Removed 7/12/2009 GeneratedSQL  = genHeader()

            if (getCountOnly)
            {
                GeneratedSQL += genEmailCountSql();
            }
            else
            {
                GeneratedSQL += getEmailTblCols(ckWeighted, ckBusiness, txtSearch);
            }

            GeneratedSQL = GeneratedSQL + " WHERE " + Constants.vbCrLf;
            if (bSaveToClipBoard)
                modGlobals.SetToClipBoard(GeneratedSQL);
            string ContainsClause = "";
            ContainsClause = genContainsClause(txtSearch, ckBusiness, ckWeighted, true, ckLimitToExisting, ThesaurusList, txtThesaurus, cbThesaurusText, "EMAIL");
            if (ContainsClause.Length > 0)
            {
                GeneratedSQL = GeneratedSQL + Constants.vbCrLf + ContainsClause;
                if (bSaveToClipBoard)
                    modGlobals.SetToClipBoard(GeneratedSQL);
            }

            if (bCopyToClipboard)
            {
                string tClip = "/* WhereClause  */ " + Constants.vbCrLf;
                tClip += WhereClause;
                if (bSaveToClipBoard)
                    modGlobals.SetToClipBoard(tClip);
                Debug.Print(tClip);
            }

            EmailSql = GeneratedSQL + Constants.vbCrLf;
            if (bCopyToClipboard)
            {
                string tClip = "/* ContainsClause */ " + Constants.vbCrLf;
                tClip += EmailSql;
                if (bSaveToClipBoard)
                    modGlobals.SetToClipBoard(tClip);
                Debug.Print(tClip);
            }

            if (ContainsClause.Trim().Length > 0)
            {
                EmailSql = GeneratedSQL + Constants.vbCrLf;
                EmailSql += " " + Constants.vbCrLf + WhereClause + Constants.vbCrLf;
                if (bSaveToClipBoard)
                    modGlobals.SetToClipBoard(EmailSql);
                if (getCountOnly)
                {
                    EmailSql += UserSql;
                }
                else
                {
                    EmailSql += Constants.vbCrLf + UserSql;
                    if (ckWeighted == true)
                    {
                        // EmailSql += " and KEY_TBL.RANK >= " + MinRating.ToString + vbCrLf
                        // EmailSql += vbCrLf + " ORDER BY KEY_TBL.RANK DESC "

                        // **WDM 6/1/2008 EmailSql += " /* and KEY_TBL.RANK >= " + MinRating.ToString + " */" + vbCrLf
                        EmailSql += "    and KEY_TBL.RANK >= " + modGlobals.MinRating.ToString() + Constants.vbCrLf;
                        string IncludeEmailAttachmentsQry = EmailSql + Constants.vbCrLf;
                        // If ckIncludeAttachments.Checked Then
                        bool ckIncludeAttachments = true;
                        if (ckWeighted == true)
                        {
                            IncludeEmailAttachmentsSearchWeighted(ckIncludeAttachments, ckWeighted, ckBusiness, txtSearch, ckLimitToExisting, txtThesaurus, cbThesaurusText, MinWeight);
                        }
                        else
                        {
                            IncludeEmailAttachmentsSearch(ckIncludeAttachments, ckWeighted, ckBusiness, txtSearch, ckLimitToExisting, txtThesaurus, cbThesaurusText, LibraryName, bIncludeAllLibs);
                        }

                        if (ckIncludeAttachments == true & ckLimitToLib == false)
                        {
                            // ** ECM EmailAttachmentSearchList
                            if (modGlobals.gMasterContentOnly == true)
                            {
                            }
                            else
                            {
                                // IncludeEmailAttachmentsQry  = vbCrLf + " OR " + "([EmailGuid] in (select EmailGuid from EmailAttachmentSearchList where UserID = '" + gCurrUserGuidID + "'))" + vbCrLf
                            }

                            // EmailSql = EmailSql + vbCrLf + IncludeEmailAttachmentsQry  + vbCrLf
                            EmailSql = EmailSql + genUseExistingRecordsOnly(UseExistingRecordsOnly, "EmailGuid");

                            // Clipboard.Clear()
                            // Clipboard.SetText(EmailSql)
                        }
                        // EmailSql += vbCrLf + " or isPublic = 'Y' "
                        EmailSql += Constants.vbCrLf + " ORDER BY KEY_TBL.RANK DESC " + Constants.vbCrLf;
                    }
                    else
                    {
                        string IncludeEmailAttachmentsQry = EmailSql + Constants.vbCrLf;
                        // If ckIncludeAttachments.Checked Then
                        bool ckIncludeAttachments = true;
                        IncludeEmailAttachmentsSearch(ckIncludeAttachments, ckWeighted, ckBusiness, txtSearch, ckLimitToExisting, txtThesaurus, cbThesaurusText, LibraryName, bIncludeAllLibs);
                        // If ckIncludeAttachments = True And ckLimitToLib = False Then
                        // '** ECM EmailAttachmentSearchList
                        // If gMasterContentOnly = True Then
                        // Else
                        // IncludeEmailAttachmentsQry  = vbCrLf + " OR " + "([EmailGuid] in (select EmailGuid from EmailAttachmentSearchList where UserID = '" + gCurrUserGuidID + "'))" + vbCrLf
                        // End If

                        // EmailSql = EmailSql + vbCrLf + IncludeEmailAttachmentsQry  + vbCrLf
                        // EmailSql = EmailSql + genUseExistingRecordsOnly(UseExistingRecordsOnly, "EmailGuid")
                        // End If
                        // EmailSql += vbCrLf + " or isPublic = 'Y' "
                        EmailSql += Constants.vbCrLf + " order by [ShortSubj] ";
                    }
                }
            }
            else
            {
                EmailSql = "";
            }

            if (bCopyToClipboard)
            {
                string tClip = "/* Final */ " + Constants.vbCrLf;
                tClip += EmailSql;
                if (bSaveToClipBoard)
                    modGlobals.SetToClipBoard(tClip);
                // Debug.Print(tClip)
            }


            // txtSearch  = Nothing
            // getCountOnly = Nothing
            // UseExistingRecordsOnly = Nothing
            // ckWeighted = Nothing
            // GeneratedSQL = Nothing
            // isAdmin = Nothing
            // ckBusiness = Nothing


            ValidateNotClauses(ref EmailSql);
            DMA.ckFreetextRemoveOr(ref EmailSql, "freetext ((Body, Description, KeyWords, Subject, Attachment, Ocrtext)");
            DMA.ckFreetextRemoveOr(ref EmailSql, "freetext (body");
            DMA.ckFreetextRemoveOr(ref EmailSql, "freetext (subject");
            // SetToClipBoard(EmailSql)
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

        public void GetToken(int I, ref int k, string tStr)
        {
            int X = tStr.Trim().Length;
            string CH = "";
            string Alphabet = " |+-^";
            var loopTo = X;
            for (I = I; I <= loopTo; I++)
            {
                CH = Strings.Mid(tStr, I, 1);
                if (Strings.InStr(1, Alphabet, CH, CompareMethod.Text) > 0)
                {
                    // We found the next word
                }
            }
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

        public void TranslateDelimiter(string CH, ref string Translateddel)
        {
            Translateddel = "";
            switch (CH ?? "")
            {
                case "+":
                    {
                        Translateddel = "And";
                        break;
                    }

                case "-":
                    {
                        Translateddel = "Not";
                        break;
                    }

                case "|":
                    {
                        Translateddel = "Or";
                        break;
                    }
            }
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

        public string getThesaurusWords(ArrayList ThesaurusList, ref ArrayList ThesaurusWords)
        {
            string AllWords = "";
            string ThesaurusName = "";
            if (modGlobals.gThesauri.Count == 1)
            {
                for (int kk = 0, loopTo = modGlobals.gThesauri.Count - 1; kk <= loopTo; kk++)
                {
                    ThesaurusName = modGlobals.gThesauri[kk].ToString();
                    ThesaurusList.Add(ThesaurusName);
                }
            }
            // FrmMDIMain.SB.Text = "Custom thesauri used"
            else if (modGlobals.gThesauri.Count > 0)
            {
                for (int kk = 0, loopTo1 = modGlobals.gThesauri.Count - 1; kk <= loopTo1; kk++)
                {
                    ThesaurusName = modGlobals.gThesauri[kk].ToString();
                    ThesaurusList.Add(ThesaurusName);
                }
                // FrmMDIMain.SB.Text = "Custom thesauri used"
            }

            string ListOfPhrases = "";
            var ExpandedWords = new ArrayList();
            if (ThesaurusList.Count == 0)
            {
                // ** Get and use the default Thesaurus'
                if (modGlobals.gClipBoardActive)
                    Console.WriteLine("No thesauri specified - using default.");
                // FrmMDIMain.SB.Text = "Default thesauri used"
                ThesaurusName = DBARCH.getSystemParm("Default Thesaurus");
                if (ThesaurusName.Equals("NA"))
                {
                    return "";
                }
                else
                {
                    ThesaurusList.Add(ThesaurusName);
                }
            }

            // ** Get and use the default Thesaurus
            foreach (string T in ThesaurusList)
            {
                ThesaurusName = T;
                string ThesaurusID = TREX.getThesaurusID(ThesaurusName);
                foreach (string token in ThesaurusWords)
                {
                    if (!ExpandedWords.Contains(token))
                    {
                        ExpandedWords.Add(token);
                    }

                    TREX.getSynonyms(ThesaurusID, token, ref ExpandedWords, true);
                }
            }

            foreach (string SS in ExpandedWords)
            {
                string tWord = SS;
                tWord = tWord.Trim();
                if (Strings.InStr(tWord, Conversions.ToString('"')) == 0)
                {
                    tWord = Conversions.ToString('"') + tWord + Conversions.ToString('"');
                }

                ListOfPhrases = ListOfPhrases + Conversions.ToString('\t') + tWord + " or " + Constants.vbCrLf;
            }

            if (ListOfPhrases == null)
            {
                return "";
            }
            else
            {
                ListOfPhrases = ListOfPhrases.Trim();
                ListOfPhrases = Strings.Mid(ListOfPhrases, 1, ListOfPhrases.Length - 3);
                return ListOfPhrases;
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
            if (Strings.InStr(ContainsList, "body, ' ')", CompareMethod.Text) > 0)
            {
                // ** It is a null where clause in effect
                ContainsList = "";
                b = false;
            }

            if (Strings.InStr(ContainsList, "body, ' or", CompareMethod.Text) > 0)
            {
                // ** It is a null where clause in effect
                ContainsList = "";
                b = false;
            }

            if (Strings.InStr(ContainsList, "body, ' and", CompareMethod.Text) > 0)
            {
                // ** It is a null where clause in effect
                ContainsList = "";
                b = false;
            }

            return b;
        }

        public string PopulateThesaurusList(ArrayList ThesaurusList, ref ArrayList ThesaurusWords, string txtThesaurus, string cbThesaurusText)
        {
            var A1 = new string[1];
            var A2 = new string[1];
            string Token = "";
            string ExpandedWords = "";
            if (Strings.InStr(1, txtThesaurus, ",") > 0)
            {
                A1 = txtThesaurus.Split(',');
            }
            else
            {
                A1[0] = txtThesaurus;
            }

            for (int i = 0, loopTo = Information.UBound(A1); i <= loopTo; i++)
            {
                Token = A1[i].Trim();
                if (Strings.InStr(Token, Conversions.ToString('"')) > 0)
                {
                    ThesaurusWords.Add(Token);
                }
                else
                {
                    A2 = Token.Split(' ');
                    for (int ii = 0, loopTo1 = Information.UBound(A2); ii <= loopTo1; ii++)
                        ThesaurusWords.Add(A2[ii].Trim());
                }
            }

            ExpandedWords = getThesaurusWords(ThesaurusList, ref ThesaurusWords);
            return ExpandedWords;
        }

        public string genContainsClause(string InputSearchString, bool useFreetext, bool ckWeighted, bool isEmail, bool LimitToCurrRecs, ArrayList ThesaurusList, string txtThesaurus, string cbThesaurusText, string calledBy)
        {
            string WhereClause = "";
            string S = "";
            // Dim ThesaurusList As New ArrayList
            var ThesaurusWords = new ArrayList();
            string ContainsClause = "";
            bool isValidContainsClause = false;
            int lParens = 0;
            int rParens = 0;
            if (InputSearchString.Length == 0)
            {
                // ** NO Search criteria was specified send back something that will return everything
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
                    if (DBARCH.isAdmin(modGlobals.gCurrUserGuidID) | DBARCH.isGlobalSearcher(modGlobals.gCurrUserGuidID) == true)
                    {
                        ContainsClause = " DataSourceOwnerUserID is not null ";
                    }
                    else
                    {
                        ContainsClause = " DataSourceOwnerUserID = '" + modGlobals.gCurrUserGuidID + "' ";
                    }
                }
                else
                {
                    ContainsClause = buildContainsSyntax(InputSearchString, ref ThesaurusWords);
                }

                isValidContainsClause = ValidateContainsList(ref ContainsClause);
                if (isEmail)
                {
                    if (useFreetext == true)
                    {
                        // ** This is FREETEXT searching, remove noise words                    
                        DBARCH.RemoveFreetextStopWords(ref InputSearchString);
                        if (InputSearchString.Length > 0 | txtThesaurus.Trim().Length > 0)
                        {
                            if (isValidContainsClause)
                            {
                                // (Body, Description, KeyWords, Subject, Attachment, Ocrtext)
                                WhereClause += " ( FREETEXT ((Body, SUBJECT, KeyWords, Description), '";
                                S = InputSearchString;
                                WhereClause += buildContainsSyntax(S, ref ThesaurusWords);
                                WhereClause += "') ";
                                rParens += 1;
                            }

                            if (txtThesaurus.Trim().Length > 0)
                            {
                                string ExpandedWordList = PopulateThesaurusList(ThesaurusList, ref ThesaurusWords, txtThesaurus, cbThesaurusText);
                                if (ExpandedWordList.Trim().Length > 0)
                                {
                                    WhereClause += Constants.vbCrLf + Conversions.ToString('\t') + cbThesaurusText + " FREETEXT ((Body, SUBJECT, KeyWords, Description), '" + ExpandedWordList;
                                    WhereClause += "')" + Constants.vbCrLf + "/* 0A1 */ " + Constants.vbCrLf;
                                    rParens += 1;
                                }
                            }

                            // ** 5/29/2008 by WDM now, get the SUBJECT searched too.
                            if (isValidContainsClause)
                            {
                                WhereClause += " or FREETEXT ((Body, SUBJECT, KeyWords, Description), '";
                                S = InputSearchString;
                                WhereClause += buildContainsSyntax(S, ref ThesaurusWords);
                                WhereClause += "') " + Constants.vbCrLf + " /* 00 */ " + Constants.vbCrLf;
                                rParens += 1;
                            }

                            if (txtThesaurus.Trim().Length > 0)
                            {
                                string ExpandedWordList = PopulateThesaurusList(ThesaurusList, ref ThesaurusWords, txtThesaurus, cbThesaurusText);
                                if (ExpandedWordList.Trim().Length > 0)
                                {
                                    WhereClause += Constants.vbCrLf + Conversions.ToString('\t') + " OR FREETEXT ((Body, SUBJECT, KeyWords, Description), '" + ExpandedWordList;
                                    WhereClause += "') ";
                                    rParens += 1;
                                }
                            }

                            WhereClause += ")" + Constants.vbCrLf + "  /* #2 */" + Constants.vbCrLf;
                        }
                    }
                    else
                    {
                        // Processing a weighted set of documents
                        lParens = 0;
                        if (InputSearchString.Length > 0 | txtThesaurus.Trim().Length > 0)
                        {
                            WhereClause += " ( CONTAINS(BODY, '";
                            S = InputSearchString;
                            WhereClause += buildContainsSyntax(S, ref ThesaurusWords);
                            WhereClause += "')   /*YY00a*/ " + Constants.vbCrLf;
                            lParens = lParens + 1;
                            if (txtThesaurus.Trim().Length > 0)
                            {
                                string ExpandedWordList = PopulateThesaurusList(ThesaurusList, ref ThesaurusWords, txtThesaurus, cbThesaurusText);
                                if (ExpandedWordList.Trim().Length > 0)
                                {
                                    WhereClause = WhereClause + Constants.vbCrLf;
                                    WhereClause += Constants.vbCrLf + Conversions.ToString('\t') + cbThesaurusText + " (CONTAINS (body, '" + ExpandedWordList;
                                    WhereClause += "')   /*YY00*/" + Constants.vbCrLf;
                                    lParens = lParens + 1;
                                }
                            }

                            WhereClause += " or CONTAINS(SUBJECT, '";
                            S = InputSearchString;
                            WhereClause += buildContainsSyntax(S, ref ThesaurusWords);
                            WhereClause += "')   /*XX01*/" + Constants.vbCrLf;
                            if (txtThesaurus.Trim().Length > 0)
                            {
                                string ExpandedWordList = PopulateThesaurusList(ThesaurusList, ref ThesaurusWords, txtThesaurus, cbThesaurusText);
                                if (ExpandedWordList.Trim().Length > 0)
                                {
                                    WhereClause = WhereClause + Constants.vbCrLf;
                                    WhereClause += Constants.vbCrLf + Conversions.ToString('\t') + cbThesaurusText + " (CONTAINS (subject, '" + getThesaurusWords(ThesaurusList, ref ThesaurusWords);
                                    WhereClause += "')   /*YY01*/" + Constants.vbCrLf;
                                    lParens = lParens + 1;
                                }
                            }

                            if (lParens == 1)
                            {
                                WhereClause += ")     /*XX02a*/" + Constants.vbCrLf;
                            }
                            else if (lParens == 2)
                            {
                                WhereClause += "))     /*XX02b*/" + Constants.vbCrLf;
                            }
                            else if (lParens == 3)
                            {
                                WhereClause += ")))     /*XX02c*/" + Constants.vbCrLf;
                            }
                        }
                    }
                }
                // ** Processing documents, not emails
                else if (useFreetext == true)
                {
                    if (InputSearchString.Length > 0 | txtThesaurus.Trim().Length > 0)
                    {
                        DBARCH.RemoveFreetextStopWords(ref InputSearchString);
                        DBARCH.RemoveFreetextStopWords(ref txtThesaurus);
                        // WhereClause += " FREETEXT (SourceImage, '"
                        // WhereClause += " FREETEXT (DataSource.*, '"
                        WhereClause += " FREETEXT ((Description, KeyWords, Notes, SourceImage, SourceName), '";
                        S = InputSearchString;
                        WhereClause += buildContainsSyntax(S, ref ThesaurusWords);
                        WhereClause += "')";
                        if (txtThesaurus.Trim().Length > 0)
                        {
                            string ExpandedWordList = PopulateThesaurusList(ThesaurusList, ref ThesaurusWords, txtThesaurus, cbThesaurusText);
                            if (ExpandedWordList.Trim().Length > 0)
                            {
                                // WhereClause += vbCrLf + Chr(9) + cbThesaurusText  + " freetext (SourceImage, '" + ExpandedWordList 
                                // WhereClause += vbCrLf + Chr(9) + cbThesaurusText  + " freetext (DataSource.*, '" + ExpandedWordList 
                                WhereClause += Constants.vbCrLf + Conversions.ToString('\t') + cbThesaurusText + " freetext ((Description, KeyWords, Notes, SourceImage, SourceName), '" + ExpandedWordList;
                                WhereClause += "')" + Constants.vbCrLf + "/* 0A2 */ " + Constants.vbCrLf;
                                rParens += 1;
                            }
                        }
                    }
                }
                else if (InputSearchString.Length > 0 | txtThesaurus.Trim().Length > 0)
                {
                    WhereClause += " (CONTAINS(SourceImage, '";
                    S = InputSearchString;
                    WhereClause += buildContainsSyntax(S, ref ThesaurusWords);
                    WhereClause += "'))     /*XX03*/ ";
                    if (txtThesaurus.Trim().Length > 0)
                    {
                        string ExpandedWordList = PopulateThesaurusList(ThesaurusList, ref ThesaurusWords, txtThesaurus, cbThesaurusText);
                        if (ExpandedWordList.Trim().Length > 0)
                        {
                            WhereClause += Constants.vbCrLf + Conversions.ToString('\t') + cbThesaurusText + " CONTAINS (SourceImage, '" + ExpandedWordList;
                            WhereClause += "')" + Constants.vbCrLf + "/* 0A3 */ " + Constants.vbCrLf;
                            rParens += 1;
                        }
                    }
                }
            }
            // ** No weightings used in this query
            else if (InputSearchString.Length == 0)
            {
                if (DBARCH.isAdmin(modGlobals.gCurrUserGuidID) | DBARCH.isGlobalSearcher(modGlobals.gCurrUserGuidID) == true)
                {
                    ContainsClause = " DataSourceOwnerUserID is not null ";
                }
                else
                {
                    ContainsClause = " DataSourceOwnerUserID = '" + modGlobals.gCurrUserGuidID + "' ";
                }
            }
            else if (useFreetext == true)
            {
                if (InputSearchString.Length > 0 | txtThesaurus.Trim().Length > 0)
                {
                    DBARCH.RemoveFreetextStopWords(ref InputSearchString);
                    DBARCH.RemoveFreetextStopWords(ref txtThesaurus);
                    WhereClause += " FREETEXT ((Body, SUBJECT, KeyWords, Description), '";
                    S = InputSearchString;
                    WhereClause += buildContainsSyntax(S, ref ThesaurusWords);
                    WhereClause += "')" + Constants.vbCrLf;
                    if (txtThesaurus.Trim().Length > 0)
                    {
                        string ExpandedWordList = PopulateThesaurusList(ThesaurusList, ref ThesaurusWords, txtThesaurus, cbThesaurusText);
                        if (ExpandedWordList.Trim().Length > 0)
                        {
                            WhereClause += Constants.vbCrLf + Conversions.ToString('\t') + cbThesaurusText + " FREETEXT ((Body, SUBJECT, KeyWords, Description), '" + ExpandedWordList;
                            WhereClause += "')" + Constants.vbCrLf + "/* 0A4 */ " + Constants.vbCrLf;
                            rParens += 1;
                        }
                    }
                    // WhereClause += ")  /* XX  Final Quotes */"
                }
            }
            else if (InputSearchString.Length > 0 | txtThesaurus.Trim().Length > 0)
            {
                WhereClause += " CONTAINS(*, '";
                S = InputSearchString;
                WhereClause += buildContainsSyntax(S, ref ThesaurusWords);
                WhereClause += "')     /*XX04*/ ";
                if (txtThesaurus.Trim().Length > 0)
                {
                    string ExpandedWordList = PopulateThesaurusList(ThesaurusList, ref ThesaurusWords, txtThesaurus, cbThesaurusText);
                    if (ExpandedWordList.Trim().Length > 0)
                    {
                        WhereClause += Constants.vbCrLf + Conversions.ToString('\t') + cbThesaurusText + " CONTAINS (*, '" + ExpandedWordList;
                        WhereClause += "')" + Constants.vbCrLf + "/* 0A5 */ " + Constants.vbCrLf;
                        rParens += 1;
                    }
                }
                // WhereClause += ")" + vbCrLf + "/* 9A */ " + vbCrLf
            }

            ThesaurusList = null;
            ThesaurusWords = null;
            return WhereClause;
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

                    if (ddebug)
                    {
                        Debug.Print(S);
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

        public string getAllTablesSql()
        {
            string s = "Select * from sysobjects where xtype = 'U'";
            return s;
        }

        public SqlDataReader getAllColsSql(string TblID)
        {
            string s = "Select C.name, C.column_id, ";
            s = s + " C.system_type_id , C.max_length, ";
            s = s + " C.precision, C.scale, C.is_nullable,";
            s = s + " C.is_identity, T.name  ";
            s = s + " from sys.objects T,  sys.columns C";
            s = s + " where T.type = 'U' and";
            s = s + " C.object_id = T.object_id and";
            s = s + " T.object_id = " + TblID + " ";
            s = s + " order by C.column_id";
            SqlDataReader rsData = null;
            try
            {
                string CS = DBARCH.setConnStr();     // DBARCH.getGateWayConnStr(gGateWayID) : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader()
            }
            catch (Exception ex)
            {
                if (ddebug)
                    Console.WriteLine("Exception Type: {0}", ex.GetType());
                if (ddebug)
                    Console.WriteLine("  Message: {0}", ex.Message);
                if (ddebug)
                    Console.WriteLine(s);
                Clipboard.Clear();
                if (ddebug)
                    modGlobals.SetToClipBoard(s);
                if (ddebug)
                    Console.WriteLine(" SQL in clipboard", s);
                Debug.Print(" SQL in clipboard", s);
                MessageBox.Show(ex.Message);
                LOG.WriteToArchiveLog("clsSql : getAllColsSql : 677 : " + ex.Message);
            }

            return rsData;
        }

        public string genAdminContentSql(bool isAdmin, bool ckLimitToLib, string LibraryName)
        {
            string UserSql = "";
            LibraryName = UTIL.RemoveSingleQuotes(LibraryName);
            if (DBARCH.isAdmin(modGlobals.gCurrUserGuidID) | DBARCH.isGlobalSearcher(modGlobals.gCurrUserGuidID) == true)
            {
                // ** ECM WhereClause
                if (ckLimitToLib == true)
                {
                    // UserSql = UserSql + " AND SourceGuid in (SELECT [SourceGuid] FROM [LibraryItems] where LibraryName = '" + LibraryName  + "')" + vbCrLf
                    // ** DO NOT PUT vbcrlf at the end of the below lines. That will cause problems in inserting PAGING.
                    UserSql = UserSql + " AND SourceGuid in (" + GEN.genLibrarySearch(modGlobals.gCurrUserGuidID, true, LibraryName, "Gen@13") + ")";
                }
                else
                {
                    if (modGlobals.gMyContentOnly == true)
                    {
                        UserSql = UserSql + " and ( DataSourceOwnerUserID = '" + modGlobals.gCurrUserGuidID + "') " + Constants.vbCrLf;
                    }
                    else
                    {
                        bool gSearcher = false;
                        if (DBARCH.isAdmin(modGlobals.gCurrUserGuidID) == true | DBARCH.isGlobalSearcher(modGlobals.gCurrUserGuidID) == true)
                        {
                            gSearcher = true;
                        }

                        string IncludeLibsSql = GEN.genLibrarySearch(modGlobals.gCurrUserGuidID, true, gSearcher, "@Gen31");
                        UserSql = UserSql + IncludeLibsSql;
                    }

                    if (modGlobals.gMasterContentOnly == true)
                    {
                        UserSql = UserSql + " and ( isMaster = 'Y' )       /*KEEP*/" + Constants.vbCrLf;
                    }
                }
            }

            // '** Removed by WDM 7/12/2008
            // UserSql = UserSql + " OR" + vbCrLf
            // UserSql = UserSql + " DataSourceOwnerUserID in (select distinct UserID from LibraryUsers " + vbCrLf
            // UserSql = UserSql + "             where(LibraryName)" + vbCrLf
            // UserSql = UserSql + " in (Select LibraryName from LibrariesContainingUser))" + vbCrLf
            // UserSql = UserSql + " )" + vbCrLf
            else if (ckLimitToLib == true)
            {
                bool gSearcher = false;
                if (DBARCH.isAdmin(modGlobals.gCurrUserGuidID) == true | DBARCH.isGlobalSearcher(modGlobals.gCurrUserGuidID) == true)
                {
                    gSearcher = true;
                }

                UserSql = " AND SourceGuid in (" + GEN.genLibrarySearch(modGlobals.gCurrUserGuidID, gSearcher, LibraryName, "Gen@01") + ")";
            }
            else
            {
                // UserSql = UserSql + " and ( DataSourceOwnerUserID is not null OR isPublic = 'Y' )" + vbCrLf
                // ** ECM WhereClause
                if (modGlobals.gMyContentOnly == true)
                {
                    UserSql = UserSql + " and ( DataSourceOwnerUserID = '" + modGlobals.gCurrUserGuidID + "') " + Constants.vbCrLf;
                }
                else
                {
                    bool gSearcher = false;
                    if (DBARCH.isAdmin(modGlobals.gCurrUserGuidID) == true | DBARCH.isGlobalSearcher(modGlobals.gCurrUserGuidID) == true)
                    {
                        gSearcher = true;
                    }

                    string IncludeLibsSql = GEN.genLibrarySearch(modGlobals.gCurrUserGuidID, true, gSearcher, "@Gen32");
                    UserSql = UserSql + IncludeLibsSql;
                }

                if (modGlobals.gMasterContentOnly == true)
                {
                    UserSql = UserSql + " and ( isMaster = 'Y' )      /*KEEP*/" + Constants.vbCrLf;
                }

                // UserSql = UserSql + " OR isPublic = 'Y' " + vbCrLf    '** WDM Add 7/9/2009
                /// ** Removed by WDM 7/12/2008
            // UserSql = UserSql + " OR DataSourceOwnerUserID in (select distinct UserID from LibraryUsers " + vbCrLf
            // UserSql = UserSql + "             where(LibraryName)" + vbCrLf
            // UserSql = UserSql + " in (Select LibraryName from LibrariesContainingUser))" + vbCrLf
            // UserSql = UserSql + " )" + vbCrLf
            }

            return UserSql;
        }

        public string genAdminEmailSql(bool isAdmin, bool ckLimitToLib, string LibraryName)
        {
            string UserSql = "";
            modGlobals.isGlobalSearcher = DBARCH.isGlobalSearcher(modGlobals.gCurrUserGuidID);
            if (DBARCH.isAdmin(modGlobals.gCurrUserGuidID) | DBARCH.isGlobalSearcher(modGlobals.gCurrUserGuidID) == true)
            {
                // ** ECM WhereClause
                if (ckLimitToLib == true)
                {
                    // ** DO NOT PUT vbcrlf at the end of the below lines. That will cause problems in inserting PAGING.
                    bool gSearcher = false;
                    if (DBARCH.isAdmin(modGlobals.gCurrUserGuidID) == true | DBARCH.isGlobalSearcher(modGlobals.gCurrUserGuidID) == true)
                    {
                        gSearcher = true;
                    }

                    UserSql = UserSql + " AND EmailGuid in (" + GEN.genLibrarySearch(modGlobals.gCurrUserGuidID, gSearcher, LibraryName, "Gen@10") + ")";
                }
                else
                {
                    if (modGlobals.gMyContentOnly == true)
                    {
                        UserSql = UserSql + " and ( UserID = '" + modGlobals.gCurrUserGuidID + "') " + Constants.vbCrLf;
                    }
                    else
                    {
                        bool gSearcher = false;
                        if (DBARCH.isAdmin(modGlobals.gCurrUserGuidID) == true | DBARCH.isGlobalSearcher(modGlobals.gCurrUserGuidID) == true)
                        {
                            gSearcher = true;
                        }

                        string IncludeLibsSql = GEN.genLibrarySearch(modGlobals.gCurrUserGuidID, false, gSearcher, "@Gen34");
                        UserSql = UserSql + IncludeLibsSql;
                    }

                    if (modGlobals.gMasterContentOnly == true)
                    {
                        UserSql = UserSql + " and ( isMaster = 'Y' )     /*KEEP*/" + Constants.vbCrLf;
                    }
                }
            }
            // UserSql = UserSql + " OR" + vbCrLf
            // 'UserSql = UserSql + " UserID in (select distinct UserID from LibraryUsers " + vbCrLf
            /// ** Removed by WDM 7/12/2008
            // UserSql = UserSql + " '" + gCurrUserGuidID + "' in (select distinct UserID from LibraryUsers " + vbCrLf
            // UserSql = UserSql + "             where(LibraryName)" + vbCrLf
            // UserSql = UserSql + " in (Select LibraryName from LibrariesContainingUser))" + vbCrLf
            // UserSql = UserSql + " )" + vbCrLf
            else if (ckLimitToLib == true)
            {
                bool gSearcher = false;
                if (DBARCH.isAdmin(modGlobals.gCurrUserGuidID) == true | DBARCH.isGlobalSearcher(modGlobals.gCurrUserGuidID) == true)
                {
                    gSearcher = true;
                }

                UserSql = UserSql + " AND EmailGuid in (" + GEN.genLibrarySearch(modGlobals.gCurrUserGuidID, gSearcher, LibraryName, "Gen@11") + ")";
            }
            else
            {
                // ** ECM WhereClause
                if (modGlobals.gMyContentOnly == true)
                {
                    UserSql = UserSql + " and ( UserID = '" + modGlobals.gCurrUserGuidID + "') " + Constants.vbCrLf;
                }
                else
                {
                    bool gSearcher = false;
                    if (DBARCH.isAdmin(modGlobals.gCurrUserGuidID) == true | DBARCH.isGlobalSearcher(modGlobals.gCurrUserGuidID) == true)
                    {
                        gSearcher = true;
                    }

                    string IncludeLibsSql = GEN.genLibrarySearch(modGlobals.gCurrUserGuidID, false, gSearcher, "@Gen30");
                    UserSql = UserSql + IncludeLibsSql;
                }

                if (modGlobals.gMasterContentOnly == true)
                {
                    UserSql = UserSql + " and ( isMaster = 'Y' )      /*KEEP*/" + Constants.vbCrLf;
                }
                // '** Removed by WDM 7/12/2008
                // UserSql = UserSql + " OR isPublic = 'Y' " + vbCrLf
                // UserSql = UserSql + " OR '" + gCurrUserGuidID + "' in (select distinct UserID from LibraryUsers " + vbCrLf
                // UserSql = UserSql + "             where(LibraryName)" + vbCrLf
                // UserSql = UserSql + " in (Select LibraryName from LibrariesContainingUser))" + vbCrLf
                // UserSql = UserSql + " )" + vbCrLf
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
                    if (Conversion.Val(modGlobals.gMaxRecordsToFetch) > 0d)
                    {
                        DocsSql = " SELECT TOP " + modGlobals.gMaxRecordsToFetch;
                    }
                    else
                    {
                        DocsSql = " SELECT ";
                    }
                }

                DocsSql += Constants.vbTab + " KEY_TBL.RANK, DS.SourceName 	" + Constants.vbCrLf;
                DocsSql += Constants.vbTab + ",DS.CreateDate " + Constants.vbCrLf;
                DocsSql += Constants.vbTab + ",DS.VersionNbr 	" + Constants.vbCrLf;
                DocsSql += Constants.vbTab + ",DS.LastAccessDate " + Constants.vbCrLf;
                DocsSql += Constants.vbTab + ",DS.FileLength " + Constants.vbCrLf;
                DocsSql += Constants.vbTab + ",DS.LastWriteTime " + Constants.vbCrLf;
                DocsSql += Constants.vbTab + ",DS.OriginalFileType 		" + Constants.vbCrLf;
                DocsSql += Constants.vbTab + ",DS.isPublic " + Constants.vbCrLf;
                DocsSql += Constants.vbTab + ",DS.FQN " + Constants.vbCrLf;
                DocsSql += Constants.vbTab + ",DS.SourceGuid " + Constants.vbCrLf;
                DocsSql += Constants.vbTab + ",DS.DataSourceOwnerUserID, DS.FileDirectory, DS.RetentionExpirationDate, DS.isMaster, DS.StructuredData, DS.RepoSvrName " + Constants.vbCrLf;
                DocsSql += "FROM DataSource as DS " + Constants.vbCrLf;
            }
            else
            {
                if (modGlobals.gMaxRecordsToFetch.Length > 0)
                {
                    if (Conversion.Val(modGlobals.gMaxRecordsToFetch) > 0d)
                    {
                        DocsSql = " SELECT TOP " + modGlobals.gMaxRecordsToFetch;
                    }
                    else
                    {
                        DocsSql = " SELECT ";
                    }
                }

                DocsSql += Constants.vbTab + "[SourceName] 	" + Constants.vbCrLf;
                DocsSql += Constants.vbTab + ",[CreateDate] " + Constants.vbCrLf;
                DocsSql += Constants.vbTab + ",[VersionNbr] 	" + Constants.vbCrLf;
                DocsSql += Constants.vbTab + ",[LastAccessDate] " + Constants.vbCrLf;
                DocsSql += Constants.vbTab + ",[FileLength] " + Constants.vbCrLf;
                DocsSql += Constants.vbTab + ",[LastWriteTime] " + Constants.vbCrLf;
                DocsSql += Constants.vbTab + ",[SourceTypeCode] 		" + Constants.vbCrLf;
                DocsSql += Constants.vbTab + ",[isPublic] " + Constants.vbCrLf;
                DocsSql += Constants.vbTab + ",[FQN] " + Constants.vbCrLf;
                DocsSql += Constants.vbTab + ",[SourceGuid] " + Constants.vbCrLf;
                DocsSql += Constants.vbTab + ",[DataSourceOwnerUserID], FileDirectory, StructuredData, RepoSvrName " + Constants.vbCrLf;
                DocsSql += "FROM DataSource " + Constants.vbCrLf;
            }

            return DocsSql;
        }

        public void MergeEmailAttachments(bool ckWeighted, string Weight, ref DataSet DS, bool PaginateData, int LowerPageNbr, int UpperPageNbr)
        {
            if (PaginateData == true & LowerPageNbr > 1)
            {
                return;
            }

            string S = "";
            if (ckWeighted == true)
            {
                if (PaginateData == true)
                {
                    S = S + " SELECT     Email.SentOn, Email.ShortSubj, Email.SenderEmailAddress, Email.SenderName, Email.SentTO, SUBSTRING(Email.Body, 1, 100) AS Body, Email.CC, Email.Bcc, " + Constants.vbCrLf;
                    S = S + "                       Email.CreationTime, Email.AllRecipients, Email.ReceivedByName, Email.ReceivedTime, Email.MsgSize, Email.SUBJECT, Email.OriginalFolder, Email.EmailGuid, " + Constants.vbCrLf;
                    S = S + "                       Email.RetentionExpirationDate, Email.isPublic,  ' ' as ConvertEmailToMsg, Email.UserID, Email.NbrAttachments, Email.SourceTypeCode, 'Y' AS FoundInAttachment, " + Constants.vbCrLf;
                    S = S + "                       CONVERT(varchar, EmailAttachment.RowID) AS RID, EmailAttachment.RepoSvrName, 9999999 as RowID  " + Constants.vbCrLf;
                    S = S + " FROM         Email INNER JOIN" + Constants.vbCrLf;
                    S = S + "                       EmailAttachmentSearchList ON Email.EmailGuid = EmailAttachmentSearchList.EmailGuid INNER JOIN" + Constants.vbCrLf;
                    S = S + "                       EmailAttachment ON EmailAttachmentSearchList.EmailGuid = EmailAttachment.EmailGuid AND EmailAttachmentSearchList.RowID = EmailAttachment.RowID" + Constants.vbCrLf;
                    S = S + " WHERE     (EmailAttachmentSearchList.UserID = '" + modGlobals.gCurrUserGuidID + "')" + Constants.vbCrLf;
                }
                else
                {
                    S = "Select     EmailAttachmentSearchList.Weight AS RANK, Email.SentOn, Email.ShortSubj, Email.SenderEmailAddress, Email.SenderName, Email.SentTO, ";
                    S = S + "                       SUBSTRING(Email.Body, 1, 100) AS Body, Email.CC, Email.Bcc, Email.CreationTime, Email.AllRecipients, Email.ReceivedByName, Email.ReceivedTime, ";
                    S = S + "                       Email.MsgSize, Email.SUBJECT, Email.OriginalFolder, Email.EmailGuid, Email.RetentionExpirationDate, Email.isPublic, ' ' as ConvertEmailToMsg, Email.UserID, Email.NbrAttachments, ";
                    S = S + "                       Email.SourceTypeCode, 'Y' AS FoundInAttachment, CONVERT(varchar, EmailAttachment.RowID) AS RID";
                    S = S + " FROM         Email INNER JOIN";
                    S = S + "                       EmailAttachmentSearchList ON Email.EmailGuid = EmailAttachmentSearchList.EmailGuid INNER JOIN";
                    S = S + "                       EmailAttachment ON EmailAttachmentSearchList.EmailGuid = EmailAttachment.EmailGuid AND EmailAttachmentSearchList.RowID = EmailAttachment.RowID";
                    S = S + " WHERE     (EmailAttachmentSearchList.UserID = '" + modGlobals.gCurrUserGuidID + "') AND (EmailAttachmentSearchList.Weight >= 0)";
                }
            }
            else if (PaginateData == true)
            {
                S = S + " SELECT     Email.SentOn, Email.ShortSubj, Email.SenderEmailAddress, Email.SenderName, Email.SentTO, SUBSTRING(Email.Body, 1, 100) AS Body, Email.CC, Email.Bcc, " + Constants.vbCrLf;
                S = S + "                       Email.CreationTime, Email.AllRecipients, Email.ReceivedByName, Email.ReceivedTime, Email.MsgSize, Email.SUBJECT, Email.OriginalFolder, Email.EmailGuid, " + Constants.vbCrLf;
                S = S + "                       Email.RetentionExpirationDate, Email.isPublic,  ' ' as ConvertEmailToMsg, Email.UserID, Email.NbrAttachments, Email.SourceTypeCode, 'Y' AS FoundInAttachment, " + Constants.vbCrLf;
                S = S + "                       CONVERT(varchar, EmailAttachment.RowID) AS RID, EmailAttachment.RepoSvrName, 9999999 as RowID  " + Constants.vbCrLf;
                S = S + " FROM         Email INNER JOIN" + Constants.vbCrLf;
                S = S + "                       EmailAttachmentSearchList ON Email.EmailGuid = EmailAttachmentSearchList.EmailGuid INNER JOIN" + Constants.vbCrLf;
                S = S + "                       EmailAttachment ON EmailAttachmentSearchList.EmailGuid = EmailAttachment.EmailGuid AND EmailAttachmentSearchList.RowID = EmailAttachment.RowID" + Constants.vbCrLf;
                S = S + " WHERE     (EmailAttachmentSearchList.UserID = '" + modGlobals.gCurrUserGuidID + "')" + Constants.vbCrLf;
            }
            else
            {
                S = S + " SELECT     Email.SentOn, Email.ShortSubj, Email.SenderEmailAddress, Email.SenderName, Email.SentTO, SUBSTRING(Email.Body, 1, 100) AS Body, Email.CC, Email.Bcc, " + Constants.vbCrLf;
                S = S + "                       Email.CreationTime, Email.AllRecipients, Email.ReceivedByName, Email.ReceivedTime, Email.MsgSize, Email.SUBJECT, Email.OriginalFolder, Email.EmailGuid, " + Constants.vbCrLf;
                S = S + "                       Email.RetentionExpirationDate, Email.isPublic,  ' ' as ConvertEmailToMsg, Email.UserID, Email.NbrAttachments, Email.SourceTypeCode, 'Y' AS FoundInAttachment, " + Constants.vbCrLf;
                S = S + "                       CONVERT(varchar, EmailAttachment.RowID) AS RID, EmailAttachment.RepoSvrName  " + Constants.vbCrLf;
                S = S + " FROM         Email INNER JOIN" + Constants.vbCrLf;
                S = S + "                       EmailAttachmentSearchList ON Email.EmailGuid = EmailAttachmentSearchList.EmailGuid INNER JOIN" + Constants.vbCrLf;
                S = S + "                       EmailAttachment ON EmailAttachmentSearchList.EmailGuid = EmailAttachment.EmailGuid AND EmailAttachmentSearchList.RowID = EmailAttachment.RowID" + Constants.vbCrLf;
                S = S + " WHERE     (EmailAttachmentSearchList.UserID = '" + modGlobals.gCurrUserGuidID + "')" + Constants.vbCrLf;
            }

            // Clipboard.Clear()
            // Clipboard.SetText(S)

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
                Clipboard.Clear();
            if (modGlobals.gClipBoardActive == true)
                Clipboard.SetText(S);
            if (modGlobals.gClipBoardActive == true)
                MessageBox.Show("Email Attachments SQL in clipboard.");
            string CS = DBARCH.setConnStr();     // DBARCH.getGateWayConnStr(gGateWayID)
            var sqlConn = new SqlConnection(CS);
            var dsAttach = new DataSet();
            var SQLAdapter = new SqlDataAdapter(S, CS);
            // sadapt.Fill(ds, "Email")
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
                    if (Conversion.Val(modGlobals.gMaxRecordsToFetch) > 0d)
                    {
                        GenSql = " SELECT TOP " + modGlobals.gMaxRecordsToFetch;
                    }
                    else
                    {
                        GenSql = " SELECT ";
                    }
                }

                GenSql = GenSql + "  KEY_TBL.RANK, DS.SentOn " + Constants.vbCrLf;
                GenSql = GenSql + " ,DS.ShortSubj" + Constants.vbCrLf;
                GenSql = GenSql + " ,DS.SenderEmailAddress" + Constants.vbCrLf;
                GenSql = GenSql + " ,DS.SenderName" + Constants.vbCrLf;
                GenSql = GenSql + " ,DS.SentTO" + Constants.vbCrLf;
                GenSql = GenSql + " ,substring(DS.Body,1,100) as Body" + Constants.vbCrLf;
                GenSql = GenSql + " ,DS.CC " + Constants.vbCrLf;
                GenSql = GenSql + " ,DS.Bcc " + Constants.vbCrLf;
                GenSql = GenSql + " ,DS.CreationTime" + Constants.vbCrLf;
                GenSql = GenSql + " ,DS.AllRecipients" + Constants.vbCrLf;
                GenSql = GenSql + " ,DS.ReceivedByName" + Constants.vbCrLf;
                GenSql = GenSql + " ,DS.ReceivedTime " + Constants.vbCrLf;
                GenSql = GenSql + " ,DS.MsgSize" + Constants.vbCrLf;
                GenSql = GenSql + " ,DS.SUBJECT" + Constants.vbCrLf;
                GenSql = GenSql + " ,DS.OriginalFolder " + Constants.vbCrLf;
                GenSql = GenSql + " ,DS.EmailGuid, DS.RetentionExpirationDate, DS.isPublic, DS.ConvertEmlToMSG, DS.UserID, DS.NbrAttachments, DS.SourceTypeCode, 'N' as FoundInAttachment, ' ' as RID, RepoSvrName  " + Constants.vbCrLf;
                GenSql = GenSql + " FROM EMAIL AS DS " + Constants.vbCrLf;
                GenSql += genIsAbout(ckWeighted, ckBusiness, SearchText, true);
            }
            else
            {
                if (modGlobals.gMaxRecordsToFetch.Length > 0)
                {
                    if (Conversion.Val(modGlobals.gMaxRecordsToFetch) > 0d)
                    {
                        GenSql = " SELECT TOP " + modGlobals.gMaxRecordsToFetch;
                    }
                    else
                    {
                        GenSql = " SELECT ";
                    }
                }

                GenSql = GenSql + " [SentOn] " + Constants.vbCrLf;
                GenSql = GenSql + " ,[ShortSubj]" + Constants.vbCrLf;
                GenSql = GenSql + " ,[SenderEmailAddress]" + Constants.vbCrLf;
                GenSql = GenSql + " ,[SenderName]" + Constants.vbCrLf;
                GenSql = GenSql + " ,[SentTO]" + Constants.vbCrLf;
                GenSql = GenSql + " ,substring(Body,1,100) as Body " + Constants.vbCrLf;
                GenSql = GenSql + " ,[CC] " + Constants.vbCrLf;
                GenSql = GenSql + " ,[Bcc] " + Constants.vbCrLf;
                GenSql = GenSql + " ,[CreationTime]" + Constants.vbCrLf;
                GenSql = GenSql + " ,[AllRecipients]" + Constants.vbCrLf;
                GenSql = GenSql + " ,[ReceivedByName]" + Constants.vbCrLf;
                GenSql = GenSql + " ,[ReceivedTime] " + Constants.vbCrLf;
                GenSql = GenSql + " ,[MsgSize]" + Constants.vbCrLf;
                GenSql = GenSql + " ,[SUBJECT]" + Constants.vbCrLf;
                GenSql = GenSql + " ,[OriginalFolder] " + Constants.vbCrLf;
                GenSql = GenSql + " ,[EmailGuid], RetentionExpirationDate, isPublic, ConvertEmlToMSG, UserID, NbrAttachments, SourceTypeCode, 'N' as FoundInAttachment, ' ' as RID, RepoSvrName   " + Constants.vbCrLf;
                GenSql = GenSql + " FROM EMAIL " + Constants.vbCrLf;
            }

            GenSql = GenSql + " WHERE " + Constants.vbCrLf;
            return GenSql;
        }

        public string getEmailTblCols(bool ckWeighted, bool ckBusiness, string SearchText)
        {
            string SearchSql = "";
            if (ckWeighted == true)
            {
                if (modGlobals.gMaxRecordsToFetch.Length > 0)
                {
                    if (Conversion.Val(modGlobals.gMaxRecordsToFetch) > 0d)
                    {
                        SearchSql = " SELECT TOP " + modGlobals.gMaxRecordsToFetch;
                    }
                    else
                    {
                        SearchSql = " SELECT ";
                    }
                }

                SearchSql = SearchSql + "  KEY_TBL.RANK, DS.SentOn " + Constants.vbCrLf;
                SearchSql = SearchSql + " ,DS.ShortSubj" + Constants.vbCrLf;
                SearchSql = SearchSql + " ,DS.SenderEmailAddress" + Constants.vbCrLf;
                SearchSql = SearchSql + " ,DS.SenderName" + Constants.vbCrLf;
                SearchSql = SearchSql + " ,DS.SentTO" + Constants.vbCrLf;
                SearchSql = SearchSql + " ,DS.Body " + Constants.vbCrLf;
                SearchSql = SearchSql + " ,DS.CC " + Constants.vbCrLf;
                SearchSql = SearchSql + " ,DS.Bcc " + Constants.vbCrLf;
                SearchSql = SearchSql + " ,DS.CreationTime" + Constants.vbCrLf;
                SearchSql = SearchSql + " ,DS.AllRecipients" + Constants.vbCrLf;
                SearchSql = SearchSql + " ,DS.ReceivedByName" + Constants.vbCrLf;
                SearchSql = SearchSql + " ,DS.ReceivedTime " + Constants.vbCrLf;
                SearchSql = SearchSql + " ,DS.MsgSize" + Constants.vbCrLf;
                SearchSql = SearchSql + " ,DS.SUBJECT" + Constants.vbCrLf;
                SearchSql = SearchSql + " ,DS.OriginalFolder " + Constants.vbCrLf;
                SearchSql = SearchSql + " ,DS.EmailGuid, DS.RetentionExpirationDate, DS.isPublic, DS.UserID, DS.SourceTypeCode, DS.NbrAttachments , ' ' as RID, RepoSvrName  " + Constants.vbCrLf;
                SearchSql = SearchSql + " FROM EMAIL AS DS " + Constants.vbCrLf;
                SearchSql += genIsAbout(ckWeighted, ckBusiness, SearchText, true);
            }
            else
            {
                if (modGlobals.gMaxRecordsToFetch.Length > 0)
                {
                    if (Conversion.Val(modGlobals.gMaxRecordsToFetch) > 0d)
                    {
                        SearchSql = " SELECT TOP " + modGlobals.gMaxRecordsToFetch;
                    }
                    else
                    {
                        SearchSql = " SELECT ";
                    }
                }

                SearchSql = SearchSql + " [SentOn] " + Constants.vbCrLf;
                SearchSql = SearchSql + " ,[ShortSubj]" + Constants.vbCrLf;
                SearchSql = SearchSql + " ,[SenderEmailAddress]" + Constants.vbCrLf;
                SearchSql = SearchSql + " ,[SenderName]" + Constants.vbCrLf;
                SearchSql = SearchSql + " ,[SentTO]" + Constants.vbCrLf;
                SearchSql = SearchSql + " ,[Body] " + Constants.vbCrLf;
                SearchSql = SearchSql + " ,[CC] " + Constants.vbCrLf;
                SearchSql = SearchSql + " ,[Bcc] " + Constants.vbCrLf;
                SearchSql = SearchSql + " ,[CreationTime]" + Constants.vbCrLf;
                SearchSql = SearchSql + " ,[AllRecipients]" + Constants.vbCrLf;
                SearchSql = SearchSql + " ,[ReceivedByName]" + Constants.vbCrLf;
                SearchSql = SearchSql + " ,[ReceivedTime] " + Constants.vbCrLf;
                SearchSql = SearchSql + " ,[MsgSize]" + Constants.vbCrLf;
                SearchSql = SearchSql + " ,[SUBJECT]" + Constants.vbCrLf;
                SearchSql = SearchSql + " ,[OriginalFolder] " + Constants.vbCrLf;
                SearchSql = SearchSql + " ,[EmailGuid], RetentionExpirationDate, isPublic, UserID, SourceTypeCode, NbrAttachments, ' ' as RID, RepoSvrName " + Constants.vbCrLf;
                SearchSql = SearchSql + " FROM EMAIL " + Constants.vbCrLf;
            }

            return SearchSql;
        }

        public string xgenHeader()
        {
            string DocsSql = "WITH LibrariesContainingUser (LibraryName) AS" + Constants.vbCrLf;
            DocsSql += " (" + Constants.vbCrLf;
            DocsSql += "    select LibraryName from LibraryUsers L1 where userid = '" + modGlobals.gCurrUserGuidID + "' " + Constants.vbCrLf;
            DocsSql += " )" + Constants.vbCrLf;
            return DocsSql;
        }

        public string genContenCountSql()
        {
            string DocsSql = "Select count(*) " + Constants.vbCrLf;
            DocsSql += "FROM DataSource " + Constants.vbCrLf;
            return DocsSql;
        }

        public string genEmailCountSql()
        {
            string DocsSql = "Select count(*) " + Constants.vbCrLf;
            DocsSql += "FROM [email] " + Constants.vbCrLf;
            return DocsSql;
        }

        public string genUseExistingRecordsOnly(bool bUseExisting, string GuidColName)
        {
            if (bUseExisting == false)
            {
                return "";
            }

            string DocsSql = " and " + GuidColName + " in (SELECT [DocGuid] FROM ActiveSearchGuids where  UserID = '" + modGlobals.gCurrUserGuidID + "')" + Constants.vbCrLf;
            return DocsSql;
        }

        public string genSelectEmailCounts(bool ckWeighted)
        {
            string SearchSql = "";
            if (ckWeighted == true)
            {
                SearchSql = SearchSql + " SELECT count(*) ";
                // SearchSql = SearchSql + "  KEY_TBL.RANK, DS.SentOn " + vbCrLf
                SearchSql = SearchSql + " FROM EMAIL AS DS " + Constants.vbCrLf;
            }
            else
            {
                SearchSql = SearchSql + " SELECT count(*) ";
                SearchSql = SearchSql + " FROM EMAIL " + Constants.vbCrLf;
            }

            SearchSql = SearchSql + " WHERE " + Constants.vbCrLf;
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

                string SS = "delete FROM [EmailAttachmentSearchList] where [UserID] = '" + modGlobals.gCurrUserGuidID + "'";
                bool BB = DBARCH.ExecuteSqlNewConn(SS, false);
                if (!BB)
                {
                    MessageBox.Show("Failed to initialize Attachment Content Search. Content search is not included in the results.");
                }
                else
                {
                    string EmailContentWhereClause = "";
                    string insertSql = "";
                    EmailContentWhereClause = genContainsClause(SearchText, ckBusiness, ckWeighted, true, ckLimitToExisting, ThesaurusList, txtThesaurus, cbThesaurusText, "EMAIL");
                    isAdmin = DBARCH.isAdmin(modGlobals.gCurrUserGuidID);
                    if (!DBARCH.isAdmin(modGlobals.gCurrUserGuidID) & DBARCH.isGlobalSearcher(modGlobals.gCurrUserGuidID) == false)
                    {
                        EmailContentWhereClause = EmailContentWhereClause + Constants.vbCrLf + " And DataSourceOwnerUserID = '" + modGlobals.gCurrUserGuidID + "' ";
                    }
                    else
                    {
                        EmailContentWhereClause = EmailContentWhereClause + Constants.vbCrLf + " And DataSourceOwnerUserID IS NOT null ";
                    }

                    if (ddebug)
                        Console.WriteLine(EmailContentWhereClause);
                    insertSql = EmailContentWhereClause;
                    if (ckBusiness)
                    {
                        SearchEmailAttachments(ref insertSql, true);
                    }
                    // or EmailGuid in (SELECT EmailGuid FROM EmailAttachmentSearchList where userid = 'wmiller')
                    // If LibraryName.Trim.Length > 0 Then
                    // 'DO SOMETHING - EVEN IF IT IS WRONG <WRITTEN BY STUPIDOUS MAXIMUS> 03/10/2008
                    // LibraryName = UTIL.RemoveSingleQuotes(LibraryName)
                    // insertSql = insertSql + genSingleLibrarySelect(EmailContentWhereClause , LibraryName )
                    // ElseIf bIncludeAllLibs = True Then
                    // insertSql = insertSql + vbCrLf + Chr(9) + genAllLibrariesSelect(EmailContentWhereClause )
                    // 'Else
                    // '    If isAdmin Then
                    // '        insertSql = insertSql + vbCrLf + genAttachmentSearchSQLAdmin(EmailContentWhereClause )
                    // '    Else
                    // '        insertSql = insertSql + vbCrLf + genAttachmentSearchSQLUser(EmailContentWhereClause )
                    // '    End If
                    // End If
                    else
                    {
                        SearchEmailAttachments(ref insertSql, false);
                        // AND EmailGuid in (SELECT [SourceGuid] FROM [LibraryItems] where LibraryName = 'Chicago Lib') 
                        // If LibraryName.Trim.Length > 0 Then
                        // 'DO SOMETHING - EVEN IF IT IS WRONG <WRITTEN BY STUPIDOUS MAXIMUS> 03/10/2008
                        // LibraryName = UTIL.RemoveSingleQuotes(LibraryName)
                        // insertSql = insertSql + genSingleLibrarySelect(EmailContentWhereClause , LibraryName )
                        // ElseIf bIncludeAllLibs = True Then
                        // insertSql = insertSql + vbCrLf + Chr(9) + genAllLibrariesSelect(EmailContentWhereClause )
                        // 'Else
                        // '    If isAdmin Then
                        // '        insertSql = insertSql + vbCrLf + genAttachmentSearchSQLAdmin(EmailContentWhereClause )
                        // '    Else
                        // '        insertSql = insertSql + vbCrLf + genAttachmentSearchSQLUser(EmailContentWhereClause )
                        // '    End If
                        // End If

                    }

                    if (!DBARCH.isAdmin(modGlobals.gCurrUserGuidID) & DBARCH.isGlobalSearcher(modGlobals.gCurrUserGuidID) == false)
                    {
                        // ** If not an ADMIN, then limit to USER content only
                        insertSql = insertSql + Constants.vbCrLf + " AND UserID = '" + modGlobals.gCurrUserGuidID + "' ";
                    }

                    if (modGlobals.gClipBoardActive == true)
                        Clipboard.Clear();
                    if (modGlobals.gClipBoardActive == true)
                        Clipboard.SetText(insertSql);
                    BB = DBARCH.ExecuteSqlNewConn(insertSql, false);
                    if (!BB)
                    {
                        LOG.WriteToArchiveLog("clsSQl:IncludeEmailAttachmentsSearch : Failed to insert Attachment Content Search. Content search is not included in the results.");
                        LOG.WriteToArchiveLog("clsSQl:IncludeEmailAttachmentsSearch : The SQL Stmt: " + insertSql);
                        modGlobals.NbrOfErrors += 1;
                        // FrmMDIMain.SB.Text = "Errors: " + NbrOfErrors.ToString
                    }
                }
            }
        }

        public void IncludeEmailAttachmentsSearchWeighted(bool ckIncludeAttachments, bool ckWeighted, bool ckBusiness, string SearchText, bool ckLimitToExisting, string txtThesaurus, string cbThesaurusText, int MinWeight)
        {
            if (ckIncludeAttachments)
            {
                string SS = "delete FROM [EmailAttachmentSearchList] where [UserID] = '" + modGlobals.gCurrUserGuidID + "'";
                bool BB = DBARCH.ExecuteSqlNewConn(SS, false);
                if (!BB)
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

                    LOG.WriteToAttachmentSearchyLog("EmailAttachmentsSearch Weighted: " + insertSql + Constants.vbCrLf + Constants.vbCrLf);
                    Clipboard.Clear();
                    Clipboard.SetText(insertSql);
                    BB = DBARCH.ExecuteSqlNewConn(insertSql, false);
                    if (!BB)
                    {
                        LOG.WriteToArchiveLog("clsSQl:IncludeEmailAttachmentsSearch : Failed to insert Attachment Content Search. Content search is not included in the results.");
                        LOG.WriteToArchiveLog("clsSQl:IncludeEmailAttachmentsSearch : The SQL Stmt: " + insertSql);
                        modGlobals.NbrOfErrors += 1;
                        // FrmMDIMain.SB.Text = "Errors: " + NbrOfErrors.ToString
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
                    string C = Strings.Mid(CorrectedSearchClause, CorrectedSearchClause.Length, 1);
                    if (C.Equals(","))
                    {
                        CorrectedSearchClause = Strings.Mid(CorrectedSearchClause, 1, CorrectedSearchClause.Length - 1);
                        CorrectedSearchClause = CorrectedSearchClause.Trim();
                    }
                }

                // CorrectedSearchClause  = UTIL.RemoveOcrProblemChars(CorrectedSearchClause )

                S = "insert EmailAttachmentSearchList ([EmailGuid], [UserID], Weight, RowID) " + Constants.vbCrLf;
                S = S + "   SELECT [EmailGuid] ,[UserID], KEY_TBL.RANK, RowID " + Constants.vbCrLf;
                S = S + "   FROM EmailAttachment " + Constants.vbCrLf;
                S = S + "      INNER JOIN CONTAINSTABLE(EmailAttachment,attachment, 'ISABOUT (" + CorrectedSearchClause + ")' ) as KEY_TBL" + Constants.vbCrLf;
                S = S + "        ON rowid = KEY_TBL.[KEY]" + Constants.vbCrLf;
                S = S + "   WHERE " + Constants.vbCrLf;
                if (isFreetext == false)
                {
                    ContainsClause = ContainsClause + " and ((UserID is not null) and UserID = '" + modGlobals.gCurrUserGuidID + "' and KEY_TBL.RANK > " + MinWeight.ToString() + " or isPublic = 'Y')";
                    ContainsClause = S + ContainsClause + Constants.vbCrLf;
                    if (modGlobals.gClipBoardActive == true)
                        Clipboard.Clear();
                    if (modGlobals.gClipBoardActive == true)
                        Clipboard.SetText(ContainsClause);
                    return;
                }

                S = ContainsClause;
                I = 0;
                I = Strings.InStr(S, "(");
                StringType.MidStmtStr(ref ContainsClause, I, 1, " ");
                S = S.Trim();
                I = Strings.InStr(S, ",");
                S = Strings.Mid(S, I);
                I = Strings.InStr(S, "/*");
                if (I > 0)
                {
                    S = Strings.Mid(S, 1, I - 1);
                }

                if (isFreetext)
                {
                    S = "FREETEXT ((Attachment, OcrText)" + S;
                }
                else
                {
                    S = ContainsClause;
                }

                ContainsClause = S + S + Constants.vbCrLf;
                if (modGlobals.gClipBoardActive == true)
                    Clipboard.Clear();
                if (modGlobals.gClipBoardActive == true)
                    Clipboard.SetText(ContainsClause);
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
            S = S.Trim();
            var loopTo = K;
            for (I = 1; I <= loopTo; I++)
            {
                reeval:
                ;
                CH = Strings.Mid(S, I, 1);
                switch (CH ?? "")
                {
                    case '"':
                        {
                            Token += CH;
                            I += 1;
                            CH = Strings.Mid(S, I, 1);
                            while (CH != Conversions.ToString('"') & I <= K)
                            {
                                Token += CH;
                                I += 1;
                                CH = Strings.Mid(S, I, 1);
                            }

                            Token += CH;
                            A.Add(Token.Trim());
                            Token = "";
                            break;
                        }

                    case "+":
                        {
                            if (Token.Trim().Length > 0)
                            {
                                A.Add(Token.Trim());
                                Token = "";
                            }

                            A.Add(CH);
                            Token = "";
                            break;
                        }

                    case "|":
                        {
                            if (Token.Trim().Length > 0)
                            {
                                A.Add(Token.Trim());
                                Token = "";
                            }

                            A.Add(" ");
                            Token = "";
                            break;
                        }

                    case "(":
                        {
                            if (Token.Trim().Length > 0)
                            {
                                A.Add(Token.Trim());
                                Token = "";
                            }

                            A.Add(CH);
                            Token = "";
                            break;
                        }

                    case ")":
                        {
                            if (Token.Trim().Length > 0)
                            {
                                A.Add(Token.Trim());
                                Token = "";
                            }

                            A.Add(CH);
                            Token = "";
                            break;
                        }

                    case "-":
                        {
                            if (Token.Trim().Length > 0)
                            {
                                A.Add(Token.Trim());
                                Token = "";
                            }

                            A.Add(CH);
                            Token = "";
                            break;
                        }

                    case "~":
                        {
                            if (Token.Trim().Length > 0)
                            {
                                A.Add(Token.Trim());
                                Token = "";
                            }

                            A.Add(CH);
                            Token = "";
                            break;
                        }

                    case "^":
                        {
                            if (Token.Trim().Length > 0)
                            {
                                A.Add(Token.Trim());
                                Token = "";
                            }

                            A.Add(CH);
                            Token = "";
                            break;
                        }

                    case " ":
                        {
                            if (Token.Trim().Length > 0)
                            {
                                A.Add(Token.Trim());
                                Token = "";
                            }

                            I += 1;
                            CH = Strings.Mid(S, I, 1);
                            while (CH == " " & I <= K)
                            {
                                Token += CH;
                                I += 1;
                                CH = Strings.Mid(S, I, 1);
                            }

                            goto reeval;
                            break;
                        }

                    default:
                        {
                            Token += CH;
                            break;
                        }
                }
            }

            if (Token.Trim().Length > 0)
            {
                A.Add(Token.Trim());
            }

            string T1 = "";
            string P1 = "";
            var loopTo1 = A.Count - 1;
            for (I = 0; I <= loopTo1; I++)
            {
                if (ddebug)
                    Console.WriteLine(A[I]);
                T1 = Conversions.ToString(A[I]);
                if (P1.Equals("-") & T1.Equals("+"))
                {
                    A[I - 1] = Operators.AndObject("+", Operators.ConditionalCompareObjectEqual(A[I], "-", false));
                }

                if (P1.Equals("NOT") & T1.Equals("AND"))
                {
                    A[I - 1] = Operators.AndObject("AND", Operators.ConditionalCompareObjectEqual(A[I], "NOT", false));
                }

                if (P1.Equals("-") & T1.Equals("AND"))
                {
                    A[I - 1] = Operators.AndObject("AND", Operators.ConditionalCompareObjectEqual(A[I], "NOT", false));
                }

                if (P1.Equals("NOT") & T1.Equals("+"))
                {
                    A[I - 1] = Operators.AndObject("AND", Operators.ConditionalCompareObjectEqual(A[I], "NOT", false));
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
            var loopTo = A.Count - 1;
            for (I = 0; I <= loopTo; I++)
            {
                if (ddebug)
                    Console.WriteLine(A[I]);
                Token = Conversions.ToString(A[I]);
                switch (Strings.UCase(Token) ?? "")
                {
                    case "OR":
                        {
                            CurrSymbol = "|";
                            Token = "OR";
                            CurrSymbolIsKeyWord = true;
                            break;
                        }

                    case "+":
                        {
                            CurrSymbol = "+";
                            Token = "AND";
                            CurrSymbolIsKeyWord = true;
                            break;
                        }

                    case "AND":
                        {
                            CurrSymbol = "+";
                            Token = "AND";
                            CurrSymbolIsKeyWord = true;
                            break;
                        }

                    case "NEAR":
                        {
                            CurrSymbol = "+";
                            Token = "NEAR";
                            CurrSymbolIsKeyWord = true;
                            break;
                        }

                    case "(":
                        {
                            CurrSymbol = "";
                            Token = "(";
                            CurrSymbolIsKeyWord = true;
                            break;
                        }

                    case ")":
                        {
                            CurrSymbol = "";
                            Token = ")";
                            CurrSymbolIsKeyWord = true;
                            break;
                        }

                    case "-":
                        {
                            CurrSymbol = "-";
                            Token = "NOT";
                            CurrSymbolIsKeyWord = true;
                            break;
                        }

                    case "NOT":
                        {
                            CurrSymbol = "-";
                            Token = "NOT";
                            CurrSymbolIsKeyWord = true;
                            break;
                        }

                    case "~":
                        {
                            CurrSymbol = "~";
                            Token = "~";
                            CurrSymbolIsKeyWord = true;
                            break;
                        }

                    case "^":
                        {
                            CurrSymbol = "^";
                            Token = "^";
                            CurrSymbolIsKeyWord = true;
                            break;
                        }

                    case var @case when @case == 'þ':
                        {
                            CurrSymbol = Conversions.ToString('þ');
                            Token = "";
                            OrMayBeNeeded = true;
                            break;
                        }

                    default:
                        {
                            CurrSymbol = "";
                            CurrSymbol = "";
                            Token = Conversions.ToString(A[I]);
                            CurrSymbolIsKeyWord = false;
                            break;
                        }
                }

                if (PrevSymbol == ")" & CurrSymbol == "^")
                {
                    // ** Skip this line
                    S = S + " OR ";
                    goto ProcessNextToken;
                }

                if (PrevSymbol == ")" & CurrSymbol == "~")
                {
                    // ** Skip this line
                    S = S + " OR ";
                    goto ProcessNextToken;
                }

                if (OrMayBeNeeded & CurrSymbolIsKeyWord == false)
                {
                    S = S + " oR ";
                }

                if (OrMayBeNeeded & CurrSymbolIsKeyWord == true)
                {
                    OrMayBeNeeded = false;
                }

                if (PrevSymbol == Conversions.ToString('þ') & CurrSymbol == Conversions.ToString('þ'))
                {
                    // ** Skip this line
                    goto ProcessNextToken;
                }

                if (PrevSymbol == Conversions.ToString('þ') & CurrSymbolIsKeyWord)
                {
                    S = S.Trim() + " " + Token;
                    goto ProcessNextToken;
                }

                if (PrevSymbol == Conversions.ToString('þ') & CurrSymbolIsKeyWord == false)
                {
                    S = S + " Or " + Token;
                }

                if (PrevSymbol == Conversions.ToString('þ') & CurrSymbolIsKeyWord == false)
                {
                    S = S + " Or " + Token;
                }

                if (PrevSymbol.Equals("~") & CurrSymbolIsKeyWord == false)
                {
                    S = S + Token;
                    goto ProcessNextToken;
                }

                if (PrevSymbol.Equals("^") & CurrSymbolIsKeyWord == false)
                {
                    S = S + Token;
                    goto ProcessNextToken;
                }

                if (CurrSymbolIsKeyWord == true & CurrSymbol == Conversions.ToString('þ'))
                {
                    // ** Skip this line
                    goto ProcessNextToken;
                }

                if (PrevSymbolIsKeyWord == false & CurrSymbolIsKeyWord == false & I > 0)
                {
                    // ** do nothing 
                    S = S + " or " + Token;
                    goto ProcessNextToken;
                }

                if (PrevSymbolIsKeyWord == false & CurrSymbolIsKeyWord == false & I == 0)
                {
                    // ** do nothing 
                    S = Token + " ";
                    goto ProcessNextToken;
                }

                if (PrevSymbolIsKeyWord == true & CurrSymbolIsKeyWord == false)
                {
                    S = S.Trim() + " " + Token;
                }

                if (PrevSymbolIsKeyWord == false & CurrSymbolIsKeyWord == true)
                {
                    S = S.Trim() + " " + Token;
                }

                if (PrevSymbolIsKeyWord == true & CurrSymbolIsKeyWord == true)
                {
                    if (PrevSymbol == "NOT" & CurrSymbol == "OR")
                    {
                        S = S + "";
                    }
                    else if (PrevSymbol == "OR" & CurrSymbol == "NOT")
                    {
                        S = S + "";
                    }
                    else
                    {
                        S = S.Trim() + " " + Token;
                    }
                }

                ProcessNextToken:
                ;
                PrevToken = Token;
                PrevSymbol = CurrSymbol;
                PrevSymbolIsKeyWord = CurrSymbolIsKeyWord;
                if (ddebug)
                    Console.WriteLine(S);
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
            string CH = "";
            int iCnt = 0;
            if (Strings.InStr(1, S, Conversions.ToString('"')) == 0)
            {
                return true;
            }

            var loopTo = S.Trim().Length;
            for (I = 1; I <= loopTo; I++)
            {
                CH = Strings.Mid(S, I, 1);
                if (CH.Equals(Conversions.ToString('"')))
                {
                    iCnt += 1;
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
            // S = S.Trim        
            bool B = false;
            try
            {
                int I = 0;
                string S1 = "";
                string S2 = "";
                string CH = "";
                var aList = new ArrayList();
                int K = K;
                ParseSearchString(ref aList, S);
                RebuildString(aList, ref S);
                reeval:
                ;
                K = S.Trim().Length;
                string NewStr = "";
                var loopTo = K;
                for (I = 1; I <= loopTo; I++)
                {
                    string CurrChar = Strings.Mid(S, I, 1);
                    EvalCurrChar:
                    ;
                    string PrevChar = "";
                    if (I > 1)
                    {
                        PrevChar = Strings.Mid(S, I - 1, 1);
                    }
                    else
                    {
                    }

                    if (CurrChar.Equals(Conversions.ToString('"')))
                    {
                        NewStr += CurrChar;
                        I += 1;
                        CurrChar = Strings.Mid(S, I, 1);
                        while (CurrChar != Conversions.ToString('"') & I <= S.Trim().Length)
                        {
                            NewStr += CurrChar;
                            I += 1;
                            CurrChar = Strings.Mid(S, I, 1);
                        }

                        NewStr += CurrChar;
                        goto GetNextChar;
                    }

                    if (CurrChar.Equals(" "))
                    {
                        NewStr += CurrChar;
                        I += 1;
                        CurrChar = Strings.Mid(S, I, 1);
                        while (CurrChar.Equals(" ") & I <= S.Trim().Length)
                        {
                            NewStr += Conversions.ToString('þ');
                            I += 1;
                            CurrChar = Strings.Mid(S, I, 1);
                        }

                        if (CurrChar.Equals(")"))
                        {
                            if (ddebug)
                                Console.WriteLine("Here xxx1");
                        }

                        goto EvalCurrChar;
                    }

                    if (CurrChar.Equals("-") | CurrChar.Equals("+") | CurrChar.Equals("|") | CurrChar.Equals("^") | CurrChar.Equals("~") | CurrChar.Equals("("))
                    {
                        NewStr += CurrChar;
                        I += 1;
                        CurrChar = Strings.Mid(S, I, 1);
                        while (CurrChar.Equals(" ") & I <= S.Trim().Length)
                        {
                            NewStr += Conversions.ToString('þ');
                            I += 1;
                            CurrChar = Strings.Mid(S, I, 1);
                        }

                        goto EvalCurrChar;
                    }

                    if (CurrChar.Equals("+") & PrevChar.Equals("-"))
                    {
                        StringType.MidStmtStr(ref S, I, 1, "-");
                        StringType.MidStmtStr(ref S, I - 1, 1, "+");
                    }

                    if (CurrChar.Equals("+") & PrevChar.Equals("+"))
                    {
                        goto GetNextChar;
                    }

                    if (CurrChar.Equals("-") & PrevChar.Equals("-"))
                    {
                        goto GetNextChar;
                    }

                    if (CurrChar.Equals("^") & PrevChar.Equals("^"))
                    {
                        goto GetNextChar;
                    }

                    if (CurrChar.Equals("~") & PrevChar.Equals("~"))
                    {
                        goto GetNextChar;
                    }

                    if (CurrChar.Equals(")") & (PrevChar.Equals(" ") | PrevChar.Equals(Conversions.ToString('þ'))))
                    {
                        string C = "";
                        int II = NewStr.Length;
                        C = Strings.Mid(S, II, 1);
                        while ((C.Equals(" ") | C.Equals(Conversions.ToString('þ'))) & II > 0)
                        {
                            var midTmp = Conversions.ToString('þ');
                            StringType.MidStmtStr(ref NewStr, II, 1, midTmp);
                            II = II - 1;
                            C = Strings.Mid(NewStr, II, 1);
                        }
                        // GoTo EvalCurrChar
                        C = "";
                    }

                    NewStr += CurrChar;
                    GetNextChar:
                    ;
                }

                NewStr = DMA.RemoveChar(NewStr, Conversions.ToString('þ'));
                S = NewStr;
            }
            catch (Exception ex)
            {
            }

            return default;
        }

        public void ValidateNotClauses(ref string SqlText)
        {
            if (SqlText.Trim().Length == 0)
            {
                return;
            }

            bool DoThis = false;
            if (!DoThis)
            {
                return;
            }

            int I = 0;
            string prevWord = "";
            string currWord = "";
            string CH = "";
            var aList = new ArrayList();
            var loopTo = SqlText.Length;
            for (I = 1; I <= loopTo; I++)
            {
                CH = Strings.Mid(SqlText, I, 1);
                if (CH == Conversions.ToString('"'))
                {
                    I = I + 1;
                    CH = Strings.Mid(SqlText, I, 1);
                    while (CH != Conversions.ToString('"') & I <= SqlText.Length)
                    {
                        I = I + 1;
                        CH = Strings.Mid(SqlText, I, 1);
                    }
                }
                else if (CH == " ")
                {
                    var midTmp = Conversions.ToString('þ');
                    StringType.MidStmtStr(ref SqlText, I, 1, midTmp);
                }
            }

            var A = SqlText.Split('þ');
            currWord = "";
            prevWord = "";
            var loopTo1 = Information.UBound(A);
            for (I = 0; I <= loopTo1; I++)
            {
                currWord = A[I];
                if (Strings.UCase(currWord).Equals("NOT") & Strings.UCase(prevWord).Equals("AND"))
                {
                    aList.Add(currWord);
                }
                else if (Strings.UCase(currWord).Equals("OR") & Strings.UCase(prevWord).Equals("OR"))
                {
                }
                // ** DO nothing - user supplied multiple blanks
                else if (Strings.UCase(currWord).Equals("AND") & Strings.UCase(prevWord).Equals("OR"))
                {
                }
                // ** DO nothing - user supplied multiple blanks
                else if (Strings.UCase(currWord).Equals("OR") & Strings.UCase(prevWord).Equals("AND"))
                {
                    aList.Add(currWord);
                }
                else if (Strings.UCase(currWord).Equals("NOT") & Strings.UCase(prevWord).Equals("IS"))
                {
                    aList.Add(currWord);
                }
                else if (Strings.UCase(currWord).Equals("NOT") & !Strings.UCase(prevWord).Equals("AND"))
                {
                    currWord = "And Not";
                    aList.Add(currWord);
                }
                else if (Strings.UCase(currWord).Equals("FORMSOF") & !Strings.UCase(prevWord).Equals("AND"))
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
            var loopTo2 = aList.Count - 1;
            for (I = 0; I <= loopTo2; I++)
            {
                try
                {
                    // If aList(I) = Nothing Then
                    // Debug.Print("nothing")
                    // Dim X# = 1
                    // Else
                    string tWord = Conversions.ToString(aList[I]);
                    string EOL = "";
                    switch (Strings.LCase(tWord) ?? "")
                    {
                        case "select":
                            {
                                EOL = Constants.vbCrLf;
                                break;
                            }

                        case "from":
                            {
                                EOL = Constants.vbCrLf;
                                break;
                            }

                        case "where":
                            {
                                EOL = Constants.vbCrLf;
                                break;
                            }

                        case "order":
                            {
                                EOL = Constants.vbCrLf;
                                break;
                            }

                        case "and":
                            {
                                EOL = Constants.vbCrLf;
                                break;
                            }

                        case "or":
                            {
                                EOL = Constants.vbCrLf;
                                break;
                            }
                    }

                    if (Strings.InStr(tWord, ",") > 0)
                    {
                        EOL = Constants.vbCrLf + Constants.vbTab;
                    }

                    if (Strings.InStr(tWord, "not", CompareMethod.Text) > 0)
                    {
                        double x = 1d;
                    }

                    if (I == 0)
                    {
                        SqlText = Conversions.ToString(SqlText + Operators.AddObject(EOL, aList[0].Trim));
                    }
                    else
                    {
                        SqlText = Conversions.ToString(SqlText + Operators.AddObject(" " + EOL, aList[I].Trim));
                    }
                }
                // End If
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
            S = S + " delete from TempUserLibItems where UserID = '" + modGlobals.gCurrUserGuidID + "'";
            try
            {
                B = DBARCH.ExecuteSqlNewConn(90301, S);
                if (B)
                {
                    S = "";
                    S = S + " INSERT INTO TempUserLibItems (SourceGuid, Userid)" + Constants.vbCrLf;
                    S = S + " select distinct SourceGuid, '" + modGlobals.gCurrUserGuidID + "' from LibraryItems" + Constants.vbCrLf;
                    S = S + " where LibraryName in (" + Constants.vbCrLf;
                    S = S + " select distinct LibraryName from GroupLibraryAccess " + Constants.vbCrLf;
                    S = S + " where GroupName in " + Constants.vbCrLf;
                    S = S + " (select distinct GroupName from GroupUsers where UserID = '" + modGlobals.gCurrUserGuidID + "')" + Constants.vbCrLf;
                    S = S + " union " + Constants.vbCrLf;
                    S = S + " select distinct LibraryName from LibraryUsers where UserID = '" + modGlobals.gCurrUserGuidID + "'";
                    S = S + " )" + Constants.vbCrLf;
                    B = DBARCH.ExecuteSqlNewConn(90302, S);
                    if (modGlobals.gClipBoardActive == true)
                        Clipboard.Clear();
                    if (modGlobals.gClipBoardActive == true)
                        Clipboard.SetText(S);
                }
            }
            catch (Exception ex)
            {
                B = false;
                LOG.WriteToArchiveLog("ERROR genIsInLibrariesSql: " + ex.Message + Constants.vbCrLf + S);
            }

            return B;
        }

        public string genAllLibrariesSql()
        {
            string S = "";
            S = S + " select distinct SourceGuid, '" + modGlobals.gCurrUserGuidID + "' from LibraryItems" + Constants.vbCrLf;
            S = S + "  where LibraryName in (" + Constants.vbCrLf;
            S = S + "  select distinct LibraryName from GroupLibraryAccess " + Constants.vbCrLf;
            S = S + "  where GroupName in ";
            S = S + "  (select distinct GroupName from GroupUsers where UserID = 'wmiller')" + Constants.vbCrLf;
            S = S + "  union " + Constants.vbCrLf;
            S = S + "  select distinct LibraryName from LibraryUsers where UserID = 'wmiller' )" + Constants.vbCrLf;
            return S;
        }

        public void AddPaging(int StartPageNo, int EndPageNo, ref string SqlQuery, bool bIncludeLibraryFilesInSearch)
        {
            bool WeightedSearch = false;
            var L = new List<string>();
            var A = SqlQuery.Split(Conversions.ToChar(Constants.vbCrLf));
            string S = SqlQuery;
            bool xContentAdded = false;
            bool ContainsUnion = false;
            bool ContainsLimitToLibrary = false;

            // gClipBoardActive = True
            if (modGlobals.gClipBoardActive == true)
                Clipboard.Clear();
            if (modGlobals.gClipBoardActive == true)
                Clipboard.SetText(SqlQuery);
            if (modGlobals.gClipBoardActive == true)
                MessageBox.Show("Step3: ADD Pagination STARTING Query in clipboard.");
            int iSelect = 0;
            for (int i = 0, loopTo = Information.UBound(A); i <= loopTo; i++)
            {
                S = A[i].Trim();
                if (modGlobals.gClipBoardActive == true)
                    Console.WriteLine(S);
                if (Strings.InStr(S, "SELECT   distinct  LibraryItems.SourceGuid") > 0)
                {
                    Console.WriteLine("XXX1 Here");
                }

                if (Strings.InStr(S, "LibraryUsers") > 0)
                {
                    Console.WriteLine("XXX1 Here");
                }

                if (Strings.InStr(S, "FROM TempUserLibItems", CompareMethod.Text) > 0)
                {
                    Console.WriteLine("Here 22,22,1");
                }

                if (Strings.InStr(S, "UNION", CompareMethod.Text) > 0)
                {
                    ContainsUnion = true;
                }

                if (Strings.InStr(S, "/*") > 0 & Strings.InStr(S, "*/") > 0)
                {
                    L.Add(Conversions.ToString('\t') + S + Constants.vbCrLf);
                    goto NEXTLINE;
                }

                if (Strings.InStr(S, "EmailAttachmentSearchList", CompareMethod.Text) > 0)
                {
                    // Console.WriteLine("Here xx0011")
                    L.Add(Conversions.ToString('\t') + S + Constants.vbCrLf);
                    goto NEXTLINE;
                }
                // SELECT TOP 1000  KEY_TBL.RANK
                if (Strings.InStr(S, "SELECT", CompareMethod.Text) > 0 & Strings.InStr(S, "KEY_TBL.RANK", CompareMethod.Text) > 0)
                {
                    WeightedSearch = true;
                    // Else
                    // WeightedSearch = False
                }

                if (Strings.InStr(S, "ORDER BY KEY_TBL.RANK DESC", CompareMethod.Text) > 0)
                {
                    WeightedSearch = true;
                    S = Conversions.ToString('\t') + "/* " + S + " */" + Constants.vbCrLf + Conversions.ToString('\t') + "/* above commented out by Pagination Module */";
                }

                if (Strings.InStr(S, "/*KEPP*/", CompareMethod.Text) > 0)
                {
                    ContainsLimitToLibrary = true;
                }
                else
                {
                    ContainsLimitToLibrary = false;
                }

                if (ContainsLimitToLibrary == true)
                {
                    S = Conversions.ToString('\t') + S;
                    L.Add(Conversions.ToString('\t') + S + Constants.vbCrLf);
                }
                else if (ContainsUnion == false & Strings.InStr(S, "select", CompareMethod.Text) > 0 & Strings.InStr(S, "*", CompareMethod.Text) == 0 & Strings.InStr(S, "FROM [LibraryItems]", CompareMethod.Text) == 0 & Strings.InStr(S, "FROM TempUserLibItems", CompareMethod.Text) == 0)



                {
                    if (S.Length >= "select".Length)
                    {
                        if (Strings.InStr(S, "or EmailGuid in (SELECT   distinct  LibraryItems.SourceGuid", CompareMethod.Text) > 0)
                        {
                            L.Add(S + Constants.vbCrLf);
                            Console.WriteLine("XX2 Do nothing here.");
                        }
                        else if (Strings.InStr(S, "or SourceGuid in (SELECT   distinct  LibraryItems.SourceGuid", CompareMethod.Text) > 0)
                        {
                            L.Add(S + Constants.vbCrLf);
                            Console.WriteLine("XX3 Do nothing here.");
                        }
                        else if (Strings.Mid(S, 1, 6).ToUpper().Equals("SELECT"))
                        {
                            L.Add("WITH xContent AS" + Constants.vbCrLf);
                            L.Add("(" + Constants.vbCrLf);
                            L.Add(S + Constants.vbCrLf);
                            xContentAdded = false;
                        }
                    }
                }
                else if (Strings.InStr(S, "FROM datasource", CompareMethod.Text) > 0 | Strings.InStr(S, "FROM DataSource", CompareMethod.Text) > 0)
                {
                    if (WeightedSearch == true)
                    {
                        L.Add(Conversions.ToString('\t') + ",ROW_NUMBER() OVER (ORDER BY Rank DESC) AS ROWID" + Constants.vbCrLf);
                    }
                    else
                    {
                        L.Add(Conversions.ToString('\t') + ",ROW_NUMBER() OVER (ORDER BY SourceName ASC) AS ROWID" + Constants.vbCrLf);
                    }

                    L.Add(S + Constants.vbCrLf);
                }
                else if (Strings.InStr(S, "FROM EMAIL", CompareMethod.Text) > 0)
                {
                    if (WeightedSearch == true)
                    {
                        L.Add(Conversions.ToString('\t') + ",ROW_NUMBER() OVER (ORDER BY Rank DESC) AS ROWID" + Constants.vbCrLf);
                    }
                    else
                    {
                        L.Add(Conversions.ToString('\t') + ",ROW_NUMBER() OVER (ORDER BY SentOn ASC) AS ROWID" + Constants.vbCrLf);
                    }

                    L.Add(S + Constants.vbCrLf);
                }
                else if (ContainsUnion == false & Strings.InStr(Conversions.ToString('\t') + S, "order by", CompareMethod.Text) > 0)
                {
                    // If WeightedSearch = False Then
                    S = "--" + S;
                    // End If

                    L.Add(S + Constants.vbCrLf);
                    L.Add(")" + Constants.vbCrLf);
                    L.Add("Select * " + Constants.vbCrLf);
                    L.Add("FROM xContent" + Constants.vbCrLf);
                    L.Add("WHERE ROWID BETWEEN " + StartPageNo.ToString() + " AND " + EndPageNo.ToString() + Constants.vbCrLf);
                    WeightedSearch = false;
                    xContentAdded = true;
                }
                else if (ContainsUnion == true & Strings.InStr(Conversions.ToString('\t') + S, "order by [SourceName]", CompareMethod.Text) > 0)
                {
                    // If WeightedSearch = False Then
                    S = "--" + S;
                }
                else
                {
                    L.Add(Conversions.ToString('\t') + S + Constants.vbCrLf);
                }

                NEXTLINE:
                ;
            }

            if (xContentAdded == false)
            {
                L.Add(")" + Constants.vbCrLf);
                L.Add("Select * " + Constants.vbCrLf);
                L.Add("FROM xContent" + Constants.vbCrLf);
                L.Add("WHERE ROWID BETWEEN " + StartPageNo.ToString() + " AND " + EndPageNo.ToString() + Constants.vbCrLf);
            }
            // ** Rebuild the statement
            int II = 0;
            SqlQuery = "";
            foreach (var currentS in L)
            {
                S = currentS;
                II += 1;
                if (modGlobals.gClipBoardActive)
                    Console.WriteLine(II.ToString() + ": " + S);
                if (Strings.InStr(S, Constants.vbCrLf) == 0)
                {
                    S = S + Constants.vbCrLf;
                }

                SqlQuery += S;
            }

            if (modGlobals.gClipBoardActive == true)
                Clipboard.Clear();
            if (modGlobals.gClipBoardActive == true)
                Clipboard.SetText(SqlQuery);
            if (modGlobals.gClipBoardActive == true)
                Console.WriteLine("HERE 222");
            if (modGlobals.gClipBoardActive == true)
                MessageBox.Show("Step4: ADD Pagination in clipboard.");
        }

        public string genAttachmentSearchSQLAdmin(string EmailContainsClause)
        {
            string S = "";
            S += " select EmailGuid from EmailAttachment where " + EmailContainsClause;
            return S;
        }

        public string genAttachmentSearchSQLUser(string EmailContainsClause)
        {
            string S = "";
            S += " select EmailGuid from EmailAttachment where " + EmailContainsClause + Constants.vbCrLf + " and UserID = '" + modGlobals.gCurrUserGuidID + "'";
            return S;
        }

        public string genAllLibrariesSelect(string EmailContainsClause)
        {
            string AllLibSql = "";
            AllLibSql += " SELECT distinct SourceGuid FROM [LibraryItems] where LibraryName in " + Constants.vbCrLf;
            AllLibSql += " (" + Constants.vbCrLf;
            AllLibSql += " select distinct LibraryName from LibraryUsers where UserID = '" + modGlobals.gCurrUserGuidID + "'" + Constants.vbCrLf;
            AllLibSql += " )" + Constants.vbCrLf;
            string S = "";
            S = S + " and EmailGuid in (" + AllLibSql + ")";
            return S;
        }

        public string genSingleLibrarySelect(string EmailContainsClause, string LibraryName)
        {
            string S = "";

            // S = S + " and EmailGuid in (SELECT [SourceGuid] FROM [LibraryItems] where LibraryName = '" + LibraryName  + "')"
            // ** DO NOT PUT vbcrlf at the end of the below lines. That will cause problems in inserting PAGING.
            bool gSearcher = false;
            if (DBARCH.isAdmin(modGlobals.gCurrUserGuidID) == true | DBARCH.isGlobalSearcher(modGlobals.gCurrUserGuidID) == true)
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
            S = "delete from EmailAttachmentSearchList where UserID = '" + modGlobals.gCurrUserGuidID + "' ";
            bool B = DBARCH.ExecuteSqlNewConn(90303, S);
            if (B == false)
            {
                LOG.WriteToArchiveLog("Notice: Failed to delete user records from EmailAttachmentSearchList.");
            }

            try
            {
                // INSERT INTO EmailAttachmentSearchList
                // (UserID, EmailGuid, RowID)
                // SELECT     'wmiller' AS Expr1, EmailGuid, RowID
                // FROM         EmailAttachment
                // WHERE     CONTAINS(*, ' alaska')

                tSql = "insert EmailAttachmentSearchList ([UserID],[EmailGuid], RowID) " + Constants.vbCrLf;
                tSql = tSql + " select '" + modGlobals.gCurrUserGuidID + "',[EmailGuid], RowID  " + Constants.vbCrLf;
                tSql = tSql + "FROM EmailAttachment " + Constants.vbCrLf;
                tSql = tSql + "where " + Constants.vbCrLf;
                S = ContainsClause;
                I = 0;
                I = Strings.InStr(S, "(");
                StringType.MidStmtStr(ref ContainsClause, I, 1, " ");
                S = S.Trim();
                I = Strings.InStr(S, ",");
                S = Strings.Mid(S, I);
                I = Strings.InStr(S, "/*");
                if (I > 0)
                {
                    S = Strings.Mid(S, 1, I - 1);
                }

                if (isFreetext)
                {
                    S = "FREETEXT ((Body, SUBJECT, KeyWords, Description)" + S;
                }
                else
                {
                    S = "contains(*" + S;
                }

                ContainsClause = tSql + S + Constants.vbCrLf;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }

            // Clipboard.Clear()
            // Clipboard.SetText(ContainsClause )

        }
    }
}