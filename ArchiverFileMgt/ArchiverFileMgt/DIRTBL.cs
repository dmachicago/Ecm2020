using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SQLite;

namespace ArchiverFileMgt
{
    /// <summary>
    /// Processes the Directory table
    /// </summary>
    public static class DIRTBL
    {
        public static string DirName = "";
        public static int DirID = 0;
        public static bool UseArchiveBit = false;
        public static string DirHash = "";

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
            int i = RecExists(conn, DirName);

            if (i > 0)
            {
                b = UpdateRec(conn, ControlParms);
            }
            else
            {
                b = InsertRec(conn, ControlParms);
            }

            ix = GetRowID(conn, DirName);

            return ix;
        }

        /// <summary>
        /// Records the exists.
        /// </summary>
        /// <param name="conn">The connection.</param>
        /// <param name="skey">The skey.</param>
        /// <returns></returns>
        public static int RecExists(SQLiteConnection conn, string skey)
        {
            int i = 0;
            string sql = "select count(*) FROM Directory where DirName = @DirName ";
            using (SQLiteCommand cmd = new SQLiteCommand(conn))
            {
                cmd.CommandText = sql;
                cmd.Prepare();
                cmd.Parameters.AddWithValue("@DirName", DirName);
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
            string s = "";
            DirName = ControlParms["DirName"];
            DirID = Convert.ToInt32(ControlParms["DirID"]);
            s = ControlParms["UseArchiveBit"];
            if (s.Equals("0") | s.Equals("false"))
            {
                UseArchiveBit = false;
            }
            else
                UseArchiveBit = true;

            DirHash = ControlParms["DirHash"];
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
                    sql += "Update [Directory] " + Environment.NewLine;
                    sql += "(set [" + ColName + "] = @ColVal " + Environment.NewLine;
                    sql += "WHERE DirID = @DirID ";

                    cmd.CommandText = sql;
                    cmd.Prepare();
                    cmd.Parameters.AddWithValue("@DirID", RecKey);
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
                    sql += "delete from [Directory] " + Environment.NewLine;
                    sql += "WHERE DirID = @DirID ";

                    cmd.CommandText = sql;
                    cmd.Prepare();
                    cmd.Parameters.AddWithValue("@DirID", RecKey);

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
                    sql += "Update [Directory] " + Environment.NewLine;
                    sql += "set [UseArchiveBit] = @UseArchiveBit " + Environment.NewLine;
                    sql += ",[DirHash] = @DirHash " + Environment.NewLine;
                    sql += "WHERE DirName = @DirName ";

                    cmd.CommandText = sql;
                    cmd.Prepare();
                    cmd.Parameters.AddWithValue("@DirID", DirID);
                    cmd.Parameters.AddWithValue("@UseArchiveBit", UseArchiveBit);
                    cmd.Parameters.AddWithValue("@DirHash", DirHash);
                    cmd.Parameters.AddWithValue("@DirName", DirName);

                    try
                    {
                        result = cmd.ExecuteNonQuery();
                    }
                    catch (SQLiteException excp) { string x = excp.Message; Console.WriteLine(excp.Message); }
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
                    sql += "INSERT INTO [Directory] " + Environment.NewLine;
                    sql += "([UseArchiveBit] " + Environment.NewLine;
                    sql += ",[DirName] " + Environment.NewLine;
                    sql += ",[DirHash]) " + Environment.NewLine;
                    sql += "VALUES " + Environment.NewLine;
                    sql += "(@UseArchiveBit " + Environment.NewLine;
                    sql += ",@DirName";
                    sql += ",@DirHash)";

                    cmd.CommandText = sql;
                    cmd.Prepare();
                    cmd.Parameters.AddWithValue("@UseArchiveBit", UseArchiveBit);
                    cmd.Parameters.AddWithValue("@DirName", DirName);
                    cmd.Parameters.AddWithValue("@DirHash", DirHash);

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
        /// <param name="DirName">Name of the dir.</param>
        /// <returns></returns>
        public static int GetRowID(SQLiteConnection conn, string DirName)
        {
            try
            {
                string sql = "SELECT DirID " + Environment.NewLine;
                sql += "From [Directory]" + Environment.NewLine;
                sql += "where DirName= @DirName ";

                using (SQLiteCommand cmd = new SQLiteCommand(conn))
                {

                    cmd.CommandText = sql;
                    cmd.Prepare();
                    cmd.Parameters.AddWithValue("@DirName", DirName);

                    using (SQLiteDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            DirID = Convert.ToInt32(reader["DirID"]);
                        }
                    }
                }

            }
            catch (SQLiteException e)
            {
                Console.WriteLine(e.Message);
            }

            return DirID;
        }

        /// <summary>
        /// Gets the records.
        /// </summary>
        /// <param name="conn">The connection.</param>
        /// <param name="ControlParms">The control parms.</param>
        /// <returns></returns>
        public static List<DS_Dir> GetRecords(SQLiteConnection conn, Dictionary<string, string> ControlParms)
        {
            List<DS_Dir> ListOfDS = new List<DS_Dir>();

            bool b = true;
            b = SetVars(ControlParms);

            try
            {

                string sql = "SELECT DirID, DirName, UseArchiveBit, DirHash " + Environment.NewLine;
                sql += "From [Directory]" + Environment.NewLine;
                sql += "where DirName= @DirName ";

                using (SQLiteCommand cmd = new SQLiteCommand(conn))
                {

                    cmd.CommandText = sql;
                    cmd.Prepare();
                    cmd.Parameters.AddWithValue("@DirName", DirName);

                    using (SQLiteDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            DS_Dir dr = new DS_Dir();

                            dr.DirID = Convert.ToInt32(reader["DirID"]);
                            dr.DirName = reader["DirName"].ToString();
                            dr.UseArchiveBit = Convert.ToBoolean(reader["UseArchiveBit"]);
                            dr.DirHash = reader["DirHash"].ToString();
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
        /// Gets the existing recs.
        /// </summary>
        /// <param name="conn">The connection.</param>
        /// <returns></returns>
        public static Dictionary<string, int> GetExistingRecs(SQLiteConnection conn)
        {
            Dictionary<string, int> ListOfDS = new Dictionary<string, int>();

            try
            {

                string sql = "SELECT DirName, DirID FROM Directory ";

                using (SQLiteCommand cmd = new SQLiteCommand(conn))
                {

                    cmd.CommandText = sql;

                    using (SQLiteDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            DirName = reader["DirName"].ToString();
                            DirID = Convert.ToInt32(reader["DirID"]);
                            ListOfDS.Add(DirName.ToUpper(), DirID);
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
    /// Directory data structure
    /// </summary>
    public class DS_Dir
    {
        public string DirName = "";
        public int DirID = 0;
        public bool UseArchiveBit = false;
        public string DirHash = "";
    }
}
