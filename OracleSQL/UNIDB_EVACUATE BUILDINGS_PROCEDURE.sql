create or replace PROCEDURE EVACUATE_BUILDINGS(
    noOfPeople IN entries.person_no%type,
    noOfBuildings IN entries.building_no%type)
IS
    build NUMBER(7);
    time TIMESTAMP;
    stmt VARCHAR2(120);
BEGIN
    
    FOR p IN ( SELECT person_id, entry_no
                    FROM people
                    WHERE entry_no IS NOT NULL) LOOP
        SELECT entry_time, building_no INTO time, build
                FROM entries
                WHERE entry_no = p.entry_no - 1;
        time := time + ( ROUND( DBMS_RANDOM.VALUE( 1, 599)) / ( 24 * 60 ));
        INSERT INTO entries ( entry_no, person_no, building_no, entry_time, direction)
            values ( p.entry_no,
                        p.person_id,
                        build,
                        time,
                        'OUT'
                    );
        stmt := 'UPDATE people SET entry_no = null WHERE person_id = ' || p.person_id;
        EXECUTE IMMEDIATE stmt;
    END LOOP;
END;