--D. Miller December 2012
select schema_name(t.schema_id) + '.' + t.[name] as [table],
    col.column_id,
    col.[name] as column_name,
    con.[definition],
    con.[name] as constraint_name
from sys.default_constraints con
    left outer join sys.objects t
        on con.parent_object_id = t.object_id
    left outer join sys.all_columns col
        on con.parent_column_id = col.column_id
        and con.parent_object_id = col.object_id
order by schema_name(t.schema_id) + '.' + t.[name], 
    col.column_id


select REPLACE(column_default, '''',''''''), column_default  FROM information_schema.columns where column_default IS NOT NULL


SELECT 'if not exists(select 1 from information_schema.columns where table_name = ''' + table_name 
		+ ''' and column_name = ''' + column_name 
		+ ''' and Table_schema = ''' + Table_schema 
		+ ''' and column_default= ''' + REPLACE(column_default, '''','''''') + ''')' + char(10) + 
		'    ALTER TABLE '+table_name+' ADD CONSTRAINT df_'+table_name +'_'+column_name +' DEFAULT '+ REPLACE(column_default, '','''') +' FOR '+column_name+'; ' + char(10) + 'GO'
FROM information_schema.columns
where column_default IS NOT NULL

--ALTER TABLE DataSource ADD CONSTRAINT df_DataSource_CreateDate DEFAULT 'getdate()' FOR CreateDate;

go
-- ECM.Library.FS.Default.Values
--************************************************
if not exists(select 1 from information_schema.columns where table_name = 'SystemParms' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE SystemParms ADD CONSTRAINT df_SystemParms_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'CaptureItems' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE CaptureItems ADD CONSTRAINT df_CaptureItems_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'FilesToDelete' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE FilesToDelete ADD CONSTRAINT df_FilesToDelete_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'ProcessFileAs' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE ProcessFileAs ADD CONSTRAINT df_ProcessFileAs_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'Volitility' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE Volitility ADD CONSTRAINT df_Volitility_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'ContactFrom' and column_name = 'Verified' and Table_schema = 'dbo' and column_default= '((1))')
    ALTER TABLE ContactFrom ADD CONSTRAINT df_ContactFrom_Verified DEFAULT ((1)) FOR Verified; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'ContactFrom' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE ContactFrom ADD CONSTRAINT df_ContactFrom_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'UD_Qty' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE UD_Qty ADD CONSTRAINT df_UD_Qty_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'FUncSkipWords' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE FUncSkipWords ADD CONSTRAINT df_FUncSkipWords_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'ProdCaptureItems' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE ProdCaptureItems ADD CONSTRAINT df_ProdCaptureItems_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'upgrade_status' and column_name = 'status' and Table_schema = 'dbo' and column_default= '(''INCOMPLETE'')')
    ALTER TABLE upgrade_status ADD CONSTRAINT df_upgrade_status_status DEFAULT ('INCOMPLETE') FOR status; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'upgrade_status' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE upgrade_status ADD CONSTRAINT df_upgrade_status_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'ContactsArchive' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE ContactsArchive ADD CONSTRAINT df_ContactsArchive_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'FunctionProdJargon' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE FunctionProdJargon ADD CONSTRAINT df_FunctionProdJargon_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'QtyDocs' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE QtyDocs ADD CONSTRAINT df_QtyDocs_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'UrlList' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE UrlList ADD CONSTRAINT df_UrlList_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'ContainerStorage' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE ContainerStorage ADD CONSTRAINT df_ContainerStorage_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'ExchangeHostPop' and column_name = 'SSL' and Table_schema = 'dbo' and column_default= '((0))')
    ALTER TABLE ExchangeHostPop ADD CONSTRAINT df_ExchangeHostPop_SSL DEFAULT ((0)) FOR SSL; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'ExchangeHostPop' and column_name = 'PortNbr' and Table_schema = 'dbo' and column_default= '((-1))')
    ALTER TABLE ExchangeHostPop ADD CONSTRAINT df_ExchangeHostPop_PortNbr DEFAULT ((-1)) FOR PortNbr; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'ExchangeHostPop' and column_name = 'DeleteAfterDownload' and Table_schema = 'dbo' and column_default= '((0))')
    ALTER TABLE ExchangeHostPop ADD CONSTRAINT df_ExchangeHostPop_DeleteAfterDownload DEFAULT ((0)) FOR DeleteAfterDownload; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'ExchangeHostPop' and column_name = 'IMap' and Table_schema = 'dbo' and column_default= '((0))')
    ALTER TABLE ExchangeHostPop ADD CONSTRAINT df_ExchangeHostPop_IMap DEFAULT ((0)) FOR IMap; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'ExchangeHostPop' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE ExchangeHostPop ADD CONSTRAINT df_ExchangeHostPop_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'UrlRejection' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE UrlRejection ADD CONSTRAINT df_UrlRejection_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'QuickDirectory' and column_name = 'ckMetaData' and Table_schema = 'dbo' and column_default= '(''N'')')
    ALTER TABLE QuickDirectory ADD CONSTRAINT df_QuickDirectory_ckMetaData DEFAULT ('N') FOR ckMetaData; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'QuickDirectory' and column_name = 'ckDisableDir' and Table_schema = 'dbo' and column_default= '(''N'')')
    ALTER TABLE QuickDirectory ADD CONSTRAINT df_QuickDirectory_ckDisableDir DEFAULT ('N') FOR ckDisableDir; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'QuickDirectory' and column_name = 'QuickRefEntry' and Table_schema = 'dbo' and column_default= '((1))')
    ALTER TABLE QuickDirectory ADD CONSTRAINT df_QuickDirectory_QuickRefEntry DEFAULT ((1)) FOR QuickRefEntry; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'QuickDirectory' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE QuickDirectory ADD CONSTRAINT df_QuickDirectory_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'UserCurrParm' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE UserCurrParm ADD CONSTRAINT df_UserCurrParm_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'ConvertedDocs' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE ConvertedDocs ADD CONSTRAINT df_ConvertedDocs_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'GroupLibraryAccess' and column_name = 'HiveActive' and Table_schema = 'dbo' and column_default= '((0))')
    ALTER TABLE GroupLibraryAccess ADD CONSTRAINT df_GroupLibraryAccess_HiveActive DEFAULT ((0)) FOR HiveActive; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'GroupLibraryAccess' and column_name = 'RepoSvrName' and Table_schema = 'dbo' and column_default= '(@@servername)')
    ALTER TABLE GroupLibraryAccess ADD CONSTRAINT df_GroupLibraryAccess_RepoSvrName DEFAULT (@@servername) FOR RepoSvrName; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'GroupLibraryAccess' and column_name = 'RowCreationDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE GroupLibraryAccess ADD CONSTRAINT df_GroupLibraryAccess_RowCreationDate DEFAULT (getdate()) FOR RowCreationDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'GroupLibraryAccess' and column_name = 'RowLastModDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE GroupLibraryAccess ADD CONSTRAINT df_GroupLibraryAccess_RowLastModDate DEFAULT (getdate()) FOR RowLastModDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'GroupLibraryAccess' and column_name = 'RepoName' and Table_schema = 'dbo' and column_default= '(db_name())')
    ALTER TABLE GroupLibraryAccess ADD CONSTRAINT df_GroupLibraryAccess_RepoName DEFAULT (db_name()) FOR RepoName; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'GroupLibraryAccess' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE GroupLibraryAccess ADD CONSTRAINT df_GroupLibraryAccess_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'QuickRef' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE QuickRef ADD CONSTRAINT df_QuickRef_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'GroupUsers' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE GroupUsers ADD CONSTRAINT df_GroupUsers_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'CoOwner' and column_name = 'CreateDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE CoOwner ADD CONSTRAINT df_CoOwner_CreateDate DEFAULT (getdate()) FOR CreateDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'CoOwner' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE CoOwner ADD CONSTRAINT df_CoOwner_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'Container' and column_name = 'ContainerGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE Container ADD CONSTRAINT df_Container_ContainerGuid DEFAULT (newid()) FOR ContainerGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'Container' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE Container ADD CONSTRAINT df_Container_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'ActiveDirUser' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE ActiveDirUser ADD CONSTRAINT df_ActiveDirUser_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'ContentContainer' and column_name = 'ContentUserRowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE ContentContainer ADD CONSTRAINT df_ContentContainer_ContentUserRowGuid DEFAULT (newid()) FOR ContentUserRowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'ContentContainer' and column_name = 'ContainerGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE ContentContainer ADD CONSTRAINT df_ContentContainer_ContainerGuid DEFAULT (newid()) FOR ContainerGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'ContentContainer' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE ContentContainer ADD CONSTRAINT df_ContentContainer_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'ActiveSession' and column_name = 'InitDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE ActiveSession ADD CONSTRAINT df_ActiveSession_InitDate DEFAULT (getdate()) FOR InitDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'ActiveSession' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE ActiveSession ADD CONSTRAINT df_ActiveSession_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'AlertContact' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE AlertContact ADD CONSTRAINT df_AlertContact_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'ContentUser' and column_name = 'NbrOccurances' and Table_schema = 'dbo' and column_default= '((1))')
    ALTER TABLE ContentUser ADD CONSTRAINT df_ContentUser_NbrOccurances DEFAULT ((1)) FOR NbrOccurances; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'ContentUser' and column_name = 'ContentUserRowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE ContentUser ADD CONSTRAINT df_ContentUser_ContentUserRowGuid DEFAULT (newid()) FOR ContentUserRowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'ContentUser' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE ContentUser ADD CONSTRAINT df_ContentUser_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'AlertHistory' and column_name = 'CreateDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE AlertHistory ADD CONSTRAINT df_AlertHistory_CreateDate DEFAULT (getdate()) FOR CreateDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'AlertHistory' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE AlertHistory ADD CONSTRAINT df_AlertHistory_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'AlertWord' and column_name = 'ExpirationDate' and Table_schema = 'dbo' and column_default= '(getdate()+(90))')
    ALTER TABLE AlertWord ADD CONSTRAINT df_AlertWord_ExpirationDate DEFAULT (getdate()+(90)) FOR ExpirationDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'AlertWord' and column_name = 'CreateDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE AlertWord ADD CONSTRAINT df_AlertWord_CreateDate DEFAULT (getdate()) FOR CreateDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'AlertWord' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE AlertWord ADD CONSTRAINT df_AlertWord_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'CorpContainer' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE CorpContainer ADD CONSTRAINT df_CorpContainer_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'CLC_DIR' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE CLC_DIR ADD CONSTRAINT df_CLC_DIR_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'CLC_Download' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE CLC_Download ADD CONSTRAINT df_CLC_Download_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'ImageTypeCodes' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE ImageTypeCodes ADD CONSTRAINT df_ImageTypeCodes_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'CLC_Preview' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE CLC_Preview ADD CONSTRAINT df_CLC_Preview_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'Recipients' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE Recipients ADD CONSTRAINT df_Recipients_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'CLCState' and column_name = 'CLCInstalled' and Table_schema = 'dbo' and column_default= '((0))')
    ALTER TABLE CLCState ADD CONSTRAINT df_CLCState_CLCInstalled DEFAULT ((0)) FOR CLCInstalled; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'CLCState' and column_name = 'CLCActive' and Table_schema = 'dbo' and column_default= '((0))')
    ALTER TABLE CLCState ADD CONSTRAINT df_CLCState_CLCActive DEFAULT ((0)) FOR CLCActive; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'CLCState' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE CLCState ADD CONSTRAINT df_CLCState_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'IncludeImmediate' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE IncludeImmediate ADD CONSTRAINT df_IncludeImmediate_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'ConnectionStrings' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE ConnectionStrings ADD CONSTRAINT df_ConnectionStrings_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'ConnectionStringsRegistered' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE ConnectionStringsRegistered ADD CONSTRAINT df_ConnectionStringsRegistered_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'Retention' and column_name = 'DaysWarning' and Table_schema = 'dbo' and column_default= '((30))')
    ALTER TABLE Retention ADD CONSTRAINT df_Retention_DaysWarning DEFAULT ((30)) FOR DaysWarning; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'Retention' and column_name = 'ResponseRequired' and Table_schema = 'dbo' and column_default= '(''Y'')')
    ALTER TABLE Retention ADD CONSTRAINT df_Retention_ResponseRequired DEFAULT ('Y') FOR ResponseRequired; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'Retention' and column_name = 'HiveActive' and Table_schema = 'dbo' and column_default= '((0))')
    ALTER TABLE Retention ADD CONSTRAINT df_Retention_HiveActive DEFAULT ((0)) FOR HiveActive; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'Retention' and column_name = 'RepoSvrName' and Table_schema = 'dbo' and column_default= '(@@servername)')
    ALTER TABLE Retention ADD CONSTRAINT df_Retention_RepoSvrName DEFAULT (@@servername) FOR RepoSvrName; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'Retention' and column_name = 'RowCreationDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE Retention ADD CONSTRAINT df_Retention_RowCreationDate DEFAULT (getdate()) FOR RowCreationDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'Retention' and column_name = 'RowLastModDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE Retention ADD CONSTRAINT df_Retention_RowLastModDate DEFAULT (getdate()) FOR RowLastModDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'Retention' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE Retention ADD CONSTRAINT df_Retention_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'Retention' and column_name = 'RetentionPeriod' and Table_schema = 'dbo' and column_default= '(''Year'')')
    ALTER TABLE Retention ADD CONSTRAINT df_Retention_RetentionPeriod DEFAULT ('Year') FOR RetentionPeriod; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'CorpFunction' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE CorpFunction ADD CONSTRAINT df_CorpFunction_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'CS' and column_name = 'ConnectionType' and Table_schema = 'dbo' and column_default= '(''ECMLIB'')')
    ALTER TABLE CS ADD CONSTRAINT df_CS_ConnectionType DEFAULT ('ECMLIB') FOR ConnectionType; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'CS' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE CS ADD CONSTRAINT df_CS_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'Library' and column_name = 'isPublic' and Table_schema = 'dbo' and column_default= '(''N'')')
    ALTER TABLE Library ADD CONSTRAINT df_Library_isPublic DEFAULT ('N') FOR isPublic; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'Library' and column_name = 'RepoSvrName' and Table_schema = 'dbo' and column_default= '(@@servername)')
    ALTER TABLE Library ADD CONSTRAINT df_Library_RepoSvrName DEFAULT (@@servername) FOR RepoSvrName; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'Library' and column_name = 'RepoName' and Table_schema = 'dbo' and column_default= '(db_name())')
    ALTER TABLE Library ADD CONSTRAINT df_Library_RepoName DEFAULT (db_name()) FOR RepoName; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'Library' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE Library ADD CONSTRAINT df_Library_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'CS_SharePoint' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE CS_SharePoint ADD CONSTRAINT df_CS_SharePoint_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'DatabaseFiles' and column_name = 'CreationDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE DatabaseFiles ADD CONSTRAINT df_DatabaseFiles_CreationDate DEFAULT (getdate()) FOR CreationDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'DatabaseFiles' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE DatabaseFiles ADD CONSTRAINT df_DatabaseFiles_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'LibraryItems' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE LibraryItems ADD CONSTRAINT df_LibraryItems_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'RuntimeErrors' and column_name = 'EntryDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE RuntimeErrors ADD CONSTRAINT df_RuntimeErrors_EntryDate DEFAULT (getdate()) FOR EntryDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'RuntimeErrors' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE RuntimeErrors ADD CONSTRAINT df_RuntimeErrors_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'RepeatData' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE RepeatData ADD CONSTRAINT df_RepeatData_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'DataSourceOwner' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE DataSourceOwner ADD CONSTRAINT df_DataSourceOwner_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'LibraryUsers' and column_name = 'ReadOnly' and Table_schema = 'dbo' and column_default= '((0))')
    ALTER TABLE LibraryUsers ADD CONSTRAINT df_LibraryUsers_ReadOnly DEFAULT ((0)) FOR ReadOnly; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'LibraryUsers' and column_name = 'CreateAccess' and Table_schema = 'dbo' and column_default= '((0))')
    ALTER TABLE LibraryUsers ADD CONSTRAINT df_LibraryUsers_CreateAccess DEFAULT ((0)) FOR CreateAccess; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'LibraryUsers' and column_name = 'UpdateAccess' and Table_schema = 'dbo' and column_default= '((1))')
    ALTER TABLE LibraryUsers ADD CONSTRAINT df_LibraryUsers_UpdateAccess DEFAULT ((1)) FOR UpdateAccess; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'LibraryUsers' and column_name = 'DeleteAccess' and Table_schema = 'dbo' and column_default= '((0))')
    ALTER TABLE LibraryUsers ADD CONSTRAINT df_LibraryUsers_DeleteAccess DEFAULT ((0)) FOR DeleteAccess; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'LibraryUsers' and column_name = 'RepoSvrName' and Table_schema = 'dbo' and column_default= '(@@servername)')
    ALTER TABLE LibraryUsers ADD CONSTRAINT df_LibraryUsers_RepoSvrName DEFAULT (@@servername) FOR RepoSvrName; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'LibraryUsers' and column_name = 'RepoName' and Table_schema = 'dbo' and column_default= '(db_name())')
    ALTER TABLE LibraryUsers ADD CONSTRAINT df_LibraryUsers_RepoName DEFAULT (db_name()) FOR RepoName; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'LibraryUsers' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE LibraryUsers ADD CONSTRAINT df_LibraryUsers_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'SearchHistory' and column_name = 'SearchDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE SearchHistory ADD CONSTRAINT df_SearchHistory_SearchDate DEFAULT (getdate()) FOR SearchDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'SearchHistory' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE SearchHistory ADD CONSTRAINT df_SearchHistory_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'DirArchLib' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE DirArchLib ADD CONSTRAINT df_DirArchLib_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'Corporation' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE Corporation ADD CONSTRAINT df_Corporation_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'DirectoryGuids' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE DirectoryGuids ADD CONSTRAINT df_DirectoryGuids_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'SearhParmsHistory' and column_name = 'SearchDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE SearhParmsHistory ADD CONSTRAINT df_SearhParmsHistory_SearchDate DEFAULT (getdate()) FOR SearchDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'SearhParmsHistory' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE SearhParmsHistory ADD CONSTRAINT df_SearhParmsHistory_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'DirectoryListener' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE DirectoryListener ADD CONSTRAINT df_DirectoryListener_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'DirectoryListenerFiles' and column_name = 'EntryDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE DirectoryListenerFiles ADD CONSTRAINT df_DirectoryListenerFiles_EntryDate DEFAULT (getdate()) FOR EntryDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'DirectoryListenerFiles' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE DirectoryListenerFiles ADD CONSTRAINT df_DirectoryListenerFiles_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'IncludedFiles' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE IncludedFiles ADD CONSTRAINT df_IncludedFiles_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'WebSource' and column_name = 'CreateDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE WebSource ADD CONSTRAINT df_WebSource_CreateDate DEFAULT (getdate()) FOR CreateDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'WebSource' and column_name = 'RetentionExpirationDate' and Table_schema = 'dbo' and column_default= '(getdate()+(3650))')
    ALTER TABLE WebSource ADD CONSTRAINT df_WebSource_RetentionExpirationDate DEFAULT (getdate()+(3650)) FOR RetentionExpirationDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'WebSource' and column_name = 'CreationDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE WebSource ADD CONSTRAINT df_WebSource_CreationDate DEFAULT (getdate()) FOR CreationDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'WebSource' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE WebSource ADD CONSTRAINT df_WebSource_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'RestorationHistory' and column_name = 'RestorationDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE RestorationHistory ADD CONSTRAINT df_RestorationHistory_RestorationDate DEFAULT (getdate()) FOR RestorationDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'RestorationHistory' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE RestorationHistory ADD CONSTRAINT df_RestorationHistory_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'DirectoryMonitorLog' and column_name = 'CreateDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE DirectoryMonitorLog ADD CONSTRAINT df_DirectoryMonitorLog_CreateDate DEFAULT (getdate()) FOR CreateDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'DirectoryMonitorLog' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE DirectoryMonitorLog ADD CONSTRAINT df_DirectoryMonitorLog_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'DirectoryTemp' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE DirectoryTemp ADD CONSTRAINT df_DirectoryTemp_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'Databases' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE Databases ADD CONSTRAINT df_Databases_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'ZippedFiles' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE ZippedFiles ADD CONSTRAINT df_ZippedFiles_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'EmailRunningTotal' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE EmailRunningTotal ADD CONSTRAINT df_EmailRunningTotal_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'RetentionTemp' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE RetentionTemp ADD CONSTRAINT df_RetentionTemp_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'ErrorLogs' and column_name = 'EntryDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE ErrorLogs ADD CONSTRAINT df_ErrorLogs_EntryDate DEFAULT (getdate()) FOR EntryDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'ErrorLogs' and column_name = 'Severity' and Table_schema = 'dbo' and column_default= '(N''ERROR'')')
    ALTER TABLE ErrorLogs ADD CONSTRAINT df_ErrorLogs_Severity DEFAULT (N'ERROR') FOR Severity; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'ErrorLogs' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE ErrorLogs ADD CONSTRAINT df_ErrorLogs_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'GlobalSeachResults' and column_name = 'Weight' and Table_schema = 'dbo' and column_default= '((0))')
    ALTER TABLE GlobalSeachResults ADD CONSTRAINT df_GlobalSeachResults_Weight DEFAULT ((0)) FOR Weight; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'GlobalSeachResults' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE GlobalSeachResults ADD CONSTRAINT df_GlobalSeachResults_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'ExcgKey' and column_name = 'InsertDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE ExcgKey ADD CONSTRAINT df_ExcgKey_InsertDate DEFAULT (getdate()) FOR InsertDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'ExcgKey' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE ExcgKey ADD CONSTRAINT df_ExcgKey_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'InformationProduct' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE InformationProduct ADD CONSTRAINT df_InformationProduct_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'DataOwners' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE DataOwners ADD CONSTRAINT df_DataOwners_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'ExchangeHostSmtp' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE ExchangeHostSmtp ADD CONSTRAINT df_ExchangeHostSmtp_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'HelpText' and column_name = 'DisplayHelpText' and Table_schema = 'dbo' and column_default= '((1))')
    ALTER TABLE HelpText ADD CONSTRAINT df_HelpText_DisplayHelpText DEFAULT ((1)) FOR DisplayHelpText; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'HelpText' and column_name = 'LastUpdate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE HelpText ADD CONSTRAINT df_HelpText_LastUpdate DEFAULT (getdate()) FOR LastUpdate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'HelpText' and column_name = 'CreateDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE HelpText ADD CONSTRAINT df_HelpText_CreateDate DEFAULT (getdate()) FOR CreateDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'HelpText' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE HelpText ADD CONSTRAINT df_HelpText_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'FileKey' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE FileKey ADD CONSTRAINT df_FileKey_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'FileKeyMachine' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE FileKeyMachine ADD CONSTRAINT df_FileKeyMachine_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'ActiveSearchGuids' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE ActiveSearchGuids ADD CONSTRAINT df_ActiveSearchGuids_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'HelpTextUser' and column_name = 'DisplayHelpText' and Table_schema = 'dbo' and column_default= '((1))')
    ALTER TABLE HelpTextUser ADD CONSTRAINT df_HelpTextUser_DisplayHelpText DEFAULT ((1)) FOR DisplayHelpText; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'HelpTextUser' and column_name = 'LastUpdate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE HelpTextUser ADD CONSTRAINT df_HelpTextUser_LastUpdate DEFAULT (getdate()) FOR LastUpdate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'HelpTextUser' and column_name = 'CreateDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE HelpTextUser ADD CONSTRAINT df_HelpTextUser_CreateDate DEFAULT (getdate()) FOR CreateDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'HelpTextUser' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE HelpTextUser ADD CONSTRAINT df_HelpTextUser_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'RiskLevel' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE RiskLevel ADD CONSTRAINT df_RiskLevel_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'FileKeyMachineDir' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE FileKeyMachineDir ADD CONSTRAINT df_FileKeyMachineDir_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'FileType' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE FileType ADD CONSTRAINT df_FileType_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'InformationType' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE InformationType ADD CONSTRAINT df_InformationType_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'PgmTrace' and column_name = 'CreateDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE PgmTrace ADD CONSTRAINT df_PgmTrace_CreateDate DEFAULT (getdate()) FOR CreateDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'PgmTrace' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE PgmTrace ADD CONSTRAINT df_PgmTrace_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'DataSourceCheckOut' and column_name = 'checkOutDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE DataSourceCheckOut ADD CONSTRAINT df_DataSourceCheckOut_checkOutDate DEFAULT (getdate()) FOR checkOutDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'DataSourceCheckOut' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE DataSourceCheckOut ADD CONSTRAINT df_DataSourceCheckOut_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'GlobalAsso' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE GlobalAsso ADD CONSTRAINT df_GlobalAsso_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'GlobalDirectory' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE GlobalDirectory ADD CONSTRAINT df_GlobalDirectory_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'QuickRefItems' and column_name = 'MarkedForDeletion' and Table_schema = 'dbo' and column_default= '((0))')
    ALTER TABLE QuickRefItems ADD CONSTRAINT df_QuickRefItems_MarkedForDeletion DEFAULT ((0)) FOR MarkedForDeletion; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'QuickRefItems' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE QuickRefItems ADD CONSTRAINT df_QuickRefItems_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'GlobalEmail' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE GlobalEmail ADD CONSTRAINT df_GlobalEmail_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'ArchiveFrom' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE ArchiveFrom ADD CONSTRAINT df_ArchiveFrom_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'RunParms' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE RunParms ADD CONSTRAINT df_RunParms_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'GlobalFile' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE GlobalFile ADD CONSTRAINT df_GlobalFile_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'GlobalLocation' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE GlobalLocation ADD CONSTRAINT df_GlobalLocation_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'ConnectionStringsSaved' and column_name = 'LastArchiveDate' and Table_schema = 'dbo' and column_default= '(''01/01/1920'')')
    ALTER TABLE ConnectionStringsSaved ADD CONSTRAINT df_ConnectionStringsSaved_LastArchiveDate DEFAULT ('01/01/1920') FOR LastArchiveDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'ConnectionStringsSaved' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE ConnectionStringsSaved ADD CONSTRAINT df_ConnectionStringsSaved_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'GlobalMachine' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE GlobalMachine ADD CONSTRAINT df_GlobalMachine_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'DataSource' and column_name = 'CreateDate' and Table_schema = 'dbo' and column_default= '(''getdate()'')')
    ALTER TABLE DataSource ADD CONSTRAINT df_DataSource_CreateDate DEFAULT ('getdate()') FOR CreateDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'DataSourceRestoreHistory' and column_name = 'RestoreDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE DataSourceRestoreHistory ADD CONSTRAINT df_DataSourceRestoreHistory_RestoreDate DEFAULT (getdate()) FOR RestoreDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'DataSourceRestoreHistory' and column_name = 'CreateDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE DataSourceRestoreHistory ADD CONSTRAINT df_DataSourceRestoreHistory_CreateDate DEFAULT (getdate()) FOR CreateDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'DataSourceRestoreHistory' and column_name = 'VerifiedData' and Table_schema = 'dbo' and column_default= '(''N'')')
    ALTER TABLE DataSourceRestoreHistory ADD CONSTRAINT df_DataSourceRestoreHistory_VerifiedData DEFAULT ('N') FOR VerifiedData; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'DataSourceRestoreHistory' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE DataSourceRestoreHistory ADD CONSTRAINT df_DataSourceRestoreHistory_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'JargonWords' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE JargonWords ADD CONSTRAINT df_JargonWords_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'DB_Updates' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE DB_Updates ADD CONSTRAINT df_DB_Updates_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'DirectoryLongName' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE DirectoryLongName ADD CONSTRAINT df_DirectoryLongName_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'HelpInfo' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE HelpInfo ADD CONSTRAINT df_HelpInfo_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'DirProfiles' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE DirProfiles ADD CONSTRAINT df_DirProfiles_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'DataTypeCodes' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE DataTypeCodes ADD CONSTRAINT df_DataTypeCodes_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'HiveServers' and column_name = 'LinkedDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE HiveServers ADD CONSTRAINT df_HiveServers_LinkedDate DEFAULT (getdate()) FOR LinkedDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'HiveServers' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE HiveServers ADD CONSTRAINT df_HiveServers_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'ArchiveHist' and column_name = 'ArchiveDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE ArchiveHist ADD CONSTRAINT df_ArchiveHist_ArchiveDate DEFAULT (getdate()) FOR ArchiveDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'ArchiveHist' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE ArchiveHist ADD CONSTRAINT df_ArchiveHist_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'DuplicateContent' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE DuplicateContent ADD CONSTRAINT df_DuplicateContent_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'Inventory' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE Inventory ADD CONSTRAINT df_Inventory_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'SavedItems' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE SavedItems ADD CONSTRAINT df_SavedItems_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'IP' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE IP ADD CONSTRAINT df_IP_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'Email' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE Email ADD CONSTRAINT df_Email_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'KTBL' and column_name = 'KGUID' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE KTBL ADD CONSTRAINT df_KTBL_KGUID DEFAULT (newid()) FOR KGUID; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'KTBL' and column_name = 'KIV' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE KTBL ADD CONSTRAINT df_KTBL_KIV DEFAULT (newid()) FOR KIV; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'KTBL' and column_name = 'CreateDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE KTBL ADD CONSTRAINT df_KTBL_CreateDate DEFAULT (getdate()) FOR CreateDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'KTBL' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE KTBL ADD CONSTRAINT df_KTBL_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'LibDirectory' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE LibDirectory ADD CONSTRAINT df_LibDirectory_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'DB_UpdateHist' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE DB_UpdateHist ADD CONSTRAINT df_DB_UpdateHist_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'EmailAttachment' and column_name = 'CreateDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE EmailAttachment ADD CONSTRAINT df_EmailAttachment_CreateDate DEFAULT (getdate()) FOR CreateDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'LoginClient' and column_name = 'LoginDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE LoginClient ADD CONSTRAINT df_LoginClient_LoginDate DEFAULT (getdate()) FOR LoginDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'LoginClient' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE LoginClient ADD CONSTRAINT df_LoginClient_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'DeleteFrom' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE DeleteFrom ADD CONSTRAINT df_DeleteFrom_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'LoginMachine' and column_name = 'LoginDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE LoginMachine ADD CONSTRAINT df_LoginMachine_LoginDate DEFAULT (getdate()) FOR LoginDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'LoginMachine' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE LoginMachine ADD CONSTRAINT df_LoginMachine_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'ArchiveHistContentType' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE ArchiveHistContentType ADD CONSTRAINT df_ArchiveHistContentType_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'HashDir' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE HashDir ADD CONSTRAINT df_HashDir_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'LoginUser' and column_name = 'LoginDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE LoginUser ADD CONSTRAINT df_LoginUser_LoginDate DEFAULT (getdate()) FOR LoginDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'LoginUser' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE LoginUser ADD CONSTRAINT df_LoginUser_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'HashFile' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE HashFile ADD CONSTRAINT df_HashFile_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'MachineRegistered' and column_name = 'MachineGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE MachineRegistered ADD CONSTRAINT df_MachineRegistered_MachineGuid DEFAULT (newid()) FOR MachineGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'MachineRegistered' and column_name = 'NetWorkName' and Table_schema = 'dbo' and column_default= '(''NA'')')
    ALTER TABLE MachineRegistered ADD CONSTRAINT df_MachineRegistered_NetWorkName DEFAULT ('NA') FOR NetWorkName; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'MachineRegistered' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE MachineRegistered ADD CONSTRAINT df_MachineRegistered_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'Logs' and column_name = 'EntryDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE Logs ADD CONSTRAINT df_Logs_EntryDate DEFAULT (getdate()) FOR EntryDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'Logs' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE Logs ADD CONSTRAINT df_Logs_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'LibEmail' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE LibEmail ADD CONSTRAINT df_LibEmail_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'SkipWords' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE SkipWords ADD CONSTRAINT df_SkipWords_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'SearchSchedule' and column_name = 'NumberOfExecutions' and Table_schema = 'dbo' and column_default= '((0))')
    ALTER TABLE SearchSchedule ADD CONSTRAINT df_SearchSchedule_NumberOfExecutions DEFAULT ((0)) FOR NumberOfExecutions; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'SearchSchedule' and column_name = 'CreateDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE SearchSchedule ADD CONSTRAINT df_SearchSchedule_CreateDate DEFAULT (getdate()) FOR CreateDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'SearchSchedule' and column_name = 'LastModDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE SearchSchedule ADD CONSTRAINT df_SearchSchedule_LastModDate DEFAULT (getdate()) FOR LastModDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'SearchSchedule' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE SearchSchedule ADD CONSTRAINT df_SearchSchedule_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'reports' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE reports ADD CONSTRAINT df_reports_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'SearchUser' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE SearchUser ADD CONSTRAINT df_SearchUser_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'SearchUser' and column_name = 'CreateDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE SearchUser ADD CONSTRAINT df_SearchUser_CreateDate DEFAULT (getdate()) FOR CreateDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'SearchUser' and column_name = 'LastUsedDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE SearchUser ADD CONSTRAINT df_SearchUser_LastUsedDate DEFAULT (getdate()) FOR LastUsedDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'ArchiveStats' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE ArchiveStats ADD CONSTRAINT df_ArchiveStats_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'ServiceActivity' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE ServiceActivity ADD CONSTRAINT df_ServiceActivity_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'Directory' and column_name = 'ckMetaData' and Table_schema = 'dbo' and column_default= '(''N'')')
    ALTER TABLE Directory ADD CONSTRAINT df_Directory_ckMetaData DEFAULT ('N') FOR ckMetaData; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'Directory' and column_name = 'ckDisableDir' and Table_schema = 'dbo' and column_default= '(''N'')')
    ALTER TABLE Directory ADD CONSTRAINT df_Directory_ckDisableDir DEFAULT ('N') FOR ckDisableDir; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'Directory' and column_name = 'QuickRefEntry' and Table_schema = 'dbo' and column_default= '((0))')
    ALTER TABLE Directory ADD CONSTRAINT df_Directory_QuickRefEntry DEFAULT ((0)) FOR QuickRefEntry; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'Directory' and column_name = 'isSysDefault' and Table_schema = 'dbo' and column_default= '((0))')
    ALTER TABLE Directory ADD CONSTRAINT df_Directory_isSysDefault DEFAULT ((0)) FOR isSysDefault; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'Directory' and column_name = 'DirGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE Directory ADD CONSTRAINT df_Directory_DirGuid DEFAULT (newid()) FOR DirGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'Directory' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE Directory ADD CONSTRAINT df_Directory_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'Directory' and column_name = 'DeleteOnArchive' and Table_schema = 'dbo' and column_default= '(''N'')')
    ALTER TABLE Directory ADD CONSTRAINT df_Directory_DeleteOnArchive DEFAULT ('N') FOR DeleteOnArchive; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'Repository' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE Repository ADD CONSTRAINT df_Repository_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'SqlDataTypes' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE SqlDataTypes ADD CONSTRAINT df_SqlDataTypes_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'RestoreQueue' and column_name = 'EntryDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE RestoreQueue ADD CONSTRAINT df_RestoreQueue_EntryDate DEFAULT (getdate()) FOR EntryDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'RestoreQueue' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE RestoreQueue ADD CONSTRAINT df_RestoreQueue_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'StagedSQL' and column_name = 'EntryTime' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE StagedSQL ADD CONSTRAINT df_StagedSQL_EntryTime DEFAULT (getdate()) FOR EntryTime; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'StagedSQL' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE StagedSQL ADD CONSTRAINT df_StagedSQL_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'RestoreQueueHistory' and column_name = 'EntryDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE RestoreQueueHistory ADD CONSTRAINT df_RestoreQueueHistory_EntryDate DEFAULT (getdate()) FOR EntryDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'RestoreQueueHistory' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE RestoreQueueHistory ADD CONSTRAINT df_RestoreQueueHistory_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'SystemMessage' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE SystemMessage ADD CONSTRAINT df_SystemMessage_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'SourceAttribute' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE SourceAttribute ADD CONSTRAINT df_SourceAttribute_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'AssignableUserParameters' and column_name = 'isPerm' and Table_schema = 'dbo' and column_default= '((0))')
    ALTER TABLE AssignableUserParameters ADD CONSTRAINT df_AssignableUserParameters_isPerm DEFAULT ((0)) FOR isPerm; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'AssignableUserParameters' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE AssignableUserParameters ADD CONSTRAINT df_AssignableUserParameters_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'Trace' and column_name = 'EntryDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE Trace ADD CONSTRAINT df_Trace_EntryDate DEFAULT (getdate()) FOR EntryDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'Trace' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE Trace ADD CONSTRAINT df_Trace_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'RssPull' and column_name = 'CreateDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE RssPull ADD CONSTRAINT df_RssPull_CreateDate DEFAULT (getdate()) FOR CreateDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'RssPull' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE RssPull ADD CONSTRAINT df_RssPull_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'RssPull' and column_name = 'isPublic' and Table_schema = 'dbo' and column_default= '(''Y'')')
    ALTER TABLE RssPull ADD CONSTRAINT df_RssPull_isPublic DEFAULT ('Y') FOR isPublic; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'EcmUser' and column_name = 'Authority' and Table_schema = 'dbo' and column_default= '(''U'')')
    ALTER TABLE EcmUser ADD CONSTRAINT df_EcmUser_Authority DEFAULT ('U') FOR Authority; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'EcmUser' and column_name = 'CreateDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE EcmUser ADD CONSTRAINT df_EcmUser_CreateDate DEFAULT (getdate()) FOR CreateDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'EcmUser' and column_name = 'LastUpdate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE EcmUser ADD CONSTRAINT df_EcmUser_LastUpdate DEFAULT (getdate()) FOR LastUpdate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'EcmUser' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE EcmUser ADD CONSTRAINT df_EcmUser_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'License' and column_name = 'ActivationDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE License ADD CONSTRAINT df_License_ActivationDate DEFAULT (getdate()) FOR ActivationDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'License' and column_name = 'InstallDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE License ADD CONSTRAINT df_License_InstallDate DEFAULT (getdate()) FOR InstallDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'License' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE License ADD CONSTRAINT df_License_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'SessionID' and column_name = 'CreateDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE SessionID ADD CONSTRAINT df_SessionID_CreateDate DEFAULT (getdate()) FOR CreateDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'AttachmentType' and column_name = 'isZipFormat' and Table_schema = 'dbo' and column_default= '((0))')
    ALTER TABLE AttachmentType ADD CONSTRAINT df_AttachmentType_isZipFormat DEFAULT ((0)) FOR isZipFormat; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'AttachmentType' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE AttachmentType ADD CONSTRAINT df_AttachmentType_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'SourceContainer' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE SourceContainer ADD CONSTRAINT df_SourceContainer_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'SessionVar' and column_name = 'CreateDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE SessionVar ADD CONSTRAINT df_SessionVar_CreateDate DEFAULT (getdate()) FOR CreateDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'SessionVar' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE SessionVar ADD CONSTRAINT df_SessionVar_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'SourceInjector' and column_name = 'LastExecDate' and Table_schema = 'dbo' and column_default= '(''01-01-1960'')')
    ALTER TABLE SourceInjector ADD CONSTRAINT df_SourceInjector_LastExecDate DEFAULT ('01-01-1960') FOR LastExecDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'SourceInjector' and column_name = 'NbrExecutions' and Table_schema = 'dbo' and column_default= '((0))')
    ALTER TABLE SourceInjector ADD CONSTRAINT df_SourceInjector_NbrExecutions DEFAULT ((0)) FOR NbrExecutions; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'SourceInjector' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE SourceInjector ADD CONSTRAINT df_SourceInjector_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'LoadProfile' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE LoadProfile ADD CONSTRAINT df_LoadProfile_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'EmailArchParms' and column_name = 'ArchiveOnlyIfRead' and Table_schema = 'dbo' and column_default= '(''N'')')
    ALTER TABLE EmailArchParms ADD CONSTRAINT df_EmailArchParms_ArchiveOnlyIfRead DEFAULT ('N') FOR ArchiveOnlyIfRead; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'EmailArchParms' and column_name = 'RowCreationDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE EmailArchParms ADD CONSTRAINT df_EmailArchParms_RowCreationDate DEFAULT (getdate()) FOR RowCreationDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'EmailArchParms' and column_name = 'RowLastModDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE EmailArchParms ADD CONSTRAINT df_EmailArchParms_RowLastModDate DEFAULT (getdate()) FOR RowLastModDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'EmailArchParms' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE EmailArchParms ADD CONSTRAINT df_EmailArchParms_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'StatsClick' and column_name = 'ClickDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE StatsClick ADD CONSTRAINT df_StatsClick_ClickDate DEFAULT (getdate()) FOR ClickDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'StatsClick' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE StatsClick ADD CONSTRAINT df_StatsClick_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'EmailAttachmentSearchList' and column_name = 'RowCreationDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE EmailAttachmentSearchList ADD CONSTRAINT df_EmailAttachmentSearchList_RowCreationDate DEFAULT (getdate()) FOR RowCreationDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'EmailAttachmentSearchList' and column_name = 'RowLastModDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE EmailAttachmentSearchList ADD CONSTRAINT df_EmailAttachmentSearchList_RowLastModDate DEFAULT (getdate()) FOR RowLastModDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'EmailAttachmentSearchList' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE EmailAttachmentSearchList ADD CONSTRAINT df_EmailAttachmentSearchList_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'StatSearch' and column_name = 'SearchDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE StatSearch ADD CONSTRAINT df_StatSearch_SearchDate DEFAULT (getdate()) FOR SearchDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'StatSearch' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE StatSearch ADD CONSTRAINT df_StatSearch_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'AttributeDatatype' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE AttributeDatatype ADD CONSTRAINT df_AttributeDatatype_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'SourceType' and column_name = 'StoreExternal' and Table_schema = 'dbo' and column_default= '((0))')
    ALTER TABLE SourceType ADD CONSTRAINT df_SourceType_StoreExternal DEFAULT ((0)) FOR StoreExternal; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'SourceType' and column_name = 'Indexable' and Table_schema = 'dbo' and column_default= '((1))')
    ALTER TABLE SourceType ADD CONSTRAINT df_SourceType_Indexable DEFAULT ((1)) FOR Indexable; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'SourceType' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE SourceType ADD CONSTRAINT df_SourceType_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'StatWord' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE StatWord ADD CONSTRAINT df_StatWord_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'LoadProfileItem' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE LoadProfileItem ADD CONSTRAINT df_LoadProfileItem_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'StructuredData' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE StructuredData ADD CONSTRAINT df_StructuredData_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'EmailFolder' and column_name = 'isSysDefault' and Table_schema = 'dbo' and column_default= '((0))')
    ALTER TABLE EmailFolder ADD CONSTRAINT df_EmailFolder_isSysDefault DEFAULT ((0)) FOR isSysDefault; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'EmailFolder' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE EmailFolder ADD CONSTRAINT df_EmailFolder_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'StructuredDataProcessed' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE StructuredDataProcessed ADD CONSTRAINT df_StructuredDataProcessed_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'TempUserLibItems' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE TempUserLibItems ADD CONSTRAINT df_TempUserLibItems_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'Attributes' and column_name = 'AttributeDataType' and Table_schema = 'dbo' and column_default= '(''nvarchar'')')
    ALTER TABLE Attributes ADD CONSTRAINT df_Attributes_AttributeDataType DEFAULT ('nvarchar') FOR AttributeDataType; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'Attributes' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE Attributes ADD CONSTRAINT df_Attributes_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'Storage' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE Storage ADD CONSTRAINT df_Storage_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'TestTbl' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE TestTbl ADD CONSTRAINT df_TestTbl_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'txTimes' and column_name = 'CreateDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE txTimes ADD CONSTRAINT df_txTimes_CreateDate DEFAULT (getdate()) FOR CreateDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'txTimes' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE txTimes ADD CONSTRAINT df_txTimes_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'UserGridState' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE UserGridState ADD CONSTRAINT df_UserGridState_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'Machine' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE Machine ADD CONSTRAINT df_Machine_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'EmailToDelete' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE EmailToDelete ADD CONSTRAINT df_EmailToDelete_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'UserScreenState' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE UserScreenState ADD CONSTRAINT df_UserScreenState_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'UserSearchState' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE UserSearchState ADD CONSTRAINT df_UserSearchState_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'AvailFileTypes' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE AvailFileTypes ADD CONSTRAINT df_AvailFileTypes_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'UserGroup' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE UserGroup ADD CONSTRAINT df_UserGroup_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'VersionInfo' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE VersionInfo ADD CONSTRAINT df_VersionInfo_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'WebScreen' and column_name = 'CreateDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE WebScreen ADD CONSTRAINT df_WebScreen_CreateDate DEFAULT (getdate()) FOR CreateDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'WebScreen' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE WebScreen ADD CONSTRAINT df_WebScreen_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'WebScreen' and column_name = 'isPublic' and Table_schema = 'dbo' and column_default= '(''Y'')')
    ALTER TABLE WebScreen ADD CONSTRAINT df_WebScreen_isPublic DEFAULT ('Y') FOR isPublic; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'WebSite' and column_name = 'CreateDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE WebSite ADD CONSTRAINT df_WebSite_CreateDate DEFAULT (getdate()) FOR CreateDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'WebSite' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE WebSite ADD CONSTRAINT df_WebSite_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'WebSite' and column_name = 'Depth' and Table_schema = 'dbo' and column_default= '((0))')
    ALTER TABLE WebSite ADD CONSTRAINT df_WebSite_Depth DEFAULT ((0)) FOR Depth; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'WebSite' and column_name = 'Width' and Table_schema = 'dbo' and column_default= '((0))')
    ALTER TABLE WebSite ADD CONSTRAINT df_WebSite_Width DEFAULT ((0)) FOR Width; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'WebSite' and column_name = 'isPublic' and Table_schema = 'dbo' and column_default= '(''Y'')')
    ALTER TABLE WebSite ADD CONSTRAINT df_WebSite_isPublic DEFAULT ('Y') FOR isPublic; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'MyTempTable' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE MyTempTable ADD CONSTRAINT df_MyTempTable_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'UserReassignHist' and column_name = 'ReassignmentDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE UserReassignHist ADD CONSTRAINT df_UserReassignHist_ReassignmentDate DEFAULT (getdate()) FOR ReassignmentDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'UserReassignHist' and column_name = 'RowID' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE UserReassignHist ADD CONSTRAINT df_UserReassignHist_RowID DEFAULT (newid()) FOR RowID; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'UserReassignHist' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE UserReassignHist ADD CONSTRAINT df_UserReassignHist_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'SubDir' and column_name = 'ckDisableDir' and Table_schema = 'dbo' and column_default= '(''N'')')
    ALTER TABLE SubDir ADD CONSTRAINT df_SubDir_ckDisableDir DEFAULT ('N') FOR ckDisableDir; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'SubDir' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE SubDir ADD CONSTRAINT df_SubDir_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'AvailFileTypesUndefined' and column_name = 'Applied' and Table_schema = 'dbo' and column_default= '((0))')
    ALTER TABLE AvailFileTypesUndefined ADD CONSTRAINT df_AvailFileTypesUndefined_Applied DEFAULT ((0)) FOR Applied; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'AvailFileTypesUndefined' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE AvailFileTypesUndefined ADD CONSTRAINT df_AvailFileTypesUndefined_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'OutlookFrom' and column_name = 'Verified' and Table_schema = 'dbo' and column_default= '((1))')
    ALTER TABLE OutlookFrom ADD CONSTRAINT df_OutlookFrom_Verified DEFAULT ((1)) FOR Verified; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'OutlookFrom' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE OutlookFrom ADD CONSTRAINT df_OutlookFrom_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'ExcludedFiles' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE ExcludedFiles ADD CONSTRAINT df_ExcludedFiles_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'BusinessFunctionJargon' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE BusinessFunctionJargon ADD CONSTRAINT df_BusinessFunctionJargon_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'Users' and column_name = 'Admin' and Table_schema = 'dbo' and column_default= '(''U'')')
    ALTER TABLE Users ADD CONSTRAINT df_Users_Admin DEFAULT ('U') FOR Admin; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'Users' and column_name = 'isActive' and Table_schema = 'dbo' and column_default= '(''Y'')')
    ALTER TABLE Users ADD CONSTRAINT df_Users_isActive DEFAULT ('Y') FOR isActive; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'Users' and column_name = 'ActiveGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE Users ADD CONSTRAINT df_Users_ActiveGuid DEFAULT (newid()) FOR ActiveGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'Users' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE Users ADD CONSTRAINT df_Users_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'SubLibrary' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE SubLibrary ADD CONSTRAINT df_SubLibrary_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'BusinessJargonCode' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE BusinessJargonCode ADD CONSTRAINT df_BusinessJargonCode_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'ExcludeFrom' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE ExcludeFrom ADD CONSTRAINT df_ExcludeFrom_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'OwnerHistory' and column_name = 'CreateDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE OwnerHistory ADD CONSTRAINT df_OwnerHistory_CreateDate DEFAULT (getdate()) FOR CreateDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'OwnerHistory' and column_name = 'RowCreationDate' and Table_schema = 'dbo' and column_default= '(getdate())')
    ALTER TABLE OwnerHistory ADD CONSTRAINT df_OwnerHistory_RowCreationDate DEFAULT (getdate()) FOR RowCreationDate; 
GO
if not exists(select 1 from information_schema.columns where table_name = 'OwnerHistory' and column_name = 'RowGuid' and Table_schema = 'dbo' and column_default= '(newid())')
    ALTER TABLE OwnerHistory ADD CONSTRAINT df_OwnerHistory_RowGuid DEFAULT (newid()) FOR RowGuid; 
GO

