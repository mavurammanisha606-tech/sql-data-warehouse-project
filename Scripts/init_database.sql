/* 
-------------
create a database and schemas
----------------
scripts purpose:
This scripts create a new database named 'Datawarehouse' after checking if it already exists.
if the database  exists, it is dropping and recreated. Additionally, the script sets up three schemas within the databse: 'Bronze', 'Silver', 'Gold'.
WARNING :
Running this script will drop the entire "datawarehouse' database if it exists.
All data in the database will be permanently deleted. Proceed with caution and ensure you have proper backup before running this script.
*/

USE master;
Go
  
---create the 'dataWarehouse database
CREATE DATABASE DataWarehouse;
Go
  
USE DataWarehouse;
Go

----create Schemas 
CREATE SCHEMA bronze;
Go
  
CREATE SCHEMA Silver;
Go
  
CREATE SCHEMA Gold;
Go
