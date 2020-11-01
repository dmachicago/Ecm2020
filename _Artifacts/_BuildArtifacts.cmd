c:
cd C:\Program Files\7-Zip

IF EXIST "C:\dev\ECM2020\_Artifacts\Sent\ConfigSetup.zip" (goto A1) 
IF EXIST "C:\dev\ECM2020\_Artifacts\ConfigSetup.zip" (goto A1) 
7z a "C:\dev\ECM2020\_Artifacts\ConfigSetup.zip" "D:\PrepublishedWebSites\ECMSaaS\ConfigSetup"
:A1

IF EXIST "C:\dev\ECM2020\_Artifacts\Sent\@IVPMasterBuild.zip" (goto AA) 
IF EXIST "C:\dev\ECM2020\_Artifacts\@IVPMasterBuild.zip" (goto AA) 
7z a "C:\dev\ECM2020\_Artifacts\@IVPMasterBuild.zip" "C:\dev\ECM2020\_BatchFiles\ECM_BUILD\@IVP_MasterBuild.sql"
:AA

IF EXIST "C:\dev\ECM2020\_Artifacts\Sent\iFilters.zip" (goto A0) 
IF EXIST "C:\dev\ECM2020\_Artifacts\iFilters.zip" (goto A0) 
7z a "C:\dev\ECM2020\_Artifacts\iFilters.zip" "D:\dev\ECM2019\_ECMInstallDVD\_ECMInstallPowerShell\Software\iFilters"
:A0

IF EXIST "C:\dev\ECM2020\_Artifacts\Sent\ServerSideOCR.zip" (goto A1) 
IF EXIST "C:\dev\ECM2020\_Artifacts\ServerSideOCR.zip" (goto A1) 
7z a "C:\dev\ECM2020\_Artifacts\ServerSideOCR.zip"  "D:\PrepublishedWebSites\ECMSaaS\ServerSideOCR"
:A1

IF EXIST "C:\dev\ECM2020\_Artifacts\Sent\Archiver.zip" (goto A2) 
IF EXIST "C:\dev\ECM2020\_Artifacts\Archiver.zip" (goto A2) 
7z a "C:\dev\ECM2020\_Artifacts\Archiver.zip" "D:\PrepublishedWebSites\ECMSaaS\Archiver"
:A2

IF EXIST "C:\dev\ECM2020\_Artifacts\Sent\ArchiverService.zip" (goto A3) 
IF EXIST "C:\dev\ECM2020\_Artifacts\ArchiverService.zip" (goto A3) 
7z a "C:\dev\ECM2020\_Artifacts\ArchiverService.zip" "D:\PrePublishedWebSites\ECMSaaS\ArchiveFS"
:A3

IF EXIST "C:\dev\ECM2020\_Artifacts\Sent\SearchService.zip" (goto A4) 
IF EXIST "C:\dev\ECM2020\_Artifacts\SearchService.zip" (goto A4) 
7z a "C:\dev\ECM2020\_Artifacts\SearchService.zip" "D:\PrePublishedWebSites\ECMSaaS\SearchSVC"
:A4

IF EXIST "C:\dev\ECM2020\_Artifacts\Sent\Search.zip" (goto A5) 
IF EXIST "C:\dev\ECM2020\_Artifacts\Search.zip" (goto A5) 
7z a "C:\dev\ECM2020\_Artifacts\Search.zip" "D:\PrepublishedWebSites\ECMSaaS\Search"
:A5

IF EXIST "C:\dev\ECM2020\_Artifacts\Sent\MODI.zip" (goto A6) 
IF EXIST "C:\dev\ECM2020\_Artifacts\MODI.zip" (goto A6) 
7z a "C:\dev\ECM2020\_Artifacts\MODI.zip" "D:\dev\ECM2019\_ECMInstallDVD\_ECMInstallPowerShell\Software\Office2007"
:A6

IF EXIST "C:\dev\ECM2020\_Artifacts\Sent\Encryption2way.zip" (goto A7) 
IF EXIST "C:\dev\ECM2020\_Artifacts\Encryption2way.zip" (goto A7) 
7z a "C:\dev\ECM2020\_Artifacts\Encryption2way.zip" "D:\PrepublishedWebSites\ECMSaaS\Encryption2way"
:A7


pause