Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System
Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO
Imports System.Data.Sql
 
Public Class clsACTIVELICENSE

    '** DIM the selected table columns 
    Dim DB As New clsDatabase
    Dim DMA As New clsDma
    '    Dim DG As New clsDataGrid

    Dim License As String = ""
    Dim InstallDate As String = ""


    '** Generate the SET methods 
    Public Sub setLicense(ByRef val$)
        If Len(val) = 0 Then
            MsgBox("SET: Field 'License' cannot be NULL.")
            Return
        End If
        val = DMA.RemoveSingleQuotes(val)
        License = val
    End Sub

    Public Sub setInstalldate(ByRef val$)
        If Len(val) = 0 Then
            MsgBox("SET: Field 'Installdate' cannot be NULL.")
            Return
        End If
        val = DMA.RemoveSingleQuotes(val)
        InstallDate = val
    End Sub



    '** Generate the GET methods 
    Public Function getLicense() As String
        If Len(License) = 0 Then
            MsgBox("GET: Field 'License' cannot be NULL.")
            Return ""
        End If
        Return DMA.RemoveSingleQuotes(License)
    End Function

    Public Function getInstalldate() As String
        If Len(InstallDate) = 0 Then
            MsgBox("GET: Field 'Installdate' cannot be NULL.")
            Return ""
        End If
        Return DMA.RemoveSingleQuotes(InstallDate)
    End Function



    '** Generate the Required Fields Validation method 
    Public Function ValidateReqData() As Boolean
        If License.Length = 0 Then Return False
        If InstallDate.Length = 0 Then Return False
        Return True
    End Function


    '** Generate the Validation method 
    Public Function ValidateData() As Boolean
        If License.Length = 0 Then Return False
        If InstallDate.Length = 0 Then Return False
        Return True
    End Function


    '** Generate the INSERT method 
    Public Function Insert() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""
        s = s + " INSERT INTO ActiveLicense("
        s = s + "License,"
        s = s + "InstallDate) values ("
        s = s + "'" + License + "'" + ","
        s = s + "'" + InstallDate + "'" + ")"
        Return DB.ExecuteSql(s)

    End Function
    Public Sub ZeroizeTbl()
        Dim b As Boolean = False
        Dim s As String = ""
        s = s + " delete from ActiveLicense "
        DB.ExecuteSql(s)
    End Sub

    '** Generate the UPDATE method 
    Public Function Update(ByVal WhereClause$) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        If Len(WhereClause) = 0 Then Return False

        s = s + " update ActiveLicense set "
        s = s + "License = '" + getLicense() + "'" + ", "
        s = s + "InstallDate = '" + getInstalldate() + "'"
        WhereClause = " " + WhereClause
        s = s + WhereClause
        Return DB.ExecuteSql(s)
    End Function


    '** Generate the SELECT method 
    Public Function SelectRecs() As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "License,"
        s = s + "InstallDate "
        s = s + " FROM ActiveLicense"
        '** s=s+ "ORDERBY xxxx"
        rsData = DB.SqlQry(s)
        Return rsData
    End Function


    '** Generate the Select One Row method 
    Public Function SelectOne(ByVal WhereClause$) As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "License,"
        s = s + "InstallDate "
        s = s + " FROM ActiveLicense"
        s = s + WhereClause
        '** s=s+ "ORDERBY xxxx"
        rsData = DB.SqlQry(s)
        Return rsData
    End Function


    '** Generate the DELETE method 
    Public Function Delete(ByVal WhereClause$) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        If Len(WhereClause) = 0 Then Return False

        WhereClause = " " + WhereClause

        s = " Delete from ActiveLicense"
        s = s + WhereClause

        b = DB.ExecuteSql(s)
        Return b

    End Function


    '** Generate the Zeroize Table method 
    Public Function Zeroize() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        s = s + " Delete from ActiveLicense"

        b = DB.ExecuteSql(s)
        Return b

    End Function


    '** Generate Index Queries 

    '** Generate Index ROW Queries 

    ''' Build Index Where Caluses 
    '''

    '** Generate the SET methods 

End Class
