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
	public class clsGridMgt
	{
		
		clsIsolatedStorage ISO = new clsIsolatedStorage();
		
		public void SaveGridState(string Userid, string ScreenName, DataGrid DG, Dictionary<int, string> Dict)
		{
			
			string ColDisplayOrder = DG.Name + " Column Display Order: " + "\r\n";
			Dict.Clear();
			for (int I = 0; I <= DG.Columns.Count - 1; I++)
			{
				string sCol = (string) (DG.Columns[I].Header);
				ColDisplayOrder += sCol + "\r\n";
				if (Dict.ContainsKey(I))
				{
					Dict.Item(I) = sCol;
				}
				else
				{
					Dict.Add(I, sCol);
				}
			}
			
			//MessageBox.Show(ColDisplayOrder)
			
			ISO.SaveGridColDisplayOrder(ScreenName, DG.Name, Userid, Dict);
			
		}
		
		public void SaveGridDictionary(DataGrid DG, Dictionary<int, string> Dict)
		{
			
			for (int I = 0; I <= DG.Columns.Count - 1; I++)
			{
				string ColName = (string) (DG.Columns[I].Header);
				if (Dict.ContainsKey(I))
				{
					Dict.Item(I) = ColName;
				}
				else
				{
					Dict.Add(I, ColName);
				}
			}
			
		}
		
		public void getGridState(string ScreenName, string GridName, string UID, ref Dictionary<int, string> Dict)
		{
			
			ISO.ReadGridColDisplayOrder(ScreenName, GridName, UID, Dict);
			
		}
		
	}
	
}
