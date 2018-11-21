-- Creates a database master key.
-- The key is encrypted using the password "Bangladesh@1"

--DECLARE @NON_ENCRYTEPD_FILE_NAME varchar(1000)
--DECLARE @ENCRYPTED_FILE_NAME varchar(1000)

--SET @NON_ENCRYPTED_FILE_NAME = (select  'https://sqlserverbackup101.blob.core.windows.net/sqlsat2018Non_encrypted_backup_' + convert(varchar(500),GetDate(),112) + '.bak')
--SET @ENCRYPTED_FILE_NAME = (select  'https://sqlserverbackup101.blob.core.windows.net/sqlsat2018Encrypted_backup_' + convert(varchar(500),GetDate(),112) + '.bak')

--PRINT @NON_ENCRYPTED_FILE_NAME
--PRINT @ENCRYPTED_FILE_NAME


USE master;
GO

IF NOT EXISTS(select 1 from sys.symmetric_keys where name like '%DatabaseMasterKey%')
BEGIN
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Bangladesh@1';
END
GO


--IF NOT EXISTS(select * from sys.certificates where name = 'SqlSatDemoCert')
BEGIN
CREATE CERTIFICATE SqlSatDemoCert
   WITH SUBJECT = 'MyTestDB Backup Encryption Certificate';
END
GO

CREATE CREDENTIAL [https://sqlserverbackup101.blob.core.windows.net/sqlsat2018] 
WITH IDENTITY = 'SHARED ACCESS SIGNATURE', 
SECRET = 'sv=2017-11-09&ss=bfqt&srt=sco&sp=rwdlacup&se=2018-11-29T18:29:29Z&st=2018-11-20T10:29:29Z&spr=https,http&sig=HEksfHTacMv2ur9Cbud9W5RC0y2w1V%2BS0hQY%2FVhvlvM%3D'
GO


---------------Backup the database with compressed encryption---------------
BACKUP DATABASE [dummydb]
TO  URL = N'https://sqlserverbackup101.blob.core.windows.net/sqlsat2018/d1_backup_2018_21_1.bak' 
--TO URL = @ENCRYPTED_FILE_NAME
WITH
  COMPRESSION,
  ENCRYPTION
   (
   ALGORITHM = AES_256,
   SERVER CERTIFICATE = SqlSatDemoCert
   ),
  STATS = 10
GO  

use master;
---------------------Backup the database without compression and encryption---------------
BACKUP DATABASE [dummydb]
TO  URL = N'https://sqlserverbackup101.blob.core.windows.net/sqlsat2018/NOEncrypt_d1_backup_2018_21_1.bak' 
--TO URL = @NON_ENCRYPTED_FILE_NAME
GO
