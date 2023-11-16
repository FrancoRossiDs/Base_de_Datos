/*1. Utilizando la base de datos de movies, queremos conocer, por un lado, los títulos 
y el nombre del género de todas las series de la base de datos.*/
SELECT s.title Titulo, g.name Género
FROM series s
INNER JOIN genres g
ON s.genre_id = g.id;

/*2. Por otro, necesitamos listar los títulos de los episodios junto con el nombre 
y apellido de los actores que trabajan en cada uno de ellos*/
SELECT e.title Titulo, a.first_name Nombre, a.last_name Apellido
FROM actors a
INNER JOIN actor_episode ae
ON a.id=ae.actor_id
INNER JOIN episodes e
ON e.id=ae.episode_id;

/*3. Para nuestro próximo desafío, necesitamos obtener a todos los actores 
o actrices (mostrar nombre y apellido) que han trabajado en cualquier película 
de la saga de La Guerra de las galaxias.*/
SELECT DISTINCT a.first_name AS Nombre, a.last_name AS Apellido
FROM actors a
INNER JOIN actor_movie am
ON a.id = am.actor_id
INNER JOIN movies m
ON am.movie_id=m.id
WHERE m.title LIKE 'La Guerra de las Galaxias%';


/*4. Crear un listado a partir de la tabla de películas, mostrar un reporte de la cantidad de películas por nombre de género.*/
SELECT COUNT(m.title) AS Cantidad, g.name AS Género
FROM movies m
JOIN genres g 
ON m.genre_id = g.id
GROUP BY g.name;
