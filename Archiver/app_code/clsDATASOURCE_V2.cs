using global::System;
using System.Data;
using global::System.Data.SqlClient;
using System.Diagnostics;
using global::System.IO;
using System.Windows.Forms;
using global::Microsoft.VisualBasic;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{
    public class clsDATASOURCE_V2
    {

        // ** DIM the selected table columns 
        private clsDatabaseARCH DBARCH = new clsDatabaseARCH();
        private clsDma DMA = new clsDma();
        private clsDataGrid DG = new clsDataGrid();
        private clsUtility UTIL = new clsUtility();
        private clsLogging LOG = new clsLogging();
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
        private string ZipFileGuid = "";
        private string ZipFileFQN = "";
        private string Description = "";
        private string KeyWords = "";
        private string Notes = "";
        private string isPerm = "";
        private string isMaster = "";
        private string CreationDate = "";
        private string OcrPerformed = "";
        private string isGraphic = "";
        private string GraphicContainsText = "";
        private string OcrText = "";
        private string ImageHiddenText = "";
        private string isWebPage = "";


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

        public void setZipfileguid(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            ZipFileGuid = val;
        }

        public void setZipfilefqn(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            ZipFileFQN = val;
        }

        public void setDescription(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            Description = val;
        }

        public void setKeywords(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            KeyWords = val;
        }

        public void setNotes(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            Notes = val;
        }

        public void setIsperm(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            isPerm = val;
        }

        public void setIsmaster(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            isMaster = val;
        }

        public void setCreationdate(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            CreationDate = val;
        }

        public void setOcrperformed(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            OcrPerformed = val;
        }

        public void setIsgraphic(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            isGraphic = val;
        }

        public void setGraphiccontainstext(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            GraphicContainsText = val;
        }

        public void AppendOcrText(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            OcrText = val;
        }

        public void setImagehiddentext(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            ImageHiddenText = val;
        }

        public void setIswebpage(ref string val)
        {
            val = UTIL.RemoveSingleQuotes(val);
            isWebPage = val;
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

        public string getZipfileguid()
        {
            return UTIL.RemoveSingleQuotes(ZipFileGuid);
        }

        public string getZipfilefqn()
        {
            return UTIL.RemoveSingleQuotes(ZipFileFQN);
        }

        public string getDescription()
        {
            return UTIL.RemoveSingleQuotes(Description);
        }

        public string getKeywords()
        {
            return UTIL.RemoveSingleQuotes(KeyWords);
        }

        public string getNotes()
        {
            return UTIL.RemoveSingleQuotes(Notes);
        }

        public string getIsperm()
        {
            return UTIL.RemoveSingleQuotes(isPerm);
        }

        public string getIsmaster()
        {
            return UTIL.RemoveSingleQuotes(isMaster);
        }

        public string getCreationdate()
        {
            return UTIL.RemoveSingleQuotes(CreationDate);
        }

        public string getOcrperformed()
        {
            return UTIL.RemoveSingleQuotes(OcrPerformed);
        }

        public string getIsgraphic()
        {
            return UTIL.RemoveSingleQuotes(isGraphic);
        }

        public string getGraphiccontainstext()
        {
            return UTIL.RemoveSingleQuotes(GraphicContainsText);
        }

        public string getOcrtext()
        {
            return UTIL.RemoveSingleQuotes(OcrText);
        }

        public string getImagehiddentext()
        {
            return UTIL.RemoveSingleQuotes(ImageHiddenText);
        }

        public string getIswebpage()
        {
            return UTIL.RemoveSingleQuotes(isWebPage);
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
        public bool Insert(string SourceGuid, string CRC)
        {
            if (VersionNbr.Length.Equals(0))
            {
                VersionNbr = "1";
            }

            string RowGuid = Guid.NewGuid().ToString();
            bool b = false;
            string s = "";
            s = s + " INSERT INTO DataSource(";
            s = s + "RowGuid,";
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
            s = s + "DataVerified,";
            s = s + "ZipFileGuid,";
            s = s + "ZipFileFQN,";
            s = s + "Description,";
            s = s + "KeyWords,";
            s = s + "Notes,";
            s = s + "isPerm,";
            s = s + "isMaster,";
            s = s + "CreationDate,";
            s = s + "OcrPerformed,";
            s = s + "isGraphic,";
            s = s + "GraphicContainsText,";
            s = s + "OcrText,";
            s = s + "ImageHiddenText,";
            s = s + "isWebPage, CRC, ImageHash) values " + Constants.vbCrLf + " (";
            s = s + "'" + RowGuid + "'" + "," + Constants.vbCrLf;
            s = s + "'" + SourceGuid + "'" + "," + Constants.vbCrLf;
            s = s + "'" + CreateDate + "'" + "," + Constants.vbCrLf;
            s = s + "'" + SourceName + "'" + "," + Constants.vbCrLf;
            // SourceImage
            s = s + "null" + "," + Constants.vbCrLf;
            s = s + "'" + SourceTypeCode + "'" + "," + Constants.vbCrLf;
            s = s + "'" + FQN + "'" + "," + Constants.vbCrLf;
            s = s + VersionNbr + "," + Constants.vbCrLf;
            s = s + "'" + LastAccessDate + "'" + "," + Constants.vbCrLf;
            s = s + "-1" + "," + Constants.vbCrLf;
            s = s + "'" + LastWriteTime + "'" + "," + Constants.vbCrLf;
            s = s + "'" + UserID + "'" + "," + Constants.vbCrLf;
            s = s + "'" + DataSourceOwnerUserID + "'" + "," + Constants.vbCrLf;
            s = s + "'" + isPublic + "'" + "," + Constants.vbCrLf;
            s = s + "'" + FileDirectory + "'" + "," + Constants.vbCrLf;
            s = s + "'" + OriginalFileType + "'" + "," + Constants.vbCrLf;
            s = s + "'" + RetentionExpirationDate + "'" + "," + Constants.vbCrLf;
            s = s + "'" + IsPublicPreviousState + "'" + "," + Constants.vbCrLf;
            s = s + "'" + isAvailable + "'" + "," + Constants.vbCrLf;
            s = s + "'" + isContainedWithinZipFile + "'" + "," + Constants.vbCrLf;
            s = s + "'" + IsZipFile + "'" + "," + Constants.vbCrLf;
            // DataVerified 
            s = s + "null" + "," + Constants.vbCrLf;
            s = s + "'" + ZipFileGuid + "'" + "," + Constants.vbCrLf;
            s = s + "'" + ZipFileFQN + "'" + "," + Constants.vbCrLf;
            s = s + "'" + Description + "'" + "," + Constants.vbCrLf;
            s = s + "'" + KeyWords + "'" + "," + Constants.vbCrLf;
            s = s + "'" + Notes + "'" + "," + Constants.vbCrLf;
            s = s + "'" + isPerm + "'" + "," + Constants.vbCrLf;
            s = s + "'" + isMaster + "'" + "," + Constants.vbCrLf;
            s = s + "'" + CreationDate + "'" + "," + Constants.vbCrLf;
            s = s + "'" + OcrPerformed + "'" + "," + Constants.vbCrLf;
            s = s + "'" + isGraphic + "'" + "," + Constants.vbCrLf;
            s = s + "'" + GraphicContainsText + "'" + "," + Constants.vbCrLf;
            s = s + "'" + OcrText + "'" + "," + Constants.vbCrLf;
            s = s + "'" + ImageHiddenText + "'" + "," + Constants.vbCrLf;
            s = s + "'" + isWebPage + "'" + "," + Constants.vbCrLf;
            s = s + "'" + CRC + "'" + "," + Constants.vbCrLf;
            s = s + "'" + CRC + "'" + ")";
            bool BB = false;
            BB = DBARCH.ExecuteSqlNewConn(s, false);
            if (!BB)
            {
                LOG.WriteToArchiveLog("ERROR clsDataSource_V2 00 Insert: " + Constants.vbCrLf + s);
            }

            s = "Update DataSource set CRC = convert(nvarchar(249), " + CRC + ") where SourceGuid = '" + RowGuid + "'";
            BB = DBARCH.ExecuteSqlNewConn(s, false);
            if (!BB)
            {
                LOG.WriteToArchiveLog("ERROR clsDataSource_V2 01 Insert: " + Constants.vbCrLf + s);
            }

            s = "Update DataSource set ImageHash = convert(nvarchar(249), " + CRC + ") where SourceGuid = '" + RowGuid + "'";
            BB = DBARCH.ExecuteSqlNewConn(s, false);
            if (!BB)
            {
                LOG.WriteToArchiveLog("ERROR clsDataSource_V2 02 Insert: " + Constants.vbCrLf + s);
            }

            return BB;
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
            s = s + "DataVerified = " + getDataverified() + ", ";
            s = s + "ZipFileGuid = '" + getZipfileguid() + "'" + ", ";
            s = s + "ZipFileFQN = '" + getZipfilefqn() + "'" + ", ";
            s = s + "Description = '" + getDescription() + "'" + ", ";
            s = s + "KeyWords = '" + getKeywords() + "'" + ", ";
            s = s + "Notes = '" + getNotes() + "'" + ", ";
            s = s + "isPerm = '" + getIsperm() + "'" + ", ";
            s = s + "isMaster = '" + getIsmaster() + "'" + ", ";
            s = s + "CreationDate = '" + getCreationdate() + "'" + ", ";
            s = s + "OcrPerformed = '" + getOcrperformed() + "'" + ", ";
            s = s + "isGraphic = '" + getIsgraphic() + "'" + ", ";
            s = s + "GraphicContainsText = '" + getGraphiccontainstext() + "'" + ", ";
            s = s + "OcrText = '" + getOcrtext() + "'" + ", ";
            s = s + "ImageHiddenText = '" + getImagehiddentext() + "'" + ", ";
            s = s + "isWebPage = '" + getIswebpage() + "'";
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
            s = s + "DataVerified,";
            s = s + "ZipFileGuid,";
            s = s + "ZipFileFQN,";
            s = s + "Description,";
            s = s + "KeyWords,";
            s = s + "Notes,";
            s = s + "isPerm,";
            s = s + "isMaster,";
            s = s + "CreationDate,";
            s = s + "OcrPerformed,";
            s = s + "isGraphic,";
            s = s + "GraphicContainsText,";
            s = s + "OcrText,";
            s = s + "ImageHiddenText,";
            s = s + "isWebPage ";
            s = s + " FROM DataSource";
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
            s = s + "DataVerified,";
            s = s + "ZipFileGuid,";
            s = s + "ZipFileFQN,";
            s = s + "Description,";
            s = s + "KeyWords,";
            s = s + "Notes,";
            s = s + "isPerm,";
            s = s + "isMaster,";
            s = s + "CreationDate,";
            s = s + "OcrPerformed,";
            s = s + "isGraphic,";
            s = s + "GraphicContainsText,";
            s = s + "OcrText,";
            s = s + "ImageHiddenText,";
            s = s + "isWebPage ";
            s = s + " FROM DataSource";
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
        public int cnt__dta_index_DataSource_11_773577794__K1_K3_2_5_6_7_8_9_10_12_13_14(DateTime CreateDate, string DataSourceOwnerUserID, string FileDirectory, int FileLength, string FQN, string isPublic, DateTime LastAccessDate, DateTime LastWriteTime, string SourceGuid, string SourceName, string SourceTypeCode, int VersionNbr)
        {
            FQN = UTIL.RemoveSingleQuotes(FQN);
            int B = 0;
            string TBL = "DataSource";
            string WC = "Where CreateDate = '" + Conversions.ToString(CreateDate) + "' and   DataSourceOwnerUserID = '" + DataSourceOwnerUserID + "' and   FileDirectory = '" + FileDirectory + "' and   FileLength = " + FileLength + "and   FQN = '" + FQN + "' and   isPublic = '" + isPublic + "' and   LastAccessDate = '" + Conversions.ToString(LastAccessDate) + "' and   LastWriteTime = '" + Conversions.ToString(LastWriteTime) + "' and   SourceGuid = '" + SourceGuid + "' and   SourceName = '" + SourceName + "' and   SourceTypeCode = '" + SourceTypeCode + "' and   VersionNbr = " + VersionNbr;
            B = DBARCH.iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt__dta_index_DataSource_11_773577794__K1_K3_2_5_6_7_8_9_10_12_13_14

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
            FQN = UTIL.RemoveSingleQuotes(FQN);
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

        public int cnt_UI_DataSource_01(string DataSourceOwnerUserID, string FQN, int VersionNbr)
        {
            FQN = UTIL.RemoveSingleQuotes(FQN);
            int B = 0;
            string TBL = "DataSource";
            string WC = "Where DataSourceOwnerUserID = '" + DataSourceOwnerUserID + "' and   FQN = '" + FQN + "' and   VersionNbr = " + VersionNbr;
            B = DBARCH.iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_UI_DataSource_01

        public int cnt_UKI_Documents(string SourceGuid)
        {
            int B = 0;
            string TBL = "DataSource";
            string WC = "Where SourceGuid = '" + SourceGuid + "'";
            B = DBARCH.iGetRowCount(TBL, WC);
            return B;
        }     // ** cnt_UKI_Documents

        // ** Generate Index ROW Queries 
        public SqlDataReader getRow__dta_index_DataSource_11_773577794__K1_K3_2_5_6_7_8_9_10_12_13_14(DateTime CreateDate, string DataSourceOwnerUserID, string FileDirectory, int FileLength, string FQN, string isPublic, DateTime LastAccessDate, DateTime LastWriteTime, string SourceGuid, string SourceName, string SourceTypeCode, int VersionNbr)
        {
            FQN = UTIL.RemoveSingleQuotes(FQN);
            SqlDataReader rsData = null;
            string TBL = "DataSource";
            string WC = "Where CreateDate = '" + Conversions.ToString(CreateDate) + "' and   DataSourceOwnerUserID = '" + DataSourceOwnerUserID + "' and   FileDirectory = '" + FileDirectory + "' and   FileLength = " + FileLength + " and   FQN = '" + FQN + "' and   isPublic = '" + isPublic + "' and   LastAccessDate = '" + Conversions.ToString(LastAccessDate) + "' and   LastWriteTime = '" + Conversions.ToString(LastWriteTime) + "' and   SourceGuid = '" + SourceGuid + "' and   SourceName = '" + SourceName + "' and   SourceTypeCode = '" + SourceTypeCode + "' and   VersionNbr = " + VersionNbr;
            rsData = DBARCH.GetRowByKey(TBL, WC);
            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow__dta_index_DataSource_11_773577794__K1_K3_2_5_6_7_8_9_10_12_13_14

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
            FQN = UTIL.RemoveSingleQuotes(FQN);
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

        public SqlDataReader getRow_UI_DataSource_01(string DataSourceOwnerUserID, string FQN, int VersionNbr)
        {
            FQN = UTIL.RemoveSingleQuotes(FQN);
            SqlDataReader rsData = null;
            string TBL = "DataSource";
            string WC = "Where DataSourceOwnerUserID = '" + DataSourceOwnerUserID + "' and   FQN = '" + FQN + "' and   VersionNbr = " + VersionNbr;
            rsData = DBARCH.GetRowByKey(TBL, WC);
            if (rsData.HasRows)
            {
                return rsData;
            }
            else
            {
                return null;
            }
        }     // ** getRow_UI_DataSource_01

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
        public string wc__dta_index_DataSource_11_773577794__K1_K3_2_5_6_7_8_9_10_12_13_14(DateTime CreateDate, string DataSourceOwnerUserID, string FileDirectory, int FileLength, string FQN, string isPublic, DateTime LastAccessDate, DateTime LastWriteTime, string SourceGuid, string SourceName, string SourceTypeCode, int VersionNbr)
        {
            FQN = UTIL.RemoveSingleQuotes(FQN);
            string WC = "Where CreateDate = '" + Conversions.ToString(CreateDate) + "' and   DataSourceOwnerUserID = '" + DataSourceOwnerUserID + "' and   FileDirectory = '" + FileDirectory + "' and   FileLength = " + FileLength + " and   FQN = '" + FQN + "' and   isPublic = '" + isPublic + "' and   LastAccessDate = '" + Conversions.ToString(LastAccessDate) + "' and   LastWriteTime = '" + Conversions.ToString(LastWriteTime) + "' and   SourceGuid = '" + SourceGuid + "' and   SourceName = '" + SourceName + "' and   SourceTypeCode = '" + SourceTypeCode + "' and   VersionNbr = " + VersionNbr;
            return WC;
        }     // ** wc__dta_index_DataSource_11_773577794__K1_K3_2_5_6_7_8_9_10_12_13_14

        public string wc_PI_DIR(string DataSourceOwnerUserID, string FileDirectory)
        {
            string WC = "Where DataSourceOwnerUserID = '" + DataSourceOwnerUserID + "' and   FileDirectory = '" + FileDirectory + "'";
            return WC;
        }     // ** wc_PI_DIR

        public string wc_PI_FQN_USERID(string DataSourceOwnerUserID, string FQN)
        {
            FQN = UTIL.RemoveSingleQuotes(FQN);
            string WC = "Where DataSourceOwnerUserID = '" + DataSourceOwnerUserID + "' and   FQN = '" + FQN + "'";
            return WC;
        }     // ** wc_PI_FQN_USERID

        public string wc_PK33_04012008185318001(string DataSourceOwnerUserID, string SourceGuid)
        {
            string WC = "Where DataSourceOwnerUserID = '" + DataSourceOwnerUserID + "' and   SourceGuid = '" + SourceGuid + "'";
            return WC;
        }     // ** wc_PK33_04012008185318001

        public string wc_UI_DataSource_01(string DataSourceOwnerUserID, string FQN, int VersionNbr)
        {
            FQN = UTIL.RemoveSingleQuotes(FQN);
            string WC = "Where DataSourceOwnerUserID = '" + DataSourceOwnerUserID + "' and   FQN = '" + FQN + "' and   VersionNbr = " + VersionNbr;
            return WC;
        }     // ** wc_UI_DataSource_01

        public string wc_UKI_Documents(string SourceGuid)
        {
            string WC = "Where SourceGuid = '" + SourceGuid + "'";
            return WC;
        }     // ** wc_UKI_Documents

        // ** Generate the SET methods 


        public bool ImageUpdt_SourceImage(string WhereClause, string FQN)
        {
            FQN = UTIL.RemoveSingleQuotes(FQN);
            bool b = false;
            string ConnStr = DBARCH.setConnStr();     // DBARCH.getGateWayConnStr(gGateWayID)
            var connection = new SqlConnection(ConnStr);
            var command = new SqlCommand("UPDATE DataSource SET SourceImage = @FileContents '" + WhereClause + "'", connection);
            try
            {
                command.Parameters.Add("@FileContents", SqlDbType.VarBinary).Value = File.ReadAllBytes(FQN);
                connection.Open();
                command.ExecuteNonQuery();
                connection.Close();
                b = true;
            }
            catch (Exception ex)
            {
                Console.WriteLine(command.CommandText);
                LOG.WriteToArchiveLog("Error 22.345.22 - Failed to add source image." + Constants.vbCrLf + command.CommandText);
                b = false;
            }

            return b;
        }

        public bool ImageToFile_SourceImage(string WhereClause, string FQN, bool OverWrite)
        {
            FQN = UTIL.RemoveSingleQuotes(FQN);
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
                da.Fill(ds, "DataSource");
                DataRow myRow;
                myRow = ds.Tables["DataSource"].Rows[0];
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
                    DBARCH.xTrace(58342.15, "image write - DataSource:SourceImage", ex.Message);
                    B = false;
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
                DBARCH.xTrace(58342.1, "DataSource", ex.Message);
            }

            return B;
        }
    }
}