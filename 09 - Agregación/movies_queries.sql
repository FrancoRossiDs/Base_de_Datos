#1 ¿Cuántas películas hay?
SELECT COUNT(*) AS cantidad
FROM movies;

#2 ¿Cuántas películas tienen entre 3 y 7 premios?
SELECT COUNT(*) AS cantidad
FROM movies
WHERE awards BETWEEN 3 AND 7;

#3 ¿Cuántas películas tienen entre 3 y 7 premios y un rating mayor a 7?
SELECT COUNT(*) as cantidad
FROM movies
WHERE awards BETWEEN 3 AND 7 AND rating>7;

#4 Encuentra la cantidad de actores en cada película.
SELECT COUNT(first_name) AS actores 
FROM actors;

#5 Crear un listado a partir de la tabla de películas, mostrar un reporte de la cantidad de películas por id. de género.
SELECT COUNT(id) AS cantidad
FROM movies;

#6 De la consulta anterior, listar sólo aquellos géneros que tengan como suma de premios un número mayor a 5.
SELECT COUNT(genre_id) AS cantidad
FROM movies
HAVING SUM(awards)>5;

#7 Encuentra las películas que tienen un promedio de calificación mayor a 6.0.
SELECT COUNT(*)
FROM movies
WHERE rating>6;


#8 Encuentra los géneros que tienen al menos 3 películas.
SELECT genre_id AS generos, COUNT(*) AS cantidad
FROM movies
GROUP BY genre_id
HAVING COUNT(title) >= 3;

