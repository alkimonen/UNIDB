-- a.En çok giriþ çýkýþ yapan personel
SELECT person_id, name, last_name, title_name
    FROM people
    LEFT OUTER JOIN title
    ON people.title_no = title.title_id
    WHERE person_id = ( SELECT person_no
                            FROM ( SELECT person_no, count(*)
                                        FROM entries
                                        GROUP BY person_no
                                        HAVING person_no IN ( SELECT person_id
                                                                    FROM people
                                                                    WHERE title_no IN ( SELECT title_id
                                                                                            FROM title
                                                                                            WHERE title_name IN( 'Rector',
                                                                                                                'Dean',
                                                                                                                'Teacher')))
                                        ORDER BY count(*) DESC)
                            WHERE rownum = 1);
                            
SELECT a.person_no, p.name, p.last_name, title_name
    FROM ( SELECT person_no
                FROM ( SELECT person_no, count(*)
                            FROM entries
                            GROUP BY person_no
                            HAVING person_no IN ( SELECT person_id
                                                    FROM people
                                                    WHERE title_no IN ( SELECT title_id
                                                                            FROM title
                                                                             WHERE title_name IN( 'Rector',
                                                                                                  'Dean',
                                                                                                  'Teacher')))
                            ORDER BY count(*) DESC)
                WHERE rownum = 1) a
    LEFT OUTER JOIN people p
    ON a.person_no = p.person_id
    LEFT OUTER JOIN title t
    ON p.title_no = t.title_id;
    
-- b.En uzun süre içeride kalan personel
SELECT person_id, name, last_name, title_name
    FROM people
    LEFT OUTER JOIN title
    ON people.title_no = title.title_id
    WHERE person_id = ( SELECT person_no
                            FROM ( SELECT curr.entry_no, curr.person_no, ( to_timestamp( curr.entry_time) - to_timestamp( prev.entry_time)) time_difference
                                        FROM entries prev
                                        INNER JOIN entries curr
                                        ON curr.entry_no = prev.entry_no + 1
                                        WHERE prev.direction = 'IN'
                                        ORDER BY time_difference DESC)
                            WHERE person_no IN ( SELECT person_id
                                                                    FROM people
                                                                    WHERE title_no IN ( SELECT title_id
                                                                                            FROM title
                                                                                            WHERE title_name IN( 'Rector',
                                                                                                                'Dean',
                                                                                                                'Teacher')))
                            AND rownum = 1);

SELECT p.person_id, p.name, p.last_name, t.title_name, a.time_difference
    FROM ( SELECT person_no, time_difference
                FROM ( SELECT curr.entry_no, curr.person_no, ( to_timestamp( curr.entry_time) - to_timestamp( prev.entry_time)) time_difference
                            FROM entries prev
                            INNER JOIN entries curr
                            ON curr.entry_no = prev.entry_no + 1
                            WHERE prev.direction = 'IN'
                            ORDER BY time_difference DESC)
                WHERE person_no IN ( SELECT person_id
                                                        FROM people
                                                        WHERE title_no IN ( SELECT title_id
                                                                                FROM title
                                                                                WHERE title_name IN( 'Rector',
                                                                                                    'Dean',
                                                                                                    'Teacher')))
                            AND rownum = 1) a
    LEFT OUTER JOIN people p
    ON a.person_no = p.person_id
    LEFT OUTER JOIN title t
    ON p.title_no = t.title_id;


-- c.Aylara göre ortalama içeride kalma süreleri
SELECT  month, to_char( to_date( ROUND( AVG( time_difference)), 'sssss'), 'hh24:mi:ss') average_time_spended
    FROM ( SELECT to_char( TRUNC( prev.entry_time, 'MM'), 'YYYY/MM') month,
                ( to_date( to_char( curr.entry_time, 'DD/MM/YYYY hh24:mi:ss'), 'DD/MM/YYYY hh24:mi:ss')
                    - to_date( to_char( prev.entry_time, 'DD/MM/YYYY hh24:mi:ss'), 'DD/MM/YYYY hh24:mi:ss'))*24*60*60 time_difference
            FROM entries prev
            INNER JOIN entries curr
            ON curr.entry_no = prev.entry_no + 1
            WHERE prev.direction = 'IN')
    GROUP BY month
    ORDER BY month;

