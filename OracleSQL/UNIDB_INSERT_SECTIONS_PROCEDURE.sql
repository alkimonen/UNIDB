create or replace PROCEDURE INSERT_SECTIONS(
    studentNo IN section.student_no%type)
IS
    i NUMBER(3);
    stmt VARCHAR2(100);
BEGIN
    INSERT INTO section ( section_no)
        SELECT section_id
            FROM (
                SELECT MIN(section_id) section_id, course_no
                    FROM section_info
                    WHERE course_no IN ( 
                        SELECT course_no
                            FROM curriculum
                            WHERE department_no = (
                                SELECT department_no
                                    FROM people
                                    WHERE person_id = studentNo
                                                )
                                    )
                    GROUP BY course_no
            );
            
    stmt := 'UPDATE section
                SET student_no = ' || studentNo ||
                ' where student_no IS NULL';
    EXECUTE IMMEDIATE stmt;
    
END;