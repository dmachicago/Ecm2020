USE [InStock365];
GO
CREATE VIEW vProduct
AS SELECT P.* , 
		PC.ClassCode , 
		C.ParentClassID , 
		C.ClassID
	FROM dbo.Product AS P
		  JOIN ProductClass AS PC
		  ON P.ProductID
			= 
			PC.ProductID
		  JOIN Classification AS C
		  ON C.ClassCode
			= 
			PC.ClassCode;
GO

--Get the products within a specific CLASS
SELECT *
  FROM vProduct
  --Where ClassCode = 'Amber Bottles'
  --Where ClassCode = 'Blue Bottles'
  WHERE ClassCode
	   = 
	   'Collodial Silver'
  ORDER BY ProductID;
GO

CREATE VIEW vProdImages
AS SELECT P.ProductID , 
		P.ShortTitle , 
		P.RowNbr , 
		P.image_small , 
		P.image_medium , 
		P.image_large , 
		PC.ClassCode , 
		C.ParentClassID , 
		C.ClassID
	FROM dbo.Product AS P
		  JOIN ProductClass AS PC
		  ON P.ProductID
			= 
			PC.ProductID
		  JOIN Classification AS C
		  ON C.ClassCode
			= 
			PC.ClassCode;

GO

--Select all Product Images within the 'Collodial Silver' class
SELECT ProductID , 
	  ShortTitle , 
	  RowNbr , 
	  image_small , 
	  image_medium , 
	  image_large , 
	  ClassCode , 
	  ParentClassID , 
	  ClassID
  FROM dbo.vProdImages
  WHERE ClassCode
	   = 
	   'Collodial Silver';
GO

SELECT ClassCode , 
	  ProductID , 
	  CreateDate , 
	  LastModDate , 
	  RowNbr
  FROM dbo.ProductClass;
GO

--Select the TOP LEVEL Classes
SELECT ClassCode , 
	  Classdesc , 
	  CreateDate , 
	  LastModDate , 
	  RowNbr , 
	  ClassID , 
	  ParentClassID , 
	  ImageURL
  FROM dbo.Classification
  WHERE ParentClassID IS NULL
  ORDER BY ClassID;
GO

--Get the SUB-CLASSES of a parent class
SELECT ClassCode , 
	  Classdesc , 
	  CreateDate , 
	  LastModDate , 
	  RowNbr , 
	  ClassID , 
	  ParentClassID , 
	  ImageURL
  FROM dbo.Classification
  WHERE ParentClassID
	   = 
	   (SELECT DISTINCT ClassID
		 FROM Classification
		 WHERE ClassCode
			  = 
			  'Collodial Silver'
	   )
	   ORDER BY ClassID;
GO



--*** ADD TEST DATA ***
INSERT INTO ProductClass(ProductID , 
					ClassCode
				    )
VALUES('NC-CS-2OZ-AM'
	, 'Amber Bottles'
	 );
INSERT INTO ProductClass(ProductID , 
					ClassCode
				    )
VALUES('NC-CS-4OZ-AM'
	, 'Amber Bottles'
	 );
INSERT INTO ProductClass(ProductID , 
					ClassCode
				    )
VALUES('NC-CS-8OZ-AM'
	, 'Amber Bottles'
	 );
INSERT INTO ProductClass(ProductID , 
					ClassCode
				    )
VALUES('NC-CS-8OZ-BL'
	, 'Blue Bottles'
	 );
INSERT INTO ProductClass(ProductID , 
					ClassCode
				    )
VALUES('NC-CS-4OZ-BL'
	, 'Blue Bottles'
	 );
INSERT INTO ProductClass(ProductID , 
					ClassCode
				    )
VALUES('NC-CS-2OZ-BL'
	, 'Blue Bottles'
	 );

INSERT INTO ProductClass(ProductID , 
					ClassCode
				    )
VALUES('NC-CS-2OZ-AM'
	, 'Collodial Silver'
	 );
INSERT INTO ProductClass(ProductID , 
					ClassCode
				    )
VALUES('NC-CS-4OZ-AM'
	, 'Collodial Silver'
	 );
INSERT INTO ProductClass(ProductID , 
					ClassCode
				    )
VALUES('NC-CS-8OZ-AM'
	, 'Collodial Silver'
	 );
INSERT INTO ProductClass(ProductID , 
					ClassCode
				    )
VALUES('NC-CS-8OZ-BL'
	, 'Collodial Silver'
	 );
INSERT INTO ProductClass(ProductID , 
					ClassCode
				    )
VALUES('NC-CS-4OZ-BL'
	, 'Collodial Silver'
	 );
INSERT INTO ProductClass(ProductID , 
					ClassCode
				    )
