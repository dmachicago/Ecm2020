
WITH mycte
	AS (SELECT vcu.view_name
			 , vcu.table_name
			 , vcu.column_name
			   FROM
					information_schema.view_column_usage AS vcu
						JOIN information_schema.columns AS col
							ON col.table_schema = vcu.table_schema
						   AND col.table_catalog = vcu.table_catalog
						   AND col.table_name = vcu.table_name
						   AND col.column_name = vcu.column_name
			   WHERE vcu.view_name = 'view_EDW_HealthAssesment'
		UNION ALL
		SELECT vcu2.view_name
			 , vcu2.table_name
			 , vcu2.column_name
			   FROM
					information_schema.view_column_usage AS vcu2
						JOIN information_schema.columns AS col
							ON col.table_schema = vcu2.table_schema
						   AND col.table_catalog = vcu2.table_catalog
						   AND col.table_name = vcu2.table_name
						   AND col.column_name = vcu2.column_name
						INNER JOIN mycte
							ON vcu2.view_name = mycte.table_name
						   AND mycte.column_name = vcu2.column_name

	--WHERE VCU2.COLUMN_NAME in (select column_name from mycte where mycte.TABLE_NAME = VCU2.TABLE_NAME )

	) 
	SELECT *
		   FROM mycte
			where Table_Name in (select table_name from information_schema.tables where type = 'TABLE');

SELECT *
	   FROM
			information_schema.view_column_usage AS vcu
				JOIN information_schema.columns AS col
					ON col.table_schema = vcu.table_schema
				   AND col.table_catalog = vcu.table_catalog
				   AND col.table_name = vcu.table_name
				   AND col.column_name = vcu.column_name
	   WHERE vcu.view_name = 'view_EDW_SmallStepResponses';
SELECT *
	   FROM
			information_schema.view_column_usage AS vcu
				JOIN information_schema.columns AS col
					ON col.table_schema = vcu.table_schema
				   AND col.table_catalog = vcu.table_catalog
				   AND col.table_name = vcu.table_name
				   AND col.column_name = vcu.column_name
	   WHERE vcu.view_name = 'View_HFit_OutComeMessages_Joined'
		 AND vcu.column_name IN ('NodeGUID', 'DocumentCulture', 'Message') ;
SELECT *
	   FROM
			information_schema.view_column_usage AS vcu
				JOIN information_schema.columns AS col
					ON col.table_schema = vcu.table_schema
				   AND col.table_catalog = vcu.table_catalog
				   AND col.table_name = vcu.table_name
				   AND col.column_name = vcu.column_name
	   WHERE vcu.view_name = 'View_HFit_HACampaign_Joined'
		 AND vcu.column_name IN ('NodeGUID', 'DocumentCulture', 'Name', 'CampaignStartDate', 'CampaignEndDate') ;
SELECT *
	   FROM
			information_schema.view_column_usage AS vcu
				JOIN information_schema.columns AS col
					ON col.table_schema = vcu.table_schema
				   AND col.table_catalog = vcu.table_catalog
				   AND col.table_name = vcu.table_name
				   AND col.column_name = vcu.column_name
	   WHERE vcu.view_name = 'View_CMS_Tree_Joined'
		 AND vcu.column_name IN ('NodeGUID', 'DocumentCulture') ;
SELECT *
	   FROM
			information_schema.view_column_usage AS vcu
				JOIN information_schema.columns AS col
					ON col.table_schema = vcu.table_schema
				   AND col.table_catalog = vcu.table_catalog
				   AND col.table_name = vcu.table_name
				   AND col.column_name = vcu.column_name
	   WHERE vcu.view_name = 'View_CMS_Tree_Joined_Regular'
		 AND vcu.column_name IN ('NodeGUID', 'DocumentCulture') ;
SELECT *
	   FROM
			information_schema.view_column_usage AS vcu
				JOIN information_schema.columns AS col
					ON col.table_schema = vcu.table_schema
				   AND col.table_catalog = vcu.table_catalog
				   AND col.table_name = vcu.table_name
				   AND col.column_name = vcu.column_name
	   WHERE vcu.view_name = 'View_CMS_Tree_Joined_Linked'
		 AND vcu.column_name IN ('NodeGUID', 'DocumentCulture') ;