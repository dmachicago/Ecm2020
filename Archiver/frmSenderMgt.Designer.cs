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
    public partial class frmSenderMgt : Form
    {

        // Form overrides dispose to clean up the component list.
        [DebuggerNonUserCode()]
        protected override void Dispose(bool disposing)
        {
            if (disposing && components is object)
            {
                components.Dispose();
            }

            base.Dispose(disposing);
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
            Label1 = new Label();
            Label2 = new Label();
            GroupBox1 = new GroupBox();
            _btnRefresh = new Button();
            _btnRefresh.Click += new EventHandler(btnRefresh_Click);
            _rbContacts = new RadioButton();
            _rbContacts.CheckedChanged += new EventHandler(rbContacts_CheckedChanged);
            _btnExclSender = new Button();
            _btnExclSender.Click += new EventHandler(btnExclSender_Click);
            _rbInbox = new RadioButton();
            _rbInbox.CheckedChanged += new EventHandler(rbInbox_CheckedChanged);
            _rbArchive = new RadioButton();
            _rbArchive.CheckedChanged += new EventHandler(rbArchive_CheckedChanged);
            _btnRemoveExcluded = new Button();
            _btnRemoveExcluded.Click += new EventHandler(btnRemoveExcluded_Click);
            dgExcludedSenders = new DataGridView();
            dgEmailSenders = new DataGridView();
            ExcludeFromBindingSource = new BindingSource(components);
            ArchiveFromBindingSource = new BindingSource(components);
            DMAUDDataSetBindingSource = new BindingSource(components);
            DMAUDDataSet2BindingSource = new BindingSource(components);
            TT = new ToolTip(components);
            _Timer1 = new Timer(components);
            _Timer1.Tick += new EventHandler(Timer1_Tick);
            f1Help = new HelpProvider();
            cbOutlookFOlder = new ComboBox();
            GroupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)dgExcludedSenders).BeginInit();
            ((System.ComponentModel.ISupportInitialize)dgEmailSenders).BeginInit();
            ((System.ComponentModel.ISupportInitialize)ExcludeFromBindingSource).BeginInit();
            ((System.ComponentModel.ISupportInitialize)ArchiveFromBindingSource).BeginInit();
            ((System.ComponentModel.ISupportInitialize)DMAUDDataSetBindingSource).BeginInit();
            ((System.ComponentModel.ISupportInitialize)DMAUDDataSet2BindingSource).BeginInit();
            SuspendLayout();
            // 
            // Label1
            // 
            Label1.AutoSize = true;
            Label1.Location = new Point(8, 8);
            Label1.Name = "Label1";
            Label1.Size = new Size(74, 13);
            Label1.TabIndex = 3;
            Label1.Text = "Email Senders";
            // 
            // Label2
            // 
            Label2.AutoSize = true;
            Label2.Location = new Point(454, 9);
            Label2.Name = "Label2";
            Label2.Size = new Size(155, 13);
            Label2.TabIndex = 4;
            Label2.Text = "Excluded Senders from Archive";
            // 
            // GroupBox1
            // 
            GroupBox1.Controls.Add(cbOutlookFOlder);
            GroupBox1.Controls.Add(_btnRefresh);
            GroupBox1.Controls.Add(_rbContacts);
            GroupBox1.Controls.Add(_btnExclSender);
            GroupBox1.Controls.Add(_rbInbox);
            GroupBox1.Controls.Add(_rbArchive);
            GroupBox1.Location = new Point(16, 448);
            GroupBox1.Name = "GroupBox1";
            GroupBox1.Size = new Size(430, 121);
            GroupBox1.TabIndex = 6;
            GroupBox1.TabStop = false;
            GroupBox1.Text = "Sender List";
            // 
            // btnRefresh
            // 
            _btnRefresh.Location = new Point(360, 12);
            _btnRefresh.Name = "_btnRefresh";
            _btnRefresh.Size = new Size(64, 24);
            _btnRefresh.TabIndex = 13;
            _btnRefresh.Text = "&Refresh";
            _btnRefresh.UseVisualStyleBackColor = true;
            // 
            // rbContacts
            // 
            _rbContacts.AutoSize = true;
            _rbContacts.Location = new Point(24, 51);
            _rbContacts.Name = "_rbContacts";
            _rbContacts.Size = new Size(107, 17);
            _rbContacts.TabIndex = 12;
            _rbContacts.Text = "Outlook Contacts";
            _rbContacts.UseVisualStyleBackColor = true;
            _rbContacts.Visible = false;
            // 
            // btnExclSender
            // 
            _btnExclSender.Location = new Point(360, 44);
            _btnExclSender.Name = "_btnExclSender";
            _btnExclSender.Size = new Size(64, 24);
            _btnExclSender.TabIndex = 11;
            _btnExclSender.Text = "&Exclude";
            TT.SetToolTip(_btnExclSender, "Press to exclude selected senders from the archive process.");
            _btnExclSender.UseVisualStyleBackColor = true;
            // 
            // rbInbox
            // 
            _rbInbox.AutoSize = true;
            _rbInbox.Location = new Point(24, 86);
            _rbInbox.Name = "_rbInbox";
            _rbInbox.Size = new Size(93, 17);
            _rbInbox.TabIndex = 9;
            _rbInbox.Text = "Inbox Senders";
            _rbInbox.UseVisualStyleBackColor = true;
            // 
            // rbArchive
            // 
            _rbArchive.AutoSize = true;
            _rbArchive.Checked = true;
            _rbArchive.Location = new Point(24, 16);
            _rbArchive.Name = "_rbArchive";
            _rbArchive.Size = new Size(109, 17);
            _rbArchive.TabIndex = 8;
            _rbArchive.TabStop = true;
            _rbArchive.Text = "Archived Senders";
            _rbArchive.UseVisualStyleBackColor = true;
            // 
            // btnRemoveExcluded
            // 
            _btnRemoveExcluded.Location = new Point(826, 457);
            _btnRemoveExcluded.Name = "_btnRemoveExcluded";
            _btnRemoveExcluded.Size = new Size(64, 24);
            _btnRemoveExcluded.TabIndex = 11;
            _btnRemoveExcluded.Text = "&Deselect";
            _btnRemoveExcluded.UseVisualStyleBackColor = true;
            // 
            // dgExcludedSenders
            // 
            dgExcludedSenders.AllowUserToAddRows = false;
            dgExcludedSenders.AllowUserToDeleteRows = false;
            dgExcludedSenders.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            dgExcludedSenders.Location = new Point(457, 24);
            dgExcludedSenders.Name = "dgExcludedSenders";
            dgExcludedSenders.ReadOnly = true;
            dgExcludedSenders.Size = new Size(435, 417);
            dgExcludedSenders.TabIndex = 14;
            // 
            // dgEmailSenders
            // 
            dgEmailSenders.AllowUserToAddRows = false;
            dgEmailSenders.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            dgEmailSenders.Location = new Point(11, 25);
            dgEmailSenders.Name = "dgEmailSenders";
            dgEmailSenders.ReadOnly = true;
            dgEmailSenders.Size = new Size(435, 417);
            dgEmailSenders.TabIndex = 19;
            // 
            // ExcludeFromBindingSource
            // 
            ExcludeFromBindingSource.DataMember = "ExcludeFrom";
            // 
            // ArchiveFromBindingSource
            // 
            // 
            // ExcludeFromTableAdapter
            // 
            // 
            // DMAUDDataSetBindingSource
            // 
            DMAUDDataSetBindingSource.Position = 0;
            // 
            // _DMA_UDDataSet2
            // 
            // 
            // DMAUDDataSet2BindingSource
            // 
            // 
            // ArchiveFromTableAdapter
            // 
            // 
            // Timer1
            // 
            // 
            // f1Help
            // 
            f1Help.HelpNamespace = "http://www.ecmlibrary.com/_helpfiles/frmSenderMgt.htm";
            // 
            // cbOutlookFOlder
            // 
            cbOutlookFOlder.FormattingEnabled = true;
            cbOutlookFOlder.Location = new Point(123, 84);
            cbOutlookFOlder.Name = "cbOutlookFOlder";
            cbOutlookFOlder.Size = new Size(301, 21);
            cbOutlookFOlder.TabIndex = 14;
            // 
            // frmSenderMgt
            // 
            AutoScaleDimensions = new SizeF(6.0f, 13.0f);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(902, 581);
            Controls.Add(dgEmailSenders);
            Controls.Add(dgExcludedSenders);
            Controls.Add(_btnRemoveExcluded);
            Controls.Add(GroupBox1);
            Controls.Add(Label2);
            Controls.Add(Label1);
            f1Help.SetHelpString(this, "http://www.ecmlibrary.com/_helpfiles/frmSenderMgt.htm");
            Name = "frmSenderMgt";
            f1Help.SetShowHelp(this, true);
            Text = "Rejected Senders Management Screen";
            GroupBox1.ResumeLayout(false);
            GroupBox1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)dgExcludedSenders).EndInit();
            ((System.ComponentModel.ISupportInitialize)dgEmailSenders).EndInit();
            ((System.ComponentModel.ISupportInitialize)ExcludeFromBindingSource).EndInit();
            ((System.ComponentModel.ISupportInitialize)ArchiveFromBindingSource).EndInit();
            ((System.ComponentModel.ISupportInitialize)DMAUDDataSetBindingSource).EndInit();
            ((System.ComponentModel.ISupportInitialize)DMAUDDataSet2BindingSource).EndInit();
            Load += new EventHandler(frmSenderMgt_Load);
            Resize += new EventHandler(frmSenderMgt_Resize);
            ResumeLayout(false);
            PerformLayout();
        }

        internal Label Label1;
        internal Label Label2;
        internal GroupBox GroupBox1;
        private Button _btnExclSender;

        internal Button btnExclSender
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnExclSender;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnExclSender != null)
                {
                    _btnExclSender.Click -= btnExclSender_Click;
                }

                _btnExclSender = value;
                if (_btnExclSender != null)
                {
                    _btnExclSender.Click += btnExclSender_Click;
                }
            }
        }

        private RadioButton _rbInbox;

        internal RadioButton rbInbox
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _rbInbox;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_rbInbox != null)
                {
                    _rbInbox.CheckedChanged -= rbInbox_CheckedChanged;
                }

                _rbInbox = value;
                if (_rbInbox != null)
                {
                    _rbInbox.CheckedChanged += rbInbox_CheckedChanged;
                }
            }
        }

        private RadioButton _rbArchive;

        internal RadioButton rbArchive
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _rbArchive;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_rbArchive != null)
                {
                    _rbArchive.CheckedChanged -= rbArchive_CheckedChanged;
                }

                _rbArchive = value;
                if (_rbArchive != null)
                {
                    _rbArchive.CheckedChanged += rbArchive_CheckedChanged;
                }
            }
        }

        private Button _btnRemoveExcluded;

        internal Button btnRemoveExcluded
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnRemoveExcluded;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnRemoveExcluded != null)
                {
                    _btnRemoveExcluded.Click -= btnRemoveExcluded_Click;
                }

                _btnRemoveExcluded = value;
                if (_btnRemoveExcluded != null)
                {
                    _btnRemoveExcluded.Click += btnRemoveExcluded_Click;
                }
            }
        }

        private RadioButton _rbContacts;

        internal RadioButton rbContacts
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _rbContacts;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_rbContacts != null)
                {
                    _rbContacts.CheckedChanged -= rbContacts_CheckedChanged;
                }

                _rbContacts = value;
                if (_rbContacts != null)
                {
                    _rbContacts.CheckedChanged += rbContacts_CheckedChanged;
                }
            }
        }

        internal DataGridView dgExcludedSenders;
        internal BindingSource ExcludeFromBindingSource;
        private Button _btnRefresh;

        internal Button btnRefresh
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnRefresh;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnRefresh != null)
                {
                    _btnRefresh.Click -= btnRefresh_Click;
                }

                _btnRefresh = value;
                if (_btnRefresh != null)
                {
                    _btnRefresh.Click += btnRefresh_Click;
                }
            }
        }

        internal BindingSource DMAUDDataSetBindingSource;
        internal BindingSource DMAUDDataSet2BindingSource;
        internal DataGridView dgEmailSenders;
        internal BindingSource ArchiveFromBindingSource;
        internal ToolTip TT;
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

        internal HelpProvider f1Help;
        internal ComboBox cbOutlookFOlder;
    }
}