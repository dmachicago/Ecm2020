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

using System.IO.IsolatedStorage;
using System.Threading;
using System.Data;
using System.Windows.Controls.Primitives;
using System.IO;


namespace ECMSearchWPF
{
	public sealed class grid
	{
		
		private grid()
		{
		}
		
		
		public static void SelectRowByIndex(DataGrid dataGrid, int rowIndex)
		{
			if (! dataGrid.SelectionUnit.Equals(DataGridSelectionUnit.FullRow))
			{
				throw (new ArgumentException("The SelectionUnit of the DataGrid must be set to FullRow."));
			}
			
			if (rowIndex < 0 || rowIndex > (dataGrid.Items.Count - 1))
			{
				throw (new ArgumentException(string.Format("{0} is an invalid row index.", rowIndex)));
			}
			
			dataGrid.SelectedItems.Clear();
			// set the SelectedItem property
			
			object item = dataGrid.Items[rowIndex];
			// = Product X
			dataGrid.SelectedItem = item;
			
			DataGridRow row = dataGrid.ItemContainerGenerator.ContainerFromIndex(rowIndex) as DataGridRow;
			if (row == null)
			{
				// bring the data item (Product object) into view
				//             * in case it has been virtualized away
				
				dataGrid.ScrollIntoView(item);
				row = dataGrid.ItemContainerGenerator.ContainerFromIndex(rowIndex) as DataGridRow;
			}
		}
		
		public static Dictionary<string, object> DictionaryFromType(object atype)
		{
			if (atype == null)
			{
				return new Dictionary<string, object>();
			}
			Type t = atype.GetType();
			System.Reflection.PropertyInfo[] props = t.GetProperties();
			Dictionary<string, object> dict = new Dictionary<string, object>();
			foreach (System.Reflection.PropertyInfo prp in props)
			{
				object value = prp.GetValue(atype, new object[] {});
				VariantType VType = Information.VarType(value);
				string VStr = VType.ToString();
				string val = VType.GetType().ToString();
				dict.Add(prp.Name, VStr);
			}
			return dict;
		}
		
		public static string[] PropertiesFromType(object atype)
		{
			if (atype == null)
			{
				return new string[] {};
			}
			
			Type t = atype.GetType();
			System.Reflection.PropertyInfo[] props = t.GetProperties();
			List<string> propNames = new List<string>();
			
			foreach (System.Reflection.PropertyInfo prp in props)
			{
				object oRType = prp.ReflectedType;
				object oType = prp.GetType();
				object oProp = prp.PropertyType;
				propNames.Add(prp.Name);
			}
			
			return propNames.ToArray();
		}
		
		public static Dictionary<object, object> enumClass()
		{
			
			Dictionary<object, object> D = new Dictionary<object, object>();
			tempdata T = new tempdata();
			Type typ = T.GetType();
			System.Reflection.PropertyInfo[] props = typ.GetProperties();
			
			foreach (System.Reflection.PropertyInfo prp in props)
			{
				//Dim val As Object = prp.GetValue(typ)
				string Obj1 = prp.Name;
				object Obj2 = prp.GetType();
				D.Add(prp.Name, prp.GetType());
				Console.Write("{0} , {1}", prp.Name, prp.GetType());
			}
			
			//For Each prop As Object In T.GetType().GetProperties()
			//    Dim O1 As Object = prop.GetType
			//    Dim O2 As Object = prop.ToString
			//    Console.Write("{0} , {1}", O1, O2)
			//    D.Add(O2, O1)
			//Next
			return D;
		}
		
		public static string GetCelValue(DataGrid dgrid)
		{
			object DR = dgrid.SelectedItems[0];
			string str = "";
			
			int i = System.Convert.ToInt32(DR.age);
			str = (string) DR.email;
			
			return str;
		}
		
		public static string GetCelValue(DataGrid dgrid, string ColName)
		{
			object DR = dgrid.SelectedItems[0];
			string str = "";
			int RowIdx = dgrid.SelectedIndex;
			//Dim i As Int32 = DR.age
			//str = DR.email
			
			str = grid.GetCellValueAsString(dgrid, RowIdx, ColName);
			
			return str;
		}
		
		public static string GetCelValue(DataGrid dgrid, int RowIdx, string ColName)
		{
			object DR = dgrid.Items[RowIdx];
			string str = "";
			
			//Dim i As Int32 = DR.age
			//str = DR.email
			
			str = grid.GetCellValueAsString(dgrid, RowIdx, ColName);
			
			return str;
		}
		
