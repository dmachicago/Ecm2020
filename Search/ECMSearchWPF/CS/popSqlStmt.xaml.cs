// VBConversions Note: VB project level imports
using System.Windows.Input;
using System.Windows.Data;
using System.Windows.Documents;
using System.Xml.Linq;
using System.Collections.Generic;
using System.Windows.Navigation;
using System.Windows.Media.Imaging;
using System.Windows;
using Microsoft.VisualBasic;
using System.Windows.Media;
using System.Collections;
using System;
using System.Windows.Shapes;
using System.Windows.Controls;
using System.Threading.Tasks;
using System.Linq;
using System.Diagnostics;
// End of VB project level imports


namespace ECMSearchWPF
{
	public partial class popSqlStmt
	{
		
		string SqlText = "";
		clsCommonFunctions COMMON = new clsCommonFunctions();
		string Userid;
		
		public popSqlStmt(string rtbSqlText)
		{
			InitializeComponent();
			
			Userid = GLOBALS._UserID;
			COMMON.SaveClick(6930, Userid);
			
			SqlText = rtbSqlText;
			rtbSql.Text = SqlText;
			
		}
		
		public void CancelButton_Click(object sender, RoutedEventArgs e)
		{
			//Me.Visibility = Windows.Visibility.Collapsed
			this.Close();
		}
		
		public void hlCopy_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			try
			{
				Clipboard.SetText(rtbSql.Text);
				MessageBox.Show("Qry in clipboard");
			}
			catch (Exception)
			{
				MessageBox.Show("Could not place Qry in clipboard, copy and paste from the window please.");
			}
			
		}
		
	}
	
}