-- d.En çok giriþ çýkan yapan öðrenci
SELECT person_id, name, last_name, title_name
    FROM people
    LEFT OUTER JOIN title
    ON people.title_no = title.title_id
    WHERE person_id = ( SELECT person_no
                            FROM ( SELECT person_no, count(*)
                                        FROM entries
                                        GROUP BY person_no
                                        HAVING person_no IN ( SELECT person_id
                                                                    FROM people
                                                                    WHERE title_no IN ( SELECT title_id
                                                                                            FROM title
                                                                                            WHERE title_name IN( 'Doctorate Student',
                                                                                                                'Master''s Student',
                                                                                                                'Student')))
                                        ORDER BY count(*) DESC)
                            WHERE rownum = 1);

SELECT a.person_no, p.name, p.last_name, title_name
    FROM ( SELECT person_no
                FROM ( SELECT person_no, count(*)
                            FROM entries
                            GROUP BY person_no
                            HAVING person_no IN ( SELECT person_id
                                FROM people
                                WHERE title_no IN ( SELECT title_id
                                    FROM title
                                     WHERE title_name IN( 'Doctorate Student',
                                                            'Master''s Student',
                                                            'Student')))
                            ORDER BY count(*) DESC)
                WHERE rownum = 1) a
    LEFT OUTER JOIN people p
    ON a.person_no = p.person_id
    LEFT OUTER JOIN title t
    ON p.title_no = t.title_id;

-- e.En uzun süre içeride kalan öðrenci
SELECT person_id, name, last_name, title_name
    FROM people
    LEFT OUTER JOIN title
    ON people.title_no = title.title_id
    WHERE person_id = ( SELECT person_no
                            FROM ( SELECT curr.entry_no, curr.person_no, ( to_timestamp( curr.entry_time) - to_timestamp( prev.entry_time)) time_difference
                                        FROM entries prev
                                        INNER JOIN entries curr
                                        ON curr.entry_no = prev.entry_no + 1
                                        WHERE prev.direction = 'IN'
                                        ORDER BY time_difference DESC) a
                            LEFT OUTER JOIN ( SELECT person_id
                                                    FROM people
                                                    WHERE title_no IN ( SELECT title_id
                                                                            FROM title
                                                                            WHERE title_name IN( 'Doctorate Student',
                                                                                                'Master''s Student',
                                                                                                'Student'))) b
                            ON a.person_no = b.person_id
                            WHERE rownum = 1);

SELECT p.person_id, p.name, p.last_name, t.title_name, a.time_difference
    FROM ( SELECT person_no, time_difference
                FROM ( SELECT curr.entry_no, curr.person_no, ( to_timestamp( curr.entry_time) - to_timestamp( prev.entry_time)) time_difference
                            FROM entries prev
                            INNER JOIN entries curr
                            ON curr.entry_no = prev.entry_no + 1
                            WHERE prev.direction = 'IN'
                            ORDER BY time_difference DESC)
                WHERE person_no IN ( SELECT person_id
                                                        FROM people
                                                        WHERE title_no IN ( SELECT title_id
                                                                                FROM title
                                                                                WHERE title_name IN( 'Doctorate Student',
                                                                                                    'Master''s Student',
                                                                                                    'Student')))
                            AND rownum = 1) a
    LEFT OUTER JOIN people p
    ON a.person_no = p.person_id
    LEFT OUTER JOIN title t
    ON p.title_no = t.title_id;

