
ECHO OFF

C:
cd "C:\Program Files\7-Zip"

ROBOCOPY D:\dev\EcmMasterSingleSource\ECM\_ECMInstall\_PS_Parsenal\InstallDocumentation E:\ECM_Install\_Documentation\$Setup /MIR

xcopy D:\dev\EcmMasterSingleSource\ECM\_ECMInstall\_PS_Parsenal\ECM.PS.VARS.txt D:\PrepublishedWebSites\ECMSaaS\_PSscripts /y
xcopy D:\dev\EcmMasterSingleSource\ECM\_ECMInstall\_PS_Parsenal\*.ps1  D:\PrepublishedWebSites\ECMSaaS\_PSscripts /y


robocopy D:\dev\EcmMasterSingleSource\ECM\ECMSaaS\ServerSideOCR\OcrInstallV3\Debug E:\PrePublishedWebSites\ECMSAAS\ServerSideOCR\ /mir /xo /r:1 /w:1

if EXIST "E:\PrePublishedWebSites\ECMSAAS\_Software\ServerSideOCR.zip" (
	echo !! !! !! EXIST "E:\PrePublishedWebSites\ECMSAAS\_Software\ServerSideOCR.zip"
)
if NOT EXIST "E:\PrePublishedWebSites\ECMSAAS\_Software\ServerSideOCR.zip" (
	echo !! !! !! NOT EXIST "E:\PrePublishedWebSites\ECMSAAS\_Software\ServerSideOCR.zip"
	7z u -r "E:\PrePublishedWebSites\ECMSAAS\_Software\ServerSideOCR.zip" "D:\dev\EcmMasterSingleSource\ECM\ECMSaaS\ServerSideOCR\OcrInstallV3\Debug\*.*"   
)



7z u -pEcm2020 "E:\PrePublishedWebSites\ECMSAAS\EcmUploadZip\ServerSideOCR\ServerSideOCR.zip" "D:\dev\EcmMasterSingleSource\ECM\ECMSaaS\ServerSideOCR\OcrInstall\OcrInstall\Express\DVD-5\DiskImages\DISK1\*.*" && (
  echo 01-A was successful ******************************************************
) || (
  echo   @@@@@ @@@@@ @@@@@ @@@@@ @@@@@ 01-A failed
  pause
)

7z u -pEcm2020 "E:\PrePublishedWebSites\ECMSAAS\EcmUploadZip\SVCGatewayAdmin\ECMInstall.zip" "D:\PrePublishedWebSites\ECMSAAS\SVCGatewayAdmin\*.*" && ( 
  echo 02 was successful ******************************************************
) || (  
   echo   @@@@@ @@@@@ @@@@@ @@@@@ @@@@@ 02 failed
   pause
)



7z u -r -pEcm2020 "E:\PrePublishedWebSites\ECMSAAS\EcmUploadZip\ServerSideOCR\ServerSideOcr.zip" "D:\dev\EcmMasterSingleSource\ECM\ECMSaaS\ServerSideOCR\OcrInstall\OcrInstall\Express\DVD-5\DiskImages\DISK1\*.*" && (
  echo 03 was successful ******************************************************
) || (
  echo @@@@@ @@@@@ @@@@@ @@@@@ @@@@@ 03 failed
  pause
)


7z u -r -pEcm2020 "E:\PrePublishedWebSites\ECMSAAS\EcmUploadZip\ServerSideOCR\ServerSideOcr.zip" "D:\dev\EcmMasterSingleSource\ECM\ECMSaaS\ServerSideOCR\ConsoleArchiver\ServerSideOCR.bat" && (
  echo 04 was successful ******************************************************
) || (
  echo @@@@@ @@@@@ @@@@@ @@@@@ @@@@@ 04 failed
  pause
)
rem pause

7z u -pSvr2016@01 "E:\PrePublishedWebSites\ECMSAAS\EcmUploadZip\PS_ECMInstall\ECMInstall.zip" "D:\dev\EcmMasterSingleSource\ECM\_ECMInstall\_PowerShellInstallScripts_Parsenal\*.ps1" && (
  echo 05 was successful ******************************************************
) || (
  echo @@@@@ @@@@@ @@@@@ @@@@@ @@@@@ 05 failed
  pause
)
rem pause

7z u -r -pEcm2020 "E:\PrePublishedWebSites\ECMSAAS\EcmUploadZip\GateWayAdmin\GateWayAdmin.zip" "D:\PrePublishedWebSites\ECMSAAS\GateWayAdmin\*.*" && (
  echo 06 was successful ******************************************************
) || (
  echo @@@@@ @@@@@ @@@@@ @@@@@ @@@@@ 06 failed
  pause
)
rem pause

