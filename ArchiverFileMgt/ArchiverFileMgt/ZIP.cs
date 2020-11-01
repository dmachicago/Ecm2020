using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SQLite;

namespace ArchiverFileMgt
{
    /// <summary>
    /// Processes the ZIP File table
    /// </summary>
    public static class ZIP
    {
        public static int RowNbr;
        public static int DirID;
        public static int FileID;
        public static string FQN;
        public static bool EmailAttachment;
        public static bool SuccessfullyProcessed;
        public static long fSize;
        public static DateTime CreateDate;
        public static DateTime LastAccessDate;
        public static int NumberOfZipFiles;
        public static string ParentGuid;
        public static bool InWork;
        public static string FileHash;

        /// <summary>
        /// Merges the record.
        /// </summary>
        /// <param name="conn">The connection.</param>
        /// <param name="ControlParms">The control parms.</param>
        /// <returns></returns>
        public static bool MergeRec(SQLiteConnection conn, Dictionary<string, string> ControlParms)
        {
            bool b = true;
            b = SetVars(ControlParms);
            int i = RecExists(conn, DirID, FileID);

            if (i > 0)
            {
                b = UpdateRec(conn, ControlParms);
            }
            else
            {
                b = InsertRec(conn, ControlParms);
            }
            return b;
        }

        /// <summary>
        /// Records the exists.
        /// </summary>
        /// <param name="conn">The connection.</param>
        /// <param name="DirID">The dir identifier.</param>
        /// <param name="FileID">The file identifier.</param>
        /// <returns></returns>
        public static int RecExists(SQLiteConnection conn, int DirID, int FileID)
        {
            int i = 0;
            string sql = "select  count(*) FROM ZipFile where DirID = @DirID and FileID = @FileID ";
            using (SQLiteCommand cmd = new SQLiteCommand(conn))
            {
                cmd.CommandText = sql;
                cmd.Prepare();
                cmd.Parameters.AddWithValue("@DirID", DirID);
                cmd.Parameters.AddWithValue("@FileID", FileID);
                i = Convert.ToInt32(cmd.ExecuteScalar());
            }
            return i;
        }

        /// <summary>
        /// Sets the vars.
        /// </summary>
        /// <param name="ControlParms">The control parms.</param>
        /// <returns></returns>
        private static bool SetVars(Dictionary<string, string> ControlParms)
        {
            bool b = true;
            RowNbr = Convert.ToInt32(ControlParms["RowNbr"]);
            DirID = Convert.ToInt32(ControlParms["DirID"]);
            FileID = Convert.ToInt32(ControlParms["FileID"]);
            FQN = ControlParms["FQN"];
            EmailAttachment = Convert.ToBoolean(ControlParms["EmailAttachment"]);
            SuccessfullyProcessed = Convert.ToBoolean(ControlParms["SuccessfullyProcessed"]);
            fSize = Convert.ToInt64(ControlParms["fSize"]);
            CreateDate = Convert.ToDateTime(ControlParms["CreateDate"]);
            CreateDate = Convert.ToDateTime(ControlParms["CreateDate"]);
            LastAccessDate = Convert.ToDateTime(ControlParms["LastAccessDate"]);
            ParentGuid = ControlParms["ParentGuid"];
            InWork = Convert.ToBoolean(ControlParms["InWork"]);
            FileHash = ControlParms["FileHash"];
            NumberOfZipFiles = Convert.ToInt32(ControlParms["NumberOfZipFiles"]);
            return b;
        }

