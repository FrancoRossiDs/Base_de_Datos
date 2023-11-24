/*Reportes Parte 1*/
/*
1 Obtener el nombre y apellido de los primeros 5 actores disponibles. 
Utilizar alias para mostrar los nombres de las columnas en español.
*/
SELECT concat(first_name , " ", last_name) as Nombre_Apellido
FROM actor
limit 5;

/*
2. Obtener un listado que incluya nombre, apellido y correo electrónico de los clientes (customers) inactivos. 
Utilizar alias para mostrar los nombres de las columnas en español.
*/
SELECT CONCAT(c.first_name, " ", c.last_name) Nombre_Apellido, c.email Email
FROM customer c
WHERE active = 0;

/*
3. Obtener un listado de films incluyendo título, año y descripción de los films que tienen un rental_duration mayor a cinco. 
Ordenar por rental_duration de mayor a menor. Utilizar alias para mostrar los nombres de las columnas en español.
*/
SELECT f.title Título, f.release_year Año, f.description Descripción
FROM film f
WHERE rental_duration>5
ORDER BY rental_duration DESC;

/*
4. Obtener un listado de alquileres (rentals) que se hicieron durante el mes de mayo de 2005, 
incluir en el resultado todas las columnas disponibles.
*/
SELECT *
FROM rental
WHERE EXTRACT(MONTH FROM rental_date) = 5 AND EXTRACT(YEAR FROM rental_date) = 2005;

/*Reportes parte 2*/
/*
1. Obtener la cantidad TOTAL de alquileres (rentals). Utilizar un alias para mostrarlo
en una columna llamada cantidad
*/
SELECT SUM(r.rental_id) TOTAL
FROM rental r;

/*
2. Obtener la suma TOTAL de todos los pagos (payments). Utilizar un alias para
mostrarlo en una columna llamada total, junto a una columna con la cantidad de
alquileres con el alias Cantidad y una columna que indique el Importe promedio
por alquiler
*/
SELECT SUM(p.amount) TOTAL, COUNT(p.rental_id) Cantidad, AVG(amount) Importe_Promedio
FROM payment p;

/*
3. Generar un reporte que responda la pregunta: ¿cuáles son los diez clientes que más
dinero gastan y en cuántos alquileres lo hacen?
*/
SELECT c.first_name Nombre, c.last_name Apellido, p.amount Monto, r.rental_id Renta
FROM customer c
JOIN payment p
ON c.customer_id =p.customer_id
JOIN rental r
ON p.customer_id = r.customer_id
GROUP BY c.customer_id, p.amount,r.rental_id
ORDER BY p.amount DESC
LIMIT 10;

/*
4. Generar un reporte que indique: ID de cliente, cantidad de alquileres y monto
total para todos los clientes que hayan gastado más de 150 dólares en alquileres
*/
SELECT
    c.customer_id AS IDCliente,
    COUNT(DISTINCT r.rental_id) AS CantidadAlquileres,
    SUM(p.amount) AS MontoTotal
FROM
    customer c
JOIN payment p ON c.customer_id = p.customer_id
JOIN rental r ON p.rental_id = r.rental_id
GROUP BY
    c.customer_id
HAVING
    MontoTotal > 150;    
/*
5. Generar un reporte que muestre por mes de alquiler (rental_date de tabla rental),
la cantidad de alquileres y la suma total pagada (amount de tabla payment) para el
año de alquiler 2005 (rental_date de tabla rental).
*/
SELECT
	 p.payment_date Fecha, extract(MONTH FROM p.payment_date) Meses , extract(YEAR FROM p.payment_date) Año ,  SUM(p.amount) Monto
FROM 
	payment p
JOIN 
	rental r
ON 
	p.rental_id=r.rental_id
WHERE 
	extract(YEAR FROM p.payment_date) = 2005
GROUP BY
	p.payment_date
ORDER BY 
	extract(MONTH FROM p.payment_date);	
/*
6. Generar un reporte que responda a la pregunta: ¿cuáles son los 5 inventarios más
	alquilados? (columna inventory_id en la tabla rental). Para cada una de ellas
	indicar la cantidad de alquileres.
*/   
SELECT
	 i.inventory_id ID, COUNT(i.inventory_id) Cantidad
FROM 
	payment p
JOIN 
	rental r ON p.rental_id=r.rental_id
JOIN
	inventory i ON r.inventory_id=i.inventory_id
GROUP BY 
	i.inventory_id
ORDER BY 
	COUNT(i.inventory_id) DESC
LIMIT 5;



