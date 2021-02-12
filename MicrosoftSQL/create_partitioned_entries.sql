ALTER DATABASE UNIDB ADD FILEGROUP [2019M9];
ALTER DATABASE UNIDB ADD FILEGROUP [2019M8];
ALTER DATABASE UNIDB ADD FILEGROUP [2019M7];
ALTER DATABASE UNIDB ADD FILEGROUP [2019M6];
ALTER DATABASE UNIDB ADD FILEGROUP [2019M5];
ALTER DATABASE UNIDB ADD FILEGROUP [2019M4];

ALTER DATABASE UNIDB
ADD FILE 
  (NAME = N'2019M8',
  FILENAME = N'D:\My SQL Server\MSSQL14.MSSQLSERVER\2019M8.ndf',
  SIZE = 50MB,
  MAXSIZE = 75MB,
  FILEGROWTH = 5MB)
TO FILEGROUP [2019M8];

ALTER DATABASE UNIDB
ADD FILE 
  (NAME = N'2019M7',
  FILENAME = N'D:\My SQL Server\MSSQL14.MSSQLSERVER\2019M7.ndf',
  SIZE = 50MB,
  MAXSIZE = 75MB,
  FILEGROWTH = 5MB)
TO FILEGROUP [2019M7];

ALTER DATABASE UNIDB
ADD FILE 
  (NAME = N'2019M6',
  FILENAME = N'D:\My SQL Server\MSSQL14.MSSQLSERVER\2019M6.ndf',
  SIZE = 50MB,
  MAXSIZE = 75MB,
  FILEGROWTH = 5MB)
TO FILEGROUP [2019M6];

ALTER DATABASE UNIDB
ADD FILE 
  (NAME = N'2019M5',
  FILENAME = N'D:\My SQL Server\MSSQL14.MSSQLSERVER\2019M5.ndf',
  SIZE = 50MB,
  MAXSIZE = 75MB,
  FILEGROWTH = 5MB)
TO FILEGROUP [2019M5];

ALTER DATABASE UNIDB
ADD FILE 
  (NAME = N'2019M4',
  FILENAME = N'D:\My SQL Server\MSSQL14.MSSQLSERVER\2019M4.ndf',
  SIZE = 50MB,
  MAXSIZE = 75MB,
  FILEGROWTH = 5MB)
TO FILEGROUP [2019M4];

ALTER DATABASE UNIDB
ADD FILE 
  (NAME = N'2019M9',
  FILENAME = N'D:\My SQL Server\MSSQL14.MSSQLSERVER\2019M9.ndf',
  SIZE = 50MB,
  MAXSIZE = 75MB,
  FILEGROWTH = 5MB)
TO FILEGROUP [2019M9];

CREATE PARTITION FUNCTION OrderDateRangePFN( datetime)
AS 
RANGE LEFT FOR VALUES ('20190430 23:59:59.997',
						'20190531 23:59:59.997',
						'20190630 23:59:59.997',
						'20190731 23:59:59.997',
						'20190831 23:59:59.997');

CREATE PARTITION SCHEME OrderDatePS 
AS 
PARTITION OrderDateRangePFN 
TO ([2019M4], [2019M5], [2019M6], [2019M7], [2019M8], [2019M9]);

CREATE TABLE entries( entry_no NUMERIC(15) IDENTITY(1,1),
                        person_no NUMERIC(10) CONSTRAINT person_no_nn NOT NULL,
                        building_no NUMERIC(5) CONSTRAINT building_no_nn NOT NULL,
                        entry_time DATETIME DEFAULT CURRENT_TIMESTAMP,
                        CONSTRAINT entry_person_fk FOREIGN KEY( person_no) REFERENCES people( person_id),
                        CONSTRAINT entry_building_fk FOREIGN KEY( building_no) REFERENCES building( building_id))
						ON OrderDatePS( entry_time);