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
    public partial class frmOutOfSpace : Form
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
            Label2 = new Label();
            _btnStopExecution = new Button();
            _btnStopExecution.Click += new EventHandler(btnStopExecution_Click);
            SuspendLayout();
            // 
            // Label1
            // 
            Label1.AutoSize = true;
            Label1.BackColor = Color.Yellow;
            Label1.Font = new Font("Microsoft Sans Serif", 24.0f, FontStyle.Bold, GraphicsUnit.Point, Conversions.ToByte(0));
            Label1.Location = new Point(12, 21);
            Label1.Name = "Label1";
            Label1.Size = new Size(244, 37);
            Label1.TabIndex = 0;
            Label1.Text = "Out of SPACE!";
            // 
            // Label2
            // 
            Label2.AutoSize = true;
            Label2.Font = new Font("Arial Narrow", 36.0f, FontStyle.Bold, GraphicsUnit.Point, Conversions.ToByte(0));
            Label2.ForeColor = Color.Yellow;
            Label2.Location = new Point(17, 69);
            Label2.Name = "Label2";
            Label2.Size = new Size(239, 57);
            Label2.TabIndex = 1;
            Label2.Text = "Contact I.T.";
            // 
            // btnStopExecution
            // 
            _btnStopExecution.Location = new Point(37, 129);
            _btnStopExecution.Name = "_btnStopExecution";
            _btnStopExecution.Size = new Size(192, 31);
            _btnStopExecution.TabIndex = 2;
            _btnStopExecution.Text = "Close ECM Application";
            _btnStopExecution.UseVisualStyleBackColor = true;
            // 
            // frmOutOfSpace
            // 
            AutoScaleDimensions = new SizeF(6.0f, 13.0f);
            AutoScaleMode = AutoScaleMode.Font;
            BackColor = Color.Red;
            ClientSize = new Size(284, 171);
            Controls.Add(_btnStopExecution);
            Controls.Add(Label2);
            Controls.Add(Label1);
            Name = "frmOutOfSpace";
            Text = "frmOutOfSpace";
            TopMost = true;
            ResumeLayout(false);
            PerformLayout();
        }

        internal Label Label1;
        internal Label Label2;
        private Button _btnStopExecution;

        internal Button btnStopExecution
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnStopExecution;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnStopExecution != null)
                {
                    _btnStopExecution.Click -= btnStopExecution_Click;
                }

                _btnStopExecution = value;
                if (_btnStopExecution != null)
                {
                    _btnStopExecution.Click += btnStopExecution_Click;
                }
            }
        }
    }
}