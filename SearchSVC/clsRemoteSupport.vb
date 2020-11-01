Imports System.Data.SqlClient
Imports System.IO
Imports System.Threading
Imports ECMEncryption

Public Class clsRemoteSupport

    Dim DMA As New clsDmaSVR
    Dim DB As New clsDatabaseSVR
    'Dim HELP As New clsHELPTEXT
    Dim ENC As New ECMEncrypt

    Dim UTIL As New clsUtilitySVR
    Dim LOG As New clsLogging


    Dim slRemoteHelp As New SortedList(Of String, Date)

    Dim ScreenName as string = ""
    Dim HelpText as string = ""
    Dim WidgetName as string = ""
    Dim WidgetText as string = ""
    Dim DisplayHelpText as string = ""
    Dim LastUpdate as string = ""
    Dim CreateDate as string = ""
    Dim UpdatedBy as string = ""

    Dim RecordsAdded As Integer = 0
    Dim RecordsUpdated As Integer = 0
    Dim ErrorCnt As Integer = 0

    Dim RemoteHelpConnStr as string = ""

    Sub New(ByVal SecureID As Integer)

        RemoteHelpConnStr$ = getRemoteHelpConnString(SecureID)

    End Sub
    Sub getHelpQuiet(ByVal SecureID As Integer)
        Dim myThread As New Thread(AddressOf UpdateHelp)
        myThread.Start()
    End Sub
    Public Function getRemoteHelpConnString(ByVal SecureID As Integer) As String
        Dim RemoteHelpConnStr as string = ""
        RemoteHelpConnStr$ = DB.getHelpConnStr(SecureID)
        RemoteHelpConnStr$ = ENC.AES256DecryptString(RemoteHelpConnStr)
        Return RemoteHelpConnStr$
    End Function
    Public Function isConnectedToInet(ByVal SecureID As Integer) As Boolean
        Dim B As Boolean = DMA.isConnected
        Return B
    End Function
    Public Function isConnectedEcmLibrary(ByVal SecureID As Integer) As Boolean
        Dim I As Integer = 0
        I = getCountRemoteTable(SecureID, "helptext")
        If I >= 0 Then
            Return True
        Else
            Return false
        End If
    End Function
    Function getCountRemoteTable(ByVal SecureID As Integer, ByVal TableName as string) As Integer

        Try
            Dim iCnt As Integer = 0
            Dim S$ = "Select COUNT(*) from " + TableName

            Dim I As Integer = 0

            Dim rsColInfo As SqlDataReader = Nothing
            rsColInfo = DB.DBCreateDataReader(S, RemoteHelpConnStr)
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
            'MsgBox("getCountRemoteTable: Connection to remote server failed:" + vbCrLf + ex.Message)
            log.WriteToSqlLog("getCountRemoteTable: Connection to remote server failed:" + vbCrLf + ex.Message)
        End Try
        Return -1
    End Function
    Function getRemoteRowLastupdate(ByVal SecureID As Integer, ByVal ScreenName as string, byval WidgetName as string) As Date

        Try
            Dim LastUpdate As String = ""
            Dim S$ = "Select [LastUpdate] FROM [HelpText] where ScreenName = '" + ScreenName$ + "' and WidgetName = '" + WidgetName$ + "'"
            Dim I As Integer = 0
            Dim rsColInfo As SqlDataReader = Nothing

            rsColInfo = DB.DBCreateDataReader(S, RemoteHelpConnStr)
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
            MsgBox("getRemoteRowLastupdate: Connection to remote server failed:" + vbCrLf + ex.Message)
            log.WriteToSqlLog("getRemoteRowLastupdate: Connection to remote server failed:" + vbCrLf + ex.Message)
        End Try

        Return Nothing

    End Function
    Function ckRemoteConnection(ByVal SecureID As Integer) As Boolean

        Dim B As Boolean = False

        Try
            Dim iCnt As Integer = 0
            Dim S$ = "Select COUNT(*) from helptext"

            Dim I As Integer = 0

            Dim rsColInfo As SqlDataReader = Nothing
            'rsColInfo = SqlQryNo'Session(S)
            rsColInfo = DB.DBCreateDataReader(S, RemoteHelpConnStr)
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
            MsgBox("Connection to remote server failed:" + vbCrLf + ex.Message)
            log.WriteToSqlLog("Connection to remote server failed:" + vbCrLf + ex.Message)
            B = False
        End Try

        Return B
    End Function
    Public Sub UpdateHelp(ByVal SecureID As Integer)

        Dim DoNotDoThisAnyLonger As Boolean = True

        If DoNotDoThisAnyLonger = True Then
            Return
        End If

        Dim B As Boolean = False
        B = ckLookupTblNeedsUpdate(SecureID, "HelpText")
        If B Then
            PushHelpToServer(SecureID)
            PullHelpFromServer(SecureID)
            'log.WriteToSqlLog("Help last updated: " + Now.ToString)
        Else
            'WriteTraceLog("clsRemoteSupport:UpdateHelp - Help update checked and not needed.")
        End If

    End Sub

    Public Function ckLookupTblNeedsUpdate(ByVal SecureID As Integer, ByVal TableName as string) As Boolean

        If Not isConnectedToInet(SecureID) Then
            'WriteTraceLog("Not connected to the internet.")
            Return False
        Else
            'WriteTraceLog("Connected to the internet.")
        End If
        If Not isConnectedEcmLibrary(SecureID) Then
            'WriteTraceLog("Not connected to EcmLibrary.com.")
            Return False
        Else
            'WriteTraceLog("Connected to EcmLibrary.com.")
        End If

        Dim B As Boolean = False
        Dim NbrLocalHelpRecs As Integer = 0
        Dim LastLocalHelpUpdate As Date = Now
        Dim NbrRemoteHelpRecs As Integer = 0
        Dim LastRemoteHelpUpdate As Date = Now

        ckGetHelpUpdateEvalParms(SecureID, TableName$, RemoteHelpConnStr$, NbrRemoteHelpRecs, LastLocalHelpUpdate)

        Dim LocalConnStr$ = DBgetConnStr()
        ckGetHelpUpdateEvalParms(SecureID, TableName$, LocalConnStr$, NbrLocalHelpRecs, LastRemoteHelpUpdate)

        If NbrLocalHelpRecs <> NbrRemoteHelpRecs Then
            B = True
        End If
        If LastLocalHelpUpdate <> LastRemoteHelpUpdate Then
            B = True
        End If
        Return B
    End Function
    Sub ckGetHelpUpdateEvalParms(ByVal SecureID As Integer, ByVal TableName as string, byval ConnStr as string, byref NbrHelpRecs As Integer, ByRef LastHelpUpdate As Date)
        Dim UpdateHelp As Boolean = False
        Dim S$ = " SELECT count(*) as TotRecs ,max([LastUpdate]) as LastUpdate    "
        S = S + " FROM " + TableName$ + " "   '** [HelpText]
        Dim iCnt As Integer = 0
        Dim LastDate As Date = CDate("01/01/1980")

        Try

            Dim rsColInfo As SqlDataReader = Nothing
            rsColInfo = DB.DBCreateDataReader(S, ConnStr)
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
            MsgBox("ckLookupTblNeedsUpdate: Error:" + vbCrLf + ex.Message)
            log.WriteToSqlLog("ckLookupTblNeedsUpdate: Error:" + vbCrLf + ex.Message)
        End Try

        NbrHelpRecs = iCnt
        LastHelpUpdate = LastDate

    End Sub
    Function LoadRemoteSortedList(ByVal SecureID As Integer) As Boolean

        Dim BB As Boolean = True

        slRemoteHelp.Clear()
        'RemoteHelpConnStr$ = DB.getHelpConnStr()

        If RemoteHelpConnStr$.Trim.Length = 0 Then
            log.WriteToSqlLog("clsRemoteSupport:LoadRemoteSortedList - Could not retrieve the CONNECTION STRING for the remote help server, aborting - contact an administrator.")
            Return False
        End If

        Dim iCnt As Integer = 0
        iCnt = getCountRemoteTable(SecureID, "helptext")

        If iCnt = 0 Then
            Return True
        End If

        Dim II As Integer = 0
        Dim GetRemoteHelpSQL as string = ""

        GetRemoteHelpSQL$ = GetRemoteHelpSQL$ + " Select [ScreenName]"
        GetRemoteHelpSQL$ = GetRemoteHelpSQL$ + " ,[HelpText]"
        GetRemoteHelpSQL$ = GetRemoteHelpSQL$ + " ,[WidgetName]"
        GetRemoteHelpSQL$ = GetRemoteHelpSQL$ + " ,[WidgetText]"
        GetRemoteHelpSQL$ = GetRemoteHelpSQL$ + " ,[DisplayHelpText]"
        GetRemoteHelpSQL$ = GetRemoteHelpSQL$ + " ,[LastUpdate]"
        GetRemoteHelpSQL$ = GetRemoteHelpSQL$ + " ,[CreateDate]"
        GetRemoteHelpSQL$ = GetRemoteHelpSQL$ + " ,[UpdatedBy]"
        GetRemoteHelpSQL$ = GetRemoteHelpSQL$ + " FROM [HelpText] "

        Dim KK As Integer = 0
        Dim rsRemoteHelp As SqlDataReader = Nothing
        'rsRemoteHelp = SqlQryNo'Session(S)
        rsRemoteHelp = DB.DBCreateDataReader(GetRemoteHelpSQL$, RemoteHelpConnStr)
        If rsRemoteHelp.HasRows Then
            Try
                Do While rsRemoteHelp.Read()
                    II = II + 1
                    KK += 1
                    'If II = 99 Then
                    '    Console.WriteLine("Here 00101 ")
                    'End If
                    ScreenName$ = gcStr(SecureID, rsRemoteHelp, 0)
                    HelpText$ = gcStr(SecureID, rsRemoteHelp, 1)
                    WidgetName$ = gcStr(SecureID, rsRemoteHelp, 2)
                    WidgetText$ = gcStr(SecureID, rsRemoteHelp, 3)
                    DisplayHelpText$ = gcStr(SecureID, rsRemoteHelp, 4)
                    If DisplayHelpText$.Equals("1") Then
                    ElseIf DisplayHelpText$.Equals("0") Then
                    ElseIf DisplayHelpText$.Equals("-1") Then
                    ElseIf UCase(DisplayHelpText).Equals("TRUE") Then
                        DisplayHelpText$ = "1"
                    Else
                        DisplayHelpText$ = "0"
                    End If
                    LastUpdate$ = gcStr(SecureID, rsRemoteHelp, 5)
                    CreateDate$ = gcStr(SecureID, rsRemoteHelp, 6)
                    UpdatedBy$ = gcStr(SecureID, rsRemoteHelp, 7)

                    Dim tKey$ = ScreenName$.Trim + Chr(254) + WidgetName
                    If slRemoteHelp.IndexOfKey(tKey) >= 0 Then
                    Else
                        slRemoteHelp.Add(tKey, CDate(LastUpdate))
                    End If
                Loop
            Catch ex As Exception
                BB = False
                'MsgBox("clsRemoteSupport:LoadRemoteSortedList - Failed to read help record for: " + ScreenName$ + ":" + WidgetName$ + ".")
                LOG.WriteToSqlLog("clsRemoteSupport:LoadRemoteSortedList - Failed to read help record for: " + ScreenName$ + ":" + WidgetName$ + ".")
            End Try

        End If
        rsRemoteHelp.Close()
        rsRemoteHelp = Nothing
        Return BB
    End Function
    Sub PushHelpToServer(ByVal SecureID As Integer)

        Dim BB As Boolean = ckRemoteConnection(SecureID)
        If Not BB Then
            Return
        End If

        LoadRemoteSortedList(SecureID)

        If RemoteHelpConnStr$.Trim.Length = 0 Then
            LOG.WriteToSqlLog("clsRemoteSupport:PushHelpToServer - Could not retrieve the CONNECTION STRING for the remote help server, aborting - contact an administrator.")
            Return
        End If

        Dim iCnt As Integer = 0
        iCnt = getCountLocalTable(SecureID, "helptext")

        Dim II As Integer = 0
        Dim S as string = ""

        S$ = S$ + " Select [ScreenName]"
        S$ = S$ + " ,[HelpText]"
        S$ = S$ + " ,[WidgetName]"
        S$ = S$ + " ,[WidgetText]"
        S$ = S$ + " ,[DisplayHelpText]"
        S$ = S$ + " ,[LastUpdate]"
        S$ = S$ + " ,[CreateDate]"
        S$ = S$ + " ,[UpdatedBy]"
        S$ = S$ + " FROM [HelpText] order by [LastUpdate] desc "

        Dim RSData As SqlDataReader = Nothing
        'RSData = SqlQryNo'Session(S)
        Dim CS$ = DBgetConnStr() : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(S, CONN) : RSData = command.ExecuteReader()
        If RSData.HasRows Then
            Try
                Do While RSData.Read()
                    II = II + 1
                    '** All of the below variables are public to the entire class
                    ScreenName$ = RSData.GetValue(0).ToString
                    HelpText$ = RSData.GetValue(1).ToString
                    WidgetName$ = RSData.GetValue(2).ToString
                    WidgetText$ = RSData.GetValue(3).ToString
                    DisplayHelpText$ = RSData.GetValue(4).ToString
                    LastUpdate$ = RSData.GetValue(5).ToString
                    CreateDate$ = RSData.GetValue(6).ToString
                    UpdatedBy$ = RSData.GetValue(7).ToString

                    publishRemoteHelpKey(SecureID, DisplayHelpText$, ScreenName$, WidgetName)
                Loop
            Catch ex As Exception
                'MsgBox("clsRemoteSupport:PushHelpToServer - Failed to read help record for: " + ScreenName$ + ":" + WidgetName$ + ".")
                LOG.WriteToSqlLog("clsRemoteSupport:PushHelpToServer - Failed to read help record for: " + ScreenName$ + ":" + WidgetName$ + ".")
            End Try

        End If
        RSData.Close()
        RSData = Nothing
        Dim msg as string = ""
        msg = "Upload Complete - Records Added: " + RecordsAdded.ToString
        msg = msg + ", Records Updated: " + RecordsUpdated.ToString
        msg = msg + ", Errors: " + ErrorCnt.ToString
        'WriteTraceLog(msg)
    End Sub
    ''' <summary>
    ''' Get value from Sql Data Reader Column as string
    ''' </summary>
    ''' <param name="rsRemoteHelp"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Function gcStr(ByVal SecureID As Integer, ByVal SDR As SqlDataReader, ByVal ColNbr As Integer) As String
        Dim tVal as string = ""
        Try
            'RSData.GetValue(7).ToString
            tVal = SDR.GetValue(ColNbr).ToString
        Catch ex As Exception
            tVal = ""
            Console.WriteLine(ex.ToString)
        End Try
        Return tVal
    End Function

    Function getCountLocalTable(ByVal SecureID As Integer, ByVal TableName as string) As Integer
        Dim iCnt As Integer = 0
        Dim S$ = "Select COUNT(*) from " + TableName$

        DB.DBCloseConn(SecureID)
        DB.DBCkConn(SecureID)
        Dim I As Integer = 0

        Dim rsColInfo As SqlDataReader = Nothing
        'rsColInfo = SqlQryNo'Session(S)
        rsColInfo = DB.DBCreateDataReader(SecureID, S)
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

    Function publishRemoteHelpKey(ByVal SecureID As Integer, ByVal DisplayHelpText as string, byval ScreenName as string, byval WidgetName as string)
        Dim BB As Boolean = False
        Dim B As Boolean = False

        Dim NowUser$ = LOG.getEnvVarUserID
        If UCase(DisplayHelpText).Equals("TRUE") Then
            DisplayHelpText = "1"
        Else
            DisplayHelpText = "0"
        End If

        B = ckRecordExists(SecureID, ScreenName$, WidgetName)
        If B Then
            B = ckRecordNeedsUpdating(SecureID, ScreenName$, WidgetName)
            If B Then
                '** Update the help
                '** Update the help
                Dim UpdateSql as string = ""
                UpdateSql$ = UpdateSql + " UPDATE [HelpText]"
                UpdateSql$ = UpdateSql + " SET "
                UpdateSql$ = UpdateSql + "  [HelpText] = '" + HelpText + "' "
                UpdateSql$ = UpdateSql + " ,[DisplayHelpText] = " + DisplayHelpText
                UpdateSql$ = UpdateSql + " ,[WidgetText] = '" + WidgetText + "'"
                UpdateSql$ = UpdateSql + " ,[LastUpdate] = '" + LastUpdate + "'"
                UpdateSql$ = UpdateSql + " ,[UpdatedBy] = '" + NowUser$ + "'"
                UpdateSql$ = UpdateSql + " WHERE "
                UpdateSql$ = UpdateSql + " ScreenName = '" + ScreenName + "' "
                UpdateSql$ = UpdateSql + " and WidgetName = '" + WidgetName + "' "

                BB = DB.DBExecuteSql(UpdateSql, RemoteHelpConnStr)
                If Not BB Then
                    LOG.WriteToSqlLog("frmHelpEditor : btnPushToServer_Click - Failed to update help record for: " + ScreenName$ + ":" + WidgetName$ + ".")
                    ErrorCnt += 1
                Else
                    RecordsUpdated += 1
                End If
            End If
        Else
            '** Insert the help
            'HELP.setDisplayhelptext(DisplayHelpText)
            'HELP.setHelptext(HelpText)
            'HELP.setLastupdate(Now.ToString)
            'HELP.setScreenname(ScreenName)
            'HELP.setUpdatedby(NowUser )
            'HELP.setWidgetname(WidgetName)
            'HELP.setWidgettext(WidgetText)
            'BB = HELP.InsertRemote(RemoteHelpConnStr )
            'If Not BB Then
            '    MsgBox("frmHelpEditor : btnPushToServer_Click - 005 Failed to ADD help record for: " + ScreenName$ + ":" + WidgetName$ + ".")
            '    LOG.WriteToSqlLog("frmHelpEditor : btnPushToServer_Click - 006 Failed to ADD help record for: " + ScreenName$ + ":" + WidgetName$ + ".")
            '    ErrorCnt += 1
            'Else
            '    RecordsAdded += 1
            'End If
        End If

        Return B

    End Function
    Function ckRecordExists(ByVal SecureID As Integer, ByVal ScreenName as string, byval WidgetName as string) As Boolean
        Dim B As Boolean = False
        Dim tKey$ = ScreenName.Trim + Chr(254) + WidgetName.Trim

        Dim I As Integer = slRemoteHelp.IndexOfKey(tKey)

        If I >= 0 Then
            B = True
        End If

        Return B
    End Function
    Function ckRecordNeedsUpdating(ByVal SecureID As Integer, ByVal ScreenName as string, byval WidgetName as string) As Boolean
        Dim B As Boolean = False
        Dim tKey$ = ScreenName.Trim + Chr(254) + WidgetName.Trim
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
    Sub PullHelpFromServer(ByVal SecureID As Integer)

        RecordsAdded = 0
        RecordsUpdated = 0
        ErrorCnt = 0
        'RemoteHelpConnStr$ = DB.getHelpConnStr()
        If RemoteHelpConnStr$.Trim.Length = 0 Then
            MsgBox("clsRemoteSupport:PullHelpFromServer - Could not retrieve the CONNECTION STRING for the remote help server, aborting - contact an administrator.")
            LOG.WriteToSqlLog("clsRemoteSupport:PullHelpFromServer - Failed to read help record for: " + ScreenName$ + ":" + WidgetName$ + ".")
            Return
        End If

        Dim BB As Boolean = ckRemoteConnection(SecureID)
        If Not BB Then
            Return
        End If

        LoadLocalSortedList(SecureID)

        Dim iCnt As Integer = 0
        iCnt = getCountLocalTable(SecureID, "helptext")

        Dim II As Integer = 0

        Dim RemoteSQL as string = ""
        RemoteSQL$ = RemoteSQL$ + " Select [ScreenName]"
        RemoteSQL$ = RemoteSQL$ + " ,[HelpText]"
        RemoteSQL$ = RemoteSQL$ + " ,[WidgetName]"
        RemoteSQL$ = RemoteSQL$ + " ,[WidgetText]"
        RemoteSQL$ = RemoteSQL$ + " ,[DisplayHelpText]"
        RemoteSQL$ = RemoteSQL$ + " ,[LastUpdate]"
        RemoteSQL$ = RemoteSQL$ + " ,[CreateDate]"
        RemoteSQL$ = RemoteSQL$ + " ,[UpdatedBy]"
        RemoteSQL$ = RemoteSQL$ + " FROM [HelpText] "
        Dim KK As Integer = 0
        Dim rsRemoteHelp As SqlDataReader = Nothing
        'rsRemoteHelp = SqlQryNo'Session(S)
        rsRemoteHelp = DB.DBCreateDataReader(RemoteSQL$, RemoteHelpConnStr)
        If rsRemoteHelp.HasRows Then
            Try
                Do While rsRemoteHelp.Read()
                    II = II + 1
                    KK += 1
                    '** All of the below variables are public to the entire class
                    ScreenName$ = rsRemoteHelp.GetValue(0).ToString
                    HelpText$ = rsRemoteHelp.GetValue(1).ToString
                    WidgetName$ = rsRemoteHelp.GetValue(2).ToString
                    WidgetText$ = rsRemoteHelp.GetValue(3).ToString
                    DisplayHelpText$ = rsRemoteHelp.GetValue(4).ToString
                    If DisplayHelpText$.Equals("1") Then
                    ElseIf DisplayHelpText$.Equals("0") Then
                    ElseIf DisplayHelpText$.Equals("-1") Then
                    ElseIf UCase(DisplayHelpText).Equals("TRUE") Then
                        DisplayHelpText$ = "1"
                    Else
                        DisplayHelpText$ = "0"
                    End If
                    LastUpdate$ = rsRemoteHelp.GetValue(5).ToString
                    CreateDate$ = rsRemoteHelp.GetValue(6).ToString
                    UpdatedBy$ = rsRemoteHelp.GetValue(7).ToString

                    publishLocalHelpKey(SecureID, ScreenName, WidgetName)

                Loop
            Catch ex As Exception
                MsgBox("frmHelpEditor : btnPushToServer_Click - Failed to read help record for: " + ScreenName$ + ":" + WidgetName$ + ".")
                LOG.WriteToSqlLog("frmHelpEditor : btnPushToServer_Click - Failed to read help record for: " + ScreenName$ + ":" + WidgetName$ + ".")
            End Try

        End If
        rsRemoteHelp.Close()
        rsRemoteHelp = Nothing

        Dim Msg as string = ""
        Msg = "HELP Download Complete - RecordsAdded: " + RecordsAdded.ToString
        Msg = Msg + ", RecordsUpdated: " + RecordsUpdated.ToString
        Msg = Msg + ", Errors: " + ErrorCnt.ToString
        'WriteTraceLog(Msg)
    End Sub

    Function LoadLocalSortedList(ByVal SecureID As Integer) As Boolean
        Dim BB As Boolean = True

        Try
            slRemoteHelp.Clear()

            Dim iCnt As Integer = 0
            iCnt = getCountLocalTable(SecureID, "helptext")

            Dim II As Integer = 0
            Dim S as string = ""

            S$ = S$ + " Select [ScreenName]"
            S$ = S$ + " ,[HelpText]"
            S$ = S$ + " ,[WidgetName]"
            S$ = S$ + " ,[WidgetText]"
            S$ = S$ + " ,[DisplayHelpText]"
            S$ = S$ + " ,[LastUpdate]"
            S$ = S$ + " ,[CreateDate]"
            S$ = S$ + " ,[UpdatedBy]"
            S$ = S$ + " FROM [HelpText] "
            Dim KK As Integer = 0
            Dim RSData As SqlDataReader = Nothing

            Dim CS$ = getRemoteHelpConnString(SecureID) : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(S, CONN) : RSData = command.ExecuteReader()
            If RSData.HasRows Then
                Try
                    Do While RSData.Read()
                        II = II + 1
                        KK = KK + 1
                        ScreenName$ = RSData.GetValue(0).ToString
                        HelpText$ = RSData.GetValue(1).ToString
                        WidgetName$ = RSData.GetValue(2).ToString
                        WidgetText$ = RSData.GetValue(3).ToString
                        DisplayHelpText$ = RSData.GetValue(4).ToString
                        If DisplayHelpText$.Equals("1") Then
                        ElseIf DisplayHelpText$.Equals("0") Then
                        ElseIf DisplayHelpText$.Equals("-1") Then
                        ElseIf UCase(DisplayHelpText).Equals("TRUE") Then
                            DisplayHelpText$ = "1"
                        Else
                            DisplayHelpText$ = "0"
                        End If
                        LastUpdate$ = RSData.GetValue(5).ToString
                        CreateDate$ = RSData.GetValue(6).ToString
                        UpdatedBy$ = RSData.GetValue(7).ToString

                        Dim tKey$ = ScreenName$.Trim + Chr(254) + WidgetName
                        If slRemoteHelp.IndexOfKey(tKey) >= 0 Then
                        Else
                            slRemoteHelp.Add(tKey, CDate(LastUpdate))
                        End If
                    Loop
                Catch ex As Exception
                    'MsgBox("clsRemoteSupport:LoadLocalSortedList - Failed to read help record for: " + ScreenName$ + ":" + WidgetName$ + ".")
                    LOG.WriteToSqlLog("clsRemoteSupport:LoadLocalSortedList - Failed to read help record for: " + ScreenName$ + ":" + WidgetName$ + ".")
                    BB = False
                End Try

            End If
            RSData.Close()
            RSData = Nothing
        Catch ex As Exception
            LOG.WriteToSqlLog("clsRemoteSupport : LoadLocalSortedList 100 " + ex.Message)
        End Try

        Return BB

    End Function

    Function publishLocalHelpKey(ByVal SecureID As Integer, ByVal ScreenName as string, byval WidgetName as string)
        If UCase(DisplayHelpText).Equals("TRUE") Then
            DisplayHelpText = "1"
        Else
            DisplayHelpText = "0"
        End If
        Dim B As Boolean = False

        B = ckRecordExists(SecureID, ScreenName, WidgetName)
        Dim BB As Boolean = False
        Dim NowUser$ = LOG.getEnvVarUserID
        'HELP.setUpdatedby(NowUser )
        If B Then
            B = ckRecordNeedsUpdating(SecureID, ScreenName, WidgetName)
            If B Then
                '** Update the help
                Dim UpdateSql as string = ""
                UpdateSql$ = UpdateSql + " UPDATE [HelpText]" + vbCrLf
                UpdateSql$ = UpdateSql + " SET " + vbCrLf
                UpdateSql$ = UpdateSql + "  [HelpText] = '" + HelpText + "' " + vbCrLf
                UpdateSql$ = UpdateSql + " ,[DisplayHelpText] = " + DisplayHelpText + vbCrLf
                UpdateSql$ = UpdateSql + " ,[WidgetText] = '" + WidgetText + "' " + vbCrLf
                UpdateSql$ = UpdateSql + " ,[LastUpdate] = '" + LastUpdate + "'" + vbCrLf
                UpdateSql$ = UpdateSql + " ,[UpdatedBy] = '" + NowUser$ + "'" + vbCrLf
                UpdateSql$ = UpdateSql + " WHERE " + vbCrLf
                UpdateSql$ = UpdateSql + " ScreenName = '" + ScreenName + "' " + vbCrLf
                UpdateSql$ = UpdateSql + " and WidgetName = '" + WidgetName + "' "

                BB = DB.DBExecuteSql(UpdateSql, False)
                If Not BB Then
                    log.WriteToSqlLog("frmHelpEditor : btnPushToServer_Click - Failed to update help record for: " + ScreenName$ + ":" + WidgetName$ + ".")
                    ErrorCnt += 1
                Else
                    RecordsUpdated += 1
                End If
            End If
        Else
            '** Insert the help
            'HELP.setDisplayhelptext(DisplayHelpText)
            'HELP.setHelptext(HelpText)
            'HELP.setLastupdate(Now.ToString)
            'HELP.setScreenname(ScreenName)
            'HELP.setUpdatedby(NowUser )
            'HELP.setWidgetname(WidgetName)
            'HELP.setWidgettext(WidgetText)
            'BB = HELP.Insert
            'If Not BB Then
            '    'ErrorCnt += 1
            '    'MsgBox("frmHelpEditor : btnPushToServer_Click - 007 Failed to ADD help record for: " + ScreenName$ + ":" + WidgetName$ + ".")
            '    log.WriteToSqlLog("frmHelpEditor : btnPushToServer_Click - 008 Failed to ADD help record for: " + ScreenName$ + ":" + WidgetName$ + ".")
            'Else
            '    RecordsAdded += 1
            'End If
        End If

        Return B

    End Function

    Sub UpdateHooverHelp(ByVal SecureID As Integer)
        RecordsAdded = 0
        RecordsUpdated = 0
        ErrorCnt = 0
        'RemoteHelpConnStr$ = DB.getHelpConnStr()
        If RemoteHelpConnStr$.Trim.Length = 0 Then
            MsgBox("clsRemoteSupport:UpdateHooverHelp - Could not retrieve the CONNECTION STRING for the remote help server, aborting - contact an administrator.")
            log.WriteToSqlLog("clsRemoteSupport:UpdateHooverHelp - Could not retrieve the CONNECTION STRING for the remote help server, aborting - contact an administrator.")
            Return
        End If

        Dim BB As Boolean = ckRemoteConnection(SecureID)
        If Not BB Then
            MsgBox("Update Hoover Help Failed to connect to remote server.")
            Return
        End If

        LoadLocalSortedList(SecureID)

        Dim iCnt As Integer = 0
        iCnt = getCountLocalTable(SecureID, "helptext")

        Dim II As Integer = 0

        Dim RemoteSQL as string = ""
        RemoteSQL$ = RemoteSQL$ + " Select [ScreenName]"
        RemoteSQL$ = RemoteSQL$ + " ,[HelpText]"
        RemoteSQL$ = RemoteSQL$ + " ,[WidgetName]"
        RemoteSQL$ = RemoteSQL$ + " ,[WidgetText]"
        RemoteSQL$ = RemoteSQL$ + " ,[DisplayHelpText]"
        RemoteSQL$ = RemoteSQL$ + " ,[LastUpdate]"
        RemoteSQL$ = RemoteSQL$ + " ,[CreateDate]"
        RemoteSQL$ = RemoteSQL$ + " ,[UpdatedBy]"
        RemoteSQL$ = RemoteSQL$ + " FROM [HelpText] "
        Dim KK As Integer = 0
        Dim rsRemoteHelp As SqlDataReader = Nothing
        'rsRemoteHelp = SqlQryNo'Session(S)
        rsRemoteHelp = DB.DBCreateDataReader(RemoteSQL$, RemoteHelpConnStr)
        If rsRemoteHelp.HasRows Then
            Try
                Do While rsRemoteHelp.Read()
                    II = II + 1
                    KK += 1

                    '** All of the below variables are public to the entire class
                    ScreenName$ = rsRemoteHelp.GetValue(0).ToString
                    HelpText$ = rsRemoteHelp.GetValue(1).ToString
                    WidgetName$ = rsRemoteHelp.GetValue(2).ToString
                    WidgetText$ = rsRemoteHelp.GetValue(3).ToString
                    DisplayHelpText$ = rsRemoteHelp.GetValue(4).ToString
                    If DisplayHelpText$.Equals("1") Then
                    ElseIf DisplayHelpText$.Equals("0") Then
                    ElseIf DisplayHelpText$.Equals("-1") Then
                    ElseIf UCase(DisplayHelpText).Equals("TRUE") Then
                        DisplayHelpText$ = "1"
                    Else
                        DisplayHelpText$ = "0"
                    End If

                    LastUpdate$ = rsRemoteHelp.GetValue(5).ToString
                    CreateDate$ = rsRemoteHelp.GetValue(6).ToString
                    UpdatedBy$ = rsRemoteHelp.GetValue(7).ToString

                    publishLocalHelpKey(SecureID, ScreenName, WidgetName)
                Loop
            Catch ex As Exception
                MsgBox("frmHelpEditor : btnPushToServer_Click - Failed to read help record for: " + ScreenName$ + ":" + WidgetName$ + ".")
                log.WriteToSqlLog("frmHelpEditor : btnPushToServer_Click - Failed to read help record for: " + ScreenName$ + ":" + WidgetName$ + ".")
            End Try

        End If
        rsRemoteHelp.Close()
        rsRemoteHelp = Nothing
        Dim Msg as string = ""
        Msg = "Hoover Help Download Complete - RecordsAdded: " + RecordsAdded.ToString
        Msg = Msg + ", RecordsUpdated: " + RecordsUpdated.ToString
        Msg = Msg + ", Errors: " + ErrorCnt.ToString

    End Sub

    Function getClientLicenseServer(ByVal SecureID As Integer, ByVal CompanyID as string, byval LicenseID as string) As String
        Dim ClientLicenseServer as string = ""
        Try
            Dim S$ = "Select MachineID, Applied from license where CompanyID = '" + CompanyID + "' and LicenseID = " + LicenseID
            Dim I As Integer = 0
            Dim rsColInfo As SqlDataReader = Nothing

            rsColInfo = DB.DBCreateDataReader(S, RemoteHelpConnStr)
            If rsColInfo.HasRows Then
                rsColInfo.Read()
                ClientLicenseServer$ = rsColInfo.GetValue(0).ToString
            End If

            If Not rsColInfo.IsClosed Then
                rsColInfo.Close()
            End If
            If Not rsColInfo Is Nothing Then
                rsColInfo = Nothing
            End If
            GC.Collect()
            GC.WaitForFullGCApproach()
            Return ClientLicenseServer$
        Catch ex As Exception
            log.WriteToSqlLog("getClientLicenseServer: Failed to retrieve Server ID:" + vbCrLf + ex.Message)
        End Try

        Return ClientLicenseServer$

    End Function

    Function getAvailClientLicenseServerName(ByVal SecureID As Integer, ByVal CompanyID as string) As String
        Dim ClientLicenseServer as string = ""
        Dim isApplied As Boolean = False
        Dim B As Boolean = False
        Try
            Dim S$ = "Select MachineID, Applied from license where CompanyID = '" + CompanyID + "'"
            Dim I As Integer = 0
            Dim rsColInfo As SqlDataReader = Nothing

            rsColInfo = DB.DBCreateDataReader(S, RemoteHelpConnStr)
            If rsColInfo.HasRows Then
                Do While rsColInfo.Read()
                    ClientLicenseServer$ = rsColInfo.GetValue(0).ToString
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
            Return ClientLicenseServer$
        Catch ex As Exception
            log.WriteToSqlLog("getClientLicenseServer: Failed to retrieve Server ID:" + vbCrLf + ex.Message)
        End Try

        Return ClientLicenseServer$

    End Function

    Function setClientLicenseServer(ByVal SecureID As Integer, ByVal CompanyID as string, byval LicenseID as string, byval MachineID as string) As Boolean
        Dim ClientLicenseServer as string = ""
        Dim B As Boolean = False
        Try
            Dim S$ = "Update License set MachineID = '" + MachineID + "' "
            S = S + "where CompanyID = '" + CompanyID + "' and LicenseID = " + LicenseID
            B = DB.DBExecuteSql(SecureID, S, RemoteHelpConnStr$, False)
            GC.Collect()
            GC.WaitForFullGCApproach()
        Catch ex As Exception
            log.WriteToSqlLog("setClientLicenseServer: Failed to set Server ID:" + vbCrLf + ex.Message)
        End Try
        Return B
        Return ClientLicenseServer$

    End Function

    Function getClientLicenses(ByVal SecureID As Integer, ByVal CompanyID as string, byref ErrorMessage As String, ByRef RC As Boolean) As List(Of DS_License)

        Dim L As New DS_License
        Dim ListRows As New List(Of DS_License)

        Dim ClientLicenseServerD As String = ""
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
            Dim S As String = "Select " + vbCrLf
            S = S + " CompanyID," + vbCrLf
            S = S + " MachineID," + vbCrLf
            S = S + " LicenseId," + vbCrLf
            S = S + " Applied," + vbCrLf
            S = S + " PurchasedMachines," + vbCrLf
            S = S + " PurchasedUsers," + vbCrLf
            S = S + " SupportActive," + vbCrLf
            S = S + " SupportActiveDate," + vbCrLf
            S = S + " SupportInactiveDate," + vbCrLf
            S = S + " LicenseText," + vbCrLf
            S = S + " LicenseTypeCode," + vbCrLf
            S = S + " EncryptedLicense, ServerNAME, SqlInstanceName" + vbCrLf
            S = S + " from License	" + vbCrLf
            S = S + " where CompanyID = '" + CompanyID + "' " + vbCrLf
            Dim I As Integer = 0
            Dim rsColInfo As SqlDataReader = Nothing

            rsColInfo = DB.DBCreateDataReader(S, RemoteHelpConnStr)
            If rsColInfo.HasRows Then
                Do While rsColInfo.Read()
                    L.CompanyID = rsColInfo.GetValue(0).ToString
                    L.MachineID = rsColInfo.GetValue(1).ToString
                    L.LicenseID = rsColInfo.GetValue(2).ToString
                    L.Applied = rsColInfo.GetValue(3).ToString
                    L.PurchasedMachines = rsColInfo.GetValue(4).ToString
                    L.PurchasedUsers = rsColInfo.GetValue(5).ToString
                    L.SupportActive = rsColInfo.GetValue(6).ToString
                    L.SupportActiveDate = rsColInfo.GetValue(7).ToString
                    L.SupportInactiveDate = rsColInfo.GetValue(8).ToString
                    L.LicenseText = rsColInfo.GetValue(9).ToString
                    L.LicenseTypeCode = rsColInfo.GetValue(10).ToString$
                    L.EncryptedLicense = rsColInfo.GetValue(11).ToString$
                    L.ServerNAME = rsColInfo.GetValue(12).ToString$
                    L.SqlInstanceName = rsColInfo.GetValue(13).ToString$
                    ListRows.Add(L)
                Loop
            Else
                MsgBox("License not found, please insure the required Company ID and other information is correct.")
            End If

            If Not rsColInfo.IsClosed Then
                rsColInfo.Close()
            End If
            If Not rsColInfo Is Nothing Then
                rsColInfo = Nothing
            End If
            GC.Collect()
            GC.WaitForFullGCApproach()
            LOG.WriteToSqlLog("getClientLicenses: Retrieve Server license:" + Now.ToString)
            RC = True
        Catch ex As Exception
            LOG.WriteToSqlLog("getClientLicenses: Failed to retrieve Server data:" + vbCrLf + ex.Message)
            RC = False
        End Try

        Return ListRows

    End Function
    Function ckCompanyID(ByVal SecureID As Integer, ByVal CompanyID as string) As Boolean
        Dim ClientLicenseServer as string = ""
        Dim B As Boolean = False
        Dim I As Integer = 0
        Try
            Dim S$ = "Select count(*) from license "
            S = S + "where CompanyID = '" + CompanyID + "'"
            'B = DB.DBExecuteSql(SecureID, S, RemoteHelpConnStr$, false)

            Dim rsColInfo As SqlDataReader = Nothing

            rsColInfo = DB.DBCreateDataReader(S, RemoteHelpConnStr)
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
            log.WriteToSqlLog("setClientLicenseServer: Failed to set Server ID:" + vbCrLf + ex.Message)
        End Try
        Return B
    End Function
    Function getClientLicense(ByVal SecureID As Integer, ByVal CompanyID as string, byval LicenseID as string) As String
        Dim ServerLicense as string = ""
        Try
            Dim S$ = "Select EncryptedLicense from license where CompanyID = '" + CompanyID + "' and LicenseID = " + LicenseID
            Dim I As Integer = 0
            Dim rsColInfo As SqlDataReader = Nothing

            rsColInfo = DB.DBCreateDataReader(S, RemoteHelpConnStr)
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
            LOG.WriteToSqlLog("getClientLicenseServer: Failed to retrieve Server ID:" + vbCrLf + ex.Message)
        End Try

        Return ServerLicense

    End Function
    Function getLicenseServerName(ByVal SecureID As Integer, ByVal CompanyID as string, byref ServerName As String, ByRef SqlInstanceName As String) As Boolean
        Dim B As Boolean = False
        Try
            Dim S$ = "Select MachineID, ServerName, SqlInstanceName from license "
            S = S + " where CompanyID = '" + CompanyID$ + "'"
            S = S + " and ServerName = '" + ServerName + "' "
            S = S + " and SqlInstanceName = '" + SqlInstanceName + "' "
            Dim I As Integer = 0
            Dim rsColInfo As SqlDataReader = Nothing

            rsColInfo = DB.DBCreateDataReader(S, RemoteHelpConnStr)
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
            LOG.WriteToSqlLog("getClientLicenseServer: Failed to retrieve Server ID:" + vbCrLf + ex.Message)
        End Try

        Return B

    End Function
    'Function ckRemoteConnection(SecureID) As Boolean
    '    Dim ClientLicenseServer as string = ""
    '    Dim B As Boolean = false
    '    Dim I As Integer = 0
    '    Try
    '        Dim S$ = "Select count(*) from license "
    '        Dim rsColInfo As SqlDataReader = Nothing

    '        rsColInfo = DB.DBCreateDataReader(S, RemoteHelpConnStr )
    '        If rsColInfo.HasRows Then
    '            rsColInfo.Read()
    '            I = rsColInfo.GetInt32(0)
    '        End If

    '        B = True

    '        GC.Collect()
    '        GC.WaitForFullGCApproach()
    '    Catch ex As Exception
    '        log.WriteToSqlLog("setClientLicenseServer: Failed to set Server ID:" + vbCrLf + ex.Message)
    '    End Try
    '    Return B
    'End Function


End Class