		public static DataGridCell GetSelectedCell(DataGrid dataGrid, DataGridRow rowContainer, int column)
		{
			if (rowContainer != null)
			{
				DataGridCellsPresenter presenter = FindVisualChild<DataGridCellsPresenter>(rowContainer);
				if (presenter == null)
				{
					// if the row has been virtualized away, call its ApplyTemplate() method
					//             * to build its visual tree in order for the DataGridCellsPresenter
					//             * and the DataGridCells to be created
					
					rowContainer.ApplyTemplate();
					presenter = FindVisualChild<DataGridCellsPresenter>(rowContainer);
				}
				if (presenter != null)
				{
					DataGridCell cell = presenter.ItemContainerGenerator.ContainerFromIndex(column) as DataGridCell;
					if (cell == null)
					{
						// bring the column into view
						//                 * in case it has been virtualized away
						
						dataGrid.ScrollIntoView(rowContainer, dataGrid.Columns[column]);
						cell = presenter.ItemContainerGenerator.ContainerFromIndex(column) as DataGridCell;
					}
					return cell;
				}
			}
			return null;
		}
		
		public static void SelectCellByIndex(DataGrid dataGrid, int rowIndex, int columnIndex)
		{
			if (! dataGrid.SelectionUnit.Equals(DataGridSelectionUnit.Cell))
			{
				throw (new ArgumentException("The SelectionUnit of the DataGrid must be set to Cell."));
			}
			
			if (rowIndex < 0 || rowIndex > (dataGrid.Items.Count - 1))
			{
				throw (new ArgumentException(string.Format("{0} is an invalid row index.", rowIndex)));
			}
			
			if (columnIndex < 0 || columnIndex > (dataGrid.Columns.Count - 1))
			{
				throw (new ArgumentException(string.Format("{0} is an invalid column index.", columnIndex)));
			}
			
			dataGrid.SelectedCells.Clear();
			
			object item = dataGrid.Items[rowIndex];
			//=Product X
			DataGridRow row = dataGrid.ItemContainerGenerator.ContainerFromIndex(rowIndex) as DataGridRow;
			if (row == null)
			{
				dataGrid.ScrollIntoView(item);
				row = dataGrid.ItemContainerGenerator.ContainerFromIndex(rowIndex) as DataGridRow;
			}
			if (row != null)
			{
				DataGridCell cell = GetCell(dataGrid, row, columnIndex);
				if (cell != null)
				{
					DataGridCellInfo dataGridCellInfo = new DataGridCellInfo(cell);
					dataGrid.SelectedCells.Add(dataGridCellInfo);
					cell.Focus();
				}
			}
		}
		
		public static t FindVisualChild<t>(DependencyObject obj) where t : DependencyObject
		{
			for (int i = 0; i <= VisualTreeHelper.GetChildrenCount(obj) - 1; i++)
			{
				DependencyObject child = VisualTreeHelper.GetChild(obj, i);
				if (child != null && child is T)
				{
					return ((T) child);
				}
				else
				{
					T childOfChild = FindVisualChild<T>(child);
					if (childOfChild != null)
					{
						return childOfChild;
					}
				}
			}
			return null;
		}
		
		public static WeakReference MakeNewWeakReference<t>(t Obj) where t : class
		{
			return new WeakReference(Obj);
		}
		
		public static bool updateCellThruDataStructure(DataGrid dgrid, int RowIdx, int ColIndex, object newValue)
		{
			bool bResetToRowMode = false;
			DataGridSelectionUnit O = dgrid.SelectionUnit;
			
			if (O.Equals(DataGridSelectionUnit.FullRow))
			{
				dgrid.SelectionUnit = DataGridSelectionUnit.Cell;
				bResetToRowMode = true;
			}
			
			bool B = true;
			int I = 0;
			
			
			try
			{
				foreach (tempdata TRow in dgrid.ItemsSource)
				{
					string s = TRow.ToString();
					if (I == RowIdx)
					{
						TRow.dg_age = newValue;
					}
					I++;
				}
				dgrid.Items.Refresh();
				if (bResetToRowMode.Equals(true))
				{
					dgrid.SelectionUnit = DataGridSelectionUnit.FullRow;
				}
			}
			catch (Exception)
			{
				B = false;
			}
			
			return B;
		}
		
