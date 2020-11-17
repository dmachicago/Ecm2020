USE [InStock365]
GO
/****** Script for SelectTopNRows command from SSMS  ******/
delete from [Classification]
SELECT TOP 1000 [category_id]
      ,[parent_id]
      ,[category]
  FROM [InStock365].[dbo].[categories]
where category_id = '1' or parent_id = '1' or category_id = '1000' or parent_id = '1000' 



INSERT INTO [dbo].[Classification] ([ClassCode],[ClassID],[ParentClassID]) VALUES ('Natural Supplements','1',null)
INSERT INTO [dbo].[Classification] ([ClassCode],[ClassID],[ParentClassID]) VALUES ('Collodial Silver Health Products','2',null)
INSERT INTO [dbo].[Classification] ([ClassCode],[ClassID],[ParentClassID]) VALUES ('Natural Beauty Care Products','3',null)

INSERT INTO [dbo].[Classification] ([ClassCode],[ClassID],[ParentClassID]) VALUES ('Mega Protein','1000','1')
INSERT INTO [dbo].[Classification] ([ClassCode],[ClassID],[ParentClassID]) VALUES ('Vitamin Water','1001','1')

INSERT INTO [dbo].[Classification] ([ClassCode],[ClassID],[ParentClassID]) VALUES ('Salve','2000','2')
INSERT INTO [dbo].[Classification] ([ClassCode],[ClassID],[ParentClassID]) VALUES ('Liquid','2001','2')
INSERT INTO [dbo].[Classification] ([ClassCode],[ClassID],[ParentClassID]) VALUES ('Cream','2002','2')
INSERT INTO [dbo].[Classification] ([ClassCode],[ClassID],[ParentClassID]) VALUES ('Silver Hand Sanitizer (Spray)','2003','2')

INSERT INTO [dbo].[Classification] ([ClassCode],[ClassID],[ParentClassID]) VALUES ('Vitamin C Skin Care','3000','3')
INSERT INTO [dbo].[Classification] ([ClassCode],[ClassID],[ParentClassID]) VALUES ('Volcanic Pumice Exfoliant','3001','3')



insert into [dbo].[categories] (category_id, parent_id, category) values ('1', null, 'Natural Supplements');
insert into [dbo].[categories] (category_id, parent_id, category) values ('2', null, 'Collodial Silver Health Products');
insert into [dbo].[categories] (category_id, parent_id, category) values ('3', null, 'Natural Beauty Care Products');

insert into [dbo].[categories] (category_id, parent_id, category) values ('3000', '3', 'Salve')
insert into [dbo].[categories] (category_id, parent_id, category) values ('3001', '3', 'Liquid')
insert into [dbo].[categories] (category_id, parent_id, category) values ('3002', '3', 'Cream')
insert into [dbo].[categories] (category_id, parent_id, category) values ('3003', '3', 'Generator')

insert into [dbo].[categories] (category_id, parent_id, category) values ('1000', '1', 'Mega Protein')
insert into [dbo].[categories] (category_id, parent_id, category) values ('10000', '1000', '16oz. Mega Protein Powder')
insert into [dbo].[categories] (category_id, parent_id, category) values ('10001', '1000', '2lbs Mega Protein Powder')
insert into [dbo].[categories] (category_id, parent_id, category) values ('10002', '1000', '5lbs Mega Protein Powder')
insert into [dbo].[categories] (category_id, parent_id, category) values ('10003', '1000', '10lbs Mega Protein Powder')
insert into [dbo].[categories] (category_id, parent_id, category) values ('10004', '1000', '20lbs Mega Protein Powder')

insert into [dbo].[categories] (category_id, parent_id, category) values ('1010', '3', 'Vitamin C Skin Care')
insert into [dbo].[categories] (category_id, parent_id, category) values ('20000', '1010', '1oz. Vitamin C Skin Care')
insert into [dbo].[categories] (category_id, parent_id, category) values ('20001', '1010', '2oz. Vitamin C Skin Care')
insert into [dbo].[categories] (category_id, parent_id, category) values ('20002', '1010', '4oz. Vitamin C Skin Care')


Select [ClassCode], [ParentClassID], [ClassID], [RowNbr],  [level]  
 From [vCategories]

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
