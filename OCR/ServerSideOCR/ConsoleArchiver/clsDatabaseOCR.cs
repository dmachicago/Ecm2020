using ECMEncryption;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace ConsoleArchiver
{
    internal class clsDatabaseOCR
    {

        private int MAXOCRSIZE = 0;
        private ECMEncrypt ENC = new ECMEncrypt();
        private bool traceon = MainPage.traceon;
        private clsLogging log = new clsLogging();

        private string ConnStr = "";
        private static SqlConnection dbConn = null;
        private SqlCommand cmd = null;

        public string getEncPW()
        {
            string MaxSize = System.Configuration.ConfigurationManager.AppSettings["MAXOCRSIZE"].ToString();
            MAXOCRSIZE = Convert.ToInt32(MaxSize);

            string pw = System.Configuration.ConfigurationManager.AppSettings["ENCPW"].ToString();
            pw = ENC.AES256DecryptString(pw);
            return pw;
        }

        //OcrType = S = Content, E = EMAIL, A = Email Attachment
        public bool validateOcrSize(string sguid, string OcrType)
        {
            string MySql = "";
            bool b = true;
            string cs = getCS();
            using (SqlConnection NewDbConn = new SqlConnection(cs))
            {
                try
                {
                    NewDbConn.Open();
                }
                catch (Exception ex)
                {
                    string RMsg = "validateOcrSize: 03A - " + ex.Message.ToString();
                    log.write(traceon, RMsg);
                    return false;
                }

                using (cmd = new SqlCommand())
                {
                    cmd.Connection = NewDbConn;
                    if (OcrType.ToUpper().Equals("C"))
                        MySql = "select DATALENGTH(SourceImage) DL from DataSource where SourceGuid  = '" + sguid + "'; ";
                    if (OcrType.ToUpper().Equals("A"))
                        MySql = "select DATALENGTH(Attachment) DL from [EmailAttachment] where RowGuid  = '" + sguid + "'; ";

                    cmd.CommandText = MySql;
                    using (SqlDataReader sqlReader = cmd.ExecuteReader())
                    {
                        if (sqlReader.HasRows)
                        {
                            while (sqlReader.Read())
                            {
                                string ocrsize = sqlReader[0].ToString();
                                if (Convert.ToInt32(ocrsize) >= MAXOCRSIZE)
                                    b = false;
                                else
                                    b = true;
                            }
                        }
                    }
                }
            }
            return b;
        }


        public void getAllOcrRequiredContent(ref Dictionary<string, string> LisOfGuids,
                    string ContentType,
                    ref string RetMsg)
        {
            string BatchSize = System.Configuration.ConfigurationManager.AppSettings["BatchSize"].ToString();
            string dDebug = System.Configuration.ConfigurationManager.AppSettings["DebugOn"].ToString();
            string cs = getCS();

            if (dDebug.Equals("1"))
            {
                log.write(traceon, "CS: " + cs);
            }

            using (SqlConnection NewDbConn = new SqlConnection(cs))
            {
                if (dDebug.Equals("1"))
                {
                    log.write(traceon, "getAllOcrRequiredContent: 01");
                }
                try
                {
                    NewDbConn.Open();
                    if (dDebug.Equals("1"))
                    {
                        log.write(traceon, "getAllOcrRequiredContent: 02");
                    }
                }
                catch (Exception ex)
                {
                    log.write(traceon, "getAllOcrRequiredContent: 03 - " + ex.Message.ToString());
                    RetMsg = "getAllOcrRequiredContent: 03 - " + ex.Message.ToString();
                    return;
                }
                string MySql = "";
                using (cmd = new SqlCommand())
                {
                    cmd.Connection = NewDbConn;

                    if (ContentType.Equals("C"))
                    {
                        if (BatchSize.Equals(0))
                        {
                            MySql = "select SourceGuid from [DataSource] where SourceGuid in (" + Environment.NewLine;
                        }
                        else
                        {
                            MySql = "select top "+BatchSize+" SourceGuid from [DataSource] where SourceGuid in (" + Environment.NewLine;
                        } 

                        MySql += "SELECT[SourceGuid] " + Environment.NewLine;
                        MySql += "FROM[dbo].[DataSource] DS " + Environment.NewLine;
                        MySql += "join[dbo].[LoadProfileItem] LPI ON " + Environment.NewLine;
                        MySql += "(DS.SourceTypeCode = LPI.SourceTypeCode or DS.SourceTypeCode = '.pdf') " + Environment.NewLine;
                        MySql += "and (ProfileName = 'Graphics Files' " + Environment.NewLine;
                        MySql += "or ProfileName = 'Graphics') " + Environment.NewLine;
                        MySql += "and ([OcrPerformed] = '0' or[OcrPerformed] = 'N' or[OcrPerformed] is null)) " + Environment.NewLine;
                        MySql += "--and (OcrPending != 'N' or OcrPending = '0' or OcrPending is null) " + Environment.NewLine;
                    }
                    else if (ContentType.Equals("A"))
                    {
                        if (BatchSize.Equals(0))
                        {
                            MySql += "select RowGuid from [EmailAttachment] where RowGuid in ( " + Environment.NewLine;
                        }
                        else
                        {
                            MySql += "select top "+BatchSize+" RowGuid from [EmailAttachment] where RowGuid in ( " + Environment.NewLine;
                        }
                        
                        MySql += "SELECT EA.[RowGuid] " + Environment.NewLine;
                        MySql += "FROM [dbo].[EmailAttachment] EA " + Environment.NewLine;
                        MySql += "join [dbo].[LoadProfileItem] LPI ON " + Environment.NewLine;
                        MySql += "(EA.AttachmentType = LPI.SourceTypeCode " + Environment.NewLine;
                        MySql += "or EA.AttachmentType = '.pdf') " + Environment.NewLine;
                        MySql += "and (ProfileName = 'Graphics Files' " + Environment.NewLine;
                        MySql += "or ProfileName = 'Graphics') " + Environment.NewLine;
                        MySql += "and ([OcrPerformed] = '0' or [OcrPerformed] = 'N' or [OcrPerformed] is null)) " + Environment.NewLine;
                        MySql += "--and (OcrPending != 'N' or OcrPending = '0' or OcrPending is null)) " + Environment.NewLine;
                    }
                    else
                    {
                        RetMsg = "You must specify the CONTENT TYPE CODE, fix it.";
                        log.write(traceon, "You must specify the CONTENT TYPE CODE, fix it.");
                        return;
                    }

                    cmd.CommandText = MySql;

                    using (SqlDataReader sqlReader = cmd.ExecuteReader())
                    {
                        if (sqlReader.HasRows)
                        {
                            while (sqlReader.Read())
                            {
                                string strGuid = (string)sqlReader[0].ToString();
                                if (!LisOfGuids.ContainsKey(strGuid))
                                {
                                    LisOfGuids.Add(strGuid, ContentType);
                                }
                            }
                        }
                    }
                }
            }

            GC.Collect();
            GC.WaitForPendingFinalizers();

            return;
        }

        public List<string> getOcrRequiredDocs(string cs, string ContentType, ref string RetMsg)
        {
            List<string> guids = new List<string>();

            SqlConnection NewDbConn = new SqlConnection(cs);
            NewDbConn.Open();

            cmd = new SqlCommand();
            cmd.Connection = NewDbConn;
            bool UseTop50 = true;

            if (ContentType.Equals("C"))
            {
                if (UseTop50)
                {
                    cmd.CommandText = "SELECT top 50 SourceGuid FROM DataSource WHERE OcrRequired = 1";
                }
                else
                {
                    cmd.CommandText = "SELECT SourceGuid FROM DataSource WHERE OcrRequired = 1";
                }
            }
            else if (ContentType.Equals("A"))
            {
                if (UseTop50)
                {
                    cmd.CommandText = "SELECT  top 50 RowGuid FROM EmailAttachment WHERE OcrRequired = 1";
                }
                else
                {
                    cmd.CommandText = "SELECT RowGuid FROM EmailAttachment WHERE OcrRequired = 1";
                }
            }
            else
            {
                RetMsg = "You must specify the CONTENT TYPE CODE, fix it.";
                return null;
            }

            SqlDataReader sqlReader = cmd.ExecuteReader();

            if (sqlReader.HasRows)
            {
                while (sqlReader.Read())
                {
                    string strGuid = (string)sqlReader[0];
                    guids.Add(strGuid);
                }
            }

            sqlReader.Close();
            cmd.Dispose();
            NewDbConn.Close();
            NewDbConn.Dispose();

            GC.Collect();
            GC.WaitForPendingFinalizers();

            return guids;
        }

        public byte[] getContent(string cs, string ContentGuid, string ContentType, ref string FileName, ref string RetMsg)
        {
            FileName = "";
            ContentType = ContentType.ToUpper();

            byte[] fileData = null;

            bool b = ckDbConnection();

            cmd = new SqlCommand();
            cmd.Connection = dbConn;

            if (ContentType.Equals("C"))
            {
                cmd.CommandText = "SELECT SourceName, SourceImage, SourceGuid FROM DataSource WHERE SourceGuid = @ContentGuid";
            }
            else if (ContentType.Equals("A"))
            {
                cmd.CommandText = "SELECT AttachmentName, Attachment, RowGuid FROM EmailAttachment WHERE RowGuid = @ContentGuid";
            }
            else
            {
                RetMsg = "You must specify the CONTENT TYPE CODE, please fix it.";
                return null;
            }

            cmd.Parameters.Add("@ContentGuid", SqlDbType.NVarChar).Value = ContentGuid;
            SqlDataReader sqlReader = cmd.ExecuteReader();

            //string fileName = "file.txt";
            //string fileDir = "C:\\Test\\";
            //string fileUrl = "/";
            string sguid = "";
            if (sqlReader.HasRows)
            {
                while (sqlReader.Read())
                {
                    try
                    {
                        FileName = (string)sqlReader[0];
                        fileData = (byte[])sqlReader[1];
                        sguid = sqlReader[1].ToString();
                    }
                    catch (Exception ex)
                    {
                        log.write(traceon, "ERROR/getContent: 100 '" + sguid + "' : " + FileName + " - " + ex.Message);
                    }
                }
            }

            sqlReader.Close();
            sqlReader.Dispose();
            cmd.Dispose();

            GC.Collect();
            GC.WaitForPendingFinalizers();

            return fileData;
        }

        public bool updateOcrText(string cs, string ContentGuid, string ContentType, string OcrText, ref string RetMsg)
        {
            bool b = true;

            ContentType = ContentType.ToUpper();
            ckDbConnection();

            cmd = new SqlCommand();
            cmd.Connection = dbConn;

            if (ContentType.Equals("C"))
            {
                if (OcrText.Length > 0)
                {
                    cmd.CommandText = "Update DataSource set OcrPerformed = 'Y', RequireOcr = 0, OcrPending = 'N', GraphicContainsText = 'Y', OcrText = @OcrText  WHERE SourceGuid = @ContentGuid";
                }
                else
                {
                    cmd.CommandText = "Update DataSource set OcrPerformed = 'Y', RequireOcr = 0, OcrPending = 'N', GraphicContainsText = 'N', OcrText = @OcrText  WHERE SourceGuid = @ContentGuid";
                }
            }
            else if (ContentType.Equals("A"))
            {
                cmd.CommandText = "Update EmailAttachment set OcrText = @OcrText, RequireOcr = 0, OcrSuccessful = 'Y', OcrPending = 'N', OcrPerformed = 'Y'  WHERE RowGuid = @ContentGuid";
            }
            else
            {
                RetMsg = "You must specify the CONTENT TYPE CODE, fix it.";
                return false;
            }
            cmd.Parameters.Add("@OcrText", SqlDbType.NVarChar).Value = OcrText;
            cmd.Parameters.Add("@ContentGuid", SqlDbType.NVarChar).Value = ContentGuid;
            try
            {
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                Console.WriteLine("ERROR 3433: " + ex.Message);
                b = false;
            }
            finally
            {
                cmd.Dispose();
            }

            GC.Collect();
            GC.WaitForPendingFinalizers();

            return b;
        }

        public bool markPdfSearchable(string ContentGuid, string ContentType, string searchableFlag, ref string RetMsg)
        {
            ContentType = ContentType.ToUpper();

            bool b = ckDbConnection();

            cmd = new SqlCommand();
            cmd.Connection = dbConn;

            if (ContentType.Equals("C"))
            {
                string ctext = "";
                ctext = "Update DataSource set PdfIsSearchable = '" + searchableFlag + "', RequireOcr = 0, OcrPerformed = 'Y', OcrSuccessful = 'Y', OcrPending = 'N' WHERE SourceGuid = @ContentGuid";
                cmd.CommandText = ctext;
            }
            else if (ContentType.Equals("A"))
            {
                cmd.CommandText = "Update EmailAttachment set PdfIsSearchable = '" + searchableFlag + "', RequireOcr = 0, OcrPerformed = 'Y', OcrSuccessful = 'Y', OcrPending = 'N'  WHERE RowGuid = @ContentGuid";
            }
            else
            {
                RetMsg = "You must specify the CONTENT TYPE CODE, fix it.";
                return false;
            }
            cmd.Parameters.Add("@OcrText", SqlDbType.NVarChar).Value = ContentGuid;
            cmd.Parameters.Add("@ContentGuid", SqlDbType.NVarChar).Value = ContentGuid;
            try
            {
                cmd.ExecuteNonQuery();
                b = true;
            }
            catch (Exception ex)
            {
                Console.WriteLine("ERROR 3433: " + ex.Message);
                b = false;
            }
            finally
            {
                cmd.Dispose();
            }

            GC.Collect();
            GC.WaitForPendingFinalizers();

            return b;
        }

        public bool markOcrCompleteWithError(string cs, string ContentGuid, string ContentType, ref string RetMsg)
        {
            bool b = true;

            ContentType = ContentType.ToUpper();

            ckDbConnection();

            cmd = new SqlCommand();
            cmd.Connection = dbConn;

            if (ContentType.Equals("C"))
            {
                cmd.CommandText = "Update DataSource set RequireOcr = 0, OcrPerformed = 'Y', OcrSuccessful = 'N', OcrPending = 'N'   WHERE SourceGuid = @ContentGuid";
            }
            else if (ContentType.Equals("A"))
            {
                cmd.CommandText = "Update EmailAttachment set RequireOcr = 0, OcrPerformed = 'Y', OcrSuccessful = 'N', OcrPending = 'N' WHERE RowGuid = @ContentGuid";
            }
            else
            {
                RetMsg = "You must specify the CONTENT TYPE CODE, fix it.";
                return false;
            }
            cmd.Parameters.Add("@OcrText", SqlDbType.NVarChar).Value = ContentGuid;
            cmd.Parameters.Add("@ContentGuid", SqlDbType.NVarChar).Value = ContentGuid;
            try
            {
                cmd.ExecuteNonQuery();
                log.write(traceon, "Marked as complete OCR: '" + ContentGuid + "'");
            }
            catch (Exception ex)
            {
                Console.WriteLine("ERROR 3433: " + ex.Message);
                log.write(traceon, "ERROR 3433 Failed to mark as complete OCR: '" + cmd.CommandText + "'   / " + ex.Message);
                b = false;
            }
            finally
            {
                cmd.Dispose();
            }

            GC.Collect();
            GC.WaitForPendingFinalizers();

            return b;
        }

        public bool markOcrComplete(string cs, string ContentGuid, string ContentType, ref string RetMsg)
        {
            bool b = true;

            ContentType = ContentType.ToUpper();

            ckDbConnection();

            cmd = new SqlCommand();
            cmd.Connection = dbConn;

            if (ContentType.Equals("C"))
            {
                cmd.CommandText = "Update DataSource set RequireOcr = 0, OcrPerformed = 'Y', OcrSuccessful = 'Y', OcrPending = 'N'   WHERE SourceGuid = @ContentGuid";
            }
            else if (ContentType.Equals("A"))
            {
                cmd.CommandText = "Update EmailAttachment set RequireOcr = 0, OcrPerformed = 'Y', OcrSuccessful = 'Y', OcrPending = 'N' WHERE RowGuid = @ContentGuid";
            }
            else
            {
                RetMsg = "You must specify the CONTENT TYPE CODE, fix it.";
                return false;
            }
            cmd.Parameters.Add("@ContentGuid", SqlDbType.NVarChar).Value = ContentGuid;
            try
            {
                cmd.ExecuteNonQuery();
                log.write(traceon, "Marked as complete OCR: '" + ContentGuid + "'");
            }
            catch (Exception ex)
            {
                Console.WriteLine("ERROR 3433B: " + ex.Message);
                log.write(traceon, "ERROR 3433B Failed to mark as complete OCR: '" + cmd.CommandText + "'   / " + ex.Message);
                b = false;
            }
            finally
            {
                cmd.Dispose();
            }

            GC.Collect();
            GC.WaitForPendingFinalizers();

            return b;
        }

        public string getConnectionString
        {
            get
            {
                return getCS();
            }
            set
            {
                ConnStr = getCS();
            }
        }

        public bool ckDbConnection()
        {
            bool b = false;
            string cs = getCS();
            if (dbConn == null)
            {
                dbConn = new SqlConnection(cs);
                dbConn.Open();
                b = true;
            }
            else
            {
                if (dbConn.State == ConnectionState.Closed)
                {
                    dbConn.ConnectionString = cs;
                    dbConn.Open();
                    b = true;
                }
            }
            return b;
        }

        public string getCS()
        {
            string RepoCS = System.Configuration.ConfigurationManager.ConnectionStrings["ECMFS"].ConnectionString;
            string pw = getEncPW();
            RepoCS = RepoCS.Replace("@@PW@@", pw);
            return RepoCS;
        }

        ~clsDatabaseOCR()
        {
            if (cmd != null)
            {
                cmd.Dispose();
            }
            if (dbConn != null)
            {
                try
                {
                    dbConn.Dispose();
                }
                catch
                {
                    Console.WriteLine("Database connection closing...");
                }
            }
            GC.Collect();
            GC.WaitForPendingFinalizers();
        }
    }
}