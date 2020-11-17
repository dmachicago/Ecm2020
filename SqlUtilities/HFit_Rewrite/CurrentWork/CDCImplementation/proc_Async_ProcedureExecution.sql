
CREATE PROCEDURE proc_BrokerTargetActivProc
AS
BEGIN
/*
Author:	  W. Dale Miller
Date:	  07/26/2013
@Copyright: DMA, Limited, 07/26/2013, all rights reserved. Can be 
		  utilized by clients of DMA, Limited without licensing.
		  All others require a use license from DMA, Limited.
Narrative:
   Running time consuming stored procedures requires sometimes 
   asynchronous processing. We can either implement it within 
   the application by starting new thread and execute stored 
   procedure in that process or we can use MSSQL Service Broker 
   to do it within the database. It is espaecially useful if we 
   need to execute time consuming operation in response to the 
   database trigger. Sending execute command message to service 
   broker will decauple the trigger proccesing from the target 
   procedure execution.

   In order to implment this solution, we need to first set-up 
   the Service broker to be able to send the message to the 
   service queue for processing.First we need to create self 
   activated stored procedure that will check the queue for 
   incoming messages. After the message arrives we simply use 
   Exec function to execute stored procedure by name.

Verified on the following platforms
    Windows 10	No
    Windows Server 2012	Yes
    Windows Server 2008 R2	Yes
    Windows Server 2008	Yes
    Windows Server 2003	Yes
    Windows 8	Yes
    Windows 7	Yes
    Windows Vista	Yes
    Windows XP	No
    Windows 2000	No
*/
    DECLARE
           @RecvReqDlgHandle uniqueidentifier;
    DECLARE
           @RecvReqMsg nvarchar (100) ;
    DECLARE
           @RecvReqMsgName sysname;

    WHILE 1 = 1
        BEGIN

            BEGIN TRANSACTION;

            WAITFOR (
            RECEIVE TOP (1) @RecvReqDlgHandle = conversation_handle
                          , @RecvReqMsg = message_body
                          , @RecvReqMsgName = message_type_name FROM TASK_QUEUE) , TIMEOUT 5000;

            IF @@ROWCOUNT = 0
                BEGIN
                    ROLLBACK TRANSACTION;
                    BREAK;
                END;

            DECLARE
                   @targetpProcedure nvarchar (100) ;
            SET @targetpProcedure = CAST (@RecvReqMsg AS nvarchar (100)) ;

            IF LEN (@targetpProcedure) > 0
                BEGIN 
                    --execute target procedure (no need to send the reply) 
                    EXEC @targetpProcedure;

                END;
            ELSE
                BEGIN
                    IF @RecvReqMsgName = N'http://schemas.microsoft.com/SQL/ServiceBroker/EndDialog'
                        BEGIN
                            END CONVERSATION @RecvReqDlgHandle;
                        END;
                    ELSE
                        BEGIN
                            IF @RecvReqMsgName = N'http://schemas.microsoft.com/SQL/ServiceBroker/Error'
                                BEGIN
                                    END CONVERSATION @RecvReqDlgHandle;
                                END;
                        END;
                END;

            COMMIT TRANSACTION;

        END;
END; 
GO

-- Let's create the message queue, contracts and services.
CREATE MESSAGE TYPE [//SBM/RequestMessage] VALIDATION = WELL_FORMED_XML;  
CREATE MESSAGE TYPE [//SBM/ReplyMessage] VALIDATION = WELL_FORMED_XML; 
  
CREATE CONTRACT [//SBM/MSGContract] ([//SBM/RequestMessage] SENT BY INITIATOR, [//SBM/ReplyMessage] SENT BY TARGET) ;   
  
CREATE QUEUE TASK_QUEUE WITH STATUS = ON, ACTIVATION (PROCEDURE_NAME = proc_BrokerTargetActivProc, MAX_QUEUE_READERS = 5, EXECUTE AS SELF) ; 
  
CREATE SERVICE [//SBM/TargetService] ON QUEUE TASK_QUEUE ([//SBM/MSGContract]) ; 
CREATE SERVICE [//SBM/InitService] ON QUEUE TASK_QUEUE ([//SBM/MSGContract]) ;
go


-- Finally let's create the procedure that we will use to send the message command to the queue.
CREATE PROCEDURE proc_ExecuteProcedureAsync @ProcedureName nvarchar (100) = ''
AS
BEGIN
    /*
    Author:	 W. Dale Miller
    Date:		 07/26/2013
    @Copyright: DMA, Limited, 07/26/2013, all rights reserved. Can be 
			 utilized by clients of DMA, Limited without licensing.
			 All others require a use license from DMA, Limited.
    */
    DECLARE
           @InitDlgHandle uniqueidentifier;
    DECLARE
           @RequestMsg xml;
    BEGIN TRANSACTION;
    BEGIN DIALOG @InitDlgHandle FROM SERVICE [//SBM/InitService] TO SERVICE N'//SBM/TargetService' ON CONTRACT [//SBM/MSGContract] WITH ENCRYPTION = OFF;

    SELECT @RequestMsg = @ProcedureName; 
  
    --Send the Message 
    SEND ON CONVERSATION @InitDlgHandle MESSAGE TYPE [//SBM/RequestMessage] (@RequestMsg) ; 
  
    --Close conversation 
    END CONVERSATION @InitDlgHandle;

    COMMIT TRANSACTION;
END;