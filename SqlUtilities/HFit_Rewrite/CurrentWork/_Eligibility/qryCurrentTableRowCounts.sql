--select 'Select ''' + table_name + ''' , count(*) as NbrRows from ' + table_name + ' ; '  from information_schema.tables where table_name like '%Eligi%'

Select 'HFit_PPTEligibility' , count(*) as NbrRows from HFit_PPTEligibility ; 
go
Select 'view_EDW_EligibilityHistory' , count(*) as NbrRows from view_EDW_EligibilityHistory ; 
go
Select 'view_EDW_Eligibility' , count(*) as NbrRows from view_EDW_Eligibility ; 
go
Select 'view_EDW_RoleEligibility' , count(*) as NbrRows from view_EDW_RoleEligibility ; 
go
Select 'view_EDW_CoachingPPTEligible' , count(*) as NbrRows from view_EDW_CoachingPPTEligible ; 
go
Select 'HFit_ChallengePPTEligibleCDPostTemplate' , count(*) as NbrRows from HFit_ChallengePPTEligibleCDPostTemplate ; 
go
Select 'hFit_ChallengePPTEligiblePostTemplate' , count(*) as NbrRows from hFit_ChallengePPTEligiblePostTemplate ; 
go
Select 'HFit_EligibilityLoadTracking' , count(*) as NbrRows from HFit_EligibilityLoadTracking ; 
go
Select 'View_Custom_HFit_UserEligibilityData' , count(*) as NbrRows from View_Custom_HFit_UserEligibilityData ; 
go
Select 'View_HFit_ChallengePPTEligibleCDPostTemplate_Joined' , count(*) as NbrRows from View_HFit_ChallengePPTEligibleCDPostTemplate_Joined ; 
go
Select 'View_hFit_ChallengePPTEligiblePostTemplate_Joined' , count(*) as NbrRows from View_hFit_ChallengePPTEligiblePostTemplate_Joined ; 
go
Select 'view_Statbridge_ScreeningEligibility' , count(*) as NbrRows from view_Statbridge_ScreeningEligibility ; 
go