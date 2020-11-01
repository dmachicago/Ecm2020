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
	[global::Microsoft.VisualBasic.CompilerServices.DesignerGenerated()]public partial class frmRetentionCode : System.Windows.Forms.Form
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
			this.dgRetention = new System.Windows.Forms.DataGridView();
			base.Load += new System.EventHandler(frmRetentionCode_Load);
			this.dgRetention.SelectionChanged += new System.EventHandler(this.dgRetention_SelectionChanged);
			this.txtRetentionCode = new System.Windows.Forms.TextBox();
			this.Label1 = new System.Windows.Forms.Label();
			this.txtDesc = new System.Windows.Forms.TextBox();
			this.Label2 = new System.Windows.Forms.Label();
			this.nbrRetentionUnits = new System.Windows.Forms.NumericUpDown();
			this.cbRetentionPeriod = new System.Windows.Forms.ComboBox();
			this.Label3 = new System.Windows.Forms.Label();
			this.Label4 = new System.Windows.Forms.Label();
			this.Label5 = new System.Windows.Forms.Label();
			this.nbrDaysWarning = new System.Windows.Forms.NumericUpDown();
			this.ckResponseRequired = new System.Windows.Forms.CheckBox();
			this.Label6 = new System.Windows.Forms.Label();
			this.txtManagerID = new System.Windows.Forms.TextBox();
			this.SB = new System.Windows.Forms.TextBox();
			this.btnSave = new System.Windows.Forms.Button();
			this.btnSave.Click += new System.EventHandler(this.btnSave_Click);
			this.btnDelete = new System.Windows.Forms.Button();
			this.btnDelete.Click += new System.EventHandler(this.btnDelete_Click);
			this.Label7 = new System.Windows.Forms.Label();
			this.cbRetentionAction = new System.Windows.Forms.ComboBox();
			((System.ComponentModel.ISupportInitialize) this.dgRetention).BeginInit();
			((System.ComponentModel.ISupportInitialize) this.nbrRetentionUnits).BeginInit();
			((System.ComponentModel.ISupportInitialize) this.nbrDaysWarning).BeginInit();
			this.SuspendLayout();
			//
			//dgRetention
			//
			this.dgRetention.AllowUserToAddRows = false;
			this.dgRetention.AllowUserToDeleteRows = false;
			this.dgRetention.AllowUserToOrderColumns = true;
			this.dgRetention.Anchor = (System.Windows.Forms.AnchorStyles) (((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right);
			this.dgRetention.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
			this.dgRetention.Location = new System.Drawing.Point(12, 318);
			this.dgRetention.Name = "dgRetention";
			this.dgRetention.Size = new System.Drawing.Size(759, 236);
			this.dgRetention.TabIndex = 99;
			//
			//txtRetentionCode
			//
			this.txtRetentionCode.BackColor = System.Drawing.Color.Gainsboro;
			this.txtRetentionCode.Location = new System.Drawing.Point(12, 42);
			this.txtRetentionCode.Name = "txtRetentionCode";
			this.txtRetentionCode.Size = new System.Drawing.Size(246, 20);
			this.txtRetentionCode.TabIndex = 1;
			//
			//Label1
			//
			this.Label1.AutoSize = true;
			this.Label1.Location = new System.Drawing.Point(12, 24);
			this.Label1.Name = "Label1";
			this.Label1.Size = new System.Drawing.Size(81, 13);
			this.Label1.TabIndex = 2;
			this.Label1.Text = "Retention Code";
			//
			//txtDesc
			//
			this.txtDesc.Anchor = (System.Windows.Forms.AnchorStyles) ((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right);
			this.txtDesc.BackColor = System.Drawing.Color.Gainsboro;
			this.txtDesc.Location = new System.Drawing.Point(15, 78);
			this.txtDesc.Multiline = true;
			this.txtDesc.Name = "txtDesc";
			this.txtDesc.Size = new System.Drawing.Size(548, 221);
			this.txtDesc.TabIndex = 3;
			//
			//Label2
			//
			this.Label2.AutoSize = true;
			this.Label2.Location = new System.Drawing.Point(12, 62);
			this.Label2.Name = "Label2";
			this.Label2.Size = new System.Drawing.Size(107, 13);
			this.Label2.TabIndex = 4;
			this.Label2.Text = "Retention description";
			//
			//nbrRetentionUnits
			//
			this.nbrRetentionUnits.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right);
			this.nbrRetentionUnits.Location = new System.Drawing.Point(591, 86);
			this.nbrRetentionUnits.Name = "nbrRetentionUnits";
			this.nbrRetentionUnits.Size = new System.Drawing.Size(94, 20);
			this.nbrRetentionUnits.TabIndex = 5;
			this.nbrRetentionUnits.Value = new decimal(new int[] {10, 0, 0, 0});
			//
			//cbRetentionPeriod
			//
			this.cbRetentionPeriod.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right);
			this.cbRetentionPeriod.FormattingEnabled = true;
			this.cbRetentionPeriod.Items.AddRange(new object[] {"Year", "Month", "Day"});
			this.cbRetentionPeriod.Location = new System.Drawing.Point(591, 42);
			this.cbRetentionPeriod.Name = "cbRetentionPeriod";
			this.cbRetentionPeriod.Size = new System.Drawing.Size(91, 21);
			this.cbRetentionPeriod.TabIndex = 4;
			this.cbRetentionPeriod.Text = "Year";
			//
			//Label3
			//
			this.Label3.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right);
			this.Label3.AutoSize = true;
			this.Label3.Location = new System.Drawing.Point(591, 68);
			this.Label3.Name = "Label3";
			this.Label3.Size = new System.Drawing.Size(89, 13);
			this.Label3.TabIndex = 7;
			this.Label3.Text = "Retention Length";
			//
			//Label4
			//
			this.Label4.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right);
			this.Label4.AutoSize = true;
			this.Label4.Location = new System.Drawing.Point(591, 24);
			this.Label4.Name = "Label4";
			this.Label4.Size = new System.Drawing.Size(86, 13);
			this.Label4.TabIndex = 8;
			this.Label4.Text = "Retention Period";
			//
			//Label5
			//
			this.Label5.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right);
			this.Label5.AutoSize = true;
			this.Label5.Location = new System.Drawing.Point(591, 111);
			this.Label5.Name = "Label5";
			this.Label5.Size = new System.Drawing.Size(74, 13);
			this.Label5.TabIndex = 10;
			this.Label5.Text = "Days Warning";
			//
			//nbrDaysWarning
			//
			this.nbrDaysWarning.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right);
			this.nbrDaysWarning.Location = new System.Drawing.Point(591, 129);
			this.nbrDaysWarning.Name = "nbrDaysWarning";
			this.nbrDaysWarning.Size = new System.Drawing.Size(94, 20);
			this.nbrDaysWarning.TabIndex = 6;
			this.nbrDaysWarning.Value = new decimal(new int[] {30, 0, 0, 0});
			//
			//ckResponseRequired
			//
			this.ckResponseRequired.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right);
			this.ckResponseRequired.AutoSize = true;
			this.ckResponseRequired.Location = new System.Drawing.Point(591, 198);
			this.ckResponseRequired.Name = "ckResponseRequired";
			this.ckResponseRequired.Size = new System.Drawing.Size(120, 17);
			this.ckResponseRequired.TabIndex = 7;
			this.ckResponseRequired.Text = "Response Required";
			this.ckResponseRequired.UseVisualStyleBackColor = true;
			//
			//Label6
			//
			this.Label6.AutoSize = true;
			this.Label6.Location = new System.Drawing.Point(314, 24);
			this.Label6.Name = "Label6";
			this.Label6.Size = new System.Drawing.Size(133, 13);
			this.Label6.TabIndex = 14;
			this.Label6.Text = "Manager Notification Email";
			//
			//txtManagerID
			//
			this.txtManagerID.BackColor = System.Drawing.Color.Gainsboro;
			this.txtManagerID.Location = new System.Drawing.Point(314, 42);
			this.txtManagerID.Name = "txtManagerID";
			this.txtManagerID.Size = new System.Drawing.Size(246, 20);
			this.txtManagerID.TabIndex = 2;
			//
			//SB
			//
			this.SB.Location = new System.Drawing.Point(12, 561);
			this.SB.Name = "SB";
			this.SB.Size = new System.Drawing.Size(759, 20);
			this.SB.TabIndex = 99999;
			//
			//btnSave
			//
			this.btnSave.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right);
			this.btnSave.Location = new System.Drawing.Point(591, 248);
			this.btnSave.Name = "btnSave";
			this.btnSave.Size = new System.Drawing.Size(73, 50);
			this.btnSave.TabIndex = 100001;
			this.btnSave.Text = "Save";
			this.btnSave.UseVisualStyleBackColor = true;
			//
			//btnDelete
			//
			this.btnDelete.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right);
			this.btnDelete.Location = new System.Drawing.Point(698, 248);
			this.btnDelete.Name = "btnDelete";
			this.btnDelete.Size = new System.Drawing.Size(73, 51);
			this.btnDelete.TabIndex = 100002;
			this.btnDelete.Text = "Delete";
			this.btnDelete.UseVisualStyleBackColor = true;
			//
			//Label7
			//
			this.Label7.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right);
			this.Label7.AutoSize = true;
			this.Label7.Location = new System.Drawing.Point(591, 154);
			this.Label7.Name = "Label7";
			this.Label7.Size = new System.Drawing.Size(86, 13);
			this.Label7.TabIndex = 100004;
			this.Label7.Text = "Retention Action";
			//
			//cbRetentionAction
			//
			this.cbRetentionAction.Anchor = (System.Windows.Forms.AnchorStyles) (System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right);
			this.cbRetentionAction.FormattingEnabled = true;
			this.cbRetentionAction.Items.AddRange(new object[] {"Delete", "Move"});
			this.cbRetentionAction.Location = new System.Drawing.Point(591, 172);
			this.cbRetentionAction.Name = "cbRetentionAction";
			this.cbRetentionAction.Size = new System.Drawing.Size(91, 21);
			this.cbRetentionAction.TabIndex = 100003;
			this.cbRetentionAction.Text = "Delete";
			//
			//frmRetentionCode
			//
			this.AutoScaleDimensions = new System.Drawing.SizeF((float) (6.0F), (float) (13.0F));
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.BackColor = System.Drawing.Color.LightGray;
			this.ClientSize = new System.Drawing.Size(783, 593);
			this.Controls.Add(this.Label7);
			this.Controls.Add(this.cbRetentionAction);
			this.Controls.Add(this.btnDelete);
			this.Controls.Add(this.btnSave);
			this.Controls.Add(this.SB);
			this.Controls.Add(this.Label6);
			this.Controls.Add(this.txtManagerID);
			this.Controls.Add(this.ckResponseRequired);
			this.Controls.Add(this.Label5);
			this.Controls.Add(this.nbrDaysWarning);
			this.Controls.Add(this.Label4);
			this.Controls.Add(this.Label3);
			this.Controls.Add(this.cbRetentionPeriod);
			this.Controls.Add(this.nbrRetentionUnits);
			this.Controls.Add(this.Label2);
			this.Controls.Add(this.txtDesc);
			this.Controls.Add(this.Label1);
			this.Controls.Add(this.txtRetentionCode);
			this.Controls.Add(this.dgRetention);
			this.Name = "frmRetentionCode";
			this.Text = "Retention Rules     (frmRetentionCode)";
			((System.ComponentModel.ISupportInitialize) this.dgRetention).EndInit();
			((System.ComponentModel.ISupportInitialize) this.nbrRetentionUnits).EndInit();
			((System.ComponentModel.ISupportInitialize) this.nbrDaysWarning).EndInit();
			this.ResumeLayout(false);
			this.PerformLayout();
			
		}
		internal System.Windows.Forms.DataGridView dgRetention;
		internal System.Windows.Forms.TextBox txtRetentionCode;
		internal System.Windows.Forms.Label Label1;
		internal System.Windows.Forms.TextBox txtDesc;
		internal System.Windows.Forms.Label Label2;
		internal System.Windows.Forms.NumericUpDown nbrRetentionUnits;
		internal System.Windows.Forms.ComboBox cbRetentionPeriod;
		internal System.Windows.Forms.Label Label3;
		internal System.Windows.Forms.Label Label4;
		internal System.Windows.Forms.Label Label5;
		internal System.Windows.Forms.NumericUpDown nbrDaysWarning;
		internal System.Windows.Forms.CheckBox ckResponseRequired;
		internal System.Windows.Forms.Label Label6;
		internal System.Windows.Forms.TextBox txtManagerID;
		internal System.Windows.Forms.TextBox SB;
		internal System.Windows.Forms.Button btnSave;
		internal System.Windows.Forms.Button btnDelete;
		internal System.Windows.Forms.Label Label7;
		internal System.Windows.Forms.ComboBox cbRetentionAction;
	}
	
}
