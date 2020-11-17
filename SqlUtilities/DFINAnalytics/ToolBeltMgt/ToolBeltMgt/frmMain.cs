using System;
using System.Data;
using System.Windows.Forms;

namespace ToolBeltMgt
{
    public partial class frmMain : Form
    {
        public bool dgready = false;

        public frmMain ()
        {
            InitializeComponent ();
        }

        private void frmMain_Load (object sender, EventArgs e)
        {
            tsDatabaseStatus.Text = "NOT Attached to Database";
            SB.Text = "";
        }

        private void loginToolStripMenuItem_Click (object sender, EventArgs e)
        {
            frmLogin m = new frmLogin ();
            m.ShowDialog (this);
            if (DB.svrConnected == 1)
            {
                tsDatabaseStatus.Text = "Server Connected";

                DataTable dtGroups = new DataTable ();
                DataTable dtServers = new DataTable ();

                dtServers = DB.getServers ();
                dtGroups = DB.getGroups ();

                cbServers.Items.Clear ();
                foreach (DataRow dr in dtServers.Rows)
                {
                    foreach (DataColumn col in dtServers.Columns)
                        cbServers.Items.Add (dr[col]);
                }

                cbGroups.Items.Clear ();
                foreach (DataRow dr in dtGroups.Rows)
                {
                    foreach (DataColumn col in dtGroups.Columns)
                        cbGroups.Items.Add (dr[col]);
                }

                dgServers.DataSource = DB.getActiveServers ();
            }
            else
                tsDatabaseStatus.Text = "Server FAILED to Connect";
        }

        private void cbServers_SelectedIndexChanged (object sender, EventArgs e)
        {
            string selServer = cbServers.Text;
            DataTable dtDatabases = new DataTable ();
            dtDatabases = DB.getServerDB (selServer);

            cbDatabase.Items.Clear ();
            foreach (DataRow dr in dtDatabases.Rows)
            {
                foreach (DataColumn col in dtDatabases.Columns)
                    cbDatabase.Items.Add (dr[col]);
            }
        }

        private void cbGroups_SelectedIndexChanged (object sender, EventArgs e)
        {
            string selGroup = cbGroups.Text;
            DataTable dt = new DataTable ();
            dt = DB.getGroupServers (selGroup);
            cbServers.Items.Clear ();
            foreach (DataRow dr in dt.Rows)
            {
                foreach (DataColumn col in dt.Columns)
                    cbServers.Items.Add (dr[col]);
            }

            string selServer = cbServers.Text;
            DataTable dtDatabases = new DataTable ();
            dtDatabases = DB.getServerDB (selServer);

            cbDatabase.Items.Clear ();
            foreach (DataRow dr in dtDatabases.Rows)
            {
                foreach (DataColumn col in dtDatabases.Columns)
                    cbDatabase.Items.Add (dr[col]);
            }
        }

        private void cbDatabase_SelectedIndexChanged (object sender, EventArgs e)
        {
            setFormValues ();
        }

        private void dgServers_CellContentClick (object sender, DataGridViewCellEventArgs e)
        {
            setFormValues ();
        }

        private void dgServers_UserAddedRow (object sender, DataGridViewRowEventArgs e)
        {
            setFormValues ();
        }

        private void setFormValues ()
        {
            try
            {
                string msg = String.Format ("Row: {0}, Column: {1}", dgServers.CurrentCell.RowIndex, dgServers.CurrentCell.ColumnIndex);

                int rowindex = dgServers.CurrentCell.RowIndex;
                int colindex = dgServers.CurrentCell.ColumnIndex;

                string GroupName = dgServers.Rows[rowindex].Cells["GroupName"].Value.ToString ();
                string SvrName = dgServers.Rows[rowindex].Cells["SvrName"].Value.ToString ();
                string DBName = dgServers.Rows[rowindex].Cells["DBName"].Value.ToString ();
                string UserID = dgServers.Rows[rowindex].Cells["UserID"].Value.ToString ();
                string pwd = dgServers.Rows[rowindex].Cells["pwd"].Value.ToString ();
                string enable = dgServers.Rows[rowindex].Cells["enable"].Value.ToString ();
                string isAzure = dgServers.Rows[rowindex].Cells["isAzure"].Value.ToString ();

                cbGroups.Text = GroupName;
                cbServers.Text = SvrName;
                cbDatabase.Text = DBName;
                txtUid.Text = UserID;
                txtPwd.Text = pwd;
                if (enable.ToLower ().Equals ("true"))
                    ckEnabled.Checked = true;
                else
                    ckEnabled.Checked = false;

                if (isAzure.ToUpper ().Equals ("Y"))
                    ckIsAzure.Checked = true;
                else
                    ckIsAzure.Checked = false;
            }
            catch (Exception ex)
            {
                SB.Text = ex.Message;
            }
        }

