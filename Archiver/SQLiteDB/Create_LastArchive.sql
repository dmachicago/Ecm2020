drop table if exists LastArchive ;

CREATE TABLE LastArchive (
    ID INTEGER PRIMARY KEY AUTOINCREMENT,
    UserID nvarchar(50) ,
    LastArchiveDate       DATETIME DEFAULT (datetime('now','localtime')) ,
    ArchiveStatus NVARCHAR (1) DEFAULT ('A'),
    StartTime DATETIME DEFAULT (datetime('now','localtime')),
    EndTime DATETIME
);

create index PI_LastArchiveDte on LastArchive (UserID, LastArchiveDate, ArchiveStatus);

select * from LastArchive ;

insert into LastArchive (UseriD) values ('wmiller');

select LastArchiveDate from LastArchive where ID in (
select max(ID) from LastArchive where UserID = 'wmiller' and ArchiveStatus = 'C' )  ;

delete from LastArchive where LastArchiveDate not in (
select max(ID) from LastArchive where UserID = 'wmiller' )  ;

update LastArchive set ArchiveStatus = 'C', EndTime = datetime('now','localtime') where ID in (
select max(ID) from LastArchive where UserID = 'wmiller' )  ;