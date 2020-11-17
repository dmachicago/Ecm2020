SELECT  
  REPLICATE(' ',4000) AS COLNAMES ,
  OBJECT_NAME(I.ID) AS TABLENAME,
  I.ID AS TABLEID,
  I.INDID AS INDEXID,
  I.NAME AS INDEXNAME,
  I.STATUS,
  INDEXPROPERTY (I.ID,I.NAME,'ISUNIQUE') AS ISUNIQUE,
  INDEXPROPERTY (I.ID,I.NAME,'ISCLUSTERED') AS ISCLUSTERED,
  INDEXPROPERTY (I.ID,I.NAME,'INDEXFILLFACTOR') AS INDEXFILLFACTOR
  INTO #TMP
  FROM SYSINDEXES I
  WHERE I.INDID > 0 
  AND I.INDID < 255 
  AND (I.STATUS & 64)=0
--uncomment below to eliminate PK or UNIQUE indexes;
--what i call 'normal' indexes
  --AND   INDEXPROPERTY (I.ID,I.NAME,'ISUNIQUE')       =0
  --AND   INDEXPROPERTY (I.ID,I.NAME,'ISCLUSTERED') =0
  and  OBJECT_NAME(I.ID) IN
  (
	'Analytics_ConversionCampaign',
	'CMS_Class',
	'CMS_Role',
	'CMS_TranslationSubmission',
	'CMS_Tree',
	'CMS_UserSettings',
	'CMS_WebFarmServerTask',
	'COM_SKU',
	'HFit_HealthAssesmentThresholds',
	'HFit_RewardsUserActivityDetail',
	'HFit_RewardsUserLevelDetail',
	'HFit_TrackerBloodPressure',
	'HFit_TrackerBloodSugarAndGlucose',
	'HFit_TrackerFlexibility',
	'OM_Contact',
	'temp_CMS_PageTemplate'
  )
  and (i.name like 'IX_Analytics_ConversionCampaign'
		OR i.name like 'IX_CMS_Class_ClassID_ClassName_ClassDisplayName'
		OR i.name like 'IX_CMS_Role_SiteID_RoleName_RoleDisplayName'
		OR i.name like 'IX_CMS_TranslationSubmission'
		OR i.name like 'IX_CMS_Tree_NodeID'
		OR i.name like 'pi_CMS_UserSettings_IDMPI'
		OR i.name like 'PK_CMS_WebFarmServerTask'
		OR i.name like 'IX_COM_SKU_SKUDepartmentID'
		OR i.name like 'idx_ThresholdTypeID'
		OR i.name like 'PI_HFit_RewardsUserActivityDetail_Date'
		OR i.name like 'PI_HFit_RewardsUserLevelDetail_Date'
		OR i.name like 'idx_HFit_TrackerBloodPressure_UserIDEventDate'
		OR i.name like 'IX_TrackerBloodSugar_UserID'
		OR i.name like 'idx_HFit_TrackerFlexibility_CreateDate'
		OR i.name like 'PK_OM_Contact'
		OR i.name like 'idxpagetemplatetemp'
	)
DECLARE
  @ISQL VARCHAR(4000),
  @TABLEID INT,
  @INDEXID INT,
  @MAXTABLELENGTH INT,
  @MAXINDEXLENGTH INT
  --USED FOR FORMATTING ONLY
    SELECT @MAXTABLELENGTH=MAX(LEN(TABLENAME)) FROM #TMP
    SELECT @MAXINDEXLENGTH=MAX(LEN(INDEXNAME)) FROM #TMP

    DECLARE C1 CURSOR FOR
      SELECT TABLEID,INDEXID FROM #TMP  
    OPEN C1
      FETCH NEXT FROM C1 INTO @TABLEID,@INDEXID
        WHILE @@FETCH_STATUS <> -1
          BEGIN
	SET @ISQL = ''
	SELECT @ISQL=@ISQL + ISNULL(SYSCOLUMNS.NAME,'') + ',' FROM SYSINDEXES I
	INNER JOIN SYSINDEXKEYS ON I.ID=SYSINDEXKEYS.ID AND I.INDID=SYSINDEXKEYS.INDID
	INNER JOIN SYSCOLUMNS ON SYSINDEXKEYS.ID=SYSCOLUMNS.ID AND SYSINDEXKEYS.COLID=SYSCOLUMNS.COLID
	WHERE I.INDID > 0 
	AND I.INDID < 255 
	AND (I.STATUS & 64)=0
	AND I.ID=@TABLEID AND I.INDID=@INDEXID
	ORDER BY SYSCOLUMNS.COLID
	UPDATE #TMP SET COLNAMES=@ISQL WHERE TABLEID=@TABLEID AND INDEXID=@INDEXID

	FETCH NEXT FROM C1 INTO @TABLEID,@INDEXID
         END
      CLOSE C1
      DEALLOCATE C1
  --AT THIS POINT, THE 'COLNAMES' COLUMN HAS A TRAILING COMMA
  UPDATE #TMP SET COLNAMES=LEFT(COLNAMES,LEN(COLNAMES) -1)

  SELECT  TABLENAME, INDEXNAME, 'CREATE ' 
    + CASE WHEN ISUNIQUE     = 1 THEN ' UNIQUE ' ELSE '        ' END 
    + CASE WHEN ISCLUSTERED = 1 THEN ' CLUSTERED ' ELSE '           ' END 
    + ' INDEX [' + UPPER(INDEXNAME) + ']' 
    + SPACE(@MAXINDEXLENGTH - LEN(INDEXNAME))
    +' ON [' + UPPER(TABLENAME) + '] '
    + SPACE(@MAXTABLELENGTH - LEN(TABLENAME)) 
    + '(' + UPPER(COLNAMES) + ')' 
    + CASE WHEN INDEXFILLFACTOR = 0 THEN ''  ELSE  ' WITH FILLFACTOR = ' + CONVERT(VARCHAR(10),INDEXFILLFACTOR)   END --AS SQL
    FROM #TMP
	

   --SELECT * FROM #TMP
   DROP TABLE #TMP
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
