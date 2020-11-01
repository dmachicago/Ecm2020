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
    public partial class frmPstLoader : Form
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
            OpenFileDialog1 = new OpenFileDialog();
            _txtPstFqn = new TextBox();
            _txtPstFqn.TextChanged += new EventHandler(txtPstFqn_TextChanged);
            Label1 = new Label();
            _btnSelectFile = new Button();
            _btnSelectFile.Click += new EventHandler(btnSelectFile_Click);
            _btnLoad = new Button();
            _btnLoad.Click += new EventHandler(btnLoad_Click);
            lbMsg = new ListBox();
            _btnArchive = new Button();
            _btnArchive.Click += new EventHandler(btnArchive_Click);
            SB = new TextBox();
            Label2 = new Label();
            Label3 = new Label();
            txtFoldersProcessed = new TextBox();
            txtEmailsProcessed = new TextBox();
            TT = new ToolTip(components);
            Label4 = new Label();
            cbRetention = new ComboBox();
            cbLibrary = new ComboBox();
            Label5 = new Label();
            _btnRemove = new Button();
            _btnRemove.Click += new EventHandler(btnRemove_Click);
            SuspendLayout();
            // 
            // OpenFileDialog1
            // 
            OpenFileDialog1.FileName = "OpenFileDialog1";
            // 
            // txtPstFqn
            // 
            _txtPstFqn.Anchor = AnchorStyles.Top | AnchorStyles.Left | AnchorStyles.Right;
            _txtPstFqn.Location = new Point(11, 28);
            _txtPstFqn.Margin = new Padding(2);
            _txtPstFqn.Name = "_txtPstFqn";
            _txtPstFqn.Size = new Size(439, 20);
            _txtPstFqn.TabIndex = 0;
            // 
            // Label1
            // 
            Label1.AutoSize = true;
            Label1.Location = new Point(9, 9);
            Label1.Margin = new Padding(2, 0, 2, 0);
            Label1.Name = "Label1";
            Label1.Size = new Size(92, 13);
            Label1.TabIndex = 1;
            Label1.Text = "Selected PST File";
            // 
            // btnSelectFile
            // 
            _btnSelectFile.Anchor = AnchorStyles.Right;
            _btnSelectFile.Location = new Point(460, 28);
            _btnSelectFile.Margin = new Padding(2);
            _btnSelectFile.Name = "_btnSelectFile";
            _btnSelectFile.Size = new Size(79, 51);
            _btnSelectFile.TabIndex = 2;
            _btnSelectFile.Text = "&Select PST File";
            TT.SetToolTip(_btnSelectFile, "Microsoft supports only local access to .pst files, not network access, and warns" + " that excessive network traffic and data corruption can result if you try to acc" + "ess .pst files over the network.");

            _btnSelectFile.UseVisualStyleBackColor = true;
            // 
            // btnLoad
            // 
            _btnLoad.Anchor = AnchorStyles.Right;
            _btnLoad.Location = new Point(461, 93);
            _btnLoad.Margin = new Padding(2);
            _btnLoad.Name = "_btnLoad";
            _btnLoad.Size = new Size(79, 51);
            _btnLoad.TabIndex = 3;
            _btnLoad.Text = "&Load File";
            TT.SetToolTip(_btnLoad, "Microsoft supports only local access to .pst files, not network access, and warns" + " that excessive network traffic and data corruption can result if you try to acc" + "ess .pst files over the network.");

            _btnLoad.UseVisualStyleBackColor = true;
            // 
            // lbMsg
            // 
            lbMsg.Anchor = AnchorStyles.Top | AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;

            lbMsg.FormattingEnabled = true;
            lbMsg.Location = new Point(11, 50);
            lbMsg.Margin = new Padding(2);
            lbMsg.Name = "lbMsg";
            lbMsg.SelectionMode = SelectionMode.MultiExtended;
            lbMsg.Size = new Size(439, 290);
            lbMsg.TabIndex = 4;
            // 
            // btnArchive
            // 
            _btnArchive.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            _btnArchive.Location = new Point(461, 289);
            _btnArchive.Margin = new Padding(2);
            _btnArchive.Name = "_btnArchive";
            _btnArchive.Size = new Size(79, 51);
            _btnArchive.TabIndex = 5;
            _btnArchive.Text = "&Archive Selected Folders";
            _btnArchive.UseVisualStyleBackColor = true;
            // 
            // SB
            // 
            SB.Anchor = AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;
            SB.BackColor = Color.FromArgb(Conversions.ToInteger(Conversions.ToByte(255)), Conversions.ToInteger(Conversions.ToByte(255)), Conversions.ToInteger(Conversions.ToByte(192)));
            SB.Location = new Point(12, 407);
            SB.Margin = new Padding(2);
            SB.Name = "SB";
            SB.Size = new Size(439, 20);
            SB.TabIndex = 6;
            // 
            // Label2
            // 
            Label2.Anchor = AnchorStyles.Right;
            Label2.AutoSize = true;
            Label2.Location = new Point(461, 172);
            Label2.Margin = new Padding(2, 0, 2, 0);
            Label2.Name = "Label2";
            Label2.Size = new Size(41, 13);
            Label2.TabIndex = 7;
            Label2.Text = "Folders";
            // 
            // Label3
            // 
            Label3.Anchor = AnchorStyles.Right;
            Label3.AutoSize = true;
            Label3.Location = new Point(461, 223);
            Label3.Margin = new Padding(2, 0, 2, 0);
            Label3.Name = "Label3";
            Label3.Size = new Size(37, 13);
            Label3.TabIndex = 8;
            Label3.Text = "Emails";
            // 
            // txtFoldersProcessed
            // 
            txtFoldersProcessed.Anchor = AnchorStyles.Right;
            txtFoldersProcessed.Location = new Point(461, 191);
            txtFoldersProcessed.Margin = new Padding(2);
            txtFoldersProcessed.Name = "txtFoldersProcessed";
            txtFoldersProcessed.Size = new Size(75, 20);
            txtFoldersProcessed.TabIndex = 9;
            // 
            // txtEmailsProcessed
            // 
            txtEmailsProcessed.Anchor = AnchorStyles.Right;
            txtEmailsProcessed.Location = new Point(461, 240);
            txtEmailsProcessed.Margin = new Padding(2);
            txtEmailsProcessed.Name = "txtEmailsProcessed";
            txtEmailsProcessed.Size = new Size(75, 20);
            txtEmailsProcessed.TabIndex = 10;
            // 
            // Label4
            // 
            Label4.AutoSize = true;
            Label4.Location = new Point(127, 353);
            Label4.Margin = new Padding(2, 0, 2, 0);
            Label4.Name = "Label4";
            Label4.Size = new Size(126, 13);
            Label4.TabIndex = 11;
            Label4.Text = "Selected Retention Rule:";
            // 
            // cbRetention
            // 
            cbRetention.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            cbRetention.FormattingEnabled = true;
            cbRetention.Location = new Point(258, 345);
            cbRetention.Name = "cbRetention";
            cbRetention.Size = new Size(192, 21);
            cbRetention.TabIndex = 12;
            // 
            // cbLibrary
            // 
            cbLibrary.FormattingEnabled = true;
            cbLibrary.Location = new Point(258, 372);
            cbLibrary.Name = "cbLibrary";
            cbLibrary.Size = new Size(192, 21);
            cbLibrary.TabIndex = 14;
            // 
            // Label5
            // 
            Label5.AutoSize = true;
            Label5.Location = new Point(179, 380);
            Label5.Margin = new Padding(2, 0, 2, 0);
            Label5.Name = "Label5";
            Label5.Size = new Size(74, 13);
            Label5.TabIndex = 13;
            Label5.Text = "Select Library:";
            // 
            // btnRemove
            // 
            _btnRemove.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            _btnRemove.Location = new Point(465, 395);
            _btnRemove.Name = "_btnRemove";
            _btnRemove.Size = new Size(73, 44);
            _btnRemove.TabIndex = 15;
            _btnRemove.Text = "Remove Imports";
            _btnRemove.UseVisualStyleBackColor = true;
            // 
            // frmPstLoader
            // 
            AutoScaleDimensions = new SizeF(6.0f, 13.0f);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(550, 449);
            Controls.Add(_btnRemove);
            Controls.Add(cbLibrary);
            Controls.Add(Label5);
            Controls.Add(cbRetention);
            Controls.Add(Label4);
            Controls.Add(txtEmailsProcessed);
            Controls.Add(txtFoldersProcessed);
            Controls.Add(Label3);
            Controls.Add(Label2);
            Controls.Add(SB);
            Controls.Add(_btnArchive);
            Controls.Add(lbMsg);
            Controls.Add(_btnLoad);
            Controls.Add(_btnSelectFile);
            Controls.Add(Label1);
            Controls.Add(_txtPstFqn);
            Margin = new Padding(2);
            Name = "frmPstLoader";
            Text = "PST Loader                  (frmPstLoader)";
            Deactivate += new EventHandler(frmPstLoader_Deactivate);
            Disposed += new EventHandler(frmPstLoader_Disposed);
            Load += new EventHandler(frmPstLoader_Load);
            ResumeLayout(false);
            PerformLayout();
        }

        internal OpenFileDialog OpenFileDialog1;
        private TextBox _txtPstFqn;

        internal TextBox txtPstFqn
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _txtPstFqn;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_txtPstFqn != null)
                {
                    _txtPstFqn.TextChanged -= txtPstFqn_TextChanged;
                }

                _txtPstFqn = value;
                if (_txtPstFqn != null)
                {
                    _txtPstFqn.TextChanged += txtPstFqn_TextChanged;
                }
            }
        }

        internal Label Label1;
        private Button _btnSelectFile;

        internal Button btnSelectFile
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnSelectFile;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnSelectFile != null)
                {
                    _btnSelectFile.Click -= btnSelectFile_Click;
                }

                _btnSelectFile = value;
                if (_btnSelectFile != null)
                {
                    _btnSelectFile.Click += btnSelectFile_Click;
                }
            }
        }

        private Button _btnLoad;

        internal Button btnLoad
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnLoad;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnLoad != null)
                {
                    _btnLoad.Click -= btnLoad_Click;
                }

                _btnLoad = value;
                if (_btnLoad != null)
                {
                    _btnLoad.Click += btnLoad_Click;
                }
            }
        }

        internal ListBox lbMsg;
        private Button _btnArchive;

        internal Button btnArchive
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnArchive;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnArchive != null)
                {
                    _btnArchive.Click -= btnArchive_Click;
                }

                _btnArchive = value;
                if (_btnArchive != null)
                {
                    _btnArchive.Click += btnArchive_Click;
                }
            }
        }

        internal TextBox SB;
        internal Label Label2;
        internal Label Label3;
        internal TextBox txtFoldersProcessed;
        internal TextBox txtEmailsProcessed;
        internal ToolTip TT;
        internal Label Label4;
        internal ComboBox cbRetention;
        internal ComboBox cbLibrary;
        internal Label Label5;
        private Button _btnRemove;

        internal Button btnRemove
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnRemove;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnRemove != null)
                {
                    _btnRemove.Click -= btnRemove_Click;
                }

                _btnRemove = value;
                if (_btnRemove != null)
                {
                    _btnRemove.Click += btnRemove_Click;
                }
            }
        }
    }
}