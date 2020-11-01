// VBConversions Note: VB project level imports
using System.Collections.Generic;
using System;
using System.Drawing;
using System.Linq;
using System.Diagnostics;
using System.Data;
using Microsoft.VisualBasic;
using MODI;
using System.Xml.Linq;
using System.Collections;
using System.Windows.Forms;
// End of VB project level imports

using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Data.Sql;


namespace EcmArchiveClcSetup
{
	public class clsDATASOURCE_V2
	{
		
		//** DIM the selected table columns
		clsDatabase DB = new clsDatabase();
		clsDma DMA = new clsDma();
		clsDataGrid DG = new clsDataGrid();
		clsUtility UTIL = new clsUtility();
		clsLogging LOG = new clsLogging();
		
		
		
		string SourceGuid = "";
		string CreateDate = "";
		string SourceName = "";
		string SourceImage = "";
		string SourceTypeCode = "";
		string FQN = "";
		string VersionNbr = "";
		string LastAccessDate = "";
		string FileLength = "";
		string LastWriteTime = "";
		string UserID = "";
		string DataSourceOwnerUserID = "";
		string isPublic = "";
		string FileDirectory = "";
		string OriginalFileType = "";
		string RetentionExpirationDate = "";
		string IsPublicPreviousState = "";
		string isAvailable = "";
		string isContainedWithinZipFile = "";
		string IsZipFile = "";
		string DataVerified = "";
		string ZipFileGuid = "";
		string ZipFileFQN = "";
		string Description = "";
		string KeyWords = "";
		string Notes = "";
		string isPerm = "";
		string isMaster = "";
		string CreationDate = "";
		string OcrPerformed = "";
		string isGraphic = "";
		string GraphicContainsText = "";
		string OcrText = "";
		string ImageHiddenText = "";
		string isWebPage = "";
		
		
		//** Generate the SET methods
		public void setSourceguid(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Sourceguid\' cannot be NULL.");
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
			if (val.Length == 0)
			{
				val = "null";
			}
			val = UTIL.RemoveSingleQuotes(val);
			SourceImage = val;
		}
		
		public void setSourcetypecode(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Sourcetypecode\' cannot be NULL.");
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
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Versionnbr\' cannot be NULL.");
				return;
			}
			if (val.Length == 0)
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
			if (val.Length == 0)
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
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Datasourceowneruserid\' cannot be NULL.");
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
			if (val.Length == 0)
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
		
		
		
