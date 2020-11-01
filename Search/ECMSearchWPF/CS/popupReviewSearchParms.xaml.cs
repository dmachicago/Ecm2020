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
	public partial class popupReviewSearchParms
	{
		
		System.Collections.ObjectModel.ObservableCollection<SVCSearch.DS_SearchTerms> _ListOfSearchTerms = new System.Collections.ObjectModel.ObservableCollection<SVCSearch.DS_SearchTerms>();
		
		public popupReviewSearchParms(System.Collections.ObjectModel.ObservableCollection<SVCSearch.DS_SearchTerms> ListOfSearchTerms)
		{
			InitializeComponent();
			
			_ListOfSearchTerms = ListOfSearchTerms;
			
			dgParms.ItemsSource = _ListOfSearchTerms;
			
		}
		
		public void OKButton_Click(object sender, RoutedEventArgs e)
		{
			this.DialogResult = true;
		}
		
		
		public void btnCopy_Click(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			string sText = "";
			for (int I = 0; I <= dgParms.Items.Count - 1; I++)
			{
				sText += (string) (dgParms.Items[I].Item("Term") + ", ");
				sText += (string) (dgParms.Items[I].Item("TermVal") + ", ");
				sText += (string) (dgParms.Items[I].Item("SearchTypeCode") + ", ");
				sText += (string) (dgParms.Items[I].Item("TermDataType") + "\r\n");
			}
			
			txtParms.SelectAll();
			txtParms.Cut();
			txtParms.AppendText(sText);
			txtParms.SelectAll();
			txtParms.Copy();
			
		}
		
		public void popupReviewSearchParms_Unloaded(System.Object sender, System.Windows.RoutedEventArgs e)
		{
			Console.WriteLine("Closing window");
		}
	}
	
}
