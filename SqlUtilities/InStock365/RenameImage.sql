
--select image_small, * from [InStock365].[dbo].[Product] where image_small like 'bottle%'
--BottleSingleBlue.jpg

declare @OldImgName nvarchar(100) = 'BottleSingleBlue.jpg';
declare @NewImgName nvarchar(100) = 'BottleSingleBlue.png';

update [InStock365].[dbo].[Product]
set image_small = @NewImgName
    , image_medium = @NewImgName
    , image_large = @NewImgName
where image_small = @OldImgName