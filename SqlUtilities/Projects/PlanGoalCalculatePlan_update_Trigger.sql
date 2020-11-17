USE [SMART]
GO

/****** Object:  Trigger [dbo].[PlanGoalCalculateActual_update]    Script Date: 09/25/2010 17:36:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create TRIGGER [dbo].[PlanGoalCalculatePlan_update]
ON [dbo].[PlanGoal]
After Update
AS
BEGIN
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


GO


USE [SMART]
GO

/****** Object:  Trigger [dbo].[PlanGoalCalculateActual_update]    Script Date: 09/25/2010 17:36:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create TRIGGER [dbo].[PlanGoalCalculateActual_update]
ON [dbo].[PlanActual]
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
	FROM PlanActual, Inserted
	WHERE PlanActual.Initcode = PlanActual.Initcode
		AND PlanActual.PlanYear = PlanActual.PlanYear
	END
		
END


GO


