using global::System;
using System.Data;
using global::System.Data.SqlClient;
using System.Diagnostics;
using global::System.IO;
using System.Windows.Forms;
using global::Microsoft.VisualBasic;
using MODI;

namespace EcmArchiver
{
    public class clsZIPDATASOURCE
    {


        // ** DIM the selected table columns 
        private clsDatabaseARCH DBARCH = new clsDatabaseARCH();
        private clsDma DMA = new clsDma();
        private clsUtility UTIL = new clsUtility();
        private clsLogging LOG = new clsLogging();
        private clsDataGrid DG = new clsDataGrid();
        private string SourceGuid = "";
        private string CreateDate = "";
        private string SourceName = "";
        private string SourceImage = "";
        private string SourceTypeCode = "";
        private string FQN = "";
        private string VersionNbr = "";
        private string LastAccessDate = "";
        private string FileLength = "";
        private string LastWriteTime = "";
        private string UserID = "";
        private string DataSourceOwnerUserID = "";
        private string isPublic = "";
        private string FileDirectory = "";
        private string OriginalFileType = "";
        private string RetentionExpirationDate = "";
        private string IsPublicPreviousState = "";
        private string isAvailable = "";
        private string isContainedWithinZipFile = "";
        private string IsZipFile = "";
        private string DataVerified = "";




        // ** Generate the SET methods 
        public void setSourceguid(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Sourceguid' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            SourceGuid = val;
        }

        public void setCreatedate(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            CreateDate = val;
        }

        public void setSourcename(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            SourceName = val;
        }

        public void setSourceimage(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                val = "null";
            }

            val = UTIL.RemoveSingleQuotes(val);
            SourceImage = val;
        }

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

        public void setFqn(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            FQN = val;
        }

        public void setVersionnbr(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Versionnbr' cannot be NULL.");
                return;
            }

            if (Strings.Len(val) == 0)
            {
                val = "null";
            }

