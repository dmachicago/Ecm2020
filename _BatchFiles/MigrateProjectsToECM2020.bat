echo THIS IS A DESTRUCTIVE PROCESS - ARE YOU SURE ?
pause 

robocopy D:\dev\EcmMasterSingleSource\ECM\ECMSecureAttachWF D:\dev\ECM2020\ECM\SecureAttachAdmin /mir /xo /r:2 /w:2 

robocopy D:\dev\EcmMasterSingleSource\ECM\EncryptString d:\dev\ECM2020\EncryptString  /mir /xo /r:2 /w:2 
robocopy D:\dev\EcmMasterSingleSource\ECM\EcmEncryption d:\dev\ECM2020\EcmEncryption  /mir /xo /r:2 /w:2 

robocopy D:\dev\OcrOneNoteV2 d:\dev\ECM2020\OcrOneNote /mir /xo /r:2 /w:2 
robocopy d:\dev\OCR_Tesseret d:\dev\ECM2020\OCR_Tesseract /mir /xo /r:2 /w:2 

robocopy D:\dev\EcmMasterSingleSource\ECM\EcmCloud\EcmAdminSetup d:\dev\ECM2020\Admin /mir /xo /r:2 /w:2 

robocopy D:\dev\EcmMasterSingleSource\ECM\EcmCloudWcf\EcmDownloader\EcmDownloader d:\dev\ECM2020\DownLoad /mir /xo /r:2 /w:2 
robocopy D:\dev\EcmMasterSingleSource\ECM\EcmCloudWcf\Backup\EcmDownloader\RestoreWCF d:\dev\ECM2020\DownLoadSVC /mir /xo /r:2 /w:2 

robocopy D:\dev\EcmMasterSingleSource\ECM\ECMSearchWPF d:\dev\ECM2020\Search /mir /xo /r:2 /w:2 
robocopy D:\dev\EcmMasterSingleSource\ECM\EcmCloudWcf\EcmCloudWcf.Web d:\dev\ECM2020\SearchSVC /mir /xo /r:2 /w:2 

robocopy D:\dev\EcmMasterSingleSource\ECM\ECMSecureAttach\EcmSecureAttachWCF2 d:\dev\ECM2020\SecureSVC /mir /xo /r:2 /w:2 
         

robocopy D:\dev\EcmMasterSingleSource\ECM\_ECMInstall\_PS_Parsenal d:\dev\ECM2020\PowerShellScripts /mir /xo /r:2 /w:2 

robocopy D:\dev\EcmMasterSingleSource\ECM\_ECMInstall\_Software d:\dev\ECM2020\3RDPartySoftware /mir /xo /r:2 /w:2 

robocopy D:\dev\EcmMasterSingleSource\ECM\_DatabaseGenerationScripts\DBScriptsLatest d:\dev\ECM2020\DBScripts /mir /xo /r:2 /w:2 

robocopy D:\dev\EcmMasterSingleSource\ECM\ECMSaaS\ServerSideOCR d:\dev\ECM2020\OCR\ServerSideOCR /mir /xo /r:2 /w:2 
robocopy D:\dev\OcrOneNoteV2 d:\dev\ECM2020\OCR\OcrOneNoteLIB /mir /xo /r:2 /w:2 

robocopy D:\dev\EcmMasterSingleSource\ECM\_ECM_SSIS\ECM.FS d:\dev\ECM2020\SSIS_Migration /mir /xo /r:2 /w:2 