create or replace PROCEDURE UIDB_CHANGE_SECTIONS(
    noOfSections IN section_info.section_id%type)
IS
    i number(10);
    j number(10);
    k number(10);
    m number(10);
BEGIN
    FOR i IN 1..noOfSections LOOP
        
        INSERT INTO temp ( section_id, course_no)
            SELECT section_id, course_no
                FROM section_info
                WHERE course_no = ( SELECT course_no
                                        FROM section_info
                                        WHERE section_id = ( SELECT section_no
                                                                FROM section
                                                                WHERE rownum = 1)
                                    );
        
        SELECT COUNT( section_id)
            INTO k
            FROM temp;

        SELECT MOD( student_no, k)
            INTO m
            FROM section
            WHERE rownum = 1;

        FOR j IN 1..m LOOP
            DELETE FROM temp
                WHERE rownum = 1;
        END LOOP;
            
        INSERT INTO section ( section_no, student_no)
            VALUES ( ( SELECT section_id
                        FROM temp
                        WHERE rownum = 1),
                    ( SELECT student_no
                        FROM section
                        WHERE rownum = 1));
            
        DELETE FROM section
            WHERE rownum = 1;
                            
        DELETE FROM temp;
        
    END LOOP;
END;