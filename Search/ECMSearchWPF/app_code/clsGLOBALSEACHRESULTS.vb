' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 07-16-2020
'
' Last Modified By : wdale
' Last Modified On : 07-16-2020
' ***********************************************************************
' <copyright file="clsGLOBALSEACHRESULTS.vb" company="D. Miller and Associates, Limited">
'     Copyright @ DMA Ltd 2020 all rights reserved.
' </copyright>
' <summary></summary>
' ***********************************************************************
Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System
'Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO
Imports System.Threading
Imports ECMEncryption

''' <summary>
''' Class clsGLOBALSEACHRESULTS.
''' </summary>
Public Class clsGLOBALSEACHRESULTS


    'Dim proxy As New SVCSearch.Service1Client

    '** DIM the selected table columns 
    'Dim DB As New clsDatabase
    ''' <summary>
    ''' The dma
    ''' </summary>
    Dim DMA As New clsDma
    'Dim DG As New clsDataGrid
    ''' <summary>
    ''' The utility
    ''' </summary>
    Dim UTIL As New clsUtility
    ''' <summary>
    ''' The log
    ''' </summary>
    Dim LOG As New clsLogMain
    'Dim EP As New clsEndPoint
    ''' <summary>
    ''' The en c2
    ''' </summary>
    Dim ENC2 As New ECMEncrypt()

    ''' <summary>
    ''' The content title
    ''' </summary>
    Dim ContentTitle As String = ""
    ''' <summary>
    ''' The content author
    ''' </summary>
    Dim ContentAuthor As String = ""
    ''' <summary>
    ''' The content type
    ''' </summary>
    Dim ContentType As String = ""
    ''' <summary>
    ''' The create date
    ''' </summary>
    Dim CreateDate As String = ""
    ''' <summary>
    ''' The content ext
    ''' </summary>
    Dim ContentExt As String = ""
    ''' <summary>
    ''' The content unique identifier
    ''' </summary>
    Dim ContentGuid As String = ""
    ''' <summary>
    ''' The user identifier
    ''' </summary>
    Dim UserID As String = ""
    ''' <summary>
    ''' The file name
    ''' </summary>
    Dim FileName As String = ""
    ''' <summary>
    ''' The file size
    ''' </summary>
    Dim FileSize As String = ""
    ''' <summary>
    ''' The NBR of attachments
    ''' </summary>
    Dim NbrOfAttachments As String = ""
    ''' <summary>
    ''' From email address
    ''' </summary>
    Dim FromEmailAddress As String = ""
    ''' <summary>
    ''' All recipiants
    ''' </summary>
    Dim AllRecipiants As String = ""
    ''' <summary>
    ''' The weight
    ''' </summary>
    Dim Weight As String = ""

    ''' <summary>
    ''' The B9999
    ''' </summary>
    Dim B9999 As Integer = 0

    ''' <summary>
    ''' The g secure identifier
    ''' </summary>
    Dim gSecureID As String = -1
    ''' <summary>
    ''' Initializes a new instance of the <see cref="clsGLOBALSEACHRESULTS"/> class.
    ''' </summary>
    Sub New()
        gSecureID = _SecureID
        'AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf gLogSQL
        'EP.setSearchSvcEndPoint(proxy)

    End Sub

    '** Generate the SET methods 
    ''' <summary>
    ''' Sets the contenttitle.
    ''' </summary>
    ''' <param name="val">The value.</param>
    Public Sub setContenttitle(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        ContentTitle = val
    End Sub

    ''' <summary>
    ''' Sets the contentauthor.
    ''' </summary>
    ''' <param name="val">The value.</param>
    Public Sub setContentauthor(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        ContentAuthor = val
    End Sub

    ''' <summary>
    ''' Sets the contenttype.
    ''' </summary>
    ''' <param name="val">The value.</param>
    Public Sub setContenttype(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        ContentType = val
    End Sub

    ''' <summary>
    ''' Sets the createdate.
    ''' </summary>
    ''' <param name="val">The value.</param>
    Public Sub setCreatedate(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        CreateDate = val
    End Sub

    ''' <summary>
    ''' Sets the contentext.
    ''' </summary>
    ''' <param name="val">The value.</param>
    Public Sub setContentext(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        ContentExt = val
    End Sub

    ''' <summary>
    ''' Sets the contentguid.
    ''' </summary>
    ''' <param name="val">The value.</param>
    Public Sub setContentguid(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Contentguid' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        ContentGuid = val
    End Sub

    ''' <summary>
    ''' Sets the userid.
    ''' </summary>
    ''' <param name="val">The value.</param>
    Public Sub setUserid(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Userid' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        UserID = val
    End Sub

    ''' <summary>
    ''' Sets the filename.
    ''' </summary>
    ''' <param name="val">The value.</param>
    Public Sub setFilename(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        FileName = val
    End Sub

    ''' <summary>
    ''' Sets the filesize.
    ''' </summary>
    ''' <param name="val">The value.</param>
    Public Sub setFilesize(ByRef val As String)
        If Len(val) = 0 Then
            val = "null"
        End If
        val = UTIL.RemoveSingleQuotes(val)
        FileSize = val
    End Sub

    ''' <summary>
    ''' Sets the nbrofattachments.
    ''' </summary>
    ''' <param name="val">The value.</param>
    Public Sub setNbrofattachments(ByRef val As String)
        If Len(val) = 0 Then
            val = "null"
        End If
        val = UTIL.RemoveSingleQuotes(val)
        NbrOfAttachments = val
    End Sub

    ''' <summary>
    ''' Sets the fromemailaddress.
    ''' </summary>
    ''' <param name="val">The value.</param>
    Public Sub setFromemailaddress(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        FromEmailAddress = val
    End Sub

    ''' <summary>
    ''' Sets the allrecipiants.
    ''' </summary>
    ''' <param name="val">The value.</param>
    Public Sub setAllrecipiants(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        AllRecipiants = val
    End Sub

    ''' <summary>
    ''' Sets the weight.
    ''' </summary>
    ''' <param name="val">The value.</param>
    Public Sub setWeight(ByRef val As String)
        If Len(val) = 0 Then
            val = "null"
        End If
        val = UTIL.RemoveSingleQuotes(val)
        Weight = val
    End Sub



    '** Generate the GET methods 
    ''' <summary>
    ''' Gets the contenttitle.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getContenttitle() As String
        Return UTIL.RemoveSingleQuotes(ContentTitle)
    End Function

    ''' <summary>
    ''' Gets the contentauthor.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getContentauthor() As String
        Return UTIL.RemoveSingleQuotes(ContentAuthor)
    End Function

    ''' <summary>
    ''' Gets the contenttype.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getContenttype() As String
        Return UTIL.RemoveSingleQuotes(ContentType)
    End Function

    ''' <summary>
    ''' Gets the createdate.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getCreatedate() As String
        Return UTIL.RemoveSingleQuotes(CreateDate)
    End Function

    ''' <summary>
    ''' Gets the contentext.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getContentext() As String
        Return UTIL.RemoveSingleQuotes(ContentExt)
    End Function

    ''' <summary>
    ''' Gets the contentguid.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getContentguid() As String
        If Len(ContentGuid) = 0 Then
            MessageBox.Show("GET: Field 'Contentguid' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(ContentGuid)
    End Function

    ''' <summary>
    ''' Gets the userid.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getUserid() As String
        If Len(UserID) = 0 Then
            MessageBox.Show("GET: Field 'Userid' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(UserID)
    End Function

    ''' <summary>
    ''' Gets the filename.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getFilename() As String
        Return UTIL.RemoveSingleQuotes(FileName)
    End Function

    ''' <summary>
    ''' Gets the filesize.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getFilesize() As String
        If Len(FileSize) = 0 Then
            FileSize = "null"
        End If
        Return FileSize
    End Function

    ''' <summary>
    ''' Gets the nbrofattachments.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getNbrofattachments() As String
        If Len(NbrOfAttachments) = 0 Then
            NbrOfAttachments = "null"
        End If
        Return NbrOfAttachments
    End Function

    ''' <summary>
    ''' Gets the fromemailaddress.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getFromemailaddress() As String
        Return UTIL.RemoveSingleQuotes(FromEmailAddress)
    End Function

    ''' <summary>
    ''' Gets the allrecipiants.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getAllrecipiants() As String
        Return UTIL.RemoveSingleQuotes(AllRecipiants)
    End Function

    ''' <summary>
    ''' Gets the weight.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getWeight() As String
        If Len(Weight) = 0 Then
            Weight = "null"
        End If
        Return Weight
    End Function



    '** Generate the Required Fields Validation method 
    ''' <summary>
    ''' Validates the req data.
    ''' </summary>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function ValidateReqData() As Boolean
        If ContentGuid.Length = 0 Then Return False
        If UserID.Length = 0 Then Return False
        Return True
    End Function


    '** Generate the Validation method 
    ''' <summary>
    ''' Validates the data.
    ''' </summary>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function ValidateData() As Boolean
        If ContentGuid.Length = 0 Then Return False
        If UserID.Length = 0 Then Return False
        Return True
    End Function


    '** Generate the INSERT method 
    ''' <summary>
    ''' Inserts this instance.
    ''' </summary>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function Insert() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""
        s = s + " INSERT INTO GlobalSeachResults("
        s = s + "ContentTitle,"
        s = s + "ContentAuthor,"
        s = s + "ContentType,"
        s = s + "CreateDate,"
        s = s + "ContentExt,"
        s = s + "ContentGuid,"
        s = s + "UserID,"
        s = s + "FileName,"
        s = s + "FileSize,"
        s = s + "NbrOfAttachments,"
        s = s + "FromEmailAddress,"
        s = s + "AllRecipiants,"
        s = s + "Weight) values ("
        s = s + "'" + ContentTitle + "'" + ","
        s = s + "'" + ContentAuthor + "'" + ","
        s = s + "'" + ContentType + "'" + ","
        s = s + "'" + CreateDate + "'" + ","
        s = s + "'" + ContentExt + "'" + ","
        s = s + "'" + ContentGuid + "'" + ","
        s = s + "'" + UserID + "'" + ","
        s = s + "'" + FileName + "'" + ","
        s = s + FileSize + ","
        s = s + NbrOfAttachments + ","
        s = s + "'" + FromEmailAddress + "'" + ","
        s = s + "'" + AllRecipiants + "'" + ","
        s = s + Weight + ")"

        'AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf gLogSQL
        'EP.setSearchSvcEndPoint(proxy)
        s = ENC2.AES256EncryptString(s)
        Dim BB As Boolean = ProxySearch.ExecuteSqlNewConnSecure(gSecureID, s, _UserID, ContractID)
        gLogSQL(BB, ENC2.AES256EncryptString(s))
        Return True

    End Function

    '** Generate the UPDATE method 
    ''' <summary>
    ''' Updates the specified where clause.
    ''' </summary>
    ''' <param name="WhereClause">The where clause.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function Update(ByVal WhereClause As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        If Len(WhereClause) = 0 Then Return False

        s = s + " update GlobalSeachResults set "
        s = s + "ContentTitle = '" + getContenttitle() + "'" + ", "
        s = s + "ContentAuthor = '" + getContentauthor() + "'" + ", "
        s = s + "ContentType = '" + getContenttype() + "'" + ", "
        s = s + "CreateDate = '" + getCreatedate() + "'" + ", "
        s = s + "ContentExt = '" + getContentext() + "'" + ", "
        s = s + "ContentGuid = '" + getContentguid() + "'" + ", "
        s = s + "UserID = '" + getUserid() + "'" + ", "
        s = s + "FileName = '" + getFilename() + "'" + ", "
        s = s + "FileSize = " + getFilesize() + ", "
        s = s + "NbrOfAttachments = " + getNbrofattachments() + ", "
        s = s + "FromEmailAddress = '" + getFromemailaddress() + "'" + ", "
        s = s + "AllRecipiants = '" + getAllrecipiants() + "'" + ", "
        s = s + "Weight = " + getWeight()
        WhereClause = " " + WhereClause
        s = s + WhereClause

        'AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf gLogSQL
        'EP.setSearchSvcEndPoint(proxy)
        s = ENC2.AES256EncryptString(s)
        Dim BB As Boolean = ProxySearch.ExecuteSqlNewConnSecure(_SecureID, s, _UserID, ContractID)
        gLogSQL(BB, ENC2.AES256EncryptString(s))

        Return True
    End Function


    ''** Generate the SELECT method 
    'Public Function SelectRecs() As SqlDataReader
    '    Dim b As Boolean = False
    '    Dim s As String = ""
    '    Dim rsData As SqlDataReader
    '    s = s + " SELECT "
    '    s = s + "ContentTitle,"
    '    s = s + "ContentAuthor,"
    '    s = s + "ContentType,"
    '    s = s + "CreateDate,"
    '    s = s + "ContentExt,"
    '    s = s + "ContentGuid,"
    '    s = s + "UserID,"
    '    s = s + "FileName,"
    '    s = s + "FileSize,"
    '    s = s + "NbrOfAttachments,"
    '    s = s + "FromEmailAddress,"
    '    s = s + "AllRecipiants,"
    '    s = s + "Weight "
    '    s = s + " FROM GlobalSeachResults"
    '    '** s=s+ "ORDERBY xxxx"
    '    Dim CS$ = db.getConnStr() : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(S, CONN) : rsdata = command.ExecuteReader()
    '    Return rsData
    'End Function


    ''** Generate the Select One Row method 
    'Public Function SelectOne(ByVal WhereClause as string) As SqlDataReader
    '    Dim b As Boolean = False
    '    Dim s As String = ""
    '    Dim rsData As SqlDataReader
    '    s = s + " SELECT "
    '    s = s + "ContentTitle,"
    '    s = s + "ContentAuthor,"
    '    s = s + "ContentType,"
    '    s = s + "CreateDate,"
    '    s = s + "ContentExt,"
    '    s = s + "ContentGuid,"
    '    s = s + "UserID,"
    '    s = s + "FileName,"
    '    s = s + "FileSize,"
    '    s = s + "NbrOfAttachments,"
    '    s = s + "FromEmailAddress,"
    '    s = s + "AllRecipiants,"
    '    s = s + "Weight "
    '    s = s + " FROM GlobalSeachResults"
    '    s = s + WhereClause
    '    '** s=s+ "ORDERBY xxxx"
    '    Dim CS$ = db.getConnStr() : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(S, CONN) : rsdata = command.ExecuteReader()
    '    Return rsData
    'End Function


    '** Generate the DELETE method 
    ''' <summary>
    ''' Deletes the specified where clause.
    ''' </summary>
    ''' <param name="WhereClause">The where clause.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function Delete(ByVal WhereClause As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        If Len(WhereClause) = 0 Then Return False

        WhereClause = " " + WhereClause

        s = " Delete from GlobalSeachResults"
        s = s + WhereClause

        'AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf gLogSQL
        'EP.setSearchSvcEndPoint(proxy)
        s = ENC2.AES256EncryptString(s)
        Dim BB As Boolean = ProxySearch.ExecuteSqlNewConnSecure(_SecureID, s, _UserID, ContractID)
        gLogSQL(BB, ENC2.AES256EncryptString(s))

        Return b

    End Function


    '** Generate the Zeroize Table method 
    ''' <summary>
    ''' Zeroizes this instance.
    ''' </summary>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function Zeroize() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        s = s + " Delete from GlobalSeachResults"

        'AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf gLogSQL
        s = ENC2.AES256EncryptString(s)
        Dim BB As Boolean = ProxySearch.ExecuteSqlNewConnSecure(gSecureID, s, _UserID, ContractID)
        gLogSQL(BB, ENC2.AES256EncryptString(s))

        Return b

    End Function


    '** Generate Index Queries 
    ''' <summary>
    ''' Counts the pk global search.
    ''' </summary>
    ''' <param name="ContentGuid">The content unique identifier.</param>
    ''' <param name="UserID">The user identifier.</param>
    ''' <returns>System.Int32.</returns>
    Public Function cnt_PK_GlobalSearch(ByVal ContentGuid As String, ByVal UserID As String) As Integer

        B9999 = -9999
        Dim TBL$ = "GlobalSeachResults"
        Dim S As String = "Select count(*) GlobalSeachResults from Where ContentGuid = '" + ContentGuid + "' and   UserID = '" + UserID + "'"

        'B = SVCSearch.iGetRowCount(TBL$, WC)
        'AddHandler ProxySearch.iGetRowCountCompleted, AddressOf client_iGetRowCount
        S = ENC2.AES256EncryptString(S)
        Dim BB As Boolean = ProxySearch.ExecuteSqlNewConnSecure(gSecureID, S, _UserID, ContractID)
        gLogSQL(BB, ENC2.AES256EncryptString(S))

        Dim LoopCnt As Integer = 0
        Do While B9999 = -9999
            LoopCnt += 1
            Thread.Sleep(25)
        Loop

        Return B9999
    End Function

    ''' <summary>
    ''' Clients the i get row count.
    ''' </summary>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="I">The i.</param>
    Sub client_iGetRowCount(RC As Boolean, I As Integer)
        If RC Then
            B9999 = I
        Else
            B9999 = -1
            LOG.WriteToSqlLog("ERROR clsGLOBALSEACHRESULTS:client_iGetRowCount: Failed to update the associated IP address.")
        End If
    End Sub

    ''** Generate Index ROW Queries 
    'Public Function getRow_PK_GlobalSearch(ByVal ContentGuid As String, ByVal UserID As String) As SqlDataReader

    '    Dim rsData As SqlDataReader = Nothing
    '    Dim TBL$ = "GlobalSeachResults"
    '    Dim WC$ = "Where ContentGuid = '" + ContentGuid + "' and   UserID = '" + UserID + "'"

    '    rsData = DB.GetRowByKey(TBL$, WC)

    '    If rsData.HasRows Then
    '        Return rsData
    '    Else
    '        Return Nothing
    '    End If
    'End Function     '** getRow_PK_GlobalSearch

    ''' <summary>
    ''' Wcs the pk global search.
    ''' </summary>
    ''' <param name="ContentGuid">The content unique identifier.</param>
    ''' <param name="UserID">The user identifier.</param>
    ''' <returns>System.String.</returns>
    ''' Build Index Where Caluses
    Public Function wc_PK_GlobalSearch(ByVal ContentGuid As String, ByVal UserID As String) As String

        Dim WC$ = "Where ContentGuid = '" + ContentGuid + "' and   UserID = '" + UserID + "'"

        Return WC
    End Function     '** wc_PK_GlobalSearch

    '** Generate the SET methods 
    ''' <summary>
    ''' Adds this instance.
    ''' </summary>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function Add() As Boolean
        Dim iCnt As Integer = cnt_PK_GlobalSearch(ContentGuid, gCurrUserGuidID)
        If iCnt > 0 Then
            Dim WC$ = wc_PK_GlobalSearch(ContentGuid, gCurrUserGuidID)
            Update(WC)
        Else
            Insert()
        End If
        Return True
    End Function
    ''' <summary>
    ''' Allows an object to try to free resources and perform other cleanup operations before it is reclaimed by garbage collection.
    ''' </summary>
    Protected Overrides Sub Finalize()
        Try

        Finally
            MyBase.Finalize()      'define the destructor
            ''RemoveHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf gLogSQL

            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try
    End Sub

    ''' <summary>
    ''' Sets the xx search SVC end point.
    ''' </summary>
    Private Sub setXXSearchSvcEndPoint()

        If (SearchEndPoint.Length = 0) Then
            Return
        End If

        Dim ServiceUri As New Uri(SearchEndPoint)
        Dim EPA As New System.ServiceModel.EndpointAddress(ServiceUri)

        ProxySearch.Endpoint.Address = EPA
        GC.Collect()
        GC.WaitForPendingFinalizers()
    End Sub

End Class