            val = UTIL.RemoveSingleQuotes(val);
            VersionNbr = val;
        }

        public void setLastaccessdate(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            LastAccessDate = val;
        }

        public void setFilelength(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                val = "null";
            }

            val = UTIL.RemoveSingleQuotes(val);
            FileLength = val;
        }

        public void setLastwritetime(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            LastWriteTime = val;
        }

        public void setUserid(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            UserID = val;
        }

        public void setDatasourceowneruserid(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                MessageBox.Show("SET: Field 'Datasourceowneruserid' cannot be NULL.");
                return;
            }

            val = UTIL.RemoveSingleQuotes(val);
            DataSourceOwnerUserID = val;
        }

        public void setIspublic(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            isPublic = val;
        }

        public void setFiledirectory(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            FileDirectory = val;
        }

        public void setOriginalfiletype(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            OriginalFileType = val;
        }

        public void setRetentionexpirationdate(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            RetentionExpirationDate = val;
        }

        public void setIspublicpreviousstate(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            IsPublicPreviousState = val;
        }

        public void setIsavailable(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            isAvailable = val;
        }

        public void setIscontainedwithinzipfile(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            isContainedWithinZipFile = val;
        }

        public void setIszipfile(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            IsZipFile = val;
        }

        public void setDataverified(ref string val)
        {
            if (Strings.Len(val) == 0)
            {
                val = "null";
            }

            val = UTIL.RemoveSingleQuotes(val);
            DataVerified = val;
        }






        // ** Generate the GET methods 
        public string getSourceguid()
        {
            if (Strings.Len(SourceGuid) == 0)
            {
                MessageBox.Show("GET: Field 'Sourceguid' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(SourceGuid);
        }

        public string getCreatedate()
        {
            return UTIL.RemoveSingleQuotes(CreateDate);
        }

        public string getSourcename()
        {
            return UTIL.RemoveSingleQuotes(SourceName);
        }

        public string getSourceimage()
        {
            if (Strings.Len(SourceImage) == 0)
            {
                SourceImage = "null";
            }

            return SourceImage;
        }

        public string getSourcetypecode()
        {
            if (Strings.Len(SourceTypeCode) == 0)
            {
                MessageBox.Show("GET: Field 'Sourcetypecode' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(SourceTypeCode);
        }

        public string getFqn()
        {
            return UTIL.RemoveSingleQuotes(FQN);
        }

        public string getVersionnbr()
        {
            if (Strings.Len(VersionNbr) == 0)
            {
                MessageBox.Show("GET: Field 'Versionnbr' cannot be NULL.");
                return "";
            }

            if (Strings.Len(VersionNbr) == 0)
            {
                VersionNbr = "null";
            }

            return VersionNbr;
        }

        public string getLastaccessdate()
        {
            return UTIL.RemoveSingleQuotes(LastAccessDate);
        }

        public string getFilelength()
        {
            if (Strings.Len(FileLength) == 0)
            {
                FileLength = "null";
            }

            return FileLength;
        }

        public string getLastwritetime()
        {
            return UTIL.RemoveSingleQuotes(LastWriteTime);
        }

        public string getUserid()
        {
            return UTIL.RemoveSingleQuotes(UserID);
        }

        public string getDatasourceowneruserid()
        {
            if (Strings.Len(DataSourceOwnerUserID) == 0)
            {
                MessageBox.Show("GET: Field 'Datasourceowneruserid' cannot be NULL.");
                return "";
            }

            return UTIL.RemoveSingleQuotes(DataSourceOwnerUserID);
        }

        public string getIspublic()
        {
            return UTIL.RemoveSingleQuotes(isPublic);
        }

        public string getFiledirectory()
        {
            return UTIL.RemoveSingleQuotes(FileDirectory);
        }

        public string getOriginalfiletype()
        {
            return UTIL.RemoveSingleQuotes(OriginalFileType);
        }

        public string getRetentionexpirationdate()
        {
            return UTIL.RemoveSingleQuotes(RetentionExpirationDate);
        }

        public string getIspublicpreviousstate()
        {
            return UTIL.RemoveSingleQuotes(IsPublicPreviousState);
        }

        public string getIsavailable()
        {
            return UTIL.RemoveSingleQuotes(isAvailable);
        }

        public string getIscontainedwithinzipfile()
        {
            return UTIL.RemoveSingleQuotes(isContainedWithinZipFile);
        }

        public string getIszipfile()
        {
            return UTIL.RemoveSingleQuotes(IsZipFile);
        }

        public string getDataverified()
        {
            if (Strings.Len(DataVerified) == 0)
            {
                DataVerified = "null";
            }

            return DataVerified;
        }






        // ** Generate the Required Fields Validation method 
        public bool ValidateReqData()
        {
            if (SourceGuid.Length == 0)
                return false;
            if (SourceTypeCode.Length == 0)
                return false;
            if (VersionNbr.Length == 0)
                return false;
            if (DataSourceOwnerUserID.Length == 0)
                return false;
            return true;
        }




        // ** Generate the Validation method 
        public bool ValidateData()
        {
            if (SourceGuid.Length == 0)
                return false;
            if (SourceTypeCode.Length == 0)
                return false;
            if (VersionNbr.Length == 0)
                return false;
            if (DataSourceOwnerUserID.Length == 0)
                return false;
            return true;
        }




        // ** Generate the INSERT method 
        public bool Insert()
        {
            bool b = false;
            string s = "";
            s = s + " INSERT INTO DataSource(";
            s = s + "SourceGuid,";
            s = s + "CreateDate,";
            s = s + "SourceName,";
            s = s + "SourceImage,";
            s = s + "SourceTypeCode,";
            s = s + "FQN,";
            s = s + "VersionNbr,";
            s = s + "LastAccessDate,";
            s = s + "FileLength,";
            s = s + "LastWriteTime,";
            s = s + "UserID,";
            s = s + "DataSourceOwnerUserID,";
            s = s + "isPublic,";
            s = s + "FileDirectory,";
            s = s + "OriginalFileType,";
            s = s + "RetentionExpirationDate,";
            s = s + "IsPublicPreviousState,";
            s = s + "isAvailable,";
            s = s + "isContainedWithinZipFile,";
            s = s + "IsZipFile,";
            s = s + "DataVerified) values (";
            s = s + "'" + SourceGuid + "'" + ",";
            s = s + "'" + CreateDate + "'" + ",";
            s = s + "'" + SourceName + "'" + ",";
            s = s + SourceImage + ",";
            s = s + "'" + SourceTypeCode + "'" + ",";
            s = s + "'" + FQN + "'" + ",";
            s = s + VersionNbr + ",";
            s = s + "'" + LastAccessDate + "'" + ",";
            s = s + FileLength + ",";
            s = s + "'" + LastWriteTime + "'" + ",";
            s = s + "'" + UserID + "'" + ",";
            s = s + "'" + DataSourceOwnerUserID + "'" + ",";
            s = s + "'" + isPublic + "'" + ",";
            s = s + "'" + FileDirectory + "'" + ",";
            s = s + "'" + OriginalFileType + "'" + ",";
            s = s + "'" + RetentionExpirationDate + "'" + ",";
            s = s + "'" + IsPublicPreviousState + "'" + ",";
            s = s + "'" + isAvailable + "'" + ",";
            s = s + "'" + isContainedWithinZipFile + "'" + ",";
            s = s + "'" + IsZipFile + "'" + ",";
            s = s + DataVerified + ")";
            return DBARCH.ExecuteSqlNewConn(s, false);
        }




        // ** Generate the UPDATE method 
        public bool Update(string WhereClause)
        {
            bool b = false;
            string s = "";
            if (Strings.Len(WhereClause) == 0)
                return false;
            s = s + " update DataSource set ";
            s = s + "SourceGuid = '" + getSourceguid() + "'" + ", ";
            s = s + "CreateDate = '" + getCreatedate() + "'" + ", ";
            s = s + "SourceName = '" + getSourcename() + "'" + ", ";
            s = s + "SourceImage = " + getSourceimage() + ", ";
            s = s + "SourceTypeCode = '" + getSourcetypecode() + "'" + ", ";
            s = s + "FQN = '" + getFqn() + "'" + ", ";
            s = s + "VersionNbr = " + getVersionnbr() + ", ";
            s = s + "LastAccessDate = '" + getLastaccessdate() + "'" + ", ";
            s = s + "FileLength = " + getFilelength() + ", ";
            s = s + "LastWriteTime = '" + getLastwritetime() + "'" + ", ";
            s = s + "UserID = '" + getUserid() + "'" + ", ";
            s = s + "DataSourceOwnerUserID = '" + getDatasourceowneruserid() + "'" + ", ";
            s = s + "isPublic = '" + getIspublic() + "'" + ", ";
            s = s + "FileDirectory = '" + getFiledirectory() + "'" + ", ";
            s = s + "OriginalFileType = '" + getOriginalfiletype() + "'" + ", ";
            s = s + "RetentionExpirationDate = '" + getRetentionexpirationdate() + "'" + ", ";
            s = s + "IsPublicPreviousState = '" + getIspublicpreviousstate() + "'" + ", ";
            s = s + "isAvailable = '" + getIsavailable() + "'" + ", ";
            s = s + "isContainedWithinZipFile = '" + getIscontainedwithinzipfile() + "'" + ", ";
            s = s + "IsZipFile = '" + getIszipfile() + "'" + ", ";
            s = s + "DataVerified = " + getDataverified();
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
            s = s + "SourceGuid,";
            s = s + "CreateDate,";
            s = s + "SourceName,";
            s = s + "SourceImage,";
            s = s + "SourceTypeCode,";
            s = s + "FQN,";
            s = s + "VersionNbr,";
            s = s + "LastAccessDate,";
            s = s + "FileLength,";
            s = s + "LastWriteTime,";
            s = s + "UserID,";
            s = s + "DataSourceOwnerUserID,";
            s = s + "isPublic,";
            s = s + "FileDirectory,";
            s = s + "OriginalFileType,";
            s = s + "RetentionExpirationDate,";
            s = s + "IsPublicPreviousState,";
            s = s + "isAvailable,";
            s = s + "isContainedWithinZipFile,";
            s = s + "IsZipFile,";
            s = s + "DataVerified ";
            s = s + " FROM DataSource";
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
            s = s + "SourceGuid,";
            s = s + "CreateDate,";
            s = s + "SourceName,";
            s = s + "SourceImage,";
            s = s + "SourceTypeCode,";
            s = s + "FQN,";
            s = s + "VersionNbr,";
            s = s + "LastAccessDate,";
            s = s + "FileLength,";
            s = s + "LastWriteTime,";
            s = s + "UserID,";
            s = s + "DataSourceOwnerUserID,";
            s = s + "isPublic,";
            s = s + "FileDirectory,";
            s = s + "OriginalFileType,";
            s = s + "RetentionExpirationDate,";
            s = s + "IsPublicPreviousState,";
            s = s + "isAvailable,";
            s = s + "isContainedWithinZipFile,";
            s = s + "IsZipFile,";
            s = s + "DataVerified ";
            s = s + " FROM DataSource";
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
            s = " Delete from DataSource";
            s = s + WhereClause;
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }




        // ** Generate the Zeroize Table method 
        public bool Zeroize()
        {
            bool b = false;
            string s = "";
            s = s + " Delete from DataSource";
            b = DBARCH.ExecuteSqlNewConn(s, false);
            return b;
        }




        // ** Generate Index Queries 
        public int cnt_PI_DIR(string DataSourceOwnerUserID, string FileDirectory)
        {
            int B = 0;
            string TBL = "DataSource";
            string WC = "Where DataSourceOwnerUserID = '" + DataSourceOwnerUserID + "' and   FileDirectory = '" + FileDirectory + "'";
            B = DBARCH.iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_PI_DIR

        public int cnt_PI_FQN_USERID(string DataSourceOwnerUserID, string FQN)
        {
            int B = 0;
            string TBL = "DataSource";
            string WC = "Where DataSourceOwnerUserID = '" + DataSourceOwnerUserID + "' and   FQN = '" + FQN + "'";
            B = DBARCH.iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_PI_FQN_USERID

        public int cnt_PK33_04012008185318001(string DataSourceOwnerUserID, string SourceGuid)
        {
            int B = 0;
            string TBL = "DataSource";
            string WC = "Where DataSourceOwnerUserID = '" + DataSourceOwnerUserID + "' and   SourceGuid = '" + SourceGuid + "'";
            B = DBARCH.iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_PK33_04012008185318001

        public int cnt_UK_FQN_VERNBR(string FQN, int VersionNbr)
        {
            int B = 0;
            string TBL = "DataSource";
            string WC = "Where FQN = '" + FQN + "' and   VersionNbr = " + VersionNbr;
            B = DBARCH.iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_UK_FQN_VERNBR

        public int cnt_UKI_Documents(string SourceGuid)
        {
            int B = 0;
            string TBL = "DataSource";
            string WC = "Where SourceGuid = '" + SourceGuid + "'";
            B = DBARCH.iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_UKI_Documents


        // ** Generate Index ROW Queries 
        public SqlDataReader getRow_PI_DIR(string DataSourceOwnerUserID, string FileDirectory)
        {
            SqlDataReader rsData = null;
            string TBL = "DataSource";
            string WC = "Where DataSourceOwnerUserID = '" + DataSourceOwnerUserID + "' and   FileDirectory = '" + FileDirectory + "'";
            rsData = DBARCH.GetRowByKey(TBL, WC);
            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow_PI_DIR

        public SqlDataReader getRow_PI_FQN_USERID(string DataSourceOwnerUserID, string FQN)
        {
            SqlDataReader rsData = null;
            string TBL = "DataSource";
            string WC = "Where DataSourceOwnerUserID = '" + DataSourceOwnerUserID + "' and   FQN = '" + FQN + "'";
            rsData = DBARCH.GetRowByKey(TBL, WC);
            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow_PI_FQN_USERID

        public SqlDataReader getRow_PK33_04012008185318001(string DataSourceOwnerUserID, string SourceGuid)
        {
            SqlDataReader rsData = null;
            string TBL = "DataSource";
            string WC = "Where DataSourceOwnerUserID = '" + DataSourceOwnerUserID + "' and   SourceGuid = '" + SourceGuid + "'";
            rsData = DBARCH.GetRowByKey(TBL, WC);
            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow_PK33_04012008185318001

        public SqlDataReader getRow_UK_FQN_VERNBR(string FQN, int VersionNbr)
        {
            SqlDataReader rsData = null;
            string TBL = "DataSource";
            string WC = "Where FQN = '" + FQN + "' and   VersionNbr = " + VersionNbr;
            rsData = DBARCH.GetRowByKey(TBL, WC);
            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow_UK_FQN_VERNBR

        public SqlDataReader getRow_UKI_Documents(string SourceGuid)
        {
            SqlDataReader rsData = null;
            string TBL = "DataSource";
            string WC = "Where SourceGuid = '" + SourceGuid + "'";
            rsData = DBARCH.GetRowByKey(TBL, WC);
            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow_UKI_Documents


        /// Build Index Where Caluses
        public string wc_PI_DIR(string DataSourceOwnerUserID, string FileDirectory)
        {
            string WC = "Where DataSourceOwnerUserID = '" + DataSourceOwnerUserID + "' and   FileDirectory = '" + FileDirectory + "'";
            return WC;
        }     // ** wc_PI_DIR

        public string wc_PI_FQN_USERID(string DataSourceOwnerUserID, string FQN)
        {
            string WC = "Where DataSourceOwnerUserID = '" + DataSourceOwnerUserID + "' and   FQN = '" + FQN + "'";
            return WC;
        }     // ** wc_PI_FQN_USERID

        public string wc_PK33_04012008185318001(string DataSourceOwnerUserID, string SourceGuid)
        {
            string WC = "Where DataSourceOwnerUserID = '" + DataSourceOwnerUserID + "' and   SourceGuid = '" + SourceGuid + "'";
            return WC;
        }     // ** wc_PK33_04012008185318001

        public string wc_UK_FQN_VERNBR(string FQN, int VersionNbr)
        {
            string WC = "Where FQN = '" + FQN + "' and   VersionNbr = " + VersionNbr;
            return WC;
        }     // ** wc_UK_FQN_VERNBR

        public string wc_UKI_Documents(string SourceGuid)
        {
            string WC = "Where SourceGuid = '" + SourceGuid + "'";
            return WC;
        }     // ** wc_UKI_Documents


        // ** Generate the SET methods 




        public bool ImageUpdt_SourceImage(string WhereClause, string FQN)
        {
            bool b = false;
            try
            {
                string ConnStr = DBARCH.setConnStr();     // DBARCH.getGateWayConnStr(gGateWayID)
                var connection = new SqlConnection(ConnStr);
                var command = new SqlCommand("UPDATE DataSource SET SourceImage = @FileContents '" + WhereClause + "'", connection);
                command.Parameters.Add("@FileContents", SqlDbType.VarBinary).Value = File.ReadAllBytes(FQN);
                connection.Open();
                command.ExecuteNonQuery();
                connection.Close();
                b = true;
            }
            catch (Exception ex)
            {
                b = false;
                LOG.WriteToArchiveLog("clsZIPDATASOURCE : ImageUpdt_SourceImage : 297 : " + ex.Message);
            }

            return b;
        }

        public bool ImageToFile_SourceImage(string WhereClause, string FQN, bool OverWrite)
        {
            bool B = true;
            string SourceTblName = "DataSource";
            string ImageFieldName = "SourceImage";
            try
            {
                string S = "";
                S = S + " SELECT ";
                S = S + " [SourceImage]";
                S = S + " FROM  [DataSource]";
                S = S + WhereClause;
                var CN = new SqlConnection(DBARCH.setConnStr());     // DBARCH.getGateWayConnStr(gGateWayID))
                if (CN.State == ConnectionState.Closed)
                {
                    CN.Open();
                }

                var da = new SqlDataAdapter(S, CN);
                var MyCB = new SqlCommandBuilder(da);
                var ds = new DataSet();
                da.Fill(ds, SourceTblName);
                DataRow myRow;
                myRow = ds.Tables[SourceTblName].Rows[0];
                byte[] MyData;
                MyData = (byte[])myRow[SourceImage];
                long K;
                K = Information.UBound(MyData);
                try
                {
                    if (OverWrite)
                    {
                    }
                    // If File.Exists(FQN) Then
                    // File.Delete(FQN)
                    // End If
                    else if (File.Exists(FQN))
                    {
                        return false;
                    }

                    var fs = new FileStream(FQN, FileMode.Create, FileAccess.Write);
                    fs.Write(MyData, 0, (int)K);
                    fs.Close();
                    fs = null;
                    B = true;
                }
                catch (Exception ex)
                {
                    Debug.Print(ex.Message);
                    DBARCH.xTrace(58342.15, "image write - ZipDataSource:SourceImage", ex.Message);
                    B = false;
                    LOG.WriteToArchiveLog("clsZIPDATASOURCE : ImageToFile_SourceImage : 337 : " + ex.Message);
                }

                MyCB = null;
                ds = null;
                da = null;
                CN.Close();
                CN = null;
                GC.Collect();
            }
            catch (Exception ex)
            {
                string AppName = ex.Source;
                DBARCH.xTrace(58342.1, "ZipDataSource", ex.Message);
                LOG.WriteToArchiveLog("clsZIPDATASOURCE : ImageToFile_SourceImage : 345 : " + ex.Message);
            }

            return B;
        }
    }
}