        /// <summary>
        /// Updates the col.
        /// </summary>
        /// <param name="conn">The connection.</param>
        /// <param name="RecKey">The record key.</param>
        /// <param name="ColName">Name of the col.</param>
        /// <param name="ColVal">The col value.</param>
        /// <returns></returns>
        public static bool UpdateCol(SQLiteConnection conn, int RecKey, string ColName, DateTime ColVal)
        {
            bool b = true;
            int result = 0;

            try
            {
                using (SQLiteCommand cmd = new SQLiteCommand(conn))
                {
                    string sql = "";
                    sql += "Update [ZipFile] " + Environment.NewLine;
                    sql += "(set [" + ColName + "] = @ColVal " + Environment.NewLine;
                    sql += "WHERE RowNbr = @RowNbr ";

                    cmd.CommandText = sql;
                    cmd.Prepare();
                    cmd.Parameters.AddWithValue("@RowNbr", RecKey);
                    cmd.Parameters.AddWithValue("@ColVal", ColVal);

                    try
                    {
                        result = cmd.ExecuteNonQuery();
                    }
                    catch (SQLiteException excp)
                    {
                        string x = excp.Message;
                        b = false;
                    }
                }
            }
            catch (Exception ex)
            {
                b = false;
                Console.WriteLine("ERROR INV01: " + ex.Message);
            }
            return b;
        }

        /// <summary>
        /// Deletes the record.
        /// </summary>
        /// <param name="conn">The connection.</param>
        /// <param name="RecKey">The record key.</param>
        /// <returns></returns>
        public static bool DeleteRec(SQLiteConnection conn, int RecKey)
        {
            bool b = true;
            int result = 0;

            try
            {
                using (SQLiteCommand cmd = new SQLiteCommand(conn))
                {
                    string sql = "";
                    sql += "delete from [ZipFile] " + Environment.NewLine;
                    sql += "WHERE RowNbr = @RowNbr ";

                    cmd.CommandText = sql;
                    cmd.Prepare();
                    cmd.Parameters.AddWithValue("@RowNbr", RecKey);

                    try
                    {
                        result = cmd.ExecuteNonQuery();
                    }
                    catch (SQLiteException excp)
                    {
                        string x = excp.Message;
                        b = false;
                    }
                }
            }
            catch (Exception ex)
            {
                b = false;
                Console.WriteLine("ERROR INV02: " + ex.Message);
            }
            return b;
        }