7z u -r -pEcm2020 "E:\PrePublishedWebSites\ECMSAAS\EcmUploadZip\Archiver\Archiver.zip" "D:\PrePublishedWebSites\ECMSaaS\Archiver\*.*" && (
  echo 07 was successful ******************************************************
) || (
  echo @@@@@ @@@@@ @@@@@ @@@@@ @@@@@ 07 failed
  pause
)
rem pause

7z u -r -pEcm2020 "E:\PrePublishedWebSites\ECMSAAS\EcmUploadZip\ArchiveSVC\ArchiveSVC.zip" "D:\PrePublishedWebSites\ECMSaaS\Archive\*.*" && (
  echo 08 was successful ******************************************************
) || (
  echo @@@@@ @@@@@ @@@@@ @@@@@ @@@@@ 08 failed
  pause
)
rem pause

7z u -r -pEcm2020 "E:\PrePublishedWebSites\ECMSaaS\ArchiveFS\ArchiveFS.zip" "D:\PrePublishedWebSites\ECMSaaS\ArchiveFS\*.*" && (
  echo 09 was successful ******************************************************
) || (
  echo @@@@@ @@@@@ @@@@@ @@@@@ @@@@@ 09 failed
  pause
)
rem pause

7z u -r -pEcm2020 "E:\PrePublishedWebSites\ECMSAAS\EcmUploadZip\Search\Search.zip" "D:\PrePublishedWebSites\ECMSaaS\Search\*.*" && (
  echo 10 was successful ******************************************************
) || (
  echo @@@@@ @@@@@ @@@@@ @@@@@ @@@@@ 10 failed
  pause
)
rem pause

wdmxx
7z u -r -pEcm2020 "E:\PrePublishedWebSites\ECMSAAS\EcmUploadZip\SecureAttachAdmin\SecureAttachAdmin.zip" "D:\PrePublishedWebSites\ECMSaaS\SecureAttachAdmin\*.*" && (
  echo 11 was successful ******************************************************
) || (
  echo @@@@@ @@@@@ @@@@@ @@@@@ @@@@@ 11 failed
  pause
)

7z u -r -pEcm2020 "E:\PrePublishedWebSites\ECMSAAS\EcmUploadZip\SecureAttachAdminSvc\SecureAttachAdminSvc.zip" "D:\PrePublishedWebSites\ECMSaaS\SecureAttachAdminSvc\*.*" && (
  echo 11 was successful ******************************************************
) || (
  echo @@@@@ @@@@@ @@@@@ @@@@@ @@@@@ 11 failed
  pause
)
rem pause

7z u -r -pEcm2020 "E:\PrePublishedWebSites\ECMSAAS\EcmUploadZip\EncryptString\EncryptString.zip" "D:\PrePublishedWebSites\EncryptString\*.*" && (
  echo 12 was successful ******************************************************
) || (
  echo @@@@@ @@@@@ @@@@@ @@@@@ @@@@@ 12 failed
  pause
)
rem pause

7z u -r -pSvr2016@01 "E:\PrePublishedWebSites\ECMSAAS\EcmUploadZip\Encryption\Encryption.zip" "D:\PrePublishedWebSites\ECMSAAS\Encryption\*.*" && (
  echo 13 was successful ******************************************************
) || (
  echo @@@@@ @@@@@ @@@@@ @@@@@ @@@@@ 13 failed
  pause
)
rem pause

7z u -r -pEcm2020 "E:\PrePublishedWebSites\ECMSAAS\EcmUploadZip\EcmAdminSetup\EcmAdminSetup.zip" "D:\PrePublishedWebSites\ECMSAAS\AdminSetup\*.*" && (
  echo 14 was successful ******************************************************
) || (
  echo @@@@@ @@@@@ @@@@@ @@@@@ @@@@@ 14 failed
  pause
)
rem pause

7z u -r -pEcm2020 "E:\PrePublishedWebSites\ECMSAAS\EcmUploadZip\ClcDownloader\VSDownloader.zip" "D:\dev\EcmMasterSingleSource\ECM\DownloaderVSinstaller\DownloaderVSinstaller\Debug\*.*" && (
  echo 15 was successful ******************************************************
) || (
  echo @@@@@ @@@@@ @@@@@ @@@@@ @@@@@ 15 failed
  pause
)
rem pause


