
echo on
cd\
cd C:\dev\ECM2020\_BatchFiles\ECM_BUILD

rem call _CkFileExists "@IVP_MasterBuild.sql"
del @IVP_MasterBuild.sql

copy spacer.txt @IVP_MasterBuild.sql

call CheckFile C:\dev\ECM2020\SQL_Utility\sp_PrintImmediate.sql
call CheckFile C:\dev\ECM2020\SQL_Utility\sp_CheckDefault.sql

rem call CheckFile C:\dev\ECM2020\_DatabaseGenerationScripts\01.01.2020.$DeleteDatabases.sql
call CheckFile C:\dev\ECM2020\_DatabaseGenerationScripts\01.01.2020.$CreateStdUsers.sql

call CheckFile C:\dev\ECM2020\_DatabaseGenerationScripts\01.01.2020.$CreateDatabases.sql
call CheckFile C:\dev\ECM2020\_DatabaseGenerationScripts\01.01.2020.$CreateStdUsers.sql

call CheckFile C:\dev\ECM2020\_DatabaseGenerationScripts\01.01.2020.TDR.sql  
call CheckFile C:\dev\ECM2020\_DatabaseGenerationScripts\01.01.2020.$CreateStdUsers.sql

call CheckFile C:\dev\ECM2020\_DatabaseGenerationScripts\01.01.2020.DMA.UD.License.script.sql  
call CheckFile C:\dev\ECM2020\_DatabaseGenerationScripts\01.01.2020.$CreateStdUsers.sql

call CheckFile C:\dev\ECM2020\_DatabaseGenerationScripts\01.01.2020.ECM.AddUsers.sql  
call CheckFile C:\dev\ECM2020\_DatabaseGenerationScripts\01.01.2020.$CreateStdUsers.sql

call CheckFile C:\dev\ECM2020\_DatabaseGenerationScripts\01.01.2020.ECM.Admin.sql  
call CheckFile C:\dev\ECM2020\_DatabaseGenerationScripts\01.01.2020.$CreateStdUsers.sql

call CheckFile C:\dev\ECM2020\_DatabaseGenerationScripts\01.01.2020.ECM.Hive.sql  
call CheckFile C:\dev\ECM2020\_DatabaseGenerationScripts\01.01.2020.$CreateStdUsers.sql

call CheckFile C:\dev\ECM2020\_DatabaseGenerationScripts\01.01.2020.ECM.Language.sql  
call CheckFile C:\dev\ECM2020\_DatabaseGenerationScripts\01.01.2020.$CreateStdUsers.sql

call CheckFile C:\dev\ECM2020\_DatabaseGenerationScripts\01.01.2020.ECM.Library.FS.sql  
call CheckFile C:\dev\ECM2020\_DatabaseGenerationScripts\01.01.2020.$CreateStdUsers.sql
call CheckFile C:\dev\ECM2020\_DatabaseGenerationScripts\01.01.2020.ECM.Library.FS.Default.Values.sql

call CheckFile C:\dev\ECM2020\_DatabaseGenerationScripts\01.01.2020.AddEcmLibraryUser.sql  
call CheckFile C:\dev\ECM2020\_DatabaseGenerationScripts\01.01.2020.$CreateStdUsers.sql

call CheckFile C:\dev\ECM2020\_DatabaseGenerationScripts\01.01.2020.ECM.SecureAttach.sql  
call CheckFile C:\dev\ECM2020\_DatabaseGenerationScripts\01.01.2020.$CreateStdUsers.sql

call CheckFile C:\dev\ECM2020\_DatabaseGenerationScripts\01.01.2020.EcmGateway.sql  
call CheckFile C:\dev\ECM2020\_DatabaseGenerationScripts\01.01.2020.$CreateStdUsers.sql

call CheckFile C:\dev\ECM2020\_DatabaseGenerationScripts\01.01.2020.Thesaurus.V2.sql  
call CheckFile C:\dev\ECM2020\_DatabaseGenerationScripts\01.01.2020.$CreateStdUsers.sql

call CheckFile C:\dev\ECM2020\_DatabaseGenerationScripts\01.01.2020.CreateUsers.sql 
call CheckFile C:\dev\ECM2020\_DatabaseGenerationScripts\01.01.2020.$CreateStdUsers.sql

call CheckFile C:\dev\ECM2020\_DatabaseGenerationScripts\01.01.2020.CreateDatabaseUsers.sql  
call CheckFile C:\dev\ECM2020\_DatabaseGenerationScripts\01.01.2020.$CreateStdUsers.sql

call CheckFile C:\dev\ECM2020\_DatabaseGenerationScripts\01.01.2020.CreateFullTextIndexes.sql  
call CheckFile C:\dev\ECM2020\_DatabaseGenerationScripts\01.01.2020.$CreateStdUsers.sql

call CheckFile C:\dev\ECM2020\_DatabaseGenerationScripts\_AddPicatinnyLicense.sql

rem ************************************
Echo IVP GEN Complete - please review for errors.
Echo For assistance call Dale Miller 847-274-6622
pause