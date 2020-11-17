/*
Column Name  Data type  Description  
DbId smallint Database ID.
FileId smallint File ID.
TimeStamp int Database timestamp at which the data was taken.
NumberReads bigint Number of reads issued on the file. 
BytesRead bigint Number of bytes read issued on the file.
IoStallReadMS bigint Total amount of time, in milliseconds, that users waited for the read I/Os to complete on the file. 
NumberWrites bigint Number of writes made on the file.
BytesWritten bigint Number of bytes written made on the file.
IoStallWriteMS bigint Total amount of time, in milliseconds, that users waited for the write I/Os to complete on the file.
IoStallMS bigint Sum of IoStallReadMS and IoStallWriteMS.
FileHandle bigint Value of the file handle.
BytesOnDisk bigint Physical file size (count of bytes) on disk.
    For database files, this is the same value as size in sys.database_files, but is expressed in bytes rather than pages.
    For database snapshot sparse files, this is the space the operating system is using for the file.
*/ 

select * from sys.databases

select DBID, Fileid, NumberReads,BytesRead,NumberWrites, BytesWritten, BytesOnDisk, IoStallMS, IoStallWriteMS,IoStallReadMS 
from fn_virtualfilestats ( DB_ID(N'ECM.Library')  , NULL )
select * from fn_virtualfilestats ( DB_ID(N'ECM.Library')  , NULL )

select * from fn_virtualfilestats (10  , 1 )

select object_name, counter_name,instance_name,cntr_value from sys.dm_os_performance_counters 
    
SELECT FILE_NAME(1) AS 'File Name 1', FILE_NAME(2) AS 'File Name 2';
