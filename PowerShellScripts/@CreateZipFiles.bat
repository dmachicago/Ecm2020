
ECHO OFF

C:
cd "C:\Program Files\7-Zip"

7z u -pEcm2018 "D:\PrePublishedWebSites\ECMSAAS\_PSscripts\PSscripts.zip" "D:\dev\EcmMasterSingleSource\ECM\_ECMInstall\_PS_Parsenal\*.*"

7z u -pEcm2018 -r "D:\PrePublishedWebSites\ECMSAAS\_Software\SecureAttachAdminWF.zip" "D:\PrepublishedWebSites\ECMSaaS\SecureAttachAdminWF\*.*"   
7z u -pEcm2018 -r "D:\PrePublishedWebSites\ECMSAAS\_Software\SecureAttachAdminWPF.zip" "D:\PrepublishedWebSites\ECMSaaS\SecureAttachAdmin\*.*"   
7z u -pEcm2018 -r "D:\PrePublishedWebSites\ECMSAAS\_Software\ServerSideOCR.zip" "D:\PrepublishedWebSites\ECMSaaS\ServerSideOCR\*.*"   
7z u -pEcm2018 "D:\PrePublishedWebSites\ECMSAAS\EcmUploadZip\SVCGatewayAdmin\ECMInstall.zip" "D:\PrePublishedWebSites\ECMSAAS\SVCGatewayAdmin\*.*"
7z u -r "D:\PrePublishedWebSites\ECMSAAS\_Software\CmdEncryptInstall.zip" "D:\dev\EcmMasterSingleSource\ECM\_EncryptString\CmdEncryptInstall\CmdEncryptInstall\Express\DVD-5\DiskImages\DISK1\*.*"   
7z u -pEcm2018 "D:\PrePublishedWebSites\ECMSAAS\EcmUploadZip\SVCclcDownload\SVCclcDownload.zip" "D:\PrepublishedWebSites\ECMSaaS\SVCclcDownload\*.*"
7z u -r -pEcm2018 "D:\PrePublishedWebSites\ECMSAAS\EcmUploadZip\ServerSideOCR\ServerSideOcr.zip" "D:\dev\EcmMasterSingleSource\ECM\ECMSaaS\ServerSideOCR\ConsoleArchiver\ServerSideOCR.bat"
7z u -r -pEcm2018 "D:\PrePublishedWebSites\ECMSAAS\EcmUploadZip\PS_ECMInstall\ECMInstall.zip" "D:\dev\EcmMasterSingleSource\ECM\_ECMInstall\_PS_Parsenal\*.ps1"
7z u -r -pEcm2018 "D:\PrePublishedWebSites\ECMSAAS\EcmUploadZip\GateWayAdmin\GateWayAdmin.zip" "D:\PrePublishedWebSites\ECMSAAS\GateWayAdmin\*.*"
7z u -r -pEcm2018 "D:\PrePublishedWebSites\ECMSAAS\EcmUploadZip\Archiver\Archiver.zip" "D:\PrePublishedWebSites\ECMSaaS\Archiver\*.*"
7z u -r -pEcm2018 "D:\PrePublishedWebSites\ECMSAAS\EcmUploadZip\ArchiveSVC\ArchiveSVC.zip" "D:\PrePublishedWebSites\ECMSaaS\Archive\*.*"
7z u -r -pEcm2018 "D:\PrePublishedWebSites\ECMSaaS\ArchiveFS\ArchiveFS.zip" "D:\PrePublishedWebSites\ECMSaaS\ArchiveFS\*.*"
7z u -r -pEcm2018 "D:\PrePublishedWebSites\ECMSAAS\EcmUploadZip\Search\Search.zip" "D:\PrePublishedWebSites\ECMSaaS\Search\*.*"
7z u -r -pEcm2018 "D:\PrePublishedWebSites\ECMSAAS\EcmUploadZip\SecureAttachAdmin\SecureAttachAdmin.zip" "D:\PrePublishedWebSites\ECMSaaS\SecureAttachAdmin\*.*"
7z u -r -pEcm2018 "D:\PrePublishedWebSites\ECMSAAS\EcmUploadZip\SecureAttachAdminSvc\SecureAttachAdminSvc.zip" "D:\PrePublishedWebSites\ECMSaaS\SecureAttachAdminSvc\*.*"
7z u -r -pEcm2018 "D:\PrePublishedWebSites\ECMSAAS\EcmUploadZip\EncryptString\EncryptString.zip" "D:\PrePublishedWebSites\EncryptString\*.*"

7z u -r -pSvr2016@01 "D:\PrePublishedWebSites\ECMSAAS\EcmUploadZip\Encryption\Encryption.zip" "D:\PrePublishedWebSites\ECMSAAS\Encryption\*.*"
7z u -r -pEcm2018 "D:\PrePublishedWebSites\ECMSAAS\EcmUploadZip\EcmAdminSetup\EcmAdminSetup.zip" "D:\PrePublishedWebSites\ECMSAAS\AdminSetup\*.*"
7z u -r -pEcm2018 "D:\PrePublishedWebSites\ECMSAAS\EcmUploadZip\ClcDownloader\ClcDownloader.zip" "D:\dev\EcmMasterSingleSource\ECM\DownloaderVSinstaller\DownloaderVSinstaller\Debug\*.*"

7z u -r -pEcm2018 "D:\PrePublishedWebSites\ECMSAAS\EcmUploadZip\EcmDBScripts\EcmDBScripts.zip" "D:\dev\EcmMasterSingleSource\ECM\_DatabaseGenerationScripts\July.17.2017\*.*" 

7z u -r -pEcm2018 "D:\PrePublishedWebSites\ECMSAAS\EcmUploadZip\EcmDBScripts\EcmDBScripts.zip" "D:\dev\EcmMasterSingleSource\ECM\_DatabaseGenerationScripts\_ECM.Thesaurus.Table.And.Data.Creation.sql" 


robocopy D:\dev\EcmMasterSingleSource\ECM\_ECMInstall\_Software\7Zip D:\PrePublishedWebSites\ECMSAAS\_Software\7z_Install /mir /xo /r:1 /w:1

7z u -r "D:\PrePublishedWebSites\ECMSAAS\_Software\7z.zip" "D:\dev\EcmMasterSingleSource\ECM\_ECMInstall\_Software\7Zip\*.*"   
7z u -r "D:\PrePublishedWebSites\ECMSAAS\_Software\iFilters.zip" "D:\dev\EcmMasterSingleSource\ECM\_ECMInstall\_Software\iFilters\*.*"   
7z u -r "D:\PrePublishedWebSites\ECMSAAS\_Software\Office2007.zip" "D:\dev\EcmMasterSingleSource\ECM\_ECMInstall\_Software\Office2007\*.*"   
7z u -r "D:\PrePublishedWebSites\ECMSAAS\_Software\PowerShell_5.0.zip" "D:\dev\EcmMasterSingleSource\ECM\_ECMInstall\_Software\PowerShell_5.0\*.*"   
7z u -r "D:\PrePublishedWebSites\ECMSAAS\_Software\SharePointDesignerMODI.zip" "D:\dev\EcmMasterSingleSource\ECM\_ECMInstall\_Software\SharePointDesignerMODI\*.*"   
7z u -r "D:\PrePublishedWebSites\ECMSAAS\_Software\Cygwin.zip" "D:\dev\EcmMasterSingleSource\ECM\_ECMInstall\_Software\Cygwin\*.*"   

pause