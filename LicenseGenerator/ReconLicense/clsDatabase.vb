'Imports Microsoft.VisualBasic

Imports System.Data.SqlClient
Imports System.IO
'Imports System.Configuration.ConfigurationSettings

'Imports System.Web.Configuration
'Imports System.Windows.Forms
'Imports System.Windows.Forms.MessageBoxOptions
'Imports System.Web.UI.Page
'' <summary>
'' clsDatabase: A set of standard utilities to perform repetitive database tasks through a public class
'' Copyright @ DMA, Limited, Chicago, IL., June 2003, all rights reserved. Licensed on a use only
'' basis for clients of DMA, Limited.
'' </summary>
'' <remarks></remarks>
Public Class clsDatabase
    'Inherits System.Web.UI.Page

    Dim CF As New clsFile

    '** Public ConnectionStringID As String = "XOMR1.1ConnectionString"
    '** Do not forget that this is a global access var to thte DB
    '** and MUST be changed to run on different platforms.
    Public ConnectionStringID As String = ""

    Public ServerName$ = ""

    Public slProjects As New SortedList
    Public slProjectTeams As New SortedList
    Public slMetricPeriods As New SortedList
    Public slExcelColNames As New SortedList
    Public slGrowthPlatform As New SortedList
    Public slOperatingGroup As New SortedList
    Public slOperatingUnit As New SortedList
    Public slGeography As New SortedList
    Public slGeographicUnit As New SortedList
    Public slClientServiceGroup As New SortedList
    Public slDeliveryCenter As New SortedList
    Public slTypeOfWork As New SortedList
    Public slProjectTeamTypeOfWork As New SortedList
    Public slSubmissionStatus As New SortedList
    Public slSubmittedBy As New SortedList
    Public EL As New ArrayList

    Public TblCols$(4, 0)

    ' Dim owner As IWin32Window
    Dim gConnStr As String = ""

    Dim DBDIR As String = "C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Data\org_db.mdf"
    Dim DQ$ = Chr(34)
    Private CurrUserGuidID$ = ""
    Private CurrUserPW$ = ""
    Dim gConn As New SqlConnection
    Dim DMA As New clsDma

    'Sub New()
    '     LoadColInfo()
    'End Sub

    Function CkColData(ByVal TblName$, ByVal ColName$, ByVal tData$) As String
        Dim xData$ = ""
        Dim K As Integer
        Dim CurrLen As Integer = tData.Length
        Dim MaxLen As Integer = 0
        Dim table_name$ = ""
        Dim column_name$ = ""
        Dim data_type$ = ""
        Dim character_maximum_length As Integer = 0
        Dim B As Boolean = False

        For K = 1 To UBound(TblCols, 2)
            table_name$ = UCase(TblCols(0, K))
            column_name$ = UCase(TblCols(1, K))
            data_type$ = TblCols(2, K)
            character_maximum_length = Val(TblCols(3, K))
            If table_name.Equals(UCase(TblName)) Then
                If column_name$.Equals(UCase(ColName)) Then
                    B = True
                    xData = tData
                    Exit For
                End If
            End If
        Next
        If B Then
            If character_maximum_length < CurrLen Then
                'tData$ = Mid(tData, 1, MaxLen)
                xData = Mid(tData, 1, character_maximum_length)
                ''Session("ErrMsgs") = 'Session("ErrMsgs") + "<br>" + "" + ColName + " > " + Str(character_maximum_length) + " characters - truncated."
            Else
                xData = tData
            End If
        End If
        Return xData
    End Function

    ''' <summary>
    ''' LoadColInfo reads table_name, column_name, data_type, character_maximum_length from INFORMATION_SCHEMA.COLUMNS.
    ''' </summary>
    ''' <remarks></remarks>
    Sub LoadColInfo()

        Dim S = ""
        S = S + " select table_name, column_name, data_type, character_maximum_length  "
        S = S + " from INFORMATION_SCHEMA.COLUMNS "
        'S = S + " where table_name = 'Project' "
        S = S + " order by table_name, column_name"

        Dim b As Boolean = True
        Dim i As Integer = 0
        Dim id As Integer = -1
        Dim II As Integer = 0
        Dim table_name$ = ""
        Dim column_name$ = ""
        Dim data_type$ = ""
        Dim character_maximum_length$ = ""

        If UBound(TblCols, 2) > 2 Then
            Return
        End If

        ReDim TblCols$(4, 0)

        Dim rsColInfo As SqlDataReader = Nothing
        'rsColInfo = SqlQryNo'Session(S)
        rsColInfo = SqlQry(S)
        If rsColInfo.HasRows Then
            Do While rsColInfo.Read()
                table_name = rsColInfo.GetValue(0).ToString
                column_name = rsColInfo.GetValue(1).ToString
                data_type = rsColInfo.GetValue(2).ToString
                character_maximum_length = rsColInfo.GetValue(3).ToString
                II = UBound(TblCols, 2) + 1
                ReDim Preserve TblCols(4, II)
                TblCols(0, II) = table_name
                TblCols(1, II) = column_name
                TblCols(2, II) = data_type
                TblCols(3, II) = character_maximum_length
            Loop
        Else
            id = -1
        End If
        rsColInfo.Close()
        rsColInfo = Nothing

    End Sub

    ''' <summary>
    ''' LoadColInfo reads table_name, column_name, data_type, character_maximum_length from
    ''' INFORMATION_SCHEMA.COLUMNS based on the provided Table Name.
    ''' </summary>
    ''' <param name="TableName">The name of the table to retrieve column information about.</param>
    ''' <remarks></remarks>
    Sub LoadColInfo(ByVal TableName$)

        Dim S = ""
        S = S + " select table_name, column_name, data_type, character_maximum_length  "
        S = S + " from INFORMATION_SCHEMA.COLUMNS "
        S = S + " where table_name = '" + TableName + "' "
        S = S + " order by table_name, column_name"

        Dim b As Boolean = True
        Dim i As Integer = 0
        Dim id As Integer = -1
        Dim II As Integer = 0
        Dim table_name$ = ""
        Dim column_name$ = ""
        Dim data_type$ = ""
        Dim character_maximum_length$ = ""

        If UBound(TblCols, 2) > 2 Then
            Return
        End If

        ReDim TblCols$(4, 0)

        Dim rsColInfo As SqlDataReader = Nothing
        'rsColInfo = SqlQryNo'Session(S)
        rsColInfo = SqlQry(S)
        If rsColInfo.HasRows Then
            Do While rsColInfo.Read()
                table_name = rsColInfo.GetValue(0).ToString
                column_name = rsColInfo.GetValue(1).ToString
                data_type = rsColInfo.GetValue(2).ToString
                character_maximum_length = rsColInfo.GetValue(3).ToString
                II = UBound(TblCols, 2) + 1
                ReDim Preserve TblCols(4, II)
                TblCols(0, II) = table_name
                TblCols(1, II) = column_name
                TblCols(2, II) = data_type
                TblCols(3, II) = character_maximum_length
            Loop
        Else
            id = -1
        End If
        rsColInfo.Close()
        rsColInfo = Nothing

    End Sub

    Sub Audit(ByVal sql$, ByVal UserID$)
        Dim i As Integer = 0
        Dim j As Integer = 0
        Dim S = sql.Trim

        Dim Tbl As String = GetTableNameFromSql(sql)
        'Dim wc As String = GetWhereClauseFromSql(sql)
        Dim TypeStmt As String = GetTypeSqlStmt(sql)

        Tbl = UCase(Tbl)

        sql$ = DMA.RemoveSingleQuotes(sql$)
        Dim A$() = Split(sql, " ")

        CurrUserGuidID$ = UserID

        Dim b As Boolean = AuditInsert(Date.Today.ToString, CurrUserGuidID$, sql$, Tbl, TypeStmt, Now())

        If Not b Then
            Console.WriteLine("Audit Failed: " + sql)
        End If

    End Sub

    Public Function ckNull(ByVal tVal$) As String
        If tVal.Trim.Length = 0 Then
            Return "null"
        Else
            Return tVal
        End If
    End Function

    Public Function AuditInsert(ByVal ChangeID$, ByVal UserID$, ByVal SqlStmt$, ByVal TableName$, ByVal TypeChange$, ByVal ChangeDate$) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        s = s + " INSERT INTO audit("
        s = s + "UserID,"
        s = s + "SqlStmt,"
        s = s + "TableName,"
        s = s + "TypeChange,"
        s = s + "ChangeDate, ChangeID) values ("
        s = s + "'" + UserID + "'" + ","
        s = s + "'" + SqlStmt + "'" + ","
        s = s + "'" + TableName + "'" + ","
        s = s + "'" + TypeChange + "'" + ","
        s = s + "'" + ChangeDate + "',"
        s = s + "'" + ChangeID$ + "'" + ")"

        b = ExecuteSqlNoAudit(s)

        If Not b Then
            Console.WriteLine("Audit Failed: " + s)
        End If

        Return b

    End Function

    Public Function AddNulls(ByVal tSql$) As String
        Dim i As Integer = 0
        Dim j As Integer = 0

        Do While InStr(tSql, ",,", CompareMethod.Text) > 0
            i = InStr(tSql, ",,", CompareMethod.Text)
            j = i + 1
            Dim s1 = Mid(tSql, 1, i)
            Dim s2 = Mid(tSql, i + 1)
            tSql = s1 + "null" + s2
        Loop
        Do While InStr(tSql, ",)", CompareMethod.Text) > 0
            i = InStr(tSql, ",)", CompareMethod.Text)
            j = i + 1
            Dim s1 = Mid(tSql, 1, i)
            Dim s2 = Mid(tSql, i + 1)
            tSql = s1 + "null" + s2
        Loop
        Do While InStr(tSql, "=)", CompareMethod.Text) > 0
            i = InStr(tSql, "=)", CompareMethod.Text)
            j = i + 1
            Dim s1 = Mid(tSql, 1, i)
            Dim s2 = Mid(tSql, i + 1)
            tSql = s1 + "null" + s2
        Loop
        Do While InStr(tSql, "= ,", CompareMethod.Text) > 0
            i = InStr(tSql, "= ,", CompareMethod.Text)
            j = i + 1
            Dim s1 = Mid(tSql, 1, i)
            Dim s2 = Mid(tSql, i + 2)
            tSql = s1 + "null" + s2
        Loop
        Do While InStr(tSql, "= )", CompareMethod.Text) > 0
            i = InStr(tSql, "= )", CompareMethod.Text)
            j = i + 1
            Dim s1 = Mid(tSql, 1, i)
            Dim s2 = Mid(tSql, i + 2)
            tSql = s1 + "null" + s2
        Loop
        Return tSql
    End Function

    Public Function AddNullsToUpdate(ByVal tSql$) As String
        Dim i As Integer = 0
        Dim j As Integer = 0

        Do While InStr(tSql, "= ,", CompareMethod.Text) > 0
            i = InStr(tSql, "= ,", CompareMethod.Text)
            j = i + 1
            Dim s1 = Mid(tSql, 1, i)
            Dim s2 = Mid(tSql, i + 2)
            tSql = s1 + "null" + s2
        Loop
        Do While InStr(tSql, "= )", CompareMethod.Text) > 0
            i = InStr(tSql, "= )", CompareMethod.Text)
            j = i + 1
            Dim s1 = Mid(tSql, 1, i)
            Dim s2 = Mid(tSql, i + 2)
            tSql = s1 + "null" + s2
        Loop

        Do While InStr(tSql, "=,", CompareMethod.Text) > 0
            i = InStr(tSql, "=,", CompareMethod.Text)
            j = i + 1
            Dim s1 = Mid(tSql, 1, i)
            Dim s2 = Mid(tSql, i + 1)
            tSql = s1 + "null" + s2
        Loop
        Do While InStr(tSql, "=)", CompareMethod.Text) > 0
            i = InStr(tSql, "=)", CompareMethod.Text)
            j = i + 1
            Dim s1 = Mid(tSql, 1, i)
            Dim s2 = Mid(tSql, i + 1)
            tSql = s1 + "null" + s2
        Loop

        Return tSql
    End Function

    Public Function ckDbConnection() As Boolean
        Dim b As Boolean = False
        Try
            If gConn Is Nothing Then
                Try
                    gConn.ConnectionString = getConnStr()
                    gConn.Open()
                    b = True
                Catch ex As Exception
                    Console.WriteLine("Error 121.25.1")
                    Console.WriteLine(ex.Source)
                    Console.WriteLine(ex.StackTrace)
                    Console.WriteLine(ex.Message)
                    b = False
                End Try
            End If
            If gConn.State = Data.ConnectionState.Closed Then
                Try
                    gConn.ConnectionString = getConnStr()
                    gConn.Open()
                    b = True
                Catch ex As Exception
                    Console.WriteLine("Error 121.25.2")
                    Console.WriteLine(ex.Source)
                    Console.WriteLine(ex.StackTrace)
                    Console.WriteLine(ex.Message)
                    b = False
                End Try
            End If
        Catch ex As Exception
            Console.WriteLine("Error 121.25.3")
            Console.WriteLine(ex.Source)
            Console.WriteLine(ex.StackTrace)
            Console.WriteLine(ex.Message)
            b = False
        End Try
        Return b
    End Function

    Public Sub setConnStr()

        Dim reader As New System.Configuration.AppSettingsReader

        If gCurrServerType = "local" Then
            gConnStr = reader.GetValue("DMA_UD_License", GetType(String))
        ElseIf gCurrServerType = "remote" Then
            gConnStr = reader.GetValue("LicenseServer", GetType(String))
        Else
            gConnStr = reader.GetValue("DMA_UD_License", GetType(String))
        End If


    End Sub

    Public Function getConnStr() As String
        setConnStr()
        Return gConnStr
    End Function

    'Public Sub setUidx(ByVal uid$)
    '    CurrUserGuidID = uid
    'End Sub
    Public Sub setpW(ByVal tVal$)
        CurrUserPW = tVal
    End Sub

    Public Function GetConnection() As SqlConnection
        CkConn()
        Return gConn
    End Function

    Public Function getSqlAdaptor(ByVal Sql$) As SqlDataAdapter
        CkConn()
        Dim sSelect$ = Sql
        Dim da As New SqlDataAdapter(sSelect, gConn)
        'da.MissingSchemaAction = MissingSchemaAction.AddWithKey
        Dim cmd As New SqlCommandBuilder(da)
        Return da
    End Function

    Public Sub CkConn()

        Dim connstr As String = getConnStr()

        If gConn.State = ConnectionState.Open Then
            gConn.Close()
        End If

        If gConn Is Nothing Then
            Try
                gConn = New SqlConnection
                gConn.ConnectionString = getConnStr()
                gConn.Open()
            Catch ex As Exception
                Console.WriteLine("Error 121.21")
                Console.WriteLine(ex.Source)
                Console.WriteLine(ex.StackTrace)
                Console.WriteLine(ex.Message)
            End Try
        End If
        If gConn.State = Data.ConnectionState.Closed Then
            Try
                gConn.ConnectionString = getConnStr()
                gConn.Open()
            Catch ex As Exception
                Console.WriteLine("Error 121.21")
                Console.WriteLine(ex.Source)
                Console.WriteLine(ex.StackTrace)
                Console.WriteLine(ex.Message)
            End Try
        End If
    End Sub

    Public Sub CkConn(ByVal wdm)
        If gConn Is Nothing Then
            Try
                gConn.ConnectionString = getConnStr()
                gConn.Open()
            Catch ex As Exception
                Console.WriteLine("Error 121.21")
                Console.WriteLine(ex.Source)
                Console.WriteLine(ex.StackTrace)
                Console.WriteLine(ex.Message)
            End Try
        End If
        If gConn.State = Data.ConnectionState.Closed Then
            Try
                gConn.ConnectionString = getConnStr()
                gConn.Open()
            Catch ex As Exception
                Console.WriteLine("Error 121.21")
                Console.WriteLine(ex.Source)
                Console.WriteLine(ex.StackTrace)
                Console.WriteLine(ex.Message)
            End Try
        End If
    End Sub

    Public Sub ResetConn()
        If gConn Is Nothing Then
            Try
                gConn.ConnectionString = getConnStr()
                gConn.Open()
            Catch ex As Exception
                Console.WriteLine("Error 121.21")
                Console.WriteLine(ex.Source)
                Console.WriteLine(ex.StackTrace)
                Console.WriteLine(ex.Message)
            End Try
        Else
            If gConn.State = Data.ConnectionState.Open Then
                gConn.Close()
            End If
            Try
                gConn.ConnectionString = getConnStr()
                gConn.Open()
            Catch ex As Exception
                Console.WriteLine("Error 121.21")
                Console.WriteLine(ex.Source)
                Console.WriteLine(ex.StackTrace)
                Console.WriteLine(ex.Message)
            End Try
        End If
        If gConn.State = Data.ConnectionState.Closed Then
            Try
                gConn.ConnectionString = getConnStr()
                gConn.Open()
            Catch ex As Exception
                Console.WriteLine("Error 121.21")
                Console.WriteLine(ex.Source)
                Console.WriteLine(ex.StackTrace)
                Console.WriteLine(ex.Message)
            End Try
        End If
    End Sub

    Public Function iGetRowCount(ByVal sql As String) As Integer

        Dim tQuery As String = ""
        Dim s1 As String = ""
        Dim s2 As String = ""
        Dim s3 As String = ""
        Dim queryString As String = sql

        CkConn()

        Dim i As Integer
        Dim cnt As Integer = -1

        i = InStr(sql, "select", CompareMethod.Text)
        If i > 0 Then
            s1 = "select count(*) as CNT from"
            i = InStr(sql, " from", CompareMethod.Text)
            If i > 0 Then
                s2 = Mid(sql, i + 5)
                s2 = Trim(s2)
                i = InStr(1, s2, " ")
                If i > 0 Then
                    s2 = Mid(s2, 1, i)
                    s2 = Trim(s2)
                End If
            Else
                Return -1
            End If
        Else
            Return -1
        End If

        sql = s1 + " " + s2

        Using gConn
            'Console.WriteLine(gConnStr)

            Dim command As New SqlCommand(sql, gConn)

            Dim rsCnt As SqlDataReader = Nothing
            rsCnt = SqlQry(sql)
            ' Call Read before accessing data.
            rsCnt.Read()
            cnt = rsCnt.GetInt32(0)
            'Dim ss As String = ""
            'ss = rsCnt.GetValue(0).ToString
            'cnt = rsCnt.Item(0)
            rsCnt.Close()
            rsCnt = Nothing
            command.Connection.Close()
            command = Nothing
        End Using

        Return cnt

    End Function

    Public Function iDataExist(ByVal sql As String) As Integer

        Dim tQuery As String = ""
        Dim s1 As String = ""
        Dim s2 As String = ""
        Dim s3 As String = ""
        Dim queryString As String = sql

        CkConn()

        Dim cnt As Integer = 0

        Using gConn
            'Console.WriteLine(gConnStr)

            Dim command As New SqlCommand(sql, gConn)

            Dim rsCnt As SqlDataReader = Nothing
            rsCnt = SqlQry(sql)
            ' Call Read before accessing data.
            rsCnt.Read()
            cnt = rsCnt.GetInt32(0)
            'Dim ss As String = ""
            'ss = rsCnt.GetValue(0).ToString
            'cnt = rsCnt.Item(0)
            rsCnt.Close()
            rsCnt = Nothing
            command.Connection.Close()
            command = Nothing
        End Using

        Return cnt

    End Function

    Public Function iGetMaxRowNbrFromXml() As Integer

        Dim tQuery As String = ""
        Dim s1 As String = ""
        Dim s2 As String = ""
        Dim s3 As String = ""
        Dim tSql$ = " select max(RowNbr) from InitialLoadData"

        CkConn()

        Dim cnt As Integer = 1

        Using gConn
            'Console.WriteLine(gConnStr)

            Dim command As New SqlCommand(tSql, gConn)

            Dim rsCnt As SqlDataReader = Nothing
            rsCnt = SqlQry(tSql)
            ' Call Read before accessing data.
            rsCnt.Read()
            cnt = rsCnt.GetInt32(0)
            'Dim ss As String = ""
            'ss = rsCnt.GetValue(0).ToString
            'cnt = rsCnt.Item(0)
            rsCnt.Close()
            rsCnt = Nothing
            command.Connection.Close()
            command = Nothing
        End Using

        Return cnt

    End Function

    Public Function getOneVal(ByVal sql As String) As String

        Dim tVal As String = sql

        CkConn()

        Dim cnt As Integer = -1

        Using gConn
            Dim command As New SqlCommand(sql, gConn)
            Dim rsCnt As SqlDataReader = Nothing
            rsCnt = SqlQry(sql)
            rsCnt.Read()
            tVal = rsCnt.GetValue(0).ToString
            rsCnt.Close()
            rsCnt = Nothing
            command.Connection.Close()
            command = Nothing
        End Using

        Return tVal

    End Function

    Public Function ckEmailExists(ByVal SenderEmailAddress, ByVal ReceivedByName, ByVal ReceivedTime, ByVal SenderName, ByVal SentOn) As Boolean
        Dim tQuery As String = ""
        Dim S As String = ""

        S = S + " SELECT [SenderEmailAddress]     "
        S = S + " ,[ReceivedByName]"
        S = S + " ,[ReceivedTime]     "
        S = S + " ,[SenderName]"
        S = S + " ,[SentOn]"
        S = S + " FROM [DMA.UD].[dbo].[Email]"
        S = S + " where [UserID] = 'wmiller'"
        S = S + " and [SenderEmailAddress] = 'XXX'"
        S = S + " and [ReceivedByName] = 'XXX'"
        S = S + " and [ReceivedTime] = '2008-01-10 12:22:06.000'"
        S = S + " and [SenderName] = 'XXX'"
        S = S + " and [SentOn] = '2008-01-10 12:19:14.000'"

        CkConn()

        Dim cnt As Integer = -1
        Dim cmd As New SqlCommand(S, gConn)
        Dim rsCnt As SqlDataReader = Nothing

        Using gConn
            rsCnt = SqlQry(S)
            rsCnt.Read()
            cnt = rsCnt.GetInt32(0)
            rsCnt.Close()
            rsCnt = Nothing
            cmd.Connection.Close()
            cmd = Nothing
        End Using
        If Not rsCnt Is Nothing Then
            rsCnt = Nothing
        End If
        If Not cmd Is Nothing Then
            cmd = Nothing
        End If
        If cnt > 0 Then
            Return True
        Else
            Return False
        End If
    End Function

    Public Function ckEmailGuidExists(ByVal EmailGuid) As Integer

        Dim S As String = ""

        S = S + " SELECT count(*) from Email where EmailGuid = '" + EmailGuid + "'"

        CkConn()

        Dim cnt As Integer = -1
        Dim cmd As New SqlCommand(S, gConn)
        Dim rsCnt As SqlDataReader = Nothing

        Using gConn
            rsCnt = SqlQry(S)
            rsCnt.Read()
            cnt = rsCnt.GetInt32(0)
            rsCnt.Close()
            rsCnt = Nothing
            cmd.Connection.Close()
            cmd = Nothing
        End Using
        If Not rsCnt Is Nothing Then
            rsCnt = Nothing
        End If
        If Not cmd Is Nothing Then
            cmd = Nothing
        End If
        Return cnt
    End Function

    Public Function ckContentGuidExists(ByVal SourceGuid) As Integer

        Dim S As String = ""

        S = S + " SELECT count(*) from DataSource where SourceGuid = '" + SourceGuid + "'"

        CkConn()

        Dim cnt As Integer = -1
        Dim cmd As New SqlCommand(S, gConn)
        Dim rsCnt As SqlDataReader = Nothing

        Using gConn
            rsCnt = SqlQry(S)
            rsCnt.Read()
            cnt = rsCnt.GetInt32(0)
            rsCnt.Close()
            rsCnt = Nothing
            cmd.Connection.Close()
            cmd = Nothing
        End Using
        If Not rsCnt Is Nothing Then
            rsCnt = Nothing
        End If
        If Not cmd Is Nothing Then
            cmd = Nothing
        End If
        Return cnt
    End Function

    Public Sub IncrementNextID()
        CkConn()
        Dim S = "update [NextIdNbr] set IdNbr = IdNbr + 1 "
        Dim b As Boolean = Me.ExecuteSql(S)
    End Sub

    Public Function SetFolderAsActive(ByVal FolderName$, ByVal sAction$) As Boolean
        Dim SS As String = " "
        SS = "update [DMA.UD].[dbo].[EmailFolder] set [SelectedForArchive] = '" + sAction$ + "' where FolderName = '" + FolderName$ + "'"
        Dim b As Boolean = Me.ExecuteSql(SS)
        Return b
    End Function

    Public Function getNextID() As Integer
        Dim tQuery As String = ""
        Dim S As String = "SELECT max([IdNbr]) FROM [NextIdNbr] "

        CkConn()

        Dim cnt As Integer = -1

        Using gConn
            Dim command As New SqlCommand(S, gConn)
            Dim rsCnt As SqlDataReader = Nothing
            rsCnt = SqlQry(S)
            rsCnt.Read()
            cnt = rsCnt.GetInt32(0)
            rsCnt.Close()
            rsCnt = Nothing
            command.Connection.Close()
            command = Nothing
            cnt = cnt + 1
        End Using

        Return cnt

    End Function

    Public Sub SetUserDefaultNotifications(ByVal UserID$)
        Dim S = "INSERT INTO [OwnerNotifications]"
        S = S + " ([OwnerNotificationID]"
        S = S + " ,[NotifyText]"
        S = S + " ,[NotifyType]"
        S = S + " ,[ImportanceLevel]"
        S = S + " ,[CreateDate]"
        S = S + " , [ExpireDate]"
        S = S + " ,[ResponseRequired]"
        S = S + " ,[OwnerNotificationDate]"
        S = S + " ,[EnteredById]"
        S = S + " )"
        S = S + " VALUES "
        S = S + " ('" + UserID + "'"
        S = S + " ,'Please Setup your account'"
        S = S + " ,'O'"
        S = S + " ,'H'"
        S = S + " ,getdate()"
        S = S + " ,getdate() + 360"
        S = S + " ,'Y'"
        S = S + " ,getdate()"
        S = S + " ,'AutoUpdate')"

        Dim b As Boolean = Me.ExecuteSql(S)

    End Sub

    Public Function CountUserEntries() As Integer
        Dim tQuery As String = ""
        Dim S As String = "select count(*) from UserData "

        CkConn()

        Dim cnt As Integer = -1

        Using gConn
            Dim command As New SqlCommand(S, gConn)
            Dim rsCnt As SqlDataReader = Nothing
            rsCnt = SqlQry(S)
            rsCnt.Read()
            cnt = rsCnt.GetInt32(0)
            rsCnt.Close()
            rsCnt = Nothing
            command.Connection.Close()
            command = Nothing
        End Using

        Return cnt

    End Function

    Public Sub ckUserInfoData()

        Dim tQuery As String = ""
        Dim S As String = "select count(*) from UserData "

        CkConn()

        Dim cnt As Integer = -1

        Using gConn
            Dim command As New SqlCommand(S, gConn)
            Dim rsCnt As SqlDataReader = Nothing
            rsCnt = SqlQry(S)
            rsCnt.Read()
            cnt = rsCnt.GetInt32(0)
            rsCnt.Close()
            rsCnt = Nothing
            command.Connection.Close()
            command = Nothing
        End Using
        If cnt < 100 Then
            For i As Integer = 100 To 705
                Dim tUid$ = "PP" + Str(i).Trim
                If i = 700 Then
                    tUid = "PPADMIN"
                End If
                If i = 701 Then
                    tUid = "PPDEV"
                End If
                Dim S1$ = "Select count(*) from UserData where UserID = '" + tUid + "'"
                Dim k As Integer = SelCount(S1)
                If k = 0 Then
                    S1 = "INSERT INTO Userdata"
                    S1 = S1 + " (UserID"
                    S1 = S1 + " ,UserPW"
                    S1 = S1 + " ,ExpireDate"
                    S1 = S1 + " ,UserLevel"
                    S1 = S1 + " ,UserClassification"
                    S1 = S1 + " ,CreateDate"
                    S1 = S1 + " ,UserName"
                    S1 = S1 + " ,UserEmail"
                    S1 = S1 + " ,SecurityQuestion"
                    S1 = S1 + " ,SecurityAnswer"
                    S1 = S1 + " ,EmergencyPhoneNbr)"
                    S1 = S1 + " VALUES "
                    S1 = S1 + " ('" + tUid + "'"

                    If tUid.Equals("PP621") Or tUid.Equals("PPADMIN") Or tUid.Equals("PPDEV") Then
                        S1 = S1 + " ,'junebug'"
                    Else
                        S1 = S1 + " ,'password'"
                    End If
                    S1 = S1 + " ,getdate() + 720"

                    If tUid.Equals("PP621") Or tUid.Equals("PPADMIN") Or tUid.Equals("PPDEV") Then
                        S1 = S1 + " ,'" + "A" + "'"
                    Else
                        S1 = S1 + " ,'" + "U" + "'"
                    End If

                    S1 = S1 + " ,'" + "O" + "'"

                    S1 = S1 + " ,'" + Now + "'"
                    S1 = S1 + " ,'Owner Name'"
                    S1 = S1 + " ,'" + tUid + ".PassagePoint.org" + "'"
                    S1 = S1 + " ,'" + "You need to set this up." + "'"
                    S1 = S1 + " ,'" + "You need to set this up." + "'"
                    S1 = S1 + " ,'" + "555-555-1212" + "')"
                    Dim b As Boolean = Me.ExecuteSql(S1)
                    If b Then
                        SetUserDefaultNotifications(tUid)
                    End If
                End If
            Next
        End If
    End Sub

    Public Function SelCount(ByVal sql As String) As Integer

        Dim tQuery As String = ""
        Dim s1 As String = ""
        Dim s2 As String = ""
        Dim s3 As String = ""
        Dim queryString As String = sql

        CkConn()

        Dim cnt As Integer = -1

        Using gConn
            Dim command As New SqlCommand(sql, gConn)
            Dim rsCnt As SqlDataReader = Nothing
            rsCnt = SqlQry(sql)
            rsCnt.Read()
            cnt = rsCnt.GetInt32(0)
            rsCnt.Close()
            rsCnt = Nothing
            command.Connection.Close()
            command = Nothing
        End Using

        Return cnt

    End Function

    Public Function ckAdminUser(ByVal Userid$, ByVal PW$) As Boolean
        Dim b As Boolean = True
        Dim SQL As String = "select userid from dco.<SchemaName>.admin_user where userid = '" + Userid + "' and password = '" + PW + "'"
        SQL = "select userid from ADMIN_USER where userid = '" + Userid + "' and password = '" + PW + "'"
        Dim i As Integer = 0

        Dim rsData As SqlDataReader

        rsData = SqlQry(SQL)
        If rsData.HasRows Then
            b = True
        Else
            b = False
        End If
        rsData.Close()
        rsData = Nothing
        Return b
    End Function

    Public Function getAdminUserId(ByVal Userid$, ByVal PW$) As String
        Dim b As Boolean = True
        Dim SQL As String = "select useridnbr from admin_user where userid = '" + Userid + "' and password = '" + PW + "'"
        SQL = "select useridnbr from ADMIN_USER where userid = '" + Userid + "' and password = '" + PW + "'"
        Dim i As Integer = 0
        Dim id$ = ""

        Dim rsData As SqlDataReader = Nothing

        rsData = SqlQry(SQL)
        If rsData.HasRows Then
            rsData.Read()
            id = rsData.GetValue(0).ToString
        Else
            id = ""
        End If
        rsData.Close()
        rsData = Nothing
        Return id
    End Function

    Public Function getDocCatIdByName(ByVal CatName$) As String
        Dim b As Boolean = True
        Dim S = "SELECT CategoryID  FROM DocumentCategories  where CategoryName = '" + CatName + "' "
        Dim i As Integer = 0
        Dim id$ = ""

        Dim rsData As SqlDataReader = Nothing

        rsData = SqlQry(S)
        If rsData.HasRows Then
            rsData.Read()
            id = rsData.GetValue(0).ToString
        Else
            id = ""
        End If
        rsData.Close()
        rsData = Nothing
        Return id
    End Function

    Public Function getUserNameByID(ByVal Userid$) As String
        Dim b As Boolean = True
        Dim S = "SELECT UserName FROM Users where UserID = '" + Userid$ + "' "
        Dim i As Integer = 0
        Dim id$ = ""

        Dim rsData As SqlDataReader = Nothing

        rsData = SqlQry(S)
        If rsData.HasRows Then
            rsData.Read()
            id = rsData.GetValue(0).ToString
        Else
            id = ""
        End If
        rsData.Close()
        rsData = Nothing
        Return id
    End Function

    Public Function getPhotoIdByRecNbr(ByVal RecNbr) As Integer
        Dim b As Boolean = True
        Dim S = "select PhotoID from photos"
        Dim i As Integer = 0
        Dim id As Integer = -1
        Dim II As Integer = 0

        Dim rsData As SqlDataReader = Nothing

        rsData = SqlQry(S)
        If rsData.HasRows Then
            Do While rsData.Read()
                II = II + 1
                id = rsData.GetValue(0).ToString
                If II = RecNbr Then
                    Exit Do
                End If
            Loop
        Else
            id = -1
        End If
        rsData.Close()
        rsData = Nothing
        Return id
    End Function

    Public Function getDeviceID(ByVal InventoryNo$) As String
        Dim b As Boolean = True
        Dim SQL As String = "SELECT DEVICEID FROM INVENTORY WHERE INVENTORYNO = " + InventoryNo
        Dim i As Integer = 0
        Dim id$ = ""

        Dim rsData As SqlDataReader = Nothing

        rsData = SqlQry(SQL)
        If rsData.HasRows Then
            rsData.Read()
            id = rsData.GetValue(0).ToString
        Else
            id = ""
        End If
        rsData.Close()
        rsData = Nothing
        Return id
    End Function

    Public Function getPhotoTitle(ByRef PhotoID As Integer, ByRef pTitle$) As String
        Dim b As Boolean = True
        Dim SQL As String = "select Caption, PhotoID from photos "
        Dim i As Integer = 0
        Dim tempTitle$ = ""

        Dim rsData As SqlDataReader = Nothing

        rsData = SqlQry(SQL)
        If rsData.HasRows Then
            Do While rsData.Read
                If i = PhotoID Then
                    PhotoID = rsData.GetInt32(1)
                    pTitle = rsData.GetValue(0).ToString
                    Exit Do
                End If
                i = i + 1
            Loop
            tempTitle = pTitle
        Else
            tempTitle = "No Photo Found"
        End If
        rsData.Close()
        rsData = Nothing
        Return tempTitle
    End Function

    Public Function getPhotoTitle(ByRef PhotoID As Integer) As String
        Dim b As Boolean = True
        Dim SQL As String = "select Caption from photos where PhotoID = " & PhotoID
        Dim i As Integer = 0
        Dim id$ = ""

        Dim rsData As SqlDataReader = Nothing

        rsData = SqlQry(SQL)
        If rsData.HasRows Then
            rsData.Read()
            id = rsData.GetValue(1).ToString
        Else
            id = "No Photo Found"
        End If
        rsData.Close()
        rsData = Nothing
        Return id
    End Function

    Public Function getContactID(ByVal FirstName$, ByVal LastName$) As String
        Dim b As Boolean = True
        Dim SS$ = "SELECT ContactID FROM Contacts "
        SS = SS + " where NameFirst = '" + FirstName$ + "' "
        SS = SS + " 	and NameLast = '" + LastName$ + "'"

        Dim i As Integer = 0
        Dim id$ = ""

        Dim rsData As SqlDataReader = Nothing

        rsData = SqlQry(SS)
        If rsData.HasRows Then
            rsData.Read()
            id = rsData.GetValue(0).ToString
        Else
            id = ""
        End If
        rsData.Close()
        rsData = Nothing
        Return id
    End Function

    Public Function RecordExists(ByVal Tbl$, ByVal WhereVar$, ByVal CompareVal$) As Boolean
        Dim b As Boolean = True
        Dim SQL As String = "select * from " + Tbl + " where " + WhereVar + " = '" + CompareVal$ + "'"
        Dim i As Integer = 0

        i = iGetRowCount(SQL)
        If i = 0 Then
            b = False
        End If
        Return b
    End Function

    Public Function getNextKey(ByVal TBL$, ByVal tCol$) As String

        CkConn()
        Dim tQuery As String = ""
        Dim s1 As String = ""
        Dim s2 As String = ""
        Dim s3 As String = ""
        Dim sql As String = "Select max(" + tCol + ") + 1 from " + TBL
        Dim d As String = ""

        'Dim cnt As Double = -1

        Dim rsData As SqlDataReader = Nothing
        Dim b As Boolean = False
        Try
            'rsData = SqlQry(sql, rsData)
            rsData = SqlQry(sql)
            rsData.Read()
            d = rsData.GetValue(0).ToString
            If Len(d) = 0 Then
                d = "0"
            End If
            'Dim ss As String = ""
            'ss = rsData.GetValue(0).ToString
            'cnt = rsData.Item(0)
            rsData.Close()
            'End Using
        Catch ex As Exception
            DMA.SaveErrMsg(ex.Message, ex.StackTrace.ToString)
            DMA.SaveErrMsg(ex.Message, sql)
            ''Session("ErrMsg") = ex.Message
            ''Session("ErrStack") = ex.StackTrace
            ''Response.Redirect("frmErrDisplay.aspx")
        End Try

        Return d
    End Function

    Public Function getNextKey(ByVal TBL$, ByVal tCol$, ByVal SQL$) As String

        Dim tQuery As String = ""
        Dim s1 As String = ""
        Dim s2 As String = ""
        Dim s3 As String = ""
        'Dim sql As String = "Select max(" + tCol + ") + 1 from " + TBL
        Dim d As String = ""

        'Dim cnt As Double = -1

        Dim rsData As SqlDataReader = Nothing
        Dim b As Boolean = False

        b = SqlQry(SQL, rsData)

        rsData.Read()
        d = rsData.GetValue(0).ToString

        rsData.Close()

        Return d
    End Function

    Public Function getKeyByLookupCol(ByVal TBL$, ByVal kCol$, ByVal tCol$, ByVal LookUpVal$) As String

        Dim tQuery As String = ""
        Dim s1 As String = ""
        Dim s2 As String = ""
        Dim s3 As String = ""
        Dim sql As String = "Select " + kCol + " from " + TBL + " where " + tCol + " = '" + LookUpVal + "'"
        Dim d As String = ""

        'Dim cnt As Double = -1

        Dim rsData As SqlDataReader = Nothing
        Dim b As Boolean = False

        b = SqlQry(sql, rsData)

        If rsData.HasRows Then
            rsData.Read()
            d = rsData.GetValue(0).ToString
        Else
            d = ""
        End If
        rsData.Close()
        'End Using
        Return d
    End Function

    Public Function getKeyByLookupCol(ByVal TBL$, ByVal kCol$, ByVal tCol$, ByVal LookUpVal As Integer) As String

        Dim tQuery As String = ""
        Dim s1 As String = ""
        Dim s2 As String = ""
        Dim s3 As String = ""
        Dim sql As String = "Select " + kCol + " from " + TBL + " where " + tCol + " = " + LookUpVal
        Dim d As String = ""

        'Dim cnt As Double = -1

        Dim rsData As SqlDataReader = Nothing
        Dim b As Boolean = False
        b = SqlQry(sql, rsData)
        If rsData.HasRows Then
            rsData.Read()
            d = rsData.GetValue(0).ToString
        Else
            d = ""
        End If
        rsData.Close()
        'End Using
        Return d
    End Function

    Public Function ValidateUserByUid(ByVal uid As String, ByVal upw As String) As Integer

        Dim Sql As String = "Select count(*) as CNT from Userdata where UserID = '" + uid + "' and UserPW = '" + upw + "'"
        Dim i As Integer = -1

        Using gConn
            Dim command As New SqlCommand(Sql, gConn)
            Dim rsCnt As SqlDataReader = Nothing
            rsCnt = SqlQry(Sql)
            Try
                ' Call Read before accessing data.
                rsCnt.Read()
                i = rsCnt.GetInt32(0)
                'Dim ss As String = ""
                'ss = rsCnt.GetValue(0).ToString
                'cnt = rsCnt.Item(0)
                rsCnt.Close()
                rsCnt = Nothing
                command.Connection.Close()
                command = Nothing
            Catch ex As Exception
                i = 0
            End Try

        End Using
        Return i
    End Function

    Public Function ValidateUserId(ByVal uid As String) As Integer

        Dim Sql As String = "Select count(*) as CNT from Userdata where UserID = '" + uid + "'"
        Dim i As Integer = -1

        Using gConn
            Dim command As New SqlCommand(Sql, gConn)
            Dim rsCnt As SqlDataReader = Nothing
            rsCnt = SqlQry(Sql)
            Try
                ' Call Read before accessing data.
                rsCnt.Read()
                i = rsCnt.GetInt32(0)
                'Dim ss As String = ""
                'ss = rsCnt.GetValue(0).ToString
                'cnt = rsCnt.Item(0)
                rsCnt.Close()
                rsCnt = Nothing
                command.Connection.Close()
                command = Nothing
            Catch ex As Exception
                i = 0
            End Try

        End Using
        Return i
    End Function

    Public Function getAuthority(ByVal uid As String) As String
        If uid = Nothing Then
            '"Error","User id has not been set...")
            Return ""
        End If
        Dim Sql As String = ""
        Sql = Sql + " Select [UserID]"
        Sql = Sql + " ,[UserPW]"
        Sql = Sql + " ,[ExpireDate]"
        Sql = Sql + " ,[UserLevel]"
        Sql = Sql + " ,[UserNbr]"
        Sql = Sql + " ,[UserClassification]"
        Sql = Sql + " ,[CreateDate]"
        Sql = Sql + " FROM Userdata"
        Sql = Sql + " where UserID = '" + uid + "'"
        Dim Auth$ = ""
        Dim queryString As String = Sql

        CkConn()

        Dim cnt As Integer = -1

        Dim rsData As SqlDataReader = Nothing
        Dim b As Boolean = False
        rsData = SqlQry(Sql)
        rsData.Read()
        Auth = rsData.GetValue(3).ToString
        rsData.Close()
        rsData = Nothing

        Return Auth

    End Function

    Public Function getPhotoExt(ByVal pid As String) As String
        If pid = Nothing Then
            '"Error","User id has not been set...")
            Return ""
        End If
        Dim Sql As String = ""
        Sql = Sql + " Select [PhotoFqn]"
        Sql = Sql + " FROM Photos "
        Sql = Sql + " where PhotoID = '" + pid + "'"
        Dim Auth$ = ""
        Dim queryString As String = Sql

        CkConn()

        Dim cnt As Integer = -1

        Dim rsData As SqlDataReader = Nothing
        Dim b As Boolean = False
        rsData = SqlQry(Sql)
        rsData.Read()
        Auth = rsData.GetValue(0).ToString
        rsData.Close()
        rsData = Nothing

        Return Auth

    End Function

    Public Function getPhotoImgType(ByVal pid As String) As String
        If pid = Nothing Then
            '"Error","User id has not been set...")
            Return ""
        End If
        Dim Sql As String = ""
        Sql = Sql + " Select ImgType "
        Sql = Sql + " FROM Photos "
        Sql = Sql + " where PhotoID = '" + pid + "'"
        Dim Auth$ = ""
        Dim queryString As String = Sql

        CkConn()

        Dim cnt As Integer = -1

        Dim rsData As SqlDataReader = Nothing
        Dim b As Boolean = False
        rsData = SqlQry(Sql)
        rsData.Read()
        Auth = rsData.GetValue(0).ToString
        rsData.Close()
        rsData = Nothing

        Return Auth

    End Function

    Public Function getUserType(ByVal uid As String) As String

        Dim Sql As String = ""
        Sql = Sql + " Select [UserID]"
        Sql = Sql + " ,[UserPW]"
        Sql = Sql + " ,[ExpireDate]"
        Sql = Sql + " ,[UserLevel]"
        Sql = Sql + " ,[UserNbr]"
        Sql = Sql + " ,[UserClassification]"
        Sql = Sql + " ,[CreateDate]"
        Sql = Sql + " FROM Userdata"
        Sql = Sql + " where UserID = '" + uid + "'"
        Dim Auth$ = ""
        Dim queryString As String = Sql

        CkConn()

        Dim cnt As Integer = -1

        Dim rsData As SqlDataReader = Nothing
        Dim b As Boolean = False
        rsData = SqlQry(Sql)
        rsData.Read()
        Auth = rsData.GetValue(5).ToString
        rsData.Close()
        rsData = Nothing

        Return Auth.Trim

    End Function

    Public Function SqlQry(ByVal sql As String, ByRef rsData As SqlDataReader) As Boolean

        Dim dDebug As Boolean = False
        If dDebug Then
            WriteToLog("____________________________________________")
            WriteToLog("Started: " + Now)
            WriteToLog(sql)

            Console.WriteLine("____________________________________________")
            Console.WriteLine("Started: " + Now)
            Console.WriteLine(sql)
        End If

        Dim CMDX As New SqlCommand

        Dim queryString As String = sql
        Dim rc As Boolean = False

        rsData = Nothing

        If gConn.State = Data.ConnectionState.Open Then
            gConn.Close()
        End If

        CkConn()

        If dDebug Then Console.WriteLine("SQLQRY Started: " + Now)
        If dDebug Then WriteToLog("SQLQRY Started: " + Now)

        Try
            'Dim CMDX As New SqlCommand(sql, gConn)
            CMDX.Connection = gConn
            CMDX.ExecuteReader()

            rsData = CMDX.ExecuteReader()
            CMDX.Dispose()
            CMDX = Nothing
            Return True
        Catch ex As Exception
            Return False
        End Try
    End Function

    Public Function NewID(ByVal Tbl$, ByVal idCol$) As Integer
        Dim S = ""
        S = "select max(" + idCol + ")+1 from " + Tbl
        Dim rsData As SqlDataReader = Nothing

        rsData = SqlQry(S)
        If rsData.HasRows Then
            rsData.Read()
            Dim iStr As Integer = rsData.GetValue(0).ToString
            rsData.Close()
            rsData = Nothing
            Return Val(iStr)
        Else
            rsData.Close()
            rsData = Nothing
            Return 0
        End If

    End Function

    Public Function getMaxPhotoID() As String
        Dim S = ""
        S = "select max(photoid) from photos "
        Dim rsData As SqlDataReader = Nothing

        rsData = SqlQry(S)
        If rsData.HasRows Then
            rsData.Read()
            Dim iStr$ = rsData.GetValue(0).ToString
            rsData.Close()
            rsData = Nothing
            Return iStr
        Else
            rsData.Close()
            rsData = Nothing
            Return "0"
        End If

    End Function

    Public Function getPhotoIDBycaption(ByVal Caption$) As String
        Dim S = ""
        S = "select photoid from photos where caption = '" + Caption + "'"
        Dim rsData As SqlDataReader = Nothing

        rsData = SqlQry(S)
        If rsData.HasRows Then
            rsData.Read()
            Dim iStr$ = rsData.GetValue(0).ToString
            rsData.Close()
            rsData = Nothing
            Return iStr
        Else
            rsData.Close()
            rsData = Nothing
            Return "0"
        End If

    End Function

    Public Function getUserPW(ByVal UID$) As String
        Dim S = ""
        S = "select UserPW from userdata where userid = '" + UID + "'"
        Dim rsData As SqlDataReader = Nothing
        Dim I As Integer = 0
        Dim iStr$ = ""
        rsData = SqlQry(S)
        If rsData.HasRows Then
            rsData.Read()
            iStr$ = rsData.GetValue(0).ToString
            rsData.Close()
            rsData = Nothing
        Else
            rsData.Close()
            rsData = Nothing
        End If
        Return iStr.Trim
    End Function

    Public Function getFqnFromGuid(ByVal SourceGuid$) As String
        Dim S = ""
        S = "SELECT FQN FROM DataSource Where SourceGuid = '" + SourceGuid + "'"
        Dim rsData As SqlDataReader = Nothing
        Dim I As Integer = 0
        Dim iStr$ = ""
        rsData = SqlQry(S)
        If rsData.HasRows Then
            rsData.Read()
            iStr$ = rsData.GetValue(0).ToString
            rsData.Close()
            rsData = Nothing
        Else
            rsData.Close()
            rsData = Nothing
        End If
        Return iStr.Trim
    End Function

    Public Function getFilenameByGuid(ByVal SourceGuid$) As String
        Dim S = ""
        S = "SELECT SourceName FROM DataSource Where SourceGuid = '" + SourceGuid + "'"
        Dim rsData As SqlDataReader = Nothing
        Dim I As Integer = 0
        Dim iStr$ = ""
        rsData = SqlQry(S)
        If rsData.HasRows Then
            rsData.Read()
            iStr$ = rsData.GetValue(0).ToString
            rsData.Close()
            rsData = Nothing
        Else
            rsData.Close()
            rsData = Nothing
        End If
        Return iStr.Trim
    End Function

    Public Function getUserGuidID(ByVal UserLoginId$) As String
        Dim S = ""
        S = "SELECT [UserID] FROM [DMA.UD].[dbo].[Users] Where UserLoginID = '" + UserLoginId$ + "'"
        Dim rsData As SqlDataReader = Nothing
        Dim I As Integer = 0
        Dim iStr$ = ""
        rsData = SqlQry(S)
        If rsData.HasRows Then
            rsData.Read()
            iStr$ = rsData.GetValue(0).ToString
            rsData.Close()
            rsData = Nothing
        Else
            rsData.Close()
            rsData = Nothing
        End If
        Return iStr.Trim
    End Function

    Public Function getQuickRefIdNbr(ByVal QuickRefName$, ByVal UserGuidID$) As String
        Dim S = ""
        S = "SELECT  [QuickRefIdNbr] FROM [QuickRef] where QuickRefName = '" + QuickRefName$ + "' and UserID = '" + UserGuidID$ + "'"
        Dim rsData As SqlDataReader = Nothing
        Dim I As Integer = 0
        Dim iStr$ = ""
        rsData = SqlQry(S)
        If rsData.HasRows Then
            rsData.Read()
            iStr$ = rsData.GetValue(0).ToString
            rsData.Close()
            rsData = Nothing
        Else
            iStr$ = "-1"
            rsData.Close()
            rsData = Nothing
        End If
        Return iStr.Trim
    End Function

    Public Function getNextDocID() As String

        Dim S = ""
        S = "SELECT max (DocumentID) FROM [Documents]"
        Dim rsData As SqlDataReader = Nothing
        Dim I As Integer = 0
        Dim iStr$ = ""
        rsData = SqlQry(S)
        If rsData.HasRows Then
            rsData.Read()
            iStr$ = rsData.GetValue(0).ToString
            rsData.Close()
            rsData = Nothing
        Else
            rsData.Close()
            rsData = Nothing
        End If
        Return iStr.Trim

    End Function

    Public Function getDocIdByFqn(ByVal FQN$) As String

        Dim S = ""
        S = "SELECT DocumentID FROM [Documents] where DocFqn = '" + FQN + "'"
        Dim rsData As SqlDataReader = Nothing
        Dim I As Integer = 0
        Dim iStr$ = ""
        rsData = SqlQry(S)
        If rsData.HasRows Then
            rsData.Read()
            iStr$ = rsData.GetValue(0).ToString
            rsData.Close()
            rsData = Nothing
        Else
            rsData.Close()
            rsData = Nothing
        End If
        Return iStr.Trim

    End Function

    Public Function ckDocExistByFqn(ByVal FQN$) As Boolean

        Dim S = ""
        S = "SELECT DocumentID FROM [Documents] where DocFqn = '" + FQN + "'"
        Dim rsData As SqlDataReader = Nothing
        Dim I As Integer = 0
        Dim B As Boolean = False
        rsData = SqlQry(S)
        If rsData.HasRows Then
            rsData.Close()
            rsData = Nothing
            B = True
        Else
            rsData.Close()
            rsData = Nothing
            B = False
        End If
        Return B

    End Function

    Public Function VerifyUserID(ByVal UID$) As Boolean
        Dim S = ""
        S = "select count(*) from Userdata where Userid = '" + UID + "'"
        Dim rsData As SqlDataReader = Nothing
        Dim I As Integer = 0

        rsData = SqlQry(S)
        If rsData.HasRows Then
            rsData.Read()
            Dim iStr$ = rsData.GetValue(0).ToString
            I = Val(iStr)
            rsData.Close()
            rsData = Nothing
            If I > 0 Then
                Return True
            Else
                Return False
            End If
        Else
            rsData.Close()
            rsData = Nothing
            Return False
        End If

    End Function

    Public Function ItemExists(ByVal Tbl$, ByVal idCol$, ByVal ColVal$, ByVal ColType$) As Boolean
        Dim S = ""
        Dim b As Boolean = False
        CkConn()
        If ColType = "N" Then
            S = "select count(*) from " + Tbl + " where " + idCol + " = " + ColVal
        Else
            S = "select count(*) from " + Tbl + " where " + idCol + " = '" + ColVal + "'"
        End If

        Dim rsData As SqlDataReader = Nothing

        rsData = SqlQry(S)
        If rsData.HasRows Then
            rsData.Read()
            Dim iStr As Integer = rsData.GetValue(0).ToString
            If Val(iStr) > 0 Then
                b = True
            Else
                b = False
            End If
        Else
            Return b
        End If
        rsData.Close()
        rsData = Nothing
        Return b
    End Function

    Public Function ValidateDeviceID(ByVal ID$) As Boolean
        Dim S = ""
        If ID.Length = 0 Then
            Return False
        End If
        Dim b As Boolean = False
        S = "select count(*) from Devices where deviceid = " + ID

        Dim rsData As SqlDataReader = Nothing

        rsData = SqlQry(S)
        If rsData.HasRows Then
            rsData.Read()
            Dim iStr As Integer = rsData.GetValue(0).ToString
            If Val(iStr) > 0 Then
                b = True
            Else
                b = False
            End If
        Else
            Return b
        End If
        rsData.Close()
        rsData = Nothing
        Return b
    End Function

    Public Function SqlQry(ByVal sql As String) As SqlDataReader
        ''Session("ActiveError") = False
        Dim dDebug As Boolean = False
        Dim queryString As String = sql
        Dim rc As Boolean = False
        Dim rsDataQry As SqlDataReader = Nothing

        CkConn()

        If gConn.State = Data.ConnectionState.Open Then
            gConn.Close()
        End If

        CkConn()

        Dim command As New SqlCommand(sql, gConn)

        Try
            rsDataQry = command.ExecuteReader()
        Catch ex As Exception
            ''Session("ActiveError") = True
            ''Session("ErrMsg") = ex.Message
            ''Session("ErrStack") = ex.StackTrace + vbCrLf + vbCrLf + sql
            xTrace(1001, "clsDataBase:SqlQry", ex.Message)
            xTrace(1002, "clsDataBase:SqlQry", ex.StackTrace)
            xTrace(1003, "clsDataBase:SqlQry", sql)
        End Try

        If dDebug Then WriteToLog("SQLQRY Ended: " + Now)
        If dDebug Then Console.WriteLine("SQLQRY Ended: " + Now)
        command.Dispose()
        command = Nothing

        Return rsDataQry
    End Function

    Public Function SqlQryNewThread(ByVal sql As String, ByRef tConn As SqlConnection) As SqlDataReader
        ''Session("ActiveError") = False
        Dim dDebug As Boolean = False
        Dim queryString As String = sql
        Dim rc As Boolean = False
        Dim rsDataQry As SqlDataReader = Nothing

        'Dim tConn As New SqlConnection
        tConn.ConnectionString = getConnStr()
        tConn.Open()

        If gConn.State = Data.ConnectionState.Open Then
            gConn.Close()
        End If

        CkConn()

        Dim command As New SqlCommand(sql, gConn)

        Try
            rsDataQry = command.ExecuteReader()
        Catch ex As Exception
            ''Session("ActiveError") = True
            ''Session("ErrMsg") = ex.Message
            ''Session("ErrStack") = ex.StackTrace + vbCrLf + vbCrLf + sql
            xTrace(1001, "clsDataBase:SqlQry", ex.Message)
            xTrace(1002, "clsDataBase:SqlQry", ex.StackTrace)
            xTrace(1003, "clsDataBase:SqlQry", sql)
        End Try

        If dDebug Then WriteToLog("SQLQRY Ended: " + Now)
        If dDebug Then Console.WriteLine("SQLQRY Ended: " + Now)
        command.Dispose()
        command = Nothing

        Return rsDataQry
    End Function

    Public Function SqlQry(ByVal sql As String, ByVal Conn As SqlConnection) As SqlDataReader
        ''Session("ActiveError") = False
        Dim dDebug As Boolean = False
        Dim queryString As String = sql
        Dim rc As Boolean = False
        Dim rsDataQry As SqlDataReader = Nothing

        If Conn.State <> Data.ConnectionState.Open Then
            Conn.Open()
        End If

        Dim command As New SqlCommand(sql, Conn)

        Try
            rsDataQry = command.ExecuteReader()
        Catch ex As Exception
            ''Session("ActiveError") = True
            ''Session("ErrMsg") = ex.Message
            ''Session("ErrStack") = ex.StackTrace + vbCrLf + vbCrLf + sql
            xTrace(1001, "clsDataBase:SqlQry", ex.Message)
            xTrace(1002, "clsDataBase:SqlQry", ex.StackTrace)
            xTrace(1003, "clsDataBase:SqlQry", sql)
        End Try

        If dDebug Then WriteToLog("SQLQRY Ended: " + Now)
        If dDebug Then Console.WriteLine("SQLQRY Ended: " + Now)

        command.Dispose()
        command = Nothing

        Return rsDataQry
    End Function

    Public Function SqlQryNewConn(ByVal sql As String) As SqlDataReader
        ''Session("ActiveError") = False
        Dim dDebug As Boolean = False
        Dim queryString As String = sql
        Dim rc As Boolean = False
        Dim rsDataQry As SqlDataReader = Nothing

        Dim CN As New SqlConnection(Me.getConnStr)

        If CN.State = ConnectionState.Closed Then
            CN.Open()
        End If

        Dim command As New SqlCommand(sql, CN)

        Try
            rsDataQry = command.ExecuteReader()
        Catch ex As Exception
            ''Session("ActiveError") = True
            ''Session("ErrMsg") = ex.Message
            ''Session("ErrStack") = ex.StackTrace + vbCrLf + vbCrLf + sql
            xTrace(1001, "clsDataBase:SqlQry", ex.Message)
            xTrace(1002, "clsDataBase:SqlQry", ex.StackTrace)
            xTrace(1003, "clsDataBase:SqlQry", sql)
        End Try

        If dDebug Then WriteToLog("SQLQRY Ended: " + Now)
        If dDebug Then Console.WriteLine("SQLQRY Ended: " + Now)

        'If CN.State = ConnectionState.Open Then
        '    CN.Close()
        'End If

        'CN = Nothing
        command.Dispose()
        command = Nothing

        Return rsDataQry
    End Function

    'Public Function LoadDataTable(ByVal DataReader As SqlDataReader) As DataTable
    '    '' create a sqlDataReader
    '    'Dim myReader As SqlDataReader
    '    '' Since the DataReader object cannot be displayed directly in the DataGridView,
    '    '' you can use the new method Load of a DataTable to fill a DataTable and then
    '    '' display the results in the DataGridView.  This method is still faster
    '    '' than filling a DataSet.
    '    Dim newDataTable As DataTable = New DataTable()
    '    newDataTable.Load(DataReader)

    '    '' set the data source
    '    'testDataDataGridView.DataSource = myTable
    '    '' close the datareader
    '    DataReader.Close()
    '    DataReader.Dispose()
    '    Return newDataTable
    'End Function
    Public Sub setGlobalConection()
        CkConn()
    End Sub

    Public Sub closeGlobalConection()
        If gConn.State = Data.ConnectionState.Open Then
            gConn.Close()
        End If
    End Sub

    Public Sub ckSiteFacility(ByVal FacilityID$)
        Dim NewKey$ = Trim(FacilityID)
        Dim H$ = Hex$(Val(NewKey))

        Dim iCnt As Integer = SelCount("select count(*) from sites where facilityID = " + FacilityID$)
        If iCnt > 0 Then
            Return
        End If

        iCnt = SelCount("select count(*) from sites where sitecode = '?" + H + "'")
        If iCnt > 0 Then
            Return
        End If

        Dim NextDispOrder$ = NewID("SITES", "SiteDisplayOrder")

        Dim S = ""
        S = S + " insert into sites (sitecode, sitename, facilityid, sitemenuname, SiteDisplayOrder)"
        S = S + " values "
        S = S + " ('?" + H + "', 'Undefined Site', " + FacilityID$ + ", 'NA','" + NextDispOrder$ + "')"

        Dim b As Boolean = ExecuteSql(S)

    End Sub

    Public Function ExecuteSqlTx(ByVal sql As String) As Boolean

        Dim TxName As String = "TX001"
        Dim rc As Boolean = False

        ''Session("ActiveError") = False
        ''Session("ErrMsg") = ""
        ''Session("ErrStack") = ""

        CkConn()

        Using gConn
            Dim dbCmd As SqlCommand = gConn.CreateCommand()
            Dim transaction As SqlTransaction

            ' Start a local transaction
            transaction = gConn.BeginTransaction(TxName)

            ' Must assign both transaction object and connection to dbCmd object for a pending local transaction.
            dbCmd.Connection = gConn
            dbCmd.Transaction = transaction

            Try
                dbCmd.CommandText = sql
                dbCmd.ExecuteNonQuery()
                ' Attempt to commit the transaction.
                transaction.Commit()

                'Audit(sql)

                Dim debug As Boolean = True
                If debug Then
                    Console.WriteLine("Successful execution: " + vbCrLf + sql)
                End If
                rc = True
            Catch ex As Exception
                rc = False

                ''Session("ActiveError") = True
                ''Session("ErrMsg") = "SQL Error check table PgmTrace: " + ex.Message
                ''Session("ErrStack") = "Stack Trace: " + vbCrLf + vbCrLf + ex.StackTrace

                xTrace(0, "ExecuteSql: ", "-----------------------")
                xTrace(1, "ExecuteSql: ", ex.Message.ToString)
                xTrace(2, "ExecuteSql: ", ex.StackTrace.ToString)
                xTrace(3, "ExecuteSql: ", sql)

                EL.Add("error 12.23.67: " + ex.Message)

                ' Attempt to roll back the transaction.
                Try
                    transaction.Rollback()
                Catch ex2 As Exception
                    ' This catch block will handle any errors that may have occurred on the server
                    ' that would cause the rollback to fail, such as a closed connection.
                    Console.WriteLine("Rollback Exception Type: {0}", ex2.GetType())
                    Console.WriteLine("  Message: {0}", ex2.Message)
                End Try
            End Try
        End Using

        Return rc
    End Function

    Public Function ExecuteSqlNoTx(ByVal sql As String) As Boolean

        Dim rc As Boolean = False

        ''Session("ActiveError") = False
        ''Session("ErrMsg") = ""
        ''Session("ErrStack") = ""

        CkConn()

        Using gConn

            Dim dbCmd As SqlCommand = gConn.CreateCommand()

            ' Must assign both transaction object and connection to dbCmd object for a pending local transaction.
            dbCmd.Connection = gConn

            Try
                dbCmd.CommandText = sql
                dbCmd.ExecuteNonQuery()
                rc = True
            Catch ex As Exception
                rc = False

                ''Session("ActiveError") = True
                ''Session("ErrMsg") = "ExecuteNoTx SQL: " + vbCrLf + sql + vbCrLf + vbCrLf + ex.Message
                ''Session("ErrStack") = "Stack Trace: " + vbCrLf + vbCrLf + ex.StackTrace

                xTrace(0, "ExecuteSqlNoTx: ", "-----------------------")
                xTrace(1, "ExecuteSqlNoTx: ", ex.Message.ToString)
                xTrace(2, "ExecuteSqlNoTx: ", ex.StackTrace.ToString)
                xTrace(3, "ExecuteSqlNoTx: ", sql)

                EL.Add("error 12.23.68: " + ex.Message)

            End Try
        End Using

        Return rc
    End Function

    Public Function ExecuteSql(ByVal sql As String) As Boolean

        Dim rc As Boolean = False

        ''Session("ActiveError") = False
        ''Session("ErrMsg") = ""
        ''Session("ErrStack") = ""

        CkConn()

        Using gConn

            Dim dbCmd As SqlCommand = gConn.CreateCommand()

            ' Must assign both transaction object and connection to dbCmd object for a pending local transaction.
            dbCmd.Connection = gConn

            Try
                dbCmd.CommandText = sql
                dbCmd.ExecuteNonQuery()
                rc = True
            Catch ex As Exception
                rc = False
                If InStr(ex.Message, "The DELETE statement conflicted with the REFERENCE", CompareMethod.Text) > 0 Then
                    MsgBox("It appears this user has DATA within the repository associated with them and cannot be deleted." + vbCrLf + vbCrLf + ex.Message)
                ElseIf InStr(ex.Message, "duplicate key row", CompareMethod.Text) > 0 Then
                    Return False
                Else
                    'MsgBox("Execute SQL: " + ex.Message + vbCrLf + "Please review the trace log." + vbCrLf + sql)
                    Clipboard.SetText(sql)
                End If

                xTrace(39901, "ExecuteSqlNoTx: ", ex.Message.ToString)
                Debug.Print(ex.Message.ToString)
                xTrace(39901, "ExecuteSqlNoTx: ", ex.StackTrace.ToString)
                xTrace(39901, "ExecuteSqlNoTx: ", Mid(sql, 1, 2000))

                'EL.Add("error 12.23.69: " + ex.Message)

            End Try
        End Using

        Return rc
    End Function

    Public Function ExecuteSqlNewConn(ByVal sql As String) As Boolean

        Dim rc As Boolean = False

        Dim CN As New SqlConnection(Me.getConnStr)
        CN.Open()
        Dim dbCmd As SqlCommand = CN.CreateCommand()

        Using CN
            dbCmd.Connection = CN
            Try
                dbCmd.CommandText = sql
                dbCmd.ExecuteNonQuery()
                rc = True
            Catch ex As Exception
                rc = False
                If InStr(ex.Message, "The DELETE statement conflicted with the REFERENCE", CompareMethod.Text) > 0 Then
                    MsgBox("It appears this user has DATA within the repository associated with them and cannot be deleted." + vbCrLf + vbCrLf + ex.Message)
                ElseIf InStr(ex.Message, "duplicate key row", CompareMethod.Text) > 0 Then
                    Return True
                Else
                    Clipboard.SetText(sql)
                End If
                xTrace(0, "ExecuteSqlNoTx: ", "-----------------------")
                xTrace(1, "ExecuteSqlNoTx: ", ex.Message.ToString)
                xTrace(2, "ExecuteSqlNoTx: ", ex.StackTrace.ToString)
                xTrace(3, "ExecuteSqlNoTx: ", Mid(sql, 1, 2000))
            End Try
        End Using

        If CN.State = ConnectionState.Open Then
            CN.Close()
        End If
        CN = Nothing
        dbCmd = Nothing
        Return rc
    End Function

    Public Function ExecSP(ByVal spName$) As Boolean
        Dim B As Boolean = False
        Dim TimeTrk As Boolean = True
        Try
            CkConn()
            If TimeTrk Then
                System.Console.WriteLine(spName + " Start: " + DateTime.Today.ToString)
            End If
            Dim command As SqlCommand = New SqlCommand(spName, gConn)
            command.CommandType = Data.CommandType.StoredProcedure
            command.CommandText = spName
            command.CommandTimeout = 3600
            command.ExecuteNonQuery()
            command = Nothing
            gConn.Close()
            B = True
            If TimeTrk Then
                System.Console.WriteLine(spName + " End: " + DateTime.Today.ToString)
            End If
        Catch ex As Exception
            'Session("ErrorLocation") = 'Session("ErrorLocation") + " : " + ex.Message
            xTrace(3014, spName$, "Stored Procedure Failed", ex)
            B = False
        End Try
        Return B
    End Function

    Public Function ExecuteSqlNoAudit(ByVal sql As String) As Boolean

        Dim TxName As String = "TX001"
        Dim rc As Boolean = False

        CkConn()

        Using gConn

            Dim dbCmd As SqlCommand = gConn.CreateCommand()

            'Dim transaction As SqlTransaction

            'transaction = gConn.BeginTransaction(TxName)

            ' Must assign both transaction object and connection to dbCmd object for a pending local transaction.
            dbCmd.Connection = gConn
            'dbCmd.Transaction = transaction

            Try
                dbCmd.CommandText = sql
                dbCmd.ExecuteNonQuery()
                ' Attempt to commit the transaction.
                'transaction.Commit()
                Dim debug As Boolean = True
                If debug Then
                    Console.WriteLine("Successful execution: " + vbCrLf + sql)
                End If
                rc = True
            Catch ex As Exception
                rc = False
                Console.WriteLine("Exception Type: {0}", ex.GetType())
                Console.WriteLine("  Message: {0}", ex.Message)
                Console.WriteLine(sql)

                ''Session("ActiveError") = True
                ''Session("ErrMsg") = "ExecuteSqlNoAudit - SQL Error check table PgmTrace: " + ex.Message
                ''Session("ErrStack") = "Stack Trace: " + vbCrLf + vbCrLf + ex.StackTrace

                xTrace(0, "ExecuteSql: ", "-----------------------")
                xTrace(1, "ExecuteSql: ", ex.Message.ToString)
                xTrace(2, "ExecuteSql: ", ex.StackTrace.ToString)
                xTrace(3, "ExecuteSql: ", sql)

            End Try
        End Using

        Return rc
    End Function

    Public Function saveHistory(ByVal SQL$) As Boolean
        Dim b As Boolean = True
        Dim typeSql As String = ""
        Dim tbl As String = ""
        Dim i As Integer = 0
        Dim j As Integer = 0

        i = InStr(1, SQL, " ", CompareMethod.Text)
        typeSql = Mid(SQL, 1, i - 1)
        typeSql = UCase(typeSql)

        If typeSql = "INSERT" Then
            i = InStr(1, SQL, "into", CompareMethod.Text)
            i = i + Len("into ")
            j = InStr(i, SQL, " ")
            tbl = Mid(SQL, i, j - i)
        End If
        If typeSql = "DELETE" Then
            i = InStr(1, SQL, "from", CompareMethod.Text)
            i = i + Len("from ")
            j = InStr(i, SQL, " ")
            tbl = Mid(SQL, i, j - i)
        End If
        If typeSql = "UPDATE" Then
            i = InStr(1, SQL, " ", CompareMethod.Text)
            i = i + Len(" ")
            j = InStr(i, SQL, " ")
            tbl = Mid(SQL, i, j - i)
        End If

        tbl = UCase(tbl)
        If tbl = "USER_ACCESS" Then
            Return True
        End If
        If tbl = "HISTORY" Then
            Return True
        End If

        SQL = DMA.RemoveSingleQuotes(SQL)
        '** select tbl, sqlstmt,LAST_MOD_DATE,user_name,action from history
        'Public MachineName As String = ""
        'Public MachineIP As String = ""
        'Public UserID As String = ""

        Dim S = "insert into HISTORY (tbl, sqlstmt,LAST_MOD_DATE,user_name,action, HostName, IPAddr, Last_Mod_User, Create_user) values ("
        S = S + "'" + tbl + "',"
        S = S + "'" + SQL + "', "
        S = S + " getdate(), "
        'S = S + "'" + Now() + "',"
        S = S + "'" + DMA.getEnvironmentUserID + "',"
        S = S + "'" + typeSql + "',"
        S = S + "'" + DMA.getHostname() + "',"
        S = S + "'" + DMA.getIpAddr() + "',"
        S = S + "'" + DMA.getEnvironmentUserID + "',"
        S = S + "'" + DMA.getEnvironmentUserID + "')"

        'Clipboard.Clear()
        'Clipboard.SetText(S)

        b = ExecuteSql(S)

        Return b
    End Function

    Public Function getCpuTime() As String
        '** You can browse the available performance counters by
        '** going to Control Panel | Administrative Tools | Performance and clicking Add.
        Dim perfCounter As New System.Diagnostics.PerformanceCounter()
        Dim loopCount As Integer
        Dim CPU$ = ""

        perfCounter.CategoryName = "Processor"
        perfCounter.CounterName = "% Processor Time"
        perfCounter.InstanceName = "_Total"

        For loopCount = 1 To 2
            'Debug.WriteLine(perfCounter.NextValue.ToString())
            CPU = perfCounter.NextValue.ToString()
        Next

        perfCounter.Close()

        Return CPU

    End Function

    Function GetTableNameFromSql(ByVal Sql$) As String
        Dim b As Boolean = True
        Dim typeSql As String = ""
        Dim tbl As String = ""
        Dim i As Integer = 0
        Dim j As Integer = 0

        Sql = Trim(Sql)

        Dim s1$ = ""
        Dim s2$ = ""
        Dim ch$ = ""

        For i = 1 To Len(Sql)
            ch = Mid(Sql, i, 1)
            If ch = "(" Then
                s1 = s1 + " " + ch
            ElseIf ch = ")" Then
                s1 = s1 + ch + " "
            Else
                s1 = s1 + ch
            End If
        Next

        Sql = s1

        i = InStr(1, Sql, " ", CompareMethod.Text)
        typeSql = Mid(Sql, 1, i - 1)
        typeSql = UCase(typeSql)

        If typeSql = "INSERT" Then
            i = InStr(1, Sql, "into", CompareMethod.Text)
            i = i + Len("into ")
            j = InStr(i, Sql, " ")
            tbl = Mid(Sql, i, j - i)
        End If
        If typeSql = "DELETE" Then
            i = InStr(1, Sql, "from", CompareMethod.Text)
            i = i + Len("from ")
            j = InStr(i, Sql, " ")
            tbl = Mid(Sql, i, j - i)
        End If
        If typeSql = "UPDATE" Then
            i = InStr(1, Sql, " ", CompareMethod.Text)
            i = i + Len(" ")
            j = InStr(i, Sql, " ")
            tbl = Mid(Sql, i, j - i)
        End If

        Return tbl

    End Function

    Function GetWhereClauseFromSql(ByVal Sql$) As String
        Dim b As Boolean = True
        Dim typeSql As String = ""
        Dim wc As String = ""
        Dim tbl As String = ""
        Dim i As Integer = 0
        Dim j As Integer = 0

        i = InStr(1, Sql, " where", CompareMethod.Text)
        If i > 0 Then
            wc = Mid(Sql, i)
        End If

        Return wc

    End Function

    Function GetTypeSqlStmt(ByVal Sql$) As String
        Dim b As Boolean = True
        Dim typeSql As String = ""
        Dim tbl As String = ""
        Dim i As Integer = 0
        Dim j As Integer = 0
        Dim SqlType As String = ""

        Sql = Trim(Sql)
        i = InStr(1, Sql, " ", CompareMethod.Text)
        typeSql = Mid(Sql, 1, i - 1)
        typeSql = UCase(typeSql)

        If typeSql = "INSERT" Then
            SqlType = typeSql
        End If
        If typeSql = "DELETE" Then
            SqlType = typeSql
        End If
        If typeSql = "UPDATE" Then
            SqlType = typeSql
        End If
        If typeSql = "SELECT" Then
            SqlType = typeSql
        End If
        Return SqlType
    End Function

    Public Function ckModuleAuth(ByVal UID$, ByVal AuthCode$) As Boolean
        AuthCode = UCase(AuthCode)
        Dim AuthGranted As Boolean = False
        Select Case AuthCode
            Case "DBA"
                AuthGranted = False
            Case "GRAPHICS"
                AuthGranted = False
            Case "INVENTORY"
                AuthGranted = False
            Case "STANDARDS"
                AuthGranted = False
            Case "ACCESS"
                AuthGranted = False
            Case "ACTION"
                AuthGranted = False
            Case "REPORTS"
                AuthGranted = False
            Case "COMPLAINTS"
                AuthGranted = False
            Case "COMPLAINANTS"
                AuthGranted = False
            Case "EMPLOYMENT"
                AuthGranted = False
            Case Else
                AuthGranted = False
                'DMA.SaveErrMsg(, "Error 121.99.2", "100.10c - Incorrect authority code entered, aborting...")
                ''Session("ErrMsg") = "Error 121.99.2"
                ''Session("ErrStack") = "100.10c - Incorrect authority code entered, aborting..."
                'Response.Redirect("frmErrDisplay.aspx")
                Return AuthGranted
        End Select

        Dim Level$ = ""

        Dim s As String = "select * from user_rights where user_name = '" + UID + "'"
        Dim rsData As SqlDataReader = Nothing
        Dim b As Boolean = False
        rsData = SqlQry(s)
        Try
            If rsData.IsClosed Then
                Console.WriteLine("ckModuleAuth HERE it is closed: " + UID)
            Else
                Console.WriteLine("ckModuleAuth HERE it is OPEN: " + UID)
            End If
        Catch ex As Exception
            'DMA.SaveErrMsg(, ex.Message, ex.StackTrace.ToString)
            ''Session("ErrMsg") = ex.Message
            ''Session("ErrStack") = ex.StackTrace
            'Response.Redirect("frmErrDisplay.aspx")
        End Try

        If rsData.HasRows Then
            rsData.Read()
            Level = rsData.GetValue(rsData.GetOrdinal(AuthCode)).ToString
            If Level <> "0" Then
                AuthGranted = True
            Else
                AuthGranted = False
            End If
        Else
            AuthGranted = False
        End If
        rsData.Close()
        'connection.Close()

        Return AuthGranted
    End Function

    Public Function ckAuthority(ByVal UID$, ByVal AuthCode$) As Boolean
        Dim AuthGranted As Boolean = False
        AuthCode = UCase(AuthCode)
        Select Case AuthCode
            Case "ADMIN"
                AuthGranted = False
            Case "SUPER USER"
                AuthGranted = False
            Case "USER"
                AuthGranted = False
            Case Else
                AuthGranted = False
                DMA.SaveErrMsg("Error", "100.10a - Incorrect authority code entered, aborting...")
                Return AuthGranted
        End Select
        Dim Auth$ = ""
        Dim s As String = "select user_type_cd from user_database where user_name = '" + UID + "' "
        Dim rsData As SqlDataReader = Nothing
        Dim b As Boolean = False
        rsData = SqlQry(s)

        rsData.Read()
        Auth = rsData.GetValue(rsData.GetOrdinal(AuthCode)).ToString
        If Auth = AuthCode Then
            AuthGranted = True
        Else
            AuthGranted = False
        End If
        rsData.Close()

        Return AuthGranted
    End Function

    Public Function UserHasAuthority(ByVal UID$, ByVal AuthCode$) As Boolean
        Dim AuthGranted As Boolean = False
        AuthCode = UCase(AuthCode)
        Select Case AuthCode
            Case "EDIT"
                AuthGranted = False
            Case "INSERT"
                AuthGranted = False
            Case "UPDATE"
                AuthGranted = False
            Case "DELETE"
                AuthGranted = False
            Case "READ"
                AuthGranted = False
            Case "MAINT"
                AuthGranted = False
            Case "EXECUTE"
                AuthGranted = False
            Case Else
                AuthGranted = False
                DMA.SaveErrMsg("Error", "100.10d - Incorrect authority code entered, aborting...")
                Return AuthGranted
        End Select
        Dim Auth$ = ""
        Dim s As String = "select user_type_cd from user_database where user_name = '" + UID + "' "
        Dim rsData As SqlDataReader = Nothing
        Dim b As Boolean = False
        rsData = SqlQry(s)
        rsData.Read()
        Auth = rsData.GetValue(0).ToString
        If Auth = "ADMIN" Then
            AuthGranted = True
        Else
            Select Case AuthCode
                Case "INSERT"
                    If Auth = "SUPER USER" Then
                        AuthGranted = True
                    ElseIf Auth = "USER" Then
                        AuthGranted = False
                    Else
                        AuthGranted = False
                    End If
                Case "EDIT"
                    If Auth = "SUPER USER" Then
                        AuthGranted = True
                    ElseIf Auth = "USER" Then
                        AuthGranted = False
                    Else
                        AuthGranted = False
                    End If
                Case "UPDATE"
                    If Auth = "SUPER USER" Then
                        AuthGranted = True
                    ElseIf Auth = "USER" Then
                        AuthGranted = False
                    Else
                        AuthGranted = False
                    End If
                Case "DELETE"
                    If Auth = "SUPER USER" Then
                        AuthGranted = False
                    ElseIf Auth = "USER" Then
                        AuthGranted = False
                    Else
                        AuthGranted = False
                    End If
                Case "READ"
                    If Auth = "SUPER USER" Then
                        AuthGranted = True
                    ElseIf Auth = "USER" Then
                        AuthGranted = True
                    Else
                        AuthGranted = False
                    End If
                Case "MAINT"
                    If Auth = "SUPER USER" Then
                        AuthGranted = True
                    ElseIf Auth = "USER" Then
                        AuthGranted = False
                    Else
                        AuthGranted = False
                    End If
                Case "EXECUTE"
                    If Auth = "SUPER USER" Then
                        AuthGranted = True
                    ElseIf Auth = "USER" Then
                        AuthGranted = False
                    Else
                        AuthGranted = False
                    End If
                Case Else
                    AuthGranted = False
            End Select
        End If
        rsData.Close()

        Return AuthGranted
    End Function

    Public Function ckFldLen(ByVal Title$, ByVal fld$) As Boolean
        If Len(fld) = 0 Then
            DMA.SaveErrMsg("Error", Title + " is a required field.")
            Return False
        Else
            Return True
        End If
    End Function

    Public Sub WriteToLog(ByVal Msg$)

        Dim cPath As String = GetCurrDir()
        Dim tFQN$ = cPath + "\AdmsApp.Log"
        ' Create an instance of StreamWriter to write text to a file.
        Using sw As StreamWriter = New StreamWriter(tFQN, True)
            ' Add some text to the file.
            sw.WriteLine(Now() + ": " + Msg)
            sw.Close()
        End Using

    End Sub

    Public Function GetCurrDir() As String
        Dim s As String = ""
        Dim ch As String = ""
        Dim i As Integer = 0
        's = Application.ExecutablePath
        s = System.Reflection.Assembly.GetExecutingAssembly.Location.ToString
        If InStr(1, s, "\") > 0 Then
            i = Len(s)
            ch = ""
            Do While ch <> "\"
                i = i - 1
                ch = Mid(s, i, 1)
            Loop
        End If
        Dim cPath As String = ""
        cPath = Mid(s, 1, i - 1)
        Return cPath
    End Function

    Public Function RetrieveDocument(ByVal DocID$) As Byte()

        Dim cn As SqlConnection = Nothing
        cn.ConnectionString = gConnStr
        cn.Open()

        Dim sql$ = "select DocumentText from documents where documentid = " & DocID$
        Dim cmd As New SqlCommand(sql, cn)
        Dim da As New SqlDataAdapter(cmd)
        Dim ds As New Data.DataSet

        da.Fill(ds, "BLOBIMAGE")

        Dim c As Integer = ds.Tables("BLOBIMAGE").Rows.Count

        If c > 0 Then
            Try
                Dim bytBLOBData() As Byte = ds.Tables("BLOBIMAGE").Rows(c - 1)("DocumentText")
                'Dim stmBLOBData As New MemoryStream(bytBLOBData)
                'MS = stmBLOBData
                Console.WriteLine("Document Bytes Retrieved: " & bytBLOBData.Length)
                cn.Close()
                cn = Nothing
                Return bytBLOBData
            Catch ex As Exception
                Console.Write(ex.StackTrace)
                Console.WriteLine("*************************************")
                Console.WriteLine(ex.Message)
                Console.WriteLine("********Inner Exception *********")
                Console.WriteLine(ex.InnerException.Message)
            End Try

        End If
        cn.Close()
        cn = Nothing
        Return Nothing
    End Function

    Public Function getDocumentFqnById(ByVal DocID$) As String

        Dim cn As SqlConnection = Nothing

        'gConnStr = ConfigurationManager.ConnectionStrings(ConnectionStringID).ConnectionString

        cn.ConnectionString = gConnStr
        cn.Open()

        Dim sql$ = "select DocFqn from documents where documentid = " & DocID$
        Dim cmd As New SqlCommand(sql, cn)
        Dim da As New SqlDataAdapter(cmd)
        Dim ds As New Data.DataSet

        da.Fill(ds, "DocFqn")

        Dim c As Integer = ds.Tables("DocFqn").Rows.Count

        If c > 0 Then
            Try
                Dim FQN$ = ds.Tables("DocFqn").Rows(c - 1)("DocFqn")
                'Dim stmBLOBData As New MemoryStream(bytBLOBData)
                'MS = stmBLOBData
                Console.WriteLine("Graphic Bytes Retrieved: " & FQN.Length)
                cn.Close()
                cn = Nothing
                Return FQN$
            Catch ex As Exception
                Console.Write(ex.StackTrace)
                Console.WriteLine("*************************************")
                Console.WriteLine(ex.Message)
                Console.WriteLine("********Inner Exception *********")
                Console.WriteLine(ex.InnerException.Message)
            End Try

        End If
        cn.Close()
        cn = Nothing
        Return Nothing
    End Function

    Sub xTrace(ByVal StmtID As Integer, ByVal Stmt$, ByVal PgmName$, ByVal ex As Exception)
        Dim ErrStack$ = ex.StackTrace.ToString
        Dim ErrorSource$ = ex.Source.ToString
        ' Dim InnerException = ex.InnerException.Message.ToString
        Dim ErrMsg$ = ex.Message.ToString
        'Dim exData As Collection = ex.Data
        Dim ConnectiveGuid$ = Me.getGuid()

        PgmName = DMA.RemoveSingleQuotes(PgmName)
        Dim mySql$ = ""
        Stmt = DMA.RemoveSingleQuotes(Stmt)
        mySql$ = "INSERT INTO PgmTrace ([StmtID] ,[PgmName], ConnectiveGuid, stmt, UserID) VALUES(" & StmtID & ", '" & PgmName & "' , '" + ConnectiveGuid$ + "', '" + Stmt + "', '" + CurrUserGuidID + "')"
        Dim b As Boolean = ExecuteSql(mySql)
        If b = False Then
            ''Session("ErrMsg") = "StmtId Call: " + 'Session("ErrMsg")
            ''Session("ErrStack") = "StmtId Call Stack: " + ''Session("ErrStack")
        End If

        SaveErrMsg(ErrMsg$, ErrStack$, StmtID.ToString, ConnectiveGuid$)

    End Sub

    Public Sub xTrace(ByVal StmtID As Integer, ByVal PgmName$, ByVal Stmt$)

        Try
            Stmt = DMA.RemoveSingleQuotes(Stmt)
            Dim mySql$ = ""
            PgmName = DMA.RemoveSingleQuotes(PgmName)
            mySql$ = "INSERT INTO PgmTrace (StmtID ,PgmName, Stmt) VALUES(" & StmtID & ", '" & PgmName & "','" & Stmt & "')"
            Dim b As Boolean = Me.ExecuteSqlNewConn(mySql)
            If b = False Then
                ''Session("ErrMsg") = "StmtId Call: " + 'Session("ErrMsg")
                ''Session("ErrStack") = "StmtId Call Stack: " + ''Session("ErrStack")
            End If
        Catch ex As Exception
            Debug.Print(ex.Message)
            Console.WriteLine(ex.Message)

        End Try

    End Sub

    Sub ZeroTrace()
        Dim mySql$ = ""
        mySql$ = "delete from PgmTrace "
        Dim b As Boolean = ExecuteSql(mySql)
        If b = False Then
            ''Session("ErrMsg") = "ZeroTrace Call: " + 'Session("ErrMsg")
            ''Session("ErrStack") = "ZeroTrace Call Stack: " + ''Session("ErrStack")
            'Response.Redirect("frmErrDisplay.aspx")
        End If
    End Sub

    Sub ZeroizeEmailToDelete(ByVal Userid$)
        Dim mySql$ = ""
        mySql$ = "delete from EmailToDelete where UserID = '" + Userid + "'"
        Dim b As Boolean = ExecuteSql(mySql)
        If b = False Then
            ''Session("ErrMsg") = "ZeroTrace Call: " + 'Session("ErrMsg")
            ''Session("ErrStack") = "ZeroTrace Call Stack: " + ''Session("ErrStack")
            'Response.Redirect("frmErrDisplay.aspx")
        End If
    End Sub

    Public Function LogEntryNew(ByVal IPADDR$) As Integer

        Dim NextKey$ = getNextKey("LOGINS", "LoginTrackingNbr")
        Dim S = ""

        S = S + "INSERT INTO [Logins]"
        S = S + "([LoginID]"
        S = S + ",[LoginDate]"
        S = S + ",[LoginTrackingNbr]"
        S = S + ",[Duration]"
        S = S + ",[IPAddress])"
        S = S + "VALUES( "
        S = S + "'VISITOR'"
        S = S + ",getdate()"
        S = S + "," + NextKey$
        S = S + ",getdate()"
        S = S + ",'" + IPADDR$ + "')"

        Dim b As Boolean = ExecuteSqlNoTx(S)
        If b Then
            Return NextKey$
        Else
            Return ""
        End If

    End Function

    Public Sub LogEntryUpdate(ByVal UID$, ByVal LoginTrackingNbr As Integer)

        If UID$ = Nothing Then
            If Not LoginTrackingNbr = Nothing Then
                LogEntryUpdate(LoginTrackingNbr)
            End If
            Return
        End If

        If UID$.Length = 0 Then
            Return
        End If

        Dim S = ""

        S = S + "UPDATE [Logins]"
        S = S + " SET [LoginID] = '" + UID + "'"
        S = S + " ,[Duration] = getdate()      "
        S = S + " WHERE (LoginTrackingNbr = " + Str(LoginTrackingNbr) + ") "

        Dim b As Boolean = ExecuteSqlNoTx(S)

    End Sub

    Public Sub LogEntryUpdate(ByVal LoginTrackingNbr As Integer)

        Dim S = ""

        S = S + "UPDATE [Logins]"
        S = S + " SET [Duration] = getdate()      "
        S = S + " WHERE (LoginTrackingNbr = " + Str(LoginTrackingNbr) + ") "

        Dim b As Boolean = ExecuteSqlNoTx(S)

    End Sub

    Public Function InsertEmail(ByVal EmailFrom$, ByVal EmailTo$, ByVal EmailSubj$, ByVal EmailCC$, ByVal EmailBCC$, ByVal EMailBody$, ByVal EMailBody2$, ByVal EmailDate As Date) As Boolean

        Dim S = ""
        S = S + " INSERT INTO [Emails]"
        S = S + " ([EmailTo]"
        S = S + " ,[EmailFrom]"
        S = S + " ,[EmailSubj]"
        S = S + " ,[EmailBody]"
        S = S + " ,[EmailBody2]"
        S = S + " ,[EmailDate]"
        S = S + " ,[EmailCC]"
        S = S + " ,[EmailBcc])"
        S = S + " VALUES"
        S = S + " ('" + EmailTo + "','"
        S = S + EmailFrom + "','"
        S = S + EmailSubj + "','"
        S = S + EMailBody + "','"
        S = S + EMailBody2 + "','"
        S = S + EmailDate + "','"
        S = S + EmailCC + "','"
        S = S + EmailBCC + "')"

        Dim b As Boolean = ExecuteSql(S)
        Return b
    End Function

    Public Sub AddUploadFileData(ByVal FQN$, ByVal UploadedBy$)
        Dim B As Boolean = ckDatasourceExists(FQN$, UploadedBy$)
        If Not B Then
            InsertFileAudit(FQN$, UploadedBy$)
        End If
    End Sub

    Public Function InsertFileAudit(ByVal FN$, ByVal UploadedBy$) As Boolean

        Dim b As Boolean = False
        Dim s As String = ""

        b = ckDatasourceExists(FN$, UploadedBy$)

        If b Then
            Return True
        End If

        s = s + " INSERT INTO [FileUpload] ([FileName],[UploadedBy]) VALUES( "
        s = s + "'" + FN + "',"
        s = s + "'" + UploadedBy + "')"

        b = ExecuteSqlNoAudit(s)

        If Not b Then
            Console.WriteLine("Audit Failed: " + s)
        End If

        Return b

    End Function

    Public Function setUploadSuccessTrue(ByVal UploadID As Integer) As Boolean

        Dim b As Boolean = False
        Dim s As String = ""

        s = " Update FileUpload set SuccessfulLoad = 1 where UploadID = " & UploadID
        b = ExecuteSqlNoAudit(s)
        s = " Update FileUpload set EndTime = getdate() where UploadID = " & UploadID
        b = ExecuteSqlNoAudit(s)
        s = " update FileUpload set ElapsedTime = DATEDIFF(second, StartTime, GETDATE()) where UploadID = " & UploadID
        b = ExecuteSqlNoAudit(s)
        If Not b Then
            Console.WriteLine("Audit Failed: " + s)
        End If
        Return b
    End Function

    Function GetLastUploadTime() As String

        CkConn()
        Dim S = ""
        S = "select max(UploadID) from FileUpload where SuccessfulLoad = 1 "
        Dim rsData As SqlDataReader = Nothing
        Dim I As Integer = 0
        Dim iStr$ = ""
        rsData = SqlQry(S)
        If rsData.HasRows Then
            rsData.Read()
            iStr$ = rsData.GetValue(0).ToString
            rsData.Close()
            rsData = Nothing
        Else
            rsData.Close()
            rsData = Nothing
        End If

        If iStr$.Length = 0 Then
            Return "No file has been loaded as of now..."
        End If

        Dim FN$ = ""
        Dim ET$ = ""
        GetElapsedTime(iStr$, FN, ET)

        If FN.Length > 0 Then
            Return "The last upload, '" + FN + "', took " + ET + " seconds."
        Else
            Return "The current load could possibly take several minutes..."
        End If

    End Function

    Sub GetElapsedTime(ByVal UploadID$, ByRef FN$, ByRef ET$)

        Try
            Dim S = ""
            S = "select FileName, ElapsedTime from FileUpload where UploadID = " + UploadID$
            Dim rsData As SqlDataReader = Nothing
            Dim I As Integer = 0
            Dim iStr$ = ""
            rsData = SqlQry(S)
            If rsData.HasRows Then
                rsData.Read()
                FN = rsData.GetValue(0).ToString
                ET = rsData.GetValue(1).ToString
                rsData.Close()
                rsData = Nothing
            Else
                rsData.Close()
                rsData = Nothing
            End If
        Catch ex As Exception
            FN = ""
            ET = ""
        End Try
    End Sub

    Function ckAttributeExists(ByVal AttributeName$, ByVal PropVal$) As Boolean

        Dim s As String = "SELECT count(*) from Attribute where AttributeName = '" + AttributeName$ + "'"
        Dim Cnt As Integer
        Dim rsData As SqlDataReader = Nothing
        Dim b As Boolean = False
        rsData = SqlQry(s)

        rsData.Read()
        Cnt = rsData.GetInt32(0)
        If Cnt > 0 Then
            b = True
        Else
            b = False
        End If
        rsData.Close()

        Return b
    End Function

    '' <summary>
    '' Determines of a file has alraedy been loaded into the system or not.
    '' </summary>
    '' <param name="FN"></param>
    '' <returns>TRUE if the file has been loaded, FALSE if not.</returns>
    '' <remarks></remarks>
    Public Function ckDatasourceExists(ByVal FQN$, ByVal UID$) As Boolean

        CkConn()

        Dim Cnt As Integer
        Dim s As String = "SELECT count(*) FROM [DataSource] "
        s = s + " where FQN = '" + FQN + "' and UserID = '" + UID + "'"
        Dim rsData As SqlDataReader = Nothing
        Dim b As Boolean = False
        rsData = SqlQry(s)

        rsData.Read()
        Cnt = rsData.GetInt32(0)
        If Cnt > 0 Then
            b = True
        Else
            b = False
        End If
        rsData.Close()

        Return b

    End Function

    Public Function getTableCount(ByVal TblName$) As Integer

        Dim S = "SELECT  count(*) FROM " + TblName
        CkConn()
        Dim Cnt As Integer
        Dim rsData As SqlDataReader = Nothing
        Dim b As Boolean = False
        rsData = SqlQry(S)

        rsData.Read()
        Cnt = rsData.GetInt32(0)

        rsData.Close()

        Return Cnt

    End Function

    Public Function iCount(ByVal tSql As String) As Integer
        Try
            Dim S = tSql
            CkConn()
            Dim Cnt As Integer
            Dim rsData As SqlDataReader = Nothing
            Dim b As Boolean = False
            rsData = SqlQry(S)
            rsData.Read()
            Cnt = rsData.GetInt32(0)
            rsData.Close()
            rsData = Nothing
            Return Cnt
        Catch ex As Exception
            MsgBox("ERROR 1993.21: " + ex.Message)
            Return -1
        End Try
    End Function

    Public Function getCountDataSourceFiles(ByVal UserID$, ByVal FQN$) As Integer
        FQN$ = DMA.RemoveSingleQuotes(FQN$)

        Dim S = "SELECT  count(*) FROM [DataSource] where FQN = '" + FQN + "' and DataSourceOwnerUserID = '" + UserID$ + "'"
        CkConn()
        Dim Cnt As Integer
        Dim rsData As SqlDataReader = Nothing
        Dim b As Boolean = False
        rsData = SqlQry(S)

        rsData.Read()
        Cnt = rsData.GetInt32(0)

        rsData.Close()

        Return Cnt

    End Function

    Public Function getCountDataSourceFiles(ByVal UserID$, ByVal FQN As String, ByVal VerNO As Integer) As Integer

        FQN = DMA.RemoveSingleQuotes(FQN)

        Dim S = "SELECT  count(*) FROM [DataSource] where FQN = '" + FQN + "' and DataSourceOwnerUserID = '" + UserID$ + "' and VersionNbr = " + VerNO.ToString
        CkConn()
        Dim Cnt As Integer
        Dim rsData As SqlDataReader = Nothing
        Dim b As Boolean = False
        rsData = SqlQry(S)

        rsData.Read()
        Cnt = rsData.GetInt32(0)

        rsData.Close()

        Return Cnt

    End Function

    Function GetMaxDataSourceVersionNbr(ByVal UserID$, ByVal FQN$) As Integer
        FQN$ = DMA.RemoveSingleQuotes(FQN$)

        Dim S = "SELECT  max ([VersionNbr]) FROM [DataSource] where FQN = '" + FQN + "' and DataSourceOwnerUserID = '" + UserID$ + "'"
        CkConn()
        Dim Cnt As Integer

        Dim rsData As SqlDataReader = Nothing
        Dim b As Boolean = False
        rsData = SqlQry(S)

        If rsData.HasRows Then
            rsData.Read()
            Cnt = rsData.GetInt32(0)
        Else
            Cnt = -1
        End If

        rsData.Close()
        rsData = Nothing

        Return Cnt

    End Function

    Function getGuid() As String
        Dim MyGuid As Guid = Guid.NewGuid()
        Return MyGuid.ToString
    End Function

    '' <summary>
    '' Bilds the sorted lists for blazing fast lookup speeds.
    '' </summary>
    '' <remarks></remarks>
    Public Sub PopulateSortedLists()
        PopulateProjectSortedList()
        PopulateProjectTeamSortedList()
    End Sub

    '' <summary>
    '' The subroutine PopulateProjectSortedList populates a sorted list with all projects from the
    '' input Excel spreadsheet. This list allows us to verify that a project exists without having to
    '' access the database thus giving us extreme speed.
    '' </summary>
    '' <remarks></remarks>
    Sub PopulateProjectSortedList()
        Dim PID As Integer = 0
        Dim s As String = "select RomID, ProjectID from Project"
        Dim rsData As SqlDataReader = Nothing

        slProjects.Clear()

        rsData = SqlQry(s)
        rsData.Read()

        If rsData.HasRows Then
            Do While rsData.Read()
                Dim RomID$ = rsData.GetValue(0).ToString
                Dim ProjectID As Integer = rsData.GetInt32(1)
                slProjects.Add(ProjectID, RomID)
            Loop
        Else
            slProjects.Add(-1, "$$New Project")
        End If

        rsData.Close()
    End Sub

    Sub PopulateProjectTeamSortedList()

        slProjectTeams.Clear()
        Dim PID As Integer = 0
        Dim s As String = "SELECT [ProjectTeamIdentifier] +'|'+ cast([ProjectID] as varchar(50)), ProjectTeamID FROM [ProjectTeam]"
        Dim rsData As SqlDataReader = Nothing

        rsData = SqlQry(s)
        rsData.Read()

        If rsData.HasRows Then
            Do While rsData.Read()
                Dim TeamKey$ = rsData.GetValue(0).ToString
                Dim ProjectTeamID As Integer = rsData.GetInt32(1)
                slProjectTeams.Add(ProjectTeamID, TeamKey$)
            Loop
        Else
            slProjectTeams.Add(-1, "XXXX")
        End If

        rsData.Close()
    End Sub

    Sub PopulateMetricPeriodSortedList()

        slMetricPeriods.Clear()
        Dim PID As Integer = 0
        Dim s As String = "SELECT cast([MetricPeriod] as varchar(50)) + '|' + cast([ProjectTeamID] as varchar(50)), [MetricRowGuid] FROM [MetricPeriodData]"
        Dim rsData As SqlDataReader = Nothing

        rsData = SqlQry(s)
        rsData.Read()

        If rsData.HasRows Then
            Do While rsData.Read()
                Dim MetricKey$ = rsData.GetValue(0).ToString
                Dim MetricID As Integer = rsData.GetInt32(1)
                slMetricPeriods.Add(MetricID, MetricKey$)
            Loop
        Else
            slMetricPeriods.Add(-1, "~~~~")
        End If

        rsData.Close()
    End Sub

    Function getMetricPeriodIdByKey(ByVal MetricPeriod$, ByVal ProjectTeamID$) As String

        slMetricPeriods.Clear()
        Dim PID As Integer = 0
        Dim s As String = ""
        Dim tKey$ = ""

        s = s + "SELECT [MetricRowGuid] "
        s = s + "FROM [MetricPeriodData]"
        s = s + "where MetricPeriod= '" + MetricPeriod$ + "'"
        s = s + "and ProjectTeamID = " + ProjectTeamID$
        Dim rsData As SqlDataReader = Nothing

        rsData = SqlQry(s)
        rsData.Read()

        If rsData.HasRows Then
            Do While rsData.Read()
                tKey = rsData.GetValue(0).ToString
            Loop
        Else
            tKey = ""
        End If

        rsData.Close()
        Return tKey
    End Function

    Sub LinkRunId()
        Dim LoadID As Integer = 0
        Dim s As String = "SELECT max([UploadID]) FROM [FileUpload]"
        Dim rsData As SqlDataReader = Nothing

        rsData = SqlQry(s)
        rsData.Read()

        If rsData.HasRows Then

            LoadID = rsData.GetInt32(0)

            rsData.Close()

            s = s + "update MetricPeriodData set UploadID = " & LoadID & " where UploadID is null"

            Dim b As Boolean = ExecuteSqlNoAudit(s)

        End If

        If Not rsData.IsClosed Then
            rsData.Close()
        End If

    End Sub

    Function getLastUploadID() As Integer

        Dim LoadID As Integer = -1
        Dim s As String = "SELECT max([UploadID]) FROM [FileUpload]"
        Dim rsData As SqlDataReader = Nothing

        rsData = SqlQry(s)
        rsData.Read()

        If rsData.HasRows Then

            LoadID = rsData.GetInt32(0)

            rsData.Close()

        End If

        If Not rsData.IsClosed Then
            rsData.Close()
        End If

        Return LoadID

    End Function

    Function getLastProjectID() As Integer

        Dim LoadID As Integer = -1
        Dim s As String = "SELECT max([ProjectID]) FROM [Project]"
        Dim rsData As SqlDataReader = Nothing

        rsData = SqlQry(s)
        rsData.Read()

        If rsData.HasRows Then

            LoadID = rsData.GetInt32(0)

            rsData.Close()

        End If

        If Not rsData.IsClosed Then
            rsData.Close()
        End If

        Return LoadID

    End Function

    Public Function ckExcelColName(ByVal ColName$) As Boolean
        Dim B As Boolean = False
        Dim I As Int32 = Me.slExcelColNames.IndexOfKey(ColName)
        If I < 0 Then
            B = False
        Else
            B = True
        End If
        Return B
    End Function

    Sub populateSortedLists(ByVal ListName$, ByVal tKey$, ByVal tDesc$)

        'Public slGrowthPlatform As New SortedList
        'Public slOperatingGroup As New SortedList
        'Public slOperatingUnit As New SortedList
        'Public slGeography As New SortedList
        'Public slGeographicUnit As New SortedList
        'Public slClientServiceGroup As New SortedList
        'Public slDeliveryCenter As New SortedList
        'Public slTypeOfWork As New SortedList
        'Public slProjectTeamTypeOfWork As New SortedList
        'Public slSubmissionStatus As New SortedList

        If ListName.Equals("GrowthPlatform") Then
            slGrowthPlatform.Add(tKey, tDesc)
        ElseIf ListName.Equals("OperatingGroup") Then
            slOperatingGroup.Add(tKey, tDesc)
        ElseIf ListName.Equals("OperatingUnit") Then
            slOperatingUnit.Add(tKey, tDesc)
        ElseIf ListName.Equals("Geography") Then
            slGeography.Add(tKey, tDesc)
        ElseIf ListName.Equals("GeographicUnit") Then
            slGeographicUnit.Add(tKey, tDesc)
        ElseIf ListName.Equals("ClientServiceGroup") Then
            slClientServiceGroup.Add(tKey, tDesc)
        ElseIf ListName.Equals("DeliveryCenter") Then
            slDeliveryCenter.Add(tKey, tDesc)
        ElseIf ListName.Equals("TypeOfWork") Then
            slTypeOfWork.Add(tKey, tDesc)
        ElseIf ListName.Equals("ProjectTeamTypeOfWork") Then
            slProjectTeamTypeOfWork.Add(tKey, tDesc)
        ElseIf ListName.Equals("SubmissionStatus") Then
            slSubmissionStatus.Add(tKey, tDesc)
        ElseIf ListName.Equals("SubmittedBy") Then
            slSubmittedBy.Add(tKey, tDesc)
        End If
    End Sub

    Sub AddLookupData(ByVal TBL$, ByVal CodeCol$, ByVal DescCol$, ByVal tCode$, ByVal tDesc$)
        Dim S = ""

        populateSortedLists(TBL, tCode$, tDesc$)

        Dim b As Boolean = ItemExists(TBL$, CodeCol$, tCode$, "S")

        If Not b Then
            S = ""
            S = S + " insert into " + TBL + " (" + CodeCol$ + "," + DescCol + ")"
            S = S + " values "
            S = S + " ('" + tCode + "','" + tDesc + "')"

            b = ExecuteSql(S)

        End If

    End Sub

    Public Sub SetConfigDb(ByVal DbId$)
        ConnectionStringID = DbId$
    End Sub

    Function GetDsValue(ByVal RS As SqlDataReader, ByVal I As Integer) As String
        Dim tVal$ = RS.GetValue(I).ToString
        tVal = DMA.RemoveSingleQuotes(tVal)
        Return tVal
    End Function

    Sub AddToSL(ByRef SL As SortedList, ByVal tSql$, ByRef dups As Integer)
        Try
            Dim I As Integer = SL.IndexOfKey(tSql)
            If I >= 0 Then
                dups = dups + 1
            Else
                SL.Add(tSql, tSql)
            End If
        Catch ex As Exception
            Console.WriteLine("Duplicate SQL statement, skipping and continuing.")
            dups = dups + 1
        End Try
    End Sub

    Public Sub spCkNextID(ByVal ID$)
        Dim B As Boolean = False
        Dim TimeTrk As Boolean = True
        Try
            CkConn()
            Dim command As SqlCommand = New SqlCommand("exec spCkNextID " + ID, gConn)
            command.CommandType = Data.CommandType.Text
            'command.CommandText = "spCkNextID " + ID
            command.CommandTimeout = 3600
            command.ExecuteNonQuery()
            command = Nothing
            gConn.Close()
        Catch ex As Exception
            'Session("ErrorLocation") = 'Session("ErrorLocation") + " : " + ex.Message
        End Try
    End Sub

    Public Function InsertEmailMsg(ByVal FQN$, ByVal EmailGUID As String, ByVal UserID$, ByVal ReceivedByName As String, ByVal ReceivedTime As DateTime, ByVal SenderEmailAddress As String, ByVal SenderName As String, ByVal SentOn As DateTime) As Boolean
        Dim B As Boolean = False
        Try
            Dim EmailBinary() As Byte = CF.FileToByte(FQN)
            'UserID, ReceivedByName As String, ReceivedTime As DateTime, SenderEmailAddress As String, SenderName As String, SentOn As DateTime
            Using connection As New SqlConnection(Me.getConnStr)
                Using command As New SqlCommand("spInsertEmailMsg", connection)
                    command.CommandType = CommandType.StoredProcedure
                    command.Parameters.Add(New SqlParameter("@EmailGuid", EmailGUID))
                    command.Parameters.Add(New SqlParameter("@EmailImage", EmailBinary))

                    command.Parameters.Add(New SqlParameter("@UserID", UserID))
                    command.Parameters.Add(New SqlParameter("@ReceivedByName", ReceivedByName))
                    command.Parameters.Add(New SqlParameter("@ReceivedTime", ReceivedTime))
                    command.Parameters.Add(New SqlParameter("@SenderEmailAddress", SenderEmailAddress))
                    command.Parameters.Add(New SqlParameter("@SenderName", SenderName))
                    command.Parameters.Add(New SqlParameter("@SentOn", SentOn))

                    connection.Open()
                    command.ExecuteNonQuery()
                    connection.Close()
                    connection.Dispose()
                    command.Dispose()
                End Using
            End Using
            B = True
        Catch ex As Exception
            Debug.Print(ex.Message)
            B = False
        End Try
        Return B
    End Function

    Public Function UpdateEmailMsg(ByVal FQN$, ByVal EmailGUID As String) As Boolean
        Dim B As Boolean = False
        Try
            Dim EmailBinary() As Byte = CF.FileToByte(FQN)
            Using connection As New SqlConnection(Me.getConnStr)
                Using command As New SqlCommand("spUpdateEmailMsg", connection)
                    command.CommandType = CommandType.StoredProcedure
                    command.Parameters.Add(New SqlParameter("@EmailGuid", EmailGUID))
                    command.Parameters.Add(New SqlParameter("@EmailImage", EmailBinary))
                    connection.Open()
                    command.ExecuteNonQuery()
                    connection.Close()
                    command.Dispose()
                End Using
            End Using
            B = True
        Catch ex As Exception
            Debug.Print(ex.Message)
            B = False
        End Try
        Return B
    End Function

    Public Function UpdateAttachment(ByVal EmailGUID As String, ByVal AttachmentBinary() As Byte, ByVal AttachmentName$, ByVal AttachmentCode$) As Boolean
        Dim B As Boolean = False
        Try
            Using connection As New SqlConnection(Me.getConnStr)
                Using command As New SqlCommand("UpdateAttachment", connection)
                    command.CommandType = CommandType.StoredProcedure
                    command.Parameters.Add(New SqlParameter("@EmailGuid", EmailGUID))
                    command.Parameters.Add(New SqlParameter("@Attachment", AttachmentBinary))
                    command.Parameters.Add(New SqlParameter("@AttachmentName", AttachmentName))
                    command.Parameters.Add(New SqlParameter("@AttachmentCode", AttachmentCode))
                    connection.Open()
                    command.ExecuteNonQuery()
                    connection.Close()
                    command.Dispose()
                End Using
            End Using
            B = True
        Catch ex As Exception
            Debug.Print(ex.Message)
            B = False
        End Try
        Return B
    End Function

    Public Function UpdateAttachmentByFQN(ByVal FQN$, ByVal EmailGUID As String, ByVal AttachmentName$, ByVal AttachmentCode$) As Boolean
        Dim B As Boolean = False
        Try
            Dim AttachmentBinary() As Byte = CF.FileToByte(FQN)
            Using connection As New SqlConnection(Me.getConnStr)
                Using command As New SqlCommand("UpdateAttachment", connection)
                    command.CommandType = CommandType.StoredProcedure
                    command.Parameters.Add(New SqlParameter("@EmailGuid", EmailGUID))
                    command.Parameters.Add(New SqlParameter("@Attachment", AttachmentBinary))
                    command.Parameters.Add(New SqlParameter("@AttachmentName", AttachmentName))
                    command.Parameters.Add(New SqlParameter("@AttachmentCode", AttachmentCode))
                    connection.Open()
                    command.ExecuteNonQuery()
                    connection.Close()
                    command.Dispose()
                End Using
            End Using
            B = True
        Catch ex As Exception
            Debug.Print(ex.Message)
            B = False
        End Try
        Return B
    End Function

    Public Function InsertAttachment(ByVal EmailGUID As String, ByVal AttachmentBinary() As Byte, ByVal AttachmentName$, ByVal AttachmentCode$) As Boolean
        Dim B As Boolean = False
        Try
            Using connection As New SqlConnection(Me.getConnStr)
                Using command As New SqlCommand("InsertAttachment", connection)
                    command.CommandType = CommandType.StoredProcedure
                    command.Parameters.Add(New SqlParameter("@EmailGuid", EmailGUID))
                    command.Parameters.Add(New SqlParameter("@Attachment", AttachmentBinary))
                    command.Parameters.Add(New SqlParameter("@AttachmentName", AttachmentName))
                    command.Parameters.Add(New SqlParameter("@AttachmentCode", AttachmentCode))
                    connection.Open()
                    command.ExecuteNonQuery()
                End Using
            End Using
            B = True
        Catch ex As Exception
            Debug.Print(ex.Message)
            B = False
        End Try
        Return B
    End Function

    Public Function InsertAttachmentFqn(ByVal FQN$, ByVal EmailGUID As String, ByVal AttachmentName$, ByVal AttachmentCode$) As Boolean
        Dim B As Boolean = False
        Dim AttachmentBinary() As Byte = CF.FileToByte(FQN)
        Try
            Using connection As New SqlConnection(Me.getConnStr)
                Using command As New SqlCommand("InsertAttachment", connection)
                    command.CommandType = CommandType.StoredProcedure
                    command.Parameters.Add(New SqlParameter("@EmailGuid", EmailGUID))
                    command.Parameters.Add(New SqlParameter("@Attachment", AttachmentBinary))
                    command.Parameters.Add(New SqlParameter("@AttachmentName", AttachmentName))
                    command.Parameters.Add(New SqlParameter("@AttachmentCode", AttachmentCode))
                    command.Parameters.Add(New SqlParameter("@UserID", CurrUserGuidID))
                    connection.Open()
                    command.ExecuteNonQuery()
                End Using
            End Using
            B = True
        Catch ex As Exception
            Debug.Print(ex.Message)
            B = False
        End Try
        Return B
    End Function

    Public Function UpdateEmailBinary(ByVal FQN$, ByVal EmailGUID As String) As Boolean
        Dim B As Boolean = False
        Dim EmailBinary() As Byte = CF.FileToByte(FQN)
        Try
            Using connection As New SqlConnection(Me.getConnStr)
                Using command As New SqlCommand("spUpdateEmailMsg", connection)
                    command.CommandType = CommandType.StoredProcedure
                    command.Parameters.Add(New SqlParameter("@EmailGuid", EmailGUID))
                    command.Parameters.Add(New SqlParameter("@EmailImage", EmailBinary))
                    connection.Open()
                    command.ExecuteNonQuery()
                End Using
            End Using
            B = True
        Catch ex As Exception
            Debug.Print(ex.Message)
            B = False
        End Try
        Return B
    End Function

    Public Function InsertSourcefile(ByVal SourceGuid As String,
                   ByVal UploadFQN$,
                   ByVal SourceName$,
                   ByVal SourceTypeCode$,
                   ByVal LastAccessDate$,
                   ByVal CreateDate$,
                   ByVal LastWriteTime$, ByVal DataSourceOwnerUserID$, ByVal VersionNbr As Integer) As Boolean

        Dim B As Boolean = False

        UploadFQN$ = DMA.RemoveSingleQuotes(UploadFQN$)
        SourceName$ = DMA.RemoveSingleQuotes(SourceName$)
        SourceTypeCode$ = DMA.RemoveSingleQuotes(SourceTypeCode$)
        LastAccessDate$ = DMA.RemoveSingleQuotes(LastAccessDate$)
        CreateDate$ = DMA.RemoveSingleQuotes(CreateDate$)
        LastWriteTime$ = DMA.RemoveSingleQuotes(LastWriteTime$)
        DataSourceOwnerUserID$ = DMA.RemoveSingleQuotes(DataSourceOwnerUserID$)

        UploadFQN = DMA.ReplaceSingleQuotes(UploadFQN)

        Dim AttachmentBinary() As Byte = CF.FileToByte(UploadFQN)

        UploadFQN$ = DMA.RemoveSingleQuotes(UploadFQN$)

        Try
            Using connection As New SqlConnection(Me.getConnStr)
                Using command As New SqlCommand("InsertDataSource", connection)
                    command.CommandType = CommandType.StoredProcedure

                    '@SourceGuid nvarchar(50),
                    '@FQN nvarchar(50),
                    '@SourceName varchar(254),
                    '@SourceImage image,
                    '@SourceTypeCode varchar(50),
                    '@LastAccessDate datetime,
                    '@CreateDate datetime,
                    '@LastWriteTime datetime,
                    '@VersionNbr int,
                    '@DataSourceOwnerUserID varchar(50)

                    command.Parameters.Add(New SqlParameter("@SourceGuid", SourceGuid))
                    command.Parameters.Add(New SqlParameter("@FQN", UploadFQN))
                    command.Parameters.Add(New SqlParameter("@SourceName", SourceName))
                    command.Parameters.Add(New SqlParameter("@SourceImage", AttachmentBinary))
                    command.Parameters.Add(New SqlParameter("@SourceTypeCode", SourceTypeCode))

                    command.Parameters.Add(New SqlParameter("@LastAccessDate", LastAccessDate))
                    command.Parameters.Add(New SqlParameter("@CreateDate", CreateDate))
                    command.Parameters.Add(New SqlParameter("@LastWriteTime", LastWriteTime))

                    command.Parameters.Add(New SqlParameter("@DataSourceOwnerUserID", DataSourceOwnerUserID))
                    command.Parameters.Add(New SqlParameter("@VersionNbr", VersionNbr))

                    connection.Open()
                    command.ExecuteNonQuery()
                End Using
            End Using
            B = True
        Catch ex As Exception
            Debug.Print(ex.Message)
            Debug.Print("Filetype: " + SourceTypeCode)
            B = False
        End Try
        Return B
    End Function

    Public Function UpdateSourcefile(ByVal SourceGuid As String, ByVal LastAccessDate$, ByVal CreateDate$, ByVal LastWriteTime$, ByVal VersionNbr As Integer, ByVal UploadFQN$) As Boolean

        Dim B As Boolean = False

        'UploadFQN$ = DMA.RemoveSingleQuotes(UploadFQN$)
        'SourceName$ = DMA.RemoveSingleQuotes(SourceName$)
        'SourceTypeCode$ = DMA.RemoveSingleQuotes(SourceTypeCode$)
        LastAccessDate$ = DMA.RemoveSingleQuotes(LastAccessDate$)
        CreateDate$ = DMA.RemoveSingleQuotes(CreateDate$)
        LastWriteTime$ = DMA.RemoveSingleQuotes(LastWriteTime$)
        'DataSourceOwnerUserID$ = DMA.RemoveSingleQuotes(DataSourceOwnerUserID$)

        'UploadFQN = DMA.ReplaceSingleQuotes(UploadFQN)

        Dim AttachmentBinary() As Byte = CF.FileToByte(UploadFQN)

        'UploadFQN$ = DMA.RemoveSingleQuotes(UploadFQN$)

        Try
            Using connection As New SqlConnection(Me.getConnStr)
                Using command As New SqlCommand("UpdateDataSourceImage", connection)
                    command.CommandType = CommandType.StoredProcedure

                    '@SourceGuid nvarchar(50),
                    '@SourceImage image,
                    '@LastAccessDate datetime,
                    '@LastWriteTime datetime,
                    '@VersionNbr int

                    command.Parameters.Add(New SqlParameter("@SourceGuid", SourceGuid))
                    command.Parameters.Add(New SqlParameter("@SourceImage", AttachmentBinary))
                    command.Parameters.Add(New SqlParameter("@LastAccessDate", LastAccessDate))
                    command.Parameters.Add(New SqlParameter("@LastWriteTime", LastWriteTime))
                    command.Parameters.Add(New SqlParameter("@VersionNbr", VersionNbr))

                    connection.Open()
                    command.ExecuteNonQuery()
                End Using
            End Using
            B = True
        Catch ex As Exception
            Debug.Print(ex.Message)
            xTrace(7321, "UpdateSourcefile: ", ex.Message.ToString, ex)
            B = False
        End Try
        Return B
    End Function

    Public Function updateSourcefile(ByVal SourceGuid As String,
                   ByVal UploadFQN$,
                   ByVal StoredExternally As Boolean,
                   ByVal SourceName$,
                   ByVal SourceTypeCode$,
                   ByVal LastAccessDate$,
                   ByVal CreateDate$,
                   ByVal LastWriteTime$) As Boolean

        'create PROCEDURE [dbo].[UpdateDataSource]
        '@SourceGuid nvarchar(50),
        '@FQN nvarchar(50),
        '@SourceName varchar(254),
        '@SourceImage image,
        '@SourceTypeCode varchar(50),
        '@LastAccessDate datetime,
        '@CreateDate datetime,
        '@LastWriteTime datetime

        Dim B As Boolean = False

        Dim AttachmentBinary() As Byte = CF.FileToByte(UploadFQN)

        Try
            Using connection As New SqlConnection(Me.getConnStr)
                Using command As New SqlCommand("UpdateDataSource", connection)
                    command.CommandType = CommandType.StoredProcedure

                    'ALTER PROCEDURE [dbo].[InsertDataSource]
                    '@SourceGuid nvarchar(50),
                    '@FQN nvarchar(50),
                    '@SourceName varchar(254),
                    '@SourceImage image,
                    '@SourceTypeCode varchar(50),
                    '@LastAccessDate datetime,
                    '@CreateDate datetime,
                    '@LastWriteTime datetime

                    command.Parameters.Add(New SqlParameter("@SourceGuid", SourceGuid))
                    command.Parameters.Add(New SqlParameter("@FQN", UploadFQN))
                    command.Parameters.Add(New SqlParameter("@StoredExternally", StoredExternally))
                    command.Parameters.Add(New SqlParameter("@SourceName", SourceName))
                    command.Parameters.Add(New SqlParameter("@SourceImage", AttachmentBinary))
                    command.Parameters.Add(New SqlParameter("@SourceTypeCode", SourceTypeCode))

                    command.Parameters.Add(New SqlParameter("@LastAccessDate", LastAccessDate))
                    command.Parameters.Add(New SqlParameter("@CreateDate", CreateDate))
                    command.Parameters.Add(New SqlParameter("@LastWriteTime", LastWriteTime))

                    connection.Open()
                    command.ExecuteNonQuery()
                End Using
            End Using
            B = True
        Catch ex As Exception
            Debug.Print(ex.Message)
            B = False
        End Try
        Return B
    End Function

    Public Function isSourcefileOlderThanLastEntry(ByVal UserID$, ByVal SourceGuid As String,
                   ByVal UploadFQN$,
                   ByVal SourceName$,
                   ByVal SourceTypeCode$,
                   ByVal FileLength$,
                   ByVal LastAccessDate$,
                   ByVal CreateDate$,
                   ByVal LastWriteTime$, ByVal VersionNbr$) As Boolean

        Dim B As Boolean = False
        UploadFQN$ = DMA.RemoveSingleQuotes(UploadFQN$)
        Dim SQL As String = ""
        SQL = "SELECT  "
        SQL = SQL + "  [FileLength]"
        SQL = SQL + " ,[LastAccessDate]"
        SQL = SQL + " ,[CreateDate]"
        SQL = SQL + " ,[LastWriteTime]"
        SQL = SQL + " FROM DataSource "
        SQL = SQL + " where FQN = '" + UploadFQN$ + "' "
        SQL = SQL + " and VersionNbr = " + VersionNbr$
        SQL = SQL + " and DataSourceOwnerUserID = '" + UserID$ + "'"

        Dim i As Integer = 0
        Dim id$ = ""

        Dim rsData As SqlDataReader = Nothing

        rsData = SqlQry(SQL)
        If rsData.HasRows Then
            rsData.Read()
            Dim tFileLength$ = rsData.GetValue(0).ToString
            Dim tLastAccessDate$ = rsData.GetValue(1).ToString
            Dim tCreateDate$ = rsData.GetValue(2).ToString
            Dim tLastWriteTime$ = rsData.GetValue(3).ToString

            If Val(FileLength$) <> Val(tFileLength$) Then
                B = True
                'ElseIf LastAccessDate$ <> tLastAccessDate$ Then
                '    B = True
            ElseIf CreateDate$ <> tCreateDate$ Then
                B = True
                'ElseIf LastWriteTime$ <> tLastWriteTime$ Then
                '    B = True
            ElseIf CDate(LastWriteTime) > CDate(tLastWriteTime$) Then
                B = True
            End If
        Else
            id = ""
        End If
        rsData.Close()
        rsData = Nothing

        Return B
    End Function

    Public Function GetAttachmentFromDB(ByVal EmailGuid$) As Byte()

        Dim con As New SqlConnection(Me.getConnStr)
        Dim da As New SqlDataAdapter("Select * From EmailAttachment where EmailGuid = '" & EmailGuid & "'", con)
        Dim MyCB As SqlCommandBuilder = New SqlCommandBuilder(da)
        Dim ds As New System.Data.DataSet
        Dim TypeAttachmentCode$ = ""

        con.Open()
        da.Fill(ds, "Attachments")
        Dim myRow As System.Data.DataRow
        myRow = ds.Tables("Attachments").Rows(0)

        Dim MyData() As Byte
        MyData = myRow("Attachment")
        TypeAttachmentCode = myRow("AttachmentCode")

        MyCB = Nothing
        ds = Nothing
        da = Nothing

        con.Close()
        con = Nothing
        Return MyData

    End Function

    ''' <summary>
    ''' Determines if an email has already been stored based on the short subject, received time, and
    ''' the sender's email address.
    ''' </summary>
    ''' <param name="EmailSubj">         The subject of the email.</param>
    ''' <param name="EmailReceivedTime"> The time the email was received.</param>
    ''' <param name="SenderEmailAddress">The email addres of the sender.</param>
    ''' <returns>Boolean</returns>
    ''' <remarks>This funcition, if extended to include other parms in the lookup will be overloaded.</remarks>
    Public Function isEmailStored(ByVal EmailSubj$, ByVal EmailCreationTime$, ByVal EmailReceivedTime$, ByVal EmailSentOn$, ByVal SenderEmailAddress$) As Boolean

        Dim sql As String = ""
        Dim B As Boolean = False
        Dim cnt As Integer = -1

        EmailSubj$ = DMA.RemoveSingleQuotes(EmailSubj$)
        SenderEmailAddress = DMA.RemoveSingleQuotes(SenderEmailAddress)

        sql = " SELECT count(*)"
        sql = sql + " FROM [Email] "
        sql = sql + " where [ShortSubj] = '" + EmailSubj$ + "' "
        sql = sql + " and creationtime = '" + EmailCreationTime$ + "' "
        sql = sql + " and SentOn = '" + EmailSentOn$ + "' "
        sql = sql + " and [ReceivedTime] = '" + EmailReceivedTime$ + "' "
        sql = sql + " and [SenderEmailAddress] = '" + SenderEmailAddress + "' "

        CkConn()

        Using gConn
            Dim command As New SqlCommand(sql, gConn)
            Dim rsCnt As SqlDataReader = Nothing
            rsCnt = SqlQry(sql)
            rsCnt.Read()
            cnt = Val(rsCnt.GetValue(0).ToString)
            rsCnt.Close()
            rsCnt = Nothing
            command.Connection.Close()
            command = Nothing
        End Using

        If cnt > 0 Then
            B = True
        Else
            B = False
        End If

        Return B

    End Function

    Public Function ckBackupFolder(ByVal UserID$, ByVal FolderName$) As Boolean

        Dim sql As String = ""
        Dim B As Boolean = False
        Dim cnt As Integer = -1

        Dim ConnStr = Me.getConnStr
        Dim Conn As New SqlConnection(ConnStr)

        MsgBox("Start Checking Here...")

        sql = " SELECT count(*)"
        sql = sql + " FROM [EmailFolder] "
        sql = sql + " WHERE [UserID] = '" + UserID + "' "
        sql = sql + " AND [FolderName] = '" + FolderName + "' "
        sql = sql + " AND [ArchiveEmails] = 'Y' "

        Using Conn
            Dim command As New SqlCommand(sql, Conn)
            Dim rsCnt As SqlDataReader = Nothing
            rsCnt = SqlQry(sql)
            rsCnt.Read()
            cnt = Val(rsCnt.GetValue(0).ToString)
            rsCnt.Close()
            rsCnt = Nothing
            command.Connection.Close()
            command = Nothing
        End Using

        If cnt > 0 Then
            B = True
        Else
            B = False
        End If

        If Conn.State = ConnectionState.Open Then
            Conn.Close()
        End If

        Conn = Nothing

        Return B

    End Function

    Public Sub delSubDirs(ByVal UID$, ByVal FQN$)
        Dim tSql As String = ""
        Dim B As Boolean = False
        Dim cnt As Integer = -1

        Dim ConnStr = Me.getConnStr
        Dim Conn As New SqlConnection(ConnStr)

        tSql = "delete FROM [SubDir] where [UserID] = '" + UID + "' and [FQN] = '" + FQN + "' "

        Using Conn
            If Conn.State = ConnectionState.Closed Then
                Conn.Open()
            End If
            Me.ExecuteSql(tSql)
        End Using

    End Sub

    Public Sub delFileParms(ByVal SGUID$)
        Dim tSql As String = ""
        Dim B As Boolean = False
        Dim cnt As Integer = -1

        CkConn()

        'Dim ConnStr = System.Configuration.ConfigurationManager.AppSettings(ConnStrID)
        'Dim Conn As New SqlConnection(ConnStr)

        tSql = "DELETE FROM [SourceAttribute] WHERE SourceGuid = '" + SGUID + "'"

        Using gConn
            If gConn.State = ConnectionState.Closed Then
                gConn.Open()
            End If
            B = Me.ExecuteSql(tSql)
        End Using

    End Sub

    ''' <summary>
    ''' Looks to see what filetypes have been defined to the system It looks in table AvailFileTypes.
    ''' </summary>
    ''' <returns>Bolean True/False</returns>
    ''' <remarks></remarks>
    Public Function ckFileExtExists() As Boolean
        Dim tSql As String = ""
        Dim B As Boolean = False
        Dim cnt As Integer = -1

        Dim ConnStr = Me.getConnStr
        Dim Conn As New SqlConnection(ConnStr)

        tSql = "SELECT count(*) FROM [AvailFileTypes]"

        Using Conn
            If Conn.State = ConnectionState.Closed Then
                Conn.Open()
            End If

            Dim command As New SqlCommand(tSql, Conn)
            Dim rsCnt As SqlDataReader = Nothing
            rsCnt = command.ExecuteReader()
            rsCnt.Read()
            cnt = Val(rsCnt.GetValue(0).ToString)
            rsCnt.Close()
            rsCnt = Nothing
            command.Connection.Close()
            command = Nothing
            Conn.Close()
            Conn = Nothing
        End Using

        If cnt > 0 Then
            B = True
        Else
            B = False
        End If

        Return B

    End Function

    Public Function ckUserExists(ByVal UserID$) As Boolean
        Dim tSql As String = ""
        Dim B As Boolean = False
        Dim cnt As Integer = -1

        Dim ConnStr = Me.getConnStr
        Dim Conn As New SqlConnection(ConnStr)

        tSql = "SELECT count(*) FROM [Users] where UserID = '" + UserID$ + "' "

        Using Conn
            If Conn.State = ConnectionState.Closed Then
                Try
                    Conn.Open()
                Catch ex As Exception
                    MsgBox(ex.Message)
                    Return False
                End Try

            End If

            Dim command As New SqlCommand(tSql, Conn)
            Dim rsCnt As SqlDataReader = Nothing
            rsCnt = command.ExecuteReader()
            rsCnt.Read()
            cnt = Val(rsCnt.GetValue(0).ToString)
            rsCnt.Close()
            rsCnt = Nothing
            command.Connection.Close()
            command = Nothing
            Conn.Close()
            Conn = Nothing
        End Using

        If cnt > 0 Then
            B = True
        Else
            B = False
        End If

        Return B

    End Function

    Public Function ckFolderExists(ByVal UserID$, ByVal FolderName$) As Boolean
        Try
            Dim tSql As String = ""
            Dim B As Boolean = False
            Dim cnt As Integer = -1

            Dim ConnStr = Me.getConnStr
            Dim Conn As New SqlConnection(ConnStr)

            tSql = "SELECT count(*) FROM [EmailArchParms] where [UserID] = '" + UserID$ + "' and [FolderName] = '" + FolderName$ + "' "

            Using Conn
                If Conn.State = ConnectionState.Closed Then
                    Conn.Open()
                End If

                Dim command As New SqlCommand(tSql, Conn)
                Dim rsCnt As SqlDataReader = Nothing
                rsCnt = command.ExecuteReader()
                rsCnt.Read()
                cnt = Val(rsCnt.GetValue(0).ToString)
                rsCnt.Close()
                rsCnt = Nothing
                command.Connection.Close()
                command = Nothing
                Conn.Close()
                Conn = Nothing
            End Using

            If cnt > 0 Then
                B = True
            Else
                B = False
            End If

            Return B
        Catch ex As Exception
            MsgBox("ERROR 1121.3 - " + ex.Message)
            Return False
        End Try

    End Function

    Public Function ckMasterExists(ByVal FileName$, ByVal TblName$, ByVal ColName$, Optional ByVal SourceGuid$ = Nothing) As Boolean
        'SELECT count(*) FROM [DMA.UD].[dbo].[DataSource] where [SourceName] = 'Current State of ECM.docx' and [isMaster] = 'Y'

        'SELECT SourceName FROM [DMA.UD].[dbo].[DataSource] where SourceGuid = 'XX'

        If SourceGuid = Nothing Then
        Else
            FileName$ = Me.getFilenameByGuid(SourceGuid)
        End If

        Try
            Dim tSql As String = ""
            Dim B As Boolean = False
            Dim cnt As Integer = -1

            Dim ConnStr = Me.getConnStr
            Dim Conn As New SqlConnection(ConnStr)

            tSql = "SELECT count(*) FROM [DMA.UD].[dbo].[DataSource] where [SourceName] = '" + FileName$ + "' and [isMaster] = 'Y'"

            Using Conn
                If Conn.State = ConnectionState.Closed Then
                    Conn.Open()
                End If

                Dim command As New SqlCommand(tSql, Conn)
                Dim rsCnt As SqlDataReader = Nothing
                rsCnt = command.ExecuteReader()
                rsCnt.Read()
                cnt = Val(rsCnt.GetValue(0).ToString)
                rsCnt.Close()
                rsCnt = Nothing
                command.Connection.Close()
                command = Nothing
                Conn.Close()
                Conn = Nothing
            End Using

            If cnt > 0 Then
                B = True
            Else
                B = False
            End If

            Return B
        Catch ex As Exception
            MsgBox("ERROR 1121.3 - " + ex.Message)
            Return False
        End Try

    End Function

    Public Function ckParmsFolderExists(ByVal UserID$, ByVal FolderName$) As Boolean
        Try
            Dim tSql As String = ""
            Dim B As Boolean = False
            Dim cnt As Integer = -1

            Dim ConnStr = Me.getConnStr
            Dim Conn As New SqlConnection(ConnStr)

            tSql = "SELECT count(*) FROM [EmailArchParms] where [UserID] = '" + UserID$ + "' and [FolderName] = '" + FolderName$ + "' "

            Using Conn
                If Conn.State = ConnectionState.Closed Then
                    Conn.Open()
                End If

                Dim command As New SqlCommand(tSql, Conn)
                Dim rsCnt As SqlDataReader = Nothing
                rsCnt = command.ExecuteReader()
                rsCnt.Read()
                cnt = Val(rsCnt.GetValue(0).ToString)
                rsCnt.Close()
                rsCnt = Nothing
                command.Connection.Close()
                command = Nothing
                Conn.Close()
                Conn = Nothing
            End Using

            If cnt > 0 Then
                B = True
            Else
                B = False
            End If

            Return B
        Catch ex As Exception
            MsgBox("ERROR 1121.3 - " + ex.Message)
            Return False
        End Try

    End Function

    Public Function SelectOneEmailParm(ByVal WhereClause$) As Array

        Dim A$(10)
        Dim ConnStr = Me.getConnStr
        Dim Conn As New SqlConnection(ConnStr)

        Dim b As Boolean = False
        Dim s As String = ""

        s = s + " SELECT "
        s = s + "UserID,"
        s = s + "ArchiveEmails,"
        s = s + "RemoveAfterArchive,"
        s = s + "SetAsDefaultFolder,"
        s = s + "ArchiveAfterXDays,"
        s = s + "RemoveAfterXDays,"
        s = s + "RemoveXDays,"
        s = s + "ArchiveXDays,"
        s = s + "FolderName,"
        s = s + "DB_ID ,"
        s = s + "ArchiveOnlyIfRead "
        s = s + " FROM EmailArchParms "
        s = s + WhereClause

        Using Conn
            If Conn.State = ConnectionState.Closed Then
                Conn.Open()
            End If

            Dim command As New SqlCommand(s, Conn)
            Dim rsCnt As SqlDataReader = Nothing
            rsCnt = command.ExecuteReader()
            If rsCnt.HasRows Then
                rsCnt.Read()
                A(0) = rsCnt.GetValue(0).ToString
                A(1) = rsCnt.GetValue(1).ToString
                A(2) = rsCnt.GetValue(2).ToString
                A(3) = rsCnt.GetValue(3).ToString
                A(4) = rsCnt.GetValue(4).ToString
                A(5) = rsCnt.GetValue(5).ToString
                A(6) = rsCnt.GetValue(6).ToString
                A(7) = rsCnt.GetValue(7).ToString
                A(8) = rsCnt.GetValue(8).ToString
                A(9) = rsCnt.GetValue(9).ToString
                A(10) = rsCnt.GetValue(10).ToString
                'UserID = a(0)
                'ArchiveEmails = a(1)
                'RemoveAfterArchive = a(2)
                'SetAsDefaultFolder = a(3)
                'ArchiveAfterXDays = a(4)
                'RemoveAfterXDays = a(5)
                'RemoveXDays = a(6)
                'ArchiveXDays = a(7)
                'FolderName = a(8)
                'DB_ID = a(9)
            End If
            rsCnt.Close()
            rsCnt = Nothing
            command.Connection.Close()
            command = Nothing
            Conn.Close()
            Conn = Nothing
        End Using
        Return A
    End Function

    Public Sub LoadAvailFileTypes(ByRef CB As ComboBox)
        CB.Items.Clear()
        Dim A$(9)
        Dim ConnStr = Me.getConnStr
        Dim Conn As New SqlConnection(ConnStr)
        Dim b As Boolean = False
        Dim s As String = ""

        s = " SELECT [ExtCode] FROM [AvailFileTypes] "
        Using Conn
            If Conn.State = ConnectionState.Closed Then
                Conn.Open()
            End If
            Dim command As New SqlCommand(s, Conn)
            Dim rsCnt As SqlDataReader = Nothing
            rsCnt = command.ExecuteReader()
            If rsCnt.HasRows Then
                Do While rsCnt.Read()
                    Dim SS$ = rsCnt.GetValue(0).ToString
                    CB.Items.Add(SS)
                Loop
            End If
            rsCnt.Close()
            rsCnt = Nothing
            command.Connection.Close()
            command = Nothing
            Conn.Close()
            Conn = Nothing
        End Using
    End Sub

    Public Sub LoadAvailUsers(ByRef CB As ComboBox)
        CB.Items.Clear()
        Dim A$(9)
        Dim ConnStr = Me.getConnStr
        Dim Conn As New SqlConnection(ConnStr)
        Dim b As Boolean = False
        Dim s As String = ""

        s = " SELECT UserLoginID FROM Users "
        Using Conn
            If Conn.State = ConnectionState.Closed Then
                Conn.Open()
            End If
            Dim command As New SqlCommand(s, Conn)
            Dim rsCnt As SqlDataReader = Nothing
            rsCnt = command.ExecuteReader()
            If rsCnt.HasRows Then
                Do While rsCnt.Read()
                    Dim SS$ = rsCnt.GetValue(0).ToString
                    CB.Items.Add(SS)
                Loop
            End If
            rsCnt.Close()
            rsCnt = Nothing
            command.Connection.Close()
            command = Nothing
            Conn.Close()
            Conn = Nothing
        End Using
    End Sub

    Public Sub LoadAvailFileTypes(ByRef LB As ListBox)
        LB.Items.Clear()
        Dim A$(9)
        Dim ConnStr = Me.getConnStr
        Dim Conn As New SqlConnection(ConnStr)
        Dim b As Boolean = False
        Dim s As String = ""

        s = " SELECT [ExtCode] FROM [AvailFileTypes] "
        Using Conn
            If Conn.State = ConnectionState.Closed Then
                Conn.Open()
            End If

            Dim command As New SqlCommand(s, Conn)
            Dim rsCnt As SqlDataReader = Nothing
            rsCnt = command.ExecuteReader()
            If rsCnt.HasRows Then
                Do While rsCnt.Read()
                    Dim SS$ = rsCnt.GetValue(0).ToString
                    LB.Items.Add(SS)
                Loop
            End If
            rsCnt.Close()
            rsCnt = Nothing
            command.Connection.Close()
            command = Nothing
            Conn.Close()
            Conn = Nothing
        End Using
    End Sub

    Public Sub LoadIncludedFileTypes(ByRef LB As ListBox, ByVal UserID$, ByVal DirName$)
        LB.Items.Clear()
        Dim A$(9)
        Dim ConnStr = Me.getConnStr
        Dim Conn As New SqlConnection(ConnStr)
        Dim b As Boolean = False
        Dim s As String = ""

        s = " SELECT [UserID]"
        s = s + " ,[ExtCode]"
        s = s + " ,[FQN]"
        s = s + " FROM IncludedFiles "
        s = s + " where Userid = '" + UserID + "' "
        s = s + " and FQN = '" + DirName + "'"

        Using Conn
            If Conn.State = ConnectionState.Closed Then
                Conn.Open()
            End If

            Dim command As New SqlCommand(s, Conn)
            Dim rsCnt As SqlDataReader = Nothing
            rsCnt = command.ExecuteReader()
            If rsCnt.HasRows Then
                Do While rsCnt.Read()
                    Dim SS$ = rsCnt.GetValue(1).ToString
                    LB.Items.Add(SS)
                Loop
            End If
            rsCnt.Close()
            rsCnt = Nothing
            command.Connection.Close()
            command = Nothing
            Conn.Close()
            Conn = Nothing
        End Using
    End Sub

    Public Sub LoadExcludedFileTypes(ByRef LB As ListBox, ByVal UserID$, ByVal DirName$)
        LB.Items.Clear()
        Dim A$(9)
        Dim ConnStr = Me.getConnStr
        Dim Conn As New SqlConnection(ConnStr)
        Dim b As Boolean = False
        Dim s As String = ""

        s = " SELECT [UserID]"
        s = s + " ,[ExtCode]"
        s = s + " ,[FQN]"
        s = s + " FROM ExcludedFiles "
        s = s + " where Userid = '" + UserID + "' "
        s = s + " and FQN = '" + DirName + "'"

        Using Conn
            If Conn.State = ConnectionState.Closed Then
                Conn.Open()
            End If

            Dim command As New SqlCommand(s, Conn)
            Dim rsCnt As SqlDataReader = Nothing
            rsCnt = command.ExecuteReader()
            If rsCnt.HasRows Then
                Do While rsCnt.Read()
                    Dim SS$ = rsCnt.GetValue(1).ToString
                    LB.Items.Add(SS)
                Loop
            End If
            rsCnt.Close()
            rsCnt = Nothing
            command.Connection.Close()
            command = Nothing
            Conn.Close()
            Conn = Nothing
        End Using
    End Sub

    Sub GetActiveEmailFolders(ByRef LB As ListBox, ByVal UserID$, ByVal CF As SortedList(Of String, String))

        Dim S = " Select distinct FolderName "
        S = S + " FROM EmailFolder "
        S = S + " where (UserID = '" + UserID + "' "
        S = S + " and SelectedForArchive = 'Y') "
        S = S + " or isSysDefault = 1 "
        S = S + " order by FolderName "

        LB.Items.Clear()
        Dim A$(9)
        Dim ConnStr = Me.getConnStr
        Dim Conn As New SqlConnection(ConnStr)
        Dim b As Boolean = False

        Using Conn
            If Conn.State = ConnectionState.Closed Then
                Conn.Open()
            End If

            Dim command As New SqlCommand(S, Conn)
            Dim rsCnt As SqlDataReader = Nothing
            rsCnt = command.ExecuteReader()
            If rsCnt.HasRows Then
                Do While rsCnt.Read()
                    Dim SS$ = rsCnt.GetValue(0).ToString
                    LB.Items.Add(SS)
                    'If CF.ContainsKey(SS) Then
                    '    LB.Items.Add(SS)
                    'End If
                Loop
            End If
            rsCnt.Close()
            rsCnt = Nothing
            command.Connection.Close()
            command = Nothing
            Conn.Close()
            Conn = Nothing

            'Dim MySql$ = "Update EmailFolder set SelectedForArchive = NULL where UserID = '" + CurrUserGuidID + "'"
            'Dim BB As Boolean = ExecuteSqlNoTx(MySql)

            Dim MySql$ = ""
            Dim BB As Boolean = True

            Dim B1 As Boolean = False
            If BB Then
                For II As Integer = 0 To LB.Items.Count - 1
                    ActivateArchiveFolder(LB.Items(II).ToString, UserID$)
                Next
            End If

        End Using

    End Sub

    Sub ActivateArchiveFolder(ByVal FolderName$, ByVal UserID$)
        Dim MySql$ = "Update EmailFolder set SelectedForArchive = 'Y' where UserID = '" + UserID$ + "' and FolderName = '" + FolderName$ + "'"
        Dim B1 As Boolean = ExecuteSqlNoTx(MySql)
        If Not B1 Then
            MsgBox("Failed to Activate folder " + FolderName$)
        End If
    End Sub

    Sub deActivateArchiveFolder(ByVal FolderName$, ByVal UserID$)
        Dim MySql$ = "Update EmailFolder set SelectedForArchive = 'N' where UserID = '" + UserID$ + "' and FolderName = '" + FolderName$ + "'"
        Dim B1 As Boolean = ExecuteSqlNoTx(MySql)
        If Not B1 Then
            MsgBox("Failed to Activate folder " + FolderName$)
        End If
    End Sub

    Sub setActiveEmailFolders(ByVal UserID$, ByVal CF As SortedList(Of String, String))
        Dim SLB As New SortedList
        Dim S = " Select FolderName "
        S = S + " FROM EmailFolder "
        S = S + " where UserID = '" + UserID + "' and SelectedForArchive = 'Y' order by FolderName "

        Dim A$(9)
        Dim ConnStr = Me.getConnStr
        Dim Conn As New SqlConnection(ConnStr)
        Dim b As Boolean = False

        Using Conn
            If Conn.State = ConnectionState.Closed Then
                Conn.Open()
            End If

            Dim command As New SqlCommand(S, Conn)
            Dim rsCnt As SqlDataReader = Nothing
            rsCnt = command.ExecuteReader()
            If rsCnt.HasRows Then
                Do While rsCnt.Read()
                    Dim SS$ = rsCnt.GetValue(0).ToString
                    Dim bKeyExists As Integer = -1
                    bKeyExists = SLB.IndexOfKey(SS)
                    If bKeyExists < 0 Then
                        'If CF.ContainsKey(SS) Then
                        '    SLB.Add(SS, SS)
                        'End If
                        SLB.Add(SS, SS)
                    End If
                Loop
            End If
            rsCnt.Close()
            rsCnt = Nothing
            command.Connection.Close()
            command = Nothing
            Conn.Close()
            Conn = Nothing

            Dim MySql$ = "Update EmailFolder set SelectedForArchive = 'N' where UserID = '" + UserID$ + "'"
            Dim BB As Boolean = ExecuteSqlNoTx(MySql)
            Dim B1 As Boolean = False
            If BB Then
                For II As Integer = 0 To SLB.Count - 1
                    Debug.Print(SLB.GetKey(II).ToString)
                    MySql$ = "Update EmailFolder set SelectedForArchive = 'Y' where UserID = '" + UserID$ + "' and FolderName = '" + SLB.GetKey(II).ToString + "'"
                    B1 = ExecuteSqlNoTx(MySql)
                    If Not B1 Then
                        MsgBox("Failed to set the Selected For Archive flag for folder " + SLB.GetKey(II).ToString)
                    End If
                Next
            End If

        End Using

    End Sub

    Sub GetDirectoryData(ByVal UserID$, ByVal FQN$, ByRef DBID$, ByRef IncludeSubDirs$, ByRef VersionFiles$, ByRef FolderDisabled$, ByRef ckMetaData$, ByRef ckPublic$)

        Dim S = "SELECT IncludeSubDirs, DB_ID, VersionFiles, ckDisableDir, ckMetaData, ckPublic FROM [Directory] where [UserID] = '" + UserID + "' and FQN = '" + FQN + "'"
        Dim A$(9)
        Dim ConnStr = Me.getConnStr
        Dim Conn As New SqlConnection(ConnStr)
        Dim b As Boolean = False

        Using Conn
            If Conn.State = ConnectionState.Closed Then
                Conn.Open()
            End If

            Dim command As New SqlCommand(S, Conn)
            Dim rsCnt As SqlDataReader = Nothing
            rsCnt = command.ExecuteReader()
            If rsCnt.HasRows Then
                Do While rsCnt.Read()
                    DBID = rsCnt.GetValue(1).ToString
                    IncludeSubDirs = rsCnt.GetValue(0).ToString
                    VersionFiles$ = rsCnt.GetValue(2).ToString
                    FolderDisabled$ = rsCnt.GetValue(3).ToString
                    ckMetaData = rsCnt.GetValue(4).ToString
                    ckPublic = rsCnt.GetValue(5).ToString
                Loop
            End If
            rsCnt.Close()
            rsCnt = Nothing
            command.Connection.Close()
            command = Nothing
            Conn.Close()
            Conn = Nothing
        End Using

    End Sub

    Sub GetDirectories(ByRef LB As ListBox, ByVal UserID$)

        Dim S = " SELECT  [FQN] FROM [Directory] where [UserID] = '" + UserID + "' and (QuickRefEntry = 0  or QuickRefEntry is null) or isSysDefault = 1 "

        LB.Items.Clear()
        Dim A$(9)
        Dim ConnStr = Me.getConnStr
        Dim Conn As New SqlConnection(ConnStr)
        Dim b As Boolean = False

        Using Conn
            If Conn.State = ConnectionState.Closed Then
                Conn.Open()
            End If

            Dim command As New SqlCommand(S, Conn)
            Dim rsCnt As SqlDataReader = Nothing
            rsCnt = command.ExecuteReader()
            If rsCnt.HasRows Then
                Do While rsCnt.Read()
                    Dim SS$ = rsCnt.GetValue(0).ToString
                    If System.IO.Directory.Exists(SS$) Then
                        LB.Items.Add(SS)
                    End If
                Loop
            End If
            rsCnt.Close()
            rsCnt = Nothing
            command.Connection.Close()
            command = Nothing
            Conn.Close()
            Conn = Nothing
        End Using

    End Sub

    Sub GetIncludedFiles(ByRef LB As ListBox, ByVal UserID$, ByVal FQN$)
        FQN$ = DMA.RemoveSingleQuotes(FQN$)
        Dim S = "SELECT [ExtCode] FROM [IncludedFiles] where [UserID] = '" + UserID$ + "'  and [FQN] = '" + FQN$ + "'"

        LB.Items.Clear()
        Dim A$(9)
        Dim ConnStr = Me.getConnStr
        Dim Conn As New SqlConnection(ConnStr)
        Dim b As Boolean = False

        Using Conn
            If Conn.State = ConnectionState.Closed Then
                Conn.Open()
            End If

            Dim command As New SqlCommand(S, Conn)
            Dim rsCnt As SqlDataReader = Nothing
            rsCnt = command.ExecuteReader()
            If rsCnt.HasRows Then
                Do While rsCnt.Read()
                    Dim SS$ = rsCnt.GetValue(0).ToString
                    LB.Items.Add(SS)
                Loop
            End If
            rsCnt.Close()
            rsCnt = Nothing
            command.Connection.Close()
            command = Nothing
            Conn.Close()
            Conn = Nothing
        End Using

    End Sub

    Sub GetActiveDatabases(ByRef CB As ComboBox)

        Dim S = " SELECT [DB_ID] FROM [Databases] "

        CB.Items.Clear()
        Dim A$(9)
        Dim ConnStr = Me.getConnStr
        Dim Conn As New SqlConnection(ConnStr)
        Dim b As Boolean = False

        Using Conn
            If Conn.State = ConnectionState.Closed Then
                Conn.Open()
            End If

            Dim command As New SqlCommand(S, Conn)
            Dim rsCnt As SqlDataReader = Nothing
            rsCnt = command.ExecuteReader()
            If rsCnt.HasRows Then
                Do While rsCnt.Read()
                    Dim SS$ = rsCnt.GetValue(0).ToString
                    CB.Items.Add(SS)
                Loop
            End If
            rsCnt.Close()
            rsCnt = Nothing
            command.Connection.Close()
            command = Nothing
            Conn.Close()
            Conn = Nothing
        End Using

    End Sub

    Public Sub GetProcessAsList(ByRef CB As ComboBox)

        Dim S = "SELECT [ExtCode] ,[ProcessExtCode] FROM [ProcessFileAs] order by [ExtCode],[ProcessExtCode]"

        CB.Items.Clear()
        Dim A$(9)
        Dim ConnStr = Me.getConnStr
        Dim Conn As New SqlConnection(ConnStr)
        Dim b As Boolean = False

        Using Conn
            If Conn.State = ConnectionState.Closed Then
                Conn.Open()
            End If

            Dim command As New SqlCommand(S, Conn)
            Dim rsCnt As SqlDataReader = Nothing
            rsCnt = command.ExecuteReader()
            If rsCnt.HasRows Then
                Do While rsCnt.Read()
                    Dim P$ = rsCnt.GetValue(0).ToString
                    Dim C$ = rsCnt.GetValue(1).ToString
                    CB.Items.Add(P + " --> " + C)
                Loop
            End If
            rsCnt.Close()
            rsCnt = Nothing
            command.Connection.Close()
            command = Nothing
            Conn.Close()
            Conn = Nothing
        End Using

    End Sub

    Public Function ckReconParmExists(ByVal UserID$, ByVal ReconParm$) As Boolean
        Dim tSql As String = ""
        Dim B As Boolean = False
        Dim cnt As Integer = -1

        Dim ConnStr = Me.getConnStr
        Dim Conn As New SqlConnection(ConnStr)

        tSql = "SELECT count(*) FROM [RunParms] "
        tSql = tSql + " where Parm = '" + ReconParm$ + "' "
        tSql = tSql + " and UserID = '" + UserID$ + "'"

        Using Conn
            If Conn.State = ConnectionState.Closed Then
                Conn.Open()
            End If

            Dim command As New SqlCommand(tSql, Conn)
            Dim rsCnt As SqlDataReader = Nothing
            rsCnt = command.ExecuteReader()
            rsCnt.Read()
            cnt = Val(rsCnt.GetValue(0).ToString)
            rsCnt.Close()
            rsCnt = Nothing
            command.Connection.Close()
            command = Nothing
            Conn.Close()
            Conn = Nothing
        End Using

        If cnt > 0 Then
            B = True
        Else
            B = False
        End If

        Return B
    End Function

    Public Function ckProcessAsExists(ByVal Pext$) As Boolean
        Dim tSql As String = ""
        Dim B As Boolean = False
        Dim cnt As Integer = -1

        Dim ConnStr = Me.getConnStr
        Dim Conn As New SqlConnection(ConnStr)

        tSql = "SELECT count(*) FROM [ProcessFileAs] where [ExtCode] = '" + Pext$ + "' "

        Using Conn
            If Conn.State = ConnectionState.Closed Then
                Conn.Open()
            End If

            Dim command As New SqlCommand(tSql, Conn)
            Dim rsCnt As SqlDataReader = Nothing
            rsCnt = command.ExecuteReader()
            rsCnt.Read()
            cnt = Val(rsCnt.GetValue(0).ToString)
            rsCnt.Close()
            rsCnt = Nothing
            command.Connection.Close()
            command = Nothing
            Conn.Close()
            Conn = Nothing
        End Using

        If cnt > 0 Then
            B = True
        Else
            B = False
        End If

        Return B
    End Function

    Public Function ckExtExists(ByVal tExt$) As Boolean
        Dim tSql As String = ""
        Dim B As Boolean = False
        Dim cnt As Integer = -1

        Dim ConnStr = Me.getConnStr
        Dim Conn As New SqlConnection(ConnStr)

        tSql = "SELECT count(*) from AvailFileTypes where ExtCode = '" + tExt + "' "

        Using Conn
            If Conn.State = ConnectionState.Closed Then
                Conn.Open()
            End If

            Dim command As New SqlCommand(tSql, Conn)
            Dim rsCnt As SqlDataReader = Nothing
            rsCnt = command.ExecuteReader()
            rsCnt.Read()
            cnt = Val(rsCnt.GetValue(0).ToString)
            rsCnt.Close()
            rsCnt = Nothing
            command.Connection.Close()
            command = Nothing
            Conn.Close()
            Conn = Nothing
        End Using

        If cnt > 0 Then
            B = True
        Else
            B = False
        End If

        Return B
    End Function

    Public Function ckDirectoryExists(ByVal UserID$, ByVal FQN$) As Boolean
        Dim tSql As String = ""
        Dim B As Boolean = False
        Dim cnt As Integer = -1

        Dim ConnStr = Me.getConnStr
        Dim Conn As New SqlConnection(ConnStr)

        FQN = DMA.RemoveSingleQuotes(FQN)

        tSql = "SELECT count(*) FROM [Directory] "
        tSql = tSql + " where FQN = '" + FQN$ + "' "
        tSql = tSql + " and UserID = '" + UserID$ + "'"

        Using Conn
            If Conn.State = ConnectionState.Closed Then
                Conn.Open()
            End If

            Dim command As New SqlCommand(tSql, Conn)
            Dim rsCnt As SqlDataReader = Nothing
            rsCnt = command.ExecuteReader()
            rsCnt.Read()
            cnt = Val(rsCnt.GetValue(0).ToString)
            rsCnt.Close()
            rsCnt = Nothing
            command.Connection.Close()
            command = Nothing
            Conn.Close()
            Conn = Nothing
        End Using

        If cnt > 0 Then
            B = True
        Else
            B = False
        End If

        Return B
    End Function

    Public Function getRconParm(ByVal UserID$, ByVal ParmID$) As String

        Dim S = " SELECT [ParmValue] FROM [RunParms] where Parm = '" + ParmID$ + "' and UserID = '" + UserID$ + "'"
        Dim SS$ = ""

        Dim ConnStr = Me.getConnStr
        Dim Conn As New SqlConnection(ConnStr)
        Dim b As Boolean = False

        Using Conn
            If Conn.State = ConnectionState.Closed Then
                Conn.Open()
            End If

            Dim command As New SqlCommand(S, Conn)
            Dim rsCnt As SqlDataReader = Nothing
            rsCnt = command.ExecuteReader()
            If rsCnt.HasRows Then
                Do While rsCnt.Read()
                    SS$ = rsCnt.GetValue(0).ToString
                Loop
            End If
            rsCnt.Close()
            rsCnt = Nothing
            command.Connection.Close()
            command = Nothing
            Conn.Close()
            Conn = Nothing
        End Using
        Return SS
    End Function

    Public Function ExecuteSql(ByVal sql As String, ByVal ConnStrID$) As Boolean

        Dim TxName As String = "TX001"
        Dim rc As Boolean = False
        Dim ConnStr As String = ConfigurationManager.AppSettings("DMA_UD_License")
        Dim reader As New System.Configuration.AppSettingsReader
        ConnStr = reader.GetValue("DMA_UD_License", GetType(String))
        'Dim ConnStr = System.Configuration.ConfigurationSettings.AppSettings("DMA_UD_License")
        Dim Conn As New SqlConnection(ConnStr)
        Dim b As Boolean = False

        Using Conn
            If Conn.State = ConnectionState.Closed Then
                Conn.Open()
            End If
            Dim dbCmd As SqlCommand = Conn.CreateCommand()
            dbCmd.Connection = Conn
            Try
                dbCmd.CommandText = sql
                dbCmd.ExecuteNonQuery()
                Dim debug As Boolean = True
                rc = True
            Catch ex As Exception
                rc = False
                Console.WriteLine("Exception Type: {0}", ex.GetType())
                Console.WriteLine("  Message: {0}", ex.Message)
                Console.WriteLine(sql)
                xTrace(0, "ExecuteSql: ", "-----------------------")
                xTrace(1, "ExecuteSql: ", ex.Message.ToString)
                xTrace(2, "ExecuteSql: ", ex.StackTrace.ToString)
                xTrace(3, "ExecuteSql: ", sql)
            End Try
        End Using
        If Conn.State = ConnectionState.Closed Then
            Conn.Close()
        End If
        Conn = Nothing
        Return rc
    End Function

    Function GetEmailDBConnStr(ByRef DBID$) As String

        Dim S = "select DB_CONN_STR from databases where DB_ID = '" + DBID + "' "
        Dim A$(9)
        Dim ConnStr = Me.getConnStr
        Dim Conn As New SqlConnection(ConnStr)
        Dim b As Boolean = False

        Dim DbConnStr$ = ""

        Using Conn
            If Conn.State = ConnectionState.Closed Then
                Conn.Open()
            End If

            Dim command As New SqlCommand(S, Conn)
            Dim rsCnt As SqlDataReader = Nothing
            rsCnt = command.ExecuteReader()
            If rsCnt.HasRows Then
                Do While rsCnt.Read()
                    DbConnStr$ = rsCnt.GetValue(0).ToString
                Loop
            End If
            rsCnt.Close()
            rsCnt = Nothing
            command.Connection.Close()
            command = Nothing
            Conn.Close()
            Conn = Nothing
        End Using

        Return DbConnStr$

    End Function

    Sub GetEmailFolders(ByRef UID$, ByRef aFolders$())

        Dim S = "SELECT "
        S = S + "  [FolderName]"
        S = S + " FROM Email "
        S = S + " where UserID = '" + UID + "' "

        ReDim aFolders$(0)
        Dim I As Integer = 0

        Dim ConnStr = Me.getConnStr
        Dim Conn As New SqlConnection(ConnStr)
        Dim b As Boolean = False

        Dim DbConnStr$ = ""

        Using Conn
            If Conn.State = ConnectionState.Closed Then
                Conn.Open()
            End If

            Dim command As New SqlCommand(S, Conn)
            Dim rsCnt As SqlDataReader = Nothing
            rsCnt = command.ExecuteReader()
            If rsCnt.HasRows Then
                Do While rsCnt.Read()
                    DbConnStr$ = rsCnt.GetValue(0).ToString
                    If I = 0 Then
                        aFolders$(0) = DbConnStr$
                    Else
                        ReDim Preserve aFolders$(I)
                        aFolders$(I) = DbConnStr$
                    End If
                    I = I + 1
                Loop
            End If
            rsCnt.Close()
            rsCnt = Nothing
            command.Connection.Close()
            command = Nothing
            Conn.Close()
            Conn = Nothing
        End Using

    End Sub

    Public Sub GetContentArchiveFileFolders(ByVal UID$, ByRef aFolders$())

        Dim S = "SELECT     "
        S = S + " S.SUBFQN, "
        'S = S + " D.UserID, "
        S = S + " D.IncludeSubDirs, "
        'S = S + " D.FQN, "
        S = S + " D.DB_ID, "
        S = S + " D.VersionFiles, "
        S = S + " D.ckDisableDir "
        S = S + " FROM         Directory D INNER JOIN"
        S = S + "                 SubDir S ON D.UserID = S.UserID AND D.FQN = S.FQN"
        S = S + " WHERE D.UserID = '" + UID + "'"
        S = S + " ORDER BY S.SUBFQN"

        ReDim aFolders$(0)
        Dim I As Integer = 0

        Dim ConnStr = Me.getConnStr
        Dim Conn As New SqlConnection(ConnStr)
        Dim b As Boolean = False

        Dim SUBFQN$ = ""
        Dim IncludeSubDirs$ = ""
        Dim DB_ID$ = ""
        Dim VersionFiles$ = ""
        Dim DisableFolder$ = ""

        Dim DbConnStr$ = ""

        Using Conn
            If Conn.State = ConnectionState.Closed Then
                Conn.Open()
            End If

            Dim command As New SqlCommand(S, Conn)
            Dim rsCnt As SqlDataReader = Nothing
            rsCnt = command.ExecuteReader()
            I = 0
            If rsCnt.HasRows Then
                Do While rsCnt.Read()
                    SUBFQN$ = rsCnt.GetValue(0).ToString
                    IncludeSubDirs$ = rsCnt.GetValue(1).ToString
                    DB_ID$ = rsCnt.GetValue(2).ToString
                    VersionFiles$ = rsCnt.GetValue(3).ToString
                    DisableFolder$ = rsCnt.GetValue(4).ToString

                    If I = 0 Then
                        aFolders$(0) = SUBFQN$ + "|" + IncludeSubDirs$ + "|" + DB_ID$ + "|" + VersionFiles$ + "|" + DisableFolder$
                    Else
                        ReDim Preserve aFolders$(I)
                        aFolders$(I) = SUBFQN$ + "|" + IncludeSubDirs$ + "|" + DB_ID$ + "|" + VersionFiles$ + "|" + DisableFolder$
                    End If
                    I = I + 1
                Loop
            End If
            rsCnt.Close()
            rsCnt = Nothing
            command.Connection.Close()
            command = Nothing
            Conn.Close()
            Conn = Nothing
        End Using

    End Sub

    Public Sub GetContentArchiveFileFolders(ByVal UID$, ByRef aFolders$(), ByVal DirPath$)

        Dim S = "SELECT     S.SUBFQN, D.IncludeSubDirs, D.DB_ID, D.VersionFiles, D.ckDisableDir, D.FQN"
        S = S + " FROM         Directory AS D FULL OUTER JOIN"
        S = S + "                       SubDir AS S ON D.UserID = S.UserID AND D.FQN = S.FQN"
        S = S + " WHERE     (D.UserID = '" + UID$ + "')"
        S = S + " ORDER BY S.SUBFQN"

        ReDim aFolders$(0)
        Dim I As Integer = 0
        Dim DirFound As Boolean = False

        Dim ConnStr = Me.getConnStr
        Dim Conn As New SqlConnection(ConnStr)
        Dim b As Boolean = False

        Dim SUBFQN$ = ""
        Dim IncludeSubDirs$ = ""
        Dim DB_ID$ = ""
        Dim VersionFiles$ = ""
        Dim DisableFolder$ = ""
        Dim ParentDir$ = ""

        Dim DbConnStr$ = ""

        Using Conn
            If Conn.State = ConnectionState.Closed Then
                Conn.Open()
            End If

            Dim command As New SqlCommand(S, Conn)
            Dim rsCnt As SqlDataReader = Nothing
            rsCnt = command.ExecuteReader()
            I = 0
            If rsCnt.HasRows Then
                Do While rsCnt.Read()
                    SUBFQN$ = rsCnt.GetValue(0).ToString
                    IncludeSubDirs$ = rsCnt.GetValue(1).ToString
                    DB_ID$ = rsCnt.GetValue(2).ToString
                    VersionFiles$ = rsCnt.GetValue(3).ToString
                    DisableFolder$ = rsCnt.GetValue(4).ToString
                    ParentDir$ = rsCnt.GetValue(5).ToString
                    If UCase(SUBFQN).Equals(UCase(DirPath$)) Then
                        aFolders$(0) = SUBFQN$ + "|" + IncludeSubDirs$ + "|" + DB_ID$ + "|" + VersionFiles$ + "|" + DisableFolder$
                        DirFound = True
                        Exit Do
                    End If
                    If SUBFQN$.Length = 0 And (UCase(ParentDir$).Equals(UCase(DirPath$))) Then
                        aFolders$(0) = ParentDir$ + "|" + IncludeSubDirs$ + "|" + DB_ID$ + "|" + VersionFiles$ + "|" + DisableFolder$
                        DirFound = True
                        Exit Do
                    End If
                    I = I + 1
                Loop
            End If
            rsCnt.Close()
            rsCnt = Nothing
            command.Connection.Close()
            command = Nothing
            Conn.Close()
            Conn = Nothing
            If Not DirFound Then
                aFolders$(0) = DirPath$ + "|" + IncludeSubDirs$ + "|" + DB_ID$ + "|" + VersionFiles$ + "|" + DisableFolder$
            End If
        End Using

    End Sub

    Public Sub GetQuickArchiveFileFolders(ByVal UID$, ByRef aFolders$(), ByVal DirPath$)

        Dim S = "SELECT     S.SUBFQN, D.IncludeSubDirs, D.DB_ID, D.VersionFiles, D.ckDisableDir, D.FQN"
        S = S + " FROM         QuickDirectory AS D FULL OUTER JOIN"
        S = S + "                       SubDir AS S ON D.UserID = S.UserID AND D.FQN = S.FQN"
        S = S + " WHERE     (D.UserID = '" + UID$ + "')"
        S = S + " ORDER BY S.SUBFQN"

        ReDim aFolders$(0)
        Dim I As Integer = 0
        Dim DirFound As Boolean = False

        Dim ConnStr = Me.getConnStr
        Dim Conn As New SqlConnection(ConnStr)
        Dim b As Boolean = False

        Dim SUBFQN$ = ""
        Dim IncludeSubDirs$ = ""
        Dim DB_ID$ = ""
        Dim VersionFiles$ = ""
        Dim DisableFolder$ = ""
        Dim ParentDir$ = ""

        Dim DbConnStr$ = ""

        Using Conn
            If Conn.State = ConnectionState.Closed Then
                Conn.Open()
            End If

            Dim command As New SqlCommand(S, Conn)
            Dim rsCnt As SqlDataReader = Nothing
            rsCnt = command.ExecuteReader()
            I = 0
            If rsCnt.HasRows Then
                Do While rsCnt.Read()
                    SUBFQN$ = rsCnt.GetValue(0).ToString
                    IncludeSubDirs$ = rsCnt.GetValue(1).ToString
                    DB_ID$ = rsCnt.GetValue(2).ToString
                    VersionFiles$ = rsCnt.GetValue(3).ToString
                    DisableFolder$ = rsCnt.GetValue(4).ToString
                    ParentDir$ = rsCnt.GetValue(5).ToString
                    If UCase(SUBFQN).Equals(UCase(DirPath$)) Then
                        aFolders$(0) = SUBFQN$ + "|" + IncludeSubDirs$ + "|" + DB_ID$ + "|" + VersionFiles$ + "|" + DisableFolder$
                        DirFound = True
                        Exit Do
                    End If
                    If SUBFQN$.Length = 0 And (UCase(ParentDir$).Equals(UCase(DirPath$))) Then
                        aFolders$(0) = ParentDir$ + "|" + IncludeSubDirs$ + "|" + DB_ID$ + "|" + VersionFiles$ + "|" + DisableFolder$
                        DirFound = True
                        Exit Do
                    End If
                    I = I + 1
                Loop
            End If
            rsCnt.Close()
            rsCnt = Nothing
            command.Connection.Close()
            command = Nothing
            Conn.Close()
            Conn = Nothing
            If Not DirFound Then
                aFolders$(0) = DirPath$ + "|" + IncludeSubDirs$ + "|" + DB_ID$ + "|" + VersionFiles$ + "|" + DisableFolder$
            End If
        End Using

    End Sub

    '     SELECT [ArchiveEmails]
    '      ,[RemoveAfterArchive]
    '      ,[SetAsDefaultFolder]
    '      ,[ArchiveAfterXDays]
    '      ,[RemoveAfterXDays]
    '      ,[RemoveXDays]
    '      ,[ArchiveXDays]
    '      ,[DB_ID]
    '  FROM [Email]
    'where UserID = 'wmiller'
    Function GetEmailFolderParms(ByVal UID$, ByVal FolderName$, ByRef ArchiveEmails$, ByRef RemoveAfterArchive$, ByRef SetAsDefaultFolder$, ByRef ArchiveAfterXDays$, ByRef RemoveAfterXDays$, ByRef RemoveXDays$, ByRef ArchiveXDays$, ByRef DB_ID$, ByRef ArchiveOnlyIfRead$) As Boolean

        ArchiveEmails$ = ""
        RemoveAfterArchive$ = ""
        SetAsDefaultFolder$ = ""
        ArchiveAfterXDays$ = ""
        RemoveAfterXDays$ = ""
        RemoveXDays$ = ""
        ArchiveXDays$ = ""
        DB_ID$ = ""

        Dim BB As Boolean = False

        Dim S = "SELECT [ArchiveEmails]"
        S = S + " ,[RemoveAfterArchive]"
        S = S + " ,[SetAsDefaultFolder]"
        S = S + " ,[ArchiveAfterXDays]"
        S = S + " ,[RemoveAfterXDays]"
        S = S + " ,[RemoveXDays]"
        S = S + " ,[ArchiveXDays]"
        S = S + " ,[DB_ID], ArchiveOnlyIfRead "
        S = S + " from [EmailArchParms] "
        S = S + " where UserID = '" + UID + "' "
        S = S + " and  [FolderName] = '" + FolderName$ + "'"

        Dim I As Integer = 0

        Dim ConnStr = Me.getConnStr
        Dim Conn As New SqlConnection(ConnStr)
        Dim b As Boolean = False

        Dim DbConnStr$ = ""

        Using Conn
            If Conn.State = ConnectionState.Closed Then
                Conn.Open()
            End If

            Dim command As New SqlCommand(S, Conn)
            Dim rsCnt As SqlDataReader = Nothing
            rsCnt = command.ExecuteReader()
            If rsCnt.HasRows Then
                Do While rsCnt.Read()
                    BB = True
                    ArchiveEmails$ = rsCnt.GetValue(0).ToString
                    RemoveAfterArchive$ = rsCnt.GetValue(1).ToString
                    SetAsDefaultFolder$ = rsCnt.GetValue(2).ToString
                    ArchiveAfterXDays$ = rsCnt.GetValue(3).ToString
                    RemoveAfterXDays$ = rsCnt.GetValue(4).ToString
                    RemoveXDays$ = rsCnt.GetValue(5).ToString
                    ArchiveXDays$ = rsCnt.GetValue(6).ToString
                    DB_ID$ = rsCnt.GetValue(7).ToString
                    ArchiveOnlyIfRead$ = rsCnt.GetValue(8).ToString
                Loop
            End If
            rsCnt.Close()
            rsCnt = Nothing
            command.Connection.Close()
            command = Nothing
            Conn.Close()
            Conn = Nothing
        End Using
        Return BB
    End Function

    Function GetEmailSubject(ByVal EmailGuid$) As String

        Dim Subject$ = ""

        Dim BB As Boolean = False

        Dim S = "SELECT [Subject]"
        S = S + " from [Email] "
        S = S + " where EmailGuid = '" + EmailGuid + "' "

        Dim I As Integer = 0

        Dim ConnStr = Me.getConnStr
        Dim Conn As New SqlConnection(ConnStr)
        Dim b As Boolean = False

        Dim DbConnStr$ = ""

        Using Conn
            If Conn.State = ConnectionState.Closed Then
                Conn.Open()
            End If
            Dim command As New SqlCommand(S, Conn)
            Dim rsCnt As SqlDataReader = Nothing
            rsCnt = command.ExecuteReader()
            If rsCnt.HasRows Then
                Do While rsCnt.Read()
                    BB = True
                    Subject = rsCnt.GetValue(0).ToString
                Loop
            End If
            rsCnt.Close()
            rsCnt = Nothing
            command.Connection.Close()
            command = Nothing
            Conn.Close()
            Conn = Nothing
        End Using
        Return Subject$
    End Function

    Function GetEmailBody(ByVal EmailGuid$) As String

        Dim Subject$ = ""

        Dim BB As Boolean = False

        Dim S = "SELECT [Body]"
        S = S + " from [Email] "
        S = S + " where EmailGuid = '" + EmailGuid + "' "

        Dim I As Integer = 0

        Dim ConnStr = Me.getConnStr
        Dim Conn As New SqlConnection(ConnStr)
        Dim b As Boolean = False

        Dim DbConnStr$ = ""

        Using Conn
            If Conn.State = ConnectionState.Closed Then
                Conn.Open()
            End If
            Dim command As New SqlCommand(S, Conn)
            Dim rsCnt As SqlDataReader = Nothing
            rsCnt = command.ExecuteReader()
            If rsCnt.HasRows Then
                Do While rsCnt.Read()
                    BB = True
                    Subject = rsCnt.GetValue(0).ToString
                Loop
            End If
            rsCnt.Close()
            rsCnt = Nothing
            command.Connection.Close()
            command = Nothing
            Conn.Close()
            Conn = Nothing
        End Using
        Return Subject$
    End Function

    Function GetDocTitle(ByVal SourceGuid$) As String

        Dim TitleFound As Boolean = False

        Dim Subject$ = ""

        Dim BB As Boolean = False

        Dim S = "SELECT [AttributeValue]     "
        S = S + "   FROM [SourceAttribute]"
        S = S + " where [AttributeName] like 'Title'"
        S = S + " and [SourceGuid] = '" + SourceGuid + "'"

        Dim I As Integer = 0

        Dim ConnStr = Me.getConnStr
        Dim Conn As New SqlConnection(ConnStr)
        Dim b As Boolean = False

        Dim DbConnStr$ = ""

        Using Conn
            If Conn.State = ConnectionState.Closed Then
                Conn.Open()
            End If
            Dim command As New SqlCommand(S, Conn)
            Dim rsCnt As SqlDataReader = Nothing
            rsCnt = command.ExecuteReader()
            If rsCnt.HasRows Then
                TitleFound = True

                BB = True
                Subject = rsCnt.GetValue(0).ToString

            End If
            rsCnt.Close()
            rsCnt = Nothing
            command.Connection.Close()
            command = Nothing
            Conn.Close()
            Conn = Nothing
        End Using

        If TitleFound = False Then
            Subject = "No subject metadata found, document name is: " + GetDocFilename(SourceGuid$)
        End If

        Return Subject$
    End Function

    Function GetDocFilename(ByVal SourceGuid$) As String

        Dim FileName$ = ""

        Dim BB As Boolean = False

        Dim S = "SELECT [SourceName] FROM [DMA.UD].[dbo].[DataSource] where [SourceGuid] = '" + SourceGuid$ + "'"

        Dim I As Integer = 0

        Dim ConnStr = Me.getConnStr
        Dim Conn As New SqlConnection(ConnStr)
        Dim b As Boolean = False

        Dim DbConnStr$ = ""

        Using Conn
            If Conn.State = ConnectionState.Closed Then
                Conn.Open()
            End If
            Dim command As New SqlCommand(S, Conn)
            Dim rsCnt As SqlDataReader = Nothing
            rsCnt = command.ExecuteReader()
            If rsCnt.HasRows Then
                BB = True
                rsCnt.Read()
                FileName = rsCnt.GetValue(0).ToString
            End If
            rsCnt.Close()
            rsCnt = Nothing
            command.Connection.Close()
            command = Nothing
            Conn.Close()
            Conn = Nothing
        End Using
        If BB = False Then
            FileName = "No file name supplied for this content."
        Else
            FileName = vbCrLf + FileName
        End If
        Return FileName
    End Function

    Public Sub GetIncludedDirs(ByVal FQN$, ByVal L As ArrayList)

        Dim S = ""

        If FQN.Length = 0 Then
            S = "SELECT distinct [ExtCode] FROM [IncludedFiles] order by [ExtCode]"
        Else
            FQN = DMA.RemoveSingleQuotes(FQN)
            S = "SELECT [ExtCode] FROM [IncludedFiles] where FQN = '" + FQN$ + "' order by [ExtCode]"
        End If

        Dim ConnStr = Me.getConnStr
        Dim Conn As New SqlConnection(ConnStr)
        Dim b As Boolean = False

        Dim IncludeExt$ = ""
        L.Clear()

        Using Conn
            If Conn.State = ConnectionState.Closed Then
                Conn.Open()
            End If

            Dim command As New SqlCommand(S, Conn)
            Dim rsCnt As SqlDataReader = Nothing
            rsCnt = command.ExecuteReader()
            If rsCnt.HasRows Then
                Do While rsCnt.Read()
                    IncludeExt$ = rsCnt.GetValue(0).ToString
                    L.Add(IncludeExt$)
                Loop
            End If
            rsCnt.Close()
            rsCnt = Nothing
            command.Connection.Close()
            command = Nothing
            Conn.Close()
            Conn = Nothing
            L.Sort()
        End Using

    End Sub

    Public Sub GetExcludedDirs(ByVal FQN$, ByVal L As ArrayList)

        FQN = DMA.RemoveSingleQuotes(FQN)

        Dim S = "SELECT [ExtCode] FROM [ExcludedFiles] where FQN = '" + FQN$ + "' order by [ExtCode]"

        Dim ConnStr = Me.getConnStr
        Dim Conn As New SqlConnection(ConnStr)
        Dim b As Boolean = False

        Dim IncludeExt$ = ""
        L.Clear()

        Using Conn
            If Conn.State = ConnectionState.Closed Then
                Conn.Open()
            End If

            Dim command As New SqlCommand(S, Conn)
            Dim rsCnt As SqlDataReader = Nothing
            rsCnt = command.ExecuteReader()
            If rsCnt.HasRows Then
                Do While rsCnt.Read()
                    IncludeExt$ = rsCnt.GetValue(0).ToString
                    L.Add(IncludeExt$)
                Loop
            End If
            rsCnt.Close()
            rsCnt = Nothing
            command.Connection.Close()
            command = Nothing
            Conn.Close()
            Conn = Nothing
            L.Sort()
        End Using

    End Sub

    'Sub AddSecondarySOURCETYPE(ByVal Sourcetypecode$, ByVal Sourcetypedesc$, ByVal Storeexternal$, ByVal Indexable$)
    '    Dim ST As New clsSOURCETYPE
    '    ST.setSourcetypecode(Sourcetypecode)
    '    ST.setSourcetypedesc(Sourcetypedesc)
    '    ST.setStoreexternal(Storeexternal)
    '    ST.setIndexable(Indexable)
    '    ST.Insert()
    'End Sub
    'Sub delSecondarySOURCETYPE(ByVal Sourcetypecode$)
    '    Dim ST As New clsSOURCETYPE
    '    ST.setSourcetypecode(Sourcetypecode)
    '    Dim WhereClause$ = "Where SourceTypeCode = '" + Sourcetypecode + "'"
    '    ST.Delete(WhereClause$)
    'End Sub
    Function FindAllTableIndexes(ByVal TBL$) As Array
        Dim SL As New SortedList
        Dim S = ""
        S = S + " select distinct si.name"
        S = S + " from sys.indexes si"
        S = S + " inner join sys.index_columns ic on si.object_id = ic.object_id and si.index_id = ic.index_id"
        S = S + " inner join information_schema.tables st on object_name(si.object_id) = st.table_name"
        S = S + " inner join information_schema.columns sc on ic.column_id = sc.ordinal_position and sc.table_name = st.table_name"
        S = S + " where si.name Is Not null And si.index_id > 0 And si.is_hypothetical = 0 "
        S = S + " and sc.table_name = '" + TBL$ + "'"

        Dim b As Boolean = True
        Dim i As Integer = 0
        Dim id As Integer = -1
        Dim II As Integer = 0
        Dim IndexName$ = ""

        Dim TblIndexes$(0)

        Dim rsColInfo As SqlDataReader = Nothing
        'rsColInfo = SqlQryNo'Session(S)
        rsColInfo = SqlQry(S)
        If rsColInfo.HasRows Then
            Do While rsColInfo.Read()
                IndexName = rsColInfo.GetValue(0).ToString
                II = UBound(TblIndexes) + 1
                ReDim Preserve TblIndexes(II)
                TblIndexes(II) = IndexName$
            Loop
        Else
            id = -1
        End If
        rsColInfo.Close()
        rsColInfo = Nothing

        Return TblIndexes$

    End Function

    Function FindAllIndexCols(ByVal TBL$, ByVal IdxName$) As Array
        Dim SL As New SortedList
        Dim S = ""
        S = S + " select distinct sc.table_name,si.name,si.type_desc,sc.column_name"
        S = S + " from sys.indexes si"
        S = S + " inner join sys.index_columns ic on si.object_id = ic.object_id and si.index_id = ic.index_id"
        S = S + " inner join information_schema.tables st on object_name(si.object_id) = st.table_name"
        S = S + " inner join information_schema.columns sc on ic.column_id = sc.ordinal_position and sc.table_name = st.table_name"
        S = S + " where si.name Is Not null And si.index_id > 0 And si.is_hypothetical = 0 "
        S = S + " and sc.table_name = '" + TBL$ + "'"
        S = S + " and name = '" + IdxName$ + "'"

        Dim b As Boolean = True
        Dim i As Integer = 0
        Dim id As Integer = -1
        Dim II As Integer = 0
        Dim ColName$ = ""

        Dim IndexColumns$(0)

        Dim rsColInfo As SqlDataReader = Nothing
        'rsColInfo = SqlQryNo'Session(S)
        rsColInfo = SqlQry(S)
        If rsColInfo.HasRows Then
            Do While rsColInfo.Read()
                ColName = rsColInfo.GetValue(3).ToString
                ColName = TBL + "|" + ColName
                II = UBound(IndexColumns$) + 1
                ReDim Preserve IndexColumns$(II)
                IndexColumns$(II) = ColName$
            Loop
        Else
            id = -1
        End If
        rsColInfo.Close()
        rsColInfo = Nothing

        Return IndexColumns$

    End Function

    Function getColumnDataType(ByVal TBL$, ByVal ColName$) As String
        Dim SL As New SortedList
        Dim S = ""
        S = S + " SELECT table_name, column_name, is_nullable, data_type, character_maximum_length"
        S = S + " FROM information_schema.columns "
        S = S + " where  table_name = '" + TBL$ + "'"
        S = S + " AND column_name = '" + ColName$ + "'"

        Dim b As Boolean = True
        Dim i As Integer = 0
        Dim id As Integer = -1
        Dim II As Integer = 0
        Dim DataType$ = ""
        Dim IsNullable$ = ""

        Dim rsColInfo As SqlDataReader = Nothing
        'rsColInfo = SqlQryNo'Session(S)
        rsColInfo = SqlQry(S)
        If rsColInfo.HasRows Then
            Do While rsColInfo.Read()
                IsNullable$ = rsColInfo.GetValue(2).ToString
                DataType$ = rsColInfo.GetValue(3).ToString
                DataType$ = DataType$ + "|" + IsNullable$
            Loop
        Else
            id = -1
        End If
        rsColInfo.Close()
        rsColInfo = Nothing

        Return DataType$

    End Function

    Public Function GetRowByKey(ByVal TBL As String, ByVal WC As String) As SqlDataReader
        Try
            Dim Auth As String = ""
            Dim s As String = "select * from " + TBL + " " + WC
            Dim rsData As SqlDataReader = Nothing
            Dim b As Boolean = False
            rsData = SqlQry(s)
            If rsData.HasRows Then
                rsData.Read()
                Auth = rsData.GetValue(0).ToString
                Return rsData
            Else
                Return Nothing
            End If
        Catch ex As Exception
            Debug.Print(ex.Message)
            Return Nothing
        End Try

    End Function

    '    SELECT [UserID]
    '      ,[FolderName]
    '      ,[ParentFolderName]
    '      ,[FolderID]
    '      ,[ParentFolderID]
    '      ,[SelectedForArchive]
    '  FROM [DMA.UD].[dbo].[EmailFolder]
    'where [SelectedForArchive] = 'Y'
    'and FolderID ='00000000AE37B53150C4EF4991D438C857CB5B08623D0300'

    Public Function ckArchEmailFolder(ByVal FolderID$, ByVal UserID$) As Integer

        Dim b As Boolean = True
        Dim S As String = "SELECT count(*) "
        S = S + "   FROM [EmailFolder]"
        S = S + " where [SelectedForArchive] = 'Y'"
        S = S + " and FolderID ='" + FolderID$ + "'"
        S = S + " and UserID ='" + UserID$ + "'"
        Dim i As Integer = 0
        Dim tQuery As String = ""

        'Dim i As Integer
        Dim cnt As Integer = -1

        Using gConn
            Dim command As New SqlCommand(S, gConn)
            Dim rsCnt As SqlDataReader = Nothing
            rsCnt = SqlQry(S)
            rsCnt.Read()
            cnt = rsCnt.GetInt32(0)
            rsCnt.Close()
            rsCnt = Nothing
            command.Connection.Close()
            command = Nothing
        End Using

        Return cnt

    End Function

    Public Function iCount(ByVal Tbl$, ByVal WhereClause$) As Boolean
        Dim b As Boolean = True
        Dim SQL As String = "select count(*) from " + Tbl + " " + WhereClause
        Dim i As Integer = 0

        i = iGetRowCount(SQL)
        If i = 0 Then
            b = False
        End If
        Return b
    End Function

    Public Function iGetRowCount(ByVal TBL$, ByVal WhereClause$) As Integer

        Dim cnt As Integer = -1

        CkConn()

        Try
            Dim tQuery As String = ""
            Dim s As String = ""

            s = "select count(*) as CNT from " + TBL + " " + WhereClause

            Clipboard.Clear()
            Clipboard.SetText(s)

            Using gConn
                Dim command As New SqlCommand(s, gConn)
                Dim rsCnt As SqlDataReader = Nothing
                rsCnt = SqlQry(s)
                rsCnt.Read()
                cnt = rsCnt.GetInt32(0)
                rsCnt.Close()
                rsCnt = Nothing
                command.Connection.Close()
                command = Nothing
            End Using
        Catch ex As Exception
            MsgBox("Error 3932.11c: " + ex.Message)
            Debug.Print("Error 3932.11d: " + ex.Message)
            cnt = 1
        End Try

        Return cnt

    End Function

    Public Function iGetRowCount(ByVal TBL$, ByVal WhereClause$, ByVal NewConnStr$) As Integer

        Dim cnt As Integer = -1

        Try
            Dim tQuery As String = ""
            Dim s As String = ""

            Dim Conn As New SqlConnection(NewConnStr$)
            Conn.Open()

            s = "select count(*) as CNT from " + TBL + " " + WhereClause

            Using Conn
                Dim command As New SqlCommand(s, gConn)
                Dim rsCnt As SqlDataReader = Nothing
                rsCnt = SqlQry(s)
                rsCnt.Read()
                cnt = rsCnt.GetInt32(0)
                rsCnt.Close()
                rsCnt = Nothing
                command.Connection.Close()
                command = Nothing
                Conn.Close()
                Conn = Nothing
            End Using
        Catch ex As Exception
            MsgBox("Error 3932.11e: " + ex.Message)
            Debug.Print("Error 3932.11f: " + ex.Message)
            cnt = 1
        End Try

        Return cnt

    End Function

    Public Function ArchiveEmail(ByVal FqnEmailImage As String, ByVal EmailGuid As String, ByVal SUBJECT As String, ByVal SentTO As String, ByVal Body As String, ByVal Bcc As String, ByVal BillingInformation As String, ByVal CC As String, ByVal Companies As String, ByVal CreationTime As DateTime, ByVal ReadReceiptRequested As String, ByVal ReceivedByName As String, ByVal ReceivedTime As DateTime, ByVal AllRecipients As String, ByVal UserID As String, ByVal SenderEmailAddress As String, ByVal SenderName As String, ByVal Sensitivity As String, ByVal SentOn As DateTime, ByVal MsgSize$, ByVal DeferredDeliveryTime As DateTime, ByVal EntryID As String, ByVal ExpiryTime As DateTime, ByVal LastModificationTime As DateTime, ByVal ShortSubj As String, ByVal SourceTypeCode As String, ByVal OriginalFolder As String) As Boolean

        Dim B As Boolean = False

        EmailGuid = DMA.RemoveSingleQuotes(EmailGuid)
        SUBJECT = DMA.RemoveSingleQuotes(SUBJECT)
        SentTO = DMA.RemoveSingleQuotes(SentTO)
        Body = DMA.RemoveSingleQuotes(Body)
        Bcc = DMA.RemoveSingleQuotes(Bcc)
        BillingInformation = DMA.RemoveSingleQuotes(BillingInformation)
        CC = DMA.RemoveSingleQuotes(CC)
        Companies = DMA.RemoveSingleQuotes(Companies)
        CreationTime = DMA.RemoveSingleQuotes(CreationTime)
        ReadReceiptRequested = DMA.RemoveSingleQuotes(ReadReceiptRequested)
        ReceivedByName = DMA.RemoveSingleQuotes(ReceivedByName)
        ReceivedTime = DMA.RemoveSingleQuotes(ReceivedTime)
        AllRecipients = DMA.RemoveSingleQuotes(AllRecipients)
        UserID = DMA.RemoveSingleQuotes(UserID)
        SenderEmailAddress = DMA.RemoveSingleQuotes(SenderEmailAddress)
        SenderName = DMA.RemoveSingleQuotes(SenderName)
        Sensitivity = DMA.RemoveSingleQuotes(Sensitivity)
        SentOn = DMA.RemoveSingleQuotes(SentOn)
        MsgSize = DMA.RemoveSingleQuotes(MsgSize)
        DeferredDeliveryTime = DMA.RemoveSingleQuotes(DeferredDeliveryTime)
        EntryID = DMA.RemoveSingleQuotes(EntryID)
        ExpiryTime = DMA.RemoveSingleQuotes(ExpiryTime)
        LastModificationTime = DMA.RemoveSingleQuotes(LastModificationTime)

        Try
            Dim EmailBinary() As Byte = CF.FileToByte(FqnEmailImage)
            'UserID, ReceivedByName As String, ReceivedTime As DateTime, SenderEmailAddress As String, SenderName As String, SentOn As DateTime
            Using connection As New SqlConnection(Me.getConnStr)
                Using command As New SqlCommand("EmailInsProc", connection)
                    command.CommandType = CommandType.StoredProcedure

                    command.Parameters.Add(New SqlParameter("@EmailGuid", EmailGuid))
                    command.Parameters.Add(New SqlParameter("@SUBJECT", SUBJECT))
                    command.Parameters.Add(New SqlParameter("@SentTO", SentTO))
                    command.Parameters.Add(New SqlParameter("@Body", Body))
                    command.Parameters.Add(New SqlParameter("@Bcc", Bcc))
                    command.Parameters.Add(New SqlParameter("@BillingInformation", BillingInformation))
                    command.Parameters.Add(New SqlParameter("@CC", CC))
                    command.Parameters.Add(New SqlParameter("@Companies", Companies))
                    command.Parameters.Add(New SqlParameter("@CreationTime", CreationTime))
                    command.Parameters.Add(New SqlParameter("@ReadReceiptRequested", ReadReceiptRequested))
                    command.Parameters.Add(New SqlParameter("@ReceivedByName", ReceivedByName))
                    command.Parameters.Add(New SqlParameter("@ReceivedTime", ReceivedTime))
                    command.Parameters.Add(New SqlParameter("@AllRecipients", AllRecipients))
                    command.Parameters.Add(New SqlParameter("@UserID", UserID))
                    command.Parameters.Add(New SqlParameter("@SenderEmailAddress", SenderEmailAddress))
                    command.Parameters.Add(New SqlParameter("@SenderName", SenderName))
                    command.Parameters.Add(New SqlParameter("@Sensitivity", Sensitivity))
                    command.Parameters.Add(New SqlParameter("@SentOn", SentOn))
                    command.Parameters.Add(New SqlParameter("@MsgSize", MsgSize))
                    command.Parameters.Add(New SqlParameter("@DeferredDeliveryTime", DeferredDeliveryTime))
                    command.Parameters.Add(New SqlParameter("@EntryID", EntryID))
                    command.Parameters.Add(New SqlParameter("@ExpiryTime", ExpiryTime))
                    command.Parameters.Add(New SqlParameter("@LastModificationTime", LastModificationTime))
                    command.Parameters.Add(New SqlParameter("@EmailImage", EmailBinary))
                    command.Parameters.Add(New SqlParameter("@ShortSubj", ShortSubj))
                    command.Parameters.Add(New SqlParameter("@SourceTypeCode", SourceTypeCode))
                    command.Parameters.Add(New SqlParameter("@OriginalFolder", OriginalFolder))

                    connection.Open()
                    command.ExecuteNonQuery()
                    connection.Close()
                    connection.Dispose()
                    command.Dispose()
                End Using
            End Using
            B = True
        Catch ex As Exception
            Debug.Print(ex.Message)
            'Debug.Print(ex.StackTrace)
            B = False
        End Try
        Return B
    End Function

    Public Sub InsertEmailBinary(ByVal FQN$, ByVal tGuid$)

        ' Read a bitmap contents in a stream
        Dim fs As FileStream = New FileStream(FQN, FileMode.OpenOrCreate, FileAccess.Read)
        Dim rawData() As Byte = New Byte(fs.Length) {}
        fs.Read(rawData, 0, System.Convert.ToInt32(fs.Length))
        fs.Close()
        ' Construct a SQL string and a connection object
        Dim S As String = " "
        S = S + " select * "
        S = S + " FROM [DMA.UD].[dbo].[Email]"
        S = S + " where [EmailGuid] = '" + tGuid$ + "'"

        CkConn()

        ' Open connection
        If gConn.State <> ConnectionState.Open Then
            gConn.Open()
        End If
        ' Create a data adapter and data set
        'Dim cmd As New SqlCommand(S, gConn)
        'Dim da As New SqlDataAdapter(cmd)
        'Dim ds As New Data.DataSet

        Dim con As New SqlConnection(Me.getConnStr)
        Dim da As New SqlDataAdapter(S, con)
        Dim MyCB As SqlCommandBuilder = New SqlCommandBuilder(da)
        Dim ds As New System.Data.DataSet

        da.Fill(ds, "Emails")
        Dim myRow As System.Data.DataRow
        myRow = ds.Tables("Emails").Rows(0)

        myRow("EmailImage") = rawData
        ds.AcceptChanges()

        MyCB = Nothing
        ds = Nothing
        da = Nothing

        con.Close()
        con = Nothing

    End Sub

    ' Sub ApplyCC() Dim L As New List(Of String) Dim RECIPS As New clsRECIPIENTS Dim SL As New
    ' SortedList Dim S = " SELECT [EmailGuid] " S = S + " ,[CC] " S = S + " FROM
    ' [DMA.UD].[dbo].[Email]" S = S + " where CC Is Not null " S = S + " and len(cc) > 0 "

    ' Dim b As Boolean = True Dim i As Integer = 0 Dim id As Integer = -1 Dim II As Integer = 0 Dim
    ' CC$ = "" Dim EmailGuid$ = ""

    ' SL.Clear()

    ' Dim rsColInfo As SqlDataReader = Nothing 'rsColInfo = SqlQryNo'Session(S) rsColInfo = SqlQry(S)
    ' If rsColInfo.HasRows Then Do While rsColInfo.Read() EmailGuid = rsColInfo.GetValue(0).ToString
    ' CC = rsColInfo.GetValue(1).ToString If Not CC Is Nothing Then SL.Clear() If CC.Trim.Length > 0
    ' Then Dim A$(0) If InStr(1, CC, ";") > 0 Then A = Split(CC, ";") Else A(0) = CC End If For KK As
    ' Integer = 0 To UBound(A) Dim SKEY$ = A(KK) If Not SKEY Is Nothing Then Dim BX As Boolean =
    ' SL.ContainsKey(SKEY) If Not BX Then SL.Add(SKEY, SKEY) End If End If Next End If For KK As
    ' Integer = 0 To SL.Count - 1 Dim Addr$ = SL.GetKey(KK)

    ' RECIPS.setEmailguid(EmailGuid) RECIPS.setRecipient(Addr$)

    ' Dim BX As Integer = RECIPS.cnt_PK32A(EmailGuid, Addr) If BX = 0 Then
    ' RECIPS.setTyperecp("RECIP") RECIPS.Insert() Else RECIPS.setTyperecp("CC") Dim SS$ = "UPDATE
    ' [DMA.UD].[dbo].[Recipients]" SS = SS + " SET [TypeRecp] = 'CC'" SS = SS + " WHERE EmailGuid =
    ' '" + EmailGuid + "' " SS = SS + " and Recipient = '" + Addr$ + "'" L.Add(SS) End If

    ' Next End If Loop Else id = -1 End If rsColInfo.Close() rsColInfo = Nothing

    ' For II = 0 To L.Count - 1 S = L.Item(II).ToString Dim bb As Boolean = ExecuteSql(S) If Not bb
    ' Then Debug.Print("ERROR: " + S) End If Next

    ' End Sub

    ' Sub BuildAllRecips() Dim L As New List(Of String) Dim RECIPS As New clsRECIPIENTS Dim SL As New
    ' SortedList Dim S = " SELECT [EmailGuid] ,[Recipient] ,[TypeRecp] FROM
    ' [DMA.UD].[dbo].[Recipients] order by EmailGuid "

    ' Dim b As Boolean = True Dim i As Integer = 0 Dim id As Integer = -1 Dim II As Integer = 0 Dim
    ' CC$ = "" Dim EmailGuid$ = "" Dim Recipient$ = "" Dim TypeRecp$ = "" Dim CurrGuid$ = "" Dim
    ' PrevGuid$ = "" Dim AllRecipients$ = ""

    ' Dim rsColInfo As SqlDataReader = Nothing 'rsColInfo = SqlQryNo'Session(S) rsColInfo = SqlQry(S)
    ' If rsColInfo.HasRows Then Do While rsColInfo.Read() II += 1 EmailGuid =
    ' rsColInfo.GetValue(0).ToString Recipient$ = rsColInfo.GetValue(1).ToString TypeRecp$ =
    ' rsColInfo.GetValue(2).ToString If II = 1 Then PrevGuid$ = EmailGuid End If If Not
    ' EmailGuid.Equals(PrevGuid$) Then Dim SS$ = "UPDATE [DMA.UD].[dbo].[Email]" SS = SS + " SET
    ' [AllRecipients] = '" + Mid(AllRecipients$, 2) + "'" SS = SS + " WHERE EmailGuid = '" +
    ' EmailGuid + "' " L.Add(SS) AllRecipients$ = "" AllRecipients$ = AllRecipients$ + ";" +
    ' Recipient$ Else AllRecipients$ = AllRecipients$ + ";" + Recipient$ End If PrevGuid$ = EmailGuid
    ' frmReconMain.SB.Text = "Recips: " + II.ToString Application.DoEvents() Loop End If
    ' rsColInfo.Close() rsColInfo = Nothing

    ' For II = 0 To L.Count - 1 S = L.Item(II).ToString Dim bb As Boolean = ExecuteSql(S) If Not bb
    ' Then Debug.Print("ERROR: " + S) End If frmReconMain.SB.Text = "Applying Recips: " + II.ToString
    ' Application.DoEvents() Next

    ' End Sub

    ' Sub BuildAllMissingData() Dim L As New List(Of String) Dim RECIPS As New clsRECIPIENTS Dim SL
    ' As New SortedList Dim S = " SELECT SourceGuid, FQN FROM DataSource "

    ' Dim b As Boolean = True Dim i As Integer = 0 Dim id As Integer = -1 Dim II As Integer = 0 Dim
    ' CC$ = "" Dim SourceGuid$ = "" Dim FQN = ""

    ' Dim rsColInfo As SqlDataReader = Nothing 'rsColInfo = SqlQryNo'Session(S) rsColInfo = SqlQry(S)
    ' If rsColInfo.HasRows Then Do While rsColInfo.Read() II += 1 SourceGuid =
    ' rsColInfo.GetValue(0).ToString FQN = rsColInfo.GetValue(1).ToString FQN = DMA.GetFilePath(FQN)

    ' Dim SS$ = "UPDATE [DataSource] " SS = SS + " SET [FileDirectory] = '" + FQN + "'" SS = SS + "
    ' WHERE SourceGuid = '" + SourceGuid + "' " L.Add(SS)

    ' frmReconMain.SB.Text = "Files Read: " + II.ToString Application.DoEvents() Loop End If
    ' rsColInfo.Close() rsColInfo = Nothing

    ' For II = 0 To L.Count - 1 S = L.Item(II).ToString Dim bb As Boolean = ExecuteSql(S) If Not bb
    ' Then Debug.Print("ERROR: " + S) End If frmReconMain.SB.Text = "Applying Files: " + II.ToString
    ' Application.DoEvents() Next

    ' End Sub

    ' Sub BuildAllCCs() Dim L As New List(Of String) Dim RECIPS As New clsRECIPIENTS Dim SL As New
    ' SortedList Dim S = " SELECT [EmailGuid] ,[Recipient] ,[TypeRecp] FROM
    ' [DMA.UD].[dbo].[Recipients] where TypeRecp = 'CC' order by EmailGuid "

    ' Dim b As Boolean = True Dim i As Integer = 0 Dim id As Integer = -1 Dim II As Integer = 0 Dim
    ' CC$ = "" Dim EmailGuid$ = "" Dim Recipient$ = "" Dim TypeRecp$ = "" Dim CurrGuid$ = "" Dim
    ' PrevGuid$ = ""

    ' Dim rsColInfo As SqlDataReader = Nothing 'rsColInfo = SqlQryNo'Session(S) rsColInfo = SqlQry(S)
    ' If rsColInfo.HasRows Then Do While rsColInfo.Read() II += 1 EmailGuid =
    ' rsColInfo.GetValue(0).ToString Recipient$ = rsColInfo.GetValue(1).ToString TypeRecp$ =
    ' rsColInfo.GetValue(2).ToString If II = 1 Then PrevGuid$ = EmailGuid End If If Not
    ' EmailGuid.Equals(PrevGuid$) Then Dim SS$ = "UPDATE [DMA.UD].[dbo].[Email]" SS = SS + " SET [CC]
    ' = '" + Mid(CC, 2) + "'" SS = SS + " WHERE EmailGuid = '" + EmailGuid + "' " L.Add(SS) CC = ""
    ' CC = CC + ";" + Recipient$ Else CC = CC + ";" + Recipient$ End If PrevGuid$ = EmailGuid
    ' frmReconMain.SB.Text = "CC: " + II.ToString Application.DoEvents() Loop End If
    ' rsColInfo.Close() rsColInfo = Nothing

    ' For II = 0 To L.Count - 1 S = L.Item(II).ToString Dim bb As Boolean = ExecuteSql(S) If Not bb
    ' Then Debug.Print("ERROR: " + S) End If frmReconMain.SB.Text = "Applying CC: " + II.ToString
    ' Application.DoEvents() Next

    ' End Sub Sub getExcludedEmails(ByVal UserID$) Dim L As New List(Of String) Dim RECIPS As New
    ' clsRECIPIENTS Dim SL As New SortedList Dim S = " SELECT [FromEmailAddr] FROM
    ' [DMA.UD].[dbo].[ExcludeFrom] where Userid = '" + UserID + "' "

    ' zeroizeExcludedEmailAddr()

    ' Dim b As Boolean = True Dim Email$ = ""

    ' Dim rsColInfo As SqlDataReader = Nothing 'rsColInfo = SqlQryNo'Session(S) rsColInfo = SqlQry(S)
    ' If rsColInfo.HasRows Then Do While rsColInfo.Read() Email = rsColInfo.GetValue(0).ToString
    ' AddExcludedEmailAddr(Email$) Application.DoEvents() Loop End If rsColInfo.Close() rsColInfo =
    ' Nothing End Sub Public Function getDirectoryParms(ByRef A$(), ByVal FQN As String, ByVal UserID
    ' As String) As Boolean FQN = DMA.RemoveSingleQuotes(FQN) Dim B As Boolean = False ReDim A(0) Dim
    ' IncludeSubDirs$ = "" Dim VersionFiles$ = "" Dim ckMetaData$ = "" Dim NumberOfDirs As Integer =
    ' 0 Dim CurrDir As Integer = 0 Dim I As Integer = 0

    '        For I = 1 To FQN.Length
    '            Dim ch$ = Mid(FQN, I, 1)
    '            If ch = "\" Then
    '                NumberOfDirs += 1
    '            End If
    '        Next
    '        CurrDir = NumberOfDirs
    '        Dim DIRS$() = Split(FQN, "\")
    'REDO:
    '        Dim CurrFqn$ = ""
    '        For I = 0 To CurrDir
    '            If I = 0 Then
    '                CurrFqn$ = DIRS(0)
    '            Else
    '                CurrFqn$ = CurrFqn$ + "\" + DIRS(I)
    '            End If
    '        Next

    ' Try Dim rsData As SqlDataReader = Nothing Dim S = "" S = S + " SELECT [UserID]" S = S + "
    ' ,[IncludeSubDirs]" S = S + " ,[FQN]" S = S + " ,[DB_ID]" S = S + " ,[VersionFiles]" S = S + "
    ' ,[ckMetaData]" S = S + " FROM [Directory]" S = S + " where fqn = '" + CurrFqn$ + "' and Userid
    ' = '" + UserID + "'"

    ' 'rsColInfo = SqlQryNo'Session(S) rsData = SqlQry(S) If rsData.HasRows Then Do While
    ' rsData.Read() B = True IncludeSubDirs$ = rsData.GetValue(1).ToString VersionFiles$ =
    ' rsData.GetValue(4).ToString ckMetaData$ = rsData.GetValue(5).ToString ReDim A(3) A(0) =
    ' IncludeSubDirs$ A(1) = VersionFiles$ A(2) = ckMetaData$ Loop End If rsData.Close() rsData = Nothing

    ' Catch ex As Exception Debug.Print(ex.Message) B = False End Try If B Then Return True Else
    ' ReDim A(3) A(0) = IncludeSubDirs$ A(1) = VersionFiles$ A(2) = ckMetaData$ If CurrDir = 1 Then
    ' Return False Else CurrDir = CurrDir - 1 GoTo REDO End If End If End Function

    Public Function getNextDocVersionNbr(ByVal Userid$, ByVal FQN$) As Integer
        FQN$ = DMA.RemoveSingleQuotes(FQN)
        Dim S = "select max([VersionNbr]) "
        S = S + " FROM [DataSource]"
        S = S + " where fqn = '" + FQN + "'"
        S = S + " and [DataSourceOwnerUserID] = 'wmiller'"
        Dim I As Integer = 0
        Try
            Dim rsColInfo As SqlDataReader = Nothing
            'rsColInfo = SqlQryNo'Session(S)
            rsColInfo = SqlQry(S)
            If rsColInfo.HasRows Then
                rsColInfo.Read()
                I = Val(rsColInfo.GetValue(0).ToString)
            End If
            rsColInfo.Close()
            rsColInfo = Nothing
            Return I + 1
        Catch ex As Exception
            I = -1
        End Try
        Return I
    End Function

    Public Function DeleteDocumentByName(ByVal Userid$, ByVal FQN$, ByVal SourceGuid$) As Boolean
        FQN$ = DMA.RemoveSingleQuotes(FQN)
        Dim b As Boolean = False

        Dim S = "delete "

        S = S + " FROM [DataSource]"
        S = S + " where fqn = '" + FQN + "'"
        S = S + " and [DataSourceOwnerUserID] = '" + Userid$ + "' or SourceGuid = '" + SourceGuid$ + "'"

        Try
            b = ExecuteSql(S)
            Return b
        Catch ex As Exception
            Debug.Print(ex.Message)
            Return b
        End Try

        'S = " delete FROM [DataSource]"
        'S = S + " where SourceGuid = '" + SourceGuid$ + "'"

        'Try
        '    b = ExecuteSql(S)
        '    Return b
        'Catch ex As Exception
        '    Debug.Print(ex.Message)
        '    Return b
        'End Try

    End Function

    Public Function DeleteDocumentByGuid(ByVal SourceGuid$) As Boolean
        Dim b As Boolean = False

        Dim S = "delete "

        S = S + " FROM [DataSource]"
        S = S + " where SourceGuid = '" + SourceGuid$ + "'"
        Dim I As Integer = 0
        Try
            b = ExecuteSql(S)
            Return b
        Catch ex As Exception
            Debug.Print(ex.Message)
            Return b
        End Try

    End Function

    Public Function hasDocumentBeenUpdated(ByVal Userid$, ByVal FQN$) As Boolean
        FQN$ = DMA.RemoveSingleQuotes(FQN)
        Dim b As Boolean = False

        Dim S = "delete "

        S = S + " FROM [DataSource]"
        S = S + " where fqn = '" + FQN + "'"
        S = S + " and [DataSourceOwnerUserID] = '" + Userid$ + "'"
        Dim I As Integer = 0
        Try
            b = ExecuteSql(S)
            Return b
        Catch ex As Exception
            Debug.Print(ex.Message)
            Return b
        End Try

    End Function

    Public Sub UpdateDocSize(ByVal DocGuid$, ByVal fSize$)
        Dim S = ""
        S = S + "  UPDATE [DataSource]"
        S = S + "  set [FileLength] = " + fSize
        S = S + "  WHERE [SourceGuid] = '" + DocGuid + "'"

        Dim B As Boolean = ExecuteSql(S)

        If Not B Then
            MsgBox("Failed to update File Size for GUID '" + DocGuid + "'.")
        End If

    End Sub

    Public Sub UpdateDocSize(ByVal FQN$, ByVal UID$, ByVal fSize$)

        FQN = DMA.RemoveSingleQuotes(FQN)

        Dim S = ""
        S = S + "  UPDATE [DataSource]"
        S = S + "  set [FileLength] = " + fSize
        S = S + "  WHERE [DataSourceOwnerUserID] = '" + UID$ + "' and FQN = '" + FQN + "'"

        Dim B As Boolean = ExecuteSql(S)

        If Not B Then
            MsgBox("Failed to update File Size for FQN '" + FQN + "'.")
        End If

    End Sub

    Public Sub UpdateDocFqn(ByVal DocGuid$, ByVal FQN$)
        FQN = DMA.RemoveSingleQuotes(FQN)
        Dim S = ""
        S = S + "  UPDATE [DataSource]"
        S = S + "  set [FQN] = '" + FQN + "' "
        S = S + "  WHERE [SourceGuid] = '" + DocGuid + "'"

        Dim B As Boolean = ExecuteSql(S)

        If Not B Then
            MsgBox("Failed to update File FQN '" + FQN + "'.")
        End If

    End Sub

    Public Sub UpdateDocOriginalFileType(ByVal DocGuid$, ByVal OriginalFileType$)
        OriginalFileType = DMA.RemoveSingleQuotes(OriginalFileType)
        Dim S = ""
        S = S + "  UPDATE [DataSource]"
        S = S + "  set [OriginalFileType] = '" + OriginalFileType + "' "
        S = S + "  WHERE [SourceGuid] = '" + DocGuid + "'"

        Dim B As Boolean = ExecuteSql(S)

        If Not B Then
            MsgBox("Failed to update OriginalFileType '" + OriginalFileType + "'.")
        End If

    End Sub

    Public Sub UpdateZipFileIndicator(ByVal DocGuid$, ByVal cZipFile As Boolean)

        Dim C As String = ""
        If cZipFile Then
            C = "Y"
        Else
            C = "N"
        End If

        Dim S = ""
        S = S + "  UPDATE [DataSource]"
        S = S + "  set [IsZipFile] = '" + C + "' "
        S = S + "  WHERE [SourceGuid] = '" + DocGuid + "'"

        Dim B As Boolean = ExecuteSql(S)

        If Not B Then
            MsgBox("ERROR 285.34.2 Failed to update ZIPFILE flag: '" + DocGuid$ + "'.")
        End If

    End Sub

    Public Sub UpdateZipFileOwnerGuid(ByVal ParentGuid$, ByVal ZipFileGuid$, ByVal ZipFileFQN$)

        Dim S = ""
        S = S + "  UPDATE [DataSource]"
        S = S + "  set [ZipFileGuid] = '" + ParentGuid$ + "', ZipFileFQN = '" + ZipFileFQN$ + "' "
        S = S + "  WHERE [SourceGuid] = '" + ZipFileGuid$ + "'"

        Dim B As Boolean = ExecuteSql(S)

        If Not B Then
            MsgBox("ERROR 2858.34.2 Failed to update ZIPFILE FQN: '" + ParentGuid$ + "'.")
        End If

    End Sub

    Public Sub UpdateIsContainedWithinZipFile(ByVal DocGuid$)

        Dim C As String = ""

        Dim S = ""
        S = S + "  UPDATE [DataSource]"
        S = S + "  set [isContainedWithinZipFile] = 'Y' "
        S = S + "  WHERE [SourceGuid] = '" + DocGuid + "'"

        Dim B As Boolean = ExecuteSql(S)

        If Not B Then
            MsgBox("ERROR 285.34.21 Failed to update ZIPFILE flag: '" + DocGuid$ + "'.")
        End If

    End Sub

    Public Sub UpdateDocDir(ByVal DocGuid$, ByVal DocDir$)

        DocDir$ = DMA.RemoveSingleQuotes(DocDir$)
        DocDir = DMA.GetFilePath(DocDir)

        Dim S = ""
        S = S + "  UPDATE [DataSource]"
        S = S + "  set [FileDirectory] = '" + DocDir$ + "' "
        S = S + "  WHERE [SourceGuid] = '" + DocGuid + "'"

        Dim B As Boolean = ExecuteSql(S)

        If Not B Then
            MsgBox("Failed to update File Size for GUID '" + DocGuid + "'.")
        End If

    End Sub

    Public Function DeleteDataSourceAndAttrs(ByVal WhereClause$) As Boolean
        Dim S = ""
        Dim B As Boolean = False
        S = "delete from SourceAttribute where [SourceGuid] in (SELECT [SourceGuid] FROM [DataSource] " + WhereClause$ + ")"
        B = ExecuteSql(S)
        If B Then
            S = "delete from datasource " + WhereClause$
            B = ExecuteSql(S)
        Else
            B = False
        End If
        Return B
    End Function

    Public Function getProcessFileAsExt(ByVal FileExt$) As String
        If FileExt.Trim.Length = 0 Then
            Return ".ukn'"
        End If
        Dim NexExt$ = ""
        Dim ProcessExtCode$ = ""
        Dim S = "SELECT [ExtCode]"
        S = S + " ,[ProcessExtCode]"
        S = S + " FROM [DMA.UD].[dbo].[ProcessFileAs]"
        S = S + " where ExtCode = '" + FileExt$ + "'"

        Dim rsColInfo As SqlDataReader = Nothing
        'rsColInfo = SqlQryNo'Session(S)
        rsColInfo = SqlQry(S)

        If rsColInfo.HasRows Then
            rsColInfo.Read()
            NexExt$ = rsColInfo.GetValue(0).ToString
            ProcessExtCode = rsColInfo.GetValue(1).ToString
        Else
            NexExt$ = Nothing
        End If
        If Not rsColInfo.IsClosed Then
            rsColInfo.Close()
        End If
        If Not rsColInfo Is Nothing Then
            rsColInfo = Nothing
        End If
        Return ProcessExtCode
    End Function

    Sub SetDocumentPublicFlagByOwnerDir(ByVal UID$, ByVal FQN$, ByVal PublicFlag As Boolean, ByVal bDisableDir As Boolean)

        Dim S = ""
        Dim sFlag$ = ""
        Dim iFlag$ = ""
        Dim B As Boolean
        Dim DisableDir$ = ""

        If PublicFlag Then
            sFlag$ = "Y"
            iFlag$ = "1"
        Else
            sFlag$ = "N"
            iFlag$ = "0"
        End If
        If bDisableDir Then
            DisableDir$ = "Y"
        Else
            DisableDir$ = "N"
        End If

        Dim SS$ = ""

        '*******************************************************
        S = "update [Directory] set [ckPublic] = '" + sFlag$ + "', ckDisableDir = '" + DisableDir$ + "' where Userid = '" + UID$ + "' and [FQN] = '" + FQN + "'"
        SS = SS + vbCrLf + vbCrLf + S
        B = ExecuteSql(S)
        If Not B Then
            xTrace(93925, "clsDataBase:SetDocumentPublicFlag", "Failed to set public flag in DIRECTORY table.")
            xTrace(93925, "clsDataBase:SetDocumentPublicFlag", S)
        End If

        S = "update [Directory] set [ckPublic] = '" + sFlag$ + "', ckDisableDir = '" + DisableDir$ + "' where Userid = '" + UID$ + "' and [FQN] like '" + FQN$ + "\%'"
        SS = SS + vbCrLf + vbCrLf + S
        B = ExecuteSql(S)
        If Not B Then
            xTrace(93925, "clsDataBase:SetDocumentPublicFlag", "Failed to set public flag in DIRECTORY table.")
            xTrace(93925, "clsDataBase:SetDocumentPublicFlag", S)
        End If
        '*******************************************************
        S = "update [SubDir] set ckPublic = '" + sFlag$ + "', ckDisableDir = '" + DisableDir$ + "' where Userid = '" + UID$ + "' "
        S = S + " and ([FQN] = '" + FQN$ + "' or [SUBFQN] = '" + FQN$ + "')"
        SS = SS + vbCrLf + vbCrLf + S
        B = ExecuteSql(S)
        If Not B Then
            xTrace(93926, "clsDataBase:SetDocumentPublicFlag", "Failed to set public flag in SUBDIR table.")
            xTrace(93926, "clsDataBase:SetDocumentPublicFlag", S)
        End If

        S = "update [SubDir] set ckPublic = '" + sFlag$ + "', ckDisableDir = '" + DisableDir$ + "' where Userid = '" + UID$ + "' "
        S = S + " and ([FQN] like '" + FQN$ + "\%' or [SUBFQN] like '" + FQN$ + "\%')"
        SS = SS + vbCrLf + vbCrLf + S
        B = ExecuteSql(S)
        If Not B Then
            xTrace(93926, "clsDataBase:SetDocumentPublicFlag", "Failed to set public flag in SUBDIR table.")
            xTrace(93926, "clsDataBase:SetDocumentPublicFlag", S)
        End If
        '*******************************************************
        S = "update [DataSource] set [isPublic] = '" + sFlag$ + "'"
        S = S + " where FileDirectory = '" + FQN$ + "'"
        S = S + " and DataSourceOwnerUserID = '" + UID$ + "'"
        SS = SS + vbCrLf + vbCrLf + S
        B = ExecuteSql(S)
        If Not B Then
            xTrace(93926, "clsDataBase:SetDocumentPublicFlag", "Failed to set public flag in DataSource table.")
            xTrace(93926, "clsDataBase:SetDocumentPublicFlag", S)
        End If

        S = "update [DataSource] set [isPublic] = '" + sFlag$ + "'"
        S = S + " where FileDirectory LIKE '" + FQN$ + "\%'"
        S = S + " and DataSourceOwnerUserID = '" + UID$ + "'"
        SS = SS + vbCrLf + vbCrLf + S
        B = ExecuteSql(S)
        If Not B Then
            xTrace(93926, "clsDataBase:SetDocumentPublicFlag", "Failed to set public flag in DataSource table.")
            xTrace(93926, "clsDataBase:SetDocumentPublicFlag", S)
        End If
        '*******************************************************
        Clipboard.SetText(SS)

    End Sub

    Sub SetDocumentPublicFlag(ByVal UID$, ByVal FQN$, ByVal PublicFlag As Boolean)

        Dim S = ""
        Dim sFlag$ = ""
        Dim iFlag$ = ""
        Dim B As Boolean
        Dim DisableDir$ = ""

        If PublicFlag Then
            sFlag$ = "Y"
            iFlag$ = "1"
        Else
            sFlag$ = "N"
            iFlag$ = "0"
        End If

        S = "update [Directory] set [ckPublic] = '" + sFlag$ + "' where Userid = '" + UID$ + "' and [FQN] = '" + FQN$ + "'"
        B = ExecuteSql(S)
        If Not B Then
            xTrace(93925, "clsDataBase:SetDocumentPublicFlag", "Failed to set public flag in DIRECTORY table.")
            xTrace(93925, "clsDataBase:SetDocumentPublicFlag", S)
        End If

        S = "update [SubDir] set ckPublic = '" + sFlag$ + "' where Userid = '" + UID$ + "' "
        S = S + " and ([FQN] = '" + FQN$ + "' or [SUBFQN] = '" + FQN$ + "')"
        B = ExecuteSql(S)
        If Not B Then
            xTrace(93926, "clsDataBase:SetDocumentPublicFlag", "Failed to set public flag in SUBDIR table.")
            xTrace(93926, "clsDataBase:SetDocumentPublicFlag", S)
        End If

        S = "update [DataSource] set [isPublic] = '" + sFlag$ + "'"
        S = S + " where FileDirectory = '" + FQN$ + "'"
        S = S + " and DataSourceOwnerUserID = '" + UID$ + "'"
        B = ExecuteSql(S)
        If Not B Then
            xTrace(93926, "clsDataBase:SetDocumentPublicFlag", "Failed to set public flag in DataSource table.")
            xTrace(93926, "clsDataBase:SetDocumentPublicFlag", S)
        End If

    End Sub

    Sub addImageUsingDataset(ByVal MySql$, ByVal FQN$, ByVal SrcTable$)

        'Dim da As New SqlDataAdapter("Select SourceImage From SourceImage where SourceGuid = 'SourceGuid' and DataSourceOwnerUserID = 'DataSourceOwnerUserID'", gConn)
        'FQN = "C:\winnt\Gone Fishing.BMP"
        CkConn()

        Dim da As New SqlDataAdapter(MySql, gConn)
        Dim MyCB As SqlCommandBuilder = New SqlCommandBuilder(da)
        Dim ds As New DataSet()

        da.MissingSchemaAction = MissingSchemaAction.AddWithKey

        Dim fs As New FileStream(FQN, FileMode.OpenOrCreate, FileAccess.Read)
        Dim MyData(fs.Length) As Byte
        fs.Read(MyData, 0, fs.Length)
        fs.Close()
        gConn.Open()
        da.Fill(ds, SrcTable$)
        Dim myRow As DataRow

        myRow = ds.Tables(SrcTable$).NewRow()
        myRow("SourceImage") = MyData

        ds.Tables(SrcTable$).Rows.Add(myRow)
        da.Update(ds, SrcTable$)

        fs = Nothing
        MyCB = Nothing
        ds = Nothing
        da = Nothing

        gConn.Close()
        gConn = Nothing
        MsgBox("Image saved to database")
    End Sub

    Sub updateImageUsingDataset(ByVal MySql$, ByVal FQN$, ByVal SrcTable$)

        'Dim da As New SqlDataAdapter("Select SourceImage From SourceImage where SourceGuid = 'SourceGuid' and DataSourceOwnerUserID = 'DataSourceOwnerUserID'", gConn)
        'FQN = "C:\winnt\Gone Fishing.BMP"
        CkConn()

        Dim da As New SqlDataAdapter(MySql, gConn)
        Dim MyCB As SqlCommandBuilder = New SqlCommandBuilder(da)
        Dim ds As New DataSet()

        da.MissingSchemaAction = MissingSchemaAction.AddWithKey

        Dim fs As New FileStream(FQN, FileMode.OpenOrCreate, FileAccess.Read)
        Dim MyData(fs.Length) As Byte
        fs.Read(MyData, 0, fs.Length)
        fs.Close()
        gConn.Open()
        da.Fill(ds, SrcTable$)
        Dim myRow As DataRow

        '.NewRow()
        myRow = ds.Tables(SrcTable$).NewRow
        myRow("SourceImage") = MyData

        '.Add(myRow)
        ds.Tables("MyImages").Rows.Add(myRow)
        da.Update(ds, "MyImages")

        fs = Nothing
        MyCB = Nothing
        ds = Nothing
        da = Nothing

        gConn.Close()
        gConn = Nothing
        MsgBox("Image saved to database")
    End Sub

    Function writeImageSourceDataFromDbWriteToFile(ByVal SourceGuid$, ByVal FQN$, ByVal OverWrite As Boolean) As Boolean
        Dim B As Boolean = True
        Dim SourceTblName$ = "DataSource"
        Dim ImageFieldName$ = "SourceImage"

        Try
            Dim S = ""
            S = S + " SELECT "
            S = S + " [SourceImage]"
            S = S + " FROM  [DataSource]"
            S = S + " where [SourceGuid] = '" + SourceGuid$ + "'"

            Dim CN As New SqlConnection(getConnStr)

            If CN.State = ConnectionState.Closed Then
                CN.Open()
            End If

            Dim da As New SqlDataAdapter(S, CN)
            Dim MyCB As SqlCommandBuilder = New SqlCommandBuilder(da)
            Dim ds As New DataSet()

            da.Fill(ds, SourceTblName$)
            Dim myRow As DataRow
            myRow = ds.Tables(SourceTblName$).Rows(0)

            Dim MyData() As Byte
            MyData = myRow(ImageFieldName$)
            Dim K As Long
            K = UBound(MyData)
            Try
                If OverWrite Then
                    If File.Exists(FQN) Then
                        File.Delete(FQN$)
                    End If
                Else
                    If File.Exists(FQN) Then
                        Return False
                    End If
                End If
                Dim fs As New FileStream(FQN$, FileMode.CreateNew, FileAccess.Write)
                fs.Write(MyData, 0, K)
                fs.Close()
                fs = Nothing
            Catch ex As Exception
                Debug.Print(ex.Message)
                xTrace(58342.15, "clsDataBase:imageDataReadFromDbWriteToFile", ex.Message)
            End Try

            MyCB = Nothing
            ds = Nothing
            da = Nothing

            CN.Close()
            CN = Nothing
            GC.Collect()
        Catch ex As Exception
            Dim AppName$ = ex.Source
            xTrace(58342.1, "clsDataBase:imageDataReadFromDbWriteToFile", ex.Message)
        End Try
        Return B

    End Function

    Sub xPopulateComboBox(ByRef CB As ComboBox, ByVal TblColName$, ByVal S As String)
        Try
            CkConn()
            If gConn.State = ConnectionState.Closed Then
                gConn.Open()
            End If
            Dim DA As New SqlDataAdapter(S, gConn)
            Dim DS As New DataSet
            DA.Fill(DS, TblColName$)

            'Create and populate the DataTable to bind to the ComboBox:
            Dim dt As New DataTable
            dt.Columns.Add(TblColName$, GetType(System.String))

            ' Populate the DataTable to bind to the Combobox.
            Dim drDSRow As DataRow
            Dim drNewRow As DataRow
            Dim iRowCnt As Integer = 0
            For Each drDSRow In DS.Tables(TblColName$).Rows()
                drNewRow = dt.NewRow()
                drNewRow(TblColName$) = drDSRow(TblColName$)
                dt.Rows.Add(drNewRow)
                iRowCnt += 1
            Next
            If iRowCnt = 0 Then
                Return
            End If
            'Bind the DataTable to the ComboBox by setting the Combobox's DataSource property to the DataTable. To display the "Description" column in the Combobox's list, set the Combobox's DisplayMember property to the name of column. Likewise, to use the "Code" column as the value of an item in the Combobox set the ValueMember property.
            CB.DropDownStyle = ComboBoxStyle.DropDown
            CB.DataSource = dt
            CB.DisplayMember = TblColName$
            CB.SelectedIndex = 0

            If Not DS Is Nothing Then
                DS = Nothing
            End If
            If Not DA Is Nothing Then
                DA = Nothing
            End If
            If Not gConn Is Nothing Then
                gConn.Close()
                gConn = Nothing
            End If
        Catch ex As Exception
            Debug.Print("Error 2194.23: " + ex.Message)
        Finally
            GC.Collect()
        End Try
    End Sub

    Function writeEmailFromDbToFile(ByVal EmailGuid$, ByVal FQN$) As Boolean
        Dim B As Boolean = True

        'Dim TempPath = System.IO.Path.GetTempPath
        'Dim Dirname$ = DMA.GetFilePath(FQN$)
        'Dim FileName$ = DMA.GetFileName(FQN)

        Dim SourceTblName$ = "Email"
        Dim ImageFieldName$ = "EmailImage"

        Try
            'CkConn()

            Dim S = ""
            S = S + " SELECT "
            S = S + " [EmailImage]"
            S = S + " FROM  [Email]"
            S = S + " where [EmailGuid] = '" + EmailGuid$ + "'"

            Dim CN As New SqlConnection(getConnStr)

            If CN.State = ConnectionState.Closed Then
                CN.Open()
            End If

            Dim da As New SqlDataAdapter(S, CN)
            Dim MyCB As SqlCommandBuilder = New SqlCommandBuilder(da)
            Dim ds As New DataSet()

            da.Fill(ds, SourceTblName$)
            Dim myRow As DataRow
            myRow = ds.Tables(SourceTblName$).Rows(0)

            Dim MyData() As Byte
            MyData = myRow(ImageFieldName$)
            Dim K As Long
            K = UBound(MyData)

            Try
                Dim fs As New FileStream(FQN$, FileMode.CreateNew, FileAccess.Write)
                fs.Write(MyData, 0, K)
                fs.Close()
                fs = Nothing
            Catch ex As Exception
                Debug.Print(ex.Message)
                xTrace(42342.15, "clsDataBase:writeEmailFromDbToFile", ex.Message)
            End Try

            MyCB = Nothing
            ds = Nothing
            da = Nothing

            CN.Close()
            CN = Nothing
            GC.Collect()
        Catch ex As Exception
            Dim AppName$ = ex.Source
            xTrace(42342.1, "clsDataBase:writeEmailFromDbToFile", ex.Message)
        End Try
        Return B

    End Function

    Sub PopulateComboBox(ByRef CB As ComboBox, ByVal TblColName$, ByVal S As String)

        Dim tConn As New SqlConnection(getConnStr)
        Dim DA As New SqlDataAdapter(S, tConn)
        Dim DS As New DataSet

        Try

            If tConn.State = ConnectionState.Closed Then
                tConn.Open()
            End If

            DA.Fill(DS, TblColName$)

            'Create and populate the DataTable to bind to the ComboBox:
            Dim dt As New DataTable
            dt.Columns.Add(TblColName$, GetType(System.String))

            ' Populate the DataTable to bind to the Combobox.
            Dim drDSRow As DataRow
            Dim drNewRow As DataRow
            Dim iRowCnt As Integer = 0
            For Each drDSRow In DS.Tables(TblColName$).Rows()
                drNewRow = dt.NewRow()
                drNewRow(TblColName$) = drDSRow(TblColName$)
                dt.Rows.Add(drNewRow)
                iRowCnt += 1
                CB.Items.Add(drDSRow(0).ToString)
            Next
            If iRowCnt = 0 Then
                Return
            End If
            'Bind the DataTable to the ComboBox by setting the Combobox's DataSource property to the DataTable. To display the "Description" column in the Combobox's list, set the Combobox's DisplayMember property to the name of column. Likewise, to use the "Code" column as the value of an item in the Combobox set the ValueMember property.
            CB.DropDownStyle = ComboBoxStyle.DropDown
            'CB.DataSource = dt
            CB.DisplayMember = TblColName$
            CB.SelectedIndex = 0

            If Not DS Is Nothing Then
                DS = Nothing
            End If
            If Not DA Is Nothing Then
                DA = Nothing
            End If
            If Not tConn Is Nothing Then
                tConn.Close()
                tConn = Nothing
            End If
        Catch ex As Exception
            Debug.Print("Error 2194.23: " + ex.Message)
        Finally
            If Not DA Is Nothing Then
                DA = Nothing
            End If
            If Not DS Is Nothing Then
                DS = Nothing
            End If
            If Not tConn Is Nothing Then
                tConn.Close()
                tConn = Nothing
            End If
            GC.Collect()
        End Try
    End Sub

    Sub PopulateListBox(ByRef LB As ListBox, ByVal TblColName$, ByVal S As String)
        Try
            LB.DataSource = Nothing
            LB.Items.Clear()
            CkConn()
            If gConn.State = ConnectionState.Closed Then
                gConn.Open()
            End If
            Dim DA As New SqlDataAdapter(S, gConn)
            Dim DS As New DataSet
            DA.Fill(DS, TblColName$)

            'Create and populate the DataTable to bind to the ComboBox:
            Dim dt As New DataTable
            dt.Columns.Add(TblColName$, GetType(System.String))

            ' Populate the DataTable to bind to the Combobox.
            Dim drDSRow As DataRow
            Dim drNewRow As DataRow
            Dim iRowCnt As Integer = 0
            For Each drDSRow In DS.Tables(TblColName$).Rows()
                drNewRow = dt.NewRow()
                drNewRow(TblColName$) = drDSRow(TblColName$)
                dt.Rows.Add(drNewRow)
                iRowCnt += 1
            Next
            If iRowCnt = 0 Then
                Return
            End If
            'Bind the DataTable to the ComboBox by setting the Combobox's DataSource property to the DataTable.
            'To display the "Description" column in the Combobox's list, set the Combobox's DisplayMember property
            'to the name of column. Likewise, to use the "Code" column as the value of an item in the Combobox set
            'the ValueMember property.
            LB.DataSource = dt
            LB.DisplayMember = TblColName$
            LB.SelectedIndex = 0

            If Not DS Is Nothing Then
                DS = Nothing
            End If
            If Not DA Is Nothing Then
                DA = Nothing
            End If
            If Not gConn Is Nothing Then
                gConn.Close()
                gConn = Nothing
            End If
        Catch ex As Exception
            Debug.Print("Error 2194.23: " + ex.Message)
        Finally
            GC.Collect()
        End Try
    End Sub

    Sub PopulateUserSL(ByRef SL As SortedList)
        SL.Clear()
        Dim S = "SELECT [UserName], [UserID]  FROM [Users] order by [UserName]"

        Dim b As Boolean = True
        Dim i As Integer = 0
        Dim id As Integer = -1
        Dim II As Integer = 0
        Dim UserName$ = ""
        Dim UserID$ = ""

        Dim rsColInfo As SqlDataReader = Nothing
        'rsColInfo = SqlQryNo'Session(S)
        rsColInfo = SqlQry(S)
        If rsColInfo.HasRows Then
            Do While rsColInfo.Read()
                UserName$ = rsColInfo.GetValue(0).ToString
                UserID$ = rsColInfo.GetValue(1).ToString
                SL.Add(UserID, UserName)
            Loop
        Else
            id = -1
        End If
        rsColInfo.Close()
        rsColInfo = Nothing
    End Sub

    Function getDatasourceParm(ByVal AttributeName$, ByVal SourceGuid$) As String

        'Select AttributeValue
        '  FROM [SourceAttribute]
        'where AttributeName = 'Author'
        'and SourceGuid = '6ff1c120-66cd-4aac-b2ec-85dda9f48bc8'
        'go

        Dim S = ""
        Dim b As Boolean = True
        Dim i As Integer = 0
        Dim id As Integer = -1
        Dim II As Integer = 0
        Dim UserName$ = ""
        Dim UserID$ = ""
        Dim ColVAl$ = ""

        S = "Select AttributeValue "
        S = S + " FROM [SourceAttribute]"
        S = S + " where AttributeName = '" + AttributeName$ + "'"
        S = S + " and SourceGuid = '" + SourceGuid$ + "'"

        'Dim dDebug As Boolean = False
        'Dim queryString As String = Sql
        'Dim rc As Boolean = False
        Dim rsDataQry As SqlDataReader = Nothing
        Dim CN As New SqlConnection(Me.getConnStr)

        If CN.State = ConnectionState.Closed Then
            CN.Open()
        End If

        Dim command As New SqlCommand(S, CN)

        Try
            rsDataQry = command.ExecuteReader()
            If rsDataQry.HasRows Then
                Do While rsDataQry.Read()
                    ColVAl$ = rsDataQry.GetValue(0).ToString
                Loop
            Else
                ColVAl$ = ""
            End If
        Catch ex As Exception
            xTrace(1001, "clsDataBase:getDatasourceParm", ex.Message)
            xTrace(1002, "clsDataBase:getDatasourceParm", ex.StackTrace)
            xTrace(1003, "clsDataBase:getDatasourceParm", S)
        End Try

        If CN.State = ConnectionState.Open Then
            CN.Close()
        End If

        CN = Nothing
        command.Dispose()
        command = Nothing
        rsDataQry.Close()
        rsDataQry = Nothing
        Return ColVAl$

    End Function

    Function getSavedValue(ByVal userid$, ByVal SaveName$, ByVal SaveTypeCode$, ByVal ValName$) As String
        Dim S = ""
        Dim b As Boolean = True
        Dim i As Integer = 0
        Dim id As Integer = -1
        Dim II As Integer = 0
        Dim UserName$ = ""
        Dim ColVAl$ = ""

        S = S + " Select [ValName]"
        S = S + " ,[ValValue]"
        S = S + " FROM [SavedItems]"
        S = S + " where userid = 'wmiller'"
        S = S + " and SaveName = '" + SaveName$ + "'"
        S = S + " and SaveTypeCode = '" + SaveTypeCode$ + "'"
        S = S + " and ValName = '" + ValName$ + "'"

        Dim rsColInfo As SqlDataReader = Nothing
        rsColInfo = SqlQry(S)
        If rsColInfo.HasRows Then
            Do While rsColInfo.Read()
                ColVAl$ = rsColInfo.GetValue(1).ToString
                ColVAl$ = ColVAl$.Trim
                ColVAl = DMA.ReplaceSingleQuotes(ColVAl)
            Loop
        Else
            ColVAl$ = ""
        End If
        rsColInfo.Close()
        rsColInfo = Nothing

        If LCase(ColVAl$).Equals("null") Then
            ColVAl$ = ""
        End If

        Return ColVAl$

    End Function

    Function getLastSuccessfulArchiveDate(ByVal ArchiveType$, ByVal UserID$) As String
        Dim S = "SELECT  max(ArchiveStartDate)"
        S = S + " FROM [DMA.UD].[dbo].[ArchiveStats]"
        S = S + " where "
        S = S + " [ArchiveType] = '" + ArchiveType + "'"
        S = S + " and [UserID] = '" + UserID + "'"
        S = S + " and Status = 'Successful'"

        Dim ColVAl$ = ""

        Dim rsColInfo As SqlDataReader = Nothing
        rsColInfo = SqlQry(S)
        If rsColInfo.HasRows Then
            Do While rsColInfo.Read()
                ColVAl$ = rsColInfo.GetValue(0).ToString
                ColVAl$ = ColVAl$.Trim
                ColVAl = DMA.ReplaceSingleQuotes(ColVAl)
            Loop
        Else
            ColVAl$ = ""
        End If
        rsColInfo.Close()
        rsColInfo = Nothing

        If LCase(ColVAl$).Equals("null") Then
            ColVAl$ = ""
        End If

        Dim d1 As Date

        If ColVAl.Trim.Length = 0 Then
            'd1 = CDate("01/01/1900")
            d1 = Nothing
        Else
            d1 = CDate(ColVAl)
        End If

        Return d1

    End Function

    Function ckForWorkingDir(ByVal Userid$, ByVal ValName$) As Boolean

        '        where [SaveName] = 'UserStartUpParameters'
        'and [SaveTypeCode] = 'StartUpParm'
        'and ValName = 'Temp Directory'
        'and userid = 'smiller'

        Dim S = ""
        S = S + " where [SaveName] = 'UserStartUpParameters'"
        S = S + " and [SaveTypeCode] = 'StartUpParm'"
        S = S + " and ValName = '" + ValName$ + "'"
        S = S + " and userid = '" + Userid$ + "'"
        Dim B As Integer = iGetRowCount("SavedItems", S)

        Return B

    End Function

    Function getWorkingDirectory(ByVal Userid$, ByVal ValName$) As String

        'Dim SaveName$ = "Global Search Parameters"
        'Dim SaveTypeCode$ = "StartUpParm"

        Dim S = ""
        S = S + "SELECT [ValValue]"
        S = S + " FROM [SavedItems]"
        S = S + " where [SaveName] = 'UserStartUpParameters'"
        S = S + " and [SaveTypeCode] = 'StartUpParm'"
        S = S + " and ValName = '" + ValName$ + "'"
        S = S + " and userid = '" + Userid$ + "'"

        Dim ColVAl$ = ""

        Dim rsColInfo As SqlDataReader = Nothing
        rsColInfo = SqlQry(S)
        If rsColInfo.HasRows Then
            Do While rsColInfo.Read()
                ColVAl$ = rsColInfo.GetValue(0).ToString
                ColVAl$ = ColVAl$.Trim
                ColVAl = DMA.ReplaceSingleQuotes(ColVAl)
            Loop
        Else
            ColVAl$ = ""
        End If
        rsColInfo.Close()
        rsColInfo = Nothing

        If LCase(ColVAl$).Equals("null") Then
            ColVAl$ = ""
        End If

        If ValName$ = "CONTENT WORKING DIRECTORY" Then
            If ColVAl.Length > 0 Then
                If Not System.IO.Directory.Exists(ColVAl$) Then
                    ColVAl = System.IO.Path.GetTempPath()
                End If
            End If
        ElseIf ValName$ = "EMAIL WORKING DIRECTORY" Then
            If ColVAl.Length > 0 Then
                If Not System.IO.Directory.Exists(ColVAl$) Then
                    ColVAl = System.IO.Path.GetTempPath()
                End If
            End If
        ElseIf ValName$ = "DB WARNING LEVEL" Then
            If ColVAl.Length = 0 Then
                ColVAl = "250"
            End If
        ElseIf ValName$ = "DB RETURN INCREMENT" Then
            If ColVAl.Length = 0 Then
                ColVAl = "100"
            End If
        End If

        Return ColVAl$

    End Function

    Function iCountNbrEmailAttachments(ByVal EMailGuid$) As Integer

        Dim con As New SqlConnection(Me.getConnStr)
        con.Open()
        'Dim command As New SqlCommand(s, con)
        Dim rsCnt As SqlDataReader = Nothing

        Dim cnt As Integer = -1

        Try
            Dim tQuery As String = ""
            Dim s As String = ""

            s = "Select count(*) as TheCount From EmailAttachment where EmailGuid = '" & EMailGuid & "'"

            Using con
                rsCnt = SqlQry(s, con)
                rsCnt.Read()
                cnt = rsCnt.GetInt32(0)
                rsCnt.Close()

            End Using
        Catch ex As Exception
            Debug.Print("Error 3932.11g: " + ex.Message)
            cnt = 0
        Finally
            If Not rsCnt.IsClosed Then
                rsCnt.Close()
            End If
            rsCnt = Nothing
            'command.Connection.Close()
            'command = Nothing
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            con = Nothing
        End Try

        Return cnt

    End Function

    Sub DefineFileExt(ByRef LB As List(Of String))
        Dim ColVAl$ = ""
        Dim S = ""
        S = S + " SELECT distinct [OriginalFileType]"
        S = S + " FROM [DataSource]"
        S = S + " order by OriginalFileType"

        Dim rsColInfo As SqlDataReader = Nothing
        rsColInfo = SqlQry(S)
        If rsColInfo.HasRows Then
            Do While rsColInfo.Read()
                ColVAl$ = rsColInfo.GetValue(0).ToString
                ColVAl$ = ColVAl$.Trim
                ColVAl = DMA.ReplaceSingleQuotes(ColVAl)
                DMA.ListRegistryKeys(ColVAl, LB)
            Loop
        End If

    End Sub

    Function UpdateBlob(ByVal TblName$, ByVal ImageColumnName$, ByVal WhereClause$, ByVal FQN$) As Boolean
        Dim b As Boolean = False
        Try
            Dim ConnStr = getConnStr()
            Dim connection As New SqlConnection(ConnStr)

            Dim command As New SqlCommand("UPDATE " + TblName + " SET " + ImageColumnName$ + " = @FileContents " + WhereClause$, connection)
            command.Parameters.Add("@FileContents", SqlDbType.VarBinary).Value = IO.File.ReadAllBytes(FQN)
            connection.Open()
            command.ExecuteNonQuery()
            connection.Close()
            b = True
        Catch ex As Exception
            b = False
        End Try
        Return b
    End Function

    Sub RebuildFulltextCatalog()
        Dim S = ""
        S = "EXEC sp_fulltext_catalog 'ftCatalog', 'start_full' "
        ExecuteSql(S)
        S = "EXEC sp_fulltext_catalog 'EMAIL_CATELOG', 'start_full' "
        ExecuteSql(S)
    End Sub

    Function isAdmin(ByVal Userid$) As Boolean
        Dim B As Boolean = False

        Dim ColVAl$ = ""
        Dim S = "SELECT [Admin] FROM [Users] where userid = '" + Userid$ + "'"

        Dim rsColInfo As SqlDataReader = Nothing
        rsColInfo = SqlQry(S)
        If rsColInfo.HasRows Then
            rsColInfo.Read()
            ColVAl$ = rsColInfo.GetValue(0).ToString
            ColVAl$ = ColVAl$.Trim
            If ColVAl.Equals("True") Then
                B = True
            End If
            If ColVAl.Equals("0") Then
                B = False
            End If
            If ColVAl.Equals("1") Then
                B = True
            End If
            If ColVAl.Equals("") Then
                B = False
            End If
            If ColVAl.Equals("Y") Then
                B = True
            End If
            If ColVAl.Equals("N") Then
                B = False
            End If
        End If
        Return B
    End Function

    Function RefactorUserid(ByVal FromUserid$, ByVal ToUserid$) As String

        Dim Msg$ = ""

        Dim myConnection As New SqlConnection("Data Source=localhost;Initial Catalog=Northwind;uid=sa;pwd=sa;")
        myConnection.Open()

        Dim myTrans = myConnection.BeginTransaction()
        Dim myCommand As New SqlCommand()
        myCommand.Connection = myConnection
        myCommand.Transaction = myTrans
        Try
            myCommand.CommandText = "Insert into Region (RegionID, RegionDescription) VALUES (100, 'Description')"
            myCommand.ExecuteNonQuery()
            myCommand.CommandText = "delete * from Region where RegionID=101"
            myCommand.ExecuteNonQuery()
            myTrans.Commit()
            Msg = "The userid was successfully changed from " + FromUserid$ + " to " + ToUserid$ + " throughout the entire repository for both content and emails."
        Catch ep As Exception
            myTrans.Rollback()
            Msg = "ERROR: The userid Failed to change from " + FromUserid$ + " to " + ToUserid$ + ". All transactions rolled back to original state."
        Finally
            myConnection.Close()
        End Try
        Return Msg
    End Function

    Function getPw(ByVal UID$) As String

        Dim ColVAl$ = ""
        Dim S = "SELECT [UserPassword] FROM [DMA.UD].[dbo].[Users] where UserLoginID = '" + UID + "'"

        Dim rsColInfo As SqlDataReader = Nothing
        rsColInfo = SqlQry(S)
        If rsColInfo.HasRows Then
            rsColInfo.Read()
            ColVAl$ = rsColInfo.GetValue(0).ToString
            ColVAl$ = ColVAl$.Trim
        End If
        Return ColVAl$
    End Function

    Function iCountUserContent(ByVal UID$) As Integer
        Dim S = "select count(*) from DataSource where DataSourceOwnerUserID = '" + UID + "'"

        Dim cnt As Integer = 0
        CkConn()
        Try
            Using gConn
                Dim command As New SqlCommand(S, gConn)
                Dim rsCnt As SqlDataReader = Nothing
                rsCnt = SqlQry(S)
                rsCnt.Read()
                cnt = rsCnt.GetInt32(0)
                rsCnt.Close()
                rsCnt = Nothing
                command.Connection.Close()
                command = Nothing
            End Using
        Catch ex As Exception

        End Try

        Return cnt
    End Function

    Function iCountUserEmails(ByVal UID$) As Integer
        Dim S = "select count(*) from email where Userid = '" + UID + "'"

        Dim cnt As Integer = 0
        CkConn()
        Try
            Using gConn
                Dim command As New SqlCommand(S, gConn)
                Dim rsCnt As SqlDataReader = Nothing
                rsCnt = SqlQry(S)
                rsCnt.Read()
                cnt = rsCnt.GetInt32(0)
                rsCnt.Close()
                rsCnt = Nothing
                command.Connection.Close()
                command = Nothing
            End Using
        Catch ex As Exception

        End Try

        Return cnt
    End Function

    Public Function SaveErrMsg(ByVal ErrMsg$, ByVal ErrStack$, ByVal IDNBR$, ByVal ConnectiveGuid$) As String

        Dim DB As New clsDatabase
        Dim rc$ = ""
        Dim SQL$ = ""

        Dim ConnectionString$ = Me.getConnStr
        Dim CN As New SqlConnection(ConnectionString)

        Try
            If CN.State = ConnectionState.Closed Then
                CN.Open()
            End If

            ErrMsg$ = DMA.RemoveSingleQuotes(ErrMsg$)
            ErrStack$ = DMA.RemoveSingleQuotes(ErrStack$)

            Dim MySql$ = "INSERT INTO [RuntimeErrors] "
            MySql$ = MySql$ + "([ErrorMsg]"
            MySql$ = MySql$ + ",[StackTrace]"
            MySql$ = MySql$ + ",IdNbr, ConnectiveGuid, Userid)"
            MySql$ = MySql$ + "VALUES "
            MySql$ = MySql$ + "('" + ErrMsg + "'"
            MySql$ = MySql$ + ",'" + ErrStack + "'"
            MySql$ = MySql$ + ",'" + IDNBR + "' "
            MySql$ = MySql$ + ",'" + ConnectiveGuid + "' "
            MySql$ = MySql$ + ",'" + CurrUserGuidID + "')"

            Using CN
                Dim dbCmd As SqlCommand = CN.CreateCommand()
                dbCmd.Connection = CN
                Try
                    dbCmd.CommandText = MySql$
                    dbCmd.ExecuteNonQuery()
                    ' Attempt to commit the transaction.
                    'transaction.Commit()

                    Dim debug As Boolean = True
                    If debug Then
                        Console.WriteLine("Successful execution: " + vbCrLf + MySql$)
                    End If
                    rc = True
                Catch ex As Exception
                    rc = "SaveErrMsg" + vbCrLf + ex.Message + vbCrLf + vbCrLf + ex.StackTrace
                End Try
                If CN.State = Data.ConnectionState.Open Then
                    CN.Close()
                End If
                If Not CN Is Nothing Then
                    CN = Nothing
                End If
                If dbCmd Is Nothing Then
                    dbCmd = Nothing
                End If
            End Using
        Catch ex As Exception
            rc = "SaveErrMsg" + vbCrLf + ex.Message + vbCrLf + vbCrLf + ex.StackTrace
        End Try

        'If CN.State = Data.ConnectionState.Open Then
        '    CN.Close()
        'End If
        'If Not CN Is Nothing Then
        '    CN = Nothing
        'End If

        Return rc

    End Function

    Sub getMissingVaules(ByVal tGuid$, ByRef VersionNbr$, ByRef LastAccessDate$, ByRef LastWriteTime$, ByRef RetentionExpirationDate$, ByRef IsPublic$)
        Dim S = " SELECt  [VersionNbr]"
        S = S + " ,[LastAccessDate]      "
        S = S + " ,[LastWriteTime]"
        S = S + " ,[RetentionExpirationDate]"
        S = S + " ,[IsPublic]"
        S = S + " FROM [DataSource]"
        S = S + " where [SourceGuid] = '" + tGuid$ + "' "

        Dim cnt As Integer = 0
        CkConn()
        Try
            Using gConn
                Dim command As New SqlCommand(S, gConn)
                Dim rsCnt As SqlDataReader = Nothing
                rsCnt = SqlQry(S)
                rsCnt.Read()
                VersionNbr$ = rsCnt.GetValue(0).ToString
                LastAccessDate$ = rsCnt.GetValue(1).ToString
                LastWriteTime$ = rsCnt.GetValue(2).ToString
                RetentionExpirationDate$ = rsCnt.GetValue(3).ToString
                IsPublic$ = rsCnt.GetValue(4).ToString
                rsCnt.Close()
                rsCnt = Nothing
                command.Connection.Close()
                command = Nothing
            End Using
        Catch ex As Exception
            xTrace(9001, "clsDataBase:getMissingVaules", ex.Message)
            xTrace(9002, "clsDataBase:getMissingVaules", S)
        End Try

    End Sub

    Sub getMissingEmailVaules(ByVal tGuid$, ByRef RetentionExpirationDate$, ByRef IsPublic$)
        Dim S = " SELECT [isPublic],[RetentionExpirationDate] FROM [Email] where [EmailGuid] = '" + tGuid + "'"

        Dim cnt As Integer = 0
        CkConn()
        Try
            Using gConn
                Dim command As New SqlCommand(S, gConn)
                Dim rsCnt As SqlDataReader = Nothing
                rsCnt = SqlQry(S)
                rsCnt.Read()
                IsPublic$ = rsCnt.GetValue(0).ToString
                RetentionExpirationDate$ = rsCnt.GetValue(1).ToString
                rsCnt.Close()
                rsCnt = Nothing
                command.Connection.Close()
                command = Nothing
            End Using
        Catch ex As Exception
            xTrace(92301, "clsDataBase:getMissingEmailVaules", ex.Message)
            xTrace(92302, "clsDataBase:getMissingEmailVaules", S)
        End Try

    End Sub

    Function getMetaData(ByVal tGuid$) As String

        Dim S = ""
        S = S + " SELECT [AttributeName] + ': ' +  [AttributeValue] + ', '      "
        S = S + " FROM [DMA.UD].[dbo].[SourceAttribute]"
        S = S + " where [SourceGuid] = '" + tGuid$ + "' "
        S = S + " order by [AttributeName]"

        Dim Msg$ = ""

        Dim cnt As Integer = 0
        CkConn()
        Try
            Using gConn
                Dim command As New SqlCommand(S, gConn)
                Dim rsCnt As SqlDataReader = Nothing
                rsCnt = SqlQry(S)
                If rsCnt.HasRows Then
                    Do While rsCnt.Read
                        Msg$ += rsCnt.GetValue(0).ToString + " ... " + vbCrLf
                    Loop
                End If

                rsCnt.Close()
                rsCnt = Nothing
                command.Connection.Close()
                command = Nothing
            End Using
        Catch ex As Exception
            xTrace(10101, "clsDataBase:getMetaData", ex.Message)
            xTrace(10102, "clsDataBase:getMetaData", S)
        End Try
        Return Msg
    End Function

    Sub getContentColumns(ByVal SourceGuid$, ByRef SL As SortedList)
        Dim S = ""
        S = S + " SELECT  "
        S = S + " [CreateDate]()"
        S = S + " ,[SourceName]"
        S = S + " ,[SourceTypeCode]"
        S = S + " ,[FQN]"
        S = S + " ,[VersionNbr]"
        S = S + " ,[LastAccessDate]"
        S = S + " ,[FileLength]"
        S = S + " ,[LastWriteTime]"
        S = S + " ,[UserID]"
        S = S + " ,[DataSourceOwnerUserID]"
        S = S + " ,[isPublic]"
        S = S + " ,[FileDirectory]"
        S = S + " ,[OriginalFileType]"
        S = S + " ,[RetentionExpirationDate]"
        S = S + " ,[IsPublicPreviousState]"
        S = S + " ,[isAvailable]"
        S = S + " ,[isContainedWithinZipFile]"
        S = S + " ,[ZipFileGuid]"
        S = S + " ,[IsZipFile]"
        S = S + " ,[DataVerified]"
        S = S + " FROM([DataSource])"
        S = S + " where [SourceGuid] = '" + SourceGuid$ + "'"

        CkConn()

        Dim rsColInfo As SqlDataReader = Nothing
        'rsColInfo = SqlQryNo'Session(S)
        rsColInfo = SqlQry(S)
        SL.Clear()
        If rsColInfo.HasRows Then
            Do While rsColInfo.Read()
                SL.Clear()
                Dim iCols As Integer = rsColInfo.FieldCount - 1
                For iCols = 0 To rsColInfo.FieldCount - 1
                    FillSortedList(rsColInfo, iCols, SL)
                Next
            Loop
        Else
            SL.Clear()
        End If
        rsColInfo.Close()
        rsColInfo = Nothing

    End Sub

    Sub getEmailColumns(ByVal SourceGuid$, ByRef SL As SortedList)
        Dim S = ""
        S = S + " SELECT  "
        S = S + " [EmailGuid]"
        S = S + " ,[SUBJECT]"
        S = S + " ,[SentTO]"
        S = S + " ,[Body]"
        S = S + " ,[Bcc]"
        S = S + " ,[BillingInformation]"
        S = S + " ,[CC]"
        S = S + " ,[Companies]"
        S = S + " ,[CreationTime]"
        S = S + " ,[ReadReceiptRequested]"
        S = S + " ,[ReceivedByName]"
        S = S + " ,[ReceivedTime]"
        S = S + " ,[AllRecipients]"
        S = S + " ,[UserID]"
        S = S + " ,[SenderEmailAddress]"
        S = S + " ,[SenderName]"
        S = S + " ,[Sensitivity]"
        S = S + " ,[SentOn]"
        S = S + " ,[MsgSize]"
        S = S + " ,[DeferredDeliveryTime]"
        S = S + " ,[EntryID]"
        S = S + " ,[ExpiryTime]"
        S = S + " ,[LastModificationTime]"
        S = S + " ,[EmailImage]"
        S = S + " ,[Accounts]"
        S = S + " ,[RowID]"
        S = S + " ,[ShortSubj]"
        S = S + " ,[SourceTypeCode]"
        S = S + " ,[OriginalFolder]"
        S = S + " ,[StoreID]"
        S = S + " ,[isPublic]"
        S = S + " ,[RetentionExpirationDate]"
        S = S + " ,[IsPublicPreviousState]"
        S = S + " ,[isAvailable]"
        S = S + " FROM [DMA.UD].[dbo].[Email]"
        S = S + " where [EmailGuid] = '" + SourceGuid$ + "'"

        CkConn()

        Dim rsColInfo As SqlDataReader = Nothing
        'rsColInfo = SqlQryNo'Session(S)
        rsColInfo = SqlQry(S)
        SL.Clear()
        If rsColInfo.HasRows Then
            Do While rsColInfo.Read()
                SL.Clear()
                Dim iCols As Integer = rsColInfo.FieldCount - 1
                For iCols = 0 To rsColInfo.FieldCount - 1
                    FillSortedList(rsColInfo, iCols, SL)
                Next
            Loop
        Else
            SL.Clear()
        End If
        rsColInfo.Close()
        rsColInfo = Nothing

    End Sub

    Sub FillSortedList(ByVal rsColInfo As SqlDataReader, ByVal iRow As Integer, ByRef SL As SortedList)
        Dim cName$ = rsColInfo.GetName(iRow).ToString
        Try
            Dim tColValue$ = rsColInfo.GetValue(0).ToString
            SL.Add(cName$, tColValue$)
        Catch ex As Exception
            Dim tColValue$ = ""
            SL.Add(cName$, tColValue$)
        End Try

    End Sub

    Function GetGuidByFqn(ByVal UserID$, ByVal FQN$) As String
        FQN$ = DMA.RemoveSingleQuotes(FQN$)

        Dim S = "SELECT  SourceGuid FROM [DataSource] where FQN = '" + FQN + "' and DataSourceOwnerUserID = '" + UserID$ + "'"
        CkConn()
        Dim xGuid$ = ""

        Dim rsData As SqlDataReader = Nothing
        Dim b As Boolean = False
        rsData = SqlQry(S)

        If rsData.HasRows Then
            rsData.Read()
            xGuid$ = rsData.GetValue(0).ToString
        Else
            xGuid$ = ""
        End If

        rsData.Close()
        rsData = Nothing

        Return xGuid$

    End Function

    Function GetLibOwnerByName(ByVal LibraryName$) As String

        Dim S = "select UserID from Library where LibraryName = '" + LibraryName$ + "'"
        CkConn()
        Dim xGuid$ = ""

        Dim rsData As SqlDataReader = Nothing
        Dim b As Boolean = False
        rsData = SqlQry(S)

        If rsData.HasRows Then
            rsData.Read()
            xGuid$ = rsData.GetValue(0).ToString
        Else
            xGuid$ = ""
        End If

        rsData.Close()
        rsData = Nothing

        Return xGuid$

    End Function

    Function addDocSourceDescription(ByVal SourceGuid$, ByVal Description$) As Boolean
        Description = DMA.RemoveSingleQuotes(Description)
        Dim mySql$ = ""
        mySql$ = "UPDATE [DataSource] set Description = '" + Description + "' where SourceGuid = '" + SourceGuid + "'"
        Dim b As Boolean = ExecuteSql(mySql)
        Return b
    End Function

    Function addDocSourceError(ByVal SourceGuid$, ByVal Notes$) As Boolean
        Notes = DMA.RemoveSingleQuotes(Notes)
        Dim mySql$ = ""
        mySql$ = "UPDATE [DataSource] set Notes = '" + Notes + "' where SourceGuid = '" + SourceGuid + "'"
        Dim b As Boolean = ExecuteSql(mySql)
        Return b
    End Function

    Function addDocSourceKeyWords(ByVal SourceGuid$, ByVal KeyWords$) As Boolean
        KeyWords = DMA.RemoveSingleQuotes(KeyWords)
        Dim mySql$ = ""
        mySql$ = "UPDATE [DataSource] set KeyWords = '" + KeyWords + "' where SourceGuid = '" + SourceGuid + "'"
        Dim b As Boolean = ExecuteSql(mySql)
        Return b
    End Function

    Function UpdateMetaData(ByVal Author$, ByVal Description$, ByVal Keywords$, ByVal QuickRefIdNbr$, ByVal FQN$) As Boolean
        Author$ = DMA.RemoveSingleQuotes(Author$)
        Description$ = DMA.RemoveSingleQuotes(Description$)
        Keywords$ = DMA.RemoveSingleQuotes(Keywords$)
        FQN = DMA.RemoveSingleQuotes(FQN)
        Dim S = ""
        S = "update QuickRefItems set Author = '" + Author$
        S = S + "', Description = '" + Description$
        S = S + "', Keywords = '" + Keywords$
        S = S + "' where QuickRefIdNbr = " + QuickRefIdNbr$
        S = S + " and FQN = '" + FQN.ToString + "'"

        Dim b As Boolean = ExecuteSqlNewConn(S)

        Return b

    End Function

    'Sub LoadProcessDates()
    '    Dim S = ""
    '    S = S + " select OriginalFolder, max(CreationTime) as MaxDate "
    '    S = S + " FROM EMAIL "
    '    S = S + " group by OriginalFolder"
    '    CkConn()

    ' slProcessDates.Clear()

    ' Dim OriginalFolder$ = "" Dim MaxDate As Date = Now

    ' Dim rsColInfo As SqlDataReader = Nothing 'rsColInfo = SqlQryNo'Session(S) rsColInfo = SqlQry(S)

    '    If rsColInfo.HasRows Then
    '        Do While rsColInfo.Read()
    '            OriginalFolder$ = rsColInfo.GetValue(0).ToString
    '            MaxDate = CDate(rsColInfo.GetValue(1).ToString)
    '            addEmailProcessDate(OriginalFolder$, MaxDate)
    '        Loop
    '    End If
    '    rsColInfo.Close()
    '    rsColInfo = Nothing
    'End Sub
    Function getSourceGuidByFqn(ByVal fqn$, ByVal UserID$) As String
        Try
            Dim S = " SELECT SourceGuid FROM DataSource where FQN = '" + fqn$ + "' AND DataSourceOwnerUserID = '" + UserID$ + "' "
            Dim SourceGuid$ = ""

            Dim rsColInfo As SqlDataReader = Nothing
            'rsColInfo = SqlQryNo'Session(S)
            rsColInfo = SqlQry(S)
            If rsColInfo.HasRows Then
                Do While rsColInfo.Read()
                    SourceGuid = rsColInfo.GetValue(0).ToString
                    Application.DoEvents()
                Loop
            End If
            rsColInfo.Close()
            rsColInfo = Nothing

            Return SourceGuid
        Catch ex As Exception
            Me.xTrace(23.456, "getSourceGuidByFqn", "clsDatabase", ex)
            Return Nothing
        End Try

    End Function

    Sub LoadEntryIdByFolder(ByVal FolderName$, ByRef L As SortedList)
        Dim S = "select EntryId from email where OriginalFolder = '" + FolderName$ + "' order by storeid"
        L.Clear()

        CkConn()
        Dim I As Integer = 0

        Dim rsColInfo As SqlDataReader = Nothing
        'rsColInfo = SqlQryNo'Session(S)
        rsColInfo = Me.SqlQryNewConn(S)
        If rsColInfo.HasRows Then
            Do While rsColInfo.Read()
                Dim EntryId$ = rsColInfo.GetValue(0).ToString
                I += 1
                Dim II As Integer = L.IndexOfKey(EntryId)
                If II < 0 Then
                    L.Add(EntryId, I)
                Else
                    Debug.Print("Dup found")
                End If
            Loop
        Else
            L.Clear()
        End If

        If Not rsColInfo.IsClosed Then
            rsColInfo.Close()
        End If
        If Not rsColInfo Is Nothing Then
            rsColInfo = Nothing
        End If

    End Sub

    Function getCountStoreIdByFolder(ByVal FolderName$) As Integer
        Dim iCnt As Integer = 0
        Dim S = "select count(*) from email where OriginalFolder = '" + FolderName$ + "'"

        CkConn()
        Dim I As Integer = 0

        Dim rsColInfo As SqlDataReader = Nothing
        'rsColInfo = SqlQryNo'Session(S)
        rsColInfo = Me.SqlQryNewConn(S)
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

    Sub getGroupUsers(ByVal GroupName$, ByRef GroupList As ArrayList)
        Dim S = "SELECT [UserID] FROM [DMA.UD].[dbo].[GroupUsers] where [GroupName] = '" + GroupName$ + "' "
        CkConn()
        Dim I As Integer = 0

        Dim rsColInfo As SqlDataReader = Nothing
        'rsColInfo = SqlQryNo'Session(S)
        rsColInfo = Me.SqlQryNewConn(S)
        If rsColInfo.HasRows Then
            Do While rsColInfo.Read()
                Dim UserID$ = rsColInfo.GetValue(0).ToString
                GroupList.Add(UserID)
            Loop
        End If

        If Not rsColInfo.IsClosed Then
            rsColInfo.Close()
        End If
        If Not rsColInfo Is Nothing Then
            rsColInfo = Nothing
        End If
    End Sub

    Public Function UpdateArchiveFlag(ByVal UID$, ByVal aFlag$, ByVal FolderName$) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        s = s + " update EmailFolder set "
        s = s + "SelectedForArchive = '" + aFlag$ + "'" + " where UserID = '" + UID + "' and FolderName = '" + FolderName + "' "

        Return ExecuteSql(s)
    End Function

    Public Function getFolderNameById(ByVal FolderID$) As String
        Dim b As Boolean = True
        Dim tSQL As String = ""
        tSQL = "SELECT [FolderName]      "
        tSQL = tSQL + " FROM [EmailFolder]"
        tSQL = tSQL + " where [FolderID] = '" + FolderID + "'"
        Dim i As Integer = 0
        Dim id$ = ""

        Dim rsData As SqlDataReader = Nothing

        rsData = SqlQry(tSQL)
        If rsData.HasRows Then
            rsData.Read()
            id = rsData.GetValue(0).ToString
        Else
            id = ""
        End If
        rsData.Close()
        rsData = Nothing
        Return id
    End Function

    Function RemoveGroupUser(ByVal GroupName$, ByVal UserID$) As Boolean
        Dim B As Boolean = True
        Dim SqlList As New ArrayList
        Try
            Dim S = " SELECT     GroupUsers.GroupName, GroupLibraryAccess.LibraryName, GroupUsers.UserID "
            S = S + " FROM         GroupUsers INNER JOIN"
            S = S + "                       GroupLibraryAccess ON GroupUsers.GroupName = GroupLibraryAccess.GroupName"
            S = S + " where GroupUsers.groupName = '" + GroupName$ + "'"
            S = S + " and GroupUsers.UserID = '" + UserID$ + "'"
            S = S + " group by GroupUsers.GroupName, GroupLibraryAccess.LibraryName, GroupUsers.UserID "

            Dim LibraryName$ = ""

            Dim rsColInfo As SqlDataReader = Nothing
            'rsColInfo = SqlQryNo'Session(S)
            rsColInfo = SqlQry(S)
            If rsColInfo.HasRows Then
                Do While rsColInfo.Read()
                    LibraryName$ = rsColInfo.GetValue(1).ToString

                    Dim tSql$ = "delete from libraryusers where libraryname = '" + LibraryName$ + "' and UserID = '" + UserID$ + "'"
                    SqlList.Add(tSql)

                    Application.DoEvents()
                Loop
            End If
            rsColInfo.Close()
            rsColInfo = Nothing

            For i As Integer = 0 To SqlList.Count - 1
                Dim tSql$ = SqlList.Item(i).ToString
                Dim BB As Boolean = Me.ExecuteSqlNewConn(tSql)
            Next

            SqlList.Clear()
            SqlList = Nothing
            GC.Collect()

            Return B
        Catch ex As Exception
            Me.xTrace(23.456, "getSourceGuidByFqn", "clsDatabase", ex)
            Return False
        End Try
    End Function

    Function getGroupOwnerGuidByGroupName(ByVal GroupName$) As String
        Try
            Dim S = "SELECT [GroupOwnerUserID] ,[GroupName] FROM [DMA.UD].[dbo].[UserGroup] where GroupName = '" + GroupName$ + "'"
            Dim SourceGuid$ = ""

            Dim rsColInfo As SqlDataReader = Nothing
            'rsColInfo = SqlQryNo'Session(S)
            rsColInfo = SqlQry(S)
            If rsColInfo.HasRows Then
                Do While rsColInfo.Read()
                    SourceGuid = rsColInfo.GetValue(0).ToString
                    Application.DoEvents()
                Loop
            End If
            rsColInfo.Close()
            rsColInfo = Nothing

            Return SourceGuid
        Catch ex As Exception
            Me.xTrace(23.456, "getSourceGuidByFqn", "clsDatabase", ex)
            Return Nothing
        End Try

    End Function

    Function getUserEmailAddrByUserID(ByVal UserID$) As String
        Try
            Dim S = "SELECT EmailAddress FROM Users where UserID = '" + UserID + "'"
            Dim SourceGuid$ = ""
            Dim rsColInfo As SqlDataReader = Nothing
            rsColInfo = SqlQry(S)
            If rsColInfo.HasRows Then
                Do While rsColInfo.Read()
                    SourceGuid = rsColInfo.GetValue(0).ToString
                    Application.DoEvents()
                Loop
            End If
            rsColInfo.Close()
            rsColInfo = Nothing
            Return SourceGuid
        Catch ex As Exception
            Me.xTrace(23.33, "getUserEmailAddrByUserID", "clsDatabase", ex)
            Return ""
        End Try
    End Function

    Function getUserNameByEmailAddr(ByVal EmailAddress$) As String
        Try
            Dim S = "SELECT UserName FROM email where EmailAddress = '" + EmailAddress + "'"
            Dim SourceGuid$ = ""
            Dim rsColInfo As SqlDataReader = Nothing
            rsColInfo = SqlQry(S)
            If rsColInfo.HasRows Then
                Do While rsColInfo.Read()
                    SourceGuid = rsColInfo.GetValue(0).ToString
                    Application.DoEvents()
                Loop
            End If
            rsColInfo.Close()
            rsColInfo = Nothing

            Return SourceGuid
        Catch ex As Exception
            Me.xTrace(23.34, "getUserNameByEmailAddr", "clsDatabase", ex)
            Return ""
        End Try
    End Function

    Sub loadReassignHistory(ByVal OldUid$, ByVal NewUid$, ByRef UserArray As ArrayList)
        UserArray.Clear()
        Dim S = "  SELECT [UserID]"
        S = S + " ,[UserName]"
        S = S + " ,[EmailAddress]"
        S = S + " ,[UserPassword]"
        S = S + " ,[Admin]"
        S = S + " ,[isActive]"
        S = S + " ,[UserLoginID]"
        S = S + " from users WHERE (Users.UserID = '" + OldUid$ + "') "
        Dim SourceGuid$ = ""
        Dim rsColInfo As SqlDataReader = Nothing
        rsColInfo = SqlQry(S)
        Dim II As Integer = 0
        If rsColInfo.HasRows Then
            Do While rsColInfo.Read()
                II += 1
                Dim UserID$ = rsColInfo.GetValue(0).ToString
                Dim UserName$ = rsColInfo.GetValue(1).ToString
                Dim EmailAddress$ = rsColInfo.GetValue(2).ToString
                Dim UserPassword$ = rsColInfo.GetValue(3).ToString
                Dim Admin$ = rsColInfo.GetValue(4).ToString
                Dim isActive$ = rsColInfo.GetValue(5).ToString
                Dim UserLoginID$ = rsColInfo.GetValue(6).ToString

                UserArray.Add(UserID$)
                UserArray.Add(UserName$)
                UserArray.Add(EmailAddress$)
                UserArray.Add(UserPassword$)
                UserArray.Add(Admin$)
                UserArray.Add(isActive$)
                UserArray.Add(UserLoginID$)

                Application.DoEvents()
            Loop
        End If
        rsColInfo.Close()
        rsColInfo = Nothing

        S = "  SELECT [UserID]"
        S = S + " ,[UserName]"
        S = S + " ,[EmailAddress]"
        S = S + " ,[UserPassword]"
        S = S + " ,[Admin]"
        S = S + " ,[isActive]"
        S = S + " ,[UserLoginID]"
        S = S + " from users WHERE Users.UserID = N'" + NewUid$ + "' "
        SourceGuid$ = ""

        rsColInfo = SqlQry(S)
        II = 0
        If rsColInfo.HasRows Then
            Do While rsColInfo.Read()
                II += 1
                Dim UserID$ = rsColInfo.GetValue(0).ToString
                Dim UserName$ = rsColInfo.GetValue(1).ToString
                Dim EmailAddress$ = rsColInfo.GetValue(2).ToString
                Dim UserPassword$ = rsColInfo.GetValue(3).ToString
                Dim Admin$ = rsColInfo.GetValue(4).ToString
                Dim isActive$ = rsColInfo.GetValue(5).ToString
                Dim UserLoginID$ = rsColInfo.GetValue(6).ToString

                UserArray.Add(UserID$)
                UserArray.Add(UserName$)
                UserArray.Add(EmailAddress$)
                UserArray.Add(UserPassword$)
                UserArray.Add(Admin$)
                UserArray.Add(isActive$)
                UserArray.Add(UserLoginID$)

                Application.DoEvents()
            Loop
        End If
        rsColInfo.Close()
        rsColInfo = Nothing
    End Sub

    Function GetXrt() As String
        Dim S = ""
        Dim iMax As Integer = GetMaxLicenseID()
        Try
            Dim tSql$ = "select License from ActiveLicense where [LicenseID] = (SELECT max([LicenseID]) FROM [ActiveLicense])"
            Dim tCnt$ = ""
            Dim rsColInfo As SqlDataReader = Nothing
            rsColInfo = SqlQry(tSql$)
            If rsColInfo.HasRows Then
                Do While rsColInfo.Read()
                    S = rsColInfo.GetValue(0).ToString
                    Application.DoEvents()
                Loop
            End If
            rsColInfo.Close()
            rsColInfo = Nothing

            Return S
        Catch ex As Exception
            Me.xTrace(23.34, "GetXrt", "clsDatabase", ex)
            Return S
        End Try
    End Function

    Function GetCurrMachineCnt() As Integer
        Try
            Dim tSql$ = "SELECT count(*) FROM [Machine]"
            Dim tCnt$ = ""
            Dim rsColInfo As SqlDataReader = Nothing
            rsColInfo = SqlQry(tSql$)
            If rsColInfo.HasRows Then
                rsColInfo.Read()
                tCnt$ = rsColInfo.GetValue(0).ToString
                Application.DoEvents()
            Else
                tCnt = 0
            End If

            rsColInfo.Close()
            rsColInfo = Nothing

            Return Val(tCnt$)
        Catch ex As Exception
            Me.xTrace(23.34, "getUserNameByEmailAddr", "clsDatabase", ex)
            Return -1
        End Try
    End Function

    'SELECT max([LicenseID]) FROM [DMA.UD].[dbo].[License]
    Function GetMaxLicenseID() As Integer
        Try
            Dim tSql$ = "SELECT max([LicenseID]) FROM [ActiveLicense]"
            Dim tCnt$ = ""
            Dim rsColInfo As SqlDataReader = Nothing
            rsColInfo = SqlQry(tSql$)
            If rsColInfo.HasRows Then
                rsColInfo.Read()
                tCnt$ = rsColInfo.GetValue(0).ToString
                Application.DoEvents()
            Else
                tCnt = 0
            End If

            rsColInfo.Close()
            rsColInfo = Nothing

            Return Val(tCnt$)
        Catch ex As Exception
            Me.xTrace(23.34, "GetMaxLicenseID", "clsDatabase", ex)
            Return -1
        End Try
    End Function

    Function LoadLicenseFile(ByVal FQN$) As String
        Dim B As Boolean = False
        Dim strContents As String
        Dim objReader As StreamReader
        Try
            objReader = New StreamReader(FQN$)
            strContents = objReader.ReadToEnd()
            objReader.Close()
            'Return strContents
        Catch Ex As Exception
            Debug.Print("Error 66.521 reading License File '" + FQN + "': " + Ex.Message)
            MsgBox("Error 66.521 reading License File '" + FQN + "': " + Ex.Message)
            Return ""
        End Try

        Dim sLic$ = "insert into ActiveLicense (License) values ('" + strContents + "')"

        B = ExecuteSqlNewConn(sLic)
        If Not B Then
            Debug.Print("Error 66.522 loading License File '" + FQN + "'")
            MsgBox("Error 66.522 loading License File '" + FQN + "'")
        End If

        Return ""
    End Function

    Function UploadLicense(ByVal CustomerID$,
                           ByVal LicenseID$,
                           ByVal MachineID$,
                           ByVal EncryptedLicense As String) As Boolean
        '[CustomerID] [nvarchar](50) NOT NULL,
        '[LicenseID] [nvarchar](18) NOT NULL,
        '[PurchasedMachines] [int] NULL,
        '[PurchasedUsers] [int] NULL,
        '[SupportActive] [bit] NULL,
        '[SupportActiveDate] [datetime] NULL,
        '[SupportInactiveDate] [nvarchar](50) NULL,
        '[LicenseText] [nvarchar](2000) NULL,
        '[LicenseTypeCode] [nvarchar](50) NOT NULL,
        '[MachineID] [nvarchar](50) NULL,
        '[Applied] [bit] NULL,
        '[EncryptedLicense] [nvarchar](4000) NULL,
        '[InstalledDate] [datetime] NULL,
        '[LastUpdate] [datetime] NULL,

        Dim licenseConnStr$ = ConfigurationManager.AppSettings("DMA_UD_License").ToString

    End Function

End Class