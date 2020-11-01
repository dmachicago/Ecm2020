Imports System.Data.SqlClient
Imports System.Data.Sql
Imports System.IO
Imports System.Collections
Imports System.Collections.Generic
Imports System.IO.Compression
Imports ECMEncryption
Imports System.Data

Public Class clsDbDownload

    Dim DB As clsDatabase()
    Dim TimeOutSecs As String = "360"
    Dim gConnStr As String = ""
    Dim gConn As New SqlConnection

    Dim CS As String = ""

    Dim ENC As New ECMEncrypt

    Private Property ID As String

    Sub load()
        CS = gFetchCS()
    End Sub

    Function getFileExt(ByVal FQN As String) As String

        FQN = FQN.ToUpper.Trim
        Dim fExt As String = "UKN"

        For i As Integer = FQN.Length To 1 Step -1
            Dim CH As String = Mid(FQN, i, 1)
            If CH.Equals(".") Then
                fExt = Mid(FQN, i + 1)
                Exit For
            End If
        Next
        Return fExt
    End Function
    Function getFileName(ByVal FQN As String) As String

        FQN = FQN.ToUpper.Trim
        Dim fName As String = "UKN"

        For i As Integer = FQN.Length To 1 Step -1
            Dim CH As String = Mid(FQN, i, 1)
            If CH.Equals("\") Then
                fName = Mid(FQN, i + 1)
                Exit For
            End If
        Next

        Return fName
    End Function

    Public Sub getFileParameters(ByVal TgtGuid As String, ByRef FileName As String, ByRef fExt As String, ByVal TgtTable As String, ByRef RC As Boolean)

        RC = True
        fExt = "UKN"
        FileName = ""

        Dim CS As String = gFetchCS()

        Dim iCnt As Integer = -1
        Dim fName As String = ""

        Try
            Dim S As String = ""

            If TgtTable.ToUpper.Equals("EMAIL") Then
                S = "select SourceTypeCode from email where EmailGuid = '" + TgtGuid + "'"
            ElseIf TgtTable.ToUpper.Equals("EMAILATTACHMENT") Then
                S = "select AttachmentName from EmailAttachment where RowID = '" + TgtGuid + "'"
            ElseIf TgtTable.ToUpper.Equals("CONTENT") Then
                S = "select SourceName from DataSource where SourceGuid = '" + TgtGuid + "'"
            End If

            Dim CN As New SqlConnection(CS)

            Dim RSData As SqlDataReader = Nothing
            'RSData = SqlQryNo'Session(S)

            Dim CONN As New SqlConnection(CS)
            CONN.Open()
            Dim command As New SqlCommand(S, CONN)
            RSData = command.ExecuteReader()

            If RSData.HasRows Then
                Do While RSData.Read()
                    FileName = RSData.GetValue(0).ToString
                    If TgtTable.ToUpper.Equals("EMAIL") Then
                        FileName = "EMAIL." + TgtGuid + "." + FileName
                    End If
                    If InStr(FileName, "\") > 0 Then
                        FileName = getFileName(FileName)
                    End If
                    fExt = getFileExt(FileName)
                Loop
            End If
            RSData.Close()
            RSData = Nothing
            CONN.Dispose()

            CN.Close()
            CN = Nothing
            GC.Collect()
            GC.WaitForPendingFinalizers()

        Catch ex As Exception
            iCnt = -1
            RC = False
            Dim AppName$ = ex.Source
            WriteToSqlLog("clsDatabase : getFileParameters : 4803 : " + ex.Message)

        End Try

    End Sub

    Sub getPreviewFileSourceGuid(ByVal UserID As String, ByRef RetGuids As Dictionary(Of String, String), ByRef RC As Boolean, SessionID As String)

        RetGuids.Clear()

        RC = True
        UserID = UserID.Replace("''", "'")
        UserID = UserID.Replace("'", "''")

        Dim SourceTblName As String = "RestoreQueue"
        Dim iCnt As Integer = -1
        Dim ContentGuid As String = ""
        Dim ContentType As String = ""
        Dim RowGuid As String = ""

        Dim AllGuids As String = ""

        Try
            Dim S As String = "select ContentGuid, ContentType, RowGuid from [RestoreQueue] where UserID = '" + UserID + "' and Preview = 1 "

            Dim CN As New SqlConnection(CS)

            Dim RSData As SqlDataReader = Nothing
            'RSData = SqlQryNo'Session(S)
            'Dim CS As String = getRepoConnStr()
            Dim CONN As New SqlConnection(CS)
            CONN.Open()
            Dim command As New SqlCommand(S, CONN)
            RSData = command.ExecuteReader()
            If RSData.HasRows Then
                Do While RSData.Read()
                    ContentGuid = RSData.GetValue(0).ToString
                    ContentType = RSData.GetValue(1).ToString
                    RowGuid = RSData.GetValue(2).ToString
                    If Not RetGuids.ContainsKey(ContentGuid) Then
                        RetGuids.Add(ContentGuid, ContentType)
                        AllGuids += "'" + RowGuid + "'" + ","
                    End If
                Loop
            End If
            RSData.Close()
            RSData = Nothing
            CONN.Dispose()
            GC.Collect()

            CN.Close()
            CN = Nothing
            GC.Collect()

        Catch ex As Exception
            iCnt = -1
            RC = False
            Dim AppName$ = ex.Source
            WriteToSqlLog("ERROR clsDatabase : getPreviewFileSourceGuid : 4803 : " + ex.Message)
            RC = False
        Finally
            If AllGuids.Trim.Length > 0 Then
                Dim RetMSg As String = ""
                AllGuids = "(" + AllGuids
                AllGuids = AllGuids.Substring(0, AllGuids.Length - 1) + ")"
                Dim tSql As String = "Update [RestoreQueue] set StartDownloadTime = getdate() where RowGuid in " + AllGuids
                Dim B As Boolean = ExecuteSqlNewConn(995611, UserID, tSql, RetMSg, SessionID)
            End If
        End Try

    End Sub

    Sub getRestoreFileSourceGuid(ByVal UserID As String, ByRef RetGuids As Dictionary(Of String, String), ByRef RC As Boolean, SessionID As String)

        RetGuids.Clear()

        RC = True
        UserID = UserID.Replace("''", "'")
        UserID = UserID.Replace("'", "''")

        Dim SourceTblName As String = "RestoreQueue"
        Dim iCnt As Integer = -1
        Dim ContentGuid As String = ""
        Dim ContentType As String = ""
        Dim AllGuids As String = ""
        Dim RowGuid As String = ""
        Try
            Dim S As String = "select ContentGuid, ContentType, RowGuid from [RestoreQueue] where UserID = '" + UserID + "' and [Restore] = 1 "

            Dim CN As New SqlConnection(CS)

            Dim RSData As SqlDataReader = Nothing
            'RSData = SqlQryNo'Session(S)
            Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(S, CONN) : RSData = command.ExecuteReader()
            If RSData.HasRows Then
                Do While RSData.Read()
                    ContentGuid = RSData.GetValue(0).ToString
                    ContentType = RSData.GetValue(1).ToString
                    RowGuid = RSData.GetValue(2).ToString
                    If Not RetGuids.ContainsKey(ContentGuid) Then
                        RetGuids.Add(ContentGuid, ContentType)
                        AllGuids += "'" + RowGuid + "'" + ","
                    End If
                Loop
            End If
            RSData.Close()
            RSData = Nothing
            CONN.Dispose()
            GC.Collect()

            CN.Close()
            CN = Nothing
            GC.Collect()

        Catch ex As Exception
            iCnt = -1
            RC = False
            Dim AppName$ = ex.Source
            WriteToSqlLog("clsDatabase : getPreviewFileSourceGuid : 4803 : " + ex.Message)
            RC = False
        Finally
            If AllGuids.Trim.Length > 0 Then
                Dim RetMSg As String = ""
                AllGuids = "(" + AllGuids
                AllGuids = AllGuids.Substring(0, AllGuids.Length - 1) + ")"
                Dim tSql As String = "Update [RestoreQueue] set StartDownloadTime = getdate() where RowGuid in " + AllGuids
                Dim B As Boolean = ExecuteSqlNewConn(995612, UserID, tSql, RetMSg, SessionID)
            End If
        End Try

    End Sub

    Public Function ckPreviewFileToProcess(ByVal UserID As String, RC As Boolean) As Integer

        RC = True
        UserID = UserID.Replace("''", "'")
        UserID = UserID.Replace("'", "''")


        Dim SourceTblName As String = "RestoreQueue"
        Dim iCnt As Integer = -1

        Try
            Dim S$ = "select count(*) as iCnt from [RestoreQueue] where Preview = 1  and UserID = '" + UserID + "' "

            Dim CN As New SqlConnection(CS)

            If CN.State = ConnectionState.Closed Then
                CN.Open()
            End If

            Dim da As New SqlDataAdapter(S, CN)
            Dim MyCB As SqlCommandBuilder = New SqlCommandBuilder(da)
            Dim ds As New DataSet()

            da.Fill(ds, SourceTblName)
            Dim myRow As DataRow
            myRow = ds.Tables(SourceTblName).Rows(0)

            iCnt = myRow("iCnt")

            MyCB = Nothing
            ds = Nothing
            da = Nothing

            CN.Close()
            CN = Nothing
            GC.Collect()

        Catch ex As Exception
            iCnt = -1
            RC = False
            Dim AppName$ = ex.Source
            WriteToSqlLog("clsDatabase : ckFilesToProcess : 4803 : " + ex.Message)
            RC = False
        End Try

        Return iCnt

    End Function
    Function ckRestoreFilesToProcess(ByVal UserID As String, ByRef RC As Boolean) As Integer

        RC = True
        UserID = UserID.Replace("''", "'")
        UserID = UserID.Replace("'", "''")


        Dim SourceTblName As String = "RestoreQueue"
        Dim iCnt As Integer = -1

        Try
            Dim S$ = "select count(*) as iCnt from [RestoreQueue] where [Restore] = 1  and UserID = '" + UserID + "' "

            Dim CN As New SqlConnection(CS)

            If CN.State = ConnectionState.Closed Then
                CN.Open()
            End If

            Dim da As New SqlDataAdapter(S, CN)
            Dim MyCB As SqlCommandBuilder = New SqlCommandBuilder(da)
            Dim ds As New DataSet()

            da.Fill(ds, SourceTblName)
            Dim myRow As DataRow
            myRow = ds.Tables(SourceTblName).Rows(0)

            iCnt = myRow("iCnt")

            MyCB = Nothing
            ds = Nothing
            da = Nothing

            CN.Close()
            CN = Nothing
            GC.Collect()

        Catch ex As Exception
            iCnt = -1
            RC = False
            Dim AppName$ = ex.Source
            WriteToSqlLog("clsDatabase : ckFilesToProcess : 4803 : " + ex.Message)
            RC = False
        End Try

        Return iCnt

    End Function
    ''' <summary>
    ''' 
    ''' </summary>
    ''' <param name="SourceGuid">The Source GUID to download</param>
    ''' <param name="FQN">The returned name of the selected file including the file extension.</param>
    ''' <param name="CompressedDataBuffer">The buffer to receive the compressed binary file data</param>
    ''' <param name="OriginalSize">the Original size fo the file</param>
    ''' <param name="CompressedSize">the Compressed size fo the file</param>
    ''' <param name="RC">True indicates success, False indicates failure</param>
    ''' <remarks></remarks>
    Sub writeImageSourceDataFromDbWriteToFile(ByVal SourceGuid As String, ByRef FQN As String, ByRef CompressedDataBuffer() As Byte, ByRef OriginalSize As Integer, ByRef CompressedSize As Integer, ByRef RC As Boolean, ByRef rMsg As String)


        FQN = ""
        Dim B As Boolean = True
        Dim SourceTblName As String = "DataSource"
        Dim ImageFieldName As String = "SourceImage"

        Try
            Dim S$ = ""
            S = S + " SELECT " + vbCrLf
            S = S + " FQN, SourceImage " + vbCrLf
            S = S + " FROM  [DataSource]" + vbCrLf
            S = S + " where [SourceGuid] = '" + SourceGuid$ + "'" + vbCrLf

            Dim CN As New SqlConnection(CS)

            If CN.State = ConnectionState.Closed Then
                CN.Open()
            End If

            Dim da As New SqlDataAdapter(S, CN)
            Dim MyCB As SqlCommandBuilder = New SqlCommandBuilder(da)
            Dim ds As New DataSet()

            da.Fill(ds, SourceTblName)
            Dim myRow As DataRow
            myRow = ds.Tables(SourceTblName).Rows(0)

            FQN = myRow("FQN")
            Try
                If myRow(ImageFieldName) Is Nothing Then
                    rMsg = FQN + " : missing the binary data, please reload."
                    WriteToSqlLog("ERROR 003 : writeImageSourceDataFromDbWriteToFile " + FQN + " : missing the binary data, please reload.")
                    MyCB = Nothing
                    ds = Nothing
                    da = Nothing

                    CN.Close()
                    CN = Nothing
                    GC.Collect()
                    RC = B
                    Return
                Else
                    CompressedDataBuffer = myRow(ImageFieldName)
                End If
            Catch ex As Exception
                rMsg = FQN + " : missing the binary data, please reload."
                WriteToSqlLog("ERROR 003 : writeImageSourceDataFromDbWriteToFile " + FQN + " : missing the binary data, please reload.")
                MyCB = Nothing
                ds = Nothing
                da = Nothing

                CN.Close()
                CN = Nothing
                GC.Collect()
                RC = B
                Return
            End Try



            If CompressedDataBuffer.Length = 0 Then
                RC = False
                CompressedDataBuffer = Nothing
                WriteToSqlLog("ERROR 004 : writeImageSourceDataFromDbWriteToFile " + FQN + " : missing the binary data, please reload.")
                Return
            End If

            OriginalSize = CompressedDataBuffer.Length

            Dim gzBuffer() As Byte = Compress(CompressedDataBuffer)

            CompressedDataBuffer = gzBuffer

            MyCB = Nothing
            ds = Nothing
            da = Nothing

            CN.Close()
            CN = Nothing
            GC.Collect()
        Catch ex As Exception
            rMsg = ex.Message
            B = False
            Dim AppName$ = ex.Source
            WriteToSqlLog("clsDatabase : writeImageSourceDataFromDbWriteToFile : 4757 : " + ex.Message)
            WriteToSqlLog("0007 writeImageSourceDataFromDbWriteToFile ")
        End Try

        RC = B

    End Sub

    Sub writeAttachmentFromDbWriteToFile(ByVal RowID As String, ByRef FQN As String, ByRef CompressedDataBuffer() As Byte, ByRef OriginalSize As Integer, ByRef CompressedSize As Integer, ByRef RC As Boolean, ByRef rMsg As String)

        FQN = ""
        Dim B As Boolean = True
        Dim SourceTblName As String = "EmailAttachment"
        Dim ImageFieldName As String = "Attachment"

        Try
            Dim S$ = ""
            S = S + " SELECT " + vbCrLf
            S = S + " AttachmentName, Attachment " + vbCrLf
            S = S + " FROM  [EmailAttachment]" + vbCrLf
            S = S + " where [RowID] = " + RowID + vbCrLf

            Dim CN As New SqlConnection(CS)

            If CN.State = ConnectionState.Closed Then
                CN.Open()
            End If

            Dim da As New SqlDataAdapter(S, CN)
            Dim MyCB As SqlCommandBuilder = New SqlCommandBuilder(da)
            Dim ds As New DataSet()

            da.Fill(ds, SourceTblName)
            Dim myRow As DataRow
            myRow = ds.Tables(SourceTblName).Rows(0)

            FQN = myRow("AttachmentName")
            CompressedDataBuffer = myRow(ImageFieldName)

            If CompressedDataBuffer.Length = 0 Then
                RC = False
                Return
            End If

            FQN = myRow("AttachmentName")

            OriginalSize = CompressedDataBuffer.Length

            Dim gzBuffer() As Byte = Compress(CompressedDataBuffer)

            CompressedDataBuffer = gzBuffer

            MyCB = Nothing
            ds = Nothing
            da = Nothing

            CN.Close()
            CN = Nothing
            GC.Collect()
            RC = True
        Catch ex As Exception
            rMsg = ex.Message
            Dim AppName$ = ex.Source
            WriteToSqlLog("clsDatabase : writeAttachmentFromDbWriteToFile : 4803 : " + ex.Message)
            RC = False
        End Try

    End Sub

    Sub writeEmailFromDbToFile(ByVal EmailGuid As String, ByRef SourceTypeCode As String, ByRef CompressedDataBuffer() As Byte, ByRef OriginalSize As Integer, ByRef CompressedSize As Integer, ByRef RC As Boolean, ByRef rMsg As String)


        Dim SourceTable As String = "Email"
        Dim ImageFieldName As String = "EmailImage"
        Try
            'CloseConn() 
            CkConn()

            Dim S$ = ""
            S = S + " SELECT " + vbCrLf
            S = S + " SourceTypeCode, EmailImage " + vbCrLf
            S = S + " FROM  [Email]" + vbCrLf
            S = S + " where [EmailGuid] = '" + EmailGuid + "'" + vbCrLf


            ExtendTimeoutBySize(CS, 0)
            Dim CN As New SqlConnection(CS)

            If CN.State = ConnectionState.Closed Then
                CN.Open()
            End If

            Dim da As New SqlDataAdapter(S, CN)
            Dim MyCB As SqlCommandBuilder = New SqlCommandBuilder(da)
            Dim ds As New DataSet()

            da.Fill(ds, SourceTable)
            Dim myRow As DataRow
            myRow = ds.Tables(SourceTable).Rows(0)

            Dim MyData() As Byte
            MyData = myRow(ImageFieldName)
            SourceTypeCode = myRow("SourceTypeCode")
            CompressedDataBuffer = myRow(ImageFieldName)

            If CompressedDataBuffer.Length = 0 Then
                rMsg = "File appears to be zero length in repository - GUID: " + EmailGuid
                RC = False
                Return
            End If

            OriginalSize = CompressedDataBuffer.Length

            Dim gzBuffer() As Byte = Compress(CompressedDataBuffer)

            CompressedDataBuffer = gzBuffer

            MyCB = Nothing
            ds = Nothing
            da = Nothing

            CN.Close()
            CN = Nothing
            GC.Collect()
            RC = True
        Catch ex As Exception
            Dim AppName$ = ex.Source
            WriteToSqlLog("clsDatabase : writeEmailFromDbToFile : 4879 : " + ex.Message)
            rMsg = "clsDatabase : writeEmailFromDbToFile : 4879 : " + ex.Message
            RC = False
        End Try

    End Sub

    Public Sub setRepoConnStr()
        gConnStr = gFetchCS()
    End Sub

    Public Function getRepoConnStr() As String
        Return gFetchCS()
    End Function

    Public Sub WriteToSqlLog(ByVal Msg As String)
        Try
            'Dim cPath As String = GetCurrDir()        
            Dim cPath As String = getTempEnvironDir()
            'Dim tFQN$ = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"

            Dim TempFolder$ = getEnvVarSpecialFolderApplicationData()
            Dim M$ = Now.Month.ToString.Trim
            Dim D$ = Now.Day.ToString.Trim
            Dim Y$ = Now.Year.ToString.Trim

            Dim SerialNo$ = M + "." + D + "." + Y + "."

            Dim tFQN$ = TempFolder$ + "\ECMLibrary.Event.Log." + SerialNo$ + "txt"
            ' Create an instance of StreamWriter to write text to a file.
            Using sw As StreamWriter = New StreamWriter(tFQN, True)
                ' Add some text to the file.                                    
                sw.WriteLine(Now.ToString + ": " + Msg + vbCrLf)
                sw.Close()
            End Using
        Catch ex As Exception
            Console.WriteLine("clsDma : WriteToSqlLog : 688 : " + ex.Message)
        End Try
    End Sub
    Function getTempEnvironDir() As String
        Return getEnvVarSpecialFolderApplicationData()
    End Function
    Public Function getEnvVarSpecialFolderApplicationData() As String
        Return Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData)
    End Function

    Sub setConnectionStringTimeout(ByRef ConnStr As String, ByVal TimeOutSecs As String)

        Dim I As Integer = 0
        Dim S$ = ""
        Dim NewConnStr$ = ""
        S = ConnStr
        I = InStr(1, S, "Connect Timeout =", CompareMethod.Text)
        If I > 0 Then
            Dim SqlTimeout$ = TimeOutSecs
            If SqlTimeout$.Trim.Length = 0 Then
                Return
            Else
                I = I + "Connect Timeout =".Length
                NewConnStr$ = setNewTimeout(ConnStr$, I, TimeOutSecs)
            End If
        Else
            NewConnStr = S
            NewConnStr$ += "; Connect Timeout = " + TimeOutSecs + ";"
        End If

        GC.Collect()
        GC.WaitForFullGCApproach()
        ConnStr = NewConnStr$
    End Sub

    Function setNewTimeout(ByVal tgtStr As String, ByVal StartingPoint As Integer, ByVal NewVal As String) As String
        Dim NextNumber$ = ""
        Dim NumberStartPos As Integer = 0
        Dim NumberEndPos As Integer = 0
        Dim NewStr$ = ""
        Dim S1$ = ""
        Dim S2$ = ""
        Try
            Dim I As Integer = 0
            Dim CH$ = Mid(tgtStr, StartingPoint, 1)
            Dim bFound As Boolean = False
            Do Until InStr("0123456789", CH) > 0 Or StartingPoint > tgtStr$.Length
                StartingPoint += 1
                CH$ = Mid(tgtStr, StartingPoint, 1)
                bFound = True
            Loop
            If Not bFound Then
                Return tgtStr$
            Else
                NumberStartPos = StartingPoint
                NumberEndPos = StartingPoint
                Do Until InStr("0123456789", CH) = 0 Or NumberEndPos >= tgtStr$.Length
                    NumberEndPos += 1
                    CH$ = Mid(tgtStr, NumberEndPos, 1)
                Loop
            End If
            Dim CurrVal$ = Mid(tgtStr, NumberStartPos, NumberEndPos - NumberStartPos + 1)
            S1$ = Mid(tgtStr, 1, NumberStartPos - 1)
            S2$ = Mid(tgtStr, NumberEndPos + 1)
            NewStr$ = S1 + " " + NewVal + " " + S2
        Catch ex As Exception
            WriteToSqlLog("FindNextNumberInStr: " + ex.Message)
            NewStr$ = tgtStr$
        End Try
        Return NewStr$
    End Function

    Public Sub CkConn()
        If gConn Is Nothing Then
            Try
                gConn = New SqlConnection
                gConn.ConnectionString = getRepoConnStr()
                gConn.Open()
            Catch ex As Exception
                MsgBox("ERROR CkConn 100: " + ex.Message)
                WriteToSqlLog("clsDatabase : CkConn : 338 : " + ex.Message)
            End Try
        End If
        If gConn.State = Data.ConnectionState.Closed Then
            Try
                gConn.ConnectionString = getRepoConnStr()
                gConn.Open()
            Catch ex As Exception
                WriteToSqlLog("clsDatabase : CkConn : 348.1 : " + ex.Message)
            End Try
        End If
    End Sub

    Public Shared Function Compress(ByVal BufferToCompress As Byte()) As Byte()
        Dim ms As New MemoryStream()
        Dim zip As New GZipStream(ms, CompressionMode.Compress, True)
        zip.Write(BufferToCompress, 0, BufferToCompress.Length)
        zip.Close()
        ms.Position = 0

        Dim outStream As New MemoryStream()

        Dim compressed As Byte() = New Byte(ms.Length - 1) {}
        ms.Read(compressed, 0, compressed.Length)

        Dim gzBuffer As Byte() = New Byte(compressed.Length + 3) {}
        Buffer.BlockCopy(compressed, 0, gzBuffer, 4, compressed.Length)
        Buffer.BlockCopy(BitConverter.GetBytes(BufferToCompress.Length), 0, gzBuffer, 0, 4)
        Return gzBuffer
    End Function

    Public Shared Function Decompress(ByVal BufferToDecompress As Byte()) As Byte()
        Dim ms As New MemoryStream()
        Dim msgLength As Integer = BitConverter.ToInt32(BufferToDecompress, 0)
        ms.Write(BufferToDecompress, 4, BufferToDecompress.Length - 4)

        Dim buffer As Byte() = New Byte(msgLength - 1) {}

        ms.Position = 0
        Dim zip As New GZipStream(ms, CompressionMode.Decompress)
        zip.Read(buffer, 0, buffer.Length)

        Return buffer
    End Function

    Sub ExtendTimeoutBySize(ByRef ConnectionString As String, ByVal currFileSize As Double)

        Dim NewTimeOut As Double = 30

        If currFileSize > 1000000 And currFileSize < 2000000 Then
            NewTimeOut = 90
        ElseIf currFileSize >= 2000000 And currFileSize < 5000000 Then
            NewTimeOut = 180
        ElseIf currFileSize >= 5000000 And currFileSize < 10000000 Then
            NewTimeOut = 360
        ElseIf currFileSize >= 10000000 Then
            NewTimeOut = 600
        Else
            Return
        End If


        Dim InsertConnStr As String = ConnectionString
        Dim S1$ = ""
        Dim II As Integer = InStr(InsertConnStr, "Connect Timeout", CompareMethod.Text)
        If II > 0 Then
            II = InStr(II + 5, InsertConnStr, "=")
            If II > 0 Then
                Dim K As Integer = InStr(II + 1, InsertConnStr, ";")
                If K > 0 Then
                    Dim S2$ = ""
                    '** The connect time is delimited with a semicolon
                    S1 = Mid(InsertConnStr, 1, II + 1)
                    S2 = Mid(InsertConnStr, K)
                    S1 = S1 + NewTimeOut.ToString + S2
                    InsertConnStr = S1
                Else
                    '** The connect time is NOT delimited with a semicolon
                    S1 = Mid(InsertConnStr, 1, II + 1)
                    S1 = S1 + NewTimeOut.ToString
                    InsertConnStr = S1
                End If
            End If
        End If

    End Sub

    Public Function cleanRestoreQue(SecureID As Int32, SourceGuid As String, UserID As String, SessionID As String, ByRef RetMsg As String) As Boolean
        Dim MySql As String = "DELETE from RestoreQueue where ContentGuid = '" + SourceGuid + "' and UserID = '" + UserID + "'"
        Dim BX As Boolean = ExecuteSqlNewConn(99611, UserID, MySql, RetMsg, SessionID)
        Return BX
    End Function

    Public Function ExecuteSqlNewConn(ByVal LocationID As Integer, ByVal UserID As String, ByVal MySql As String, ByRef RetMsg As String, SessionID As String) As Boolean
        RetMsg = ""

        Dim ErrMsg As String = ""
        Dim txStartTime As Date = Now
        Dim rc As Boolean = False
        Dim CN As New SqlConnection(Me.getRepoConnStr)
        CN.Open()
        Dim dbCmd As SqlCommand = CN.CreateCommand()
        Dim BB As Boolean = True
        Try
            Using CN
                dbCmd.Connection = CN
                Try
                    dbCmd.CommandText = MySql
                    dbCmd.ExecuteNonQuery()
                    BB = True
                Catch ex As Exception
                    rc = False
                    RetMsg = "Location LocationID: " & LocationID & " UID: " & UserID & " : " & ex.Message
                End Try
            End Using
        Catch ex As Exception
            BB = False
            RetMsg = "ERROR" + MySql + " vbcrlf + ex.Message"
        Finally
            If CN IsNot Nothing Then
                If CN.State = ConnectionState.Open Then
                    CN.Close()
                End If

                CN = Nothing
            End If
            dbCmd = Nothing
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try

        Return BB
    End Function
End Class
