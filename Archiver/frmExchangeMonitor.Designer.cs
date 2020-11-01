using System.Diagnostics;
using System.Drawing;
using System.Windows.Forms;
using MODI;

namespace EcmArchiver
{
    [Microsoft.VisualBasic.CompilerServices.DesignerGenerated()]
    public partial class frmExchangeMonitor : Form
    {

        // Form overrides dispose to clean up the component list.
        [DebuggerNonUserCode()]
        protected override void Dispose(bool disposing)
        {
            try
            {
                if (disposing && components is object)
                {
                    components.Dispose();
                }
            }
            finally
            {
                base.Dispose(disposing);
            }
        }

        // Required by the Windows Form Designer
        private System.ComponentModel.IContainer components;

        // NOTE: The following procedure is required by the Windows Form Designer
        // It can be modified using the Windows Form Designer.  
        // Do not modify it using the code editor.
        [DebuggerStepThrough()]
        private void InitializeComponent()
        {
            components = new System.ComponentModel.Container();
            lblServer = new Label();
            lblMessageInfo = new Label();
            lblCnt = new Label();
            lblMsg = new Label();
            lblSpeed = new Label();
            txTime = new Label();
            ToolTip1 = new ToolTip(components);
            Label1 = new Label();
            Label2 = new Label();
            eTimeAvg = new Label();
            txAvg = new Label();
            SuspendLayout();
            // 
            // lblServer
            // 
            lblServer.AutoSize = true;
            lblServer.Location = new Point(12, 9);
            lblServer.Name = "lblServer";
            lblServer.Size = new Size(48, 13);
            lblServer.TabIndex = 0;
            lblServer.Text = "lblServer";
            // 
            // lblMessageInfo
            // 
            lblMessageInfo.AutoSize = true;
            lblMessageInfo.Location = new Point(12, 33);
            lblMessageInfo.Name = "lblMessageInfo";
            lblMessageInfo.Size = new Size(78, 13);
            lblMessageInfo.TabIndex = 1;
            lblMessageInfo.Text = "lblMessageInfo";
            // 
            // lblCnt
            // 
            lblCnt.AutoSize = true;
            lblCnt.Location = new Point(12, 59);
            lblCnt.Name = "lblCnt";
            lblCnt.Size = new Size(22, 13);
            lblCnt.TabIndex = 2;
            lblCnt.Text = "cnt";
            // 
            // lblMsg
            // 
            lblMsg.AutoSize = true;
            lblMsg.Location = new Point(12, 84);
            lblMsg.Name = "lblMsg";
            lblMsg.Size = new Size(50, 13);
            lblMsg.TabIndex = 3;
            lblMsg.Text = "Message";
            // 
            // lblSpeed
            // 
            lblSpeed.AutoSize = true;
            lblSpeed.Location = new Point(12, 123);
            lblSpeed.Name = "lblSpeed";
            lblSpeed.Size = new Size(36, 13);
            lblSpeed.TabIndex = 4;
            lblSpeed.Text = "eTime";
            ToolTip1.SetToolTip(lblSpeed, "Time to download the one email");
            // 
            // txTime
            // 
            txTime.AutoSize = true;
            txTime.Location = new Point(12, 173);
            txTime.Name = "txTime";
            txTime.Size = new Size(38, 13);
            txTime.TabIndex = 5;
            txTime.Text = "txTime";
            ToolTip1.SetToolTip(txTime, "Time to process the one email");
            // 
            // Label1
            // 
            Label1.AutoSize = true;
            Label1.Location = new Point(12, 110);
            Label1.Name = "Label1";
            Label1.Size = new Size(34, 13);
            Label1.TabIndex = 6;
            Label1.Text = "Fetch";
            ToolTip1.SetToolTip(Label1, "Time to download the one email");
            // 
            // Label2
            // 
            Label2.AutoSize = true;
            Label2.Location = new Point(12, 160);
            Label2.Name = "Label2";
            Label2.Size = new Size(33, 13);
            Label2.TabIndex = 7;
            Label2.Text = "Apply";
            ToolTip1.SetToolTip(Label2, "Time to download the one email");
            // 
            // eTimeAvg
            // 
            eTimeAvg.AutoSize = true;
            eTimeAvg.Location = new Point(12, 136);
            eTimeAvg.Name = "eTimeAvg";
            eTimeAvg.Size = new Size(55, 13);
            eTimeAvg.TabIndex = 8;
            eTimeAvg.Text = "eTimeAvg";
            ToolTip1.SetToolTip(eTimeAvg, "Average time to download the one email");
            // 
            // txAvg
            // 
            txAvg.AutoSize = true;
            txAvg.Location = new Point(12, 186);
            txAvg.Name = "txAvg";
            txAvg.Size = new Size(34, 13);
            txAvg.TabIndex = 9;
            txAvg.Text = "txAvg";
            ToolTip1.SetToolTip(txAvg, "Average time to process the one email");
            // 
            // frmExchangeMonitor
            // 
            AutoScaleDimensions = new SizeF(6.0f, 13.0f);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(281, 105);
            Controls.Add(txAvg);
            Controls.Add(eTimeAvg);
            Controls.Add(Label2);
            Controls.Add(Label1);
            Controls.Add(txTime);
            Controls.Add(lblSpeed);
            Controls.Add(lblMsg);
            Controls.Add(lblCnt);
            Controls.Add(lblMessageInfo);
            Controls.Add(lblServer);
            Name = "frmExchangeMonitor";
            StartPosition = FormStartPosition.Manual;
            Text = "frmExchangeMonitor";
            TopMost = true;
            ResumeLayout(false);
            PerformLayout();
        }

        internal Label lblServer;
        internal Label lblMessageInfo;
        internal Label lblCnt;
        internal Label lblMsg;
        internal Label lblSpeed;
        internal Label txTime;
        internal ToolTip ToolTip1;
        internal Label Label1;
        internal Label Label2;
        internal Label eTimeAvg;
        internal Label txAvg;
    }
}