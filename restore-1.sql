USE [master]
ALTER DATABASE [dummydb] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
RESTORE DATABASE [dummydb] FROM  URL = N'https://sqlserverbackup101.blob.core.windows.net/sqlsat2018/Non_encrypted_d1_backup_20181123110234.bak'
WITH  FILE = 1,  NOUNLOAD,  STATS = 5, REPLACE
ALTER DATABASE [dummydb] SET MULTI_USER
GO
--OUTPUT


