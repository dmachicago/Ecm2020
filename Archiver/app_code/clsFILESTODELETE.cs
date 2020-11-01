using global::System.Data.SqlClient;
using global::Microsoft.VisualBasic;
using MODI;

namespace EcmArchiver
{
    public class clsFILESTODELETE
    {


        // ** DIM the selected table columns 
        private clsDatabaseARCH DBARCH = new clsDatabaseARCH();
        private clsDma DMA = new clsDma();
        private clsUtility UTIL = new clsUtility();
        private clsDataGrid DG = new clsDataGrid();
        private string UserID = "";
        private string MachineName = "";
        private string FQN = "";
        private string PendingDelete = "";




        // ** Generate the SET methods 
        public void setUserid(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            UserID = val;
        }

        public void setMachinename(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            MachineName = val;
        }

        public void setFqn(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            FQN = val;
        }

        public void setPendingdelete(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                val = "null";
            }

            if (val.Equals("Y"))
                val = "1";
            if (val.Equals("N"))
                val = "0";
            val = UTIL.RemoveSingleQuotes(val);
            PendingDelete = val;
        }






        // ** Generate the GET methods 
        public string getUserid()
        {
            return UTIL.RemoveSingleQuotes(UserID);
        }

        public string getMachinename()
        {
            return UTIL.RemoveSingleQuotes(MachineName);
        }

        public string getFqn()
        {
            return UTIL.RemoveSingleQuotes(FQN);
        }

        public string getPendingdelete()
        {
            if (Strings.Len(PendingDelete) == 0)
            {
                PendingDelete = "null";
            }

            return PendingDelete;
        }






        // ** Generate the Required Fields Validation method 
        public bool ValidateReqData()
        {
            return true;
        }




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
            s = s + " INSERT INTO FilesToDelete(";
            s = s + "UserID,";
            s = s + "MachineName,";
            s = s + "FQN,";
            s = s + "PendingDelete) values (";
            s = s + "'" + UserID + "'" + ",";
            s = s + "'" + MachineName + "'" + ",";
            s = s + "'" + FQN + "'" + ",";
            s = s + PendingDelete + ")";
            return DBARCH.ExecuteSqlNewConn(s, false);
        }




        // ** Generate the UPDATE method 
        public bool Update(string WhereClause)
        {
            bool b = false;
            string s = "";
            if (Strings.Len(WhereClause) == 0)
                return false;
            s = s + " update FilesToDelete set ";
            s = s + "UserID = '" + getUserid() + "'" + ", ";
            s = s + "MachineName = '" + getMachinename() + "'" + ", ";
            s = s + "FQN = '" + getFqn() + "'" + ", ";
            s = s + "PendingDelete = " + getPendingdelete();
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
            s = s + "UserID,";
            s = s + "MachineName,";
            s = s + "FQN,";
            s = s + "PendingDelete ";
            s = s + " FROM FilesToDelete";
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
            s = s + "UserID,";
            s = s + "MachineName,";
            s = s + "FQN,";
            s = s + "PendingDelete ";
            s = s + " FROM FilesToDelete";
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
            s = " Delete from FilesToDelete";
            s = s + WhereClause;
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }




        // ** Generate the Zeroize Table method 
        public bool Zeroize()
        {
            bool b = false;
            string s = "";
            s = s + " Delete from FilesToDelete";
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }




        // ** Generate Index Queries 
        public int cnt_PK_FileToDelete(string FQN, string MachineName, string UserID)
        {
            int B = 0;
            string TBL = "FilesToDelete";
            string WC = "Where FQN = '" + FQN + "' and   MachineName = '" + MachineName + "' and   UserID = '" + UserID + "'";
            B = DBARCH.iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_PK_FileToDelete


        // ** Generate Index ROW Queries 
        public SqlDataReader getRow_PK_FileToDelete(string FQN, string MachineName, string UserID)
        {
            SqlDataReader rsData = null;
            string TBL = "FilesToDelete";
            string WC = "Where FQN = '" + FQN + "' and   MachineName = '" + MachineName + "' and   UserID = '" + UserID + "'";
            rsData = DBARCH.GetRowByKey(TBL, WC);
            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow_PK_FileToDelete


        /// Build Index Where Caluses
        public string wc_PK_FileToDelete(string FQN, string MachineName, string UserID)
        {
            string WC = "Where FQN = '" + FQN + "' and   MachineName = '" + MachineName + "' and   UserID = '" + UserID + "'";
            return WC;
        }     // ** wc_PK_FileToDelete


        // ** Generate the SET methods 


    }
}