using System;
using System.Diagnostics;
using System.Drawing;
using System.Runtime.CompilerServices;
using System.Windows.Forms;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{
    [DesignerGenerated()]
    public partial class frmNotifyMessage : Form
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
            txtMsg = new TextBox();
            _T1 = new Timer(components);
            _T1.Tick += new EventHandler(T1_Tick);
            Label1 = new Label();
            SuspendLayout();
            // 
            // txtMsg
            // 
            txtMsg.BackColor = Color.FromArgb(Conversions.ToInteger(Conversions.ToByte(255)), Conversions.ToInteger(Conversions.ToByte(255)), Conversions.ToInteger(Conversions.ToByte(192)));
            txtMsg.Location = new Point(16, 15);
            txtMsg.Margin = new Padding(4, 4, 4, 4);
            txtMsg.Multiline = true;
            txtMsg.Name = "txtMsg";
            txtMsg.Size = new Size(345, 169);
            txtMsg.TabIndex = 0;
            // 
            // T1
            // 
            _T1.Enabled = true;
            _T1.Interval = 1000;
            // 
            // Label1
            // 
            Label1.AutoSize = true;
            Label1.Location = new Point(24, 194);
            Label1.Margin = new Padding(4, 0, 4, 0);
            Label1.Name = "Label1";
            Label1.Size = new Size(270, 17);
            Label1.TabIndex = 1;
            Label1.Text = "This message will go away in 30 seconds.";
            // 
            // frmNotifyMessage
            // 
            AutoScaleDimensions = new SizeF(8.0f, 16.0f);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(379, 233);
            Controls.Add(Label1);
            Controls.Add(txtMsg);
            Margin = new Padding(4, 4, 4, 4);
            Name = "frmNotifyMessage";
            Text = "frmNotifyMessage";
            ResumeLayout(false);
            PerformLayout();
        }

        internal TextBox txtMsg;
        private Timer _T1;

        internal Timer T1
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _T1;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_T1 != null)
                {
                    _T1.Tick -= T1_Tick;
                }

                _T1 = value;
                if (_T1 != null)
                {
                    _T1.Tick += T1_Tick;
                }
            }
        }

        internal Label Label1;
    }
}