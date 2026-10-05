/*
=======================================================================================
Stored Procedure: Load Bronze Layer (source -> Bronze)
========================================================================================
Script Purpose:
  This stored procedure loads data into the 'bronze' schema from external CSV files.
  It perform the following actions:
-truncates the Bronze tabels before loading data
-Uses the 'BULK Inserts' command to load data from CSV files to bronze tables.

Parameters:
None.
This  stored procedure does not accept any parameters or return any values.

Usage Example:
  EXEC bronze.load_bronze;
===================================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN	
	DECLARE @start_time DATETIME,  @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		PRINT '=========================================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '=========================================================================';

		PRINT '---------------------------------------------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '---------------------------------------------------------------------------';

		SET @batch_start_time = GETDATE();
		PRINT '>> TRUNCATING TABLE : bronze.crm_cust_info' ;
		TRUNCATE TABLE bronze.crm_cust_info;
		PRINT '>> INSERTING DATA INTO : bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\manis\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT '>> LOAD DURATION : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '>> ----------------';

		SET @start_time = GETDATE();
		PRINT '>> TRUNCATING TABLE : bronze.crm_prd_info'; 
		TRUNCATE TABLE bronze.crm_prd_info;
		PRINT '>> INSERTING DATA  : bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\manis\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '>> -----------------------';

		SET @start_time = GETDATE();
		PRINT '>> TRUNCATING TABLE : bronze.crm_sales_details'; 
		TRUNCATE TABLE bronze.crm_sales_details;
		PRINT '>> INSERTING DATA : bronze.crm_sales_details'; 
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\manis\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT'>> LOAD DURATION: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '>> --------------------';

		PRINT '---------------------------------------------------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '---------------------------------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> TRUNCATING TABLE : bronze.erp_loc_a101'; 
		TRUNCATE TABLE bronze.erp_loc_a101;
		PRINT '>> INSERTING DATA : bronze.erp_loc_a101' ;
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\manis\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT '>> LOAD DURATION : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT ' >> --------------------';

		SET @start_time = GETDATE();
		PRINT '>> TRUNCATING TABLE : bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;
		PRINT '>> INSERTING DATA : bronze.erp_cust_az12' ;
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\manis\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK 
		);	
		SET @end_time = GETDATE();
		PRINT '>> LOAD DURATION : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT ' >> --------------------';

		SET @start_time = GETDATE();
		PRINT '>> TRUNCATING TABLE : bronze.erp_px_cat_g1v2'; 
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		PRINT '>> INSERTING DATA : bronze.erp_px_cat_g1v2' ;
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\manis\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK 
		);
		SET @batch_end_time = GETDATE();
		PRINT '>> ======================================================='
		PRINT 'Loading Bronze Layer is completed';
		PRINT'>> TOTAL LOAD DURATION: ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + 'seconds';
		PRINT '>> ========================================================='

	END TRY
	BEGIN CATCH
	PRINT '===================================================='
	PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
	PRINT 'Error Message' + Error_Message();
	PRINT 'ERROR Message' + CAST (Error_NUmber() As NVARCHAR);
			PRINT 'ERROR MESSAGE' + CAST (ERROR_NUMBER() AS NVARCHAR);
	PRINT '===================================================='

	END CATCH
END
Go
EXEC bronze.load_bronze
Go
	
