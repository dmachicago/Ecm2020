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
	[global::Microsoft.VisualBasic.CompilerServices.DesignerGenerated()]public partial class frmPstLoader : System.Windows.Forms.Form
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
			this.Deactivate += new System.EventHandler(frmPstLoader_Deactivate);
			this.Disposed += new System.EventHandler(frmPstLoader_Disposed);
			base.Load += new System.EventHandler(frmPstLoader_Load);
			this.OpenFileDialog1 = new System.Windows.Forms.OpenFileDialog();
			this.txtPstFqn = new System.Windows.Forms.TextBox();
			this.txtPstFqn.TextChanged += new System.EventHandler(this.txtPstFqn_TextChanged);
			this.Label1 = new System.Windows.Forms.Label();
			this.btnSelectFile = new System.Windows.Forms.Button();
			this.btnSelectFile.Click += new System.EventHandler(this.btnSelectFile_Click);
			this.btnLoad = new System.Windows.Forms.Button();
			this.btnLoad.Click += new System.EventHandler(this.btnLoad_Click);
			this.lbMsg = new System.Windows.Forms.ListBox();
			this.btnArchive = new System.Windows.Forms.Button();
			this.btnArchive.Click += new System.EventHandler(this.btnArchive_Click);
			this.SB = new System.Windows.Forms.TextBox();
			this.Label2 = new System.Windows.Forms.Label();
			this.Label3 = new System.Windows.Forms.Label();
			this.txtFoldersProcessed = new System.Windows.Forms.TextBox();
			this.txtEmailsProcessed = new System.Windows.Forms.TextBox();
			this.TT = new System.Windows.Forms.ToolTip(this.components);
			this.Label4 = new System.Windows.Forms.Label();
			this.cbRetention = new System.Windows.Forms.ComboBox();
			this.cbLibrary = new System.Windows.Forms.ComboBox();
			this.Label5 = new System.Windows.Forms.Label();
			this.btnRemove = new System.Windows.Forms.Button();
			this.btnRemove.Click += new System.EventHandler(this.btnRemove_Click);
			this.SuspendLayout();
			//
			//OpenFileDialog1
			//
			this.OpenFileDialog1.FileName = "OpenFileDialog1";
			//
			//txtPstFqn
			//
			this.txtPstFqn.Anchor = (System.Windows.Forms.AnchorStyles) ((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right);
			this.txtPstFqn.Location = new System.Drawing.Point(11, 28);
			this.txtPstFqn.Margin = new System.Windows.Forms.Padding(2);
			this.txtPstFqn.Name = "txtPstFqn";
			this.txtPstFqn.Size = new System.Drawing.Size(439, 20);
			this.txtPstFqn.TabIndex = 0;
			//
			//Label1
			//
			this.Label1.AutoSize = true;
			this.Label1.Location = new System.Drawing.Point(9, 9);
			this.Label1.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
			this.Label1.Name = "Label1";
			this.Label1.Size = new System.Drawing.Size(92, 13);
			this.Label1.TabIndex = 1;
			this.Label1.Text = "Selected PST File";
			//
			//btnSelectFile
			//
			this.btnSelectFile.Anchor = System.Windows.Forms.AnchorStyles.Right;
			this.btnSelectFile.Location = new System.Drawing.Point(460, 28);
			this.btnSelectFile.Margin = new System.Windows.Forms.Padding(2);
			this.btnSelectFile.Name = "btnSelectFile";
			this.btnSelectFile.Size = new System.Drawing.Size(79, 51);
			this.btnSelectFile.TabIndex = 2;
			this.btnSelectFile.Text = "&Select PST File";
			this.TT.SetToolTip(this.btnSelectFile, "Microsoft supports only local access to .pst files, not network access, and warns" + " that excessive network traffic and data corruption can result if you try to acc" + "ess .pst files over the network.");
			this.btnSelectFile.UseVisualStyleBackColor = true;
			//
			//btnLoad
			//
			this.btnLoad.Anchor = System.Windows.Forms.AnchorStyles.Right;
			this.btnLoad.Location = new System.Drawing.Point(461, 93);
			this.btnLoad.Margin = new System.Windows.Forms.Padding(2);
			this.btnLoad.Name = "btnLoad";
			this.btnLoad.Size = new System.Drawing.Size(79, 51);
			this.btnLoad.TabIndex = 3;
			this.btnLoad.Text = "&Load File";
			this.TT.SetToolTip(this.btnLoad, "Microsoft supports only local access to .pst files, not network access, and warns" + " that excessive network traffic and data corruption can result if you try to acc" + "ess .pst files over the network.");
			this.btnLoad.UseVisualStyleBackColor = true;
			//
			//lbMsg
			//
			this.lbMsg.Anchor = (System.Windows.Forms.AnchorStyles) (((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right);
			this.lbMsg.FormattingEnabled = true;
			this.lbMsg.Location = new System.Drawing.Point(11, 50);
			this.lbMsg.Margin = new System.Windows.Forms.Padding(2);
			this.lbMsg.Name = "lbMsg";
			this.lbMsg.SelectionMode = System.Windows.Forms.SelectionMode.MultiExtended;
			this.lbMsg.Size = new System.Drawing.Size(439, 290);
			this.lbMsg.TabIndex = 4;
			//
			//btnArchive
			//
			this.btnArchive.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.btnArchive.Location = new System.Drawing.Point(461, 289);
			this.btnArchive.Margin = new System.Windows.Forms.Padding(2);
			this.btnArchive.Name = "btnArchive";
			this.btnArchive.Size = new System.Drawing.Size(79, 51);
			this.btnArchive.TabIndex = 5;
			this.btnArchive.Text = "&Archive Selected Folders";
			this.btnArchive.UseVisualStyleBackColor = true;
			//
			//SB
			//
			this.SB.Anchor = (System.Windows.Forms.AnchorStyles) ((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right);
			this.SB.BackColor = System.Drawing.Color.FromArgb(System.Convert.ToInt32((byte) (255)), System.Convert.ToInt32((byte) (255)), System.Convert.ToInt32((byte) (192)));
			this.SB.Location = new System.Drawing.Point(12, 407);
			this.SB.Margin = new System.Windows.Forms.Padding(2);
			this.SB.Name = "SB";
			this.SB.Size = new System.Drawing.Size(439, 20);
			this.SB.TabIndex = 6;
			//
			//Label2
			//
			this.Label2.Anchor = System.Windows.Forms.AnchorStyles.Right;
			this.Label2.AutoSize = true;
			this.Label2.Location = new System.Drawing.Point(461, 172);
			this.Label2.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
			this.Label2.Name = "Label2";
			this.Label2.Size = new System.Drawing.Size(41, 13);
			this.Label2.TabIndex = 7;
			this.Label2.Text = "Folders";
			//
			//Label3
			//
			this.Label3.Anchor = System.Windows.Forms.AnchorStyles.Right;
			this.Label3.AutoSize = true;
			this.Label3.Location = new System.Drawing.Point(461, 223);
			this.Label3.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
			this.Label3.Name = "Label3";
			this.Label3.Size = new System.Drawing.Size(37, 13);
			this.Label3.TabIndex = 8;
			this.Label3.Text = "Emails";
			//
			//txtFoldersProcessed
			//
			this.txtFoldersProcessed.Anchor = System.Windows.Forms.AnchorStyles.Right;
			this.txtFoldersProcessed.Location = new System.Drawing.Point(461, 191);
			this.txtFoldersProcessed.Margin = new System.Windows.Forms.Padding(2);
			this.txtFoldersProcessed.Name = "txtFoldersProcessed";
			this.txtFoldersProcessed.Size = new System.Drawing.Size(75, 20);
			this.txtFoldersProcessed.TabIndex = 9;
			//
			//txtEmailsProcessed
			//
			this.txtEmailsProcessed.Anchor = System.Windows.Forms.AnchorStyles.Right;
			this.txtEmailsProcessed.Location = new System.Drawing.Point(461, 240);
			this.txtEmailsProcessed.Margin = new System.Windows.Forms.Padding(2);
			this.txtEmailsProcessed.Name = "txtEmailsProcessed";
			this.txtEmailsProcessed.Size = new System.Drawing.Size(75, 20);
			this.txtEmailsProcessed.TabIndex = 10;
			//
			//Label4
			//
			this.Label4.AutoSize = true;
			this.Label4.Location = new System.Drawing.Point(127, 353);
			this.Label4.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
			this.Label4.Name = "Label4";
			this.Label4.Size = new System.Drawing.Size(126, 13);
			this.Label4.TabIndex = 11;
			this.Label4.Text = "Selected Retention Rule:";
			//
			//cbRetention
			//
			this.cbRetention.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.cbRetention.FormattingEnabled = true;
			this.cbRetention.Location = new System.Drawing.Point(258, 345);
			this.cbRetention.Name = "cbRetention";
			this.cbRetention.Size = new System.Drawing.Size(192, 21);
			this.cbRetention.TabIndex = 12;
			//
			//cbLibrary
			//
			this.cbLibrary.FormattingEnabled = true;
			this.cbLibrary.Location = new System.Drawing.Point(258, 372);
			this.cbLibrary.Name = "cbLibrary";
			this.cbLibrary.Size = new System.Drawing.Size(192, 21);
			this.cbLibrary.TabIndex = 14;
			//
			//Label5
			//
			this.Label5.AutoSize = true;
			this.Label5.Location = new System.Drawing.Point(179, 380);
			this.Label5.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
			this.Label5.Name = "Label5";
			this.Label5.Size = new System.Drawing.Size(74, 13);
			this.Label5.TabIndex = 13;
			this.Label5.Text = "Select Library:";
			//
			//btnRemove
			//
			this.btnRemove.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.btnRemove.Location = new System.Drawing.Point(465, 395);
			this.btnRemove.Name = "btnRemove";
			this.btnRemove.Size = new System.Drawing.Size(73, 44);
			this.btnRemove.TabIndex = 15;
			this.btnRemove.Text = "Remove Imports";
			this.btnRemove.UseVisualStyleBackColor = true;
			//
			//frmPstLoader
			//
			this.AutoScaleDimensions = new System.Drawing.SizeF((float) (6.0F), (float) (13.0F));
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.ClientSize = new System.Drawing.Size(550, 449);
			this.Controls.Add(this.btnRemove);
			this.Controls.Add(this.cbLibrary);
			this.Controls.Add(this.Label5);
			this.Controls.Add(this.cbRetention);
			this.Controls.Add(this.Label4);
			this.Controls.Add(this.txtEmailsProcessed);
			this.Controls.Add(this.txtFoldersProcessed);
			this.Controls.Add(this.Label3);
			this.Controls.Add(this.Label2);
			this.Controls.Add(this.SB);
			this.Controls.Add(this.btnArchive);
			this.Controls.Add(this.lbMsg);
			this.Controls.Add(this.btnLoad);
			this.Controls.Add(this.btnSelectFile);
			this.Controls.Add(this.Label1);
			this.Controls.Add(this.txtPstFqn);
			this.Margin = new System.Windows.Forms.Padding(2);
			this.Name = "frmPstLoader";
			this.Text = "PST Loader                  (frmPstLoader)";
			this.ResumeLayout(false);
			this.PerformLayout();
			
		}
		internal System.Windows.Forms.OpenFileDialog OpenFileDialog1;
		internal System.Windows.Forms.TextBox txtPstFqn;
		internal System.Windows.Forms.Label Label1;
		internal System.Windows.Forms.Button btnSelectFile;
		internal System.Windows.Forms.Button btnLoad;
		internal System.Windows.Forms.ListBox lbMsg;
		internal System.Windows.Forms.Button btnArchive;
		internal System.Windows.Forms.TextBox SB;
		internal System.Windows.Forms.Label Label2;
		internal System.Windows.Forms.Label Label3;
		internal System.Windows.Forms.TextBox txtFoldersProcessed;
		internal System.Windows.Forms.TextBox txtEmailsProcessed;
		internal System.Windows.Forms.ToolTip TT;
		internal System.Windows.Forms.Label Label4;
		internal System.Windows.Forms.ComboBox cbRetention;
		internal System.Windows.Forms.ComboBox cbLibrary;
		internal System.Windows.Forms.Label Label5;
		internal System.Windows.Forms.Button btnRemove;
	}
	
}
