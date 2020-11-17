
USE [SMART]
GO

/****** Object:  Trigger [dbo].[PlanGoalCalculateActual_insert]    Script Date: 09/25/2010 17:35:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create TRIGGER [dbo].[PlanGoalCalculatePlan_insert]
ON [dbo].[PlanGoal]
After INSERT
AS
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
	FROM  PlanGoal, inserted
	WHERE PlanGoal.Initcode = PlanGoal.Initcode
		AND PlanGoal.PlanYear = PlanGoal.PlanYear
	
END

GO


USE [SMART]
GO

/****** Object:  Trigger [dbo].[PlanGoalCalculateActual_insert]    Script Date: 09/25/2010 17:35:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create TRIGGER [dbo].[PlanGoalCalculateActual_insert]
ON dbo.PlanActual
After INSERT
AS
BEGIN
	UPDATE PlanActual
	SET PlanActual.TotalActual = 
		PlanActual.January_Actual         +
		PlanActual.February_Actual       +
		PlanActual.March_Actual           +
		PlanActual.April_Actual           +
		PlanActual.May_Actual             +
		PlanActual.June_Actual            +
		PlanActual.July_Actual            +
		PlanActual.August_Actual          +
		PlanActual.September_Actual       +
		PlanActual.October_Actual         +
		PlanActual.November_Actual        +
		PlanActual.December_Actual
	FROM PlanActual, inserted
	WHERE PlanActual.Initcode = PlanActual.Initcode
		AND PlanActual.PlanYear = PlanActual.PlanYear
		
END

GO


