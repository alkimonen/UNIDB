UPDATE classroom
    SET building_no = ( SELECT building_id
                        FROM building
                        WHERE SUBSTR(class_name, 1, 2) = building_name
                        AND LENGTH(building_name) > 1);
                        
UPDATE classroom
    SET building_no = ( SELECT building_id
                        FROM building
                        WHERE SUBSTR(class_name, 1, 1) = building_name
                        AND LENGTH(building_name) = 1)
    WHERE building_no IS null;


DECLARE
    i number(3);
    s varchar2(25);
BEGIN
    FOR i IN 1..100 LOOP
    
        SELECT building_name INTO s FROM building WHERE building_id = i;
        
        UNIDB_INSERT_CLASSROOMS(
            MOD(i,10),
            FLOOR(i*3/10),
            s);
    END LOOP;
END;