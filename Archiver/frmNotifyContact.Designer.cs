using System;
using System.Diagnostics;
using System.Drawing;
using System.Windows.Forms;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{
    [DesignerGenerated()]
    public partial class frmNotifyContact : Form
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
            var resources = new System.ComponentModel.ComponentResourceManager(typeof(frmNotifyContact));
            lblMsg = new Label();
            lblMsg2 = new Label();
            SuspendLayout();
            // 
            // lblMsg
            // 
            lblMsg.AutoSize = true;
            lblMsg.Location = new Point(12, 9);
            lblMsg.Name = "lblMsg";
            lblMsg.Size = new Size(59, 13);
            lblMsg.TabIndex = 0;
            lblMsg.Text = "CONTENT";
            // 
            // lblMsg2
            // 
            lblMsg2.AutoSize = true;
            lblMsg2.Location = new Point(12, 35);
            lblMsg2.Name = "lblMsg2";
            lblMsg2.Size = new Size(26, 13);
            lblMsg2.TabIndex = 1;
            lblMsg2.Text = "File:";
            // 
            // frmNotifyContact
            // 
            AutoScaleDimensions = new SizeF(6.0f, 13.0f);
            AutoScaleMode = AutoScaleMode.Font;
            BackColor = Color.White;
            ClientSize = new Size(357, 57);
            Controls.Add(lblMsg2);
            Controls.Add(lblMsg);
            DoubleBuffered = true;
            Icon = (Icon)resources.GetObject("$this.Icon");
            MaximizeBox = false;
            Name = "frmNotifyContact";
            Text = "Active           (frmNotifyContact)";
            Load += new EventHandler(frmNotifyContact_Load);
            ResumeLayout(false);
            PerformLayout();
        }

        internal Label lblMsg;
        internal Label lblMsg2;
    }
}