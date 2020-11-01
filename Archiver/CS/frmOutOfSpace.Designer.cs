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
	[global::Microsoft.VisualBasic.CompilerServices.DesignerGenerated()]public partial class frmOutOfSpace : System.Windows.Forms.Form
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
			this.Label1 = new System.Windows.Forms.Label();
			this.Label2 = new System.Windows.Forms.Label();
			this.btnStopExecution = new System.Windows.Forms.Button();
			this.btnStopExecution.Click += new System.EventHandler(this.btnStopExecution_Click);
			this.SuspendLayout();
			//
			//Label1
			//
			this.Label1.AutoSize = true;
			this.Label1.BackColor = System.Drawing.Color.Yellow;
			this.Label1.Font = new System.Drawing.Font("Microsoft Sans Serif", (float) (24.0F), System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, (byte) (0));
			this.Label1.Location = new System.Drawing.Point(12, 21);
			this.Label1.Name = "Label1";
			this.Label1.Size = new System.Drawing.Size(244, 37);
			this.Label1.TabIndex = 0;
			this.Label1.Text = "Out of SPACE!";
			//
			//Label2
			//
			this.Label2.AutoSize = true;
			this.Label2.Font = new System.Drawing.Font("Arial Narrow", (float) (36.0F), System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, (byte) (0));
			this.Label2.ForeColor = System.Drawing.Color.Yellow;
			this.Label2.Location = new System.Drawing.Point(17, 69);
			this.Label2.Name = "Label2";
			this.Label2.Size = new System.Drawing.Size(239, 57);
			this.Label2.TabIndex = 1;
			this.Label2.Text = "Contact I.T.";
			//
			//btnStopExecution
			//
			this.btnStopExecution.Location = new System.Drawing.Point(37, 129);
			this.btnStopExecution.Name = "btnStopExecution";
			this.btnStopExecution.Size = new System.Drawing.Size(192, 31);
			this.btnStopExecution.TabIndex = 2;
			this.btnStopExecution.Text = "Close ECM Application";
			this.btnStopExecution.UseVisualStyleBackColor = true;
			//
			//frmOutOfSpace
			//
			this.AutoScaleDimensions = new System.Drawing.SizeF((float) (6.0F), (float) (13.0F));
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.BackColor = System.Drawing.Color.Red;
			this.ClientSize = new System.Drawing.Size(284, 171);
			this.Controls.Add(this.btnStopExecution);
			this.Controls.Add(this.Label2);
			this.Controls.Add(this.Label1);
			this.Name = "frmOutOfSpace";
			this.Text = "frmOutOfSpace";
			this.TopMost = true;
			this.ResumeLayout(false);
			this.PerformLayout();
			
		}
		internal System.Windows.Forms.Label Label1;
		internal System.Windows.Forms.Label Label2;
		internal System.Windows.Forms.Button btnStopExecution;
	}
	
}
