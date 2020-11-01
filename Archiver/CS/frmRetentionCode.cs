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
	public partial class frmRetentionCode
	{
		public frmRetentionCode()
		{
			InitializeComponent();
			
			//Added to support default instance behavour in C#
			if (defaultInstance == null)
				defaultInstance = this;
		}
		
#region Default Instance
		
		private static frmRetentionCode defaultInstance;
		
		/// <summary>
		/// Added by the VB.Net to C# Converter to support default instance behavour in C#
		/// </summary>
		public static frmRetentionCode Default
		{
			get
			{
				if (defaultInstance == null)
				{
					defaultInstance = new frmRetentionCode();
					defaultInstance.FormClosed += new FormClosedEventHandler(defaultInstance_FormClosed);
				}
				
				return defaultInstance;
			}
		}
		
		static void defaultInstance_FormClosed(object sender, FormClosedEventArgs e)
		{
			defaultInstance = null;
		}
		
#endregion
		
		clsDatabase DB = new clsDatabase();
		bool RC = false;
		
		/// <summary>
		/// Handles the Load event of the frmRetentionCode control.
		/// </summary>
		/// <param name="sender">The source of the event.</param>
		/// <param name="e">The <see cref="System.EventArgs" /> instance containing the event data.</param>
		public void frmRetentionCode_Load(System.Object sender, System.EventArgs e)
		{
			GetRetentionCodes();
		}
		
		/// <summary>
		/// Handles the Click event of the btnSave control.
		/// </summary>
		/// <param name="sender">The source of the event.</param>
		/// <param name="e">The <see cref="System.EventArgs" /> instance containing the event data.</param>
		public void btnSave_Click(System.Object sender, System.EventArgs e)
		{
			
			var RetentionCode = txtRetentionCode.Text;
			var RetentionDesc = txtDesc.Text;
			string ManagerID = txtManagerID.Text;
			int RetentionUnits = (int) nbrRetentionUnits.Value;
			int DaysWarning = (int) nbrDaysWarning.Value;
			string RetentionPeriod = cbRetentionPeriod.Text;
			string RetentionAction = cbRetentionAction.Text;
			string ResponseRequired = "";
			if (ckResponseRequired.Checked)
			{
				ResponseRequired = "Y";
			}
			else
			{
				ResponseRequired = "N";
			}
			
			bool B = DB.Save_RetentionCode(modGlobals.gGateWayID, RetentionCode, RetentionDesc, RetentionUnits, RetentionAction, ManagerID, DaysWarning, ResponseRequired, RetentionPeriod, ref RC);
			
			if (B)
			{
				SB.Text = RetentionCode + " Saved.";
				GetRetentionCodes();
			}
			else
			{
				SB.Text = RetentionCode + " NOT Saved.";
			}
			
		}
		
		/// <summary>
		/// Gets the retention codes.
		/// </summary>
		public void GetRetentionCodes()
		{
			
			bool RC = true;
			
			BindingSource RssBindingSource = new BindingSource();
			RssBindingSource.DataSource = DB.GET_RetentionCodes(modGlobals.gGateWayID, RC);
			dgRetention.DataSource = RssBindingSource;
			
		}
		
		
		/// <summary>
		/// Handles the SelectionChanged event of the dgRetention control.
		/// </summary>
		/// <param name="sender">The source of the event.</param>
		/// <param name="e">The <see cref="System.EventArgs" /> instance containing the event data.</param>
		public void dgRetention_SelectionChanged(System.Object sender, System.EventArgs e)
		{
			int I = dgRetention.SelectedRows.Count;
			if (I == 1)
			{
				DataGridViewRow DR = dgRetention.SelectedRows[0];
				txtRetentionCode.Text = DR.Cells["RetentionCode"].Value.ToString();
				txtDesc.Text = DR.Cells["RetentionDesc"].Value.ToString();
				nbrRetentionUnits.Value = decimal.Parse(DR.Cells["RetentionUnits"].Value.ToString());
				if (DR.Cells["DaysWarning"].Value == null)
				{
					nbrDaysWarning.Value = 14;
				}
				else
				{
					try
					{
						nbrDaysWarning.Value = System.Convert.ToDecimal(DR.Cells["DaysWarning"].Value);
					}
					catch (Exception)
					{
						nbrDaysWarning.Value = 15;
					}
				}
				
				txtManagerID.Text = DR.Cells["ManagerID"].Value.ToString();
				cbRetentionPeriod.Text = DR.Cells["RetentionPeriod"].Value.ToString();
				cbRetentionAction.Text = DR.Cells["RetentionAction"].Value.ToString();
				string ResponseRequired = DR.Cells["ResponseRequired"].Value.ToString();
				if (ckResponseRequired.ToString().Equals("Y"))
				{
					ckResponseRequired.Checked = true;
				}
				else
				{
					ckResponseRequired.Checked = false;
				}
			}
			else
			{
				SB.Text = "Only one row can be selected.";
			}
		}
		
		/// <summary>
		/// Handles the Click event of the btnDelete control.
		/// </summary>
		/// <param name="sender">The source of the event.</param>
		/// <param name="e">The <see cref="System.EventArgs" /> instance containing the event data.</param>
		public void btnDelete_Click(System.Object sender, System.EventArgs e)
		{
			
			int I = dgRetention.SelectedRows.Count;
			if (I != 1)
			{
				MessageBox.Show("One and only one row must be selected.");
				return;
			}
			
			string RetentionCode = txtRetentionCode.Text;
			
			string MySql = "delete from Retention where RetentionCode = \'" + RetentionCode + "\' ";
			
			RC = DB.ExecuteSqlNewConn(MySql);
			
			if (RC)
			{
				GetRetentionCodes();
			}
			else
			{
				MessageBox.Show((string) ("Failed to DELETE Retention Code : " + RetentionCode));
			}
		}
		
	}
	
}
