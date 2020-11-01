Imports System.IO
Imports System.Globalization

Public Class frmSchedule

    Dim LOG As New clsLogging
    Dim UTIL As New clsUtility
    Dim SCHED As New clsScheduler
    Dim REG As New clsRegistry

    Private Sub btnDisplaySchedules_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnDisplaySchedules.Click
        SCHED.PopulateScheduleGrid(dgSchedule)
        ckShowAll_CheckedChanged(Nothing, Nothing)
    End Sub
   
   

    Sub AddSchedule()

        'SCHTASKS /Create [/S system [/U username [/P [password]]]]
        '    [/RU username [/RP password]] /SC schedule [/MO modifier] [/D day]
        '    [/M months] [/I idletime] /TN taskname /TR taskrun [/ST starttime]
        '    [/RI interval] [ {/ET endtime | /DU duration} [/K] [/XML xmlfile] [/V1]]
        '    [/SD startdate] [/ED enddate] [/IT | /NP] [/Z] [/F]
        '
        'Description:
        '    Enables an administrator to create scheduled tasks on a local or
        '    remote system.
        '
        'Parameter List:
        '    /S   system        Specifies the remote system to connect to. If omitted
        '                       the system parameter defaults to the local system.
        '
        '    /U   username      Specifies the user context under which SchTasks.exe 
        '                       should execute.
        '
        '    /P   [password]    Specifies the password for the given user context.
        '                       Prompts for input if omitted.
        '
        '    /RU  username      Specifies the "run as" user account (user context)
        '                       under which the task runs. For the system account,
        '                       valid values are "", "NT AUTHORITY\SYSTEM"
        '                       or "SYSTEM".
        '                       For v2 tasks, "NT AUTHORITY\LOCALSERVICE" and 
        '                       "NT AUTHORITY\NETWORKSERVICE" are also available as well 
        '                       as the well known SIDs for all three. 
        '
        '    /RP  [password]    Specifies the password for the "run as" user. 
        '                       To prompt for the password, the value must be either
        '                       "*" or none. This password is ignored for the 
        '                       system account. Must be combined with either /RU or
        '                       /XML switch.
        '
        '    /SC   schedule     Specifies the schedule frequency.
        '                       Valid schedule types: MINUTE, HOURLY, DAILY, WEEKLY, 
        '                       MONTHLY, ONCE, ONSTART, ONLOGON, ONIDLE, ONEVENT.
        '
        '    /MO   modifier     Refines the schedule type to allow finer control over
        '                       schedule recurrence. Valid values are listed in the 
        '                       "Modifiers" section below.
        '
        '    /D    days         Specifies the day of the week to run the task. Valid 
        '                       values: MON, TUE, WED, THU, FRI, SAT, SUN and for
        '                       MONTHLY schedules 1 - 31 (days of the month). 
        '                       Wildcard "*" specifies all days.
        '
        '    /M    months       Specifies month(s) of the year. Defaults to the first 
        '                       day of the month. Valid values: JAN, FEB, MAR, APR, 
        '                       MAY, JUN, JUL, AUG, SEP, OCT, NOV, DEC. Wildcard "*" 
        '                       specifies all months.
        '
        '    /I    idletime     Specifies the amount of idle time to wait before 
        '                       running a scheduled ONIDLE task.
        '                       Valid range: 1 - 999 minutes.
        '
        '    /TN   taskname     Specifies a name which uniquely
        '                       identifies this scheduled task.
        '
        '    /TR   taskrun      Specifies the path and file name of the program to be 
        '                       run at the scheduled time.
        '                       Example: C:\windows\system32\calc.exe
        '
        '    /ST   starttime    Specifies the start time to run the task. The time 
        '                       format is HH:mm (24 hour time) for example, 14:30 for 
        '                       2:30 PM. Defaults to current time if /ST is not 
        '                       specified.  This option is required with /SC ONCE.
        '
        '    /RI   interval     Specifies the repetition interval in minutes. This is 
        '                       not applicable for schedule types: MINUTE, HOURLY,
        '                       ONSTART, ONLOGON, ONIDLE, ONEVENT.
        '                       Valid range: 1 - 599940 minutes.
        '                       If either /ET or /DU is specified, then it defaults to 
        '                       10 minutes.
        '
        '    /ET   endtime      Specifies the end time to run the task. The time format
        '                       is HH:mm (24 hour time) for example, 14:50 for 2:50 PM.
        '                       This is not applicable for schedule types: ONSTART, 
        '                       ONLOGON, ONIDLE, ONEVENT.
        '
        '    /DU   duration     Specifies the duration to run the task. The time 
        '                       format is HH:mm. This is not applicable with /ET and
        '                       for schedule types: ONSTART, ONLOGON, ONIDLE, ONEVENT.
        '                       For /V1 tasks, if /RI is specified, duration defaults 
        '                       to 1 hour.
        '
        '    /K                 Terminates the task at the endtime or duration time. 
        '                       This is not applicable for schedule types: ONSTART, 
        '                       ONLOGON, ONIDLE, ONEVENT. Either /ET or /DU must be
        '                       specified.
        '
        '    /SD   startdate    Specifies the first date on which the task runs. The 
        '                       format is dd/mm/yyyy. Defaults to the current 
        '                       date. This is not applicable for schedule types: ONCE, 
        '                       ONSTART, ONLOGON, ONIDLE, ONEVENT.
        '
        '    /ED   enddate      Specifies the last date when the task should run. The 
        '                       format is dd/mm/yyyy. This is not applicable for 
        '                       schedule types: ONCE, ONSTART, ONLOGON, ONIDLE, ONEVENT.
        '
        '    /EC   ChannelName  Specifies the event channel for OnEvent triggers.
        '
        '    /IT                Enables the task to run interactively only if the /RU 
        '                       user is currently logged on at the time the job runs.
        '                       This task runs only if the user is logged in.
        '
        '    /NP                No password is stored.  The task runs non-interactively
        '                       as the given user.  Only local resources are available.
        '
        '    /Z                 Marks the task for deletion after its final run.
        '
        '    /XML  xmlfile      Creates a task from the task XML specified in a file.
        '                       Can be combined with /RU and /RP switches, or with /RP 
        '                       alone, when task XML already contains the principal.
        '
        '    /V1                Creates a task visible to pre-Vista platforms.
        '                       Not compatible with /XML.
        '
        '    /F                 Forcefully creates the task and suppresses warnings if 
        '                       the specified task already exists.
        '
        '    /RL   level        Sets the Run Level for the job. Valid values are 
        '                       LIMITED and HIGHEST. The default is LIMITED.
        '
        '    /DELAY delaytime   Specifies the wait time to delay the running of the 
        '                       task after the trigger is fired.  The time format is
        '                       mmmm:ss.  This option is only valid for schedule types
        '                       ONSTART, ONLOGON, ONEVENT.
        '
        '    /?                 Displays this help message.
        '
        'Modifiers: Valid values for the /MO switch per schedule type:
        '    MINUTE:  1 - 1439 minutes.
        '    HOURLY:  1 - 23 hours.
        '    DAILY:   1 - 365 days.
        '    WEEKLY:  weeks 1 - 52.
        '    ONCE:    No modifiers.
        '    ONSTART: No modifiers.
        '    ONLOGON: No modifiers.
        '    ONIDLE:  No modifiers.
        '    MONTHLY: 1 - 12, or 
        '             FIRST, SECOND, THIRD, FOURTH, LAST, LASTDAY.
        '
        '    ONEVENT:  XPath event query string.
        'Examples:
        '    ==> Creates a scheduled task "doc" on the remote machine "ABC"
        '        which runs notepad.exe every hour under user "runasuser". 
        '
        '        SCHTASKS /Create /S ABC /U user /P password /RU runasuser
        '                 /RP runaspassword /SC HOURLY /TN doc /TR notepad 
        '
        '    ==> Creates a scheduled task "accountant" on the remote machine 
        '        "ABC" to run calc.exe every five minutes from the specified
        '        start time to end time between the start date and end date.
        '
        '        SCHTASKS /Create /S ABC /U domain\user /P password /SC MINUTE
        '                 /MO 5 /TN accountant /TR calc.exe /ST 12:00 /ET 14:00
        '                 /SD 06/06/2006 /ED 06/06/2006 /RU runasuser /RP userpassword
        '
        '    ==> Creates a scheduled task "gametime" to run freecell on the 
        '        first Sunday of every month.
        '
        '        SCHTASKS /Create /SC MONTHLY /MO first /D SUN /TN gametime 
        '                 /TR c:\windows\system32\freecell
        '
        '    ==> Creates a scheduled task "report" on remote machine "ABC"
        '        to run notepad.exe every week.
        '
        '        SCHTASKS /Create /S ABC /U user /P password /RU runasuser
        '                 /RP runaspassword /SC WEEKLY /TN report /TR notepad.exe
        '
        '    ==> Creates a scheduled task "logtracker" on remote machine "ABC"
        '        to run notepad.exe every five minutes starting from the
        '        specified start time with no end time. The /RP password will be
        '        prompted for.
        '
        '        SCHTASKS /Create /S ABC /U domain\user /P password /SC MINUTE
        '                 /MO 5 /TN logtracker 
        '                 /TR c:\windows\system32\notepad.exe /ST 18:30
        '                 /RU runasuser /RP

        'SCHTASKS /U domain\user /P password /SC MINUTE /MO 5 /TN ECM_ARCHIVEALL /TR c:\windows\system32\notepad.exe /ST 18:30 
        '
        '    ==> Creates a scheduled task "gaming" to run freecell.exe starting
        '        at 12:00 and automatically terminating at 14:00 hours every day
        '
        '        SCHTASKS /Create /SC DAILY /TN gaming /TR c:\freecell /ST 12:00
        '                 /ET 14:00 /K
        '    ==> Creates a scheduled task "EventLog" to run wevtvwr.msc starting
        '        whenever event 101 is published in the System channel
        '
        '        SCHTASKS /Create /TN EventLog /TR wevtvwr.msc /SC ONEVENT
        '                 /EC System /MO *[System/EventID=101] 
        '    ==> Spaces in file paths can be used by using two sets of quotes, one
        '        set for CMD.EXE and one for SchTasks.exe.  The outer quotes for CMD
        '        need to be double quotes; the inner quotes can be single quotes or
        '        escaped double quotes:
        '        SCHTASKS /Create 
        '           /tr "'c:\program files\internet explorer\iexplorer.exe' 
        '           \"c:\log data\today.xml\"" ...


        '***************************************************************************************
        'SCHTASKS /Create /TN ECM_TEST /SC DAILY /TR "dir c:\temp\*.* >DIR.List.TXT"
        '***************************************************************************************

        Dim TaskCmd As String = ""
        TaskCmd = "SCHTASKS /U <UserID> /P <password> /SC MINUTE /MO 5 /TN ECM_ARCHIVEALL /TR c:\windows\system32\notepad.exe /ST 18:30"

    End Sub

    Private Sub cbScheduleUnits_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cbScheduleUnits.SelectedIndexChanged
        'HOURLY
        'DAILY
        'WEEKLY, 
        'MONTHLY

        cbTod.Items.Clear()
        cbTod.Text = ""
        Dim rTime As String = ""
        For i As Integer = 0 To 23
            For k As Integer = 1 To 4
                If i < 10 Then
                    rTime = "0" + i.ToString
                Else
                    rTime = i.ToString
                End If
                If k = 1 Then
                    rTime += ":00"
                ElseIf k = 2 Then
                    rTime += ":15"
                ElseIf k = 3 Then
                    rTime += ":30"
                ElseIf k = 4 Then
                    rTime += ":45"
                End If
                cbTod.Items.Add(rTime)
            Next
        Next

        If cbScheduleUnits.Text.Equals("HOURLY") Then
            Label3.Visible = False
            cbDayToRun.Visible = False
            Label2.Visible = False
            dtStart.Text = Now.ToString
            dtStart.Visible = False
            Label4.Visible = False
            cbTod.Visible = False

        ElseIf cbScheduleUnits.Text.Equals("DAILY") Then

            Label3.Visible = True
            cbDayToRun.Visible = True
            Label2.Visible = True
            dtStart.Visible = True
            Label3.Visible = False
            cbDayToRun.Visible = False
            Label4.Visible = True
            cbTod.Visible = True

            Label3.Text = "Pick the Time To run:"
            cbDayToRun.Items.Clear()
            cbDayToRun.Text = ""
            rTime = ""
            For i As Integer = 0 To 23
                For k As Integer = 1 To 4
                    If i < 10 Then
                        rTime = "0" + i.ToString
                    Else
                        rTime = i.ToString
                    End If
                    If k = 1 Then
                        rTime += ":00"
                    ElseIf k = 2 Then
                        rTime += ":15"
                    ElseIf k = 3 Then
                        rTime += ":30"
                    ElseIf k = 4 Then
                        rTime += ":45"
                    End If
                    cbDayToRun.Items.Add(rTime)
                Next
            Next
        ElseIf cbScheduleUnits.Text.Equals("WEEKLY") Then
            Label3.Visible = True
            cbDayToRun.Visible = True
            Label2.Visible = True
            dtStart.Visible = True
            Label4.Visible = True
            cbTod.Visible = True

            Label3.Text = "Pick the Day To run:"
            cbDayToRun.Items.Clear()
            cbDayToRun.Text = ""
            cbDayToRun.Items.Add("SUN")
            cbDayToRun.Items.Add("MON")
            cbDayToRun.Items.Add("TUE")
            cbDayToRun.Items.Add("WED")
            cbDayToRun.Items.Add("THU")
            cbDayToRun.Items.Add("FRI")
            cbDayToRun.Items.Add("SAT")
        ElseIf cbScheduleUnits.Text.Equals("MONTHLY") Then
            Label3.Visible = True
            cbDayToRun.Visible = True
            Label2.Visible = True
            dtStart.Visible = True
            Label4.Visible = True
            cbTod.Visible = True
            Label3.Text = "Pick the Day To run:"
            cbDayToRun.Items.Clear()
            cbDayToRun.Text = ""
            For i As Integer = 0 To 31
                cbDayToRun.Items.Add(i.ToString)
            Next
        End If
    End Sub


    Private Sub btnDelete_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnDelete.Click

