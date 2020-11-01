Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System
Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO
Imports System.Data.Sql

Public Class clsSAVEDITEMS

    '** DIM the selected table columns
    Dim DBARCH As New clsDatabaseARCH
    Dim DMA As New clsDma
    Dim UTIL As New clsUtility
    Dim LOG As New clsLogging

    Dim Userid As String = ""
    Dim SaveName As String = ""
    Dim SaveTypeCode As String = ""
    Dim ValName As String = ""
    Dim ValValue As String = ""

    '** Generate the SET methods
    Public Sub setUserid(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Userid' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        Userid = val
    End Sub

    Public Sub setSavename(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Savename' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        SaveName = val
    End Sub

    Public Sub setSavetypecode(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Savetypecode' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        SaveTypeCode = val
    End Sub

    Public Sub setValname(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Valname' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        ValName = val
    End Sub

    Public Sub setValvalue(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Valvalue' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        ValValue = val
    End Sub

    '** Generate the GET methods
    Public Function getUserid() As String
        If Len(Userid) = 0 Then
            MessageBox.Show("GET: Field 'Userid' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(Userid)
    End Function

    Public Function getSavename() As String
        If Len(SaveName) = 0 Then
            MessageBox.Show("GET: Field 'Savename' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(SaveName)
    End Function

    Public Function getSavetypecode() As String
        If Len(SaveTypeCode) = 0 Then
            MessageBox.Show("GET: Field 'Savetypecode' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(SaveTypeCode)
    End Function

    Public Function getValname() As String
        If Len(ValName) = 0 Then
            MessageBox.Show("GET: Field 'Valname' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(ValName)
    End Function

    Public Function getValvalue() As String
        If Len(ValValue) = 0 Then
            MessageBox.Show("GET: Field 'Valvalue' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(ValValue)
    End Function

    '** Generate the Required Fields Validation method
    Public Function ValidateReqData() As Boolean
        If Userid.Length = 0 Then Return False
        If SaveName.Length = 0 Then Return False
        If SaveTypeCode.Length = 0 Then Return False
        If ValName.Length = 0 Then Return False
        If ValValue.Length = 0 Then Return False
        Return True
    End Function

    '** Generate the Validation method
    Public Function ValidateData() As Boolean
        If Userid.Length = 0 Then Return False
        If SaveName.Length = 0 Then Return False
        If SaveTypeCode.Length = 0 Then Return False
        If ValName.Length = 0 Then Return False
        If ValValue.Length = 0 Then Return False
        Return True
    End Function

    '** Generate the INSERT method
    Public Function Insert() As Boolean
        Dim b As Boolean = False
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
        Return DBARCH.ExecuteSqlNewConn(s, False)

    End Function

    '** Generate the UPDATE method
    Public Function Update(ByVal WhereClause As String) As Boolean
        Dim b As Boolean = False
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
        Return DBARCH.ExecuteSqlNewConn(s, False)
    End Function

    '** Generate the SELECT method
    Public Function SelectRecs() As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "Userid,"
        s = s + "SaveName,"
        s = s + "SaveTypeCode,"
        s = s + "ValName,"
        s = s + "ValValue "
        s = s + " FROM SavedItems"

        Dim CS As String = DBARCH.setConnStr()     'DBARCH.getGateWayConnStr(gGateWayID) : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader()
        Return rsData
    End Function

    '** Generate the Select One Row method
    Public Function SelectOne(ByVal WhereClause As String) As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "Userid,"
        s = s + "SaveName,"
        s = s + "SaveTypeCode,"
        s = s + "ValName,"
        s = s + "ValValue "
        s = s + " FROM SavedItems"
        s = s + WhereClause

        Dim CS As String = DBARCH.setConnStr()     'DBARCH.getGateWayConnStr(gGateWayID) : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader()
        Return rsData
    End Function

    '** Generate the DELETE method
    Public Function Delete(ByVal WhereClause As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        If Len(WhereClause) = 0 Then Return False

        WhereClause = " " + WhereClause

        s = " Delete from SavedItems"
        s = s + WhereClause

        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b

    End Function

    '** Generate the Zeroize Table method
    Public Function Zeroize() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        s = s + " Delete from SavedItems"

        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b

    End Function

    '** Generate Index Queries
    Public Function cnt_PK_SavedItems(ByVal SaveName As String, ByVal SaveTypeCode As String, ByVal Userid As String, ByVal ValName As String) As Integer

        Dim B As Integer = 0
        Dim TBL As String = "SavedItems"
        Dim WC As String = "Where SaveName = '" + SaveName + "' and   SaveTypeCode = '" + SaveTypeCode + "' and   Userid = '" + Userid + "' and   ValName = '" + ValName + "'"

        B = DBARCH.iGetRowCount(TBL, WC)

        Return B
    End Function     '** cnt_PK_SavedItems

    '** Generate Index ROW Queries
    Public Function getRow_PK_SavedItems(ByVal SaveName As String, ByVal SaveTypeCode As String, ByVal Userid As String, ByVal ValName As String) As SqlDataReader

        Dim rsData As SqlDataReader = Nothing
        Dim TBL As String = "SavedItems"
        Dim WC As String = "Where SaveName = '" + SaveName + "' and   SaveTypeCode = '" + SaveTypeCode + "' and   Userid = '" + Userid + "' and   ValName = '" + ValName + "'"

        rsData = DBARCH.GetRowByKey(TBL, WC)

        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PK_SavedItems

    ''' Build Index Where Caluses
    '''
    Public Function wc_PK_SavedItems(ByVal SaveName As String, ByVal SaveTypeCode As String, ByVal Userid As String, ByVal ValName As String) As String

        Dim WC As String = "Where SaveName = '" + SaveName + "' and   SaveTypeCode = '" + SaveTypeCode + "' and   Userid = '" + Userid + "' and   ValName = '" + ValName + "'"

        Return WC
    End Function     '** wc_PK_SavedItems
End Class