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
    public partial class frmExhangeMail : Form
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
            _dgExchange = new DataGridView();
            _dgExchange.CellContentClick += new DataGridViewCellEventHandler(dgExchange_CellContentClick);
            _dgExchange.MouseDown += new MouseEventHandler(dgExchange_MouseDown);
            _dgExchange.SelectionChanged += new EventHandler(dgExchange_SelectionChanged);
            Label1 = new Label();
            Label2 = new Label();
            Label3 = new Label();
            Label5 = new Label();
            Label6 = new Label();
            ckSSL = new CheckBox();
            _ckDeleteAfterDownload = new CheckBox();
            _ckDeleteAfterDownload.CheckedChanged += new EventHandler(ckDeleteAfterDownload_CheckedChanged);
            _ckIMap = new CheckBox();
            _ckIMap.CheckedChanged += new EventHandler(ckIMap_CheckedChanged);
            Label4 = new Label();
            cbUsers = new ComboBox();
            cbRetention = new ComboBox();
            txtUserLoginID = new TextBox();
            txtPw = new TextBox();
            txtPortNumber = new TextBox();
            cbHostName = new ComboBox();
            _btnAdd = new Button();
            _btnAdd.Click += new EventHandler(btnAdd_Click);
            _btnUpdate = new Button();
            _btnUpdate.Click += new EventHandler(btnUpdate_Click);
            _btnDelete = new Button();
            _btnDelete.Click += new EventHandler(btnDelete_Click);
            SB = new TextBox();
            TT = new ToolTip(components);
            txtFolderName = new TextBox();
            cbLibrary = new ComboBox();
            nbrDaysToRetain = new NumericUpDown();
            _btnTest = new Button();
            _btnTest.Click += new EventHandler(Button1_Click);
            _btnTestConnection = new Button();
            _btnTestConnection.Click += new EventHandler(btnTestConnection_Click);
            _btnShoaAllLib = new Button();
            _btnShoaAllLib.Click += new EventHandler(btnShoaAllLib_Click);
            _btnEncrypt = new Button();
            _btnEncrypt.Click += new EventHandler(btnEncrypt_Click);
            f1Help = new HelpProvider();
            txtUserID = new TextBox();
            MenuStrip1 = new MenuStrip();
            _HelpToolStripMenuItem = new ToolStripMenuItem();
            _HelpToolStripMenuItem.Click += new EventHandler(HelpToolStripMenuItem_Click);
            _ECMLibraryExchangeInterfaceToolStripMenuItem1 = new ToolStripMenuItem();
            _ECMLibraryExchangeInterfaceToolStripMenuItem1.Click += new EventHandler(ECMLibraryExchangeInterfaceToolStripMenuItem1_Click);
            _Exchange2007Vs2003ToolStripMenuItem = new ToolStripMenuItem();
            _Exchange2007Vs2003ToolStripMenuItem.Click += new EventHandler(Exchange2007Vs2003ToolStripMenuItem_Click);
            _ExchnageJournalingToolStripMenuItem = new ToolStripMenuItem();
            _ExchnageJournalingToolStripMenuItem.Click += new EventHandler(ExchnageJournalingToolStripMenuItem_Click);
            _SamplePOPMailScreenToolStripMenuItem = new ToolStripMenuItem();
            _SamplePOPMailScreenToolStripMenuItem.Click += new EventHandler(SamplePOPMailScreenToolStripMenuItem_Click);
            _SampleIMAPSSLScreenToolStripMenuItem = new ToolStripMenuItem();
            _SampleIMAPSSLScreenToolStripMenuItem.Click += new EventHandler(SampleIMAPSSLScreenToolStripMenuItem_Click);
            _SampleIMAPScreenToolStripMenuItem = new ToolStripMenuItem();
            _SampleIMAPScreenToolStripMenuItem.Click += new EventHandler(SampleIMAPScreenToolStripMenuItem_Click);
            _SamplePOPSSLMailScreenToolStripMenuItem = new ToolStripMenuItem();
            _SamplePOPSSLMailScreenToolStripMenuItem.Click += new EventHandler(SamplePOPSSLMailScreenToolStripMenuItem_Click);
            _SampleCorporateEmailScreenToolStripMenuItem = new ToolStripMenuItem();
            _SampleCorporateEmailScreenToolStripMenuItem.Click += new EventHandler(SampleCorporateEmailScreenToolStripMenuItem_Click);
            Label7 = new Label();
            Label8 = new Label();
            ckPublic = new CheckBox();
            Label9 = new Label();
            txtReject = new TextBox();
            Label10 = new Label();
            ckConvertEmlToMsg = new CheckBox();
            _btnReset = new Button();
            _btnReset.Click += new EventHandler(btnReset_Click);
            _ckExcg2003 = new CheckBox();
            _ckExcg2003.CheckedChanged += new EventHandler(ckExcg2003_CheckedChanged);
            _ckExcg2007 = new CheckBox();
            _ckExcg2007.CheckedChanged += new EventHandler(ckExcg2007_CheckedChanged);
            ckRtfFormat = new CheckBox();
            ckPlainText = new CheckBox();
            ckEnvelope = new CheckBox();
            ckJournaled = new CheckBox();
            Panel1 = new Panel();
            ContextMenuStrip1 = new ContextMenuStrip(components);
            _ComplianceOverviewToolStripMenuItem = new ToolStripMenuItem();
            _ComplianceOverviewToolStripMenuItem.Click += new EventHandler(ComplianceOverviewToolStripMenuItem_Click);
            ECMLibraryExchangeInterfaceToolStripMenuItem = new ToolStripMenuItem();
            _ExchangeJournalingToolStripMenuItem = new ToolStripMenuItem();
            _ExchangeJournalingToolStripMenuItem.Click += new EventHandler(ExchangeJournalingToolStripMenuItem_Click);
            SamplesToolStripMenuItem = new ToolStripMenuItem();
            _POPMailToolStripMenuItem = new ToolStripMenuItem();
            _POPMailToolStripMenuItem.Click += new EventHandler(POPMailToolStripMenuItem_Click);
            _IMAPSSLToolStripMenuItem = new ToolStripMenuItem();
            _IMAPSSLToolStripMenuItem.Click += new EventHandler(IMAPSSLToolStripMenuItem_Click);
            _IMAPToolStripMenuItem = new ToolStripMenuItem();
            _IMAPToolStripMenuItem.Click += new EventHandler(IMAPToolStripMenuItem_Click);
            _POPSSLToolStripMenuItem = new ToolStripMenuItem();
            _POPSSLToolStripMenuItem.Click += new EventHandler(POPSSLToolStripMenuItem_Click);
            _StandardCoporateToolStripMenuItem = new ToolStripMenuItem();
            _StandardCoporateToolStripMenuItem.Click += new EventHandler(StandardCoporateToolStripMenuItem_Click);
            ((System.ComponentModel.ISupportInitialize)_dgExchange).BeginInit();
            ((System.ComponentModel.ISupportInitialize)nbrDaysToRetain).BeginInit();
            MenuStrip1.SuspendLayout();
            Panel1.SuspendLayout();
            ContextMenuStrip1.SuspendLayout();
            SuspendLayout();
            // 
            // dgExchange
            // 
            _dgExchange.AllowUserToAddRows = false;
            _dgExchange.AllowUserToDeleteRows = false;
            _dgExchange.Anchor = AnchorStyles.Top | AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;

            _dgExchange.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.AllCells;
            _dgExchange.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            _dgExchange.Location = new Point(12, 58);
            _dgExchange.Name = "_dgExchange";
            _dgExchange.ReadOnly = true;
            _dgExchange.Size = new Size(483, 524);
            _dgExchange.TabIndex = 0;
            TT.SetToolTip(_dgExchange, "Do not update data here, use input fields to the right.");
            // 
            // Label1
            // 
            Label1.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            Label1.AutoSize = true;
            Label1.Location = new Point(527, 40);
            Label1.Name = "Label1";
            Label1.Size = new Size(60, 13);
            Label1.TabIndex = 1;
            Label1.Text = "Host Name";
            // 
            // Label2
            // 
            Label2.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            Label2.AutoSize = true;
            Label2.Location = new Point(527, 84);
            Label2.Name = "Label2";
            Label2.Size = new Size(72, 13);
            Label2.TabIndex = 2;
            Label2.Text = "User Login ID";
            // 
            // Label3
            // 
            Label3.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            Label3.AutoSize = true;
            Label3.Location = new Point(527, 127);
            Label3.Name = "Label3";
            Label3.Size = new Size(82, 13);
            Label3.TabIndex = 3;
            Label3.Text = "Login Password";
            // 
            // Label5
            // 
            Label5.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            Label5.AutoSize = true;
            Label5.Location = new Point(524, 358);
            Label5.Name = "Label5";
            Label5.Size = new Size(66, 13);
            Label5.TabIndex = 5;
            Label5.Text = "Port Number";
            // 
            // Label6
            // 
            Label6.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            Label6.AutoSize = true;
            Label6.Location = new Point(524, 401);
            Label6.Name = "Label6";
            Label6.Size = new Size(78, 13);
            Label6.TabIndex = 6;
            Label6.Text = "RetentionCode";
            // 
            // ckSSL
            // 
            ckSSL.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            ckSSL.AutoSize = true;
            ckSSL.Location = new Point(526, 173);
            ckSSL.Name = "ckSSL";
            ckSSL.Size = new Size(46, 17);
            ckSSL.TabIndex = 7;
            ckSSL.Text = "SSL";
            ckSSL.UseVisualStyleBackColor = true;
            // 
            // ckDeleteAfterDownload
            // 
            _ckDeleteAfterDownload.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            _ckDeleteAfterDownload.AutoSize = true;
            _ckDeleteAfterDownload.Location = new Point(526, 196);
            _ckDeleteAfterDownload.Name = "_ckDeleteAfterDownload";
            _ckDeleteAfterDownload.Size = new Size(133, 17);
            _ckDeleteAfterDownload.TabIndex = 8;
            _ckDeleteAfterDownload.Text = "Delete After Download";
            _ckDeleteAfterDownload.UseVisualStyleBackColor = true;
            // 
            // ckIMap
            // 
            _ckIMap.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            _ckIMap.AutoSize = true;
            _ckIMap.Location = new Point(610, 173);
            _ckIMap.Name = "_ckIMap";
            _ckIMap.Size = new Size(50, 17);
            _ckIMap.TabIndex = 9;
            _ckIMap.Text = "IMap";
            _ckIMap.UseVisualStyleBackColor = true;
            // 
            // Label4
            // 
            Label4.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            Label4.AutoSize = true;
            Label4.Location = new Point(524, 445);
            Label4.Name = "Label4";
            Label4.Size = new Size(93, 13);
            Label4.TabIndex = 10;
            Label4.Text = "Execution User ID";
            // 
            // cbUsers
            // 
            cbUsers.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            cbUsers.FormattingEnabled = true;
            cbUsers.Location = new Point(524, 463);
            cbUsers.Name = "cbUsers";
            cbUsers.Size = new Size(294, 21);
            cbUsers.TabIndex = 11;
            TT.SetToolTip(cbUsers, "Leave blank to default to your ID or Set this ID to be different than your curren" + "t ID if another user is to run this utility.");
            // 
            // cbRetention
            // 
            cbRetention.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            cbRetention.FormattingEnabled = true;
            cbRetention.Location = new Point(524, 419);
            cbRetention.Name = "cbRetention";
            cbRetention.Size = new Size(294, 21);
            cbRetention.TabIndex = 12;
            // 
            // txtUserLoginID
            // 
            txtUserLoginID.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            txtUserLoginID.Location = new Point(527, 102);
            txtUserLoginID.Name = "txtUserLoginID";
            txtUserLoginID.Size = new Size(294, 20);
            txtUserLoginID.TabIndex = 14;
            // 
            // txtPw
            // 
            txtPw.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            txtPw.Location = new Point(527, 145);
            txtPw.Name = "txtPw";
            txtPw.Size = new Size(179, 20);
            txtPw.TabIndex = 15;
            // 
            // txtPortNumber
            // 
            txtPortNumber.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            txtPortNumber.Location = new Point(524, 376);
            txtPortNumber.Name = "txtPortNumber";
            txtPortNumber.Size = new Size(110, 20);
            txtPortNumber.TabIndex = 16;
            // 
            // cbHostName
            // 
            cbHostName.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            cbHostName.FormattingEnabled = true;
            cbHostName.Location = new Point(527, 58);
            cbHostName.Name = "cbHostName";
            cbHostName.Size = new Size(294, 21);
            cbHostName.TabIndex = 17;
            TT.SetToolTip(cbHostName, "For a sample of how to fill this out, please click the help menu.");
            // 
            // btnAdd
            // 
            _btnAdd.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            _btnAdd.Location = new Point(640, 611);
            _btnAdd.Name = "_btnAdd";
            _btnAdd.Size = new Size(53, 36);
            _btnAdd.TabIndex = 18;
            _btnAdd.Text = "&Insert";
            _btnAdd.UseVisualStyleBackColor = true;
            // 
            // btnUpdate
            // 
            _btnUpdate.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            _btnUpdate.Location = new Point(699, 611);
            _btnUpdate.Name = "_btnUpdate";
            _btnUpdate.Size = new Size(53, 36);
            _btnUpdate.TabIndex = 19;
            _btnUpdate.Text = "&Update";
            _btnUpdate.UseVisualStyleBackColor = true;
            // 
            // btnDelete
            // 
            _btnDelete.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            _btnDelete.Location = new Point(767, 611);
            _btnDelete.Name = "_btnDelete";
            _btnDelete.Size = new Size(53, 36);
            _btnDelete.TabIndex = 20;
            _btnDelete.Text = "&Delete";
            _btnDelete.UseVisualStyleBackColor = true;
            // 
            // SB
            // 
            SB.Anchor = AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;
            SB.BackColor = Color.FromArgb(Conversions.ToInteger(Conversions.ToByte(255)), Conversions.ToInteger(Conversions.ToByte(255)), Conversions.ToInteger(Conversions.ToByte(192)));
            SB.Enabled = false;
            SB.Location = new Point(92, 663);
            SB.Name = "SB";
            SB.Size = new Size(403, 20);
            SB.TabIndex = 21;
            // 
            // txtFolderName
            // 
            txtFolderName.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            txtFolderName.Enabled = false;
            txtFolderName.Location = new Point(652, 376);
            txtFolderName.Name = "txtFolderName";
            txtFolderName.Size = new Size(165, 20);
            txtFolderName.TabIndex = 25;
            TT.SetToolTip(txtFolderName, "Used in an IMAP definition.");
            // 
            // cbLibrary
            // 
            cbLibrary.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            cbLibrary.FormattingEnabled = true;
            cbLibrary.Location = new Point(524, 514);
            cbLibrary.Name = "cbLibrary";
            cbLibrary.Size = new Size(269, 21);
            cbLibrary.TabIndex = 28;
            TT.SetToolTip(cbLibrary, "Leave blank to default to your ID or Set this ID to be different than your curren" + "t ID if another user is to run this utility.");
            // 
            // nbrDaysToRetain
            // 
            nbrDaysToRetain.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            nbrDaysToRetain.Location = new Point(773, 194);
            nbrDaysToRetain.Maximum = new decimal(new int[] { 1000, 0, 0, 0 });
            nbrDaysToRetain.Name = "nbrDaysToRetain";
            nbrDaysToRetain.Size = new Size(56, 20);
            nbrDaysToRetain.TabIndex = 31;
            TT.SetToolTip(nbrDaysToRetain, "Zero means delete when downloaded");
            // 
            // btnTest
            // 
            _btnTest.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            _btnTest.Location = new Point(526, 611);
            _btnTest.Name = "_btnTest";
            _btnTest.Size = new Size(53, 36);
            _btnTest.TabIndex = 32;
            _btnTest.Text = "Show All";
            TT.SetToolTip(_btnTest, "Show the appropriate list of defined Exchange mail boxes.");
            _btnTest.UseVisualStyleBackColor = true;
            // 
            // btnTestConnection
            // 
            _btnTestConnection.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            _btnTestConnection.BackgroundImageLayout = ImageLayout.Stretch;
            _btnTestConnection.Location = new Point(829, 53);
            _btnTestConnection.Name = "_btnTestConnection";
            _btnTestConnection.Size = new Size(30, 31);
            _btnTestConnection.TabIndex = 40;
            TT.SetToolTip(_btnTestConnection, "Press to test the connection to the server.");
            _btnTestConnection.UseVisualStyleBackColor = true;
            // 
            // btnShoaAllLib
            // 
            _btnShoaAllLib.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            _btnShoaAllLib.Location = new Point(810, 514);
            _btnShoaAllLib.Name = "_btnShoaAllLib";
            _btnShoaAllLib.Size = new Size(19, 20);
            _btnShoaAllLib.TabIndex = 41;
            TT.SetToolTip(_btnShoaAllLib, "Show all libraries in system to choose from.");
            _btnShoaAllLib.UseVisualStyleBackColor = true;
            // 
            // btnEncrypt
            // 
            _btnEncrypt.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            _btnEncrypt.Location = new Point(717, 145);
            _btnEncrypt.Name = "_btnEncrypt";
            _btnEncrypt.Size = new Size(103, 20);
            _btnEncrypt.TabIndex = 22;
            _btnEncrypt.Text = "Encrypt PW";
            _btnEncrypt.UseVisualStyleBackColor = true;
            // 
            // f1Help
            // 
            f1Help.HelpNamespace = "http://www.ecmlibrary.com/_helpfiles/frmExchangeMail.htm";
            // 
            // txtUserID
            // 
            txtUserID.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            txtUserID.Enabled = false;
            txtUserID.Location = new Point(527, 656);
            txtUserID.Name = "txtUserID";
            txtUserID.Size = new Size(293, 20);
            txtUserID.TabIndex = 23;
            // 
            // MenuStrip1
            // 
            MenuStrip1.BackColor = Color.Transparent;
            MenuStrip1.Dock = DockStyle.None;
            MenuStrip1.Items.AddRange(new ToolStripItem[] { _HelpToolStripMenuItem });
            MenuStrip1.Location = new Point(0, 0);
            MenuStrip1.Name = "MenuStrip1";
            MenuStrip1.Size = new Size(48, 24);
            MenuStrip1.TabIndex = 24;
            MenuStrip1.Text = "MenuStrip1";
            // 
            // HelpToolStripMenuItem
            // 
            _HelpToolStripMenuItem.DisplayStyle = ToolStripItemDisplayStyle.Text;
            _HelpToolStripMenuItem.DropDownItems.AddRange(new ToolStripItem[] { _ECMLibraryExchangeInterfaceToolStripMenuItem1, _Exchange2007Vs2003ToolStripMenuItem, _ExchnageJournalingToolStripMenuItem, _SamplePOPMailScreenToolStripMenuItem, _SampleIMAPSSLScreenToolStripMenuItem, _SampleIMAPScreenToolStripMenuItem, _SamplePOPSSLMailScreenToolStripMenuItem, _SampleCorporateEmailScreenToolStripMenuItem });
            _HelpToolStripMenuItem.Name = "_HelpToolStripMenuItem";
            _HelpToolStripMenuItem.ShortcutKeys = Keys.Control | Keys.F1;
            _HelpToolStripMenuItem.Size = new Size(40, 20);
            _HelpToolStripMenuItem.Text = "&Help";
            // 
            // ECMLibraryExchangeInterfaceToolStripMenuItem1
            // 
            _ECMLibraryExchangeInterfaceToolStripMenuItem1.Name = "_ECMLibraryExchangeInterfaceToolStripMenuItem1";
            _ECMLibraryExchangeInterfaceToolStripMenuItem1.Size = new Size(312, 22);
            _ECMLibraryExchangeInterfaceToolStripMenuItem1.Text = "ECM Library Exchange Interface";
            // 
            // Exchange2007Vs2003ToolStripMenuItem
            // 
            _Exchange2007Vs2003ToolStripMenuItem.Name = "_Exchange2007Vs2003ToolStripMenuItem";
            _Exchange2007Vs2003ToolStripMenuItem.Size = new Size(312, 22);
            _Exchange2007Vs2003ToolStripMenuItem.Text = "Microsoft Exchange Server 2007 Compliance Tour";
            // 
            // ExchnageJournalingToolStripMenuItem
            // 
            _ExchnageJournalingToolStripMenuItem.Name = "_ExchnageJournalingToolStripMenuItem";
            _ExchnageJournalingToolStripMenuItem.Size = new Size(312, 22);
            _ExchnageJournalingToolStripMenuItem.Text = "Exchange Journaling";
            // 
            // SamplePOPMailScreenToolStripMenuItem
            // 
            _SamplePOPMailScreenToolStripMenuItem.Name = "_SamplePOPMailScreenToolStripMenuItem";
            _SamplePOPMailScreenToolStripMenuItem.Size = new Size(312, 22);
            _SamplePOPMailScreenToolStripMenuItem.Text = "Sample POP Mail Screen";
            // 
            // SampleIMAPSSLScreenToolStripMenuItem
            // 
            _SampleIMAPSSLScreenToolStripMenuItem.Name = "_SampleIMAPSSLScreenToolStripMenuItem";
            _SampleIMAPSSLScreenToolStripMenuItem.Size = new Size(312, 22);
            _SampleIMAPSSLScreenToolStripMenuItem.Text = "Sample IMAP SSL Screen";
            // 
            // SampleIMAPScreenToolStripMenuItem
            // 
            _SampleIMAPScreenToolStripMenuItem.Name = "_SampleIMAPScreenToolStripMenuItem";
            _SampleIMAPScreenToolStripMenuItem.Size = new Size(312, 22);
            _SampleIMAPScreenToolStripMenuItem.Text = "Sample IMAP Screen";
            // 
            // SamplePOPSSLMailScreenToolStripMenuItem
            // 
            _SamplePOPSSLMailScreenToolStripMenuItem.Name = "_SamplePOPSSLMailScreenToolStripMenuItem";
            _SamplePOPSSLMailScreenToolStripMenuItem.Size = new Size(312, 22);
            _SamplePOPSSLMailScreenToolStripMenuItem.Text = "Sample POP SSL Mail Screen";
            // 
            // SampleCorporateEmailScreenToolStripMenuItem
            // 
            _SampleCorporateEmailScreenToolStripMenuItem.Name = "_SampleCorporateEmailScreenToolStripMenuItem";
            _SampleCorporateEmailScreenToolStripMenuItem.Size = new Size(312, 22);
            _SampleCorporateEmailScreenToolStripMenuItem.Text = "Sample Corporate Email Screen";
            // 
            // Label7
            // 
            Label7.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            Label7.AutoSize = true;
            Label7.Location = new Point(649, 360);
            Label7.Name = "Label7";
            Label7.Size = new Size(74, 13);
            Label7.TabIndex = 26;
            Label7.Text = "Mailbox Name";
            // 
            // Label8
            // 
            Label8.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            Label8.AutoSize = true;
            Label8.Location = new Point(524, 496);
            Label8.Name = "Label8";
            Label8.Size = new Size(80, 13);
            Label8.TabIndex = 27;
            Label8.Text = "Select a Library";
            // 
            // ckPublic
            // 
            ckPublic.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            ckPublic.AutoSize = true;
            ckPublic.Location = new Point(524, 548);
            ckPublic.Name = "ckPublic";
            ckPublic.Size = new Size(295, 17);
            ckPublic.TabIndex = 29;
            ckPublic.Text = "Make all emails in this archive available for Public access";
            ckPublic.UseVisualStyleBackColor = true;
            // 
            // Label9
            // 
            Label9.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            Label9.AutoSize = true;
            Label9.Location = new Point(665, 198);
            Label9.Name = "Label9";
            Label9.Size = new Size(102, 13);
            Label9.TabIndex = 30;
            Label9.Text = "or Delete after days:";
            // 
            // txtReject
            // 
            txtReject.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            txtReject.Location = new Point(526, 585);
            txtReject.Name = "txtReject";
            txtReject.Size = new Size(293, 20);
            txtReject.TabIndex = 33;
            // 
            // Label10
            // 
            Label10.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            Label10.AutoSize = true;
            Label10.Location = new Point(526, 569);
            Label10.Name = "Label10";
            Label10.Size = new Size(131, 13);
            Label10.TabIndex = 34;
            Label10.Text = "Reject if Subject contains:";
            // 
            // ckConvertEmlToMsg
            // 
            ckConvertEmlToMsg.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            ckConvertEmlToMsg.AutoSize = true;
            ckConvertEmlToMsg.Location = new Point(537, 308);
            ckConvertEmlToMsg.Name = "ckConvertEmlToMsg";
            ckConvertEmlToMsg.Size = new Size(230, 17);
            ckConvertEmlToMsg.TabIndex = 35;
            ckConvertEmlToMsg.Text = "Convert all emails in this folder to MSG files.";
            ckConvertEmlToMsg.UseVisualStyleBackColor = true;
            // 
            // btnReset
            // 
            _btnReset.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            _btnReset.Location = new Point(12, 663);
            _btnReset.Name = "_btnReset";
            _btnReset.Size = new Size(53, 22);
            _btnReset.TabIndex = 37;
            _btnReset.Text = "Reset";
            _btnReset.UseVisualStyleBackColor = true;
            _btnReset.Visible = false;
            // 
            // ckExcg2003
            // 
            _ckExcg2003.AutoSize = true;
            _ckExcg2003.Location = new Point(12, 29);
            _ckExcg2003.Name = "_ckExcg2003";
            _ckExcg2003.Size = new Size(101, 17);
            _ckExcg2003.TabIndex = 1;
            _ckExcg2003.Text = "Exchange 2003";
            _ckExcg2003.UseVisualStyleBackColor = true;
            // 
            // ckExcg2007
            // 
            _ckExcg2007.AutoSize = true;
            _ckExcg2007.Location = new Point(12, 6);
            _ckExcg2007.Name = "_ckExcg2007";
            _ckExcg2007.Size = new Size(101, 17);
            _ckExcg2007.TabIndex = 2;
            _ckExcg2007.Text = "Exchange 2007";
            _ckExcg2007.UseVisualStyleBackColor = true;
            // 
            // ckRtfFormat
            // 
            ckRtfFormat.AutoSize = true;
            ckRtfFormat.Location = new Point(161, 6);
            ckRtfFormat.Name = "ckRtfFormat";
            ckRtfFormat.Size = new Size(47, 17);
            ckRtfFormat.TabIndex = 3;
            ckRtfFormat.Text = "RTF";
            ckRtfFormat.UseVisualStyleBackColor = true;
            // 
            // ckPlainText
            // 
            ckPlainText.AutoSize = true;
            ckPlainText.Location = new Point(161, 30);
            ckPlainText.Name = "ckPlainText";
            ckPlainText.Size = new Size(73, 17);
            ckPlainText.TabIndex = 4;
            ckPlainText.Text = "Plain Text";
            ckPlainText.UseVisualStyleBackColor = true;
            // 
            // ckEnvelope
            // 
            ckEnvelope.AutoSize = true;
            ckEnvelope.Location = new Point(161, 54);
            ckEnvelope.Name = "ckEnvelope";
            ckEnvelope.Size = new Size(71, 17);
            ckEnvelope.TabIndex = 5;
            ckEnvelope.Text = "Envelope";
            ckEnvelope.UseVisualStyleBackColor = true;
            // 
            // ckJournaled
            // 
            ckJournaled.AutoSize = true;
            ckJournaled.Location = new Point(12, 54);
            ckJournaled.Name = "ckJournaled";
            ckJournaled.Size = new Size(99, 17);
            ckJournaled.TabIndex = 6;
            ckJournaled.Text = "Journal Mailbox";
            ckJournaled.UseVisualStyleBackColor = true;
            // 
            // Panel1
            // 
            Panel1.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            Panel1.BorderStyle = BorderStyle.FixedSingle;
            Panel1.Controls.Add(ckJournaled);
            Panel1.Controls.Add(ckEnvelope);
            Panel1.Controls.Add(ckPlainText);
            Panel1.Controls.Add(ckRtfFormat);
            Panel1.Controls.Add(_ckExcg2007);
            Panel1.Controls.Add(_ckExcg2003);
            Panel1.Enabled = false;
            Panel1.Location = new Point(536, 219);
            Panel1.Name = "Panel1";
            Panel1.Size = new Size(283, 83);
            Panel1.TabIndex = 38;
            // 
            // ContextMenuStrip1
            // 
            ContextMenuStrip1.Items.AddRange(new ToolStripItem[] { _ComplianceOverviewToolStripMenuItem, ECMLibraryExchangeInterfaceToolStripMenuItem, _ExchangeJournalingToolStripMenuItem, SamplesToolStripMenuItem });
            ContextMenuStrip1.Name = "ContextMenuStrip1";
            ContextMenuStrip1.Size = new Size(241, 92);
            // 
            // ComplianceOverviewToolStripMenuItem
            // 
            _ComplianceOverviewToolStripMenuItem.Name = "_ComplianceOverviewToolStripMenuItem";
            _ComplianceOverviewToolStripMenuItem.Size = new Size(240, 22);
            _ComplianceOverviewToolStripMenuItem.Text = "Compliance Overview";
            // 
            // ECMLibraryExchangeInterfaceToolStripMenuItem
            // 
            ECMLibraryExchangeInterfaceToolStripMenuItem.Name = "ECMLibraryExchangeInterfaceToolStripMenuItem";
            ECMLibraryExchangeInterfaceToolStripMenuItem.Size = new Size(240, 22);
            ECMLibraryExchangeInterfaceToolStripMenuItem.Text = "ECM Library Exchange Interface";
            // 
            // ExchangeJournalingToolStripMenuItem
            // 
            _ExchangeJournalingToolStripMenuItem.Name = "_ExchangeJournalingToolStripMenuItem";
            _ExchangeJournalingToolStripMenuItem.Size = new Size(240, 22);
            _ExchangeJournalingToolStripMenuItem.Text = "Exchange Journaling";
            // 
            // SamplesToolStripMenuItem
            // 
            SamplesToolStripMenuItem.DropDownItems.AddRange(new ToolStripItem[] { _POPMailToolStripMenuItem, _IMAPSSLToolStripMenuItem, _IMAPToolStripMenuItem, _POPSSLToolStripMenuItem, _StandardCoporateToolStripMenuItem });
            SamplesToolStripMenuItem.Name = "SamplesToolStripMenuItem";
            SamplesToolStripMenuItem.Size = new Size(240, 22);
            SamplesToolStripMenuItem.Text = "Samples";
            // 
            // POPMailToolStripMenuItem
            // 
            _POPMailToolStripMenuItem.Name = "_POPMailToolStripMenuItem";
            _POPMailToolStripMenuItem.Size = new Size(166, 22);
            _POPMailToolStripMenuItem.Text = "POP Mail";
            // 
            // IMAPSSLToolStripMenuItem
            // 
            _IMAPSSLToolStripMenuItem.Name = "_IMAPSSLToolStripMenuItem";
            _IMAPSSLToolStripMenuItem.Size = new Size(166, 22);
            _IMAPSSLToolStripMenuItem.Text = "IMAP SSL";
            // 
            // IMAPToolStripMenuItem
            // 
            _IMAPToolStripMenuItem.Name = "_IMAPToolStripMenuItem";
            _IMAPToolStripMenuItem.Size = new Size(166, 22);
            _IMAPToolStripMenuItem.Text = "IMAP ";
            // 
            // POPSSLToolStripMenuItem
            // 
            _POPSSLToolStripMenuItem.Name = "_POPSSLToolStripMenuItem";
            _POPSSLToolStripMenuItem.Size = new Size(166, 22);
            _POPSSLToolStripMenuItem.Text = "POP SSL";
            // 
            // StandardCoporateToolStripMenuItem
            // 
            _StandardCoporateToolStripMenuItem.Name = "_StandardCoporateToolStripMenuItem";
            _StandardCoporateToolStripMenuItem.Size = new Size(166, 22);
            _StandardCoporateToolStripMenuItem.Text = "Standard Coporate";
            // 
            // frmExhangeMail
            // 
            AutoScaleDimensions = new SizeF(6.0f, 13.0f);
            AutoScaleMode = AutoScaleMode.Font;
            BackColor = SystemColors.ActiveBorder;
            BackgroundImageLayout = ImageLayout.Stretch;
            ClientSize = new Size(867, 697);
            Controls.Add(_btnShoaAllLib);
            Controls.Add(_btnTestConnection);
            Controls.Add(Panel1);
            Controls.Add(_btnReset);
            Controls.Add(ckConvertEmlToMsg);
            Controls.Add(Label10);
            Controls.Add(txtReject);
            Controls.Add(_btnTest);
            Controls.Add(nbrDaysToRetain);
            Controls.Add(Label9);
            Controls.Add(ckPublic);
            Controls.Add(cbLibrary);
            Controls.Add(Label8);
            Controls.Add(Label7);
            Controls.Add(txtFolderName);
            Controls.Add(txtUserID);
            Controls.Add(_btnEncrypt);
            Controls.Add(SB);
            Controls.Add(_btnDelete);
            Controls.Add(_btnUpdate);
            Controls.Add(_btnAdd);
            Controls.Add(cbHostName);
            Controls.Add(txtPortNumber);
            Controls.Add(txtPw);
            Controls.Add(txtUserLoginID);
            Controls.Add(cbRetention);
            Controls.Add(cbUsers);
            Controls.Add(Label4);
            Controls.Add(_ckIMap);
            Controls.Add(_ckDeleteAfterDownload);
            Controls.Add(ckSSL);
            Controls.Add(Label6);
            Controls.Add(Label5);
            Controls.Add(Label3);
            Controls.Add(Label2);
            Controls.Add(Label1);
            Controls.Add(_dgExchange);
            Controls.Add(MenuStrip1);
            f1Help.SetHelpString(this, "http://www.ecmlibrary.com/_helpfiles/frmExchangeMail.htm");
            MainMenuStrip = MenuStrip1;
            Name = "frmExhangeMail";
            f1Help.SetShowHelp(this, true);
            Text = "Exhange Mail";
            ((System.ComponentModel.ISupportInitialize)_dgExchange).EndInit();
            ((System.ComponentModel.ISupportInitialize)nbrDaysToRetain).EndInit();
            MenuStrip1.ResumeLayout(false);
            MenuStrip1.PerformLayout();
            Panel1.ResumeLayout(false);
            Panel1.PerformLayout();
            ContextMenuStrip1.ResumeLayout(false);
            Load += new EventHandler(frmExhangeMail_Load);
            ResumeLayout(false);
            PerformLayout();
        }

        private DataGridView _dgExchange;

        internal DataGridView dgExchange
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _dgExchange;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_dgExchange != null)
                {
                    _dgExchange.CellContentClick -= dgExchange_CellContentClick;
                    _dgExchange.MouseDown -= dgExchange_MouseDown;
                    _dgExchange.SelectionChanged -= dgExchange_SelectionChanged;
                }

                _dgExchange = value;
                if (_dgExchange != null)
                {
                    _dgExchange.CellContentClick += dgExchange_CellContentClick;
                    _dgExchange.MouseDown += dgExchange_MouseDown;
                    _dgExchange.SelectionChanged += dgExchange_SelectionChanged;
                }
            }
        }

        internal Label Label1;
        internal Label Label2;
        internal Label Label3;
        internal Label Label5;
        internal Label Label6;
        internal CheckBox ckSSL;
        private CheckBox _ckDeleteAfterDownload;

        internal CheckBox ckDeleteAfterDownload
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ckDeleteAfterDownload;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ckDeleteAfterDownload != null)
                {
                    _ckDeleteAfterDownload.CheckedChanged -= ckDeleteAfterDownload_CheckedChanged;
                }

                _ckDeleteAfterDownload = value;
                if (_ckDeleteAfterDownload != null)
                {
                    _ckDeleteAfterDownload.CheckedChanged += ckDeleteAfterDownload_CheckedChanged;
                }
            }
        }

        private CheckBox _ckIMap;

        internal CheckBox ckIMap
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ckIMap;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ckIMap != null)
                {
                    _ckIMap.CheckedChanged -= ckIMap_CheckedChanged;
                }

                _ckIMap = value;
                if (_ckIMap != null)
                {
                    _ckIMap.CheckedChanged += ckIMap_CheckedChanged;
                }
            }
        }

        internal Label Label4;
        internal ComboBox cbUsers;
        internal ComboBox cbRetention;
        internal TextBox txtUserLoginID;
        internal TextBox txtPw;
        internal TextBox txtPortNumber;
        internal ComboBox cbHostName;
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

        internal TextBox SB;
        internal ToolTip TT;
        private Button _btnEncrypt;

        internal Button btnEncrypt
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnEncrypt;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnEncrypt != null)
                {
                    _btnEncrypt.Click -= btnEncrypt_Click;
                }

                _btnEncrypt = value;
                if (_btnEncrypt != null)
                {
                    _btnEncrypt.Click += btnEncrypt_Click;
                }
            }
        }

        internal HelpProvider f1Help;
        internal TextBox txtUserID;
        internal MenuStrip MenuStrip1;
        private ToolStripMenuItem _HelpToolStripMenuItem;

        internal ToolStripMenuItem HelpToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _HelpToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_HelpToolStripMenuItem != null)
                {
                    _HelpToolStripMenuItem.Click -= HelpToolStripMenuItem_Click;
                }

                _HelpToolStripMenuItem = value;
                if (_HelpToolStripMenuItem != null)
                {
                    _HelpToolStripMenuItem.Click += HelpToolStripMenuItem_Click;
                }
            }
        }

        private ToolStripMenuItem _ECMLibraryExchangeInterfaceToolStripMenuItem1;

        internal ToolStripMenuItem ECMLibraryExchangeInterfaceToolStripMenuItem1
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ECMLibraryExchangeInterfaceToolStripMenuItem1;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ECMLibraryExchangeInterfaceToolStripMenuItem1 != null)
                {
                    _ECMLibraryExchangeInterfaceToolStripMenuItem1.Click -= ECMLibraryExchangeInterfaceToolStripMenuItem1_Click;
                }

                _ECMLibraryExchangeInterfaceToolStripMenuItem1 = value;
                if (_ECMLibraryExchangeInterfaceToolStripMenuItem1 != null)
                {
                    _ECMLibraryExchangeInterfaceToolStripMenuItem1.Click += ECMLibraryExchangeInterfaceToolStripMenuItem1_Click;
                }
            }
        }

        private ToolStripMenuItem _Exchange2007Vs2003ToolStripMenuItem;

        internal ToolStripMenuItem Exchange2007Vs2003ToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _Exchange2007Vs2003ToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_Exchange2007Vs2003ToolStripMenuItem != null)
                {
                    _Exchange2007Vs2003ToolStripMenuItem.Click -= Exchange2007Vs2003ToolStripMenuItem_Click;
                }

                _Exchange2007Vs2003ToolStripMenuItem = value;
                if (_Exchange2007Vs2003ToolStripMenuItem != null)
                {
                    _Exchange2007Vs2003ToolStripMenuItem.Click += Exchange2007Vs2003ToolStripMenuItem_Click;
                }
            }
        }

        private ToolStripMenuItem _ExchnageJournalingToolStripMenuItem;

        internal ToolStripMenuItem ExchnageJournalingToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ExchnageJournalingToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ExchnageJournalingToolStripMenuItem != null)
                {
                    _ExchnageJournalingToolStripMenuItem.Click -= ExchnageJournalingToolStripMenuItem_Click;
                }

                _ExchnageJournalingToolStripMenuItem = value;
                if (_ExchnageJournalingToolStripMenuItem != null)
                {
                    _ExchnageJournalingToolStripMenuItem.Click += ExchnageJournalingToolStripMenuItem_Click;
                }
            }
        }

        internal TextBox txtFolderName;
        internal Label Label7;
        internal ComboBox cbLibrary;
        internal Label Label8;
        internal CheckBox ckPublic;
        internal Label Label9;
        internal NumericUpDown nbrDaysToRetain;
        private Button _btnTest;

        internal Button btnTest
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnTest;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnTest != null)
                {
                    _btnTest.Click -= Button1_Click;
                }

                _btnTest = value;
                if (_btnTest != null)
                {
                    _btnTest.Click += Button1_Click;
                }
            }
        }

        internal TextBox txtReject;
        internal Label Label10;
        internal CheckBox ckConvertEmlToMsg;
        private Button _btnReset;

        internal Button btnReset
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnReset;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnReset != null)
                {
                    _btnReset.Click -= btnReset_Click;
                }

                _btnReset = value;
                if (_btnReset != null)
                {
                    _btnReset.Click += btnReset_Click;
                }
            }
        }

        private CheckBox _ckExcg2003;

        internal CheckBox ckExcg2003
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ckExcg2003;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ckExcg2003 != null)
                {
                    _ckExcg2003.CheckedChanged -= ckExcg2003_CheckedChanged;
                }

                _ckExcg2003 = value;
                if (_ckExcg2003 != null)
                {
                    _ckExcg2003.CheckedChanged += ckExcg2003_CheckedChanged;
                }
            }
        }

        private CheckBox _ckExcg2007;

        internal CheckBox ckExcg2007
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ckExcg2007;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ckExcg2007 != null)
                {
                    _ckExcg2007.CheckedChanged -= ckExcg2007_CheckedChanged;
                }

                _ckExcg2007 = value;
                if (_ckExcg2007 != null)
                {
                    _ckExcg2007.CheckedChanged += ckExcg2007_CheckedChanged;
                }
            }
        }

        internal CheckBox ckRtfFormat;
        internal CheckBox ckPlainText;
        internal CheckBox ckEnvelope;
        internal CheckBox ckJournaled;
        internal Panel Panel1;
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

        private Button _btnShoaAllLib;

        internal Button btnShoaAllLib
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnShoaAllLib;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnShoaAllLib != null)
                {
                    _btnShoaAllLib.Click -= btnShoaAllLib_Click;
                }

                _btnShoaAllLib = value;
                if (_btnShoaAllLib != null)
                {
                    _btnShoaAllLib.Click += btnShoaAllLib_Click;
                }
            }
        }

        private ToolStripMenuItem _SamplePOPMailScreenToolStripMenuItem;

        internal ToolStripMenuItem SamplePOPMailScreenToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _SamplePOPMailScreenToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_SamplePOPMailScreenToolStripMenuItem != null)
                {
                    _SamplePOPMailScreenToolStripMenuItem.Click -= SamplePOPMailScreenToolStripMenuItem_Click;
                }

                _SamplePOPMailScreenToolStripMenuItem = value;
                if (_SamplePOPMailScreenToolStripMenuItem != null)
                {
                    _SamplePOPMailScreenToolStripMenuItem.Click += SamplePOPMailScreenToolStripMenuItem_Click;
                }
            }
        }

        private ToolStripMenuItem _SampleIMAPSSLScreenToolStripMenuItem;

        internal ToolStripMenuItem SampleIMAPSSLScreenToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _SampleIMAPSSLScreenToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_SampleIMAPSSLScreenToolStripMenuItem != null)
                {
                    _SampleIMAPSSLScreenToolStripMenuItem.Click -= SampleIMAPSSLScreenToolStripMenuItem_Click;
                }

                _SampleIMAPSSLScreenToolStripMenuItem = value;
                if (_SampleIMAPSSLScreenToolStripMenuItem != null)
                {
                    _SampleIMAPSSLScreenToolStripMenuItem.Click += SampleIMAPSSLScreenToolStripMenuItem_Click;
                }
            }
        }

        private ToolStripMenuItem _SampleIMAPScreenToolStripMenuItem;

        internal ToolStripMenuItem SampleIMAPScreenToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _SampleIMAPScreenToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_SampleIMAPScreenToolStripMenuItem != null)
                {
                    _SampleIMAPScreenToolStripMenuItem.Click -= SampleIMAPScreenToolStripMenuItem_Click;
                }

                _SampleIMAPScreenToolStripMenuItem = value;
                if (_SampleIMAPScreenToolStripMenuItem != null)
                {
                    _SampleIMAPScreenToolStripMenuItem.Click += SampleIMAPScreenToolStripMenuItem_Click;
                }
            }
        }

        private ToolStripMenuItem _SamplePOPSSLMailScreenToolStripMenuItem;

        internal ToolStripMenuItem SamplePOPSSLMailScreenToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _SamplePOPSSLMailScreenToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_SamplePOPSSLMailScreenToolStripMenuItem != null)
                {
                    _SamplePOPSSLMailScreenToolStripMenuItem.Click -= SamplePOPSSLMailScreenToolStripMenuItem_Click;
                }

                _SamplePOPSSLMailScreenToolStripMenuItem = value;
                if (_SamplePOPSSLMailScreenToolStripMenuItem != null)
                {
                    _SamplePOPSSLMailScreenToolStripMenuItem.Click += SamplePOPSSLMailScreenToolStripMenuItem_Click;
                }
            }
        }

        private ToolStripMenuItem _SampleCorporateEmailScreenToolStripMenuItem;

        internal ToolStripMenuItem SampleCorporateEmailScreenToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _SampleCorporateEmailScreenToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_SampleCorporateEmailScreenToolStripMenuItem != null)
                {
                    _SampleCorporateEmailScreenToolStripMenuItem.Click -= SampleCorporateEmailScreenToolStripMenuItem_Click;
                }

                _SampleCorporateEmailScreenToolStripMenuItem = value;
                if (_SampleCorporateEmailScreenToolStripMenuItem != null)
                {
                    _SampleCorporateEmailScreenToolStripMenuItem.Click += SampleCorporateEmailScreenToolStripMenuItem_Click;
                }
            }
        }

        internal ContextMenuStrip ContextMenuStrip1;
        private ToolStripMenuItem _ComplianceOverviewToolStripMenuItem;

        internal ToolStripMenuItem ComplianceOverviewToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ComplianceOverviewToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ComplianceOverviewToolStripMenuItem != null)
                {
                    _ComplianceOverviewToolStripMenuItem.Click -= ComplianceOverviewToolStripMenuItem_Click;
                }

                _ComplianceOverviewToolStripMenuItem = value;
                if (_ComplianceOverviewToolStripMenuItem != null)
                {
                    _ComplianceOverviewToolStripMenuItem.Click += ComplianceOverviewToolStripMenuItem_Click;
                }
            }
        }

        internal ToolStripMenuItem ECMLibraryExchangeInterfaceToolStripMenuItem;
        private ToolStripMenuItem _ExchangeJournalingToolStripMenuItem;

        internal ToolStripMenuItem ExchangeJournalingToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ExchangeJournalingToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ExchangeJournalingToolStripMenuItem != null)
                {
                    _ExchangeJournalingToolStripMenuItem.Click -= ExchangeJournalingToolStripMenuItem_Click;
                }

                _ExchangeJournalingToolStripMenuItem = value;
                if (_ExchangeJournalingToolStripMenuItem != null)
                {
                    _ExchangeJournalingToolStripMenuItem.Click += ExchangeJournalingToolStripMenuItem_Click;
                }
            }
        }

        internal ToolStripMenuItem SamplesToolStripMenuItem;
        private ToolStripMenuItem _POPMailToolStripMenuItem;

        internal ToolStripMenuItem POPMailToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _POPMailToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_POPMailToolStripMenuItem != null)
                {
                    _POPMailToolStripMenuItem.Click -= POPMailToolStripMenuItem_Click;
                }

                _POPMailToolStripMenuItem = value;
                if (_POPMailToolStripMenuItem != null)
                {
                    _POPMailToolStripMenuItem.Click += POPMailToolStripMenuItem_Click;
                }
            }
        }

        private ToolStripMenuItem _IMAPSSLToolStripMenuItem;

        internal ToolStripMenuItem IMAPSSLToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _IMAPSSLToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_IMAPSSLToolStripMenuItem != null)
                {
                    _IMAPSSLToolStripMenuItem.Click -= IMAPSSLToolStripMenuItem_Click;
                }

                _IMAPSSLToolStripMenuItem = value;
                if (_IMAPSSLToolStripMenuItem != null)
                {
                    _IMAPSSLToolStripMenuItem.Click += IMAPSSLToolStripMenuItem_Click;
                }
            }
        }

        private ToolStripMenuItem _IMAPToolStripMenuItem;

        internal ToolStripMenuItem IMAPToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _IMAPToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_IMAPToolStripMenuItem != null)
                {
                    _IMAPToolStripMenuItem.Click -= IMAPToolStripMenuItem_Click;
                }

                _IMAPToolStripMenuItem = value;
                if (_IMAPToolStripMenuItem != null)
                {
                    _IMAPToolStripMenuItem.Click += IMAPToolStripMenuItem_Click;
                }
            }
        }

        private ToolStripMenuItem _POPSSLToolStripMenuItem;

        internal ToolStripMenuItem POPSSLToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _POPSSLToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_POPSSLToolStripMenuItem != null)
                {
                    _POPSSLToolStripMenuItem.Click -= POPSSLToolStripMenuItem_Click;
                }

                _POPSSLToolStripMenuItem = value;
                if (_POPSSLToolStripMenuItem != null)
                {
                    _POPSSLToolStripMenuItem.Click += POPSSLToolStripMenuItem_Click;
                }
            }
        }

        private ToolStripMenuItem _StandardCoporateToolStripMenuItem;

        internal ToolStripMenuItem StandardCoporateToolStripMenuItem
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _StandardCoporateToolStripMenuItem;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_StandardCoporateToolStripMenuItem != null)
                {
                    _StandardCoporateToolStripMenuItem.Click -= StandardCoporateToolStripMenuItem_Click;
                }

                _StandardCoporateToolStripMenuItem = value;
                if (_StandardCoporateToolStripMenuItem != null)
                {
                    _StandardCoporateToolStripMenuItem.Click += StandardCoporateToolStripMenuItem_Click;
                }
            }
        }
    }
}