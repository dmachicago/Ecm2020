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

using System.Configuration;
using System.Data.SqlClient;

//Imports System.Windows.Forms.DataGridView
namespace EcmArchiveClcSetup
{
	public class clsDataGrid : clsDatabase
	{
		
		//Dim DB As New clsDatabase
		clsDma DMA = new clsDma();
		clsUtility UTIL = new clsUtility();
		clsLogging LOG = new clsLogging();
		
		clsSql SQL = new clsSql();
		int iSequence_number = 0;
		int iSHORT_REMARK = 1;
		int iSTD_UNIT = 2;
		int iEFFECTIVE_DATE = 3;
		int iINEFFECTIVE_DATE = 4;
		int iMeasurement_id = 5;
		int iSkip = 6;
		int iStd_component_id = 7;
		int iShort_remark2 = 0;
		int iEeffective_date2 = 1;
		int iIneffective_date2 = 2;
		int iMeasurement_id2 = 3;
		string Sequence_number = "";
		string SHORT_REMARK = "";
		string STD_UNIT = "";
		string EFFECTIVE_DATE = "";
		string INEFFECTIVE_DATE = "";
		string Measurement_id = "";
		string Skip = "";
		string Std_component_id = "";
		string ComponentID = "";
		
		public string GetColValue(string ColName, DataGridView DG)
		{
			int iRow = 0;
			iRow = DG.CurrentRow.Index;
			string S = DG[ColName, iRow].Value.ToString();
			return S;
		}
		public int iCol(double ColName, DataGridView DG)
		{
			int i = 0;
			int j = 0;
			if (DG.Columns.Count > 0)
			{
				j = DG.Columns.Count;
				for (i = 0; i <= j - 1; i++)
				{
					//messagebox.show("Validate next stmt")
					string tColName = DG.Columns[i].ToString();
					if (Strings.StrComp(tColName, ColName, CompareMethod.Text) == 0)
					{
						return i;
					}
				}
			}
			else
			{
				return -1;
			}
			return -1;
		}
		public void PopulateDataGrid(string S, DataGridView DG, ref string[] dgColNames)
		{
			try
			{
				int i = 0;
				string[] dgKeys;
				SqlDataReader rsData = null;
				bool b = false;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				rsData = command.ExecuteReader();
				if (rsData == null)
				{
					return;
				}
				int nbrCols = rsData.FieldCount;
				dgColNames = new string[nbrCols + 1];
				if (DG.Columns.Count > 0)
				{
					DG.Columns.Clear();
				}
				DG.Rows.Clear();
				for (i = 0; i <= nbrCols - 1; i++)
				{
					DG.Columns.Add(rsData.GetName(i).ToString(), rsData.GetName(i).ToString());
					dgColNames[i] = rsData.GetName(i).ToString();
				}
				int II = nbrCols;
				DG.Rows.Clear();
				if (rsData.HasRows)
				{
					dgKeys = new string[II + 1];
					bool ColNamesSet = false;
					while (rsData.Read())
					{
						for (i = 0; i <= II - 1; i++)
						{
							dgKeys[i] = rsData.GetValue(i).ToString();
							if (! ColNamesSet)
							{
								dgColNames[i] = rsData.GetName(i).ToString();
							}
						}
						ColNamesSet = true;
						DG.Rows.Add(dgKeys);
					}
				}
				//For i = 6 To II - 1
				//    DG.Columns(i).Visible = False
				//Next i
				rsData.Close();
				rsData = null;
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("Error: clsDAtaGrid - PopulateDataGrid - 100:  " + ex.Message));
				LOG.WriteToArchiveLog((string) ("Error: clsDAtaGrid - PopulateDataGrid - 100:  " + ex.StackTrace));
				LOG.WriteToArchiveLog((string) ("Error: clsDAtaGrid - PopulateDataGrid - 100:  " + S));
			}
			
		}
		public void PopulateDataGrid(string S, DataGridView DG)
		{
			int i = 0;
			string[] dgKeys;
			string[] dgColNames;
			SqlDataReader rsData = null;
			bool b = false;
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			rsData = command.ExecuteReader();
			if (rsData == null)
			{
				return;
			}
			int nbrCols = rsData.FieldCount - 1;
			dgColNames = new string[nbrCols + 1];
			if (DG.Columns.Count > 0)
			{
				DG.Columns.Clear();
			}
			DG.Rows.Clear();
			for (i = 0; i <= nbrCols - 1; i++)
			{
				DG.Columns.Add(rsData.GetName(i).ToString(), rsData.GetName(i).ToString());
				dgColNames[i] = rsData.GetName(i).ToString();
			}
			int II = nbrCols;
			DG.Rows.Clear();
			if (rsData.HasRows)
			{
				dgKeys = new string[II + 1];
				bool ColNamesSet = false;
				while (rsData.Read())
				{
					for (i = 0; i <= II - 1; i++)
					{
						dgKeys[i] = rsData.GetValue(i).ToString();
						if (! ColNamesSet)
						{
							dgColNames[i] = rsData.GetName(i).ToString();
						}
					}
					ColNamesSet = true;
					DG.Rows.Add(dgKeys);
				}
			}
			//For i = 6 To II - 1
			//    DG.Columns(i).Visible = False
			//Next i
			rsData.Close();
			rsData = null;
		}
		public void PopulateColGrid(DataGridView DG, string TblID)
		{
			string[] dgColNames;
			SqlDataReader rsdata = SQL.getAllColsSql(TblID);
			int i = 0;
			string[] dgKeys;
			//Dim rsData As SqlDataReader = Nothing
			bool b = false;
			//rsData = DB.SqlQry(SQL, rsData)
			if (rsdata == null)
			{
				return;
			}
			int nbrCols = rsdata.FieldCount;
			dgColNames = new string[nbrCols + 1];
			if (DG.Columns.Count > 0)
			{
				DG.Columns.Clear();
			}
			for (i = 0; i <= nbrCols - 1; i++)
			{
				DG.Columns.Add(rsdata.GetName(i).ToString(), rsdata.GetName(i).ToString());
				dgColNames[i] = rsdata.GetName(i).ToString();
			}
			int II = nbrCols;
			DG.Rows.Clear();
			if (rsdata.HasRows)
			{
				dgKeys = new string[II + 1];
				bool ColNamesSet = false;
				while (rsdata.Read())
				{
					for (i = 0; i <= II - 1; i++)
					{
						dgKeys[i] = rsdata.GetValue(i).ToString();
						if (! ColNamesSet)
						{
							dgColNames[i] = rsdata.GetName(i).ToString();
						}
					}
					ColNamesSet = true;
					DG.Rows.Add(dgKeys);
				}
			}
			rsdata.Close();
			rsdata = null;
		}
		//Public Sub AppendDataGrid(ByVal SQL , ByRef DG As DataGridView, ByVal ColCnt As Integer)
		//    Dim i As Integer = 0
		//    Dim dgKeys ()
		//    Dim rsData As SqlDataReader = Nothing
		//    Dim b As Boolean = False
		//    rsData = SqlQry(SQL, rsData)
		//    If rsData Is Nothing Then
		//        Return
		//    End If
		//    Dim nbrCols As Integer = rsData.FieldCount
		//    If nbrCols <> ColCnt Then
		//        Return
		//    End If
		//    Dim II As Integer = nbrCols
		//    If rsData.HasRows Then
		//        ReDim dgKeys(II)
		//        Dim ColNamesSet As Boolean = False
		//        Do While rsData.Read
		//            For i = 0 To II - 1
		//                dgKeys(i) = rsData.GetValue(i).ToString
		//            Next i
		//            DG.Rows.Add(dgKeys)
		//        Loop
		//    End If
		//    rsData.Close()
		//    rsData = Nothing
		//End Sub
		//Public Sub PopulateDataGrid(ByVal SQL , ByRef DG As DataGridView, ByRef dgColNames (), ByVal PB As ProgressBar)
		//    Dim i As Integer = 0
		//    Dim dgKeys ()
		//    Dim rsData As SqlDataReader = Nothing
		//    Dim b As Boolean = False
		//    Dim iCnt As Integer = iGetRowCount(SQL)
		//    PB.Minimum = 0
		//    PB.Maximum = iCnt + 5
		//    frmWorkInProgress.Show()
		//    frmWorkInProgress.PB.Minimum = 0
		//    frmWorkInProgress.PB.Maximum = iCnt + 5
		//    frmWorkInProgress.SB.Text = "Loading: " + DG.Name
		//    Dim iRow As Integer = DG.Rows.Count
		//    If iRow > 1 Then
		//        DG.Rows.Clear()
		//    End If
		//    rsData = SqlQry(SQL, rsData)
		//    Dim nbrCols As Integer = rsData.FieldCount
		//    ReDim dgColNames(nbrCols)
		//    DG.Columns.Clear()
		//    For i = 0 To nbrCols - 1
		//        DG.Columns.Add(rsData.GetName(i).ToString, rsData.GetName(i).ToString)
		//        dgColNames(i) = rsData.GetName(i).ToString
		//    Next
		//    Dim II As Integer = nbrCols
		//    If rsData.HasRows Then
		//        ReDim dgKeys(II)
		//        Dim kk As Integer = 0
		//        Dim ColNamesSet As Boolean = False
		//        Do While rsData.Read
		//            kk = kk + 1
		//            If kk Mod 5 = 0 Then
		//                frmWorkInProgress.PB.Value = kk
		//                PB.Value = kk
		//                PB.Refresh()
		//                System.Windows.Forms.Application.DoEvents()
		//            End If
		//            For i = 0 To II - 1
		//                dgKeys(i) = rsData.GetValue(i).ToString
		//                If Not ColNamesSet Then
		//                    dgColNames(i) = rsData.GetName(i).ToString
		//                End If
		//            Next i
		//            ColNamesSet = True
		//            DG.Rows.Add(dgKeys)
		//        Loop
		//    End If
		//    'For i = 6 To II - 1
		//    '    DG.Columns(i).Visible = False
		//    'Next i
		//    rsData.Close()
		//    rsData = Nothing
		//    PB.Value = 0
		//    frmWorkInProgress.Hide()
		//End Sub
		public void DisplayColNames(DataGridView DG)
		{
			int i = 0;
			for (i = 0; i <= DG.Columns.Count - 1; i++)
			{
				//Console.WriteLine("Column#" & i & " : " & DG.Columns(i).Name)
				string msg = "Column#" + i.ToString() + " : " + DG.Columns[i].Name;
				Debug.Print(msg);
			}
		}
		public void DisplayColNames(DataGridView DG, SortedList SL)
		{
			int i = 0;
			string ColName = "";
			SL.Clear();
			for (i = 0; i <= DG.Columns.Count - 1; i++)
			{
				//Console.WriteLine("Column#" & i & " : " & DG.Columns(i).Name)
				string msg = "Column#" + i.ToString() + " : " + DG.Columns[i].Name;
				Debug.Print(msg);
				ColName = Strings.Mid((string) (DG.Columns[i].Name), 1, 1);
				SL.Add(i, ColName);
			}
		}
		public void ListColumnNames(DataGridView dg)
		{
			foreach (DataGridViewColumn column in dg.Columns)
			{
				Debug.Print(column.Name);
			}
		}
		public void DisplayHeaderNames(DataGridView DG)
		{
			int i = 0;
			for (i = 0; i <= DG.Columns.Count - 1; i++)
			{
				string msg = "Column#" + i.ToString() + " : " + DG.Columns[i].Name;
				Debug.Print(msg);
			}
		}
		//Public Sub AddGridColumns(ByRef DG As DataGridView, ByVal GridCols As String)
		//    Dim dgCols() As String = Split(GridCols, ",")
		//    Dim i As Integer = 0
		//    For i = 0 To UBound(dgCols) - 1
		//        DG.Columns.Add(dgCols(i), dgCols(i))
		//    Next
		//    Return
		//End Sub
		//Public Sub ZeroizeGridColumns(ByRef DG As DataGrid)
		//    'Dim dgCols() As String = Split(GridCols, ",")
		//    Dim i As Integer = 0
		//    Dim C As DataGridViewColumn
		//    For Each C In DG.Columns
		//        DG.Columns.Remove(C)
		//    Next
		//    Return
		//End Sub
		//Public Sub AddGridDataFromStr(ByRef DG As DataGridView, ByVal Str As String, ByVal Delimiter As String, ByVal bNewCols As Boolean)
		//    If Mid(Str, 1, 1) = Delimiter Then
		//        Mid(Str, 1, 1) = " "
		//    End If
		//    If Mid(Str, Len(Str), 1) = Delimiter Then
		//        Mid(Str, Len(Str), 1) = " "
		//    End If
		//    Str = Trim(Str)
		//    Dim cCnt As Integer = DG.ColumnCount
		//    If bNewCols Then
		//        Dim ii As Integer = 0
		//        Dim jj As Integer = 0
		//        Dim dgCols() As String = Split(Str, Delimiter)
		//        DG.Columns.Clear()
		//        For ii = 0 To UBound(dgCols)
		//            DG.Columns.Add(dgCols(ii), dgCols(ii))
		//        Next ii
		//    Else
		//        Dim dgKeys() As String = Split(Str, Delimiter)
		//        DG.Rows.Add(dgKeys)
		//    End If
		//End Sub
		public void HideGridCol(DataGridView DG, int ColNbr)
		{
			DG.Columns[ColNbr].Visible = false;
		}
		public void SetGridColHeader(DataGridView DG, int ColNbr, string ColTitle)
		{
			DG.Columns[ColNbr].HeaderText = ColTitle;
		}
		public int PopulateGrid(string SourceTable, string MySql, DataGridView DVG)
		{
			//System.Windows.Forms.DataGridViewCellEventArgs
			int II = 0;
			try
			{
				BindingSource BS = new BindingSource();
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection sqlcn = new SqlConnection(CS);
				SqlDataAdapter sadapt = new SqlDataAdapter(MySql, sqlcn);
				DataSet ds = new DataSet();
				if (sqlcn.State == ConnectionState.Closed)
				{
					sqlcn.Open();
				}
				sadapt.Fill(ds, SourceTable);
				II = ds.Tables[SourceTable].Rows.Count;
				DVG.DataSource = ds.Tables[SourceTable];
			}
			catch (Exception ex)
			{
				//messagebox.show("Search Error 96165.4b: " + ex.Message + vbCrLf + MySql)
				II = -1;
				LOG.WriteToArchiveLog((string) ("clsDataGrid : PopulateGrid : 96165.4b : " + ex.Message + "\r\n" + MySql));
			}
			return II;
		}
		public void saveGridColOrder(DataGridView G, Form F)
		{
			int I = 0;
			string FormName = F.Name;
			string ColName = "";
			
			clsRUNPARMS RUNPARMS = new clsRUNPARMS();
			
			try
			{
				ColName = FormName + "|" + G.Name + "|" + " ColOrderActive";
				int iCnt = RUNPARMS.cnt_PKI8(ColName, modGlobals.gCurrUserGuidID);
				if (iCnt == 0)
				{
					RUNPARMS.setParmvalue("Y");
					RUNPARMS.setParm(ref ColName);
					RUNPARMS.setUserid(ref modGlobals.gCurrUserGuidID);
					RUNPARMS.Insert();
				}
			}
			catch (Exception)
			{
				Console.WriteLine("saveGridColOrder Failed to set form grid active: " + ColName);
			}
			
			int iColCnt = G.ColumnCount;
			int iDisplayIndex = 0;
			for (I = 0; I <= iColCnt - 1; I++)
			{
				ColName = FormName + "|" + G.Name + "|" + G.Columns[I].Name;
				iDisplayIndex = G.Columns[I].DisplayIndex;
				int iCnt = RUNPARMS.cnt_PKI8(ColName, modGlobals.gCurrUserGuidID);
				if (iCnt == 0)
				{
					RUNPARMS.setParmvalue(iDisplayIndex.ToString());
					RUNPARMS.setParm(ref ColName);
					RUNPARMS.setUserid(ref modGlobals.gCurrUserGuidID);
					RUNPARMS.Insert();
				}
				else if (iCnt > 0)
				{
					RUNPARMS.setParmvalue(iDisplayIndex.ToString());
					RUNPARMS.setParm(ref ColName);
					RUNPARMS.setUserid(ref modGlobals.gCurrUserGuidID);
					string WC = RUNPARMS.wc_PKI8(ColName, modGlobals.gCurrUserGuidID);
					RUNPARMS.Update(WC);
				}
			}
			
			RUNPARMS = null;
			
			saveGridColWidth(G, F);
			
			GC.Collect();
			GC.WaitForFullGCComplete();
			
		}
		
