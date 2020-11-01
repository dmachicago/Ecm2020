
ROBOCOPY D:\PrePublishedWebSites\ECMSAAS\Encryption2way E:\ECM_Install\EncryptUtility /MIR
ROBOCOPY D:\PrepublishedWebSites\ECMSaaS\SVCclcDownload E:\ECM_Install\SVCclcDownload /MIR
ROBOCOPY D:\PrePublishedWebSites\ECMSaaS\SearchSVC E:\ECM_Install\SearchSVC /MIR
robocopy "D:\dev\EcmMasterSingleSource\ECM\_ECMInstall\_Software" E:\ECM_Install\Software /mir /xo
robocopy "D:\dev\EcmMasterSingleSource\ECM\_ECMInstall\_7z" "E:\ECM_Install\7z" /mir
robocopy D:\PrePublishedWebSites\ECMSAAS\Encryption E:\ECM_Install\Encryption /mir /xo

rem http://ecmlibrary/ECMSaaS/ClcDownloader
rem robocopy D:\PrePublishedWebSites\ECMSaaS\clcDownloader E:\ECM_Install\ClcDownloader /mir /xo

d:
cd D:\dev\EcmMasterSingleSource\ECM\_DatabaseGenerationScripts\DBScriptsLatest

call BuildMaster.bat

cd D:\dev\EcmMasterSingleSource

ROBOCOPY D:\dev\EcmMasterSingleSource\ECM\_ECMInstall\_PS_Parsenal\InstallDocumentation E:\ECM_Install\_Documentation\$Setup /MIR

xcopy D:\dev\EcmMasterSingleSource\ECM\_ECMInstall\_PS_Parsenal\ECM.PS.VARS.txt D:\PrepublishedWebSites\ECMSaaS\_PSscripts /y
xcopy D:\dev\EcmMasterSingleSource\ECM\_ECMInstall\_PS_Parsenal\*.ps1  D:\PrepublishedWebSites\ECMSaaS\_PSscripts /y

ROBOCOPY D:\PrepublishedWebSites\ECMSaaS\_PSscripts E:\ECM_Install\PowerShellscripts /MIR

xcopy D:\dev\EcmMasterSingleSource\ECM\_DatabaseGenerationScripts\DBScriptsLatest\01*.sql E:\ECM_Install\ECMSaas\DBScripts /y
xcopy D:\dev\EcmMasterSingleSource\ECM\_DatabaseGenerationScripts\DBScriptsLatest\MasterDBBuild.bat E:\ECM_Install\ECMSaas\DBScripts /y

rem File Archiver
ROBOCOPY D:\PrePublishedWebSites\ECMSaaS\Archiver E:\ECM_Install\Archiver /MIR
rem File Archiver Service
ROBOCOPY D:\PrePublishedWebSites\ECMSaaS\Archive E:\ECM_Install\Archive /MIR
rem Archiver File Service
ROBOCOPY D:\PrePublishedWebSites\ECMSaaS\ArchiveFS E:\ECM_Install\ArchiveFS /MIR
rem Gateway Service
ROBOCOPY D:\PrePublishedWebSites\ECMSaaS\SecureAttachAdminSvc E:\ECM_Install\SecureAttachAdminSvc /MIR

rem Search Application
ROBOCOPY D:\PrepublishedWebSites\ECMSearchWPF E:\ECM_Install\ECMSearchWPF /MIR
rem Secure Attach Service
ROBOCOPY D:\PrePublishedWebSites\ECMSaaS\SecureAttachAdminSvc E:\ECM_Install\SecureAttachAdminSvc /MIR

rem License and MOSTLY UNUSED
rem D:\PrePublishedWebSites\ECMSAAS\AdminSetup\

REM Installed from a Website http://ecmlibrary/ECMSaaS/ClcDownloader/
ROBOCOPY D:\PrePublishedWebSites\ECMSaaS\clcDownloader E:\ECM_Install\clcDownloader /MIR

rem CD type Install
ROBOCOPY D:\PrePublishedWebSites\ECMSAAS\ServerSideOCR E:\ECM_Install\ServerSideOCR /MIR
