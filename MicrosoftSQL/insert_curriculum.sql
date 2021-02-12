INSERT INTO curriculum( department_no, course_no)
	( SELECT d.column1, a.course_id FROM course a, UNIDB_CURRICULUM_DATA d
		WHERE a.course_code = d.column2
	);