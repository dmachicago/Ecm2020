using global::System.Data.SqlClient;
using System.Windows.Forms;
using global::Microsoft.VisualBasic;
using MODI;

namespace EcmArchiver
{
    public class clsSOURCETYPE
    {


        // ** DIM the selected table columns 
        private clsDatabaseARCH DBARCH = new clsDatabaseARCH();
        private clsDma DMA = new clsDma();
        private clsUtility UTIL = new clsUtility();
        private clsLogging LOG = new clsLogging();
        private string SourceTypeCode = "";
        private string StoreExternal = "";
        private string SourceTypeDesc = "";
        private string Indexable = "";




        // ** Generate the SET methods 
        public void setSourcetypecode(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Sourcetypecode' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            SourceTypeCode = val;
        }

        public void setStoreexternal(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                val = "null";
            }

            val = UTIL.RemoveSingleQuotes(val);
            StoreExternal = val;
        }

        public void setSourcetypedesc(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            SourceTypeDesc = val;
        }

        public void setIndexable(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                val = "null";
            }

            val = UTIL.RemoveSingleQuotes(val);
            Indexable = val;
        }






        // ** Generate the GET methods 
        public string getSourcetypecode()
        {
            if (Strings.Len(SourceTypeCode) == 0)
            {
                MessageBox.Show("GET: Field 'Sourcetypecode' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(SourceTypeCode);
        }

        public string getStoreexternal()
        {
            if (Strings.Len(StoreExternal) == 0)
            {
                StoreExternal = "null";
            }

            return StoreExternal;
        }

        public string getSourcetypedesc()
        {
            return UTIL.RemoveSingleQuotes(SourceTypeDesc);
        }

        public string getIndexable()
        {
            if (Strings.Len(Indexable) == 0)
            {
                Indexable = "null";
            }

            return Indexable;
        }






        // ** Generate the Required Fields Validation method 
        public bool ValidateReqData()
        {
            if (SourceTypeCode.Length == 0)
                return false;
            return true;
        }




        // ** Generate the Validation method 
        public bool ValidateData()
        {
            if (SourceTypeCode.Length == 0)
                return false;
            return true;
        }

        // ** Generate the INSERT method 
        public bool Insert()
        {
            bool b = false;
            string s = "";
            s = s + " INSERT INTO SourceType(";
            s = s + "SourceTypeCode,";
            s = s + "StoreExternal,";
            s = s + "SourceTypeDesc,";
            s = s + "Indexable) values (";
            s = s + "'" + SourceTypeCode + "'" + ",";
            s = s + StoreExternal + ",";
            s = s + "'" + SourceTypeDesc + "'" + ",";
            s = s + Indexable + ")";
            b = DBARCH.ExecuteSqlNewConn(s, false);
            if (!b)
            {
                LOG.WriteToArchiveLog("clsSOURCETYPE : Insert : 01 : " + "ERROR: An unknown file type was NOT inserted. The SQL is: " + s);
                LOG.WriteToArchiveLog("clsSOURCETYPE : Insert : 01 : " + "ERROR: An unknown file type was NOT inserted. The SQL is: " + s);
            }

            return b;
        }


        // ** Generate the UPDATE method 
        public bool Update(string WhereClause)
        {
            bool b = false;
            string s = "";
            if (Strings.Len(WhereClause) == 0)
                return false;
            s = s + " update SourceType set ";
            // s = s + "SourceTypeCode = '" + getSourcetypecode() + "'" + ", "
            s = s + "StoreExternal = " + getStoreexternal() + ", ";
            s = s + "SourceTypeDesc = '" + getSourcetypedesc() + "'" + ", ";
            s = s + "Indexable = " + getIndexable();
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
            s = s + "SourceTypeCode,";
            s = s + "StoreExternal,";
            s = s + "SourceTypeDesc,";
            s = s + "Indexable ";
            s = s + " FROM SourceType";
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
            s = s + "SourceTypeCode,";
            s = s + "StoreExternal,";
            s = s + "SourceTypeDesc,";
            s = s + "Indexable ";
            s = s + " FROM SourceType";
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
            s = " Delete from SourceType";
            s = s + WhereClause;
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }




        // ** Generate the Zeroize Table method 
        public bool Zeroize()
        {
            bool b = false;
            string s = "";
            s = s + " Delete from SourceType";
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }




        // ** Generate Index Queries 
        public int cnt_PK34(string SourceTypeCode)
        {
            int B = 0;
            string TBL = "SourceType";
            string WC = "Where SourceTypeCode = '" + SourceTypeCode + "'";
            B = DBARCH.iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_PK34


        // ** Generate Index ROW Queries 
        public SqlDataReader getRow_PK34(string SourceTypeCode)
        {
            SqlDataReader rsData = null;
            string TBL = "SourceType";
            string WC = "Where SourceTypeCode = '" + SourceTypeCode + "'";
            rsData = DBARCH.GetRowByKey(TBL, WC);
            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow_PK34


        /// Build Index Where Caluses
        public string wc_PK34(string SourceTypeCode)
        {
            string WC = "Where SourceTypeCode = '" + SourceTypeCode + "'";
            return WC;
        }     // ** wc_PK34
    }
}