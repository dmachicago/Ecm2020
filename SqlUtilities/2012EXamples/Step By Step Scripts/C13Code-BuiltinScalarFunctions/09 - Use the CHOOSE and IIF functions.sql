declare @choosevar int = 3
SELECT
CHOOSE(@choosevar, 'ONE', 'TWO', 'PATRICK', 'THREE') [Choose],
IIF(DATENAME(MONTH, GETDATE()) = 'July', 'The 4th is this month', 'No Fireworks') AS
[IIF]