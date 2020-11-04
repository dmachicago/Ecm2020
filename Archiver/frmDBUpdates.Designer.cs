using System;
using System.Diagnostics;
using System.Drawing;
using System.Windows.Forms;
using MODI;

namespace EcmArchiver
{
    [Microsoft.VisualBasic.CompilerServices.DesignerGenerated()]
    public partial class frmDBUpdates : Form
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
            lblFile = new Label();
            txtFile = new TextBox();
            txtSql = new TextBox();
            Button1 = new Button();
            Button2 = new Button();
            SB = new TextBox();
            SuspendLayout();
            // 
            // lblFile
            // 
            lblFile.AutoSize = true;
            lblFile.Location = new Point(27, 22);
            lblFile.Name = "lblFile";
            lblFile.Size = new Size(80, 17);
            lblFile.TabIndex = 0;
            lblFile.Text = "Update File";
            // 
            // txtFile
            // 
            txtFile.Location = new Point(30, 43);
            txtFile.Name = "txtFile";
            txtFile.ReadOnly = true;
            txtFile.Size = new Size(482, 22);
            txtFile.TabIndex = 1;
            // 
            // txtSql
            // 
            txtSql.Location = new Point(30, 91);
            txtSql.Multiline = true;
            txtSql.Name = "txtSql";
            txtSql.ReadOnly = true;
            txtSql.ScrollBars = ScrollBars.Both;
            txtSql.Size = new Size(949, 390);
            txtSql.TabIndex = 2;
            // 
            // Button1
            // 
            Button1.Location = new Point(875, 548);
            Button1.Name = "Button1";
            Button1.Size = new Size(104, 38);
            Button1.TabIndex = 3;
            Button1.Text = "Close";
            Button1.UseVisualStyleBackColor = true;
            // 
            // Button2
            // 
            Button2.Location = new Point(30, 548);
            Button2.Name = "Button2";
            Button2.Size = new Size(104, 38);
            Button2.TabIndex = 4;
            Button2.Text = "Reapply";
            Button2.UseVisualStyleBackColor = true;
            // 
            // SB
            // 
            SB.Location = new Point(30, 501);
            SB.Name = "SB";
            SB.ReadOnly = true;
            SB.Size = new Size(949, 22);
            SB.TabIndex = 5;
            // 
            // frmDBUpdates
            // 
            AutoScaleDimensions = new SizeF(8.0f, 16.0f);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(991, 598);
            Controls.Add(SB);
            Controls.Add(Button2);
            Controls.Add(Button1);
            Controls.Add(txtSql);
            Controls.Add(txtFile);
            Controls.Add(lblFile);
            Name = "frmDBUpdates";
            Text = "frmDBUpdates";
            Load += new EventHandler(frmDBUpdates_Load);
            ResumeLayout(false);
            PerformLayout();
        }

        internal Label lblFile;
        internal TextBox txtFile;
        internal TextBox txtSql;
        internal Button Button1;
        internal Button Button2;
        internal TextBox SB;
    }
}