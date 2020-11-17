--04:55:58
select * 
into Staging_EDW_HealthAssesment_BACKUP
from view_EDW_HealthAssesment 


select * 
into DIM_EDW_BioMetrics_BACKUP
from DIM_EDW_BioMetrics
