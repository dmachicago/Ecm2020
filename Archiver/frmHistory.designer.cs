using System;
using System.Diagnostics;
using System.Drawing;
using System.Runtime.CompilerServices;
using System.Windows.Forms;
using MODI;

namespace EcmArchiver
{
    [Microsoft.VisualBasic.CompilerServices.DesignerGenerated()]
    public partial class frmHistory : Form
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
            _lbHistory = new ListBox();
            _lbHistory.SelectedIndexChanged += new EventHandler(lbHistory_SelectedIndexChanged);
            SuspendLayout();
            // 
            // lbHistory
            // 
            _lbHistory.Dock = DockStyle.Fill;
            _lbHistory.FormattingEnabled = true;
            _lbHistory.Location = new Point(0, 0);
            _lbHistory.Name = "_lbHistory";
            _lbHistory.Size = new Size(890, 433);
            _lbHistory.TabIndex = 0;
            // 
            // frmHistory
            // 
            AutoScaleDimensions = new SizeF(6.0f, 13.0f);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(890, 437);
            Controls.Add(_lbHistory);
            Name = "frmHistory";
            Text = "History of improvements      (frmHistory)";
            Load += new EventHandler(frmHistory_Load);
            ResumeLayout(false);
        }

        private ListBox _lbHistory;

        internal ListBox lbHistory
        {
            [MethodImpl(MethodImplOptions.Synchronized)]
            get
            {
                return _lbHistory;
            }

            [MethodImpl(MethodImplOptions.Synchronized)]
            set
            {
                if (_lbHistory != null)
                {
                    _lbHistory.SelectedIndexChanged -= lbHistory_SelectedIndexChanged;
                }

                _lbHistory = value;
                if (_lbHistory != null)
                {
                    _lbHistory.SelectedIndexChanged += lbHistory_SelectedIndexChanged;
                }
            }
        }
    }
}