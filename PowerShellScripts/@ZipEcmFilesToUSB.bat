
cd C:\Program Files\7-Zip

robocopy "D:\dev\EcmMasterSingleSource\ECM\_ECMInstall\_Software" f:\Software /mir /xo

robocopy "D:\dev\EcmMasterSingleSource\ECM\_ECMInstall\_7z" "f:\7z" /mir

REM #SSIS

7z u -r -mx7 f:\_PowerShellScripts.7z D:\dev\EcmMasterSingleSource\ECM\_ECMInstall\_PS_PArsenal\*.* -pCondor2019

7z u -r -mx7 f:\DBScripts.7z D:\dev\EcmMasterSingleSource\ECM\_DatabaseGenerationScripts\DBScriptsLatest\*.* -pCondor2019

7z u -r -mx7 f:\ECM.FS.SSIS.7z D:\dev\EcmMasterSingleSource\ECM\_ECM_SSIS\ECM.FS\*.* -pCondor2019

7z u -r -mx7 f:\ECM.Encryption.7z D:\PrePublishedWebSites\ECMSAAS\Encryption\*.* -pCondor2019

7z u -r -mx7 f:\ECM.ServerSideOCR.7z D:\PrepublishedWebSites\ECMSaaS\ServerSideOCR\*.* -pCondor2019

7z u -r -mx7 f:\Archiver.7z D:\PrePublishedWebSites\ECMSaaS\Archiver\*.* -pCondor2019
7z u -r -mx7 f:\Archive.7z D:\PrePublishedWebSites\ECMSaaS\Archive\*.* -pCondor2019
7z u -r -mx7 f:\ArchiveFS.7z D:\PrePublishedWebSites\ECMSaaS\ArchiveFS\*.* -pCondor2019

7z u -r -mx7 f:\EcmSVC.7z D:\PrepublishedWebSites\ECM2019\EcmSVC\*.* -pCondor2019
7z u -r -mx7 f:\EcmWPF.7z D:\PrepublishedWebSites\ECM2019\EcmWPF\*.* -pCondor2019

7z u -r -mx7 f:\EcmAttachSVC.7z D:\PrepublishedWebSites\ECM2019\EcmAttachSVC\*.* -pCondor2019
7z u -r -mx7 f:\SVCclcDownload.7z D:\PrepublishedWebSites\ECMSaaS\SVCclcDownload\*.* -pCondor2019

REM ****************************************************************************************************
rem 7z u -r -mx7 f:\Software.7z "D:\dev\EcmMasterSingleSource\ECM\_ECMInstall\_Software\*.*" -pCondor2019

REM #SSIS
7z u -r -mx7 f:\ECM.FS.SSIS.7z D:\dev\EcmMasterSingleSource\ECM\_ECM_SSIS\ECM.FS\*.* -pCondor2019

7z u -r -mx7 f:\ECM.Encryption.7z D:\PrePublishedWebSites\ECMSAAS\Encryption\*.* -pCondor2019

7z u -r -mx7 f:\ECM.ServerSideOCR.7z D:\PrepublishedWebSites\ECMSaaS\ServerSideOCR\*.* -pCondor2019

7z u -r -mx7 f:\Archiver.7z D:\PrePublishedWebSites\ECMSaaS\Archiver\*.* -pCondor2019
7z u -r -mx7 f:\Archive.7z D:\PrePublishedWebSites\ECMSaaS\Archive\*.* -pCondor2019
7z u -r -mx7 f:\ArchiveFS.7z D:\PrePublishedWebSites\ECMSaaS\ArchiveFS\*.* -pCondor2019

7z u -r -mx7 f:\EcmSVC.7z D:\PrepublishedWebSites\ECM2019\EcmSVC\*.* -pCondor2019
7z u -r -mx7 f:\EcmWPF.7z D:\PrepublishedWebSites\ECM2019\EcmWPF\*.* -pCondor2019






