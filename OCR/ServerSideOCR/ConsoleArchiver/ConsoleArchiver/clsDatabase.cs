using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace ConsoleArchiver
{
    internal class clsDatabase
    {

        clsEncrypt enc = new clsEncrypt ();
        clsLogging log = new clsLogging ();

        private string ConnStr = "";
        private SqlConnection dbConn = null;
        private SqlCommand cmd = null;

        public void getAllOcrRequiredContent ( string cs, 
                    ref Dictionary<string, 
                    string> LisOfGuids, 
                    string ContentType, 
                    ref string RetMsg )
        {
            
            //if (ConnStr.Length == 0)
            //{
            //    RetMsg = "Connection String is NOT set, fix it.";
            //    log.write ( "Connection String is NOT set, fix it." );
            //    return ;
            //}

            //ckDbConnection ();
            
            SqlConnection NewDbConn = new SqlConnection ( cs );
            NewDbConn.Open ();

            cmd = new SqlCommand ();
            cmd.Connection = NewDbConn;

            if (ContentType.Equals ( "C" ))
            {
                cmd.CommandText = "SELECT SourceGuid FROM DataSource WHERE RequireOcr = 1";
            }
            else if (ContentType.Equals ( "A" ))
            {
                cmd.CommandText = "SELECT RowGuid FROM EmailAttachment WHERE RequireOcr = 1";
            }
            else
            {
                RetMsg = "You must specify the CONTENT TYPE CODE, fix it.";
                log.write ( "You must specify the CONTENT TYPE CODE, fix it." ); 
                return ;
            }

            SqlDataReader sqlReader = cmd.ExecuteReader ();

            if (sqlReader.HasRows)
            {
                while (sqlReader.Read ())
                {
                    string strGuid = (string)sqlReader[0].ToString();
                    if (!LisOfGuids.ContainsKey ( strGuid ))
                    {
                        LisOfGuids.Add ( strGuid, ContentType );
                    }                    
                }
            }

            sqlReader.Close ();
            cmd.Dispose ();

            NewDbConn.Close ();
            NewDbConn.Dispose ();

            GC.Collect ();
            GC.WaitForPendingFinalizers ();

            return ;
        }

        public List<string> getOcrRequiredDocs (string cs,  string ContentType, ref string RetMsg )
        {
            List<string> guids = new List<string> ();
            
            SqlConnection NewDbConn = new SqlConnection ( cs );
            NewDbConn.Open ();

            cmd = new SqlCommand ();
            cmd.Connection = NewDbConn;

            if (ContentType.Equals ( "C" ))
            {
                cmd.CommandText = "SELECT top 50 SourceGuid FROM DataSource WHERE OcrRequired = 1";
            }
            else if (ContentType.Equals ( "A" ))
            {
                cmd.CommandText = "SELECT  top 50 RowGuid FROM EmailAttachment WHERE OcrRequired = 1";
            }
            else
            {
                RetMsg = "You must specify the CONTENT TYPE CODE, fix it.";
                return null;
            }

            SqlDataReader sqlReader = cmd.ExecuteReader ();

            if (sqlReader.HasRows)
            {
                while (sqlReader.Read ())
                {
                    string strGuid = (string)sqlReader[0];
                    guids.Add ( strGuid );
                }
            }

            sqlReader.Close ();
            cmd.Dispose ();
            NewDbConn.Close ();
            NewDbConn.Dispose ();

            GC.Collect ();
            GC.WaitForPendingFinalizers ();

            return guids;
        }

        public byte[] getContent ( string cs,  string ContentGuid, string ContentType, ref string FileName, ref string RetMsg )
        {
            FileName = "";
            ContentType = ContentType.ToUpper ();
            if (cs.Length == 0)
            {
                RetMsg = "Connection String is NOT set, fix it.";
                return null;
            }

            byte[] fileData = null;
            
            SqlConnection NewDbConn = new SqlConnection ( cs );
            NewDbConn.Open ();

            cmd = new SqlCommand ();
            cmd.Connection = NewDbConn;

            if (ContentType.Equals ( "C" ))
            {
                cmd.CommandText = "SELECT SourceName, SourceImage FROM DataSource WHERE SourceGuid = @ContentGuid";
            }
            else if (ContentType.Equals ( "A" ))
            {
                cmd.CommandText = "SELECT AttachmentName, Attachment FROM EmailAttachment WHERE RowGuid = @ContentGuid";
            }
            else
            {
                RetMsg = "You must specify the CONTENT TYPE CODE, fix it.";
                return null;
            }
            cmd.Parameters.Add ( "@ContentGuid", SqlDbType.NVarChar ).Value = ContentGuid;
            SqlDataReader sqlReader = cmd.ExecuteReader ();

            //string fileName = "file.txt";
            //string fileDir = "C:\\Test\\";
            //string fileUrl = "/";

            if (sqlReader.HasRows)
            {
                while (sqlReader.Read ())
                {
                    try
                    {
                        FileName = (string)sqlReader[0];
                        fileData = (byte[])sqlReader[1];
                    }
                    catch (Exception ex)
                    {
                        log.write ( "ERROR/getContent: 100 " + FileName + " - "  + ex.Message );
                    }
                    
                }
            }

            sqlReader.Close ();
            sqlReader.Dispose ();
            cmd.Dispose ();

            GC.Collect ();
            GC.WaitForPendingFinalizers ();

            return fileData;
        }

        public bool updateOcrText (string cs, string ContentGuid, string ContentType, string OcrText, ref string RetMsg )
        {
            bool b = true;

            ContentType = ContentType.ToUpper ();
            if (ConnStr.Length == 0)
            {
                RetMsg = "Connection String is NOT set, fix it.";
                return false;
            }

            SqlConnection NewDbConn = new SqlConnection ( cs );
            NewDbConn.Open ();

            cmd = new SqlCommand ();
            cmd.Connection = NewDbConn;

            if (ContentType.Equals ( "C" ))
            {
                if (OcrText.Length > 0)
                {
                    cmd.CommandText = "Update DataSource set OcrPerformed = 1, RequireOcr = 0, OcrPending = 'N', GraphicContainsText = 'Y', OcrText = @OcrText  WHERE SourceGuid = @ContentGuid";
                }
                else
                {
                    cmd.CommandText = "Update DataSource set OcrPerformed = 1, RequireOcr = 0, OcrPending = 'N', GraphicContainsText = 'N', OcrText = @OcrText  WHERE SourceGuid = @ContentGuid";
                }
            }
            else if (ContentType.Equals ( "A" ))
            {
                cmd.CommandText = "Update EmailAttachment set OcrText = @OcrText, RequireOcr = 0, OcrSuccessful = 'Y', OcrPending = 'N', OcrPerformed = 'Y'  WHERE RowGuid = @ContentGuid";
            }
            else
            {
                RetMsg = "You must specify the CONTENT TYPE CODE, fix it.";
                return false;
            }
            cmd.Parameters.Add ( "@OcrText", SqlDbType.NVarChar ).Value = OcrText;
            cmd.Parameters.Add ( "@ContentGuid", SqlDbType.NVarChar ).Value = ContentGuid;
            try
            {
                cmd.ExecuteNonQuery ();
            }
            catch (Exception ex)
            {
                Console.WriteLine ( "ERROR 3433: " + ex.Message );
                b = false;
            }
            finally
            {
                cmd.Dispose ();
                NewDbConn.Close ();
                NewDbConn.Dispose ();
            }

            GC.Collect ();
            GC.WaitForPendingFinalizers ();

            return b;
        }

        public bool markPdfSearchable ( string cs,  string ContentGuid, string ContentType, string searchableFlag, ref string RetMsg )
        {
            bool b = true;

            ContentType = ContentType.ToUpper ();
            if (ConnStr.Length == 0)
            {
                RetMsg = "Connection String is NOT set, fix it.";
                return false;
            }

            SqlConnection NewDbConn = new SqlConnection ( cs );
            NewDbConn.Open ();

            cmd = new SqlCommand ();
            cmd.Connection = NewDbConn;

            if (ContentType.Equals ( "C" ))
            {
                cmd.CommandText = "Update DataSource set PdfIsSearchable = '" + searchableFlag + "', RequireOcr = 0  WHERE SourceGuid = @ContentGuid";
            }
            else if (ContentType.Equals ( "A" ))
            {
                cmd.CommandText = "Update EmailAttachment set PdfIsSearchable = '" + searchableFlag + "', RequireOcr = 0 WHERE RowGuid = @ContentGuid";
            }
            else
            {
                RetMsg = "You must specify the CONTENT TYPE CODE, fix it.";
                return false;
            }
            cmd.Parameters.Add ( "@OcrText", SqlDbType.NVarChar ).Value = ContentGuid;
            cmd.Parameters.Add ( "@ContentGuid", SqlDbType.NVarChar ).Value = ContentGuid;
            try
            {
                cmd.ExecuteNonQuery ();
            }
            catch (Exception ex)
            {
                Console.WriteLine ( "ERROR 3433: " + ex.Message );
                b = false;
            }
            finally
            {
                cmd.Dispose ();

                NewDbConn.Close ();
                NewDbConn.Dispose ();
            }

            GC.Collect ();
            GC.WaitForPendingFinalizers ();

            return b;
        }

        public bool markOcrCompleteWithError ( string cs, string ContentGuid, string ContentType, ref string RetMsg )
        {
            bool b = true;

            ContentType = ContentType.ToUpper ();
            if (ConnStr.Length == 0)
            {
                RetMsg = "Connection String is NOT set, fix it.";
                return false;
            }

            SqlConnection NewDbConn = new SqlConnection ( cs );
            NewDbConn.Open ();

            cmd = new SqlCommand ();
            cmd.Connection = NewDbConn;

            if (ContentType.Equals ( "C" ))
            {
                cmd.CommandText = "Update DataSource set RequireOcr = 0, OcrPerformed = 'N', OcrSuccessful = 'N', OcrPending = 'N'   WHERE SourceGuid = @ContentGuid";
            }
            else if (ContentType.Equals ( "A" ))
            {
                cmd.CommandText = "Update EmailAttachment set RequireOcr = 0, OcrPerformed = 'N', OcrSuccessful = 'N', OcrPending = 'N' WHERE RowGuid = @ContentGuid";
            }
            else
            {
                RetMsg = "You must specify the CONTENT TYPE CODE, fix it.";
                return false;
            }
            cmd.Parameters.Add ( "@OcrText", SqlDbType.NVarChar ).Value = ContentGuid;
            cmd.Parameters.Add ( "@ContentGuid", SqlDbType.NVarChar ).Value = ContentGuid;
            try
            {
                cmd.ExecuteNonQuery ();
            }
            catch (Exception ex)
            {
                Console.WriteLine ( "ERROR 3433: " + ex.Message );
                b = false;
            }
            finally
            {
                cmd.Dispose ();

                NewDbConn.Close ();
                NewDbConn.Dispose ();
            }

            GC.Collect ();
            GC.WaitForPendingFinalizers ();

            return b;
        }

        public string getConnectionString
        {
            get
            {
                return ConnStr;
            }
            set
            {
                ConnStr = value;
            }
        }

        private void ckDbConnection ()
        {
            if (dbConn == null)
            {
                dbConn = new SqlConnection ( ConnStr );
                dbConn.Open ();
            }
            else
            {
                if (dbConn.State == ConnectionState.Closed)
                {
                    dbConn.ConnectionString = ConnStr;
                    dbConn.Open ();
                }
            }
        }

        public string getEncCS( string gatewayid)
        {
            string enccs = "" ;
            string decryptedcs = "" ;
            string GateWayCs = System.Configuration.ConfigurationManager.ConnectionStrings["ECMGWAY"].ConnectionString;
            SqlConnection conn = new SqlConnection(GateWayCs) ;

            conn.Open ();

            cmd = new SqlCommand ();
            cmd.Connection = conn;
            cmd.CommandText = "SELECT [CS] FROM [ECM.SecureLogin].[dbo].[SecureAttach] where RowID = " + gatewayid;
            
            SqlDataReader sqlReader = cmd.ExecuteReader ();

            if (sqlReader.HasRows)
            {
                while (sqlReader.Read ())
                {
                    enccs = (string)sqlReader[0].ToString ();
                    decryptedcs = enc.DecryptTripleDES ( enccs );
                }
            }

            sqlReader.Close ();
            cmd.Dispose ();
            conn.Close ();
            conn.Dispose ();

            GC.Collect ();
            GC.WaitForPendingFinalizers ();

            return decryptedcs;
        }

        ~clsDatabase ()
        {
            if (cmd != null)
            {
                cmd.Dispose ();
            }
            if (dbConn != null)
            {
                try
                {
                    dbConn.Dispose ();
                }
                catch
                {
                    Console.WriteLine ( "Database connection closing..." );
                }
                
            }            
            GC.Collect ();
            GC.WaitForPendingFinalizers ();
        }
    }
}