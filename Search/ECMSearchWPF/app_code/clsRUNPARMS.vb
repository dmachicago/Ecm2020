' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 06-28-2020
'
' Last Modified By : wdale
' Last Modified On : 06-28-2020
' ***********************************************************************
' <copyright file="clsRUNPARMS.vb" company="D. Miller and Associates, Limited">
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
''' Class clsRUNPARMS.
''' </summary>
Public Class clsRUNPARMS


    '** DIM the selected table columns 
    '    Dim DB As New clsDatabase
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
    ''' The parm
    ''' </summary>
    Dim Parm As String = ""
    ''' <summary>
    ''' The parm value
    ''' </summary>
    Dim ParmValue As String = ""
    ''' <summary>
    ''' The user identifier
    ''' </summary>
    Dim UserID As String = ""




    '** Generate the SET methods 
    ''' <summary>
    ''' Sets the parm.
    ''' </summary>
    ''' <param name="val">The value.</param>
    Public Sub setParm(ByRef val$)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Parm' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        Parm = val
    End Sub


    ''' <summary>
    ''' Sets the parmvalue.
    ''' </summary>
    ''' <param name="val">The value.</param>
    Public Sub setParmvalue(ByRef val$)
        val = UTIL.RemoveSingleQuotes(val)
        ParmValue = val
    End Sub


    ''' <summary>
    ''' Sets the userid.
    ''' </summary>
    ''' <param name="val">The value.</param>
    Public Sub setUserid(ByRef val$)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Userid' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        UserID = val
    End Sub






    '** Generate the GET methods 
    ''' <summary>
    ''' Gets the parm.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getParm() As String
        If Len(Parm) = 0 Then
            MessageBox.Show("GET: Field 'Parm' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(Parm)
    End Function


    ''' <summary>
    ''' Gets the parmvalue.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getParmvalue() As String
        Return UTIL.RemoveSingleQuotes(ParmValue)
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






    '** Generate the Required Fields Validation method 
    ''' <summary>
    ''' Validates the req data.
    ''' </summary>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function ValidateReqData() As Boolean
        If Parm.Length = 0 Then Return False
        If UserID.Length = 0 Then Return False
        Return True
    End Function




    '** Generate the Validation method 
    ''' <summary>
    ''' Validates the data.
    ''' </summary>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function ValidateData() As Boolean
        If Parm.Length = 0 Then Return False
        If UserID.Length = 0 Then Return False
        Return True
    End Function




    '** Generate the INSERT method 
    ''' <summary>
    ''' Inserts this instance.
    ''' </summary>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function Insert() As Boolean
        Dim b As Boolean = True
        Dim s As String = ""
        s = s + " INSERT INTO RunParms("
        s = s + "Parm,"
        s = s + "ParmValue,"
        s = s + "UserID) values ("
        s = s + "'" + Parm + "'" + ","
        s = s + "'" + ParmValue + "'" + ","
        s = s + "'" + UserID + "'" + ")"
        ExecuteSql(_SecureID, s)

        Return b

    End Function




    '** Generate the UPDATE method 
    ''' <summary>
    ''' Updates the specified where clause.
    ''' </summary>
    ''' <param name="WhereClause">The where clause.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function Update(ByVal WhereClause$) As Boolean
        Dim b As Boolean = True
        Dim s As String = ""


        If Len(WhereClause) = 0 Then Return False


        s = s + " update RunParms set "
        's = s + "Parm = '" + getParm() + "'" + ", "
        s = s + "ParmValue = '" + getParmvalue() + "'" + ", "
        s = s + "UserID = '" + getUserid() + "'"
        WhereClause = " " + WhereClause
        s = s + WhereClause
        ExecuteSql(_SecureID, s)
        Return b
    End Function




    ''** Generate the SELECT method 
    'Public Function SelectRecs() As SqlDataReader
    '    Dim b As Boolean = true
    '    Dim s As String = ""
    '    Dim rsData As SqlDataReader
    '    s = s + " SELECT "
    '    s = s + "Parm,"
    '    s = s + "ParmValue,"
    '    s = s + "UserID "
    '    s = s + " FROM RunParms"

    '    Dim CS$ = db.getConnStr() : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(S, CONN) : rsdata = command.ExecuteReader()
    '    Return rsData
    'End Function




    ''** Generate the Select One Row method 
    'Public Function SelectOne(ByVal WhereClause$) As SqlDataReader
    '    Dim b As Boolean = true
    '    Dim s As String = ""
    '    Dim rsData As SqlDataReader
    '    s = s + " SELECT "
    '    s = s + "Parm,"
    '    s = s + "ParmValue,"
    '    s = s + "UserID "
    '    s = s + " FROM RunParms "
    '    s = s + WhereClause

    '    Dim CS$ = db.getConnStr() : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(S, CONN) : rsdata = command.ExecuteReader()
    '    Return rsData
    'End Function




    '** Generate the DELETE method 
    ''' <summary>
    ''' Deletes the specified where clause.
    ''' </summary>
    ''' <param name="WhereClause">The where clause.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function Delete(ByVal WhereClause$) As Boolean
        Dim b As Boolean = True
        Dim s As String = ""


        If Len(WhereClause) = 0 Then Return False


        WhereClause = " " + WhereClause


        s = " Delete from RunParms "
        s = s + WhereClause

        Return b


    End Function




    '** Generate the Zeroize Table method 
    ''' <summary>
    ''' Zeroizes this instance.
    ''' </summary>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function Zeroize() As Boolean
        Dim b As Boolean = True
        Dim s As String = ""


        s = s + " Delete from RunParms "


        ExecuteSql(_SecureID, s)
        Return b


    End Function




    ''** Generate Index Queries 
    'Public Function cnt_PKI8(ByVal Parm As String, ByVal UserID As String) As Integer


    '    Dim B As Integer = 0
    '    Dim TBL$ = "RunParms"
    '    Dim WC$ = "Where Parm = '" + Parm + "' and   UserID = '" + UserID + "'"


    '    B = DB.iGetRowCount(TBL$, WC)


    '    Return B
    'End Function     '** cnt_PKI8


    ''** Generate Index ROW Queries 
    'Public Function getRow_PKI8(ByVal Parm As String, ByVal UserID As String) As SqlDataReader

    '    Dim rsData As SqlDataReader = Nothing
    '    Dim TBL$ = "RunParms"
    '    Dim WC$ = "Where Parm = '" + Parm + "' and   UserID = '" + UserID + "'"

    '    rsData = DB.GetRowByKey(TBL$, WC)
    '    If rsData Is Nothing Then
    '        Return Nothing
    '    End If
    '    If rsData.HasRows Then
    '        Return rsData
    '    Else
    '        Return Nothing
    '    End If
    'End Function     '** getRow_PKI8


    ''' <summary>
    ''' Wcs the pk i8.
    ''' </summary>
    ''' <param name="Parm">The parm.</param>
    ''' <param name="UserID">The user identifier.</param>
    ''' <returns>System.String.</returns>
    ''' Build Index Where Caluses
    Public Function wc_PKI8(ByVal Parm As String, ByVal UserID As String) As String


        Dim WC$ = "Where Parm = '" + Parm + "' and   UserID = '" + UserID + "'"


        Return WC
    End Function     '** wc_PKI8


    '** Generate the SET methods 


End Class
