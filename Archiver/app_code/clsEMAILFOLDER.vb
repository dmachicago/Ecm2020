Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System
Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO
Imports System.Data.Sql


Public Class clsEMAILFOLDER


    '** DIM the selected table columns 
    Dim DBARCH As New clsDatabaseARCH
    Dim DMA As New clsDma
    Dim UTIL As New clsUtility
    Dim LOG As New clsLogging

    Dim UserID As String = ""
    Dim FolderName As String = ""
    Dim ParentFolderName As String = ""
    Dim FolderID As String = ""
    Dim ParentFolderID As String = ""
    Dim SelectedForArchive As String = ""
    Dim StoreID As String = ""




    '** Generate the SET methods 
    Public Sub setUserid(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Userid' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        UserID = val
    End Sub


    Public Sub setFoldername(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        FolderName = val
    End Sub


    Public Sub setParentfoldername(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        ParentFolderName = val
    End Sub


    Public Sub setFolderid(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Folderid' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        FolderID = val
    End Sub


    Public Sub setParentfolderid(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        ParentFolderID = val
    End Sub


    Public Sub setSelectedforarchive(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        SelectedForArchive = val
    End Sub


    Public Sub setStoreid(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        StoreID = val
    End Sub






    '** Generate the GET methods 
    Public Function getUserid() As String
        If Len(UserID) = 0 Then
            MessageBox.Show("GET: Field 'Userid' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(UserID)
    End Function


    Public Function getFoldername() As String
        Return UTIL.RemoveSingleQuotes(FolderName)
    End Function


    Public Function getParentfoldername() As String
        Return UTIL.RemoveSingleQuotes(ParentFolderName)
    End Function


    Public Function getFolderid() As String
        If Len(FolderID) = 0 Then
            MessageBox.Show("GET: Field 'Folderid' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(FolderID)
    End Function


    Public Function getParentfolderid() As String
        Return UTIL.RemoveSingleQuotes(ParentFolderID)
    End Function


    Public Function getSelectedforarchive() As String
        Return UTIL.RemoveSingleQuotes(SelectedForArchive)
    End Function


    Public Function getStoreid() As String
        Return UTIL.RemoveSingleQuotes(StoreID)
    End Function






    '** Generate the Required Fields Validation method 
    Public Function ValidateReqData() As Boolean
        If UserID.Length = 0 Then Return False
        If FolderID.Length = 0 Then Return False
        Return True
    End Function




    '** Generate the Validation method 
    Public Function ValidateData() As Boolean
        If UserID.Length = 0 Then Return False
        If FolderID.Length = 0 Then Return False
        Return True
    End Function

    '** Generate the INSERT method 
    Public Function Insert(ByVal MasterFolder As String) As Boolean

        Dim b As Boolean = False
        Dim s As String = ""
        Dim ContainerName As String = ""
        MasterFolder = UTIL.RemoveSingleQuotes(MasterFolder)

        FolderName = MasterFolder.Trim + "|" + FolderName.Trim

        FolderName = UTIL.RemoveSingleQuotes(FolderName)

        s = s + " INSERT INTO EmailFolder("
        s = s + "UserID,"
        s = s + "FolderName,"
        s = s + "ParentFolderName,"
        s = s + "FolderID,"
        s = s + "ParentFolderID,"
        If SelectedForArchive.Equals("Y") Or SelectedForArchive.Equals("N") Then
            s = s + "SelectedForArchive,"
        End If
        s = s + "StoreID, FileDirectory) values ("
        s = s + "'" + UserID + "'" + ","
        s = s + "'" + FolderName + "'" + ","
        s = s + "'" + ParentFolderName + "'" + ","
        s = s + "'" + FolderID + "'" + ","
        s = s + "'" + ParentFolderID + "'" + ","
        If SelectedForArchive.Equals("Y") Or SelectedForArchive.Equals("N") Then
            s = s + "'" + SelectedForArchive + "'" + ","
        End If
        s = s + "'" + StoreID + "'" + ","
        s = s + "'" + MasterFolder.Trim + "'" + ")"

        If FolderName.Contains("|") Then
            Dim i As Integer = FolderName.IndexOf("|")
            ContainerName = FolderName.Substring(i + 1)
        Else
            ContainerName = ""
        End If

        Dim bb As Boolean = DBARCH.ckEmailFolderExist(UserID, FolderID, FolderName, ContainerName)

        If Not bb Then
            b = DBARCH.ExecuteSqlNewConn(s, False)
        Else
            b = True
        End If

        If b Then
            Return True
        Else
            LOG.WriteToArchiveLog("ERROR: Failed to add email folder - " + MasterFolder + " : " + FolderName + " : " + ParentFolderName)
            Return False
        End If


    End Function




    '** Generate the UPDATE method 
    Public Function Update(ByVal WhereClause As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""


        If Len(WhereClause) = 0 Then Return False

        Dim SelectedForArchive As String = getSelectedforarchive()

        s = s + " update EmailFolder set " + vbCrLf
        s = s + "UserID = '" + getUserid() + "'" + ", " + vbCrLf
        s = s + "FolderName = '" + getFoldername() + "'" + ", " + vbCrLf
        s = s + "ParentFolderName = '" + getParentfoldername() + "'" + ", " + vbCrLf
        s = s + "FolderID = '" + getFolderid() + "'" + ", " + vbCrLf
        s = s + "ParentFolderID = '" + getParentfolderid() + "'" + ", " + vbCrLf
        If SelectedForArchive.Equals("Y") Or SelectedForArchive.Equals("N") Then
            s = s + "SelectedForArchive = '" + getSelectedforarchive() + "'" + ", " + vbCrLf
        End If
        s = s + "StoreID = '" + getStoreid() + "'" + vbCrLf
        WhereClause = " " + WhereClause + vbCrLf
        s = s + WhereClause + vbCrLf
        If gClipBoardActive = True Then Clipboard.Clear()
        If gClipBoardActive = True Then Clipboard.SetText(s)
        Return DBARCH.ExecuteSqlNewConn(s, False)
    End Function




    '** Generate the SELECT method 
    Public Function SelectRecs() As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "UserID,"
        s = s + "FolderName,"
        s = s + "ParentFolderName,"
        s = s + "FolderID,"
        s = s + "ParentFolderID,"
        s = s + "SelectedForArchive,"
        s = s + "StoreID "
        s = s + " FROM EmailFolder"

        Dim CS As String = DBARCH.setConnStr()     'DBARCH.getGateWayConnStr(gGateWayID) : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader()
        Return rsData
    End Function




    '** Generate the Select One Row method 
    Public Function SelectOne(ByVal WhereClause As String) As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "UserID,"
        s = s + "FolderName,"
        s = s + "ParentFolderName,"
        s = s + "FolderID,"
        s = s + "ParentFolderID,"
        s = s + "SelectedForArchive,"
        s = s + "StoreID "
        s = s + " FROM EmailFolder"
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


        s = " Delete from EmailFolder"
        s = s + WhereClause


        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b


    End Function




    '** Generate the Zeroize Table method 
    Public Function Zeroize() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""


        s = s + " Delete from EmailFolder"


        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b


    End Function




    '** Generate Index Queries 
    Public Function cnt_IDX_FolderName(ByVal FileDirectory As String, ByVal FolderName As String, ByVal UserID As String) As Integer


        Dim B As Integer = 0
        Dim TBL As String = "EmailFolder"
        Dim WC As String = "Where FileDirectory = '" + FileDirectory + "' and FolderName = '" + FolderName + "' and   UserID = '" + UserID + "'"


        B = DBARCH.iGetRowCount(TBL, WC)


        Return B
    End Function     '** cnt_IDX_FolderName
    Public Function cnt_PK_EmailFolder(ByVal FolderID As String, ByVal UserID As String) As Integer


        Dim B As Integer = 0
        Dim TBL As String = "EmailFolder"
        Dim WC As String = "Where FolderID = '" + FolderID + "' and   UserID = '" + UserID + "'"


        B = DBARCH.iGetRowCount(TBL, WC)


        Return B
    End Function     '** cnt_PK_EmailFolder
    Public Function cnt_UI_EmailFolder(ByVal TopLevelOutlookFolderName As String, ByVal FolderName As String, ByVal UserID As String) As Integer

        TopLevelOutlookFolderName = UTIL.RemoveSingleQuotes(TopLevelOutlookFolderName)
        FolderName = UTIL.RemoveSingleQuotes(FolderName)
        FolderName = TopLevelOutlookFolderName + "|" + FolderName

        Dim B As Integer = 0
        Dim TBL As String = "EmailFolder"
        Dim WC As String = "Where FolderName = '" + TopLevelOutlookFolderName + "' and FolderName = '" + FolderName + "' and   UserID = '" + UserID + "'"


        B = DBARCH.iGetRowCount(TBL, WC)


        Return B
    End Function     '** cnt_UI_EmailFolder


    '** Generate Index ROW Queries 
    Public Function getRow_IDX_FolderName(ByVal FolderName As String, ByVal UserID As String) As SqlDataReader


        Dim rsData As SqlDataReader = Nothing
        Dim TBL As String = "EmailFolder"
        Dim WC As String = "Where FolderName = '" + FolderName + "' and   UserID = '" + UserID + "'"


        rsData = DBARCH.GetRowByKey(TBL, WC)


        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_IDX_FolderName
    Public Function getRow_PK_EmailFolder(ByVal FolderID As String, ByVal UserID As String) As SqlDataReader


        Dim rsData As SqlDataReader = Nothing
        Dim TBL As String = "EmailFolder"
        Dim WC As String = "Where FolderID = '" + FolderID + "' and   UserID = '" + UserID + "'"


        rsData = DBARCH.GetRowByKey(TBL, WC)


        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PK_EmailFolder
    Public Function getRow_UI_EmailFolder(ByVal FolderName As String, ByVal UserID As String) As SqlDataReader


        Dim rsData As SqlDataReader = Nothing
        Dim TBL As String = "EmailFolder"
        Dim WC As String = "Where FolderName = '" + FolderName + "' and   UserID = '" + UserID + "'"


        rsData = DBARCH.GetRowByKey(TBL, WC)


        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_UI_EmailFolder


    ''' Build Index Where Caluses 
    '''
    Public Function wc_IDX_FolderName(ByVal FolderName As String, ByVal UserID As String) As String


        Dim WC As String = "Where FolderName = '" + FolderName + "' and   UserID = '" + UserID + "'"


        Return WC
    End Function     '** wc_IDX_FolderName
    Public Function wc_PK_EmailFolder(ByVal FolderID As String, ByVal UserID As String) As String


        Dim WC As String = "Where FolderID = '" + FolderID + "' and   UserID = '" + UserID + "'"


        Return WC
    End Function     '** wc_PK_EmailFolder
    Public Function wc_UI_EmailFolder(ByVal FileDirectory As String, ByVal FolderName As String, ByVal UserID As String) As String

        ' "where [FileDirectory] = '" + FileDirectory  + "' and FolderName = 'Personal Folders|Junk E-mail' and UserID = 'wmiller'"
        FileDirectory = UTIL.RemoveSingleQuotes(FileDirectory)
        FolderName = UTIL.RemoveSingleQuotes(FolderName)

        Dim WC As String = "where [FileDirectory] = '" + FileDirectory + "' and FolderName = '" + FolderName + "' and UserID = '" + UserID + "'"


        Return WC
    End Function     '** wc_UI_EmailFolder


    '** Generate the SET methods 


End Class
