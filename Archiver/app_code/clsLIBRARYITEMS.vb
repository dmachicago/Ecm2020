Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System
Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO
Imports System.Data.Sql


Public Class clsLIBRARYITEMS
    Inherits clsDatabaseARCH

    '** DIM the selected table columns 
    'Dim DBARCH As New clsDatabaseARCH
    Dim DMA As New clsDma
    Dim UTIL As New clsUtility
    Dim LOG As New clsLogging

    Dim SourceGuid As String = ""
    Dim ItemTitle As String = ""
    Dim ItemType As String = ""
    Dim LibraryItemGuid As String = ""
    Dim DataSourceOwnerUserID As String = ""
    Dim LibraryOwnerUserID As String = ""
    Dim LibraryName As String = ""
    Dim AddedByUserGuidId As String = ""

    '** Generate the SET methods 
    Public Sub setSourceguid(ByRef val AS String )
        val = UTIL.RemoveSingleQuotes(val)
        SourceGuid = val
    End Sub


    Public Sub setItemtitle(ByRef val AS String )
        val = UTIL.RemoveSingleQuotes(val)
        ItemTitle = val
    End Sub


    Public Sub setItemtype(ByRef val AS String )
        val = UTIL.RemoveSingleQuotes(val)
        ItemType = val
    End Sub


    Public Sub setLibraryitemguid(ByRef val AS String )
        If Len(val) = 0 Then
            messagebox.show("SET: Field 'Libraryitemguid' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        LibraryItemGuid = val
    End Sub


    Public Sub setDatasourceowneruserid(ByRef val AS String )
        val = UTIL.RemoveSingleQuotes(val)
        DataSourceOwnerUserID = val
    End Sub


    Public Sub setLibraryowneruserid(ByRef val AS String )
        If Len(val) = 0 Then
            messagebox.show("SET: Field 'Libraryowneruserid' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        LibraryOwnerUserID = val
    End Sub


    Public Sub setLibraryname(ByRef val AS String )
        If Len(val) = 0 Then
            messagebox.show("SET: Field 'Libraryname' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        LibraryName = val
    End Sub


    Public Sub setAddedbyuserguidid(ByRef val AS String )
        val = UTIL.RemoveSingleQuotes(val)
        AddedByUserGuidId = val
    End Sub






    '** Generate the GET methods 
    Public Function getSourceguid() As String
        Return UTIL.RemoveSingleQuotes(SourceGuid)
    End Function


    Public Function getItemtitle() As String
        Return UTIL.RemoveSingleQuotes(ItemTitle)
    End Function


    Public Function getItemtype() As String
        Return UTIL.RemoveSingleQuotes(ItemType)
    End Function


    Public Function getLibraryitemguid() As String
        If Len(LibraryItemGuid) = 0 Then
            messagebox.show("GET: Field 'Libraryitemguid' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(LibraryItemGuid)
    End Function


    Public Function getDatasourceowneruserid() As String
        Return UTIL.RemoveSingleQuotes(DataSourceOwnerUserID)
    End Function


    Public Function getLibraryowneruserid() As String
        If Len(LibraryOwnerUserID) = 0 Then
            messagebox.show("GET: Field 'Libraryowneruserid' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(LibraryOwnerUserID)
    End Function


    Public Function getLibraryname() As String
        If Len(LibraryName) = 0 Then
            messagebox.show("GET: Field 'Libraryname' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(LibraryName)
    End Function


    Public Function getAddedbyuserguidid() As String
        Return UTIL.RemoveSingleQuotes(AddedByUserGuidId)
    End Function






    '** Generate the Required Fields Validation method 
    Public Function ValidateReqData() As Boolean
        If LibraryItemGuid.Length = 0 Then Return False
        If LibraryOwnerUserID.Length = 0 Then Return False
        If LibraryName.Length = 0 Then Return False
        Return True
    End Function

    '** Generate the Validation method 
    Public Function ValidateData() As Boolean
        If LibraryItemGuid.Length = 0 Then Return False
        If LibraryOwnerUserID.Length = 0 Then Return False
        If LibraryName.Length = 0 Then Return False
        Return True
    End Function

    Public Function InsertIntoList(ByRef L As ArrayList) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""
        s = s + " INSERT INTO LibraryItems("
        s = s + "SourceGuid,"
        s = s + "ItemTitle,"
        s = s + "ItemType,"
        s = s + "LibraryItemGuid,"
        s = s + "DataSourceOwnerUserID,"
        s = s + "LibraryOwnerUserID,"
        s = s + "LibraryName,"
        s = s + "AddedByUserGuidId) values ("
        s = s + "'" + SourceGuid + "'" + ","
        s = s + "'" + ItemTitle + "'" + ","
        s = s + "'" + ItemType + "'" + ","
        s = s + "'" + LibraryItemGuid + "'" + ","
        s = s + "'" + DataSourceOwnerUserID + "'" + ","
        s = s + "'" + LibraryOwnerUserID + "'" + ","
        s = s + "'" + LibraryName + "'" + ","
        s = s + "'" + AddedByUserGuidId + "'" + ")"
        Application.DoEvents()
        L.Add(s)
        Return True
    End Function

    Public Function Insert(ByVal CN As SqlConnection) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""
        s = s + " INSERT INTO LibraryItems("
        s = s + "SourceGuid,"
        s = s + "ItemTitle,"
        s = s + "ItemType,"
        s = s + "LibraryItemGuid,"
        s = s + "DataSourceOwnerUserID,"
        s = s + "LibraryOwnerUserID,"
        s = s + "LibraryName,"
        s = s + "AddedByUserGuidId) values ("
        s = s + "'" + SourceGuid + "'" + ","
        s = s + "'" + ItemTitle + "'" + ","
        s = s + "'" + ItemType + "'" + ","
        s = s + "'" + LibraryItemGuid + "'" + ","
        s = s + "'" + DataSourceOwnerUserID + "'" + ","
        s = s + "'" + LibraryOwnerUserID + "'" + ","
        s = s + "'" + LibraryName + "'" + ","
        s = s + "'" + AddedByUserGuidId + "'" + ")"
        Application.DoEvents()
        Return ExecuteSqlSameConn(s, CN)


    End Function

    '** Generate the INSERT method 
    Public Function Insert() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""
        s = s + " INSERT INTO LibraryItems("
        s = s + "SourceGuid,"
        s = s + "ItemTitle,"
        s = s + "ItemType,"
        s = s + "LibraryItemGuid,"
        s = s + "DataSourceOwnerUserID,"
        s = s + "LibraryOwnerUserID,"
        s = s + "LibraryName,"
        s = s + "AddedByUserGuidId) values ("
        s = s + "'" + SourceGuid + "'" + ","
        s = s + "'" + ItemTitle + "'" + ","
        s = s + "'" + ItemType + "'" + ","
        s = s + "'" + LibraryItemGuid + "'" + ","
        s = s + "'" + DataSourceOwnerUserID + "'" + ","
        s = s + "'" + LibraryOwnerUserID + "'" + ","
        s = s + "'" + LibraryName + "'" + ","
        s = s + "'" + AddedByUserGuidId + "'" + ")"
        Application.DoEvents()
        Return ExecuteSqlNewConn(s, False)


    End Function




    '** Generate the UPDATE method 
    Public Function Update(ByVal WhereClause AS String ) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""


        If Len(WhereClause) = 0 Then Return False


        s = s + " update LibraryItems set "
        s = s + "SourceGuid = '" + getSourceguid() + "'" + ", "
        s = s + "ItemTitle = '" + getItemtitle() + "'" + ", "
        s = s + "ItemType = '" + getItemtype() + "'" + ", "
        s = s + "LibraryItemGuid = '" + getLibraryitemguid() + "'" + ", "
        s = s + "DataSourceOwnerUserID = '" + getDatasourceowneruserid() + "'" + ", "
        s = s + "LibraryOwnerUserID = '" + getLibraryowneruserid() + "'" + ", "
        s = s + "LibraryName = '" + getLibraryname() + "'" + ", "
        s = s + "AddedByUserGuidId = '" + getAddedbyuserguidid() + "'"
        WhereClause = " " + WhereClause
        s = s + WhereClause
        Return ExecuteSqlNewConn(s, False)
    End Function




    '** Generate the SELECT method 
    Public Function SelectRecs() As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "SourceGuid,"
        s = s + "ItemTitle,"
        s = s + "ItemType,"
        s = s + "LibraryItemGuid,"
        s = s + "DataSourceOwnerUserID,"
        s = s + "LibraryOwnerUserID,"
        s = s + "LibraryName,"
        s = s + "AddedByUserGuidId "
        s = s + " FROM LibraryItems"

Dim CS AS String  = setConnStr() : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader() 
        Return rsData
    End Function




    '** Generate the Select One Row method 
    Public Function SelectOne(ByVal WhereClause AS String ) As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "SourceGuid,"
        s = s + "ItemTitle,"
        s = s + "ItemType,"
        s = s + "LibraryItemGuid,"
        s = s + "DataSourceOwnerUserID,"
        s = s + "LibraryOwnerUserID,"
        s = s + "LibraryName,"
        s = s + "AddedByUserGuidId "
        s = s + " FROM LibraryItems"
        s = s + WhereClause

Dim CS AS String  = setConnStr() : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader() 
        Return rsData
    End Function




    '** Generate the DELETE method 
    Public Function Delete(ByVal WhereClause AS String ) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""


        If Len(WhereClause) = 0 Then Return False


        WhereClause = " " + WhereClause


        s = " Delete from LibraryItems"
        s = s + WhereClause


        b = ExecuteSqlNewConn(s, False)
        Return b


    End Function




    '** Generate the Zeroize Table method 
    Public Function Zeroize() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""


        s = s + " Delete from LibraryItems"


        b = ExecuteSqlNewConn(s, False)
        Return b


    End Function




    '** Generate Index Queries 
    Public Function cnt_PI01_LibItems(ByVal ItemTitle As String) As Integer


        Dim B As Integer = 0
Dim TBL AS String  = "LibraryItems" 
Dim WC AS String  = "Where ItemTitle = '" + ItemTitle + "'" 


        B = iGetRowCount(TBL , WC)


        Return B
    End Function     '** cnt_PI01_LibItems
    Public Function cnt_PK89(ByVal LibraryItemGuid As String, ByVal LibraryName As String, ByVal LibraryOwnerUserID As String) As Integer


        Dim B As Integer = 0
Dim TBL AS String  = "LibraryItems" 
Dim WC AS String  = "Where LibraryItemGuid = '" + LibraryItemGuid + "' and   LibraryName = '" + LibraryName + "' and   LibraryOwnerUserID = '" + LibraryOwnerUserID + "'" 


        B = iGetRowCount(TBL , WC)


        Return B
    End Function     '** cnt_PK89
    Public Function cnt_UI_LibItems(ByVal LibraryName As String, ByVal SourceGuid As String) As Integer


        Dim B As Integer = 0
Dim TBL AS String  = "LibraryItems" 
Dim WC AS String  = "Where LibraryName = '" + LibraryName + "' and   SourceGuid = '" + SourceGuid + "'" 


        B = iGetRowCount(TBL , WC)


        Return B
    End Function     '** cnt_UI_LibItems
    Public Function cnt_UK_LibItems(ByVal LibraryItemGuid As String) As Integer


        Dim B As Integer = 0
Dim TBL AS String  = "LibraryItems" 
Dim WC AS String  = "Where LibraryItemGuid = '" + LibraryItemGuid + "'" 


        B = iGetRowCount(TBL , WC)


        Return B
    End Function     '** cnt_UK_LibItems

    Public Function cnt_UniqueEntry(ByVal LibraryName AS String , ByVal SourceGuid As String) As Integer

        LibraryName = UTIL.RemoveSingleQuotes(LibraryName)

        Dim B As Integer = 0
Dim TBL AS String  = "LibraryItems" 
Dim WC AS String  = "Where LibraryName = '" + LibraryName + "' and SourceGuid = '" + SourceGuid + "' " 


        B = iGetRowCount(TBL , WC)


        Return B
    End Function     '** cnt_UK_LibItems


    '** Generate Index ROW Queries 
    Public Function getRow_PI01_LibItems(ByVal ItemTitle As String) As SqlDataReader


        Dim rsData As SqlDataReader = Nothing
Dim TBL AS String  = "LibraryItems" 
Dim WC AS String  = "Where ItemTitle = '" + ItemTitle + "'" 


        rsData = GetRowByKey(TBL , WC)


        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PI01_LibItems
    Public Function getRow_PK89(ByVal LibraryItemGuid As String, ByVal LibraryName As String, ByVal LibraryOwnerUserID As String) As SqlDataReader


        Dim rsData As SqlDataReader = Nothing
Dim TBL AS String  = "LibraryItems" 
Dim WC AS String  = "Where LibraryItemGuid = '" + LibraryItemGuid + "' and   LibraryName = '" + LibraryName + "' and   LibraryOwnerUserID = '" + LibraryOwnerUserID + "'" 


        rsData = GetRowByKey(TBL , WC)


        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PK89
    Public Function getRow_UI_LibItems(ByVal LibraryName As String, ByVal SourceGuid As String) As SqlDataReader


        Dim rsData As SqlDataReader = Nothing
Dim TBL AS String  = "LibraryItems" 
Dim WC AS String  = "Where LibraryName = '" + LibraryName + "' and   SourceGuid = '" + SourceGuid + "'" 


        rsData = GetRowByKey(TBL , WC)


        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_UI_LibItems
    Public Function getRow_UK_LibItems(ByVal LibraryItemGuid As String) As SqlDataReader


        Dim rsData As SqlDataReader = Nothing
Dim TBL AS String  = "LibraryItems" 
Dim WC AS String  = "Where LibraryItemGuid = '" + LibraryItemGuid + "'" 


        rsData = GetRowByKey(TBL , WC)


        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_UK_LibItems


    ''' Build Index Where Caluses 
    '''
    Public Function wc_PI01_LibItems(ByVal ItemTitle As String) As String


Dim WC AS String  = "Where ItemTitle = '" + ItemTitle + "'" 


        Return WC
    End Function     '** wc_PI01_LibItems
    Public Function wc_PK89(ByVal LibraryItemGuid As String, ByVal LibraryName As String, ByVal LibraryOwnerUserID As String) As String


Dim WC AS String  = "Where LibraryItemGuid = '" + LibraryItemGuid + "' and   LibraryName = '" + LibraryName + "' and   LibraryOwnerUserID = '" + LibraryOwnerUserID + "'" 


        Return WC
    End Function     '** wc_PK89
    Public Function wc_UI_LibItems(ByVal LibraryName As String, ByVal SourceGuid As String) As String


Dim WC AS String  = "Where LibraryName = '" + LibraryName + "' and   SourceGuid = '" + SourceGuid + "'" 


        Return WC
    End Function     '** wc_UI_LibItems
    Public Function wc_UK_LibItems(ByVal LibraryItemGuid As String) As String


Dim WC AS String  = "Where LibraryItemGuid = '" + LibraryItemGuid + "'" 


        Return WC
    End Function     '** wc_UK_LibItems


    '** Generate the SET methods 


End Class
