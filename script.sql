#Creacion de la base de datos
CREATE DATABASE gerenciales1;
#Uso de la base de datos
USE gerenciales1;

#Creacion de la tabla empleados
CREATE TABLE IF NOT EXISTS empleados (
	id INTEGER PRIMARY KEY,
	nombre VARCHAR(250),
    supervisor VARCHAR(250),
    fecha_contratacion DATE
);

#Carga de datos en la tabla empleados
LOAD DATA LOCAL
    INFILE 'C:/Users/franc/Documents/2S2021 USAC/Sistemas Organizacionales y Gerenciales 1/Laboratorio/Enunciados/Practica 1/empleados.csv'
    INTO TABLE empleados
    CHARACTER SET utf8
    FIELDS TERMINATED BY ',' 
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS
    (id, nombre, supervisor, @fecha_contratacion)
    SET fecha_contratacion = STR_TO_DATE(@fecha_contratacion, '%Y-%m-%d');

#Acciones con la tabla empleados
SELECT * FROM empleados;
DROP TABLE empleados;

#Creacion de la tabla facturas
CREATE TABLE IF NOT EXISTS facturas (
	fecha DATE,
    id INTEGER,
	nombre VARCHAR(250),
    supervisor VARCHAR(250),
    total_ediciones INTEGER,
	tiempo_ediciones INTEGER,
    PRIMARY KEY (fecha, id),
    FOREIGN KEY (id) REFERENCES empleados(id)
);

#Carga de datos en la tabla facturas
LOAD DATA LOCAL
    INFILE 'C:/Users/franc/Documents/2S2021 USAC/Sistemas Organizacionales y Gerenciales 1/Laboratorio/Enunciados/Practica 1/facturas.csv'
    INTO TABLE facturas
    CHARACTER SET utf8
    FIELDS TERMINATED BY ',' 
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS
    (@fecha, id, nombre, supervisor, total_ediciones, tiempo_ediciones)
    SET fecha = STR_TO_DATE(@fecha, '%Y-%m-%d');

#Acciones con la tabla facturas
SELECT facturas.*, empleados.fecha_contratacion FROM facturas 
INNER JOIN empleados ON facturas.id = empleados.id;
DROP TABLE facturas;
