

--************************************************************************************
--view_EDW_EligibilityHistory provides users access to the EDW_GroupMemberHistory table.
-- select top 100 * from view_EDW_EligibilityHistory
--************************************************************************************

CREATE VIEW [dbo].[view_EDW_EligibilityHistory]
AS SELECT
          GroupName
        , UserMpiNumber
        , StartedDate
        , EndedDate
        , RowNbr
          FROM dbo.EDW_GroupMemberHistory;

GO


