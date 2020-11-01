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

using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Data.Sql;



namespace ECMSearchWPF
{
	public class clsSAVEDITEMS
	{
		
		
		//** DIM the selected table columns
		clsDma DMA = new clsDma();
		clsUtility UTIL = new clsUtility();
		clsLogging LOG = new clsLogging();
		string Userid = "";
		string SaveName = "";
		string SaveTypeCode = "";
		string ValName = "";
		string ValValue = "";
		
		//** Generate the SET methods
		public void setUserid(ref object val)
		{
			if (Strings.Len(val) == 0)
			{
				MessageBox.Show("SET: Field \'Userid\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val.ToString());
			Userid = val.ToString();
		}
		
		
		public void setSavename(ref object val)
		{
			if (Strings.Len(val) == 0)
			{
				MessageBox.Show("SET: Field \'Savename\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val.ToString());
			SaveName = val.ToString();
		}
		
		
		public void setSavetypecode(ref object val)
		{
			if (Strings.Len(val) == 0)
			{
				MessageBox.Show("SET: Field \'Savetypecode\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val.ToString());
			SaveTypeCode = val.ToString();
		}
		
		
		public void setValname(ref object val)
		{
			if (Strings.Len(val) == 0)
			{
				MessageBox.Show("SET: Field \'Valname\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val.ToString());
			ValName = val.ToString();
		}
		
		
		public void setValvalue(ref object val)
		{
			if (Strings.Len(val) == 0)
			{
				MessageBox.Show("SET: Field \'Valvalue\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val.ToString());
			ValValue = val.ToString();
		}
		
		
		
		
		
		
		//** Generate the GET methods
		public string getUserid()
		{
			if (Userid.Length == 0)
			{
				MessageBox.Show("GET: Field \'Userid\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(Userid);
		}
		
		
		public string getSavename()
		{
			if (SaveName.Length == 0)
			{
				MessageBox.Show("GET: Field \'Savename\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(SaveName);
		}
		
		
		public string getSavetypecode()
		{
			if (SaveTypeCode.Length == 0)
			{
				MessageBox.Show("GET: Field \'Savetypecode\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(SaveTypeCode);
		}
		
		
		public string getValname()
		{
			if (ValName.Length == 0)
			{
				MessageBox.Show("GET: Field \'Valname\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(ValName);
		}
		
		
		public string getValvalue()
		{
			if (ValValue.Length == 0)
			{
				MessageBox.Show("GET: Field \'Valvalue\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(ValValue);
		}
		
		
		
		
		
		
		//** Generate the Required Fields Validation method
		public bool ValidateReqData()
		{
			if (Userid.Length == 0)
			{
				return false;
			}
			if (SaveName.Length == 0)
			{
				return false;
			}
			if (SaveTypeCode.Length == 0)
			{
				return false;
			}
			if (ValName.Length == 0)
			{
				return false;
			}
			if (ValValue.Length == 0)
			{
				return false;
			}
			return true;
		}
		
		
		
		
		//** Generate the Validation method
		public bool ValidateData()
		{
			if (Userid.Length == 0)
			{
				return false;
			}
			if (SaveName.Length == 0)
			{
				return false;
			}
			if (SaveTypeCode.Length == 0)
			{
				return false;
			}
			if (ValName.Length == 0)
			{
				return false;
			}
			if (ValValue.Length == 0)
			{
				return false;
			}
			return true;
		}
		
		
		
		
		//** Generate the INSERT method
		public bool Insert()
		{
			bool b = true;
			string s = "";
			s = s + " INSERT INTO SavedItems(";
			s = s + "Userid,";
			s = s + "SaveName,";
			s = s + "SaveTypeCode,";
			s = s + "ValName,";
			s = s + "ValValue) values (";
			s = s + "\'" + Userid + "\'" + ",";
			s = s + "\'" + SaveName + "\'" + ",";
			s = s + "\'" + SaveTypeCode + "\'" + ",";
			s = s + "\'" + ValName + "\'" + ",";
			s = s + "\'" + ValValue + "\'" + ")";
			modGlobals.ExecuteSql(GLOBALS._SecureID.ToString(), s);
			
			return b;
			
		}
		
		
		
		
		//** Generate the UPDATE method
		public bool Update(object WhereClause)
		{
			bool b = true;
			string s = "";
			
			
			if (Strings.Len(WhereClause) == 0)
			{
				return false;
			}
			
			
			s = s + " update SavedItems set ";
			s = s + "Userid = \'" + getUserid() + "\'" + ", ";
			s = s + "SaveName = \'" + getSavename() + "\'" + ", ";
			s = s + "SaveTypeCode = \'" + getSavetypecode() + "\'" + ", ";
			s = s + "ValName = \'" + getValname() + "\'" + ", ";
			s = s + "ValValue = \'" + getValvalue() + "\'";
			WhereClause = " " + WhereClause;
			s = s + WhereClause;
			modGlobals.ExecuteSql(GLOBALS._SecureID.ToString(), s);
			return b;
		}
		
		//** Generate the DELETE method
		public bool Delete(object WhereClause)
		{
			bool b = true;
			string s = "";
			
			
			if (Strings.Len(WhereClause) == 0)
			{
				return false;
			}
			
			
			WhereClause = " " + WhereClause;
			
			
			s = " Delete from SavedItems";
			s = s + WhereClause;
			
			
			modGlobals.ExecuteSql(GLOBALS._SecureID.ToString(), s);
			return b;
			
			
		}
		
		
		
		
		//** Generate the Zeroize Table method
		public bool Zeroize()
		{
			bool b = true;
			string s = "";
			
			s = s + " Delete from SavedItems";
			
			modGlobals.ExecuteSql(GLOBALS._SecureID.ToString(), s);
			return b;
			
			
		}
		
		
		
		
		//'** Generate Index Queries
		//Public Function cnt_PK_SavedItems(ByVal SaveName As String, ByVal SaveTypeCode As String, ByVal Userid As String, ByVal ValName As String) As Integer
		
		
		//    Dim B As Integer = 0
		//    Dim TBL$ = "SavedItems"
		//    Dim WC$ = "Where SaveName = '" + SaveName + "' and   SaveTypeCode = '" + SaveTypeCode + "' and   Userid = '" + Userid + "' and   ValName = '" + ValName + "'"
		
		
		//    B = DB.iGetRowCount(TBL$, WC)
		
		
		//    Return B
		//End Function     '** cnt_PK_SavedItems
		
		
		//'** Generate Index ROW Queries
		//Public Function getRow_PK_SavedItems(ByVal SaveName As String, ByVal SaveTypeCode As String, ByVal Userid As String, ByVal ValName As String) As SqlDataReader
		
		
		//    Dim rsData As SqlDataReader = Nothing
		//    Dim TBL$ = "SavedItems"
		//    Dim WC$ = "Where SaveName = '" + SaveName + "' and   SaveTypeCode = '" + SaveTypeCode + "' and   Userid = '" + Userid + "' and   ValName = '" + ValName + "'"
		
		
		//    rsData = DB.GetRowByKey(TBL$, WC)
		
		
		//    If rsData.HasRows Then
		//        Return rsData
		//    Else
		//        Return Nothing
		//    End If
		//End Function     '** getRow_PK_SavedItems
		
		
		/// Build Index Where Caluses
		///
		public string wc_PK_SavedItems(string SaveName, string SaveTypeCode, string Userid, string ValName)
		{
			
			
			var WC = "Where SaveName = \'" + SaveName + "\' and   SaveTypeCode = \'" + SaveTypeCode + "\' and   Userid = \'" + Userid + "\' and   ValName = \'" + ValName + "\'";
			
			
			return WC;
		} //** wc_PK_SavedItems
	}
	
}