		public static bool updateCellThruDataStructure(DataGrid dgrid, int RowIdx, string ColName, object newValue)
		{
			bool bResetToRowMode = false;
			DataGridSelectionUnit O = dgrid.SelectionUnit;
			
			if (O.Equals(DataGridSelectionUnit.FullRow))
			{
				dgrid.SelectionUnit = DataGridSelectionUnit.Cell;
				bResetToRowMode = true;
			}
			
			bool B = true;
			int I = 0;
			
			
			try
			{
				foreach (tempdata TRow in dgrid.ItemsSource)
				{
					if (I == RowIdx)
					{
						TRow.dg_age = newValue;
					}
					I++;
				}
				dgrid.Items.Refresh();
				if (bResetToRowMode.Equals(true))
				{
					dgrid.SelectionUnit = DataGridSelectionUnit.FullRow;
				}
			}
			catch (Exception)
			{
				B = false;
			}
			
			return B;
		}
		
		public static bool updateCell(DataGrid dgrid, int RowIdx, string ColName, object newValue)
		{
			bool B = true;
			try
			{
				int iCol = getColumnIndexByName(dgrid, ColName);
				SelectCellByIndex(dgrid, RowIdx, iCol);
				
				DataGridRow R = null;
				R = GetRow(dgrid, RowIdx);
				
				DataGridCell DC = null;
				DC = GetCell(dgrid, R, iCol);
				DC.Content = newValue;
				dgrid.Items.Refresh();
				return true;
			}
			catch (Exception)
			{
				B = false;
			}
			
			return B;
		}
		
		/// <summary>
		/// Enums the grid cols and returns a list of names in display order
		/// </summary>
		/// <param name="dgrid">The dgrid.</param>
		/// <returns>returns a list of names in display order</returns>
		public static Dictionary<int, string> EnumGridCols(DataGrid dgrid)
		{
			Dictionary<int, string> LCols = new Dictionary<int, string>();
			//Dim iTot As Integer = dgrid.Columns.Count - 1
			//Dim iCol As Integer = 0
			//For i As Integer = 0 To iTot
			//    Dim tCol As DataGridColumn = dgrid.Columns(i)
			//    Dim name As String = tCol.Header
			//    Dim ii As Integer = tCol.DisplayIndex
			//    Console.WriteLine(name, ii)
			//Next
			foreach (DataGridColumn C in dgrid.Columns)
			{
				string name = (string) C.Header;
				int ii = C.DisplayIndex;
				LCols.Add(ii, name);
			}
			
			return LCols;
			
		}
		
		/// <summary>
		/// Enums objects within the grid tree.
		/// </summary>
		/// <param name="DGRID">The dgrid.</param>
		public static void EnumGridTree(DependencyObject DGRID, ref Dictionary<string, string> ObjectList)
		{
			
			for (int i = 0; i <= VisualTreeHelper.GetChildrenCount(DGRID) - 1; i++)
			{
				var child = VisualTreeHelper.GetChild(DGRID, i);
				string sType = child.GetType().ToString();
				
				object OName = child.GetType().Name;
				object OType = child.GetType().FullName;
				if (! ObjectList.ContainsKey(OName))
				{
					ObjectList.Add(OName, OType);
				}
				EnumGridTree(child, ref ObjectList);
				
				//If child IsNot Nothing AndAlso TypeOf child Is ScrollViewer Then
				//    Dim scrollbarname As String = DirectCast(child, ScrollViewer).Name
				//    Console.WriteLine(scrollbarname)
				//    ObjectList.Add(scrollbarname)
				//ElseIf child IsNot Nothing AndAlso TypeOf child Is ScrollBar Then
				//    Dim scrollbarname As String = DirectCast(child, ScrollBar).Name
				//    Console.WriteLine(scrollbarname)
				//    ObjectList.Add(scrollbarname)
				//Else
				//    EnumGridTree(child, ObjectList)
				//    If [ObjectList] IsNot Nothing Then
				//        Return
				//    Else
				//        For Each s As String In ObjectList
				//            ObjectList.Add(s)
				//        Next
				//    End If
				//End If
			}
			return;
		}
		
