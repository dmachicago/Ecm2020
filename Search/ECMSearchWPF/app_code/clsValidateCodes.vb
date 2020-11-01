Public Class clsValidateCodes

    Dim LOG As New clsLogging
    Dim UTIL As New clsUtility

    Public Sub LoadAll(ByVal UserGuidID As String)
        valSystemParmsCodes()
        valAvailFileTypes()
        valAttachmentType()
        valSourceType()
        valProfileItems()
        valLoadProfile()
        AddUserSelectableParameters(UserGuidID)
        AddImageCodes()
        VerifyLookupData()
    End Sub

    Public Sub valSystemParmsCodes()
        Dim SysParm$ = ""
        Dim InsertSql$ = ""

        InsertSql$ = "INSERT [dbo].[SystemParms] ([SysParm], [SysParmDesc], [SysParmVal], [flgActive], [isDirectory], [isEmailFolder], [flgAllSubDirs]) VALUES ('MaxUrlsToProcess', 'The number of levels to penetrate in a web site.', '2', NULL, NULL, NULL, NULL)"
        SystemParmsCodesExist("MaxUrlsToProcess", InsertSql$)

        InsertSql$ = "INSERT [dbo].[SystemParms] ([SysParm], [SysParmDesc], [SysParmVal], [flgActive], [isDirectory], [isEmailFolder], [flgAllSubDirs]) VALUES ('RequireUserAuthentication', 'This determines whether the USERID ir the MACHINE ID will authenticate (Y or N).', '2', 'Y', NULL, NULL, NULL)"
        SystemParmsCodesExist("MaxUrlsToProcess", InsertSql$)

        InsertSql = "INSERT [dbo].[SystemParms] ([SysParm], [SysParmDesc], [SysParmVal], [flgActive], [isDirectory], [isEmailFolder], [flgAllSubDirs]) VALUES ('Default Thesaurus', 'This is the thesaurus that will be used when a specific thesaurus is not specified.', 'Roget', NULL, NULL, NULL, NULL)"
        SystemParmsCodesExist("Default Thesaurus", InsertSql)

        InsertSql = "INSERT [dbo].[SystemParms] ([SysParm], [SysParmDesc], [SysParmVal], [flgActive], [isDirectory], [isEmailFolder], [flgAllSubDirs]) VALUES ('RETENTION YEARS', 'The default number years to retain content.', '10', 'N', NULL, NULL, NULL)"
        SystemParmsCodesExist("RETENTION YEARS", InsertSql)

        InsertSql = "INSERT [dbo].[SystemParms] ([SysParm], [SysParmDesc], [SysParmVal], [flgActive], [isDirectory], [isEmailFolder], [flgAllSubDirs]) VALUES ('EmailFolder1', 'This is the Top Level folder name and is required. It can be overridden for an individual user using the APP.CONFIG file, entry name EmailFolder1', 'Personal Folders', 'Y', NULL, NULL, NULL)"
        SystemParmsCodesExist("EmailFolder1", InsertSql)

        InsertSql = "INSERT [dbo].[SystemParms] ([SysParm], [SysParmDesc], [SysParmVal], [flgActive], [isDirectory], [isEmailFolder], [flgAllSubDirs]) VALUES ('SharePointVirtualLimit', 'When there are less records than this number, then a linked list is used for PURE speed.', '100001', 'Y', NULL, NULL, NULL)"
        SystemParmsCodesExist("SharePointVirtualLimit", InsertSql)

        InsertSql = "INSERT [dbo].[SystemParms] ([SysParm], [SysParmDesc], [SysParmVal], [flgActive], [isDirectory], [isEmailFolder], [flgAllSubDirs]) VALUES ('SharePointECMVirtualLimit', 'When there are less records than this number, then a linked list is used for PURE speed.', '1000001', 'Y', NULL, NULL, NULL)"
        SystemParmsCodesExist("SharePointECMVirtualLimit", InsertSql)

        InsertSql = "INSERT [dbo].[SystemParms] ([SysParm], [SysParmDesc], [SysParmVal], [flgActive], [isDirectory], [isEmailFolder], [flgAllSubDirs]) VALUES ('srv_disable', 'When set to anything other than 0 the ECM Service will continue to run but will NOT archive.', '0', 'Y', NULL, NULL, NULL)"
        SystemParmsCodesExist("srv_disable", InsertSql)

        InsertSql = "INSERT [dbo].[SystemParms] ([SysParm], [SysParmDesc], [SysParmVal], [flgActive], [isDirectory], [isEmailFolder], [flgAllSubDirs]) VALUES ('srv_PollingInterval', 'This is the number of MINUTES between executing an archive.', '60', 'Y', NULL, NULL, NULL)"
        SystemParmsCodesExist("srv_PollingInterval", InsertSql)

        InsertSql = "INSERT [dbo].[SystemParms] ([SysParm], [SysParmDesc], [SysParmVal], [flgActive], [isDirectory], [isEmailFolder], [flgAllSubDirs]) VALUES ('srv_ArchiveNow', 'Set value to 1 in order to force an archive next interval.', '0', 'Y', NULL, NULL, NULL)"
        SystemParmsCodesExist("srv_ArchiveNow", InsertSql)

        InsertSql = "INSERT [dbo].[SystemParms] ([SysParm], [SysParmDesc], [SysParmVal], [flgActive], [isDirectory], [isEmailFolder], [flgAllSubDirs]) VALUES ('srv_LastArchive', 'This is the datetime of the last completed archive.', '10/22/2009 7:58:57 PM', 'Y', NULL, NULL, NULL)"
        SystemParmsCodesExist("srv_LastArchive", InsertSql)

        InsertSql = "INSERT [dbo].[SystemParms] ([SysParm], [SysParmDesc], [SysParmVal], [flgActive], [isDirectory], [isEmailFolder], [flgAllSubDirs]) VALUES ('MaxSearchesToTrack', 'The number of searches the user has in their immediate history.', '25', NULL, NULL, NULL, NULL)"
        SystemParmsCodesExist("MaxSearchesToTrack", InsertSql)

        InsertSql = "INSERT [dbo].[SystemParms] ([SysParm], [SysParmDesc], [SysParmVal], [flgActive], [isDirectory], [isEmailFolder], [flgAllSubDirs]) VALUES ('SqlServerTimeout', 'This is the value that will be assigned to the SQL Server timeout for users that do not have a specific timeout established.', '90', NULL, NULL, NULL, NULL)"
        SystemParmsCodesExist("SqlServerTimeout", InsertSql)

        InsertSql = "INSERT [dbo].[SystemParms] ([SysParm], [SysParmDesc], [SysParmVal], [flgActive], [isDirectory], [isEmailFolder], [flgAllSubDirs]) VALUES ('srv_shutdown', 'When set to 1, the service (next poll) will stop running.', '0', 'Y', NULL, NULL, NULL)"
        SystemParmsCodesExist("srv_shutdown", InsertSql)

        InsertSql = "INSERT [dbo].[SystemParms] ([SysParm], [SysParmDesc], [SysParmVal], [flgActive], [isDirectory], [isEmailFolder], [flgAllSubDirs]) VALUES ('SYS_SingleInstance', 'When set to 1, ECM will store just 1 copy of an archive.', '1', NULL, NULL, NULL, NULL)"
        SystemParmsCodesExist("SYS_SingleInstance", InsertSql)

        InsertSql = "INSERT [dbo].[SystemParms] ([SysParm], [SysParmDesc], [SysParmVal], [flgActive], [isDirectory], [isEmailFolder], [flgAllSubDirs]) VALUES ('SYS_HiveEnabled', 'When set to Y, the defined HIVE will be available for search.', 'N', NULL, NULL, NULL, NULL)"
        SystemParmsCodesExist("SYS_HiveEnabled", InsertSql)

        InsertSql = "INSERT [dbo].[SystemParms] ([SysParm], [SysParmDesc], [SysParmVal], [flgActive], [isDirectory], [isEmailFolder], [flgAllSubDirs]) VALUES ('SYS_EcmPDFX', 'When set to 1, ECM will attempt to extract all images and strings from within PDF files containing embedded graphics as well as normal search indexing.', '1', NULL, NULL, NULL, NULL)"
        SystemParmsCodesExist("SYS_EcmPDFX", InsertSql)

        'InsertSql = "INSERT [dbo].[SystemParms] ([SysParm], [SysParmDesc], [SysParmVal], [flgActive], [isDirectory], [isEmailFolder], [flgAllSubDirs]) VALUES ('SYS_EcmPDFdir', 'Set this as the temporary PDF/Graphics processing directory. NO SPACES ALLOWED IN NAME.', 'C:\TEMP\PdfProcessing\', NULL, NULL, NULL, NULL)"
        'SystemParmsCodesExist("SYS_EcmPDFdir", InsertSql)

        '******************************************************************
        InsertSql = "INSERT [dbo].[SystemParms] ([SysParm], [SysParmDesc], [SysParmVal], [flgActive], [isDirectory], [isEmailFolder], [flgAllSubDirs]) VALUES ('SYS_MandateUserLogin', 'MandateUserLogin MUST BE SET TO TRUE OR FALSE. If MandateUserLogin is true, then roaming profiles are in place. Else, no roaming profiles and the MACHINE must be registerd in order to log on to the system.', 'False', NULL, NULL, NULL, NULL)"
        SystemParmsCodesExist("SYS_MandateUserLogin", InsertSql)

        InsertSql = "INSERT [dbo].[SystemParms] ([SysParm], [SysParmDesc], [SysParmVal], [flgActive], [isDirectory], [isEmailFolder], [flgAllSubDirs]) VALUES ('SYS_MandateSeatLogin', 'MandateSeatLogin MUST BE SET TO TRUE OR FALSE.', 'xx', NULL, NULL, NULL, NULL)"
        SystemParmsCodesExist("SYS_MandateSeatLogin", InsertSql)

        InsertSql = "INSERT [dbo].[SystemParms] ([SysParm], [SysParmDesc], [SysParmVal], [flgActive], [isDirectory], [isEmailFolder], [flgAllSubDirs]) VALUES ('SYS_AutoRegisterUser', 'When set true, authentication will be automatic adn entered into the DB.', 'xx', NULL, NULL, NULL, NULL)"
        SystemParmsCodesExist("SYS_AutoRegisterUser", InsertSql)

        InsertSql = "INSERT [dbo].[SystemParms] ([SysParm], [SysParmDesc], [SysParmVal], [flgActive], [isDirectory], [isEmailFolder], [flgAllSubDirs]) VALUES ('SYS_AutoRegisterMachine', 'When set to true, authentication will be done automatically. A machine will automatically be entered into the system if a seat is available. Otherwise, the machine will have to be pre-registered by an admin before login can be completed.', 'xx', NULL, NULL, NULL, NULL)"
        SystemParmsCodesExist("SYS_AutoRegisterMachine", InsertSql)

        InsertSql = "INSERT [dbo].[SystemParms] ([SysParm], [SysParmDesc], [SysParmVal], [flgActive], [isDirectory], [isEmailFolder], [flgAllSubDirs]) VALUES ('SYS_AllowPublic', 'When set to Y, users can set their searchable content to public. Otherwise, all content is defaulted to private..', 'Y', NULL, NULL, NULL, NULL)"
        SystemParmsCodesExist("SYS_AllowPublic", InsertSql)

        InsertSql = "INSERT [dbo].[SystemParms] ([SysParm], [SysParmDesc], [SysParmVal], [flgActive], [isDirectory], [isEmailFolder], [flgAllSubDirs]) VALUES ('SYS_MaxFileSize', 'When set to 0, unlimited file upload size. Otherwise, any value sets the max upload size.', '0', NULL, NULL, NULL, NULL)"
        SystemParmsCodesExist("SYS_MaxFileSize", InsertSql)

        'InsertSql = "INSERT [dbo].[SystemParms] ([SysParm], [SysParmDesc], [SysParmVal], [flgActive], [isDirectory], [isEmailFolder], [flgAllSubDirs]) VALUES ('SYS_MaxFileSize', 'When set to 0, unlimited file upload size. Otherwise, any value sets the max upload size.', '0', NULL, NULL, NULL, NULL)"
        'SystemParmsCodesExist("SYS_MaxFileSize", InsertSql)

        InsertSql = "INSERT [dbo].[SystemParms] ([SysParm], [SysParmDesc], [SysParmVal], [flgActive], [isDirectory], [isEmailFolder], [flgAllSubDirs]) VALUES ('SYS_PageReturn', 'When set to 0, the maximum number of rows returned will be unlimited.', '0', NULL, NULL, NULL, NULL)"
        SystemParmsCodesExist("SYS_PageReturn", InsertSql)

        InsertSql = "INSERT [dbo].[SystemParms] ([SysParm], [SysParmDesc], [SysParmVal], [flgActive], [isDirectory], [isEmailFolder], [flgAllSubDirs]) VALUES ('SYS_PageReturnRowLimit', 'Sets the number of rows that will be returned and displayed on a page. Millions of can be returned quickly this way.', '100', NULL, NULL, NULL, NULL)"
        SystemParmsCodesExist("SYS_PageReturnRowLimit", InsertSql)

        InsertSql = "INSERT [dbo].[SystemParms] ([SysParm], [SysParmDesc], [SysParmVal], [flgActive], [isDirectory], [isEmailFolder], [flgAllSubDirs]) VALUES ('SYS_SyncAllAdUsers', 'Set to 1 to to ADD all existing users. Set to 0 for Selected Users only.', '0', NULL, NULL, NULL, NULL)"
        SystemParmsCodesExist("SYS_SyncAllAdUsers", InsertSql)

        InsertSql = "INSERT [dbo].[SystemParms] ([SysParm], [SysParmDesc], [SysParmVal], [flgActive], [isDirectory], [isEmailFolder], [flgAllSubDirs]) VALUES ('SYS_SyncRemoveMissingUser', 'Set to 1 to to remove a user not found in the target list. Only users with NO content attached to their name can be removed. All others marked inactive.', '0', NULL, NULL, NULL, NULL)"
        SystemParmsCodesExist("SYS_SyncRemoveMissingUser", InsertSql)

    End Sub
    Function SystemParmsCodesExist(ByVal SysParm$, ByVal InsertSql$) As Boolean
        ExecuteSQL(InsertSql)
    End Function

    Sub valAvailFileTypes()

        Dim InsertSql$ = ""

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('*')"
        Me.AvailFileTypesExist("*", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.dct')"
        AvailFileTypesExist(".dct", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.act')"
        AvailFileTypesExist(".act", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.ascx')"
        AvailFileTypesExist(".ascx", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.asm')"
        AvailFileTypesExist(".asm", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.asp')"
        AvailFileTypesExist(".asp", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.aspx')"
        AvailFileTypesExist(".aspx", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.bat')"
        AvailFileTypesExist(".bat", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.bmp')"
        AvailFileTypesExist(".bmp", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.c')"
        AvailFileTypesExist(".c", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.cmd')"
        AvailFileTypesExist(".cmd", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.cpp')"
        AvailFileTypesExist(".cpp", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.cxx')"
        AvailFileTypesExist(".cxx", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.dct')"
        AvailFileTypesExist(".dct", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.def')"
        AvailFileTypesExist(".def", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.dic')"
        AvailFileTypesExist(".dic", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.dll')"
        AvailFileTypesExist(".dll", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.doc')"
        AvailFileTypesExist(".doc", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.docx')"
        AvailFileTypesExist(".docx", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.dot')"
        AvailFileTypesExist(".dot", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.exe')"
        AvailFileTypesExist(".exe", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.frm')"
        AvailFileTypesExist(".frm", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.GIF')"
        AvailFileTypesExist(".GIF", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.gz')"
        AvailFileTypesExist(".gz", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.h')"
        AvailFileTypesExist(".h", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.hhc')"
        AvailFileTypesExist(".hhc", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.hpp')"
        AvailFileTypesExist(".hpp", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.htm')"
        AvailFileTypesExist(".htm", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.html')"
        AvailFileTypesExist(".html", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.htw')"
        AvailFileTypesExist(".htw", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.htx')"
        AvailFileTypesExist(".htx", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.hxx')"
        AvailFileTypesExist(".hxx", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.ibq')"
        AvailFileTypesExist(".ibq", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.idl')"
        AvailFileTypesExist(".idl", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.inc')"
        AvailFileTypesExist(".inc", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.inf')"
        AvailFileTypesExist(".inf", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.ini')"
        AvailFileTypesExist(".ini", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.inx')"
        AvailFileTypesExist(".inx", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.java')"
        AvailFileTypesExist(".java", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.JPG')"
        AvailFileTypesExist(".JPG", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.JPX')"
        AvailFileTypesExist(".JPX", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.js')"
        AvailFileTypesExist(".js", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.log')"
        AvailFileTypesExist(".log", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.m3u')"
        AvailFileTypesExist(".m3u", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.mht')"
        AvailFileTypesExist(".mht", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.mp3')"
        AvailFileTypesExist(".mp3", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.msg')"
        AvailFileTypesExist(".msg", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.obd')"
        AvailFileTypesExist(".obd", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.obj')"
        AvailFileTypesExist(".obj", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.obt')"
        AvailFileTypesExist(".obt", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.odc')"
        AvailFileTypesExist(".odc", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.pdf')"
        AvailFileTypesExist(".pdf", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.pl')"
        AvailFileTypesExist(".pl", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.PNG')"
        AvailFileTypesExist(".PNG", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.pot')"
        AvailFileTypesExist(".pot", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.ppt')"
        AvailFileTypesExist(".ppt", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.rc')"
        AvailFileTypesExist(".rc", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.reg')"
        AvailFileTypesExist(".reg", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.resx')"
        AvailFileTypesExist(".resx", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.rtf')"
        AvailFileTypesExist(".rtf", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.sln')"
        AvailFileTypesExist(".sln", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.sql')"
        AvailFileTypesExist(".sql", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.stm')"
        AvailFileTypesExist(".stm", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.suo')"
        AvailFileTypesExist(".suo", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.tar')"
        AvailFileTypesExist(".tar", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.tif')"
        AvailFileTypesExist(".tif", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.TIFF')"
        AvailFileTypesExist(".TIFF", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.txt')"
        AvailFileTypesExist(".txt", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.UKN')"
        AvailFileTypesExist(".UKN", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.url')"
        AvailFileTypesExist(".url", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.vb')"
        AvailFileTypesExist(".vb", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.vbs')"
        AvailFileTypesExist(".vbs", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.VSD')"
        AvailFileTypesExist(".VSD", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.wav')"
        AvailFileTypesExist(".wav", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.wma')"
        AvailFileTypesExist(".wma", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.wtx')"
        AvailFileTypesExist(".wtx", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.XL*')"
        AvailFileTypesExist(".XL*", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.xlb')"
        AvailFileTypesExist(".xlb", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.xlc')"
        AvailFileTypesExist(".xlc", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.xls')"
        AvailFileTypesExist(".xls", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.xlsx')"
        AvailFileTypesExist(".xlsx", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.xlt')"
        AvailFileTypesExist(".xlt", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.xml')"
        AvailFileTypesExist(".xml", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.xsc')"
        AvailFileTypesExist(".xsc", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.xsd')"
        AvailFileTypesExist(".xsd", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.xslt')"
        AvailFileTypesExist(".xslt", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.xss')"
        AvailFileTypesExist(".xss", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.z')"
        AvailFileTypesExist(".z", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.zip')"
        AvailFileTypesExist(".zip", InsertSql)

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('msg')"
        AvailFileTypesExist("msg", InsertSql)

        '*****************************************************************

        'docx - Word 2007 XML Document
        InsertSql = "Insert AvailFileTypes (ExtCode) Values ('.docx')"
        AvailFileTypesExist(".docx", InsertSql)

        'docm - Word 2007 XML Macro-Enabled Document
        InsertSql = "Insert AvailFileTypes (ExtCode) Values ('.docm')"
        AvailFileTypesExist(".docm", InsertSql)

        'dotx - Word 2007 XML Template
        InsertSql = "Insert AvailFileTypes (ExtCode) Values ('.dotx')"
        AvailFileTypesExist(".dotx", InsertSql)

        'dotm - Word 2007 XML Macro-Enabled Template
        InsertSql = "Insert AvailFileTypes (ExtCode) Values ('.dotm')"
        AvailFileTypesExist(".dotm", InsertSql)

        'xlsx - Excel 2007 XML Workbook
        InsertSql = "Insert AvailFileTypes (ExtCode) Values ('.xlsx')"
        AvailFileTypesExist(".xlsx", InsertSql)

        'xlsm - Excel 2007 XML Macro-Enabled Workbook
        InsertSql = "Insert AvailFileTypes (ExtCode) Values ('.xlsm')"
        AvailFileTypesExist(".xlsm", InsertSql)

        'xltx - Excel 2007 XML Template
        InsertSql = "Insert AvailFileTypes (ExtCode) Values ('.xltx')"
        AvailFileTypesExist(".xltx", InsertSql)

        'xltm - Excel 2007 XML Macro-Enabled Template
        InsertSql = "Insert AvailFileTypes (ExtCode) Values ('.xltm')"
        AvailFileTypesExist(".xltm", InsertSql)

        'xlsb - Excel 2007 binary workbook (BIFF12)
        InsertSql = "Insert AvailFileTypes (ExtCode) Values ('.xlsb')"
        AvailFileTypesExist("MSG", InsertSql)

        'xlam - Excel 2007 XML Macro-Enabled Add-In
        InsertSql = "Insert AvailFileTypes (ExtCode) Values ('.xlam')"
        AvailFileTypesExist(".xlam", InsertSql)

        'pptx - PowerPoint 2007 XML Presentation
        InsertSql = "Insert AvailFileTypes (ExtCode) Values ('.pptx')"
        AvailFileTypesExist(".pptx", InsertSql)

        'pptm - PowerPoint 2007 Macro-Enabled XML Presentation
        InsertSql = "Insert AvailFileTypes (ExtCode) Values ('.pptm')"
        AvailFileTypesExist(".pptm", InsertSql)

        'potx - PowerPoint 2007 XML Template
        InsertSql = "Insert AvailFileTypes (ExtCode) Values ('.potx')"
        AvailFileTypesExist(".potx", InsertSql)

        'potm - PowerPoint 2007 Macro-Enabled XML Template
        InsertSql = "Insert AvailFileTypes (ExtCode) Values ('.potm')"
        AvailFileTypesExist(".potm", InsertSql)

        'ppam - PowerPoint 2007 Macro-Enabled XML Add-In
        InsertSql = "Insert AvailFileTypes (ExtCode) Values ('.ppam')"
        AvailFileTypesExist(".ppam", InsertSql)

        'ppsx - PowerPoint 2007 XML Show
        InsertSql = "Insert AvailFileTypes (ExtCode) Values ('.ppsx')"
        AvailFileTypesExist(".ppsx", InsertSql)

        'ppsm - PowerPoint 2007 Macro-Enabled XML Show
        InsertSql = "Insert AvailFileTypes (ExtCode) Values ('.ppsm')"
        AvailFileTypesExist(".ppsm", InsertSql)



    End Sub
    Function AvailFileTypesExist(ByVal ExtCode$, ByVal InsertSql$) As Boolean
        ExecuteSQL(InsertSql)
    End Function

    Public Sub valAttachmentType()
        Dim SysParm$ = ""
        Dim InsertSql$ = ""

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.0', 'Hacha Split Archive File', 1)"
        AttachmentTypeExist(".0", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.000', 'DoubleSpace Compressed File', 1)"
        AttachmentTypeExist(".000", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.001', 'Auto added this code.', 0)"
        AttachmentTypeExist(".001", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.7z', '7-Zip Compressed File', 1)"
        AttachmentTypeExist(".7z", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.ace', 'WinAce Compressed File (Edited)', 1)"
        AttachmentTypeExist(".ace", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.ain', 'AIN Compressed File Archive', 1)"
        AttachmentTypeExist(".ain", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.alz', 'ALZip Archive', 1)"
        AttachmentTypeExist(".alz", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.apz', 'Autoplay Media Studio Exported Project', 1)"
        AttachmentTypeExist(".apz", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.ar', 'Unix Static Library', 1)"
        AttachmentTypeExist(".ar", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.arc', 'Compressed File Archive', 1)"
        AttachmentTypeExist(".arc", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.ari', 'ARI Compressed File Archive', 1)"
        AttachmentTypeExist(".ari", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.arj', 'ARJ Compressed File Archive', 1)"
        AttachmentTypeExist(".arj", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.ascx', '', 0)"
        AttachmentTypeExist(".ascx", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.asm', '', 0)"
        AttachmentTypeExist(".asm", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.asp', '', 0)"
        AttachmentTypeExist(".asp", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.aspx', '', 0)"
        AttachmentTypeExist(".aspx", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.aspx_userid=2126', 'Auto added this code.', 0)"
        AttachmentTypeExist(".aspx_userid=2126", InsertSql)

        InsertSql = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.au', 'Auto added this code.', 0)"
        AttachmentTypeExist(".au", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.axx', 'AxCrypt Encrypted File', 1)"
        AttachmentTypeExist(".axx", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.b64', 'Base64 MIME-Encoded File', 1)"
        AttachmentTypeExist(".b64", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.ba', 'Scifer External Header Archive', 1)"
        AttachmentTypeExist(".ba", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.bat', '', 0)"
        AttachmentTypeExist(".bat", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.bh', 'BlakHole Archive', 1)"
        AttachmentTypeExist(".bh", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.bmp', 'Auto added this code.', 0)"
        AttachmentTypeExist(".bmp", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.boo', 'Booasm Compressed Archive', 1)"
        AttachmentTypeExist(".boo", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.bz', 'Bzip Compressed File', 1)"
        AttachmentTypeExist(".bz", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.bz2', 'Bzip2 Compressed File', 1)"
        AttachmentTypeExist(".bz2", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.bzip', 'Bzip Compressed Archive', 1)"
        AttachmentTypeExist(".bzip", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.bzip2', 'Bzip2 Compressed Archive', 1)"
        AttachmentTypeExist(".bzip2", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.c', '', 0)"
        AttachmentTypeExist(".c", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.c00', 'WinAce Split Archive File', 1)"
        AttachmentTypeExist(".c00", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.c01', 'WinAce Split Archive Part 1 File', 1)"
        AttachmentTypeExist(".c01", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.c02', 'WinAce Split Archive Part 1 File', 1)"
        AttachmentTypeExist(".c02", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.car', 'CAR Archive', 1)"
        AttachmentTypeExist(".car", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.cbr', 'Comic Book RAR Archive', 1)"
        AttachmentTypeExist(".cbr", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.cbz', 'Comic Book ZIP Archive', 1)"
        AttachmentTypeExist(".cbz", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.cmd', '', 0)"
        AttachmentTypeExist(".cmd", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.cp9', 'ChoicePoint Encrypted File', 1)"
        AttachmentTypeExist(".cp9", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.cpgz', 'Compressed CPIO Archive', 1)"
        AttachmentTypeExist(".cpgz", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.cpp', '', 0)"
        AttachmentTypeExist(".cpp", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.cpt', 'Compact Pro Archive', 1)"
        AttachmentTypeExist(".cpt", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.crt', 'Auto added this code.', 0)"
        AttachmentTypeExist(".crt", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.csv', 'Auto added this code.', 0)"
        AttachmentTypeExist(".csv", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.cxx', '', 0)"
        AttachmentTypeExist(".cxx", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.dar', 'DAR Disk Archive', 1)"
        AttachmentTypeExist(".dar", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.dat', 'Auto added this code.', 0)"
        AttachmentTypeExist(".dat", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.dd', 'DiskDouber Archive', 1)"
        AttachmentTypeExist(".dd", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.deb', 'Debian Software Package', 1)"
        AttachmentTypeExist(".deb", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.def', '', 0)"
        AttachmentTypeExist(".def", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.dgc', 'DGCA File Archive', 1)"
        AttachmentTypeExist(".dgc", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.dic', '', 0)"
        AttachmentTypeExist(".dic", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.dist', 'Mac OS X Distribution Script', 1)"
        AttachmentTypeExist(".dist", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.DM1', 'Auto added this code.', 0)"
        AttachmentTypeExist(".DM1", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.doc', '', 0)"
        AttachmentTypeExist(".doc", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.docx', '', 0)"
        AttachmentTypeExist(".docx", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.dot', '', 0)"
        AttachmentTypeExist(".dot", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.dts', 'Auto added this code.', 0)"
        AttachmentTypeExist(".dts", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.dtsx', 'Auto added this code.', 0)"
        AttachmentTypeExist(".dtsx", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.ecs', 'Sony Ericsson Phone Backup File', 1)"
        AttachmentTypeExist(".ecs", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.efw', 'Renamed Zip or Executable File', 1)"
        AttachmentTypeExist(".efw", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.emz', 'Auto added this code.', 0)"
        AttachmentTypeExist(".emz", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.exe', 'Auto added this code.', 0)"
        AttachmentTypeExist(".exe", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.f', 'Freeze Compressed File', 1)"
        AttachmentTypeExist(".f", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.fdp', 'MySafe Encrypted Data', 1)"
        AttachmentTypeExist(".fdp", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.gca', 'GCA File Archive', 1)"
        AttachmentTypeExist(".gca", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.gif', 'Auto added this code.', 0)"
        AttachmentTypeExist(".gif", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.GRV', 'Auto added this code.', 0)"
        AttachmentTypeExist(".GRV", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.gz', 'Gnu Zipped File', 1)"
        AttachmentTypeExist(".gz", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.gzi', 'Unix Gzip File', 1)"
        AttachmentTypeExist(".gzi", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.gzip', 'Gnu Zipped File', 1)"
        AttachmentTypeExist(".gzip", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.h', '', 0)"
        AttachmentTypeExist(".h", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.ha', 'HA Compressed Archive', 1)"
        AttachmentTypeExist(".ha", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.hbc', 'HyperBac Compressed Archive', 1)"
        AttachmentTypeExist(".hbc", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.hbc2', 'HyperBac Compressed File Archive', 1)"
        AttachmentTypeExist(".hbc2", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.hbe', 'HyperBac Compressed and Encrypted Archive', 1)"
        AttachmentTypeExist(".hbe", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.hhc', '', 0)"
        AttachmentTypeExist(".hhc", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.hki', 'WinHKI Archive', 1)"
        AttachmentTypeExist(".hki", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.hki1', 'WinHKI HKI1 Archive', 1)"
        AttachmentTypeExist(".hki1", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.hki2', 'WinHKI HKI2 Archive', 1)"
        AttachmentTypeExist(".hki2", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.hki3', 'WinHKI HKI3 Archive', 1)"
        AttachmentTypeExist(".hki3", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.hpk', 'HPack Compressed Archive', 1)"
        AttachmentTypeExist(".hpk", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.hpp', '', 0)"
        AttachmentTypeExist(".hpp", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.htm', '', 0)"
        AttachmentTypeExist(".htm", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.html', 'This is standard HTML', 0)"
        AttachmentTypeExist(".html", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.htw', '', 0)"
        AttachmentTypeExist(".htw", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.htx', '', 0)"
        AttachmentTypeExist(".htx", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.hxx', '', 0)"
        AttachmentTypeExist(".hxx", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.hyp', 'HYPER Compressed Archive', 1)"
        AttachmentTypeExist(".hyp", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.ibq', '', 0)"
        AttachmentTypeExist(".ibq", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.ice', 'ICE File Archive', 1)"
        AttachmentTypeExist(".ice", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.ico', 'Auto added this code.', 0)"
        AttachmentTypeExist(".ico", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.ics', 'Auto added this code.', 0)"
        AttachmentTypeExist(".ics", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.idl', '', 0)"
        AttachmentTypeExist(".idl", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.inc', '', 0)"
        AttachmentTypeExist(".inc", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.inf', '', 0)"
        AttachmentTypeExist(".inf", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.ini', '', 0)"
        AttachmentTypeExist(".ini", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.inx', '', 0)"
        AttachmentTypeExist(".inx", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.ipg', 'iPod Game File', 1)"
        AttachmentTypeExist(".ipg", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.ipk', 'Itsy Package', 1)"
        AttachmentTypeExist(".ipk", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.ish', 'ISH Compressed Archive', 1)"
        AttachmentTypeExist(".ish", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.j', 'JAR Archive', 1)"
        AttachmentTypeExist(".j", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.java', 'Auto added this code.', 0)"
        AttachmentTypeExist(".java", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.jgz', 'Gzipped Javascript File', 1)"
        AttachmentTypeExist(".jgz", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.jic', 'Java Icon File', 1)"
        AttachmentTypeExist(".jic", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.jpg', 'Auto added this code.', 0)"
        AttachmentTypeExist(".jpg", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.jpx', 'Auto added this code.', 0)"
        AttachmentTypeExist(".jpx", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.js', '', 0)"
        AttachmentTypeExist(".js", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.js=No', 'Auto added this code.', 0)"
        AttachmentTypeExist(".js", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.jsp', 'Java Server Page - as TXT.', 0)"
        AttachmentTypeExist(".jsp", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.kgb', 'KGB Archive File', 1)"
        AttachmentTypeExist(".kgb", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.lbr', 'LU Library Archive', 1)"
        AttachmentTypeExist(".lbr", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.lemon', 'LemonShare.net Download', 1)"
        AttachmentTypeExist(".lemon", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.lha', 'LHARC Compressed Archive', 1)"
        AttachmentTypeExist(".lha", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.lnx', 'Commodore 64 Lynx Archive', 1)"
        AttachmentTypeExist(".lnx", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.log', '', 0)"
        AttachmentTypeExist(".log", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.lqr', 'SQ Compressed LBR Archive', 1)"
        AttachmentTypeExist(".lqr", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.lzh', 'LZH Compressed File', 1)"
        AttachmentTypeExist(".lzh", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.lzm', 'Slax Module', 1)"
        AttachmentTypeExist(".lzm", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.lzma', 'LZMA Compressed File', 1)"
        AttachmentTypeExist(".lzma", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.lzo', 'LZO Compressed File', 1)"
        AttachmentTypeExist(".lzo", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.lzx', 'Amiga LZX Compressed File', 1)"
        AttachmentTypeExist(".lzx", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.m3u', '', 0)"
        AttachmentTypeExist(".m3u", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.md', 'MDCD Compressed Archive', 1)"
        AttachmentTypeExist(".md", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.MDI', 'Auto added this code.', 0)"
        AttachmentTypeExist(".MDI", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.mht', '', 0)"
        AttachmentTypeExist(".mht", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.mint', 'Linux Mint Installer File', 1)"
        AttachmentTypeExist(".mint", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.mp3', 'Auto added this code.', 0)"
        AttachmentTypeExist(".mp3", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.mpg', 'Auto added this code.', 0)"
        AttachmentTypeExist(".mpg", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.mpkg', 'Meta Package File', 1)"
        AttachmentTypeExist(".mpkg", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.mpp', 'Auto added this code.', 0)"
        AttachmentTypeExist(".mpp", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.msg', '', 0)"
        AttachmentTypeExist(".msg", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.msi', 'Auto added this code.', 0)"
        AttachmentTypeExist(".msi", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.mso', 'Auto added this code.', 0)"
        AttachmentTypeExist(".mso", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.msrcincident', 'Auto added this code.', 0)"
        AttachmentTypeExist(".msrcincident", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.mzp', 'MAXScript Zip Package', 1)"
        AttachmentTypeExist(".mzp", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.obd', '', 0)"
        AttachmentTypeExist(".obd", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.obt', '', 0)"
        AttachmentTypeExist(".obt", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.octet-stream', 'Auto added this code.', 0)"
        AttachmentTypeExist(".octet-stream", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.odc', '', 0)"
        AttachmentTypeExist(".odc", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.one', 'Auto added this code.', 0)"
        AttachmentTypeExist(".one", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.p7b', 'Auto added this code.', 0)"
        AttachmentTypeExist(".p7b", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.p7m', 'Digitally Encrypted Message', 1)"
        AttachmentTypeExist(".p7m", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.package', 'Linux Autopackage File', 1)"
        AttachmentTypeExist(".package", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.pae', 'PowerArchiver Encrypted Archive', 1)"
        AttachmentTypeExist(".pae", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.pak', 'PAK (Packed) File', 1)"
        AttachmentTypeExist(".pak", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.paq6', 'PAQ6 Data Archive', 1)"
        AttachmentTypeExist(".paq6", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.paq7', 'PAQ7 Data Archive', 1)"
        AttachmentTypeExist(".paq7", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.paq8', 'PAQ8 Data Archive', 1)"
        AttachmentTypeExist(".paq8", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.par', 'Parchive Index File', 1)"
        AttachmentTypeExist(".par", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.par2', 'Parchive 2 Index File', 1)"
        AttachmentTypeExist(".par2", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.pbi', 'PC BSD Installer Package', 1)"
        AttachmentTypeExist(".pbi", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.pcv', 'Mozilla Profile Backup', 1)"
        AttachmentTypeExist(".pcv", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.pcx', 'Auto added this code.', 0)"
        AttachmentTypeExist(".pcx", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.pdf', '', 0)"
        AttachmentTypeExist(".pdf", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.pea', 'PEA File Archive', 1)"
        AttachmentTypeExist(".pea", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.pf', 'Private File', 1)"
        AttachmentTypeExist(".pf", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.pim', 'PIM Archive', 1)"
        AttachmentTypeExist(".pim", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.pit', 'PackIt Compressed Archive', 1)"
        AttachmentTypeExist(".pit", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.piz', 'Zipped File', 1)"
        AttachmentTypeExist(".piz", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.pkg', 'Mac OS X Installer Package', 1)"
        AttachmentTypeExist(".pkg", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.pl', '', 0)"
        AttachmentTypeExist(".pl", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.png', 'Auto added this code.', 0)"
        AttachmentTypeExist(".png", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.pot', '', 0)"
        AttachmentTypeExist(".pot", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.pps', 'Auto added this code.', 0)"
        AttachmentTypeExist(".pps", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.ppt', '', 0)"
        AttachmentTypeExist(".ppt", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.proprties', 'Auto added this code.', 0)"
        AttachmentTypeExist(".proprties", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.psd', 'Auto added this code.', 0)"
        AttachmentTypeExist(".psd", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.pub', 'Auto added this code.', 0)"
        AttachmentTypeExist(".pub", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.pup', 'PlayStation 3 Update File', 1)"
        AttachmentTypeExist(".pup", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.puz', 'Packed Publisher File', 1)"
        AttachmentTypeExist(".puz", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.pwa', 'Password Agent File', 1)"
        AttachmentTypeExist(".pwa", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.qda', 'Quadruple D Archive', 1)"
        AttachmentTypeExist(".qda", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.r00', 'WinRAR Compressed Archive', 1)"
        AttachmentTypeExist(".r00", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.r01', 'WinRAR Split Archive Part 1', 1)"
        AttachmentTypeExist(".r01", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.r02', 'WinRAR Split Archive Part 2', 1)"
        AttachmentTypeExist(".r02", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.r03', 'WinRAR Split Archive Part 3', 1)"
        AttachmentTypeExist(".r03", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.rar', 'WinRAR Compressed Archive', 1)"
        AttachmentTypeExist(".rar", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.rc', '', 0)"
        AttachmentTypeExist(".rc", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.rdp', 'Auto added this code.', 0)"
        AttachmentTypeExist(".rdp", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.reg', '', 0)"
        AttachmentTypeExist(".reg", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.rev', 'RAR Recovery Volume Set', 1)"
        AttachmentTypeExist(".rev", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.rk', 'WinRK File Archive', 1)"
        AttachmentTypeExist(".rk", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.rnc', 'RNC ProPack Archive', 1)"
        AttachmentTypeExist(".rnc", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.rpm', 'Red Hat Package Manager File', 1)"
        AttachmentTypeExist(".rpm", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.rte', 'RTE Encoded File', 1)"
        AttachmentTypeExist(".rte", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.rtf', '', 0)"
        AttachmentTypeExist(".rtf", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.rz', 'Rzip Compressed File', 1)"
        AttachmentTypeExist(".rz", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.rzs', 'Red Zion Security File', 1)"
        AttachmentTypeExist(".rzs", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.s00', 'ZipSplitter Part 1 Archive', 1)"
        AttachmentTypeExist(".s00", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.s01', 'ZipSplitter Part 2 Archive', 1)"
        AttachmentTypeExist(".s01", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.s02', 'ZipSplitter Part 3 Archive', 1)"
        AttachmentTypeExist(".s02", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.s7z', 'Mac OS X 7-Zip File', 1)"
        AttachmentTypeExist(".s7z", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.sar', 'Service Archive File', 1)"
        AttachmentTypeExist(".sar", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.sdn', 'Shareware Distributors Network File', 1)"
        AttachmentTypeExist(".sdn", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.sea', 'Self-Extracting Archive', 1)"
        AttachmentTypeExist(".sea", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.sen', 'Scifer Internal Header Archive', 1)"
        AttachmentTypeExist(".sen", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.sfs', 'SquashFS File Archive', 1)"
        AttachmentTypeExist(".sfs", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.sfx', 'Windows Self-Extracting Archive', 1)"
        AttachmentTypeExist(".sfx", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.sh', 'Unix Shell Archive', 1)"
        AttachmentTypeExist(".sh", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.shar', 'Unix Shar Archive', 1)"
        AttachmentTypeExist(".shar", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.shk', 'ShrinkIt Archive', 1)"
        AttachmentTypeExist(".shk", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.shr', 'Unix Shell Archive File', 1)"
        AttachmentTypeExist(".shr", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.sit', 'Stuffit Archive', 1)"
        AttachmentTypeExist(".sit", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.sitx', 'Stuffit X Archive', 1)"
        AttachmentTypeExist(".sitx", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.spt', 'TM File Packer Compressed Archive', 1)"
        AttachmentTypeExist(".spt", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.sql', 'Auto added this code.', 0)"
        AttachmentTypeExist(".sql", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.sqx', 'SQX Archive', 1)"
        AttachmentTypeExist(".sqx", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.sqz', 'Squeezed Video File', 1)"
        AttachmentTypeExist(".sqz", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.stm', '', 0)"
        AttachmentTypeExist(".stm", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.tar', 'Consolidated Unix File Archive', 1)"
        AttachmentTypeExist(".tar", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.taz', 'Tar Zipped File', 1)"
        AttachmentTypeExist(".taz", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.tbz', 'Bzip Compressed Tar Archive', 1)"
        AttachmentTypeExist(".tbz", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.tbz2', 'Tar BZip 2 Compressed File', 1)"
        AttachmentTypeExist(".tbz2", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.tg', 'Gzip Compressed Tar Archive', 1)"
        AttachmentTypeExist(".tg", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.tgz', 'Gzipped Tar File', 1)"
        AttachmentTypeExist(".tgz", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.TIF', 'Auto added this code.', 0)"
        AttachmentTypeExist(".TIF", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.tiff', 'Auto added this code.', 0)"
        AttachmentTypeExist(".tiff", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.tlz', 'Tar LZMA Compressed File', 1)"
        AttachmentTypeExist(".tlz", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.txt', '', 0)"
        AttachmentTypeExist(".txt", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.tz', 'Zipped Tar Archive', 1)"
        AttachmentTypeExist(".tz", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.uc2', 'UltraCompressor 2 Archive', 1)"
        AttachmentTypeExist(".uc2", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.uha', 'UHarc Compressed Archive', 1)"
        AttachmentTypeExist(".uha", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.url', '', 0)"
        AttachmentTypeExist(".url", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.vb', 'Auto added this code.', 0)"
        AttachmentTypeExist(".vb", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.vb,x', 'Auto added this code.', 0)"
        AttachmentTypeExist(".vb,x", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.vbs', '', 0)"
        AttachmentTypeExist(".vbs", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.vcf', 'Auto added this code.', 0)"
        AttachmentTypeExist(".vcf", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.vsd', 'Auto added this code.', 0)"
        AttachmentTypeExist(".vsd", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.vsi', 'Visual Studio Content Installer File', 1)"
        AttachmentTypeExist(".vsi", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.wad', 'Compressed Game Data', 1)"
        AttachmentTypeExist(".wad", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.war', 'Java Web Archive', 1)"
        AttachmentTypeExist(".war", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.WAV', 'Auto added this code.', 0)"
        AttachmentTypeExist(".WAV", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.wcinv', 'Auto added this code.', 0)"
        AttachmentTypeExist(".wcinv", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.wm', 'Auto added this code.', 0)"
        AttachmentTypeExist(".wm", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.wma', 'Auto added this code.', 0)"
        AttachmentTypeExist(".wma", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.wmv', 'Auto added this code.', 0)"
        AttachmentTypeExist(".wmv", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.wmz', 'Auto added this code.', 0)"
        AttachmentTypeExist(".wmz", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.wot', 'Web Of Trust File', 1)"
        AttachmentTypeExist(".wot", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.wtx', '', 0)"
        AttachmentTypeExist(".wtx", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.x', 'Auto added this code.', 0)"
        AttachmentTypeExist(".x", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.xef', 'WinAce Encrypted File', 1)"
        AttachmentTypeExist(".xef", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.xez', 'eManager Template Package', 1)"
        AttachmentTypeExist(".xez", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.xlb', '', 0)"
        AttachmentTypeExist(".xlb", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.xlc', '', 0)"
        AttachmentTypeExist(".xlc", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.xls', '', 0)"
        AttachmentTypeExist(".xls", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.xlsx', 'Auto added this code.', 0)"
        AttachmentTypeExist(".xlsx", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.xlt', '', 0)"
        AttachmentTypeExist(".xlt", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.xmcdz', 'Mathcad Compressed Worksheet File', 1)"
        AttachmentTypeExist(".xmcdz", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.xml', '', 0)"
        AttachmentTypeExist(".xml", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.xpi', 'Mozilla Installer Package', 1)"
        AttachmentTypeExist(".xpi", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.xps', 'Auto added this code.', 0)"
        AttachmentTypeExist(".xps", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.XSD', 'Auto added this code.', 0)"
        AttachmentTypeExist(".XSD", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.xx', 'XXEncoded File', 1)"
        AttachmentTypeExist(".xx", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.y', 'Amiga Yabba Compressed File', 1)"
        AttachmentTypeExist(".y", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.yz', 'YAC Compressed File', 1)"
        AttachmentTypeExist(".yz", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.z', 'Unix Compressed File', 1)"
        AttachmentTypeExist(".z", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.z01', 'WinZip First Split Zip File', 1)"
        AttachmentTypeExist(".z01", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.z02', 'WinZip Second Split Zip File', 1)"
        AttachmentTypeExist(".z02", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.z03', 'WinZip Third Split Zip File', 1)"
        AttachmentTypeExist(".z03", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.z04', 'WinZip Fourth Split Zip File', 1)"
        AttachmentTypeExist(".z04", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.zap', 'FileWrangler Archive', 1)"
        AttachmentTypeExist(".zap", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.zfsendtotarget', 'Compressed Folder', 1)"
        AttachmentTypeExist(".zfsendtotarget", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.zip', 'Zipped File', 1)"
        AttachmentTypeExist(".zip", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.zix', 'WinZix Compressed File', 1)"
        AttachmentTypeExist(".zix", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.zoo', 'Zoo Compressed File', 1)"
        AttachmentTypeExist(".zoo", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.zz', 'Zzip Compressed Archive', 1)"
        AttachmentTypeExist(".zz", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.EMAIL', '', 0)"
        AttachmentTypeExist("EMAIL", InsertSql)

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.MSG', '', 0)"
        AttachmentTypeExist("MSG", InsertSql)

        '**********************************************
        'docx - Word 2007 XML Document
        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.docx', ' Word 2007 XML Document ', 0)"
        AttachmentTypeExist(".docx", InsertSql)

        'docm - Word 2007 XML Macro-Enabled Document
        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.docm', ' Word 2007 XML Macro-Enabled Document ', 0)"
        AttachmentTypeExist(".docm", InsertSql)

        'dotx - Word 2007 XML Template
        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.dotx', ' Word 2007 XML Template ', 0)"
        AttachmentTypeExist(".dotx", InsertSql)

        'dotm - Word 2007 XML Macro-Enabled Template
        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.dotm', ' Word 2007 XML Macro-Enabled Template ', 0)"
        AttachmentTypeExist(".dotm", InsertSql)

        'xlsx - Excel 2007 XML Workbook
        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.xlsx', ' Excel 2007 XML Workbook ', 0)"
        AttachmentTypeExist(".xlsx", InsertSql)

        'xlsm - Excel 2007 XML Macro-Enabled Workbook
        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.xlsm', ' Excel 2007 XML Macro-Enabled Workbook ', 0)"
        AttachmentTypeExist(".xlsm", InsertSql)

        'xltx - Excel 2007 XML Template
        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.xltx', ' Excel 2007 XML Template.', 0)"
        AttachmentTypeExist(".xltx", InsertSql)

        'xltm - Excel 2007 XML Macro-Enabled Template
        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.xltm', ' Excel 2007 XML Macro-Enabled Template ', 0)"
        AttachmentTypeExist(".xltm", InsertSql)

        'xlsb - Excel 2007 binary workbook (BIFF12)
        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.xlsb', ' Excel 2007 binary workbook (B.xlsb.', 0)"
        AttachmentTypeExist(".xlsb", InsertSql)

        'xlam - Excel 2007 XML Macro-Enabled Add-In
        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.xlam', ' Excel 2007 XML Macro-Enabled Add-In ', 0)"
        AttachmentTypeExist(".xlam", InsertSql)

        'pptx - PowerPoint 2007 XML Presentation
        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.pptx', ' PowerPoint 2007 XML Presentation ', 0)"
        AttachmentTypeExist(".pptx", InsertSql)

        'pptm - PowerPoint 2007 Macro-Enabled XML Presentation
        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.pptm', ' PowerPoint 2007 Macro-Enabled XML Presentation ', 0)"
        AttachmentTypeExist(".pptm", InsertSql)

        'potx - PowerPoint 2007 XML Template
        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.potx', ' PowerPoint 2007 XML Template ', 0)"
        AttachmentTypeExist(".potx", InsertSql)

        'potm - PowerPoint 2007 Macro-Enabled XML Template
        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.potm', ' PowerPoint 2007 Macro-Enabled XML Template ', 0)"
        AttachmentTypeExist(".potm", InsertSql)

        'ppam - PowerPoint 2007 Macro-Enabled XML Add-In
        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.ppam', ' PowerPoint 2007 Macro-Enabled XML Add-In ', 0)"
        AttachmentTypeExist(".ppam", InsertSql)

        'ppsx - PowerPoint 2007 XML Show
        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.ppsx', ' PowerPoint 2007 XML Show ', 0)"
        AttachmentTypeExist(".ppsx", InsertSql)

        'ppsm - PowerPoint 2007 Macro-Enabled XML Show
        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.ppsm', ' PowerPoint 2007 Macro-Enabled XML Show ', 0)"
        AttachmentTypeExist(".ppsm", InsertSql)

    End Sub
    Function AttachmentTypeExist(ByVal AttachmentCode$, ByVal InsertSql$) As Boolean
        ExecuteSQL(InsertSql)
    End Function

    'Function ThesaurusExist() As Boolean
    '    Dim DBX As New clsDb
    '    Dim B As Boolean = True
    '    Try
    '        DBX.ThesaurusExist()
    '    Catch ex As Exception
    '        LOG.WriteToSqlLog("clsValidateCodes:ThesaurusExist - failed to add default Thesaurus.")
    '        B = False
    '    Finally
    '        DBX = Nothing
    '        GC.Collect()
    '    End Try

    '    Return B
    'End Function

    Public Sub valSourceType()

        Dim SourceTypeCode$ = ""
        Dim SourceTypeDesc$ = ""
        Dim Indexable$ = ""

        Indexable$ = "0"

        SourceTypeExist(".docx", "Word 2007 XML Document", "1")
        SourceTypeExist(".docm", "Word 2007 XML Macro-Enabled Document", "1")
        SourceTypeExist(".dotx", "Word 2007 XML Template", "1")
        SourceTypeExist(".dotm", "Word 2007 XML Macro-Enabled Template", "1")
        SourceTypeExist(".xlsx", "Excel 2007 XML Workbook", "1")
        SourceTypeExist(".xlsm", "Excel 2007 XML Macro-Enabled Workbook", "1")
        SourceTypeExist(".xltx", "Excel 2007 XML Template", "1")
        SourceTypeExist(".xltm", "Excel 2007 XML Macro-Enabled Template", "1")
        SourceTypeExist(".xlsb", "Excel 2007 binary workbook (BIFF12)", "1")
        SourceTypeExist(".xlam", "Excel 2007 XML Macro-Enabled Add-In", "1")
        SourceTypeExist(".pptx", "PowerPoint 2007 XML Presentation", "1")
        SourceTypeExist(".pptm", "PowerPoint 2007 Macro-Enabled XML Presentation", "1")
        SourceTypeExist(".potx", "PowerPoint 2007 XML Template", "1")
        SourceTypeExist(".potm", "PowerPoint 2007 Macro-Enabled XML Template", "1")
        SourceTypeExist(".ppam", "PowerPoint 2007 Macro-Enabled XML Add-In", "1")
        SourceTypeExist(".ppsx", "PowerPoint 2007 XML Show", "1")
        SourceTypeExist(".ppsm", "PowerPoint 2007 Macro-Enabled XML Show", "1")

        SourceTypeExist(".dct", "Added by user", "1")
        SourceTypeExist(".act", "Added by user", "1")
        SourceTypeExist(".application", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".asax", "NO SEARCH - AUTO ADDED by Pgm", "1")
        SourceTypeExist(".ascx", "Word Splitter", "1")
        SourceTypeExist(".ashx", "NO SEARCH - AUTO ADDED by Pgm", "1")
        SourceTypeExist(".asm", "Word Splitter", "1")
        SourceTypeExist(".asmmeta", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".asp", "Word Splitter", "1")
        SourceTypeExist(".aspx", "Word Splitter", "1")
        SourceTypeExist(".BAK", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".baml", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".bas", "NO SEARCH - AUTO ADDED by Pgm", "1")
        SourceTypeExist(".bat", "Word Splitter", "1")
        SourceTypeExist(".bmp", "Added by user", "1")
        SourceTypeExist(".c", "Word Splitter", "1")
        SourceTypeExist(".Cache", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".cd", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".chm", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".cls", "NO SEARCH - AUTO ADDED by Pgm", "1")
        SourceTypeExist(".cmd", "Word Splitter", "1")
        SourceTypeExist(".compiled", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".config", "NO SEARCH - AUTO ADDED by Pgm", "1")
        SourceTypeExist(".cpp", "Word Splitter", "1")
        SourceTypeExist(".crt", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".cs", "NO SEARCH - AUTO ADDED by Pgm", "1")
        SourceTypeExist(".CSproj", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".css", "NO SEARCH - AUTO ADDED by Pgm", "1")
        SourceTypeExist(".csv", "NO SEARCH - AUTO ADDED by Pgm", "1")
        SourceTypeExist(".cxx", "Word Splitter", "1")
        SourceTypeExist(".dat", "NO SEARCH - AUTO ADDED by Pgm", "1")
        SourceTypeExist(".data", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".database", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".datasource", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".db", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".dct", "NO SEARCH - AUTO ADDED by Pgm", "1")
        SourceTypeExist(".def", "Word Splitter", "1")
        SourceTypeExist(".deploy", "NO SEARCH - AUTO ADDED by Pgm", "1")
        SourceTypeExist(".dic", "Word Splitter", "1")
        SourceTypeExist(".dll", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".DM1", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".dnn", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".doc", "Word Splitter", "1")
        SourceTypeExist(".docx", "NO SEARCH - AUTO ADDED by Pgm", "1")
        SourceTypeExist(".dot", "Word Splitter", "1")
        SourceTypeExist(".dtproj", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".dtsConfig", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".dtsx", "NO SEARCH - AUTO ADDED by Pgm", "1")
        SourceTypeExist(".emz", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".exe", "NO SEARCH - AUTO ADDED by Pgm", "0")

        SourceTypeExist(".frm", "Added by user", "1")
        SourceTypeExist(".gif", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".grxml", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".gz", "Added by user", "1")
        SourceTypeExist(".h", "Word Splitter", "1")
        SourceTypeExist(".hhc", "Word Splitter", "1")
        SourceTypeExist(".hlp", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".hpp", "Word Splitter", "1")
        SourceTypeExist(".htc", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".htm", "Word Splitter", "1")
        SourceTypeExist(".html", "Word Splitter", "1")
        SourceTypeExist(".htw", "Word Splitter", "1")
        SourceTypeExist(".htx", "Word Splitter", "1")
        SourceTypeExist(".hxx", "Word Splitter", "1")
        SourceTypeExist(".ibq", "Word Splitter", "1")
        SourceTypeExist(".ico", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".idl", "Word Splitter", "1")
        SourceTypeExist(".inc", "Word Splitter", "1")
        SourceTypeExist(".inf", "Word Splitter", "1")
        SourceTypeExist(".ini", "Word Splitter", "1")
        SourceTypeExist(".inx", "Word Splitter", "1")
        SourceTypeExist(".jar", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".java", "Added by user", "1")
        SourceTypeExist(".jpg", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".js", "Word Splitter", "1")
        SourceTypeExist(".kmz", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".ldb", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".ldf", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".lng", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".lnk", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".log", "Word Splitter", "1")
        SourceTypeExist(".m3u", "Word Splitter", "1")
        SourceTypeExist(".manifest", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".master", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".mdb", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".mdf", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".MDI", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".mht", "Word Splitter", "1")
        SourceTypeExist(".mp3", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".mrc", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".msg", "Word Splitter", "1")
        SourceTypeExist(".msi", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".myapp", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".obd", "Word Splitter", "1")
        SourceTypeExist(".obj", "Added by user", "1")
        SourceTypeExist(".obt", "Word Splitter", "1")
        SourceTypeExist(".odc", "Word Splitter", "1")
        SourceTypeExist(".one", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".opml", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".org", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".p7b", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".pcap", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".pdb", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".pdf", "Word Splitter", "1")
        SourceTypeExist(".pfx", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".php", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".pl", "Word Splitter", "1")
        SourceTypeExist(".png", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".pot", "Word Splitter", "1")
        SourceTypeExist(".ppt", "Word Splitter", "1")
        SourceTypeExist(".psd", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".pub", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".rar", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".rc", "Word Splitter", "1")
        SourceTypeExist(".rdl", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".rdlc", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".rds", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".reg", "Word Splitter", "1")
        SourceTypeExist(".resources", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".resx", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".rpt", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".rptproj", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".rtf", "Word Splitter", "1")
        SourceTypeExist(".scc", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".settings", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".shs", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".sitemap", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".skin", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".sln", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".sql", "Added by user", "1")
        SourceTypeExist(".SqlDataProvider", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".sqm", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".stm", "Word Splitter", "1")
        SourceTypeExist(".subproj", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".suo", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".tar", "Added by user", "1")
        SourceTypeExist(".template", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".Text", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".thmx", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".tif", "Added by user", "1")
        SourceTypeExist(".Tiff", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".tmp", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".txt", "Word Splitter", "1")
        SourceTypeExist(".UD", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".url", "Word Splitter", "1")
        SourceTypeExist(".user", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".vb", "Added by user", "1")
        SourceTypeExist(".vbp", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".vbproj", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".vbs", "Word Splitter", "1")
        SourceTypeExist(".vsd", "AUTO ADDED by Pgm", "0")
        SourceTypeExist(".vspscc", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".vstemplate", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".WAV", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".webproj", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".wma", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".wmv", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".wri", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".wtx", "Word Splitter", "1")
        SourceTypeExist(".xaml", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".xlb", "Word Splitter", "1")
        SourceTypeExist(".xlc", "Word Splitter", "1")
        SourceTypeExist(".xlk", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".xls", "Word Splitter", "1")
        SourceTypeExist(".xlsx", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".xlt", "Word Splitter", "1")
        SourceTypeExist(".xml", "Word Splitter", "1")
        SourceTypeExist(".xsc", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".xsd", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".xsl", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".xslt", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".xss", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".xsx", "NO SEARCH - AUTO ADDED by Pgm", "0")
        SourceTypeExist(".z", "Added by user", "1")
        SourceTypeExist(".zip", "Word Splitter", "1")




    End Sub

    Function SourceTypeExist(ByVal SourceTypeCode$, ByVal SourceTypeDesc$, ByVal Indexable$)
        'INSERT INTO [SourceType]([SourceTypeCode],[StoreExternal],[SourceTypeDesc],[Indexable])VALUES('XX',0,'XX',1)
        Dim S$ = "INSERT INTO [SourceType] ([SourceTypeCode],[StoreExternal],[SourceTypeDesc],[Indexable]) VALUES ('" + SourceTypeCode$ + "',0,'" + SourceTypeDesc$ + "'," + Indexable$ + ")"
        ExecuteSQL(S)
    End Function

    Public Sub valProfileItems()
        Dim SysParm$ = ""
        Dim InsertSql$ = ""
        Dim ProfileName$ = ""
        Dim SourceTypeCode$ = ""

        ProfileName$ = "Office Documents"
        SourceTypeCode$ = ".doc"
        LoadProfileItems(ProfileName$, SourceTypeCode$)

        ProfileName$ = "Office Documents"
        SourceTypeCode$ = ".docx"

        ProfileName$ = "Office Documents"
        SourceTypeCode$ = ".txt"

        LoadProfileItems(ProfileName$, SourceTypeCode$)

        ProfileName$ = "Office Documents"
        SourceTypeCode$ = ".docm"

        LoadProfileItems(ProfileName$, SourceTypeCode$)

        ProfileName$ = "Office Documents"
        SourceTypeCode$ = ".dotx"

        LoadProfileItems(ProfileName$, SourceTypeCode$)

        ProfileName$ = "Office Documents"
        SourceTypeCode$ = ".dotm"

        LoadProfileItems(ProfileName$, SourceTypeCode$)

        ProfileName$ = "Office Documents"
        SourceTypeCode$ = ".xls"

        LoadProfileItems(ProfileName$, SourceTypeCode$)

        ProfileName$ = "Office Documents"
        SourceTypeCode$ = ".xlsx"

        LoadProfileItems(ProfileName$, SourceTypeCode$)

        ProfileName$ = "Office Documents"
        SourceTypeCode$ = ".xlsm"

        LoadProfileItems(ProfileName$, SourceTypeCode$)

        ProfileName$ = "Office Documents"
        SourceTypeCode$ = ".xltx"

        LoadProfileItems(ProfileName$, SourceTypeCode$)

        ProfileName$ = "Office Documents"
        SourceTypeCode$ = ".xltm"

        LoadProfileItems(ProfileName$, SourceTypeCode$)

        ProfileName$ = "Office Documents"
        SourceTypeCode$ = ".xlsb"

        LoadProfileItems(ProfileName$, SourceTypeCode$)

        ProfileName$ = "Office Documents"
        SourceTypeCode$ = ".xlam"

        LoadProfileItems(ProfileName$, SourceTypeCode$)

        ProfileName$ = "Office Documents"
        SourceTypeCode$ = ".pptx"

        LoadProfileItems(ProfileName$, SourceTypeCode$)

        ProfileName$ = "Office Documents"
        SourceTypeCode$ = ".pptm"

        LoadProfileItems(ProfileName$, SourceTypeCode$)

        ProfileName$ = "Office Documents"
        SourceTypeCode$ = ".potx"

        LoadProfileItems(ProfileName$, SourceTypeCode$)

        ProfileName$ = "Office Documents"
        SourceTypeCode$ = ".potm"

        LoadProfileItems(ProfileName$, SourceTypeCode$)

        ProfileName$ = "Office Documents"
        SourceTypeCode$ = ".ppam"

        LoadProfileItems(ProfileName$, SourceTypeCode$)

        ProfileName$ = "Office Documents"
        SourceTypeCode$ = ".ppsx"

        LoadProfileItems(ProfileName$, SourceTypeCode$)

        ProfileName$ = "Office Documents"
        SourceTypeCode$ = ".ppsm"

        LoadProfileItems(ProfileName$, SourceTypeCode$)

        ProfileName$ = "Graphics Files"
        SourceTypeCode$ = ".gif"

        LoadProfileItems(ProfileName$, SourceTypeCode$)

        ProfileName$ = "Graphics Files"
        SourceTypeCode$ = ".tif"

        LoadProfileItems(ProfileName$, SourceTypeCode$)

        ProfileName$ = "Graphics Files"
        SourceTypeCode$ = ".tiff"

        LoadProfileItems(ProfileName$, SourceTypeCode$)

        ProfileName$ = "Graphics Files"
        SourceTypeCode$ = ".jpg"

        LoadProfileItems(ProfileName$, SourceTypeCode$)

        ProfileName$ = "Graphics Files"
        SourceTypeCode$ = ".bmp"

        LoadProfileItems(ProfileName$, SourceTypeCode$)

        ProfileName$ = "Graphics Files"
        SourceTypeCode$ = ".png"

        LoadProfileItems(ProfileName$, SourceTypeCode$)

        ProfileName$ = "Graphics Files"
        SourceTypeCode$ = ".trf"

        LoadProfileItems(ProfileName$, SourceTypeCode$)

        '*********************************************************************

        ProfileName$ = "Source Code - VB"
        SourceTypeCode$ = ".vb"

        LoadProfileItems(ProfileName$, SourceTypeCode$)

        ProfileName$ = "Source Code - VB"
        SourceTypeCode$ = ".xsd"

        LoadProfileItems(ProfileName$, SourceTypeCode$)

        ProfileName$ = "Source Code - VB"
        SourceTypeCode$ = ".xss"

        LoadProfileItems(ProfileName$, SourceTypeCode$)

        ProfileName$ = "Source Code - VB"
        SourceTypeCode$ = ".xsc"

        LoadProfileItems(ProfileName$, SourceTypeCode$)

        ProfileName$ = "Source Code - VB"
        SourceTypeCode$ = ".ico"

        LoadProfileItems(ProfileName$, SourceTypeCode$)

        ProfileName$ = "Source Code - VB"
        SourceTypeCode$ = ".rpt"

        LoadProfileItems(ProfileName$, SourceTypeCode$)

        ProfileName$ = "Source Code - VB"
        SourceTypeCode$ = ".rdlc"

        LoadProfileItems(ProfileName$, SourceTypeCode$)

        ProfileName$ = "Source Code - VB"
        SourceTypeCode$ = ".resx"

        LoadProfileItems(ProfileName$, SourceTypeCode$)

        ProfileName$ = "Source Code - VB"
        SourceTypeCode$ = ".sql"

        LoadProfileItems(ProfileName$, SourceTypeCode$)

        ProfileName$ = "Source Code - VB"
        SourceTypeCode$ = ".xml"

        LoadProfileItems(ProfileName$, SourceTypeCode$)

        ProfileName$ = "Source Code - VB"
        SourceTypeCode$ = ".sln"

        LoadProfileItems(ProfileName$, SourceTypeCode$)

        ProfileName$ = "Source Code - VB"
        SourceTypeCode$ = ".vbx"

        LoadProfileItems(ProfileName$, SourceTypeCode$)


    End Sub

    Function valLoadProfile() As Boolean
        Dim ProfileName$ = ""
        Dim ProfileDesc$ = ""

        ProfileName = "Graphics Files"
        ProfileDesc$ = "Known graphic file types"
        LoadProfile(ProfileName$, ProfileDesc$)

        ProfileName = "Office Documents"
        ProfileDesc$ = "MS Office files"
        LoadProfile(ProfileName$, ProfileDesc$)

        ProfileName = "Source Code - VB"
        ProfileDesc$ = "Development/Application files from VB Projects"
        LoadProfile(ProfileName$, ProfileDesc$)

        ProfileName = "Source Code - C#"
        ProfileDesc$ = "Development/Application files from C# Projects"
        LoadProfile(ProfileName$, ProfileDesc$)

    End Function

    Sub LoadProfile(ByVal ProfileName$, ByVal ProfileDesc$)
        Try
            Dim InsertSql$ = "INSERT INTO LoadProfile (ProfileName,ProfileDesc) VALUES ('" + ProfileName$ + "','" + ProfileName$ + "')"
            ExecuteSQL(InsertSql$)
        Catch ex As Exception
            LOG.WriteToSqlLog("ERROR: LoadProfile 100 - " + ex.Message + vbCrLf + ProfileName)
        End Try


    End Sub

    Sub LoadProfileItems(ByVal ProfileName$, ByVal SourceTypeCode$)

        Dim InsertSql$ = "INSERT INTO [LoadProfileItem] ([ProfileName] ,[SourceTypeCode]) VALUES ('" + ProfileName$ + "','" + SourceTypeCode$ + "')"
            ExecuteSQL(InsertSql$)

            InsertSql = "Insert AvailFileTypes (ExtCode) Values ('" + SourceTypeCode$ + "')"
            AvailFileTypesExist(SourceTypeCode$, InsertSql)
            SourceTypeExist(SourceTypeCode$, "AUTO Defined by System", "0")

            InsertSql$ = "INSERT INTO [LoadProfileItem] ([ProfileName] ,[SourceTypeCode]) VALUES ('" + ProfileName$ + "','" + SourceTypeCode$ + "')"
            ExecuteSQL(InsertSql$)


    End Sub

    Sub SetDefaultUserParms(ByVal UserGuid$)
        Dim SI As New clsSAVEDITEMS

        Dim SaveName$ = "UserStartUpParameters"
        Dim SaveTypeCode$ = "StartUpParm"

        Dim TempDir$ = System.IO.Path.GetTempPath
        'Dim b As Integer = DB.ckUserStartUpParameter(UserGuid$, "CONTENT WORKING DIRECTORY")
        Dim b = 0
        If b = 0 Then
            SI.setSavename(SaveName)
            SI.setSavetypecode(SaveTypeCode$)
            SI.setUserid(UserGuid$)
            SI.setValname("CONTENT WORKING DIRECTORY")
            SI.setValvalue(TempDir)
            SI.Insert()
        End If

        'b = DB.ckUserStartUpParameter(UserGuid$, "EMAIL WORKING DIRECTORY")
        b = 0
        If b = 0 Then
            SI.setSavename(SaveName)
            SI.setSavetypecode(SaveTypeCode$)
            SI.setUserid(UserGuid$)
            SI.setValname("EMAIL WORKING DIRECTORY")
            SI.setValvalue(TempDir)
            SI.Insert()
        End If

        'b = DB.ckUserStartUpParameter(UserGuid$, "RETENTION YEARS")
        b = 0
        If b = 0 Then
            SI.setSavename(SaveName)
            SI.setSavetypecode(SaveTypeCode$)
            SI.setUserid(UserGuid$)
            SI.setValname("RETENTION YEARS")
            SI.setValvalue("10")
            SI.Insert()
        End If

        'b = DB.ckUserStartUpParameter(UserGuid$, "DB WARNING LEVEL")
        b = 0
        If b = 0 Then
            SI.setSavename(SaveName)
            SI.setSavetypecode(SaveTypeCode$)
            SI.setUserid(UserGuid$)
            SI.setValname("DB WARNING LEVEL")
            SI.setValvalue("100")
            SI.Insert()
        End If
        'b = DB.ckUserStartUpParameter(UserGuid$, "DB RETURN INCREMENT")
        b = 0
        If b = 0 Then
            SI.setSavename(SaveName)
            SI.setSavetypecode(SaveTypeCode$)
            SI.setUserid(UserGuid$)
            SI.setValname("DB RETURN INCREMENT")
            SI.setValvalue("50")
            SI.Insert()
        End If
        SI = Nothing
    End Sub
    Public Sub addDefaultAttributes(ByVal AttributeName$, ByVal AttributeDataType$, ByVal AttributeDesc$, ByVal AssoApplication$)

        AttributeName$ = UTIL.RemoveSingleQuotes(AttributeName$)
        AttributeDataType$ = UTIL.RemoveSingleQuotes(AttributeDataType$)
        AttributeDesc$ = UTIL.RemoveSingleQuotes(AttributeDesc$)
        AssoApplication$ = UTIL.RemoveSingleQuotes(AssoApplication$)

        If AttributeDataType$.Length = 0 Then
            AttributeDataType$ = "varchar"
        End If
        If AttributeDesc$.Length = 0 Then
            AttributeDesc$ = "Varchar used as none Supplied at this time."
        End If
        If AssoApplication$.Length = 0 Then
            AssoApplication$ = "Unspecified"
        End If

        Dim S$ = ""
        S = S + " INSERT INTO [Attributes]"
        S = S + " ([AttributeName]"
        S = S + " ,[AttributeDataType]"
        S = S + " ,[AttributeDesc]"
        S = S + " ,[AssoApplication])"
        S = S + " VALUES ("
        S = S + " '" + AttributeName$ + "'"
        S = S + " ,'" + AttributeDataType$ + "'"
        S = S + " ,'" + AttributeDesc$ + "'"
        S = S + " ,'" + AssoApplication$ + "')"

        ExecuteSQL(S)
        
    End Sub

    Sub AddUserSelectableParameters(ByVal UserGuidID)


        AddDflt("debug_clsArchive", "0", UserGuidID)
        AddDflt("debug_SetupScreen", "0", UserGuidID)
        AddDflt("debug_QuickSearchScreen", "0", UserGuidID)
        AddDflt("debug_EmailSearchScreen", "0", UserGuidID)
        AddDflt("debug_ClsDatabase", "0", UserGuidID)
        AddDflt("debug_ContentSearchScreen", "0", UserGuidID)
        AddDflt("debug_QuickArchiveScreen", "0", UserGuidID)
        AddDflt("debug_clsSql", "0", UserGuidID)
        AddDflt("debug_MetadataScreen", "0", UserGuidID)
        AddDflt("debug_clsSpider", "0", UserGuidID)
        AddDflt("debug_clsEmailFunc", "1", UserGuidID)

        AddDflt("UserEmail_Pause", "250", UserGuidID)
        AddDflt("UserContent_Pause", "250", UserGuidID)

        AddDflt("user_DaysToKeepTraceLogs", "2", UserGuidID)
        AddDflt("user_EmailFolder1", "Personal Folders", UserGuidID)
        AddDflt("user_CreateOutlookRestoreFolder", "0", UserGuidID)
        AddDflt("user_showContactMenu", "0", UserGuidID)

        AddDflt("user_MaxRecordsToFetch", "10000000", UserGuidID)

        AddDflt("user_RunUnattended", "N", UserGuidID)

        AddDflt("user_HiveEnabled", "N", UserGuidID)

        AddDflt("user_PageReturn", "0", UserGuidID)
        AddDflt("user_PageReturnRowLimit", "100", UserGuidID)

    End Sub

    Sub AddDflt(ByVal sKey$, ByVal sValue$, ByVal sUser$)
        Dim RP As New clsRUNPARMS
        'Dim iCnt As Integer = RP.cnt_PKI8(sKey, sUser)
        Dim iCnt As Integer = 0
        If iCnt = 0 Then
            RP.setParm(sKey)
            RP.setParmvalue(sValue)
            RP.setUserid(sUser)
            RP.Insert()
        End If
        RP = Nothing
    End Sub
    Function addHelpInfo(ByVal HelpName$, ByVal HelpEmailAddr$, ByVal HelpPhone$, ByVal AreaOfFocus$, ByVal HoursAvail$, ByVal EmailNotification As Integer)
        'INSERT INTO [SourceType]([SourceTypeCode],[StoreExternal],[SourceTypeDesc],[Indexable])VALUES('XX',0,'XX',1)
        Dim B As Boolean = False
        Dim iCnt As Integer = 0
        Dim S$ = " "

        S = S + " INSERT INTO [HelpInfo]"
        S = S + "    ([HelpName]"
        S = S + "    ,[HelpEmailAddr]"
        S = S + "    ,[HelpPhone]"
        S = S + "    ,[AreaOfFocus]"
        S = S + "    ,[HoursAvail], EmailNotification )"
        S = S + " VALUES "
        S = S + "    ('" + HelpName + "'"
        S = S + "    ,'" + HelpEmailAddr + "'"
        S = S + "    ,'" + HelpPhone + "'"
        S = S + "    ,'" + AreaOfFocus + "'"
        S = S + "    ,'" + HoursAvail + "'"
        S = S + "    ," + EmailNotification.ToString + ")"

        ExecuteSQL(S)
        Return B

    End Function

    Sub AddImageCodes()
        Dim B As Boolean = True
        Dim S As String = ""
        S = " INSERT [ImageTypeCodes] ([ImageTypeCode], [ImageTypeCodeDesc]) VALUES (N'.bmp', '')"
        ExecuteSQL(S)
        S = " INSERT [ImageTypeCodes] ([ImageTypeCode], [ImageTypeCodeDesc]) VALUES (N'.emf', NULL)"
        ExecuteSQL(S)
        S = " INSERT [ImageTypeCodes] ([ImageTypeCode], [ImageTypeCodeDesc]) VALUES (N'.gif', '')"
        ExecuteSQL(S)
        S = " INSERT [ImageTypeCodes] ([ImageTypeCode], [ImageTypeCodeDesc]) VALUES (N'.ico', '')"
        ExecuteSQL(S)
        S = " INSERT [ImageTypeCodes] ([ImageTypeCode], [ImageTypeCodeDesc]) VALUES (N'.jpeg', NULL)"
        ExecuteSQL(S)
        S = " INSERT [ImageTypeCodes] ([ImageTypeCode], [ImageTypeCodeDesc]) VALUES (N'.jpg', '')"
        ExecuteSQL(S)
        S = " INSERT [ImageTypeCodes] ([ImageTypeCode], [ImageTypeCodeDesc]) VALUES (N'.png', '')"
        ExecuteSQL(S)
        S = " INSERT [ImageTypeCodes] ([ImageTypeCode], [ImageTypeCodeDesc]) VALUES (N'.tif', '')"
        ExecuteSQL(S)
        S = " INSERT [ImageTypeCodes] ([ImageTypeCode], [ImageTypeCodeDesc]) VALUES (N'.tiff', '')"
        ExecuteSQL(S)
        S = " INSERT [ImageTypeCodes] ([ImageTypeCode], [ImageTypeCodeDesc]) VALUES (N'.trf', 'Proprietary document storage format of Documagix processed a an image file using ECM OCR.')"
        ExecuteSQL(S)
        S = " INSERT [ImageTypeCodes] ([ImageTypeCode], [ImageTypeCodeDesc]) VALUES (N'.wmf', NULL)"
        ExecuteSQL(S)
    End Sub

    Sub VerifyLookupData()
        Dim B As Boolean = False
        Dim S As String = ""

        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (null, 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (',dct', 0, 'Added by user', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.act', 0, 'Added by user', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ada', 0, 'Added by user', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.adb', 0, 'Added by user', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ads', 0, 'Added by user', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.application', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.asax', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ascx', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ashx', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.asm', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.asmmeta', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.asp', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.aspx', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.BAK', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.baml', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.bas', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.bat', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.bmp', 0, 'Added by user', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.c', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.Cache', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.cd', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.chm', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.cls', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.cmd', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.compiled', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.config', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.cpp', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.crt', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.cs', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.CSproj', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.css', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.csv', 0, 'Added by user', 1, NULL, NULL, NULL, NULL, NULL)"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.cxx', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.dat', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.data', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.database', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.datasource', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.db', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.dct', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.def', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.deploy', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.dic', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.dll', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.DM1', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.dnn', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.doc', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.docm', 0, 'Word 2007 XML Macro-Enabled Document', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.docx', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.dot', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.dotm', 0, 'Word 2007 XML Macro-Enabled Template', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.dotx', 0, 'Word 2007 XML Template', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.dtproj', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.dtsConfig', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.dtsx', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.emz', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.exe', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.exe_SyncToyBackup_20090311100439812', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.exe_SyncToyBackup_20090406194350947', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.frm', 0, 'Added by user', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.gif', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.grxml', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.gz', 0, 'Added by user', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.h', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.hhc', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.hlp', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.hpp', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.htc', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.htm', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.html', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.htw', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.htx', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.hxx', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ibq', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ico', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.idl', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.inc', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.inf', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ini', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.inx', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.jar', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.java', 0, 'Added by user', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.jpg', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.js', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.kmz', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ldb', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ldf', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.lng', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.lnk', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.log', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.m3u', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.manifest', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.master', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.mdb', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.mdf', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.MDI', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.mht', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.mp3', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.mrc', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.msg', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.msi', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.myapp', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.obd', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.obj', 0, 'Added by user', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.obt', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.odc', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.one', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.opml', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.org', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.p7b', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.pcap', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.pdb', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.pdf', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.pfx', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.php', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.pl', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.png', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.pot', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.potm', 0, 'PowerPoint 2007 Macro-Enabled XML Template', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.potx', 0, 'PowerPoint 2007 XML Template', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ppam', 0, 'PowerPoint 2007 Macro-Enabled XML Add-In', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ppsm', 0, 'PowerPoint 2007 Macro-Enabled XML Show', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ppsx', 0, 'PowerPoint 2007 XML Show', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ppt', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.pptm', 0, 'PowerPoint 2007 Macro-Enabled XML Presentation', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.pptx', 0, 'PowerPoint 2007 XML Presentation', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.psd', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.pub', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.rar', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.rc', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.rdl', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.rdlc', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.rds', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.reg', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.resources', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.resx', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.rpt', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.rptproj', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.rtf', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.scc', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.settings', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.shs', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.sitemap', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.skin', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.sln', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.sql', 0, 'Added by user', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.SqlDataProvider', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.sqlsuo', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, NULL, NULL, NULL, NULL)"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.sqm', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.stm', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.subproj', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.suo', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.tar', 0, 'Added by user', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.template', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.Text', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.thmx', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.tif', 0, 'Added by user', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.Tiff', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.tmp', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.TRF', 0, 'Added by user', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.txt', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.UD', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.url', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.user', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.vb', 0, 'Added by user', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.vbp', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.vbproj', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.vbs', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.vbx', 0, 'AUTO Defined by System', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.vsd', 0, 'AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.vspscc', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.vstemplate', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.WAV', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.webproj', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.wma', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.wmv', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.wri', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.wtx', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xaml', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xlam', 0, 'Excel 2007 XML Macro-Enabled Add-In', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xlb', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xlc', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xlk', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xls', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xlsb', 0, 'Excel 2007 binary workbook (BIFF12)', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xlsm', 0, 'Excel 2007 XML Macro-Enabled Workbook', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xlsx', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xlt', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xltm', 0, 'Excel 2007 XML Macro-Enabled Template', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xltx', 0, 'Excel 2007 XML Template', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xml', 0, 'Word Splitter', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xsc', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xsd', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xsl', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xslt', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xss', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xsx', 0, 'NO SEARCH - AUTO ADDED by Pgm', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.z', 0, 'Added by user', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.zip', 0, 'Word Splitter', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Added by user', 0, '.dct', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('docm', 0, 'Word 2007 XML Macro-Enabled Document', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('docx', 0, 'Word 2007 XML Document', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('dotm', 0, 'Word 2007 XML Macro-Enabled Template', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('dotx', 0, 'Word 2007 XML Template', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('NO SEARCH - AUTO ADDED by Pgm', 0, '.application', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('potm', 0, 'PowerPoint 2007 Macro-Enabled XML Template', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('potx', 0, 'PowerPoint 2007 XML Template', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('ppam', 0, 'PowerPoint 2007 Macro-Enabled XML Add-In', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('ppsm', 0, 'PowerPoint 2007 Macro-Enabled XML Show', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('ppsx', 0, 'PowerPoint 2007 XML Show', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('pptm', 0, 'PowerPoint 2007 Macro-Enabled XML Presentation', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('pptx', 0, 'PowerPoint 2007 XML Presentation', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('xlam', 0, 'Excel 2007 XML Macro-Enabled Add-In', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('xlsb', 0, 'Excel 2007 binary workbook (BIFF12)', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('xlsm', 0, 'Excel 2007 XML Macro-Enabled Workbook', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('xlsx', 0, 'Excel 2007 XML Workbook', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('xltm', 0, 'Excel 2007 XML Macro-Enabled Template', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('xltx', 0, 'Excel 2007 XML Template', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[SourceType] ([SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('XXXX', 0, 'AUTO Definition - not found', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CC9DDC AS DateTime), CAST(0x00009D8B00CC9DE6 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Retention] ([RetentionCode], [RetentionDesc], [RetentionYears], [RetentionAction], [ManagerID], [ManagerName], [DaysWarning], [ResponseRequired], [ManagerAcknowledged], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Retain 10 Years', 'Retain for 5 Years', 5, 'delete', 'admin', 'admin', NULL, NULL, NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBF50E AS DateTime), CAST(0x00009D8B00CBF512 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Retention] ([RetentionCode], [RetentionDesc], [RetentionYears], [RetentionAction], [ManagerID], [ManagerName], [DaysWarning], [ResponseRequired], [ManagerAcknowledged], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Retain 10 Years', 'Retain for 10 Years', 10, 'delete', 'admin', 'admin', NULL, NULL, NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBF50E AS DateTime), CAST(0x00009D8B00CBF512 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Retention] ([RetentionCode], [RetentionDesc], [RetentionYears], [RetentionAction], [ManagerID], [ManagerName], [DaysWarning], [ResponseRequired], [ManagerAcknowledged], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Retain 20 Years', '20 years', 20, 'delete', 'bmiller', 'bmiller', NULL, NULL, NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBF50E AS DateTime), CAST(0x00009D8B00CBF512 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Retention] ([RetentionCode], [RetentionDesc], [RetentionYears], [RetentionAction], [ManagerID], [ManagerName], [DaysWarning], [ResponseRequired], [ManagerAcknowledged], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Retain 30 Years', '30 Years', 30, 'delete', '233e9e91-a657-4f98-8d4f-0ce1a341dfcb', 'smiller', NULL, NULL, NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBF50E AS DateTime), CAST(0x00009D8B00CBF512 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Retention] ([RetentionCode], [RetentionDesc], [RetentionYears], [RetentionAction], [ManagerID], [ManagerName], [DaysWarning], [ResponseRequired], [ManagerAcknowledged], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Retain 40 Years', '40 Years', 40, 'delete', NULL, 'wmiller', NULL, NULL, NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBF50E AS DateTime), CAST(0x00009D8B00CBF512 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Retention] ([RetentionCode], [RetentionDesc], [RetentionYears], [RetentionAction], [ManagerID], [ManagerName], [DaysWarning], [ResponseRequired], [ManagerAcknowledged], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Retain 50 Years', 'Retian for 50 Years', 50, 'Move', 'SAdmin', 'sadmin', NULL, NULL, NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBF50E AS DateTime), CAST(0x00009D8B00CBF512 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Retention] ([RetentionCode], [RetentionDesc], [RetentionYears], [RetentionAction], [ManagerID], [ManagerName], [DaysWarning], [ResponseRequired], [ManagerAcknowledged], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Retain 60 Years', 'Retian for 60 Years', 50, 'Inactive', 'SAdmin', 'sadmin', NULL, NULL, NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBF50E AS DateTime), CAST(0x00009D8B00CBF512 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Office Documents', '.xlsx', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Office Documents', '.xls', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Office Documents', '.pdf', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Office Documents', '.html', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Office Documents', '.htm', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Office Documents', '.docx', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Office Documents', '.doc', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Graphics Files', '.Tiff', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Graphics Files', '.tif', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Graphics Files', '.gif', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Office Documents', '.docm', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Office Documents', '.dotx', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Office Documents', '.dotm', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Office Documents', '.xlsm', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Office Documents', '.xltx', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Office Documents', '.xltm', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Office Documents', '.xlsb', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Office Documents', '.xlam', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Office Documents', '.pptx', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Office Documents', '.pptm', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Office Documents', '.potx', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Office Documents', '.potm', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Office Documents', '.ppam', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Office Documents', '.ppsx', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Office Documents', '.ppsm', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Graphics Files', '.bmp', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Graphics Files', '.png', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Source Code - VB', '.vb', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Source Code - VB', '.xsd', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Source Code - VB', '.xss', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Source Code - VB', '.xsc', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Source Code - VB', '.ico', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Source Code - VB', '.rpt', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Source Code - VB', '.rdlc', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Source Code - VB', '.resx', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Source Code - VB', '.sql', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Source Code - VB', '.xml', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Source Code - VB', '.sln', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Source Code - VB', '.vbx', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Graphics Files', '.jpg', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[LoadProfile] ([ProfileName], [ProfileDesc], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Graphics Files', 'Known graphic file types.', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB752 AS DateTime), CAST(0x00009D8B00CBB752 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[LoadProfile] ([ProfileName], [ProfileDesc], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Office Documents', 'All MS Office content.', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB752 AS DateTime), CAST(0x00009D8B00CBB752 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[LoadProfile] ([ProfileName], [ProfileDesc], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Source Code - C#', 'Source Code - C#', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB752 AS DateTime), CAST(0x00009D8B00CBB752 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[LoadProfile] ([ProfileName], [ProfileDesc], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Source Code - VB', 'Source Code - VB', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB752 AS DateTime), CAST(0x00009D8B00CBB752 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.0', 'Hacha Split Archive File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.000', 'DoubleSpace Compressed File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.001', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.0d054e90', 'Auto added this code.', 0, NULL, NULL, NULL, NULL, NULL)"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.3gp', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.7z', '7-Zip Compressed File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ace', 'WinAce Compressed File (Edited)', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ADA', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ADB', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ADS', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ain', 'AIN Compressed File Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.alz', 'ALZip Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.apz', 'Autoplay Media Studio Exported Project', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ar', 'Unix Static Library', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.arc', 'Compressed File Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ari', 'ARI Compressed File Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.arj', 'ARJ Compressed File Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ascx', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.asm', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.asp', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.aspx', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.aspx_userid=2126', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.au', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.axx', 'AxCrypt Encrypted File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.b64', 'Base64 MIME-Encoded File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ba', 'Scifer External Header Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.Backup', 'Auto added this code.', 0, NULL, NULL, NULL, NULL, NULL)"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.bat', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.bh', 'BlakHole Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.bmp', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.boo', 'Booasm Compressed Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.bqy', 'Auto added this code.', 0, NULL, NULL, NULL, NULL, NULL)"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.bz', 'Bzip Compressed File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.bz2', 'Bzip2 Compressed File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.bzip', 'Bzip Compressed Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.bzip2', 'Bzip2 Compressed Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.c', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.c00', 'WinAce Split Archive File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.c01', 'WinAce Split Archive Part 1 File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.c02', 'WinAce Split Archive Part 1 File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.camproj', 'Auto added this code.', 0, NULL, NULL, NULL, NULL, NULL)"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.car', 'CAR Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.cbr', 'Comic Book RAR Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.cbz', 'Comic Book ZIP Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.cmd', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.config', 'Auto added this code.', 0, NULL, NULL, NULL, NULL, NULL)"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.cp9', 'ChoicePoint Encrypted File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.cpgz', 'Compressed CPIO Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.cpp', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.cpt', 'Compact Pro Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.crt', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.csv', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.cxx', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.dar', 'DAR Disk Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.dat', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.dd', 'DiskDouber Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.deb', 'Debian Software Package', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.def', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.dgc', 'DGCA File Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.dic', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.dist', 'Mac OS X Distribution Script', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.dll', 'Auto added this code.', 0, NULL, NULL, NULL, NULL, NULL)"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.DM1', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.doc', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.docm', ' Word 2007 XML Macro-Enabled Document ', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.docx', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.dot', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.dotm', ' Word 2007 XML Macro-Enabled Template ', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.dotx', ' Word 2007 XML Template ', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.dts', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.dtsx', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ecs', 'Sony Ericsson Phone Backup File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.efw', 'Renamed Zip or Executable File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.emz', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.eps', 'Auto added this code.', 0, NULL, NULL, NULL, NULL, NULL)"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.exe', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.f', 'Freeze Compressed File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.fdp', 'MySafe Encrypted Data', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.gca', 'GCA File Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.gif', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.GRV', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.gz', 'Gnu Zipped File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.gzi', 'Unix Gzip File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.gzip', 'Gnu Zipped File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.h', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ha', 'HA Compressed Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.hbc', 'HyperBac Compressed Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.hbc2', 'HyperBac Compressed File Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.hbe', 'HyperBac Compressed and Encrypted Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.hhc', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.hki', 'WinHKI Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.hki1', 'WinHKI HKI1 Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.hki2', 'WinHKI HKI2 Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.hki3', 'WinHKI HKI3 Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.hpk', 'HPack Compressed Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.hpp', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.htm', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.html', 'This is standard HTML', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.htw', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.htx', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.hxx', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.hyp', 'HYPER Compressed Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ibq', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ice', 'ICE File Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ico', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ics', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.idl', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.inc', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.inf', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ini', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.inx', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ipg', 'iPod Game File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ipk', 'Itsy Package', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ish', 'ISH Compressed Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.j', 'JAR Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.java', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.jgz', 'Gzipped Javascript File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.jic', 'Java Icon File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.jpg', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.jpx', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.js', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.js=No', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.jsp', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.kgb', 'KGB Archive File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.lbr', 'LU Library Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.lemon', 'LemonShare.net Download', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.lha', 'LHARC Compressed Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.lnx', 'Commodore 64 Lynx Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.log', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.lqr', 'SQ Compressed LBR Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.lzh', 'LZH Compressed File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.lzm', 'Slax Module', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.lzma', 'LZMA Compressed File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.lzo', 'LZO Compressed File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.lzx', 'Amiga LZX Compressed File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.m3u', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.m4a', 'Auto added this code.', 0, NULL, NULL, NULL, NULL, NULL)"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.md', 'MDCD Compressed Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.MDI', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.mht', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.mint', 'Linux Mint Installer File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.mp3', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.mpeg', 'Auto added this code.', 0, NULL, NULL, NULL, NULL, NULL)"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.mpg', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.mpkg', 'Meta Package File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.mpp', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.msg', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.msi', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.mso', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.msrcincident', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.mzp', 'MAXScript Zip Package', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.nsf', 'Auto added this code.', 0, NULL, NULL, NULL, NULL, NULL)"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.obd', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.obt', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.octet-stream', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.odc', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.one', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.p7b', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.p7m', 'Digitally Encrypted Message', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.package', 'Linux Autopackage File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.pae', 'PowerArchiver Encrypted Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.pak', 'PAK (Packed) File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.paq6', 'PAQ6 Data Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.paq7', 'PAQ7 Data Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.paq8', 'PAQ8 Data Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.par', 'Parchive Index File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.par2', 'Parchive 2 Index File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.pbi', 'PC BSD Installer Package', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.pcv', 'Mozilla Profile Backup', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.pcx', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.pdf', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.pea', 'PEA File Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.pf', 'Private File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.pim', 'PIM Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.pit', 'PackIt Compressed Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.piz', 'Zipped File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.pkg', 'Mac OS X Installer Package', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.pl', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.png', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.pot', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.potm', ' PowerPoint 2007 Macro-Enabled XML Template ', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.potx', ' PowerPoint 2007 XML Template ', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ppam', ' PowerPoint 2007 Macro-Enabled XML Add-In ', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.pps', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ppsm', ' PowerPoint 2007 Macro-Enabled XML Show ', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ppsx', ' PowerPoint 2007 XML Show ', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ppt', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.pptm', ' PowerPoint 2007 Macro-Enabled XML Presentation ', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.pptx', ' PowerPoint 2007 XML Presentation ', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.proprties', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.psd', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.pub', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.pup', 'PlayStation 3 Update File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.puz', 'Packed Publisher File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.pwa', 'Password Agent File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.qda', 'Quadruple D Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.r00', 'WinRAR Compressed Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.r01', 'WinRAR Split Archive Part 1', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.r02', 'WinRAR Split Archive Part 2', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.r03', 'WinRAR Split Archive Part 3', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.rar', 'WinRAR Compressed Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.rc', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.rdp', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.reg', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.rev', 'RAR Recovery Volume Set', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.rk', 'WinRK File Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.rnc', 'RNC ProPack Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.rpm', 'Red Hat Package Manager File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.rte', 'RTE Encoded File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.rtf', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.rz', 'Rzip Compressed File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.rzs', 'Red Zion Security File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.s00', 'ZipSplitter Part 1 Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.s01', 'ZipSplitter Part 2 Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.s02', 'ZipSplitter Part 3 Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.s7z', 'Mac OS X 7-Zip File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.sar', 'Service Archive File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.sdn', 'Shareware Distributors Network File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.sea', 'Self-Extracting Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.sen', 'Scifer Internal Header Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.sfs', 'SquashFS File Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.sfx', 'Windows Self-Extracting Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.sh', 'Unix Shell Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.shar', 'Unix Shar Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.shk', 'ShrinkIt Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.shr', 'Unix Shell Archive File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.sit', 'Stuffit Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.sitx', 'Stuffit X Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.sln', 'Auto added this code.', 0, NULL, NULL, NULL, NULL, NULL)"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.spt', 'TM File Packer Compressed Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.sql', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.sqx', 'SQX Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.sqz', 'Squeezed Video File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.stm', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.suo', 'Auto added this code.', 0, NULL, NULL, NULL, NULL, NULL)"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.tar', 'Consolidated Unix File Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.taz', 'Tar Zipped File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.tbz', 'Bzip Compressed Tar Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.tbz2', 'Tar BZip 2 Compressed File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.tg', 'Gzip Compressed Tar Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.tgz', 'Gzipped Tar File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.TIF', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.tiff', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.tlz', 'Tar LZMA Compressed File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.TRF', 'Auto added this code.', 0, NULL, NULL, NULL, NULL, NULL)"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.txt', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.tz', 'Zipped Tar Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.uc2', 'UltraCompressor 2 Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.uha', 'UHarc Compressed Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.url', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.vb', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.vb,x', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.vbs', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.vcf', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.vsd', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.vsi', 'Visual Studio Content Installer File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.wad', 'Compressed Game Data', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.war', 'Java Web Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.WAV', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.wcinv', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.wm', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.wma', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.wmv', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.wmz', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.wot', 'Web Of Trust File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.wps', 'Auto added this code.', 0, NULL, NULL, NULL, NULL, NULL)"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.wtx', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.x', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xef', 'WinAce Encrypted File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xez', 'eManager Template Package', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xlam', ' Excel 2007 XML Macro-Enabled Add-In ', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xlb', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xlc', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xls', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xlsb', ' Excel 2007 binary workbook (B.xlsb.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xlsm', ' Excel 2007 XML Macro-Enabled Workbook ', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xlsx', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xlt', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xltm', ' Excel 2007 XML Macro-Enabled Template ', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xltx', ' Excel 2007 XML Template ', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xmcdz', 'Mathcad Compressed Worksheet File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xml', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xpi', 'Mozilla Installer Package', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xps', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.XSD', 'Auto added this code.', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xx', 'XXEncoded File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.y', 'Amiga Yabba Compressed File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.yip', 'Auto added this code.', 0, NULL, NULL, NULL, NULL, NULL)"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.yz', 'YAC Compressed File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.z', 'Unix Compressed File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.z01', 'WinZip First Split Zip File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.z02', 'WinZip Second Split Zip File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.z03', 'WinZip Third Split Zip File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.z04', 'WinZip Fourth Split Zip File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.zap', 'FileWrangler Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.zfsendtotarget', 'Compressed Folder', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.zip', 'Zipped File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.zix', 'WinZix Compressed File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.zoo', 'Zoo Compressed File', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.zz', 'Zzip Compressed Archive', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('docm', ' Word 2007 XML Macro-Enabled Document ', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('dotm', ' Word 2007 XML Macro-Enabled Template ', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('dotx', ' Word 2007 XML Template ', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('EMAIL', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('MSG', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('UKN', 'Unknown Attachment Type', 0, NULL, NULL, NULL, NULL, NULL)"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('xlam', ' Excel 2007 XML Macro-Enabled Add-In ', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('xlsm', ' Excel 2007 XML Macro-Enabled Workbook ', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('xltm', ' Excel 2007 XML Macro-Enabled Template ', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttachmentType] ([AttachmentCode], [Description], [isZipFormat], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('xltx', ' Excel 2007 XML Template ', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB93CE AS DateTime), CAST(0x00009D8B00CB93D3 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('*', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (',dct', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.*', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.act', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ada', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.adb', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ads', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ascx', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.asm', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.asp', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.aspx', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.bat', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.bmp', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.c', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.cmd', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.cpp', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.csv', NULL, NULL, NULL, NULL, NULL)"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.cxx', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.dct', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.def', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.dic', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.dll', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.doc', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.docm', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.docx', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.dot', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.dotm', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.dotx', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.exe', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.frm', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.GIF', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.gz', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.h', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.hhc', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.hpp', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.htm', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.html', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.htw', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.htx', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.hxx', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ibq', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.idl', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.inc', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.inf', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ini', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.inx', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.java', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.JPG', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.JPX', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.js', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.log', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.m3u', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.mht', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.mp3', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.msg', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.obd', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.obj', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.obt', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.odc', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.pdf', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.pl', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.PNG', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.pot', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.potm', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.potx', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ppam', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ppsm', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ppsx', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ppt', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.pptm', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.pptx', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.rc', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.reg', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.resx', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.rtf', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.sln', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.sql', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.stm', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.suo', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.tar', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.tif', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.TIFF', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.TRF', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.txt', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.UKN', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.url', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.vb', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.vbs', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.vbx', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.VSD', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.wav', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.wma', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.wtx', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.XL*', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xlam', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xlb', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xlc', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xls', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xlsm', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xlsx', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xlt', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xltm', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xltx', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xml', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xsc', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xsd', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xslt', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xss', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.z', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.zip', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypes] ([ExtCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('msg', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9464 AS DateTime), CAST(0x00009D8B00CB9464 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.docx', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.Tiff', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.jpg', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.rar', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xlsx', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.shs', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.php', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.emz', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.thmx', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.png', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.config', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.vbproj', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.user', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.resx', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.mdf', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ldf', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.myapp', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.settings', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.exe', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.pdb', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.resources', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.Cache', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xsc', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xsd', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xss', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.mdb', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ldb', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.opml', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.template', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.Text', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.htc', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xslt', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.psd', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.p7b', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.crt', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ashx', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.asax', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.sitemap', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.dtsConfig', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.dtsx', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.pfx', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.application', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.one', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xlk', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.pub', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.exe_SyncToyBackup_20090311100439812', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.exe_SyncToyBackup_20090406194350947', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.kmz', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.mp3', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.wma', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.WAV', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.wmv', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.tmp', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.lnk', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.zip', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.dll', '.dll', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.manifest', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.DM1', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.UD', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.css', '.cxx', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.dct', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.rdl', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.data', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.rptproj', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.rds', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.database', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.dtproj', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.sqm', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.BAK', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.csv', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.chm', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.mrc', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.vspscc', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.subproj', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.org', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.asmmeta', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.jar', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xaml', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.grxml', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.baml', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.msi', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.hlp', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.lng', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.cls', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.vbp', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.bas', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.rdlc', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.rpt', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.deploy', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.datasource', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.compiled', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.wri', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.pcap', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.txt', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.sqlsuo', null, 0, NULL, NULL, NULL, NULL, NULL)"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.gif', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.MDI', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.sln', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.suo', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xsl', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.dat', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.vstemplate', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ico', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.cs', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.SqlDataProvider', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.dnn', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.CSproj', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.webproj', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xsx', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.master', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.scc', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.skin', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.db', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AvailFileTypesUndefined] ([FileType], [SubstituteType], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.cd', null, 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9496 AS DateTime), CAST(0x00009D8B00CB9496 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[ImageTypeCodes] ([ImageTypeCode], [ImageTypeCodeDesc], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.bmp', null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB174 AS DateTime), CAST(0x00009D8B00CBB174 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[ImageTypeCodes] ([ImageTypeCode], [ImageTypeCodeDesc], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.gif', null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB174 AS DateTime), CAST(0x00009D8B00CBB174 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[ImageTypeCodes] ([ImageTypeCode], [ImageTypeCodeDesc], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ico', null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB174 AS DateTime), CAST(0x00009D8B00CBB174 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[ImageTypeCodes] ([ImageTypeCode], [ImageTypeCodeDesc], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.jpg', null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB174 AS DateTime), CAST(0x00009D8B00CBB174 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[ImageTypeCodes] ([ImageTypeCode], [ImageTypeCodeDesc], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.png', null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB174 AS DateTime), CAST(0x00009D8B00CBB174 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[ImageTypeCodes] ([ImageTypeCode], [ImageTypeCodeDesc], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.tif', null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB174 AS DateTime), CAST(0x00009D8B00CBB174 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[ImageTypeCodes] ([ImageTypeCode], [ImageTypeCodeDesc], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.tiff', null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB174 AS DateTime), CAST(0x00009D8B00CBB174 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[ImageTypeCodes] ([ImageTypeCode], [ImageTypeCodeDesc], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.trf', 'Proprietary document storage format of Documagix processed a an image file using ECM OCR.', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB174 AS DateTime), CAST(0x00009D8B00CBB174 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmAttachmentCode', '<help text here>', 'btnApplyRetentionRule', '@', 0, CAST(0x00009C7B008D50F4 AS DateTime), CAST(0x00009C7B008D4F05 AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmAttachmentCode', '<help text here>', 'btnEncrypt', 'Encrypt Password', 0, CAST(0x00009C7A00D584F0 AS DateTime), CAST(0x00009C7A00D58278 AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmAttachmentCode', '&Update', 'btnUpdate', '&Update', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmAttachmentCode', '<help text here>', 'cbRetention', null, 0, CAST(0x00009C7B008D50F4 AS DateTime), CAST(0x00009C7B008D4F05 AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmAttachmentCode', 'This is the list of available attachment codes.', 'dgAttachmentCode', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmAttachmentCode', '<help text here>', 'Label1', 'Please Select a Retention Rule:', 0, CAST(0x00009C7B008D50F4 AS DateTime), CAST(0x00009C7B008D4F05 AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'btnAddLib', 'Add Content to librar&y', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'btnClipboard', 'Gen SQL ', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'btnCopy', 'Include All Libraries', 0, CAST(0x00009C6F013B8250 AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', 'Press to delete the currently selected search.', 'btnDelSearch', 'Delete Search', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', 'Press this button to get all the file names.', 'btnGetFileNames', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', 'Press this to hide the query window.', 'btnHideQry', 'Hide Query', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', 'Press to select the directory from which to load the files.', 'btnLoadFileDirs', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'btnOpenWorkingDir', 'Content Dir.', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', 'Press this button to paste  the contents of the clipboard into the search line.', 'btnPaste', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', 'Opens the query viewing wndow.', 'btnQryView', 'View Query', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', 'When pressed, the selected Search will be restored as the active search.', 'btnRecallSearch', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'btnRestore', 'R&estore', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', 'Press to save the current search under the selected name.', 'btnSaveSearch', 'Sa&ve Search', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'btnSearch', '&Search', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'btnSel', null, 0, CAST(0x00009C4100C77ACC AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', 'Press this button to perform a spell check on the search line.', 'btnSpellCk', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'Button1', 'Save Screen Settings', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'Button2', 'Button2', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'Button3', 'P', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'Button4', 'C', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', 'This is a dropdown list of the directories.', 'cbDirs', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', 'Determines how the date will be evaluated.', 'cbEvalCreateTime', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', 'Determines how the date will be evaluated.', 'cbEvalWriteTime', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'cbFilename', null, 0, CAST(0x00009C4100C77ACC AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', 'A drop down list of file types.', 'cbFileTypes', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'cbLibrary', 'NOT Master documents .', 0, CAST(0x00009C4300FA3584 AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', 'This is a drop down list of available metadata.', 'cbMeta1', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', 'This is a drop down list of available metadata.', 'cbMeta2', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'cbMeta3', 'Do not change public/private indicator', 0, CAST(0x00009C4300FA3584 AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', 'This is a drop down list of available metadata.', 'cbMeta4', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', 'A list of saved searches.', 'cbSavedDocSearches', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'cbThesaurus', 'AND', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'ckBusiness', '&Business Meaning', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'ckCounts', 'Use Counts', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'ckDays', 'Limit to content created within the last', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'ckEcmConnection', 'R&estore', 0, CAST(0x00009CB8011FDB04 AS DateTime), CAST(0x00009CB8011FD8DA AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'ckIncludeAllLibraries', 'Include All Libraries', 0, CAST(0x00009C6F013B8250 AS DateTime), CAST(0x00009C6F013B810C AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'ckIncludeWeb', 'Include &Web Content', 0, CAST(0x00009C5400B54064 AS DateTime), CAST(0x00009C5400B547DB AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'ckIsPublick', 'Set as Public &Document', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'ckLimitToExisting', '&Limit to current list', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'ckLimitToLib', 'Limit Search to Library', 0, CAST(0x00009C44012CBA54 AS DateTime), CAST(0x00009C44012CBC22 AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'ckMakeIsPublick', 'Set as Public &Document', 0, CAST(0x00009C58010506A8 AS DateTime), CAST(0x00009C58010508B7 AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'ckMakeMasterDoc', 'Set as &Master doc', 0, CAST(0x00009C58010506A8 AS DateTime), CAST(0x00009C58010508B0 AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'ckMasterDoc', 'Set as &Master doc', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'ckMasterOnly', 'Master content  only', 0, CAST(0x00009C4D0101A4A4 AS DateTime), CAST(0x00009C4D0101ABB7 AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'ckMyContentOnly', 'My content only', 0, CAST(0x00009C4D0101A4A4 AS DateTime), CAST(0x00009C4D0101ABB4 AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'ckOverwrite', 'Overwrite', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'ckSearchMasterDocsOnly', 'Master content  only', 0, CAST(0x00009C58010506A8 AS DateTime), CAST(0x00009C580105085C AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'ckSearchMyContentOnly', 'My content only', 0, CAST(0x00009C58010506A8 AS DateTime), CAST(0x00009C5801050855 AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'ckShowDetails', 'Show Search Details', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'ckWeighted', 'Show &Weights', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'dgDoc', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'dgMetaData', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', 'Used to establish the end date.', 'dtLastAccessEnd', 'Saturday', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'dtLastAccessStart', null, 0, CAST(0x00009C5001312FBC AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', 'Select retention date', 'dtLastWriteEnd', 'And', 0, CAST(0x00009CB6010D9610 AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', 'Used to establish the search dates.', 'dtLastWriteStart', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'Label1', 'Search Content For:', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'Label10', 'Thesaurus:', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'Label16', 'ECM Thesaurus Words', 0, CAST(0x00009C410088F7AC AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'Label2', 'Select Retention Rule:', 0, CAST(0x00009C58010AF310 AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'Label3', 'Reset', 0, CAST(0x00009C7700B447F4 AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'Label4', 'File Name', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'Label5', 'Execute', 0, CAST(0x00009CB600E0EF98 AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'Label6', 'File Directory', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'Label7', 'Group Library Assignments', 0, CAST(0x00009C4400C4F9C8 AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'Label8', 'Search Name', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'Label9', 'Metadata Search', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'lblWeightLimit', 'Weight >=:', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'nbrSelectSearch', '20', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'nbrWeightMin', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'Panel1', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'PB', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', 'This is a drop down list of available metadata.', 'rbContacts', null, 0, CAST(0x00009CB600F866A0 AS DateTime), CAST(0x00009CB600F86702 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'rbToDefaultDir', 'To default directory', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39A38 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'rbToOriginalDir', 'Assign To Library:', 0, CAST(0x00009C7800B50A7C AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'rbToSelDir', 'To selected directory', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'Reset', 'Reset', 0, CAST(0x00009C7700B4CD8C AS DateTime), CAST(0x00009C7700B4CA8B AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'SB', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'txtDays', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', 'Enter text here that you expect to match the selected metadata. Wildcards are permissible.', 'txtMetaSearch1', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', 'Enter text here that you expect to match the selected metadata. Wildcards are permissible.', 'txtMetaSearch2', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', 'Enter text here that you expect to match the selected metadata. Wildcards are permissible.', 'txtMetaSearch3', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', 'Enter text here that you expect to match the selected metadata. Wildcards are permissible.', 'txtMetaSearch4', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', 'This is the generated query text.', 'txtQry', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'txtRowCnt', '001', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'txtSearch', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'txtSelDir', 'Currently Defined Groups', 0, CAST(0x00009C4400ACC4E8 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'txtSentTo', null, 0, CAST(0x00009CB600E0EF98 AS DateTime), CAST(0x00009CB600E0EF8E AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'txtThesaurus', 'thoughtful', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmDocSearch', '<help text here>', 'txtVerNo', 'P', 0, CAST(0x00009CB600E35F08 AS DateTime), CAST(0x00009CB600E35E97 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', 'Press to copy thes earch line into the clipboard.', 'btnCopy', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', 'Delete the selected Search', 'btnDelSearch', 'Delete Search', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', '<help text here>', 'btnExecuteExpire', 'Execute', 0, CAST(0x00009CB6010183D4 AS DateTime), CAST(0x00009CB60101834B AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', 'Press to Generate the Sql stmt and put it into the clipboard.', 'btnGenSql', 'Gen Sql', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', 'Append selected items to the selected Library', 'btnLibrarySave', 'Add to Library', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', 'Press to paste the clipboard into the search line.', 'btnPaste', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', 'Recall selected Search items', 'btnRecall', 'Recall Search', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', '<help text here>', 'btnReset', 'Reset', 0, CAST(0x00009C7700C11358 AS DateTime), CAST(0x00009C7700C10F7F AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', 'Restore the selected items', 'btnRestore', 'Restore', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', 'Save the selected Search', 'btnSave', 'Save Search', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', 'Excute the Search', 'btnSearch', 'Search', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', '<help text here>', 'btnSearchFrom', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', 'Press to spell check the search line.', 'btnSpellCk', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', 'Test Display: this will go away', 'Button1', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', 'Open the Working Dir.', 'Button2', 'Working Dir.', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', '<help text here>', 'Button3', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', '<help text here>', 'Button4', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', '<help text here>', 'Button5', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', '<help text here>', 'Button6', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', '<help text here>', 'Button7', 'S', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', '<help text here>', 'Button8', 'P', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', '<help text here>', 'Button9', 'C', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', 'This will contain a drop down list of CC addresses', 'cbCCaddr', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', '<help text here>', 'cbDateSelection', 'Apply Selected License', 0, CAST(0x00009C5100DDDAEC AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', 'This will contain a drop down list of searchable email folders', 'cbFolderFilter', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', 'This will contain a drop down list of searchable email from addresses', 'cbFromAddr', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', 'This will contain a drop down list of searchable email from names', 'cbFromName', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', 'A list of available libraries.', 'cbLibrary', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', 'This will contain a drop down list of saved email searches.', 'cbSavedEmailSearches', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', '<help text here>', 'cbThesaurus', 'AND', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', 'This will contain a drop down list of searchable email to Addresses.', 'cbToAddr', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', 'This will contain a drop down list of searchable email to names.', 'cbToName', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', '<help text here>', 'ckBusiness', 'Do not change public/private indicator', 0, CAST(0x00009C4300FA3584 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', 'Check Count to have the number of rows returned calculated.', 'ckCount', 'Check Count', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', '<help text here>', 'ckCreationDate', 'Creation', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', '<help text here>', 'ckDays', 'Created/sent in last', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', '<help text here>', 'ckEcmConnection', 'Check Server DB Conn', 0, CAST(0x00009CB701176EC4 AS DateTime), CAST(0x00009CB701177B24 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', '<help text here>', 'ckIncludeAllLibraries', 'Include All Libraries', 0, CAST(0x00009C6F013B12FC AS DateTime), CAST(0x00009C6F013B11A1 AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', 'Check to Search Email Attachments as part of the search.', 'ckIncludeAttachments', 'Search Email Attachments', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', '<help text here>', 'ckIsPublic', 'Is Public Email', 0, CAST(0x00009C430167FFC4 AS DateTime), CAST(0x00009C430168008C AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', 'Limit to current list of found emails.', 'ckLimitToExisting', 'Limit to current list', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', '<help text here>', 'ckLimitToLib', 'Limit Search to Library', 0, CAST(0x00009C44012E94F0 AS DateTime), CAST(0x00009C44012E9640 AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', '<help text here>', 'ckMyContentOnly', 'My content only', 0, CAST(0x00009C4E00F01C5C AS DateTime), CAST(0x00009C4E00F02200 AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', 'Return only those that have attachments', 'ckOnlyWithAttach', 'Return only those that have attachments', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', '<help text here>', 'ckReceivedTime', 'Received', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', '<help text here>', 'ckSentDate', 'Sent', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', 'Show Search Details window', 'ckShowDetails', 'Show Search Details', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', 'Show Weights of the search and order by the weighted return value.', 'ckWeighted', 'Show Weights', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', 'The list of associated attachments for the selected email.', 'dgAttachments', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', 'The search return results.', 'dgSearch', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', 'This is the start date.', 'dtMailDateEnd', 'Friday', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', 'This is the end date.', 'dtMailDateStart', 'Friday', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', 'This is the label for the Search by FROM email addr.', 'Label1', 'FROM email addr:', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', '<help text here>', 'Label10', '&Goto Library Items Screen', 0, CAST(0x00009C3F011E2E1C AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', '<help text here>', 'Label11', 'Thesaurus:', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', '<help text here>', 'Label12', 'Where Contains', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', '<help text here>', 'Label13', 'CC/BCC Contains characters:', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', '<help text here>', 'Label14', 'CC or BCC:', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', '<help text here>', 'Label15', 'Folder Filter:', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', '<help text here>', 'Label16', 'days.', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', '<help text here>', 'Label2', 'FROM Name:', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', '<help text here>', 'Label3', 'or where contains the phrase:', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', '<help text here>', 'Label4', 'or where contains the phrase:', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', '<help text here>', 'Label5', 'Email Subject:', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', '<help text here>', 'Label6', 'Search by MAIL Date:', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', '<help text here>', 'Label7', 'or where contains the phrase:', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', '<help text here>', 'Label8', 'or where contains the phrase:', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', '<help text here>', 'Label9', 'TO Name:', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', '<help text here>', 'lbGroups', null, 0, CAST(0x00009CB8014610A8 AS DateTime), CAST(0x00009CB801460D4E AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', '<help text here>', 'lblWeightLimit', 'show items with weight greater >=', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', '<help text here>', 'nbrSelectSearch', '1', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', '<help text here>', 'nbrWeightMin', '0', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', '<help text here>', 'PB', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', 'Check to searh ALL Emails that are shared, public, or in a library you have access to.', 'rbAllEmails', 'All Emails', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', 'Check to searh only My Emails', 'rbMyEmails', 'My Emails', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', 'Check to search Received  items', 'rbRx', 'Received', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', '<help text here>', 'rbSent', null, 0, CAST(0x00009C410088F7AC AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', 'Status Bar', 'SB', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', 'Warning messges.', 'SB_Warning', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', 'Status bar', 'SB2', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', 'This is the search text for the subject and the body of the email.', 'txtBody', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', 'This searches the CC`d list of people for the email and is wildcard able.', 'txtCCPhrase', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', '<help text here>', 'txtDays', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', 'This searches the from address of the email and is wildcard able.', 'txtFromAddr', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', 'This searches the from name  of the email and is wildcard able.', 'txtFromName', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', '<help text here>', 'txtInflection', null, 0, CAST(0x00009CB600E35F08 AS DateTime), CAST(0x00009CB600E35E68 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', 'The generated Qry', 'txtQry', 'The Qry', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', '<help text here>', 'txtSearch', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', 'This searches the subject of the email and is wildcard able.', 'txtSubject', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', '<help text here>', 'txtThesaurus', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', 'This searches the to address of the email and is wildcard able.', 'txtToAddr', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', 'This searches the to name  of the email and is wildcard able.', 'txtToName', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmEmailSearch', '<help text here>', 'txtVerNo', null, 0, CAST(0x00009CB801460F7C AS DateTime), CAST(0x00009CB801460C4C AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmGrantContentToUsers', '<help text here>', 'btnGrant', '&Assign', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmGrantContentToUsers', '<help text here>', 'btnHelp01', '?', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmGrantContentToUsers', '<help text here>', 'btnRemove', '&Remove', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmGrantContentToUsers', '<help text here>', 'cbLibrary', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmGrantContentToUsers', '<help text here>', 'clLibUsersOnly', 'Library Users', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmGrantContentToUsers', '<help text here>', 'dgUsers', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmGrantContentToUsers', '<help text here>', 'Label1', 'Current Library', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmGrantContentToUsers', 'Press this o Grant Group AccessTo Library', 'Label7', 'Add Users to &Group', 0, CAST(0x00009CB600FE8A1C AS DateTime), CAST(0x00009CB600FE8A29 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmGrantContentToUsers', '<help text here>', 'ProgressBar1', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmGrantContentToUsers', '<help text here>', 'sb', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmGroup', 'Press this to add the new record.', 'BtnAdd', '&Add', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmGroup', 'Press this o Grant Group AccessTo Library', 'btnAddGroupToLibrary', 'Grant Group AccessTo Library', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmGroup', 'Press to Add Users to Group', 'btnAddToGroup', 'Add Users to &Group', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmGroup', 'Press to Delete the selected.', 'btnDelete', '&Delete', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmGroup', '<help text here>', 'btnExecuteExpire', 'Execute', 0, CAST(0x00009CB800EB4F10 AS DateTime), CAST(0x00009CB800EB4CC1 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmGroup', '<help text here>', 'btnGenSql', 'Export', 0, CAST(0x00009CB60112D184 AS DateTime), CAST(0x00009CB60112D146 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmGroup', 'Displays a second status so that the first status bar is not over written.', 'btnRefreshLibrary', null, 0, CAST(0x00009CB6010CAE08 AS DateTime), CAST(0x00009CB6010CAD4C AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmGroup', 'Press to Remove users from Group', 'btnRemove', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmGroup', 'Remove Group Access From Library', 'btnRemoveGroupFromLibrary', 'Remove Group Access From Library', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmGroup', 'Press to save your current changes.', 'btnSave', 'Sa&ve', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmGroup', '<help text here>', 'cbLibrary', null, 0, CAST(0x00009CB6010359C0 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmGroup', 'Check this to show all users.', 'ckBoxShowAllUsers', 'ShowAll Users for Selection', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmGroup', 'Displays a second status so that the first status bar is not over written.', 'dgGrpUsers', null, 0, CAST(0x00009CB70125BA88 AS DateTime), CAST(0x00009CB70125B821 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmGroup', 'Use all of these words in the search', 'dgUsers', ' ecm', 0, CAST(0x00009CB70125BA88 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmGroup', '<help text here>', 'Label1', 'Currently Defined Groups', 0, CAST(0x00009C4400ACC4E8 AS DateTime), CAST(0x00009C4400ACC536 AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmGroup', 'Group Assigned Users', 'Label2', 'Group Assigned Users', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmGroup', '<help text here>', 'Label3', 'Group Library Assignments', 0, CAST(0x00009C4400C4F9C8 AS DateTime), CAST(0x00009C4400C4F970 AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmGroup', '<help text here>', 'lbAssignedLibs', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmGroup', 'Status bar User', 'lbGroups', null, 0, CAST(0x00009CB600FBEE24 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmGroup', 'Displays a second status so that the first status bar is not over written.', 'rbToSelDir', null, 0, CAST(0x00009CB800F8FB74 AS DateTime), CAST(0x00009CB800F8F865 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmGroup', 'Displays the status of the last action.', 'SB', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmGroup', 'Displays a second status so that the first status bar is not over written.', 'SB2', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmGroup', 'Status bar User', 'SBUser', null, 0, CAST(0x00009CB6010FA43C AS DateTime), CAST(0x00009CB6010FA48B AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmGroup', '<help text here>', 'txtParmVal', null, 0, CAST(0x00009CB800EB4F10 AS DateTime), CAST(0x00009CB800EB4CA0 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmGroup', '<help text here>', 'txtUserGroup', 'Include', 0, CAST(0x00009C8100DC6770 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmHelpEditor', '<help text here>', 'btnCkConnection', 'Check Inet Conn', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmHelpEditor', '<help text here>', 'btnExecuteExpire', 'Execute', 0, CAST(0x00009CB600DD034C AS DateTime), CAST(0x00009CB600DD02B1 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmHelpEditor', 'press to Export the data as SQL Insert statements.', 'btnExport', 'Export', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmHelpEditor', 'Get Reusable text and populate the help text field.', 'btnGetReusable', 'Get Reusable', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmHelpEditor', '<help text here>', 'btnMakeSelectedVisible', 'Make All Selected Visible', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmHelpEditor', 'Press this button to paste  the contents of the clipboard into the search line.', 'btnPaste', null, 0, CAST(0x00009CB600E2F464 AS DateTime), CAST(0x00009CB600E2F3E0 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmHelpEditor', '<help text here>', 'btnPullFromServer', 'Download Help', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmHelpEditor', '<help text here>', 'btnPushToServer', null, 0, CAST(0x00009C3C00D789BC AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmHelpEditor', 'Set  Reusable text for later use.', 'btnSetReusable', 'Set Reusable', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmHelpEditor', 'Press to Update help text.', 'btnUpdate', '&Update', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmHelpEditor', 'Status bar User', 'btnUpdateAndMakeVisible', null, 0, CAST(0x00009CB701176EC4 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmHelpEditor', '<help text here>', 'Button1', 'Synchronize Changes Between Server and Local ', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmHelpEditor', 'Drop down list of all screens defiend to thte help system.', 'cbScreens', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmHelpEditor', '<help text here>', 'ckEcmConnection', 'Check Server DB Conn', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmHelpEditor', 'check this to Display Help Item to the user.', 'ckHelpEnabled', 'Display Help Item', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmHelpEditor', '<help text here>', 'dgGrpUsers', null, 0, CAST(0x00009CB701176EC4 AS DateTime), CAST(0x00009CB701177B1B AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmHelpEditor', '<help text here>', 'dgHelp', 'Do not change', 0, CAST(0x00009C4300FA3584 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmHelpEditor', '<help text here>', 'Label3', 'Apply Selected License', 0, CAST(0x00009C5100DDDAEC AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmHelpEditor', '<help text here>', 'lbGroups', null, 0, CAST(0x00009CB600DE17DC AS DateTime), CAST(0x00009CB600DE17B6 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmHelpEditor', '<help text here>', 'lblBtnText', 'Delete Profile', 0, CAST(0x00009CB600E0EF98 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmHelpEditor', 'The currently selected control displays here.', 'lblCurrControl', 'lblCurrControl', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmHelpEditor', 'The currently selected form name displays here.', 'lblCurrForm', 'lblCurrForm', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmHelpEditor', '<help text here>', 'PB', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmHelpEditor', 'Check to Show Active help text.', 'rbShowActive', 'Show Active', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmHelpEditor', 'Check to Show all Controls within the selected screen.', 'rbShowAll', 'Show all Controls', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmHelpEditor', 'Check to show all Inactive (those with no help text defined).', 'rbShowInactive', 'Show Inactive', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmHelpEditor', '<help text here>', 'rtHelptext', 'Include &Web Content', 0, CAST(0x00009C5400B54064 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmHelpEditor', 'Status bar', 'SB', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmHelpEditor', 'Delete the selected library', 'SB_Warning', '&Delete', 0, CAST(0x00009CB7009BC238 AS DateTime), CAST(0x00009CB7009BC0C0 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmHelpEditor', 'This holds the reusable text and is editable.', 'txtReusable', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLibrary', 'Add the new library', 'BtnAdd', '&Add', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLibrary', 'Delete the selected library', 'btnDelete', '&Delete', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLibrary', '<help text here>', 'btnTransfer', '&Goto Library Items Screen', 0, CAST(0x00009C3F011E2E1C AS DateTime), CAST(0x00009C3F011E31AC AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLibrary', '<help text here>', 'ckEcmConnection', 'Check Server DB Conn', 0, CAST(0x00009CB8012A7FA0 AS DateTime), CAST(0x00009CB8012A7D5F AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLibrary', 'Check to turn Public (On/Off)', 'ckIsPublic', 'Public (On/Off)', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLibrary', 'Make new Library  Public', 'ckNewLibPublic', 'Make new Library  Public', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLibrary', '<help text here>', 'dgGrpUsers', null, 0, CAST(0x00009CB600E0EF98 AS DateTime), CAST(0x00009CB600E0EF64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLibrary', '<help text here>', 'Label1', 'User Login ID', 0, CAST(0x00009CB6010182A8 AS DateTime), CAST(0x00009CB6010182E4 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLibrary', '<help text here>', 'lbGroups', null, 0, CAST(0x00009CB800ED588C AS DateTime), CAST(0x00009CB800ED55DF AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLibrary', 'List box of current libraries.', 'lbLibrary', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLibrary', 'Status bar and shows the success or failure of events.', 'SB', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLibrary', '<help text here>', 'txtLibrary', null, 0, CAST(0x00009C9500B638D4 AS DateTime), CAST(0x00009C9500B68D11 AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLibrary', '<help text here>', 'txtParmVal', null, 0, CAST(0x00009CB8011DC378 AS DateTime), CAST(0x00009CB8011DC093 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLibrary', 'Displays the user group', 'txtUserGroup', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLibraryMgt', 'Open the Lib Management screen', 'btnAddLib', 'Open Lib Mgt.', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLibraryMgt', 'Add Group to Library', 'btnAssignGroup', 'Add Group to Library', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLibraryMgt', '<help text here>', 'btnExecuteExpire', 'Execute', 0, CAST(0x00009CB6010FA568 AS DateTime), CAST(0x00009CB6010FA4B1 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLibraryMgt', 'Define Library Users', 'btnLibUsers', 'Define Library Users', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLibraryMgt', 'Open the Group Mgt. screen', 'btnNewGroup', 'Open Group Mgt.', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLibraryMgt', 'Refresh the Group List', 'btnRefreshGRps', '&Refresh Group List', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLibraryMgt', 'Refresh the Library List', 'btnRefreshLibCombo', 'Refresh Library &List', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLibraryMgt', 'Remove the selected Group', 'btnRemoveGroup', 'Remove Group', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLibraryMgt', 'Remove the selected Item(s)', 'btnRemoveItem', 'Remove Item(s)', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLibraryMgt', 'Restore the selected Items', 'btnRestore', 'Restore Items', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLibraryMgt', 'Open Restored Emails Dir', 'btnWorkingDir', 'Open Restored Emails Dir', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLibraryMgt', 'Open Restored Content Dir', 'btnWorkingDirDocs', 'Open Restored Content Dir', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLibraryMgt', 'This will contain a drop down list of groups', 'cbGroups', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLibraryMgt', 'This will contain a drop down list oflibraries', 'cbLibrary', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLibraryMgt', 'The assigned members', 'dgAssigned', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLibraryMgt', 'The assigned group users', 'dgGrpUsers', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLibraryMgt', 'The assigned library items', 'dgLibItems', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLibraryMgt', '<help text here>', 'Label1', 'Select Library', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLibraryMgt', '<help text here>', 'Label2', 'Assigned User Groups', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLibraryMgt', '<help text here>', 'Label3', 'Selected User Group:', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLibraryMgt', '<help text here>', 'Label4', 'Group`s Users', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLibraryMgt', '<help text here>', 'lbGroups', null, 0, CAST(0x00009CB701176EC4 AS DateTime), CAST(0x00009CB701177B0D AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLibraryMgt', 'Displays the progress of ongoing updates', 'PB', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLibraryMgt', 'Status bar', 'SB', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLibraryMgt', 'Open Restored Content Dir', 'selDir', 'Open Restored Content Dir', 0, CAST(0x00009CB800F8FB74 AS DateTime), CAST(0x00009CB800F8F865 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLicense', '<help text here>', 'btnApplySelLic', 'Apply Selected License', 0, CAST(0x00009C5100DDDAEC AS DateTime), CAST(0x00009C5100DDDBCE AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLicense', '<help text here>', 'btnDisplay', 'Show License Rules', 0, CAST(0x00009C3A01413C54 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLicense', '<help text here>', 'btnGetfile', 'Find License File', 0, CAST(0x00009C3A01413C54 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLicense', '<help text here>', 'btnGetServers', 'Get Server Names', 0, CAST(0x00009C5001312FBC AS DateTime), CAST(0x00009C5001313196 AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLicense', '<help text here>', 'btnLoadFile', 'Load License File', 0, CAST(0x00009C3A01413C54 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLicense', '<help text here>', 'btnPasteLicense', 'Apply License from Textbox', 0, CAST(0x00009C3A01413C54 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLicense', '<help text here>', 'btnRemote', 'Fetch Available Licenses from ECM License Server', 0, CAST(0x00009C5001312FBC AS DateTime), CAST(0x00009C5001313196 AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLicense', '<help text here>', 'cbServers', null, 0, CAST(0x00009C5001312FBC AS DateTime), CAST(0x00009C5001313197 AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLicense', '<help text here>', 'dgLicense', null, 0, CAST(0x00009C50014EE78C AS DateTime), CAST(0x00009C50014EE8F4 AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLicense', '<help text here>', 'Label1', 'Select Repository Server Name', 0, CAST(0x00009C5001312FBC AS DateTime), CAST(0x00009C5001313197 AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLicense', '<help text here>', 'Label2', 'Please Enter Your Assigned Customer ID:', 0, CAST(0x00009C5001312FBC AS DateTime), CAST(0x00009C5001313195 AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLicense', '<help text here>', 'SB', null, 0, CAST(0x00009C3A01413C54 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLicense', '<help text here>', 'txtCompanyID', null, 0, CAST(0x00009C5001312FBC AS DateTime), CAST(0x00009C5001313195 AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLicense', '<help text here>', 'txtFqn', null, 0, CAST(0x00009C3A01413C54 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLicense', '<help text here>', 'txtLicense', null, 0, CAST(0x00009C3A01413C54 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLoadProfile', '<help text here>', 'addFileTypes', 'Add Selected Filetype to Profile', 0, CAST(0x00009C4100C77ACC AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLoadProfile', '<help text here>', 'btnAdd', 'Add New Profile', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLoadProfile', '<help text here>', 'btnDelProfile', 'Delete Profile', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLoadProfile', 'Press this button to paste  the contents of the clipboard into the search line.', 'btnPaste', null, 0, CAST(0x00009CB600F9FE70 AS DateTime), CAST(0x00009CB600F9FDB9 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLoadProfile', '<help text here>', 'btnRemove', 'Remove Selected Filetype from Profile', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLoadProfile', '<help text here>', 'btnUpdate', 'Update Profile', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLoadProfile', 'Status Bar', 'cbFolderFilter', null, 0, CAST(0x00009CB800EADFBC AS DateTime), CAST(0x00009CB800EADD2B AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLoadProfile', 'The display of currently defined proifile elements.', 'dgFileTypes', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLoadProfile', '<help text here>', 'Label1', 'Profile Assigned Filetypes', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLoadProfile', '<help text here>', 'Label2', 'Profiles', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLoadProfile', '<help text here>', 'Label3', 'Available File Types', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLoadProfile', '<help text here>', 'Label4', 'Profile Name:', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLoadProfile', '<help text here>', 'Label5', 'Profile Description:', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLoadProfile', '<help text here>', 'Label6', 'Delete Profile', 0, CAST(0x00009CB600E0EF98 AS DateTime), CAST(0x00009CB600E0EF8E AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLoadProfile', '<help text here>', 'lbAssignments', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLoadProfile', '<help text here>', 'lbProfiles', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLoadProfile', 'Status Bar', 'SB', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLoadProfile', 'Profile description', 'txtProfileDesc', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmLoadProfile', 'Profile name', 'txtProfileName', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('FrmMDIMain', '<help text here>', 'MenuStrip', 'MenuStrip', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('FrmMDIMain', '<help text here>', 'StatusStrip', 'StatusStrip', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('FrmMDIMain', '<help text here>', 'ToolStrip', 'ToolStrip', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmMissingFileTypes', 'Press to assign Assign', 'btnAssign', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmMissingFileTypes', 'Reapply All', 'btnReapply', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmMissingFileTypes', 'Press to Remove selected', 'btnRemove', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmMissingFileTypes', 'The list of available file types.', 'cbAvailFileTypes', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmMissingFileTypes', 'The list of assigned  file types.', 'dgAssignedTypes', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmMissingFileTypes', 'Status bar', 'SB', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmMstrMaint', 'Press to apply changes', 'btnApply', '&Apply', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmMstrMaint', 'List of users', 'cbUsers', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmMstrMaint', 'Select retention date', 'ckEcmThesaurus', 'And', 0, CAST(0x00009CB6010D9610 AS DateTime), CAST(0x00009CB6010D95FD AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmMstrMaint', 'Check to make Make Permenant', 'ckMakePerm', 'Make Permanent', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmMstrMaint', 'Check to resassign', 'ckReassign', 'Reassign Ownership', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmMstrMaint', 'Check to Set Retention Date', 'ckSetRetentionDate', 'Set Retention Date', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmMstrMaint', 'Select retention date', 'dtRetentionDate', 'Wednesday', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmMstrMaint', '<help text here>', 'Label1', 'Available Users', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmMstrMaint', 'Check to resassign', 'nbrWeightMin', 'Reassign Ownership', 0, CAST(0x00009CB600F9FD44 AS DateTime), CAST(0x00009CB600F9FD69 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmMstrMaint', 'Progess Bar', 'PB', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmMstrMaint', 'Press to Make Master', 'rbMaster', 'Make Master', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmMstrMaint', 'No Master', 'rbNoMaster', 'No Master', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmMstrMaint', 'No Change', 'rbNoMasterChange', 'No Change', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmMstrMaint', 'No Change', 'rbNoPublicChange', 'No Change', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmMstrMaint', 'Check to make Private', 'rbPrivate', 'Private', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmMstrMaint', '<help text here>', 'rbPublic', 'Disable Exchange', 0, CAST(0x00009C7A00C735A8 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmMstrMaint', '<help text here>', 'SB', '&Goto Library Items Screen', 0, CAST(0x00009C3F011E2E1C AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmMstrMaint', 'Warning Status bar', 'SB2', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickArchive', 'Press to Update Metadata', 'btnApplyMetadata', 'Update Metadata', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickArchive', 'Press to Quick Archive', 'btnQuickArch', 'Quick Archive', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickArchive', 'Press to Add a Quick Reference', 'btnQuickRefAdd', 'Add Quick Ref.', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickArchive', 'Press to save all', 'btnSaveAll', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickArchive', 'Select Files to Archive', 'btnSelectFiles', 'Select one or more Files to Archive.', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickArchive', 'Press to reinitialize the directory and update all files.', 'btnUpdateAllFilesInSelectedDir', 'Re-Init Dir', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickArchive', 'Del Quick Reference', 'Button1', 'Del Quick Ref.', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickArchive', 'Press to Remove File', 'Button2', 'Remove File', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickArchive', 'Press to Remove Directory', 'Button3', 'Remove Dir', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickArchive', '<help text here>', 'cbLibrary', null, 0, CAST(0x00009C7800B50A7C AS DateTime), CAST(0x00009C7800B50695 AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickArchive', '<help text here>', 'cbMetadata', null, 0, CAST(0x00009C7800B50A7C AS DateTime), CAST(0x00009C7800B50695 AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickArchive', 'Select reference name from this list', 'cbRefName', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickArchive', '<help text here>', 'cbRetention', null, 0, CAST(0x00009C570142F620 AS DateTime), CAST(0x00009C57014384F7 AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickArchive', '<help text here>', 'ckArchiveBit', 'Skip if archive bit is ON', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C390167F33C AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickArchive', '<help text here>', 'Label1', 'Author Search Name', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickArchive', '<help text here>', 'Label2', 'Key Words', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickArchive', '<help text here>', 'Label3', 'Archived Senders', 0, CAST(0x00009CB600EF8FBC AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickArchive', '<help text here>', 'Label4', 'Select Retention Rule:', 0, CAST(0x00009C58010AF310 AS DateTime), CAST(0x00009C58010AF481 AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickArchive', '<help text here>', 'Label5', 'Quick Reference Name', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickArchive', '<help text here>', 'Label6', 'Drag`nullDrop Here', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickArchive', '<help text here>', 'Label7', 'Assign Specific Metadata Tag:', 0, CAST(0x00009C7800B50A7C AS DateTime), CAST(0x00009C7800B50695 AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickArchive', '<help text here>', 'Label8', 'Assign To Library:', 0, CAST(0x00009C7800B50A7C AS DateTime), CAST(0x00009C7800B50695 AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickArchive', 'A list of directories', 'lbDirs', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickArchive', 'A list of files', 'lbFiles', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickArchive', '<help text here>', 'rbMstrNoChange', 'Do not change', 0, CAST(0x00009C4300FA3584 AS DateTime), CAST(0x00009C4300FA36F9 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickArchive', '<help text here>', 'rbMstrNot', 'NOT Master documents .', 0, CAST(0x00009C4300FA3584 AS DateTime), CAST(0x00009C4300FA3728 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickArchive', '<help text here>', 'rbMstrYes', 'Master documents.', 0, CAST(0x00009C4300FA3584 AS DateTime), CAST(0x00009C4300FA3728 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickArchive', '<help text here>', 'rbNochange', 'Do not change', 0, CAST(0x00009C4300FA3584 AS DateTime), CAST(0x00009C4300FA3724 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickArchive', '<help text here>', 'rbPrivate', 'Make documents private.', 0, CAST(0x00009C4300FA3584 AS DateTime), CAST(0x00009C4300FA3724 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickArchive', '<help text here>', 'rbPublic', 'Make documents public.', 0, CAST(0x00009C4300FA3584 AS DateTime), CAST(0x00009C4300FA3725 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickArchive', 'Status bar', 'SB', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickArchive', 'The author`s name', 'txtAuthorName', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickArchive', 'Enter a full description here', 'txtDescription', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickArchive', 'Enter all searchable keywords here', 'txtKeyWords', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickArchive', '<help text here>', 'txtMetadata', null, 0, CAST(0x00009C7800B50A7C AS DateTime), CAST(0x00009C7800B50695 AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', 'Press this to copy the contents of the search line into the clipboard.', 'btnCopy', 'C', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', '<help text here>', 'btnDelete', 'Delete', 0, CAST(0x00009C3A01429158 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', '<help text here>', 'btnExecuteExpire', 'Execute', 0, CAST(0x00009CB600E35F08 AS DateTime), CAST(0x00009CB600E35EA5 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', '<help text here>', 'btnGenSql', 'Gen Sql', 0, CAST(0x00009C3A01429158 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', '<help text here>', 'btnLibMgt', 'Library Management', 0, CAST(0x00009C3A01429158 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', '<help text here>', 'btnLibrary', 'Add to Library', 0, CAST(0x00009C3A01429158 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', 'Press to paste the contens of the clipboard into the search line.', 'btnPaste', 'P', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', '<help text here>', 'btnRefreshLibrary', 'Refresh', 0, CAST(0x00009C3A01429158 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', '<help text here>', 'btnReset', 'Reset', 0, CAST(0x00009C7700B447F4 AS DateTime), CAST(0x00009C7700B44555 AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', '<help text here>', 'btnRestore', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', 'Enter your ECM Library login password here.', 'btnSearch', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', 'Press to spell check the contents of your search line.', 'btnSpellCk', 'S', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', '<help text here>', 'btnTestLibSearch', 'Test Lib Search', 0, CAST(0x00009C6F01615584 AS DateTime), CAST(0x00009C6F0161536D AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', 'The assigned group users', 'btnWorkingDir', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', '<help text here>', 'btnWorkingDirDocs', 'Restored Content Dir', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', 'The startup parameters', 'Button1', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', '<help text here>', 'Button2', 'Save', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', '<help text here>', 'Button3', 'Restore', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', 'Delete  the user', 'cbLibrary', '&Remove', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', '<help text here>', 'cbSavedDocSearches', null, 0, CAST(0x00009CB60113E164 AS DateTime), CAST(0x00009CB60113E189 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', '<help text here>', 'cbThesaurus', 'AND', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', '<help text here>', 'ckBusiness', 'Business Meaning', 0, CAST(0x00009C3A01429158 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', '<help text here>', 'ckCountOnly', 'AND none of these words', 0, CAST(0x00009CB601055400 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', '<help text here>', 'ckIncludeAllLibraries', 'Include All Libraries', 0, CAST(0x00009C6F011CD594 AS DateTime), CAST(0x00009C6F011CD47A AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', '<help text here>', 'ckIncludeWeb', 'Include &Web Content', 0, CAST(0x00009C5400B497A4 AS DateTime), CAST(0x00009C5400B49E4F AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', '<help text here>', 'ckIsMasterShow', 'Is Master', 0, CAST(0x00009C5400B497A4 AS DateTime), CAST(0x00009C5400B49E4E AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', '<help text here>', 'ckIsWebShow', 'Is Web Content', 0, CAST(0x00009C5400B497A4 AS DateTime), CAST(0x00009C5400B49E4D AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', '<help text here>', 'ckLimitToExisting', 'Generate Search Query', 0, CAST(0x00009CB60112D184 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', '<help text here>', 'ckLimitToLib', 'Limit Search to Library', 0, CAST(0x00009C4401250F70 AS DateTime), CAST(0x00009C4401251113 AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', '<help text here>', 'ckMasterOnly', '&Master content  only', 0, CAST(0x00009C4C00AFE09C AS DateTime), CAST(0x00009C4C00AFE75B AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', '<help text here>', 'ckMyContentOnly', 'My &content only', 0, CAST(0x00009C4C00AFE09C AS DateTime), CAST(0x00009C4C00AFE75C AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', '<help text here>', 'ckOverWrite', null, 0, CAST(0x00009C3C00D789BC AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', '<help text here>', 'ckShowDetails', 'Show &Details', 0, CAST(0x00009C3A01429158 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', '<help text here>', 'ckWeighted', null, 0, CAST(0x00009CB600DD0220 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', '<help text here>', 'dgGlobalSearch', null, 0, CAST(0x00009C3A01429158 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', '<help text here>', 'isPublicShow', 'Is Public', 0, CAST(0x00009C5400B497A4 AS DateTime), CAST(0x00009C5400B49E4F AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', '<help text here>', 'Label1', 'Label1', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', '<help text here>', 'Label2', 'Quick search does not search email attachments and only on content within an email or file.', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', 'Status bar', 'Label3', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', '<help text here>', 'Label4', 'Restored Content Dir', 0, CAST(0x00009CB600F866A0 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', '<help text here>', 'lbGroups', null, 0, CAST(0x00009CB800F9D7C4 AS DateTime), CAST(0x00009CB800F9D583 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', 'Press this button to get all the file names.', 'lblWeightLimit', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', '<help text here>', 'nbrSelectSearch', 'Available Users', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', '<help text here>', 'nbrWeightMin', 'Save Screen Settings', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', '<help text here>', 'PB', null, 0, CAST(0x00009C3A01429158 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', '<help text here>', 'rbAll', 'All Content', 0, CAST(0x00009C3A01429158 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', '<help text here>', 'rbDocs', 'Documents', 0, CAST(0x00009C3A01429158 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', '<help text here>', 'rbEmails', 'Emails', 0, CAST(0x00009C3A01429158 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', '<help text here>', 'rbNoMaster', 'Restored Content Dir', 0, CAST(0x00009CB600F866A0 AS DateTime), CAST(0x00009CB600F866B7 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', '<help text here>', 'rbToDefaultDir', 'To default directory', 0, CAST(0x00009C3A01429158 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', '<help text here>', 'rbToOriginalDir', 'To original directory', 0, CAST(0x00009C3A01429158 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', '<help text here>', 'rbToSelDir', 'Delete Selected Items', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', '<help text here>', 'SB', 'Notices', 0, CAST(0x00009C3A01429158 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', 'Status bar User', 'SBUser', null, 0, CAST(0x00009CB701176EC4 AS DateTime), CAST(0x00009CB701177AEC AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', '<help text here>', 'selDir', 'Select Director&y', 0, CAST(0x00009C3A01429158 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', '<help text here>', 'TempGrid', null, 0, CAST(0x00009C3A01429158 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', '<help text here>', 'txtContents', null, 0, CAST(0x00009C3A01429158 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', 'Use these terms as {inflected} not infected terms.', 'txtInflection', null, 0, CAST(0x00009CB80104C508 AS DateTime), CAST(0x00009CB80104C256 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', 'Enter text here that you expect to match the selected metadata. Wildcards are permissible.', 'txtMetaSearch2', null, 0, CAST(0x00009CB801460F7C AS DateTime), CAST(0x00009CB801460C34 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', '<help text here>', 'txtSearch', null, 0, CAST(0x00009C3A01429158 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', '<help text here>', 'txtSelDir', null, 0, CAST(0x00009C3A01429158 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', '<help text here>', 'txtThesaurus', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmQuickSearch', '<help text here>', 'txtVerNo', null, 0, CAST(0x00009CB600DD0220 AS DateTime), CAST(0x00009CB600DD0278 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'btnActive', 'Archived', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'btnAddDir', 'Include Dir', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'btnAddFiletype', '+', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'btnAddProfile', '@', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'btnArchiveContent', 'Archive Content', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'btnArchiveDirectories', 'Archive &Content', 0, CAST(0x00009C7B00874E48 AS DateTime), CAST(0x00009C7B00874C20 AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'btnArchiveExchangeEmails', 'Archive &Exchange Emails', 0, CAST(0x00009C7B00874E48 AS DateTime), CAST(0x00009C7B00874C29 AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'btnArchiveOutlookEmail', 'Archive &Outlook Emails', 0, CAST(0x00009C7B00874E48 AS DateTime), CAST(0x00009C7B00874C29 AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'btnArchNow', 'Once &Now', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'btnDeleteEmailEntry', 'Deactivate', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'btnExchangePop', 'Exchange', 0, CAST(0x00009C7A00CF99B4 AS DateTime), CAST(0x00009C7A00CF97D7 AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'btnExclProfile', 'Exclude', 0, CAST(0x00009C8100DC6770 AS DateTime), CAST(0x00009C8100DC5E6D AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'btnExclude', 'Exclude', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'btnExecNow', 'Archive Emails', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'btnExecuteExpire', 'Execute', 0, CAST(0x00009CB600E0EF98 AS DateTime), CAST(0x00009CB600E0EF98 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'btnGrlobalArchive', '&Archive All', 0, CAST(0x00009C7B00874E48 AS DateTime), CAST(0x00009C7B00874C20 AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'btnInclFileType', 'Include', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'btnInclProfile', 'Include', 0, CAST(0x00009C8100DC6770 AS DateTime), CAST(0x00009C8100DC5E6D AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'btnRefresh', 'Refresh', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'btnRefreshFolders', 'Avail For Archive', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'btnRemoveDir', 'Remove Dir', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'btnRemoveExclude', 'Remove', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'btnSaveChanges', 'Save Change', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'btnSaveConditions', 'Activate', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'btnSaveSchedule', 'Save', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'btnSelDir', 'Select Dir', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'btnSMTP', 'SMTP', 0, CAST(0x00009C7A00CF99B4 AS DateTime), CAST(0x00009C7A00CF97D7 AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'btnTestSchedule', 'Test', 0, CAST(0x00009C8200A78E24 AS DateTime), CAST(0x00009C8200A78408 AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'Button1', 'Add', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'Button2', 'Remove', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'Button3', 'Remove', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'Button4', 'Button4', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'Button5', 'Button5', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'Button7', 'Button7', 0, CAST(0x00009C3A01429158 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'cbAsType', null, 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'cbEmailDB', 'CONN_DMA.DB', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'cbEmailRetention', null, 0, CAST(0x00009C5700F10590 AS DateTime), CAST(0x00009C5700F1099B AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'cbFileDB', 'ECM Thesaurus Words', 0, CAST(0x00009C410088F7AC AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'cbFileTypes', 'Search Name', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'cbInterval', null, 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'cbParentFolders', null, 0, CAST(0x00009C8D013AC928 AS DateTime), CAST(0x00009C8D013B3257 AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'cbPocessType', null, 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'cbProcessAsList', null, 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'cbProfile', null, 0, CAST(0x00009C8100DC6770 AS DateTime), CAST(0x00009C8100DC5E72 AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'cbProfiles', null, 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'cbRetention', null, 0, CAST(0x00009C5700F10590 AS DateTime), CAST(0x00009C5700F10979 AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'cbTimeUnit', null, 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'ckArchAfterDays', 'Archive items after', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'ckArchiveFolder', 'Archive Emails in Folder', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'ckArchiveRead', 'Do Not Delete Unread Emails', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'ckDisable', 'Disable All', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'ckDisableContentArchive', 'Disable Content', 0, CAST(0x00009C7A00C735A8 AS DateTime), CAST(0x00009C7A00C733D0 AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'ckDisableDir', 'Disable Dir Archive', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'ckDisableExchange', 'Disable Exchange', 0, CAST(0x00009C7A00C735A8 AS DateTime), CAST(0x00009C7A00C733D0 AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'ckDisableOutlookEmailArchive', 'Disable Email', 0, CAST(0x00009C7A00C735A8 AS DateTime), CAST(0x00009C7A00C733D0 AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'ckIncludeAllTypes', 'Include All', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'ckMetaData', 'Capture Metadata', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'ckOcr', 'OCR This Directory', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'ckPublic', 'Make Public', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'ckRemove', 'Remove After Archive', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'ckRemoveAfterXDays', 'Remove items after', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'ckRemoveFileType', 'X', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'ckRunAtStartup', 'Load at startup', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'ckSkipIfArchived', 'Skip if archive bit is ON', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'ckSubDirs', 'Include Subdirectories', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'ckSystemFolder', 'Mandatory Folder', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'ckUseLastProcessDateAsCutoff', 'User Name', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'ckVersionFiles', 'Version Files', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'clAdminDir', 'Mandatory Directory', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', 'Progress bar', 'dgGrpUsers', null, 0, CAST(0x00009CB6010183D4 AS DateTime), CAST(0x00009CB60101831D AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'Label1', 'Run archiver', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'Label10', 'As type', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'Label11', 'Free Document Space After:', 0, CAST(0x00009C9500AF8D68 AS DateTime), CAST(0x00009C9500AFE14C AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'Label12', 'months of inactivity.', 0, CAST(0x00009C9500AF8D68 AS DateTime), CAST(0x00009C9500AFE14C AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'Label13', 'Retention Rule', 0, CAST(0x00009C98016C1FA0 AS DateTime), CAST(0x00009C98016C7038 AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'Label2', 'Every', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'Label3', 'days.', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'Label4', 'days.', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'Label5', 'Available', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'Label6', 'Include', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'Label7', 'Exclude', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'Label8', 'Select Repository', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'Label9', 'Process type', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'lbActiveFolder', null, 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'lbArchiveDirs', null, 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'lbAvailExts', null, 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'lbExcludeExts', 'User List', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'lbGroups', null, 0, CAST(0x00009CB6010FA43C AS DateTime), CAST(0x00009CB6010FA499 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'lbIncludeExts', null, 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'lblUnit', 'hour(s)', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'MenuStrip1', 'MenuStrip1', 0, CAST(0x00009C7A00B882C4 AS DateTime), CAST(0x00009C7A00B8810D AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'NumericUpDown1', '0', 0, CAST(0x00009C9500AF8D68 AS DateTime), CAST(0x00009C9500AFE14C AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'NumericUpDown2', '0', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'NumericUpDown3', '0', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', 'Progress bar', 'PB1', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'PBx', null, 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'rbToDefaultDir', 'Deactivate', 0, CAST(0x00009CB6010D973C AS DateTime), CAST(0x00009CB6010D9676 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'SB', 'Disabled set to True', 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'SB2', null, 0, CAST(0x00009C3E008043F0 AS DateTime), CAST(0x00009C3D01678A86 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'txtDir', null, 0, CAST(0x00009C3A01428DD4 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', 'Enter text here that you expect to match the selected metadata. Wildcards are permissible.', 'txtMetaSearch2', null, 0, CAST(0x00009CB6010182A8 AS DateTime), CAST(0x00009CB6010182FC AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'txtParmVal', null, 0, CAST(0x00009CB801449174 AS DateTime), CAST(0x00009CB801448E15 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmReconMain', '<help text here>', 'txtVerNo', null, 0, CAST(0x00009CB800F9D7C4 AS DateTime), CAST(0x00009CB800F9D554 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmRetentionMgt', '<help text here>', 'btnDelete', 'ECM Thesaurus Words', 0, CAST(0x00009C410088F7AC AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmRetentionMgt', '<help text here>', 'btnExecuteAge', 'Execute', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmRetentionMgt', '<help text here>', 'btnExecuteExpire', 'Execute', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmRetentionMgt', '<help text here>', 'btnExtend', 'Extend', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmRetentionMgt', '<help text here>', 'btnMove', 'Move Selected Items', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmRetentionMgt', '<help text here>', 'btnRecall', null, 0, CAST(0x00009C3C00D789BC AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmRetentionMgt', '<help text here>', 'btnSelectExpired', 'Execute', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmRetentionMgt', '<help text here>', 'cbAgeUnits', 'Months', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmRetentionMgt', '<help text here>', 'cbExpireUnits', 'Months', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmRetentionMgt', '<help text here>', 'ckEcmConnection', 'Check Server DB Conn', 0, CAST(0x00009CB600DD034C AS DateTime), CAST(0x00009CB600DD02BF AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmRetentionMgt', '<help text here>', 'dgGrpUsers', null, 0, CAST(0x00009CB6010FA568 AS DateTime), CAST(0x00009CB6010FA4BF AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmRetentionMgt', '<help text here>', 'dgItems', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmRetentionMgt', ' June 02', 'dtExtendDate', 'Tuesday', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmRetentionMgt', '<help text here>', 'Label1', 'Select all items within', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmRetentionMgt', '<help text here>', 'Label2', 'of expiration', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmRetentionMgt', '<help text here>', 'Label3', 'Select all expired items', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmRetentionMgt', '<help text here>', 'Label4', 'Extend all selected item`s retention date until:', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmRetentionMgt', '<help text here>', 'Label5', 'Select all items older than', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmRetentionMgt', '<help text here>', 'lbGroups', null, 0, CAST(0x00009CB600DD034C AS DateTime), CAST(0x00009CB600DD02A7 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmRetentionMgt', '<help text here>', 'PB', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmRetentionMgt', '<help text here>', 'rbContent', 'Content / Documents', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmRetentionMgt', '<help text here>', 'rbEmails', 'Emails', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmRetentionMgt', '<help text here>', 'SB', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmRetentionMgt', 'Status bar User', 'SBUser', null, 0, CAST(0x00009CB600FBEE24 AS DateTime), CAST(0x00009CB600FBEE15 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmRetentionMgt', '<help text here>', 'txtAgeUnit', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmRetentionMgt', '<help text here>', 'txtExpireUnit', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmRetentionMgt', 'Use these terms as {inflected} not infected terms.', 'txtInflection', null, 0, CAST(0x00009CB801451A90 AS DateTime), CAST(0x00009CB8014517F6 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmRetentionMgt', '<help text here>', 'txtParmVal', null, 0, CAST(0x00009CB8012EC2A4 AS DateTime), CAST(0x00009CB8012EC039 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchAssist', '<help text here>', 'btnAddThesauri', 'Add', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchAssist', '<help text here>', 'btnAddWords', 'Add Selected', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C3300DE434C AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchAssist', '<help text here>', 'btnClear', 'Clear All Fields', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchAssist', '<help text here>', 'btnClrList', 'Clear List', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C3300DF9A53 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchAssist', '<help text here>', 'btnExpand', 'Exp', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchAssist', '<help text here>', 'btnExpandThesaurus', 'Exp', 0, CAST(0x00009C4100C77ACC AS DateTime), CAST(0x00009C4100B1B688 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchAssist', '<help text here>', 'btnExpInflection', 'Exp', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchAssist', '<help text here>', 'btnRemoveThesauri', 'Del', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchAssist', '<help text here>', 'btnRestore', 'Restore Search', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchAssist', '<help text here>', 'btnSave', 'Generate Search Query', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchAssist', '<help text here>', 'Button1', 'Generate Search Query', 0, CAST(0x00009CB60112D184 AS DateTime), CAST(0x00009CB60112D183 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchAssist', '<help text here>', 'cbAvailThesauri', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchAssist', 'Turn the date range on or OFF here', 'cbDateRange', 'OFF', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchAssist', '<help text here>', 'cbSelectedThesauri', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchAssist', '<help text here>', 'CheckBox1', 'And', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchAssist', '<help text here>', 'CheckBox3', 'And', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchAssist', '<help text here>', 'CheckBox4', 'And', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchAssist', '<help text here>', 'ckAndInflection', 'And', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchAssist', '<help text here>', 'ckAndThesaurus', 'And', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchAssist', '<help text here>', 'ckEcmThesaurus', 'And', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchAssist', 'End date', 'dtEnd', 'Thursday', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchAssist', 'Start date', 'dtStart', 'Thursday', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchAssist', '<help text here>', 'Label1', null, 0, CAST(0x00009C410088F7AC AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchAssist', '<help text here>', 'Label10', 'Use all of these thesauri', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchAssist', '<help text here>', 'Label11', 'Thesaurus Expanded Word List', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C3300DE434D AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchAssist', '<help text here>', 'Label12', 'ECM Thesaurus Words', 0, CAST(0x00009C410088F7AC AS DateTime), CAST(0x00009C400113A8C3 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchAssist', '<help text here>', 'Label2', 'this exact phrase', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchAssist', '<help text here>', 'Label3', null, 0, CAST(0x00009C410088F7AC AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchAssist', '<help text here>', 'Label4', 'AND none of these words', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchAssist', '<help text here>', 'Label5', 'these words near each other', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchAssist', '<help text here>', 'Label6', 'By Date Range', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchAssist', '<help text here>', 'Label7', 'Inflection for these words', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchAssist', '<help text here>', 'Label8', 'Microsoft thesaurus words', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchAssist', '<help text here>', 'Label9', 'ECM Library thesaurus words', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchAssist', '<help text here>', 'lbGroups', null, 0, CAST(0x00009CB801451A90 AS DateTime), CAST(0x00009CB8014517ED AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchAssist', '<help text here>', 'lbWords', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C3300DE434C AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchAssist', 'Status bar', 'SB', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchAssist', 'Status bar', 'SB2', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchAssist', 'Status bar User', 'SBUser', null, 0, CAST(0x00009CB801460F7C AS DateTime), CAST(0x00009CB801460D0C AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchAssist', 'Use all of these words in the search', 'txtAllOfTheseWords', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchAssist', 'Use any of  these words in the search', 'txtAnyOfThese', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchAssist', '<help text here>', 'txtEcmThesaurus', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchAssist', '<help text here>', 'txtExactPhrase', 'Exp', 0, CAST(0x00009C4100C77ACC AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchAssist', '<help text here>', 'txtExpandedTheWords', null, 0, CAST(0x00009C4100C77ACC AS DateTime), CAST(0x00009C400156EE83 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchAssist', 'Use these terms as {inflected} not infected terms.', 'txtInflection', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchAssist', '<help text here>', 'txtMsThesuarus', null, 0, CAST(0x00009C3C00D789BC AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchAssist', 'Press to be near me or better yet, find the pair of words near each other.', 'txtNear', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchAssist', 'If any of these words appear do not retrieve the content, but instead cast it deep into the desert.', 'txtNoneOfThese', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchAssist', 'This uses the thesaurus definitions specific to your company as defined and provided by your administrator.', 'txtThesuarus', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchAssist', '<help text here>', 'txtTheWords', null, 0, CAST(0x00009C410088F7AC AS DateTime), CAST(0x00009C400113A8C5 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchAssist', '<help text here>', 'txtVerNo', null, 0, CAST(0x00009CB800DE77F4 AS DateTime), CAST(0x00009CB800DE74F3 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchDetail', 'A list of available libraries.', 'cbFolderFilter', null, 0, CAST(0x00009CB801449048 AS DateTime), CAST(0x00009CB801448D55 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchDetail', '<help text here>', 'cbLibrary', null, 0, CAST(0x00009CB801449048 AS DateTime), CAST(0x00009CB801448DB2 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchDetail', '<help text here>', 'ckEcmConnection', 'Check Server DB Conn', 0, CAST(0x00009CB70125BA88 AS DateTime), CAST(0x00009CB70125B839 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchDetail', '<help text here>', 'dgMetaData', null, 0, CAST(0x00009C3C00D789BC AS DateTime), CAST(0x00009C3C00D787D2 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchDetail', '<help text here>', 'lbGroups', null, 0, CAST(0x00009CB600E35F08 AS DateTime), CAST(0x00009CB600E35E8D AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchDetail', '<help text here>', 'lblAuthor', 'Author', 0, CAST(0x00009C3A01429158 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchDetail', '<help text here>', 'lblCreateDate', 'Create Date', 0, CAST(0x00009C3A01429158 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchDetail', '<help text here>', 'lblFqn', 'Source Name Or CC List', 0, CAST(0x00009C3A01429158 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchDetail', '<help text here>', 'lblIsPublic', 'Public', 0, CAST(0x00009C3A01429158 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchDetail', '<help text here>', 'lblRetentionDate', 'Retention Date', 0, CAST(0x00009C3A01429158 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchDetail', '<help text here>', 'lblSentTo', 'Sent To', 0, CAST(0x00009C3A01429158 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchDetail', '<help text here>', 'lblSize', 'Size', 0, CAST(0x00009C3A01429158 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchDetail', '<help text here>', 'lblTitle', 'Title', 0, CAST(0x00009C3A01429158 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchDetail', '<help text here>', 'lblVerNo', 'Ver#', 0, CAST(0x00009C3A01429158 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchDetail', '<help text here>', 'txtAuthor', null, 0, CAST(0x00009C3A01429158 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchDetail', '<help text here>', 'txtBody', null, 0, CAST(0x00009C3A01429158 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchDetail', '<help text here>', 'txtCreateDate', null, 0, CAST(0x00009C3A01429158 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchDetail', '<help text here>', 'txtIsPublic', 'Delete Selected Items', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchDetail', '<help text here>', 'txtParmVal', null, 0, CAST(0x00009CB801449048 AS DateTime), CAST(0x00009CB801448D50 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchDetail', '<help text here>', 'txtRetentionDate', 'Exp', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchDetail', '<help text here>', 'txtSentTo', 'Thesaurus:', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchDetail', '<help text here>', 'txtSize', null, 0, CAST(0x00009C3A01429158 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchDetail', '<help text here>', 'txtSourceName', null, 0, CAST(0x00009C3A01429158 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchDetail', '<help text here>', 'txtTitle', 'ECM Thesaurus Words', 0, CAST(0x00009C410088F7AC AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSearchDetail', '<help text here>', 'txtVerNo', 'content', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSenderMgt', '<help text here>', 'btnExclSender', '&Exclude', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSenderMgt', '<help text here>', 'btnRefresh', '&Refresh', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSenderMgt', '<help text here>', 'btnRemoveExcluded', '&Deselect', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSenderMgt', '<help text here>', 'dgEmailSenders', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSenderMgt', '<help text here>', 'dgExcludedSenders', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSenderMgt', '<help text here>', 'Label1', 'Email Senders', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSenderMgt', '<help text here>', 'Label2', 'Excluded Senders from Archive', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSenderMgt', '<help text here>', 'rbArchive', 'Archived Senders', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSenderMgt', '<help text here>', 'rbContacts', 'Outlook Contacts', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSenderMgt', '<help text here>', 'rbInbox', 'Inbox Senders', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSenderMgt', 'Use all of these words in the search', 'txtAllOfTheseWords', ' ecm', 0, CAST(0x00009CB70125BA88 AS DateTime), CAST(0x00009CB70125B85E AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmSenderMgt', '<help text here>', 'txtParmVal', 'Archived Senders', 0, CAST(0x00009CB600EF8FBC AS DateTime), CAST(0x00009CB600EF8FCA AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmTrace', 'Remove all records except for those within the last 90 days.', 'btn90Days', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmTrace', 'Export the data in the table into a file that can be emailed or sent to support.', 'btnFile', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmTrace', 'Displays all errors that have occured within the application.', 'dgErrors', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmTrace', 'Export the data in the table into a file that can be emailed or sent to support.', 'PB', null, 0, CAST(0x00009CB7009BC238 AS DateTime), CAST(0x00009CB7009BC0F4 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmTrace', 'This is the status bar.', 'SB', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmTrace', 'Displays a second status so that the first status bar is not over written.', 'SB2', null, 0, CAST(0x00009CB600E0EF98 AS DateTime), CAST(0x00009CB600E0EF89 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmTrace', 'The displayed error message.', 'txtErrorMsg', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmTrace', 'The displayed user messge.', 'txtMsg', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmTrace', 'The stack dump that was a result of the error.', 'txtStack', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUser', 'Add the user', 'btnAdd', '&Add', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUser', 'Delete  the user', 'btnDelete', '&Remove', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUser', 'Make Public', 'btnMakePublic', 'Make Public', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUser', 'Refactor the selected user`s documents', 'btnRefactor', 'Refactor', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUser', 'Remove the user`s co-owner', 'btnRemoveCoowner', 'Remove', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUser', '<help text here>', 'btnSpellCk', null, 0, CAST(0x00009CB600E2F464 AS DateTime), CAST(0x00009CB600E2F3BF AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUser', 'Update the information displayed on the screen', 'btnUpdate', '&Update', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUser', 'A list of specified owners.', 'cbCurrentOwner', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUser', 'Select the new OWNER for content', 'cbNewOwner', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUser', 'Refactoring an owner will go through all tables and change the OWNER guid.', 'cbRefactoredOwner', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUser', '<help text here>', 'cbUserType', 'User - Standard', 0, CAST(0x00009C4C007E4D34 AS DateTime), CAST(0x00009C4C007E51EE AS DateTime), null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUser', 'Make this user an Active User', 'ckActive', 'Active User', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUser', 'Add C0-Owner to the current owner`s data', 'ckAddCoOwner', 'Add C0-Owner', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUser', 'Make user an Administrator', 'ckAdmin', 'Administrator', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUser', 'Refactor User -', 'ckRefactor', 'Refactor User', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUser', 'Currenly assigned co-owners.', 'dgCoOwner', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUser', 'Current users of ECM Library', 'dgUsers', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUser', '<help text here>', 'Label1', 'User Login ID', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUser', '<help text here>', 'Label2', 'User Name', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUser', '<help text here>', 'Label3', 'Password', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUser', '<help text here>', 'Label4', 'User Email', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUser', '<help text here>', 'Label5', 'Co-Owners', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUser', ' you will:', 'lblRefactor1', 'If you press the Refactor button', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUser', '<help text here>', 'lblRefactor2', 'reassign the OWNERSHIP of all documents owned by', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUser', '<help text here>', 'lblRefactor4', 'TO', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUser', 'Status bar', 'SB', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUser', '<help text here>', 'txtEmail', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUser', '<help text here>', 'txtPassword', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUser', '<help text here>', 'txtUserID', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUser', '<help text here>', 'txtUserName', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUserBulkLoader', 'Press to find the file ou wish to upload', 'btnGetFile', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUserBulkLoader', 'Press to load the selected file into the repository.', 'btnLoad', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUserBulkLoader', 'A list of users.', 'lbLoadedUsers', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39C90 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUserBulkLoader', 'Press to load the selected file into the repository.', 'txtParmVal', null, 0, CAST(0x00009CB800EADFBC AS DateTime), CAST(0x00009CB800EADD7B AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUserRunParms', 'Add the defined user parameter', 'btnAdd', '&Add', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUserRunParms', 'Assign parameter To User', 'btnAssign', 'Assign To User', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUserRunParms', 'Press to Delete', 'btnDelete', '&Delete', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUserRunParms', 'Delete the selected user parameter', 'btnDelUserParm', 'Delete', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUserRunParms', '<help text here>', 'btnDisplay', 'Show License Rules', 0, CAST(0x00009CB800EADFBC AS DateTime), CAST(0x00009CB800EADD7F AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUserRunParms', '<help text here>', 'btnExecuteExpire', 'Execute', 0, CAST(0x00009CB600FBEE24 AS DateTime), CAST(0x00009CB600FBEE0C AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUserRunParms', 'Update the screen items into the database', 'btnUpdate', 'Update', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUserRunParms', 'The list of parameters available.', 'cbParmsList', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUserRunParms', 'Status bar', 'ckEcmConnection', 'Check Server DB Conn', 0, CAST(0x00009CB800F8FB74 AS DateTime), CAST(0x00009CB800F8F8A2 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUserRunParms', 'Check to not allow delete of this parameter by a user.', 'ckIsPerm', 'Do not allow delete', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUserRunParms', 'The users', 'dgUsers', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUserRunParms', 'The startup parameters', 'dgUserStartupParms', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUserRunParms', '<help text here>', 'Label1', 'User List', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUserRunParms', '<help text here>', 'Label2', 'Assignable User Parameters', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUserRunParms', '<help text here>', 'Label3', 'Do not change public/private indicator', 0, CAST(0x00009C4300FA3584 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUserRunParms', '<help text here>', 'Label4', 'Assigned User Parameters', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUserRunParms', '<help text here>', 'Label5', 'Selected Parameter', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUserRunParms', '<help text here>', 'Label6', 'Parameter Value', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUserRunParms', '<help text here>', 'Label7', 'Selected User:', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUserRunParms', '<help text here>', 'lbGroups', null, 0, CAST(0x00009CB6010359C0 AS DateTime), CAST(0x00009CB601035933 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUserRunParms', 'Status bar', 'SB', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUserRunParms', 'Status bar User', 'SBUser', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUserRunParms', 'The parmeter value', 'txtLoginID', null, 0, CAST(0x00009CB800EB4F10 AS DateTime), CAST(0x00009CB800EB4C92 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUserRunParms', 'The parmeter value', 'txtParmVal', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUserRunParms', 'The parmeter value', 'txtParmValue', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('frmUserRunParms', 'The selected parmeter', 'txtSelParm', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('LoginForm1', 'Press this to cancel login.', 'Cancel', '&Cancel', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('LoginForm1', '<help text here>', 'Label4', 'AND none of these words', 0, CAST(0x00009CB601055400 AS DateTime), CAST(0x00009CB6010553B0 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('LoginForm1', '<help text here>', 'LogoPictureBox', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('LoginForm1', 'Press to login.', 'OK', '&OK', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('LoginForm1', '<help text here>', 'PasswordLabel', '&Password', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('LoginForm1', 'Enter your ECM Library login password here.', 'PasswordTextBox', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('LoginForm1', 'Enter your Login ID here.', 'txtLoginID', null, 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('LoginForm1', '<help text here>', 'txtProfileDesc', 'Login ID', 0, CAST(0x00009CB600E0EF98 AS DateTime), CAST(0x00009CB600E0EF8E AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('LoginForm1', '<help text here>', 'txtVerNo', null, 0, CAST(0x00009CB600E0EF98 AS DateTime), CAST(0x00009CB600E0EF43 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpText] ([ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('LoginForm1', '<help text here>', 'UsernameLabel', 'Login ID', 0, CAST(0x00009C3A0142A670 AS DateTime), CAST(0x00009C2C00C39B64 AS DateTime), 'wmiller', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBB11F AS DateTime), CAST(0x00009D8B00CBB124 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpInfo] ([HelpName], [HelpEmailAddr], [HelpPhone], [AreaOfFocus], [HoursAvail], [EmailNotification], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('W. Dale Miller', 'dale@EcmLibrary.com', '847-266-1941', '1st Level Tech Support', '6 AM to 9 PM CST', 0, NULL, NULL, NULL, NULL, NULL)"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpInfo] ([HelpName], [HelpEmailAddr], [HelpPhone], [AreaOfFocus], [HoursAvail], [EmailNotification], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Liz Garnand', 'liz@EcmLibrary.com', '503-246-9211', 'Marketing Support', '9 AM to 5:30 PM PST', 0, NULL, NULL, NULL, NULL, NULL)"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpInfo] ([HelpName], [HelpEmailAddr], [HelpPhone], [AreaOfFocus], [HoursAvail], [EmailNotification], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Chandran Rajaratnam', 'cr@EcmLibrary.com', '815-904-6125', 'Business Development', '8 AM to 6 PM EST', 0, NULL, NULL, NULL, NULL, NULL)"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpInfo] ([HelpName], [HelpEmailAddr], [HelpPhone], [AreaOfFocus], [HoursAvail], [EmailNotification], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Susan Miller', 'susan@EcmLibrary.com', '847-266-1941', 'Finance and Accounts', '10 AM to 5 PM EST', 0, NULL, NULL, NULL, NULL, NULL)"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[HelpInfo] ([HelpName], [HelpEmailAddr], [HelpPhone], [AreaOfFocus], [HoursAvail], [EmailNotification], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('@Tech Support', 'support@EcmLibrary.com', 'NA', 'Email Technical Support', '6 AM to 10 PM EST', 1, NULL, NULL, NULL, NULL, NULL)"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[DataTypeCodes] ([FileType], [VerNbr], [Publisher], [Definition], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ascx', '12.0.5626.1', 'Microsoft Corporation', 'Active Server Plus page web user control', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBA369 AS DateTime), CAST(0x00009D8B00CBA369 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[DataTypeCodes] ([FileType], [VerNbr], [Publisher], [Definition], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.asm', '12.0.5626.1', 'Microsoft Corporation', 'Assembly Language Source Code', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBA369 AS DateTime), CAST(0x00009D8B00CBA369 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[DataTypeCodes] ([FileType], [VerNbr], [Publisher], [Definition], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.asp', '12.0.5626.1', 'Microsoft Corporation', 'Active Server Page', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBA369 AS DateTime), CAST(0x00009D8B00CBA369 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[DataTypeCodes] ([FileType], [VerNbr], [Publisher], [Definition], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.aspx', '12.0.5626.1', 'Microsoft Corporation', 'ASP.NET Source File', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBA369 AS DateTime), CAST(0x00009D8B00CBA369 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[DataTypeCodes] ([FileType], [VerNbr], [Publisher], [Definition], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.bat', '12.0.5626.1', 'Microsoft Corporation', 'Batch File', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBA369 AS DateTime), CAST(0x00009D8B00CBA369 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[DataTypeCodes] ([FileType], [VerNbr], [Publisher], [Definition], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.c', '12.0.5626.1', 'Microsoft Corporation', 'C Language File', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBA369 AS DateTime), CAST(0x00009D8B00CBA369 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[DataTypeCodes] ([FileType], [VerNbr], [Publisher], [Definition], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.cmd', '12.0.5626.1', 'Microsoft Corporation', 'Command File', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBA369 AS DateTime), CAST(0x00009D8B00CBA369 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[DataTypeCodes] ([FileType], [VerNbr], [Publisher], [Definition], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.cpp', '12.0.5626.1', 'Microsoft Corporation', 'CPP Language file', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBA369 AS DateTime), CAST(0x00009D8B00CBA369 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[DataTypeCodes] ([FileType], [VerNbr], [Publisher], [Definition], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.cxx', '12.0.5626.1', 'Microsoft Corporation', 'CXX is a file extension associated with File containing Visual C++ code files', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBA369 AS DateTime), CAST(0x00009D8B00CBA369 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[DataTypeCodes] ([FileType], [VerNbr], [Publisher], [Definition], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.def', '12.0.5626.1', 'Microsoft Corporation', 'C++ module definition file', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBA369 AS DateTime), CAST(0x00009D8B00CBA369 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[DataTypeCodes] ([FileType], [VerNbr], [Publisher], [Definition], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.dic', '12.0.5626.1', 'Microsoft Corporation', 'Dictionary of words that can be referenced by word processors and other software programs', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBA369 AS DateTime), CAST(0x00009D8B00CBA369 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[DataTypeCodes] ([FileType], [VerNbr], [Publisher], [Definition], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.doc', null, null, 'Older word document', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBA369 AS DateTime), CAST(0x00009D8B00CBA369 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[DataTypeCodes] ([FileType], [VerNbr], [Publisher], [Definition], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.dot', null, null, 'Word Document Template', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBA369 AS DateTime), CAST(0x00009D8B00CBA369 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[DataTypeCodes] ([FileType], [VerNbr], [Publisher], [Definition], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.h', '12.0.5626.1', 'Microsoft Corporation', 'C Header File', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBA369 AS DateTime), CAST(0x00009D8B00CBA369 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[DataTypeCodes] ([FileType], [VerNbr], [Publisher], [Definition], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.hhc', '12.0.5626.1', 'Microsoft Corporation', 'HTML Help Table of Contents', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBA369 AS DateTime), CAST(0x00009D8B00CBA369 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[DataTypeCodes] ([FileType], [VerNbr], [Publisher], [Definition], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.hpp', '12.0.5626.1', 'Microsoft Corporation', 'C++ Builder 6 Program Header', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBA369 AS DateTime), CAST(0x00009D8B00CBA369 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[DataTypeCodes] ([FileType], [VerNbr], [Publisher], [Definition], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.htm', '12.0.5626.1', 'Microsoft Corporation', 'Hypertext Markup Language', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBA369 AS DateTime), CAST(0x00009D8B00CBA369 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[DataTypeCodes] ([FileType], [VerNbr], [Publisher], [Definition], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.html', '12.0.5626.1', 'Microsoft Corporation', 'Hypertext Markup Language', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBA369 AS DateTime), CAST(0x00009D8B00CBA369 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[DataTypeCodes] ([FileType], [VerNbr], [Publisher], [Definition], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.htw', '12.0.5626.1', 'Microsoft Corporation', 'Hypertext Markup Language', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBA369 AS DateTime), CAST(0x00009D8B00CBA369 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[DataTypeCodes] ([FileType], [VerNbr], [Publisher], [Definition], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.htx', '12.0.5626.1', 'Microsoft Corporation', 'Extended Hypertext Template', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBA369 AS DateTime), CAST(0x00009D8B00CBA369 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[DataTypeCodes] ([FileType], [VerNbr], [Publisher], [Definition], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.hxx', '12.0.5626.1', 'Microsoft Corporation', 'C++ Header', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBA369 AS DateTime), CAST(0x00009D8B00CBA369 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[DataTypeCodes] ([FileType], [VerNbr], [Publisher], [Definition], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ibq', '12.0.5626.1', 'Microsoft Corporation', 'IsoBuster Optical Media Data Container File', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBA369 AS DateTime), CAST(0x00009D8B00CBA369 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[DataTypeCodes] ([FileType], [VerNbr], [Publisher], [Definition], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.idl', '12.0.5626.1', 'Microsoft Corporation', 'CRiSP Harvest File', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBA369 AS DateTime), CAST(0x00009D8B00CBA369 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[DataTypeCodes] ([FileType], [VerNbr], [Publisher], [Definition], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.inc', '12.0.5626.1', 'Microsoft Corporation', 'Active Server Include File', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBA369 AS DateTime), CAST(0x00009D8B00CBA369 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[DataTypeCodes] ([FileType], [VerNbr], [Publisher], [Definition], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.inf', '12.0.5626.1', 'Microsoft Corporation', 'Information or Setup File', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBA369 AS DateTime), CAST(0x00009D8B00CBA369 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[DataTypeCodes] ([FileType], [VerNbr], [Publisher], [Definition], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ini', '12.0.5626.1', 'Microsoft Corporation', 'Initialization/Configuration File', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBA369 AS DateTime), CAST(0x00009D8B00CBA369 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[DataTypeCodes] ([FileType], [VerNbr], [Publisher], [Definition], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.inx', '12.0.5626.1', 'Microsoft Corporation', 'ACL for Windows Index', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBA369 AS DateTime), CAST(0x00009D8B00CBA369 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[DataTypeCodes] ([FileType], [VerNbr], [Publisher], [Definition], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.js', '12.0.5626.1', 'Microsoft Corporation', 'java script', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBA369 AS DateTime), CAST(0x00009D8B00CBA369 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[DataTypeCodes] ([FileType], [VerNbr], [Publisher], [Definition], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.log', '12.0.5626.1', 'Microsoft Corporation', 'Log File', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBA369 AS DateTime), CAST(0x00009D8B00CBA369 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[DataTypeCodes] ([FileType], [VerNbr], [Publisher], [Definition], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.m3u', '12.0.5626.1', 'Microsoft Corporation', 'MP3 Playlist File', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBA369 AS DateTime), CAST(0x00009D8B00CBA369 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[DataTypeCodes] ([FileType], [VerNbr], [Publisher], [Definition], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.mht', '12.0.5626.1', 'Microsoft Corporation', 'MHTML Document', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBA369 AS DateTime), CAST(0x00009D8B00CBA369 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[DataTypeCodes] ([FileType], [VerNbr], [Publisher], [Definition], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.obd', null, null, 'Office Binder Document', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBA369 AS DateTime), CAST(0x00009D8B00CBA369 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[DataTypeCodes] ([FileType], [VerNbr], [Publisher], [Definition], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.obt', null, null, 'Office Binder Template', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBA369 AS DateTime), CAST(0x00009D8B00CBA369 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[DataTypeCodes] ([FileType], [VerNbr], [Publisher], [Definition], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.odc', '12.0.5626.1', 'Microsoft Corporation', 'OpenOffice/StarOffice OpenDocument (Ver 2) Chart', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBA369 AS DateTime), CAST(0x00009D8B00CBA369 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[DataTypeCodes] ([FileType], [VerNbr], [Publisher], [Definition], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.pl', '12.0.5626.1', 'Microsoft Corporation', 'BRL-CAD 2D and 3D Plot File', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBA369 AS DateTime), CAST(0x00009D8B00CBA369 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[DataTypeCodes] ([FileType], [VerNbr], [Publisher], [Definition], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.pot', null, null, 'PowerPoint Template', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBA369 AS DateTime), CAST(0x00009D8B00CBA369 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[DataTypeCodes] ([FileType], [VerNbr], [Publisher], [Definition], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ppt', null, null, 'PowerPoint', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBA369 AS DateTime), CAST(0x00009D8B00CBA369 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[DataTypeCodes] ([FileType], [VerNbr], [Publisher], [Definition], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.rc', '12.0.5626.1', 'Microsoft Corporation', 'C++ Resource Compiler Script File', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBA369 AS DateTime), CAST(0x00009D8B00CBA369 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[DataTypeCodes] ([FileType], [VerNbr], [Publisher], [Definition], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.reg', '12.0.5626.1', 'Microsoft Corporation', 'Registry Data File', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBA369 AS DateTime), CAST(0x00009D8B00CBA369 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[DataTypeCodes] ([FileType], [VerNbr], [Publisher], [Definition], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.rtf', '12.0.5626.1', 'Microsoft Corporation', 'Rich Text Format File', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBA369 AS DateTime), CAST(0x00009D8B00CBA369 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[DataTypeCodes] ([FileType], [VerNbr], [Publisher], [Definition], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.stm', '12.0.5626.1', 'Microsoft Corporation', 'Exchange Server Streaming Store', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBA369 AS DateTime), CAST(0x00009D8B00CBA369 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[DataTypeCodes] ([FileType], [VerNbr], [Publisher], [Definition], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.txt', '12.0.5626.1', 'Microsoft Corporation', 'Text', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBA369 AS DateTime), CAST(0x00009D8B00CBA369 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[DataTypeCodes] ([FileType], [VerNbr], [Publisher], [Definition], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.url', '12.0.5626.1', 'Microsoft Corporation', 'Internet Location', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBA369 AS DateTime), CAST(0x00009D8B00CBA369 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[DataTypeCodes] ([FileType], [VerNbr], [Publisher], [Definition], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.vbs', '12.0.5626.1', 'Microsoft Corporation', 'VB Script', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBA369 AS DateTime), CAST(0x00009D8B00CBA369 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[DataTypeCodes] ([FileType], [VerNbr], [Publisher], [Definition], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.wtx', '12.0.5626.1', 'Microsoft Corporation', 'ASCII Text', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBA369 AS DateTime), CAST(0x00009D8B00CBA369 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[DataTypeCodes] ([FileType], [VerNbr], [Publisher], [Definition], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xlb', null, null, 'Excel Worksheet', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBA369 AS DateTime), CAST(0x00009D8B00CBA369 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[DataTypeCodes] ([FileType], [VerNbr], [Publisher], [Definition], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xlc', null, null, 'Excel Chart', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBA369 AS DateTime), CAST(0x00009D8B00CBA369 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[DataTypeCodes] ([FileType], [VerNbr], [Publisher], [Definition], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xls', null, null, 'Excel Worksheet', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBA369 AS DateTime), CAST(0x00009D8B00CBA369 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[DataTypeCodes] ([FileType], [VerNbr], [Publisher], [Definition], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xlt', null, null, 'Excel Template', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBA369 AS DateTime), CAST(0x00009D8B00CBA369 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[DataTypeCodes] ([FileType], [VerNbr], [Publisher], [Definition], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.xml', '12.0.5626.1', 'Microsoft Corporation', 'Extensible Markup Language File', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBA369 AS DateTime), CAST(0x00009D8B00CBA369 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[ProcessFileAs] ([ExtCode], [ProcessExtCode], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (',dct', '.txt', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBF2FB AS DateTime), CAST(0x00009D8B00CBF2FF AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[ProcessFileAs] ([ExtCode], [ProcessExtCode], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ada', '.txt', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBF2FB AS DateTime), CAST(0x00009D8B00CBF2FF AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[ProcessFileAs] ([ExtCode], [ProcessExtCode], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.adb', '.txt', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBF2FB AS DateTime), CAST(0x00009D8B00CBF2FF AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[ProcessFileAs] ([ExtCode], [ProcessExtCode], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.ads', '.txt', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBF2FB AS DateTime), CAST(0x00009D8B00CBF2FF AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[ProcessFileAs] ([ExtCode], [ProcessExtCode], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.bat', '.txt', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBF2FB AS DateTime), CAST(0x00009D8B00CBF2FF AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[ProcessFileAs] ([ExtCode], [ProcessExtCode], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.css', '.cxx', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBF2FB AS DateTime), CAST(0x00009D8B00CBF2FF AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[ProcessFileAs] ([ExtCode], [ProcessExtCode], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.csv', '.txt', 1, NULL, NULL, 'DELLT100A', CAST(0x00009E3F00EA91F8 AS DateTime), CAST(0x00009E3F00EA91F8 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[ProcessFileAs] ([ExtCode], [ProcessExtCode], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.def', '.txt', 1, NULL, NULL, 'DELLT100A', CAST(0x00009E2A00D878CB AS DateTime), CAST(0x00009E2A00D878CB AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[ProcessFileAs] ([ExtCode], [ProcessExtCode], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.dll', '.dll', 0, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBF2FB AS DateTime), CAST(0x00009D8B00CBF2FF AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[ProcessFileAs] ([ExtCode], [ProcessExtCode], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.frm', '.vbs', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBF2FB AS DateTime), CAST(0x00009D8B00CBF2FF AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[ProcessFileAs] ([ExtCode], [ProcessExtCode], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.java', '.js', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBF2FB AS DateTime), CAST(0x00009D8B00CBF2FF AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[ProcessFileAs] ([ExtCode], [ProcessExtCode], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.sql', '.txt', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBF2FB AS DateTime), CAST(0x00009D8B00CBF2FF AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[ProcessFileAs] ([ExtCode], [ProcessExtCode], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.url', '.txt', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBF2FB AS DateTime), CAST(0x00009D8B00CBF2FF AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[ProcessFileAs] ([ExtCode], [ProcessExtCode], [Applied], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('.vb', '.vbs', 1, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CBF2FB AS DateTime), CAST(0x00009D8B00CBF2FF AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Attributes] ([AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('$Contract ID', 'nvarchar', 'Contract Identifier', 'NA', null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9430 AS DateTime), CAST(0x00009D8B00CB9435 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Attributes] ([AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Album', 'S', 'Auto added: initWordDocMetaData', 'MP3', NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9430 AS DateTime), CAST(0x00009D8B00CB9435 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Attributes] ([AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Application name', 'varchar', 'Varchar used as none Supplied at this time.', 'MSWORD', NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9430 AS DateTime), CAST(0x00009D8B00CB9435 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Attributes] ([AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Author', 'varchar', 'Varchar used as none Supplied at this time.', 'MSWORD', NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9430 AS DateTime), CAST(0x00009D8B00CB9435 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Attributes] ([AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Category', 'varchar', 'Varchar used as none Supplied at this time.', 'MSWORD', NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9430 AS DateTime), CAST(0x00009D8B00CB9435 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Attributes] ([AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('ChangeDate', 'datetime', 'The last date the file was updated', 'UKN', NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9430 AS DateTime), CAST(0x00009D8B00CB9435 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Attributes] ([AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Comments', 'varchar', 'Varchar used as none Supplied at this time.', 'MSWORD', NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9430 AS DateTime), CAST(0x00009D8B00CB9435 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Attributes] ([AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Company', 'varchar', 'Varchar used as none Supplied at this time.', 'MSWORD', NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9430 AS DateTime), CAST(0x00009D8B00CB9435 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Attributes] ([AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Content status', 'varchar', 'Varchar used as none Supplied at this time.', 'MSWORD', NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9430 AS DateTime), CAST(0x00009D8B00CB9435 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Attributes] ([AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Content type', 'varchar', 'Varchar used as none Supplied at this time.', 'MSWORD', NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9430 AS DateTime), CAST(0x00009D8B00CB9435 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Attributes] ([AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('CRC', 'VARCHAR', 'The CRC of the associated file', 'ECMLIBRARY', NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9430 AS DateTime), CAST(0x00009D8B00CB9435 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Attributes] ([AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('CreateDate', 'datetime', 'The CREATION datethe file was updated', 'UKN', NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9430 AS DateTime), CAST(0x00009D8B00CB9435 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Attributes] ([AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Creation date', 'varchar', 'Varchar used as none Supplied at this time.', 'MSWORD', NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9430 AS DateTime), CAST(0x00009D8B00CB9435 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Attributes] ([AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Document version', 'varchar', 'Varchar used as none Supplied at this time.', 'MSWORD', NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9430 AS DateTime), CAST(0x00009D8B00CB9435 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Attributes] ([AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('FILENAME', 'varchar', 'The name of a file', 'UKN', NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9430 AS DateTime), CAST(0x00009D8B00CB9435 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Attributes] ([AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('FILESIZE', 'INT', 'Byte length of a file', 'UKN', NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9430 AS DateTime), CAST(0x00009D8B00CB9435 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Attributes] ([AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Format', 'varchar', 'Varchar used as none Supplied at this time.', 'MSWORD', NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9430 AS DateTime), CAST(0x00009D8B00CB9435 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Attributes] ([AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('FQN', 'varchar', 'The fully qualified name of a file', 'UKN', NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9430 AS DateTime), CAST(0x00009D8B00CB9435 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Attributes] ([AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Genre', 'S', 'Auto added: initWordDocMetaData', 'MP3', NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9430 AS DateTime), CAST(0x00009D8B00CB9435 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Attributes] ([AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Hyperlink base', 'varchar', 'Varchar used as none Supplied at this time.', 'MSWORD', NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9430 AS DateTime), CAST(0x00009D8B00CB9435 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Attributes] ([AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Keywords', 'varchar', 'Varchar used as none Supplied at this time.', 'MSWORD', NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9430 AS DateTime), CAST(0x00009D8B00CB9435 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Attributes] ([AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Language', 'varchar', 'Varchar used as none Supplied at this time.', 'MSWORD', NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9430 AS DateTime), CAST(0x00009D8B00CB9435 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Attributes] ([AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Last author', 'varchar', 'Varchar used as none Supplied at this time.', 'MSWORD', NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9430 AS DateTime), CAST(0x00009D8B00CB9435 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Attributes] ([AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Last print date', 'varchar', 'Varchar used as none Supplied at this time.', 'MSWORD', NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9430 AS DateTime), CAST(0x00009D8B00CB9435 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Attributes] ([AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Last save time', 'varchar', 'Varchar used as none Supplied at this time.', 'MSWORD', NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9430 AS DateTime), CAST(0x00009D8B00CB9435 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Attributes] ([AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Manager', 'varchar', 'Varchar used as none Supplied at this time.', 'MSWORD', NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9430 AS DateTime), CAST(0x00009D8B00CB9435 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Attributes] ([AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('MD Author', 'NVARCHAR', 'ADDED BY ECM Library', '???', NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9430 AS DateTime), CAST(0x00009D8B00CB9435 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Attributes] ([AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('music', 'S', 'Auto added: initWordDocMetaData', 'MP3', NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9430 AS DateTime), CAST(0x00009D8B00CB9435 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Attributes] ([AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Number of bytes', 'varchar', 'Varchar used as none Supplied at this time.', 'MSWORD', NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9430 AS DateTime), CAST(0x00009D8B00CB9435 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Attributes] ([AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Number of characters', 'varchar', 'Varchar used as none Supplied at this time.', 'MSWORD', NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9430 AS DateTime), CAST(0x00009D8B00CB9435 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Attributes] ([AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Number of characters (with spaces)', 'varchar', 'Varchar used as none Supplied at this time.', 'MSWORD', NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9430 AS DateTime), CAST(0x00009D8B00CB9435 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Attributes] ([AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Number of hidden Slides', 'varchar', 'Varchar used as none Supplied at this time.', 'MSWORD', NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9430 AS DateTime), CAST(0x00009D8B00CB9435 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Attributes] ([AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Number of lines', 'varchar', 'Varchar used as none Supplied at this time.', 'MSWORD', NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9430 AS DateTime), CAST(0x00009D8B00CB9435 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Attributes] ([AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Number of multimedia clips', 'varchar', 'Varchar used as none Supplied at this time.', 'MSWORD', NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9430 AS DateTime), CAST(0x00009D8B00CB9435 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Attributes] ([AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Number of notes', 'varchar', 'Varchar used as none Supplied at this time.', 'MSWORD', NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9430 AS DateTime), CAST(0x00009D8B00CB9435 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Attributes] ([AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Number of pages', 'varchar', 'Varchar used as none Supplied at this time.', 'MSWORD', NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9430 AS DateTime), CAST(0x00009D8B00CB9435 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Attributes] ([AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Number of paragraphs', 'varchar', 'Varchar used as none Supplied at this time.', 'MSWORD', NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9430 AS DateTime), CAST(0x00009D8B00CB9435 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Attributes] ([AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Number of slides', 'varchar', 'Varchar used as none Supplied at this time.', 'MSWORD', NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9430 AS DateTime), CAST(0x00009D8B00CB9435 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Attributes] ([AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Number of words', 'varchar', 'Varchar used as none Supplied at this time.', 'MSWORD', NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9430 AS DateTime), CAST(0x00009D8B00CB9435 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Attributes] ([AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('PRIVATE', 'char', 'This marks a peice of content as private and belonging only to the owner. It can be set in two places. This is where you set public or private at the specific content item and global directory public access is set on the `setup screen`.', 'ECMLIBRARY', 'Y,', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9430 AS DateTime), CAST(0x00009D8B00CB9435 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Attributes] ([AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Revision number', 'varchar', 'Varchar used as none Supplied at this time.', 'MSWORD', NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9430 AS DateTime), CAST(0x00009D8B00CB9435 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Attributes] ([AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Security', 'varchar', 'Varchar used as none Supplied at this time.', 'MSWORD', NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9430 AS DateTime), CAST(0x00009D8B00CB9435 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Attributes] ([AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Song Artist', 'S', 'Auto added: initWordDocMetaData', 'MP3', NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9430 AS DateTime), CAST(0x00009D8B00CB9435 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Attributes] ([AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Song Title', 'S', 'Auto added: initWordDocMetaData', 'MP3', NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9430 AS DateTime), CAST(0x00009D8B00CB9435 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Attributes] ([AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Subject', 'varchar', 'Varchar used as none Supplied at this time.', 'MSWORD', NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9430 AS DateTime), CAST(0x00009D8B00CB9435 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Attributes] ([AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Template', 'varchar', 'Varchar used as none Supplied at this time.', 'MSWORD', NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9430 AS DateTime), CAST(0x00009D8B00CB9435 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Attributes] ([AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Title', 'varchar', 'Varchar used as none Supplied at this time.', 'MSWORD', NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9430 AS DateTime), CAST(0x00009D8B00CB9435 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Attributes] ([AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Total editing time', 'nvarchar', 'Varchar used as none Supplied at this time.', 'MSWORD', null, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9430 AS DateTime), CAST(0x00009D8B00CB9435 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Attributes] ([AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Track', 'I', 'Auto added: initWordDocMetaData', 'MP3', NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9430 AS DateTime), CAST(0x00009D8B00CB9435 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Attributes] ([AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('WriteDate', 'datetime', 'The last time the file was written to', 'UKN', NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9430 AS DateTime), CAST(0x00009D8B00CB9435 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[Attributes] ([AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('Year', 'I', 'Auto added: initWordDocMetaData', 'MP3', NULL, NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9430 AS DateTime), CAST(0x00009D8B00CB9435 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttributeDatatype] ([AttributeDataType], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('bigint', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9401 AS DateTime), CAST(0x00009D8B00CB9401 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttributeDatatype] ([AttributeDataType], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('binary', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9401 AS DateTime), CAST(0x00009D8B00CB9401 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttributeDatatype] ([AttributeDataType], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('bit', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9401 AS DateTime), CAST(0x00009D8B00CB9401 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttributeDatatype] ([AttributeDataType], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('boolean', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9401 AS DateTime), CAST(0x00009D8B00CB9401 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttributeDatatype] ([AttributeDataType], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('char', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9401 AS DateTime), CAST(0x00009D8B00CB9401 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttributeDatatype] ([AttributeDataType], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('cursor', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9401 AS DateTime), CAST(0x00009D8B00CB9401 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttributeDatatype] ([AttributeDataType], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('date', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9401 AS DateTime), CAST(0x00009D8B00CB9401 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttributeDatatype] ([AttributeDataType], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('datetime', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9401 AS DateTime), CAST(0x00009D8B00CB9401 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttributeDatatype] ([AttributeDataType], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('datetime2', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9401 AS DateTime), CAST(0x00009D8B00CB9401 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttributeDatatype] ([AttributeDataType], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('datetimeoffset', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9401 AS DateTime), CAST(0x00009D8B00CB9401 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttributeDatatype] ([AttributeDataType], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('decimal', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9401 AS DateTime), CAST(0x00009D8B00CB9401 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttributeDatatype] ([AttributeDataType], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('float', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9401 AS DateTime), CAST(0x00009D8B00CB9401 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttributeDatatype] ([AttributeDataType], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('hierarchyid', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9401 AS DateTime), CAST(0x00009D8B00CB9401 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttributeDatatype] ([AttributeDataType], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('image', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9401 AS DateTime), CAST(0x00009D8B00CB9401 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttributeDatatype] ([AttributeDataType], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('int', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9401 AS DateTime), CAST(0x00009D8B00CB9401 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttributeDatatype] ([AttributeDataType], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('money', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9401 AS DateTime), CAST(0x00009D8B00CB9401 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttributeDatatype] ([AttributeDataType], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('MP3', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9401 AS DateTime), CAST(0x00009D8B00CB9401 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttributeDatatype] ([AttributeDataType], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('nchar', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9401 AS DateTime), CAST(0x00009D8B00CB9401 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttributeDatatype] ([AttributeDataType], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('ntext', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9401 AS DateTime), CAST(0x00009D8B00CB9401 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttributeDatatype] ([AttributeDataType], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('numeric', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9401 AS DateTime), CAST(0x00009D8B00CB9401 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttributeDatatype] ([AttributeDataType], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('nvarchar', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9401 AS DateTime), CAST(0x00009D8B00CB9401 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttributeDatatype] ([AttributeDataType], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('real', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9401 AS DateTime), CAST(0x00009D8B00CB9401 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttributeDatatype] ([AttributeDataType], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('smalldatetime', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9401 AS DateTime), CAST(0x00009D8B00CB9401 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttributeDatatype] ([AttributeDataType], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('smallint', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9401 AS DateTime), CAST(0x00009D8B00CB9401 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttributeDatatype] ([AttributeDataType], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('smallmoney', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9401 AS DateTime), CAST(0x00009D8B00CB9401 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttributeDatatype] ([AttributeDataType], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('sql_variant', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9401 AS DateTime), CAST(0x00009D8B00CB9401 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttributeDatatype] ([AttributeDataType], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('table', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9401 AS DateTime), CAST(0x00009D8B00CB9401 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttributeDatatype] ([AttributeDataType], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('text', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9401 AS DateTime), CAST(0x00009D8B00CB9401 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttributeDatatype] ([AttributeDataType], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('time', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9401 AS DateTime), CAST(0x00009D8B00CB9401 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttributeDatatype] ([AttributeDataType], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('timestamp', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9401 AS DateTime), CAST(0x00009D8B00CB9401 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttributeDatatype] ([AttributeDataType], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('tinyint', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9401 AS DateTime), CAST(0x00009D8B00CB9401 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttributeDatatype] ([AttributeDataType], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('uniqueidentifier', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9401 AS DateTime), CAST(0x00009D8B00CB9401 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttributeDatatype] ([AttributeDataType], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('varbinary', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9401 AS DateTime), CAST(0x00009D8B00CB9401 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttributeDatatype] ([AttributeDataType], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('varchar', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9401 AS DateTime), CAST(0x00009D8B00CB9401 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttributeDatatype] ([AttributeDataType], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('WAV', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9401 AS DateTime), CAST(0x00009D8B00CB9401 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttributeDatatype] ([AttributeDataType], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('WMA', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9401 AS DateTime), CAST(0x00009D8B00CB9401 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttributeDatatype] ([AttributeDataType], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('WMV', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9401 AS DateTime), CAST(0x00009D8B00CB9401 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        S = "INSERT [dbo].[AttributeDatatype] ([AttributeDataType], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES ('xml', NULL, 0, 'DELLT100\ECMLIB', CAST(0x00009D8B00CB9401 AS DateTime), CAST(0x00009D8B00CB9401 AS DateTime))"
        'S = UTIL.RemoveSingleQuotes(S)
        ExecuteSQL(S)
        
    End Sub

End Class
