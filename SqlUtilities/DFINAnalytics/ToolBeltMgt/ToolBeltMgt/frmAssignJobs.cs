using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ToolBeltMgt
{
    public partial class frmAssignJobs : Form
    {
        public frmAssignJobs ()
        {
            InitializeComponent ();
        }

        private void btnAssign_Click (object sender, EventArgs e)
        {
            string SvrName = "";
            string JobName = "";
            for (int i = 0; i < cbServers.Items.Count; i++)
            {
                SvrName = cbServers.Items[i].ToString ();
                CheckState st = cbServers.GetItemCheckState (i);
                if (st == CheckState.Checked)
                {
                    for (int j = 0; j < cbJobs.Items.Count; j++)
                    {
                        CheckState st2 = cbJobs.GetItemCheckState (j);
                        JobName = cbJobs.Items[j].ToString ();
                        if (st2 == CheckState.Checked)
                            DB.updateActiveJobSchedule (SvrName, JobName);
                    }

                }
            }
        }

        private void btnRemove_Click (object sender, EventArgs e)
        {
            string SvrName = "";
            string JobName = "";
            foreach (DataGridViewRow row  in dgServerJobs.SelectedRows) {
                int rowindex = dgServerJobs.CurrentCell.RowIndex;
                int colindex = dgServerJobs.CurrentCell.ColumnIndex;
                SvrName = dgServerJobs.Rows[rowindex].Cells["SvrName"].Value.ToString ();
                JobName = dgServerJobs.Rows[rowindex].Cells["JobName"].Value.ToString ();
                DB.deleteActiveJobSchedule (SvrName, JobName);
            }
        }

        private void btnShowAll_Click (object sender, EventArgs e)
        {
            DataTable dtServers = new DataTable ();
            DataTable dtJobs = new DataTable ();

            dtServers = DB.getServers ();
            dtJobs = DB.getJobNames ();

            cbJobs.Items.Clear ();
            //dgServerJobs.Rows.Clear ();
            dgServerJobs.DataSource = null;
            cbServers.Items.Clear ();

            foreach (DataRow dr in dtServers.Rows)
            {
                foreach (DataColumn col in dtServers.Columns)
                    cbServers.Items.Add (dr[col]);
            }
            foreach (DataRow dr in dtJobs.Rows)
            {
                foreach (DataColumn col in dtJobs.Columns)
                    cbJobs.Items.Add (dr[col]);
            }
        }

        private void cbServers_SelectedIndexChanged (object sender, EventArgs e)
        {
            string SvrName = cbServers.SelectedItem.ToString ();
            //((ListBox)cbServerJobs).DataSource = DB.getServerJobs (SvrName);
            dgServerJobs.DataSource = DB.getServerJobs (SvrName);
        }

        private void cbJobs_SelectedIndexChanged (object sender, EventArgs e)
        {
            string JobName = cbJobs.SelectedItem.ToString ();
            dgServerJobs.DataSource = DB.getJobsAndTheirServer (JobName);
        }

        private void frmAssignJobs_Load (object sender, EventArgs e)
        {
            btnShowAll_Click (null, null);
        }

        private void btnSelectAll_Click (object sender, EventArgs e)
        {
            for (int i = 0; i < cbJobs.Items.Count; i++)
            {
                cbJobs.SetItemChecked (i, true);
                cbJobs.SetItemCheckState (i, CheckState.Checked);
            }
        }

        private void btnDeselect_Click (object sender, EventArgs e)
        {
            for (int i = 0; i < cbJobs.Items.Count; i++)
            {
                cbJobs.SetItemChecked (i, false);
                cbJobs.SetItemCheckState (i, CheckState.Unchecked);
            }
        }

        private void button2_Click (object sender, EventArgs e)
        {
            for (int i = 0; i < cbServers.Items.Count; i++)
            {
                cbServers.SetItemChecked (i, true);
                cbServers.SetItemCheckState (i, CheckState.Checked);
            }
        }

        private void button1_Click (object sender, EventArgs e)
        {
            for (int i = 0; i < cbServers.Items.Count; i++)
            {
                cbServers.SetItemChecked (i, false);
                cbServers.SetItemCheckState (i, CheckState.Unchecked);
            }
        }
    }
}
