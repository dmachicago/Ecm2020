using global::System.Data.SqlClient;
using System.Windows.Forms;
using global::Microsoft.VisualBasic;
using MODI;

namespace EcmArchiver
{
    public class clsLICENSE
    {

        // ** DIM the selected table columns 
        private clsDatabaseARCH DBARCH = new clsDatabaseARCH();
        private clsDma DMA = new clsDma();
        private clsUtility UTIL = new clsUtility();
        private clsLogging LOG = new clsLogging();
        private clsDataGrid DG = new clsDataGrid();
        private string Agreement = "";
        private string VersionNbr = "";
        private string ActivationDate = "";
        private string InstallDate = "";
        private string CustomerID = "";
        private string CustomerName = "";
        private string LicenseID = "";
        private string XrtNxr1 = "";
        private string SqlServerInstanceNameX = "";
        private string SqlServerMachineName = "";


        // ** Generate the SET methods 
        public void setAgreement(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Agreement' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            Agreement = val;
        }

        public void setVersionnbr(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Versionnbr' cannot be NULL.");
                return;
            }

            if (Strings.Len(val) == 0)
            {
                val = "null";
            }

            val = UTIL.RemoveSingleQuotes(val);
            VersionNbr = val;
        }

        public void setActivationdate(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Activationdate' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            ActivationDate = val;
        }

        public void setInstalldate(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Installdate' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            InstallDate = val;
        }

        public void setCustomerid(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Customerid' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            CustomerID = val;
        }

        public void setCustomername(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Customername' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            CustomerName = val;
        }

        public void setXrtnxr1(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            XrtNxr1 = val;
        }

        public void setServeridentifier(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            SqlServerInstanceNameX = val;
        }

        public void setSqlinstanceidentifier(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            SqlServerMachineName = val;
        }