        private void dgServers_RowEnter (object sender, DataGridViewCellEventArgs e)
        {
            setFormValues ();
        }

        private void dgServers_Enter (object sender, EventArgs e)
        {
        }

        private void dgServers_SelectionChanged (object sender, EventArgs e)
        {
            setFormValues ();
        }

        private void menuStrip1_ItemClicked (object sender, ToolStripItemClickedEventArgs e)
        {
        }

        private void jobsToolStripMenuItem_Click (object sender, EventArgs e)
        {
            frmJobs m = new frmJobs ();
            m.Show (this);
        }

        private void serverJobsToolStripMenuItem_Click (object sender, EventArgs e)
        {
            frmAssignJobs m = new frmAssignJobs ();
            m.Show (this);
        }

        private void frmMain_FormClosing (object sender, FormClosingEventArgs e)
        {
            DB.closeDatabase ();
        }

        private void btnDeleteSvr_Click (object sender, EventArgs e)
        {
            string SvrName = cbServers.Text;
            DialogResult dr = MessageBox.Show ("Are you sure ? This will remove this server ('" + SvrName + "') from all associated groups and all of its associated jobs from the system. NOTE: History will not be deleted.",
                   "VERIFY", MessageBoxButtons.YesNo);
            switch (dr)
            {
                case DialogResult.Yes:
                    int rc = DB.deleteServer (SvrName);
                    if (rc.Equals (1))
                    {
                        SB.Text = "SERVER Successfully deleted from system.";
                        DataTable dtServers = new DataTable ();
                        dtServers = DB.getServers ();

                        cbServers.Items.Clear ();
                        foreach (DataRow drow in dtServers.Rows)
                        {
                            foreach (DataColumn col in dtServers.Columns)
                                cbServers.Items.Add (drow[col]);
                        }
                    }
                    else
                        SB.Text = "SERVER FAILED to delete from system.";
                    break;

                case DialogResult.No:
                    SB.Text = "Delete cancelled.";
                    break;
            }
        }

        private void btnTest_Click (object sender, EventArgs e)
        {
            string SvrName = cbServers.Text;
            string DBName = cbDatabase.Text;
            string UID = txtUid.Text;
            string pwd = txtPwd.Text;
            string cs = DB.buildConnStr (SvrName, DBName, UID, pwd);
            int rc = DB.testDbConnection (cs);
            if (rc.Equals (1))
            {
                MessageBox.Show ("Connection GOOD");
            }
            else
                MessageBox.Show ("Connection FAILED");
        }

        private void btnGetDBs_Click (object sender, EventArgs e)
        {
            DataTable dtDBs = new DataTable ();
            string SvrName = cbServers.Text;
            //string DBName = cbDatabase.Text;
            string DBName = "master";
            string UID = txtUid.Text;
            string pwd = txtPwd.Text;
            string cs = DB.buildConnStr (SvrName, DBName, UID, pwd);
            dtDBs = DB.getServerDatabases (cs);

            SB.Text = "Returned " + dtDBs.Rows.Count.ToString () + " databases from " + SvrName;

            cbDatabases.Items.Clear ();
            foreach (DataRow dr in dtDBs.Rows)
            {
                foreach (DataColumn col in dtDBs.Columns)
                    cbDatabases.Items.Add (dr[col]);
            }
        }

        private void btnAddSelectedDBs_Click (object sender, EventArgs e)
        {
            
            string GroupName = cbGroups.Text;
            string SvrName = cbServers.Text;
            string DBName = "";
            string UserID = txtUid.Text;
            string pwd = txtPwd.Text;
            string isAzure = ckIsAzure.Checked.ToString ();
            bool enable = ckEnabled.Checked;

            DialogResult dr = MessageBox.Show ("Are you sure ? This cannot be undone and will apply the selected databases as defined below!",
                   "MAKE CERTAIN", MessageBoxButtons.YesNo);
            switch (dr)
            {
                case DialogResult.Yes:
                    for (int i = 0; i < cbDatabases.Items.Count; i++)
                    {
                        if (cbDatabases.GetItemCheckState (i) == CheckState.Checked)
                        {
                            DBName = cbDatabases.Items[i].ToString ();
                            DB.updateActiveServers (GroupName, SvrName, DBName, UserID, pwd, isAzure, enable);
                        }
                        else
                        {
                            DBName = cbDatabases.Items[i].ToString ();
                            DB.deleteActiveServerDatabase (SvrName, DBName);
                        }
                    }
                    break;
                case DialogResult.No:
                    SB.Text = "APPLY cancelled.";
                    break;
            }

            
        }

