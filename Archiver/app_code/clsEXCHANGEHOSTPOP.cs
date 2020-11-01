using global::System.Data.SqlClient;
using System.Windows.Forms;
using global::Microsoft.VisualBasic;
using MODI;

namespace EcmArchiver
{
    public class clsEXCHANGEHOSTPOP
    {
        public clsEXCHANGEHOSTPOP()
        {
            ConnStr = DBARCH.setConnStr();
        }

        // ** DIM the selected table columns

        private clsDatabaseARCH DBARCH = new clsDatabaseARCH();
        private clsDma DMA = new clsDma();
        private clsUtility UTIL = new clsUtility();
        private clsLogging LOG = new clsLogging();
        private clsDataGrid DG = new clsDataGrid();
        private string HostNameIp = "";
        private string UserLoginID = "";
        private string LoginPw = "";
        private string SSL = "";
        private string PortNbr = "";
        private string DeleteAfterDownload = "";
        private string RetentionCode = "";
        private string IMap = "";
        private string Userid = "";
        private string FolderName = "";
        private string LibraryName = "";
        private bool isPublic = false;
        private int DaysToHold = 0;
        private string strReject = "";
        private bool ckConvertEmlToMsg = false;
        private string ConnStr;     // DBARCH.getGateWayConnStr(gGateWayID)

        // ** Generate the SET methods 
        public void setConvertEmlToMsg(ref bool val)
        {
            ckConvertEmlToMsg = val;
        }

        public void setReject(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            strReject = val;
        }

        public void setDaysToHold(ref int val)
        {
            DaysToHold = val;
        }

        public void setLibrary(ref bool val)
        {
            isPublic = val;
        }

        public void setLibrary(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            LibraryName = val;
        }

        public void setFolderName(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            FolderName = val;
        }

        public void setHostnameip(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Hostnameip' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            HostNameIp = val;
        }

        public void setUserloginid(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Userloginid' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            UserLoginID = val;
        }

        public void setLoginpw(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Loginpw' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            LoginPw = val;
        }

        public void setSsl(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                val = "null";
            }

            val = UTIL.RemoveSingleQuotes(val);
            SSL = val;
        }

        public void setPortnbr(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                val = "null";
            }

