USE [PTMS]
go

-- Role Alter SQL


-- User Alter SQL


-- Schema Alter SQL


-- Dictionary Object Alter SQL


-- Standard Alter Table SQL

ALTER TABLE dbo.ptms_EstExpense DROP CONSTRAINT PK11
go
ALTER TABLE dbo.ptms_EstExpense ADD CONSTRAINT PK11
PRIMARY KEY NONCLUSTERED (ExpenseCode,UserLoginID,CourseID,ProviderID,LocationCode)
go

-- Drop Referencing Constraint SQL


-- Drop Constraint, Rename and Create Table SQL

EXEC sp_rename 'dbo.ptms_CourseEvaluation.PK27','PK27_03112011010349001','INDEX'
go
EXEC sp_rename 'dbo.FK__ptms_Cour__UserL__45BE5BA9','FK__ptms_C_03112011010349002'
go
EXEC sp_rename 'dbo.FK__ptms_CourseEvalu__46B27FE2','FK__ptms_C_03112011010349003'
go


/* 
 * PROCEDURE: ptms_CourseEvaluationDelProc 
 */

CREATE PROCEDURE ptms_Cours_03112011010349004
(
    @EvaluationID           int)
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM ptms_CourseEvaluation
     WHERE EvaluationID = @EvaluationID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 'ptms_CourseEvaluationDelProc: Cannot delete because foreign keys still exist in ptms_CourseEvaluation '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('dbo.ptms_Cours_03112011010349004') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.ptms_Cours_03112011010349004 >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.ptms_Cours_03112011010349004 >>>'
go


/* 
 * PROCEDURE: ptms_CourseEvaluationInsProc 
 */

CREATE PROCEDURE ptms_Cours_03112011010349005
(
    @LocationCode           nvarchar(80)             = NULL,
    @UserLoginID            nvarchar(50)             = NULL,
    @Evaluation             nvarchar(max)            = NULL,
    @CourseRating           int                      = NULL,
    @InstructorRating       int                      = NULL,
    @Questionaire_Title     nvarchar(25),
    @PresentationOrder      int)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO ptms_CourseEvaluation(LocationCode,
                                      UserLoginID,
                                      Evaluation,
                                      CourseRating,
                                      InstructorRating,
                                      Questionaire_Title,
                                      PresentationOrder)
    VALUES(@LocationCode,
           @UserLoginID,
           @Evaluation,
           @CourseRating,
           @InstructorRating,
           @Questionaire_Title,
           @PresentationOrder)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 'ptms_CourseEvaluationInsProc: Cannot insert because primary key value not found in ptms_CourseEvaluation '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END
go
IF OBJECT_ID('dbo.ptms_Cours_03112011010349005') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.ptms_Cours_03112011010349005 >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.ptms_Cours_03112011010349005 >>>'
go


/* 
 * PROCEDURE: ptms_CourseEvaluationSelProc 
 */

CREATE PROCEDURE ptms_Cours_03112011010349006
(
    @EvaluationID           int)
AS
BEGIN
    SELECT EvaluationID,
           LocationCode,
           UserLoginID,
           Evaluation,
           CourseRating,
           InstructorRating,
           Questionaire_Title,
           PresentationOrder
      FROM ptms_CourseEvaluation
     WHERE EvaluationID = @EvaluationID

    RETURN(0)
END
go
IF OBJECT_ID('dbo.ptms_Cours_03112011010349006') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.ptms_Cours_03112011010349006 >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.ptms_Cours_03112011010349006 >>>'
go


/* 
 * PROCEDURE: ptms_CourseEvaluationUpdProc 
 */

CREATE PROCEDURE ptms_Cours_03112011010349007
(
    @EvaluationID           int,
    @LocationCode           nvarchar(80)             = NULL,
    @UserLoginID            nvarchar(50)             = NULL,
    @Evaluation             nvarchar(max)            = NULL,
    @CourseRating           int                      = NULL,
    @InstructorRating       int                      = NULL,
    @Questionaire_Title     nvarchar(25),
    @PresentationOrder      int)
AS
BEGIN
    BEGIN TRAN

    UPDATE ptms_CourseEvaluation
       SET LocationCode            = @LocationCode,
           UserLoginID             = @UserLoginID,
           Evaluation              = @Evaluation,
           CourseRating            = @CourseRating,
           InstructorRating        = @InstructorRating,
           Questionaire_Title      = @Questionaire_Title,
           PresentationOrder       = @PresentationOrder
     WHERE EvaluationID = @EvaluationID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 'ptms_CourseEvaluationUpdProc: Cannot update  in ptms_CourseEvaluation '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('dbo.ptms_Cours_03112011010349007') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.ptms_Cours_03112011010349007 >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.ptms_Cours_03112011010349007 >>>'
go
EXEC sp_rename 'dbo.ptms_CourseEvaluation','ptms_Cours_03112011010349000',OBJECT
go
CREATE TABLE dbo.ptms_CourseEvaluation
(
    EvaluationID       int          IDENTITY,
    LocationCode       nvarchar(80) NOT NULL,
    UserLoginID        nvarchar(50) NULL,
    Evaluation         nvarchar     NULL,
    CourseRating       int          NULL,
    InstructorRating   int          NULL,
    Questionaire_Title nvarchar(25) NOT NULL,
    PresentationOrder  int          NOT NULL,
    CourseID           nvarchar(80) NOT NULL,
    ProviderID         nvarchar(50) NOT NULL
)
ON [PRIMARY]
go
EXEC sp_rename 'dbo.ptms_CourseStat.PK6','PK6_03112011010350001','INDEX'
go
EXEC sp_rename 'dbo.FK__ptms_CourseStat__4A8310C6','FK__ptms_C_03112011010350002'
go
EXEC sp_rename 'dbo.FK__ptms_Cour__UserL__4B7734FF','FK__ptms_C_03112011010350003'
go


/* 
 * PROCEDURE: ptms_CourseStatDelProc 
 */

CREATE PROCEDURE ptms_Cours_03112011010350004
(
    @UserLoginID               nvarchar(50),
    @CourseID                  nvarchar(80),
    @ProviderID                nvarchar(50),
    @LocationCode              nvarchar(80))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM ptms_CourseStat
     WHERE UserLoginID  = @UserLoginID
       AND CourseID     = @CourseID
       AND ProviderID   = @ProviderID
       AND LocationCode = @LocationCode

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 'ptms_CourseStatDelProc: Cannot delete because foreign keys still exist in ptms_CourseStat '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('dbo.ptms_Cours_03112011010350004') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.ptms_Cours_03112011010350004 >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.ptms_Cours_03112011010350004 >>>'
go


/* 
 * PROCEDURE: ptms_CourseStatInsProc 
 */

