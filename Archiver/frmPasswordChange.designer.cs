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
    public partial class frmPasswordChange : Form
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
            txtPw1 = new TextBox();
            txtPw2 = new TextBox();
            _btnEnter = new Button();
            _btnEnter.Click += new EventHandler(btnEnter_Click);
            SB = new TextBox();
            SuspendLayout();
            // 
            // Label1
            // 
            Label1.AutoSize = true;
            Label1.Location = new Point(18, 19);
            Label1.Name = "Label1";
            Label1.Size = new Size(100, 17);
            Label1.TabIndex = 0;
            Label1.Text = "New Password";
            // 
            // Label2
            // 
            Label2.AutoSize = true;
            Label2.Location = new Point(18, 90);
            Label2.Name = "Label2";
            Label2.Size = new Size(118, 17);
            Label2.TabIndex = 1;
            Label2.Text = "Retype Password";
            // 
            // txtPw1
            // 
            txtPw1.Location = new Point(18, 44);
            txtPw1.Name = "txtPw1";
            txtPw1.PasswordChar = '*';
            txtPw1.Size = new Size(241, 22);
            txtPw1.TabIndex = 2;
            // 
            // txtPw2
            // 
            txtPw2.Location = new Point(18, 116);
            txtPw2.Name = "txtPw2";
            txtPw2.PasswordChar = '*';
            txtPw2.Size = new Size(241, 22);
            txtPw2.TabIndex = 3;
            // 
            // btnEnter
            // 
            _btnEnter.Location = new Point(79, 161);
            _btnEnter.Name = "_btnEnter";
            _btnEnter.Size = new Size(116, 41);
            _btnEnter.TabIndex = 4;
            _btnEnter.Text = "Accept";
            _btnEnter.UseVisualStyleBackColor = true;
            // 
            // SB
            // 
            SB.BackColor = Color.FromArgb(Conversions.ToInteger(Conversions.ToByte(255)), Conversions.ToInteger(Conversions.ToByte(255)), Conversions.ToInteger(Conversions.ToByte(192)));
            SB.Enabled = false;
            SB.Location = new Point(18, 221);
            SB.Name = "SB";
            SB.Size = new Size(241, 22);
            SB.TabIndex = 5;
            // 
            // frmPasswordChange
            // 
            AutoScaleDimensions = new SizeF(8.0f, 16.0f);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(282, 255);
            Controls.Add(SB);
            Controls.Add(_btnEnter);
            Controls.Add(txtPw2);
            Controls.Add(txtPw1);
            Controls.Add(Label2);
            Controls.Add(Label1);
            Name = "frmPasswordChange";
            Text = "Password Entry Form  (frmPasswordChange)";
            TopMost = true;
            ResumeLayout(false);
            PerformLayout();
        }

        internal Label Label1;
        internal Label Label2;
        internal TextBox txtPw1;
        internal TextBox txtPw2;
        private Button _btnEnter;

        internal Button btnEnter
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnEnter;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnEnter != null)
                {
                    _btnEnter.Click -= btnEnter_Click;
                }

                _btnEnter = value;
                if (_btnEnter != null)
                {
                    _btnEnter.Click += btnEnter_Click;
                }
            }
        }

        internal TextBox SB;
    }
}