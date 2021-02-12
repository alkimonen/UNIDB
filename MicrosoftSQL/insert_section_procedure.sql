--DROP PROCEDURE INSERT_SECTIONS;

/*create PROCEDURE INSERT_SECTIONS(
    @studentNo NUMERIC(10))
AS
BEGIN
	DECLARE
		@i NUMERIC(3);

    INSERT INTO section ( section_no)
        ( SELECT res.section_id
            FROM ( SELECT MIN(section_id) as section_id, course_no
						FROM section_info
						WHERE course_no IN ( 
							SELECT course_no
								FROM curriculum
								WHERE department_no = (
									SELECT department_no
										FROM people
										WHERE person_id = @studentNo
													)
										) 
                    GROUP BY course_no ) res
            );
            
    UPDATE section
		SET student_no = @studentNo
		where student_no IS NULL;    
END;*/