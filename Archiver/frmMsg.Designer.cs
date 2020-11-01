using System;
using System.Diagnostics;
using System.Drawing;
using System.Windows.Forms;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{
    [DesignerGenerated()]
    public partial class frmMsg : Form
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
            txtMsg = new TextBox();
            SuspendLayout();
            // 
            // txtMsg
            // 
            txtMsg.Location = new Point(12, 12);
            txtMsg.Name = "txtMsg";
            txtMsg.Size = new Size(536, 20);
            txtMsg.TabIndex = 0;
            // 
            // frmMsg
            // 
            AutoScaleDimensions = new SizeF(6.0f, 13.0f);
            AutoScaleMode = AutoScaleMode.Font;
            BackColor = Color.FromArgb(Conversions.ToInteger(Conversions.ToByte(64)), Conversions.ToInteger(Conversions.ToByte(64)), Conversions.ToInteger(Conversions.ToByte(64)));
            ClientSize = new Size(560, 44);
            Controls.Add(txtMsg);
            Name = "frmMsg";
            StartPosition = FormStartPosition.Manual;
            Text = "Information";
            Load += new EventHandler(frmMsg_Load);
            ResumeLayout(false);
            PerformLayout();
        }

        internal TextBox txtMsg;
    }
}