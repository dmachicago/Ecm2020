USE KenticoCMS_Datamart_2
GO
SET NOCOUNT ON;

-- drop table #triggerFullText
-- drop table #triggerLines

CREATE TABLE #triggerFullText ([TriggerName] VARCHAR(500), [Text] VARCHAR(MAX))
CREATE TABLE #triggerLines ([Text] VARCHAR(MAX))

DECLARE @triggerName VARCHAR(500)
DECLARE @fullText VARCHAR(MAX)

SELECT @triggerName = MIN(name)
FROM sys.triggers

WHILE @triggerName IS NOT NULL
BEGIN

if @triggerName != 'trgSchemaMonitor'
begin

    INSERT INTO #triggerLines 
    EXEC sp_helptext @triggerName

    --sp_helptext gives us one row per trigger line
    --here we join lines into one variable
    SELECT @fullText = ISNULL(@fullText, '') + CHAR(10) + [TEXT]
    FROM #triggerLines

    --adding "GO" for ease of copy paste execution
    SET @fullText = @fullText + CHAR(10) + 'GO' + CHAR(10)

    PRINT @fullText

    --accumulating result for future manipulations
    INSERT INTO #triggerFullText([TriggerName], [Text])
    VALUES(@triggerName, @fullText)

    --iterating over next trigger
    SELECT @triggerName = MIN(name)
    FROM sys.triggers
    WHERE name > @triggerName

    SET @fullText = NULL

    TRUNCATE TABLE #triggerLines
	end
END