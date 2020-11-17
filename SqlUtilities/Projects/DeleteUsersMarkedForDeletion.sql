alter table Users add MarkForDeletion as bit null
go

delete from GroupUsers
where UserID in (Select UserID from Users where MarkForDeletion = 1)

delete from LibraryItems
where DataSourceOwnerUserID in (Select UserID from Users where MarkForDeletion = 1)

delete from LibraryItems
where LibraryOwnerUserID in (Select UserID from Users where MarkForDeletion = 1)

delete from LibraryUsers
where UserID in (Select UserID from Users where MarkForDeletion = 1)

delete from CoOwner
where CurrentOwnerUserID in (Select UserID from Users where MarkForDeletion = 1)

delete from SubDir
where UserID in (Select UserID from Users where MarkForDeletion = 1)

delete from Directory
where UserID in (Select UserID from Users where MarkForDeletion = 1)

delete from Email
where UserID in (Select UserID from Users where MarkForDeletion = 1)

delete from DataSource 
where DataSourceOwnerUserID in (Select UserID from Users where MarkForDeletion = 1)

delete from DataSource 
where DataSourceOwnerUserID in (Select UserID from Users where MarkForDeletion = 1)

delete from ActiveDirUser
where UserID in (Select UserID from Users where MarkForDeletion = 1 )

delete from ActiveSearchGuids
where UserID in (Select UserID from Users where MarkForDeletion = 1 )

delete from ArchiveFrom
where UserID in (Select UserID from Users where MarkForDeletion = 1 )

delete from ArchiveStats
where UserID in (Select UserID from Users where MarkForDeletion = 1 )

delete from ContactFrom
where UserID in (Select UserID from Users where MarkForDeletion = 1 )

delete from ContactsArchive
where UserID in (Select UserID from Users where MarkForDeletion = 1 )

delete from DataOwners
where UserID in (Select UserID from Users where MarkForDeletion = 1 )

delete from DataSource
where UserID in (Select UserID from Users where MarkForDeletion = 1 )

delete from DataSourceOwner
where UserID in (Select UserID from Users where MarkForDeletion = 1 )

delete from DeleteFrom
where UserID in (Select UserID from Users where MarkForDeletion = 1 )

delete from Directory
where UserID in (Select UserID from Users where MarkForDeletion = 1 )

delete from DirectoryListener
where UserID in (Select UserID from Users where MarkForDeletion = 1 )

delete from DirectoryListenerFiles
where UserID in (Select UserID from Users where MarkForDeletion = 1 )

delete from Email
where UserID in (Select UserID from Users where MarkForDeletion = 1 )

delete from EmailArchParms
where UserID in (Select UserID from Users where MarkForDeletion = 1 )

delete from EmailAttachment
where UserID in (Select UserID from Users where MarkForDeletion = 1 )

delete from EmailAttachmentSearchList
where UserID in (Select UserID from Users where MarkForDeletion = 1 )

delete from EmailFolder
where UserID in (Select UserID from Users where MarkForDeletion = 1 )

delete from EmailFolder_BAK
where UserID in (Select UserID from Users where MarkForDeletion = 1 )

delete from EmailFolder_BAK2
where UserID in (Select UserID from Users where MarkForDeletion = 1 )

delete from EmailToDelete
where UserID in (Select UserID from Users where MarkForDeletion = 1 )

delete from ExchangeHostPop
where UserID in (Select UserID from Users where MarkForDeletion = 1 )

delete from ExcludedFiles
where UserID in (Select UserID from Users where MarkForDeletion = 1 )

delete from ExcludeFrom
where UserID in (Select UserID from Users where MarkForDeletion = 1 )

delete from FilesToDelete
where UserID in (Select UserID from Users where MarkForDeletion = 1 )

delete from GlobalSeachResults
where UserID in (Select UserID from Users where MarkForDeletion = 1 )

delete from GroupLibraryAccess
where UserID in (Select UserID from Users where MarkForDeletion = 1 )

delete from GroupUsers
where UserID in (Select UserID from Users where MarkForDeletion = 1 )

delete from HelpTextUser
where UserID in (Select UserID from Users where MarkForDeletion = 1 )

delete from IncludedFiles
where UserID in (Select UserID from Users where MarkForDeletion = 1 )

delete from IncludeImmediate
where UserID in (Select UserID from Users where MarkForDeletion = 1 )

delete from LibDirectory
where UserID in (Select UserID from Users where MarkForDeletion = 1 )

delete from LibEmail
where UserID in (Select UserID from Users where MarkForDeletion = 1 )

delete from Library
where UserID in (Select UserID from Users where MarkForDeletion = 1 )

delete from LibraryUsers
where UserID in (Select UserID from Users where MarkForDeletion = 1 )

delete from Machine
where UserID in (Select UserID from Users where MarkForDeletion = 1 )

delete from OutlookFrom
where UserID in (Select UserID from Users where MarkForDeletion = 1 )

delete from PgmTrace
where UserID in (Select UserID from Users where MarkForDeletion = 1 )

delete from QuickDirectory
where UserID in (Select UserID from Users where MarkForDeletion = 1 )

delete from QuickRef
where UserID in (Select UserID from Users where MarkForDeletion = 1 )

delete from RetentionTemp
where UserID in (Select UserID from Users where MarkForDeletion = 1 )

delete from RunParms
where UserID in (Select UserID from Users where MarkForDeletion = 1 )

delete from RuntimeErrors
where UserID in (Select UserID from Users where MarkForDeletion = 1 )

delete from SavedItems
where UserID in (Select UserID from Users where MarkForDeletion = 1 )

delete from SearchHistory
where UserID in (Select UserID from Users where MarkForDeletion = 1 )

delete from SearhParmsHistory
where UserID in (Select UserID from Users where MarkForDeletion = 1 )

delete from SubDir
where UserID in (Select UserID from Users where MarkForDeletion = 1 )

delete from SubLibrary
where UserID in (Select UserID from Users where MarkForDeletion = 1 )

delete from SystemMessage
where UserID in (Select UserID from Users where MarkForDeletion = 1 )

delete from TempUserLibItems
where UserID in (Select UserID from Users where MarkForDeletion = 1 )

delete from UserCurrParm
where UserID in (Select UserID from Users where MarkForDeletion = 1 )
delete from UserCurrParm
where UserID in (Select UserID from Users where MarkForDeletion = 1)
delete from DataOwners
where UserID in (Select UserID from Users where MarkForDeletion = 1)

delete from DataSource
where UserID in (Select UserID from Users where MarkForDeletion = 1)

delete from DataSourceCheckOut
where DataSourceOwnerUserID in (Select UserID from Users where MarkForDeletion = 1)

delete from DataSourceRestoreHistory
where DataSourceOwnerUserID in (Select UserID from Users where MarkForDeletion = 1)

delete from LibraryItems
where DataSourceOwnerUserID in (Select UserID from Users where MarkForDeletion = 1)

delete from QuickRefItems
where DataSourceOwnerUserID in (Select UserID from Users where MarkForDeletion = 1)

delete from SourceAttribute
where DataSourceOwnerUserID in (Select UserID from Users where MarkForDeletion = 1)

delete from ZippedFiles
where DataSourceOwnerUserID in (Select UserID from Users where MarkForDeletion = 1)


--Users
