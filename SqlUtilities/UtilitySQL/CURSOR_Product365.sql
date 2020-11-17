SET NOCOUNT ON;

DECLARE @EmailAddr nvarchar(50);
DECLARE @ProductID nvarchar(50);
DECLARE @I int ;
Declare @comment nvarchar(200) ;
Declare @ManfID nvarchar(10) ;
Declare @rating decimal(4,2) ;
declare @Remainder as integer ;

Declare @maxRandomValue tinyint = 5 , @minRandomValue tinyint = 3;
 
PRINT '-------- Adding Comments --------';

DECLARE cust_cursor CURSOR FOR 
SELECT EmailAddr
FROM Customer ;

OPEN cust_cursor ;

FETCH NEXT FROM cust_cursor INTO @EmailAddr ;

WHILE @@FETCH_STATUS = 0
BEGIN
    SELECT @EmailAddr ;
    PRINT 'EM:' + @EmailAddr ;

    -- Declare an inner cursor based   
    -- on vendor_id from the outer cursor.

    DECLARE product_cursor CURSOR FOR SELECT ProductID, ManfID FROM Product ;
    
    OPEN product_cursor ;
    FETCH NEXT FROM product_cursor INTO @ProductID, @ManfID ;

	Select @I = 0 ; 

    IF @@FETCH_STATUS <> 0 
        PRINT '         <<None>>'     ;

    WHILE @@FETCH_STATUS = 0
    BEGIN

		select @I += 1 ;		
		Select @rating = Cast(((@maxRandomValue + 1) - @minRandomValue) * Rand() + @minRandomValue As tinyint);

		if @rating = 3 begin
			select @comment = 'This is an average product that fills the purpose.' ;
		end;
		if @rating = 4 begin
			select @comment = 'An above average product that mor than fills the purpose' ;
		end;
		if @rating = 5 begin
			select @comment = 'An excellent product at a great price.' ;
		end;
		

        --PRINT @I ;
        FETCH NEXT FROM product_cursor INTO @ProductID, @ManfID ;

		Insert into ProdReview (ProductID, ManfID, EmailAddr, Rating, Comment) values (@ProductID, @ManfID, @EmailAddr, @Rating, @comment) ;

    END

    CLOSE product_cursor ;
    DEALLOCATE product_cursor ;
        -- Get the next vendor.
    FETCH NEXT FROM cust_cursor INTO @EmailAddr ;
END 
CLOSE cust_cursor;
DEALLOCATE cust_cursor;
