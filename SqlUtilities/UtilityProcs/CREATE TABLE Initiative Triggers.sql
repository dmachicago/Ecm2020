USE [SMART]
GO

/****** Object:  Table [dbo].[Initiative]    Script Date: 09/24/2010 15:11:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Initiative]') AND type in (N'U'))
DROP TABLE [dbo].[Initiative]
GO

USE [SMART]
GO

/****** Object:  Table [dbo].[Initiative]    Script Date: 09/24/2010 15:11:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Initiative](
	[PartnerName] [nvarchar](25) NOT NULL,
	[PartnerDivision] [nvarchar](25) NOT NULL,
	[InitCode] [nvarchar](50) NOT NULL,
	[Initdesc] [nvarchar](2000) NULL,
 CONSTRAINT [PK_Initiative] PRIMARY KEY CLUSTERED 
(
	[InitCode] ASC,
	[PartnerName] ASC,
	[PartnerDivision] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO



USE [SMART]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefInitiative9]') AND parent_object_id = OBJECT_ID(N'[dbo].[PlanGoal]'))
ALTER TABLE [dbo].[PlanGoal] DROP CONSTRAINT [RefInitiative9]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_PlanGoal_01a]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PlanGoal] DROP CONSTRAINT [DF_PlanGoal_01a]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_PlanGoal_01b]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PlanGoal] DROP CONSTRAINT [DF_PlanGoal_01b]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_PlanGoal_02a]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PlanGoal] DROP CONSTRAINT [DF_PlanGoal_02a]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_PlanGoal_02b]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PlanGoal] DROP CONSTRAINT [DF_PlanGoal_02b]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_PlanGoal_03a]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PlanGoal] DROP CONSTRAINT [DF_PlanGoal_03a]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_PlanGoal_03b]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PlanGoal] DROP CONSTRAINT [DF_PlanGoal_03b]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_PlanGoal_04a]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PlanGoal] DROP CONSTRAINT [DF_PlanGoal_04a]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_PlanGoal_04ba]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PlanGoal] DROP CONSTRAINT [DF_PlanGoal_04ba]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_PlanGoal_05a]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PlanGoal] DROP CONSTRAINT [DF_PlanGoal_05a]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_PlanGoal_05b]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PlanGoal] DROP CONSTRAINT [DF_PlanGoal_05b]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_PlanGoal_06a]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PlanGoal] DROP CONSTRAINT [DF_PlanGoal_06a]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_PlanGoal_06b]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PlanGoal] DROP CONSTRAINT [DF_PlanGoal_06b]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_PlanGoal_07a]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PlanGoal] DROP CONSTRAINT [DF_PlanGoal_07a]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_PlanGoal_07b]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PlanGoal] DROP CONSTRAINT [DF_PlanGoal_07b]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_PlanGoal_08a]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PlanGoal] DROP CONSTRAINT [DF_PlanGoal_08a]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_PlanGoal_08b]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PlanGoal] DROP CONSTRAINT [DF_PlanGoal_08b]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_PlanGoal_09a]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PlanGoal] DROP CONSTRAINT [DF_PlanGoal_09a]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_PlanGoal_09b]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PlanGoal] DROP CONSTRAINT [DF_PlanGoal_09b]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_PlanGoal_10a]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PlanGoal] DROP CONSTRAINT [DF_PlanGoal_10a]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_PlanGoal_10b]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PlanGoal] DROP CONSTRAINT [DF_PlanGoal_10b]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_PlanGoal_11a]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PlanGoal] DROP CONSTRAINT [DF_PlanGoal_11a]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_PlanGoal_11b]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PlanGoal] DROP CONSTRAINT [DF_PlanGoal_11b]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_PlanGoal_12a]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PlanGoal] DROP CONSTRAINT [DF_PlanGoal_12a]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_PlanGoal_12b]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PlanGoal] DROP CONSTRAINT [DF_PlanGoal_12b]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_PlanGoal_13a]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PlanGoal] DROP CONSTRAINT [DF_PlanGoal_13a]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_PlanGoal_14b]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PlanGoal] DROP CONSTRAINT [DF_PlanGoal_14b]
END

GO

USE [SMART]
GO

/****** Object:  Table [dbo].[PlanGoal]    Script Date: 09/24/2010 15:11:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PlanGoal]') AND type in (N'U'))
DROP TABLE [dbo].[PlanGoal]
GO

USE [SMART]
GO

/****** Object:  Table [dbo].[PlanGoal]    Script Date: 09/24/2010 15:11:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[PlanGoal](
	[PartnerName] [nvarchar](25) NOT NULL,
	[PartnerDivision] [nvarchar](25) NOT NULL,
	[InitCode] [nvarchar](50) NOT NULL,
	[PlanYear] [int] NOT NULL,
	[January_Plan] [money] NULL,
	[January_Actual] [money] NULL,
	[February_Plan] [money] NULL,
	[February_Actual] [money] NULL,
	[March_Plan] [money] NULL,
	[March_Actual] [money] NULL,
	[April_Plan] [money] NULL,
	[April_Actual] [money] NULL,
	[May_Plan] [money] NULL,
	[May_Actual] [money] NULL,
	[June_Plan] [money] NULL,
	[June_Actual] [money] NULL,
	[July_Plan] [money] NULL,
	[July_Actual] [money] NULL,
	[August_Plan] [money] NULL,
	[August_Actual] [money] NULL,
	[September_Plan] [money] NULL,
	[September_Actual] [money] NULL,
	[October_Plan] [money] NULL,
	[October_Actual] [money] NULL,
	[November_Plan] [money] NULL,
	[November_Actual] [money] NULL,
	[December_Plan] [money] NULL,
	[December_Actual] [money] NULL,
	[TotalProjectedPlan] [money] NULL,
	[TotalActual] [money] NULL,
 CONSTRAINT [PK_Plan] PRIMARY KEY NONCLUSTERED 
(
	[InitCode] ASC,
	[PlanYear] ASC,
	[PartnerName] ASC,
	[PartnerDivision] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[PlanGoal]  WITH CHECK ADD  CONSTRAINT [RefInitiative9] FOREIGN KEY([InitCode], [PartnerName], [PartnerDivision])
REFERENCES [dbo].[Initiative] ([InitCode], [PartnerName], [PartnerDivision])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[PlanGoal] CHECK CONSTRAINT [RefInitiative9]
GO

ALTER TABLE [dbo].[PlanGoal] ADD  CONSTRAINT [DF_PlanGoal_01a]  DEFAULT ((0)) FOR [January_Plan]
GO

ALTER TABLE [dbo].[PlanGoal] ADD  CONSTRAINT [DF_PlanGoal_01b]  DEFAULT ((0)) FOR [January_Actual]
GO

ALTER TABLE [dbo].[PlanGoal] ADD  CONSTRAINT [DF_PlanGoal_02a]  DEFAULT ((0)) FOR [February_Plan]
GO

ALTER TABLE [dbo].[PlanGoal] ADD  CONSTRAINT [DF_PlanGoal_02b]  DEFAULT ((0)) FOR [February_Actual]
GO

ALTER TABLE [dbo].[PlanGoal] ADD  CONSTRAINT [DF_PlanGoal_03a]  DEFAULT ((0)) FOR [March_Plan]
GO

ALTER TABLE [dbo].[PlanGoal] ADD  CONSTRAINT [DF_PlanGoal_03b]  DEFAULT ((0)) FOR [March_Actual]
GO

ALTER TABLE [dbo].[PlanGoal] ADD  CONSTRAINT [DF_PlanGoal_04a]  DEFAULT ((0)) FOR [April_Plan]
GO

ALTER TABLE [dbo].[PlanGoal] ADD  CONSTRAINT [DF_PlanGoal_04ba]  DEFAULT ((0)) FOR [April_Actual]
GO

ALTER TABLE [dbo].[PlanGoal] ADD  CONSTRAINT [DF_PlanGoal_05a]  DEFAULT ((0)) FOR [May_Plan]
GO

ALTER TABLE [dbo].[PlanGoal] ADD  CONSTRAINT [DF_PlanGoal_05b]  DEFAULT ((0)) FOR [May_Actual]
GO

ALTER TABLE [dbo].[PlanGoal] ADD  CONSTRAINT [DF_PlanGoal_06a]  DEFAULT ((0)) FOR [June_Plan]
GO

ALTER TABLE [dbo].[PlanGoal] ADD  CONSTRAINT [DF_PlanGoal_06b]  DEFAULT ((0)) FOR [June_Actual]
GO

ALTER TABLE [dbo].[PlanGoal] ADD  CONSTRAINT [DF_PlanGoal_07a]  DEFAULT ((0)) FOR [July_Plan]
GO

ALTER TABLE [dbo].[PlanGoal] ADD  CONSTRAINT [DF_PlanGoal_07b]  DEFAULT ((0)) FOR [July_Actual]
GO

ALTER TABLE [dbo].[PlanGoal] ADD  CONSTRAINT [DF_PlanGoal_08a]  DEFAULT ((0)) FOR [August_Plan]
GO

ALTER TABLE [dbo].[PlanGoal] ADD  CONSTRAINT [DF_PlanGoal_08b]  DEFAULT ((0)) FOR [August_Actual]
GO

ALTER TABLE [dbo].[PlanGoal] ADD  CONSTRAINT [DF_PlanGoal_09a]  DEFAULT ((0)) FOR [September_Plan]
GO

ALTER TABLE [dbo].[PlanGoal] ADD  CONSTRAINT [DF_PlanGoal_09b]  DEFAULT ((0)) FOR [September_Actual]
GO

ALTER TABLE [dbo].[PlanGoal] ADD  CONSTRAINT [DF_PlanGoal_10a]  DEFAULT ((0)) FOR [October_Plan]
GO

ALTER TABLE [dbo].[PlanGoal] ADD  CONSTRAINT [DF_PlanGoal_10b]  DEFAULT ((0)) FOR [October_Actual]
GO

ALTER TABLE [dbo].[PlanGoal] ADD  CONSTRAINT [DF_PlanGoal_11a]  DEFAULT ((0)) FOR [November_Plan]
GO

ALTER TABLE [dbo].[PlanGoal] ADD  CONSTRAINT [DF_PlanGoal_11b]  DEFAULT ((0)) FOR [November_Actual]
GO

ALTER TABLE [dbo].[PlanGoal] ADD  CONSTRAINT [DF_PlanGoal_12a]  DEFAULT ((0)) FOR [December_Plan]
GO

ALTER TABLE [dbo].[PlanGoal] ADD  CONSTRAINT [DF_PlanGoal_12b]  DEFAULT ((0)) FOR [December_Actual]
GO

ALTER TABLE [dbo].[PlanGoal] ADD  CONSTRAINT [DF_PlanGoal_13a]  DEFAULT ((0)) FOR [TotalProjectedPlan]
GO

ALTER TABLE [dbo].[PlanGoal] ADD  CONSTRAINT [DF_PlanGoal_14b]  DEFAULT ((0)) FOR [TotalActual]
GO


drop view vPlanGoal 
go
create view vPlanGoal as
SELECT [PartnerName]
      ,[PartnerDivision]
      ,[InitCode]
      ,[PlanYear]
      ,[January_Plan]
      ,[February_Plan]
      ,[March_Plan]
      ,[April_Plan]
      ,[May_Plan]
      ,[June_Plan]
      ,[July_Plan]
      ,[August_Plan]
      ,[September_Plan]
      ,[October_Plan]
      ,[November_Plan]
      ,[December_Plan]      
FROM [SMART].[dbo].[PlanGoal]
  
alter PROCEDURE PlanUpdProcMonthPlan
(
    @InitCode               nvarchar(25),
    @PlanYear               int,
    @MonthNbr               int,
    @Amt					Money)
AS
BEGIN
    BEGIN TRAN
	IF @MonthNbr = 1
	BEGIN
		UPDATE PlanGoal
		   SET January_Plan = @Amt	   
		 WHERE InitCode = @InitCode
		   AND PlanYear = @PlanYear
	End
	IF @MonthNbr = 2
	BEGIN
		UPDATE PlanGoal
		   SET February_Plan = @Amt			   
		 WHERE InitCode = @InitCode
		   AND PlanYear = @PlanYear
	End 
	IF @MonthNbr = 3
	BEGIN
		UPDATE PlanGoal
		   SET March_Plan = @Amt			  
		 WHERE InitCode = @InitCode
		   AND PlanYear = @PlanYear
	End
	IF @MonthNbr = 4
	BEGIN
		UPDATE PlanGoal
		   SET April_Plan = @Amt			   
		 WHERE InitCode = @InitCode
		   AND PlanYear = @PlanYear
	End
	IF @MonthNbr = 5
	BEGIN
		UPDATE PlanGoal
		   SET May_Plan = @Amt			   
		 WHERE InitCode = @InitCode
		   AND PlanYear = @PlanYear
	End
	IF @MonthNbr = 6
	BEGIN
		UPDATE PlanGoal
		   SET June_Plan = @Amt			   
		 WHERE InitCode = @InitCode
		   AND PlanYear = @PlanYear
	End
	IF @MonthNbr = 7
	BEGIN
		UPDATE PlanGoal
		   SET July_Plan = @Amt
		 WHERE InitCode = @InitCode
		   AND PlanYear = @PlanYear
	End
	IF @MonthNbr = 8
	BEGIN
		UPDATE PlanGoal
		   SET August_Plan = @Amt
		 WHERE InitCode = @InitCode
		   AND PlanYear = @PlanYear
	End
	IF @MonthNbr = 9
	BEGIN
		UPDATE PlanGoal
		   SET September_Plan = @Amt
		 WHERE InitCode = @InitCode
		   AND PlanYear = @PlanYear
	End
	IF @MonthNbr = 10
	BEGIN
		UPDATE PlanGoal
		   SET October_Plan = @Amt
		 WHERE InitCode = @InitCode
		   AND PlanYear = @PlanYear
	End
	IF @MonthNbr = 11
	BEGIN
		UPDATE PlanGoal
		   SET November_Plan = @Amt
		 WHERE InitCode = @InitCode
		   AND PlanYear = @PlanYear
	End
	IF @MonthNbr = 12
	BEGIN
		UPDATE PlanGoal
		   SET December_Plan = @Amt
		 WHERE InitCode = @InitCode
		   AND PlanYear = @PlanYear
	End
    
    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 'PlanUpdProcMonthPlan: Cannot update  in PlanGoal '
        ROLLBACK TRAN
        RETURN(1)    
    END

    COMMIT TRAN

    RETURN(0)
END
go

alter PROCEDURE PlanUpdProcMonthActual
(
    @InitCode               nvarchar(25),
    @PlanYear               int,
    @MonthNbr               int,
    @Amt					Money)
AS
BEGIN
    BEGIN TRAN
	IF @MonthNbr = 1
	BEGIN
		UPDATE PlanGoal
			SET January_Actual = @Amt			   
		 WHERE InitCode = @InitCode
		   AND PlanYear = @PlanYear
	End
	IF @MonthNbr = 2
	BEGIN
		UPDATE PlanGoal
		   SET February_Actual = @Amt			   
		 WHERE InitCode = @InitCode
		   AND PlanYear = @PlanYear
	End
	IF @MonthNbr = 3
	BEGIN
		UPDATE PlanGoal
		   SET March_Actual = @Amt			  
		 WHERE InitCode = @InitCode
		   AND PlanYear = @PlanYear
	End
	IF @MonthNbr = 4
	BEGIN
		UPDATE PlanGoal
		   SET April_Actual = @Amt			   
		 WHERE InitCode = @InitCode
		   AND PlanYear = @PlanYear
	End
	IF @MonthNbr = 5
	BEGIN
		UPDATE PlanGoal
		   SET May_Actual = @Amt			   
		 WHERE InitCode = @InitCode
		   AND PlanYear = @PlanYear
	End
	IF @MonthNbr = 6
	BEGIN
		UPDATE PlanGoal
		   SET June_Actual = @Amt			   
		 WHERE InitCode = @InitCode
		   AND PlanYear = @PlanYear
	End
	IF @MonthNbr = 7
	BEGIN
		UPDATE PlanGoal
		   SET July_Actual = @Amt
		 WHERE InitCode = @InitCode
		   AND PlanYear = @PlanYear
	End
	IF @MonthNbr = 8
	BEGIN
		UPDATE PlanGoal
		   SET August_Actual = @Amt
		 WHERE InitCode = @InitCode
		   AND PlanYear = @PlanYear
	End
	IF @MonthNbr = 9
	BEGIN
		UPDATE PlanGoal
		   SET September_Actual = @Amt
		 WHERE InitCode = @InitCode
		   AND PlanYear = @PlanYear
	End
	IF @MonthNbr = 10
	BEGIN
		UPDATE PlanGoal
		   SET October_Actual = @Amt
		 WHERE InitCode = @InitCode
		   AND PlanYear = @PlanYear
	End
	IF @MonthNbr = 11
	BEGIN
		UPDATE PlanGoal
		   SET November_Actual = @Amt
		 WHERE InitCode = @InitCode
		   AND PlanYear = @PlanYear
	End
	IF @MonthNbr = 12
	BEGIN
		UPDATE PlanGoal
		   SET December_Actual = @Amt
		 WHERE InitCode = @InitCode
		   AND PlanYear = @PlanYear
	End
    
    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 'PlanUpdProcMonthActual: Cannot update  in PlanGoal '
        ROLLBACK TRAN
        RETURN(1)    
    END

    COMMIT TRAN

    RETURN(0)
END
go

use Smart
go


create TRIGGER PlanGoalCalculateActual_insert
ON dbo.PlanGoal
After INSERT
AS
BEGIN
	UPDATE PlanGoal
	SET PlanGoal.TotalActual = 
		PlanGoal.January_Actual         +
		PlanGoal.February_Actual       +
		PlanGoal.March_Actual           +
		PlanGoal.April_Actual           +
		PlanGoal.May_Actual             +
		PlanGoal.June_Actual            +
		PlanGoal.July_Actual            +
		PlanGoal.August_Actual          +
		PlanGoal.September_Actual       +
		PlanGoal.October_Actual         +
		PlanGoal.November_Actual        +
		PlanGoal.December_Actual
	FROM PlanGoal, inserted
	WHERE PlanGoal.Initcode = PlanGoal.Initcode
		AND PlanGoal.PlanYear = PlanGoal.PlanYear
		
	UPDATE PlanGoal
	SET PlanGoal.TotalProjectedPlan = 
		PlanGoal.January_Plan         +
		PlanGoal.February_Plan       +
		PlanGoal.March_Plan           +
		PlanGoal.April_Plan           +
		PlanGoal.May_Plan             +
		PlanGoal.June_Plan            +
		PlanGoal.July_Plan            +
		PlanGoal.August_Plan          +
		PlanGoal.September_Plan       +
		PlanGoal.October_Plan         +
		PlanGoal.November_Plan        +
		PlanGoal.December_Plan
	FROM  PlanGoal, inserted
	WHERE PlanGoal.Initcode = PlanGoal.Initcode
		AND PlanGoal.PlanYear = PlanGoal.PlanYear
	
END
go

create TRIGGER PlanGoalCalculateActual_update
ON dbo.PlanGoal
After Update
AS
BEGIN
	if update(January_Actual) or
		update(February_Actual) or
		update(March_Actual) or
		update(April_Actual) or
		update(May_Actual) or
		update(June_Actual) or
		update(July_Actual) or
		update(August_Actual) or
		update(September_Actual) or
		update(October_Actual) or
		update(November_Actual) or
		update(December_Actual)
	BEGIN
	UPDATE PlanGoal
	SET PlanGoal.TotalActual = 
		PlanGoal.January_Actual         +
		PlanGoal.February_Actual       +
		PlanGoal.March_Actual           +
		PlanGoal.April_Actual           +
		PlanGoal.May_Actual             +
		PlanGoal.June_Actual            +
		PlanGoal.July_Actual            +
		PlanGoal.August_Actual          +
		PlanGoal.September_Actual       +
		PlanGoal.October_Actual         +
		PlanGoal.November_Actual        +
		PlanGoal.December_Actual
	FROM PlanGoal, Inserted
	WHERE PlanGoal.Initcode = PlanGoal.Initcode
		AND PlanGoal.PlanYear = PlanGoal.PlanYear
	END
	
	if update(January_Plan) or
		update(February_Plan) or
		update(March_Plan) or
		update(April_Plan) or
		update(May_Plan) or
		update(June_Plan) or
		update(July_Plan) or
		update(August_Plan) or
		update(September_Plan) or
		update(October_Plan) or
		update(November_Plan) or
		update(December_Plan)
	BEGIN
	UPDATE PlanGoal
	SET PlanGoal.TotalProjectedPlan = 
		PlanGoal.January_Plan         +
		PlanGoal.February_Plan       +
		PlanGoal.March_Plan           +
		PlanGoal.April_Plan           +
		PlanGoal.May_Plan             +
		PlanGoal.June_Plan            +
		PlanGoal.July_Plan            +
		PlanGoal.August_Plan          +
		PlanGoal.September_Plan       +
		PlanGoal.October_Plan         +
		PlanGoal.November_Plan        +
		PlanGoal.December_Plan
	FROM PlanGoal, Inserted
	WHERE PlanGoal.Initcode = PlanGoal.Initcode
		AND PlanGoal.PlanYear = PlanGoal.PlanYear
	END	
END


/*************************************************/

