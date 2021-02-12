CREATE TABLE campus( campus_id NUMERIC(2) IDENTITY(1,1) CONSTRAINT campus_pk PRIMARY KEY,
                     campus_name VARCHAR(25) CONSTRAINT campus_name_nn NOT NULL);

CREATE TABLE building( building_id NUMERIC(5) IDENTITY(1,1) CONSTRAINT building_pk PRIMARY KEY,
                        building_name VARCHAR(25) CONSTRAINT building_name_nn NOT NULL,
                        campus_no NUMERIC(2),
                        CONSTRAINT building_campus_fk FOREIGN KEY( campus_no) REFERENCES campus( campus_id));

CREATE TABLE classroom( class_id NUMERIC(7) IDENTITY(1,1) CONSTRAINT class_pk PRIMARY KEY,
                        class_name VARCHAR(25) CONSTRAINT class_name_nn NOT NULL,
                        building_no NUMERIC(5),
                        CONSTRAINT class_building_fk FOREIGN KEY( building_no) REFERENCES building( building_id));

CREATE TABLE course( course_id NUMERIC(10) IDENTITY(1,1) CONSTRAINT course_pk PRIMARY KEY,
                        course_code VARCHAR(10) CONSTRAINT course_code_nn NOT NULL,
                        course_desc VARCHAR(80),
                        course_credit NUMERIC(1) DEFAULT 0);

CREATE TABLE faculty( faculty_id NUMERIC(2) IDENTITY(1,1) CONSTRAINT faculty_pk PRIMARY KEY,
                        faculty_name VARCHAR(40) CONSTRAINT faculty_name_nn NOT NULL);

CREATE TABLE degree( degree_id NUMERIC(1) IDENTITY(1,1) CONSTRAINT degree_pk PRIMARY KEY,
                        degree_name VARCHAR(20) CONSTRAINT degree_name_nn NOT NULL);

CREATE TABLE department( department_id NUMERIC(3) IDENTITY(1,1) CONSTRAINT department_pk PRIMARY KEY,
                            department_name VARCHAR(60) CONSTRAINT department_name_nn NOT NULL,
                            faculty_no NUMERIC(2),
                            degree_no NUMERIC(1),
                            CONSTRAINT department_faculty_fk FOREIGN KEY( faculty_no) REFERENCES faculty( faculty_id),
                            CONSTRAINT department_degree_fk FOREIGN KEY( degree_no) REFERENCES degree( degree_id));

CREATE TABLE curriculum( department_no NUMERIC(3) CONSTRAINT department_no_nn NOT NULL,
                            course_no NUMERIC(10) CONSTRAINT course_no_nn NOT NULL,
                            CONSTRAINT curriculum_course_fk FOREIGN KEY( course_no) REFERENCES course( course_id),
                            CONSTRAINT curriculum_department_fk FOREIGN KEY( department_no) REFERENCES department( department_id));

CREATE TABLE title( title_id NUMERIC(1) IDENTITY(1,1) CONSTRAINT title_pk PRIMARY KEY,
                        title_name VARCHAR(20) CONSTRAINT title_name_nn NOT NULL);

CREATE TABLE people( person_id NUMERIC(10) IDENTITY(1,1) CONSTRAINT people_pk PRIMARY KEY,
                        name VARCHAR(20) CONSTRAINT name_nn NOT NULL,
                        last_name VARCHAR(20) CONSTRAINT last_name_nn NOT NULL,
                        email VARCHAR(50),
                        phone VARCHAR(15),
                        gpa NUMERIC(3,2) CONSTRAINT gpa_ck CHECK ( gpa >= 0 and gpa <= 4),
                        title_no NUMERIC(1),
                        department_no NUMERIC(3),
                        CONSTRAINT people_title_fk FOREIGN KEY( title_no) REFERENCES title( title_id),
                        CONSTRAINT student_department_fk FOREIGN KEY( department_no) REFERENCES department( department_id));

CREATE TABLE section_info( section_id NUMERIC(10) IDENTITY(1,1) CONSTRAINT section_info_pk PRIMARY KEY,
                            course_no NUMERIC(10),
                            section_no NUMERIC(2) CONSTRAINT section_no_nn NOT NULL,
                            teacher_no NUMERIC(10),
                            class_no NUMERIC(7),
                            CONSTRAINT section_course_fk FOREIGN KEY( course_no) REFERENCES course( course_id),
                            CONSTRAINT section_teacher_fk FOREIGN KEY( teacher_no) REFERENCES people( person_id),
                            CONSTRAINT section_class_fk FOREIGN KEY( class_no) REFERENCES classroom( class_id));

CREATE TABLE section( section_no NUMERIC(10) CONSTRAINT section_id_nn NOT NULL,
                        student_no NUMERIC(10),
                        CONSTRAINT section_info_fk FOREIGN KEY( section_no) REFERENCES section_info( section_id),
                        CONSTRAINT section_student_fk FOREIGN KEY( student_no) REFERENCES people( person_id));
                    

CREATE TABLE entries( entry_no NUMERIC(15) IDENTITY(1,1) CONSTRAINT entry_pk PRIMARY KEY,
                        person_no NUMERIC(10) CONSTRAINT person_no_nn NOT NULL,
                        building_no NUMERIC(5) CONSTRAINT building_no_nn NOT NULL,
                        entry_time DATETIME DEFAULT CURRENT_TIMESTAMP,
                        CONSTRAINT entry_person_fk FOREIGN KEY( person_no) REFERENCES people( person_id),
                        CONSTRAINT entry_building_fk FOREIGN KEY( building_no) REFERENCES building( building_id));