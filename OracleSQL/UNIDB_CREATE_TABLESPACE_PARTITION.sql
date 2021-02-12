CREATE TABLESPACE tablespace1
    DATAFILE 'entry1.dat'
    SIZE 200M
    AUTOEXTEND ON;
    
CREATE TABLESPACE tablespace2
    DATAFILE 'entry2.dat'
    SIZE 200M
    AUTOEXTEND ON;
    
CREATE TABLESPACE tablespace3
    DATAFILE 'entry3.dat'
    SIZE 200M
    AUTOEXTEND ON;
    
CREATE TABLESPACE tablespace4
    DATAFILE 'entry4.dat'
    SIZE 200M
    AUTOEXTEND ON;

CREATE TABLE partitioned_entries( entry_no NUMBER(15) CONSTRAINT p_entry_pk PRIMARY KEY,
                        person_no NUMBER(10) CONSTRAINT p_person_no_nn NOT NULL,
                        building_no NUMBER(7) CONSTRAINT p_building_no_nn NOT NULL,
                        entry_time TIMESTAMP DEFAULT current_date,
                        CONSTRAINT p_entry_person_fk FOREIGN KEY( person_no) REFERENCES people( person_id),
                        CONSTRAINT p_entry_building_fk FOREIGN KEY( building_no) REFERENCES building( building_id))
                         PARTITION BY RANGE ( entry_time) (
                            PARTITION entries_p1 VALUES LESS THAN ( to_date( '01.01.2012', 'DD.MM.YYYY'))
                                TABLESPACE tablespace1,
                            PARTITION entries_p2 VALUES LESS THAN ( to_date( '01.01.2015', 'DD.MM.YYYY'))
                                TABLESPACE tablespace2,
                            PARTITION entries_p3 VALUES LESS THAN ( to_date( '01.01.2018', 'DD.MM.YYYY'))
                                TABLESPACE tablespace3,
                            PARTITION entries_p4 VALUES LESS THAN ( to_date( '01.01.2020', 'DD.MM.YYYY'))
                                TABLESPACE tablespace4);

INSERT INTO partitioned_entries
    SELECT * from entries;