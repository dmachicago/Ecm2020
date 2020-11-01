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

using System.Data.SqlClient;
using System.Threading;


namespace EcmArchiveClcSetup
{
	public class clsGlobalEntity
	{
		
		clsLogging LOG = new clsLogging();
		clsUtility UTIL = new clsUtility();
		clsKeyGen KEY = new clsKeyGen();
		
		string HashCode = "";
		Guid GuidID = null;
		string ShortName = "";
		string LongName = "";
		int LocatorID = 0;
		string gConnStr = "";
		SqlConnection gConn;
		int ShortNameLength = 250;
		
		public Guid XXAddItem(string FQN, string TableName, bool CaseSensitive)
		{
			
			if (CaseSensitive == false)
			{
				FQN = FQN.ToUpper();
			}
			
			FQN = UTIL.RemoveSingleQuotes(FQN);
			
			int NameLength = FQN.Length;
			string S = "";
			Guid NewGuid = ItemExists(FQN, TableName, CaseSensitive);
			
			try
			{
				if (NewGuid == null)
				{
					if (NameLength <= ShortNameLength)
					{
						ShortName = UTIL.RemoveSingleQuotes(FQN);
						LongName = "";
					}
					else
					{
						LongName = UTIL.RemoveSingleQuotes(FQN);
						ShortName = "";
					}
					
					HashCode = KEY.getMD5HashX(FQN);
					NewGuid = Guid.NewGuid();
					S = "";
					if (TableName.Equals("GlobalDirectory"))
					{
						S = S + " INSERT INTO [GlobalDirectory]";
					}
					else if (TableName.Equals("GlobalFile"))
					{
						S = S + " INSERT INTO  [GlobalFile] ";
					}
					else if (TableName.Equals("GlobalLocation"))
					{
						S = S + " INSERT INTO  [GlobalLocation] ";
					}
					else if (TableName.Equals("GlobalMachine"))
					{
						S = S + " INSERT INTO  [GlobalMachine] ";
					}
					else if (TableName.Equals("GlobalEmail"))
					{
						S = S + " INSERT INTO  [GlobalEmail] ";
					}
					else
					{
						LOG.WriteToArchiveLog("ERROR AddEntity - incorrect table name supplied \'" + TableName + "\'.");
						return null;
					}
					S = S + " ([HashCode]";
					S = S + " ,[GuidID]";
					S = S + " ,[ShortName] ";
					S = S + " ,[LongName])";
					S = S + " VALUES ";
					S = S + " (\'" + HashCode + "\'";
					S = S + " ,\'" + NewGuid.ToString() + "\'";
					S = S + " ,\'" + ShortName + "\'";
					S = S + " ,\'" + LongName + "\')";
					
					bool B = ExecSql(S);
					
					if (B == false)
					{
						LOG.WriteToArchiveLog((string) ("ERROR AddEntity - Table name  \'" + TableName + "\' - " + "\r\n" + S));
						NewGuid = null;
					}
					
				}
			}
			catch (Exception)
			{
				LOG.WriteToArchiveLog((string) ("ERROR AddEntity - 100: Table name  \'" + TableName + "\' - " + FQN));
				NewGuid = null;
			}
			
			return NewGuid;
			
		}
		
