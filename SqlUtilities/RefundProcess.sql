/****** Script for SelectTopNRows command from SSMS  ******/
SELECT count(*), [EmailAddr] , Refunded     
  FROM [CCInfo].[dbo].[Payment]
  group by EmailAddr, Refunded
  having count(*) > 1 
  and refunded is null
  
  -- select PaymentCode, refunded from Payment where EmailAddr = 'Gina_cross@me.com'
  -- update Payment set Refunded = 1 where PaymentCode = '5953954603'
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
