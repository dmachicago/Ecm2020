Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System
Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO
Imports System.Data.Sql


Public Class clsFILESTODELETE


    '** DIM the selected table columns 
    Dim DB As New clsDatabaseSVR
    Dim DMA As New clsDmaSVR
    Dim UTIL As New clsUtilitySVR

    Dim DG As New clsDataGrid(SecureID)


    Dim UserID As String = ""
    Dim MachineName As String = ""
    Dim FQN As String = ""
    Dim PendingDelete As String = ""

       Dim SecureID As Integer = -1

    Sub New(ByVal iSecureID As Integer)
        SecureID = iSecureID
    End Sub


    '** Generate the SET methods 
    ''' <summary>
    ''' Sets the userid.
    ''' </summary>
    ''' <param name="val">The value.</param>
    Public Sub setUserid(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        UserID = val
    End Sub


    Public Sub setMachinename(ByRef val as string)
        val = UTIL.RemoveSingleQuotes(val)
        MachineName = val
    End Sub


    Public Sub setFqn(ByRef val as string)
        val = UTIL.RemoveSingleQuotes(val)
        FQN = val
    End Sub


    Public Sub setPendingdelete(ByRef val as string)
        If Len(val) = 0 Then
            val = "null"
        End If
        If val.Equals("Y") Then val = "1"
        If val.Equals("N") Then val = "0"
        val = UTIL.RemoveSingleQuotes(val)
        PendingDelete = val
    End Sub






    '** Generate the GET methods 
    Public Function getUserid() As String
        Return UTIL.RemoveSingleQuotes(UserID)
    End Function


    Public Function getMachinename() As String
        Return UTIL.RemoveSingleQuotes(MachineName)
    End Function


    Public Function getFqn() As String
        Return UTIL.RemoveSingleQuotes(FQN)
    End Function


    Public Function getPendingdelete() As String
        If Len(PendingDelete) = 0 Then
            PendingDelete = "null"
        End If
        Return PendingDelete
    End Function






    '** Generate the Required Fields Validation AS string 
    Public Function ValidateReqData() As Boolean
        Return True
    End Function




    '** Generate the Validation AS string 
    Public Function ValidateData() As Boolean
        Return True
    End Function

    '** Generate the INSERT AS string 
    Public Function Insert() As Boolean
        Dim b As Boolean = false
        Dim s As String = ""
        s = s + " INSERT INTO FilesToDelete("
        s = s + "UserID,"
        s = s + "MachineName,"
        s = s + "FQN,"
        s = s + "PendingDelete) values ("
        s = s + "'" + UserID + "'" + ","
        s = s + "'" + MachineName + "'" + ","
        s = s + "'" + FQN + "'" + ","
        s = s + PendingDelete + ")"
        Return DB.DBExecuteSql(SecureID, S, False)


    End Function




    '** Generate the UPDATE AS string 
    Public Function Update(ByVal WhereClause as string) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""


        If Len(WhereClause) = 0 Then Return False


        s = s + " update FilesToDelete set "
        s = s + "UserID = '" + getUserid() + "'" + ", "
        s = s + "MachineName = '" + getMachinename() + "'" + ", "
        s = s + "FQN = '" + getFqn() + "'" + ", "
        s = s + "PendingDelete = " + getPendingdelete()
        WhereClause = " " + WhereClause
        s = s + WhereClause
        Return DB.DBExecuteSql(SecureID, S, False)
    End Function




    '** Generate the SELECT AS string 
    Public Function SelectRecs() As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "UserID,"
        s = s + "MachineName,"
        s = s + "FQN,"
        s = s + "PendingDelete "
        s = s + " FROM FilesToDelete"

        Dim CS$ = DBgetConnStr() : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader()
        Return rsData
    End Function




    '** Generate the Select One Row AS string 
    Public Function SelectOne(ByVal WhereClause as string) As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "UserID,"
        s = s + "MachineName,"
        s = s + "FQN,"
        s = s + "PendingDelete "
        s = s + " FROM FilesToDelete"
        s = s + WhereClause

        Dim CS$ = DBgetConnStr() : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader()
        Return rsData
    End Function




    '** Generate the DELETE AS string 
    Public Function Delete(ByVal WhereClause as string) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""


        If Len(WhereClause) = 0 Then Return False


        WhereClause = " " + WhereClause


        s = " Delete from FilesToDelete"
        s = s + WhereClause


        b = DB.DBExecuteSql(SecureID, S, False)
        Return b


    End Function




    '** Generate the Zeroize Table AS string 
    Public Function Zeroize() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""


        s = s + " Delete from FilesToDelete"


        b = DB.DBExecuteSql(SecureID, S, False)
        Return b


    End Function

    '** Generate Index Queries 
    Public Function cnt_PK_FileToDelete(ByVal SecureID As Integer, ByVal FQN As String, ByVal MachineName As String, ByVal UserID As String) As Integer
        Dim B As Integer = 0
        Dim TBL$ = "FilesToDelete"
        Dim WC$ = "Where FQN = '" + FQN + "' and   MachineName = '" + MachineName + "' and   UserID = '" + UserID + "'"
        B = DB.iGetRowCount(TBL$, WC)
        Return B
    End Function     '** cnt_PK_FileToDelete


    '** Generate Index ROW Queries 
    Public Function getRow_PK_FileToDelete(ByVal FQN As String, ByVal MachineName As String, ByVal UserID As String) As SqlDataReader


        Dim rsData As SqlDataReader = Nothing
        Dim TBL$ = "FilesToDelete"
        Dim WC$ = "Where FQN = '" + FQN + "' and   MachineName = '" + MachineName + "' and   UserID = '" + UserID + "'"


        rsData = DB.GetRowByKey(SecureID, TBL$, WC)


        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PK_FileToDelete


    ''' Build Index Where Caluses 
    '''
    Public Function wc_PK_FileToDelete(ByVal FQN As String, ByVal MachineName As String, ByVal UserID As String) As String


        Dim WC$ = "Where FQN = '" + FQN + "' and   MachineName = '" + MachineName + "' and   UserID = '" + UserID + "'"


        Return WC
    End Function     '** wc_PK_FileToDelete


    '** Generate the SET methods 


End Class
