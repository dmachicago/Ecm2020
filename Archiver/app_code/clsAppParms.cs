using global::System;
using System.Data;
using global::System.Data.SqlClient;
using global::System.IO;
using System.Windows.Forms;
using global::Microsoft.VisualBasic;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{
    public class clsAppParms
    {
        public clsAppParms()
        {
            ErrLogFqn = LOG.getTempEnvironDir() + @"\ECMLibrary.AppParms.Log";
        }

        private clsDma DMA = new clsDma();
        private clsLogging LOG = new clsLogging();
        private clsUtility UTIL = new clsUtility();
        private SqlConnection AppConn = new SqlConnection();
        private string ErrLogFqn;
        private clsDatabaseARCH DBARCH = new clsDatabaseARCH();
        private clsPROCESSFILEAS PFA = new clsPROCESSFILEAS();

        public void SaveSearch(string SaveName, string SaveTypeCode, string UID, string ValName, string ValValue)
        {
            try
            {
                var SI = new clsSAVEDITEMS();
                bool B = false;
                SI.setSavename(ref SaveName);
                SI.setSavetypecode(ref SaveTypeCode);
                SI.setUserid(ref UID);
                SI.setValname(ref ValName);
                if (ValValue.Length > 0)
                {
                    SI.setValvalue(ref ValValue);
                }
                else
                {
                    string argval = "null";
                    SI.setValvalue(ref argval);
                }

                int I = SI.cnt_PK_SavedItems(SaveName, SaveTypeCode, UID, ValName);
                if (I == 0)
                {
                    B = SI.Insert();
                    if (!B)
                    {
                        LOG.WriteToArchiveLog("clsAppParms : SaveSearch : 00 Error failed to save a search item: " + SaveTypeCode + " : " + ValName + " : " + ValValue + ".");
                    }
                }

                if (I > 0)
                {
                    string WC = SI.wc_PK_SavedItems(SaveName, SaveTypeCode, UID, ValName);
                    SI.Update(WC);
                }
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("clsAppParms : SaveSearch : 00A Error failed to save a search item: " + SaveTypeCode + " : " + ValName + " : " + ValValue + ".");
                LOG.WriteToArchiveLog("clsAppParms : SaveSearch : 00A Error failed to save a search item: " + ex.Message);
            }
        }

        public string SaveSearchParm(string SaveName, string SaveTypeCode, string UID, string ValName, string ValValue)
        {
            string S = "";
            SaveName = UTIL.RemoveSingleQuotes(SaveName);
            SaveTypeCode = UTIL.RemoveSingleQuotes(SaveTypeCode);
            ValName = UTIL.RemoveSingleQuotes(ValName);
            ValValue = UTIL.RemoveSingleQuotes(ValValue);
            try
            {
                S = SaveName + Conversions.ToString('ú') + SaveTypeCode + Conversions.ToString('ú') + UID + Conversions.ToString('ú') + ValName + Conversions.ToString('ú') + ValValue + Conversions.ToString('þ');
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("clsAppParms : SaveSearchParm : 00A Error failed to save a search item: " + SaveTypeCode + " : " + ValName + " : " + ValValue + ".");
                LOG.WriteToArchiveLog("clsAppParms : SaveSearchParm : 00A Error failed to save a search item: " + ex.Message);
            }

            return S;
        }

        public string getConnStr()
        {
            bool bUseConfig = true;
            string S = "";
            S = DBARCH.setConnStr();     // DBARCH.getGateWayConnStr(gGateWayID)
            UTIL.setConnectionStringTimeout(ref S);
            return S;
        }

        public void CkConn()
        {
            if (AppConn is null)
            {
                try
                {
                    AppConn = new SqlConnection();
                    AppConn.ConnectionString = getConnStr();
                    AppConn.Open();
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Error 121.21");
                    Console.WriteLine(ex.Source);
                    Console.WriteLine(ex.StackTrace);
                    Console.WriteLine(ex.Message);
                    LOG.WriteToArchiveLog("clsAppParms : CkConn : 31 : " + ex.Message);
                }
            }

            if (AppConn.State == ConnectionState.Closed)
            {
                try
                {
                    AppConn.ConnectionString = getConnStr();
                    AppConn.Open();
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Error 121.21");
                    Console.WriteLine(ex.Source);
                    Console.WriteLine(ex.StackTrace);
                    Console.WriteLine(ex.Message);
                    LOG.WriteToArchiveLog("clsAppParms : CkConn : 40 : " + ex.Message);
                }
            }
        }

        public SqlDataReader SqlQry(string sql)
        {
            // 'Session("ActiveError") = False
            bool ddebug = false;
            string queryString = sql;
            bool rc = false;
            SqlDataReader rsDataQry = null;
            if (AppConn.State == ConnectionState.Open)
            {
                AppConn.Close();
            }

            CkConn();
            var command = new SqlCommand(sql, AppConn);
            try
            {
                rsDataQry = command.ExecuteReader();
            }
            catch (Exception ex)
            {
                WriteToLog("Error clsAppParms1001 Time: " + Conversions.ToString(DateAndTime.Now), ErrLogFqn);
                WriteToLog("Error clsAppParms1001 clsAppParms.SqlQry: " + Conversions.ToString(DateAndTime.Now), ErrLogFqn);
                WriteToLog("Error clsAppParms1001 Msg: " + ex.Message, ErrLogFqn);
                WriteToLog("Error clsAppParms1001 SQL: " + sql, ErrLogFqn);
                MessageBox.Show("Errors, check the log: " + ErrLogFqn);
                LOG.WriteToArchiveLog("clsAppParms : SqlQry : 57 : " + ex.Message);
            }

            command.Dispose();
            command = null;
            return rsDataQry;
        }

        public void WriteToLog(string Msg, string LogFQN)
        {
            using (var sw = new StreamWriter(LogFQN, true))
            {
                // Add some text to the file.                                    
                sw.WriteLine(Conversions.ToString(DateAndTime.Now) + ": " + Msg);
                sw.Close();
            }
        }

        public void SaveUserParm(string ParmName, string ParameterValue, string AssignedUserID, string SaveName, string SaveTypeCode)
        {
            if (ParmName.Trim().Length == 0)
            {
                MessageBox.Show("A Parameter must be supplied, returning.");
                return;
            }

            bool B = true;
            if (AssignedUserID.Length == 0)
            {
                MessageBox.Show("A USER must be selected, returning.");
                return;
            }

            // Dim sSql  = "DELETE FROM [SavedItems]"
            // sSql  += " WHERE "
            // sSql  += " [Userid] = '" + AssignedUserID  + "'"
            // sSql  += " and [SaveName]  = '" + SaveName  + "'"
            // sSql  += " and [SaveTypeCode]  = '" + SaveTypeCode  + "'"
            // B = DBARCH.ExecuteSqlNewConn(sSql,false)

            ParameterValue = UTIL.RemoveSingleQuotes(ParameterValue);
            SaveSearch(SaveName, SaveTypeCode, AssignedUserID, ParmName, ParameterValue);
        }

        public string SaveNewAssociations(string ParentFT, string ChildFT)
        {
            // Dim ParentFT  = cbPocessType.Text
            // Dim ChildFT  = cbAsType.Text
            string MSG = "";
            PFA.setExtcode(ref ParentFT);
            PFA.setProcessextcode(ref ChildFT);
            string argval = "0";
            PFA.setApplied(ref argval);
            string S = "";
            bool B = DBARCH.ckProcessAsExists(ParentFT);
            if (!B)
            {
                PFA.Insert();
            }
            else
            {
                MSG = "Extension already defined to system...";
                return MSG;
            }

            S = "update [DataSource] set [SourceTypeCode] = '" + ChildFT + "' where [SourceTypeCode] = '" + ParentFT + "' and [DataSourceOwnerUserID] = '" + modGlobals.gCurrUserGuidID + "'";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            if (B)
            {
                MSG = ParentFT + " set to process as " + ChildFT;
                S = " update ProcessFileAs set Applied = 1  where Extcode = '" + ParentFT + "' and [ProcessExtCode] = '" + ChildFT + "'";
                B = DBARCH.ExecuteSqlNewConn(S, false);
            }
            else
            {
                MSG = ParentFT + " WAS NOT set to process as " + ChildFT;
            }

            return MSG;
        }
    }
}