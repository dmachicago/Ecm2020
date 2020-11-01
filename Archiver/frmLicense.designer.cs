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
    public partial class frmLicense : Form
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
            _btnGetfile = new Button();
            _btnGetfile.Click += new EventHandler(btnGetfile_Click);
            _btnLoadFile = new Button();
            _btnLoadFile.Click += new EventHandler(btnLoadFile_Click);
            txtFqn = new TextBox();
            txtLicense = new TextBox();
            _btnPasteLicense = new Button();
            _btnPasteLicense.Click += new EventHandler(btnPasteLicense_Click);
            OpenFileDialog1 = new OpenFileDialog();
            SB = new TextBox();
            TT = new ToolTip(components);
            _btnRemote = new Button();
            _btnRemote.Click += new EventHandler(btnRemote_Click);
            _btnApplySelLic = new Button();
            _btnApplySelLic.Click += new EventHandler(btnApplySelLic_Click);
            _btnShowCurrentDB = new Button();
            _btnShowCurrentDB.Click += new EventHandler(btnShowCurrentDB_Click);
            _btnSetEqual = new Button();
            _btnSetEqual.Click += new EventHandler(btnSetEqual_Click);
            _btnGetCustID = new Button();
            _btnGetCustID.Click += new EventHandler(btnGetCustID_Click);
            _Timer1 = new Timer(components);
            _Timer1.Tick += new EventHandler(Timer1_Tick);
            _btnDisplay = new Button();
            _btnDisplay.Click += new EventHandler(btnDisplay_Click);
            Label1 = new Label();
            txtCompanyID = new TextBox();
            Label2 = new Label();
            _dgLicense = new DataGridView();
            _dgLicense.CellContentClick += new DataGridViewCellEventHandler(dgLicense_CellContentClick);
            _dgLicense.SelectionChanged += new EventHandler(dgLicense_SelectionChanged);
            f1Help = new HelpProvider();
            txtSqlServerMachineName = new TextBox();
            Label3 = new Label();
            txtServers = new TextBox();
            ((System.ComponentModel.ISupportInitialize)_dgLicense).BeginInit();
            SuspendLayout();
            // 
            // btnGetfile
            // 
            _btnGetfile.Location = new Point(685, 239);
            _btnGetfile.Name = "_btnGetfile";
            _btnGetfile.Size = new Size(147, 33);
            _btnGetfile.TabIndex = 0;
            _btnGetfile.Text = "Find License File";
            TT.SetToolTip(_btnGetfile, "Locate the license file in a specified directory and then \"Load License File\"");
            _btnGetfile.UseVisualStyleBackColor = true;
            // 
            // btnLoadFile
            // 
            _btnLoadFile.Location = new Point(685, 278);
            _btnLoadFile.Name = "_btnLoadFile";
            _btnLoadFile.Size = new Size(147, 33);
            _btnLoadFile.TabIndex = 1;
            _btnLoadFile.Text = "Load License File";
            TT.SetToolTip(_btnLoadFile, "Once you locate the license file in a specified directory, then press \"Load Licen" + "se File\"");
            _btnLoadFile.UseVisualStyleBackColor = true;
            // 
            // txtFqn
            // 
            txtFqn.Location = new Point(10, 33);
            txtFqn.Name = "txtFqn";
            txtFqn.Size = new Size(669, 20);
            txtFqn.TabIndex = 2;
            // 
            // txtLicense
            // 
            txtLicense.Location = new Point(10, 59);
            txtLicense.Multiline = true;
            txtLicense.Name = "txtLicense";
            txtLicense.Size = new Size(669, 133);
            txtLicense.TabIndex = 3;
            TT.SetToolTip(txtLicense, "Paste the encryted license data in this window.");
            // 
            // btnPasteLicense
            // 
            _btnPasteLicense.Location = new Point(685, 317);
            _btnPasteLicense.Name = "_btnPasteLicense";
            _btnPasteLicense.Size = new Size(147, 33);
            _btnPasteLicense.TabIndex = 4;
            _btnPasteLicense.Text = "Apply License from Textbox";
            TT.SetToolTip(_btnPasteLicense, "Copy the encrypted license into the window to the left and then Press this button" + ".");
            _btnPasteLicense.UseVisualStyleBackColor = true;
            // 
            // OpenFileDialog1
            // 
            OpenFileDialog1.FileName = "OpenFileDialog1";
            // 
            // SB
            // 
            SB.BackColor = Color.FromArgb(Conversions.ToInteger(Conversions.ToByte(255)), Conversions.ToInteger(Conversions.ToByte(255)), Conversions.ToInteger(Conversions.ToByte(192)));
            SB.Enabled = false;
            SB.Location = new Point(6, 471);
            SB.Name = "SB";
            SB.Size = new Size(669, 20);
            SB.TabIndex = 5;
            // 
            // btnRemote
            // 
            _btnRemote.Location = new Point(685, 419);
            _btnRemote.Name = "_btnRemote";
            _btnRemote.Size = new Size(147, 70);
            _btnRemote.TabIndex = 11;
            _btnRemote.Text = "Fetch Available Licenses from ECM License Server";
            TT.SetToolTip(_btnRemote, "Fetch License from ECM license server.");
            _btnRemote.UseVisualStyleBackColor = true;
            // 
            // btnApplySelLic
            // 
            _btnApplySelLic.Location = new Point(685, 59);
            _btnApplySelLic.Name = "_btnApplySelLic";
            _btnApplySelLic.Size = new Size(147, 70);
            _btnApplySelLic.TabIndex = 15;
            _btnApplySelLic.Text = "Apply Selected License";
            TT.SetToolTip(_btnApplySelLic, "Apply the selected license to the appropriate server.");
            _btnApplySelLic.UseVisualStyleBackColor = true;
            // 
            // btnShowCurrentDB
            // 
            _btnShowCurrentDB.Location = new Point(12, 6);
            _btnShowCurrentDB.Name = "_btnShowCurrentDB";
            _btnShowCurrentDB.Size = new Size(24, 21);
            _btnShowCurrentDB.TabIndex = 17;
            _btnShowCurrentDB.Text = "@";
            TT.SetToolTip(_btnShowCurrentDB, "Show the current User and DBARCH information");
            _btnShowCurrentDB.UseVisualStyleBackColor = true;
            _btnShowCurrentDB.Visible = false;
            // 
            // btnSetEqual
            // 
            _btnSetEqual.Location = new Point(52, 6);
            _btnSetEqual.Name = "_btnSetEqual";
            _btnSetEqual.Size = new Size(24, 21);
            _btnSetEqual.TabIndex = 18;
            _btnSetEqual.Text = "+";
            TT.SetToolTip(_btnSetEqual, "Press to get your current Customer ID. Will not display anything if a license is " + "not currently installed.");
            _btnSetEqual.UseVisualStyleBackColor = true;
            _btnSetEqual.Visible = false;
            // 
            // btnGetCustID
            // 
            _btnGetCustID.Location = new Point(425, 444);
            _btnGetCustID.Name = "_btnGetCustID";
            _btnGetCustID.Size = new Size(157, 21);
            _btnGetCustID.TabIndex = 19;
            _btnGetCustID.Text = "Get ID from License";
            TT.SetToolTip(_btnGetCustID, "Press to get your current Customer ID. Will not display anything if a license is " + "not currently installed.");
            _btnGetCustID.UseVisualStyleBackColor = true;
            // 
            // Timer1
            // 
            _Timer1.Enabled = true;
            _Timer1.Interval = 5000;
            // 
            // btnDisplay
            // 
            _btnDisplay.Location = new Point(685, 135);
            _btnDisplay.Name = "_btnDisplay";
            _btnDisplay.Size = new Size(147, 35);
            _btnDisplay.TabIndex = 6;
            _btnDisplay.Text = "Show License Rules";
            _btnDisplay.UseVisualStyleBackColor = true;
            // 
            // Label1
            // 
            Label1.AutoSize = true;
            Label1.Location = new Point(6, 379);
            Label1.Name = "Label1";
            Label1.Size = new Size(150, 13);
            Label1.TabIndex = 8;
            Label1.Text = "Enter Repository Server Name";
            // 
            // txtCompanyID
            // 
            txtCompanyID.Location = new Point(212, 442);
            txtCompanyID.Name = "txtCompanyID";
            txtCompanyID.Size = new Size(207, 20);
            txtCompanyID.TabIndex = 12;
            // 
            // Label2
            // 
            Label2.AutoSize = true;
            Label2.Location = new Point(6, 446);
            Label2.Name = "Label2";
            Label2.Size = new Size(202, 13);
            Label2.TabIndex = 13;
            Label2.Text = "Please Enter Your Assigned Customer ID:";
            // 
            // dgLicense
            // 
            _dgLicense.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            _dgLicense.Location = new Point(10, 198);
            _dgLicense.Name = "_dgLicense";
            _dgLicense.RowTemplate.Height = 24;
            _dgLicense.Size = new Size(669, 178);
            _dgLicense.TabIndex = 14;
            // 
            // f1Help
            // 
            f1Help.HelpNamespace = "http://www.ecmlibrary.com/_helpfiles/License Management Screen.htm";
            // 
            // txtSqlServerMachineName
            // 
            txtSqlServerMachineName.BackColor = SystemColors.InactiveBorder;
            txtSqlServerMachineName.Enabled = false;
            txtSqlServerMachineName.Location = new Point(135, 419);
            txtSqlServerMachineName.Name = "txtSqlServerMachineName";
            txtSqlServerMachineName.Size = new Size(284, 20);
            txtSqlServerMachineName.TabIndex = 20;
            // 
            // Label3
            // 
            Label3.AutoSize = true;
            Label3.Location = new Point(6, 422);
            Label3.Name = "Label3";
            Label3.Size = new Size(125, 13);
            Label3.TabIndex = 21;
            Label3.Text = "SQL Svr Instance Name:";
            // 
            // txtServers
            // 
            txtServers.Location = new Point(8, 393);
            txtServers.Name = "txtServers";
            txtServers.Size = new Size(411, 20);
            txtServers.TabIndex = 22;
            // 
            // frmLicense
            // 
            AutoScaleDimensions = new SizeF(6.0f, 13.0f);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(844, 501);
            Controls.Add(txtServers);
            Controls.Add(Label3);
            Controls.Add(txtSqlServerMachineName);
            Controls.Add(_btnGetCustID);
            Controls.Add(_btnSetEqual);
            Controls.Add(_btnShowCurrentDB);
            Controls.Add(_btnApplySelLic);
            Controls.Add(_dgLicense);
            Controls.Add(Label2);
            Controls.Add(txtCompanyID);
            Controls.Add(_btnRemote);
            Controls.Add(Label1);
            Controls.Add(_btnDisplay);
            Controls.Add(SB);
            Controls.Add(_btnPasteLicense);
            Controls.Add(txtLicense);
            Controls.Add(txtFqn);
            Controls.Add(_btnLoadFile);
            Controls.Add(_btnGetfile);
            f1Help.SetHelpString(this, "http://www.ecmlibrary.com/_helpfiles/License Management Screen.htm");
            Name = "frmLicense";
            f1Help.SetShowHelp(this, true);
            Text = "frmLicense";
            ((System.ComponentModel.ISupportInitialize)_dgLicense).EndInit();
            Load += new EventHandler(frmLicense_Load);
            ResumeLayout(false);
            PerformLayout();
        }

        private Button _btnGetfile;

        internal Button btnGetfile
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnGetfile;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnGetfile != null)
                {
                    _btnGetfile.Click -= btnGetfile_Click;
                }

                _btnGetfile = value;
                if (_btnGetfile != null)
                {
                    _btnGetfile.Click += btnGetfile_Click;
                }
            }
        }

        private Button _btnLoadFile;

        internal Button btnLoadFile
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnLoadFile;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnLoadFile != null)
                {
                    _btnLoadFile.Click -= btnLoadFile_Click;
                }

                _btnLoadFile = value;
                if (_btnLoadFile != null)
                {
                    _btnLoadFile.Click += btnLoadFile_Click;
                }
            }
        }

        internal TextBox txtFqn;
        internal TextBox txtLicense;
        private Button _btnPasteLicense;

        internal Button btnPasteLicense
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnPasteLicense;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnPasteLicense != null)
                {
                    _btnPasteLicense.Click -= btnPasteLicense_Click;
                }

                _btnPasteLicense = value;
                if (_btnPasteLicense != null)
                {
                    _btnPasteLicense.Click += btnPasteLicense_Click;
                }
            }
        }

        internal OpenFileDialog OpenFileDialog1;
        internal TextBox SB;
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

        private Button _btnDisplay;

        internal Button btnDisplay
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnDisplay;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnDisplay != null)
                {
                    _btnDisplay.Click -= btnDisplay_Click;
                }

                _btnDisplay = value;
                if (_btnDisplay != null)
                {
                    _btnDisplay.Click += btnDisplay_Click;
                }
            }
        }

        internal Label Label1;
        private Button _btnRemote;

        internal Button btnRemote
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnRemote;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnRemote != null)
                {
                    _btnRemote.Click -= btnRemote_Click;
                }

                _btnRemote = value;
                if (_btnRemote != null)
                {
                    _btnRemote.Click += btnRemote_Click;
                }
            }
        }

        internal TextBox txtCompanyID;
        internal Label Label2;
        private DataGridView _dgLicense;

        internal DataGridView dgLicense
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _dgLicense;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_dgLicense != null)
                {
                    _dgLicense.CellContentClick -= dgLicense_CellContentClick;
                    _dgLicense.SelectionChanged -= dgLicense_SelectionChanged;
                }

                _dgLicense = value;
                if (_dgLicense != null)
                {
                    _dgLicense.CellContentClick += dgLicense_CellContentClick;
                    _dgLicense.SelectionChanged += dgLicense_SelectionChanged;
                }
            }
        }

        private Button _btnApplySelLic;

        internal Button btnApplySelLic
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnApplySelLic;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnApplySelLic != null)
                {
                    _btnApplySelLic.Click -= btnApplySelLic_Click;
                }

                _btnApplySelLic = value;
                if (_btnApplySelLic != null)
                {
                    _btnApplySelLic.Click += btnApplySelLic_Click;
                }
            }
        }

        internal HelpProvider f1Help;
        private Button _btnShowCurrentDB;

        internal Button btnShowCurrentDB
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnShowCurrentDB;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnShowCurrentDB != null)
                {
                    _btnShowCurrentDB.Click -= btnShowCurrentDB_Click;
                }

                _btnShowCurrentDB = value;
                if (_btnShowCurrentDB != null)
                {
                    _btnShowCurrentDB.Click += btnShowCurrentDB_Click;
                }
            }
        }

        private Button _btnSetEqual;

        internal Button btnSetEqual
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnSetEqual;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnSetEqual != null)
                {
                    _btnSetEqual.Click -= btnSetEqual_Click;
                }

                _btnSetEqual = value;
                if (_btnSetEqual != null)
                {
                    _btnSetEqual.Click += btnSetEqual_Click;
                }
            }
        }

        private Button _btnGetCustID;

        internal Button btnGetCustID
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnGetCustID;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnGetCustID != null)
                {
                    _btnGetCustID.Click -= btnGetCustID_Click;
                }

                _btnGetCustID = value;
                if (_btnGetCustID != null)
                {
                    _btnGetCustID.Click += btnGetCustID_Click;
                }
            }
        }

        internal TextBox txtSqlServerMachineName;
        internal Label Label3;
        internal TextBox txtServers;
    }
}