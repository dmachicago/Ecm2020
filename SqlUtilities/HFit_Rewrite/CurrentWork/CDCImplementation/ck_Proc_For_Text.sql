SELECT DISTINCT
       o.name AS Object_Name,
       o.type_desc
  FROM sys.sql_modules m
       INNER JOIN
       sys.objects o
         ON m.object_id = o.object_id
 WHERE m.definition Like '%KenticoCMS[_]1%'
 and o.name like '%KenticoCMS[_]3%'

-- proc_BASE_view_EDW_TrackerCompositeDetails_CT_ONLY_KenticoCMS_2_ApplyCT
-- proc_BASE_View_HFit_Coach_Bio_HISTORY_KenticoCMS_2_ApplyCT

-- proc_BASE_view_EDW_HAassessment_KenticoCMS_3_ApplyCT
-- proc_BASE_view_EDW_TrackerCompositeDetails_CT_ONLY_KenticoCMS_3_ApplyCT
-- proc_BASE_View_HFit_Coach_Bio_HISTORY_KenticoCMS_3_ApplyCT