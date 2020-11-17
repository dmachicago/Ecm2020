
GO
print 'FROM dropViews.sql' ;
GO

if exists (select table_name from information_schema.tables where table_name = 'view_EDW_HADefinition')
BEGIN
    drop view view_EDW_HADefinition ;
    print 'drop view view_EDW_HADefinition' ;
END

GO

if exists (select table_name from information_schema.tables where table_name = 'view_HFit_TrackerCompositeDetails')
BEGIN
    drop view view_HFit_TrackerCompositeDetails ;
    print 'drop view view_HFit_TrackerCompositeDetails' ;
END

GO 
if exists (select name from sys.objects where name = 'Proc_EDW_HealthAssessmentDefinition')
BEGIN
    drop procedure Proc_EDW_HealthAssessmentDefinition;
    print 'drop procedure Proc_EDW_HealthAssessmentDefinition' ;
END

go

if exists (select name from sys.objects where name = 'proc_EDW_HealthAssessment')
BEGIN
    drop procedure proc_EDW_HealthAssessment;
    print 'drop procedure proc_EDW_HealthAssessment' ;
END

GO

if exists (select name from sys.objects where name = 'proc_getViewsNestedObjects')
BEGIN
    drop procedure proc_getViewsNestedObjects;
    print 'drop procedure proc_getViewsNestedObjects' ;
END

GO

print 'Completed dropViews.sql' ;
GO
