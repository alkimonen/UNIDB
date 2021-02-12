UPDATE people
    SET email = LOWER( name) + '.' + LOWER( last_name) + '@uni.edu';

update department
	set blue = null;

DECLARE
	@i as NUMERIC(2) = 1;
WHILE ( (SELECT count(*) FROM department where degree_no = 1 and blue is null) > 0)
BEGIN
update top (1) department
    set blue = @i
    where degree_no = 1
	and blue is null;

	set @i = @i + 1;
END;

update people
    set department_no = ( 
    SELECT a.department_id
    FROM ( SELECT department_id, blue FROM department WHERE degree_no = 1 ) a
    WHERE a.blue = ( (people.person_id % 32) + 1)
    )
    where title_no = 6;

update department
	set blue = null;

DECLARE
	@j as NUMERIC(2) = 1;
WHILE ( (SELECT count(*) FROM department where degree_no = 2 and blue is null) > 0)
BEGIN
update top (1) department
    set blue = @j
    where degree_no = 2
	and blue is null;

	set @j = @j + 1;
END;

update people
    set department_no = ( 
    SELECT a.department_id
    FROM ( SELECT department_id, blue FROM department WHERE degree_no = 2 ) a
    WHERE a.blue = ( (people.person_id % 22) + 1)
    )
    where title_no = 5;

update department
	set blue = null;

DECLARE
	@k as NUMERIC(2) = 1;
WHILE ( (SELECT count(*) FROM department where degree_no = 3 and blue is null) > 0)
BEGIN
update top (1) department
    set blue = @k
    where degree_no = 3
	and blue is null;

	set @k = @k + 1;
END;

update people
    set department_no = ( 
    SELECT a.department_id
    FROM ( SELECT department_id, blue FROM department WHERE degree_no = 3 ) a
    WHERE a.blue = (people.person_id % 17) + 1
    )
    where title_no = 4;

update people
    set department_no = ( (people.person_id % 73) + 1)
    where title_no = 3;

update people
    set department_no = 4
    where title_no = 1;