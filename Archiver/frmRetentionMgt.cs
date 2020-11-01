using System;
using System.Collections;
using System.Data;
using global::System.Data.SqlClient;
using System.Windows.Forms;
using Microsoft.VisualBasic;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{
    public partial class frmRetentionMgt
    {
        public frmRetentionMgt()
        {
            InitializeComponent();
            _rbEmails.Name = "rbEmails";
            _rbContent.Name = "rbContent";
            _btnExecuteExpire.Name = "btnExecuteExpire";
            _btnSelectExpired.Name = "btnSelectExpired";
            _btnExecuteAge.Name = "btnExecuteAge";
            _btnDelete.Name = "btnDelete";
            _btnMove.Name = "btnMove";
            _btnExtend.Name = "btnExtend";
            _btnRecall.Name = "btnRecall";
        }
        // Dim SHIST As New clsSEARCHHISTORY
        private clsDatabaseARCH DBARCH = new clsDatabaseARCH();
        private clsDma DMA = new clsDma();
        private clsDataGrid DG = new clsDataGrid();
        private bool bHelpLoaded = false;
        private bool FormLoaded = false;
        private clsLogging LOG = new clsLogging();

        private void ToolTip1_Popup(object sender, PopupEventArgs e)
        {
        }

        private void frmRetentionMgt_Load(object sender, EventArgs e)
        {
            modResizeForm.GetLocation(this);
            if (modGlobals.HelpOn)
            {
                Form argfrm = this;
                var argTT = TT;
                DBARCH.getFormTooltips(ref argfrm, ref argTT, true);
                TT = argTT;
                TT.Active = true;
                bHelpLoaded = true;
            }
            else
            {
                TT.Active = false;
            }

            Timer1.Enabled = true;
            Timer1.Interval = 5000;
            // Dim bGetScreenObjects As Boolean = True
            // If bGetScreenObjects Then DMA.getFormWidgets(Me)

            btnRecall.Enabled = false;
            btnRecall.Text = "Load Marked EMAIL Retention Items";
        }

        public void PopulateGrid(string MySql)
        {
            var StartTime = DateAndTime.Now;

            // System.Windows.Forms.DataGridViewCellEventArgs
            try
            {
                SB.Text = "";
                var BS = new BindingSource();
                string CS = DBARCH.setConnStr();
                var sqlcn = new SqlConnection(CS);
                var sadapt = new SqlDataAdapter(MySql, sqlcn);
                var ds = new DataSet();

                // Me.DsDocumentSearch.Reset()

                if (sqlcn.State == ConnectionState.Closed)
                {
                    sqlcn.Open();
                }

                sadapt.Fill(ds, "DataSource");
                SB.Text = "Returned Items: " + ds.Tables["DataSource"].Rows.Count.ToString();
                dgItems.DataSource = null;
                dgItems.DataSource = ds.Tables["DataSource"];
            }

            // SHIST.setCalledfrom(Me.Name)
            // SHIST.setEndtime(Now.ToString)
            // SHIST.setReturnedrows(Me.dgItems.RowCount)
            // SHIST.setTypesearch("PopulateGrid")
            // SHIST.setStarttime(StartTime.ToString)
            // SHIST.setSearchdate(Now.ToString)
            // SHIST.setSearchsql(MySql )
            // SHIST.setUserid(gCurrUserGuidID)
            // Dim b As Boolean = SHIST.Insert
            // If Not b Then
            // Debug.Print("Error 1943.23b - Failed to save history of search.")
            // End If

            catch (Exception ex)
            {
                Interaction.MsgBox("Search Error 165.4x: " + ex.Message);
                LOG.WriteToSqlLog("Search Error 165.4: " + ex.Message + Constants.vbCrLf + MySql);
            }
        }

        private void btnExecuteExpire_Click(object sender, EventArgs e)
        {
            string S = "";
            int UnitQty = (int)Conversion.Val(txtExpireUnit.Text);
            string Unit = cbExpireUnits.Text;
            var CurrDate = DateAndTime.Now;
            DateTime FutureDate;
            if (rbEmails.Checked == true)
            {
                S = S + " SELECT ";
                S = S + " [SentOn] " + Constants.vbCrLf;
                S = S + " ,[ShortSubj]" + Constants.vbCrLf;
                S = S + " ,[SenderEmailAddress]" + Constants.vbCrLf;
                S = S + " ,[SenderName]" + Constants.vbCrLf;
                S = S + " ,[SentTO]" + Constants.vbCrLf;
                S = S + " ,[Body] " + Constants.vbCrLf;
                S = S + " ,[CC] " + Constants.vbCrLf;
                S = S + " ,[Bcc] " + Constants.vbCrLf;
                S = S + " ,[CreationTime]" + Constants.vbCrLf;
                S = S + " ,[AllRecipients]" + Constants.vbCrLf;
                S = S + " ,[ReceivedByName]" + Constants.vbCrLf;
                S = S + " ,[ReceivedTime] " + Constants.vbCrLf;
                S = S + " ,[MsgSize]" + Constants.vbCrLf;
                S = S + " ,[SUBJECT]" + Constants.vbCrLf;
                S = S + " ,[OriginalFolder] " + Constants.vbCrLf;
                S = S + " ,[EmailGuid], RetentionExpirationDate, isPublic, UserID " + Constants.vbCrLf;
                S = S + " FROM EMAIL " + Constants.vbCrLf;
            }
            else
            {
                S = "";
                S = S + "Select " + Constants.vbCrLf;
                S += Constants.vbTab + "[SourceName] 	" + Constants.vbCrLf;
                S += Constants.vbTab + ",[CreateDate] " + Constants.vbCrLf;
                S += Constants.vbTab + ",[VersionNbr] 	" + Constants.vbCrLf;
                S += Constants.vbTab + ",[LastAccessDate] " + Constants.vbCrLf;
                S += Constants.vbTab + ",[FileLength] " + Constants.vbCrLf;
                S += Constants.vbTab + ",[LastWriteTime] " + Constants.vbCrLf;
                S += Constants.vbTab + ",[OriginalFileType] 		" + Constants.vbCrLf;
                S += Constants.vbTab + ",[isPublic] " + Constants.vbCrLf;
                S += Constants.vbTab + ",[FQN] " + Constants.vbCrLf;
                S += Constants.vbTab + ",[SourceGuid] " + Constants.vbCrLf;
                S += Constants.vbTab + ",[DataSourceOwnerUserID], FileDirectory, RetentionExpirationDate, isMaster " + Constants.vbCrLf;
                S += "FROM DataSource " + Constants.vbCrLf;
            }

            if (Unit.Equals("Months"))
            {
                FutureDate = CurrDate.AddMonths(UnitQty);
            }
            else if (Unit.Equals("Days"))
            {
                FutureDate = CurrDate.AddDays(UnitQty);
            }
            else if (Unit.Equals("Years"))
            {
                FutureDate = CurrDate.AddYears(UnitQty);
            }
            else
            {
                return;
            }

            string WC = " where RetentionExpirationDate <= '" + Conversions.ToString(Conversions.ToDate(FutureDate.ToString())) + "'";
            S = S + WC;
            PopulateGrid(S);
        }

        private void btnExecuteAge_Click(object sender, EventArgs e)
        {
            string S = "";
            int UnitQty = (int)Conversion.Val(txtExpireUnit.Text);
            string Unit = cbExpireUnits.Text;
            var CurrDate = DateAndTime.Now;
            DateTime PastDate;
            if (rbEmails.Checked == true)
            {
                S = S + " SELECT ";
                S = S + " [SentOn] " + Constants.vbCrLf;
                S = S + " ,[ShortSubj]" + Constants.vbCrLf;
                S = S + " ,[SenderEmailAddress]" + Constants.vbCrLf;
                S = S + " ,[SenderName]" + Constants.vbCrLf;
                S = S + " ,[SentTO]" + Constants.vbCrLf;
                S = S + " ,[Body] " + Constants.vbCrLf;
                S = S + " ,[CC] " + Constants.vbCrLf;
                S = S + " ,[Bcc] " + Constants.vbCrLf;
                S = S + " ,[CreationTime]" + Constants.vbCrLf;
                S = S + " ,[AllRecipients]" + Constants.vbCrLf;
                S = S + " ,[ReceivedByName]" + Constants.vbCrLf;
                S = S + " ,[ReceivedTime] " + Constants.vbCrLf;
                S = S + " ,[MsgSize]" + Constants.vbCrLf;
                S = S + " ,[SUBJECT]" + Constants.vbCrLf;
                S = S + " ,[OriginalFolder] " + Constants.vbCrLf;
                S = S + " ,[EmailGuid], RetentionExpirationDate, isPublic, UserID " + Constants.vbCrLf;
                S = S + " FROM EMAIL " + Constants.vbCrLf;
            }
            else
            {
                S = "";
                S = S + "Select " + Constants.vbCrLf;
                S += Constants.vbTab + "[SourceName] 	" + Constants.vbCrLf;
                S += Constants.vbTab + ",[CreateDate] " + Constants.vbCrLf;
                S += Constants.vbTab + ",[VersionNbr] 	" + Constants.vbCrLf;
                S += Constants.vbTab + ",[LastAccessDate] " + Constants.vbCrLf;
                S += Constants.vbTab + ",[FileLength] " + Constants.vbCrLf;
                S += Constants.vbTab + ",[LastWriteTime] " + Constants.vbCrLf;
                S += Constants.vbTab + ",[OriginalFileType] 		" + Constants.vbCrLf;
                S += Constants.vbTab + ",[isPublic] " + Constants.vbCrLf;
                S += Constants.vbTab + ",[FQN] " + Constants.vbCrLf;
                S += Constants.vbTab + ",[SourceGuid] " + Constants.vbCrLf;
                S += Constants.vbTab + ",[DataSourceOwnerUserID], FileDirectory, RetentionExpirationDate, isMaster " + Constants.vbCrLf;
                S += "FROM DataSource " + Constants.vbCrLf;
            }

            if (Unit.Equals("Months"))
            {
                int TotalDays = 30 * UnitQty;
                var Days = new TimeSpan(TotalDays, 0, 0, 0);
                PastDate = CurrDate.Subtract(Days);
            }
            else if (Unit.Equals("Days"))
            {
                int TotalDays = 1 * UnitQty;
                var Days = new TimeSpan(TotalDays, 0, 0, 0);
                PastDate = CurrDate.Subtract(Days);
            }
            else if (Unit.Equals("Years"))
            {
                int TotalDays = (int)(365.25d * UnitQty);
                var Days = new TimeSpan(TotalDays, 0, 0, 0);
                PastDate = CurrDate.Subtract(Days);
            }
            else
            {
                return;
            }

            string WC = " where CreationDate <= '" + Conversions.ToString(Conversions.ToDate(PastDate.ToString())) + "'";
            S = S + WC;
            PopulateGrid(S);
        }

        private void btnSelectExpired_Click(object sender, EventArgs e)
        {
            string S = "";
            int UnitQty = (int)Conversion.Val(txtExpireUnit.Text);
            string Unit = cbExpireUnits.Text;
            var CurrDate = DateAndTime.Now;
            var FutureDate = DateAndTime.Now;
            if (rbEmails.Checked == true)
            {
                S = S + " SELECT ";
                S = S + " [SentOn] " + Constants.vbCrLf;
                S = S + " ,[ShortSubj]" + Constants.vbCrLf;
                S = S + " ,[SenderEmailAddress]" + Constants.vbCrLf;
                S = S + " ,[SenderName]" + Constants.vbCrLf;
                S = S + " ,[SentTO]" + Constants.vbCrLf;
                S = S + " ,[Body] " + Constants.vbCrLf;
                S = S + " ,[CC] " + Constants.vbCrLf;
                S = S + " ,[Bcc] " + Constants.vbCrLf;
                S = S + " ,[CreationTime]" + Constants.vbCrLf;
                S = S + " ,[AllRecipients]" + Constants.vbCrLf;
                S = S + " ,[ReceivedByName]" + Constants.vbCrLf;
                S = S + " ,[ReceivedTime] " + Constants.vbCrLf;
                S = S + " ,[MsgSize]" + Constants.vbCrLf;
                S = S + " ,[SUBJECT]" + Constants.vbCrLf;
                S = S + " ,[OriginalFolder] " + Constants.vbCrLf;
                S = S + " ,[EmailGuid], RetentionExpirationDate, isPublic, UserID " + Constants.vbCrLf;
                S = S + " FROM EMAIL " + Constants.vbCrLf;
            }
            else
            {
                S = "";
                S = S + "Select " + Constants.vbCrLf;
                S += Constants.vbTab + "[SourceName] 	" + Constants.vbCrLf;
                S += Constants.vbTab + ",[CreateDate] " + Constants.vbCrLf;
                S += Constants.vbTab + ",[VersionNbr] 	" + Constants.vbCrLf;
                S += Constants.vbTab + ",[LastAccessDate] " + Constants.vbCrLf;
                S += Constants.vbTab + ",[FileLength] " + Constants.vbCrLf;
                S += Constants.vbTab + ",[LastWriteTime] " + Constants.vbCrLf;
                S += Constants.vbTab + ",[OriginalFileType] 		" + Constants.vbCrLf;
                S += Constants.vbTab + ",[isPublic] " + Constants.vbCrLf;
                S += Constants.vbTab + ",[FQN] " + Constants.vbCrLf;
                S += Constants.vbTab + ",[SourceGuid] " + Constants.vbCrLf;
                S += Constants.vbTab + ",[DataSourceOwnerUserID], FileDirectory, RetentionExpirationDate, isMaster " + Constants.vbCrLf;
                S += "FROM DataSource " + Constants.vbCrLf;
            }

            string WC = " where RetentionExpirationDate <= '" + Conversions.ToString(Conversions.ToDate(DateAndTime.Now.ToString())) + "'";
            S = S + WC;
            PopulateGrid(S);
        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            string msg = "This will delete the selected items, are you sure, really sure?";
            var dlgRes = MessageBox.Show(msg, "UNDOABLE DELETE of Content", MessageBoxButtons.YesNo);
            if (dlgRes == DialogResult.No)
            {
                return;
            }

            PB.Value = 0;
            PB.Maximum = dgItems.SelectedRows.Count + 1;
            int II = 0;
            int SuccessfulDelete = 0;
            int FailedDelete = 0;
            var uidList = new ArrayList();
            string CurrGuid = "";
            string S = "";
            bool B = false;
            foreach (DataRow DR in dgItems.SelectedRows)
            {
                II += 1;
                PB.Value = II;
                PB.Refresh();
                Application.DoEvents();
                if (rbEmails.Checked == true)
                {
                    CurrGuid = DR["EmailGuid"].ToString();
                    uidList.Add(CurrGuid);
                }
                else
                {
                    CurrGuid = DR["SourceGuid"].ToString();
                    uidList.Add(CurrGuid);
                }
            }

            for (int i = 0, loopTo = uidList.Count - 1; i <= loopTo; i++)
            {
                if (rbEmails.Checked == true)
                {
                    CurrGuid = uidList[i].ToString();
                    S = "delete from emailattachment where EmailGuid = '" + CurrGuid + "'";
                    B = DBARCH.ExecuteSqlNewConn(S, false);
                    S = "delete from Recipients where EmailGuid = '" + CurrGuid + "'";
                    B = DBARCH.ExecuteSqlNewConn(S, false);
                    S = "delete from email  where EmailGuid = '" + CurrGuid + "'";
                    B = DBARCH.ExecuteSqlNewConn(S, false);
                    if (B)
                    {
                        SuccessfulDelete += 1;
                    }
                    else
                    {
                        FailedDelete += 1;
                    }
                }
                else
                {
                    CurrGuid = uidList[i].ToString();
                    S = "DELETE from SourceAttribute where SourceGuid = '" + CurrGuid + "'";
                    B = DBARCH.ExecuteSqlNewConn(S, false);
                    S = "DELETE from DataSource where SourceGuid = '" + CurrGuid + "'";
                    B = DBARCH.ExecuteSqlNewConn(S, false);
                    if (B)
                    {
                        SuccessfulDelete += 1;
                    }
                    else
                    {
                        FailedDelete += 1;
                    }
                }
            }

            PB.Value = 0;
            SB.Text = "Deleted = " + SuccessfulDelete.ToString() + " - A12 Failed to delete = " + FailedDelete.ToString();
        }

        private void btnMove_Click(object sender, EventArgs e)
        {
            Interaction.MsgBox("This item is in a future release...");
        }

        private void btnExtend_Click(object sender, EventArgs e)
        {
            int SuccessfulDelete = 0;
            int FailedDelete = 0;
            var uidList = new ArrayList();
            string CurrGuid = "";
            string S = "";
            bool B = false;
            DateTime NewDate = Conversions.ToDate(dtExtendDate.Value.ToLongDateString());
            int iSelected = dgItems.SelectedRows.Count;
            if (iSelected == 0)
            {
                Interaction.MsgBox("One or more items must be selected to extend, returning.");
                return;
            }

            foreach (DataGridViewRow DR in dgItems.SelectedRows)
            {
                if (rbEmails.Checked == true)
                {
                    CurrGuid = DR.Cells["EmailGuid"].Value.ToString();
                    uidList.Add(CurrGuid);
                }
                else
                {
                    CurrGuid = DR.Cells["SourceGuid"].Value.ToString();
                    uidList.Add(CurrGuid);
                }
            }

            for (int i = 0, loopTo = uidList.Count - 1; i <= loopTo; i++)
            {
                if (rbEmails.Checked == true)
                {
                    CurrGuid = uidList[i].ToString();
                    S = "update email set  RetentionExpirationDate = '" + NewDate.ToString() + "' where EmailGuid = '" + CurrGuid + "'";
                    B = DBARCH.ExecuteSqlNewConn(S, false);
                    if (B)
                    {
                        SuccessfulDelete += 1;
                    }
                    else
                    {
                        FailedDelete += 1;
                    }
                }
                else
                {
                    CurrGuid = uidList[i].ToString();
                    S = "update DataSource set  RetentionExpirationDate = '" + NewDate.ToString() + "' where SourceGuid = '" + CurrGuid + "'";
                    B = DBARCH.ExecuteSqlNewConn(S, false);
                    if (B)
                    {
                        SuccessfulDelete += 1;
                    }
                    else
                    {
                        FailedDelete += 1;
                    }
                }
            }

            SB.Text = "Updated = " + SuccessfulDelete.ToString() + " - Failed to update = " + FailedDelete.ToString();
        }

        private void Timer1_Tick(object sender, EventArgs e)
        {
            // If HelpOn Then
            // If bHelpLoaded Then
            // TT.Active = True
            // Else
            // DBARCH.getFormTooltips(Me, TT, True)
            // TT.Active = True
            // bHelpLoaded = True
            // End If
            // Else
            // TT.Active = False
            // End If
            // System.Windows.Forms.Application.DoEvents()
        }

        private void btnRecall_Click(object sender, EventArgs e)
        {
            string S = "";
            int UnitQty = (int)Conversion.Val(txtExpireUnit.Text);
            string Unit = cbExpireUnits.Text;
            var CurrDate = DateAndTime.Now;
            // Dim PastDate As Date

            string WC = "";
            if (rbEmails.Checked == true)
            {
                S = S + " SELECT ";
                S = S + " [SentOn] " + Constants.vbCrLf;
                S = S + " ,[ShortSubj]" + Constants.vbCrLf;
                S = S + " ,[SenderEmailAddress]" + Constants.vbCrLf;
                S = S + " ,[SenderName]" + Constants.vbCrLf;
                S = S + " ,[SentTO]" + Constants.vbCrLf;
                S = S + " ,[Body] " + Constants.vbCrLf;
                S = S + " ,[CC] " + Constants.vbCrLf;
                S = S + " ,[Bcc] " + Constants.vbCrLf;
                S = S + " ,[CreationTime]" + Constants.vbCrLf;
                S = S + " ,[AllRecipients]" + Constants.vbCrLf;
                S = S + " ,[ReceivedByName]" + Constants.vbCrLf;
                S = S + " ,[ReceivedTime] " + Constants.vbCrLf;
                S = S + " ,[MsgSize]" + Constants.vbCrLf;
                S = S + " ,[SUBJECT]" + Constants.vbCrLf;
                S = S + " ,[OriginalFolder] " + Constants.vbCrLf;
                S = S + " ,[EmailGuid], RetentionExpirationDate, isPublic, UserID " + Constants.vbCrLf;
                S = S + " FROM EMAIL " + Constants.vbCrLf;
                WC = " where EmailGuid in (select [ContentGuid] from [RetentionTemp] where [TypeContent] = 'EMAIL' and [UserID] = '" + modGlobals.gCurrUserGuidID + "')";
            }
            else
            {
                S = "";
                S = S + "Select " + Constants.vbCrLf;
                S += Constants.vbTab + "[SourceName] 	" + Constants.vbCrLf;
                S += Constants.vbTab + ",[CreateDate] " + Constants.vbCrLf;
                S += Constants.vbTab + ",[VersionNbr] 	" + Constants.vbCrLf;
                S += Constants.vbTab + ",[LastAccessDate] " + Constants.vbCrLf;
                S += Constants.vbTab + ",[FileLength] " + Constants.vbCrLf;
                S += Constants.vbTab + ",[LastWriteTime] " + Constants.vbCrLf;
                S += Constants.vbTab + ",[OriginalFileType] 		" + Constants.vbCrLf;
                S += Constants.vbTab + ",[isPublic] " + Constants.vbCrLf;
                S += Constants.vbTab + ",[FQN] " + Constants.vbCrLf;
                S += Constants.vbTab + ",[SourceGuid] " + Constants.vbCrLf;
                S += Constants.vbTab + ",[DataSourceOwnerUserID], FileDirectory, RetentionExpirationDate, isMaster " + Constants.vbCrLf;
                S += "FROM DataSource " + Constants.vbCrLf;
                WC = " where SourceGuid in (select [ContentGuid] from [RetentionTemp] where [TypeContent] = 'CONTENT' and [UserID] = '" + modGlobals.gCurrUserGuidID + "')";
            }

            S = S + WC;
            PopulateGrid(S);
        }

        private void rbContent_CheckedChanged(object sender, EventArgs e)
        {
            if (rbContent.Checked)
            {
                int iCnt = DBARCH.RetentionTempCountType("CONTENT", modGlobals.gCurrUserGuidID);
                if (iCnt > 0)
                {
                    btnRecall.Enabled = true;
                    // btnRecall.Visible = True
                    btnRecall.Text = "Load Marked CONTENT Retention Items";
                }
                else
                {
                    btnRecall.Enabled = false;
                    // btnRecall.Visible = True
                    btnRecall.Text = "Load Marked CONTENT Retention Items";
                }
            }
        }

        private void rbEmails_CheckedChanged(object sender, EventArgs e)
        {
            if (rbEmails.Checked)
            {
                int iCnt = DBARCH.RetentionTempCountType("EMAIL", modGlobals.gCurrUserGuidID);
                if (iCnt > 0)
                {
                    btnRecall.Enabled = true;
                    // btnRecall.Visible = True
                    btnRecall.Text = "Load Marked EMAIL Retention Items";
                }
                else
                {
                    btnRecall.Enabled = false;
                    // btnRecall.Visible = True
                    btnRecall.Text = "Load Marked EMAIL Retention Items";
                }
            }
        }

        private void frmRetentionMgt_Resize(object sender, EventArgs e)
        {
            if (FormLoaded == false)
                return;
            Form argfrm = this;
            modResizeForm.ResizeControls(ref argfrm);
        }
    }
}