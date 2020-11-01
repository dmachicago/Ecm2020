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
	[global::Microsoft.VisualBasic.CompilerServices.DesignerGenerated()]public partial class frmOutlookNotice : System.Windows.Forms.Form
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
			base.Load += new System.EventHandler(frmOutlookNotice_Load);
			this.Label1 = new System.Windows.Forms.Label();
			this.Label2 = new System.Windows.Forms.Label();
			this.Label3 = new System.Windows.Forms.Label();
			this.Label4 = new System.Windows.Forms.Label();
			this.Label5 = new System.Windows.Forms.Label();
			this.btnTerminate = new System.Windows.Forms.Button();
			this.btnTerminate.Click += new System.EventHandler(this.btnTerminate_Click);
			this.Timer1 = new System.Windows.Forms.Timer(this.components);
			this.Timer1.Tick += new System.EventHandler(this.Timer1_Tick);
			this.StatusStrip1 = new System.Windows.Forms.StatusStrip();
			this.statElapsedTime = new System.Windows.Forms.ToolStripStatusLabel();
			this.PB = new System.Windows.Forms.ToolStripProgressBar();
			this.StatusStrip1.SuspendLayout();
			this.SuspendLayout();
			//
			//Label1
			//
			this.Label1.AutoSize = true;
			this.Label1.Font = new System.Drawing.Font("Microsoft Sans Serif", (float) (15.75F), System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, (byte) (0));
			this.Label1.Location = new System.Drawing.Point(14, 16);
			this.Label1.Name = "Label1";
			this.Label1.Size = new System.Drawing.Size(86, 25);
			this.Label1.TabIndex = 0;
			this.Label1.Text = "Notice:";
			//
			//Label2
			//
			this.Label2.AutoSize = true;
			this.Label2.Location = new System.Drawing.Point(14, 49);
			this.Label2.Name = "Label2";
			this.Label2.Size = new System.Drawing.Size(307, 13);
			this.Label2.TabIndex = 1;
			this.Label2.Text = "Outlook is running. This can cause ECM to be unstable at time. ";
			//
			//Label3
			//
			this.Label3.AutoSize = true;
			this.Label3.Location = new System.Drawing.Point(14, 70);
			this.Label3.Name = "Label3";
			this.Label3.Size = new System.Drawing.Size(356, 13);
			this.Label3.TabIndex = 2;
			this.Label3.Text = "If this screen does not close in a few seconds, please terminate all running";
			//
			//Label4
			//
			this.Label4.AutoSize = true;
			this.Label4.Location = new System.Drawing.Point(14, 91);
			this.Label4.Name = "Label4";
			this.Label4.Size = new System.Drawing.Size(331, 13);
			this.Label4.TabIndex = 3;
			this.Label4.Text = "instances of Outlook by pressing the Terminate button and execution";
			//
			//Label5
			//
			this.Label5.AutoSize = true;
			this.Label5.Location = new System.Drawing.Point(14, 112);
			this.Label5.Name = "Label5";
			this.Label5.Size = new System.Drawing.Size(85, 13);
			this.Label5.TabIndex = 4;
			this.Label5.Text = "should continue.";
			//
			//btnTerminate
			//
			this.btnTerminate.Location = new System.Drawing.Point(265, 124);
			this.btnTerminate.Name = "btnTerminate";
			this.btnTerminate.Size = new System.Drawing.Size(105, 26);
			this.btnTerminate.TabIndex = 5;
			this.btnTerminate.Text = "Terminate";
			this.btnTerminate.UseVisualStyleBackColor = true;
			//
			//Timer1
			//
			this.Timer1.Enabled = true;
			this.Timer1.Interval = 1000;
			//
			//StatusStrip1
			//
			this.StatusStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {this.statElapsedTime, this.PB});
			this.StatusStrip1.Location = new System.Drawing.Point(0, 163);
			this.StatusStrip1.Name = "StatusStrip1";
			this.StatusStrip1.Size = new System.Drawing.Size(389, 22);
			this.StatusStrip1.TabIndex = 6;
			this.StatusStrip1.Text = "StatusStrip1";
			//
			//statElapsedTime
			//
			this.statElapsedTime.Name = "statElapsedTime";
			this.statElapsedTime.Size = new System.Drawing.Size(77, 17);
			this.statElapsedTime.Text = "Elapsed Time";
			//
			//PB
			//
			this.PB.Name = "PB";
			this.PB.Size = new System.Drawing.Size(100, 16);
			//
			//frmOutlookNotice
			//
			this.AutoScaleDimensions = new System.Drawing.SizeF((float) (6.0F), (float) (13.0F));
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.ClientSize = new System.Drawing.Size(389, 185);
			this.Controls.Add(this.StatusStrip1);
			this.Controls.Add(this.btnTerminate);
			this.Controls.Add(this.Label5);
			this.Controls.Add(this.Label4);
			this.Controls.Add(this.Label3);
			this.Controls.Add(this.Label2);
			this.Controls.Add(this.Label1);
			this.Name = "frmOutlookNotice";
			this.Text = "Notification       (frmOutlookNotice)";
			this.TopMost = true;
			this.StatusStrip1.ResumeLayout(false);
			this.StatusStrip1.PerformLayout();
			this.ResumeLayout(false);
			this.PerformLayout();
			
		}
		internal System.Windows.Forms.Label Label1;
		internal System.Windows.Forms.Label Label2;
		internal System.Windows.Forms.Label Label3;
		internal System.Windows.Forms.Label Label4;
		internal System.Windows.Forms.Label Label5;
		internal System.Windows.Forms.Button btnTerminate;
		internal System.Windows.Forms.Timer Timer1;
		internal System.Windows.Forms.StatusStrip StatusStrip1;
		internal System.Windows.Forms.ToolStripStatusLabel statElapsedTime;
		internal System.Windows.Forms.ToolStripProgressBar PB;
	}
	
}
