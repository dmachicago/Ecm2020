using System;
using System.Diagnostics;
using System.Drawing;
using System.Windows.Forms;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{
    [DesignerGenerated()]
    public partial class frmNotify2 : Form
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
            lblEmailMsg = new Label();
            lblMsg2 = new Label();
            lblFolder = new Label();
            SuspendLayout();
            // 
            // lblEmailMsg
            // 
            lblEmailMsg.AutoSize = true;
            lblEmailMsg.Location = new Point(12, 9);
            lblEmailMsg.Name = "lblEmailMsg";
            lblEmailMsg.Size = new Size(30, 13);
            lblEmailMsg.TabIndex = 1;
            lblEmailMsg.Text = "Msg:";
            // 
            // lblMsg2
            // 
            lblMsg2.AutoSize = true;
            lblMsg2.Location = new Point(12, 30);
            lblMsg2.Name = "lblMsg2";
            lblMsg2.Size = new Size(30, 13);
            lblMsg2.TabIndex = 2;
            lblMsg2.Text = "Msg:";
            // 
            // lblFolder
            // 
            lblFolder.AutoSize = true;
            lblFolder.Location = new Point(12, 49);
            lblFolder.Name = "lblFolder";
            lblFolder.Size = new Size(30, 13);
            lblFolder.TabIndex = 3;
            lblFolder.Text = "Msg:";
            // 
            // frmNotify2
            // 
            AutoScaleDimensions = new SizeF(6.0f, 13.0f);
            AutoScaleMode = AutoScaleMode.Font;
            BackColor = Color.FromArgb(Conversions.ToInteger(Conversions.ToByte(224)), Conversions.ToInteger(Conversions.ToByte(224)), Conversions.ToInteger(Conversions.ToByte(224)));
            ClientSize = new Size(294, 71);
            Controls.Add(lblFolder);
            Controls.Add(lblMsg2);
            Controls.Add(lblEmailMsg);
            DoubleBuffered = true;
            ForeColor = Color.Black;
            MaximizeBox = false;
            Name = "frmNotify2";
            Text = "Progress Tracking     (frmNotify2)";
            Load += new EventHandler(frmNotify2_Load);
            ResumeLayout(false);
            PerformLayout();
        }

        internal Label lblEmailMsg;
        internal Label lblMsg2;
        internal Label lblFolder;
    }
}