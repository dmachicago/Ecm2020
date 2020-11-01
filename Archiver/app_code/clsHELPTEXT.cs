using global::System.Data.SqlClient;
using System.Windows.Forms;
using global::Microsoft.VisualBasic;
using MODI;

namespace EcmArchiver
{
    public class clsHELPTEXT
    {

        // ** DIM the selected table columns 
        private clsDatabaseARCH DBARCH = new clsDatabaseARCH();
        private clsDma DMA = new clsDma();
        private clsDataGrid DG = new clsDataGrid();
        private clsUtility UTIL = new clsUtility();
        private clsLogging LOG = new clsLogging();
        private string ScreenName = "";
        private string HelpText = "";
        private string WidgetName = "";
        private string WidgetText = "";
        private string DisplayHelpText = "";
        private string LastUpdate = "";
        private string CreateDate = "";
        private string UpdatedBy = "";


        // ** Generate the SET methods 
        public void setScreenname(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Screenname' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            ScreenName = val;
        }

        public void setHelptext(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            HelpText = val;
        }

        public void setWidgetname(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Widgetname' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            WidgetName = val;
        }

        public void setWidgettext(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            WidgetText = val;
        }

        public void setDisplayhelptext(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                val = "null";
            }

            val = UTIL.RemoveSingleQuotes(val);
            DisplayHelpText = val;
        }

        public void setLastupdate(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            LastUpdate = val;
        }

        public void setCreatedate(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            CreateDate = val;
        }

        public void setUpdatedby(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            UpdatedBy = val;
        }



