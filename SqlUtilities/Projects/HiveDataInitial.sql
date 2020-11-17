INSERT [dbo].[HIVERepo] ([ConnectionName], [ServerName], [ActiveRepository], [EncryptedConnectionString], [RepoLicense], [MachineName], [DbmsCode], [RepositoryGuid]) VALUES (N'DELLT100_ECMLIB', N'DELLT100\ECMLIB', 0, N'bNk5A9GOZlbuBHC2plcGjcoJ3WQJrj8WJ1Shx8FfBYP0abvO/1DEAaug33+vNa8h61E87Z4KproaGFjKsjgGp4Yi6KcKonej8qffXYA6dTPjE94y4oskTB4PbP8vC52psZ9gsAjZx60F2UD4vRie2xG6paLJ4MHM', N'', N'DELLT100', N'SS2005', N'9223f2cd-cac6-41f4-a672-1bb12b6c30cb')
INSERT [dbo].[HIVERepo] ([ConnectionName], [ServerName], [ActiveRepository], [EncryptedConnectionString], [RepoLicense], [MachineName], [DbmsCode], [RepositoryGuid]) VALUES (N'HP8GB_ECMLIBRARY', N'HP8GB\ECMLIBRARY', 0, N'bNk5A9GOZlafYUQHEx+oYCKJ6XBnt3yJC7PS55e0aqO5NK9fnYucmCIaZ00UidzY8zwbJAm45gFkk7kj3gDsKzGhvae2UDjMXlXzaj/WZwTVvOaHu18GJrSx9Iu4Rg6QQ2KI19KHuRp0ak+Tby5Y4RpFx+dmIYdN/EXpqNcFHTE=', N'', N'HP8GB', N'SS2005', N'509f322f-6224-45b1-a333-482159efb164')
INSERT [dbo].[HIVERepo] ([ConnectionName], [ServerName], [ActiveRepository], [EncryptedConnectionString], [RepoLicense], [MachineName], [DbmsCode], [RepositoryGuid]) VALUES (N'VIRTSVR_ECMLIB', N'VIRTSVR\ECMLIB', 0, N'bNk5A9GOZlbvMsArlANWdJSIxSOu4ExdIuci93efyZpcimqJ3xDDGbnVPaVD0eJKQ2KI19KHuRpK3nsLP/i6+9MnMFge47PenBjGQu56tIS0eKrmipVR+VZkOCr9tXqmruny6El9QvS9DwZ/hFyijlAO+xer0lcA', N'', N'VIRTSVR', N'SS2005', N'56545779-de93-45a7-b47a-8d16773568c2')
go
INSERT [dbo].[HIVEUsers] ([UserLoginID], [EmailAddress], [AuthCode], [UserPassword], [Admin], [ClientOnly], [UserID]) VALUES (N'wmiller', N'dale@EcmLibrary.com', N'SA', N'GkXH52Yhh038Remo1wUdMQ==', N'S', 0, N'1872B2A8-9FAC-48E9-8B10-07D0408A19FE')
INSERT [dbo].[HIVEUsers] ([UserLoginID], [EmailAddress], [AuthCode], [UserPassword], [Admin], [ClientOnly], [UserID]) VALUES (N'smiller', N'susan@EcmLibrary.com', N'Admin', N'GkXH52Yhh038Remo1wUdMQ==', N'A', 0, N'4c5c0fba-b2ea-445d-b25f-f713be28162b')
INSERT [dbo].[HIVEUsers] ([UserLoginID], [EmailAddress], [AuthCode], [UserPassword], [Admin], [ClientOnly], [UserID]) VALUES (N'LGarnand', N'liz@EcmLibrary.com', N'User', N'GkXH52Yhh038Remo1wUdMQ==', N'U', 0, N'9e59196b-c872-4f69-a052-e457a8ef7d56')
INSERT [dbo].[HIVEUsers] ([UserLoginID], [EmailAddress], [AuthCode], [UserPassword], [Admin], [ClientOnly], [UserID]) VALUES (N'frank', N'frank@EcmLibrary.com', N'User', N'GkXH52Yhh038Remo1wUdMQ==', N'U', 0, N'8e7e1d37-c1b6-4eb8-8ede-a8aa1de61f01')
INSERT [dbo].[HIVEUsers] ([UserLoginID], [EmailAddress], [AuthCode], [UserPassword], [Admin], [ClientOnly], [UserID]) VALUES (N'bmiller', N'ben@EcmLibrary.com', N'Global', N'GkXH52Yhh038Remo1wUdMQ==', N'G', 0, N'646937f5-a1e1-4fbb-b1de-16633ad5d282')
INSERT [dbo].[HIVEUsers] ([UserLoginID], [EmailAddress], [AuthCode], [UserPassword], [Admin], [ClientOnly], [UserID]) VALUES (N'cr', N'cr@EcmLibrary.com', N'User', N'GkXH52Yhh038Remo1wUdMQ==', N'U', 0, N'8f293968-daa5-459e-9489-5d11d06c92a5')
INSERT [dbo].[HIVEUsers] ([UserLoginID], [EmailAddress], [AuthCode], [UserPassword], [Admin], [ClientOnly], [UserID]) VALUES (N'joe', N'joe@EcmLibrary.com', N'User', N'GkXH52Yhh038Remo1wUdMQ==', N'U', 1, N'21ccd868-7013-4e6c-80b1-9fcad8dd741c')

