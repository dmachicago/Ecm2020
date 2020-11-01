using System;
using System.Diagnostics;
using System.Drawing;
using System.Runtime.CompilerServices;
using System.Windows.Forms;
using MODI;

namespace EcmArchiver
{
    [Microsoft.VisualBasic.CompilerServices.DesignerGenerated()]
    public partial class frmImpersonate : Form
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
            txtUserID = new TextBox();
            Label1 = new Label();
            Label2 = new Label();
            txtPw1 = new TextBox();
            Label3 = new Label();
            txtPw2 = new TextBox();
            Label4 = new Label();
            _btnAssign = new Button();
            _btnAssign.Click += new EventHandler(btnAssign_Click);
            _btnCancel = new Button();
            _btnCancel.Click += new EventHandler(btnCancel_Click);
            _btnRemoveAssignment = new Button();
            _btnRemoveAssignment.Click += new EventHandler(btnRemoveAssignment_Click);
            SuspendLayout();
            // 
            // txtUserID
            // 
            txtUserID.Location = new Point(3, 35);
            txtUserID.Name = "txtUserID";
            txtUserID.Size = new Size(269, 20);
            txtUserID.TabIndex = 0;
            // 
            // Label1
            // 
            Label1.AutoSize = true;
            Label1.Location = new Point(3, 19);
            Label1.Name = "Label1";
            Label1.Size = new Size(51, 13);
            Label1.TabIndex = 99;
            Label1.Text = "Login As:";
            // 
            // Label2
            // 
            Label2.AutoSize = true;
            Label2.Location = new Point(3, 68);
            Label2.Name = "Label2";
            Label2.Size = new Size(56, 13);
            Label2.TabIndex = 99;
            Label2.Text = "Password:";
            // 
            // txtPw1
            // 
            txtPw1.Location = new Point(3, 84);
            txtPw1.Name = "txtPw1";
            txtPw1.PasswordChar = '*';
            txtPw1.Size = new Size(226, 20);
            txtPw1.TabIndex = 1;
            // 
            // Label3
            // 
            Label3.AutoSize = true;
            Label3.Location = new Point(3, 113);
            Label3.Name = "Label3";
            Label3.Size = new Size(97, 13);
            Label3.TabIndex = 99;
            Label3.Text = "Re-enter Password";
            // 
            // txtPw2
            // 
            txtPw2.Location = new Point(3, 129);
            txtPw2.Name = "txtPw2";
            txtPw2.PasswordChar = '*';
            txtPw2.Size = new Size(226, 20);
            txtPw2.TabIndex = 2;
            // 
            // Label4
            // 
            Label4.AutoSize = true;
            Label4.Location = new Point(3, 163);
            Label4.Name = "Label4";
            Label4.Size = new Size(210, 13);
            Label4.TabIndex = 99;
            Label4.Text = "Note: This login is set only for this machine.";
            // 
            // btnAssign
            // 
            _btnAssign.Location = new Point(292, 33);
            _btnAssign.Name = "_btnAssign";
            _btnAssign.Size = new Size(109, 25);
            _btnAssign.TabIndex = 4;
            _btnAssign.Text = "Assign";
            _btnAssign.UseVisualStyleBackColor = true;
            // 
            // btnCancel
            // 
            _btnCancel.Location = new Point(292, 127);
            _btnCancel.Name = "_btnCancel";
            _btnCancel.Size = new Size(109, 25);
            _btnCancel.TabIndex = 3;
            _btnCancel.Text = "Cancel";
            _btnCancel.UseVisualStyleBackColor = true;
            // 
            // btnRemoveAssignment
            // 
            _btnRemoveAssignment.Location = new Point(292, 82);
            _btnRemoveAssignment.Name = "_btnRemoveAssignment";
            _btnRemoveAssignment.Size = new Size(109, 25);
            _btnRemoveAssignment.TabIndex = 100;
            _btnRemoveAssignment.Text = "Remove";
            _btnRemoveAssignment.UseVisualStyleBackColor = true;
            // 
            // frmImpersonate
            // 
            AutoScaleDimensions = new SizeF(6.0f, 13.0f);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(413, 188);
            Controls.Add(_btnRemoveAssignment);
            Controls.Add(_btnCancel);
            Controls.Add(_btnAssign);
            Controls.Add(Label4);
            Controls.Add(Label3);
            Controls.Add(txtPw2);
            Controls.Add(Label2);
            Controls.Add(txtPw1);
            Controls.Add(Label1);
            Controls.Add(txtUserID);
            Name = "frmImpersonate";
            Text = "Auto-Launch Login   (frmImpersonate)";
            ResumeLayout(false);
            PerformLayout();
        }

        internal TextBox txtUserID;
        internal Label Label1;
        internal Label Label2;
        internal TextBox txtPw1;
        internal Label Label3;
        internal TextBox txtPw2;
        internal Label Label4;
        private Button _btnAssign;

        internal Button btnAssign
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnAssign;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnAssign != null)
                {
                    _btnAssign.Click -= btnAssign_Click;
                }

                _btnAssign = value;
                if (_btnAssign != null)
                {
                    _btnAssign.Click += btnAssign_Click;
                }
            }
        }

        private Button _btnCancel;

        internal Button btnCancel
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnCancel;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnCancel != null)
                {
                    _btnCancel.Click -= btnCancel_Click;
                }

                _btnCancel = value;
                if (_btnCancel != null)
                {
                    _btnCancel.Click += btnCancel_Click;
                }
            }
        }

        private Button _btnRemoveAssignment;

        internal Button btnRemoveAssignment
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnRemoveAssignment;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnRemoveAssignment != null)
                {
                    _btnRemoveAssignment.Click -= btnRemoveAssignment_Click;
                }

                _btnRemoveAssignment = value;
                if (_btnRemoveAssignment != null)
                {
                    _btnRemoveAssignment.Click += btnRemoveAssignment_Click;
                }
            }
        }
    }
}