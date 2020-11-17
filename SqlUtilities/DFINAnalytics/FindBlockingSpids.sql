--Change the @ShowallSpids to 0 if just wanting to see blockers

DECLARE 
  @showallspids BIT;

SET @showallspids=0;

CREATE TABLE #ExecRequests
(
  id                                  INT IDENTITY( 1, 1 ) PRIMARY KEY, 
  session_id                          SMALLINT NOT NULL, 
  request_id                          INT NULL, 
  request_start_time                  DATETIME NULL, 
  login_time                          DATETIME NOT NULL, 
  login_name                          NVARCHAR(256) NULL, 
  client_interface_name               NVARCHAR(64), 
  session_status                      NVARCHAR(60) NULL, 
  request_status                      NVARCHAR(60) NULL, 
  command                             NVARCHAR(32) NULL, 
  sql_handle                          VARBINARY(64) NULL, 
  statement_start_offset              INT NULL, 
  statement_end_offset                INT NULL, 
  plan_handle                         VARBINARY(64) NULL, 
  database_id                         SMALLINT NULL, 
  user_id                             INT NULL, 
  blocking_session_id                 SMALLINT NULL, 
  wait_type                           NVARCHAR(120) NULL, 
  wait_time_s                         INT NULL, 
  wait_resource                       NVARCHAR(120) NULL, 
  last_wait_type                      NVARCHAR(120) NULL, 
  cpu_time_s                          INT NULL, 
  tot_time_s                          INT NULL, 
  reads                               BIGINT NULL, 
  writes                              BIGINT NULL, 
  logical_reads                       BIGINT NULL, 
  host_name                           NVARCHAR(256) NULL, 
  program_name                        NVARCHAR(256) NULL, 
  blocking_these                      VARCHAR(1000) NULL, 
  percent_complete                    INT NULL, 
  session_transaction_isolation_level VARCHAR(20) NULL, 
  request_transaction_isolation_level VARCHAR(20) NULL);

INSERT INTO #ExecRequests
(session_id, 
 request_id, 
 request_start_time, 
 login_time, 
 login_name, 
 client_interface_name, 
 session_status, 
 request_status, 
 command, 
 sql_handle, 
 statement_start_offset, 
 statement_end_offset, 
 plan_handle, 
 database_id, 
 user_id, 
 blocking_session_id, 
 wait_type, 
 last_wait_type, 
 wait_time_s, 
 wait_resource, 
 cpu_time_s, 
 tot_time_s, 
 reads, 
 writes, 
 logical_reads, 
 host_name, 
 program_name, 
 session_transaction_isolation_level, 
 request_transaction_isolation_level)
       SELECT s.session_id, 
              request_id, 
              r.start_time, 
              s.login_time, 
              s.login_name, 
              s.client_interface_name, 
              s.STATUS, 
              r.STATUS, 
              command, 
              sql_handle, 
              statement_start_offset, 
              statement_end_offset, 
              plan_handle, 
              r.database_id, 
              user_id, 
              blocking_session_id, 
              wait_type, 
              r.last_wait_type, 
              r.wait_time/1000., 
              r.wait_resource, 
              r.cpu_time/1000., 
              r.total_elapsed_time/1000., 
              r.reads, 
              r.writes, 
              r.logical_reads, 
              s.host_name, 
              s.program_name, 
              s.transaction_isolation_level, 
              r.transaction_isolation_level
       FROM sys.dm_exec_sessions s
       LEFT OUTER JOIN
       sys.dm_exec_requests r
       ON r.session_id=s.session_id
       WHERE 1=1
             AND s.session_id>=50 --retrieve only user spids
             AND s.session_id<>@@SPID --ignore myself
             AND (@showallspids=1
                  OR r.session_id IS NOT NULL);

UPDATE #ExecRequests
SET 
    blocking_these=LEFT(
(
  SELECT ISNULL( CONVERT( VARCHAR(5), er.session_id ), '' )+', '
  FROM #ExecRequests er
  WHERE er.blocking_session_id=ISNULL( #ExecRequests.session_id, 0 )
        AND er.blocking_session_id<>0 FOR XML PATH( '' )
), 1000 );

SELECT *
FROM
(
  SELECT r.session_id, 
         r.host_name, 
         r.program_name, 
         r.session_status, 
         r.request_status, 
         r.blocking_these, 
         blocked_by=r.blocking_session_id, 
         r.wait_type, 
         r.wait_resource, 
         r.last_wait_type, 
         DBName=DB_NAME( r.database_id ), 
         r.command, 
         login_time, 
         login_name, 
         client_interface_name, 
         request_start_time, 
         r.tot_time_s, 
         r.wait_time_s, 
         r.cpu_time_s, 
         r.reads, 
         r.writes, 
         r.logical_reads,
         --, [fulltext] = est.[text] 
         offsettext=CASE
                      WHEN r.statement_start_offset=0
                           AND r.statement_end_offset=0
                      THEN NULL
                      ELSE SUBSTRING( est.[text], r.statement_start_offset/2+1,
                                                                             CASE
                                                                               WHEN r.statement_end_offset=-1
                                                                               THEN LEN( CONVERT( NVARCHAR(MAX), est.[text] ) )
                                                                               ELSE r.statement_end_offset/2-r.statement_start_offset/2+1
                                                                             END )
                    END, 
         r.statement_start_offset, 
         r.statement_end_offset, 
         cacheobjtype=LEFT( p.cacheobjtype+' ('+p.objtype+')', 35 ), 
         QueryPlan=qp.query_plan, 
         request_transaction_isolation_level=CASE request_transaction_isolation_level
                                               WHEN 0
                                               THEN 'Unspecified'
                                               WHEN 1
                                               THEN 'ReadUncommitted'
                                               WHEN 2
                                               THEN 'ReadCommitted'
                                               WHEN 3
                                               THEN 'Repeatable'
                                               WHEN 4
                                               THEN 'Serializable'
                                               WHEN 5
                                               THEN 'Snapshot'
                                             END, 
         session_transaction_isolation_level=CASE session_transaction_isolation_level
                                               WHEN 0
                                               THEN 'Unspecified'
                                               WHEN 1
                                               THEN 'ReadUncommitted'
                                               WHEN 2
                                               THEN 'ReadCommitted'
                                               WHEN 3
                                               THEN 'Repeatable'
                                               WHEN 4
                                               THEN 'Serializable'
                                               WHEN 5
                                               THEN 'Snapshot'
                                             END
  FROM #ExecRequests r
  LEFT OUTER JOIN
  sys.dm_exec_cached_plans p
  ON p.plan_handle=r.plan_handle
      OUTER APPLY
      sys.dm_exec_query_plan
  (r.plan_handle) qp
          OUTER APPLY
          sys.dm_exec_sql_text
  (r.sql_handle) est
) a
  --where blocked_by != 0 and blocking_these is not null
  ORDER BY LEN( blocking_these ) DESC, 
           blocking_these DESC, 
           blocked_by DESC, 
           session_id ASC;

DROP TABLE #ExecRequests;