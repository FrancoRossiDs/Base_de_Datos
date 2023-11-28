/*Extra*/
/*
1. Obtener los artistas que han actuado en una o más películas.
*/
SELECT
	concat(a.nombre, " " , a.apellido) Nombre,COUNT(p.titulo) Cantidad_Peliculas
FROM 
	artista a
JOIN
	artista_x_pelicula axp ON a.id=axp.artista_id
JOIN
	pelicula p ON axp.pelicula_id=p.id
WHERE p.titulo IS NOT NULL
GROUP BY concat(a.nombre, " " , a.apellido);
/*
2. Obtener las películas donde han participado más de un artista según nuestra base de datos. 
*/
SELECT
    p.id,
    p.titulo,
    COUNT(CONCAT(a.nombre, ' ', a.apellido)) AS Cantidad
FROM 
    artista a
JOIN
    artista_x_pelicula axp ON a.id = axp.artista_id
JOIN
    pelicula p ON axp.pelicula_id = p.id
GROUP BY 
    p.id, p.titulo
HAVING 
    COUNT(a.id) > 1;
/*
3. Obtener aquellos artistas que han actuado en alguna película, incluso aquellos que aún no lo han hecho, según nuestra base de datos.
*/
SELECT
	concat(a.nombre, " " , a.apellido) Nombre,
    p.titulo Titulo
FROM 
    artista a
LEFT JOIN
    artista_x_pelicula axp ON a.id = axp.artista_id
JOIN
    pelicula p ON axp.pelicula_id = p.id;
/*
4. Obtener las películas que no se le han asignado artistas en nuestra base de datos.
*/
SELECT
	concat(a.nombre, " " , a.apellido) Nombre,
    p.titulo Titulo
FROM 
    artista a
JOIN
    artista_x_pelicula axp ON a.id = axp.artista_id
RIGHT JOIN
    pelicula p ON axp.pelicula_id = p.id
WHERE concat(a.nombre, " ",a.apellido) IS NULL;
/*
5. Obtener aquellos artistas que no han actuado en alguna película, según nuestra base de datos.
*/
SELECT
	concat(a.nombre, " " , a.apellido) Nombre,
    p.titulo Titulo
FROM 
    artista a
JOIN
    artista_x_pelicula axp ON a.id = axp.artista_id
RIGHT JOIN
    pelicula p ON axp.pelicula_id = p.id
WHERE p.titulo IS NULL;
/*
6. Obtener aquellos artistas que han actuado en dos o más películas según nuestra base de datos.
*/
SELECT
	concat(a.nombre, " ", a.apellido) Nombre,
    COUNT(p.titulo) Peliculas
FROM 
    artista a
JOIN
    artista_x_pelicula axp ON a.id = axp.artista_id
RIGHT JOIN
    pelicula p ON axp.pelicula_id = p.id
WHERE 
	a.id 
GROUP BY concat(a.nombre, " ", a.apellido) 
HAVING COUNT(DISTINCT p.id) >= 2;
/*
7.Obtener aquellas películas que tengan asignado uno o más artistas, incluso aquellas que aún no le han asignado un artista en nuestra base de datos.
*/
SELECT
    p.titulo, 
    COUNT(CONCAT(a.nombre, ' ', a.apellido)) Cantidad
FROM 
    pelicula p
LEFT JOIN
    artista_x_pelicula axp ON p.id = axp.pelicula_id
LEFT JOIN
    artista a ON axp.artista_id = a.id
GROUP BY 
    p.id, p.titulo, CONCAT(a.nombre, ' ', a.apellido)
HAVING 
    COUNT(DISTINCT a.id) >= 2;
