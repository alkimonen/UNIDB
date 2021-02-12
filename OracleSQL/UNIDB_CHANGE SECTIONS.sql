CREATE TABLE temp( section_id NUMBER(10),
                    course_no NUMBER(10));

DROP TABLE temp;

SELECT COUNT( section_no) FROM section;

BEGIN
    --UIDB_CHANGE_SECTIONS( 774642);
    UIDB_CHANGE_SECTIONS( 100000);
END;