using System;
using System.Diagnostics;
using System.Drawing;
using System.Runtime.CompilerServices;
using System.Windows.Forms;
using MODI;

namespace EcmArchiver
{
    [Microsoft.VisualBasic.CompilerServices.DesignerGenerated()]
    public partial class frmHelp : Form
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
            rtbText = new RichTextBox();
            lblScreenName = new Label();
            lblObject = new Label();
            _Timer1 = new Timer(components);
            _Timer1.Tick += new EventHandler(Timer1_Tick);
            SuspendLayout();
            // 
            // rtbText
            // 
            rtbText.Location = new Point(12, 33);
            rtbText.Name = "rtbText";
            rtbText.Size = new Size(260, 219);
            rtbText.TabIndex = 0;
            rtbText.Text = "";
            // 
            // lblScreenName
            // 
            lblScreenName.AutoSize = true;
            lblScreenName.Location = new Point(12, 9);
            lblScreenName.Name = "lblScreenName";
            lblScreenName.Size = new Size(79, 13);
            lblScreenName.TabIndex = 1;
            lblScreenName.Text = "lblScreenName";
            // 
            // lblObject
            // 
            lblObject.AutoSize = true;
            lblObject.Location = new Point(169, 9);
            lblObject.Name = "lblObject";
            lblObject.Size = new Size(48, 13);
            lblObject.TabIndex = 2;
            lblObject.Text = "lblObject";
            // 
            // Timer1
            // 
            _Timer1.Enabled = true;
            _Timer1.Interval = 5000;
            // 
            // frmHelp
            // 
            AutoScaleDimensions = new SizeF(6.0f, 13.0f);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(284, 264);
            Controls.Add(lblObject);
            Controls.Add(lblScreenName);
            Controls.Add(rtbText);
            Name = "frmHelp";
            StartPosition = FormStartPosition.Manual;
            Text = "Help Screen";
            Load += new EventHandler(frmHelp_Load);
            ResumeLayout(false);
            PerformLayout();
        }

        internal RichTextBox rtbText;
        internal Label lblScreenName;
        internal Label lblObject;
        private Timer _Timer1;

        internal Timer Timer1
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _Timer1;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_Timer1 != null)
                {
                    _Timer1.Tick -= Timer1_Tick;
                }

                _Timer1 = value;
                if (_Timer1 != null)
                {
                    _Timer1.Tick += Timer1_Tick;
                }
            }
        }
    }
}