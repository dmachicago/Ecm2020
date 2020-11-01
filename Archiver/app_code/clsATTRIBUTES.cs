using global::System.Data.SqlClient;
using System.Windows.Forms;
using global::Microsoft.VisualBasic;
using MODI;

namespace EcmArchiver
{
    public class clsATTRIBUTES
    {

        // ** DIM the selected table columns
        private clsDatabaseARCH DBARCH = new clsDatabaseARCH();
        private clsDma DMA = new clsDma();
        private clsUtility UTIL = new clsUtility();
        private clsLogging LOG = new clsLogging();
        private string AttributeName = "";
        private string AttributeDataType = "";
        private string AttributeDesc = "";
        private string AssoApplication = "";
        private string AllowedValues = "";

        // ** Generate the SET methods
        public void setAttributename(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Attributename' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            AttributeName = val;
        }

        public void setAttributedatatype(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Attributedatatype' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            AttributeDataType = val;
        }

        public void setAttributedesc(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            AttributeDesc = val;
        }

        public void setAssoapplication(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            AssoApplication = val;
        }

        public void setAllowedvalues(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            AllowedValues = val;
        }

        // ** Generate the GET methods
        public string getAttributename()
        {
            if (Strings.Len(AttributeName) == 0)
            {
                MessageBox.Show("GET: Field 'Attributename' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(AttributeName);
        }

        public string getAttributedatatype()
        {
            if (Strings.Len(AttributeDataType) == 0)
            {
                MessageBox.Show("GET: Field 'Attributedatatype' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(AttributeDataType);
        }

        public string getAttributedesc()
        {
            return UTIL.RemoveSingleQuotes(AttributeDesc);
        }

        public string getAssoapplication()
        {
            return UTIL.RemoveSingleQuotes(AssoApplication);
        }

        public string getAllowedvalues()
        {
            return UTIL.RemoveSingleQuotes(AllowedValues);
        }

        // ** Generate the Required Fields Validation method
        public bool ValidateReqData()
        {
            if (AttributeName.Length == 0)
                return false;
            if (AttributeDataType.Length == 0)
                return false;
            return true;
        }

        // ** Generate the Validation method
        public bool ValidateData()
        {
            if (AttributeName.Length == 0)
                return false;
            if (AttributeDataType.Length == 0)
                return false;
            return true;
        }

        // ** Generate the INSERT method
        public bool Insert()
        {
            bool b = false;
            string s = "";
            s = s + " INSERT INTO Attributes(";
            s = s + "AttributeName,";
            s = s + "AttributeDataType,";
            s = s + "AttributeDesc,";
            s = s + "AssoApplication,";
            s = s + "AllowedValues) values (";
            s = s + "'" + AttributeName + "'" + ",";
            s = s + "'" + AttributeDataType + "'" + ",";
            s = s + "'" + AttributeDesc + "'" + ",";
            s = s + "'" + AssoApplication + "'" + ",";
            s = s + "'" + AllowedValues + "'" + ")";
            return DBARCH.ExecuteSqlNewConn(s, false);
        }

        // ** Generate the UPDATE method
        public bool Update(string WhereClause)
        {
            bool b = false;
            string s = "";
            if (Strings.Len(WhereClause) == 0)
                return false;
            s = s + " update Attributes set ";
            // s = s + "AttributeName = '" + getAttributename() + "'" + ", "
            s = s + "AttributeDataType = '" + getAttributedatatype() + "'" + ", ";
            s = s + "AttributeDesc = '" + getAttributedesc() + "'" + ", ";
            s = s + "AssoApplication = '" + getAssoapplication() + "'" + ", ";
            s = s + "AllowedValues = '" + getAllowedvalues() + "'";
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
            s = s + "AttributeName,";
            s = s + "AttributeDataType,";
            s = s + "AttributeDesc,";
            s = s + "AssoApplication,";
            s = s + "AllowedValues ";
            s = s + " FROM Attributes";
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
            s = s + "AttributeName,";
            s = s + "AttributeDataType,";
            s = s + "AttributeDesc,";
            s = s + "AssoApplication,";
            s = s + "AllowedValues ";
            s = s + " FROM Attributes";
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
            s = " Delete from Attributes";
            s = s + WhereClause;
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }

        // ** Generate the Zeroize Table method
        public bool Zeroize()
        {
            bool b = false;
            string s = "";
            s = s + " Delete from Attributes";
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }

        // ** Generate Index Queries
        public int cnt_PK36(string AttributeName)
        {
            int B = 0;
            string TBL = "Attributes";
            string WC = "Where AttributeName = '" + AttributeName + "'";
            B = DBARCH.iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_PK36

        // ** Generate Index ROW Queries
        public SqlDataReader getRow_PK36(string AttributeName)
        {
            SqlDataReader rsData = null;
            string TBL = "Attributes";
            string WC = "Where AttributeName = '" + AttributeName + "'";
            rsData = DBARCH.GetRowByKey(TBL, WC);
            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow_PK36

        /// Build Index Where Caluses
        public string wc_PK36(string AttributeName)
        {
            string WC = "Where AttributeName = '" + AttributeName + "'";
            return WC;
        }     // ** wc_PK36

        // ** Generate the SET methods

    }
}