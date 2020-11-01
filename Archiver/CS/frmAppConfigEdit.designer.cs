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
	[global::Microsoft.VisualBasic.CompilerServices.DesignerGenerated()]public partial class frmAppConfigEdit : System.Windows.Forms.Form
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
			System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(frmAppConfigEdit));
			this.SB = new System.Windows.Forms.TextBox();
			this.ckHive = new System.Windows.Forms.CheckBox();
			this.btnHiveUpdate = new System.Windows.Forms.Button();
			this.btnTestHiveConn = new System.Windows.Forms.Button();
			this.Label6 = new System.Windows.Forms.Label();
			this.txtDBName = new System.Windows.Forms.TextBox();
			this.txtServerInstance = new System.Windows.Forms.TextBox();
			this.Label7 = new System.Windows.Forms.Label();
			this.ckWindowsAuthentication = new System.Windows.Forms.CheckBox();
			this.ckWindowsAuthentication.CheckedChanged += new System.EventHandler(this.ckWindowsAuthentication_CheckedChanged);
			this.txtPw1 = new System.Windows.Forms.TextBox();
			this.Label8 = new System.Windows.Forms.Label();
			this.txtLoginName = new System.Windows.Forms.TextBox();
			this.Label9 = new System.Windows.Forms.Label();
			this.txtPw2 = new System.Windows.Forms.TextBox();
			this.Label10 = new System.Windows.Forms.Label();
			this.Label11 = new System.Windows.Forms.Label();
			this.cbSavedDefinitions = new System.Windows.Forms.ComboBox();
			this.cbSavedDefinitions.TextChanged += new System.EventHandler(this.cbSavedDefinitions_TextChanged);
			this.btnTestConnection = new System.Windows.Forms.Button();
			this.btnTestConnection.Click += new System.EventHandler(this.btnTestConnection_Click);
			this.btnSaveConn = new System.Windows.Forms.Button();
			this.btnSaveConn.Click += new System.EventHandler(this.btnSaveConn_Click);
			this.Button7 = new System.Windows.Forms.Button();
			this.Button7.Click += new System.EventHandler(this.Button7_Click);
			this.txtGlobalFileDirectory = new System.Windows.Forms.TextBox();
			this.TT = new System.Windows.Forms.ToolTip(this.components);
			this.Button1 = new System.Windows.Forms.Button();
			this.Button1.Click += new System.EventHandler(this.Button1_Click);
			this.Button2 = new System.Windows.Forms.Button();
			this.Button2.Click += new System.EventHandler(this.Button2_Click);
			this.txtRepositoryName = new System.Windows.Forms.TextBox();
			this.btnResetGlobalLocationToDefault = new System.Windows.Forms.Button();
			this.btnResetGlobalLocationToDefault.Click += new System.EventHandler(this.btnResetGlobalLocationToDefault_Click);
			this.btnLoadCombo = new System.Windows.Forms.Button();
			this.btnLoadCombo.Click += new System.EventHandler(this.btnLoadCombo_Click);
			this.btnLoadData = new System.Windows.Forms.Button();
			this.btnLoadData.Click += new System.EventHandler(this.btnLoadData_Click);
			this.Label1 = new System.Windows.Forms.Label();
			this.FolderBrowserDialog1 = new System.Windows.Forms.FolderBrowserDialog();
			this.mnuLicense = new System.Windows.Forms.MenuStrip();
			this.UtilityToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.GotoApplicationDirectoryToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.GotoApplicationDirectoryToolStripMenuItem.Click += new System.EventHandler(this.GotoApplicationDirectoryToolStripMenuItem_Click);
			this.GotoGlobalDirectoryToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.GotoGlobalDirectoryToolStripMenuItem.Click += new System.EventHandler(this.GotoGlobalDirectoryToolStripMenuItem_Click);
			this.LicenseToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.Label2 = new System.Windows.Forms.Label();
			this.rbRepository = new System.Windows.Forms.RadioButton();
			this.rbThesaurus = new System.Windows.Forms.RadioButton();
			this.txtMstr = new System.Windows.Forms.TextBox();
			this.mnuLicense.SuspendLayout();
			this.SuspendLayout();
			//
			//SB
			//
			this.SB.BackColor = System.Drawing.Color.Black;
			this.SB.Enabled = false;
			this.SB.ForeColor = System.Drawing.Color.FromArgb(System.Convert.ToInt32((byte) (255)), System.Convert.ToInt32((byte) (255)), System.Convert.ToInt32((byte) (192)));
			this.SB.Location = new System.Drawing.Point(38, 509);
			this.SB.Name = "SB";
			this.SB.ReadOnly = true;
			this.SB.Size = new System.Drawing.Size(375, 20);
			this.SB.TabIndex = 12;
			//
			//ckHive
			//
			this.ckHive.AutoSize = true;
			this.ckHive.BackColor = System.Drawing.Color.Transparent;
			this.ckHive.ForeColor = System.Drawing.Color.White;
			this.ckHive.Location = new System.Drawing.Point(35, 580);
			this.ckHive.Name = "ckHive";
			this.ckHive.Size = new System.Drawing.Size(126, 17);
			this.ckHive.TabIndex = 25;
			this.ckHive.Text = "Attach Client to HIVE";
			this.ckHive.UseVisualStyleBackColor = false;
			this.ckHive.Visible = false;
			//
			//btnHiveUpdate
			//
			this.btnHiveUpdate.Location = new System.Drawing.Point(189, 597);
			this.btnHiveUpdate.Name = "btnHiveUpdate";
			this.btnHiveUpdate.Size = new System.Drawing.Size(148, 21);
			this.btnHiveUpdate.TabIndex = 26;
			this.btnHiveUpdate.Text = "Apply HIVE DB";
			this.btnHiveUpdate.UseVisualStyleBackColor = true;
			this.btnHiveUpdate.Visible = false;
			//
			//btnTestHiveConn
			//
			this.btnTestHiveConn.Location = new System.Drawing.Point(35, 597);
			this.btnTestHiveConn.Name = "btnTestHiveConn";
			this.btnTestHiveConn.Size = new System.Drawing.Size(148, 21);
			this.btnTestHiveConn.TabIndex = 27;
			this.btnTestHiveConn.Text = "Test HIVE Connection";
			this.btnTestHiveConn.UseVisualStyleBackColor = true;
			this.btnTestHiveConn.Visible = false;
			//
			//Label6
			//
			this.Label6.AutoSize = true;
			this.Label6.BackColor = System.Drawing.Color.Transparent;
			this.Label6.ForeColor = System.Drawing.Color.White;
			this.Label6.Location = new System.Drawing.Point(35, 131);
			this.Label6.Name = "Label6";
			this.Label6.Size = new System.Drawing.Size(122, 13);
			this.Label6.TabIndex = 30;
			this.Label6.Text = "Repository Server Name";
			//
			//txtDBName
			//
			this.txtDBName.Location = new System.Drawing.Point(35, 147);
			this.txtDBName.Name = "txtDBName";
			this.txtDBName.Size = new System.Drawing.Size(375, 20);
			this.txtDBName.TabIndex = 1;
			this.txtDBName.Text = "ServerName";
			this.TT.SetToolTip(this.txtDBName, "The name of the server on which the targeted repository lives.");
			//
			//txtServerInstance
			//
			this.txtServerInstance.Location = new System.Drawing.Point(35, 194);
			this.txtServerInstance.Name = "txtServerInstance";
			this.txtServerInstance.Size = new System.Drawing.Size(375, 20);
			this.txtServerInstance.TabIndex = 2;
			this.txtServerInstance.Text = "SqlServerName\\InstanceName";
			this.TT.SetToolTip(this.txtServerInstance, "The databse name and instance of the ECM Repository or Thesaurus.");
			//
			//Label7
			//
			this.Label7.AutoSize = true;
			this.Label7.BackColor = System.Drawing.Color.Transparent;
			this.Label7.ForeColor = System.Drawing.Color.White;
			this.Label7.Location = new System.Drawing.Point(35, 178);
			this.Label7.Name = "Label7";
			this.Label7.Size = new System.Drawing.Size(130, 13);
			this.Label7.TabIndex = 32;
			this.Label7.Text = "Database\\Instance Name";
			//
			//ckWindowsAuthentication
			//
			this.ckWindowsAuthentication.AutoSize = true;
			this.ckWindowsAuthentication.BackColor = System.Drawing.Color.Transparent;
			this.ckWindowsAuthentication.Checked = true;
			this.ckWindowsAuthentication.CheckState = System.Windows.Forms.CheckState.Checked;
			this.ckWindowsAuthentication.ForeColor = System.Drawing.Color.White;
			this.ckWindowsAuthentication.Location = new System.Drawing.Point(38, 258);
			this.ckWindowsAuthentication.Name = "ckWindowsAuthentication";
			this.ckWindowsAuthentication.Size = new System.Drawing.Size(141, 17);
			this.ckWindowsAuthentication.TabIndex = 34;
			this.ckWindowsAuthentication.Text = "Windows Authentication";
			this.TT.SetToolTip(this.ckWindowsAuthentication, "When checked, windows authentication will be used to access the repository, other" + "wise the global ECM user name and password will be required.");
			this.ckWindowsAuthentication.UseVisualStyleBackColor = false;
			//
			//txtPw1
			//
			this.txtPw1.Enabled = false;
			this.txtPw1.Location = new System.Drawing.Point(38, 354);
			this.txtPw1.Name = "txtPw1";
			this.txtPw1.PasswordChar = global::Microsoft.VisualBasic.Strings.ChrW(42);
			this.txtPw1.ReadOnly = true;
			this.txtPw1.Size = new System.Drawing.Size(375, 20);
			this.txtPw1.TabIndex = 5;
			this.txtPw1.Text = "Junebug1";
			//
			//Label8
			//
			this.Label8.AutoSize = true;
			this.Label8.BackColor = System.Drawing.Color.Transparent;
			this.Label8.Enabled = false;
			this.Label8.ForeColor = System.Drawing.Color.White;
			this.Label8.Location = new System.Drawing.Point(38, 338);
			this.Label8.Name = "Label8";
			this.Label8.Size = new System.Drawing.Size(53, 13);
			this.Label8.TabIndex = 37;
			this.Label8.Text = "Password";
			//
			//txtLoginName
			//
			this.txtLoginName.Enabled = false;
			this.txtLoginName.Location = new System.Drawing.Point(38, 307);
			this.txtLoginName.Name = "txtLoginName";
			this.txtLoginName.ReadOnly = true;
			this.txtLoginName.Size = new System.Drawing.Size(375, 20);
			this.txtLoginName.TabIndex = 4;
			this.txtLoginName.Text = "ecmlibrary";
			//
			//Label9
			//
			this.Label9.AutoSize = true;
			this.Label9.BackColor = System.Drawing.Color.Transparent;
			this.Label9.Enabled = false;
			this.Label9.ForeColor = System.Drawing.Color.White;
			this.Label9.Location = new System.Drawing.Point(38, 291);
			this.Label9.Name = "Label9";
			this.Label9.Size = new System.Drawing.Size(118, 13);
			this.Label9.TabIndex = 35;
			this.Label9.Text = "ECM Login User Name ";
			//
			//txtPw2
			//
			this.txtPw2.Enabled = false;
			this.txtPw2.Location = new System.Drawing.Point(38, 403);
			this.txtPw2.Name = "txtPw2";
			this.txtPw2.PasswordChar = global::Microsoft.VisualBasic.Strings.ChrW(42);
			this.txtPw2.ReadOnly = true;
			this.txtPw2.Size = new System.Drawing.Size(375, 20);
			this.txtPw2.TabIndex = 6;
			this.txtPw2.Text = "Junebug1";
			//
			//Label10
			//
			this.Label10.AutoSize = true;
			this.Label10.BackColor = System.Drawing.Color.Transparent;
			this.Label10.Enabled = false;
			this.Label10.ForeColor = System.Drawing.Color.White;
			this.Label10.Location = new System.Drawing.Point(38, 387);
			this.Label10.Name = "Label10";
			this.Label10.Size = new System.Drawing.Size(90, 13);
			this.Label10.TabIndex = 39;
			this.Label10.Text = "Retype Password";
			//
			//Label11
			//
			this.Label11.AutoSize = true;
			this.Label11.BackColor = System.Drawing.Color.Transparent;
			this.Label11.ForeColor = System.Drawing.Color.White;
			this.Label11.Location = new System.Drawing.Point(38, 436);
			this.Label11.Name = "Label11";
			this.Label11.Size = new System.Drawing.Size(102, 13);
			this.Label11.TabIndex = 41;
			this.Label11.Text = "Save/Reload Name";
			//
			//cbSavedDefinitions
			//
			this.cbSavedDefinitions.FormattingEnabled = true;
			this.cbSavedDefinitions.Location = new System.Drawing.Point(38, 455);
			this.cbSavedDefinitions.Name = "cbSavedDefinitions";
			this.cbSavedDefinitions.Size = new System.Drawing.Size(375, 21);
			this.cbSavedDefinitions.TabIndex = 7;
			this.cbSavedDefinitions.Text = "DefaultRepository";
			this.TT.SetToolTip(this.cbSavedDefinitions, "No more than 50 cahracters .");
			//
			//btnTestConnection
			//
			this.btnTestConnection.Location = new System.Drawing.Point(35, 535);
			this.btnTestConnection.Name = "btnTestConnection";
			this.btnTestConnection.Size = new System.Drawing.Size(71, 42);
			this.btnTestConnection.TabIndex = 8;
			this.btnTestConnection.Text = "Test Connection";
			this.TT.SetToolTip(this.btnTestConnection, "Press to test the connection defintion");
			this.btnTestConnection.UseVisualStyleBackColor = true;
			//
			//btnSaveConn
			//
			this.btnSaveConn.Enabled = false;
			this.btnSaveConn.Location = new System.Drawing.Point(111, 535);
			this.btnSaveConn.Name = "btnSaveConn";
			this.btnSaveConn.Size = new System.Drawing.Size(71, 42);
			this.btnSaveConn.TabIndex = 9;
			this.btnSaveConn.Text = "Save Connection";
			this.TT.SetToolTip(this.btnSaveConn, "Saves to Master DB and Will activate only after a successful Test Connection");
			this.btnSaveConn.UseVisualStyleBackColor = true;
			//
			//Button7
			//
			this.Button7.Location = new System.Drawing.Point(35, 49);
			this.Button7.Name = "Button7";
			this.Button7.Size = new System.Drawing.Size(305, 28);
			this.Button7.TabIndex = 47;
			this.Button7.Text = "Select Global File Location";
			this.Button7.UseVisualStyleBackColor = true;
			//
			//txtGlobalFileDirectory
			//
			this.txtGlobalFileDirectory.Location = new System.Drawing.Point(35, 96);
			this.txtGlobalFileDirectory.Name = "txtGlobalFileDirectory";
			this.txtGlobalFileDirectory.Size = new System.Drawing.Size(375, 20);
			this.txtGlobalFileDirectory.TabIndex = 0;
			this.txtGlobalFileDirectory.Text = "C:\\EcmLibrary\\Global";
			this.TT.SetToolTip(this.txtGlobalFileDirectory, "Specifiy a directory that to which ALL potential users will have access.");
			//
			//Button1
			//
			this.Button1.Enabled = false;
			this.Button1.Location = new System.Drawing.Point(263, 535);
			this.Button1.Name = "Button1";
			this.Button1.Size = new System.Drawing.Size(71, 42);
			this.Button1.TabIndex = 10;
			this.Button1.Text = "Save Master Setup";
			this.TT.SetToolTip(this.Button1, "Will active only after a successful Test Connection");
			this.Button1.UseVisualStyleBackColor = true;
			//
			//Button2
			//
			this.Button2.Location = new System.Drawing.Point(339, 535);
			this.Button2.Name = "Button2";
			this.Button2.Size = new System.Drawing.Size(71, 42);
			this.Button2.TabIndex = 11;
			this.Button2.Text = "Load Master Setup";
			this.TT.SetToolTip(this.Button2, "Will active only after a successful Test Connection");
			this.Button2.UseVisualStyleBackColor = true;
			//
			//txtRepositoryName
			//
			this.txtRepositoryName.Location = new System.Drawing.Point(35, 233);
			this.txtRepositoryName.Name = "txtRepositoryName";
			this.txtRepositoryName.Size = new System.Drawing.Size(375, 20);
			this.txtRepositoryName.TabIndex = 3;
			this.txtRepositoryName.Text = "ECM.Library";
			this.TT.SetToolTip(this.txtRepositoryName, "The databse name and instance of the ECM Repository or Thesaurus.");
			//
			//btnResetGlobalLocationToDefault
			//
			this.btnResetGlobalLocationToDefault.Location = new System.Drawing.Point(342, 53);
			this.btnResetGlobalLocationToDefault.Name = "btnResetGlobalLocationToDefault";
			this.btnResetGlobalLocationToDefault.Size = new System.Drawing.Size(22, 20);
			this.btnResetGlobalLocationToDefault.TabIndex = 59;
			this.btnResetGlobalLocationToDefault.Text = "@";
			this.TT.SetToolTip(this.btnResetGlobalLocationToDefault, "Reset global dorectory to default.");
			this.btnResetGlobalLocationToDefault.UseVisualStyleBackColor = true;
			//
			//btnLoadCombo
			//
			this.btnLoadCombo.Font = new System.Drawing.Font("Microsoft Sans Serif", (float) (8.25F), System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, (byte) (0));
			this.btnLoadCombo.ForeColor = System.Drawing.Color.Maroon;
			this.btnLoadCombo.Location = new System.Drawing.Point(38, 482);
			this.btnLoadCombo.Name = "btnLoadCombo";
			this.btnLoadCombo.Size = new System.Drawing.Size(148, 21);
			this.btnLoadCombo.TabIndex = 60;
			this.btnLoadCombo.Text = "Refresh Combo";
			this.TT.SetToolTip(this.btnLoadCombo, "Reload the combobox from the currently defined reporsitory.");
			this.btnLoadCombo.UseVisualStyleBackColor = true;
			//
			//btnLoadData
			//
			this.btnLoadData.Font = new System.Drawing.Font("Microsoft Sans Serif", (float) (8.25F), (System.Drawing.FontStyle) (System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic), System.Drawing.GraphicsUnit.Point, (byte) (0));
			this.btnLoadData.Location = new System.Drawing.Point(265, 482);
			this.btnLoadData.Name = "btnLoadData";
			this.btnLoadData.Size = new System.Drawing.Size(148, 21);
			this.btnLoadData.TabIndex = 61;
			this.btnLoadData.Text = "Load Selected Parms";
			this.TT.SetToolTip(this.btnLoadData, "Load the stored parameters for the selected definition.");
			this.btnLoadData.UseVisualStyleBackColor = true;
			//
			//Label1
			//
			this.Label1.AutoSize = true;
			this.Label1.BackColor = System.Drawing.Color.Transparent;
			this.Label1.ForeColor = System.Drawing.Color.White;
			this.Label1.Location = new System.Drawing.Point(35, 80);
			this.Label1.Name = "Label1";
			this.Label1.Size = new System.Drawing.Size(130, 13);
			this.Label1.TabIndex = 49;
			this.Label1.Text = "Global Install File Location";
			//
			//mnuLicense
			//
			this.mnuLicense.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {this.UtilityToolStripMenuItem, this.LicenseToolStripMenuItem});
			this.mnuLicense.Location = new System.Drawing.Point(0, 0);
			this.mnuLicense.Name = "mnuLicense";
			this.mnuLicense.Size = new System.Drawing.Size(489, 24);
			this.mnuLicense.TabIndex = 52;
			this.mnuLicense.Text = "License";
			//
			//UtilityToolStripMenuItem
			//
			this.UtilityToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {this.GotoApplicationDirectoryToolStripMenuItem, this.GotoGlobalDirectoryToolStripMenuItem});
			this.UtilityToolStripMenuItem.Name = "UtilityToolStripMenuItem";
			this.UtilityToolStripMenuItem.Size = new System.Drawing.Size(46, 20);
			this.UtilityToolStripMenuItem.Text = "Utility";
			//
			//GotoApplicationDirectoryToolStripMenuItem
			//
			this.GotoApplicationDirectoryToolStripMenuItem.Name = "GotoApplicationDirectoryToolStripMenuItem";
			this.GotoApplicationDirectoryToolStripMenuItem.Size = new System.Drawing.Size(199, 22);
			this.GotoApplicationDirectoryToolStripMenuItem.Text = "Goto Application Directory";
			//
			//GotoGlobalDirectoryToolStripMenuItem
			//
			this.GotoGlobalDirectoryToolStripMenuItem.Name = "GotoGlobalDirectoryToolStripMenuItem";
			this.GotoGlobalDirectoryToolStripMenuItem.Size = new System.Drawing.Size(199, 22);
			this.GotoGlobalDirectoryToolStripMenuItem.Text = "Goto Global Directory";
			//
			//LicenseToolStripMenuItem
			//
			this.LicenseToolStripMenuItem.Name = "LicenseToolStripMenuItem";
			this.LicenseToolStripMenuItem.Size = new System.Drawing.Size(54, 20);
			this.LicenseToolStripMenuItem.Text = "License";
			this.LicenseToolStripMenuItem.Visible = false;
			//
			//Label2
			//
			this.Label2.AutoSize = true;
			this.Label2.BackColor = System.Drawing.Color.Transparent;
			this.Label2.ForeColor = System.Drawing.Color.White;
			this.Label2.Location = new System.Drawing.Point(35, 217);
			this.Label2.Name = "Label2";
			this.Label2.Size = new System.Drawing.Size(88, 13);
			this.Label2.TabIndex = 55;
			this.Label2.Text = "Repository Name";
			//
			//rbRepository
			//
			this.rbRepository.AutoSize = true;
			this.rbRepository.BackColor = System.Drawing.Color.Transparent;
			this.rbRepository.Checked = true;
			this.rbRepository.ForeColor = System.Drawing.Color.White;
			this.rbRepository.Location = new System.Drawing.Point(187, 258);
			this.rbRepository.Name = "rbRepository";
			this.rbRepository.Size = new System.Drawing.Size(75, 17);
			this.rbRepository.TabIndex = 57;
			this.rbRepository.TabStop = true;
			this.rbRepository.Text = "Repository";
			this.rbRepository.UseVisualStyleBackColor = false;
			//
			//rbThesaurus
			//
			this.rbThesaurus.AutoSize = true;
			this.rbThesaurus.BackColor = System.Drawing.Color.Transparent;
			this.rbThesaurus.ForeColor = System.Drawing.Color.White;
			this.rbThesaurus.Location = new System.Drawing.Point(268, 258);
			this.rbThesaurus.Name = "rbThesaurus";
			this.rbThesaurus.Size = new System.Drawing.Size(75, 17);
			this.rbThesaurus.TabIndex = 58;
			this.rbThesaurus.Text = "Thesaurus";
			this.rbThesaurus.UseVisualStyleBackColor = false;
			//
			//txtMstr
			//
			this.txtMstr.BackColor = System.Drawing.Color.Black;
			this.txtMstr.Enabled = false;
			this.txtMstr.ForeColor = System.Drawing.Color.FromArgb(System.Convert.ToInt32((byte) (255)), System.Convert.ToInt32((byte) (255)), System.Convert.ToInt32((byte) (192)));
			this.txtMstr.Location = new System.Drawing.Point(35, 624);
			this.txtMstr.Name = "txtMstr";
			this.txtMstr.ReadOnly = true;
			this.txtMstr.Size = new System.Drawing.Size(375, 20);
			this.txtMstr.TabIndex = 62;
			//
			//frmAppConfigEdit
			//
			this.AutoScaleDimensions = new System.Drawing.SizeF((float) (6.0F), (float) (13.0F));
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.BackColor = System.Drawing.Color.FromArgb(System.Convert.ToInt32((byte) (224)), System.Convert.ToInt32((byte) (224)), System.Convert.ToInt32((byte) (224)));
			//Me.BackgroundImage = Global.WindowsApplication1.My.Resources.Resources.backgroundDarkBlueGradient01
			this.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch;
			this.ClientSize = new System.Drawing.Size(489, 664);
			this.Controls.Add(this.txtMstr);
			this.Controls.Add(this.btnLoadData);
			this.Controls.Add(this.btnLoadCombo);
			this.Controls.Add(this.btnResetGlobalLocationToDefault);
			this.Controls.Add(this.rbThesaurus);
			this.Controls.Add(this.rbRepository);
			this.Controls.Add(this.txtRepositoryName);
			this.Controls.Add(this.Label2);
			this.Controls.Add(this.Button2);
			this.Controls.Add(this.Button1);
			this.Controls.Add(this.Label1);
			this.Controls.Add(this.txtGlobalFileDirectory);
			this.Controls.Add(this.Button7);
			this.Controls.Add(this.btnSaveConn);
			this.Controls.Add(this.btnTestConnection);
			this.Controls.Add(this.cbSavedDefinitions);
			this.Controls.Add(this.Label11);
			this.Controls.Add(this.txtPw2);
			this.Controls.Add(this.Label10);
			this.Controls.Add(this.txtPw1);
			this.Controls.Add(this.Label8);
			this.Controls.Add(this.txtLoginName);
			this.Controls.Add(this.Label9);
			this.Controls.Add(this.ckWindowsAuthentication);
			this.Controls.Add(this.txtServerInstance);
			this.Controls.Add(this.Label7);
			this.Controls.Add(this.txtDBName);
			this.Controls.Add(this.Label6);
			this.Controls.Add(this.btnTestHiveConn);
			this.Controls.Add(this.btnHiveUpdate);
			this.Controls.Add(this.ckHive);
			this.Controls.Add(this.SB);
			this.Controls.Add(this.mnuLicense);
			this.Icon = (System.Drawing.Icon) (resources.GetObject("$this.Icon"));
			this.MainMenuStrip = this.mnuLicense;
			this.MaximizeBox = false;
			this.MaximumSize = new System.Drawing.Size(497, 691);
			this.Name = "frmAppConfigEdit";
			this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
			this.Text = "Administrator\'s Installation Setup";
			this.mnuLicense.ResumeLayout(false);
			this.mnuLicense.PerformLayout();
			this.ResumeLayout(false);
			this.PerformLayout();
			
		}
		internal System.Windows.Forms.TextBox SB;
		internal System.Windows.Forms.CheckBox ckHive;
		internal System.Windows.Forms.Button btnHiveUpdate;
		internal System.Windows.Forms.Button btnTestHiveConn;
		internal System.Windows.Forms.Label Label6;
		internal System.Windows.Forms.TextBox txtDBName;
		internal System.Windows.Forms.TextBox txtServerInstance;
		internal System.Windows.Forms.Label Label7;
		internal System.Windows.Forms.CheckBox ckWindowsAuthentication;
		internal System.Windows.Forms.TextBox txtPw1;
		internal System.Windows.Forms.Label Label8;
		internal System.Windows.Forms.TextBox txtLoginName;
		internal System.Windows.Forms.Label Label9;
		internal System.Windows.Forms.TextBox txtPw2;
		internal System.Windows.Forms.Label Label10;
		internal System.Windows.Forms.Label Label11;
		internal System.Windows.Forms.ComboBox cbSavedDefinitions;
		internal System.Windows.Forms.Button btnTestConnection;
		internal System.Windows.Forms.Button btnSaveConn;
		internal System.Windows.Forms.Button Button7;
		internal System.Windows.Forms.TextBox txtGlobalFileDirectory;
		internal System.Windows.Forms.ToolTip TT;
		internal System.Windows.Forms.Label Label1;
		internal System.Windows.Forms.FolderBrowserDialog FolderBrowserDialog1;
		internal System.Windows.Forms.MenuStrip mnuLicense;
		internal System.Windows.Forms.ToolStripMenuItem UtilityToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem GotoApplicationDirectoryToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem GotoGlobalDirectoryToolStripMenuItem;
		internal System.Windows.Forms.Button Button1;
		internal System.Windows.Forms.Button Button2;
		internal System.Windows.Forms.TextBox txtRepositoryName;
		internal System.Windows.Forms.Label Label2;
		internal System.Windows.Forms.RadioButton rbRepository;
		internal System.Windows.Forms.RadioButton rbThesaurus;
		internal System.Windows.Forms.Button btnResetGlobalLocationToDefault;
		internal System.Windows.Forms.Button btnLoadCombo;
		internal System.Windows.Forms.Button btnLoadData;
		internal System.Windows.Forms.TextBox txtMstr;
		internal System.Windows.Forms.ToolStripMenuItem LicenseToolStripMenuItem;
	}
	
}
