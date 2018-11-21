-- Creates a database master key.   
-- The key is encrypted using the password "<master key password>"  
USE master;  
GO  
CREATE MASTER KEY ENCRYPTION BY PASSWORD = '<master key password>';  
GO

Use Master  
GO  
CREATE CERTIFICATE asd  
   WITH SUBJECT = 'MyTestDB Backup Encryption Certificate';  
GO 
---------------Backup the database with compressed encryption---------------
BACKUP DATABASE asd  
TO DISK = N'D:\BackupTest_with_Encryption.bak'  
WITH  
  COMPRESSION,  
  ENCRYPTION   
   (  
   ALGORITHM = AES_256,  
   SERVER CERTIFICATE = MyTestDBBackupEncryptCert  
   ),  
  STATS = 10  
GO  

---------------------Backup the database without compression and encryption---------------
BACKUP DATABASE asd 
TO DISK = 'D:\BackupTest_with_Noencryption.bak';
GO