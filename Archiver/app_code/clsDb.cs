using System;
using System.Collections;
using System.Data;
using global::System.Data.SqlClient;
using System.Diagnostics;
using System.Windows.Forms;
using Microsoft.VisualBasic;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{

    /// <summary>
/// This is the database class for the thesaurus developed and used by ECM Library developers. It is
/// copyrighted and confidential as this is critical to our products uniqueness. I promise you, if
/// you are reading this code without our WRITTEN permission, I will find you , I will hunt you down,
/// and I will do my very best to completely and utterly DESTROY YOU - count on it.
/// </summary>
/// <remarks></remarks>
    public class clsDb
    {
        private clsDma DMA = new clsDma();
        private clsLogging LOG = new clsLogging();
        private clsUtility UTIL = new clsUtility();
        private bool ddebug = false;
        private SqlConnection TrexConnection = new SqlConnection();
        private string ThesaurusConnectionString = "";
        private string EcmLibConnectionString = "";

        public void setEcmLibConnStr()
        {
            bool bUseConfig = true;
            string S = "";
            S = Conversions.ToString(My.MySettingsProperty.Settings["UserDefaultConnString"]);
            if (S.Equals("?"))
            {
                S = System.Configuration.ConfigurationManager.AppSettings["ECMREPO"];
            }
            // setConnectionStringTimeout(S)
            // S = ENC.AES256DecryptString(S)
            EcmLibConnectionString = S;
        }

        public bool ExecuteSqlNewConn(string sql, string NewConnectionStr)
        {
            try
            {
                bool rc = false;
                var CN = new SqlConnection(NewConnectionStr);
                CN.Open();
                var dbCmd = CN.CreateCommand();
                using (CN)
                {
                    dbCmd.Connection = CN;
                    try
                    {
                        dbCmd.CommandText = sql;
                        dbCmd.ExecuteNonQuery();
                        rc = true;
                    }
                    catch (Exception ex)
                    {
                        rc = false;
                        if (Strings.InStr(ex.Message, "The DELETE statement conflicted with the REFERENCE", CompareMethod.Text) > 0)
                        {
                            MessageBox.Show("It appears this user has DATA within the repository associated to them and cannot be deleted." + Constants.vbCrLf + Constants.vbCrLf + ex.Message);
                        }
                        else if (Strings.InStr(ex.Message, "duplicate key row", CompareMethod.Text) > 0)
                        {
                            // log.WriteToArchiveLog("clsDatabaseARCH : ExecuteSqlNewConn : 1464 : " + ex.Message)
                            // log.WriteToArchiveLog("clsDatabaseARCH : ExecuteSqlNewConn : 1408 : " + ex.Message)
                            // log.WriteToArchiveLog("clsDatabaseARCH : ExecuteSqlNewConn : 1411 : " + ex.Message)
                            return true;
                        }
                        // messagebox.show("Execute SQL: " + ex.Message + vbCrLf + "Please review the trace log." + vbCrLf + sql)
                        else if (ddebug)
                            Clipboard.SetText(sql);
                        // xTrace(0, "ExecuteSqlNoTx: ", "-----------------------")
                        // xTrace(1, "ExecuteSqlNoTx: ", ex.Message.ToString)
                        if (ddebug)
                            Debug.Print(ex.Message.ToString());
                        // xTrace(2, "ExecuteSqlNoTx: ", ex.StackTrace.ToString)
                        // xTrace(3, "ExecuteSqlNoTx: ", Mid(sql, 1, 2000))
                    }
                }

                if (CN.State == ConnectionState.Open)
                {
                    CN.Close();
                }

                CN = null;
                dbCmd = null;
                return rc;
            }
            catch (Exception ex)
            {
                // xTrace(9914, "ExecuteSqlNewConn", "ExecuteSqlNewConn Failed", ex)
                MessageBox.Show(ex.Message);
                return false;
            }
        }

        public SqlDataReader SqlQry(string sql)
        {
            // 'Session("ActiveError") = False
            bool ddebug = true;
            string queryString = sql;
            bool rc = false;
            SqlDataReader rsDataQry = null;
            CkConn();
            var command = new SqlCommand(sql, TrexConnection);
            try
            {
                rsDataQry = command.ExecuteReader();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("clsDB : SqlQry : 1319db : " + ex.Message.ToString() + Constants.vbCrLf + sql);
            }

            command.Dispose();
            command = null;
            return rsDataQry;
        }

        public string getDefaultThesaurus()
        {
            // Dim EcmLibConnectionString As String = ""
            setEcmLibConnStr();
            string DefaultThesaurus = "";
            string s = "";
            var EcmConn = new SqlConnection(EcmLibConnectionString);
            if (EcmConn.State == ConnectionState.Closed)
            {
                EcmConn.Open();
            }

            try
            {
                string tQuery = "";
                s = "Select [SysParmVal] FROM [SystemParms] where [SysParm] = 'Default Thesaurus' ";
                using (TrexConnection)
                {
                    var command = new SqlCommand(s, EcmConn);
                    SqlDataReader RSData = null;
                    RSData = SqlQry(s);
                    RSData.Read();
                    DefaultThesaurus = RSData.GetValue(0).ToString();
                    RSData.Close();
                    RSData = null;
                    command.Connection.Close();
                    command = null;
                }
            }
            catch (Exception ex)
            {
                // xTrace(12335, "clsDataBase:iGetRowCount", ex.Message)
                // messagebox.show("Error 3932.11: " + ex.Message)
                if (ddebug)
                    Debug.Print("Error 3932.11: CountOfThesauri " + ex.Message);
                Console.WriteLine("Error 3932.11: getDefaultThesaurus" + ex.Message);
                DefaultThesaurus = "";
                MessageBox.Show("Check the sql error log");
                LOG.WriteToArchiveLog("ERROR clsDB : getDefaultThesaurus : 100a : " + EcmLibConnectionString);
                LOG.WriteToArchiveLog("clsDB : getDefaultThesaurus : 100b : " + ex.Message + Constants.vbCrLf + s);
                DefaultThesaurus = "Roget";
            }

            if (!(EcmConn.State == ConnectionState.Closed))
            {
                EcmConn.Close();
            }

            EcmConn = null;
            GC.Collect();
            return DefaultThesaurus;
        }

        public bool ThesaurusExist()
        {
            int I = getCountOfThesauri();
            if (I <= 0)
            {
                string CS = getThesaurusConnectionString();
                string InsertSql = "INSERT INTO [dbo].[Thesaurus] ([ThesaurusName],[ThesaurusID]) VALUES ('Roget','D7A21DA7-0818-4B75-8BBA-D0339D3E1D54')";
                bool B = ExecuteSqlNewConn(InsertSql, CS);
                if (!B)
                {
                    LOG.WriteToArchiveLog("ERROR :ThesaurusExist - Failed to add default Thesaurus.");
                }
            }

            return default;
        }

        public int getCountOfThesauri()
        {
            int cnt = -1;
            string s = "";
            try
            {
                string tQuery = "";
                s = "Select count(*) FROM [Thesaurus] ";
                using (TrexConnection)
                {
                    SqlDataReader RSData = null;
                    string CS = ThesaurusConnectionString;
                    var CONN = new SqlConnection(CS);
                    CONN.Open();
                    var command = new SqlCommand(s, CONN);
                    RSData = command.ExecuteReader();
                    RSData.Read();
                    cnt = RSData.GetInt32(0);
                    RSData.Close();
                    RSData = null;
                    command.Connection.Close();
                    command = null;
                }
            }
            catch (Exception ex)
            {
                // xTrace(12335, "clsDataBase:iGetRowCount", ex.Message)
                // messagebox.show("Error 3932.11: " + ex.Message)
                if (ddebug)
                    Debug.Print("Error 3932.11: CountOfThesauri " + ex.Message);
                Console.WriteLine("Error 3932.11: CountOfThesauri" + ex.Message);
                cnt = 0;
                LOG.WriteToArchiveLog("clsDB : CountOfThesauri : 100 : " + ex.Message);
            }

            return cnt;
        }

        public int iGetRowCount(string TBL, string WhereClause)
        {
            int cnt = -1;
            string s = "";
            try
            {
                string tQuery = "";
                s = "Select count(*) as CNT from " + TBL + " " + WhereClause;
                using (TrexConnection)
                {
                    var command = new SqlCommand(s, TrexConnection);
                    SqlDataReader RSData = null;
                    RSData = command.ExecuteReader();
                    RSData.Read();
                    cnt = RSData.GetInt32(0);
                    RSData.Close();
                    RSData = null;
                    command.Connection.Close();
                    command = null;
                }
            }
            catch (Exception ex)
            {
                // xTrace(12335, "clsDataBase:iGetRowCount", ex.Message)
                // messagebox.show("Error 3932.11: " + ex.Message)
                if (ddebug)
                    Debug.Print("Error 3932.11: " + ex.Message);
                Console.WriteLine("Error 3932.11: " + ex.Message);
                cnt = 0;
                LOG.WriteToArchiveLog("clsDatabaseARCH : iGetRowCount : 4010 : " + ex.Message);
            }

            return cnt;
        }

        public SqlDataReader GetRowByKey(string TBL, string WC)
        {
            try
            {
                string Auth = "";
                string s = "Select * from " + TBL + " " + WC;
                SqlDataReader rsData = null;
                bool b = false;
                string CS = ThesaurusConnectionString;
                var CONN = new SqlConnection(CS);
                CONN.Open();
                var command = new SqlCommand(s, CONN);
                rsData = command.ExecuteReader();
                if (rsData.HasRows)
                {
                    rsData.Read();
                    Auth = rsData.GetValue(0).ToString();
                    return rsData;
                }
                else
                {
                    return null;
                }
            }
            catch (Exception ex)
            {
                // xTrace(12330, "clsDataBase:GetRowByKey", ex.Message)
                if (ddebug)
                    Debug.Print(ex.Message);
                LOG.WriteToArchiveLog("clsDatabaseARCH : GetRowByKey : 3963 : " + ex.Message);
                LOG.WriteToArchiveLog("clsDatabaseARCH : GetRowByKey : 3931 : " + ex.Message);
                LOG.WriteToArchiveLog("clsDatabaseARCH : GetRowByKey : 3945 : " + ex.Message);
                return null;
            }
        }

        public void CkConn()
        {
            string S = "";
            if (TrexConnection is null)
            {
                try
                {
                    TrexConnection = new SqlConnection();
                    TrexConnection.ConnectionString = getThesaurusConnectionString();
                    S = getThesaurusConnectionString();
                    TrexConnection.Open();
                }
                catch (Exception ex)
                {
                    LOG.WriteToArchiveLog("clsDatabaseARCH : CkConn : 338 : " + ex.Message);
                }
            }

            if (TrexConnection.State == ConnectionState.Closed)
            {
                try
                {
                    TrexConnection.ConnectionString = getThesaurusConnectionString();
                    S = getThesaurusConnectionString();
                    TrexConnection.Open();
                }
                catch (Exception ex)
                {
                    LOG.WriteToArchiveLog("clsDatabaseARCH : CkConn : 348.2 : " + ex.Message + Constants.vbCrLf + S);
                }
            }
        }

        public void setConnThesaurusStr()
        {
            bool bUseConfig = true;
            string S = "";
            try
            {
                LOG.WriteToInstallLog("INFO: clsDb:setConnThesaurusStr 100: " + My.MySettingsProperty.Settings["UserThesaurusConnString"].ToString());
                if (My.MySettingsProperty.Settings["UserThesaurusConnString"].Equals("?"))
                {
                    S = modGlobals.setThesaurusConnStr();
                    LOG.WriteToInstallLog("INFO: clsDb:setConnThesaurusStr 200: " + S);
                    My.MySettingsProperty.Settings["UserThesaurusConnString"] = S;
                    LOG.WriteToInstallLog("INFO: clsDb:setConnThesaurusStr 300: " + My.MySettingsProperty.Settings["UserThesaurusConnString"].ToString());
                }
                else
                {
                    S = Conversions.ToString(My.MySettingsProperty.Settings["UserThesaurusConnString"]);
                    LOG.WriteToInstallLog("INFO: clsDb:setConnThesaurusStr 400: " + My.MySettingsProperty.Settings["UserThesaurusConnString"].ToString());
                }

                ThesaurusConnectionString = S;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }

            // S = ENC.AES256DecryptString(S)
            ThesaurusConnectionString = S;
            LOG.WriteToInstallLog("INFO: clsDb:setConnThesaurusStr 500: " + S);
        }

        public string getThesaurusConnectionString()
        {
            if (string.IsNullOrEmpty(ThesaurusConnectionString))
            {
                setConnThesaurusStr();
            }

            return ThesaurusConnectionString;
        }

        public string getClassName(string ClassonomyName, string Token)
        {
            string S = "";
            S = S + " SELECT GroupID";
            S = S + " FROM [ECM.Thesaurus].[dbo].[ClassonomyData]";
            S = S + " where [CalssonomyName] = '" + ClassonomyName + "'";
            S = S + " and [Token] = '" + Token + "'";
            string ClassID = "";
            SqlDataReader rsData = null;
            try
            {
                string Auth = "";
                bool b = false;
                string CS = ThesaurusConnectionString;
                var CONN = new SqlConnection(CS);
                CONN.Open();
                var command = new SqlCommand(S, CONN);
                rsData = command.ExecuteReader();
                if (rsData.HasRows)
                {
                    rsData.Read();
                    ClassID = rsData.GetValue(0).ToString();
                }
                else
                {
                    ClassID = "";
                }
            }
            catch (Exception ex)
            {
                // xTrace(12330, "clsDataBase:GetRowByKey", ex.Message)
                if (ddebug)
                    Debug.Print(ex.Message);
                LOG.WriteToArchiveLog("clsDatabaseARCH : getClassName : 3963 : " + ex.Message);
                return null;
            }

            if (rsData.IsClosed)
            {
            }
            else
            {
                rsData.Close();
            }

            rsData = null;
            return ClassID;
        }

        public string getThesaurusID(string ThesaurusName)
        {
            if (ThesaurusName.Trim().Length == 0)
            {
                ThesaurusName = getDefaultThesaurus();
            }

            string S = "";
            S = S + " SELECT [ThesaurusID] FROM [Thesaurus] where [ThesaurusName] = '" + ThesaurusName + "'";
            string TID = "";
            SqlDataReader rsData = null;
            try
            {
                string Auth = "";
                bool b = false;
                string CS = getThesaurusConnectionString();
                var CONN = new SqlConnection(CS);
                CONN.Open();
                var command = new SqlCommand(S, CONN);
                rsData = command.ExecuteReader();
                if (rsData.HasRows)
                {
                    rsData.Read();
                    TID = rsData.GetValue(0).ToString();
                }
                else
                {
                    MessageBox.Show("Did not find the Thesaurus listed in the DBARCH - aborting: " + ThesaurusName + ", so the query will continue without a thesaurus.");
                    LOG.WriteToArchiveLog("clsDatabaseARCH : getThesaurusID : ERROR 3963 : " + Constants.vbCrLf + S);
                }
            }
            catch (Exception ex)
            {
                // xTrace(12330, "clsDataBase:GetRowByKey", ex.Message)
                if (ddebug)
                    Debug.Print(ex.Message);
                LOG.WriteToArchiveLog("clsDatabaseARCH : getThesaurusID : 3963 : " + ex.Message);
                return null;
            }

            if (rsData.IsClosed)
            {
            }
            else
            {
                rsData.Close();
            }

            rsData = null;
            return TID;
        }

        public int getThesaurusNumberID(string ThesaurusName)
        {
            string S = "";
            S = S + " SELECT [ThesaurusSeqID] FROM [Thesaurus] where [ThesaurusName] = '" + ThesaurusName + "'";
            int TID = -1;
            SqlDataReader rsData = null;
            try
            {
                string Auth = "";
                bool b = false;
                string CS = ThesaurusConnectionString;
                var CONN = new SqlConnection(CS);
                CONN.Open();
                var command = new SqlCommand(S, CONN);
                rsData = command.ExecuteReader();
                if (rsData.HasRows)
                {
                    rsData.Read();
                    TID = rsData.GetInt32(0);
                }
                else
                {
                    MessageBox.Show("Did not find the Thesaurus listed in the DBARCH - aborting: " + ThesaurusName);
                    Environment.Exit(0);
                }
            }
            catch (Exception ex)
            {
                // xTrace(12330, "clsDataBase:GetRowByKey", ex.Message)
                if (ddebug)
                    Debug.Print(ex.Message);
                LOG.WriteToArchiveLog("clsDatabaseARCH : getClassName : 3963 : " + ex.Message);
                return default;
            }

            if (rsData.IsClosed)
            {
            }
            else
            {
                rsData.Close();
            }

            rsData = null;
            return TID;
        }

        public bool InsertChildWord(string RootID, string Token, int TokenID)
        {
            string ConnStr = getThesaurusConnectionString();
            bool B = false;
            string S = "";
            try
            {
                S = S + " INSERT INTO [RootChildren]";
                S = S + " ([Token]";
                S = S + " ,[TokenID]";
                S = S + " ,[RootID])";
                S = S + " VALUES";
                S = S + " ('" + Token + "'";
                S = S + " ," + TokenID;
                S = S + " ,'" + RootID + "')";
                B = ExecuteSqlNewConn(S, ConnStr);
            }
            catch (Exception ex)
            {
                B = false;
                Console.WriteLine(ex.Message);
                MessageBox.Show(ex.Message);
            }

            return B;
        }

        public bool RootWordExists(string RootToken)
        {
            string ConnStr = getThesaurusConnectionString();
            bool B = false;
            SqlDataReader rsData = null;
            int iCnt = -1;
            string S = "";
            try
            {
                S = "Select COUNT(*) FROM [Rootword] WHERE [RootToken] = '" + RootToken + "'";
                try
                {
                    string CS = ThesaurusConnectionString;
                    var CONN = new SqlConnection(CS);
                    CONN.Open();
                    var command = new SqlCommand(S, CONN);
                    rsData = command.ExecuteReader();
                    if (rsData.HasRows)
                    {
                        rsData.Read();
                        iCnt = rsData.GetInt32(0);
                    }
                }
                catch (Exception ex)
                {
                    // xTrace(12330, "clsDataBase:GetRowByKey", ex.Message)
                    if (ddebug)
                        Debug.Print(ex.Message);
                    LOG.WriteToArchiveLog("clsDatabaseARCH : getClassName : 3963 : " + ex.Message);
                    iCnt = -1;
                }

                if (rsData.IsClosed)
                {
                }
                else
                {
                    rsData.Close();
                }

                rsData = null;
                return Conversions.ToBoolean(iCnt);
            }
            catch (Exception ex)
            {
                B = false;
                Console.WriteLine(ex.Message);
                MessageBox.Show(ex.Message);
            }

            if (iCnt > 0)
            {
                B = true;
            }
            else
            {
                B = false;
            }

            return B;
        }

        public int AddToken(string Token)
        {
            int TokenID = -1;
            TokenID = getTokenID(Token);
            if (TokenID > 0)
            {
                return TokenID;
            }

            string S = "";
            return default;
        }

        public int getTokenID(string Token)
        {
            Token = UTIL.RemoveSingleQuotes(Token);
            int ID = 0;
            string S = "Select [TokenID] FROM [Tokens] where [Token] = '" + Token + "'";
            string ConnStr = getThesaurusConnectionString();
            bool B = false;
            SqlDataReader rsData = null;
            int iCnt = -1;
            try
            {
                string CS = ThesaurusConnectionString;
                var CONN = new SqlConnection(CS);
                CONN.Open();
                var command = new SqlCommand(S, CONN);
                rsData = command.ExecuteReader();
                if (rsData.HasRows)
                {
                    rsData.Read();
                    iCnt = rsData.GetInt32(0);
                }
            }
            catch (Exception ex)
            {
                // xTrace(12330, "clsDataBase:GetRowByKey", ex.Message)
                if (ddebug)
                    Debug.Print(ex.Message);
                LOG.WriteToArchiveLog("clsDatabaseARCH : getTokenID : 3963 : " + ex.Message);
                iCnt = -1;
            }

            if (rsData.IsClosed)
            {
            }
            else
            {
                rsData.Close();
            }

            rsData = null;
            return iCnt;
            return iCnt;
        }

        public bool ChildWordExists(string RootID, string Token, int TokenID)
        {
            string ConnStr = getThesaurusConnectionString();
            bool B = false;
            SqlDataReader rsData = null;
            int iCnt = -1;
            string S = "";
            try
            {
                S = S + "Select count(*)";
                S = S + "FROM [RootChildren] ";
                S = S + "where ";
                S = S + "[Token] = '" + Token + "'";
                S = S + "and [TokenID] = " + TokenID.ToString();
                S = S + "and [RootID] = '" + RootID + "'";
                try
                {
                    string CS = ThesaurusConnectionString;
                    var CONN = new SqlConnection(CS);
                    CONN.Open();
                    var command = new SqlCommand(S, CONN);
                    rsData = command.ExecuteReader();
                    if (rsData.HasRows)
                    {
                        rsData.Read();
                        iCnt = rsData.GetInt32(0);
                    }
                }
                catch (Exception ex)
                {
                    // xTrace(12330, "clsDataBase:GetRowByKey", ex.Message)
                    if (ddebug)
                        Debug.Print(ex.Message);
                    LOG.WriteToArchiveLog("clsDatabaseARCH : getClassName : 3963 : " + ex.Message);
                    iCnt = -1;
                }

                if (rsData.IsClosed)
                {
                }
                else
                {
                    rsData.Close();
                }

                rsData = null;
                return Conversions.ToBoolean(iCnt);
            }
            catch (Exception ex)
            {
                B = false;
                Console.WriteLine(ex.Message);
                MessageBox.Show(ex.Message);
            }

            if (iCnt > 0)
            {
                B = true;
            }
            else
            {
                B = false;
            }

            return B;
        }

        public bool InsertRootWord(string ThesaurusID, string RootToken, string RootID)
        {
            string ConnStr = getThesaurusConnectionString();
            bool B = false;
            string S = "";
            try
            {
                S = S + " INSERT INTO [ECM.Thesaurus].[dbo].[Rootword]";
                S = S + " (ThesaurusID, [RootToken]";
                S = S + " ,[RootID])";
                S = S + " VALUES ";
                S = S + " ('" + ThesaurusID + "'";
                S = S + " ,'" + RootToken + "'";
                S = S + " ,'" + RootID + "')";
                B = ExecuteSqlNewConn(S, ConnStr);
            }
            catch (Exception ex)
            {
                B = false;
                Console.WriteLine(ex.Message);
                MessageBox.Show(ex.Message);
            }

            return B;
        }

        public string getSynonyms(string ThesaurusID, string Token, ref ListBox lbSynonyms)
        {
            string ConnStr = getThesaurusConnectionString();
            bool B = false;
            SqlDataReader rsData = null;
            int iCnt = -1;
            string Synonyms = "";
            lbSynonyms.Items.Clear();
            string S = " SELECT     RootChildren.Token";
            S = S + " FROM       Rootword INNER JOIN";
            S = S + " RootChildren ON Rootword.RootID = RootChildren.RootID";
            S = S + " where  Rootword.RootToken = '" + Token + "'  and    ThesaurusID  = 'D7A21DA7-0818-4B75-8BBA-D0339D3E1D54'";
            S = S + " order by RootChildren.Token";
            SqlDataReader rsSynonyms = null;
            // rsSynonyms = SqlQryNo'Session(S)
            rsSynonyms = SqlQry(S);
            if (rsSynonyms.HasRows)
            {
                while (rsSynonyms.Read())
                {
                    Synonyms += rsSynonyms.GetValue(0).ToString() + ",";
                    lbSynonyms.Items.Add(rsSynonyms.GetValue(0).ToString());
                }
            }

            if (Conversions.ToBoolean(Synonyms.Trim().Length))
            {
                Synonyms = Strings.Mid(Synonyms, 1, Synonyms.Length - 1);
            }

            rsSynonyms.Close();
            rsSynonyms = null;
            return Synonyms;
        }

        public void getSynonyms(string ThesaurusID, string Token, ref ArrayList SynonymsArray, bool AppendToList)
        {
            string ConnStr = getThesaurusConnectionString();
            bool B = false;
            SqlDataReader rsData = null;
            int iCnt = -1;
            string Synonym = "";
            if (AppendToList == false)
            {
                SynonymsArray.Clear();
            }

            string S = " SELECT     RootChildren.Token";
            S = S + " FROM       Rootword INNER JOIN";
            S = S + " RootChildren ON Rootword.RootID = RootChildren.RootID";
            S = S + " where  Rootword.RootToken = '" + Token + "'  and    ThesaurusID  = '" + ThesaurusID + "'";
            S = S + " order by RootChildren.Token";
            SqlDataReader rsSynonyms = null;
            // rsSynonyms = SqlQryNo'Session(S)
            rsSynonyms = SqlQry(S);
            if (rsSynonyms.HasRows)
            {
                while (rsSynonyms.Read())
                {
                    Synonym = rsSynonyms.GetValue(0).ToString().Trim();
                    Console.WriteLine(Synonym);
                    if (!SynonymsArray.Contains(Synonym))
                    {
                        SynonymsArray.Add(Synonym);
                    }
                }
            }
            // If Synonyms .Trim.Length Then
            // Synonyms  = Mid(Synonyms , 1, Synonyms .Length - 1)
            // End If
            rsSynonyms.Close();
            rsSynonyms = null;
        }

        public void getAllTokens(ref ListBox LB, string ThesaurusID)
        {
            LB.Items.Clear();
            string ConnStr = getThesaurusConnectionString();
            bool B = false;
            SqlDataReader rsData = null;
            int iCnt = -1;
            string Synonyms = "";
            string S = " select RootToken from Rootword order by RootToken ";
            SqlDataReader rsSynonyms = null;
            // rsSynonyms = SqlQryNo'Session(S)
            rsSynonyms = SqlQry(S);
            if (rsSynonyms.HasRows)
            {
                while (rsSynonyms.Read())
                {
                    Synonyms = rsSynonyms.GetValue(0).ToString().Trim();
                    LB.Items.Add(Synonyms);
                }
            }

            rsSynonyms.Close();
            rsSynonyms = null;
        }

        public void PopulateComboBox(ref ComboBox CB, string TblColName, string S)
        {
            bool TryAgain = false;
            RETRY1:
            ;
            string ConnStr = getThesaurusConnectionString();
            var tConn = new SqlConnection(ConnStr);
            var DA = new SqlDataAdapter(S, tConn);
            var DS = new DataSet();
            try
            {
                if (tConn.State == ConnectionState.Closed)
                {
                    tConn.Open();
                }

                DA.Fill(DS, TblColName);

                // Create and populate the DataTable to bind to the ComboBox:
                var dt = new DataTable();

                // Populate the DataTable to bind to the Combobox.
                dt.Columns.Add(TblColName, typeof(string));
                DataRow drNewRow;
                int iRowCnt = 0;
                foreach (DataRow drDSRow in DS.Tables[TblColName].Rows)
                {
                    drNewRow = dt.NewRow();
                    drNewRow[TblColName] = drDSRow[TblColName];
                    dt.Rows.Add(drNewRow);
                    iRowCnt += 1;
                    CB.Items.Add(drDSRow[0].ToString());
                }

                if (iRowCnt == 0)
                {
                    string SS = "insert into Thesaurus (ThesaurusName, ThesaurusID) values ('Roget', 'D7A21DA7-0818-4B75-8BBA-D0339D3E1D54')";
                    bool BB = ExecuteSqlNewConn(SS, ConnStr);
                    MessageBox.Show("Please close and reopen the Search Assistant screen - there is a connectivity issue with the thesaurus.");
                    return;
                }
                // Bind the DataTable to the ComboBox by setting the Combobox's DataSource property to the DataTable. To display the "Description" column in the Combobox's list, set the Combobox's DisplayMember property to the name of column. Likewise, to use the "Code" column as the value of an item in the Combobox set the ValueMember property.
                CB.DropDownStyle = ComboBoxStyle.DropDown;
                // CB.DataSource = dt
                CB.DisplayMember = TblColName;
                CB.SelectedIndex = 0;
                if (DS is object)
                {
                    DS = null;
                }

                if (DA is object)
                {
                    DA = null;
                }

                if (tConn is object)
                {
                    tConn.Close();
                    tConn = null;
                }
            }
            catch (Exception ex)
            {
                if (ddebug)
                    Debug.Print("Error 2194.23: " + ex.Message);
                LOG.WriteToArchiveLog("clsDB : PopulateComboBox : 1000 : " + ex.Message + Constants.vbCrLf + S + Constants.vbCrLf + ConnStr);
                if (Conversions.ToBoolean(Strings.InStr(ex.Message, "XX", CompareMethod.Text) & Conversions.ToInteger(TryAgain == false)))
                {
                    My.MySettingsProperty.Settings["UserThesaurusConnString"] = "?";
                    LOG.WriteToArchiveLog("clsDB : PopulateComboBox : 1000a : try again using APP Config.");
                    TryAgain = true;
                    goto RETRY1;
                }
            }
            finally
            {
                if (DA is object)
                {
                    DA = null;
                }

                if (DS is object)
                {
                    DS = null;
                }

                if (tConn is object)
                {
                    tConn.Close();
                    tConn = null;
                }

                GC.Collect();
            }
        }
    }
}