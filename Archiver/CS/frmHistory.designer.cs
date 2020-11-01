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
	[global::Microsoft.VisualBasic.CompilerServices.DesignerGenerated()]public partial class frmHistory : System.Windows.Forms.Form
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
			this.lbHistory = new System.Windows.Forms.ListBox();
			base.Load += new System.EventHandler(frmHistory_Load);
			this.lbHistory.SelectedIndexChanged += new System.EventHandler(this.lbHistory_SelectedIndexChanged);
			this.SuspendLayout();
			//
			//lbHistory
			//
			this.lbHistory.Dock = System.Windows.Forms.DockStyle.Fill;
			this.lbHistory.FormattingEnabled = true;
			this.lbHistory.Location = new System.Drawing.Point(0, 0);
			this.lbHistory.Name = "lbHistory";
			this.lbHistory.Size = new System.Drawing.Size(890, 433);
			this.lbHistory.TabIndex = 0;
			//
			//frmHistory
			//
			this.AutoScaleDimensions = new System.Drawing.SizeF((float) (6.0F), (float) (13.0F));
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.ClientSize = new System.Drawing.Size(890, 437);
			this.Controls.Add(this.lbHistory);
			this.Name = "frmHistory";
			this.Text = "History of improvements      (frmHistory)";
			this.ResumeLayout(false);
			
		}
		internal System.Windows.Forms.ListBox lbHistory;
	}
	
}
