create table #LeftTBL
(
xcode nvarchar(50) null,
xamt float null
)

create table #RightTBL
(
xcode nvarchar(50) null,
xamt float null
)

create table #CenterTBL
(
xcode nvarchar(50) null,
xamt float null
)

insert into #LeftTBL (xcode,xamt) values ('A',1) ;
insert into #LeftTBL (xcode,xamt) values  ('B',1) ;
insert into #LeftTBL (xcode,xamt) values   ('C',1) ;
insert into #LeftTBL (xcode,xamt) values  ('D',1) ;
insert into #LeftTBL (xcode,xamt) values  ('X',1) ;
insert into #LeftTBL (xcode,xamt) values  ('Y',1) ;
insert into #LeftTBL (xcode,xamt) values  ('Z',1) ;
insert into #LeftTBL (xcode,xamt) values  ('AA',1) ;

insert into #RightTBL (xcode,xamt) values ('A',1) ;
--insert into #RightTBL (xcode,xamt) values  ('B',1) ;
insert into #RightTBL (xcode,xamt) values   ('C',1) ;
--insert into #RightTBL (xcode,xamt) values  ('D',1) ;

insert into #CenterTBL (xcode,xamt) values ('Center1',1) ;
insert into #CenterTBL (xcode,xamt) values  ('A',1) ;
insert into #CenterTBL (xcode,xamt) values   ('Center2',1) ;
--insert into #RightTBL (xcode,xamt) values  ('D',1) ;

insert into #RightTBL (xcode,xamt) values  ('e',1) ;
insert into #RightTBL (xcode,xamt) values  ('f',1) ;
insert into #RightTBL (xcode,xamt) values  ('g',1) ;
insert into #RightTBL (xcode,xamt) values  ('1',1) ;

--insert into #RightTBL (xcode,xamt) values  ('X',1) ;
--insert into #RightTBL (xcode,xamt) values  ('Y',1) ;
--insert into #RightTBL (xcode,xamt) values  ('Z',1) ;


SELECT        LTBL.xcode as LCODE, RTBL.xcode AS RCODE
FROM            [#LeftTBL] AS LTBL LEFT OUTER JOIN
                         [#RightTBL] AS RTBL ON LTBL.xcode = RTBL.xcode


--Select ALL from the right that do not exist in the left
select LTBL.xcode , RTBL.xcode  
from #RightTBL as RTBL
    left join #LeftTBL as LTBL
	   on LTBL.xcode = RTBL.xcode
where LTBL.xcode is null

--Select ALL from the right that do not exist in the left
SELECT        LTBL.xcode as LCODE, RTBL.xcode AS RCODE
FROM            [#RightTBL] AS RTBL RIGHT OUTER JOIN
                         [#LeftTBL] AS LTBL ON LTBL.xcode = RTBL.xcode
where RTBL.xcode is not null



--Select ALL from the right that do not exist in the left
SELECT        LTBL.xcode AS LXCODE, RTBL.xcode AS RXCODE
FROM            [#leftTBL] AS LTBL RIGHT OUTER JOIN
                         [#RightTBL] AS RTBL ON LTBL.xcode = RTBL.xcode
where LTBL.xcode is null
--LXCODE	RXCODE
--A	A
--C	C
--NULL	e
--NULL	f
--NULL	g
--NULL	1

--Select ALL from the right that do not exist in the left
SELECT        LTBL.xcode as LXCODE, RTBL.xcode AS RXCODE
FROM            [#LeftTBL] AS LTBL FULL OUTER JOIN
                         [#RightTBL] AS RTBL ON LTBL.xcode = RTBL.xcode
where RTBL.xcode is not null


--Select ALL from the right that do not exist in the left
Update [#RightTBL]
set xamt = 9001
FROM [#LeftTBL] AS LTBL FULL OUTER JOIN
                         [#RightTBL] AS RTBL ON LTBL.xcode = RTBL.xcode
where LTBL.xcode is null

select * from [#RightTBL]