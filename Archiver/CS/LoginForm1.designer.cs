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
	[global::Microsoft.VisualBasic.CompilerServices.DesignerGenerated()][global::System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Naming", "CA1726")]public partial class LoginForm1 : System.Windows.Forms.Form
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
		internal System.Windows.Forms.PictureBox LogoPictureBox;
		internal System.Windows.Forms.Label UsernameLabel;
		internal System.Windows.Forms.Label PasswordLabel;
		internal System.Windows.Forms.TextBox txtLoginID;
		internal System.Windows.Forms.TextBox PasswordTextBox;
		internal System.Windows.Forms.Button OK;
		internal System.Windows.Forms.Button Cancel;
		
		//Required by the Windows Form Designer
		private System.ComponentModel.Container components = null;
		
		//NOTE: The following procedure is required by the Windows Form Designer
		//It can be modified using the Windows Form Designer.
		//Do not modify it using the code editor.
		[System.Diagnostics.DebuggerStepThrough()]private void InitializeComponent()
		{
			this.components = new System.ComponentModel.Container();
			base.Load += new System.EventHandler(LoginForm1_Load);
			System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(LoginForm1));
			this.LogoPictureBox = new System.Windows.Forms.PictureBox();
			this.UsernameLabel = new System.Windows.Forms.Label();
			this.PasswordLabel = new System.Windows.Forms.Label();
			this.txtLoginID = new System.Windows.Forms.TextBox();
			this.PasswordTextBox = new System.Windows.Forms.TextBox();
			this.OK = new System.Windows.Forms.Button();
			this.OK.Click += new System.EventHandler(this.OK_Click);
			this.Cancel = new System.Windows.Forms.Button();
			this.Cancel.Click += new System.EventHandler(this.Cancel_Click);
			this.TT = new System.Windows.Forms.ToolTip(this.components);
			this.btnGetRepos = new System.Windows.Forms.Button();
			this.btnGetRepos.Click += new System.EventHandler(this.btnGetRepos_Click);
			this.btnAttach = new System.Windows.Forms.Button();
			this.btnAttach.Click += new System.EventHandler(this.btnAttach_Click);
			this.Timer1 = new System.Windows.Forms.Timer(this.components);
			this.Timer1.Tick += new System.EventHandler(this.Timer1_Tick);
			this.ckSaveAsDefaultLogin = new System.Windows.Forms.CheckBox();
			this.ckSaveAsDefaultLogin.CheckedChanged += new System.EventHandler(this.ckSaveAsDefaultLogin_CheckedChanged);
			this.Label1 = new System.Windows.Forms.Label();
			this.txtCompanyID = new System.Windows.Forms.TextBox();
			this.Label2 = new System.Windows.Forms.Label();
			this.cbRepoID = new System.Windows.Forms.ComboBox();
			this.Label3 = new System.Windows.Forms.Label();
			this.pwEncryptPW = new System.Windows.Forms.TextBox();
			this.lblAttached = new System.Windows.Forms.Label();
			this.lblAttachedMachineName = new System.Windows.Forms.Label();
			this.lblCurrUserGuidID = new System.Windows.Forms.Label();
			this.lblServerInstanceName = new System.Windows.Forms.Label();
			this.lblLocalIP = new System.Windows.Forms.Label();
			this.lblServerMachineName = new System.Windows.Forms.Label();
			this.SB = new System.Windows.Forms.TextBox();
			this.btnChgPW = new System.Windows.Forms.Button();
			this.Panel1 = new System.Windows.Forms.Panel();
			this.Panel2 = new System.Windows.Forms.Panel();
			this.lblNetworkID = new System.Windows.Forms.Label();
			this.ckCancelAutoLogin = new System.Windows.Forms.CheckBox();
			this.lblMsg = new System.Windows.Forms.Label();
			this.Timer2 = new System.Windows.Forms.Timer(this.components);
			this.Timer2.Tick += new System.EventHandler(this.Timer2_Tick);
			((System.ComponentModel.ISupportInitialize) this.LogoPictureBox).BeginInit();
			this.Panel1.SuspendLayout();
			this.Panel2.SuspendLayout();
			this.SuspendLayout();
			//
			//LogoPictureBox
			//
			this.LogoPictureBox.Image = (System.Drawing.Image) (resources.GetObject("LogoPictureBox.Image"));
			this.LogoPictureBox.Location = new System.Drawing.Point(12, 0);
			this.LogoPictureBox.Name = "LogoPictureBox";
			this.LogoPictureBox.Size = new System.Drawing.Size(241, 78);
			this.LogoPictureBox.TabIndex = 0;
			this.LogoPictureBox.TabStop = false;
			//
			//UsernameLabel
			//
			this.UsernameLabel.Font = new System.Drawing.Font("Microsoft Sans Serif", (float) (8.25F), System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, (byte) (0));
			this.UsernameLabel.ForeColor = System.Drawing.Color.Maroon;
			this.UsernameLabel.Location = new System.Drawing.Point(14, 0);
			this.UsernameLabel.Name = "UsernameLabel";
			this.UsernameLabel.Size = new System.Drawing.Size(220, 23);
			this.UsernameLabel.TabIndex = 0;
			this.UsernameLabel.Text = "Login ID";
			this.UsernameLabel.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
			//
			//PasswordLabel
			//
			this.PasswordLabel.Font = new System.Drawing.Font("Microsoft Sans Serif", (float) (8.25F), System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, (byte) (0));
			this.PasswordLabel.ForeColor = System.Drawing.Color.Maroon;
			this.PasswordLabel.Location = new System.Drawing.Point(237, 0);
			this.PasswordLabel.Name = "PasswordLabel";
			this.PasswordLabel.Size = new System.Drawing.Size(185, 23);
			this.PasswordLabel.TabIndex = 2;
			this.PasswordLabel.Text = "&Password";
			this.PasswordLabel.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
			//
			//txtLoginID
			//
			this.txtLoginID.BackColor = System.Drawing.Color.Silver;
			this.txtLoginID.Location = new System.Drawing.Point(14, 26);
			this.txtLoginID.Name = "txtLoginID";
			this.txtLoginID.Size = new System.Drawing.Size(220, 20);
			this.txtLoginID.TabIndex = 1;
			//
			//PasswordTextBox
			//
			this.PasswordTextBox.BackColor = System.Drawing.Color.Silver;
			this.PasswordTextBox.Location = new System.Drawing.Point(240, 26);
			this.PasswordTextBox.Name = "PasswordTextBox";
			this.PasswordTextBox.PasswordChar = global::Microsoft.VisualBasic.Strings.ChrW(42);
			this.PasswordTextBox.Size = new System.Drawing.Size(182, 20);
			this.PasswordTextBox.TabIndex = 3;
			//
			//OK
			//
			this.OK.Location = new System.Drawing.Point(328, 80);
			this.OK.Name = "OK";
			this.OK.Size = new System.Drawing.Size(94, 23);
			this.OK.TabIndex = 4;
			this.OK.Text = "&Login";
			//
			//Cancel
			//
			this.Cancel.DialogResult = System.Windows.Forms.DialogResult.Cancel;
			this.Cancel.Location = new System.Drawing.Point(178, 80);
			this.Cancel.Name = "Cancel";
			this.Cancel.Size = new System.Drawing.Size(94, 23);
			this.Cancel.TabIndex = 5;
			this.Cancel.Text = "&Cancel";
			//
			//btnGetRepos
			//
			this.btnGetRepos.Location = new System.Drawing.Point(299, 52);
			this.btnGetRepos.Name = "btnGetRepos";
			this.btnGetRepos.Size = new System.Drawing.Size(94, 23);
			this.btnGetRepos.TabIndex = 13;
			this.btnGetRepos.Text = "&Available";
			this.TT.SetToolTip(this.btnGetRepos, "Populate the dropdown list with your available repositories.");
			//
			//btnAttach
			//
			this.btnAttach.Location = new System.Drawing.Point(485, 52);
			this.btnAttach.Name = "btnAttach";
			this.btnAttach.Size = new System.Drawing.Size(94, 23);
			this.btnAttach.TabIndex = 14;
			this.btnAttach.Text = "Attach";
			this.TT.SetToolTip(this.btnAttach, "Attach to the selected repository.");
			//
			//Timer1
			//
			//
			//ckSaveAsDefaultLogin
			//
			this.ckSaveAsDefaultLogin.AutoSize = true;
			this.ckSaveAsDefaultLogin.Font = new System.Drawing.Font("Microsoft Sans Serif", (float) (8.25F), System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, (byte) (0));
			this.ckSaveAsDefaultLogin.ForeColor = System.Drawing.Color.Maroon;
			this.ckSaveAsDefaultLogin.Location = new System.Drawing.Point(14, 52);
			this.ckSaveAsDefaultLogin.Name = "ckSaveAsDefaultLogin";
			this.ckSaveAsDefaultLogin.Size = new System.Drawing.Size(225, 17);
			this.ckSaveAsDefaultLogin.TabIndex = 6;
			this.ckSaveAsDefaultLogin.Text = "Save as default login for auto-login";
			this.ckSaveAsDefaultLogin.UseVisualStyleBackColor = true;
			//
			//Label1
			//
			this.Label1.Font = new System.Drawing.Font("Microsoft Sans Serif", (float) (8.25F), System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, (byte) (0));
			this.Label1.ForeColor = System.Drawing.Color.Maroon;
			this.Label1.Location = new System.Drawing.Point(12, 0);
			this.Label1.Name = "Label1";
			this.Label1.Size = new System.Drawing.Size(75, 23);
			this.Label1.TabIndex = 7;
			this.Label1.Text = "Company ID";
			this.Label1.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
			//
			//txtCompanyID
			//
			this.txtCompanyID.BackColor = System.Drawing.Color.Silver;
			this.txtCompanyID.Location = new System.Drawing.Point(12, 26);
			this.txtCompanyID.Name = "txtCompanyID";
			this.txtCompanyID.Size = new System.Drawing.Size(177, 20);
			this.txtCompanyID.TabIndex = 8;
			this.TT.SetToolTip(this.txtCompanyID, "Enter your Company ID in this field.");
			//
			//Label2
			//
			this.Label2.Font = new System.Drawing.Font("Microsoft Sans Serif", (float) (8.25F), System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, (byte) (0));
			this.Label2.ForeColor = System.Drawing.Color.Maroon;
			this.Label2.Location = new System.Drawing.Point(195, 0);
			this.Label2.Name = "Label2";
			this.Label2.Size = new System.Drawing.Size(75, 23);
			this.Label2.TabIndex = 9;
			this.Label2.Text = "Repository ID";
			this.Label2.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
			//
			//cbRepoID
			//
			this.cbRepoID.BackColor = System.Drawing.Color.Silver;
			this.cbRepoID.FormattingEnabled = true;
			this.cbRepoID.Location = new System.Drawing.Point(195, 25);
			this.cbRepoID.Name = "cbRepoID";
			this.cbRepoID.Size = new System.Drawing.Size(198, 21);
			this.cbRepoID.TabIndex = 10;
			//
			//Label3
			//
			this.Label3.Font = new System.Drawing.Font("Microsoft Sans Serif", (float) (8.25F), System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, (byte) (0));
			this.Label3.ForeColor = System.Drawing.Color.Maroon;
			this.Label3.Location = new System.Drawing.Point(399, 0);
			this.Label3.Name = "Label3";
			this.Label3.Size = new System.Drawing.Size(126, 23);
			this.Label3.TabIndex = 11;
			this.Label3.Text = "Gateway Password";
			this.Label3.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
			//
			//pwEncryptPW
			//
			this.pwEncryptPW.BackColor = System.Drawing.Color.Silver;
			this.pwEncryptPW.Location = new System.Drawing.Point(402, 26);
			this.pwEncryptPW.Name = "pwEncryptPW";
			this.pwEncryptPW.PasswordChar = global::Microsoft.VisualBasic.Strings.ChrW(42);
			this.pwEncryptPW.Size = new System.Drawing.Size(177, 20);
			this.pwEncryptPW.TabIndex = 12;
			//
			//lblAttached
			//
			this.lblAttached.AutoSize = true;
			this.lblAttached.Font = new System.Drawing.Font("Microsoft Sans Serif", (float) (9.75F), (System.Drawing.FontStyle) (System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic), System.Drawing.GraphicsUnit.Point, (byte) (0));
			this.lblAttached.ForeColor = System.Drawing.Color.FromArgb(System.Convert.ToInt32((byte) (192)), System.Convert.ToInt32((byte) (0)), System.Convert.ToInt32((byte) (0)));
			this.lblAttached.Location = new System.Drawing.Point(12, 312);
			this.lblAttached.Name = "lblAttached";
			this.lblAttached.Size = new System.Drawing.Size(97, 16);
			this.lblAttached.TabIndex = 15;
			this.lblAttached.Text = "Not Attached";
			//
			//lblAttachedMachineName
			//
			this.lblAttachedMachineName.AutoSize = true;
			this.lblAttachedMachineName.Location = new System.Drawing.Point(499, 14);
			this.lblAttachedMachineName.Name = "lblAttachedMachineName";
			this.lblAttachedMachineName.Size = new System.Drawing.Size(79, 13);
			this.lblAttachedMachineName.TabIndex = 16;
			this.lblAttachedMachineName.Text = "Machine Name";
			//
			//lblCurrUserGuidID
			//
			this.lblCurrUserGuidID.AutoSize = true;
			this.lblCurrUserGuidID.Location = new System.Drawing.Point(499, 37);
			this.lblCurrUserGuidID.Name = "lblCurrUserGuidID";
			this.lblCurrUserGuidID.Size = new System.Drawing.Size(43, 13);
			this.lblCurrUserGuidID.TabIndex = 17;
			this.lblCurrUserGuidID.Text = "User ID";
			//
			//lblServerInstanceName
			//
			this.lblServerInstanceName.AutoSize = true;
			this.lblServerInstanceName.Location = new System.Drawing.Point(499, 88);
			this.lblServerInstanceName.Name = "lblServerInstanceName";
			this.lblServerInstanceName.Size = new System.Drawing.Size(79, 13);
			this.lblServerInstanceName.TabIndex = 19;
			this.lblServerInstanceName.Text = "Instance Name";
			//
			//lblLocalIP
			//
			this.lblLocalIP.AutoSize = true;
			this.lblLocalIP.Location = new System.Drawing.Point(499, 65);
			this.lblLocalIP.Name = "lblLocalIP";
			this.lblLocalIP.Size = new System.Drawing.Size(46, 13);
			this.lblLocalIP.TabIndex = 18;
			this.lblLocalIP.Text = "Local IP";
			//
			//lblServerMachineName
			//
			this.lblServerMachineName.AutoSize = true;
			this.lblServerMachineName.Location = new System.Drawing.Point(499, 114);
			this.lblServerMachineName.Name = "lblServerMachineName";
			this.lblServerMachineName.Size = new System.Drawing.Size(69, 13);
			this.lblServerMachineName.TabIndex = 20;
			this.lblServerMachineName.Text = "Server Name";
			//
			//SB
			//
			this.SB.BackColor = System.Drawing.Color.WhiteSmoke;
			this.SB.Location = new System.Drawing.Point(12, 328);
			this.SB.Name = "SB";
			this.SB.Size = new System.Drawing.Size(688, 20);
			this.SB.TabIndex = 21;
			//
			//btnChgPW
			//
			this.btnChgPW.Location = new System.Drawing.Point(14, 80);
			this.btnChgPW.Name = "btnChgPW";
			this.btnChgPW.Size = new System.Drawing.Size(94, 23);
			this.btnChgPW.TabIndex = 22;
			this.btnChgPW.Text = "&Password";
			this.TT.SetToolTip(this.btnChgPW, "Press to change your password.");
			//
			//Panel1
			//
			this.Panel1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
			this.Panel1.Controls.Add(this.btnAttach);
			this.Panel1.Controls.Add(this.btnGetRepos);
			this.Panel1.Controls.Add(this.pwEncryptPW);
			this.Panel1.Controls.Add(this.Label3);
			this.Panel1.Controls.Add(this.cbRepoID);
			this.Panel1.Controls.Add(this.Label2);
			this.Panel1.Controls.Add(this.txtCompanyID);
			this.Panel1.Controls.Add(this.Label1);
			this.Panel1.Location = new System.Drawing.Point(12, 213);
			this.Panel1.Name = "Panel1";
			this.Panel1.Size = new System.Drawing.Size(633, 96);
			this.Panel1.TabIndex = 23;
			//
			//Panel2
			//
			this.Panel2.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
			this.Panel2.Controls.Add(this.btnChgPW);
			this.Panel2.Controls.Add(this.ckSaveAsDefaultLogin);
			this.Panel2.Controls.Add(this.Cancel);
			this.Panel2.Controls.Add(this.OK);
			this.Panel2.Controls.Add(this.PasswordTextBox);
			this.Panel2.Controls.Add(this.txtLoginID);
			this.Panel2.Controls.Add(this.PasswordLabel);
			this.Panel2.Controls.Add(this.UsernameLabel);
			this.Panel2.Location = new System.Drawing.Point(12, 81);
			this.Panel2.Name = "Panel2";
			this.Panel2.Size = new System.Drawing.Size(453, 117);
			this.Panel2.TabIndex = 24;
			//
			//lblNetworkID
			//
			this.lblNetworkID.AutoSize = true;
			this.lblNetworkID.Location = new System.Drawing.Point(499, 139);
			this.lblNetworkID.Name = "lblNetworkID";
			this.lblNetworkID.Size = new System.Drawing.Size(69, 13);
			this.lblNetworkID.TabIndex = 25;
			this.lblNetworkID.Text = "Server Name";
			//
			//ckCancelAutoLogin
			//
			this.ckCancelAutoLogin.AutoSize = true;
			this.ckCancelAutoLogin.Location = new System.Drawing.Point(330, 27);
			this.ckCancelAutoLogin.Name = "ckCancelAutoLogin";
			this.ckCancelAutoLogin.Size = new System.Drawing.Size(109, 17);
			this.ckCancelAutoLogin.TabIndex = 26;
			this.ckCancelAutoLogin.Text = "Cancel Auto-login";
			this.ckCancelAutoLogin.UseVisualStyleBackColor = true;
			//
			//lblMsg
			//
			this.lblMsg.AutoSize = true;
			this.lblMsg.Font = new System.Drawing.Font("Microsoft Sans Serif", (float) (9.75F), (System.Drawing.FontStyle) (System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Italic), System.Drawing.GraphicsUnit.Point, (byte) (0));
			this.lblMsg.ForeColor = System.Drawing.Color.FromArgb(System.Convert.ToInt32((byte) (192)), System.Convert.ToInt32((byte) (0)), System.Convert.ToInt32((byte) (0)));
			this.lblMsg.Location = new System.Drawing.Point(327, 8);
			this.lblMsg.Name = "lblMsg";
			this.lblMsg.Size = new System.Drawing.Size(72, 16);
			this.lblMsg.TabIndex = 27;
			this.lblMsg.Text = "Message";
			//
			//Timer2
			//
			this.Timer2.Interval = 1000;
			//
			//LoginForm1
			//
			this.AcceptButton = this.OK;
			this.AutoScaleDimensions = new System.Drawing.SizeF((float) (6.0F), (float) (13.0F));
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.BackColor = System.Drawing.SystemColors.ButtonHighlight;
			this.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch;
			this.CancelButton = this.Cancel;
			this.ClientSize = new System.Drawing.Size(712, 349);
			this.Controls.Add(this.lblMsg);
			this.Controls.Add(this.ckCancelAutoLogin);
			this.Controls.Add(this.lblNetworkID);
			this.Controls.Add(this.Panel2);
			this.Controls.Add(this.Panel1);
			this.Controls.Add(this.SB);
			this.Controls.Add(this.lblServerMachineName);
			this.Controls.Add(this.lblServerInstanceName);
			this.Controls.Add(this.lblLocalIP);
			this.Controls.Add(this.lblCurrUserGuidID);
			this.Controls.Add(this.lblAttachedMachineName);
			this.Controls.Add(this.lblAttached);
			this.Controls.Add(this.LogoPictureBox);
			this.DoubleBuffered = true;
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.Fixed3D;
			this.MaximizeBox = false;
			this.MinimizeBox = false;
			this.Name = "LoginForm1";
			this.SizeGripStyle = System.Windows.Forms.SizeGripStyle.Hide;
			this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
			this.Text = "ECM Archive Login Screen";
			((System.ComponentModel.ISupportInitialize) this.LogoPictureBox).EndInit();
			this.Panel1.ResumeLayout(false);
			this.Panel1.PerformLayout();
			this.Panel2.ResumeLayout(false);
			this.Panel2.PerformLayout();
			this.ResumeLayout(false);
			this.PerformLayout();
			
		}
		internal System.Windows.Forms.ToolTip TT;
		internal System.Windows.Forms.Timer Timer1;
		internal System.Windows.Forms.CheckBox ckSaveAsDefaultLogin;
		internal System.Windows.Forms.Label Label1;
		internal System.Windows.Forms.TextBox txtCompanyID;
		internal System.Windows.Forms.Label Label2;
		internal System.Windows.Forms.ComboBox cbRepoID;
		internal System.Windows.Forms.Label Label3;
		internal System.Windows.Forms.TextBox pwEncryptPW;
		internal System.Windows.Forms.Button btnGetRepos;
		internal System.Windows.Forms.Button btnAttach;
		internal System.Windows.Forms.Label lblAttached;
		internal System.Windows.Forms.Label lblAttachedMachineName;
		internal System.Windows.Forms.Label lblCurrUserGuidID;
		internal System.Windows.Forms.Label lblServerInstanceName;
		internal System.Windows.Forms.Label lblLocalIP;
		internal System.Windows.Forms.Label lblServerMachineName;
		internal System.Windows.Forms.TextBox SB;
		internal System.Windows.Forms.Button btnChgPW;
		internal System.Windows.Forms.Panel Panel1;
		internal System.Windows.Forms.Panel Panel2;
		internal System.Windows.Forms.Label lblNetworkID;
		internal System.Windows.Forms.CheckBox ckCancelAutoLogin;
		internal System.Windows.Forms.Label lblMsg;
		internal System.Windows.Forms.Timer Timer2;
		
	}
	
}
