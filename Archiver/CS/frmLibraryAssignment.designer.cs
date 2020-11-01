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
	[global::Microsoft.VisualBasic.CompilerServices.DesignerGenerated()]public partial class frmLibraryAssignment : System.Windows.Forms.Form
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
			this.components = new System.ComponentModel.Container();
			base.Load += new System.EventHandler(frmLibraryAssignment_Load);
			this.Resize += new System.EventHandler(frmLibraryAssignment_Resize);
			this.cbLibrary = new System.Windows.Forms.ComboBox();
			this.btnAssign = new System.Windows.Forms.Button();
			this.btnAssign.Click += new System.EventHandler(this.btnAssign_Click);
			this.txtFolderName = new System.Windows.Forms.TextBox();
			this.SB = new System.Windows.Forms.TextBox();
			this.btnRemove = new System.Windows.Forms.Button();
			this.btnRemove.Click += new System.EventHandler(this.btnRemove_Click);
			this.cbAssignedLibs = new System.Windows.Forms.ComboBox();
			this.txtFolderID = new System.Windows.Forms.TextBox();
			this.TT = new System.Windows.Forms.ToolTip(this.components);
			this.Timer1 = new System.Windows.Forms.Timer(this.components);
			this.Label1 = new System.Windows.Forms.Label();
			this.Label2 = new System.Windows.Forms.Label();
			this.SuspendLayout();
			//
			//cbLibrary
			//
			this.cbLibrary.FormattingEnabled = true;
			this.cbLibrary.Location = new System.Drawing.Point(12, 23);
			this.cbLibrary.Name = "cbLibrary";
			this.cbLibrary.Size = new System.Drawing.Size(232, 21);
			this.cbLibrary.TabIndex = 0;
			//
			//btnAssign
			//
			this.btnAssign.Location = new System.Drawing.Point(12, 50);
			this.btnAssign.Name = "btnAssign";
			this.btnAssign.Size = new System.Drawing.Size(106, 21);
			this.btnAssign.TabIndex = 1;
			this.btnAssign.Text = "Assign";
			this.btnAssign.UseVisualStyleBackColor = true;
			//
			//txtFolderName
			//
			this.txtFolderName.Enabled = false;
			this.txtFolderName.Location = new System.Drawing.Point(11, 87);
			this.txtFolderName.Name = "txtFolderName";
			this.txtFolderName.Size = new System.Drawing.Size(471, 20);
			this.txtFolderName.TabIndex = 2;
			//
			//SB
			//
			this.SB.BackColor = System.Drawing.Color.FromArgb(System.Convert.ToInt32((byte) (255)), System.Convert.ToInt32((byte) (255)), System.Convert.ToInt32((byte) (192)));
			this.SB.Enabled = false;
			this.SB.Location = new System.Drawing.Point(11, 113);
			this.SB.Name = "SB";
			this.SB.Size = new System.Drawing.Size(471, 20);
			this.SB.TabIndex = 3;
			//
			//btnRemove
			//
			this.btnRemove.Location = new System.Drawing.Point(376, 50);
			this.btnRemove.Name = "btnRemove";
			this.btnRemove.Size = new System.Drawing.Size(106, 21);
			this.btnRemove.TabIndex = 4;
			this.btnRemove.Text = "Remove";
			this.btnRemove.UseVisualStyleBackColor = true;
			//
			//cbAssignedLibs
			//
			this.cbAssignedLibs.FormattingEnabled = true;
			this.cbAssignedLibs.Location = new System.Drawing.Point(250, 23);
			this.cbAssignedLibs.Name = "cbAssignedLibs";
			this.cbAssignedLibs.Size = new System.Drawing.Size(232, 21);
			this.cbAssignedLibs.TabIndex = 5;
			//
			//txtFolderID
			//
			this.txtFolderID.Location = new System.Drawing.Point(12, 139);
			this.txtFolderID.Name = "txtFolderID";
			this.txtFolderID.Size = new System.Drawing.Size(470, 20);
			this.txtFolderID.TabIndex = 6;
			//
			//TT
			//
			this.TT.ToolTipTitle = "Use this form to assign a LIBRARY to a directory.";
			//
			//Timer1
			//
			this.Timer1.Enabled = true;
			this.Timer1.Interval = 5000;
			//
			//Label1
			//
			this.Label1.AutoSize = true;
			this.Label1.BackColor = System.Drawing.Color.Transparent;
			this.Label1.Font = new System.Drawing.Font("Microsoft Sans Serif", (float) (9.0F), System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, (byte) (0));
			this.Label1.ForeColor = System.Drawing.Color.WhiteSmoke;
			this.Label1.Location = new System.Drawing.Point(12, 5);
			this.Label1.Name = "Label1";
			this.Label1.Size = new System.Drawing.Size(107, 15);
			this.Label1.TabIndex = 7;
			this.Label1.Text = "Available Libraries";
			//
			//Label2
			//
			this.Label2.AutoSize = true;
			this.Label2.BackColor = System.Drawing.Color.Transparent;
			this.Label2.Font = new System.Drawing.Font("Microsoft Sans Serif", (float) (9.0F), System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, (byte) (0));
			this.Label2.ForeColor = System.Drawing.Color.WhiteSmoke;
			this.Label2.Location = new System.Drawing.Point(247, 5);
			this.Label2.Name = "Label2";
			this.Label2.Size = new System.Drawing.Size(108, 15);
			this.Label2.TabIndex = 8;
			this.Label2.Text = "Assigned Libraries";
			//
			//frmLibraryAssignment
			//
			this.AutoScaleDimensions = new System.Drawing.SizeF((float) (6.0F), (float) (13.0F));
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch;
			this.ClientSize = new System.Drawing.Size(491, 169);
			this.Controls.Add(this.Label2);
			this.Controls.Add(this.Label1);
			this.Controls.Add(this.txtFolderID);
			this.Controls.Add(this.cbAssignedLibs);
			this.Controls.Add(this.btnRemove);
			this.Controls.Add(this.SB);
			this.Controls.Add(this.txtFolderName);
			this.Controls.Add(this.btnAssign);
			this.Controls.Add(this.cbLibrary);
			this.MaximizeBox = false;
			this.MinimizeBox = false;
			this.Name = "frmLibraryAssignment";
			this.Text = "Library Assignment Form";
			this.ResumeLayout(false);
			this.PerformLayout();
			
		}
		internal System.Windows.Forms.ComboBox cbLibrary;
		internal System.Windows.Forms.Button btnAssign;
		internal System.Windows.Forms.TextBox txtFolderName;
		internal System.Windows.Forms.TextBox SB;
		internal System.Windows.Forms.Button btnRemove;
		internal System.Windows.Forms.ComboBox cbAssignedLibs;
		internal System.Windows.Forms.TextBox txtFolderID;
		internal System.Windows.Forms.ToolTip TT;
		internal System.Windows.Forms.Timer Timer1;
		internal System.Windows.Forms.Label Label1;
		internal System.Windows.Forms.Label Label2;
	}
	
}
