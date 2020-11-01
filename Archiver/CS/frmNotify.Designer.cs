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
	[global::Microsoft.VisualBasic.CompilerServices.DesignerGenerated()]public partial class frmNotify : System.Windows.Forms.Form
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
			System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(frmNotify));
			this.Label1 = new System.Windows.Forms.Label();
			base.Load += new System.EventHandler(frmNotify_Load);
			this.lblFileSpec = new System.Windows.Forms.Label();
			this.lblPdgPages = new System.Windows.Forms.Label();
			this.SuspendLayout();
			//
			//Label1
			//
			this.Label1.AutoSize = true;
			this.Label1.Location = new System.Drawing.Point(12, 9);
			this.Label1.Name = "Label1";
			this.Label1.Size = new System.Drawing.Size(59, 13);
			this.Label1.TabIndex = 0;
			this.Label1.Text = "CONTENT";
			//
			//lblFileSpec
			//
			this.lblFileSpec.AutoSize = true;
			this.lblFileSpec.Location = new System.Drawing.Point(12, 35);
			this.lblFileSpec.Name = "lblFileSpec";
			this.lblFileSpec.Size = new System.Drawing.Size(26, 13);
			this.lblFileSpec.TabIndex = 1;
			this.lblFileSpec.Text = "File:";
			//
			//lblPdgPages
			//
			this.lblPdgPages.AutoSize = true;
			this.lblPdgPages.Location = new System.Drawing.Point(269, 9);
			this.lblPdgPages.Name = "lblPdgPages";
			this.lblPdgPages.Size = new System.Drawing.Size(40, 13);
			this.lblPdgPages.TabIndex = 2;
			this.lblPdgPages.Text = "Pages:";
			//
			//frmNotify
			//
			this.AutoScaleDimensions = new System.Drawing.SizeF((float) (6.0F), (float) (13.0F));
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.BackColor = System.Drawing.Color.White;
			this.ClientSize = new System.Drawing.Size(357, 57);
			this.Controls.Add(this.lblPdgPages);
			this.Controls.Add(this.lblFileSpec);
			this.Controls.Add(this.Label1);
			this.DoubleBuffered = true;
			this.Icon = (System.Drawing.Icon) (resources.GetObject("$this.Icon"));
			this.MaximizeBox = false;
			this.Name = "frmNotify";
			this.Text = "Notice           (frmNotify)";
			this.ResumeLayout(false);
			this.PerformLayout();
			
		}
		internal System.Windows.Forms.Label Label1;
		internal System.Windows.Forms.Label lblFileSpec;
		internal System.Windows.Forms.Label lblPdgPages;
	}
	
}
