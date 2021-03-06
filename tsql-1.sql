-- Creates a database master key.
-- The key is encrypted using the password "Bangladesh@1"

USE master;

IF NOT EXISTS(select 1 from sys.symmetric_keys where name like '%DatabaseMasterKey%')
BEGIN
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Bangladesh@1';
END

IF NOT EXISTS(select 1 from sys.certificates where name = 'SqlSatDemoCert')
BEGIN
CREATE CERTIFICATE SqlSatDemoCert
   WITH SUBJECT = 'MyTestDB Backup Encryption Certificate';
END

--CREATE CREDENTIAL [https://sqlserverbackup101.blob.core.windows.net/sqlsat2018] 
--WITH IDENTITY = 'SHARED ACCESS SIGNATURE', 
--SECRET = 'sv=2017-11-09&ss=bfqt&srt=sco&sp=rwdlacup&se=2018-11-29T18:29:29Z&st=2018-11-20T10:29:29Z&spr=https,http&sig=HEksfHTacMv2ur9Cbud9W5RC0y2w1V%2BS0hQY%2FVhvlvM%3D'


---------------Backup the database with compressed encryption---------------
DECLARE @backupfile_with_e nvarchar(2000)
SET @backupfile_with_e = N'https://sqlserverbackup101.blob.core.windows.net/sqlsat2018/d1_backup_' + REPLACE(REPLACE(REPLACE(CONVERT(varchar,GETDATE(), 20),'-',''),':',''),' ','') + N'.bak'

BACKUP DATABASE [dummydb] 
TO URL = @backupfile_with_e

WITH
  COMPRESSION,
  ENCRYPTION
   (
   ALGORITHM = AES_256,
   SERVER CERTIFICATE = SqlSatDemoCert
   ),
  STATS = 5

---------------------Backup the database without compression and encryption---------------
DECLARE @backupfile_no_e nvarchar(2000)
SET @backupfile_no_e = N'https://sqlserverbackup101.blob.core.windows.net/sqlsat2018/Non_encrypted_d1_backup_' + REPLACE(REPLACE(REPLACE(CONVERT(varchar,GETDATE(), 20),'-',''),':',''),' ','') + N'.bak'

BACKUP DATABASE [dummydb] 
TO URL = @backupfile_no_e
WITH
  COMPRESSION,
  STATS = 5
GO
