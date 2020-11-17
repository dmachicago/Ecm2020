
if exists (select name from sys.tables where name = 'SeqTbl')
    drop table dbo.SeqTbl ;
go

create table dbo.SeqTbl (
    createdate datetime default getdate(),
    seqnbr int not null identity(1,1) constraint pk_SeqNbr primary key
 )
go
insert into SeqTbl (createdate) values (getdate())  ;
insert into SeqTbl (createdate) values (getdate())  ;
insert into SeqTbl (createdate) values (getdate())  ;
select * from SeqTbl;
go    
CREATE TRIGGER [dbo].[decrementSeq] ON  [dbo].SeqTbl FOR INSERT
AS 
BEGIN
    SET NOCOUNT ON
    delete from SeqTbl where seqnbr = (select min(seqnbr) from SeqTbl);
END
go

CREATE proc [dbo].[incrementSeq]  
as
begin
   insert into SeqTbl (createdate) values (getdate())  ;
end
GO

if exists (select name from sys.views where name = 'MyView')
    drop view dbo.MyView;
go

create view dbo.MyView
as
    select max(seqnbr) as seqnbr
    from dbo.SeqTbl;
go


exec incrementSeq ;
select * from dbo.MyView;
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