        private void btnSave_Click (object sender, EventArgs e)
        {
            string GroupName = cbGroups.Text;
            string SvrName = cbServers.Text;
            string DBName = cbDatabase.Text;
            string UserID = txtUid.Text;
            string pwd = txtPwd.Text;
            string isAzure = ckIsAzure.Checked.ToString ();
            bool enable = ckEnabled.Checked;
            DB.updateActiveServers (GroupName, SvrName, DBName, UserID, pwd, isAzure, enable);
        }

        private void btnSelectAll_Click (object sender, EventArgs e)
        {
            for (int i = 0; i < cbDatabases.Items.Count; i++)
            {
                cbDatabases.SetItemChecked (i, true);
                cbDatabases.SetItemCheckState (i, CheckState.Checked);
            }
        }

        private void btnDeselectAll_Click (object sender, EventArgs e)
        {
            for (int i = 0; i < cbDatabases.Items.Count; i++)
            {
                cbDatabases.SetItemChecked (i, false);
                cbDatabases.SetItemCheckState (i, CheckState.Unchecked);
            }
        }

        private void button1_Click (object sender, EventArgs e)
        {
            string baseGroupName = cbGroups.Text;
            string baseSvrName = cbServers.Text;
            string baseDBName = cbDatabase.Text;
            int i = 0;
            int iMax = dgServers.Rows.Count;

            for (int j = 0; j < cbDatabases.Items.Count; j++)
            {
                    cbDatabases.SetItemChecked (j, false);
                    cbDatabases.SetItemCheckState (j, CheckState.Unchecked);
            }

            foreach (DataGridViewRow row in dgServers.Rows)
            {
                i = row.Index;
                try
                {
                    string Group = row.Cells["GroupName"].Value.ToString ();
                    string SvrName = row.Cells["SvrName"].Value.ToString ();
                    string DBName = row.Cells["DBName"].Value.ToString ();

                    if (baseGroupName.ToUpper().Equals (Group.ToUpper()) && baseSvrName.ToUpper().Equals (SvrName.ToUpper())){

                        for (int j = 0; j < cbDatabases.Items.Count; j++)
                        {
                            string tgtDBName = cbDatabases.Items[j].ToString ();
                            if (tgtDBName.ToUpper().Equals (DBName.ToUpper()))
                            {
                                cbDatabases.SetItemChecked (j, true);
                                cbDatabases.SetItemCheckState (j, CheckState.Checked);
                            }
                            //else
                            //{
                            //    cbDatabases.SetItemChecked (j, false);
                            //    cbDatabases.SetItemCheckState (j, CheckState.Unchecked);
                            //}
                        }
                    }
                }
                catch
                {
                    i = i - 1;
                    SB.Text = "Processed " + i.ToString () + " servers and databases.";
                }
                
            }
        }

        private void btnShowSelected_Click (object sender, EventArgs e)
        {

        }

        private void btnDeselectStd_Click (object sender, EventArgs e)
        {
            int turnoff = 0;
            for (int i = 0; i < cbDatabases.Items.Count; i++)
            {
                turnoff = 0;
                string tname = cbDatabases.Items[i].ToString ();
                switch (tname.ToUpper())
                {
                    case "TEMPDB":
                        turnoff = 1;
                        break;
                    case "MSDB":
                        turnoff = 1;
                        break;
                    case "MODEL":
                        turnoff = 1;
                        break;
                    case "MASTER":
                        turnoff = 1;
                        break;
                    case "REPORTSERVER":
                        turnoff = 1;
                        break;
                    case "REPORTSERVERTEMPDB":
                        turnoff = 1;
                        break;
                    default:
                        turnoff = 0;
                        break;
                }
                if (turnoff.Equals(1))
                {
                    cbDatabases.SetItemChecked (i, false);
                    cbDatabases.SetItemCheckState (i, CheckState.Unchecked);
                }
            }
        }
    }
}