-- Temp tablespace resize
ALTER TABLESPACE temp
    ADD TEMPFILE '/home/oracle/app/oracle/oradata/UNIDB/temp02.dbf'
    SIZE 500M
    AUTOEXTEND OFF;
ALTER TABLESPACE temp
    DROP TEMPFILE '/home/oracle/app/oracle/oradata/UNIDB/temp01.dbf';
ALTER TABLESPACE temp
    ADD TEMPFILE '/home/oracle/app/oracle/oradata/UNIDB/temp01.dbf'
    SIZE 512M
    AUTOEXTEND ON
    MAXSIZE 8G;
ALTER TABLESPACE temp
    DROP TEMPFILE '/home/oracle/app/oracle/oradata/UNIDB/temp02.dbf';
ALTER TABLESPACE temp
    SHRINK SPACE KEEP 0M;
ALTER TABLESPACE temp
    ADD TEMPFILE '/home/oracle/app/oracle/oradata/UNIDB/temp01.dbf'
    SIZE 8G
    AUTOEXTEND OFF;

-- List tempfile sessions
select 
su.INST_ID, su.username, se.sid, se.SERIAL#, tf.FILE#, tf.NAME, tf.STATUS
from gv$sort_usage su
, v$tempfile tf
, GV$SESSION se
where su.SEGRFNO# = tf.FILE#
and se.INST_ID = su.INST_ID
and se.SADDR = su.SESSION_ADDR
order by tf.file#
;

-- List datafiles
SELECT  file_name, blocks, tablespace_name FROM dba_data_files;
-- List tempfiles
SELECT * from v$tempfile;
-- Free temp space
SELECT * from DBA_TEMP_FREE_SPACE;
-- Database size
SELECT SUM (bytes)/1024/1024/1024 AS GB FROM dba_segments;
-- List tablespace names
SELECT * from user_tablespaces;
-- Free database size
SELECT * from dba_free_space;

-- Undo tablespace resize
CREATE UNDO TABLESPACE undotbs2 DATAFILE '/home/oracle/app/oracle/oradata/UNIDB/undotbs02.dbf' SIZE 2G AUTOEXTEND OFF;
ALTER SYSTEM SET undo_tablespace = undotbs2;
DROP TABLESPACE undotbs1 INCLUDING CONTENTS AND DATAFILES;
CREATE UNDO TABLESPACE undotbs1 DATAFILE '/home/oracle/app/oracle/oradata/UNIDB/undotbs01.dbf'
    SIZE 512M
    AUTOEXTEND ON
    MAXSIZE 5G;
ALTER SYSTEM SET undo_tablespace = undotbs1;
DROP TABLESPACE undotbs2 INCLUDING CONTENTS AND DATAFILES;



-- ALKIMDATA
CREATE UNDO TABLESPACE undotbs2 DATAFILE '/home/oracle/app/oracle/oradata/ALKIMDATA/undotbs02.dbf' SIZE 512M AUTOEXTEND OFF;
ALTER SYSTEM SET undo_tablespace = undotbs2;
DROP TABLESPACE undotbs1 INCLUDING CONTENTS AND DATAFILES;
CREATE UNDO TABLESPACE undotbs1 DATAFILE '/home/oracle/app/oracle/oradata/ALKIMDATA/undotbs01.dbf'
    SIZE 512M
    AUTOEXTEND ON
    MAXSIZE 5G;
ALTER SYSTEM SET undo_tablespace = undotbs1;
DROP TABLESPACE undotbs2 INCLUDING CONTENTS AND DATAFILES;

ALTER TABLESPACE temp
    ADD TEMPFILE '/home/oracle/app/oracle/oradata/ALKIMDATA/temp02.dbf'
    SIZE 512M
    AUTOEXTEND OFF;
ALTER TABLESPACE temp
    DROP TEMPFILE '/home/oracle/app/oracle/oradata/ALKIMDATA/temp01.dbf';
ALTER TABLESPACE temp
    ADD TEMPFILE '/home/oracle/app/oracle/oradata/ALKIMDATA/temp01.dbf'
    SIZE 512M
    AUTOEXTEND ON
    MAXSIZE 8G;
ALTER TABLESPACE temp
    DROP TEMPFILE '/home/oracle/app/oracle/oradata/ALKIMDATA/temp02.dbf';