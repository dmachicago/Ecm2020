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
	[global::Microsoft.VisualBasic.CompilerServices.DesignerGenerated()]public partial class frmEncryptString : System.Windows.Forms.Form
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
			this.txtUnencrypted = new System.Windows.Forms.TextBox();
			this.txtEncrypted = new System.Windows.Forms.TextBox();
			this.btnEncrypt = new System.Windows.Forms.Button();
			this.btnEncrypt.Click += new System.EventHandler(this.btnEncrypt_Click);
			this.btnCopy = new System.Windows.Forms.Button();
			this.btnCopy.Click += new System.EventHandler(this.btnCopy_Click);
			this.SuspendLayout();
			//
			//txtUnencrypted
			//
			this.txtUnencrypted.Anchor = (System.Windows.Forms.AnchorStyles) ((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right);
			this.txtUnencrypted.Location = new System.Drawing.Point(12, 26);
			this.txtUnencrypted.Multiline = true;
			this.txtUnencrypted.Name = "txtUnencrypted";
			this.txtUnencrypted.Size = new System.Drawing.Size(403, 120);
			this.txtUnencrypted.TabIndex = 0;
			//
			//txtEncrypted
			//
			this.txtEncrypted.Anchor = (System.Windows.Forms.AnchorStyles) ((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right);
			this.txtEncrypted.Location = new System.Drawing.Point(12, 152);
			this.txtEncrypted.Multiline = true;
			this.txtEncrypted.Name = "txtEncrypted";
			this.txtEncrypted.Size = new System.Drawing.Size(403, 120);
			this.txtEncrypted.TabIndex = 1;
			//
			//btnEncrypt
			//
			this.btnEncrypt.Anchor = (System.Windows.Forms.AnchorStyles) ((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) | System.Windows.Forms.AnchorStyles.Right);
			this.btnEncrypt.Location = new System.Drawing.Point(430, 51);
			this.btnEncrypt.Name = "btnEncrypt";
			this.btnEncrypt.Size = new System.Drawing.Size(69, 59);
			this.btnEncrypt.TabIndex = 2;
			this.btnEncrypt.Text = "Encrypt";
			this.btnEncrypt.UseVisualStyleBackColor = true;
			//
			//btnCopy
			//
			this.btnCopy.Anchor = (System.Windows.Forms.AnchorStyles) ((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) | System.Windows.Forms.AnchorStyles.Right);
			this.btnCopy.Location = new System.Drawing.Point(430, 181);
			this.btnCopy.Name = "btnCopy";
			this.btnCopy.Size = new System.Drawing.Size(69, 59);
			this.btnCopy.TabIndex = 3;
			this.btnCopy.Text = "Copy to Clipboard";
			this.btnCopy.UseVisualStyleBackColor = true;
			//
			//frmEncryptString
			//
			this.AutoScaleDimensions = new System.Drawing.SizeF((float) (6.0F), (float) (13.0F));
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.ClientSize = new System.Drawing.Size(512, 273);
			this.Controls.Add(this.btnCopy);
			this.Controls.Add(this.btnEncrypt);
			this.Controls.Add(this.txtEncrypted);
			this.Controls.Add(this.txtUnencrypted);
			this.Name = "frmEncryptString";
			this.Text = "Encrypt Phrase       (frmEncryptString)";
			this.ResumeLayout(false);
			this.PerformLayout();
			
		}
		internal System.Windows.Forms.TextBox txtUnencrypted;
		internal System.Windows.Forms.TextBox txtEncrypted;
		internal System.Windows.Forms.Button btnEncrypt;
		internal System.Windows.Forms.Button btnCopy;
	}
	
}
