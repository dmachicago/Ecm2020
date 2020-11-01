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
    public partial class frmRetentionCode : Form
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
            _dgRetention = new DataGridView();
            _dgRetention.SelectionChanged += new EventHandler(dgRetention_SelectionChanged);
            txtRetentionCode = new TextBox();
            Label1 = new Label();
            txtDesc = new TextBox();
            Label2 = new Label();
            nbrRetentionUnits = new NumericUpDown();
            cbRetentionPeriod = new ComboBox();
            Label3 = new Label();
            Label4 = new Label();
            Label5 = new Label();
            nbrDaysWarning = new NumericUpDown();
            ckResponseRequired = new CheckBox();
            Label6 = new Label();
            txtManagerID = new TextBox();
            SB = new TextBox();
            _btnSave = new Button();
            _btnSave.Click += new EventHandler(btnSave_Click);
            _btnDelete = new Button();
            _btnDelete.Click += new EventHandler(btnDelete_Click);
            Label7 = new Label();
            cbRetentionAction = new ComboBox();
            ((System.ComponentModel.ISupportInitialize)_dgRetention).BeginInit();
            ((System.ComponentModel.ISupportInitialize)nbrRetentionUnits).BeginInit();
            ((System.ComponentModel.ISupportInitialize)nbrDaysWarning).BeginInit();
            SuspendLayout();
            // 
            // dgRetention
            // 
            _dgRetention.AllowUserToAddRows = false;
            _dgRetention.AllowUserToDeleteRows = false;
            _dgRetention.AllowUserToOrderColumns = true;
            _dgRetention.Anchor = AnchorStyles.Top | AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;

            _dgRetention.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            _dgRetention.Location = new Point(12, 318);
            _dgRetention.Name = "_dgRetention";
            _dgRetention.Size = new Size(759, 236);
            _dgRetention.TabIndex = 99;
            // 
            // txtRetentionCode
            // 
            txtRetentionCode.BackColor = Color.Gainsboro;
            txtRetentionCode.Location = new Point(12, 42);
            txtRetentionCode.Name = "txtRetentionCode";
            txtRetentionCode.Size = new Size(246, 20);
            txtRetentionCode.TabIndex = 1;
            // 
            // Label1
            // 
            Label1.AutoSize = true;
            Label1.Location = new Point(12, 24);
            Label1.Name = "Label1";
            Label1.Size = new Size(81, 13);
            Label1.TabIndex = 2;
            Label1.Text = "Retention Code";
            // 
            // txtDesc
            // 
            txtDesc.Anchor = AnchorStyles.Top | AnchorStyles.Left | AnchorStyles.Right;
            txtDesc.BackColor = Color.Gainsboro;
            txtDesc.Location = new Point(15, 78);
            txtDesc.Multiline = true;
            txtDesc.Name = "txtDesc";
            txtDesc.Size = new Size(548, 221);
            txtDesc.TabIndex = 3;
            // 
            // Label2
            // 
            Label2.AutoSize = true;
            Label2.Location = new Point(12, 62);
            Label2.Name = "Label2";
            Label2.Size = new Size(107, 13);
            Label2.TabIndex = 4;
            Label2.Text = "Retention description";
            // 
            // nbrRetentionUnits
            // 
            nbrRetentionUnits.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            nbrRetentionUnits.Location = new Point(591, 86);
            nbrRetentionUnits.Name = "nbrRetentionUnits";
            nbrRetentionUnits.Size = new Size(94, 20);
            nbrRetentionUnits.TabIndex = 5;
            nbrRetentionUnits.Value = new decimal(new int[] { 10, 0, 0, 0 });
            // 
            // cbRetentionPeriod
            // 
            cbRetentionPeriod.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            cbRetentionPeriod.FormattingEnabled = true;
            cbRetentionPeriod.Items.AddRange(new object[] { "Year", "Month", "Day" });
            cbRetentionPeriod.Location = new Point(591, 42);
            cbRetentionPeriod.Name = "cbRetentionPeriod";
            cbRetentionPeriod.Size = new Size(91, 21);
            cbRetentionPeriod.TabIndex = 4;
            cbRetentionPeriod.Text = "Year";
            // 
            // Label3
            // 
            Label3.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            Label3.AutoSize = true;
            Label3.Location = new Point(591, 68);
            Label3.Name = "Label3";
            Label3.Size = new Size(89, 13);
            Label3.TabIndex = 7;
            Label3.Text = "Retention Length";
            // 
            // Label4
            // 
            Label4.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            Label4.AutoSize = true;
            Label4.Location = new Point(591, 24);
            Label4.Name = "Label4";
            Label4.Size = new Size(86, 13);
            Label4.TabIndex = 8;
            Label4.Text = "Retention Period";
            // 
            // Label5
            // 
            Label5.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            Label5.AutoSize = true;
            Label5.Location = new Point(591, 111);
            Label5.Name = "Label5";
            Label5.Size = new Size(74, 13);
            Label5.TabIndex = 10;
            Label5.Text = "Days Warning";
            // 
            // nbrDaysWarning
            // 
            nbrDaysWarning.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            nbrDaysWarning.Location = new Point(591, 129);
            nbrDaysWarning.Name = "nbrDaysWarning";
            nbrDaysWarning.Size = new Size(94, 20);
            nbrDaysWarning.TabIndex = 6;
            nbrDaysWarning.Value = new decimal(new int[] { 30, 0, 0, 0 });
            // 
            // ckResponseRequired
            // 
            ckResponseRequired.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            ckResponseRequired.AutoSize = true;
            ckResponseRequired.Location = new Point(591, 198);
            ckResponseRequired.Name = "ckResponseRequired";
            ckResponseRequired.Size = new Size(120, 17);
            ckResponseRequired.TabIndex = 7;
            ckResponseRequired.Text = "Response Required";
            ckResponseRequired.UseVisualStyleBackColor = true;
            // 
            // Label6
            // 
            Label6.AutoSize = true;
            Label6.Location = new Point(314, 24);
            Label6.Name = "Label6";
            Label6.Size = new Size(133, 13);
            Label6.TabIndex = 14;
            Label6.Text = "Manager Notification Email";
            // 
            // txtManagerID
            // 
            txtManagerID.BackColor = Color.Gainsboro;
            txtManagerID.Location = new Point(314, 42);
            txtManagerID.Name = "txtManagerID";
            txtManagerID.Size = new Size(246, 20);
            txtManagerID.TabIndex = 2;
            // 
            // SB
            // 
            SB.Location = new Point(12, 561);
            SB.Name = "SB";
            SB.Size = new Size(759, 20);
            SB.TabIndex = 99999;
            // 
            // btnSave
            // 
            _btnSave.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            _btnSave.Location = new Point(591, 248);
            _btnSave.Name = "_btnSave";
            _btnSave.Size = new Size(73, 50);
            _btnSave.TabIndex = 100001;
            _btnSave.Text = "Save";
            _btnSave.UseVisualStyleBackColor = true;
            // 
            // btnDelete
            // 
            _btnDelete.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            _btnDelete.Location = new Point(698, 248);
            _btnDelete.Name = "_btnDelete";
            _btnDelete.Size = new Size(73, 51);
            _btnDelete.TabIndex = 100002;
            _btnDelete.Text = "Delete";
            _btnDelete.UseVisualStyleBackColor = true;
            // 
            // Label7
            // 
            Label7.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            Label7.AutoSize = true;
            Label7.Location = new Point(591, 154);
            Label7.Name = "Label7";
            Label7.Size = new Size(86, 13);
            Label7.TabIndex = 100004;
            Label7.Text = "Retention Action";
            // 
            // cbRetentionAction
            // 
            cbRetentionAction.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            cbRetentionAction.FormattingEnabled = true;
            cbRetentionAction.Items.AddRange(new object[] { "Delete", "Move" });
            cbRetentionAction.Location = new Point(591, 172);
            cbRetentionAction.Name = "cbRetentionAction";
            cbRetentionAction.Size = new Size(91, 21);
            cbRetentionAction.TabIndex = 100003;
            cbRetentionAction.Text = "Delete";
            // 
            // frmRetentionCode
            // 
            AutoScaleDimensions = new SizeF(6.0f, 13.0f);
            AutoScaleMode = AutoScaleMode.Font;
            BackColor = Color.LightGray;
            ClientSize = new Size(783, 593);
            Controls.Add(Label7);
            Controls.Add(cbRetentionAction);
            Controls.Add(_btnDelete);
            Controls.Add(_btnSave);
            Controls.Add(SB);
            Controls.Add(Label6);
            Controls.Add(txtManagerID);
            Controls.Add(ckResponseRequired);
            Controls.Add(Label5);
            Controls.Add(nbrDaysWarning);
            Controls.Add(Label4);
            Controls.Add(Label3);
            Controls.Add(cbRetentionPeriod);
            Controls.Add(nbrRetentionUnits);
            Controls.Add(Label2);
            Controls.Add(txtDesc);
            Controls.Add(Label1);
            Controls.Add(txtRetentionCode);
            Controls.Add(_dgRetention);
            Name = "frmRetentionCode";
            Text = "Retention Rules     (frmRetentionCode)";
            ((System.ComponentModel.ISupportInitialize)_dgRetention).EndInit();
            ((System.ComponentModel.ISupportInitialize)nbrRetentionUnits).EndInit();
            ((System.ComponentModel.ISupportInitialize)nbrDaysWarning).EndInit();
            Load += new EventHandler(frmRetentionCode_Load);
            ResumeLayout(false);
            PerformLayout();
        }

        private DataGridView _dgRetention;

        internal DataGridView dgRetention
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _dgRetention;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_dgRetention != null)
                {
                    _dgRetention.SelectionChanged -= dgRetention_SelectionChanged;
                }

                _dgRetention = value;
                if (_dgRetention != null)
                {
                    _dgRetention.SelectionChanged += dgRetention_SelectionChanged;
                }
            }
        }

        internal TextBox txtRetentionCode;
        internal Label Label1;
        internal TextBox txtDesc;
        internal Label Label2;
        internal NumericUpDown nbrRetentionUnits;
        internal ComboBox cbRetentionPeriod;
        internal Label Label3;
        internal Label Label4;
        internal Label Label5;
        internal NumericUpDown nbrDaysWarning;
        internal CheckBox ckResponseRequired;
        internal Label Label6;
        internal TextBox txtManagerID;
        internal TextBox SB;
        private Button _btnSave;

        internal Button btnSave
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnSave;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnSave != null)
                {
                    _btnSave.Click -= btnSave_Click;
                }

                _btnSave = value;
                if (_btnSave != null)
                {
                    _btnSave.Click += btnSave_Click;
                }
            }
        }

        private Button _btnDelete;

        internal Button btnDelete
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnDelete;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnDelete != null)
                {
                    _btnDelete.Click -= btnDelete_Click;
                }

                _btnDelete = value;
                if (_btnDelete != null)
                {
                    _btnDelete.Click += btnDelete_Click;
                }
            }
        }

        internal Label Label7;
        internal ComboBox cbRetentionAction;
    }
}