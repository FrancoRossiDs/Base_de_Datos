/*Modelo examen final SQL*/
/*WHERE*/
/*
1. Mostrar el nombre, peso y altura de los pokémon cuyo peso sea mayor a 150.
   Tablas: pokemon
   Campos: nombre, peso, altura
*/
SELECT
	p.numero_pokedex Nro_Pokedex, p.nombre Nombre, p.peso Peso, p.altura Altura
FROM 
	pokemon p
WHERE 
	p.peso>150;
/*
2. Muestra los nombres y potencias de los movimientos que tienen una precisión mayor 90.
   Tablas: movimiento, tipo
   Campos: m.nombre, t.nombre, potencia
*/
SELECT
	m.nombre Nombre, t.nombre Tipo, m.potencia Potencia,m.precision_mov _Precision
FROM
	movimiento m 
JOIN 
	tipo t ON m.id_tipo=t.id_tipo
WHERE
	m.precision_mov > 90;
    
/*Operadores & joins*/
/*
1. Mostrar tipo, nombre y potencia de los movimientos que tienen una potencia mayor igual que 120.
   Tablas: movimiento, tipo
   Campos: m.nombre, t.nombre, potencia
*/
SELECT 
	m.nombre Nombre, t.nombre Tipo, m.potencia Potencia
FROM
	movimiento m 
JOIN 
	tipo t ON m.id_tipo=t.id_tipo
WHERE
	m.potencia>=120;
/*
2. Muestra los nombres de los tipos de Pokémon junto con sus tipos de ataque correspondientes de aquellos cuya potencia sea igual a 0.
   Tablas: tipo, tipo_ataque, movimiento
   Campos: t.nombre ta.tipo m.potencia
*/
SELECT 
	t.nombre Tipo, ta.tipo Tipo_Ataque, m.potencia Potencia
FROM
	movimiento m 
JOIN 
	tipo t ON m.id_tipo=t.id_tipo
JOIN 
	tipo_ataque ta ON t.id_tipo_ataque=ta.id_tipo_ataque
WHERE m.potencia=0;

/*Order by*/
/*
Muestra los nombres y números de Pokédex de los primeros 10 Pokémon en orden alfabético.
Tablas: pokemon
Campos: numero_pokedex, nombre
*/
SELECT 
	p.numero_pokedex Nro_Pokedex, p.nombre Nombre
FROM 
	pokemon p
ORDER BY 
	p.numero_pokedex
LIMIT 10;
/*
2. Muestra los nombres y alturas de los Pokémon de tipo "Eléctrico", ordenados por altura de forma descendente.
   Tablas: pokemon, pokemon_tipo, tipo
   Campos: nombre, altura
*/
SELECT 
	p.nombre Nombre, t.nombre Tipo, p.altura Altura
FROM 
	pokemon p
JOIN
	pokemon_tipo pt ON p.numero_pokedex=pt.numero_pokedex
JOIN
	tipo t ON pt.id_tipo=t.id_tipo
WHERE t.nombre="Eléctrico"
ORDER BY p.altura DESC;

/*Funciones de agregación*/
/*
1. ¿Cuál es la suma total de los valores de "Defensa" en todas las estadísticas base?
   Tablas: estadisticas_base
   Campos: defensa
*/
SELECT 
	SUM(eb.defensa)
FROM 
	estadisticas_base eb;
/*
2.¿Cuántos Pokémon tienen el tipo "Fuego"?
  Tablas: pokemon_tipo, tipo
  Campos: *
*/
SELECT 
	COUNT(t.nombre) Cantidad
FROM 
	tipo t
JOIN 
	pokemon_tipo pt on t.id_tipo=pt.id_tipo
WHERE t.nombre="Fuego";

/*Group by*/
/*
1. Muestra los nombres de los tipos de Pokémon junto con la cantidad de Pokémon de cada tipo.
   Tablas: pokemon_tipo, tipo
   Campos: nombre, numero_pokedex
*/
SELECT 
	t.nombre Tipo, COUNT(pt.numero_pokedex) Cantidad
FROM 
	tipo t
JOIN 
	pokemon_tipo pt on t.id_tipo=pt.id_tipo
GROUP BY t.nombre;
/*
2. Muestra los nombres de los tipos de Pokémon junto con el promedio de peso de los Pokémon de cada tipo. Ordena los resultados de manera descendente según el promedio de peso.
   Tablas: pokemon, pokemon_tipo, tipo
   Campos: t.nombre, p.peso
*/
SELECT 
	t.nombre Tipo, round(AVG(p.peso),2) Peso_Promedio
FROM 
	pokemon p
JOIN
	pokemon_tipo pt ON p.numero_pokedex=pt.numero_pokedex
JOIN
	tipo t ON pt.id_tipo=t.id_tipo
GROUP BY t.nombre;

/*Having*/
/*
1. Muestra los nombres de los Pokémon que tienen más de un tipo.
   Tablas: pokemon, pokemon_tipo
   Campos: nombre
*/
SELECT 
	p.nombre Nombre,COUNT(t.nombre) Tipos
FROM 
	pokemon p
JOIN
	pokemon_tipo pt ON p.numero_pokedex=pt.numero_pokedex
JOIN
	tipo t ON pt.id_tipo=t.id_tipo
GROUP BY p.nombre
HAVING COUNT(t.nombre)>1;
/*
2. Muestra los nombres de los tipos de Pokémon junto con la cantidad de Pokémon de cada tipo que tienen un peso promedio mayor a 10.
   Tablas: pokemon, pokemon_tipo, tipo
   Campos: nombre, numero_pokedex
*/
SELECT 
	t.nombre Tipo, COUNT(p.nombre) Cantidad, round(AVG(p.peso),2) Peso
FROM 
	pokemon p
JOIN
	pokemon_tipo pt ON p.numero_pokedex=pt.numero_pokedex
JOIN
	tipo t ON pt.id_tipo=t.id_tipo
GROUP BY t.nombre
HAVING AVG(p.peso)>10;
/*Funciones de alteración*/
/*
1. Muestra los nombres de los movimientos de tipo de ataque "Especial" con una potencia superior a 10 y una descripción que contenga al menos 20 palabras.
   Tablas: movimiento, tipo_ataque
   Campos: nombre, potencia, tipo, descripcion
*/   
SELECT 
	m.nombre Movimiento, ta.tipo Tipo_Ataque, m.potencia Potencia, m.descripcion Descripción
FROM 
	movimiento m
JOIN
	tipo t ON m.id_tipo=t.id_tipo
JOIN
	tipo_ataque ta ON t.id_tipo_ataque=ta.id_tipo_ataque
WHERE 
	m.potencia>10 AND length(m.descripcion)>=20;
/*
2. Muestra los nombres de los tipos de Pokémon junto con la cantidad de Pokémon de cada tipo que tienen una velocidad promedio superior a 80. 
   Solo incluye tipos que tienen al menos 3 Pokémon con esas características.
   Tablas: tipo, pokemon_tipo, estadisticas_base
   Campos: t.nombre, *
*/
SELECT 
*
FROM 
	tipo t
JOIN
	pokemon_tipo pt ON t.id_tipo=pt.id_tipo
JOIN
	pokemon p ON pt.numero_pokedex=p.numero_pokedex
JOIN
	estadisticas_base eb ON p.numero_pokedex=eb.numero_pokedex
	
    
