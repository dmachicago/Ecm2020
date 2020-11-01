using global::System.Data.SqlClient;
using System.Windows.Forms;
using global::Microsoft.VisualBasic;
using MODI;

namespace EcmArchiver
{
    public class clsSAVEDITEMS
    {

        // ** DIM the selected table columns
        private clsDatabaseARCH DBARCH = new clsDatabaseARCH();
        private clsDma DMA = new clsDma();
        private clsUtility UTIL = new clsUtility();
        private clsLogging LOG = new clsLogging();
        private string Userid = "";
        private string SaveName = "";
        private string SaveTypeCode = "";
        private string ValName = "";
        private string ValValue = "";

        // ** Generate the SET methods
        public void setUserid(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Userid' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            Userid = val;
        }

        public void setSavename(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Savename' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            SaveName = val;
        }

        public void setSavetypecode(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Savetypecode' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            SaveTypeCode = val;
        }

        public void setValname(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Valname' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            ValName = val;
        }

        public void setValvalue(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Valvalue' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            ValValue = val;
        }

        // ** Generate the GET methods
        public string getUserid()
        {
            if (Strings.Len(Userid) == 0)
            {
                MessageBox.Show("GET: Field 'Userid' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(Userid);
        }

        public string getSavename()
        {
            if (Strings.Len(SaveName) == 0)
            {
                MessageBox.Show("GET: Field 'Savename' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(SaveName);
        }

        public string getSavetypecode()
        {
            if (Strings.Len(SaveTypeCode) == 0)
            {
                MessageBox.Show("GET: Field 'Savetypecode' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(SaveTypeCode);
        }

        public string getValname()
        {
            if (Strings.Len(ValName) == 0)
            {
                MessageBox.Show("GET: Field 'Valname' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(ValName);
        }

        public string getValvalue()
        {
            if (Strings.Len(ValValue) == 0)
            {
                MessageBox.Show("GET: Field 'Valvalue' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(ValValue);
        }

        // ** Generate the Required Fields Validation method
        public bool ValidateReqData()
        {
            if (Userid.Length == 0)
                return false;
            if (SaveName.Length == 0)
                return false;
            if (SaveTypeCode.Length == 0)
                return false;
            if (ValName.Length == 0)
                return false;
            if (ValValue.Length == 0)
                return false;
            return true;
        }

        // ** Generate the Validation method
        public bool ValidateData()
        {
            if (Userid.Length == 0)
                return false;
            if (SaveName.Length == 0)
                return false;
            if (SaveTypeCode.Length == 0)
                return false;
            if (ValName.Length == 0)
                return false;
            if (ValValue.Length == 0)
                return false;
            return true;
        }

        // ** Generate the INSERT method
        public bool Insert()
        {
            bool b = false;
            string s = "";
            s = s + " INSERT INTO SavedItems(";
            s = s + "Userid,";
            s = s + "SaveName,";
            s = s + "SaveTypeCode,";
            s = s + "ValName,";
            s = s + "ValValue) values (";
            s = s + "'" + Userid + "'" + ",";
            s = s + "'" + SaveName + "'" + ",";
            s = s + "'" + SaveTypeCode + "'" + ",";
            s = s + "'" + ValName + "'" + ",";
            s = s + "'" + ValValue + "'" + ")";
            return DBARCH.ExecuteSqlNewConn(s, false);
        }

        // ** Generate the UPDATE method
        public bool Update(string WhereClause)
        {
            bool b = false;
            string s = "";
            if (Strings.Len(WhereClause) == 0)
                return false;
            s = s + " update SavedItems set ";
            s = s + "Userid = '" + getUserid() + "'" + ", ";
            s = s + "SaveName = '" + getSavename() + "'" + ", ";
            s = s + "SaveTypeCode = '" + getSavetypecode() + "'" + ", ";
            s = s + "ValName = '" + getValname() + "'" + ", ";
            s = s + "ValValue = '" + getValvalue() + "'";
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
            s = s + "Userid,";
            s = s + "SaveName,";
            s = s + "SaveTypeCode,";
            s = s + "ValName,";
            s = s + "ValValue ";
            s = s + " FROM SavedItems";
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
            s = s + "Userid,";
            s = s + "SaveName,";
            s = s + "SaveTypeCode,";
            s = s + "ValName,";
            s = s + "ValValue ";
            s = s + " FROM SavedItems";
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
            s = " Delete from SavedItems";
            s = s + WhereClause;
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }

        // ** Generate the Zeroize Table method
        public bool Zeroize()
        {
            bool b = false;
            string s = "";
            s = s + " Delete from SavedItems";
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }

        // ** Generate Index Queries
        public int cnt_PK_SavedItems(string SaveName, string SaveTypeCode, string Userid, string ValName)
        {
            int B = 0;
            string TBL = "SavedItems";
            string WC = "Where SaveName = '" + SaveName + "' and   SaveTypeCode = '" + SaveTypeCode + "' and   Userid = '" + Userid + "' and   ValName = '" + ValName + "'";
            B = DBARCH.iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_PK_SavedItems

        // ** Generate Index ROW Queries
        public SqlDataReader getRow_PK_SavedItems(string SaveName, string SaveTypeCode, string Userid, string ValName)
        {
            SqlDataReader rsData = null;
            string TBL = "SavedItems";
            string WC = "Where SaveName = '" + SaveName + "' and   SaveTypeCode = '" + SaveTypeCode + "' and   Userid = '" + Userid + "' and   ValName = '" + ValName + "'";
            rsData = DBARCH.GetRowByKey(TBL, WC);
            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow_PK_SavedItems

        /// Build Index Where Caluses
        public string wc_PK_SavedItems(string SaveName, string SaveTypeCode, string Userid, string ValName)
        {
            string WC = "Where SaveName = '" + SaveName + "' and   SaveTypeCode = '" + SaveTypeCode + "' and   Userid = '" + Userid + "' and   ValName = '" + ValName + "'";
            return WC;
        }     // ** wc_PK_SavedItems
    }
}