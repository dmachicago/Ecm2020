using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SQLite;

namespace ArchiverFileMgt
{
    /// <summary>
    /// Process the Files Table
    /// </summary>
    public static  class FILETBL
    {
        public static  string FileName = "";
        public static  int FileID = 0;
        public static  string FileHash = "";
        //public static  DS_Files dr = new DS_Files();

        /// <summary>
        /// Merges the record.
        /// </summary>
        /// <param name="conn">The connection.</param>
        /// <param name="ControlParms">The control parms.</param>
        /// <returns></returns>
        public static int MergeRec(SQLiteConnection conn, Dictionary<string, string> ControlParms)
        {
            int ix = -1; 
            bool b = true;
            b = SetVars(ControlParms);
            int i = RecExists(conn, FileName);

            if (i > 0)
            {
                b = UpdateRec(conn, ControlParms);
            }
            else
            {
                b = InsertRec(conn, ControlParms);
            }
            ix = GetRowID(conn, FileName);
            return ix;
        }

        /// <summary>
        /// Records the exists.
        /// </summary>
        /// <param name="conn">The connection.</param>
        /// <param name="FileName">Name of the file.</param>
        /// <returns></returns>
        public static  int RecExists(SQLiteConnection conn, string FileName)
        {
            int i = 0;
            string sql = "select  count(*) FROM Files where FileName = @FileName ";
            using (SQLiteCommand cmd = new SQLiteCommand(conn))
            {
                cmd.CommandText = sql;
                cmd.Prepare();
                cmd.Parameters.AddWithValue("@FileName", FileName);
                i = Convert.ToInt32(cmd.ExecuteScalar());
            }
            return i;
        }

