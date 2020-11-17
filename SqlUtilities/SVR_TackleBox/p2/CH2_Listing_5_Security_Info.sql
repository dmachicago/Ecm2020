IF EXISTS ( SELECT  *
            FROM    tempdb.dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[tempdb].[dbo].[SQL_DB_REP]') ) 
    DROP TABLE [tempdb].[dbo].[SQL_DB_REP] ; 
GO

CREATE TABLE [tempdb].[dbo].[SQL_DB_REP]
    (
      [Server] [varchar](100) NOT NULL,
      [DB_Name] [varchar](70) NOT NULL,
      [User_Name] [nvarchar](90) NULL,
      [Group_Name] [varchar](100) NULL,
      [Account_Type] [varchar](22) NULL,
      [Login_Name] [varchar](80) NULL,
      [Def_DB] [varchar](100) NULL
    )
ON  [PRIMARY]

INSERT  INTO [tempdb].[dbo].[SQL_DB_REP]
        Exec sp_MSForEachDB 'SELECT  
        CONVERT(varchar(100), SERVERPROPERTY(''Servername'')) AS Server, 
		''?'' AS DB_Name,usu.name u_name,
			CASE	WHEN (usg.uid is null) THEN ''public''
					ELSE usg.name
				    END as Group_Name,
			CASE	WHEN usu.isntuser=1 THEN ''Windows Domain Account'' 
					WHEN usu.isntgroup = 1 THEN ''Windows Group'' 
					WHEN usu.issqluser = 1 THEN''SQL Account'' 
					WHEN usu.issqlrole = 1 THEN ''SQL Role'' 
					END as Account_Type,
			lo.loginname,
            lo.dbname AS Def_DB
FROM
      [?]..sysusers usu LEFT OUTER JOIN
      ([?]..sysmembers mem INNER JOIN
      [?]..sysusers usg ON mem.groupuid = usg.uid)
      ON usu.uid = mem.memberuid LEFT OUTER JOIN 
      DFINAnalytics.dbo.syslogins  lo ON usu.sid = lo.sid
WHERE
           ( usu.islogin = 1 AND 
				usu.isaliased = 0 AND 
				usu.hasdbaccess = 1) AND
          (usg.issqlrole = 1 OR 
			usg.uid is null)'


Select  *
from    [tempdb].[dbo].[SQL_DB_REP]