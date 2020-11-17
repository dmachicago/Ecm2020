
select * from KenticoCMS_1.dbo.CMS_Tree

with CTE (NodeGuid, NodeID , DBNAME , SVR) as
(
    select NodeGuid, NodeID , 'KenticoCMS_1' as DBNAME , @@SERVERNAME
	   from KenticoCMS_1.dbo.CMS_Tree as T1
    union select NodeGuid, NodeID , 'KenticoCMS_2' as DBNAME, @@SERVERNAME
	   from KenticoCMS_2.dbo.CMS_Tree as T2
    union
    select NodeGuid, NodeID , 'KenticoCMS_3' as DBNAME , @@SERVERNAME
	   from KenticoCMS_3.dbo.CMS_Tree as T3
)
select count(*) as CNT,NodeGuid, DBNAME from CTE
group by DBNAME, NodeGuid
having count(*) > 1

select * from KenticoCMS_2.dbo.CMS_Tree
where NodeGuid = '3E3DA3E0-E2E9-4AAA-BB88-2D23CBD87151'
or NodeGuid = 'E5C5DE02-45EA-478D-82C4-4CB8CC8953EA'



--***********************************************************************

select UserGUID, Userid from KenticoCMS_1.dbo.CMS_User as T1
where UserGUID in (select UserGUID from KenticoCMS_2.dbo.CMS_User)
or UserGUID in (select UserGUID from KenticoCMS_3.dbo.CMS_User)

select * from KenticoCMS_1.dbo.CMS_User 
where UserGUID in 
(
'1FF0FA7B-FF8C-4783-8574-45F22FAA6D82'
,'2FFA1A7A-A1B7-438D-9E6F-4771E451CFFD'
,'164FB921-191C-408A-917A-76A60E3A3B21'
,'3758B9B5-045C-4B7D-B020-80F9B068D990'
,'6415B8CE-8072-4BCD-8E48-9D7178B826B7'
,'24C451B1-682E-4E39-B359-FB9BD3D18679'
)
union 
select * from KenticoCMS_2.dbo.CMS_User 
where UserGUID in 
(
'1FF0FA7B-FF8C-4783-8574-45F22FAA6D82'
,'2FFA1A7A-A1B7-438D-9E6F-4771E451CFFD'
,'164FB921-191C-408A-917A-76A60E3A3B21'
,'3758B9B5-045C-4B7D-B020-80F9B068D990'
,'6415B8CE-8072-4BCD-8E48-9D7178B826B7'
,'24C451B1-682E-4E39-B359-FB9BD3D18679'
)
union 
select * from KenticoCMS_3.dbo.CMS_User 
where UserGUID in 
(
'1FF0FA7B-FF8C-4783-8574-45F22FAA6D82'
,'2FFA1A7A-A1B7-438D-9E6F-4771E451CFFD'
,'164FB921-191C-408A-917A-76A60E3A3B21'
,'3758B9B5-045C-4B7D-B020-80F9B068D990'
,'6415B8CE-8072-4BCD-8E48-9D7178B826B7'
,'24C451B1-682E-4E39-B359-FB9BD3D18679'
)
order by UserGUID

