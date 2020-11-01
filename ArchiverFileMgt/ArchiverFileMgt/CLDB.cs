using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Security.Cryptography;
using System.Data.SQLite;

namespace ArchiverFileMgt
{
    static class CLDB
    {

        /// <summary>
        /// Gets the languages.
        /// </summary>
        /// <param name="connectionString">The connection string.</param>
        /// <param name="UserID">The user identifier.</param>
        /// <returns>List of supported languages within this repository</returns>
        public static List<string> GetLanguages(string connectionString, string UserID)
        {
            List<string> ProcessedFiles = new List<string>();
            try
            {
                using (SQLiteConnection conn = new SQLiteConnection(connectionString))
                {
                    conn.Open();
                    string sql = "SELECT * FROM ArchivedItems WHERE Id = " + UserID;
                    using (SQLiteCommand cmd = new SQLiteCommand(sql, conn))
                    {
                        using (SQLiteDataReader reader = cmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                string fqn = reader["fqn"].ToString();
                                ProcessedFiles.Add(fqn);
                            }
                        }
                    }
                    conn.Close();
                }
            }
            catch (SQLiteException e)
            {
                Console.WriteLine(e.Message);
            }
            return ProcessedFiles;
        }

        /// <summary>
        /// Updates the language title.
        /// </summary>
        /// <param name="connectionString">The connection string.</param>
        /// <param name="id">The identifier.</param>
        /// <param name="attr">The attribute.</param>
        /// <param name="val">The value.</param>
        /// <returns>#of affected records</returns>
        public static int UpdateLangTitle(string connectionString, int id, string attr, string val)
        {
            int result = -1;
            using (SQLiteConnection conn = new SQLiteConnection(connectionString))
            {
                conn.Open();
                using (SQLiteCommand cmd = new SQLiteCommand(conn))
                {
                    cmd.CommandText = "UPDATE Language "
                        + "SET LangTitle = @Lang "
                        + "WHERE Id = @Id";
                    cmd.Prepare();
                    cmd.Parameters.AddWithValue("id", id);
                    cmd.Parameters.AddWithValue(attr, val);
                    try
                    {
                        result = cmd.ExecuteNonQuery();
                    }
                    catch (SQLiteException ex)
                    {
                        string x = ex.Message;
                        Console.WriteLine("ERROR 22x3 UpdateLangTitle: " + x);
                    }
                }
                conn.Close();
            }
            return result;
        }
    }
}
