Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System
Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO
Imports System.Data.Sql
 
Public Class clsHELPTEXT

    '** DIM the selected table columns 
    Dim DBARCH As New clsDatabaseARCH
    Dim DMA As New clsDma
    Dim DG As New clsDataGrid

    Dim UTIL As New clsUtility
    Dim LOG As New clsLogging


    Dim ScreenName As String = ""
    Dim HelpText As String = ""
    Dim WidgetName As String = ""
    Dim WidgetText As String = ""
    Dim DisplayHelpText As String = ""
    Dim LastUpdate As String = ""
    Dim CreateDate As String = ""
    Dim UpdatedBy As String = ""


    '** Generate the SET methods 
    Public Sub setScreenname(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Screenname' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        ScreenName = val
    End Sub

    Public Sub setHelptext(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        HelpText = val
    End Sub

    Public Sub setWidgetname(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Widgetname' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        WidgetName = val
    End Sub

    Public Sub setWidgettext(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        WidgetText = val
    End Sub

    Public Sub setDisplayhelptext(ByRef val As String)
        If Len(val) = 0 Then
            val = "null"
        End If
        val = UTIL.RemoveSingleQuotes(val)
        DisplayHelpText = val
    End Sub

    Public Sub setLastupdate(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        LastUpdate = val
    End Sub

    Public Sub setCreatedate(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        CreateDate = val
    End Sub

    Public Sub setUpdatedby(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        UpdatedBy = val
    End Sub



    '** Generate the GET methods 
    Public Function getScreenname() As String
        If Len(ScreenName) = 0 Then
            MessageBox.Show("GET: Field 'Screenname' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(ScreenName)
    End Function

    Public Function getHelptext() As String
        Return UTIL.RemoveSingleQuotes(HelpText)
    End Function

    Public Function getWidgetname() As String
        If Len(WidgetName) = 0 Then
            MessageBox.Show("GET: Field 'Widgetname' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(WidgetName)
    End Function

    Public Function getWidgettext() As String
        Return UTIL.RemoveSingleQuotes(WidgetText)
    End Function

    Public Function getDisplayhelptext() As String
        If Len(DisplayHelpText) = 0 Then
            DisplayHelpText = "null"
        End If
        Return DisplayHelpText
    End Function

    Public Function getLastupdate() As String
        Return UTIL.RemoveSingleQuotes(LastUpdate)
    End Function

    Public Function getCreatedate() As String
        Return UTIL.RemoveSingleQuotes(CreateDate)
    End Function

    Public Function getUpdatedby() As String
        Return UTIL.RemoveSingleQuotes(UpdatedBy)
    End Function



    '** Generate the Required Fields Validation method 
    Public Function ValidateReqData() As Boolean
        If ScreenName.Length = 0 Then Return False
        If WidgetName.Length = 0 Then Return False
        Return True
    End Function


    '** Generate the Validation method 
    Public Function ValidateData() As Boolean
        If ScreenName.Length = 0 Then Return False
        If WidgetName.Length = 0 Then Return False
        Return True
    End Function


    '** Generate the INSERT method 
    Public Function Insert() As Boolean
        Dim b As Boolean = False
        If LastUpdate.Trim.Length = 0 Then LastUpdate = Now.ToString
        If DisplayHelpText.Trim.Length = 0 Then DisplayHelpText = "0"
        Dim s As String = ""
        s = s + " INSERT INTO HelpText("
        s = s + "ScreenName,"
        s = s + "HelpText,"
        s = s + "WidgetName,"
        s = s + "WidgetText,"
        s = s + "DisplayHelpText,"
        s = s + "LastUpdate,"
        s = s + "UpdatedBy) values ("
        s = s + "'" + ScreenName + "'" + ","
        s = s + "'" + HelpText + "'" + ","
        s = s + "'" + WidgetName + "'" + ","
        s = s + "'" + WidgetText + "'" + ","
        s = s + DisplayHelpText + ","
        s = s + "'" + LastUpdate + "'" + ","
        s = s + "'" + UpdatedBy + "'" + ")"
        Return DBARCH.ExecuteSqlNewConn(s, False)

    End Function

    Public Function InsertRemote(ByVal ConnStr As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""
        If LastUpdate.Trim.Length = 0 Then LastUpdate = Now.ToString
        If DisplayHelpText.Trim.Length = 0 Then DisplayHelpText = "0"
        s = s + " INSERT INTO HelpText("
        s = s + "ScreenName,"
        s = s + "HelpText,"
        s = s + "WidgetName,"
        s = s + "WidgetText,"
        s = s + "DisplayHelpText,"
        s = s + "LastUpdate,"
        s = s + "UpdatedBy) values ("
        s = s + "'" + ScreenName + "'" + ","
        s = s + "'" + HelpText + "'" + ","
        s = s + "'" + WidgetName + "'" + ","
        s = s + "'" + WidgetText + "'" + ","
        s = s + DisplayHelpText + ","
        s = s + "'" + LastUpdate + "'" + ","
        s = s + "'" + UpdatedBy + "'" + ")"
        Return DBARCH.ExecuteSqlNewConn(s, ConnStr, b)

    End Function

    '** Generate the UPDATE method 
    Public Function Update(ByVal WhereClause As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        If Len(WhereClause) = 0 Then Return False

        s = s + " update HelpText set "
        's = s + "ScreenName = '" + getScreenname() + "'" + ", "
        s = s + "HelpText = '" + getHelptext() + "'" + ", "
        's = s + "WidgetName = '" + getWidgetname() + "'" + ", "
        s = s + "WidgetText = '" + getWidgettext() + "'" + ", "
        s = s + "DisplayHelpText = " + getDisplayhelptext() + ", "
        s = s + "LastUpdate = '" + getLastupdate() + "'" + ", "
        s = s + "CreateDate = '" + getCreatedate() + "'" + ", "
        s = s + "UpdatedBy = '" + getUpdatedby() + "'"
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
        s = s + "ScreenName,"
        s = s + "HelpText,"
        s = s + "WidgetName,"
        s = s + "WidgetText,"
        s = s + "DisplayHelpText,"
        s = s + "LastUpdate,"
        s = s + "CreateDate,"
        s = s + "UpdatedBy "
        s = s + " FROM HelpText"

        Dim CS As String = DBARCH.setConnStr()     'DBARCH.getGateWayConnStr(gGateWayID) : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader()
        Return rsData
    End Function


    '** Generate the Select One Row method 
    Public Function SelectOne(ByVal WhereClause As String) As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "ScreenName,"
        s = s + "HelpText,"
        s = s + "WidgetName,"
        s = s + "WidgetText,"
        s = s + "DisplayHelpText,"
        s = s + "LastUpdate,"
        s = s + "CreateDate,"
        s = s + "UpdatedBy "
        s = s + " FROM HelpText"
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

        s = " Delete from HelpText"
        s = s + WhereClause

        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b

    End Function


    '** Generate the Zeroize Table method 
    Public Function Zeroize() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        s = s + " Delete from HelpText"

        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b

    End Function


    '** Generate Index Queries 
    Public Function cnt_PK_HelpText(ByVal ScreenName As String, ByVal WidgetName As String) As Integer

        Dim B As Integer = 0
        Dim TBL As String = "HelpText"
        Dim WC As String = "Where ScreenName = '" + ScreenName + "' and   WidgetName = '" + WidgetName + "'"

        B = DBARCH.iGetRowCount(TBL, WC)

        Return B
    End Function     '** cnt_PK_HelpText

    '** Generate Index ROW Queries 
    Public Function getRow_PK_HelpText(ByVal ScreenName As String, ByVal WidgetName As String) As SqlDataReader

        Dim rsData As SqlDataReader = Nothing
        Dim TBL As String = "HelpText"
        Dim WC As String = "Where ScreenName = '" + ScreenName + "' and   WidgetName = '" + WidgetName + "'"

        rsData = DBARCH.GetRowByKey(TBL, WC)

        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PK_HelpText

    ''' Build Index Where Caluses 
    '''
    Public Function wc_PK_HelpText(ByVal ScreenName As String, ByVal WidgetName As String) As String

Dim WC AS String  = "Where ScreenName = '" + ScreenName + "' and   WidgetName = '" + WidgetName + "'" 

        Return WC
    End Function     '** wc_PK_HelpText

    '** Generate the SET methods 

End Class
