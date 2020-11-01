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
    public partial class frmAttachmentCode : Form
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
            _dgAttachmentCode = new DataGridView();
            _dgAttachmentCode.CellContentClick += new DataGridViewCellEventHandler(dgAttachmentCode_CellContentClick);
            _btnUpdate = new Button();
            _btnUpdate.Click += new EventHandler(btnUpdate_Click);
            TT = new ToolTip(components);
            _btnApplyRetentionRule = new Button();
            _btnApplyRetentionRule.Click += new EventHandler(btnApplyRetentionRule_Click);
            _Timer1 = new Timer(components);
            _Timer1.Tick += new EventHandler(Timer1_Tick);
            HelpProvider1 = new HelpProvider();
            _btnEncrypt = new Button();
            _btnEncrypt.Click += new EventHandler(btnEncrypt_Click);
            Label1 = new Label();
            cbRetention = new ComboBox();
            ((System.ComponentModel.ISupportInitialize)_dgAttachmentCode).BeginInit();
            SuspendLayout();
            // 
            // dgAttachmentCode
            // 
            _dgAttachmentCode.AllowUserToOrderColumns = true;
            _dgAttachmentCode.Anchor = AnchorStyles.Top | AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;

            _dgAttachmentCode.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            _dgAttachmentCode.Location = new Point(12, 12);
            _dgAttachmentCode.Name = "_dgAttachmentCode";
            _dgAttachmentCode.Size = new Size(463, 331);
            _dgAttachmentCode.TabIndex = 0;
            // 
            // btnUpdate
            // 
            _btnUpdate.Anchor = AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;
            _btnUpdate.Location = new Point(327, 354);
            _btnUpdate.Name = "_btnUpdate";
            _btnUpdate.Size = new Size(147, 32);
            _btnUpdate.TabIndex = 1;
            _btnUpdate.Text = "&Update";
            _btnUpdate.UseVisualStyleBackColor = true;
            // 
            // btnApplyRetentionRule
            // 
            _btnApplyRetentionRule.Anchor = AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;
            _btnApplyRetentionRule.Location = new Point(444, 395);
            _btnApplyRetentionRule.Name = "_btnApplyRetentionRule";
            _btnApplyRetentionRule.Size = new Size(29, 21);
            _btnApplyRetentionRule.TabIndex = 5;
            _btnApplyRetentionRule.Text = "@";
            TT.SetToolTip(_btnApplyRetentionRule, "Press to apply selected retention rule to selected item.");
            _btnApplyRetentionRule.UseVisualStyleBackColor = true;
            // 
            // Timer1
            // 
            _Timer1.Enabled = true;
            // 
            // HelpProvider1
            // 
            HelpProvider1.HelpNamespace = "http://www.ecmlibrary.com/_helpfiles/frmAttachmentCodes.htm";
            // 
            // btnEncrypt
            // 
            _btnEncrypt.Anchor = AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;
            _btnEncrypt.Location = new Point(12, 354);
            _btnEncrypt.Name = "_btnEncrypt";
            _btnEncrypt.Size = new Size(147, 32);
            _btnEncrypt.TabIndex = 2;
            _btnEncrypt.Text = "Encrypt Password";
            _btnEncrypt.UseVisualStyleBackColor = true;
            // 
            // Label1
            // 
            Label1.Anchor = AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;
            Label1.AutoSize = true;
            Label1.Location = new Point(12, 399);
            Label1.Name = "Label1";
            Label1.Size = new Size(158, 13);
            Label1.TabIndex = 3;
            Label1.Text = "Please Select a Retention Rule:";
            // 
            // cbRetention
            // 
            cbRetention.Anchor = AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;
            cbRetention.FormattingEnabled = true;
            cbRetention.Location = new Point(191, 396);
            cbRetention.Name = "cbRetention";
            cbRetention.Size = new Size(245, 21);
            cbRetention.TabIndex = 4;
            // 
            // frmAttachmentCode
            // 
            AutoScaleDimensions = new SizeF(6.0f, 13.0f);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(490, 421);
            Controls.Add(_btnApplyRetentionRule);
            Controls.Add(cbRetention);
            Controls.Add(Label1);
            Controls.Add(_btnEncrypt);
            Controls.Add(_btnUpdate);
            Controls.Add(_dgAttachmentCode);
            HelpProvider1.SetHelpString(this, "http://www.ecmlibrary.com/_helpfiles/frmAttachmentCodes.htm");
            Name = "frmAttachmentCode";
            HelpProvider1.SetShowHelp(this, true);
            Text = "Attachment Codes";
            ((System.ComponentModel.ISupportInitialize)_dgAttachmentCode).EndInit();
            Deactivate += new EventHandler(frmAttachmentCode_Deactivate);
            Disposed += new EventHandler(frmAttachmentCode_Disposed);
            Load += new EventHandler(frmAttachmentCode_Load);
            Resize += new EventHandler(frmAttachmentCode_Resize);
            ResumeLayout(false);
            PerformLayout();
        }

        private DataGridView _dgAttachmentCode;

        internal DataGridView dgAttachmentCode
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _dgAttachmentCode;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_dgAttachmentCode != null)
                {
                    _dgAttachmentCode.CellContentClick -= dgAttachmentCode_CellContentClick;
                }

                _dgAttachmentCode = value;
                if (_dgAttachmentCode != null)
                {
                    _dgAttachmentCode.CellContentClick += dgAttachmentCode_CellContentClick;
                }
            }
        }

        private Button _btnUpdate;

        internal Button btnUpdate
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnUpdate;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnUpdate != null)
                {
                    _btnUpdate.Click -= btnUpdate_Click;
                }

                _btnUpdate = value;
                if (_btnUpdate != null)
                {
                    _btnUpdate.Click += btnUpdate_Click;
                }
            }
        }

        internal ToolTip TT;
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

        internal HelpProvider HelpProvider1;
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

        internal Label Label1;
        internal ComboBox cbRetention;
        private Button _btnApplyRetentionRule;

        internal Button btnApplyRetentionRule
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnApplyRetentionRule;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnApplyRetentionRule != null)
                {
                    _btnApplyRetentionRule.Click -= btnApplyRetentionRule_Click;
                }

                _btnApplyRetentionRule = value;
                if (_btnApplyRetentionRule != null)
                {
                    _btnApplyRetentionRule.Click += btnApplyRetentionRule_Click;
                }
            }
        }
    }
}