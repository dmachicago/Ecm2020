rem notepad MasterDBBuild.sql
c:
cd C:\dev\ECM2020\_DatabaseGenerationScripts

del MasterDBBuild.sql

echo print 'START...' >> MasterDBBuild.sql

del MasterDBBuild.sql
echo PRINT 'Beginning build...' >> MasterDBBuild.sql

echo GO >> MSTR_WTBNEW.sql >> MasterDBBuild.sql

TYPE C:\dev\ECM2020\SQL_Utility\sp_PrintImmediate.sql >> MasterDBBuild.sql 
echo GO >> MasterDBBuild.sql

TYPE 01.01.2020.01.01.2020.$DeleteStdUsers.sql >> MasterDBBuild.sql 
echo GO >> MasterDBBuild.sql

TYPE 01.01.2020.01.01.2020.$CreateStdUsers.sql >> MasterDBBuild.sql 
echo GO >> MasterDBBuild.sql


TYPE 01.01.2020.TDR.sql >> MasterDBBuild.sql 
echo GO >> MasterDBBuild.sql

TYPE 01.01.2020.DMA.UD.License.script.sql >> MasterDBBuild.sql 
echo GO >> MasterDBBuild.sql
TYPE 01.01.2020.$CreateStdUsers.sql >> MasterDBBuild.sql 
echo GO >> MasterDBBuild.sql

TYPE 01.01.2020.ECM.AddUsers.sql >> MasterDBBuild.sql 
echo GO >> MasterDBBuild.sql

TYPE 01.01.2020.ECM.Admin.sql >> MasterDBBuild.sql 
echo GO >> MasterDBBuild.sql
TYPE 01.01.2020.$CreateStdUsers.sql >> MasterDBBuild.sql 
echo GO >> MasterDBBuild.sql

TYPE 01.01.2020.ECM.Hive.sql >> MasterDBBuild.sql 
echo GO >> MasterDBBuild.sql
TYPE 01.01.2020.$CreateStdUsers.sql >> MasterDBBuild.sql 
echo GO >> MasterDBBuild.sql

TYPE 01.01.2020.ECM.Language.sql >> MasterDBBuild.sql 
echo GO >> MasterDBBuild.sql
TYPE 01.01.2020.$CreateStdUsers.sql >> MasterDBBuild.sql 
echo GO >> MasterDBBuild.sql

TYPE 01.01.2020.ECM.Library.FS.sql >> MasterDBBuild.sql 
echo GO >> MasterDBBuild.sql
TYPE 01.01.2020.$CreateStdUsers.sql >> MasterDBBuild.sql 
echo GO >> MasterDBBuild.sql

TYPE 01.01.2020.AddEcmLibraryUser.sql >> MasterDBBuild.sql 
echo GO >> MasterDBBuild.sql
TYPE 01.01.2020.$CreateStdUsers.sql >> MasterDBBuild.sql 
echo GO >> MasterDBBuild.sql

TYPE 01.01.2020.ECM.SecureAttach.sql >> MasterDBBuild.sql 
echo GO >> MasterDBBuild.sql
TYPE 01.01.2020.$CreateStdUsers.sql >> MasterDBBuild.sql 
echo GO >> MasterDBBuild.sql

TYPE 01.01.2020.EcmGateway.sql >> MasterDBBuild.sql 
echo GO >> MasterDBBuild.sql
TYPE 01.01.2020.$CreateStdUsers.sql >> MasterDBBuild.sql 
echo GO >> MasterDBBuild.sql

TYPE 01.01.2020.Thesaurus.V2.sql >> MasterDBBuild.sql 
echo GO >> MasterDBBuild.sql
TYPE 01.01.2020.$CreateStdUsers.sql >> MasterDBBuild.sql 
echo GO >> MasterDBBuild.sql


type  01.01.2020.CreateUsers.sql >> MasterDBBuild.sql
echo GO >> MasterDBBuild.sql

TYPE 01.01.2020.CreateDatabaseUsers.sql >> MasterDBBuild.sql 
echo GO >> MasterDBBuild.sql
TYPE 01.01.2020.CreateFullTextIndexes.sql >> MasterDBBuild.sql 
echo GO >> MasterDBBuild.sql

REM type 01.01.2020.ECM.Library.FS.Initial.Data.sql >> MasterDBBuild.sql

type getTableRowCounts.sql >> MasterDBBuild.sql
echo --End of file >> MasterDBBuild.sql
echo PRINT 'DONE...' >> MasterDBBuild.sql

