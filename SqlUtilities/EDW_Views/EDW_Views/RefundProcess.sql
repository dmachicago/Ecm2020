/****** Script for SelectTopNRows command from SSMS  ******/
SELECT count(*), [EmailAddr] , Refunded     
  FROM [CCInfo].[dbo].[Payment]
  group by EmailAddr, Refunded
  having count(*) > 1 
  and refunded is null
  
  -- select PaymentCode, refunded from Payment where EmailAddr = 'Gina_cross@me.com'
  -- update Payment set Refunded = 1 where PaymentCode = '5953954603'†ⴭ†਍†ⴭ†਍佇ഠ瀊楲瑮✨⨪⨪‪剆䵏›敒畦摮牐捯獥⹳煳❬㬩ഠ䜊⁏਍