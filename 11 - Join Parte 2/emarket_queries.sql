/*Clientes*/
/*1. ¿Cuántos clientes existen?*/
SELECT COUNT(ClienteID) AS Cantidad
FROM clientes;

/*2. ¿Cuántos clientes hay por ciudad?*/
SELECT COUNT(clientes.Contacto) AS Cantidad, clientes.Ciudad AS Cuidades
FROM clientes
GROUP BY clientes.Ciudad;

/*Facturas*/
/*1. ¿Cuál es el total de transporte?*/
SELECT SUM(Transporte) AS Total
FROM facturas;

/*2. ¿Cuál es el total de transporte por EnvioVia (empresa de envío)?*/
SELECT EnvioVia,SUM(Transporte) AS Total 
FROM facturas
GROUP BY facturas.EnvioVia;

/*3. Calcular la cantidad de facturas por cliente. Ordenar descendentemente por cantidad de facturas.*/
SELECT ClienteID AS ID, COUNT(FacturaID) AS Cantidad
FROM facturas
GROUP BY ClienteID
ORDER BY Cantidad DESC;

/*4. Obtener el Top 5 de clientes de acuerdo a su cantidad de facturas.*/
SELECT ClienteID AS ID, COUNT(FacturaID) AS Cantidad
FROM facturas f
GROUP BY ClienteID
ORDER BY Cantidad DESC
LIMIT 5;

/*5. ¿Cuál es el país de envío menos frecuente de acuerdo a la cantidad de facturas?*/
SELECT f.PaisEnvio Pais,COUNT(f.PaisEnvio) Cantidad
FROM facturas f
GROUP BY f.PaisEnvio
ORDER BY COUNT(f.PaisEnvio) ASC
LIMIT 1;

/*6. Se quiere otorgar un bono al empleado con más ventas. ¿Qué ID de empleado realizó más operaciones de ventas?*/
SELECT EmpleadoID, COUNT(FacturaID)
FROM facturas
GROUP BY EmpleadoID
ORDER BY COUNT(FacturaID) DESC
LIMIT 1;


/*Factura Detalle*/
/*1. ¿Cuál es el producto que aparece en más líneas de la tabla Factura Detalle?*/
SELECT  p.ProductoNombre ,COUNT(p.ProductoID)
FROM productos p
JOIN facturadetalle fd
ON p.ProductoID=fd.ProductoID
GROUP BY fd.ProductoID
ORDER BY COUNT(p.ProductoID) DESC
LIMIT 1;

/*2. ¿Cuál es el total facturado? Considerar que el total facturado es la suma de cantidad por precio unitario.*/
SELECT SUM(PrecioUnitario*Cantidad) Total
FROM facturadetalle;

/*3. ¿Cuál es el total facturado para los productos ID entre 30 y 50?*/
SELECT SUM(PrecioUnitario*Cantidad) Total
FROM facturadetalle
WHERE ProductoID BETWEEN 30 AND 50;

/*4. ¿Cuál es el precio unitario promedio de cada producto?*/
SELECT facturadetalle.ProductoID , AVG(facturadetalle.PrecioUnitario) AS Promedio
FROM facturadetalle
GROUP BY facturadetalle.ProductoID;

/*5. ¿Cuál es el precio unitario máximo?*/
SELECT facturadetalle.ProductoID , AVG(facturadetalle.PrecioUnitario) AS Promedio
FROM facturadetalle
GROUP BY facturadetalle.ProductoID
ORDER BY AVG(facturadetalle.PrecioUnitario) DESC
LIMIT 1;

/*Join Parte 2*/
/*1. Generar un listado de todas las facturas del empleado 'Buchanan'. */
SELECT FacturaID
FROM facturas f
JOIN empleados e
ON f.EmpleadoID=e.EmpleadoID
WHERE e.Apellido ='Buchanan';

/*2. Generar un listado con todos los campos de las facturas del correo 'Speedy Express'*/
SELECT FacturaID
FROM facturas f
JOIN correos c
ON f.EnvioVia=c.CorreoID
WHERE Compania='Speedy Express';

/*3. Generar un listado de todas las facturas con el nombre y apellido de los empleados.*/
SELECT FacturaID, e.Nombre, e.Apellido
FROM facturas f 
JOIN empleados e
ON f.EmpleadoID = e.EmpleadoID
GROUP BY FacturaID;

/*4. Mostrar un listado de las facturas de todos los clientes “Owner” y país de envío “USA”.*/
SELECT FacturaID, c.Titulo, c.Pais
FROM facturas f 
JOIN clientes c
ON f.ClienteID = c.ClienteID
WHERE c.Titulo="Owner" AND c.Pais="USA";

/*5. Mostrar todos los campos de las facturas del empleado cuyo apellido sea “Leverling” o que incluyan el producto id = “42”.*/
SELECT e.Apellido ,fd.ProductoID, f.*
FROM empleados e
JOIN facturas f ON e.EmpleadoID = f.EmpleadoID
JOIN facturadetalle fd ON f.FacturaID = fd.FacturaID
WHERE e.Apellido = "Leverling" OR fd.ProductoID = 42;


/*6. Mostrar todos los campos de las facturas del empleado cuyo apellido sea “Leverling” y que incluya los producto id = “80” o ”42”.*/
SELECT e.Apellido, fd.ProductoID, f.*
FROM empleados e
JOIN facturas f ON e.EmpleadoID = f.EmpleadoID
JOIN facturadetalle fd ON f.FacturaID = fd.FacturaID
WHERE e.Apellido = 'Leverling' AND (fd.ProductoID = 42 OR fd.ProductoID = 80);

/*7. Generar un listado con los cinco mejores clientes, según sus importes de compras total (PrecioUnitario * Cantidad).*/
SELECT c.Contacto ,(fd.PrecioUnitario*fd.Cantidad) Total
FROM clientes c
JOIN facturas f
ON c.ClienteID = f.ClienteID
JOIN facturadetalle fd
ON f.FacturaID = fd.FacturaID
ORDER BY (fd.PrecioUnitario*fd.Cantidad) DESC
LIMIT 5;

/*8. Generar un listado de facturas, con los campos id, nombre y apellido del cliente, fecha de factura, país de envío, Total, ordenado de manera descendente por fecha de factura y limitado a 10 filas.*/
SELECT c.ClienteID ID,c.Contacto Nombre_Apellido ,f.FechaFactura  Fecha,f.PaisEnvio Pais,(fd.Cantidad*fd.PrecioUnitario) Total
FROM clientes c
JOIN facturas f
ON c.ClienteID = f.ClienteID
JOIN facturadetalle fd
ON f.FacturaID = fd.FacturaID
ORDER BY f.FechaFactura DESC
LIMIT 10;





