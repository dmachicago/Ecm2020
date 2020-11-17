
GO
PRINT '********************************************************************';
PRINT 'Creating trgSchemaMonitor HAS BEEN DISABLED       ******************';
PRINT '********************************************************************';
PRINT 'Processed trgLastModDate.sql';
--select * from EDW_RoleMemberHistory
GO
CREATE TRIGGER trgEDWRoleEligibilityLasModDate ON EDW_RoleMemberHistory
    AFTER UPDATE
AS
SET ANSI_NULLS ON;
SET ANSI_PADDING ON;
SET ANSI_WARNINGS ON;
SET ARITHABORT ON;
SET CONCAT_NULL_YIELDS_NULL ON;
SET NUMERIC_ROUNDABORT OFF;
SET QUOTED_IDENTIFIER ON;
SET NOCOUNT ON;

UPDATE HIST
       SET
           LastModifiedDate = GETDATE () 
           FROM EDW_RoleMemberHistory AS HIST
                    JOIN INSERTED AS I
                        ON I.RowNbr = HIST.RowNbr;

SET NOCOUNT OFF;
GO

PRINT '********************************************************************';
PRINT 'Created trgSchemaMonitor HAS BEEN CREATED       ******************';
PRINT '********************************************************************';
PRINT 'Processed trgLastModDate.sql';
