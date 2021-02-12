create or replace PROCEDURE ADD_ENTRIES(
    noOfPeople IN entries.person_no%type,
    noOfBuildings IN entries.building_no%type)
IS
    i number(10);
    j number(3);
BEGIN
    
    FOR j IN 1..10 LOOP
    FOR i IN 1..1000000 LOOP
    
    INSERT INTO entries ( entry_no, person_no, building_no, entry_time)
        values (
            entry_seq.nextval,
            ROUND( DBMS_RANDOM.VALUE( 1, noOfPeople)),
            ROUND( DBMS_RANDOM.VALUE( 1, noOfBuildings)),
            ADD_MONTHS( sysdate, -132 + ( 12 * j ) )
        );
        
    END LOOP;
    END LOOP;
END;