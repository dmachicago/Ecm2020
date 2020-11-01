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
using System.IO;
using System.Data.Sql;


namespace EcmArchiveClcSetup
{
	public class clsListener : clsDatabase
	{
		
		clsLogging LOG = new clsLogging();
		clsDma DMA = new clsDma();
		
		bool PauseOn = true;
		bool PauseOff = false;
		
		//Static gActiveListeners As New LinkedList(Of String)
		
		public bool AddDirListener(string DirGuid, bool AdminDisabled, bool ListenerLoaded, bool ListenerActive, bool ListenerPaused, bool ListenDirectory, bool ListenSubDirectory, string MachineName)
		{
			
			Guid tGuid = new Guid(DirGuid);
			bool B = true;
			string S = "";
			int iCnt = iCount("Select count(*) from DirectoryListener where DirGuid = \'" + DirGuid + "\'");
			
			if (iCnt > 0)
			{
				S = "Update DirectoryListener set AdminDisabled = 0 where DirGuid = \'" + DirGuid + "\' ";
				B = ExecuteSqlNewConn(S, false);
				
				S = "Update DirectoryListener set ListenerLoaded = 0 where DirGuid = \'" + DirGuid + "\' ";
				B = ExecuteSqlNewConn(S, false);
				
				S = "Update DirectoryListener set ListenerActive = 0 where DirGuid = \'" + DirGuid + "\' ";
				B = ExecuteSqlNewConn(S, false);
				
				S = "Update DirectoryListener set ListenerPaused = 0 where DirGuid = \'" + DirGuid + "\' ";
				B = ExecuteSqlNewConn(S, false);
				
				if (ListenDirectory == true)
				{
					S = "Update DirectoryListener set ListenDirectory = 1 where DirGuid = \'" + DirGuid + "\' ";
					B = ExecuteSqlNewConn(S, false);
				}
				else
				{
					S = "Update DirectoryListener set ListenDirectory = 0 where DirGuid = \'" + DirGuid + "\' ";
					B = ExecuteSqlNewConn(S, false);
				}
				if (ListenSubDirectory == true)
				{
					S = "Update DirectoryListener set ListenSubDirectory = 1 where DirGuid = \'" + DirGuid + "\' ";
					B = ExecuteSqlNewConn(S, false);
				}
				else
				{
					S = "Update DirectoryListener set ListenSubDirectory = 0 where DirGuid = \'" + DirGuid + "\' ";
					B = ExecuteSqlNewConn(S, false);
				}
				
			}
			else
			{
				S = S + " INSERT INTO [DirectoryListener]" + "\r\n";
				S = S + "            ([UserID]" + "\r\n";
				S = S + "            ,[AdminDisabled]" + "\r\n";
				S = S + "            ,[ListenerLoaded]" + "\r\n";
				S = S + "            ,[ListenerActive]" + "\r\n";
				S = S + "            ,[ListenerPaused]" + "\r\n";
				S = S + "            ,[ListenDirectory]" + "\r\n";
				S = S + "            ,[ListenSubDirectory]" + "\r\n";
				S = S + "            ,[DirGuid]" + "\r\n";
				S = S + "            ,[MachineName])";
				S = S + "      VALUES";
				S = S + "            (\'" + modGlobals.gCurrUserGuidID + "\'" + "\r\n";
				S = S + "            ," + val[AdminDisabled] + "\r\n";
				S = S + "            ," + val[ListenerLoaded] + "\r\n";
				S = S + "            ," + val[ListenerActive] + "\r\n";
				S = S + "            ," + val[ListenerPaused] + "\r\n";
				S = S + "            ," + val[ListenDirectory] + "\r\n";
				S = S + "            ," + val[ListenSubDirectory] + "\r\n";
				S = S + "            ,\'" + tGuid.ToString() + ("\'" + "\r\n");
				S = S + "            ,\'" + MachineName + "\')";
				
				B = ExecuteSqlNewConn(S, false);
			}
			
			
			
			return B;
		}
		
		public bool deleteDirListener(string DirGuid)
		{
			
			bool B = true;
			string S = "";
			S = S + " delete from [DirectoryListener] where DirGuid = \'" + DirGuid + "\'";
			B = ExecuteSqlNewConn(S, false);
			
			return B;
		}
		
		public bool TurnOffSubDirListener(string DirGuid)
		{
			
			bool B = true;
			string S = "";
			
			S = S + " update [DirectoryListener] set ListenSubDirectory = 0 where DirGuid = \'" + DirGuid + "\' ";
			
			B = ExecuteSqlNewConn(S, false);
			
			if (B)
			{
				PauseDirListener(DirGuid, PauseOn);
			}
			
			return B;
		}
		
