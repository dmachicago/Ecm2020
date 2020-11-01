using global::System.Data.SqlClient;
using System.Windows.Forms;
using global::Microsoft.VisualBasic;
using MODI;

namespace EcmArchiver
{
    public class clsATTACHMENTTYPE
    {

        // ** DIM the selected table columns 
        private clsDatabaseARCH DBARCH = new clsDatabaseARCH();
        private clsDma DMA = new clsDma();
        private clsUtility UTIL = new clsUtility();
        private clsLogging LOG = new clsLogging();
        private string AttachmentCode = "";
        private string Description = "";
        private string isZipFormat = "";


        // ** Generate the SET methods 
        public void setAttachmentcode(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Attachmentcode' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            AttachmentCode = val;
        }

        public void setDescription(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            Description = val;
        }

        public void setIszipformat(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                val = "null";
            }

            val = UTIL.RemoveSingleQuotes(val);
            isZipFormat = val;
        }



        // ** Generate the GET methods 
        public string getAttachmentcode()
        {
            if (Strings.Len(AttachmentCode) == 0)
            {
                MessageBox.Show("GET: Field 'Attachmentcode' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(AttachmentCode);
        }

        public string getDescription()
        {
            return UTIL.RemoveSingleQuotes(Description);
        }

        public string getIszipformat()
        {
            if (Strings.Len(isZipFormat) == 0)
            {
                isZipFormat = "null";
            }

            return isZipFormat;
        }



        // ** Generate the Required Fields Validation method 
        public bool ValidateReqData()
        {
            if (AttachmentCode.Length == 0)
                return false;
            return true;
        }


        // ** Generate the Validation method 
        public bool ValidateData()
        {
            if (AttachmentCode.Length == 0)
                return false;
            return true;
        }


        // ** Generate the INSERT method 
        public bool Insert()
        {
            bool b = false;
            string s = "";
            if (AttachmentCode.Trim().Length > 10)
            {
                AttachmentCode = "UKN";
                Description = "Unknown Attachment Type";
            }

            if (isZipFormat.Length == 0)
            {
                isZipFormat = "0";
            }

            s = s + " INSERT INTO AttachmentType(";
            s = s + "AttachmentCode,";
            s = s + "Description,";
            s = s + "isZipFormat) values (";
            s = s + "'" + AttachmentCode + "'" + ",";
            s = s + "'" + Description + "'" + ",";
            s = s + isZipFormat + ")";
            return DBARCH.ExecuteSqlNewConn(s, false);
        }


        // ** Generate the UPDATE method 
        public bool Update(string WhereClause)
        {
            bool b = false;
            string s = "";
            if (Strings.Len(WhereClause) == 0)
                return false;
            s = s + " update AttachmentType set ";
            // s = s + "AttachmentCode = '" + getAttachmentcode() + "'" + ", "
            s = s + "Description = '" + getDescription() + "'" + ", ";
            s = s + "isZipFormat = " + getIszipformat();
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
            s = s + "AttachmentCode,";
            s = s + "Description,";
            s = s + "isZipFormat ";
            s = s + " FROM AttachmentType";
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
            s = s + "AttachmentCode,";
            s = s + "Description,";
            s = s + "isZipFormat ";
            s = s + " FROM AttachmentType";
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
            s = " Delete from AttachmentType";
            s = s + WhereClause;
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }


        // ** Generate the Zeroize Table method 
        public bool Zeroize()
        {
            bool b = false;
            string s = "";
            s = s + " Delete from AttachmentType";
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }


        // ** Generate Index Queries 
        public int cnt_PK29(string AttachmentCode)
        {
            int B = 0;
            string TBL = "AttachmentType";
            string WC = "Where AttachmentCode = '" + AttachmentCode + "'";
            B = DBARCH.iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_PK29

        // ** Generate Index ROW Queries 
        public SqlDataReader getRow_PK29(string AttachmentCode)
        {
            SqlDataReader rsData = null;
            string TBL = "AttachmentType";
            string WC = "Where AttachmentCode = '" + AttachmentCode + "'";
            rsData = DBARCH.GetRowByKey(TBL, WC);
            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow_PK29

        /// Build Index Where Caluses
        public string wc_PK29(string AttachmentCode)
        {
            string WC = "Where AttachmentCode = '" + AttachmentCode + "'";
            return WC;
        }     // ** wc_PK29

        // ** Generate the SET methods 

    }
}