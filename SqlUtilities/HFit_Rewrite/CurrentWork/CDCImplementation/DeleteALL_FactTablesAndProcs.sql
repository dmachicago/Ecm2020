SELECT          
    'Drop procedure ' + name + char(10) + 'GO'
FROM
    sys.procedures 
where name like 'proc_FACT%' or name like '%_CTHIST' 
union
SELECT          
    'Drop Table ' + table_name +  char(10) + 'GO'
FROM
    INFORMATION_SCHEMA.TABLES
where table_name like 'FACT_%'

Drop Table FACT_CMS_Class
GO
Drop Table FACT_CMS_Class_CTVerHIST
GO
Drop Table FACT_CMS_Class_DEL
GO
Drop Table FACT_CMS_Document
GO
Drop Table FACT_CMS_Document_CTVerHIST
GO
Drop Table FACT_CMS_Document_DEL
GO
Drop Table FACT_CMS_Site
GO
Drop Table FACT_CMS_Site_CTVerHIST
GO
Drop Table FACT_CMS_Site_DEL
GO
Drop Table FACT_CMS_Tree
GO
Drop Table FACT_CMS_Tree_CTVerHIST
GO
Drop Table FACT_CMS_Tree_DEL
GO
Drop Table FACT_cms_user
GO
Drop Table FACT_cms_user_CTVerHIST
GO
Drop Table FACT_cms_user_DEL
GO
Drop Table FACT_CMS_USERSite
GO
Drop Table FACT_CMS_USERSite_CTVerHIST
GO
Drop Table FACT_CMS_USERSite_DEL
GO