		public static ScrollBar GetScrollbar(DependencyObject DGRID, string name)
		{
			for (int i = 0; i <= VisualTreeHelper.GetChildrenCount(DGRID) - 1; i++)
			{
				var child = VisualTreeHelper.GetChild(DGRID, i);
				if (child != null && child is ScrollBar)
				{
					string scrollbarname = ((ScrollBar) child).Name;
					Console.WriteLine(scrollbarname);
					return child as ScrollBar;
				}
				else
				{
					ScrollBar SBAR = GetScrollbar(child, name);
					if (SBAR != null)
					{
						return SBAR;
					}
				}
			}
			return null;
		}
		
		//<System.Runtime.CompilerServices.Extension> _
		public static ScrollBar GetDGScrollbar(DependencyObject DGRID, string name)
		{
			for (int i = 0; i <= VisualTreeHelper.GetChildrenCount(DGRID) - 1; i++)
			{
				var child = VisualTreeHelper.GetChild(DGRID, i);
				if (child != null && child is ScrollBar&& ((ScrollBar) child).Name == name)
				{
					return child as ScrollBar;
				}
				else
				{
					ScrollBar SBAR = GetScrollbar(child, name);
					if (SBAR != null)
					{
						return SBAR;
					}
				}
			}
			return null;
		}
		
		public static double getScrollBarCurrentPct(DataGrid dg, string sbarname)
		{
			ScrollBar sbar = GetScrollbar(dg, sbarname);
			double currpos = sbar.Value;
			double currmax = sbar.Maximum;
			double pct = currpos / currmax * 100;
			return pct;
		}
		
		// Get the current position of the scrollbar.
		public static double getScrollBarCurrentPosition(DataGrid dg, string sbarname)
		{
			ScrollBar sbar = GetScrollbar(dg, sbarname);
			return sbar.Value;
		}
		
		/// Gets the scroll bar maximum position.
		public static double getScrollBarMaxPosition(DataGrid dg, string sbarname)
		{
			ScrollBar sbar = GetScrollbar(dg, sbarname);
			return sbar.Maximum;
		}
		
		public static DataGridRow GetSelectedRow(DataGrid dgrid)
		{
			return ((DataGridRow) (dgrid.ItemContainerGenerator.ContainerFromItem(dgrid.SelectedItem)));
		}
		
		public static int getColumnIndexByName(DataGrid dgrid, string ColName)
		{
			string cname = "";
			int i = -1;
			
			bool f = false;
			foreach (DataGridColumn C in dgrid.Columns)
			{
				i++;
				cname = (string) C.Header;
				if (cname.ToUpper().Equals(ColName.ToUpper()))
				{
					f = true;
					return i;
				}
			}
			if (f == false)
			{
				i = -1;
			}
			return i;
		}
		
		public static string getColumnNameByIndex(DataGrid dgrid, int ColIdx)
		{
			string cname = "";
			int i = -1;
			
			foreach (DataGridColumn C in dgrid.Columns)
			{
				i++;
				cname = (string) C.Header;
				if (i.Equals(ColIdx))
				{
					return cname;
				}
			}
			return cname;
		}
		
		public static DataGridRow GetRow(DataGrid dgrid, int index)
		{
			if (index < 0)
			{
				return null;
			}
			DataGridRow row = (DataGridRow) (dgrid.ItemContainerGenerator.ContainerFromIndex(index));
			if (row == null)
			{
				// May be virtualized, bring into view and try again.
				dgrid.UpdateLayout();
				dgrid.ScrollIntoView(dgrid.Items[index]);
				row = (DataGridRow) (dgrid.ItemContainerGenerator.ContainerFromIndex(index));
			}
			return row;
		}
		
		/// <summary>
		/// Gets the cell and returns it as a datagrid cell usign the column name.
		/// Verified 10/13/2015 by WDM
		/// </summary>
		/// <param name="dgrid">The data grid.</param>
		/// <param name="row">The row.</param>
		/// <param name="columnName">Name of the column.</param>
		/// <returns></returns>
		public static DataGridCell GetCell(DataGrid dgrid, DataGridRow row, string columnName)
		{
			int column = -1;
			column = getColumnIndexByName(dgrid, columnName);
			if (column < 0)
			{
				return null;
			}
			return GetCell(dgrid, row, column);
		}
		