if EXIST "E:\PrePublishedWebSites\ECMSAAS\EcmUploadZip\EcmDBScripts\EcmDBScripts.zip" (
	echo !! !! !! EXIST "E:\PrePublishedWebSites\ECMSAAS\EcmUploadZip\EcmDBScripts\EcmDBScripts.zip"
)
if NOT EXIST "E:\PrePublishedWebSites\ECMSAAS\_Software\7z.zip" (
	rem **********************************************************************************************************************************************************
	7z u -r -pEcm2020 "E:\PrePublishedWebSites\ECMSAAS\EcmUploadZip\EcmDBScripts\EcmDBScripts.zip" "D:\dev\EcmMasterSingleSource\ECM\_DatabaseGenerationScripts\July.17.2017\*.*" 

	7z u -r -pEcm2020 "E:\PrePublishedWebSites\ECMSAAS\EcmUploadZip\EcmDBScripts\EcmDBScripts.zip" "D:\dev\EcmMasterSingleSource\ECM\_DatabaseGenerationScripts\_ECM.Thesaurus.Table.And.Data.Creation.sql" 
	rem **********************************************************************************************************************************************************
)

rem robocopy D:\dev\EcmMasterSingleSource\ECM\_ECMInstall\_Software E:\PrePublishedWebSites\ECMSAAS\_Software\ /mir /xo /r:1 /w:1

robocopy D:\dev\EcmMasterSingleSource\ECM\_ECMInstall\_Software\7Zip E:\PrePublishedWebSites\ECMSAAS\_Software\7z_Install /mir /xo /r:1 /w:1

if EXIST "E:\PrePublishedWebSites\ECMSAAS\_Software\7z.zip" (
echo !! !! !! EXIST "E:\PrePublishedWebSites\ECMSAAS\_Software\7z.zip"
)
if NOT EXIST "E:\PrePublishedWebSites\ECMSAAS\_Software\7z.zip" (
echo !! !! !! NOT EXIST "E:\PrePublishedWebSites\ECMSAAS\_Software\7z.zip"
7z u -r "E:\PrePublishedWebSites\ECMSAAS\_Software\7z.zip" "D:\dev\EcmMasterSingleSource\ECM\_ECMInstall\_Software\7Zip\*.*"   
)

if EXIST "E:\PrePublishedWebSites\ECMSAAS\_Software\iFilters.zip" (
	ECHO "*** ->> EXISTS --> E:\PrePublishedWebSites\ECMSAAS\_Software\iFilters.zip"
)
if NOT EXIST "E:\PrePublishedWebSites\ECMSAAS\_Software\iFilters.zip" (
	7z u -r "E:\PrePublishedWebSites\ECMSAAS\_Software\iFilters.zip" "D:\dev\EcmMasterSingleSource\ECM\_ECMInstall\_Software\iFilters\*.*"   
)

if EXIST "E:\PrePublishedWebSites\ECMSAAS\_Software\Office2007.zip" (
	ECHO "*** ->> EXISTS --> E:\PrePublishedWebSites\ECMSAAS\_Software\Office2007.zip"
)
if NOT EXIST "E:\PrePublishedWebSites\ECMSAAS\_Software\Office2007.zip" (
	7z u -r "E:\PrePublishedWebSites\ECMSAAS\_Software\Office2007.zip" "D:\dev\EcmMasterSingleSource\ECM\_ECMInstall\_Software\Office2007\*.*"   
)

if EXIST "E:\PrePublishedWebSites\ECMSAAS\_Software\PowerShell_5.0.zip" (
	ECHO "*** ->> EXISTS --> E:\PrePublishedWebSites\ECMSAAS\_Software\PowerShell_5.0.zip"
)
if NOT EXIST "E:\PrePublishedWebSites\ECMSAAS\_Software\PowerShell_5.0.zip" (
	7z u -r "E:\PrePublishedWebSites\ECMSAAS\_Software\PowerShell_5.0.zip" "D:\dev\EcmMasterSingleSource\ECM\_ECMInstall\_Software\PowerShell_5.0\*.*"   
)

if EXIST "E:\PrePublishedWebSites\ECMSAAS\_Software\SharePointDesignerMODI.zip" (
	ECHO "*** ->> EXISTS --> E:\PrePublishedWebSites\ECMSAAS\_Software\SharePointDesignerMODI.zip"
)
if NOT EXIST "E:\PrePublishedWebSites\ECMSAAS\_Software\SharePointDesignerMODI.zip" (
	7z u -r "E:\PrePublishedWebSites\ECMSAAS\_Software\SharePointDesignerMODI.zip" "D:\dev\EcmMasterSingleSource\ECM\_ECMInstall\_Software\SharePointDesignerMODI\*.*"   
)
if NOT EXIST "E:\PrePublishedWebSites\ECMSAAS\_Software\Cygwin.zip" (
	7z u -r "E:\PrePublishedWebSites\ECMSAAS\_Software\Cygwin.zip" "D:\dev\EcmMasterSingleSource\ECM\_ECMInstall\_Software\Cygwin\*.*"   
)

pause