using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SQLite;
using System.Configuration;

namespace SQLiteTool
{
    public partial class frmMain : Form
    {
        public string filename = @"C:\cplus\tutorials\c#\SQLite\About.sqlite";

        public frmMain()
        {
            InitializeComponent();
        }

        public string setConn()
        {
            filename = @"C:\cplus\tutorials\c#\SQLite\About.sqlite";
            return filename;
        }

        private void rbContactsArchive_CheckedChanged(object sender, EventArgs e)
        {
            string SQLiteDB = ConfigurationManager.AppSettings["SQLiteDB"];
            const string sql = "select * from ContactsArchive;";
            var conn = new SQLiteConnection("Data Source=" + SQLiteDB);
            try
            {
                conn.Open();
                DataSet ds = new DataSet();
                var da = new SQLiteDataAdapter(sql, conn);
                da.Fill(ds);
                dgData.DataSource = ds.Tables[0].DefaultView;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void rbDirectory_CheckedChanged(object sender, EventArgs e)
        {
            string SQLiteDB = ConfigurationManager.AppSettings["SQLiteDB"];
            const string sql = "select * from Directory;";
            var conn = new SQLiteConnection("Data Source=" + SQLiteDB);
            try
            {
                conn.Open();
                DataSet ds = new DataSet();
                var da = new SQLiteDataAdapter(sql, conn);
                da.Fill(ds);
                dgData.DataSource = ds.Tables[0].DefaultView;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void rbExchange_CheckedChanged(object sender, EventArgs e)
        {
            string SQLiteDB = ConfigurationManager.AppSettings["SQLiteDB"];
            const string sql = "select * from Exchange;";
            var conn = new SQLiteConnection("Data Source=" + SQLiteDB);
            try
            {
                conn.Open();
                DataSet ds = new DataSet();
                var da = new SQLiteDataAdapter(sql, conn);
                da.Fill(ds);
                dgData.DataSource = ds.Tables[0].DefaultView;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void rbFiles_CheckedChanged(object sender, EventArgs e)
        {
            string SQLiteDB = ConfigurationManager.AppSettings["SQLiteDB"];
            const string sql = "select * from Files;";
            var conn = new SQLiteConnection("Data Source=" + SQLiteDB);
            try
            {
                conn.Open();
                DataSet ds = new DataSet();
                var da = new SQLiteDataAdapter(sql, conn);
                da.Fill(ds);
                dgData.DataSource = ds.Tables[0].DefaultView;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void rbInventory_CheckedChanged(object sender, EventArgs e)
        {
            string SQLiteDB = ConfigurationManager.AppSettings["SQLiteDB"];
            const string sql = "select * from Inventory;";
            var conn = new SQLiteConnection("Data Source=" + SQLiteDB);
            try
            {
                conn.Open();
                DataSet ds = new DataSet();
                var da = new SQLiteDataAdapter(sql, conn);
                da.Fill(ds);
                dgData.DataSource = ds.Tables[0].DefaultView;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void rbListener_CheckedChanged(object sender, EventArgs e)
        {
            string SQLiteDB = ConfigurationManager.AppSettings["SQLiteDB"];
            const string sql = "select * from Listener;";
            var conn = new SQLiteConnection("Data Source=" + SQLiteDB);
            try
            {
                conn.Open();
                DataSet ds = new DataSet();
                var da = new SQLiteDataAdapter(sql, conn);
                da.Fill(ds);
                dgData.DataSource = ds.Tables[0].DefaultView;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void rbMultiLocationFiles_CheckedChanged(object sender, EventArgs e)
        {
            string SQLiteDB = ConfigurationManager.AppSettings["SQLiteDB"];
            const string sql = "select * from MultiLocationFiles;";
            var conn = new SQLiteConnection("Data Source=" + SQLiteDB);
            try
            {
                conn.Open();
                DataSet ds = new DataSet();
                var da = new SQLiteDataAdapter(sql, conn);
                da.Fill(ds);
                dgData.DataSource = ds.Tables[0].DefaultView;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void rbOutlook_CheckedChanged(object sender, EventArgs e)
        {
            string SQLiteDB = ConfigurationManager.AppSettings["SQLiteDB"];
            const string sql = "select * from Outlook;";
            var conn = new SQLiteConnection("Data Source=" + SQLiteDB);
            try
            {
                conn.Open();
                DataSet ds = new DataSet();
                var da = new SQLiteDataAdapter(sql, conn);
                da.Fill(ds);
                dgData.DataSource = ds.Tables[0].DefaultView;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void rbZipFile_CheckedChanged(object sender, EventArgs e)
        {
            string SQLiteDB = ConfigurationManager.AppSettings["SQLiteDB"];
            const string sql = "select * from ZipFile;";
            var conn = new SQLiteConnection("Data Source=" + SQLiteDB);
            try
            {
                conn.Open();
                DataSet ds = new DataSet();
                var da = new SQLiteDataAdapter(sql, conn);
                da.Fill(ds);
                dgData.DataSource = ds.Tables[0].DefaultView;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void readFiles()
        {
            string SQLiteDB = ConfigurationManager.AppSettings["SQLiteDB"];
            var conn = new SQLiteConnection("Data Source=" + SQLiteDB);
            //String strSqlCommand = "SELECT * FROM Files order by FileName";
            String strSqlCommand = "SELECT * FROM Directory";
            SQLiteCommand oLocalCommand = new SQLiteCommand(strSqlCommand, conn);
            DataSet ds = new DataSet();
            SQLiteDataAdapter DA = new SQLiteDataAdapter(oLocalCommand);
            DataSet oLocalSet = new DataSet();
            //DA.Fill(oLocalSet, "Directory");
            DA.Fill(ds);

            dgData.DataSource = ds;

            bool b = false;

            if (b)
            {
                SQLiteConnection sqlite_conn;          // Database Connection Object
                SQLiteCommand sqlite_cmd;             // Database Command Object
                SQLiteDataReader sqlite_datareader;  // Data Reader Object

                sqlite_conn = new SQLiteConnection("Data Source=database.sqlite;Version=3;New=True;");
                sqlite_conn.Open();
                sqlite_cmd = sqlite_conn.CreateCommand();
                sqlite_cmd.CommandText = "SELECT FileName, FileID,FileHash FROM test order by FileName";
                sqlite_datareader = sqlite_cmd.ExecuteReader();
                dgData.DataSource = null;
                // The SQLiteDataReader allows us to run through each row per loop
                while (sqlite_datareader.Read()) // Read() returns true if there is still a result line to read
                {
                    string FileName = sqlite_datareader.GetString(0);
                    Int32 FileID = sqlite_datareader.GetInt32(1);
                    string FileHash = sqlite_datareader.GetString(2);
                }
            }
        }

        private void btnSql_Click(object sender, EventArgs e)
        {
            string SQLiteDB = ConfigurationManager.AppSettings["SQLiteDB"];
            string sql = txtSql.Text + ";";
            var conn = new SQLiteConnection("Data Source=" + SQLiteDB);
            try
            {
                conn.Open();
                System.Data.SQLite.SQLiteCommand cmd = new System.Data.SQLite.SQLiteCommand(sql, conn);
                try
                {
                    cmd.ExecuteNonQuery();
                    MessageBox.Show("Execution successful...");
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Execution Failed: \n" + sql + "\n" + ex.Message);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
    }
}
