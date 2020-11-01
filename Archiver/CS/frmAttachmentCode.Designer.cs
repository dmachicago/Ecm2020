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
	[global::Microsoft.VisualBasic.CompilerServices.DesignerGenerated()]public partial class frmAttachmentCode : System.Windows.Forms.Form
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
			this.Deactivate += new System.EventHandler(frmAttachmentCode_Deactivate);
			this.Disposed += new System.EventHandler(frmAttachmentCode_Disposed);
			base.Load += new System.EventHandler(frmAttachmentCode_Load);
			this.Resize += new System.EventHandler(frmAttachmentCode_Resize);
			this.dgAttachmentCode = new System.Windows.Forms.DataGridView();
			this.dgAttachmentCode.CellContentClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgAttachmentCode_CellContentClick);
			this.btnUpdate = new System.Windows.Forms.Button();
			this.btnUpdate.Click += new System.EventHandler(this.btnUpdate_Click);
			this.TT = new System.Windows.Forms.ToolTip(this.components);
			this.btnApplyRetentionRule = new System.Windows.Forms.Button();
			this.btnApplyRetentionRule.Click += new System.EventHandler(this.btnApplyRetentionRule_Click);
			this.Timer1 = new System.Windows.Forms.Timer(this.components);
			this.Timer1.Tick += new System.EventHandler(this.Timer1_Tick);
			this.HelpProvider1 = new System.Windows.Forms.HelpProvider();
			this.btnEncrypt = new System.Windows.Forms.Button();
			this.btnEncrypt.Click += new System.EventHandler(this.btnEncrypt_Click);
			this.Label1 = new System.Windows.Forms.Label();
			this.cbRetention = new System.Windows.Forms.ComboBox();
			((System.ComponentModel.ISupportInitialize) this.dgAttachmentCode).BeginInit();
			this.SuspendLayout();
			//
			//dgAttachmentCode
			//
			this.dgAttachmentCode.AllowUserToOrderColumns = true;
			this.dgAttachmentCode.Anchor = (System.Windows.Forms.AnchorStyles) (((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right);
			this.dgAttachmentCode.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
			this.dgAttachmentCode.Location = new System.Drawing.Point(12, 12);
			this.dgAttachmentCode.Name = "dgAttachmentCode";
			this.dgAttachmentCode.Size = new System.Drawing.Size(463, 331);
			this.dgAttachmentCode.TabIndex = 0;
			//
			//btnUpdate
			//
			this.btnUpdate.Anchor = (System.Windows.Forms.AnchorStyles) ((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right);
			this.btnUpdate.Location = new System.Drawing.Point(327, 354);
			this.btnUpdate.Name = "btnUpdate";
			this.btnUpdate.Size = new System.Drawing.Size(147, 32);
			this.btnUpdate.TabIndex = 1;
			this.btnUpdate.Text = "&Update";
			this.btnUpdate.UseVisualStyleBackColor = true;
			//
			//btnApplyRetentionRule
			//
			this.btnApplyRetentionRule.Anchor = (System.Windows.Forms.AnchorStyles) ((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right);
			this.btnApplyRetentionRule.Location = new System.Drawing.Point(444, 395);
			this.btnApplyRetentionRule.Name = "btnApplyRetentionRule";
			this.btnApplyRetentionRule.Size = new System.Drawing.Size(29, 21);
			this.btnApplyRetentionRule.TabIndex = 5;
			this.btnApplyRetentionRule.Text = "@";
			this.TT.SetToolTip(this.btnApplyRetentionRule, "Press to apply selected retention rule to selected item.");
			this.btnApplyRetentionRule.UseVisualStyleBackColor = true;
			//
			//Timer1
			//
			this.Timer1.Enabled = true;
			//
			//HelpProvider1
			//
			this.HelpProvider1.HelpNamespace = "http://www.ecmlibrary.com/helpfiles/frmAttachmentCodes.htm";
			//
			//btnEncrypt
			//
			this.btnEncrypt.Anchor = (System.Windows.Forms.AnchorStyles) ((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right);
			this.btnEncrypt.Location = new System.Drawing.Point(12, 354);
			this.btnEncrypt.Name = "btnEncrypt";
			this.btnEncrypt.Size = new System.Drawing.Size(147, 32);
			this.btnEncrypt.TabIndex = 2;
			this.btnEncrypt.Text = "Encrypt Password";
			this.btnEncrypt.UseVisualStyleBackColor = true;
			//
			//Label1
			//
			this.Label1.Anchor = (System.Windows.Forms.AnchorStyles) ((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right);
			this.Label1.AutoSize = true;
			this.Label1.Location = new System.Drawing.Point(12, 399);
			this.Label1.Name = "Label1";
			this.Label1.Size = new System.Drawing.Size(158, 13);
			this.Label1.TabIndex = 3;
			this.Label1.Text = "Please Select a Retention Rule:";
			//
			//cbRetention
			//
			this.cbRetention.Anchor = (System.Windows.Forms.AnchorStyles) ((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right);
			this.cbRetention.FormattingEnabled = true;
			this.cbRetention.Location = new System.Drawing.Point(191, 396);
			this.cbRetention.Name = "cbRetention";
			this.cbRetention.Size = new System.Drawing.Size(245, 21);
			this.cbRetention.TabIndex = 4;
			//
			//frmAttachmentCode
			//
			this.AutoScaleDimensions = new System.Drawing.SizeF((float) (6.0F), (float) (13.0F));
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.ClientSize = new System.Drawing.Size(490, 421);
			this.Controls.Add(this.btnApplyRetentionRule);
			this.Controls.Add(this.cbRetention);
			this.Controls.Add(this.Label1);
			this.Controls.Add(this.btnEncrypt);
			this.Controls.Add(this.btnUpdate);
			this.Controls.Add(this.dgAttachmentCode);
			this.HelpProvider1.SetHelpString(this, "http://www.ecmlibrary.com/helpfiles/frmAttachmentCodes.htm");
			this.Name = "frmAttachmentCode";
			this.HelpProvider1.SetShowHelp(this, true);
			this.Text = "Attachment Codes";
			((System.ComponentModel.ISupportInitialize) this.dgAttachmentCode).EndInit();
			this.ResumeLayout(false);
			this.PerformLayout();
			
		}
		internal System.Windows.Forms.DataGridView dgAttachmentCode;
		internal System.Windows.Forms.Button btnUpdate;
		internal System.Windows.Forms.ToolTip TT;
		internal System.Windows.Forms.Timer Timer1;
		internal System.Windows.Forms.HelpProvider HelpProvider1;
		internal System.Windows.Forms.Button btnEncrypt;
		internal System.Windows.Forms.Label Label1;
		internal System.Windows.Forms.ComboBox cbRetention;
		internal System.Windows.Forms.Button btnApplyRetentionRule;
	}
	
}
