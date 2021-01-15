
Imports System.Data
Imports System.Reflection
Imports System.Web.Script.Serialization

Public Class clsDatasetMgt

    Dim LOG As New clsLoggingExtended


    Public Function ListClassProperties(ByVal TgtClass As Type) As Dictionary(Of String, String)

        Dim dict As New Dictionary(Of String, String)
        Dim name As String = ""
        Dim xtype As Object = Nothing
        'GetType(SVCSearch.DS_clsUSERGRIDSTATE)
        For Each prop In TgtClass.GetProperties()
            name = prop.Name
            xtype = prop.PropertyType.Name
            If Not dict.ContainsKey(name) Then
                dict.Add(name, xtype)
            End If
        Next

        Return dict

    End Function

    Public Function ListClassPropertiesX(ByVal ClassName As Object) As List(Of String)

        Dim ObjectDetail As New List(Of String)
        Dim _type As Type = ClassName.GetType()
        Dim properties() As PropertyInfo = _type.GetProperties()  'line 3
        Dim oType As Type = Nothing
        Dim pType As Type = Nothing

        For Each p As PropertyInfo In properties
            Console.WriteLine("Name: " + p.Name + ", Value: " + p.GetValue(ClassName, Nothing))
            oType = p.GetType
            pType = p.PropertyType.ReflectedType
            ObjectDetail.Add(p.Name + " | " + p.GetValue(ClassName, Nothing) + " | " + p.GetType.Attributes + " | " + p.PropertyType.ToString)
        Next

        Return ObjectDetail
    End Function

    Public Function ListObjectProperties(OBJ As Object) As List(Of String)

        Dim pname As String = ""
        Dim pval As Object = Nothing
        Dim ObjectDetail As New List(Of String)

        For Each p As System.Reflection.PropertyInfo In OBJ.GetType().GetProperties()
            If p.CanRead Then
                Console.WriteLine("{0}: {1}", p.Name, p.GetValue(OBJ, Nothing))
                ObjectDetail.Add(p.Name + " | " + p.GetValue(OBJ, Nothing))
            End If
        Next

        Return ObjectDetail

    End Function

    '*********************************************************************************************************************************************************************
    Public Function ConvertObjDS_SearchTerms() As DataSet

        Dim B As Boolean = True
        Dim DS As New DataSet
        Dim DT As DataTable
        'Dim DR As DataRow
        Dim SearchTypeCode As DataColumn
        Dim Term As DataColumn
        Dim TermVal As DataColumn
        Dim TermDatatype As DataColumn

        Dim sSearchTypeCode As String = ""
        Dim sTerm As String = ""
        Dim sTermVal As String = ""
        Dim sTermDatatype As String = ""

        'Dim i As Integer

        DT = New DataTable()
        SearchTypeCode = New DataColumn("SearchTypeCode", Type.GetType("System.String"))
        Term = New DataColumn("Term", Type.GetType("System.String"))
        TermVal = New DataColumn("TermVal", Type.GetType("System.String"))
        TermDatatype = New DataColumn("TermDatatype", Type.GetType("System.String"))

        DT.Columns.Add(SearchTypeCode)
        DT.Columns.Add(Term)
        DT.Columns.Add(TermVal)
        DT.Columns.Add(TermDatatype)

        If gDebug Then Console.WriteLine("DMGT Trace 700")

        For Each Obj As Object In ListOfSearchTerms
            sSearchTypeCode = Obj.SearchTypeCode
            sTerm = Obj.Term
            sTermVal = Obj.TermVal
            sTermDatatype = Obj.TermDatatype
            B = AddSearchTermRow(DT, sSearchTypeCode, sTerm, sTermVal, sTermDatatype)
        Next

        DS.Tables.Add(DT)
        DT.Dispose()

        Return DS

    End Function

    Private Function AddSearchTermRow(ByRef DT As DataTable, SearchTypeCode As String, Term As String, TermVal As String, TermDatatype As String) As Boolean
        Dim b As Boolean = True
        Dim DR As DataRow

        Try
            DR = DT.NewRow()
            DR("SearchTypeCode") = SearchTypeCode
            DR("Term") = Term
            DR("TermVal") = TermVal
            DR("TermDatatype") = TermDatatype
            DT.Rows.Add(DR)
            b = True
        Catch ex As Exception
            LOG.WriteTraceLog("ERROR AddSearchTermRow : 01 : " + SearchTypeCode + " : " + Term + " : " + TermVal + " : " + TermDatatype + " : " + Environment.NewLine + ex.Message)
            Console.WriteLine("ERROR AddSearchTermRow : 01 : " + SearchTypeCode + " : " + Term + " : " + TermVal + " : " + TermDatatype + " : " + Environment.NewLine + ex.Message)
            b = False
        End Try
        Return b
    End Function
    '*********************************************************************************************************************************************************************


    '*********************************************************************************************************************************************************************
    Public Function ConvertObjGroupUserGridDataset(ObjListOfRows As Object) As DataSet

        Dim B As Boolean = True
        Dim DS As New DataSet
        Dim DT As DataTable
        'Dim DR As DataRow
        Dim UserName As DataColumn
        Dim UserID As DataColumn

        Dim sUserName As String = ""
        Dim sUserID As String = ""

        'Dim i As Integer

        DT = New DataTable()
        UserName = New DataColumn("UserName", Type.GetType("System.String"))
        UserID = New DataColumn("UserID", Type.GetType("System.String"))

        DT.Columns.Add(UserName)
        DT.Columns.Add(UserID)

        If gDebug Then Console.WriteLine("DMGT Trace 311")

        For Each Obj As DS_DgAssigned In ObjListOfRows
            sUserName = Obj.GroupName
            sUserID = Obj.GroupOwnerUserID
            B = AddGroupUserGridRow(DT, sUserName, sUserID)
        Next

        DS.Tables.Add(DT)
        DT.Dispose()

        Return DS

    End Function

    Private Function AddGroupUserGridRow(ByRef DT As DataTable, GroupName As String, GroupOwnerUserID As String) As Boolean
        Dim b As Boolean = True
        Dim DR As DataRow

        Try
            DR = DT.NewRow()
            DR("GroupName") = GroupName
            DR("GroupOwnerUserID") = GroupOwnerUserID
            DT.Rows.Add(DR)
            b = True
        Catch ex As Exception
            LOG.WriteTraceLog("ERROR AddLibraryDTRow : 01 GroupName: " + GroupName + Environment.NewLine + ex.Message)
            Console.WriteLine("ERROR AddLibraryDTRow : 01" + ex.Message)
            b = False
        End Try
        Return b
    End Function
    '*********************************************************************************************************************************************************************

    '*********************************************************************************************************************************************************************
    Public Function ConvertObjToDgAssignedDataset(ObjListOfRows As Object) As DataSet

        Dim B As Boolean = True
        Dim DS As New DataSet
        Dim DT As DataTable
        'Dim DR As DataRow
        Dim GroupName As DataColumn
        Dim GroupOwnerUserID As DataColumn

        Dim sGroupName As String = ""
        Dim sGroupOwnerUserID As String = ""

        'Dim i As Integer

        DT = New DataTable()
        GroupName = New DataColumn("GroupName", Type.GetType("System.String"))
        GroupOwnerUserID = New DataColumn("GroupOwnerUserID", Type.GetType("System.String"))

        DT.Columns.Add(GroupName)
        DT.Columns.Add(GroupOwnerUserID)

        If gDebug Then Console.WriteLine("DMGT Trace 311")
        'Dim ListOfRows As New System.Collections.ObjectModel.ObservableCollection(Of DS_DgAssigned)
        'Dim jss = New JavaScriptSerializer()
        'Dim ObjContent As Object = jss.Deserialize(Of DS_DgAssigned())(ObjListOfRows)
        'Dim Z As Integer = ObjContent.Count

        For Each Obj As DS_DgAssigned In ObjListOfRows
            sGroupName = Obj.GroupName
            sGroupOwnerUserID = Obj.GroupOwnerUserID
            B = AddDgAssignedRow(DT, sGroupName, sGroupOwnerUserID)
        Next

        DS.Tables.Add(DT)
        DT.Dispose()

        Return DS

    End Function

    Private Function AddDgAssignedRow(ByRef DT As DataTable, GroupName As String, GroupOwnerUserID As String) As Boolean
        Dim b As Boolean = True
        Dim DR As DataRow

        Try
            DR = DT.NewRow()
            DR("GroupName") = GroupName
            DR("GroupOwnerUserID") = GroupOwnerUserID
            DT.Rows.Add(DR)
            b = True
        Catch ex As Exception
            LOG.WriteTraceLog("ERROR AddLibraryDTRow : 01 GroupName: " + GroupName + Environment.NewLine + ex.Message)
            Console.WriteLine("ERROR AddLibraryDTRow : 01" + ex.Message)
            b = False
        End Try
        Return b
    End Function


    '*********************************************************************************************************************************************************************
    Public Function ConvertObjToLibraryDataset(ObjListOfRows As Object) As DataSet

        Dim B As Boolean = True
        Dim DS As New DataSet
        Dim DT As DataTable
        'Dim DR As DataRow
        Dim LibraryName As DataColumn
        Dim isPublic As DataColumn
        Dim Items As DataColumn
        Dim Members As DataColumn

        Dim sLibraryName As String = ""
        Dim sisPublic As String = ""
        Dim sItems As Int32 = -1
        Dim sMembers As Int32 = -1
        'Dim i As Integer

        DT = New DataTable()
        LibraryName = New DataColumn("LibraryName", Type.GetType("System.String"))
        isPublic = New DataColumn("isPublic", Type.GetType("System.String"))
        Items = New DataColumn("Items", Type.GetType("System.Int32"))
        Members = New DataColumn("Members", Type.GetType("System.Int32"))

        DT.Columns.Add(LibraryName)
        DT.Columns.Add(isPublic)
        DT.Columns.Add(Items)
        DT.Columns.Add(Members)

        If gDebug Then Console.WriteLine("DMGT Trace 11")
        Dim ListOfRows As New System.Collections.ObjectModel.ObservableCollection(Of DS_VLibraryStats)
        Dim jss = New JavaScriptSerializer()
        Dim ObjContent = jss.Deserialize(Of DS_VLibraryStats())(ObjListOfRows)
        Dim Z As Integer = ObjContent.Count
        For Each Obj As DS_VLibraryStats In ObjContent
            sLibraryName = Obj.LibraryName
            sisPublic = Obj.isPublic
            sItems = Convert.ToInt32(Obj.Items)
            sMembers = Convert.ToInt32(Obj.Members)
            B = AddLibraryDTRow(DT, sLibraryName, sisPublic, sItems, sMembers)
        Next

        DS.Tables.Add(DT)
        DT.Dispose()



        Return DS

    End Function

    Private Function AddLibraryDTRow(ByRef DT As DataTable, LibraryName As String, isPublic As String, Items As Int32, Members As Int32) As Boolean
        Dim b As Boolean = True
        Dim DR As DataRow

        Try
            DR = DT.NewRow()
            DR("LibraryName") = LibraryName
            DR("isPublic") = isPublic
            DR("Items") = Items
            DR("Members") = Members
            DT.Rows.Add(DR)
            b = True
        Catch ex As Exception
            LOG.WriteTraceLog("ERROR AddLibraryDTRow : 01 LibraryName: " + LibraryName + Environment.NewLine + ex.Message)
            Console.WriteLine("ERROR AddLibraryDTRow : 01" + ex.Message)
            b = False
        End Try


        Return b
    End Function

    '*********************************************************************************************************************************************************************

    Public Function ConvertObjContentToDataset(ObjListOfRows As Object) As DataSet

        Dim B As Boolean = True
        Dim DS As New DataSet
        Dim DT As New DataTable


        Dim sCreateDate As DateTime = Nothing
        Dim sDataSourceOwnerUserID As String = Nothing
        Dim sDescription As String = Nothing
        Dim sFileDirectory As String = Nothing
        Dim sFileLength As Int64 = Nothing
        Dim sFQN As String = Nothing
        Dim sisPublic As String = Nothing
        Dim sisWebPage As String = Nothing
        Dim sLastAccessDate As DateTime = Nothing
        Dim sLastWriteTime As DateTime = Nothing
        Dim sRepoSvrName As String = Nothing
        Dim sRetentionExpirationDate As DateTime = Nothing
        Dim sRssLinkFlg As Boolean = Nothing
        Dim sSourceGuid As String = Nothing
        Dim sSourceName As String = Nothing
        Dim sSourceTypeCode As String = Nothing
        Dim sStructuredData As Boolean = Nothing
        Dim sVersionNbr As Int64 = Nothing

        Dim CreateDate As DataColumn = New DataColumn("CreateDate", Type.GetType("System.DateTime"))
        Dim DataSourceOwnerUserID As DataColumn = New DataColumn("DataSourceOwnerUserID", Type.GetType("System.String"))
        Dim Description As DataColumn = New DataColumn("Description", Type.GetType("System.String"))
        Dim FileDirectory As DataColumn = New DataColumn("FileDirectory", Type.GetType("System.String"))
        Dim FileLength As DataColumn = New DataColumn("FileLength", Type.GetType("System.Int64"))
        Dim FQN As DataColumn = New DataColumn("FQN", Type.GetType("System.String"))
        Dim isPublic As DataColumn = New DataColumn("isPublic", Type.GetType("System.String"))
        Dim isWebPage As DataColumn = New DataColumn("isWebPage", Type.GetType("System.String"))
        Dim LastAccessDate As DataColumn = New DataColumn("LastAccessDate", Type.GetType("System.DateTime"))
        Dim LastWriteTime As DataColumn = New DataColumn("LastWriteTime", Type.GetType("System.DateTime"))
        Dim RepoSvrName As DataColumn = New DataColumn("RepoSvrName", Type.GetType("System.String"))
        Dim RetentionExpirationDate As DataColumn = New DataColumn("RetentionExpirationDate", Type.GetType("System.DateTime"))
        Dim RssLinkFlg As DataColumn = New DataColumn("RssLinkFlg", Type.GetType("System.Boolean"))
        Dim SourceGuid As DataColumn = New DataColumn("SourceGuid", Type.GetType("System.String"))
        Dim SourceName As DataColumn = New DataColumn("SourceName", Type.GetType("System.String"))
        Dim SourceTypeCode As DataColumn = New DataColumn("SourceTypeCode", Type.GetType("System.String"))
        Dim StructuredData As DataColumn = New DataColumn("StructuredData", Type.GetType("System.Boolean"))
        Dim VersionNbr As DataColumn = New DataColumn("VersionNbr", Type.GetType("System.DateTime"))

        DT.Columns.Add(CreateDate)
        DT.Columns.Add(DataSourceOwnerUserID)
        DT.Columns.Add(Description)
        DT.Columns.Add(FileDirectory)
        DT.Columns.Add(FileLength)
        DT.Columns.Add(FQN)
        DT.Columns.Add(isPublic)
        DT.Columns.Add(isWebPage)
        DT.Columns.Add(LastAccessDate)
        DT.Columns.Add(LastWriteTime)
        DT.Columns.Add(RepoSvrName)
        DT.Columns.Add(RetentionExpirationDate)
        DT.Columns.Add(RssLinkFlg)
        DT.Columns.Add(SourceGuid)
        DT.Columns.Add(SourceName)
        DT.Columns.Add(SourceTypeCode)
        DT.Columns.Add(StructuredData)
        DT.Columns.Add(VersionNbr)

        If gDebug Then Console.WriteLine("DMGT Trace 11")
        'Dim jss = New JavaScriptSerializer()
        'Dim ObjContent = jss.Deserialize(Of SVCSearch.DS_CONTENT())(ObjListOfRows)
        'Dim Z As Integer = ObjListOfRows

        Dim ProcessedGuids As List(Of String) = New List(Of String)

        For Each Obj As SVCSearch.DS_CONTENT In ObjListOfRows
            sCreateDate = Obj.CreateDate
            sDataSourceOwnerUserID = Obj.DataSourceOwnerUserID
            sDescription = Obj.Description
            sFileDirectory = Obj.FileDirectory
            sFileLength = Obj.FileLength
            sFQN = Obj.FQN
            sisPublic = Obj.isPublic
            If sisPublic.Trim.Length.Equals(0) Then
                sisPublic = "N"
            End If
            sisWebPage = Obj.isWebPage
            If sisWebPage.Trim.Length.Equals(0) Then
                sisWebPage = "N"
            End If
            sLastAccessDate = Obj.LastAccessDate
            sLastWriteTime = Obj.LastWriteTime
            sRepoSvrName = Obj.RepoSvrName
            sRetentionExpirationDate = Obj.RetentionExpirationDate
            sRssLinkFlg = Obj.RssLinkFlg
            sSourceGuid = Obj.SourceGuid
            sSourceName = Obj.SourceName
            sSourceTypeCode = Obj.OriginalFileType
            sStructuredData = Obj.StructuredData
            sVersionNbr = Obj.VersionNbr

            If Not ProcessedGuids.Contains(sSourceGuid) Then
                ProcessedGuids.Add(sSourceGuid)
                B = AddContentDTRow(DT _
                               , sCreateDate _
                                , sDataSourceOwnerUserID _
                                , sDescription _
                                , sFileDirectory _
                                , sFileLength _
                                , sFQN _
                                , sisPublic _
                                , sisWebPage _
                                , sLastAccessDate _
                                , sLastWriteTime _
                                , sRepoSvrName _
                                , sRetentionExpirationDate _
                                , sRssLinkFlg _
                                , sSourceGuid _
                                , sSourceName _
                                , sSourceTypeCode _
                                , sStructuredData _
                                , sVersionNbr
                                )
            Else
                Console.WriteLine("Duplicate Found: " + sSourceGuid)
            End If

        Next

        DS.Tables.Add(DT)
        'DT.Dispose()



        Return DS

    End Function

    Private Function AddContentDTRow(ByRef DT As DataTable _
                                    , CreateDate As DateTime _
                                    , DataSourceOwnerUserID As String _
                                    , Description As String _
                                    , FileDirectory As String _
                                    , FileLength As Int64 _
                                    , FQN As String _
                                    , isPublic As String _
                                    , isWebPage As String _
                                    , LastAccessDate As DateTime _
                                    , LastWriteTime As DateTime _
                                    , RepoSvrName As String _
                                    , RetentionExpirationDate As DateTime _
                                    , RssLinkFlg As Boolean _
                                    , SourceGuid As String _
                                    , SourceName As String _
                                    , SourceTypeCode As String _
                                    , StructuredData As Boolean _
                                    , VersionNbr As Int64) As Boolean

        Dim b As Boolean = True
        Dim DR As DataRow = Nothing

        Try
            DR = DT.NewRow()
            DR("CreateDate") = CreateDate
            DR("DataSourceOwnerUserID") = DataSourceOwnerUserID
            DR("Description") = Description
            DR("FileDirectory") = FileDirectory
            DR("FileLength") = FileLength
            DR("FQN") = FQN
            DR("isPublic") = isPublic
            DR("isWebPage") = isWebPage
            DR("LastAccessDate") = LastAccessDate
            DR("LastWriteTime") = LastWriteTime
            DR("RepoSvrName") = RepoSvrName
            DR("RetentionExpirationDate") = RetentionExpirationDate
            DR("RssLinkFlg") = RssLinkFlg
            DR("SourceGuid") = SourceGuid
            DR("SourceName") = SourceName
            DR("SourceTypeCode") = SourceTypeCode
            DR("StructuredData") = StructuredData
            'DR("VersionNbr") = VersionNbr
            DT.Rows.Add(DR)
            b = True
        Catch ex As Exception
            LOG.WriteTraceLog("ERROR AddLibraryDTRow : 01 DataSourceOwnerUserID: " + DataSourceOwnerUserID + Environment.NewLine + ex.Message)
            Console.WriteLine("ERROR AddLibraryDTRow : 01" + ex.Message)
            b = False
        End Try

        Return b
    End Function

    '*********************************************************************************************************************************************************************
    '*********************************************************************************************************************************************************************

    Public Function ConvertObjEmailToDataset(ObjListOfRows As Object) As DataSet

        Dim L As Integer = 0
        Dim B As Boolean = True
        Dim DS As New DataSet
        Dim DT As New DataTable

        Dim AllRecipients = New DataColumn("AllRecipients", Type.GetType("System.String")) : L = 1
        Dim Bcc = New DataColumn("Bcc", Type.GetType("System.String")) : L = 2
        Dim Body = New DataColumn("Body", Type.GetType("System.String")) : L = 3
        Dim CC = New DataColumn("CC", Type.GetType("System.String")) : L = 4
        Dim CreationTime = New DataColumn("CreationTime", Type.GetType("System.DateTime")) : L = 5
        Dim EmailGuid = New DataColumn("EmailGuid", Type.GetType("System.String")) : L = 6
        Dim isPublic = New DataColumn("isPublic", Type.GetType("System.String")) : L = 7
        Dim MsgSize = New DataColumn("MsgSize", Type.GetType("System.Int64")) : L = 8
        Dim NbrAttachments = New DataColumn("NbrAttachments", Type.GetType("System.Int64")) : L = 9
        Dim OriginalFolder = New DataColumn("OriginalFolder", Type.GetType("System.String")) : L = 10
        Dim ReceivedByName = New DataColumn("ReceivedByName", Type.GetType("System.String")) : L = 11
        Dim ReceivedTime = New DataColumn("ReceivedTime", Type.GetType("System.DateTime")) : L = 12
        Dim RepoSvrName = New DataColumn("RepoSvrName", Type.GetType("System.String")) : L = 13
        Dim RetentionExpirationDate = New DataColumn("RetentionExpirationDate", Type.GetType("System.DateTime")) : L = 14
        Dim SenderEmailAddress = New DataColumn("SenderEmailAddress", Type.GetType("System.String")) : L = 15
        Dim SenderName = New DataColumn("SenderName", Type.GetType("System.String")) : L = 16
        Dim SentOn = New DataColumn("SentOn", Type.GetType("System.DateTime")) : L = 17
        Dim SentTO = New DataColumn("SentTO", Type.GetType("System.String")) : L = 18
        Dim ShortSubj = New DataColumn("ShortSubj", Type.GetType("System.String")) : L = 19
        Dim SourceTypeCode = New DataColumn("SourceTypeCode", Type.GetType("System.String")) : L = 20
        Dim SUBJECT = New DataColumn("SUBJECT", Type.GetType("System.String")) : L = 21
        Dim UserID = New DataColumn("UserID", Type.GetType("System.String")) : L = 22

        Dim sAllRecipients As String = Nothing
        Dim sBcc As String = Nothing
        Dim sBody As String = Nothing
        Dim sCC As String = Nothing
        Dim sCreationTime As DateTime = Nothing
        Dim sEmailGuid As String = Nothing
        Dim sisPublic As String = Nothing
        Dim sMsgSize As Int64 = Nothing
        Dim sNbrAttachments As Int64 = Nothing
        Dim sOriginalFolder As String = Nothing
        Dim sReceivedByName As String = Nothing
        Dim sReceivedTime As DateTime = Nothing
        Dim sRepoSvrName As String = Nothing
        Dim sRetentionExpirationDate As DateTime = Nothing
        Dim sSenderEmailAddress As String = Nothing
        Dim sSenderName As String = Nothing
        Dim sSentOn As DateTime = Nothing
        Dim sSentTO As String = Nothing
        Dim sShortSubj As String = Nothing
        Dim sSourceTypeCode As String = Nothing
        Dim sSUBJECT As String = Nothing
        Dim sUserID As String = Nothing

        Try

            DT.Columns.Add(AllRecipients)
            DT.Columns.Add(Bcc)
            DT.Columns.Add(Body)
            DT.Columns.Add(CC)
            DT.Columns.Add(CreationTime)
            DT.Columns.Add(EmailGuid)
            DT.Columns.Add(isPublic)
            DT.Columns.Add(MsgSize)
            DT.Columns.Add(NbrAttachments)
            DT.Columns.Add(OriginalFolder)
            DT.Columns.Add(ReceivedByName)
            DT.Columns.Add(ReceivedTime)
            DT.Columns.Add(RepoSvrName)
            DT.Columns.Add(RetentionExpirationDate)
            DT.Columns.Add(SenderEmailAddress)
            DT.Columns.Add(SenderName)
            DT.Columns.Add(SentOn)
            DT.Columns.Add(SentTO)
            DT.Columns.Add(ShortSubj)
            DT.Columns.Add(SourceTypeCode)
            DT.Columns.Add(SUBJECT)
            DT.Columns.Add(UserID)

            If gDebug Then Console.WriteLine("DMGT Trace 11")

            'Dim jss = New JavaScriptSerializer()
            'Dim ObjContent = jss.Deserialize(Of SVCSearch.DS_EMAIL())(ObjListOfRows)
            'Dim Z As Integer = ObjListOfRows.Count

            For Each Obj As SVCSearch.DS_EMAIL In ObjListOfRows
                'For Each Obj As Object In ObjListOfRows

                sAllRecipients = Obj.AllRecipients
                sBcc = Obj.Bcc
                sBody = Obj.Body
                sCC = Obj.CC
                sCreationTime = Obj.CreationTime
                sEmailGuid = Obj.EmailGuid
                sisPublic = Obj.isPublic
                sMsgSize = Obj.MsgSize
                sNbrAttachments = Obj.NbrAttachments
                sOriginalFolder = Obj.OriginalFolder
                sReceivedByName = Obj.ReceivedByName
                sReceivedTime = Obj.ReceivedTime
                sRepoSvrName = Obj.RepoSvrName
                sRetentionExpirationDate = Obj.RetentionExpirationDate
                sSenderEmailAddress = Obj.SenderEmailAddress
                sSenderName = Obj.SenderName
                sSentOn = Obj.SentOn
                sSentTO = Obj.SentTO
                sShortSubj = Obj.ShortSubj
                sSourceTypeCode = Obj.SourceTypeCode
                sSUBJECT = Obj.SUBJECT
                sUserID = Obj.UserID

                B = AddEmailDTRow(DT _
                                    , sAllRecipients _
                                    , sBcc _
                                    , sBody _
                                    , sCC _
                                    , sCreationTime _
                                    , sEmailGuid _
                                    , sisPublic _
                                    , sMsgSize _
                                    , sNbrAttachments _
                                    , sOriginalFolder _
                                    , sReceivedByName _
                                    , sReceivedTime _
                                    , sRepoSvrName _
                                    , sRetentionExpirationDate _
                                    , sSenderEmailAddress _
                                    , sSenderName _
                                    , sSentOn _
                                    , sSentTO _
                                    , sShortSubj _
                                    , sSourceTypeCode _
                                    , sSUBJECT _
                                    , sUserID
                                    )
            Next
        Catch ex As Exception
            LOG.WriteTraceLog("ERROR AddLibraryDTRow : 01 EmailGuid: " + sEmailGuid + " - L=" + L.ToString + Environment.NewLine + ex.Message)
            Console.WriteLine("ERROR AddLibraryDTRow : 01 EmailGuid: " + sEmailGuid + " - L=" + L.ToString + Environment.NewLine + ex.Message)
        End Try

        DS.Tables.Add(DT)
        DT.Dispose()

        Dim O = DS.Tables(0)

        Return DS

    End Function

    Private Function AddEmailDTRow(ByRef DT As DataTable _
                                   , AllRecipients As String _
                                    , Bcc As String _
                                    , Body As String _
                                    , CC As String _
                                    , CreationTime As DateTime _
                                    , EmailGuid As String _
                                    , isPublic As String _
                                    , MsgSize As Int64 _
                                    , NbrAttachments As Int64 _
                                    , OriginalFolder As String _
                                    , ReceivedByName As String _
                                    , ReceivedTime As DateTime _
                                    , RepoSvrName As String _
                                    , RetentionExpirationDate As DateTime _
                                    , SenderEmailAddress As String _
                                    , SenderName As String _
                                    , SentOn As DateTime _
                                    , SentTO As String _
                                    , ShortSubj As String _
                                    , SourceTypeCode As String _
                                    , SUBJECT As String _
                                    , UserID As String) As Boolean

        Dim b As Boolean = True
        Dim DR As DataRow = Nothing

        Try
            DR = DT.NewRow()
            DR("AllRecipients") = AllRecipients
            DR("Bcc") = Bcc
            DR("Body") = Body
            DR("CC") = CC
            DR("CreationTime") = CreationTime
            DR("EmailGuid") = EmailGuid
            DR("isPublic") = isPublic
            DR("MsgSize") = MsgSize
            DR("NbrAttachments") = NbrAttachments
            DR("OriginalFolder") = OriginalFolder
            DR("ReceivedByName") = ReceivedByName
            DR("ReceivedTime") = ReceivedTime
            DR("RepoSvrName") = RepoSvrName
            DR("RetentionExpirationDate") = RetentionExpirationDate
            DR("SenderEmailAddress") = SenderEmailAddress
            DR("SenderName") = SenderName
            DR("SentOn") = SentOn
            DR("SentTO") = SentTO
            DR("ShortSubj") = ShortSubj
            DR("SourceTypeCode") = SourceTypeCode
            DR("SUBJECT") = SUBJECT
            DR("UserID") = UserID
            DT.Rows.Add(DR)
            b = True
        Catch ex As Exception
            LOG.WriteTraceLog("ERROR AddLibraryDTRow : 01 EmailGuid: " + EmailGuid + Environment.NewLine + ex.Message)
            Console.WriteLine("ERROR AddLibraryDTRow : 01" + ex.Message)
            b = False
        End Try

        Return b
    End Function

    '*********************************************************************************************************************************************************************
    '*********************************************************************************************************************************************************************
    Public Function ConvertObjToEmailAttachmentDS(ObjListOfRows As Object) As DataSet

        Dim B As Boolean = True
        Dim DS As New DataSet
        Dim DT As New DataTable


        Dim sAttachmentName As String = Nothing
        Dim sRowID As Int64 = Nothing
        Dim sEmailGuid As String = Nothing

        Dim AttachmentName As DataColumn = New DataColumn("AttachmentName", Type.GetType("System.String"))
        Dim RowID As DataColumn = New DataColumn("RowID", Type.GetType("System.Int64"))
        Dim EmailGuid As DataColumn = New DataColumn("EmailGuid", Type.GetType("System.String"))

        DT.Columns.Add(AttachmentName)
        DT.Columns.Add(RowID)
        DT.Columns.Add(EmailGuid)

        If gDebug Then Console.WriteLine("DMGT eAttach  Trace 11")

        For Each Obj As DS_EmailAttachments In ObjListOfRows
            sAttachmentName = Obj.AttachmentName
            sRowID = Obj.RowID
            sEmailGuid = Obj.EmailGuid
            If sEmailGuid.Trim.Length.Equals(0) Then
                sEmailGuid = "?"
            End If

            B = AddEAttachDTRow(DT _
                               , sAttachmentName _
                                , sRowID _
                                , sEmailGuid
                                )

        Next

        DS.Tables.Add(DT)
        DT.Dispose()

        Return DS

    End Function

    Private Function AddEAttachDTRow(ByRef DT As DataTable _
                                    , AttachmentName As String _
                                , RowID As Int64 _
                                , EmailGuid As String) As Boolean

        Dim b As Boolean = True
        Dim DR As DataRow = Nothing

        Try
            DR = DT.NewRow()
            DR("AttachmentName") = AttachmentName
            DR("RowID") = RowID
            DR("EmailGuid") = EmailGuid
            DT.Rows.Add(DR)
            b = True
        Catch ex As Exception
            LOG.WriteTraceLog("ERROR AddEAttachDTRow : 01 Attachment EmailGuid: " + EmailGuid + Environment.NewLine + ex.Message)
            Console.WriteLine("ERROR AddEAttachDTRow : 01" + ex.Message)
            b = False
        End Try

        Return b
    End Function

    '*********************************************************************************************************************************************************************
    '*********************************************************************************************************************************************************************
    Public Function ConvertImageObjDS(ObjListOfRows As Object) As DataSet

        Dim B As Boolean = True
        Dim DS As New DataSet
        Dim DT As New DataTable
        Dim sSourceName As String = Nothing
        Dim iFileLength As Int64 = Nothing
        Dim bSourceImage As Byte() = Nothing

        Dim SourceName As DataColumn = New DataColumn("SourceName", Type.GetType("System.String"))
        Dim FileLength As DataColumn = New DataColumn("FileLength", Type.GetType("System.Int64"))
        Dim SourceImage As DataColumn = New DataColumn("SourceImage", Type.GetType("System.Byte"))

        DT.Columns.Add(SourceName)
        DT.Columns.Add(FileLength)
        DT.Columns.Add(SourceImage)

        If gDebug Then Console.WriteLine("DMGT ConvertImgObjDS  Trace 11")

        For Each Obj As DS_ImageData In ObjListOfRows
            sSourceName = Obj.SourceName
            iFileLength = Obj.FileLength
            bSourceImage = Obj.SourceImage

            B = AddImageRow(DT _
                               , sSourceName _
                                , iFileLength _
                                , bSourceImage
                                )
        Next

        DS.Tables.Add(DT)
        DT.Dispose()

        Return DS

    End Function

    Private Function AddImageRow(ByRef DT As DataTable _
                                    , SourceName As String _
                                , FileLength As Int64 _
                                , SourceImage As Byte()) As Boolean

        Dim b As Boolean = True
        Dim DR As DataRow = Nothing

        Try
            DR = DT.NewRow()
            DR("SourceName") = SourceName
            DR("FileLength") = FileLength
            DR("SourceImage") = SourceImage
            DT.Rows.Add(DR)
            b = True
        Catch ex As Exception
            LOG.WriteTraceLog("ERROR AddImageRow 01 : " + SourceName + Environment.NewLine + ex.Message)
            b = False
        End Try

        Return b
    End Function

    '*********************************************************************************************************************************************************************
End Class

Public Class TestClass
    Private _One As String = "1"
    Public Property One() As String
        Get
            Return _One
        End Get
        Set(ByVal value As String)
            _One = value
        End Set
    End Property

    Private _Two As Integer = 2
    Public Property Two() As Integer
        Get
            Return _Two
        End Get
        Set(ByVal value As Integer)
            _Two = value
        End Set
    End Property

    Private _Three As Double = 3.1415927
    Public Property Three() As Double
        Get
            Return _Three
        End Get
        Set(ByVal value As Double)
            _Three = value
        End Set
    End Property

    Private _Four As Decimal = 4.4D
    Public Property Four() As Decimal
        Get
            Return _Four
        End Get
        Set(ByVal value As Decimal)
            _Four = value
        End Set
    End Property
End Class