CREATE PROCEDURE ptms_Cours_03112011010350005
(
    @UserLoginID               nvarchar(50),
    @CourseID                  nvarchar(80),
    @ProviderID                nvarchar(50),
    @LocationCode              nvarchar(80),
    @ScheduledToStart          bit                      = NULL,
    @CompletedSuccessfully     bit                      = NULL,
    @FailedToAttend            bit                      = NULL,
    @FailedCourse              bit                      = NULL,
    @Notes                     nvarchar(max)            = NULL,
    @PreReqFulfilled           bit                      = NULL,
    @PreReqWaiverGranter       bit                      = NULL,
    @CourseGrade               decimal(5, 2)            = NULL,
    @CPE_Credits               int                      = NULL,
    @CompletedDate             datetime                 = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO ptms_CourseStat(UserLoginID,
                                CourseID,
                                ProviderID,
                                LocationCode,
                                ScheduledToStart,
                                CompletedSuccessfully,
                                FailedToAttend,
                                FailedCourse,
                                Notes,
                                PreReqFulfilled,
                                PreReqWaiverGranter,
                                CourseGrade,
                                CPE_Credits,
                                CompletedDate)
    VALUES(@UserLoginID,
           @CourseID,
           @ProviderID,
           @LocationCode,
           @ScheduledToStart,
           @CompletedSuccessfully,
           @FailedToAttend,
           @FailedCourse,
           @Notes,
           @PreReqFulfilled,
           @PreReqWaiverGranter,
           @CourseGrade,
           @CPE_Credits,
           @CompletedDate)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 'ptms_CourseStatInsProc: Cannot insert because primary key value not found in ptms_CourseStat '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END
go
IF OBJECT_ID('dbo.ptms_Cours_03112011010350005') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.ptms_Cours_03112011010350005 >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.ptms_Cours_03112011010350005 >>>'
go


/* 
 * PROCEDURE: ptms_CourseStatSelProc 
 */

CREATE PROCEDURE ptms_Cours_03112011010350006
(
    @UserLoginID               nvarchar(50),
    @CourseID                  nvarchar(80),
    @ProviderID                nvarchar(50),
    @LocationCode              nvarchar(80))
AS
BEGIN
    SELECT UserLoginID,
           CourseID,
           ProviderID,
           LocationCode,
           ScheduledToStart,
           CompletedSuccessfully,
           FailedToAttend,
           FailedCourse,
           Notes,
           PreReqFulfilled,
           PreReqWaiverGranter,
           CourseGrade,
           CPE_Credits,
           CompletedDate
      FROM ptms_CourseStat
     WHERE UserLoginID  = @UserLoginID
       AND CourseID     = @CourseID
       AND ProviderID   = @ProviderID
       AND LocationCode = @LocationCode

    RETURN(0)
END
go
IF OBJECT_ID('dbo.ptms_Cours_03112011010350006') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.ptms_Cours_03112011010350006 >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.ptms_Cours_03112011010350006 >>>'
go


/* 
 * PROCEDURE: ptms_CourseStatUpdProc 
 */

CREATE PROCEDURE ptms_Cours_03112011010350007
(
    @UserLoginID               nvarchar(50),
    @CourseID                  nvarchar(80),
    @ProviderID                nvarchar(50),
    @LocationCode              nvarchar(80),
    @ScheduledToStart          bit                      = NULL,
    @CompletedSuccessfully     bit                      = NULL,
    @FailedToAttend            bit                      = NULL,
    @FailedCourse              bit                      = NULL,
    @Notes                     nvarchar(max)            = NULL,
    @PreReqFulfilled           bit                      = NULL,
    @PreReqWaiverGranter       bit                      = NULL,
    @CourseGrade               decimal(5, 2)            = NULL,
    @CPE_Credits               int                      = NULL,
    @CompletedDate             datetime                 = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE ptms_CourseStat
       SET ScheduledToStart           = @ScheduledToStart,
           CompletedSuccessfully      = @CompletedSuccessfully,
           FailedToAttend             = @FailedToAttend,
           FailedCourse               = @FailedCourse,
           Notes                      = @Notes,
           PreReqFulfilled            = @PreReqFulfilled,
           PreReqWaiverGranter        = @PreReqWaiverGranter,
           CourseGrade                = @CourseGrade,
           CPE_Credits                = @CPE_Credits,
           CompletedDate              = @CompletedDate
     WHERE UserLoginID  = @UserLoginID
       AND CourseID     = @CourseID
       AND ProviderID   = @ProviderID
       AND LocationCode = @LocationCode

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 'ptms_CourseStatUpdProc: Cannot update  in ptms_CourseStat '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('dbo.ptms_Cours_03112011010350007') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.ptms_Cours_03112011010350007 >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.ptms_Cours_03112011010350007 >>>'
go
EXEC sp_rename 'dbo.ptms_CourseStat','ptms_Cours_03112011010350000',OBJECT
go
CREATE TABLE dbo.ptms_CourseStat
(
    UserLoginID           nvarchar(50) NOT NULL,
    CourseID              nvarchar(80) NOT NULL,
    LocationCode          nvarchar(80) NOT NULL,
    ProviderID            nvarchar(50) NOT NULL,
    ScheduledToStart      bit          NULL,
    CompletedSuccessfully bit          NULL,
    FailedToAttend        bit          NULL,
    FailedCourse          bit          NULL,
    Notes                 nvarchar(1)  NULL,
    PreReqFulfilled       bit          NULL,
    PreReqWaiverGranter   bit          NULL,
    CourseGrade           decimal(5,2) NULL,
    CPE_Credits           int          NULL,
    CompletedDate         datetime     NULL
)
ON [PRIMARY]
go
EXEC sp_rename 'dbo.ptms_EvalResponse.PK29','PK29_03112011010352001','INDEX'
go
EXEC sp_rename 'dbo.Refptms_CourseEvalQuestion53','Refptms_Co_03112011010352002'
go


/* 
 * PROCEDURE: ptms_EvalResponseDelProc 
 */

CREATE PROCEDURE ptms_EvalR_03112011010352003
(
    @UserLoginID            nvarchar(50),
    @Questionaire_Title     nvarchar(25),
    @EvaluationID           int,
    @PresentationOrder      int)
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM ptms_EvalResponse
     WHERE UserLoginID        = @UserLoginID
       AND Questionaire_Title = @Questionaire_Title
       AND EvaluationID       = @EvaluationID
       AND PresentationOrder  = @PresentationOrder

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 'ptms_EvalResponseDelProc: Cannot delete because foreign keys still exist in ptms_EvalResponse '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('dbo.ptms_EvalR_03112011010352003') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.ptms_EvalR_03112011010352003 >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.ptms_EvalR_03112011010352003 >>>'
go


/* 
 * PROCEDURE: ptms_EvalResponseInsProc 
 */

CREATE PROCEDURE ptms_EvalR_03112011010352004
(
    @UserLoginID            nvarchar(50),
    @QuestionResponse       int                     = NULL,
    @Questionaire_Title     nvarchar(25),
    @EvaluationID           int,
    @PresentationOrder      int)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO ptms_EvalResponse(UserLoginID,
                                  QuestionResponse,
                                  Questionaire_Title,
                                  EvaluationID,
                                  PresentationOrder)
    VALUES(@UserLoginID,
           @QuestionResponse,
           @Questionaire_Title,
           @EvaluationID,
           @PresentationOrder)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 'ptms_EvalResponseInsProc: Cannot insert because primary key value not found in ptms_EvalResponse '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END
go
IF OBJECT_ID('dbo.ptms_EvalR_03112011010352004') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.ptms_EvalR_03112011010352004 >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.ptms_EvalR_03112011010352004 >>>'
go


/* 
 * PROCEDURE: ptms_EvalResponseSelProc 
 */

CREATE PROCEDURE ptms_EvalR_03112011010352005
(
    @UserLoginID            nvarchar(50),
    @Questionaire_Title     nvarchar(25),
    @EvaluationID           int,
    @PresentationOrder      int)
AS
BEGIN
    SELECT UserLoginID,
           QuestionResponse,
           Questionaire_Title,
           EvaluationID,
           PresentationOrder
      FROM ptms_EvalResponse
     WHERE UserLoginID        = @UserLoginID
       AND Questionaire_Title = @Questionaire_Title
       AND EvaluationID       = @EvaluationID
       AND PresentationOrder  = @PresentationOrder

    RETURN(0)
END
go
IF OBJECT_ID('dbo.ptms_EvalR_03112011010352005') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.ptms_EvalR_03112011010352005 >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.ptms_EvalR_03112011010352005 >>>'
go


/* 
 * PROCEDURE: ptms_EvalResponseUpdProc 
 */

CREATE PROCEDURE ptms_EvalR_03112011010352006
(
    @UserLoginID            nvarchar(50),
    @QuestionResponse       int                     = NULL,
    @Questionaire_Title     nvarchar(25),
    @EvaluationID           int,
    @PresentationOrder      int)
AS
BEGIN
    BEGIN TRAN

    UPDATE ptms_EvalResponse
       SET QuestionResponse        = @QuestionResponse
     WHERE UserLoginID        = @UserLoginID
       AND Questionaire_Title = @Questionaire_Title
       AND EvaluationID       = @EvaluationID
       AND PresentationOrder  = @PresentationOrder

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 'ptms_EvalResponseUpdProc: Cannot update  in ptms_EvalResponse '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('dbo.ptms_EvalR_03112011010352006') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.ptms_EvalR_03112011010352006 >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.ptms_EvalR_03112011010352006 >>>'
go
EXEC sp_rename 'dbo.ptms_EvalResponse','ptms_EvalR_03112011010352000',OBJECT
go
CREATE TABLE dbo.ptms_EvalResponse
(
    UserLoginID        nvarchar(50) NOT NULL,
    QuestionResponse   int          NULL,
    Questionaire_Title nvarchar(25) NOT NULL,
    EvaluationID       int          NOT NULL,
    PresentationOrder  int          NOT NULL,
    Strongly_Agree     bit          NULL,
    Agree              bit          NULL,
    Neutral            bit          NULL,
    Disagree           bit          NULL,
    Strongly_Disagree  bit          NULL,
    CourseID           nvarchar(80) NOT NULL,
    ProviderID         nvarchar(50) NOT NULL,
    LocationCode       nvarchar(80) NOT NULL
)
ON [PRIMARY]
go

-- Insert Data SQL

SET IDENTITY_INSERT dbo.ptms_CourseEvaluation ON
go
INSERT INTO dbo.ptms_CourseEvaluation(
                                      EvaluationID,
                                      LocationCode,
                                      UserLoginID,
                                      Evaluation,
                                      CourseRating,
                                      InstructorRating,
                                      Questionaire_Title,
                                      PresentationOrder,
                                      CourseID,
                                      ProviderID
                                     )
                               SELECT 
                                      EvaluationID,
                                      LocationCode,
                                      UserLoginID,
                                      Evaluation,
                                      CourseRating,
                                      InstructorRating,
                                      Questionaire_Title,
                                      PresentationOrder,
                                      ' ',
                                      ' '
                                 FROM dbo.ptms_Cours_03112011010349000 
go
SET IDENTITY_INSERT dbo.ptms_CourseEvaluation OFF
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.ptms_Cours_03112011010349000') AND name='UI_001')
BEGIN
    DROP INDEX dbo.ptms_Cours_03112011010349000.UI_001
    IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.ptms_Cours_03112011010349000') AND name='UI_001')
        PRINT '<<< FAILED DROPPING INDEX dbo.ptms_Cours_03112011010349000.UI_001 >>>'
    ELSE
        PRINT '<<< DROPPED INDEX dbo.ptms_Cours_03112011010349000.UI_001 >>>'
END
go
INSERT INTO dbo.ptms_CourseStat(
                                UserLoginID,
                                CourseID,
                                LocationCode,
                                ProviderID,
                                ScheduledToStart,
                                CompletedSuccessfully,
                                FailedToAttend,
                                FailedCourse,
                                Notes,
                                PreReqFulfilled,
                                PreReqWaiverGranter,
                                CourseGrade,
                                CPE_Credits,
                                CompletedDate
                               )
                         SELECT 
                                UserLoginID,
                                CourseID,
                                LocationCode,
                                ProviderID,
                                ScheduledToStart,
                                CompletedSuccessfully,
                                FailedToAttend,
                                FailedCourse,
                                Notes,
                                PreReqFulfilled,
                                PreReqWaiverGranter,
                                CourseGrade,
                                CPE_Credits,
                                CompletedDate
                           FROM dbo.ptms_Cours_03112011010350000 
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.ptms_Cours_03112011010350000') AND name='Ref15')
BEGIN
    DROP INDEX dbo.ptms_Cours_03112011010350000.Ref15
    IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.ptms_Cours_03112011010350000') AND name='Ref15')
        PRINT '<<< FAILED DROPPING INDEX dbo.ptms_Cours_03112011010350000.Ref15 >>>'
    ELSE
        PRINT '<<< DROPPED INDEX dbo.ptms_Cours_03112011010350000.Ref15 >>>'
END
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.ptms_Cours_03112011010350000') AND name='Ref712')
BEGIN
    DROP INDEX dbo.ptms_Cours_03112011010350000.Ref712
    IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.ptms_Cours_03112011010350000') AND name='Ref712')
        PRINT '<<< FAILED DROPPING INDEX dbo.ptms_Cours_03112011010350000.Ref712 >>>'
    ELSE
        PRINT '<<< DROPPED INDEX dbo.ptms_Cours_03112011010350000.Ref712 >>>'
END
go
INSERT INTO dbo.ptms_EvalResponse(
                                  UserLoginID,
                                  QuestionResponse,
                                  Questionaire_Title,
                                  EvaluationID,
                                  PresentationOrder,
                                  Strongly_Agree,
                                  Agree,
                                  Neutral,
                                  Disagree,
                                  Strongly_Disagree,
                                  CourseID,
                                  ProviderID,
                                  LocationCode
                                 )
                           SELECT 
                                  UserLoginID,
                                  QuestionResponse,
                                  Questionaire_Title,
                                  EvaluationID,
                                  PresentationOrder,
                                  Strongly_Agree,
                                  Agree,
                                  Neutral,
                                  Disagree,
                                  Strongly_Disagree,
                                  ' ',
                                  ' ',
                                  ' '
                             FROM dbo.ptms_EvalR_03112011010352000 
go

-- Add Constraint SQL

ALTER TABLE dbo.ptms_CourseEvaluation ADD CONSTRAINT PK27
PRIMARY KEY CLUSTERED (EvaluationID,CourseID,ProviderID,LocationCode)
go
ALTER TABLE dbo.ptms_CourseStat ADD CONSTRAINT PK6
PRIMARY KEY CLUSTERED (UserLoginID,CourseID,LocationCode,ProviderID)
go
ALTER TABLE dbo.ptms_EvalResponse ADD CONSTRAINT PK29
PRIMARY KEY NONCLUSTERED (Questionaire_Title,PresentationOrder,CourseID,ProviderID,LocationCode,UserLoginID,EvaluationID)
go

-- Add Indexes SQL

CREATE UNIQUE NONCLUSTERED INDEX UI_001
    ON dbo.ptms_CourseEvaluation(LocationCode,UserLoginID,Questionaire_Title)
    ON [PRIMARY]
go

-- Add Dependencies SQL

SET QUOTED_IDENTIFIER ON
go
SET ANSI_NULLS ON
go
IF OBJECT_ID('dbo.ptms_CourseEvaluationDelProc') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.ptms_CourseEvaluationDelProc
    IF OBJECT_ID('dbo.ptms_CourseEvaluationDelProc') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.ptms_CourseEvaluationDelProc >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.ptms_CourseEvaluationDelProc >>>'
END
go


/* 
 * PROCEDURE: ptms_CourseEvaluationDelProc 
 */

CREATE PROCEDURE ptms_CourseEvaluationDelProc
(
    @EvaluationID           int)
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM ptms_CourseEvaluation
     WHERE EvaluationID = @EvaluationID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 'ptms_CourseEvaluationDelProc: Cannot delete because foreign keys still exist in ptms_CourseEvaluation '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('dbo.ptms_CourseEvaluationDelProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.ptms_CourseEvaluationDelProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.ptms_CourseEvaluationDelProc >>>'
go
SET ANSI_NULLS OFF
go
SET QUOTED_IDENTIFIER OFF
go
IF OBJECT_ID('dbo.ptms_CourseEvaluationDelProc') IS NULL
BEGIN
	EXEC sp_rename 'ptms_Cours_03112011010349004', 'ptms_CourseEvaluationDelProc'
	IF OBJECT_ID('dbo.ptms_CourseEvaluationDelProc') IS NOT NULL
	   PRINT '<<< PROCEDURE dbo.ptms_CourseEvaluationDelProc is no longer valid. Please modify the SQL so that it is validated against dbo.ptms_CourseEvaluation >>>'
END
go
IF OBJECT_ID('dbo.ptms_CourseEvaluationInsProc') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.ptms_CourseEvaluationInsProc
    IF OBJECT_ID('dbo.ptms_CourseEvaluationInsProc') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.ptms_CourseEvaluationInsProc >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.ptms_CourseEvaluationInsProc >>>'
END
go


/* 
 * PROCEDURE: ptms_CourseEvaluationInsProc 
 */

CREATE PROCEDURE ptms_CourseEvaluationInsProc
(
    @LocationCode           nvarchar(80)             = NULL,
    @UserLoginID            nvarchar(50)             = NULL,
    @Evaluation             nvarchar(max)            = NULL,
    @CourseRating           int                      = NULL,
    @InstructorRating       int                      = NULL,
    @Questionaire_Title     nvarchar(25),
    @PresentationOrder      int)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO ptms_CourseEvaluation(LocationCode,
                                      UserLoginID,
                                      Evaluation,
                                      CourseRating,
                                      InstructorRating,
                                      Questionaire_Title,
                                      PresentationOrder)
    VALUES(@LocationCode,
           @UserLoginID,
           @Evaluation,
           @CourseRating,
           @InstructorRating,
           @Questionaire_Title,
           @PresentationOrder)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 'ptms_CourseEvaluationInsProc: Cannot insert because primary key value not found in ptms_CourseEvaluation '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END
go
IF OBJECT_ID('dbo.ptms_CourseEvaluationInsProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.ptms_CourseEvaluationInsProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.ptms_CourseEvaluationInsProc >>>'
go
IF OBJECT_ID('dbo.ptms_CourseEvaluationInsProc') IS NULL
BEGIN
	EXEC sp_rename 'ptms_Cours_03112011010349005', 'ptms_CourseEvaluationInsProc'
	IF OBJECT_ID('dbo.ptms_CourseEvaluationInsProc') IS NOT NULL
	   PRINT '<<< PROCEDURE dbo.ptms_CourseEvaluationInsProc is no longer valid. Please modify the SQL so that it is validated against dbo.ptms_CourseEvaluation >>>'
END
go
IF OBJECT_ID('dbo.ptms_CourseEvaluationSelProc') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.ptms_CourseEvaluationSelProc
    IF OBJECT_ID('dbo.ptms_CourseEvaluationSelProc') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.ptms_CourseEvaluationSelProc >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.ptms_CourseEvaluationSelProc >>>'
END
go


/* 
 * PROCEDURE: ptms_CourseEvaluationSelProc 
 */

CREATE PROCEDURE ptms_CourseEvaluationSelProc
(
    @EvaluationID           int)
AS
BEGIN
    SELECT EvaluationID,
           LocationCode,
           UserLoginID,
           Evaluation,
           CourseRating,
           InstructorRating,
           Questionaire_Title,
           PresentationOrder
      FROM ptms_CourseEvaluation
     WHERE EvaluationID = @EvaluationID

    RETURN(0)
END
go
IF OBJECT_ID('dbo.ptms_CourseEvaluationSelProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.ptms_CourseEvaluationSelProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.ptms_CourseEvaluationSelProc >>>'
go
IF OBJECT_ID('dbo.ptms_CourseEvaluationSelProc') IS NULL
BEGIN
	EXEC sp_rename 'ptms_Cours_03112011010349006', 'ptms_CourseEvaluationSelProc'
	IF OBJECT_ID('dbo.ptms_CourseEvaluationSelProc') IS NOT NULL
	   PRINT '<<< PROCEDURE dbo.ptms_CourseEvaluationSelProc is no longer valid. Please modify the SQL so that it is validated against dbo.ptms_CourseEvaluation >>>'
END
go
IF OBJECT_ID('dbo.ptms_CourseEvaluationUpdProc') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.ptms_CourseEvaluationUpdProc
    IF OBJECT_ID('dbo.ptms_CourseEvaluationUpdProc') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.ptms_CourseEvaluationUpdProc >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.ptms_CourseEvaluationUpdProc >>>'
END
go


/* 
 * PROCEDURE: ptms_CourseEvaluationUpdProc 
 */

CREATE PROCEDURE ptms_CourseEvaluationUpdProc
(
    @EvaluationID           int,
    @LocationCode           nvarchar(80)             = NULL,
    @UserLoginID            nvarchar(50)             = NULL,
    @Evaluation             nvarchar(max)            = NULL,
    @CourseRating           int                      = NULL,
    @InstructorRating       int                      = NULL,
    @Questionaire_Title     nvarchar(25),
    @PresentationOrder      int)
AS
BEGIN
    BEGIN TRAN

    UPDATE ptms_CourseEvaluation
       SET LocationCode            = @LocationCode,
           UserLoginID             = @UserLoginID,
           Evaluation              = @Evaluation,
           CourseRating            = @CourseRating,
           InstructorRating        = @InstructorRating,
           Questionaire_Title      = @Questionaire_Title,
           PresentationOrder       = @PresentationOrder
     WHERE EvaluationID = @EvaluationID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 'ptms_CourseEvaluationUpdProc: Cannot update  in ptms_CourseEvaluation '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('dbo.ptms_CourseEvaluationUpdProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.ptms_CourseEvaluationUpdProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.ptms_CourseEvaluationUpdProc >>>'
go
IF OBJECT_ID('dbo.ptms_CourseEvaluationUpdProc') IS NULL
BEGIN
	EXEC sp_rename 'ptms_Cours_03112011010349007', 'ptms_CourseEvaluationUpdProc'
	IF OBJECT_ID('dbo.ptms_CourseEvaluationUpdProc') IS NOT NULL
	   PRINT '<<< PROCEDURE dbo.ptms_CourseEvaluationUpdProc is no longer valid. Please modify the SQL so that it is validated against dbo.ptms_CourseEvaluation >>>'
END
go
IF OBJECT_ID('dbo.ptms_CourseStatDelProc') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.ptms_CourseStatDelProc
    IF OBJECT_ID('dbo.ptms_CourseStatDelProc') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.ptms_CourseStatDelProc >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.ptms_CourseStatDelProc >>>'
END
go


/* 
 * PROCEDURE: ptms_CourseStatDelProc 
 */

CREATE PROCEDURE ptms_CourseStatDelProc
(
    @UserLoginID               nvarchar(50),
    @CourseID                  nvarchar(80),
    @ProviderID                nvarchar(50),
    @LocationCode              nvarchar(80))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM ptms_CourseStat
     WHERE UserLoginID  = @UserLoginID
       AND CourseID     = @CourseID
       AND ProviderID   = @ProviderID
       AND LocationCode = @LocationCode

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 'ptms_CourseStatDelProc: Cannot delete because foreign keys still exist in ptms_CourseStat '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('dbo.ptms_CourseStatDelProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.ptms_CourseStatDelProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.ptms_CourseStatDelProc >>>'
go
IF OBJECT_ID('dbo.ptms_CourseStatDelProc') IS NULL
BEGIN
	EXEC sp_rename 'ptms_Cours_03112011010350004', 'ptms_CourseStatDelProc'
	IF OBJECT_ID('dbo.ptms_CourseStatDelProc') IS NOT NULL
	   PRINT '<<< PROCEDURE dbo.ptms_CourseStatDelProc is no longer valid. Please modify the SQL so that it is validated against dbo.ptms_CourseStat >>>'
END
go
IF OBJECT_ID('dbo.ptms_CourseStatInsProc') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.ptms_CourseStatInsProc
    IF OBJECT_ID('dbo.ptms_CourseStatInsProc') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.ptms_CourseStatInsProc >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.ptms_CourseStatInsProc >>>'
END
go


/* 
 * PROCEDURE: ptms_CourseStatInsProc 
 */

CREATE PROCEDURE ptms_CourseStatInsProc
(
    @UserLoginID               nvarchar(50),
    @CourseID                  nvarchar(80),
    @ProviderID                nvarchar(50),
    @LocationCode              nvarchar(80),
    @ScheduledToStart          bit                      = NULL,
    @CompletedSuccessfully     bit                      = NULL,
    @FailedToAttend            bit                      = NULL,
    @FailedCourse              bit                      = NULL,
    @Notes                     nvarchar(max)            = NULL,
    @PreReqFulfilled           bit                      = NULL,
    @PreReqWaiverGranter       bit                      = NULL,
    @CourseGrade               decimal(5, 2)            = NULL,
    @CPE_Credits               int                      = NULL,
    @CompletedDate             datetime                 = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO ptms_CourseStat(UserLoginID,
                                CourseID,
                                ProviderID,
                                LocationCode,
                                ScheduledToStart,
                                CompletedSuccessfully,
                                FailedToAttend,
                                FailedCourse,
                                Notes,
                                PreReqFulfilled,
                                PreReqWaiverGranter,
                                CourseGrade,
                                CPE_Credits,
                                CompletedDate)
    VALUES(@UserLoginID,
           @CourseID,
           @ProviderID,
           @LocationCode,
           @ScheduledToStart,
           @CompletedSuccessfully,
           @FailedToAttend,
           @FailedCourse,
           @Notes,
           @PreReqFulfilled,
           @PreReqWaiverGranter,
           @CourseGrade,
           @CPE_Credits,
           @CompletedDate)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 'ptms_CourseStatInsProc: Cannot insert because primary key value not found in ptms_CourseStat '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END
go
IF OBJECT_ID('dbo.ptms_CourseStatInsProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.ptms_CourseStatInsProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.ptms_CourseStatInsProc >>>'
go
IF OBJECT_ID('dbo.ptms_CourseStatInsProc') IS NULL
BEGIN
	EXEC sp_rename 'ptms_Cours_03112011010350005', 'ptms_CourseStatInsProc'
	IF OBJECT_ID('dbo.ptms_CourseStatInsProc') IS NOT NULL
	   PRINT '<<< PROCEDURE dbo.ptms_CourseStatInsProc is no longer valid. Please modify the SQL so that it is validated against dbo.ptms_CourseStat >>>'
END
go
IF OBJECT_ID('dbo.ptms_CourseStatSelProc') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.ptms_CourseStatSelProc
    IF OBJECT_ID('dbo.ptms_CourseStatSelProc') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.ptms_CourseStatSelProc >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.ptms_CourseStatSelProc >>>'
END
go


/* 
 * PROCEDURE: ptms_CourseStatSelProc 
 */

CREATE PROCEDURE ptms_CourseStatSelProc
(
    @UserLoginID               nvarchar(50),
    @CourseID                  nvarchar(80),
    @ProviderID                nvarchar(50),
    @LocationCode              nvarchar(80))
AS
BEGIN
    SELECT UserLoginID,
           CourseID,
           ProviderID,
           LocationCode,
           ScheduledToStart,
           CompletedSuccessfully,
           FailedToAttend,
           FailedCourse,
           Notes,
           PreReqFulfilled,
           PreReqWaiverGranter,
           CourseGrade,
           CPE_Credits,
           CompletedDate
      FROM ptms_CourseStat
     WHERE UserLoginID  = @UserLoginID
       AND CourseID     = @CourseID
       AND ProviderID   = @ProviderID
       AND LocationCode = @LocationCode

    RETURN(0)
END
go
IF OBJECT_ID('dbo.ptms_CourseStatSelProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.ptms_CourseStatSelProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.ptms_CourseStatSelProc >>>'
go
IF OBJECT_ID('dbo.ptms_CourseStatSelProc') IS NULL
BEGIN
	EXEC sp_rename 'ptms_Cours_03112011010350006', 'ptms_CourseStatSelProc'
	IF OBJECT_ID('dbo.ptms_CourseStatSelProc') IS NOT NULL
	   PRINT '<<< PROCEDURE dbo.ptms_CourseStatSelProc is no longer valid. Please modify the SQL so that it is validated against dbo.ptms_CourseStat >>>'
END
go
IF OBJECT_ID('dbo.ptms_CourseStatUpdProc') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.ptms_CourseStatUpdProc
    IF OBJECT_ID('dbo.ptms_CourseStatUpdProc') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.ptms_CourseStatUpdProc >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.ptms_CourseStatUpdProc >>>'
END
go


/* 
 * PROCEDURE: ptms_CourseStatUpdProc 
 */

CREATE PROCEDURE ptms_CourseStatUpdProc
(
    @UserLoginID               nvarchar(50),
    @CourseID                  nvarchar(80),
    @ProviderID                nvarchar(50),
    @LocationCode              nvarchar(80),
    @ScheduledToStart          bit                      = NULL,
    @CompletedSuccessfully     bit                      = NULL,
    @FailedToAttend            bit                      = NULL,
    @FailedCourse              bit                      = NULL,
    @Notes                     nvarchar(max)            = NULL,
    @PreReqFulfilled           bit                      = NULL,
    @PreReqWaiverGranter       bit                      = NULL,
    @CourseGrade               decimal(5, 2)            = NULL,
    @CPE_Credits               int                      = NULL,
    @CompletedDate             datetime                 = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE ptms_CourseStat
       SET ScheduledToStart           = @ScheduledToStart,
           CompletedSuccessfully      = @CompletedSuccessfully,
           FailedToAttend             = @FailedToAttend,
           FailedCourse               = @FailedCourse,
           Notes                      = @Notes,
           PreReqFulfilled            = @PreReqFulfilled,
           PreReqWaiverGranter        = @PreReqWaiverGranter,
           CourseGrade                = @CourseGrade,
           CPE_Credits                = @CPE_Credits,
           CompletedDate              = @CompletedDate
     WHERE UserLoginID  = @UserLoginID
       AND CourseID     = @CourseID
       AND ProviderID   = @ProviderID
       AND LocationCode = @LocationCode

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 'ptms_CourseStatUpdProc: Cannot update  in ptms_CourseStat '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('dbo.ptms_CourseStatUpdProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.ptms_CourseStatUpdProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.ptms_CourseStatUpdProc >>>'
go
IF OBJECT_ID('dbo.ptms_CourseStatUpdProc') IS NULL
BEGIN
	EXEC sp_rename 'ptms_Cours_03112011010350007', 'ptms_CourseStatUpdProc'
	IF OBJECT_ID('dbo.ptms_CourseStatUpdProc') IS NOT NULL
	   PRINT '<<< PROCEDURE dbo.ptms_CourseStatUpdProc is no longer valid. Please modify the SQL so that it is validated against dbo.ptms_CourseStat >>>'
END
go
IF OBJECT_ID('dbo.ptms_EvalResponseDelProc') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.ptms_EvalResponseDelProc
    IF OBJECT_ID('dbo.ptms_EvalResponseDelProc') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.ptms_EvalResponseDelProc >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.ptms_EvalResponseDelProc >>>'
END
go


/* 
 * PROCEDURE: ptms_EvalResponseDelProc 
 */

CREATE PROCEDURE ptms_EvalResponseDelProc
(
    @UserLoginID            nvarchar(50),
    @Questionaire_Title     nvarchar(25),
    @EvaluationID           int,
    @PresentationOrder      int)
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM ptms_EvalResponse
     WHERE UserLoginID        = @UserLoginID
       AND Questionaire_Title = @Questionaire_Title
       AND EvaluationID       = @EvaluationID
       AND PresentationOrder  = @PresentationOrder

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 'ptms_EvalResponseDelProc: Cannot delete because foreign keys still exist in ptms_EvalResponse '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('dbo.ptms_EvalResponseDelProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.ptms_EvalResponseDelProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.ptms_EvalResponseDelProc >>>'
go
IF OBJECT_ID('dbo.ptms_EvalResponseDelProc') IS NULL
BEGIN
	EXEC sp_rename 'ptms_EvalR_03112011010352003', 'ptms_EvalResponseDelProc'
	IF OBJECT_ID('dbo.ptms_EvalResponseDelProc') IS NOT NULL
	   PRINT '<<< PROCEDURE dbo.ptms_EvalResponseDelProc is no longer valid. Please modify the SQL so that it is validated against dbo.ptms_EvalResponse >>>'
END
go
IF OBJECT_ID('dbo.ptms_EvalResponseInsProc') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.ptms_EvalResponseInsProc
    IF OBJECT_ID('dbo.ptms_EvalResponseInsProc') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.ptms_EvalResponseInsProc >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.ptms_EvalResponseInsProc >>>'
END
go


/* 
 * PROCEDURE: ptms_EvalResponseInsProc 
 */

CREATE PROCEDURE ptms_EvalResponseInsProc
(
    @UserLoginID            nvarchar(50),
    @QuestionResponse       int                     = NULL,
    @Questionaire_Title     nvarchar(25),
    @EvaluationID           int,
    @PresentationOrder      int)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO ptms_EvalResponse(UserLoginID,
                                  QuestionResponse,
                                  Questionaire_Title,
                                  EvaluationID,
                                  PresentationOrder)
    VALUES(@UserLoginID,
           @QuestionResponse,
           @Questionaire_Title,
           @EvaluationID,
           @PresentationOrder)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 'ptms_EvalResponseInsProc: Cannot insert because primary key value not found in ptms_EvalResponse '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END
go
IF OBJECT_ID('dbo.ptms_EvalResponseInsProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.ptms_EvalResponseInsProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.ptms_EvalResponseInsProc >>>'
go
IF OBJECT_ID('dbo.ptms_EvalResponseInsProc') IS NULL
BEGIN
	EXEC sp_rename 'ptms_EvalR_03112011010352004', 'ptms_EvalResponseInsProc'
	IF OBJECT_ID('dbo.ptms_EvalResponseInsProc') IS NOT NULL
	   PRINT '<<< PROCEDURE dbo.ptms_EvalResponseInsProc is no longer valid. Please modify the SQL so that it is validated against dbo.ptms_EvalResponse >>>'
END
go
IF OBJECT_ID('dbo.ptms_EvalResponseSelProc') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.ptms_EvalResponseSelProc
    IF OBJECT_ID('dbo.ptms_EvalResponseSelProc') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.ptms_EvalResponseSelProc >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.ptms_EvalResponseSelProc >>>'
END
go


/* 
 * PROCEDURE: ptms_EvalResponseSelProc 
 */

CREATE PROCEDURE ptms_EvalResponseSelProc
(
    @UserLoginID            nvarchar(50),
    @Questionaire_Title     nvarchar(25),
    @EvaluationID           int,
    @PresentationOrder      int)
AS
BEGIN
    SELECT UserLoginID,
           QuestionResponse,
           Questionaire_Title,
           EvaluationID,
           PresentationOrder
      FROM ptms_EvalResponse
     WHERE UserLoginID        = @UserLoginID
       AND Questionaire_Title = @Questionaire_Title
       AND EvaluationID       = @EvaluationID
       AND PresentationOrder  = @PresentationOrder

    RETURN(0)
END
go
IF OBJECT_ID('dbo.ptms_EvalResponseSelProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.ptms_EvalResponseSelProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.ptms_EvalResponseSelProc >>>'
go
IF OBJECT_ID('dbo.ptms_EvalResponseSelProc') IS NULL
BEGIN
	EXEC sp_rename 'ptms_EvalR_03112011010352005', 'ptms_EvalResponseSelProc'
	IF OBJECT_ID('dbo.ptms_EvalResponseSelProc') IS NOT NULL
	   PRINT '<<< PROCEDURE dbo.ptms_EvalResponseSelProc is no longer valid. Please modify the SQL so that it is validated against dbo.ptms_EvalResponse >>>'
END
go
IF OBJECT_ID('dbo.ptms_EvalResponseUpdProc') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.ptms_EvalResponseUpdProc
    IF OBJECT_ID('dbo.ptms_EvalResponseUpdProc') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.ptms_EvalResponseUpdProc >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.ptms_EvalResponseUpdProc >>>'
END
go


/* 
 * PROCEDURE: ptms_EvalResponseUpdProc 
 */

CREATE PROCEDURE ptms_EvalResponseUpdProc
(
    @UserLoginID            nvarchar(50),
    @QuestionResponse       int                     = NULL,
    @Questionaire_Title     nvarchar(25),
    @EvaluationID           int,
    @PresentationOrder      int)
AS
BEGIN
    BEGIN TRAN

    UPDATE ptms_EvalResponse
       SET QuestionResponse        = @QuestionResponse
     WHERE UserLoginID        = @UserLoginID
       AND Questionaire_Title = @Questionaire_Title
       AND EvaluationID       = @EvaluationID
       AND PresentationOrder  = @PresentationOrder

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 'ptms_EvalResponseUpdProc: Cannot update  in ptms_EvalResponse '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('dbo.ptms_EvalResponseUpdProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.ptms_EvalResponseUpdProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.ptms_EvalResponseUpdProc >>>'
go
IF OBJECT_ID('dbo.ptms_EvalResponseUpdProc') IS NULL
BEGIN
	EXEC sp_rename 'ptms_EvalR_03112011010352006', 'ptms_EvalResponseUpdProc'
	IF OBJECT_ID('dbo.ptms_EvalResponseUpdProc') IS NOT NULL
	   PRINT '<<< PROCEDURE dbo.ptms_EvalResponseUpdProc is no longer valid. Please modify the SQL so that it is validated against dbo.ptms_EvalResponse >>>'
END
go

-- Update Views SQL


-- Add Privileges SQL


-- Alter Index SQL

CREATE NONCLUSTERED INDEX Ref712
    ON dbo.ptms_CourseStat(ProviderID,CourseID)
    ON [PRIMARY]
go
CREATE NONCLUSTERED INDEX Ref15
    ON dbo.ptms_CourseStat(UserLoginID)
    ON [PRIMARY]
go

-- Add Referencing Foreign Keys SQL

ALTER TABLE dbo.ptms_EstExpense ADD CONSTRAINT Refptms_CourseEnrollment18
FOREIGN KEY (UserLoginID,CourseID,LocationCode,ProviderID)
REFERENCES dbo.ptms_CourseEnrollment (UserLoginID,CourseID,LocationCode,ProviderID)
 ON DELETE CASCADE
 ON UPDATE CASCADE
go
ALTER TABLE dbo.ptms_CourseEvaluation ADD CONSTRAINT FK__ptms_Cour__UserL__45BE5BA9
FOREIGN KEY (UserLoginID)
REFERENCES dbo.ptms_Participant (UserLoginID)
 ON DELETE CASCADE
 ON UPDATE CASCADE
go
ALTER TABLE dbo.ptms_CourseEvaluation ADD CONSTRAINT FK__ptms_CourseEvalu__46B27FE2
FOREIGN KEY (Questionaire_Title,PresentationOrder)
REFERENCES dbo.ptms_CourseEvalQuestion (Questionaire_Title,PresentationOrder)
 ON DELETE CASCADE
 ON UPDATE CASCADE
go
ALTER TABLE dbo.ptms_CourseEvaluation ADD CONSTRAINT FK__ptms_Cour__Locat__44CA3770
FOREIGN KEY (LocationCode)
REFERENCES dbo.ptms_CourseLocation (LocationCode)
 ON DELETE CASCADE
 ON UPDATE CASCADE
go
ALTER TABLE dbo.ptms_CourseEvaluation ADD FOREIGN KEY (CourseID)
REFERENCES dbo.ptms_Course (CourseID)
 ON DELETE CASCADE
 ON UPDATE CASCADE
go
ALTER TABLE dbo.ptms_CourseEvaluation ADD FOREIGN KEY (ProviderID)
REFERENCES dbo.ptms_Provider (ProviderID)
 ON DELETE CASCADE
 ON UPDATE CASCADE
go
ALTER TABLE dbo.ptms_CourseStat ADD CONSTRAINT FK__ptms_CourseStat__4A8310C6
FOREIGN KEY (CourseID,ProviderID)
REFERENCES dbo.ptms_CourseProvider (CourseID,ProviderID)
 ON DELETE CASCADE
 ON UPDATE CASCADE
go
ALTER TABLE dbo.ptms_CourseStat ADD CONSTRAINT FK__ptms_Cour__UserL__4B7734FF
FOREIGN KEY (UserLoginID)
REFERENCES dbo.ptms_Participant (UserLoginID)
 ON DELETE CASCADE
 ON UPDATE CASCADE
go
ALTER TABLE dbo.ptms_EvalResponse ADD CONSTRAINT Refptms_Participant51
FOREIGN KEY (UserLoginID)
REFERENCES dbo.ptms_Participant (UserLoginID)
 ON DELETE CASCADE
 ON UPDATE CASCADE
go
ALTER TABLE dbo.ptms_EvalResponse ADD CONSTRAINT Refptms_CourseEvaluation54
FOREIGN KEY (EvaluationID,CourseID,ProviderID,LocationCode)
REFERENCES dbo.ptms_CourseEvaluation (EvaluationID,CourseID,ProviderID,LocationCode)
 ON DELETE CASCADE
 ON UPDATE CASCADE
go
ALTER TABLE dbo.ptms_EvalResponse ADD CONSTRAINT Refptms_CourseEvalQuestion53
FOREIGN KEY (Questionaire_Title,PresentationOrder)
REFERENCES dbo.ptms_CourseEvalQuestion (Questionaire_Title,PresentationOrder)
 ON DELETE CASCADE
 ON UPDATE CASCADE
go

-- Alter Procedure SQL


-- Alter Package SQL


-- Alter Oracle Object Type SQL


-- Alter Trigger SQL

USE [PTMS]
go

-- Role Alter SQL


-- User Alter SQL


-- Schema Alter SQL


-- Dictionary Object Alter SQL


-- Standard Alter Table SQL

ALTER TABLE dbo.ptms_EvalResponse DROP CONSTRAINT PK29
go
ALTER TABLE dbo.ptms_EvalResponse ADD CONSTRAINT PK29
PRIMARY KEY NONCLUSTERED (UserLoginID,Questionaire_Title,PresentationOrder,EvaluationID,CourseID,ProviderID,LocationCode)
go

-- Drop Referencing Constraint SQL


-- Drop Constraint, Rename and Create Table SQL

EXEC sp_rename 'dbo.ptms_CourseEvaluation.PK27','PK27_03112011011358001','INDEX'
go
EXEC sp_rename 'dbo.FK__ptms_Cour__Cours__719CDDE7','FK__ptms_C_03112011011358002'
go
EXEC sp_rename 'dbo.FK__ptms_Cour__Provi__72910220','FK__ptms_C_03112011011358003'
go
EXEC sp_rename 'dbo.FK__ptms_Cour__UserL__45BE5BA9','FK__ptms_C_03112011011358004'
go
EXEC sp_rename 'dbo.FK__ptms_CourseEvalu__46B27FE2','FK__ptms_C_03112011011358005'
go
EXEC sp_rename 'dbo.FK__ptms_Cour__Locat__44CA3770','FK__ptms_C_03112011011358006'
go


/* 
 * PROCEDURE: ptms_CourseEvaluationDelProc 
 */

CREATE PROCEDURE ptms_Cours_03112011011358007
(
    @EvaluationID           int)
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM ptms_CourseEvaluation
     WHERE EvaluationID = @EvaluationID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 'ptms_CourseEvaluationDelProc: Cannot delete because foreign keys still exist in ptms_CourseEvaluation '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('dbo.ptms_Cours_03112011011358007') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.ptms_Cours_03112011011358007 >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.ptms_Cours_03112011011358007 >>>'
go


/* 
 * PROCEDURE: ptms_CourseEvaluationInsProc 
 */

CREATE PROCEDURE ptms_Cours_03112011011358008
(
    @LocationCode           nvarchar(80)             = NULL,
    @UserLoginID            nvarchar(50)             = NULL,
    @Evaluation             nvarchar(max)            = NULL,
    @CourseRating           int                      = NULL,
    @InstructorRating       int                      = NULL,
    @Questionaire_Title     nvarchar(25),
    @PresentationOrder      int)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO ptms_CourseEvaluation(LocationCode,
                                      UserLoginID,
                                      Evaluation,
                                      CourseRating,
                                      InstructorRating,
                                      Questionaire_Title,
                                      PresentationOrder)
    VALUES(@LocationCode,
           @UserLoginID,
           @Evaluation,
           @CourseRating,
           @InstructorRating,
           @Questionaire_Title,
           @PresentationOrder)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 'ptms_CourseEvaluationInsProc: Cannot insert because primary key value not found in ptms_CourseEvaluation '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END
go
IF OBJECT_ID('dbo.ptms_Cours_03112011011358008') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.ptms_Cours_03112011011358008 >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.ptms_Cours_03112011011358008 >>>'
go


/* 
 * PROCEDURE: ptms_CourseEvaluationSelProc 
 */

CREATE PROCEDURE ptms_Cours_03112011011358009
(
    @EvaluationID           int)
AS
BEGIN
    SELECT EvaluationID,
           LocationCode,
           UserLoginID,
           Evaluation,
           CourseRating,
           InstructorRating,
           Questionaire_Title,
           PresentationOrder
      FROM ptms_CourseEvaluation
     WHERE EvaluationID = @EvaluationID

    RETURN(0)
END
go
IF OBJECT_ID('dbo.ptms_Cours_03112011011358009') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.ptms_Cours_03112011011358009 >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.ptms_Cours_03112011011358009 >>>'
go


/* 
 * PROCEDURE: ptms_CourseEvaluationUpdProc 
 */

CREATE PROCEDURE ptms_Cours_03112011011358010
(
    @EvaluationID           int,
    @LocationCode           nvarchar(80)             = NULL,
    @UserLoginID            nvarchar(50)             = NULL,
    @Evaluation             nvarchar(max)            = NULL,
    @CourseRating           int                      = NULL,
    @InstructorRating       int                      = NULL,
    @Questionaire_Title     nvarchar(25),
    @PresentationOrder      int)
AS
BEGIN
    BEGIN TRAN

    UPDATE ptms_CourseEvaluation
       SET LocationCode            = @LocationCode,
           UserLoginID             = @UserLoginID,
           Evaluation              = @Evaluation,
           CourseRating            = @CourseRating,
           InstructorRating        = @InstructorRating,
           Questionaire_Title      = @Questionaire_Title,
           PresentationOrder       = @PresentationOrder
     WHERE EvaluationID = @EvaluationID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 'ptms_CourseEvaluationUpdProc: Cannot update  in ptms_CourseEvaluation '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('dbo.ptms_Cours_03112011011358010') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.ptms_Cours_03112011011358010 >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.ptms_Cours_03112011011358010 >>>'
go
EXEC sp_rename 'dbo.ptms_CourseEvaluation','ptms_Cours_03112011011358000',OBJECT
go
CREATE TABLE dbo.ptms_CourseEvaluation
(
    EvaluationID       int          IDENTITY,
    LocationCode       nvarchar(80) NOT NULL,
    UserLoginID        nvarchar(50) NOT NULL,
    Evaluation         nvarchar     NULL,
    CourseRating       int          NULL,
    InstructorRating   int          NULL,
    Questionaire_Title nvarchar(25) NOT NULL,
    PresentationOrder  int          NOT NULL,
    CourseID           nvarchar(80) NOT NULL,
    ProviderID         nvarchar(50) NOT NULL
)
ON [PRIMARY]
go

-- Insert Data SQL

SET IDENTITY_INSERT dbo.ptms_CourseEvaluation ON
go
INSERT INTO dbo.ptms_CourseEvaluation(
                                      EvaluationID,
                                      LocationCode,
                                      UserLoginID,
                                      Evaluation,
                                      CourseRating,
                                      InstructorRating,
                                      Questionaire_Title,
                                      PresentationOrder,
                                      CourseID,
                                      ProviderID
                                     )
                               SELECT 
                                      EvaluationID,
                                      LocationCode,
                                      UserLoginID,
                                      SUBSTRING(Evaluation, 1, -1),
                                      CourseRating,
                                      InstructorRating,
                                      Questionaire_Title,
                                      PresentationOrder,
                                      CourseID,
                                      ProviderID
                                 FROM dbo.ptms_Cours_03112011011358000 
go
SET IDENTITY_INSERT dbo.ptms_CourseEvaluation OFF
go
IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.ptms_Cours_03112011011358000') AND name='UI_001')
BEGIN
    DROP INDEX dbo.ptms_Cours_03112011011358000.UI_001
    IF EXISTS (SELECT * FROM sysindexes WHERE id=OBJECT_ID('dbo.ptms_Cours_03112011011358000') AND name='UI_001')
        PRINT '<<< FAILED DROPPING INDEX dbo.ptms_Cours_03112011011358000.UI_001 >>>'
    ELSE
        PRINT '<<< DROPPED INDEX dbo.ptms_Cours_03112011011358000.UI_001 >>>'
END
go

-- Add Constraint SQL

ALTER TABLE dbo.ptms_CourseEvaluation ADD CONSTRAINT PK27
PRIMARY KEY CLUSTERED (EvaluationID,CourseID,ProviderID,LocationCode,UserLoginID)
go

-- Add Indexes SQL

CREATE UNIQUE NONCLUSTERED INDEX UI_001
    ON dbo.ptms_CourseEvaluation(LocationCode,UserLoginID,Questionaire_Title)
    ON [PRIMARY]
go

-- Add Dependencies SQL

SET QUOTED_IDENTIFIER ON
go
SET ANSI_NULLS ON
go
IF OBJECT_ID('dbo.ptms_CourseEvaluationDelProc') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.ptms_CourseEvaluationDelProc
    IF OBJECT_ID('dbo.ptms_CourseEvaluationDelProc') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.ptms_CourseEvaluationDelProc >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.ptms_CourseEvaluationDelProc >>>'
END
go


/* 
 * PROCEDURE: ptms_CourseEvaluationDelProc 
 */

CREATE PROCEDURE ptms_CourseEvaluationDelProc
(
    @EvaluationID           int)
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM ptms_CourseEvaluation
     WHERE EvaluationID = @EvaluationID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 'ptms_CourseEvaluationDelProc: Cannot delete because foreign keys still exist in ptms_CourseEvaluation '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('dbo.ptms_CourseEvaluationDelProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.ptms_CourseEvaluationDelProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.ptms_CourseEvaluationDelProc >>>'
go
SET ANSI_NULLS OFF
go
SET QUOTED_IDENTIFIER OFF
go
IF OBJECT_ID('dbo.ptms_CourseEvaluationDelProc') IS NULL
BEGIN
	EXEC sp_rename 'ptms_Cours_03112011011358007', 'ptms_CourseEvaluationDelProc'
	IF OBJECT_ID('dbo.ptms_CourseEvaluationDelProc') IS NOT NULL
	   PRINT '<<< PROCEDURE dbo.ptms_CourseEvaluationDelProc is no longer valid. Please modify the SQL so that it is validated against dbo.ptms_CourseEvaluation >>>'
END
go
IF OBJECT_ID('dbo.ptms_CourseEvaluationInsProc') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.ptms_CourseEvaluationInsProc
    IF OBJECT_ID('dbo.ptms_CourseEvaluationInsProc') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.ptms_CourseEvaluationInsProc >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.ptms_CourseEvaluationInsProc >>>'
END
go


/* 
 * PROCEDURE: ptms_CourseEvaluationInsProc 
 */

CREATE PROCEDURE ptms_CourseEvaluationInsProc
(
    @LocationCode           nvarchar(80)             = NULL,
    @UserLoginID            nvarchar(50)             = NULL,
    @Evaluation             nvarchar(max)            = NULL,
    @CourseRating           int                      = NULL,
    @InstructorRating       int                      = NULL,
    @Questionaire_Title     nvarchar(25),
    @PresentationOrder      int)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO ptms_CourseEvaluation(LocationCode,
                                      UserLoginID,
                                      Evaluation,
                                      CourseRating,
                                      InstructorRating,
                                      Questionaire_Title,
                                      PresentationOrder)
    VALUES(@LocationCode,
           @UserLoginID,
           @Evaluation,
           @CourseRating,
           @InstructorRating,
           @Questionaire_Title,
           @PresentationOrder)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 'ptms_CourseEvaluationInsProc: Cannot insert because primary key value not found in ptms_CourseEvaluation '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END
go
IF OBJECT_ID('dbo.ptms_CourseEvaluationInsProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.ptms_CourseEvaluationInsProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.ptms_CourseEvaluationInsProc >>>'
go
IF OBJECT_ID('dbo.ptms_CourseEvaluationInsProc') IS NULL
BEGIN
	EXEC sp_rename 'ptms_Cours_03112011011358008', 'ptms_CourseEvaluationInsProc'
	IF OBJECT_ID('dbo.ptms_CourseEvaluationInsProc') IS NOT NULL
	   PRINT '<<< PROCEDURE dbo.ptms_CourseEvaluationInsProc is no longer valid. Please modify the SQL so that it is validated against dbo.ptms_CourseEvaluation >>>'
END
go
IF OBJECT_ID('dbo.ptms_CourseEvaluationSelProc') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.ptms_CourseEvaluationSelProc
    IF OBJECT_ID('dbo.ptms_CourseEvaluationSelProc') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.ptms_CourseEvaluationSelProc >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.ptms_CourseEvaluationSelProc >>>'
END
go


/* 
 * PROCEDURE: ptms_CourseEvaluationSelProc 
 */

CREATE PROCEDURE ptms_CourseEvaluationSelProc
(
    @EvaluationID           int)
AS
BEGIN
    SELECT EvaluationID,
           LocationCode,
           UserLoginID,
           Evaluation,
           CourseRating,
           InstructorRating,
           Questionaire_Title,
           PresentationOrder
      FROM ptms_CourseEvaluation
     WHERE EvaluationID = @EvaluationID

    RETURN(0)
END
go
IF OBJECT_ID('dbo.ptms_CourseEvaluationSelProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.ptms_CourseEvaluationSelProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.ptms_CourseEvaluationSelProc >>>'
go
IF OBJECT_ID('dbo.ptms_CourseEvaluationSelProc') IS NULL
BEGIN
	EXEC sp_rename 'ptms_Cours_03112011011358009', 'ptms_CourseEvaluationSelProc'
	IF OBJECT_ID('dbo.ptms_CourseEvaluationSelProc') IS NOT NULL
	   PRINT '<<< PROCEDURE dbo.ptms_CourseEvaluationSelProc is no longer valid. Please modify the SQL so that it is validated against dbo.ptms_CourseEvaluation >>>'
END
go
IF OBJECT_ID('dbo.ptms_CourseEvaluationUpdProc') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.ptms_CourseEvaluationUpdProc
    IF OBJECT_ID('dbo.ptms_CourseEvaluationUpdProc') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.ptms_CourseEvaluationUpdProc >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.ptms_CourseEvaluationUpdProc >>>'
END
go


/* 
 * PROCEDURE: ptms_CourseEvaluationUpdProc 
 */

CREATE PROCEDURE ptms_CourseEvaluationUpdProc
(
    @EvaluationID           int,
    @LocationCode           nvarchar(80)             = NULL,
    @UserLoginID            nvarchar(50)             = NULL,
    @Evaluation             nvarchar(max)            = NULL,
    @CourseRating           int                      = NULL,
    @InstructorRating       int                      = NULL,
    @Questionaire_Title     nvarchar(25),
    @PresentationOrder      int)
AS
BEGIN
    BEGIN TRAN

    UPDATE ptms_CourseEvaluation
       SET LocationCode            = @LocationCode,
           UserLoginID             = @UserLoginID,
           Evaluation              = @Evaluation,
           CourseRating            = @CourseRating,
           InstructorRating        = @InstructorRating,
           Questionaire_Title      = @Questionaire_Title,
           PresentationOrder       = @PresentationOrder
     WHERE EvaluationID = @EvaluationID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 'ptms_CourseEvaluationUpdProc: Cannot update  in ptms_CourseEvaluation '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('dbo.ptms_CourseEvaluationUpdProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.ptms_CourseEvaluationUpdProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.ptms_CourseEvaluationUpdProc >>>'
go
IF OBJECT_ID('dbo.ptms_CourseEvaluationUpdProc') IS NULL
BEGIN
	EXEC sp_rename 'ptms_Cours_03112011011358010', 'ptms_CourseEvaluationUpdProc'
	IF OBJECT_ID('dbo.ptms_CourseEvaluationUpdProc') IS NOT NULL
	   PRINT '<<< PROCEDURE dbo.ptms_CourseEvaluationUpdProc is no longer valid. Please modify the SQL so that it is validated against dbo.ptms_CourseEvaluation >>>'
END
go

-- Update Views SQL


-- Add Privileges SQL


-- Alter Index SQL


-- Add Referencing Foreign Keys SQL

ALTER TABLE dbo.ptms_EvalResponse ADD CONSTRAINT Refptms_CourseEvaluation54
FOREIGN KEY (EvaluationID,CourseID,ProviderID,LocationCode,UserLoginID)
REFERENCES dbo.ptms_CourseEvaluation (EvaluationID,CourseID,ProviderID,LocationCode,UserLoginID)
 ON DELETE CASCADE
 ON UPDATE CASCADE
go
ALTER TABLE dbo.ptms_CourseEvaluation ADD FOREIGN KEY (CourseID)
REFERENCES dbo.ptms_Course (CourseID)
 ON DELETE CASCADE
 ON UPDATE CASCADE
go
ALTER TABLE dbo.ptms_CourseEvaluation ADD FOREIGN KEY (ProviderID)
REFERENCES dbo.ptms_Provider (ProviderID)
 ON DELETE CASCADE
 ON UPDATE CASCADE
go
ALTER TABLE dbo.ptms_CourseEvaluation ADD CONSTRAINT FK__ptms_Cour__UserL__45BE5BA9
FOREIGN KEY (UserLoginID)
REFERENCES dbo.ptms_Participant (UserLoginID)
 ON DELETE CASCADE
 ON UPDATE CASCADE
go
ALTER TABLE dbo.ptms_CourseEvaluation ADD CONSTRAINT FK__ptms_CourseEvalu__46B27FE2
FOREIGN KEY (Questionaire_Title,PresentationOrder)
REFERENCES dbo.ptms_CourseEvalQuestion (Questionaire_Title,PresentationOrder)
 ON DELETE CASCADE
 ON UPDATE CASCADE
go
ALTER TABLE dbo.ptms_CourseEvaluation ADD CONSTRAINT FK__ptms_Cour__Locat__44CA3770
FOREIGN KEY (LocationCode)
REFERENCES dbo.ptms_CourseLocation (LocationCode)
 ON DELETE CASCADE
 ON UPDATE CASCADE
go

-- Alter Procedure SQL


-- Alter Package SQL


-- Alter Oracle Object Type SQL


-- Alter Trigger SQL

