DECLARE @RowLogContents VARBINARY(8000)
SET @RowLogContents = 0x3000140001000000E10CF400EA9D00002A000000050000020028003700446F6E27742050616E6963536861726520616E6420456E6A6F79
DECLARE @lenFixedBytes SMALLINT, @noOfCols SMALLINT, @nullBitMapLength SMALLINT, @nullByteMap VARBINARY(MAX), @nullBitMap VARCHAR(MAX), @noVarCols SMALLINT, @columnOffsetArray VARBINARY(MAX), @varColPointer SMALLINT
SELECT
   @lenFixedBytes = CONVERT(SMALLINT, CONVERT(BINARY(2), REVERSE(SUBSTRING(@RowLogContents, 2 + 1, 2)))) , @noOfCols = CONVERT(INT, CONVERT(BINARY(2), REVERSE(SUBSTRING(@RowLogContents, @lenFixedBytes + 1, 2)))) , @nullBitMapLength = CONVERT(INT, ceiling(@noOfCols/8.0)) , @nullByteMap = SUBSTRING(@RowLogContents, @lenFixedBytes + 3, @nullBitMapLength) , @noVarCols =
   CASE
      WHEN SUBSTRING(@RowLogContents, 1, 1) = 0x30
         THEN CONVERT(INT, CONVERT(BINARY(2), REVERSE(SUBSTRING(@RowLogContents, @lenFixedBytes + 3 + @nullBitMapLength, 2))))
         ELSE null
   END , @columnOffsetArray =
   CASE
      WHEN SUBSTRING(@RowLogContents, 1, 1) = 0x30
         THEN SUBSTRING(@RowLogContents, @lenFixedBytes + 3 + @nullBitMapLength + 2, @noVarCols * 2)
         ELSE null
   END , @varColPointer =
   CASE
      WHEN SUBSTRING(@RowLogContents, 1, 1) = 0x30
         THEN (@lenFixedBytes + 2 + @nullBitMapLength + 2 + (@noVarCols * 2))
         ELSE null
   END