-- f.Bir gün içerisinde en fazla giriþ-çýkýþ yapan öðrenci ve personel
SELECT person_id, name, last_name, title_name
    FROM people
    LEFT OUTER JOIN title
    ON people.title_no = title.title_id
    WHERE person_id IN( ( SELECT person_no
                            FROM ( SELECT person_no, count(*)
                                        FROM entries
                                        WHERE entry_time
                                            BETWEEN to_timestamp( '05/05/2019', 'DD/MM/YYYY')
                                            AND to_timestamp( '06/05/2019', 'DD/MM/YYYY')
                                        GROUP BY person_no
                                        HAVING person_no IN ( SELECT person_id
                                                                    FROM people
                                                                    WHERE title_no IN ( SELECT title_id
                                                                                            FROM title
                                                                                            WHERE title_name IN( 'Doctorate Student',
                                                                                                                'Master''s Student',
                                                                                                                'Student')))
                                        ORDER BY count(*) DESC)
                            WHERE rownum = 1),
                            ( SELECT person_no
                            FROM ( SELECT person_no, count(*)
                                        FROM entries
                                        WHERE entry_time
                                            BETWEEN to_timestamp( '01/05/2019', 'DD/MM/YYYY')
                                            AND to_timestamp( '02/05/2019', 'DD/MM/YYYY')
                                        GROUP BY person_no
                                        HAVING person_no IN ( SELECT person_id
                                                                    FROM people
                                                                    WHERE title_no IN ( SELECT title_id
                                                                                            FROM title
                                                                                            WHERE title_name IN( 'Rector',
                                                                                                                'Dean',
                                                                                                                'Teacher')))
                                        ORDER BY count(*) DESC)
                            WHERE rownum = 1));

SELECT p.person_id, p.name, p.last_name, t.title_name, a.total "Count"
    FROM ( SELECT person_no, total
            FROM (( SELECT person_no, total
                            FROM ( SELECT person_no, count(*) total
                                        FROM entries
                                        WHERE entry_time
                                            BETWEEN to_timestamp( '01/05/2019', 'DD/MM/YYYY')
                                            AND to_timestamp( '02/05/2019', 'DD/MM/YYYY')
                                        GROUP BY person_no
                                        HAVING person_no IN ( SELECT person_id
                                                                    FROM people
                                                                    WHERE title_no IN ( SELECT title_id
                                                                                            FROM title
                                                                                            WHERE title_name IN( 'Doctorate Student',
                                                                                                                'Master''s Student',
                                                                                                                'Student')))
                                        ORDER BY count(*) DESC)
                            WHERE rownum = 1)
                            UNION
                            ( SELECT person_no, total
                            FROM ( SELECT person_no, count(*) total
                                        FROM entries
                                        WHERE entry_time
                                            BETWEEN to_timestamp( '01/05/2019', 'DD/MM/YYYY')
                                            AND to_timestamp( '02/05/2019', 'DD/MM/YYYY')
                                        GROUP BY person_no
                                        HAVING person_no IN ( SELECT person_id
                                                                    FROM people
                                                                    WHERE title_no IN ( SELECT title_id
                                                                                            FROM title
                                                                                            WHERE title_name IN( 'Rector',
                                                                                                                'Dean',
                                                                                                                'Teacher')))
                                        ORDER BY count(*) DESC)
                            WHERE rownum = 1))) a
    LEFT OUTER JOIN people p
    ON a.person_no = p.person_id
    LEFT OUTER JOIN title t
    ON p.title_no = t.title_id;

