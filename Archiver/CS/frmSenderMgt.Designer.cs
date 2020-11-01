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
	[global::Microsoft.VisualBasic.CompilerServices.DesignerGenerated()]public partial class frmSenderMgt : System.Windows.Forms.Form
	{
		
		//Form overrides dispose to clean up the component list.
		[System.Diagnostics.DebuggerNonUserCode()]protected override void Dispose(bool disposing)
		{
			if (disposing && components != null)
			{
				components.Dispose();
			}
			base.Dispose(disposing);
		}
		
		//Required by the Windows Form Designer
		private System.ComponentModel.Container components = null;
		
		//NOTE: The following procedure is required by the Windows Form Designer
		//It can be modified using the Windows Form Designer.
		//Do not modify it using the code editor.
		[System.Diagnostics.DebuggerStepThrough()]private void InitializeComponent()
		{
			this.components = new System.ComponentModel.Container();
			base.Load += new System.EventHandler(frmSenderMgt_Load);
			this.Resize += new System.EventHandler(frmSenderMgt_Resize);
			this.Label1 = new System.Windows.Forms.Label();
			this.Label2 = new System.Windows.Forms.Label();
			this.GroupBox1 = new System.Windows.Forms.GroupBox();
			this.btnRefresh = new System.Windows.Forms.Button();
			this.btnRefresh.Click += new System.EventHandler(this.btnRefresh_Click);
			this.rbContacts = new System.Windows.Forms.RadioButton();
			this.rbContacts.CheckedChanged += new System.EventHandler(this.rbContacts_CheckedChanged);
			this.btnExclSender = new System.Windows.Forms.Button();
			this.btnExclSender.Click += new System.EventHandler(this.btnExclSender_Click);
			this.rbInbox = new System.Windows.Forms.RadioButton();
			this.rbInbox.CheckedChanged += new System.EventHandler(this.rbInbox_CheckedChanged);
			this.rbArchive = new System.Windows.Forms.RadioButton();
			this.rbArchive.CheckedChanged += new System.EventHandler(this.rbArchive_CheckedChanged);
			this.btnRemoveExcluded = new System.Windows.Forms.Button();
			this.btnRemoveExcluded.Click += new System.EventHandler(this.btnRemoveExcluded_Click);
			this.dgExcludedSenders = new System.Windows.Forms.DataGridView();
			this.dgEmailSenders = new System.Windows.Forms.DataGridView();
			this.ExcludeFromBindingSource = new System.Windows.Forms.BindingSource(this.components);
			this.ArchiveFromBindingSource = new System.Windows.Forms.BindingSource(this.components);
			this.DMAUDDataSetBindingSource = new System.Windows.Forms.BindingSource(this.components);
			this.DMAUDDataSet2BindingSource = new System.Windows.Forms.BindingSource(this.components);
			this.TT = new System.Windows.Forms.ToolTip(this.components);
			this.Timer1 = new System.Windows.Forms.Timer(this.components);
			this.Timer1.Tick += new System.EventHandler(this.Timer1_Tick);
			this.f1Help = new System.Windows.Forms.HelpProvider();
			this.cbOutlookFOlder = new System.Windows.Forms.ComboBox();
			this.GroupBox1.SuspendLayout();
			((System.ComponentModel.ISupportInitialize) this.dgExcludedSenders).BeginInit();
			((System.ComponentModel.ISupportInitialize) this.dgEmailSenders).BeginInit();
			((System.ComponentModel.ISupportInitialize) this.ExcludeFromBindingSource).BeginInit();
			((System.ComponentModel.ISupportInitialize) this.ArchiveFromBindingSource).BeginInit();
			((System.ComponentModel.ISupportInitialize) this.DMAUDDataSetBindingSource).BeginInit();
			((System.ComponentModel.ISupportInitialize) this.DMAUDDataSet2BindingSource).BeginInit();
			this.SuspendLayout();
			//
			//Label1
			//
			this.Label1.AutoSize = true;
			this.Label1.Location = new System.Drawing.Point(8, 8);
			this.Label1.Name = "Label1";
			this.Label1.Size = new System.Drawing.Size(74, 13);
			this.Label1.TabIndex = 3;
			this.Label1.Text = "Email Senders";
			//
			//Label2
			//
			this.Label2.AutoSize = true;
			this.Label2.Location = new System.Drawing.Point(454, 9);
			this.Label2.Name = "Label2";
			this.Label2.Size = new System.Drawing.Size(155, 13);
			this.Label2.TabIndex = 4;
			this.Label2.Text = "Excluded Senders from Archive";
			//
			//GroupBox1
			//
			this.GroupBox1.Controls.Add(this.cbOutlookFOlder);
			this.GroupBox1.Controls.Add(this.btnRefresh);
			this.GroupBox1.Controls.Add(this.rbContacts);
			this.GroupBox1.Controls.Add(this.btnExclSender);
			this.GroupBox1.Controls.Add(this.rbInbox);
			this.GroupBox1.Controls.Add(this.rbArchive);
			this.GroupBox1.Location = new System.Drawing.Point(16, 448);
			this.GroupBox1.Name = "GroupBox1";
			this.GroupBox1.Size = new System.Drawing.Size(430, 121);
			this.GroupBox1.TabIndex = 6;
			this.GroupBox1.TabStop = false;
			this.GroupBox1.Text = "Sender List";
			//
			//btnRefresh
			//
			this.btnRefresh.Location = new System.Drawing.Point(360, 12);
			this.btnRefresh.Name = "btnRefresh";
			this.btnRefresh.Size = new System.Drawing.Size(64, 24);
			this.btnRefresh.TabIndex = 13;
			this.btnRefresh.Text = "&Refresh";
			this.btnRefresh.UseVisualStyleBackColor = true;
			//
			//rbContacts
			//
			this.rbContacts.AutoSize = true;
			this.rbContacts.Location = new System.Drawing.Point(24, 51);
			this.rbContacts.Name = "rbContacts";
			this.rbContacts.Size = new System.Drawing.Size(107, 17);
			this.rbContacts.TabIndex = 12;
			this.rbContacts.Text = "Outlook Contacts";
			this.rbContacts.UseVisualStyleBackColor = true;
			this.rbContacts.Visible = false;
			//
			//btnExclSender
			//
			this.btnExclSender.Location = new System.Drawing.Point(360, 44);
			this.btnExclSender.Name = "btnExclSender";
			this.btnExclSender.Size = new System.Drawing.Size(64, 24);
			this.btnExclSender.TabIndex = 11;
			this.btnExclSender.Text = "&Exclude";
			this.TT.SetToolTip(this.btnExclSender, "Press to exclude selected senders from the archive process.");
			this.btnExclSender.UseVisualStyleBackColor = true;
			//
			//rbInbox
			//
			this.rbInbox.AutoSize = true;
			this.rbInbox.Location = new System.Drawing.Point(24, 86);
			this.rbInbox.Name = "rbInbox";
			this.rbInbox.Size = new System.Drawing.Size(93, 17);
			this.rbInbox.TabIndex = 9;
			this.rbInbox.Text = "Inbox Senders";
			this.rbInbox.UseVisualStyleBackColor = true;
			//
			//rbArchive
			//
			this.rbArchive.AutoSize = true;
			this.rbArchive.Checked = true;
			this.rbArchive.Location = new System.Drawing.Point(24, 16);
			this.rbArchive.Name = "rbArchive";
			this.rbArchive.Size = new System.Drawing.Size(109, 17);
			this.rbArchive.TabIndex = 8;
			this.rbArchive.TabStop = true;
			this.rbArchive.Text = "Archived Senders";
			this.rbArchive.UseVisualStyleBackColor = true;
			//
			//btnRemoveExcluded
			//
			this.btnRemoveExcluded.Location = new System.Drawing.Point(826, 457);
			this.btnRemoveExcluded.Name = "btnRemoveExcluded";
			this.btnRemoveExcluded.Size = new System.Drawing.Size(64, 24);
			this.btnRemoveExcluded.TabIndex = 11;
			this.btnRemoveExcluded.Text = "&Deselect";
			this.btnRemoveExcluded.UseVisualStyleBackColor = true;
			//
			//dgExcludedSenders
			//
			this.dgExcludedSenders.AllowUserToAddRows = false;
			this.dgExcludedSenders.AllowUserToDeleteRows = false;
			this.dgExcludedSenders.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
			this.dgExcludedSenders.Location = new System.Drawing.Point(457, 24);
			this.dgExcludedSenders.Name = "dgExcludedSenders";
			this.dgExcludedSenders.ReadOnly = true;
			this.dgExcludedSenders.Size = new System.Drawing.Size(435, 417);
			this.dgExcludedSenders.TabIndex = 14;
			//
			//dgEmailSenders
			//
			this.dgEmailSenders.AllowUserToAddRows = false;
			this.dgEmailSenders.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
			this.dgEmailSenders.Location = new System.Drawing.Point(11, 25);
			this.dgEmailSenders.Name = "dgEmailSenders";
			this.dgEmailSenders.ReadOnly = true;
			this.dgEmailSenders.Size = new System.Drawing.Size(435, 417);
			this.dgEmailSenders.TabIndex = 19;
			//
			//ExcludeFromBindingSource
			//
			this.ExcludeFromBindingSource.DataMember = "ExcludeFrom";
			//
			//ArchiveFromBindingSource
			//
			//
			//ExcludeFromTableAdapter
			//
			//
			//DMAUDDataSetBindingSource
			//
			this.DMAUDDataSetBindingSource.Position = 0;
			//
			//_DMA_UDDataSet2
			//
			//
			//DMAUDDataSet2BindingSource
			//
			//
			//ArchiveFromTableAdapter
			//
			//
			//Timer1
			//
			//
			//f1Help
			//
			this.f1Help.HelpNamespace = "http://www.ecmlibrary.com/helpfiles/frmSenderMgt.htm";
			//
			//cbOutlookFOlder
			//
			this.cbOutlookFOlder.FormattingEnabled = true;
			this.cbOutlookFOlder.Location = new System.Drawing.Point(123, 84);
			this.cbOutlookFOlder.Name = "cbOutlookFOlder";
			this.cbOutlookFOlder.Size = new System.Drawing.Size(301, 21);
			this.cbOutlookFOlder.TabIndex = 14;
			//
			//frmSenderMgt
			//
			this.AutoScaleDimensions = new System.Drawing.SizeF((float) (6.0F), (float) (13.0F));
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.ClientSize = new System.Drawing.Size(902, 581);
			this.Controls.Add(this.dgEmailSenders);
			this.Controls.Add(this.dgExcludedSenders);
			this.Controls.Add(this.btnRemoveExcluded);
			this.Controls.Add(this.GroupBox1);
			this.Controls.Add(this.Label2);
			this.Controls.Add(this.Label1);
			this.f1Help.SetHelpString(this, "http://www.ecmlibrary.com/helpfiles/frmSenderMgt.htm");
			this.Name = "frmSenderMgt";
			this.f1Help.SetShowHelp(this, true);
			this.Text = "Rejected Senders Management Screen";
			this.GroupBox1.ResumeLayout(false);
			this.GroupBox1.PerformLayout();
			((System.ComponentModel.ISupportInitialize) this.dgExcludedSenders).EndInit();
			((System.ComponentModel.ISupportInitialize) this.dgEmailSenders).EndInit();
			((System.ComponentModel.ISupportInitialize) this.ExcludeFromBindingSource).EndInit();
			((System.ComponentModel.ISupportInitialize) this.ArchiveFromBindingSource).EndInit();
			((System.ComponentModel.ISupportInitialize) this.DMAUDDataSetBindingSource).EndInit();
			((System.ComponentModel.ISupportInitialize) this.DMAUDDataSet2BindingSource).EndInit();
			this.ResumeLayout(false);
			this.PerformLayout();
			
		}
		internal System.Windows.Forms.Label Label1;
		internal System.Windows.Forms.Label Label2;
		internal System.Windows.Forms.GroupBox GroupBox1;
		internal System.Windows.Forms.Button btnExclSender;
		internal System.Windows.Forms.RadioButton rbInbox;
		internal System.Windows.Forms.RadioButton rbArchive;
		internal System.Windows.Forms.Button btnRemoveExcluded;
		internal System.Windows.Forms.RadioButton rbContacts;
		internal System.Windows.Forms.DataGridView dgExcludedSenders;
		internal System.Windows.Forms.BindingSource ExcludeFromBindingSource;
		internal System.Windows.Forms.Button btnRefresh;
		internal System.Windows.Forms.BindingSource DMAUDDataSetBindingSource;
		internal System.Windows.Forms.BindingSource DMAUDDataSet2BindingSource;
		internal System.Windows.Forms.DataGridView dgEmailSenders;
		internal System.Windows.Forms.BindingSource ArchiveFromBindingSource;
		internal System.Windows.Forms.ToolTip TT;
		internal System.Windows.Forms.Timer Timer1;
		internal System.Windows.Forms.HelpProvider f1Help;
		internal System.Windows.Forms.ComboBox cbOutlookFOlder;
	}
	
}
