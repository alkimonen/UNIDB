CREATE INDEX entry_people_fk
    ON entries( person_no);

    /*LOCAL PARTITION BY RANGE ( entry_time) (
        PARTITION entries_i1 VALUES LESS THAN ( to_date( '01.01.2019', 'DD.MM.YYYY')),
        PARTITION entries_i2 VALUES LESS THAN ( to_date( '01.02.2019', 'DD.MM.YYYY')),
        PARTITION entries_i3 VALUES LESS THAN ( to_date( '01.03.2019', 'DD.MM.YYYY')),
        PARTITION entries_i4 VALUES LESS THAN ( to_date( '01.04.2019', 'DD.MM.YYYY')),
        PARTITION entries_i5 VALUES LESS THAN ( to_date( '01.05.2019', 'DD.MM.YYYY')),
        PARTITION entries_i6 VALUES LESS THAN ( to_date( '01.06.2019', 'DD.MM.YYYY')),
        PARTITION entries_i7 VALUES LESS THAN ( to_date( '01.07.2019', 'DD.MM.YYYY')),
        PARTITION entries_i8 VALUES LESS THAN ( to_date( '01.08.2019', 'DD.MM.YYYY')),
        PARTITION entries_i9 VALUES LESS THAN ( MAXVALUE));*/
DROP INDEX entry_people_fk;

CREATE INDEX people_title_fk
    ON people( title_no);

CREATE INDEX people_department_fk
    ON people( department_no);
    
CREATE INDEX class_building_fk
    ON classroom( building_no);

CREATE INDEX building_campus_fk
    ON building( campus_no);

CREATE INDEX section_people_fk
    ON section( student_no);

CREATE INDEX curriculum_department_fk
    ON curriculum( department_no);

CREATE INDEX curriculum_course_fk
    ON curriculum( course_no);