-- g.A,b,d,e sorgusunu sadece bir aylýk partition için çalýþtýr
--a
SELECT a.person_no, p.name, p.last_name, title_name
    FROM ( SELECT person_no
                FROM ( SELECT person_no, count(*)
                            FROM entries PARTITION( entries_p7)
                            GROUP BY person_no
                            HAVING person_no IN ( SELECT person_id
                                FROM people
                                WHERE title_no IN ( SELECT title_id
                                    FROM title
                                     WHERE title_name IN( 'Rector',
                                                          'Dean',
                                                          'Teacher')))
                            ORDER BY count(*) DESC)
                WHERE rownum = 1) a
    LEFT OUTER JOIN people p
    ON a.person_no = p.person_id
    LEFT OUTER JOIN title t
    ON p.title_no = t.title_id;

--b
SELECT p.person_id, p.name, p.last_name, t.title_name, a.time_difference
    FROM ( SELECT person_no, time_difference
                FROM ( SELECT curr.entry_no, curr.person_no, ( to_timestamp( curr.entry_time) - to_timestamp( prev.entry_time)) time_difference
                            FROM entries PARTITION( entries_p7) prev
                            INNER JOIN entries  PARTITION( entries_p7) curr
                            ON curr.entry_no = prev.entry_no + 1
                            WHERE prev.direction = 'IN'
                            ORDER BY time_difference DESC)
                WHERE person_no IN ( SELECT person_id
                                                        FROM people
                                                        WHERE title_no IN ( SELECT title_id
                                                                                FROM title
                                                                                WHERE title_name IN( 'Rector',
                                                                                                    'Dean',
                                                                                                    'Teacher')))
                            AND rownum = 1) a
    LEFT OUTER JOIN people p
    ON a.person_no = p.person_id
    LEFT OUTER JOIN title t
    ON p.title_no = t.title_id;

--d
SELECT a.person_no, p.name, p.last_name, title_name
    FROM ( SELECT person_no
                FROM ( SELECT person_no, count(*)
                            FROM entries PARTITION( entries_p7)
                            GROUP BY person_no
                            HAVING person_no IN ( SELECT person_id
                                FROM people
                                WHERE title_no IN ( SELECT title_id
                                    FROM title
                                     WHERE title_name IN( 'Doctorate Student',
                                                            'Master''s Student',
                                                            'Student')))
                            ORDER BY count(*) DESC)
                WHERE rownum = 1) a
    LEFT OUTER JOIN people p
    ON a.person_no = p.person_id
    LEFT OUTER JOIN title t
    ON p.title_no = t.title_id;

--e
SELECT p.person_id, p.name, p.last_name, t.title_name, a.time_difference
    FROM ( SELECT person_no, time_difference
                FROM ( SELECT curr.entry_no, curr.person_no, ( to_timestamp( curr.entry_time) - to_timestamp( prev.entry_time)) time_difference
                            FROM entries PARTITION( entries_p7) prev
                            INNER JOIN entries PARTITION( entries_p7) curr
                            ON curr.entry_no = prev.entry_no + 1
                            WHERE prev.direction = 'IN'
                            ORDER BY time_difference DESC)
                WHERE person_no IN ( SELECT person_id
                                                        FROM people
                                                        WHERE title_no IN ( SELECT title_id
                                                                                FROM title
                                                                                WHERE title_name IN( 'Doctorate Student',
                                                                                                    'Master''s Student',
                                                                                                    'Student')))
                            AND rownum = 1) a
    LEFT OUTER JOIN people p
    ON a.person_no = p.person_id
    LEFT OUTER JOIN title t
    ON p.title_no = t.title_id;


SELECT subobject_name
    FROM user_objects
    WHERE data_object_id IN ( SELECT dbms_rowid.rowid_object(ROWID) data_object_id
                                   FROM entries
                                   WHERE entry_no IN ( SELECT entry_no
                                                            FROM ( SELECT MIN( entry_no) entry_no, to_char( TRUNC( entry_time, 'MM'), 'YYYY/MM')
                                                                FROM entries
                                                                GROUP BY to_char( TRUNC( entry_time, 'MM'), 'YYYY/MM')
                                                                ORDER BY to_char( TRUNC( entry_time, 'MM'), 'YYYY/MM'))));