using System;
using System.Data;
using global::System.Data.SqlClient;
using Microsoft.VisualBasic;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{
    public class clsListener : clsDatabaseARCH
    {
        private clsLogging LOG = new clsLogging();
        private clsDma DMA = new clsDma();
        private bool PauseOn = true;
        private bool PauseOff = false;

        // Static gActiveListeners As New LinkedList(Of String)

        public bool AddDirListener(string DirGuid, bool AdminDisabled, bool ListenerLoaded, bool ListenerActive, bool ListenerPaused, bool ListenDirectory, bool ListenSubDirectory, string MachineName)
        {
            var tGuid = new Guid(DirGuid);
            bool B = true;
            string S = "";
            int iCnt = iCount("Select count(*) from DirectoryListener where DirGuid = '" + DirGuid + "'");
            if (iCnt > 0)
            {
                S = "Update DirectoryListener set AdminDisabled = 0 where DirGuid = '" + DirGuid + "' ";
                B = ExecuteSqlNewConn(S, false);
                S = "Update DirectoryListener set ListenerLoaded = 0 where DirGuid = '" + DirGuid + "' ";
                B = ExecuteSqlNewConn(S, false);
                S = "Update DirectoryListener set ListenerActive = 0 where DirGuid = '" + DirGuid + "' ";
                B = ExecuteSqlNewConn(S, false);
                S = "Update DirectoryListener set ListenerPaused = 0 where DirGuid = '" + DirGuid + "' ";
                B = ExecuteSqlNewConn(S, false);
                if (ListenDirectory == true)
                {
                    S = "Update DirectoryListener set ListenDirectory = 1 where DirGuid = '" + DirGuid + "' ";
                    B = ExecuteSqlNewConn(S, false);
                }
                else
                {
                    S = "Update DirectoryListener set ListenDirectory = 0 where DirGuid = '" + DirGuid + "' ";
                    B = ExecuteSqlNewConn(S, false);
                }

                if (ListenSubDirectory == true)
                {
                    S = "Update DirectoryListener set ListenSubDirectory = 1 where DirGuid = '" + DirGuid + "' ";
                    B = ExecuteSqlNewConn(S, false);
                }
                else
                {
                    S = "Update DirectoryListener set ListenSubDirectory = 0 where DirGuid = '" + DirGuid + "' ";
                    B = ExecuteSqlNewConn(S, false);
                }
            }
            else
            {
                S = S + " INSERT INTO [DirectoryListener]" + Constants.vbCrLf;
                S = S + "            ([UserID]" + Constants.vbCrLf;
                S = S + "            ,[AdminDisabled]" + Constants.vbCrLf;
                S = S + "            ,[ListenerLoaded]" + Constants.vbCrLf;
                S = S + "            ,[ListenerActive]" + Constants.vbCrLf;
                S = S + "            ,[ListenerPaused]" + Constants.vbCrLf;
                S = S + "            ,[ListenDirectory]" + Constants.vbCrLf;
                S = S + "            ,[ListenSubDirectory]" + Constants.vbCrLf;
                S = S + "            ,[DirGuid]" + Constants.vbCrLf;
                S = S + "            ,[MachineName])";
                S = S + "      VALUES";
                S = S + "            ('" + modGlobals.gCurrUserGuidID + "'" + Constants.vbCrLf;
                S = S + "            ," + Conversion.Val(AdminDisabled) + Constants.vbCrLf;
                S = S + "            ," + Conversion.Val(ListenerLoaded) + Constants.vbCrLf;
                S = S + "            ," + Conversion.Val(ListenerActive) + Constants.vbCrLf;
                S = S + "            ," + Conversion.Val(ListenerPaused) + Constants.vbCrLf;
                S = S + "            ," + Conversion.Val(ListenDirectory) + Constants.vbCrLf;
                S = S + "            ," + Conversion.Val(ListenSubDirectory) + Constants.vbCrLf;
                S = S + "            ,'" + tGuid.ToString() + "'" + Constants.vbCrLf;
                S = S + "            ,'" + MachineName + "')";
                B = ExecuteSqlNewConn(S, false);
            }

            return B;
        }

        public bool deleteDirListener(string DirGuid)
        {
            bool B = true;
            string S = "";
            S = S + " delete from [DirectoryListener] where DirGuid = '" + DirGuid + "'";
            B = ExecuteSqlNewConn(S, false);
            return B;
        }

        public bool TurnOffSubDirListener(string DirGuid)
        {
            bool B = true;
            string S = "";
            S = S + " update [DirectoryListener] set ListenSubDirectory = 0 where DirGuid = '" + DirGuid + "' ";
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
            S = S + " update [DirectoryListener] set ListenDirectory = 0 where DirGuid = '" + DirGuid + "' ";
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
                S = S + " update [DirectoryListener] set ListenerPaused = 1 where DirGuid = '" + DirGuid + "' ";
                int I = modGlobals.gActiveListeners.IndexOfKey(DirGuid);
                if (I >= 0)
                {
                    modGlobals.gActiveListeners[DirGuid] = PauseOn;
                }
            }
            else
            {
                S = S + " update [DirectoryListener] set ListenerPaused = 0 where DirGuid = '" + DirGuid + "' ";
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
            S = S + " update [DirectoryListener] set ListenerActive = 0, ListenerPaused = 1 where DirGuid = '" + DirGuid + "' ";
            B = ExecuteSqlNewConn(S, false);
            if (B)
            {
                int I = modGlobals.gActiveListeners.IndexOfKey(DirGuid);
                if (I >= 0)
                {
                    modGlobals.gActiveListeners.Values[I] = PauseOn;
                }
            }

            return B;
        }

        public bool EnableDirListenerActive(string DirGuid)
        {
            bool B = true;
            string S = "";
            S = S + " update [DirectoryListener] set ListenerActive = 1, ListenerPaused = 0 where DirGuid = '" + DirGuid + "' ";
            B = ExecuteSqlNewConn(S, false);
            if (B)
            {
                int I = modGlobals.gActiveListeners.IndexOfKey(DirGuid);
                if (I >= 0)
                {
                    modGlobals.gActiveListeners.Values[I] = PauseOff;
                }
            }

            return B;
        }

        public bool DisableDirListenerAdmin(string DirGuid)
        {
            bool B = true;
            string S = "";
            S = S + " update [DirectoryListener] set AdminDisabled = 1 where DirGuid = '" + DirGuid + "' ";
            B = ExecuteSqlNewConn(S, false);
            return B;
        }

        public bool EnableDirListenerAdmin(string DirGuid)
        {
            bool B = true;
            string S = "";
            S = S + " update [DirectoryListener] set AdminDisabled = 0 where DirGuid = '" + DirGuid + "' ";
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
            S = S + "            ('" + DirGuid + "'";
            S = S + "            ,'" + SourceFile + "'";
            S = S + "            ,0";
            S = S + "            ,'" + DateAndTime.Now.ToString() + "'";
            S = S + "            ,'" + modGlobals.gCurrUserGuidID + "'";
            S = S + "            ,'" + MachineName + "'";
            B = ExecuteSqlNewConn(S, false);
            return B;
        }

        public bool setDirListernerON(string DirGuid)
        {
            bool B = true;
            string S = "";
            S = S + " Update Directory set ListenForChanges = 1, ListenDirectory = 1 where DirGuid = '" + DirGuid + "' ";
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
            S = S + " Update Directory set ListenSubDirectory = 1 where DirGuid = '" + DirGuid + "' ";
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
            S = S + " Update Directory set ListenForChanges = 0, ListenDirectory = 0, ListenSubDirectory = 0 where DirGuid = '" + DirGuid + "' ";
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
            S = S + " WHERE     (DirectoryListener.MachineName = '" + TgtMachineName + "') AND (DirectoryListener.ListenerActive = 1)";
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
            string CS = getRepoConnStr();
            var CONN = new SqlConnection(CS);
            CONN.Open();
            var command = new SqlCommand(S, CONN);
            RSData = command.ExecuteReader();
            if (RSData.HasRows)
            {
                while (RSData.Read())
                {
                    NbrListeners += 1;
                    UserID = RSData.GetValue(0).ToString();
                    AdminDisabled = Conversions.ToBoolean(RSData.GetValue(1).ToString());
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
                        var DL = new clsDirListener();
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

            if (!RSData.IsClosed)
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

            S = S + " WHERE  DirectoryListener.MachineName = '" + TgtMachineName + "'";
            bool B = ExecuteSqlNewConn(90400, S);
            for (int I = 0, loopTo = modGlobals.gActiveListeners.Count - 1; I <= loopTo; I++)
            {
                S = modGlobals.gActiveListeners.Keys[I].ToString();
                modGlobals.gActiveListeners[S] = bPause;
            }
        }
    }
}