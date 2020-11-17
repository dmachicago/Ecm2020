WITH GroupsContainingUser (GroupName) AS
(
   select GroupName from GroupUsers G1 where userid = 'SAdmin' 
)
SELECT [GroupName]
  FROM [UserGroup]
where GroupOwnerUserID = 'SAdmin'
or GroupName in (select GroupName from GroupsContainingUser)
order by GroupName

