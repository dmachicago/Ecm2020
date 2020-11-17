use KenticoCMS_Prod1
go
select count(*) from [DIM_EDW_HealthAssessment]
where CHANGED_FLG is not null
or [ChangeType] is not null

use KenticoCMS_Prod2
go
select count(*) from [DIM_EDW_HealthAssessment]
where CHANGED_FLG is not null
or [ChangeType] is not null

use KenticoCMS_Prod3
go
select count(*) from [DIM_EDW_HealthAssessment]
where CHANGED_FLG is not null
or [ChangeType] is not null