DECLARE @byteTable TABLE
   (
      byte INT
   )
   DECLARE @cnt INT
   SET @cnt = 1
   WHILE (@cnt < @nullBitMapLength + 1)
   BEGIN
      INSERT INTO @byteTable
         (byte
         )
         VALUES
         (@cnt
         )
         SET @cnt = @cnt +1
      END
      SELECT
         @nullBitMap = COALESCE(@nullBitMap, '') + CONVERT(NVARCHAR(1), (SUBSTRING(@nullByteMap, byte, 1) / 128) % 2) + CONVERT(NVARCHAR(1), (SUBSTRING(@nullByteMap, byte, 1) / 64) % 2) + CONVERT(NVARCHAR(1), (SUBSTRING(@nullByteMap, byte, 1) / 32) % 2) + CONVERT(NVARCHAR(1), (SUBSTRING(@nullByteMap, byte, 1) / 16) % 2) + CONVERT(NVARCHAR(1), (SUBSTRING(@nullByteMap, byte, 1) / 8) % 2) + CONVERT(NVARCHAR(1), (SUBSTRING(@nullByteMap, byte, 1) / 4) % 2) + CONVERT(NVARCHAR(1), (SUBSTRING(@nullByteMap, byte, 1) / 2) % 2) + CONVERT(NVARCHAR(1), SUBSTRING(@nullByteMap, byte, 1) % 2)
      FROM
         @byteTable b
      ORDER BY
         byte DESC
      SELECT
         SUBSTRING(@RowLogContents, 2 + 1, 2) AS lenFixedBytes , SUBSTRING(@RowLogContents, @lenFixedBytes + 1, 2) AS noOfCols , SUBSTRING(@RowLogContents, @lenFixedBytes + 3, @nullBitMapLength) AS nullByteMap , SUBSTRING(@RowLogContents, @lenFixedBytes + 3 + @nullBitMapLength, 2) AS noVarCols , SUBSTRING(@RowLogContents, @lenFixedBytes + 3 + @nullBitMapLength + 2, @noVarCols * 2) AS columnOffsetArray , @lenFixedBytes + 2 + @nullBitMapLength + 2 + (@noVarCols * 2) AS varColStart
      SELECT
         @lenFixedBytes AS lenFixedBytes , @noOfCols AS noOfCols , @nullBitMapLength AS nullBitMapLength , @nullByteMap AS nullByteMap , @nullBitMap AS nullBitMap , @noVarCols AS noVarCols , @columnOffsetArray AS columnOffsetArray , @varColPointer AS varColStart
      DECLARE @colOffsetTable TABLE
         (
            colNum SMALLINT, columnOffset VARBINARY(2), columnOffvalue SMALLINT, columnLength SMALLINT
         )
         SET @cnt = 1
         WHILE (@cnt <= @noVarCols)
         BEGIN
            INSERT INTO @colOffsetTable
               (colNum , columnOffset , columnOffValue , columnLength
               )
               VALUES
               ( @cnt * - 1 , SUBSTRING (@columnOffsetArray, (2 * @cnt) - 1, 2) , CONVERT(SMALLINT, CONVERT(BINARY(2), REVERSE (SUBSTRING (@columnOffsetArray, (2 * @cnt) - 1, 2)))) , CONVERT(SMALLINT, CONVERT(BINARY(2), REVERSE (SUBSTRING (@columnOffsetArray, (2 * @cnt) - 1, 2)))) - ISNULL(NULLIF(CONVERT(SMALLINT, CONVERT(BINARY(2), REVERSE (SUBSTRING (@columnOffsetArray, (2 * (@cnt - 1)) - 1, 2)))), 0), @varColPointer)
               )
               SET @cnt = @cnt + 1
            END
            --**********************************************************
            --       SELECT * FROM @colOffsetTable;
            --**********************************************************
            SELECT
               cols.leaf_null_bit AS nullbit , ISNULL(syscolumns.length, cols.max_length) AS [length] , CASE
                  WHEN is_uniqueifier = 1
                     THEN 'UNIQUIFIER'
                     ELSE ISNULL(syscolumns.name, 'DROPPED')
               END [name] , cols.system_type_id , cols.leaf_bit_position AS bitpos , ISNULL(syscolumns.xprec, cols.precision) AS xprec , ISNULL(syscolumns.xscale, cols.scale) AS xscale , cols.leaf_offset , is_uniqueifier
            FROM
               sys.allocation_units allocunits
               INNER JOIN
                  sys.partitions partitions
                  ON
                     (
                        allocunits.type IN (1 , 3)
                        AND partitions.hobt_id = allocunits.container_id
                     )
                     OR
                     (
                        allocunits.type             = 2
                        AND partitions.partition_id =allocunits.container_id
                     )
               INNER JOIN
                  sys.system_internals_partition_columns cols
                  ON
                     cols.partition_id = partitions.partition_id
               LEFT OUTER JOIN
                  syscolumns
                  ON
                     syscolumns.id        = partitions.object_id
                     AND syscolumns.colid = cols.partition_column_id
            WHERE
               allocunits.allocation_unit_id = 72057594039697408
            ORDER BY
               nullbit
            --**********************************************************
            DECLARE @schema TABLE
               (
                  [column] INT, [length] INT, [name] NVARCHAR(255), [system_type_id] INT, [bitpos] INT, [xprec] INT, [xscale] INT, [leaf_offset] INT, [is_uniqueifier] BIT, [is_null] BIT NULL
               )
            INSERT INTO @schema
            SELECT
               cols.leaf_null_bit AS nullbit , ISNULL(syscolumns.length, cols.max_length) AS [length] , CASE
                  WHEN is_uniqueifier = 1
                     THEN 'UNIQUIFIER'
                     ELSE isnull(syscolumns.name, 'DROPPED')
               END [name] , cols.system_type_id , cols.leaf_bit_position AS bitpos , ISNULL(syscolumns.xprec, cols.precision) AS xprec , ISNULL(syscolumns.xscale, cols.scale) AS xscale , cols.leaf_offset , is_uniqueifier , SUBSTRING(REVERSE(@nullBitMap), cols.leaf_null_bit, 1) AS is_null
            FROM
               sys.allocation_units allocunits
               INNER JOIN
                  sys.partitions partitions
                  ON
                     (
                        allocunits.type IN (1 , 3)
                        AND partitions.hobt_id = allocunits.container_id
                     )
                     OR
                     (
                        allocunits.type             = 2
                        AND partitions.partition_id = allocunits.container_id
                     )
               INNER JOIN
                  sys.system_internals_partition_columns cols
                  ON
                     cols.partition_id = partitions.partition_id
               LEFT OUTER JOIN
                  syscolumns
                  ON
                     syscolumns.id        = partitions.object_id
                     AND syscolumns.colid = cols.partition_column_id
            WHERE
               allocunits.allocation_unit_id = 72057594039697408
            ORDER BY
               nullbit
            INSERT INTO @schema
            SELECT
               -3 , 1 , 'StatusBitsA' , 0 , 0 , 0 , 0 , 2147483647 , 0 , 0
            INSERT INTO @schema
            SELECT
               -2 , 1 , 'StatusBitsB' , 0 , 0 , 0 , 0 , 2147483647 , 0 , 0
            INSERT INTO @schema
            SELECT
               -1 , 2 , 'LenFixedBytes' , 52 , 0 , 10 , 0 , 2147483647 , 0 , 0
            SELECT
               s.* , CASE
                  WHEN s.leaf_offset > 1
                     AND s.bitpos    = 0
                     THEN SUBSTRING ( @RowLogContents, ISNULL(
                                                               (
                                                                  SELECT
                                                                     TOP 1 SUM(x.length)
                                                                  FROM
                                                                     @schema x
                                                                  WHERE
                                                                     x.[column]        < s.[column]
                                                                     AND x.leaf_offset > 1
                                                                     AND x.bitpos      = 0
                                                              )
                                                              , 0) + 1, s.length )
                     ELSE SUBSTRING ( @RowLogContents, (col.columnOffValue - col.columnLength) + 1, col.columnLength )
               END AS hex_string
            FROM
               @schema s
               LEFT OUTER JOIN
                  @colOffsetTable col
                  ON
                     col.colNum = (s.leaf_offset) 	