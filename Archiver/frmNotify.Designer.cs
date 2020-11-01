using System;
using System.Diagnostics;
using System.Drawing;
using System.Windows.Forms;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{
    [DesignerGenerated()]
    public partial class frmNotify : Form
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
            var resources = new System.ComponentModel.ComponentResourceManager(typeof(frmNotify));
            Label1 = new Label();
            lblFileSpec = new Label();
            lblPdgPages = new Label();
            SuspendLayout();
            // 
            // Label1
            // 
            Label1.AutoSize = true;
            Label1.Location = new Point(12, 9);
            Label1.Name = "Label1";
            Label1.Size = new Size(59, 13);
            Label1.TabIndex = 0;
            Label1.Text = "CONTENT";
            // 
            // lblFileSpec
            // 
            lblFileSpec.AutoSize = true;
            lblFileSpec.Location = new Point(12, 58);
            lblFileSpec.Name = "lblFileSpec";
            lblFileSpec.Size = new Size(26, 13);
            lblFileSpec.TabIndex = 1;
            lblFileSpec.Text = "File:";
            // 
            // lblPdgPages
            // 
            lblPdgPages.AutoSize = true;
            lblPdgPages.Location = new Point(12, 33);
            lblPdgPages.Name = "lblPdgPages";
            lblPdgPages.Size = new Size(40, 13);
            lblPdgPages.TabIndex = 2;
            lblPdgPages.Text = "Pages:";
            // 
            // frmNotify
            // 
            AutoScaleDimensions = new SizeF(6.0f, 13.0f);
            AutoScaleMode = AutoScaleMode.Font;
            BackColor = Color.White;
            ClientSize = new Size(706, 80);
            Controls.Add(lblPdgPages);
            Controls.Add(lblFileSpec);
            Controls.Add(Label1);
            DoubleBuffered = true;
            Icon = (Icon)resources.GetObject("$this.Icon");
            MaximizeBox = false;
            Name = "frmNotify";
            Text = "Notice           (frmNotify)";
            Load += new EventHandler(frmNotify_Load);
            ResumeLayout(false);
            PerformLayout();
        }

        internal Label Label1;
        internal Label lblFileSpec;
        internal Label lblPdgPages;
    }
}