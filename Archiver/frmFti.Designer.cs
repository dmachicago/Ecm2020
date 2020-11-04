using System;
using System.Diagnostics;
using System.Drawing;
using System.Runtime.CompilerServices;
using System.Windows.Forms;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{
    [DesignerGenerated()]
    public partial class frmFti : Form
    {

        // Form overrides dispose to clean up the component list.
        [DebuggerNonUserCode()]
        protected override void Dispose(bool disposing)
        {
            try
            {
                if (disposing && components is object)
                {
                    components.Dispose();
                }
            }
            finally
            {
                base.Dispose(disposing);
            }
        }

        // Required by the Windows Form Designer
        private System.ComponentModel.IContainer components;

        // NOTE: The following procedure is required by the Windows Form Designer
        // It can be modified using the Windows Form Designer.  
        // Do not modify it using the code editor.
        [DebuggerStepThrough()]
        private void InitializeComponent()
        {
            _lbFtiLogs = new ListBox();
            _lbFtiLogs.SelectedIndexChanged += new EventHandler(lbFtiLogs_SelectedIndexChanged);
            _btnScanGuids = new Button();
            _btnScanGuids.Click += new EventHandler(btnScanGuids_Click);
            txtSourceGuid = new TextBox();
            Label1 = new Label();
            btnCommonErrs = new Button();
            _btnSelectAll = new Button();
            _btnSelectAll.Click += new EventHandler(btnSelectAll_Click);
            _lbOutput = new ListBox();
            _lbOutput.SelectedIndexChanged += new EventHandler(lbOutput_SelectedIndexChanged);
            btnSave = new Button();
            _Button1 = new Button();
            _Button1.Click += new EventHandler(Button1_Click);
            SB = new TextBox();
            SBFqn = new TextBox();
            lblMsg = new Label();
            txtDetail = new TextBox();
            txtKeyGuid = new TextBox();
            txtDb = new TextBox();
            _btnFindItem = new Button();
            _btnFindItem.Click += new EventHandler(btnFindItem_Click);
            txtMaxNbr = new TextBox();
            Label2 = new Label();
            SuspendLayout();
            // 
            // lbFtiLogs
            // 
            _lbFtiLogs.Anchor = AnchorStyles.Top | AnchorStyles.Bottom | AnchorStyles.Left;
            _lbFtiLogs.FormattingEnabled = true;
            _lbFtiLogs.ItemHeight = 16;
            _lbFtiLogs.Location = new Point(12, 44);
            _lbFtiLogs.Name = "_lbFtiLogs";
            _lbFtiLogs.SelectionMode = SelectionMode.MultiExtended;
            _lbFtiLogs.Size = new Size(300, 308);
            _lbFtiLogs.TabIndex = 0;
            // 
            // btnScanGuids
            // 
            _btnScanGuids.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            _btnScanGuids.Location = new Point(12, 431);
            _btnScanGuids.Name = "_btnScanGuids";
            _btnScanGuids.Size = new Size(204, 32);
            _btnScanGuids.TabIndex = 1;
            _btnScanGuids.Text = "Search for Text";
            _btnScanGuids.UseVisualStyleBackColor = true;
            // 
            // txtSourceGuid
            // 
            txtSourceGuid.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            txtSourceGuid.Location = new Point(13, 403);
            txtSourceGuid.Name = "txtSourceGuid";
            txtSourceGuid.Size = new Size(299, 22);
            txtSourceGuid.TabIndex = 2;
            // 
            // Label1
            // 
            Label1.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            Label1.AutoSize = true;
            Label1.Location = new Point(12, 383);
            Label1.Name = "Label1";
            Label1.Size = new Size(134, 17);
            Label1.TabIndex = 3;
            Label1.Text = "Text To Search For:";
            // 
            // btnCommonErrs
            // 
            btnCommonErrs.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            btnCommonErrs.Location = new Point(13, 469);
            btnCommonErrs.Name = "btnCommonErrs";
            btnCommonErrs.Size = new Size(204, 32);
            btnCommonErrs.TabIndex = 4;
            btnCommonErrs.Text = "Error Summary";
            btnCommonErrs.UseVisualStyleBackColor = true;
            // 
            // btnSelectAll
            // 
            _btnSelectAll.Location = new Point(12, 5);
            _btnSelectAll.Name = "_btnSelectAll";
            _btnSelectAll.Size = new Size(300, 33);
            _btnSelectAll.TabIndex = 5;
            _btnSelectAll.Text = "Select All";
            _btnSelectAll.UseVisualStyleBackColor = true;
            // 
            // lbOutput
            // 
            _lbOutput.Anchor = AnchorStyles.Top | AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;

            _lbOutput.FormattingEnabled = true;
            _lbOutput.ItemHeight = 16;
            _lbOutput.Location = new Point(354, 44);
            _lbOutput.Name = "_lbOutput";
            _lbOutput.ScrollAlwaysVisible = true;
            _lbOutput.Size = new Size(639, 308);
            _lbOutput.TabIndex = 6;
            // 
            // btnSave
            // 
            btnSave.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            btnSave.FlatStyle = FlatStyle.System;
            btnSave.Location = new Point(789, 6);
            btnSave.Name = "btnSave";
            btnSave.Size = new Size(204, 32);
            btnSave.TabIndex = 7;
            btnSave.Text = "Save to File";
            btnSave.UseVisualStyleBackColor = true;
            // 
            // Button1
            // 
            _Button1.Location = new Point(237, 359);
            _Button1.Name = "_Button1";
            _Button1.Size = new Size(75, 29);
            _Button1.TabIndex = 8;
            _Button1.Text = "Edit";
            _Button1.UseVisualStyleBackColor = true;
            _Button1.Visible = false;
            // 
            // SB
            // 
            SB.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            SB.BackColor = SystemColors.InactiveCaption;
            SB.Location = new Point(12, 529);
            SB.Name = "SB";
            SB.Size = new Size(981, 22);
            SB.TabIndex = 9;
            // 
            // SBFqn
            // 
            SBFqn.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            SBFqn.BackColor = SystemColors.InactiveCaption;
            SBFqn.Location = new Point(12, 507);
            SBFqn.Name = "SBFqn";
            SBFqn.Size = new Size(981, 22);
            SBFqn.TabIndex = 10;
            // 
            // lblMsg
            // 
            lblMsg.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            lblMsg.AutoSize = true;
            lblMsg.Location = new Point(354, 359);
            lblMsg.Name = "lblMsg";
            lblMsg.Size = new Size(65, 17);
            lblMsg.TabIndex = 11;
            lblMsg.Text = "Message";
            // 
            // txtDetail
            // 
            txtDetail.Anchor = AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;
            txtDetail.Location = new Point(357, 384);
            txtDetail.Multiline = true;
            txtDetail.Name = "txtDetail";
            txtDetail.ScrollBars = ScrollBars.Both;
            txtDetail.Size = new Size(322, 117);
            txtDetail.TabIndex = 12;
            // 
            // txtKeyGuid
            // 
            txtKeyGuid.Anchor = AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;
            txtKeyGuid.Location = new Point(685, 416);
            txtKeyGuid.Name = "txtKeyGuid";
            txtKeyGuid.ReadOnly = true;
            txtKeyGuid.Size = new Size(299, 22);
            txtKeyGuid.TabIndex = 13;
            // 
            // txtDb
            // 
            txtDb.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            txtDb.Location = new Point(685, 384);
            txtDb.Name = "txtDb";
            txtDb.ReadOnly = true;
            txtDb.Size = new Size(299, 22);
            txtDb.TabIndex = 14;
            // 
            // btnFindItem
            // 
            _btnFindItem.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            _btnFindItem.Location = new Point(780, 444);
            _btnFindItem.Name = "_btnFindItem";
            _btnFindItem.Size = new Size(108, 34);
            _btnFindItem.TabIndex = 15;
            _btnFindItem.Text = "Get Name";
            _btnFindItem.UseVisualStyleBackColor = true;
            // 
            // txtMaxNbr
            // 
            txtMaxNbr.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            txtMaxNbr.Location = new Point(223, 469);
            txtMaxNbr.Name = "txtMaxNbr";
            txtMaxNbr.Size = new Size(72, 22);
            txtMaxNbr.TabIndex = 16;
            txtMaxNbr.Text = "100";
            // 
            // Label2
            // 
            Label2.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            Label2.AutoSize = true;
            Label2.Location = new Point(222, 449);
            Label2.Name = "Label2";
            Label2.Size = new Size(49, 17);
            Label2.TabIndex = 17;
            Label2.Text = "Max #:";
            // 
            // frmFti
            // 
            AutoScaleDimensions = new SizeF(8.0f, 16.0f);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(1019, 552);
            Controls.Add(Label2);
            Controls.Add(txtMaxNbr);
            Controls.Add(_btnFindItem);
            Controls.Add(txtDb);
            Controls.Add(txtKeyGuid);
            Controls.Add(txtDetail);
            Controls.Add(lblMsg);
            Controls.Add(SBFqn);
            Controls.Add(SB);
            Controls.Add(_Button1);
            Controls.Add(btnSave);
            Controls.Add(_lbOutput);
            Controls.Add(_btnSelectAll);
            Controls.Add(btnCommonErrs);
            Controls.Add(Label1);
            Controls.Add(txtSourceGuid);
            Controls.Add(_btnScanGuids);
            Controls.Add(_lbFtiLogs);
            Name = "frmFti";
            Text = "frmFti";
            Load += new EventHandler(frmFti_Load);
            ResumeLayout(false);
            PerformLayout();
        }

        private ListBox _lbFtiLogs;

        internal ListBox lbFtiLogs
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _lbFtiLogs;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_lbFtiLogs != null)
                {
                    _lbFtiLogs.SelectedIndexChanged -= lbFtiLogs_SelectedIndexChanged;
                }

                _lbFtiLogs = value;
                if (_lbFtiLogs != null)
                {
                    _lbFtiLogs.SelectedIndexChanged += lbFtiLogs_SelectedIndexChanged;
                }
            }
        }

        private Button _btnScanGuids;

        internal Button btnScanGuids
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnScanGuids;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnScanGuids != null)
                {
                    _btnScanGuids.Click -= btnScanGuids_Click;
                }

                _btnScanGuids = value;
                if (_btnScanGuids != null)
                {
                    _btnScanGuids.Click += btnScanGuids_Click;
                }
            }
        }

        internal TextBox txtSourceGuid;
        internal Label Label1;
        internal Button btnCommonErrs;
        private Button _btnSelectAll;

        internal Button btnSelectAll
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnSelectAll;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnSelectAll != null)
                {
                    _btnSelectAll.Click -= btnSelectAll_Click;
                }

                _btnSelectAll = value;
                if (_btnSelectAll != null)
                {
                    _btnSelectAll.Click += btnSelectAll_Click;
                }
            }
        }

        private ListBox _lbOutput;

        internal ListBox lbOutput
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _lbOutput;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_lbOutput != null)
                {
                    _lbOutput.SelectedIndexChanged -= lbOutput_SelectedIndexChanged;
                }

                _lbOutput = value;
                if (_lbOutput != null)
                {
                    _lbOutput.SelectedIndexChanged += lbOutput_SelectedIndexChanged;
                }
            }
        }

        internal Button btnSave;
        private Button _Button1;

        internal Button Button1
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _Button1;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_Button1 != null)
                {
                    _Button1.Click -= Button1_Click;
                }

                _Button1 = value;
                if (_Button1 != null)
                {
                    _Button1.Click += Button1_Click;
                }
            }
        }

        internal TextBox SB;
        internal TextBox SBFqn;
        internal Label lblMsg;
        internal TextBox txtDetail;
        internal TextBox txtKeyGuid;
        internal TextBox txtDb;
        private Button _btnFindItem;

        internal Button btnFindItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnFindItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnFindItem != null)
                {
                    _btnFindItem.Click -= btnFindItem_Click;
                }

                _btnFindItem = value;
                if (_btnFindItem != null)
                {
                    _btnFindItem.Click += btnFindItem_Click;
                }
            }
        }

        internal TextBox txtMaxNbr;
        internal Label Label2;
    }
}