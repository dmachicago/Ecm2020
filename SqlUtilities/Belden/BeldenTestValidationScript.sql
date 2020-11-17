Select count(*) as DM_F_SALES_SUMMARY_global from Bldsql1p.SMART_GLOBAL_DW.dbo.DM_F_SALES_SUMMARY	
Select count(*) as DM_F_SALES_SUMMARY_master from BDCSQLSP.SMART_DB.dbo.DM_F_SALES_SUMMARY 
Select count(*) as DM_F_SALES_SUMMARY_mirror from Bldsql1p.SMART.dbo.MIRROR_DM_F_SALES_SUMMARY

Select count(*) from BDCSQLSP.SMART_DB.dbo.BAG_BILLINGS	
Select count(*) from Bldsql1p.SMART.dbo.MIRROR_BAG_BILLINGS

Select count(*) from BDCSQLSP.SMART_DB.dbo.DM_L_HIERARCHY	
Select count(*) from Bldsql1p.SMART.dbo.MIRROR_DM_L_HIERARCHY

Select count(*) from BLDSQL1P.SMART_GLOBAL_DW.dbo.DM_D_ITEM	
Select count(*) from BDCSQLSP.SMART_DB.dbo.DM_D_ITEM	
Select count(*) from Bldsql1p.SMART.dbo.MIRROR_DM_D_ITEM

Select count(*) from BLDSQL1P.SMART_GLOBAL_DW.dbo.DM_D_CALENDAR	
Select count(*) from Bldsql1p.SMART.dbo.MIRROR_DM_D_CALENDAR

Select count(*) from BDCSQLSP.SMART_DB.dbo.DM_F_SALES_SUMMARY	
Select count(*) from Bldsql1p.SMART.dbo.MIRROR_DM_F_SALES_SUMMARY

Select count(*) from BLDSQL1P.SMART_GLOBAL_DW.dbo.DM_D_ITEM_CLASS	
Select count(*) from Bldsql1p.SMART.dbo.MIRROR_DM_D_ITEM_CLASS

Select count(*) from BLDSQL1P.SMART_GLOBAL_DW.dbo.DM_D_CUSTOMER_TYPE	
Select count(*) from Bldsql1p.SMART.dbo.MIRROR_DM_D_CUSTOMER_TYPE

Select count(*) from BLDSQL1P.SMART_GLOBAL_DW.dbo.DM_H_ITEM	
Select count(*) from Bldsql1p.SMART.dbo.MIRROR_DM_H_ITEM

Select count(*) from BDCSQLSP.SMART_DB.dbo.DM_D_CUSTOMER	
Select count(*) from Bldsql1p.SMART.dbo.MIRROR_DM_D_CUSTOMER

Select count(*) from BDCSQLSP.SMART_DB.dbo.DM_F_INVOICE_LN
Select count(*) from Bldsql1p.SMART.dbo.MIRROR_DM_F_INVOICE_LN

Select count(*) from BDCSQLSP.SMART_DB.dbo.TPR_X_RECAPCLASS_PRODUCTGROUP	
Select count(*) from Bldsql1p.SMART.dbo.MIRROR_TPR_X_RECAPCLASS_PRODUCTGROUP

/*********************************************/
SELECT SUM(NET_BILLING_AMT) as _Master FROM GLOBAL_BI WHERE Fiscal_Period='06' AND FISCAL_YEAR='2011'
GO
SELECT SUM(NET_BILLING_AMT) as _MIRROR FROM GLOBAL_BI_MIRROR WHERE Fiscal_Period='06' AND FISCAL_YEAR='2011'
GO

SELECT SUM(NET_BILLING_AMT) as Master_P1of3 FROM vGLOBAL_BI_EXTRACT_Master_P1of3 WHERE Fiscal_Period='06' AND FISCAL_YEAR='2011'
GO 
SELECT SUM(NET_BILLING_AMT) as Mirror_P1of3 FROM vGLOBAL_BI_EXTRACT_MIRROR_P1of3 WHERE Fiscal_Period='06' AND FISCAL_YEAR='2011'
GO

SELECT SUM(NET_BILLING_AMT) as Master_P2of3 FROM vGLOBAL_BI_EXTRACT_Master_P2of3 WHERE Fiscal_Period='06' AND FISCAL_YEAR='2011'
GO
SELECT SUM(NET_BILLING_AMT) as MIRROR_P2of3 FROM vGLOBAL_BI_EXTRACT_MIRROR_P2of3 WHERE Fiscal_Period='06' AND FISCAL_YEAR='2011'
GO

SELECT SUM(NET_BILLING_AMT) as Master_P3of3 FROM vGLOBAL_BI_EXTRACT_Master_P3of3 WHERE Fiscal_Period='06' AND FISCAL_YEAR='2011'
GO
SELECT SUM(NET_BILLING_AMT) as MIRROR_P3of3 FROM vGLOBAL_BI_EXTRACT_MIRROR_P3of3 WHERE Fiscal_Period='06' AND FISCAL_YEAR='2011'
GO

select * from Table_Row_COunt order by TableNAme
select * from staticMigrationLog order by StartTime

