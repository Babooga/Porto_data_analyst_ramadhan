-- 1. crm_cust_info
create table bronze.crm_cust_info (
	cst_id int,
	cst_key nvarchar(50),
	cst_firstname nvarchar(50),
	cst_lastname nvarchar(50),
	cst_material_status nvarchar(50),
	cst_gndr nvarchar(50),
	cst_create_date date
);
truncate table bronze.crm_cust_info;
bulk insert bronze.crm_cust_info
from 'd:\data analyst\data with bara\sql-data-warehouse-project-main\datasets\source_crm\cust_info.csv'
with (
    firstrow = 2,
    fieldterminator = ',',
    tablock
);

-- 2. crm_prd_info
create table silver.crm_prd_info(
	prd_id int,
	prd_key nvarchar(50),
	prd_nm nvarchar(50),
	prd_cost int,
	prd_line nvarchar(50),
	prd_start_dt datetime,
	prd_end_dt datetime
);
truncate table bronze.crm_prd_info;
bulk insert bronze.crm_prd_info
from 'd:\data analyst\data with bara\sql-data-warehouse-project-main\datasets\source_crm\prd_info.csv'
with (
    firstrow = 2,
    fieldterminator = ',',
    tablock
);

-- 3. crm_sales_details
create table silver.crm_sales_details (
	sls_ord_num nvarchar(50),
	sls_prd_key nvarchar(50),
	sls_cust_id int,
	sls_order_dt int,
	sls_ship_dt int,
	sls_dur_dt int,
	sls_sales int,
	sls_quantity int,
	sls_price int
);
truncate table bronze.crm_sales_details;
bulk insert bronze.crm_sales_details
from 'd:\data analyst\data with bara\sql-data-warehouse-project-main\datasets\source_crm\sales_details.csv'
with (
    firstrow = 2,
    fieldterminator = ',',
    tablock
);

-- 4. erp_cust_az12
create table silver.erp_cust_az12 (
	cid nvarchar(50),
	bdate date,
	gen nvarchar(50)
);
truncate table bronze.erp_cust_az12;
bulk insert bronze.erp_cust_az12
from 'd:\data analyst\data with bara\sql-data-warehouse-project-main\datasets\source_erp\cust_az12.csv'
with (
    firstrow = 2,
    fieldterminator = ',',
    tablock
);

-- 5. erp_loc_a101
create table silver.erp_loc_a101 (
	cid nvarchar(50),
	cntry nvarchar(50)
);
truncate table bronze.erp_loc_a101;
bulk insert bronze.erp_loc_a101
from 'd:\data analyst\data with bara\sql-data-warehouse-project-main\datasets\source_erp\loc_a101.csv'
with (
    firstrow = 2,
    fieldterminator = ',',
    tablock
);

-- 6. erp_px_cat_g1v2
create table silver.erp_px_cat_g1v2 (
	id nvarchar(50),
	cat nvarchar(50),
	subcat nvarchar(50),
	maintenance nvarchar(50)
);
truncate table bronze.erp_px_cat_g1v2;
bulk insert bronze.erp_px_cat_g1v2
from 'd:\data analyst\data with bara\sql-data-warehouse-project-main\datasets\source_erp\px_cat_g1v2.csv'
with (
    firstrow = 2,
    fieldterminator = ',',
    tablock
);