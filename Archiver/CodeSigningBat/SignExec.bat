c:
cd\
cd C:\Program Files (x86)\Windows Kits\8.1\bin\x64

rem SignTool sign /f D:\dev\Certificates\DmaChicagoSigningCert\CodeSigningCertificate.pfx /p Lottieb@01 "D:\PrepublishedWebSites\ECMSaaS\Archiver\Application Files\EcmArchiveClcSetup_3_5_2_5\EcmArchiveClcSetup.exe.deploy"

rem dir "D:\PrepublishedWebSites\ECMSaaS\Archiver\Application Files\EcmArchiveClcSetup_3_5_2_5\EcmArchiveClcSetup.exe.deploy"

SignTool sign /f D:\dev\Certificates\DmaChicagoSigningCert\CodeSigningCertificate.pfx /p Lottieb@01 "D:\dev\EcmMasterSingleSource\ECM\EcmCloud\EcmCLCArchive\obj\Debug\EcmArchiveClcSetup.exe"


SignTool verify /PA "D:\dev\EcmMasterSingleSource\ECM\EcmCloud\EcmCLCArchive\obj\Debug\EcmArchiveClcSetup.exe"


rem SignTool Error: A certificate chain processed, but terminated in a root certificate which is not trusted by the trust provider.