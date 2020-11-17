select view_name, table_name, column_name, 
	case 
		WHEN SV.name is NULL Then 'N'
		ELSE 'Y'
	end
	as isView
from INFORMATION_SCHEMA.VIEW_COLUMN_USAGE as T1
	LEFT OUTER JOIN sys.views as SV on SV.name = T1.table_name	
WHERE VIEW_NAME = 'view_EDW_HealthAssesment'


--Get the next VIEW from witin the returned set and do the same
select view_name, table_name, column_name, 
	case 
		WHEN SV.name is NULL Then 'N'
		ELSE 'Y'
	end
	as isView
from INFORMATION_SCHEMA.VIEW_COLUMN_USAGE as T1
	LEFT OUTER JOIN sys.views as SV on SV.name = T1.table_name	
WHERE VIEW_NAME = 'View_HFit_HealthAssesmentQuestions'

--Get the next VIEW from witin the returned set and do the same
select view_name, table_name, column_name, 
	case 
		WHEN SV.name is NULL Then 'N'
		ELSE 'Y'
	end
	as isView
from INFORMATION_SCHEMA.VIEW_COLUMN_USAGE as T1
	LEFT OUTER JOIN sys.views as SV on SV.name = T1.table_name	
WHERE VIEW_NAME = 'View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined'


--Get the next VIEW from witin the returned set and do the same
select view_name, table_name, column_name, 
	case 
		WHEN SV.name is NULL Then 'N'
		ELSE 'Y'
	end
	as isView
from INFORMATION_SCHEMA.VIEW_COLUMN_USAGE as T1
	LEFT OUTER JOIN sys.views as SV on SV.name = T1.table_name	
WHERE VIEW_NAME = 'View_CMS_Tree_Joined'


