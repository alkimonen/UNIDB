UPDATE people
    SET email = LOWER( name)|| '.' || LOWER( last_name) || '@uni.edu';



alter table department
    add blue NUMBER(2);

create sequence seq
    start WITH 1
    INCREMENT BY 1;

update department
    set blue = seq.nextval
    where degree_no = 1;

update people
    set department_no = ( 
    SELECT department_id
    FROM ( SELECT department_id, blue FROM department WHERE degree_no = 1 ) 
    WHERE blue = ( MOD( person_id, 32) + 1)
    )
    where title_no = 6;

alter table department
    drop column blue;

drop sequence seq;

alter table department
    add blue NUMBER(2);

create sequence seq
    start WITH 1
    INCREMENT BY 1;

update department
    set blue = seq.nextval
    where degree_no = 2;

update people
    set department_no = ( 
    SELECT department_id
    FROM ( SELECT department_id, blue FROM department WHERE degree_no = 2 ) 
    WHERE blue = ( MOD( person_id, 22) + 1)
    )
    where title_no = 5;

alter table department
    drop column blue;

drop sequence seq;

alter table department
    add blue NUMBER(2);

create sequence seq
    start WITH 1
    INCREMENT BY 1;

update department
    set blue = seq.nextval
    where degree_no = 3;

update people
    set department_no = ( 
    SELECT department_id
    FROM ( SELECT department_id, blue FROM department WHERE degree_no = 3 ) 
    WHERE blue = ( MOD( person_id, 17) + 1)
    )
    where title_no = 4;

alter table department
    drop column blue;

drop sequence seq;