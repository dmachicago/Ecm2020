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
	[global::Microsoft.VisualBasic.CompilerServices.DesignerGenerated()]public partial class frmImpersonate : System.Windows.Forms.Form
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
			this.txtUserID = new System.Windows.Forms.TextBox();
			this.Label1 = new System.Windows.Forms.Label();
			this.Label2 = new System.Windows.Forms.Label();
			this.txtPw1 = new System.Windows.Forms.TextBox();
			this.Label3 = new System.Windows.Forms.Label();
			this.txtPw2 = new System.Windows.Forms.TextBox();
			this.Label4 = new System.Windows.Forms.Label();
			this.btnAssign = new System.Windows.Forms.Button();
			this.btnAssign.Click += new System.EventHandler(this.btnAssign_Click);
			this.btnCancel = new System.Windows.Forms.Button();
			this.btnCancel.Click += new System.EventHandler(this.btnCancel_Click);
			this.btnRemoveAssignment = new System.Windows.Forms.Button();
			this.btnRemoveAssignment.Click += new System.EventHandler(this.btnRemoveAssignment_Click);
			this.SuspendLayout();
			//
			//txtUserID
			//
			this.txtUserID.Location = new System.Drawing.Point(3, 35);
			this.txtUserID.Name = "txtUserID";
			this.txtUserID.Size = new System.Drawing.Size(269, 20);
			this.txtUserID.TabIndex = 0;
			//
			//Label1
			//
			this.Label1.AutoSize = true;
			this.Label1.Location = new System.Drawing.Point(3, 19);
			this.Label1.Name = "Label1";
			this.Label1.Size = new System.Drawing.Size(51, 13);
			this.Label1.TabIndex = 99;
			this.Label1.Text = "Login As:";
			//
			//Label2
			//
			this.Label2.AutoSize = true;
			this.Label2.Location = new System.Drawing.Point(3, 68);
			this.Label2.Name = "Label2";
			this.Label2.Size = new System.Drawing.Size(56, 13);
			this.Label2.TabIndex = 99;
			this.Label2.Text = "Password:";
			//
			//txtPw1
			//
			this.txtPw1.Location = new System.Drawing.Point(3, 84);
			this.txtPw1.Name = "txtPw1";
			this.txtPw1.PasswordChar = global::Microsoft.VisualBasic.Strings.ChrW(42);
			this.txtPw1.Size = new System.Drawing.Size(226, 20);
			this.txtPw1.TabIndex = 1;
			//
			//Label3
			//
			this.Label3.AutoSize = true;
			this.Label3.Location = new System.Drawing.Point(3, 113);
			this.Label3.Name = "Label3";
			this.Label3.Size = new System.Drawing.Size(97, 13);
			this.Label3.TabIndex = 99;
			this.Label3.Text = "Re-enter Password";
			//
			//txtPw2
			//
			this.txtPw2.Location = new System.Drawing.Point(3, 129);
			this.txtPw2.Name = "txtPw2";
			this.txtPw2.PasswordChar = global::Microsoft.VisualBasic.Strings.ChrW(42);
			this.txtPw2.Size = new System.Drawing.Size(226, 20);
			this.txtPw2.TabIndex = 2;
			//
			//Label4
			//
			this.Label4.AutoSize = true;
			this.Label4.Location = new System.Drawing.Point(3, 163);
			this.Label4.Name = "Label4";
			this.Label4.Size = new System.Drawing.Size(210, 13);
			this.Label4.TabIndex = 99;
			this.Label4.Text = "Note: This login is set only for this machine.";
			//
			//btnAssign
			//
			this.btnAssign.Location = new System.Drawing.Point(292, 33);
			this.btnAssign.Name = "btnAssign";
			this.btnAssign.Size = new System.Drawing.Size(109, 25);
			this.btnAssign.TabIndex = 4;
			this.btnAssign.Text = "Assign";
			this.btnAssign.UseVisualStyleBackColor = true;
			//
			//btnCancel
			//
			this.btnCancel.Location = new System.Drawing.Point(292, 127);
			this.btnCancel.Name = "btnCancel";
			this.btnCancel.Size = new System.Drawing.Size(109, 25);
			this.btnCancel.TabIndex = 3;
			this.btnCancel.Text = "Cancel";
			this.btnCancel.UseVisualStyleBackColor = true;
			//
			//btnRemoveAssignment
			//
			this.btnRemoveAssignment.Location = new System.Drawing.Point(292, 82);
			this.btnRemoveAssignment.Name = "btnRemoveAssignment";
			this.btnRemoveAssignment.Size = new System.Drawing.Size(109, 25);
			this.btnRemoveAssignment.TabIndex = 100;
			this.btnRemoveAssignment.Text = "Remove";
			this.btnRemoveAssignment.UseVisualStyleBackColor = true;
			//
			//frmImpersonate
			//
			this.AutoScaleDimensions = new System.Drawing.SizeF((float) (6.0F), (float) (13.0F));
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.ClientSize = new System.Drawing.Size(413, 188);
			this.Controls.Add(this.btnRemoveAssignment);
			this.Controls.Add(this.btnCancel);
			this.Controls.Add(this.btnAssign);
			this.Controls.Add(this.Label4);
			this.Controls.Add(this.Label3);
			this.Controls.Add(this.txtPw2);
			this.Controls.Add(this.Label2);
			this.Controls.Add(this.txtPw1);
			this.Controls.Add(this.Label1);
			this.Controls.Add(this.txtUserID);
			this.Name = "frmImpersonate";
			this.Text = "Auto-Launch Login   (frmImpersonate)";
			this.ResumeLayout(false);
			this.PerformLayout();
			
		}
		internal System.Windows.Forms.TextBox txtUserID;
		internal System.Windows.Forms.Label Label1;
		internal System.Windows.Forms.Label Label2;
		internal System.Windows.Forms.TextBox txtPw1;
		internal System.Windows.Forms.Label Label3;
		internal System.Windows.Forms.TextBox txtPw2;
		internal System.Windows.Forms.Label Label4;
		internal System.Windows.Forms.Button btnAssign;
		internal System.Windows.Forms.Button btnCancel;
		internal System.Windows.Forms.Button btnRemoveAssignment;
	}
	
}
