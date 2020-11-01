using System;
using System.Diagnostics;
using System.Drawing;
using System.Windows.Forms;
using MODI;

namespace EcmArchiver
{
    [Microsoft.VisualBasic.CompilerServices.DesignerGenerated()]
    public partial class frmLibraryAssgnList : Form
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
            lbLibraries = new ListBox();
            SuspendLayout();
            // 
            // lbLibraries
            // 
            lbLibraries.Dock = DockStyle.Fill;
            lbLibraries.FormattingEnabled = true;
            lbLibraries.Location = new Point(0, 0);
            lbLibraries.Name = "lbLibraries";
            lbLibraries.Size = new Size(179, 160);
            lbLibraries.TabIndex = 0;
            // 
            // frmLibraryAssgnList
            // 
            AutoScaleDimensions = new SizeF(6.0f, 13.0f);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(179, 163);
            Controls.Add(lbLibraries);
            Name = "frmLibraryAssgnList";
            StartPosition = FormStartPosition.Manual;
            Text = "Assigned Libraries     (frmLibraryAssgnList)";
            TopMost = true;
            Load += new EventHandler(frmLibraryAssgnList_Load);
            ResumeLayout(false);
        }

        internal ListBox lbLibraries;
    }
}