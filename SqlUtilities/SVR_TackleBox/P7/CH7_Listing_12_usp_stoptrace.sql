USE [msdb]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
   Procedure Name : usp_stopTrace
   -------------------------------
   Parameter 1 : traceName - Unique identifier of trace to be stopped [Req]
*/
CREATE PROCEDURE [dbo].[usp_stopTrace]
   @traceName NVARCHAR(50)
AS

   SET NOCOUNT ON
   
   /*
      Variable Declaration
      --------------------
      traceID - Will hold the ID of the trace that will be stopped and archived
      traceFile - The physical file to export data from
      command - Variable to hold the command to clean the traceFile from the server
   */
   DECLARE @traceID INT,
         @traceFile NVARCHAR(100),
         @command NVARCHAR(150)
   
   -- Test for the trace via name in the repository, if it exsists proccess it, if not alert the user
   -- Change linked server name here
   IF EXISTS (
      SELECT * FROM MYSERVER123.DBA_Info.dbo.Trace_IDs
       WHERE TraceName = @traceName
         AND TraceServer = SERVERPROPERTY('ServerName')
   )
   BEGIN
      -- Gather the traceID and traceFile from the respository
      -- Change linked server name here      
      SET @traceID   = (SELECT TraceID FROM MYSERVER123.DBA_Info.dbo.Trace_IDs WHERE TraceName = @traceName AND TraceServer = SERVERPROPERTY('ServerName'))
      -- Change linked server name here
      SET @traceFile = (SELECT TraceFile FROM MYSERVER123.DBA_Info.dbo.Trace_IDs WHERE TraceName = @traceName AND TraceServer = SERVERPROPERTY('ServerName'))

      -- Set the status of the trace to inactive, then remove the trace from the server
      EXEC sp_trace_setstatus @traceID, 0
      EXEC sp_trace_setstatus @traceID, 2

      -- Archive the older trace data and remove all records to make room for the new trace data
      -- Change linked server name here
      INSERT INTO MYSERVER123.DBA_Info.dbo.trace_archive SELECT * FROM MYSERVER123.DBA_Info.dbo.trace_table
      
      -- Change linked server name here
      DELETE FROM MYSERVER123.DBA_Info.dbo.trace_table
      
      -- Change linked server name here
      INSERT INTO MYSERVER123.DBA_Info.dbo.trace_table SELECT * FROM ::fn_trace_gettable(@traceFile + '.trc', default)

      -- Remove the existing trace file for future use
      SET @command = 'DEL ' + @traceFile + '.trc'
      EXEC xp_cmdshell @command
      
      -- Delete the trace information from the repository
      -- Change linked server name here
      DELETE FROM MYSERVER123.DBA_Info.dbo.Trace_IDs WHERE TraceName = @traceName AND TraceServer = SERVERPROPERTY('ServerName')
      
      -- Alert the user that the trace has been stopped and archived
      PRINT('Trace ' + @traceName + ' Stopped and Archived')
      RETURN
   END
   
   -- Alert the user that the trace was not found in the repository
   PRINT('Trace ' + @traceName + ' Not Found')
   
   SET NOCOUNT OFF

GO
