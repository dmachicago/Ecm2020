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
    public partial class frmSqlHelp : Form
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
            SplitContainer1 = new SplitContainer();
            _cbDirectory = new ComboBox();
            _cbDirectory.SelectedIndexChanged += new EventHandler(cbDirectory_SelectedIndexChanged);
            _btnOpenFile = new Button();
            _btnOpenFile.Click += new EventHandler(btnOpenFile_Click);
            lbFiles = new ListBox();
            _btnAddFile = new Button();
            _btnAddFile.Click += new EventHandler(btnAddFile_Click);
            _btnCopy = new Button();
            _btnCopy.Click += new EventHandler(btnCopy_Click);
            _rtbFile = new RichTextBox();
            _rtbFile.TextChanged += new EventHandler(RichTextBox1_TextChanged);
            OpenFileDialog1 = new OpenFileDialog();
            ((System.ComponentModel.ISupportInitialize)SplitContainer1).BeginInit();
            SplitContainer1.Panel1.SuspendLayout();
            SplitContainer1.Panel2.SuspendLayout();
            SplitContainer1.SuspendLayout();
            SuspendLayout();
            // 
            // SplitContainer1
            // 
            SplitContainer1.BorderStyle = BorderStyle.Fixed3D;
            SplitContainer1.Dock = DockStyle.Fill;
            SplitContainer1.Location = new Point(0, 0);
            SplitContainer1.Name = "SplitContainer1";
            // 
            // SplitContainer1.Panel1
            // 
            SplitContainer1.Panel1.Controls.Add(_cbDirectory);
            SplitContainer1.Panel1.Controls.Add(_btnOpenFile);
            SplitContainer1.Panel1.Controls.Add(lbFiles);
            // 
            // SplitContainer1.Panel2
            // 
            SplitContainer1.Panel2.Controls.Add(_btnAddFile);
            SplitContainer1.Panel2.Controls.Add(_btnCopy);
            SplitContainer1.Panel2.Controls.Add(_rtbFile);
            SplitContainer1.Size = new Size(898, 621);
            SplitContainer1.SplitterDistance = 347;
            SplitContainer1.TabIndex = 0;
            // 
            // cbDirectory
            // 
            _cbDirectory.Anchor = AnchorStyles.Top | AnchorStyles.Left | AnchorStyles.Right;
            _cbDirectory.FormattingEnabled = true;
            _cbDirectory.Items.AddRange(new object[] { "Fulltext Index Routines", "SQL Routines" });
            _cbDirectory.Location = new Point(13, 19);
            _cbDirectory.Name = "_cbDirectory";
            _cbDirectory.Size = new Size(310, 24);
            _cbDirectory.TabIndex = 2;
            // 
            // btnOpenFile
            // 
            _btnOpenFile.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            _btnOpenFile.Location = new Point(132, 562);
            _btnOpenFile.Name = "_btnOpenFile";
            _btnOpenFile.Size = new Size(75, 43);
            _btnOpenFile.TabIndex = 1;
            _btnOpenFile.Text = "Open";
            _btnOpenFile.UseVisualStyleBackColor = true;
            // 
            // lbFiles
            // 
            lbFiles.Anchor = AnchorStyles.Top | AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;

            lbFiles.FormattingEnabled = true;
            lbFiles.ItemHeight = 16;
            lbFiles.Location = new Point(12, 50);
            lbFiles.Name = "lbFiles";
            lbFiles.Size = new Size(311, 484);
            lbFiles.TabIndex = 0;
            // 
            // btnAddFile
            // 
            _btnAddFile.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            _btnAddFile.Location = new Point(18, 562);
            _btnAddFile.Name = "_btnAddFile";
            _btnAddFile.Size = new Size(75, 43);
            _btnAddFile.TabIndex = 3;
            _btnAddFile.Text = "Add";
            _btnAddFile.UseVisualStyleBackColor = true;
            // 
            // btnCopy
            // 
            _btnCopy.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            _btnCopy.Location = new Point(456, 562);
            _btnCopy.Name = "_btnCopy";
            _btnCopy.Size = new Size(75, 43);
            _btnCopy.TabIndex = 2;
            _btnCopy.Text = "Copy";
            _btnCopy.UseVisualStyleBackColor = true;
            // 
            // rtbFile
            // 
            _rtbFile.Anchor = AnchorStyles.Top | AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;

            _rtbFile.Location = new Point(18, 19);
            _rtbFile.Name = "_rtbFile";
            _rtbFile.Size = new Size(513, 527);
            _rtbFile.TabIndex = 0;
            _rtbFile.Text = "";
            // 
            // OpenFileDialog1
            // 
            OpenFileDialog1.FileName = "OpenFileDialog1";
            // 
            // frmSqlHelp
            // 
            AutoScaleDimensions = new SizeF(8.0f, 16.0f);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(898, 621);
            Controls.Add(SplitContainer1);
            Name = "frmSqlHelp";
            Text = "frmSqlHelp";
            SplitContainer1.Panel1.ResumeLayout(false);
            SplitContainer1.Panel2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)SplitContainer1).EndInit();
            SplitContainer1.ResumeLayout(false);
            ResumeLayout(false);
        }

        internal SplitContainer SplitContainer1;
        private Button _btnOpenFile;

        internal Button btnOpenFile
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnOpenFile;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnOpenFile != null)
                {
                    _btnOpenFile.Click -= btnOpenFile_Click;
                }

                _btnOpenFile = value;
                if (_btnOpenFile != null)
                {
                    _btnOpenFile.Click += btnOpenFile_Click;
                }
            }
        }

        internal ListBox lbFiles;
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

        private RichTextBox _rtbFile;

        internal RichTextBox rtbFile
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _rtbFile;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_rtbFile != null)
                {
                    _rtbFile.TextChanged -= RichTextBox1_TextChanged;
                }

                _rtbFile = value;
                if (_rtbFile != null)
                {
                    _rtbFile.TextChanged += RichTextBox1_TextChanged;
                }
            }
        }

        private ComboBox _cbDirectory;

        internal ComboBox cbDirectory
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _cbDirectory;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_cbDirectory != null)
                {
                    _cbDirectory.SelectedIndexChanged -= cbDirectory_SelectedIndexChanged;
                }

                _cbDirectory = value;
                if (_cbDirectory != null)
                {
                    _cbDirectory.SelectedIndexChanged += cbDirectory_SelectedIndexChanged;
                }
            }
        }

        private Button _btnAddFile;

        internal Button btnAddFile
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnAddFile;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnAddFile != null)
                {
                    _btnAddFile.Click -= btnAddFile_Click;
                }

                _btnAddFile = value;
                if (_btnAddFile != null)
                {
                    _btnAddFile.Click += btnAddFile_Click;
                }
            }
        }

        internal OpenFileDialog OpenFileDialog1;
    }
}