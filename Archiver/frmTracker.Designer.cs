using System.Diagnostics;
using System.Drawing;
using System.Windows.Forms;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{
    [DesignerGenerated()]
    public partial class frmTracker : Form
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
            Label1 = new Label();
            PB = new ProgressBar();
            Label2 = new Label();
            Label3 = new Label();
            Label4 = new Label();
            SuspendLayout();
            // 
            // Label1
            // 
            Label1.AutoSize = true;
            Label1.Location = new Point(12, 20);
            Label1.Name = "Label1";
            Label1.Size = new Size(51, 17);
            Label1.TabIndex = 0;
            Label1.Text = "Label1";
            // 
            // PB
            // 
            PB.Anchor = AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;
            PB.Location = new Point(13, 157);
            PB.Name = "PB";
            PB.Size = new Size(525, 23);
            PB.TabIndex = 1;
            // 
            // Label2
            // 
            Label2.AutoSize = true;
            Label2.Location = new Point(12, 55);
            Label2.Name = "Label2";
            Label2.Size = new Size(51, 17);
            Label2.TabIndex = 2;
            Label2.Text = "Label2";
            // 
            // Label3
            // 
            Label3.AutoSize = true;
            Label3.Location = new Point(12, 92);
            Label3.Name = "Label3";
            Label3.Size = new Size(51, 17);
            Label3.TabIndex = 3;
            Label3.Text = "Label3";
            // 
            // Label4
            // 
            Label4.AutoSize = true;
            Label4.Location = new Point(12, 126);
            Label4.Name = "Label4";
            Label4.Size = new Size(51, 17);
            Label4.TabIndex = 4;
            Label4.Text = "Label4";
            // 
            // frmTracker
            // 
            AutoScaleDimensions = new SizeF(8.0f, 16.0f);
            AutoScaleMode = AutoScaleMode.Font;
            AutoSizeMode = AutoSizeMode.GrowAndShrink;
            ClientSize = new Size(550, 192);
            Controls.Add(Label4);
            Controls.Add(Label3);
            Controls.Add(Label2);
            Controls.Add(PB);
            Controls.Add(Label1);
            Name = "frmTracker";
            Text = "frmTracker";
            ResumeLayout(false);
            PerformLayout();
        }

        internal Label Label1;
        internal ProgressBar PB;
        internal Label Label2;
        internal Label Label3;
        internal Label Label4;
    }
}