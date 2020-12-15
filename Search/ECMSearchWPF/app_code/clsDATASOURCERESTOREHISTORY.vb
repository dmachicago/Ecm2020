' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 07-16-2020
'
' Last Modified By : wdale
' Last Modified On : 07-16-2020
' ***********************************************************************
' <copyright file="clsDATASOURCERESTOREHISTORY.vb" company="D. Miller and Associates, Limited">
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
Imports ECMEncryption

''' <summary>
''' Class clsDATASOURCERESTOREHISTORY.
''' </summary>
Public Class clsDATASOURCERESTOREHISTORY

    ''' <summary>
    ''' The common
    ''' </summary>
    Dim COMMON As New clsCommonFunctions
    'Dim EP As New clsEndPoint
    ''' <summary>
    ''' The en c2
    ''' </summary>
    Dim ENC2 As New ECMEncrypt()


    'Dim proxy As New SVCSearch.Service1Client

    '** DIM the selected table columns 
    'Dim DB As New clsDatabase
    ''' <summary>
    ''' The dma
    ''' </summary>
    Dim DMA As New clsDma
    ''' <summary>
    ''' The utility
    ''' </summary>
    Dim UTIL As New clsUtility
    ''' <summary>
    ''' The log
    ''' </summary>
    Dim LOG As New clsLogMain


    ''' <summary>
    ''' The source unique identifier
    ''' </summary>
    Dim SourceGuid As String = ""
    ''' <summary>
    ''' The restored to machine
    ''' </summary>
    Dim RestoredToMachine As String = ""
    ''' <summary>
    ''' The restore user name
    ''' </summary>
    Dim RestoreUserName As String = ""
    ''' <summary>
    ''' The restore user identifier
    ''' </summary>
    Dim RestoreUserID As String = ""
    ''' <summary>
    ''' The restore user domain
    ''' </summary>
    Dim RestoreUserDomain As String = ""
    ''' <summary>
    ''' The restore date
    ''' </summary>
    Dim RestoreDate As String = ""
    ''' <summary>
    ''' The data source owner user identifier
    ''' </summary>
    Dim DataSourceOwnerUserID As String = ""
    ''' <summary>
    ''' The seq no
    ''' </summary>
    Dim SeqNo As String = ""
    ''' <summary>
    ''' The type content code
    ''' </summary>
    Dim TypeContentCode As String = ""
    ''' <summary>
    ''' The create date
    ''' </summary>
    Dim CreateDate As String = ""
    ''' <summary>
    ''' The document name
    ''' </summary>
    Dim DocumentName As String = ""
    ''' <summary>
    ''' The FQN
    ''' </summary>
    Dim FQN As String = ""
    ''' <summary>
    ''' The verified data
    ''' </summary>
    Dim VerifiedData As String = ""
    ''' <summary>
    ''' The original CRC
    ''' </summary>
    Dim OrigCrc As String = ""
    ''' <summary>
    ''' The restore CRC
    ''' </summary>
    Dim RestoreCrc As String = ""

    ''' <summary>
    ''' The handler added
    ''' </summary>
    Dim HandlerAdded As Boolean = False
    ''' <summary>
    ''' Initializes a new instance of the <see cref="clsDATASOURCERESTOREHISTORY"/> class.
    ''' </summary>
    Sub New()

    End Sub
    '** Generate the SET methods 
    ''' <summary>
    ''' Sets the sourceguid.
    ''' </summary>
    ''' <param name="val">The value.</param>
    Public Sub setSourceguid(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("clsDATASOURCERESTOREHISTORY - SET: Field 'Sourceguid' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        SourceGuid = val
    End Sub

    ''' <summary>
    ''' Sets the restoredtomachine.
    ''' </summary>
    ''' <param name="val">The value.</param>
    Public Sub setRestoredtomachine(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        RestoredToMachine = val
    End Sub

    ''' <summary>
    ''' Sets the restoreusername.
    ''' </summary>
    ''' <param name="val">The value.</param>
    Public Sub setRestoreusername(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        RestoreUserName = val
    End Sub

    ''' <summary>
    ''' Sets the restoreuserid.
    ''' </summary>
    ''' <param name="val">The value.</param>
    Public Sub setRestoreuserid(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        RestoreUserID = val
    End Sub

    ''' <summary>
    ''' Sets the restoreuserdomain.
    ''' </summary>
    ''' <param name="val">The value.</param>
    Public Sub setRestoreuserdomain(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        RestoreUserDomain = val
    End Sub

    ''' <summary>
    ''' Sets the restoredate.
    ''' </summary>
    ''' <param name="val">The value.</param>
    Public Sub setRestoredate(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        RestoreDate = val
    End Sub

    ''' <summary>
    ''' Sets the datasourceowneruserid.
    ''' </summary>
    ''' <param name="val">The value.</param>
    Public Sub setDatasourceowneruserid(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("clsDATASOURCERESTOREHISTORY - SET: Field 'Datasourceowneruserid' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        DataSourceOwnerUserID = val
    End Sub

    ''' <summary>
    ''' Sets the typecontentcode.
    ''' </summary>
    ''' <param name="val">The value.</param>
    Public Sub setTypecontentcode(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        TypeContentCode = val
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
    ''' Sets the documentname.
    ''' </summary>
    ''' <param name="val">The value.</param>
    Public Sub setDocumentname(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        DocumentName = val
    End Sub

    ''' <summary>
    ''' Sets the FQN.
    ''' </summary>
    ''' <param name="val">The value.</param>
    Public Sub setFqn(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        FQN = val
    End Sub

    ''' <summary>
    ''' Sets the verifieddata.
    ''' </summary>
    ''' <param name="val">The value.</param>
    Public Sub setVerifieddata(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        VerifiedData = val
    End Sub

    ''' <summary>
    ''' Sets the origcrc.
    ''' </summary>
    ''' <param name="val">The value.</param>
    Public Sub setOrigcrc(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        OrigCrc = val
    End Sub

    ''' <summary>
    ''' Sets the restorecrc.
    ''' </summary>
    ''' <param name="val">The value.</param>
    Public Sub setRestorecrc(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        RestoreCrc = val
    End Sub



    '** Generate the GET methods 
    ''' <summary>
    ''' Gets the sourceguid.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getSourceguid() As String
        If Len(SourceGuid) = 0 Then
            MessageBox.Show("clsDATASOURCERESTOREHISTORY - GET: Field 'Sourceguid' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(SourceGuid)
    End Function

    ''' <summary>
    ''' Gets the restoredtomachine.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getRestoredtomachine() As String
        Return UTIL.RemoveSingleQuotes(RestoredToMachine)
    End Function

    ''' <summary>
    ''' Gets the restoreusername.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getRestoreusername() As String
        Return UTIL.RemoveSingleQuotes(RestoreUserName)
    End Function

    ''' <summary>
    ''' Gets the restoreuserid.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getRestoreuserid() As String
        Return UTIL.RemoveSingleQuotes(RestoreUserID)
    End Function

    ''' <summary>
    ''' Gets the restoreuserdomain.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getRestoreuserdomain() As String
        Return UTIL.RemoveSingleQuotes(RestoreUserDomain)
    End Function

    ''' <summary>
    ''' Gets the restoredate.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getRestoredate() As String
        Return UTIL.RemoveSingleQuotes(RestoreDate)
    End Function

    ''' <summary>
    ''' Gets the datasourceowneruserid.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getDatasourceowneruserid() As String
        If Len(DataSourceOwnerUserID) = 0 Then
            MessageBox.Show("clsDATASOURCERESTOREHISTORY - GET: Field 'Datasourceowneruserid' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(DataSourceOwnerUserID)
    End Function

    ''' <summary>
    ''' Gets the seqno.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getSeqno() As String
        If Len(SeqNo) = 0 Then
            MessageBox.Show("clsDATASOURCERESTOREHISTORY - GET: Field 'Seqno' cannot be NULL.")
            Return ""
        End If
        If Len(SeqNo) = 0 Then
            SeqNo = "null"
        End If
        Return SeqNo
    End Function

    ''' <summary>
    ''' Gets the typecontentcode.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getTypecontentcode() As String
        Return UTIL.RemoveSingleQuotes(TypeContentCode)
    End Function

    ''' <summary>
    ''' Gets the createdate.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getCreatedate() As String
        Return UTIL.RemoveSingleQuotes(CreateDate)
    End Function

    ''' <summary>
    ''' Gets the documentname.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getDocumentname() As String
        Return UTIL.RemoveSingleQuotes(DocumentName)
    End Function

    ''' <summary>
    ''' Gets the FQN.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getFqn() As String
        Return UTIL.RemoveSingleQuotes(FQN)
    End Function

    ''' <summary>
    ''' Gets the verifieddata.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getVerifieddata() As String
        Return UTIL.RemoveSingleQuotes(VerifiedData)
    End Function

    ''' <summary>
    ''' Gets the origcrc.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getOrigcrc() As String
        Return UTIL.RemoveSingleQuotes(OrigCrc)
    End Function

    ''' <summary>
    ''' Gets the restorecrc.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getRestorecrc() As String
        Return UTIL.RemoveSingleQuotes(RestoreCrc)
    End Function



    '** Generate the Required Fields Validation method 
    ''' <summary>
    ''' Validates the req data.
    ''' </summary>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function ValidateReqData() As Boolean
        If SourceGuid.Length = 0 Then Return False
        If DataSourceOwnerUserID.Length = 0 Then Return False
        If SeqNo.Length = 0 Then Return False
        Return True
    End Function


    '** Generate the Validation method 
    ''' <summary>
    ''' Validates the data.
    ''' </summary>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function ValidateData() As Boolean
        If SourceGuid.Length = 0 Then Return False
        If DataSourceOwnerUserID.Length = 0 Then Return False
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
        s = s + " INSERT INTO DataSourceRestoreHistory(" + vbCrLf
        s = s + "SourceGuid," + vbCrLf
        s = s + "RestoredToMachine," + vbCrLf
        s = s + "RestoreUserName," + vbCrLf
        s = s + "RestoreUserID," + vbCrLf
        s = s + "RestoreUserDomain," + vbCrLf
        s = s + "RestoreDate," + vbCrLf
        s = s + "DataSourceOwnerUserID," + vbCrLf
        s = s + "TypeContentCode," + vbCrLf
        s = s + "CreateDate)" + vbCrLf
        s = s + " values (" + vbCrLf
        s = s + "'" + SourceGuid + "'" + "," + vbCrLf
        s = s + "'" + RestoredToMachine + "'" + "," + vbCrLf
        s = s + "'" + RestoreUserName + "'" + "," + vbCrLf
        s = s + "'" + RestoreUserID + "'" + "," + vbCrLf
        s = s + "'" + RestoreUserDomain + "'" + "," + vbCrLf
        s = s + "'" + Now.ToString + "'" + "," + vbCrLf
        s = s + "'" + DataSourceOwnerUserID + "'" + "," + vbCrLf
        s = s + "'" + TypeContentCode + "'" + "," + vbCrLf
        s = s + "'" + Now.ToString + "')" + vbCrLf

        If Not HandlerAdded Then
            ''AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf gLogSQL
            'EP.setSearchSvcEndPoint(proxy)
        End If
        s = ENC2.AES256EncryptString(s)
        Dim rc As Boolean = ProxySearch.ExecuteSqlNewConnSecure(_SecureID, s, _UserID, ContractID)
        gLogSQL(rc, ENC2.AES256EncryptString(s))

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

        s = s + " update DataSourceRestoreHistory set "
        s = s + "SourceGuid = '" + getSourceguid() + "'" + ", "
        s = s + "RestoredToMachine = '" + getRestoredtomachine() + "'" + ", "
        s = s + "RestoreUserName = '" + getRestoreusername() + "'" + ", "
        s = s + "RestoreUserID = '" + getRestoreuserid() + "'" + ", "
        s = s + "RestoreUserDomain = '" + getRestoreuserdomain() + "'" + ", "
        s = s + "RestoreDate = '" + getRestoredate() + "'" + ", "
        s = s + "DataSourceOwnerUserID = '" + getDatasourceowneruserid() + "'" + ", "
        s = s + "TypeContentCode = '" + getTypecontentcode() + "'" + ", "
        s = s + "CreateDate = '" + getCreatedate() + "'" + ", "
        s = s + "DocumentName = '" + getDocumentname() + "'" + ", "
        s = s + "FQN = '" + getFqn() + "'" + ", "
        s = s + "VerifiedData = '" + getVerifieddata() + "'" + ", "
        s = s + "OrigCrc = '" + getOrigcrc() + "'" + ", "
        s = s + "RestoreCrc = '" + getRestorecrc() + "'"
        WhereClause = " " + WhereClause
        s = s + WhereClause
        If Not HandlerAdded Then
            ''AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf gLogSQL
            'EP.setSearchSvcEndPoint(proxy)
        End If

        s = ENC2.AES256EncryptString(s)
        Dim BB As Boolean = ProxySearch.ExecuteSqlNewConnSecure(_SecureID, s, _UserID, ContractID)
        gLogSQL(BB, ENC2.AES256EncryptString(s))
        Return True
    End Function




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

        s = " Delete from DataSourceRestoreHistory"
        s = s + WhereClause

        If Not HandlerAdded Then
            ''AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf gLogSQL
            'EP.setSearchSvcEndPoint(proxy)
        End If

        s = ENC2.AES256EncryptString(s)
        Dim bb As Boolean = ProxySearch.ExecuteSqlNewConnSecure(_SecureID, s, _UserID, ContractID)
        gLogSQL(bb, ENC2.AES256EncryptString(s))

        Return True

    End Function


    '** Generate the Zeroize Table method 
    ''' <summary>
    ''' Zeroizes this instance.
    ''' </summary>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function Zeroize() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        s = s + " Delete from DataSourceRestoreHistory"

        If Not HandlerAdded Then
            ''AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf gLogSQL
            'EP.setSearchSvcEndPoint(proxy)
        End If

        s = ENC2.AES256EncryptString(s)
        Dim BB As Boolean = ProxySearch.ExecuteSqlNewConnSecure(_SecureID, s, _UserID, ContractID)
        gLogSQL(BB, ENC2.AES256EncryptString(s))
        Return True

    End Function



    ''' <summary>
    ''' Finalizes this instance.
    ''' </summary>
    Protected Overrides Sub Finalize()
        Try

        Finally
            MyBase.Finalize()      'define the destructor
            HandlerAdded = False
            ''RemoveHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf gLogSQL
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try
    End Sub


End Class