		//** Generate the GET methods
		public string getSourceguid()
		{
			if (SourceGuid.Length == 0)
			{
				MessageBox.Show("GET: Field \'Sourceguid\' cannot be NULL.");
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
			if (SourceImage.Length == 0)
			{
				SourceImage = "null";
			}
			return SourceImage;
		}
		
		public string getSourcetypecode()
		{
			if (SourceTypeCode.Length == 0)
			{
				MessageBox.Show("GET: Field \'Sourcetypecode\' cannot be NULL.");
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
			if (VersionNbr.Length == 0)
			{
				MessageBox.Show("GET: Field \'Versionnbr\' cannot be NULL.");
				return "";
			}
			if (VersionNbr.Length == 0)
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
			if (FileLength.Length == 0)
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
			if (DataSourceOwnerUserID.Length == 0)
			{
				MessageBox.Show("GET: Field \'Datasourceowneruserid\' cannot be NULL.");
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
			if (DataVerified.Length == 0)
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
		
		
		
		//** Generate the Required Fields Validation method
		public bool ValidateReqData()
		{
			if (SourceGuid.Length == 0)
			{
				return false;
			}
			if (SourceTypeCode.Length == 0)
			{
				return false;
			}
			if (VersionNbr.Length == 0)
			{
				return false;
			}
			if (DataSourceOwnerUserID.Length == 0)
			{
				return false;
			}
			return true;
		}
		
		
		//** Generate the Validation method
		public bool ValidateData()
		{
			if (SourceGuid.Length == 0)
			{
				return false;
			}
			if (SourceTypeCode.Length == 0)
			{
				return false;
			}
			if (VersionNbr.Length == 0)
			{
				return false;
			}
			if (DataSourceOwnerUserID.Length == 0)
			{
				return false;
			}
			return true;
		}
		
		
		//** Generate the INSERT method
		public bool Insert(string CRC)
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
			s = s + "isWebPage, CRC) values (";
			s = s + "\'" + SourceGuid + "\'" + ",";
			s = s + "\'" + CreateDate + "\'" + ",";
			s = s + "\'" + SourceName + "\'" + ",";
			//SourceImage
			s = s + "null" + ",";
			s = s + "\'" + SourceTypeCode + "\'" + ",";
			FQN = UTIL.RemoveSingleQuotes(FQN);
			s = s + "\'" + FQN + "\'" + ",";
			s = s + VersionNbr + ",";
			s = s + "\'" + LastAccessDate + "\'" + ",";
			//FileLength
			s = s + "null" + ",";
			s = s + "\'" + LastWriteTime + "\'" + ",";
			s = s + "\'" + UserID + "\'" + ",";
			s = s + "\'" + DataSourceOwnerUserID + "\'" + ",";
			s = s + "\'" + isPublic + "\'" + ",";
			s = s + "\'" + FileDirectory + "\'" + ",";
			s = s + "\'" + OriginalFileType + "\'" + ",";
			s = s + "\'" + RetentionExpirationDate + "\'" + ",";
			s = s + "\'" + IsPublicPreviousState + "\'" + ",";
			s = s + "\'" + isAvailable + "\'" + ",";
			s = s + "\'" + isContainedWithinZipFile + "\'" + ",";
			s = s + "\'" + IsZipFile + "\'" + ",";
			//DataVerified
			s = s + "null" + ",";
			s = s + "\'" + ZipFileGuid + "\'" + ",";
			s = s + "\'" + ZipFileFQN + "\'" + ",";
			s = s + "\'" + Description + "\'" + ",";
			s = s + "\'" + KeyWords + "\'" + ",";
			s = s + "\'" + Notes + "\'" + ",";
			s = s + "\'" + isPerm + "\'" + ",";
			s = s + "\'" + isMaster + "\'" + ",";
			s = s + "\'" + CreationDate + "\'" + ",";
			s = s + "\'" + OcrPerformed + "\'" + ",";
			s = s + "\'" + isGraphic + "\'" + ",";
			s = s + "\'" + GraphicContainsText + "\'" + ",";
			s = s + "\'" + OcrText + "\'" + ",";
			s = s + "\'" + ImageHiddenText + "\'" + ",";
			s = s + "\'" + isWebPage + "\'" + ",";
			s = s + "\'" + CRC + "\'" + ")";
			
			return DB.ExecuteSqlNewConn(s, false);
			
		}
		
		
		//** Generate the UPDATE method
		public bool Update(string WhereClause)
		{
			bool b = false;
			string s = "";
			
			if (WhereClause.Length == 0)
			{
				return false;
			}
			
			s = s + " update DataSource set ";
			s = s + "SourceGuid = \'" + getSourceguid() + "\'" + ", ";
			s = s + "CreateDate = \'" + getCreatedate() + "\'" + ", ";
			s = s + "SourceName = \'" + getSourcename() + "\'" + ", ";
			s = s + "SourceImage = " + getSourceimage() + ", ";
			s = s + "SourceTypeCode = \'" + getSourcetypecode() + "\'" + ", ";
			s = s + "FQN = \'" + getFqn() + "\'" + ", ";
			s = s + "VersionNbr = " + getVersionnbr() + ", ";
			s = s + "LastAccessDate = \'" + getLastaccessdate() + "\'" + ", ";
			s = s + "FileLength = " + getFilelength() + ", ";
			s = s + "LastWriteTime = \'" + getLastwritetime() + "\'" + ", ";
			s = s + "UserID = \'" + getUserid() + "\'" + ", ";
			s = s + "DataSourceOwnerUserID = \'" + getDatasourceowneruserid() + "\'" + ", ";
			s = s + "isPublic = \'" + getIspublic() + "\'" + ", ";
			s = s + "FileDirectory = \'" + getFiledirectory() + "\'" + ", ";
			s = s + "OriginalFileType = \'" + getOriginalfiletype() + "\'" + ", ";
			s = s + "RetentionExpirationDate = \'" + getRetentionexpirationdate() + "\'" + ", ";
			s = s + "IsPublicPreviousState = \'" + getIspublicpreviousstate() + "\'" + ", ";
			s = s + "isAvailable = \'" + getIsavailable() + "\'" + ", ";
			s = s + "isContainedWithinZipFile = \'" + getIscontainedwithinzipfile() + "\'" + ", ";
			s = s + "IsZipFile = \'" + getIszipfile() + "\'" + ", ";
			s = s + "DataVerified = " + getDataverified() + ", ";
			s = s + "ZipFileGuid = \'" + getZipfileguid() + "\'" + ", ";
			s = s + "ZipFileFQN = \'" + getZipfilefqn() + "\'" + ", ";
			s = s + "Description = \'" + getDescription() + "\'" + ", ";
			s = s + "KeyWords = \'" + getKeywords() + "\'" + ", ";
			s = s + "Notes = \'" + getNotes() + "\'" + ", ";
			s = s + "isPerm = \'" + getIsperm() + "\'" + ", ";
			s = s + "isMaster = \'" + getIsmaster() + "\'" + ", ";
			s = s + "CreationDate = \'" + getCreationdate() + "\'" + ", ";
			s = s + "OcrPerformed = \'" + getOcrperformed() + "\'" + ", ";
			s = s + "isGraphic = \'" + getIsgraphic() + "\'" + ", ";
			s = s + "GraphicContainsText = \'" + getGraphiccontainstext() + "\'" + ", ";
			s = s + "OcrText = \'" + getOcrtext() + "\'" + ", ";
			s = s + "ImageHiddenText = \'" + getImagehiddentext() + "\'" + ", ";
			s = s + "isWebPage = \'" + getIswebpage() + "\'";
			WhereClause = (string) (" " + WhereClause);
			s = s + WhereClause;
			return DB.ExecuteSqlNewConn(s, false);
		}
		
		
		//** Generate the SELECT method
		public SqlDataReader SelectRecs()
		{
			bool b = false;
			string s = "";
			SqlDataReader rsData;
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
			//** s=s+ "ORDERBY xxxx"
			string CS = DB.getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(s, CONN);
			rsData = command.ExecuteReader();
			return rsData;
		}
		
		
		//** Generate the Select One Row method
		public SqlDataReader SelectOne(string WhereClause)
		{
			bool b = false;
			string s = "";
			SqlDataReader rsData;
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
			//** s=s+ "ORDERBY xxxx"
			string CS = DB.getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(s, CONN);
			rsData = command.ExecuteReader();
			return rsData;
		}
		
		
		//** Generate the DELETE method
		public bool Delete(string WhereClause)
		{
			bool b = false;
			string s = "";
			
			if (WhereClause.Length == 0)
			{
				return false;
			}
			
			WhereClause = (string) (" " + WhereClause);
			
			s = " Delete from DataSource";
			s = s + WhereClause;
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
		}
		
		
		//** Generate the Zeroize Table method
		public bool Zeroize()
		{
			bool b = false;
			string s = "";
			
			s = s + " Delete from DataSource";
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
		}
		
		
		//** Generate Index Queries
		public int cnt__dta_index_DataSource_11_773577794__K1_K3_2_5_6_7_8_9_10_12_13_14(DateTime CreateDate, string DataSourceOwnerUserID, string FileDirectory, int FileLength, string FQN, string isPublic, DateTime LastAccessDate, DateTime LastWriteTime, string SourceGuid, string SourceName, string SourceTypeCode, int VersionNbr)
		{
			FQN = UTIL.RemoveSingleQuotes(FQN);
			int B = 0;
			string TBL = "DataSource";
			
			string WC = (string) ("Where CreateDate = \'" + CreateDate + "\' and   DataSourceOwnerUserID = \'" + DataSourceOwnerUserID + "\' and   FileDirectory = \'" + FileDirectory + "\' and   FileLength = " + FileLength.ToString() + ("and   FQN = \'" + FQN + "\' and   isPublic = \'" + isPublic + "\' and   LastAccessDate = \'" + LastAccessDate + "\' and   LastWriteTime = \'" + LastWriteTime + "\' and   SourceGuid = \'" + SourceGuid + "\' and   SourceName = \'" + SourceName + "\' and   SourceTypeCode = \'" + SourceTypeCode + "\' and   VersionNbr = ") + VersionNbr.ToString());
			
			B = DB.iGetRowCount(TBL, WC);
			
			return B;
		} //** cnt__dta_index_DataSource_11_773577794__K1_K3_2_5_6_7_8_9_10_12_13_14
		public int cnt_PI_DIR(string DataSourceOwnerUserID, string FileDirectory)
		{
			
			int B = 0;
			string TBL = "DataSource";
			string WC = "Where DataSourceOwnerUserID = \'" + DataSourceOwnerUserID + "\' and   FileDirectory = \'" + FileDirectory + "\'";
			
			B = DB.iGetRowCount(TBL, WC);
			
			return B;
		} //** cnt_PI_DIR
		public int cnt_PI_FQN_USERID(string DataSourceOwnerUserID, string FQN)
		{
			FQN = UTIL.RemoveSingleQuotes(FQN);
			int B = 0;
			string TBL = "DataSource";
			string WC = "Where DataSourceOwnerUserID = \'" + DataSourceOwnerUserID + "\' and   FQN = \'" + FQN + "\'";
			
			B = DB.iGetRowCount(TBL, WC);
			
			return B;
		} //** cnt_PI_FQN_USERID
		public int cnt_PK33_04012008185318001(string DataSourceOwnerUserID, string SourceGuid)
		{
			
			int B = 0;
			string TBL = "DataSource";
			string WC = "Where DataSourceOwnerUserID = \'" + DataSourceOwnerUserID + "\' and   SourceGuid = \'" + SourceGuid + "\'";
			
			B = DB.iGetRowCount(TBL, WC);
			
			return B;
		} //** cnt_PK33_04012008185318001
		public int cnt_UI_DataSource_01(string DataSourceOwnerUserID, string FQN, int VersionNbr)
		{
			FQN = UTIL.RemoveSingleQuotes(FQN);
			int B = 0;
			string TBL = "DataSource";
			string WC = (string) ("Where DataSourceOwnerUserID = \'" + DataSourceOwnerUserID + "\' and   FQN = \'" + FQN + "\' and   VersionNbr = " + VersionNbr.ToString());
			
			B = DB.iGetRowCount(TBL, WC);
			
			return B;
		} //** cnt_UI_DataSource_01
		public int cnt_UKI_Documents(string SourceGuid)
		{
			
			int B = 0;
			string TBL = "DataSource";
			string WC = "Where SourceGuid = \'" + SourceGuid + "\'";
			
			B = DB.iGetRowCount(TBL, WC);
			
			return B;
		} //** cnt_UKI_Documents
		
		//** Generate Index ROW Queries
		public SqlDataReader getRow__dta_index_DataSource_11_773577794__K1_K3_2_5_6_7_8_9_10_12_13_14(DateTime CreateDate, string DataSourceOwnerUserID, string FileDirectory, int FileLength, string FQN, string isPublic, DateTime LastAccessDate, DateTime LastWriteTime, string SourceGuid, string SourceName, string SourceTypeCode, int VersionNbr)
		{
			FQN = UTIL.RemoveSingleQuotes(FQN);
			SqlDataReader rsData = null;
			string TBL = "DataSource";
			string WC = (string) ("Where CreateDate = \'" + CreateDate + "\' and   DataSourceOwnerUserID = \'" + DataSourceOwnerUserID + "\' and   FileDirectory = \'" + FileDirectory + "\' and   FileLength = " + FileLength.ToString() + (" and   FQN = \'" + FQN + "\' and   isPublic = \'" + isPublic + "\' and   LastAccessDate = \'" + LastAccessDate + "\' and   LastWriteTime = \'" + LastWriteTime + "\' and   SourceGuid = \'" + SourceGuid + "\' and   SourceName = \'" + SourceName + "\' and   SourceTypeCode = \'" + SourceTypeCode + "\' and   VersionNbr = ") + VersionNbr.ToString());
			
			rsData = DB.GetRowByKey(TBL, WC);
			
			if (rsData.HasRows)
			{
				return rsData;
			}
			else
			{
				return null;
			}
		} //** getRow__dta_index_DataSource_11_773577794__K1_K3_2_5_6_7_8_9_10_12_13_14
		public SqlDataReader getRow_PI_DIR(string DataSourceOwnerUserID, string FileDirectory)
		{
			
			SqlDataReader rsData = null;
			string TBL = "DataSource";
			string WC = "Where DataSourceOwnerUserID = \'" + DataSourceOwnerUserID + "\' and   FileDirectory = \'" + FileDirectory + "\'";
			
			rsData = DB.GetRowByKey(TBL, WC);
			
			if (rsData.HasRows)
			{
				return rsData;
			}
			else
			{
				return null;
			}
		} //** getRow_PI_DIR
		public SqlDataReader getRow_PI_FQN_USERID(string DataSourceOwnerUserID, string FQN)
		{
			FQN = UTIL.RemoveSingleQuotes(FQN);
			SqlDataReader rsData = null;
			string TBL = "DataSource";
			string WC = "Where DataSourceOwnerUserID = \'" + DataSourceOwnerUserID + "\' and   FQN = \'" + FQN + "\'";
			
			rsData = DB.GetRowByKey(TBL, WC);
			
			if (rsData.HasRows)
			{
				return rsData;
			}
			else
			{
				return null;
			}
		} //** getRow_PI_FQN_USERID
		public SqlDataReader getRow_PK33_04012008185318001(string DataSourceOwnerUserID, string SourceGuid)
		{
			
			SqlDataReader rsData = null;
			string TBL = "DataSource";
			string WC = "Where DataSourceOwnerUserID = \'" + DataSourceOwnerUserID + "\' and   SourceGuid = \'" + SourceGuid + "\'";
			
			rsData = DB.GetRowByKey(TBL, WC);
			
			if (rsData.HasRows)
			{
				return rsData;
			}
			else
			{
				return null;
			}
		} //** getRow_PK33_04012008185318001
		public SqlDataReader getRow_UI_DataSource_01(string DataSourceOwnerUserID, string FQN, int VersionNbr)
		{
			FQN = UTIL.RemoveSingleQuotes(FQN);
			SqlDataReader rsData = null;
			string TBL = "DataSource";
			string WC = (string) ("Where DataSourceOwnerUserID = \'" + DataSourceOwnerUserID + "\' and   FQN = \'" + FQN + "\' and   VersionNbr = " + VersionNbr.ToString());
			
			rsData = DB.GetRowByKey(TBL, WC);
			
			if (rsData.HasRows)
			{
				return rsData;
			}
			else
			{
				return null;
			}
		} //** getRow_UI_DataSource_01
		public SqlDataReader getRow_UKI_Documents(string SourceGuid)
		{
			
			SqlDataReader rsData = null;
			string TBL = "DataSource";
			string WC = "Where SourceGuid = \'" + SourceGuid + "\'";
			
			rsData = DB.GetRowByKey(TBL, WC);
			
			if (rsData.HasRows)
			{
				return rsData;
			}
			else
			{
				return null;
			}
		} //** getRow_UKI_Documents
		
		/// Build Index Where Caluses
		///
		public string wc__dta_index_DataSource_11_773577794__K1_K3_2_5_6_7_8_9_10_12_13_14(DateTime CreateDate, string DataSourceOwnerUserID, string FileDirectory, int FileLength, string FQN, string isPublic, DateTime LastAccessDate, DateTime LastWriteTime, string SourceGuid, string SourceName, string SourceTypeCode, int VersionNbr)
		{
			FQN = UTIL.RemoveSingleQuotes(FQN);
			string WC = (string) ("Where CreateDate = \'" + CreateDate + "\' and   DataSourceOwnerUserID = \'" + DataSourceOwnerUserID + "\' and   FileDirectory = \'" + FileDirectory + "\' and   FileLength = " + FileLength.ToString() + (" and   FQN = \'" + FQN + "\' and   isPublic = \'" + isPublic + "\' and   LastAccessDate = \'" + LastAccessDate + "\' and   LastWriteTime = \'" + LastWriteTime + "\' and   SourceGuid = \'" + SourceGuid + "\' and   SourceName = \'" + SourceName + "\' and   SourceTypeCode = \'" + SourceTypeCode + "\' and   VersionNbr = ") + VersionNbr.ToString());
			
			return WC;
		} //** wc__dta_index_DataSource_11_773577794__K1_K3_2_5_6_7_8_9_10_12_13_14
		public string wc_PI_DIR(string DataSourceOwnerUserID, string FileDirectory)
		{
			
			string WC = "Where DataSourceOwnerUserID = \'" + DataSourceOwnerUserID + "\' and   FileDirectory = \'" + FileDirectory + "\'";
			
			return WC;
		} //** wc_PI_DIR
		public string wc_PI_FQN_USERID(string DataSourceOwnerUserID, string FQN)
		{
			FQN = UTIL.RemoveSingleQuotes(FQN);
			string WC = "Where DataSourceOwnerUserID = \'" + DataSourceOwnerUserID + "\' and   FQN = \'" + FQN + "\'";
			
			return WC;
		} //** wc_PI_FQN_USERID
		public string wc_PK33_04012008185318001(string DataSourceOwnerUserID, string SourceGuid)
		{
			
			string WC = "Where DataSourceOwnerUserID = \'" + DataSourceOwnerUserID + "\' and   SourceGuid = \'" + SourceGuid + "\'";
			
			return WC;
		} //** wc_PK33_04012008185318001
		public string wc_UI_DataSource_01(string DataSourceOwnerUserID, string FQN, int VersionNbr)
		{
			FQN = UTIL.RemoveSingleQuotes(FQN);
			string WC = (string) ("Where DataSourceOwnerUserID = \'" + DataSourceOwnerUserID + "\' and   FQN = \'" + FQN + "\' and   VersionNbr = " + VersionNbr.ToString());
			
			return WC;
		} //** wc_UI_DataSource_01
		public string wc_UKI_Documents(string SourceGuid)
		{
			
			string WC = "Where SourceGuid = \'" + SourceGuid + "\'";
			
			return WC;
		} //** wc_UKI_Documents
		
		//** Generate the SET methods
		
		
		public bool ImageUpdt_SourceImage(string WhereClause, string FQN)
		{
			FQN = UTIL.RemoveSingleQuotes(FQN);
			bool b = false;
			string ConnStr = DB.getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection connection = new SqlConnection(ConnStr);
			SqlCommand command = new SqlCommand("UPDATE DataSource SET SourceImage = @FileContents \'" + WhereClause + "\'", connection);
			
			try
			{
				command.Parameters.Add("@FileContents", SqlDbType.VarBinary).Value = System.IO.File.ReadAllBytes(FQN);
				connection.Open();
				command.ExecuteNonQuery();
				connection.Close();
				b = true;
			}
			catch (Exception)
			{
				Console.WriteLine(command.CommandText);
				LOG.WriteToArchiveLog((string) ("Error 22.345.22 - Failed to add source image." + "\r\n" + command.CommandText));
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
				
				SqlConnection CN = new SqlConnection(DB.getGateWayConnStr(modGlobals.gGateWayID));
				
				if (CN.State == ConnectionState.Closed)
				{
					CN.Open();
				}
				
				SqlDataAdapter da = new SqlDataAdapter(S, CN);
				SqlCommandBuilder MyCB = new SqlCommandBuilder(da);
				DataSet ds = new DataSet();
				
				da.Fill(ds, "DataSource");
				DataRow myRow;
				myRow = ds.Tables["DataSource"].Rows[0];
				
				byte[] MyData;
				MyData = myRow[SourceImage];
				long K;
				K = MyData.Length - 1;
				try
				{
					if (OverWrite)
					{
						//If File.Exists(FQN) Then
						//    File.Delete(FQN)
						//End If
					}
					else
					{
						if (File.Exists(FQN))
						{
							return false;
						}
					}
					FileStream fs = new FileStream(FQN, FileMode.Create, FileAccess.Write);
					fs.Write(MyData, 0, K);
					fs.Close();
					fs = null;
					B = true;
				}
				catch (Exception ex)
				{
					Debug.Print(ex.Message);
					DB.xTrace((int) 58342.15, "image write - DataSource:SourceImage", ex.Message);
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
				DB.xTrace((int) 58342.1, "DataSource", ex.Message);
			}
			return B;
			
		}
	}
	
}
