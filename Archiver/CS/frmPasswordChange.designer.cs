// VBConversions Note: VB project level imports
using System.Collections.Generic;
using System;
using System.Drawing;
using System.Linq;
using System.Diagnostics;
using System.Data;
using Microsoft.VisualBasic;
using MODI;
using System.Xml.Linq;
using System.Collections;
using System.Windows.Forms;
// End of VB project level imports


namespace EcmArchiveClcSetup
{
	[global::Microsoft.VisualBasic.CompilerServices.DesignerGenerated()]public partial class frmPasswordChange : System.Windows.Forms.Form
	{
		
		//Form overrides dispose to clean up the component list.
		[System.Diagnostics.DebuggerNonUserCode()]protected override void Dispose(bool disposing)
		{
			try
			{
				if (disposing && components != null)
				{
					components.Dispose();
				}
			}
			finally
			{
				base.Dispose(disposing);
			}
		}
		
		//Required by the Windows Form Designer
		private System.ComponentModel.Container components = null;
		
		//NOTE: The following procedure is required by the Windows Form Designer
		//It can be modified using the Windows Form Designer.
		//Do not modify it using the code editor.
		[System.Diagnostics.DebuggerStepThrough()]private void InitializeComponent()
		{
			this.Label1 = new System.Windows.Forms.Label();
			this.Label2 = new System.Windows.Forms.Label();
			this.txtPw1 = new System.Windows.Forms.TextBox();
			this.txtPw2 = new System.Windows.Forms.TextBox();
			this.btnEnter = new System.Windows.Forms.Button();
			this.btnEnter.Click += new System.EventHandler(this.btnEnter_Click);
			this.SB = new System.Windows.Forms.TextBox();
			this.SuspendLayout();
			//
			//Label1
			//
			this.Label1.AutoSize = true;
			this.Label1.Location = new System.Drawing.Point(18, 19);
			this.Label1.Name = "Label1";
			this.Label1.Size = new System.Drawing.Size(100, 17);
			this.Label1.TabIndex = 0;
			this.Label1.Text = "New Password";
			//
			//Label2
			//
			this.Label2.AutoSize = true;
			this.Label2.Location = new System.Drawing.Point(18, 90);
			this.Label2.Name = "Label2";
			this.Label2.Size = new System.Drawing.Size(118, 17);
			this.Label2.TabIndex = 1;
			this.Label2.Text = "Retype Password";
			//
			//txtPw1
			//
			this.txtPw1.Location = new System.Drawing.Point(18, 44);
			this.txtPw1.Name = "txtPw1";
			this.txtPw1.PasswordChar = global::Microsoft.VisualBasic.Strings.ChrW(42);
			this.txtPw1.Size = new System.Drawing.Size(241, 22);
			this.txtPw1.TabIndex = 2;
			//
			//txtPw2
			//
			this.txtPw2.Location = new System.Drawing.Point(18, 116);
			this.txtPw2.Name = "txtPw2";
			this.txtPw2.PasswordChar = global::Microsoft.VisualBasic.Strings.ChrW(42);
			this.txtPw2.Size = new System.Drawing.Size(241, 22);
			this.txtPw2.TabIndex = 3;
			//
			//btnEnter
			//
			this.btnEnter.Location = new System.Drawing.Point(79, 161);
			this.btnEnter.Name = "btnEnter";
			this.btnEnter.Size = new System.Drawing.Size(116, 41);
			this.btnEnter.TabIndex = 4;
			this.btnEnter.Text = "Accept";
			this.btnEnter.UseVisualStyleBackColor = true;
			//
			//SB
			//
			this.SB.BackColor = System.Drawing.Color.FromArgb(System.Convert.ToInt32((byte) (255)), System.Convert.ToInt32((byte) (255)), System.Convert.ToInt32((byte) (192)));
			this.SB.Enabled = false;
			this.SB.Location = new System.Drawing.Point(18, 221);
			this.SB.Name = "SB";
			this.SB.Size = new System.Drawing.Size(241, 22);
			this.SB.TabIndex = 5;
			//
			//frmPasswordChange
			//
			this.AutoScaleDimensions = new System.Drawing.SizeF((float) (8.0F), (float) (16.0F));
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.ClientSize = new System.Drawing.Size(282, 255);
			this.Controls.Add(this.SB);
			this.Controls.Add(this.btnEnter);
			this.Controls.Add(this.txtPw2);
			this.Controls.Add(this.txtPw1);
			this.Controls.Add(this.Label2);
			this.Controls.Add(this.Label1);
			this.Name = "frmPasswordChange";
			this.Text = "Password Entry Form  (frmPasswordChange)";
			this.TopMost = true;
			this.ResumeLayout(false);
			this.PerformLayout();
			
		}
		internal System.Windows.Forms.Label Label1;
		internal System.Windows.Forms.Label Label2;
		internal System.Windows.Forms.TextBox txtPw1;
		internal System.Windows.Forms.TextBox txtPw2;
		internal System.Windows.Forms.Button btnEnter;
		internal System.Windows.Forms.TextBox SB;
	}
	
}
