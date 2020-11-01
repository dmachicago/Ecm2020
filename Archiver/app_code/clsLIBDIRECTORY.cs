using global::System.Data.SqlClient;
using System.Windows.Forms;
using global::Microsoft.VisualBasic;
using MODI;

namespace EcmArchiver
{
    public class clsLIBDIRECTORY
    {


        // ** DIM the selected table columns 
        private clsDatabaseARCH DBARCH = new clsDatabaseARCH();
        private clsDma DMA = new clsDma();
        private clsUtility UTIL = new clsUtility();
        private clsLogging LOG = new clsLogging();
        private string DirectoryName = "";
        private string UserID = "";
        private string LibraryName = "";




        // ** Generate the SET methods 
        public void setDirectoryname(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                if (modGlobals.gRunUnattended == false)
                    MessageBox.Show("SET: Field 'Directoryname' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            DirectoryName = val;
        }

        public void setUserid(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                if (modGlobals.gRunUnattended == false)
                    MessageBox.Show("SET: Field 'Userid' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            UserID = val;
        }

        public void setLibraryname(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                if (modGlobals.gRunUnattended == false)
                    MessageBox.Show("SET: Field 'Libraryname' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            LibraryName = val;
        }

        // ** Generate the GET methods 
        public string getDirectoryname()
        {
            if (Strings.Len(DirectoryName) == 0)
            {
                if (modGlobals.gRunUnattended == false)
                {
                    if (modGlobals.gRunUnattended == false)
                        MessageBox.Show("GET: Field 'Directoryname' cannot be NULL.");
                }

                return "";
            }

            return UTIL.RemoveSingleQuotes(DirectoryName);
        }

        public string getUserid()
        {
            if (Strings.Len(UserID) == 0)
            {
                if (modGlobals.gRunUnattended == false)
                {
                    if (modGlobals.gRunUnattended == false)
                        MessageBox.Show("GET: Field 'Userid' cannot be NULL.");
                }

                return "";
            }

            return UTIL.RemoveSingleQuotes(UserID);
        }

        public string getLibraryname()
        {
            if (Strings.Len(LibraryName) == 0)
            {
                if (modGlobals.gRunUnattended == false)
                {
                    if (modGlobals.gRunUnattended == false)
                        MessageBox.Show("GET: Field 'Libraryname' cannot be NULL.");
                }

                return "";
            }

            return UTIL.RemoveSingleQuotes(LibraryName);
        }






        // ** Generate the Required Fields Validation method 
        public bool ValidateReqData()
        {
            if (DirectoryName.Length == 0)
                return false;
            if (UserID.Length == 0)
                return false;
            if (LibraryName.Length == 0)
                return false;
            return true;
        }




        // ** Generate the Validation method 
        public bool ValidateData()
        {
            if (DirectoryName.Length == 0)
                return false;
            if (UserID.Length == 0)
                return false;
            if (LibraryName.Length == 0)
                return false;
            return true;
        }




        // ** Generate the INSERT method 
        public bool Insert()
        {
            bool b = false;
            string s = "";
            s = s + " INSERT INTO LibDirectory(";
            s = s + "DirectoryName,";
            s = s + "UserID,";
            s = s + "LibraryName) values (";
            s = s + "'" + DirectoryName + "'" + ",";
            s = s + "'" + UserID + "'" + ",";
            s = s + "'" + LibraryName + "'" + ")";
            return DBARCH.ExecuteSqlNewConn(s, false);
        }




        // ** Generate the UPDATE method 
        public bool Update(string WhereClause)
        {
            bool b = false;
            string s = "";
            if (Strings.Len(WhereClause) == 0)
                return false;
            s = s + " update LibDirectory set ";
            s = s + "DirectoryName = '" + getDirectoryname() + "'" + ", ";
            s = s + "UserID = '" + getUserid() + "'" + ", ";
            s = s + "LibraryName = '" + getLibraryname() + "'";
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
            s = s + "DirectoryName,";
            s = s + "UserID,";
            s = s + "LibraryName ";
            s = s + " FROM LibDirectory";
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
            s = s + "DirectoryName,";
            s = s + "UserID,";
            s = s + "LibraryName ";
            s = s + " FROM LibDirectory";
            s = s + WhereClause;
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
            s = " Delete from LibDirectory";
            s = s + WhereClause;
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }




        // ** Generate the Zeroize Table method 
        public bool Zeroize()
        {
            bool b = false;
            string s = "";
            s = s + " Delete from LibDirectory";
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }




        // ** Generate Index Queries 
        public int cnt_PK98(string DirectoryName, string LibraryName, string UserID)
        {
            int B = 0;
            string TBL = "LibDirectory";
            string WC = "Where DirectoryName = '" + DirectoryName + "' and   LibraryName = '" + LibraryName + "' and   UserID = '" + UserID + "'";
            B = DBARCH.iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_PK98


        // ** Generate Index ROW Queries 
        public SqlDataReader getRow_PK98(string DirectoryName, string LibraryName, string UserID)
        {
            SqlDataReader rsData = null;
            string TBL = "LibDirectory";
            string WC = "Where DirectoryName = '" + DirectoryName + "' and   LibraryName = '" + LibraryName + "' and   UserID = '" + UserID + "'";
            rsData = DBARCH.GetRowByKey(TBL, WC);
            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow_PK98


        /// Build Index Where Caluses
        public string wc_PK98(string DirectoryName, string LibraryName, string UserID)
        {


            // Dim WC  = "Where DirectoryName = '" + DirectoryName + "' and   LibraryName = '" + LibraryName + "' and   UserID = '" + UserID + "'"
            string WC = "Where DirectoryName = '" + DirectoryName + "' and   LibraryName = '" + LibraryName + "' ";
            return WC;
        }     // ** wc_PK98


        // ** Generate the SET methods 


    }
}