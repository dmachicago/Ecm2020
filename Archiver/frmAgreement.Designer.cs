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
    public partial class frmAgreement : Form
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
            var resources = new System.ComponentModel.ComponentResourceManager(typeof(frmAgreement));
            txtAgreement = new TextBox();
            _ckAgree = new CheckBox();
            _ckAgree.CheckedChanged += new EventHandler(ckAgree_CheckedChanged);
            _ckDisagree = new CheckBox();
            _ckDisagree.CheckedChanged += new EventHandler(ckDisagree_CheckedChanged);
            _btnProcess = new Button();
            _btnProcess.Click += new EventHandler(btnProcess_Click);
            SuspendLayout();
            // 
            // txtAgreement
            // 
            txtAgreement.Anchor = AnchorStyles.Top | AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;

            txtAgreement.Location = new Point(12, 12);
            txtAgreement.Multiline = true;
            txtAgreement.Name = "txtAgreement";
            txtAgreement.ReadOnly = true;
            txtAgreement.ScrollBars = ScrollBars.Both;
            txtAgreement.Size = new Size(465, 155);
            txtAgreement.TabIndex = 10;
            // 
            // ckAgree
            // 
            _ckAgree.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            _ckAgree.AutoSize = true;
            _ckAgree.Location = new Point(277, 194);
            _ckAgree.Name = "_ckAgree";
            _ckAgree.Size = new Size(54, 17);
            _ckAgree.TabIndex = 2;
            _ckAgree.Text = "Agree";
            _ckAgree.UseVisualStyleBackColor = true;
            // 
            // ckDisagree
            // 
            _ckDisagree.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            _ckDisagree.AutoSize = true;
            _ckDisagree.Location = new Point(277, 237);
            _ckDisagree.Name = "_ckDisagree";
            _ckDisagree.Size = new Size(68, 17);
            _ckDisagree.TabIndex = 1;
            _ckDisagree.Text = "Disagree";
            _ckDisagree.UseVisualStyleBackColor = true;
            // 
            // btnProcess
            // 
            _btnProcess.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            _btnProcess.Location = new Point(376, 194);
            _btnProcess.Name = "_btnProcess";
            _btnProcess.Size = new Size(101, 60);
            _btnProcess.TabIndex = 0;
            _btnProcess.Text = "Proceed";
            _btnProcess.UseVisualStyleBackColor = true;
            // 
            // frmAgreement
            // 
            AutoScaleDimensions = new SizeF(6.0f, 13.0f);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(489, 267);
            Controls.Add(_btnProcess);
            Controls.Add(_ckDisagree);
            Controls.Add(_ckAgree);
            Controls.Add(txtAgreement);
            Icon = (Icon)resources.GetObject("$this.Icon");
            Name = "frmAgreement";
            Text = "Legal Agreement";
            Load += new EventHandler(frmAgreement_Load);
            ResumeLayout(false);
            PerformLayout();
        }

        internal TextBox txtAgreement;
        private CheckBox _ckAgree;

        internal CheckBox ckAgree
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ckAgree;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ckAgree != null)
                {
                    _ckAgree.CheckedChanged -= ckAgree_CheckedChanged;
                }

                _ckAgree = value;
                if (_ckAgree != null)
                {
                    _ckAgree.CheckedChanged += ckAgree_CheckedChanged;
                }
            }
        }

        private CheckBox _ckDisagree;

        internal CheckBox ckDisagree
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _ckDisagree;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_ckDisagree != null)
                {
                    _ckDisagree.CheckedChanged -= ckDisagree_CheckedChanged;
                }

                _ckDisagree = value;
                if (_ckDisagree != null)
                {
                    _ckDisagree.CheckedChanged += ckDisagree_CheckedChanged;
                }
            }
        }

        private Button _btnProcess;

        internal Button btnProcess
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnProcess;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnProcess != null)
                {
                    _btnProcess.Click -= btnProcess_Click;
                }

                _btnProcess = value;
                if (_btnProcess != null)
                {
                    _btnProcess.Click += btnProcess_Click;
                }
            }
        }
    }
}