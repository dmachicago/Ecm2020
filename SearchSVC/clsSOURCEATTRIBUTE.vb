Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System
Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO
Imports System.Data.Sql
 
Public Class clsSOURCEATTRIBUTE

    '** DIM the selected table columns 
    Dim DB As New clsDatabaseSVR
    Dim DMA As New clsDmaSVR
    Dim UTIL As New clsUtilitySVR
    Dim LOG As New clsLogging

    Dim AttributeValue As String = ""
    Dim AttributeName As String = ""
    Dim SourceGuid As String = ""
    Dim DataSourceOwnerUserID As String = ""
    Dim SourceTypeCode As String = ""

    Dim SecureID As Integer = -1

    Sub New(ByVal iSecureID As Integer)
        SecureID = iSecureID
    End Sub


    '** Generate the SET methods 
    Public Sub setAttributevalue(ByRef val as string)
        val = UTIL.RemoveSingleQuotes(val)
        AttributeValue = val
    End Sub

    Public Sub setAttributename(ByRef val as string)
        If Len(val) = 0 Then
            MsgBox("SET: Field 'Attributename' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        AttributeName = val
    End Sub

    Public Sub setSourceguid(ByRef val as string)
        If Len(val) = 0 Then
            MsgBox("SET: Field 'Sourceguid' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        SourceGuid = val
    End Sub

    Public Sub setDatasourceowneruserid(ByRef val as string)
        If Len(val) = 0 Then
            MsgBox("SET: Field 'Datasourceowneruserid' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        DataSourceOwnerUserID = val
    End Sub

    Public Sub setSourcetypecode(ByRef val as string)
        val = UTIL.RemoveSingleQuotes(val)
        SourceTypeCode = val
    End Sub



    '** Generate the GET methods 
    Public Function getAttributevalue() As String
        Return UTIL.RemoveSingleQuotes(AttributeValue)
    End Function

    Public Function getAttributename() As String
        If Len(AttributeName) = 0 Then
            MsgBox("GET: Field 'Attributename' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(AttributeName)
    End Function

    Public Function getSourceguid() As String
        If Len(SourceGuid) = 0 Then
            MsgBox("GET: Field 'Sourceguid' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(SourceGuid)
    End Function

    Public Function getDatasourceowneruserid() As String
        If Len(DataSourceOwnerUserID) = 0 Then
            MsgBox("GET: Field 'Datasourceowneruserid' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(DataSourceOwnerUserID)
    End Function

    Public Function getSourcetypecode() As String
        Return UTIL.RemoveSingleQuotes(SourceTypeCode)
    End Function



    '** Generate the Required Fields Validation AS string 
    Public Function ValidateReqData() As Boolean
        If AttributeName.Length = 0 Then Return false
        If SourceGuid.Length = 0 Then Return false
        If DataSourceOwnerUserID.Length = 0 Then Return false
        Return True
    End Function


    '** Generate the Validation AS string 
    Public Function ValidateData() As Boolean
        If AttributeName.Length = 0 Then Return false
        If SourceGuid.Length = 0 Then Return false
        If DataSourceOwnerUserID.Length = 0 Then Return false
        Return True
    End Function


    '** Generate the INSERT AS string 
    Public Function Insert() As Boolean
        Dim b As Boolean = false
        Dim s As String = ""
        s = s + " INSERT INTO SourceAttribute("
        s = s + "AttributeValue,"
        s = s + "AttributeName,"
        s = s + "SourceGuid,"
        s = s + "DataSourceOwnerUserID,"
        s = s + "SourceTypeCode) values ("
        s = s + "'" + AttributeValue + "'" + ","
        s = s + "'" + AttributeName + "'" + ","
        s = s + "'" + SourceGuid + "'" + ","
        s = s + "'" + DataSourceOwnerUserID + "'" + ","
        s = s + "'" + SourceTypeCode + "'" + ")"

        Return DB.DBExecuteSql(SecureID, S, False)

    End Function


    '** Generate the UPDATE AS string 
    Public Function Update(ByVal WhereClause as string) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        If Len(WhereClause) = 0 Then Return False

        s = s + " update SourceAttribute set "
        s = s + "AttributeValue = '" + getAttributevalue() + "'" + ", "
        s = s + "AttributeName = '" + getAttributename() + "'" + ", "
        s = s + "SourceGuid = '" + getSourceguid() + "'" + ", "
        s = s + "DataSourceOwnerUserID = '" + getDatasourceowneruserid() + "'" + ", "
        s = s + "SourceTypeCode = '" + getSourcetypecode() + "'"
        WhereClause = " " + WhereClause
        s = s + WhereClause

        Return DB.DBExecuteSql(SecureID, S, False)
    End Function


    '** Generate the SELECT AS string 
    Public Function SelectRecs(ByVal SecureID As Integer) As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "AttributeValue,"
        s = s + "AttributeName,"
        s = s + "SourceGuid,"
        s = s + "DataSourceOwnerUserID,"
        s = s + "SourceTypeCode "
        s = s + " FROM SourceAttribute"
        '** s=s+ "ORDERBY xxxx"
        Dim CS$ = DBgetConnStr() : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader()
        Return rsData
    End Function


    '** Generate the Select One Row AS string 
    Public Function SelectOne(ByVal SecureID As Integer, ByVal WhereClause as string) As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "AttributeValue,"
        s = s + "AttributeName,"
        s = s + "SourceGuid,"
        s = s + "DataSourceOwnerUserID,"
        s = s + "SourceTypeCode "
        s = s + " FROM SourceAttribute"
        s = s + WhereClause
        '** s=s+ "ORDERBY xxxx"
        Dim CS$ = DBgetConnStr() : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader()
        Return rsData
    End Function


    '** Generate the DELETE AS string 
    Public Function Delete(ByVal WhereClause as string) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        If Len(WhereClause) = 0 Then Return False

        WhereClause = " " + WhereClause

        s = " Delete from SourceAttribute"
        s = s + WhereClause

        b = DB.DBExecuteSql(SecureID, S, False)
        Return b

    End Function


    '** Generate the Zeroize Table AS string 
    Public Function Zeroize() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        s = s + " Delete from SourceAttribute"

        b = DB.DBExecuteSql(SecureID, S, False)
        Return b

    End Function


    '** Generate Index Queries 
    Public Function cnt__dta_index_SourceAttribute_c_11_786101841__K3_K2(ByVal AttributeName As String, ByVal SourceGuid As String) As Integer

        Dim B As Integer = 0
        Dim TBL$ = "SourceAttribute"
        Dim WC$ = "Where AttributeName = '" + AttributeName + "' and   SourceGuid = '" + SourceGuid + "'"

        B = DB.iGetRowCount(TBL$, WC)

        Return B
    End Function     '** cnt__dta_index_SourceAttribute_c_11_786101841__K3_K2
    Public Function cnt_PI001_SourceAttribute(ByVal SourceGuid As String) As Integer

        Dim B As Integer = 0
        Dim TBL$ = "SourceAttribute"
        Dim WC$ = "Where SourceGuid = '" + SourceGuid + "'"

        B = DB.iGetRowCount(TBL$, WC)

        Return B
    End Function     '** cnt_PI001_SourceAttribute
    Public Function cnt_PI02_SourceAttributes(ByVal AttributeName As String, ByVal AttributeValue As String) As Integer

        Dim B As Integer = 0
        Dim TBL$ = "SourceAttribute"
        Dim WC$ = "Where AttributeName = '" + AttributeName + "' and   AttributeValue = '" + AttributeValue + "'"

        B = DB.iGetRowCount(TBL$, WC)

        Return B
    End Function     '** cnt_PI02_SourceAttributes
    Public Function cnt_PK35(ByVal AttributeName As String, ByVal DataSourceOwnerUserID As String, ByVal SourceGuid As String) As Integer

        Dim B As Integer = 0
        Dim TBL$ = "SourceAttribute"
        Dim WC$ = "Where AttributeName = '" + AttributeName + "' and   DataSourceOwnerUserID = '" + DataSourceOwnerUserID + "' and   SourceGuid = '" + SourceGuid + "'"

        B = DB.iGetRowCount(TBL$, WC)

        Return B
    End Function     '** cnt_PK35

    '** Generate Index ROW Queries 
    Public Function getRow__dta_index_SourceAttribute_c_11_786101841__K3_K2(ByVal SecureID As Integer, ByVal AttributeName As String, ByVal SourceGuid As String) As SqlDataReader

        Dim rsData As SqlDataReader = Nothing
        Dim TBL$ = "SourceAttribute"
        Dim WC$ = "Where AttributeName = '" + AttributeName + "' and   SourceGuid = '" + SourceGuid + "'"

        rsData = DB.GetRowByKey(SecureID, TBL$, WC)

        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow__dta_index_SourceAttribute_c_11_786101841__K3_K2
    Public Function getRow_PI001_SourceAttribute(ByVal SecureID As Integer, ByVal SourceGuid As String) As SqlDataReader

        Dim rsData As SqlDataReader = Nothing
        Dim TBL$ = "SourceAttribute"
        Dim WC$ = "Where SourceGuid = '" + SourceGuid + "'"

        rsData = DB.GetRowByKey(SecureID, TBL$, WC)

        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PI001_SourceAttribute
    Public Function getRow_PI02_SourceAttributes(ByVal SecureID As Integer, ByVal AttributeName As String, ByVal AttributeValue As String) As SqlDataReader

        Dim rsData As SqlDataReader = Nothing
        Dim TBL$ = "SourceAttribute"
        Dim WC$ = "Where AttributeName = '" + AttributeName + "' and   AttributeValue = '" + AttributeValue + "'"

        rsData = DB.GetRowByKey(SecureID, TBL$, WC)

        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PI02_SourceAttributes
    Public Function getRow_PK35(ByVal SecureID As Integer, ByVal AttributeName As String, ByVal DataSourceOwnerUserID As String, ByVal SourceGuid As String) As SqlDataReader

        Dim rsData As SqlDataReader = Nothing
        Dim TBL$ = "SourceAttribute"
        Dim WC$ = "Where AttributeName = '" + AttributeName + "' and   DataSourceOwnerUserID = '" + DataSourceOwnerUserID + "' and   SourceGuid = '" + SourceGuid + "'"

        rsData = DB.GetRowByKey(SecureID, TBL$, WC)

        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PK35

    ''' Build Index Where Caluses 
    '''
    Public Function wc__dta_index_SourceAttribute_c_11_786101841__K3_K2(ByVal AttributeName As String, ByVal SourceGuid As String) As String

        Dim WC$ = "Where AttributeName = '" + AttributeName + "' and   SourceGuid = '" + SourceGuid + "'"

        Return WC
    End Function     '** wc__dta_index_SourceAttribute_c_11_786101841__K3_K2
    Public Function wc_PI001_SourceAttribute(ByVal SourceGuid As String) As String

        Dim WC$ = "Where SourceGuid = '" + SourceGuid + "'"

        Return WC
    End Function     '** wc_PI001_SourceAttribute
    Public Function wc_PI02_SourceAttributes(ByVal AttributeName As String, ByVal AttributeValue As String) As String

        Dim WC$ = "Where AttributeName = '" + AttributeName + "' and   AttributeValue = '" + AttributeValue + "'"

        Return WC
    End Function     '** wc_PI02_SourceAttributes
    Public Function wc_PK35(ByVal AttributeName As String, ByVal DataSourceOwnerUserID As String, ByVal SourceGuid As String) As String

        Dim WC$ = "Where AttributeName = '" + AttributeName + "' and   DataSourceOwnerUserID = '" + DataSourceOwnerUserID + "' and   SourceGuid = '" + SourceGuid + "'"

        Return WC
    End Function     '** wc_PK35

    Public Function Add(ByVal SecureID As Integer) As Boolean
        Dim bSuccess As Boolean = False
        Dim iCnt As Integer = 0
        iCnt = cnt_PK35(AttributeName, DataSourceOwnerUserID, SourceGuid)

        If iCnt = 0 Then
            bSuccess = Insert()
        Else
            Dim WC$ = "Where AttributeName = '" + AttributeName + "' and   DataSourceOwnerUserID = '" + DataSourceOwnerUserID + "' and   SourceGuid = '" + SourceGuid + "'"
            bSuccess = Update(WC)
        End If
        If bSuccess = True Then
            If AttributeName$.ToUpper.Equals("PRIVATE") Then
                Dim S$ = "Update Datasource set isPublic = '" + AttributeValue$ + "' where SourceGuid = '" + SourceGuid$ + "'"
                Dim BB As Boolean = DB.DBExecuteSql(SecureID, S, False)
                If Not BB Then
                    LOG.WriteToSqlLog("clsSOURCEATTRIBUTE : InsertOrUpdate : 100 : Failed to update DataSource isPublic: '" + SourceGuid + "'.")
                    DB.DBTrace(SecureID, 9011, "clsSOURCEATTRIBUTE : InsertOrUpdate : 100 : Failed to update DataSource isPublic: '" + SourceGuid + "'.", "clsSOURCEATTRIBUTE")
                End If
            End If
            If AttributeName$.ToUpper.Equals("MASTERDOC") Then
                Dim S$ = "Update Datasource set isMaster = '" + AttributeValue$ + "' where SourceGuid = '" + SourceGuid$ + "'"
                Dim BB As Boolean = DB.DBExecuteSql(SecureID, S, False)
                If Not BB Then
                    LOG.WriteToSqlLog("clsSOURCEATTRIBUTE : InsertOrUpdate : 700 : Failed to update DataSource isMaster: '" + SourceGuid + "'.")
                    DB.DBTrace(SecureID, 9011, "clsSOURCEATTRIBUTE : InsertOrUpdate : 700 : Failed to update DataSource isMaster: '" + SourceGuid + "'.", "clsSOURCEATTRIBUTE")
                End If
            End If
        End If
        Return bSuccess
    End Function

End Class
