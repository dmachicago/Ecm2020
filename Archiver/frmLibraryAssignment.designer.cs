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
    public partial class frmLibraryAssignment : Form
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
            cbLibrary = new ComboBox();
            _btnAssign = new Button();
            _btnAssign.Click += new EventHandler(btnAssign_Click);
            txtFolderName = new TextBox();
            SB = new TextBox();
            _btnRemove = new Button();
            _btnRemove.Click += new EventHandler(btnRemove_Click);
            cbAssignedLibs = new ComboBox();
            txtFolderID = new TextBox();
            TT = new ToolTip(components);
            Timer1 = new Timer(components);
            Label1 = new Label();
            Label2 = new Label();
            SuspendLayout();
            // 
            // cbLibrary
            // 
            cbLibrary.FormattingEnabled = true;
            cbLibrary.Location = new Point(12, 23);
            cbLibrary.Name = "cbLibrary";
            cbLibrary.Size = new Size(232, 21);
            cbLibrary.TabIndex = 0;
            // 
            // btnAssign
            // 
            _btnAssign.Location = new Point(12, 50);
            _btnAssign.Name = "_btnAssign";
            _btnAssign.Size = new Size(106, 21);
            _btnAssign.TabIndex = 1;
            _btnAssign.Text = "Assign";
            _btnAssign.UseVisualStyleBackColor = true;
            // 
            // txtFolderName
            // 
            txtFolderName.Enabled = false;
            txtFolderName.Location = new Point(11, 87);
            txtFolderName.Name = "txtFolderName";
            txtFolderName.Size = new Size(471, 20);
            txtFolderName.TabIndex = 2;
            // 
            // SB
            // 
            SB.BackColor = Color.FromArgb(Conversions.ToInteger(Conversions.ToByte(255)), Conversions.ToInteger(Conversions.ToByte(255)), Conversions.ToInteger(Conversions.ToByte(192)));
            SB.Enabled = false;
            SB.Location = new Point(11, 113);
            SB.Name = "SB";
            SB.Size = new Size(471, 20);
            SB.TabIndex = 3;
            // 
            // btnRemove
            // 
            _btnRemove.Location = new Point(376, 50);
            _btnRemove.Name = "_btnRemove";
            _btnRemove.Size = new Size(106, 21);
            _btnRemove.TabIndex = 4;
            _btnRemove.Text = "Remove";
            _btnRemove.UseVisualStyleBackColor = true;
            // 
            // cbAssignedLibs
            // 
            cbAssignedLibs.FormattingEnabled = true;
            cbAssignedLibs.Location = new Point(250, 23);
            cbAssignedLibs.Name = "cbAssignedLibs";
            cbAssignedLibs.Size = new Size(232, 21);
            cbAssignedLibs.TabIndex = 5;
            // 
            // txtFolderID
            // 
            txtFolderID.Location = new Point(12, 139);
            txtFolderID.Name = "txtFolderID";
            txtFolderID.Size = new Size(470, 20);
            txtFolderID.TabIndex = 6;
            // 
            // TT
            // 
            TT.ToolTipTitle = "Use this form to assign a LIBRARY to a directory.";
            // 
            // Timer1
            // 
            Timer1.Enabled = true;
            Timer1.Interval = 5000;
            // 
            // Label1
            // 
            Label1.AutoSize = true;
            Label1.BackColor = Color.Transparent;
            Label1.Font = new Font("Microsoft Sans Serif", 9.0f, FontStyle.Regular, GraphicsUnit.Point, Conversions.ToByte(0));
            Label1.ForeColor = Color.WhiteSmoke;
            Label1.Location = new Point(12, 5);
            Label1.Name = "Label1";
            Label1.Size = new Size(107, 15);
            Label1.TabIndex = 7;
            Label1.Text = "Available Libraries";
            // 
            // Label2
            // 
            Label2.AutoSize = true;
            Label2.BackColor = Color.Transparent;
            Label2.Font = new Font("Microsoft Sans Serif", 9.0f, FontStyle.Regular, GraphicsUnit.Point, Conversions.ToByte(0));
            Label2.ForeColor = Color.WhiteSmoke;
            Label2.Location = new Point(247, 5);
            Label2.Name = "Label2";
            Label2.Size = new Size(108, 15);
            Label2.TabIndex = 8;
            Label2.Text = "Assigned Libraries";
            // 
            // frmLibraryAssignment
            // 
            AutoScaleDimensions = new SizeF(6.0f, 13.0f);
            AutoScaleMode = AutoScaleMode.Font;
            BackgroundImageLayout = ImageLayout.Stretch;
            ClientSize = new Size(491, 169);
            Controls.Add(Label2);
            Controls.Add(Label1);
            Controls.Add(txtFolderID);
            Controls.Add(cbAssignedLibs);
            Controls.Add(_btnRemove);
            Controls.Add(SB);
            Controls.Add(txtFolderName);
            Controls.Add(_btnAssign);
            Controls.Add(cbLibrary);
            MaximizeBox = false;
            MinimizeBox = false;
            Name = "frmLibraryAssignment";
            Text = "Library Assignment Form";
            Load += new EventHandler(frmLibraryAssignment_Load);
            Resize += new EventHandler(frmLibraryAssignment_Resize);
            ResumeLayout(false);
            PerformLayout();
        }

        internal ComboBox cbLibrary;
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

        internal TextBox txtFolderName;
        internal TextBox SB;
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

        internal ComboBox cbAssignedLibs;
        internal TextBox txtFolderID;
        internal ToolTip TT;
        internal Timer Timer1;
        internal Label Label1;
        internal Label Label2;
    }
}