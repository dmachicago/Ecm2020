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
    public partial class frmSqlite : Form
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
            _dgData = new DataGridView();
            _dgData.CellContentClick += new DataGridViewCellEventHandler(dgData_CellContentClick);
            _CheckBox1 = new CheckBox();
            _CheckBox1.CheckedChanged += new EventHandler(CheckBox1_CheckedChanged);
            _btnValidate = new Button();
            _btnValidate.Click += new EventHandler(btnValidate_Click);
            txtSql = new TextBox();
            _btnExec = new Button();
            _btnExec.Click += new EventHandler(btnExec_Click);
            _CheckBox2 = new CheckBox();
            _CheckBox2.CheckedChanged += new EventHandler(CheckBox2_CheckedChanged);
            _CheckBox3 = new CheckBox();
            _CheckBox3.CheckedChanged += new EventHandler(CheckBox3_CheckedChanged);
            _CheckBox4 = new CheckBox();
            _CheckBox4.CheckedChanged += new EventHandler(CheckBox4_CheckedChanged);
            _CheckBox5 = new CheckBox();
            _CheckBox5.CheckedChanged += new EventHandler(CheckBox5_CheckedChanged);
            _CheckBox6 = new CheckBox();
            _CheckBox6.CheckedChanged += new EventHandler(CheckBox6_CheckedChanged);
            _CheckBox7 = new CheckBox();
            _CheckBox7.CheckedChanged += new EventHandler(CheckBox7_CheckedChanged);
            _CheckBox8 = new CheckBox();
            _CheckBox8.CheckedChanged += new EventHandler(CheckBox8_CheckedChanged);
            txtLimit = new TextBox();
            Label1 = new Label();
            lblConn = new Label();
            GroupBox1 = new GroupBox();
            _RadioButton1 = new RadioButton();
            _RadioButton1.CheckedChanged += new EventHandler(RadioButton1_CheckedChanged);
            _RadioButton2 = new RadioButton();
            _RadioButton2.CheckedChanged += new EventHandler(RadioButton2_CheckedChanged);
            _RadioButton3 = new RadioButton();
            _RadioButton3.CheckedChanged += new EventHandler(RadioButton3_CheckedChanged);
            _RadioButton4 = new RadioButton();
            _RadioButton4.CheckedChanged += new EventHandler(RadioButton4_CheckedChanged);
            _RadioButton5 = new RadioButton();
            _RadioButton5.CheckedChanged += new EventHandler(RadioButton5_CheckedChanged);
            _RadioButton6 = new RadioButton();
            _RadioButton6.CheckedChanged += new EventHandler(RadioButton6_CheckedChanged);
            _RadioButton7 = new RadioButton();
            _RadioButton7.CheckedChanged += new EventHandler(RadioButton7_CheckedChanged);
            _RadioButton8 = new RadioButton();
            _RadioButton8.CheckedChanged += new EventHandler(RadioButton8_CheckedChanged);
            ((System.ComponentModel.ISupportInitialize)_dgData).BeginInit();
            GroupBox1.SuspendLayout();
            SuspendLayout();
            // 
            // dgData
            // 
            _dgData.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            _dgData.Location = new Point(16, 228);
            _dgData.Margin = new Padding(4);
            _dgData.Name = "_dgData";
            _dgData.Size = new Size(1283, 665);
            _dgData.TabIndex = 0;
            // 
            // CheckBox1
            // 
            _CheckBox1.AutoSize = true;
            _CheckBox1.Enabled = false;
            _CheckBox1.Location = new Point(40, 16);
            _CheckBox1.Margin = new Padding(4);
            _CheckBox1.Name = "_CheckBox1";
            _CheckBox1.Size = new Size(85, 21);
            _CheckBox1.TabIndex = 1;
            _CheckBox1.Text = "Contacts";
            _CheckBox1.UseVisualStyleBackColor = true;
            // 
            // btnValidate
            // 
            _btnValidate.Location = new Point(1036, 11);
            _btnValidate.Margin = new Padding(4);
            _btnValidate.Name = "_btnValidate";
            _btnValidate.Size = new Size(100, 57);
            _btnValidate.TabIndex = 2;
            _btnValidate.Text = "Validate";
            _btnValidate.UseVisualStyleBackColor = true;
            // 
            // txtSql
            // 
            txtSql.Location = new Point(16, 82);
            txtSql.Margin = new Padding(4);
            txtSql.Multiline = true;
            txtSql.Name = "txtSql";
            txtSql.Size = new Size(1283, 137);
            txtSql.TabIndex = 3;
            // 
            // btnExec
            // 
            _btnExec.Location = new Point(1307, 123);
            _btnExec.Margin = new Padding(4);
            _btnExec.Name = "_btnExec";
            _btnExec.Size = new Size(100, 57);
            _btnExec.TabIndex = 4;
            _btnExec.Text = "Execute";
            _btnExec.UseVisualStyleBackColor = true;
            // 
            // CheckBox2
            // 
            _CheckBox2.AutoSize = true;
            _CheckBox2.Location = new Point(168, 16);
            _CheckBox2.Margin = new Padding(4);
            _CheckBox2.Name = "_CheckBox2";
            _CheckBox2.Size = new Size(87, 21);
            _CheckBox2.TabIndex = 5;
            _CheckBox2.Text = "Directory";
            _CheckBox2.UseVisualStyleBackColor = true;
            // 
            // CheckBox3
            // 
            _CheckBox3.AutoSize = true;
            _CheckBox3.Location = new Point(432, 16);
            _CheckBox3.Margin = new Padding(4);
            _CheckBox3.Name = "_CheckBox3";
            _CheckBox3.Size = new Size(59, 21);
            _CheckBox3.TabIndex = 7;
            _CheckBox3.Text = "Files";
            _CheckBox3.UseVisualStyleBackColor = true;
            // 
            // CheckBox4
            // 
            _CheckBox4.AutoSize = true;
            _CheckBox4.Enabled = false;
            _CheckBox4.Location = new Point(296, 16);
            _CheckBox4.Margin = new Padding(4);
            _CheckBox4.Name = "_CheckBox4";
            _CheckBox4.Size = new Size(92, 21);
            _CheckBox4.TabIndex = 6;
            _CheckBox4.Text = "Exchange";
            _CheckBox4.UseVisualStyleBackColor = true;
            // 
            // CheckBox5
            // 
            _CheckBox5.AutoSize = true;
            _CheckBox5.Enabled = false;
            _CheckBox5.Location = new Point(653, 16);
            _CheckBox5.Margin = new Padding(4);
            _CheckBox5.Name = "_CheckBox5";
            _CheckBox5.Size = new Size(119, 21);
            _CheckBox5.TabIndex = 9;
            _CheckBox5.Text = "Multi Loc Files";
            _CheckBox5.UseVisualStyleBackColor = true;
            // 
            // CheckBox6
            // 
            _CheckBox6.AutoSize = true;
            _CheckBox6.Enabled = false;
            _CheckBox6.Location = new Point(532, 16);
            _CheckBox6.Margin = new Padding(4);
            _CheckBox6.Name = "_CheckBox6";
            _CheckBox6.Size = new Size(81, 21);
            _CheckBox6.TabIndex = 8;
            _CheckBox6.Text = "Listener";
            _CheckBox6.UseVisualStyleBackColor = true;
            // 
            // CheckBox7
            // 
            _CheckBox7.AutoSize = true;
            _CheckBox7.Enabled = false;
            _CheckBox7.Location = new Point(936, 16);
            _CheckBox7.Margin = new Padding(4);
            _CheckBox7.Name = "_CheckBox7";
            _CheckBox7.Size = new Size(75, 21);
            _CheckBox7.TabIndex = 11;
            _CheckBox7.Text = "Zipfiles";
            _CheckBox7.UseVisualStyleBackColor = true;
            // 
            // CheckBox8
            // 
            _CheckBox8.AutoSize = true;
            _CheckBox8.Enabled = false;
            _CheckBox8.Location = new Point(815, 16);
            _CheckBox8.Margin = new Padding(4);
            _CheckBox8.Name = "_CheckBox8";
            _CheckBox8.Size = new Size(79, 21);
            _CheckBox8.TabIndex = 10;
            _CheckBox8.Text = "Outlook";
            _CheckBox8.UseVisualStyleBackColor = true;
            // 
            // txtLimit
            // 
            txtLimit.Location = new Point(1265, 15);
            txtLimit.Margin = new Padding(4);
            txtLimit.Name = "txtLimit";
            txtLimit.Size = new Size(72, 22);
            txtLimit.TabIndex = 12;
            txtLimit.Text = "10";
            // 
            // Label1
            // 
            Label1.AutoSize = true;
            Label1.Location = new Point(1155, 18);
            Label1.Margin = new Padding(4, 0, 4, 0);
            Label1.Name = "Label1";
            Label1.Size = new Size(100, 17);
            Label1.TabIndex = 13;
            Label1.Text = "Limit Rows To:";
            // 
            // lblConn
            // 
            lblConn.AutoSize = true;
            lblConn.Location = new Point(23, 52);
            lblConn.Margin = new Padding(4, 0, 4, 0);
            lblConn.Name = "lblConn";
            lblConn.Size = new Size(83, 17);
            lblConn.TabIndex = 14;
            lblConn.Text = "Connection:";
            // 
            // GroupBox1
            // 
            GroupBox1.Controls.Add(_RadioButton7);
            GroupBox1.Controls.Add(_RadioButton8);
            GroupBox1.Controls.Add(_RadioButton4);
            GroupBox1.Controls.Add(_RadioButton5);
            GroupBox1.Controls.Add(_RadioButton6);
            GroupBox1.Controls.Add(_RadioButton3);
            GroupBox1.Controls.Add(_RadioButton2);
            GroupBox1.Controls.Add(_RadioButton1);
            GroupBox1.Location = new Point(1306, 228);
            GroupBox1.Name = "GroupBox1";
            GroupBox1.Size = new Size(101, 271);
            GroupBox1.TabIndex = 17;
            GroupBox1.TabStop = false;
            GroupBox1.Text = "COUNT";
            // 
            // RadioButton1
            // 
            _RadioButton1.AutoSize = true;
            _RadioButton1.Location = new Point(6, 30);
            _RadioButton1.Name = "_RadioButton1";
            _RadioButton1.Size = new Size(84, 21);
            _RadioButton1.TabIndex = 0;
            _RadioButton1.TabStop = true;
            _RadioButton1.Text = "Contacts";
            _RadioButton1.UseVisualStyleBackColor = true;
            // 
            // RadioButton2
            // 
            _RadioButton2.AutoSize = true;
            _RadioButton2.Location = new Point(6, 84);
            _RadioButton2.Name = "_RadioButton2";
            _RadioButton2.Size = new Size(59, 21);
            _RadioButton2.TabIndex = 1;
            _RadioButton2.TabStop = true;
            _RadioButton2.Text = "Excg";
            _RadioButton2.UseVisualStyleBackColor = true;
            // 
            // RadioButton3
            // 
            _RadioButton3.AutoSize = true;
            _RadioButton3.Location = new Point(6, 57);
            _RadioButton3.Name = "_RadioButton3";
            _RadioButton3.Size = new Size(54, 21);
            _RadioButton3.TabIndex = 2;
            _RadioButton3.TabStop = true;
            _RadioButton3.Text = "Dirs";
            _RadioButton3.UseVisualStyleBackColor = true;
            // 
            // RadioButton4
            // 
            _RadioButton4.AutoSize = true;
            _RadioButton4.Location = new Point(6, 138);
            _RadioButton4.Name = "_RadioButton4";
            _RadioButton4.Size = new Size(80, 21);
            _RadioButton4.TabIndex = 5;
            _RadioButton4.TabStop = true;
            _RadioButton4.Text = "Listener";
            _RadioButton4.UseVisualStyleBackColor = true;
            // 
            // RadioButton5
            // 
            _RadioButton5.AutoSize = true;
            _RadioButton5.Location = new Point(6, 165);
            _RadioButton5.Name = "_RadioButton5";
            _RadioButton5.Size = new Size(91, 21);
            _RadioButton5.TabIndex = 4;
            _RadioButton5.TabStop = true;
            _RadioButton5.Text = "Multi Files";
            _RadioButton5.TextAlign = ContentAlignment.MiddleCenter;
            _RadioButton5.UseVisualStyleBackColor = true;
            // 
            // RadioButton6
            // 
            _RadioButton6.AutoSize = true;
            _RadioButton6.Location = new Point(6, 111);
            _RadioButton6.Name = "_RadioButton6";
            _RadioButton6.Size = new Size(58, 21);
            _RadioButton6.TabIndex = 3;
            _RadioButton6.TabStop = true;
            _RadioButton6.Text = "Files";
            _RadioButton6.UseVisualStyleBackColor = true;
            // 
            // RadioButton7
            // 
            _RadioButton7.AutoSize = true;
            _RadioButton7.Location = new Point(6, 192);
            _RadioButton7.Name = "_RadioButton7";
            _RadioButton7.Size = new Size(78, 21);
            _RadioButton7.TabIndex = 7;
            _RadioButton7.TabStop = true;
            _RadioButton7.Text = "Outlook";
            _RadioButton7.UseVisualStyleBackColor = true;
            // 
            // RadioButton8
            // 
            _RadioButton8.AutoSize = true;
            _RadioButton8.Location = new Point(6, 219);
            _RadioButton8.Name = "_RadioButton8";
            _RadioButton8.Size = new Size(82, 21);
            _RadioButton8.TabIndex = 6;
            _RadioButton8.TabStop = true;
            _RadioButton8.Text = "Zip Files";
            _RadioButton8.UseVisualStyleBackColor = true;
            // 
            // frmSqlite
            // 
            AutoScaleDimensions = new SizeF(8.0f, 16.0f);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(1423, 907);
            Controls.Add(GroupBox1);
            Controls.Add(lblConn);
            Controls.Add(Label1);
            Controls.Add(txtLimit);
            Controls.Add(_CheckBox7);
            Controls.Add(_CheckBox8);
            Controls.Add(_CheckBox5);
            Controls.Add(_CheckBox6);
            Controls.Add(_CheckBox3);
            Controls.Add(_CheckBox4);
            Controls.Add(_CheckBox2);
            Controls.Add(_btnExec);
            Controls.Add(txtSql);
            Controls.Add(_btnValidate);
            Controls.Add(_CheckBox1);
            Controls.Add(_dgData);
            Margin = new Padding(4);
            Name = "frmSqlite";
            Text = "frmSqlite";
            ((System.ComponentModel.ISupportInitialize)_dgData).EndInit();
            GroupBox1.ResumeLayout(false);
            GroupBox1.PerformLayout();
            ResumeLayout(false);
            PerformLayout();
        }

        private DataGridView _dgData;

        internal DataGridView dgData
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _dgData;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_dgData != null)
                {
                    _dgData.CellContentClick -= dgData_CellContentClick;
                }

                _dgData = value;
                if (_dgData != null)
                {
                    _dgData.CellContentClick += dgData_CellContentClick;
                }
            }
        }

        private CheckBox _CheckBox1;

        internal CheckBox CheckBox1
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _CheckBox1;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_CheckBox1 != null)
                {
                    _CheckBox1.CheckedChanged -= CheckBox1_CheckedChanged;
                }

                _CheckBox1 = value;
                if (_CheckBox1 != null)
                {
                    _CheckBox1.CheckedChanged += CheckBox1_CheckedChanged;
                }
            }
        }

        private Button _btnValidate;

        internal Button btnValidate
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnValidate;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnValidate != null)
                {
                    _btnValidate.Click -= btnValidate_Click;
                }

                _btnValidate = value;
                if (_btnValidate != null)
                {
                    _btnValidate.Click += btnValidate_Click;
                }
            }
        }

        internal TextBox txtSql;
        private Button _btnExec;

        internal Button btnExec
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _btnExec;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_btnExec != null)
                {
                    _btnExec.Click -= btnExec_Click;
                }

                _btnExec = value;
                if (_btnExec != null)
                {
                    _btnExec.Click += btnExec_Click;
                }
            }
        }

        private CheckBox _CheckBox2;

        internal CheckBox CheckBox2
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _CheckBox2;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_CheckBox2 != null)
                {
                    _CheckBox2.CheckedChanged -= CheckBox2_CheckedChanged;
                }

                _CheckBox2 = value;
                if (_CheckBox2 != null)
                {
                    _CheckBox2.CheckedChanged += CheckBox2_CheckedChanged;
                }
            }
        }

        private CheckBox _CheckBox3;

        internal CheckBox CheckBox3
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _CheckBox3;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_CheckBox3 != null)
                {
                    _CheckBox3.CheckedChanged -= CheckBox3_CheckedChanged;
                }

                _CheckBox3 = value;
                if (_CheckBox3 != null)
                {
                    _CheckBox3.CheckedChanged += CheckBox3_CheckedChanged;
                }
            }
        }

        private CheckBox _CheckBox4;

        internal CheckBox CheckBox4
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _CheckBox4;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_CheckBox4 != null)
                {
                    _CheckBox4.CheckedChanged -= CheckBox4_CheckedChanged;
                }

                _CheckBox4 = value;
                if (_CheckBox4 != null)
                {
                    _CheckBox4.CheckedChanged += CheckBox4_CheckedChanged;
                }
            }
        }

        private CheckBox _CheckBox5;

        internal CheckBox CheckBox5
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _CheckBox5;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_CheckBox5 != null)
                {
                    _CheckBox5.CheckedChanged -= CheckBox5_CheckedChanged;
                }

                _CheckBox5 = value;
                if (_CheckBox5 != null)
                {
                    _CheckBox5.CheckedChanged += CheckBox5_CheckedChanged;
                }
            }
        }

        private CheckBox _CheckBox6;

        internal CheckBox CheckBox6
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _CheckBox6;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_CheckBox6 != null)
                {
                    _CheckBox6.CheckedChanged -= CheckBox6_CheckedChanged;
                }

                _CheckBox6 = value;
                if (_CheckBox6 != null)
                {
                    _CheckBox6.CheckedChanged += CheckBox6_CheckedChanged;
                }
            }
        }

        private CheckBox _CheckBox7;

        internal CheckBox CheckBox7
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _CheckBox7;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_CheckBox7 != null)
                {
                    _CheckBox7.CheckedChanged -= CheckBox7_CheckedChanged;
                }

                _CheckBox7 = value;
                if (_CheckBox7 != null)
                {
                    _CheckBox7.CheckedChanged += CheckBox7_CheckedChanged;
                }
            }
        }

        private CheckBox _CheckBox8;

        internal CheckBox CheckBox8
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _CheckBox8;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_CheckBox8 != null)
                {
                    _CheckBox8.CheckedChanged -= CheckBox8_CheckedChanged;
                }

                _CheckBox8 = value;
                if (_CheckBox8 != null)
                {
                    _CheckBox8.CheckedChanged += CheckBox8_CheckedChanged;
                }
            }
        }

        internal TextBox txtLimit;
        internal Label Label1;
        internal Label lblConn;
        internal GroupBox GroupBox1;
        private RadioButton _RadioButton7;

        internal RadioButton RadioButton7
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _RadioButton7;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_RadioButton7 != null)
                {
                    _RadioButton7.CheckedChanged -= RadioButton7_CheckedChanged;
                }

                _RadioButton7 = value;
                if (_RadioButton7 != null)
                {
                    _RadioButton7.CheckedChanged += RadioButton7_CheckedChanged;
                }
            }
        }

        private RadioButton _RadioButton8;

        internal RadioButton RadioButton8
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _RadioButton8;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_RadioButton8 != null)
                {
                    _RadioButton8.CheckedChanged -= RadioButton8_CheckedChanged;
                }

                _RadioButton8 = value;
                if (_RadioButton8 != null)
                {
                    _RadioButton8.CheckedChanged += RadioButton8_CheckedChanged;
                }
            }
        }

        private RadioButton _RadioButton4;

        internal RadioButton RadioButton4
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _RadioButton4;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_RadioButton4 != null)
                {
                    _RadioButton4.CheckedChanged -= RadioButton4_CheckedChanged;
                }

                _RadioButton4 = value;
                if (_RadioButton4 != null)
                {
                    _RadioButton4.CheckedChanged += RadioButton4_CheckedChanged;
                }
            }
        }

        private RadioButton _RadioButton5;

        internal RadioButton RadioButton5
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _RadioButton5;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_RadioButton5 != null)
                {
                    _RadioButton5.CheckedChanged -= RadioButton5_CheckedChanged;
                }

                _RadioButton5 = value;
                if (_RadioButton5 != null)
                {
                    _RadioButton5.CheckedChanged += RadioButton5_CheckedChanged;
                }
            }
        }

        private RadioButton _RadioButton6;

        internal RadioButton RadioButton6
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _RadioButton6;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_RadioButton6 != null)
                {
                    _RadioButton6.CheckedChanged -= RadioButton6_CheckedChanged;
                }

                _RadioButton6 = value;
                if (_RadioButton6 != null)
                {
                    _RadioButton6.CheckedChanged += RadioButton6_CheckedChanged;
                }
            }
        }

        private RadioButton _RadioButton3;

        internal RadioButton RadioButton3
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _RadioButton3;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_RadioButton3 != null)
                {
                    _RadioButton3.CheckedChanged -= RadioButton3_CheckedChanged;
                }

                _RadioButton3 = value;
                if (_RadioButton3 != null)
                {
                    _RadioButton3.CheckedChanged += RadioButton3_CheckedChanged;
                }
            }
        }

        private RadioButton _RadioButton2;

        internal RadioButton RadioButton2
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _RadioButton2;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_RadioButton2 != null)
                {
                    _RadioButton2.CheckedChanged -= RadioButton2_CheckedChanged;
                }

                _RadioButton2 = value;
                if (_RadioButton2 != null)
                {
                    _RadioButton2.CheckedChanged += RadioButton2_CheckedChanged;
                }
            }
        }

        private RadioButton _RadioButton1;

        internal RadioButton RadioButton1
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _RadioButton1;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_RadioButton1 != null)
                {
                    _RadioButton1.CheckedChanged -= RadioButton1_CheckedChanged;
                }

                _RadioButton1 = value;
                if (_RadioButton1 != null)
                {
                    _RadioButton1.CheckedChanged += RadioButton1_CheckedChanged;
                }
            }
        }
    }
}