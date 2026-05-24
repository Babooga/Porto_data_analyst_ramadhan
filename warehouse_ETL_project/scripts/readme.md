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
  * **Purpose:** Handles the heavy lifting of data quality management and transformation.
  * **Details:** It builds tables under the `silver` schema and populates them with data processed through SQL transformations, including:
    * Text trimming and removal of unwanted prefixes/dashes from keys.
    * Handling missing values (`NULL` normalization) and date formatting constraints.
    * Mapping fragmented categorical flags into standard, readable business definitions (e.g., standardizing Gender and Marital Status values).

### 4. Dimensional Modeling Layer (Load)
* **`4.gold_layer_view.sql`**
  * **Purpose:** Creates the final consumption-ready views based on the Star Schema pattern.
  * **Details:** It bridges operational silos by joining the cleaned Silver tables and structuring them into logical data warehouse views:
    * `gold.dim_customers`: Consolidates customer profiles by merging CRM information with ERP geography and demographic details, generating a unique *Surrogate Key*.
    * `gold.dim_products`: Resolves product catalog hierarchies and filters out end-of-life historical data.
    * `gold.fact_sales`: Generates the centralized fact table by linking transactional metrics with their corresponding dimension business keys.

---

## 🚀 How to Run the Pipeline

To successfully execute this ETL project and build the Data Warehouse, run the scripts sequentially inside **SQL Server Management Studio (SSMS)** or **Azure Data Studio**:

1. **Step 1:** Execute `1.init_database.sql` to initialize the database architecture and schemas.
2. **Step 2:** Execute `2.ddl_extract_bronze_layer.sql` to ingest the raw `.csv` data into the staging area (Note: Verify that the dataset file paths match your local directory).
3. **Step 3:** Execute `3.ddl_ETL_silver_layer.sql` to cleanse data and perform business transformations.
4. **Step 4:** Execute `4.gold_layer_view.sql` to construct the Star Schema views for analytics and reporting.
