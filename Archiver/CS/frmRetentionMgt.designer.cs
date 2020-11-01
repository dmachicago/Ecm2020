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
	[global::Microsoft.VisualBasic.CompilerServices.DesignerGenerated()]public partial class frmRetentionMgt : System.Windows.Forms.Form
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
			base.Load += new System.EventHandler(frmRetentionMgt_Load);
			this.Resize += new System.EventHandler(frmRetentionMgt_Resize);
			this.GroupBox1 = new System.Windows.Forms.GroupBox();
			this.rbEmails = new System.Windows.Forms.RadioButton();
			this.rbEmails.CheckedChanged += new System.EventHandler(this.rbEmails_CheckedChanged);
			this.rbContent = new System.Windows.Forms.RadioButton();
			this.rbContent.CheckedChanged += new System.EventHandler(this.rbContent_CheckedChanged);
			this.Label1 = new System.Windows.Forms.Label();
			this.txtExpireUnit = new System.Windows.Forms.TextBox();
			this.cbExpireUnits = new System.Windows.Forms.ComboBox();
			this.Label2 = new System.Windows.Forms.Label();
			this.btnExecuteExpire = new System.Windows.Forms.Button();
			this.btnExecuteExpire.Click += new System.EventHandler(this.btnExecuteExpire_Click);
			this.Label3 = new System.Windows.Forms.Label();
			this.btnSelectExpired = new System.Windows.Forms.Button();
			this.btnSelectExpired.Click += new System.EventHandler(this.btnSelectExpired_Click);
			this.btnExecuteAge = new System.Windows.Forms.Button();
			this.btnExecuteAge.Click += new System.EventHandler(this.btnExecuteAge_Click);
			this.cbAgeUnits = new System.Windows.Forms.ComboBox();
			this.txtAgeUnit = new System.Windows.Forms.TextBox();
			this.Label5 = new System.Windows.Forms.Label();
			this.dgItems = new System.Windows.Forms.DataGridView();
			this.SB = new System.Windows.Forms.TextBox();
			this.btnDelete = new System.Windows.Forms.Button();
			this.btnDelete.Click += new System.EventHandler(this.btnDelete_Click);
			this.btnMove = new System.Windows.Forms.Button();
			this.btnMove.Click += new System.EventHandler(this.btnMove_Click);
			this.TT = new System.Windows.Forms.ToolTip(this.components);
			this.TT.Popup += new System.Windows.Forms.PopupEventHandler(this.ToolTip1_Popup);
			this.PB = new System.Windows.Forms.ProgressBar();
			this.dtExtendDate = new System.Windows.Forms.DateTimePicker();
			this.Label4 = new System.Windows.Forms.Label();
			this.btnExtend = new System.Windows.Forms.Button();
			this.btnExtend.Click += new System.EventHandler(this.btnExtend_Click);
			this.Timer1 = new System.Windows.Forms.Timer(this.components);
			this.Timer1.Tick += new System.EventHandler(this.Timer1_Tick);
			this.btnRecall = new System.Windows.Forms.Button();
			this.btnRecall.Click += new System.EventHandler(this.btnRecall_Click);
			this.HelpProvider1 = new System.Windows.Forms.HelpProvider();
			this.GroupBox1.SuspendLayout();
			((System.ComponentModel.ISupportInitialize) this.dgItems).BeginInit();
			this.SuspendLayout();
			//
			//GroupBox1
			//
			this.GroupBox1.Controls.Add(this.rbEmails);
			this.GroupBox1.Controls.Add(this.rbContent);
			this.GroupBox1.Location = new System.Drawing.Point(12, 12);
			this.GroupBox1.Name = "GroupBox1";
			this.GroupBox1.Size = new System.Drawing.Size(210, 88);
			this.GroupBox1.TabIndex = 0;
			this.GroupBox1.TabStop = false;
			this.GroupBox1.Text = "Select Group To Manage";
			//
			//rbEmails
			//
			this.rbEmails.AutoSize = true;
			this.rbEmails.Location = new System.Drawing.Point(20, 48);
			this.rbEmails.Name = "rbEmails";
			this.rbEmails.Size = new System.Drawing.Size(55, 17);
			this.rbEmails.TabIndex = 1;
			this.rbEmails.TabStop = true;
			this.rbEmails.Text = "Emails";
			this.rbEmails.UseVisualStyleBackColor = true;
			//
			//rbContent
			//
			this.rbContent.AutoSize = true;
			this.rbContent.Location = new System.Drawing.Point(20, 25);
			this.rbContent.Name = "rbContent";
			this.rbContent.Size = new System.Drawing.Size(127, 17);
			this.rbContent.TabIndex = 0;
			this.rbContent.TabStop = true;
			this.rbContent.Text = "Content / Documents";
			this.rbContent.UseVisualStyleBackColor = true;
			//
			//Label1
			//
			this.Label1.AutoSize = true;
			this.Label1.Location = new System.Drawing.Point(12, 121);
			this.Label1.Name = "Label1";
			this.Label1.Size = new System.Drawing.Size(107, 13);
			this.Label1.TabIndex = 1;
			this.Label1.Text = "Select all items within";
			//
			//txtExpireUnit
			//
			this.txtExpireUnit.Location = new System.Drawing.Point(12, 143);
			this.txtExpireUnit.Name = "txtExpireUnit";
			this.txtExpireUnit.Size = new System.Drawing.Size(52, 20);
			this.txtExpireUnit.TabIndex = 2;
			//
			//cbExpireUnits
			//
			this.cbExpireUnits.FormattingEnabled = true;
			this.cbExpireUnits.Items.AddRange(new object[] {"Months", "Days", "Years"});
			this.cbExpireUnits.Location = new System.Drawing.Point(88, 142);
			this.cbExpireUnits.Name = "cbExpireUnits";
			this.cbExpireUnits.Size = new System.Drawing.Size(97, 21);
			this.cbExpireUnits.TabIndex = 3;
			this.cbExpireUnits.Text = "Months";
			//
			//Label2
			//
			this.Label2.AutoSize = true;
			this.Label2.Location = new System.Drawing.Point(9, 177);
			this.Label2.Name = "Label2";
			this.Label2.Size = new System.Drawing.Size(64, 13);
			this.Label2.TabIndex = 4;
			this.Label2.Text = "of expiration";
			//
			//btnExecuteExpire
			//
			this.btnExecuteExpire.Location = new System.Drawing.Point(88, 177);
			this.btnExecuteExpire.Name = "btnExecuteExpire";
			this.btnExecuteExpire.Size = new System.Drawing.Size(91, 25);
			this.btnExecuteExpire.TabIndex = 5;
			this.btnExecuteExpire.Text = "Execute";
			this.btnExecuteExpire.UseVisualStyleBackColor = true;
			//
			//Label3
			//
			this.Label3.AutoSize = true;
			this.Label3.Location = new System.Drawing.Point(19, 330);
			this.Label3.Name = "Label3";
			this.Label3.Size = new System.Drawing.Size(114, 13);
			this.Label3.TabIndex = 6;
			this.Label3.Text = "Select all expired items";
			//
			//btnSelectExpired
			//
			this.btnSelectExpired.Location = new System.Drawing.Point(22, 346);
			this.btnSelectExpired.Name = "btnSelectExpired";
			this.btnSelectExpired.Size = new System.Drawing.Size(91, 25);
			this.btnSelectExpired.TabIndex = 7;
			this.btnSelectExpired.Text = "Execute";
			this.btnSelectExpired.UseVisualStyleBackColor = true;
			//
			//btnExecuteAge
			//
			this.btnExecuteAge.Location = new System.Drawing.Point(94, 280);
			this.btnExecuteAge.Name = "btnExecuteAge";
			this.btnExecuteAge.Size = new System.Drawing.Size(91, 25);
			this.btnExecuteAge.TabIndex = 12;
			this.btnExecuteAge.Text = "Execute";
			this.btnExecuteAge.UseVisualStyleBackColor = true;
			//
			//cbAgeUnits
			//
			this.cbAgeUnits.FormattingEnabled = true;
			this.cbAgeUnits.Items.AddRange(new object[] {"Months", "Days", "Years"});
			this.cbAgeUnits.Location = new System.Drawing.Point(88, 251);
			this.cbAgeUnits.Name = "cbAgeUnits";
			this.cbAgeUnits.Size = new System.Drawing.Size(97, 21);
			this.cbAgeUnits.TabIndex = 10;
			this.cbAgeUnits.Text = "Months";
			//
			//txtAgeUnit
			//
			this.txtAgeUnit.Location = new System.Drawing.Point(12, 252);
			this.txtAgeUnit.Name = "txtAgeUnit";
			this.txtAgeUnit.Size = new System.Drawing.Size(52, 20);
			this.txtAgeUnit.TabIndex = 9;
			//
			//Label5
			//
			this.Label5.AutoSize = true;
			this.Label5.Location = new System.Drawing.Point(12, 230);
			this.Label5.Name = "Label5";
			this.Label5.Size = new System.Drawing.Size(127, 13);
			this.Label5.TabIndex = 8;
			this.Label5.Text = "Select all items older than";
			//
			//dgItems
			//
			this.dgItems.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
			this.dgItems.Location = new System.Drawing.Point(248, 37);
			this.dgItems.Name = "dgItems";
			this.dgItems.Size = new System.Drawing.Size(576, 358);
			this.dgItems.TabIndex = 13;
			//
			//SB
			//
			this.SB.Location = new System.Drawing.Point(15, 462);
			this.SB.Name = "SB";
			this.SB.Size = new System.Drawing.Size(809, 20);
			this.SB.TabIndex = 14;
			//
			//btnDelete
			//
			this.btnDelete.Location = new System.Drawing.Point(248, 414);
			this.btnDelete.Name = "btnDelete";
			this.btnDelete.Size = new System.Drawing.Size(91, 42);
			this.btnDelete.TabIndex = 15;
			this.btnDelete.Text = "Delete Selected Items";
			this.btnDelete.UseVisualStyleBackColor = true;
			//
			//btnMove
			//
			this.btnMove.Enabled = false;
			this.btnMove.Location = new System.Drawing.Point(733, 414);
			this.btnMove.Name = "btnMove";
			this.btnMove.Size = new System.Drawing.Size(91, 42);
			this.btnMove.TabIndex = 16;
			this.btnMove.Text = "Move Selected Items";
			this.btnMove.UseVisualStyleBackColor = true;
			//
			//TT
			//
			//
			//PB
			//
			this.PB.Location = new System.Drawing.Point(372, 431);
			this.PB.Name = "PB";
			this.PB.Size = new System.Drawing.Size(329, 14);
			this.PB.TabIndex = 17;
			//
			//dtExtendDate
			//
			this.dtExtendDate.Location = new System.Drawing.Point(469, 10);
			this.dtExtendDate.Name = "dtExtendDate";
			this.dtExtendDate.Size = new System.Drawing.Size(208, 20);
			this.dtExtendDate.TabIndex = 18;
			//
			//Label4
			//
			this.Label4.AutoSize = true;
			this.Label4.Location = new System.Drawing.Point(245, 14);
			this.Label4.Name = "Label4";
			this.Label4.Size = new System.Drawing.Size(218, 13);
			this.Label4.TabIndex = 19;
			this.Label4.Text = "Extend all selected item\'s retention date until:";
			//
			//btnExtend
			//
			this.btnExtend.Location = new System.Drawing.Point(733, 8);
			this.btnExtend.Name = "btnExtend";
			this.btnExtend.Size = new System.Drawing.Size(91, 25);
			this.btnExtend.TabIndex = 20;
			this.btnExtend.Text = "Extend";
			this.btnExtend.UseVisualStyleBackColor = true;
			//
			//Timer1
			//
			//
			//btnRecall
			//
			this.btnRecall.Enabled = false;
			this.btnRecall.Location = new System.Drawing.Point(22, 414);
			this.btnRecall.Name = "btnRecall";
			this.btnRecall.Size = new System.Drawing.Size(163, 42);
			this.btnRecall.TabIndex = 21;
			this.btnRecall.Text = "Load Marked EMAIL Retention Items";
			this.btnRecall.UseVisualStyleBackColor = true;
			//
			//HelpProvider1
			//
			this.HelpProvider1.HelpNamespace = "http://www.ecmlibrary.com/helpfiles/Retention Management Screen.htm";
			//
			//frmRetentionMgt
			//
			this.AutoScaleDimensions = new System.Drawing.SizeF((float) (6.0F), (float) (13.0F));
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.ClientSize = new System.Drawing.Size(871, 494);
			this.Controls.Add(this.btnRecall);
			this.Controls.Add(this.btnExtend);
			this.Controls.Add(this.Label4);
			this.Controls.Add(this.dtExtendDate);
			this.Controls.Add(this.PB);
			this.Controls.Add(this.btnMove);
			this.Controls.Add(this.btnDelete);
			this.Controls.Add(this.SB);
			this.Controls.Add(this.dgItems);
			this.Controls.Add(this.btnExecuteAge);
			this.Controls.Add(this.cbAgeUnits);
			this.Controls.Add(this.txtAgeUnit);
			this.Controls.Add(this.Label5);
			this.Controls.Add(this.btnSelectExpired);
			this.Controls.Add(this.Label3);
			this.Controls.Add(this.btnExecuteExpire);
			this.Controls.Add(this.Label2);
			this.Controls.Add(this.cbExpireUnits);
			this.Controls.Add(this.txtExpireUnit);
			this.Controls.Add(this.Label1);
			this.Controls.Add(this.GroupBox1);
			this.HelpProvider1.SetHelpString(this, "http://www.ecmlibrary.com/helpfiles/Retention Management Screen.htm");
			this.Name = "frmRetentionMgt";
			this.HelpProvider1.SetShowHelp(this, true);
			this.Text = "Content Retention Management Screen";
			this.GroupBox1.ResumeLayout(false);
			this.GroupBox1.PerformLayout();
			((System.ComponentModel.ISupportInitialize) this.dgItems).EndInit();
			this.ResumeLayout(false);
			this.PerformLayout();
			
		}
		internal System.Windows.Forms.GroupBox GroupBox1;
		internal System.Windows.Forms.RadioButton rbEmails;
		internal System.Windows.Forms.RadioButton rbContent;
		internal System.Windows.Forms.Label Label1;
		internal System.Windows.Forms.TextBox txtExpireUnit;
		internal System.Windows.Forms.ComboBox cbExpireUnits;
		internal System.Windows.Forms.Label Label2;
		internal System.Windows.Forms.Button btnExecuteExpire;
		internal System.Windows.Forms.Label Label3;
		internal System.Windows.Forms.Button btnSelectExpired;
		internal System.Windows.Forms.Button btnExecuteAge;
		internal System.Windows.Forms.ComboBox cbAgeUnits;
		internal System.Windows.Forms.TextBox txtAgeUnit;
		internal System.Windows.Forms.Label Label5;
		internal System.Windows.Forms.DataGridView dgItems;
		internal System.Windows.Forms.TextBox SB;
		internal System.Windows.Forms.Button btnDelete;
		internal System.Windows.Forms.Button btnMove;
		internal System.Windows.Forms.ToolTip TT;
		internal System.Windows.Forms.ProgressBar PB;
		internal System.Windows.Forms.DateTimePicker dtExtendDate;
		internal System.Windows.Forms.Label Label4;
		internal System.Windows.Forms.Button btnExtend;
		internal System.Windows.Forms.Timer Timer1;
		internal System.Windows.Forms.Button btnRecall;
		internal System.Windows.Forms.HelpProvider HelpProvider1;
	}
	
}
