SELECT
'LEBLANC '+', '+' PATRICK' RawValues,
RTRIM('LEBLANC ')+', '+LTRIM(' PATRICK') TrimValue,
LEFT('PatrickDTomorr', 7) [Left],
RIGHT('DTomorrLeBlanc', 7) [Right],
SUBSTRING('DTomorrPatrick',8,LEN('DTomorrPatrick')) [SubString],
'12/'+CAST(1 AS VARCHAR)+'/2012' WithoutConcat,
CONCAT('12/',1,'/2012') WithConcat