		public static string GetCellValueAsString(DataGrid dgrid, int RowIdx, string ColName)
		{
			int ColIDX = getColumnIndexByName(dgrid, ColName);
			if (ColIDX < 0)
			{
				return "";
			}
			int RowNbr = RowIdx;
			string str = GetCellValueAsString(dgrid, RowIdx, ColIDX);
			return str;
		}
		public static string GetCellValueAsString(DataGrid dgrid, int RowIdx, int ColIDX)
		{
			int RowNbr = RowIdx;
			if (RowNbr < 0)
			{
				return "";
			}
			DataGridRow DR = GetRow(dgrid, RowNbr);
			if (DR != null)
			{
				
				DataGridCellsPresenter presenter = GetVisualChild<DataGridCellsPresenter>(DR);
				
				if (presenter == null)
				{
					dgrid.ScrollIntoView(DR, dgrid.Columns[ColIDX]);
					presenter = GetVisualChild<DataGridCellsPresenter>(DR);
				}
				
				DataGridCell cell = (DataGridCell) (presenter.ItemContainerGenerator.ContainerFromIndex(ColIDX));
				System.Type stype = cell.GetType();
				//Dim str As String = TryCast(dgrid.SelectedCells(0).Column.GetCellContent(DR), TextBlock).Text
				
				string str = "";
				try
				{
					str = (dgrid.SelectedCells[ColIDX].Column.GetCellContent(DR) as TextBlock).Text;
				}
				catch (Exception)
				{
					str = "";
				}
				return str;
			}
			return "";
			
		}
		
		/// <summary>
		/// Gets the cell value as string using the Column Index.
		/// Verified 10/13/2015 by WDM
		/// </summary>
		/// <param name="dgrid">The dgrid.</param>
		/// <param name="ColIDX">Index of the col.</param>
		/// <returns></returns>
		public static string GetCellValueAsString(DataGrid dgrid, int ColIDX)
		{
			int RowNbr = dgrid.SelectedIndex;
			if (RowNbr < 0)
			{
				return "";
			}
			DataGridRow DR = GetRow(dgrid, RowNbr);
			if (DR != null)
			{
				
				DataGridCellsPresenter presenter = GetVisualChild<DataGridCellsPresenter>(DR);
				
				if (presenter == null)
				{
					dgrid.ScrollIntoView(DR, dgrid.Columns[ColIDX]);
					presenter = GetVisualChild<DataGridCellsPresenter>(DR);
				}
				
				DataGridCell cell = (DataGridCell) (presenter.ItemContainerGenerator.ContainerFromIndex(ColIDX));
				System.Type stype = cell.GetType();
				string str = (dgrid.SelectedCells[0].Column.GetCellContent(DR) as TextBlock).Text;
				return str;
			}
			return "";
			
		}
		
		/// <summary>
		/// Gets the cell value as string using the Column name.
		/// Verified 10/13/2015 by WDM
		/// </summary>
		/// <param name="dgrid">The dgrid.</param>
		/// <param name="ColName">Name of the col.</param>
		/// <returns></returns>
		public static string GetCellValueAsString(DataGrid dgrid, string ColName)
		{
			
			int RowNbr = dgrid.SelectedIndex;
			if (RowNbr < 0)
			{
				return "";
			}
			DataGridRow DR = GetRow(dgrid, RowNbr);
			
			if (DR != null)
			{
				int ColIDX = getColumnIndexByName(dgrid, ColName);
				if (ColIDX < 0)
				{
					return "";
				}
				DataGridCellsPresenter presenter = GetVisualChild<DataGridCellsPresenter>(DR);
				
				if (presenter == null)
				{
					dgrid.ScrollIntoView(DR, dgrid.Columns[ColIDX]);
					presenter = GetVisualChild<DataGridCellsPresenter>(DR);
				}
				
				DataGridCell cell = (DataGridCell) (presenter.ItemContainerGenerator.ContainerFromIndex(ColIDX));
				System.Type stype = cell.GetType();
				string str = (dgrid.SelectedCells[ColIDX].Column.GetCellContent(DR) as TextBlock).Text;
				return str;
			}
			return "";
			
		}
		public static t GetVisualChild<t>(Visual parent) where t : Visual
		{
			T child = null;
			int numVisuals = VisualTreeHelper.GetChildrenCount(parent);
			for (int i = 0; i <= numVisuals - 1; i++)
			{
				Visual v = (Visual) (VisualTreeHelper.GetChild(parent, i));
				child = v as T;
				if (child == null)
				{
					child = GetVisualChild<T>(v);
				}
				if (child != null)
				{
					break;
				}
			}
			return child;
		}
		
