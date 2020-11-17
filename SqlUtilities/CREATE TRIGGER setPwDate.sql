
update Member set PWUpdated = getdate() where PWUpdated is null 
update Member set UserEnabled = 1

update Member set pw = 'Welcome1!' where memberID = 'DH' ;
update member set PasswordHash = HASHBYTES ('SHA2_512', pw) where memberID = 'DH' ;
update member set HashCheck = HASHBYTES ('SHA2_512', pw + memberID) where memberID = 'DH' ;

Select * from k3 where kid > 181
Select * from FromTo
Select * from Member 
alter table Member add PWUpdated datetime default getdate() null
alter table Member add UserEnabled bit default 1 null

select *, HASHBYTES ('SHA_512',pw) from Member
 
UPDATE Member
SET HashCheck = EncryptByPassPhrase('This is the pass phrase' 
    , pw, 1, CONVERT( varbinary, pw))  
WHERE MemberID = 'ronin' ;

go
drop TRIGGER setPwDate 
go
 CREATE TRIGGER setPwDate ON Member
    AFTER INSERT
    AS
    BEGIN
      UPDATE Member
      SET PWUpdated = GETDATE()
      FROM inserted
      WHERE Member.MemberID = inserted.MemberID;
    END
   GO


-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
