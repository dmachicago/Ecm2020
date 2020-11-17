
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[Refptms_Participant51]') AND parent_object_id = OBJECT_ID(N'[dbo].[ptms_EvalResponse]'))
ALTER TABLE [dbo].[ptms_EvalResponse] DROP CONSTRAINT [Refptms_Participant51]
GO


