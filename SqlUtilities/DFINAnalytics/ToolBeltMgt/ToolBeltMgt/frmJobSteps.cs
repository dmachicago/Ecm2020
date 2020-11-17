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
    public partial class frmJobSteps : Form
    {

        bool ChangesAreBeingMade = false;
        List<int> ChangedItems = new List<int>();
        public frmJobSteps ()
        {
            InitializeComponent ();
        }

        private void frmJobSteps_Load (object sender, EventArgs e)
        {
            DataTable dtJobs = new DataTable ();
            dtJobs = DB.getJobNames ();

            lbJobs.Items.Clear ();
            foreach (DataRow dr in dtJobs.Rows)
            {
                foreach (DataColumn col in dtJobs.Columns)
                    lbJobs.Items.Add (dr[col]);
            }
        }

        private void lbJobs_SelectedIndexChanged (object sender, EventArgs e)
        {
            
            ChangedItems.Clear ();
            ChangesAreBeingMade = false;
            string JobName = lbJobs.Text;
            
            DataTable dtJobSteps = new DataTable ();
            dtJobSteps = DB.getJobSteps (JobName);

            //dgJobSteps.Rows.Clear ();
            dgJobSteps.DataSource = dtJobSteps;
            lockStepName ();
        }

        private void Remove_Click (object sender, EventArgs e)
        {
            string JobName = lbJobs.Text;
            string StepName = getStepName ();
            int rc = DB.deleteJobStep (JobName, StepName);
            if (rc.Equals(1)) {
            SB.Text = "Step: " + StepName + " deleted.";
            }
            else 
            SB.Text = "Step: " + StepName + " FAILED TO DELETE.";
            lbJobs_SelectedIndexChanged (null, null);
        }

        private void btnApply_Click (object sender, EventArgs e)
        {
            SB.Text = "";
            bool ErrorsDetected = false;
            for (int i = 0; i < ChangedItems.Count; i++)
            {
                int rowidx = ChangedItems[i];
                string JobName = lbJobs.Text;
                string StepName = dgJobSteps.Rows[rowidx].Cells["StepName"].Value.ToString ();
                string ExecutionOrder = dgJobSteps.Rows[rowidx].Cells["ExecutionOrder"].Value.ToString ();
                string StepSQL = dgJobSteps.Rows[rowidx].Cells["StepSQL"].Value.ToString ();
                string disabled = dgJobSteps.Rows[rowidx].Cells["disabled"].Value.ToString ();
                string RunIdReq = dgJobSteps.Rows[rowidx].Cells["RunIdReq"].Value.ToString ();
                string AzureOK = dgJobSteps.Rows[rowidx].Cells["AzureOK"].Value.ToString ();

                int rc = DB.applyJobStep (JobName, StepName, StepSQL, disabled.ToUpper(), AzureOK.ToUpper (), RunIdReq.ToUpper (), ExecutionOrder);

                if (rc.Equals (1))
                {
                    SB.Text += "Step: " + StepName + " Added to Job : " + lbJobs.Text;
                }
                else
                {
                    SB.Text += "ERROR Step: " + StepName + " FAILED TO add to Job : " + lbJobs.Text;
                    ErrorsDetected = true;
                }
            }
            if (ErrorsDetected.Equals(false)) {
                                lbJobs_SelectedIndexChanged (null, null);
                ChangedItems.Clear ();
                ChangesAreBeingMade = false;
            }
            else
                MessageBox.Show ("ERRORS detected, please review your updates/changes.");
        }

        private void btnInsert_Click (object sender, EventArgs e)
        {
            string ExecutionOrder = nbrExecOrder.Value.ToString ();
            string StepName = txtNewStep.Text;
            string Disable = "";
            string AzureOK = "";
            string RunIdReq = "";

            if (txtNewStep.Text.Trim().Length.Equals(0)) {
                MessageBox.Show ("An 'Insert' cannot be performed without a NEW step name being supplied, returning...");
                return;
            }

            if (ckDisable.CheckState.Equals (CheckState.Checked)){
                Disable = "Y";
            }
            if (ckAzure.CheckState.Equals (CheckState.Checked))
            {
                AzureOK = "Y";
            }
            if (ckRunID.CheckState.Equals (CheckState.Checked))
            {
                RunIdReq = "Y";
            }
            
            int rc = DB.applyJobStep (lbJobs.Text, txtNewStep.Text, tbCmd.Text, Disable, AzureOK, RunIdReq, ExecutionOrder);

            if (rc.Equals (1))
            {
                SB.Text = "Step: " + StepName + " Added to Job : " + lbJobs.Text;
                lbJobs_SelectedIndexChanged (null, null);
                txtNewStep.Text = "";
                tbCmd.Text = "";
            }
            else
                SB.Text = "ERROR Step: " + StepName + " FAILED TO add to Job : " + lbJobs.Text;

            
        }

        private string getExecutionOrder ()
        {
            int rowindex = dgJobSteps.CurrentCell.RowIndex;
            int columnindex = dgJobSteps.CurrentCell.ColumnIndex;
            string ExecutionOrder = "";
            ExecutionOrder = dgJobSteps.Rows[rowindex].Cells["ExecutionOrder"].Value.ToString ();
            return ExecutionOrder;
        }
        private string getStepName() {
            int rowindex = dgJobSteps.CurrentCell.RowIndex;
            int columnindex = dgJobSteps.CurrentCell.ColumnIndex;
            string StepName = "";
            StepName = dgJobSteps.Rows[rowindex].Cells["StepName"].Value.ToString ();
            return StepName;
        }
        private string getStepSql ()
        {
            int rowindex = dgJobSteps.CurrentCell.RowIndex;
            int columnindex = dgJobSteps.CurrentCell.ColumnIndex;
            string StepName = "";
            StepName = dgJobSteps.Rows[rowindex].Cells["StepSql"].Value.ToString ();
            return StepName;
        }
        private string getDisabled ()
        {
            int rowindex = dgJobSteps.CurrentCell.RowIndex;
            int columnindex = dgJobSteps.CurrentCell.ColumnIndex;
            string StepName = "";
            StepName = dgJobSteps.Rows[rowindex].Cells["disabled"].Value.ToString ();
            return StepName;
        }
        private string getRunIdReq ()
        {
            int rowindex = dgJobSteps.CurrentCell.RowIndex;
            int columnindex = dgJobSteps.CurrentCell.ColumnIndex;
            string StepName = "";
            StepName = dgJobSteps.Rows[rowindex].Cells["RunIdReq"].Value.ToString ();
            return StepName;
        }
        private string getAzureOK ()
        {
            int rowindex = dgJobSteps.CurrentCell.RowIndex;
            int columnindex = dgJobSteps.CurrentCell.ColumnIndex;
            string StepName = "";
            StepName = dgJobSteps.Rows[rowindex].Cells["AzureOK"].Value.ToString ();
            return StepName;
        }

        private void getJobStepGridData() {

            int rowindex = dgJobSteps.CurrentCell.RowIndex;

            string JobName = lbJobs.Text;
            String StepName = getStepName ();
            String StepSQL = getStepSql ();
            String disabled = getDisabled ();
            String RunIdReq = getRunIdReq ();
            String AzureOK = getAzureOK ();
            string EO = getExecutionOrder ();
            if (EO.Length.Equals (0))
                EO = "1";
            decimal ExecutionOrder = decimal.Parse (EO);
            nbrExecOrder.Value = ExecutionOrder;
            
            
            tbCmd.Text = StepSQL;

            if (RunIdReq.ToUpper ().Equals ('Y'))
            {
                ckRunID.Checked = true;
            }
            else
                ckRunID.Checked = false;
            
            if (AzureOK.ToUpper ().Equals ("Y"))
            {
                ckAzure.CheckState = CheckState.Checked;
                ckAzure.Refresh ();
            }
            else
            {
                ckAzure.CheckState = CheckState.Unchecked;
            }
            
            if (disabled.ToUpper ().Equals ("Y"))
            {
                ckDisable.CheckState = CheckState.Checked;
            }
            else
                ckDisable.CheckState = CheckState.Unchecked;
        }

        private void dgJobSteps_SelectionChanged (object sender, EventArgs e)
        {
            getJobStepGridData ();
        }

        private void dgJobSteps_CellContentClick (object sender, DataGridViewCellEventArgs e)
        {
            getJobStepGridData ();
            
        }

        private void dgJobSteps_CellValueChanged (object sender, DataGridViewCellEventArgs e)
        {
            ChangesAreBeingMade = true;
            int rowindex = dgJobSteps.CurrentCell.RowIndex;
            if (!ChangedItems.Contains (rowindex))
            {
                ChangedItems.Add (rowindex);
            }
        }

        private void ckDisable_CheckedChanged (object sender, EventArgs e)
        {
            if (txtNewStep.Text.Trim ().Length.Equals (0) && ChangesAreBeingMade.Equals(false))
            {
                int i = dgJobSteps.CurrentCell.RowIndex;
                if (ckDisable.CheckState.Equals (CheckState.Checked)){
                    dgJobSteps.Rows[i].Cells["disabled"].Value = "N";
                }
                else {
                    dgJobSteps.Rows[i].Cells["disabled"].Value = "Y";
                }
            }
        }

        private void ckAzure_CheckedChanged (object sender, EventArgs e)
        {
            if (txtNewStep.Text.Trim ().Length.Equals (0) && ChangesAreBeingMade.Equals (false))
            {
                int i = dgJobSteps.CurrentCell.RowIndex;
                if (ckAzure.CheckState.Equals (CheckState.Checked))
                {
                    dgJobSteps.Rows[i].Cells["AzureOK"].Value = "Y";
                }
                else
                {
                    dgJobSteps.Rows[i].Cells["AzureOK"].Value = "N";
                }
            }
        }

        private void ckRunID_CheckedChanged (object sender, EventArgs e)
        {
            if (txtNewStep.Text.Trim ().Length.Equals (0) && ChangesAreBeingMade.Equals (false))
            {
                int i = dgJobSteps.CurrentCell.RowIndex;
                if (ckRunID.CheckState.Equals (CheckState.Checked))
                {
                    dgJobSteps.Rows[i].Cells["RunIdReq"].Value = "Y";
                }
                else
                {
                    dgJobSteps.Rows[i].Cells["RunIdReq"].Value = "N";
                }
            }
        }

        private void txtNewStep_TextChanged (object sender, EventArgs e)
        {
            if (txtNewStep.Text.Trim ().Length > 0)
            {
                dgJobSteps.Enabled = false;
                ChangesAreBeingMade = false;
            }
            else
            {
                dgJobSteps.Enabled = true;
            }
        }

        private void nbrExecOrder_ValueChanged (object sender, EventArgs e)
        {
            if (txtNewStep.Text.Trim ().Length.Equals (0))
            {
                string ExecutionOrder = nbrExecOrder.Value.ToString ();
                int i = dgJobSteps.CurrentCell.RowIndex;
                dgJobSteps.Rows[i].Cells["ExecutionOrder"].Value = ExecutionOrder;
                
            }
        }

        private void dgJobSteps_CellEndEdit (object sender, DataGridViewCellEventArgs e)
        {
            ChangesAreBeingMade = false;
        }

        private void lockStepName() {
            int n = Convert.ToInt32 (dgJobSteps.Rows.Count.ToString ());
            for (int i = 0; i < n; i++)
            {
                dgJobSteps.Rows[i].Cells[0].ReadOnly = true;
            }
        }

    }
}
