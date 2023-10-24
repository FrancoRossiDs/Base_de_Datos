#comentario en linea
-- comentario en linea con un espacio
/*
comentario 
multilinea
*/
-- Ctrl Enter = ejecuta solo una linea
-- Ctrl Shift Enter = ejecuta todo
-- crear base de datos
drop database if exists prueba;
create database prueba;
use prueba;
create table certificado(
	id int auto_increment primary key,
    title varchar(50)
);
-- crear tabla
create table usuario(
	id int PRIMARY KEY auto_increment,
	nombre varchar(90),
    dni int,
    id_certificado int ,
    Foreign  key(id_certificado) references certificado(id)
);

create table curso(
	id int auto_increment primary key,
    title varchar(50),
    cantidadAlumnos int 
);
-- agregar columna
alter table usuario add apellido varchar(50);