		public void saveGridSortCol(DataGridView G, Form F, string ColName, bool AscendingOrder)
		{
			
			int I = 0;
			string FormName = F.Name;
			string SortColName = "";
			int ColOrderNbr = -1;
			
			for (I = 0; I <= G.Columns.Count - 1; I++)
			{
				string tgtCol = G.Columns[I].Name;
				if (tgtCol == ColName)
				{
					ColOrderNbr = I;
					break;
				}
			}
			
			clsRUNPARMS RUNPARMS = new clsRUNPARMS();
			string ParmName = "";
			try
			{
				SortColName = FormName + "|" + G.Name + "|" + ColName + "|" + ColOrderNbr.ToString() + "|" + AscendingOrder.ToString();
				ParmName = FormName + "|" + G.Name + "|" + "COLUMN_SORT";
				int iCnt = RUNPARMS.cnt_PKI8(ParmName, modGlobals.gCurrUserGuidID);
				if (iCnt == 0)
				{
					RUNPARMS.setParmvalue(ref SortColName);
					RUNPARMS.setParm(ref ParmName);
					RUNPARMS.setUserid(ref modGlobals.gCurrUserGuidID);
					RUNPARMS.Insert();
				}
				else
				{
					string WC = RUNPARMS.wc_PKI8(ParmName, modGlobals.gCurrUserGuidID);
					RUNPARMS.setParmvalue(ref SortColName);
					RUNPARMS.setParm(ref ParmName);
					RUNPARMS.setUserid(ref modGlobals.gCurrUserGuidID);
					RUNPARMS.Update(WC);
				}
			}
			catch (Exception)
			{
				Console.WriteLine("saveGridSortCol Failed to set form grid sort: " + ColName);
			}
			
			RUNPARMS = null;
			
			GC.Collect();
			GC.WaitForFullGCComplete();
			
		}
		public void getGridSortCol(DataGridView G, Form F)
		{
			
			
			//SortColName  = FormName + "|" + G.Name + "|" + "Sort" + "|" + ColName  + "|" + ColOrderNbr.ToString + "|" + AscendingOrder.ToString
			string tFormName = "";
			string tGridName = "";
			int tColOrderNbr = -1;
			string tAscendingOrder = "";
			string tColName = "";
			
			string ParmName = F.Name + "|" + G.Name + "|" + "COLUMN_SORT";
			
			int I = 0;
			string FormName = F.Name;
			string Parm = "";
			
			bool bSetOrder = false;
			
			SortedList<int, string> GridOrder = new SortedList<int, string>();
			clsRUNPARMS RUNPARMS = new clsRUNPARMS();
			int iCnt = RUNPARMS.cnt_PKI8(ParmName, modGlobals.gCurrUserGuidID);
			
			if (iCnt == 1)
			{
				string WC = RUNPARMS.wc_PKI8(ParmName, modGlobals.gCurrUserGuidID);
				SqlDataReader RS;
				RS = RUNPARMS.SelectOne(WC);
				if (RS.HasRows)
				{
					RS.Read();
					Parm = RS.GetValue(0).ToString();
					string ParmValue = RS.GetValue(1).ToString();
					string UserID = RS.GetValue(2).ToString();
					if (ParmValue.IndexOf("|") + 1 > 0)
					{
						bSetOrder = true;
						//SortColName  = FormName + "|" + G.Name + "|" + ColName  + "|" + ColOrderNbr.ToString + "|" + AscendingOrder.ToString
						string[] A = ParmValue.Split("|".ToCharArray());
						tFormName = A[0];
						tGridName = A[1];
						tColName = A[2];
						tColOrderNbr = int.Parse(val[A[3]]);
						tAscendingOrder = A[4];
					}
				}
			}
			
			
			
			RUNPARMS = null;
			
			if (bSetOrder == true)
			{
				int ColOrderNbr = -1;
				for (I = 0; I <= G.Columns.Count - 1; I++)
				{
					string tgtCol = G.Columns[I].Name;
					if (tgtCol.ToUpper().Equals(tColName.ToUpper()))
					{
						ColOrderNbr = I;
						break;
					}
				}
				
				System.Windows.Forms.DataGridViewColumn DGVC = G.Columns[ColOrderNbr];
				if (tAscendingOrder.ToUpper().Equals("TRUE"))
				{
					G.Sort(DGVC, System.ComponentModel.ListSortDirection.Ascending);
				}
				else
				{
					G.Sort(DGVC, System.ComponentModel.ListSortDirection.Descending);
				}
				G.Refresh();
			}
			
			GC.Collect();
			GC.WaitForFullGCComplete();
			
		}
		
