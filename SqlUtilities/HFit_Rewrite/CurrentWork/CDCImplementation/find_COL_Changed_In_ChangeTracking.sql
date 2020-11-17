
--select top  100 * from [HFit_HealthAssesmentUserQuestion]

--update [HFit_HealthAssesmentUserQuestion] set ItemModifiedWhen = getdate() where Itemid = 15047
--update [HFit_HealthAssesmentUserQuestion] set ItemModifiedWhen = null where Itemid = 15048

SELECT 'HFit_HealthAssesmentUserQuestion' as TBL
      , SRC.ItemID
     , CT.SYS_CHANGE_VERSION
     , CT.SYS_CHANGE_OPERATION
     --, CT.SYS_CHANGE_COLUMNS
     , CASE
           WHEN CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('HFit_HealthAssesmentUserQuestion') , 'CODENAME', 'ColumnId') , SYS_CHANGE_COLUMNS) > 0
               THEN 1
           WHEN CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('HFit_HealthAssesmentUserQuestion') , 'HAQUESTIONNODEGUID', 'ColumnId') , SYS_CHANGE_COLUMNS) > 0
               THEN 1
           WHEN CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('HFit_HealthAssesmentUserQuestion') , 'HAQUESTIONSCORE', 'ColumnId') , SYS_CHANGE_COLUMNS) > 0
               THEN 1
           WHEN CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('HFit_HealthAssesmentUserQuestion') , 'ISPROFESSIONALLYCOLLECTED', 'ColumnId') , SYS_CHANGE_COLUMNS) > 0
               THEN 1
           WHEN CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('HFit_HealthAssesmentUserQuestion') , 'ITEMMODIFIEDWHEN', 'ColumnId') , SYS_CHANGE_COLUMNS) > 0
               THEN 1
           WHEN CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('HFit_HealthAssesmentUserQuestion') , 'PREWEIGHTEDSCORE', 'ColumnId') , SYS_CHANGE_COLUMNS) > 0
               THEN 1
           ELSE 0
       END AS TgtDataChanged
     --, CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('HFit_HealthAssesmentUserQuestion') , 'CODENAME', 'ColumnId') , SYS_CHANGE_COLUMNS) AS CODENAME_FLG
     --, CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('HFit_HealthAssesmentUserQuestion') , 'HAQUESTIONNODEGUID', 'ColumnId') , SYS_CHANGE_COLUMNS) AS HAQUESTIONNODEGUID_FLG
     --, CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('HFit_HealthAssesmentUserQuestion') , 'HAQUESTIONSCORE', 'ColumnId') , SYS_CHANGE_COLUMNS) AS HAQUESTIONSCORE_FLG
     --, CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('HFit_HealthAssesmentUserQuestion') , 'ISPROFESSIONALLYCOLLECTED', 'ColumnId') , SYS_CHANGE_COLUMNS) AS ISPROFESSIONALLYCOLLECTED_FLG
     --, CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('HFit_HealthAssesmentUserQuestion') , 'ITEMMODIFIEDWHEN', 'ColumnId') , SYS_CHANGE_COLUMNS) AS ITEMMODIFIEDWHEN_FLG
     --, CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('HFit_HealthAssesmentUserQuestion') , 'PREWEIGHTEDSCORE', 'ColumnId') , SYS_CHANGE_COLUMNS) AS PREWEIGHTEDSCORE_FLG
       FROM
           HFit_HealthAssesmentUserQuestion AS SRC
               RIGHT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentUserQuestion, NULL) AS CT
                   ON SRC.ItemID = CT.ItemID ;


SELECT 
count(*) AS ChangedCNT
       FROM
           HFit_HealthAssesmentUserQuestion AS SRC
               RIGHT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentUserQuestion, NULL) AS CT
                   ON SRC.ItemID = CT.ItemID
    where 
     CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('HFit_HealthAssesmentUserQuestion') , 'CODENAME', 'ColumnId') , SYS_CHANGE_COLUMNS) > 0
     OR  CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('HFit_HealthAssesmentUserQuestion') , 'HAQUESTIONNODEGUID', 'ColumnId') , SYS_CHANGE_COLUMNS) > 0
     OR  CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('HFit_HealthAssesmentUserQuestion') , 'HAQUESTIONSCORE', 'ColumnId') , SYS_CHANGE_COLUMNS) > 0
     OR  CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('HFit_HealthAssesmentUserQuestion') , 'ISPROFESSIONALLYCOLLECTED', 'ColumnId') , SYS_CHANGE_COLUMNS) > 0
     OR  CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('HFit_HealthAssesmentUserQuestion') , 'ITEMMODIFIEDWHEN', 'ColumnId') , SYS_CHANGE_COLUMNS) > 0
     OR  CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('HFit_HealthAssesmentUserQuestion') , 'PREWEIGHTEDSCORE', 'ColumnId') , SYS_CHANGE_COLUMNS)  > 0