        /// <summary>
        /// Updates the record.
        /// </summary>
        /// <param name="conn">The connection.</param>
        /// <param name="ControlParms">The control parms.</param>
        /// <returns></returns>
        public static bool UpdateRec(SQLiteConnection conn, Dictionary<string, string> ControlParms)
        {
            bool b = true;
            b = SetVars(ControlParms);

            int result = -1;
            try
            {
                using (SQLiteCommand cmd = new SQLiteCommand(conn))
                {
                    string sql = "";
                    sql += "Update [ZipFile] " + Environment.NewLine;
                    sql += "(set [DirID] = @DirID " + Environment.NewLine;
                    sql += ",[FileID] = @FileID " + Environment.NewLine;
                    sql += ",[FQN] = @FQN" + Environment.NewLine;
                    sql += ",[EmailAttachment] = @EmailAttachment" + Environment.NewLine;
                    sql += ",[SuccessfullyProcessed] = @SuccessfullyProcessed" + Environment.NewLine;
                    sql += ",[fSize] = @fSize " + Environment.NewLine;
                    sql += ",[CreateDate] = @CreateDate " + Environment.NewLine;
                    sql += ",[LastAccessDate] = @LastAccessDate " + Environment.NewLine;
                    sql += ",[NumberOfZipFiles] = @NumberOfZipFiles " + Environment.NewLine;
                    sql += ",[ParentGuid] = @ParentGuid " + Environment.NewLine;
                    sql += ",[InWork] = @InWork " + Environment.NewLine;
                    sql += ",[FileHash] = @FileHash " + Environment.NewLine;
                    sql += "WHERE RowNbr = @RowNbr ";

                    cmd.CommandText = sql;
                    cmd.Prepare();
                    cmd.Parameters.AddWithValue("@DirID", DirID);
                    cmd.Parameters.AddWithValue("@FileID", RowNbr);
                    cmd.Parameters.AddWithValue("@FQN", FileID);
                    cmd.Parameters.AddWithValue("@EmailAttachment", EmailAttachment);
                    cmd.Parameters.AddWithValue("@SuccessfullyProcessed", SuccessfullyProcessed);
                    cmd.Parameters.AddWithValue("@fSize", fSize);
                    cmd.Parameters.AddWithValue("@CreateDate", CreateDate);
                    cmd.Parameters.AddWithValue("@LastAccessDate", LastAccessDate);
                    cmd.Parameters.AddWithValue("@NumberOfZipFiles", NumberOfZipFiles);
                    cmd.Parameters.AddWithValue("@ParentGuid", ParentGuid);
                    cmd.Parameters.AddWithValue("@InWork", InWork);
                    cmd.Parameters.AddWithValue("@FileHash", FileHash);

                    try
                    {
                        result = cmd.ExecuteNonQuery();
                    }
                    catch (SQLiteException excp) { string x = excp.Message; }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("ERROR INV03: " + ex.Message);
                b = false;
            }

            return b;
        }

        /// <summary>
        /// Inserts the record.
        /// </summary>
        /// <param name="conn">The connection.</param>
        /// <param name="ControlParms">The control parms.</param>
        /// <returns></returns>
        public static bool InsertRec(SQLiteConnection conn, Dictionary<string, string> ControlParms)
        {
            bool b = true;
            b = SetVars(ControlParms);

            int result = -1;
            try
            {
                using (SQLiteCommand cmd = new SQLiteCommand(conn))
                {

                    string sql = "";
                    sql += "INSERT INTO [ZipFile] " + Environment.NewLine;
                    sql += "([DirID] " + Environment.NewLine;
                    sql += ",[FileID] " + Environment.NewLine;
                    sql += ",[FQN] " + Environment.NewLine;
                    sql += ",[EmailAttachment] " + Environment.NewLine;
                    sql += ",[SuccessfullyProcessed] " + Environment.NewLine;
                    sql += ",[fSize] " + Environment.NewLine;
                    sql += ",[CreateDate] " + Environment.NewLine;
                    sql += ",[LastAccessDate] " + Environment.NewLine;
                    sql += ",[NumberOfZipFiles] " + Environment.NewLine;
                    sql += ",[ParentGuid] " + Environment.NewLine;
                    sql += ",[InWork] " + Environment.NewLine;
                    sql += ",[FileHash]) " + Environment.NewLine;
                    sql += "VALUES " + Environment.NewLine;
                    sql += "(@DirID, " + Environment.NewLine;
                    sql += ",@FileID, " + Environment.NewLine;
                    sql += ",@FQN, " + Environment.NewLine;
                    sql += ",@EmailAttachment, " + Environment.NewLine;
                    sql += ",@SuccessfullyProcessed, " + Environment.NewLine;
                    sql += ",@fSize, " + Environment.NewLine;
                    sql += ",@CreateDate, " + Environment.NewLine;
                    sql += ",@LastAccessDate, " + Environment.NewLine;
                    sql += ",@NumberOfZipFiles, " + Environment.NewLine;
                    sql += ",@ParentGuid, " + Environment.NewLine;
                    sql += ",@InWork, " + Environment.NewLine;
                    sql += ",@FileHash)";

                    cmd.CommandText = sql;
                    cmd.Prepare();

                    cmd.Parameters.AddWithValue("@DirID", DirID);
                    cmd.Parameters.AddWithValue("@FileID", RowNbr);
                    cmd.Parameters.AddWithValue("@FQN", FileID);
                    cmd.Parameters.AddWithValue("@EmailAttachment", EmailAttachment);
                    cmd.Parameters.AddWithValue("@SuccessfullyProcessed", SuccessfullyProcessed);
                    cmd.Parameters.AddWithValue("@fSize", fSize);
                    cmd.Parameters.AddWithValue("@CreateDate", CreateDate);
                    cmd.Parameters.AddWithValue("@LastAccessDate", LastAccessDate);
                    cmd.Parameters.AddWithValue("@NumberOfZipFiles", NumberOfZipFiles);
                    cmd.Parameters.AddWithValue("@ParentGuid", ParentGuid);
                    cmd.Parameters.AddWithValue("@InWork", InWork);
                    cmd.Parameters.AddWithValue("@FileHash", FileHash);

                    try
                    {
                        result = cmd.ExecuteNonQuery();
                    }
                    catch (SQLiteException excp)
                    {
                        string x = excp.Message;
                        b = false;
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("ERROR INV04: " + ex.Message);
                b = false;
            }

            return b;
        }

        /// <summary>
        /// Gets the records.
        /// </summary>
        /// <param name="conn">The connection.</param>
        /// <param name="ControlParms">The control parms.</param>
        /// <returns></returns>
        public static List<DS_ZipFile> GetRecords(SQLiteConnection conn, Dictionary<string, string> ControlParms)
        {
            List<DS_ZipFile> ListOfDS = new List<DS_ZipFile>();

            bool b = true;
            b = SetVars(ControlParms);

            try
            {
                conn.Open();
                string sql = "SELECT [RowNbr] " + Environment.NewLine;
                sql += "      ,[DirID] " + Environment.NewLine;
                sql += "      ,[FileID] " + Environment.NewLine;
                sql += "      ,[FQN] " + Environment.NewLine;
                sql += "      ,[EmailAttachment] " + Environment.NewLine;
                sql += "      ,[SuccessfullyProcessed] " + Environment.NewLine;
                sql += "      ,[fSize] " + Environment.NewLine;
                sql += "      ,[CreateDate] " + Environment.NewLine;
                sql += "      ,[LastAccessDate] " + Environment.NewLine;
                sql += "      ,[NumberOfZipFiles] " + Environment.NewLine;
                sql += "      ,[ParentGuid] " + Environment.NewLine;
                sql += "      ,[InWork] " + Environment.NewLine;
                sql += "      ,[FileHash] " + Environment.NewLine;
                sql += "FROM[ZipFile] " + Environment.NewLine;
                sql += "where DirID = @DirID and FileID = @FileID ";

                using (SQLiteCommand cmd = new SQLiteCommand(conn))
                {
                    cmd.CommandText = sql;
                    cmd.Prepare();
                    cmd.Parameters.AddWithValue("@DirID", DirID);
                    cmd.Parameters.AddWithValue("@FileID", FileID);

                    using (SQLiteDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            DS_ZipFile dr = new DS_ZipFile();

                            dr.RowNbr = Convert.ToInt32(reader["RowNbr"]);
                            dr.DirID = Convert.ToInt32(reader["DirID"]);
                            dr.FileID = Convert.ToInt32(reader["FileID"]);
                            dr.FQN = reader["FQN"].ToString();
                            dr.EmailAttachment = Convert.ToBoolean(reader["EmailAttachment"]);
                            dr.SuccessfullyProcessed = Convert.ToBoolean(reader["SuccessfullyProcessed"]);
                            dr.fSize = Convert.ToInt64(reader["fSize"]);
                            dr.CreateDate = Convert.ToDateTime(reader["CreateDate"]);
                            dr.LastAccessDate = Convert.ToDateTime(reader["LastAccessDate"]);
                            dr.NumberOfZipFiles = Convert.ToInt32(reader["NumberOfZipFiles"]);
                            dr.ParentGuid = reader["ParentGuid"].ToString();
                            dr.InWork = Convert.ToBoolean(reader["InWork"]);
                            dr.FileHash = reader["FileHash"].ToString();

                            ListOfDS.Add(dr);
                        }
                    }
                }
            }
            catch (SQLiteException e)
            {
                Console.WriteLine(e.Message);
            }

            return ListOfDS;
        }
    }

    /// <summary>
    /// Zipfile data structure
    /// </summary>
    public class DS_ZipFile
    {
        public int RowNbr;
        public int DirID;
        public int FileID;
        public string FQN;
        public bool EmailAttachment;
        public bool SuccessfullyProcessed;
        public long fSize;
        public DateTime CreateDate;
        public DateTime LastAccessDate;
        public int NumberOfZipFiles;
        public string ParentGuid;
        public bool InWork;
        public string FileHash;
    }
}
