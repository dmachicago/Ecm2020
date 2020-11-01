Public Class clsValidateCodes

    Dim DBARCH As New clsDatabaseARCH
    Dim LOG As New clsLogging
    Dim UTIL As New clsUtility

    Public Sub valSystemParmsCodes()
        Dim SysParm As String = ""
        Dim InsertSql As String = ""

        InsertSql = "INSERT [dbo].[SystemParms] ([SysParm], [SysParmDesc], [SysParmVal], [flgActive], [isDirectory], [isEmailFolder], [flgAllSubDirs]) VALUES ('MaxUrlsToProcess', 'The number of levels to penetrate in a web site.', '2', NULL, NULL, NULL, NULL)"
        SystemParmsCodesExist("MaxUrlsToProcess", InsertSql)

        InsertSql = "INSERT [dbo].[SystemParms] ([SysParm], [SysParmDesc], [SysParmVal], [flgActive], [isDirectory], [isEmailFolder], [flgAllSubDirs]) VALUES ('RequireUserAuthentication', 'This determines whether the USERID ir the MACHINE ID will authenticate (Y or N).', '2', 'Y', NULL, NULL, NULL)"
        SystemParmsCodesExist("MaxUrlsToProcess", InsertSql)

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

        InsertSql = "INSERT [dbo].[SystemParms] ([SysParm], [SysParmDesc], [SysParmVal], [flgActive], [isDirectory], [isEmailFolder], [flgAllSubDirs]) VALUES ('SYS_AutoRegisterUser', 'When set true, authentication will be automatic adn entered into the DBARCH.', 'xx', NULL, NULL, NULL, NULL)"
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
    Function SystemParmsCodesExist(ByVal SysParm As String, ByVal InsertSql As String) As Boolean
        Dim B As Boolean = False
        Dim iCnt As Integer = 0

        Dim S As String = "Select count(*) from SystemParms  where SysParm = '" + SysParm + "' "
        iCnt = DBARCH.iCount(S)
        If iCnt = 0 Then
            B = DBARCH.ExecuteSqlNewConn(90601, InsertSql)
        End If
        Return B
    End Function

    Sub valAvailFileTypes()

        Dim InsertSql As String = ""

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

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.CMD')"
        AvailFileTypesExist(".CMD", InsertSql)

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

        InsertSql = "INSERT [AvailFileTypes] ([ExtCode]) VALUES ('.ppt')"
        AvailFileTypesExist(".one", InsertSql)

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
    Function AvailFileTypesExist(ByVal ExtCode As String, ByVal InsertSql As String) As Boolean
        Dim B As Boolean = False
        Dim iCnt As Integer = 0

        Dim S As String = "Select count(*) from AvailFileTypes  where ExtCode = '" + ExtCode + "'"
        iCnt = DBARCH.iCount(S)
        If iCnt = 0 Then
            B = DBARCH.ExecuteSqlNewConn(90602, InsertSql)
        End If
        Return B
    End Function

    Public Sub valAttachmentType()
        Dim SysParm As String = ""
        Dim InsertSql As String = ""

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

        InsertSql = "INSERT [AttachmentType] ([AttachmentCode], [Description], [isZipFormat]) VALUES ('.CMD', '', 0)"
        AttachmentTypeExist(".CMD", InsertSql)

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
    Function AttachmentTypeExist(ByVal AttachmentCode As String, ByVal InsertSql As String) As Boolean
        Dim B As Boolean = False
        Dim iCnt As Integer = 0

        Dim S As String = "Select count(*) from AttachmentType where AttachmentCode = '" + AttachmentCode + "' "
        iCnt = DBARCH.iCount(S)
        If iCnt = 0 Then
            B = DBARCH.ExecuteSqlNewConn(90603, InsertSql)
        End If
        Return B
    End Function

    Function ThesaurusExist() As Boolean
        Dim DBX As New clsDb
        Dim B As Boolean = True
        Try
            DBX.ThesaurusExist()
        Catch ex As Exception
            LOG.WriteToArchiveLog("clsValidateCodes:ThesaurusExist - failed to add default Thesaurus.")
            B = False
        Finally
            DBX = Nothing
            GC.Collect()
        End Try

        Return B
    End Function

    Public Sub valSourceType()

        Dim SourceTypeCode As String = ""
        Dim SourceTypeDesc As String = ""
        Dim Indexable As String = ""

        Indexable = "0"

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
        SourceTypeExist(".CMD", "Word Splitter", "1")
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
        SourceTypeExist(".DBARCH", "NO SEARCH - AUTO ADDED by Pgm", "0")
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

    Function SourceTypeExist(ByVal SourceTypeCode As String, ByVal SourceTypeDesc As String, ByVal Indexable As String) As Boolean
        'INSERT INTO [SourceType]([SourceTypeCode],[StoreExternal],[SourceTypeDesc],[Indexable])VALUES('XX',0,'XX',1)
        Dim B As Boolean = False
        Dim iCnt As Integer = 0
        Dim S As String = "Select COUNT(*) FROM [SourceType] where [SourceTypeCode] = '" + SourceTypeCode + "' "

        iCnt = DBARCH.iCount(S)
        If iCnt = 0 Then
            S = "INSERT INTO [SourceType] ([SourceTypeCode],[StoreExternal],[SourceTypeDesc],[Indexable]) VALUES ('" + SourceTypeCode + "',0,'" + SourceTypeDesc + "'," + Indexable + ")"
            B = DBARCH.ExecuteSqlNewConn(90604, S)
            'Else
            '    S  = "UPDATE [SourceType] SET  [SourceTypeDesc] = '" + SourceTypeDesc  + "' ,[Indexable] = " + Indexable  + " where [SourceTypeCode] = '""+SourceTypeCode+" ' 
        End If
        Return B

    End Function

    Public Sub valProfileItems()
        Dim SysParm As String = ""
        Dim InsertSql As String = ""
        Dim ProfileName As String = ""
        Dim SourceTypeCode As String = ""

        ProfileName = "Office Documents"
        SourceTypeCode = ".doc"
        LoadProfileItems(ProfileName, SourceTypeCode)

        ProfileName = "Office Documents"
        SourceTypeCode = ".docx"

        LoadProfileItems(ProfileName, SourceTypeCode)

        ProfileName = "Office Documents"
        SourceTypeCode = ".docm"

        LoadProfileItems(ProfileName, SourceTypeCode)

        ProfileName = "Office Documents"
        SourceTypeCode = ".dotx"

        LoadProfileItems(ProfileName, SourceTypeCode)

        ProfileName = "Office Documents"
        SourceTypeCode = ".dotm"

        LoadProfileItems(ProfileName, SourceTypeCode)

        ProfileName = "Office Documents"
        SourceTypeCode = ".xls"

        LoadProfileItems(ProfileName, SourceTypeCode)

        ProfileName = "Office Documents"
        SourceTypeCode = ".xlsx"

        LoadProfileItems(ProfileName, SourceTypeCode)

        ProfileName = "Office Documents"
        SourceTypeCode = ".xlsm"

        LoadProfileItems(ProfileName, SourceTypeCode)

        ProfileName = "Office Documents"
        SourceTypeCode = ".xltx"

        LoadProfileItems(ProfileName, SourceTypeCode)

        ProfileName = "Office Documents"
        SourceTypeCode = ".xltm"

        LoadProfileItems(ProfileName, SourceTypeCode)

        ProfileName = "Office Documents"
        SourceTypeCode = ".xlsb"

        LoadProfileItems(ProfileName, SourceTypeCode)

        ProfileName = "Office Documents"
        SourceTypeCode = ".xlam"

        LoadProfileItems(ProfileName, SourceTypeCode)

        ProfileName = "Office Documents"
        SourceTypeCode = ".pptx"

        LoadProfileItems(ProfileName, SourceTypeCode)

        ProfileName = "Office Documents"
        SourceTypeCode = ".pptm"

        LoadProfileItems(ProfileName, SourceTypeCode)

        ProfileName = "Office Documents"
        SourceTypeCode = ".potx"

        LoadProfileItems(ProfileName, SourceTypeCode)

        ProfileName = "Office Documents"
        SourceTypeCode = ".potm"

        LoadProfileItems(ProfileName, SourceTypeCode)

        ProfileName = "Office Documents"
        SourceTypeCode = ".ppam"

        LoadProfileItems(ProfileName, SourceTypeCode)

        ProfileName = "Office Documents"
        SourceTypeCode = ".ppsx"

        LoadProfileItems(ProfileName, SourceTypeCode)

        ProfileName = "Office Documents"
        SourceTypeCode = ".ppsm"

        LoadProfileItems(ProfileName, SourceTypeCode)

        ProfileName = "Graphics Files"
        SourceTypeCode = ".gif"

        LoadProfileItems(ProfileName, SourceTypeCode)

        ProfileName = "Graphics Files"
        SourceTypeCode = ".tif"

        LoadProfileItems(ProfileName, SourceTypeCode)

        ProfileName = "Graphics Files"
        SourceTypeCode = ".tiff"

        LoadProfileItems(ProfileName, SourceTypeCode)

        ProfileName = "Graphics Files"
        SourceTypeCode = ".jpg"

        LoadProfileItems(ProfileName, SourceTypeCode)

        ProfileName = "Graphics Files"
        SourceTypeCode = ".bmp"

        LoadProfileItems(ProfileName, SourceTypeCode)

        ProfileName = "Graphics Files"
        SourceTypeCode = ".png"

        LoadProfileItems(ProfileName, SourceTypeCode)

        '*********************************************************************

        ProfileName = "Source Code - VB"
        SourceTypeCode = ".vb"

        LoadProfileItems(ProfileName, SourceTypeCode)

        ProfileName = "Source Code - VB"
        SourceTypeCode = ".xsd"

        LoadProfileItems(ProfileName, SourceTypeCode)

        ProfileName = "Source Code - VB"
        SourceTypeCode = ".xss"

        LoadProfileItems(ProfileName, SourceTypeCode)

        ProfileName = "Source Code - VB"
        SourceTypeCode = ".xsc"

        LoadProfileItems(ProfileName, SourceTypeCode)

        ProfileName = "Source Code - VB"
        SourceTypeCode = ".ico"

        LoadProfileItems(ProfileName, SourceTypeCode)

        ProfileName = "Source Code - VB"
        SourceTypeCode = ".rpt"

        LoadProfileItems(ProfileName, SourceTypeCode)

        ProfileName = "Source Code - VB"
        SourceTypeCode = ".rdlc"

        LoadProfileItems(ProfileName, SourceTypeCode)

        ProfileName = "Source Code - VB"
        SourceTypeCode = ".resx"

        LoadProfileItems(ProfileName, SourceTypeCode)

        ProfileName = "Source Code - VB"
        SourceTypeCode = ".sql"

        LoadProfileItems(ProfileName, SourceTypeCode)

        ProfileName = "Source Code - VB"
        SourceTypeCode = ".xml"

        LoadProfileItems(ProfileName, SourceTypeCode)

        ProfileName = "Source Code - VB"
        SourceTypeCode = ".sln"

        LoadProfileItems(ProfileName, SourceTypeCode)

        ProfileName = "Source Code - VB"
        SourceTypeCode = ".vbx"

        LoadProfileItems(ProfileName, SourceTypeCode)


    End Sub

    Function valLoadProfile() As Boolean
        Dim ProfileName As String = ""
        Dim ProfileDesc As String = ""

        ProfileName = "Graphics Files"
        ProfileDesc = "Known graphic file types"
        LoadProfile(ProfileName, ProfileDesc)

        ProfileName = "Office Documents"
        ProfileDesc = "MS Office files"
        LoadProfile(ProfileName, ProfileDesc)

        ProfileName = "Source Code - VB"
        ProfileDesc = "Development/Application files from VB Projects"
        LoadProfile(ProfileName, ProfileDesc)

        ProfileName = "Source Code - C#"
        ProfileDesc = "Development/Application files from C# Projects"
        LoadProfile(ProfileName, ProfileDesc)

    End Function

    Sub LoadProfile(ByVal ProfileName As String, ByVal ProfileDesc As String)
        Try
            Dim S As String = "Select COUNT(*) from [LoadProfile] where ProfileName = '" + ProfileName + "'"
            Dim iCnt As Integer = DBARCH.iCount(S)
            If iCnt = 0 Then
                Dim InsertSql As String = "INSERT INTO LoadProfile (ProfileName,ProfileDesc) VALUES ('" + ProfileName + "','" + ProfileName + "')"
                Dim B As Boolean = DBARCH.ExecuteSqlNewConn(90605, InsertSql)
                If Not B Then
                    LOG.WriteToArchiveLog("ERROR: LoadProfile 100a - " + vbCrLf + InsertSql)
                End If
            End If
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: LoadProfile 100 - " + ex.Message + vbCrLf + ProfileName)
        End Try


    End Sub

    Sub LoadProfileItems(ByVal ProfileName As String, ByVal SourceTypeCode As String)
        Try
            Dim S As String = "Select COUNT(*) FROM [LoadProfileItem] where [ProfileName] = '" + ProfileName + "' and SourceTypeCode = '" + SourceTypeCode + "'"
            Dim iCnt As Integer = DBARCH.iCount(S)
            If iCnt = 0 Then
                Dim InsertSql As String = "INSERT INTO [LoadProfileItem] ([ProfileName] ,[SourceTypeCode]) VALUES ('" + ProfileName + "','" + SourceTypeCode + "')"
                Dim B As Boolean = DBARCH.ExecuteSqlNewConn(90606, InsertSql)
                If Not B Then

                    InsertSql = "Insert AvailFileTypes (ExtCode) Values ('" + SourceTypeCode + "')"
                    AvailFileTypesExist(SourceTypeCode, InsertSql)

                    SourceTypeExist(SourceTypeCode, "AUTO Defined by System", "0")

                    InsertSql = "INSERT INTO [LoadProfileItem] ([ProfileName] ,[SourceTypeCode]) VALUES ('" + ProfileName + "','" + SourceTypeCode + "')"
                    B = DBARCH.ExecuteSqlNewConn(90607, InsertSql)

                    If Not B Then
                        LOG.WriteToArchiveLog("ERROR: LoadProfileItems 100a - " + vbCrLf + InsertSql)
                    End If

                End If
            End If
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: LoadProfileItems 100 - " + ex.Message + vbCrLf + ProfileName + " : " + SourceTypeCode)
        End Try


    End Sub

    Sub SetDefaultUserParms(ByVal UserGuid As String)
        Dim SI As New clsSAVEDITEMS

        Dim SaveName As String = "UserStartUpParameters"
        Dim SaveTypeCode As String = "StartUpParm"

        Dim TempDir As String = System.IO.Path.GetTempPath
        Dim b As Integer = DBARCH.ckUserStartUpParameter(UserGuid, "CONTENT WORKING DIRECTORY")
        If b = 0 Then
            SI.setSavename(SaveName)
            SI.setSavetypecode(SaveTypeCode)
            SI.setUserid(UserGuid)
            SI.setValname("CONTENT WORKING DIRECTORY")
            SI.setValvalue(TempDir)
            SI.Insert()
        End If

        b = DBARCH.ckUserStartUpParameter(UserGuid, "EMAIL WORKING DIRECTORY")
        If b = 0 Then
            SI.setSavename(SaveName)
            SI.setSavetypecode(SaveTypeCode)
            SI.setUserid(UserGuid)
            SI.setValname("EMAIL WORKING DIRECTORY")
            SI.setValvalue(TempDir)
            SI.Insert()
        End If

        b = DBARCH.ckUserStartUpParameter(UserGuid, "RETENTION YEARS")
        If b = 0 Then
            SI.setSavename(SaveName)
            SI.setSavetypecode(SaveTypeCode)
            SI.setUserid(UserGuid)
            SI.setValname("RETENTION YEARS")
            SI.setValvalue("10")
            SI.Insert()
        End If

        b = DBARCH.ckUserStartUpParameter(UserGuid, "DBARCH WARNING LEVEL")
        If b = 0 Then
            SI.setSavename(SaveName)
            SI.setSavetypecode(SaveTypeCode)
            SI.setUserid(UserGuid)
            SI.setValname("DBARCH WARNING LEVEL")
            SI.setValvalue("100")
            SI.Insert()
        End If
        b = DBARCH.ckUserStartUpParameter(UserGuid, "DBARCH RETURN INCREMENT")
        If b = 0 Then
            SI.setSavename(SaveName)
            SI.setSavetypecode(SaveTypeCode)
            SI.setUserid(UserGuid)
            SI.setValname("DBARCH RETURN INCREMENT")
            SI.setValvalue("50")
            SI.Insert()
        End If
        SI = Nothing
    End Sub
    Public Sub addDefaultAttributes(ByVal AttributeName As String, ByVal AttributeDataType As String, ByVal AttributeDesc As String, ByVal AssoApplication As String)

        AttributeName = UTIL.RemoveSingleQuotes(AttributeName)
        AttributeDataType = UTIL.RemoveSingleQuotes(AttributeDataType)
        AttributeDesc = UTIL.RemoveSingleQuotes(AttributeDesc)
        AssoApplication = UTIL.RemoveSingleQuotes(AssoApplication)

        If AttributeDataType.Length = 0 Then
            AttributeDataType = "varchar"
        End If
        If AttributeDesc.Length = 0 Then
            AttributeDesc = "Varchar used as none Supplied at this time."
        End If
        If AssoApplication.Length = 0 Then
            AssoApplication = "Unspecified"
        End If

        Dim S As String = ""
        S = S + " INSERT INTO [Attributes]"
        S = S + " ([AttributeName]"
        S = S + " ,[AttributeDataType]"
        S = S + " ,[AttributeDesc]"
        S = S + " ,[AssoApplication])"
        S = S + " VALUES ("
        S = S + " '" + AttributeName + "'"
        S = S + " ,'" + AttributeDataType + "'"
        S = S + " ,'" + AttributeDesc + "'"
        S = S + " ,'" + AssoApplication + "')"

        Dim B As Boolean = False

        B = DBARCH.ExecuteSqlNewConn(S, False)
        If Not B Then
            LOG.WriteToArchiveLog("ERROR 62952.14: Failed to add " + AttributeName + " to list.")
            LOG.WriteToArchiveLog("ERROR 62952.14: Sql Statement " + vbCrLf + S)
        End If

    End Sub

    Sub AddUserSelectableParameters(ByVal UserGuidID As String)


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

    Sub AddDflt(ByVal sKey As String, ByVal sValue As String, ByVal sUser As String)
        Dim RP As New clsRUNPARMS
        Dim iCnt As Integer = RP.cnt_PKI8(sKey, sUser)
        If iCnt = 0 Then
            RP.setParm(sKey)
            RP.setParmvalue(sValue)
            RP.setUserid(sUser)
            RP.Insert()
        End If
        RP = Nothing
    End Sub
    Function addHelpInfo(ByVal HelpName As String, ByVal HelpEmailAddr As String, ByVal HelpPhone As String, ByVal AreaOfFocus As String, ByVal HoursAvail As String, ByVal EmailNotification As Integer) As Boolean
        'INSERT INTO [SourceType]([SourceTypeCode],[StoreExternal],[SourceTypeDesc],[Indexable])VALUES('XX',0,'XX',1)
        Dim B As Boolean = False
        Dim iCnt As Integer = 0
        Dim S As String = " "

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

        B = DBARCH.ExecuteSqlNewConn(90608, S)
        Return B

    End Function

    Sub AddImageCodes()
        Dim B As Boolean = True
        Dim S As String = ""
        S = " INSERT [ImageTypeCodes] ([ImageTypeCode], [ImageTypeCodeDesc]) VALUES (N'.bmp', '')"
        B = DBARCH.ExecuteSqlNewConn(90609, S)
        S = " INSERT [ImageTypeCodes] ([ImageTypeCode], [ImageTypeCodeDesc]) VALUES (N'.emf', NULL)"
        B = DBARCH.ExecuteSqlNewConn(90610, S)
        S = " INSERT [ImageTypeCodes] ([ImageTypeCode], [ImageTypeCodeDesc]) VALUES (N'.gif', '')"
        B = DBARCH.ExecuteSqlNewConn(90611, S)
        S = " INSERT [ImageTypeCodes] ([ImageTypeCode], [ImageTypeCodeDesc]) VALUES (N'.ico', '')"
        B = DBARCH.ExecuteSqlNewConn(90612, S)
        S = " INSERT [ImageTypeCodes] ([ImageTypeCode], [ImageTypeCodeDesc]) VALUES (N'.jpeg', NULL)"
        B = DBARCH.ExecuteSqlNewConn(90613, S)
        S = " INSERT [ImageTypeCodes] ([ImageTypeCode], [ImageTypeCodeDesc]) VALUES (N'.jpg', '')"
        B = DBARCH.ExecuteSqlNewConn(90614, S)
        S = " INSERT [ImageTypeCodes] ([ImageTypeCode], [ImageTypeCodeDesc]) VALUES (N'.png', '')"
        B = DBARCH.ExecuteSqlNewConn(90615, S)
        S = " INSERT [ImageTypeCodes] ([ImageTypeCode], [ImageTypeCodeDesc]) VALUES (N'.tif', '')"
        B = DBARCH.ExecuteSqlNewConn(90616, S)
        S = " INSERT [ImageTypeCodes] ([ImageTypeCode], [ImageTypeCodeDesc]) VALUES (N'.tiff', '')"
        B = DBARCH.ExecuteSqlNewConn(90617, S)
        S = " INSERT [ImageTypeCodes] ([ImageTypeCode], [ImageTypeCodeDesc]) VALUES (N'.trf', 'Proprietary document storage format of Documagix processed a an image file using ECM OCR.')"
        B = DBARCH.ExecuteSqlNewConn(90618, S)
        S = " INSERT [ImageTypeCodes] ([ImageTypeCode], [ImageTypeCodeDesc]) VALUES (N'.wmf', NULL)"
        B = DBARCH.ExecuteSqlNewConn(90619, S)
    End Sub

End Class

