Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System
Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO
Imports System.Data.Sql
 
Public Class clsSOURCEATTRIBUTE

    '** DIM the selected table columns 
    Dim DBARCH As New clsDatabaseARCH
    Dim DMA As New clsDma
    Dim UTIL As New clsUtility
    Dim LOG As New clsLogging

    Dim AttributeValue As String = ""
    Dim AttributeName As String = ""
    Dim SourceGuid As String = ""
    Dim DataSourceOwnerUserID As String = ""
    Dim SourceTypeCode As String = ""


    '** Generate the SET methods 
    Public Sub setAttributevalue(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        AttributeValue = val
    End Sub

    Public Sub setAttributename(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Attributename' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        AttributeName = val
    End Sub

    Public Sub setSourceguid(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Sourceguid' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        SourceGuid = val
    End Sub

    Public Sub setDatasourceowneruserid(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Datasourceowneruserid' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        DataSourceOwnerUserID = val
    End Sub

    Public Sub setSourcetypecode(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        SourceTypeCode = val
    End Sub



    '** Generate the GET methods 
    Public Function getAttributevalue() As String
        Return UTIL.RemoveSingleQuotes(AttributeValue)
    End Function

    Public Function getAttributename() As String
        If Len(AttributeName) = 0 Then
            MessageBox.Show("GET: Field 'Attributename' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(AttributeName)
    End Function

    Public Function getSourceguid() As String
        If Len(SourceGuid) = 0 Then
            MessageBox.Show("GET: Field 'Sourceguid' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(SourceGuid)
    End Function

    Public Function getDatasourceowneruserid() As String
        If Len(DataSourceOwnerUserID) = 0 Then
            MessageBox.Show("GET: Field 'Datasourceowneruserid' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(DataSourceOwnerUserID)
    End Function

    Public Function getSourcetypecode() As String
        Return UTIL.RemoveSingleQuotes(SourceTypeCode)
    End Function



    '** Generate the Required Fields Validation method 
    Public Function ValidateReqData() As Boolean
        If AttributeName.Length = 0 Then Return False
        If SourceGuid.Length = 0 Then Return False
        If DataSourceOwnerUserID.Length = 0 Then Return False
        Return True
    End Function


    '** Generate the Validation method 
    Public Function ValidateData() As Boolean
        If AttributeName.Length = 0 Then Return False
        If SourceGuid.Length = 0 Then Return False
        If DataSourceOwnerUserID.Length = 0 Then Return False
        Return True
    End Function


    '** Generate the INSERT method 
    Public Function Insert() As Boolean
        Dim b As Boolean = False
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

        Return DBARCH.ExecuteSqlNewConn(s, False)

    End Function


    '** Generate the UPDATE method 
    Public Function Update(ByVal WhereClause As String) As Boolean
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

        Return DBARCH.ExecuteSqlNewConn(s, False)
    End Function


    '** Generate the SELECT method 
    Public Function SelectRecs() As SqlDataReader
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
        Dim CS As String = DBARCH.setConnStr()     'DBARCH.getGateWayConnStr(gGateWayID) : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader()
        Return rsData
    End Function


    '** Generate the Select One Row method 
    Public Function SelectOne(ByVal WhereClause As String) As SqlDataReader
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
        Dim CS As String = DBARCH.setConnStr()     'DBARCH.getGateWayConnStr(gGateWayID) : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader()
        Return rsData
    End Function


    '** Generate the DELETE method 
    Public Function Delete(ByVal WhereClause As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        If Len(WhereClause) = 0 Then Return False

        WhereClause = " " + WhereClause

        s = " Delete from SourceAttribute"
        s = s + WhereClause

        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b

    End Function


    '** Generate the Zeroize Table method 
    Public Function Zeroize() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        s = s + " Delete from SourceAttribute"

        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b

    End Function


    '** Generate Index Queries 
    Public Function cnt__dta_index_SourceAttribute_c_11_786101841__K3_K2(ByVal AttributeName As String, ByVal SourceGuid As String) As Integer

        Dim B As Integer = 0
        Dim TBL As String = "SourceAttribute"
        Dim WC As String = "Where AttributeName = '" + AttributeName + "' and   SourceGuid = '" + SourceGuid + "'"

        B = DBARCH.iGetRowCount(TBL, WC)

        Return B
    End Function     '** cnt__dta_index_SourceAttribute_c_11_786101841__K3_K2
    Public Function cnt_PI001_SourceAttribute(ByVal SourceGuid As String) As Integer

        Dim B As Integer = 0
        Dim TBL As String = "SourceAttribute"
        Dim WC As String = "Where SourceGuid = '" + SourceGuid + "'"

        B = DBARCH.iGetRowCount(TBL, WC)

        Return B
    End Function     '** cnt_PI001_SourceAttribute
    Public Function cnt_PI02_SourceAttributes(ByVal AttributeName As String, ByVal AttributeValue As String) As Integer

        Dim B As Integer = 0
        Dim TBL As String = "SourceAttribute"
        Dim WC As String = "Where AttributeName = '" + AttributeName + "' and   AttributeValue = '" + AttributeValue + "'"

        B = DBARCH.iGetRowCount(TBL, WC)

        Return B
    End Function     '** cnt_PI02_SourceAttributes
    Public Function cnt_PK35(ByVal AttributeName As String, ByVal DataSourceOwnerUserID As String, ByVal SourceGuid As String) As Integer

        Dim B As Integer = 0
        Dim TBL As String = "SourceAttribute"
        Dim WC As String = "Where AttributeName = '" + AttributeName + "' and   DataSourceOwnerUserID = '" + DataSourceOwnerUserID + "' and   SourceGuid = '" + SourceGuid + "'"

        B = DBARCH.iGetRowCount(TBL, WC)

        Return B
    End Function     '** cnt_PK35

    '** Generate Index ROW Queries 
    Public Function getRow__dta_index_SourceAttribute_c_11_786101841__K3_K2(ByVal AttributeName As String, ByVal SourceGuid As String) As SqlDataReader

        Dim rsData As SqlDataReader = Nothing
        Dim TBL As String = "SourceAttribute"
        Dim WC As String = "Where AttributeName = '" + AttributeName + "' and   SourceGuid = '" + SourceGuid + "'"

        rsData = DBARCH.GetRowByKey(TBL, WC)

        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow__dta_index_SourceAttribute_c_11_786101841__K3_K2
    Public Function getRow_PI001_SourceAttribute(ByVal SourceGuid As String) As SqlDataReader

        Dim rsData As SqlDataReader = Nothing
        Dim TBL As String = "SourceAttribute"
        Dim WC As String = "Where SourceGuid = '" + SourceGuid + "'"

        rsData = DBARCH.GetRowByKey(TBL, WC)

        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PI001_SourceAttribute
    Public Function getRow_PI02_SourceAttributes(ByVal AttributeName As String, ByVal AttributeValue As String) As SqlDataReader

        Dim rsData As SqlDataReader = Nothing
        Dim TBL As String = "SourceAttribute"
        Dim WC As String = "Where AttributeName = '" + AttributeName + "' and   AttributeValue = '" + AttributeValue + "'"

        rsData = DBARCH.GetRowByKey(TBL, WC)

        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PI02_SourceAttributes
    Public Function getRow_PK35(ByVal AttributeName As String, ByVal DataSourceOwnerUserID As String, ByVal SourceGuid As String) As SqlDataReader

        Dim rsData As SqlDataReader = Nothing
        Dim TBL As String = "SourceAttribute"
        Dim WC As String = "Where AttributeName = '" + AttributeName + "' and   DataSourceOwnerUserID = '" + DataSourceOwnerUserID + "' and   SourceGuid = '" + SourceGuid + "'"

        rsData = DBARCH.GetRowByKey(TBL, WC)

        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PK35

    ''' Build Index Where Caluses 
    '''
    Public Function wc__dta_index_SourceAttribute_c_11_786101841__K3_K2(ByVal AttributeName As String, ByVal SourceGuid As String) As String

        Dim WC As String = "Where AttributeName = '" + AttributeName + "' and   SourceGuid = '" + SourceGuid + "'"

        Return WC
    End Function     '** wc__dta_index_SourceAttribute_c_11_786101841__K3_K2
    Public Function wc_PI001_SourceAttribute(ByVal SourceGuid As String) As String

        Dim WC As String = "Where SourceGuid = '" + SourceGuid + "'"

        Return WC
    End Function     '** wc_PI001_SourceAttribute
    Public Function wc_PI02_SourceAttributes(ByVal AttributeName As String, ByVal AttributeValue As String) As String

        Dim WC As String = "Where AttributeName = '" + AttributeName + "' and   AttributeValue = '" + AttributeValue + "'"

        Return WC
    End Function     '** wc_PI02_SourceAttributes
    Public Function wc_PK35(ByVal AttributeName As String, ByVal DataSourceOwnerUserID As String, ByVal SourceGuid As String) As String

        Dim WC As String = "Where AttributeName = '" + AttributeName + "' and   DataSourceOwnerUserID = '" + DataSourceOwnerUserID + "' and   SourceGuid = '" + SourceGuid + "'"

        Return WC
    End Function     '** wc_PK35

    Public Function Add() As Boolean
        Dim bSuccess As Boolean = False
        Dim iCnt As Integer = 0
        iCnt = cnt_PK35(AttributeName, DataSourceOwnerUserID, SourceGuid)

        If iCnt = 0 Then
            bSuccess = Insert()
        Else
            Dim WC As String = "Where AttributeName = '" + AttributeName + "' and   DataSourceOwnerUserID = '" + DataSourceOwnerUserID + "' and   SourceGuid = '" + SourceGuid + "'"
            bSuccess = Update(WC)
        End If
        If bSuccess = True Then
            If AttributeName.ToUpper.Equals("PRIVATE") Then
                Dim S As String = "Update Datasource set isPublic = '" + AttributeValue + "' where SourceGuid = '" + SourceGuid + "'"
                Dim BB As Boolean = DBARCH.ExecuteSqlNewConn(S, False)
                If Not BB Then
                    LOG.WriteToArchiveLog("clsSOURCEATTRIBUTE : InsertOrUpdate : 100 : Failed to update DataSource isPublic: '" + SourceGuid + "'.")
                    DBARCH.xTrace(9011, "clsSOURCEATTRIBUTE : InsertOrUpdate : 100 : Failed to update DataSource isPublic: '" + SourceGuid + "'.", "clsSOURCEATTRIBUTE")
                End If
            End If
            If AttributeName.ToUpper.Equals("MASTERDOC") Then
                Dim S As String = "Update Datasource set isMaster = '" + AttributeValue + "' where SourceGuid = '" + SourceGuid + "'"
                Dim BB As Boolean = DBARCH.ExecuteSqlNewConn(S, False)
                If Not BB Then
                    LOG.WriteToArchiveLog("clsSOURCEATTRIBUTE : InsertOrUpdate : 700 : Failed to update DataSource isMaster: '" + SourceGuid + "'.")
                    DBARCH.xTrace(9011, "clsSOURCEATTRIBUTE : InsertOrUpdate : 700 : Failed to update DataSource isMaster: '" + SourceGuid + "'.", "clsSOURCEATTRIBUTE")
                End If
            End If
        End If
        Return bSuccess
    End Function

End Class
