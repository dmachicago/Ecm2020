USE [EmailAddr]
GO

/****** Object:  Index [PI_State]    Script Date: 6/21/2014 3:48:33 PM ******/
CREATE NONCLUSTERED INDEX [PI_City] ON [dbo].[EmailAddress]
(
	[CITY] ASC
)
INCLUDE ( 	[ZIP]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


  --  
  --  
GO 
print('***** FROM: X2.sql'); 
GO 
