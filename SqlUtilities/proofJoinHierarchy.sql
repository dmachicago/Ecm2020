
DECLARE @TBL1 TABLE
(
  ProductID1 int, 
  Revenue1 money
)

DECLARE @TBL2 TABLE
(
  ProductID2 int, 
  Revenue2 money
)

insert into @TBL1 (ProductID1, Revenue1) values (100, 100);
insert into @TBL1 (ProductID1, Revenue1) values (200, 200);
insert into @TBL1 (ProductID1, Revenue1) values (300, 300);
insert into @TBL1 (ProductID1, Revenue1) values (400, 400);
insert into @TBL1 (ProductID1, Revenue1) values (500, 500);
insert into @TBL1 (ProductID1, Revenue1) values (600, 600);
insert into @TBL1 (ProductID1, Revenue1) values (700, 700)
insert into @TBL1 (ProductID1, Revenue1) values (800, 800);

insert into @TBL2 (ProductID2, Revenue2) values (100, 100);
insert into @TBL2 (ProductID2, Revenue2) values (200, 200);
insert into @TBL2 (ProductID2, Revenue2) values (300, 300);
insert into @TBL2 (ProductID2, Revenue2) values (400, 400);

--Build the structure
select * from @TBL1 as T1 join @TBL2 as T2 on T1.ProductID1 = T2.ProductID2 ;

--Invert the structure
select * from @TBL2 as T2 join @TBL1 as T1 on T2.ProductID2 = T1.ProductID1 ;


--Left join the structure
select * from @TBL1 as T1 left join @TBL2 as T2 on T1.ProductID1 = T2.ProductID2 ;
select * from @TBL2 as T2 right join @TBL1 as T1 on T2.ProductID2 = T1.ProductID1 ;

--Invert the left join structure
select * from @TBL2 as T2 left join @TBL1 as T1 on T2.ProductID2 = T1.ProductID1 ;
select * from @TBL2 as T2 right join @TBL1 as T1 on T2.ProductID2 = T1.ProductID1 ;

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
