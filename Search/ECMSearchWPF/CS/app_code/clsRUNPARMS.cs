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
using System.IO;

//Imports System.Data.SqlClient
//Imports System.Data.Sql


namespace ECMSearchWPF
{
	public class clsRUNPARMS
	{
		
		
		//** DIM the selected table columns
		//    Dim DB As New clsDatabase
		clsDma DMA = new clsDma();
		clsUtility UTIL = new clsUtility();
		clsLogging LOG = new clsLogging();
		
		
		
		string Parm = "";
		string ParmValue = "";
		string UserID = "";
		
		
		
		
		//** Generate the SET methods
		public void setParm(ref object val)
		{
			if (Strings.Len(val) == 0)
			{
				MessageBox.Show("SET: Field \'Parm\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val.ToString());
			Parm = val.ToString();
		}
		
		
		public void setParmvalue(ref object val)
		{
			val = UTIL.RemoveSingleQuotes(val.ToString());
			ParmValue = val.ToString();
		}
		
		
		public void setUserid(ref object val)
		{
			if (Strings.Len(val) == 0)
			{
				MessageBox.Show("SET: Field \'Userid\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val.ToString());
			UserID = val.ToString();
		}
		
		
		
		
		
		
		//** Generate the GET methods
		public string getParm()
		{
			if (Parm.Length == 0)
			{
				MessageBox.Show("GET: Field \'Parm\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(Parm);
		}
		
		
		public string getParmvalue()
		{
			return UTIL.RemoveSingleQuotes(ParmValue);
		}
		
		
		public string getUserid()
		{
			if (UserID.Length == 0)
			{
				MessageBox.Show("GET: Field \'Userid\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(UserID);
		}
		
		
		
		
		
		
		//** Generate the Required Fields Validation method
		public bool ValidateReqData()
		{
			if (Parm.Length == 0)
			{
				return false;
			}
			if (UserID.Length == 0)
			{
				return false;
			}
			return true;
		}
		
		
		
		
		//** Generate the Validation method
		public bool ValidateData()
		{
			if (Parm.Length == 0)
			{
				return false;
			}
			if (UserID.Length == 0)
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
			s = s + " INSERT INTO RunParms(";
			s = s + "Parm,";
			s = s + "ParmValue,";
			s = s + "UserID) values (";
			s = s + "\'" + Parm + "\'" + ",";
			s = s + "\'" + ParmValue + "\'" + ",";
			s = s + "\'" + UserID + "\'" + ")";
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
			
			
			s = s + " update RunParms set ";
			//s = s + "Parm = '" + getParm() + "'" + ", "
			s = s + "ParmValue = \'" + getParmvalue() + "\'" + ", ";
			s = s + "UserID = \'" + getUserid() + "\'";
			WhereClause = " " + WhereClause;
			s = s + WhereClause;
			modGlobals.ExecuteSql(GLOBALS._SecureID.ToString(), s);
			return b;
		}
		
		
		
		
		//'** Generate the SELECT method
		//Public Function SelectRecs() As SqlDataReader
		//    Dim b As Boolean = true
		//    Dim s As String = ""
		//    Dim rsData As SqlDataReader
		//    s = s + " SELECT "
		//    s = s + "Parm,"
		//    s = s + "ParmValue,"
		//    s = s + "UserID "
		//    s = s + " FROM RunParms"
		
		//    Dim CS$ = db.getConnStr() : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(S, CONN) : rsdata = command.ExecuteReader()
		//    Return rsData
		//End Function
		
		
		
		
		//'** Generate the Select One Row method
		//Public Function SelectOne(ByVal WhereClause$) As SqlDataReader
		//    Dim b As Boolean = true
		//    Dim s As String = ""
		//    Dim rsData As SqlDataReader
		//    s = s + " SELECT "
		//    s = s + "Parm,"
		//    s = s + "ParmValue,"
		//    s = s + "UserID "
		//    s = s + " FROM RunParms "
		//    s = s + WhereClause
		
		//    Dim CS$ = db.getConnStr() : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(S, CONN) : rsdata = command.ExecuteReader()
		//    Return rsData
		//End Function
		
		
		
		
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
			
			
			s = " Delete from RunParms ";
			s = s + WhereClause;
			
			return b;
			
			
		}
		
		
		
		
		//** Generate the Zeroize Table method
		public bool Zeroize()
		{
			bool b = true;
			string s = "";
			
			
			s = s + " Delete from RunParms ";
			
			
			modGlobals.ExecuteSql(GLOBALS._SecureID.ToString(), s);
			return b;
			
			
		}
		
		
		
		
		//'** Generate Index Queries
		//Public Function cnt_PKI8(ByVal Parm As String, ByVal UserID As String) As Integer
		
		
		//    Dim B As Integer = 0
		//    Dim TBL$ = "RunParms"
		//    Dim WC$ = "Where Parm = '" + Parm + "' and   UserID = '" + UserID + "'"
		
		
		//    B = DB.iGetRowCount(TBL$, WC)
		
		
		//    Return B
		//End Function     '** cnt_PKI8
		
		
		//'** Generate Index ROW Queries
		//Public Function getRow_PKI8(ByVal Parm As String, ByVal UserID As String) As SqlDataReader
		
		//    Dim rsData As SqlDataReader = Nothing
		//    Dim TBL$ = "RunParms"
		//    Dim WC$ = "Where Parm = '" + Parm + "' and   UserID = '" + UserID + "'"
		
		//    rsData = DB.GetRowByKey(TBL$, WC)
		//    If rsData Is Nothing Then
		//        Return Nothing
		//    End If
		//    If rsData.HasRows Then
		//        Return rsData
		//    Else
		//        Return Nothing
		//    End If
		//End Function     '** getRow_PKI8
		
		
		/// Build Index Where Caluses
		///
		public string wc_PKI8(string Parm, string UserID)
		{
			
			
			var WC = "Where Parm = \'" + Parm + "\' and   UserID = \'" + UserID + "\'";
			
			
			return WC;
		} //** wc_PKI8
		
		
		//** Generate the SET methods
		
		
	}
	
}
