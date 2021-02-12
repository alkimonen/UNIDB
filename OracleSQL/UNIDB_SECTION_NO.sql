create table temp( section_id NUMBER(10),
                    course_no NUMBER(10),
                    section_no NUMBER(2),
                    teacher_no NUMBER(10),
                    class_no NUMBER(7));
                    

INSERT INTO temp ( teacher_no)
    SELECT person_id FROM people WHERE title_no = 3;
    
UPDATE temp
    SET section_id = section_info_seq.nextval
    WHERE section_id IS NULL;

ALTER TABLE classroom
    ADD blue number(5);

ALTER table classroom
    drop column blue;

drop sequence seq;
select seq.nextval from dual;
CREATE SEQUENCE seq
    START WITH 1
    INCREMENT BY 1;

UPDATE course
    SET red = seq.nextval;

ALTER TABLE course
    ADD red NUMBER(5);

update temp
    set class_no = ( 
    SELECT class_id
    FROM ( SELECT class_id, blue FROM classroom) 
    WHERE blue = ( MOD( teacher_no, 6704) + 1)
    );
    
UPDATE temp
    set course_no = (
    SELECT course_id
    FROM ( SELECT course_id, red FROM course)
    WHERE red = ( MOD( teacher_no, 2668) + 1)
    );

select * from temp where course_no = 1063;

alter table temp
    MODIFY section_no NUMBER(5);
Select * from temp where section_no IS NOT NULL;
UPDATE temp
set section_no = null;
    set section_no=1 where course_no = 1 and section_no IS NULL and rownum =1;
select count ( section_id) from temp where course_no = 1635;
select * from course where course_code LIKE 'ENG%';

ALTER TABLE section_info
    DISABLE CONSTRAINT section_no_nn;
commit;

DECLARE
    i number(10);
    j number(2);
BEGIN
    FOR i IN 1..2669 LOOP
        SELECT COUNT( section_id) INTO j FROM section_info WHERE course_no = i;
        UNIDB_NUMBER_SECTION_INFO( i, j);
    END LOOP;
END;


