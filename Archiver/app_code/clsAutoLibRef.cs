using global::System;
using global::System.Collections;
using System.Data;
using global::System.Data.SqlClient;
using System.Diagnostics;
using global::System.Threading;
using System.Windows.Forms;
using Microsoft.VisualBasic;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{
    public class clsAutoLibRef
    {
        private clsDatabaseARCH DBARCH = new clsDatabaseARCH();
        private clsLIBEMAIL LEmail = new clsLIBEMAIL();
        private clsLIBDIRECTORY LDir = new clsLIBDIRECTORY();
        private clsLIBRARYITEMS LI = new clsLIBRARYITEMS();
        private clsDma DMA = new clsDma();
        private clsUtility UTIL = new clsUtility();
        private clsLogging LOG = new clsLogging();
        private Thread tProcessAllRefDirs;
        private Thread tProcessAllRefEmails;

        public void ProcessAutoReferences()
        {
            bool bUSeThreads = false;
            if (bUSeThreads)
            {
                if (tProcessAllRefDirs is object)
                {
                    if (tProcessAllRefDirs.IsAlive)
                    {
                        return;
                    }
                }

                if (tProcessAllRefEmails is object)
                {
                    if (tProcessAllRefEmails.IsAlive)
                    {
                        return;
                    }
                }

                tProcessAllRefDirs = new Thread((_) => this.ProcessAllRefDirs());
                tProcessAllRefDirs.Name = "ThreadProcessAllRefDirs";
                tProcessAllRefDirs.Priority = ThreadPriority.Lowest;
                tProcessAllRefDirs.Start(bUSeThreads);
                tProcessAllRefEmails = new Thread((_) => this.ProcessAllRefEmails());
                tProcessAllRefEmails.Name = "ThreadProcessAllRefEmails";
                tProcessAllRefEmails.Priority = ThreadPriority.Lowest;
                tProcessAllRefEmails.Start(bUSeThreads);
            }
            else
            {
                ProcessAllRefDirs(bUSeThreads);
                ProcessAllRefEmails(bUSeThreads);
            }
        }

        public void ProcessAllRefDirs(bool bThreaded)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            var A = new ArrayList();
            string S = "";
            S = S + " SELECT     LibDirectory.DirectoryName, LibDirectory.UserID, LibDirectory.LibraryName, Directory.IncludeSubDirs";
            S = S + " FROM         LibDirectory INNER JOIN";
            S = S + " Directory ON LibDirectory.UserID = Directory.UserID AND LibDirectory.DirectoryName = Directory.FQN";
            S = S + " where LibDirectory.UserID = '" + modGlobals.gCurrUserGuidID + "'";
            string DirectoryName = "";
            string UserID = "";
            string LibraryName = "";
            string IncludeSubDirs = "";
            SqlDataReader rsColInfo = null;
            string CS = DBARCH.setConnStr();     // DBARCH.getGateWayConnStr(gGateWayID)
            var tConn = new SqlConnection(CS);
            if (tConn.State == ConnectionState.Closed)
            {
                tConn.Open();
            }

            DBARCH.SqlQryNewThread(S, ref tConn, ref rsColInfo);
            if (rsColInfo.HasRows)
            {
                while (rsColInfo.Read())
                {
                    DirectoryName = rsColInfo.GetValue(rsColInfo.GetOrdinal("DirectoryName")).ToString();
                    UserID = rsColInfo.GetValue(rsColInfo.GetOrdinal("UserID")).ToString();
                    LibraryName = rsColInfo.GetValue(rsColInfo.GetOrdinal("LibraryName")).ToString();
                    IncludeSubDirs = rsColInfo.GetValue(rsColInfo.GetOrdinal("IncludeSubDirs")).ToString();
                    A.Add(DirectoryName + "|" + LibraryName + "|" + IncludeSubDirs);
                }
            }

            rsColInfo.Close();
            rsColInfo = null;
            tConn.Close();
            tConn = null;
            GC.Collect();
            for (int I = 0, loopTo = A.Count - 1; I <= loopTo; I++)
            {
                Application.DoEvents();
                var tArray = Strings.Split(A[I].ToString(), "|");
                DirectoryName = tArray[0].ToString();
                LibraryName = tArray[1];
                IncludeSubDirs = tArray[2];
                DirectoryName = UTIL.RemoveSingleQuotes(tArray[0].ToString());
                LibraryName = UTIL.RemoveSingleQuotes(tArray[1]);
                IncludeSubDirs = UTIL.RemoveSingleQuotes(tArray[2]);
                ProcessDirToLibs(DirectoryName, LibraryName, IncludeSubDirs, bThreaded);
            }

            A.Clear();
            A = null;
            GC.Collect();
        }

        public void ProcessAllRefEmails(bool bThreaded)
        {
            string S = "";
            S = S + " SELECT [EmailFolderEntryID]";
            S = S + " ,[UserID]";
            S = S + " ,[LibraryName]";
            S = S + " ,[FolderName]";
            S = S + " FROM  [LibEmail]";
            S = S + " where UserID = '" + modGlobals.gCurrUserGuidID + "'";
            var A = new ArrayList();
            string EmailFolderEntryID = "";
            string UserID = "";
            string LibraryName = "";
            string FolderName = "";
            SqlDataReader rsColInfo = null;
            string CS = DBARCH.setConnStr();     // DBARCH.getGateWayConnStr(gGateWayID)
            var tConn = new SqlConnection(CS);
            if (tConn.State == ConnectionState.Closed)
            {
                tConn.Open();
            }

            DBARCH.SqlQryNewThread(S, ref tConn, ref rsColInfo);
            if (rsColInfo.HasRows)
            {
                while (rsColInfo.Read())
                {
                    try
                    {
                        EmailFolderEntryID = rsColInfo.GetValue(rsColInfo.GetOrdinal("EmailFolderEntryID")).ToString();
                        UserID = rsColInfo.GetValue(rsColInfo.GetOrdinal("UserID")).ToString();
                        LibraryName = rsColInfo.GetValue(rsColInfo.GetOrdinal("LibraryName")).ToString();
                        FolderName = rsColInfo.GetValue(rsColInfo.GetOrdinal("FolderName")).ToString();
                        A.Add(EmailFolderEntryID + "|" + LibraryName);
                    }
                    catch (Exception ex)
                    {
                        LOG.WriteToArchiveLog("Warning: ProcessAllRefEmails 100 - " + ex.Message);
                    }
                }
            }

            rsColInfo.Close();
            rsColInfo = null;
            tConn.Close();
            tConn = null;
            GC.Collect();
            for (int I = 0, loopTo = A.Count - 1; I <= loopTo; I++)
            {
                var tArray = Strings.Split(A[I].ToString(), "|");
                EmailFolderEntryID = UTIL.RemoveSingleQuotes(tArray[0]);
                LibraryName = UTIL.RemoveSingleQuotes(tArray[1]);
                ProcessDirToEmails(EmailFolderEntryID, LibraryName, bThreaded);
            }

            A.Clear();
            A = null;
            GC.Collect();
        }

        public void ProcessDirToLibs(string DirName, string LibName, string IncludeSubDirs, bool bThreaded)
        {
            string S = "";
            S = S + " Select count(*) FROM  [DataSource]";
            if (IncludeSubDirs == "Y")
            {
                S = S + " where FileDirectory like '" + DirName + "%'";
            }
            else
            {
                S = S + " where FileDirectory = '" + DirName + "'";
            }

            S = S + " and SourceGuid not in (Select SourceGuid from LibraryItems where LibraryName = '" + LibName + "')";
            int iFileCnt = DBARCH.iCount(S);
            S = "";
            S = S + " Select [SourceGuid]";
            S = S + " ,[SourceName]";
            S = S + " ,[SourceTypeCode]";
            S = S + " ,[FileDirectory]";
            S = S + " FROM  [DataSource]";
            if (IncludeSubDirs == "Y")
            {
                S = S + " where FileDirectory like '" + DirName + "%'";
            }
            else
            {
                S = S + " where FileDirectory = '" + DirName + "'";
            }

            S = S + " and SourceGuid not in (Select SourceGuid from LibraryItems where LibraryName = '" + LibName + "')";
            if (!(bThreaded == false))
            {
                // FrmMDIMain.TSPB1.Value = 0
                // FrmMDIMain.TSPB1.Maximum = iFileCnt + 1
            }

            SqlDataReader rsColInfo = null;
            var tConn = new SqlConnection();
            DBARCH.SqlQryNewThread(S, ref tConn, ref rsColInfo);
            int ii = 0;
            try
            {
                if (rsColInfo.HasRows)
                {
                    while (rsColInfo.Read())
                    {
                        ii += 1;
                        if (modGlobals.gTerminateImmediately == true)
                        {
                            return;
                        }
                        // FrmMDIMain.SB4.Text = "Validate:" & LibName  & ii
                        Application.DoEvents();
                        if (!(bThreaded == false))
                        {
                            // FrmMDIMain.TSPB1.Value = ii
                        }

                        Application.DoEvents();
                        string NewGuid = Guid.NewGuid().ToString();
                        string Itemtitle = rsColInfo.GetValue(rsColInfo.GetOrdinal("SourceName")).ToString();
                        string SourceTypeCode = rsColInfo.GetValue(rsColInfo.GetOrdinal("SourceTypeCode")).ToString();
                        string SourceGuid = rsColInfo.GetValue(rsColInfo.GetOrdinal("SourceGuid")).ToString();
                        LI.setAddedbyuserguidid(ref modGlobals.gCurrUserGuidID);
                        LI.setDatasourceowneruserid(ref modGlobals.gCurrUserGuidID);
                        LI.setItemtitle(ref Itemtitle);
                        LI.setItemtype(ref SourceTypeCode);
                        LI.setLibraryitemguid(ref NewGuid);
                        LI.setLibraryname(ref LibName);
                        LI.setLibraryowneruserid(ref modGlobals.gCurrUserGuidID);
                        LI.setSourceguid(ref SourceGuid);
                        bool B = LI.Insert();
                        if (!B)
                        {
                            LOG.WriteToArchiveLog("Error #654.342.1 - Failed to add Auto Ref Directory '" + DirName + ":'" + LibName + "' .");
                        }

                        if (!bThreaded)
                        {
                            if (ii % 100 == 0)
                            {
                                // FrmMDIMain.SB.Text = "Adding to " + LibName  + "# " + ii.ToString + " of " + iFileCnt.ToString
                                Application.DoEvents();
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: - " + ex.Message);
            }
            finally
            {
                if (rsColInfo is object)
                {
                    if (!rsColInfo.IsClosed)
                    {
                        rsColInfo.Close();
                    }

                    rsColInfo = null;
                }

                if (tConn is object)
                {
                    tConn.Close();
                    tConn = null;
                }

                GC.Collect();
            }

            if (!bThreaded)
            {
                // FrmMDIMain.TSPB1.Value = 0
            }
            // FrmMDIMain.SB4.Text = ""
        }

        public void ProcessDirToEmails(string FolderEntryID, string LibName, bool bThreaded)
        {
            int LL = 0;
            try
            {
                var SqlList = new ArrayList();
                LL = 1;
                string S = "";
                LL = 3;
                S = S + " SELECT  [EmailGuid]";
                LL = 4;
                S = S + " ,[ShortSubj]";
                LL = 5;
                S = S + " ,[SourceTypeCode]";
                LL = 6;
                S = S + " ,[CurrMailFolderID]";
                LL = 7;
                S = S + " FROM  [Email]";
                LL = 8;
                S = S + " WHERE CurrMailFolderID = '" + FolderEntryID + "' ";
                S = S + " AND EmailGuid not in (Select SourceGuid from LibraryItems where LibraryName = '" + LibName + "')";
                LL = 9;
                LL = 10;
                SqlDataReader rsColInfo = null;
                LL = 11;
                LL = 12;
                var tConn = new SqlConnection();
                LL = 13;
                DBARCH.SqlQryNewThread(S, ref tConn, ref rsColInfo);
                LL = 14;
                int II = 0;
                LL = 15;
                LL = 16;
                try
                {
                    LL = 17;
                    if (rsColInfo.HasRows)
                    {
                        LL = 18;
                        while (rsColInfo.Read())
                        {
                            LL = 19;
                            II += 1;
                            LL = 20;
                            string Itemtitle = "";
                            LL = 21;
                            try
                            {
                                LL = 22;
                                string NewGuid = Guid.NewGuid().ToString();
                                LL = 23;
                                Itemtitle = rsColInfo.GetValue(1).ToString();
                                LL = 24;
                                string SourceTypeCode = ".msg";
                                LL = 25;
                                string SourceGuid = rsColInfo.GetValue(0).ToString();
                                LL = 26;
                                LI.setAddedbyuserguidid(ref modGlobals.gCurrUserGuidID);
                                LL = 27;
                                LI.setDatasourceowneruserid(ref modGlobals.gCurrUserGuidID);
                                LL = 28;
                                LI.setItemtitle(ref Itemtitle);
                                LL = 29;
                                LI.setItemtype(ref SourceTypeCode);
                                LL = 30;
                                LI.setLibraryitemguid(ref NewGuid);
                                LL = 31;
                                LI.setLibraryname(ref LibName);
                                LL = 32;
                                LI.setLibraryowneruserid(ref modGlobals.gCurrUserGuidID);
                                LL = 33;
                                LI.setSourceguid(ref SourceGuid);
                                LL = 34;
                                LL = 35;
                                bool B = LI.InsertIntoList(ref SqlList);
                                LL = 36;
                                if (!B)
                                {
                                    Debug.Print("Error #654.342.1 - Failed to add Auto Ref Email.");
                                    LL = 37;
                                }

                                LL = 38;
                                if (!bThreaded)
                                {
                                    LL = 39;
                                    // FrmMDIMain.SB.Text = "E-Ref# " + II.ToString : LL = 40
                                }

                                LL = 41;
                            }
                            catch (Exception ex)
                            {
                                LOG.WriteToArchiveLog("WARNING: ProcessDirToEmails: " + Itemtitle + " did not load." + Constants.vbCrLf + "LL = " + LL.ToString());
                            }

                            LL = 43;
                            LL = 44;
                            Application.DoEvents();
                            LL = 45;
                        }

                        LL = 46;
                    }

                    LL = 47;
                }
                catch (Exception ex)
                {
                    LOG.WriteToArchiveLog("WARNING: ProcessDirToEmails: 100 " + ex.Message + Constants.vbCrLf + "LL = " + LL.ToString());
                }
                finally
                {
                    LL = 49;
                    rsColInfo.Close();
                    LL = 50;
                    rsColInfo = null;
                    LL = 51;
                    tConn.Close();
                    LL = 52;
                    tConn = null;
                    LL = 53;
                    GC.Collect();
                    LL = 54;
                }

                LL = 55;
                LL = 56;
                if (SqlList.Count > 0)
                {
                    LL = 57;
                    LL = 58;
                    // Dim CN As New SqlConnection(DBARCH.setConnStr()     'DBARCH.getGateWayConnStr(gGateWayID)) : LL =  59
                    // Try : LL =  60
                    // CN.Open() : LL =  61
                    // Catch ex As Exception
                    // log.WriteToArchiveLog("ERROR ProcessDirToEmails - 100 Connection not opened: " + ex.Message) : LL =  62
                    // log.WriteToArchiveLog("ERROR ProcessDirToEmails - 100 Connection not opened: " + ex.StackTrace) : LL =  63
                    // Return : LL =  64
                    // End Try : LL =  65
                    LL = 66;
                    for (int I = 0, loopTo = SqlList.Count - 1; I <= loopTo; I++)
                    {
                        LL = 67;
                        try
                        {
                            LL = 68;
                            if (!bThreaded)
                            {
                                // FrmMDIMain.SB.Text = LibName  + " : AddRef# " + I.ToString + " of " + SqlList.Count.ToString : LL = 69
                            }

                            LL = 70;
                            LL = 71;
                            Application.DoEvents();
                            LL = 72;
                            string MySql = Conversions.ToString(SqlList[I]);
                            LL = 73;
                            // Dim B As Boolean = DBARCH.ExecuteSqlSameConn(MySql, CN) : LL =  74
                            bool B = DBARCH.ExecuteSqlTx(MySql);
                            LL = 75;
                            if (!B)
                            {
                                LOG.WriteToArchiveLog("ERROR ProcessDirToEmails - 200 Connection not opened: " + MySql + Constants.vbCrLf + "LL = " + LL.ToString());
                            }

                            LL = 77;
                        }
                        catch (Exception ex)
                        {
                            LOG.WriteToArchiveLog("WARNING: ProcessDirToEmails: 200 " + ex.Message + Constants.vbCrLf + "LL = " + LL.ToString());
                        }

                        LL = 79;
                    }

                    LL = 80;
                    LL = 81;
                    // If Not CN Is Nothing Then : LL =  82
                    // If CN.State = ConnectionState.Open Then : LL =  83
                    // CN.Close() : LL =  84
                    // End If : LL =  85
                    // CN.Dispose() : LL =  86
                    // End If : LL =  87
                }

                LL = 88;
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: ProcessDirToEmails: 220 " + ex.Message + Constants.vbCrLf + "LL = " + LL.ToString());
            }

            GC.Collect();
            LL = 89;
            GC.WaitForPendingFinalizers();
        }
    }
}