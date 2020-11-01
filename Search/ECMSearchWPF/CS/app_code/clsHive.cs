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
	public class clsHive
	{
		
		clsLogging LOG = new clsLogging();
		//Dim proxy As New SVCSearch.Service1Client
		//Dim EP As New clsEndPoint
		clsEncryptV2 ENC2 = new clsEncryptV2();
		
		
		
		public void updateHiveServerName(string TableName)
		{
			string S = "Update " + TableName + " set RepoSvrName = (select @@SERVERNAME) where RepoName is null ";
			S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(GLOBALS._SecureID, GLOBALS.gRowID, S, GLOBALS._UserID, GLOBALS.ContractID);
		}
		public void updateHiveRepoName(string TableName)
		{
			string S = "Update " + TableName + " set RepoSvrName = (SELECT DB_NAME() AS DataBaseName) where RepoName is null ";
			//Dim proxy As New SVCSearch.Service1Client
			
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted += new System.EventHandler(client_ExecuteSqlNewConn);
			//EP.setSearchSvcEndPoint(proxy)
			S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(GLOBALS._SecureID, GLOBALS.gRowID, S, GLOBALS._UserID, GLOBALS.ContractID);
		}
		public void client_ExecuteSqlNewConn(object sender, SVCSearch.ExecuteSqlNewConnSecureCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				bool B = System.Convert.ToBoolean(e.Result);
			}
			else
			{
				string ErrSql = (string) e.MySql;
				modGlobals.gErrorCount++;
				LOG.WriteToSqlLog((string) ("ERROR clsLIBRARYUSERS 100: " + e.Error.Message));
				LOG.WriteToSqlLog((string) ("ERROR clsLIBRARYUSERS 100: " + ErrSql));
			}
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted -= new System.EventHandler(client_ExecuteSqlNewConn);
		}
		~clsHive()
		{
			try
			{
			}
			finally
			{
				base.Finalize(); //define the destructor
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
		}
		
	}
	
}
