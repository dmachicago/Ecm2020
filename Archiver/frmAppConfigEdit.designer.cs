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
    public partial class frmAppConfigEdit : Form
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
            var resources = new System.ComponentModel.ComponentResourceManager(typeof(frmAppConfigEdit));
            SB = new TextBox();
            ckHive = new CheckBox();
            btnHiveUpdate = new Button();
            btnTestHiveConn = new Button();
            Label6 = new Label();
            txtDBName = new TextBox();
            txtServerInstance = new TextBox();
            Label7 = new Label();
            _ckWindowsAuthentication = new CheckBox();
            _ckWindowsAuthentication.CheckedChanged += new EventHandler(ckWindowsAuthentication_CheckedChanged);
            txtPw1 = new TextBox();
            Label8 = new Label();
            txtLoginName = new TextBox();
            Label9 = new Label();
            txtPw2 = new TextBox();
            Label10 = new Label();
            Label11 = new Label();
            _cbSavedDefinitions = new ComboBox();
            _cbSavedDefinitions.TextChanged += new EventHandler(cbSavedDefinitions_TextChanged);
            _btnTestConnection = new Button();
            _btnTestConnection.Click += new EventHandler(btnTestConnection_Click);
            _btnSaveConn = new Button();
            _btnSaveConn.Click += new EventHandler(btnSaveConn_Click);
            _Button7 = new Button();
            _Button7.Click += new EventHandler(Button7_Click);
            txtGlobalFileDirectory = new TextBox();
            TT = new ToolTip(components);
            _Button1 = new Button();
            _Button1.Click += new EventHandler(Button1_Click);
            _Button2 = new Button();
            _Button2.Click += new EventHandler(Button2_Click);
            txtRepositoryName = new TextBox();
            _btnResetGlobalLocationToDefault = new Button();
            _btnResetGlobalLocationToDefault.Click += new EventHandler(btnResetGlobalLocationToDefault_Click);
            _btnLoadCombo = new Button();
            _btnLoadCombo.Click += new EventHandler(btnLoadCombo_Click);
            _btnLoadData = new Button();
            _btnLoadData.Click += new EventHandler(btnLoadData_Click);
            Label1 = new Label();
            FolderBrowserDialog1 = new FolderBrowserDialog();
            mnuLicense = new MenuStrip();
            UtilityToolStripMenuItem = new ToolStripMenuItem();
            _GotoApplicationDirectoryToolStripMenuItem = new ToolStripMenuItem();
            _GotoApplicationDirectoryToolStripMenuItem.Click += new EventHandler(GotoApplicationDirectoryToolStripMenuItem_Click);
            _GotoGlobalDirectoryToolStripMenuItem = new ToolStripMenuItem();
            _GotoGlobalDirectoryToolStripMenuItem.Click += new EventHandler(GotoGlobalDirectoryToolStripMenuItem_Click);
            LicenseToolStripMenuItem = new ToolStripMenuItem();
            Label2 = new Label();
            rbRepository = new RadioButton();
            rbThesaurus = new RadioButton();
            txtMstr = new TextBox();
            mnuLicense.SuspendLayout();
            SuspendLayout();
            // 
            // SB
            // 
            SB.BackColor = Color.Black;
            SB.Enabled = false;
            SB.ForeColor = Color.FromArgb(Conversions.ToInteger(Conversions.ToByte(255)), Conversions.ToInteger(Conversions.ToByte(255)), Conversions.ToInteger(Conversions.ToByte(192)));
            SB.Location = new Point(38, 509);
            SB.Name = "SB";
            SB.ReadOnly = true;
            SB.Size = new Size(375, 20);
            SB.TabIndex = 12;
            // 
            // ckHive
            // 
            ckHive.AutoSize = true;
            ckHive.BackColor = Color.Transparent;
            ckHive.ForeColor = Color.White;
            ckHive.Location = new Point(35, 580);
            ckHive.Name = "ckHive";
            ckHive.Size = new Size(126, 17);
            ckHive.TabIndex = 25;
            ckHive.Text = "Attach Client to HIVE";
            ckHive.UseVisualStyleBackColor = false;
            ckHive.Visible = false;
            // 
            // btnHiveUpdate
            // 
            btnHiveUpdate.Location = new Point(189, 597);
            btnHiveUpdate.Name = "btnHiveUpdate";
            btnHiveUpdate.Size = new Size(148, 21);
            btnHiveUpdate.TabIndex = 26;
            btnHiveUpdate.Text = "Apply HIVE DBARCH";
            btnHiveUpdate.UseVisualStyleBackColor = true;
            btnHiveUpdate.Visible = false;
            // 
            // btnTestHiveConn
            // 
            btnTestHiveConn.Location = new Point(35, 597);
            btnTestHiveConn.Name = "btnTestHiveConn";
            btnTestHiveConn.Size = new Size(148, 21);
            btnTestHiveConn.TabIndex = 27;
            btnTestHiveConn.Text = "Test HIVE Connection";
            btnTestHiveConn.UseVisualStyleBackColor = true;
            btnTestHiveConn.Visible = false;
            // 
            // Label6
            // 
            Label6.AutoSize = true;
            Label6.BackColor = Color.Transparent;
            Label6.ForeColor = Color.White;
            Label6.Location = new Point(35, 131);
            Label6.Name = "Label6";
            Label6.Size = new Size(122, 13);
            Label6.TabIndex = 30;
            Label6.Text = "Repository Server Name";
            // 
            // txtDBName
            // 
            txtDBName.Location = new Point(35, 147);
            txtDBName.Name = "txtDBName";
            txtDBName.Size = new Size(375, 20);
            txtDBName.TabIndex = 1;
            txtDBName.Text = "ServerName";
            TT.SetToolTip(txtDBName, "The name of the server on which the targeted repository lives.");
            // 
            // txtServerInstance
            // 
            txtServerInstance.Location = new Point(35, 194);
            txtServerInstance.Name = "txtServerInstance";
            txtServerInstance.Size = new Size(375, 20);
            txtServerInstance.TabIndex = 2;
            txtServerInstance.Text = @"SqlServerName\InstanceName";
            TT.SetToolTip(txtServerInstance, "The databse name and instance of the ECM Repository or Thesaurus.");
            // 
            // Label7
            // 
            Label7.AutoSize = true;
            Label7.BackColor = Color.Transparent;
            Label7.ForeColor = Color.White;
            Label7.Location = new Point(35, 178);
            Label7.Name = "Label7";
            Label7.Size = new Size(130, 13);
            Label7.TabIndex = 32;
            Label7.Text = @"Database\Instance Name";
            // 
            // ckWindowsAuthentication
            // 
            _ckWindowsAuthentication.AutoSize = true;
            _ckWindowsAuthentication.BackColor = Color.Transparent;
            _ckWindowsAuthentication.Checked = true;
            _ckWindowsAuthentication.CheckState = CheckState.Checked;
            _ckWindowsAuthentication.ForeColor = Color.White;
            _ckWindowsAuthentication.Location = new Point(38, 258);
            _ckWindowsAuthentication.Name = "_ckWindowsAuthentication";
            _ckWindowsAuthentication.Size = new Size(141, 17);
            _ckWindowsAuthentication.TabIndex = 34;
            _ckWindowsAuthentication.Text = "Windows Authentication";
            TT.SetToolTip(_ckWindowsAuthentication, "When checked, windows authentication will be used to access the repository, other" + "wise the global ECM user name and password will be required.");
            _ckWindowsAuthentication.UseVisualStyleBackColor = false;
            // 
            // txtPw1
            // 
            txtPw1.Enabled = false;
            txtPw1.Location = new Point(38, 354);
            txtPw1.Name = "txtPw1";
            txtPw1.PasswordChar = '*';
            txtPw1.ReadOnly = true;
            txtPw1.Size = new Size(375, 20);
            txtPw1.TabIndex = 5;
            txtPw1.Text = "Jxxxxxxx";
            // 
            // Label8
            // 
            Label8.AutoSize = true;
            Label8.BackColor = Color.Transparent;
            Label8.Enabled = false;
            Label8.ForeColor = Color.White;
            Label8.Location = new Point(38, 338);
            Label8.Name = "Label8";
            Label8.Size = new Size(53, 13);
            Label8.TabIndex = 37;
            Label8.Text = "Password";
            // 
            // txtLoginName
            // 
            txtLoginName.Enabled = false;
            txtLoginName.Location = new Point(38, 307);
            txtLoginName.Name = "txtLoginName";
            txtLoginName.ReadOnly = true;
            txtLoginName.Size = new Size(375, 20);
            txtLoginName.TabIndex = 4;
            txtLoginName.Text = "ecmlibrary";
            // 
            // Label9
            // 
            Label9.AutoSize = true;
            Label9.BackColor = Color.Transparent;
            Label9.Enabled = false;
            Label9.ForeColor = Color.White;
            Label9.Location = new Point(38, 291);
            Label9.Name = "Label9";
            Label9.Size = new Size(118, 13);
            Label9.TabIndex = 35;
            Label9.Text = "ECM Login User Name ";
            // 
            // txtPw2
            // 
            txtPw2.Enabled = false;
            txtPw2.Location = new Point(38, 403);
            txtPw2.Name = "txtPw2";
            txtPw2.PasswordChar = '*';
            txtPw2.ReadOnly = true;
            txtPw2.Size = new Size(375, 20);
            txtPw2.TabIndex = 6;
            txtPw2.Text = "Jxxxxxxx";
            // 
            // Label10
            // 
            Label10.AutoSize = true;
            Label10.BackColor = Color.Transparent;
            Label10.Enabled = false;
            Label10.ForeColor = Color.White;
            Label10.Location = new Point(38, 387);
            Label10.Name = "Label10";
            Label10.Size = new Size(90, 13);
            Label10.TabIndex = 39;
            Label10.Text = "Retype Password";
            // 
            // Label11
            // 
            Label11.AutoSize = true;
            Label11.BackColor = Color.Transparent;
            Label11.ForeColor = Color.White;
            Label11.Location = new Point(38, 436);
            Label11.Name = "Label11";
            Label11.Size = new Size(102, 13);
            Label11.TabIndex = 41;
            Label11.Text = "Save/Reload Name";
            // 
            // cbSavedDefinitions
            // 
            _cbSavedDefinitions.FormattingEnabled = true;
            _cbSavedDefinitions.Location = new Point(38, 455);
            _cbSavedDefinitions.Name = "_cbSavedDefinitions";
            _cbSavedDefinitions.Size = new Size(375, 21);
            _cbSavedDefinitions.TabIndex = 7;
            _cbSavedDefinitions.Text = "DefaultRepository";
            TT.SetToolTip(_cbSavedDefinitions, "No more than 50 cahracters .");
            // 
            // btnTestConnection
            // 
            _btnTestConnection.Location = new Point(35, 535);
            _btnTestConnection.Name = "_btnTestConnection";
            _btnTestConnection.Size = new Size(71, 42);
            _btnTestConnection.TabIndex = 8;
            _btnTestConnection.Text = "Test Connection";
            TT.SetToolTip(_btnTestConnection, "Press to test the connection defintion");
            _btnTestConnection.UseVisualStyleBackColor = true;
            // 
            // btnSaveConn
            // 
            _btnSaveConn.Enabled = false;
            _btnSaveConn.Location = new Point(111, 535);
            _btnSaveConn.Name = "_btnSaveConn";
            _btnSaveConn.Size = new Size(71, 42);
            _btnSaveConn.TabIndex = 9;
            _btnSaveConn.Text = "Save Connection";
            TT.SetToolTip(_btnSaveConn, "Saves to Master DBARCH and Will activate only after a successful Test Connection");
            _btnSaveConn.UseVisualStyleBackColor = true;
            // 
            // Button7
            // 
            _Button7.Location = new Point(35, 49);
            _Button7.Name = "_Button7";
            _Button7.Size = new Size(305, 28);
            _Button7.TabIndex = 47;
            _Button7.Text = "Select Global File Location";
            _Button7.UseVisualStyleBackColor = true;
            // 
            // txtGlobalFileDirectory
            // 
            txtGlobalFileDirectory.Location = new Point(35, 96);
            txtGlobalFileDirectory.Name = "txtGlobalFileDirectory";
            txtGlobalFileDirectory.Size = new Size(375, 20);
            txtGlobalFileDirectory.TabIndex = 0;
            txtGlobalFileDirectory.Text = @"C:\EcmLibrary\Global";
            TT.SetToolTip(txtGlobalFileDirectory, "Specifiy a directory that to which ALL potential users will have access.");
            // 
            // Button1
            // 
            _Button1.Enabled = false;
            _Button1.Location = new Point(263, 535);
            _Button1.Name = "_Button1";
            _Button1.Size = new Size(71, 42);
            _Button1.TabIndex = 10;
            _Button1.Text = "Save Master Setup";
            TT.SetToolTip(_Button1, "Will active only after a successful Test Connection");
            _Button1.UseVisualStyleBackColor = true;
            // 
            // Button2
            // 
            _Button2.Location = new Point(339, 535);
            _Button2.Name = "_Button2";
            _Button2.Size = new Size(71, 42);
            _Button2.TabIndex = 11;
            _Button2.Text = "Load Master Setup";
            TT.SetToolTip(_Button2, "Will active only after a successful Test Connection");
            _Button2.UseVisualStyleBackColor = true;
            // 
            // txtRepositoryName
            // 
            txtRepositoryName.Location = new Point(35, 233);
            txtRepositoryName.Name = "txtRepositoryName";
            txtRepositoryName.Size = new Size(375, 20);
            txtRepositoryName.TabIndex = 3;
            txtRepositoryName.Text = "ECM.Library";
            TT.SetToolTip(txtRepositoryName, "The databse name and instance of the ECM Repository or Thesaurus.");
            // 
            // btnResetGlobalLocationToDefault
            // 
            _btnResetGlobalLocationToDefault.Location = new Point(342, 53);
            _btnResetGlobalLocationToDefault.Name = "_btnResetGlobalLocationToDefault";
            _btnResetGlobalLocationToDefault.Size = new Size(22, 20);
            _btnResetGlobalLocationToDefault.TabIndex = 59;
            _btnResetGlobalLocationToDefault.Text = "@";
            TT.SetToolTip(_btnResetGlobalLocationToDefault, "Reset global dorectory to default.");
            _btnResetGlobalLocationToDefault.UseVisualStyleBackColor = true;
            // 
            // btnLoadCombo
            // 
            _btnLoadCombo.Font = new Font("Microsoft Sans Serif", 8.25f, FontStyle.Bold, GraphicsUnit.Point, Conversions.ToByte(0));
            _btnLoadCombo.ForeColor = Color.Maroon;
            _btnLoadCombo.Location = new Point(38, 482);
            _btnLoadCombo.Name = "_btnLoadCombo";
            _btnLoadCombo.Size = new Size(148, 21);
            _btnLoadCombo.TabIndex = 60;
            _btnLoadCombo.Text = "Refresh Combo";
            TT.SetToolTip(_btnLoadCombo, "Reload the combobox from the currently defined reporsitory.");
            _btnLoadCombo.UseVisualStyleBackColor = true;
            // 
            // btnLoadData
            // 
            _btnLoadData.Font = new Font("Microsoft Sans Serif", 8.25f, FontStyle.Bold | FontStyle.Italic, GraphicsUnit.Point, Conversions.ToByte(0));
            _btnLoadData.Location = new Point(265, 482);
            _btnLoadData.Name = "_btnLoadData";
            _btnLoadData.Size = new Size(148, 21);
            _btnLoadData.TabIndex = 61;
            _btnLoadData.Text = "Load Selected Parms";
            TT.SetToolTip(_btnLoadData, "Load the stored parameters for the selected definition.");
            _btnLoadData.UseVisualStyleBackColor = true;
            // 
            // Label1
            // 
            Label1.AutoSize = true;
            Label1.BackColor = Color.Transparent;
            Label1.ForeColor = Color.White;
            Label1.Location = new Point(35, 80);
            Label1.Name = "Label1";
            Label1.Size = new Size(130, 13);
            Label1.TabIndex = 49;
            Label1.Text = "Global Install File Location";
            // 
            // mnuLicense
            // 
            mnuLicense.Items.AddRange(new ToolStripItem[] { UtilityToolStripMenuItem, LicenseToolStripMenuItem });
            mnuLicense.Location = new Point(0, 0);
            mnuLicense.Name = "mnuLicense";
            mnuLicense.Size = new Size(489, 24);
            mnuLicense.TabIndex = 52;
            mnuLicense.Text = "License";
            // 
            // UtilityToolStripMenuItem
            // 
            UtilityToolStripMenuItem.DropDownItems.AddRange(new ToolStripItem[] { _GotoApplicationDirectoryToolStripMenuItem, _GotoGlobalDirectoryToolStripMenuItem });
            UtilityToolStripMenuItem.Name = "UtilityToolStripMenuItem";
            UtilityToolStripMenuItem.Size = new Size(46, 20);
            UtilityToolStripMenuItem.Text = "Utility";
            // 
            // GotoApplicationDirectoryToolStripMenuItem
            // 
            _GotoApplicationDirectoryToolStripMenuItem.Name = "_GotoApplicationDirectoryToolStripMenuItem";
            _GotoApplicationDirectoryToolStripMenuItem.Size = new Size(199, 22);
            _GotoApplicationDirectoryToolStripMenuItem.Text = "Goto Application Directory";
            // 
            // GotoGlobalDirectoryToolStripMenuItem
            // 
            _GotoGlobalDirectoryToolStripMenuItem.Name = "_GotoGlobalDirectoryToolStripMenuItem";
            _GotoGlobalDirectoryToolStripMenuItem.Size = new Size(199, 22);
            _GotoGlobalDirectoryToolStripMenuItem.Text = "Goto Global Directory";
            // 
            // LicenseToolStripMenuItem
            // 
            LicenseToolStripMenuItem.Name = "LicenseToolStripMenuItem";
            LicenseToolStripMenuItem.Size = new Size(54, 20);
            LicenseToolStripMenuItem.Text = "License";
            LicenseToolStripMenuItem.Visible = false;
            // 
            // Label2
            // 
            Label2.AutoSize = true;
            Label2.BackColor = Color.Transparent;
            Label2.ForeColor = Color.White;
            Label2.Location = new Point(35, 217);
            Label2.Name = "Label2";
            Label2.Size = new Size(88, 13);
            Label2.TabIndex = 55;
            Label2.Text = "Repository Name";
            // 
            // rbRepository
            // 
            rbRepository.AutoSize = true;
            rbRepository.BackColor = Color.Transparent;
            rbRepository.Checked = true;
            rbRepository.ForeColor = Color.White;
            rbRepository.Location = new Point(187, 258);
            rbRepository.Name = "rbRepository";
            rbRepository.Size = new Size(75, 17);
            rbRepository.TabIndex = 57;
            rbRepository.TabStop = true;
            rbRepository.Text = "Repository";
            rbRepository.UseVisualStyleBackColor = false;
            // 
            // rbThesaurus
            // 
            rbThesaurus.AutoSize = true;
            rbThesaurus.BackColor = Color.Transparent;
            rbThesaurus.ForeColor = Color.White;
            rbThesaurus.Location = new Point(268, 258);
            rbThesaurus.Name = "rbThesaurus";
            rbThesaurus.Size = new Size(75, 17);
            rbThesaurus.TabIndex = 58;
            rbThesaurus.Text = "Thesaurus";
            rbThesaurus.UseVisualStyleBackColor = false;
            // 
            // txtMstr
            // 
            txtMstr.BackColor = Color.Black;
            txtMstr.Enabled = false;
            txtMstr.ForeColor = Color.FromArgb(Conversions.ToInteger(Conversions.ToByte(255)), Conversions.ToInteger(Conversions.ToByte(255)), Conversions.ToInteger(Conversions.ToByte(192)));
            txtMstr.Location = new Point(35, 624);
            txtMstr.Name = "txtMstr";
            txtMstr.ReadOnly = true;
            txtMstr.Size = new Size(375, 20);
            txtMstr.TabIndex = 62;
            // 
            // frmAppConfigEdit
            // 
            AutoScaleDimensions = new SizeF(6.0f, 13.0f);
            AutoScaleMode = AutoScaleMode.Font;
            BackColor = Color.FromArgb(Conversions.ToInteger(Conversions.ToByte(224)), Conversions.ToInteger(Conversions.ToByte(224)), Conversions.ToInteger(Conversions.ToByte(224)));
            // Me.BackgroundImage = Global.WindowsApplication1.My.Resources.Resources.backgroundDarkBlueGradient01
            BackgroundImageLayout = ImageLayout.Stretch;
            ClientSize = new Size(489, 664);
            Controls.Add(txtMstr);
            Controls.Add(_btnLoadData);
            Controls.Add(_btnLoadCombo);
            Controls.Add(_btnResetGlobalLocationToDefault);
            Controls.Add(rbThesaurus);
            Controls.Add(rbRepository);
            Controls.Add(txtRepositoryName);
            Controls.Add(Label2);
            Controls.Add(_Button2);
            Controls.Add(_Button1);
            Controls.Add(Label1);
            Controls.Add(txtGlobalFileDirectory);
            Controls.Add(_Button7);
            Controls.Add(_btnSaveConn);
            Controls.Add(_btnTestConnection);
            Controls.Add(_cbSavedDefinitions);
            Controls.Add(Label11);
            Controls.Add(txtPw2);
            Controls.Add(Label10);
            Controls.Add(txtPw1);
            Controls.Add(Label8);
            Controls.Add(txtLoginName);
            Controls.Add(Label9);
            Controls.Add(_ckWindowsAuthentication);
            Controls.Add(txtServerInstance);
            Controls.Add(Label7);
            Controls.Add(txtDBName);
            Controls.Add(Label6);
            Controls.Add(btnTestHiveConn);
            Controls.Add(btnHiveUpdate);
            Controls.Add(ckHive);
            Controls.Add(SB);
            Controls.Add(mnuLicense);
            Icon = (Icon)resources.GetObject("$this.Icon");
            MainMenuStrip = mnuLicense;
            MaximizeBox = false;
            MaximumSize = new Size(497, 691);
            Name = "frmAppConfigEdit";
            StartPosition = FormStartPosition.CenterScreen;
            Text = "Administrator's Installation Setup";
            mnuLicense.ResumeLayout(false);
            mnuLicense.PerformLayout();
            ResumeLayout(false);
            PerformLayout();
        }

        internal TextBox SB;
        internal CheckBox ckHive;
        internal Button btnHiveUpdate;
        internal Button btnTestHiveConn;
        internal Label Label6;
        internal TextBox txtDBName;
        internal TextBox txtServerInstance;
        internal Label Label7;
        private CheckBox _ckWindowsAuthentication;

        internal CheckBox ckWindowsAuthentication
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ckWindowsAuthentication;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ckWindowsAuthentication != null)
                {
                    _ckWindowsAuthentication.CheckedChanged -= ckWindowsAuthentication_CheckedChanged;
                }

                _ckWindowsAuthentication = value;
                if (_ckWindowsAuthentication != null)
                {
                    _ckWindowsAuthentication.CheckedChanged += ckWindowsAuthentication_CheckedChanged;
                }
            }
        }

        internal TextBox txtPw1;
        internal Label Label8;
        internal TextBox txtLoginName;
        internal Label Label9;
        internal TextBox txtPw2;
        internal Label Label10;
        internal Label Label11;
        private ComboBox _cbSavedDefinitions;

        internal ComboBox cbSavedDefinitions
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _cbSavedDefinitions;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_cbSavedDefinitions != null)
                {
                    _cbSavedDefinitions.TextChanged -= cbSavedDefinitions_TextChanged;
                }

                _cbSavedDefinitions = value;
                if (_cbSavedDefinitions != null)
                {
                    _cbSavedDefinitions.TextChanged += cbSavedDefinitions_TextChanged;
                }
            }
        }

        private Button _btnTestConnection;

        internal Button btnTestConnection
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnTestConnection;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnTestConnection != null)
                {
                    _btnTestConnection.Click -= btnTestConnection_Click;
                }

                _btnTestConnection = value;
                if (_btnTestConnection != null)
                {
                    _btnTestConnection.Click += btnTestConnection_Click;
                }
            }
        }

        private Button _btnSaveConn;

        internal Button btnSaveConn
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnSaveConn;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnSaveConn != null)
                {
                    _btnSaveConn.Click -= btnSaveConn_Click;
                }

                _btnSaveConn = value;
                if (_btnSaveConn != null)
                {
                    _btnSaveConn.Click += btnSaveConn_Click;
                }
            }
        }

        private Button _Button7;

        internal Button Button7
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _Button7;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_Button7 != null)
                {
                    _Button7.Click -= Button7_Click;
                }

                _Button7 = value;
                if (_Button7 != null)
                {
                    _Button7.Click += Button7_Click;
                }
            }
        }

        internal TextBox txtGlobalFileDirectory;
        internal ToolTip TT;
        internal Label Label1;
        internal FolderBrowserDialog FolderBrowserDialog1;
        internal MenuStrip mnuLicense;
        internal ToolStripMenuItem UtilityToolStripMenuItem;
        private ToolStripMenuItem _GotoApplicationDirectoryToolStripMenuItem;

        internal ToolStripMenuItem GotoApplicationDirectoryToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _GotoApplicationDirectoryToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_GotoApplicationDirectoryToolStripMenuItem != null)
                {
                    _GotoApplicationDirectoryToolStripMenuItem.Click -= GotoApplicationDirectoryToolStripMenuItem_Click;
                }

                _GotoApplicationDirectoryToolStripMenuItem = value;
                if (_GotoApplicationDirectoryToolStripMenuItem != null)
                {
                    _GotoApplicationDirectoryToolStripMenuItem.Click += GotoApplicationDirectoryToolStripMenuItem_Click;
                }
            }
        }

        private ToolStripMenuItem _GotoGlobalDirectoryToolStripMenuItem;

        internal ToolStripMenuItem GotoGlobalDirectoryToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _GotoGlobalDirectoryToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_GotoGlobalDirectoryToolStripMenuItem != null)
                {
                    _GotoGlobalDirectoryToolStripMenuItem.Click -= GotoGlobalDirectoryToolStripMenuItem_Click;
                }

                _GotoGlobalDirectoryToolStripMenuItem = value;
                if (_GotoGlobalDirectoryToolStripMenuItem != null)
                {
                    _GotoGlobalDirectoryToolStripMenuItem.Click += GotoGlobalDirectoryToolStripMenuItem_Click;
                }
            }
        }

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

        private Button _Button2;

        internal Button Button2
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _Button2;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_Button2 != null)
                {
                    _Button2.Click -= Button2_Click;
                }

                _Button2 = value;
                if (_Button2 != null)
                {
                    _Button2.Click += Button2_Click;
                }
            }
        }

        internal TextBox txtRepositoryName;
        internal Label Label2;
        internal RadioButton rbRepository;
        internal RadioButton rbThesaurus;
        private Button _btnResetGlobalLocationToDefault;

        internal Button btnResetGlobalLocationToDefault
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnResetGlobalLocationToDefault;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnResetGlobalLocationToDefault != null)
                {
                    _btnResetGlobalLocationToDefault.Click -= btnResetGlobalLocationToDefault_Click;
                }

                _btnResetGlobalLocationToDefault = value;
                if (_btnResetGlobalLocationToDefault != null)
                {
                    _btnResetGlobalLocationToDefault.Click += btnResetGlobalLocationToDefault_Click;
                }
            }
        }

        private Button _btnLoadCombo;

        internal Button btnLoadCombo
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnLoadCombo;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnLoadCombo != null)
                {
                    _btnLoadCombo.Click -= btnLoadCombo_Click;
                }

                _btnLoadCombo = value;
                if (_btnLoadCombo != null)
                {
                    _btnLoadCombo.Click += btnLoadCombo_Click;
                }
            }
        }

        private Button _btnLoadData;

        internal Button btnLoadData
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnLoadData;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnLoadData != null)
                {
                    _btnLoadData.Click -= btnLoadData_Click;
                }

                _btnLoadData = value;
                if (_btnLoadData != null)
                {
                    _btnLoadData.Click += btnLoadData_Click;
                }
            }
        }

        internal TextBox txtMstr;
        internal ToolStripMenuItem LicenseToolStripMenuItem;
    }
}