## Repository Structure & Script Directory

All SQL scripts responsible for database initialization, data cleansing, and data warehouse modeling are organized within the `/scripts` directory. Below is the detailed breakdown of each script and its role in the ETL pipeline:

### 1. Database Initialization
* **`1.init_database.sql`**
  * **Purpose:** Sets up the foundational environment by creating the core `DataWarehouse` database.
  * **Details:** It establishes three distinct database schemas reflecting the Medallion Architecture: `bronze`, `silver`, and `gold`.

### 2. Ingestion Layer bronze
* **`2.ddl_extract_bronze_layer.sql`**
  * **Purpose:** Defines the structure of the ingestion tables and extracts raw data from the `.csv` source files.
  * **Details:** Creates 6 staging tables under the `bronze` schema and uses SQL `BULK INSERT` commands to efficiently load raw dataset files from both CRM and ERP sources.

### 3. Transformation Layer (Transform & Cleanse)
* **`3.ddl_ETL_silver_layer.sql`**
  * **Purpose:** Handles the core data quality management, deduplication, and complex business transformations required to move data from a raw state into a trusted, analytics-ready format.
  * **Details:** It builds structured tables under the `silver` schema and populates them using defensive SQL logic to tackle the following critical data quality issues found in the raw datasets:
    
    * **Data Cleansing & Text Standardizations:** * Uses `TRIM()` to eliminate accidental leading and trailing whitespaces from critical text fields like customer names (`cst_firstname`, `cst_lastname`).
      * Utilizes string manipulation functions such as `REPLACE()`, `SUBSTRING()`, and `LEN()` to strip out unwanted characters, dashes, and system prefixes (e.g., handling keys formatted like `NAS-` or extracting sub-components from composite keys).
    
    * **Advanced Deduplication & Historical Snapshotting:** * Employs Window Functions via `ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC)` to identify and extract only the latest customer records, effectively removing operational duplicates.
      * Implements analytical Lead/Lag logic using `LEAD() OVER (PARTITION BY prd_key ORDER BY prd_start_dt)` to establish dynamically calculated product effective date boundaries (`prd_end_dt`), forming a foundational layout for tracking historical changes.
    
    * **Defensive Data Guardrails & Error Prevention:**
      * Standardizes integer-based raw date formats into actual SQL `DATE` data types while filtering out corrupted dates (such as future birthdates or zeroed integers) by converting them to `NULL`.
      * Implements `NULLIF(sls_quantity, 0)` during sales calculation intervals. This acts as a defensive guardrail against *Division by Zero* errors by gracefully substituting invalid `0` quantities with a safe `NULL` value, preventing pipeline runtime failures.
      * Uses `ISNULL()` and `COALESCE()` expressions to normalize missing financial figures or fallback on secondary source data for missing profile attributes.
    
    * **Categorical Standardization (Business Rules Mapping):**
      * Leverages conditional `CASE WHEN` statements to translate highly fragmented system codes or single-character flags into standardized, human-readable enterprise values (e.g., transforming `'M'` or `'S'` into `'Married'` or `'Single'`, and converting disjointed gender indicators like `'F'` or `'FEMALE'` into a unified `'Female'` value).
### 4. Dimensional Modeling Layer (Load)
* **`4.gold_layer_view.sql`**
  * **Purpose:** Creates the final consumption-ready views based on the Star Schema pattern.
  * **Details:** It bridges operational silos by joining the cleaned Silver tables and structuring them into logical data warehouse views:
    * `gold.dim_customers`: Consolidates customer profiles by merging CRM information with ERP geography and demographic details, generating a unique *Surrogate Key*.
    * `gold.dim_products`: Resolves product catalog hierarchies and filters out end-of-life historical data.
    * `gold.fact_sales`: Generates the centralized fact table by linking transactional metrics with their corresponding dimension business keys.

---

## How to Run the Pipeline

To successfully execute this ETL project and build the Data Warehouse, run the scripts sequentially inside **SQL Server Management Studio (SSMS)**:

1. **Step 1:** Execute `1.init_database.sql` to initialize the database architecture and schemas.
2. **Step 2:** Execute `2.ddl_extract_bronze_layer.sql` to ingest the raw `.csv` data into the staging area (Note: Verify that the dataset file paths match your local directory).
3. **Step 3:** Execute `3.ddl_ETL_silver_layer.sql` to cleanse data and perform business transformations.
4. **Step 4:** Execute `4.gold_layer_view.sql` to construct the Star Schema views for analytics and reporting.
