// VBConversions Note: VB project level imports
using System.Collections.Generic;
using System;
using System.Drawing;
using System.Linq;
using System.Diagnostics;
using System.Data;
using Microsoft.VisualBasic;
using MODI;
using System.Xml.Linq;
using System.Collections;
using System.Windows.Forms;
// End of VB project level imports


namespace EcmArchiveClcSetup
{
	[global::Microsoft.VisualBasic.CompilerServices.DesignerGenerated()]public partial class frmSchedule : System.Windows.Forms.Form
	{
		
		//Form overrides dispose to clean up the component list.
		[System.Diagnostics.DebuggerNonUserCode()]protected override void Dispose(bool disposing)
		{
			try
			{
				if (disposing && components != null)
				{
					components.Dispose();
				}
			}
			finally
			{
				base.Dispose(disposing);
			}
		}
		
		//Required by the Windows Form Designer
		private System.ComponentModel.Container components = null;
		
		//NOTE: The following procedure is required by the Windows Form Designer
		//It can be modified using the Windows Form Designer.
		//Do not modify it using the code editor.
		[System.Diagnostics.DebuggerStepThrough()]private void InitializeComponent()
		{
			this.components = new System.ComponentModel.Container();
			System.Windows.Forms.DataGridViewCellStyle DataGridViewCellStyle1 = new System.Windows.Forms.DataGridViewCellStyle();
			System.Windows.Forms.DataGridViewCellStyle DataGridViewCellStyle2 = new System.Windows.Forms.DataGridViewCellStyle();
			System.Windows.Forms.DataGridViewCellStyle DataGridViewCellStyle3 = new System.Windows.Forms.DataGridViewCellStyle();
			this.dgSchedule = new System.Windows.Forms.DataGridView();
			this.dgSchedule.CellContentClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgSchedule_CellContentClick);
			this.dgSchedule.SelectionChanged += new System.EventHandler(this.dgSchedule_SelectionChanged);
			this.btnDisplaySchedules = new System.Windows.Forms.Button();
			this.btnDisplaySchedules.Click += new System.EventHandler(this.btnDisplaySchedules_Click);
			this.btnDelete = new System.Windows.Forms.Button();
			this.btnDelete.Click += new System.EventHandler(this.btnDelete_Click);
			this.TT = new System.Windows.Forms.ToolTip(this.components);
			this.lblScheduleType = new System.Windows.Forms.Label();
			this.cbScheduleUnits = new System.Windows.Forms.ComboBox();
			this.cbScheduleUnits.SelectedIndexChanged += new System.EventHandler(this.cbScheduleUnits_SelectedIndexChanged);
			this.Label1 = new System.Windows.Forms.Label();
			this.Label2 = new System.Windows.Forms.Label();
			this.btnUpdate = new System.Windows.Forms.Button();
			this.btnUpdate.Click += new System.EventHandler(this.btnUpdate_Click);
			this.btnAdd = new System.Windows.Forms.Button();
			this.btnAdd.Click += new System.EventHandler(this.btnAdd_Click);
			this.StatusBar = new System.Windows.Forms.StatusStrip();
			this.SB = new System.Windows.Forms.ToolStripStatusLabel();
			this.SB2 = new System.Windows.Forms.ToolStripStatusLabel();
			this.SelectedTaskName = new System.Windows.Forms.ToolStripStatusLabel();
			this.MenuStrip1 = new System.Windows.Forms.MenuStrip();
			this.ToolsToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.WindowsSchedulerToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.WindowsSchedulerToolStripMenuItem.Click += new System.EventHandler(this.WindowsSchedulerToolStripMenuItem_Click);
			this.ApplicationExecutionPathToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.ApplicationExecutionPathToolStripMenuItem.Click += new System.EventHandler(this.ApplicationExecutionPathToolStripMenuItem_Click);
			this.Label3 = new System.Windows.Forms.Label();
			this.cbDayToRun = new System.Windows.Forms.ComboBox();
			this.dtStart = new System.Windows.Forms.DateTimePicker();
			this.btnDisableArchive = new System.Windows.Forms.Button();
			this.btnDisableArchive.Click += new System.EventHandler(this.btnDisableArchive_Click);
			this.btnEnableArchive = new System.Windows.Forms.Button();
			this.btnEnableArchive.Click += new System.EventHandler(this.btnEnableArchive_Click);
			this.ckAll = new System.Windows.Forms.CheckBox();
			this.ckFiles = new System.Windows.Forms.CheckBox();
			this.ckOutlook = new System.Windows.Forms.CheckBox();
			this.ckExchange = new System.Windows.Forms.CheckBox();
			this.cbTod = new System.Windows.Forms.ComboBox();
			this.Label4 = new System.Windows.Forms.Label();
			this.Label5 = new System.Windows.Forms.Label();
			this.txtUser = new System.Windows.Forms.TextBox();
			this.btnValidate = new System.Windows.Forms.Button();
			this.btnValidate.Click += new System.EventHandler(this.btnValidate_Click);
			this.ckShowAll = new System.Windows.Forms.CheckBox();
			this.ckShowAll.CheckedChanged += new System.EventHandler(this.ckShowAll_CheckedChanged);
			this.ckClipboardCommad = new System.Windows.Forms.CheckBox();
			this.CommandExecutionDirectoryToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.CommandExecutionDirectoryToolStripMenuItem.Click += new System.EventHandler(this.CommandExecutionDirectoryToolStripMenuItem_Click);
			((System.ComponentModel.ISupportInitialize) this.dgSchedule).BeginInit();
			this.StatusBar.SuspendLayout();
			this.MenuStrip1.SuspendLayout();
			this.SuspendLayout();
			//
			//dgSchedule
			//
			this.dgSchedule.Anchor = (System.Windows.Forms.AnchorStyles) (((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right);
			DataGridViewCellStyle1.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
			DataGridViewCellStyle1.BackColor = System.Drawing.SystemColors.Control;
			DataGridViewCellStyle1.Font = new System.Drawing.Font("Microsoft Sans Serif", (float) (8.25F), System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, (byte) (0));
			DataGridViewCellStyle1.ForeColor = System.Drawing.SystemColors.WindowText;
			DataGridViewCellStyle1.SelectionBackColor = System.Drawing.SystemColors.Highlight;
			DataGridViewCellStyle1.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
			DataGridViewCellStyle1.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
			this.dgSchedule.ColumnHeadersDefaultCellStyle = DataGridViewCellStyle1;
			this.dgSchedule.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
			DataGridViewCellStyle2.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
			DataGridViewCellStyle2.BackColor = System.Drawing.SystemColors.Window;
			DataGridViewCellStyle2.Font = new System.Drawing.Font("Microsoft Sans Serif", (float) (8.25F), System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, (byte) (0));
			DataGridViewCellStyle2.ForeColor = System.Drawing.SystemColors.ControlText;
			DataGridViewCellStyle2.SelectionBackColor = System.Drawing.SystemColors.Highlight;
			DataGridViewCellStyle2.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
			DataGridViewCellStyle2.WrapMode = System.Windows.Forms.DataGridViewTriState.False;
			this.dgSchedule.DefaultCellStyle = DataGridViewCellStyle2;
			this.dgSchedule.Location = new System.Drawing.Point(12, 30);
			this.dgSchedule.Name = "dgSchedule";
			DataGridViewCellStyle3.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
			DataGridViewCellStyle3.BackColor = System.Drawing.SystemColors.Control;
			DataGridViewCellStyle3.Font = new System.Drawing.Font("Microsoft Sans Serif", (float) (8.25F), System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, (byte) (0));
			DataGridViewCellStyle3.ForeColor = System.Drawing.SystemColors.WindowText;
			DataGridViewCellStyle3.SelectionBackColor = System.Drawing.SystemColors.Highlight;
			DataGridViewCellStyle3.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
			DataGridViewCellStyle3.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
			this.dgSchedule.RowHeadersDefaultCellStyle = DataGridViewCellStyle3;
			this.dgSchedule.Size = new System.Drawing.Size(818, 338);
			this.dgSchedule.TabIndex = 0;
			//
			//btnDisplaySchedules
			//
			this.btnDisplaySchedules.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.btnDisplaySchedules.Location = new System.Drawing.Point(146, 461);
			this.btnDisplaySchedules.Name = "btnDisplaySchedules";
			this.btnDisplaySchedules.Size = new System.Drawing.Size(85, 60);
			this.btnDisplaySchedules.TabIndex = 1;
			this.btnDisplaySchedules.Text = "Display Scheduled Items";
			this.btnDisplaySchedules.UseVisualStyleBackColor = true;
			//
			//btnDelete
			//
			this.btnDelete.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.btnDelete.Location = new System.Drawing.Point(344, 461);
			this.btnDelete.Name = "btnDelete";
			this.btnDelete.Size = new System.Drawing.Size(85, 60);
			this.btnDelete.TabIndex = 2;
			this.btnDelete.Text = "Delete Selected Task";
			this.btnDelete.UseVisualStyleBackColor = true;
			//
			//lblScheduleType
			//
			this.lblScheduleType.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.lblScheduleType.AutoSize = true;
			this.lblScheduleType.Font = new System.Drawing.Font("Microsoft Sans Serif", (float) (8.25F), System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, (byte) (0));
			this.lblScheduleType.Location = new System.Drawing.Point(6, 410);
			this.lblScheduleType.Name = "lblScheduleType";
			this.lblScheduleType.Size = new System.Drawing.Size(139, 13);
			this.lblScheduleType.TabIndex = 4;
			this.lblScheduleType.Text = "Select what to archive:";
			//
			//cbScheduleUnits
			//
			this.cbScheduleUnits.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.cbScheduleUnits.FormattingEnabled = true;
			this.cbScheduleUnits.Items.AddRange(new object[] {"HOURLY", "DAILY", "WEEKLY", "MONTHLY"});
			this.cbScheduleUnits.Location = new System.Drawing.Point(143, 387);
			this.cbScheduleUnits.Name = "cbScheduleUnits";
			this.cbScheduleUnits.Size = new System.Drawing.Size(169, 21);
			this.cbScheduleUnits.TabIndex = 5;
			//
			//Label1
			//
			this.Label1.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.Label1.AutoSize = true;
			this.Label1.Location = new System.Drawing.Point(143, 371);
			this.Label1.Name = "Label1";
			this.Label1.Size = new System.Drawing.Size(133, 13);
			this.Label1.TabIndex = 6;
			this.Label1.Text = "Choose When To Archive:";
			//
			//Label2
			//
			this.Label2.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.Label2.AutoSize = true;
			this.Label2.Location = new System.Drawing.Point(674, 371);
			this.Label2.Name = "Label2";
			this.Label2.Size = new System.Drawing.Size(58, 13);
			this.Label2.TabIndex = 7;
			this.Label2.Text = "Start Time:";
			//
			//btnUpdate
			//
			this.btnUpdate.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.btnUpdate.Location = new System.Drawing.Point(629, 461);
			this.btnUpdate.Name = "btnUpdate";
			this.btnUpdate.Size = new System.Drawing.Size(85, 60);
			this.btnUpdate.TabIndex = 10;
			this.btnUpdate.Text = "Update Selected Task";
			this.btnUpdate.UseVisualStyleBackColor = true;
			//
			//btnAdd
			//
			this.btnAdd.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.btnAdd.Location = new System.Drawing.Point(744, 461);
			this.btnAdd.Name = "btnAdd";
			this.btnAdd.Size = new System.Drawing.Size(85, 60);
			this.btnAdd.TabIndex = 11;
			this.btnAdd.Text = "Add New Selected Task";
			this.btnAdd.UseVisualStyleBackColor = true;
			//
			//StatusBar
			//
			this.StatusBar.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {this.SB, this.SB2, this.SelectedTaskName});
			this.StatusBar.Location = new System.Drawing.Point(0, 534);
			this.StatusBar.Name = "StatusBar";
			this.StatusBar.Size = new System.Drawing.Size(842, 22);
			this.StatusBar.TabIndex = 12;
			//
			//SB
			//
			this.SB.Name = "SB";
			this.SB.Size = new System.Drawing.Size(105, 17);
			this.SB.Text = "Archiver Messages";
			//
			//SB2
			//
			this.SB2.Name = "SB2";
			this.SB2.Size = new System.Drawing.Size(61, 17);
			this.SB2.Text = "Statement";
			//
			//SelectedTaskName
			//
			this.SelectedTaskName.Name = "SelectedTaskName";
			this.SelectedTaskName.Size = new System.Drawing.Size(66, 17);
			this.SelectedTaskName.Text = "Task Name";
			//
			//MenuStrip1
			//
			this.MenuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {this.ToolsToolStripMenuItem});
			this.MenuStrip1.Location = new System.Drawing.Point(0, 0);
			this.MenuStrip1.Name = "MenuStrip1";
			this.MenuStrip1.Size = new System.Drawing.Size(842, 24);
			this.MenuStrip1.TabIndex = 13;
			this.MenuStrip1.Text = "MenuStrip1";
			//
			//ToolsToolStripMenuItem
			//
			this.ToolsToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {this.WindowsSchedulerToolStripMenuItem, this.ApplicationExecutionPathToolStripMenuItem, this.CommandExecutionDirectoryToolStripMenuItem});
			this.ToolsToolStripMenuItem.Name = "ToolsToolStripMenuItem";
			this.ToolsToolStripMenuItem.Size = new System.Drawing.Size(48, 20);
			this.ToolsToolStripMenuItem.Text = "Tools";
			//
			//WindowsSchedulerToolStripMenuItem
			//
			this.WindowsSchedulerToolStripMenuItem.Name = "WindowsSchedulerToolStripMenuItem";
			this.WindowsSchedulerToolStripMenuItem.Size = new System.Drawing.Size(236, 22);
			this.WindowsSchedulerToolStripMenuItem.Text = "Windows Scheduler";
			//
			//ApplicationExecutionPathToolStripMenuItem
			//
			this.ApplicationExecutionPathToolStripMenuItem.Name = "ApplicationExecutionPathToolStripMenuItem";
			this.ApplicationExecutionPathToolStripMenuItem.Size = new System.Drawing.Size(236, 22);
			this.ApplicationExecutionPathToolStripMenuItem.Text = "Application Execution path";
			//
			//Label3
			//
			this.Label3.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.Label3.AutoSize = true;
			this.Label3.Location = new System.Drawing.Point(325, 371);
			this.Label3.Name = "Label3";
			this.Label3.Size = new System.Drawing.Size(64, 13);
			this.Label3.TabIndex = 15;
			this.Label3.Text = "Day to Run:";
			//
			//cbDayToRun
			//
			this.cbDayToRun.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.cbDayToRun.FormattingEnabled = true;
			this.cbDayToRun.Items.AddRange(new object[] {"HOURLY", "DAILY", "WEEKLY, ", "MONTHLY", "ONCE"});
			this.cbDayToRun.Location = new System.Drawing.Point(325, 387);
			this.cbDayToRun.Name = "cbDayToRun";
			this.cbDayToRun.Size = new System.Drawing.Size(144, 21);
			this.cbDayToRun.TabIndex = 14;
			//
			//dtStart
			//
			this.dtStart.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.dtStart.Location = new System.Drawing.Point(546, 387);
			this.dtStart.Name = "dtStart";
			this.dtStart.Size = new System.Drawing.Size(186, 20);
			this.dtStart.TabIndex = 16;
			//
			//btnDisableArchive
			//
			this.btnDisableArchive.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.btnDisableArchive.Location = new System.Drawing.Point(538, 461);
			this.btnDisableArchive.Name = "btnDisableArchive";
			this.btnDisableArchive.Size = new System.Drawing.Size(85, 60);
			this.btnDisableArchive.TabIndex = 17;
			this.btnDisableArchive.Text = "Disable Archive";
			this.btnDisableArchive.UseVisualStyleBackColor = true;
			//
			//btnEnableArchive
			//
			this.btnEnableArchive.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.btnEnableArchive.Location = new System.Drawing.Point(435, 461);
			this.btnEnableArchive.Name = "btnEnableArchive";
			this.btnEnableArchive.Size = new System.Drawing.Size(85, 60);
			this.btnEnableArchive.TabIndex = 18;
			this.btnEnableArchive.Text = "Enable Archive";
			this.btnEnableArchive.UseVisualStyleBackColor = true;
			//
			//ckAll
			//
			this.ckAll.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.ckAll.AutoSize = true;
			this.ckAll.Location = new System.Drawing.Point(9, 426);
			this.ckAll.Name = "ckAll";
			this.ckAll.Size = new System.Drawing.Size(84, 17);
			this.ckAll.TabIndex = 19;
			this.ckAll.Text = "Archive ALL";
			this.ckAll.UseVisualStyleBackColor = true;
			//
			//ckFiles
			//
			this.ckFiles.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.ckFiles.AutoSize = true;
			this.ckFiles.Location = new System.Drawing.Point(9, 449);
			this.ckFiles.Name = "ckFiles";
			this.ckFiles.Size = new System.Drawing.Size(79, 17);
			this.ckFiles.TabIndex = 20;
			this.ckFiles.Text = "File Folders";
			this.ckFiles.UseVisualStyleBackColor = true;
			//
			//ckOutlook
			//
			this.ckOutlook.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.ckOutlook.AutoSize = true;
			this.ckOutlook.Location = new System.Drawing.Point(9, 472);
			this.ckOutlook.Name = "ckOutlook";
			this.ckOutlook.Size = new System.Drawing.Size(100, 17);
			this.ckOutlook.TabIndex = 21;
			this.ckOutlook.Text = "Outlook Folders";
			this.ckOutlook.UseVisualStyleBackColor = true;
			//
			//ckExchange
			//
			this.ckExchange.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.ckExchange.AutoSize = true;
			this.ckExchange.Location = new System.Drawing.Point(9, 495);
			this.ckExchange.Name = "ckExchange";
			this.ckExchange.Size = new System.Drawing.Size(113, 17);
			this.ckExchange.TabIndex = 22;
			this.ckExchange.Text = "Exchange Servers";
			this.ckExchange.UseVisualStyleBackColor = true;
			//
			//cbTod
			//
			this.cbTod.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.cbTod.FormattingEnabled = true;
			this.cbTod.Items.AddRange(new object[] {"HOURLY", "DAILY", "WEEKLY, ", "MONTHLY", "ONCE"});
			this.cbTod.Location = new System.Drawing.Point(475, 386);
			this.cbTod.Name = "cbTod";
			this.cbTod.Size = new System.Drawing.Size(65, 21);
			this.cbTod.TabIndex = 23;
			//
			//Label4
			//
			this.Label4.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.Label4.AutoSize = true;
			this.Label4.Location = new System.Drawing.Point(472, 371);
			this.Label4.Name = "Label4";
			this.Label4.Size = new System.Drawing.Size(68, 13);
			this.Label4.TabIndex = 24;
			this.Label4.Text = "Time to Run:";
			//
			//Label5
			//
			this.Label5.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.Label5.AutoSize = true;
			this.Label5.Location = new System.Drawing.Point(143, 426);
			this.Label5.Name = "Label5";
			this.Label5.Size = new System.Drawing.Size(126, 13);
			this.Label5.TabIndex = 25;
			this.Label5.Text = "Run as USER (Login ID):";
			//
			//txtUser
			//
			this.txtUser.Location = new System.Drawing.Point(274, 424);
			this.txtUser.Name = "txtUser";
			this.txtUser.Size = new System.Drawing.Size(266, 20);
			this.txtUser.TabIndex = 26;
			//
			//btnValidate
			//
			this.btnValidate.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.btnValidate.Location = new System.Drawing.Point(237, 461);
			this.btnValidate.Name = "btnValidate";
			this.btnValidate.Size = new System.Drawing.Size(85, 60);
			this.btnValidate.TabIndex = 27;
			this.btnValidate.Text = "Validate All ECM Schedules";
			this.btnValidate.UseVisualStyleBackColor = true;
			//
			//ckShowAll
			//
			this.ckShowAll.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left);
			this.ckShowAll.AutoSize = true;
			this.ckShowAll.Location = new System.Drawing.Point(12, 371);
			this.ckShowAll.Name = "ckShowAll";
			this.ckShowAll.Size = new System.Drawing.Size(120, 17);
			this.ckShowAll.TabIndex = 28;
			this.ckShowAll.Text = "Show All Schedules";
			this.ckShowAll.UseVisualStyleBackColor = true;
			//
			//ckClipboardCommad
			//
			this.ckClipboardCommad.AutoSize = true;
			this.ckClipboardCommad.Location = new System.Drawing.Point(564, 427);
			this.ckClipboardCommad.Name = "ckClipboardCommad";
			this.ckClipboardCommad.Size = new System.Drawing.Size(160, 17);
			this.ckClipboardCommad.TabIndex = 29;
			this.ckClipboardCommad.Text = "Save Command to Clipboard";
			this.ckClipboardCommad.UseVisualStyleBackColor = true;
			//
			//CommandExecutionDirectoryToolStripMenuItem
			//
			this.CommandExecutionDirectoryToolStripMenuItem.Name = "CommandExecutionDirectoryToolStripMenuItem";
			this.CommandExecutionDirectoryToolStripMenuItem.Size = new System.Drawing.Size(236, 22);
			this.CommandExecutionDirectoryToolStripMenuItem.Text = "Command Execution Directory";
			//
			//frmSchedule
			//
			this.AutoScaleDimensions = new System.Drawing.SizeF((float) (6.0F), (float) (13.0F));
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.ClientSize = new System.Drawing.Size(842, 556);
			this.Controls.Add(this.ckClipboardCommad);
			this.Controls.Add(this.ckShowAll);
			this.Controls.Add(this.btnValidate);
			this.Controls.Add(this.txtUser);
			this.Controls.Add(this.Label5);
			this.Controls.Add(this.Label4);
			this.Controls.Add(this.cbTod);
			this.Controls.Add(this.ckExchange);
			this.Controls.Add(this.ckOutlook);
			this.Controls.Add(this.ckFiles);
			this.Controls.Add(this.ckAll);
			this.Controls.Add(this.btnEnableArchive);
			this.Controls.Add(this.btnDisableArchive);
			this.Controls.Add(this.dtStart);
			this.Controls.Add(this.Label3);
			this.Controls.Add(this.cbDayToRun);
			this.Controls.Add(this.StatusBar);
			this.Controls.Add(this.MenuStrip1);
			this.Controls.Add(this.btnAdd);
			this.Controls.Add(this.btnUpdate);
			this.Controls.Add(this.Label2);
			this.Controls.Add(this.Label1);
			this.Controls.Add(this.cbScheduleUnits);
			this.Controls.Add(this.lblScheduleType);
			this.Controls.Add(this.btnDelete);
			this.Controls.Add(this.btnDisplaySchedules);
			this.Controls.Add(this.dgSchedule);
			this.MainMenuStrip = this.MenuStrip1;
			this.Name = "frmSchedule";
			this.Text = "ECM Archive Scheduler           (frmSchedule)";
			((System.ComponentModel.ISupportInitialize) this.dgSchedule).EndInit();
			this.StatusBar.ResumeLayout(false);
			this.StatusBar.PerformLayout();
			this.MenuStrip1.ResumeLayout(false);
			this.MenuStrip1.PerformLayout();
			this.ResumeLayout(false);
			this.PerformLayout();
			
		}
		internal System.Windows.Forms.DataGridView dgSchedule;
		internal System.Windows.Forms.Button btnDisplaySchedules;
		internal System.Windows.Forms.Button btnDelete;
		internal System.Windows.Forms.ToolTip TT;
		internal System.Windows.Forms.Label lblScheduleType;
		internal System.Windows.Forms.ComboBox cbScheduleUnits;
		internal System.Windows.Forms.Label Label1;
		internal System.Windows.Forms.Label Label2;
		internal System.Windows.Forms.Button btnUpdate;
		internal System.Windows.Forms.Button btnAdd;
		internal System.Windows.Forms.StatusStrip StatusBar;
		internal System.Windows.Forms.ToolStripStatusLabel SB;
		internal System.Windows.Forms.MenuStrip MenuStrip1;
		internal System.Windows.Forms.ToolStripMenuItem ToolsToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem WindowsSchedulerToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem ApplicationExecutionPathToolStripMenuItem;
		internal System.Windows.Forms.Label Label3;
		internal System.Windows.Forms.ComboBox cbDayToRun;
		internal System.Windows.Forms.ToolStripStatusLabel SB2;
		internal System.Windows.Forms.DateTimePicker dtStart;
		internal System.Windows.Forms.Button btnDisableArchive;
		internal System.Windows.Forms.Button btnEnableArchive;
		internal System.Windows.Forms.CheckBox ckAll;
		internal System.Windows.Forms.CheckBox ckFiles;
		internal System.Windows.Forms.CheckBox ckOutlook;
		internal System.Windows.Forms.CheckBox ckExchange;
		internal System.Windows.Forms.ToolStripStatusLabel SelectedTaskName;
		internal System.Windows.Forms.ComboBox cbTod;
		internal System.Windows.Forms.Label Label4;
		internal System.Windows.Forms.Label Label5;
		internal System.Windows.Forms.TextBox txtUser;
		internal System.Windows.Forms.Button btnValidate;
		internal System.Windows.Forms.CheckBox ckShowAll;
		internal System.Windows.Forms.CheckBox ckClipboardCommad;
		internal System.Windows.Forms.ToolStripMenuItem CommandExecutionDirectoryToolStripMenuItem;
	}
	
}
