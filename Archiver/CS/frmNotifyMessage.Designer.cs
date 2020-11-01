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
	[global::Microsoft.VisualBasic.CompilerServices.DesignerGenerated()]public partial class frmNotifyMessage : System.Windows.Forms.Form
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
			this.txtMsg = new System.Windows.Forms.TextBox();
			this.T1 = new System.Windows.Forms.Timer(this.components);
			this.T1.Tick += new System.EventHandler(this.T1_Tick);
			this.Label1 = new System.Windows.Forms.Label();
			this.SuspendLayout();
			//
			//txtMsg
			//
			this.txtMsg.BackColor = System.Drawing.Color.FromArgb(System.Convert.ToInt32((byte) (255)), System.Convert.ToInt32((byte) (255)), System.Convert.ToInt32((byte) (192)));
			this.txtMsg.Location = new System.Drawing.Point(12, 12);
			this.txtMsg.Multiline = true;
			this.txtMsg.Name = "txtMsg";
			this.txtMsg.Size = new System.Drawing.Size(260, 138);
			this.txtMsg.TabIndex = 0;
			//
			//T1
			//
			this.T1.Enabled = true;
			this.T1.Interval = 5000;
			//
			//Label1
			//
			this.Label1.AutoSize = true;
			this.Label1.Location = new System.Drawing.Point(18, 158);
			this.Label1.Name = "Label1";
			this.Label1.Size = new System.Drawing.Size(204, 13);
			this.Label1.TabIndex = 1;
			this.Label1.Text = "This message will go away in 30 seconds.";
			//
			//frmNotifyMessage
			//
			this.AutoScaleDimensions = new System.Drawing.SizeF((float) (6.0F), (float) (13.0F));
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.ClientSize = new System.Drawing.Size(284, 189);
			this.Controls.Add(this.Label1);
			this.Controls.Add(this.txtMsg);
			this.Name = "frmNotifyMessage";
			this.Text = "frmNotifyMessage";
			this.ResumeLayout(false);
			this.PerformLayout();
			
		}
		internal System.Windows.Forms.TextBox txtMsg;
		internal System.Windows.Forms.Timer T1;
		internal System.Windows.Forms.Label Label1;
	}
	
}
