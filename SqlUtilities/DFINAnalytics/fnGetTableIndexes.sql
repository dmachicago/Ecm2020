/*
--* USEKenticoCMS_Datamart
go
select * from dbo.fnGetTableIndexes('BASE_CMS_User');

select * into #TempIndexes from dbo.fnGetTableIndexes('BASE_CMS_User') ;

*/
--* USEDFINAnalytics;
go

CREATE FUNCTION dbo.UTIL_GetTableIndexes (
  @TblName nvarchar (100
 )
RETURNS @TblOfIndexs TABLE (index_name varchar (150) NOT NULL
   , index_description varchar (210) NULL
   , index_keys varchar (2126) NOT NULL
   , origfillfactor int
   , create_statement varchar (3000) 
   , drop_statement varchar (1000)
    ) 
AS
BEGIN

    --  Author:	 W. Dale Miller
    --  Date:		 5.22.2005
    --  Copyright:	 DMA Limited, 2005
    --  Purpose	 Return the DDL for indexes on a given table into a temp table

    DECLARE
    @objid int
  , -- the object id of the table

    @indid smallint
  , -- the index id of an index

    @groupid smallint
  , -- the filegroup id of an index

    @indname sysname
  , @groupname sysname
  , @status int
  , @keys nvarchar (2126
     ) 
  , --Length (16*max_identifierLength)+(15*2)+(16*3)

    @dbname sysname
  , @OrigFillFactor int;
    DECLARE
    @inddata TABLE (index_name sysname NOT NULL
    , stats int
    , groupname sysname NOT NULL
    , index_keys nvarchar (2126
  ) NOT NULL
    , -- see @keys above for length descr

 OrigFillFactor int

    -- Original fillfactor value used when the index was created.

     );

    -- Check to see that the object names are local to the current database.

    SELECT @dbname = PARSENAME (@TblName, 3
     ) ;

    -- Check to see the the table exists and initialize @objid.

    SELECT @objid = OBJECT_ID (@TblName
    ) ;
    IF @objid IS NULL
 BEGIN
     RETURN;
 END;

    -- OPEN CURSOR OVER INDEXES (skip stats: bug shiloh_51196)

    DECLARE ms_crs_ind CURSOR LOCAL STATIC
 FOR SELECT indid
   , groupid
   , name
   , status
   , OrigFillFactor
     FROM sysindexes
     WHERE id = @objid
  AND indid > 0
  AND indid < 255
  AND status&64 = 0
     ORDER BY indid;
    OPEN ms_crs_ind;
    FETCH ms_crs_ind INTO @indid, @groupid, @indname, @status, @OrigFillFactor;

    -- IF NO INDEX, QUIT

    IF @@fetch_status < 0
 BEGIN
     RETURN;
 END;

    -- Now check out each index, figure out its type and keys and
    -- save the info in a temporary table that we'll print out at the end.

    WHILE @@fetch_status >= 0
 BEGIN

     -- First we'll figure out what the keys are.

     DECLARE
     @i int
   , @thiskey nvarchar (131
    ) ;

     -- 128+3

     SELECT @keys = INDEX_COL (@TblName, @indid, 1
    ) 
   , @i = 2;
     IF INDEXKEY_PROPERTY (@objid, @indid, 1, 'isdescending'
     ) = 1
  BEGIN
 SELECT @keys = @keys + '(-)';
  END;
     SELECT @thiskey = INDEX_COL (@TblName, @indid, @i
     ) ;
     IF @thiskey IS NOT NULL
    AND INDEXKEY_PROPERTY (@objid, @indid, @i, 'isdescending'
     ) = 1
  BEGIN
 SELECT @thiskey = @thiskey + '(-)';
  END;
     WHILE @thiskey IS NOT NULL
  BEGIN
 SELECT @keys = @keys
     + ', '
     + @thiskey
    , @i = @i + 1;
 SELECT @thiskey = INDEX_COL (@TblName, @indid, @i
 ) ;
 IF @thiskey IS NOT NULL
     AND INDEXKEY_PROPERTY (@objid, @indid, @i, 'isdescending'
 ) = 1
   BEGIN
  SELECT @thiskey = @thiskey + '(-)';
   END;
  END;
     SELECT @groupname = groupname
     FROM sysfilegroups
     WHERE groupid = @groupid;

     -- INSERT ROW FOR INDEX

     INSERT INTO @inddata
     VALUES
     (@indname, @status, @groupname, @keys, @OrigFillFactor
     ) ;

     -- Next index

     FETCH ms_crs_ind INTO @indid, @groupid, @indname, @status, @OrigFillFactor;
 END;
    DEALLOCATE ms_crs_ind;

    -- SET UP SOME CONSTANT VALUES FOR OUTPUT QUERY

    DECLARE
    @empty varchar (1
     ) ;
    SELECT @empty = '';
    DECLARE
    @des1 varchar (35
    ) 
  , -- 35 matches spt_values

    @des2 varchar (35
    ) 
  , @des4 varchar (35
    ) 
  , @des32 varchar (35
     ) 
  , @des64 varchar (35
     ) 
  , @des2048 varchar (35
  ) 
  , @des4096 varchar (35
  ) 
  , @des8388608 varchar (35
     ) 
  , @des16777216 varchar (35
    ) ;
    SELECT @des1 = name
    FROM dbo.spt_values
    WHERE type = 'I'
 AND number = 1;

    -- ignore duplicate keys

    SELECT @des2 = name
    FROM dbo.spt_values
    WHERE type = 'I'
 AND number = 2;

    -- unique

    SELECT @des4 = name
    FROM dbo.spt_values
    WHERE type = 'I'
 AND number = 4;

    -- ignore duplicate rows

    SELECT @des32 = name
    FROM dbo.spt_values
    WHERE type = 'I'
 AND number = 32;

    -- clustered

    SELECT @des64 = name
    FROM dbo.spt_values
    WHERE type = 'I'
 AND number = 64;
    SELECT @des2048 = name
    FROM dbo.spt_values
    WHERE type = 'I'
 AND number = 2048;
    SELECT @des4096 = name
    FROM dbo.spt_values
    WHERE type = 'I'
 AND number = 4096;
    SELECT @des8388608 = name
    FROM dbo.spt_values
    WHERE type = 'I'
 AND number = 8388608;
    SELECT @des16777216 = name
    FROM dbo.spt_values
    WHERE type = 'I'
 AND number = 16777216;

    -- DISPLAY THE RESULTS

    INSERT INTO @TblOfIndexs (index_name
   , index_description
   , index_keys
   , origfillfactor
   , create_statement
   , drop_statement
    ) 
    SELECT [@inddata].index_name
  , CONVERT (varchar (210
  ) ,

    --bits 16 off, 1, 2, 16777216 on, located on group

    CASE
    WHEN [@inddata].stats&16 <> 0 THEN 'clustered'
    ELSE 'nonclustered'
    END
  + CASE
    WHEN [@inddata].stats&1 <> 0 THEN ', ' + @des1
    ELSE @empty
    END
  + CASE
    WHEN [@inddata].stats&2 <> 0 THEN ', ' + @des2
    ELSE @empty
    END
  + CASE
    WHEN [@inddata].stats&4 <> 0 THEN ', ' + @des4
    ELSE @empty
    END
  + CASE
    WHEN [@inddata].stats&64 <> 0 THEN ', ' + @des64
    ELSE CASE
  WHEN [@inddata].stats&32 <> 0 THEN ', ' + @des32
  ELSE @empty
  END
    END
  + CASE
    WHEN [@inddata].stats&2048 <> 0 THEN ', ' + @des2048
    ELSE @empty
    END
  + CASE
    WHEN [@inddata].stats&4096 <> 0 THEN ', ' + @des4096
    ELSE @empty
    END
  + CASE
    WHEN [@inddata].stats&8388608 <> 0 THEN ', '
  + @des8388608
    ELSE @empty
    END
  + CASE
    WHEN [@inddata].stats&16777216 <> 0 THEN ', '
   + @des16777216
    ELSE @empty
    END
  + ' located on '
  + [@inddata].groupname
     ) 
  , [@inddata].index_keys
  , [@inddata].OrigFillFactor
  , CASE
    WHEN [@inddata].stats&2048 <> 0 THEN 'ALTER '
      + CASE
 WHEN OBJECTPROPERTY (OBJECT_ID (@TblName
      ) , 'IsView'
  ) = 1 THEN 'VIEW '
 ELSE 'TABLE '
 END
      + @TblName
      + CHAR (10
      )
      + 'ADD CONSTRAINT '
      + [@inddata].index_name
      + CHAR (10
      )
      + 'PRIMARY KEY '
      + CASE
 WHEN [@inddata].stats&16 <> 0 THEN 'CLUSTERED'
 ELSE 'NONCLUSTERED'
 END
      + CHAR (10
      )
      + '('
      + [@inddata].index_keys
      + ')'
      + CHAR (10
      )
      + 'ON ['
      + [@inddata].groupname
      + ']'
      + CHAR (10
      )
    ELSE 'CREATE '
  + CASE
  WHEN [@inddata].stats&4096 <> 0 THEN 'UNIQUE '
  ELSE @empty
  END
  + CASE
  WHEN [@inddata].stats&16 <> 0 THEN 'CLUSTERED '
  ELSE 'NONCLUSTERED '
  END
  + 'INDEX '
  + [@inddata].index_name
  + CHAR (10
  )
  + 'ON '
  + @TblName
  + ' ('
  + [@inddata].index_keys
  + ')'
  + CHAR (10
  )
  + CASE
  WHEN [@inddata].OrigFillFactor <> 0
    OR [@inddata].stats&1 <> 0
    OR [@inddata].stats&8388608 <> 0
    OR [@inddata].stats&16777216 <> 0 THEN 'WITH '
   + CASE
   WHEN [@inddata].OrigFillFactor <> 0 THEN 'PAD_INDEX FILLFACTOR = '
  + CONVERT (varchar, [@inddata].OrigFillFactor
     )
   ELSE @empty
   END
   + CASE
   WHEN [@inddata].stats&1 <> 0 THEN ', IGNORE_DUP_KEY '
   ELSE @empty
   END
   + CASE
   WHEN [@inddata].stats&8388608 <> 0 THEN ', DROP_EXISTING '
   ELSE @empty
   END
   + CASE
   WHEN [@inddata].stats&16777216 <> 0 THEN ', STATISTICS_NORECOMPUTE '
   ELSE @empty
   END
   + CHAR (10
   )
  ELSE @empty
  END
  + 'ON ['
  + [@inddata].groupname
  + ']'
  + CHAR (10
  )
    END
  , CASE
    WHEN [@inddata].stats&2048 <> 0 THEN 'ALTER '
      + CASE
 WHEN OBJECTPROPERTY (OBJECT_ID (@TblName
      ) , 'IsView'
  ) = 1 THEN 'VIEW '
 ELSE 'TABLE '
 END
      + @TblName
      + CHAR (10
      )
      + 'DROP CONSTRAINT '
      + [@inddata].index_name
      + CHAR (10
      )
    ELSE 'DROP INDEX '
  + @TblName
  + '.'
  + [@inddata].index_name
    END
    FROM @inddata
    ORDER BY [@inddata].index_name;
    RETURN;
END;
GO
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
