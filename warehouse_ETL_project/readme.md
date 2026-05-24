# Warehouse ETL Project 

![Database Status](https://img.shields.io/badge/Database-MS%20SQL%20Server-red)
![Language](https://img.shields.io/badge/Language-T--SQL%20%2F%20Python-blue)

## 📌 Deskripsi Proyek
Proyek ini adalah implementasi pipeline ETL (Extract, Transform, Load) untuk membangun Data Warehouse menggunakan **Microsoft SQL Server (MSSQL)**. Proyek ini mengekstrak data dari [Sebutkan nama/sumber dataset, misal: File CSV / API / Database Transaksional OLTP], melakukan transformasi data (cleansing, deduplikasi, bisnis logika), dan memuatnya ke dalam skema Data Warehouse (Dimensional Modeling) untuk kebutuhan analitik.

---

## 🏗️ Arsitektur Data & Alur ETL
Pipeline ETL ini berjalan melalui tiga tahapan utama:
1. **Extract**: Mengambil data mentah dari *Source Dataset* dan memasukkannya ke dalam *Staging Area* (`staging` schema).
2. **Transform**: Melakukan pembersihan data, penanganan nilai yang hilang (*missing values*), standardisasi format, dan pembentukan tabel dimensi serta fakta.
3. **Load**: Memasukkan data yang telah bersih ke dalam skema Data Warehouse utama (`dw` atau `dbo` schema) menggunakan pendekatan *SCD (Slowly Changing Dimension)* atau *Append/Upsert*.



---

## 📊 Dataset & Sumber Data
* **Sumber Dataset:** [Masukkan link sumber data, misal: Kaggle / Server OLTP]
* **Format Data:** [Misal: .csv, .json, atau SQL Dump]
* **Deskripsi Singkat:** Dataset ini berisi informasi tentang [misal: transaksi penjualan, inventaris gudang, data pelanggan] dari tahun [XXXX] hingga [XXXX].

---

## 🗄️ Desain Skema Data Warehouse
Data Warehouse ini didesain menggunakan pendekatan **Star Schema / Snowflake Schema** [pilih salah satu] untuk mengoptimalkan performa query analitik.

### Tabel Dimensi (Dimensions)
* `Dim_Product`: Menyimpan informasi detail produk.
* `Dim_Customer`: Menyimpan data profil pelanggan.
* `Dim_Date`: Tabel dimensi waktu untuk analisis berbasis periode.

### Tabel Fakta (Facts)
* `Fact_Sales`: Menyimpan data metrik transaksi penjualan (Quantity, Revenue) dan *foreign keys* ke tabel dimensi.

---

## 🚀 Cara Menjalankan Proyek

### Prerequisites
* MS SQL Server (v2019 atau terbaru)
* SQL Server Management Studio (SSMS) atau Azure Data Studio
* [Opsional] Python 3.x (jika ekstraksi menggunakan script Python/Pandas)

