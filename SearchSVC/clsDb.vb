' ***********************************************************************
' Assembly         : EcmCloudWcf.Web
' Author           : wdale
' Created          : 07-16-2020
'
' Last Modified By : wdale
' Last Modified On : 07-16-2020
' ***********************************************************************
' <copyright file="clsDb.vb" company="ECM Library,LLC">
'     Copyright @ECM Library 2020 all rights reserved.
' </copyright>
' <summary></summary>
' ***********************************************************************
Imports ECMEncryption

''' <summary>
''' This is the database class for the thesaurus developed and used by ECM Library developers. It is
''' copyrighted and confidential as this is critical to our product's uniqueness. I promise you, if
''' you are reading this code without our WRITTEN permission, I will find you , I will hunt you down,
''' and I will do my very best to completely and utterly DESTROY YOU - count on it.
''' </summary>
Public Class clsDb

    ''' <summary>
    ''' The enc
    ''' </summary>
    Dim ENC As New ECMEncrypt
    ''' <summary>
    ''' The dma
    ''' </summary>
    Dim DMA As New clsDmaSVR
    ''' <summary>
    ''' The log
    ''' </summary>
    Dim LOG As New clsLogging
    ''' <summary>
    ''' The utility
    ''' </summary>
    Dim UTIL As New clsUtilitySVR

    ''' <summary>
    ''' The d debug
    ''' </summary>
    Dim dDebug As Boolean = False
    ''' <summary>
    ''' The trex connection
    ''' </summary>
    Dim TrexConnection As New SqlConnection
    ''' <summary>
    ''' The thesaurus connection string
    ''' </summary>
    Dim ThesaurusConnectionString As String = ""
    ''' <summary>
    ''' The ecm library connection string
    ''' </summary>
    Dim EcmLibConnectionString As String = ""

    ''' <summary>
    ''' Sets the ecm library connection string.
    ''' </summary>
    Public Sub setEcmLibConnStr()
        Dim bUseConfig As Boolean = True
        Dim S As String = ""
        S = My.Settings("UserDefaultConnString")
        If S.Equals("?") Then
            S = DBgetConnStr()

        End If
        EcmLibConnectionString = S

    End Sub

    ''' <summary>
    ''' Executes the SQL new connection.
    ''' </summary>
    ''' <param name="sql">The SQL.</param>
    ''' <param name="NewConnectionStr">Creates new connectionstr.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
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
                        MsgBox("It appears this user has DATA within the repository associated to them and cannot be deleted." + vbCrLf + vbCrLf + ex.Message)
                    ElseIf InStr(ex.Message, "duplicate key row", CompareMethod.Text) > 0 Then
                        'log.WriteToSqlLog("clsDatabase : ExecuteSqlNewConn : 1464 : " + ex.Message)
                        'log.WriteToSqlLog("clsDatabase : ExecuteSqlNewConn : 1408 : " + ex.Message)
                        'log.WriteToSqlLog("clsDatabase : ExecuteSqlNewConn : 1411 : " + ex.Message)
                        Return True
                    End If
                    LOG.WriteToSqlLog("ERROR 126.xx-1 : " + ex.Message)
                    LOG.WriteToSqlLog("ERROR 126.xx-2 : " + sql)
                End Try
            End Using

            If CN.State = ConnectionState.Open Then
                CN.Close()
            End If
            CN = Nothing
            dbCmd = Nothing
            Return rc
        Catch ex As Exception
            'DBTrace(9914, "ExecuteSqlNewConn", "ExecuteSqlNewConn Failed",ex)
            MsgBox(ex.Message)
            Return False
        End Try

    End Function

    ''' <summary>
    ''' SQLs the qry.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="sql">The SQL.</param>
    ''' <returns>SqlDataReader.</returns>
    Public Function SqlQry(ByVal SecureID As Integer, ByVal sql As String) As SqlDataReader

        Dim dDebug As Boolean = True
        Dim queryString As String = sql
        Dim rc As Boolean = False
        Dim rsDataQry As SqlDataReader = Nothing
        Dim CS As String = getThesaurusConnectionString()

        Using CONN As New SqlConnection(CS)

            Try
                CONN.Open()
            Catch ex As Exception
                Console.WriteLine(ex.Message)
            End Try

            Using command As New SqlCommand(sql, CONN)
                Try
                    rsDataQry = command.ExecuteReader()
                Catch ex As Exception
                    LOG.WriteToSqlLog("clsDB : SqlQry : 1319db : " + ex.Message.ToString + vbCrLf + sql)
                End Try
            End Using
        End Using

        Return rsDataQry
    End Function

    ''' <summary>
    ''' Gets the default thesaurus.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <returns>System.String.</returns>
    Public Function getDefaultThesaurus(ByVal SecureID As Integer) As String
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
                RSData = SqlQry(SecureID, s)
                RSData.Read()
                DefaultThesaurus = RSData.GetValue(0).ToString
                RSData.Close()
                RSData = Nothing
                command.Connection.Close()
                command = Nothing
            End Using
        Catch ex As Exception
            'DBTrace(SecureID,12335, "clsDataBase:iGetRowCount",ex)
            'MsgBox("Error 3932.11: " + ex.Message)
            If dDebug Then Debug.Print("Error 3932.11: CountOfThesauri " + ex.Message)
            Console.WriteLine("Error 3932.11: getDefaultThesaurus" + ex.Message)
            DefaultThesaurus = ""
            MsgBox("Check the sql error log")
            LOG.WriteToSqlLog("ERROR clsDB : getDefaultThesaurus : 100a : " + EcmLibConnectionString)
            LOG.WriteToSqlLog("clsDB : getDefaultThesaurus : 100b : " + ex.Message + vbCrLf + s)
            DefaultThesaurus$ = "Roget"
        End Try
        If Not EcmConn.State = ConnectionState.Closed Then
            EcmConn.Close()
        End If
        EcmConn = Nothing
        GC.Collect()
        Return DefaultThesaurus$
    End Function

    ''' <summary>
    ''' Thesauruses the exist.
    ''' </summary>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function ThesaurusExist() As Boolean
        Dim B As Boolean = True
        Dim I As Integer = getCountOfThesauri()
        If I <= 0 Then
            Dim CS$ = getThesaurusConnectionString()
            Dim InsertSql$ = "INSERT INTO [dbo].[Thesaurus] ([ThesaurusName],[ThesaurusID]) VALUES ('Roget','D7A21DA7-0818-4B75-8BBA-D0339D3E1D54')"
            B = ExecuteSqlNewConn(InsertSql, CS)
            If Not B Then
                Dim tMsg As String = ""
                tMsg = "ERROR :ThesaurusExist - Failed to add default Thesaurus."
                Console.WriteLine(tMsg)
            End If
        End If
        Return B
    End Function

    ''' <summary>
    ''' Gets the count of thesauri.
    ''' </summary>
    ''' <returns>System.Int32.</returns>
    Function getCountOfThesauri() As Integer
        Dim cnt As Integer = -1
        Dim s As String = ""

        Try
            Dim tQuery As String = ""
            s = "Select count(*) FROM [Thesaurus] "
            Using TrexConnection

                Dim RSData As SqlDataReader = Nothing
                Dim CS$ = ThesaurusConnectionString : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : RSData = command.ExecuteReader()
                RSData.Read()
                cnt = RSData.GetInt32(0)
                RSData.Close()
                RSData = Nothing
                command.Connection.Close()
                command = Nothing
            End Using
        Catch ex As Exception
            'DBTrace(SecureID,12335, "clsDataBase:iGetRowCount",ex)
            'MsgBox("Error 3932.11: " + ex.Message)
            If dDebug Then Debug.Print("Error 3932.11: CountOfThesauri " + ex.Message)
            Console.WriteLine("Error 3932.11: CountOfThesauri" + ex.Message)
            cnt = 0
            LOG.WriteToSqlLog("clsDB : CountOfThesauri : 100 : " + ex.Message)
        End Try

        Return cnt

    End Function

    ''' <summary>
    ''' is the get row count.
    ''' </summary>
    ''' <param name="TBL">The table.</param>
    ''' <param name="WhereClause">The where clause.</param>
    ''' <returns>System.Int32.</returns>
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
            'DBTrace(SecureID,12335, "clsDataBase:iGetRowCount",ex)
            'MsgBox("Error 3932.11: " + ex.Message)
            If dDebug Then Debug.Print("Error 3932.11: " + ex.Message)
            Console.WriteLine("Error 3932.11: " + ex.Message)
            cnt = 0
            LOG.WriteToSqlLog("clsDatabase : iGetRowCount : 4010 : " + ex.Message)
        End Try

        Return cnt

    End Function

    ''' <summary>
    ''' Gets the row by key.
    ''' </summary>
    ''' <param name="TBL">The table.</param>
    ''' <param name="WC">The wc.</param>
    ''' <returns>SqlDataReader.</returns>
    Public Function GetRowByKey(ByVal TBL As String, ByVal WC As String) As SqlDataReader
        Try
            Dim Auth As String = ""
            Dim s As String = "Select * from " + TBL + " " + WC
            Dim rsData As SqlDataReader = Nothing
            Dim b As Boolean = False
            Dim CS$ = ThesaurusConnectionString : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader()
            If rsData.HasRows Then
                rsData.Read()
                Auth = rsData.GetValue(0).ToString
                Return rsData
            Else
                Return Nothing
            End If
        Catch ex As Exception
            'DBTrace(SecureID,12330, "clsDataBase:GetRowByKey",ex)
            If dDebug Then Debug.Print(ex.Message)
            LOG.WriteToSqlLog("clsDatabase : GetRowByKey : 3963 : " + ex.Message)
            LOG.WriteToSqlLog("clsDatabase : GetRowByKey : 3931 : " + ex.Message)
            LOG.WriteToSqlLog("clsDatabase : GetRowByKey : 3945 : " + ex.Message)
            Return Nothing
        End Try

    End Function

    ''' <summary>
    ''' Sets the connection thesaurus string.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function setConnThesaurusStr() As String

        Dim S As String = System.Configuration.ConfigurationManager.AppSettings("ECM_ThesaurusConnectionString").ToString
        Dim pw As String = System.Configuration.ConfigurationManager.AppSettings("ENCPW")

        pw = ENC.AES256DecryptString(pw)
        S = S.Replace("@@PW@@", pw)

        Return S

    End Function

    ''' <summary>
    ''' Gets the thesaurus connection string.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getThesaurusConnectionString() As String

        Dim S As String = ""
        S = setConnThesaurusStr()
        Return S

    End Function

    ''' <summary>
    ''' Gets the name of the class.
    ''' </summary>
    ''' <param name="ClassonomyName">Name of the classonomy.</param>
    ''' <param name="Token">The token.</param>
    ''' <returns>System.String.</returns>
    Function getClassName(ByVal ClassonomyName As String, ByVal Token As String) As String
        Dim S As String = ""
        S = S + " SELECT GroupID"
        S = S + " FROM [ECM.Thesaurus].[dbo].[ClassonomyData]"
        S = S + " where [CalssonomyName] = '" + ClassonomyName$ + "'"
        S = S + " and [Token] = '" + Token + "'"
        Dim ClassID As String = ""
        Dim rsData As SqlDataReader = Nothing

        Try
            Dim Auth As String = ""
            Dim b As Boolean = False
            Dim CS$ = ThesaurusConnectionString : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(S, CONN) : rsData = command.ExecuteReader()
            If rsData.HasRows Then
                rsData.Read()
                ClassID$ = rsData.GetValue(0).ToString
            Else
                ClassID = ""
            End If
        Catch ex As Exception
            'DBTrace(SecureID,12330, "clsDataBase:GetRowByKey",ex)
            If dDebug Then Debug.Print(ex.Message)
            LOG.WriteToSqlLog("clsDatabase : getClassName : 3963 : " + ex.Message)
            Return Nothing
        End Try
        If rsData.IsClosed Then
        Else
            rsData.Close()
        End If
        rsData = Nothing
        Return ClassID$
    End Function

    ''' <summary>
    ''' Gets the thesaurus identifier.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="ThesaurusName">Name of the thesaurus.</param>
    ''' <returns>System.String.</returns>
    Function getThesaurusID(ByVal SecureID As Integer, ByVal ThesaurusName As String) As String

        If ThesaurusName$.Trim.Length = 0 Then
            ThesaurusName$ = getDefaultThesaurus(SecureID)
        End If

        Dim S As String = ""
        S = S + " SELECT [ThesaurusID] FROM [Thesaurus] where [ThesaurusName] = '" + ThesaurusName$ + "'"
        Dim TID As String = ""
        Dim rsData As SqlDataReader = Nothing

        Try
            Dim Auth As String = ""
            Dim b As Boolean = False
            Dim CS$ = getThesaurusConnectionString()
            Dim CONN As New SqlConnection(CS)
            CONN.Open()
            Dim command As New SqlCommand(S, CONN)
            rsData = command.ExecuteReader()
            If rsData.HasRows Then
                rsData.Read()
                TID$ = rsData.GetValue(0).ToString
            Else
                MsgBox("Did not find the Thesaurus listed in the DB - aborting: " + ThesaurusName$ + ", so the query will continue without a thesaurus.")
                LOG.WriteToSqlLog("clsDatabase : getThesaurusID : ERROR 3963 : " + vbCrLf + S)
            End If
        Catch ex As Exception
            'DBTrace(SecureID,12330, "clsDataBase:GetRowByKey",ex)
            If dDebug Then Debug.Print(ex.Message)
            LOG.WriteToSqlLog("clsDatabase : getThesaurusID : 3963 : " + ex.Message)
            Return Nothing
        End Try
        If rsData.IsClosed Then
        Else
            rsData.Close()
        End If
        rsData = Nothing
        Return TID
    End Function

    ''' <summary>
    ''' Gets the thesaurus number identifier.
    ''' </summary>
    ''' <param name="ThesaurusName">Name of the thesaurus.</param>
    ''' <returns>System.Int32.</returns>
    Function getThesaurusNumberID(ByVal ThesaurusName As String) As Integer

        Dim S As String = ""
        S = S + " SELECT [ThesaurusSeqID] FROM [Thesaurus] where [ThesaurusName] = '" + ThesaurusName$ + "'"
        Dim TID As Integer = -1
        Dim rsData As SqlDataReader = Nothing

        Try
            Dim Auth As String = ""

            Dim b As Boolean = False
            Dim CS$ = ThesaurusConnectionString : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(S, CONN) : rsData = command.ExecuteReader()
            If rsData.HasRows Then
                rsData.Read()
                TID = rsData.GetInt32(0)
            Else
                MsgBox("Did not find the Thesaurus listed in the DB - aborting: " + ThesaurusName)
                Return -1
            End If
        Catch ex As Exception
            'DBTrace(SecureID,12330, "clsDataBase:GetRowByKey",ex)
            If dDebug Then Debug.Print(ex.Message)
            LOG.WriteToSqlLog("clsDatabase : getClassName : 3963 : " + ex.Message)
            Return Nothing
        End Try
        If rsData.IsClosed Then
        Else
            rsData.Close()
        End If
        rsData = Nothing
        Return TID
    End Function

    ''' <summary>
    ''' Inserts the child word.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="RootID">The root identifier.</param>
    ''' <param name="Token">The token.</param>
    ''' <param name="TokenID">The token identifier.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function InsertChildWord(ByVal SecureID As Integer, ByVal RootID As String, ByVal Token As String, ByVal TokenID As Integer) As Boolean
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
            S = S + " ,'" + RootID$ + "')"

            B = Me.ExecuteSqlNewConn(S, ConnStr)
        Catch ex As Exception
            B = False
            Console.WriteLine(ex.Message)
            MsgBox(ex.Message)
        End Try

        Return B

    End Function

    ''' <summary>
    ''' Roots the word exists.
    ''' </summary>
    ''' <param name="RootToken">The root token.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function RootWordExists(ByVal RootToken As String) As Boolean
        Dim ConnStr As String = getThesaurusConnectionString()
        Dim B As Boolean = False
        Dim rsData As SqlDataReader = Nothing
        Dim iCnt As Integer = -1
        Dim S As String = ""
        Try
            S = "Select COUNT(*) FROM [Rootword] WHERE [RootToken] = '" + RootToken$ + "'"
            Try
                Dim CS$ = ThesaurusConnectionString : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(S, CONN) : rsData = command.ExecuteReader()
                If rsData.HasRows Then
                    rsData.Read()
                    iCnt = rsData.GetInt32(0)
                End If
            Catch ex As Exception
                'DBTrace(SecureID,12330, "clsDataBase:GetRowByKey",ex)
                If dDebug Then Debug.Print(ex.Message)
                LOG.WriteToSqlLog("clsDatabase : getClassName : 3963 : " + ex.Message)
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
            MsgBox(ex.Message)
        End Try
        If iCnt > 0 Then
            B = True
        Else
            B = False
        End If
        Return B

    End Function

    ''' <summary>
    ''' Adds the token.
    ''' </summary>
    ''' <param name="Token">The token.</param>
    ''' <returns>System.Int32.</returns>
    Function AddToken(ByVal Token As String) As Integer
        Dim TokenID As Integer = -1
        TokenID = getTokenID(Token)
        If TokenID > 0 Then
            Return TokenID
        End If
        Dim S As String = ""

    End Function

    ''' <summary>
    ''' Gets the token identifier.
    ''' </summary>
    ''' <param name="Token">The token.</param>
    ''' <returns>System.Int32.</returns>
    Function getTokenID(ByVal Token As String) As Integer
        Token = UTIL.RemoveSingleQuotes(Token)
        Dim ID As Integer = 0
        Dim S$ = "Select [TokenID] FROM [Tokens] where [Token] = '" + Token + "'"
        Dim ConnStr As String = getThesaurusConnectionString()
        Dim B As Boolean = False
        Dim rsData As SqlDataReader = Nothing
        Dim iCnt As Integer = -1
        Try
            Dim CS$ = ThesaurusConnectionString : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(S, CONN) : rsData = command.ExecuteReader()
            If rsData.HasRows Then
                rsData.Read()
                iCnt = rsData.GetInt32(0)
            End If
        Catch ex As Exception
            'DBTrace(SecureID,12330, "clsDataBase:GetRowByKey",ex)
            If dDebug Then Debug.Print(ex.Message)
            LOG.WriteToSqlLog("clsDatabase : getTokenID : 3963 : " + ex.Message)
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

    ''' <summary>
    ''' Childs the word exists.
    ''' </summary>
    ''' <param name="RootID">The root identifier.</param>
    ''' <param name="Token">The token.</param>
    ''' <param name="TokenID">The token identifier.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
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
            S = S + "and [RootID] = '" + RootID$ + "'"
            Try
                Dim CS$ = ThesaurusConnectionString : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(S, CONN) : rsData = command.ExecuteReader()
                If rsData.HasRows Then
                    rsData.Read()
                    iCnt = rsData.GetInt32(0)
                End If
            Catch ex As Exception
                'DBTrace(SecureID,12330, "clsDataBase:GetRowByKey",ex)
                If dDebug Then Debug.Print(ex.Message)
                LOG.WriteToSqlLog("clsDatabase : getClassName : 3963 : " + ex.Message)
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
            MsgBox(ex.Message)
        End Try
        If iCnt > 0 Then
            B = True
        Else
            B = False
        End If
        Return B

    End Function

    ''' <summary>
    ''' Inserts the root word.
    ''' </summary>
    ''' <param name="ThesaurusID">The thesaurus identifier.</param>
    ''' <param name="RootToken">The root token.</param>
    ''' <param name="RootID">The root identifier.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function InsertRootWord(ByVal ThesaurusID As String, ByVal RootToken As String, ByVal RootID As String) As Boolean
        Dim ConnStr As String = getThesaurusConnectionString()
        Dim B As Boolean = False
        Dim S As String = ""
        Try
            S = S + " INSERT INTO [ECM.Thesaurus].[dbo].[Rootword]"
            S = S + " (ThesaurusID, [RootToken]"
            S = S + " ,[RootID])"
            S = S + " VALUES "
            S = S + " ('" + ThesaurusID$ + "'"
            S = S + " ,'" + RootToken$ + "'"
            S = S + " ,'" + RootID$ + "')"
            B = Me.ExecuteSqlNewConn(S, ConnStr)
        Catch ex As Exception
            B = False
            Console.WriteLine(ex.Message)
            MsgBox(ex.Message)
        End Try

        Return B

    End Function

    ''' <summary>
    ''' Gets the synonyms.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="ThesaurusID">The thesaurus identifier.</param>
    ''' <param name="Token">The token.</param>
    ''' <param name="Synonyms">The synonyms.</param>
    ''' <returns>System.String.</returns>
    Function getSynonyms(ByVal SecureID As Integer, ByVal ThesaurusID As String, ByVal Token As String, ByRef Synonyms As String) As String

        Dim lbSynonyms() As String = Synonyms.Split("|")
        Dim CS As String = getThesaurusConnectionString()
        Dim B As Boolean = False
        Dim iCnt As Integer = -1
        Dim ListOfSynonyms As New List(Of String)

        Dim inPhrase As String = ""
        For Each str As String In lbSynonyms
            str = str.Trim
            If str.Length > 0 Then
                If Not ListOfSynonyms.Contains(str) Then
                    ListOfSynonyms.Add(str)
                End If
                inPhrase += "'" + str + "'" + ","
            End If
        Next

        If inPhrase.Length <= 0 Then
            Return ""
        End If

        inPhrase = inPhrase.Trim.Substring(0, inPhrase.Length - 1)
        Dim SS As String = ""

        Dim S As String = " SELECT RootChildren.Token" + Environment.NewLine
        S = S + " FROM Rootword INNER JOIN" + Environment.NewLine
        S = S + " RootChildren ON Rootword.RootID = RootChildren.RootID" + Environment.NewLine
        'S = S + " where  Rootword.RootToken = '" + Token + "'  and    ThesaurusID  = 'D7A21DA7-0818-4B75-8BBA-D0339D3E1D54'" + Environment.NewLine
        S = S + " where  Rootword.RootToken in (" + inPhrase + ")" + Environment.NewLine
        S = S + " order by RootChildren.Token"

        Try

            Using CONN As New SqlConnection(CS)

                Dim RSData As SqlDataReader = Nothing
                CONN.Open()
                Dim command As New SqlCommand(S, CONN)
                RSData = command.ExecuteReader()
                If RSData.HasRows Then
                    Do While RSData.Read()
                        SS = RSData.GetValue(0).ToString
                        If Not ListOfSynonyms.Contains(SS) Then
                            ListOfSynonyms.Add(SS)
                        End If
                    Loop
                Else
                    LOG.WriteToSqlLog("clsDatabase : getThesaurusID : ERROR 3963 : " + vbCrLf + S)
                End If
                RSData = Nothing
                command.Connection.Close()
                command = Nothing
            End Using
        Catch ex As Exception
            'DBTrace(SecureID,12330, "clsDataBase:GetRowByKey",ex)
            LOG.WriteToSqlLog("clsDatabase : getThesaurusID : 3963 : " + ex.Message)
            Return Nothing
        End Try

        Dim TgtSynonyms As String = ""
        For Each SS In ListOfSynonyms
            TgtSynonyms += SS + ","
        Next

        If TgtSynonyms.Contains(",") Then
            TgtSynonyms = TgtSynonyms.Substring(0, TgtSynonyms.Length - 1)
        End If

        Return TgtSynonyms
    End Function

    ''' <summary>
    ''' Gets the synonyms.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="ThesaurusID">The thesaurus identifier.</param>
    ''' <param name="Token">The token.</param>
    ''' <param name="SynonymsArray">The synonyms array.</param>
    ''' <param name="AppendToList">if set to <c>true</c> [append to list].</param>
    Sub getSynonyms(ByVal SecureID As Integer, ByVal ThesaurusID As String, ByVal Token As String, ByRef SynonymsArray As ArrayList, ByVal AppendToList As Boolean)
        Dim ConnStr As String = getThesaurusConnectionString()
        Dim B As Boolean = False
        Dim rsData As SqlDataReader = Nothing
        Dim iCnt As Integer = -1
        Dim Synonym As String = ""

        If AppendToList = False Then
            SynonymsArray.Clear()
        End If

        Dim S$ = " SELECT RootChildren.Token" + Environment.NewLine
        S = S + " FROM Rootword INNER JOIN" + Environment.NewLine
        S = S + " RootChildren ON Rootword.RootID = RootChildren.RootID" + Environment.NewLine
        S = S + " where  Rootword.RootToken = '" + Token + "'  and    ThesaurusID  = '" + ThesaurusID$ + "'" + Environment.NewLine
        S = S + " order by RootChildren.Token"

        Dim rsSynonyms As SqlDataReader = Nothing
        'rsSynonyms = SqlQryNo'Session(S)
        rsSynonyms = SqlQry(SecureID, S)
        If rsSynonyms.HasRows Then
            Do While rsSynonyms.Read()
                Synonym$ = rsSynonyms.GetValue(0).ToString.Trim
                Console.WriteLine(Synonym)
                If Not SynonymsArray.Contains(Synonym) Then
                    SynonymsArray.Add(Synonym)
                End If

            Loop
        End If
        'If Synonyms$.Trim.Length Then
        '    Synonyms$ = Mid(Synonyms$, 1, Synonyms$.Length - 1)
        'End If
        rsSynonyms.Close()
        rsSynonyms = Nothing

    End Sub

    ''' <summary>
    ''' Gets all tokens.
    ''' </summary>
    ''' <param name="SecureID">The secure identifier.</param>
    ''' <param name="LB">The lb.</param>
    ''' <param name="ThesaurusID">The thesaurus identifier.</param>
    Sub getAllTokens(ByVal SecureID As Integer, ByRef LB As ListBox, ByVal ThesaurusID As String)
        LB.Items.Clear()
        Dim ConnStr As String = getThesaurusConnectionString()
        Dim B As Boolean = False
        Dim rsData As SqlDataReader = Nothing
        Dim iCnt As Integer = -1
        Dim Synonyms As String = ""

        Dim S$ = " select RootToken from Rootword order by RootToken "
        Dim rsSynonyms As SqlDataReader = Nothing
        'rsSynonyms = SqlQryNo'Session(S)
        rsSynonyms = SqlQry(SecureID, S)
        If rsSynonyms.HasRows Then
            Do While rsSynonyms.Read()
                Synonyms$ = rsSynonyms.GetValue(0).ToString.Trim
                LB.Items.Add(Synonyms)
            Loop
        End If
        rsSynonyms.Close()
        rsSynonyms = Nothing
    End Sub

    ''' <summary>
    ''' Populates the ComboBox.
    ''' </summary>
    ''' <param name="CB">The cb.</param>
    ''' <param name="TblColName">Name of the table col.</param>
    ''' <param name="S">The s.</param>
    Sub PopulateComboBox(ByRef CB As List(Of String), ByVal TblColName As String, ByVal S As String)

        Dim TryAgain As Boolean = False