		public void saveGridColWidth(DataGridView G, Form F)
		{
			int I = 0;
			string FormName = F.Name;
			string ColName = "";
			
			clsRUNPARMS RUNPARMS = new clsRUNPARMS();
			int iColCnt = G.ColumnCount;
			int iWidth = 0;
			
			for (I = 0; I <= iColCnt - 1; I++)
			{
				ColName = FormName + "|" + G.Name + "|" + "Width|" + G.Columns[I].Name;
				iWidth = G.Columns[I].Width;
				int iCnt = RUNPARMS.cnt_PKI8(ColName, modGlobals.gCurrUserGuidID);
				if (iCnt == 0)
				{
					RUNPARMS.setParmvalue(iWidth.ToString());
					RUNPARMS.setParm(ref ColName);
					RUNPARMS.setUserid(ref modGlobals.gCurrUserGuidID);
					RUNPARMS.Insert();
				}
				else if (iCnt > 0)
				{
					RUNPARMS.setParmvalue(iWidth.ToString());
					RUNPARMS.setParm(ref ColName);
					RUNPARMS.setUserid(ref modGlobals.gCurrUserGuidID);
					string WC = RUNPARMS.wc_PKI8(ColName, modGlobals.gCurrUserGuidID);
					RUNPARMS.Update(WC);
				}
			}
			
			RUNPARMS = null;
			
			GC.Collect();
			GC.WaitForFullGCComplete();
			
		}
		public bool isGridColOrderActive(DataGridView G, Form F)
		{
			bool isActive = false;
			int I = 0;
			string FormName = F.Name;
			string ColName = "";
			
			clsRUNPARMS RUNPARMS = new clsRUNPARMS();
			
			try
			{
				ColName = FormName + "|" + G.Name + "|" + " ColOrderActive";
				int iCnt = RUNPARMS.cnt_PKI8(ColName, modGlobals.gCurrUserGuidID);
				if (iCnt == 1)
				{
					string WC = RUNPARMS.wc_PKI8(ColName, modGlobals.gCurrUserGuidID);
					SqlDataReader RS;
					RS = RUNPARMS.SelectOne(WC);
					if (RS.HasRows)
					{
						while (RS.Read())
						{
							string Parm = RS.GetValue(0).ToString();
							string ParmValue = RS.GetValue(1).ToString();
							string UserID = RS.GetValue(0).ToString();
							int iColOrder = int.Parse(val[ParmValue]);
							if (ParmValue.Equals("Y") || ParmValue.Equals("1"))
							{
								isActive = true;
							}
							else
							{
								isActive = false;
							}
						}
					}
				}
			}
			catch (Exception)
			{
				Console.WriteLine("isGridColOrderActive Failed to set form grid avtive: " + ColName);
			}
			RUNPARMS = null;
			
			GC.Collect();
			GC.WaitForFullGCComplete();
			
			return isActive;
		}
		public void getGridColOrder(ref DataGridView G, Form F)
		{
			
			if (isGridColOrderActive(G, F) == false)
			{
				return;
			}
			
			int I = 0;
			string FormName = F.Name;
			string ColName = "";
			
			SortedList<int, string> GridOrder = new SortedList<int, string>();
			clsRUNPARMS RUNPARMS = new clsRUNPARMS();
			
			int iColCnt = G.ColumnCount;
			
			for (I = 0; I <= iColCnt - 1; I++)
			{
				ColName = FormName + "|" + G.Name + "|" + G.Columns[I].Name;
				int iCnt = RUNPARMS.cnt_PKI8(ColName, modGlobals.gCurrUserGuidID);
				if (iCnt == 1)
				{
					string WC = RUNPARMS.wc_PKI8(ColName, modGlobals.gCurrUserGuidID);
					SqlDataReader RS;
					RS = RUNPARMS.SelectOne(WC);
					if (RS.HasRows)
					{
						while (RS.Read())
						{
							string Parm = RS.GetValue(0).ToString();
							string ParmValue = RS.GetValue(1).ToString();
							string UserID = RS.GetValue(0).ToString();
							int iColOrder = int.Parse(val[ParmValue]);
							if (GridOrder.ContainsKey(iColOrder))
							{
							}
							else
							{
								GridOrder.Add(iColOrder, G.Columns[I].Name);
							}
						}
					}
				}
			}
			
			for (I = 0; I <= GridOrder.Count - 1; I++)
			{
				ColName = GridOrder.Values(I);
				G.Columns[ColName].DisplayIndex = I;
			}
			RUNPARMS = null;
			
			getGridColWidth(ref G, F);
			
			G.Refresh();
			
			GC.Collect();
			GC.WaitForFullGCComplete();
			
		}
		public void getGridColWidth(ref DataGridView G, Form F)
		{
			
			if (isGridColOrderActive(G, F) == false)
			{
				return;
			}
			
			int I = 0;
			string FormName = F.Name;
			string ColName = "";
			
			SortedList<string, int> GridWidth = new SortedList<string, int>();
			clsRUNPARMS RUNPARMS = new clsRUNPARMS();
			
			int iColCnt = G.ColumnCount;
			
			for (I = 0; I <= iColCnt - 1; I++)
			{
				ColName = FormName + "|" + G.Name + "|" + "Width|" + G.Columns[I].Name;
				int iCnt = RUNPARMS.cnt_PKI8(ColName, modGlobals.gCurrUserGuidID);
				if (iCnt == 1)
				{
					string WC = RUNPARMS.wc_PKI8(ColName, modGlobals.gCurrUserGuidID);
					SqlDataReader RS;
					RS = RUNPARMS.SelectOne(WC);
					if (RS.HasRows)
					{
						while (RS.Read())
						{
							string Parm = RS.GetValue(0).ToString();
							string ParmValue = RS.GetValue(1).ToString();
							string UserID = RS.GetValue(0).ToString();
							int iColOrder = int.Parse(val[ParmValue]);
							if (GridWidth.ContainsKey(ColName))
							{
							}
							else
							{
								GridWidth.Add(ColName, val[ParmValue]);
							}
						}
					}
				}
			}
			
			foreach (string S in GridWidth.Keys)
			{
				ColName = S.ToString();
				int iKey = GridWidth.IndexOfKey(ColName);
				int ColWidth = GridWidth.Values(iKey);
				string[] A = new string[1];
				A = ColName.Split("|".ToCharArray());
				string tColName = A[(A.Length - 1)];
				try
				{
					G.Columns[tColName].Width = ColWidth;
				}
				catch (Exception)
				{
					G.Columns[tColName].Width = 100;
				}
				
			}
			RUNPARMS = null;
			
			G.Refresh();
			
			GC.Collect();
			GC.WaitForFullGCComplete();
			
		}
		
