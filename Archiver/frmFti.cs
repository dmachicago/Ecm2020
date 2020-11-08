using System;
using System.Collections.Generic;
using System.Data;
using global::System.Data.SQLite;
using global::System.IO;
using global::System.Linq;
using System.Windows.Forms;
using Microsoft.VisualBasic;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{
    public partial class frmFti
    {
        public frmFti()
        {
            InitializeComponent();
            _btnScanGuids.Name = "btnScanGuids";
            _btnSelectAll.Name = "btnSelectAll";
            _lbOutput.Name = "lbOutput";
            _Button1.Name = "Button1";
            _btnFindItem.Name = "btnFindItem";
            _btnSummarize.Name = "btnSummarize";
            _btnCancel.Name = "btnCancel";
        }

        private bool CancelNow = false;
        private clsLogging LOG = new clsLogging();
        private clsDatabaseARCH DBArch = new clsDatabaseARCH();
        private string FTIAnalysisDB = System.Configuration.ConfigurationManager.AppSettings["FTIAnalysisDB"];
        private Dictionary<long, string> DictSourceGuids = new Dictionary<long, string>();
        private Dictionary<string, string> DictErrors = new Dictionary<string, string>();
        private Dictionary<string, string> SourceKeys = new Dictionary<string, string>();
        private Dictionary<string, int> SourceKeyCnt = new Dictionary<string, int>();
        private SQLiteConnection FtiCONN = new SQLiteConnection();
        private string UseMemOptTabl = System.Configuration.ConfigurationManager.AppSettings["UseMemOptTabl"];
        private List<clsKeyTable> KT = new List<clsKeyTable>();
        // New KT With {.TableKey = XX", .SourceName = "xx", .OccurCnt = 20, .TypeCode = 'xx', .OriginalExt = 'xx}
        private List<clsErrors> ERRS = new List<clsErrors>();
        // New ERRS With {.ErrorMsg = XX", .SourceName = "xx", .OccurCnt = 20, .ErrTble = 'xx', .TypeErr = 'xx}

        private void frmFti_Load(object sender, EventArgs e)
        {
            getFtiLogs();
        }

        public void AnalyzeSelectedLogs()
        {
        }

        public void getFtiLogs()
        {
            var files = Directory.GetFiles(modGlobals.FTILogs);
            string FName = "";
            lbFtiLogs.Items.Clear();
            foreach (string file in files)
            {
                FName = Path.GetFileName(file);
                lbFtiLogs.Items.Add(FName);
                // Dim text As String = IO.File.ReadAllText(file)
            }
        }

        private void btnSelectAll_Click(object sender, EventArgs e)
        {
            int i;
            var loopTo = lbFtiLogs.Items.Count - 1;
            for (i = 0; i <= loopTo; i++)
                lbFtiLogs.SetSelected(i, true);
        }

        private void btnScanGuids_Click(object sender, EventArgs e)
        {
            if (lbFtiLogs.SelectedItems.Count.Equals(0))
            {
                MessageBox.Show("Please select at least one file to search, returning...");
                return;
            }

            lbOutput.Items.Clear();
            string FQN = "";
            string TgtText = txtSourceGuid.Text;
            int I = 0;
            int IFound = 0;
            int MaxCnt = Convert.ToInt32(txtMaxNbr.Text);
            SB.Text = "Starting Search";
            int K = 0;
            foreach (string S in lbFtiLogs.SelectedItems)
            {
                FQN = modGlobals.FTILogs + @"\" + S;
                var reader = My.MyProject.Computer.FileSystem.OpenTextFileReader(FQN);
                string line;
                SBFqn.Text = S;
                Cursor = Cursors.WaitCursor;
                do
                {
                    Application.DoEvents();
                    K += 1;
                    if (I >= MaxCnt)
                    {
                        break;
                    }

                    if (K % 5 == 0)
                    {
                        SB.Text = K.ToString();
                        SB.Refresh();
                    }

                    line = reader.ReadLine();
                    if (!Information.IsNothing(line))
                    {
                        if (line.Contains(TgtText))
                        {
                            I += 1;
                            lbOutput.Items.Add(line);
                            IFound += 1;
                            lblMsg.Text = "Items Found: " + IFound.ToString();
                        }
                    }
                }
                while (!(line is null));
                Cursor = Cursors.Default;
                reader.Close();
                reader.Dispose();
            }

            SBFqn.Text = "Search Complete...";
        }

        public string getSourceKey(string line)
        {
            string SourceKey = "";
            int I = 0;
            int J = 0;
            try
            {
                I = line.IndexOf("full-text key value");
                if (I > 0)
                {
                    I = line.IndexOf("'", I + 1);
                    if (I >= 0)
                    {
                        J = line.IndexOf("'", I + 1);
                        if (J >= 0)
                        {
                            SourceKey = line.Substring(I + 1, J - I - 1);
                        }
                        else
                        {
                            return "";
                        }
                    }
                    else
                    {
                        return "";
                    }
                }
                else
                {
                    return "";
                }
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR getSourceKey 00 : " + ex.Message + Constants.vbCrLf + line);
            }

            return SourceKey;
        }

        public string getErrorType(string line)
        {
            string ErrType = "";
            if (line.Contains("Error '"))
            {
                ErrType = "Error";
            }
            else if (line.Contains("Warning:"))
            {
                ErrType = "Warning";
            }
            else
            {
                ErrType = "";
            }

            return ErrType;
        }

        public string getErrorMsg(string line)
        {
            string ErrMsg = "";
            int I = 0;
            int J = 0;
            int len = 0;
            int linelen = 0;
            try
            {
                if (line.Contains("Error '"))
                {
                    I = line.IndexOf("Error '");
                    I = line.IndexOf("'", I + 1);
                    J = line.IndexOf(".'", I + 1);
                    ErrMsg = line.Substring(I + 1, J - I - 1);
                }
                else if (line.Contains("Warning:"))
                {
                    // Warning: No appropriate filter was found during full-text index population for table or indexed view '[ECM.Library.FS].[dbo].[DataSource]' (table or indexed view ID '1634820886', database ID '9'), full-text key value 'DAF4BA6F-1BE7-4247-95B0-04F8D9F22A70'. Some columns of the row were not indexed.
                    I = line.IndexOf("Warning:");
                    I = line.IndexOf(":", I + 1);
                    J = line.IndexOf("[", I + 1);
                    len = J - I - 2;
                    linelen = line.Length;
                    ErrMsg = line.Substring(I + 1, len);
                    ErrMsg = ErrMsg.Trim();
                }
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("Error 00 getErrorMsg: " + ex.Message + Constants.vbCrLf + line);
            }

            return ErrMsg;
        }

        public string getErrorTbl(string line)
        {
            string ErrTbl = "";
            int I = 0;
            int J = 0;
            try
            {
                if (line.Contains("indexed view '"))
                {
                    I = line.IndexOf("indexed view '");
                    I = line.IndexOf("'", I + 1);
                    J = line.IndexOf("'", I + 1);
                    ErrTbl = line.Substring(I + 1, J - I - 1);
                }
                else if (line.Contains("Warning: '"))
                {
                    ErrTbl = "";
                }
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("Error 00 getErrorTbl: " + ex.Message + Constants.vbCrLf + line);
            }

            return ErrTbl;
        }

        public void SummarizeLogs()
        {
            string SourceName = "";
            string FQN = "";
            string line = "";
            int idx = 0;
            int I = 0;
            int J = 0;
            string ErrorMsg = "";
            string TypeErr = "";
            string SourceKey = "";
            string ErrTbl = "";
            long ErrRowNbr = 0L;
            bool B = true;
            long iCnt = 0L;
            long iTotal = 0L;
            DataRow[] SrcDetDR = null;
            DataTable SrcDT = null;
            if (UseMemOptTabl.Equals("1"))
            {
                SrcDT = DBArch.getSrcDT();
            }

            foreach (string LogFile in lbFtiLogs.SelectedItems)
            {
                FQN = modGlobals.FTILogs + @"\" + LogFile;
                SBFqn.Text = "Counting Rows: " + LogFile;
                iTotal += File.ReadAllLines(FQN).Length;
            }

            PB.Maximum = (int)iTotal;
            EmptyTables();
            foreach (string LogFile in lbFtiLogs.SelectedItems)
            {
                FQN = modGlobals.FTILogs + @"\" + LogFile;
                SBFqn.Text = LogFile;
                string[] AR = null;
                string ReturnStr = "";
                string TypeCode = "";
                string OriginalExt = "";
                using (var reader = My.MyProject.Computer.FileSystem.OpenTextFileReader(FQN))
                {
                    do
                    {
                        iCnt += 1L;
                        if (iCnt % 5L == 0L)
                        {
                            SB.Text = "Lines Processed: " + iCnt.ToString() + " of " + iTotal.ToString();
                            PB.Increment(5);
                            // PB.ref
                        }

                        Application.DoEvents();
                        line = reader.ReadLine();
                        if (!Information.IsNothing(line))
                        {
                            // ******************************
                            TypeCode = "";
                            OriginalExt = "";
                            ErrorMsg = getErrorMsg(line);
                            SourceKey = getSourceKey(line);
                            TypeErr = getErrorType(line);
                            ErrTbl = getErrorTbl(line);
                            // ******************************
                            if (ErrorMsg.Trim().Length > 0 & SourceKey.Trim().Length > 0 & TypeErr.Trim().Length > 0 & ErrTbl.Trim().Length > 0)
                            {
                                if (!SourceKeys.ContainsKey(SourceKey))
                                {
                                    // WDM Set this up as selectable because MEMORY may be critical depending upon available RAM
                                    if (UseMemOptTabl.Equals("1"))
                                    {
                                        SrcDetDR = SrcDT.Select("RowGuid = '" + SourceKey + "'");
                                        if (SrcDetDR.Count() > 0)
                                        {
                                            SourceName = Conversions.ToString(SrcDetDR[0]["SourceName"]);
                                            OriginalExt = Conversions.ToString(SrcDetDR[0]["OriginalFileType"]);
                                            TypeCode = Conversions.ToString(SrcDetDR[0]["SourceTypeCode"]);
                                        }
                                        else
                                        {
                                            SourceName = "Not Found";
                                            TypeCode = "?";
                                            OriginalExt = "?";
                                        }
                                    }
                                    else
                                    {
                                        ReturnStr = DBArch.getSourceNameByGuid(SourceKey);
                                        if (ReturnStr.Trim().Length.Equals(0))
                                        {
                                            SourceName = "Not Found";
                                            TypeCode = "?";
                                            OriginalExt = "?";
                                        }
                                        else
                                        {
                                            AR = ReturnStr.Split('|');
                                            SourceName = AR[0];
                                            TypeCode = AR[1];
                                            OriginalExt = AR[2];
                                        }
                                    }

                                    if (SourceKey.Trim().Length > 0)
                                    {
                                        SourceKeys.Add(SourceKey, SourceName);
                                    }

                                    if (UseMemOptTabl.Equals("1"))
                                    {
                                        saveFtiErrDS(ErrorMsg, TypeErr, ErrTbl);
                                    }
                                    else
                                    {
                                        ErrRowNbr = saveFtiErr(ErrorMsg, TypeErr, ErrTbl, 1);
                                    }

                                    if (UseMemOptTabl.Equals("1"))
                                    {
                                        saveFtiSourceGuidDS((int)ErrRowNbr, SourceKey, SourceName, TypeCode, OriginalExt);
                                    }
                                    else
                                    {
                                        saveFtiSourceGuid(ErrRowNbr, SourceKey, SourceName, 0, TypeCode, OriginalExt);
                                    }
                                }
                                else if (UseMemOptTabl.Equals("1"))
                                {
                                    saveFtiSourceGuidDS((int)ErrRowNbr, SourceKey, SourceName, TypeCode, OriginalExt);
                                }
                                else
                                {
                                    SourceName = SourceKeys[SourceKey];
                                    ErrRowNbr = saveFtiErr(ErrorMsg, TypeErr, ErrTbl, 1);
                                    saveFtiSourceGuid(ErrRowNbr, SourceKey, SourceName, 1, TypeCode, OriginalExt);
                                }

                                if (!SourceKeyCnt.ContainsKey(SourceKey))
                                {
                                    SourceKeyCnt.Add(SourceKey, 1);
                                }
                                else
                                {
                                    int kcnt = SourceKeyCnt[SourceKey];
                                    kcnt += 1;
                                    SourceKeyCnt[SourceKey] = kcnt;
                                }
                            }
                        }

                        Application.DoEvents();
                    }
                    while (!(line is null | CancelNow.Equals(true)));
                }

                if (CancelNow.Equals(true))
                {
                    break;
                }
            }

            PB.Value = 0;
            if (CancelNow.Equals(false) & UseMemOptTabl.Equals("1"))
            {
                applyERRDeails();
                applyFTIDetails();
            }

            CancelNow = false;
            SBFqn.Text = "FINISHED...";
        }

        public string setSingleQuotes(string Str)
        {
            if (Str.Contains("'"))
            {
                Str = Str.Replace("''", "'");
                Str = Str.Replace("'", "''");
            }

            return Str;
        }

        public void applyERRDeails()
        {
            long ErrRowNbr = -1;
            string CS = "data source= " + FTIAnalysisDB;
            string MySql = "";
            int iCnt = 0;
            string ErrorMsg = "";
            string TypeErr = "";
            string ErrTbl = "";
            int OccurCnt = 0;

            // FtiCONN.Open()
            SetDBConn();
            SBFqn.Text = "Applying Error details To Database";
            MySql = "";
            try
            {
                using (FtiCONN)
                {
                    var CMD = new SQLiteCommand(FtiCONN);
                    using (CMD)
                        foreach (clsErrors item in ERRS)
                        {
                            iCnt += 1;
                            SB.Text = "Rec # " + iCnt.ToString();
                            Application.DoEvents();
                            try
                            {
                                ErrorMsg = setSingleQuotes(item.ErrorMsg);
                                TypeErr = setSingleQuotes(item.TypeErr);
                                ErrTbl = setSingleQuotes(item.ErrTbl);
                                OccurCnt = item.OccurCnt;
                                MySql = "Insert into Errors (ErrorMsg, TypeErr, ErrTbl, OccrCnt) values ('" + ErrorMsg + "', '" + TypeErr + "', '" + ErrTbl + "', " + OccurCnt.ToString() + ")";
                                CMD.CommandText = MySql;
                                CMD.ExecuteNonQuery();
                            }
                            catch (Exception ex)
                            {
                                LOG.WriteToArchiveLog("ERROR: applyERRDeails 04 - " + ex.Message + Constants.vbCrLf + MySql);
                                bConnSet = false;
                            }
                        }
                }
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR SaveErr 00 : " + ex.Message);
            }
        }

        public void applyFTIDetails()
        {
            string SqlStmt = "";
            bool B = true;
            // Dim FtiCONN As New SQLiteConnection()
            string CS = "data source= " + FTIAnalysisDB;
            string MySql = "";
            int iCnt = 0;
            int ErrRowNbr = 0;
            string TableKey = "";
            string SourceName = "";
            string TypeCode = "";
            string OriginalExt = "";
            var KeyTbl = new clsKeyTable();
            SBFqn.Text = "Applying ROW ERROR details to Database";
            SetDBConn();
            try
            {
                MySql = "Insert or ignore into KeyTable (ErrRowNbr, TableKey, SourceName, OccrCnt, TypeCode, OriginalExt) values (@ErrRowNbr, @TableKey, @SourceName, @OccrCnt, @TypeCode, @OriginalExt)";
                using (FtiCONN)
                {
                    var CMD = new SQLiteCommand(FtiCONN);
                    using (CMD)
                        foreach (clsKeyTable item in KT)
                        {
                            iCnt += 1;
                            SB.Text = "Rec #" + iCnt.ToString();
                            Application.DoEvents();
                            try
                            {
                                ErrRowNbr = (int)item.ErrRowNbr;
                                TableKey = item.TableKey;
                                SourceName = item.SourceName;
                                TypeCode = item.TypeCode;
                                OriginalExt = item.OriginalExt;
                                OccrCnt = item.OccurCnt;

                                // CMD.Parameters.AddWithValue("@ErrRowNbr", ErrRowNbr)
                                // CMD.Parameters.AddWithValue("@TableKey", TableKey)
                                // CMD.Parameters.AddWithValue("@SourceName", SourceName)
                                // CMD.Parameters.AddWithValue("@TypeCode", TypeCode)
                                // CMD.Parameters.AddWithValue("@OriginalExt", OriginalExt)

                                MySql = @"Insert into KeyTable (ErrRowNbr, TableKey, SourceName, OccrCnt,TypeCode, OriginalExt) 
                                    values (
                                    " + ErrRowNbr.ToString() + ", '" + TableKey + "', '" + SourceName + "', " + OccrCnt.ToString() + ", '" + TypeCode + "', '" + OriginalExt + "')";
                                CMD.CommandText = MySql;
                                CMD.ExecuteNonQuery();
                                B = true;
                            }
                            catch (Exception ex)
                            {
                                B = false;
                                LOG.WriteToArchiveLog("ERROR: applyFTIDetails 00 - " + ex.Message + Constants.vbCrLf + MySql);
                            }
                        }
                }
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: saveFtiSourceGuid 01 - " + ex.Message);
                B = false;
            }
        }

        public bool saveFtiSourceGuid(long ErrRowNbr, string TableKey, string SourceName, int cnt, string TypeCode, string OriginalExt)
        {
            bool B = true;
            // Dim FtiCONN As New SQLiteConnection()
            string CS = "data source= " + FTIAnalysisDB;
            string MySql = "";
            int iCnt = 0;
            SetDBConn();
            try
            {
                MySql = "Insert or ignore into KeyTable (ErrRowNbr, TableKey, SourceName, OccrCnt, TypeCode, OriginalExt) values (@ErrRowNbr, @TableKey, @SourceName, @OccrCnt, @TypeCode, @OriginalExt)";
                using (FtiCONN)
                {
                    var CMD = new SQLiteCommand(FtiCONN);
                    CMD.Parameters.AddWithValue("@ErrRowNbr", ErrRowNbr);
                    CMD.Parameters.AddWithValue("@TableKey", TableKey);
                    CMD.Parameters.AddWithValue("@SourceName", SourceName);
                    CMD.Parameters.AddWithValue("@TypeCode", TypeCode);
                    CMD.Parameters.AddWithValue("@OriginalExt", OriginalExt);
                    CMD.CommandText = "select count(*) as CNT from KeyTable where TableKey = @TableKey ";
                    iCnt = Convert.ToInt32(CMD.ExecuteScalar());
                    if (iCnt > 0)
                    {
                        MySql = "update KeyTable set OccrCnt = OccrCnt+1 where TableKey = @TableKey";
                    }
                    else
                    {
                        cnt = 1;
                        CMD.Parameters.AddWithValue("@OccrCnt", cnt);
                        MySql = "Insert into KeyTable (ErrRowNbr, TableKey, SourceName, OccrCnt,TypeCode, OriginalExt) values (@ErrRowNbr, @TableKey, @SourceName, @OccrCnt, @TypeCode, @OriginalExt)";
                    }

                    try
                    {
                        CMD.CommandText = MySql;
                        CMD.ExecuteNonQuery();
                        B = true;
                    }
                    catch (Exception ex)
                    {
                        B = false;
                        LOG.WriteToArchiveLog("ERROR: saveFtiSourceGuid 00 - " + ex.Message + Constants.vbCrLf + MySql);
                    }
                    finally
                    {
                        CMD.Dispose();
                        GC.Collect();
                        GC.WaitForPendingFinalizers();
                    }
                }
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: saveFtiSourceGuid 01 - " + ex.Message);
                B = false;
            }

            return B;
        }

        public void EmptyTables()
        {
            long ErrRowNbr = -1;
            string CS = "data source= " + FTIAnalysisDB;
            string MySql = "";
            SetDBConn();
            MySql = "delete from Errors ";
            var CMD = new SQLiteCommand(MySql, FtiCONN);
            try
            {
                using (FtiCONN)
                    try
                    {
                        CMD.ExecuteNonQuery();
                        CMD.CommandText = "Delete from KeyTable";
                        CMD.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        LOG.WriteToArchiveLog("ERROR: saveFtiErr 04 - " + ex.Message + Constants.vbCrLf + MySql);
                        bConnSet = false;
                    }
                    finally
                    {
                        CMD.Dispose();
                        GC.Collect();
                        GC.WaitForPendingFinalizers();
                    }
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR SaveErr 00 : " + ex.Message);
            }
        }

        public long saveFtiErrDS(string ErrorMsg, string TypeErr, string ErrTbl)
        {
            int index = 0;
            int NewRowID = ERRS.Count + 1;
            var SelectedRow = from thErr in ERRS
                              where thErr.ErrorMsg.Equals(ErrorMsg)
                              select thErr;
            // Order By theElement.Name
            if (SelectedRow.Count() == 1)
            {
                foreach (var item in SelectedRow)
                    item.OccurCnt = item.OccurCnt + 1;
            }
            else if (SelectedRow.Count().Equals(0))
            {
                var theErr = new clsErrors();
                theErr.ErrRowNbr = 1L;
                theErr.OccurCnt = 1;
                theErr.ErrorMsg = ErrorMsg;
                theErr.TypeErr = TypeErr;
                theErr.ErrTbl = ErrTbl;
                ERRS.Add(theErr);
            }
            else
            {
                Console.WriteLine("ERROR saveFtiErrDS");
            }

            return default;
            // New ERRS With {.ErrorMsg = XX", .SourceName = "xx", .OccurCnt = 20, .ErrTble = 'xx', .TypeErr = 'xx}
        }

        public long saveFtiSourceGuidDS(int ErrRowNbr, string SourceKey, string SourceName, string TypeCode, string OriginalExt)
        {
            // (ErrRowNbr, SourceKey, SourceName,  TypeCode, OriginalExt)
            int index = 0;
            int NewRowID = ERRS.Count + 1;
            var SelectedRow = from theGuid in KT
                              where theGuid.TableKey.Equals(SourceKey)
                              select theGuid;
            if (SelectedRow.Count() == 1)
            {
                foreach (var item in SelectedRow)
                    item.OccurCnt = item.OccurCnt + 1;
            }
            else if (SelectedRow.Count().Equals(0))
            {
                var KeyTable = new clsKeyTable();
                KeyTable.ErrRowNbr = ErrRowNbr;
                KeyTable.TableKey = SourceKey;
                KeyTable.SourceName = SourceName;
                KeyTable.TypeCode = TypeCode;
                KeyTable.OriginalExt = OriginalExt;
                KeyTable.OccurCnt = 1;
                KT.Add(KeyTable);
            }
            else
            {
                Console.WriteLine("ERROR saveFtiSourceGuidDS");
            }

            return default;
            // New ERRS With {.ErrorMsg = XX", .SourceName = "xx", .OccurCnt = 20, .ErrTble = 'xx', .TypeErr = 'xx}
        }

        public long saveFtiErr(string ErrorMsg, string TypeErr, string ErrTbl, int OccrCnt)
        {
            long ErrRowNbr = -1;
            string CS = "data source= " + FTIAnalysisDB;
            string MySql = "Insert or ignore into Errors (ErrorMsg, TypeErr, ErrTbl) values (@ErrorMsg, @TypeErr, @ErrTbl)";
            int iCnt = 0;
            // FtiCONN.Open()
            SetDBConn();
            MySql = "";
            try
            {
                using (FtiCONN)
                {
                    var CMD = new SQLiteCommand(FtiCONN);
                    try
                    {
                        CMD.Parameters.AddWithValue("@ErrorMsg", ErrorMsg);
                        CMD.Parameters.AddWithValue("@TypeErr", TypeErr);
                        CMD.Parameters.AddWithValue("@ErrTbl", ErrTbl);
                        CMD.CommandText = "select count(*) as CNT from Errors where ErrorMsg = @ErrorMsg and TypeErr = @TypeErr and ErrTbl = @ErrTbl ";
                        iCnt = (int)Convert.ToInt64(CMD.ExecuteScalar());
                        if (iCnt.Equals(0))
                        {
                            MySql = "Insert into Errors (ErrorMsg, TypeErr, ErrTbl, OccrCnt) values (@ErrorMsg, @TypeErr, @ErrTbl, 1)";
                            CMD.CommandText = MySql;
                            CMD.ExecuteNonQuery();
                            CMD.CommandText = "select last_insert_rowid()";
                            ErrRowNbr = Convert.ToInt64(CMD.ExecuteScalar());
                        }
                        else
                        {
                            MySql = "Update Errors set OccrCnt = OccrCnt+1 where ErrorMsg = @ErrorMsg and TypeErr = @TypeErr and ErrTbl = @ErrTbl ";
                            CMD.CommandText = MySql;
                            CMD.ExecuteNonQuery();
                            CMD.CommandText = "select ErrRowNbr as CNT from Errors where ErrorMsg = @ErrorMsg and TypeErr = @TypeErr and ErrTbl = @ErrTbl ";
                            ErrRowNbr = Convert.ToInt64(CMD.ExecuteScalar());
                            MySql = "";
                        }
                    }
                    catch (Exception ex)
                    {
                        LOG.WriteToArchiveLog("ERROR: saveFtiErr 04 - " + ex.Message + Constants.vbCrLf + MySql);
                        bConnSet = false;
                    }
                    finally
                    {
                        CMD.Dispose();
                        GC.Collect();
                        GC.WaitForPendingFinalizers();
                    }
                }
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR SaveErr 00 : " + ex.Message);
            }

            return ErrRowNbr;
        }

        private void Button1_Click(object sender, EventArgs e)
        {
            string key = "SQLFT0001200010.LOG.4";
            string lbkey = "";
            int i;
            var loopTo = lbFtiLogs.Items.Count - 1;
            for (i = 0; i <= loopTo; i++)
                lbFtiLogs.SetSelected(i, false);
            var loopTo1 = lbFtiLogs.Items.Count - 1;
            for (i = 0; i <= loopTo1; i++)
            {
                lbkey = Conversions.ToString(lbFtiLogs.Items[i]);
                if ((lbkey ?? "") == (key ?? ""))
                {
                    lbFtiLogs.SetSelected(i, true);
                }
            }
        }

        private void lbOutput_SelectedIndexChanged(object sender, EventArgs e)
        {
            string s = Conversions.ToString(lbOutput.SelectedItems[0]);
            txtDetail.Text = s;
            string tkey = "";
            string db = "";
            int i = 0;
            int k = 0;
            try
            {
                i = s.IndexOf("view");
                if (i >= 0)
                {
                    i = s.IndexOf("'", i + 1);
                    j = s.IndexOf("'", i + 1);
                    db = s.Substring(i + 1, Conversions.ToInteger(Operators.SubtractObject(Operators.SubtractObject(j, i), 1)));
                    txtDb.Text = db;
                }

                i = s.IndexOf("key value");
                if (i >= 0)
                {
                    i = s.IndexOf("'", i + 1);
                    j = s.IndexOf("'", i + 1);
                    tkey = s.Substring(i + 1, Conversions.ToInteger(Operators.SubtractObject(Operators.SubtractObject(j, i), 1)));
                    txtKeyGuid.Text = tkey;
                }
            }
            catch (Exception ex)
            {
                SB.Text = "ERROR: " + ex.Message;
            }
        }

        private void btnFindItem_Click(object sender, EventArgs e)
        {
            string fqn = "";
            string db = txtDb.Text.ToUpper();
            int i = db.IndexOf("EMAILATTACHMENT");
            int j = db.IndexOf("DataSource");
            if (i >= 0)
            {
                fqn = DBArch.getFqnFromGuid(txtSourceGuid.Text, "EmailAttachment");
                SBFqn.Text = fqn;
                SB.Text = Path.GetFileName(fqn);
            }
            else if (j >= 0)
            {
                fqn = DBArch.getFqnFromGuid(txtSourceGuid.Text);
                SBFqn.Text = fqn;
                SB.Text = Path.GetFileName(fqn);
            }
            else
            {
                SB.Text = "NOTICE: Cannot retrieve data from this information.";
            }
        }

        public bool SetDBConn()
        {
            bool bb = true;
            string cs = "";
            try
            {
                FtiCONN = new SQLiteConnection();
            }
            catch (Exception ex)
            {
                Console.WriteLine("WARNING: " + ex.Message);
            }

            if (!FtiCONN.State.Equals(ConnectionState.Open))
            {
                try
                {
                    FTIAnalysisDB = System.Configuration.ConfigurationManager.AppSettings["FTIAnalysisDB"];
                    if (!File.Exists(FTIAnalysisDB))
                    {
                        MessageBox.Show("FATAL ERR SQLite DB MISSING: " + FTIAnalysisDB);
                    }

                    cs = "data source=" + FTIAnalysisDB;
                    modGlobals.gLocalDBCS = cs;
                    FtiCONN.ConnectionString = cs;
                    FtiCONN.Open();
                    bb = true;
                    bSQLiteCOnnected = true;
                }
                catch (Exception ex)
                {
                    var LG = new clsLogging();
                    LG.WriteToArchiveLog("ERROR LOCALDB SetDBConn: " + ex.Message + Constants.vbCrLf + cs);
                    LG = null;
                    bb = false;
                    bSQLiteCOnnected = false;
                }
            }

            return bb;
        }

        private void btnSummarize_Click(object sender, EventArgs e)
        {
            SummarizeLogs();
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            CancelNow = true;
        }
    }

    public class clsKeyTable
    {
        public long ErrRowNbr { get; set; }
        public string TableKey { get; set; }
        public string SourceName { get; set; }
        public int OccurCnt { get; set; }
        public string TypeCode { get; set; }
        public string OriginalExt { get; set; }
    }

    public class clsErrors
    {
        public long ErrRowNbr { get; set; }
        public string ErrorMsg { get; set; }
        public string ErrTbl { get; set; }
        public string TypeErr { get; set; }
        public int OccurCnt { get; set; }
    }
}