            val = UTIL.RemoveSingleQuotes(val);
            PortNbr = val;
        }

        public void setDeleteafterdownload(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                val = "null";
            }

            val = UTIL.RemoveSingleQuotes(val);
            DeleteAfterDownload = val;
        }

        public void setRetentioncode(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            RetentionCode = val;
        }

        public void setImap(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                val = "null";
            }

            val = UTIL.RemoveSingleQuotes(val);
            IMap = val;
        }

        public void setUserid(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            Userid = val;
        }



        // ** Generate the GET methods 
        public string getFolderName()
        {
            return UTIL.RemoveSingleQuotes(FolderName);
        }

        public string getHostnameip()
        {
            if (Strings.Len(HostNameIp) == 0)
            {
                MessageBox.Show("GET: Field 'Hostnameip' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(HostNameIp);
        }

        public string getUserloginid()
        {
            if (Strings.Len(UserLoginID) == 0)
            {
                MessageBox.Show("GET: Field 'Userloginid' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(UserLoginID);
        }

        public string getLoginpw()
        {
            if (Strings.Len(LoginPw) == 0)
            {
                MessageBox.Show("GET: Field 'Loginpw' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(LoginPw);
        }

        public string getSsl()
        {
            if (Strings.Len(SSL) == 0)
            {
                SSL = "null";
            }

            return SSL;
        }

        public string getPortnbr()
        {
            if (Strings.Len(PortNbr) == 0)
            {
                PortNbr = "null";
            }

            return PortNbr;
        }

        public string getDeleteafterdownload()
        {
            if (Strings.Len(DeleteAfterDownload) == 0)
            {
                DeleteAfterDownload = "null";
            }

            return DeleteAfterDownload;
        }

        public string getRetentioncode()
        {
            return UTIL.RemoveSingleQuotes(RetentionCode);
        }

        public string getImap()
        {
            if (Strings.Len(IMap) == 0)
            {
                IMap = "null";
            }

            return IMap;
        }

        public string getUserid()
        {
            return UTIL.RemoveSingleQuotes(Userid);
        }



        // ** Generate the Required Fields Validation method 
        public bool ValidateReqData()
        {
            if (HostNameIp.Length == 0)
                return false;
            if (UserLoginID.Length == 0)
                return false;
            if (LoginPw.Length == 0)
                return false;
            return true;
        }


        // ** Generate the Validation method 
        public bool ValidateData()
        {
            if (HostNameIp.Length == 0)
                return false;
            if (UserLoginID.Length == 0)
                return false;
            if (LoginPw.Length == 0)
                return false;
            return true;
        }


        // ** Generate the INSERT method 
        public bool Insert()
        {
            bool b = false;
            string s = "";
            s = s + " INSERT INTO ExchangeHostPop(";
            s = s + "HostNameIp,";
            s = s + "UserLoginID,";
            s = s + "LoginPw,";
            s = s + "SSL,";
            s = s + "PortNbr,";
            s = s + "DeleteAfterDownload,";
            s = s + "RetentionCode,";
            s = s + "IMap,";
            s = s + "Userid, FolderName, LibraryName, isPublic, DaysToHold, strReject, ConvertEmlToMSG) values (";
            s = s + "'" + HostNameIp + "'" + ",";
            s = s + "'" + UserLoginID + "'" + ",";
            s = s + "'" + LoginPw + "'" + ",";
            s = s + SSL + ",";
            s = s + PortNbr + ",";
            s = s + DeleteAfterDownload + ",";
            s = s + "'" + RetentionCode + "'" + ",";
            s = s + IMap + ",";
            s = s + "'" + Userid + "'" + ",";
            s = s + "'" + FolderName + "'" + ",";
            s = s + "'" + LibraryName + "'" + ",";
            if (isPublic == true)
            {
                s = s + "1,";
            }
            else
            {
                s = s + "0,";
            }

            s = s + DaysToHold.ToString() + ", ";
            s = s + "'" + strReject + "', ";
            if (ckConvertEmlToMsg == true)
            {
                s = s + "1) ";
            }
            else
            {
                s = s + "0) ";
            }
            // log.WriteToArchiveLog("INFO: " + vbCrLf + s)
            return DBARCH.ExecuteSql(s, ConnStr, false);
        }


        // ** Generate the UPDATE method 
        public bool Update(string Host, string UserID, string UserLogin)
        {
            bool b = false;
            string s = "";
            s = s + " update ExchangeHostPop set ";
            // s = s + "HostNameIp = '" + getHostnameip() + "'" + ", "
            // s = s + "UserLoginID = '" + getUserloginid() + "'" + ", "
            s = s + "LoginPw = '" + getLoginpw() + "'" + ", ";
            s = s + "SSL = " + getSsl() + ", ";
            s = s + "PortNbr = " + getPortnbr() + ", ";
            s = s + "DeleteAfterDownload = " + getDeleteafterdownload() + ", ";
            s = s + "RetentionCode = '" + getRetentioncode() + "'" + ", ";
            s = s + "IMap = " + getImap() + ", ";
            s = s + "FolderName = '" + getFolderName() + "', ";
            s = s + "LibraryName = '" + LibraryName + "', ";
            if (isPublic == true)
            {
                s = s + "isPublic = 1, ";
            }
            else
            {
                s = s + "isPublic = 0, ";
            }

            s = s + "DaysToHold = " + DaysToHold.ToString() + ", ";
            s = s + "strReject = '" + strReject + "', ";
            if (ckConvertEmlToMsg == true)
            {
                s = s + "ConvertEmlToMSG = 1 ";
            }
            else
            {
                s = s + "ConvertEmlToMSG = 0 ";
            }

            s = s + " Where ";
            s = s + " HostNameIp = '" + Host + "' ";
            s = s + " and   Userid = '" + UserID + "'";
            s = s + " and [UserLoginID] = '" + UserLogin + "'";
            return DBARCH.ExecuteSql(s, ConnStr, false);
        }


        // ** Generate the SELECT method 
        public SqlDataReader SelectRecs()
        {
            bool b = false;
            string s = "";
            var rsData = default(SqlDataReader);
            s = s + " SELECT ";
            s = s + "HostNameIp,";
            s = s + "UserLoginID,";
            s = s + "LoginPw,";
            s = s + "SSL,";
            s = s + "PortNbr,";
            s = s + "DeleteAfterDownload,";
            s = s + "RetentionCode,";
            s = s + "IMap,";
            s = s + "Userid ";
            s = s + " FROM ExchangeHostPop";
            // ** s=s+ "ORDERBY xxxx"
            string CS = DBARCH.setConnStr();     // DBARCH.getGateWayConnStr(gGateWayID) : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader()
            return rsData;
        }


        // ** Generate the Select One Row method 
        public SqlDataReader SelectOne(string WhereClause)
        {
            bool b = false;
            string s = "";
            var rsData = default(SqlDataReader);
            s = s + " SELECT ";
            s = s + "HostNameIp,";
            s = s + "UserLoginID,";
            s = s + "LoginPw,";
            s = s + "SSL,";
            s = s + "PortNbr,";
            s = s + "DeleteAfterDownload,";
            s = s + "RetentionCode,";
            s = s + "IMap,";
            s = s + "Userid ";
            s = s + " FROM ExchangeHostPop";
            s = s + WhereClause;
            // ** s=s+ "ORDERBY xxxx"
            string CS = DBARCH.setConnStr();     // DBARCH.getGateWayConnStr(gGateWayID) : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader()
            return rsData;
        }


        // ** Generate the DELETE method 
        public bool Delete(string WhereClause)
        {
            bool b = false;
            string s = "";
            if (Strings.Len(WhereClause) == 0)
                return false;
            WhereClause = " " + WhereClause;
            s = " Delete from ExchangeHostPop";
            s = s + WhereClause;
            b = DBARCH.ExecuteSql(s, ConnStr, false);
            return b;
        }


        // ** Generate the Zeroize Table method 
        public bool Zeroize()
        {
            bool b = false;
            string s = "";
            s = s + " Delete from ExchangeHostPop";
            b = DBARCH.ExecuteSql(s, ConnStr, false);
            return b;
        }


        // ** Generate Index Queries 
        public int cnt_PK_ExchangeHostPop(string HostNameIp, string Userid, string UserLoginID)
        {
            int B = 0;
            string TBL = "ExchangeHostPop";
            string WC = "Where HostNameIp = '" + HostNameIp + "' and   Userid = '" + Userid + "' and   UserLoginID = '" + UserLoginID + "'";
            B = DBARCH.iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_PK_ExchangeHostPop

        // ** Generate Index ROW Queries 
        public SqlDataReader getRow_PK_ExchangeHostPop(string HostNameIp, string Userid, string UserLoginID)
        {
            SqlDataReader rsData = null;
            string TBL = "ExchangeHostPop";
            string WC = "Where HostNameIp = '" + HostNameIp + "' and   Userid = '" + Userid + "' and   UserLoginID = '" + UserLoginID + "'";
            rsData = DBARCH.GetRowByKey(TBL, WC);
            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow_PK_ExchangeHostPop

        /// Build Index Where Caluses
        public string wc_PK_ExchangeHostPop(string HostNameIp, string Userid, string UserLoginID)
        {
            string WC = "Where HostNameIp = '" + HostNameIp + "' and   Userid = '" + Userid + "' and   UserLoginID = '" + UserLoginID + "'";
            return WC;
        }     // ** wc_PK_ExchangeHostPop

        // ** Generate the SET methods 

    }
}