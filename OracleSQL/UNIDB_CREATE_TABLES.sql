CREATE TABLE campus( campus_id NUMBER(2) CONSTRAINT campus_pk PRIMARY KEY,
                     campus_name VARCHAR2(25) CONSTRAINT campus_name_nn NOT NULL);

CREATE TABLE building( building_id NUMBER(5) CONSTRAINT building_pk PRIMARY KEY,
                        building_name VARCHAR2(25) CONSTRAINT building_name_nn NOT NULL,
                        campus_no NUMBER(2),
                        CONSTRAINT building_campus_fk FOREIGN KEY( campus_no) REFERENCES campus( campus_id));

CREATE TABLE classroom( class_id NUMBER(7) CONSTRAINT class_pk PRIMARY KEY,
                        class_name VARCHAR2(25) CONSTRAINT class_name_nn NOT NULL,
                        building_no NUMBER(5),
                        CONSTRAINT class_building_fk FOREIGN KEY( building_no) REFERENCES building( building_id));

CREATE TABLE course( course_id NUMBER(10) CONSTRAINT course_pk PRIMARY KEY,
                        course_code VARCHAR2(10) CONSTRAINT course_code_nn NOT NULL,
                        course_desc VARCHAR2(80),
                        course_credit NUMBER(1) DEFAULT 0);

CREATE TABLE faculty( faculty_id NUMBER(2) CONSTRAINT faculty_pk PRIMARY KEY,
                        faculty_name VARCHAR2(40) CONSTRAINT faculty_name_nn NOT NULL);

CREATE TABLE degrees( degree_id NUMBER(1) CONSTRAINT degree_pk PRIMARY KEY,
                        degree_name VARCHAR2(20) CONSTRAINT degree_name_nn NOT NULL);

CREATE TABLE department( department_id NUMBER(3) CONSTRAINT department_pk PRIMARY KEY,
                            department_name VARCHAR2(60) CONSTRAINT department_name_nn NOT NULL,
                            faculty_no NUMBER(2),
                            degree_no NUMBER(1),
                            CONSTRAINT department_faculty_fk FOREIGN KEY( faculty_no) REFERENCES faculty( faculty_id),
                            CONSTRAINT department_degree_fk FOREIGN KEY( degree_no) REFERENCES degrees( degree_id));

CREATE TABLE curriculum( department_no NUMBER(3) CONSTRAINT department_no_nn NOT NULL,
                            course_no NUMBER(10) CONSTRAINT course_no_nn NOT NULL,
                            CONSTRAINT curriculum_course_fk FOREIGN KEY( course_no) REFERENCES course( course_id),
                            CONSTRAINT curriculum_department_fk FOREIGN KEY( department_no) REFERENCES department( department_id));

CREATE TABLE title( title_id NUMBER(1) CONSTRAINT title_pk PRIMARY KEY,
                        title_name VARCHAR2(20) CONSTRAINT title_name_nn NOT NULL);

CREATE TABLE people( person_id NUMBER(10) CONSTRAINT people_pk PRIMARY KEY,
                        name VARCHAR2(20) CONSTRAINT name_nn NOT NULL,
                        last_name VARCHAR2(20) CONSTRAINT last_name_nn NOT NULL,
                        email VARCHAR2(50),
                        phone VARCHAR2(15),
                        gpa NUMBER(3,2) CONSTRAINT gpa_ck CHECK ( gpa >= 0 and gpa <= 4),
                        title_no NUMBER(1),
                        department_no NUMBER(3),
                        CONSTRAINT people_title_fk FOREIGN KEY( title_no) REFERENCES title( title_id),
                        CONSTRAINT student_department_fk FOREIGN KEY( department_no) REFERENCES department( department_id));

CREATE TABLE section_info( section_id NUMBER(10) CONSTRAINT section_info_pk PRIMARY KEY,
                            course_no NUMBER(10),
                            section_no NUMBER(2) CONSTRAINT section_no_nn NOT NULL,
                            teacher_no NUMBER(10),
                            class_no NUMBER(7),
                            CONSTRAINT section_course_fk FOREIGN KEY( course_no) REFERENCES course( course_id),
                            CONSTRAINT section_teacher_fk FOREIGN KEY( teacher_no) REFERENCES people( person_id),
                            CONSTRAINT section_class_fk FOREIGN KEY( class_no) REFERENCES classroom( class_id));

CREATE TABLE section( section_no NUMBER(10) CONSTRAINT section_id_nn NOT NULL,
                        student_no NUMBER(10),
                        CONSTRAINT section_info_fk FOREIGN KEY( section_no) REFERENCES section_info( section_id),
                        CONSTRAINT section_student_fk FOREIGN KEY( student_no) REFERENCES people( person_id));
                    

CREATE TABLE entries( entry_no NUMBER(15) CONSTRAINT entry_pk PRIMARY KEY,
                        person_no NUMBER(10) CONSTRAINT person_no_nn NOT NULL,
                        building_no NUMBER(7) CONSTRAINT building_no_nn NOT NULL,
                        entry_time TIMESTAMP DEFAULT current_date,
                        CONSTRAINT entry_person_fk FOREIGN KEY( person_no) REFERENCES people( person_id),
                        CONSTRAINT entry_building_fk FOREIGN KEY( building_no) REFERENCES building( building_id));