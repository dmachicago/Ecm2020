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
	[global::Microsoft.VisualBasic.CompilerServices.DesignerGenerated()]public partial class frmLibraryAssgnList : System.Windows.Forms.Form
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
			this.lbLibraries = new System.Windows.Forms.ListBox();
			base.Load += new System.EventHandler(frmLibraryAssgnList_Load);
			this.SuspendLayout();
			//
			//lbLibraries
			//
			this.lbLibraries.Dock = System.Windows.Forms.DockStyle.Fill;
			this.lbLibraries.FormattingEnabled = true;
			this.lbLibraries.Location = new System.Drawing.Point(0, 0);
			this.lbLibraries.Name = "lbLibraries";
			this.lbLibraries.Size = new System.Drawing.Size(179, 160);
			this.lbLibraries.TabIndex = 0;
			//
			//frmLibraryAssgnList
			//
			this.AutoScaleDimensions = new System.Drawing.SizeF((float) (6.0F), (float) (13.0F));
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.ClientSize = new System.Drawing.Size(179, 163);
			this.Controls.Add(this.lbLibraries);
			this.Name = "frmLibraryAssgnList";
			this.StartPosition = System.Windows.Forms.FormStartPosition.Manual;
			this.Text = "Assigned Libraries     (frmLibraryAssgnList)";
			this.TopMost = true;
			this.ResumeLayout(false);
			
		}
		internal System.Windows.Forms.ListBox lbLibraries;
	}
	
}
