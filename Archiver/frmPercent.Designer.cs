using System.Diagnostics;
using System.Drawing;
using System.Windows.Forms;
using MODI;

namespace EcmArchiver
{
    [Microsoft.VisualBasic.CompilerServices.DesignerGenerated()]
    public partial class frmPercent : Form
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
            PB = new ProgressBar();
            Label1 = new Label();
            SuspendLayout();
            // 
            // PB
            // 
            PB.Location = new Point(3, 2);
            PB.Name = "PB";
            PB.Size = new Size(704, 19);
            PB.TabIndex = 0;
            // 
            // Label1
            // 
            Label1.AutoSize = true;
            Label1.Location = new Point(717, 3);
            Label1.Name = "Label1";
            Label1.Size = new Size(102, 13);
            Label1.TabIndex = 1;
            Label1.Text = "Loading File of Size:";
            // 
            // frmPercent
            // 
            AutoScaleDimensions = new SizeF(6.0f, 13.0f);
            AutoScaleMode = AutoScaleMode.Font;
            BackgroundImageLayout = ImageLayout.None;
            ClientSize = new Size(961, 20);
            Controls.Add(Label1);
            Controls.Add(PB);
            FormBorderStyle = FormBorderStyle.None;
            MaximizeBox = false;
            MinimizeBox = false;
            Name = "frmPercent";
            Text = "frmPercent";
            ResumeLayout(false);
            PerformLayout();
        }

        internal ProgressBar PB;
        internal Label Label1;
    }
}