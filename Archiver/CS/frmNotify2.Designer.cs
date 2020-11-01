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
	[global::Microsoft.VisualBasic.CompilerServices.DesignerGenerated()]public partial class frmNotify2 : System.Windows.Forms.Form
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
			this.lblEmailMsg = new System.Windows.Forms.Label();
			base.Load += new System.EventHandler(frmNotify2_Load);
			this.lblMsg2 = new System.Windows.Forms.Label();
			this.lblFolder = new System.Windows.Forms.Label();
			this.SuspendLayout();
			//
			//lblEmailMsg
			//
			this.lblEmailMsg.AutoSize = true;
			this.lblEmailMsg.Location = new System.Drawing.Point(12, 9);
			this.lblEmailMsg.Name = "lblEmailMsg";
			this.lblEmailMsg.Size = new System.Drawing.Size(30, 13);
			this.lblEmailMsg.TabIndex = 1;
			this.lblEmailMsg.Text = "Msg:";
			//
			//lblMsg2
			//
			this.lblMsg2.AutoSize = true;
			this.lblMsg2.Location = new System.Drawing.Point(12, 30);
			this.lblMsg2.Name = "lblMsg2";
			this.lblMsg2.Size = new System.Drawing.Size(30, 13);
			this.lblMsg2.TabIndex = 2;
			this.lblMsg2.Text = "Msg:";
			//
			//lblFolder
			//
			this.lblFolder.AutoSize = true;
			this.lblFolder.Location = new System.Drawing.Point(12, 49);
			this.lblFolder.Name = "lblFolder";
			this.lblFolder.Size = new System.Drawing.Size(30, 13);
			this.lblFolder.TabIndex = 3;
			this.lblFolder.Text = "Msg:";
			//
			//frmNotify2
			//
			this.AutoScaleDimensions = new System.Drawing.SizeF((float) (6.0F), (float) (13.0F));
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.BackColor = System.Drawing.Color.FromArgb(System.Convert.ToInt32((byte) (224)), System.Convert.ToInt32((byte) (224)), System.Convert.ToInt32((byte) (224)));
			this.ClientSize = new System.Drawing.Size(294, 71);
			this.Controls.Add(this.lblFolder);
			this.Controls.Add(this.lblMsg2);
			this.Controls.Add(this.lblEmailMsg);
			this.DoubleBuffered = true;
			this.ForeColor = System.Drawing.Color.Black;
			this.MaximizeBox = false;
			this.Name = "frmNotify2";
			this.Text = "Progress Tracking     (frmNotify2)";
			this.ResumeLayout(false);
			this.PerformLayout();
			
		}
		internal System.Windows.Forms.Label lblEmailMsg;
		internal System.Windows.Forms.Label lblMsg2;
		internal System.Windows.Forms.Label lblFolder;
	}
	
}
