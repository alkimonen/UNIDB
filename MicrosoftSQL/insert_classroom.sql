DECLARE
    @l NUMERIC(3) = 1,
	@t NUMERIC(2),
	@h NUMERIC(2),
    @s VARCHAR(25);
BEGIN
	WHILE ( @l <= 100 )
	BEGIN
		set @s = ( SELECT building_name FROM building WHERE building_id = (@l+1000));
		set @t = @l % 10;
		set @h = FLOOR( ( @l*3) % 20);

		EXEC INSERT_CLASSROOMS @floor = @t, @rooms = @h, @name = @s;
		set @l = @l + 1;
	END;
END;



UPDATE classroom
    SET building_no = ( SELECT building_id
                        FROM building
                        WHERE LEN(building_name) > 1
                        AND SUBSTRING(class_name, 1, 2) = building_name);
                        
UPDATE classroom
    SET building_no = ( SELECT building_id
                        FROM building
                        WHERE LEN(building_name) = 1
                        AND SUBSTRING(class_name, 1, 1) = building_name)
    WHERE building_no IS null;