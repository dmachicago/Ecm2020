using global::System.Data.SqlClient;
using System.Windows.Forms;
using global::Microsoft.VisualBasic;
using MODI;

namespace EcmArchiver
{
    public class clsAVAILFILETYPESUNDEFINED : clsDatabaseARCH
    {
        // ** DIM the selected table columns 
        // Dim DBARCH As New clsDatabaseARCH
        private clsDma DMA = new clsDma();
        private clsUtility UTIL = new clsUtility();
        private clsLogging LOG = new clsLogging();
        private string FileType = "";
        private string SubstituteType = "";
        private string Applied = "";


        // ** Generate the SET methods 
        public void setFiletype(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Filetype' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            FileType = val;
        }

        public void setSubstitutetype(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            SubstituteType = val;
        }

        public void setApplied(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                val = "null";
            }

            val = UTIL.RemoveSingleQuotes(val);
            Applied = val;
        }



        // ** Generate the GET methods 
        public string getFiletype()
        {
            if (Strings.Len(FileType) == 0)
            {
                MessageBox.Show("GET: Field 'Filetype' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(FileType);
        }

        public string getSubstitutetype()
        {
            return UTIL.RemoveSingleQuotes(SubstituteType);
        }

        public string getApplied()
        {
            if (Strings.Len(Applied) == 0)
            {
                Applied = "null";
            }

            return Applied;
        }



        // ** Generate the Required Fields Validation method 
        public bool ValidateReqData()
        {
            if (FileType.Length == 0)
                return false;
            return true;
        }


        // ** Generate the Validation method 
        public bool ValidateData()
        {
            if (FileType.Length == 0)
                return false;
            return true;
        }


        // ** Generate the INSERT method 
        public bool Insert()
        {
            bool b = false;
            string s = "";
            s = s + " INSERT INTO AvailFileTypesUndefined(";
            s = s + "FileType,";
            s = s + "SubstituteType,";
            s = s + "Applied) values (";
            s = s + "'" + FileType + "'" + ",";
            s = s + "'" + SubstituteType + "'" + ",";
            s = s + Applied + ")";
            return ExecuteSqlNewConn(s, false);
        }


        // ** Generate the UPDATE method 
        public bool Update(string WhereClause)
        {
            bool b = false;
            string s = "";
            if (Strings.Len(WhereClause) == 0)
                return false;
            s = s + " update AvailFileTypesUndefined set ";
            s = s + "FileType = '" + getFiletype() + "'" + ", ";
            s = s + "SubstituteType = '" + getSubstitutetype() + "'" + ", ";
            s = s + "Applied = " + getApplied();
            WhereClause = " " + WhereClause;
            s = s + WhereClause;
            return ExecuteSqlNewConn(s, false);
        }


        // ** Generate the SELECT method 
        public SqlDataReader SelectRecs()
        {
            bool b = false;
            string s = "";
            SqlDataReader rsData;
            s = s + " SELECT ";
            s = s + "FileType,";
            s = s + "SubstituteType,";
            s = s + "Applied ";
            s = s + " FROM AvailFileTypesUndefined";
            string CS = setConnStr();
            var CONN = new SqlConnection(CS);
            CONN.Open();
            var command = new SqlCommand(s, CONN);
            rsData = command.ExecuteReader();
            return rsData;
        }


        // ** Generate the Select One Row method 
        public SqlDataReader SelectOne(string WhereClause)
        {
            bool b = false;
            string s = "";
            SqlDataReader rsData;
            s = s + " SELECT ";
            s = s + "FileType,";
            s = s + "SubstituteType,";
            s = s + "Applied ";
            s = s + " FROM AvailFileTypesUndefined";
            s = s + WhereClause;
            string CS = setConnStr();
            var CONN = new SqlConnection(CS);
            CONN.Open();
            var command = new SqlCommand(s, CONN);
            rsData = command.ExecuteReader();
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
            s = " Delete from AvailFileTypesUndefined";
            s = s + WhereClause;
            b = ExecuteSqlNewConn(s, false);
            return b;
        }


        // ** Generate the Zeroize Table method 
        public bool Zeroize()
        {
            bool b = false;
            string s = "";
            s = s + " Delete from AvailFileTypesUndefined";
            b = ExecuteSqlNewConn(s, false);
            return b;
        }


        // ** Generate Index Queries 
        public int cnt_PK_AFTU(string FileType)
        {
            int B = 0;
            string TBL = "AvailFileTypesUndefined";
            string WC = "Where FileType = '" + FileType + "'";
            B = iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_PK_AFTU

        // ** Generate Index ROW Queries 
        public SqlDataReader getRow_PK_AFTU(string FileType)
        {
            SqlDataReader rsData = null;
            string TBL = "AvailFileTypesUndefined";
            string WC = "Where FileType = '" + FileType + "'";
            rsData = GetRowByKey(TBL, WC);
            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow_PK_AFTU

        /// Build Index Where Caluses
        public string wc_PK_AFTU(string FileType)
        {
            string WC = "Where FileType = '" + FileType + "'";
            return WC;
        }     // ** wc_PK_AFTU
    }
}