        /// <summary>
        /// Sets the vars.
        /// </summary>
        /// <param name="ControlParms">The control parms.</param>
        /// <returns></returns>
        private static  bool SetVars(Dictionary<string, string> ControlParms)
        {
            bool b = true;
            FileID = Convert.ToInt32(ControlParms["FileID"]);
            FileName = ControlParms["FileName"];
            FileHash = ControlParms["FileHash"];
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
        public static  bool UpdateCol(SQLiteConnection conn, int RecKey, string ColName, DateTime ColVal)
        {
            bool b = true;
            int result = 0;

            try
            {
                using (SQLiteCommand cmd = new SQLiteCommand(conn))
                {
                    string sql = "";
                    sql += "Update [Files] " + Environment.NewLine;
                    sql += "(set [" + ColName + "] = @ColVal " + Environment.NewLine;
                    sql += "WHERE FileID = @FileID ";

                    cmd.CommandText = sql;
                    cmd.Prepare();
                    cmd.Parameters.AddWithValue("@FileID", RecKey);
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
                Console.WriteLine("ERROR DIR01: " + ex.Message);
            }
            return b;
        }

        /// <summary>
        /// Deletes the record.
        /// </summary>
        /// <param name="conn">The connection.</param>
        /// <param name="RecKey">The record key.</param>
        /// <returns></returns>
        public static  bool DeleteRec(SQLiteConnection conn, int RecKey)
        {
            bool b = true;
            int result = 0;

            try
            {
                using (SQLiteCommand cmd = new SQLiteCommand(conn))
                {
                    string sql = "";
                    sql += "delete from [Files] " + Environment.NewLine;
                    sql += "WHERE FileID = @FileID ";

                    cmd.CommandText = sql;
                    cmd.Prepare();
                    cmd.Parameters.AddWithValue("@FileID", RecKey);

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
                Console.WriteLine("ERROR DIR02: " + ex.Message);
            }
            return b;
        }


        /// <summary>
        /// Updates the record.
        /// </summary>
        /// <param name="conn">The connection.</param>
        /// <param name="ControlParms">The control parms.</param>
        /// <returns></returns>
        public static  bool UpdateRec(SQLiteConnection conn, Dictionary<string, string> ControlParms)
        {
            bool b = true;
            b = SetVars(ControlParms);

            int result = -1;
            try
            {
                using (SQLiteCommand cmd = new SQLiteCommand(conn))
                {
                    string sql = "";
                    sql += "Update [Files] " + Environment.NewLine;
                    sql += "(set [FileName] = @FileName " + Environment.NewLine;
                    sql += ",[FileHash] = @FileHash " + Environment.NewLine;
                    sql += "WHERE FileID = @FileID ";

                    cmd.CommandText = sql;
                    cmd.Prepare();
                    cmd.Parameters.AddWithValue("@FileID", FileID);
                    cmd.Parameters.AddWithValue("@FileName", FileName);
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
                Console.WriteLine("ERROR DIR03: " + ex.Message);
            }

            return b;
        }

        /// <summary>
        /// Inserts the record.
        /// </summary>
        /// <param name="conn">The connection.</param>
        /// <param name="ControlParms">The control parms.</param>
        /// <returns></returns>
        public static  bool InsertRec(SQLiteConnection conn, Dictionary<string, string> ControlParms)
        {
            bool b = true;
            b = SetVars(ControlParms);

            int result = -1;
            try
            {
                using (SQLiteCommand cmd = new SQLiteCommand(conn))
                {
                    string sql = "";
                    sql += "INSERT INTO [Files] ([FileName],[FileHash]) VALUES (@FileName, @FileHash);";

                    cmd.CommandText = sql;
                    cmd.Prepare();
                    cmd.Parameters.AddWithValue("@FileName", FileName);
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
                Console.WriteLine("ERROR DIR04: " + ex.Message);
                b = false;
            }

            return b;
        }

        /// <summary>
        /// Gets the row identifier.
        /// </summary>
        /// <param name="conn">The connection.</param>
        /// <param name="FileName">Name of the file.</param>
        /// <returns></returns>
        public static int GetRowID(SQLiteConnection conn, string FileName)
        {
            try
            {
                string sql = "SELECT FileID " + Environment.NewLine;
                sql += "From [Files]" + Environment.NewLine;
                sql += "where FileName= @FileName ";

                using (SQLiteCommand cmd = new SQLiteCommand(conn))
                {

                    cmd.CommandText = sql;
                    cmd.Prepare();
                    cmd.Parameters.AddWithValue("@FileName", FileName);

                    using (SQLiteDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            FileID = Convert.ToInt32(reader["FileID"]);
                        }
                    }
                }

            }
            catch (SQLiteException e)
            {
                Console.WriteLine(e.Message);
            }

            return FileID;
        }

        /// <summary>
        /// Gets the records.
        /// </summary>
        /// <param name="conn">The connection.</param>
        /// <param name="ControlParms">The control parms.</param>
        /// <returns></returns>
        public static  List<DS_Files> GetRecords(SQLiteConnection conn, Dictionary<string, string> ControlParms)
        {
            List<DS_Files> ListOfDS = new List<DS_Files>();

            bool b = true;
            b = SetVars(ControlParms);

            try
            {

                string sql = "SELECT FileID, FileName, FileHash " + Environment.NewLine;
                sql += " FROM Files ";
                sql += "WHERE FileName = @FileName ";

                using (SQLiteCommand cmd = new SQLiteCommand(conn))
                {

                    cmd.CommandText = sql;
                    cmd.Prepare();
                    cmd.Parameters.AddWithValue("@FileName", FileName);

                    using (SQLiteDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            DS_Files DSFiles = new DS_Files();
                            DSFiles.FileID = Convert.ToInt32(reader["FileID"]);
                            DSFiles.FileName = reader["FileName"].ToString();
                            DSFiles.FileHash = reader["FileHash"].ToString();
                            ListOfDS.Add(DSFiles);
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

        /// <summary>
        /// Gets the existing recs.
        /// </summary>
        /// <param name="conn">The connection.</param>
        /// <returns></returns>
        public static Dictionary<string, int> GetExistingRecs(SQLiteConnection conn)
        {
            Dictionary<string, int> ListOfDS = new Dictionary<string, int>();
            try
            {
                string sql = "SELECT FileName, FileID FROM Files ";
                using (SQLiteCommand cmd = new SQLiteCommand(conn))
                {
                    cmd.CommandText = sql;
                    using (SQLiteDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            FileName = reader["FileName"].ToString();
                            FileID = Convert.ToInt32( reader["FileID"]);
                            ListOfDS.Add(FileName.ToUpper(), FileID);
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
    /// Files table data structure
    /// </summary>
    public class DS_Files
    {
        public int FileID = 0;
        public string FileName = "";
        public string FileHash = "";
    }
}
