

USE master;
exec sp_IVP_Databases

USE [DMA.UD.License];
EXEC sp_GenIvp;
EXEC sp_IvpIndexes;

USE [ECM.Hive];
EXEC sp_GenIvp;
EXEC sp_IvpIndexes;

USE [ECM.Language];
EXEC sp_GenIvp;
EXEC sp_IvpIndexes;

USE [ECM.Library.FS];
EXEC sp_GenIvp;
EXEC sp_IvpIndexes;

USE [ECM.Thesaurus];
EXEC sp_GenIvp;
EXEC sp_IvpIndexes;

USE [ECM.Library.FS];
exec sp_IVP_FTI;

