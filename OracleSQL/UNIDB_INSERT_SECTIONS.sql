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
                            WHERE person_id = 10185
                                        )
                            )
            GROUP BY course_no
    );

ALTER TABLE people
    ADD blue NUMBER(10);

CREATE SEQUENCE seq
    START WITH 1
    INCREMENT BY 1;
    
UPDATE people
    SET blue = seq.nextval
    where title_no = 4 OR title_no = 5 OR title_no = 6;

DECLARE
    noOfSt NUMBER(10);
    idOfSt NUMBER(10);
    k NUMBER(10);
BEGIN
    /*SELECT count( person_id) INTO noOfSt FROM people
        WHERE title_no = 4 OR title_no = 5 OR title_no = 6;*/
    noOfSt := seq.currval;
    
    FOR k IN 1..noOfSt LOOP
        SELECT person_id
            INTO idOfSt
            FROM people
            WHERE person_id = k;
        INSERT_SECTIONS( idOfSt);
    END LOOP;
END;