        // ** Generate the GET methods 
        public string getAgreement()
        {
            if (Strings.Len(Agreement) == 0)
            {
                MessageBox.Show("GET: Field 'Agreement' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(Agreement);
        }

        public string getVersionnbr()
        {
            if (Strings.Len(VersionNbr) == 0)
            {
                MessageBox.Show("GET: Field 'Versionnbr' cannot be NULL.");
                return "";
            }

            if (Strings.Len(VersionNbr) == 0)
            {
                VersionNbr = "null";
            }

            return VersionNbr;
        }

        public string getActivationdate()
        {
            if (Strings.Len(ActivationDate) == 0)
            {
                MessageBox.Show("GET: Field 'Activationdate' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(ActivationDate);
        }

        public string getInstalldate()
        {
            if (Strings.Len(InstallDate) == 0)
            {
                MessageBox.Show("GET: Field 'Installdate' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(InstallDate);
        }

        public string getCustomerid()
        {
            if (Strings.Len(CustomerID) == 0)
            {
                MessageBox.Show("GET: Field 'Customerid' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(CustomerID);
        }

        public string getCustomername()
        {
            if (Strings.Len(CustomerName) == 0)
            {
                MessageBox.Show("GET: Field 'Customername' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(CustomerName);
        }

        public string getLicenseid()
        {
            if (Strings.Len(LicenseID) == 0)
            {
                MessageBox.Show("GET: Field 'Licenseid' cannot be NULL.");
                return "";
            }

            if (Strings.Len(LicenseID) == 0)
            {
                LicenseID = "null";
            }

            return LicenseID;
        }

        public string getXrtnxr1()
        {
            return UTIL.RemoveSingleQuotes(XrtNxr1);
        }

        public string getServeridentifier()
        {
            return UTIL.RemoveSingleQuotes(SqlServerInstanceNameX);
        }

        public string getSqlinstanceidentifier()
        {
            return UTIL.RemoveSingleQuotes(SqlServerMachineName);
        }



        // ** Generate the Required Fields Validation method 
        public bool ValidateReqData()
        {
            if (Agreement.Length == 0)
                return false;
            if (VersionNbr.Length == 0)
                return false;
            if (ActivationDate.Length == 0)
                return false;
            if (InstallDate.Length == 0)
                return false;
            if (CustomerID.Length == 0)
                return false;
            if (CustomerName.Length == 0)
                return false;
            if (LicenseID.Length == 0)
                return false;
            return true;
        }


        // ** Generate the Validation method 
        public bool ValidateData()
        {
            if (Agreement.Length == 0)
                return false;
            if (VersionNbr.Length == 0)
                return false;
            if (ActivationDate.Length == 0)
                return false;
            if (InstallDate.Length == 0)
                return false;
            if (CustomerID.Length == 0)
                return false;
            if (CustomerName.Length == 0)
                return false;
            return true;
        }


        // ** Generate the INSERT method 
        public bool Insert()
        {
            bool b = false;
            string s = "";
            s = s + " INSERT INTO License(" + Constants.vbCrLf;
            s = s + "Agreement," + Constants.vbCrLf;
            s = s + "VersionNbr," + Constants.vbCrLf;
            s = s + "ActivationDate," + Constants.vbCrLf;
            s = s + "InstallDate," + Constants.vbCrLf;
            s = s + "CustomerID," + Constants.vbCrLf;
            s = s + "CustomerName," + Constants.vbCrLf;
            s = s + "XrtNxr1," + Constants.vbCrLf;
            s = s + "SqlServerInstanceName," + Constants.vbCrLf;
            s = s + "SqlServerMachineName) values (" + Constants.vbCrLf;
            s = s + "'" + Agreement + "'" + "," + Constants.vbCrLf;
            s = s + VersionNbr + "," + Constants.vbCrLf;
            s = s + "'" + ActivationDate + "'" + "," + Constants.vbCrLf;
            s = s + "'" + InstallDate + "'" + "," + Constants.vbCrLf;
            s = s + "'" + CustomerID + "'" + "," + Constants.vbCrLf;
            s = s + "'" + CustomerName + "'" + "," + Constants.vbCrLf;
            s = s + "'" + XrtNxr1 + "'" + "," + Constants.vbCrLf;
            s = s + "'" + SqlServerInstanceNameX + "'" + "," + Constants.vbCrLf;
            s = s + "'" + SqlServerMachineName + "'" + ")";
            return DBARCH.ExecuteSqlNewConn(s, false);
        }


        // ** Generate the UPDATE method 
        public bool Update(string WhereClause)
        {
            bool b = false;
            string s = "";
            if (Strings.Len(WhereClause) == 0)
                return false;
            s = s + " update License set ";
            s = s + "Agreement = '" + getAgreement() + "'" + ", ";
            s = s + "VersionNbr = " + getVersionnbr() + ", ";
            s = s + "ActivationDate = '" + getActivationdate() + "'" + ", ";
            s = s + "InstallDate = '" + getInstalldate() + "'" + ", ";
            s = s + "CustomerID = '" + getCustomerid() + "'" + ", ";
            s = s + "CustomerName = '" + getCustomername() + "'" + ", ";
            s = s + "XrtNxr1 = '" + getXrtnxr1() + "'" + ", ";
            s = s + "SqlServerInstanceNameX = '" + getServeridentifier() + "'" + ", ";
            s = s + "SqlServerMachineName = '" + getSqlinstanceidentifier() + "'";
            WhereClause = " " + WhereClause;
            s = s + WhereClause;
            return DBARCH.ExecuteSqlNewConn(s, false);
        }


        // ** Generate the SELECT method 
        public SqlDataReader SelectRecs()
        {
            bool b = false;
            string s = "";
            var rsData = default(SqlDataReader);
            s = s + " SELECT ";
            s = s + "Agreement,";
            s = s + "VersionNbr,";
            s = s + "ActivationDate,";
            s = s + "InstallDate,";
            s = s + "CustomerID,";
            s = s + "CustomerName,";
            s = s + "LicenseID,";
            s = s + "XrtNxr1,";
            s = s + "SqlServerInstanceNameX,";
            s = s + "SqlServerMachineName ";
            s = s + " FROM License";
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
            s = s + "Agreement,";
            s = s + "VersionNbr,";
            s = s + "ActivationDate,";
            s = s + "InstallDate,";
            s = s + "CustomerID,";
            s = s + "CustomerName,";
            s = s + "LicenseID,";
            s = s + "XrtNxr1,";
            s = s + "SqlServerInstanceNameX,";
            s = s + "SqlServerMachineName ";
            s = s + " FROM License";
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
            s = " Delete from License";
            s = s + WhereClause;
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }


        // ** Generate the Zeroize Table method 
        public bool Zeroize()
        {
            bool b = false;
            string s = "";
            s = s + " Delete from License";
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }


        // ** Generate Index Queries 
        public int cnt_PK_License(string LicenseID)
        {
            int B = 0;
            string TBL = "License";
            string WC = "Where LicenseID = " + LicenseID;
            B = DBARCH.iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_PK_License

        // ** Generate Index ROW Queries 
        public SqlDataReader getRow_PK_License(string LicenseID)
        {
            SqlDataReader rsData = null;
            string TBL = "License";
            string WC = "Where LicenseID = " + LicenseID;
            rsData = DBARCH.GetRowByKey(TBL, WC);
            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow_PK_License

        /// Build Index Where Caluses
        public string wc_PK_License(string LicenseID)
        {
            string WC = "Where LicenseID = " + LicenseID;
            return WC;
        }     // ** wc_PK_License

        // ** Generate the SET methods 

    }
}