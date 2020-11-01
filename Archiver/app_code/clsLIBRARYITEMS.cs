using global::System.Collections;
using global::System.Data.SqlClient;
using System.Windows.Forms;
using global::Microsoft.VisualBasic;
using MODI;

namespace EcmArchiver
{
    public class clsLIBRARYITEMS : clsDatabaseARCH
    {

        // ** DIM the selected table columns 
        // Dim DBARCH As New clsDatabaseARCH
        private clsDma DMA = new clsDma();
        private clsUtility UTIL = new clsUtility();
        private clsLogging LOG = new clsLogging();
        private string SourceGuid = "";
        private string ItemTitle = "";
        private string ItemType = "";
        private string LibraryItemGuid = "";
        private string DataSourceOwnerUserID = "";
        private string LibraryOwnerUserID = "";
        private string LibraryName = "";
        private string AddedByUserGuidId = "";

        // ** Generate the SET methods 
        public void setSourceguid(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            SourceGuid = val;
        }

        public void setItemtitle(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            ItemTitle = val;
        }

        public void setItemtype(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            ItemType = val;
        }

        public void setLibraryitemguid(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Libraryitemguid' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            LibraryItemGuid = val;
        }

        public void setDatasourceowneruserid(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            DataSourceOwnerUserID = val;
        }

        public void setLibraryowneruserid(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Libraryowneruserid' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            LibraryOwnerUserID = val;
        }

        public void setLibraryname(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Libraryname' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            LibraryName = val;
        }

        public void setAddedbyuserguidid(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            AddedByUserGuidId = val;
        }






        // ** Generate the GET methods 
        public string getSourceguid()
        {
            return UTIL.RemoveSingleQuotes(SourceGuid);
        }

        public string getItemtitle()
        {
            return UTIL.RemoveSingleQuotes(ItemTitle);
        }

        public string getItemtype()
        {
            return UTIL.RemoveSingleQuotes(ItemType);
        }

