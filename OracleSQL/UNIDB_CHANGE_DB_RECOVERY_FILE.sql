alter system set db_recovery_file_dest_size= 2G;

show parameter db_recovery;

select SPACE_USED/1024/1024/1024 "SPACE_USED(GB)" ,SPACE_LIMIT/1024/1024/1024 "SPACE_LIMIT(GB)" from  v$recovery_file_dest;

alter system set db_recovery_file_dest_size= 4G;
