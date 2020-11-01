using System;
using System.Data;
using global::System.Data.SqlClient;
using System.Windows.Forms;
using Microsoft.VisualBasic;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{
    public class clsGlobalEntity
    {
        private clsLogging LOG = new clsLogging();
        private clsUtility UTIL = new clsUtility();
        private clsKeyGen KEY = new clsKeyGen();
        private string HashCode = "";
        private Guid GuidID = default;
        private string ShortName = "";
        private string LongName = "";
        private int LocatorID = 0;
        private string gConnStr = "";
        private SqlConnection gConn;
        private int ShortNameLength = 250;

        public Guid XXAddItem(string FQN, string TableName, bool CaseSensitive)
        {
            if (CaseSensitive == false)
            {
                FQN = FQN.ToUpper();
            }

            FQN = UTIL.RemoveSingleQuotes(FQN);
            int NameLength = FQN.Length;
            string S = "";
            var NewGuid = ItemExists(FQN, TableName, CaseSensitive);
            try
            {
                if (NewGuid == default)
                {
                    if (NameLength <= ShortNameLength)
                    {
                        ShortName = UTIL.RemoveSingleQuotes(FQN);
                        LongName = "";
                    }
                    else
                    {
                        LongName = UTIL.RemoveSingleQuotes(FQN);
                        ShortName = "";
                    }

                    HashCode = KEY.getMD5HashX(FQN);
                    NewGuid = Guid.NewGuid();
                    S = "";
                    if (TableName.Equals("GlobalDirectory"))
                    {
                        S = S + " INSERT INTO [GlobalDirectory]";
                    }
                    else if (TableName.Equals("GlobalFile"))
                    {
                        S = S + " INSERT INTO  [GlobalFile] ";
                    }
                    else if (TableName.Equals("GlobalLocation"))
                    {
                        S = S + " INSERT INTO  [GlobalLocation] ";
                    }
                    else if (TableName.Equals("GlobalMachine"))
                    {
                        S = S + " INSERT INTO  [GlobalMachine] ";
                    }
                    else if (TableName.Equals("GlobalEmail"))
                    {
                        S = S + " INSERT INTO  [GlobalEmail] ";
                    }
                    else
                    {
                        LOG.WriteToArchiveLog("ERROR AddEntity - incorrect table name supplied '" + TableName + "'.");
                        return default;
                    }

                    S = S + " ([HashCode]";
                    S = S + " ,[GuidID]";
                    S = S + " ,[ShortName] ";
                    S = S + " ,[LongName])";
                    S = S + " VALUES ";
                    S = S + " ('" + HashCode + "'";
                    S = S + " ,'" + NewGuid.ToString() + "'";
                    S = S + " ,'" + ShortName + "'";
                    S = S + " ,'" + LongName + "')";
                    bool B = ExecSql(S);
                    if (B == false)
                    {
                        LOG.WriteToArchiveLog("ERROR AddEntity - Table name  '" + TableName + "' - " + Constants.vbCrLf + S);
                        NewGuid = default;
                    }
                }
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR AddEntity - 100: Table name  '" + TableName + "' - " + FQN);
                NewGuid = default;
            }

            return NewGuid;
        }

        public Guid ItemExists(string FQN, string TableName, bool CaseSensitive)
        {
            if (CaseSensitive == false)
            {
                FQN = FQN.ToUpper();
            }

            bool B = false;
            int NameLength = FQN.Length;
            GuidID = default;
            HashCode = KEY.getMD5HashX(FQN);
            string S = "";
            try
            {
                S = " Select ";
                S = S + "  [GuidID]";
                S = S + " ,[ShortName]";
                S = S + " ,[LongName]";
                S = S + " ,[LocatorID]";
                if (TableName.Equals("GlobalDirectory"))
                {
                    S = S + " FROM [GlobalDirectory] ";
                }
                else if (TableName.Equals("GlobalFile"))
                {
                    S = S + " FROM [GlobalFile] ";
                }
                else if (TableName.Equals("GlobalLocation"))
                {
                    S = S + " FROM [GlobalLocation] ";
                }
                else if (TableName.Equals("GlobalMachine"))
                {
                    S = S + " FROM [GlobalMachine] ";
                }
                else if (TableName.Equals("GlobalEmail"))
                {
                    S = S + " FROM [GlobalEmail] ";
                }
                else
                {
                    LOG.WriteToArchiveLog("ERROR EntityExists - incorrect table name supplied '" + TableName + "'.");
                    return default;
                }

                S = S + " where HashCode = '" + HashCode + "'";
                bool ddebug = false;
                bool rc = false;
                SqlDataReader rsDataQry = null;
                setConnStr();
                var CN = new SqlConnection(gConnStr);
                if (CN.State == ConnectionState.Closed)
                {
                    CN.Open();
                }

                var command = new SqlCommand(S, CN);
                try
                {
                    rsDataQry = command.ExecuteReader();
                    if (rsDataQry.HasRows)
                    {
                        while (rsDataQry.Read())
                        {
                            if (NameLength <= ShortNameLength)
                            {
                                GuidID = rsDataQry.GetGuid(0);
                                ShortName = rsDataQry.GetString(1);
                                if (FQN.Equals(ShortName))
                                {
                                    break;
                                }
                            }
                            else
                            {
                                GuidID = rsDataQry.GetGuid(0);
                                LongName = rsDataQry.GetString(2);
                                if (FQN.Equals(ShortName))
                                {
                                    break;
                                }
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    LOG.WriteToArchiveLog("ItemExists : 1300 : " + ex.Message);
                    GuidID = default;
                }
                finally
                {
                    command.Dispose();
                    command = null;
                    if (CN.State == ConnectionState.Open)
                    {
                        CN.Close();
                    }

                    CN.Dispose();
                    GC.Collect();
                }
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ItemExists : 1301 : " + ex.Message);
                GuidID = default;
            }

            return GuidID;
        }

        public void setConnStr()
        {
            string S = "";
            lock (this)
            {
                try
                {
                    // If ddebug Then log.WriteToArchiveLog("010 - gUserConnectionStringConfirmedGood is being initiated.")
                    S = Conversions.ToString(My.MySettingsProperty.Settings["UserDefaultConnString"]);
                    if (!S.Equals("?"))
                    {
                        if (modGlobals.gUserConnectionStringConfirmedGood == true)
                        {
                            gConnStr = S;
                        }
                        else
                        {
                            try
                            {
                                if (gConn.State == ConnectionState.Open)
                                {
                                    // If ddebug Then log.WriteToArchiveLog("400 - gUserConnectionStringConfirmedGood.")
                                    gConn.Close();
                                }
                                // If ddebug Then log.WriteToArchiveLog("500 - gUserConnectionStringConfirmedGood.")
                                gConn.ConnectionString = S;
                                gConn.Open();
                                modGlobals.gUserConnectionStringConfirmedGood = true;
                                My.MySettingsProperty.Settings["UserDefaultConnString"] = S;
                                My.MySettingsProperty.Settings.Save();
                                gConnStr = S;
                            }
                            catch (Exception ex)
                            {
                                // ** The connection failed use the APP.CONFIG string
                                S = System.Configuration.ConfigurationManager.AppSettings["ECMREPO"];
                                My.MySettingsProperty.Settings["UserDefaultConnString"] = S;
                                My.MySettingsProperty.Settings.Save();
                                modGlobals.gUserConnectionStringConfirmedGood = true;
                                gConnStr = S;
                            }
                        }

                        goto SKIPOUT;
                    }
                    else if (S.Equals("?"))
                    {
                        // ** First time, set the connection str to the APP.CONFIG.
                        // 'If ddebug Then log.WriteToArchiveLog("1001 - gUserConnectionStringConfirmedGood.")
                        S = System.Configuration.ConfigurationManager.AppSettings["ECMREPO"];
                        My.MySettingsProperty.Settings["UserDefaultConnString"] = S;
                        My.MySettingsProperty.Settings.Save();
                        // 'If ddebug Then log.WriteToArchiveLog("1002 - gUserConnectionStringConfirmedGood.")
                        modGlobals.gUserConnectionStringConfirmedGood = true;
                        gConnStr = S;
                        // If ddebug Then log.WriteToArchiveLog("1003 - gUserConnectionStringConfirmedGood.")
                        goto SKIPOUT;
                    }
                }
                catch (Exception ex)
                {
                    // If ddebug Then log.WriteToArchiveLog("1004 - gUserConnectionStringConfirmedGood.")
                    S = System.Configuration.ConfigurationManager.AppSettings["ECMREPO"];
                    LOG.WriteToArchiveLog("1005 - gUserConnectionStringConfirmedGood: " + S);
                }

                bool bUseConfig = true;

                // If ddebug Then log.WriteToArchiveLog("1006 - gUserConnectionStringConfirmedGood.")


                S = System.Configuration.ConfigurationManager.AppSettings["ECMREPO"];
                UTIL.setConnectionStringTimeout(ref S);
                gConnStr = S;
                SKIPOUT:
                ;
            }
        }

        public bool ExecSql(string sql)
        {
            bool rc = false;
            setConnStr();
            var CN = new SqlConnection(gConnStr);
            CN.Open();
            var dbCmd = CN.CreateCommand();
            bool BB = true;
            using (CN)
            {
                dbCmd.Connection = CN;
                try
                {
                    dbCmd.CommandText = sql;
                    dbCmd.ExecuteNonQuery();
                    BB = true;
                }
                catch (Exception ex)
                {
                    rc = false;
                    if (Strings.InStr(ex.Message, "The DELETE statement conflicted with the REFERENCE", CompareMethod.Text) > 0)
                    {
                        if (modGlobals.gRunUnattended == false)
                            MessageBox.Show("It appears this user has DATA within the repository associated to them and cannot be deleted." + Constants.vbCrLf + Constants.vbCrLf + ex.Message);
                        LOG.WriteToArchiveLog("It appears this user has DATA within the repository associated to them and cannot be deleted." + Constants.vbCrLf + Constants.vbCrLf + ex.Message);
                    }
                    else if (Strings.InStr(ex.Message, "HelpText", CompareMethod.Text) > 0)
                    {
                        BB = true;
                    }
                    else if (Strings.InStr(ex.Message, "duplicate key row", CompareMethod.Text) > 0)
                    {
                        BB = true;
                    }
                    else if (Strings.InStr(ex.Message, "duplicate key", CompareMethod.Text) > 0)
                    {
                        BB = true;
                    }
                    else if (Strings.InStr(ex.Message, "duplicate", CompareMethod.Text) > 0)
                    {
                        BB = true;
                    }
                    else
                    {
                        BB = false;
                        LOG.WriteToArchiveLog("clsDatabaseARCH : ExecuteSqlNewConn : 79442a1p1: " + ex.Message);
                        LOG.WriteToArchiveLog("clsDatabaseARCH : ExecuteSqlNewConn : 7442a1p2: " + Constants.vbCrLf + sql + Constants.vbCrLf);
                    }
                }
            }

            if (CN.State == ConnectionState.Open)
            {
                CN.Close();
            }

            CN = null;
            dbCmd = null;
            GC.Collect();
            return BB;
        }
    }
}