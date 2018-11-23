USE [master]
ALTER DATABASE [dummydb] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
RESTORE DATABASE [dummydb] FROM  URL = N'https://sqlserverbackup101.blob.core.windows.net/sqlsat2018/Non_encrypted_d1_backup_20181123110234.bak'
WITH  CREDENTIAL = N'[https://sqlserverbackup101.blob.core.windows.net/sqlsat2018]'
,  FILE = 1,  NOUNLOAD,  STATS = 5
ALTER DATABASE [dummydb] SET MULTI_USER
GO
--OUTPUT


