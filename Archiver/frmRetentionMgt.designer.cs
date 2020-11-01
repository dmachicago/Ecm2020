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
    public partial class frmRetentionMgt : Form
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
            components = new System.ComponentModel.Container();
            GroupBox1 = new GroupBox();
            _rbEmails = new RadioButton();
            _rbEmails.CheckedChanged += new EventHandler(rbEmails_CheckedChanged);
            _rbContent = new RadioButton();
            _rbContent.CheckedChanged += new EventHandler(rbContent_CheckedChanged);
            Label1 = new Label();
            txtExpireUnit = new TextBox();
            cbExpireUnits = new ComboBox();
            Label2 = new Label();
            _btnExecuteExpire = new Button();
            _btnExecuteExpire.Click += new EventHandler(btnExecuteExpire_Click);
            Label3 = new Label();
            _btnSelectExpired = new Button();
            _btnSelectExpired.Click += new EventHandler(btnSelectExpired_Click);
            _btnExecuteAge = new Button();
            _btnExecuteAge.Click += new EventHandler(btnExecuteAge_Click);
            cbAgeUnits = new ComboBox();
            txtAgeUnit = new TextBox();
            Label5 = new Label();
            dgItems = new DataGridView();
            SB = new TextBox();
            _btnDelete = new Button();
            _btnDelete.Click += new EventHandler(btnDelete_Click);
            _btnMove = new Button();
            _btnMove.Click += new EventHandler(btnMove_Click);
            _TT = new ToolTip(components);
            _TT.Popup += new PopupEventHandler(ToolTip1_Popup);
            PB = new ProgressBar();
            dtExtendDate = new DateTimePicker();
            Label4 = new Label();
            _btnExtend = new Button();
            _btnExtend.Click += new EventHandler(btnExtend_Click);
            _Timer1 = new Timer(components);
            _Timer1.Tick += new EventHandler(Timer1_Tick);
            _btnRecall = new Button();
            _btnRecall.Click += new EventHandler(btnRecall_Click);
            HelpProvider1 = new HelpProvider();
            GroupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)dgItems).BeginInit();
            SuspendLayout();
            // 
            // GroupBox1
            // 
            GroupBox1.Controls.Add(_rbEmails);
            GroupBox1.Controls.Add(_rbContent);
            GroupBox1.Location = new Point(12, 12);
            GroupBox1.Name = "GroupBox1";
            GroupBox1.Size = new Size(210, 88);
            GroupBox1.TabIndex = 0;
            GroupBox1.TabStop = false;
            GroupBox1.Text = "Select Group To Manage";
            // 
            // rbEmails
            // 
            _rbEmails.AutoSize = true;
            _rbEmails.Location = new Point(20, 48);
            _rbEmails.Name = "_rbEmails";
            _rbEmails.Size = new Size(55, 17);
            _rbEmails.TabIndex = 1;
            _rbEmails.TabStop = true;
            _rbEmails.Text = "Emails";
            _rbEmails.UseVisualStyleBackColor = true;
            // 
            // rbContent
            // 
            _rbContent.AutoSize = true;
            _rbContent.Location = new Point(20, 25);
            _rbContent.Name = "_rbContent";
            _rbContent.Size = new Size(127, 17);
            _rbContent.TabIndex = 0;
            _rbContent.TabStop = true;
            _rbContent.Text = "Content / Documents";
            _rbContent.UseVisualStyleBackColor = true;
            // 
            // Label1
            // 
            Label1.AutoSize = true;
            Label1.Location = new Point(12, 121);
            Label1.Name = "Label1";
            Label1.Size = new Size(107, 13);
            Label1.TabIndex = 1;
            Label1.Text = "Select all items within";
            // 
            // txtExpireUnit
            // 
            txtExpireUnit.Location = new Point(12, 143);
            txtExpireUnit.Name = "txtExpireUnit";
            txtExpireUnit.Size = new Size(52, 20);
            txtExpireUnit.TabIndex = 2;
            // 
            // cbExpireUnits
            // 
            cbExpireUnits.FormattingEnabled = true;
            cbExpireUnits.Items.AddRange(new object[] { "Months", "Days", "Years" });
            cbExpireUnits.Location = new Point(88, 142);
            cbExpireUnits.Name = "cbExpireUnits";
            cbExpireUnits.Size = new Size(97, 21);
            cbExpireUnits.TabIndex = 3;
            cbExpireUnits.Text = "Months";
            // 
            // Label2
            // 
            Label2.AutoSize = true;
            Label2.Location = new Point(9, 177);
            Label2.Name = "Label2";
            Label2.Size = new Size(64, 13);
            Label2.TabIndex = 4;
            Label2.Text = "of expiration";
            // 
            // btnExecuteExpire
            // 
            _btnExecuteExpire.Location = new Point(88, 177);
            _btnExecuteExpire.Name = "_btnExecuteExpire";
            _btnExecuteExpire.Size = new Size(91, 25);
            _btnExecuteExpire.TabIndex = 5;
            _btnExecuteExpire.Text = "Execute";
            _btnExecuteExpire.UseVisualStyleBackColor = true;
            // 
            // Label3
            // 
            Label3.AutoSize = true;
            Label3.Location = new Point(19, 330);
            Label3.Name = "Label3";
            Label3.Size = new Size(114, 13);
            Label3.TabIndex = 6;
            Label3.Text = "Select all expired items";
            // 
            // btnSelectExpired
            // 
            _btnSelectExpired.Location = new Point(22, 346);
            _btnSelectExpired.Name = "_btnSelectExpired";
            _btnSelectExpired.Size = new Size(91, 25);
            _btnSelectExpired.TabIndex = 7;
            _btnSelectExpired.Text = "Execute";
            _btnSelectExpired.UseVisualStyleBackColor = true;
            // 
            // btnExecuteAge
            // 
            _btnExecuteAge.Location = new Point(94, 280);
            _btnExecuteAge.Name = "_btnExecuteAge";
            _btnExecuteAge.Size = new Size(91, 25);
            _btnExecuteAge.TabIndex = 12;
            _btnExecuteAge.Text = "Execute";
            _btnExecuteAge.UseVisualStyleBackColor = true;
            // 
            // cbAgeUnits
            // 
            cbAgeUnits.FormattingEnabled = true;
            cbAgeUnits.Items.AddRange(new object[] { "Months", "Days", "Years" });
            cbAgeUnits.Location = new Point(88, 251);
            cbAgeUnits.Name = "cbAgeUnits";
            cbAgeUnits.Size = new Size(97, 21);
            cbAgeUnits.TabIndex = 10;
            cbAgeUnits.Text = "Months";
            // 
            // txtAgeUnit
            // 
            txtAgeUnit.Location = new Point(12, 252);
            txtAgeUnit.Name = "txtAgeUnit";
            txtAgeUnit.Size = new Size(52, 20);
            txtAgeUnit.TabIndex = 9;
            // 
            // Label5
            // 
            Label5.AutoSize = true;
            Label5.Location = new Point(12, 230);
            Label5.Name = "Label5";
            Label5.Size = new Size(127, 13);
            Label5.TabIndex = 8;
            Label5.Text = "Select all items older than";
            // 
            // dgItems
            // 
            dgItems.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            dgItems.Location = new Point(248, 37);
            dgItems.Name = "dgItems";
            dgItems.Size = new Size(576, 358);
            dgItems.TabIndex = 13;
            // 
            // SB
            // 
            SB.Location = new Point(15, 462);
            SB.Name = "SB";
            SB.Size = new Size(809, 20);
            SB.TabIndex = 14;
            // 
            // btnDelete
            // 
            _btnDelete.Location = new Point(248, 414);
            _btnDelete.Name = "_btnDelete";
            _btnDelete.Size = new Size(91, 42);
            _btnDelete.TabIndex = 15;
            _btnDelete.Text = "Delete Selected Items";
            _btnDelete.UseVisualStyleBackColor = true;
            // 
            // btnMove
            // 
            _btnMove.Enabled = false;
            _btnMove.Location = new Point(733, 414);
            _btnMove.Name = "_btnMove";
            _btnMove.Size = new Size(91, 42);
            _btnMove.TabIndex = 16;
            _btnMove.Text = "Move Selected Items";
            _btnMove.UseVisualStyleBackColor = true;
            // 
            // TT
            // 
            // 
            // PB
            // 
            PB.Location = new Point(372, 431);
            PB.Name = "PB";
            PB.Size = new Size(329, 14);
            PB.TabIndex = 17;
            // 
            // dtExtendDate
            // 
            dtExtendDate.Location = new Point(469, 10);
            dtExtendDate.Name = "dtExtendDate";
            dtExtendDate.Size = new Size(208, 20);
            dtExtendDate.TabIndex = 18;
            // 
            // Label4
            // 
            Label4.AutoSize = true;
            Label4.Location = new Point(245, 14);
            Label4.Name = "Label4";
            Label4.Size = new Size(218, 13);
            Label4.TabIndex = 19;
            Label4.Text = "Extend all selected item's retention date until:";
            // 
            // btnExtend
            // 
            _btnExtend.Location = new Point(733, 8);
            _btnExtend.Name = "_btnExtend";
            _btnExtend.Size = new Size(91, 25);
            _btnExtend.TabIndex = 20;
            _btnExtend.Text = "Extend";
            _btnExtend.UseVisualStyleBackColor = true;
            // 
            // Timer1
            // 
            // 
            // btnRecall
            // 
            _btnRecall.Enabled = false;
            _btnRecall.Location = new Point(22, 414);
            _btnRecall.Name = "_btnRecall";
            _btnRecall.Size = new Size(163, 42);
            _btnRecall.TabIndex = 21;
            _btnRecall.Text = "Load Marked EMAIL Retention Items";
            _btnRecall.UseVisualStyleBackColor = true;
            // 
            // HelpProvider1
            // 
            HelpProvider1.HelpNamespace = "http://www.ecmlibrary.com/_helpfiles/Retention Management Screen.htm";
            // 
            // frmRetentionMgt
            // 
            AutoScaleDimensions = new SizeF(6.0f, 13.0f);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(871, 494);
            Controls.Add(_btnRecall);
            Controls.Add(_btnExtend);
            Controls.Add(Label4);
            Controls.Add(dtExtendDate);
            Controls.Add(PB);
            Controls.Add(_btnMove);
            Controls.Add(_btnDelete);
            Controls.Add(SB);
            Controls.Add(dgItems);
            Controls.Add(_btnExecuteAge);
            Controls.Add(cbAgeUnits);
            Controls.Add(txtAgeUnit);
            Controls.Add(Label5);
            Controls.Add(_btnSelectExpired);
            Controls.Add(Label3);
            Controls.Add(_btnExecuteExpire);
            Controls.Add(Label2);
            Controls.Add(cbExpireUnits);
            Controls.Add(txtExpireUnit);
            Controls.Add(Label1);
            Controls.Add(GroupBox1);
            HelpProvider1.SetHelpString(this, "http://www.ecmlibrary.com/_helpfiles/Retention Management Screen.htm");
            Name = "frmRetentionMgt";
            HelpProvider1.SetShowHelp(this, true);
            Text = "Content Retention Management Screen";
            GroupBox1.ResumeLayout(false);
            GroupBox1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)dgItems).EndInit();
            Load += new EventHandler(frmRetentionMgt_Load);
            Resize += new EventHandler(frmRetentionMgt_Resize);
            ResumeLayout(false);
            PerformLayout();
        }

        internal GroupBox GroupBox1;
        private RadioButton _rbEmails;

        internal RadioButton rbEmails
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _rbEmails;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_rbEmails != null)
                {
                    _rbEmails.CheckedChanged -= rbEmails_CheckedChanged;
                }

                _rbEmails = value;
                if (_rbEmails != null)
                {
                    _rbEmails.CheckedChanged += rbEmails_CheckedChanged;
                }
            }
        }

        private RadioButton _rbContent;

        internal RadioButton rbContent
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _rbContent;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_rbContent != null)
                {
                    _rbContent.CheckedChanged -= rbContent_CheckedChanged;
                }

                _rbContent = value;
                if (_rbContent != null)
                {
                    _rbContent.CheckedChanged += rbContent_CheckedChanged;
                }
            }
        }

        internal Label Label1;
        internal TextBox txtExpireUnit;
        internal ComboBox cbExpireUnits;
        internal Label Label2;
        private Button _btnExecuteExpire;

        internal Button btnExecuteExpire
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnExecuteExpire;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnExecuteExpire != null)
                {
                    _btnExecuteExpire.Click -= btnExecuteExpire_Click;
                }

                _btnExecuteExpire = value;
                if (_btnExecuteExpire != null)
                {
                    _btnExecuteExpire.Click += btnExecuteExpire_Click;
                }
            }
        }

        internal Label Label3;
        private Button _btnSelectExpired;

        internal Button btnSelectExpired
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnSelectExpired;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnSelectExpired != null)
                {
                    _btnSelectExpired.Click -= btnSelectExpired_Click;
                }

                _btnSelectExpired = value;
                if (_btnSelectExpired != null)
                {
                    _btnSelectExpired.Click += btnSelectExpired_Click;
                }
            }
        }

        private Button _btnExecuteAge;

        internal Button btnExecuteAge
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnExecuteAge;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnExecuteAge != null)
                {
                    _btnExecuteAge.Click -= btnExecuteAge_Click;
                }

                _btnExecuteAge = value;
                if (_btnExecuteAge != null)
                {
                    _btnExecuteAge.Click += btnExecuteAge_Click;
                }
            }
        }

        internal ComboBox cbAgeUnits;
        internal TextBox txtAgeUnit;
        internal Label Label5;
        internal DataGridView dgItems;
        internal TextBox SB;
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

        private Button _btnMove;

        internal Button btnMove
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnMove;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnMove != null)
                {
                    _btnMove.Click -= btnMove_Click;
                }

                _btnMove = value;
                if (_btnMove != null)
                {
                    _btnMove.Click += btnMove_Click;
                }
            }
        }

        private ToolTip _TT;

        internal ToolTip TT
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _TT;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_TT != null)
                {
                    _TT.Popup -= ToolTip1_Popup;
                }

                _TT = value;
                if (_TT != null)
                {
                    _TT.Popup += ToolTip1_Popup;
                }
            }
        }

        internal ProgressBar PB;
        internal DateTimePicker dtExtendDate;
        internal Label Label4;
        private Button _btnExtend;

        internal Button btnExtend
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnExtend;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnExtend != null)
                {
                    _btnExtend.Click -= btnExtend_Click;
                }

                _btnExtend = value;
                if (_btnExtend != null)
                {
                    _btnExtend.Click += btnExtend_Click;
                }
            }
        }

        private Timer _Timer1;

        internal Timer Timer1
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _Timer1;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_Timer1 != null)
                {
                    _Timer1.Tick -= Timer1_Tick;
                }

                _Timer1 = value;
                if (_Timer1 != null)
                {
                    _Timer1.Tick += Timer1_Tick;
                }
            }
        }

        private Button _btnRecall;

        internal Button btnRecall
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnRecall;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnRecall != null)
                {
                    _btnRecall.Click -= btnRecall_Click;
                }

                _btnRecall = value;
                if (_btnRecall != null)
                {
                    _btnRecall.Click += btnRecall_Click;
                }
            }
        }

        internal HelpProvider HelpProvider1;
    }
}