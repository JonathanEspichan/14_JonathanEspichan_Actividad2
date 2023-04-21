/* Si la base de datos ya existe la eliminamos */
DROP DATABASE IF EXISTS db_SalesClothes;

/* Crear base de datos Sales Clothes */
CREATE DATABASE db_SalesClothes;

/* Ponemos en uso nuestra base de datos creada */
USE db_SalesClothes

/* Configurar idioma español en el servidor */
SET LANGUAGE Español
GO
SELECT @@language AS 'Idioma'
GO

/* Configurar el formato de fecha */
SET DATEFORMAT dmy
GO

/* Creamos nuestra tabla client */
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

/* eliminamos el Primary Key en tabla client */
ALTER TABLE client
	DROP CONSTRAINT client_pk
GO

/* eliminamos la columna id en tabla cliente */
ALTER TABLE client
	DROP COLUMN id
GO

/* Agregar columna client */
ALTER TABLE client
	ADD id int identity(1,1)
GO

/* Agregar restricción primary key */
ALTER TABLE client
	ADD CONSTRAINT client_pk 
	PRIMARY KEY (id)
GO

/* El tipo de documento puede ser DNI ó CNE */
ALTER TABLE client
	DROP COLUMN type_document
GO

/* Agregar restricción para tipo documento */
ALTER TABLE client
	ADD type_document char(3)
	CONSTRAINT type_document_client
	CHECK( type_document ='DNI' OR type_document ='CNE')
GO

/*  eliminamos la columna number_document de tabla client */
ALTER TABLE client
	DROP COLUMN number_document
GO

/* El número de documento sólo debe permitir dígitos de 0 - 9 */
ALTER TABLE client
	ADD number_document char(9)
	CONSTRAINT number_document_client
	CHECK (number_document like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][^A-Z]')
GO

/* Eliminar columna email de tabla client */
ALTER TABLE client
	DROP COLUMN email
GO

/* Agregamos la columna email */
ALTER TABLE client
	ADD email varchar(80)
	CONSTRAINT email_client
	CHECK(email LIKE '%@%._%')
GO

/* Eliminar columna celular */
ALTER TABLE client
	DROP COLUMN cell_phone
GO

