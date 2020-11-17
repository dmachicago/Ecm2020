--For a column:
EXECUTE sp_addextendedproperty N'MS_Description', 'My Column Comment', N'user', N'dbo', N'table', N'MyTableName', N'column', N'MyColumnName'

--(Note that this is to ADD, there is a different SProc to UPDATE)
--For a table:
EXECUTE sp_updateextendedproperty N'MS_Description', 'My Table Comment', N'user', N'dbo', N'table', N'MyTableName', NULL, NULL