Dim msg AS String  = "This will DELETE the selected archive schedule, are you sure?" 
        Dim dlgRes As DialogResult = MessageBox.Show(msg, "Cannot be undone!", MessageBoxButtons.YesNo)
        If dlgRes = Windows.Forms.DialogResult.No Then
            Return
        End If

        Dim TaskName As String = SelectedTaskName.Text
        Dim CMD As String = "SCHTASKS /Delete /F /TN " + TaskName

        ExecuteCommandFile(CMD)

        REG.UpdateEcmRegistrySubKey(TaskName, "")

    End Sub

    Private Sub btnUpdate_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnUpdate.Click

        Dim TaskName As String = SelectedTaskName.Text
        Dim CMD As String = "SCHTASKS /Delete /F /TN " + TaskName

        If TaskName.Length = 0 Then
            SB.Text = "YOU MUST SELECT ONE TASK SCHEDULE."
            Return
        End If

        ExecuteCommandFile(CMD)

        btnAdd_Click(Nothing, Nothing)

    End Sub

    Private Sub btnAdd_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnAdd.Click

        Dim TaskName As String = ""
        Dim ArchiveType As String = ""
        Dim bChecks As Boolean = False
        If ckFiles.Checked Then
            TaskName = "ECM_ARCHIVE_FOLDERS"
            ArchiveType = "File Folders"
            Dim CmdLine As String = BuildCommandLine(TaskName, ArchiveType)
            SB.Text = CmdLine
            ExecuteCommandFile(CmdLine)
            REG.UpdateEcmRegistrySubKey("ECM_ARCHIVE_FOLDERS", CmdLine)
            bChecks = True
        End If
        If ckOutlook.Checked Then
            TaskName = "ECM_ARCHIVE_OUTLOOK"
            ArchiveType = "Outlook Folders"
            Dim CmdLine As String = BuildCommandLine(TaskName, ArchiveType)
            SB.Text = CmdLine
            ExecuteCommandFile(CmdLine)
            REG.UpdateEcmRegistrySubKey("ECM_ARCHIVE_OUTLOOK", CmdLine)
            bChecks = True
        End If
        If ckExchange.Checked Then
            TaskName = "ECM_ARCHIVE_EXCHANGE"
            ArchiveType = "Exchange Servers"
            Dim CmdLine As String = BuildCommandLine(TaskName, ArchiveType)
            SB.Text = CmdLine
            ExecuteCommandFile(CmdLine)
            REG.UpdateEcmRegistrySubKey("ECM_ARCHIVE_EXCHANGE", CmdLine)
            bChecks = True
        End If
        If ckAll.Checked Then
            TaskName = "ECM_ARCHIVE_ALL"
            ArchiveType = "All"
            Dim CmdLine As String = BuildCommandLine(TaskName, ArchiveType)
            SB.Text = CmdLine
            ExecuteCommandFile(CmdLine)
            REG.UpdateEcmRegistrySubKey("ECM_ARCHIVE_ALL", CmdLine)
            bChecks = True
        End If

        If bChecks = False Then
            Dim xmsg As String = "INFO: Good job, you have tried to add a schedule without defining what to archive." + vbCrLf
            xmsg += "On the bottom left side of the screen you will see four check boxes. " + vbCrLf
            xmsg += "Until you pick at least one, you will see this message - you decide. " + vbCrLf
            log.WriteToArchiveLog(xmsg)
            messagebox.show(xmsg)
        End If
    End Sub

    Private Sub WindowsSchedulerToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles WindowsSchedulerToolStripMenuItem.Click
        Dim tCmd As String = "%windir%\system32\taskschd.msc /s"
        ExecuteCommandFile(tCmd)
    End Sub

    Private Sub ApplicationExecutionPathToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ApplicationExecutionPathToolStripMenuItem.Click
        Clipboard.Clear()
        Clipboard.SetText(Application.ExecutablePath)
        SB.Text = Application.ExecutablePath
    End Sub

    Private Sub btnEnableArchive_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnEnableArchive.Click

