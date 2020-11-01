Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System
Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO

Public Class clsAppParms

    Dim DMA As New clsDma
    Dim LOG As New clsLogging
    Dim UTIL As New clsUtility

    Dim AppConn As New SqlConnection
    Dim ErrLogFqn As String = LOG.getTempEnvironDir + "\ECMLibrary.AppParms.Log"
    Dim DBARCH As New clsDatabaseARCH

    Dim PFA As New clsPROCESSFILEAS

    Public Sub SaveSearch(ByVal SaveName As String, ByVal SaveTypeCode As String, ByVal UID As String, ByVal ValName As String, ByVal ValValue As String)
        Try
            Dim SI As New clsSAVEDITEMS
            Dim B As Boolean = False

            SI.setSavename(SaveName)
            SI.setSavetypecode(SaveTypeCode)
            SI.setUserid(UID)
            SI.setValname(ValName)
            If ValValue.Length > 0 Then
                SI.setValvalue(ValValue)
            Else
                SI.setValvalue("null")
            End If

            Dim I As Integer = SI.cnt_PK_SavedItems(SaveName, SaveTypeCode, UID, ValName)
            If I = 0 Then
                B = SI.Insert()
                If Not B Then
                    LOG.WriteToArchiveLog("clsAppParms : SaveSearch : 00 Error failed to save a search item: " + SaveTypeCode + " : " + ValName + " : " + ValValue + ".")
                End If
            End If
            If I > 0 Then
                Dim WC As String = SI.wc_PK_SavedItems(SaveName, SaveTypeCode, UID, ValName)
                SI.Update(WC)
            End If
        Catch ex As Exception
            LOG.WriteToArchiveLog("clsAppParms : SaveSearch : 00A Error failed to save a search item: " + SaveTypeCode + " : " + ValName + " : " + ValValue + ".")
            LOG.WriteToArchiveLog("clsAppParms : SaveSearch : 00A Error failed to save a search item: " + ex.Message)
        End Try


    End Sub
    Public Function SaveSearchParm(ByVal SaveName As String, ByVal SaveTypeCode As String, ByVal UID As String, ByVal ValName As String, ByVal ValValue As String) As String
        Dim S As String = ""
        SaveName = UTIL.RemoveSingleQuotes(SaveName)
        SaveTypeCode = UTIL.RemoveSingleQuotes(SaveTypeCode)
        ValName = UTIL.RemoveSingleQuotes(ValName)
        ValValue = UTIL.RemoveSingleQuotes(ValValue)
        Try
            S = SaveName + Chr(250) + SaveTypeCode + Chr(250) + UID + Chr(250) + ValName + Chr(250) + ValValue + Chr(254)
        Catch ex As Exception
            LOG.WriteToArchiveLog("clsAppParms : SaveSearchParm : 00A Error failed to save a search item: " + SaveTypeCode + " : " + ValName + " : " + ValValue + ".")
            LOG.WriteToArchiveLog("clsAppParms : SaveSearchParm : 00A Error failed to save a search item: " + ex.Message)
        End Try

        Return S
    End Function
    Public Function getConnStr() As String

        Dim bUseConfig As Boolean = True
        Dim S As String = ""
        S = DBARCH.setConnStr()     'DBARCH.getGateWayConnStr(gGateWayID)
        UTIL.setConnectionStringTimeout(S)
        Return S

    End Function

    Public Sub CkConn()
        If AppConn Is Nothing Then
            Try
                AppConn = New SqlConnection
                AppConn.ConnectionString = getConnStr()
                AppConn.Open()
            Catch ex As Exception
                Console.WriteLine("Error 121.21")
                Console.WriteLine(ex.Source)
                Console.WriteLine(ex.StackTrace)
                Console.WriteLine(ex.Message)
                LOG.WriteToArchiveLog("clsAppParms : CkConn : 31 : " + ex.Message)
            End Try
        End If
        If AppConn.State = Data.ConnectionState.Closed Then
            Try
                AppConn.ConnectionString = getConnStr()
                AppConn.Open()
            Catch ex As Exception
                Console.WriteLine("Error 121.21")
                Console.WriteLine(ex.Source)
                Console.WriteLine(ex.StackTrace)
                Console.WriteLine(ex.Message)
                LOG.WriteToArchiveLog("clsAppParms : CkConn : 40 : " + ex.Message)
            End Try
        End If
    End Sub

    Public Function SqlQry(ByVal sql As String) As SqlDataReader
        ''Session("ActiveError") = False
        Dim ddebug As Boolean = False
        Dim queryString As String = sql
        Dim rc As Boolean = False
        Dim rsDataQry As SqlDataReader = Nothing

        If AppConn.State = Data.ConnectionState.Open Then
            AppConn.Close()
        End If

        CkConn()

        Dim command As New SqlCommand(sql, AppConn)

        Try
            rsDataQry = command.ExecuteReader()
        Catch ex As Exception
            WriteToLog("Error clsAppParms1001 Time: " + Now, ErrLogFqn)
            WriteToLog("Error clsAppParms1001 clsAppParms.SqlQry: " + Now, ErrLogFqn)
            WriteToLog("Error clsAppParms1001 Msg: " + ex.Message, ErrLogFqn)
            WriteToLog("Error clsAppParms1001 SQL: " + sql, ErrLogFqn)
            MessageBox.Show("Errors, check the log: " + ErrLogFqn)
            LOG.WriteToArchiveLog("clsAppParms : SqlQry : 57 : " + ex.Message)
        End Try

        command.Dispose()
        command = Nothing

        Return rsDataQry
    End Function

    Public Sub WriteToLog(ByVal Msg As String, ByVal LogFQN As String)

        Using sw As StreamWriter = New StreamWriter(LogFQN, True)
            ' Add some text to the file.                                    
            sw.WriteLine(Now() + ": " + Msg)
            sw.Close()
        End Using

    End Sub

    Sub SaveUserParm(ByVal ParmName As String, ByVal ParameterValue As String, ByVal AssignedUserID As String, ByVal SaveName As String, ByVal SaveTypeCode As String)

        If ParmName.Trim.Length = 0 Then
            MessageBox.Show("A Parameter must be supplied, returning.")
            Return
        End If

        Dim B As Boolean = True

        If AssignedUserID.Length = 0 Then
            MessageBox.Show("A USER must be selected, returning.")
            Return
        End If

        'Dim sSql  = "DELETE FROM [SavedItems]"
        'sSql  += " WHERE "
        'sSql  += " [Userid] = '" + AssignedUserID  + "'"
        'sSql  += " and [SaveName]  = '" + SaveName  + "'"
        'sSql  += " and [SaveTypeCode]  = '" + SaveTypeCode  + "'"
        'B = DBARCH.ExecuteSqlNewConn(sSql,false)

        ParameterValue = UTIL.RemoveSingleQuotes(ParameterValue)

        SaveSearch(SaveName, SaveTypeCode, AssignedUserID, ParmName, ParameterValue)

    End Sub

    Function SaveNewAssociations(ByVal ParentFT As String, ByVal ChildFT As String) As String
        'Dim ParentFT  = cbPocessType.Text
        'Dim ChildFT  = cbAsType.Text
        Dim MSG As String = ""
        PFA.setExtcode(ParentFT)
        PFA.setProcessextcode(ChildFT)
        PFA.setApplied("0")

        Dim S As String = ""

        Dim B As Boolean = DBARCH.ckProcessAsExists(ParentFT)
        If Not B Then
            PFA.Insert()
        Else
            MSG = "Extension already defined to system..."
            Return MSG
        End If

        S = "update [DataSource] set [SourceTypeCode] = '" + ChildFT + "' where [SourceTypeCode] = '" + ParentFT + "' and [DataSourceOwnerUserID] = '" + gCurrUserGuidID + "'"
        B = DBARCH.ExecuteSqlNewConn(S, False)

        If B Then
            MSG = ParentFT + " set to process as " + ChildFT
            S = " update ProcessFileAs set Applied = 1  where Extcode = '" + ParentFT + "' and [ProcessExtCode] = '" + ChildFT + "'"
            B = DBARCH.ExecuteSqlNewConn(S, False)
        Else
            MSG = ParentFT + " WAS NOT set to process as " + ChildFT
        End If
        Return MSG
    End Function

End Class