--truncate table PlanGoal
INSERT INTO [SMART].[dbo].[Initiative]
           ([PartnerName]
           ,[PartnerDivision]
           ,[InitCode]
           ,[Initdesc])
     VALUES
           ('P_Name1'
           ,'P_DIV1'
           ,'Init01'
           ,'Desc 01'
           )
GO

select * FROM [dbo].[Initiative]
go
/*************************************************/

INSERT INTO [SMART].[dbo].[PlanGoal]
           ([PartnerName]
           ,[PartnerDivision]
           ,[InitCode]
           ,[PlanYear]
           )
     VALUES
           ('P_Name1'
           ,'P_DIV2'
           ,'Init02'
           ,10
           )
GO

INSERT INTO [SMART].[dbo].[PlanGoal]
           ([PartnerName]
           ,[PartnerDivision]
           ,[InitCode]
           ,[PlanYear]
           )
     VALUES
           ('P_Name1'
           ,'P_DIV1'
           ,'Init01'
           ,10
           )
GO



UPDATE [dbo].[PlanGoal]
     SET January_Plan =  January_Plan + 250
     Where 
           PartnerName = 'P_Name1'
           and PartnerDivision = 'P_DIV2'
           and InitCode = 'Init02'
           and PlanYear = 10
           
GO
UPDATE [dbo].[PlanGoal]
     SET January_Plan = January_Plan + 50 
     Where 
           PartnerName = 'P_Name1'
           and PartnerDivision = 'P_DIV1'
           and InitCode = 'Init01'
           and PlanYear = 10
           
GO

UPDATE [dbo].[PlanGoal]
     SET January_Actual =  January_Actual + 350
     Where 
           PartnerName = 'P_Name1'
           and PartnerDivision = 'P_DIV2'
           and InitCode = 'Init02'
           and PlanYear = 10
GO

UPDATE [dbo].[PlanGoal]
     SET January_Actual = January_Actual + 25 
     Where 
           PartnerName = 'P_Name1'
           and PartnerDivision = 'P_DIV1'
           and InitCode = 'Init01'
           and PlanYear = 10
GO


select * FROM [dbo].[PlanGoal]


GO