VALUES('NC-CS-2OZ-BL'
	, 'Collodial Silver'
	 );

UPDATE Product
  SET image_small = 'BottleAndDropperAmber.jpg'
  WHERE ProductID
	   = 
	   'NC-CS-2OZ-AM';     --	2oz. Collodial Silver (Amber)
UPDATE Product
  SET image_medium = 'BottleAndDropperAmber.jpg'
  WHERE ProductID
	   = 
	   'NC-CS-2OZ-AM';     --	2oz. Collodial Silver (Amber)
UPDATE Product
  SET image_large = 'BottleAndDropperAmber.jpg'
  WHERE ProductID
	   = 
	   'NC-CS-2OZ-AM';     --	2oz. Collodial Silver (Amber)

UPDATE Product
  SET image_small = 'BottleWithMisterAmber.jpg'
  WHERE ProductID
	   = 
	   'NC-CS-4OZ-AM';     --	4oz. Collodial Silver (Amber)
UPDATE Product
  SET image_medium = 'BottleWithMisterAmber.jpg'
  WHERE ProductID
	   = 
	   'NC-CS-4OZ-AM';     --	4oz. Collodial Silver (Amber)
UPDATE Product
  SET image_large = 'BottleWithMisterAmber.jpg'
  WHERE ProductID
	   = 
	   'NC-CS-4OZ-AM';     --	4oz. Collodial Silver (Amber)

UPDATE Product
  SET image_small = 'Colloidal-Silver.Label7.jpg'
  WHERE ProductID
	   = 
	   'NC-CS-8OZ-AM';     --	8oz. Collodial Silver (Amber)
UPDATE Product
  SET image_medium = 'Colloidal-Silver.Label7.jpg'
  WHERE ProductID
	   = 
	   'NC-CS-8OZ-AM';     --	8oz. Collodial Silver (Amber)
UPDATE Product
  SET image_large = 'Colloidal-Silver.Label7.jpg'
  WHERE ProductID
	   = 
	   'NC-CS-8OZ-AM';     --	8oz. Collodial Silver (Amber)

UPDATE Product
  SET image_small = 'BottleDropperBlue.jpg'
  WHERE ProductID
	   = 
	   'NC-CS-8OZ-BL';     --	8oz. Collodial Silver (Blue)
UPDATE Product
  SET image_medium = 'BottleDropperBlue.jpg'
  WHERE ProductID
	   = 
	   'NC-CS-8OZ-BL';     --	8oz. Collodial Silver (Blue)
UPDATE Product
  SET image_large = 'BottleDropperBlue.jpg'
  WHERE ProductID
	   = 
	   'NC-CS-8OZ-BL';     --	8oz. Collodial Silver (Blue)

UPDATE Product
  SET image_small = 'BottleSingleBlue.jpg'
  WHERE ProductID
	   = 
	   'NC-CS-4OZ-BL';     --	4oz. Collodial Silver (Blue Bottle)
UPDATE Product
  SET image_medium = 'BottleSingleBlue.jpg'
  WHERE ProductID
	   = 
	   'NC-CS-4OZ-BL';     --	4oz. Collodial Silver (Blue Bottle)
UPDATE Product
  SET image_large = 'BottleSingleBlue.jpg'
  WHERE ProductID
	   = 
	   'NC-CS-4OZ-BL';     --	4oz. Collodial Silver (Blue Bottle)

UPDATE Product
  SET image_small = 'BottleDropperBlue2.jpg'
  WHERE ProductID
	   = 
	   'NC-CS-2OZ-BL';     --	2oz. Collodial Silver (Blue)
UPDATE Product
  SET image_medium = 'BottleDropperBlue2.jpg'
  WHERE ProductID
	   = 
	   'NC-CS-2OZ-BL';     --	2oz. Collodial Silver (Blue)
UPDATE Product
  SET image_large = 'BottleDropperBlue2.jpg'
  WHERE ProductID
	   = 
	   'NC-CS-2OZ-BL';     --	2oz. Collodial Silver (Blue)

UPDATE Classification
  SET ImageURL = 'Supplement13.jpg'
  WHERE ClassCode
	   = 
	   'Natural Supplements';
UPDATE Classification
  SET ImageURL = 'Colloidal-Silver.Label10.jpg'
  WHERE ClassCode
	   = 
	   'Collodial Silver';
UPDATE Classification
  SET ImageURL = 'SkinCare00.jpg'
  WHERE ClassCode
	   = 
	   'Natural Skin Care';
UPDATE Classification
  SET ImageURL = 'Vitamins01.jpg'
  WHERE ClassCode
	   = 
	   'Vitamins';
UPDATE Classification
  SET ImageURL = 'Oils04.jpg'
  WHERE ClassCode
	   = 
	   'Essential Oils';