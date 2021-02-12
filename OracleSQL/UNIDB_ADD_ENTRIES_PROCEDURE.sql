create or replace PROCEDURE ADD_ENTRIES(
    noOfPeople IN entries.person_no%type,
    noOfBuildings IN entries.building_no%type)
IS
    i NUMBER(10);
    j NUMBER(3);
    entryNo NUMBER(15);
    id NUMBER(10);
    build NUMBER(7);
    time TIMESTAMP;
    stmt VARCHAR2(120);
BEGIN
    
    FOR j IN 1..240 LOOP
        FOR i IN 1..2 LOOP
        
        id := ROUND( DBMS_RANDOM.VALUE( 1, noOfPeople));
        SELECT entry_no INTO entryNo FROM people WHERE person_id = id;
        
        IF ( entryNo IS NULL ) THEN
            build := ROUND( DBMS_RANDOM.VALUE( 1, noOfBuildings));
            time := sysdate - 240 + j + ( ROUND( DBMS_RANDOM.VALUE( 1, 24)) / 24);
            INSERT INTO entries ( entry_no, person_no, building_no, entry_time)
                values (
                    entry_seq.nextval,
                    id,
                    build,
                    time
                );
            stmt := 'UPDATE people SET entry_no = ' || entry_seq.nextval || ' WHERE person_id = ' || id;
            EXECUTE IMMEDIATE stmt;
        ELSE
            SELECT entry_time, building_no INTO time, build
                FROM entries
                WHERE entry_no = entryNo - 1;
            time := time + ( ROUND( DBMS_RANDOM.VALUE( 1, 599)) / ( 24 * 60 ));
            INSERT INTO entries ( entry_no, person_no, building_no, entry_time, direction)
                values (
                    entryNo,
                    id,
                    build,
                    time,
                    'OUT'
                );
            stmt := 'UPDATE people SET entry_no = null WHERE person_id = ' || id;
            EXECUTE IMMEDIATE stmt;
        END IF;
        
        END LOOP;
    END LOOP;
END;