/* Validar que el celular esté conformado por 9 números */
ALTER TABLE client
	ADD cell_phone char(9)
	CONSTRAINT cellphone_client
	CHECK (cell_phone like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
GO

/* Eliminar columna fecha de nacimiento */
ALTER TABLE client
	DROP COLUMN birthdate
GO

/* Sólo debe permitir el registro de clientes mayores de edad */
ALTER TABLE client
	ADD  birthdate date
	CONSTRAINT birthdate_client
	CHECK((YEAR(GETDATE())- YEAR(birthdate )) >= 18)
GO

/* Eliminar columna active de tabla client */
ALTER TABLE client
	DROP COLUMN active
GO

/* El valor predeterminado será activo al registrar clientes */
ALTER TABLE client
	ADD active bit DEFAULT (1)
GO

/* Creamos nuestra tabla seller */
CREATE TABLE seller (
    id int ,
    type_document char(3),
    number_document char(15) ,
    names varchar(60),
    last_name varchar(90),
    salary decimal(8,2),
    cell_phone char(9),
    email varchar(80),
    active bit  ,
    CONSTRAINT seller_pk PRIMARY KEY (id)
);

/* eliminamos Primary Key en tabla seller */
ALTER TABLE seller
	DROP CONSTRAINT seller_pk
GO

/* eliminamos columna id en tabla seller */
ALTER TABLE seller
	DROP COLUMN id
GO

/* Agregar columna seller */
ALTER TABLE seller
	ADD id int identity(1,1)
GO

/* Agregar restricción primary key */
ALTER TABLE seller
	ADD CONSTRAINT seller_pk 
	PRIMARY KEY (id)
GO

/* El tipo de documento puede ser DNI ó CNE*/
ALTER TABLE seller
	DROP COLUMN type_document
GO

/* Agregamos una restricción para tipo documento que solo acepte DNI O CNE */
ALTER TABLE seller
	ADD type_document char(3)
	CONSTRAINT type_document_seller
	CHECK( type_document ='DNI' OR type_document ='CNE')
GO

/* Eliminar columna number_document de tabla seller */
ALTER TABLE seller
	DROP COLUMN number_document
GO

/* El número de documento sólo debe permitir dígitos de 0 - 9 */
ALTER TABLE seller
	ADD number_document char(9)
	CONSTRAINT number_document_seller
	CHECK (number_document like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][^A-Z]')
GO

/* Eliminar columna salary de tabla seller */
ALTER TABLE seller
	DROP COLUMN salary
GO

/* Crear columna seller en la tabla salary */
ALTER TABLE seller
	ADD salary decimal(8,2)
GO

/*Poner como default '1025' en la columna salary*/
ALTER TABLE seller 
	ADD DEFAULT 1025 FOR salary
GO

/* Eliminar columna celular */
ALTER TABLE seller
	DROP COLUMN cell_phone
GO

/* Validar que el celular esté conformado por 9 números */
ALTER TABLE seller
	ADD cell_phone char(9)
	CONSTRAINT cellphone_seller
	CHECK (cell_phone like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
GO

/* Eliminar columna email de tabla seller */
ALTER TABLE seller
	DROP COLUMN email
GO

/* Agregar la columna email y con su respectiva restricción */
ALTER TABLE seller
	ADD email varchar(80)
	CONSTRAINT email_seller
	CHECK(email LIKE '%@%._%')
GO

/* Eliminamos la columna active de tabla seller */
ALTER TABLE seller
	DROP COLUMN active
GO

/* El valor predeterminado será activo al registrar seller */
ALTER TABLE seller
	ADD active bit DEFAULT (1)
GO

/* Creamos nuestra tabla clothes */
CREATE TABLE clothes 
(
    id int,
    descriptions varchar(60),
    brand varchar(60),
    amount int,
    size varchar(10),
    price decimal(8,2),
    active bit,
    CONSTRAINT clothes_pk PRIMARY KEY (id)
);

/* Eliminamos el Primary Key en tabla clothes */
ALTER TABLE clothes
	DROP CONSTRAINT clothes_pk
GO

/* Eliminamos la columna id en tabla clothes */
ALTER TABLE clothes
	DROP COLUMN id
GO

/* Eliminamos la columna id en la tabla clothes */
ALTER TABLE clothes
	ADD id int identity(1,1)
GO

/* Agregamos la restricción primary key para la tabla clothes */
ALTER TABLE clothes
	ADD CONSTRAINT clothes_pk 
	PRIMARY KEY (id)
GO

/* Eliminamos la columna active en la tabla clothes */
ALTER TABLE clothes
	DROP COLUMN active
GO

/* Agregamos el valor predeterminado que será activo al registrar en la tabla clothes */
ALTER TABLE clothes
	ADD active bit DEFAULT (1)
GO

/* Creamos nuestra tabla sale */
CREATE TABLE sale 
(
    id int,
    date_time datetime,
	seller_id int,
    client_id int,
    active bit,
    CONSTRAINT sale_pk PRIMARY KEY (id)
);

/* Eliminamos el Primary Key en tabla sale */
ALTER TABLE sale
	DROP CONSTRAINT sale_pk
GO

/* Eliminamos la columna id de nuestra tabla sale */
ALTER TABLE sale
	DROP COLUMN id
GO

/* Agregamos la columna id en la tabla sale */
ALTER TABLE sale
	ADD id int identity(1,1)
GO

/* Agregamos restricción primary key o id para nuestra tabla sale */
ALTER TABLE sale
	ADD CONSTRAINT sale_pk 
	PRIMARY KEY (id)
GO

/* Eliminamos la columna date_time de nuestra tabla sale */
ALTER TABLE sale
	DROP COLUMN date_time
GO

/* Agregamos la columna date_time en la columna de la tabla sale */
ALTER TABLE sale
	ADD date_time datetime
GO

/* Agregamos el valor predeterminado fecha y hora del servidor en la columna date_time dentro de la tabla sale */
ALTER TABLE sale
	ADD CONSTRAINT date_time_sale DEFAULT (GETDATE()) FOR date_time
GO

/* Eliminamos la columna active de tabla sale */
ALTER TABLE sale
	DROP COLUMN active
GO

/*Agregamos el valor predeterminado será activo al registrar sales */
ALTER TABLE sale
	ADD active bit DEFAULT (1)
GO

/* Creamos nuestra tabla sale_detail */
CREATE TABLE sale_detail 
(
    id int ,
    sale_id int ,
    clothes_id int ,
    amount int ,
    CONSTRAINT sale_detail_pk PRIMARY KEY (id)
);

/*RESTRICCIONES*/
/* Relacionamos la tabla sale con tabla client */
ALTER TABLE sale
	ADD CONSTRAINT sale_client FOREIGN KEY (client_id)
	REFERENCES client (id)
	ON UPDATE CASCADE 
	ON DELETE CASCADE
GO

/* Relacionamos la sale con sale_detail */
ALTER TABLE sale_detail
	ADD CONSTRAINT sale_detail_sale FOREIGN KEY (sale_id)
	REFERENCES sale (id)
	ON UPDATE CASCADE
	ON DELETE CASCADE
GO

/* Relacionar tabla sale con seller */
ALTER TABLE sale
	ADD CONSTRAINT sale_seller FOREIGN KEY (seller_id)
	REFERENCES seller (id)
	ON UPDATE CASCADE
	ON DELETE CASCADE
GO

/* Relacionamos la sale_detail con clothes */
ALTER TABLE sale_detail
	ADD CONSTRAINT sale_detail_clothes FOREIGN KEY (clothes_id)
	REFERENCES clothes (id)
	ON UPDATE CASCADE
	ON DELETE CASCADE
GO


/*INGRESAMOS REGISTROS DE DATOS*/

/* Insertamos los 8 registros en nuestra tabla client  */

INSERT INTO client 
	(type_document, number_document, names, last_name, email, cell_phone, birthdate)
VALUES
	('DNI', '78451233', 'Fabiola', 'Perales Campos', 'fabiolaperales@gmail.com', '991692597', '19/01/2005'),
	('DNI', '14782536', 'Marcos', 'Dávila Palomino', 'marcosdavila@gmail.com', '982514752', '03/03/1990'),
	('DNI', '78451236', 'Luis Alberto', 'Barrios Paredes', 'luisbarrios@outlook.com', '985414752', '03/10/1995'),
	('CNE', '352514789', 'Claudia María', 'Martínez Rodríguez', 'claudiamartinez@yahoo.com', '995522147', '23/09/1992'),
	('CNE', '142536792', 'Mario Tadeo', 'Farfán Castillo', 'mariotadeo@outlook.com', '973125478', '25/11/1997'),
	('DNI', '58251433', 'Ana Lucrecia', 'Chumpitaz Prada', 'anachumpitaz@gmail.com', '982514361', '17/10/1992'),
	('DNI', '15223369', 'Humberto', 'Cabrera Tadeo', 'humbertocabrera@yahoo.com', '977112234', '27/05/1990'),
	('CNE', '442233698', 'Rosario', 'Prada Velásquez', 'rosarioprada@outlook.com', '971144782', '05/11/1990')
GO

/* Insertamos los 3 registros en nuestra tabla seller */
INSERT INTO seller
	(type_document, number_document, names, last_name, cell_phone, email)
VALUES
	('DNI', '11224578', 'Oscar', 'Paredes Flores', '985566251', 'oparedes@miemrpesa.com'),
	('CNE', '889922365', 'Azucena', 'Valle Alcazar', '966338874', 'avalle@miemrpesa.com'),
	('DNI', '44771123', 'Rosario', 'Huarca Tarazona', '933665521', 'rhuaraca@miempresa.com')
GO

/* Insertamos los 6 registros en nuestra tabla clothes */
INSERT INTO  clothes
	(descriptions, brand, amount, size, price)
VALUES
	('Polo camisero', 'Adidas', '20', 'Medium', '40.50'),
	('Short playero', 'Nike', '30', 'Medium', '55.50'),
	('Camisa sport', 'Adams', '60', 'Large', '60.80'),
	('Camisa sport', 'Adams', '70', 'Medium', '58.75'),
	('buzo de verano', 'Reebok', '45', 'Small', '62.90'),
	('Pantalón Jean', 'Lewis', '35', 'Large', '73.60')
GO

/* Listamos el tipo de documento "DNI" en la tabla client */
SELECT *
FROM client
WHERE type_document LIKE 'DNI'
GO

/* Listamos los correo electronico que llevan "outlook.com " de tabla client */
SELECT *
FROM client
WHERE email LIKE '%@outlook.com'
GO

/* Listamos los type_document que llevan "CNE" de tabla seller */
SELECT *
FROM seller
WHERE type_document LIKE 'CNE'
GO

/* Listamos todas las prendas de ropa cual el costo sea "menor e igual que S/. 55.00" dentro de la tabla clothes*/
SELECT *
FROM clothes
WHERE price <= 55.00
GO

/* Listamos todas las prendas de ropa cuya marca sea "Adams" de la tabla clothes */
SELECT *
FROM clothes
WHERE brand LIKE 'Adams'
GO

/* Eliminamos de manera lógica de los datos de un cliente de acuerdo a un determinado id dentro de la tabla client */
UPDATE client
SET active = '0' 
WHERE id = '5'
GO


/* Eliminamos de manera lógica los datos de un cliente de acuerdo a un determinado id dentro de la tabla seller*/
UPDATE seller
SET active = '0' 
WHERE id = '2'
GO
/*OTRO ejemplo de eliminar logicamente dentro la tabla seller*/
UPDATE seller
SET  names = '' 
WHERE id = '2'
GO


/* Eliminar de manera lógica los datos de un cliente (clothes) de acuerdo a un determinado id dentro de la tabla clothes*/
UPDATE clothes
SET active = '0' 
WHERE id = '4'
GO

/*ejemplo extra*/
UPDATE clothes
SET size = ''
WHERE id = '4'
GO

SELECT * FROM client

SELECT * FROM seller

SELECT * FROM clothes