        public string getLibraryitemguid()
        {
            if (Strings.Len(LibraryItemGuid) == 0)
            {
                MessageBox.Show("GET: Field 'Libraryitemguid' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(LibraryItemGuid);
        }

        public string getDatasourceowneruserid()
        {
            return UTIL.RemoveSingleQuotes(DataSourceOwnerUserID);
        }

        public string getLibraryowneruserid()
        {
            if (Strings.Len(LibraryOwnerUserID) == 0)
            {
                MessageBox.Show("GET: Field 'Libraryowneruserid' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(LibraryOwnerUserID);
        }

        public string getLibraryname()
        {
            if (Strings.Len(LibraryName) == 0)
            {
                MessageBox.Show("GET: Field 'Libraryname' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(LibraryName);
        }

        public string getAddedbyuserguidid()
        {
            return UTIL.RemoveSingleQuotes(AddedByUserGuidId);
        }






        // ** Generate the Required Fields Validation method 
        public bool ValidateReqData()
        {
            if (LibraryItemGuid.Length == 0)
                return false;
            if (LibraryOwnerUserID.Length == 0)
                return false;
            if (LibraryName.Length == 0)
                return false;
            return true;
        }

        // ** Generate the Validation method 
        public bool ValidateData()
        {
            if (LibraryItemGuid.Length == 0)
                return false;
            if (LibraryOwnerUserID.Length == 0)
                return false;
            if (LibraryName.Length == 0)
                return false;
            return true;
        }

        public bool InsertIntoList(ref ArrayList L)
        {
            bool b = false;
            string s = "";
            s = s + " INSERT INTO LibraryItems(";
            s = s + "SourceGuid,";
            s = s + "ItemTitle,";
            s = s + "ItemType,";
            s = s + "LibraryItemGuid,";
            s = s + "DataSourceOwnerUserID,";
            s = s + "LibraryOwnerUserID,";
            s = s + "LibraryName,";
            s = s + "AddedByUserGuidId) values (";
            s = s + "'" + SourceGuid + "'" + ",";
            s = s + "'" + ItemTitle + "'" + ",";
            s = s + "'" + ItemType + "'" + ",";
            s = s + "'" + LibraryItemGuid + "'" + ",";
            s = s + "'" + DataSourceOwnerUserID + "'" + ",";
            s = s + "'" + LibraryOwnerUserID + "'" + ",";
            s = s + "'" + LibraryName + "'" + ",";
            s = s + "'" + AddedByUserGuidId + "'" + ")";
            Application.DoEvents();
            L.Add(s);
            return true;
        }

        public bool Insert(SqlConnection CN)
        {
            bool b = false;
            string s = "";
            s = s + " INSERT INTO LibraryItems(";
            s = s + "SourceGuid,";
            s = s + "ItemTitle,";
            s = s + "ItemType,";
            s = s + "LibraryItemGuid,";
            s = s + "DataSourceOwnerUserID,";
            s = s + "LibraryOwnerUserID,";
            s = s + "LibraryName,";
            s = s + "AddedByUserGuidId) values (";
            s = s + "'" + SourceGuid + "'" + ",";
            s = s + "'" + ItemTitle + "'" + ",";
            s = s + "'" + ItemType + "'" + ",";
            s = s + "'" + LibraryItemGuid + "'" + ",";
            s = s + "'" + DataSourceOwnerUserID + "'" + ",";
            s = s + "'" + LibraryOwnerUserID + "'" + ",";
            s = s + "'" + LibraryName + "'" + ",";
            s = s + "'" + AddedByUserGuidId + "'" + ")";
            Application.DoEvents();
            return ExecuteSqlSameConn(s, CN);
        }

        // ** Generate the INSERT method 
        public bool Insert()
        {
            bool b = false;
            string s = "";
            s = s + " INSERT INTO LibraryItems(";
            s = s + "SourceGuid,";
            s = s + "ItemTitle,";
            s = s + "ItemType,";
            s = s + "LibraryItemGuid,";
            s = s + "DataSourceOwnerUserID,";
            s = s + "LibraryOwnerUserID,";
            s = s + "LibraryName,";
            s = s + "AddedByUserGuidId) values (";
            s = s + "'" + SourceGuid + "'" + ",";
            s = s + "'" + ItemTitle + "'" + ",";
            s = s + "'" + ItemType + "'" + ",";
            s = s + "'" + LibraryItemGuid + "'" + ",";
            s = s + "'" + DataSourceOwnerUserID + "'" + ",";
            s = s + "'" + LibraryOwnerUserID + "'" + ",";
            s = s + "'" + LibraryName + "'" + ",";
            s = s + "'" + AddedByUserGuidId + "'" + ")";
            Application.DoEvents();
            return ExecuteSqlNewConn(s, false);
        }




        // ** Generate the UPDATE method 
        public bool Update(string WhereClause)
        {
            bool b = false;
            string s = "";
            if (Strings.Len(WhereClause) == 0)
                return false;
            s = s + " update LibraryItems set ";
            s = s + "SourceGuid = '" + getSourceguid() + "'" + ", ";
            s = s + "ItemTitle = '" + getItemtitle() + "'" + ", ";
            s = s + "ItemType = '" + getItemtype() + "'" + ", ";
            s = s + "LibraryItemGuid = '" + getLibraryitemguid() + "'" + ", ";
            s = s + "DataSourceOwnerUserID = '" + getDatasourceowneruserid() + "'" + ", ";
            s = s + "LibraryOwnerUserID = '" + getLibraryowneruserid() + "'" + ", ";
            s = s + "LibraryName = '" + getLibraryname() + "'" + ", ";
            s = s + "AddedByUserGuidId = '" + getAddedbyuserguidid() + "'";
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
            s = s + "SourceGuid,";
            s = s + "ItemTitle,";
            s = s + "ItemType,";
            s = s + "LibraryItemGuid,";
            s = s + "DataSourceOwnerUserID,";
            s = s + "LibraryOwnerUserID,";
            s = s + "LibraryName,";
            s = s + "AddedByUserGuidId ";
            s = s + " FROM LibraryItems";
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
            s = s + "SourceGuid,";
            s = s + "ItemTitle,";
            s = s + "ItemType,";
            s = s + "LibraryItemGuid,";
            s = s + "DataSourceOwnerUserID,";
            s = s + "LibraryOwnerUserID,";
            s = s + "LibraryName,";
            s = s + "AddedByUserGuidId ";
            s = s + " FROM LibraryItems";
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
            s = " Delete from LibraryItems";
            s = s + WhereClause;
            b = ExecuteSqlNewConn(s, false);
            return b;
        }




        // ** Generate the Zeroize Table method 
        public bool Zeroize()
        {
            bool b = false;
            string s = "";
            s = s + " Delete from LibraryItems";
            b = ExecuteSqlNewConn(s, false);
            return b;
        }




        // ** Generate Index Queries 
        public int cnt_PI01_LibItems(string ItemTitle)
        {
            int B = 0;
            string TBL = "LibraryItems";
            string WC = "Where ItemTitle = '" + ItemTitle + "'";
            B = iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_PI01_LibItems

        public int cnt_PK89(string LibraryItemGuid, string LibraryName, string LibraryOwnerUserID)
        {
            int B = 0;
            string TBL = "LibraryItems";
            string WC = "Where LibraryItemGuid = '" + LibraryItemGuid + "' and   LibraryName = '" + LibraryName + "' and   LibraryOwnerUserID = '" + LibraryOwnerUserID + "'";
            B = iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_PK89

        public int cnt_UI_LibItems(string LibraryName, string SourceGuid)
        {
            int B = 0;
            string TBL = "LibraryItems";
            string WC = "Where LibraryName = '" + LibraryName + "' and   SourceGuid = '" + SourceGuid + "'";
            B = iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_UI_LibItems

        public int cnt_UK_LibItems(string LibraryItemGuid)
        {
            int B = 0;
            string TBL = "LibraryItems";
            string WC = "Where LibraryItemGuid = '" + LibraryItemGuid + "'";
            B = iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_UK_LibItems

        public int cnt_UniqueEntry(string LibraryName, string SourceGuid)
        {
            LibraryName = UTIL.RemoveSingleQuotes(LibraryName);
            int B = 0;
            string TBL = "LibraryItems";
            string WC = "Where LibraryName = '" + LibraryName + "' and SourceGuid = '" + SourceGuid + "' ";
            B = iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_UK_LibItems


        // ** Generate Index ROW Queries 
        public SqlDataReader getRow_PI01_LibItems(string ItemTitle)
        {
            SqlDataReader rsData = null;
            string TBL = "LibraryItems";
            string WC = "Where ItemTitle = '" + ItemTitle + "'";
            rsData = GetRowByKey(TBL, WC);
            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow_PI01_LibItems

        public SqlDataReader getRow_PK89(string LibraryItemGuid, string LibraryName, string LibraryOwnerUserID)
        {
            SqlDataReader rsData = null;
            string TBL = "LibraryItems";
            string WC = "Where LibraryItemGuid = '" + LibraryItemGuid + "' and   LibraryName = '" + LibraryName + "' and   LibraryOwnerUserID = '" + LibraryOwnerUserID + "'";
            rsData = GetRowByKey(TBL, WC);
            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow_PK89

        public SqlDataReader getRow_UI_LibItems(string LibraryName, string SourceGuid)
        {
            SqlDataReader rsData = null;
            string TBL = "LibraryItems";
            string WC = "Where LibraryName = '" + LibraryName + "' and   SourceGuid = '" + SourceGuid + "'";
            rsData = GetRowByKey(TBL, WC);
            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow_UI_LibItems

        public SqlDataReader getRow_UK_LibItems(string LibraryItemGuid)
        {
            SqlDataReader rsData = null;
            string TBL = "LibraryItems";
            string WC = "Where LibraryItemGuid = '" + LibraryItemGuid + "'";
            rsData = GetRowByKey(TBL, WC);
            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow_UK_LibItems


        /// Build Index Where Caluses
        public string wc_PI01_LibItems(string ItemTitle)
        {
            string WC = "Where ItemTitle = '" + ItemTitle + "'";
            return WC;
        }     // ** wc_PI01_LibItems

        public string wc_PK89(string LibraryItemGuid, string LibraryName, string LibraryOwnerUserID)
        {
            string WC = "Where LibraryItemGuid = '" + LibraryItemGuid + "' and   LibraryName = '" + LibraryName + "' and   LibraryOwnerUserID = '" + LibraryOwnerUserID + "'";
            return WC;
        }     // ** wc_PK89

        public string wc_UI_LibItems(string LibraryName, string SourceGuid)
        {
            string WC = "Where LibraryName = '" + LibraryName + "' and   SourceGuid = '" + SourceGuid + "'";
            return WC;
        }     // ** wc_UI_LibItems

        public string wc_UK_LibItems(string LibraryItemGuid)
        {
            string WC = "Where LibraryItemGuid = '" + LibraryItemGuid + "'";
            return WC;
        }     // ** wc_UK_LibItems


        // ** Generate the SET methods 


    }
}