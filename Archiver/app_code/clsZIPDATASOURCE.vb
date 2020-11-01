Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System
Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO
Imports System.Data.Sql


Public Class clsZIPDATASOURCE


    '** DIM the selected table columns 
    Dim DBARCH As New clsDatabaseARCH
    Dim DMA As New clsDma

    Dim UTIL As New clsUtility
    Dim LOG As New clsLogging

    Dim DG As New clsDataGrid


    Dim SourceGuid As String = ""
    Dim CreateDate As String = ""
    Dim SourceName As String = ""
    Dim SourceImage As String = ""
    Dim SourceTypeCode As String = ""
    Dim FQN As String = ""
    Dim VersionNbr As String = ""
    Dim LastAccessDate As String = ""
    Dim FileLength As String = ""
    Dim LastWriteTime As String = ""
    Dim UserID As String = ""
    Dim DataSourceOwnerUserID As String = ""
    Dim isPublic As String = ""
    Dim FileDirectory As String = ""
    Dim OriginalFileType As String = ""
    Dim RetentionExpirationDate As String = ""
    Dim IsPublicPreviousState As String = ""
    Dim isAvailable As String = ""
    Dim isContainedWithinZipFile As String = ""
    Dim IsZipFile As String = ""
    Dim DataVerified As String = ""




    '** Generate the SET methods 
    Public Sub setSourceguid(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Sourceguid' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        SourceGuid = val
    End Sub


    Public Sub setCreatedate(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        CreateDate = val
    End Sub


    Public Sub setSourcename(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        SourceName = val
    End Sub


    Public Sub setSourceimage(ByRef val As String)
        If Len(val) = 0 Then
            val = "null"
        End If
        val = UTIL.RemoveSingleQuotes(val)
        SourceImage = val
    End Sub


    Public Sub setSourcetypecode(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Sourcetypecode' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        SourceTypeCode = val
    End Sub


    Public Sub setFqn(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        FQN = val
    End Sub


    Public Sub setVersionnbr(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Versionnbr' cannot be NULL.")
            Return
        End If
        If Len(val) = 0 Then
            val = "null"
        End If
        val = UTIL.RemoveSingleQuotes(val)
        VersionNbr = val
    End Sub


    Public Sub setLastaccessdate(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        LastAccessDate = val
    End Sub


    Public Sub setFilelength(ByRef val As String)
        If Len(val) = 0 Then
            val = "null"
        End If
        val = UTIL.RemoveSingleQuotes(val)
        FileLength = val
    End Sub


    Public Sub setLastwritetime(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        LastWriteTime = val
    End Sub


    Public Sub setUserid(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        UserID = val
    End Sub


    Public Sub setDatasourceowneruserid(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Datasourceowneruserid' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        DataSourceOwnerUserID = val
    End Sub


    Public Sub setIspublic(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        isPublic = val
    End Sub


    Public Sub setFiledirectory(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        FileDirectory = val
    End Sub


    Public Sub setOriginalfiletype(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        OriginalFileType = val
    End Sub


    Public Sub setRetentionexpirationdate(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        RetentionExpirationDate = val
    End Sub


    Public Sub setIspublicpreviousstate(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        IsPublicPreviousState = val
    End Sub


    Public Sub setIsavailable(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        isAvailable = val
    End Sub


    Public Sub setIscontainedwithinzipfile(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        isContainedWithinZipFile = val
    End Sub


    Public Sub setIszipfile(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        IsZipFile = val
    End Sub


    Public Sub setDataverified(ByRef val As String)
        If Len(val) = 0 Then
            val = "null"
        End If
        val = UTIL.RemoveSingleQuotes(val)
        DataVerified = val
    End Sub






    '** Generate the GET methods 
    Public Function getSourceguid() As String
        If Len(SourceGuid) = 0 Then
            MessageBox.Show("GET: Field 'Sourceguid' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(SourceGuid)
    End Function


    Public Function getCreatedate() As String
        Return UTIL.RemoveSingleQuotes(CreateDate)
    End Function


    Public Function getSourcename() As String
        Return UTIL.RemoveSingleQuotes(SourceName)
    End Function


    Public Function getSourceimage() As String
        If Len(SourceImage) = 0 Then
            SourceImage = "null"
        End If
        Return SourceImage
    End Function


    Public Function getSourcetypecode() As String
        If Len(SourceTypeCode) = 0 Then
            MessageBox.Show("GET: Field 'Sourcetypecode' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(SourceTypeCode)
    End Function


    Public Function getFqn() As String
        Return UTIL.RemoveSingleQuotes(FQN)
    End Function


    Public Function getVersionnbr() As String
        If Len(VersionNbr) = 0 Then
            MessageBox.Show("GET: Field 'Versionnbr' cannot be NULL.")
            Return ""
        End If
        If Len(VersionNbr) = 0 Then
            VersionNbr = "null"
        End If
        Return VersionNbr
    End Function


    Public Function getLastaccessdate() As String
        Return UTIL.RemoveSingleQuotes(LastAccessDate)
    End Function


    Public Function getFilelength() As String
        If Len(FileLength) = 0 Then
            FileLength = "null"
        End If
        Return FileLength
    End Function


    Public Function getLastwritetime() As String
        Return UTIL.RemoveSingleQuotes(LastWriteTime)
    End Function


    Public Function getUserid() As String
        Return UTIL.RemoveSingleQuotes(UserID)
    End Function


    Public Function getDatasourceowneruserid() As String
        If Len(DataSourceOwnerUserID) = 0 Then
            MessageBox.Show("GET: Field 'Datasourceowneruserid' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(DataSourceOwnerUserID)
    End Function


    Public Function getIspublic() As String
        Return UTIL.RemoveSingleQuotes(isPublic)
    End Function


    Public Function getFiledirectory() As String
        Return UTIL.RemoveSingleQuotes(FileDirectory)
    End Function


    Public Function getOriginalfiletype() As String
        Return UTIL.RemoveSingleQuotes(OriginalFileType)
    End Function


    Public Function getRetentionexpirationdate() As String
        Return UTIL.RemoveSingleQuotes(RetentionExpirationDate)
    End Function


    Public Function getIspublicpreviousstate() As String
        Return UTIL.RemoveSingleQuotes(IsPublicPreviousState)
    End Function


    Public Function getIsavailable() As String
        Return UTIL.RemoveSingleQuotes(isAvailable)
    End Function


    Public Function getIscontainedwithinzipfile() As String
        Return UTIL.RemoveSingleQuotes(isContainedWithinZipFile)
    End Function


    Public Function getIszipfile() As String
        Return UTIL.RemoveSingleQuotes(IsZipFile)
    End Function


    Public Function getDataverified() As String
        If Len(DataVerified) = 0 Then
            DataVerified = "null"
        End If
        Return DataVerified
    End Function






    '** Generate the Required Fields Validation method 
    Public Function ValidateReqData() As Boolean
        If SourceGuid.Length = 0 Then Return False
        If SourceTypeCode.Length = 0 Then Return False
        If VersionNbr.Length = 0 Then Return False
        If DataSourceOwnerUserID.Length = 0 Then Return False
        Return True
    End Function




    '** Generate the Validation method 
    Public Function ValidateData() As Boolean
        If SourceGuid.Length = 0 Then Return False
        If SourceTypeCode.Length = 0 Then Return False
        If VersionNbr.Length = 0 Then Return False
        If DataSourceOwnerUserID.Length = 0 Then Return False
        Return True
    End Function




    '** Generate the INSERT method 
    Public Function Insert() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""
        s = s + " INSERT INTO DataSource("
        s = s + "SourceGuid,"
        s = s + "CreateDate,"
        s = s + "SourceName,"
        s = s + "SourceImage,"
        s = s + "SourceTypeCode,"
        s = s + "FQN,"
        s = s + "VersionNbr,"
        s = s + "LastAccessDate,"
        s = s + "FileLength,"
        s = s + "LastWriteTime,"
        s = s + "UserID,"
        s = s + "DataSourceOwnerUserID,"
        s = s + "isPublic,"
        s = s + "FileDirectory,"
        s = s + "OriginalFileType,"
        s = s + "RetentionExpirationDate,"
        s = s + "IsPublicPreviousState,"
        s = s + "isAvailable,"
        s = s + "isContainedWithinZipFile,"
        s = s + "IsZipFile,"
        s = s + "DataVerified) values ("
        s = s + "'" + SourceGuid + "'" + ","
        s = s + "'" + CreateDate + "'" + ","
        s = s + "'" + SourceName + "'" + ","
        s = s + SourceImage + ","
        s = s + "'" + SourceTypeCode + "'" + ","
        s = s + "'" + FQN + "'" + ","
        s = s + VersionNbr + ","
        s = s + "'" + LastAccessDate + "'" + ","
        s = s + FileLength + ","
        s = s + "'" + LastWriteTime + "'" + ","
        s = s + "'" + UserID + "'" + ","
        s = s + "'" + DataSourceOwnerUserID + "'" + ","
        s = s + "'" + isPublic + "'" + ","
        s = s + "'" + FileDirectory + "'" + ","
        s = s + "'" + OriginalFileType + "'" + ","
        s = s + "'" + RetentionExpirationDate + "'" + ","
        s = s + "'" + IsPublicPreviousState + "'" + ","
        s = s + "'" + isAvailable + "'" + ","
        s = s + "'" + isContainedWithinZipFile + "'" + ","
        s = s + "'" + IsZipFile + "'" + ","
        s = s + DataVerified + ")"
        Return DBARCH.ExecuteSqlNewConn(s, False)


    End Function




    '** Generate the UPDATE method 
    Public Function Update(ByVal WhereClause As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""


        If Len(WhereClause) = 0 Then Return False


        s = s + " update DataSource set "
        s = s + "SourceGuid = '" + getSourceguid() + "'" + ", "
        s = s + "CreateDate = '" + getCreatedate() + "'" + ", "
        s = s + "SourceName = '" + getSourcename() + "'" + ", "
        s = s + "SourceImage = " + getSourceimage() + ", "
        s = s + "SourceTypeCode = '" + getSourcetypecode() + "'" + ", "
        s = s + "FQN = '" + getFqn() + "'" + ", "
        s = s + "VersionNbr = " + getVersionnbr() + ", "
        s = s + "LastAccessDate = '" + getLastaccessdate() + "'" + ", "
        s = s + "FileLength = " + getFilelength() + ", "
        s = s + "LastWriteTime = '" + getLastwritetime() + "'" + ", "
        s = s + "UserID = '" + getUserid() + "'" + ", "
        s = s + "DataSourceOwnerUserID = '" + getDatasourceowneruserid() + "'" + ", "
        s = s + "isPublic = '" + getIspublic() + "'" + ", "
        s = s + "FileDirectory = '" + getFiledirectory() + "'" + ", "
        s = s + "OriginalFileType = '" + getOriginalfiletype() + "'" + ", "
        s = s + "RetentionExpirationDate = '" + getRetentionexpirationdate() + "'" + ", "
        s = s + "IsPublicPreviousState = '" + getIspublicpreviousstate() + "'" + ", "
        s = s + "isAvailable = '" + getIsavailable() + "'" + ", "
        s = s + "isContainedWithinZipFile = '" + getIscontainedwithinzipfile() + "'" + ", "
        s = s + "IsZipFile = '" + getIszipfile() + "'" + ", "
        s = s + "DataVerified = " + getDataverified()
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
        s = s + "SourceGuid,"
        s = s + "CreateDate,"
        s = s + "SourceName,"
        s = s + "SourceImage,"
        s = s + "SourceTypeCode,"
        s = s + "FQN,"
        s = s + "VersionNbr,"
        s = s + "LastAccessDate,"
        s = s + "FileLength,"
        s = s + "LastWriteTime,"
        s = s + "UserID,"
        s = s + "DataSourceOwnerUserID,"
        s = s + "isPublic,"
        s = s + "FileDirectory,"
        s = s + "OriginalFileType,"
        s = s + "RetentionExpirationDate,"
        s = s + "IsPublicPreviousState,"
        s = s + "isAvailable,"
        s = s + "isContainedWithinZipFile,"
        s = s + "IsZipFile,"
        s = s + "DataVerified "
        s = s + " FROM DataSource"

        Dim CS As String = DBARCH.setConnStr()     'DBARCH.getGateWayConnStr(gGateWayID) : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader()
        Return rsData
    End Function




    '** Generate the Select One Row method 
    Public Function SelectOne(ByVal WhereClause As String) As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "SourceGuid,"
        s = s + "CreateDate,"
        s = s + "SourceName,"
        s = s + "SourceImage,"
        s = s + "SourceTypeCode,"
        s = s + "FQN,"
        s = s + "VersionNbr,"
        s = s + "LastAccessDate,"
        s = s + "FileLength,"
        s = s + "LastWriteTime,"
        s = s + "UserID,"
        s = s + "DataSourceOwnerUserID,"
        s = s + "isPublic,"
        s = s + "FileDirectory,"
        s = s + "OriginalFileType,"
        s = s + "RetentionExpirationDate,"
        s = s + "IsPublicPreviousState,"
        s = s + "isAvailable,"
        s = s + "isContainedWithinZipFile,"
        s = s + "IsZipFile,"
        s = s + "DataVerified "
        s = s + " FROM DataSource"
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


        s = " Delete from DataSource"
        s = s + WhereClause


        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b


    End Function




    '** Generate the Zeroize Table method 
    Public Function Zeroize() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""


        s = s + " Delete from DataSource"


        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b


    End Function




    '** Generate Index Queries 
    Public Function cnt_PI_DIR(ByVal DataSourceOwnerUserID As String, ByVal FileDirectory As String) As Integer


        Dim B As Integer = 0
        Dim TBL As String = "DataSource"
        Dim WC As String = "Where DataSourceOwnerUserID = '" + DataSourceOwnerUserID + "' and   FileDirectory = '" + FileDirectory + "'"


        B = DBARCH.iGetRowCount(TBL, WC)


        Return B
    End Function     '** cnt_PI_DIR
    Public Function cnt_PI_FQN_USERID(ByVal DataSourceOwnerUserID As String, ByVal FQN As String) As Integer


        Dim B As Integer = 0
        Dim TBL As String = "DataSource"
        Dim WC As String = "Where DataSourceOwnerUserID = '" + DataSourceOwnerUserID + "' and   FQN = '" + FQN + "'"


        B = DBARCH.iGetRowCount(TBL, WC)


        Return B
    End Function     '** cnt_PI_FQN_USERID
    Public Function cnt_PK33_04012008185318001(ByVal DataSourceOwnerUserID As String, ByVal SourceGuid As String) As Integer


        Dim B As Integer = 0
        Dim TBL As String = "DataSource"
        Dim WC As String = "Where DataSourceOwnerUserID = '" + DataSourceOwnerUserID + "' and   SourceGuid = '" + SourceGuid + "'"


        B = DBARCH.iGetRowCount(TBL, WC)


        Return B
    End Function     '** cnt_PK33_04012008185318001
    Public Function cnt_UK_FQN_VERNBR(ByVal FQN As String, ByVal VersionNbr As Integer) As Integer


        Dim B As Integer = 0
        Dim TBL As String = "DataSource"
        Dim WC As String = "Where FQN = '" + FQN + "' and   VersionNbr = " & VersionNbr


        B = DBARCH.iGetRowCount(TBL, WC)


        Return B
    End Function     '** cnt_UK_FQN_VERNBR
    Public Function cnt_UKI_Documents(ByVal SourceGuid As String) As Integer


        Dim B As Integer = 0
        Dim TBL As String = "DataSource"
        Dim WC As String = "Where SourceGuid = '" + SourceGuid + "'"


        B = DBARCH.iGetRowCount(TBL, WC)


        Return B
    End Function     '** cnt_UKI_Documents


    '** Generate Index ROW Queries 
    Public Function getRow_PI_DIR(ByVal DataSourceOwnerUserID As String, ByVal FileDirectory As String) As SqlDataReader


        Dim rsData As SqlDataReader = Nothing
        Dim TBL As String = "DataSource"
        Dim WC As String = "Where DataSourceOwnerUserID = '" + DataSourceOwnerUserID + "' and   FileDirectory = '" + FileDirectory + "'"


        rsData = DBARCH.GetRowByKey(TBL, WC)


        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PI_DIR
    Public Function getRow_PI_FQN_USERID(ByVal DataSourceOwnerUserID As String, ByVal FQN As String) As SqlDataReader


        Dim rsData As SqlDataReader = Nothing
        Dim TBL As String = "DataSource"
        Dim WC As String = "Where DataSourceOwnerUserID = '" + DataSourceOwnerUserID + "' and   FQN = '" + FQN + "'"


        rsData = DBARCH.GetRowByKey(TBL, WC)


        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PI_FQN_USERID
    Public Function getRow_PK33_04012008185318001(ByVal DataSourceOwnerUserID As String, ByVal SourceGuid As String) As SqlDataReader


        Dim rsData As SqlDataReader = Nothing
        Dim TBL As String = "DataSource"
        Dim WC As String = "Where DataSourceOwnerUserID = '" + DataSourceOwnerUserID + "' and   SourceGuid = '" + SourceGuid + "'"


        rsData = DBARCH.GetRowByKey(TBL, WC)


        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PK33_04012008185318001
    Public Function getRow_UK_FQN_VERNBR(ByVal FQN As String, ByVal VersionNbr As Integer) As SqlDataReader


        Dim rsData As SqlDataReader = Nothing
        Dim TBL As String = "DataSource"
        Dim WC As String = "Where FQN = '" + FQN + "' and   VersionNbr = " & VersionNbr


        rsData = DBARCH.GetRowByKey(TBL, WC)


        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_UK_FQN_VERNBR
    Public Function getRow_UKI_Documents(ByVal SourceGuid As String) As SqlDataReader


        Dim rsData As SqlDataReader = Nothing
        Dim TBL As String = "DataSource"
        Dim WC As String = "Where SourceGuid = '" + SourceGuid + "'"


        rsData = DBARCH.GetRowByKey(TBL, WC)


        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_UKI_Documents


    ''' Build Index Where Caluses 
    '''
    Public Function wc_PI_DIR(ByVal DataSourceOwnerUserID As String, ByVal FileDirectory As String) As String


        Dim WC As String = "Where DataSourceOwnerUserID = '" + DataSourceOwnerUserID + "' and   FileDirectory = '" + FileDirectory + "'"


        Return WC
    End Function     '** wc_PI_DIR
    Public Function wc_PI_FQN_USERID(ByVal DataSourceOwnerUserID As String, ByVal FQN As String) As String


        Dim WC As String = "Where DataSourceOwnerUserID = '" + DataSourceOwnerUserID + "' and   FQN = '" + FQN + "'"


        Return WC
    End Function     '** wc_PI_FQN_USERID
    Public Function wc_PK33_04012008185318001(ByVal DataSourceOwnerUserID As String, ByVal SourceGuid As String) As String


        Dim WC As String = "Where DataSourceOwnerUserID = '" + DataSourceOwnerUserID + "' and   SourceGuid = '" + SourceGuid + "'"


        Return WC
    End Function     '** wc_PK33_04012008185318001
    Public Function wc_UK_FQN_VERNBR(ByVal FQN As String, ByVal VersionNbr As Integer) As String


        Dim WC As String = "Where FQN = '" + FQN + "' and   VersionNbr = " & VersionNbr


        Return WC
    End Function     '** wc_UK_FQN_VERNBR
    Public Function wc_UKI_Documents(ByVal SourceGuid As String) As String


        Dim WC As String = "Where SourceGuid = '" + SourceGuid + "'"


        Return WC
    End Function     '** wc_UKI_Documents


    '** Generate the SET methods 




    Function ImageUpdt_SourceImage(ByVal WhereClause As String, ByVal FQN As String) As Boolean
        Dim b As Boolean = False
        Try
            Dim ConnStr As String = DBARCH.setConnStr()     'DBARCH.getGateWayConnStr(gGateWayID)
            Dim connection As New SqlConnection(ConnStr)
            Dim command As New SqlCommand("UPDATE DataSource SET SourceImage = @FileContents '" + WhereClause + "'", connection)
            command.Parameters.Add("@FileContents", SqlDbType.VarBinary).Value = IO.File.ReadAllBytes(FQN)
            connection.Open()
            command.ExecuteNonQuery()
            connection.Close()
            b = True
        Catch ex As Exception
            b = False
            LOG.WriteToArchiveLog("clsZIPDATASOURCE : ImageUpdt_SourceImage : 297 : " + ex.Message)
        End Try
        Return b
    End Function
    Function ImageToFile_SourceImage(ByVal WhereClause As String, ByVal FQN As String, ByVal OverWrite As Boolean) As Boolean
        Dim B As Boolean = True
        Dim SourceTblName As String = "DataSource"
        Dim ImageFieldName As String = "SourceImage"


        Try
            Dim S As String = ""
            S = S + " SELECT "
            S = S + " [SourceImage]"
            S = S + " FROM  [DataSource]"
            S = S + WhereClause


            Dim CN As New SqlConnection(DBARCH.setConnStr())     'DBARCH.getGateWayConnStr(gGateWayID))


            If CN.State = ConnectionState.Closed Then
                CN.Open()
            End If


            Dim da As New SqlDataAdapter(S, CN)
            Dim MyCB As SqlCommandBuilder = New SqlCommandBuilder(da)
            Dim ds As New DataSet()


            da.Fill(ds, SourceTblName)
            Dim myRow As DataRow
            myRow = ds.Tables(SourceTblName).Rows(0)


            Dim MyData() As Byte
            MyData = myRow(SourceImage)
            Dim K As Long
            K = UBound(MyData)
            Try
                If OverWrite Then
                    'If File.Exists(FQN) Then
                    '    File.Delete(FQN)
                    'End If
                Else
                    If File.Exists(FQN) Then
                        Return False
                    End If
                End If
                Dim fs As New FileStream(FQN, FileMode.Create, FileAccess.Write)
                fs.Write(MyData, 0, K)
                fs.Close()
                fs = Nothing
                B = True
            Catch ex As Exception
                Debug.Print(ex.Message)
                DBARCH.xTrace(58342.15, "image write - ZipDataSource:SourceImage", ex.Message)
                B = False
                LOG.WriteToArchiveLog("clsZIPDATASOURCE : ImageToFile_SourceImage : 337 : " + ex.Message)
            End Try


            MyCB = Nothing
            ds = Nothing
            da = Nothing


            CN.Close()
            CN = Nothing
            GC.Collect()
        Catch ex As Exception
            Dim AppName As String = ex.Source
            DBARCH.xTrace(58342.1, "ZipDataSource", ex.Message)
            LOG.WriteToArchiveLog("clsZIPDATASOURCE : ImageToFile_SourceImage : 345 : " + ex.Message)
        End Try
        Return B


    End Function
End Class
