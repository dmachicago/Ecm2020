Imports System.Data.SqlClient
Imports System.IO
Imports System.Threading
Imports ECMEncryption

Public Class clsRemoteSupport

    Dim DMA As New clsDma
    Dim DBARCH As New clsDatabaseARCH
    Dim HELP As New clsHELPTEXT
    Dim ENC As new ECMEncrypt

    Dim UTIL As New clsUtility
    Dim LOG As New clsLogging


    Dim slRemoteHelp As New SortedList(Of String, Date)

    Dim ScreenName As String = ""
    Dim HelpText As String = ""
    Dim WidgetName As String = ""
    Dim WidgetText As String = ""
    Dim DisplayHelpText As String = ""
    Dim LastUpdate As String = ""
    Dim CreateDate As String = ""
    Dim UpdatedBy As String = ""

    Dim RecordsAdded As Integer = 0
    Dim RecordsUpdated As Integer = 0
    Dim ErrorCnt As Integer = 0

    Dim RemoteHelpConnStr As String = ""

    Sub New()
        RemoteHelpConnStr = getRemoteHelpConnString()
    End Sub
    Sub getHelpQuiet()
        Dim myThread As New Thread(AddressOf UpdateHelp)
        myThread.Start()
    End Sub
    Public Function getRemoteHelpConnString() As String
        Dim RemoteHelpConnStr As String = ""
        RemoteHelpConnStr = DBARCH.getHelpConnStr()
        Try
            RemoteHelpConnStr = ENC.AES256DecryptString(RemoteHelpConnStr)
        Catch ex As Exception
            RemoteHelpConnStr = ""
        End Try

        Return RemoteHelpConnStr
    End Function
    Public Function isConnectedToInet() As Boolean
        Dim B As Boolean = DMA.isConnected
        Return B
    End Function
    Public Function isConnectedEcmLibrary() As Boolean
        Dim I As Integer = 0
        I = getCountRemoteTable("helptext")
        If I >= 0 Then
            Return True
        Else
            Return False
        End If
    End Function
    Function getCountRemoteTable(ByVal TableName As String) As Integer

        Try
            Dim iCnt As Integer = 0
            Dim S As String = "Select COUNT(*) from " + TableName

            Dim I As Integer = 0

            Dim rsColInfo As SqlDataReader = Nothing
            rsColInfo = DBARCH.SqlQryNewConn(S, RemoteHelpConnStr)
            If rsColInfo.HasRows Then
                Do While rsColInfo.Read()
                    iCnt = rsColInfo.GetInt32(0)
                Loop
            End If

            If Not rsColInfo.IsClosed Then
                rsColInfo.Close()
            End If
            If Not rsColInfo Is Nothing Then
                rsColInfo = Nothing
            End If
            Return iCnt
        Catch ex As Exception
            'messagebox.show("getCountRemoteTable: Connection to remote server failed:" + vbCrLf + ex.Message)
            LOG.WriteToArchiveLog("getCountRemoteTable: Connection to remote server failed:" + vbCrLf + ex.Message)
        End Try
        Return -1
    End Function
    Function getRemoteRowLastupdate(ByVal ScreenName As String, ByVal WidgetName As String) As Date

        Try
            Dim LastUpdate As String = ""
            Dim S As String = "Select [LastUpdate] FROM [HelpText] where ScreenName = '" + ScreenName + "' and WidgetName = '" + WidgetName + "'"
            Dim I As Integer = 0
            Dim rsColInfo As SqlDataReader = Nothing

            rsColInfo = DBARCH.SqlQryNewConn(S, RemoteHelpConnStr)
            If rsColInfo.HasRows Then
                Do While rsColInfo.Read()
                    LastUpdate = rsColInfo.GetValue(0).ToString
                Loop
            End If

            If Not rsColInfo.IsClosed Then
                rsColInfo.Close()
            End If
            If Not rsColInfo Is Nothing Then
                rsColInfo = Nothing
            End If
            Return CDate(LastUpdate)
        Catch ex As Exception
            MessageBox.Show("getRemoteRowLastupdate: Connection to remote server failed:" + vbCrLf + ex.Message)
            LOG.WriteToArchiveLog("getRemoteRowLastupdate: Connection to remote server failed:" + vbCrLf + ex.Message)
        End Try

        Return Nothing

    End Function
    Function ckRemoteConnection() As Boolean

        Dim B As Boolean = False

        Try
            Dim iCnt As Integer = 0
            Dim S As String = "Select COUNT(*) from helptext"

            Dim I As Integer = 0

            Dim rsColInfo As SqlDataReader = Nothing
            'rsColInfo = SqlQryNo'Session(S)
            rsColInfo = DBARCH.SqlQryNewConn(S, RemoteHelpConnStr)
            If rsColInfo.HasRows Then
                Do While rsColInfo.Read()
                    iCnt = rsColInfo.GetInt32(0)
                Loop
            End If

            If Not rsColInfo.IsClosed Then
                rsColInfo.Close()
            End If
            If Not rsColInfo Is Nothing Then
                rsColInfo = Nothing
            End If
            B = True
        Catch ex As Exception
            MessageBox.Show("Connection to remote server failed:" + vbCrLf + ex.Message)
            LOG.WriteToArchiveLog("Connection to remote server failed:" + vbCrLf + ex.Message)
            B = False
        End Try

        Return B
    End Function
    Public Sub UpdateHelp()

        Dim DoNotDoThisAnyLonger As Boolean = True

        If DoNotDoThisAnyLonger = True Then
            Return
        End If

        Dim B As Boolean = False
        B = ckLookupTblNeedsUpdate("HelpText")
        If B Then
            LOG.WriteToArchiveLog("Help update needed.")
            PushHelpToServer()
            PullHelpFromServer()
            'log.WriteToArchiveLog("Help last updated: " + Now.ToString)
        Else
            LOG.WriteToArchiveLog("clsRemoteSupport:UpdateHelp - Help update checked and not needed.")
        End If

    End Sub

    Public Function ckLookupTblNeedsUpdate(ByVal TableName As String) As Boolean

        If Not isConnectedToInet() Then
            LOG.WriteToArchiveLog("Not connected to the internet.")
            Return False
        Else
            LOG.WriteToArchiveLog("Connected to the internet.")
        End If
        If Not isConnectedEcmLibrary() Then
            LOG.WriteToArchiveLog("Not connected to EcmLibrary.com.")
            Return False
        Else
            LOG.WriteToArchiveLog("Connected to EcmLibrary.com.")
        End If

        Dim B As Boolean = False
        Dim NbrLocalHelpRecs As Integer = 0
        Dim LastLocalHelpUpdate As Date = Now
        Dim NbrRemoteHelpRecs As Integer = 0
        Dim LastRemoteHelpUpdate As Date = Now

        ckGetHelpUpdateEvalParms(TableName, RemoteHelpConnStr, NbrRemoteHelpRecs, LastLocalHelpUpdate)

        Dim LocalConnStr As String = DBARCH.setConnStr()     'DBARCH.getGateWayConnStr(gGateWayID)
        ckGetHelpUpdateEvalParms(TableName, LocalConnStr, NbrLocalHelpRecs, LastRemoteHelpUpdate)

        If NbrLocalHelpRecs <> NbrRemoteHelpRecs Then
            B = True
        End If
        If LastLocalHelpUpdate <> LastRemoteHelpUpdate Then
            B = True
        End If
        Return B
    End Function
    Sub ckGetHelpUpdateEvalParms(ByVal TableName As String, ByVal ConnStr As String, ByRef NbrHelpRecs As Integer, ByRef LastHelpUpdate As Date)
        Dim UpdateHelp As Boolean = False
        Dim S As String = " SELECT count(*) as TotRecs ,max([LastUpdate]) as LastUpdate    "
        S = S + " FROM " + TableName + " "   '** [HelpText]
        Dim iCnt As Integer = 0
        Dim LastDate As Date = CDate("01/01/1980")

        Try

            Dim rsColInfo As SqlDataReader = Nothing
            rsColInfo = DBARCH.SqlQryNewConn(S, ConnStr)
            If rsColInfo.HasRows Then
                Do While rsColInfo.Read()
                    iCnt = rsColInfo.GetInt32(0)
                    LastDate = rsColInfo.GetDateTime(1)
                Loop
            End If

            If Not rsColInfo.IsClosed Then
                rsColInfo.Close()
            End If
            If Not rsColInfo Is Nothing Then
                rsColInfo = Nothing
            End If
        Catch ex As Exception
            MessageBox.Show("ckLookupTblNeedsUpdate: Error:" + vbCrLf + ex.Message)
            LOG.WriteToArchiveLog("ckLookupTblNeedsUpdate: Error:" + vbCrLf + ex.Message)
        End Try

        NbrHelpRecs = iCnt
        LastHelpUpdate = LastDate

    End Sub
    Function LoadRemoteSortedList() As Boolean

        Dim BB As Boolean = False

        slRemoteHelp.Clear()
        'RemoteHelpConnStr  = DBARCH.getHelpConnStr()

        If RemoteHelpConnStr.Trim.Length = 0 Then
            LOG.WriteToArchiveLog("clsRemoteSupport:LoadRemoteSortedList - Could not retrieve the CONNECTION STRING for the remote help server, aborting - contact an administrator.")
            Return False
        End If

        Dim iCnt As Integer = 0
        iCnt = getCountRemoteTable("helptext")

        If iCnt = 0 Then
            Return True
        End If

        Dim II As Integer = 0
        Dim GetRemoteHelpSQL As String = ""

        GetRemoteHelpSQL = GetRemoteHelpSQL + " Select [ScreenName]"
        GetRemoteHelpSQL = GetRemoteHelpSQL + " ,[HelpText]"
        GetRemoteHelpSQL = GetRemoteHelpSQL + " ,[WidgetName]"
        GetRemoteHelpSQL = GetRemoteHelpSQL + " ,[WidgetText]"
        GetRemoteHelpSQL = GetRemoteHelpSQL + " ,[DisplayHelpText]"
        GetRemoteHelpSQL = GetRemoteHelpSQL + " ,[LastUpdate]"
        GetRemoteHelpSQL = GetRemoteHelpSQL + " ,[CreateDate]"
        GetRemoteHelpSQL = GetRemoteHelpSQL + " ,[UpdatedBy]"
        GetRemoteHelpSQL = GetRemoteHelpSQL + " FROM [HelpText] "

        Dim KK As Integer = 0
        Dim rsRemoteHelp As SqlDataReader = Nothing
        'rsRemoteHelp = SqlQryNo'Session(S)
        rsRemoteHelp = DBARCH.SqlQryNewConn(GetRemoteHelpSQL, RemoteHelpConnStr)
        If rsRemoteHelp.HasRows Then
            Try
                Do While rsRemoteHelp.Read()
                    II = II + 1
                    KK += 1
                    'If II = 99 Then
                    '    Console.WriteLine("Here 00101 ")
                    'End If
                    ScreenName = gcStr(rsRemoteHelp, 0)
                    HelpText = gcStr(rsRemoteHelp, 1)
                    WidgetName = gcStr(rsRemoteHelp, 2)
                    WidgetText = gcStr(rsRemoteHelp, 3)
                    DisplayHelpText = gcStr(rsRemoteHelp, 4)
                    If DisplayHelpText.Equals("1") Then
                    ElseIf DisplayHelpText.Equals("0") Then
                    ElseIf DisplayHelpText.Equals("-1") Then
                    ElseIf UCase(DisplayHelpText).Equals("TRUE") Then
                        DisplayHelpText = "1"
                    Else
                        DisplayHelpText = "0"
                    End If
                    LastUpdate = gcStr(rsRemoteHelp, 5)
                    CreateDate = gcStr(rsRemoteHelp, 6)
                    UpdatedBy = gcStr(rsRemoteHelp, 7)

                    Application.DoEvents()
                    Dim tKey As String = ScreenName.Trim + Chr(254) + WidgetName
                    If slRemoteHelp.IndexOfKey(tKey) >= 0 Then
                    Else
                        slRemoteHelp.Add(tKey, CDate(LastUpdate))
                    End If
                Loop
            Catch ex As Exception
                'messagebox.show("clsRemoteSupport:LoadRemoteSortedList - Failed to read help record for: " + ScreenName  + ":" + WidgetName  + ".")
                LOG.WriteToArchiveLog("clsRemoteSupport:LoadRemoteSortedList - Failed to read help record for: " + ScreenName + ":" + WidgetName + ".")
            End Try

        End If
        rsRemoteHelp.Close()
        rsRemoteHelp = Nothing

    End Function
    Sub PushHelpToServer()

        Dim BB As Boolean = ckRemoteConnection()
        If Not BB Then
            Return
        End If

        LoadRemoteSortedList()

        If RemoteHelpConnStr.Trim.Length = 0 Then
            LOG.WriteToArchiveLog("clsRemoteSupport:PushHelpToServer - Could not retrieve the CONNECTION STRING for the remote help server, aborting - contact an administrator.")
            Return
        End If

        Dim iCnt As Integer = 0
        iCnt = getCountLocalTable("helptext")

        Dim II As Integer = 0
        Dim S As String = ""

        S = S + " Select [ScreenName]"
        S = S + " ,[HelpText]"
        S = S + " ,[WidgetName]"
        S = S + " ,[WidgetText]"
        S = S + " ,[DisplayHelpText]"
        S = S + " ,[LastUpdate]"
        S = S + " ,[CreateDate]"
        S = S + " ,[UpdatedBy]"
        S = S + " FROM [HelpText] order by [LastUpdate] desc "

        Dim RSData As SqlDataReader = Nothing
        'RSData = SqlQryNo'Session(S)
        Dim CS As String = DBARCH.setConnStr()     'DBARCH.getGateWayConnStr(gGateWayID) : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(S, CONN) : RSData = command.ExecuteReader()
        If RSData.HasRows Then
            Try
                Do While RSData.Read()
                    II = II + 1
                    '** All of the below variables are public to the entire class
                    ScreenName = RSData.GetValue(0).ToString
                    HelpText = RSData.GetValue(1).ToString
                    WidgetName = RSData.GetValue(2).ToString
                    WidgetText = RSData.GetValue(3).ToString
                    DisplayHelpText = RSData.GetValue(4).ToString
                    LastUpdate = RSData.GetValue(5).ToString
                    CreateDate = RSData.GetValue(6).ToString
                    UpdatedBy = RSData.GetValue(7).ToString

                    Application.DoEvents()

                    publishRemoteHelpKey(DisplayHelpText, ScreenName, WidgetName)
                Loop
            Catch ex As Exception
                'messagebox.show("clsRemoteSupport:PushHelpToServer - Failed to read help record for: " + ScreenName  + ":" + WidgetName  + ".")
                LOG.WriteToArchiveLog("clsRemoteSupport:PushHelpToServer - Failed to read help record for: " + ScreenName + ":" + WidgetName + ".")
            End Try

        End If
        RSData.Close()
        RSData = Nothing
        Dim msg As String = ""
        msg = "Upload Complete - Records Added: " + RecordsAdded.ToString
        msg = msg + ", Records Updated: " + RecordsUpdated.ToString
        msg = msg + ", Errors: " + ErrorCnt.ToString
        LOG.WriteToArchiveLog(msg)
    End Sub
    ''' <summary>
    ''' Get value from Sql Data Reader Column as string
    ''' </summary>
    ''' <param name="rsRemoteHelp"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Function gcStr(ByVal SDR As SqlDataReader, ByVal ColNbr As Integer) As String
        Dim tVal As String = ""
        Try
            'RSData.GetValue(7).ToString
            tVal = SDR.GetValue(ColNbr).ToString
        Catch ex As Exception
            tVal = ""
            Console.WriteLine(ex.ToString)
        End Try
        Return tVal
    End Function
    Function getCountLocalTable(ByVal TableName As String) As Integer
        Dim iCnt As Integer = 0
        Dim S As String = "Select COUNT(*) from " + TableName

        DBARCH.CloseConn()
        DBARCH.CkConn()
        Dim I As Integer = 0

        Dim rsColInfo As SqlDataReader = Nothing
        'rsColInfo = SqlQryNo'Session(S)
        rsColInfo = DBARCH.SqlQryNewConn(S)
        If rsColInfo.HasRows Then
            Do While rsColInfo.Read()
                iCnt = rsColInfo.GetInt32(0)
            Loop
        End If

        If Not rsColInfo.IsClosed Then
            rsColInfo.Close()
        End If
        If Not rsColInfo Is Nothing Then
            rsColInfo = Nothing
        End If
        Return iCnt
    End Function
    Function publishRemoteHelpKey(ByVal DisplayHelpText As String, ByVal ScreenName As String, ByVal WidgetName As String) As Boolean
        Dim BB As Boolean = False
        Dim B As Boolean = False

        Dim NowUser As String = LOG.getEnvVarUserID
        If UCase(DisplayHelpText).Equals("TRUE") Then
            DisplayHelpText = "1"
        Else
            DisplayHelpText = "0"
        End If

        B = ckRecordExists(ScreenName, WidgetName)
        If B Then
            B = ckRecordNeedsUpdating(ScreenName, WidgetName)
            If B Then
                '** Update the help
                '** Update the help
                Dim UpdateSql As String = ""
                UpdateSql = UpdateSql + " UPDATE [HelpText]"
                UpdateSql = UpdateSql + " SET "
                UpdateSql = UpdateSql + "  [HelpText] = '" + HelpText + "' "
                UpdateSql = UpdateSql + " ,[DisplayHelpText] = " + DisplayHelpText
                UpdateSql = UpdateSql + " ,[WidgetText] = '" + WidgetText + "'"
                UpdateSql = UpdateSql + " ,[LastUpdate] = '" + LastUpdate + "'"
                UpdateSql = UpdateSql + " ,[UpdatedBy] = '" + NowUser + "'"
                UpdateSql = UpdateSql + " WHERE "
                UpdateSql = UpdateSql + " ScreenName = '" + ScreenName + "' "
                UpdateSql = UpdateSql + " and WidgetName = '" + WidgetName + "' "

                BB = DBARCH.ExecuteSqlNewConn(UpdateSql, RemoteHelpConnStr, B)
                If Not BB Then
                    LOG.WriteToArchiveLog("frmHelpEditor : btnPushToServer_Click - Failed to update help record for: " + ScreenName + ":" + WidgetName + ".")
                    ErrorCnt += 1
                Else
                    RecordsUpdated += 1
                End If
            End If
        Else
            '** Insert the help
            HELP.setDisplayhelptext(DisplayHelpText)
            HELP.setHelptext(HelpText)
            HELP.setLastupdate(Now.ToString)
            HELP.setScreenname(ScreenName)
            HELP.setUpdatedby(NowUser)
            HELP.setWidgetname(WidgetName)
            HELP.setWidgettext(WidgetText)
            BB = HELP.InsertRemote(RemoteHelpConnStr)
            If Not BB Then
                MessageBox.Show("frmHelpEditor : btnPushToServer_Click - 005 Failed to ADD help record for: " + ScreenName + ":" + WidgetName + ".")
                LOG.WriteToArchiveLog("frmHelpEditor : btnPushToServer_Click - 006 Failed to ADD help record for: " + ScreenName + ":" + WidgetName + ".")
                ErrorCnt += 1
            Else
                RecordsAdded += 1
            End If
        End If

        Return B

    End Function
    Function ckRecordExists(ByVal ScreenName As String, ByVal WidgetName As String) As Boolean
        Dim B As Boolean = False
        Dim tKey As String = ScreenName.Trim + Chr(254) + WidgetName.Trim

        Dim I As Integer = slRemoteHelp.IndexOfKey(tKey)

        If I >= 0 Then
            B = True
        End If

        Return B
    End Function
    Function ckRecordNeedsUpdating(ByVal ScreenName As String, ByVal WidgetName As String) As Boolean
        Dim B As Boolean = False
        Dim tKey As String = ScreenName.Trim + Chr(254) + WidgetName.Trim
        Dim LastUpdateDate As Date

        Dim idx As Integer = slRemoteHelp.IndexOfKey(tKey)
        If idx >= 0 Then
        Else
            Return True
        End If
        LastUpdateDate = slRemoteHelp(tKey)

        If CDate(LastUpdate) > LastUpdateDate Then
            B = True
        End If

        Return B
    End Function
    Sub PullHelpFromServer()

        RecordsAdded = 0
        RecordsUpdated = 0
        ErrorCnt = 0
        'RemoteHelpConnStr  = DBARCH.getHelpConnStr()
        If RemoteHelpConnStr.Trim.Length = 0 Then
            MessageBox.Show("clsRemoteSupport:PullHelpFromServer - Could not retrieve the CONNECTION STRING for the remote help server, aborting - contact an administrator.")
            LOG.WriteToArchiveLog("clsRemoteSupport:PullHelpFromServer - Failed to read help record for: " + ScreenName + ":" + WidgetName + ".")
            Return
        End If

        Dim BB As Boolean = ckRemoteConnection()
        If Not BB Then
            Return
        End If

        LoadLocalSortedList()

        Dim iCnt As Integer = 0
        iCnt = getCountLocalTable("helptext")

        Dim II As Integer = 0

        Dim RemoteSQL As String = ""
        RemoteSQL = RemoteSQL + " Select [ScreenName]"
        RemoteSQL = RemoteSQL + " ,[HelpText]"
        RemoteSQL = RemoteSQL + " ,[WidgetName]"
        RemoteSQL = RemoteSQL + " ,[WidgetText]"
        RemoteSQL = RemoteSQL + " ,[DisplayHelpText]"
        RemoteSQL = RemoteSQL + " ,[LastUpdate]"
        RemoteSQL = RemoteSQL + " ,[CreateDate]"
        RemoteSQL = RemoteSQL + " ,[UpdatedBy]"
        RemoteSQL = RemoteSQL + " FROM [HelpText] "
        Dim KK As Integer = 0
        Dim rsRemoteHelp As SqlDataReader = Nothing
        'rsRemoteHelp = SqlQryNo'Session(S)
        rsRemoteHelp = DBARCH.SqlQryNewConn(RemoteSQL, RemoteHelpConnStr)
        If rsRemoteHelp.HasRows Then
            Try
                Do While rsRemoteHelp.Read()
                    II = II + 1
                    KK += 1
                    '** All of the below variables are public to the entire class
                    ScreenName = rsRemoteHelp.GetValue(0).ToString
                    HelpText = rsRemoteHelp.GetValue(1).ToString
                    WidgetName = rsRemoteHelp.GetValue(2).ToString
                    WidgetText = rsRemoteHelp.GetValue(3).ToString
                    DisplayHelpText = rsRemoteHelp.GetValue(4).ToString
                    If DisplayHelpText.Equals("1") Then
                    ElseIf DisplayHelpText.Equals("0") Then
                    ElseIf DisplayHelpText.Equals("-1") Then
                    ElseIf UCase(DisplayHelpText).Equals("TRUE") Then
                        DisplayHelpText = "1"
                    Else
                        DisplayHelpText = "0"
                    End If
                    LastUpdate = rsRemoteHelp.GetValue(5).ToString
                    CreateDate = rsRemoteHelp.GetValue(6).ToString
                    UpdatedBy = rsRemoteHelp.GetValue(7).ToString

                    publishLocalHelpKey(ScreenName, WidgetName)

                    Application.DoEvents()

                Loop
            Catch ex As Exception
                MessageBox.Show("frmHelpEditor : btnPushToServer_Click - Failed to read help record for: " + ScreenName + ":" + WidgetName + ".")
                LOG.WriteToArchiveLog("frmHelpEditor : btnPushToServer_Click - Failed to read help record for: " + ScreenName + ":" + WidgetName + ".")
            End Try

        End If
        rsRemoteHelp.Close()
        rsRemoteHelp = Nothing

        Dim Msg As String = ""
        Msg = "HELP Download Complete - RecordsAdded: " + RecordsAdded.ToString
        Msg = Msg + ", RecordsUpdated: " + RecordsUpdated.ToString
        Msg = Msg + ", Errors: " + ErrorCnt.ToString
        LOG.WriteToArchiveLog(Msg)
    End Sub
    Function LoadLocalSortedList() As Boolean
        Try
            Dim BB As Boolean = False

            slRemoteHelp.Clear()

            Dim iCnt As Integer = 0
            iCnt = getCountLocalTable("helptext")

            Dim II As Integer = 0
            Dim S As String = ""

            S = S + " Select [ScreenName]"
            S = S + " ,[HelpText]"
            S = S + " ,[WidgetName]"
            S = S + " ,[WidgetText]"
            S = S + " ,[DisplayHelpText]"
            S = S + " ,[LastUpdate]"
            S = S + " ,[CreateDate]"
            S = S + " ,[UpdatedBy]"
            S = S + " FROM [HelpText] "
            Dim KK As Integer = 0
            Dim RSData As SqlDataReader = Nothing

            Dim CS As String = getRemoteHelpConnString() : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(S, CONN) : RSData = command.ExecuteReader()
            If RSData.HasRows Then
                Try
                    Do While RSData.Read()
                        II = II + 1
                        KK = KK + 1
                        ScreenName = RSData.GetValue(0).ToString
                        HelpText = RSData.GetValue(1).ToString
                        WidgetName = RSData.GetValue(2).ToString
                        WidgetText = RSData.GetValue(3).ToString
                        DisplayHelpText = RSData.GetValue(4).ToString
                        If DisplayHelpText.Equals("1") Then
                        ElseIf DisplayHelpText.Equals("0") Then
                        ElseIf DisplayHelpText.Equals("-1") Then
                        ElseIf UCase(DisplayHelpText).Equals("TRUE") Then
                            DisplayHelpText = "1"
                        Else
                            DisplayHelpText = "0"
                        End If
                        LastUpdate = RSData.GetValue(5).ToString
                        CreateDate = RSData.GetValue(6).ToString
                        UpdatedBy = RSData.GetValue(7).ToString

                        Application.DoEvents()
                        Dim tKey As String = ScreenName.Trim + Chr(254) + WidgetName
                        If slRemoteHelp.IndexOfKey(tKey) >= 0 Then
                        Else
                            slRemoteHelp.Add(tKey, CDate(LastUpdate))
                        End If
                    Loop
                Catch ex As Exception
                    'messagebox.show("clsRemoteSupport:LoadLocalSortedList - Failed to read help record for: " + ScreenName  + ":" + WidgetName  + ".")
                    LOG.WriteToArchiveLog("clsRemoteSupport:LoadLocalSortedList - Failed to read help record for: " + ScreenName + ":" + WidgetName + ".")
                End Try

            End If
            RSData.Close()
            RSData = Nothing
        Catch ex As Exception
            LOG.WriteToArchiveLog("clsRemoteSupport : LoadLocalSortedList 100 " + ex.Message)
        End Try

    End Function
    Function publishLocalHelpKey(ByVal ScreenName As String, ByVal WidgetName As String) As Boolean
        If UCase(DisplayHelpText).Equals("TRUE") Then
            DisplayHelpText = "1"
        Else
            DisplayHelpText = "0"
        End If
        Dim B As Boolean = False

        B = ckRecordExists(ScreenName, WidgetName)
        Dim BB As Boolean = False
        Dim NowUser As String = LOG.getEnvVarUserID
        'HELP.setUpdatedby(NowUser )
        If B Then
            B = ckRecordNeedsUpdating(ScreenName, WidgetName)
            If B Then
                '** Update the help
                Dim UpdateSql As String = ""
                UpdateSql = UpdateSql + " UPDATE [HelpText]" + vbCrLf
                UpdateSql = UpdateSql + " SET " + vbCrLf
                UpdateSql = UpdateSql + "  [HelpText] = '" + HelpText + "' " + vbCrLf
                UpdateSql = UpdateSql + " ,[DisplayHelpText] = " + DisplayHelpText + vbCrLf
                UpdateSql = UpdateSql + " ,[WidgetText] = '" + WidgetText + "' " + vbCrLf
                UpdateSql = UpdateSql + " ,[LastUpdate] = '" + LastUpdate + "'" + vbCrLf
                UpdateSql = UpdateSql + " ,[UpdatedBy] = '" + NowUser + "'" + vbCrLf
                UpdateSql = UpdateSql + " WHERE " + vbCrLf
                UpdateSql = UpdateSql + " ScreenName = '" + ScreenName + "' " + vbCrLf
                UpdateSql = UpdateSql + " and WidgetName = '" + WidgetName + "' "

                BB = DBARCH.ExecuteSqlNewConn(UpdateSql, False)
                If Not BB Then
                    LOG.WriteToArchiveLog("frmHelpEditor : btnPushToServer_Click - Failed to update help record for: " + ScreenName + ":" + WidgetName + ".")
                    ErrorCnt += 1
                Else
                    RecordsUpdated += 1
                End If
            End If
        Else
            '** Insert the help
            HELP.setDisplayhelptext(DisplayHelpText)
            HELP.setHelptext(HelpText)
            HELP.setLastupdate(Now.ToString)
            HELP.setScreenname(ScreenName)
            HELP.setUpdatedby(NowUser)
            HELP.setWidgetname(WidgetName)
            HELP.setWidgettext(WidgetText)
            BB = HELP.Insert
            If Not BB Then
                'ErrorCnt += 1
                'messagebox.show("frmHelpEditor : btnPushToServer_Click - 007 Failed to ADD help record for: " + ScreenName  + ":" + WidgetName  + ".")
                LOG.WriteToArchiveLog("frmHelpEditor : btnPushToServer_Click - 008 Failed to ADD help record for: " + ScreenName + ":" + WidgetName + ".")
            Else
                RecordsAdded += 1
            End If
        End If

        Return B

    End Function
    Sub UpdateHooverHelp()
        RecordsAdded = 0
        RecordsUpdated = 0
        ErrorCnt = 0
        'RemoteHelpConnStr  = DBARCH.getHelpConnStr()
        If RemoteHelpConnStr.Trim.Length = 0 Then
            MessageBox.Show("clsRemoteSupport:UpdateHooverHelp - Could not retrieve the CONNECTION STRING for the remote help server, aborting - contact an administrator.")
            LOG.WriteToArchiveLog("clsRemoteSupport:UpdateHooverHelp - Could not retrieve the CONNECTION STRING for the remote help server, aborting - contact an administrator.")
            Return
        End If

        Dim BB As Boolean = ckRemoteConnection()
        If Not BB Then
            MessageBox.Show("Update Hoover Help Failed to connect to remote server.")
            Return
        End If

        LoadLocalSortedList()

        Dim iCnt As Integer = 0
        iCnt = getCountLocalTable("helptext")

        'FrmMDIMain.TSPB1.Minimum = 0
        'FrmMDIMain.TSPB1.Maximum = iCnt + 10
        'FrmMDIMain.TSPB1.Value = 0
        Dim II As Integer = 0

        Dim RemoteSQL As String = ""
        RemoteSQL = RemoteSQL + " Select [ScreenName]"
        RemoteSQL = RemoteSQL + " ,[HelpText]"
        RemoteSQL = RemoteSQL + " ,[WidgetName]"
        RemoteSQL = RemoteSQL + " ,[WidgetText]"
        RemoteSQL = RemoteSQL + " ,[DisplayHelpText]"
        RemoteSQL = RemoteSQL + " ,[LastUpdate]"
        RemoteSQL = RemoteSQL + " ,[CreateDate]"
        RemoteSQL = RemoteSQL + " ,[UpdatedBy]"
        RemoteSQL = RemoteSQL + " FROM [HelpText] "
        Dim KK As Integer = 0
        Dim rsRemoteHelp As SqlDataReader = Nothing
        'rsRemoteHelp = SqlQryNo'Session(S)
        rsRemoteHelp = DBARCH.SqlQryNewConn(RemoteSQL, RemoteHelpConnStr)
        If rsRemoteHelp.HasRows Then
            Try
                Do While rsRemoteHelp.Read()
                    II = II + 1
                    KK += 1
                    'If II >= FrmMDIMain.TSPB1.Maximum Then
                    '    II = 0
                    'End If
                    'FrmMDIMain.TSPB1.Value = II

                    '** All of the below variables are public to the entire class
                    ScreenName = rsRemoteHelp.GetValue(0).ToString
                    HelpText = rsRemoteHelp.GetValue(1).ToString
                    WidgetName = rsRemoteHelp.GetValue(2).ToString
                    WidgetText = rsRemoteHelp.GetValue(3).ToString
                    DisplayHelpText = rsRemoteHelp.GetValue(4).ToString
                    If DisplayHelpText.Equals("1") Then
                    ElseIf DisplayHelpText.Equals("0") Then
                    ElseIf DisplayHelpText.Equals("-1") Then
                    ElseIf UCase(DisplayHelpText).Equals("TRUE") Then
                        DisplayHelpText = "1"
                    Else
                        DisplayHelpText = "0"
                    End If

                    LastUpdate = rsRemoteHelp.GetValue(5).ToString
                    CreateDate = rsRemoteHelp.GetValue(6).ToString
                    UpdatedBy = rsRemoteHelp.GetValue(7).ToString

                    publishLocalHelpKey(ScreenName, WidgetName)

                    Application.DoEvents()

                Loop
            Catch ex As Exception
                MessageBox.Show("frmHelpEditor : btnPushToServer_Click - Failed to read help record for: " + ScreenName + ":" + WidgetName + ".")
                LOG.WriteToArchiveLog("frmHelpEditor : btnPushToServer_Click - Failed to read help record for: " + ScreenName + ":" + WidgetName + ".")
            End Try

        End If
        rsRemoteHelp.Close()
        rsRemoteHelp = Nothing
        'FrmMDIMain.TSPB1.Value = 0
        Dim Msg As String = ""
        Msg = "Hoover Help Download Complete - RecordsAdded: " + RecordsAdded.ToString
        Msg = Msg + ", RecordsUpdated: " + RecordsUpdated.ToString
        Msg = Msg + ", Errors: " + ErrorCnt.ToString
        'FrmMDIMain.TSSB2.Text = Msg
    End Sub
    Function getClientLicenseServer(ByVal CompanyID As String, ByVal LicenseID As String) As String
        Dim ClientLicenseServer As String = ""
        Try
            Dim S As String = "Select MachineID, Applied from license where CompanyID = '" + CompanyID + "' and LicenseID = " + LicenseID
            Dim I As Integer = 0
            Dim rsColInfo As SqlDataReader = Nothing

            rsColInfo = DBARCH.SqlQryNewConn(S, RemoteHelpConnStr)
            If rsColInfo.HasRows Then
                rsColInfo.Read()
                ClientLicenseServer = rsColInfo.GetValue(0).ToString
            End If

            If Not rsColInfo.IsClosed Then
                rsColInfo.Close()
            End If
            If Not rsColInfo Is Nothing Then
                rsColInfo = Nothing
            End If
            GC.Collect()
            GC.WaitForFullGCApproach()
            Return ClientLicenseServer
        Catch ex As Exception
            LOG.WriteToArchiveLog("getClientLicenseServer: Failed to retrieve Server ID:" + vbCrLf + ex.Message)
        End Try

        Return ClientLicenseServer

    End Function
    Function getAvailClientLicenseServerName(ByVal CompanyID As String) As String
        Dim ClientLicenseServer As String = ""
        Dim isApplied As Boolean = False
        Dim B As Boolean = False
        Try
            Dim S As String = "Select MachineID, Applied from license where CompanyID = '" + CompanyID + "'"
            Dim I As Integer = 0
            Dim rsColInfo As SqlDataReader = Nothing

            rsColInfo = DBARCH.SqlQryNewConn(S, RemoteHelpConnStr)
            If rsColInfo.HasRows Then
                Do While rsColInfo.Read()
                    ClientLicenseServer = rsColInfo.GetValue(0).ToString
                    isApplied = rsColInfo.GetBoolean(0)
                    If isApplied = False Then
                        B = True
                        Exit Do
                    End If
                Loop

            End If

            If Not rsColInfo.IsClosed Then
                rsColInfo.Close()
            End If
            If Not rsColInfo Is Nothing Then
                rsColInfo = Nothing
            End If
            GC.Collect()
            GC.WaitForFullGCApproach()
            If B = True Then
            Else
                ClientLicenseServer = ""
            End If
            Return ClientLicenseServer
        Catch ex As Exception
            LOG.WriteToArchiveLog("getClientLicenseServer: Failed to retrieve Server ID:" + vbCrLf + ex.Message)
        End Try

        Return ClientLicenseServer

    End Function
    Function setClientLicenseServer(ByVal CompanyID As String, ByVal LicenseID As String, ByVal MachineID As String) As Boolean
        Dim ClientLicenseServer As String = ""
        Dim B As Boolean = False
        Try
            Dim S As String = "Update License set MachineID = '" + MachineID + "' "
            S = S + "where CompanyID = '" + CompanyID + "' and LicenseID = " + LicenseID
            B = DBARCH.ExecuteSqlNewConn(S, RemoteHelpConnStr, False)
            GC.Collect()
            GC.WaitForFullGCApproach()
        Catch ex As Exception
            LOG.WriteToArchiveLog("setClientLicenseServer: Failed to set Server ID:" + vbCrLf + ex.Message)
        End Try
        Return B
        Return ClientLicenseServer

    End Function

    Function getClientLicenses(ByVal CompanyID As String, ByRef dg As DataGridView) As Boolean
        Dim ClientLicenseServer As String = ""
        Dim isApplied As Boolean = False
        Dim B As Boolean = False

        Dim LicenseID As String = ""
        Dim MachineID As String = ""
        Dim LicenseTypeCode As String = ""
        Dim Applied As String = ""
        Dim EncryptedLicense As String = ""
        Dim SupportActiveDate As String = ""
        Dim SupportInactiveDate As String = ""
        Dim PurchasedMachines As String = ""
        Dim PurchasedUsers As String = ""
        Dim SupportActive As String = ""
        Dim LicenseText As String = ""

        Dim ServerNAME As String = ""
        Dim SqlInstanceName As String = ""

        Try
            Dim S As String = "Select "
            S = S + " CompanyID,"
            S = S + " MachineID,"
            S = S + " LicenseId,"
            S = S + " Applied,"
            S = S + " PurchasedMachines,"
            S = S + " PurchasedUsers,"
            S = S + " SupportActive,"
            S = S + " SupportActiveDate,"
            S = S + " SupportInactiveDate,"
            S = S + " LicenseText,"
            S = S + " LicenseTypeCode,"
            S = S + " EncryptedLicense, ServerNAME, SqlInstanceName"
            S = S + " from License	"
            S = S + " where CompanyID = '" + CompanyID + "' "
            Dim I As Integer = 0
            Dim rsColInfo As SqlDataReader = Nothing

            dg.Columns.Clear()
            dg.Rows.Clear()
            dg.Columns.Add("CompanyID", "CompanyID")
            dg.Columns.Add("MachineID", "MachineID")
            dg.Columns.Add("LicenseId", "LicenseId")
            dg.Columns.Add("Applied", "Applied")
            dg.Columns.Add("PurchasedMachines", "PurchasedMachines")
            dg.Columns.Add("PurchasedUsers", "PurchasedUsers")
            dg.Columns.Add("SupportActive", "SupportActive")
            dg.Columns.Add("SupportActiveDate", "SupportActiveDate")
            dg.Columns.Add("SupportInactiveDate", "SupportInactiveDate")
            dg.Columns.Add("LicenseText", "LicenseText")
            dg.Columns.Add("LicenseTypeCode", "LicenseTypeCode")
            dg.Columns.Add("EncryptedLicense", "EncryptedLicense")
            dg.Columns.Add("ServerName", "ServerName")
            dg.Columns.Add("SqlInstanceName", "SqlInstanceName")

            rsColInfo = DBARCH.SqlQryNewConn(S, RemoteHelpConnStr)
            If rsColInfo.HasRows Then
                Do While rsColInfo.Read()
                    dg.Rows.Add()
                    Dim MaxRowNbr As Integer = dg.Rows.Count - 1

                    CompanyID = rsColInfo.GetValue(0).ToString
                    MachineID = rsColInfo.GetValue(1).ToString
                    LicenseID = rsColInfo.GetValue(2).ToString
                    Applied = rsColInfo.GetValue(3).ToString
                    PurchasedMachines = rsColInfo.GetValue(4).ToString
                    PurchasedUsers = rsColInfo.GetValue(5).ToString
                    SupportActive = rsColInfo.GetValue(6).ToString
                    SupportActiveDate = rsColInfo.GetValue(7).ToString
                    SupportInactiveDate = rsColInfo.GetValue(8).ToString
                    LicenseText = rsColInfo.GetValue(9).ToString
                    LicenseTypeCode = rsColInfo.GetValue(10).ToString
                    EncryptedLicense = rsColInfo.GetValue(11).ToString
                    ServerNAME = rsColInfo.GetValue(12).ToString
                    SqlInstanceName = rsColInfo.GetValue(13).ToString

                    dg.Rows(MaxRowNbr).Cells("CompanyID").Value = CompanyID

                    dg.Rows(MaxRowNbr).Cells("MachineID").Value = MachineID
                    dg.Rows(MaxRowNbr).Cells("LicenseId").Value = LicenseID
                    dg.Rows(MaxRowNbr).Cells("Applied").Value = Applied
                    dg.Rows(MaxRowNbr).Cells("PurchasedMachines").Value = PurchasedMachines
                    dg.Rows(MaxRowNbr).Cells("PurchasedUsers").Value = PurchasedUsers
                    dg.Rows(MaxRowNbr).Cells("SupportActive").Value = SupportActive
                    dg.Rows(MaxRowNbr).Cells("SupportActiveDate").Value = SupportActiveDate
                    dg.Rows(MaxRowNbr).Cells("SupportInactiveDate").Value = SupportInactiveDate
                    dg.Rows(MaxRowNbr).Cells("LicenseText").Value = LicenseText
                    dg.Rows(MaxRowNbr).Cells("LicenseTypeCode").Value = LicenseTypeCode
                    dg.Rows(MaxRowNbr).Cells("EncryptedLicense").Value = EncryptedLicense
                    dg.Rows(MaxRowNbr).Cells("ServerNAME").Value = ServerNAME
                    dg.Rows(MaxRowNbr).Cells("SqlInstanceName").Value = SqlInstanceName
                Loop
            Else
                MessageBox.Show("License not found, please insure the required Company ID and other information is correct.")
            End If

            If Not rsColInfo.IsClosed Then
                rsColInfo.Close()
            End If
            If Not rsColInfo Is Nothing Then
                rsColInfo = Nothing
            End If
            GC.Collect()
            GC.WaitForFullGCApproach()
            LOG.WriteToArchiveLog("getClientLicenses: Retrieve Server license:" + Now.ToString)
            B = True
        Catch ex As Exception
            LOG.WriteToArchiveLog("getClientLicenses: Failed to retrieve Server data:" + vbCrLf + ex.Message)
            B = False
        End Try

        Return B

    End Function
    Function ckCompanyID(ByVal CompanyID As String) As Boolean
        Dim ClientLicenseServer As String = ""
        Dim B As Boolean = False
        Dim I As Integer = 0
        Try
            Dim S As String = "Select count(*) from license "
            S = S + "where CompanyID = '" + CompanyID + "'"
            'B = DBARCH.ExecuteSqlNewConn(S, RemoteHelpConnStr , False)

            Dim rsColInfo As SqlDataReader = Nothing

            rsColInfo = DBARCH.SqlQryNewConn(S, RemoteHelpConnStr)
            If rsColInfo.HasRows Then
                rsColInfo.Read()
                I = rsColInfo.GetInt32(0)
            End If

            If I > 0 Then
                B = True
            Else
                B = False
            End If

            GC.Collect()
            GC.WaitForFullGCApproach()
        Catch ex As Exception
            LOG.WriteToArchiveLog("setClientLicenseServer: Failed to set Server ID:" + vbCrLf + ex.Message)
        End Try
        Return B
    End Function
    Function getClientLicense(ByVal CompanyID As String, ByVal LicenseID As String) As String
        Dim ServerLicense As String = ""
        Try
            Dim S As String = "Select EncryptedLicense from license where CompanyID = '" + CompanyID + "' and LicenseID = " + LicenseID
            Dim I As Integer = 0
            Dim rsColInfo As SqlDataReader = Nothing

            rsColInfo = DBARCH.SqlQryNewConn(S, RemoteHelpConnStr)
            If rsColInfo.HasRows Then
                rsColInfo.Read()
                ServerLicense = rsColInfo.GetValue(0).ToString
            End If

            If Not rsColInfo.IsClosed Then
                rsColInfo.Close()
            End If
            If Not rsColInfo Is Nothing Then
                rsColInfo = Nothing
            End If
            GC.Collect()
            GC.WaitForFullGCApproach()
            Return ServerLicense
        Catch ex As Exception
            LOG.WriteToArchiveLog("getClientLicenseServer: Failed to retrieve Server ID:" + vbCrLf + ex.Message)
        End Try

        Return ServerLicense

    End Function
    Function getLicenseServerName(ByVal CompanyID As String, ByRef ServerName As String, ByRef SqlInstanceName As String) As Boolean
        Dim B As Boolean = False
        Try
            Dim S As String = "Select MachineID, ServerName, SqlInstanceName from license "
            S = S + " where CompanyID = '" + CompanyID + "'"
            S = S + " and ServerName = '" + ServerName + "' "
            S = S + " and SqlInstanceName = '" + SqlInstanceName + "' "
            Dim I As Integer = 0
            Dim rsColInfo As SqlDataReader = Nothing

            rsColInfo = DBARCH.SqlQryNewConn(S, RemoteHelpConnStr)
            If rsColInfo.HasRows Then
                rsColInfo.Read()
                ServerName = rsColInfo.GetValue(1).ToString
                SqlInstanceName = rsColInfo.GetValue(2).ToString
            End If

            If Not rsColInfo.IsClosed Then
                rsColInfo.Close()
            End If
            If Not rsColInfo Is Nothing Then
                rsColInfo = Nothing
            End If
            GC.Collect()
            GC.WaitForFullGCApproach()

            Return True
        Catch ex As Exception
            B = False
            LOG.WriteToArchiveLog("getClientLicenseServer: Failed to retrieve Server ID:" + vbCrLf + ex.Message)
        End Try

        Return B

    End Function
    'Function ckRemoteConnection() As Boolean
    '    Dim ClientLicenseServer  = ""
    '    Dim B As Boolean = False
    '    Dim I As Integer = 0
    '    Try
    '        Dim S  = "Select count(*) from license "
    '        Dim rsColInfo As SqlDataReader = Nothing

    '        rsColInfo = DBARCH.SqlQryNewConn(S, RemoteHelpConnStr )
    '        If rsColInfo.HasRows Then
    '            rsColInfo.Read()
    '            I = rsColInfo.GetInt32(0)
    '        End If

    '        B = True

    '        GC.Collect()
    '        GC.WaitForFullGCApproach()
    '    Catch ex As Exception
    '        log.WriteToArchiveLog("setClientLicenseServer: Failed to set Server ID:" + vbCrLf + ex.Message)
    '    End Try
    '    Return B
    'End Function


End Class
