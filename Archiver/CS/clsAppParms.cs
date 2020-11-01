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
using System.IO;


namespace EcmArchiveClcSetup
{
	public class clsAppParms
	{
		public clsAppParms()
		{
			// VBConversions Note: Non-static class variable initialization is below.  Class variables cannot be initially assigned non-static values in C#.
			ErrLogFqn = LOG.getTempEnvironDir() + "\\ECMLibrary.AppParms.Log";
			
		}
		
		clsDma DMA = new clsDma();
		clsLogging LOG = new clsLogging();
		clsUtility UTIL = new clsUtility();
		
		SqlConnection AppConn = new SqlConnection();
		string ErrLogFqn; // VBConversions Note: Initial value of "LOG.getTempEnvironDir() + "\\ECMLibrary.AppParms.Log"" cannot be assigned here since it is non-static.  Assignment has been moved to the class constructors.
		clsDatabase DB = new clsDatabase();
		
		clsPROCESSFILEAS PFA = new clsPROCESSFILEAS();
		
		public void SaveSearch(string SaveName, string SaveTypeCode, string UID, string ValName, string ValValue)
		{
			try
			{
				clsSAVEDITEMS SI = new clsSAVEDITEMS();
				bool B = false;
				
				SI.setSavename(ref SaveName);
				SI.setSavetypecode(ref SaveTypeCode);
				SI.setUserid(ref UID);
				SI.setValname(ref ValName);
				if (ValValue.Length > 0)
				{
					SI.setValvalue(ref ValValue);
				}
				else
				{
					SI.setValvalue("null");
				}
				
				int I = SI.cnt_PK_SavedItems(SaveName, SaveTypeCode, UID, ValName);
				if (I == 0)
				{
					B = SI.Insert();
					if (! B)
					{
						LOG.WriteToArchiveLog("clsAppParms : SaveSearch : 00 Error failed to save a search item: " + SaveTypeCode + " : " + ValName + " : " + ValValue + ".");
					}
				}
				if (I > 0)
				{
					string WC = SI.wc_PK_SavedItems(SaveName, SaveTypeCode, UID, ValName);
					SI.Update(WC);
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog("clsAppParms : SaveSearch : 00A Error failed to save a search item: " + SaveTypeCode + " : " + ValName + " : " + ValValue + ".");
				LOG.WriteToArchiveLog((string) ("clsAppParms : SaveSearch : 00A Error failed to save a search item: " + ex.Message));
			}
			
			
		}
		public string SaveSearchParm(string SaveName, string SaveTypeCode, string UID, string ValName, string ValValue)
		{
			string S = "";
			SaveName = UTIL.RemoveSingleQuotes(SaveName);
			SaveTypeCode = UTIL.RemoveSingleQuotes(SaveTypeCode);
			ValName = UTIL.RemoveSingleQuotes(ValName);
			ValValue = UTIL.RemoveSingleQuotes(ValValue);
			try
			{
				S = SaveName + Strings.Chr(250) + SaveTypeCode + Strings.Chr(250) + UID + Strings.Chr(250) + ValName + Strings.Chr(250) + ValValue + Strings.Chr(254);
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog("clsAppParms : SaveSearchParm : 00A Error failed to save a search item: " + SaveTypeCode + " : " + ValName + " : " + ValValue + ".");
				LOG.WriteToArchiveLog((string) ("clsAppParms : SaveSearchParm : 00A Error failed to save a search item: " + ex.Message));
			}
			
			return S;
		}
		public string getConnStr()
		{
			
			bool bUseConfig = true;
			string S = "";
			S = DB.getGateWayConnStr(modGlobals.gGateWayID);
			UTIL.setConnectionStringTimeout(ref S);
			return S;
			
		}
		
		public void CkConn()
		{
			if (AppConn == null)
			{
				try
				{
					AppConn = new SqlConnection();
					AppConn.ConnectionString = getConnStr();
					AppConn.Open();
				}
				catch (Exception ex)
				{
					Console.WriteLine("Error 121.21");
					Console.WriteLine(ex.Source);
					Console.WriteLine(ex.StackTrace);
					Console.WriteLine(ex.Message);
					LOG.WriteToArchiveLog((string) ("clsAppParms : CkConn : 31 : " + ex.Message));
				}
			}
			if (AppConn.State == System.Data.ConnectionState.Closed)
			{
				try
				{
					AppConn.ConnectionString = getConnStr();
					AppConn.Open();
				}
				catch (Exception ex)
				{
					Console.WriteLine("Error 121.21");
					Console.WriteLine(ex.Source);
					Console.WriteLine(ex.StackTrace);
					Console.WriteLine(ex.Message);
					LOG.WriteToArchiveLog((string) ("clsAppParms : CkConn : 40 : " + ex.Message));
				}
			}
		}
		
		public SqlDataReader SqlQry(string sql)
		{
			//'Session("ActiveError") = False
			bool dDebug = false;
			string queryString = sql;
			bool rc = false;
			SqlDataReader rsDataQry = null;
			
			if (AppConn.State == System.Data.ConnectionState.Open)
			{
				AppConn.Close();
			}
			
			CkConn();
			
			SqlCommand command = new SqlCommand(sql, AppConn);
			
			try
			{
				rsDataQry = command.ExecuteReader();
			}
			catch (Exception ex)
			{
				WriteToLog((string) ("Error clsAppParms1001 Time: " + DateTime.Now), ErrLogFqn);
				WriteToLog((string) ("Error clsAppParms1001 clsAppParms.SqlQry: " + DateTime.Now), ErrLogFqn);
				WriteToLog((string) ("Error clsAppParms1001 Msg: " + ex.Message), ErrLogFqn);
				WriteToLog((string) ("Error clsAppParms1001 SQL: " + sql), ErrLogFqn);
				MessageBox.Show((string) ("Errors, check the log: " + ErrLogFqn));
				LOG.WriteToArchiveLog((string) ("clsAppParms : SqlQry : 57 : " + ex.Message));
			}
			
			command.Dispose();
			command = null;
			
			return rsDataQry;
		}
		
		public void WriteToLog(string Msg, string LogFQN)
		{
			
			using (StreamWriter sw = new StreamWriter(LogFQN, true))
			{
				// Add some text to the file.
				sw.WriteLine(DateTime.Now+ ": " + Msg);
				sw.Close();
			}
			
			
		}
		
		public void SaveUserParm(string ParmName, string ParameterValue, string AssignedUserID, string SaveName, string SaveTypeCode)
		{
			
			if (ParmName.Trim.Length == 0)
			{
				MessageBox.Show("A Parameter must be supplied, returning.");
				return;
			}
			
			bool B = true;
			
			if (AssignedUserID.Length == 0)
			{
				MessageBox.Show("A USER must be selected, returning.");
				return;
			}
			
			//Dim sSql  = "DELETE FROM [SavedItems]"
			//sSql  += " WHERE "
			//sSql  += " [Userid] = '" + AssignedUserID  + "'"
			//sSql  += " and [SaveName]  = '" + SaveName  + "'"
			//sSql  += " and [SaveTypeCode]  = '" + SaveTypeCode  + "'"
			//B = DB.ExecuteSqlNewConn(sSql,false)
			
			ParameterValue = UTIL.RemoveSingleQuotes(ParameterValue);
			
			SaveSearch(SaveName, SaveTypeCode, AssignedUserID, ParmName, ParameterValue);
			
		}
		
		public string SaveNewAssociations(string ParentFT, string ChildFT)
		{
			//Dim ParentFT  = cbPocessType.Text
			//Dim ChildFT  = cbAsType.Text
			string MSG = "";
			PFA.setExtcode(ref ParentFT);
			PFA.setProcessextcode(ref ChildFT);
			PFA.setApplied("0");
			
			string S = "";
			
			bool B = DB.ckProcessAsExists(ParentFT);
			if (! B)
			{
				
				PFA.Insert();
			}
			else
			{
				MSG = "Extension already defined to system...";
				return MSG;
			}
			
			S = "update [DataSource] set [SourceTypeCode] = \'" + ChildFT + "\' where [SourceTypeCode] = \'" + ParentFT + "\' and [DataSourceOwnerUserID] = \'" + modGlobals.gCurrUserGuidID + "\'";
			B = DB.ExecuteSqlNewConn(S, false);
			
			if (B)
			{
				MSG = ParentFT + " set to process as " + ChildFT;
				S = " update ProcessFileAs set Applied = 1  where Extcode = \'" + ParentFT + "\' and [ProcessExtCode] = \'" + ChildFT + "\'";
				B = DB.ExecuteSqlNewConn(S, false);
			}
			else
			{
				MSG = ParentFT + " WAS NOT set to process as " + ChildFT;
			}
			return MSG;
		}
		
	}
	
}
