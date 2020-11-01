using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SQLite;

namespace ArchiverFileMgt
{
    /// <summary>
    /// Classs for Outlook
    /// </summary>
    class OLOOK
    {

        public static int RowID = 0;
        public static bool KeyExists = true;
        public static string skey = "";

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
            int i = RecExists(conn);

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
        /// <returns></returns>
        public static int RecExists(SQLiteConnection conn)
        {
            int i = 0;
            string sql = "select  count(*) FROM OutLook where skey =  @skey ";
            using (SQLiteCommand cmd = new SQLiteCommand(conn))
            {
                cmd.CommandText = sql;
                cmd.Prepare();
                cmd.Parameters.AddWithValue("@skey", skey);
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
            RowID = Convert.ToInt32(ControlParms["RowID"]);
            KeyExists = Convert.ToBoolean(ControlParms["KeyExists"]);
            skey = ControlParms["skey"];
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
                    sql += "Update [Outlook] " + Environment.NewLine;
                    sql += "(set [" + ColName + "] = @ColVal " + Environment.NewLine;
                    sql += "WHERE RowID = @RowID ";

                    cmd.CommandText = sql;
                    cmd.Prepare();
                    cmd.Parameters.AddWithValue("@RowID", RecKey);
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
                    sql += "delete from [Outlook] " + Environment.NewLine;
                    sql += "WHERE RowID = @RowID ";

                    cmd.CommandText = sql;
                    cmd.Prepare();
                    cmd.Parameters.AddWithValue("@RowID", RecKey);

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
                    sql += "Update [Outlook] " + Environment.NewLine;
                    sql += "(set [KeyExists] = @KeyExists " + Environment.NewLine;
                    sql += ",[skey] = @skey " + Environment.NewLine;
                    sql += "WHERE RowID = @RowID ";

                    cmd.CommandText = sql;
                    cmd.Prepare();
                    cmd.Parameters.AddWithValue("@RowID", RowID);
                    cmd.Parameters.AddWithValue("@KeyExists", RowID);
                    cmd.Parameters.AddWithValue("@skey", RowID);

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
                    sql += "INSERT INTO [Outlook] " + Environment.NewLine;
                    sql += "([KeyExists] " + Environment.NewLine;
                    sql += ",[skey]) " + Environment.NewLine;
                    sql += "VALUES " + Environment.NewLine;
                    sql += ",@KeyExists, " + Environment.NewLine;
                    sql += ",@skey)";

                    cmd.CommandText = sql;
                    cmd.Prepare();
                    cmd.Parameters.AddWithValue("@KeyExists", RowID);
                    cmd.Parameters.AddWithValue("@skey", RowID);

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
        public static List<DS_Outlook> GetRecords(SQLiteConnection conn, Dictionary<string, string> ControlParms)
        {
            List<DS_Outlook> ListOfDS = new List<DS_Outlook>();

            bool b = true;
            b = SetVars(ControlParms);

            try
            {

                string sql = "SELECT RowID, KeyExists, skey from Outlook " + Environment.NewLine;
                sql += "where skey= @skey ";

                using (SQLiteCommand cmd = new SQLiteCommand(conn))
                {

                    cmd.CommandText = sql;
                    cmd.Prepare();
                    cmd.Parameters.AddWithValue("@skey", skey);

                    using (SQLiteDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            DS_Outlook dr = new DS_Outlook();

                            dr.RowID = Convert.ToInt32(reader["RowID"]);
                            dr.skey = reader["skey"].ToString();
                            dr.KeyExists = Convert.ToBoolean(reader["KeyExists"]);

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
    /// Outlook / Email data structure
    /// </summary>
    public class DS_Outlook
    {
        public int RowID = 0;
        public bool KeyExists = false;
        public string skey = "";
    }
}
