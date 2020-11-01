using System;
using System.Windows.Forms;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{
    public partial class frmRetentionCode
    {
        public frmRetentionCode()
        {
            InitializeComponent();
            _dgRetention.Name = "dgRetention";
            _btnSave.Name = "btnSave";
            _btnDelete.Name = "btnDelete";
        }

        private clsDatabaseARCH DBARCH = new clsDatabaseARCH();
        private bool RC = false;

        /// <summary>
    /// Handles the Load event of the frmRetentionCode control.
    /// </summary>
    /// <param name="sender">The source of the event.</param>
    /// <param name="e">The <see cref="System.EventArgs" /> instance containing the event data.</param>
        private void frmRetentionCode_Load(object sender, EventArgs e)
        {
            GetRetentionCodes();
        }

        /// <summary>
    /// Handles the Click event of the btnSave control.
    /// </summary>
    /// <param name="sender">The source of the event.</param>
    /// <param name="e">The <see cref="System.EventArgs" /> instance containing the event data.</param>
        private void btnSave_Click(object sender, EventArgs e)
        {
            string RetentionCode = txtRetentionCode.Text;
            string RetentionDesc = txtDesc.Text;
            string ManagerID = txtManagerID.Text;
            int RetentionUnits = (int)nbrRetentionUnits.Value;
            int DaysWarning = (int)nbrDaysWarning.Value;
            string RetentionPeriod = cbRetentionPeriod.Text;
            string RetentionAction = cbRetentionAction.Text;
            string ResponseRequired = "";
            if (ckResponseRequired.Checked)
            {
                ResponseRequired = "Y";
            }
            else
            {
                ResponseRequired = "N";
            }

            bool B = DBARCH.Save_RetentionCode(modGlobals.gGateWayID, RetentionCode, RetentionDesc, RetentionUnits, RetentionAction, ManagerID, DaysWarning, ResponseRequired, RetentionPeriod, ref RC);
            if (B)
            {
                SB.Text = RetentionCode + " Saved.";
                GetRetentionCodes();
            }
            else
            {
                SB.Text = RetentionCode + " NOT Saved.";
            }
        }

        /// <summary>
    /// Gets the retention codes.
    /// </summary>
        public void GetRetentionCodes()
        {
            bool RC = true;
            var RssBindingSource = new BindingSource();
            RssBindingSource.DataSource = DBARCH.GET_RetentionCodes(modGlobals.gGateWayID, RC);
            dgRetention.DataSource = RssBindingSource;
        }


        /// <summary>
    /// Handles the SelectionChanged event of the dgRetention control.
    /// </summary>
    /// <param name="sender">The source of the event.</param>
    /// <param name="e">The <see cref="System.EventArgs" /> instance containing the event data.</param>
        private void dgRetention_SelectionChanged(object sender, EventArgs e)
        {
            int I = dgRetention.SelectedRows.Count;
            if (I == 1)
            {
                var DR = dgRetention.SelectedRows[0];
                txtRetentionCode.Text = DR.Cells["RetentionCode"].Value.ToString();
                txtDesc.Text = DR.Cells["RetentionDesc"].Value.ToString();
                nbrRetentionUnits.Value = Conversions.ToDecimal(DR.Cells["RetentionUnits"].Value.ToString());
                if (DR.Cells["DaysWarning"].Value is null)
                {
                    nbrDaysWarning.Value = 14m;
                }
                else
                {
                    try
                    {
                        nbrDaysWarning.Value = Conversions.ToDecimal(DR.Cells["DaysWarning"].Value);
                    }
                    catch (Exception ex)
                    {
                        nbrDaysWarning.Value = 15m;
                    }
                }

                txtManagerID.Text = DR.Cells["ManagerID"].Value.ToString();
                cbRetentionPeriod.Text = DR.Cells["RetentionPeriod"].Value.ToString();
                cbRetentionAction.Text = DR.Cells["RetentionAction"].Value.ToString();
                string ResponseRequired = DR.Cells["ResponseRequired"].Value.ToString();
                if (ckResponseRequired.ToString().Equals("Y"))
                {
                    ckResponseRequired.Checked = true;
                }
                else
                {
                    ckResponseRequired.Checked = false;
                }
            }
            else
            {
                SB.Text = "Only one row can be selected.";
            }
        }

        /// <summary>
    /// Handles the Click event of the btnDelete control.
    /// </summary>
    /// <param name="sender">The source of the event.</param>
    /// <param name="e">The <see cref="System.EventArgs" /> instance containing the event data.</param>
        private void btnDelete_Click(object sender, EventArgs e)
        {
            int I = dgRetention.SelectedRows.Count;
            if (I != 1)
            {
                MessageBox.Show("One and only one row must be selected.");
                return;
            }

            string RetentionCode = txtRetentionCode.Text;
            string MySql = "delete from Retention where RetentionCode = '" + RetentionCode + "' ";
            RC = DBARCH.ExecuteSqlNewConn(90000, MySql);
            if (RC)
            {
                GetRetentionCodes();
            }
            else
            {
                MessageBox.Show("A11 Failed to DELETE Retention Code : " + RetentionCode);
            }
        }
    }
}