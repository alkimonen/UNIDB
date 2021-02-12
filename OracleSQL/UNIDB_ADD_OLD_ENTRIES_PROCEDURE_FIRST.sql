create or replace PROCEDURE ADD_OLD_ENTRIES(
    noOfPeople IN entries.person_no%type,
    noOfBuildings IN entries.building_no%type)
IS
    i NUMBER(10);
    j NUMBER(3);
    id NUMBER(10);
    build NUMBER(7);
    time TIMESTAMP;
BEGIN

    FOR j IN 1..240 LOOP
        FOR i IN 1..500000 LOOP

        id := ROUND( DBMS_RANDOM.VALUE( 1, noOfPeople));
        build := ROUND( DBMS_RANDOM.VALUE( 1, noOfBuildings));
        time := sysdate - 240 + j + ( ROUND( DBMS_RANDOM.VALUE( 1, 24)) / 24);

        INSERT INTO entries ( entry_no, person_no, building_no, entry_time)
            values (
                entry_seq.nextval,
                id,
                build,
                time
            );

        time := time + ( ROUND( DBMS_RANDOM.VALUE( 1, 599)) / ( 24 * 60 ));

        INSERT INTO entries ( entry_no, person_no, building_no, entry_time, direction)
            values (
                entry_seq.nextval,
                id,
                build,
                time,
                'OUT'
            );

        END LOOP;
    END LOOP;
END;