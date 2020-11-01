Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System
Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO
Imports System.Data.Sql
 
Public Class clsEXCHANGEHOSTPOP

    '** DIM the selected table columns

    Dim DBARCH As New clsDatabaseARCH
    Dim DMA As New clsDma

    Dim UTIL As New clsUtility
    Dim LOG As New clsLogging

    Dim DG As New clsDataGrid

    Dim HostNameIp As String = ""
    Dim UserLoginID As String = ""
    Dim LoginPw As String = ""
    Dim SSL As String = ""
    Dim PortNbr As String = ""
    Dim DeleteAfterDownload As String = ""
    Dim RetentionCode As String = ""
    Dim IMap As String = ""
    Dim Userid As String = ""
    Dim FolderName As String = ""
    Dim LibraryName As String = ""
    Dim isPublic As Boolean = False
    Dim DaysToHold As Integer = 0
    Dim strReject As String = ""
    Dim ckConvertEmlToMsg As Boolean = False

    Dim ConnStr As String = DBARCH.setConnStr()     'DBARCH.getGateWayConnStr(gGateWayID)

    '** Generate the SET methods 
    Public Sub setConvertEmlToMsg(ByRef val As Boolean)
        ckConvertEmlToMsg = val
    End Sub
    Public Sub setReject(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        strReject = val
    End Sub
    Public Sub setDaysToHold(ByRef val As Integer)
        DaysToHold = val
    End Sub
    Public Sub setLibrary(ByRef val As Boolean)
        isPublic = val
    End Sub
    Public Sub setLibrary(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        LibraryName = val
    End Sub
    Public Sub setFolderName(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        FolderName = val
    End Sub

    Public Sub setHostnameip(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Hostnameip' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        HostNameIp = val
    End Sub

    Public Sub setUserloginid(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Userloginid' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        UserLoginID = val
    End Sub

    Public Sub setLoginpw(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Loginpw' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        LoginPw = val
    End Sub

    Public Sub setSsl(ByRef val As String)
        If Len(val) = 0 Then
            val = "null"
        End If
        val = UTIL.RemoveSingleQuotes(val)
        SSL = val
    End Sub

    Public Sub setPortnbr(ByRef val As String)
        If Len(val) = 0 Then
            val = "null"
        End If
        val = UTIL.RemoveSingleQuotes(val)
        PortNbr = val
    End Sub

    Public Sub setDeleteafterdownload(ByRef val As String)
        If Len(val) = 0 Then
            val = "null"
        End If
        val = UTIL.RemoveSingleQuotes(val)
        DeleteAfterDownload = val
    End Sub

    Public Sub setRetentioncode(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        RetentionCode = val
    End Sub

    Public Sub setImap(ByRef val As String)
        If Len(val) = 0 Then
            val = "null"
        End If
        val = UTIL.RemoveSingleQuotes(val)
        IMap = val
    End Sub

    Public Sub setUserid(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        Userid = val
    End Sub



    '** Generate the GET methods 
    Public Function getFolderName() As String
        Return UTIL.RemoveSingleQuotes(FolderName)
    End Function
    Public Function getHostnameip() As String
        If Len(HostNameIp) = 0 Then
            MessageBox.Show("GET: Field 'Hostnameip' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(HostNameIp)
    End Function

    Public Function getUserloginid() As String
        If Len(UserLoginID) = 0 Then
            MessageBox.Show("GET: Field 'Userloginid' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(UserLoginID)
    End Function

    Public Function getLoginpw() As String
        If Len(LoginPw) = 0 Then
            MessageBox.Show("GET: Field 'Loginpw' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(LoginPw)
    End Function

    Public Function getSsl() As String
        If Len(SSL) = 0 Then
            SSL = "null"
        End If
        Return SSL
    End Function

    Public Function getPortnbr() As String
        If Len(PortNbr) = 0 Then
            PortNbr = "null"
        End If
        Return PortNbr
    End Function

    Public Function getDeleteafterdownload() As String
        If Len(DeleteAfterDownload) = 0 Then
            DeleteAfterDownload = "null"
        End If
        Return DeleteAfterDownload
    End Function

    Public Function getRetentioncode() As String
        Return UTIL.RemoveSingleQuotes(RetentionCode)
    End Function

    Public Function getImap() As String
        If Len(IMap) = 0 Then
            IMap = "null"
        End If
        Return IMap
    End Function

    Public Function getUserid() As String
        Return UTIL.RemoveSingleQuotes(Userid)
    End Function



    '** Generate the Required Fields Validation method 
    Public Function ValidateReqData() As Boolean
        If HostNameIp.Length = 0 Then Return False
        If UserLoginID.Length = 0 Then Return False
        If LoginPw.Length = 0 Then Return False
        Return True
    End Function


    '** Generate the Validation method 
    Public Function ValidateData() As Boolean
        If HostNameIp.Length = 0 Then Return False
        If UserLoginID.Length = 0 Then Return False
        If LoginPw.Length = 0 Then Return False
        Return True
    End Function


    '** Generate the INSERT method 
    Public Function Insert() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""
        s = s + " INSERT INTO ExchangeHostPop("
        s = s + "HostNameIp,"
        s = s + "UserLoginID,"
        s = s + "LoginPw,"
        s = s + "SSL,"
        s = s + "PortNbr,"
        s = s + "DeleteAfterDownload,"
        s = s + "RetentionCode,"
        s = s + "IMap,"
        s = s + "Userid, FolderName, LibraryName, isPublic, DaysToHold, strReject, ConvertEmlToMSG) values ("
        s = s + "'" + HostNameIp + "'" + ","
        s = s + "'" + UserLoginID + "'" + ","
        s = s + "'" + LoginPw + "'" + ","
        s = s + SSL + ","
        s = s + PortNbr + ","
        s = s + DeleteAfterDownload + ","
        s = s + "'" + RetentionCode + "'" + ","
        s = s + IMap + ","
        s = s + "'" + Userid + "'" + ","
        s = s + "'" + FolderName + "'" + ","
        s = s + "'" + LibraryName + "'" + ","
        If isPublic = True Then
            s = s + "1,"
        Else
            s = s + "0,"
        End If
        s = s + DaysToHold.ToString + ", "
        s = s + "'" + strReject + "', "
        If ckConvertEmlToMsg = True Then
            s = s + "1) "
        Else
            s = s + "0) "
        End If
        'log.WriteToArchiveLog("INFO: " + vbCrLf + s)
        Return DBARCH.ExecuteSql(s, ConnStr, False)

    End Function


    '** Generate the UPDATE method 
    Public Function Update(ByVal Host As String, ByVal UserID As String, ByVal UserLogin As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        s = s + " update ExchangeHostPop set "
        's = s + "HostNameIp = '" + getHostnameip() + "'" + ", "
        's = s + "UserLoginID = '" + getUserloginid() + "'" + ", "
        s = s + "LoginPw = '" + getLoginpw() + "'" + ", "
        s = s + "SSL = " + getSsl() + ", "
        s = s + "PortNbr = " + getPortnbr() + ", "
        s = s + "DeleteAfterDownload = " + getDeleteafterdownload() + ", "
        s = s + "RetentionCode = '" + getRetentioncode() + "'" + ", "
        s = s + "IMap = " + getImap() + ", "
        s = s + "FolderName = '" + Me.getFolderName() + "', "
        s = s + "LibraryName = '" + LibraryName + "', "
        If isPublic = True Then
            s = s + "isPublic = 1, "
        Else
            s = s + "isPublic = 0, "
        End If
        s = s + "DaysToHold = " + DaysToHold.ToString + ", "
        s = s + "strReject = '" + strReject + "', "

        If ckConvertEmlToMsg = True Then
            s = s + "ConvertEmlToMSG = 1 "
        Else
            s = s + "ConvertEmlToMSG = 0 "
        End If

        s = s + " Where "
        s = s + " HostNameIp = '" + Host + "' "
        s = s + " and   Userid = '" + UserID + "'"
        s = s + " and [UserLoginID] = '" + UserLogin + "'"

        Return DBARCH.ExecuteSql(s, ConnStr, False)
    End Function


    '** Generate the SELECT method 
    Public Function SelectRecs() As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "HostNameIp,"
        s = s + "UserLoginID,"
        s = s + "LoginPw,"
        s = s + "SSL,"
        s = s + "PortNbr,"
        s = s + "DeleteAfterDownload,"
        s = s + "RetentionCode,"
        s = s + "IMap,"
        s = s + "Userid "
        s = s + " FROM ExchangeHostPop"
        '** s=s+ "ORDERBY xxxx"
        Dim CS As String = DBARCH.setConnStr()     'DBARCH.getGateWayConnStr(gGateWayID) : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader()
        Return rsData
    End Function


    '** Generate the Select One Row method 
    Public Function SelectOne(ByVal WhereClause As String) As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "HostNameIp,"
        s = s + "UserLoginID,"
        s = s + "LoginPw,"
        s = s + "SSL,"
        s = s + "PortNbr,"
        s = s + "DeleteAfterDownload,"
        s = s + "RetentionCode,"
        s = s + "IMap,"
        s = s + "Userid "
        s = s + " FROM ExchangeHostPop"
        s = s + WhereClause
        '** s=s+ "ORDERBY xxxx"
        Dim CS As String = DBARCH.setConnStr()     'DBARCH.getGateWayConnStr(gGateWayID) : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader()
        Return rsData
    End Function


    '** Generate the DELETE method 
    Public Function Delete(ByVal WhereClause As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        If Len(WhereClause) = 0 Then Return False

        WhereClause = " " + WhereClause

        s = " Delete from ExchangeHostPop"
        s = s + WhereClause

        b = DBARCH.ExecuteSql(s, ConnStr, False)
        Return b

    End Function


    '** Generate the Zeroize Table method 
    Public Function Zeroize() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        s = s + " Delete from ExchangeHostPop"

        b = DBARCH.ExecuteSql(s, ConnStr, False)
        Return b

    End Function


    '** Generate Index Queries 
    Public Function cnt_PK_ExchangeHostPop(ByVal HostNameIp As String, ByVal Userid As String, ByVal UserLoginID As String) As Integer

        Dim B As Integer = 0
        Dim TBL As String = "ExchangeHostPop"
        Dim WC As String = "Where HostNameIp = '" + HostNameIp + "' and   Userid = '" + Userid + "' and   UserLoginID = '" + UserLoginID + "'"

        B = DBARCH.iGetRowCount(TBL, WC)

        Return B
    End Function     '** cnt_PK_ExchangeHostPop

    '** Generate Index ROW Queries 
    Public Function getRow_PK_ExchangeHostPop(ByVal HostNameIp As String, ByVal Userid As String, ByVal UserLoginID As String) As SqlDataReader

        Dim rsData As SqlDataReader = Nothing
        Dim TBL As String = "ExchangeHostPop"
        Dim WC As String = "Where HostNameIp = '" + HostNameIp + "' and   Userid = '" + Userid + "' and   UserLoginID = '" + UserLoginID + "'"

        rsData = DBARCH.GetRowByKey(TBL, WC)

        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PK_ExchangeHostPop

    ''' Build Index Where Caluses 
    '''
    Public Function wc_PK_ExchangeHostPop(ByVal HostNameIp As String, ByVal Userid As String, ByVal UserLoginID As String) As String

Dim WC AS String  = "Where HostNameIp = '" + HostNameIp + "' and   Userid = '" + Userid + "' and   UserLoginID = '" + UserLoginID + "'" 

        Return WC
    End Function     '** wc_PK_ExchangeHostPop

    '** Generate the SET methods 

End Class
