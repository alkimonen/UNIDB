--DROP PROCEDURE INSERT_CLASSROOMS;

create PROCEDURE INSERT_CLASSROOMS(
    @floor NUMERIC(2),
    @rooms NUMERIC(2),
    @name VARCHAR(MAX))
AS
BEGIN
	declare
		@current NUMERIC(10),
		@i NUMERIC(2) = 1,
		@j NUMERIC(2) = 1,
		@ek VARCHAR(2);

	WHILE ( @i <= @floor )
	BEGIN
		
		WHILE ( @j <= @rooms )
		BEGIN
			IF ( @j < 10 )
				set @ek = '0' + CONVERT( VARCHAR(2), @j);
			ELSE
				set @ek = CONVERT( VARCHAR(2), @j);
			SET @j = @j + 1;

		INSERT INTO classroom ( class_name)
			VALUES ( @name + CONVERT( VARCHAR(1), @i) + @ek );
		END;
		SET @j = 1;
		SET @i = @i + 1;
	END;
END;