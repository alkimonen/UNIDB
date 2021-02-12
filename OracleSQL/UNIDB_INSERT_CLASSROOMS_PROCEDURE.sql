create or replace PROCEDURE UNIDB_INSERT_CLASSROOMS(
    floor IN classroom.class_id%type,
    rooms IN classroom.class_id%type,
    name IN classroom.class_name%type)
IS
    current number(10);
    i number(2);
    j number(2);
    ek VARCHAR2(2);
BEGIN
    FOR i IN 1..floor LOOP
        
        FOR j IN 1..rooms LOOP
            
            IF ( i < 10 ) THEN
                ek := '0' || to_char(j);
            ELSE
                ek := to_char(j);
            END IF;            
            
            INSERT INTO classroom( class_id, class_name)
                VALUES ( class_seq.nextval, name || to_char(i)
                            || ek);
        END LOOP;
    END LOOP;
END;