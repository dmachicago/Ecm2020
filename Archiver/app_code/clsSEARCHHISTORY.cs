using global::System;
using global::System.Data.SqlClient;
using global::Microsoft.VisualBasic;
using MODI;

namespace EcmArchiver
{
    public class clsSEARCHHISTORY
    {

        // ** DIM the selected table columns 
        private clsDatabaseARCH DBARCH = new clsDatabaseARCH();
        private clsDma DMA = new clsDma();
        private clsUtility UTIL = new clsUtility();
        private clsLogging LOG = new clsLogging();
        private string SearchSql = "";
        private string SearchDate = "";
        private string UserID = "";
        private string RowID = "";
        private string ReturnedRows = "";
        private string StartTime = "";
        private string EndTime = "";
        private string CalledFrom = "";
        private string TypeSearch = "";


        // ** Generate the SET methods 
        public void setSearchsql(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            SearchSql = val;
        }

        public void setSearchdate(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            SearchDate = val;
        }

        public void setUserid(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            UserID = val;
        }

        public void setReturnedrows(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                val = "null";
            }

            val = UTIL.RemoveSingleQuotes(val);
            ReturnedRows = val;
        }

        public void setStarttime(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            StartTime = val;
        }

        public void setEndtime(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            EndTime = val;
        }

        public void setCalledfrom(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            CalledFrom = val;
        }

        public void setTypesearch(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            TypeSearch = val;
        }



        // ** Generate the GET methods 
        public string getSearchsql()
        {
            return UTIL.RemoveSingleQuotes(SearchSql);
        }

        public string getSearchdate()
        {
            return UTIL.RemoveSingleQuotes(SearchDate);
        }

        public string getUserid()
        {
            return UTIL.RemoveSingleQuotes(UserID);
        }

        // Public Function getRowid() As String
        // If Len(RowID) = 0 Then
        // messagebox.show("GET: Field 'Rowid' cannot be NULL.")
        // Return ""
        // End If
        // If Len(RowID) = 0 Then
        // RowID = "null"
        // End If
        // Return RowID
        // End Function

        public string getReturnedrows()
        {
            if (Strings.Len(ReturnedRows) == 0)
            {
                ReturnedRows = "null";
            }

            return ReturnedRows;
        }

        public string getStarttime()
        {
            return UTIL.RemoveSingleQuotes(StartTime);
        }

        public string getEndtime()
        {
            return UTIL.RemoveSingleQuotes(EndTime);
        }

        public string getCalledfrom()
        {
            return UTIL.RemoveSingleQuotes(CalledFrom);
        }

        public string getTypesearch()
        {
            return UTIL.RemoveSingleQuotes(TypeSearch);
        }



        // ** Generate the Required Fields Validation method 
        // Public Function ValidateReqData() As Boolean
        // If RowID.Length = 0 Then Return False
        // Return True
        // End Function


        // ** Generate the Validation method 
        public bool ValidateData()
        {
            return true;
        }


        // ** Generate the INSERT method 
        public bool Insert()
        {
            bool b = false;
            string s = "";
            if (ReturnedRows.Length == 0)
            {
                ReturnedRows = "-1";
            }

            s = s + " INSERT INTO SearchHistory(";
            s = s + "SearchSql,";
            s = s + "SearchDate,";
            s = s + "UserID,";
            s = s + "ReturnedRows,";
            s = s + "StartTime,";
            s = s + "EndTime,";
            s = s + "CalledFrom,";
            s = s + "TypeSearch) values (";
            s = s + "'" + SearchSql + "'" + ",";
            s = s + "'" + SearchDate + "'" + ",";
            s = s + "'" + UserID + "'" + ",";
            // s = s + RowID + ","
            s = s + ReturnedRows + ",";
            s = s + "'" + StartTime + "'" + ",";
            s = s + "'" + EndTime + "'" + ",";
            s = s + "'" + CalledFrom + "'" + ",";
            s = s + "'" + TypeSearch + "'" + ")";
            b = DBARCH.ExecuteSqlNewConn(s, false);
            if (b == false)
            {
                Console.WriteLine("Error clsSearchHistory Insert");
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
            s = s + " update SearchHistory set ";
            s = s + "SearchSql = '" + getSearchsql() + "'" + ", ";
            s = s + "SearchDate = '" + getSearchdate() + "'" + ", ";
            s = s + "UserID = '" + getUserid() + "'" + ", ";
            s = s + "ReturnedRows = " + getReturnedrows() + ", ";
            s = s + "StartTime = '" + getStarttime() + "'" + ", ";
            s = s + "EndTime = '" + getEndtime() + "'" + ", ";
            s = s + "CalledFrom = '" + getCalledfrom() + "'" + ", ";
            s = s + "TypeSearch = '" + getTypesearch() + "'";
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
            s = s + "SearchSql,";
            s = s + "SearchDate,";
            s = s + "UserID,";
            s = s + "RowID,";
            s = s + "ReturnedRows,";
            s = s + "StartTime,";
            s = s + "EndTime,";
            s = s + "CalledFrom,";
            s = s + "TypeSearch ";
            s = s + " FROM SearchHistory";
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
            s = s + "SearchSql,";
            s = s + "SearchDate,";
            s = s + "UserID,";
            s = s + "RowID,";
            s = s + "ReturnedRows,";
            s = s + "StartTime,";
            s = s + "EndTime,";
            s = s + "CalledFrom,";
            s = s + "TypeSearch ";
            s = s + " FROM SearchHistory";
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
            s = " Delete from SearchHistory";
            s = s + WhereClause;
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }


        // ** Generate the Zeroize Table method 
        public bool Zeroize()
        {
            bool b = false;
            string s = "";
            s = s + " Delete from SearchHistory";
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }


        // ** Generate Index Queries 
        public int cnt_PK_SearchHist(int RowID)
        {
            int B = 0;
            string TBL = "SearchHistory";
            string WC = "Where RowID = " + RowID;
            B = DBARCH.iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_PK_SearchHist

        // ** Generate Index ROW Queries 
        public SqlDataReader getRow_PK_SearchHist(int RowID)
        {
            SqlDataReader rsData = null;
            string TBL = "SearchHistory";
            string WC = "Where RowID = " + RowID;
            rsData = DBARCH.GetRowByKey(TBL, WC);
            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow_PK_SearchHist

        /// Build Index Where Caluses
        public string wc_PK_SearchHist(int RowID)
        {
            string WC = "Where RowID = " + RowID;
            return WC;
        }     // ** wc_PK_SearchHist

        // ** Generate the SET methods 

    }
}