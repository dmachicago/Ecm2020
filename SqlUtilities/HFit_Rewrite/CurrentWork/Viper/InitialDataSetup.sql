USE [Viper]
GO

--********************************************************************************
INSERT INTO [dbo].[RuleClass]([ClassID],[RuleClassDesc])
     VALUES
           ('Global'
           ,'This classification of rule applies to ALL files that will be processed through the Viper System.')
GO
INSERT INTO [dbo].[RuleClass]([ClassID],[RuleClassDesc])
     VALUES
           ('Client'
           ,'This classification of rule applies to ALL files that will be processed through the Viper System for a specific client.')
GO
--********************************************************************************
INSERT INTO [dbo].[RuleType] ([RuleCode],[ClassID],[RuleDesc])
     VALUES
           ('FileHeader'
           ,'Global'
           ,'Rule insures that all processed files contain a header record. A header record will contain the following structure and be validated by the FileHeader class in ViperSetup.')
GO
INSERT INTO [dbo].[RuleType] ([RuleCode],[ClassID],[RuleDesc])
     VALUES
           ('Statistic'
           ,'Global'
           ,'When executed, will retrieve and record a specified statistic.')

--********************************************************************************

INSERT INTO [dbo].[Rule] ([RuleName],[RuleCode],[ClassID],[RuleCommand],[RuleDesc])
     VALUES
           ('Check Header Exists'
           ,'FileHeader'
           ,'Global'
           ,'NA - this rule is applied within ViperSetup code.'
           ,'Rule that verifies the file being processed contains a properly formatted and defined header record.')
GO
INSERT INTO [dbo].[Rule] ([RuleName],[RuleCode],[ClassID],[RuleCommand],[RuleDesc])
     VALUES
           ('Get File Row Count'
           ,'Statistic'
           ,'Global'
           ,'NA - this rule is applied within ViperSetup code. (refer to class clsStats and proc GetFileRowCount)'
           ,'Acquires the count of the total records contained within the client file.')
GO

--********************************************************************************

INSERT INTO [dbo].[Client] ([ClientID],[ClientDesc])
     VALUES
           ('TestClient01'
           ,'This is a temporary test client that will only be used to augment code development.')
GO

--********************************************************************************

INSERT INTO [dbo].[ClientRule] ([ClientID],[RuleName],[ExecutionOrder],[RuleCode],[ClassID])
     VALUES
           ('TestClient01'
           ,'Check Header Exists'
           ,1
           ,'Client'
           ,'Global')
GO
INSERT INTO [dbo].[ClientRule] ([ClientID],[RuleName],[ExecutionOrder],[RuleCode],[ClassID])
     VALUES
           ('TestClient01'
           ,'Get File Row Count'
           ,2
           ,'Client'
           ,'Global')
GO