		public void removeGridColOrder(DataGridView G, Form F)
		{
			int I = 0;
			string FormName = F.Name;
			string ColName = "";
			
			SortedList<int, string> GridOrder = new SortedList<int, string>();
			clsRUNPARMS RUNPARMS = new clsRUNPARMS();
			
			int iColCnt = G.ColumnCount;
			
			for (I = 0; I <= iColCnt - 1; I++)
			{
				ColName = FormName + "|" + G.Name + "|" + G.Columns[I].Name;
				int iCnt = RUNPARMS.cnt_PKI8(ColName, modGlobals.gCurrUserGuidID);
				if (iCnt == 1)
				{
					string WC = RUNPARMS.wc_PKI8(ColName, modGlobals.gCurrUserGuidID);
					RUNPARMS.Delete(WC);
				}
			}
			
			RUNPARMS = null;
			G.Refresh();
			GC.Collect();
			GC.WaitForFullGCComplete();
			
			setDefaultGridColOrder(G, F);
			
		}
		public void setDefaultGridColOrder(DataGridView G, Form F)
		{
			int I = 0;
			string FormName = F.Name;
			string ColName = "";
			
			clsRUNPARMS RUNPARMS = new clsRUNPARMS();
			
			try
			{
				ColName = FormName + "|" + G.Name + "|" + " ColOrderActive";
				int iCnt = RUNPARMS.cnt_PKI8(ColName, modGlobals.gCurrUserGuidID);
				if (iCnt == 0)
				{
					RUNPARMS.setParmvalue("N");
					RUNPARMS.setParm(ref ColName);
					RUNPARMS.setUserid(ref modGlobals.gCurrUserGuidID);
					RUNPARMS.Insert();
				}
			}
			catch (Exception)
			{
				Console.WriteLine("saveGridColOrder Failed to set form grid avtive: " + ColName);
			}
			
			int iColCnt = G.ColumnCount;
			int iDisplayIndex = 0;
			for (I = 0; I <= iColCnt - 1; I++)
			{
				G.Columns[I].DisplayIndex = 9;
				//ColName = FormName + "|" + G.Name + "|" + G.Columns(I).Name
				//iDisplayIndex = I
				//Dim iCnt As Integer = RUNPARMS.cnt_PKI8(ColName, gCurrUserGuidID)
				//If iCnt = 0 Then
				//    RUNPARMS.setParmvalue(iDisplayIndex.ToString)
				//    RUNPARMS.setParm(ColName)
				//    RUNPARMS.setUserid(gCurrUserGuidID)
				//    RUNPARMS.Insert()
				//ElseIf iCnt > 0 Then
				//    RUNPARMS.setParmvalue(iDisplayIndex.ToString)
				//    RUNPARMS.setParm(ColName)
				//    RUNPARMS.setUserid(gCurrUserGuidID)
				//    Dim WC  = RUNPARMS.wc_PKI8(ColName, gCurrUserGuidID)
				//    RUNPARMS.Update(WC)
				//End If
			}
			
			RUNPARMS = null;
			G.Refresh();
			GC.Collect();
			GC.WaitForFullGCComplete();
			
		}
	}
	
	
}