Dim msg AS String  = "This will this ENABLE this archive schedule, are you sure?" 
        Dim dlgRes As DialogResult = MessageBox.Show(msg, "Cannot be undone!", MessageBoxButtons.YesNo)
        If dlgRes = Windows.Forms.DialogResult.No Then
            Return
        End If

        Dim TaskName As String = SelectedTaskName.Text
        Dim CMD As String = "SCHTASKS /CHANGE /ENABLE /TN " + TaskName

        ExecuteCommandFile(CMD)

    End Sub

    Private Sub btnDisableArchive_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnDisableArchive.Click
Dim msg AS String  = "This will this DISABLE this archive schedule, are you sure?" 
        Dim dlgRes As DialogResult = MessageBox.Show(msg, "Cannot be undone!", MessageBoxButtons.YesNo)
        If dlgRes = Windows.Forms.DialogResult.No Then
            Return
        End If

        Dim TaskName As String = SelectedTaskName.Text
        Dim CMD As String = "SCHTASKS /CHANGE /DISABLE /TN " + TaskName
        ExecuteCommandFile(CMD)
    End Sub

    Function BuildCommandLine(ByVal TASK_NAME As String, ByVal ArchiveType As String) As String
        Dim Executable As String = Application.ExecutablePath

        Dim ScheduleCommand As String = ""
        Dim ScheduleFreq As String = cbScheduleUnits.Text
        Dim RunParms As String = " X "
        Dim xDate As Date = CDate(dtStart.Text)
        Dim StartTime As String = xDate.ToString
        Dim StartDate As String = xDate.ToString

        If InStr(StartTime, " ") > 0 Then

        End If
        If InStr(StartDate, " ") > 0 Then
            StartDate = Mid(StartDate, 1, InStr(StartDate, " ") - 1)
        End If

        '******************************************************************

        Dim date_info As DateTimeFormatInfo = CultureInfo.CurrentCulture.DateTimeFormat()
        Dim lblFullDateTime As String = date_info.FullDateTimePattern
        Dim lblShortDate As String = date_info.ShortDatePattern
        Dim lblShortTime As String = date_info.ShortTimePattern
        Dim lblInvariant As String = date_info.InvariantInfo.FullDateTimePattern
        Dim lblExFullDateTime As String = Now.ToString(date_info.FullDateTimePattern)
        Dim lblExShortDate As String = Now.ToString(date_info.ShortDatePattern)
        Dim lblExShortTime As String = Now.ToString(date_info.ShortTimePattern)
        Dim lblExInvariant As String = Now.ToString(date_info.InvariantInfo().FullDateTimePattern)
        '******************************************************************

        'StartDate = xDate.Day.ToString + "/" + xDate.Month.ToString + "/" + xDate.Year.ToString
        If lblShortDate.ToUpper.Equals("DD-MMM-YY") Then 'Or lblShortDate.ToUpper.Equals("M/D/YY") 
            Dim sDay As String = xDate.Day.ToString
            Dim sMO As String = xDate.Month.ToString
            Dim sYR As String = xDate.Year.ToString
            If sDay.Length = 1 Then
                sDay = "0" + sDay
            End If
            If sMO.Length = 1 Then
                sMO = "0" + sMO
            End If
            StartDate = sDay + "/" + sMO + "/" + sYR
        ElseIf lblShortDate.ToUpper.Equals("MMM-DD-YY") Or lblShortDate.ToUpper.Equals("M/D/YY") Or lblShortDate.ToUpper.Equals("M/D/YYYY") Then
            Dim sDay As String = xDate.Day.ToString
            Dim sMO As String = xDate.Month.ToString
            Dim sYR As String = xDate.Year.ToString
            If sDay.Length = 1 Then
                sDay = "0" + sDay
            End If
            If sMO.Length = 1 Then
                sMO = "0" + sMO
            End If
            StartDate = sMO + "/" + sDay + "/" + sYR
        End If

        'StartDate = xDate.Month.ToString + "/" + xDate.Day.ToString + "/" + xDate.Year.ToString
        StartTime = cbTod.Text
        If InStr(StartTime, ":") = 0 Then
            StartTime = Mid(StartTime, 1, 2) + ":" + Mid(StartTime, 3, 2)
        End If

        If CDate(dtStart.Text) = Nothing Or CDate(dtStart.Text) < Now Then
            dtStart.Text = Now.ToString
        End If

        ScheduleCommand = "SCHTASKS /Create /TN " + Chr(34) + TASK_NAME + Chr(34) + " "

        '******************************************************
        If ArchiveType.Equals("File Folders") Then
            RunParms += " C "
        End If
        If ArchiveType.Equals("Outlook Folders") Then
            RunParms += " O "
        End If
        If ArchiveType.Equals("Exchange Servers") Then
            RunParms += " E "
        End If
        If ArchiveType.Equals("All") Then
            RunParms += " A "
        End If
        If txtUser.Text.Trim.Length > 0 Then
            RunParms += " U" + txtUser.Text.Trim + " "
        End If
        '******************************************************

        If ScheduleFreq.Equals("HOURLY") Then
            ScheduleCommand = ScheduleCommand + " /SC HOURLY " + " /SD " + StartDate + " "
            Clipboard.Clear()
            Clipboard.SetText(ScheduleCommand)
        End If
        If ScheduleFreq.Equals("DAILY") Then
            ScheduleCommand = ScheduleCommand + " /SC DAILY " + " /SD " + StartDate + " " + "/ST " + StartTime
            Clipboard.Clear()
            Clipboard.SetText(ScheduleCommand)
        End If
        If ScheduleFreq.Equals("WEEKLY") Then
            ScheduleCommand = ScheduleCommand + " /SC WEEKLY " + " /D " + cbDayToRun.Text + " /SD " + StartDate + " " + "/ST " + StartTime
            Clipboard.Clear()
            Clipboard.SetText(ScheduleCommand)
        End If
        If ScheduleFreq.Equals("MONTHLY") Then
            ScheduleCommand = ScheduleCommand + " /SC MONTHLY " + " /D " + cbDayToRun.Text + " /SD " + StartDate + " " + "/ST " + StartTime
            Clipboard.Clear()
            Clipboard.SetText(ScheduleCommand)
        End If

        ScheduleCommand += " /TR " + Chr(34) + Executable + Chr(34)
        ScheduleCommand = ScheduleCommand.Trim
        ScheduleCommand = Mid(ScheduleCommand, 1, ScheduleCommand.Length - 1)
        ScheduleCommand = ScheduleCommand + RunParms + Chr(34)
        Console.WriteLine(ScheduleCommand)
        Return ScheduleCommand

    End Function

    Sub ExecuteCommandFile(ByVal CommandLine As String)

        Dim RunDir As String = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData)
        Dim FQN As String = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + "\CreateEcmSchedule.bat"
        Dim SchedDir As String = LOG.getTempEnvironDir + "\ScheduleProcessDir"
        Dim CmdFile As String = SchedDir + "\ProcessSchedule.bat"
        'Dim ScheduleCommand As String = "schtasks /query >" + SchedDir + "\ExistingSchedules.TXT"
        Dim QueryFile As String = SchedDir + "\ExistingSchedules.TXT"
        Try

            If Not Directory.Exists(SchedDir) Then
                Directory.CreateDirectory(SchedDir)
            End If

            If File.Exists(CmdFile) Then
                File.Delete(CmdFile)
            End If

            Try
                Dim sw As New StreamWriter(CmdFile, False)
                ' Write ANSI strings to the file line by line...
                sw.WriteLine("CD\")
                sw.WriteLine("CD " + Chr(34) + RunDir + Chr(34))
                sw.WriteLine(CommandLine)
                'sw.WriteLine("PAUSE")
                sw.Close()

                SCHED.ShellandWait(CmdFile)

                SCHED.PopulateScheduleGrid(dgSchedule)

                Dim ID As String = Now.Ticks.ToString

                File.Copy(CmdFile, LOG.getTempEnvironDir + ".Ecm.Scheduler." + ID + ".txt")

            Catch ex As Exception
                log.WriteToArchiveLog("ERROR: ExecuteCommandFile 200: " + ex.Message)
                frmMain.SB.Text = "Check Logs ERROR: ExecuteCommandFile 200: " + ex.Message
            End Try

        Catch ex As Exception
            log.WriteToArchiveLog("ERROR: ExecuteCommandFile 100 - " + ex.Message)
        Finally
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try
    End Sub

    Private Sub dgSchedule_CellContentClick(ByVal sender As System.Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles dgSchedule.CellContentClick
        GetGridData()
    End Sub

    Private Sub dgSchedule_SelectionChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles dgSchedule.SelectionChanged
        GetGridData()
    End Sub
    Sub GetGridData()
        Dim I As Integer = 0
        I = dgSchedule.SelectedRows.Count
        SelectedTaskName.Text = ""
        If I = 0 Then
            Return
        End If
        Dim CurrCmd As String = ""
        Dim ItemName As String = dgSchedule.SelectedRows(0).Cells(0).Value.ToString
        ckFiles.Checked = False
        ckOutlook.Checked = False
        ckAll.Checked = False
        ckExchange.Checked = False
        If I <> 1 Then
            frmMain.SB.Text = "YOU MUST SELECT ONE AND ONLY ONE SCHEDULE ITEM."
            SelectedTaskName.Text = ""
        Else
            SelectedTaskName.Text = ItemName

            If ItemName.Equals("ECM_ARCHIVE_FOLDERS") Then
                parseSubCommand(ItemName)
            End If
            If ItemName.Equals("ECM_ARCHIVE_OUTLOOK") Then
                parseSubCommand(ItemName)
            End If
            If ItemName.Equals("ECM_ARCHIVE_EXCHANGE") Then
                parseSubCommand(ItemName)
            End If
            If ItemName.Equals("ECM_ARCHIVE_ALL") Then
                parseSubCommand(ItemName)
            End If

            If ItemName.Equals("ECM_ARCHIVE_FOLDERS") Or ItemName.Equals("ECM_ARCHIVE_FOLDER") Then
                SB.Text = ""
                ckFiles.Checked = True
                ckOutlook.Checked = False
                ckAll.Checked = False
                ckExchange.Checked = False
                CurrCmd = REG.ReadEcmSubKey("ECM_ARCHIVE_FOLDERS")
                SB.Text = CurrCmd
            ElseIf ItemName.Equals("ECM_ARCHIVE_OUTLOOK") Then
                SB.Text = ""
                ckOutlook.Checked = True
                ckFiles.Checked = False
                ckAll.Checked = False
                ckExchange.Checked = False
                CurrCmd = REG.ReadEcmSubKey("ECM_ARCHIVE_OUTLOOK")
                SB.Text = CurrCmd
            ElseIf ItemName.Equals("ECM_ARCHIVE_EXCHANGE") Then
                SB.Text = ""
                ckExchange.Checked = True
                ckFiles.Checked = False
                ckOutlook.Checked = False
                ckAll.Checked = False
                CurrCmd = REG.ReadEcmSubKey("ECM_ARCHIVE_EXCHANGE")
                SB.Text = CurrCmd
            ElseIf ItemName.Equals("ECM_ARCHIVE_ALL") Then
                SB.Text = ""
                ckAll.Checked = True
                ckFiles.Checked = False
                ckOutlook.Checked = False
                ckExchange.Checked = False
                CurrCmd = REG.ReadEcmSubKey("ECM_ARCHIVE_ALL")
                SB.Text = CurrCmd
            Else
                SB.Text = "ECM ONLY OPERATES ON ECM SCHEDULER ITEMS."
                SelectedTaskName.Text = ""
            End If
        End If

    End Sub


    Private Sub btnValidate_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnValidate.Click

        ValidateExecPath()

    End Sub
    Sub parseSubCommand(ByVal RegKey as string )
        Dim SubCommands() As String
        Dim CMX As String = ""
        Dim xCmd As String = ""
        Dim CurrArchCmd As String = REG.ReadEcmRegistrySubKey(RegKey)
        If CurrArchCmd.Trim.Length > 0 Then
            SubCommands = CurrArchCmd.Split("/")
            If UBound(SubCommands) > 0 Then
                For i As Integer = 0 To UBound(SubCommands)
                    CMX = SubCommands(i)
                    'Console.WriteLine(i.ToString + " : " + CMX)
                    If CMX.Trim.Length > 2 Then
                        Dim Z As Integer = 0
                        Z = InStr(CMX, " ")
                        If Z = 2 Then
                            xCmd = Mid(CMX, 1, 1).ToUpper.Trim
                        Else
                            xCmd = Mid(CMX, 1, 3).ToUpper.Trim
                        End If
                    Else
                        xCmd = ""
                    End If
                    If xCmd.Equals("TN") Then
                        SB.Text = Mid(CMX, 4).Trim
                    End If
                    If xCmd.Equals("SC") Then
                        cbScheduleUnits.Text = Mid(CMX, 4).Trim
                    End If
                    If xCmd.Equals("ST") Then
                        cbTod.Text = Mid(CMX, 4).Trim
                    End If
                    If xCmd.Equals("SD") Then
                        Dim xDate As String = ""
                        xDate = Mid(CMX, 3).Trim
                        xDate = xDate + "/" + SubCommands(i + 1) + "/" + SubCommands(i + 2)
                        dtStart.Value = CDate(xDate)
                    End If
                    If xCmd.Equals("D") Then
                        cbDayToRun.Text = Mid(CMX, 2).Trim
                    End If
                    If xCmd.Equals("TR") Then
                        For X As Integer = CMX.Length To 1 Step -1
                            Dim CH As String = ""
                            CH = Mid(CMX, X, 1)
                            If CH.Equals(".") Then
                                Dim A1() As String
                                Dim tCmd As String = Mid(CMX, X)
                                A1 = tCmd.Split(" ")
                                For Y As Integer = 0 To UBound(A1) - 1
                                    Dim CH2 As String = A1(Y)
                                    If CH2.Length > 1 Then
                                        If Mid(CH2, 1, 1).ToUpper.Equals("U") Then
                                            txtUser.Text = Mid(CH2, 2)
                                        End If
                                    End If
                                Next
                            End If
                        Next
                    End If
                Next
            End If
        End If
    End Sub

    Sub ValidateApplicationDirectory(ByVal RegKey)
        Dim CurrApplicationPath As String = Application.ExecutablePath
        Dim PrevApplicationPath As String = REG.ReadEcmRegistrySubKey("EcmArchiverDir")
        Dim SubCommands() As String = Nothing
        Dim TaskName As String = ""
        Dim CMX As String = ""
        Dim xCmd As String = ""
        Dim RebuildCommand As Boolean = False
        If PrevApplicationPath = CurrApplicationPath Then
            SB.Text = "Scheduled tasks point to correct directory."
            Return
        End If
        Dim CurrArchCmd As String = REG.ReadEcmRegistrySubKey(RegKey)
        If CurrArchCmd.Trim.Length > 0 Then
            SubCommands = CurrArchCmd.Split("/")
            If UBound(SubCommands) > 0 Then
                For i As Integer = 0 To UBound(SubCommands)
                    CMX = SubCommands(i)
                    Console.WriteLine(i.ToString + " : " + CMX)
                    If CMX.Trim.Length > 2 Then
                        Dim Z As Integer = 0
                        Z = InStr(CMX, " ")
                        If Z = 2 Then
                            xCmd = Mid(CMX, 1, 1).ToUpper.Trim
                        Else
                            xCmd = Mid(CMX, 1, 3).ToUpper.Trim
                        End If
                    Else
                        xCmd = ""
                    End If
                    If xCmd.Equals("TN") Then
                        TaskName = Mid(CMX, 4)
                    End If
                    If xCmd.Equals("TR") Then
                        Dim S1 As String = ""
                        Dim S2 As String = ""
                        Dim iBlank As Integer = InStr(CMX, Chr(34)) + 1
                        Dim iExe As Integer = InStr(CMX, ".exe") + 4
                        S1 = Mid(CMX, 1, iBlank - 1)
                        S2 = Mid(CMX, iExe)
                        Dim S As String = S1 + CurrApplicationPath + S2
                        Console.WriteLine(S)
                        SubCommands(i) = S
                        RebuildCommand = True
                    End If
                Next
            End If
        End If
        If RebuildCommand = True Then
            Dim NewCmd As String = ""
            For I As Integer = 0 To UBound(SubCommands)
                If I = 0 Then
                    NewCmd = SubCommands(I)
                Else
                    NewCmd += "/" + SubCommands(I)
                End If

            Next
            Console.WriteLine(NewCmd)
            If TaskName.Length > 0 Then
                Dim CMD As String = "SCHTASKS /Delete /F /TN " + TaskName
                ExecuteCommandFile(CMD)
                ExecuteCommandFile(NewCmd)
            End If

        End If
    End Sub
    Public Sub ValidateExecPath()
        SCHED.PopulateScheduleGrid(dgSchedule)
        Dim CurrAppPath As String = Application.ExecutablePath
        Dim ScheduleName As String = ""
        Dim DRV As New DataGridViewRow

        For Each DRV In dgSchedule.Rows
            Try
                ScheduleName = DRV.Cells(0).Value.ToString
            Catch ex As Exception
                ScheduleName = ""
            End Try

            If ScheduleName.Equals("ECM_ARCHIVE_FOLDERS") Then
                ValidateApplicationDirectory(ScheduleName)
            End If
            If ScheduleName.Equals("ECM_ARCHIVE_OUTLOOK") Then
                ValidateApplicationDirectory(ScheduleName)
            End If
            If ScheduleName.Equals("ECM_ARCHIVE_EXCHANGE") Then
                ValidateApplicationDirectory(ScheduleName)
            End If
            If ScheduleName.Equals("ECM_ARCHIVE_ALL") Then
                ValidateApplicationDirectory(ScheduleName)
            End If
        Next
    End Sub

    Sub hideGridColData()
        'TgtColName = SenderEmailAddress
        Dim GridVal As String = ""
        Dim iFound As Boolean = False
        Dim DR As DataGridViewRow
        Dim iRow As Integer = 0

        '**Wdmxx
        For Each DR In dgSchedule.Rows
            Try
                If DR.Visible = True Then
                    GridVal = DR.Cells(0).Value.ToString
                    GridVal = GridVal.Trim
                    Dim B As Boolean = False
                    If InStr(GridVal, "ECM_", CompareMethod.Text) > 0 Then
                        B = True
                    End If
                    If B = False Then
                        DR.Selected = False
                        DR.Visible = False
                    Else
                        Try
                            DR.Selected = False
                            DR.Visible = True
                        Catch ex As Exception
                            Console.WriteLine("Could not hide row.")
                        End Try
                    End If
                End If

            Catch ex As Exception
                Console.WriteLine(ex.Message)
            End Try

        Next

    End Sub
    Sub showGridColData()
        'TgtColName = SenderEmailAddress
        Dim GridVal As String = ""
        Dim iFound As Boolean = False
        Dim DR As DataGridViewRow
        Dim iRow As Integer = 0

        For Each DR In dgSchedule.Rows
            Try
                If DR.Visible = False Then
                    Try
                        DR.Visible = True
                    Catch ex As Exception
                        Console.WriteLine("Could not hide row.")
                    End Try
                End If

            Catch ex As Exception
                Console.WriteLine(ex.Message)
            End Try

        Next

    End Sub

    Private Sub ckShowAll_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ckShowAll.CheckedChanged
        If ckShowAll.Checked = True Then
            showGridColData()
        Else
            hideGridColData()
        End If
    End Sub

    Private Sub CommandExecutionDirectoryToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles CommandExecutionDirectoryToolStripMenuItem.Click
        Dim SchedDir As String = LOG.getTempEnvironDir + "\ScheduleProcessDir"
        Clipboard.Clear()
        Clipboard.SetText(SchedDir)
        messagebox.show("Command file path in clipboard.")
    End Sub
End Class
