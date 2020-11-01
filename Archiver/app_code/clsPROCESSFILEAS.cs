﻿using global::System.Data.SqlClient;
using System.Windows.Forms;
using global::Microsoft.VisualBasic;
using MODI;

namespace EcmArchiver
{
    public class clsPROCESSFILEAS
    {


        // ** DIM the selected table columns 
        private clsDatabaseARCH DBARCH = new clsDatabaseARCH();
        private clsDma DMA = new clsDma();
        private clsUtility UTIL = new clsUtility();
        private clsLogging LOG = new clsLogging();
        private string ExtCode = "";
        private string ProcessExtCode = "";
        private string Applied = "";




        // ** Generate the SET methods 
        public void setExtcode(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Extcode' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            ExtCode = val;
        }

        public void setProcessextcode(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Processextcode' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            ProcessExtCode = val;
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
        public string getExtcode()
        {
            if (Strings.Len(ExtCode) == 0)
            {
                MessageBox.Show("GET: Field 'Extcode' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(ExtCode);
        }

        public string getProcessextcode()
        {
            if (Strings.Len(ProcessExtCode) == 0)
            {
                MessageBox.Show("GET: Field 'Processextcode' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(ProcessExtCode);
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
            if (ExtCode.Length == 0)
                return false;
            if (ProcessExtCode.Length == 0)
                return false;
            return true;
        }




        // ** Generate the Validation method 
        public bool ValidateData()
        {
            if (ExtCode.Length == 0)
                return false;
            if (ProcessExtCode.Length == 0)
                return false;
            return true;
        }




        // ** Generate the INSERT method 
        public bool Insert()
        {
            bool b = false;
            string s = "";
            s = s + " INSERT INTO ProcessFileAs(";
            s = s + "ExtCode,";
            s = s + "ProcessExtCode,";
            s = s + "Applied) values (";
            s = s + "'" + ExtCode + "'" + ",";
            s = s + "'" + ProcessExtCode + "'" + ",";
            s = s + Applied + ")";
            return DBARCH.ExecuteSqlNewConn(s, false);
        }




        // ** Generate the UPDATE method 
        public bool Update(string WhereClause)
        {
            bool b = false;
            string s = "";
            if (Strings.Len(WhereClause) == 0)
                return false;
            s = s + " update ProcessFileAs set ";
            s = s + "ExtCode = '" + getExtcode() + "'" + ", ";
            s = s + "ProcessExtCode = '" + getProcessextcode() + "'" + ", ";
            s = s + "Applied = " + getApplied();
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
            s = s + "ExtCode,";
            s = s + "ProcessExtCode,";
            s = s + "Applied ";
            s = s + " FROM ProcessFileAs";
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
            s = s + "ExtCode,";
            s = s + "ProcessExtCode,";
            s = s + "Applied ";
            s = s + " FROM ProcessFileAs";
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
            s = " Delete from ProcessFileAs";
            s = s + WhereClause;
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }




        // ** Generate the Zeroize Table method 
        public bool Zeroize()
        {
            bool b = false;
            string s = "";
            s = s + " Delete from ProcessFileAs";
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }




        // ** Generate Index Queries 
        public int cnt_PK__ProcessFileAs__5887175A(string ExtCode)
        {
            int B = 0;
            string TBL = "ProcessFileAs";
            string WC = "Where ExtCode = '" + ExtCode + "'";
            B = DBARCH.iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_PK__ProcessFileAs__5887175A

        public int cnt_PK_00_ProcessFileAs(string ExtCode)
        {
            int B = 0;
            string TBL = "ProcessFileAs";
            string WC = "Where ExtCode = '" + ExtCode + "'";
            B = DBARCH.iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_PK_00_ProcessFileAs


        // ** Generate Index ROW Queries 
        public SqlDataReader getRow_PK__ProcessFileAs__5887175A(string ExtCode)
        {
            SqlDataReader rsData = null;
            string TBL = "ProcessFileAs";
            string WC = "Where ExtCode = '" + ExtCode + "'";
            rsData = DBARCH.GetRowByKey(TBL, WC);
            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow_PK__ProcessFileAs__5887175A

        public SqlDataReader getRow_PK_00_ProcessFileAs(string ExtCode)
        {
            SqlDataReader rsData = null;
            string TBL = "ProcessFileAs";
            string WC = "Where ExtCode = '" + ExtCode + "'";
            rsData = DBARCH.GetRowByKey(TBL, WC);
            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow_PK_00_ProcessFileAs


        /// Build Index Where Caluses
        public string wc_PK__ProcessFileAs__5887175A(string ExtCode)
        {
            string WC = "Where ExtCode = '" + ExtCode + "'";
            return WC;
        }     // ** wc_PK__ProcessFileAs__5887175A

        public string wc_PK_00_ProcessFileAs(string ExtCode)
        {
            string WC = "Where ExtCode = '" + ExtCode + "'";
            return WC;
        }     // ** wc_PK_00_ProcessFileAs


        // ** Generate the SET methods 


    }
}