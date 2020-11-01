using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SQLite;

namespace ArchiverFileMgt
{
    public static class CNTCT
    {
        /*
        [Email1Address] nvarchar(100) NOT NULL COLLATE NOCASE
        , [FullName] nvarchar(100) NOT NULL COLLATE NOCASE
         */
        public static string FullName = "";
        public static string Email1Address = "";
        public static int RowID;

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
            int i = RecExists(conn, Email1Address, FullName);

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
        /// <param name="Email1Address">The email1 address.</param>
        /// <param name="FullName">The full name.</param>
        /// <returns></returns>
        public static int RecExists(SQLiteConnection conn, string Email1Address, string FullName)
        {
            int i = 0;
            string sql = "select  count(*) FROM ContactsArchive where Email1Address =  @Email1Address and FullName = @FullName ";
            using (SQLiteCommand cmd = new SQLiteCommand(conn))
            {
                cmd.CommandText = sql;
                cmd.Prepare();
                cmd.Parameters.AddWithValue("@FullName", FullName);
                cmd.Parameters.AddWithValue("@Email1Address", Email1Address);

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
            Email1Address = ControlParms["Email1Address"];
            FullName = ControlParms["FullName"];
            return b;
        }

        /// <summary>
        /// Updates the col.
        /// </summary>
        /// <param name="conn">The connection.</param>
        /// <param name="Email1Address">The email1 address.</param>
        /// <param name="ColName">Name of the col.</param>
        /// <param name="ColVal">The col value.</param>
        /// <returns></returns>
        public static bool UpdateCol(SQLiteConnection conn, int Email1Address, string ColName, DateTime ColVal)
        {
            bool b = true;
            int result = 0;

            try
            {
                using (SQLiteCommand cmd = new SQLiteCommand(conn))
                {
                    string sql = "";
                    sql += "Update [ContactsArchive] " + Environment.NewLine;
                    sql += "(set [" + ColName + "] = @ColVal " + Environment.NewLine;
                    sql += "WHERE RowID = @RowID ";

                    cmd.CommandText = sql;
                    cmd.Prepare();
                    cmd.Parameters.AddWithValue("@RowID", RowID);
                    cmd.Parameters.AddWithValue("@FullName", FullName);
                    cmd.Parameters.AddWithValue("@Email1Address", Email1Address);
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
        /// <param name="RowID">The row identifier.</param>
        /// <returns></returns>
        public static bool DeleteRec(SQLiteConnection conn, int RowID)
        {
            bool b = true;
            int result = 0;

            try
            {
                using (SQLiteCommand cmd = new SQLiteCommand(conn))
                {
                    string sql = "";
                    sql += "delete from [ContactsArchive] " + Environment.NewLine;
                    sql += "WHERE RowID = @RowID";

                    cmd.CommandText = sql;
                    cmd.Prepare();
                    cmd.Parameters.AddWithValue("@RowID", RowID);

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
                    sql += "Update [ContactsArchive] " + Environment.NewLine;
                    sql += "(set [FullName] = @FullName " + Environment.NewLine;
                    sql += ",[Email1Address] = @Email1Address " + Environment.NewLine;
                    sql += "WHERE RowID = @RowID";

                    cmd.CommandText = sql;
                    cmd.Prepare();
                    cmd.Parameters.AddWithValue("@RowID", RowID);
                    cmd.Parameters.AddWithValue("@Email1Address", Email1Address);
                    cmd.Parameters.AddWithValue("@FullName", FullName);

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
                    sql += "INSERT INTO [ContactsArchive] " + Environment.NewLine;
                    sql += "([FullName] " + Environment.NewLine;
                    sql += ",[Email1Address]) " + Environment.NewLine;
                    sql += "VALUES " + Environment.NewLine;
                    sql += "(@FullName, " + Environment.NewLine;
                    sql += ",@Email1Address)";

                    cmd.CommandText = sql;
                    cmd.Prepare();
                    cmd.Parameters.AddWithValue("@FullName", FullName);
                    cmd.Parameters.AddWithValue("@Email1Address", Email1Address);

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
        public static List<DS_Contacts> GetRecords(SQLiteConnection conn, Dictionary<string, string> ControlParms)
        {
            List<DS_Contacts> ListOfDS = new List<DS_Contacts>();

            bool b = true;
            b = SetVars(ControlParms);

            try
            {
                
                string sql = "SELECT [RowID] " + Environment.NewLine;
                sql += ",[FullName] " + Environment.NewLine;
                sql += ",[Email1Address] " + Environment.NewLine;
                sql += "FROM ContactsArchive " + Environment.NewLine;
                sql += "where FullName = @FullName and Email1Address = @Email1Address ";

                using (SQLiteCommand cmd = new SQLiteCommand(conn))
                {
                    cmd.CommandText = sql;
                    cmd.Prepare();
                    cmd.Parameters.AddWithValue("@FullName", FullName);
                    cmd.Parameters.AddWithValue("@Email1Address", Email1Address);

                    using (SQLiteDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            DS_Contacts dr = new DS_Contacts();

                            dr.RowID = Convert.ToInt32(reader["RowID"]);
                            dr.Email1Address = reader["Email1Address"].ToString();
                            dr.FullName = reader["FullName"].ToString();
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
    /// Contacts data structure
    /// </summary>
    public class DS_Contacts
    {
        public int RowID = 0;
        public string FullName = "";
        public string Email1Address = "";
    }
}
