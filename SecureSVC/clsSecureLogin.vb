Imports System.Data.SqlClient
Imports ECMEncryption

Public Class clsSecureLogin

    Dim ENC As New ECMEncrypt

    Function updateRepoUsers(CompanyID As String, RepoID As String) As String

        Dim RC As Integer = 0
        If CompanyID.Length = 0 Then
            Return "ERROR: Must select a company"
        End If
        If RepoID.Length = 0 Then
            Return "ERROR: Must select a RepoID"
        End If
        Console.WriteLine("XX001")
        Dim CS As String = System.Configuration.ConfigurationManager.AppSettings("ECMSecureLogin")
        Dim TS As String = XXI()
        CS = CS.Replace("@@PW@@", TS)

        Dim rowid As String = getRepoID(CompanyID, RepoID)
        Dim RetTxt As String = ""
        Dim I As Integer = 0
        Dim action As String = ""
        Dim mysql As String = ""
        Console.WriteLine("XX003")
        Dim RepoCS As String = getRepoCS(CompanyID, RepoID)
        Console.WriteLine("XX004")
        Dim tdict As Dictionary(Of String, String) = getRepoUsers(RepoCS)
        Console.WriteLine("XX005")
        Dim tlist As List(Of String) = getSecureAttachUsers(CS, rowid)
        Console.WriteLine("XX006")
        Dim dictusers As Dictionary(Of String, String) = validateRepoUsers(tlist, tdict)
        Console.WriteLine("XX007")
        Dim tpw As String = ""

        Dim CONN As New SqlConnection
        Dim command As New SqlCommand

        Try
            CONN.ConnectionString = CS
            CONN.Open()
            command.Connection = CONN

            For Each uid As String In dictusers.Keys
                action = dictusers(uid)
                If action.Equals("D") Then
                    mysql = "delete from [User] where UserID = '" + uid + "' and CurrRepoID = " + rowid
                    command.CommandText = mysql
                    I = command.ExecuteNonQuery()
                End If
                If action.Equals("I") Then
                    Dim sGUID As String
                    sGUID = System.Guid.NewGuid.ToString()
                    tpw = dictusers(uid)
                    mysql = "insert into [User] (UserID, UserPW, CurrRepoId) Values ('" + uid + "','" + sGUID + "'," + rowid + ")"
                    'mysql = "insert into [User] (UserID, UserPW) Values ('" + uid + "','" + sGUID + "')"
                    command.CommandText = mysql
                    I = command.ExecuteNonQuery()
                End If
                Console.WriteLine("XX008", mysql)
            Next
            RetTxt = "Users validated for " + CompanyID + " / " + RepoID
            Console.WriteLine("XX009", RetTxt)
        Catch ex As Exception
            RetTxt = "ERROR: " + ex.Message
        Finally
            If CONN.State = ConnectionState.Open Then
                CONN.Close()
            End If
            CONN.Dispose()
            command.Dispose()
        End Try

        GC.Collect()
        GC.WaitForPendingFinalizers()

        Return RetTxt

    End Function

    Function validateRepoUsers(SecureUsers As List(Of String), RepoUsers As Dictionary(Of String, String))

        Dim ValidUsers As Dictionary(Of String, String) = New Dictionary(Of String, String)
        Dim suser As String = ""
        Dim ruser As String = ""

        For Each ruser In RepoUsers.Keys
            If SecureUsers.Contains(ruser) Then
                ValidUsers.Add(ruser, "K")
            Else
                ValidUsers.Add(ruser, "I")
            End If
        Next
        For Each suser In SecureUsers
            If Not RepoUsers.ContainsKey(suser) Then
                If ValidUsers.ContainsKey(suser) Then
                    ValidUsers(suser) = "D"
                Else
                    ValidUsers.Add(suser, "D")
                End If
            End If
        Next

        Return ValidUsers

    End Function

    Function getRepoUsers(CS As String) As Dictionary(Of String, String)

        Dim S As String = ""
        S += " SELECT UserID, UserPassword " + vbCrLf
        S += " FROM [Users] " + vbCrLf

        Dim usr As String = ""
        Dim usrpw As String = ""
        Dim tdict As Dictionary(Of String, String) = New Dictionary(Of String, String)

        Dim RSData As SqlDataReader = Nothing
        Dim CONN As New SqlConnection
        Dim command As New SqlCommand

        Try
            CONN.ConnectionString = CS
            CONN.Open()
            command.Connection = CONN
            command.CommandText = S
            RSData = command.ExecuteReader()

            If RSData.HasRows Then
                Do While RSData.Read()
                    usr = RSData.GetValue(0).ToString
                    usrpw = RSData.GetValue(1).ToString
                    tdict.Add(usr, usrpw)
                Loop
            End If
        Catch ex As Exception
            CS = "ERROR: " + ex.Message
        Finally
            If RSData.IsClosed Then
            Else
                RSData.Close()
            End If
            RSData = Nothing
            If CONN.State = ConnectionState.Open Then
                CONN.Close()
            End If
            CONN.Dispose()
            command.Dispose()

        End Try

        Return tdict

    End Function

    Function getCompanyID(CS As String) As String

        'Select CompanyID from [dbo].[SecureAttach] order by CompanyID
        'Select SvrName from [dbo].[SecureAttach] where CompanyID = 'PA'  order by SvrName
        'Select DBName from [dbo].[SecureAttach] where CompanyID = 'PA'   and SvrName = 'NA' order by SvrName
        'Select InstanceName from [dbo].[SecureAttach] where CompanyID = 'PA'   and SvrName = 'NA' and DBName = 'NA' order by SvrName


        Dim S As String = ""
        S += " Select distinct CompanyID from [dbo].[SecureAttach] order by CompanyID " + vbCrLf

        Dim EntityName As String = ""
        Dim ListOfItems As List(Of String) = New List(Of String)

        Dim RSData As SqlDataReader = Nothing
        Dim CONN As New SqlConnection
        Dim command As New SqlCommand

        Try
            CONN.ConnectionString = CS
            CONN.Open()
            command.Connection = CONN
            command.CommandText = S
            RSData = command.ExecuteReader()

            If RSData.HasRows Then
                Do While RSData.Read()
                    EntityName = RSData.GetValue(0).ToString
                    ListOfItems.Add(EntityName)
                Loop
            End If
        Catch ex As Exception
            CS = "ERROR: " + ex.Message
        Finally
            If RSData.IsClosed Then
            Else
                RSData.Close()
            End If
            RSData = Nothing
            If CONN.State = ConnectionState.Open Then
                CONN.Close()
            End If
            CONN.Dispose()
            command.Dispose()

        End Try

        Dim value As String = String.Join("|", ListOfItems)
        Return value

    End Function

    Function getServers(CS As String, CompanyID As String) As String

        'Select CompanyID from [dbo].[SecureAttach] order by CompanyID
        'Select SvrName from [dbo].[SecureAttach] where CompanyID = 'PA'  order by SvrName
        'Select DBName from [dbo].[SecureAttach] where CompanyID = 'PA'   and SvrName = 'NA' order by SvrName
        'Select InstanceName from [dbo].[SecureAttach] where CompanyID = 'PA'   and SvrName = 'NA' and DBName = 'NA' order by SvrName


        Dim S As String = ""
        S += " Select distinct SvrName from [dbo].[SecureAttach] where CompanyID = '" + CompanyID + "'  order by SvrName " + vbCrLf

        Dim EntityName As String = ""
        Dim ListOfItems As List(Of String) = New List(Of String)

        Dim RSData As SqlDataReader = Nothing
        Dim CONN As New SqlConnection
        Dim command As New SqlCommand

        Try
            CONN.ConnectionString = CS
            CONN.Open()
            command.Connection = CONN
            command.CommandText = S
            RSData = command.ExecuteReader()

            If RSData.HasRows Then
                Do While RSData.Read()
                    EntityName = RSData.GetValue(0).ToString
                    ListOfItems.Add(EntityName)
                Loop
            End If
        Catch ex As Exception
            CS = "ERROR: " + ex.Message
        Finally
            If RSData.IsClosed Then
            Else
                RSData.Close()
            End If
            RSData = Nothing
            If CONN.State = ConnectionState.Open Then
                CONN.Close()
            End If
            CONN.Dispose()
            command.Dispose()

        End Try

        Dim value As String = String.Join("|", ListOfItems)
        Return value


    End Function

    Function getUserCompanies(UserID As String, PW As String) As String

        Dim CS As String = System.Configuration.ConfigurationManager.AppSettings("ECMSecureLogin")
        Dim val As String = ""
        Dim TS As String = XXI()
        CS = CS.Replace("@@PW@@", TS)

        val = ENC.AES256DecryptString(UserID)
        UserID = val

        'val = ENC.AES256DecryptString(PW)
        'PW = val

        Dim S As String = ""
        S += " SELECT CompanyID
                ,[SvrName]
                ,[DBName]
                ,[InstanceName]
                ,[,UR.RepoID[
                FROM [UserRepo] UR
                join [User] U
                on UR.UserID = U.UserID
                and U.Userid = '" + UserID + "'
                and U.Userpw = '" + PW + "'"

        Dim VALUE As String = ""
        Dim EntityName As String = ""
        Dim ListOfItems As List(Of String) = New List(Of String)

        Dim RSData As SqlDataReader = Nothing
        Dim CONN As New SqlConnection
        Dim command As New SqlCommand

        Try
            CONN.ConnectionString = CS
            CONN.Open()
            command.Connection = CONN
            command.CommandText = S
            RSData = command.ExecuteReader()

            If RSData.HasRows Then
                Do While RSData.Read()
                    VALUE += RSData.GetValue(0).ToString + ";"
                    VALUE += RSData.GetValue(1).ToString + ";"
                    VALUE += RSData.GetValue(2).ToString + ";"
                    VALUE += RSData.GetValue(3).ToString + ";"
                    VALUE += RSData.GetValue(4).ToString + ";|"
                Loop
            End If
        Catch ex As Exception
            CS = "Error: " + ex.Message
        Finally
            If RSData.IsClosed Then
            Else
                RSData.Close()
            End If
            RSData = Nothing
            If CONN.State = ConnectionState.Open Then
                CONN.Close()
            End If
            CONN.Dispose()
            command.Dispose()

        End Try

        VALUE = ENC.AES256EncryptString(VALUE)
        Return VALUE


    End Function


    Function getDatabases(CS As String, CompanyID As String, SvrName As String) As String

        'Select CompanyID from [dbo].[SecureAttach] order by CompanyID
        'Select SvrName from [dbo].[SecureAttach] where CompanyID = 'PA'  order by SvrName
        'Select DBName from [dbo].[SecureAttach] where CompanyID = 'PA'   and SvrName = 'NA' order by SvrName
        'Select InstanceName from [dbo].[SecureAttach] where CompanyID = 'PA'   and SvrName = 'NA' and DBName = 'NA' order by SvrName


        Dim S As String = ""
        S += " Select distinct DBName from [dbo].[SecureAttach] where CompanyID = '" + CompanyID + "' and SvrName = '" + SvrName + "' order by DBName "

        Dim EntityName As String = ""
        Dim ListOfItems As List(Of String) = New List(Of String)

        Dim RSData As SqlDataReader = Nothing
        Dim CONN As New SqlConnection
        Dim command As New SqlCommand

        Try
            CONN.ConnectionString = CS
            CONN.Open()
            command.Connection = CONN
            command.CommandText = S
            RSData = command.ExecuteReader()

            If RSData.HasRows Then
                Do While RSData.Read()
                    EntityName = RSData.GetValue(0).ToString
                    ListOfItems.Add(EntityName)
                Loop
            End If
        Catch ex As Exception
            CS = "Error: " + ex.Message
        Finally
            If RSData.IsClosed Then
            Else
                RSData.Close()
            End If
            RSData = Nothing
            If CONN.State = ConnectionState.Open Then
                CONN.Close()
            End If
            CONN.Dispose()
            command.Dispose()

        End Try

        Dim value As String = String.Join("|", ListOfItems)
        Return value


    End Function

    Function getInstance(CS As String, CompanyID As String, SvrName As String, DBName As String) As String

        Dim S As String = ""
        S += " Select distinct InstanceName from [dbo].[SecureAttach] where CompanyID = '" + CompanyID + "'   and SvrName = '" + SvrName + "' and DBName = '" + DBName + "' order by InstanceName "

        Dim EntityName As String = ""
        Dim ListOfItems As List(Of String) = New List(Of String)

        Dim RSData As SqlDataReader = Nothing
        Dim CONN As New SqlConnection
        Dim command As New SqlCommand

        Try
            CONN.ConnectionString = CS
            CONN.Open()
            command.Connection = CONN
            command.CommandText = S
            RSData = command.ExecuteReader()

            If RSData.HasRows Then
                Do While RSData.Read()
                    EntityName = RSData.GetValue(0).ToString
                    ListOfItems.Add(EntityName)
                Loop
            End If
        Catch ex As Exception
            CS = "Error: " + ex.Message
        Finally
            If RSData.IsClosed Then
            Else
                RSData.Close()
            End If
            RSData = Nothing
            If CONN.State = ConnectionState.Open Then
                CONN.Close()
            End If
            CONN.Dispose()
            command.Dispose()

        End Try

        Dim value As String = String.Join("|", ListOfItems)
        Return value


    End Function

    Function getAttachData(CS As String, CompanyID As String, SvrName As String, DBName As String, InstanceName As String) As String

        'Dim CompanyID As String = ""
        Dim EncPW As String = ""
        Dim RepoID As String = ""
        'Dim CS As String = ""
        Dim Disabled As String = ""
        Dim RowID As String = ""
        Dim isThesaurus As String = ""
        Dim CSRepo As String = ""
        Dim CSThesaurus As String = ""
        Dim CSHive As String = ""
        Dim CSDMALicense As String = ""
        Dim CSGateWay As String = ""
        Dim CSTDR As String = ""
        Dim CSKBase As String = ""
        Dim CreateDate As String = ""
        Dim LastModDate As String = ""
        Dim SVCFS_Endpoint As String = ""
        Dim SVCGateway_Endpoint As String = ""
        Dim SVCCLCArchive_Endpoint As String = ""
        Dim SVCSearch_Endpoint As String = ""
        Dim SVCDownload_Endpoint As String = ""
        Dim SVCFS_CS As String = ""
        Dim SVCGateway_CS As String = ""
        Dim SVCSearch_CS As String = ""
        Dim SVCDownload_CS As String = ""
        Dim SVCThesaurus_CS As String = ""
        'Dim SvrName As String = ""
        'Dim DBName As String = ""
        'Dim InstanceName As String = ""
        Dim LoginID As String = ""
        Dim LoginPW As String = ""
        Dim ckWinAuth As String = ""
        Dim ConnTimeout As String = ""

        Dim tDict As Dictionary(Of String, String) = New Dictionary(Of String, String)()
        Dim S As String = ""
        S += " SELECT top 1 
                    isnull([CompanyID],'') as CompanyID
                    ,isnull([EncPW],'') as EncPW
                    ,isnull([RepoID],'') as RepoID
                    ,isnull([CS],'') as CS
                    ,isnull([Disabled],'') as Disabled
                    ,isnull([RowID],'') as RowID
                    ,isnull([isThesaurus],'') as isThesaurus
                    ,isnull([CSRepo],'') as CSRepo
                    ,isnull([CSThesaurus],'') as CSThesaurus
                    ,isnull([CSHive],'') as CSHive
                    ,isnull([CSDMALicense],'') as CSDMALicense
                    ,isnull([CSGateWay],'') as CSGateWay
                    ,isnull([CSTDR],'') as CSTDR
                    ,isnull([CSKBase],'') as CSKBase
                    ,isnull([CreateDate],'') as CreateDate
                    ,isnull([LastModDate],'') as LastModDate
                    ,isnull([SVCFS_Endpoint],'') as SVCFS_Endpoint
                    ,isnull([SVCGateway_Endpoint],'') as SVCGateway_Endpoint
                    ,isnull([SVCCLCArchive_Endpoint],'') as SVCCLCArchive_Endpoint
                    ,isnull([SVCSearch_Endpoint],'') as SVCSearch_Endpoint
                    ,isnull([SVCDownload_Endpoint],'') as SVCDownload_Endpoint
                    ,isnull([SVCFS_CS],'') as SVCFS_CS
                    ,isnull([SVCGateway_CS],'') as SVCGateway_CS
                    ,isnull([SVCSearch_CS],'') as SVCSearch_CS
                    ,isnull([SVCDownload_CS],'') as SVCDownload_CS
                    ,isnull([SVCThesaurus_CS],'') as SVCThesaurus_CS
                    ,isnull([SvrName],'') as SvrName
                    ,isnull([DBName],'') as DBName
                    ,isnull([InstanceName],'') as InstanceName
                    ,isnull([LoginID],'') as LoginID
                    ,isnull([LoginPW],'') as LoginPW
                    ,isnull([ConnTimeout],'0') as ConnTimeout 
                    ,isnull([ckWinAuth],'0') as ckWinAuth
              FROM [dbo].[SecureAttach]
            where CompanyID = '" + CompanyID + "' 
            and SvrName = '" + SvrName + "'
            and DBName = '" + DBName + "'
            And InstanceName = '" + InstanceName + "'"

        Dim SS As String = S
        Dim RSData As SqlDataReader = Nothing
        Dim CONN As New SqlConnection
        Dim command As New SqlCommand

        Try
            CONN.ConnectionString = CS
            CONN.Open()
            command.Connection = CONN
            command.CommandText = S
            RSData = command.ExecuteReader()

            If RSData.HasRows Then
                Do While RSData.Read()
                    CompanyID = RSData.GetValue(0).ToString
                    EncPW = RSData.GetValue(1).ToString
                    RepoID = RSData.GetValue(2).ToString
                    CS = RSData.GetValue(3).ToString
                    Disabled = RSData.GetValue(4).ToString
                    RowID = RSData.GetValue(5).ToString
                    isThesaurus = RSData.GetValue(6).ToString
                    CSRepo = RSData.GetValue(7).ToString
                    CSThesaurus = RSData.GetValue(8).ToString
                    CSHive = RSData.GetValue(9).ToString
                    CSDMALicense = RSData.GetValue(10).ToString
                    CSGateWay = RSData.GetValue(11).ToString
                    CSTDR = RSData.GetValue(12).ToString
                    CSKBase = RSData.GetValue(13).ToString
                    CreateDate = RSData.GetValue(14).ToString
                    LastModDate = RSData.GetValue(15).ToString
                    SVCFS_Endpoint = RSData.GetValue(16).ToString
                    SVCGateway_Endpoint = RSData.GetValue(17).ToString
                    SVCCLCArchive_Endpoint = RSData.GetValue(18).ToString
                    SVCSearch_Endpoint = RSData.GetValue(19).ToString
                    SVCDownload_Endpoint = RSData.GetValue(20).ToString
                    SVCFS_CS = RSData.GetValue(21).ToString
                    SVCGateway_CS = RSData.GetValue(22).ToString
                    SVCSearch_CS = RSData.GetValue(23).ToString
                    SVCDownload_CS = RSData.GetValue(24).ToString
                    SVCThesaurus_CS = RSData.GetValue(25).ToString
                    SvrName = RSData.GetValue(26).ToString
                    DBName = RSData.GetValue(27).ToString
                    InstanceName = RSData.GetValue(28).ToString
                    LoginID = RSData.GetValue(29).ToString
                    LoginPW = RSData.GetValue(30).ToString
                    ConnTimeout = RSData.GetValue(31).ToString
                    ckWinAuth = RSData.GetValue(32).ToString

                    tDict.Add("CompanyID", CompanyID)
                    tDict.Add("EncPW", EncPW)
                    tDict.Add("RepoID", RepoID)
                    tDict.Add("CS", CS)
                    tDict.Add("Disabled", Disabled)
                    tDict.Add("RowID", RowID)
                    tDict.Add("isThesaurus", isThesaurus)
                    tDict.Add("CSRepo", CSRepo)
                    tDict.Add("CSThesaurus", CSThesaurus)
                    tDict.Add("CSHive", CSHive)
                    tDict.Add("CSDMALicense", CSDMALicense)
                    tDict.Add("CSGateWay", CSGateWay)
                    tDict.Add("CSTDR", CSTDR)
                    tDict.Add("CSKBase", CSKBase)
                    tDict.Add("CreateDate", CreateDate)
                    tDict.Add("LastModDate", LastModDate)
                    tDict.Add("SVCFS_Endpoint", SVCFS_Endpoint)
                    tDict.Add("SVCGateway_Endpoint", SVCGateway_Endpoint)
                    tDict.Add("SVCCLCArchive_Endpoint", SVCCLCArchive_Endpoint)
                    tDict.Add("SVCSearch_Endpoint", SVCSearch_Endpoint)
                    tDict.Add("SVCDownload_Endpoint", SVCDownload_Endpoint)
                    tDict.Add("SVCFS_CS", SVCFS_CS)
                    tDict.Add("SVCGateway_CS", SVCGateway_CS)
                    tDict.Add("SVCSearch_CS", SVCSearch_CS)
                    tDict.Add("SVCDownload_CS", SVCDownload_CS)
                    tDict.Add("SVCThesaurus_CS", SVCThesaurus_CS)
                    tDict.Add("SvrName", SvrName)
                    tDict.Add("DBName", DBName)
                    tDict.Add("InstanceName", InstanceName)
                    tDict.Add("LoginID", LoginID)
                    tDict.Add("LoginPW", LoginPW)
                    tDict.Add("ConnTimeout", ConnTimeout)
                    tDict.Add("ckWinAuth", ckWinAuth)
                Loop
            End If
        Catch ex As Exception
            CS = "Error: " + ex.Message
        Finally
            If RSData.IsClosed Then
            Else
                RSData.Close()
            End If
            RSData = Nothing
            If CONN.State = ConnectionState.Open Then
                CONN.Close()
            End If
            CONN.Dispose()
            command.Dispose()

        End Try

        Dim value As String = String.Join("|", tDict)
        Return value
    End Function


    Function getSecureAttachUsers(CS As String, CurrRepoID As String) As List(Of String)

        Dim S As String = ""
        S += " SELECT UserID " + vbCrLf
        S += " FROM [User] " + vbCrLf
        S += " where CurrRepoID = " + CurrRepoID + vbCrLf

        Dim usr As String = ""
        Dim usrpw As String = ""
        Dim tlist As List(Of String) = New List(Of String)

        Dim RSData As SqlDataReader = Nothing
        Dim CONN As New SqlConnection
        Dim command As New SqlCommand

        Try
            CONN.ConnectionString = CS
            CONN.Open()
            command.Connection = CONN
            command.CommandText = S
            RSData = command.ExecuteReader()

            If RSData.HasRows Then
                Do While RSData.Read()
                    usr = RSData.GetValue(0).ToString
                    tlist.Add(usr)
                Loop
            End If
        Catch ex As Exception
            CS = "ERROR: " + ex.Message
        Finally
            If RSData.IsClosed Then
            Else
                RSData.Close()
            End If
            RSData = Nothing
            If CONN.State = ConnectionState.Open Then
                CONN.Close()
            End If
            CONN.Dispose()
            command.Dispose()

        End Try

        Return tlist

    End Function

    Function getRepoID(CompanyID As String, RepoID As String) As String
        Dim RC As Boolean = True
        Dim RetMsg As String = ""
        Dim RowID As String = ""
        Dim S As String = ""
        S += " SELECT RowID " + vbCrLf
        S += " FROM SecureAttach " + vbCrLf
        S += " where CompanyID = '" + CompanyID + "' and RepoID = '" + RepoID + "' " + vbCrLf

        Dim ConnStr As String = System.Configuration.ConfigurationManager.AppSettings("ECMSecureLogin")
        Dim TS As String = XXI()
        ConnStr = ConnStr.Replace("@@PW@@", TS)

        Dim RSData As SqlDataReader = Nothing
        Dim CONN As New SqlConnection()
        Dim command As New SqlCommand

        Try
            CONN.ConnectionString = ConnStr
            CONN.Open()
            command.Connection = CONN
            command.CommandText = S
            RSData = command.ExecuteReader()

            If RSData.HasRows Then
                Do While RSData.Read()
                    RowID = RSData.GetValue(0).ToString
                Loop
            End If
        Catch ex As Exception
            RowID = "-99"
        Finally
            If RSData.IsClosed Then
            Else
                RSData.Close()
            End If
            RSData = Nothing
            If CONN.State = ConnectionState.Open Then
                CONN.Close()
            End If
            CONN.Dispose()
            command.Dispose()

        End Try

        Return RowID

    End Function

    Function getRepoCS(CompanyID As String, RepoID As String) As String
        Dim RC As Boolean = True
        Dim RetMsg As String = ""
        Dim cs As String = ""
        Dim S As String = ""
        S += " SELECT CSRepo " + vbCrLf
        S += " FROM SecureAttach " + vbCrLf
        S += " where CompanyID = '" + CompanyID + "' and RepoID = '" + RepoID + "' " + vbCrLf

        Dim ConnStr As String = System.Configuration.ConfigurationManager.AppSettings("ECMSecureLogin")
        Dim TS As String = XXI()
        ConnStr = ConnStr.Replace("@@PW@@", TS)

        Dim RSData As SqlDataReader = Nothing
        Dim CONN As New SqlConnection()
        Dim command As New SqlCommand

        Try
            CONN.ConnectionString = ConnStr
            CONN.Open()
            command.Connection = CONN
            command.CommandText = S
            RSData = command.ExecuteReader()

            If RSData.HasRows Then
                Do While RSData.Read()
                    cs = RSData.GetValue(0).ToString
                Loop
            End If

            'Dim ENC As New clsEncrypt
            cs = ENC.AES256EncryptString(cs)
            'ENC = Nothing
        Catch ex As Exception
            cs = "ERROR: " + ex.Message
        Finally
            If RSData.IsClosed Then
            Else
                RSData.Close()
            End If
            RSData = Nothing
            If CONN.State = ConnectionState.Open Then
                CONN.Close()
            End If
            CONN.Dispose()
            command.Dispose()

        End Try

        Return cs

    End Function

    Sub logit(msg As String)
        Dim path As String = "c:\temp\DEBUG_LOG.txt"

        ' This text is added only once to the file.
        If Not System.IO.File.Exists(path) Then
            ' Create a file to write to.
            Using sw As System.IO.StreamWriter = System.IO.File.CreateText(path)
                sw.WriteLine(msg)
            End Using
        End If

        ' This text is always added, making the file longer over time if it is not deleted.
        Using sw As System.IO.StreamWriter = System.IO.File.AppendText(path)
            sw.WriteLine(msg)
        End Using

    End Sub

    Function AttachToSecureLoginDB(ByVal ConnStr As String, ByRef RC As Boolean, ByRef RtnMsg As String) As Boolean

        'Data Source=HP8GB\ECMLIBRARY;Initial Catalog=ECM.SecureLogin;Persist Security Info=True;User ID=ecmlibrary;Password=Jxxxxxxx
        'Data Source=hp8gb\ECMlibrary;Initial Catalog=ECM.SecureAttach;Persist Security Info=True;User ID=ecmlibrary;Password=Jxxxxxxx; Connect Timeout = 15

        logit("001 Into AttachToSecureLoginDB")

        Dim B As Boolean = True
        RC = True
        Dim CN As New SqlConnection

        logit("002 Into AttachToSecureLoginDB")

        Try
            CN.ConnectionString = ConnStr
            CN.Open()
            RtnMsg = "Connected to SecureServer"
            logit(RtnMsg)
        Catch ex As Exception
            RtnMsg = "CONNECTION ERROR: " + ex.Message
            logit(RtnMsg)
            B = False
            RC = False
            If CN.State = ConnectionState.Open Then
                CN.Close()
            End If
            CN.Dispose()
        End Try
        GC.Collect()
        logit("003 Exiting AttachToSecureLoginDB")
        Return B
    End Function

    Function XXI() As String
        Dim RC As Boolean = True
        Dim RetMsg As String = ""
        '2RLaSKcN9L42IPlWDjXnvw==
        Dim XI As String = System.Configuration.ConfigurationManager.AppSettings("EncPW")
        'Dim ENC As New clsEncrypt
        XI = ENC.AES256DecryptString(XI)
        GC.Collect()
        Return XI
    End Function

    Function ValidateGatewayLogin(ByVal CompanyID As String, ByVal RepoID As String, ByVal EncPW As String, ByRef RC As Boolean, ByRef RtnMsg As String) As Boolean

        Dim B As Boolean = False
        Dim MySql As String = "select COUNT(*) from SecureAttach where CompanyID = '" + CompanyID + "' and RepoID = '" + RepoID + "' and EncPW = '" + EncPW + "'"
        Dim Connstr As String = ""
        Connstr = System.Configuration.ConfigurationManager.AppSettings("ECMSecureLogin")
        Dim TS As String = XXI()
        Connstr = Connstr.Replace("@@PW@@", TS)

        Dim RSData As SqlDataReader = Nothing
        Dim CONN As New SqlConnection(Connstr)
        CONN.Open()
        Dim command As New SqlCommand(MySql, CONN)

        command.Parameters.AddWithValue("@CompanyID", CompanyID)
        command.Parameters.AddWithValue("@RepoID", RepoID)

        RSData = command.ExecuteReader()
        Dim iCnt As Integer = 0
        Try
            If RSData.HasRows Then
                RSData.Read()
                iCnt = RSData.GetInt32(0)
                If iCnt > 0 Then
                    B = True
                Else
                    B = False
                End If
            Else
                B = False
                iCnt = 0
            End If
        Catch ex As Exception
            B = False
            RC = False
            RtnMsg = ex.Message.ToString
        Finally
            If RSData.IsClosed Then
            Else
                RSData.Close()
            End If
            RSData = Nothing
            If CONN.State = ConnectionState.Open Then
                CONN.Close()
            End If
            CONN.Dispose()
            command.Dispose()
        End Try

        GC.Collect()
        GC.WaitForPendingFinalizers()

        Return B

    End Function

    Function ValidateUserLogin(ByVal UID As String, ByVal EncPW As String) As Boolean

        Dim RC As Boolean = False
        Dim RetMsg As String = ""

        'Dim ENC As New clsEncrypt
        EncPW = ENC.AES256EncryptString(EncPW)
        'ENC = Nothing

        Dim B As Boolean = False
        Dim MySql As String = "select COUNT(*) from User where Userid  = '" + UID + "' and UserPW = '" + EncPW + "' "
        Dim Connstr As String = ""

        Connstr = System.Configuration.ConfigurationManager.AppSettings("ECMSecureLogin")
        Dim TS As String = XXI()
        Connstr = Connstr.Replace("@@PW@@", TS)

        Dim iCnt As Integer = 0
        Dim RSData As SqlDataReader = Nothing
        Dim CONN As New SqlConnection(Connstr)
        CONN.Open()
        Dim command As New SqlCommand(MySql, CONN)

        RSData = command.ExecuteReader()

        Try
            If RSData.HasRows Then
                RSData.Read()
                iCnt = RSData.GetInt32(0)
                If iCnt > 0 Then
                    B = True
                Else
                    B = False
                End If
            Else
                B = False
                iCnt = 0
            End If
        Catch ex As Exception
            B = False
            RC = False
        Finally
            If RSData.IsClosed Then
            Else
                RSData.Close()
            End If
            RSData = Nothing
            If CONN.State = ConnectionState.Open Then
                CONN.Close()
            End If
            CONN.Dispose()
            command.Dispose()
        End Try

        GC.Collect()
        GC.WaitForPendingFinalizers()

        Return B

    End Function

    Function SaveConnection(ByVal ConnStr As String,
                               tDict As Dictionary(Of String, String),
                               ByRef RC As Boolean, ByRef RtnMsg As String) As Boolean

        Dim ENCX As ECMEncrypt = New ECMEncrypt()
        Dim RetMsg As String = ""

        Dim CompanyID As String = ""
        Dim SvrName As String = ""
        Dim DBName As String = ""
        Dim InstanceName As String = ""
        Dim RepoID As String = ""
        Dim GateWayServerCS As String = ""

        GateWayServerCS = tDict("GateWayServerCS")
        GateWayServerCS = ENCX.DecryptTripleDES(GateWayServerCS)

        RepoID = tDict("RepoID")
        RepoID = ENCX.DecryptTripleDES(RepoID)

        CompanyID = tDict("CompanyID")
        CompanyID = ENCX.DecryptTripleDES(CompanyID)

        SvrName = tDict("SvrName")
        SvrName = ENCX.DecryptTripleDES(SvrName)

        DBName = tDict("DBName")
        DBName = ENCX.DecryptTripleDES(DBName)

        InstanceName = tDict("InstanceName")
        InstanceName = ENCX.DecryptTripleDES(InstanceName)

        Dim B As Boolean = True
        Dim MySql As String = "Select count(*) from SecureAttach " + vbCrLf
        'MySql += "where CompanyID = '" + CompanyID + "' and SvrName = '" + SvrName + "' and DBName = '" + DBName + "' and RepoID = '" + RepoID + "' "
        MySql += "where CompanyID = '" + CompanyID + "' and SvrName = '" + SvrName + "' and DBName = '" + DBName + "' "
        If InstanceName.Length > 0 Then
            MySql += " AND InstanceName = InstanceName"
        Else
            MySql += " AND (InstanceName = '' OR InstanceName is null or InstanceName = 'NA')"
        End If
        Dim RSData As SqlDataReader = Nothing

        Dim CONN As New SqlConnection(GateWayServerCS)
        CONN.Open()
        Dim command As New SqlCommand(MySql, CONN)

        RSData = command.ExecuteReader()
        Dim iCnt As Integer = 0
        Try
            If RSData.HasRows Then
                RSData.Read()
                iCnt = RSData.GetInt32(0)
            Else
                iCnt = 0
            End If
        Catch ex As Exception
            B = False
            RC = False
            RtnMsg = ex.Message
        Finally
            If RSData.IsClosed Then
            Else
                RSData.Close()
            End If
            RSData = Nothing
            If CONN.State = ConnectionState.Open Then
                CONN.Close()
            End If
            CONN.Dispose()
            command.Dispose()
        End Try

        GC.Collect()
        GC.WaitForPendingFinalizers()

        If B Then
            If iCnt = 0 Then
                B = AddNewConnection(GateWayServerCS, tDict, RC, RtnMsg)
                If B = True Then
                    B = UpdateExistingConnection(GateWayServerCS, tDict, RC, RtnMsg)
                End If
            Else
                B = UpdateExistingConnection(GateWayServerCS, tDict, RC, RtnMsg)
            End If
        End If
        ENCX = Nothing
        Return B
    End Function

    Function AddNewConnection(ByVal ConnStr As String,
                               tDict As Dictionary(Of String, String),
                               ByRef RC As Boolean, ByRef RtnMsg As String) As Boolean

        Dim ENC2 As New ECMEncrypt

        Dim CreateDate As String = DateTime.Now.ToString
        Dim LastModDate As String = DateTime.Now.ToString
        Dim RepoID As String = ""
        Dim CompanyID As String = ""
        Dim SvrName As String = ""
        Dim DBName As String = ""
        Dim InstanceName As String = ""

        RepoID = tDict("RepoID")
        RepoID = ENC2.DecryptTripleDES(RepoID)

        CompanyID = tDict("CompanyID")
        CompanyID = ENC2.DecryptTripleDES(CompanyID)

        SvrName = tDict("SvrName")
        SvrName = ENC2.DecryptTripleDES(SvrName)

        DBName = tDict("DBName")
        DBName = ENC2.DecryptTripleDES(DBName)

        InstanceName = tDict("InstanceName")
        InstanceName = ENC2.DecryptTripleDES(InstanceName)

        If InstanceName.Length = 0 Then
            InstanceName = "0"
        End If

        Dim CS As String = tDict("CS")
        Dim Disabled As String = tDict("Disabled")
        Disabled = ENC2.EncryptTripleDES(Disabled)
        If Disabled.Equals("True") Then
            Disabled = "1"
        Else
            Disabled = "0"
        End If

        Dim RowID As String = tDict("RowID")
        Dim isThesaurus As String = tDict("isThesaurus")
        isThesaurus = ENC2.EncryptTripleDES(isThesaurus)
        If isThesaurus.Equals("True") Then
            isThesaurus = "1"
        Else
            isThesaurus = "0"
        End If

        Dim EncPW As String = tDict("EncPW")
        Dim CSRepo As String = tDict("CSRepo")
        Dim CSThesaurus As String = tDict("CSThesaurus")
        Dim CSHive As String = tDict("CSHive")
        Dim CSDMALicense As String = tDict("CSDMALicense")
        Dim CSGateWay As String = tDict("CSGateWay")
        Dim CSTDR As String = tDict("CSTDR")
        Dim CSKBase As String = tDict("CSKBase")
        'Dim CreateDate As String = tDict("CreateDate")
        'Dim LastModDate As String = tDict("LastModDate")
        Dim SVCFS_Endpoint As String = tDict("SVCFS_Endpoint")
        Dim SVCGateway_Endpoint As String = tDict("SVCGateway_Endpoint")
        Dim SVCCLCArchive_Endpoint As String = tDict("SVCCLCArchive_Endpoint")
        Dim SVCSearch_Endpoint As String = tDict("SVCSearch_Endpoint")
        Dim SVCDownload_Endpoint As String = tDict("SVCDownload_Endpoint")
        Dim SVCFS_CS As String = tDict("SVCFS_CS")
        Dim SVCGateway_CS As String = tDict("SVCGateway_CS")
        Dim SVCSearch_CS As String = tDict("SVCSearch_CS")
        Dim SVCDownload_CS As String = tDict("SVCDownload_CS")
        Dim SVCThesaurus_CS As String = tDict("SVCThesaurus_CS")
        'Dim SvrName As String = tDict("SvrName")
        'Dim DBName As String = tDict("DBName")
        'Dim InstanceName As String = tDict("InstanceName")
        Dim LoginID As String = tDict("LoginID")
        Dim LoginPW As String = tDict("LoginPW")
        Dim ConnTimeout As String = tDict("ConnTimeout")

        Dim ckWinAuth As String = tDict("ckWinAuth")
        If ckWinAuth.Equals("True") Then
            ckWinAuth = "1"
        Else
            ckWinAuth = "0"
        End If
        Dim B As Boolean = True
        Dim CN As New SqlConnection
        RtnMsg = ""
        RC = True

        Dim MySql As String = ""
        MySql += " INSERT INTO [dbo].[SecureAttach]
                       ([CompanyID]
                       ,[EncPW]
                       ,[RepoID]
                       ,[CS]
                       ,[Disabled]
                       ,[isThesaurus]
                       ,[CSRepo]
                       ,[CSThesaurus]
                       ,[CSHive]
                       ,[CSDMALicense]
                       ,[CSGateWay]
                       ,[CSTDR]
                       ,[CSKBase]
                       ,[CreateDate]
                       ,[LastModDate]
                       ,[SVCFS_Endpoint]
                       ,[SVCGateway_Endpoint]
                       ,[SVCCLCArchive_Endpoint]
                       ,[SVCSearch_Endpoint]
                       ,[SVCDownload_Endpoint]
                       ,[SVCFS_CS]
                       ,[SVCGateway_CS]
                       ,[SVCSearch_CS]
                       ,[SVCDownload_CS]
                       ,[SVCThesaurus_CS]
                       ,[SvrName]
                       ,[DBName]
                       ,[InstanceName]
                       ,[LoginID]
                       ,[LoginPW]) 
                 VALUES
                       (
                         @CompanyID
                       ,@EncPW
                       ,@RepoID
                       ,@CS
                       ,@Disabled
                       ,@isThesaurus
                       ,@CSRepo
                       ,@CSThesaurus
                       ,@CSHive
                       ,@CSDMALicense
                       ,@CSGateWay
                       ,@CSTDR
                       ,@CSKBase
                       ,@CreateDate
                       ,@LastModDate
                       ,@SVCFS_Endpoint
                       ,@SVCGateway_Endpoint
                       ,@SVCCLCArchive_Endpoint
                       ,@SVCSearch_Endpoint
                       ,@SVCDownload_Endpoint
                       ,@SVCFS_CS
                       ,@SVCGateway_CS
                       ,@SVCSearch_CS
                       ,@SVCDownload_CS
                       ,@SVCThesaurus_CS
                       ,@SvrName
                       ,@DBName
                       ,@InstanceName
                       ,@LoginID
                       ,@LoginPW
          )"

        Try
            B = True
            CN.ConnectionString = ConnStr
            CN.Open()

            Using CN
                Using command As New SqlCommand(MySql, CN)
                    command.CommandType = CommandType.Text
                    command.Parameters.AddWithValue("@CompanyID", CompanyID)
                    command.Parameters.AddWithValue("@EncPW", EncPW)
                    command.Parameters.AddWithValue("@RepoID", RepoID)
                    command.Parameters.AddWithValue("@CS", CS)
                    command.Parameters.AddWithValue("@Disabled", Disabled)
                    command.Parameters.AddWithValue("@RowID", RowID)
                    command.Parameters.AddWithValue("@isThesaurus", isThesaurus)
                    command.Parameters.AddWithValue("@CSRepo", CSRepo)
                    command.Parameters.AddWithValue("@CSThesaurus", CSThesaurus)
                    command.Parameters.AddWithValue("@CSHive", CSHive)
                    command.Parameters.AddWithValue("@CSDMALicense", CSDMALicense)
                    command.Parameters.AddWithValue("@CSGateWay", CSGateWay)
                    command.Parameters.AddWithValue("@CSTDR", CSTDR)
                    command.Parameters.AddWithValue("@CSKBase", CSKBase)
                    command.Parameters.AddWithValue("@CreateDate", CreateDate)
                    command.Parameters.AddWithValue("@LastModDate", LastModDate)
                    command.Parameters.AddWithValue("@SVCFS_Endpoint", SVCFS_Endpoint)
                    command.Parameters.AddWithValue("@SVCGateway_Endpoint", SVCGateway_Endpoint)
                    command.Parameters.AddWithValue("@SVCCLCArchive_Endpoint", SVCCLCArchive_Endpoint)
                    command.Parameters.AddWithValue("@SVCSearch_Endpoint", SVCSearch_Endpoint)
                    command.Parameters.AddWithValue("@SVCDownload_Endpoint", SVCDownload_Endpoint)
                    command.Parameters.AddWithValue("@SVCFS_CS", SVCFS_CS)
                    command.Parameters.AddWithValue("@SVCGateway_CS", SVCGateway_CS)
                    command.Parameters.AddWithValue("@SVCSearch_CS", SVCSearch_CS)
                    command.Parameters.AddWithValue("@SVCDownload_CS", SVCDownload_CS)
                    command.Parameters.AddWithValue("@SVCThesaurus_CS", SVCThesaurus_CS)
                    command.Parameters.AddWithValue("@SvrName", SvrName)
                    command.Parameters.AddWithValue("@DBName", DBName)
                    command.Parameters.AddWithValue("@InstanceName", InstanceName)
                    command.Parameters.AddWithValue("@LoginID", LoginID)
                    command.Parameters.AddWithValue("@LoginPW", LoginPW)

                    command.ExecuteNonQuery()
                    command.Dispose()
                End Using
            End Using
        Catch ex As Exception
            B = False
            RC = False
            RtnMsg = ex.Message.ToString
        Finally
            CN.Close()
            CN.Dispose()
            GC.Collect()
        End Try
        ENC2 = Nothing
        Return B
    End Function

    Function duplicateEntryx(ByVal ConnStr As String, tDict As Dictionary(Of String, String)) As Boolean

        'Dim ENC As New clsEncrypt

        Dim B As Boolean = True
        Dim CN As New SqlConnection
        Dim RetMsg As String = ""

        Dim CreateDate As String = ""
        Dim LastModDate As String = Now.ToString()
        Dim Disabled As String = ""
        Dim isThesaurus As String = ""
        Dim RowID As String = ""
        Dim RepoID As String = ""
        Dim CompanyID As String = ""
        Dim EncPW As String = ""
        Dim Cs As String = ""
        Dim CSThesaurus As String = ""
        Dim CSHive As String = ""
        Dim CSRepo As String = ""
        Dim CSDMALicense As String = ""
        Dim CSGateWay As String = ""
        Dim CSTDR As String = ""
        Dim CSKBase As String = ""

        Dim gSVCFS_Endpoint As String = ""
        Dim gSVCGateway_Endpoint As String = ""
        Dim gSVCCLCArchive_Endpoint As String = ""
        Dim gSVCSearch_Endpoint As String = ""
        Dim gSVCDownload_Endpoint As String = ""

        Dim MySql As String = "Update SecureAttach " + vbCrLf
        MySql += "Set" + vbCrLf
        MySql += " EncPW = @EncPW " + vbCrLf
        MySql += ", CS = @CS " + vbCrLf
        MySql += ", Disabled = @Disabled " + vbCrLf
        MySql += ", isThesaurus = @isThesaurus " + vbCrLf
        MySql += ", CSRepo = @CSRepo " + vbCrLf
        MySql += ", CSThesaurus = @CSThesaurus " + vbCrLf
        MySql += ", CSHive = @CSHive " + vbCrLf
        MySql += ", CSDMALicense = @CSDMALicense " + vbCrLf
        MySql += ", CSGateWay = @CSGateWay " + vbCrLf
        MySql += ", CSTDR = @CSTDR " + vbCrLf
        MySql += ", CSKBase = @CSKBase " + vbCrLf
        MySql += ", LastModDate = @LastModDate " + vbCrLf
        MySql += ", SVCFS_Endpoint = @SVCFS_Endpoint " + vbCrLf
        MySql += ", SVCGateway_Endpoint = @SVCGateway_Endpoint " + vbCrLf
        MySql += ", SVCCLCArchive_Endpoint = @SVCCLCArchive_Endpoint " + vbCrLf
        MySql += ", SVCSearch_Endpoint = @SVCSearch_Endpoint " + vbCrLf
        MySql += ", SVCDownload_Endpoint = @SVCDownload_Endpoint " + vbCrLf
        MySql += "where CompanyID = @CompanyID And RepoID = @RepoID"

        Try
            B = True
            CN.ConnectionString = ConnStr
            CN.Open()

            Using CN
                Using command As New SqlCommand(MySql, CN)
                    command.CommandType = CommandType.Text
                    command.Parameters.AddWithValue("@CompanyID", CompanyID)
                    command.Parameters.AddWithValue("@RepoID", RepoID)
                    command.Parameters.AddWithValue("@EncPW", EncPW)
                    command.Parameters.AddWithValue("@CS", Cs)
                    command.Parameters.AddWithValue("@Disabled", Disabled)
                    command.Parameters.AddWithValue("@isThesaurus", isThesaurus)

                    command.Parameters.AddWithValue("@CSRepo", CSRepo)
                    command.Parameters.AddWithValue("@CSThesaurus", CSThesaurus)
                    command.Parameters.AddWithValue("@CSHive", CSHive)
                    command.Parameters.AddWithValue("@CSDMALicense", CSDMALicense)
                    command.Parameters.AddWithValue("@CSGateWay", CSGateWay)
                    command.Parameters.AddWithValue("@CSTDR", CSTDR)
                    command.Parameters.AddWithValue("@CSKBase", CSKBase)
                    command.Parameters.AddWithValue("@LastModDate", LastModDate)
                    command.Parameters.AddWithValue("@SVCFS_Endpoint", gSVCFS_Endpoint)
                    command.Parameters.AddWithValue("@SVCGateway_Endpoint", gSVCGateway_Endpoint)
                    command.Parameters.AddWithValue("@SVCCLCArchive_Endpoint", gSVCCLCArchive_Endpoint)
                    command.Parameters.AddWithValue("@SVCSearch_Endpoint", gSVCSearch_Endpoint)
                    command.Parameters.AddWithValue("@SVCDownload_Endpoint", gSVCDownload_Endpoint)

                    command.ExecuteNonQuery()
                    command.Dispose()
                End Using
            End Using
        Catch ex As Exception
            B = False
        Finally
            CN.Close()
            CN.Dispose()
            GC.Collect()
        End Try

        Return B
    End Function

    Function DeleteExistingConnection(ByVal ConnStr As String,
                               tDict As Dictionary(Of String, String),
                               ByRef RC As Boolean, ByRef RtnMsg As String) As Boolean

        Dim CompanyID As String = tDict("CompanyID")
        Dim SvrName As String = tDict("SvrName")
        Dim DBName As String = tDict("DBName")
        Dim InstanceName As String = tDict("InstanceID")

        Dim B As Boolean = True
        Dim CN As New SqlConnection
        RtnMsg = ""
        RC = True

        Dim MySql As String = "delete from SecureAttach " + vbCrLf
        MySql += "where CompanyID = @CompanyID And SvrName = @SvrName and DBName = @DBName AND InstanceName = '" + InstanceName + "' "
        Try
            B = True
            CN.ConnectionString = ConnStr
            CN.Open()

            Using CN
                Using command As New SqlCommand(MySql, CN)
                    command.CommandType = CommandType.Text
                    command.Parameters.AddWithValue("@CompanyID", CompanyID)
                    command.Parameters.AddWithValue("@SvrName", SvrName)
                    command.Parameters.AddWithValue("@DBName", DBName)
                    command.ExecuteNonQuery()
                    command.Dispose()
                End Using
                'MySql = "delete from [user] " + vbCrLf
                'MySql += "where CurrRepoID = @CurrRepoID"
                'Using command2 As New SqlCommand(MySql, CN)
                '    command2.CommandType = CommandType.Text
                '    command2.Parameters.AddWithValue("@CurrRepoID", RowID)
                '    command2.ExecuteNonQuery()
                '    command2.Dispose()
                'End Using
            End Using
        Catch ex As Exception
            B = False
            RC = False
            RtnMsg = ex.Message.ToString
        Finally
            CN.Close()
            CN.Dispose()
            GC.Collect()
        End Try

        Return B
    End Function

    Function PopulateGrid(ByVal CS As String, ByVal CompanyID As String, ByVal EncPW As String, ByRef RC As Boolean, ByRef RetTxt As String, LimitToCompany As Integer) As List(Of DS_SecureAttach)

        Dim ListOfItems As New List(Of DS_SecureAttach)
        RC = True
        RetTxt = ""

        Dim sCompanyID As String = ""
        Dim sEncPW As String = ""
        Dim sRepoID As String = ""
        Dim sCS As String = ""
        Dim Disabled As Integer = 0

        Dim RowID As Integer = Nothing
        Dim isThesaurus As Integer = 0
        Dim CSRepo As String = ""
        Dim CSThesaurus As String = ""
        Dim CSHive As String = ""
        Dim CSDMALicense As String = ""
        Dim CSGateWay As String = ""
        Dim CSTDR As String = ""
        Dim CSKBase As String = ""
        Dim CreateDate As Date = Nothing
        Dim LastModDate As Date = Nothing
        Dim SVCFS_Endpoint As String = ""
        Dim SVCGateway_Endpoint As String = ""
        Dim SVCCLCArchive_Endpoint As String = ""
        Dim SVCSearch_Endpoint As String = ""
        Dim SVCDownload_Endpoint As String = ""
        Dim SVCFS_CS As String = ""
        Dim SVCGateway_CS As String = ""
        Dim SVCSearch_CS As String = ""
        Dim SVCDownload_CS As String = ""
        Dim SVCThesaurus_CS As String = ""
        Dim S As String = ""

        S += " Select CompanyID" + vbCrLf
        S += " ,EncPW" + vbCrLf
        S += " ,RepoID" + vbCrLf
        S += " ,CS" + vbCrLf
        S += " ,Disabled" + vbCrLf
        S += " ,RowID" + vbCrLf
        S += " ,isThesaurus" + vbCrLf
        S += " ,CSRepo" + vbCrLf
        S += " ,CSThesaurus" + vbCrLf
        S += " ,CSHive" + vbCrLf
        S += " ,CSDMALicense" + vbCrLf
        S += " ,CSGateWay" + vbCrLf
        S += " ,CSTDR" + vbCrLf
        S += " ,CSKBase" + vbCrLf
        S += " ,CreateDate" + vbCrLf
        S += " ,LastModDate" + vbCrLf
        S += " ,SVCFS_Endpoint" + vbCrLf
        S += " ,SVCGateway_Endpoint" + vbCrLf
        S += " ,SVCCLCArchive_Endpoint" + vbCrLf
        S += " ,SVCSearch_Endpoint" + vbCrLf
        S += " ,SVCDownload_Endpoint" + vbCrLf
        S += " ,SVCFS_CS" + vbCrLf
        S += " ,SVCGateway_CS" + vbCrLf
        S += " ,SVCSearch_CS" + vbCrLf
        S += " ,SVCDownload_CS" + vbCrLf
        S += " ,SVCThesaurus_CS" + vbCrLf
        S += " FROM SecureAttach"

        If LimitToCompany > 0 Then
            S += " Where CompanyID = '" + CompanyID + "'" + vbCrLf
        End If

        S += " order by CompanyID, RepoID" + vbCrLf

        Dim ddebug As Boolean = True
        If ddebug.Equals(True) Then
            Debug.Print("01x SQL: " + vbCrLf + S)
        End If
        Dim RSData As SqlDataReader = Nothing
        Dim CONN As New SqlConnection(CS)
        CONN.Open()
        Dim command As New SqlCommand(S, CONN)

        RSData = command.ExecuteReader()

        Try
            If RSData.HasRows Then
                Do While RSData.Read()
                    Try
                        sCompanyID = RSData.GetValue(0).ToString
                    Catch ex As Exception
                        sCompanyID = ""
                    End Try
                    Try
                        sEncPW = RSData.GetValue(1).ToString
                    Catch ex As Exception
                        sEncPW = ""
                    End Try
                    Try
                        sRepoID = RSData.GetValue(2).ToString
                    Catch ex As Exception
                        sRepoID = ""
                    End Try
                    Try
                        sCS = RSData.GetValue(3).ToString
                    Catch ex As Exception
                        sCS = ""
                    End Try
                    Try
                        Disabled = CInt(RSData.GetBoolean(4))
                    Catch ex As Exception
                        Disabled = 0
                    End Try
                    Try
                        RowID = RSData.GetInt32(5)
                    Catch ex As Exception
                        RowID = -1
                    End Try
                    Try
                        isThesaurus = CInt(RSData.GetBoolean(6))
                    Catch ex As Exception
                        isThesaurus = 0
                    End Try
                    Try
                        CSRepo = RSData.GetString(7)
                    Catch ex As Exception
                        CSRepo = ""
                    End Try
                    Try
                        CSThesaurus = RSData.GetString(8)
                    Catch ex As Exception
                        CSThesaurus = ""
                    End Try
                    Try
                        CSHive = RSData.GetString(9)
                    Catch ex As Exception
                        CSHive = ""
                    End Try
                    Try
                        CSDMALicense = RSData.GetString(10)
                    Catch ex As Exception
                        CSDMALicense = ""
                    End Try
                    Try
                        CSGateWay = RSData.GetString(11)
                    Catch ex As Exception
                        CSGateWay = ""
                    End Try
                    Try
                        CSTDR = RSData.GetString(12)
                    Catch ex As Exception
                        CSTDR = ""
                    End Try
                    Try
                        CSKBase = RSData.GetString(13)
                    Catch ex As Exception
                        CSKBase = ""
                    End Try
                    Try
                        CreateDate = RSData.GetDateTime(14)
                    Catch ex As Exception
                        CreateDate = Nothing
                    End Try
                    Try
                        LastModDate = RSData.GetDateTime(15)
                    Catch ex As Exception
                        LastModDate = Nothing
                    End Try
                    Try
                        SVCFS_Endpoint = RSData.GetString(16)
                    Catch ex As Exception
                        SVCFS_Endpoint = ""
                    End Try
                    Try
                        SVCGateway_Endpoint = RSData.GetString(17)
                    Catch ex As Exception
                        SVCGateway_Endpoint = ""
                    End Try
                    Try
                        SVCCLCArchive_Endpoint = RSData.GetString(18)
                    Catch ex As Exception
                        SVCCLCArchive_Endpoint = ""
                    End Try
                    Try
                        SVCSearch_Endpoint = RSData.GetString(19)
                    Catch ex As Exception
                        SVCSearch_Endpoint = ""
                    End Try
                    Try
                        SVCDownload_Endpoint = RSData.GetString(20)
                    Catch ex As Exception
                        SVCDownload_Endpoint = ""
                    End Try
                    Try
                        SVCFS_CS = RSData.GetString(21)
                    Catch ex As Exception
                        SVCFS_CS = ""
                    End Try
                    Try
                        SVCGateway_CS = RSData.GetString(22)
                    Catch ex As Exception
                        SVCGateway_CS = ""
                    End Try
                    Try
                        SVCSearch_CS = RSData.GetString(23)
                    Catch ex As Exception
                        SVCSearch_CS = ""
                    End Try
                    Try
                        SVCDownload_CS = RSData.GetString(24)
                    Catch ex As Exception
                        SVCDownload_CS = ""
                    End Try
                    Try
                        SVCThesaurus_CS = RSData.GetString(25)
                    Catch ex As Exception
                        SVCThesaurus_CS = ""
                    End Try

                    Dim LI As New DS_SecureAttach
                    LI.CompanyID = sCompanyID
                    LI.EncPW = sEncPW
                    LI.RepoID = sRepoID
                    LI.CS = sCS
                    LI.Disabled = Disabled
                    LI.RowID = RowID
                    LI.isThesaurus = isThesaurus
                    LI.CSRepo = CSRepo
                    LI.CSThesaurus = CSThesaurus
                    LI.CSHive = CSHive
                    LI.CSDMALicense = CSDMALicense
                    LI.CSGateWay = CSGateWay
                    LI.CSTDR = CSTDR
                    LI.CSKBase = CSKBase
                    LI.CreateDate = CreateDate
                    LI.LastModDate = LastModDate
                    LI.SVCFS_Endpoint = SVCFS_Endpoint
                    LI.SVCGateway_Endpoint = SVCGateway_Endpoint
                    LI.SVCCLCArchive_Endpoint = SVCCLCArchive_Endpoint
                    LI.SVCSearch_Endpoint = SVCSearch_Endpoint
                    LI.SVCDownload_Endpoint = SVCDownload_Endpoint
                    LI.SVCFS_CS = SVCFS_CS
                    LI.SVCGateway_CS = SVCGateway_CS
                    LI.SVCSearch_CS = SVCSearch_CS
                    LI.SVCDownload_CS = SVCDownload_CS
                    LI.SVCThesaurus_CS = SVCThesaurus_CS

                    ListOfItems.Add(LI)
                Loop
            Else
                ListOfItems = Nothing
            End If
        Catch ex As Exception
            RC = False
            RetTxt = ex.Message
        Finally
            If RSData.IsClosed Then
            Else
                RSData.Close()
            End If
            RSData = Nothing
            If CONN.State = ConnectionState.Open Then
                CONN.Close()
            End If
            CONN.Dispose()
            command.Dispose()
        End Try

        GC.Collect()
        GC.WaitForPendingFinalizers()

        Return ListOfItems

    End Function

    ''' <summary>
    ''' </summary>
    ''' <param name="CS">       
    ''' Leave the connection string blank to use the locally defined CONFIG connection string
    ''' </param>
    ''' <param name="CompanyID"></param>
    ''' <param name="RC">       </param>
    ''' <param name="RetTxt">   </param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Function PopulateCombo(ByVal CS As String, ByVal CompanyID As String, ByRef RC As Boolean, ByRef RetTxt As String) As String

        If CS.Length = 0 Then

            CS = System.Configuration.ConfigurationManager.AppSettings("ECMSecureLogin")
            Dim TS As String = XXI()
            CS = CS.Replace("@@PW@@", TS)
        End If

        Dim lItems As String = ""
        RC = True
        RetTxt = ""

        Dim sCompanyID As String = ""
        Dim sEncPW As String = ""
        Dim sRepoID As String = ""
        'Dim sCS As String = ""
        Dim Disabled As Boolean = Nothing

        Dim S As String = ""
        S += " SELECT distinct CompanyID" + vbCrLf
        S += " FROM SecureAttach " + vbCrLf
        S += " order by CompanyID" + vbCrLf

        Dim RSData As SqlDataReader = Nothing
        Dim CONN As New SqlConnection
        Dim command As New SqlCommand

        Try
            CONN.ConnectionString = CS
            CONN.Open()
            command.Connection = CONN
            command.CommandText = S
            RSData = command.ExecuteReader()

            If RSData.HasRows Then
                Do While RSData.Read()
                    Dim LI As New DS_Combo
                    sCompanyID = RSData.GetValue(0).ToString
                    lItems += sCompanyID + "|"
                Loop
            End If
            RetTxt = lItems
        Catch ex As Exception
            RC = False
            RetTxt = ex.Message
        Finally
            If RSData.IsClosed Then
            Else
                RSData.Close()
            End If
            RSData = Nothing
            If CONN.State = ConnectionState.Open Then
                CONN.Close()
            End If
            CONN.Dispose()
            command.Dispose()
        End Try

        GC.Collect()
        GC.WaitForPendingFinalizers()

        Return lItems

    End Function

    Function getSecureID(CompanyID As String, RepoID As String) As Integer

        Dim CS As String = System.Configuration.ConfigurationManager.AppSettings("ECMSecureLogin")
        Dim TS As String = XXI()
        CS = CS.Replace("@@PW@@", TS)

        Dim ListOfItems As String = ""
        Dim rid As Integer = -1

        Dim sCompanyID As String = ""
        Dim sEncPW As String = ""
        Dim sRepoID As String = ""
        'Dim sCS As String = ""
        Dim Disabled As Boolean = Nothing
        Dim SVCFS_Endpoint As String = ""
        Dim SVCGateway_Endpoint As String = ""
        Dim SVCCLCArchive_Endpoint As String = ""
        Dim SVCSearch_Endpoint As String = ""
        Dim SVCDownload_Endpoint As String = ""

        Dim S As String = ""
        S += " Select RowID "
        S += " From [dbo].[SecureAttach] "
        S += " Where [CompanyID] = '" + CompanyID + "' "
        S += " And [RepoID] = '" + RepoID + "' "

        Dim RSData As SqlDataReader = Nothing
        Dim CONN As New SqlConnection
        Dim command As New SqlCommand

        Try
            CONN.ConnectionString = CS
            CONN.Open()
            command.Connection = CONN
            command.CommandText = S
            RSData = command.ExecuteReader()

            If RSData.HasRows Then
                Do While RSData.Read()
                    rid = RSData.GetInt32(0)
                Loop
            End If
        Catch ex As Exception
            rid = -1
        Finally
            If RSData.IsClosed Then
            Else
                RSData.Close()
            End If
            RSData = Nothing
            If CONN.State = ConnectionState.Open Then
                CONN.Close()
            End If
            CONN.Dispose()
            command.Dispose()
        End Try

        GC.Collect()
        GC.WaitForPendingFinalizers()

        Return rid

    End Function

    Function getEndPoints(ByVal CompanyID As String, RepoID As String) As String

        ''*************************************** DEBUG SETUP FOR ENDPOINTS *******************************************
        'update [ECM.SecureLogin].[dbo].[SecureAttach]
        'set [SVCCLCArchive_Endpoint] = 'http://ECM2016/archive/SVCCLCArchive.svc'
        'where RowID = 23

        'update [ECM.SecureLogin].[dbo].[SecureAttach]
        'set [SVCCLCArchive_Endpoint] = 'http://localhost:53407/SVCCLCArchive.svc'
        'where RowID = 23
        ''*************************************************************************************************************

        Dim CS As String = System.Configuration.ConfigurationManager.AppSettings("ECMSecureLogin")
        Dim TS As String = XXI()
        CS = CS.Replace("@@PW@@", TS)

        Dim ListOfItems As String = ""
        Dim RC = True
        Dim RetTxt = ""

        Dim sCompanyID As String = ""
        Dim sEncPW As String = ""
        Dim sRepoID As String = ""
        'Dim sCS As String = ""
        Dim Disabled As Boolean = Nothing
        Dim SVCFS_Endpoint As String = ""
        Dim SVCGateway_Endpoint As String = ""
        Dim SVCCLCArchive_Endpoint As String = ""
        Dim SVCSearch_Endpoint As String = ""
        Dim SVCDownload_Endpoint As String = ""

        Dim S As String = ""
        S += " Select SVCFS_Endpoint, [SVCGateway_Endpoint],[SVCCLCArchive_Endpoint],[SVCSearch_Endpoint],[SVCDownload_Endpoint] "
        S += " From [dbo].[SecureAttach] "
        S += " Where [CompanyID] = '" + CompanyID + "' "
        S += " And [RepoID] = '" + RepoID + "' "

        Dim RSData As SqlDataReader = Nothing
        Dim CONN As New SqlConnection
        Dim command As New SqlCommand

        Try
            CONN.ConnectionString = CS
            CONN.Open()
            command.Connection = CONN
            command.CommandText = S
            RSData = command.ExecuteReader()

            If RSData.HasRows Then
                Do While RSData.Read()
                    SVCFS_Endpoint = RSData.GetValue(0).ToString
                    SVCGateway_Endpoint = RSData.GetValue(1).ToString
                    SVCCLCArchive_Endpoint = RSData.GetValue(2).ToString
                    SVCSearch_Endpoint = RSData.GetValue(3).ToString
                    SVCDownload_Endpoint = RSData.GetValue(4).ToString
                    ListOfItems += SVCFS_Endpoint + "|"
                    ListOfItems += SVCGateway_Endpoint + "|"
                    ListOfItems += SVCCLCArchive_Endpoint + "|"
                    ListOfItems += SVCSearch_Endpoint + "|"
                    ListOfItems += SVCDownload_Endpoint
                Loop
            End If
            RetTxt = ListOfItems
        Catch ex As Exception
            RC = False
            RetTxt = ex.Message
        Finally
            If RSData.IsClosed Then
            Else
                RSData.Close()
            End If
            RSData = Nothing
            If CONN.State = ConnectionState.Open Then
                CONN.Close()
            End If
            CONN.Dispose()
            command.Dispose()
        End Try

        GC.Collect()
        GC.WaitForPendingFinalizers()

        Return ListOfItems
    End Function

    Function getCS(gSecureID As Integer) As String
        Dim CS As String = ""
        CS = System.Configuration.ConfigurationManager.AppSettings("ECMSecureLogin")
        Dim TS As String = XXI()
        CS = CS.Replace("@@PW@@", TS)

        Dim lItems As String = ""
        Dim sEncPW As String = ""
        Dim sRepoID As String = ""
        Dim Disabled As Boolean = Nothing

        Dim S As String = ""
        S += " SELECT CS FROM [dbo].[SecureAttach] where [RowID] = " + gSecureID.ToString()

        Dim RSData As SqlDataReader = Nothing
        Dim CONN As New SqlConnection
        Dim command As New SqlCommand

        Try
            CONN.ConnectionString = CS
            CONN.Open()
            command.Connection = CONN
            command.CommandText = S
            RSData = command.ExecuteReader()

            If RSData.HasRows Then
                Do While RSData.Read()
                    Dim LI As New DS_Combo
                    lItems = RSData.GetValue(0).ToString
                Loop
            End If
        Catch ex As Exception
            Return ""
        Finally
            If RSData.IsClosed Then
            Else
                RSData.Close()
            End If
            RSData = Nothing
            If CONN.State = ConnectionState.Open Then
                CONN.Close()
            End If
            CONN.Dispose()
            command.Dispose()
        End Try

        GC.Collect()
        GC.WaitForPendingFinalizers()

        Return lItems
    End Function

    Function getRepoCS(gSecureID As Integer) As String
        Dim CS As String = ""
        CS = System.Configuration.ConfigurationManager.AppSettings("ECMSecureLogin")
        Dim TS As String = XXI()
        CS = CS.Replace("@@PW@@", TS)

        Dim lItems As String = ""
        Dim sEncPW As String = ""
        Dim sRepoID As String = ""
        Dim Disabled As Boolean = Nothing

        Dim S As String = ""
        S += " SELECT CSRepo FROM [dbo].[SecureAttach] where [RowID] = " + gSecureID.ToString()

        Dim RSData As SqlDataReader = Nothing
        Dim CONN As New SqlConnection
        Dim command As New SqlCommand

        Try
            CONN.ConnectionString = CS
            CONN.Open()
            command.Connection = CONN
            command.CommandText = S
            RSData = command.ExecuteReader()

            If RSData.HasRows Then
                Do While RSData.Read()
                    Dim LI As New DS_Combo
                    lItems = RSData.GetValue(0).ToString
                Loop
            End If
        Catch ex As Exception
            Return ""
        Finally
            If RSData.IsClosed Then
            Else
                RSData.Close()
            End If
            RSData = Nothing
            If CONN.State = ConnectionState.Open Then
                CONN.Close()
            End If
            CONN.Dispose()
            command.Dispose()
        End Try

        GC.Collect()
        GC.WaitForPendingFinalizers()

        Return lItems
    End Function

    Function validateAttachSecureLogin(gSecureID As Integer, gCustomerID As String, gRepoID As String, LoginID As String, EPW As String) As Integer

        Dim RepoCS As String = getCS(gSecureID)
        If (RepoCS.Length <= 0) Then
            Return -100
        End If
        Dim RC As Integer = 0

        Dim S As String = ""
        S = "SELECT count(*) FROM [Users] where UserID = '" + LoginID + "' and UserPassword = '" + EPW + "' "

        Dim RSData As SqlDataReader = Nothing
        Dim CONN As New SqlConnection
        Dim command As New SqlCommand

        Try
            CONN.ConnectionString = RepoCS
            CONN.Open()
            command.Connection = CONN
            command.CommandText = S
            RSData = command.ExecuteReader()

            If RSData.HasRows Then
                Do While RSData.Read()
                    RC = RSData.GetInt32(0)
                Loop
            End If
        Catch ex As Exception
            Return -1
        Finally
            If RSData.IsClosed Then
            Else
                RSData.Close()
            End If
            RSData = Nothing
            If CONN.State = ConnectionState.Open Then
                CONN.Close()
            End If
            CONN.Dispose()
            command.Dispose()
        End Try

        GC.Collect()
        GC.WaitForPendingFinalizers()

        Return RC
    End Function

    Function getGatewayCS(gSecureID As Integer, gCustomerID As String, gRepoID As String, EPW As String) As String

        Dim CS As String = ""
        CS = System.Configuration.ConfigurationManager.AppSettings("ECMSecureLogin")
        Dim TS As String = XXI()
        CS = CS.Replace("@@PW@@", TS)

        Dim lItems As String = ""
        Dim sEncPW As String = ""
        Dim sRepoID As String = ""
        Dim Disabled As Boolean = Nothing

        Dim S As String = ""
        S += " SELECT CS FROM [dbo].[SecureAttach] where [CompanyID] = '" + gCustomerID + "' and RepoID = '" + gRepoID + "' and EncPW = '" + EPW + "' "

        Dim RSData As SqlDataReader = Nothing
        Dim CONN As New SqlConnection
        Dim command As New SqlCommand

        Try
            CONN.ConnectionString = CS
            CONN.Open()
            command.Connection = CONN
            command.CommandText = S
            RSData = command.ExecuteReader()

            If RSData.HasRows Then
                Do While RSData.Read()
                    Dim LI As New DS_Combo
                    lItems = RSData.GetValue(0).ToString
                Loop
            End If
        Catch ex As Exception
            Return ""
        Finally
            If RSData.IsClosed Then
            Else
                RSData.Close()
            End If
            RSData = Nothing
            If CONN.State = ConnectionState.Open Then
                CONN.Close()
            End If
            CONN.Dispose()
            command.Dispose()
        End Try

        GC.Collect()
        GC.WaitForPendingFinalizers()

        Return lItems
    End Function

    Function PopulateGatewayLoginCB(ByVal CS As String, ByVal CompanyID As String) As String

        If CS.Length = 0 Then

            CS = System.Configuration.ConfigurationManager.AppSettings("ECMSecureLogin")
            Dim TS As String = XXI()
            CS = CS.Replace("@@PW@@", TS)
        End If

        Dim lItems As String = ""
        Dim sCompanyID As String = ""
        Dim sEncPW As String = ""
        Dim sRepoID As String = ""
        Dim Disabled As Boolean = Nothing

        Dim S As String = ""
        S += " SELECT RepoID FROM [dbo].[SecureAttach] where [CompanyID] = '" + CompanyID + "' order by RepoID "

        Dim RSData As SqlDataReader = Nothing
        Dim CONN As New SqlConnection
        Dim command As New SqlCommand

        Try
            CONN.ConnectionString = CS
            CONN.Open()
            command.Connection = CONN
            command.CommandText = S
            RSData = command.ExecuteReader()

            If RSData.HasRows Then
                Do While RSData.Read()
                    Dim LI As New DS_Combo
                    sCompanyID = RSData.GetValue(0).ToString
                    lItems += sCompanyID + "|"
                Loop
            End If
        Catch ex As Exception
            Return ""
        Finally
            If RSData.IsClosed Then
            Else
                RSData.Close()
            End If
            RSData = Nothing
            If CONN.State = ConnectionState.Open Then
                CONN.Close()
            End If
            CONN.Dispose()
            command.Dispose()
        End Try

        GC.Collect()
        GC.WaitForPendingFinalizers()

        Return lItems
    End Function

    Function PopulateCompanyComboSecure(ByVal CS As String, ByVal CompanyID As String, ByVal EncryptedPW As String, ByRef RC As Boolean, ByRef RetTxt As String) As String

        ''Dim ENC As New clsEncrypt
        'Try
        '    EncryptedPW = ENC.AES256EncryptString(EncryptedPW, RC, RetTxt)
        'Catch ex As Exception
        '    'ENC = Nothing
        '    RC = False
        '    RetTxt = "ERROR: PopulateCompanyComboSecure 100 - " + ex.Message
        '    Return ""
        'End Try
        ''ENC = Nothing
        'GC.Collect()

        If CS.Length = 0 Then

            CS = System.Configuration.ConfigurationManager.AppSettings("ECMSecureLogin")
            Dim TS As String = XXI()
            CS = CS.Replace("@@PW@@", TS)
        End If

        Dim lItems As String = ""
        RC = True
        RetTxt = ""

        Dim sCompanyID As String = ""
        Dim sEncPW As String = ""
        Dim sRepoID As String = ""
        'Dim sCS As String = ""
        Dim Disabled As Boolean = Nothing

        Dim S As String = ""
        S += " SELECT distinct CompanyID" + vbCrLf
        S += " FROM SecureAttach where EncPW = '" + EncryptedPW + "' " + vbCrLf
        S += " order by CompanyID" + vbCrLf

        Dim RSData As SqlDataReader = Nothing
        Dim CONN As New SqlConnection
        Dim command As New SqlCommand

        Try
            CONN.ConnectionString = CS
            CONN.Open()
            command.Connection = CONN
            command.CommandText = S
            RSData = command.ExecuteReader()

            If RSData.HasRows Then
                Do While RSData.Read()
                    Dim LI As New DS_Combo
                    sCompanyID = RSData.GetValue(0).ToString
                    lItems += sCompanyID + "|"
                Loop
            End If
            RetTxt = lItems
        Catch ex As Exception
            RC = False
            RetTxt = ex.Message
        Finally
            If RSData.IsClosed Then
            Else
                RSData.Close()
            End If
            RSData = Nothing
            If CONN.State = ConnectionState.Open Then
                CONN.Close()
            End If
            CONN.Dispose()
            command.Dispose()
        End Try

        GC.Collect()
        GC.WaitForPendingFinalizers()

        Return lItems

    End Function

    Function PopulateRepoSecure(ByVal CS As String, ByVal CompanyID As String, ByVal EncryptedPW As String, ByRef RC As Boolean, ByRef RetTxt As String) As String

        If CS.Length = 0 Then
            CS = System.Configuration.ConfigurationManager.AppSettings("ECMSecureLogin")
            Dim TS As String = XXI()
            CS = CS.Replace("@@PW@@", TS)
        End If

        Dim bGoodPW As Boolean = False
        Dim lItems As String = ""
        RC = True
        RetTxt = ""

        Dim sCompanyID As String = ""
        Dim sEncPW As String = ""
        Dim sRepoID As String = ""
        'Dim sCS As String = ""
        Dim Disabled As Boolean = Nothing

        Dim S As String = ""
        S += " SELECT distinct CompanyID" + vbCrLf
        S += " FROM SecureAttach where EncPW = '" + EncryptedPW + "' " + vbCrLf
        S += " order by CompanyID" + vbCrLf

        Dim RSData As SqlDataReader = Nothing
        Dim CONN As New SqlConnection
        Dim command As New SqlCommand

        Try
            CONN.ConnectionString = CS
            CONN.Open()
            command.Connection = CONN
            command.CommandText = S
            RSData = command.ExecuteReader()

            If RSData.HasRows Then
                Do While RSData.Read()
                    bGoodPW = True
                Loop
            End If
            RetTxt = lItems
        Catch ex As Exception
            bGoodPW = False
            RC = False
            RetTxt = ex.Message
        Finally
            If RSData.IsClosed Then
            Else
                RSData.Close()
            End If
            RSData = Nothing
            If CONN.State = ConnectionState.Open Then
                CONN.Close()
            End If
            CONN.Dispose()
            command.Dispose()
        End Try

        If bGoodPW Then
            lItems = PopulateRepoCombo(CS, CompanyID, RC, RetTxt)
        End If

        GC.Collect()
        GC.WaitForPendingFinalizers()

        Return lItems

    End Function

    ''' <summary>
    ''' Get a list of REPO ids set for a given company.
    ''' </summary>
    ''' <param name="Connstr">  
    ''' Leave this NULL in order to use the locally CONFIG defined connection string. Pass in a conn
    ''' str to use any gateway.
    ''' </param>
    ''' <param name="CompanyID"></param>
    ''' <param name="RC">       </param>
    ''' <param name="RetTxt">   </param>
    ''' <returns>A delimited list of repo IDs for a given company</returns>
    ''' <remarks></remarks>
    Function PopulateRepoCombo(ByVal Connstr As String, ByVal CompanyID As String, ByRef RC As Boolean, ByRef RetTxt As String) As String

        If Connstr.Length = 0 Then
            Connstr = System.Configuration.ConfigurationManager.AppSettings("ECMSecureLogin")
            Dim TS As String = XXI()
            Connstr = Connstr.Replace("@@PW@@", TS)
        End If

        Dim lItems As String = ""
        RC = True
        RetTxt = ""

        Dim sRepoID As String = ""
        Dim sEncPW As String = ""
        Dim sCS As String = ""
        Dim Disabled As Boolean = Nothing

        Dim S As String = ""
        S += " SELECT RepoID" + vbCrLf
        S += " FROM SecureAttach " + vbCrLf
        S += " Where CompanyID = '" + CompanyID + "' " + vbCrLf
        S += " order by RepoID" + vbCrLf

        Dim RSData As SqlDataReader = Nothing
        Dim CONN As New SqlConnection(Connstr)
        CONN.Open()
        Dim command As New SqlCommand(S, CONN)

        RSData = command.ExecuteReader()

        Try
            If RSData.HasRows Then
                Do While RSData.Read()
                    Dim LI As New DS_Combo
                    sRepoID = RSData.GetValue(0).ToString
                    lItems += sRepoID + "|"
                Loop
            End If
        Catch ex As Exception
            RC = False
            RetTxt = ex.Message
        Finally
            If RSData.IsClosed Then
            Else
                RSData.Close()
            End If
            RSData = Nothing
            If CONN.State = ConnectionState.Open Then
                CONN.Close()
            End If
            CONN.Dispose()
            command.Dispose()
        End Try

        GC.Collect()
        GC.WaitForPendingFinalizers()

        Return lItems

    End Function

    Function getSecureKey(ByVal CompanyID As String, ByVal RepoID As String, ByVal LoginPassword As String, ByRef RC As Boolean, ByRef RetMsg As String) As String
        Dim S As String = ""
        Dim SKey As String = ""

        'Dim ENC As New clsEncrypt

        Dim Connstr As String = ""
        Connstr = System.Configuration.ConfigurationManager.AppSettings("ECMSecureLogin")
        Dim TS As String = XXI()
        Connstr = Connstr.Replace("@@PW@@", TS)

        If Connstr.Length = 0 Then
            RetMsg = "ERROR: Failed to retrieve connection string."
            RC = False
            Return ""
        End If

        S += " SELECT distinct CS" + vbCrLf
        S += " FROM SecureAttach " + vbCrLf
        S += " Where CompanyID = '" + CompanyID + "'" + vbCrLf
        S += " and RepoID = '" + RepoID + "' " + vbCrLf
        S += " and EncPW = '" + LoginPassword + "' " + vbCrLf

        Dim RSData As SqlDataReader = Nothing
        Dim CONN As New SqlConnection(Connstr)
        CONN.Open()
        Dim command As New SqlCommand(S, CONN)

        RSData = command.ExecuteReader()

        Try
            If RSData.HasRows Then
                RSData.Read()
                Dim LI As New DS_Combo
                SKey = RSData.GetValue(0).ToString
            End If
        Catch ex As Exception
            RC = False
            RetMsg = ex.Message
        Finally
            If RSData.IsClosed Then
            Else
                RSData.Close()
            End If
            RSData = Nothing
            If CONN.State = ConnectionState.Open Then
                CONN.Close()
            End If
            CONN.Dispose()
            command.Dispose()
        End Try

        'ENC = Nothing

        GC.Collect()
        GC.WaitForPendingFinalizers()

        Return SKey
    End Function

    Public Function getConnection(ByVal CompanyID As String, ByVal RepoID As String, ByRef RC As Boolean, ByRef RetMsg As String) As String

        Dim B As Boolean = False
        Dim MySql As String = "select CS from SecureAttach where CompanyID = @CompanyID and RepoID = @RepoID "

        Dim Connstr As String = ""
        Connstr = System.Configuration.ConfigurationManager.AppSettings("ECMSecureLogin")
        Dim TS As String = XXI()
        Connstr = Connstr.Replace("@@PW@@", TS)

        Dim RSData As SqlDataReader = Nothing
        Dim CONN As New SqlConnection(Connstr)
        CONN.Open()
        Dim command As New SqlCommand(MySql, CONN)
        Dim CS As String = ""

        command.Parameters.AddWithValue("@CompanyID", CompanyID)
        command.Parameters.AddWithValue("@RepoID", RepoID)

        RSData = command.ExecuteReader()
        Dim iCnt As Integer = 0
        Try
            If RSData.HasRows Then
                RSData.Read()
                CS = RSData.GetValue(0).ToString
            Else
                CS = ""
                B = False
                iCnt = 0
            End If
        Catch ex As Exception
            B = False
            RC = False
            RetMsg = ex.Message.ToString
        Finally
            If RSData.IsClosed Then
            Else
                RSData.Close()
            End If
            RSData = Nothing
            If CONN.State = ConnectionState.Open Then
                CONN.Close()
            End If
            CONN.Dispose()
            command.Dispose()
        End Try

        GC.Collect()
        GC.WaitForPendingFinalizers()

        Return CS

    End Function

    Function UpdateExistingConnection(ByVal ConnStr As String, tDict As Dictionary(Of String, String), ByRef RC As Boolean, ByRef RtnMsg As String) As Boolean

        'Dim ENC As New clsEncrypt

        Dim B As Boolean = True
        Dim CN As New SqlConnection
        RtnMsg = ""
        RC = True
        Dim RetMsg As String = ""

        Dim RepoID As String = ""
        Dim CompanyID As String = ""
        Dim SvrName As String = ""
        Dim DBName As String = ""
        Dim InstanceName As String = ""

        RepoID = tDict("RepoID")
        RepoID = ENC.AES256DecryptString(RepoID)

        CompanyID = tDict("CompanyID")
        CompanyID = ENC.AES256DecryptString(CompanyID)

        SvrName = tDict("SvrName")
        SvrName = ENC.AES256DecryptString(SvrName)

        DBName = tDict("DBName")
        DBName = ENC.AES256DecryptString(DBName)

        InstanceName = tDict("InstanceName")
        InstanceName = ENC.AES256DecryptString(InstanceName)


        Dim EncPW As String = tDict("EncPW")
        Dim CS As String = tDict("CS")
        Dim Disabled As String = tDict("Disabled")
        Dim RowID As String = tDict("RowID")
        Dim isThesaurus As String = tDict("isThesaurus")
        Dim CSRepo As String = tDict("CSRepo")
        Dim CSThesaurus As String = tDict("CSThesaurus")
        Dim CSHive As String = tDict("CSHive")
        Dim CSDMALicense As String = tDict("CSDMALicense")
        Dim CSGateWay As String = tDict("CSGateWay")
        Dim CSTDR As String = tDict("CSTDR")
        Dim CSKBase As String = tDict("CSKBase")
        'Dim CreateDate As String = tDict("CreateDate")
        Dim LastModDate As String = tDict("LastModDate")
        Dim SVCFS_Endpoint As String = tDict("SVCFS_Endpoint")
        Dim SVCGateway_Endpoint As String = tDict("SVCGateway_Endpoint")
        Dim SVCCLCArchive_Endpoint As String = tDict("SVCCLCArchive_Endpoint")
        Dim SVCSearch_Endpoint As String = tDict("SVCSearch_Endpoint")
        Dim SVCDownload_Endpoint As String = tDict("SVCDownload_Endpoint")
        Dim SVCFS_CS As String = tDict("SVCFS_CS")
        Dim SVCGateway_CS As String = tDict("SVCGateway_CS")
        Dim SVCSearch_CS As String = tDict("SVCSearch_CS")
        Dim SVCDownload_CS As String = tDict("SVCDownload_CS")
        Dim SVCThesaurus_CS As String = tDict("SVCThesaurus_CS")
        Dim LoginID As String = tDict("LoginID")
        Dim LoginPW As String = tDict("LoginPW")
        Dim ConnTimeout As String = tDict("ConnTimeout")
        Dim ckWinAuth As String = tDict("ckWinAuth")
        LastModDate = DateTime.Now.ToString


        If ckWinAuth.Equals("True") Then
            ckWinAuth = "1"
        Else
            ckWinAuth = "0"
        End If

        If Disabled.Equals("True") Then
            Disabled = "1"
        Else
            Disabled = "0"
        End If

        If isThesaurus.Equals("True") Then
            isThesaurus = "1"
        Else
            isThesaurus = "0"
        End If

        Dim MySql As String = "UPDATE [dbo].[SecureAttach]
                   SET [CompanyID] = @CompanyID
                      ,[EncPW] = @EncPW
                      ,[RepoID] = @RepoID
                      ,[CS] = @CS
                      ,[Disabled] = @Disabled
                      ,[isThesaurus] = @isThesaurus
                      ,[CSRepo] = @CSRepo
                      ,[CSThesaurus] = @CSThesaurus
                      ,[CSHive] = @CSHive
                      ,[CSDMALicense] = @CSDMALicense
                      ,[CSGateWay] = @CSGateWay
                      ,[CSTDR] = @CSTDR
                      ,[CSKBase] = @CSKBase
                      ,[LastModDate] = @LastModDate
                      ,[SVCFS_Endpoint] = @SVCFS_Endpoint
                      ,[SVCGateway_Endpoint] = @SVCGateway_Endpoint
                      ,[SVCCLCArchive_Endpoint] = @SVCCLCArchive_Endpoint
                      ,[SVCSearch_Endpoint] = @SVCSearch_Endpoint
                      ,[SVCDownload_Endpoint] = @SVCDownload_Endpoint
                      ,[SVCFS_CS] = @SVCFS_CS
                      ,[SVCGateway_CS] = @SVCGateway_CS
                      ,[SVCSearch_CS] = @SVCSearch_CS
                      ,[SVCDownload_CS] = @SVCDownload_CS
                      ,[SVCThesaurus_CS] = @SVCThesaurus_CS
                      ,[SvrName] = @SvrName
                      ,[DBName] = @DBName
                      ,[InstanceName] = @InstanceName
                      ,[LoginID] = @LoginID
                      ,[LoginPW] = @LoginPW
                      ,ckWinAuth = @ckWinAuth
                      ,ConnTimeout = @ConnTimeout 
                 WHERE CompanyID = @CompanyID
                          and SvrName = @SvrName
                          and DBName = @DBName"
        'and RepoID = @RepoID"
        If InstanceName.Length > 0 Then
            MySql += " AND InstanceName = @InstanceName"
        Else
            MySql += " And (InstanceName = 'NA' or InstanceName = '' or InstanceName = null)"
        End If

        Try
            B = True
            CN.ConnectionString = ConnStr
            CN.Open()

            Using CN
                Using command As New SqlCommand(MySql, CN)
                    command.CommandType = CommandType.Text
                    command.Parameters.AddWithValue("@CompanyID", CompanyID)
                    command.Parameters.AddWithValue("@EncPW", EncPW)
                    command.Parameters.AddWithValue("@RepoID", RepoID)
                    command.Parameters.AddWithValue("@CS", Cs)
                    command.Parameters.AddWithValue("@Disabled", Disabled)
                    command.Parameters.AddWithValue("@RowID", RowID)
                    command.Parameters.AddWithValue("@isThesaurus", isThesaurus)
                    command.Parameters.AddWithValue("@CSRepo", CSRepo)
                    command.Parameters.AddWithValue("@CSThesaurus", CSThesaurus)
                    command.Parameters.AddWithValue("@CSHive", CSHive)
                    command.Parameters.AddWithValue("@CSDMALicense", CSDMALicense)
                    command.Parameters.AddWithValue("@CSGateWay", CSGateWay)
                    command.Parameters.AddWithValue("@CSTDR", CSTDR)
                    command.Parameters.AddWithValue("@CSKBase", CSKBase)
                    'command.Parameters.AddWithValue("@CreateDate", CreateDate)
                    command.Parameters.AddWithValue("@LastModDate", LastModDate)
                    command.Parameters.AddWithValue("@SVCFS_Endpoint", SVCFS_Endpoint)
                    command.Parameters.AddWithValue("@SVCGateway_Endpoint", SVCGateway_Endpoint)
                    command.Parameters.AddWithValue("@SVCCLCArchive_Endpoint", SVCCLCArchive_Endpoint)
                    command.Parameters.AddWithValue("@SVCSearch_Endpoint", SVCSearch_Endpoint)
                    command.Parameters.AddWithValue("@SVCDownload_Endpoint", SVCDownload_Endpoint)
                    command.Parameters.AddWithValue("@SVCFS_CS", SVCFS_CS)
                    command.Parameters.AddWithValue("@SVCGateway_CS", SVCGateway_CS)
                    command.Parameters.AddWithValue("@SVCSearch_CS", SVCSearch_CS)
                    command.Parameters.AddWithValue("@SVCDownload_CS", SVCDownload_CS)
                    command.Parameters.AddWithValue("@SVCThesaurus_CS", SVCThesaurus_CS)
                    command.Parameters.AddWithValue("@SvrName", SvrName)
                    command.Parameters.AddWithValue("@DBName", DBName)
                    command.Parameters.AddWithValue("@InstanceName", InstanceName)
                    command.Parameters.AddWithValue("@LoginID", LoginID)
                    command.Parameters.AddWithValue("@LoginPW", LoginPW)

                    command.Parameters.AddWithValue("@ckWinAuth", ckWinAuth)
                    command.Parameters.AddWithValue("@ConnTimeout", ConnTimeout)

                    command.ExecuteNonQuery()
                    command.Dispose()
                End Using
            End Using
        Catch ex As Exception
            B = False
            RC = False
            RtnMsg = ex.Message.ToString
        Finally
            CN.Close()
            CN.Dispose()
            GC.Collect()
        End Try

        Return B
    End Function

    Function duplicateEntry(ByVal ConnStr As String, tDict As Dictionary(Of String, String)) As Boolean

        ConnStr = System.Configuration.ConfigurationManager.AppSettings("ECMSecureLogin")
        Dim TS As String = XXI()
        ConnStr = ConnStr.Replace("@@PW@@", TS)

        Dim I As Integer = 0
        Dim ExtensionData As String = ""
        Dim CS As String = ""
        Dim CSDMALicense As String = ""
        Dim CSGateWay As String = ""
        Dim CSHive As String = ""
        Dim CSKBase As String = ""
        Dim CSRepo As String = ""
        Dim CSTDR As String = ""
        Dim CSThesaurus As String = ""
        Dim CompanyID As String = ""
        Dim CreateDate As String = ""
        Dim Disabled As String = ""
        Dim EncPW As String = ""
        Dim LastModDate As String = ""
        Dim RepoID As String = ""
        Dim RowID As String = ""
        Dim SVCCLCArchive_Endpoint As String = ""
        Dim SVCDownload_CS As String = ""
        Dim SVCDownload_Endpoint As String = ""
        Dim SVCFS_CS As String = ""
        Dim SVCFS_Endpoint As String = ""
        Dim SVCGateway_CS As String = ""
        Dim SVCGateway_Endpoint As String = ""
        Dim SVCSearch_CS As String = ""
        Dim SVCSearch_Endpoint As String = ""
        Dim SVCThesaurus_CS As String = ""
        Dim isThesaurus As String = ""

        Dim B As Boolean = True

        Dim S1 As String = "insert into SecureAttach (" + vbCrLf

        Dim colname As String = ""
        For Each colname In tDict.Keys
            If colname = "ExtensionData" Then
                ExtensionData = tDict("ExtensionData")
            End If
            If colname = "CS" Then
                CS = tDict("CS")
            End If
            If colname = "CSDMALicense" Then
                CSDMALicense = tDict("CSDMALicense")
            End If
            If colname = "CSGateWay" Then
                CSGateWay = tDict("CSGateWay")
            End If
            If colname = "CSHive" Then
                CSHive = tDict("CSHive")
            End If
            If colname = "CSKBase" Then
                CSKBase = tDict("CSKBase")
            End If
            If colname = "CSRepo" Then
                CSRepo = tDict("CSRepo")
            End If
            If colname = "CSTDR" Then
                CSTDR = tDict("CSTDR")
            End If
            If colname = "CSThesaurus" Then
                CSThesaurus = tDict("CSThesaurus")
            End If
            If colname = "CompanyID" Then
                CompanyID = tDict("CompanyID")
            End If
            If colname = "CreateDate" Then
                CreateDate =  DateAndTime.Today.ToString()
            End If
            If colname = "Disabled" Then
                Disabled = tDict("Disabled")
            End If
            If colname = "EncPW" Then
                EncPW = tDict("EncPW")
            End If
            If colname = "LastModDate" Then
                LastModDate = DateAndTime.Today.ToString()
            End If
            If colname = "RepoID" Then
                RepoID = tDict("RepoID")
                RepoID = RepoID + "_Copy"
            End If
            If colname = "RowID" Then
                RowID = tDict("RowID")
            End If
            If colname = "SVCCLCArchive_Endpoint" Then
                SVCCLCArchive_Endpoint = tDict("SVCCLCArchive_Endpoint")
            End If
            If colname = "SVCDownload_CS" Then
                SVCDownload_CS = tDict("SVCDownload_CS")
            End If
            If colname = "SVCDownload_Endpoint" Then
                SVCDownload_Endpoint = tDict("SVCDownload_Endpoint")
            End If
            If colname = "SVCFS_CS" Then
                SVCFS_CS = tDict("SVCFS_CS")
            End If
            If colname = "SVCFS_Endpoint" Then
                SVCFS_Endpoint = tDict("SVCFS_Endpoint")
            End If
            If colname = "SVCGateway_CS" Then
                SVCGateway_CS = tDict("SVCGateway_CS")
            End If
            If colname = "SVCGateway_Endpoint" Then
                SVCGateway_Endpoint = tDict("SVCGateway_Endpoint")
            End If
            If colname = "SVCSearch_CS" Then
                SVCSearch_CS = tDict("SVCSearch_CS")
            End If
            If colname = "SVCSearch_Endpoint" Then
                SVCSearch_Endpoint = tDict("SVCSearch_Endpoint")
            End If
            If colname = "SVCThesaurus_CS" Then
                SVCThesaurus_CS = tDict("SVCThesaurus_CS")
            End If
            If colname = "isThesaurus" Then
                isThesaurus = tDict("isThesaurus")
            End If
        Next

        Dim MySql As String = ""
        MySql = "insert into SecureAttach ("
        'MySql += "ExtensionData,"
        MySql += "CS,"
        MySql += "CSDMALicense,"
        MySql += "CSGateWay,"
        MySql += "CSHive,"
        MySql += "CSKBase,"
        MySql += "CSRepo,"
        MySql += "CSTDR,"
        MySql += "CSThesaurus,"
        MySql += "CompanyID,"
        MySql += "CreateDate,"
        MySql += "Disabled,"
        MySql += "EncPW,"
        MySql += "LastModDate,"
        MySql += "RepoID,"
        'MySql += "RowID,"
        MySql += "SVCCLCArchive_Endpoint,"
        MySql += "SVCDownload_CS,"
        MySql += "SVCDownload_Endpoint,"
        MySql += "SVCFS_CS,"
        MySql += "SVCFS_Endpoint,"
        MySql += "SVCGateway_CS,"
        MySql += "SVCGateway_Endpoint,"
        MySql += "SVCSearch_CS,"
        MySql += "SVCSearch_Endpoint,"
        MySql += "SVCThesaurus_CS,"
        MySql += "isThesaurus"
        MySql += ")" + vbCrLf
        MySql += " values ("
        'MySql += "@ExtensionData,"
        MySql += "@CS,"
        MySql += "@CSDMALicense,"
        MySql += "@CSGateWay,"
        MySql += "@CSHive,"
        MySql += "@CSKBase,"
        MySql += "@CSRepo,"
        MySql += "@CSTDR,"
        MySql += "@CSThesaurus,"
        MySql += "@CompanyID,"
        MySql += "@CreateDate,"
        MySql += "@Disabled,"
        MySql += "@EncPW,"
        MySql += "@LastModDate,"
        MySql += "@RepoID,"
        'MySql += "@RowID,"
        MySql += "@SVCCLCArchive_Endpoint,"
        MySql += "@SVCDownload_CS,"
        MySql += "@SVCDownload_Endpoint,"
        MySql += "@SVCFS_CS,"
        MySql += "@SVCFS_Endpoint,"
        MySql += "@SVCGateway_CS,"
        MySql += "@SVCGateway_Endpoint,"
        MySql += "@SVCSearch_CS,"
        MySql += "@SVCSearch_Endpoint,"
        MySql += "@SVCThesaurus_CS,"
        MySql += "@isThesaurus"
        MySql += ")"

        Dim NewCN As New SqlConnection(ConnStr)
        NewCN.Open()
        Dim command As New SqlCommand(MySql, NewCN)

        Try
            Using NewCN
                Using command
                    command.CommandType = CommandType.Text

                    'command.Parameters.AddWithValue("@ExtensionData", ExtensionData)
                    command.Parameters.AddWithValue("@CS", CS)
                    command.Parameters.AddWithValue("@CSDMALicense", CSDMALicense)
                    command.Parameters.AddWithValue("@CSGateWay", CSGateWay)
                    command.Parameters.AddWithValue("@CSHive", CSHive)
                    command.Parameters.AddWithValue("@CSKBase", CSKBase)
                    command.Parameters.AddWithValue("@CSRepo", CSRepo)
                    command.Parameters.AddWithValue("@CSTDR", CSTDR)
                    command.Parameters.AddWithValue("@CSThesaurus", CSThesaurus)
                    command.Parameters.AddWithValue("@CompanyID", CompanyID)
                    command.Parameters.AddWithValue("@CreateDate", CreateDate)
                    command.Parameters.AddWithValue("@Disabled", Disabled)
                    command.Parameters.AddWithValue("@EncPW", EncPW)
                    command.Parameters.AddWithValue("@LastModDate", LastModDate)
                    command.Parameters.AddWithValue("@RepoID", RepoID)
                    'command.Parameters.AddWithValue("@RowID", RowID)
                    command.Parameters.AddWithValue("@SVCCLCArchive_Endpoint", SVCCLCArchive_Endpoint)
                    command.Parameters.AddWithValue("@SVCDownload_CS", SVCDownload_CS)
                    command.Parameters.AddWithValue("@SVCDownload_Endpoint", SVCDownload_Endpoint)
                    command.Parameters.AddWithValue("@SVCFS_CS", SVCFS_CS)
                    command.Parameters.AddWithValue("@SVCFS_Endpoint", SVCFS_Endpoint)
                    command.Parameters.AddWithValue("@SVCGateway_CS", SVCGateway_CS)
                    command.Parameters.AddWithValue("@SVCGateway_Endpoint", SVCGateway_Endpoint)
                    command.Parameters.AddWithValue("@SVCSearch_CS", SVCSearch_CS)
                    command.Parameters.AddWithValue("@SVCSearch_Endpoint", SVCSearch_Endpoint)
                    command.Parameters.AddWithValue("@SVCThesaurus_CS", SVCThesaurus_CS)
                    command.Parameters.AddWithValue("@isThesaurus", isThesaurus)

                    command.ExecuteNonQuery()
                    'command.Dispose()
                End Using
            End Using
        Catch ex As Exception
            B = False
        Finally
            If NewCN.State = ConnectionState.Open Then
                NewCN.Close()
                NewCN.Dispose()
            End If
            GC.Collect()
        End Try

        Return B
    End Function

End Class