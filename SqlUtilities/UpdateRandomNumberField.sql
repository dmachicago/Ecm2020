DECLARE @counter smallint;
SET @counter = 1;
WHILE @counter < 15
   BEGIN
      --SELECT RAND() Random_Number
		SELECT ROUND(5*RAND(), 2)
	  
      SET @counter = @counter + 1
   END;
GO

select CAST(RAND(CHECKSUM(NEWID())) * 5 as INT) + 1 where AvgRating <= 1 

update Product set AvgRating = CAST(RAND(CHECKSUM(NEWID())) * 5 as INT) + 1 where AvgRating <= 1 

update Product set NbrReviews = CAST(RAND(CHECKSUM(NEWID())) * 15000 as INT) + 1 where AvgRating <= 1 

update Product set QtyAvail = CAST(RAND(CHECKSUM(NEWID())) * 15000 as INT) + 1 

select * from Product

alter table Product add UseInstruction nvarchar(2000) null ;
alter table Product add SupplementalFacts nvarchar(2000) null ;

update product 
set SupplementalFacts = 
'<h2 style="background-color: lightsteelblue">Supplemental Facts and Directions</h2>
                <p>Service Size: 10 mL</p>
                <p><strong>Ingredients:</strong> Silver @ 10ppm, deionized water.</p>
                <p><strong>Directions:</strong>  ADULTS: Take 2 teaspoons per day for no more than 10 days at a time. This product is not intended for continuous use. CHILDREN: Take one-half the adult usage. May be used topically. Best taken on an empty stomach.</p>
                <p><strong>Disclaimer: Do not use this product in the eyes. If you are pregnant, may become pregnant, or breastfeeding, consult your physician before using this product.</strong>  </p>'
where ProductID like 'NC-CS%'

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
