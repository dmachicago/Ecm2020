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
	[global::Microsoft.VisualBasic.CompilerServices.DesignerGenerated()]public partial class frmExchangeMonitor : System.Windows.Forms.Form
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
			this.lblServer = new System.Windows.Forms.Label();
			this.lblMessageInfo = new System.Windows.Forms.Label();
			this.lblCnt = new System.Windows.Forms.Label();
			this.lblMsg = new System.Windows.Forms.Label();
			this.lblSpeed = new System.Windows.Forms.Label();
			this.txTime = new System.Windows.Forms.Label();
			this.ToolTip1 = new System.Windows.Forms.ToolTip(this.components);
			this.Label1 = new System.Windows.Forms.Label();
			this.Label2 = new System.Windows.Forms.Label();
			this.eTimeAvg = new System.Windows.Forms.Label();
			this.txAvg = new System.Windows.Forms.Label();
			this.SuspendLayout();
			//
			//lblServer
			//
			this.lblServer.AutoSize = true;
			this.lblServer.Location = new System.Drawing.Point(12, 9);
			this.lblServer.Name = "lblServer";
			this.lblServer.Size = new System.Drawing.Size(48, 13);
			this.lblServer.TabIndex = 0;
			this.lblServer.Text = "lblServer";
			//
			//lblMessageInfo
			//
			this.lblMessageInfo.AutoSize = true;
			this.lblMessageInfo.Location = new System.Drawing.Point(12, 33);
			this.lblMessageInfo.Name = "lblMessageInfo";
			this.lblMessageInfo.Size = new System.Drawing.Size(78, 13);
			this.lblMessageInfo.TabIndex = 1;
			this.lblMessageInfo.Text = "lblMessageInfo";
			//
			//lblCnt
			//
			this.lblCnt.AutoSize = true;
			this.lblCnt.Location = new System.Drawing.Point(12, 59);
			this.lblCnt.Name = "lblCnt";
			this.lblCnt.Size = new System.Drawing.Size(22, 13);
			this.lblCnt.TabIndex = 2;
			this.lblCnt.Text = "cnt";
			//
			//lblMsg
			//
			this.lblMsg.AutoSize = true;
			this.lblMsg.Location = new System.Drawing.Point(12, 84);
			this.lblMsg.Name = "lblMsg";
			this.lblMsg.Size = new System.Drawing.Size(50, 13);
			this.lblMsg.TabIndex = 3;
			this.lblMsg.Text = "Message";
			//
			//lblSpeed
			//
			this.lblSpeed.AutoSize = true;
			this.lblSpeed.Location = new System.Drawing.Point(12, 123);
			this.lblSpeed.Name = "lblSpeed";
			this.lblSpeed.Size = new System.Drawing.Size(36, 13);
			this.lblSpeed.TabIndex = 4;
			this.lblSpeed.Text = "eTime";
			this.ToolTip1.SetToolTip(this.lblSpeed, "Time to download the one email");
			//
			//txTime
			//
			this.txTime.AutoSize = true;
			this.txTime.Location = new System.Drawing.Point(12, 173);
			this.txTime.Name = "txTime";
			this.txTime.Size = new System.Drawing.Size(38, 13);
			this.txTime.TabIndex = 5;
			this.txTime.Text = "txTime";
			this.ToolTip1.SetToolTip(this.txTime, "Time to process the one email");
			//
			//Label1
			//
			this.Label1.AutoSize = true;
			this.Label1.Location = new System.Drawing.Point(12, 110);
			this.Label1.Name = "Label1";
			this.Label1.Size = new System.Drawing.Size(34, 13);
			this.Label1.TabIndex = 6;
			this.Label1.Text = "Fetch";
			this.ToolTip1.SetToolTip(this.Label1, "Time to download the one email");
			//
			//Label2
			//
			this.Label2.AutoSize = true;
			this.Label2.Location = new System.Drawing.Point(12, 160);
			this.Label2.Name = "Label2";
			this.Label2.Size = new System.Drawing.Size(33, 13);
			this.Label2.TabIndex = 7;
			this.Label2.Text = "Apply";
			this.ToolTip1.SetToolTip(this.Label2, "Time to download the one email");
			//
			//eTimeAvg
			//
			this.eTimeAvg.AutoSize = true;
			this.eTimeAvg.Location = new System.Drawing.Point(12, 136);
			this.eTimeAvg.Name = "eTimeAvg";
			this.eTimeAvg.Size = new System.Drawing.Size(55, 13);
			this.eTimeAvg.TabIndex = 8;
			this.eTimeAvg.Text = "eTimeAvg";
			this.ToolTip1.SetToolTip(this.eTimeAvg, "Average time to download the one email");
			//
			//txAvg
			//
			this.txAvg.AutoSize = true;
			this.txAvg.Location = new System.Drawing.Point(12, 186);
			this.txAvg.Name = "txAvg";
			this.txAvg.Size = new System.Drawing.Size(34, 13);
			this.txAvg.TabIndex = 9;
			this.txAvg.Text = "txAvg";
			this.ToolTip1.SetToolTip(this.txAvg, "Average time to process the one email");
			//
			//frmExchangeMonitor
			//
			this.AutoScaleDimensions = new System.Drawing.SizeF((float) (6.0F), (float) (13.0F));
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.ClientSize = new System.Drawing.Size(281, 105);
			this.Controls.Add(this.txAvg);
			this.Controls.Add(this.eTimeAvg);
			this.Controls.Add(this.Label2);
			this.Controls.Add(this.Label1);
			this.Controls.Add(this.txTime);
			this.Controls.Add(this.lblSpeed);
			this.Controls.Add(this.lblMsg);
			this.Controls.Add(this.lblCnt);
			this.Controls.Add(this.lblMessageInfo);
			this.Controls.Add(this.lblServer);
			this.Name = "frmExchangeMonitor";
			this.StartPosition = System.Windows.Forms.FormStartPosition.Manual;
			this.Text = "frmExchangeMonitor";
			this.TopMost = true;
			this.ResumeLayout(false);
			this.PerformLayout();
			
		}
		internal System.Windows.Forms.Label lblServer;
		internal System.Windows.Forms.Label lblMessageInfo;
		internal System.Windows.Forms.Label lblCnt;
		internal System.Windows.Forms.Label lblMsg;
		internal System.Windows.Forms.Label lblSpeed;
		internal System.Windows.Forms.Label txTime;
		internal System.Windows.Forms.ToolTip ToolTip1;
		internal System.Windows.Forms.Label Label1;
		internal System.Windows.Forms.Label Label2;
		internal System.Windows.Forms.Label eTimeAvg;
		internal System.Windows.Forms.Label txAvg;
	}
	
}
