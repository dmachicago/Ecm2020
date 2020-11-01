using System.Diagnostics;
using System.Drawing;
using System.Windows.Forms;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{
    [DesignerGenerated()]
    public partial class frmMessageBar : Form
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
            var resources = new System.ComponentModel.ComponentResourceManager(typeof(frmMessageBar));
            lblmsg = new Label();
            lblCnt = new Label();
            SuspendLayout();
            // 
            // lblmsg
            // 
            lblmsg.AutoSize = true;
            lblmsg.ForeColor = Color.White;
            lblmsg.Location = new Point(16, 11);
            lblmsg.Margin = new Padding(4, 0, 4, 0);
            lblmsg.Name = "lblmsg";
            lblmsg.Size = new Size(51, 17);
            lblmsg.TabIndex = 0;
            lblmsg.Text = "Label1";
            // 
            // lblCnt
            // 
            lblCnt.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            lblCnt.AutoSize = true;
            lblCnt.ForeColor = Color.White;
            lblCnt.Location = new Point(1147, 9);
            lblCnt.Margin = new Padding(4, 0, 4, 0);
            lblCnt.Name = "lblCnt";
            lblCnt.Size = new Size(51, 17);
            lblCnt.TabIndex = 1;
            lblCnt.Text = "Label1";
            // 
            // frmMessageBar
            // 
            AutoScaleDimensions = new SizeF(8.0f, 16.0f);
            AutoScaleMode = AutoScaleMode.Font;
            BackColor = Color.Maroon;
            ClientSize = new Size(1211, 36);
            Controls.Add(lblCnt);
            Controls.Add(lblmsg);
            Icon = (Icon)resources.GetObject("$this.Icon");
            Margin = new Padding(4, 4, 4, 4);
            Name = "frmMessageBar";
            Text = "Notice                  (frmMessageBar)";
            ResumeLayout(false);
            PerformLayout();
        }

        internal Label lblmsg;
        internal Label lblCnt;
    }
}