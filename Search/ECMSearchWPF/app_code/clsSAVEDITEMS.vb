' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 06-28-2020
'
' Last Modified By : wdale
' Last Modified On : 06-28-2020
' ***********************************************************************
' <copyright file="clsSAVEDITEMS.vb" company="D. Miller and Associates, Limited">
'     Copyright @ DMA Ltd 2020 all rights reserved.
' </copyright>
' <summary></summary>
' ***********************************************************************
Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System
Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO
Imports System.Data.Sql


''' <summary>
''' Class clsSAVEDITEMS.
''' </summary>
Public Class clsSAVEDITEMS


    '** DIM the selected table columns 
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
    ''' The userid
    ''' </summary>
    Dim Userid As String = ""
    ''' <summary>
    ''' The save name
    ''' </summary>
    Dim SaveName As String = ""
    ''' <summary>
    ''' The save type code
    ''' </summary>
    Dim SaveTypeCode As String = ""
    ''' <summary>
    ''' The value name
    ''' </summary>
    Dim ValName As String = ""
    ''' <summary>
    ''' The value value
    ''' </summary>
    Dim ValValue As String = ""

    '** Generate the SET methods 
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
        Userid = val
    End Sub


    ''' <summary>
    ''' Sets the savename.
    ''' </summary>
    ''' <param name="val">The value.</param>
    Public Sub setSavename(ByRef val$)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Savename' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        SaveName = val
    End Sub


    ''' <summary>
    ''' Sets the savetypecode.
    ''' </summary>
    ''' <param name="val">The value.</param>
    Public Sub setSavetypecode(ByRef val$)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Savetypecode' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        SaveTypeCode = val
    End Sub


    ''' <summary>
    ''' Sets the valname.
    ''' </summary>
    ''' <param name="val">The value.</param>
    Public Sub setValname(ByRef val$)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Valname' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        ValName = val
    End Sub


    ''' <summary>
    ''' Sets the valvalue.
    ''' </summary>
    ''' <param name="val">The value.</param>
    Public Sub setValvalue(ByRef val$)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Valvalue' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        ValValue = val
    End Sub






    '** Generate the GET methods 
    ''' <summary>
    ''' Gets the userid.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getUserid() As String
        If Len(Userid) = 0 Then
            MessageBox.Show("GET: Field 'Userid' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(Userid)
    End Function


    ''' <summary>
    ''' Gets the savename.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getSavename() As String
        If Len(SaveName) = 0 Then
            MessageBox.Show("GET: Field 'Savename' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(SaveName)
    End Function


    ''' <summary>
    ''' Gets the savetypecode.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getSavetypecode() As String
        If Len(SaveTypeCode) = 0 Then
            MessageBox.Show("GET: Field 'Savetypecode' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(SaveTypeCode)
    End Function


    ''' <summary>
    ''' Gets the valname.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getValname() As String
        If Len(ValName) = 0 Then
            MessageBox.Show("GET: Field 'Valname' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(ValName)
    End Function


    ''' <summary>
    ''' Gets the valvalue.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getValvalue() As String
        If Len(ValValue) = 0 Then
            MessageBox.Show("GET: Field 'Valvalue' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(ValValue)
    End Function






    '** Generate the Required Fields Validation method 
    ''' <summary>
    ''' Validates the req data.
    ''' </summary>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function ValidateReqData() As Boolean
        If Userid.Length = 0 Then Return False
        If SaveName.Length = 0 Then Return False
        If SaveTypeCode.Length = 0 Then Return False
        If ValName.Length = 0 Then Return False
        If ValValue.Length = 0 Then Return False
        Return True
    End Function




    '** Generate the Validation method 
    ''' <summary>
    ''' Validates the data.
    ''' </summary>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function ValidateData() As Boolean
        If Userid.Length = 0 Then Return False
        If SaveName.Length = 0 Then Return False
        If SaveTypeCode.Length = 0 Then Return False
        If ValName.Length = 0 Then Return False
        If ValValue.Length = 0 Then Return False
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
        s = s + " INSERT INTO SavedItems("
        s = s + "Userid,"
        s = s + "SaveName,"
        s = s + "SaveTypeCode,"
        s = s + "ValName,"
        s = s + "ValValue) values ("
        s = s + "'" + Userid + "'" + ","
        s = s + "'" + SaveName + "'" + ","
        s = s + "'" + SaveTypeCode + "'" + ","
        s = s + "'" + ValName + "'" + ","
        s = s + "'" + ValValue + "'" + ")"
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


        s = s + " update SavedItems set "
        s = s + "Userid = '" + getUserid() + "'" + ", "
        s = s + "SaveName = '" + getSavename() + "'" + ", "
        s = s + "SaveTypeCode = '" + getSavetypecode() + "'" + ", "
        s = s + "ValName = '" + getValname() + "'" + ", "
        s = s + "ValValue = '" + getValvalue() + "'"
        WhereClause = " " + WhereClause
        s = s + WhereClause
        ExecuteSql(_SecureID, s)
        Return b
    End Function

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


        s = " Delete from SavedItems"
        s = s + WhereClause


        ExecuteSql(_SecureID, s)
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

        s = s + " Delete from SavedItems"

        ExecuteSql(_SecureID, s)
        Return b


    End Function




    ''** Generate Index Queries 
    'Public Function cnt_PK_SavedItems(ByVal SaveName As String, ByVal SaveTypeCode As String, ByVal Userid As String, ByVal ValName As String) As Integer


    '    Dim B As Integer = 0
    '    Dim TBL$ = "SavedItems"
    '    Dim WC$ = "Where SaveName = '" + SaveName + "' and   SaveTypeCode = '" + SaveTypeCode + "' and   Userid = '" + Userid + "' and   ValName = '" + ValName + "'"


    '    B = DB.iGetRowCount(TBL$, WC)


    '    Return B
    'End Function     '** cnt_PK_SavedItems


    ''** Generate Index ROW Queries 
    'Public Function getRow_PK_SavedItems(ByVal SaveName As String, ByVal SaveTypeCode As String, ByVal Userid As String, ByVal ValName As String) As SqlDataReader


    '    Dim rsData As SqlDataReader = Nothing
    '    Dim TBL$ = "SavedItems"
    '    Dim WC$ = "Where SaveName = '" + SaveName + "' and   SaveTypeCode = '" + SaveTypeCode + "' and   Userid = '" + Userid + "' and   ValName = '" + ValName + "'"


    '    rsData = DB.GetRowByKey(TBL$, WC)


    '    If rsData.HasRows Then
    '        Return rsData
    '    Else
    '        Return Nothing
    '    End If
    'End Function     '** getRow_PK_SavedItems


    ''' <summary>
    ''' Wcs the pk saved items.
    ''' </summary>
    ''' <param name="SaveName">Name of the save.</param>
    ''' <param name="SaveTypeCode">The save type code.</param>
    ''' <param name="Userid">The userid.</param>
    ''' <param name="ValName">Name of the value.</param>
    ''' <returns>System.String.</returns>
    ''' Build Index Where Caluses
    Public Function wc_PK_SavedItems(ByVal SaveName As String, ByVal SaveTypeCode As String, ByVal Userid As String, ByVal ValName As String) As String


        Dim WC$ = "Where SaveName = '" + SaveName + "' and   SaveTypeCode = '" + SaveTypeCode + "' and   Userid = '" + Userid + "' and   ValName = '" + ValName + "'"


        Return WC
    End Function     '** wc_PK_SavedItems
End Class
