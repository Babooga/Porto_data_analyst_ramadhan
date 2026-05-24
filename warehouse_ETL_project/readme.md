# Warehouse ETL Project 

![Database Status](https://img.shields.io/badge/Database-MS%20SQL%20Server-red)
![Architecture](https://img.shields.io/badge/Architecture-Medallion-blue)
![Modeling](https://img.shields.io/badge/Data%20Modeling-Star%20Schema-orange)

## Project Overview
This project implements an end-to-end ETL (Extract, Transform, Load) pipeline to build a robust Data Warehouse using **Microsoft SQL Server (MSSQL)**. The pipeline leverages the **Medallion Architecture** for data quality management and a **Star Schema** design for data modeling. 

The source data consists of transactional dummy datasets originating from operational **ERP** and **CRM** systems, provided in `.csv` format.

* **Source Dataset:** [GitHub Datasets Repository](https://github.com/Babooga/Porto_data_analyst_ramadhan/tree/main/warehouse_ETL_project/datasets)

---

## Data Architecture
The data processing pipeline is structured into three logical layers following the **Medallion Architecture** principles:

![Level Architecture](https://raw.githubusercontent.com/Babooga/Porto_data_analyst_ramadhan/main/warehouse_ETL_project/document/level%20architecture.drawio.png)

1. **Bronze Layer:** Acts as the landing zone for raw data directly ingested from source systems. No treatments or modifications are applied here to preserve historical data integrity.
2. **Silver Layer:** Data from the Bronze layer undergoes rigorous data cleansing, data type standardization, deduplication, and initial transformations.
3. **Gold Layer:** The final business-ready layer where clean data is modeled into a **Star Schema**. In this stage, 6 operational source tables are transformed into 3 analytical database *Views*: `dim.customer`, `dim.product`, and `fact.sales`. These are fully optimized for downstream consumption, such as Business Intelligence reporting and Machine Learning workloads.

The incremental progression of data preservation across these layers is illustrated below:

![Data Preserved](https://raw.githubusercontent.com/Babooga/Porto_data_analyst_ramadhan/main/warehouse_ETL_project/document/data%20preserved.drawio.png)

---

## Data Integration Overview
Prior to data modeling in the Gold Layer, all disparate raw sources from the CRM and ERP systems are integrated. This integration bridges separate business silos by mapping shared relational keys:

![Data Integration](https://raw.githubusercontent.com/Babooga/Porto_data_analyst_ramadhan/main/warehouse_ETL_project/document/data%20integration.drawio.png)

* **Product Entity:** Maps product profile info from the CRM system with specific product categories managed in the ERP system.
* **Customer Entity:** Enriches basic customer profiles from the CRM with extra demographic details (e.g., birthdate, country location) extracted from the ERP based on matching Customer IDs.

---

## Schema Design (Star Schema)
The Data Warehouse within the *Gold Layer* is structured using a **Star Schema** approach. The centralized fact table, `fact.sales`, stores business metrics and is directly connected to the surrounding dimension tables, `dim.customer` and `dim.product`. This dimensional modeling approach was chosen for its intuitive structure, ease of understanding, and high query performance for analytical reporting on this data scale.

![Star Schema Design](https://raw.githubusercontent.com/Babooga/Porto_data_analyst_ramadhan/main/warehouse_ETL_project/document/schema.png)

---

## Data Flow
The downstream data flow details the step-by-step pipeline execution, ensuring data successfully converges into the Gold Layer as reliable, actionable insights:

![Data Flow](https://raw.githubusercontent.com/Babooga/Porto_data_analyst_ramadhan/main/warehouse_ETL_project/document/data%20flow.drawio.png)
