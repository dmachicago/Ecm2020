
GO
USE KenticoCMS_DataMart_2;
GO

if exists (Select name from sys.views where name = 'View_HFit_OutComeMessages_Joined_MART')
DROP VIEW
     dbo.View_HFit_OutComeMessages_Joined_MART;
GO

/****** Object:  View [dbo].[View_HFit_OutComeMessages_Joined]    Script Date: 11/30/2015 8:08:10 PM ******/
SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO
-- select top 1000 * from View_HFit_OutComeMessages_Joined_MART
-- SELECT ',f.' + COLUMN_NAME from information_schema.columns where table_name = 'BASE_HFit_OutComeMessages'
CREATE VIEW dbo.View_HFit_OutComeMessages_Joined_MART
AS SELECT
          V.*
        , f.Message
        , f.IsEnabled
        , f.CodeName
        , f.OrderWeight
        , f.OutComeMessagesID
        , f.ACTION
        , f.SYS_CHANGE_VERSION
        , f.LASTMODIFIEDDATE as MSG_LastModifiedDate
        , f.HashCode as MSG_HashCode
   --,f.SVR
   --,f.DBNAME
          FROM BASE_View_CMS_Tree_Joined AS V
                   INNER JOIN BASE_HFit_OutComeMessages AS F
                       ON V.DocumentForeignKeyValue = F.OutComeMessagesID
          WHERE ClassName = 'HFit.OutcomeMessage';
GO


