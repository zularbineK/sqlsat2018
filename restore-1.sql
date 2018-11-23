USE [master]
ALTER DATABASE [dummydb] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
RESTORE DATABASE [dummydb] FROM  URL = N'https://raresql.blob.core.windows.net/sql-backup/AdventureWorks2012_25_Dec_2014.bak'
WITH  CREDENTIAL = N'[https://sqlserverbackup101.blob.core.windows.net/sqlsat2018]'
,  FILE = 1,  NOUNLOAD,  STATS = 5
ALTER DATABASE [dummydb] SET MULTI_USER
GO
--OUTPUT