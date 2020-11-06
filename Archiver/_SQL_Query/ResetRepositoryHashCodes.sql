

-- Run this please
-- comment out the where Rowguid and
-- uncomment the where Imagehash is null
update DataSource set Imagehash = (convert(char(128), HASHBYTES('sha2_512', SourceImage), 1) )
where Imagehash is null or ltrim(rtrim(ImageHash)) = ''

update DataSource set FqnHASH = (convert(char(128), HASHBYTES('sha2_512', FQN), 1) )
where FqnHASH is null or ltrim(rtrim(FqnHASH)) = ''

update DataSource set HashFile = (convert(char(128), HASHBYTES('sha2_512', SourceName), 1) )
where HashFile is null or ltrim(rtrim(HashFile)) = ''
