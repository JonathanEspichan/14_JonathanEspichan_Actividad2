/* Si la base de datos ya existe la eliminamos */
DROP DATABASE IF EXISTS db_SalesClothes;

/* Crear base de datos Sales Clothes */
CREATE DATABASE db_SalesClothes;

/* Poner en uso la base de datos */
USE [db_SalesClothes]

/*Para eliminar una base de datos, esta no debe estar en uso, la base  de datos en uso deberá ser master*/
/* Poner en uso base de datos master*/
/*USE master;*/

/* Eliminar base de datos */
/*DROP DATABASE db_SalesClothes;*/

/* Eliminar base de datos */
/*DROP DATABASE db_SalesClothes;*/

/* Crear tabla client */
DROP TABLE IF EXISTS client;  
CREATE TABLE client
(
	id int,
	type_document char(3),
	number_document char(15),
	names varchar(60),
	last_name varchar(90),
	email varchar(80),
	cell_phone char(9),
	birthdate date,
	active bit
	CONSTRAINT client_pk PRIMARY KEY (id)
);

/* Ver estructura de tabla client */
EXEC sp_columns @table_name = 'client';


/* Listar tablas de la base de datos db_SalesClothes */
SELECT * FROM INFORMATION_SCHEMA.TABLES;


/* Eliminar tabla client */
/*DROP TABLE client;*/


/* Crear tabla client */
DROP TABLE IF EXISTS sale;  
CREATE TABLE sale
(
	id int,
    date_time datetime,
    active bit,
    client_id int,
	CONSTRAINT sale_pk PRIMARY KEY (id)
);

/*Table: sale_detail*/
DROP TABLE IF EXISTS sale_detail;  
CREATE TABLE sale_detail (
    id int,
    amount int,
    sale_id int,
    CONSTRAINT sale_detail_pk PRIMARY KEY  (id)
);

/*Creamos nuestra tabla seller*/
DROP TABLE IF EXISTS seller;  
CREATE TABLE seller (
    id int,
    type_document char(3),
    number_document char(15),
    mes varchar(60),
    last_name varchar(90),
    salary decimal(8,2),
    cell_phone char(9),
    email varchar(80),
    activo bit,
    sale_id int,
    CONSTRAINT seller_pk PRIMARY KEY  (id)
);

/*Creamos una tabla clothes*/
DROP TABLE IF EXISTS clothes;
CREATE TABLE clothes (
    id int,
    description varchar(60),
    brand varchar(60),
    amount int,
    size varchar(10),
    price decimal(8,2),
    active bit,
    sale_detail_id int,
    CONSTRAINT clothes_pk PRIMARY KEY  (id)
);

/*Vamos a relacionar las tablas*/
/*foreign keys*/
/*Reference: clothes_sale_detail (table: clothes)*/
ALTER TABLE clothes 
	ADD CONSTRAINT clothes_sale_detail
    FOREIGN KEY (sale_detail_id)
    REFERENCES sale_detail (id);
	
/*Reference: sale_client (table: sale)*/
ALTER TABLE sale 
	ADD CONSTRAINT sale_client
    FOREIGN KEY (client_id)
    REFERENCES client (id);

/*Reference: sale_detail_sale (table: sale_detail)*/
ALTER TABLE sale_detail 
	ADD CONSTRAINT sale_detail_sale
    FOREIGN KEY (sale_id)
    REFERENCES sale (id);

/*Reference: seller_sale (table: seller)*/
ALTER TABLE seller 
	ADD CONSTRAINT seller_sale
    FOREIGN KEY (sale_id)
    REFERENCES sale (id);

/* Ver relaciones creadas entre las tablas de la base de datos */
SELECT 
    fk.name [Constraint],
    OBJECT_NAME(fk.parent_object_id) [Tabla],
    COL_NAME(fc.parent_object_id,fc.parent_column_id) [Columna FK],
    OBJECT_NAME (fk.referenced_object_id) AS [Tabla base],
    COL_NAME(fc.referenced_object_id, fc.referenced_column_id) AS [Columna PK]
FROM 
    sys.foreign_keys fk
    INNER JOIN sys.foreign_key_columns fc ON (fk.OBJECT_ID = fc.constraint_object_id)
GO


/* Eliminar una relación */
/*ALTER TABLE sale
	DROP CONSTRAINT sale_client
GO*/


/* Ver relaciones creadas entre las tablas de la base de datos */
SELECT 
    fk.name [Constraint],
    OBJECT_NAME(fk.parent_object_id) [Tabla],
    COL_NAME(fc.parent_object_id,fc.parent_column_id) [Columna FK],
    OBJECT_NAME (fk.referenced_object_id) AS [Tabla base],
    COL_NAME(fc.referenced_object_id, fc.referenced_column_id) AS [Columna PK]
FROM 
    sys.foreign_keys fk
    INNER JOIN sys.foreign_key_columns fc ON (fk.OBJECT_ID = fc.constraint_object_id)
GO

/*FIN de la actividad*/

