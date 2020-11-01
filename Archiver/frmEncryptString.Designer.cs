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
    public partial class frmEncryptString : Form
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
            txtUnencrypted = new TextBox();
            txtEncrypted = new TextBox();
            _btnEncrypt = new Button();
            _btnEncrypt.Click += new EventHandler(btnEncrypt_Click);
            _btnCopy = new Button();
            _btnCopy.Click += new EventHandler(btnCopy_Click);
            SuspendLayout();
            // 
            // txtUnencrypted
            // 
            txtUnencrypted.Anchor = AnchorStyles.Top | AnchorStyles.Left | AnchorStyles.Right;
            txtUnencrypted.Location = new Point(12, 26);
            txtUnencrypted.Multiline = true;
            txtUnencrypted.Name = "txtUnencrypted";
            txtUnencrypted.Size = new Size(403, 120);
            txtUnencrypted.TabIndex = 0;
            // 
            // txtEncrypted
            // 
            txtEncrypted.Anchor = AnchorStyles.Top | AnchorStyles.Left | AnchorStyles.Right;
            txtEncrypted.Location = new Point(12, 152);
            txtEncrypted.Multiline = true;
            txtEncrypted.Name = "txtEncrypted";
            txtEncrypted.Size = new Size(403, 120);
            txtEncrypted.TabIndex = 1;
            // 
            // btnEncrypt
            // 
            _btnEncrypt.Anchor = AnchorStyles.Top | AnchorStyles.Bottom | AnchorStyles.Right;
            _btnEncrypt.Location = new Point(430, 51);
            _btnEncrypt.Name = "_btnEncrypt";
            _btnEncrypt.Size = new Size(69, 59);
            _btnEncrypt.TabIndex = 2;
            _btnEncrypt.Text = "Encrypt";
            _btnEncrypt.UseVisualStyleBackColor = true;
            // 
            // btnCopy
            // 
            _btnCopy.Anchor = AnchorStyles.Top | AnchorStyles.Bottom | AnchorStyles.Right;
            _btnCopy.Location = new Point(430, 181);
            _btnCopy.Name = "_btnCopy";
            _btnCopy.Size = new Size(69, 59);
            _btnCopy.TabIndex = 3;
            _btnCopy.Text = "Copy to Clipboard";
            _btnCopy.UseVisualStyleBackColor = true;
            // 
            // frmEncryptString
            // 
            AutoScaleDimensions = new SizeF(6.0f, 13.0f);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(512, 273);
            Controls.Add(_btnCopy);
            Controls.Add(_btnEncrypt);
            Controls.Add(txtEncrypted);
            Controls.Add(txtUnencrypted);
            Name = "frmEncryptString";
            Text = "Encrypt Phrase       (frmEncryptString)";
            ResumeLayout(false);
            PerformLayout();
        }

        internal TextBox txtUnencrypted;
        internal TextBox txtEncrypted;
        private Button _btnEncrypt;

        internal Button btnEncrypt
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnEncrypt;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnEncrypt != null)
                {
                    _btnEncrypt.Click -= btnEncrypt_Click;
                }

                _btnEncrypt = value;
                if (_btnEncrypt != null)
                {
                    _btnEncrypt.Click += btnEncrypt_Click;
                }
            }
        }

        private Button _btnCopy;

        internal Button btnCopy
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnCopy;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnCopy != null)
                {
                    _btnCopy.Click -= btnCopy_Click;
                }

                _btnCopy = value;
                if (_btnCopy != null)
                {
                    _btnCopy.Click += btnCopy_Click;
                }
            }
        }
    }
}