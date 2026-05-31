ALTER TABLE BARANG;

CREATE DATABASE PERUSAHAAN;

USE PERUSAHAAN;

SHOW DATABASES;

SHOW TABLES;

SHOW ENGINES;

CREATE TABLE BARANG(
	ID INT,
    NAMA VARCHAR(100),
    HARGA INT,
    JUMLAH INT
) ENGINE = InnoDB;

DESCRIBE BARANG;

CREATE TABLE products(
	id VARCHAR(10) NOT NULL,
    NAME VARCHAR(100) NOT NULL,
    DESCRIPTION TEXT,
    PRICE INT UNSIGNED NOT NULL,
    QUANTITY INT UNSIGNED NOT NULL DEFAULT 0,
    CREATED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE = InnoDB;

-- Source - https://stackoverflow.com/a/53487418
-- Posted by KeitelDOG, modified by community. See post 'Timeline' for change history
-- Retrieved 2026-04-29, License - CC BY-SA 4.0

SELECT user,authentication_string,plugin,host FROM mysql.user;

-- Source - https://stackoverflow.com/a/53487418
-- Posted by KeitelDOG, modified by community. See post 'Timeline' for change history
-- Retrieved 2026-04-29, License - CC BY-SA 4.0

ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'Current-Root-Password';
FLUSH PRIVILEGES;
