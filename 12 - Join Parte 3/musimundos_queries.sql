/*1. Listar las canciones cuya duración sea mayor a 2 minutos.*/
SELECT c.id ID, c.nombre Nombre, c.compositor Compositor, c.milisegundos Duración
FROM canciones c
WHERE milisegundos > 120000;

/*2. Listar las canciones cuyo nombre comience con una vocal.  */
SELECT c.id ID, c.nombre Nombre, c.compositor Compositor
FROM canciones c
WHERE c.nombre LIKE 'a%' OR c.nombre LIKE 'e%' OR c.nombre LIKE 'i%' OR c.nombre LIKE 'o%' OR c.nombre LIKE 'u%'
   OR c.nombre LIKE 'A%' OR c.nombre LIKE 'E%' OR c.nombre LIKE 'I%' OR c.nombre LIKE 'O%' OR c.nombre LIKE 'U%';

/*Canciones*/
/*1.
A. Listar las canciones ordenadas por compositor en forma descendente.
B. Luego, por nombre en forma ascendente. Incluir únicamente aquellas canciones que tengan compositor.
*/   
SELECT c.nombre Nombre, c.compositor Compositor
FROM canciones c
ORDER BY c.compositor DESC;

SELECT c.nombre AS Nombre, c.compositor AS Compositor
FROM canciones c
WHERE c.compositor IS NOT NULL AND c.compositor != ''
ORDER BY c.nombre;

/*2.
A. Listar la cantidad de canciones de cada compositor. 
B. Modificar la consulta para incluir únicamente los compositores que tengan más de 10 canciones. 
*/
SELECT COUNT(c.nombre) Cantidad, c.compositor Compositores
FROM canciones c
WHERE c.compositor IS NOT NULL AND c.compositor != ''
GROUP BY c.compositor
HAVING COUNT(c.nombre) > 10;

/*Facturas */
/*1.
A. Listar el total facturado agrupado por ciudad.
B. Modificar el listado del punto (a) mostrando únicamente las ciudades de Canadá.
C. Modificar el listado del punto (a) mostrando únicamente las ciudades con una facturación mayor a 38.
D. Modificar el listado del punto (a) agrupando la facturación por país, y luego por ciudad.
*/

SELECT f.ciudad_de_facturacion Cuidades, SUM(f.total) Total
FROM facturas f
GROUP BY f.ciudad_de_facturacion;

SELECT f.ciudad_de_facturacion Cuidades, SUM(f.total) Total
FROM facturas f
WHERE f.pais_de_facturacion = "Canadá"
GROUP BY f.ciudad_de_facturacion;

SELECT f.ciudad_de_facturacion Cuidades, SUM(f.total) Total
FROM facturas f
GROUP BY f.ciudad_de_facturacion
HAVING SUM(f.total)>38;

SELECT f.pais_de_facturacion Paises, f.ciudad_de_facturacion Cuidades, SUM(f.total) Total
FROM facturas f
GROUP BY f.pais_de_facturacion, f.ciudad_de_facturacion;

/*Canciones/Géneros*/
/*1.
A. Listar la duración mínima, máxima y promedio de las canciones. 
B. Modificar el punto (a) mostrando la información agrupada por género
*/

SELECT  MAX(c.milisegundos) Máximo, MIN(c.milisegundos) Mínimo, AVG(c.milisegundos) Promedio
FROM canciones c;

SELECT g.nombre, MAX(c.milisegundos) Máximo, MIN(c.milisegundos) Mínimo, AVG(c.milisegundos) Promedio
FROM canciones c
JOIN generos g
ON c.id_genero=g.id
GROUP BY g.nombre;