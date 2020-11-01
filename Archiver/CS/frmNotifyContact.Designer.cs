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
	[global::Microsoft.VisualBasic.CompilerServices.DesignerGenerated()]public partial class frmNotifyContact : System.Windows.Forms.Form
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
			System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(frmNotifyContact));
			this.lblMsg = new System.Windows.Forms.Label();
			base.Load += new System.EventHandler(frmNotifyContact_Load);
			this.lblMsg2 = new System.Windows.Forms.Label();
			this.SuspendLayout();
			//
			//lblMsg
			//
			this.lblMsg.AutoSize = true;
			this.lblMsg.Location = new System.Drawing.Point(12, 9);
			this.lblMsg.Name = "lblMsg";
			this.lblMsg.Size = new System.Drawing.Size(59, 13);
			this.lblMsg.TabIndex = 0;
			this.lblMsg.Text = "CONTENT";
			//
			//lblMsg2
			//
			this.lblMsg2.AutoSize = true;
			this.lblMsg2.Location = new System.Drawing.Point(12, 35);
			this.lblMsg2.Name = "lblMsg2";
			this.lblMsg2.Size = new System.Drawing.Size(26, 13);
			this.lblMsg2.TabIndex = 1;
			this.lblMsg2.Text = "File:";
			//
			//frmNotifyContact
			//
			this.AutoScaleDimensions = new System.Drawing.SizeF((float) (6.0F), (float) (13.0F));
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.BackColor = System.Drawing.Color.White;
			this.ClientSize = new System.Drawing.Size(357, 57);
			this.Controls.Add(this.lblMsg2);
			this.Controls.Add(this.lblMsg);
			this.DoubleBuffered = true;
			this.Icon = (System.Drawing.Icon) (resources.GetObject("$this.Icon"));
			this.MaximizeBox = false;
			this.Name = "frmNotifyContact";
			this.Text = "Active           (frmNotifyContact)";
			this.ResumeLayout(false);
			this.PerformLayout();
			
		}
		internal System.Windows.Forms.Label lblMsg;
		internal System.Windows.Forms.Label lblMsg2;
	}
	
}
