--DROP PROCEDURE ADD_ENTRIES;

CREATE PROCEDURE ADD_ENTRIES(
    @noOfPeople NUMERIC(10),
    @noOfBuildings NUMERIC(5))
AS
BEGIN
    DECLARE
	@i NUMERIC(10),
	@j NUMERIC(5) = 1,
	@time DATETIME;

	WHILE ( @j <= 153 )
	BEGIN
		SET @i = 1;
		WHILE ( @i <= 50000 )
		BEGIN
			SET @time = DATEADD( day, ( @j - 153 ), CURRENT_TIMESTAMP);
			SET @time = DATEADD( hour, FLOOR( RAND()*24), @time);
			SET @time = DATEADD( minute, FLOOR( RAND()*60), @time);
			SET @time = DATEADD( second, FLOOR( RAND()*60), @time);

			INSERT INTO entries( person_no, building_no, entry_time)
				VALUES( FLOOR( RAND()*( @noOfPeople + 1 )),
						FLOOR( 1000 + RAND()*( @noOfBuildings + 1 )),
						@time);
			SET @i = @i + 1;
		END;
		SET @j = @j + 1;
	END;
END;