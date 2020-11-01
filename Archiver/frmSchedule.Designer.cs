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
    public partial class frmSchedule : Form
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
            var DataGridViewCellStyle1 = new DataGridViewCellStyle();
            var DataGridViewCellStyle2 = new DataGridViewCellStyle();
            var DataGridViewCellStyle3 = new DataGridViewCellStyle();
            _dgSchedule = new DataGridView();
            _dgSchedule.CellContentClick += new DataGridViewCellEventHandler(dgSchedule_CellContentClick);
            _dgSchedule.SelectionChanged += new EventHandler(dgSchedule_SelectionChanged);
            _btnDisplaySchedules = new Button();
            _btnDisplaySchedules.Click += new EventHandler(btnDisplaySchedules_Click);
            _btnDelete = new Button();
            _btnDelete.Click += new EventHandler(btnDelete_Click);
            TT = new ToolTip(components);
            lblScheduleType = new Label();
            _cbScheduleUnits = new ComboBox();
            _cbScheduleUnits.SelectedIndexChanged += new EventHandler(cbScheduleUnits_SelectedIndexChanged);
            Label1 = new Label();
            Label2 = new Label();
            _btnUpdate = new Button();
            _btnUpdate.Click += new EventHandler(btnUpdate_Click);
            _btnAdd = new Button();
            _btnAdd.Click += new EventHandler(btnAdd_Click);
            StatusBar = new StatusStrip();
            SB = new ToolStripStatusLabel();
            SB2 = new ToolStripStatusLabel();
            SelectedTaskName = new ToolStripStatusLabel();
            MenuStrip1 = new MenuStrip();
            ToolsToolStripMenuItem = new ToolStripMenuItem();
            _WindowsSchedulerToolStripMenuItem = new ToolStripMenuItem();
            _WindowsSchedulerToolStripMenuItem.Click += new EventHandler(WindowsSchedulerToolStripMenuItem_Click);
            _ApplicationExecutionPathToolStripMenuItem = new ToolStripMenuItem();
            _ApplicationExecutionPathToolStripMenuItem.Click += new EventHandler(ApplicationExecutionPathToolStripMenuItem_Click);
            Label3 = new Label();
            cbDayToRun = new ComboBox();
            dtStart = new DateTimePicker();
            _btnDisableArchive = new Button();
            _btnDisableArchive.Click += new EventHandler(btnDisableArchive_Click);
            _btnEnableArchive = new Button();
            _btnEnableArchive.Click += new EventHandler(btnEnableArchive_Click);
            ckAll = new CheckBox();
            ckFiles = new CheckBox();
            ckOutlook = new CheckBox();
            ckExchange = new CheckBox();
            cbTod = new ComboBox();
            Label4 = new Label();
            Label5 = new Label();
            txtUser = new TextBox();
            _btnValidate = new Button();
            _btnValidate.Click += new EventHandler(btnValidate_Click);
            _ckShowAll = new CheckBox();
            _ckShowAll.CheckedChanged += new EventHandler(ckShowAll_CheckedChanged);
            ckClipboardCommad = new CheckBox();
            _CommandExecutionDirectoryToolStripMenuItem = new ToolStripMenuItem();
            _CommandExecutionDirectoryToolStripMenuItem.Click += new EventHandler(CommandExecutionDirectoryToolStripMenuItem_Click);
            ((System.ComponentModel.ISupportInitialize)_dgSchedule).BeginInit();
            StatusBar.SuspendLayout();
            MenuStrip1.SuspendLayout();
            SuspendLayout();
            // 
            // dgSchedule
            // 
            _dgSchedule.Anchor = AnchorStyles.Top | AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;

            DataGridViewCellStyle1.Alignment = DataGridViewContentAlignment.MiddleLeft;
            DataGridViewCellStyle1.BackColor = SystemColors.Control;
            DataGridViewCellStyle1.Font = new Font("Microsoft Sans Serif", 8.25f, FontStyle.Regular, GraphicsUnit.Point, Conversions.ToByte(0));
            DataGridViewCellStyle1.ForeColor = SystemColors.WindowText;
            DataGridViewCellStyle1.SelectionBackColor = SystemColors.Highlight;
            DataGridViewCellStyle1.SelectionForeColor = SystemColors.HighlightText;
            DataGridViewCellStyle1.WrapMode = DataGridViewTriState.True;
            _dgSchedule.ColumnHeadersDefaultCellStyle = DataGridViewCellStyle1;
            _dgSchedule.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            DataGridViewCellStyle2.Alignment = DataGridViewContentAlignment.MiddleLeft;
            DataGridViewCellStyle2.BackColor = SystemColors.Window;
            DataGridViewCellStyle2.Font = new Font("Microsoft Sans Serif", 8.25f, FontStyle.Regular, GraphicsUnit.Point, Conversions.ToByte(0));
            DataGridViewCellStyle2.ForeColor = SystemColors.ControlText;
            DataGridViewCellStyle2.SelectionBackColor = SystemColors.Highlight;
            DataGridViewCellStyle2.SelectionForeColor = SystemColors.HighlightText;
            DataGridViewCellStyle2.WrapMode = DataGridViewTriState.False;
            _dgSchedule.DefaultCellStyle = DataGridViewCellStyle2;
            _dgSchedule.Location = new Point(12, 30);
            _dgSchedule.Name = "_dgSchedule";
            DataGridViewCellStyle3.Alignment = DataGridViewContentAlignment.MiddleLeft;
            DataGridViewCellStyle3.BackColor = SystemColors.Control;
            DataGridViewCellStyle3.Font = new Font("Microsoft Sans Serif", 8.25f, FontStyle.Regular, GraphicsUnit.Point, Conversions.ToByte(0));
            DataGridViewCellStyle3.ForeColor = SystemColors.WindowText;
            DataGridViewCellStyle3.SelectionBackColor = SystemColors.Highlight;
            DataGridViewCellStyle3.SelectionForeColor = SystemColors.HighlightText;
            DataGridViewCellStyle3.WrapMode = DataGridViewTriState.True;
            _dgSchedule.RowHeadersDefaultCellStyle = DataGridViewCellStyle3;
            _dgSchedule.Size = new Size(818, 338);
            _dgSchedule.TabIndex = 0;
            // 
            // btnDisplaySchedules
            // 
            _btnDisplaySchedules.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            _btnDisplaySchedules.Location = new Point(146, 461);
            _btnDisplaySchedules.Name = "_btnDisplaySchedules";
            _btnDisplaySchedules.Size = new Size(85, 60);
            _btnDisplaySchedules.TabIndex = 1;
            _btnDisplaySchedules.Text = "Display Scheduled Items";
            _btnDisplaySchedules.UseVisualStyleBackColor = true;
            // 
            // btnDelete
            // 
            _btnDelete.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            _btnDelete.Location = new Point(344, 461);
            _btnDelete.Name = "_btnDelete";
            _btnDelete.Size = new Size(85, 60);
            _btnDelete.TabIndex = 2;
            _btnDelete.Text = "Delete Selected Task";
            _btnDelete.UseVisualStyleBackColor = true;
            // 
            // lblScheduleType
            // 
            lblScheduleType.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            lblScheduleType.AutoSize = true;
            lblScheduleType.Font = new Font("Microsoft Sans Serif", 8.25f, FontStyle.Bold, GraphicsUnit.Point, Conversions.ToByte(0));
            lblScheduleType.Location = new Point(6, 410);
            lblScheduleType.Name = "lblScheduleType";
            lblScheduleType.Size = new Size(139, 13);
            lblScheduleType.TabIndex = 4;
            lblScheduleType.Text = "Select what to archive:";
            // 
            // cbScheduleUnits
            // 
            _cbScheduleUnits.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            _cbScheduleUnits.FormattingEnabled = true;
            _cbScheduleUnits.Items.AddRange(new object[] { "HOURLY", "DAILY", "WEEKLY", "MONTHLY" });
            _cbScheduleUnits.Location = new Point(143, 387);
            _cbScheduleUnits.Name = "_cbScheduleUnits";
            _cbScheduleUnits.Size = new Size(169, 21);
            _cbScheduleUnits.TabIndex = 5;
            // 
            // Label1
            // 
            Label1.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            Label1.AutoSize = true;
            Label1.Location = new Point(143, 371);
            Label1.Name = "Label1";
            Label1.Size = new Size(133, 13);
            Label1.TabIndex = 6;
            Label1.Text = "Choose When To Archive:";
            // 
            // Label2
            // 
            Label2.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            Label2.AutoSize = true;
            Label2.Location = new Point(674, 371);
            Label2.Name = "Label2";
            Label2.Size = new Size(58, 13);
            Label2.TabIndex = 7;
            Label2.Text = "Start Time:";
            // 
            // btnUpdate
            // 
            _btnUpdate.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            _btnUpdate.Location = new Point(629, 461);
            _btnUpdate.Name = "_btnUpdate";
            _btnUpdate.Size = new Size(85, 60);
            _btnUpdate.TabIndex = 10;
            _btnUpdate.Text = "Update Selected Task";
            _btnUpdate.UseVisualStyleBackColor = true;
            // 
            // btnAdd
            // 
            _btnAdd.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            _btnAdd.Location = new Point(744, 461);
            _btnAdd.Name = "_btnAdd";
            _btnAdd.Size = new Size(85, 60);
            _btnAdd.TabIndex = 11;
            _btnAdd.Text = "Add New Selected Task";
            _btnAdd.UseVisualStyleBackColor = true;
            // 
            // StatusBar
            // 
            StatusBar.Items.AddRange(new ToolStripItem[] { SB, SB2, SelectedTaskName });
            StatusBar.Location = new Point(0, 534);
            StatusBar.Name = "StatusBar";
            StatusBar.Size = new Size(842, 22);
            StatusBar.TabIndex = 12;
            // 
            // SB
            // 
            SB.Name = "SB";
            SB.Size = new Size(105, 17);
            SB.Text = "Archiver Messages";
            // 
            // SB2
            // 
            SB2.Name = "SB2";
            SB2.Size = new Size(61, 17);
            SB2.Text = "Statement";
            // 
            // SelectedTaskName
            // 
            SelectedTaskName.Name = "SelectedTaskName";
            SelectedTaskName.Size = new Size(66, 17);
            SelectedTaskName.Text = "Task Name";
            // 
            // MenuStrip1
            // 
            MenuStrip1.Items.AddRange(new ToolStripItem[] { ToolsToolStripMenuItem });
            MenuStrip1.Location = new Point(0, 0);
            MenuStrip1.Name = "MenuStrip1";
            MenuStrip1.Size = new Size(842, 24);
            MenuStrip1.TabIndex = 13;
            MenuStrip1.Text = "MenuStrip1";
            // 
            // ToolsToolStripMenuItem
            // 
            ToolsToolStripMenuItem.DropDownItems.AddRange(new ToolStripItem[] { _WindowsSchedulerToolStripMenuItem, _ApplicationExecutionPathToolStripMenuItem, _CommandExecutionDirectoryToolStripMenuItem });
            ToolsToolStripMenuItem.Name = "ToolsToolStripMenuItem";
            ToolsToolStripMenuItem.Size = new Size(48, 20);
            ToolsToolStripMenuItem.Text = "Tools";
            // 
            // WindowsSchedulerToolStripMenuItem
            // 
            _WindowsSchedulerToolStripMenuItem.Name = "_WindowsSchedulerToolStripMenuItem";
            _WindowsSchedulerToolStripMenuItem.Size = new Size(236, 22);
            _WindowsSchedulerToolStripMenuItem.Text = "Windows Scheduler";
            // 
            // ApplicationExecutionPathToolStripMenuItem
            // 
            _ApplicationExecutionPathToolStripMenuItem.Name = "_ApplicationExecutionPathToolStripMenuItem";
            _ApplicationExecutionPathToolStripMenuItem.Size = new Size(236, 22);
            _ApplicationExecutionPathToolStripMenuItem.Text = "Application Execution path";
            // 
            // Label3
            // 
            Label3.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            Label3.AutoSize = true;
            Label3.Location = new Point(325, 371);
            Label3.Name = "Label3";
            Label3.Size = new Size(64, 13);
            Label3.TabIndex = 15;
            Label3.Text = "Day to Run:";
            // 
            // cbDayToRun
            // 
            cbDayToRun.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            cbDayToRun.FormattingEnabled = true;
            cbDayToRun.Items.AddRange(new object[] { "HOURLY", "DAILY", "WEEKLY, ", "MONTHLY", "ONCE" });
            cbDayToRun.Location = new Point(325, 387);
            cbDayToRun.Name = "cbDayToRun";
            cbDayToRun.Size = new Size(144, 21);
            cbDayToRun.TabIndex = 14;
            // 
            // dtStart
            // 
            dtStart.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            dtStart.Location = new Point(546, 387);
            dtStart.Name = "dtStart";
            dtStart.Size = new Size(186, 20);
            dtStart.TabIndex = 16;
            // 
            // btnDisableArchive
            // 
            _btnDisableArchive.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            _btnDisableArchive.Location = new Point(538, 461);
            _btnDisableArchive.Name = "_btnDisableArchive";
            _btnDisableArchive.Size = new Size(85, 60);
            _btnDisableArchive.TabIndex = 17;
            _btnDisableArchive.Text = "Disable Archive";
            _btnDisableArchive.UseVisualStyleBackColor = true;
            // 
            // btnEnableArchive
            // 
            _btnEnableArchive.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            _btnEnableArchive.Location = new Point(435, 461);
            _btnEnableArchive.Name = "_btnEnableArchive";
            _btnEnableArchive.Size = new Size(85, 60);
            _btnEnableArchive.TabIndex = 18;
            _btnEnableArchive.Text = "Enable Archive";
            _btnEnableArchive.UseVisualStyleBackColor = true;
            // 
            // ckAll
            // 
            ckAll.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            ckAll.AutoSize = true;
            ckAll.Location = new Point(9, 426);
            ckAll.Name = "ckAll";
            ckAll.Size = new Size(84, 17);
            ckAll.TabIndex = 19;
            ckAll.Text = "Archive ALL";
            ckAll.UseVisualStyleBackColor = true;
            // 
            // ckFiles
            // 
            ckFiles.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            ckFiles.AutoSize = true;
            ckFiles.Location = new Point(9, 449);
            ckFiles.Name = "ckFiles";
            ckFiles.Size = new Size(79, 17);
            ckFiles.TabIndex = 20;
            ckFiles.Text = "File Folders";
            ckFiles.UseVisualStyleBackColor = true;
            // 
            // ckOutlook
            // 
            ckOutlook.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            ckOutlook.AutoSize = true;
            ckOutlook.Location = new Point(9, 472);
            ckOutlook.Name = "ckOutlook";
            ckOutlook.Size = new Size(100, 17);
            ckOutlook.TabIndex = 21;
            ckOutlook.Text = "Outlook Folders";
            ckOutlook.UseVisualStyleBackColor = true;
            // 
            // ckExchange
            // 
            ckExchange.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            ckExchange.AutoSize = true;
            ckExchange.Location = new Point(9, 495);
            ckExchange.Name = "ckExchange";
            ckExchange.Size = new Size(113, 17);
            ckExchange.TabIndex = 22;
            ckExchange.Text = "Exchange Servers";
            ckExchange.UseVisualStyleBackColor = true;
            // 
            // cbTod
            // 
            cbTod.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            cbTod.FormattingEnabled = true;
            cbTod.Items.AddRange(new object[] { "HOURLY", "DAILY", "WEEKLY, ", "MONTHLY", "ONCE" });
            cbTod.Location = new Point(475, 386);
            cbTod.Name = "cbTod";
            cbTod.Size = new Size(65, 21);
            cbTod.TabIndex = 23;
            // 
            // Label4
            // 
            Label4.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            Label4.AutoSize = true;
            Label4.Location = new Point(472, 371);
            Label4.Name = "Label4";
            Label4.Size = new Size(68, 13);
            Label4.TabIndex = 24;
            Label4.Text = "Time to Run:";
            // 
            // Label5
            // 
            Label5.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            Label5.AutoSize = true;
            Label5.Location = new Point(143, 426);
            Label5.Name = "Label5";
            Label5.Size = new Size(126, 13);
            Label5.TabIndex = 25;
            Label5.Text = "Run as USER (Login ID):";
            // 
            // txtUser
            // 
            txtUser.Location = new Point(274, 424);
            txtUser.Name = "txtUser";
            txtUser.Size = new Size(266, 20);
            txtUser.TabIndex = 26;
            // 
            // btnValidate
            // 
            _btnValidate.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            _btnValidate.Location = new Point(237, 461);
            _btnValidate.Name = "_btnValidate";
            _btnValidate.Size = new Size(85, 60);
            _btnValidate.TabIndex = 27;
            _btnValidate.Text = "Validate All ECM Schedules";
            _btnValidate.UseVisualStyleBackColor = true;
            // 
            // ckShowAll
            // 
            _ckShowAll.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            _ckShowAll.AutoSize = true;
            _ckShowAll.Location = new Point(12, 371);
            _ckShowAll.Name = "_ckShowAll";
            _ckShowAll.Size = new Size(120, 17);
            _ckShowAll.TabIndex = 28;
            _ckShowAll.Text = "Show All Schedules";
            _ckShowAll.UseVisualStyleBackColor = true;
            // 
            // ckClipboardCommad
            // 
            ckClipboardCommad.AutoSize = true;
            ckClipboardCommad.Location = new Point(564, 427);
            ckClipboardCommad.Name = "ckClipboardCommad";
            ckClipboardCommad.Size = new Size(160, 17);
            ckClipboardCommad.TabIndex = 29;
            ckClipboardCommad.Text = "Save Command to Clipboard";
            ckClipboardCommad.UseVisualStyleBackColor = true;
            // 
            // CommandExecutionDirectoryToolStripMenuItem
            // 
            _CommandExecutionDirectoryToolStripMenuItem.Name = "_CommandExecutionDirectoryToolStripMenuItem";
            _CommandExecutionDirectoryToolStripMenuItem.Size = new Size(236, 22);
            _CommandExecutionDirectoryToolStripMenuItem.Text = "Command Execution Directory";
            // 
            // frmSchedule
            // 
            AutoScaleDimensions = new SizeF(6.0f, 13.0f);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(842, 556);
            Controls.Add(ckClipboardCommad);
            Controls.Add(_ckShowAll);
            Controls.Add(_btnValidate);
            Controls.Add(txtUser);
            Controls.Add(Label5);
            Controls.Add(Label4);
            Controls.Add(cbTod);
            Controls.Add(ckExchange);
            Controls.Add(ckOutlook);
            Controls.Add(ckFiles);
            Controls.Add(ckAll);
            Controls.Add(_btnEnableArchive);
            Controls.Add(_btnDisableArchive);
            Controls.Add(dtStart);
            Controls.Add(Label3);
            Controls.Add(cbDayToRun);
            Controls.Add(StatusBar);
            Controls.Add(MenuStrip1);
            Controls.Add(_btnAdd);
            Controls.Add(_btnUpdate);
            Controls.Add(Label2);
            Controls.Add(Label1);
            Controls.Add(_cbScheduleUnits);
            Controls.Add(lblScheduleType);
            Controls.Add(_btnDelete);
            Controls.Add(_btnDisplaySchedules);
            Controls.Add(_dgSchedule);
            MainMenuStrip = MenuStrip1;
            Name = "frmSchedule";
            Text = "ECM Archive Scheduler           (frmSchedule)";
            ((System.ComponentModel.ISupportInitialize)_dgSchedule).EndInit();
            StatusBar.ResumeLayout(false);
            StatusBar.PerformLayout();
            MenuStrip1.ResumeLayout(false);
            MenuStrip1.PerformLayout();
            ResumeLayout(false);
            PerformLayout();
        }

        private DataGridView _dgSchedule;

        internal DataGridView dgSchedule
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _dgSchedule;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_dgSchedule != null)
                {
                    _dgSchedule.CellContentClick -= dgSchedule_CellContentClick;
                    _dgSchedule.SelectionChanged -= dgSchedule_SelectionChanged;
                }

                _dgSchedule = value;
                if (_dgSchedule != null)
                {
                    _dgSchedule.CellContentClick += dgSchedule_CellContentClick;
                    _dgSchedule.SelectionChanged += dgSchedule_SelectionChanged;
                }
            }
        }

        private Button _btnDisplaySchedules;

        internal Button btnDisplaySchedules
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnDisplaySchedules;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnDisplaySchedules != null)
                {
                    _btnDisplaySchedules.Click -= btnDisplaySchedules_Click;
                }

                _btnDisplaySchedules = value;
                if (_btnDisplaySchedules != null)
                {
                    _btnDisplaySchedules.Click += btnDisplaySchedules_Click;
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

        internal ToolTip TT;
        internal Label lblScheduleType;
        private ComboBox _cbScheduleUnits;

        internal ComboBox cbScheduleUnits
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _cbScheduleUnits;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_cbScheduleUnits != null)
                {
                    _cbScheduleUnits.SelectedIndexChanged -= cbScheduleUnits_SelectedIndexChanged;
                }

                _cbScheduleUnits = value;
                if (_cbScheduleUnits != null)
                {
                    _cbScheduleUnits.SelectedIndexChanged += cbScheduleUnits_SelectedIndexChanged;
                }
            }
        }

        internal Label Label1;
        internal Label Label2;
        private Button _btnUpdate;

        internal Button btnUpdate
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnUpdate;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnUpdate != null)
                {
                    _btnUpdate.Click -= btnUpdate_Click;
                }

                _btnUpdate = value;
                if (_btnUpdate != null)
                {
                    _btnUpdate.Click += btnUpdate_Click;
                }
            }
        }

        private Button _btnAdd;

        internal Button btnAdd
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnAdd;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnAdd != null)
                {
                    _btnAdd.Click -= btnAdd_Click;
                }

                _btnAdd = value;
                if (_btnAdd != null)
                {
                    _btnAdd.Click += btnAdd_Click;
                }
            }
        }

        internal StatusStrip StatusBar;
        internal ToolStripStatusLabel SB;
        internal MenuStrip MenuStrip1;
        internal ToolStripMenuItem ToolsToolStripMenuItem;
        private ToolStripMenuItem _WindowsSchedulerToolStripMenuItem;

        internal ToolStripMenuItem WindowsSchedulerToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _WindowsSchedulerToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_WindowsSchedulerToolStripMenuItem != null)
                {
                    _WindowsSchedulerToolStripMenuItem.Click -= WindowsSchedulerToolStripMenuItem_Click;
                }

                _WindowsSchedulerToolStripMenuItem = value;
                if (_WindowsSchedulerToolStripMenuItem != null)
                {
                    _WindowsSchedulerToolStripMenuItem.Click += WindowsSchedulerToolStripMenuItem_Click;
                }
            }
        }

        private ToolStripMenuItem _ApplicationExecutionPathToolStripMenuItem;

        internal ToolStripMenuItem ApplicationExecutionPathToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ApplicationExecutionPathToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ApplicationExecutionPathToolStripMenuItem != null)
                {
                    _ApplicationExecutionPathToolStripMenuItem.Click -= ApplicationExecutionPathToolStripMenuItem_Click;
                }

                _ApplicationExecutionPathToolStripMenuItem = value;
                if (_ApplicationExecutionPathToolStripMenuItem != null)
                {
                    _ApplicationExecutionPathToolStripMenuItem.Click += ApplicationExecutionPathToolStripMenuItem_Click;
                }
            }
        }

        internal Label Label3;
        internal ComboBox cbDayToRun;
        internal ToolStripStatusLabel SB2;
        internal DateTimePicker dtStart;
        private Button _btnDisableArchive;

        internal Button btnDisableArchive
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnDisableArchive;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnDisableArchive != null)
                {
                    _btnDisableArchive.Click -= btnDisableArchive_Click;
                }

                _btnDisableArchive = value;
                if (_btnDisableArchive != null)
                {
                    _btnDisableArchive.Click += btnDisableArchive_Click;
                }
            }
        }

        private Button _btnEnableArchive;

        internal Button btnEnableArchive
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnEnableArchive;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnEnableArchive != null)
                {
                    _btnEnableArchive.Click -= btnEnableArchive_Click;
                }

                _btnEnableArchive = value;
                if (_btnEnableArchive != null)
                {
                    _btnEnableArchive.Click += btnEnableArchive_Click;
                }
            }
        }

        internal CheckBox ckAll;
        internal CheckBox ckFiles;
        internal CheckBox ckOutlook;
        internal CheckBox ckExchange;
        internal ToolStripStatusLabel SelectedTaskName;
        internal ComboBox cbTod;
        internal Label Label4;
        internal Label Label5;
        internal TextBox txtUser;
        private Button _btnValidate;

        internal Button btnValidate
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnValidate;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnValidate != null)
                {
                    _btnValidate.Click -= btnValidate_Click;
                }

                _btnValidate = value;
                if (_btnValidate != null)
                {
                    _btnValidate.Click += btnValidate_Click;
                }
            }
        }

        private CheckBox _ckShowAll;

        internal CheckBox ckShowAll
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ckShowAll;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ckShowAll != null)
                {
                    _ckShowAll.CheckedChanged -= ckShowAll_CheckedChanged;
                }

                _ckShowAll = value;
                if (_ckShowAll != null)
                {
                    _ckShowAll.CheckedChanged += ckShowAll_CheckedChanged;
                }
            }
        }

        internal CheckBox ckClipboardCommad;
        private ToolStripMenuItem _CommandExecutionDirectoryToolStripMenuItem;

        internal ToolStripMenuItem CommandExecutionDirectoryToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _CommandExecutionDirectoryToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_CommandExecutionDirectoryToolStripMenuItem != null)
                {
                    _CommandExecutionDirectoryToolStripMenuItem.Click -= CommandExecutionDirectoryToolStripMenuItem_Click;
                }

                _CommandExecutionDirectoryToolStripMenuItem = value;
                if (_CommandExecutionDirectoryToolStripMenuItem != null)
                {
                    _CommandExecutionDirectoryToolStripMenuItem.Click += CommandExecutionDirectoryToolStripMenuItem_Click;
                }
            }
        }
    }
}