If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'AdUserName' and table_name = 'ActiveDirUser')
BEGIN
    print 'Altered: ActiveDirUser ,AdUserName';
    alter table [ActiveDirUser] add [AdUserName]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'ActiveDirUser')
BEGIN
    print 'Altered: ActiveDirUser ,HiveActive';
    alter table [ActiveDirUser] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'ActiveDirUser')
BEGIN
    print 'Altered: ActiveDirUser ,HiveConnectionName';
    alter table [ActiveDirUser] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'ActiveDirUser')
BEGIN
    print 'Altered: ActiveDirUser ,RepoName';
    alter table [ActiveDirUser] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'ActiveDirUser')
BEGIN
    print 'Altered: ActiveDirUser ,RepoSvrName';
    alter table [ActiveDirUser] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'ActiveDirUser')
BEGIN
    print 'Altered: ActiveDirUser ,RowCreationDate';
    alter table [ActiveDirUser] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'ActiveDirUser')
BEGIN
    print 'Altered: ActiveDirUser ,RowGuid';
    alter table [ActiveDirUser] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'ActiveDirUser')
BEGIN
    print 'Altered: ActiveDirUser ,RowLastModDate';
    alter table [ActiveDirUser] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'ActiveDirUser')
BEGIN
    print 'Altered: ActiveDirUser ,UserID';
    alter table [ActiveDirUser] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'DocGuid' and table_name = 'ActiveSearchGuids')
BEGIN
    print 'Altered: ActiveSearchGuids ,DocGuid';
    alter table [ActiveSearchGuids] add [DocGuid]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'ActiveSearchGuids')
BEGIN
    print 'Altered: ActiveSearchGuids ,HiveActive';
    alter table [ActiveSearchGuids] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'ActiveSearchGuids')
BEGIN
    print 'Altered: ActiveSearchGuids ,HiveConnectionName';
    alter table [ActiveSearchGuids] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'ActiveSearchGuids')
BEGIN
    print 'Altered: ActiveSearchGuids ,RepoName';
    alter table [ActiveSearchGuids] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'ActiveSearchGuids')
BEGIN
    print 'Altered: ActiveSearchGuids ,RepoSvrName';
    alter table [ActiveSearchGuids] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'ActiveSearchGuids')
BEGIN
    print 'Altered: ActiveSearchGuids ,RowCreationDate';
    alter table [ActiveSearchGuids] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'ActiveSearchGuids')
BEGIN
    print 'Altered: ActiveSearchGuids ,RowGuid';
    alter table [ActiveSearchGuids] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'ActiveSearchGuids')
BEGIN
    print 'Altered: ActiveSearchGuids ,RowLastModDate';
    alter table [ActiveSearchGuids] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SeqNO' and table_name = 'ActiveSearchGuids')
BEGIN
    print 'Altered: ActiveSearchGuids ,SeqNO';
    alter table [ActiveSearchGuids] add [SeqNO]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'ActiveSearchGuids')
BEGIN
    print 'Altered: ActiveSearchGuids ,UserID';
    alter table [ActiveSearchGuids] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'InitDate' and table_name = 'ActiveSession')
BEGIN
    print 'Altered: ActiveSession ,InitDate';
    alter table [ActiveSession] add [InitDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Parm' and table_name = 'ActiveSession')
BEGIN
    print 'Altered: ActiveSession ,Parm';
    alter table [ActiveSession] add [Parm]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ParmVal' and table_name = 'ActiveSession')
BEGIN
    print 'Altered: ActiveSession ,ParmVal';
    alter table [ActiveSession] add [ParmVal]  nvarchar (2000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'ActiveSession')
BEGIN
    print 'Altered: ActiveSession ,RepoName';
    alter table [ActiveSession] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'ActiveSession')
BEGIN
    print 'Altered: ActiveSession ,RowGuid';
    alter table [ActiveSession] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SessionGuid' and table_name = 'ActiveSession')
BEGIN
    print 'Altered: ActiveSession ,SessionGuid';
    alter table [ActiveSession] add [SessionGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Carrier' and table_name = 'AlertContact')
BEGIN
    print 'Altered: AlertContact ,Carrier';
    alter table [AlertContact] add [Carrier]  nvarchar (75)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ContactEmail' and table_name = 'AlertContact')
BEGIN
    print 'Altered: AlertContact ,ContactEmail';
    alter table [AlertContact] add [ContactEmail]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ContactIM' and table_name = 'AlertContact')
BEGIN
    print 'Altered: AlertContact ,ContactIM';
    alter table [AlertContact] add [ContactIM]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ContactName' and table_name = 'AlertContact')
BEGIN
    print 'Altered: AlertContact ,ContactName';
    alter table [AlertContact] add [ContactName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'AlertContact')
BEGIN
    print 'Altered: AlertContact ,RepoName';
    alter table [AlertContact] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'AlertContact')
BEGIN
    print 'Altered: AlertContact ,RowGuid';
    alter table [AlertContact] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'AlertWord' and table_name = 'AlertHistory')
BEGIN
    print 'Altered: AlertHistory ,AlertWord';
    alter table [AlertHistory] add [AlertWord]  nvarchar (100)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ByUserID' and table_name = 'AlertHistory')
BEGIN
    print 'Altered: AlertHistory ,ByUserID';
    alter table [AlertHistory] add [ByUserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CreateDate' and table_name = 'AlertHistory')
BEGIN
    print 'Altered: AlertHistory ,CreateDate';
    alter table [AlertHistory] add [CreateDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'AlertHistory')
BEGIN
    print 'Altered: AlertHistory ,RepoName';
    alter table [AlertHistory] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'AlertHistory')
BEGIN
    print 'Altered: AlertHistory ,RowGuid';
    alter table [AlertHistory] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'AlertWord' and table_name = 'AlertWord')
BEGIN
    print 'Altered: AlertWord ,AlertWord';
    alter table [AlertWord] add [AlertWord]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CreateDate' and table_name = 'AlertWord')
BEGIN
    print 'Altered: AlertWord ,CreateDate';
    alter table [AlertWord] add [CreateDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ExpirationDate' and table_name = 'AlertWord')
BEGIN
    print 'Altered: AlertWord ,ExpirationDate';
    alter table [AlertWord] add [ExpirationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'AlertWord')
BEGIN
    print 'Altered: AlertWord ,RepoName';
    alter table [AlertWord] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'AlertWord')
BEGIN
    print 'Altered: AlertWord ,RowGuid';
    alter table [AlertWord] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FromEmailAddr' and table_name = 'ArchiveFrom')
BEGIN
    print 'Altered: ArchiveFrom ,FromEmailAddr';
    alter table [ArchiveFrom] add [FromEmailAddr]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'ArchiveFrom')
BEGIN
    print 'Altered: ArchiveFrom ,HiveActive';
    alter table [ArchiveFrom] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'ArchiveFrom')
BEGIN
    print 'Altered: ArchiveFrom ,HiveConnectionName';
    alter table [ArchiveFrom] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'ArchiveFrom')
BEGIN
    print 'Altered: ArchiveFrom ,RepoName';
    alter table [ArchiveFrom] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'ArchiveFrom')
BEGIN
    print 'Altered: ArchiveFrom ,RepoSvrName';
    alter table [ArchiveFrom] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'ArchiveFrom')
BEGIN
    print 'Altered: ArchiveFrom ,RowCreationDate';
    alter table [ArchiveFrom] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'ArchiveFrom')
BEGIN
    print 'Altered: ArchiveFrom ,RowGuid';
    alter table [ArchiveFrom] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'ArchiveFrom')
BEGIN
    print 'Altered: ArchiveFrom ,RowLastModDate';
    alter table [ArchiveFrom] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SenderName' and table_name = 'ArchiveFrom')
BEGIN
    print 'Altered: ArchiveFrom ,SenderName';
    alter table [ArchiveFrom] add [SenderName]  varchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'ArchiveFrom')
BEGIN
    print 'Altered: ArchiveFrom ,UserID';
    alter table [ArchiveFrom] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ArchiveDate' and table_name = 'ArchiveHist')
BEGIN
    print 'Altered: ArchiveHist ,ArchiveDate';
    alter table [ArchiveHist] add [ArchiveDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ArchiveID' and table_name = 'ArchiveHist')
BEGIN
    print 'Altered: ArchiveHist ,ArchiveID';
    alter table [ArchiveHist] add [ArchiveID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'ArchiveHist')
BEGIN
    print 'Altered: ArchiveHist ,HiveActive';
    alter table [ArchiveHist] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'ArchiveHist')
BEGIN
    print 'Altered: ArchiveHist ,HiveConnectionName';
    alter table [ArchiveHist] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'NbrFilesArchived' and table_name = 'ArchiveHist')
BEGIN
    print 'Altered: ArchiveHist ,NbrFilesArchived';
    alter table [ArchiveHist] add [NbrFilesArchived]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'ArchiveHist')
BEGIN
    print 'Altered: ArchiveHist ,RepoName';
    alter table [ArchiveHist] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'ArchiveHist')
BEGIN
    print 'Altered: ArchiveHist ,RepoSvrName';
    alter table [ArchiveHist] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'ArchiveHist')
BEGIN
    print 'Altered: ArchiveHist ,RowCreationDate';
    alter table [ArchiveHist] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'ArchiveHist')
BEGIN
    print 'Altered: ArchiveHist ,RowGuid';
    alter table [ArchiveHist] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'ArchiveHist')
BEGIN
    print 'Altered: ArchiveHist ,RowLastModDate';
    alter table [ArchiveHist] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserGuid' and table_name = 'ArchiveHist')
BEGIN
    print 'Altered: ArchiveHist ,UserGuid';
    alter table [ArchiveHist] add [UserGuid]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ArchiveID' and table_name = 'ArchiveHistContentType')
BEGIN
    print 'Altered: ArchiveHistContentType ,ArchiveID';
    alter table [ArchiveHistContentType] add [ArchiveID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Directory' and table_name = 'ArchiveHistContentType')
BEGIN
    print 'Altered: ArchiveHistContentType ,Directory';
    alter table [ArchiveHistContentType] add [Directory]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FileType' and table_name = 'ArchiveHistContentType')
BEGIN
    print 'Altered: ArchiveHistContentType ,FileType';
    alter table [ArchiveHistContentType] add [FileType]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'ArchiveHistContentType')
BEGIN
    print 'Altered: ArchiveHistContentType ,HiveActive';
    alter table [ArchiveHistContentType] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'ArchiveHistContentType')
BEGIN
    print 'Altered: ArchiveHistContentType ,HiveConnectionName';
    alter table [ArchiveHistContentType] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'NbrFilesArchived' and table_name = 'ArchiveHistContentType')
BEGIN
    print 'Altered: ArchiveHistContentType ,NbrFilesArchived';
    alter table [ArchiveHistContentType] add [NbrFilesArchived]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'ArchiveHistContentType')
BEGIN
    print 'Altered: ArchiveHistContentType ,RepoName';
    alter table [ArchiveHistContentType] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'ArchiveHistContentType')
BEGIN
    print 'Altered: ArchiveHistContentType ,RepoSvrName';
    alter table [ArchiveHistContentType] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'ArchiveHistContentType')
BEGIN
    print 'Altered: ArchiveHistContentType ,RowCreationDate';
    alter table [ArchiveHistContentType] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'ArchiveHistContentType')
BEGIN
    print 'Altered: ArchiveHistContentType ,RowGuid';
    alter table [ArchiveHistContentType] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'ArchiveHistContentType')
BEGIN
    print 'Altered: ArchiveHistContentType ,RowLastModDate';
    alter table [ArchiveHistContentType] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ArchiveEndDate' and table_name = 'ArchiveStats')
BEGIN
    print 'Altered: ArchiveStats ,ArchiveEndDate';
    alter table [ArchiveStats] add [ArchiveEndDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ArchiveStartDate' and table_name = 'ArchiveStats')
BEGIN
    print 'Altered: ArchiveStats ,ArchiveStartDate';
    alter table [ArchiveStats] add [ArchiveStartDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ArchiveType' and table_name = 'ArchiveStats')
BEGIN
    print 'Altered: ArchiveStats ,ArchiveType';
    alter table [ArchiveStats] add [ArchiveType]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'EntrySeq' and table_name = 'ArchiveStats')
BEGIN
    print 'Altered: ArchiveStats ,EntrySeq';
    alter table [ArchiveStats] add [EntrySeq]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'ArchiveStats')
BEGIN
    print 'Altered: ArchiveStats ,HiveActive';
    alter table [ArchiveStats] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'ArchiveStats')
BEGIN
    print 'Altered: ArchiveStats ,HiveConnectionName';
    alter table [ArchiveStats] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'ArchiveStats')
BEGIN
    print 'Altered: ArchiveStats ,RepoName';
    alter table [ArchiveStats] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'ArchiveStats')
BEGIN
    print 'Altered: ArchiveStats ,RepoSvrName';
    alter table [ArchiveStats] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'ArchiveStats')
BEGIN
    print 'Altered: ArchiveStats ,RowCreationDate';
    alter table [ArchiveStats] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'ArchiveStats')
BEGIN
    print 'Altered: ArchiveStats ,RowGuid';
    alter table [ArchiveStats] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'ArchiveStats')
BEGIN
    print 'Altered: ArchiveStats ,RowLastModDate';
    alter table [ArchiveStats] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'StatGuid' and table_name = 'ArchiveStats')
BEGIN
    print 'Altered: ArchiveStats ,StatGuid';
    alter table [ArchiveStats] add [StatGuid]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Status' and table_name = 'ArchiveStats')
BEGIN
    print 'Altered: ArchiveStats ,Status';
    alter table [ArchiveStats] add [Status]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Successful' and table_name = 'ArchiveStats')
BEGIN
    print 'Altered: ArchiveStats ,Successful';
    alter table [ArchiveStats] add [Successful]  nchar (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'TotalContentInRepository' and table_name = 'ArchiveStats')
BEGIN
    print 'Altered: ArchiveStats ,TotalContentInRepository';
    alter table [ArchiveStats] add [TotalContentInRepository]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'TotalEmailsInRepository' and table_name = 'ArchiveStats')
BEGIN
    print 'Altered: ArchiveStats ,TotalEmailsInRepository';
    alter table [ArchiveStats] add [TotalEmailsInRepository]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'ArchiveStats')
BEGIN
    print 'Altered: ArchiveStats ,UserID';
    alter table [ArchiveStats] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'AssignableUserParameters')
BEGIN
    print 'Altered: AssignableUserParameters ,HiveActive';
    alter table [AssignableUserParameters] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'AssignableUserParameters')
BEGIN
    print 'Altered: AssignableUserParameters ,HiveConnectionName';
    alter table [AssignableUserParameters] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'isPerm' and table_name = 'AssignableUserParameters')
BEGIN
    print 'Altered: AssignableUserParameters ,isPerm';
    alter table [AssignableUserParameters] add [isPerm]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ParmName' and table_name = 'AssignableUserParameters')
BEGIN
    print 'Altered: AssignableUserParameters ,ParmName';
    alter table [AssignableUserParameters] add [ParmName]  nchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'AssignableUserParameters')
BEGIN
    print 'Altered: AssignableUserParameters ,RepoName';
    alter table [AssignableUserParameters] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'AssignableUserParameters')
BEGIN
    print 'Altered: AssignableUserParameters ,RepoSvrName';
    alter table [AssignableUserParameters] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'AssignableUserParameters')
BEGIN
    print 'Altered: AssignableUserParameters ,RowCreationDate';
    alter table [AssignableUserParameters] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'AssignableUserParameters')
BEGIN
    print 'Altered: AssignableUserParameters ,RowGuid';
    alter table [AssignableUserParameters] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'AssignableUserParameters')
BEGIN
    print 'Altered: AssignableUserParameters ,RowLastModDate';
    alter table [AssignableUserParameters] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'AttachmentCode' and table_name = 'AttachmentType')
BEGIN
    print 'Altered: AttachmentType ,AttachmentCode';
    alter table [AttachmentType] add [AttachmentCode]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Description' and table_name = 'AttachmentType')
BEGIN
    print 'Altered: AttachmentType ,Description';
    alter table [AttachmentType] add [Description]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'AttachmentType')
BEGIN
    print 'Altered: AttachmentType ,HiveActive';
    alter table [AttachmentType] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'AttachmentType')
BEGIN
    print 'Altered: AttachmentType ,HiveConnectionName';
    alter table [AttachmentType] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'isZipFormat' and table_name = 'AttachmentType')
BEGIN
    print 'Altered: AttachmentType ,isZipFormat';
    alter table [AttachmentType] add [isZipFormat]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'AttachmentType')
BEGIN
    print 'Altered: AttachmentType ,RepoName';
    alter table [AttachmentType] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'AttachmentType')
BEGIN
    print 'Altered: AttachmentType ,RepoSvrName';
    alter table [AttachmentType] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'AttachmentType')
BEGIN
    print 'Altered: AttachmentType ,RowCreationDate';
    alter table [AttachmentType] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'AttachmentType')
BEGIN
    print 'Altered: AttachmentType ,RowGuid';
    alter table [AttachmentType] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'AttachmentType')
BEGIN
    print 'Altered: AttachmentType ,RowLastModDate';
    alter table [AttachmentType] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'AttributeDataType' and table_name = 'AttributeDatatype')
BEGIN
    print 'Altered: AttributeDatatype ,AttributeDataType';
    alter table [AttributeDatatype] add [AttributeDataType]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'AttributeDatatype')
BEGIN
    print 'Altered: AttributeDatatype ,HiveActive';
    alter table [AttributeDatatype] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'AttributeDatatype')
BEGIN
    print 'Altered: AttributeDatatype ,HiveConnectionName';
    alter table [AttributeDatatype] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'AttributeDatatype')
BEGIN
    print 'Altered: AttributeDatatype ,RepoName';
    alter table [AttributeDatatype] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'AttributeDatatype')
BEGIN
    print 'Altered: AttributeDatatype ,RepoSvrName';
    alter table [AttributeDatatype] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'AttributeDatatype')
BEGIN
    print 'Altered: AttributeDatatype ,RowCreationDate';
    alter table [AttributeDatatype] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'AttributeDatatype')
BEGIN
    print 'Altered: AttributeDatatype ,RowGuid';
    alter table [AttributeDatatype] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'AttributeDatatype')
BEGIN
    print 'Altered: AttributeDatatype ,RowLastModDate';
    alter table [AttributeDatatype] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'AllowedValues' and table_name = 'Attributes')
BEGIN
    print 'Altered: Attributes ,AllowedValues';
    alter table [Attributes] add [AllowedValues]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'AssoApplication' and table_name = 'Attributes')
BEGIN
    print 'Altered: Attributes ,AssoApplication';
    alter table [Attributes] add [AssoApplication]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'AttributeDataType' and table_name = 'Attributes')
BEGIN
    print 'Altered: Attributes ,AttributeDataType';
    alter table [Attributes] add [AttributeDataType]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'AttributeDesc' and table_name = 'Attributes')
BEGIN
    print 'Altered: Attributes ,AttributeDesc';
    alter table [Attributes] add [AttributeDesc]  nvarchar (2000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'AttributeName' and table_name = 'Attributes')
BEGIN
    print 'Altered: Attributes ,AttributeName';
    alter table [Attributes] add [AttributeName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'Attributes')
BEGIN
    print 'Altered: Attributes ,HiveActive';
    alter table [Attributes] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'Attributes')
BEGIN
    print 'Altered: Attributes ,HiveConnectionName';
    alter table [Attributes] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'Attributes')
BEGIN
    print 'Altered: Attributes ,RepoName';
    alter table [Attributes] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'Attributes')
BEGIN
    print 'Altered: Attributes ,RepoSvrName';
    alter table [Attributes] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'Attributes')
BEGIN
    print 'Altered: Attributes ,RowCreationDate';
    alter table [Attributes] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'Attributes')
BEGIN
    print 'Altered: Attributes ,RowGuid';
    alter table [Attributes] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'Attributes')
BEGIN
    print 'Altered: Attributes ,RowLastModDate';
    alter table [Attributes] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ExtCode' and table_name = 'AvailFileTypes')
BEGIN
    print 'Altered: AvailFileTypes ,ExtCode';
    alter table [AvailFileTypes] add [ExtCode]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'AvailFileTypes')
BEGIN
    print 'Altered: AvailFileTypes ,HiveActive';
    alter table [AvailFileTypes] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'AvailFileTypes')
BEGIN
    print 'Altered: AvailFileTypes ,HiveConnectionName';
    alter table [AvailFileTypes] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'AvailFileTypes')
BEGIN
    print 'Altered: AvailFileTypes ,RepoName';
    alter table [AvailFileTypes] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'AvailFileTypes')
BEGIN
    print 'Altered: AvailFileTypes ,RepoSvrName';
    alter table [AvailFileTypes] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'AvailFileTypes')
BEGIN
    print 'Altered: AvailFileTypes ,RowCreationDate';
    alter table [AvailFileTypes] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'AvailFileTypes')
BEGIN
    print 'Altered: AvailFileTypes ,RowGuid';
    alter table [AvailFileTypes] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'AvailFileTypes')
BEGIN
    print 'Altered: AvailFileTypes ,RowLastModDate';
    alter table [AvailFileTypes] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Applied' and table_name = 'AvailFileTypesUndefined')
BEGIN
    print 'Altered: AvailFileTypesUndefined ,Applied';
    alter table [AvailFileTypesUndefined] add [Applied]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FileType' and table_name = 'AvailFileTypesUndefined')
BEGIN
    print 'Altered: AvailFileTypesUndefined ,FileType';
    alter table [AvailFileTypesUndefined] add [FileType]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'AvailFileTypesUndefined')
BEGIN
    print 'Altered: AvailFileTypesUndefined ,HiveActive';
    alter table [AvailFileTypesUndefined] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'AvailFileTypesUndefined')
BEGIN
    print 'Altered: AvailFileTypesUndefined ,HiveConnectionName';
    alter table [AvailFileTypesUndefined] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'AvailFileTypesUndefined')
BEGIN
    print 'Altered: AvailFileTypesUndefined ,RepoName';
    alter table [AvailFileTypesUndefined] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'AvailFileTypesUndefined')
BEGIN
    print 'Altered: AvailFileTypesUndefined ,RepoSvrName';
    alter table [AvailFileTypesUndefined] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'AvailFileTypesUndefined')
BEGIN
    print 'Altered: AvailFileTypesUndefined ,RowCreationDate';
    alter table [AvailFileTypesUndefined] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'AvailFileTypesUndefined')
BEGIN
    print 'Altered: AvailFileTypesUndefined ,RowGuid';
    alter table [AvailFileTypesUndefined] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'AvailFileTypesUndefined')
BEGIN
    print 'Altered: AvailFileTypesUndefined ,RowLastModDate';
    alter table [AvailFileTypesUndefined] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SubstituteType' and table_name = 'AvailFileTypesUndefined')
BEGIN
    print 'Altered: AvailFileTypesUndefined ,SubstituteType';
    alter table [AvailFileTypesUndefined] add [SubstituteType]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CorpFuncName' and table_name = 'BusinessFunctionJargon')
BEGIN
    print 'Altered: BusinessFunctionJargon ,CorpFuncName';
    alter table [BusinessFunctionJargon] add [CorpFuncName]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CorpName' and table_name = 'BusinessFunctionJargon')
BEGIN
    print 'Altered: BusinessFunctionJargon ,CorpName';
    alter table [BusinessFunctionJargon] add [CorpName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'BusinessFunctionJargon')
BEGIN
    print 'Altered: BusinessFunctionJargon ,HiveActive';
    alter table [BusinessFunctionJargon] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'BusinessFunctionJargon')
BEGIN
    print 'Altered: BusinessFunctionJargon ,HiveConnectionName';
    alter table [BusinessFunctionJargon] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'JargonCode' and table_name = 'BusinessFunctionJargon')
BEGIN
    print 'Altered: BusinessFunctionJargon ,JargonCode';
    alter table [BusinessFunctionJargon] add [JargonCode]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'JargonWords_tgtWord' and table_name = 'BusinessFunctionJargon')
BEGIN
    print 'Altered: BusinessFunctionJargon ,JargonWords_tgtWord';
    alter table [BusinessFunctionJargon] add [JargonWords_tgtWord]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'BusinessFunctionJargon')
BEGIN
    print 'Altered: BusinessFunctionJargon ,RepoName';
    alter table [BusinessFunctionJargon] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'BusinessFunctionJargon')
BEGIN
    print 'Altered: BusinessFunctionJargon ,RepoSvrName';
    alter table [BusinessFunctionJargon] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'BusinessFunctionJargon')
BEGIN
    print 'Altered: BusinessFunctionJargon ,RowCreationDate';
    alter table [BusinessFunctionJargon] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'BusinessFunctionJargon')
BEGIN
    print 'Altered: BusinessFunctionJargon ,RowGuid';
    alter table [BusinessFunctionJargon] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'BusinessFunctionJargon')
BEGIN
    print 'Altered: BusinessFunctionJargon ,RowLastModDate';
    alter table [BusinessFunctionJargon] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'WordID' and table_name = 'BusinessFunctionJargon')
BEGIN
    print 'Altered: BusinessFunctionJargon ,WordID';
    alter table [BusinessFunctionJargon] add [WordID]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'BusinessJargonCode')
BEGIN
    print 'Altered: BusinessJargonCode ,HiveActive';
    alter table [BusinessJargonCode] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'BusinessJargonCode')
BEGIN
    print 'Altered: BusinessJargonCode ,HiveConnectionName';
    alter table [BusinessJargonCode] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'JargonCode' and table_name = 'BusinessJargonCode')
BEGIN
    print 'Altered: BusinessJargonCode ,JargonCode';
    alter table [BusinessJargonCode] add [JargonCode]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'JargonDesc' and table_name = 'BusinessJargonCode')
BEGIN
    print 'Altered: BusinessJargonCode ,JargonDesc';
    alter table [BusinessJargonCode] add [JargonDesc]  nvarchar (18)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'BusinessJargonCode')
BEGIN
    print 'Altered: BusinessJargonCode ,RepoName';
    alter table [BusinessJargonCode] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'BusinessJargonCode')
BEGIN
    print 'Altered: BusinessJargonCode ,RepoSvrName';
    alter table [BusinessJargonCode] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'BusinessJargonCode')
BEGIN
    print 'Altered: BusinessJargonCode ,RowCreationDate';
    alter table [BusinessJargonCode] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'BusinessJargonCode')
BEGIN
    print 'Altered: BusinessJargonCode ,RowGuid';
    alter table [BusinessJargonCode] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'BusinessJargonCode')
BEGIN
    print 'Altered: BusinessJargonCode ,RowLastModDate';
    alter table [BusinessJargonCode] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CaptureItemsCode' and table_name = 'CaptureItems')
BEGIN
    print 'Altered: CaptureItems ,CaptureItemsCode';
    alter table [CaptureItems] add [CaptureItemsCode]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CaptureItemsDesc' and table_name = 'CaptureItems')
BEGIN
    print 'Altered: CaptureItems ,CaptureItemsDesc';
    alter table [CaptureItems] add [CaptureItemsDesc]  nvarchar (18)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CreateDate' and table_name = 'CaptureItems')
BEGIN
    print 'Altered: CaptureItems ,CreateDate';
    alter table [CaptureItems] add [CreateDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'CaptureItems')
BEGIN
    print 'Altered: CaptureItems ,HiveActive';
    alter table [CaptureItems] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'CaptureItems')
BEGIN
    print 'Altered: CaptureItems ,HiveConnectionName';
    alter table [CaptureItems] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'CaptureItems')
BEGIN
    print 'Altered: CaptureItems ,RepoName';
    alter table [CaptureItems] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'CaptureItems')
BEGIN
    print 'Altered: CaptureItems ,RepoSvrName';
    alter table [CaptureItems] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'CaptureItems')
BEGIN
    print 'Altered: CaptureItems ,RowCreationDate';
    alter table [CaptureItems] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'CaptureItems')
BEGIN
    print 'Altered: CaptureItems ,RowGuid';
    alter table [CaptureItems] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'CaptureItems')
BEGIN
    print 'Altered: CaptureItems ,RowLastModDate';
    alter table [CaptureItems] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'DirName' and table_name = 'CLC_DIR')
BEGIN
    print 'Altered: CLC_DIR ,DirName';
    alter table [CLC_DIR] add [DirName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FullPath' and table_name = 'CLC_DIR')
BEGIN
    print 'Altered: CLC_DIR ,FullPath';
    alter table [CLC_DIR] add [FullPath]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'CLC_DIR')
BEGIN
    print 'Altered: CLC_DIR ,RepoName';
    alter table [CLC_DIR] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'CLC_DIR')
BEGIN
    print 'Altered: CLC_DIR ,RowGuid';
    alter table [CLC_DIR] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'CLC_DIR')
BEGIN
    print 'Altered: CLC_DIR ,UserID';
    alter table [CLC_DIR] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ContentGuid' and table_name = 'CLC_Download')
BEGIN
    print 'Altered: CLC_Download ,ContentGuid';
    alter table [CLC_Download] add [ContentGuid]  varchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ContentTable' and table_name = 'CLC_Download')
BEGIN
    print 'Altered: CLC_Download ,ContentTable';
    alter table [CLC_Download] add [ContentTable]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'CLC_Download')
BEGIN
    print 'Altered: CLC_Download ,RepoName';
    alter table [CLC_Download] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'CLC_Download')
BEGIN
    print 'Altered: CLC_Download ,RowGuid';
    alter table [CLC_Download] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'CLC_Download')
BEGIN
    print 'Altered: CLC_Download ,UserID';
    alter table [CLC_Download] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ContentGuid' and table_name = 'CLC_Preview')
BEGIN
    print 'Altered: CLC_Preview ,ContentGuid';
    alter table [CLC_Preview] add [ContentGuid]  varchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ContentTable' and table_name = 'CLC_Preview')
BEGIN
    print 'Altered: CLC_Preview ,ContentTable';
    alter table [CLC_Preview] add [ContentTable]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'CLC_Preview')
BEGIN
    print 'Altered: CLC_Preview ,RepoName';
    alter table [CLC_Preview] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'CLC_Preview')
BEGIN
    print 'Altered: CLC_Preview ,RowGuid';
    alter table [CLC_Preview] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'CLC_Preview')
BEGIN
    print 'Altered: CLC_Preview ,UserID';
    alter table [CLC_Preview] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CLCActive' and table_name = 'CLCState')
BEGIN
    print 'Altered: CLCState ,CLCActive';
    alter table [CLCState] add [CLCActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CLCInstalled' and table_name = 'CLCState')
BEGIN
    print 'Altered: CLCState ,CLCInstalled';
    alter table [CLCState] add [CLCInstalled]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'MachineID' and table_name = 'CLCState')
BEGIN
    print 'Altered: CLCState ,MachineID';
    alter table [CLCState] add [MachineID]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'CLCState')
BEGIN
    print 'Altered: CLCState ,RepoName';
    alter table [CLCState] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'CLCState')
BEGIN
    print 'Altered: CLCState ,RowGuid';
    alter table [CLCState] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'CLCState')
BEGIN
    print 'Altered: CLCState ,UserID';
    alter table [CLCState] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ConnStr' and table_name = 'ConnectionStrings')
BEGIN
    print 'Altered: ConnectionStrings ,ConnStr';
    alter table [ConnectionStrings] add [ConnStr]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'DBMS' and table_name = 'ConnectionStrings')
BEGIN
    print 'Altered: ConnectionStrings ,DBMS';
    alter table [ConnectionStrings] add [DBMS]  nvarchar (100)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'ConnectionStrings')
BEGIN
    print 'Altered: ConnectionStrings ,RepoName';
    alter table [ConnectionStrings] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'ConnectionStrings')
BEGIN
    print 'Altered: ConnectionStrings ,RowGuid';
    alter table [ConnectionStrings] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ConnName' and table_name = 'ConnectionStringsRegistered')
BEGIN
    print 'Altered: ConnectionStringsRegistered ,ConnName';
    alter table [ConnectionStringsRegistered] add [ConnName]  nvarchar (100)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ConnStr' and table_name = 'ConnectionStringsRegistered')
BEGIN
    print 'Altered: ConnectionStringsRegistered ,ConnStr';
    alter table [ConnectionStringsRegistered] add [ConnStr]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'ConnectionStringsRegistered')
BEGIN
    print 'Altered: ConnectionStringsRegistered ,RepoName';
    alter table [ConnectionStringsRegistered] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'ConnectionStringsRegistered')
BEGIN
    print 'Altered: ConnectionStringsRegistered ,RowGuid';
    alter table [ConnectionStringsRegistered] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CombinedSql' and table_name = 'ConnectionStringsSaved')
BEGIN
    print 'Altered: ConnectionStringsSaved ,CombinedSql';
    alter table [ConnectionStringsSaved] add [CombinedSql]  nvarchar (max)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ConnStr' and table_name = 'ConnectionStringsSaved')
BEGIN
    print 'Altered: ConnectionStringsSaved ,ConnStr';
    alter table [ConnectionStringsSaved] add [ConnStr]  nvarchar (2000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ConnstrName' and table_name = 'ConnectionStringsSaved')
BEGIN
    print 'Altered: ConnectionStringsSaved ,ConnstrName';
    alter table [ConnectionStringsSaved] add [ConnstrName]  nvarchar (100)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CustomColSelectionSQL' and table_name = 'ConnectionStringsSaved')
BEGIN
    print 'Altered: ConnectionStringsSaved ,CustomColSelectionSQL';
    alter table [ConnectionStringsSaved] add [CustomColSelectionSQL]  nvarchar (max)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CustomTableDataSQL' and table_name = 'ConnectionStringsSaved')
BEGIN
    print 'Altered: ConnectionStringsSaved ,CustomTableDataSQL';
    alter table [ConnectionStringsSaved] add [CustomTableDataSQL]  nvarchar (max)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'ConnectionStringsSaved')
BEGIN
    print 'Altered: ConnectionStringsSaved ,HiveActive';
    alter table [ConnectionStringsSaved] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'ConnectionStringsSaved')
BEGIN
    print 'Altered: ConnectionStringsSaved ,HiveConnectionName';
    alter table [ConnectionStringsSaved] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LastArchiveDate' and table_name = 'ConnectionStringsSaved')
BEGIN
    print 'Altered: ConnectionStringsSaved ,LastArchiveDate';
    alter table [ConnectionStringsSaved] add [LastArchiveDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Library' and table_name = 'ConnectionStringsSaved')
BEGIN
    print 'Altered: ConnectionStringsSaved ,Library';
    alter table [ConnectionStringsSaved] add [Library]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LibraryOwnerGuid' and table_name = 'ConnectionStringsSaved')
BEGIN
    print 'Altered: ConnectionStringsSaved ,LibraryOwnerGuid';
    alter table [ConnectionStringsSaved] add [LibraryOwnerGuid]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'ConnectionStringsSaved')
BEGIN
    print 'Altered: ConnectionStringsSaved ,RepoName';
    alter table [ConnectionStringsSaved] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'ConnectionStringsSaved')
BEGIN
    print 'Altered: ConnectionStringsSaved ,RepoSvrName';
    alter table [ConnectionStringsSaved] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RetentionCode' and table_name = 'ConnectionStringsSaved')
BEGIN
    print 'Altered: ConnectionStringsSaved ,RetentionCode';
    alter table [ConnectionStringsSaved] add [RetentionCode]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'ConnectionStringsSaved')
BEGIN
    print 'Altered: ConnectionStringsSaved ,RowCreationDate';
    alter table [ConnectionStringsSaved] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'ConnectionStringsSaved')
BEGIN
    print 'Altered: ConnectionStringsSaved ,RowGuid';
    alter table [ConnectionStringsSaved] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'ConnectionStringsSaved')
BEGIN
    print 'Altered: ConnectionStringsSaved ,RowLastModDate';
    alter table [ConnectionStringsSaved] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Schedule' and table_name = 'ConnectionStringsSaved')
BEGIN
    print 'Altered: ConnectionStringsSaved ,Schedule';
    alter table [ConnectionStringsSaved] add [Schedule]  nvarchar (2000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SelectedColumns' and table_name = 'ConnectionStringsSaved')
BEGIN
    print 'Altered: ConnectionStringsSaved ,SelectedColumns';
    alter table [ConnectionStringsSaved] add [SelectedColumns]  nvarchar (max)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'TableName' and table_name = 'ConnectionStringsSaved')
BEGIN
    print 'Altered: ConnectionStringsSaved ,TableName';
    alter table [ConnectionStringsSaved] add [TableName]  nvarchar (2000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'TypeDB' and table_name = 'ConnectionStringsSaved')
BEGIN
    print 'Altered: ConnectionStringsSaved ,TypeDB';
    alter table [ConnectionStringsSaved] add [TypeDB]  nvarchar (15)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FromEmailAddr' and table_name = 'ContactFrom')
BEGIN
    print 'Altered: ContactFrom ,FromEmailAddr';
    alter table [ContactFrom] add [FromEmailAddr]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'ContactFrom')
BEGIN
    print 'Altered: ContactFrom ,HiveActive';
    alter table [ContactFrom] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'ContactFrom')
BEGIN
    print 'Altered: ContactFrom ,HiveConnectionName';
    alter table [ContactFrom] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'ContactFrom')
BEGIN
    print 'Altered: ContactFrom ,RepoName';
    alter table [ContactFrom] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'ContactFrom')
BEGIN
    print 'Altered: ContactFrom ,RepoSvrName';
    alter table [ContactFrom] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'ContactFrom')
BEGIN
    print 'Altered: ContactFrom ,RowCreationDate';
    alter table [ContactFrom] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'ContactFrom')
BEGIN
    print 'Altered: ContactFrom ,RowGuid';
    alter table [ContactFrom] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'ContactFrom')
BEGIN
    print 'Altered: ContactFrom ,RowLastModDate';
    alter table [ContactFrom] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SenderName' and table_name = 'ContactFrom')
BEGIN
    print 'Altered: ContactFrom ,SenderName';
    alter table [ContactFrom] add [SenderName]  varchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'ContactFrom')
BEGIN
    print 'Altered: ContactFrom ,UserID';
    alter table [ContactFrom] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Verified' and table_name = 'ContactFrom')
BEGIN
    print 'Altered: ContactFrom ,Verified';
    alter table [ContactFrom] add [Verified]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Account' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,Account';
    alter table [ContactsArchive] add [Account]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Anniversary' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,Anniversary';
    alter table [ContactsArchive] add [Anniversary]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Application' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,Application';
    alter table [ContactsArchive] add [Application]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'AssistantName' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,AssistantName';
    alter table [ContactsArchive] add [AssistantName]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'AssistantTelephoneNumber' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,AssistantTelephoneNumber';
    alter table [ContactsArchive] add [AssistantTelephoneNumber]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'BillingInformation' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,BillingInformation';
    alter table [ContactsArchive] add [BillingInformation]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Birthday' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,Birthday';
    alter table [ContactsArchive] add [Birthday]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Body' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,Body';
    alter table [ContactsArchive] add [Body]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Business2TelephoneNumber' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,Business2TelephoneNumber';
    alter table [ContactsArchive] add [Business2TelephoneNumber]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'BusinessAddress' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,BusinessAddress';
    alter table [ContactsArchive] add [BusinessAddress]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'BusinessAddressCity' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,BusinessAddressCity';
    alter table [ContactsArchive] add [BusinessAddressCity]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'BusinessAddressCountry' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,BusinessAddressCountry';
    alter table [ContactsArchive] add [BusinessAddressCountry]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'BusinessAddressPostalCode' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,BusinessAddressPostalCode';
    alter table [ContactsArchive] add [BusinessAddressPostalCode]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'BusinessAddressPostOfficeBox' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,BusinessAddressPostOfficeBox';
    alter table [ContactsArchive] add [BusinessAddressPostOfficeBox]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'BusinessAddressState' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,BusinessAddressState';
    alter table [ContactsArchive] add [BusinessAddressState]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'BusinessAddressStreet' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,BusinessAddressStreet';
    alter table [ContactsArchive] add [BusinessAddressStreet]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'BusinessCardType' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,BusinessCardType';
    alter table [ContactsArchive] add [BusinessCardType]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'BusinessFaxNumber' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,BusinessFaxNumber';
    alter table [ContactsArchive] add [BusinessFaxNumber]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'BusinessHomePage' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,BusinessHomePage';
    alter table [ContactsArchive] add [BusinessHomePage]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'BusinessTelephoneNumber' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,BusinessTelephoneNumber';
    alter table [ContactsArchive] add [BusinessTelephoneNumber]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CallbackTelephoneNumber' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,CallbackTelephoneNumber';
    alter table [ContactsArchive] add [CallbackTelephoneNumber]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CarTelephoneNumber' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,CarTelephoneNumber';
    alter table [ContactsArchive] add [CarTelephoneNumber]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Categories' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,Categories';
    alter table [ContactsArchive] add [Categories]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Children' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,Children';
    alter table [ContactsArchive] add [Children]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Companies' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,Companies';
    alter table [ContactsArchive] add [Companies]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CompanyName' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,CompanyName';
    alter table [ContactsArchive] add [CompanyName]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ComputerNetworkName' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,ComputerNetworkName';
    alter table [ContactsArchive] add [ComputerNetworkName]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Conflicts' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,Conflicts';
    alter table [ContactsArchive] add [Conflicts]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ConversationTopic' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,ConversationTopic';
    alter table [ContactsArchive] add [ConversationTopic]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CreationTime' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,CreationTime';
    alter table [ContactsArchive] add [CreationTime]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CustomerID' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,CustomerID';
    alter table [ContactsArchive] add [CustomerID]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Department' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,Department';
    alter table [ContactsArchive] add [Department]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Email1Address' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,Email1Address';
    alter table [ContactsArchive] add [Email1Address]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Email1AddressType' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,Email1AddressType';
    alter table [ContactsArchive] add [Email1AddressType]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Email1DisplayName' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,Email1DisplayName';
    alter table [ContactsArchive] add [Email1DisplayName]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Email1EntryID' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,Email1EntryID';
    alter table [ContactsArchive] add [Email1EntryID]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Email2Address' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,Email2Address';
    alter table [ContactsArchive] add [Email2Address]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Email2AddressType' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,Email2AddressType';
    alter table [ContactsArchive] add [Email2AddressType]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Email2DisplayName' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,Email2DisplayName';
    alter table [ContactsArchive] add [Email2DisplayName]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Email2EntryID' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,Email2EntryID';
    alter table [ContactsArchive] add [Email2EntryID]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Email3Address' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,Email3Address';
    alter table [ContactsArchive] add [Email3Address]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Email3AddressType' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,Email3AddressType';
    alter table [ContactsArchive] add [Email3AddressType]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Email3DisplayName' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,Email3DisplayName';
    alter table [ContactsArchive] add [Email3DisplayName]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Email3EntryID' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,Email3EntryID';
    alter table [ContactsArchive] add [Email3EntryID]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FileAs' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,FileAs';
    alter table [ContactsArchive] add [FileAs]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FirstName' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,FirstName';
    alter table [ContactsArchive] add [FirstName]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FTPSite' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,FTPSite';
    alter table [ContactsArchive] add [FTPSite]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FullName' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,FullName';
    alter table [ContactsArchive] add [FullName]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Gender' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,Gender';
    alter table [ContactsArchive] add [Gender]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'GovernmentIDNumber' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,GovernmentIDNumber';
    alter table [ContactsArchive] add [GovernmentIDNumber]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,HiveActive';
    alter table [ContactsArchive] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,HiveConnectionName';
    alter table [ContactsArchive] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Hobby' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,Hobby';
    alter table [ContactsArchive] add [Hobby]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Home2TelephoneNumber' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,Home2TelephoneNumber';
    alter table [ContactsArchive] add [Home2TelephoneNumber]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HomeAddress' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,HomeAddress';
    alter table [ContactsArchive] add [HomeAddress]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HomeAddressCountry' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,HomeAddressCountry';
    alter table [ContactsArchive] add [HomeAddressCountry]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HomeAddressPostalCode' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,HomeAddressPostalCode';
    alter table [ContactsArchive] add [HomeAddressPostalCode]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HomeAddressPostOfficeBox' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,HomeAddressPostOfficeBox';
    alter table [ContactsArchive] add [HomeAddressPostOfficeBox]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HomeAddressState' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,HomeAddressState';
    alter table [ContactsArchive] add [HomeAddressState]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HomeAddressStreet' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,HomeAddressStreet';
    alter table [ContactsArchive] add [HomeAddressStreet]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HomeFaxNumber' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,HomeFaxNumber';
    alter table [ContactsArchive] add [HomeFaxNumber]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HomeTelephoneNumber' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,HomeTelephoneNumber';
    alter table [ContactsArchive] add [HomeTelephoneNumber]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'IMAddress' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,IMAddress';
    alter table [ContactsArchive] add [IMAddress]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Importance' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,Importance';
    alter table [ContactsArchive] add [Importance]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Initials' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,Initials';
    alter table [ContactsArchive] add [Initials]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'InternetFreeBusyAddress' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,InternetFreeBusyAddress';
    alter table [ContactsArchive] add [InternetFreeBusyAddress]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'JobTitle' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,JobTitle';
    alter table [ContactsArchive] add [JobTitle]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Journal' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,Journal';
    alter table [ContactsArchive] add [Journal]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Language' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,Language';
    alter table [ContactsArchive] add [Language]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LastModificationTime' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,LastModificationTime';
    alter table [ContactsArchive] add [LastModificationTime]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LastName' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,LastName';
    alter table [ContactsArchive] add [LastName]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LastNameAndFirstName' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,LastNameAndFirstName';
    alter table [ContactsArchive] add [LastNameAndFirstName]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'MailingAddress' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,MailingAddress';
    alter table [ContactsArchive] add [MailingAddress]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'MailingAddressCity' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,MailingAddressCity';
    alter table [ContactsArchive] add [MailingAddressCity]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'MailingAddressCountry' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,MailingAddressCountry';
    alter table [ContactsArchive] add [MailingAddressCountry]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'MailingAddressPostalCode' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,MailingAddressPostalCode';
    alter table [ContactsArchive] add [MailingAddressPostalCode]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'MailingAddressPostOfficeBox' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,MailingAddressPostOfficeBox';
    alter table [ContactsArchive] add [MailingAddressPostOfficeBox]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'MailingAddressState' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,MailingAddressState';
    alter table [ContactsArchive] add [MailingAddressState]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'MailingAddressStreet' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,MailingAddressStreet';
    alter table [ContactsArchive] add [MailingAddressStreet]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ManagerName' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,ManagerName';
    alter table [ContactsArchive] add [ManagerName]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'MiddleName' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,MiddleName';
    alter table [ContactsArchive] add [MiddleName]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Mileage' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,Mileage';
    alter table [ContactsArchive] add [Mileage]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'MobileTelephoneNumber' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,MobileTelephoneNumber';
    alter table [ContactsArchive] add [MobileTelephoneNumber]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'NetMeetingAlias' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,NetMeetingAlias';
    alter table [ContactsArchive] add [NetMeetingAlias]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'NetMeetingServer' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,NetMeetingServer';
    alter table [ContactsArchive] add [NetMeetingServer]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'NickName' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,NickName';
    alter table [ContactsArchive] add [NickName]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'OfficeLocation' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,OfficeLocation';
    alter table [ContactsArchive] add [OfficeLocation]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,RepoName';
    alter table [ContactsArchive] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,RepoSvrName';
    alter table [ContactsArchive] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,RowCreationDate';
    alter table [ContactsArchive] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,RowGuid';
    alter table [ContactsArchive] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,RowLastModDate';
    alter table [ContactsArchive] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Subject' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,Subject';
    alter table [ContactsArchive] add [Subject]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Title' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,Title';
    alter table [ContactsArchive] add [Title]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,UserID';
    alter table [ContactsArchive] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'xClass' and table_name = 'ContactsArchive')
BEGIN
    print 'Altered: ContactsArchive ,xClass';
    alter table [ContactsArchive] add [xClass]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ContainerGuid' and table_name = 'Container')
BEGIN
    print 'Altered: Container ,ContainerGuid';
    alter table [Container] add [ContainerGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ContainerName' and table_name = 'Container')
BEGIN
    print 'Altered: Container ,ContainerName';
    alter table [Container] add [ContainerName]  nvarchar (449)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'Container')
BEGIN
    print 'Altered: Container ,RepoName';
    alter table [Container] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'Container')
BEGIN
    print 'Altered: Container ,RowGuid';
    alter table [Container] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ContainerType' and table_name = 'ContainerStorage')
BEGIN
    print 'Altered: ContainerStorage ,ContainerType';
    alter table [ContainerStorage] add [ContainerType]  nvarchar (25)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'ContainerStorage')
BEGIN
    print 'Altered: ContainerStorage ,HiveActive';
    alter table [ContainerStorage] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'ContainerStorage')
BEGIN
    print 'Altered: ContainerStorage ,HiveConnectionName';
    alter table [ContainerStorage] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'ContainerStorage')
BEGIN
    print 'Altered: ContainerStorage ,RepoName';
    alter table [ContainerStorage] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'ContainerStorage')
BEGIN
    print 'Altered: ContainerStorage ,RepoSvrName';
    alter table [ContainerStorage] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'ContainerStorage')
BEGIN
    print 'Altered: ContainerStorage ,RowCreationDate';
    alter table [ContainerStorage] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'ContainerStorage')
BEGIN
    print 'Altered: ContainerStorage ,RowGuid';
    alter table [ContainerStorage] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'ContainerStorage')
BEGIN
    print 'Altered: ContainerStorage ,RowLastModDate';
    alter table [ContainerStorage] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'StoreCode' and table_name = 'ContainerStorage')
BEGIN
    print 'Altered: ContainerStorage ,StoreCode';
    alter table [ContainerStorage] add [StoreCode]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ContainerGuid' and table_name = 'ContentContainer')
BEGIN
    print 'Altered: ContentContainer ,ContainerGuid';
    alter table [ContentContainer] add [ContainerGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ContentUserRowGuid' and table_name = 'ContentContainer')
BEGIN
    print 'Altered: ContentContainer ,ContentUserRowGuid';
    alter table [ContentContainer] add [ContentUserRowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'ContentContainer')
BEGIN
    print 'Altered: ContentContainer ,RepoName';
    alter table [ContentContainer] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'ContentContainer')
BEGIN
    print 'Altered: ContentContainer ,RowGuid';
    alter table [ContentContainer] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ContentGuid' and table_name = 'ContentUser')
BEGIN
    print 'Altered: ContentUser ,ContentGuid';
    alter table [ContentUser] add [ContentGuid]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ContentTypeCode' and table_name = 'ContentUser')
BEGIN
    print 'Altered: ContentUser ,ContentTypeCode';
    alter table [ContentUser] add [ContentTypeCode]  nchar (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ContentUserRowGuid' and table_name = 'ContentUser')
BEGIN
    print 'Altered: ContentUser ,ContentUserRowGuid';
    alter table [ContentUser] add [ContentUserRowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'NbrOccurances' and table_name = 'ContentUser')
BEGIN
    print 'Altered: ContentUser ,NbrOccurances';
    alter table [ContentUser] add [NbrOccurances]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'ContentUser')
BEGIN
    print 'Altered: ContentUser ,RepoName';
    alter table [ContentUser] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'ContentUser')
BEGIN
    print 'Altered: ContentUser ,RowGuid';
    alter table [ContentUser] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'ContentUser')
BEGIN
    print 'Altered: ContentUser ,UserID';
    alter table [ContentUser] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CorpName' and table_name = 'ConvertedDocs')
BEGIN
    print 'Altered: ConvertedDocs ,CorpName';
    alter table [ConvertedDocs] add [CorpName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FileDir' and table_name = 'ConvertedDocs')
BEGIN
    print 'Altered: ConvertedDocs ,FileDir';
    alter table [ConvertedDocs] add [FileDir]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FileName' and table_name = 'ConvertedDocs')
BEGIN
    print 'Altered: ConvertedDocs ,FileName';
    alter table [ConvertedDocs] add [FileName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FQN' and table_name = 'ConvertedDocs')
BEGIN
    print 'Altered: ConvertedDocs ,FQN';
    alter table [ConvertedDocs] add [FQN]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'ConvertedDocs')
BEGIN
    print 'Altered: ConvertedDocs ,HiveActive';
    alter table [ConvertedDocs] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'ConvertedDocs')
BEGIN
    print 'Altered: ConvertedDocs ,HiveConnectionName';
    alter table [ConvertedDocs] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'ConvertedDocs')
BEGIN
    print 'Altered: ConvertedDocs ,RepoName';
    alter table [ConvertedDocs] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'ConvertedDocs')
BEGIN
    print 'Altered: ConvertedDocs ,RepoSvrName';
    alter table [ConvertedDocs] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'ConvertedDocs')
BEGIN
    print 'Altered: ConvertedDocs ,RowCreationDate';
    alter table [ConvertedDocs] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'ConvertedDocs')
BEGIN
    print 'Altered: ConvertedDocs ,RowGuid';
    alter table [ConvertedDocs] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'ConvertedDocs')
BEGIN
    print 'Altered: ConvertedDocs ,RowLastModDate';
    alter table [ConvertedDocs] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'XMLDIr' and table_name = 'ConvertedDocs')
BEGIN
    print 'Altered: ConvertedDocs ,XMLDIr';
    alter table [ConvertedDocs] add [XMLDIr]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'XMLName' and table_name = 'ConvertedDocs')
BEGIN
    print 'Altered: ConvertedDocs ,XMLName';
    alter table [ConvertedDocs] add [XMLName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CreateDate' and table_name = 'CoOwner')
BEGIN
    print 'Altered: CoOwner ,CreateDate';
    alter table [CoOwner] add [CreateDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CurrentOwnerUserID' and table_name = 'CoOwner')
BEGIN
    print 'Altered: CoOwner ,CurrentOwnerUserID';
    alter table [CoOwner] add [CurrentOwnerUserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'CoOwner')
BEGIN
    print 'Altered: CoOwner ,HiveActive';
    alter table [CoOwner] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'CoOwner')
BEGIN
    print 'Altered: CoOwner ,HiveConnectionName';
    alter table [CoOwner] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'PreviousOwnerUserID' and table_name = 'CoOwner')
BEGIN
    print 'Altered: CoOwner ,PreviousOwnerUserID';
    alter table [CoOwner] add [PreviousOwnerUserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'CoOwner')
BEGIN
    print 'Altered: CoOwner ,RepoName';
    alter table [CoOwner] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'CoOwner')
BEGIN
    print 'Altered: CoOwner ,RepoSvrName';
    alter table [CoOwner] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'CoOwner')
BEGIN
    print 'Altered: CoOwner ,RowCreationDate';
    alter table [CoOwner] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'CoOwner')
BEGIN
    print 'Altered: CoOwner ,RowGuid';
    alter table [CoOwner] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowId' and table_name = 'CoOwner')
BEGIN
    print 'Altered: CoOwner ,RowId';
    alter table [CoOwner] add [RowId]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'CoOwner')
BEGIN
    print 'Altered: CoOwner ,RowLastModDate';
    alter table [CoOwner] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ContainerType' and table_name = 'CorpContainer')
BEGIN
    print 'Altered: CorpContainer ,ContainerType';
    alter table [CorpContainer] add [ContainerType]  nvarchar (25)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CorpFuncName' and table_name = 'CorpContainer')
BEGIN
    print 'Altered: CorpContainer ,CorpFuncName';
    alter table [CorpContainer] add [CorpFuncName]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CorpName' and table_name = 'CorpContainer')
BEGIN
    print 'Altered: CorpContainer ,CorpName';
    alter table [CorpContainer] add [CorpName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'CorpContainer')
BEGIN
    print 'Altered: CorpContainer ,HiveActive';
    alter table [CorpContainer] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'CorpContainer')
BEGIN
    print 'Altered: CorpContainer ,HiveConnectionName';
    alter table [CorpContainer] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'QtyDocCode' and table_name = 'CorpContainer')
BEGIN
    print 'Altered: CorpContainer ,QtyDocCode';
    alter table [CorpContainer] add [QtyDocCode]  nvarchar (10)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'CorpContainer')
BEGIN
    print 'Altered: CorpContainer ,RepoName';
    alter table [CorpContainer] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'CorpContainer')
BEGIN
    print 'Altered: CorpContainer ,RepoSvrName';
    alter table [CorpContainer] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'CorpContainer')
BEGIN
    print 'Altered: CorpContainer ,RowCreationDate';
    alter table [CorpContainer] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'CorpContainer')
BEGIN
    print 'Altered: CorpContainer ,RowGuid';
    alter table [CorpContainer] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'CorpContainer')
BEGIN
    print 'Altered: CorpContainer ,RowLastModDate';
    alter table [CorpContainer] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CorpFuncDesc' and table_name = 'CorpFunction')
BEGIN
    print 'Altered: CorpFunction ,CorpFuncDesc';
    alter table [CorpFunction] add [CorpFuncDesc]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CorpFuncName' and table_name = 'CorpFunction')
BEGIN
    print 'Altered: CorpFunction ,CorpFuncName';
    alter table [CorpFunction] add [CorpFuncName]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CorpName' and table_name = 'CorpFunction')
BEGIN
    print 'Altered: CorpFunction ,CorpName';
    alter table [CorpFunction] add [CorpName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CreateDate' and table_name = 'CorpFunction')
BEGIN
    print 'Altered: CorpFunction ,CreateDate';
    alter table [CorpFunction] add [CreateDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'CorpFunction')
BEGIN
    print 'Altered: CorpFunction ,HiveActive';
    alter table [CorpFunction] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'CorpFunction')
BEGIN
    print 'Altered: CorpFunction ,HiveConnectionName';
    alter table [CorpFunction] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'CorpFunction')
BEGIN
    print 'Altered: CorpFunction ,RepoName';
    alter table [CorpFunction] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'CorpFunction')
BEGIN
    print 'Altered: CorpFunction ,RepoSvrName';
    alter table [CorpFunction] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'CorpFunction')
BEGIN
    print 'Altered: CorpFunction ,RowCreationDate';
    alter table [CorpFunction] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'CorpFunction')
BEGIN
    print 'Altered: CorpFunction ,RowGuid';
    alter table [CorpFunction] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'CorpFunction')
BEGIN
    print 'Altered: CorpFunction ,RowLastModDate';
    alter table [CorpFunction] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CorpName' and table_name = 'Corporation')
BEGIN
    print 'Altered: Corporation ,CorpName';
    alter table [Corporation] add [CorpName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'Corporation')
BEGIN
    print 'Altered: Corporation ,HiveActive';
    alter table [Corporation] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'Corporation')
BEGIN
    print 'Altered: Corporation ,HiveConnectionName';
    alter table [Corporation] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'Corporation')
BEGIN
    print 'Altered: Corporation ,RepoName';
    alter table [Corporation] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'Corporation')
BEGIN
    print 'Altered: Corporation ,RepoSvrName';
    alter table [Corporation] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'Corporation')
BEGIN
    print 'Altered: Corporation ,RowCreationDate';
    alter table [Corporation] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'Corporation')
BEGIN
    print 'Altered: Corporation ,RowGuid';
    alter table [Corporation] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'Corporation')
BEGIN
    print 'Altered: Corporation ,RowLastModDate';
    alter table [Corporation] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ConnectionName' and table_name = 'CS')
BEGIN
    print 'Altered: CS ,ConnectionName';
    alter table [CS] add [ConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ConnectionString' and table_name = 'CS')
BEGIN
    print 'Altered: CS ,ConnectionString';
    alter table [CS] add [ConnectionString]  varchar (300)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ConnectionType' and table_name = 'CS')
BEGIN
    print 'Altered: CS ,ConnectionType';
    alter table [CS] add [ConnectionType]  nchar (25)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'CS')
BEGIN
    print 'Altered: CS ,HiveActive';
    alter table [CS] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'CS')
BEGIN
    print 'Altered: CS ,HiveConnectionName';
    alter table [CS] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ID_NBR' and table_name = 'CS')
BEGIN
    print 'Altered: CS ,ID_NBR';
    alter table [CS] add [ID_NBR]  varchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LoginID' and table_name = 'CS')
BEGIN
    print 'Altered: CS ,LoginID';
    alter table [CS] add [LoginID]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LoginPW' and table_name = 'CS')
BEGIN
    print 'Altered: CS ,LoginPW';
    alter table [CS] add [LoginPW]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'CS')
BEGIN
    print 'Altered: CS ,RepoName';
    alter table [CS] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'CS')
BEGIN
    print 'Altered: CS ,RepoSvrName';
    alter table [CS] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'CS')
BEGIN
    print 'Altered: CS ,RowCreationDate';
    alter table [CS] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'CS')
BEGIN
    print 'Altered: CS ,RowGuid';
    alter table [CS] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'CS')
BEGIN
    print 'Altered: CS ,RowLastModDate';
    alter table [CS] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SharePointURL' and table_name = 'CS')
BEGIN
    print 'Altered: CS ,SharePointURL';
    alter table [CS] add [SharePointURL]  nvarchar (500)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ConnectionName' and table_name = 'CS_SharePoint')
BEGIN
    print 'Altered: CS_SharePoint ,ConnectionName';
    alter table [CS_SharePoint] add [ConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ECM_ConnectionString' and table_name = 'CS_SharePoint')
BEGIN
    print 'Altered: CS_SharePoint ,ECM_ConnectionString';
    alter table [CS_SharePoint] add [ECM_ConnectionString]  varchar (300)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'CS_SharePoint')
BEGIN
    print 'Altered: CS_SharePoint ,HiveActive';
    alter table [CS_SharePoint] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'CS_SharePoint')
BEGIN
    print 'Altered: CS_SharePoint ,HiveConnectionName';
    alter table [CS_SharePoint] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ID_NBR' and table_name = 'CS_SharePoint')
BEGIN
    print 'Altered: CS_SharePoint ,ID_NBR';
    alter table [CS_SharePoint] add [ID_NBR]  varchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ID_NBR_ECM' and table_name = 'CS_SharePoint')
BEGIN
    print 'Altered: CS_SharePoint ,ID_NBR_ECM';
    alter table [CS_SharePoint] add [ID_NBR_ECM]  varchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'isPublic' and table_name = 'CS_SharePoint')
BEGIN
    print 'Altered: CS_SharePoint ,isPublic';
    alter table [CS_SharePoint] add [isPublic]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LibraryName' and table_name = 'CS_SharePoint')
BEGIN
    print 'Altered: CS_SharePoint ,LibraryName';
    alter table [CS_SharePoint] add [LibraryName]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LoginID' and table_name = 'CS_SharePoint')
BEGIN
    print 'Altered: CS_SharePoint ,LoginID';
    alter table [CS_SharePoint] add [LoginID]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LoginPW' and table_name = 'CS_SharePoint')
BEGIN
    print 'Altered: CS_SharePoint ,LoginPW';
    alter table [CS_SharePoint] add [LoginPW]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'CS_SharePoint')
BEGIN
    print 'Altered: CS_SharePoint ,RepoName';
    alter table [CS_SharePoint] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'CS_SharePoint')
BEGIN
    print 'Altered: CS_SharePoint ,RepoSvrName';
    alter table [CS_SharePoint] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'CS_SharePoint')
BEGIN
    print 'Altered: CS_SharePoint ,RowCreationDate';
    alter table [CS_SharePoint] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'CS_SharePoint')
BEGIN
    print 'Altered: CS_SharePoint ,RowGuid';
    alter table [CS_SharePoint] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'CS_SharePoint')
BEGIN
    print 'Altered: CS_SharePoint ,RowLastModDate';
    alter table [CS_SharePoint] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SP_ConnectionString' and table_name = 'CS_SharePoint')
BEGIN
    print 'Altered: CS_SharePoint ,SP_ConnectionString';
    alter table [CS_SharePoint] add [SP_ConnectionString]  varchar (300)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'backup_lsn' and table_name = 'DatabaseFiles')
BEGIN
    print 'Altered: DatabaseFiles ,backup_lsn';
    alter table [DatabaseFiles] add [backup_lsn]  numeric; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'create_lsn' and table_name = 'DatabaseFiles')
BEGIN
    print 'Altered: DatabaseFiles ,create_lsn';
    alter table [DatabaseFiles] add [create_lsn]  numeric; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CreationDate' and table_name = 'DatabaseFiles')
BEGIN
    print 'Altered: DatabaseFiles ,CreationDate';
    alter table [DatabaseFiles] add [CreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'data_space_id' and table_name = 'DatabaseFiles')
BEGIN
    print 'Altered: DatabaseFiles ,data_space_id';
    alter table [DatabaseFiles] add [data_space_id]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'differential_base_guid' and table_name = 'DatabaseFiles')
BEGIN
    print 'Altered: DatabaseFiles ,differential_base_guid';
    alter table [DatabaseFiles] add [differential_base_guid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'differential_base_lsn' and table_name = 'DatabaseFiles')
BEGIN
    print 'Altered: DatabaseFiles ,differential_base_lsn';
    alter table [DatabaseFiles] add [differential_base_lsn]  numeric; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'differential_base_time' and table_name = 'DatabaseFiles')
BEGIN
    print 'Altered: DatabaseFiles ,differential_base_time';
    alter table [DatabaseFiles] add [differential_base_time]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'drop_lsn' and table_name = 'DatabaseFiles')
BEGIN
    print 'Altered: DatabaseFiles ,drop_lsn';
    alter table [DatabaseFiles] add [drop_lsn]  numeric; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'file_guid' and table_name = 'DatabaseFiles')
BEGIN
    print 'Altered: DatabaseFiles ,file_guid';
    alter table [DatabaseFiles] add [file_guid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'file_id' and table_name = 'DatabaseFiles')
BEGIN
    print 'Altered: DatabaseFiles ,file_id';
    alter table [DatabaseFiles] add [file_id]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'growth' and table_name = 'DatabaseFiles')
BEGIN
    print 'Altered: DatabaseFiles ,growth';
    alter table [DatabaseFiles] add [growth]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'is_media_read_only' and table_name = 'DatabaseFiles')
BEGIN
    print 'Altered: DatabaseFiles ,is_media_read_only';
    alter table [DatabaseFiles] add [is_media_read_only]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'is_name_reserved' and table_name = 'DatabaseFiles')
BEGIN
    print 'Altered: DatabaseFiles ,is_name_reserved';
    alter table [DatabaseFiles] add [is_name_reserved]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'is_percent_growth' and table_name = 'DatabaseFiles')
BEGIN
    print 'Altered: DatabaseFiles ,is_percent_growth';
    alter table [DatabaseFiles] add [is_percent_growth]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'is_read_only' and table_name = 'DatabaseFiles')
BEGIN
    print 'Altered: DatabaseFiles ,is_read_only';
    alter table [DatabaseFiles] add [is_read_only]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'is_sparse' and table_name = 'DatabaseFiles')
BEGIN
    print 'Altered: DatabaseFiles ,is_sparse';
    alter table [DatabaseFiles] add [is_sparse]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'max_size' and table_name = 'DatabaseFiles')
BEGIN
    print 'Altered: DatabaseFiles ,max_size';
    alter table [DatabaseFiles] add [max_size]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'name' and table_name = 'DatabaseFiles')
BEGIN
    print 'Altered: DatabaseFiles ,name';
    alter table [DatabaseFiles] add [name]  nvarchar (128)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'physical_name' and table_name = 'DatabaseFiles')
BEGIN
    print 'Altered: DatabaseFiles ,physical_name';
    alter table [DatabaseFiles] add [physical_name]  nvarchar (260)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'read_only_lsn' and table_name = 'DatabaseFiles')
BEGIN
    print 'Altered: DatabaseFiles ,read_only_lsn';
    alter table [DatabaseFiles] add [read_only_lsn]  numeric; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'read_write_lsn' and table_name = 'DatabaseFiles')
BEGIN
    print 'Altered: DatabaseFiles ,read_write_lsn';
    alter table [DatabaseFiles] add [read_write_lsn]  numeric; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'redo_start_fork_guid' and table_name = 'DatabaseFiles')
BEGIN
    print 'Altered: DatabaseFiles ,redo_start_fork_guid';
    alter table [DatabaseFiles] add [redo_start_fork_guid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'redo_start_lsn' and table_name = 'DatabaseFiles')
BEGIN
    print 'Altered: DatabaseFiles ,redo_start_lsn';
    alter table [DatabaseFiles] add [redo_start_lsn]  numeric; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'redo_target_fork_guid' and table_name = 'DatabaseFiles')
BEGIN
    print 'Altered: DatabaseFiles ,redo_target_fork_guid';
    alter table [DatabaseFiles] add [redo_target_fork_guid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'redo_target_lsn' and table_name = 'DatabaseFiles')
BEGIN
    print 'Altered: DatabaseFiles ,redo_target_lsn';
    alter table [DatabaseFiles] add [redo_target_lsn]  numeric; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'DatabaseFiles')
BEGIN
    print 'Altered: DatabaseFiles ,RepoName';
    alter table [DatabaseFiles] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'DatabaseFiles')
BEGIN
    print 'Altered: DatabaseFiles ,RowGuid';
    alter table [DatabaseFiles] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'size' and table_name = 'DatabaseFiles')
BEGIN
    print 'Altered: DatabaseFiles ,size';
    alter table [DatabaseFiles] add [size]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'state' and table_name = 'DatabaseFiles')
BEGIN
    print 'Altered: DatabaseFiles ,state';
    alter table [DatabaseFiles] add [state]  tinyint; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'state_desc' and table_name = 'DatabaseFiles')
BEGIN
    print 'Altered: DatabaseFiles ,state_desc';
    alter table [DatabaseFiles] add [state_desc]  nvarchar (60)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'type' and table_name = 'DatabaseFiles')
BEGIN
    print 'Altered: DatabaseFiles ,type';
    alter table [DatabaseFiles] add [type]  tinyint; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'type_desc' and table_name = 'DatabaseFiles')
BEGIN
    print 'Altered: DatabaseFiles ,type_desc';
    alter table [DatabaseFiles] add [type_desc]  nvarchar (60)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'DB_CONN_STR' and table_name = 'Databases')
BEGIN
    print 'Altered: Databases ,DB_CONN_STR';
    alter table [Databases] add [DB_CONN_STR]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'DB_ID' and table_name = 'Databases')
BEGIN
    print 'Altered: Databases ,DB_ID';
    alter table [Databases] add [DB_ID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'Databases')
BEGIN
    print 'Altered: Databases ,HiveActive';
    alter table [Databases] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'Databases')
BEGIN
    print 'Altered: Databases ,HiveConnectionName';
    alter table [Databases] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'Databases')
BEGIN
    print 'Altered: Databases ,RepoName';
    alter table [Databases] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'Databases')
BEGIN
    print 'Altered: Databases ,RepoSvrName';
    alter table [Databases] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'Databases')
BEGIN
    print 'Altered: Databases ,RowCreationDate';
    alter table [Databases] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'Databases')
BEGIN
    print 'Altered: Databases ,RowGuid';
    alter table [Databases] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'Databases')
BEGIN
    print 'Altered: Databases ,RowLastModDate';
    alter table [Databases] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'DataSourceOwnerUserID' and table_name = 'DataOwners')
BEGIN
    print 'Altered: DataOwners ,DataSourceOwnerUserID';
    alter table [DataOwners] add [DataSourceOwnerUserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'DeleteAccess' and table_name = 'DataOwners')
BEGIN
    print 'Altered: DataOwners ,DeleteAccess';
    alter table [DataOwners] add [DeleteAccess]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FullAccess' and table_name = 'DataOwners')
BEGIN
    print 'Altered: DataOwners ,FullAccess';
    alter table [DataOwners] add [FullAccess]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'GroupName' and table_name = 'DataOwners')
BEGIN
    print 'Altered: DataOwners ,GroupName';
    alter table [DataOwners] add [GroupName]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'GroupOwnerUserID' and table_name = 'DataOwners')
BEGIN
    print 'Altered: DataOwners ,GroupOwnerUserID';
    alter table [DataOwners] add [GroupOwnerUserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'DataOwners')
BEGIN
    print 'Altered: DataOwners ,HiveActive';
    alter table [DataOwners] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'DataOwners')
BEGIN
    print 'Altered: DataOwners ,HiveConnectionName';
    alter table [DataOwners] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'OwnerTypeCode' and table_name = 'DataOwners')
BEGIN
    print 'Altered: DataOwners ,OwnerTypeCode';
    alter table [DataOwners] add [OwnerTypeCode]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'PrimaryOwner' and table_name = 'DataOwners')
BEGIN
    print 'Altered: DataOwners ,PrimaryOwner';
    alter table [DataOwners] add [PrimaryOwner]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ReadOnly' and table_name = 'DataOwners')
BEGIN
    print 'Altered: DataOwners ,ReadOnly';
    alter table [DataOwners] add [ReadOnly]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'DataOwners')
BEGIN
    print 'Altered: DataOwners ,RepoName';
    alter table [DataOwners] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'DataOwners')
BEGIN
    print 'Altered: DataOwners ,RepoSvrName';
    alter table [DataOwners] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'DataOwners')
BEGIN
    print 'Altered: DataOwners ,RowCreationDate';
    alter table [DataOwners] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'DataOwners')
BEGIN
    print 'Altered: DataOwners ,RowGuid';
    alter table [DataOwners] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'DataOwners')
BEGIN
    print 'Altered: DataOwners ,RowLastModDate';
    alter table [DataOwners] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Searchable' and table_name = 'DataOwners')
BEGIN
    print 'Altered: DataOwners ,Searchable';
    alter table [DataOwners] add [Searchable]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SourceGuid' and table_name = 'DataOwners')
BEGIN
    print 'Altered: DataOwners ,SourceGuid';
    alter table [DataOwners] add [SourceGuid]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'DataOwners')
BEGIN
    print 'Altered: DataOwners ,UserID';
    alter table [DataOwners] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'BPS' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,BPS';
    alter table [DataSource] add [BPS]  float; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CompressedSize' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,CompressedSize';
    alter table [DataSource] add [CompressedSize]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ContainedWithin' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,ContainedWithin';
    alter table [DataSource] add [ContainedWithin]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CRC' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,CRC';
    alter table [DataSource] add [CRC]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CreateDate' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,CreateDate';
    alter table [DataSource] add [CreateDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CreationDate' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,CreationDate';
    alter table [DataSource] add [CreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'DataSourceOwnerUserID' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,DataSourceOwnerUserID';
    alter table [DataSource] add [DataSourceOwnerUserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'DataVerified' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,DataVerified';
    alter table [DataSource] add [DataVerified]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Description' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,Description';
    alter table [DataSource] add [Description]  nvarchar (max)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FileAttached' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,FileAttached';
    alter table [DataSource] add [FileAttached]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FileDirectory' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,FileDirectory';
    alter table [DataSource] add [FileDirectory]  nvarchar (300)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FileLength' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,FileLength';
    alter table [DataSource] add [FileLength]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FQN' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,FQN';
    alter table [DataSource] add [FQN]  varchar (712)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'GraphicContainsText' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,GraphicContainsText';
    alter table [DataSource] add [GraphicContainsText]  nchar (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HashFile' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,HashFile';
    alter table [DataSource] add [HashFile]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HashName' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,HashName';
    alter table [DataSource] add [HashName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,HiveActive';
    alter table [DataSource] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,HiveConnectionName';
    alter table [DataSource] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ImageHiddenText' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,ImageHiddenText';
    alter table [DataSource] add [ImageHiddenText]  nvarchar (max)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'isAvailable' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,isAvailable';
    alter table [DataSource] add [isAvailable]  nchar (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'isContainedWithinZipFile' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,isContainedWithinZipFile';
    alter table [DataSource] add [isContainedWithinZipFile]  nchar (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'isGraphic' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,isGraphic';
    alter table [DataSource] add [isGraphic]  nchar (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'isMaster' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,isMaster';
    alter table [DataSource] add [isMaster]  nchar (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'isPerm' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,isPerm';
    alter table [DataSource] add [isPerm]  nchar (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'isPublic' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,isPublic';
    alter table [DataSource] add [isPublic]  nchar (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'IsPublicPreviousState' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,IsPublicPreviousState';
    alter table [DataSource] add [IsPublicPreviousState]  nchar (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'isWebPage' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,isWebPage';
    alter table [DataSource] add [isWebPage]  nchar (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'IsZipFile' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,IsZipFile';
    alter table [DataSource] add [IsZipFile]  nchar (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'KeyWords' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,KeyWords';
    alter table [DataSource] add [KeyWords]  nvarchar (2000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LastAccessDate' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,LastAccessDate';
    alter table [DataSource] add [LastAccessDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LastWriteTime' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,LastWriteTime';
    alter table [DataSource] add [LastWriteTime]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'MachineID' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,MachineID';
    alter table [DataSource] add [MachineID]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Notes' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,Notes';
    alter table [DataSource] add [Notes]  nvarchar (2000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'OcrPending' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,OcrPending';
    alter table [DataSource] add [OcrPending]  char (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'OcrPerformed' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,OcrPerformed';
    alter table [DataSource] add [OcrPerformed]  nchar (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'OcrSuccessful' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,OcrSuccessful';
    alter table [DataSource] add [OcrSuccessful]  char (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'OcrText' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,OcrText';
    alter table [DataSource] add [OcrText]  nvarchar (max)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'OriginalFileType' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,OriginalFileType';
    alter table [DataSource] add [OriginalFileType]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'OriginalSize' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,OriginalSize';
    alter table [DataSource] add [OriginalSize]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'PageURL' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,PageURL';
    alter table [DataSource] add [PageURL]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ParentGuid' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,ParentGuid';
    alter table [DataSource] add [ParentGuid]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'PdfImages' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,PdfImages';
    alter table [DataSource] add [PdfImages]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'PdfIsSearchable' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,PdfIsSearchable';
    alter table [DataSource] add [PdfIsSearchable]  char (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'PdfOcrRequired' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,PdfOcrRequired';
    alter table [DataSource] add [PdfOcrRequired]  char (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'PdfOcrSuccess' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,PdfOcrSuccess';
    alter table [DataSource] add [PdfOcrSuccess]  char (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'PdfOcrTextExtracted' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,PdfOcrTextExtracted';
    alter table [DataSource] add [PdfOcrTextExtracted]  char (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'PdfPages' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,PdfPages';
    alter table [DataSource] add [PdfPages]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RecHash' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,RecHash';
    alter table [DataSource] add [RecHash]  varchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RecLen' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,RecLen';
    alter table [DataSource] add [RecLen]  float; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,RepoName';
    alter table [DataSource] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,RepoSvrName';
    alter table [DataSource] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RequireOcr' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,RequireOcr';
    alter table [DataSource] add [RequireOcr]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RetentionCode' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,RetentionCode';
    alter table [DataSource] add [RetentionCode]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RetentionDate' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,RetentionDate';
    alter table [DataSource] add [RetentionDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RetentionExpirationDate' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,RetentionExpirationDate';
    alter table [DataSource] add [RetentionExpirationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,RowCreationDate';
    alter table [DataSource] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,RowGuid';
    alter table [DataSource] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowID' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,RowID';
    alter table [DataSource] add [RowID]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,RowLastModDate';
    alter table [DataSource] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RssLinkFlg' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,RssLinkFlg';
    alter table [DataSource] add [RssLinkFlg]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RssLinkGuid' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,RssLinkGuid';
    alter table [DataSource] add [RssLinkGuid]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SapData' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,SapData';
    alter table [DataSource] add [SapData]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SharePoint' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,SharePoint';
    alter table [DataSource] add [SharePoint]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SharePointDoc' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,SharePointDoc';
    alter table [DataSource] add [SharePointDoc]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SharePointList' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,SharePointList';
    alter table [DataSource] add [SharePointList]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SharePointListItem' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,SharePointListItem';
    alter table [DataSource] add [SharePointListItem]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SourceGuid' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,SourceGuid';
    alter table [DataSource] add [SourceGuid]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SourceImage' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,SourceImage';
    alter table [DataSource] add [SourceImage]  varbinary; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SourceName' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,SourceName';
    alter table [DataSource] add [SourceName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SourceTypeCode' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,SourceTypeCode';
    alter table [DataSource] add [SourceTypeCode]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'StructuredData' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,StructuredData';
    alter table [DataSource] add [StructuredData]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'TransmitTime' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,TransmitTime';
    alter table [DataSource] add [TransmitTime]  float; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'txEndTime' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,txEndTime';
    alter table [DataSource] add [txEndTime]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'txStartTime' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,txStartTime';
    alter table [DataSource] add [txStartTime]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'txTotalTime' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,txTotalTime';
    alter table [DataSource] add [txTotalTime]  float; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'URLHash' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,URLHash';
    alter table [DataSource] add [URLHash]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,UserID';
    alter table [DataSource] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'VersionNbr' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,VersionNbr';
    alter table [DataSource] add [VersionNbr]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'WebPagePublishDate' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,WebPagePublishDate';
    alter table [DataSource] add [WebPagePublishDate]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ZipFileFQN' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,ZipFileFQN';
    alter table [DataSource] add [ZipFileFQN]  varchar (712)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ZipFileGuid' and table_name = 'DataSource')
BEGIN
    print 'Altered: DataSource ,ZipFileGuid';
    alter table [DataSource] add [ZipFileGuid]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CheckedOutByUserID' and table_name = 'DataSourceCheckOut')
BEGIN
    print 'Altered: DataSourceCheckOut ,CheckedOutByUserID';
    alter table [DataSourceCheckOut] add [CheckedOutByUserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'checkOutDate' and table_name = 'DataSourceCheckOut')
BEGIN
    print 'Altered: DataSourceCheckOut ,checkOutDate';
    alter table [DataSourceCheckOut] add [checkOutDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'DataSourceOwnerUserID' and table_name = 'DataSourceCheckOut')
BEGIN
    print 'Altered: DataSourceCheckOut ,DataSourceOwnerUserID';
    alter table [DataSourceCheckOut] add [DataSourceOwnerUserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'DataSourceCheckOut')
BEGIN
    print 'Altered: DataSourceCheckOut ,HiveActive';
    alter table [DataSourceCheckOut] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'DataSourceCheckOut')
BEGIN
    print 'Altered: DataSourceCheckOut ,HiveConnectionName';
    alter table [DataSourceCheckOut] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'isForUpdate' and table_name = 'DataSourceCheckOut')
BEGIN
    print 'Altered: DataSourceCheckOut ,isForUpdate';
    alter table [DataSourceCheckOut] add [isForUpdate]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'isReadOnly' and table_name = 'DataSourceCheckOut')
BEGIN
    print 'Altered: DataSourceCheckOut ,isReadOnly';
    alter table [DataSourceCheckOut] add [isReadOnly]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'DataSourceCheckOut')
BEGIN
    print 'Altered: DataSourceCheckOut ,RepoName';
    alter table [DataSourceCheckOut] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'DataSourceCheckOut')
BEGIN
    print 'Altered: DataSourceCheckOut ,RepoSvrName';
    alter table [DataSourceCheckOut] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'DataSourceCheckOut')
BEGIN
    print 'Altered: DataSourceCheckOut ,RowCreationDate';
    alter table [DataSourceCheckOut] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'DataSourceCheckOut')
BEGIN
    print 'Altered: DataSourceCheckOut ,RowGuid';
    alter table [DataSourceCheckOut] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'DataSourceCheckOut')
BEGIN
    print 'Altered: DataSourceCheckOut ,RowLastModDate';
    alter table [DataSourceCheckOut] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SourceGuid' and table_name = 'DataSourceCheckOut')
BEGIN
    print 'Altered: DataSourceCheckOut ,SourceGuid';
    alter table [DataSourceCheckOut] add [SourceGuid]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ChildSourceGuid' and table_name = 'DataSourceChildren')
BEGIN
    print 'Altered: DataSourceChildren ,ChildSourceGuid';
    alter table [DataSourceChildren] add [ChildSourceGuid]  nchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ParentSourceGuid' and table_name = 'DataSourceChildren')
BEGIN
    print 'Altered: DataSourceChildren ,ParentSourceGuid';
    alter table [DataSourceChildren] add [ParentSourceGuid]  nchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'DataSourceOwner')
BEGIN
    print 'Altered: DataSourceOwner ,HiveActive';
    alter table [DataSourceOwner] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'DataSourceOwner')
BEGIN
    print 'Altered: DataSourceOwner ,HiveConnectionName';
    alter table [DataSourceOwner] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'DataSourceOwner')
BEGIN
    print 'Altered: DataSourceOwner ,RepoName';
    alter table [DataSourceOwner] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'DataSourceOwner')
BEGIN
    print 'Altered: DataSourceOwner ,RepoSvrName';
    alter table [DataSourceOwner] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'DataSourceOwner')
BEGIN
    print 'Altered: DataSourceOwner ,RowCreationDate';
    alter table [DataSourceOwner] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'DataSourceOwner')
BEGIN
    print 'Altered: DataSourceOwner ,RowGuid';
    alter table [DataSourceOwner] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'DataSourceOwner')
BEGIN
    print 'Altered: DataSourceOwner ,RowLastModDate';
    alter table [DataSourceOwner] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SourceGuid' and table_name = 'DataSourceOwner')
BEGIN
    print 'Altered: DataSourceOwner ,SourceGuid';
    alter table [DataSourceOwner] add [SourceGuid]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'DataSourceOwner')
BEGIN
    print 'Altered: DataSourceOwner ,UserID';
    alter table [DataSourceOwner] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CreateDate' and table_name = 'DataSourceRestoreHistory')
BEGIN
    print 'Altered: DataSourceRestoreHistory ,CreateDate';
    alter table [DataSourceRestoreHistory] add [CreateDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'DataSourceOwnerUserID' and table_name = 'DataSourceRestoreHistory')
BEGIN
    print 'Altered: DataSourceRestoreHistory ,DataSourceOwnerUserID';
    alter table [DataSourceRestoreHistory] add [DataSourceOwnerUserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'DocumentName' and table_name = 'DataSourceRestoreHistory')
BEGIN
    print 'Altered: DataSourceRestoreHistory ,DocumentName';
    alter table [DataSourceRestoreHistory] add [DocumentName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FQN' and table_name = 'DataSourceRestoreHistory')
BEGIN
    print 'Altered: DataSourceRestoreHistory ,FQN';
    alter table [DataSourceRestoreHistory] add [FQN]  nvarchar (500)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'DataSourceRestoreHistory')
BEGIN
    print 'Altered: DataSourceRestoreHistory ,HiveActive';
    alter table [DataSourceRestoreHistory] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'DataSourceRestoreHistory')
BEGIN
    print 'Altered: DataSourceRestoreHistory ,HiveConnectionName';
    alter table [DataSourceRestoreHistory] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'OrigCrc' and table_name = 'DataSourceRestoreHistory')
BEGIN
    print 'Altered: DataSourceRestoreHistory ,OrigCrc';
    alter table [DataSourceRestoreHistory] add [OrigCrc]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'DataSourceRestoreHistory')
BEGIN
    print 'Altered: DataSourceRestoreHistory ,RepoName';
    alter table [DataSourceRestoreHistory] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'DataSourceRestoreHistory')
BEGIN
    print 'Altered: DataSourceRestoreHistory ,RepoSvrName';
    alter table [DataSourceRestoreHistory] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RestoreCrc' and table_name = 'DataSourceRestoreHistory')
BEGIN
    print 'Altered: DataSourceRestoreHistory ,RestoreCrc';
    alter table [DataSourceRestoreHistory] add [RestoreCrc]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RestoreDate' and table_name = 'DataSourceRestoreHistory')
BEGIN
    print 'Altered: DataSourceRestoreHistory ,RestoreDate';
    alter table [DataSourceRestoreHistory] add [RestoreDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RestoredToMachine' and table_name = 'DataSourceRestoreHistory')
BEGIN
    print 'Altered: DataSourceRestoreHistory ,RestoredToMachine';
    alter table [DataSourceRestoreHistory] add [RestoredToMachine]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RestoreUserDomain' and table_name = 'DataSourceRestoreHistory')
BEGIN
    print 'Altered: DataSourceRestoreHistory ,RestoreUserDomain';
    alter table [DataSourceRestoreHistory] add [RestoreUserDomain]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RestoreUserID' and table_name = 'DataSourceRestoreHistory')
BEGIN
    print 'Altered: DataSourceRestoreHistory ,RestoreUserID';
    alter table [DataSourceRestoreHistory] add [RestoreUserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RestoreUserName' and table_name = 'DataSourceRestoreHistory')
BEGIN
    print 'Altered: DataSourceRestoreHistory ,RestoreUserName';
    alter table [DataSourceRestoreHistory] add [RestoreUserName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'DataSourceRestoreHistory')
BEGIN
    print 'Altered: DataSourceRestoreHistory ,RowCreationDate';
    alter table [DataSourceRestoreHistory] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'DataSourceRestoreHistory')
BEGIN
    print 'Altered: DataSourceRestoreHistory ,RowGuid';
    alter table [DataSourceRestoreHistory] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'DataSourceRestoreHistory')
BEGIN
    print 'Altered: DataSourceRestoreHistory ,RowLastModDate';
    alter table [DataSourceRestoreHistory] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SeqNo' and table_name = 'DataSourceRestoreHistory')
BEGIN
    print 'Altered: DataSourceRestoreHistory ,SeqNo';
    alter table [DataSourceRestoreHistory] add [SeqNo]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SourceGuid' and table_name = 'DataSourceRestoreHistory')
BEGIN
    print 'Altered: DataSourceRestoreHistory ,SourceGuid';
    alter table [DataSourceRestoreHistory] add [SourceGuid]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'TypeContentCode' and table_name = 'DataSourceRestoreHistory')
BEGIN
    print 'Altered: DataSourceRestoreHistory ,TypeContentCode';
    alter table [DataSourceRestoreHistory] add [TypeContentCode]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'VerifiedData' and table_name = 'DataSourceRestoreHistory')
BEGIN
    print 'Altered: DataSourceRestoreHistory ,VerifiedData';
    alter table [DataSourceRestoreHistory] add [VerifiedData]  nchar (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Definition' and table_name = 'DataTypeCodes')
BEGIN
    print 'Altered: DataTypeCodes ,Definition';
    alter table [DataTypeCodes] add [Definition]  nvarchar (255)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FileType' and table_name = 'DataTypeCodes')
BEGIN
    print 'Altered: DataTypeCodes ,FileType';
    alter table [DataTypeCodes] add [FileType]  nvarchar (255)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'DataTypeCodes')
BEGIN
    print 'Altered: DataTypeCodes ,HiveActive';
    alter table [DataTypeCodes] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'DataTypeCodes')
BEGIN
    print 'Altered: DataTypeCodes ,HiveConnectionName';
    alter table [DataTypeCodes] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Publisher' and table_name = 'DataTypeCodes')
BEGIN
    print 'Altered: DataTypeCodes ,Publisher';
    alter table [DataTypeCodes] add [Publisher]  nvarchar (255)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'DataTypeCodes')
BEGIN
    print 'Altered: DataTypeCodes ,RepoName';
    alter table [DataTypeCodes] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'DataTypeCodes')
BEGIN
    print 'Altered: DataTypeCodes ,RepoSvrName';
    alter table [DataTypeCodes] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'DataTypeCodes')
BEGIN
    print 'Altered: DataTypeCodes ,RowCreationDate';
    alter table [DataTypeCodes] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'DataTypeCodes')
BEGIN
    print 'Altered: DataTypeCodes ,RowGuid';
    alter table [DataTypeCodes] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'DataTypeCodes')
BEGIN
    print 'Altered: DataTypeCodes ,RowLastModDate';
    alter table [DataTypeCodes] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'VerNbr' and table_name = 'DataTypeCodes')
BEGIN
    print 'Altered: DataTypeCodes ,VerNbr';
    alter table [DataTypeCodes] add [VerNbr]  nvarchar (255)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CompanyID' and table_name = 'DB_UpdateHist')
BEGIN
    print 'Altered: DB_UpdateHist ,CompanyID';
    alter table [DB_UpdateHist] add [CompanyID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CreateDate' and table_name = 'DB_UpdateHist')
BEGIN
    print 'Altered: DB_UpdateHist ,CreateDate';
    alter table [DB_UpdateHist] add [CreateDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'DBName' and table_name = 'DB_UpdateHist')
BEGIN
    print 'Altered: DB_UpdateHist ,DBName';
    alter table [DB_UpdateHist] add [DBName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FixID' and table_name = 'DB_UpdateHist')
BEGIN
    print 'Altered: DB_UpdateHist ,FixID';
    alter table [DB_UpdateHist] add [FixID]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'DB_UpdateHist')
BEGIN
    print 'Altered: DB_UpdateHist ,HiveActive';
    alter table [DB_UpdateHist] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'DB_UpdateHist')
BEGIN
    print 'Altered: DB_UpdateHist ,HiveConnectionName';
    alter table [DB_UpdateHist] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'MachineName' and table_name = 'DB_UpdateHist')
BEGIN
    print 'Altered: DB_UpdateHist ,MachineName';
    alter table [DB_UpdateHist] add [MachineName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'DB_UpdateHist')
BEGIN
    print 'Altered: DB_UpdateHist ,RepoName';
    alter table [DB_UpdateHist] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'DB_UpdateHist')
BEGIN
    print 'Altered: DB_UpdateHist ,RepoSvrName';
    alter table [DB_UpdateHist] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'DB_UpdateHist')
BEGIN
    print 'Altered: DB_UpdateHist ,RowCreationDate';
    alter table [DB_UpdateHist] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'DB_UpdateHist')
BEGIN
    print 'Altered: DB_UpdateHist ,RowGuid';
    alter table [DB_UpdateHist] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'DB_UpdateHist')
BEGIN
    print 'Altered: DB_UpdateHist ,RowLastModDate';
    alter table [DB_UpdateHist] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Status' and table_name = 'DB_UpdateHist')
BEGIN
    print 'Altered: DB_UpdateHist ,Status';
    alter table [DB_UpdateHist] add [Status]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Applied' and table_name = 'DB_Updates')
BEGIN
    print 'Altered: DB_Updates ,Applied';
    alter table [DB_Updates] add [Applied]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'AppliedDate' and table_name = 'DB_Updates')
BEGIN
    print 'Altered: DB_Updates ,AppliedDate';
    alter table [DB_Updates] add [AppliedDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CompanyID' and table_name = 'DB_Updates')
BEGIN
    print 'Altered: DB_Updates ,CompanyID';
    alter table [DB_Updates] add [CompanyID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CreateDate' and table_name = 'DB_Updates')
BEGIN
    print 'Altered: DB_Updates ,CreateDate';
    alter table [DB_Updates] add [CreateDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'DBName' and table_name = 'DB_Updates')
BEGIN
    print 'Altered: DB_Updates ,DBName';
    alter table [DB_Updates] add [DBName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FixDescription' and table_name = 'DB_Updates')
BEGIN
    print 'Altered: DB_Updates ,FixDescription';
    alter table [DB_Updates] add [FixDescription]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FixID' and table_name = 'DB_Updates')
BEGIN
    print 'Altered: DB_Updates ,FixID';
    alter table [DB_Updates] add [FixID]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'DB_Updates')
BEGIN
    print 'Altered: DB_Updates ,HiveActive';
    alter table [DB_Updates] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'DB_Updates')
BEGIN
    print 'Altered: DB_Updates ,HiveConnectionName';
    alter table [DB_Updates] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'MachineName' and table_name = 'DB_Updates')
BEGIN
    print 'Altered: DB_Updates ,MachineName';
    alter table [DB_Updates] add [MachineName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'DB_Updates')
BEGIN
    print 'Altered: DB_Updates ,RepoName';
    alter table [DB_Updates] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'DB_Updates')
BEGIN
    print 'Altered: DB_Updates ,RepoSvrName';
    alter table [DB_Updates] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'DB_Updates')
BEGIN
    print 'Altered: DB_Updates ,RowCreationDate';
    alter table [DB_Updates] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'DB_Updates')
BEGIN
    print 'Altered: DB_Updates ,RowGuid';
    alter table [DB_Updates] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'DB_Updates')
BEGIN
    print 'Altered: DB_Updates ,RowLastModDate';
    alter table [DB_Updates] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SqlStmt' and table_name = 'DB_Updates')
BEGIN
    print 'Altered: DB_Updates ,SqlStmt';
    alter table [DB_Updates] add [SqlStmt]  nvarchar (max)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FromEmailAddr' and table_name = 'DeleteFrom')
BEGIN
    print 'Altered: DeleteFrom ,FromEmailAddr';
    alter table [DeleteFrom] add [FromEmailAddr]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'DeleteFrom')
BEGIN
    print 'Altered: DeleteFrom ,HiveActive';
    alter table [DeleteFrom] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'DeleteFrom')
BEGIN
    print 'Altered: DeleteFrom ,HiveConnectionName';
    alter table [DeleteFrom] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'DeleteFrom')
BEGIN
    print 'Altered: DeleteFrom ,RepoName';
    alter table [DeleteFrom] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'DeleteFrom')
BEGIN
    print 'Altered: DeleteFrom ,RepoSvrName';
    alter table [DeleteFrom] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'DeleteFrom')
BEGIN
    print 'Altered: DeleteFrom ,RowCreationDate';
    alter table [DeleteFrom] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'DeleteFrom')
BEGIN
    print 'Altered: DeleteFrom ,RowGuid';
    alter table [DeleteFrom] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'DeleteFrom')
BEGIN
    print 'Altered: DeleteFrom ,RowLastModDate';
    alter table [DeleteFrom] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SenderName' and table_name = 'DeleteFrom')
BEGIN
    print 'Altered: DeleteFrom ,SenderName';
    alter table [DeleteFrom] add [SenderName]  varchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'DeleteFrom')
BEGIN
    print 'Altered: DeleteFrom ,UserID';
    alter table [DeleteFrom] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'DirOwnerUserID' and table_name = 'DirArchLib')
BEGIN
    print 'Altered: DirArchLib ,DirOwnerUserID';
    alter table [DirArchLib] add [DirOwnerUserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FQN' and table_name = 'DirArchLib')
BEGIN
    print 'Altered: DirArchLib ,FQN';
    alter table [DirArchLib] add [FQN]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LibOwnerUserID' and table_name = 'DirArchLib')
BEGIN
    print 'Altered: DirArchLib ,LibOwnerUserID';
    alter table [DirArchLib] add [LibOwnerUserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LibraryName' and table_name = 'DirArchLib')
BEGIN
    print 'Altered: DirArchLib ,LibraryName';
    alter table [DirArchLib] add [LibraryName]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'DirArchLib')
BEGIN
    print 'Altered: DirArchLib ,RepoName';
    alter table [DirArchLib] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'DirArchLib')
BEGIN
    print 'Altered: DirArchLib ,RowGuid';
    alter table [DirArchLib] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'AdminDisabled' and table_name = 'Directory')
BEGIN
    print 'Altered: Directory ,AdminDisabled';
    alter table [Directory] add [AdminDisabled]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ArchiveSkipBit' and table_name = 'Directory')
BEGIN
    print 'Altered: Directory ,ArchiveSkipBit';
    alter table [Directory] add [ArchiveSkipBit]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ckDisableDir' and table_name = 'Directory')
BEGIN
    print 'Altered: Directory ,ckDisableDir';
    alter table [Directory] add [ckDisableDir]  nchar (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ckMetaData' and table_name = 'Directory')
BEGIN
    print 'Altered: Directory ,ckMetaData';
    alter table [Directory] add [ckMetaData]  nchar (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ckPublic' and table_name = 'Directory')
BEGIN
    print 'Altered: Directory ,ckPublic';
    alter table [Directory] add [ckPublic]  nchar (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'DB_ID' and table_name = 'Directory')
BEGIN
    print 'Altered: Directory ,DB_ID';
    alter table [Directory] add [DB_ID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'DeleteOnArchive' and table_name = 'Directory')
BEGIN
    print 'Altered: Directory ,DeleteOnArchive';
    alter table [Directory] add [DeleteOnArchive]  nchar (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'DirGuid' and table_name = 'Directory')
BEGIN
    print 'Altered: Directory ,DirGuid';
    alter table [Directory] add [DirGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FQN' and table_name = 'Directory')
BEGIN
    print 'Altered: Directory ,FQN';
    alter table [Directory] add [FQN]  varchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'Directory')
BEGIN
    print 'Altered: Directory ,HiveActive';
    alter table [Directory] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'Directory')
BEGIN
    print 'Altered: Directory ,HiveConnectionName';
    alter table [Directory] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'IncludeSubDirs' and table_name = 'Directory')
BEGIN
    print 'Altered: Directory ,IncludeSubDirs';
    alter table [Directory] add [IncludeSubDirs]  char (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'isMappedDrive' and table_name = 'Directory')
BEGIN
    print 'Altered: Directory ,isMappedDrive';
    alter table [Directory] add [isMappedDrive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'isNetworkDrive' and table_name = 'Directory')
BEGIN
    print 'Altered: Directory ,isNetworkDrive';
    alter table [Directory] add [isNetworkDrive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'isServerDirectory' and table_name = 'Directory')
BEGIN
    print 'Altered: Directory ,isServerDirectory';
    alter table [Directory] add [isServerDirectory]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'isSysDefault' and table_name = 'Directory')
BEGIN
    print 'Altered: Directory ,isSysDefault';
    alter table [Directory] add [isSysDefault]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ListenDirectory' and table_name = 'Directory')
BEGIN
    print 'Altered: Directory ,ListenDirectory';
    alter table [Directory] add [ListenDirectory]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ListenForChanges' and table_name = 'Directory')
BEGIN
    print 'Altered: Directory ,ListenForChanges';
    alter table [Directory] add [ListenForChanges]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ListenSubDirectory' and table_name = 'Directory')
BEGIN
    print 'Altered: Directory ,ListenSubDirectory';
    alter table [Directory] add [ListenSubDirectory]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'OcrDirectory' and table_name = 'Directory')
BEGIN
    print 'Altered: Directory ,OcrDirectory';
    alter table [Directory] add [OcrDirectory]  nchar (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'OcrPdf' and table_name = 'Directory')
BEGIN
    print 'Altered: Directory ,OcrPdf';
    alter table [Directory] add [OcrPdf]  nchar (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'QuickRefEntry' and table_name = 'Directory')
BEGIN
    print 'Altered: Directory ,QuickRefEntry';
    alter table [Directory] add [QuickRefEntry]  char (10)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'Directory')
BEGIN
    print 'Altered: Directory ,RepoName';
    alter table [Directory] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'Directory')
BEGIN
    print 'Altered: Directory ,RepoSvrName';
    alter table [Directory] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RequiresAuthentication' and table_name = 'Directory')
BEGIN
    print 'Altered: Directory ,RequiresAuthentication';
    alter table [Directory] add [RequiresAuthentication]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RetentionCode' and table_name = 'Directory')
BEGIN
    print 'Altered: Directory ,RetentionCode';
    alter table [Directory] add [RetentionCode]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'Directory')
BEGIN
    print 'Altered: Directory ,RowCreationDate';
    alter table [Directory] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'Directory')
BEGIN
    print 'Altered: Directory ,RowGuid';
    alter table [Directory] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'Directory')
BEGIN
    print 'Altered: Directory ,RowLastModDate';
    alter table [Directory] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'Directory')
BEGIN
    print 'Altered: Directory ,UserID';
    alter table [Directory] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'VersionFiles' and table_name = 'Directory')
BEGIN
    print 'Altered: Directory ,VersionFiles';
    alter table [Directory] add [VersionFiles]  char (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'DirFQN' and table_name = 'DirectoryGuids')
BEGIN
    print 'Altered: DirectoryGuids ,DirFQN';
    alter table [DirectoryGuids] add [DirFQN]  varchar (800)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'DirGuid' and table_name = 'DirectoryGuids')
BEGIN
    print 'Altered: DirectoryGuids ,DirGuid';
    alter table [DirectoryGuids] add [DirGuid]  nchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'DirectoryGuids')
BEGIN
    print 'Altered: DirectoryGuids ,HiveActive';
    alter table [DirectoryGuids] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'DirectoryGuids')
BEGIN
    print 'Altered: DirectoryGuids ,HiveConnectionName';
    alter table [DirectoryGuids] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'DirectoryGuids')
BEGIN
    print 'Altered: DirectoryGuids ,RepoName';
    alter table [DirectoryGuids] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'DirectoryGuids')
BEGIN
    print 'Altered: DirectoryGuids ,RepoSvrName';
    alter table [DirectoryGuids] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'DirectoryGuids')
BEGIN
    print 'Altered: DirectoryGuids ,RowCreationDate';
    alter table [DirectoryGuids] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'DirectoryGuids')
BEGIN
    print 'Altered: DirectoryGuids ,RowGuid';
    alter table [DirectoryGuids] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'DirectoryGuids')
BEGIN
    print 'Altered: DirectoryGuids ,RowLastModDate';
    alter table [DirectoryGuids] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'AdminDisabled' and table_name = 'DirectoryListener')
BEGIN
    print 'Altered: DirectoryListener ,AdminDisabled';
    alter table [DirectoryListener] add [AdminDisabled]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'DirGuid' and table_name = 'DirectoryListener')
BEGIN
    print 'Altered: DirectoryListener ,DirGuid';
    alter table [DirectoryListener] add [DirGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'DirectoryListener')
BEGIN
    print 'Altered: DirectoryListener ,HiveActive';
    alter table [DirectoryListener] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'DirectoryListener')
BEGIN
    print 'Altered: DirectoryListener ,HiveConnectionName';
    alter table [DirectoryListener] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ListenDirectory' and table_name = 'DirectoryListener')
BEGIN
    print 'Altered: DirectoryListener ,ListenDirectory';
    alter table [DirectoryListener] add [ListenDirectory]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ListenerActive' and table_name = 'DirectoryListener')
BEGIN
    print 'Altered: DirectoryListener ,ListenerActive';
    alter table [DirectoryListener] add [ListenerActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ListenerLoaded' and table_name = 'DirectoryListener')
BEGIN
    print 'Altered: DirectoryListener ,ListenerLoaded';
    alter table [DirectoryListener] add [ListenerLoaded]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ListenerPaused' and table_name = 'DirectoryListener')
BEGIN
    print 'Altered: DirectoryListener ,ListenerPaused';
    alter table [DirectoryListener] add [ListenerPaused]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ListenSubDirectory' and table_name = 'DirectoryListener')
BEGIN
    print 'Altered: DirectoryListener ,ListenSubDirectory';
    alter table [DirectoryListener] add [ListenSubDirectory]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'MachineName' and table_name = 'DirectoryListener')
BEGIN
    print 'Altered: DirectoryListener ,MachineName';
    alter table [DirectoryListener] add [MachineName]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'DirectoryListener')
BEGIN
    print 'Altered: DirectoryListener ,RepoName';
    alter table [DirectoryListener] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'DirectoryListener')
BEGIN
    print 'Altered: DirectoryListener ,RepoSvrName';
    alter table [DirectoryListener] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'DirectoryListener')
BEGIN
    print 'Altered: DirectoryListener ,RowCreationDate';
    alter table [DirectoryListener] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'DirectoryListener')
BEGIN
    print 'Altered: DirectoryListener ,RowGuid';
    alter table [DirectoryListener] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'DirectoryListener')
BEGIN
    print 'Altered: DirectoryListener ,RowLastModDate';
    alter table [DirectoryListener] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'DirectoryListener')
BEGIN
    print 'Altered: DirectoryListener ,UserID';
    alter table [DirectoryListener] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Archived' and table_name = 'DirectoryListenerFiles')
BEGIN
    print 'Altered: DirectoryListenerFiles ,Archived';
    alter table [DirectoryListenerFiles] add [Archived]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'DirGuid' and table_name = 'DirectoryListenerFiles')
BEGIN
    print 'Altered: DirectoryListenerFiles ,DirGuid';
    alter table [DirectoryListenerFiles] add [DirGuid]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'EntryDate' and table_name = 'DirectoryListenerFiles')
BEGIN
    print 'Altered: DirectoryListenerFiles ,EntryDate';
    alter table [DirectoryListenerFiles] add [EntryDate]  date; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'DirectoryListenerFiles')
BEGIN
    print 'Altered: DirectoryListenerFiles ,HiveActive';
    alter table [DirectoryListenerFiles] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'DirectoryListenerFiles')
BEGIN
    print 'Altered: DirectoryListenerFiles ,HiveConnectionName';
    alter table [DirectoryListenerFiles] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'MachineName' and table_name = 'DirectoryListenerFiles')
BEGIN
    print 'Altered: DirectoryListenerFiles ,MachineName';
    alter table [DirectoryListenerFiles] add [MachineName]  varchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'NameHash' and table_name = 'DirectoryListenerFiles')
BEGIN
    print 'Altered: DirectoryListenerFiles ,NameHash';
    alter table [DirectoryListenerFiles] add [NameHash]  decimal; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'DirectoryListenerFiles')
BEGIN
    print 'Altered: DirectoryListenerFiles ,RepoName';
    alter table [DirectoryListenerFiles] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'DirectoryListenerFiles')
BEGIN
    print 'Altered: DirectoryListenerFiles ,RepoSvrName';
    alter table [DirectoryListenerFiles] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'DirectoryListenerFiles')
BEGIN
    print 'Altered: DirectoryListenerFiles ,RowCreationDate';
    alter table [DirectoryListenerFiles] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'DirectoryListenerFiles')
BEGIN
    print 'Altered: DirectoryListenerFiles ,RowGuid';
    alter table [DirectoryListenerFiles] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'DirectoryListenerFiles')
BEGIN
    print 'Altered: DirectoryListenerFiles ,RowLastModDate';
    alter table [DirectoryListenerFiles] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SourceFile' and table_name = 'DirectoryListenerFiles')
BEGIN
    print 'Altered: DirectoryListenerFiles ,SourceFile';
    alter table [DirectoryListenerFiles] add [SourceFile]  varchar (720)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'DirectoryListenerFiles')
BEGIN
    print 'Altered: DirectoryListenerFiles ,UserID';
    alter table [DirectoryListenerFiles] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'DIRHASH' and table_name = 'DirectoryLongName')
BEGIN
    print 'Altered: DirectoryLongName ,DIRHASH';
    alter table [DirectoryLongName] add [DIRHASH]  varchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'DirLongName' and table_name = 'DirectoryLongName')
BEGIN
    print 'Altered: DirectoryLongName ,DirLongName';
    alter table [DirectoryLongName] add [DirLongName]  nvarchar (max)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'DirLongNameID' and table_name = 'DirectoryLongName')
BEGIN
    print 'Altered: DirectoryLongName ,DirLongNameID';
    alter table [DirectoryLongName] add [DirLongNameID]  varchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'DirectoryLongName')
BEGIN
    print 'Altered: DirectoryLongName ,RepoName';
    alter table [DirectoryLongName] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'DirectoryLongName')
BEGIN
    print 'Altered: DirectoryLongName ,RowGuid';
    alter table [DirectoryLongName] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'AccessDate' and table_name = 'DirectoryMonitorLog')
BEGIN
    print 'Altered: DirectoryMonitorLog ,AccessDate';
    alter table [DirectoryMonitorLog] add [AccessDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'AccessedBy' and table_name = 'DirectoryMonitorLog')
BEGIN
    print 'Altered: DirectoryMonitorLog ,AccessedBy';
    alter table [DirectoryMonitorLog] add [AccessedBy]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CreateDate' and table_name = 'DirectoryMonitorLog')
BEGIN
    print 'Altered: DirectoryMonitorLog ,CreateDate';
    alter table [DirectoryMonitorLog] add [CreateDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'DirFQN' and table_name = 'DirectoryMonitorLog')
BEGIN
    print 'Altered: DirectoryMonitorLog ,DirFQN';
    alter table [DirectoryMonitorLog] add [DirFQN]  nvarchar (2000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FileFQN' and table_name = 'DirectoryMonitorLog')
BEGIN
    print 'Altered: DirectoryMonitorLog ,FileFQN';
    alter table [DirectoryMonitorLog] add [FileFQN]  nvarchar (250)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'DirectoryMonitorLog')
BEGIN
    print 'Altered: DirectoryMonitorLog ,RepoName';
    alter table [DirectoryMonitorLog] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'DirectoryMonitorLog')
BEGIN
    print 'Altered: DirectoryMonitorLog ,RowGuid';
    alter table [DirectoryMonitorLog] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'TypeAccess' and table_name = 'DirectoryMonitorLog')
BEGIN
    print 'Altered: DirectoryMonitorLog ,TypeAccess';
    alter table [DirectoryMonitorLog] add [TypeAccess]  nvarchar (20)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CurrUserGuidId' and table_name = 'DirectoryTemp')
BEGIN
    print 'Altered: DirectoryTemp ,CurrUserGuidId';
    alter table [DirectoryTemp] add [CurrUserGuidId]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'DirFQN' and table_name = 'DirectoryTemp')
BEGIN
    print 'Altered: DirectoryTemp ,DirFQN';
    alter table [DirectoryTemp] add [DirFQN]  nvarchar (300)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'DirectoryTemp')
BEGIN
    print 'Altered: DirectoryTemp ,HiveActive';
    alter table [DirectoryTemp] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'DirectoryTemp')
BEGIN
    print 'Altered: DirectoryTemp ,HiveConnectionName';
    alter table [DirectoryTemp] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'MachineID' and table_name = 'DirectoryTemp')
BEGIN
    print 'Altered: DirectoryTemp ,MachineID';
    alter table [DirectoryTemp] add [MachineID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'DirectoryTemp')
BEGIN
    print 'Altered: DirectoryTemp ,RepoName';
    alter table [DirectoryTemp] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'DirectoryTemp')
BEGIN
    print 'Altered: DirectoryTemp ,RepoSvrName';
    alter table [DirectoryTemp] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'DirectoryTemp')
BEGIN
    print 'Altered: DirectoryTemp ,RowCreationDate';
    alter table [DirectoryTemp] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'DirectoryTemp')
BEGIN
    print 'Altered: DirectoryTemp ,RowGuid';
    alter table [DirectoryTemp] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'DirectoryTemp')
BEGIN
    print 'Altered: DirectoryTemp ,RowLastModDate';
    alter table [DirectoryTemp] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SkipDir' and table_name = 'DirectoryTemp')
BEGIN
    print 'Altered: DirectoryTemp ,SkipDir';
    alter table [DirectoryTemp] add [SkipDir]  char (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'DirectoryTemp')
BEGIN
    print 'Altered: DirectoryTemp ,UserID';
    alter table [DirectoryTemp] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'DirProfiles')
BEGIN
    print 'Altered: DirProfiles ,HiveActive';
    alter table [DirProfiles] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'DirProfiles')
BEGIN
    print 'Altered: DirProfiles ,HiveConnectionName';
    alter table [DirProfiles] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Parms' and table_name = 'DirProfiles')
BEGIN
    print 'Altered: DirProfiles ,Parms';
    alter table [DirProfiles] add [Parms]  nvarchar (max)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ProfileName' and table_name = 'DirProfiles')
BEGIN
    print 'Altered: DirProfiles ,ProfileName';
    alter table [DirProfiles] add [ProfileName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'DirProfiles')
BEGIN
    print 'Altered: DirProfiles ,RepoName';
    alter table [DirProfiles] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'DirProfiles')
BEGIN
    print 'Altered: DirProfiles ,RepoSvrName';
    alter table [DirProfiles] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'DirProfiles')
BEGIN
    print 'Altered: DirProfiles ,RowCreationDate';
    alter table [DirProfiles] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'DirProfiles')
BEGIN
    print 'Altered: DirProfiles ,RowGuid';
    alter table [DirProfiles] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'DirProfiles')
BEGIN
    print 'Altered: DirProfiles ,RowLastModDate';
    alter table [DirProfiles] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ContentType' and table_name = 'DuplicateContent')
BEGIN
    print 'Altered: DuplicateContent ,ContentType';
    alter table [DuplicateContent] add [ContentType]  char (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ContentUniqueName' and table_name = 'DuplicateContent')
BEGIN
    print 'Altered: DuplicateContent ,ContentUniqueName';
    alter table [DuplicateContent] add [ContentUniqueName]  varchar (900)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Guids' and table_name = 'DuplicateContent')
BEGIN
    print 'Altered: DuplicateContent ,Guids';
    alter table [DuplicateContent] add [Guids]  varchar (max)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HashID' and table_name = 'DuplicateContent')
BEGIN
    print 'Altered: DuplicateContent ,HashID';
    alter table [DuplicateContent] add [HashID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Occurances' and table_name = 'DuplicateContent')
BEGIN
    print 'Altered: DuplicateContent ,Occurances';
    alter table [DuplicateContent] add [Occurances]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'DuplicateContent')
BEGIN
    print 'Altered: DuplicateContent ,RepoName';
    alter table [DuplicateContent] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'DuplicateContent')
BEGIN
    print 'Altered: DuplicateContent ,RowGuid';
    alter table [DuplicateContent] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Authority' and table_name = 'EcmUser')
BEGIN
    print 'Altered: EcmUser ,Authority';
    alter table [EcmUser] add [Authority]  nchar (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CompanyID' and table_name = 'EcmUser')
BEGIN
    print 'Altered: EcmUser ,CompanyID';
    alter table [EcmUser] add [CompanyID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CreateDate' and table_name = 'EcmUser')
BEGIN
    print 'Altered: EcmUser ,CreateDate';
    alter table [EcmUser] add [CreateDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'EMail' and table_name = 'EcmUser')
BEGIN
    print 'Altered: EcmUser ,EMail';
    alter table [EcmUser] add [EMail]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'EcmUser')
BEGIN
    print 'Altered: EcmUser ,HiveActive';
    alter table [EcmUser] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'EcmUser')
BEGIN
    print 'Altered: EcmUser ,HiveConnectionName';
    alter table [EcmUser] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LastUpdate' and table_name = 'EcmUser')
BEGIN
    print 'Altered: EcmUser ,LastUpdate';
    alter table [EcmUser] add [LastUpdate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'PassWord' and table_name = 'EcmUser')
BEGIN
    print 'Altered: EcmUser ,PassWord';
    alter table [EcmUser] add [PassWord]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'PhoneNumber' and table_name = 'EcmUser')
BEGIN
    print 'Altered: EcmUser ,PhoneNumber';
    alter table [EcmUser] add [PhoneNumber]  nvarchar (20)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'EcmUser')
BEGIN
    print 'Altered: EcmUser ,RepoName';
    alter table [EcmUser] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'EcmUser')
BEGIN
    print 'Altered: EcmUser ,RepoSvrName';
    alter table [EcmUser] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'EcmUser')
BEGIN
    print 'Altered: EcmUser ,RowCreationDate';
    alter table [EcmUser] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'EcmUser')
BEGIN
    print 'Altered: EcmUser ,RowGuid';
    alter table [EcmUser] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'EcmUser')
BEGIN
    print 'Altered: EcmUser ,RowLastModDate';
    alter table [EcmUser] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'YourCompany' and table_name = 'EcmUser')
BEGIN
    print 'Altered: EcmUser ,YourCompany';
    alter table [EcmUser] add [YourCompany]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'YourName' and table_name = 'EcmUser')
BEGIN
    print 'Altered: EcmUser ,YourName';
    alter table [EcmUser] add [YourName]  nvarchar (100)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Accounts' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,Accounts';
    alter table [Email] add [Accounts]  nvarchar (2000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'AllRecipients' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,AllRecipients';
    alter table [Email] add [AllRecipients]  nvarchar (max)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Bcc' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,Bcc';
    alter table [Email] add [Bcc]  nvarchar (max)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'BillingInformation' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,BillingInformation';
    alter table [Email] add [BillingInformation]  nvarchar (200)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Body' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,Body';
    alter table [Email] add [Body]  text; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'BPS' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,BPS';
    alter table [Email] add [BPS]  float; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CC' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,CC';
    alter table [Email] add [CC]  nvarchar (max)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Companies' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,Companies';
    alter table [Email] add [Companies]  nvarchar (2000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CompressedSize' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,CompressedSize';
    alter table [Email] add [CompressedSize]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ContainsAttachment' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,ContainsAttachment';
    alter table [Email] add [ContainsAttachment]  char (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ConvertEmlToMSG' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,ConvertEmlToMSG';
    alter table [Email] add [ConvertEmlToMSG]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CRC' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,CRC';
    alter table [Email] add [CRC]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CreationDate' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,CreationDate';
    alter table [Email] add [CreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CreationTime' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,CreationTime';
    alter table [Email] add [CreationTime]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CurrMailFolderID' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,CurrMailFolderID';
    alter table [Email] add [CurrMailFolderID]  nvarchar (300)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'DeferredDeliveryTime' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,DeferredDeliveryTime';
    alter table [Email] add [DeferredDeliveryTime]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Description' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,Description';
    alter table [Email] add [Description]  nvarchar (max)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'EmailGuid' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,EmailGuid';
    alter table [Email] add [EmailGuid]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'EmailIdentifier' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,EmailIdentifier';
    alter table [Email] add [EmailIdentifier]  nvarchar (450)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'EmailImage' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,EmailImage';
    alter table [Email] add [EmailImage]  varbinary; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'EntryID' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,EntryID';
    alter table [Email] add [EntryID]  varchar (150)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ExpiryTime' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,ExpiryTime';
    alter table [Email] add [ExpiryTime]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FileAttached' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,FileAttached';
    alter table [Email] add [FileAttached]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HashFile' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,HashFile';
    alter table [Email] add [HashFile]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HashName' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,HashName';
    alter table [Email] add [HashName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,HiveActive';
    alter table [Email] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,HiveConnectionName';
    alter table [Email] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'isAvailable' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,isAvailable';
    alter table [Email] add [isAvailable]  nchar (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'isMaster' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,isMaster';
    alter table [Email] add [isMaster]  nchar (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'isPerm' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,isPerm';
    alter table [Email] add [isPerm]  nchar (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'isPublic' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,isPublic';
    alter table [Email] add [isPublic]  nchar (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'IsPublicPreviousState' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,IsPublicPreviousState';
    alter table [Email] add [IsPublicPreviousState]  nchar (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'KeyWords' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,KeyWords';
    alter table [Email] add [KeyWords]  nvarchar (2000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LastModificationTime' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,LastModificationTime';
    alter table [Email] add [LastModificationTime]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'MachineID' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,MachineID';
    alter table [Email] add [MachineID]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'MsgSize' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,MsgSize';
    alter table [Email] add [MsgSize]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'NbrAttachment' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,NbrAttachment';
    alter table [Email] add [NbrAttachment]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'NbrAttachments' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,NbrAttachments';
    alter table [Email] add [NbrAttachments]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'NbrOccurances' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,NbrOccurances';
    alter table [Email] add [NbrOccurances]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'NbrZipFiles' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,NbrZipFiles';
    alter table [Email] add [NbrZipFiles]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'NbrZipFilesCnt' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,NbrZipFilesCnt';
    alter table [Email] add [NbrZipFilesCnt]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'notes' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,notes';
    alter table [Email] add [notes]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'OriginalFolder' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,OriginalFolder';
    alter table [Email] add [OriginalFolder]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'OriginalSize' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,OriginalSize';
    alter table [Email] add [OriginalSize]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'PdfImages' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,PdfImages';
    alter table [Email] add [PdfImages]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'PdfIsSearchable' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,PdfIsSearchable';
    alter table [Email] add [PdfIsSearchable]  char (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'PdfOcrRequired' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,PdfOcrRequired';
    alter table [Email] add [PdfOcrRequired]  char (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'PdfOcrSuccess' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,PdfOcrSuccess';
    alter table [Email] add [PdfOcrSuccess]  char (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'PdfOcrTextExtracted' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,PdfOcrTextExtracted';
    alter table [Email] add [PdfOcrTextExtracted]  char (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'PdfPages' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,PdfPages';
    alter table [Email] add [PdfPages]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ReadReceiptRequested' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,ReadReceiptRequested';
    alter table [Email] add [ReadReceiptRequested]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ReceivedByName' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,ReceivedByName';
    alter table [Email] add [ReceivedByName]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ReceivedTime' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,ReceivedTime';
    alter table [Email] add [ReceivedTime]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RecHash' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,RecHash';
    alter table [Email] add [RecHash]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RecLen' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,RecLen';
    alter table [Email] add [RecLen]  float; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,RepoName';
    alter table [Email] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,RepoSvrName';
    alter table [Email] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RetentionCode' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,RetentionCode';
    alter table [Email] add [RetentionCode]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RetentionExpirationDate' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,RetentionExpirationDate';
    alter table [Email] add [RetentionExpirationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,RowCreationDate';
    alter table [Email] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,RowGuid';
    alter table [Email] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowID' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,RowID';
    alter table [Email] add [RowID]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,RowLastModDate';
    alter table [Email] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SenderEmailAddress' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,SenderEmailAddress';
    alter table [Email] add [SenderEmailAddress]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SenderName' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,SenderName';
    alter table [Email] add [SenderName]  nvarchar (100)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Sensitivity' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,Sensitivity';
    alter table [Email] add [Sensitivity]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SentOn' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,SentOn';
    alter table [Email] add [SentOn]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SentTO' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,SentTO';
    alter table [Email] add [SentTO]  nvarchar (max)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ShortSubj' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,ShortSubj';
    alter table [Email] add [ShortSubj]  nvarchar (250)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SourceTypeCode' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,SourceTypeCode';
    alter table [Email] add [SourceTypeCode]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'StoreID' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,StoreID';
    alter table [Email] add [StoreID]  varchar (750)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SUBJECT' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,SUBJECT';
    alter table [Email] add [SUBJECT]  nvarchar (2000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'TransmitTime' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,TransmitTime';
    alter table [Email] add [TransmitTime]  float; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'txEndTime' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,txEndTime';
    alter table [Email] add [txEndTime]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'txStartTime' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,txStartTime';
    alter table [Email] add [txStartTime]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'txTotalTime' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,txTotalTime';
    alter table [Email] add [txTotalTime]  float; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UIDL' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,UIDL';
    alter table [Email] add [UIDL]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'Email')
BEGIN
    print 'Altered: Email ,UserID';
    alter table [Email] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ArchiveAfterXDays' and table_name = 'EmailArchParms')
BEGIN
    print 'Altered: EmailArchParms ,ArchiveAfterXDays';
    alter table [EmailArchParms] add [ArchiveAfterXDays]  char (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ArchiveEmails' and table_name = 'EmailArchParms')
BEGIN
    print 'Altered: EmailArchParms ,ArchiveEmails';
    alter table [EmailArchParms] add [ArchiveEmails]  char (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ArchiveOnlyIfRead' and table_name = 'EmailArchParms')
BEGIN
    print 'Altered: EmailArchParms ,ArchiveOnlyIfRead';
    alter table [EmailArchParms] add [ArchiveOnlyIfRead]  nchar (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ArchiveXDays' and table_name = 'EmailArchParms')
BEGIN
    print 'Altered: EmailArchParms ,ArchiveXDays';
    alter table [EmailArchParms] add [ArchiveXDays]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ContainerName' and table_name = 'EmailArchParms')
BEGIN
    print 'Altered: EmailArchParms ,ContainerName';
    alter table [EmailArchParms] add [ContainerName]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'DB_ID' and table_name = 'EmailArchParms')
BEGIN
    print 'Altered: EmailArchParms ,DB_ID';
    alter table [EmailArchParms] add [DB_ID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FolderName' and table_name = 'EmailArchParms')
BEGIN
    print 'Altered: EmailArchParms ,FolderName';
    alter table [EmailArchParms] add [FolderName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'EmailArchParms')
BEGIN
    print 'Altered: EmailArchParms ,HiveActive';
    alter table [EmailArchParms] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'EmailArchParms')
BEGIN
    print 'Altered: EmailArchParms ,HiveConnectionName';
    alter table [EmailArchParms] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'isSysDefault' and table_name = 'EmailArchParms')
BEGIN
    print 'Altered: EmailArchParms ,isSysDefault';
    alter table [EmailArchParms] add [isSysDefault]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'MachineName' and table_name = 'EmailArchParms')
BEGIN
    print 'Altered: EmailArchParms ,MachineName';
    alter table [EmailArchParms] add [MachineName]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'nRowID' and table_name = 'EmailArchParms')
BEGIN
    print 'Altered: EmailArchParms ,nRowID';
    alter table [EmailArchParms] add [nRowID]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RemoveAfterArchive' and table_name = 'EmailArchParms')
BEGIN
    print 'Altered: EmailArchParms ,RemoveAfterArchive';
    alter table [EmailArchParms] add [RemoveAfterArchive]  char (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RemoveAfterXDays' and table_name = 'EmailArchParms')
BEGIN
    print 'Altered: EmailArchParms ,RemoveAfterXDays';
    alter table [EmailArchParms] add [RemoveAfterXDays]  char (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RemoveXDays' and table_name = 'EmailArchParms')
BEGIN
    print 'Altered: EmailArchParms ,RemoveXDays';
    alter table [EmailArchParms] add [RemoveXDays]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'EmailArchParms')
BEGIN
    print 'Altered: EmailArchParms ,RepoName';
    alter table [EmailArchParms] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'EmailArchParms')
BEGIN
    print 'Altered: EmailArchParms ,RepoSvrName';
    alter table [EmailArchParms] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'EmailArchParms')
BEGIN
    print 'Altered: EmailArchParms ,RowCreationDate';
    alter table [EmailArchParms] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'EmailArchParms')
BEGIN
    print 'Altered: EmailArchParms ,RowGuid';
    alter table [EmailArchParms] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'EmailArchParms')
BEGIN
    print 'Altered: EmailArchParms ,RowLastModDate';
    alter table [EmailArchParms] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SetAsDefaultFolder' and table_name = 'EmailArchParms')
BEGIN
    print 'Altered: EmailArchParms ,SetAsDefaultFolder';
    alter table [EmailArchParms] add [SetAsDefaultFolder]  char (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'EmailArchParms')
BEGIN
    print 'Altered: EmailArchParms ,UserID';
    alter table [EmailArchParms] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Attachment' and table_name = 'EmailAttachment')
BEGIN
    print 'Altered: EmailAttachment ,Attachment';
    alter table [EmailAttachment] add [Attachment]  varbinary; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'AttachmentCode' and table_name = 'EmailAttachment')
BEGIN
    print 'Altered: EmailAttachment ,AttachmentCode';
    alter table [EmailAttachment] add [AttachmentCode]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'AttachmentLength' and table_name = 'EmailAttachment')
BEGIN
    print 'Altered: EmailAttachment ,AttachmentLength';
    alter table [EmailAttachment] add [AttachmentLength]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'AttachmentName' and table_name = 'EmailAttachment')
BEGIN
    print 'Altered: EmailAttachment ,AttachmentName';
    alter table [EmailAttachment] add [AttachmentName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'AttachmentType' and table_name = 'EmailAttachment')
BEGIN
    print 'Altered: EmailAttachment ,AttachmentType';
    alter table [EmailAttachment] add [AttachmentType]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'BPS' and table_name = 'EmailAttachment')
BEGIN
    print 'Altered: EmailAttachment ,BPS';
    alter table [EmailAttachment] add [BPS]  float; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CompressedSize' and table_name = 'EmailAttachment')
BEGIN
    print 'Altered: EmailAttachment ,CompressedSize';
    alter table [EmailAttachment] add [CompressedSize]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CRC' and table_name = 'EmailAttachment')
BEGIN
    print 'Altered: EmailAttachment ,CRC';
    alter table [EmailAttachment] add [CRC]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CreateDate' and table_name = 'EmailAttachment')
BEGIN
    print 'Altered: EmailAttachment ,CreateDate';
    alter table [EmailAttachment] add [CreateDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'EmailGuid' and table_name = 'EmailAttachment')
BEGIN
    print 'Altered: EmailAttachment ,EmailGuid';
    alter table [EmailAttachment] add [EmailGuid]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FileAttached' and table_name = 'EmailAttachment')
BEGIN
    print 'Altered: EmailAttachment ,FileAttached';
    alter table [EmailAttachment] add [FileAttached]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'EmailAttachment')
BEGIN
    print 'Altered: EmailAttachment ,HiveActive';
    alter table [EmailAttachment] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'EmailAttachment')
BEGIN
    print 'Altered: EmailAttachment ,HiveConnectionName';
    alter table [EmailAttachment] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'isPublic' and table_name = 'EmailAttachment')
BEGIN
    print 'Altered: EmailAttachment ,isPublic';
    alter table [EmailAttachment] add [isPublic]  char (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'isZipFileEntry' and table_name = 'EmailAttachment')
BEGIN
    print 'Altered: EmailAttachment ,isZipFileEntry';
    alter table [EmailAttachment] add [isZipFileEntry]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'MachineID' and table_name = 'EmailAttachment')
BEGIN
    print 'Altered: EmailAttachment ,MachineID';
    alter table [EmailAttachment] add [MachineID]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'OcrPending' and table_name = 'EmailAttachment')
BEGIN
    print 'Altered: EmailAttachment ,OcrPending';
    alter table [EmailAttachment] add [OcrPending]  char (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'OcrPerformed' and table_name = 'EmailAttachment')
BEGIN
    print 'Altered: EmailAttachment ,OcrPerformed';
    alter table [EmailAttachment] add [OcrPerformed]  char (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'OcrSuccessful' and table_name = 'EmailAttachment')
BEGIN
    print 'Altered: EmailAttachment ,OcrSuccessful';
    alter table [EmailAttachment] add [OcrSuccessful]  char (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'OcrText' and table_name = 'EmailAttachment')
BEGIN
    print 'Altered: EmailAttachment ,OcrText';
    alter table [EmailAttachment] add [OcrText]  nvarchar (max)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'OriginalFileTypeCode' and table_name = 'EmailAttachment')
BEGIN
    print 'Altered: EmailAttachment ,OriginalFileTypeCode';
    alter table [EmailAttachment] add [OriginalFileTypeCode]  nvarchar (20)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'OriginalSize' and table_name = 'EmailAttachment')
BEGIN
    print 'Altered: EmailAttachment ,OriginalSize';
    alter table [EmailAttachment] add [OriginalSize]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ParentGuid' and table_name = 'EmailAttachment')
BEGIN
    print 'Altered: EmailAttachment ,ParentGuid';
    alter table [EmailAttachment] add [ParentGuid]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'PdfImages' and table_name = 'EmailAttachment')
BEGIN
    print 'Altered: EmailAttachment ,PdfImages';
    alter table [EmailAttachment] add [PdfImages]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'PdfIsSearchable' and table_name = 'EmailAttachment')
BEGIN
    print 'Altered: EmailAttachment ,PdfIsSearchable';
    alter table [EmailAttachment] add [PdfIsSearchable]  char (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'PdfOcrRequired' and table_name = 'EmailAttachment')
BEGIN
    print 'Altered: EmailAttachment ,PdfOcrRequired';
    alter table [EmailAttachment] add [PdfOcrRequired]  char (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'PdfOcrSuccess' and table_name = 'EmailAttachment')
BEGIN
    print 'Altered: EmailAttachment ,PdfOcrSuccess';
    alter table [EmailAttachment] add [PdfOcrSuccess]  char (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'PdfOcrTextExtracted' and table_name = 'EmailAttachment')
BEGIN
    print 'Altered: EmailAttachment ,PdfOcrTextExtracted';
    alter table [EmailAttachment] add [PdfOcrTextExtracted]  char (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'PdfPages' and table_name = 'EmailAttachment')
BEGIN
    print 'Altered: EmailAttachment ,PdfPages';
    alter table [EmailAttachment] add [PdfPages]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RecHash' and table_name = 'EmailAttachment')
BEGIN
    print 'Altered: EmailAttachment ,RecHash';
    alter table [EmailAttachment] add [RecHash]  varchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RecLen' and table_name = 'EmailAttachment')
BEGIN
    print 'Altered: EmailAttachment ,RecLen';
    alter table [EmailAttachment] add [RecLen]  float; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'EmailAttachment')
BEGIN
    print 'Altered: EmailAttachment ,RepoName';
    alter table [EmailAttachment] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'EmailAttachment')
BEGIN
    print 'Altered: EmailAttachment ,RepoSvrName';
    alter table [EmailAttachment] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RequireOcr' and table_name = 'EmailAttachment')
BEGIN
    print 'Altered: EmailAttachment ,RequireOcr';
    alter table [EmailAttachment] add [RequireOcr]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RetentionCode' and table_name = 'EmailAttachment')
BEGIN
    print 'Altered: EmailAttachment ,RetentionCode';
    alter table [EmailAttachment] add [RetentionCode]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RetentionExpirationDate' and table_name = 'EmailAttachment')
BEGIN
    print 'Altered: EmailAttachment ,RetentionExpirationDate';
    alter table [EmailAttachment] add [RetentionExpirationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'EmailAttachment')
BEGIN
    print 'Altered: EmailAttachment ,RowCreationDate';
    alter table [EmailAttachment] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'EmailAttachment')
BEGIN
    print 'Altered: EmailAttachment ,RowGuid';
    alter table [EmailAttachment] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowID' and table_name = 'EmailAttachment')
BEGIN
    print 'Altered: EmailAttachment ,RowID';
    alter table [EmailAttachment] add [RowID]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'EmailAttachment')
BEGIN
    print 'Altered: EmailAttachment ,RowLastModDate';
    alter table [EmailAttachment] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'TransmitTime' and table_name = 'EmailAttachment')
BEGIN
    print 'Altered: EmailAttachment ,TransmitTime';
    alter table [EmailAttachment] add [TransmitTime]  float; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'txEndTime' and table_name = 'EmailAttachment')
BEGIN
    print 'Altered: EmailAttachment ,txEndTime';
    alter table [EmailAttachment] add [txEndTime]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'txStartTime' and table_name = 'EmailAttachment')
BEGIN
    print 'Altered: EmailAttachment ,txStartTime';
    alter table [EmailAttachment] add [txStartTime]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'txTotalTime' and table_name = 'EmailAttachment')
BEGIN
    print 'Altered: EmailAttachment ,txTotalTime';
    alter table [EmailAttachment] add [txTotalTime]  float; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'EmailAttachment')
BEGIN
    print 'Altered: EmailAttachment ,UserID';
    alter table [EmailAttachment] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'EmailGuid' and table_name = 'EmailAttachmentSearchList')
BEGIN
    print 'Altered: EmailAttachmentSearchList ,EmailGuid';
    alter table [EmailAttachmentSearchList] add [EmailGuid]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'EmailAttachmentSearchList')
BEGIN
    print 'Altered: EmailAttachmentSearchList ,HiveActive';
    alter table [EmailAttachmentSearchList] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'EmailAttachmentSearchList')
BEGIN
    print 'Altered: EmailAttachmentSearchList ,HiveConnectionName';
    alter table [EmailAttachmentSearchList] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'EmailAttachmentSearchList')
BEGIN
    print 'Altered: EmailAttachmentSearchList ,RepoName';
    alter table [EmailAttachmentSearchList] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'EmailAttachmentSearchList')
BEGIN
    print 'Altered: EmailAttachmentSearchList ,RepoSvrName';
    alter table [EmailAttachmentSearchList] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'EmailAttachmentSearchList')
BEGIN
    print 'Altered: EmailAttachmentSearchList ,RowCreationDate';
    alter table [EmailAttachmentSearchList] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'EmailAttachmentSearchList')
BEGIN
    print 'Altered: EmailAttachmentSearchList ,RowGuid';
    alter table [EmailAttachmentSearchList] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowID' and table_name = 'EmailAttachmentSearchList')
BEGIN
    print 'Altered: EmailAttachmentSearchList ,RowID';
    alter table [EmailAttachmentSearchList] add [RowID]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'EmailAttachmentSearchList')
BEGIN
    print 'Altered: EmailAttachmentSearchList ,RowLastModDate';
    alter table [EmailAttachmentSearchList] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'EmailAttachmentSearchList')
BEGIN
    print 'Altered: EmailAttachmentSearchList ,UserID';
    alter table [EmailAttachmentSearchList] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Weight' and table_name = 'EmailAttachmentSearchList')
BEGIN
    print 'Altered: EmailAttachmentSearchList ,Weight';
    alter table [EmailAttachmentSearchList] add [Weight]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ContainerName' and table_name = 'EmailFolder')
BEGIN
    print 'Altered: EmailFolder ,ContainerName';
    alter table [EmailFolder] add [ContainerName]  varchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FolderID' and table_name = 'EmailFolder')
BEGIN
    print 'Altered: EmailFolder ,FolderID';
    alter table [EmailFolder] add [FolderID]  varchar (100)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FolderName' and table_name = 'EmailFolder')
BEGIN
    print 'Altered: EmailFolder ,FolderName';
    alter table [EmailFolder] add [FolderName]  varchar (450)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'EmailFolder')
BEGIN
    print 'Altered: EmailFolder ,HiveActive';
    alter table [EmailFolder] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'EmailFolder')
BEGIN
    print 'Altered: EmailFolder ,HiveConnectionName';
    alter table [EmailFolder] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'isSysDefault' and table_name = 'EmailFolder')
BEGIN
    print 'Altered: EmailFolder ,isSysDefault';
    alter table [EmailFolder] add [isSysDefault]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'MachineName' and table_name = 'EmailFolder')
BEGIN
    print 'Altered: EmailFolder ,MachineName';
    alter table [EmailFolder] add [MachineName]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'nRowID' and table_name = 'EmailFolder')
BEGIN
    print 'Altered: EmailFolder ,nRowID';
    alter table [EmailFolder] add [nRowID]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ParentFolderID' and table_name = 'EmailFolder')
BEGIN
    print 'Altered: EmailFolder ,ParentFolderID';
    alter table [EmailFolder] add [ParentFolderID]  varchar (100)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ParentFolderName' and table_name = 'EmailFolder')
BEGIN
    print 'Altered: EmailFolder ,ParentFolderName';
    alter table [EmailFolder] add [ParentFolderName]  varchar (200)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'EmailFolder')
BEGIN
    print 'Altered: EmailFolder ,RepoName';
    alter table [EmailFolder] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'EmailFolder')
BEGIN
    print 'Altered: EmailFolder ,RepoSvrName';
    alter table [EmailFolder] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RetentionCode' and table_name = 'EmailFolder')
BEGIN
    print 'Altered: EmailFolder ,RetentionCode';
    alter table [EmailFolder] add [RetentionCode]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'EmailFolder')
BEGIN
    print 'Altered: EmailFolder ,RowCreationDate';
    alter table [EmailFolder] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'EmailFolder')
BEGIN
    print 'Altered: EmailFolder ,RowGuid';
    alter table [EmailFolder] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'EmailFolder')
BEGIN
    print 'Altered: EmailFolder ,RowLastModDate';
    alter table [EmailFolder] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SelectedForArchive' and table_name = 'EmailFolder')
BEGIN
    print 'Altered: EmailFolder ,SelectedForArchive';
    alter table [EmailFolder] add [SelectedForArchive]  char (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'StoreID' and table_name = 'EmailFolder')
BEGIN
    print 'Altered: EmailFolder ,StoreID';
    alter table [EmailFolder] add [StoreID]  varchar (600)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'EmailFolder')
BEGIN
    print 'Altered: EmailFolder ,UserID';
    alter table [EmailFolder] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Ord' and table_name = 'EmailRunningTotal')
BEGIN
    print 'Altered: EmailRunningTotal ,Ord';
    alter table [EmailRunningTotal] add [Ord]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Period' and table_name = 'EmailRunningTotal')
BEGIN
    print 'Altered: EmailRunningTotal ,Period';
    alter table [EmailRunningTotal] add [Period]  varchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'PeriodVal' and table_name = 'EmailRunningTotal')
BEGIN
    print 'Altered: EmailRunningTotal ,PeriodVal';
    alter table [EmailRunningTotal] add [PeriodVal]  float; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'EmailRunningTotal')
BEGIN
    print 'Altered: EmailRunningTotal ,RepoName';
    alter table [EmailRunningTotal] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'EmailRunningTotal')
BEGIN
    print 'Altered: EmailRunningTotal ,RowGuid';
    alter table [EmailRunningTotal] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RunningTotal' and table_name = 'EmailRunningTotal')
BEGIN
    print 'Altered: EmailRunningTotal ,RunningTotal';
    alter table [EmailRunningTotal] add [RunningTotal]  float; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Total' and table_name = 'EmailRunningTotal')
BEGIN
    print 'Altered: EmailRunningTotal ,Total';
    alter table [EmailRunningTotal] add [Total]  float; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'YR' and table_name = 'EmailRunningTotal')
BEGIN
    print 'Altered: EmailRunningTotal ,YR';
    alter table [EmailRunningTotal] add [YR]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'EmailGuid' and table_name = 'EmailToDelete')
BEGIN
    print 'Altered: EmailToDelete ,EmailGuid';
    alter table [EmailToDelete] add [EmailGuid]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'EmailToDelete')
BEGIN
    print 'Altered: EmailToDelete ,HiveActive';
    alter table [EmailToDelete] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'EmailToDelete')
BEGIN
    print 'Altered: EmailToDelete ,HiveConnectionName';
    alter table [EmailToDelete] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'MessageID' and table_name = 'EmailToDelete')
BEGIN
    print 'Altered: EmailToDelete ,MessageID';
    alter table [EmailToDelete] add [MessageID]  nchar (100)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'EmailToDelete')
BEGIN
    print 'Altered: EmailToDelete ,RepoName';
    alter table [EmailToDelete] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'EmailToDelete')
BEGIN
    print 'Altered: EmailToDelete ,RepoSvrName';
    alter table [EmailToDelete] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'EmailToDelete')
BEGIN
    print 'Altered: EmailToDelete ,RowCreationDate';
    alter table [EmailToDelete] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'EmailToDelete')
BEGIN
    print 'Altered: EmailToDelete ,RowGuid';
    alter table [EmailToDelete] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'EmailToDelete')
BEGIN
    print 'Altered: EmailToDelete ,RowLastModDate';
    alter table [EmailToDelete] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'StoreID' and table_name = 'EmailToDelete')
BEGIN
    print 'Altered: EmailToDelete ,StoreID';
    alter table [EmailToDelete] add [StoreID]  nvarchar (500)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'EmailToDelete')
BEGIN
    print 'Altered: EmailToDelete ,UserID';
    alter table [EmailToDelete] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'EntryDate' and table_name = 'ErrorLogs')
BEGIN
    print 'Altered: ErrorLogs ,EntryDate';
    alter table [ErrorLogs] add [EntryDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'EntryUserID' and table_name = 'ErrorLogs')
BEGIN
    print 'Altered: ErrorLogs ,EntryUserID';
    alter table [ErrorLogs] add [EntryUserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LoggedMessage' and table_name = 'ErrorLogs')
BEGIN
    print 'Altered: ErrorLogs ,LoggedMessage';
    alter table [ErrorLogs] add [LoggedMessage]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LogName' and table_name = 'ErrorLogs')
BEGIN
    print 'Altered: ErrorLogs ,LogName';
    alter table [ErrorLogs] add [LogName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'ErrorLogs')
BEGIN
    print 'Altered: ErrorLogs ,RepoName';
    alter table [ErrorLogs] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'ErrorLogs')
BEGIN
    print 'Altered: ErrorLogs ,RowGuid';
    alter table [ErrorLogs] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowNbr' and table_name = 'ErrorLogs')
BEGIN
    print 'Altered: ErrorLogs ,RowNbr';
    alter table [ErrorLogs] add [RowNbr]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Severity' and table_name = 'ErrorLogs')
BEGIN
    print 'Altered: ErrorLogs ,Severity';
    alter table [ErrorLogs] add [Severity]  nvarchar (10)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'InsertDate' and table_name = 'ExcgKey')
BEGIN
    print 'Altered: ExcgKey ,InsertDate';
    alter table [ExcgKey] add [InsertDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'MailKey' and table_name = 'ExcgKey')
BEGIN
    print 'Altered: ExcgKey ,MailKey';
    alter table [ExcgKey] add [MailKey]  varchar (500)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'ExcgKey')
BEGIN
    print 'Altered: ExcgKey ,RepoName';
    alter table [ExcgKey] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'ExcgKey')
BEGIN
    print 'Altered: ExcgKey ,RowGuid';
    alter table [ExcgKey] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ConvertEmlToMSG' and table_name = 'ExchangeHostPop')
BEGIN
    print 'Altered: ExchangeHostPop ,ConvertEmlToMSG';
    alter table [ExchangeHostPop] add [ConvertEmlToMSG]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'DaysToHold' and table_name = 'ExchangeHostPop')
BEGIN
    print 'Altered: ExchangeHostPop ,DaysToHold';
    alter table [ExchangeHostPop] add [DaysToHold]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'DeleteAfterDownload' and table_name = 'ExchangeHostPop')
BEGIN
    print 'Altered: ExchangeHostPop ,DeleteAfterDownload';
    alter table [ExchangeHostPop] add [DeleteAfterDownload]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FolderName' and table_name = 'ExchangeHostPop')
BEGIN
    print 'Altered: ExchangeHostPop ,FolderName';
    alter table [ExchangeHostPop] add [FolderName]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'ExchangeHostPop')
BEGIN
    print 'Altered: ExchangeHostPop ,HiveActive';
    alter table [ExchangeHostPop] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'ExchangeHostPop')
BEGIN
    print 'Altered: ExchangeHostPop ,HiveConnectionName';
    alter table [ExchangeHostPop] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HostNameIp' and table_name = 'ExchangeHostPop')
BEGIN
    print 'Altered: ExchangeHostPop ,HostNameIp';
    alter table [ExchangeHostPop] add [HostNameIp]  nvarchar (100)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'IMap' and table_name = 'ExchangeHostPop')
BEGIN
    print 'Altered: ExchangeHostPop ,IMap';
    alter table [ExchangeHostPop] add [IMap]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'isPublic' and table_name = 'ExchangeHostPop')
BEGIN
    print 'Altered: ExchangeHostPop ,isPublic';
    alter table [ExchangeHostPop] add [isPublic]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LibraryName' and table_name = 'ExchangeHostPop')
BEGIN
    print 'Altered: ExchangeHostPop ,LibraryName';
    alter table [ExchangeHostPop] add [LibraryName]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LoginPw' and table_name = 'ExchangeHostPop')
BEGIN
    print 'Altered: ExchangeHostPop ,LoginPw';
    alter table [ExchangeHostPop] add [LoginPw]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'PortNbr' and table_name = 'ExchangeHostPop')
BEGIN
    print 'Altered: ExchangeHostPop ,PortNbr';
    alter table [ExchangeHostPop] add [PortNbr]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'ExchangeHostPop')
BEGIN
    print 'Altered: ExchangeHostPop ,RepoName';
    alter table [ExchangeHostPop] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'ExchangeHostPop')
BEGIN
    print 'Altered: ExchangeHostPop ,RepoSvrName';
    alter table [ExchangeHostPop] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RetentionCode' and table_name = 'ExchangeHostPop')
BEGIN
    print 'Altered: ExchangeHostPop ,RetentionCode';
    alter table [ExchangeHostPop] add [RetentionCode]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'ExchangeHostPop')
BEGIN
    print 'Altered: ExchangeHostPop ,RowCreationDate';
    alter table [ExchangeHostPop] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'ExchangeHostPop')
BEGIN
    print 'Altered: ExchangeHostPop ,RowGuid';
    alter table [ExchangeHostPop] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'ExchangeHostPop')
BEGIN
    print 'Altered: ExchangeHostPop ,RowLastModDate';
    alter table [ExchangeHostPop] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SSL' and table_name = 'ExchangeHostPop')
BEGIN
    print 'Altered: ExchangeHostPop ,SSL';
    alter table [ExchangeHostPop] add [SSL]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'strReject' and table_name = 'ExchangeHostPop')
BEGIN
    print 'Altered: ExchangeHostPop ,strReject';
    alter table [ExchangeHostPop] add [strReject]  nvarchar (250)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Userid' and table_name = 'ExchangeHostPop')
BEGIN
    print 'Altered: ExchangeHostPop ,Userid';
    alter table [ExchangeHostPop] add [Userid]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserLoginID' and table_name = 'ExchangeHostPop')
BEGIN
    print 'Altered: ExchangeHostPop ,UserLoginID';
    alter table [ExchangeHostPop] add [UserLoginID]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'DisplayName' and table_name = 'ExchangeHostSmtp')
BEGIN
    print 'Altered: ExchangeHostSmtp ,DisplayName';
    alter table [ExchangeHostSmtp] add [DisplayName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'ExchangeHostSmtp')
BEGIN
    print 'Altered: ExchangeHostSmtp ,HiveActive';
    alter table [ExchangeHostSmtp] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'ExchangeHostSmtp')
BEGIN
    print 'Altered: ExchangeHostSmtp ,HiveConnectionName';
    alter table [ExchangeHostSmtp] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HostNameIp' and table_name = 'ExchangeHostSmtp')
BEGIN
    print 'Altered: ExchangeHostSmtp ,HostNameIp';
    alter table [ExchangeHostSmtp] add [HostNameIp]  nvarchar (100)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LoginPw' and table_name = 'ExchangeHostSmtp')
BEGIN
    print 'Altered: ExchangeHostSmtp ,LoginPw';
    alter table [ExchangeHostSmtp] add [LoginPw]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'ExchangeHostSmtp')
BEGIN
    print 'Altered: ExchangeHostSmtp ,RepoName';
    alter table [ExchangeHostSmtp] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'ExchangeHostSmtp')
BEGIN
    print 'Altered: ExchangeHostSmtp ,RepoSvrName';
    alter table [ExchangeHostSmtp] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'ExchangeHostSmtp')
BEGIN
    print 'Altered: ExchangeHostSmtp ,RowCreationDate';
    alter table [ExchangeHostSmtp] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'ExchangeHostSmtp')
BEGIN
    print 'Altered: ExchangeHostSmtp ,RowGuid';
    alter table [ExchangeHostSmtp] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'ExchangeHostSmtp')
BEGIN
    print 'Altered: ExchangeHostSmtp ,RowLastModDate';
    alter table [ExchangeHostSmtp] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserLoginID' and table_name = 'ExchangeHostSmtp')
BEGIN
    print 'Altered: ExchangeHostSmtp ,UserLoginID';
    alter table [ExchangeHostSmtp] add [UserLoginID]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ExtCode' and table_name = 'ExcludedFiles')
BEGIN
    print 'Altered: ExcludedFiles ,ExtCode';
    alter table [ExcludedFiles] add [ExtCode]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FQN' and table_name = 'ExcludedFiles')
BEGIN
    print 'Altered: ExcludedFiles ,FQN';
    alter table [ExcludedFiles] add [FQN]  varchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'ExcludedFiles')
BEGIN
    print 'Altered: ExcludedFiles ,HiveActive';
    alter table [ExcludedFiles] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'ExcludedFiles')
BEGIN
    print 'Altered: ExcludedFiles ,HiveConnectionName';
    alter table [ExcludedFiles] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'ExcludedFiles')
BEGIN
    print 'Altered: ExcludedFiles ,RepoName';
    alter table [ExcludedFiles] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'ExcludedFiles')
BEGIN
    print 'Altered: ExcludedFiles ,RepoSvrName';
    alter table [ExcludedFiles] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'ExcludedFiles')
BEGIN
    print 'Altered: ExcludedFiles ,RowCreationDate';
    alter table [ExcludedFiles] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'ExcludedFiles')
BEGIN
    print 'Altered: ExcludedFiles ,RowGuid';
    alter table [ExcludedFiles] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'ExcludedFiles')
BEGIN
    print 'Altered: ExcludedFiles ,RowLastModDate';
    alter table [ExcludedFiles] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'ExcludedFiles')
BEGIN
    print 'Altered: ExcludedFiles ,UserID';
    alter table [ExcludedFiles] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FromEmailAddr' and table_name = 'ExcludeFrom')
BEGIN
    print 'Altered: ExcludeFrom ,FromEmailAddr';
    alter table [ExcludeFrom] add [FromEmailAddr]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'ExcludeFrom')
BEGIN
    print 'Altered: ExcludeFrom ,HiveActive';
    alter table [ExcludeFrom] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'ExcludeFrom')
BEGIN
    print 'Altered: ExcludeFrom ,HiveConnectionName';
    alter table [ExcludeFrom] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'ExcludeFrom')
BEGIN
    print 'Altered: ExcludeFrom ,RepoName';
    alter table [ExcludeFrom] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'ExcludeFrom')
BEGIN
    print 'Altered: ExcludeFrom ,RepoSvrName';
    alter table [ExcludeFrom] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'ExcludeFrom')
BEGIN
    print 'Altered: ExcludeFrom ,RowCreationDate';
    alter table [ExcludeFrom] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'ExcludeFrom')
BEGIN
    print 'Altered: ExcludeFrom ,RowGuid';
    alter table [ExcludeFrom] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'ExcludeFrom')
BEGIN
    print 'Altered: ExcludeFrom ,RowLastModDate';
    alter table [ExcludeFrom] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SenderName' and table_name = 'ExcludeFrom')
BEGIN
    print 'Altered: ExcludeFrom ,SenderName';
    alter table [ExcludeFrom] add [SenderName]  varchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'ExcludeFrom')
BEGIN
    print 'Altered: ExcludeFrom ,UserID';
    alter table [ExcludeFrom] add [UserID]  varchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FileKey' and table_name = 'FileKey')
BEGIN
    print 'Altered: FileKey ,FileKey';
    alter table [FileKey] add [FileKey]  nvarchar (300)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'FileKey')
BEGIN
    print 'Altered: FileKey ,HiveActive';
    alter table [FileKey] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'FileKey')
BEGIN
    print 'Altered: FileKey ,HiveConnectionName';
    alter table [FileKey] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'FileKey')
BEGIN
    print 'Altered: FileKey ,RepoName';
    alter table [FileKey] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'FileKey')
BEGIN
    print 'Altered: FileKey ,RepoSvrName';
    alter table [FileKey] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'FileKey')
BEGIN
    print 'Altered: FileKey ,RowCreationDate';
    alter table [FileKey] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'FileKey')
BEGIN
    print 'Altered: FileKey ,RowGuid';
    alter table [FileKey] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'FileKey')
BEGIN
    print 'Altered: FileKey ,RowLastModDate';
    alter table [FileKey] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SourceGuid' and table_name = 'FileKey')
BEGIN
    print 'Altered: FileKey ,SourceGuid';
    alter table [FileKey] add [SourceGuid]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FileKey' and table_name = 'FileKeyMachine')
BEGIN
    print 'Altered: FileKeyMachine ,FileKey';
    alter table [FileKeyMachine] add [FileKey]  nvarchar (300)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'FileKeyMachine')
BEGIN
    print 'Altered: FileKeyMachine ,HiveActive';
    alter table [FileKeyMachine] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'FileKeyMachine')
BEGIN
    print 'Altered: FileKeyMachine ,HiveConnectionName';
    alter table [FileKeyMachine] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Machine' and table_name = 'FileKeyMachine')
BEGIN
    print 'Altered: FileKeyMachine ,Machine';
    alter table [FileKeyMachine] add [Machine]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'FileKeyMachine')
BEGIN
    print 'Altered: FileKeyMachine ,RepoName';
    alter table [FileKeyMachine] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'FileKeyMachine')
BEGIN
    print 'Altered: FileKeyMachine ,RepoSvrName';
    alter table [FileKeyMachine] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'FileKeyMachine')
BEGIN
    print 'Altered: FileKeyMachine ,RowCreationDate';
    alter table [FileKeyMachine] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'FileKeyMachine')
BEGIN
    print 'Altered: FileKeyMachine ,RowGuid';
    alter table [FileKeyMachine] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'FileKeyMachine')
BEGIN
    print 'Altered: FileKeyMachine ,RowLastModDate';
    alter table [FileKeyMachine] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Dir' and table_name = 'FileKeyMachineDir')
BEGIN
    print 'Altered: FileKeyMachineDir ,Dir';
    alter table [FileKeyMachineDir] add [Dir]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FileKey' and table_name = 'FileKeyMachineDir')
BEGIN
    print 'Altered: FileKeyMachineDir ,FileKey';
    alter table [FileKeyMachineDir] add [FileKey]  nvarchar (300)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FileKeyMachineDirGuid' and table_name = 'FileKeyMachineDir')
BEGIN
    print 'Altered: FileKeyMachineDir ,FileKeyMachineDirGuid';
    alter table [FileKeyMachineDir] add [FileKeyMachineDirGuid]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HashKey' and table_name = 'FileKeyMachineDir')
BEGIN
    print 'Altered: FileKeyMachineDir ,HashKey';
    alter table [FileKeyMachineDir] add [HashKey]  nvarchar (100)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'FileKeyMachineDir')
BEGIN
    print 'Altered: FileKeyMachineDir ,HiveActive';
    alter table [FileKeyMachineDir] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'FileKeyMachineDir')
BEGIN
    print 'Altered: FileKeyMachineDir ,HiveConnectionName';
    alter table [FileKeyMachineDir] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Machine' and table_name = 'FileKeyMachineDir')
BEGIN
    print 'Altered: FileKeyMachineDir ,Machine';
    alter table [FileKeyMachineDir] add [Machine]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'FileKeyMachineDir')
BEGIN
    print 'Altered: FileKeyMachineDir ,RepoName';
    alter table [FileKeyMachineDir] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'FileKeyMachineDir')
BEGIN
    print 'Altered: FileKeyMachineDir ,RepoSvrName';
    alter table [FileKeyMachineDir] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'FileKeyMachineDir')
BEGIN
    print 'Altered: FileKeyMachineDir ,RowCreationDate';
    alter table [FileKeyMachineDir] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'FileKeyMachineDir')
BEGIN
    print 'Altered: FileKeyMachineDir ,RowGuid';
    alter table [FileKeyMachineDir] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'FileKeyMachineDir')
BEGIN
    print 'Altered: FileKeyMachineDir ,RowLastModDate';
    alter table [FileKeyMachineDir] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FQN' and table_name = 'FilesToDelete')
BEGIN
    print 'Altered: FilesToDelete ,FQN';
    alter table [FilesToDelete] add [FQN]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'FilesToDelete')
BEGIN
    print 'Altered: FilesToDelete ,HiveActive';
    alter table [FilesToDelete] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'FilesToDelete')
BEGIN
    print 'Altered: FilesToDelete ,HiveConnectionName';
    alter table [FilesToDelete] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'MachineName' and table_name = 'FilesToDelete')
BEGIN
    print 'Altered: FilesToDelete ,MachineName';
    alter table [FilesToDelete] add [MachineName]  nvarchar (100)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'PendingDelete' and table_name = 'FilesToDelete')
BEGIN
    print 'Altered: FilesToDelete ,PendingDelete';
    alter table [FilesToDelete] add [PendingDelete]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'FilesToDelete')
BEGIN
    print 'Altered: FilesToDelete ,RepoName';
    alter table [FilesToDelete] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'FilesToDelete')
BEGIN
    print 'Altered: FilesToDelete ,RepoSvrName';
    alter table [FilesToDelete] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'FilesToDelete')
BEGIN
    print 'Altered: FilesToDelete ,RowCreationDate';
    alter table [FilesToDelete] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'FilesToDelete')
BEGIN
    print 'Altered: FilesToDelete ,RowGuid';
    alter table [FilesToDelete] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'FilesToDelete')
BEGIN
    print 'Altered: FilesToDelete ,RowLastModDate';
    alter table [FilesToDelete] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'FilesToDelete')
BEGIN
    print 'Altered: FilesToDelete ,UserID';
    alter table [FilesToDelete] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Description' and table_name = 'FileType')
BEGIN
    print 'Altered: FileType ,Description';
    alter table [FileType] add [Description]  nvarchar (255)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FileExt' and table_name = 'FileType')
BEGIN
    print 'Altered: FileType ,FileExt';
    alter table [FileType] add [FileExt]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'FileType')
BEGIN
    print 'Altered: FileType ,HiveActive';
    alter table [FileType] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'FileType')
BEGIN
    print 'Altered: FileType ,HiveConnectionName';
    alter table [FileType] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'FileType')
BEGIN
    print 'Altered: FileType ,RepoName';
    alter table [FileType] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'FileType')
BEGIN
    print 'Altered: FileType ,RepoSvrName';
    alter table [FileType] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'FileType')
BEGIN
    print 'Altered: FileType ,RowCreationDate';
    alter table [FileType] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'FileType')
BEGIN
    print 'Altered: FileType ,RowGuid';
    alter table [FileType] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'FileType')
BEGIN
    print 'Altered: FileType ,RowLastModDate';
    alter table [FileType] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CorpFuncName' and table_name = 'FUncSkipWords')
BEGIN
    print 'Altered: FUncSkipWords ,CorpFuncName';
    alter table [FUncSkipWords] add [CorpFuncName]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CorpName' and table_name = 'FUncSkipWords')
BEGIN
    print 'Altered: FUncSkipWords ,CorpName';
    alter table [FUncSkipWords] add [CorpName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'FUncSkipWords')
BEGIN
    print 'Altered: FUncSkipWords ,HiveActive';
    alter table [FUncSkipWords] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'FUncSkipWords')
BEGIN
    print 'Altered: FUncSkipWords ,HiveConnectionName';
    alter table [FUncSkipWords] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'FUncSkipWords')
BEGIN
    print 'Altered: FUncSkipWords ,RepoName';
    alter table [FUncSkipWords] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'FUncSkipWords')
BEGIN
    print 'Altered: FUncSkipWords ,RepoSvrName';
    alter table [FUncSkipWords] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'FUncSkipWords')
BEGIN
    print 'Altered: FUncSkipWords ,RowCreationDate';
    alter table [FUncSkipWords] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'FUncSkipWords')
BEGIN
    print 'Altered: FUncSkipWords ,RowGuid';
    alter table [FUncSkipWords] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'FUncSkipWords')
BEGIN
    print 'Altered: FUncSkipWords ,RowLastModDate';
    alter table [FUncSkipWords] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'tgtWord' and table_name = 'FUncSkipWords')
BEGIN
    print 'Altered: FUncSkipWords ,tgtWord';
    alter table [FUncSkipWords] add [tgtWord]  nvarchar (18)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CorpFuncName' and table_name = 'FunctionProdJargon')
BEGIN
    print 'Altered: FunctionProdJargon ,CorpFuncName';
    alter table [FunctionProdJargon] add [CorpFuncName]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CorpName' and table_name = 'FunctionProdJargon')
BEGIN
    print 'Altered: FunctionProdJargon ,CorpName';
    alter table [FunctionProdJargon] add [CorpName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'FunctionProdJargon')
BEGIN
    print 'Altered: FunctionProdJargon ,HiveActive';
    alter table [FunctionProdJargon] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'FunctionProdJargon')
BEGIN
    print 'Altered: FunctionProdJargon ,HiveConnectionName';
    alter table [FunctionProdJargon] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'JargonCode' and table_name = 'FunctionProdJargon')
BEGIN
    print 'Altered: FunctionProdJargon ,JargonCode';
    alter table [FunctionProdJargon] add [JargonCode]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'KeyFlag' and table_name = 'FunctionProdJargon')
BEGIN
    print 'Altered: FunctionProdJargon ,KeyFlag';
    alter table [FunctionProdJargon] add [KeyFlag]  binary (50) ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepeatDataCode' and table_name = 'FunctionProdJargon')
BEGIN
    print 'Altered: FunctionProdJargon ,RepeatDataCode';
    alter table [FunctionProdJargon] add [RepeatDataCode]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'FunctionProdJargon')
BEGIN
    print 'Altered: FunctionProdJargon ,RepoName';
    alter table [FunctionProdJargon] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'FunctionProdJargon')
BEGIN
    print 'Altered: FunctionProdJargon ,RepoSvrName';
    alter table [FunctionProdJargon] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'FunctionProdJargon')
BEGIN
    print 'Altered: FunctionProdJargon ,RowCreationDate';
    alter table [FunctionProdJargon] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'FunctionProdJargon')
BEGIN
    print 'Altered: FunctionProdJargon ,RowGuid';
    alter table [FunctionProdJargon] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'FunctionProdJargon')
BEGIN
    print 'Altered: FunctionProdJargon ,RowLastModDate';
    alter table [FunctionProdJargon] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'DirID' and table_name = 'GlobalAsso')
BEGIN
    print 'Altered: GlobalAsso ,DirID';
    alter table [GlobalAsso] add [DirID]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FileID' and table_name = 'GlobalAsso')
BEGIN
    print 'Altered: GlobalAsso ,FileID';
    alter table [GlobalAsso] add [FileID]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'GlobalAsso')
BEGIN
    print 'Altered: GlobalAsso ,HiveActive';
    alter table [GlobalAsso] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'GlobalAsso')
BEGIN
    print 'Altered: GlobalAsso ,HiveConnectionName';
    alter table [GlobalAsso] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LocationID' and table_name = 'GlobalAsso')
BEGIN
    print 'Altered: GlobalAsso ,LocationID';
    alter table [GlobalAsso] add [LocationID]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'MachineID' and table_name = 'GlobalAsso')
BEGIN
    print 'Altered: GlobalAsso ,MachineID';
    alter table [GlobalAsso] add [MachineID]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'GlobalAsso')
BEGIN
    print 'Altered: GlobalAsso ,RepoName';
    alter table [GlobalAsso] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'GlobalAsso')
BEGIN
    print 'Altered: GlobalAsso ,RepoSvrName';
    alter table [GlobalAsso] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'GlobalAsso')
BEGIN
    print 'Altered: GlobalAsso ,RowCreationDate';
    alter table [GlobalAsso] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'GlobalAsso')
BEGIN
    print 'Altered: GlobalAsso ,RowGuid';
    alter table [GlobalAsso] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'GlobalAsso')
BEGIN
    print 'Altered: GlobalAsso ,RowLastModDate';
    alter table [GlobalAsso] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'GuidID' and table_name = 'GlobalDirectory')
BEGIN
    print 'Altered: GlobalDirectory ,GuidID';
    alter table [GlobalDirectory] add [GuidID]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HashCode' and table_name = 'GlobalDirectory')
BEGIN
    print 'Altered: GlobalDirectory ,HashCode';
    alter table [GlobalDirectory] add [HashCode]  varchar (40)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'GlobalDirectory')
BEGIN
    print 'Altered: GlobalDirectory ,HiveActive';
    alter table [GlobalDirectory] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'GlobalDirectory')
BEGIN
    print 'Altered: GlobalDirectory ,HiveConnectionName';
    alter table [GlobalDirectory] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LocatorID' and table_name = 'GlobalDirectory')
BEGIN
    print 'Altered: GlobalDirectory ,LocatorID';
    alter table [GlobalDirectory] add [LocatorID]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LongName' and table_name = 'GlobalDirectory')
BEGIN
    print 'Altered: GlobalDirectory ,LongName';
    alter table [GlobalDirectory] add [LongName]  nvarchar (2000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'GlobalDirectory')
BEGIN
    print 'Altered: GlobalDirectory ,RepoName';
    alter table [GlobalDirectory] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'GlobalDirectory')
BEGIN
    print 'Altered: GlobalDirectory ,RepoSvrName';
    alter table [GlobalDirectory] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'GlobalDirectory')
BEGIN
    print 'Altered: GlobalDirectory ,RowCreationDate';
    alter table [GlobalDirectory] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'GlobalDirectory')
BEGIN
    print 'Altered: GlobalDirectory ,RowGuid';
    alter table [GlobalDirectory] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'GlobalDirectory')
BEGIN
    print 'Altered: GlobalDirectory ,RowLastModDate';
    alter table [GlobalDirectory] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ShortName' and table_name = 'GlobalDirectory')
BEGIN
    print 'Altered: GlobalDirectory ,ShortName';
    alter table [GlobalDirectory] add [ShortName]  nvarchar (250)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'GuidID' and table_name = 'GlobalEmail')
BEGIN
    print 'Altered: GlobalEmail ,GuidID';
    alter table [GlobalEmail] add [GuidID]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HashCode' and table_name = 'GlobalEmail')
BEGIN
    print 'Altered: GlobalEmail ,HashCode';
    alter table [GlobalEmail] add [HashCode]  varchar (40)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'GlobalEmail')
BEGIN
    print 'Altered: GlobalEmail ,HiveActive';
    alter table [GlobalEmail] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'GlobalEmail')
BEGIN
    print 'Altered: GlobalEmail ,HiveConnectionName';
    alter table [GlobalEmail] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LocatorID' and table_name = 'GlobalEmail')
BEGIN
    print 'Altered: GlobalEmail ,LocatorID';
    alter table [GlobalEmail] add [LocatorID]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LongName' and table_name = 'GlobalEmail')
BEGIN
    print 'Altered: GlobalEmail ,LongName';
    alter table [GlobalEmail] add [LongName]  nvarchar (2000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'GlobalEmail')
BEGIN
    print 'Altered: GlobalEmail ,RepoName';
    alter table [GlobalEmail] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'GlobalEmail')
BEGIN
    print 'Altered: GlobalEmail ,RepoSvrName';
    alter table [GlobalEmail] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'GlobalEmail')
BEGIN
    print 'Altered: GlobalEmail ,RowCreationDate';
    alter table [GlobalEmail] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'GlobalEmail')
BEGIN
    print 'Altered: GlobalEmail ,RowGuid';
    alter table [GlobalEmail] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'GlobalEmail')
BEGIN
    print 'Altered: GlobalEmail ,RowLastModDate';
    alter table [GlobalEmail] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ShortName' and table_name = 'GlobalEmail')
BEGIN
    print 'Altered: GlobalEmail ,ShortName';
    alter table [GlobalEmail] add [ShortName]  nvarchar (250)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'GuidID' and table_name = 'GlobalFile')
BEGIN
    print 'Altered: GlobalFile ,GuidID';
    alter table [GlobalFile] add [GuidID]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HashCode' and table_name = 'GlobalFile')
BEGIN
    print 'Altered: GlobalFile ,HashCode';
    alter table [GlobalFile] add [HashCode]  varchar (40)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'GlobalFile')
BEGIN
    print 'Altered: GlobalFile ,HiveActive';
    alter table [GlobalFile] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'GlobalFile')
BEGIN
    print 'Altered: GlobalFile ,HiveConnectionName';
    alter table [GlobalFile] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LocatorID' and table_name = 'GlobalFile')
BEGIN
    print 'Altered: GlobalFile ,LocatorID';
    alter table [GlobalFile] add [LocatorID]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LongName' and table_name = 'GlobalFile')
BEGIN
    print 'Altered: GlobalFile ,LongName';
    alter table [GlobalFile] add [LongName]  nvarchar (2000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'GlobalFile')
BEGIN
    print 'Altered: GlobalFile ,RepoName';
    alter table [GlobalFile] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'GlobalFile')
BEGIN
    print 'Altered: GlobalFile ,RepoSvrName';
    alter table [GlobalFile] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'GlobalFile')
BEGIN
    print 'Altered: GlobalFile ,RowCreationDate';
    alter table [GlobalFile] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'GlobalFile')
BEGIN
    print 'Altered: GlobalFile ,RowGuid';
    alter table [GlobalFile] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'GlobalFile')
BEGIN
    print 'Altered: GlobalFile ,RowLastModDate';
    alter table [GlobalFile] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ShortName' and table_name = 'GlobalFile')
BEGIN
    print 'Altered: GlobalFile ,ShortName';
    alter table [GlobalFile] add [ShortName]  nvarchar (250)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'GuidID' and table_name = 'GlobalLocation')
BEGIN
    print 'Altered: GlobalLocation ,GuidID';
    alter table [GlobalLocation] add [GuidID]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HashCode' and table_name = 'GlobalLocation')
BEGIN
    print 'Altered: GlobalLocation ,HashCode';
    alter table [GlobalLocation] add [HashCode]  varchar (40)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'GlobalLocation')
BEGIN
    print 'Altered: GlobalLocation ,HiveActive';
    alter table [GlobalLocation] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'GlobalLocation')
BEGIN
    print 'Altered: GlobalLocation ,HiveConnectionName';
    alter table [GlobalLocation] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LocatorID' and table_name = 'GlobalLocation')
BEGIN
    print 'Altered: GlobalLocation ,LocatorID';
    alter table [GlobalLocation] add [LocatorID]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LongName' and table_name = 'GlobalLocation')
BEGIN
    print 'Altered: GlobalLocation ,LongName';
    alter table [GlobalLocation] add [LongName]  nvarchar (2000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'GlobalLocation')
BEGIN
    print 'Altered: GlobalLocation ,RepoName';
    alter table [GlobalLocation] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'GlobalLocation')
BEGIN
    print 'Altered: GlobalLocation ,RepoSvrName';
    alter table [GlobalLocation] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'GlobalLocation')
BEGIN
    print 'Altered: GlobalLocation ,RowCreationDate';
    alter table [GlobalLocation] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'GlobalLocation')
BEGIN
    print 'Altered: GlobalLocation ,RowGuid';
    alter table [GlobalLocation] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'GlobalLocation')
BEGIN
    print 'Altered: GlobalLocation ,RowLastModDate';
    alter table [GlobalLocation] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ShortName' and table_name = 'GlobalLocation')
BEGIN
    print 'Altered: GlobalLocation ,ShortName';
    alter table [GlobalLocation] add [ShortName]  nvarchar (250)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'GuidID' and table_name = 'GlobalMachine')
BEGIN
    print 'Altered: GlobalMachine ,GuidID';
    alter table [GlobalMachine] add [GuidID]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HashCode' and table_name = 'GlobalMachine')
BEGIN
    print 'Altered: GlobalMachine ,HashCode';
    alter table [GlobalMachine] add [HashCode]  varchar (40)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'GlobalMachine')
BEGIN
    print 'Altered: GlobalMachine ,HiveActive';
    alter table [GlobalMachine] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'GlobalMachine')
BEGIN
    print 'Altered: GlobalMachine ,HiveConnectionName';
    alter table [GlobalMachine] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LocatorID' and table_name = 'GlobalMachine')
BEGIN
    print 'Altered: GlobalMachine ,LocatorID';
    alter table [GlobalMachine] add [LocatorID]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LongName' and table_name = 'GlobalMachine')
BEGIN
    print 'Altered: GlobalMachine ,LongName';
    alter table [GlobalMachine] add [LongName]  nvarchar (2000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'GlobalMachine')
BEGIN
    print 'Altered: GlobalMachine ,RepoName';
    alter table [GlobalMachine] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'GlobalMachine')
BEGIN
    print 'Altered: GlobalMachine ,RepoSvrName';
    alter table [GlobalMachine] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'GlobalMachine')
BEGIN
    print 'Altered: GlobalMachine ,RowCreationDate';
    alter table [GlobalMachine] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'GlobalMachine')
BEGIN
    print 'Altered: GlobalMachine ,RowGuid';
    alter table [GlobalMachine] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'GlobalMachine')
BEGIN
    print 'Altered: GlobalMachine ,RowLastModDate';
    alter table [GlobalMachine] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ShortName' and table_name = 'GlobalMachine')
BEGIN
    print 'Altered: GlobalMachine ,ShortName';
    alter table [GlobalMachine] add [ShortName]  nvarchar (250)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'AllRecipiants' and table_name = 'GlobalSeachResults')
BEGIN
    print 'Altered: GlobalSeachResults ,AllRecipiants';
    alter table [GlobalSeachResults] add [AllRecipiants]  nvarchar (max)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ContentAuthor' and table_name = 'GlobalSeachResults')
BEGIN
    print 'Altered: GlobalSeachResults ,ContentAuthor';
    alter table [GlobalSeachResults] add [ContentAuthor]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ContentExt' and table_name = 'GlobalSeachResults')
BEGIN
    print 'Altered: GlobalSeachResults ,ContentExt';
    alter table [GlobalSeachResults] add [ContentExt]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ContentGuid' and table_name = 'GlobalSeachResults')
BEGIN
    print 'Altered: GlobalSeachResults ,ContentGuid';
    alter table [GlobalSeachResults] add [ContentGuid]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ContentTitle' and table_name = 'GlobalSeachResults')
BEGIN
    print 'Altered: GlobalSeachResults ,ContentTitle';
    alter table [GlobalSeachResults] add [ContentTitle]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ContentType' and table_name = 'GlobalSeachResults')
BEGIN
    print 'Altered: GlobalSeachResults ,ContentType';
    alter table [GlobalSeachResults] add [ContentType]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CreateDate' and table_name = 'GlobalSeachResults')
BEGIN
    print 'Altered: GlobalSeachResults ,CreateDate';
    alter table [GlobalSeachResults] add [CreateDate]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FileName' and table_name = 'GlobalSeachResults')
BEGIN
    print 'Altered: GlobalSeachResults ,FileName';
    alter table [GlobalSeachResults] add [FileName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FileSize' and table_name = 'GlobalSeachResults')
BEGIN
    print 'Altered: GlobalSeachResults ,FileSize';
    alter table [GlobalSeachResults] add [FileSize]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FromEmailAddress' and table_name = 'GlobalSeachResults')
BEGIN
    print 'Altered: GlobalSeachResults ,FromEmailAddress';
    alter table [GlobalSeachResults] add [FromEmailAddress]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'GlobalSeachResults')
BEGIN
    print 'Altered: GlobalSeachResults ,HiveActive';
    alter table [GlobalSeachResults] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'GlobalSeachResults')
BEGIN
    print 'Altered: GlobalSeachResults ,HiveConnectionName';
    alter table [GlobalSeachResults] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'NbrOfAttachments' and table_name = 'GlobalSeachResults')
BEGIN
    print 'Altered: GlobalSeachResults ,NbrOfAttachments';
    alter table [GlobalSeachResults] add [NbrOfAttachments]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'GlobalSeachResults')
BEGIN
    print 'Altered: GlobalSeachResults ,RepoName';
    alter table [GlobalSeachResults] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'GlobalSeachResults')
BEGIN
    print 'Altered: GlobalSeachResults ,RepoSvrName';
    alter table [GlobalSeachResults] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'GlobalSeachResults')
BEGIN
    print 'Altered: GlobalSeachResults ,RowCreationDate';
    alter table [GlobalSeachResults] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'GlobalSeachResults')
BEGIN
    print 'Altered: GlobalSeachResults ,RowGuid';
    alter table [GlobalSeachResults] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'GlobalSeachResults')
BEGIN
    print 'Altered: GlobalSeachResults ,RowLastModDate';
    alter table [GlobalSeachResults] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'GlobalSeachResults')
BEGIN
    print 'Altered: GlobalSeachResults ,UserID';
    alter table [GlobalSeachResults] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Weight' and table_name = 'GlobalSeachResults')
BEGIN
    print 'Altered: GlobalSeachResults ,Weight';
    alter table [GlobalSeachResults] add [Weight]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'GraphicFileTypeExt' and table_name = 'GraphicFileType')
BEGIN
    print 'Altered: GraphicFileType ,GraphicFileTypeExt';
    alter table [GraphicFileType] add [GraphicFileTypeExt]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'GroupName' and table_name = 'GroupLibraryAccess')
BEGIN
    print 'Altered: GroupLibraryAccess ,GroupName';
    alter table [GroupLibraryAccess] add [GroupName]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'GroupOwnerUserID' and table_name = 'GroupLibraryAccess')
BEGIN
    print 'Altered: GroupLibraryAccess ,GroupOwnerUserID';
    alter table [GroupLibraryAccess] add [GroupOwnerUserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'GroupLibraryAccess')
BEGIN
    print 'Altered: GroupLibraryAccess ,HiveActive';
    alter table [GroupLibraryAccess] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'GroupLibraryAccess')
BEGIN
    print 'Altered: GroupLibraryAccess ,HiveConnectionName';
    alter table [GroupLibraryAccess] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LibraryName' and table_name = 'GroupLibraryAccess')
BEGIN
    print 'Altered: GroupLibraryAccess ,LibraryName';
    alter table [GroupLibraryAccess] add [LibraryName]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'GroupLibraryAccess')
BEGIN
    print 'Altered: GroupLibraryAccess ,RepoName';
    alter table [GroupLibraryAccess] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'GroupLibraryAccess')
BEGIN
    print 'Altered: GroupLibraryAccess ,RepoSvrName';
    alter table [GroupLibraryAccess] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'GroupLibraryAccess')
BEGIN
    print 'Altered: GroupLibraryAccess ,RowCreationDate';
    alter table [GroupLibraryAccess] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'GroupLibraryAccess')
BEGIN
    print 'Altered: GroupLibraryAccess ,RowGuid';
    alter table [GroupLibraryAccess] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'GroupLibraryAccess')
BEGIN
    print 'Altered: GroupLibraryAccess ,RowLastModDate';
    alter table [GroupLibraryAccess] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'GroupLibraryAccess')
BEGIN
    print 'Altered: GroupLibraryAccess ,UserID';
    alter table [GroupLibraryAccess] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'DeleteAccess' and table_name = 'GroupUsers')
BEGIN
    print 'Altered: GroupUsers ,DeleteAccess';
    alter table [GroupUsers] add [DeleteAccess]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FullAccess' and table_name = 'GroupUsers')
BEGIN
    print 'Altered: GroupUsers ,FullAccess';
    alter table [GroupUsers] add [FullAccess]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'GroupName' and table_name = 'GroupUsers')
BEGIN
    print 'Altered: GroupUsers ,GroupName';
    alter table [GroupUsers] add [GroupName]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'GroupOwnerUserID' and table_name = 'GroupUsers')
BEGIN
    print 'Altered: GroupUsers ,GroupOwnerUserID';
    alter table [GroupUsers] add [GroupOwnerUserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'GroupUsers')
BEGIN
    print 'Altered: GroupUsers ,HiveActive';
    alter table [GroupUsers] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'GroupUsers')
BEGIN
    print 'Altered: GroupUsers ,HiveConnectionName';
    alter table [GroupUsers] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ReadOnlyAccess' and table_name = 'GroupUsers')
BEGIN
    print 'Altered: GroupUsers ,ReadOnlyAccess';
    alter table [GroupUsers] add [ReadOnlyAccess]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'GroupUsers')
BEGIN
    print 'Altered: GroupUsers ,RepoName';
    alter table [GroupUsers] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'GroupUsers')
BEGIN
    print 'Altered: GroupUsers ,RepoSvrName';
    alter table [GroupUsers] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'GroupUsers')
BEGIN
    print 'Altered: GroupUsers ,RowCreationDate';
    alter table [GroupUsers] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'GroupUsers')
BEGIN
    print 'Altered: GroupUsers ,RowGuid';
    alter table [GroupUsers] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'GroupUsers')
BEGIN
    print 'Altered: GroupUsers ,RowLastModDate';
    alter table [GroupUsers] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Searchable' and table_name = 'GroupUsers')
BEGIN
    print 'Altered: GroupUsers ,Searchable';
    alter table [GroupUsers] add [Searchable]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'GroupUsers')
BEGIN
    print 'Altered: GroupUsers ,UserID';
    alter table [GroupUsers] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Hash' and table_name = 'HashDir')
BEGIN
    print 'Altered: HashDir ,Hash';
    alter table [HashDir] add [Hash]  decimal; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HashedString' and table_name = 'HashDir')
BEGIN
    print 'Altered: HashDir ,HashedString';
    alter table [HashDir] add [HashedString]  varchar (max)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HashID' and table_name = 'HashDir')
BEGIN
    print 'Altered: HashDir ,HashID';
    alter table [HashDir] add [HashID]  varchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'HashDir')
BEGIN
    print 'Altered: HashDir ,HiveActive';
    alter table [HashDir] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'HashDir')
BEGIN
    print 'Altered: HashDir ,HiveConnectionName';
    alter table [HashDir] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'HashDir')
BEGIN
    print 'Altered: HashDir ,RepoName';
    alter table [HashDir] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'HashDir')
BEGIN
    print 'Altered: HashDir ,RepoSvrName';
    alter table [HashDir] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'HashDir')
BEGIN
    print 'Altered: HashDir ,RowCreationDate';
    alter table [HashDir] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'HashDir')
BEGIN
    print 'Altered: HashDir ,RowGuid';
    alter table [HashDir] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'HashDir')
BEGIN
    print 'Altered: HashDir ,RowLastModDate';
    alter table [HashDir] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Hash' and table_name = 'HashFile')
BEGIN
    print 'Altered: HashFile ,Hash';
    alter table [HashFile] add [Hash]  decimal; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HashedString' and table_name = 'HashFile')
BEGIN
    print 'Altered: HashFile ,HashedString';
    alter table [HashFile] add [HashedString]  varchar (max)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HashID' and table_name = 'HashFile')
BEGIN
    print 'Altered: HashFile ,HashID';
    alter table [HashFile] add [HashID]  varchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'HashFile')
BEGIN
    print 'Altered: HashFile ,HiveActive';
    alter table [HashFile] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'HashFile')
BEGIN
    print 'Altered: HashFile ,HiveConnectionName';
    alter table [HashFile] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'HashFile')
BEGIN
    print 'Altered: HashFile ,RepoName';
    alter table [HashFile] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'HashFile')
BEGIN
    print 'Altered: HashFile ,RepoSvrName';
    alter table [HashFile] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'HashFile')
BEGIN
    print 'Altered: HashFile ,RowCreationDate';
    alter table [HashFile] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'HashFile')
BEGIN
    print 'Altered: HashFile ,RowGuid';
    alter table [HashFile] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'HashFile')
BEGIN
    print 'Altered: HashFile ,RowLastModDate';
    alter table [HashFile] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'AreaOfFocus' and table_name = 'HelpInfo')
BEGIN
    print 'Altered: HelpInfo ,AreaOfFocus';
    alter table [HelpInfo] add [AreaOfFocus]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'EmailNotification' and table_name = 'HelpInfo')
BEGIN
    print 'Altered: HelpInfo ,EmailNotification';
    alter table [HelpInfo] add [EmailNotification]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HelpEmailAddr' and table_name = 'HelpInfo')
BEGIN
    print 'Altered: HelpInfo ,HelpEmailAddr';
    alter table [HelpInfo] add [HelpEmailAddr]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HelpName' and table_name = 'HelpInfo')
BEGIN
    print 'Altered: HelpInfo ,HelpName';
    alter table [HelpInfo] add [HelpName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HelpPhone' and table_name = 'HelpInfo')
BEGIN
    print 'Altered: HelpInfo ,HelpPhone';
    alter table [HelpInfo] add [HelpPhone]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'HelpInfo')
BEGIN
    print 'Altered: HelpInfo ,HiveActive';
    alter table [HelpInfo] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'HelpInfo')
BEGIN
    print 'Altered: HelpInfo ,HiveConnectionName';
    alter table [HelpInfo] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HoursAvail' and table_name = 'HelpInfo')
BEGIN
    print 'Altered: HelpInfo ,HoursAvail';
    alter table [HelpInfo] add [HoursAvail]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'HelpInfo')
BEGIN
    print 'Altered: HelpInfo ,RepoName';
    alter table [HelpInfo] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'HelpInfo')
BEGIN
    print 'Altered: HelpInfo ,RepoSvrName';
    alter table [HelpInfo] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'HelpInfo')
BEGIN
    print 'Altered: HelpInfo ,RowCreationDate';
    alter table [HelpInfo] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'HelpInfo')
BEGIN
    print 'Altered: HelpInfo ,RowGuid';
    alter table [HelpInfo] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'HelpInfo')
BEGIN
    print 'Altered: HelpInfo ,RowLastModDate';
    alter table [HelpInfo] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CreateDate' and table_name = 'HelpText')
BEGIN
    print 'Altered: HelpText ,CreateDate';
    alter table [HelpText] add [CreateDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'DisplayHelpText' and table_name = 'HelpText')
BEGIN
    print 'Altered: HelpText ,DisplayHelpText';
    alter table [HelpText] add [DisplayHelpText]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HelpText' and table_name = 'HelpText')
BEGIN
    print 'Altered: HelpText ,HelpText';
    alter table [HelpText] add [HelpText]  nvarchar (max)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'HelpText')
BEGIN
    print 'Altered: HelpText ,HiveActive';
    alter table [HelpText] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'HelpText')
BEGIN
    print 'Altered: HelpText ,HiveConnectionName';
    alter table [HelpText] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LastUpdate' and table_name = 'HelpText')
BEGIN
    print 'Altered: HelpText ,LastUpdate';
    alter table [HelpText] add [LastUpdate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'HelpText')
BEGIN
    print 'Altered: HelpText ,RepoName';
    alter table [HelpText] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'HelpText')
BEGIN
    print 'Altered: HelpText ,RepoSvrName';
    alter table [HelpText] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'HelpText')
BEGIN
    print 'Altered: HelpText ,RowCreationDate';
    alter table [HelpText] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'HelpText')
BEGIN
    print 'Altered: HelpText ,RowGuid';
    alter table [HelpText] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'HelpText')
BEGIN
    print 'Altered: HelpText ,RowLastModDate';
    alter table [HelpText] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ScreenName' and table_name = 'HelpText')
BEGIN
    print 'Altered: HelpText ,ScreenName';
    alter table [HelpText] add [ScreenName]  nvarchar (100)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UpdatedBy' and table_name = 'HelpText')
BEGIN
    print 'Altered: HelpText ,UpdatedBy';
    alter table [HelpText] add [UpdatedBy]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'WidgetName' and table_name = 'HelpText')
BEGIN
    print 'Altered: HelpText ,WidgetName';
    alter table [HelpText] add [WidgetName]  nvarchar (100)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'WidgetText' and table_name = 'HelpText')
BEGIN
    print 'Altered: HelpText ,WidgetText';
    alter table [HelpText] add [WidgetText]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CompanyID' and table_name = 'HelpTextUser')
BEGIN
    print 'Altered: HelpTextUser ,CompanyID';
    alter table [HelpTextUser] add [CompanyID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CreateDate' and table_name = 'HelpTextUser')
BEGIN
    print 'Altered: HelpTextUser ,CreateDate';
    alter table [HelpTextUser] add [CreateDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'DisplayHelpText' and table_name = 'HelpTextUser')
BEGIN
    print 'Altered: HelpTextUser ,DisplayHelpText';
    alter table [HelpTextUser] add [DisplayHelpText]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HelpText' and table_name = 'HelpTextUser')
BEGIN
    print 'Altered: HelpTextUser ,HelpText';
    alter table [HelpTextUser] add [HelpText]  nvarchar (max)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'HelpTextUser')
BEGIN
    print 'Altered: HelpTextUser ,HiveActive';
    alter table [HelpTextUser] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'HelpTextUser')
BEGIN
    print 'Altered: HelpTextUser ,HiveConnectionName';
    alter table [HelpTextUser] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LastUpdate' and table_name = 'HelpTextUser')
BEGIN
    print 'Altered: HelpTextUser ,LastUpdate';
    alter table [HelpTextUser] add [LastUpdate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'HelpTextUser')
BEGIN
    print 'Altered: HelpTextUser ,RepoName';
    alter table [HelpTextUser] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'HelpTextUser')
BEGIN
    print 'Altered: HelpTextUser ,RepoSvrName';
    alter table [HelpTextUser] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'HelpTextUser')
BEGIN
    print 'Altered: HelpTextUser ,RowCreationDate';
    alter table [HelpTextUser] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'HelpTextUser')
BEGIN
    print 'Altered: HelpTextUser ,RowGuid';
    alter table [HelpTextUser] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'HelpTextUser')
BEGIN
    print 'Altered: HelpTextUser ,RowLastModDate';
    alter table [HelpTextUser] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ScreenName' and table_name = 'HelpTextUser')
BEGIN
    print 'Altered: HelpTextUser ,ScreenName';
    alter table [HelpTextUser] add [ScreenName]  nvarchar (100)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'HelpTextUser')
BEGIN
    print 'Altered: HelpTextUser ,UserID';
    alter table [HelpTextUser] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'WidgetName' and table_name = 'HelpTextUser')
BEGIN
    print 'Altered: HelpTextUser ,WidgetName';
    alter table [HelpTextUser] add [WidgetName]  nvarchar (100)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'WidgetText' and table_name = 'HelpTextUser')
BEGIN
    print 'Altered: HelpTextUser ,WidgetText';
    alter table [HelpTextUser] add [WidgetText]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'isHiveserver' and table_name = 'HiveServers')
BEGIN
    print 'Altered: HiveServers ,isHiveserver';
    alter table [HiveServers] add [isHiveserver]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'isLInked' and table_name = 'HiveServers')
BEGIN
    print 'Altered: HiveServers ,isLInked';
    alter table [HiveServers] add [isLInked]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LinkedDate' and table_name = 'HiveServers')
BEGIN
    print 'Altered: HiveServers ,LinkedDate';
    alter table [HiveServers] add [LinkedDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'HiveServers')
BEGIN
    print 'Altered: HiveServers ,RepoName';
    alter table [HiveServers] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'HiveServers')
BEGIN
    print 'Altered: HiveServers ,RowGuid';
    alter table [HiveServers] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ServerInstance' and table_name = 'HiveServers')
BEGIN
    print 'Altered: HiveServers ,ServerInstance';
    alter table [HiveServers] add [ServerInstance]  nvarchar (100)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SeverAlias' and table_name = 'HiveServers')
BEGIN
    print 'Altered: HiveServers ,SeverAlias';
    alter table [HiveServers] add [SeverAlias]  nvarchar (100)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'ImageTypeCodes')
BEGIN
    print 'Altered: ImageTypeCodes ,HiveActive';
    alter table [ImageTypeCodes] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'ImageTypeCodes')
BEGIN
    print 'Altered: ImageTypeCodes ,HiveConnectionName';
    alter table [ImageTypeCodes] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ImageTypeCode' and table_name = 'ImageTypeCodes')
BEGIN
    print 'Altered: ImageTypeCodes ,ImageTypeCode';
    alter table [ImageTypeCodes] add [ImageTypeCode]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ImageTypeCodeDesc' and table_name = 'ImageTypeCodes')
BEGIN
    print 'Altered: ImageTypeCodes ,ImageTypeCodeDesc';
    alter table [ImageTypeCodes] add [ImageTypeCodeDesc]  nvarchar (250)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'ImageTypeCodes')
BEGIN
    print 'Altered: ImageTypeCodes ,RepoName';
    alter table [ImageTypeCodes] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'ImageTypeCodes')
BEGIN
    print 'Altered: ImageTypeCodes ,RepoSvrName';
    alter table [ImageTypeCodes] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'ImageTypeCodes')
BEGIN
    print 'Altered: ImageTypeCodes ,RowCreationDate';
    alter table [ImageTypeCodes] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'ImageTypeCodes')
BEGIN
    print 'Altered: ImageTypeCodes ,RowGuid';
    alter table [ImageTypeCodes] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'ImageTypeCodes')
BEGIN
    print 'Altered: ImageTypeCodes ,RowLastModDate';
    alter table [ImageTypeCodes] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ExtCode' and table_name = 'IncludedFiles')
BEGIN
    print 'Altered: IncludedFiles ,ExtCode';
    alter table [IncludedFiles] add [ExtCode]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FQN' and table_name = 'IncludedFiles')
BEGIN
    print 'Altered: IncludedFiles ,FQN';
    alter table [IncludedFiles] add [FQN]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'IncludedFiles')
BEGIN
    print 'Altered: IncludedFiles ,HiveActive';
    alter table [IncludedFiles] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'IncludedFiles')
BEGIN
    print 'Altered: IncludedFiles ,HiveConnectionName';
    alter table [IncludedFiles] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'IncludedFiles')
BEGIN
    print 'Altered: IncludedFiles ,RepoName';
    alter table [IncludedFiles] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'IncludedFiles')
BEGIN
    print 'Altered: IncludedFiles ,RepoSvrName';
    alter table [IncludedFiles] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'IncludedFiles')
BEGIN
    print 'Altered: IncludedFiles ,RowCreationDate';
    alter table [IncludedFiles] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'IncludedFiles')
BEGIN
    print 'Altered: IncludedFiles ,RowGuid';
    alter table [IncludedFiles] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'IncludedFiles')
BEGIN
    print 'Altered: IncludedFiles ,RowLastModDate';
    alter table [IncludedFiles] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'IncludedFiles')
BEGIN
    print 'Altered: IncludedFiles ,UserID';
    alter table [IncludedFiles] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FromEmailAddr' and table_name = 'IncludeImmediate')
BEGIN
    print 'Altered: IncludeImmediate ,FromEmailAddr';
    alter table [IncludeImmediate] add [FromEmailAddr]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'IncludeImmediate')
BEGIN
    print 'Altered: IncludeImmediate ,HiveActive';
    alter table [IncludeImmediate] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'IncludeImmediate')
BEGIN
    print 'Altered: IncludeImmediate ,HiveConnectionName';
    alter table [IncludeImmediate] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'IncludeImmediate')
BEGIN
    print 'Altered: IncludeImmediate ,RepoName';
    alter table [IncludeImmediate] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'IncludeImmediate')
BEGIN
    print 'Altered: IncludeImmediate ,RepoSvrName';
    alter table [IncludeImmediate] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'IncludeImmediate')
BEGIN
    print 'Altered: IncludeImmediate ,RowCreationDate';
    alter table [IncludeImmediate] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'IncludeImmediate')
BEGIN
    print 'Altered: IncludeImmediate ,RowGuid';
    alter table [IncludeImmediate] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'IncludeImmediate')
BEGIN
    print 'Altered: IncludeImmediate ,RowLastModDate';
    alter table [IncludeImmediate] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SenderName' and table_name = 'IncludeImmediate')
BEGIN
    print 'Altered: IncludeImmediate ,SenderName';
    alter table [IncludeImmediate] add [SenderName]  varchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'IncludeImmediate')
BEGIN
    print 'Altered: IncludeImmediate ,UserID';
    alter table [IncludeImmediate] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Code' and table_name = 'InformationProduct')
BEGIN
    print 'Altered: InformationProduct ,Code';
    alter table [InformationProduct] add [Code]  char (10)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ContainerType' and table_name = 'InformationProduct')
BEGIN
    print 'Altered: InformationProduct ,ContainerType';
    alter table [InformationProduct] add [ContainerType]  nvarchar (25)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CorpFuncName' and table_name = 'InformationProduct')
BEGIN
    print 'Altered: InformationProduct ,CorpFuncName';
    alter table [InformationProduct] add [CorpFuncName]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CorpName' and table_name = 'InformationProduct')
BEGIN
    print 'Altered: InformationProduct ,CorpName';
    alter table [InformationProduct] add [CorpName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CreateDate' and table_name = 'InformationProduct')
BEGIN
    print 'Altered: InformationProduct ,CreateDate';
    alter table [InformationProduct] add [CreateDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'InformationProduct')
BEGIN
    print 'Altered: InformationProduct ,HiveActive';
    alter table [InformationProduct] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'InformationProduct')
BEGIN
    print 'Altered: InformationProduct ,HiveConnectionName';
    alter table [InformationProduct] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'InfoTypeCode' and table_name = 'InformationProduct')
BEGIN
    print 'Altered: InformationProduct ,InfoTypeCode';
    alter table [InformationProduct] add [InfoTypeCode]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'InformationProduct')
BEGIN
    print 'Altered: InformationProduct ,RepoName';
    alter table [InformationProduct] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'InformationProduct')
BEGIN
    print 'Altered: InformationProduct ,RepoSvrName';
    alter table [InformationProduct] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RetentionCode' and table_name = 'InformationProduct')
BEGIN
    print 'Altered: InformationProduct ,RetentionCode';
    alter table [InformationProduct] add [RetentionCode]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'InformationProduct')
BEGIN
    print 'Altered: InformationProduct ,RowCreationDate';
    alter table [InformationProduct] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'InformationProduct')
BEGIN
    print 'Altered: InformationProduct ,RowGuid';
    alter table [InformationProduct] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'InformationProduct')
BEGIN
    print 'Altered: InformationProduct ,RowLastModDate';
    alter table [InformationProduct] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'VolitilityCode' and table_name = 'InformationProduct')
BEGIN
    print 'Altered: InformationProduct ,VolitilityCode';
    alter table [InformationProduct] add [VolitilityCode]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CreateDate' and table_name = 'InformationType')
BEGIN
    print 'Altered: InformationType ,CreateDate';
    alter table [InformationType] add [CreateDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Description' and table_name = 'InformationType')
BEGIN
    print 'Altered: InformationType ,Description';
    alter table [InformationType] add [Description]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'InformationType')
BEGIN
    print 'Altered: InformationType ,HiveActive';
    alter table [InformationType] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'InformationType')
BEGIN
    print 'Altered: InformationType ,HiveConnectionName';
    alter table [InformationType] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'InfoTypeCode' and table_name = 'InformationType')
BEGIN
    print 'Altered: InformationType ,InfoTypeCode';
    alter table [InformationType] add [InfoTypeCode]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'InformationType')
BEGIN
    print 'Altered: InformationType ,RepoName';
    alter table [InformationType] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'InformationType')
BEGIN
    print 'Altered: InformationType ,RepoSvrName';
    alter table [InformationType] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'InformationType')
BEGIN
    print 'Altered: InformationType ,RowCreationDate';
    alter table [InformationType] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'InformationType')
BEGIN
    print 'Altered: InformationType ,RowGuid';
    alter table [InformationType] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'InformationType')
BEGIN
    print 'Altered: InformationType ,RowLastModDate';
    alter table [InformationType] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CombinedHash' and table_name = 'Inventory')
BEGIN
    print 'Altered: Inventory ,CombinedHash';
    alter table [Inventory] add [CombinedHash]  varchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'DirFqn' and table_name = 'Inventory')
BEGIN
    print 'Altered: Inventory ,DirFqn';
    alter table [Inventory] add [DirFqn]  varchar (720)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'DirHash' and table_name = 'Inventory')
BEGIN
    print 'Altered: Inventory ,DirHash';
    alter table [Inventory] add [DirHash]  numeric; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ExistInRepo' and table_name = 'Inventory')
BEGIN
    print 'Altered: Inventory ,ExistInRepo';
    alter table [Inventory] add [ExistInRepo]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FileHash' and table_name = 'Inventory')
BEGIN
    print 'Altered: Inventory ,FileHash';
    alter table [Inventory] add [FileHash]  numeric; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FileSize' and table_name = 'Inventory')
BEGIN
    print 'Altered: Inventory ,FileSize';
    alter table [Inventory] add [FileSize]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FQN' and table_name = 'Inventory')
BEGIN
    print 'Altered: Inventory ,FQN';
    alter table [Inventory] add [FQN]  varchar (100)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'Inventory')
BEGIN
    print 'Altered: Inventory ,HiveActive';
    alter table [Inventory] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'Inventory')
BEGIN
    print 'Altered: Inventory ,HiveConnectionName';
    alter table [Inventory] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'MachineName' and table_name = 'Inventory')
BEGIN
    print 'Altered: Inventory ,MachineName';
    alter table [Inventory] add [MachineName]  varbinary; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'Inventory')
BEGIN
    print 'Altered: Inventory ,RepoName';
    alter table [Inventory] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'Inventory')
BEGIN
    print 'Altered: Inventory ,RepoSvrName';
    alter table [Inventory] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'Inventory')
BEGIN
    print 'Altered: Inventory ,RowCreationDate';
    alter table [Inventory] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'Inventory')
BEGIN
    print 'Altered: Inventory ,RowGuid';
    alter table [Inventory] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'Inventory')
BEGIN
    print 'Altered: Inventory ,RowLastModDate';
    alter table [Inventory] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserLogin' and table_name = 'Inventory')
BEGIN
    print 'Altered: Inventory ,UserLogin';
    alter table [Inventory] add [UserLogin]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Verified' and table_name = 'Inventory')
BEGIN
    print 'Altered: Inventory ,Verified';
    alter table [Inventory] add [Verified]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'AccessCnt' and table_name = 'IP')
BEGIN
    print 'Altered: IP ,AccessCnt';
    alter table [IP] add [AccessCnt]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'AccessingIP' and table_name = 'IP')
BEGIN
    print 'Altered: IP ,AccessingIP';
    alter table [IP] add [AccessingIP]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'BlockIP' and table_name = 'IP')
BEGIN
    print 'Altered: IP ,BlockIP';
    alter table [IP] add [BlockIP]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FirstAccessDate' and table_name = 'IP')
BEGIN
    print 'Altered: IP ,FirstAccessDate';
    alter table [IP] add [FirstAccessDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'IP')
BEGIN
    print 'Altered: IP ,HiveActive';
    alter table [IP] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'IP')
BEGIN
    print 'Altered: IP ,HiveConnectionName';
    alter table [IP] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HostName' and table_name = 'IP')
BEGIN
    print 'Altered: IP ,HostName';
    alter table [IP] add [HostName]  nvarchar (150)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LastAccessDate' and table_name = 'IP')
BEGIN
    print 'Altered: IP ,LastAccessDate';
    alter table [IP] add [LastAccessDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'IP')
BEGIN
    print 'Altered: IP ,RepoName';
    alter table [IP] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'IP')
BEGIN
    print 'Altered: IP ,RepoSvrName';
    alter table [IP] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'IP')
BEGIN
    print 'Altered: IP ,RowCreationDate';
    alter table [IP] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'IP')
BEGIN
    print 'Altered: IP ,RowGuid';
    alter table [IP] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'IP')
BEGIN
    print 'Altered: IP ,RowLastModDate';
    alter table [IP] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SearchCnt' and table_name = 'IP')
BEGIN
    print 'Altered: IP ,SearchCnt';
    alter table [IP] add [SearchCnt]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CreateDate' and table_name = 'JargonWords')
BEGIN
    print 'Altered: JargonWords ,CreateDate';
    alter table [JargonWords] add [CreateDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'JargonWords')
BEGIN
    print 'Altered: JargonWords ,HiveActive';
    alter table [JargonWords] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'JargonWords')
BEGIN
    print 'Altered: JargonWords ,HiveConnectionName';
    alter table [JargonWords] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'JargonCode' and table_name = 'JargonWords')
BEGIN
    print 'Altered: JargonWords ,JargonCode';
    alter table [JargonWords] add [JargonCode]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'jDesc' and table_name = 'JargonWords')
BEGIN
    print 'Altered: JargonWords ,jDesc';
    alter table [JargonWords] add [jDesc]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'JargonWords')
BEGIN
    print 'Altered: JargonWords ,RepoName';
    alter table [JargonWords] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'JargonWords')
BEGIN
    print 'Altered: JargonWords ,RepoSvrName';
    alter table [JargonWords] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'JargonWords')
BEGIN
    print 'Altered: JargonWords ,RowCreationDate';
    alter table [JargonWords] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'JargonWords')
BEGIN
    print 'Altered: JargonWords ,RowGuid';
    alter table [JargonWords] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'JargonWords')
BEGIN
    print 'Altered: JargonWords ,RowLastModDate';
    alter table [JargonWords] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'tgtWord' and table_name = 'JargonWords')
BEGIN
    print 'Altered: JargonWords ,tgtWord';
    alter table [JargonWords] add [tgtWord]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CreateDate' and table_name = 'KTBL')
BEGIN
    print 'Altered: KTBL ,CreateDate';
    alter table [KTBL] add [CreateDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'KGUID' and table_name = 'KTBL')
BEGIN
    print 'Altered: KTBL ,KGUID';
    alter table [KTBL] add [KGUID]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'KID' and table_name = 'KTBL')
BEGIN
    print 'Altered: KTBL ,KID';
    alter table [KTBL] add [KID]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'KIV' and table_name = 'KTBL')
BEGIN
    print 'Altered: KTBL ,KIV';
    alter table [KTBL] add [KIV]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'KTBL')
BEGIN
    print 'Altered: KTBL ,RepoName';
    alter table [KTBL] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'KTBL')
BEGIN
    print 'Altered: KTBL ,RowGuid';
    alter table [KTBL] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'DirectoryName' and table_name = 'LibDirectory')
BEGIN
    print 'Altered: LibDirectory ,DirectoryName';
    alter table [LibDirectory] add [DirectoryName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'LibDirectory')
BEGIN
    print 'Altered: LibDirectory ,HiveActive';
    alter table [LibDirectory] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'LibDirectory')
BEGIN
    print 'Altered: LibDirectory ,HiveConnectionName';
    alter table [LibDirectory] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'IncludeSubDirs' and table_name = 'LibDirectory')
BEGIN
    print 'Altered: LibDirectory ,IncludeSubDirs';
    alter table [LibDirectory] add [IncludeSubDirs]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LibraryName' and table_name = 'LibDirectory')
BEGIN
    print 'Altered: LibDirectory ,LibraryName';
    alter table [LibDirectory] add [LibraryName]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'LibDirectory')
BEGIN
    print 'Altered: LibDirectory ,RepoName';
    alter table [LibDirectory] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'LibDirectory')
BEGIN
    print 'Altered: LibDirectory ,RepoSvrName';
    alter table [LibDirectory] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'LibDirectory')
BEGIN
    print 'Altered: LibDirectory ,RowCreationDate';
    alter table [LibDirectory] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'LibDirectory')
BEGIN
    print 'Altered: LibDirectory ,RowGuid';
    alter table [LibDirectory] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'LibDirectory')
BEGIN
    print 'Altered: LibDirectory ,RowLastModDate';
    alter table [LibDirectory] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'LibDirectory')
BEGIN
    print 'Altered: LibDirectory ,UserID';
    alter table [LibDirectory] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'EmailFolderEntryID' and table_name = 'LibEmail')
BEGIN
    print 'Altered: LibEmail ,EmailFolderEntryID';
    alter table [LibEmail] add [EmailFolderEntryID]  nvarchar (200)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FolderName' and table_name = 'LibEmail')
BEGIN
    print 'Altered: LibEmail ,FolderName';
    alter table [LibEmail] add [FolderName]  nvarchar (250)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'LibEmail')
BEGIN
    print 'Altered: LibEmail ,HiveActive';
    alter table [LibEmail] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'LibEmail')
BEGIN
    print 'Altered: LibEmail ,HiveConnectionName';
    alter table [LibEmail] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LibraryName' and table_name = 'LibEmail')
BEGIN
    print 'Altered: LibEmail ,LibraryName';
    alter table [LibEmail] add [LibraryName]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'LibEmail')
BEGIN
    print 'Altered: LibEmail ,RepoName';
    alter table [LibEmail] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'LibEmail')
BEGIN
    print 'Altered: LibEmail ,RepoSvrName';
    alter table [LibEmail] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'LibEmail')
BEGIN
    print 'Altered: LibEmail ,RowCreationDate';
    alter table [LibEmail] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'LibEmail')
BEGIN
    print 'Altered: LibEmail ,RowGuid';
    alter table [LibEmail] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'LibEmail')
BEGIN
    print 'Altered: LibEmail ,RowLastModDate';
    alter table [LibEmail] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'LibEmail')
BEGIN
    print 'Altered: LibEmail ,UserID';
    alter table [LibEmail] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'Library')
BEGIN
    print 'Altered: Library ,HiveActive';
    alter table [Library] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'Library')
BEGIN
    print 'Altered: Library ,HiveConnectionName';
    alter table [Library] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'isPublic' and table_name = 'Library')
BEGIN
    print 'Altered: Library ,isPublic';
    alter table [Library] add [isPublic]  nchar (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LibraryName' and table_name = 'Library')
BEGIN
    print 'Altered: Library ,LibraryName';
    alter table [Library] add [LibraryName]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'Library')
BEGIN
    print 'Altered: Library ,RepoName';
    alter table [Library] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'Library')
BEGIN
    print 'Altered: Library ,RepoSvrName';
    alter table [Library] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'Library')
BEGIN
    print 'Altered: Library ,RowCreationDate';
    alter table [Library] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'Library')
BEGIN
    print 'Altered: Library ,RowGuid';
    alter table [Library] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'Library')
BEGIN
    print 'Altered: Library ,RowLastModDate';
    alter table [Library] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'Library')
BEGIN
    print 'Altered: Library ,UserID';
    alter table [Library] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'AddedByUserGuidId' and table_name = 'LibraryItems')
BEGIN
    print 'Altered: LibraryItems ,AddedByUserGuidId';
    alter table [LibraryItems] add [AddedByUserGuidId]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'DataSourceOwnerUserID' and table_name = 'LibraryItems')
BEGIN
    print 'Altered: LibraryItems ,DataSourceOwnerUserID';
    alter table [LibraryItems] add [DataSourceOwnerUserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'LibraryItems')
BEGIN
    print 'Altered: LibraryItems ,HiveActive';
    alter table [LibraryItems] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'LibraryItems')
BEGIN
    print 'Altered: LibraryItems ,HiveConnectionName';
    alter table [LibraryItems] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ItemTitle' and table_name = 'LibraryItems')
BEGIN
    print 'Altered: LibraryItems ,ItemTitle';
    alter table [LibraryItems] add [ItemTitle]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ItemType' and table_name = 'LibraryItems')
BEGIN
    print 'Altered: LibraryItems ,ItemType';
    alter table [LibraryItems] add [ItemType]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LibraryItemGuid' and table_name = 'LibraryItems')
BEGIN
    print 'Altered: LibraryItems ,LibraryItemGuid';
    alter table [LibraryItems] add [LibraryItemGuid]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LibraryName' and table_name = 'LibraryItems')
BEGIN
    print 'Altered: LibraryItems ,LibraryName';
    alter table [LibraryItems] add [LibraryName]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LibraryOwnerUserID' and table_name = 'LibraryItems')
BEGIN
    print 'Altered: LibraryItems ,LibraryOwnerUserID';
    alter table [LibraryItems] add [LibraryOwnerUserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'LibraryItems')
BEGIN
    print 'Altered: LibraryItems ,RepoName';
    alter table [LibraryItems] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'LibraryItems')
BEGIN
    print 'Altered: LibraryItems ,RepoSvrName';
    alter table [LibraryItems] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'LibraryItems')
BEGIN
    print 'Altered: LibraryItems ,RowCreationDate';
    alter table [LibraryItems] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'LibraryItems')
BEGIN
    print 'Altered: LibraryItems ,RowGuid';
    alter table [LibraryItems] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'LibraryItems')
BEGIN
    print 'Altered: LibraryItems ,RowLastModDate';
    alter table [LibraryItems] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SourceGuid' and table_name = 'LibraryItems')
BEGIN
    print 'Altered: LibraryItems ,SourceGuid';
    alter table [LibraryItems] add [SourceGuid]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CreateAccess' and table_name = 'LibraryUsers')
BEGIN
    print 'Altered: LibraryUsers ,CreateAccess';
    alter table [LibraryUsers] add [CreateAccess]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'DeleteAccess' and table_name = 'LibraryUsers')
BEGIN
    print 'Altered: LibraryUsers ,DeleteAccess';
    alter table [LibraryUsers] add [DeleteAccess]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'GroupCnt' and table_name = 'LibraryUsers')
BEGIN
    print 'Altered: LibraryUsers ,GroupCnt';
    alter table [LibraryUsers] add [GroupCnt]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'GroupUser' and table_name = 'LibraryUsers')
BEGIN
    print 'Altered: LibraryUsers ,GroupUser';
    alter table [LibraryUsers] add [GroupUser]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'LibraryUsers')
BEGIN
    print 'Altered: LibraryUsers ,HiveActive';
    alter table [LibraryUsers] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'LibraryUsers')
BEGIN
    print 'Altered: LibraryUsers ,HiveConnectionName';
    alter table [LibraryUsers] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LibraryName' and table_name = 'LibraryUsers')
BEGIN
    print 'Altered: LibraryUsers ,LibraryName';
    alter table [LibraryUsers] add [LibraryName]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LibraryOwnerUserID' and table_name = 'LibraryUsers')
BEGIN
    print 'Altered: LibraryUsers ,LibraryOwnerUserID';
    alter table [LibraryUsers] add [LibraryOwnerUserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'NotAddedAsGroupMember' and table_name = 'LibraryUsers')
BEGIN
    print 'Altered: LibraryUsers ,NotAddedAsGroupMember';
    alter table [LibraryUsers] add [NotAddedAsGroupMember]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ReadOnly' and table_name = 'LibraryUsers')
BEGIN
    print 'Altered: LibraryUsers ,ReadOnly';
    alter table [LibraryUsers] add [ReadOnly]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'LibraryUsers')
BEGIN
    print 'Altered: LibraryUsers ,RepoName';
    alter table [LibraryUsers] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'LibraryUsers')
BEGIN
    print 'Altered: LibraryUsers ,RepoSvrName';
    alter table [LibraryUsers] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'LibraryUsers')
BEGIN
    print 'Altered: LibraryUsers ,RowCreationDate';
    alter table [LibraryUsers] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'LibraryUsers')
BEGIN
    print 'Altered: LibraryUsers ,RowGuid';
    alter table [LibraryUsers] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'LibraryUsers')
BEGIN
    print 'Altered: LibraryUsers ,RowLastModDate';
    alter table [LibraryUsers] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SingleUser' and table_name = 'LibraryUsers')
BEGIN
    print 'Altered: LibraryUsers ,SingleUser';
    alter table [LibraryUsers] add [SingleUser]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UpdateAccess' and table_name = 'LibraryUsers')
BEGIN
    print 'Altered: LibraryUsers ,UpdateAccess';
    alter table [LibraryUsers] add [UpdateAccess]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'LibraryUsers')
BEGIN
    print 'Altered: LibraryUsers ,UserID';
    alter table [LibraryUsers] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ActivationDate' and table_name = 'License')
BEGIN
    print 'Altered: License ,ActivationDate';
    alter table [License] add [ActivationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Agreement' and table_name = 'License')
BEGIN
    print 'Altered: License ,Agreement';
    alter table [License] add [Agreement]  nvarchar (2000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CustomerID' and table_name = 'License')
BEGIN
    print 'Altered: License ,CustomerID';
    alter table [License] add [CustomerID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CustomerName' and table_name = 'License')
BEGIN
    print 'Altered: License ,CustomerName';
    alter table [License] add [CustomerName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'License')
BEGIN
    print 'Altered: License ,HiveActive';
    alter table [License] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'License')
BEGIN
    print 'Altered: License ,HiveConnectionName';
    alter table [License] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'InstallDate' and table_name = 'License')
BEGIN
    print 'Altered: License ,InstallDate';
    alter table [License] add [InstallDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LicenseID' and table_name = 'License')
BEGIN
    print 'Altered: License ,LicenseID';
    alter table [License] add [LicenseID]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'MachineID' and table_name = 'License')
BEGIN
    print 'Altered: License ,MachineID';
    alter table [License] add [MachineID]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'License')
BEGIN
    print 'Altered: License ,RepoName';
    alter table [License] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'License')
BEGIN
    print 'Altered: License ,RepoSvrName';
    alter table [License] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'License')
BEGIN
    print 'Altered: License ,RowCreationDate';
    alter table [License] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'License')
BEGIN
    print 'Altered: License ,RowGuid';
    alter table [License] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'License')
BEGIN
    print 'Altered: License ,RowLastModDate';
    alter table [License] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ServerIdentifier' and table_name = 'License')
BEGIN
    print 'Altered: License ,ServerIdentifier';
    alter table [License] add [ServerIdentifier]  varchar (100)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ServerName' and table_name = 'License')
BEGIN
    print 'Altered: License ,ServerName';
    alter table [License] add [ServerName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SqlInstanceIdentifier' and table_name = 'License')
BEGIN
    print 'Altered: License ,SqlInstanceIdentifier';
    alter table [License] add [SqlInstanceIdentifier]  varchar (100)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SqlInstanceName' and table_name = 'License')
BEGIN
    print 'Altered: License ,SqlInstanceName';
    alter table [License] add [SqlInstanceName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SqlServerInstanceName' and table_name = 'License')
BEGIN
    print 'Altered: License ,SqlServerInstanceName';
    alter table [License] add [SqlServerInstanceName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SqlServerMachineName' and table_name = 'License')
BEGIN
    print 'Altered: License ,SqlServerMachineName';
    alter table [License] add [SqlServerMachineName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'VersionNbr' and table_name = 'License')
BEGIN
    print 'Altered: License ,VersionNbr';
    alter table [License] add [VersionNbr]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'XrtNxr1' and table_name = 'License')
BEGIN
    print 'Altered: License ,XrtNxr1';
    alter table [License] add [XrtNxr1]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'LoadProfile')
BEGIN
    print 'Altered: LoadProfile ,HiveActive';
    alter table [LoadProfile] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'LoadProfile')
BEGIN
    print 'Altered: LoadProfile ,HiveConnectionName';
    alter table [LoadProfile] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ProfileDesc' and table_name = 'LoadProfile')
BEGIN
    print 'Altered: LoadProfile ,ProfileDesc';
    alter table [LoadProfile] add [ProfileDesc]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ProfileName' and table_name = 'LoadProfile')
BEGIN
    print 'Altered: LoadProfile ,ProfileName';
    alter table [LoadProfile] add [ProfileName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'LoadProfile')
BEGIN
    print 'Altered: LoadProfile ,RepoName';
    alter table [LoadProfile] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'LoadProfile')
BEGIN
    print 'Altered: LoadProfile ,RepoSvrName';
    alter table [LoadProfile] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'LoadProfile')
BEGIN
    print 'Altered: LoadProfile ,RowCreationDate';
    alter table [LoadProfile] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'LoadProfile')
BEGIN
    print 'Altered: LoadProfile ,RowGuid';
    alter table [LoadProfile] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'LoadProfile')
BEGIN
    print 'Altered: LoadProfile ,RowLastModDate';
    alter table [LoadProfile] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'LoadProfileItem')
BEGIN
    print 'Altered: LoadProfileItem ,HiveActive';
    alter table [LoadProfileItem] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'LoadProfileItem')
BEGIN
    print 'Altered: LoadProfileItem ,HiveConnectionName';
    alter table [LoadProfileItem] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ProfileName' and table_name = 'LoadProfileItem')
BEGIN
    print 'Altered: LoadProfileItem ,ProfileName';
    alter table [LoadProfileItem] add [ProfileName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'LoadProfileItem')
BEGIN
    print 'Altered: LoadProfileItem ,RepoName';
    alter table [LoadProfileItem] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'LoadProfileItem')
BEGIN
    print 'Altered: LoadProfileItem ,RepoSvrName';
    alter table [LoadProfileItem] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'LoadProfileItem')
BEGIN
    print 'Altered: LoadProfileItem ,RowCreationDate';
    alter table [LoadProfileItem] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'LoadProfileItem')
BEGIN
    print 'Altered: LoadProfileItem ,RowGuid';
    alter table [LoadProfileItem] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'LoadProfileItem')
BEGIN
    print 'Altered: LoadProfileItem ,RowLastModDate';
    alter table [LoadProfileItem] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SourceTypeCode' and table_name = 'LoadProfileItem')
BEGIN
    print 'Altered: LoadProfileItem ,SourceTypeCode';
    alter table [LoadProfileItem] add [SourceTypeCode]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'LoginClient')
BEGIN
    print 'Altered: LoginClient ,HiveActive';
    alter table [LoginClient] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'LoginClient')
BEGIN
    print 'Altered: LoginClient ,HiveConnectionName';
    alter table [LoginClient] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LoginDate' and table_name = 'LoginClient')
BEGIN
    print 'Altered: LoginClient ,LoginDate';
    alter table [LoginClient] add [LoginDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'MachineName' and table_name = 'LoginClient')
BEGIN
    print 'Altered: LoginClient ,MachineName';
    alter table [LoginClient] add [MachineName]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'LoginClient')
BEGIN
    print 'Altered: LoginClient ,RepoName';
    alter table [LoginClient] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'LoginClient')
BEGIN
    print 'Altered: LoginClient ,RepoSvrName';
    alter table [LoginClient] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'LoginClient')
BEGIN
    print 'Altered: LoginClient ,RowCreationDate';
    alter table [LoginClient] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'LoginClient')
BEGIN
    print 'Altered: LoginClient ,RowGuid';
    alter table [LoginClient] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'LoginClient')
BEGIN
    print 'Altered: LoginClient ,RowLastModDate';
    alter table [LoginClient] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'LoginMachine')
BEGIN
    print 'Altered: LoginMachine ,HiveActive';
    alter table [LoginMachine] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'LoginMachine')
BEGIN
    print 'Altered: LoginMachine ,HiveConnectionName';
    alter table [LoginMachine] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LoginDate' and table_name = 'LoginMachine')
BEGIN
    print 'Altered: LoginMachine ,LoginDate';
    alter table [LoginMachine] add [LoginDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'MachineName' and table_name = 'LoginMachine')
BEGIN
    print 'Altered: LoginMachine ,MachineName';
    alter table [LoginMachine] add [MachineName]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'LoginMachine')
BEGIN
    print 'Altered: LoginMachine ,RepoName';
    alter table [LoginMachine] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'LoginMachine')
BEGIN
    print 'Altered: LoginMachine ,RepoSvrName';
    alter table [LoginMachine] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'LoginMachine')
BEGIN
    print 'Altered: LoginMachine ,RowCreationDate';
    alter table [LoginMachine] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'LoginMachine')
BEGIN
    print 'Altered: LoginMachine ,RowGuid';
    alter table [LoginMachine] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'LoginMachine')
BEGIN
    print 'Altered: LoginMachine ,RowLastModDate';
    alter table [LoginMachine] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'LoginUser')
BEGIN
    print 'Altered: LoginUser ,HiveActive';
    alter table [LoginUser] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'LoginUser')
BEGIN
    print 'Altered: LoginUser ,HiveConnectionName';
    alter table [LoginUser] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LoginDate' and table_name = 'LoginUser')
BEGIN
    print 'Altered: LoginUser ,LoginDate';
    alter table [LoginUser] add [LoginDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LoginID' and table_name = 'LoginUser')
BEGIN
    print 'Altered: LoginUser ,LoginID';
    alter table [LoginUser] add [LoginID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'LoginUser')
BEGIN
    print 'Altered: LoginUser ,RepoName';
    alter table [LoginUser] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'LoginUser')
BEGIN
    print 'Altered: LoginUser ,RepoSvrName';
    alter table [LoginUser] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'LoginUser')
BEGIN
    print 'Altered: LoginUser ,RowCreationDate';
    alter table [LoginUser] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'LoginUser')
BEGIN
    print 'Altered: LoginUser ,RowGuid';
    alter table [LoginUser] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'LoginUser')
BEGIN
    print 'Altered: LoginUser ,RowLastModDate';
    alter table [LoginUser] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'EntryDate' and table_name = 'Logs')
BEGIN
    print 'Altered: Logs ,EntryDate';
    alter table [Logs] add [EntryDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ErrorMsg' and table_name = 'Logs')
BEGIN
    print 'Altered: Logs ,ErrorMsg';
    alter table [Logs] add [ErrorMsg]  nvarchar (max)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'Logs')
BEGIN
    print 'Altered: Logs ,RepoName';
    alter table [Logs] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'Logs')
BEGIN
    print 'Altered: Logs ,RowGuid';
    alter table [Logs] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowNbr' and table_name = 'Logs')
BEGIN
    print 'Altered: Logs ,RowNbr';
    alter table [Logs] add [RowNbr]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UID' and table_name = 'Logs')
BEGIN
    print 'Altered: Logs ,UID';
    alter table [Logs] add [UID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ContentType' and table_name = 'Machine')
BEGIN
    print 'Altered: Machine ,ContentType';
    alter table [Machine] add [ContentType]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CreateDate' and table_name = 'Machine')
BEGIN
    print 'Altered: Machine ,CreateDate';
    alter table [Machine] add [CreateDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FQN' and table_name = 'Machine')
BEGIN
    print 'Altered: Machine ,FQN';
    alter table [Machine] add [FQN]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'Machine')
BEGIN
    print 'Altered: Machine ,HiveActive';
    alter table [Machine] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'Machine')
BEGIN
    print 'Altered: Machine ,HiveConnectionName';
    alter table [Machine] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LastUpdate' and table_name = 'Machine')
BEGIN
    print 'Altered: Machine ,LastUpdate';
    alter table [Machine] add [LastUpdate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'MachineName' and table_name = 'Machine')
BEGIN
    print 'Altered: Machine ,MachineName';
    alter table [Machine] add [MachineName]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'Machine')
BEGIN
    print 'Altered: Machine ,RepoName';
    alter table [Machine] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'Machine')
BEGIN
    print 'Altered: Machine ,RepoSvrName';
    alter table [Machine] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'Machine')
BEGIN
    print 'Altered: Machine ,RowCreationDate';
    alter table [Machine] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'Machine')
BEGIN
    print 'Altered: Machine ,RowGuid';
    alter table [Machine] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'Machine')
BEGIN
    print 'Altered: Machine ,RowLastModDate';
    alter table [Machine] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SourceGuid' and table_name = 'Machine')
BEGIN
    print 'Altered: Machine ,SourceGuid';
    alter table [Machine] add [SourceGuid]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'Machine')
BEGIN
    print 'Altered: Machine ,UserID';
    alter table [Machine] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CreateDate' and table_name = 'MachineRegistered')
BEGIN
    print 'Altered: MachineRegistered ,CreateDate';
    alter table [MachineRegistered] add [CreateDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'MachineRegistered')
BEGIN
    print 'Altered: MachineRegistered ,HiveActive';
    alter table [MachineRegistered] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'MachineRegistered')
BEGIN
    print 'Altered: MachineRegistered ,HiveConnectionName';
    alter table [MachineRegistered] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LastUpdate' and table_name = 'MachineRegistered')
BEGIN
    print 'Altered: MachineRegistered ,LastUpdate';
    alter table [MachineRegistered] add [LastUpdate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'MachineGuid' and table_name = 'MachineRegistered')
BEGIN
    print 'Altered: MachineRegistered ,MachineGuid';
    alter table [MachineRegistered] add [MachineGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'MachineName' and table_name = 'MachineRegistered')
BEGIN
    print 'Altered: MachineRegistered ,MachineName';
    alter table [MachineRegistered] add [MachineName]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'NetWorkName' and table_name = 'MachineRegistered')
BEGIN
    print 'Altered: MachineRegistered ,NetWorkName';
    alter table [MachineRegistered] add [NetWorkName]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'MachineRegistered')
BEGIN
    print 'Altered: MachineRegistered ,RepoName';
    alter table [MachineRegistered] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'MachineRegistered')
BEGIN
    print 'Altered: MachineRegistered ,RepoSvrName';
    alter table [MachineRegistered] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'MachineRegistered')
BEGIN
    print 'Altered: MachineRegistered ,RowCreationDate';
    alter table [MachineRegistered] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'MachineRegistered')
BEGIN
    print 'Altered: MachineRegistered ,RowGuid';
    alter table [MachineRegistered] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'MachineRegistered')
BEGIN
    print 'Altered: MachineRegistered ,RowLastModDate';
    alter table [MachineRegistered] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'docid' and table_name = 'MyTempTable')
BEGIN
    print 'Altered: MyTempTable ,docid';
    alter table [MyTempTable] add [docid]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'MyTempTable')
BEGIN
    print 'Altered: MyTempTable ,HiveActive';
    alter table [MyTempTable] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'MyTempTable')
BEGIN
    print 'Altered: MyTempTable ,HiveConnectionName';
    alter table [MyTempTable] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'key' and table_name = 'MyTempTable')
BEGIN
    print 'Altered: MyTempTable ,key';
    alter table [MyTempTable] add [key]  nvarchar (100)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'MyTempTable')
BEGIN
    print 'Altered: MyTempTable ,RepoName';
    alter table [MyTempTable] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'MyTempTable')
BEGIN
    print 'Altered: MyTempTable ,RepoSvrName';
    alter table [MyTempTable] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'MyTempTable')
BEGIN
    print 'Altered: MyTempTable ,RowCreationDate';
    alter table [MyTempTable] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'MyTempTable')
BEGIN
    print 'Altered: MyTempTable ,RowGuid';
    alter table [MyTempTable] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'MyTempTable')
BEGIN
    print 'Altered: MyTempTable ,RowLastModDate';
    alter table [MyTempTable] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FromEmailAddr' and table_name = 'OutlookFrom')
BEGIN
    print 'Altered: OutlookFrom ,FromEmailAddr';
    alter table [OutlookFrom] add [FromEmailAddr]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'OutlookFrom')
BEGIN
    print 'Altered: OutlookFrom ,HiveActive';
    alter table [OutlookFrom] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'OutlookFrom')
BEGIN
    print 'Altered: OutlookFrom ,HiveConnectionName';
    alter table [OutlookFrom] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'OutlookFrom')
BEGIN
    print 'Altered: OutlookFrom ,RepoName';
    alter table [OutlookFrom] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'OutlookFrom')
BEGIN
    print 'Altered: OutlookFrom ,RepoSvrName';
    alter table [OutlookFrom] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'OutlookFrom')
BEGIN
    print 'Altered: OutlookFrom ,RowCreationDate';
    alter table [OutlookFrom] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'OutlookFrom')
BEGIN
    print 'Altered: OutlookFrom ,RowGuid';
    alter table [OutlookFrom] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'OutlookFrom')
BEGIN
    print 'Altered: OutlookFrom ,RowLastModDate';
    alter table [OutlookFrom] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SenderName' and table_name = 'OutlookFrom')
BEGIN
    print 'Altered: OutlookFrom ,SenderName';
    alter table [OutlookFrom] add [SenderName]  varchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'OutlookFrom')
BEGIN
    print 'Altered: OutlookFrom ,UserID';
    alter table [OutlookFrom] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Verified' and table_name = 'OutlookFrom')
BEGIN
    print 'Altered: OutlookFrom ,Verified';
    alter table [OutlookFrom] add [Verified]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CreateDate' and table_name = 'OwnerHistory')
BEGIN
    print 'Altered: OwnerHistory ,CreateDate';
    alter table [OwnerHistory] add [CreateDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CurrentOwnerUserID' and table_name = 'OwnerHistory')
BEGIN
    print 'Altered: OwnerHistory ,CurrentOwnerUserID';
    alter table [OwnerHistory] add [CurrentOwnerUserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'OwnerHistory')
BEGIN
    print 'Altered: OwnerHistory ,HiveActive';
    alter table [OwnerHistory] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'OwnerHistory')
BEGIN
    print 'Altered: OwnerHistory ,HiveConnectionName';
    alter table [OwnerHistory] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'PreviousOwnerUserID' and table_name = 'OwnerHistory')
BEGIN
    print 'Altered: OwnerHistory ,PreviousOwnerUserID';
    alter table [OwnerHistory] add [PreviousOwnerUserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'OwnerHistory')
BEGIN
    print 'Altered: OwnerHistory ,RepoName';
    alter table [OwnerHistory] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'OwnerHistory')
BEGIN
    print 'Altered: OwnerHistory ,RepoSvrName';
    alter table [OwnerHistory] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'OwnerHistory')
BEGIN
    print 'Altered: OwnerHistory ,RowCreationDate';
    alter table [OwnerHistory] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'OwnerHistory')
BEGIN
    print 'Altered: OwnerHistory ,RowGuid';
    alter table [OwnerHistory] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowId' and table_name = 'OwnerHistory')
BEGIN
    print 'Altered: OwnerHistory ,RowId';
    alter table [OwnerHistory] add [RowId]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'OwnerHistory')
BEGIN
    print 'Altered: OwnerHistory ,RowLastModDate';
    alter table [OwnerHistory] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ConnectiveGuid' and table_name = 'PgmTrace')
BEGIN
    print 'Altered: PgmTrace ,ConnectiveGuid';
    alter table [PgmTrace] add [ConnectiveGuid]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CreateDate' and table_name = 'PgmTrace')
BEGIN
    print 'Altered: PgmTrace ,CreateDate';
    alter table [PgmTrace] add [CreateDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'PgmTrace')
BEGIN
    print 'Altered: PgmTrace ,HiveActive';
    alter table [PgmTrace] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'PgmTrace')
BEGIN
    print 'Altered: PgmTrace ,HiveConnectionName';
    alter table [PgmTrace] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'PgmName' and table_name = 'PgmTrace')
BEGIN
    print 'Altered: PgmTrace ,PgmName';
    alter table [PgmTrace] add [PgmName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'PgmTrace')
BEGIN
    print 'Altered: PgmTrace ,RepoName';
    alter table [PgmTrace] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'PgmTrace')
BEGIN
    print 'Altered: PgmTrace ,RepoSvrName';
    alter table [PgmTrace] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'PgmTrace')
BEGIN
    print 'Altered: PgmTrace ,RowCreationDate';
    alter table [PgmTrace] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'PgmTrace')
BEGIN
    print 'Altered: PgmTrace ,RowGuid';
    alter table [PgmTrace] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowID' and table_name = 'PgmTrace')
BEGIN
    print 'Altered: PgmTrace ,RowID';
    alter table [PgmTrace] add [RowID]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'PgmTrace')
BEGIN
    print 'Altered: PgmTrace ,RowLastModDate';
    alter table [PgmTrace] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Stmt' and table_name = 'PgmTrace')
BEGIN
    print 'Altered: PgmTrace ,Stmt';
    alter table [PgmTrace] add [Stmt]  nvarchar (max)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'StmtID' and table_name = 'PgmTrace')
BEGIN
    print 'Altered: PgmTrace ,StmtID';
    alter table [PgmTrace] add [StmtID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'PgmTrace')
BEGIN
    print 'Altered: PgmTrace ,UserID';
    alter table [PgmTrace] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Applied' and table_name = 'ProcessFileAs')
BEGIN
    print 'Altered: ProcessFileAs ,Applied';
    alter table [ProcessFileAs] add [Applied]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ExtCode' and table_name = 'ProcessFileAs')
BEGIN
    print 'Altered: ProcessFileAs ,ExtCode';
    alter table [ProcessFileAs] add [ExtCode]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'ProcessFileAs')
BEGIN
    print 'Altered: ProcessFileAs ,HiveActive';
    alter table [ProcessFileAs] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'ProcessFileAs')
BEGIN
    print 'Altered: ProcessFileAs ,HiveConnectionName';
    alter table [ProcessFileAs] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ProcessExtCode' and table_name = 'ProcessFileAs')
BEGIN
    print 'Altered: ProcessFileAs ,ProcessExtCode';
    alter table [ProcessFileAs] add [ProcessExtCode]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'ProcessFileAs')
BEGIN
    print 'Altered: ProcessFileAs ,RepoName';
    alter table [ProcessFileAs] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'ProcessFileAs')
BEGIN
    print 'Altered: ProcessFileAs ,RepoSvrName';
    alter table [ProcessFileAs] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'ProcessFileAs')
BEGIN
    print 'Altered: ProcessFileAs ,RowCreationDate';
    alter table [ProcessFileAs] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'ProcessFileAs')
BEGIN
    print 'Altered: ProcessFileAs ,RowGuid';
    alter table [ProcessFileAs] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'ProcessFileAs')
BEGIN
    print 'Altered: ProcessFileAs ,RowLastModDate';
    alter table [ProcessFileAs] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CaptureItemsCode' and table_name = 'ProdCaptureItems')
BEGIN
    print 'Altered: ProdCaptureItems ,CaptureItemsCode';
    alter table [ProdCaptureItems] add [CaptureItemsCode]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ContainerType' and table_name = 'ProdCaptureItems')
BEGIN
    print 'Altered: ProdCaptureItems ,ContainerType';
    alter table [ProdCaptureItems] add [ContainerType]  nvarchar (25)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CorpFuncName' and table_name = 'ProdCaptureItems')
BEGIN
    print 'Altered: ProdCaptureItems ,CorpFuncName';
    alter table [ProdCaptureItems] add [CorpFuncName]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CorpName' and table_name = 'ProdCaptureItems')
BEGIN
    print 'Altered: ProdCaptureItems ,CorpName';
    alter table [ProdCaptureItems] add [CorpName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'ProdCaptureItems')
BEGIN
    print 'Altered: ProdCaptureItems ,HiveActive';
    alter table [ProdCaptureItems] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'ProdCaptureItems')
BEGIN
    print 'Altered: ProdCaptureItems ,HiveConnectionName';
    alter table [ProdCaptureItems] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'ProdCaptureItems')
BEGIN
    print 'Altered: ProdCaptureItems ,RepoName';
    alter table [ProdCaptureItems] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'ProdCaptureItems')
BEGIN
    print 'Altered: ProdCaptureItems ,RepoSvrName';
    alter table [ProdCaptureItems] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'ProdCaptureItems')
BEGIN
    print 'Altered: ProdCaptureItems ,RowCreationDate';
    alter table [ProdCaptureItems] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'ProdCaptureItems')
BEGIN
    print 'Altered: ProdCaptureItems ,RowGuid';
    alter table [ProdCaptureItems] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'ProdCaptureItems')
BEGIN
    print 'Altered: ProdCaptureItems ,RowLastModDate';
    alter table [ProdCaptureItems] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SendAlert' and table_name = 'ProdCaptureItems')
BEGIN
    print 'Altered: ProdCaptureItems ,SendAlert';
    alter table [ProdCaptureItems] add [SendAlert]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CreateDate' and table_name = 'QtyDocs')
BEGIN
    print 'Altered: QtyDocs ,CreateDate';
    alter table [QtyDocs] add [CreateDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Description' and table_name = 'QtyDocs')
BEGIN
    print 'Altered: QtyDocs ,Description';
    alter table [QtyDocs] add [Description]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'QtyDocs')
BEGIN
    print 'Altered: QtyDocs ,HiveActive';
    alter table [QtyDocs] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'QtyDocs')
BEGIN
    print 'Altered: QtyDocs ,HiveConnectionName';
    alter table [QtyDocs] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'QtyDocCode' and table_name = 'QtyDocs')
BEGIN
    print 'Altered: QtyDocs ,QtyDocCode';
    alter table [QtyDocs] add [QtyDocCode]  nvarchar (10)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'QtyDocs')
BEGIN
    print 'Altered: QtyDocs ,RepoName';
    alter table [QtyDocs] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'QtyDocs')
BEGIN
    print 'Altered: QtyDocs ,RepoSvrName';
    alter table [QtyDocs] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'QtyDocs')
BEGIN
    print 'Altered: QtyDocs ,RowCreationDate';
    alter table [QtyDocs] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'QtyDocs')
BEGIN
    print 'Altered: QtyDocs ,RowGuid';
    alter table [QtyDocs] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'QtyDocs')
BEGIN
    print 'Altered: QtyDocs ,RowLastModDate';
    alter table [QtyDocs] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Accounts' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,Accounts';
    alter table [Query] add [Accounts]  nvarchar (2000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'AllRecipients' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,AllRecipients';
    alter table [Query] add [AllRecipients]  ntext; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Bcc' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,Bcc';
    alter table [Query] add [Bcc]  ntext; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'BillingInformation' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,BillingInformation';
    alter table [Query] add [BillingInformation]  nvarchar (200)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Body' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,Body';
    alter table [Query] add [Body]  text; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'BPS' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,BPS';
    alter table [Query] add [BPS]  float; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CC' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,CC';
    alter table [Query] add [CC]  ntext; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Companies' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,Companies';
    alter table [Query] add [Companies]  nvarchar (2000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CompressedSize' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,CompressedSize';
    alter table [Query] add [CompressedSize]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ContainsAttachment' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,ContainsAttachment';
    alter table [Query] add [ContainsAttachment]  char (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ConvertEmlToMSG' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,ConvertEmlToMSG';
    alter table [Query] add [ConvertEmlToMSG]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CRC' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,CRC';
    alter table [Query] add [CRC]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CreationDate' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,CreationDate';
    alter table [Query] add [CreationDate]  datetime2; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CreationTime' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,CreationTime';
    alter table [Query] add [CreationTime]  datetime2; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CurrMailFolderID' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,CurrMailFolderID';
    alter table [Query] add [CurrMailFolderID]  nvarchar (300)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'DeferredDeliveryTime' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,DeferredDeliveryTime';
    alter table [Query] add [DeferredDeliveryTime]  datetime2; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Description' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,Description';
    alter table [Query] add [Description]  ntext; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'EmailGuid' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,EmailGuid';
    alter table [Query] add [EmailGuid]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'EmailIdentifier' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,EmailIdentifier';
    alter table [Query] add [EmailIdentifier]  nvarchar (450)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'EmailImage' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,EmailImage';
    alter table [Query] add [EmailImage]  image ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'EntryID' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,EntryID';
    alter table [Query] add [EntryID]  varchar (150)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ExpiryTime' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,ExpiryTime';
    alter table [Query] add [ExpiryTime]  datetime2; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FileAttached' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,FileAttached';
    alter table [Query] add [FileAttached]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HashFile' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,HashFile';
    alter table [Query] add [HashFile]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HashName' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,HashName';
    alter table [Query] add [HashName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,HiveActive';
    alter table [Query] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,HiveConnectionName';
    alter table [Query] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'isAvailable' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,isAvailable';
    alter table [Query] add [isAvailable]  nchar (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'isMaster' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,isMaster';
    alter table [Query] add [isMaster]  nchar (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'isPerm' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,isPerm';
    alter table [Query] add [isPerm]  nchar (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'isPublic' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,isPublic';
    alter table [Query] add [isPublic]  nchar (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'IsPublicPreviousState' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,IsPublicPreviousState';
    alter table [Query] add [IsPublicPreviousState]  nchar (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'KeyWords' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,KeyWords';
    alter table [Query] add [KeyWords]  nvarchar (2000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LastModificationTime' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,LastModificationTime';
    alter table [Query] add [LastModificationTime]  datetime2; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'MachineID' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,MachineID';
    alter table [Query] add [MachineID]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'MsgSize' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,MsgSize';
    alter table [Query] add [MsgSize]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'NbrAttachment' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,NbrAttachment';
    alter table [Query] add [NbrAttachment]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'NbrAttachments' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,NbrAttachments';
    alter table [Query] add [NbrAttachments]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'NbrOccurances' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,NbrOccurances';
    alter table [Query] add [NbrOccurances]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'NbrZipFiles' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,NbrZipFiles';
    alter table [Query] add [NbrZipFiles]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'NbrZipFilesCnt' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,NbrZipFilesCnt';
    alter table [Query] add [NbrZipFilesCnt]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'notes' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,notes';
    alter table [Query] add [notes]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'OriginalFolder' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,OriginalFolder';
    alter table [Query] add [OriginalFolder]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'OriginalSize' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,OriginalSize';
    alter table [Query] add [OriginalSize]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'PdfImages' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,PdfImages';
    alter table [Query] add [PdfImages]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'PdfIsSearchable' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,PdfIsSearchable';
    alter table [Query] add [PdfIsSearchable]  char (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'PdfOcrRequired' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,PdfOcrRequired';
    alter table [Query] add [PdfOcrRequired]  char (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'PdfOcrSuccess' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,PdfOcrSuccess';
    alter table [Query] add [PdfOcrSuccess]  char (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'PdfOcrTextExtracted' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,PdfOcrTextExtracted';
    alter table [Query] add [PdfOcrTextExtracted]  char (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'PdfPages' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,PdfPages';
    alter table [Query] add [PdfPages]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ReadReceiptRequested' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,ReadReceiptRequested';
    alter table [Query] add [ReadReceiptRequested]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ReceivedByName' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,ReceivedByName';
    alter table [Query] add [ReceivedByName]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ReceivedTime' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,ReceivedTime';
    alter table [Query] add [ReceivedTime]  datetime2; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RecHash' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,RecHash';
    alter table [Query] add [RecHash]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RecLen' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,RecLen';
    alter table [Query] add [RecLen]  float; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,RepoName';
    alter table [Query] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,RepoSvrName';
    alter table [Query] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RetentionCode' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,RetentionCode';
    alter table [Query] add [RetentionCode]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RetentionExpirationDate' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,RetentionExpirationDate';
    alter table [Query] add [RetentionExpirationDate]  datetime2; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,RowCreationDate';
    alter table [Query] add [RowCreationDate]  datetime2; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,RowGuid';
    alter table [Query] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowID' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,RowID';
    alter table [Query] add [RowID]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,RowLastModDate';
    alter table [Query] add [RowLastModDate]  datetime2; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SenderEmailAddress' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,SenderEmailAddress';
    alter table [Query] add [SenderEmailAddress]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SenderName' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,SenderName';
    alter table [Query] add [SenderName]  nvarchar (100)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Sensitivity' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,Sensitivity';
    alter table [Query] add [Sensitivity]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SentOn' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,SentOn';
    alter table [Query] add [SentOn]  datetime2; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SentTO' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,SentTO';
    alter table [Query] add [SentTO]  ntext; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ShortSubj' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,ShortSubj';
    alter table [Query] add [ShortSubj]  nvarchar (250)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SourceTypeCode' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,SourceTypeCode';
    alter table [Query] add [SourceTypeCode]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'StoreID' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,StoreID';
    alter table [Query] add [StoreID]  varchar (750)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SUBJECT' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,SUBJECT';
    alter table [Query] add [SUBJECT]  nvarchar (2000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'TransmitTime' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,TransmitTime';
    alter table [Query] add [TransmitTime]  float; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'txEndTime' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,txEndTime';
    alter table [Query] add [txEndTime]  datetime2; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'txStartTime' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,txStartTime';
    alter table [Query] add [txStartTime]  datetime2; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'txTotalTime' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,txTotalTime';
    alter table [Query] add [txTotalTime]  float; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UIDL' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,UIDL';
    alter table [Query] add [UIDL]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'Query')
BEGIN
    print 'Altered: Query ,UserID';
    alter table [Query] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ckDisableDir' and table_name = 'QuickDirectory')
BEGIN
    print 'Altered: QuickDirectory ,ckDisableDir';
    alter table [QuickDirectory] add [ckDisableDir]  nchar (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ckMetaData' and table_name = 'QuickDirectory')
BEGIN
    print 'Altered: QuickDirectory ,ckMetaData';
    alter table [QuickDirectory] add [ckMetaData]  nchar (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ckPublic' and table_name = 'QuickDirectory')
BEGIN
    print 'Altered: QuickDirectory ,ckPublic';
    alter table [QuickDirectory] add [ckPublic]  nchar (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'DB_ID' and table_name = 'QuickDirectory')
BEGIN
    print 'Altered: QuickDirectory ,DB_ID';
    alter table [QuickDirectory] add [DB_ID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FQN' and table_name = 'QuickDirectory')
BEGIN
    print 'Altered: QuickDirectory ,FQN';
    alter table [QuickDirectory] add [FQN]  varchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'QuickDirectory')
BEGIN
    print 'Altered: QuickDirectory ,HiveActive';
    alter table [QuickDirectory] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'QuickDirectory')
BEGIN
    print 'Altered: QuickDirectory ,HiveConnectionName';
    alter table [QuickDirectory] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'IncludeSubDirs' and table_name = 'QuickDirectory')
BEGIN
    print 'Altered: QuickDirectory ,IncludeSubDirs';
    alter table [QuickDirectory] add [IncludeSubDirs]  char (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'QuickRefEntry' and table_name = 'QuickDirectory')
BEGIN
    print 'Altered: QuickDirectory ,QuickRefEntry';
    alter table [QuickDirectory] add [QuickRefEntry]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'QuickDirectory')
BEGIN
    print 'Altered: QuickDirectory ,RepoName';
    alter table [QuickDirectory] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'QuickDirectory')
BEGIN
    print 'Altered: QuickDirectory ,RepoSvrName';
    alter table [QuickDirectory] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RetentionCode' and table_name = 'QuickDirectory')
BEGIN
    print 'Altered: QuickDirectory ,RetentionCode';
    alter table [QuickDirectory] add [RetentionCode]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'QuickDirectory')
BEGIN
    print 'Altered: QuickDirectory ,RowCreationDate';
    alter table [QuickDirectory] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'QuickDirectory')
BEGIN
    print 'Altered: QuickDirectory ,RowGuid';
    alter table [QuickDirectory] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'QuickDirectory')
BEGIN
    print 'Altered: QuickDirectory ,RowLastModDate';
    alter table [QuickDirectory] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'QuickDirectory')
BEGIN
    print 'Altered: QuickDirectory ,UserID';
    alter table [QuickDirectory] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'VersionFiles' and table_name = 'QuickDirectory')
BEGIN
    print 'Altered: QuickDirectory ,VersionFiles';
    alter table [QuickDirectory] add [VersionFiles]  char (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'QuickRef')
BEGIN
    print 'Altered: QuickRef ,HiveActive';
    alter table [QuickRef] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'QuickRef')
BEGIN
    print 'Altered: QuickRef ,HiveConnectionName';
    alter table [QuickRef] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'QuickRefIdNbr' and table_name = 'QuickRef')
BEGIN
    print 'Altered: QuickRef ,QuickRefIdNbr';
    alter table [QuickRef] add [QuickRefIdNbr]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'QuickRefName' and table_name = 'QuickRef')
BEGIN
    print 'Altered: QuickRef ,QuickRefName';
    alter table [QuickRef] add [QuickRefName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'QuickRef')
BEGIN
    print 'Altered: QuickRef ,RepoName';
    alter table [QuickRef] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'QuickRef')
BEGIN
    print 'Altered: QuickRef ,RepoSvrName';
    alter table [QuickRef] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'QuickRef')
BEGIN
    print 'Altered: QuickRef ,RowCreationDate';
    alter table [QuickRef] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'QuickRef')
BEGIN
    print 'Altered: QuickRef ,RowGuid';
    alter table [QuickRef] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'QuickRef')
BEGIN
    print 'Altered: QuickRef ,RowLastModDate';
    alter table [QuickRef] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'QuickRef')
BEGIN
    print 'Altered: QuickRef ,UserID';
    alter table [QuickRef] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Author' and table_name = 'QuickRefItems')
BEGIN
    print 'Altered: QuickRefItems ,Author';
    alter table [QuickRefItems] add [Author]  nvarchar (300)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'DataSourceOwnerUserID' and table_name = 'QuickRefItems')
BEGIN
    print 'Altered: QuickRefItems ,DataSourceOwnerUserID';
    alter table [QuickRefItems] add [DataSourceOwnerUserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Description' and table_name = 'QuickRefItems')
BEGIN
    print 'Altered: QuickRefItems ,Description';
    alter table [QuickRefItems] add [Description]  nvarchar (max)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'DirName' and table_name = 'QuickRefItems')
BEGIN
    print 'Altered: QuickRefItems ,DirName';
    alter table [QuickRefItems] add [DirName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FileName' and table_name = 'QuickRefItems')
BEGIN
    print 'Altered: QuickRefItems ,FileName';
    alter table [QuickRefItems] add [FileName]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FQN' and table_name = 'QuickRefItems')
BEGIN
    print 'Altered: QuickRefItems ,FQN';
    alter table [QuickRefItems] add [FQN]  nvarchar (300)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'QuickRefItems')
BEGIN
    print 'Altered: QuickRefItems ,HiveActive';
    alter table [QuickRefItems] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'QuickRefItems')
BEGIN
    print 'Altered: QuickRefItems ,HiveConnectionName';
    alter table [QuickRefItems] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Keywords' and table_name = 'QuickRefItems')
BEGIN
    print 'Altered: QuickRefItems ,Keywords';
    alter table [QuickRefItems] add [Keywords]  nvarchar (2000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Library' and table_name = 'QuickRefItems')
BEGIN
    print 'Altered: QuickRefItems ,Library';
    alter table [QuickRefItems] add [Library]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'MarkedForDeletion' and table_name = 'QuickRefItems')
BEGIN
    print 'Altered: QuickRefItems ,MarkedForDeletion';
    alter table [QuickRefItems] add [MarkedForDeletion]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'MetadataTag' and table_name = 'QuickRefItems')
BEGIN
    print 'Altered: QuickRefItems ,MetadataTag';
    alter table [QuickRefItems] add [MetadataTag]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'MetadataValue' and table_name = 'QuickRefItems')
BEGIN
    print 'Altered: QuickRefItems ,MetadataValue';
    alter table [QuickRefItems] add [MetadataValue]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'QuickRefIdNbr' and table_name = 'QuickRefItems')
BEGIN
    print 'Altered: QuickRefItems ,QuickRefIdNbr';
    alter table [QuickRefItems] add [QuickRefIdNbr]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'QuickRefItemGuid' and table_name = 'QuickRefItems')
BEGIN
    print 'Altered: QuickRefItems ,QuickRefItemGuid';
    alter table [QuickRefItems] add [QuickRefItemGuid]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'QuickRefItems')
BEGIN
    print 'Altered: QuickRefItems ,RepoName';
    alter table [QuickRefItems] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'QuickRefItems')
BEGIN
    print 'Altered: QuickRefItems ,RepoSvrName';
    alter table [QuickRefItems] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RetentionCode' and table_name = 'QuickRefItems')
BEGIN
    print 'Altered: QuickRefItems ,RetentionCode';
    alter table [QuickRefItems] add [RetentionCode]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'QuickRefItems')
BEGIN
    print 'Altered: QuickRefItems ,RowCreationDate';
    alter table [QuickRefItems] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'QuickRefItems')
BEGIN
    print 'Altered: QuickRefItems ,RowGuid';
    alter table [QuickRefItems] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'QuickRefItems')
BEGIN
    print 'Altered: QuickRefItems ,RowLastModDate';
    alter table [QuickRefItems] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SourceGuid' and table_name = 'QuickRefItems')
BEGIN
    print 'Altered: QuickRefItems ,SourceGuid';
    alter table [QuickRefItems] add [SourceGuid]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'EmailGuid' and table_name = 'Recipients')
BEGIN
    print 'Altered: Recipients ,EmailGuid';
    alter table [Recipients] add [EmailGuid]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'Recipients')
BEGIN
    print 'Altered: Recipients ,HiveActive';
    alter table [Recipients] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'Recipients')
BEGIN
    print 'Altered: Recipients ,HiveConnectionName';
    alter table [Recipients] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Recipient' and table_name = 'Recipients')
BEGIN
    print 'Altered: Recipients ,Recipient';
    alter table [Recipients] add [Recipient]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'Recipients')
BEGIN
    print 'Altered: Recipients ,RepoName';
    alter table [Recipients] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'Recipients')
BEGIN
    print 'Altered: Recipients ,RepoSvrName';
    alter table [Recipients] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'Recipients')
BEGIN
    print 'Altered: Recipients ,RowCreationDate';
    alter table [Recipients] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'Recipients')
BEGIN
    print 'Altered: Recipients ,RowGuid';
    alter table [Recipients] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'Recipients')
BEGIN
    print 'Altered: Recipients ,RowLastModDate';
    alter table [Recipients] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'TypeRecp' and table_name = 'Recipients')
BEGIN
    print 'Altered: Recipients ,TypeRecp';
    alter table [Recipients] add [TypeRecp]  nchar (10)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'RepeatData')
BEGIN
    print 'Altered: RepeatData ,HiveActive';
    alter table [RepeatData] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'RepeatData')
BEGIN
    print 'Altered: RepeatData ,HiveConnectionName';
    alter table [RepeatData] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepeatDataCode' and table_name = 'RepeatData')
BEGIN
    print 'Altered: RepeatData ,RepeatDataCode';
    alter table [RepeatData] add [RepeatDataCode]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepeatDataDesc' and table_name = 'RepeatData')
BEGIN
    print 'Altered: RepeatData ,RepeatDataDesc';
    alter table [RepeatData] add [RepeatDataDesc]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'RepeatData')
BEGIN
    print 'Altered: RepeatData ,RepoName';
    alter table [RepeatData] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'RepeatData')
BEGIN
    print 'Altered: RepeatData ,RepoSvrName';
    alter table [RepeatData] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'RepeatData')
BEGIN
    print 'Altered: RepeatData ,RowCreationDate';
    alter table [RepeatData] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'RepeatData')
BEGIN
    print 'Altered: RepeatData ,RowGuid';
    alter table [RepeatData] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'RepeatData')
BEGIN
    print 'Altered: RepeatData ,RowLastModDate';
    alter table [RepeatData] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CreateDate' and table_name = 'reports')
BEGIN
    print 'Altered: reports ,CreateDate';
    alter table [reports] add [CreateDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'reports')
BEGIN
    print 'Altered: reports ,HiveActive';
    alter table [reports] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'reports')
BEGIN
    print 'Altered: reports ,HiveConnectionName';
    alter table [reports] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'reports')
BEGIN
    print 'Altered: reports ,RepoName';
    alter table [reports] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'reports')
BEGIN
    print 'Altered: reports ,RepoSvrName';
    alter table [reports] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'reports')
BEGIN
    print 'Altered: reports ,RowCreationDate';
    alter table [reports] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'reports')
BEGIN
    print 'Altered: reports ,RowGuid';
    alter table [reports] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'reports')
BEGIN
    print 'Altered: reports ,RowLastModDate';
    alter table [reports] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'rptCreatedForCustomerID' and table_name = 'reports')
BEGIN
    print 'Altered: reports ,rptCreatedForCustomerID';
    alter table [reports] add [rptCreatedForCustomerID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'rptDesc' and table_name = 'reports')
BEGIN
    print 'Altered: reports ,rptDesc';
    alter table [reports] add [rptDesc]  nvarchar (1000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'rptDisplayname' and table_name = 'reports')
BEGIN
    print 'Altered: reports ,rptDisplayname';
    alter table [reports] add [rptDisplayname]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'rptExists' and table_name = 'reports')
BEGIN
    print 'Altered: reports ,rptExists';
    alter table [reports] add [rptExists]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'rptFqn' and table_name = 'reports')
BEGIN
    print 'Altered: reports ,rptFqn';
    alter table [reports] add [rptFqn]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'rptFqnDate' and table_name = 'reports')
BEGIN
    print 'Altered: reports ,rptFqnDate';
    alter table [reports] add [rptFqnDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ConnectionData' and table_name = 'Repository')
BEGIN
    print 'Altered: Repository ,ConnectionData';
    alter table [Repository] add [ConnectionData]  nvarchar (2000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ConnectionDataThesaurus' and table_name = 'Repository')
BEGIN
    print 'Altered: Repository ,ConnectionDataThesaurus';
    alter table [Repository] add [ConnectionDataThesaurus]  nvarchar (2000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ConnectionName' and table_name = 'Repository')
BEGIN
    print 'Altered: Repository ,ConnectionName';
    alter table [Repository] add [ConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'Repository')
BEGIN
    print 'Altered: Repository ,RepoName';
    alter table [Repository] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'Repository')
BEGIN
    print 'Altered: Repository ,RowGuid';
    alter table [Repository] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'RestorationHistory')
BEGIN
    print 'Altered: RestorationHistory ,HiveActive';
    alter table [RestorationHistory] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'RestorationHistory')
BEGIN
    print 'Altered: RestorationHistory ,HiveConnectionName';
    alter table [RestorationHistory] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'OriginalCrc' and table_name = 'RestorationHistory')
BEGIN
    print 'Altered: RestorationHistory ,OriginalCrc';
    alter table [RestorationHistory] add [OriginalCrc]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'RestorationHistory')
BEGIN
    print 'Altered: RestorationHistory ,RepoName';
    alter table [RestorationHistory] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'RestorationHistory')
BEGIN
    print 'Altered: RestorationHistory ,RepoSvrName';
    alter table [RestorationHistory] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RestorationDate' and table_name = 'RestorationHistory')
BEGIN
    print 'Altered: RestorationHistory ,RestorationDate';
    alter table [RestorationHistory] add [RestorationDate]  nchar (10)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RestorationID' and table_name = 'RestorationHistory')
BEGIN
    print 'Altered: RestorationHistory ,RestorationID';
    alter table [RestorationHistory] add [RestorationID]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RestoredBy' and table_name = 'RestorationHistory')
BEGIN
    print 'Altered: RestorationHistory ,RestoredBy';
    alter table [RestorationHistory] add [RestoredBy]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RestoredCrc' and table_name = 'RestorationHistory')
BEGIN
    print 'Altered: RestorationHistory ,RestoredCrc';
    alter table [RestorationHistory] add [RestoredCrc]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'RestorationHistory')
BEGIN
    print 'Altered: RestorationHistory ,RowCreationDate';
    alter table [RestorationHistory] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'RestorationHistory')
BEGIN
    print 'Altered: RestorationHistory ,RowGuid';
    alter table [RestorationHistory] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'RestorationHistory')
BEGIN
    print 'Altered: RestorationHistory ,RowLastModDate';
    alter table [RestorationHistory] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SourceGuid' and table_name = 'RestorationHistory')
BEGIN
    print 'Altered: RestorationHistory ,SourceGuid';
    alter table [RestorationHistory] add [SourceGuid]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SourceType' and table_name = 'RestorationHistory')
BEGIN
    print 'Altered: RestorationHistory ,SourceType';
    alter table [RestorationHistory] add [SourceType]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ContentGuid' and table_name = 'RestoreQueue')
BEGIN
    print 'Altered: RestoreQueue ,ContentGuid';
    alter table [RestoreQueue] add [ContentGuid]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ContentType' and table_name = 'RestoreQueue')
BEGIN
    print 'Altered: RestoreQueue ,ContentType';
    alter table [RestoreQueue] add [ContentType]  varchar (15)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'EndDownloadTime' and table_name = 'RestoreQueue')
BEGIN
    print 'Altered: RestoreQueue ,EndDownloadTime';
    alter table [RestoreQueue] add [EndDownloadTime]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'EntryDate' and table_name = 'RestoreQueue')
BEGIN
    print 'Altered: RestoreQueue ,EntryDate';
    alter table [RestoreQueue] add [EntryDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FileSize' and table_name = 'RestoreQueue')
BEGIN
    print 'Altered: RestoreQueue ,FileSize';
    alter table [RestoreQueue] add [FileSize]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FQN' and table_name = 'RestoreQueue')
BEGIN
    print 'Altered: RestoreQueue ,FQN';
    alter table [RestoreQueue] add [FQN]  nvarchar (2500)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'MachineID' and table_name = 'RestoreQueue')
BEGIN
    print 'Altered: RestoreQueue ,MachineID';
    alter table [RestoreQueue] add [MachineID]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Preview' and table_name = 'RestoreQueue')
BEGIN
    print 'Altered: RestoreQueue ,Preview';
    alter table [RestoreQueue] add [Preview]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ProcessedDate' and table_name = 'RestoreQueue')
BEGIN
    print 'Altered: RestoreQueue ,ProcessedDate';
    alter table [RestoreQueue] add [ProcessedDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ProcessingCompleted' and table_name = 'RestoreQueue')
BEGIN
    print 'Altered: RestoreQueue ,ProcessingCompleted';
    alter table [RestoreQueue] add [ProcessingCompleted]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'RestoreQueue')
BEGIN
    print 'Altered: RestoreQueue ,RepoName';
    alter table [RestoreQueue] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Restore' and table_name = 'RestoreQueue')
BEGIN
    print 'Altered: RestoreQueue ,Restore';
    alter table [RestoreQueue] add [Restore]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'RestoreQueue')
BEGIN
    print 'Altered: RestoreQueue ,RowGuid';
    alter table [RestoreQueue] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'StartDownloadTime' and table_name = 'RestoreQueue')
BEGIN
    print 'Altered: RestoreQueue ,StartDownloadTime';
    alter table [RestoreQueue] add [StartDownloadTime]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'RestoreQueue')
BEGIN
    print 'Altered: RestoreQueue ,UserID';
    alter table [RestoreQueue] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ContentGuid' and table_name = 'RestoreQueueHistory')
BEGIN
    print 'Altered: RestoreQueueHistory ,ContentGuid';
    alter table [RestoreQueueHistory] add [ContentGuid]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ContentType' and table_name = 'RestoreQueueHistory')
BEGIN
    print 'Altered: RestoreQueueHistory ,ContentType';
    alter table [RestoreQueueHistory] add [ContentType]  varchar (15)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'EndDownloadTime' and table_name = 'RestoreQueueHistory')
BEGIN
    print 'Altered: RestoreQueueHistory ,EndDownloadTime';
    alter table [RestoreQueueHistory] add [EndDownloadTime]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'EntryDate' and table_name = 'RestoreQueueHistory')
BEGIN
    print 'Altered: RestoreQueueHistory ,EntryDate';
    alter table [RestoreQueueHistory] add [EntryDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FileSize' and table_name = 'RestoreQueueHistory')
BEGIN
    print 'Altered: RestoreQueueHistory ,FileSize';
    alter table [RestoreQueueHistory] add [FileSize]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FQN' and table_name = 'RestoreQueueHistory')
BEGIN
    print 'Altered: RestoreQueueHistory ,FQN';
    alter table [RestoreQueueHistory] add [FQN]  nvarchar (2500)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'MachineID' and table_name = 'RestoreQueueHistory')
BEGIN
    print 'Altered: RestoreQueueHistory ,MachineID';
    alter table [RestoreQueueHistory] add [MachineID]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Preview' and table_name = 'RestoreQueueHistory')
BEGIN
    print 'Altered: RestoreQueueHistory ,Preview';
    alter table [RestoreQueueHistory] add [Preview]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ProcessedDate' and table_name = 'RestoreQueueHistory')
BEGIN
    print 'Altered: RestoreQueueHistory ,ProcessedDate';
    alter table [RestoreQueueHistory] add [ProcessedDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ProcessingCompleted' and table_name = 'RestoreQueueHistory')
BEGIN
    print 'Altered: RestoreQueueHistory ,ProcessingCompleted';
    alter table [RestoreQueueHistory] add [ProcessingCompleted]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'RestoreQueueHistory')
BEGIN
    print 'Altered: RestoreQueueHistory ,RepoName';
    alter table [RestoreQueueHistory] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Restore' and table_name = 'RestoreQueueHistory')
BEGIN
    print 'Altered: RestoreQueueHistory ,Restore';
    alter table [RestoreQueueHistory] add [Restore]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'RestoreQueueHistory')
BEGIN
    print 'Altered: RestoreQueueHistory ,RowGuid';
    alter table [RestoreQueueHistory] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'StartDownloadTime' and table_name = 'RestoreQueueHistory')
BEGIN
    print 'Altered: RestoreQueueHistory ,StartDownloadTime';
    alter table [RestoreQueueHistory] add [StartDownloadTime]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UseriD' and table_name = 'RestoreQueueHistory')
BEGIN
    print 'Altered: RestoreQueueHistory ,UseriD';
    alter table [RestoreQueueHistory] add [UseriD]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'DaysWarning' and table_name = 'Retention')
BEGIN
    print 'Altered: Retention ,DaysWarning';
    alter table [Retention] add [DaysWarning]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'Retention')
BEGIN
    print 'Altered: Retention ,HiveActive';
    alter table [Retention] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'Retention')
BEGIN
    print 'Altered: Retention ,HiveConnectionName';
    alter table [Retention] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ManagerID' and table_name = 'Retention')
BEGIN
    print 'Altered: Retention ,ManagerID';
    alter table [Retention] add [ManagerID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ManagerName' and table_name = 'Retention')
BEGIN
    print 'Altered: Retention ,ManagerName';
    alter table [Retention] add [ManagerName]  nvarchar (200)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'Retention')
BEGIN
    print 'Altered: Retention ,RepoName';
    alter table [Retention] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'Retention')
BEGIN
    print 'Altered: Retention ,RepoSvrName';
    alter table [Retention] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ResponseRequired' and table_name = 'Retention')
BEGIN
    print 'Altered: Retention ,ResponseRequired';
    alter table [Retention] add [ResponseRequired]  char (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RetentionAction' and table_name = 'Retention')
BEGIN
    print 'Altered: Retention ,RetentionAction';
    alter table [Retention] add [RetentionAction]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RetentionCode' and table_name = 'Retention')
BEGIN
    print 'Altered: Retention ,RetentionCode';
    alter table [Retention] add [RetentionCode]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RetentionDesc' and table_name = 'Retention')
BEGIN
    print 'Altered: Retention ,RetentionDesc';
    alter table [Retention] add [RetentionDesc]  nvarchar (max)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RetentionPeriod' and table_name = 'Retention')
BEGIN
    print 'Altered: Retention ,RetentionPeriod';
    alter table [Retention] add [RetentionPeriod]  nvarchar (10)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RetentionUnits' and table_name = 'Retention')
BEGIN
    print 'Altered: Retention ,RetentionUnits';
    alter table [Retention] add [RetentionUnits]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'Retention')
BEGIN
    print 'Altered: Retention ,RowCreationDate';
    alter table [Retention] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'Retention')
BEGIN
    print 'Altered: Retention ,RowGuid';
    alter table [Retention] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'Retention')
BEGIN
    print 'Altered: Retention ,RowLastModDate';
    alter table [Retention] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ContentGuid' and table_name = 'RetentionTemp')
BEGIN
    print 'Altered: RetentionTemp ,ContentGuid';
    alter table [RetentionTemp] add [ContentGuid]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'RetentionTemp')
BEGIN
    print 'Altered: RetentionTemp ,HiveActive';
    alter table [RetentionTemp] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'RetentionTemp')
BEGIN
    print 'Altered: RetentionTemp ,HiveConnectionName';
    alter table [RetentionTemp] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'RetentionTemp')
BEGIN
    print 'Altered: RetentionTemp ,RepoName';
    alter table [RetentionTemp] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'RetentionTemp')
BEGIN
    print 'Altered: RetentionTemp ,RepoSvrName';
    alter table [RetentionTemp] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'RetentionTemp')
BEGIN
    print 'Altered: RetentionTemp ,RowCreationDate';
    alter table [RetentionTemp] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'RetentionTemp')
BEGIN
    print 'Altered: RetentionTemp ,RowGuid';
    alter table [RetentionTemp] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'RetentionTemp')
BEGIN
    print 'Altered: RetentionTemp ,RowLastModDate';
    alter table [RetentionTemp] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'TypeContent' and table_name = 'RetentionTemp')
BEGIN
    print 'Altered: RetentionTemp ,TypeContent';
    alter table [RetentionTemp] add [TypeContent]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'RetentionTemp')
BEGIN
    print 'Altered: RetentionTemp ,UserID';
    alter table [RetentionTemp] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CreateDate' and table_name = 'RiskLevel')
BEGIN
    print 'Altered: RiskLevel ,CreateDate';
    alter table [RiskLevel] add [CreateDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Description' and table_name = 'RiskLevel')
BEGIN
    print 'Altered: RiskLevel ,Description';
    alter table [RiskLevel] add [Description]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'RiskLevel')
BEGIN
    print 'Altered: RiskLevel ,HiveActive';
    alter table [RiskLevel] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'RiskLevel')
BEGIN
    print 'Altered: RiskLevel ,HiveConnectionName';
    alter table [RiskLevel] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'RiskLevel')
BEGIN
    print 'Altered: RiskLevel ,RepoName';
    alter table [RiskLevel] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'RiskLevel')
BEGIN
    print 'Altered: RiskLevel ,RepoSvrName';
    alter table [RiskLevel] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RiskCode' and table_name = 'RiskLevel')
BEGIN
    print 'Altered: RiskLevel ,RiskCode';
    alter table [RiskLevel] add [RiskCode]  char (10)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'RiskLevel')
BEGIN
    print 'Altered: RiskLevel ,RowCreationDate';
    alter table [RiskLevel] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'RiskLevel')
BEGIN
    print 'Altered: RiskLevel ,RowGuid';
    alter table [RiskLevel] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'RiskLevel')
BEGIN
    print 'Altered: RiskLevel ,RowLastModDate';
    alter table [RiskLevel] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RssRowGuid' and table_name = 'RSSChildren')
BEGIN
    print 'Altered: RSSChildren ,RssRowGuid';
    alter table [RSSChildren] add [RssRowGuid]  nchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SourceGuid' and table_name = 'RSSChildren')
BEGIN
    print 'Altered: RSSChildren ,SourceGuid';
    alter table [RSSChildren] add [SourceGuid]  nchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CreateDate' and table_name = 'RssPull')
BEGIN
    print 'Altered: RssPull ,CreateDate';
    alter table [RssPull] add [CreateDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'isPublic' and table_name = 'RssPull')
BEGIN
    print 'Altered: RssPull ,isPublic';
    alter table [RssPull] add [isPublic]  char (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'RssPull')
BEGIN
    print 'Altered: RssPull ,RepoName';
    alter table [RssPull] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RetentionCode' and table_name = 'RssPull')
BEGIN
    print 'Altered: RssPull ,RetentionCode';
    alter table [RssPull] add [RetentionCode]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'RssPull')
BEGIN
    print 'Altered: RssPull ,RowGuid';
    alter table [RssPull] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RssName' and table_name = 'RssPull')
BEGIN
    print 'Altered: RssPull ,RssName';
    alter table [RssPull] add [RssName]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RssUrl' and table_name = 'RssPull')
BEGIN
    print 'Altered: RssPull ,RssUrl';
    alter table [RssPull] add [RssUrl]  nvarchar (400)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'RssPull')
BEGIN
    print 'Altered: RssPull ,UserID';
    alter table [RssPull] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'RunParms')
BEGIN
    print 'Altered: RunParms ,HiveActive';
    alter table [RunParms] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'RunParms')
BEGIN
    print 'Altered: RunParms ,HiveConnectionName';
    alter table [RunParms] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Parm' and table_name = 'RunParms')
BEGIN
    print 'Altered: RunParms ,Parm';
    alter table [RunParms] add [Parm]  nvarchar (250)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ParmDesc' and table_name = 'RunParms')
BEGIN
    print 'Altered: RunParms ,ParmDesc';
    alter table [RunParms] add [ParmDesc]  nvarchar (500)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ParmValue' and table_name = 'RunParms')
BEGIN
    print 'Altered: RunParms ,ParmValue';
    alter table [RunParms] add [ParmValue]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'RunParms')
BEGIN
    print 'Altered: RunParms ,RepoName';
    alter table [RunParms] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'RunParms')
BEGIN
    print 'Altered: RunParms ,RepoSvrName';
    alter table [RunParms] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'RunParms')
BEGIN
    print 'Altered: RunParms ,RowCreationDate';
    alter table [RunParms] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'RunParms')
BEGIN
    print 'Altered: RunParms ,RowGuid';
    alter table [RunParms] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'RunParms')
BEGIN
    print 'Altered: RunParms ,RowLastModDate';
    alter table [RunParms] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'RunParms')
BEGIN
    print 'Altered: RunParms ,UserID';
    alter table [RunParms] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ConnectiveGuid' and table_name = 'RuntimeErrors')
BEGIN
    print 'Altered: RuntimeErrors ,ConnectiveGuid';
    alter table [RuntimeErrors] add [ConnectiveGuid]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'EntryDate' and table_name = 'RuntimeErrors')
BEGIN
    print 'Altered: RuntimeErrors ,EntryDate';
    alter table [RuntimeErrors] add [EntryDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'EntrySeq' and table_name = 'RuntimeErrors')
BEGIN
    print 'Altered: RuntimeErrors ,EntrySeq';
    alter table [RuntimeErrors] add [EntrySeq]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ErrorMsg' and table_name = 'RuntimeErrors')
BEGIN
    print 'Altered: RuntimeErrors ,ErrorMsg';
    alter table [RuntimeErrors] add [ErrorMsg]  nvarchar (max)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'RuntimeErrors')
BEGIN
    print 'Altered: RuntimeErrors ,HiveActive';
    alter table [RuntimeErrors] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'RuntimeErrors')
BEGIN
    print 'Altered: RuntimeErrors ,HiveConnectionName';
    alter table [RuntimeErrors] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'IdNbr' and table_name = 'RuntimeErrors')
BEGIN
    print 'Altered: RuntimeErrors ,IdNbr';
    alter table [RuntimeErrors] add [IdNbr]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'RuntimeErrors')
BEGIN
    print 'Altered: RuntimeErrors ,RepoName';
    alter table [RuntimeErrors] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'RuntimeErrors')
BEGIN
    print 'Altered: RuntimeErrors ,RepoSvrName';
    alter table [RuntimeErrors] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'RuntimeErrors')
BEGIN
    print 'Altered: RuntimeErrors ,RowCreationDate';
    alter table [RuntimeErrors] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'RuntimeErrors')
BEGIN
    print 'Altered: RuntimeErrors ,RowGuid';
    alter table [RuntimeErrors] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'RuntimeErrors')
BEGIN
    print 'Altered: RuntimeErrors ,RowLastModDate';
    alter table [RuntimeErrors] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'StackTrace' and table_name = 'RuntimeErrors')
BEGIN
    print 'Altered: RuntimeErrors ,StackTrace';
    alter table [RuntimeErrors] add [StackTrace]  nvarchar (max)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'RuntimeErrors')
BEGIN
    print 'Altered: RuntimeErrors ,UserID';
    alter table [RuntimeErrors] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'SavedItems')
BEGIN
    print 'Altered: SavedItems ,HiveActive';
    alter table [SavedItems] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'SavedItems')
BEGIN
    print 'Altered: SavedItems ,HiveConnectionName';
    alter table [SavedItems] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'SavedItems')
BEGIN
    print 'Altered: SavedItems ,RepoName';
    alter table [SavedItems] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'SavedItems')
BEGIN
    print 'Altered: SavedItems ,RepoSvrName';
    alter table [SavedItems] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'SavedItems')
BEGIN
    print 'Altered: SavedItems ,RowCreationDate';
    alter table [SavedItems] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'SavedItems')
BEGIN
    print 'Altered: SavedItems ,RowGuid';
    alter table [SavedItems] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'SavedItems')
BEGIN
    print 'Altered: SavedItems ,RowLastModDate';
    alter table [SavedItems] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SaveName' and table_name = 'SavedItems')
BEGIN
    print 'Altered: SavedItems ,SaveName';
    alter table [SavedItems] add [SaveName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SaveTypeCode' and table_name = 'SavedItems')
BEGIN
    print 'Altered: SavedItems ,SaveTypeCode';
    alter table [SavedItems] add [SaveTypeCode]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Userid' and table_name = 'SavedItems')
BEGIN
    print 'Altered: SavedItems ,Userid';
    alter table [SavedItems] add [Userid]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ValName' and table_name = 'SavedItems')
BEGIN
    print 'Altered: SavedItems ,ValName';
    alter table [SavedItems] add [ValName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ValValue' and table_name = 'SavedItems')
BEGIN
    print 'Altered: SavedItems ,ValValue';
    alter table [SavedItems] add [ValValue]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Classification' and table_name = 'SearchGuids')
BEGIN
    print 'Altered: SearchGuids ,Classification';
    alter table [SearchGuids] add [Classification]  nvarchar (10)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'IDGuid' and table_name = 'SearchGuids')
BEGIN
    print 'Altered: SearchGuids ,IDGuid';
    alter table [SearchGuids] add [IDGuid]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SourceGuid' and table_name = 'SearchGuids')
BEGIN
    print 'Altered: SearchGuids ,SourceGuid';
    alter table [SearchGuids] add [SourceGuid]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CalledFrom' and table_name = 'SearchHistory')
BEGIN
    print 'Altered: SearchHistory ,CalledFrom';
    alter table [SearchHistory] add [CalledFrom]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'EndTime' and table_name = 'SearchHistory')
BEGIN
    print 'Altered: SearchHistory ,EndTime';
    alter table [SearchHistory] add [EndTime]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'SearchHistory')
BEGIN
    print 'Altered: SearchHistory ,HiveActive';
    alter table [SearchHistory] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'SearchHistory')
BEGIN
    print 'Altered: SearchHistory ,HiveConnectionName';
    alter table [SearchHistory] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'SearchHistory')
BEGIN
    print 'Altered: SearchHistory ,RepoName';
    alter table [SearchHistory] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'SearchHistory')
BEGIN
    print 'Altered: SearchHistory ,RepoSvrName';
    alter table [SearchHistory] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ReturnedRows' and table_name = 'SearchHistory')
BEGIN
    print 'Altered: SearchHistory ,ReturnedRows';
    alter table [SearchHistory] add [ReturnedRows]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'SearchHistory')
BEGIN
    print 'Altered: SearchHistory ,RowCreationDate';
    alter table [SearchHistory] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'SearchHistory')
BEGIN
    print 'Altered: SearchHistory ,RowGuid';
    alter table [SearchHistory] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowID' and table_name = 'SearchHistory')
BEGIN
    print 'Altered: SearchHistory ,RowID';
    alter table [SearchHistory] add [RowID]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'SearchHistory')
BEGIN
    print 'Altered: SearchHistory ,RowLastModDate';
    alter table [SearchHistory] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SearchDate' and table_name = 'SearchHistory')
BEGIN
    print 'Altered: SearchHistory ,SearchDate';
    alter table [SearchHistory] add [SearchDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SearchParms' and table_name = 'SearchHistory')
BEGIN
    print 'Altered: SearchHistory ,SearchParms';
    alter table [SearchHistory] add [SearchParms]  nvarchar (max)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SearchSql' and table_name = 'SearchHistory')
BEGIN
    print 'Altered: SearchHistory ,SearchSql';
    alter table [SearchHistory] add [SearchSql]  nvarchar (max)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'StartTime' and table_name = 'SearchHistory')
BEGIN
    print 'Altered: SearchHistory ,StartTime';
    alter table [SearchHistory] add [StartTime]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'TypeSearch' and table_name = 'SearchHistory')
BEGIN
    print 'Altered: SearchHistory ,TypeSearch';
    alter table [SearchHistory] add [TypeSearch]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'SearchHistory')
BEGIN
    print 'Altered: SearchHistory ,UserID';
    alter table [SearchHistory] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Carrier' and table_name = 'SearchSchedule')
BEGIN
    print 'Altered: SearchSchedule ,Carrier';
    alter table [SearchSchedule] add [Carrier]  nvarchar (75)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CreateDate' and table_name = 'SearchSchedule')
BEGIN
    print 'Altered: SearchSchedule ,CreateDate';
    alter table [SearchSchedule] add [CreateDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'EndRunDate' and table_name = 'SearchSchedule')
BEGIN
    print 'Altered: SearchSchedule ,EndRunDate';
    alter table [SearchSchedule] add [EndRunDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LastModDate' and table_name = 'SearchSchedule')
BEGIN
    print 'Altered: SearchSchedule ,LastModDate';
    alter table [SearchSchedule] add [LastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LastRunDate' and table_name = 'SearchSchedule')
BEGIN
    print 'Altered: SearchSchedule ,LastRunDate';
    alter table [SearchSchedule] add [LastRunDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'NotificationSMS' and table_name = 'SearchSchedule')
BEGIN
    print 'Altered: SearchSchedule ,NotificationSMS';
    alter table [SearchSchedule] add [NotificationSMS]  nvarchar (20)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'NumberOfExecutions' and table_name = 'SearchSchedule')
BEGIN
    print 'Altered: SearchSchedule ,NumberOfExecutions';
    alter table [SearchSchedule] add [NumberOfExecutions]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'OwnerID' and table_name = 'SearchSchedule')
BEGIN
    print 'Altered: SearchSchedule ,OwnerID';
    alter table [SearchSchedule] add [OwnerID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'SearchSchedule')
BEGIN
    print 'Altered: SearchSchedule ,RepoName';
    alter table [SearchSchedule] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'SearchSchedule')
BEGIN
    print 'Altered: SearchSchedule ,RowGuid';
    alter table [SearchSchedule] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ScheduleDaysOfMonth' and table_name = 'SearchSchedule')
BEGIN
    print 'Altered: SearchSchedule ,ScheduleDaysOfMonth';
    alter table [SearchSchedule] add [ScheduleDaysOfMonth]  nchar (70)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ScheduleDaysOfWeek' and table_name = 'SearchSchedule')
BEGIN
    print 'Altered: SearchSchedule ,ScheduleDaysOfWeek';
    alter table [SearchSchedule] add [ScheduleDaysOfWeek]  nchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ScheduleHour' and table_name = 'SearchSchedule')
BEGIN
    print 'Altered: SearchSchedule ,ScheduleHour';
    alter table [SearchSchedule] add [ScheduleHour]  nchar (10)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ScheduleHourInterval' and table_name = 'SearchSchedule')
BEGIN
    print 'Altered: SearchSchedule ,ScheduleHourInterval';
    alter table [SearchSchedule] add [ScheduleHourInterval]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ScheduleMonthOfQtr' and table_name = 'SearchSchedule')
BEGIN
    print 'Altered: SearchSchedule ,ScheduleMonthOfQtr';
    alter table [SearchSchedule] add [ScheduleMonthOfQtr]  nchar (10)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ScheduleUnit' and table_name = 'SearchSchedule')
BEGIN
    print 'Altered: SearchSchedule ,ScheduleUnit';
    alter table [SearchSchedule] add [ScheduleUnit]  nchar (10)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SearchDesc' and table_name = 'SearchSchedule')
BEGIN
    print 'Altered: SearchSchedule ,SearchDesc';
    alter table [SearchSchedule] add [SearchDesc]  nvarchar (2000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SearchName' and table_name = 'SearchSchedule')
BEGIN
    print 'Altered: SearchSchedule ,SearchName';
    alter table [SearchSchedule] add [SearchName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SearchParameters' and table_name = 'SearchSchedule')
BEGIN
    print 'Altered: SearchSchedule ,SearchParameters';
    alter table [SearchSchedule] add [SearchParameters]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SearchQuery' and table_name = 'SearchSchedule')
BEGIN
    print 'Altered: SearchSchedule ,SearchQuery';
    alter table [SearchSchedule] add [SearchQuery]  nvarchar (max)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SendToEmail' and table_name = 'SearchSchedule')
BEGIN
    print 'Altered: SearchSchedule ,SendToEmail';
    alter table [SearchSchedule] add [SendToEmail]  nvarchar (2000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'StartToRunDate' and table_name = 'SearchSchedule')
BEGIN
    print 'Altered: SearchSchedule ,StartToRunDate';
    alter table [SearchSchedule] add [StartToRunDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CreateDate' and table_name = 'SearchUser')
BEGIN
    print 'Altered: SearchUser ,CreateDate';
    alter table [SearchUser] add [CreateDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LastUsedDate' and table_name = 'SearchUser')
BEGIN
    print 'Altered: SearchUser ,LastUsedDate';
    alter table [SearchUser] add [LastUsedDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'SearchUser')
BEGIN
    print 'Altered: SearchUser ,RepoName';
    alter table [SearchUser] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'SearchUser')
BEGIN
    print 'Altered: SearchUser ,RowGuid';
    alter table [SearchUser] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowNbr' and table_name = 'SearchUser')
BEGIN
    print 'Altered: SearchUser ,RowNbr';
    alter table [SearchUser] add [RowNbr]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SearchName' and table_name = 'SearchUser')
BEGIN
    print 'Altered: SearchUser ,SearchName';
    alter table [SearchUser] add [SearchName]  nvarchar (75)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SearchParms' and table_name = 'SearchUser')
BEGIN
    print 'Altered: SearchUser ,SearchParms';
    alter table [SearchUser] add [SearchParms]  nvarchar (max)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'SearchUser')
BEGIN
    print 'Altered: SearchUser ,UserID';
    alter table [SearchUser] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'EntryID' and table_name = 'SearhParmsHistory')
BEGIN
    print 'Altered: SearhParmsHistory ,EntryID';
    alter table [SearhParmsHistory] add [EntryID]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'SearhParmsHistory')
BEGIN
    print 'Altered: SearhParmsHistory ,HiveActive';
    alter table [SearhParmsHistory] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'SearhParmsHistory')
BEGIN
    print 'Altered: SearhParmsHistory ,HiveConnectionName';
    alter table [SearhParmsHistory] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'QryParms' and table_name = 'SearhParmsHistory')
BEGIN
    print 'Altered: SearhParmsHistory ,QryParms';
    alter table [SearhParmsHistory] add [QryParms]  nvarchar (max)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'SearhParmsHistory')
BEGIN
    print 'Altered: SearhParmsHistory ,RepoName';
    alter table [SearhParmsHistory] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'SearhParmsHistory')
BEGIN
    print 'Altered: SearhParmsHistory ,RepoSvrName';
    alter table [SearhParmsHistory] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'SearhParmsHistory')
BEGIN
    print 'Altered: SearhParmsHistory ,RowCreationDate';
    alter table [SearhParmsHistory] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'SearhParmsHistory')
BEGIN
    print 'Altered: SearhParmsHistory ,RowGuid';
    alter table [SearhParmsHistory] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'SearhParmsHistory')
BEGIN
    print 'Altered: SearhParmsHistory ,RowLastModDate';
    alter table [SearhParmsHistory] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Screen' and table_name = 'SearhParmsHistory')
BEGIN
    print 'Altered: SearhParmsHistory ,Screen';
    alter table [SearhParmsHistory] add [Screen]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SearchDate' and table_name = 'SearhParmsHistory')
BEGIN
    print 'Altered: SearhParmsHistory ,SearchDate';
    alter table [SearhParmsHistory] add [SearchDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'SearhParmsHistory')
BEGIN
    print 'Altered: SearhParmsHistory ,UserID';
    alter table [SearhParmsHistory] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'EntryTime' and table_name = 'ServiceActivity')
BEGIN
    print 'Altered: ServiceActivity ,EntryTime';
    alter table [ServiceActivity] add [EntryTime]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'ServiceActivity')
BEGIN
    print 'Altered: ServiceActivity ,HiveActive';
    alter table [ServiceActivity] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'ServiceActivity')
BEGIN
    print 'Altered: ServiceActivity ,HiveConnectionName';
    alter table [ServiceActivity] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Msg' and table_name = 'ServiceActivity')
BEGIN
    print 'Altered: ServiceActivity ,Msg';
    alter table [ServiceActivity] add [Msg]  varchar (max)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'ServiceActivity')
BEGIN
    print 'Altered: ServiceActivity ,RepoName';
    alter table [ServiceActivity] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'ServiceActivity')
BEGIN
    print 'Altered: ServiceActivity ,RepoSvrName';
    alter table [ServiceActivity] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'ServiceActivity')
BEGIN
    print 'Altered: ServiceActivity ,RowCreationDate';
    alter table [ServiceActivity] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'ServiceActivity')
BEGIN
    print 'Altered: ServiceActivity ,RowGuid';
    alter table [ServiceActivity] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'ServiceActivity')
BEGIN
    print 'Altered: ServiceActivity ,RowLastModDate';
    alter table [ServiceActivity] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'StmtID' and table_name = 'ServiceActivity')
BEGIN
    print 'Altered: ServiceActivity ,StmtID';
    alter table [ServiceActivity] add [StmtID]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CreateDate' and table_name = 'SessionID')
BEGIN
    print 'Altered: SessionID ,CreateDate';
    alter table [SessionID] add [CreateDate]  datetime2; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowNbr' and table_name = 'SessionID')
BEGIN
    print 'Altered: SessionID ,RowNbr';
    alter table [SessionID] add [RowNbr]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SessionID' and table_name = 'SessionID')
BEGIN
    print 'Altered: SessionID ,SessionID';
    alter table [SessionID] add [SessionID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'SessionID')
BEGIN
    print 'Altered: SessionID ,UserID';
    alter table [SessionID] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CreateDate' and table_name = 'SessionVar')
BEGIN
    print 'Altered: SessionVar ,CreateDate';
    alter table [SessionVar] add [CreateDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'SessionVar')
BEGIN
    print 'Altered: SessionVar ,HiveActive';
    alter table [SessionVar] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'SessionVar')
BEGIN
    print 'Altered: SessionVar ,HiveConnectionName';
    alter table [SessionVar] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'SessionVar')
BEGIN
    print 'Altered: SessionVar ,RepoName';
    alter table [SessionVar] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'SessionVar')
BEGIN
    print 'Altered: SessionVar ,RepoSvrName';
    alter table [SessionVar] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'SessionVar')
BEGIN
    print 'Altered: SessionVar ,RowCreationDate';
    alter table [SessionVar] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'SessionVar')
BEGIN
    print 'Altered: SessionVar ,RowGuid';
    alter table [SessionVar] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'SessionVar')
BEGIN
    print 'Altered: SessionVar ,RowLastModDate';
    alter table [SessionVar] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SessionGuid' and table_name = 'SessionVar')
BEGIN
    print 'Altered: SessionVar ,SessionGuid';
    alter table [SessionVar] add [SessionGuid]  varchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SessionVar' and table_name = 'SessionVar')
BEGIN
    print 'Altered: SessionVar ,SessionVar';
    alter table [SessionVar] add [SessionVar]  varchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SessionVarVal' and table_name = 'SessionVar')
BEGIN
    print 'Altered: SessionVar ,SessionVarVal';
    alter table [SessionVar] add [SessionVarVal]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'SkipWords')
BEGIN
    print 'Altered: SkipWords ,HiveActive';
    alter table [SkipWords] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'SkipWords')
BEGIN
    print 'Altered: SkipWords ,HiveConnectionName';
    alter table [SkipWords] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'SkipWords')
BEGIN
    print 'Altered: SkipWords ,RepoName';
    alter table [SkipWords] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'SkipWords')
BEGIN
    print 'Altered: SkipWords ,RepoSvrName';
    alter table [SkipWords] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'SkipWords')
BEGIN
    print 'Altered: SkipWords ,RowCreationDate';
    alter table [SkipWords] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'SkipWords')
BEGIN
    print 'Altered: SkipWords ,RowGuid';
    alter table [SkipWords] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'SkipWords')
BEGIN
    print 'Altered: SkipWords ,RowLastModDate';
    alter table [SkipWords] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'tgtWord' and table_name = 'SkipWords')
BEGIN
    print 'Altered: SkipWords ,tgtWord';
    alter table [SkipWords] add [tgtWord]  nvarchar (18)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'AttributeName' and table_name = 'SourceAttribute')
BEGIN
    print 'Altered: SourceAttribute ,AttributeName';
    alter table [SourceAttribute] add [AttributeName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'AttributeValue' and table_name = 'SourceAttribute')
BEGIN
    print 'Altered: SourceAttribute ,AttributeValue';
    alter table [SourceAttribute] add [AttributeValue]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'DataSourceOwnerUserID' and table_name = 'SourceAttribute')
BEGIN
    print 'Altered: SourceAttribute ,DataSourceOwnerUserID';
    alter table [SourceAttribute] add [DataSourceOwnerUserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'SourceAttribute')
BEGIN
    print 'Altered: SourceAttribute ,HiveActive';
    alter table [SourceAttribute] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'SourceAttribute')
BEGIN
    print 'Altered: SourceAttribute ,HiveConnectionName';
    alter table [SourceAttribute] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'SourceAttribute')
BEGIN
    print 'Altered: SourceAttribute ,RepoName';
    alter table [SourceAttribute] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'SourceAttribute')
BEGIN
    print 'Altered: SourceAttribute ,RepoSvrName';
    alter table [SourceAttribute] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'SourceAttribute')
BEGIN
    print 'Altered: SourceAttribute ,RowCreationDate';
    alter table [SourceAttribute] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'SourceAttribute')
BEGIN
    print 'Altered: SourceAttribute ,RowGuid';
    alter table [SourceAttribute] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'SourceAttribute')
BEGIN
    print 'Altered: SourceAttribute ,RowLastModDate';
    alter table [SourceAttribute] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SourceGuid' and table_name = 'SourceAttribute')
BEGIN
    print 'Altered: SourceAttribute ,SourceGuid';
    alter table [SourceAttribute] add [SourceGuid]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SourceTypeCode' and table_name = 'SourceAttribute')
BEGIN
    print 'Altered: SourceAttribute ,SourceTypeCode';
    alter table [SourceAttribute] add [SourceTypeCode]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ContainerDesc' and table_name = 'SourceContainer')
BEGIN
    print 'Altered: SourceContainer ,ContainerDesc';
    alter table [SourceContainer] add [ContainerDesc]  nvarchar (4000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ContainerType' and table_name = 'SourceContainer')
BEGIN
    print 'Altered: SourceContainer ,ContainerType';
    alter table [SourceContainer] add [ContainerType]  nvarchar (25)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CreateDate' and table_name = 'SourceContainer')
BEGIN
    print 'Altered: SourceContainer ,CreateDate';
    alter table [SourceContainer] add [CreateDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'SourceContainer')
BEGIN
    print 'Altered: SourceContainer ,HiveActive';
    alter table [SourceContainer] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'SourceContainer')
BEGIN
    print 'Altered: SourceContainer ,HiveConnectionName';
    alter table [SourceContainer] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'SourceContainer')
BEGIN
    print 'Altered: SourceContainer ,RepoName';
    alter table [SourceContainer] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'SourceContainer')
BEGIN
    print 'Altered: SourceContainer ,RepoSvrName';
    alter table [SourceContainer] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'SourceContainer')
BEGIN
    print 'Altered: SourceContainer ,RowCreationDate';
    alter table [SourceContainer] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'SourceContainer')
BEGIN
    print 'Altered: SourceContainer ,RowGuid';
    alter table [SourceContainer] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'SourceContainer')
BEGIN
    print 'Altered: SourceContainer ,RowLastModDate';
    alter table [SourceContainer] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ClassName' and table_name = 'SourceInjector')
BEGIN
    print 'Altered: SourceInjector ,ClassName';
    alter table [SourceInjector] add [ClassName]  varchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Executed' and table_name = 'SourceInjector')
BEGIN
    print 'Altered: SourceInjector ,Executed';
    alter table [SourceInjector] add [Executed]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FuncName' and table_name = 'SourceInjector')
BEGIN
    print 'Altered: SourceInjector ,FuncName';
    alter table [SourceInjector] add [FuncName]  varchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LastExecDate' and table_name = 'SourceInjector')
BEGIN
    print 'Altered: SourceInjector ,LastExecDate';
    alter table [SourceInjector] add [LastExecDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LineID' and table_name = 'SourceInjector')
BEGIN
    print 'Altered: SourceInjector ,LineID';
    alter table [SourceInjector] add [LineID]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'NbrExecutions' and table_name = 'SourceInjector')
BEGIN
    print 'Altered: SourceInjector ,NbrExecutions';
    alter table [SourceInjector] add [NbrExecutions]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'SourceInjector')
BEGIN
    print 'Altered: SourceInjector ,RepoName';
    alter table [SourceInjector] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'SourceInjector')
BEGIN
    print 'Altered: SourceInjector ,RowGuid';
    alter table [SourceInjector] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'SourceType')
BEGIN
    print 'Altered: SourceType ,HiveActive';
    alter table [SourceType] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'SourceType')
BEGIN
    print 'Altered: SourceType ,HiveConnectionName';
    alter table [SourceType] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Indexable' and table_name = 'SourceType')
BEGIN
    print 'Altered: SourceType ,Indexable';
    alter table [SourceType] add [Indexable]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'SourceType')
BEGIN
    print 'Altered: SourceType ,RepoName';
    alter table [SourceType] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'SourceType')
BEGIN
    print 'Altered: SourceType ,RepoSvrName';
    alter table [SourceType] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'SourceType')
BEGIN
    print 'Altered: SourceType ,RowCreationDate';
    alter table [SourceType] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'SourceType')
BEGIN
    print 'Altered: SourceType ,RowGuid';
    alter table [SourceType] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'SourceType')
BEGIN
    print 'Altered: SourceType ,RowLastModDate';
    alter table [SourceType] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SourceTypeCode' and table_name = 'SourceType')
BEGIN
    print 'Altered: SourceType ,SourceTypeCode';
    alter table [SourceType] add [SourceTypeCode]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SourceTypeDesc' and table_name = 'SourceType')
BEGIN
    print 'Altered: SourceType ,SourceTypeDesc';
    alter table [SourceType] add [SourceTypeDesc]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'StoreExternal' and table_name = 'SourceType')
BEGIN
    print 'Altered: SourceType ,StoreExternal';
    alter table [SourceType] add [StoreExternal]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = '_bigint' and table_name = 'SqlDataTypes')
BEGIN
    print 'Altered: SqlDataTypes ,_bigint';
    alter table [SqlDataTypes] add [_bigint]  bigint; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = '_binary' and table_name = 'SqlDataTypes')
BEGIN
    print 'Altered: SqlDataTypes ,_binary';
    alter table [SqlDataTypes] add [_binary]  binary (50) ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = '_bit' and table_name = 'SqlDataTypes')
BEGIN
    print 'Altered: SqlDataTypes ,_bit';
    alter table [SqlDataTypes] add [_bit]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = '_char' and table_name = 'SqlDataTypes')
BEGIN
    print 'Altered: SqlDataTypes ,_char';
    alter table [SqlDataTypes] add [_char]  char (10)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = '_datetime' and table_name = 'SqlDataTypes')
BEGIN
    print 'Altered: SqlDataTypes ,_datetime';
    alter table [SqlDataTypes] add [_datetime]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = '_datetimeoffset' and table_name = 'SqlDataTypes')
BEGIN
    print 'Altered: SqlDataTypes ,_datetimeoffset';
    alter table [SqlDataTypes] add [_datetimeoffset]  datetimeoffset; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = '_decimal' and table_name = 'SqlDataTypes')
BEGIN
    print 'Altered: SqlDataTypes ,_decimal';
    alter table [SqlDataTypes] add [_decimal]  decimal; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = '_float' and table_name = 'SqlDataTypes')
BEGIN
    print 'Altered: SqlDataTypes ,_float';
    alter table [SqlDataTypes] add [_float]  float; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = '_geography' and table_name = 'SqlDataTypes')
BEGIN
    print 'Altered: SqlDataTypes ,_geography';
    alter table [SqlDataTypes] add [_geography]  geography; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = '_geometry' and table_name = 'SqlDataTypes')
BEGIN
    print 'Altered: SqlDataTypes ,_geometry';
    alter table [SqlDataTypes] add [_geometry]  geometry; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = '_hierarchyid' and table_name = 'SqlDataTypes')
BEGIN
    print 'Altered: SqlDataTypes ,_hierarchyid';
    alter table [SqlDataTypes] add [_hierarchyid]  hierarchyid; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = '_image' and table_name = 'SqlDataTypes')
BEGIN
    print 'Altered: SqlDataTypes ,_image';
    alter table [SqlDataTypes] add [_image]  image ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = '_int' and table_name = 'SqlDataTypes')
BEGIN
    print 'Altered: SqlDataTypes ,_int';
    alter table [SqlDataTypes] add [_int]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = '_money' and table_name = 'SqlDataTypes')
BEGIN
    print 'Altered: SqlDataTypes ,_money';
    alter table [SqlDataTypes] add [_money]  money; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = '_nchar' and table_name = 'SqlDataTypes')
BEGIN
    print 'Altered: SqlDataTypes ,_nchar';
    alter table [SqlDataTypes] add [_nchar]  nchar (10)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = '_ntext' and table_name = 'SqlDataTypes')
BEGIN
    print 'Altered: SqlDataTypes ,_ntext';
    alter table [SqlDataTypes] add [_ntext]  ntext; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = '_numeric' and table_name = 'SqlDataTypes')
BEGIN
    print 'Altered: SqlDataTypes ,_numeric';
    alter table [SqlDataTypes] add [_numeric]  numeric; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = '_nvarchar' and table_name = 'SqlDataTypes')
BEGIN
    print 'Altered: SqlDataTypes ,_nvarchar';
    alter table [SqlDataTypes] add [_nvarchar]  nchar (10)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = '_nvarchar_max' and table_name = 'SqlDataTypes')
BEGIN
    print 'Altered: SqlDataTypes ,_nvarchar_max';
    alter table [SqlDataTypes] add [_nvarchar_max]  nvarchar (max)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = '_real' and table_name = 'SqlDataTypes')
BEGIN
    print 'Altered: SqlDataTypes ,_real';
    alter table [SqlDataTypes] add [_real]  real; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = '_smalldatetime' and table_name = 'SqlDataTypes')
BEGIN
    print 'Altered: SqlDataTypes ,_smalldatetime';
    alter table [SqlDataTypes] add [_smalldatetime]  smalldatetime; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = '_smallint' and table_name = 'SqlDataTypes')
BEGIN
    print 'Altered: SqlDataTypes ,_smallint';
    alter table [SqlDataTypes] add [_smallint]  smallint; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = '_smallmoney' and table_name = 'SqlDataTypes')
BEGIN
    print 'Altered: SqlDataTypes ,_smallmoney';
    alter table [SqlDataTypes] add [_smallmoney]  smallmoney; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = '_sql_variant' and table_name = 'SqlDataTypes')
BEGIN
    print 'Altered: SqlDataTypes ,_sql_variant';
    alter table [SqlDataTypes] add [_sql_variant]  sql_variant; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = '_text' and table_name = 'SqlDataTypes')
BEGIN
    print 'Altered: SqlDataTypes ,_text';
    alter table [SqlDataTypes] add [_text]  text; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = '_time7' and table_name = 'SqlDataTypes')
BEGIN
    print 'Altered: SqlDataTypes ,_time7';
    alter table [SqlDataTypes] add [_time7]  time; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = '_timestamp' and table_name = 'SqlDataTypes')
BEGIN
    print 'Altered: SqlDataTypes ,_timestamp';
    alter table [SqlDataTypes] add [_timestamp]  timestamp; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = '_tinyint' and table_name = 'SqlDataTypes')
BEGIN
    print 'Altered: SqlDataTypes ,_tinyint';
    alter table [SqlDataTypes] add [_tinyint]  tinyint; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = '_uniqueidentifier' and table_name = 'SqlDataTypes')
BEGIN
    print 'Altered: SqlDataTypes ,_uniqueidentifier';
    alter table [SqlDataTypes] add [_uniqueidentifier]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = '_varbinary' and table_name = 'SqlDataTypes')
BEGIN
    print 'Altered: SqlDataTypes ,_varbinary';
    alter table [SqlDataTypes] add [_varbinary]  varbinary; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = '_varchar' and table_name = 'SqlDataTypes')
BEGIN
    print 'Altered: SqlDataTypes ,_varchar';
    alter table [SqlDataTypes] add [_varchar]  varchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = '_varcharMAX' and table_name = 'SqlDataTypes')
BEGIN
    print 'Altered: SqlDataTypes ,_varcharMAX';
    alter table [SqlDataTypes] add [_varcharMAX]  varchar (max)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = '_xml' and table_name = 'SqlDataTypes')
BEGIN
    print 'Altered: SqlDataTypes ,_xml';
    alter table [SqlDataTypes] add [_xml]  xml; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'SqlDataTypes')
BEGIN
    print 'Altered: SqlDataTypes ,HiveActive';
    alter table [SqlDataTypes] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'SqlDataTypes')
BEGIN
    print 'Altered: SqlDataTypes ,HiveConnectionName';
    alter table [SqlDataTypes] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'SqlDataTypes')
BEGIN
    print 'Altered: SqlDataTypes ,RepoName';
    alter table [SqlDataTypes] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'SqlDataTypes')
BEGIN
    print 'Altered: SqlDataTypes ,RepoSvrName';
    alter table [SqlDataTypes] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'SqlDataTypes')
BEGIN
    print 'Altered: SqlDataTypes ,RowCreationDate';
    alter table [SqlDataTypes] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'SqlDataTypes')
BEGIN
    print 'Altered: SqlDataTypes ,RowGuid';
    alter table [SqlDataTypes] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'SqlDataTypes')
BEGIN
    print 'Altered: SqlDataTypes ,RowLastModDate';
    alter table [SqlDataTypes] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'EntryTime' and table_name = 'StagedSQL')
BEGIN
    print 'Altered: StagedSQL ,EntryTime';
    alter table [StagedSQL] add [EntryTime]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ExecutionID' and table_name = 'StagedSQL')
BEGIN
    print 'Altered: StagedSQL ,ExecutionID';
    alter table [StagedSQL] add [ExecutionID]  varchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'StagedSQL')
BEGIN
    print 'Altered: StagedSQL ,RepoName';
    alter table [StagedSQL] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'StagedSQL')
BEGIN
    print 'Altered: StagedSQL ,RowGuid';
    alter table [StagedSQL] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SqlStmt' and table_name = 'StagedSQL')
BEGIN
    print 'Altered: StagedSQL ,SqlStmt';
    alter table [StagedSQL] add [SqlStmt]  nvarchar (max)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'StmtID' and table_name = 'StagedSQL')
BEGIN
    print 'Altered: StagedSQL ,StmtID';
    alter table [StagedSQL] add [StmtID]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ClickDate' and table_name = 'StatsClick')
BEGIN
    print 'Altered: StatsClick ,ClickDate';
    alter table [StatsClick] add [ClickDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ClickID' and table_name = 'StatsClick')
BEGIN
    print 'Altered: StatsClick ,ClickID';
    alter table [StatsClick] add [ClickID]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LocationID' and table_name = 'StatsClick')
BEGIN
    print 'Altered: StatsClick ,LocationID';
    alter table [StatsClick] add [LocationID]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'StatsClick')
BEGIN
    print 'Altered: StatsClick ,RepoName';
    alter table [StatsClick] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'StatsClick')
BEGIN
    print 'Altered: StatsClick ,RowGuid';
    alter table [StatsClick] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'StatsClick')
BEGIN
    print 'Altered: StatsClick ,UserID';
    alter table [StatsClick] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ClickID' and table_name = 'StatSearch')
BEGIN
    print 'Altered: StatSearch ,ClickID';
    alter table [StatSearch] add [ClickID]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'StatSearch')
BEGIN
    print 'Altered: StatSearch ,RepoName';
    alter table [StatSearch] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'StatSearch')
BEGIN
    print 'Altered: StatSearch ,RowGuid';
    alter table [StatSearch] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SearchDate' and table_name = 'StatSearch')
BEGIN
    print 'Altered: StatSearch ,SearchDate';
    alter table [StatSearch] add [SearchDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'TypeSearch' and table_name = 'StatSearch')
BEGIN
    print 'Altered: StatSearch ,TypeSearch';
    alter table [StatSearch] add [TypeSearch]  char (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'StatSearch')
BEGIN
    print 'Altered: StatSearch ,UserID';
    alter table [StatSearch] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'WordID' and table_name = 'StatSearch')
BEGIN
    print 'Altered: StatSearch ,WordID';
    alter table [StatSearch] add [WordID]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'StatWord')
BEGIN
    print 'Altered: StatWord ,RepoName';
    alter table [StatWord] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'StatWord')
BEGIN
    print 'Altered: StatWord ,RowGuid';
    alter table [StatWord] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Word' and table_name = 'StatWord')
BEGIN
    print 'Altered: StatWord ,Word';
    alter table [StatWord] add [Word]  nvarchar (100)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'WordID' and table_name = 'StatWord')
BEGIN
    print 'Altered: StatWord ,WordID';
    alter table [StatWord] add [WordID]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CreateDate' and table_name = 'Storage')
BEGIN
    print 'Altered: Storage ,CreateDate';
    alter table [Storage] add [CreateDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'Storage')
BEGIN
    print 'Altered: Storage ,HiveActive';
    alter table [Storage] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'Storage')
BEGIN
    print 'Altered: Storage ,HiveConnectionName';
    alter table [Storage] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'Storage')
BEGIN
    print 'Altered: Storage ,RepoName';
    alter table [Storage] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'Storage')
BEGIN
    print 'Altered: Storage ,RepoSvrName';
    alter table [Storage] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'Storage')
BEGIN
    print 'Altered: Storage ,RowCreationDate';
    alter table [Storage] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'Storage')
BEGIN
    print 'Altered: Storage ,RowGuid';
    alter table [Storage] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'Storage')
BEGIN
    print 'Altered: Storage ,RowLastModDate';
    alter table [Storage] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'StoreCode' and table_name = 'Storage')
BEGIN
    print 'Altered: Storage ,StoreCode';
    alter table [Storage] add [StoreCode]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'StoreDesc' and table_name = 'Storage')
BEGIN
    print 'Altered: Storage ,StoreDesc';
    alter table [Storage] add [StoreDesc]  nvarchar (18)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ColumnName' and table_name = 'StructuredData')
BEGIN
    print 'Altered: StructuredData ,ColumnName';
    alter table [StructuredData] add [ColumnName]  nvarchar (120)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ColVal' and table_name = 'StructuredData')
BEGIN
    print 'Altered: StructuredData ,ColVal';
    alter table [StructuredData] add [ColVal]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'StructuredData')
BEGIN
    print 'Altered: StructuredData ,RepoName';
    alter table [StructuredData] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'StructuredData')
BEGIN
    print 'Altered: StructuredData ,RowGuid';
    alter table [StructuredData] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SourceGuid' and table_name = 'StructuredData')
BEGIN
    print 'Altered: StructuredData ,SourceGuid';
    alter table [StructuredData] add [SourceGuid]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'EcmGuid' and table_name = 'StructuredDataProcessed')
BEGIN
    print 'Altered: StructuredDataProcessed ,EcmGuid';
    alter table [StructuredDataProcessed] add [EcmGuid]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'StructuredDataProcessed')
BEGIN
    print 'Altered: StructuredDataProcessed ,RepoName';
    alter table [StructuredDataProcessed] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'StructuredDataProcessed')
BEGIN
    print 'Altered: StructuredDataProcessed ,RowGuid';
    alter table [StructuredDataProcessed] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ckDisableDir' and table_name = 'SubDir')
BEGIN
    print 'Altered: SubDir ,ckDisableDir';
    alter table [SubDir] add [ckDisableDir]  nchar (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ckPublic' and table_name = 'SubDir')
BEGIN
    print 'Altered: SubDir ,ckPublic';
    alter table [SubDir] add [ckPublic]  nchar (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FQN' and table_name = 'SubDir')
BEGIN
    print 'Altered: SubDir ,FQN';
    alter table [SubDir] add [FQN]  varchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'SubDir')
BEGIN
    print 'Altered: SubDir ,HiveActive';
    alter table [SubDir] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'SubDir')
BEGIN
    print 'Altered: SubDir ,HiveConnectionName';
    alter table [SubDir] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'isSysDefault' and table_name = 'SubDir')
BEGIN
    print 'Altered: SubDir ,isSysDefault';
    alter table [SubDir] add [isSysDefault]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'OcrDirectory' and table_name = 'SubDir')
BEGIN
    print 'Altered: SubDir ,OcrDirectory';
    alter table [SubDir] add [OcrDirectory]  nchar (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'SubDir')
BEGIN
    print 'Altered: SubDir ,RepoName';
    alter table [SubDir] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'SubDir')
BEGIN
    print 'Altered: SubDir ,RepoSvrName';
    alter table [SubDir] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RetentionCode' and table_name = 'SubDir')
BEGIN
    print 'Altered: SubDir ,RetentionCode';
    alter table [SubDir] add [RetentionCode]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'SubDir')
BEGIN
    print 'Altered: SubDir ,RowCreationDate';
    alter table [SubDir] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'SubDir')
BEGIN
    print 'Altered: SubDir ,RowGuid';
    alter table [SubDir] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'SubDir')
BEGIN
    print 'Altered: SubDir ,RowLastModDate';
    alter table [SubDir] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SUBFQN' and table_name = 'SubDir')
BEGIN
    print 'Altered: SubDir ,SUBFQN';
    alter table [SubDir] add [SUBFQN]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'SubDir')
BEGIN
    print 'Altered: SubDir ,UserID';
    alter table [SubDir] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'VersionFiles' and table_name = 'SubDir')
BEGIN
    print 'Altered: SubDir ,VersionFiles';
    alter table [SubDir] add [VersionFiles]  nchar (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'SubLibrary')
BEGIN
    print 'Altered: SubLibrary ,HiveActive';
    alter table [SubLibrary] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'SubLibrary')
BEGIN
    print 'Altered: SubLibrary ,HiveConnectionName';
    alter table [SubLibrary] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LibraryName' and table_name = 'SubLibrary')
BEGIN
    print 'Altered: SubLibrary ,LibraryName';
    alter table [SubLibrary] add [LibraryName]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'SubLibrary')
BEGIN
    print 'Altered: SubLibrary ,RepoName';
    alter table [SubLibrary] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'SubLibrary')
BEGIN
    print 'Altered: SubLibrary ,RepoSvrName';
    alter table [SubLibrary] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'SubLibrary')
BEGIN
    print 'Altered: SubLibrary ,RowCreationDate';
    alter table [SubLibrary] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'SubLibrary')
BEGIN
    print 'Altered: SubLibrary ,RowGuid';
    alter table [SubLibrary] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'SubLibrary')
BEGIN
    print 'Altered: SubLibrary ,RowLastModDate';
    alter table [SubLibrary] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SubLibraryName' and table_name = 'SubLibrary')
BEGIN
    print 'Altered: SubLibrary ,SubLibraryName';
    alter table [SubLibrary] add [SubLibraryName]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SubUserID' and table_name = 'SubLibrary')
BEGIN
    print 'Altered: SubLibrary ,SubUserID';
    alter table [SubLibrary] add [SubUserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'SubLibrary')
BEGIN
    print 'Altered: SubLibrary ,UserID';
    alter table [SubLibrary] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'EntryDate' and table_name = 'SystemMessage')
BEGIN
    print 'Altered: SystemMessage ,EntryDate';
    alter table [SystemMessage] add [EntryDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'EntryGuid' and table_name = 'SystemMessage')
BEGIN
    print 'Altered: SystemMessage ,EntryGuid';
    alter table [SystemMessage] add [EntryGuid]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'EntryMsg' and table_name = 'SystemMessage')
BEGIN
    print 'Altered: SystemMessage ,EntryMsg';
    alter table [SystemMessage] add [EntryMsg]  nvarchar (max)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'SystemMessage')
BEGIN
    print 'Altered: SystemMessage ,HiveActive';
    alter table [SystemMessage] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'SystemMessage')
BEGIN
    print 'Altered: SystemMessage ,HiveConnectionName';
    alter table [SystemMessage] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'SystemMessage')
BEGIN
    print 'Altered: SystemMessage ,RepoName';
    alter table [SystemMessage] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'SystemMessage')
BEGIN
    print 'Altered: SystemMessage ,RepoSvrName';
    alter table [SystemMessage] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'SystemMessage')
BEGIN
    print 'Altered: SystemMessage ,RowCreationDate';
    alter table [SystemMessage] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'SystemMessage')
BEGIN
    print 'Altered: SystemMessage ,RowGuid';
    alter table [SystemMessage] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'SystemMessage')
BEGIN
    print 'Altered: SystemMessage ,RowLastModDate';
    alter table [SystemMessage] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'SystemMessage')
BEGIN
    print 'Altered: SystemMessage ,UserID';
    alter table [SystemMessage] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'flgActive' and table_name = 'SystemParms')
BEGIN
    print 'Altered: SystemParms ,flgActive';
    alter table [SystemParms] add [flgActive]  nchar (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'flgAllSubDirs' and table_name = 'SystemParms')
BEGIN
    print 'Altered: SystemParms ,flgAllSubDirs';
    alter table [SystemParms] add [flgAllSubDirs]  nchar (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'SystemParms')
BEGIN
    print 'Altered: SystemParms ,HiveActive';
    alter table [SystemParms] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'SystemParms')
BEGIN
    print 'Altered: SystemParms ,HiveConnectionName';
    alter table [SystemParms] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'isDirectory' and table_name = 'SystemParms')
BEGIN
    print 'Altered: SystemParms ,isDirectory';
    alter table [SystemParms] add [isDirectory]  nchar (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'isEmailFolder' and table_name = 'SystemParms')
BEGIN
    print 'Altered: SystemParms ,isEmailFolder';
    alter table [SystemParms] add [isEmailFolder]  nchar (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'SystemParms')
BEGIN
    print 'Altered: SystemParms ,RepoName';
    alter table [SystemParms] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'SystemParms')
BEGIN
    print 'Altered: SystemParms ,RepoSvrName';
    alter table [SystemParms] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'SystemParms')
BEGIN
    print 'Altered: SystemParms ,RowCreationDate';
    alter table [SystemParms] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'SystemParms')
BEGIN
    print 'Altered: SystemParms ,RowGuid';
    alter table [SystemParms] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'SystemParms')
BEGIN
    print 'Altered: SystemParms ,RowLastModDate';
    alter table [SystemParms] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SysParm' and table_name = 'SystemParms')
BEGIN
    print 'Altered: SystemParms ,SysParm';
    alter table [SystemParms] add [SysParm]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SysParmDesc' and table_name = 'SystemParms')
BEGIN
    print 'Altered: SystemParms ,SysParmDesc';
    alter table [SystemParms] add [SysParmDesc]  nvarchar (250)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SysParmVal' and table_name = 'SystemParms')
BEGIN
    print 'Altered: SystemParms ,SysParmVal';
    alter table [SystemParms] add [SysParmVal]  nvarchar (250)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'TempUserLibItems')
BEGIN
    print 'Altered: TempUserLibItems ,HiveActive';
    alter table [TempUserLibItems] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'TempUserLibItems')
BEGIN
    print 'Altered: TempUserLibItems ,HiveConnectionName';
    alter table [TempUserLibItems] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'TempUserLibItems')
BEGIN
    print 'Altered: TempUserLibItems ,RepoName';
    alter table [TempUserLibItems] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'TempUserLibItems')
BEGIN
    print 'Altered: TempUserLibItems ,RepoSvrName';
    alter table [TempUserLibItems] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'TempUserLibItems')
BEGIN
    print 'Altered: TempUserLibItems ,RowCreationDate';
    alter table [TempUserLibItems] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'TempUserLibItems')
BEGIN
    print 'Altered: TempUserLibItems ,RowGuid';
    alter table [TempUserLibItems] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'TempUserLibItems')
BEGIN
    print 'Altered: TempUserLibItems ,RowLastModDate';
    alter table [TempUserLibItems] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SourceGuid' and table_name = 'TempUserLibItems')
BEGIN
    print 'Altered: TempUserLibItems ,SourceGuid';
    alter table [TempUserLibItems] add [SourceGuid]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'TempUserLibItems')
BEGIN
    print 'Altered: TempUserLibItems ,UserID';
    alter table [TempUserLibItems] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'iCol' and table_name = 'TestTbl')
BEGIN
    print 'Altered: TestTbl ,iCol';
    alter table [TestTbl] add [iCol]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'TestTbl')
BEGIN
    print 'Altered: TestTbl ,RepoName';
    alter table [TestTbl] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'TestTbl')
BEGIN
    print 'Altered: TestTbl ,RowGuid';
    alter table [TestTbl] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'TestCol' and table_name = 'TestTbl')
BEGIN
    print 'Altered: TestTbl ,TestCol';
    alter table [TestTbl] add [TestCol]  varchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'EntryDate' and table_name = 'Trace')
BEGIN
    print 'Altered: Trace ,EntryDate';
    alter table [Trace] add [EntryDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'Trace')
BEGIN
    print 'Altered: Trace ,HiveActive';
    alter table [Trace] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'Trace')
BEGIN
    print 'Altered: Trace ,HiveConnectionName';
    alter table [Trace] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LogEntry' and table_name = 'Trace')
BEGIN
    print 'Altered: Trace ,LogEntry';
    alter table [Trace] add [LogEntry]  nvarchar (max)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'Trace')
BEGIN
    print 'Altered: Trace ,RepoName';
    alter table [Trace] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'Trace')
BEGIN
    print 'Altered: Trace ,RepoSvrName';
    alter table [Trace] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'Trace')
BEGIN
    print 'Altered: Trace ,RowCreationDate';
    alter table [Trace] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'Trace')
BEGIN
    print 'Altered: Trace ,RowGuid';
    alter table [Trace] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'Trace')
BEGIN
    print 'Altered: Trace ,RowLastModDate';
    alter table [Trace] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CreateDate' and table_name = 'txTimes')
BEGIN
    print 'Altered: txTimes ,CreateDate';
    alter table [txTimes] add [CreateDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'txTimes')
BEGIN
    print 'Altered: txTimes ,RepoName';
    alter table [txTimes] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'txTimes')
BEGIN
    print 'Altered: txTimes ,RowGuid';
    alter table [txTimes] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'StmtID' and table_name = 'txTimes')
BEGIN
    print 'Altered: txTimes ,StmtID';
    alter table [txTimes] add [StmtID]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'txTime' and table_name = 'txTimes')
BEGIN
    print 'Altered: txTimes ,txTime';
    alter table [txTimes] add [txTime]  decimal; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Code' and table_name = 'UD_Qty')
BEGIN
    print 'Altered: UD_Qty ,Code';
    alter table [UD_Qty] add [Code]  char (10)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Description' and table_name = 'UD_Qty')
BEGIN
    print 'Altered: UD_Qty ,Description';
    alter table [UD_Qty] add [Description]  char (10)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'UD_Qty')
BEGIN
    print 'Altered: UD_Qty ,HiveActive';
    alter table [UD_Qty] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'UD_Qty')
BEGIN
    print 'Altered: UD_Qty ,HiveConnectionName';
    alter table [UD_Qty] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'UD_Qty')
BEGIN
    print 'Altered: UD_Qty ,RepoName';
    alter table [UD_Qty] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'UD_Qty')
BEGIN
    print 'Altered: UD_Qty ,RepoSvrName';
    alter table [UD_Qty] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'UD_Qty')
BEGIN
    print 'Altered: UD_Qty ,RowCreationDate';
    alter table [UD_Qty] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'UD_Qty')
BEGIN
    print 'Altered: UD_Qty ,RowGuid';
    alter table [UD_Qty] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'UD_Qty')
BEGIN
    print 'Altered: UD_Qty ,RowLastModDate';
    alter table [UD_Qty] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'upgrade_status')
BEGIN
    print 'Altered: upgrade_status ,HiveActive';
    alter table [upgrade_status] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'upgrade_status')
BEGIN
    print 'Altered: upgrade_status ,HiveConnectionName';
    alter table [upgrade_status] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'name' and table_name = 'upgrade_status')
BEGIN
    print 'Altered: upgrade_status ,name';
    alter table [upgrade_status] add [name]  varchar (30)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'upgrade_status')
BEGIN
    print 'Altered: upgrade_status ,RepoName';
    alter table [upgrade_status] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'upgrade_status')
BEGIN
    print 'Altered: upgrade_status ,RepoSvrName';
    alter table [upgrade_status] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'upgrade_status')
BEGIN
    print 'Altered: upgrade_status ,RowCreationDate';
    alter table [upgrade_status] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'upgrade_status')
BEGIN
    print 'Altered: upgrade_status ,RowGuid';
    alter table [upgrade_status] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'upgrade_status')
BEGIN
    print 'Altered: upgrade_status ,RowLastModDate';
    alter table [upgrade_status] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'status' and table_name = 'upgrade_status')
BEGIN
    print 'Altered: upgrade_status ,status';
    alter table [upgrade_status] add [status]  varchar (10)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'UrlList')
BEGIN
    print 'Altered: UrlList ,HiveActive';
    alter table [UrlList] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'UrlList')
BEGIN
    print 'Altered: UrlList ,HiveConnectionName';
    alter table [UrlList] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'UrlList')
BEGIN
    print 'Altered: UrlList ,RepoName';
    alter table [UrlList] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'UrlList')
BEGIN
    print 'Altered: UrlList ,RepoSvrName';
    alter table [UrlList] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'UrlList')
BEGIN
    print 'Altered: UrlList ,RowCreationDate';
    alter table [UrlList] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'UrlList')
BEGIN
    print 'Altered: UrlList ,RowGuid';
    alter table [UrlList] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'UrlList')
BEGIN
    print 'Altered: UrlList ,RowLastModDate';
    alter table [UrlList] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'URL' and table_name = 'UrlList')
BEGIN
    print 'Altered: UrlList ,URL';
    alter table [UrlList] add [URL]  nvarchar (425)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'UrlRejection')
BEGIN
    print 'Altered: UrlRejection ,HiveActive';
    alter table [UrlRejection] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'UrlRejection')
BEGIN
    print 'Altered: UrlRejection ,HiveConnectionName';
    alter table [UrlRejection] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RejectionPattern' and table_name = 'UrlRejection')
BEGIN
    print 'Altered: UrlRejection ,RejectionPattern';
    alter table [UrlRejection] add [RejectionPattern]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'UrlRejection')
BEGIN
    print 'Altered: UrlRejection ,RepoName';
    alter table [UrlRejection] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'UrlRejection')
BEGIN
    print 'Altered: UrlRejection ,RepoSvrName';
    alter table [UrlRejection] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'UrlRejection')
BEGIN
    print 'Altered: UrlRejection ,RowCreationDate';
    alter table [UrlRejection] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'UrlRejection')
BEGIN
    print 'Altered: UrlRejection ,RowGuid';
    alter table [UrlRejection] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'UrlRejection')
BEGIN
    print 'Altered: UrlRejection ,RowLastModDate';
    alter table [UrlRejection] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'UserCurrParm')
BEGIN
    print 'Altered: UserCurrParm ,HiveActive';
    alter table [UserCurrParm] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'UserCurrParm')
BEGIN
    print 'Altered: UserCurrParm ,HiveConnectionName';
    alter table [UserCurrParm] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ParmName' and table_name = 'UserCurrParm')
BEGIN
    print 'Altered: UserCurrParm ,ParmName';
    alter table [UserCurrParm] add [ParmName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ParmVal' and table_name = 'UserCurrParm')
BEGIN
    print 'Altered: UserCurrParm ,ParmVal';
    alter table [UserCurrParm] add [ParmVal]  nvarchar (2000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'UserCurrParm')
BEGIN
    print 'Altered: UserCurrParm ,RepoName';
    alter table [UserCurrParm] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'UserCurrParm')
BEGIN
    print 'Altered: UserCurrParm ,RepoSvrName';
    alter table [UserCurrParm] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'UserCurrParm')
BEGIN
    print 'Altered: UserCurrParm ,RowCreationDate';
    alter table [UserCurrParm] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'UserCurrParm')
BEGIN
    print 'Altered: UserCurrParm ,RowGuid';
    alter table [UserCurrParm] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'UserCurrParm')
BEGIN
    print 'Altered: UserCurrParm ,RowLastModDate';
    alter table [UserCurrParm] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'UserCurrParm')
BEGIN
    print 'Altered: UserCurrParm ,UserID';
    alter table [UserCurrParm] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ColName' and table_name = 'UserGridState')
BEGIN
    print 'Altered: UserGridState ,ColName';
    alter table [UserGridState] add [ColName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ColOrder' and table_name = 'UserGridState')
BEGIN
    print 'Altered: UserGridState ,ColOrder';
    alter table [UserGridState] add [ColOrder]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ColReadOnly' and table_name = 'UserGridState')
BEGIN
    print 'Altered: UserGridState ,ColReadOnly';
    alter table [UserGridState] add [ColReadOnly]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ColSortAsc' and table_name = 'UserGridState')
BEGIN
    print 'Altered: UserGridState ,ColSortAsc';
    alter table [UserGridState] add [ColSortAsc]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ColSortOrder' and table_name = 'UserGridState')
BEGIN
    print 'Altered: UserGridState ,ColSortOrder';
    alter table [UserGridState] add [ColSortOrder]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ColVisible' and table_name = 'UserGridState')
BEGIN
    print 'Altered: UserGridState ,ColVisible';
    alter table [UserGridState] add [ColVisible]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ColWidth' and table_name = 'UserGridState')
BEGIN
    print 'Altered: UserGridState ,ColWidth';
    alter table [UserGridState] add [ColWidth]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'GridName' and table_name = 'UserGridState')
BEGIN
    print 'Altered: UserGridState ,GridName';
    alter table [UserGridState] add [GridName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'UserGridState')
BEGIN
    print 'Altered: UserGridState ,HiveActive';
    alter table [UserGridState] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'UserGridState')
BEGIN
    print 'Altered: UserGridState ,HiveConnectionName';
    alter table [UserGridState] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'UserGridState')
BEGIN
    print 'Altered: UserGridState ,RepoName';
    alter table [UserGridState] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'UserGridState')
BEGIN
    print 'Altered: UserGridState ,RepoSvrName';
    alter table [UserGridState] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'UserGridState')
BEGIN
    print 'Altered: UserGridState ,RowCreationDate';
    alter table [UserGridState] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'UserGridState')
BEGIN
    print 'Altered: UserGridState ,RowGuid';
    alter table [UserGridState] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'UserGridState')
BEGIN
    print 'Altered: UserGridState ,RowLastModDate';
    alter table [UserGridState] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowNbr' and table_name = 'UserGridState')
BEGIN
    print 'Altered: UserGridState ,RowNbr';
    alter table [UserGridState] add [RowNbr]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ScreenName' and table_name = 'UserGridState')
BEGIN
    print 'Altered: UserGridState ,ScreenName';
    alter table [UserGridState] add [ScreenName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'UserGridState')
BEGIN
    print 'Altered: UserGridState ,UserID';
    alter table [UserGridState] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'GroupName' and table_name = 'UserGroup')
BEGIN
    print 'Altered: UserGroup ,GroupName';
    alter table [UserGroup] add [GroupName]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'GroupOwnerUserID' and table_name = 'UserGroup')
BEGIN
    print 'Altered: UserGroup ,GroupOwnerUserID';
    alter table [UserGroup] add [GroupOwnerUserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'UserGroup')
BEGIN
    print 'Altered: UserGroup ,HiveActive';
    alter table [UserGroup] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'UserGroup')
BEGIN
    print 'Altered: UserGroup ,HiveConnectionName';
    alter table [UserGroup] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'UserGroup')
BEGIN
    print 'Altered: UserGroup ,RepoName';
    alter table [UserGroup] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'UserGroup')
BEGIN
    print 'Altered: UserGroup ,RepoSvrName';
    alter table [UserGroup] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'UserGroup')
BEGIN
    print 'Altered: UserGroup ,RowCreationDate';
    alter table [UserGroup] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'UserGroup')
BEGIN
    print 'Altered: UserGroup ,RowGuid';
    alter table [UserGroup] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'UserGroup')
BEGIN
    print 'Altered: UserGroup ,RowLastModDate';
    alter table [UserGroup] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'UserReassignHist')
BEGIN
    print 'Altered: UserReassignHist ,HiveActive';
    alter table [UserReassignHist] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'UserReassignHist')
BEGIN
    print 'Altered: UserReassignHist ,HiveConnectionName';
    alter table [UserReassignHist] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'PrevAdmin' and table_name = 'UserReassignHist')
BEGIN
    print 'Altered: UserReassignHist ,PrevAdmin';
    alter table [UserReassignHist] add [PrevAdmin]  nchar (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'PrevEmailAddress' and table_name = 'UserReassignHist')
BEGIN
    print 'Altered: UserReassignHist ,PrevEmailAddress';
    alter table [UserReassignHist] add [PrevEmailAddress]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'PrevisActive' and table_name = 'UserReassignHist')
BEGIN
    print 'Altered: UserReassignHist ,PrevisActive';
    alter table [UserReassignHist] add [PrevisActive]  nchar (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'PrevUserID' and table_name = 'UserReassignHist')
BEGIN
    print 'Altered: UserReassignHist ,PrevUserID';
    alter table [UserReassignHist] add [PrevUserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'PrevUserLoginID' and table_name = 'UserReassignHist')
BEGIN
    print 'Altered: UserReassignHist ,PrevUserLoginID';
    alter table [UserReassignHist] add [PrevUserLoginID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'PrevUserName' and table_name = 'UserReassignHist')
BEGIN
    print 'Altered: UserReassignHist ,PrevUserName';
    alter table [UserReassignHist] add [PrevUserName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'PrevUserPassword' and table_name = 'UserReassignHist')
BEGIN
    print 'Altered: UserReassignHist ,PrevUserPassword';
    alter table [UserReassignHist] add [PrevUserPassword]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ReassignedAdmin' and table_name = 'UserReassignHist')
BEGIN
    print 'Altered: UserReassignHist ,ReassignedAdmin';
    alter table [UserReassignHist] add [ReassignedAdmin]  nchar (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ReassignedEmailAddress' and table_name = 'UserReassignHist')
BEGIN
    print 'Altered: UserReassignHist ,ReassignedEmailAddress';
    alter table [UserReassignHist] add [ReassignedEmailAddress]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ReassignedisActive' and table_name = 'UserReassignHist')
BEGIN
    print 'Altered: UserReassignHist ,ReassignedisActive';
    alter table [UserReassignHist] add [ReassignedisActive]  nchar (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ReassignedUserID' and table_name = 'UserReassignHist')
BEGIN
    print 'Altered: UserReassignHist ,ReassignedUserID';
    alter table [UserReassignHist] add [ReassignedUserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ReassignedUserLoginID' and table_name = 'UserReassignHist')
BEGIN
    print 'Altered: UserReassignHist ,ReassignedUserLoginID';
    alter table [UserReassignHist] add [ReassignedUserLoginID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ReassignedUserName' and table_name = 'UserReassignHist')
BEGIN
    print 'Altered: UserReassignHist ,ReassignedUserName';
    alter table [UserReassignHist] add [ReassignedUserName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ReassignedUserPassword' and table_name = 'UserReassignHist')
BEGIN
    print 'Altered: UserReassignHist ,ReassignedUserPassword';
    alter table [UserReassignHist] add [ReassignedUserPassword]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ReassignmentDate' and table_name = 'UserReassignHist')
BEGIN
    print 'Altered: UserReassignHist ,ReassignmentDate';
    alter table [UserReassignHist] add [ReassignmentDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'UserReassignHist')
BEGIN
    print 'Altered: UserReassignHist ,RepoName';
    alter table [UserReassignHist] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'UserReassignHist')
BEGIN
    print 'Altered: UserReassignHist ,RepoSvrName';
    alter table [UserReassignHist] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'UserReassignHist')
BEGIN
    print 'Altered: UserReassignHist ,RowCreationDate';
    alter table [UserReassignHist] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'UserReassignHist')
BEGIN
    print 'Altered: UserReassignHist ,RowGuid';
    alter table [UserReassignHist] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowID' and table_name = 'UserReassignHist')
BEGIN
    print 'Altered: UserReassignHist ,RowID';
    alter table [UserReassignHist] add [RowID]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'UserReassignHist')
BEGIN
    print 'Altered: UserReassignHist ,RowLastModDate';
    alter table [UserReassignHist] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ActiveGuid' and table_name = 'Users')
BEGIN
    print 'Altered: Users ,ActiveGuid';
    alter table [Users] add [ActiveGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Admin' and table_name = 'Users')
BEGIN
    print 'Altered: Users ,Admin';
    alter table [Users] add [Admin]  nchar (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ClientOnly' and table_name = 'Users')
BEGIN
    print 'Altered: Users ,ClientOnly';
    alter table [Users] add [ClientOnly]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'EmailAddress' and table_name = 'Users')
BEGIN
    print 'Altered: Users ,EmailAddress';
    alter table [Users] add [EmailAddress]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'Users')
BEGIN
    print 'Altered: Users ,HiveActive';
    alter table [Users] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'Users')
BEGIN
    print 'Altered: Users ,HiveConnectionName';
    alter table [Users] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'isActive' and table_name = 'Users')
BEGIN
    print 'Altered: Users ,isActive';
    alter table [Users] add [isActive]  nchar (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'Users')
BEGIN
    print 'Altered: Users ,RepoName';
    alter table [Users] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'Users')
BEGIN
    print 'Altered: Users ,RepoSvrName';
    alter table [Users] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'Users')
BEGIN
    print 'Altered: Users ,RowCreationDate';
    alter table [Users] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'Users')
BEGIN
    print 'Altered: Users ,RowGuid';
    alter table [Users] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'Users')
BEGIN
    print 'Altered: Users ,RowLastModDate';
    alter table [Users] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'Users')
BEGIN
    print 'Altered: Users ,UserID';
    alter table [Users] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserLoginID' and table_name = 'Users')
BEGIN
    print 'Altered: Users ,UserLoginID';
    alter table [Users] add [UserLoginID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserName' and table_name = 'Users')
BEGIN
    print 'Altered: Users ,UserName';
    alter table [Users] add [UserName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserPassword' and table_name = 'Users')
BEGIN
    print 'Altered: Users ,UserPassword';
    alter table [Users] add [UserPassword]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'UserScreenState')
BEGIN
    print 'Altered: UserScreenState ,HiveActive';
    alter table [UserScreenState] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'UserScreenState')
BEGIN
    print 'Altered: UserScreenState ,HiveConnectionName';
    alter table [UserScreenState] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ParmDataType' and table_name = 'UserScreenState')
BEGIN
    print 'Altered: UserScreenState ,ParmDataType';
    alter table [UserScreenState] add [ParmDataType]  nvarchar (15)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ParmName' and table_name = 'UserScreenState')
BEGIN
    print 'Altered: UserScreenState ,ParmName';
    alter table [UserScreenState] add [ParmName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ParmVal' and table_name = 'UserScreenState')
BEGIN
    print 'Altered: UserScreenState ,ParmVal';
    alter table [UserScreenState] add [ParmVal]  nvarchar (2000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'UserScreenState')
BEGIN
    print 'Altered: UserScreenState ,RepoName';
    alter table [UserScreenState] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'UserScreenState')
BEGIN
    print 'Altered: UserScreenState ,RepoSvrName';
    alter table [UserScreenState] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'UserScreenState')
BEGIN
    print 'Altered: UserScreenState ,RowCreationDate';
    alter table [UserScreenState] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'UserScreenState')
BEGIN
    print 'Altered: UserScreenState ,RowGuid';
    alter table [UserScreenState] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'UserScreenState')
BEGIN
    print 'Altered: UserScreenState ,RowLastModDate';
    alter table [UserScreenState] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowNbr' and table_name = 'UserScreenState')
BEGIN
    print 'Altered: UserScreenState ,RowNbr';
    alter table [UserScreenState] add [RowNbr]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ScreenName' and table_name = 'UserScreenState')
BEGIN
    print 'Altered: UserScreenState ,ScreenName';
    alter table [UserScreenState] add [ScreenName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'UserScreenState')
BEGIN
    print 'Altered: UserScreenState ,UserID';
    alter table [UserScreenState] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'UserSearchState')
BEGIN
    print 'Altered: UserSearchState ,HiveActive';
    alter table [UserSearchState] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'UserSearchState')
BEGIN
    print 'Altered: UserSearchState ,HiveConnectionName';
    alter table [UserSearchState] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ParmDataType' and table_name = 'UserSearchState')
BEGIN
    print 'Altered: UserSearchState ,ParmDataType';
    alter table [UserSearchState] add [ParmDataType]  nvarchar (2000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ParmName' and table_name = 'UserSearchState')
BEGIN
    print 'Altered: UserSearchState ,ParmName';
    alter table [UserSearchState] add [ParmName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ParmVal' and table_name = 'UserSearchState')
BEGIN
    print 'Altered: UserSearchState ,ParmVal';
    alter table [UserSearchState] add [ParmVal]  nvarchar (2000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'UserSearchState')
BEGIN
    print 'Altered: UserSearchState ,RepoName';
    alter table [UserSearchState] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'UserSearchState')
BEGIN
    print 'Altered: UserSearchState ,RepoSvrName';
    alter table [UserSearchState] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'UserSearchState')
BEGIN
    print 'Altered: UserSearchState ,RowCreationDate';
    alter table [UserSearchState] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'UserSearchState')
BEGIN
    print 'Altered: UserSearchState ,RowGuid';
    alter table [UserSearchState] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'UserSearchState')
BEGIN
    print 'Altered: UserSearchState ,RowLastModDate';
    alter table [UserSearchState] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowNbr' and table_name = 'UserSearchState')
BEGIN
    print 'Altered: UserSearchState ,RowNbr';
    alter table [UserSearchState] add [RowNbr]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ScreenName' and table_name = 'UserSearchState')
BEGIN
    print 'Altered: UserSearchState ,ScreenName';
    alter table [UserSearchState] add [ScreenName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SearchID' and table_name = 'UserSearchState')
BEGIN
    print 'Altered: UserSearchState ,SearchID';
    alter table [UserSearchState] add [SearchID]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'UserSearchState')
BEGIN
    print 'Altered: UserSearchState ,UserID';
    alter table [UserSearchState] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'VersionInfo')
BEGIN
    print 'Altered: VersionInfo ,HiveActive';
    alter table [VersionInfo] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'VersionInfo')
BEGIN
    print 'Altered: VersionInfo ,HiveConnectionName';
    alter table [VersionInfo] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Product' and table_name = 'VersionInfo')
BEGIN
    print 'Altered: VersionInfo ,Product';
    alter table [VersionInfo] add [Product]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ProductVersion' and table_name = 'VersionInfo')
BEGIN
    print 'Altered: VersionInfo ,ProductVersion';
    alter table [VersionInfo] add [ProductVersion]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'VersionInfo')
BEGIN
    print 'Altered: VersionInfo ,RepoName';
    alter table [VersionInfo] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'VersionInfo')
BEGIN
    print 'Altered: VersionInfo ,RepoSvrName';
    alter table [VersionInfo] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'VersionInfo')
BEGIN
    print 'Altered: VersionInfo ,RowCreationDate';
    alter table [VersionInfo] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'VersionInfo')
BEGIN
    print 'Altered: VersionInfo ,RowGuid';
    alter table [VersionInfo] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'VersionInfo')
BEGIN
    print 'Altered: VersionInfo ,RowLastModDate';
    alter table [VersionInfo] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CreateDate' and table_name = 'Volitility')
BEGIN
    print 'Altered: Volitility ,CreateDate';
    alter table [Volitility] add [CreateDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'Volitility')
BEGIN
    print 'Altered: Volitility ,HiveActive';
    alter table [Volitility] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'Volitility')
BEGIN
    print 'Altered: Volitility ,HiveConnectionName';
    alter table [Volitility] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'Volitility')
BEGIN
    print 'Altered: Volitility ,RepoName';
    alter table [Volitility] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'Volitility')
BEGIN
    print 'Altered: Volitility ,RepoSvrName';
    alter table [Volitility] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'Volitility')
BEGIN
    print 'Altered: Volitility ,RowCreationDate';
    alter table [Volitility] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'Volitility')
BEGIN
    print 'Altered: Volitility ,RowGuid';
    alter table [Volitility] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'Volitility')
BEGIN
    print 'Altered: Volitility ,RowLastModDate';
    alter table [Volitility] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'VolitilityCode' and table_name = 'Volitility')
BEGIN
    print 'Altered: Volitility ,VolitilityCode';
    alter table [Volitility] add [VolitilityCode]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'VolitilityDesc' and table_name = 'Volitility')
BEGIN
    print 'Altered: Volitility ,VolitilityDesc';
    alter table [Volitility] add [VolitilityDesc]  nvarchar (18)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CreateDate' and table_name = 'WebScreen')
BEGIN
    print 'Altered: WebScreen ,CreateDate';
    alter table [WebScreen] add [CreateDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'isPublic' and table_name = 'WebScreen')
BEGIN
    print 'Altered: WebScreen ,isPublic';
    alter table [WebScreen] add [isPublic]  char (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'WebScreen')
BEGIN
    print 'Altered: WebScreen ,RepoName';
    alter table [WebScreen] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RetentionCode' and table_name = 'WebScreen')
BEGIN
    print 'Altered: WebScreen ,RetentionCode';
    alter table [WebScreen] add [RetentionCode]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'WebScreen')
BEGIN
    print 'Altered: WebScreen ,RowGuid';
    alter table [WebScreen] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'WebScreen')
BEGIN
    print 'Altered: WebScreen ,UserID';
    alter table [WebScreen] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'WebScreen' and table_name = 'WebScreen')
BEGIN
    print 'Altered: WebScreen ,WebScreen';
    alter table [WebScreen] add [WebScreen]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'WebUrl' and table_name = 'WebScreen')
BEGIN
    print 'Altered: WebScreen ,WebUrl';
    alter table [WebScreen] add [WebUrl]  nvarchar (400)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CreateDate' and table_name = 'WebSite')
BEGIN
    print 'Altered: WebSite ,CreateDate';
    alter table [WebSite] add [CreateDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Depth' and table_name = 'WebSite')
BEGIN
    print 'Altered: WebSite ,Depth';
    alter table [WebSite] add [Depth]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'isPublic' and table_name = 'WebSite')
BEGIN
    print 'Altered: WebSite ,isPublic';
    alter table [WebSite] add [isPublic]  char (1)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'WebSite')
BEGIN
    print 'Altered: WebSite ,RepoName';
    alter table [WebSite] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RetentionCode' and table_name = 'WebSite')
BEGIN
    print 'Altered: WebSite ,RetentionCode';
    alter table [WebSite] add [RetentionCode]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'WebSite')
BEGIN
    print 'Altered: WebSite ,RowGuid';
    alter table [WebSite] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'UserID' and table_name = 'WebSite')
BEGIN
    print 'Altered: WebSite ,UserID';
    alter table [WebSite] add [UserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'WebSite' and table_name = 'WebSite')
BEGIN
    print 'Altered: WebSite ,WebSite';
    alter table [WebSite] add [WebSite]  nvarchar (80)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'WebUrl' and table_name = 'WebSite')
BEGIN
    print 'Altered: WebSite ,WebUrl';
    alter table [WebSite] add [WebUrl]  nvarchar (400)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Width' and table_name = 'WebSite')
BEGIN
    print 'Altered: WebSite ,Width';
    alter table [WebSite] add [Width]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CreateDate' and table_name = 'WebSource')
BEGIN
    print 'Altered: WebSource ,CreateDate';
    alter table [WebSource] add [CreateDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'CreationDate' and table_name = 'WebSource')
BEGIN
    print 'Altered: WebSource ,CreationDate';
    alter table [WebSource] add [CreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Description' and table_name = 'WebSource')
BEGIN
    print 'Altered: WebSource ,Description';
    alter table [WebSource] add [Description]  nvarchar (max)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'FileLength' and table_name = 'WebSource')
BEGIN
    print 'Altered: WebSource ,FileLength';
    alter table [WebSource] add [FileLength]  int; -- Unspecified Datatype
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'WebSource')
BEGIN
    print 'Altered: WebSource ,HiveActive';
    alter table [WebSource] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'WebSource')
BEGIN
    print 'Altered: WebSource ,HiveConnectionName';
    alter table [WebSource] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'KeyWords' and table_name = 'WebSource')
BEGIN
    print 'Altered: WebSource ,KeyWords';
    alter table [WebSource] add [KeyWords]  nvarchar (2000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'LastWriteTime' and table_name = 'WebSource')
BEGIN
    print 'Altered: WebSource ,LastWriteTime';
    alter table [WebSource] add [LastWriteTime]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'Notes' and table_name = 'WebSource')
BEGIN
    print 'Altered: WebSource ,Notes';
    alter table [WebSource] add [Notes]  nvarchar (2000)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'WebSource')
BEGIN
    print 'Altered: WebSource ,RepoName';
    alter table [WebSource] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'WebSource')
BEGIN
    print 'Altered: WebSource ,RepoSvrName';
    alter table [WebSource] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RetentionExpirationDate' and table_name = 'WebSource')
BEGIN
    print 'Altered: WebSource ,RetentionExpirationDate';
    alter table [WebSource] add [RetentionExpirationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'WebSource')
BEGIN
    print 'Altered: WebSource ,RowCreationDate';
    alter table [WebSource] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'WebSource')
BEGIN
    print 'Altered: WebSource ,RowGuid';
    alter table [WebSource] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'WebSource')
BEGIN
    print 'Altered: WebSource ,RowLastModDate';
    alter table [WebSource] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SourceGuid' and table_name = 'WebSource')
BEGIN
    print 'Altered: WebSource ,SourceGuid';
    alter table [WebSource] add [SourceGuid]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SourceImage' and table_name = 'WebSource')
BEGIN
    print 'Altered: WebSource ,SourceImage';
    alter table [WebSource] add [SourceImage]  image ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SourceName' and table_name = 'WebSource')
BEGIN
    print 'Altered: WebSource ,SourceName';
    alter table [WebSource] add [SourceName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SourceTypeCode' and table_name = 'WebSource')
BEGIN
    print 'Altered: WebSource ,SourceTypeCode';
    alter table [WebSource] add [SourceTypeCode]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'ContentGUID' and table_name = 'ZippedFiles')
BEGIN
    print 'Altered: ZippedFiles ,ContentGUID';
    alter table [ZippedFiles] add [ContentGUID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'DataSourceOwnerUserID' and table_name = 'ZippedFiles')
BEGIN
    print 'Altered: ZippedFiles ,DataSourceOwnerUserID';
    alter table [ZippedFiles] add [DataSourceOwnerUserID]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveActive' and table_name = 'ZippedFiles')
BEGIN
    print 'Altered: ZippedFiles ,HiveActive';
    alter table [ZippedFiles] add [HiveActive]  bit ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'HiveConnectionName' and table_name = 'ZippedFiles')
BEGIN
    print 'Altered: ZippedFiles ,HiveConnectionName';
    alter table [ZippedFiles] add [HiveConnectionName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoName' and table_name = 'ZippedFiles')
BEGIN
    print 'Altered: ZippedFiles ,RepoName';
    alter table [ZippedFiles] add [RepoName]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RepoSvrName' and table_name = 'ZippedFiles')
BEGIN
    print 'Altered: ZippedFiles ,RepoSvrName';
    alter table [ZippedFiles] add [RepoSvrName]  nvarchar (254)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowCreationDate' and table_name = 'ZippedFiles')
BEGIN
    print 'Altered: ZippedFiles ,RowCreationDate';
    alter table [ZippedFiles] add [RowCreationDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowGuid' and table_name = 'ZippedFiles')
BEGIN
    print 'Altered: ZippedFiles ,RowGuid';
    alter table [ZippedFiles] add [RowGuid]  uniqueidentifier ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'RowLastModDate' and table_name = 'ZippedFiles')
BEGIN
    print 'Altered: ZippedFiles ,RowLastModDate';
    alter table [ZippedFiles] add [RowLastModDate]  datetime ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SourceGuid' and table_name = 'ZippedFiles')
BEGIN
    print 'Altered: ZippedFiles ,SourceGuid';
    alter table [ZippedFiles] add [SourceGuid]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SourceImage' and table_name = 'ZippedFiles')
BEGIN
    print 'Altered: ZippedFiles ,SourceImage';
    alter table [ZippedFiles] add [SourceImage]  image ;
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SourceTypeCode' and table_name = 'ZippedFiles')
BEGIN
    print 'Altered: ZippedFiles ,SourceTypeCode';
    alter table [ZippedFiles] add [SourceTypeCode]  nvarchar (50)
END
GO

If not exists (select column_name from INFORMATION_SCHEMA.COLUMNS where column_name = 'SourceTypeCode' and table_name = 'ZippedFiles')
BEGIN
    print 'Altered: ZippedFiles ,SourceTypeCode';
    alter table [ZippedFiles] add [SourceTypeCode]  nvarchar (50)
END
GO