		public Guid ItemExists(string FQN, string TableName, bool CaseSensitive)
		{
			
			if (CaseSensitive == false)
			{
				FQN = FQN.ToUpper();
			}
			
			bool B = false;
			int NameLength = FQN.Length;
			
			GuidID = null;
			
			HashCode = KEY.getMD5HashX(FQN);
			string S = "";
			
			try
			{
				S = " Select ";
				S = S + "  [GuidID]";
				S = S + " ,[ShortName]";
				S = S + " ,[LongName]";
				S = S + " ,[LocatorID]";
				if (TableName.Equals("GlobalDirectory"))
				{
					S = S + " FROM [GlobalDirectory] ";
				}
				else if (TableName.Equals("GlobalFile"))
				{
					S = S + " FROM [GlobalFile] ";
				}
				else if (TableName.Equals("GlobalLocation"))
				{
					S = S + " FROM [GlobalLocation] ";
				}
				else if (TableName.Equals("GlobalMachine"))
				{
					S = S + " FROM [GlobalMachine] ";
				}
				else if (TableName.Equals("GlobalEmail"))
				{
					S = S + " FROM [GlobalEmail] ";
				}
				else
				{
					LOG.WriteToArchiveLog("ERROR EntityExists - incorrect table name supplied \'" + TableName + "\'.");
					return null;
				}
				
				S = S + " where HashCode = \'" + HashCode + "\'";
				
				bool dDebug = false;
				bool rc = false;
				SqlDataReader rsDataQry = null;
				setConnStr();
				
				SqlConnection CN = new SqlConnection(gConnStr);
				
				if (CN.State == ConnectionState.Closed)
				{
					CN.Open();
				}
				
				SqlCommand command = new SqlCommand(S, CN);
				
				try
				{
					rsDataQry = command.ExecuteReader();
					if (rsDataQry.HasRows)
					{
						while (rsDataQry.Read())
						{
							if (NameLength <= ShortNameLength)
							{
								GuidID = rsDataQry.GetGuid(0);
								ShortName = rsDataQry.GetString(1);
								if (FQN.Equals(ShortName))
								{
									break;
								}
							}
							else
							{
								GuidID = rsDataQry.GetGuid(0);
								LongName = rsDataQry.GetString(2);
								if (FQN.Equals(ShortName))
								{
									break;
								}
							}
						}
					}
				}
				catch (Exception ex)
				{
					LOG.WriteToArchiveLog((string) ("ItemExists : 1300 : " + ex.Message));
					GuidID = null;
				}
				finally
				{
					command.Dispose();
					command = null;
					if (CN.State == ConnectionState.Open)
					{
						CN.Close();
					}
					CN.Dispose();
					
					GC.Collect();
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ItemExists : 1301 : " + ex.Message));
				GuidID = null;
			}
			
			return GuidID;
			
		}
		
		
		public void setConnStr()
		{
			string S = "";
			lock(this)
			{
				try
				{
					//If dDebug Then log.WriteToArchiveLog("010 - gUserConnectionStringConfirmedGood is being initiated.")
					S = My.Settings.Default["UserDefaultConnString"];
					if (! S.Equals("?"))
					{
						if (modGlobals.gUserConnectionStringConfirmedGood == true)
						{
							gConnStr = S;
						}
						else
						{
							try
							{
								if (gConn.State == ConnectionState.Open)
								{
									//If dDebug Then log.WriteToArchiveLog("400 - gUserConnectionStringConfirmedGood.")
									gConn.Close();
								}
								//If dDebug Then log.WriteToArchiveLog("500 - gUserConnectionStringConfirmedGood.")
								gConn.ConnectionString = S;
								gConn.Open();
								modGlobals.gUserConnectionStringConfirmedGood = true;
								My.Settings.Default["UserDefaultConnString"] = S;
								My.Settings.Default.Save();
								gConnStr = S;
							}
							catch (Exception)
							{
								//** The connection failed use the APP.CONFIG string
								S = System.Configuration.ConfigurationManager.AppSettings["ECMREPO"];
								My.Settings.Default["UserDefaultConnString"] = S;
								My.Settings.Default.Save();
								modGlobals.gUserConnectionStringConfirmedGood = true;
								gConnStr = S;
							}
						}
						goto SKIPOUT;
					}
					else if (S.Equals("?"))
					{
						//** First time, set the connection str to the APP.CONFIG.
						//'If dDebug Then log.WriteToArchiveLog("1001 - gUserConnectionStringConfirmedGood.")
						S = System.Configuration.ConfigurationManager.AppSettings["ECMREPO"];
						My.Settings.Default["UserDefaultConnString"] = S;
						My.Settings.Default.Save();
						//'If dDebug Then log.WriteToArchiveLog("1002 - gUserConnectionStringConfirmedGood.")
						modGlobals.gUserConnectionStringConfirmedGood = true;
						gConnStr = S;
						//If dDebug Then log.WriteToArchiveLog("1003 - gUserConnectionStringConfirmedGood.")
						goto SKIPOUT;
					}
				}
				catch (Exception)
				{
					//If dDebug Then log.WriteToArchiveLog("1004 - gUserConnectionStringConfirmedGood.")
					S = System.Configuration.ConfigurationManager.AppSettings["ECMREPO"];
					LOG.WriteToArchiveLog((string) ("1005 - gUserConnectionStringConfirmedGood: " + S));
				}
				
				bool bUseConfig = true;
				
				//If dDebug Then log.WriteToArchiveLog("1006 - gUserConnectionStringConfirmedGood.")
				
				
				S = System.Configuration.ConfigurationManager.AppSettings["ECMREPO"];
				UTIL.setConnectionStringTimeout(ref S);
				
				gConnStr = S;
SKIPOUT:
				1.GetHashCode() ; //VBConversions note: C# requires an executable line here, so a dummy line was added.
			}
		}
		
		public bool ExecSql(string sql)
		{
			bool rc = false;
			setConnStr();
			SqlConnection CN = new SqlConnection(gConnStr);
			CN.Open();
			SqlCommand dbCmd = CN.CreateCommand();
			bool BB = true;
			using (CN)
			{
				dbCmd.Connection = CN;
				try
				{
					dbCmd.CommandText = sql;
					dbCmd.ExecuteNonQuery();
					BB = true;
				}
				catch (Exception ex)
				{
					rc = false;
					if (ex.Message.IndexOf("The DELETE statement conflicted with the REFERENCE") + 1 > 0)
					{
						if (modGlobals.gRunUnattended == false)
						{
							MessageBox.Show((string) ("It appears this user has DATA within the repository associated to them and cannot be deleted." + "\r\n" + "\r\n" + ex.Message));
						}
						LOG.WriteToArchiveLog((string) ("It appears this user has DATA within the repository associated to them and cannot be deleted." + "\r\n" + "\r\n" + ex.Message));
					}
					else if (ex.Message.IndexOf("HelpText") + 1 > 0)
					{
						BB = true;
					}
					else if (ex.Message.IndexOf("duplicate key row") + 1 > 0)
					{
						BB = true;
					}
					else if (ex.Message.IndexOf("duplicate key") + 1 > 0)
					{
						BB = true;
					}
					else if (ex.Message.IndexOf("duplicate") + 1 > 0)
					{
						BB = true;
					}
					else
					{
						BB = false;
						LOG.WriteToArchiveLog((string) ("clsDatabase : ExecuteSqlNewConn : 9442a1p1: " + ex.Message));
						LOG.WriteToArchiveLog("clsDatabase : ExecuteSqlNewConn : 9442a1p2: " + "\r\n" + sql + "\r\n");
					}
					
				}
			}
			
			
			if (CN.State == ConnectionState.Open)
			{
				CN.Close();
			}
			
			CN = null;
			dbCmd = null;
			GC.Collect();
			
			return BB;
		}
		
	}
	
}
