/*Examen Final*/
/*Where*/
/*
1. Mostrar el nombre, altura y peso de los Pokémon cuya altura sea menor a 0.5.
   Tablas: pokemon
   Campos: nombre, peso, altura
*/
SELECT 
	p.nombre Pokemon, p.altura Altura, p.peso Peso
FROM 
	pokemon p
WHERE 
	p.altura < 0.5;
/*
2. Mostrar los nombres, descripciones, potencia y precisión de los movimientos cuya potencia esté entre 70 y 100, la precisión sea mayor a 80.
   Tablas: movimiento
   Campos: nombre, descripcion, potencia, precision_mov
*/
SELECT 
	m.nombre Movimiento, m.descripcion Descripción,m.potencia Potencia ,m.precision_mov Precisión
FROM
	movimiento m
WHERE 
	m.potencia BETWEEN 70 AND 100 AND m.precision_mov>80;

/*Operadores & joins*/
/*
1. Mostrar los nombres y potencia de los movimientos que tienen una potencia entre 50 y 80, junto con el nombre del tipo al que pertenecen.
   Tablas: movimiento, tipo
   Campos: m.nombre, t.nombre, potencia
*/
SELECT
	m.nombre Movimiento, m.potencia Potencia, t.nombre Tipo
FROM
	movimiento m
JOIN
	tipo t ON m.id_tipo=t.id_tipo
WHERE 
	m.potencia BETWEEN 50 AND 80;
/*
2. Mostrar los nombre, potencia y tipo de los movimientos que tienen un tipo de ataque "Físico" y una precisión mayor a 85.
   Tablas: tipo, tipo_ataque, movimiento
   Campos: m.nombre, m.potencia, m.precision_mov, ta.tipo
*/
SELECT
	m.nombre Movimiento, m.potencia Potencia, t.nombre Tipo, m.precision_mov Precision_, ta.tipo Tipo_Ataque
FROM
	movimiento m
JOIN
	tipo t ON m.id_tipo=t.id_tipo
JOIN 
	tipo_ataque ta ON t.id_tipo_ataque=ta.id_tipo_ataque
WHERE 
	ta.tipo = "Físico" AND m.precision_mov >85;

/*Order by*/
/*
1. Mostrar los nombres y números de Pokédex de los Pokémon en orden descendente según su número de Pokédex.
   Tablas: pokemon
   Campos: numero_pokedex, nombre
*/
SELECT 
	p.nombre Pokemon, p.numero_pokedex Pokedex
FROM 
	pokemon p
ORDER BY 
	p.numero_pokedex DESC;
/*
2. Mostrar numero de pokedex, nombre y altura de los Pokémon de tipo "Roca", ordenados por altura de forma ascendente.
   Tablas: pokemon, pokemon_tipo, tipo
   Campos: numero_pokedex, nombre, altura
*/
SELECT 
	p.numero_pokedex Pokedex, p.nombre Pokemon, p.altura Altura, t.nombre Tipo  
FROM 
	pokemon p
JOIN 
	pokemon_tipo pt ON p.numero_pokedex= pt.numero_pokedex
JOIN
	tipo t ON pt.id_tipo = t.id_tipo
WHERE 
	t.nombre="Roca"
ORDER BY 
	p.altura ;

/*Funciones de agregación*/
/*
1. ¿Cuántos Pokémon tienen una defensa superior a 100?
    Tablas: estadisticas_base
    Campos: defensa
*/
SELECT 
	COUNT(eb.defensa) Cantidad
FROM
	estadisticas_base eb
WHERE 
	eb.defensa >100;
/*
2. ¿Cuál es la potencia promedio de todos los movimientos en la base de datos? ¿Cuáles son los valores máximos y mínimos de la potencia?
   Tablas: movimiento
   Campos: potencia
*/
SELECT 
	round(AVG(m.potencia),2) Promedio, MAX(m.potencia) Mayor, MIN(m.potencia) Menor
FROM 
	movimiento m;
/*Group by*/
/*
1. Muestra los nombres de los tipos de Pokémon junto con la velocidad promedio de los Pokémon de cada tipo.
   Tablas: estadisticas_base, pokemon_tipo, tipo
   Campos: t.nombre, eb.velocidad
*/
SELECT
	t.nombre Tipo, round(AVG(eb.velocidad),2) Velocidad_Promedio
FROM 
	estadisticas_base eb
JOIN 
	pokemon p ON eb.numero_pokedex=p.numero_pokedex
JOIN 
	pokemon_tipo pt ON eb.numero_pokedex=pt.numero_pokedex
JOIN
	tipo t ON pt.id_tipo=t.id_tipo
GROUP BY 
	t.nombre;
/*
2. Muestra los nombres de los tipos de Pokémon junto con la potencia máxima de movimientos de cualquier tipo que tienen una potencia superior a 80.
   Tablas: movimiento, tipo
   Campos: t.nombre, m.potencia
*/
SELECT 
	t.nombre Tipo, MAX(m.potencia) Potencia_MAX
