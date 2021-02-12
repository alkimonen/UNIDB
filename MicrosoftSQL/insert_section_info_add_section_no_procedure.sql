/*create PROCEDURE ADD_SECTION_NO(
    @courseNo NUMERIC(10),
    @noOfSections NUMERIC(2))
AS
BEGIN
	DECLARE
		@k NUMERIC(2);
	SET @k = 1;
	WHILE ( @k <= @noOfSections )
	BEGIN
		UPDATE TOP (1) temp
			SET section_no = @k
			WHERE course_no = @courseNo
			AND section_no is null;
		SET @k = @k + 1;
	END;
END;*/

--DROP PROCEDURE ADD_SECTION_NO;