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
	[global::Microsoft.VisualBasic.CompilerServices.DesignerGenerated()]public partial class frmLicense : System.Windows.Forms.Form
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
			base.Load += new System.EventHandler(frmLicense_Load);
			this.btnGetfile = new System.Windows.Forms.Button();
			this.btnGetfile.Click += new System.EventHandler(this.btnGetfile_Click);
			this.btnLoadFile = new System.Windows.Forms.Button();
			this.btnLoadFile.Click += new System.EventHandler(this.btnLoadFile_Click);
			this.txtFqn = new System.Windows.Forms.TextBox();
			this.txtLicense = new System.Windows.Forms.TextBox();
			this.btnPasteLicense = new System.Windows.Forms.Button();
			this.btnPasteLicense.Click += new System.EventHandler(this.btnPasteLicense_Click);
			this.OpenFileDialog1 = new System.Windows.Forms.OpenFileDialog();
			this.SB = new System.Windows.Forms.TextBox();
			this.TT = new System.Windows.Forms.ToolTip(this.components);
			this.btnRemote = new System.Windows.Forms.Button();
			this.btnRemote.Click += new System.EventHandler(this.btnRemote_Click);
			this.btnApplySelLic = new System.Windows.Forms.Button();
			this.btnApplySelLic.Click += new System.EventHandler(this.btnApplySelLic_Click);
			this.btnShowCurrentDB = new System.Windows.Forms.Button();
			this.btnShowCurrentDB.Click += new System.EventHandler(this.btnShowCurrentDB_Click);
			this.btnSetEqual = new System.Windows.Forms.Button();
			this.btnSetEqual.Click += new System.EventHandler(this.btnSetEqual_Click);
			this.btnGetCustID = new System.Windows.Forms.Button();
			this.btnGetCustID.Click += new System.EventHandler(this.btnGetCustID_Click);
			this.Timer1 = new System.Windows.Forms.Timer(this.components);
			this.Timer1.Tick += new System.EventHandler(this.Timer1_Tick);
			this.btnDisplay = new System.Windows.Forms.Button();
			this.btnDisplay.Click += new System.EventHandler(this.btnDisplay_Click);
			this.Label1 = new System.Windows.Forms.Label();
			this.txtCompanyID = new System.Windows.Forms.TextBox();
			this.Label2 = new System.Windows.Forms.Label();
			this.dgLicense = new System.Windows.Forms.DataGridView();
			this.dgLicense.CellContentClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgLicense_CellContentClick);
			this.dgLicense.SelectionChanged += new System.EventHandler(this.dgLicense_SelectionChanged);
			this.f1Help = new System.Windows.Forms.HelpProvider();
			this.txtSqlServerMachineName = new System.Windows.Forms.TextBox();
			this.Label3 = new System.Windows.Forms.Label();
			this.txtServers = new System.Windows.Forms.TextBox();
			((System.ComponentModel.ISupportInitialize) this.dgLicense).BeginInit();
			this.SuspendLayout();
			//
			//btnGetfile
			//
			this.btnGetfile.Location = new System.Drawing.Point(685, 239);
			this.btnGetfile.Name = "btnGetfile";
			this.btnGetfile.Size = new System.Drawing.Size(147, 33);
			this.btnGetfile.TabIndex = 0;
			this.btnGetfile.Text = "Find License File";
			this.TT.SetToolTip(this.btnGetfile, "Locate the license file in a specified directory and then \"Load License File\"");
			this.btnGetfile.UseVisualStyleBackColor = true;
			//
			//btnLoadFile
			//
			this.btnLoadFile.Location = new System.Drawing.Point(685, 278);
			this.btnLoadFile.Name = "btnLoadFile";
			this.btnLoadFile.Size = new System.Drawing.Size(147, 33);
			this.btnLoadFile.TabIndex = 1;
			this.btnLoadFile.Text = "Load License File";
			this.TT.SetToolTip(this.btnLoadFile, "Once you locate the license file in a specified directory, then press \"Load Licen" + "se File\"");
			this.btnLoadFile.UseVisualStyleBackColor = true;
			//
			//txtFqn
			//
			this.txtFqn.Location = new System.Drawing.Point(10, 33);
			this.txtFqn.Name = "txtFqn";
			this.txtFqn.Size = new System.Drawing.Size(669, 20);
			this.txtFqn.TabIndex = 2;
			//
			//txtLicense
			//
			this.txtLicense.Location = new System.Drawing.Point(10, 59);
			this.txtLicense.Multiline = true;
			this.txtLicense.Name = "txtLicense";
			this.txtLicense.Size = new System.Drawing.Size(669, 133);
			this.txtLicense.TabIndex = 3;
			this.TT.SetToolTip(this.txtLicense, "Paste the encryted license data in this window.");
			//
			//btnPasteLicense
			//
			this.btnPasteLicense.Location = new System.Drawing.Point(685, 317);
			this.btnPasteLicense.Name = "btnPasteLicense";
			this.btnPasteLicense.Size = new System.Drawing.Size(147, 33);
			this.btnPasteLicense.TabIndex = 4;
			this.btnPasteLicense.Text = "Apply License from Textbox";
			this.TT.SetToolTip(this.btnPasteLicense, "Copy the encrypted license into the window to the left and then Press this button" + ".");
			this.btnPasteLicense.UseVisualStyleBackColor = true;
			//
			//OpenFileDialog1
			//
			this.OpenFileDialog1.FileName = "OpenFileDialog1";
			//
			//SB
			//
			this.SB.BackColor = System.Drawing.Color.FromArgb(System.Convert.ToInt32((byte) (255)), System.Convert.ToInt32((byte) (255)), System.Convert.ToInt32((byte) (192)));
			this.SB.Enabled = false;
			this.SB.Location = new System.Drawing.Point(6, 471);
			this.SB.Name = "SB";
			this.SB.Size = new System.Drawing.Size(669, 20);
			this.SB.TabIndex = 5;
			//
			//btnRemote
			//
			this.btnRemote.Location = new System.Drawing.Point(685, 419);
			this.btnRemote.Name = "btnRemote";
			this.btnRemote.Size = new System.Drawing.Size(147, 70);
			this.btnRemote.TabIndex = 11;
			this.btnRemote.Text = "Fetch Available Licenses from ECM License Server";
			this.TT.SetToolTip(this.btnRemote, "Fetch License from ECM license server.");
			this.btnRemote.UseVisualStyleBackColor = true;
			//
			//btnApplySelLic
			//
			this.btnApplySelLic.Location = new System.Drawing.Point(685, 59);
			this.btnApplySelLic.Name = "btnApplySelLic";
			this.btnApplySelLic.Size = new System.Drawing.Size(147, 70);
			this.btnApplySelLic.TabIndex = 15;
			this.btnApplySelLic.Text = "Apply Selected License";
			this.TT.SetToolTip(this.btnApplySelLic, "Apply the selected license to the appropriate server.");
			this.btnApplySelLic.UseVisualStyleBackColor = true;
			//
			//btnShowCurrentDB
			//
			this.btnShowCurrentDB.Location = new System.Drawing.Point(12, 6);
			this.btnShowCurrentDB.Name = "btnShowCurrentDB";
			this.btnShowCurrentDB.Size = new System.Drawing.Size(24, 21);
			this.btnShowCurrentDB.TabIndex = 17;
			this.btnShowCurrentDB.Text = "@";
			this.TT.SetToolTip(this.btnShowCurrentDB, "Show the current User and DB information");
			this.btnShowCurrentDB.UseVisualStyleBackColor = true;
			this.btnShowCurrentDB.Visible = false;
			//
			//btnSetEqual
			//
			this.btnSetEqual.Location = new System.Drawing.Point(52, 6);
			this.btnSetEqual.Name = "btnSetEqual";
			this.btnSetEqual.Size = new System.Drawing.Size(24, 21);
			this.btnSetEqual.TabIndex = 18;
			this.btnSetEqual.Text = "+";
			this.TT.SetToolTip(this.btnSetEqual, "Press to get your current Customer ID. Will not display anything if a license is " + "not currently installed.");
			this.btnSetEqual.UseVisualStyleBackColor = true;
			this.btnSetEqual.Visible = false;
			//
			//btnGetCustID
			//
			this.btnGetCustID.Location = new System.Drawing.Point(425, 444);
			this.btnGetCustID.Name = "btnGetCustID";
			this.btnGetCustID.Size = new System.Drawing.Size(157, 21);
			this.btnGetCustID.TabIndex = 19;
			this.btnGetCustID.Text = "Get ID from License";
			this.TT.SetToolTip(this.btnGetCustID, "Press to get your current Customer ID. Will not display anything if a license is " + "not currently installed.");
			this.btnGetCustID.UseVisualStyleBackColor = true;
			//
			//Timer1
			//
			this.Timer1.Enabled = true;
			this.Timer1.Interval = 5000;
			//
			//btnDisplay
			//
			this.btnDisplay.Location = new System.Drawing.Point(685, 135);
			this.btnDisplay.Name = "btnDisplay";
			this.btnDisplay.Size = new System.Drawing.Size(147, 35);
			this.btnDisplay.TabIndex = 6;
			this.btnDisplay.Text = "Show License Rules";
			this.btnDisplay.UseVisualStyleBackColor = true;
			//
			//Label1
			//
			this.Label1.AutoSize = true;
			this.Label1.Location = new System.Drawing.Point(6, 379);
			this.Label1.Name = "Label1";
			this.Label1.Size = new System.Drawing.Size(150, 13);
			this.Label1.TabIndex = 8;
			this.Label1.Text = "Enter Repository Server Name";
			//
			//txtCompanyID
			//
			this.txtCompanyID.Location = new System.Drawing.Point(212, 442);
			this.txtCompanyID.Name = "txtCompanyID";
			this.txtCompanyID.Size = new System.Drawing.Size(207, 20);
			this.txtCompanyID.TabIndex = 12;
			//
			//Label2
			//
			this.Label2.AutoSize = true;
			this.Label2.Location = new System.Drawing.Point(6, 446);
			this.Label2.Name = "Label2";
			this.Label2.Size = new System.Drawing.Size(202, 13);
			this.Label2.TabIndex = 13;
			this.Label2.Text = "Please Enter Your Assigned Customer ID:";
			//
			//dgLicense
			//
			this.dgLicense.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
			this.dgLicense.Location = new System.Drawing.Point(10, 198);
			this.dgLicense.Name = "dgLicense";
			this.dgLicense.RowTemplate.Height = 24;
			this.dgLicense.Size = new System.Drawing.Size(669, 178);
			this.dgLicense.TabIndex = 14;
			//
			//f1Help
			//
			this.f1Help.HelpNamespace = "http://www.ecmlibrary.com/helpfiles/License Management Screen.htm";
			//
			//txtSqlServerMachineName
			//
			this.txtSqlServerMachineName.BackColor = System.Drawing.SystemColors.InactiveBorder;
			this.txtSqlServerMachineName.Enabled = false;
			this.txtSqlServerMachineName.Location = new System.Drawing.Point(135, 419);
			this.txtSqlServerMachineName.Name = "txtSqlServerMachineName";
			this.txtSqlServerMachineName.Size = new System.Drawing.Size(284, 20);
			this.txtSqlServerMachineName.TabIndex = 20;
			//
			//Label3
			//
			this.Label3.AutoSize = true;
			this.Label3.Location = new System.Drawing.Point(6, 422);
			this.Label3.Name = "Label3";
			this.Label3.Size = new System.Drawing.Size(125, 13);
			this.Label3.TabIndex = 21;
			this.Label3.Text = "SQL Svr Instance Name:";
			//
			//txtServers
			//
			this.txtServers.Location = new System.Drawing.Point(8, 393);
			this.txtServers.Name = "txtServers";
			this.txtServers.Size = new System.Drawing.Size(411, 20);
			this.txtServers.TabIndex = 22;
			//
			//frmLicense
			//
			this.AutoScaleDimensions = new System.Drawing.SizeF((float) (6.0F), (float) (13.0F));
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.ClientSize = new System.Drawing.Size(844, 501);
			this.Controls.Add(this.txtServers);
			this.Controls.Add(this.Label3);
			this.Controls.Add(this.txtSqlServerMachineName);
			this.Controls.Add(this.btnGetCustID);
			this.Controls.Add(this.btnSetEqual);
			this.Controls.Add(this.btnShowCurrentDB);
			this.Controls.Add(this.btnApplySelLic);
			this.Controls.Add(this.dgLicense);
			this.Controls.Add(this.Label2);
			this.Controls.Add(this.txtCompanyID);
			this.Controls.Add(this.btnRemote);
			this.Controls.Add(this.Label1);
			this.Controls.Add(this.btnDisplay);
			this.Controls.Add(this.SB);
			this.Controls.Add(this.btnPasteLicense);
			this.Controls.Add(this.txtLicense);
			this.Controls.Add(this.txtFqn);
			this.Controls.Add(this.btnLoadFile);
			this.Controls.Add(this.btnGetfile);
			this.f1Help.SetHelpString(this, "http://www.ecmlibrary.com/helpfiles/License Management Screen.htm");
			this.Name = "frmLicense";
			this.f1Help.SetShowHelp(this, true);
			this.Text = "frmLicense";
			((System.ComponentModel.ISupportInitialize) this.dgLicense).EndInit();
			this.ResumeLayout(false);
			this.PerformLayout();
			
		}
		internal System.Windows.Forms.Button btnGetfile;
		internal System.Windows.Forms.Button btnLoadFile;
		internal System.Windows.Forms.TextBox txtFqn;
		internal System.Windows.Forms.TextBox txtLicense;
		internal System.Windows.Forms.Button btnPasteLicense;
		internal System.Windows.Forms.OpenFileDialog OpenFileDialog1;
		internal System.Windows.Forms.TextBox SB;
		internal System.Windows.Forms.ToolTip TT;
		internal System.Windows.Forms.Timer Timer1;
		internal System.Windows.Forms.Button btnDisplay;
		internal System.Windows.Forms.Label Label1;
		internal System.Windows.Forms.Button btnRemote;
		internal System.Windows.Forms.TextBox txtCompanyID;
		internal System.Windows.Forms.Label Label2;
		internal System.Windows.Forms.DataGridView dgLicense;
		internal System.Windows.Forms.Button btnApplySelLic;
		internal System.Windows.Forms.HelpProvider f1Help;
		internal System.Windows.Forms.Button btnShowCurrentDB;
		internal System.Windows.Forms.Button btnSetEqual;
		internal System.Windows.Forms.Button btnGetCustID;
		internal System.Windows.Forms.TextBox txtSqlServerMachineName;
		internal System.Windows.Forms.Label Label3;
		internal System.Windows.Forms.TextBox txtServers;
	}
	
}
