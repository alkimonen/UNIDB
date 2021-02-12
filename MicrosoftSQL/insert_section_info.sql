create table temp( course_no NUMERIC(10),
                   section_no NUMERIC(2),
                   teacher_no NUMERIC(10),
                   class_no NUMERIC(7));

INSERT INTO temp ( teacher_no)
    SELECT person_id FROM people WHERE title_no = 3;

update temp
    set class_no = (
    SELECT class_id
    FROM  classroom
    WHERE class_id = (teacher_no % 4499) + 35616
    ); 

UPDATE temp
    set course_no = (
    SELECT course_id
    FROM course
    WHERE course_id = ( teacher_no % 2674 ) + 7034
    );

DECLARE
    @i NUMERIC(10) = 7034,
    @j NUMERIC(2);
BEGIN
	WHILE ( @i <= 9707 )
	BEGIN
		SET @j = ( SELECT COUNT(*) FROM temp WHERE course_no = @i);
		EXEC ADD_SECTION_NO @courseNo = @i, @noOfSections = @j;
		SET @i = @i + 1;
    END;
END;

INSERT INTO section_info (course_no, section_no, teacher_no, class_no)
	SELECT course_no, section_no, teacher_no, class_no
	FROM temp;

DROP TABLE temp;