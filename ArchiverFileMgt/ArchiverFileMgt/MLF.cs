using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SQLite;

namespace ArchiverFileMgt
{
    /// <summary>
    /// Processes files of the same name in multiple locations (directories)
    /// </summary>
    class MLF
    {

        public static int LocID = 0;
        public static int DirID = 0;
        public static int FileID = 0;
        public static string FileHash = "";

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

            string sql = "select  count(*) FROM MultiLocationFiles where DirID =  @DirID and FileID = @FileID ";
            using (SQLiteCommand cmd = new SQLiteCommand(conn))
            {
                cmd.CommandText = sql;
                cmd.Prepare();
                cmd.Parameters.AddWithValue("@FileID", FileID);
                cmd.Parameters.AddWithValue("@DirID", DirID);

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
            LocID = Convert.ToInt32(ControlParms["LocID"]);
            DirID = Convert.ToInt32(ControlParms["DirID"]);
            FileID = Convert.ToInt32(ControlParms["FileID"]);
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
        public static bool UpdateCol(SQLiteConnection conn, int RecKey, string ColName, DateTime ColVal)
        {
            bool b = true;
            int result = 0;

            try
            {
                using (SQLiteCommand cmd = new SQLiteCommand(conn))
                {
                    string sql = "";
                    sql += "Update [MultiLocationFiles] " + Environment.NewLine;
                    sql += "(set [" + ColName + "] = @ColVal " + Environment.NewLine;
                    sql += "WHERE LocID = @LocID ";

                    cmd.CommandText = sql;
                    cmd.Prepare();
                    cmd.Parameters.AddWithValue("@LocID", RecKey);
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
        public static bool DeleteRec(SQLiteConnection conn, int RecKey)
        {
            bool b = true;
            int result = 0;

            try
            {
                using (SQLiteCommand cmd = new SQLiteCommand(conn))
                {
                    string sql = "";
                    sql += "delete from [MultiLocationFiles] " + Environment.NewLine;
                    sql += "WHERE LocID = @LocID ";

                    cmd.CommandText = sql;
                    cmd.Prepare();
                    cmd.Parameters.AddWithValue("@LocID", RecKey);

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
                    sql += "Update [MultiLocationFiles] " + Environment.NewLine;
                    sql += "(set [DirID] = @DirID " + Environment.NewLine;
                    sql += ",[FileID] = @FileID " + Environment.NewLine;
                    sql += ",[FileHash] = @FileHash " + Environment.NewLine;
                    sql += "WHERE LocID = @LocID ";

                    cmd.CommandText = sql;
                    cmd.Prepare();
                    cmd.Parameters.AddWithValue("@LocID", LocID);
                    cmd.Parameters.AddWithValue("@DirID", DirID);
                    cmd.Parameters.AddWithValue("@FileID", FileID);
                    cmd.Parameters.AddWithValue("@FileHash", LocID);

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
                    sql += "INSERT INTO [MultiLocationFiles] " + Environment.NewLine;
                    sql += "([DirID] " + Environment.NewLine;
                    sql += "([FileID] " + Environment.NewLine;
                    sql += ",[FileHash]) " + Environment.NewLine;
                    sql += "VALUES " + Environment.NewLine;
                    sql += ",@DirID, " + Environment.NewLine;
                    sql += ",@FileID, " + Environment.NewLine;
                    sql += ",@FileHash)";

                    cmd.CommandText = sql;
                    cmd.Prepare();
                    cmd.Parameters.AddWithValue("@DirID", DirID);
                    cmd.Parameters.AddWithValue("@FileID", FileID);
                    cmd.Parameters.AddWithValue("@FileHash", LocID);

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
        /// Gets the records.
        /// </summary>
        /// <param name="conn">The connection.</param>
        /// <param name="ControlParms">The control parms.</param>
        /// <returns></returns>
        public static List<DS_MultiLocation> GetRecords(SQLiteConnection conn, Dictionary<string, string> ControlParms)
        {
            List<DS_MultiLocation> ListOfDS = new List<DS_MultiLocation>();

            bool b = true;
            b = SetVars(ControlParms);

            try
            {

                string sql = "SELECT LocID, DirID, FileID,FileHash" + Environment.NewLine;
                sql += "From [MultiLocationFiles]" + Environment.NewLine;
                sql += "where DirID= @DirID and FileID= @FileID";

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
                            DS_MultiLocation dr = new DS_MultiLocation();
                            dr.LocID = Convert.ToInt32(reader["LocID"]);
                            dr.DirID = Convert.ToInt32(reader["DirID"]);
                            dr.FileID = Convert.ToInt32(reader["FileID"]);
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
    /// MultiLocation data structure
    /// </summary>
    public class DS_MultiLocation
    {
        public int LocID = 0;
        public int DirID = 0;
        public int FileID = 0;
        public string FileHash = "";
    }
}
