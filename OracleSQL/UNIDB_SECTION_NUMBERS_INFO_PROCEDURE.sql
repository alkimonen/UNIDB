create or replace PROCEDURE UNIDB_NUMBER_SECTION_INFO(
    courseNo IN section_info.course_no%type,
    noOfSections IN section_info.section_no%type)
IS
    k number(2);
    stmt varchar2(200);
BEGIN        
        FOR k IN 1..noOfSections LOOP
            stmt :=  'UPDATE section_info set section_no = ' || k ||
                        ' where course_no = ' || courseNo ||
                        ' and section_no IS NULL
                        and rownum = 1';
            EXECUTE IMMEDIATE stmt;
        END LOOP;
END;