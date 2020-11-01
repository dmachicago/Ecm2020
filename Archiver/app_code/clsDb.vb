Imports System.Data.SqlClient

''' <summary>
''' This is the database class for the thesaurus developed and used by ECM Library developers. It is
''' copyrighted and confidential as this is critical to our products uniqueness. I promise you, if
''' you are reading this code without our WRITTEN permission, I will find you , I will hunt you down,
''' and I will do my very best to completely and utterly DESTROY YOU - count on it.
''' </summary>
''' <remarks></remarks>
Public Class clsDb
    Dim DMA As New clsDma
    Dim LOG As New clsLogging
    Dim UTIL As New clsUtility

    Dim ddebug As Boolean = False
    Dim TrexConnection As New SqlConnection
    Dim ThesaurusConnectionString As String = ""
    Dim EcmLibConnectionString As String = ""

    Public Sub setEcmLibConnStr()
        Dim bUseConfig As Boolean = True
        Dim S As String = ""
        S = My.Settings("UserDefaultConnString")
        If S.Equals("?") Then
            S = System.Configuration.ConfigurationManager.AppSettings("ECMREPO")
        End If
        'setConnectionStringTimeout(S)
        'S = ENC.AES256DecryptString(S)
        EcmLibConnectionString = S
    End Sub

    Public Function ExecuteSqlNewConn(ByVal sql As String, ByVal NewConnectionStr As String) As Boolean
        Try
            Dim rc As Boolean = False

            Dim CN As New SqlConnection(NewConnectionStr)
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
                        MessageBox.Show("It appears this user has DATA within the repository associated to them and cannot be deleted." + vbCrLf + vbCrLf + ex.Message)
                    ElseIf InStr(ex.Message, "duplicate key row", CompareMethod.Text) > 0 Then
                        'log.WriteToArchiveLog("clsDatabaseARCH : ExecuteSqlNewConn : 1464 : " + ex.Message)
                        'log.WriteToArchiveLog("clsDatabaseARCH : ExecuteSqlNewConn : 1408 : " + ex.Message)
                        'log.WriteToArchiveLog("clsDatabaseARCH : ExecuteSqlNewConn : 1411 : " + ex.Message)
                        Return True
                    Else
                        'messagebox.show("Execute SQL: " + ex.Message + vbCrLf + "Please review the trace log." + vbCrLf + sql)
                        If ddebug Then Clipboard.SetText(sql)
                    End If
                    'xTrace(0, "ExecuteSqlNoTx: ", "-----------------------")
                    'xTrace(1, "ExecuteSqlNoTx: ", ex.Message.ToString)
                    If ddebug Then Debug.Print(ex.Message.ToString)
                    'xTrace(2, "ExecuteSqlNoTx: ", ex.StackTrace.ToString)
                    'xTrace(3, "ExecuteSqlNoTx: ", Mid(sql, 1, 2000))
                End Try
            End Using

            If CN.State = ConnectionState.Open Then
                CN.Close()
            End If
            CN = Nothing
            dbCmd = Nothing
            Return rc
        Catch ex As Exception
            'xTrace(9914, "ExecuteSqlNewConn", "ExecuteSqlNewConn Failed", ex)
            MessageBox.Show(ex.Message)
            Return False
        End Try

    End Function

    Public Function SqlQry(ByVal sql As String) As SqlDataReader
        ''Session("ActiveError") = False
        Dim ddebug As Boolean = True
        Dim queryString As String = sql
        Dim rc As Boolean = False
        Dim rsDataQry As SqlDataReader = Nothing
        CkConn()
        Dim command As New SqlCommand(sql, TrexConnection)
        Try
            rsDataQry = command.ExecuteReader()
        Catch ex As Exception
            LOG.WriteToArchiveLog("clsDB : SqlQry : 1319db : " + ex.Message.ToString + vbCrLf + sql)
        End Try
        command.Dispose()
        command = Nothing
        Return rsDataQry
    End Function

    Public Function getDefaultThesaurus() As String
        'Dim EcmLibConnectionString As String = ""
        setEcmLibConnStr()
        Dim DefaultThesaurus As String = ""
        Dim s As String = ""

        Dim EcmConn As New SqlConnection(EcmLibConnectionString)
        If EcmConn.State = ConnectionState.Closed Then
            EcmConn.Open()
        End If

        Try
            Dim tQuery As String = ""
            s = "Select [SysParmVal] FROM [SystemParms] where [SysParm] = 'Default Thesaurus' "
            Using TrexConnection
                Dim command As New SqlCommand(s, EcmConn)
                Dim RSData As SqlDataReader = Nothing
                RSData = SqlQry(s)
                RSData.Read()
                DefaultThesaurus = RSData.GetValue(0).ToString
                RSData.Close()
                RSData = Nothing
                command.Connection.Close()
                command = Nothing
            End Using
        Catch ex As Exception
            'xTrace(12335, "clsDataBase:iGetRowCount", ex.Message)
            'messagebox.show("Error 3932.11: " + ex.Message)
            If ddebug Then Debug.Print("Error 3932.11: CountOfThesauri " + ex.Message)
            Console.WriteLine("Error 3932.11: getDefaultThesaurus" + ex.Message)
            DefaultThesaurus = ""
            MessageBox.Show("Check the sql error log")
            LOG.WriteToArchiveLog("ERROR clsDB : getDefaultThesaurus : 100a : " + EcmLibConnectionString)
            LOG.WriteToArchiveLog("clsDB : getDefaultThesaurus : 100b : " + ex.Message + vbCrLf + s)
            DefaultThesaurus = "Roget"
        End Try
        If Not EcmConn.State = ConnectionState.Closed Then
            EcmConn.Close()
        End If
        EcmConn = Nothing
        GC.Collect()
        Return DefaultThesaurus
    End Function

    Function ThesaurusExist() As Boolean

        Dim I As Integer = getCountOfThesauri()
        If I <= 0 Then
            Dim CS As String = getThesaurusConnectionString()
            Dim InsertSql As String = "INSERT INTO [dbo].[Thesaurus] ([ThesaurusName],[ThesaurusID]) VALUES ('Roget','D7A21DA7-0818-4B75-8BBA-D0339D3E1D54')"
            Dim B As Boolean = ExecuteSqlNewConn(InsertSql, CS)
            If Not B Then
                LOG.WriteToArchiveLog("ERROR :ThesaurusExist - Failed to add default Thesaurus.")
            End If
        End If
    End Function

    Function getCountOfThesauri() As Integer
        Dim cnt As Integer = -1
        Dim s As String = ""

        Try
            Dim tQuery As String = ""
            s = "Select count(*) FROM [Thesaurus] "
            Using TrexConnection

                Dim RSData As SqlDataReader = Nothing
                Dim CS As String = ThesaurusConnectionString : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : RSData = command.ExecuteReader()
                RSData.Read()
                cnt = RSData.GetInt32(0)
                RSData.Close()
                RSData = Nothing
                command.Connection.Close()
                command = Nothing
            End Using
        Catch ex As Exception
            'xTrace(12335, "clsDataBase:iGetRowCount", ex.Message)
            'messagebox.show("Error 3932.11: " + ex.Message)
            If ddebug Then Debug.Print("Error 3932.11: CountOfThesauri " + ex.Message)
            Console.WriteLine("Error 3932.11: CountOfThesauri" + ex.Message)
            cnt = 0
            LOG.WriteToArchiveLog("clsDB : CountOfThesauri : 100 : " + ex.Message)
        End Try

        Return cnt

    End Function

    Public Function iGetRowCount(ByVal TBL As String, ByVal WhereClause As String) As Integer

        Dim cnt As Integer = -1
        Dim s As String = ""

        Try
            Dim tQuery As String = ""
            s = "Select count(*) as CNT from " + TBL + " " + WhereClause
            Using TrexConnection

                Dim command As New SqlCommand(s, TrexConnection)
                Dim RSData As SqlDataReader = Nothing
                RSData = command.ExecuteReader()

                RSData.Read()
                cnt = RSData.GetInt32(0)
                RSData.Close()
                RSData = Nothing
                command.Connection.Close()
                command = Nothing
            End Using
        Catch ex As Exception
            'xTrace(12335, "clsDataBase:iGetRowCount", ex.Message)
            'messagebox.show("Error 3932.11: " + ex.Message)
            If ddebug Then Debug.Print("Error 3932.11: " + ex.Message)
            Console.WriteLine("Error 3932.11: " + ex.Message)
            cnt = 0
            LOG.WriteToArchiveLog("clsDatabaseARCH : iGetRowCount : 4010 : " + ex.Message)
        End Try

        Return cnt

    End Function

    Public Function GetRowByKey(ByVal TBL As String, ByVal WC As String) As SqlDataReader
        Try
            Dim Auth As String = ""
            Dim s As String = "Select * from " + TBL + " " + WC
            Dim rsData As SqlDataReader = Nothing
            Dim b As Boolean = False
            Dim CS As String = ThesaurusConnectionString : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader()
            If rsData.HasRows Then
                rsData.Read()
                Auth = rsData.GetValue(0).ToString
                Return rsData
            Else
                Return Nothing
            End If
        Catch ex As Exception
            'xTrace(12330, "clsDataBase:GetRowByKey", ex.Message)
            If ddebug Then Debug.Print(ex.Message)
            LOG.WriteToArchiveLog("clsDatabaseARCH : GetRowByKey : 3963 : " + ex.Message)
            LOG.WriteToArchiveLog("clsDatabaseARCH : GetRowByKey : 3931 : " + ex.Message)
            LOG.WriteToArchiveLog("clsDatabaseARCH : GetRowByKey : 3945 : " + ex.Message)
            Return Nothing
        End Try

    End Function

    Public Sub CkConn()
        Dim S As String = ""
        If TrexConnection Is Nothing Then
            Try
                TrexConnection = New SqlConnection
                TrexConnection.ConnectionString = getThesaurusConnectionString()
                S = getThesaurusConnectionString()
                TrexConnection.Open()
            Catch ex As Exception
                LOG.WriteToArchiveLog("clsDatabaseARCH : CkConn : 338 : " + ex.Message)
            End Try
        End If
        If TrexConnection.State = Data.ConnectionState.Closed Then
            Try
                TrexConnection.ConnectionString = getThesaurusConnectionString()
                S = getThesaurusConnectionString()
                TrexConnection.Open()
            Catch ex As Exception
                LOG.WriteToArchiveLog("clsDatabaseARCH : CkConn : 348.2 : " + ex.Message + vbCrLf + S)
            End Try
        End If
    End Sub

    Public Sub setConnThesaurusStr()
        Dim bUseConfig As Boolean = True
        Dim S As String = ""
        Try
            LOG.WriteToInstallLog("INFO: clsDb:setConnThesaurusStr 100: " + My.Settings("UserThesaurusConnString").ToString)
            If My.Settings("UserThesaurusConnString").Equals("?") Then
                S = setThesaurusConnStr()
                LOG.WriteToInstallLog("INFO: clsDb:setConnThesaurusStr 200: " + S)
                My.Settings("UserThesaurusConnString") = S
                LOG.WriteToInstallLog("INFO: clsDb:setConnThesaurusStr 300: " + My.Settings("UserThesaurusConnString").ToString)
            Else
                S = My.Settings("UserThesaurusConnString")
                LOG.WriteToInstallLog("INFO: clsDb:setConnThesaurusStr 400: " + My.Settings("UserThesaurusConnString").ToString)
            End If
            ThesaurusConnectionString = S
        Catch ex As Exception
            MessageBox.Show(ex.Message)
        End Try

        'S = ENC.AES256DecryptString(S)
        ThesaurusConnectionString = S
        LOG.WriteToInstallLog("INFO: clsDb:setConnThesaurusStr 500: " + S)

    End Sub

    Public Function getThesaurusConnectionString() As String
        If ThesaurusConnectionString = "" Then
            setConnThesaurusStr()
        End If
        Return ThesaurusConnectionString
    End Function

    Function getClassName(ByVal ClassonomyName As String, ByVal Token As String) As String
        Dim S As String = ""
        S = S + " SELECT GroupID"
        S = S + " FROM [ECM.Thesaurus].[dbo].[ClassonomyData]"
        S = S + " where [CalssonomyName] = '" + ClassonomyName + "'"
        S = S + " and [Token] = '" + Token + "'"
        Dim ClassID As String = ""
        Dim rsData As SqlDataReader = Nothing

        Try
            Dim Auth As String = ""
            Dim b As Boolean = False
            Dim CS As String = ThesaurusConnectionString : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(S, CONN) : rsData = command.ExecuteReader()
            If rsData.HasRows Then
                rsData.Read()
                ClassID = rsData.GetValue(0).ToString
            Else
                ClassID = ""
            End If
        Catch ex As Exception
            'xTrace(12330, "clsDataBase:GetRowByKey", ex.Message)
            If ddebug Then Debug.Print(ex.Message)
            LOG.WriteToArchiveLog("clsDatabaseARCH : getClassName : 3963 : " + ex.Message)
            Return Nothing
        End Try
        If rsData.IsClosed Then
        Else
            rsData.Close()
        End If
        rsData = Nothing
        Return ClassID
    End Function

    Function getThesaurusID(ByVal ThesaurusName As String) As String

        If ThesaurusName.Trim.Length = 0 Then
            ThesaurusName = getDefaultThesaurus()
        End If

        Dim S As String = ""
        S = S + " SELECT [ThesaurusID] FROM [Thesaurus] where [ThesaurusName] = '" + ThesaurusName + "'"
        Dim TID As String = ""
        Dim rsData As SqlDataReader = Nothing

        Try
            Dim Auth As String = ""
            Dim b As Boolean = False
            Dim CS As String = getThesaurusConnectionString()
            Dim CONN As New SqlConnection(CS)
            CONN.Open()
            Dim command As New SqlCommand(S, CONN)
            rsData = command.ExecuteReader()
            If rsData.HasRows Then
                rsData.Read()
                TID = rsData.GetValue(0).ToString
            Else
                MessageBox.Show("Did not find the Thesaurus listed in the DBARCH - aborting: " + ThesaurusName + ", so the query will continue without a thesaurus.")
                LOG.WriteToArchiveLog("clsDatabaseARCH : getThesaurusID : ERROR 3963 : " + vbCrLf + S)
            End If
        Catch ex As Exception
            'xTrace(12330, "clsDataBase:GetRowByKey", ex.Message)
            If ddebug Then Debug.Print(ex.Message)
            LOG.WriteToArchiveLog("clsDatabaseARCH : getThesaurusID : 3963 : " + ex.Message)
            Return Nothing
        End Try
        If rsData.IsClosed Then
        Else
            rsData.Close()
        End If
        rsData = Nothing
        Return TID
    End Function

    Function getThesaurusNumberID(ByVal ThesaurusName As String) As Integer

        Dim S As String = ""
        S = S + " SELECT [ThesaurusSeqID] FROM [Thesaurus] where [ThesaurusName] = '" + ThesaurusName + "'"
        Dim TID As Integer = -1
        Dim rsData As SqlDataReader = Nothing

        Try
            Dim Auth As String = ""

            Dim b As Boolean = False
            Dim CS As String = ThesaurusConnectionString : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(S, CONN) : rsData = command.ExecuteReader()
            If rsData.HasRows Then
                rsData.Read()
                TID = rsData.GetInt32(0)
            Else
                MessageBox.Show("Did not find the Thesaurus listed in the DBARCH - aborting: " + ThesaurusName)
                End
            End If
        Catch ex As Exception
            'xTrace(12330, "clsDataBase:GetRowByKey", ex.Message)
            If ddebug Then Debug.Print(ex.Message)
            LOG.WriteToArchiveLog("clsDatabaseARCH : getClassName : 3963 : " + ex.Message)
            Return Nothing
        End Try
        If rsData.IsClosed Then
        Else
            rsData.Close()
        End If
        rsData = Nothing
        Return TID
    End Function

    Function InsertChildWord(ByVal RootID As String, ByVal Token As String, ByVal TokenID As Integer) As Boolean
        Dim ConnStr As String = getThesaurusConnectionString()
        Dim B As Boolean = False
        Dim S As String = ""
        Try
            S = S + " INSERT INTO [RootChildren]"
            S = S + " ([Token]"
            S = S + " ,[TokenID]"
            S = S + " ,[RootID])"
            S = S + " VALUES"
            S = S + " ('" + Token + "'"
            S = S + " ," & TokenID
            S = S + " ,'" + RootID + "')"

            B = Me.ExecuteSqlNewConn(S, ConnStr)
        Catch ex As Exception
            B = False
            Console.WriteLine(ex.Message)
            MessageBox.Show(ex.Message)
        End Try

        Return B

    End Function

    Function RootWordExists(ByVal RootToken As String) As Boolean
        Dim ConnStr As String = getThesaurusConnectionString()
        Dim B As Boolean = False
        Dim rsData As SqlDataReader = Nothing
        Dim iCnt As Integer = -1
        Dim S As String = ""
        Try
            S = "Select COUNT(*) FROM [Rootword] WHERE [RootToken] = '" + RootToken + "'"
            Try
                Dim CS As String = ThesaurusConnectionString : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(S, CONN) : rsData = command.ExecuteReader()
                If rsData.HasRows Then
                    rsData.Read()
                    iCnt = rsData.GetInt32(0)
                End If
            Catch ex As Exception
                'xTrace(12330, "clsDataBase:GetRowByKey", ex.Message)
                If ddebug Then Debug.Print(ex.Message)
                LOG.WriteToArchiveLog("clsDatabaseARCH : getClassName : 3963 : " + ex.Message)
                iCnt = -1
            End Try
            If rsData.IsClosed Then
            Else
                rsData.Close()
            End If
            rsData = Nothing
            Return iCnt
        Catch ex As Exception
            B = False
            Console.WriteLine(ex.Message)
            MessageBox.Show(ex.Message)
        End Try
        If iCnt > 0 Then
            B = True
        Else
            B = False
        End If
        Return B

    End Function

    Function AddToken(ByVal Token As String) As Integer
        Dim TokenID As Integer = -1
        TokenID = getTokenID(Token)
        If TokenID > 0 Then
            Return TokenID
        End If
        Dim S As String = ""

    End Function

    Function getTokenID(ByVal Token As String) As Integer
        Token = UTIL.RemoveSingleQuotes(Token)
        Dim ID As Integer = 0
        Dim S As String = "Select [TokenID] FROM [Tokens] where [Token] = '" + Token + "'"
        Dim ConnStr As String = getThesaurusConnectionString()
        Dim B As Boolean = False
        Dim rsData As SqlDataReader = Nothing
        Dim iCnt As Integer = -1
        Try
            Dim CS As String = ThesaurusConnectionString : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(S, CONN) : rsData = command.ExecuteReader()
            If rsData.HasRows Then
                rsData.Read()
                iCnt = rsData.GetInt32(0)
            End If
        Catch ex As Exception
            'xTrace(12330, "clsDataBase:GetRowByKey", ex.Message)
            If ddebug Then Debug.Print(ex.Message)
            LOG.WriteToArchiveLog("clsDatabaseARCH : getTokenID : 3963 : " + ex.Message)
            iCnt = -1
        End Try
        If rsData.IsClosed Then
        Else
            rsData.Close()
        End If
        rsData = Nothing
        Return iCnt
        Return iCnt

    End Function

    Function ChildWordExists(ByVal RootID As String, ByVal Token As String, ByVal TokenID As Integer) As Boolean
        Dim ConnStr As String = getThesaurusConnectionString()
        Dim B As Boolean = False
        Dim rsData As SqlDataReader = Nothing
        Dim iCnt As Integer = -1
        Dim S As String = ""
        Try
            S = S + "Select count(*)"
            S = S + "FROM [RootChildren] "
            S = S + "where "
            S = S + "[Token] = '" + Token + "'"
            S = S + "and [TokenID] = " + TokenID.ToString
            S = S + "and [RootID] = '" + RootID + "'"
            Try
                Dim CS As String = ThesaurusConnectionString : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(S, CONN) : rsData = command.ExecuteReader()
                If rsData.HasRows Then
                    rsData.Read()
                    iCnt = rsData.GetInt32(0)
                End If
            Catch ex As Exception
                'xTrace(12330, "clsDataBase:GetRowByKey", ex.Message)
                If ddebug Then Debug.Print(ex.Message)
                LOG.WriteToArchiveLog("clsDatabaseARCH : getClassName : 3963 : " + ex.Message)
                iCnt = -1
            End Try
            If rsData.IsClosed Then
            Else
                rsData.Close()
            End If
            rsData = Nothing
            Return iCnt
        Catch ex As Exception
            B = False
            Console.WriteLine(ex.Message)
            MessageBox.Show(ex.Message)
        End Try
        If iCnt > 0 Then
            B = True
        Else
            B = False
        End If
        Return B

    End Function

    Function InsertRootWord(ByVal ThesaurusID As String, ByVal RootToken As String, ByVal RootID As String) As Boolean
        Dim ConnStr As String = getThesaurusConnectionString()
        Dim B As Boolean = False
        Dim S As String = ""
        Try
            S = S + " INSERT INTO [ECM.Thesaurus].[dbo].[Rootword]"
            S = S + " (ThesaurusID, [RootToken]"
            S = S + " ,[RootID])"
            S = S + " VALUES "
            S = S + " ('" + ThesaurusID + "'"
            S = S + " ,'" + RootToken + "'"
            S = S + " ,'" + RootID + "')"
            B = Me.ExecuteSqlNewConn(S, ConnStr)
        Catch ex As Exception
            B = False
            Console.WriteLine(ex.Message)
            MessageBox.Show(ex.Message)
        End Try

        Return B

    End Function

    Function getSynonyms(ByVal ThesaurusID As String, ByVal Token As String, ByRef lbSynonyms As ListBox) As String
        Dim ConnStr As String = getThesaurusConnectionString()
        Dim B As Boolean = False
        Dim rsData As SqlDataReader = Nothing
        Dim iCnt As Integer = -1
        Dim Synonyms As String = ""

        lbSynonyms.Items.Clear()

        Dim S As String = " SELECT     RootChildren.Token"
        S = S + " FROM       Rootword INNER JOIN"
        S = S + " RootChildren ON Rootword.RootID = RootChildren.RootID"
        S = S + " where  Rootword.RootToken = '" + Token + "'  and    ThesaurusID  = 'D7A21DA7-0818-4B75-8BBA-D0339D3E1D54'"
        S = S + " order by RootChildren.Token"

        Dim rsSynonyms As SqlDataReader = Nothing
        'rsSynonyms = SqlQryNo'Session(S)
        rsSynonyms = SqlQry(S)
        If rsSynonyms.HasRows Then
            Do While rsSynonyms.Read()
                Synonyms += rsSynonyms.GetValue(0).ToString + ","
                lbSynonyms.Items.Add(rsSynonyms.GetValue(0).ToString)
            Loop
        End If
        If Synonyms.Trim.Length Then
            Synonyms = Mid(Synonyms, 1, Synonyms.Length - 1)
        End If
        rsSynonyms.Close()
        rsSynonyms = Nothing

        Return Synonyms
    End Function

    Sub getSynonyms(ByVal ThesaurusID As String, ByVal Token As String, ByRef SynonymsArray As ArrayList, ByVal AppendToList As Boolean)
        Dim ConnStr As String = getThesaurusConnectionString()
        Dim B As Boolean = False
        Dim rsData As SqlDataReader = Nothing
        Dim iCnt As Integer = -1
        Dim Synonym As String = ""

        If AppendToList = False Then
            SynonymsArray.Clear()
        End If

        Dim S As String = " SELECT     RootChildren.Token"
        S = S + " FROM       Rootword INNER JOIN"
        S = S + " RootChildren ON Rootword.RootID = RootChildren.RootID"
        S = S + " where  Rootword.RootToken = '" + Token + "'  and    ThesaurusID  = '" + ThesaurusID + "'"
        S = S + " order by RootChildren.Token"

        Dim rsSynonyms As SqlDataReader = Nothing
        'rsSynonyms = SqlQryNo'Session(S)
        rsSynonyms = SqlQry(S)
        If rsSynonyms.HasRows Then
            Do While rsSynonyms.Read()
                Synonym = rsSynonyms.GetValue(0).ToString.Trim
                Console.WriteLine(Synonym)
                If Not SynonymsArray.Contains(Synonym) Then
                    SynonymsArray.Add(Synonym)
                End If

            Loop
        End If
        'If Synonyms .Trim.Length Then
        '    Synonyms  = Mid(Synonyms , 1, Synonyms .Length - 1)
        'End If
        rsSynonyms.Close()
        rsSynonyms = Nothing

    End Sub

    Sub getAllTokens(ByRef LB As ListBox, ByVal ThesaurusID As String)
        LB.Items.Clear()
        Dim ConnStr As String = getThesaurusConnectionString()
        Dim B As Boolean = False
        Dim rsData As SqlDataReader = Nothing
        Dim iCnt As Integer = -1
        Dim Synonyms As String = ""

        Dim S As String = " select RootToken from Rootword order by RootToken "
        Dim rsSynonyms As SqlDataReader = Nothing
        'rsSynonyms = SqlQryNo'Session(S)
        rsSynonyms = SqlQry(S)
        If rsSynonyms.HasRows Then
            Do While rsSynonyms.Read()
                Synonyms = rsSynonyms.GetValue(0).ToString.Trim
                LB.Items.Add(Synonyms)
            Loop
        End If
        rsSynonyms.Close()
        rsSynonyms = Nothing
    End Sub

    Sub PopulateComboBox(ByRef CB As ComboBox, ByVal TblColName As String, ByVal S As String)

        Dim TryAgain As Boolean = False
RETRY1:
        Dim ConnStr As String = getThesaurusConnectionString()
        Dim tConn As New SqlConnection(ConnStr)
        Dim DA As New SqlDataAdapter(S, tConn)
        Dim DS As New DataSet

        Try

            If tConn.State = ConnectionState.Closed Then
                tConn.Open()
            End If

            DA.Fill(DS, TblColName)

            'Create and populate the DataTable to bind to the ComboBox:
            Dim dt As New DataTable
            dt.Columns.Add(TblColName, GetType(System.String))

            ' Populate the DataTable to bind to the Combobox.
            Dim drDSRow As DataRow
            Dim drNewRow As DataRow
            Dim iRowCnt As Integer = 0
            For Each drDSRow In DS.Tables(TblColName).Rows()
                drNewRow = dt.NewRow()
                drNewRow(TblColName) = drDSRow(TblColName)
                dt.Rows.Add(drNewRow)
                iRowCnt += 1
                CB.Items.Add(drDSRow(0).ToString)
            Next
            If iRowCnt = 0 Then
                Dim SS As String = "insert into Thesaurus (ThesaurusName, ThesaurusID) values ('Roget', 'D7A21DA7-0818-4B75-8BBA-D0339D3E1D54')"
                Dim BB As Boolean = ExecuteSqlNewConn(SS, ConnStr)
                MessageBox.Show("Please close and reopen the Search Assistant screen - there is a connectivity issue with the thesaurus.")
                Return
            End If
            'Bind the DataTable to the ComboBox by setting the Combobox's DataSource property to the DataTable. To display the "Description" column in the Combobox's list, set the Combobox's DisplayMember property to the name of column. Likewise, to use the "Code" column as the value of an item in the Combobox set the ValueMember property.
            CB.DropDownStyle = ComboBoxStyle.DropDown
            'CB.DataSource = dt
            CB.DisplayMember = TblColName
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
            If ddebug Then Debug.Print("Error 2194.23: " + ex.Message)
            LOG.WriteToArchiveLog("clsDB : PopulateComboBox : 1000 : " + ex.Message + vbCrLf + S + vbCrLf + ConnStr)
            If InStr(ex.Message, "XX", CompareMethod.Text) And TryAgain = False Then
                My.Settings("UserThesaurusConnString") = "?"
                LOG.WriteToArchiveLog("clsDB : PopulateComboBox : 1000a : try again using APP Config.")
                TryAgain = True
                GoTo RETRY1
            End If
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

End Class