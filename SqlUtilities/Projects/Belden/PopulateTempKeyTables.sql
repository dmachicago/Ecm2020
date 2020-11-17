truncate table dbo.TEMP_B1_KEYS
go
INSERT INTO dbo.TEMP_B1_KEYS (RowID)
SELECT RowID
FROM dbo.GLOBAL_Static_BI
WHERE Extract = 'B1'
go

truncate table dbo.TEMP_B2_KEYS
go
INSERT INTO dbo.TEMP_B2_KEYS (RowID)
SELECT RowID
FROM dbo.GLOBAL_Static_BI
WHERE Extract = 'B2'
go

truncate table dbo.TEMP_B3_KEYS
go
INSERT INTO dbo.TEMP_B3_KEYS (RowID)
SELECT RowID
FROM dbo.GLOBAL_Static_BI
WHERE Extract = 'B3'
go

truncate table dbo.TEMP_P1_KEYS
go
INSERT INTO dbo.TEMP_p1_KEYS (RowID)
SELECT RowID
FROM dbo.GLOBAL_Static_POS
WHERE Extract = 'P1'
go

truncate table dbo.TEMP_P2_KEYS
go
INSERT INTO dbo.TEMP_p2_KEYS (RowID)
SELECT RowID
FROM dbo.GLOBAL_Static_POS
WHERE Extract = 'P2'
go

truncate table dbo.TEMP_P3_KEYS
go
INSERT INTO dbo.TEMP_p3_KEYS (RowID)
SELECT RowID
FROM dbo.GLOBAL_Static_POS
WHERE Extract = 'P3'
go

truncate table dbo.TEMP_P4_KEYS
go
INSERT INTO dbo.TEMP_p4_KEYS (RowID)
SELECT RowID
FROM dbo.GLOBAL_Static_POS
WHERE Extract = 'P4'
go

truncate table dbo.TEMP_P5_KEYS
go
INSERT INTO dbo.TEMP_p5_KEYS (RowID)
SELECT RowID
FROM dbo.GLOBAL_Static_POS
WHERE Extract = 'P5'
go