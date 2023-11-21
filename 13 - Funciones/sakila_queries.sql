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