FROM 
	movimiento m
JOIN
	tipo t ON m.id_tipo = t.id_tipo
WHERE 
	m.potencia>80
GROUP BY 
	t.nombre;

/*Having*/
/*
1. Muestra los nombres de los tipos de Pokémon junto con la cantidad de Pokémon de cada tipo que tienen una precisión promedio mayor a 80 en sus movimientos.
   Tablas: tipo, pokemon_tipo, movimiento
   Campos: t.nombre, m.precision_mov
*/
SELECT 
	t.nombre Tipo, COUNT(m.nombre) Cantidad, round(AVG(m.precision_mov), 2) Precision_Promedio
FROM 
	movimiento m
JOIN 
	tipo t ON m.id_tipo=t.id_tipo
JOIN
	pokemon_tipo pt ON t.id_tipo=pt.id_tipo
GROUP BY 
	t.nombre, m.precision_mov
HAVING 
	AVG(m.precision_mov)>80;
/*
2. Muestra los nombres de los Pokémon que tienen un promedio de ataque superior a 70 y más de un tipo.
   Tablas: pokemon, pokemon_tipo, estadisticas_base
   Campos: p.nombre, eb.ataque, pt.id_tipo
*/
SELECT
	round(AVG(eb.ataque),2) Promedio_Ataque, p.nombre Pokemon, COUNT(pt.id_tipo) Cantidad_Tipos
FROM
	estadisticas_base eb
JOIN 
	pokemon p ON eb.numero_pokedex = p.numero_pokedex
JOIN 
	pokemon_tipo pt ON p.numero_pokedex=pt.numero_pokedex
GROUP BY 
	eb.ataque, p.nombre
HAVING AVG
	(eb.ataque)>70 AND COUNT(pt.id_tipo)>1;

/*Registros*/
/*
1. Muestra el nombre de cada Pokémon junto con su tipo y velocidad base. Ordena los resultados por el nombre del Pokémon en orden descendente.
   Tablas: pokemon, estadisticas_base, pokemon_tipo, tipo
   Campos: p.nombre, t.nombre, eb.velocidad
*/
SELECT
	p.nombre Pokemon, t.nombre Tipo, eb.velocidad Velocidad
FROM 
 estadisticas_base eb
JOIN 
	pokemon p ON eb.numero_pokedex =p.numero_pokedex
JOIN 
	pokemon_tipo pt ON p.numero_pokedex =pt.numero_pokedex
JOIN 
	tipo t ON pt.id_tipo=t.id_tipo
ORDER BY 
	p.nombre DESC;
/*
2. Muestra los nombres de los tipos de Pokémon junto con la cantidad de Pokémon de cada tipo que tienen una velocidad promedio superior a 60 y una precisión promedio mayor a 85 en sus movimientos.
   Tablas: movimiento, tipo_ataque, pokemon_tipo, tipo, estadisticas_base, pokemon 
   Campos: t.nombre
*/
SELECT 
	 t.nombre Tipo, COUNT(p.nombre) Cantidad, round(AVG(eb.velocidad),2) Velocidad_Promedio, round(AVG(m.precision_mov),2) Precisión_Promedio
FROM 
	movimiento m
JOIN 
	tipo t ON m.id_tipo= t.id_tipo
JOIN
	pokemon_tipo pt ON t.id_tipo=pt.id_tipo
JOIN 
	pokemon p ON pt.numero_pokedex = p.numero_pokedex
JOIN 
	estadisticas_base eb ON p.numero_pokedex=eb.numero_pokedex
JOIN
	tipo_ataque ta ON t.id_tipo_ataque=ta.id_tipo_ataque
GROUP BY 
	t.nombre, m.precision_mov
HAVING 
	AVG(eb.velocidad)>60 AND AVG(m.precision_mov)>85;
/*
3. Muestra los nombres de los movimientos de tipo "Fuego" junto con los nombres de los Pokémon que pueden aprenderlos y el promedio de su altura. Solo incluye los movimientos con una potencia promedio mayor a 50.
   Tablas: movimiento, tipo_ataque, pokemon_tipo, tipo, pokemon
   Campos: m.nombre, p.nombre, p.altura
*/
SELECT 
	 t.nombre Tipo,m.nombre Movimiento,  p.nombre Pokemon, round(AVG(p.altura),2) Altura, m.potencia Potencia_Promedio
FROM 
	movimiento m
JOIN 
	tipo t ON m.id_tipo= t.id_tipo
JOIN
	pokemon_tipo pt ON t.id_tipo=pt.id_tipo
JOIN 
	pokemon p ON pt.numero_pokedex = p.numero_pokedex
JOIN
	tipo_ataque ta ON t.id_tipo_ataque=ta.id_tipo_ataque 
GROUP BY 
	t.nombre, m.nombre, p.nombre, m.potencia
HAVING 
	t.nombre="Fuego" AND AVG(m.potencia)> 50;


