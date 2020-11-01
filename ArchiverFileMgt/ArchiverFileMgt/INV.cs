using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SQLite;

namespace ArchiverFileMgt
{
    /// <summary>
    /// Processes the Inventory table
    /// </summary>
    public static class INV
    {
        public static int InvID;
        public static int DirID;
        public static int FileID;
        public static bool FileExist;
        public static long FileSize;
        public static DateTime CreateDate;
        public static DateTime LastUpdate;
        public static DateTime LastArchiveUpdate;
        public static bool ArchiveBit;
        public static bool NeedsArchive;
        public static string FileHash;

        /// <summary>
        /// Merges the record.
        /// </summary>
        /// <param name="conn">The connection.</param>
        /// <param name="ControlParms">The control parms.</param>
        /// <returns></returns>
        public static int MergeRec(SQLiteConnection conn, Dictionary<string, string> ControlParms)
        {
            int invid = -1;
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

            if (b == true)
            {
                invid = GetRowID(conn, DirID, FileID);
            }
            return invid;
        }

        /// <summary>
        /// Gets the row identifier.
        /// </summary>
        /// <param name="conn">The connection.</param>
        /// <param name="DirID">The dir identifier.</param>
        /// <param name="FileID">The file identifier.</param>
        /// <returns></returns>
        public static int GetRowID(SQLiteConnection conn, int DirID, int FileID)
        {
            try
            {
                string sql = "SELECT InvID " + Environment.NewLine;
                sql += "From [Inventory]" + Environment.NewLine;
                sql += "where DirID= @DirID and FileID= @DirID ";

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
                            InvID = Convert.ToInt32(reader["InvID"]);
                        }
                    }
                }

            }
            catch (SQLiteException e)
            {
                Console.WriteLine(e.Message);
            }

            return InvID;
        }

        /// <summary>
        /// Records the exists.
        /// </summary>
        /// <param name="conn">The connection.</param>
        /// <param name="FileHash">The file hash.</param>
        /// <returns></returns>
        public static int RecExists(SQLiteConnection conn, string FileHash)
        {
            int i = 0;
            string sql = "select  count(*) FROM Inventory where FileHash = @FileHash ";
            using (SQLiteCommand cmd = new SQLiteCommand(conn))
            {
                cmd.CommandText = sql;
                cmd.Prepare();
                cmd.Parameters.AddWithValue("@FileHash", FileHash);
                i = Convert.ToInt32(cmd.ExecuteScalar());
            }
            return i;
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
            string sql = "select  count(*) FROM Inventory where DirID = @DirID and FileID = @FileID ";
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
            InvID = Convert.ToInt32(ControlParms["InvID"]);
            DirID = Convert.ToInt32(ControlParms["DirID"]);
            FileID = Convert.ToInt32(ControlParms["FileID"]);
            string s = ControlParms["FileExist"];
            if (s.ToLower().Equals("true") | s.Equals("1"))
                FileExist = true;
            else
                FileExist = true;
            FileSize = Convert.ToInt64(ControlParms["FileSize"]);
            CreateDate = Convert.ToDateTime(ControlParms["CreateDate"]);
            LastUpdate = Convert.ToDateTime(ControlParms["LastUpdate"]);
            LastArchiveUpdate = Convert.ToDateTime(ControlParms["LastArchiveUpdate"]);
            s = ControlParms["ArchiveBit"];
            if (s.ToLower().Equals("true") | s.Equals("1"))
                ArchiveBit = true;
            else
                ArchiveBit = false;
            s = ControlParms["NeedsArchive"];
            if (s.ToLower().Equals("true") | s.Equals("1"))
                NeedsArchive = true;
            else
                NeedsArchive = false;
            FileHash = ControlParms["FileHash"];
            return b;
        }

        /// <summary>
        /// Sets the archive bit.
        /// </summary>
        /// <param name="conn">The connection.</param>
        /// <param name="RowID">The row identifier.</param>
        /// <param name="BitValue">if set to <c>true</c> [bit value].</param>
        /// <returns></returns>
        public static bool SetArchiveBit(SQLiteConnection conn, int RowID, bool BitValue)
        {
            bool b = true;
            int result = 0;

            try
            {
                using (SQLiteCommand cmd = new SQLiteCommand(conn))
                {
                    string sql = "";
                    sql += "Update [Inventory] " + Environment.NewLine;
                    sql += "set [ArchiveBit] = @BitValue, [NeedsArchive] = @BitValue " + Environment.NewLine;
                    sql += "WHERE InvID  = @InvID ";

                    cmd.CommandText = sql;
                    cmd.Prepare();
                    cmd.Parameters.AddWithValue("@InvID ", InvID);
                    cmd.Parameters.AddWithValue("@BitValue ", BitValue);

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
        /// Updates the col.
        /// </summary>
        /// <param name="conn">The connection.</param>
        /// <param name="DirID">The dir identifier.</param>
        /// <param name="FileID">The file identifier.</param>
        /// <param name="ColName">Name of the col.</param>
        /// <param name="ColVal">The col value.</param>
        /// <returns></returns>
        public static bool UpdateCol(SQLiteConnection conn, int DirID, int FileID, string ColName, string ColVal)
        {
            bool b = true;
            int result = 0;

            try
            {
                using (SQLiteCommand cmd = new SQLiteCommand(conn))
                {
                    string sql = "";
                    sql += "Update [Inventory] " + Environment.NewLine;
                    sql += "set [" + ColName + "] = @ColVal " + Environment.NewLine;
                    sql += "WHERE DirID = @DirID and FileID = @FileID ";

                    cmd.CommandText = sql;
                    cmd.Prepare();
                    cmd.Parameters.AddWithValue("@DirID", DirID);
                    cmd.Parameters.AddWithValue("@FileID", FileID);
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
        /// Updates the col.
        /// </summary>
        /// <param name="conn">The connection.</param>
        /// <param name="FileHash">The file hash.</param>
        /// <param name="ColName">Name of the col.</param>
        /// <param name="ColVal">The col value.</param>
        /// <returns></returns>
        public static bool UpdateCol(SQLiteConnection conn, string FileHash, string ColName, string ColVal)
        {
            bool b = true;
            int result = 0;

            try
            {
                using (SQLiteCommand cmd = new SQLiteCommand(conn))
                {
                    string sql = "";
                    sql += "Update [Inventory] " + Environment.NewLine;
                    sql += "set [" + ColName + "] = @ColVal " + Environment.NewLine;
                    sql += "WHERE FileHash = @FileHash ";

                    cmd.CommandText = sql;
                    cmd.Prepare();
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
                    sql += "delete from [Inventory] " + Environment.NewLine;
                    sql += "WHERE InvID = @InvID ";

                    cmd.CommandText = sql;
                    cmd.Prepare();
                    cmd.Parameters.AddWithValue("@InvID", RecKey);

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
                    sql += "Update [Inventory] " + Environment.NewLine;
                    sql += "(set [DirID] = @DirID " + Environment.NewLine;
                    sql += ",[FileID] = @FileID " + Environment.NewLine;
                    sql += ",[FileExist] = @FileExist" + Environment.NewLine;
                    sql += ",[FileSize] = @FileSize " + Environment.NewLine;
                    sql += ",[CreateDate] = @CreateDate " + Environment.NewLine;
                    sql += ",[LastUpdate] = @LastUpdate " + Environment.NewLine;
                    sql += ",[LastArchiveUpdate] = @LastArchiveUpdate " + Environment.NewLine;
                    sql += ",[ArchiveBit] = @ArchiveBit " + Environment.NewLine;
                    sql += ",[NeedsArchive] = @NeedsArchive " + Environment.NewLine;
                    sql += ",[FileHash] = @FileHash " + Environment.NewLine;
                    sql += "WHERE InvID = @InvID ";

                    cmd.CommandText = sql;
                    cmd.Prepare();
                    cmd.Parameters.AddWithValue("@DirID", InvID);
                    cmd.Parameters.AddWithValue("@FileID", InvID);
                    cmd.Parameters.AddWithValue("@FileExist", InvID);
                    cmd.Parameters.AddWithValue("@FileSize", InvID);
                    cmd.Parameters.AddWithValue("@CreateDate", InvID);
                    cmd.Parameters.AddWithValue("@LastUpdate", InvID);
                    cmd.Parameters.AddWithValue("@LastArchiveUpdate", InvID);
                    cmd.Parameters.AddWithValue("@ArchiveBit", InvID);
                    cmd.Parameters.AddWithValue("@NeedsArchive", InvID);
                    cmd.Parameters.AddWithValue("@FileHash", InvID);

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
                    sql += "INSERT INTO [Inventory] " + Environment.NewLine;
                    sql += "([DirID] " + Environment.NewLine;
                    sql += ",[FileID] " + Environment.NewLine;
                    sql += ",[FileExist] " + Environment.NewLine;
                    sql += ",[FileSize] " + Environment.NewLine;
                    sql += ",[CreateDate] " + Environment.NewLine;
                    sql += ",[LastUpdate] " + Environment.NewLine;
                    sql += ",[LastArchiveUpdate] " + Environment.NewLine;
                    sql += ",[ArchiveBit] " + Environment.NewLine;
                    sql += ",[NeedsArchive] " + Environment.NewLine;
                    sql += ",[FileHash]) " + Environment.NewLine;
                    sql += "VALUES " + Environment.NewLine;
                    sql += "(@DirID ,@FileID,@FileExist " + Environment.NewLine;
                    sql += ",@FileSize " + Environment.NewLine;
                    sql += ",@CreateDate " + Environment.NewLine;
                    sql += ",@LastUpdate " + Environment.NewLine;
                    sql += ",@LastArchiveUpdate " + Environment.NewLine;
                    sql += ",@ArchiveBit " + Environment.NewLine;
                    sql += ",@NeedsArchive " + Environment.NewLine;
                    sql += ",@FileHash)";

                    cmd.CommandText = sql;
                    cmd.Prepare();
                    cmd.Parameters.AddWithValue("@DirID", DirID);
                    cmd.Parameters.AddWithValue("@FileID", FileID);
                    cmd.Parameters.AddWithValue("@FileExist", FileExist);
                    cmd.Parameters.AddWithValue("@FileSize", FileSize);
                    cmd.Parameters.AddWithValue("@CreateDate", CreateDate);
                    cmd.Parameters.AddWithValue("@LastUpdate", LastUpdate);
                    cmd.Parameters.AddWithValue("@LastArchiveUpdate", LastArchiveUpdate);
                    cmd.Parameters.AddWithValue("@ArchiveBit", ArchiveBit);
                    cmd.Parameters.AddWithValue("@NeedsArchive", NeedsArchive);
                    cmd.Parameters.AddWithValue("@FileHash", FileHash);

                    try
                    {
                        result = cmd.ExecuteNonQuery();
                        b = true;
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
        public static List<DS_Inventory> GetRecords(SQLiteConnection conn, Dictionary<string, string> ControlParms)
        {
            List<DS_Inventory> ListOfDS = new List<DS_Inventory>();

            bool b = true;
            b = SetVars(ControlParms);

            try
            {

                string sql = "";
                sql += "Select " + Environment.NewLine;
                sql += "[DirID] " + Environment.NewLine;
                sql += ",[FileID] " + Environment.NewLine;
                sql += ",[FileExist] " + Environment.NewLine;
                sql += ",[FileSize] " + Environment.NewLine;
                sql += ",[CreateDate] " + Environment.NewLine;
                sql += ",[LastUpdate] " + Environment.NewLine;
                sql += ",[LastArchiveUpdate] " + Environment.NewLine;
                sql += ",[ArchiveBit] " + Environment.NewLine;
                sql += ",[NeedsArchive] " + Environment.NewLine;
                sql += ",[FileHash] " + Environment.NewLine;
                sql += " FROM Inventory ";
                sql += "WHERE DirID = @DirID and FileID = @FileID";

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
                            DS_Inventory dr = new DS_Inventory();

                            dr.InvID = Convert.ToInt32(reader["InvID"]);
                            dr.DirID = Convert.ToInt32(reader["DirID"]);
                            dr.FileID = Convert.ToInt32(reader["FileID"]);
                            dr.FileExist = Convert.ToBoolean(reader["FileExist"]);
                            dr.FileSize = Convert.ToInt32(reader["FileSize"]);
                            dr.CreateDate = Convert.ToDateTime(reader["CreateDate"]);
                            dr.LastUpdate = Convert.ToDateTime(reader["LastUpdate"]);
                            dr.LastArchiveUpdate = Convert.ToDateTime(reader["LastArchiveUpdate"]);
                            dr.ArchiveBit = Convert.ToBoolean(reader["ArchiveBit"]);
                            dr.NeedsArchive = Convert.ToBoolean(reader["NeedsArchive"]);
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

        /// <summary>
        /// checks to see if rec needs an update.
        /// </summary>
        /// <param name="conn">The connection.</param>
        /// <param name="DirID">The dir identifier.</param>
        /// <param name="FileID">The file identifier.</param>
        /// <param name="FSize">Size of the f.</param>
        /// <param name="LUpdate">The l update.</param>
        /// <returns></returns>
        public static bool CheckUpdateNeeded(SQLiteConnection conn, int DirID, int FileID, long FSize, DateTime LUpdate)
        {
            
            bool b = false;
            try
            {

                string sql = "";
                sql += "Select " + Environment.NewLine;
                sql += "[FileSize] " + Environment.NewLine;
                sql += ",[LastUpdate] " + Environment.NewLine;
                sql += " FROM Inventory ";
                sql += "WHERE DirID = @DirID and FileID = @FileID";

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
                            //DS_Inventory dr = new DS_Inventory();

                            FileSize = Convert.ToInt32(reader["FileSize"]);
                            LastUpdate = Convert.ToDateTime(reader["LastUpdate"]);

                            if (FileSize.Equals(FSize))
                            {
                                var diffInSeconds = (LUpdate - LastUpdate).TotalSeconds;
                                if (diffInSeconds < 1)
                                {
                                    b = false;
                                }
                            }
                            else
                                b = true;
                        }
                    }
                }

            }
            catch (SQLiteException e)
            {
                Console.WriteLine(e.Message);
            }

            return b;
        }

        /// <summary>
        /// Checks the update needed.
        /// </summary>
        /// <param name="conn">The connection.</param>
        /// <param name="FullHash">The full hash.</param>
        /// <param name="FSize">Size of the f.</param>
        /// <param name="LUpdate">The l update.</param>
        /// <returns></returns>
        public static bool CheckUpdateNeeded(SQLiteConnection conn, string FullHash, long FSize, DateTime LUpdate)
        {

            bool b = true;
            try
            {

                string sql = "";
                sql += "Select " + Environment.NewLine;
                sql += ",[FileSize] " + Environment.NewLine;
                sql += ",[LastUpdate] " + Environment.NewLine;
                sql += " FROM Inventory ";
                sql += "WHERE FileHash = @FileHash";

                using (SQLiteCommand cmd = new SQLiteCommand(conn))
                {

                    cmd.CommandText = sql;
                    cmd.Prepare();
                    cmd.Parameters.AddWithValue("@FileHash", FullHash);

                    using (SQLiteDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            DS_Inventory dr = new DS_Inventory();

                            FileSize = Convert.ToInt32(reader["FileSize"]);
                            LastUpdate = Convert.ToDateTime(reader["LastUpdate"]);

                            if (FileSize == FSize && LastUpdate == LUpdate)
                                b = true;
                            else
                                b = false;
                        }
                    }
                }

            }
            catch (SQLiteException e)
            {
                Console.WriteLine(e.Message);
            }

            return b;
        }

    }

    /// <summary>
    /// Inventory data structure
    /// </summary>
    public class DS_Inventory
    {
        public int InvID;
        public int DirID;
        public int FileID;
        public bool FileExist;
        public long FileSize;
        public DateTime CreateDate;
        public DateTime LastUpdate;
        public DateTime LastArchiveUpdate;
        public bool ArchiveBit;
        public bool NeedsArchive;
        public string FileHash;
    }
}