        // ** Generate the GET methods 
        public string getScreenname()
        {
            if (Strings.Len(ScreenName) == 0)
            {
                MessageBox.Show("GET: Field 'Screenname' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(ScreenName);
        }

        public string getHelptext()
        {
            return UTIL.RemoveSingleQuotes(HelpText);
        }

        public string getWidgetname()
        {
            if (Strings.Len(WidgetName) == 0)
            {
                MessageBox.Show("GET: Field 'Widgetname' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(WidgetName);
        }

        public string getWidgettext()
        {
            return UTIL.RemoveSingleQuotes(WidgetText);
        }

        public string getDisplayhelptext()
        {
            if (Strings.Len(DisplayHelpText) == 0)
            {
                DisplayHelpText = "null";
            }

            return DisplayHelpText;
        }

        public string getLastupdate()
        {
            return UTIL.RemoveSingleQuotes(LastUpdate);
        }

        public string getCreatedate()
        {
            return UTIL.RemoveSingleQuotes(CreateDate);
        }

        public string getUpdatedby()
        {
            return UTIL.RemoveSingleQuotes(UpdatedBy);
        }



        // ** Generate the Required Fields Validation method 
        public bool ValidateReqData()
        {
            if (ScreenName.Length == 0)
                return false;
            if (WidgetName.Length == 0)
                return false;
            return true;
        }


        // ** Generate the Validation method 
        public bool ValidateData()
        {
            if (ScreenName.Length == 0)
                return false;
            if (WidgetName.Length == 0)
                return false;
            return true;
        }


        // ** Generate the INSERT method 
        public bool Insert()
        {
            bool b = false;
            if (LastUpdate.Trim().Length == 0)
                LastUpdate = DateAndTime.Now.ToString();
            if (DisplayHelpText.Trim().Length == 0)
                DisplayHelpText = "0";
            string s = "";
            s = s + " INSERT INTO HelpText(";
            s = s + "ScreenName,";
            s = s + "HelpText,";
            s = s + "WidgetName,";
            s = s + "WidgetText,";
            s = s + "DisplayHelpText,";
            s = s + "LastUpdate,";
            s = s + "UpdatedBy) values (";
            s = s + "'" + ScreenName + "'" + ",";
            s = s + "'" + HelpText + "'" + ",";
            s = s + "'" + WidgetName + "'" + ",";
            s = s + "'" + WidgetText + "'" + ",";
            s = s + DisplayHelpText + ",";
            s = s + "'" + LastUpdate + "'" + ",";
            s = s + "'" + UpdatedBy + "'" + ")";
            return DBARCH.ExecuteSqlNewConn(s, false);
        }

        public bool InsertRemote(string ConnStr)
        {
            bool b = false;
            string s = "";
            if (LastUpdate.Trim().Length == 0)
                LastUpdate = DateAndTime.Now.ToString();
            if (DisplayHelpText.Trim().Length == 0)
                DisplayHelpText = "0";
            s = s + " INSERT INTO HelpText(";
            s = s + "ScreenName,";
            s = s + "HelpText,";
            s = s + "WidgetName,";
            s = s + "WidgetText,";
            s = s + "DisplayHelpText,";
            s = s + "LastUpdate,";
            s = s + "UpdatedBy) values (";
            s = s + "'" + ScreenName + "'" + ",";
            s = s + "'" + HelpText + "'" + ",";
            s = s + "'" + WidgetName + "'" + ",";
            s = s + "'" + WidgetText + "'" + ",";
            s = s + DisplayHelpText + ",";
            s = s + "'" + LastUpdate + "'" + ",";
            s = s + "'" + UpdatedBy + "'" + ")";
            return DBARCH.ExecuteSqlNewConn(s, ConnStr, b);
        }

        // ** Generate the UPDATE method 
        public bool Update(string WhereClause)
        {
            bool b = false;
            string s = "";
            if (Strings.Len(WhereClause) == 0)
                return false;
            s = s + " update HelpText set ";
            // s = s + "ScreenName = '" + getScreenname() + "'" + ", "
            s = s + "HelpText = '" + getHelptext() + "'" + ", ";
            // s = s + "WidgetName = '" + getWidgetname() + "'" + ", "
            s = s + "WidgetText = '" + getWidgettext() + "'" + ", ";
            s = s + "DisplayHelpText = " + getDisplayhelptext() + ", ";
            s = s + "LastUpdate = '" + getLastupdate() + "'" + ", ";
            s = s + "CreateDate = '" + getCreatedate() + "'" + ", ";
            s = s + "UpdatedBy = '" + getUpdatedby() + "'";
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
            s = s + "ScreenName,";
            s = s + "HelpText,";
            s = s + "WidgetName,";
            s = s + "WidgetText,";
            s = s + "DisplayHelpText,";
            s = s + "LastUpdate,";
            s = s + "CreateDate,";
            s = s + "UpdatedBy ";
            s = s + " FROM HelpText";
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
            s = s + "ScreenName,";
            s = s + "HelpText,";
            s = s + "WidgetName,";
            s = s + "WidgetText,";
            s = s + "DisplayHelpText,";
            s = s + "LastUpdate,";
            s = s + "CreateDate,";
            s = s + "UpdatedBy ";
            s = s + " FROM HelpText";
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
            s = " Delete from HelpText";
            s = s + WhereClause;
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }


        // ** Generate the Zeroize Table method 
        public bool Zeroize()
        {
            bool b = false;
            string s = "";
            s = s + " Delete from HelpText";
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }


        // ** Generate Index Queries 
        public int cnt_PK_HelpText(string ScreenName, string WidgetName)
        {
            int B = 0;
            string TBL = "HelpText";
            string WC = "Where ScreenName = '" + ScreenName + "' and   WidgetName = '" + WidgetName + "'";
            B = DBARCH.iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_PK_HelpText

        // ** Generate Index ROW Queries 
        public SqlDataReader getRow_PK_HelpText(string ScreenName, string WidgetName)
        {
            SqlDataReader rsData = null;
            string TBL = "HelpText";
            string WC = "Where ScreenName = '" + ScreenName + "' and   WidgetName = '" + WidgetName + "'";
            rsData = DBARCH.GetRowByKey(TBL, WC);
            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow_PK_HelpText

        /// Build Index Where Caluses
        public string wc_PK_HelpText(string ScreenName, string WidgetName)
        {
            string WC = "Where ScreenName = '" + ScreenName + "' and   WidgetName = '" + WidgetName + "'";
            return WC;
        }     // ** wc_PK_HelpText

        // ** Generate the SET methods 

    }
}