		public static DataGridCell GetCellAsCell(DataGrid grid, int row, int column)
		{
			DataGridRow rowContainer = GetRow(grid, row);
			return GetCell(grid, rowContainer, column);
		}
		public static DataGridCell GetCellAsString(DataGrid grid, int row, int column)
		{
			DataGridRow rowContainer = GetRow(grid, row);
			return GetCell(grid, rowContainer, column);
		}
		
		/// <summary>
		/// Selects a single row from a datagrid.
		/// </summary>
		/// <param name="dataGrid">The data grid.</param>
		/// <param name="rowIndex">Index of the row.</param>
		/// <exception cref="ArgumentException">
		/// The SelectionUnit of the DataGrid must be set to FullRow.
		/// or
		/// </exception>
		public static void SelectSingleRow(DataGrid dataGrid, int rowIndex)
		{
			if (! dataGrid.SelectionUnit.Equals(DataGridSelectionUnit.FullRow))
			{
				throw (new ArgumentException("The SelectionUnit of the DataGrid must be set to FullRow."));
			}
			
			if (rowIndex < 0 || rowIndex > (dataGrid.Items.Count - 1))
			{
				throw (new ArgumentException(string.Format("{0} is an invalid row index.", rowIndex)));
			}
			
			dataGrid.SelectedItems.Clear();
			// set the SelectedItem property
			
			object item = dataGrid.Items[rowIndex];
			// = Product X
			dataGrid.SelectedItem = item;
			
			DataGridRow row = dataGrid.ItemContainerGenerator.ContainerFromIndex(rowIndex) as DataGridRow;
			if (row == null)
			{
				// bring the data item (Product object) into view
				//             * in case it has been virtualized away
				
				dataGrid.ScrollIntoView(item);
				row = dataGrid.ItemContainerGenerator.ContainerFromIndex(rowIndex) as DataGridRow;
			}
			//TODO: Retrieve and focus a DataGridCell object
		}
		
		/// <summary>
		/// Converts the data grid to data table.
		/// </summary>
		/// <param name="dg">The datagrid.</param>
		/// <returns></returns>
		public static DataTable ConvertDataGridToDataTable(DataGrid dg)
		{
			//Dim o As Object = dataTable.Rows.Item(0).Item("ColumnNameOrIndex")
			dg.SelectAllCells();
			dg.ClipboardCopyMode = DataGridClipboardCopyMode.IncludeHeader;
			ApplicationCommands.Copy.Execute(null, dg);
			dg.UnselectAllCells();
			string result = (string) (Clipboard.GetData(DataFormats.CommaSeparatedValue));
			string[] Lines = result.Split(new string[] {Constants.vbCr + Constants.vbLf, Constants.vbLf}, StringSplitOptions.None);
			string[] Fields;
			Fields = Lines[0].Split(new char[] {','});
			int Cols = Fields.GetLength(0);
			
			DataTable dt = new DataTable();
			for (int i = 0; i <= Cols - 1; i++)
			{
				dt.Columns.Add((string) (Fields[i].ToUpper()), typeof(string));
			}
			DataRow Row;
			for (int i = 1; i <= Lines.GetLength(0) - 2; i++)
			{
				Fields = Lines[i].Split(new char[] {','});
				Row = dt.NewRow();
				for (int f = 0; f <= Cols - 1; f++)
				{
					Row[f] = Fields[f];
				}
				dt.Rows.Add(Row);
			}
			return dt;
			
		}
		
		public static string getSelectedCellValue(DataGrid DG, string ColName)
		{
			object item = DG.SelectedItem;
			int iCol = getColumnIndexByName(DG, ColName);
			string strItem = DG.SelectedCells[iCol].Column.GetCellContent(item).ToString();
			return strItem;
		}
		
		private int FindRowIndex(DataGridRow row)
		{
			DataGrid dataGrid = ItemsControl.ItemsControlFromItemContainer(row) as DataGrid;
			
			int index = dataGrid.ItemContainerGenerator.IndexFromContainer(row);
			
			return index;
		}
		