go
INSERT [dbo].[HIVEAuth] ([AuthCode], [Description]) VALUES (N'Admin', N'System Administrator')
INSERT [dbo].[HIVEAuth] ([AuthCode], [Description]) VALUES (N'Global', N'Global Searcher')
INSERT [dbo].[HIVEAuth] ([AuthCode], [Description]) VALUES (N'SA', N'Super Administrator')
INSERT [dbo].[HIVEAuth] ([AuthCode], [Description]) VALUES (N'User', N'Standard User')
go
INSERT [dbo].[HIVEProfileItem] ([ItemCode], [description]) VALUES (N'debug_clsArchive', N'description needed')
INSERT [dbo].[HIVEProfileItem] ([ItemCode], [description]) VALUES (N'debug_ClsDatabase', N'description needed')
INSERT [dbo].[HIVEProfileItem] ([ItemCode], [description]) VALUES (N'debug_clsEmailFunc', N'description needed')
INSERT [dbo].[HIVEProfileItem] ([ItemCode], [description]) VALUES (N'debug_clsSpider', N'description needed')
INSERT [dbo].[HIVEProfileItem] ([ItemCode], [description]) VALUES (N'debug_clsSql', N'description needed')
INSERT [dbo].[HIVEProfileItem] ([ItemCode], [description]) VALUES (N'debug_SetupScreen', N'description needed')
INSERT [dbo].[HIVEProfileItem] ([ItemCode], [description]) VALUES (N'user_EmailFolder1', N'description needed')
INSERT [dbo].[HIVEProfileItem] ([ItemCode], [description]) VALUES (N'user_PageReturn', N'description needed')
INSERT [dbo].[HIVEProfileItem] ([ItemCode], [description]) VALUES (N'user_RunUnattended', N'description needed')
go
INSERT [dbo].[HiveDBMS] ([DbmsCode], [DbmsDescription]) VALUES (N'SS2005', N'SQL Server version 2005')
INSERT [dbo].[HiveDBMS] ([DbmsCode], [DbmsDescription]) VALUES (N'SS2008', N'SQL Server version 2008')
go
INSERT [dbo].[HIVEDatatypeCode] ([DatatypeCode], [description]) VALUES (N'Numeric', N'defines a number')
INSERT [dbo].[HIVEDatatypeCode] ([DatatypeCode], [description]) VALUES (N'String', N'defines a string (alpha/numeric)')
INSERT [dbo].[HIVEDatatypeCode] ([DatatypeCode], [description]) VALUES (N'date', N'defines a date field')
INSERT [dbo].[HIVEDatatypeCode] ([DatatypeCode], [description]) VALUES (N'Boolean', N'defines a True/false')
INSERT [dbo].[HIVEDatatypeCode] ([DatatypeCode], [description]) VALUES (N'char1', N'defines a Y/N')
go
INSERT [dbo].[HiveController] ([HiveName], [MachineName], [InternalHiveID], [EntryDate], [LastModDate], [HiveGuid]) VALUES (N'Dmachicago', N'HP8GB\ECMLIBRARY', N'HIVE01', CAST(0x00009D8801436DA4 AS DateTime), CAST(0x00009D8801436DA4 AS DateTime), N'1152cdea-2e93-49e8-aecb-2894f7c71cc2')

go
INSERT [dbo].[HIVERepoStats] ([RepositoryGuid], [SizeOfEmailsGB], [SizeOfEmailAttachmentsGB], [SizeOfDocsGB], [NbrOfEmails], [NbrOfEmailAttachments], [NbrOfDocs], [CurrentSizeTB], [CutOffSizeTB]) VALUES (N'9223f2cd-cac6-41f4-a672-1bb12b6c30cb', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 81763, 10)
INSERT [dbo].[HIVERepoStats] ([RepositoryGuid], [SizeOfEmailsGB], [SizeOfEmailAttachmentsGB], [SizeOfDocsGB], [NbrOfEmails], [NbrOfEmailAttachments], [NbrOfDocs], [CurrentSizeTB], [CutOffSizeTB]) VALUES (N'509f322f-6224-45b1-a333-482159efb164', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 7908, 10)
INSERT [dbo].[HIVERepoStats] ([RepositoryGuid], [SizeOfEmailsGB], [SizeOfEmailAttachmentsGB], [SizeOfDocsGB], [NbrOfEmails], [NbrOfEmailAttachments], [NbrOfDocs], [CurrentSizeTB], [CutOffSizeTB]) VALUES (N'56545779-de93-45a7-b47a-8d16773568c2', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 0, 10)
go