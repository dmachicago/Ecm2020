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
	[global::Microsoft.VisualBasic.CompilerServices.DesignerGenerated()]public partial class frmExhangeMail : System.Windows.Forms.Form
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
			base.Load += new System.EventHandler(frmExhangeMail_Load);
			this.dgExchange = new System.Windows.Forms.DataGridView();
			this.dgExchange.CellContentClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgExchange_CellContentClick);
			this.dgExchange.MouseDown += new System.Windows.Forms.MouseEventHandler(this.dgExchange_MouseDown);
			this.dgExchange.SelectionChanged += new System.EventHandler(this.dgExchange_SelectionChanged);
			this.Label1 = new System.Windows.Forms.Label();
			this.Label2 = new System.Windows.Forms.Label();
			this.Label3 = new System.Windows.Forms.Label();
			this.Label5 = new System.Windows.Forms.Label();
			this.Label6 = new System.Windows.Forms.Label();
			this.ckSSL = new System.Windows.Forms.CheckBox();
			this.ckDeleteAfterDownload = new System.Windows.Forms.CheckBox();
			this.ckDeleteAfterDownload.CheckedChanged += new System.EventHandler(this.ckDeleteAfterDownload_CheckedChanged);
			this.ckIMap = new System.Windows.Forms.CheckBox();
			this.ckIMap.CheckedChanged += new System.EventHandler(this.ckIMap_CheckedChanged);
			this.Label4 = new System.Windows.Forms.Label();
			this.cbUsers = new System.Windows.Forms.ComboBox();
			this.cbRetention = new System.Windows.Forms.ComboBox();
			this.txtUserLoginID = new System.Windows.Forms.TextBox();
			this.txtPw = new System.Windows.Forms.TextBox();
			this.txtPortNumber = new System.Windows.Forms.TextBox();
			this.cbHostName = new System.Windows.Forms.ComboBox();
			this.btnAdd = new System.Windows.Forms.Button();
			this.btnAdd.Click += new System.EventHandler(this.btnAdd_Click);
			this.btnUpdate = new System.Windows.Forms.Button();
			this.btnUpdate.Click += new System.EventHandler(this.btnUpdate_Click);
			this.btnDelete = new System.Windows.Forms.Button();
			this.btnDelete.Click += new System.EventHandler(this.btnDelete_Click);
			this.SB = new System.Windows.Forms.TextBox();
			this.TT = new System.Windows.Forms.ToolTip(this.components);
			this.txtFolderName = new System.Windows.Forms.TextBox();
			this.cbLibrary = new System.Windows.Forms.ComboBox();
			this.nbrDaysToRetain = new System.Windows.Forms.NumericUpDown();
			this.btnTest = new System.Windows.Forms.Button();
			this.btnTest.Click += new System.EventHandler(this.Button1_Click);
			this.btnTestConnection = new System.Windows.Forms.Button();
			this.btnTestConnection.Click += new System.EventHandler(this.btnTestConnection_Click);
			this.btnShoaAllLib = new System.Windows.Forms.Button();
			this.btnShoaAllLib.Click += new System.EventHandler(this.btnShoaAllLib_Click);
			this.btnEncrypt = new System.Windows.Forms.Button();
			this.btnEncrypt.Click += new System.EventHandler(this.btnEncrypt_Click);
			this.f1Help = new System.Windows.Forms.HelpProvider();
			this.txtUserID = new System.Windows.Forms.TextBox();
			this.MenuStrip1 = new System.Windows.Forms.MenuStrip();
			this.HelpToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.HelpToolStripMenuItem.Click += new System.EventHandler(this.HelpToolStripMenuItem_Click);
			this.ECMLibraryExchangeInterfaceToolStripMenuItem1 = new System.Windows.Forms.ToolStripMenuItem();
			this.ECMLibraryExchangeInterfaceToolStripMenuItem1.Click += new System.EventHandler(this.ECMLibraryExchangeInterfaceToolStripMenuItem1_Click);
			this.Exchange2007Vs2003ToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.Exchange2007Vs2003ToolStripMenuItem.Click += new System.EventHandler(this.Exchange2007Vs2003ToolStripMenuItem_Click);
			this.ExchnageJournalingToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.ExchnageJournalingToolStripMenuItem.Click += new System.EventHandler(this.ExchnageJournalingToolStripMenuItem_Click);
			this.SamplePOPMailScreenToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.SamplePOPMailScreenToolStripMenuItem.Click += new System.EventHandler(this.SamplePOPMailScreenToolStripMenuItem_Click);
			this.SampleIMAPSSLScreenToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.SampleIMAPSSLScreenToolStripMenuItem.Click += new System.EventHandler(this.SampleIMAPSSLScreenToolStripMenuItem_Click);
			this.SampleIMAPScreenToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.SampleIMAPScreenToolStripMenuItem.Click += new System.EventHandler(this.SampleIMAPScreenToolStripMenuItem_Click);
			this.SamplePOPSSLMailScreenToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.SamplePOPSSLMailScreenToolStripMenuItem.Click += new System.EventHandler(this.SamplePOPSSLMailScreenToolStripMenuItem_Click);
			this.SampleCorporateEmailScreenToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.SampleCorporateEmailScreenToolStripMenuItem.Click += new System.EventHandler(this.SampleCorporateEmailScreenToolStripMenuItem_Click);
			this.Label7 = new System.Windows.Forms.Label();
			this.Label8 = new System.Windows.Forms.Label();
			this.ckPublic = new System.Windows.Forms.CheckBox();
			this.Label9 = new System.Windows.Forms.Label();
			this.txtReject = new System.Windows.Forms.TextBox();
			this.Label10 = new System.Windows.Forms.Label();
			this.ckConvertEmlToMsg = new System.Windows.Forms.CheckBox();
			this.btnReset = new System.Windows.Forms.Button();
			this.btnReset.Click += new System.EventHandler(this.btnReset_Click);
			this.ckExcg2003 = new System.Windows.Forms.CheckBox();
			this.ckExcg2003.CheckedChanged += new System.EventHandler(this.ckExcg2003_CheckedChanged);
			this.ckExcg2007 = new System.Windows.Forms.CheckBox();
			this.ckExcg2007.CheckedChanged += new System.EventHandler(this.ckExcg2007_CheckedChanged);
			this.ckRtfFormat = new System.Windows.Forms.CheckBox();
			this.ckPlainText = new System.Windows.Forms.CheckBox();
			this.ckEnvelope = new System.Windows.Forms.CheckBox();
			this.ckJournaled = new System.Windows.Forms.CheckBox();
			this.Panel1 = new System.Windows.Forms.Panel();
			this.ContextMenuStrip1 = new System.Windows.Forms.ContextMenuStrip(this.components);
			this.ComplianceOverviewToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.ComplianceOverviewToolStripMenuItem.Click += new System.EventHandler(this.ComplianceOverviewToolStripMenuItem_Click);
			this.ECMLibraryExchangeInterfaceToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.ExchangeJournalingToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.ExchangeJournalingToolStripMenuItem.Click += new System.EventHandler(this.ExchangeJournalingToolStripMenuItem_Click);
			this.SamplesToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.POPMailToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.POPMailToolStripMenuItem.Click += new System.EventHandler(this.POPMailToolStripMenuItem_Click);
			this.IMAPSSLToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.IMAPSSLToolStripMenuItem.Click += new System.EventHandler(this.IMAPSSLToolStripMenuItem_Click);
			this.IMAPToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.IMAPToolStripMenuItem.Click += new System.EventHandler(this.IMAPToolStripMenuItem_Click);
			this.POPSSLToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.POPSSLToolStripMenuItem.Click += new System.EventHandler(this.POPSSLToolStripMenuItem_Click);
			this.StandardCoporateToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
			this.StandardCoporateToolStripMenuItem.Click += new System.EventHandler(this.StandardCoporateToolStripMenuItem_Click);
			((System.ComponentModel.ISupportInitialize) this.dgExchange).BeginInit();
			((System.ComponentModel.ISupportInitialize) this.nbrDaysToRetain).BeginInit();
			this.MenuStrip1.SuspendLayout();
			this.Panel1.SuspendLayout();
			this.ContextMenuStrip1.SuspendLayout();
			this.SuspendLayout();
			//
			//dgExchange
			//
			this.dgExchange.AllowUserToAddRows = false;
			this.dgExchange.AllowUserToDeleteRows = false;
			this.dgExchange.Anchor = (System.Windows.Forms.AnchorStyles) (((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right);
			this.dgExchange.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.AllCells;
			this.dgExchange.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
			this.dgExchange.Location = new System.Drawing.Point(12, 58);
			this.dgExchange.Name = "dgExchange";
			this.dgExchange.ReadOnly = true;
			this.dgExchange.Size = new System.Drawing.Size(483, 524);
			this.dgExchange.TabIndex = 0;
			this.TT.SetToolTip(this.dgExchange, "Do not update data here, use input fields to the right.");
			//
			//Label1
			//
			this.Label1.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right);
			this.Label1.AutoSize = true;
			this.Label1.Location = new System.Drawing.Point(527, 40);
			this.Label1.Name = "Label1";
			this.Label1.Size = new System.Drawing.Size(60, 13);
			this.Label1.TabIndex = 1;
			this.Label1.Text = "Host Name";
			//
			//Label2
			//
			this.Label2.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right);
			this.Label2.AutoSize = true;
			this.Label2.Location = new System.Drawing.Point(527, 84);
			this.Label2.Name = "Label2";
			this.Label2.Size = new System.Drawing.Size(72, 13);
			this.Label2.TabIndex = 2;
			this.Label2.Text = "User Login ID";
			//
			//Label3
			//
			this.Label3.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right);
			this.Label3.AutoSize = true;
			this.Label3.Location = new System.Drawing.Point(527, 127);
			this.Label3.Name = "Label3";
			this.Label3.Size = new System.Drawing.Size(82, 13);
			this.Label3.TabIndex = 3;
			this.Label3.Text = "Login Password";
			//
			//Label5
			//
			this.Label5.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.Label5.AutoSize = true;
			this.Label5.Location = new System.Drawing.Point(524, 358);
			this.Label5.Name = "Label5";
			this.Label5.Size = new System.Drawing.Size(66, 13);
			this.Label5.TabIndex = 5;
			this.Label5.Text = "Port Number";
			//
			//Label6
			//
			this.Label6.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.Label6.AutoSize = true;
			this.Label6.Location = new System.Drawing.Point(524, 401);
			this.Label6.Name = "Label6";
			this.Label6.Size = new System.Drawing.Size(78, 13);
			this.Label6.TabIndex = 6;
			this.Label6.Text = "RetentionCode";
			//
			//ckSSL
			//
			this.ckSSL.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right);
			this.ckSSL.AutoSize = true;
			this.ckSSL.Location = new System.Drawing.Point(526, 173);
			this.ckSSL.Name = "ckSSL";
			this.ckSSL.Size = new System.Drawing.Size(46, 17);
			this.ckSSL.TabIndex = 7;
			this.ckSSL.Text = "SSL";
			this.ckSSL.UseVisualStyleBackColor = true;
			//
			//ckDeleteAfterDownload
			//
			this.ckDeleteAfterDownload.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right);
			this.ckDeleteAfterDownload.AutoSize = true;
			this.ckDeleteAfterDownload.Location = new System.Drawing.Point(526, 196);
			this.ckDeleteAfterDownload.Name = "ckDeleteAfterDownload";
			this.ckDeleteAfterDownload.Size = new System.Drawing.Size(133, 17);
			this.ckDeleteAfterDownload.TabIndex = 8;
			this.ckDeleteAfterDownload.Text = "Delete After Download";
			this.ckDeleteAfterDownload.UseVisualStyleBackColor = true;
			//
			//ckIMap
			//
			this.ckIMap.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right);
			this.ckIMap.AutoSize = true;
			this.ckIMap.Location = new System.Drawing.Point(610, 173);
			this.ckIMap.Name = "ckIMap";
			this.ckIMap.Size = new System.Drawing.Size(50, 17);
			this.ckIMap.TabIndex = 9;
			this.ckIMap.Text = "IMap";
			this.ckIMap.UseVisualStyleBackColor = true;
			//
			//Label4
			//
			this.Label4.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.Label4.AutoSize = true;
			this.Label4.Location = new System.Drawing.Point(524, 445);
			this.Label4.Name = "Label4";
			this.Label4.Size = new System.Drawing.Size(93, 13);
			this.Label4.TabIndex = 10;
			this.Label4.Text = "Execution User ID";
			//
			//cbUsers
			//
			this.cbUsers.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.cbUsers.FormattingEnabled = true;
			this.cbUsers.Location = new System.Drawing.Point(524, 463);
			this.cbUsers.Name = "cbUsers";
			this.cbUsers.Size = new System.Drawing.Size(294, 21);
			this.cbUsers.TabIndex = 11;
			this.TT.SetToolTip(this.cbUsers, "Leave blank to default to your ID or Set this ID to be different than your curren" + "t ID if another user is to run this utility.");
			//
			//cbRetention
			//
			this.cbRetention.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.cbRetention.FormattingEnabled = true;
			this.cbRetention.Location = new System.Drawing.Point(524, 419);
			this.cbRetention.Name = "cbRetention";
			this.cbRetention.Size = new System.Drawing.Size(294, 21);
			this.cbRetention.TabIndex = 12;
			//
			//txtUserLoginID
			//
			this.txtUserLoginID.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right);
			this.txtUserLoginID.Location = new System.Drawing.Point(527, 102);
			this.txtUserLoginID.Name = "txtUserLoginID";
			this.txtUserLoginID.Size = new System.Drawing.Size(294, 20);
			this.txtUserLoginID.TabIndex = 14;
			//
			//txtPw
			//
			this.txtPw.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right);
			this.txtPw.Location = new System.Drawing.Point(527, 145);
			this.txtPw.Name = "txtPw";
			this.txtPw.Size = new System.Drawing.Size(179, 20);
			this.txtPw.TabIndex = 15;
			//
			//txtPortNumber
			//
			this.txtPortNumber.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.txtPortNumber.Location = new System.Drawing.Point(524, 376);
			this.txtPortNumber.Name = "txtPortNumber";
			this.txtPortNumber.Size = new System.Drawing.Size(110, 20);
			this.txtPortNumber.TabIndex = 16;
			//
			//cbHostName
			//
			this.cbHostName.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right);
			this.cbHostName.FormattingEnabled = true;
			this.cbHostName.Location = new System.Drawing.Point(527, 58);
			this.cbHostName.Name = "cbHostName";
			this.cbHostName.Size = new System.Drawing.Size(294, 21);
			this.cbHostName.TabIndex = 17;
			this.TT.SetToolTip(this.cbHostName, "For a sample of how to fill this out, please click the help menu.");
			//
			//btnAdd
			//
			this.btnAdd.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.btnAdd.Location = new System.Drawing.Point(640, 611);
			this.btnAdd.Name = "btnAdd";
			this.btnAdd.Size = new System.Drawing.Size(53, 36);
			this.btnAdd.TabIndex = 18;
			this.btnAdd.Text = "&Insert";
			this.btnAdd.UseVisualStyleBackColor = true;
			//
			//btnUpdate
			//
			this.btnUpdate.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.btnUpdate.Location = new System.Drawing.Point(699, 611);
			this.btnUpdate.Name = "btnUpdate";
			this.btnUpdate.Size = new System.Drawing.Size(53, 36);
			this.btnUpdate.TabIndex = 19;
			this.btnUpdate.Text = "&Update";
			this.btnUpdate.UseVisualStyleBackColor = true;
			//
			//btnDelete
			//
			this.btnDelete.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.btnDelete.Location = new System.Drawing.Point(767, 611);
			this.btnDelete.Name = "btnDelete";
			this.btnDelete.Size = new System.Drawing.Size(53, 36);
			this.btnDelete.TabIndex = 20;
			this.btnDelete.Text = "&Delete";
			this.btnDelete.UseVisualStyleBackColor = true;
			//
			//SB
			//
			this.SB.Anchor = (System.Windows.Forms.AnchorStyles) ((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right);
			this.SB.BackColor = System.Drawing.Color.FromArgb(System.Convert.ToInt32((byte) (255)), System.Convert.ToInt32((byte) (255)), System.Convert.ToInt32((byte) (192)));
			this.SB.Enabled = false;
			this.SB.Location = new System.Drawing.Point(92, 663);
			this.SB.Name = "SB";
			this.SB.Size = new System.Drawing.Size(403, 20);
			this.SB.TabIndex = 21;
			//
			//txtFolderName
			//
			this.txtFolderName.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.txtFolderName.Enabled = false;
			this.txtFolderName.Location = new System.Drawing.Point(652, 376);
			this.txtFolderName.Name = "txtFolderName";
			this.txtFolderName.Size = new System.Drawing.Size(165, 20);
			this.txtFolderName.TabIndex = 25;
			this.TT.SetToolTip(this.txtFolderName, "Used in an IMAP definition.");
			//
			//cbLibrary
			//
			this.cbLibrary.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.cbLibrary.FormattingEnabled = true;
			this.cbLibrary.Location = new System.Drawing.Point(524, 514);
			this.cbLibrary.Name = "cbLibrary";
			this.cbLibrary.Size = new System.Drawing.Size(269, 21);
			this.cbLibrary.TabIndex = 28;
			this.TT.SetToolTip(this.cbLibrary, "Leave blank to default to your ID or Set this ID to be different than your curren" + "t ID if another user is to run this utility.");
			//
			//nbrDaysToRetain
			//
			this.nbrDaysToRetain.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right);
			this.nbrDaysToRetain.Location = new System.Drawing.Point(773, 194);
			this.nbrDaysToRetain.Maximum = new decimal(new int[] {1000, 0, 0, 0});
			this.nbrDaysToRetain.Name = "nbrDaysToRetain";
			this.nbrDaysToRetain.Size = new System.Drawing.Size(56, 20);
			this.nbrDaysToRetain.TabIndex = 31;
			this.TT.SetToolTip(this.nbrDaysToRetain, "Zero means delete when downloaded");
			//
			//btnTest
			//
			this.btnTest.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.btnTest.Location = new System.Drawing.Point(526, 611);
			this.btnTest.Name = "btnTest";
			this.btnTest.Size = new System.Drawing.Size(53, 36);
			this.btnTest.TabIndex = 32;
			this.btnTest.Text = "Show All";
			this.TT.SetToolTip(this.btnTest, "Show the appropriate list of defined Exchange mail boxes.");
			this.btnTest.UseVisualStyleBackColor = true;
			//
			//btnTestConnection
			//
			this.btnTestConnection.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right);
			this.btnTestConnection.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch;
			this.btnTestConnection.Location = new System.Drawing.Point(829, 53);
			this.btnTestConnection.Name = "btnTestConnection";
			this.btnTestConnection.Size = new System.Drawing.Size(30, 31);
			this.btnTestConnection.TabIndex = 40;
			this.TT.SetToolTip(this.btnTestConnection, "Press to test the connection to the server.");
			this.btnTestConnection.UseVisualStyleBackColor = true;
			//
			//btnShoaAllLib
			//
			this.btnShoaAllLib.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.btnShoaAllLib.Location = new System.Drawing.Point(810, 514);
			this.btnShoaAllLib.Name = "btnShoaAllLib";
			this.btnShoaAllLib.Size = new System.Drawing.Size(19, 20);
			this.btnShoaAllLib.TabIndex = 41;
			this.TT.SetToolTip(this.btnShoaAllLib, "Show all libraries in system to choose from.");
			this.btnShoaAllLib.UseVisualStyleBackColor = true;
			//
			//btnEncrypt
			//
			this.btnEncrypt.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right);
			this.btnEncrypt.Location = new System.Drawing.Point(717, 145);
			this.btnEncrypt.Name = "btnEncrypt";
			this.btnEncrypt.Size = new System.Drawing.Size(103, 20);
			this.btnEncrypt.TabIndex = 22;
			this.btnEncrypt.Text = "Encrypt PW";
			this.btnEncrypt.UseVisualStyleBackColor = true;
			//
			//f1Help
			//
			this.f1Help.HelpNamespace = "http://www.ecmlibrary.com/helpfiles/frmExchangeMail.htm";
			//
			//txtUserID
			//
			this.txtUserID.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.txtUserID.Enabled = false;
			this.txtUserID.Location = new System.Drawing.Point(527, 656);
			this.txtUserID.Name = "txtUserID";
			this.txtUserID.Size = new System.Drawing.Size(293, 20);
			this.txtUserID.TabIndex = 23;
			//
			//MenuStrip1
			//
			this.MenuStrip1.BackColor = System.Drawing.Color.Transparent;
			this.MenuStrip1.Dock = System.Windows.Forms.DockStyle.None;
			this.MenuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {this.HelpToolStripMenuItem});
			this.MenuStrip1.Location = new System.Drawing.Point(0, 0);
			this.MenuStrip1.Name = "MenuStrip1";
			this.MenuStrip1.Size = new System.Drawing.Size(48, 24);
			this.MenuStrip1.TabIndex = 24;
			this.MenuStrip1.Text = "MenuStrip1";
			//
			//HelpToolStripMenuItem
			//
			this.HelpToolStripMenuItem.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Text;
			this.HelpToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {this.ECMLibraryExchangeInterfaceToolStripMenuItem1, this.Exchange2007Vs2003ToolStripMenuItem, this.ExchnageJournalingToolStripMenuItem, this.SamplePOPMailScreenToolStripMenuItem, this.SampleIMAPSSLScreenToolStripMenuItem, this.SampleIMAPScreenToolStripMenuItem, this.SamplePOPSSLMailScreenToolStripMenuItem, this.SampleCorporateEmailScreenToolStripMenuItem});
			this.HelpToolStripMenuItem.Name = "HelpToolStripMenuItem";
			this.HelpToolStripMenuItem.ShortcutKeys = (System.Windows.Forms.Keys) (System.Windows.Forms.Keys.Control | System.Windows.Forms.Keys.F1);
			this.HelpToolStripMenuItem.Size = new System.Drawing.Size(40, 20);
			this.HelpToolStripMenuItem.Text = "&Help";
			//
			//ECMLibraryExchangeInterfaceToolStripMenuItem1
			//
			this.ECMLibraryExchangeInterfaceToolStripMenuItem1.Name = "ECMLibraryExchangeInterfaceToolStripMenuItem1";
			this.ECMLibraryExchangeInterfaceToolStripMenuItem1.Size = new System.Drawing.Size(312, 22);
			this.ECMLibraryExchangeInterfaceToolStripMenuItem1.Text = "ECM Library Exchange Interface";
			//
			//Exchange2007Vs2003ToolStripMenuItem
			//
			this.Exchange2007Vs2003ToolStripMenuItem.Name = "Exchange2007Vs2003ToolStripMenuItem";
			this.Exchange2007Vs2003ToolStripMenuItem.Size = new System.Drawing.Size(312, 22);
			this.Exchange2007Vs2003ToolStripMenuItem.Text = "Microsoft Exchange Server 2007 Compliance Tour";
			//
			//ExchnageJournalingToolStripMenuItem
			//
			this.ExchnageJournalingToolStripMenuItem.Name = "ExchnageJournalingToolStripMenuItem";
			this.ExchnageJournalingToolStripMenuItem.Size = new System.Drawing.Size(312, 22);
			this.ExchnageJournalingToolStripMenuItem.Text = "Exchange Journaling";
			//
			//SamplePOPMailScreenToolStripMenuItem
			//
			this.SamplePOPMailScreenToolStripMenuItem.Name = "SamplePOPMailScreenToolStripMenuItem";
			this.SamplePOPMailScreenToolStripMenuItem.Size = new System.Drawing.Size(312, 22);
			this.SamplePOPMailScreenToolStripMenuItem.Text = "Sample POP Mail Screen";
			//
			//SampleIMAPSSLScreenToolStripMenuItem
			//
			this.SampleIMAPSSLScreenToolStripMenuItem.Name = "SampleIMAPSSLScreenToolStripMenuItem";
			this.SampleIMAPSSLScreenToolStripMenuItem.Size = new System.Drawing.Size(312, 22);
			this.SampleIMAPSSLScreenToolStripMenuItem.Text = "Sample IMAP SSL Screen";
			//
			//SampleIMAPScreenToolStripMenuItem
			//
			this.SampleIMAPScreenToolStripMenuItem.Name = "SampleIMAPScreenToolStripMenuItem";
			this.SampleIMAPScreenToolStripMenuItem.Size = new System.Drawing.Size(312, 22);
			this.SampleIMAPScreenToolStripMenuItem.Text = "Sample IMAP Screen";
			//
			//SamplePOPSSLMailScreenToolStripMenuItem
			//
			this.SamplePOPSSLMailScreenToolStripMenuItem.Name = "SamplePOPSSLMailScreenToolStripMenuItem";
			this.SamplePOPSSLMailScreenToolStripMenuItem.Size = new System.Drawing.Size(312, 22);
			this.SamplePOPSSLMailScreenToolStripMenuItem.Text = "Sample POP SSL Mail Screen";
			//
			//SampleCorporateEmailScreenToolStripMenuItem
			//
			this.SampleCorporateEmailScreenToolStripMenuItem.Name = "SampleCorporateEmailScreenToolStripMenuItem";
			this.SampleCorporateEmailScreenToolStripMenuItem.Size = new System.Drawing.Size(312, 22);
			this.SampleCorporateEmailScreenToolStripMenuItem.Text = "Sample Corporate Email Screen";
			//
			//Label7
			//
			this.Label7.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.Label7.AutoSize = true;
			this.Label7.Location = new System.Drawing.Point(649, 360);
			this.Label7.Name = "Label7";
			this.Label7.Size = new System.Drawing.Size(74, 13);
			this.Label7.TabIndex = 26;
			this.Label7.Text = "Mailbox Name";
			//
			//Label8
			//
			this.Label8.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.Label8.AutoSize = true;
			this.Label8.Location = new System.Drawing.Point(524, 496);
			this.Label8.Name = "Label8";
			this.Label8.Size = new System.Drawing.Size(80, 13);
			this.Label8.TabIndex = 27;
			this.Label8.Text = "Select a Library";
			//
			//ckPublic
			//
			this.ckPublic.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.ckPublic.AutoSize = true;
			this.ckPublic.Location = new System.Drawing.Point(524, 548);
			this.ckPublic.Name = "ckPublic";
			this.ckPublic.Size = new System.Drawing.Size(295, 17);
			this.ckPublic.TabIndex = 29;
			this.ckPublic.Text = "Make all emails in this archive available for Public access";
			this.ckPublic.UseVisualStyleBackColor = true;
			//
			//Label9
			//
			this.Label9.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right);
			this.Label9.AutoSize = true;
			this.Label9.Location = new System.Drawing.Point(665, 198);
			this.Label9.Name = "Label9";
			this.Label9.Size = new System.Drawing.Size(102, 13);
			this.Label9.TabIndex = 30;
			this.Label9.Text = "or Delete after days:";
			//
			//txtReject
			//
			this.txtReject.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.txtReject.Location = new System.Drawing.Point(526, 585);
			this.txtReject.Name = "txtReject";
			this.txtReject.Size = new System.Drawing.Size(293, 20);
			this.txtReject.TabIndex = 33;
			//
			//Label10
			//
			this.Label10.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.Label10.AutoSize = true;
			this.Label10.Location = new System.Drawing.Point(526, 569);
			this.Label10.Name = "Label10";
			this.Label10.Size = new System.Drawing.Size(131, 13);
			this.Label10.TabIndex = 34;
			this.Label10.Text = "Reject if Subject contains:";
			//
			//ckConvertEmlToMsg
			//
			this.ckConvertEmlToMsg.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right);
			this.ckConvertEmlToMsg.AutoSize = true;
			this.ckConvertEmlToMsg.Location = new System.Drawing.Point(537, 308);
			this.ckConvertEmlToMsg.Name = "ckConvertEmlToMsg";
			this.ckConvertEmlToMsg.Size = new System.Drawing.Size(230, 17);
			this.ckConvertEmlToMsg.TabIndex = 35;
			this.ckConvertEmlToMsg.Text = "Convert all emails in this folder to MSG files.";
			this.ckConvertEmlToMsg.UseVisualStyleBackColor = true;
			//
			//btnReset
			//
			this.btnReset.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.btnReset.Location = new System.Drawing.Point(12, 663);
			this.btnReset.Name = "btnReset";
			this.btnReset.Size = new System.Drawing.Size(53, 22);
			this.btnReset.TabIndex = 37;
			this.btnReset.Text = "Reset";
			this.btnReset.UseVisualStyleBackColor = true;
			this.btnReset.Visible = false;
			//
			//ckExcg2003
			//
			this.ckExcg2003.AutoSize = true;
			this.ckExcg2003.Location = new System.Drawing.Point(12, 29);
			this.ckExcg2003.Name = "ckExcg2003";
			this.ckExcg2003.Size = new System.Drawing.Size(101, 17);
			this.ckExcg2003.TabIndex = 1;
			this.ckExcg2003.Text = "Exchange 2003";
			this.ckExcg2003.UseVisualStyleBackColor = true;
			//
			//ckExcg2007
			//
			this.ckExcg2007.AutoSize = true;
			this.ckExcg2007.Location = new System.Drawing.Point(12, 6);
			this.ckExcg2007.Name = "ckExcg2007";
			this.ckExcg2007.Size = new System.Drawing.Size(101, 17);
			this.ckExcg2007.TabIndex = 2;
			this.ckExcg2007.Text = "Exchange 2007";
			this.ckExcg2007.UseVisualStyleBackColor = true;
			//
			//ckRtfFormat
			//
			this.ckRtfFormat.AutoSize = true;
			this.ckRtfFormat.Location = new System.Drawing.Point(161, 6);
			this.ckRtfFormat.Name = "ckRtfFormat";
			this.ckRtfFormat.Size = new System.Drawing.Size(47, 17);
			this.ckRtfFormat.TabIndex = 3;
			this.ckRtfFormat.Text = "RTF";
			this.ckRtfFormat.UseVisualStyleBackColor = true;
			//
			//ckPlainText
			//
			this.ckPlainText.AutoSize = true;
			this.ckPlainText.Location = new System.Drawing.Point(161, 30);
			this.ckPlainText.Name = "ckPlainText";
			this.ckPlainText.Size = new System.Drawing.Size(73, 17);
			this.ckPlainText.TabIndex = 4;
			this.ckPlainText.Text = "Plain Text";
			this.ckPlainText.UseVisualStyleBackColor = true;
			//
			//ckEnvelope
			//
			this.ckEnvelope.AutoSize = true;
			this.ckEnvelope.Location = new System.Drawing.Point(161, 54);
			this.ckEnvelope.Name = "ckEnvelope";
			this.ckEnvelope.Size = new System.Drawing.Size(71, 17);
			this.ckEnvelope.TabIndex = 5;
			this.ckEnvelope.Text = "Envelope";
			this.ckEnvelope.UseVisualStyleBackColor = true;
			//
			//ckJournaled
			//
			this.ckJournaled.AutoSize = true;
			this.ckJournaled.Location = new System.Drawing.Point(12, 54);
			this.ckJournaled.Name = "ckJournaled";
			this.ckJournaled.Size = new System.Drawing.Size(99, 17);
			this.ckJournaled.TabIndex = 6;
			this.ckJournaled.Text = "Journal Mailbox";
			this.ckJournaled.UseVisualStyleBackColor = true;
			//
			//Panel1
			//
			this.Panel1.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right);
			this.Panel1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
			this.Panel1.Controls.Add(this.ckJournaled);
			this.Panel1.Controls.Add(this.ckEnvelope);
			this.Panel1.Controls.Add(this.ckPlainText);
			this.Panel1.Controls.Add(this.ckRtfFormat);
			this.Panel1.Controls.Add(this.ckExcg2007);
			this.Panel1.Controls.Add(this.ckExcg2003);
			this.Panel1.Enabled = false;
			this.Panel1.Location = new System.Drawing.Point(536, 219);
			this.Panel1.Name = "Panel1";
			this.Panel1.Size = new System.Drawing.Size(283, 83);
			this.Panel1.TabIndex = 38;
			//
			//ContextMenuStrip1
			//
			this.ContextMenuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {this.ComplianceOverviewToolStripMenuItem, this.ECMLibraryExchangeInterfaceToolStripMenuItem, this.ExchangeJournalingToolStripMenuItem, this.SamplesToolStripMenuItem});
			this.ContextMenuStrip1.Name = "ContextMenuStrip1";
			this.ContextMenuStrip1.Size = new System.Drawing.Size(241, 92);
			//
			//ComplianceOverviewToolStripMenuItem
			//
			this.ComplianceOverviewToolStripMenuItem.Name = "ComplianceOverviewToolStripMenuItem";
			this.ComplianceOverviewToolStripMenuItem.Size = new System.Drawing.Size(240, 22);
			this.ComplianceOverviewToolStripMenuItem.Text = "Compliance Overview";
			//
			//ECMLibraryExchangeInterfaceToolStripMenuItem
			//
			this.ECMLibraryExchangeInterfaceToolStripMenuItem.Name = "ECMLibraryExchangeInterfaceToolStripMenuItem";
			this.ECMLibraryExchangeInterfaceToolStripMenuItem.Size = new System.Drawing.Size(240, 22);
			this.ECMLibraryExchangeInterfaceToolStripMenuItem.Text = "ECM Library Exchange Interface";
			//
			//ExchangeJournalingToolStripMenuItem
			//
			this.ExchangeJournalingToolStripMenuItem.Name = "ExchangeJournalingToolStripMenuItem";
			this.ExchangeJournalingToolStripMenuItem.Size = new System.Drawing.Size(240, 22);
			this.ExchangeJournalingToolStripMenuItem.Text = "Exchange Journaling";
			//
			//SamplesToolStripMenuItem
			//
			this.SamplesToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {this.POPMailToolStripMenuItem, this.IMAPSSLToolStripMenuItem, this.IMAPToolStripMenuItem, this.POPSSLToolStripMenuItem, this.StandardCoporateToolStripMenuItem});
			this.SamplesToolStripMenuItem.Name = "SamplesToolStripMenuItem";
			this.SamplesToolStripMenuItem.Size = new System.Drawing.Size(240, 22);
			this.SamplesToolStripMenuItem.Text = "Samples";
			//
			//POPMailToolStripMenuItem
			//
			this.POPMailToolStripMenuItem.Name = "POPMailToolStripMenuItem";
			this.POPMailToolStripMenuItem.Size = new System.Drawing.Size(166, 22);
			this.POPMailToolStripMenuItem.Text = "POP Mail";
			//
			//IMAPSSLToolStripMenuItem
			//
			this.IMAPSSLToolStripMenuItem.Name = "IMAPSSLToolStripMenuItem";
			this.IMAPSSLToolStripMenuItem.Size = new System.Drawing.Size(166, 22);
			this.IMAPSSLToolStripMenuItem.Text = "IMAP SSL";
			//
			//IMAPToolStripMenuItem
			//
			this.IMAPToolStripMenuItem.Name = "IMAPToolStripMenuItem";
			this.IMAPToolStripMenuItem.Size = new System.Drawing.Size(166, 22);
			this.IMAPToolStripMenuItem.Text = "IMAP ";
			//
			//POPSSLToolStripMenuItem
			//
			this.POPSSLToolStripMenuItem.Name = "POPSSLToolStripMenuItem";
			this.POPSSLToolStripMenuItem.Size = new System.Drawing.Size(166, 22);
			this.POPSSLToolStripMenuItem.Text = "POP SSL";
			//
			//StandardCoporateToolStripMenuItem
			//
			this.StandardCoporateToolStripMenuItem.Name = "StandardCoporateToolStripMenuItem";
			this.StandardCoporateToolStripMenuItem.Size = new System.Drawing.Size(166, 22);
			this.StandardCoporateToolStripMenuItem.Text = "Standard Coporate";
			//
			//frmExhangeMail
			//
			this.AutoScaleDimensions = new System.Drawing.SizeF((float) (6.0F), (float) (13.0F));
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.BackColor = System.Drawing.SystemColors.ActiveBorder;
			this.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch;
			this.ClientSize = new System.Drawing.Size(867, 697);
			this.Controls.Add(this.btnShoaAllLib);
			this.Controls.Add(this.btnTestConnection);
			this.Controls.Add(this.Panel1);
			this.Controls.Add(this.btnReset);
			this.Controls.Add(this.ckConvertEmlToMsg);
			this.Controls.Add(this.Label10);
			this.Controls.Add(this.txtReject);
			this.Controls.Add(this.btnTest);
			this.Controls.Add(this.nbrDaysToRetain);
			this.Controls.Add(this.Label9);
			this.Controls.Add(this.ckPublic);
			this.Controls.Add(this.cbLibrary);
			this.Controls.Add(this.Label8);
			this.Controls.Add(this.Label7);
			this.Controls.Add(this.txtFolderName);
			this.Controls.Add(this.txtUserID);
			this.Controls.Add(this.btnEncrypt);
			this.Controls.Add(this.SB);
			this.Controls.Add(this.btnDelete);
			this.Controls.Add(this.btnUpdate);
			this.Controls.Add(this.btnAdd);
			this.Controls.Add(this.cbHostName);
			this.Controls.Add(this.txtPortNumber);
			this.Controls.Add(this.txtPw);
			this.Controls.Add(this.txtUserLoginID);
			this.Controls.Add(this.cbRetention);
			this.Controls.Add(this.cbUsers);
			this.Controls.Add(this.Label4);
			this.Controls.Add(this.ckIMap);
			this.Controls.Add(this.ckDeleteAfterDownload);
			this.Controls.Add(this.ckSSL);
			this.Controls.Add(this.Label6);
			this.Controls.Add(this.Label5);
			this.Controls.Add(this.Label3);
			this.Controls.Add(this.Label2);
			this.Controls.Add(this.Label1);
			this.Controls.Add(this.dgExchange);
			this.Controls.Add(this.MenuStrip1);
			this.f1Help.SetHelpString(this, "http://www.ecmlibrary.com/helpfiles/frmExchangeMail.htm");
			this.MainMenuStrip = this.MenuStrip1;
			this.Name = "frmExhangeMail";
			this.f1Help.SetShowHelp(this, true);
			this.Text = "Exhange Mail";
			((System.ComponentModel.ISupportInitialize) this.dgExchange).EndInit();
			((System.ComponentModel.ISupportInitialize) this.nbrDaysToRetain).EndInit();
			this.MenuStrip1.ResumeLayout(false);
			this.MenuStrip1.PerformLayout();
			this.Panel1.ResumeLayout(false);
			this.Panel1.PerformLayout();
			this.ContextMenuStrip1.ResumeLayout(false);
			this.ResumeLayout(false);
			this.PerformLayout();
			
		}
		internal System.Windows.Forms.DataGridView dgExchange;
		internal System.Windows.Forms.Label Label1;
		internal System.Windows.Forms.Label Label2;
		internal System.Windows.Forms.Label Label3;
		internal System.Windows.Forms.Label Label5;
		internal System.Windows.Forms.Label Label6;
		internal System.Windows.Forms.CheckBox ckSSL;
		internal System.Windows.Forms.CheckBox ckDeleteAfterDownload;
		internal System.Windows.Forms.CheckBox ckIMap;
		internal System.Windows.Forms.Label Label4;
		internal System.Windows.Forms.ComboBox cbUsers;
		internal System.Windows.Forms.ComboBox cbRetention;
		internal System.Windows.Forms.TextBox txtUserLoginID;
		internal System.Windows.Forms.TextBox txtPw;
		internal System.Windows.Forms.TextBox txtPortNumber;
		internal System.Windows.Forms.ComboBox cbHostName;
		internal System.Windows.Forms.Button btnAdd;
		internal System.Windows.Forms.Button btnUpdate;
		internal System.Windows.Forms.Button btnDelete;
		internal System.Windows.Forms.TextBox SB;
		internal System.Windows.Forms.ToolTip TT;
		internal System.Windows.Forms.Button btnEncrypt;
		internal System.Windows.Forms.HelpProvider f1Help;
		internal System.Windows.Forms.TextBox txtUserID;
		internal System.Windows.Forms.MenuStrip MenuStrip1;
		internal System.Windows.Forms.ToolStripMenuItem HelpToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem ECMLibraryExchangeInterfaceToolStripMenuItem1;
		internal System.Windows.Forms.ToolStripMenuItem Exchange2007Vs2003ToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem ExchnageJournalingToolStripMenuItem;
		internal System.Windows.Forms.TextBox txtFolderName;
		internal System.Windows.Forms.Label Label7;
		internal System.Windows.Forms.ComboBox cbLibrary;
		internal System.Windows.Forms.Label Label8;
		internal System.Windows.Forms.CheckBox ckPublic;
		internal System.Windows.Forms.Label Label9;
		internal System.Windows.Forms.NumericUpDown nbrDaysToRetain;
		internal System.Windows.Forms.Button btnTest;
		internal System.Windows.Forms.TextBox txtReject;
		internal System.Windows.Forms.Label Label10;
		internal System.Windows.Forms.CheckBox ckConvertEmlToMsg;
		internal System.Windows.Forms.Button btnReset;
		internal System.Windows.Forms.CheckBox ckExcg2003;
		internal System.Windows.Forms.CheckBox ckExcg2007;
		internal System.Windows.Forms.CheckBox ckRtfFormat;
		internal System.Windows.Forms.CheckBox ckPlainText;
		internal System.Windows.Forms.CheckBox ckEnvelope;
		internal System.Windows.Forms.CheckBox ckJournaled;
		internal System.Windows.Forms.Panel Panel1;
		internal System.Windows.Forms.Button btnTestConnection;
		internal System.Windows.Forms.Button btnShoaAllLib;
		internal System.Windows.Forms.ToolStripMenuItem SamplePOPMailScreenToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem SampleIMAPSSLScreenToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem SampleIMAPScreenToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem SamplePOPSSLMailScreenToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem SampleCorporateEmailScreenToolStripMenuItem;
		internal System.Windows.Forms.ContextMenuStrip ContextMenuStrip1;
		internal System.Windows.Forms.ToolStripMenuItem ComplianceOverviewToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem ECMLibraryExchangeInterfaceToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem ExchangeJournalingToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem SamplesToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem POPMailToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem IMAPSSLToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem IMAPToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem POPSSLToolStripMenuItem;
		internal System.Windows.Forms.ToolStripMenuItem StandardCoporateToolStripMenuItem;
	}
	
}