		/// <summary>
		/// Gets the selected cell value for a single selected cell and returns that value as a string.
		/// </summary>
		/// <param name="DG">The datagrid.</param>
		/// <returns></returns>
		public static string getSelectedCellValue(DataGrid DG)
		{
			var cellInfo = DG.SelectedCells[0];
			var content = (cellInfo.Column.GetCellContent(cellInfo.Item) as TextBlock).Text;
			return content;
		}
		
		public static string ExportGridToTEXT(DataGrid DG, string UserID)
		{
			
			DG.ClipboardCopyMode = DataGridClipboardCopyMode.IncludeHeader;
			string result = Clipboard.GetData(DataFormats.Text).ToString();
			
			IsolatedStorageFile isoStore = IsolatedStorageFile.GetStore(IsolatedStorageScope.User || IsolatedStorageScope.Assembly, null, null);
			string FQN = UserID + ".Export.txt";
			string Msg = (string) ("GRID exported to: " + FQN);
			try
			{
				//Dim sw As New StreamWriter(Server.MapPath("~/GridData.csv"), False)
				// First we will write the headers.
				DataTable dt = ((DataSet) DG.ItemsSource).Tables[0];
				
				using (IsolatedStorageFileStream isoStream = new IsolatedStorageFileStream(FQN, FileMode.Create, isoStore))
				{
					using (StreamWriter writer = new StreamWriter(isoStream))
					{
						writer.Write(result);
					}
					
				}
				
			}
			catch (Exception ex)
			{
				Msg = (string) ("ERROR: " + ex.Message);
			}
			
			return Msg;
		}
		
		public static string ExportGridToHTML(DataGrid DG, string UserID)
		{
			
			DG.ClipboardCopyMode = DataGridClipboardCopyMode.IncludeHeader;
			string result = (string) (Clipboard.GetData(DataFormats.Html));
			
			IsolatedStorageFile isoStore = IsolatedStorageFile.GetStore(IsolatedStorageScope.User || IsolatedStorageScope.Assembly, null, null);
			string FQN = UserID + ".Export.HTML";
			string Msg = (string) ("GRID exported to: " + FQN);
			try
			{
				//Dim sw As New StreamWriter(Server.MapPath("~/GridData.csv"), False)
				// First we will write the headers.
				DataTable dt = ((DataSet) DG.ItemsSource).Tables[0];
				
				using (IsolatedStorageFileStream isoStream = new IsolatedStorageFileStream(FQN, FileMode.Create, isoStore))
				{
					using (StreamWriter writer = new StreamWriter(isoStream))
					{
						writer.Write(result);
					}
					
				}
				
			}
			catch (Exception ex)
			{
				Msg = (string) ("ERROR: " + ex.Message);
			}
			
			return Msg;
		}
		
		public static string ExportGridToCSV(DataGrid DG, string UserID)
		{
			
			DG.ClipboardCopyMode = DataGridClipboardCopyMode.IncludeHeader;
			string result = (string) (Clipboard.GetData(DataFormats.CommaSeparatedValue));
			
			IsolatedStorageFile isoStore = IsolatedStorageFile.GetStore(IsolatedStorageScope.User || IsolatedStorageScope.Assembly, null, null);
			string FQN = UserID + ".Export.csv";
			string Msg = (string) ("GRID exported to: " + FQN);
			try
			{
				//Dim sw As New StreamWriter(Server.MapPath("~/GridData.csv"), False)
				// First we will write the headers.
				DataTable dt = ((DataSet) DG.ItemsSource).Tables[0];
				
				using (IsolatedStorageFileStream isoStream = new IsolatedStorageFileStream(FQN, FileMode.Create, isoStore))
				{
					using (StreamWriter writer = new StreamWriter(isoStream))
					{
						writer.Write(result);
					}
					
				}
				
			}
			catch (Exception ex)
			{
				Msg = (string) ("ERROR: " + ex.Message);
			}
			
			return Msg;
		}
		
		public static DataGridCell GetCell(DataGrid dataGrid, DataGridRow rowContainer, int column)
		{
			if (rowContainer != null)
			{
				DataGridCellsPresenter presenter = FindVisualChild<DataGridCellsPresenter>(rowContainer);
				if (presenter == null)
				{
					// if the row has been virtualized away, call its ApplyTemplate() method
					//             * to build its visual tree in order for the DataGridCellsPresenter
					//             * and the DataGridCells to be created
					rowContainer.ApplyTemplate();
					presenter = FindVisualChild<DataGridCellsPresenter>(rowContainer);
				}
				if (presenter != null)
				{
					DataGridCell cell = presenter.ItemContainerGenerator.ContainerFromIndex(column) as DataGridCell;
					if (cell == null)
					{
						// bring the column into view in case it has been virtualized away
						dataGrid.ScrollIntoView(rowContainer, dataGrid.Columns[column]);
						cell = presenter.ItemContainerGenerator.ContainerFromIndex(column) as DataGridCell;
					}
					return cell;
				}
			}
			return null;
		}
		