		public bool TurnOffListener(string DirGuid)
		{
			
			bool B = true;
			string S = "";
			
			S = S + " update [DirectoryListener] set ListenDirectory = 0 where DirGuid = \'" + DirGuid + "\' ";
			
			B = ExecuteSqlNewConn(S, false);
			
			if (B)
			{
				PauseDirListener(DirGuid, PauseOn);
			}
			
			return B;
		}
		
		public bool PauseDirListener(string DirGuid, bool bPause)
		{
			
			bool B = true;
			string S = "";
			if (bPause == true)
			{
				S = S + " update [DirectoryListener] set ListenerPaused = 1 where DirGuid = \'" + DirGuid + "\' ";
				int I = modGlobals.gActiveListeners.IndexOfKey(DirGuid);
				if (I >= 0)
				{
					modGlobals.gActiveListeners[DirGuid] = PauseOn;
				}
			}
			else
			{
				S = S + " update [DirectoryListener] set ListenerPaused = 0 where DirGuid = \'" + DirGuid + "\' ";
				int I = modGlobals.gActiveListeners.IndexOfKey(DirGuid);
				if (I >= 0)
				{
					modGlobals.gActiveListeners[DirGuid] = PauseOff;
				}
			}
			
			B = ExecuteSqlNewConn(S, false);
			
			return B;
		}
		
		public bool DisableDirListenerActive(string DirGuid)
		{
			
			bool B = true;
			string S = "";
			
			S = S + " update [DirectoryListener] set ListenerActive = 0, ListenerPaused = 1 where DirGuid = \'" + DirGuid + "\' ";
			
			B = ExecuteSqlNewConn(S, false);
			
			if (B)
			{
				int I = modGlobals.gActiveListeners.IndexOfKey(DirGuid);
				if (I >= 0)
				{
					modGlobals.gActiveListeners.Values(I) = PauseOn;
				}
			}
			
			return B;
		}
		public bool EnableDirListenerActive(string DirGuid)
		{
			
			bool B = true;
			string S = "";
			
			S = S + " update [DirectoryListener] set ListenerActive = 1, ListenerPaused = 0 where DirGuid = \'" + DirGuid + "\' ";
			
			B = ExecuteSqlNewConn(S, false);
			
			if (B)
			{
				int I = modGlobals.gActiveListeners.IndexOfKey(DirGuid);
				if (I >= 0)
				{
					modGlobals.gActiveListeners.Values(I) = PauseOff;
				}
			}
			
			return B;
		}
		
		public bool DisableDirListenerAdmin(string DirGuid)
		{
			
			bool B = true;
			string S = "";
			
			S = S + " update [DirectoryListener] set AdminDisabled = 1 where DirGuid = \'" + DirGuid + "\' ";
			
			B = ExecuteSqlNewConn(S, false);
			
			return B;
		}
		
		public bool EnableDirListenerAdmin(string DirGuid)
		{
			
			bool B = true;
			string S = "";
			
			S = S + " update [DirectoryListener] set AdminDisabled = 0 where DirGuid = \'" + DirGuid + "\' ";
			
			B = ExecuteSqlNewConn(S, false);
			
			return B;
		}
		
		public bool AddListenerFile(string DirGuid, string SourceFile, string MachineName)
		{
			bool B = true;
			string S = "";
			S = S + " INSERT INTO [DirectoryListenerFiles]";
			S = S + "            ([DirGuid]";
			S = S + "            ,[SourceFile]";
			S = S + "            ,[Archived]";
			S = S + "            ,[EntryDate]";
			S = S + "            ,[UserID]";
			S = S + "            ,[MachineName])";
			S = S + "      VALUES";
			S = S + "            (\'" + DirGuid + "\'";
			S = S + "            ,\'" + SourceFile + "\'";
			S = S + "            ,0";
			S = S + "            ,\'" + DateTime.Now.ToString() + "\'";
			S = S + "            ,\'" + modGlobals.gCurrUserGuidID + "\'";
			S = S + "            ,\'" + MachineName + "\'";
			
			B = ExecuteSqlNewConn(S, false);
			
			return B;
		}
		
		public bool setDirListernerON(string DirGuid)
		{
			bool B = true;
			string S = "";
			S = S + " Update Directory set ListenForChanges = 1, ListenDirectory = 1 where DirGuid = \'" + DirGuid + "\' ";
			B = ExecuteSqlNewConn(S, false);
			if (B)
			{
				PauseDirListener(DirGuid, PauseOff);
			}
			return B;
		}
		
