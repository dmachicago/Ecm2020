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
	[global::Microsoft.VisualBasic.CompilerServices.DesignerGenerated()]public partial class frmAgreement : System.Windows.Forms.Form
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
			System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(frmAgreement));
			this.txtAgreement = new System.Windows.Forms.TextBox();
			base.Load += new System.EventHandler(frmAgreement_Load);
			this.ckAgree = new System.Windows.Forms.CheckBox();
			this.ckAgree.CheckedChanged += new System.EventHandler(this.ckAgree_CheckedChanged);
			this.ckDisagree = new System.Windows.Forms.CheckBox();
			this.ckDisagree.CheckedChanged += new System.EventHandler(this.ckDisagree_CheckedChanged);
			this.btnProcess = new System.Windows.Forms.Button();
			this.btnProcess.Click += new System.EventHandler(this.btnProcess_Click);
			this.SuspendLayout();
			//
			//txtAgreement
			//
			this.txtAgreement.Anchor = (System.Windows.Forms.AnchorStyles) (((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right);
			this.txtAgreement.Location = new System.Drawing.Point(12, 12);
			this.txtAgreement.Multiline = true;
			this.txtAgreement.Name = "txtAgreement";
			this.txtAgreement.ReadOnly = true;
			this.txtAgreement.ScrollBars = System.Windows.Forms.ScrollBars.Both;
			this.txtAgreement.Size = new System.Drawing.Size(465, 155);
			this.txtAgreement.TabIndex = 10;
			//
			//ckAgree
			//
			this.ckAgree.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.ckAgree.AutoSize = true;
			this.ckAgree.Location = new System.Drawing.Point(277, 194);
			this.ckAgree.Name = "ckAgree";
			this.ckAgree.Size = new System.Drawing.Size(54, 17);
			this.ckAgree.TabIndex = 2;
			this.ckAgree.Text = "Agree";
			this.ckAgree.UseVisualStyleBackColor = true;
			//
			//ckDisagree
			//
			this.ckDisagree.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.ckDisagree.AutoSize = true;
			this.ckDisagree.Location = new System.Drawing.Point(277, 237);
			this.ckDisagree.Name = "ckDisagree";
			this.ckDisagree.Size = new System.Drawing.Size(68, 17);
			this.ckDisagree.TabIndex = 1;
			this.ckDisagree.Text = "Disagree";
			this.ckDisagree.UseVisualStyleBackColor = true;
			//
			//btnProcess
			//
			this.btnProcess.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right);
			this.btnProcess.Location = new System.Drawing.Point(376, 194);
			this.btnProcess.Name = "btnProcess";
			this.btnProcess.Size = new System.Drawing.Size(101, 60);
			this.btnProcess.TabIndex = 0;
			this.btnProcess.Text = "Proceed";
			this.btnProcess.UseVisualStyleBackColor = true;
			//
			//frmAgreement
			//
			this.AutoScaleDimensions = new System.Drawing.SizeF((float) (6.0F), (float) (13.0F));
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.ClientSize = new System.Drawing.Size(489, 267);
			this.Controls.Add(this.btnProcess);
			this.Controls.Add(this.ckDisagree);
			this.Controls.Add(this.ckAgree);
			this.Controls.Add(this.txtAgreement);
			this.Icon = (System.Drawing.Icon) (resources.GetObject("$this.Icon"));
			this.Name = "frmAgreement";
			this.Text = "Legal Agreement";
			this.ResumeLayout(false);
			this.PerformLayout();
			
		}
		internal System.Windows.Forms.TextBox txtAgreement;
		internal System.Windows.Forms.CheckBox ckAgree;
		internal System.Windows.Forms.CheckBox ckDisagree;
		internal System.Windows.Forms.Button btnProcess;
	}
	
}
