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
	[global::Microsoft.VisualBasic.CompilerServices.DesignerGenerated()]public partial class frmMsg : System.Windows.Forms.Form
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
			this.txtMsg = new System.Windows.Forms.TextBox();
			base.Load += new System.EventHandler(frmMsg_Load);
			this.SuspendLayout();
			//
			//txtMsg
			//
			this.txtMsg.Location = new System.Drawing.Point(12, 12);
			this.txtMsg.Name = "txtMsg";
			this.txtMsg.Size = new System.Drawing.Size(536, 20);
			this.txtMsg.TabIndex = 0;
			//
			//frmMsg
			//
			this.AutoScaleDimensions = new System.Drawing.SizeF((float) (6.0F), (float) (13.0F));
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.BackColor = System.Drawing.Color.FromArgb(System.Convert.ToInt32((byte) (64)), System.Convert.ToInt32((byte) (64)), System.Convert.ToInt32((byte) (64)));
			this.ClientSize = new System.Drawing.Size(560, 44);
			this.Controls.Add(this.txtMsg);
			this.Name = "frmMsg";
			this.StartPosition = System.Windows.Forms.FormStartPosition.Manual;
			this.Text = "Information";
			this.ResumeLayout(false);
			this.PerformLayout();
			
		}
		internal System.Windows.Forms.TextBox txtMsg;
	}
	
}
