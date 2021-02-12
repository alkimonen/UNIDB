ALTER TABLE entries
    DISABLE CONSTRAINT entry_pk;
    
ALTER TABLE section_info
    DISABLE CONSTRAINT section_teacher_fk;
    
ALTER TABLE section
    DISABLE CONSTRAINT section_student_fk;
    
ALTER TABLE entries
    DISABLE CONSTRAINT entry_person_fk;
    
ALTER TABLE people
    DISABLE CONSTRAINT people_pk;

ALTER TABLE people
    ENABLE CONSTRAINT people_pk;
    
ALTER TABLE section_info
    ENABLE CONSTRAINT section_teacher_fk;
    
ALTER TABLE section
    ENABLE CONSTRAINT section_student_fk;
    
ALTER TABLE entries
    ENABLE CONSTRAINT entry_person_fk;
    
ALTER TABLE entries
    ENABLE CONSTRAINT entry_pk;
    
SELECT * from entries;

ALTER SYSTEM CHECK DATAFILES;
