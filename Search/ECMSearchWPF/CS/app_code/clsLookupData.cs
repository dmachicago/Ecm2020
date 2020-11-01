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
	public class clsLookupData
	{
		
		public void InitializeLookupTables()
		{
			AddDefaultRetentionCode();
		}
		
		public void AddDefaultRetentionCode()
		{
			
			var S = "INSERT INTO [Retention]";
			S = S + " ([RetentionCode]";
			S = S + " ,[RetentionDesc]";
			S = S + " ,[RetentionYears]";
			S = S + " ,[RetentionAction]";
			S = S + " ,[ManagerID]";
			S = S + " ,[ManagerName])";
			S = S + " VALUES ";
			S = S + " (\'10 Years\'";
			S = S + " ,\'Retain for 10 years.\'";
			S = S + " ,10";
			S = S + " ,\'Move\'";
			S = S + " ,\'admin\'";
			S = S + " ,\'admin\')";
			modGlobals.ExecuteSql(GLOBALS._SecureID.ToString(), S);
			S = "INSERT INTO [Retention]";
			S = S + " ([RetentionCode]";
			S = S + " ,[RetentionDesc]";
			S = S + " ,[RetentionYears]";
			S = S + " ,[RetentionAction]";
			S = S + " ,[ManagerID]";
			S = S + " ,[ManagerName])";
			S = S + " VALUES ";
			S = S + " (\'20 Years\'";
			S = S + " ,\'Retain for 20 years.\'";
			S = S + " ,20";
			S = S + " ,\'Move\'";
			S = S + " ,\'admin\'";
			S = S + " ,\'admin\')";
			modGlobals.ExecuteSql(GLOBALS._SecureID.ToString(), S);
			S = "INSERT INTO [Retention]";
			S = S + " ([RetentionCode]";
			S = S + " ,[RetentionDesc]";
			S = S + " ,[RetentionYears]";
			S = S + " ,[RetentionAction]";
			S = S + " ,[ManagerID]";
			S = S + " ,[ManagerName])";
			S = S + " VALUES ";
			S = S + " (\'30 Years\'";
			S = S + " ,\'Retain for 20 years.\'";
			S = S + " ,30";
			S = S + " ,\'Move\'";
			S = S + " ,\'admin\'";
			S = S + " ,\'admin\')";
			modGlobals.ExecuteSql(GLOBALS._SecureID.ToString(), S);
			S = "INSERT INTO [Retention]";
			S = S + " ([RetentionCode]";
			S = S + " ,[RetentionDesc]";
			S = S + " ,[RetentionYears]";
			S = S + " ,[RetentionAction]";
			S = S + " ,[ManagerID]";
			S = S + " ,[ManagerName])";
			S = S + " VALUES ";
			S = S + " (\'40 Years\'";
			S = S + " ,\'Retain for 20 years.\'";
			S = S + " ,40";
			S = S + " ,\'Move\'";
			S = S + " ,\'admin\'";
			S = S + " ,\'admin\')";
			modGlobals.ExecuteSql(GLOBALS._SecureID.ToString(), S);
			S = "INSERT INTO [Retention]";
			S = S + " ([RetentionCode]";
			S = S + " ,[RetentionDesc]";
			S = S + " ,[RetentionYears]";
			S = S + " ,[RetentionAction]";
			S = S + " ,[ManagerID]";
			S = S + " ,[ManagerName])";
			S = S + " VALUES ";
			S = S + " (\'50 Years\'";
			S = S + " ,\'Retain for 20 years.\'";
			S = S + " ,50";
			S = S + " ,\'Move\'";
			S = S + " ,\'admin\'";
			S = S + " ,\'admin\')";
			modGlobals.ExecuteSql(GLOBALS._SecureID.ToString(), S);
		}
		
	}
	
}
