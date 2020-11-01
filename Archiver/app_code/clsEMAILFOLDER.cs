using global::System.Data.SqlClient;
using System.Windows.Forms;
using global::Microsoft.VisualBasic;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{
    public class clsEMAILFOLDER
    {


        // ** DIM the selected table columns 
        private clsDatabaseARCH DBARCH = new clsDatabaseARCH();
        private clsDma DMA = new clsDma();
        private clsUtility UTIL = new clsUtility();
        private clsLogging LOG = new clsLogging();
        private string UserID = "";
        private string FolderName = "";
        private string ParentFolderName = "";
        private string FolderID = "";
        private string ParentFolderID = "";
        private string SelectedForArchive = "";
        private string StoreID = "";




        // ** Generate the SET methods 
        public void setUserid(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Userid' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            UserID = val;
        }

        public void setFoldername(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            FolderName = val;
        }

        public void setParentfoldername(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            ParentFolderName = val;
        }

        public void setFolderid(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Folderid' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            FolderID = val;
        }

        public void setParentfolderid(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            ParentFolderID = val;
        }

        public void setSelectedforarchive(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            SelectedForArchive = val;
        }

        public void setStoreid(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            StoreID = val;
        }






        // ** Generate the GET methods 
        public string getUserid()
        {
            if (Strings.Len(UserID) == 0)
            {
                MessageBox.Show("GET: Field 'Userid' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(UserID);
        }

        public string getFoldername()
        {
            return UTIL.RemoveSingleQuotes(FolderName);
        }

        public string getParentfoldername()
        {
            return UTIL.RemoveSingleQuotes(ParentFolderName);
        }

        public string getFolderid()
        {
            if (Strings.Len(FolderID) == 0)
            {
                MessageBox.Show("GET: Field 'Folderid' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(FolderID);
        }

        public string getParentfolderid()
        {
            return UTIL.RemoveSingleQuotes(ParentFolderID);
        }

        public string getSelectedforarchive()
        {
            return UTIL.RemoveSingleQuotes(SelectedForArchive);
        }

        public string getStoreid()
        {
            return UTIL.RemoveSingleQuotes(StoreID);
        }






        // ** Generate the Required Fields Validation method 
        public bool ValidateReqData()
        {
            if (UserID.Length == 0)
                return false;
            if (FolderID.Length == 0)
                return false;
            return true;
        }




        // ** Generate the Validation method 
        public bool ValidateData()
        {
            if (UserID.Length == 0)
                return false;
            if (FolderID.Length == 0)
                return false;
            return true;
        }

        // ** Generate the INSERT method 
        public bool Insert(string MasterFolder)
        {
            bool b = false;
            string s = "";
            string ContainerName = "";
            MasterFolder = UTIL.RemoveSingleQuotes(MasterFolder);
            FolderName = MasterFolder.Trim() + "|" + FolderName.Trim();
            FolderName = UTIL.RemoveSingleQuotes(FolderName);
            s = s + " INSERT INTO EmailFolder(";
            s = s + "UserID,";
            s = s + "FolderName,";
            s = s + "ParentFolderName,";
            s = s + "FolderID,";
            s = s + "ParentFolderID,";
            if (SelectedForArchive.Equals("Y") | SelectedForArchive.Equals("N"))
            {
                s = s + "SelectedForArchive,";
            }

            s = s + "StoreID, FileDirectory) values (";
            s = s + "'" + UserID + "'" + ",";
            s = s + "'" + FolderName + "'" + ",";
            s = s + "'" + ParentFolderName + "'" + ",";
            s = s + "'" + FolderID + "'" + ",";
            s = s + "'" + ParentFolderID + "'" + ",";
            if (SelectedForArchive.Equals("Y") | SelectedForArchive.Equals("N"))
            {
                s = s + "'" + SelectedForArchive + "'" + ",";
            }

            s = s + "'" + StoreID + "'" + ",";
            s = s + "'" + MasterFolder.Trim() + "'" + ")";
            if (FolderName.Contains("|"))
            {
                int i = FolderName.IndexOf("|");
                ContainerName = FolderName.Substring(i + 1);
            }
            else
            {
                ContainerName = "";
            }

            bool bb = DBARCH.ckEmailFolderExist(UserID, Conversions.ToInteger(FolderID), FolderName, ContainerName);
            if (!bb)
            {
                b = DBARCH.ExecuteSqlNewConn(s, false);
            }
            else
            {
                b = true;
            }

            if (b)
            {
                return true;
            }
            else
            {
                LOG.WriteToArchiveLog("ERROR: Failed to add email folder - " + MasterFolder + " : " + FolderName + " : " + ParentFolderName);
                return false;
            }
        }




        // ** Generate the UPDATE method 
        public bool Update(string WhereClause)
        {
            bool b = false;
            string s = "";
            if (Strings.Len(WhereClause) == 0)
                return false;
            string SelectedForArchive = getSelectedforarchive();
            s = s + " update EmailFolder set " + Constants.vbCrLf;
            s = s + "UserID = '" + getUserid() + "'" + ", " + Constants.vbCrLf;
            s = s + "FolderName = '" + getFoldername() + "'" + ", " + Constants.vbCrLf;
            s = s + "ParentFolderName = '" + getParentfoldername() + "'" + ", " + Constants.vbCrLf;
            s = s + "FolderID = '" + getFolderid() + "'" + ", " + Constants.vbCrLf;
            s = s + "ParentFolderID = '" + getParentfolderid() + "'" + ", " + Constants.vbCrLf;
            if (SelectedForArchive.Equals("Y") | SelectedForArchive.Equals("N"))
            {
                s = s + "SelectedForArchive = '" + getSelectedforarchive() + "'" + ", " + Constants.vbCrLf;
            }

            s = s + "StoreID = '" + getStoreid() + "'" + Constants.vbCrLf;
            WhereClause = " " + WhereClause + Constants.vbCrLf;
            s = s + WhereClause + Constants.vbCrLf;
            if (modGlobals.gClipBoardActive == true)
                Clipboard.Clear();
            if (modGlobals.gClipBoardActive == true)
                Clipboard.SetText(s);
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
            s = s + "FolderName,";
            s = s + "ParentFolderName,";
            s = s + "FolderID,";
            s = s + "ParentFolderID,";
            s = s + "SelectedForArchive,";
            s = s + "StoreID ";
            s = s + " FROM EmailFolder";
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
            s = s + "FolderName,";
            s = s + "ParentFolderName,";
            s = s + "FolderID,";
            s = s + "ParentFolderID,";
            s = s + "SelectedForArchive,";
            s = s + "StoreID ";
            s = s + " FROM EmailFolder";
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
            s = " Delete from EmailFolder";
            s = s + WhereClause;
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }




        // ** Generate the Zeroize Table method 
        public bool Zeroize()
        {
            bool b = false;
            string s = "";
            s = s + " Delete from EmailFolder";
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }




        // ** Generate Index Queries 
        public int cnt_IDX_FolderName(string FileDirectory, string FolderName, string UserID)
        {
            int B = 0;
            string TBL = "EmailFolder";
            string WC = "Where FileDirectory = '" + FileDirectory + "' and FolderName = '" + FolderName + "' and   UserID = '" + UserID + "'";
            B = DBARCH.iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_IDX_FolderName

        public int cnt_PK_EmailFolder(string FolderID, string UserID)
        {
            int B = 0;
            string TBL = "EmailFolder";
            string WC = "Where FolderID = '" + FolderID + "' and   UserID = '" + UserID + "'";
            B = DBARCH.iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_PK_EmailFolder

        public int cnt_UI_EmailFolder(string TopLevelOutlookFolderName, string FolderName, string UserID)
        {
            TopLevelOutlookFolderName = UTIL.RemoveSingleQuotes(TopLevelOutlookFolderName);
            FolderName = UTIL.RemoveSingleQuotes(FolderName);
            FolderName = TopLevelOutlookFolderName + "|" + FolderName;
            int B = 0;
            string TBL = "EmailFolder";
            string WC = "Where FolderName = '" + TopLevelOutlookFolderName + "' and FolderName = '" + FolderName + "' and   UserID = '" + UserID + "'";
            B = DBARCH.iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_UI_EmailFolder


        // ** Generate Index ROW Queries 
        public SqlDataReader getRow_IDX_FolderName(string FolderName, string UserID)
        {
            SqlDataReader rsData = null;
            string TBL = "EmailFolder";
            string WC = "Where FolderName = '" + FolderName + "' and   UserID = '" + UserID + "'";
            rsData = DBARCH.GetRowByKey(TBL, WC);
            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow_IDX_FolderName

        public SqlDataReader getRow_PK_EmailFolder(string FolderID, string UserID)
        {
            SqlDataReader rsData = null;
            string TBL = "EmailFolder";
            string WC = "Where FolderID = '" + FolderID + "' and   UserID = '" + UserID + "'";
            rsData = DBARCH.GetRowByKey(TBL, WC);
            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow_PK_EmailFolder

        public SqlDataReader getRow_UI_EmailFolder(string FolderName, string UserID)
        {
            SqlDataReader rsData = null;
            string TBL = "EmailFolder";
            string WC = "Where FolderName = '" + FolderName + "' and   UserID = '" + UserID + "'";
            rsData = DBARCH.GetRowByKey(TBL, WC);
            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow_UI_EmailFolder


        /// Build Index Where Caluses
        public string wc_IDX_FolderName(string FolderName, string UserID)
        {
            string WC = "Where FolderName = '" + FolderName + "' and   UserID = '" + UserID + "'";
            return WC;
        }     // ** wc_IDX_FolderName

        public string wc_PK_EmailFolder(string FolderID, string UserID)
        {
            string WC = "Where FolderID = '" + FolderID + "' and   UserID = '" + UserID + "'";
            return WC;
        }     // ** wc_PK_EmailFolder

        public string wc_UI_EmailFolder(string FileDirectory, string FolderName, string UserID)
        {

            // "where [FileDirectory] = '" + FileDirectory  + "' and FolderName = 'Personal Folders|Junk E-mail' and UserID = 'wmiller'"
            FileDirectory = UTIL.RemoveSingleQuotes(FileDirectory);
            FolderName = UTIL.RemoveSingleQuotes(FolderName);
            string WC = "where [FileDirectory] = '" + FileDirectory + "' and FolderName = '" + FolderName + "' and UserID = '" + UserID + "'";
            return WC;
        }     // ** wc_UI_EmailFolder


        // ** Generate the SET methods 


    }
}