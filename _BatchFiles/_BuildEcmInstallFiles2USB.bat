

ROBOCOPY D:\dev\EcmMasterSingleSource\ECM\_ECMInstall\_PS_Parsenal\InstallDocumentation E:\ECM_Install\_Documentation\$Setup /MIR
d:
cd D:\dev\EcmMasterSingleSource\ECM\_DatabaseGenerationScripts\DBScriptsLatest
call BuildMaster.bat

ROBOCOPY D:\dev\EcmMasterSingleSource\ECM\_ECMInstall\_PS_Parsenal\InstallDocumentation E:\ECM_Install\_Documentation\$Setup /MIR

xcopy D:\dev\EcmMasterSingleSource\ECM\_ECMInstall\_PS_Parsenal\ECM.PS.VARS.txt D:\PrepublishedWebSites\ECMSaaS\_PSscripts /y
xcopy D:\dev\EcmMasterSingleSource\ECM\_ECMInstall\_PS_Parsenal\*.ps1  D:\PrepublishedWebSites\ECMSaaS\_PSscripts /y

rem del D:\PrepublishedWebSites\ECMSaaS\DBScripts\*.*
DEL /F/Q/S D:\PrepublishedWebSites\ECMSaaS\DBScripts\*.* > NUL

xcopy D:\dev\EcmMasterSingleSource\ECM\_DatabaseGenerationScripts\DBScriptsLatest\01*.sql D:\PrepublishedWebSites\ECMSaaS\DBScripts /y
xcopy D:\dev\EcmMasterSingleSource\ECM\_DatabaseGenerationScripts\DBScriptsLatest\MasterDBBuild.bat D:\PrepublishedWebSites\ECMSaas\DBScripts /y

ROBOCOPY D:\PrepublishedWebSites\ECMSaaS E:\PrepublishedWebSites\ECMSaaS /MIR