RETRY1:
        Dim ConnStr As String = getThesaurusConnectionString()
        Dim tConn As SqlConnection = New SqlConnection(ConnStr)
        Dim DA As New SqlDataAdapter(S, tConn)
        Dim DS As New DataSet

        Try

            If tConn.State = ConnectionState.Closed Then
                tConn.Open()
            End If

            DA.Fill(DS, TblColName)

            'Create and populate the DataTable to bind to the ComboBox:
            Dim dt As New DataTable
            dt.Columns.Add(TblColName$, GetType(System.String))

            ' Populate the DataTable to bind to the Combobox.
            Dim drDSRow As DataRow
            Dim drNewRow As DataRow
            Dim iRowCnt As Integer = 0
            For Each drDSRow In DS.Tables(TblColName).Rows()
                drNewRow = dt.NewRow()
                drNewRow(TblColName) = drDSRow(TblColName)
                dt.Rows.Add(drNewRow)
                iRowCnt += 1
                CB.Add(drDSRow(0).ToString)
            Next
            If iRowCnt = 0 Then
                Dim SS As String = "insert into Thesaurus (ThesaurusName, ThesaurusID) values ('Roget', 'D7A21DA7-0818-4B75-8BBA-D0339D3E1D54')"
                Dim BB As Boolean = ExecuteSqlNewConn(SS, ConnStr)
                MsgBox("Please close and reopen the Search Assistant screen - there is a connectivity issue with the thesaurus.")
                Return
            End If
            'Bind the DataTable to the ComboBox by setting the Combobox's DataSource property to the DataTable. To display the "Description" column in the Combobox's list, set the Combobox's DisplayMember property to the name of column. Likewise, to use the "Code" column as the value of an item in the Combobox set the ValueMember property.
            'CB.DropDownStyle = ComboBoxStyle.DropDown
            ''CB.DataSource = dt
            'CB.DisplayMember = TblColName$
            'CB.SelectedIndex = 0

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
            If dDebug Then Debug.Print("Error 2194.23: " + ex.Message)
            LOG.WriteToSqlLog("clsDB : PopulateComboBox : 1000 : " + ex.Message + vbCrLf + S$ + vbCrLf + ConnStr)
            If InStr(ex.Message, "XX", CompareMethod.Text) And TryAgain = False Then
                My.Settings("UserThesaurusConnString") = "?"
                LOG.WriteToSqlLog("clsDB : PopulateComboBox : 1000a : try again using APP Config.")
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