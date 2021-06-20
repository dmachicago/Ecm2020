using System.Diagnostics;
using System.Drawing;
using System.Runtime.CompilerServices;
using System.Windows.Forms;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{
    [DesignerGenerated()]
    public partial class frmLocalParameters : Form
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
            var DataGridViewCellStyle1 = new DataGridViewCellStyle();
            _dgParms = new DataGridView();
            _dgParms.CellContentClick += new DataGridViewCellEventHandler(DataGridView1_CellContentClick);
            Label1 = new Label();
            btnApply = new Button();
            txtValue = new TextBox();
            ((System.ComponentModel.ISupportInitialize)_dgParms).BeginInit();
            SuspendLayout();
            // 
            // dgParms
            // 
            DataGridViewCellStyle1.BackColor = Color.FromArgb(Conversions.ToInteger(Conversions.ToByte(128)), Conversions.ToInteger(Conversions.ToByte(255)), Conversions.ToInteger(Conversions.ToByte(255)));
            _dgParms.AlternatingRowsDefaultCellStyle = DataGridViewCellStyle1;
            _dgParms.Anchor = AnchorStyles.Top | AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right;

            _dgParms.BorderStyle = BorderStyle.Fixed3D;
            _dgParms.CellBorderStyle = DataGridViewCellBorderStyle.Raised;
            _dgParms.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            _dgParms.Location = new Point(26, 30);
            _dgParms.Name = "_dgParms";
            _dgParms.RowTemplate.Height = 24;
            _dgParms.Size = new Size(813, 380);
            _dgParms.TabIndex = 0;
            // 
            // Label1
            // 
            Label1.AutoSize = true;
            Label1.Location = new Point(26, 417);
            Label1.Name = "Label1";
            Label1.Size = new Size(73, 17);
            Label1.TabIndex = 1;
            Label1.Text = "Set Value:";
            // 
            // btnApply
            // 
            btnApply.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            btnApply.Location = new Point(223, 445);
            btnApply.Name = "btnApply";
            btnApply.Size = new Size(75, 42);
            btnApply.TabIndex = 4;
            btnApply.Text = "Apply";
            btnApply.UseVisualStyleBackColor = true;
            // 
            // txtValue
            // 
            txtValue.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            txtValue.Location = new Point(107, 417);
            txtValue.Name = "txtValue";
            txtValue.Size = new Size(306, 22);
            txtValue.TabIndex = 5;
            // 
            // frmLocalParameters
            // 
            AutoScaleDimensions = new SizeF(8.0f, 16.0f);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(863, 499);
            Controls.Add(txtValue);
            Controls.Add(btnApply);
            Controls.Add(Label1);
            Controls.Add(_dgParms);
            Name = "frmLocalParameters";
            Text = "frmLocalParameters";
            ((System.ComponentModel.ISupportInitialize)_dgParms).EndInit();
            ResumeLayout(false);
            PerformLayout();
        }

        private DataGridView _dgParms;

        internal DataGridView dgParms
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _dgParms;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_dgParms != null)
                {
                    _dgParms.CellContentClick -= DataGridView1_CellContentClick;
                }

                _dgParms = value;
                if (_dgParms != null)
                {
                    _dgParms.CellContentClick += DataGridView1_CellContentClick;
                }
            }
        }

        internal Label Label1;
        internal Button btnApply;
        internal TextBox txtValue;
    }
}