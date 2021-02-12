/*SELECT COUNT(*) FROM people;
SELECT COUNT(*) FROM building;

SELECT top (1) person_id FROM people ORDER BY person_id;
SELECT top (1) person_id FROM people ORDER BY person_id desc;
SELECT top (1) building_id FROM building ORDER BY building_id;
SELECT top (1) building_id FROM building ORDER BY building_id desc;*/

EXEC ADD_ENTRIES @noOfPeople = 147992, @noOfBuildings = 100;
select count(*) from entries;