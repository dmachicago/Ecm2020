using System;
using System.Data;
using System.Windows.Forms;

namespace ToolBeltMgt
{
    public partial class frmJobs : Form
    {
        public frmJobs ()
        {
            InitializeComponent ();
        }

        private void frmJobs_Load (object sender, EventArgs e)
        {
            refreshJobGrid ();
        }

        private void refreshJobGrid ()
        {
            dgJobs.DataSource = DB.getJobs ();
        }

        private void btnRefresh_Click (object sender, EventArgs e)
        {
            refreshJobGrid ();

            DataTable dtSvrs = new DataTable ();
            DataTable dtJobs = new DataTable ();
            dtJobs = DB.getJobNames ();

            cbJobs.Items.Clear ();
            foreach (DataRow dr in dtJobs.Rows)
            {
                foreach (DataColumn col in dtJobs.Columns)
                    cbJobs.Items.Add (dr[col]);
            }

            dtSvrs = DB.getJobServers ();
            cbJobs.Items.Clear ();
            foreach (DataRow dr in dtJobs.Rows)
            {
                foreach (DataColumn col in dtJobs.Columns)
                    cbJobs.Items.Add (dr[col]);
            }
        }

        private void textBox1_TextChanged (object sender, EventArgs e)
        {
            bool b = DB.IsDigitsOnly (txtUnitVal.Text);
            if (!b)
            {
                SB.Text = "ERROR: the UNIT VALUE must be a positive integer.";
                MessageBox.Show ("ERROR: the UNIT VALUE must be a positive integer.");

                txtUnitVal.Text = "";
            }
        }

        private void setFormValues ()
        {
            try
            {
                string msg = String.Format ("Row: {0}, Column: {1}", dgJobs.CurrentCell.RowIndex, dgJobs.CurrentCell.ColumnIndex);

                int rowindex = dgJobs.CurrentCell.RowIndex;
                int colindex = dgJobs.CurrentCell.ColumnIndex;

                string JobName = dgJobs.Rows[rowindex].Cells["JobName"].Value.ToString ();
                string ScheduleUnit = dgJobs.Rows[rowindex].Cells["ScheduleUnit"].Value.ToString ();
                string ScheduleVal = dgJobs.Rows[rowindex].Cells["ScheduleVal"].Value.ToString ();
                string LastRunDate = dgJobs.Rows[rowindex].Cells["LastRunDate"].Value.ToString ();
                string NextRunDate = dgJobs.Rows[rowindex].Cells["NextRunDate"].Value.ToString ();
                string OncePerServer = dgJobs.Rows[rowindex].Cells["OncePerServer"].Value.ToString ();
                string enable = dgJobs.Rows[rowindex].Cells["enable"].Value.ToString ();
                string ExecOrder = dgJobs.Rows[rowindex].Cells["ExecutionOrder"].Value.ToString ();

                cbJobs.Text = JobName;
                cbUnit.Text = ScheduleUnit;
                txtUnitVal.Text = ScheduleVal;
                lblLastRunDate.Text = ScheduleUnit;
                lblNextRunDate.Text = NextRunDate;

                if (OncePerServer.ToUpper ().Equals ("Y"))
                    ckOncePerSvr.Checked = true;
                else
                    ckOncePerSvr.Checked = false;

                if (enable.ToUpper ().Equals ("Y"))
                    ckDisable.Checked = false;
                else
                    ckDisable.Checked = true;
                nbrExecOrder.Value = Convert.ToDecimal (ExecOrder);
            }
            catch (Exception ex)
            {
                SB.Text = ex.Message;
            }
        }

        private void dgJobs_CellContentClick (object sender, DataGridViewCellEventArgs e)
        {
            setFormValues ();
        }

        private void btnApply_Click (object sender, EventArgs e)
        {
            string JobName = "";
            string ScheduleUnit = "";
            string ScheduleValue = "";
            string enable = "";
            string OncePerServer = "";
            bool isOncePerServer = true;
            bool isEnable = true;
            string ExecOrd = "";
            int maxrows = dgJobs.Rows.Count;
            int i = 0;
            foreach (DataGridViewRow row in dgJobs.Rows)
            {
                if (i < maxrows-1)
                {
                    JobName = row.Cells["JobName"].Value.ToString ();
                    ScheduleUnit = row.Cells["ScheduleUnit"].Value.ToString ();
                    ScheduleValue = row.Cells["ScheduleVal"].Value.ToString ();
                    OncePerServer = row.Cells["OncePerServer"].Value.ToString ().ToUpper ();
                    enable = row.Cells["enable"].Value.ToString ().ToUpper ();
                    ExecOrd = row.Cells["ExecutionOrder"].Value.ToString ();

                    if (OncePerServer.ToUpper ().Equals ("Y"))
                        isOncePerServer = true;
                    else
                        isOncePerServer = false;

                    if (enable.Equals ("Y"))
                        isEnable = true;
                    else
                        isEnable = false;

                    int rc = DB.applyJobs (JobName, ScheduleUnit, ScheduleValue, isOncePerServer, isEnable, Convert.ToDecimal (ExecOrd));

                    if (rc.Equals (1))
                    {
                        SB.Text = "New job added.";
                        //rc = DB.updateActiveJobSchedule (SvrName, JobName);
                    }
                    else
                        SB.Text = "FAILED to insert job.";
                }
                i++;
            }
            btnRefresh_Click (null, null);
        }

        private void assignServersToolStripMenuItem_Click (object sender, EventArgs e)
        {
            frmAssignJobs m = new frmAssignJobs ();
            m.Show (this);
        }

        private void jobStepsToolStripMenuItem_Click (object sender, EventArgs e)
        {
            frmJobSteps m = new frmJobSteps ();
            m.Show (this);
        }

        private void btnDelete_Click (object sender, EventArgs e)
        {
            DialogResult dr = MessageBox.Show ("Are you sure ? This will remove this job from the system.",
                    "VERIFY", MessageBoxButtons.YesNo);
            switch (dr)
            {
                case DialogResult.Yes:
                    int rc = DB.deleteJob (cbJobs.Text);
                    if (rc.Equals (1))
                    {
                        SB.Text = "JOB Successfully deleted from system.";
                        btnRefresh_Click (null, null);
                    }
                    else
                        SB.Text = "JOB FAILED to delete from system.";
                    break;

                case DialogResult.No:
                    SB.Text = "Delete cancelled.";
                    break;
            }
        }

        private void cbJobs_SelectedIndexChanged (object sender, EventArgs e)
        {
            int i = 0;
            string JobName = cbJobs.Text;
            string s = "";
            DataTable dtJob = new DataTable ();
            dtJob = DB.getJobByName (JobName);
            foreach (DataRow dr in dtJob.Rows)
            {
                //JobName, ScheduleUnit, ScheduleVal, LastRunDate,NextRunDate,[enable]
                foreach (DataColumn col in dtJob.Columns)
                {
                    s = dr[col].ToString ();
                    switch (i)
                    {
                        case 0:
                            //jobname
                            break;

                        case 1:
                            cbUnit.Text = s;
                            break;

                        case 2:
                            txtUnitVal.Text = s;
                            break;

                        case 3:
                            lblLastRunDate.Text = s;
                            break;

                        case 4:
                            lblNextRunDate.Text = s;
                            break;

                        case 5:
                            if (Enabled.Equals ('Y'))
                                ckDisable.Checked = false;
                            else
                                ckDisable.Checked = true;
                            break;
                    }
                    i++;
                }
            }
        }

        private void dgJobs_SelectionChanged (object sender, EventArgs e)
        {
            setFormValues ();
        }
    }
}