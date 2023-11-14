/*1. Utilizando la base de datos de movies, queremos conocer, por un lado, los títulos 
y el nombre del género de todas las series de la base de datos.*/
SELECT series.title Titulo, genres.name Género
FROM series
INNER JOIN genres
ON series.genre_id = genre.id;

/*2. Por otro, necesitamos listar los títulos de los episodios junto con el nombre 
y apellido de los actores que trabajan en cada uno de ellos*/
SELECT episodes.title Titulo, actors.first_name Nombre, actors.last_name Apellido
FROM actors
INNER JOIN actor_episode
ON actor_id=actor_episode.episode_id
INNER JOIN episodes
ON actor_episode.actor_id=actor_id;

/*3. Para nuestro próximo desafío, necesitamos obtener a todos los actores 
o actrices (mostrar nombre y apellido) que han trabajado en cualquier película 
de la saga de La Guerra de las galaxias.*/
SELECT DISTINCT actors.first_name AS Nombre, actors.last_name AS Apellido
FROM actors
INNER JOIN actor_movie 
ON actor_id = actor_movie.actor_id
INNER JOIN movies 
ON actor_movie.actor_id=movie_id
WHERE movies.title LIKE 'La Guerra de las Galaxias%';


/*4. Crear un listado a partir de la tabla de películas, mostrar un reporte de la cantidad de películas por nombre de género.*/
SELECT COUNT(m.title) AS Cantidad, g.name AS Género
FROM movies m
JOIN genres g 
ON m.genre_id = g.id
GROUP BY g.name;