		public static DataTable CreateDataTable(string TableName, Dictionary<string, string> TableCols)
		{
			
			string ColumnType = "";
			System.Data.DataTable dt = new DataTable(TableName);
			foreach (string sKey in TableCols.Keys)
			{
				sKey = sKey.ToString();
				ColumnType = (string) (TableCols(sKey).ToUpper);
				if (ColumnType.Equals("USHORT"))
				{
					dt.Columns.Add(sKey, typeof(UInt16));
				}
				if (ColumnType.Equals("UINT32"))
				{
					dt.Columns.Add(sKey, typeof(UInt32));
				}
				if (ColumnType.Equals("UINT64"))
				{
					dt.Columns.Add(sKey, typeof(UInt64));
				}
				if (ColumnType.Equals("UINTEGER"))
				{
					dt.Columns.Add(sKey, typeof(UInt32));
				}
				if (ColumnType.Equals("ULONG"))
				{
					dt.Columns.Add(sKey, typeof(UInt64));
				}
				if (ColumnType.Equals("SINGLE"))
				{
					dt.Columns.Add(sKey, typeof(Single));
				}
				if (ColumnType.Equals("INT16"))
				{
					dt.Columns.Add(sKey, typeof(short));
				}
				if (ColumnType.Equals("SHORT"))
				{
					dt.Columns.Add(sKey, typeof(short));
				}
				if (ColumnType.Equals("SBYTE"))
				{
					dt.Columns.Add(sKey, typeof(SByte));
				}
				if (ColumnType.Equals("OBJECT"))
				{
					dt.Columns.Add(sKey, typeof(object));
				}
				if (ColumnType.Equals("DATETIME"))
				{
					dt.Columns.Add(sKey, typeof(DateTime));
				}
				if (ColumnType.Equals("DATE"))
				{
					dt.Columns.Add(sKey, typeof(DateTime));
				}
				if (ColumnType.Equals("CHAR"))
				{
					dt.Columns.Add(sKey, typeof(char));
				}
				if (ColumnType.Equals("BOOLEAN"))
				{
					dt.Columns.Add(sKey, typeof(bool));
				}
				if (ColumnType.Equals("BYTE"))
				{
					dt.Columns.Add(sKey, typeof(byte));
				}
				if (ColumnType.Equals("INTEGER"))
				{
					dt.Columns.Add(sKey, typeof(int));
				}
				if (ColumnType.Equals("LONG"))
				{
					dt.Columns.Add(sKey, typeof(long));
				}
				if (ColumnType.Equals("INT32"))
				{
					dt.Columns.Add(sKey, typeof(int));
				}
				if (ColumnType.Equals("INT64"))
				{
					dt.Columns.Add(sKey, typeof(long));
				}
				if (ColumnType.Equals("DECIMAL"))
				{
					dt.Columns.Add(sKey, typeof(decimal));
				}
				if (ColumnType.Equals("FLOAT"))
				{
					dt.Columns.Add(sKey, typeof(double));
				}
				if (ColumnType.Equals("STRING"))
				{
					dt.Columns.Add(sKey, typeof(string));
				}
			}
			//dt.Rows.Add("row of data")
			return dt;
		}
		
	}
	
	public class tempdata
	{
		public string name;
		public string email;
		public int age;
		public decimal dec;
		
		public object dg_name
		{
			get
			{
				return name;
			}
			set
			{
				name = value.ToString();
			}
		}
		public object dg_email
		{
			get
			{
				return email;
			}
			set
			{
				email = value.ToString();
			}
		}
		public object dg_age
		{
			get
			{
				return age;
			}
			set
			{
				age = System.Convert.ToInt32(value);
			}
		}
		public object dg_decimal
		{
			get
			{
				return dec;
			}
			set
			{
				dec = System.Convert.ToDecimal(value);
			}
		}
	}
}
