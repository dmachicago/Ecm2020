using System.Diagnostics;
using System.Drawing;
using System.Windows.Forms;
using MODI;

namespace EcmArchiver
{
    [Microsoft.VisualBasic.CompilerServices.DesignerGenerated()]
    public partial class frmNotifyBatchOCR : Form
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
            lblMsg = new Label();
            SuspendLayout();
            // 
            // lblMsg
            // 
            lblMsg.AutoSize = true;
            lblMsg.Location = new Point(12, 9);
            lblMsg.Name = "lblMsg";
            lblMsg.Size = new Size(39, 13);
            lblMsg.TabIndex = 0;
            lblMsg.Text = "Label1";
            // 
            // frmNotifyBatchOCR
            // 
            AutoScaleDimensions = new SizeF(6.0f, 13.0f);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(240, 46);
            Controls.Add(lblMsg);
            Name = "frmNotifyBatchOCR";
            Text = "frmNotifyBatchOCR";
            ResumeLayout(false);
            PerformLayout();
        }

        internal Label lblMsg;
    }
}