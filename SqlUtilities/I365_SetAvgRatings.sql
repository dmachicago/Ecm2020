select top 1000 * from Product

--delete from ProdReview where Comment = 'This is a test rating'

--update ProdReview set rating = 4.75 where rating = 0 

update product set 
NbrRatings = (select count(*) from ProdReview where ProdReview.ProductID = Product.ProductID),
Vote3 = (select count(*) from ProdReview where ProdReview.ProductID = Product.ProductID and Rating = 3),
Vote4 = (select count(*) from ProdReview where ProdReview.ProductID = Product.ProductID and Rating = 4),
Vote5 = (select count(*) from ProdReview where ProdReview.ProductID = Product.ProductID and Rating = 5)
--AvgRating = (select count(*) from ProdReview where ProdReview.ProductID = Product.ProductID and Rating = 5)

update product set 
AvgRating = (select avg(rating) from ProdReview where ProdReview.ProductID = Product.ProductID),
Rating = (select avg(rating) from ProdReview where ProdReview.ProductID = Product.ProductID)

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
