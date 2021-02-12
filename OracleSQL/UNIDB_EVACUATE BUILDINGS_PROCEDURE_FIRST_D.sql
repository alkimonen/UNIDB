create or replace PROCEDURE EVACUATE_BUILDINGS(
    noOfPeople IN entries.person_no%type,
    noOfBuildings IN entries.building_no%type)
IS
    i NUMBER(10);
    id NUMBER(10);
    build NUMBER(7);
    time TIMESTAMP;
    stmt VARCHAR2(120);
BEGIN
    
    FOR i IN 1..noOfPeople LOOP
    
        SELECT building INTO build FROM people WHERE person_id = id;
        
        IF ( build IS NOT NULL ) THEN
            SELECT entry_time INTO time
                FROM ( SELECT entry_no, entry_time
                            FROM entries
                            WHERE person_no = id
                            ORDER BY entry_no DESC)
                WHERE rownum = 1;
            time := time + ( ROUND( DBMS_RANDOM.VALUE( 1, 599)) / ( 24 * 60 ));
            INSERT INTO entries ( entry_no, person_no, building_no, entry_time, direction)
                values (
                    entry_seq.nextval,
                    id,
                    build,
                    time,
                    'OUT'
                );
            stmt := 'UPDATE people SET building = null WHERE person_id = ' || id;
            EXECUTE IMMEDIATE stmt;
        END IF;
        
    END LOOP;
END;