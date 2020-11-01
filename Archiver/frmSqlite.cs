using System;
using global::System.Configuration;
using System.Data;
using global::System.IO;
using System.Windows.Forms;
using global::Microsoft.Data.Sqlite;
using Microsoft.VisualBasic;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{
    // Imports System.Data.SQLite


    public partial class frmSqlite
    {
        public frmSqlite()
        {
            InitializeComponent();
            _dgData.Name = "dgData";
            _CheckBox1.Name = "CheckBox1";
            _btnValidate.Name = "btnValidate";
            _btnExec.Name = "btnExec";
            _CheckBox2.Name = "CheckBox2";
            _CheckBox3.Name = "CheckBox3";
            _CheckBox4.Name = "CheckBox4";
            _CheckBox5.Name = "CheckBox5";
            _CheckBox6.Name = "CheckBox6";
            _CheckBox7.Name = "CheckBox7";
            _CheckBox8.Name = "CheckBox8";
            _RadioButton1.Name = "RadioButton1";
            _RadioButton2.Name = "RadioButton2";
            _RadioButton3.Name = "RadioButton3";
            _RadioButton4.Name = "RadioButton4";
            _RadioButton5.Name = "RadioButton5";
            _RadioButton6.Name = "RadioButton6";
            _RadioButton7.Name = "RadioButton7";
            _RadioButton8.Name = "RadioButton8";
        }

        private clsLogging LOG = new clsLogging();
        public string cs = "";
        public SqliteConnection SLiteConn = new SqliteConnection();
        private int UseDebugSQLite = Conversions.ToInteger(ConfigurationManager.AppSettings["UseDebugSQLite"]);

        private string getCs()
        {
            string strPath = "";
            string connstr = "";
            if (UseDebugSQLite.Equals(1))
            {
                slDatabase = ConfigurationManager.AppSettings["SQLiteDir"];
                tchar = slDatabase.Substring(Operators.SubtractObject(slDatabase.Length, 1));
                if (!tchar.Equals(@"\"))
                {
                    strPath += @"\";
                }

                if (!Directory.Exists(Conversions.ToString(slDatabase)))
                {
                    Directory.CreateDirectory(Conversions.ToString(slDatabase));
                }

                slDatabase += "EcmArchive.db";
                if (!File.Exists(Conversions.ToString(slDatabase)))
                {
                    tchar = strPath.Substring(strPath.Length - 1);
                    if (!tchar.Equals(@"\"))
                        strPath += @"\";
                    My.MyProject.Computer.FileSystem.CopyFile(strPath + @"SQLiteDB\EcmArchive.db", Conversions.ToString(slDatabase), overwrite: false);
                }

                connstr = Conversions.ToString(Operators.AddObject("data source=", slDatabase));
            }
            else
            {
                tchar = strPath.Substring(strPath.Length - 1);
                if (!tchar.Equals(@"\"))
                    strPath += @"\";
                slDatabase = strPath + @"SQLiteDB\EcmArchive.db";
                if (!File.Exists(Conversions.ToString(slDatabase)))
                {
                    MessageBox.Show("SQLite DB missing, please correct this issue...");
                }

                connstr = "data source=" + strPath + "EcmArchive.db;";
            }

            lblConn.Text = connstr;
            return connstr;
        }

        private void btnExec_Click(object sender, EventArgs e)
        {
            modGlobals.setSLConn();
            string S = txtSql.Text;
            var CMD = new SqliteCommand(S, SLiteConn);
            try
            {
                CMD.ExecuteNonQuery();
                MessageBox.Show("SUCCESSFUL EXecution");
            }
            catch (Exception ex)
            {
                string msg = "ERROR: clsDbLocal/addInventory - " + Constants.vbCrLf + S + Constants.vbCrLf + ex.Message;
                MessageBox.Show(msg);
                B = false;
            }
            finally
            {
                CMD.Dispose();
                // If cn IsNot Nothing Then
                // If cn.State = ConnectionState.Open Then
                // cn.Close()
                // End If
                // cn.Dispose()
                // End If
                GC.Collect();
                GC.WaitForPendingFinalizers();
            }
        }

        private void rbContactsArchive_CK(DataGridView dg)
        {
            setConn();
            string sql = "select * from ContactsArchive;";
            filleGrid(sql, ref dg);
        }

        private void filleGrid(string SQL, ref DataGridView dg)
        {
            MessageBox.Show("Not available at this time... ");
            return;
            if (txtLimit.Text.Trim().Length > 0)
            {
                SQL = SQL.Replace(";", " ");
                SQL = SQL + " LIMIT " + txtLimit.Text + ";";
            }

            setConn();
            try
            {
            }
            // Dim ds As DataSet = New DataSet()
            // Dim cmdx As New SqliteCommand(sql, SLconn)
            // Dim da = New SQLiteDataAdapter(cmdx)
            // da.Fill(ds)
            // dg.DataSource = ds.Tables(0).DefaultView
            // SLiteConn.Close()
            // SLiteConn.Dispose()

            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void rbDirectory_CheckedChanged_CK(ref DataGridView dg)
        {
            setConn();
            string sql = "select * from Directory;";
            filleGrid(sql, ref dg);
        }

        private void rbExchange_CheckedChanged_CK(ref DataGridView dg)
        {
            setConn();
            string sql = "select * from Exchange;";
            filleGrid(sql, ref dg);
        }

        private void rbFiles_CheckedChanged_CK(ref DataGridView dg)
        {
            setConn();
            string sql = "select * from Files;";
            filleGrid(sql, ref dg);
        }

        private void rbInventory_CheckedChanged_CK(ref DataGridView dg)
        {
            setConn();
            string sql = "select * from Inventory;";
            filleGrid(sql, ref dg);
        }

        private void rbListener_CheckedChanged_CK(ref DataGridView dg)
        {
            setConn();
            string sql = "select * from Listener;";
            filleGrid(sql, ref dg);
        }

        private void rbMultiLocationFiles_CheckedChanged_CK(ref DataGridView dg)
        {
            setConn();
            string sql = "select * from MultiLocationFiles;";
            filleGrid(sql, ref dg);
        }

        private void rbOutlook_CheckedChanged_CK(ref DataGridView dg)
        {
            setConn();
            string sql = "select * from Outlook;";
            filleGrid(sql, ref dg);
        }

        public void rbZipFile_CheckedChanged_CK(ref DataGridView dg)
        {
            setConn();
            string sql = "select * from ZipFile;";
            filleGrid(sql, ref dg);
        }

        private void btnValidate_Click(object sender, EventArgs e)
        {
            setConn();
            if (CheckBox1.Checked)
            {
                rbContactsArchive_CK(dgData);
            }

            if (CheckBox2.Checked)
            {
                var argdg = dgData;
                rbDirectory_CheckedChanged_CK(ref argdg);
                dgData = argdg;
            }

            if (CheckBox4.Checked)
            {
                var argdg1 = dgData;
                rbExchange_CheckedChanged_CK(ref argdg1);
                dgData = argdg1;
            }

            if (CheckBox3.Checked)
            {
                var argdg2 = dgData;
                rbFiles_CheckedChanged_CK(ref argdg2);
                dgData = argdg2;
            }

            if (CheckBox6.Checked)
            {
                var argdg3 = dgData;
                rbListener_CheckedChanged_CK(ref argdg3);
                dgData = argdg3;
            }

            if (CheckBox5.Checked)
            {
                var argdg4 = dgData;
                rbMultiLocationFiles_CheckedChanged_CK(ref argdg4);
                dgData = argdg4;
            }

            if (CheckBox8.Checked)
            {
                var argdg5 = dgData;
                rbOutlook_CheckedChanged_CK(ref argdg5);
                dgData = argdg5;
            }

            if (CheckBox7.Checked)
            {
                var argdg6 = dgData;
                rbZipFile_CheckedChanged_CK(ref argdg6);
                dgData = argdg6;
            }
        }

        private void CheckBox1_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox2.Checked = false;
            CheckBox3.Checked = false;
            CheckBox4.Checked = false;
            CheckBox5.Checked = false;
            CheckBox6.Checked = false;
            CheckBox7.Checked = false;
            CheckBox8.Checked = false;
            // CheckBox1.Checked = True
        }

        private void CheckBox2_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox1.Checked = false;
            CheckBox3.Checked = false;
            CheckBox4.Checked = false;
            CheckBox5.Checked = false;
            CheckBox6.Checked = false;
            CheckBox7.Checked = false;
            CheckBox8.Checked = false;
            int i = 0;
            modGlobals.setSLConn();
            string sql = "";
            if (txtLimit.Text.Length == 0 | txtLimit.Text.Trim().Equals("0"))
            {
                sql = "SELECT * FROM Directory order by DirName ";
            }
            else
            {
                sql = "SELECT * FROM Directory order by DirName LIMIT " + txtLimit.Text.Trim();
            }

            dgData.Columns.Clear();
            dgData.Rows.Clear();
            dgData.Columns.Add("DirName", "DirName");
            dgData.Columns.Add("DirID", "DirID");
            dgData.Columns.Add("UseArchiveBit", "UseArchiveBit");
            dgData.Columns.Add("DirHash", "DirHash");
            string DirName = "";
            string DirID = "";
            string UseArchiveBit = "";
            string DirHash = "";
            try
            {
                modGlobals.SLConn.Open();
            }
            catch (Exception ex)
            {
                Console.WriteLine("XX991: " + ex.Message);
            }

            using (modGlobals.SLConn)
            using (var CMD = new SqliteCommand(sql, modGlobals.SLConn))
            {
                var rdr = CMD.ExecuteReader();
                using (rdr)
                    while (rdr.Read())
                    {
                        DirName = rdr.GetValue(0).ToString();
                        DirID = rdr.GetValue(1).ToString();
                        UseArchiveBit = rdr.GetValue(2).ToString();
                        DirHash = rdr.GetValue(3).ToString();
                        int RowIndex = dgData.Rows.Add();
                        var NewRow = dgData.Rows[RowIndex];
                        NewRow.Cells[0].Value = DirName;
                        NewRow.Cells[1].Value = DirID;
                        NewRow.Cells[2].Value = UseArchiveBit;
                        NewRow.Cells[3].Value = DirHash;
                    }
            }
        }

        private void CheckBox4_CheckedChanged(object sender, EventArgs e)
        {
            // CheckBox4.Checked = True
            CheckBox1.Checked = false;
            CheckBox2.Checked = false;
            CheckBox3.Checked = false;
            CheckBox5.Checked = false;
            CheckBox6.Checked = false;
            CheckBox7.Checked = false;
            CheckBox8.Checked = false;
        }

        private void CheckBox3_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox1.Checked = false;
            CheckBox2.Checked = false;
            CheckBox4.Checked = false;
            CheckBox5.Checked = false;
            CheckBox6.Checked = false;
            CheckBox7.Checked = false;
            CheckBox8.Checked = false;
            // CheckBox3.Checked = True

            int i = 0;
            modGlobals.setSLConn();
            string sql = "";
            if (txtLimit.Text.Length == 0 | txtLimit.Text.Trim().Equals("0"))
            {
                sql = "SELECT * FROM Directory order by FileID ";
            }
            else
            {
                sql = "SELECT * FROM Directory order by FileID LIMIT " + txtLimit.Text.Trim();
            }

            dgData.Columns.Clear();
            dgData.Rows.Clear();
            dgData.Columns.Add("FileID", "FileID");
            dgData.Columns.Add("FileName", "FileName");
            dgData.Columns.Add("FileHash", "FileHash");
            string FileID = "";
            string FileName = "";
            string FileHash = "";
            try
            {
                modGlobals.SLConn.Open();
            }
            catch (Exception ex)
            {
                Console.WriteLine("XX991: " + ex.Message);
            }

            using (modGlobals.SLConn)
            using (var CMD = new SqliteCommand(sql, modGlobals.SLConn))
            {
                var rdr = CMD.ExecuteReader();
                using (rdr)
                    while (rdr.Read())
                    {
                        FileID = rdr.GetValue(0).ToString();
                        FileName = rdr.GetValue(1).ToString();
                        FileHash = rdr.GetValue(2).ToString();
                        int RowIndex = dgData.Rows.Add();
                        var NewRow = dgData.Rows[RowIndex];
                        NewRow.Cells[0].Value = FileID;
                        NewRow.Cells[1].Value = FileName;
                        NewRow.Cells[2].Value = FileHash;
                    }
            }
        }

        private void CheckBox6_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox1.Checked = false;
            CheckBox2.Checked = false;
            CheckBox3.Checked = false;
            CheckBox4.Checked = false;
            CheckBox5.Checked = false;
            // CheckBox6.Checked = True
            CheckBox7.Checked = false;
            CheckBox8.Checked = false;
        }

        private void CheckBox5_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox1.Checked = false;
            CheckBox2.Checked = false;
            CheckBox3.Checked = false;
            CheckBox4.Checked = false;
            // CheckBox5.Checked = True
            CheckBox6.Checked = false;
            CheckBox7.Checked = false;
            CheckBox8.Checked = false;
        }

        private void CheckBox8_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox1.Checked = false;
            CheckBox2.Checked = false;
            CheckBox3.Checked = false;
            CheckBox4.Checked = false;
            CheckBox5.Checked = false;
            CheckBox6.Checked = false;
            CheckBox7.Checked = false;
            // CheckBox8.Checked = True
        }

        private void CheckBox7_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox1.Checked = false;
            CheckBox2.Checked = false;
            CheckBox3.Checked = false;
            CheckBox4.Checked = false;
            CheckBox5.Checked = false;
            CheckBox6.Checked = false;
            // CheckBox7.Checked = True
            CheckBox8.Checked = false;
        }

        public bool setConn()
        {
            bool bb = true;
            if (!SLiteConn.State.Equals(ConnectionState.Open))
            {
                try
                {
                    string slDatabase = "";
                    string tchar = "";
                    string cs = "";
                    string strPath = Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().CodeBase);
                    int I = 0;
                    I = strPath.IndexOf(":");
                    I += 2;
                    strPath = strPath.Substring(I);
                    if (UseDebugSQLite.Equals(1))
                    {
                        slDatabase = ConfigurationManager.AppSettings["SQLiteDir"];
                        tchar = slDatabase.Substring(slDatabase.Length - 1);
                        if (!tchar.Equals(@"\"))
                        {
                            strPath += @"\";
                        }

                        if (!Directory.Exists(slDatabase))
                        {
                            Directory.CreateDirectory(slDatabase);
                        }

                        slDatabase += "EcmArchive.db";
                        if (!File.Exists(slDatabase))
                        {
                            tchar = strPath.Substring(strPath.Length - 1);
                            if (!tchar.Equals(@"\"))
                                strPath += @"\";
                            My.MyProject.Computer.FileSystem.CopyFile(strPath + @"SQLiteDB\EcmArchive.db", slDatabase, overwrite: false);
                        }

                        cs = "data source=" + slDatabase;
                    }
                    else
                    {
                        tchar = strPath.Substring(strPath.Length - 1);
                        if (!tchar.Equals(@"\"))
                            strPath += @"\";
                        slDatabase = strPath + @"SQLiteDB\EcmArchive.db";
                        if (!File.Exists(slDatabase))
                        {
                            MessageBox.Show("SQLite DB missing, please correct this issue...");
                        }

                        cs = "data source=" + strPath + "EcmArchive.db;";
                    }

                    // Dim cs As String = strPath + "\CE\EcmArchive.db;"
                    SLiteConn.ConnectionString = cs;
                    SLiteConn.Open();
                    bb = true;
                    modGlobals.bSLConn = true;
                }
                catch (Exception ex)
                {
                    bb = false;
                    modGlobals.bSLConn = false;
                }
            }

            return bb;
        }

        private void RadioButton1_CheckedChanged(object sender, EventArgs e)
        {
            string tbl = "ContactsArchive";
            string s = getCount(tbl);
            MessageBox.Show(tbl + " : " + s);
        }

        public string getCount(string tbl)
        {
            int i = 0;
            modGlobals.setSLConn();
            using (modGlobals.SLConn)
            {
                string sql = "SELECT count(*) FROM " + tbl;
                using (var CMD = new SqliteCommand(sql, modGlobals.SLConn))
                {
                    var rdr = CMD.ExecuteReader();
                    using (rdr)
                        while (rdr.Read())
                            i = rdr.GetInt32(0);
                }
            }

            return i.ToString();
        }

        private void RadioButton3_CheckedChanged(object sender, EventArgs e)
        {
            string tbl = "Directory";
            string s = getCount(tbl);
            MessageBox.Show(tbl + " : " + s);
        }

        private void RadioButton2_CheckedChanged(object sender, EventArgs e)
        {
            string tbl = "Exchange";
            string s = getCount(tbl);
            MessageBox.Show(tbl + " : " + s);
        }

        private void RadioButton6_CheckedChanged(object sender, EventArgs e)
        {
            string tbl = "Files";
            string s = getCount(tbl);
            MessageBox.Show(tbl + " : " + s);
        }

        private void RadioButton4_CheckedChanged(object sender, EventArgs e)
        {
            string tbl = "Listener";
            string s = getCount(tbl);
            MessageBox.Show(tbl + " : " + s);
        }

        private void RadioButton5_CheckedChanged(object sender, EventArgs e)
        {
            string tbl = "MultiLocationFiles";
            string s = getCount(tbl);
            MessageBox.Show(tbl + " : " + s);
        }

        private void RadioButton7_CheckedChanged(object sender, EventArgs e)
        {
            string tbl = "Outlook";
            string s = getCount(tbl);
            MessageBox.Show(tbl + " : " + s);
        }

        private void RadioButton8_CheckedChanged(object sender, EventArgs e)
        {
            string tbl = "Zipfile";
            string s = getCount(tbl);
            MessageBox.Show(tbl + " : " + s);
        }

        private void dgData_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
        }
    }
}