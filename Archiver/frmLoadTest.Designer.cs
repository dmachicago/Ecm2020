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
    public partial class frmLoadTest : Form
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
            FolderBrowserDialog1 = new FolderBrowserDialog();
            _lbFiles = new ListBox();
            _lbFiles.SelectedIndexChanged += new EventHandler(lbFiles_SelectedIndexChanged);
            _lbDirs = new ListBox();
            _lbDirs.SelectedIndexChanged += new EventHandler(lbDirs_SelectedIndexChanged);
            txtSearch = new TextBox();
            _btnRun = new Button();
            _btnRun.Click += new EventHandler(btnRun_Click);
            txtDir = new TextBox();
            _btnDir = new Button();
            _btnDir.Click += new EventHandler(btnDir_Click);
            ckSubdir = new CheckBox();
            _Button1 = new Button();
            _Button1.Click += new EventHandler(Button1_Click);
            SuspendLayout();
            // 
            // lbFiles
            // 
            _lbFiles.Anchor = AnchorStyles.Top | AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;

            _lbFiles.FormattingEnabled = true;
            _lbFiles.ItemHeight = 16;
            _lbFiles.Location = new Point(33, 253);
            _lbFiles.Name = "_lbFiles";
            _lbFiles.SelectionMode = SelectionMode.MultiSimple;
            _lbFiles.Size = new Size(985, 356);
            _lbFiles.TabIndex = 0;
            // 
            // lbDirs
            // 
            _lbDirs.Anchor = AnchorStyles.Top | AnchorStyles.Left | AnchorStyles.Right;
            _lbDirs.FormattingEnabled = true;
            _lbDirs.ItemHeight = 16;
            _lbDirs.Location = new Point(33, 99);
            _lbDirs.Name = "_lbDirs";
            _lbDirs.Size = new Size(985, 148);
            _lbDirs.TabIndex = 1;
            // 
            // txtSearch
            // 
            txtSearch.Anchor = AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;
            txtSearch.Location = new Point(33, 635);
            txtSearch.Name = "txtSearch";
            txtSearch.Size = new Size(863, 22);
            txtSearch.TabIndex = 2;
            // 
            // btnRun
            // 
            _btnRun.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            _btnRun.Location = new Point(902, 68);
            _btnRun.Name = "_btnRun";
            _btnRun.Size = new Size(116, 28);
            _btnRun.TabIndex = 3;
            _btnRun.Text = "Scan";
            _btnRun.UseVisualStyleBackColor = true;
            // 
            // txtDir
            // 
            txtDir.Anchor = AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;
            txtDir.Location = new Point(33, 39);
            txtDir.Name = "txtDir";
            txtDir.Size = new Size(985, 22);
            txtDir.TabIndex = 4;
            // 
            // btnDir
            // 
            _btnDir.Location = new Point(33, 5);
            _btnDir.Name = "_btnDir";
            _btnDir.Size = new Size(116, 28);
            _btnDir.TabIndex = 5;
            _btnDir.Text = "Select";
            _btnDir.UseVisualStyleBackColor = true;
            // 
            // ckSubdir
            // 
            ckSubdir.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            ckSubdir.AutoSize = true;
            ckSubdir.Checked = true;
            ckSubdir.CheckState = CheckState.Checked;
            ckSubdir.Location = new Point(356, 72);
            ckSubdir.Name = "ckSubdir";
            ckSubdir.Size = new Size(127, 21);
            ckSubdir.TabIndex = 6;
            ckSubdir.Text = "Include Subdirs";
            ckSubdir.UseVisualStyleBackColor = true;
            // 
            // Button1
            // 
            _Button1.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            _Button1.Location = new Point(902, 632);
            _Button1.Name = "_Button1";
            _Button1.Size = new Size(116, 28);
            _Button1.TabIndex = 7;
            _Button1.Text = "Scan";
            _Button1.UseVisualStyleBackColor = true;
            // 
            // frmLoadTest
            // 
            AutoScaleDimensions = new SizeF(8.0f, 16.0f);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(1030, 667);
            Controls.Add(_Button1);
            Controls.Add(ckSubdir);
            Controls.Add(_btnDir);
            Controls.Add(txtDir);
            Controls.Add(_btnRun);
            Controls.Add(txtSearch);
            Controls.Add(_lbDirs);
            Controls.Add(_lbFiles);
            Name = "frmLoadTest";
            Text = "frmLoadTest";
            Load += new EventHandler(frmLoadTest_Load);
            ResumeLayout(false);
            PerformLayout();
        }

        internal FolderBrowserDialog FolderBrowserDialog1;
        private ListBox _lbFiles;

        internal ListBox lbFiles
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _lbFiles;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_lbFiles != null)
                {
                    _lbFiles.SelectedIndexChanged -= lbFiles_SelectedIndexChanged;
                }

                _lbFiles = value;
                if (_lbFiles != null)
                {
                    _lbFiles.SelectedIndexChanged += lbFiles_SelectedIndexChanged;
                }
            }
        }

        private ListBox _lbDirs;

        internal ListBox lbDirs
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _lbDirs;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_lbDirs != null)
                {
                    _lbDirs.SelectedIndexChanged -= lbDirs_SelectedIndexChanged;
                }

                _lbDirs = value;
                if (_lbDirs != null)
                {
                    _lbDirs.SelectedIndexChanged += lbDirs_SelectedIndexChanged;
                }
            }
        }

        internal TextBox txtSearch;
        private Button _btnRun;

        internal Button btnRun
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnRun;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnRun != null)
                {
                    _btnRun.Click -= btnRun_Click;
                }

                _btnRun = value;
                if (_btnRun != null)
                {
                    _btnRun.Click += btnRun_Click;
                }
            }
        }

        internal TextBox txtDir;
        private Button _btnDir;

        internal Button btnDir
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnDir;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnDir != null)
                {
                    _btnDir.Click -= btnDir_Click;
                }

                _btnDir = value;
                if (_btnDir != null)
                {
                    _btnDir.Click += btnDir_Click;
                }
            }
        }

        internal CheckBox ckSubdir;
        private Button _Button1;

        internal Button Button1
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _Button1;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_Button1 != null)
                {
                    _Button1.Click -= Button1_Click;
                }

                _Button1 = value;
                if (_Button1 != null)
                {
                    _Button1.Click += Button1_Click;
                }
            }
        }
    }
}