DECLARE @count int = 0
WHILE (@count < 10)
BEGIN
SET @count = @count + 1;
IF(@count < 5)
BEGIN
SELECT @count AS Counter
CONTINUE;
END
ELSE
BREAK;
END