		public bool setSubDirListernerON(string DirGuid)
		{
			bool B = true;
			string S = "";
			S = S + " Update Directory set ListenSubDirectory = 1 where DirGuid = \'" + DirGuid + "\' ";
			B = ExecuteSqlNewConn(S, false);
			if (B)
			{
				PauseDirListener(DirGuid, PauseOff);
			}
			return B;
		}
		
		public bool setDirListernerOFF(string DirGuid)
		{
			bool B = true;
			string S = "";
			S = S + " Update Directory set ListenForChanges = 0, ListenDirectory = 0, ListenSubDirectory = 0 where DirGuid = \'" + DirGuid + "\' ";
			B = ExecuteSqlNewConn(S, false);
			
			if (B)
			{
				PauseDirListener(DirGuid, PauseOn);
			}
			
			return B;
		}
		
		public int LoadListeners(string TgtMachineName)
		{
			
			int NbrListeners = 0;
			
			string S = "";
			S = S + " SELECT     DirectoryListener.UserID, DirectoryListener.AdminDisabled, DirectoryListener.ListenerLoaded, DirectoryListener.ListenerActive, DirectoryListener.ListenerPaused, ";
			S = S + " DirectoryListener.ListenDirectory, DirectoryListener.ListenSubDirectory, DirectoryListener.DirGuid, DirectoryListener.MachineName, Directory.FQN";
			S = S + " FROM         DirectoryListener INNER JOIN";
			S = S + " Directory ON DirectoryListener.DirGuid = Directory.DirGuid";
			S = S + " WHERE     (DirectoryListener.MachineName = \'" + TgtMachineName + "\') AND (DirectoryListener.ListenerActive = 1)";
			
			string UserID = "";
			bool AdminDisabled = false;
			bool ListenerLoaded = false;
			bool ListenerActive = false;
			bool ListenerPaused = false;
			bool ListenDirectory = false;
			bool ListenSubDirectory = false;
			string DirGuid = "";
			string MachineName = "";
			string FQN = "";
			
			SqlDataReader RSData = null;
			//RSData = SqlQryNo'Session(S)
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					NbrListeners++;
					UserID = RSData.GetValue(0).ToString();
					AdminDisabled = bool.Parse(RSData.GetValue(1).ToString());
					ListenerLoaded = RSData.GetBoolean(2);
					ListenerActive = RSData.GetBoolean(3);
					ListenerPaused = RSData.GetBoolean(4);
					ListenDirectory = RSData.GetBoolean(5);
					ListenSubDirectory = RSData.GetBoolean(6);
					DirGuid = RSData.GetValue(7).ToString();
					MachineName = RSData.GetValue(8).ToString();
					FQN = RSData.GetValue(9).ToString();
					
					if (modGlobals.gActiveListeners.IndexOfKey(DirGuid) >= 0)
					{
					}
					else
					{
						clsDirListener DL = new clsDirListener();
						DL.WatchDirectory = FQN;
						DL.DirGuid = DirGuid;
						DL.Machinename = MachineName;
						DL.StartListening(ListenSubDirectory);
						try
						{
							modGlobals.gActiveListeners.Add(DirGuid, ListenerPaused);
						}
						catch (Exception ex)
						{
							Console.WriteLine(ex.Message);
						}
						
					}
					
				}
			}
			else
			{
				LOG.WriteToArchiveLog("Notification: No directory listeners found for machine " + TgtMachineName + ".");
			}
			
			if (! RSData.IsClosed)
			{
				RSData.Close();
			}
			RSData = null;
			command.Dispose();
			command = null;
			
			if (CONN.State == ConnectionState.Open)
			{
				CONN.Close();
			}
			CONN.Dispose();
			return NbrListeners;
		}
		
		public void PauseListeners(string TgtMachineName, bool bPause)
		{
			
			string S = "";
			if (bPause == true)
			{
				S = S + " Update [DirectoryListener] set ListenerPaused = 1 ";
			}
			else
			{
				S = S + " Update [DirectoryListener] set ListenerPaused = 0 ";
			}
			S = S + " WHERE  DirectoryListener.MachineName = \'" + TgtMachineName + "\'";
			
			bool B = ExecuteSqlNewConn(S);
			
			for (int I = 0; I <= modGlobals.gActiveListeners.Count - 1; I++)
			{
				S = modGlobals.gActiveListeners.Keys(I).ToString();
				modGlobals.gActiveListeners[S] = bPause;
			}
			
		}
		
	}
	
}
