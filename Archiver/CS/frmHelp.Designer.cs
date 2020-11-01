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
	[global::Microsoft.VisualBasic.CompilerServices.DesignerGenerated()]public partial class frmHelp : System.Windows.Forms.Form
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
			base.Load += new System.EventHandler(frmHelp_Load);
			this.rtbText = new System.Windows.Forms.RichTextBox();
			this.lblScreenName = new System.Windows.Forms.Label();
			this.lblObject = new System.Windows.Forms.Label();
			this.Timer1 = new System.Windows.Forms.Timer(this.components);
			this.Timer1.Tick += new System.EventHandler(this.Timer1_Tick);
			this.SuspendLayout();
			//
			//rtbText
			//
			this.rtbText.Location = new System.Drawing.Point(12, 33);
			this.rtbText.Name = "rtbText";
			this.rtbText.Size = new System.Drawing.Size(260, 219);
			this.rtbText.TabIndex = 0;
			this.rtbText.Text = "";
			//
			//lblScreenName
			//
			this.lblScreenName.AutoSize = true;
			this.lblScreenName.Location = new System.Drawing.Point(12, 9);
			this.lblScreenName.Name = "lblScreenName";
			this.lblScreenName.Size = new System.Drawing.Size(79, 13);
			this.lblScreenName.TabIndex = 1;
			this.lblScreenName.Text = "lblScreenName";
			//
			//lblObject
			//
			this.lblObject.AutoSize = true;
			this.lblObject.Location = new System.Drawing.Point(169, 9);
			this.lblObject.Name = "lblObject";
			this.lblObject.Size = new System.Drawing.Size(48, 13);
			this.lblObject.TabIndex = 2;
			this.lblObject.Text = "lblObject";
			//
			//Timer1
			//
			this.Timer1.Enabled = true;
			this.Timer1.Interval = 5000;
			//
			//frmHelp
			//
			this.AutoScaleDimensions = new System.Drawing.SizeF((float) (6.0F), (float) (13.0F));
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.ClientSize = new System.Drawing.Size(284, 264);
			this.Controls.Add(this.lblObject);
			this.Controls.Add(this.lblScreenName);
			this.Controls.Add(this.rtbText);
			this.Name = "frmHelp";
			this.StartPosition = System.Windows.Forms.FormStartPosition.Manual;
			this.Text = "Help Screen";
			this.ResumeLayout(false);
			this.PerformLayout();
			
		}
		internal System.Windows.Forms.RichTextBox rtbText;
		internal System.Windows.Forms.Label lblScreenName;
		internal System.Windows.Forms.Label lblObject;
		internal System.Windows.Forms.Timer Timer1;
	}
	
}
