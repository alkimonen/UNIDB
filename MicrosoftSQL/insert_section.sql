DECLARE
    @noOfSt NUMERIC(10),
    @idOfSt NUMERIC(10),
    @k NUMERIC(10) = 1;
BEGIN
    set @noOfSt = ( SELECT COUNT( *) FROM people
					WHERE title_no = 4 OR title_no = 5 OR title_no = 6);
	WHILE ( @k <=  @noOfSt )
	BEGIN
		SET @idOfSt = 18000 + @k;
		EXEC INSERT_SECTIONS @studentNo = @idOfSt;
		SET @k = @k + 1;
	END;
END;