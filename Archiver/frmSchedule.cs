using System;
using global::System.Globalization;
using global::System.IO;
using System.Windows.Forms;
using Microsoft.VisualBasic;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{
    public partial class frmSchedule
    {
        public frmSchedule()
        {
            InitializeComponent();
            _dgSchedule.Name = "dgSchedule";
            _btnDisplaySchedules.Name = "btnDisplaySchedules";
            _btnDelete.Name = "btnDelete";
            _cbScheduleUnits.Name = "cbScheduleUnits";
            _btnUpdate.Name = "btnUpdate";
            _btnAdd.Name = "btnAdd";
            _WindowsSchedulerToolStripMenuItem.Name = "WindowsSchedulerToolStripMenuItem";
            _ApplicationExecutionPathToolStripMenuItem.Name = "ApplicationExecutionPathToolStripMenuItem";
            _btnDisableArchive.Name = "btnDisableArchive";
            _btnEnableArchive.Name = "btnEnableArchive";
            _btnValidate.Name = "btnValidate";
            _ckShowAll.Name = "ckShowAll";
            _CommandExecutionDirectoryToolStripMenuItem.Name = "CommandExecutionDirectoryToolStripMenuItem";
        }

        private clsLogging LOG = new clsLogging();
        private clsUtility UTIL = new clsUtility();
        private clsScheduler SCHED = new clsScheduler();
        private clsRegistry REG = new clsRegistry();

        private void btnDisplaySchedules_Click(object sender, EventArgs e)
        {
            var argDG = dgSchedule;
            SCHED.PopulateScheduleGrid(ref argDG);
            dgSchedule = argDG;
            ckShowAll_CheckedChanged(null, null);
        }

        public void AddSchedule()
        {

            // SCHTASKS /Create [/S system [/U username [/P [password]]]]
            // [/RU username [/RP password]] /SC schedule [/MO modifier] [/D day]
            // [/M months] [/I idletime] /TN taskname /TR taskrun [/ST starttime]
            // [/RI interval] [ {/ET endtime | /DU duration} [/K] [/XML xmlfile] [/V1]]
            // [/SD startdate] [/ED enddate] [/IT | /NP] [/Z] [/F]
            // 
            // Description:
            // Enables an administrator to create scheduled tasks on a local or
            // remote system.
            // 
            // Parameter List:
            // /S   system        Specifies the remote system to connect to. If omitted
            // the system parameter defaults to the local system.
            // 
            // /U   username      Specifies the user context under which SchTasks.exe 
            // should execute.
            // 
            // /P   [password]    Specifies the password for the given user context.
            // Prompts for input if omitted.
            // 
            // /RU  username      Specifies the "run as" user account (user context)
            // under which the task runs. For the system account,
            // valid values are "", "NT AUTHORITY\SYSTEM"
            // or "SYSTEM".
            // For v2 tasks, "NT AUTHORITY\LOCALSERVICE" and 
            // "NT AUTHORITY\NETWORKSERVICE" are also available as well 
            // as the well known SIDs for all three. 
            // 
            // /RP  [password]    Specifies the password for the "run as" user. 
            // To prompt for the password, the value must be either
            // "*" or none. This password is ignored for the 
            // system account. Must be combined with either /RU or
            // /XML switch.
            // 
            // /SC   schedule     Specifies the schedule frequency.
            // Valid schedule types: MINUTE, HOURLY, DAILY, WEEKLY, 
            // MONTHLY, ONCE, ONSTART, ONLOGON, ONIDLE, ONEVENT.
            // 
            // /MO   modifier     Refines the schedule type to allow finer control over
            // schedule recurrence. Valid values are listed in the 
            // "Modifiers" section below.
            // 
            // /D    days         Specifies the day of the week to run the task. Valid 
            // values: MON, TUE, WED, THU, FRI, SAT, SUN and for
            // MONTHLY schedules 1 - 31 (days of the month). 
            // Wildcard "*" specifies all days.
            // 
            // /M    months       Specifies month(s) of the year. Defaults to the first 
            // day of the month. Valid values: JAN, FEB, MAR, APR, 
            // MAY, JUN, JUL, AUG, SEP, OCT, NOV, DEC. Wildcard "*" 
            // specifies all months.
            // 
            // /I    idletime     Specifies the amount of idle time to wait before 
            // running a scheduled ONIDLE task.
            // Valid range: 1 - 999 minutes.
            // 
            // /TN   taskname     Specifies a name which uniquely
            // identifies this scheduled task.
            // 
            // /TR   taskrun      Specifies the path and file name of the program to be 
            // run at the scheduled time.
            // Example: C:\windows\system32\calc.exe
            // 
            // /ST   starttime    Specifies the start time to run the task. The time 
            // format is HH:mm (24 hour time) for example, 14:30 for 
            // 2:30 PM. Defaults to current time if /ST is not 
            // specified.  This option is required with /SC ONCE.
            // 
            // /RI   interval     Specifies the repetition interval in minutes. This is 
            // not applicable for schedule types: MINUTE, HOURLY,
            // ONSTART, ONLOGON, ONIDLE, ONEVENT.
            // Valid range: 1 - 599940 minutes.
            // If either /ET or /DU is specified, then it defaults to 
            // 10 minutes.
            // 
            // /ET   endtime      Specifies the end time to run the task. The time format
            // is HH:mm (24 hour time) for example, 14:50 for 2:50 PM.
            // This is not applicable for schedule types: ONSTART, 
            // ONLOGON, ONIDLE, ONEVENT.
            // 
            // /DU   duration     Specifies the duration to run the task. The time 
            // format is HH:mm. This is not applicable with /ET and
            // for schedule types: ONSTART, ONLOGON, ONIDLE, ONEVENT.
            // For /V1 tasks, if /RI is specified, duration defaults 
            // to 1 hour.
            // 
            // /K                 Terminates the task at the endtime or duration time. 
            // This is not applicable for schedule types: ONSTART, 
            // ONLOGON, ONIDLE, ONEVENT. Either /ET or /DU must be
            // specified.
            // 
            // /SD   startdate    Specifies the first date on which the task runs. The 
            // format is dd/mm/yyyy. Defaults to the current 
            // date. This is not applicable for schedule types: ONCE, 
            // ONSTART, ONLOGON, ONIDLE, ONEVENT.
            // 
            // /ED   enddate      Specifies the last date when the task should run. The 
            // format is dd/mm/yyyy. This is not applicable for 
            // schedule types: ONCE, ONSTART, ONLOGON, ONIDLE, ONEVENT.
            // 
            // /EC   ChannelName  Specifies the event channel for OnEvent triggers.
            // 
            // /IT                Enables the task to run interactively only if the /RU 
            // user is currently logged on at the time the job runs.
            // This task runs only if the user is logged in.
            // 
            // /NP                No password is stored.  The task runs non-interactively
            // as the given user.  Only local resources are available.
            // 
            // /Z                 Marks the task for deletion after its final run.
            // 
            // /XML  xmlfile      Creates a task from the task XML specified in a file.
            // Can be combined with /RU and /RP switches, or with /RP 
            // alone, when task XML already contains the principal.
            // 
            // /V1                Creates a task visible to pre-Vista platforms.
            // Not compatible with /XML.
            // 
            // /F                 Forcefully creates the task and suppresses warnings if 
            // the specified task already exists.
            // 
            // /RL   level        Sets the Run Level for the job. Valid values are 
            // LIMITED and HIGHEST. The default is LIMITED.
            // 
            // /DELAY delaytime   Specifies the wait time to delay the running of the 
            // task after the trigger is fired.  The time format is
            // mmmm:ss.  This option is only valid for schedule types
            // ONSTART, ONLOGON, ONEVENT.
            // 
            // /?                 Displays this help message.
            // 
            // Modifiers: Valid values for the /MO switch per schedule type:
            // MINUTE:  1 - 1439 minutes.
            // HOURLY:  1 - 23 hours.
            // DAILY:   1 - 365 days.
            // WEEKLY:  weeks 1 - 52.
            // ONCE:    No modifiers.
            // ONSTART: No modifiers.
            // ONLOGON: No modifiers.
            // ONIDLE:  No modifiers.
            // MONTHLY: 1 - 12, or 
            // FIRST, SECOND, THIRD, FOURTH, LAST, LASTDAY.
            // 
            // ONEVENT:  XPath event query string.
            // Examples:
            // ==> Creates a scheduled task "doc" on the remote machine "ABC"
            // which runs notepad.exe every hour under user "runasuser". 
            // 
            // SCHTASKS /Create /S ABC /U user /P password /RU runasuser
            // /RP runaspassword /SC HOURLY /TN doc /TR notepad 
            // 
            // ==> Creates a scheduled task "accountant" on the remote machine 
            // "ABC" to run calc.exe every five minutes from the specified
            // start time to end time between the start date and end date.
            // 
            // SCHTASKS /Create /S ABC /U domain\user /P password /SC MINUTE
            // /MO 5 /TN accountant /TR calc.exe /ST 12:00 /ET 14:00
            // /SD 06/06/2006 /ED 06/06/2006 /RU runasuser /RP userpassword
            // 
            // ==> Creates a scheduled task "gametime" to run freecell on the 
            // first Sunday of every month.
            // 
            // SCHTASKS /Create /SC MONTHLY /MO first /D SUN /TN gametime 
            // /TR c:\windows\system32\freecell
            // 
            // ==> Creates a scheduled task "report" on remote machine "ABC"
            // to run notepad.exe every week.
            // 
            // SCHTASKS /Create /S ABC /U user /P password /RU runasuser
            // /RP runaspassword /SC WEEKLY /TN report /TR notepad.exe
            // 
            // ==> Creates a scheduled task "logtracker" on remote machine "ABC"
            // to run notepad.exe every five minutes starting from the
            // specified start time with no end time. The /RP password will be
            // prompted for.
            // 
            // SCHTASKS /Create /S ABC /U domain\user /P password /SC MINUTE
            // /MO 5 /TN logtracker 
            // /TR c:\windows\system32\notepad.exe /ST 18:30
            // /RU runasuser /RP

            // SCHTASKS /U domain\user /P password /SC MINUTE /MO 5 /TN ECM_ARCHIVEALL /TR c:\windows\system32\notepad.exe /ST 18:30 
            // 
            // ==> Creates a scheduled task "gaming" to run freecell.exe starting
            // at 12:00 and automatically terminating at 14:00 hours every day
            // 
            // SCHTASKS /Create /SC DAILY /TN gaming /TR c:\freecell /ST 12:00
            // /ET 14:00 /K
            // ==> Creates a scheduled task "EventLog" to run wevtvwr.msc starting
            // whenever event 101 is published in the System channel
            // 
            // SCHTASKS /Create /TN EventLog /TR wevtvwr.msc /SC ONEVENT
            // /EC System /MO *[System/EventID=101] 
            // ==> Spaces in file paths can be used by using two sets of quotes, one
            // set for CMD.EXE and one for SchTasks.exe.  The outer quotes for CMD
            // need to be double quotes; the inner quotes can be single quotes or
            // escaped double quotes:
            // SCHTASKS /Create 
            // /tr "'c:\program files\internet explorer\iexplorer.exe' 
            // \"c:\log data\today.xml\"" ...


            // ***************************************************************************************
            // SCHTASKS /Create /TN ECM_TEST /SC DAILY /TR "dir c:\temp\*.* >DIR.List.TXT"
            // ***************************************************************************************

            string TaskCmd = "";
            TaskCmd = @"SCHTASKS /U <UserID> /P <password> /SC MINUTE /MO 5 /TN ECM_ARCHIVEALL /TR c:\windows\system32\notepad.exe /ST 18:30";
        }

        private void cbScheduleUnits_SelectedIndexChanged(object sender, EventArgs e)
        {
            // HOURLY
            // DAILY
            // WEEKLY, 
            // MONTHLY

            cbTod.Items.Clear();
            cbTod.Text = "";
            string rTime = "";
            for (int i = 0; i <= 23; i++)
            {
                for (int k = 1; k <= 4; k++)
                {
                    if (i < 10)
                    {
                        rTime = "0" + i.ToString();
                    }
                    else
                    {
                        rTime = i.ToString();
                    }

                    if (k == 1)
                    {
                        rTime += ":00";
                    }
                    else if (k == 2)
                    {
                        rTime += ":15";
                    }
                    else if (k == 3)
                    {
                        rTime += ":30";
                    }
                    else if (k == 4)
                    {
                        rTime += ":45";
                    }

                    cbTod.Items.Add(rTime);
                }
            }

            if (cbScheduleUnits.Text.Equals("HOURLY"))
            {
                Label3.Visible = false;
                cbDayToRun.Visible = false;
                Label2.Visible = false;
                dtStart.Text = DateAndTime.Now.ToString();
                dtStart.Visible = false;
                Label4.Visible = false;
                cbTod.Visible = false;
            }
            else if (cbScheduleUnits.Text.Equals("DAILY"))
            {
                Label3.Visible = true;
                cbDayToRun.Visible = true;
                Label2.Visible = true;
                dtStart.Visible = true;
                Label3.Visible = false;
                cbDayToRun.Visible = false;
                Label4.Visible = true;
                cbTod.Visible = true;
                Label3.Text = "Pick the Time To run:";
                cbDayToRun.Items.Clear();
                cbDayToRun.Text = "";
                rTime = "";
                for (int i = 0; i <= 23; i++)
                {
                    for (int k = 1; k <= 4; k++)
                    {
                        if (i < 10)
                        {
                            rTime = "0" + i.ToString();
                        }
                        else
                        {
                            rTime = i.ToString();
                        }

                        if (k == 1)
                        {
                            rTime += ":00";
                        }
                        else if (k == 2)
                        {
                            rTime += ":15";
                        }
                        else if (k == 3)
                        {
                            rTime += ":30";
                        }
                        else if (k == 4)
                        {
                            rTime += ":45";
                        }

                        cbDayToRun.Items.Add(rTime);
                    }
                }
            }
            else if (cbScheduleUnits.Text.Equals("WEEKLY"))
            {
                Label3.Visible = true;
                cbDayToRun.Visible = true;
                Label2.Visible = true;
                dtStart.Visible = true;
                Label4.Visible = true;
                cbTod.Visible = true;
                Label3.Text = "Pick the Day To run:";
                cbDayToRun.Items.Clear();
                cbDayToRun.Text = "";
                cbDayToRun.Items.Add("SUN");
                cbDayToRun.Items.Add("MON");
                cbDayToRun.Items.Add("TUE");
                cbDayToRun.Items.Add("WED");
                cbDayToRun.Items.Add("THU");
                cbDayToRun.Items.Add("FRI");
                cbDayToRun.Items.Add("SAT");
            }
            else if (cbScheduleUnits.Text.Equals("MONTHLY"))
            {
                Label3.Visible = true;
                cbDayToRun.Visible = true;
                Label2.Visible = true;
                dtStart.Visible = true;
                Label4.Visible = true;
                cbTod.Visible = true;
                Label3.Text = "Pick the Day To run:";
                cbDayToRun.Items.Clear();
                cbDayToRun.Text = "";
                for (int i = 0; i <= 31; i++)
                    cbDayToRun.Items.Add(i.ToString());
            }
        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            string msg = "This will DELETE the selected archive schedule, are you sure?";
            var dlgRes = MessageBox.Show(msg, "Cannot be undone!", MessageBoxButtons.YesNo);
            if (dlgRes == DialogResult.No)
            {
                return;
            }

            string TaskName = SelectedTaskName.Text;
            string CMD = "SCHTASKS /Delete /F /TN " + TaskName;
            ExecuteCommandFile(CMD);
            REG.UpdateEcmRegistrySubKey(TaskName, "");
        }

        private void btnUpdate_Click(object sender, EventArgs e)
        {
            string TaskName = SelectedTaskName.Text;
            string CMD = "SCHTASKS /Delete /F /TN " + TaskName;
            if (TaskName.Length == 0)
            {
                SB.Text = "YOU MUST SELECT ONE TASK SCHEDULE.";
                return;
            }

            ExecuteCommandFile(CMD);
            btnAdd_Click(null, null);
        }

        private void btnAdd_Click(object sender, EventArgs e)
        {
            string TaskName = "";
            string ArchiveType = "";
            bool bChecks = false;
            if (ckFiles.Checked)
            {
                TaskName = "ECM_ARCHIVE_FOLDERS";
                ArchiveType = "File Folders";
                string CmdLine = BuildCommandLine(TaskName, ArchiveType);
                SB.Text = CmdLine;
                ExecuteCommandFile(CmdLine);
                REG.UpdateEcmRegistrySubKey("ECM_ARCHIVE_FOLDERS", CmdLine);
                bChecks = true;
            }

            if (ckOutlook.Checked)
            {
                TaskName = "ECM_ARCHIVE_OUTLOOK";
                ArchiveType = "Outlook Folders";
                string CmdLine = BuildCommandLine(TaskName, ArchiveType);
                SB.Text = CmdLine;
                ExecuteCommandFile(CmdLine);
                REG.UpdateEcmRegistrySubKey("ECM_ARCHIVE_OUTLOOK", CmdLine);
                bChecks = true;
            }

            if (ckExchange.Checked)
            {
                TaskName = "ECM_ARCHIVE_EXCHANGE";
                ArchiveType = "Exchange Servers";
                string CmdLine = BuildCommandLine(TaskName, ArchiveType);
                SB.Text = CmdLine;
                ExecuteCommandFile(CmdLine);
                REG.UpdateEcmRegistrySubKey("ECM_ARCHIVE_EXCHANGE", CmdLine);
                bChecks = true;
            }

            if (ckAll.Checked)
            {
                TaskName = "ECM_ARCHIVE_ALL";
                ArchiveType = "All";
                string CmdLine = BuildCommandLine(TaskName, ArchiveType);
                SB.Text = CmdLine;
                ExecuteCommandFile(CmdLine);
                REG.UpdateEcmRegistrySubKey("ECM_ARCHIVE_ALL", CmdLine);
                bChecks = true;
            }

            if (bChecks == false)
            {
                string xmsg = "INFO: Good job, you have tried to add a schedule without defining what to archive." + Constants.vbCrLf;
                xmsg += "On the bottom left side of the screen you will see four check boxes. " + Constants.vbCrLf;
                xmsg += "Until you pick at least one, you will see this message - you decide. " + Constants.vbCrLf;
                LOG.WriteToArchiveLog(xmsg);
                MessageBox.Show(xmsg);
            }
        }

        private void WindowsSchedulerToolStripMenuItem_Click(object sender, EventArgs e)
        {
            string tCmd = @"%windir%\system32\taskschd.msc /s";
            ExecuteCommandFile(tCmd);
        }

        private void ApplicationExecutionPathToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Clipboard.Clear();
            Clipboard.SetText(Application.ExecutablePath);
            SB.Text = Application.ExecutablePath;
        }

        private void btnEnableArchive_Click(object sender, EventArgs e)
        {
            string msg = "This will this ENABLE this archive schedule, are you sure?";
            var dlgRes = MessageBox.Show(msg, "Cannot be undone!", MessageBoxButtons.YesNo);
            if (dlgRes == DialogResult.No)
            {
                return;
            }

            string TaskName = SelectedTaskName.Text;
            string CMD = "SCHTASKS /CHANGE /ENABLE /TN " + TaskName;
            ExecuteCommandFile(CMD);
        }

        private void btnDisableArchive_Click(object sender, EventArgs e)
        {
            string msg = "This will this DISABLE this archive schedule, are you sure?";
            var dlgRes = MessageBox.Show(msg, "Cannot be undone!", MessageBoxButtons.YesNo);
            if (dlgRes == DialogResult.No)
            {
                return;
            }

            string TaskName = SelectedTaskName.Text;
            string CMD = "SCHTASKS /CHANGE /DISABLE /TN " + TaskName;
            ExecuteCommandFile(CMD);
        }

        public string BuildCommandLine(string TASK_NAME, string ArchiveType)
        {
            string Executable = Application.ExecutablePath;
            string ScheduleCommand = "";
            string ScheduleFreq = cbScheduleUnits.Text;
            string RunParms = " X ";
            DateTime xDate = Conversions.ToDate(dtStart.Text);
            string StartTime = xDate.ToString();
            string StartDate = xDate.ToString();
            if (Strings.InStr(StartTime, " ") > 0)
            {
            }

            if (Strings.InStr(StartDate, " ") > 0)
            {
                StartDate = Strings.Mid(StartDate, 1, Strings.InStr(StartDate, " ") - 1);
            }

            // ******************************************************************

            var date_info = CultureInfo.CurrentCulture.DateTimeFormat;
            string lblFullDateTime = date_info.FullDateTimePattern;
            string lblShortDate = date_info.ShortDatePattern;
            string lblShortTime = date_info.ShortTimePattern;
            string lblInvariant = DateTimeFormatInfo.InvariantInfo.FullDateTimePattern;
            string lblExFullDateTime = DateAndTime.Now.ToString(date_info.FullDateTimePattern);
            string lblExShortDate = DateAndTime.Now.ToString(date_info.ShortDatePattern);
            string lblExShortTime = DateAndTime.Now.ToString(date_info.ShortTimePattern);
            string lblExInvariant = DateAndTime.Now.ToString(DateTimeFormatInfo.InvariantInfo.FullDateTimePattern);
            // ******************************************************************

            // StartDate = xDate.Day.ToString + "/" + xDate.Month.ToString + "/" + xDate.Year.ToString
            if (lblShortDate.ToUpper().Equals("DD-MMM-YY")) // Or lblShortDate.ToUpper.Equals("M/D/YY") 
            {
                string sDay = xDate.Day.ToString();
                string sMO = xDate.Month.ToString();
                string sYR = xDate.Year.ToString();
                if (sDay.Length == 1)
                {
                    sDay = "0" + sDay;
                }

                if (sMO.Length == 1)
                {
                    sMO = "0" + sMO;
                }

                StartDate = sDay + "/" + sMO + "/" + sYR;
            }
            else if (lblShortDate.ToUpper().Equals("MMM-DD-YY") | lblShortDate.ToUpper().Equals("M/D/YY") | lblShortDate.ToUpper().Equals("M/D/YYYY"))
            {
                string sDay = xDate.Day.ToString();
                string sMO = xDate.Month.ToString();
                string sYR = xDate.Year.ToString();
                if (sDay.Length == 1)
                {
                    sDay = "0" + sDay;
                }

                if (sMO.Length == 1)
                {
                    sMO = "0" + sMO;
                }

                StartDate = sMO + "/" + sDay + "/" + sYR;
            }

            // StartDate = xDate.Month.ToString + "/" + xDate.Day.ToString + "/" + xDate.Year.ToString
            StartTime = cbTod.Text;
            if (Strings.InStr(StartTime, ":") == 0)
            {
                StartTime = Strings.Mid(StartTime, 1, 2) + ":" + Strings.Mid(StartTime, 3, 2);
            }

            if (Conversions.ToDate(dtStart.Text) == default | Conversions.ToDate(dtStart.Text) < DateAndTime.Now)
            {
                dtStart.Text = DateAndTime.Now.ToString();
            }

            ScheduleCommand = "SCHTASKS /Create /TN " + Conversions.ToString('"') + TASK_NAME + Conversions.ToString('"') + " ";

            // ******************************************************
            if (ArchiveType.Equals("File Folders"))
            {
                RunParms += " C ";
            }

            if (ArchiveType.Equals("Outlook Folders"))
            {
                RunParms += " O ";
            }

            if (ArchiveType.Equals("Exchange Servers"))
            {
                RunParms += " E ";
            }

            if (ArchiveType.Equals("All"))
            {
                RunParms += " A ";
            }

            if (txtUser.Text.Trim().Length > 0)
            {
                RunParms += " U" + txtUser.Text.Trim() + " ";
            }
            // ******************************************************

            if (ScheduleFreq.Equals("HOURLY"))
            {
                ScheduleCommand = ScheduleCommand + " /SC HOURLY " + " /SD " + StartDate + " ";
                Clipboard.Clear();
                Clipboard.SetText(ScheduleCommand);
            }

            if (ScheduleFreq.Equals("DAILY"))
            {
                ScheduleCommand = ScheduleCommand + " /SC DAILY " + " /SD " + StartDate + " " + "/ST " + StartTime;
                Clipboard.Clear();
                Clipboard.SetText(ScheduleCommand);
            }

            if (ScheduleFreq.Equals("WEEKLY"))
            {
                ScheduleCommand = ScheduleCommand + " /SC WEEKLY " + " /D " + cbDayToRun.Text + " /SD " + StartDate + " " + "/ST " + StartTime;
                Clipboard.Clear();
                Clipboard.SetText(ScheduleCommand);
            }

            if (ScheduleFreq.Equals("MONTHLY"))
            {
                ScheduleCommand = ScheduleCommand + " /SC MONTHLY " + " /D " + cbDayToRun.Text + " /SD " + StartDate + " " + "/ST " + StartTime;
                Clipboard.Clear();
                Clipboard.SetText(ScheduleCommand);
            }

            ScheduleCommand += " /TR " + Conversions.ToString('"') + Executable + Conversions.ToString('"');
            ScheduleCommand = ScheduleCommand.Trim();
            ScheduleCommand = Strings.Mid(ScheduleCommand, 1, ScheduleCommand.Length - 1);
            ScheduleCommand = ScheduleCommand + RunParms + Conversions.ToString('"');
            Console.WriteLine(ScheduleCommand);
            return ScheduleCommand;
        }

        public void ExecuteCommandFile(string CommandLine)
        {
            string RunDir = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);
            string FQN = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + @"\CreateEcmSchedule.bat";
            string SchedDir = LOG.getTempEnvironDir() + @"\ScheduleProcessDir";
            string CmdFile = SchedDir + @"\ProcessSchedule.bat";
            // Dim ScheduleCommand As String = "schtasks /query >" + SchedDir + "\ExistingSchedules.TXT"
            string QueryFile = SchedDir + @"\ExistingSchedules.TXT";
            try
            {
                if (!Directory.Exists(SchedDir))
                {
                    Directory.CreateDirectory(SchedDir);
                }

                if (File.Exists(CmdFile))
                {
                    File.Delete(CmdFile);
                }

                try
                {
                    var sw = new StreamWriter(CmdFile, false);
                    // Write ANSI strings to the file line by line...
                    sw.WriteLine(@"CD\");
                    sw.WriteLine("CD " + Conversions.ToString('"') + RunDir + Conversions.ToString('"'));
                    sw.WriteLine(CommandLine);
                    // sw.WriteLine("PAUSE")
                    sw.Close();
                    SCHED.ShellandWait(CmdFile);
                    var argDG = dgSchedule;
                    SCHED.PopulateScheduleGrid(ref argDG);
                    dgSchedule = argDG;
                    string ID = DateAndTime.Now.Ticks.ToString();
                    File.Copy(CmdFile, LOG.getTempEnvironDir() + ".Ecm.Scheduler." + ID + ".txt");
                }
                catch (Exception ex)
                {
                    LOG.WriteToArchiveLog("ERROR: ExecuteCommandFile 200: " + ex.Message);
                    My.MyProject.Forms.frmMain.SB.Text = "Check Logs ERROR: ExecuteCommandFile 200: " + ex.Message;
                }
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: ExecuteCommandFile 100 - " + ex.Message);
            }
            finally
            {
                GC.Collect();
                GC.WaitForPendingFinalizers();
            }
        }

        private void dgSchedule_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            GetGridData();
        }

        private void dgSchedule_SelectionChanged(object sender, EventArgs e)
        {
            GetGridData();
        }

        public void GetGridData()
        {
            int I = 0;
            I = dgSchedule.SelectedRows.Count;
            SelectedTaskName.Text = "";
            if (I == 0)
            {
                return;
            }

            string CurrCmd = "";
            string ItemName = dgSchedule.SelectedRows[0].Cells[0].Value.ToString();
            ckFiles.Checked = false;
            ckOutlook.Checked = false;
            ckAll.Checked = false;
            ckExchange.Checked = false;
            if (I != 1)
            {
                My.MyProject.Forms.frmMain.SB.Text = "YOU MUST SELECT ONE AND ONLY ONE SCHEDULE ITEM.";
                SelectedTaskName.Text = "";
            }
            else
            {
                SelectedTaskName.Text = ItemName;
                if (ItemName.Equals("ECM_ARCHIVE_FOLDERS"))
                {
                    parseSubCommand(ItemName);
                }

                if (ItemName.Equals("ECM_ARCHIVE_OUTLOOK"))
                {
                    parseSubCommand(ItemName);
                }

                if (ItemName.Equals("ECM_ARCHIVE_EXCHANGE"))
                {
                    parseSubCommand(ItemName);
                }

                if (ItemName.Equals("ECM_ARCHIVE_ALL"))
                {
                    parseSubCommand(ItemName);
                }

                if (ItemName.Equals("ECM_ARCHIVE_FOLDERS") | ItemName.Equals("ECM_ARCHIVE_FOLDER"))
                {
                    SB.Text = "";
                    ckFiles.Checked = true;
                    ckOutlook.Checked = false;
                    ckAll.Checked = false;
                    ckExchange.Checked = false;
                    CurrCmd = REG.ReadEcmSubKey("ECM_ARCHIVE_FOLDERS");
                    SB.Text = CurrCmd;
                }
                else if (ItemName.Equals("ECM_ARCHIVE_OUTLOOK"))
                {
                    SB.Text = "";
                    ckOutlook.Checked = true;
                    ckFiles.Checked = false;
                    ckAll.Checked = false;
                    ckExchange.Checked = false;
                    CurrCmd = REG.ReadEcmSubKey("ECM_ARCHIVE_OUTLOOK");
                    SB.Text = CurrCmd;
                }
                else if (ItemName.Equals("ECM_ARCHIVE_EXCHANGE"))
                {
                    SB.Text = "";
                    ckExchange.Checked = true;
                    ckFiles.Checked = false;
                    ckOutlook.Checked = false;
                    ckAll.Checked = false;
                    CurrCmd = REG.ReadEcmSubKey("ECM_ARCHIVE_EXCHANGE");
                    SB.Text = CurrCmd;
                }
                else if (ItemName.Equals("ECM_ARCHIVE_ALL"))
                {
                    SB.Text = "";
                    ckAll.Checked = true;
                    ckFiles.Checked = false;
                    ckOutlook.Checked = false;
                    ckExchange.Checked = false;
                    CurrCmd = REG.ReadEcmSubKey("ECM_ARCHIVE_ALL");
                    SB.Text = CurrCmd;
                }
                else
                {
                    SB.Text = "ECM ONLY OPERATES ON ECM SCHEDULER ITEMS.";
                    SelectedTaskName.Text = "";
                }
            }
        }

        private void btnValidate_Click(object sender, EventArgs e)
        {
            ValidateExecPath();
        }

        public void parseSubCommand(string RegKey)
        {
            string[] SubCommands;
            string CMX = "";
            string xCmd = "";
            string CurrArchCmd = REG.ReadEcmRegistrySubKey(RegKey);
            if (CurrArchCmd.Trim().Length > 0)
            {
                SubCommands = CurrArchCmd.Split('/');
                if (Information.UBound(SubCommands) > 0)
                {
                    for (int i = 0, loopTo = Information.UBound(SubCommands); i <= loopTo; i++)
                    {
                        CMX = SubCommands[i];
                        // Console.WriteLine(i.ToString + " : " + CMX)
                        if (CMX.Trim().Length > 2)
                        {
                            int Z = 0;
                            Z = Strings.InStr(CMX, " ");
                            if (Z == 2)
                            {
                                xCmd = Strings.Mid(CMX, 1, 1).ToUpper().Trim();
                            }
                            else
                            {
                                xCmd = Strings.Mid(CMX, 1, 3).ToUpper().Trim();
                            }
                        }
                        else
                        {
                            xCmd = "";
                        }

                        if (xCmd.Equals("TN"))
                        {
                            SB.Text = Strings.Mid(CMX, 4).Trim();
                        }

                        if (xCmd.Equals("SC"))
                        {
                            cbScheduleUnits.Text = Strings.Mid(CMX, 4).Trim();
                        }

                        if (xCmd.Equals("ST"))
                        {
                            cbTod.Text = Strings.Mid(CMX, 4).Trim();
                        }

                        if (xCmd.Equals("SD"))
                        {
                            string xDate = "";
                            xDate = Strings.Mid(CMX, 3).Trim();
                            xDate = xDate + "/" + SubCommands[i + 1] + "/" + SubCommands[i + 2];
                            dtStart.Value = Conversions.ToDate(xDate);
                        }

                        if (xCmd.Equals("D"))
                        {
                            cbDayToRun.Text = Strings.Mid(CMX, 2).Trim();
                        }

                        if (xCmd.Equals("TR"))
                        {
                            for (int X = CMX.Length; X >= 1; X -= 1)
                            {
                                string CH = "";
                                CH = Strings.Mid(CMX, X, 1);
                                if (CH.Equals("."))
                                {
                                    string[] A1;
                                    string tCmd = Strings.Mid(CMX, X);
                                    A1 = tCmd.Split(' ');
                                    for (int Y = 0, loopTo1 = Information.UBound(A1) - 1; Y <= loopTo1; Y++)
                                    {
                                        string CH2 = A1[Y];
                                        if (CH2.Length > 1)
                                        {
                                            if (Strings.Mid(CH2, 1, 1).ToUpper().Equals("U"))
                                            {
                                                txtUser.Text = Strings.Mid(CH2, 2);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        public void ValidateApplicationDirectory(object RegKey)
        {
            string CurrApplicationPath = Application.ExecutablePath;
            string PrevApplicationPath = REG.ReadEcmRegistrySubKey("EcmArchiverDir");
            string[] SubCommands = null;
            string TaskName = "";
            string CMX = "";
            string xCmd = "";
            bool RebuildCommand = false;
            if ((PrevApplicationPath ?? "") == (CurrApplicationPath ?? ""))
            {
                SB.Text = "Scheduled tasks point to correct directory.";
                return;
            }

            string CurrArchCmd = REG.ReadEcmRegistrySubKey(Conversions.ToString(RegKey));
            if (CurrArchCmd.Trim().Length > 0)
            {
                SubCommands = CurrArchCmd.Split('/');
                if (Information.UBound(SubCommands) > 0)
                {
                    for (int i = 0, loopTo = Information.UBound(SubCommands); i <= loopTo; i++)
                    {
                        CMX = SubCommands[i];
                        Console.WriteLine(i.ToString() + " : " + CMX);
                        if (CMX.Trim().Length > 2)
                        {
                            int Z = 0;
                            Z = Strings.InStr(CMX, " ");
                            if (Z == 2)
                            {
                                xCmd = Strings.Mid(CMX, 1, 1).ToUpper().Trim();
                            }
                            else
                            {
                                xCmd = Strings.Mid(CMX, 1, 3).ToUpper().Trim();
                            }
                        }
                        else
                        {
                            xCmd = "";
                        }

                        if (xCmd.Equals("TN"))
                        {
                            TaskName = Strings.Mid(CMX, 4);
                        }

                        if (xCmd.Equals("TR"))
                        {
                            string S1 = "";
                            string S2 = "";
                            int iBlank = Strings.InStr(CMX, Conversions.ToString('"')) + 1;
                            int iExe = Strings.InStr(CMX, ".exe") + 4;
                            S1 = Strings.Mid(CMX, 1, iBlank - 1);
                            S2 = Strings.Mid(CMX, iExe);
                            string S = S1 + CurrApplicationPath + S2;
                            Console.WriteLine(S);
                            SubCommands[i] = S;
                            RebuildCommand = true;
                        }
                    }
                }
            }

            if (RebuildCommand == true)
            {
                string NewCmd = "";
                for (int I = 0, loopTo1 = Information.UBound(SubCommands); I <= loopTo1; I++)
                {
                    if (I == 0)
                    {
                        NewCmd = SubCommands[I];
                    }
                    else
                    {
                        NewCmd += "/" + SubCommands[I];
                    }
                }

                Console.WriteLine(NewCmd);
                if (TaskName.Length > 0)
                {
                    string CMD = "SCHTASKS /Delete /F /TN " + TaskName;
                    ExecuteCommandFile(CMD);
                    ExecuteCommandFile(NewCmd);
                }
            }
        }

        public void ValidateExecPath()
        {
            var argDG = dgSchedule;
            SCHED.PopulateScheduleGrid(ref argDG);
            dgSchedule = argDG;
            string CurrAppPath = Application.ExecutablePath;
            string ScheduleName = "";
            foreach (DataGridViewRow DRV in dgSchedule.Rows)
            {
                try
                {
                    ScheduleName = DRV.Cells[0].Value.ToString();
                }
                catch (Exception ex)
                {
                    ScheduleName = "";
                }

                if (ScheduleName.Equals("ECM_ARCHIVE_FOLDERS"))
                {
                    ValidateApplicationDirectory(ScheduleName);
                }

                if (ScheduleName.Equals("ECM_ARCHIVE_OUTLOOK"))
                {
                    ValidateApplicationDirectory(ScheduleName);
                }

                if (ScheduleName.Equals("ECM_ARCHIVE_EXCHANGE"))
                {
                    ValidateApplicationDirectory(ScheduleName);
                }

                if (ScheduleName.Equals("ECM_ARCHIVE_ALL"))
                {
                    ValidateApplicationDirectory(ScheduleName);
                }
            }
        }

        public void hideGridColData()
        {
            // TgtColName = SenderEmailAddress
            string GridVal = "";
            bool iFound = false;
            int iRow = 0;

            // **Wdmxx
            foreach (DataGridViewRow DR in dgSchedule.Rows)
            {
                try
                {
                    if (DR.Visible == true)
                    {
                        GridVal = DR.Cells[0].Value.ToString();
                        GridVal = GridVal.Trim();
                        bool B = false;
                        if (Strings.InStr(GridVal, "ECM_", CompareMethod.Text) > 0)
                        {
                            B = true;
                        }

                        if (B == false)
                        {
                            DR.Selected = false;
                            DR.Visible = false;
                        }
                        else
                        {
                            try
                            {
                                DR.Selected = false;
                                DR.Visible = true;
                            }
                            catch (Exception ex)
                            {
                                Console.WriteLine("Could not hide row.");
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }
            }
        }

        public void showGridColData()
        {
            // TgtColName = SenderEmailAddress
            string GridVal = "";
            bool iFound = false;
            int iRow = 0;
            foreach (DataGridViewRow DR in dgSchedule.Rows)
            {
                try
                {
                    if (DR.Visible == false)
                    {
                        try
                        {
                            DR.Visible = true;
                        }
                        catch (Exception ex)
                        {
                            Console.WriteLine("Could not hide row.");
                        }
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }
            }
        }

        private void ckShowAll_CheckedChanged(object sender, EventArgs e)
        {
            if (ckShowAll.Checked == true)
            {
                showGridColData();
            }
            else
            {
                hideGridColData();
            }
        }

        private void CommandExecutionDirectoryToolStripMenuItem_Click(object sender, EventArgs e)
        {
            string SchedDir = LOG.getTempEnvironDir() + @"\ScheduleProcessDir";
            Clipboard.Clear();
            Clipboard.SetText(SchedDir);
            MessageBox.Show("Command file path in clipboard.");
        }
    }
}