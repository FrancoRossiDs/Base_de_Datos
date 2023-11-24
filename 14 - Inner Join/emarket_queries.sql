/*Reportes parte II - INNER, LEFT Y RIGHT JOIN*/
/*
1. Listar todas las categorías junto con información de sus productos. Incluir todas las
   categorías aunque no tengan productos.
*/
SELECT
	*
FROM 
	categorias c
LEFT JOIN 
	productos p ON c.CategoriaID=p.CategoriaID;
/*
2. Listar la información de contacto de los clientes que no hayan comprado nunca en
   emarket
*/
SELECT
	c.Contacto Nombre_Apellido, 
    f.FechaFactura
FROM 
	clientes c
LEFT JOIN
	facturas f ON c.ClienteID=f.ClienteID
WHERE f.FechaFactura IS NULL;
/*
3. Realizar un listado de productos. Para cada uno indicar su nombre, categoría, y la
	información de contacto de su proveedor. Tener en cuenta que puede haber
	productos para los cuales no se indicó quién es el proveedor.
*/
SELECT
	p.ProductoNombre Producto,
    c.CategoriaNombre Categoria, 
    pr.Contacto
FROM 
	categorias c
RIGHT JOIN 
	productos p ON c.CategoriaID=p.CategoriaID
JOIN 
	proveedores pr ON p.ProveedorID=pr.ProveedorID;
/*
4.Para cada categoría listar el promedio del precio unitario de sus productos
*/
SELECT
	c.CategoriaID ID, 
    c.CategoriaNombre, 
    AVG(p.PrecioUnitario) Promedio
FROM 
	categorias c
RIGHT JOIN 
	productos p ON c.CategoriaID=p.CategoriaID
GROUP BY c.CategoriaID
ORDER BY c.CategoriaID;
/*
5. Para cada cliente, indicar la última factura de compra. Incluir a los clientes que
   nunca hayan comprado en e-market
*/
SELECT c.ClienteID,c.Contacto , MAX(f.FechaFactura) Fecha
FROM 
	clientes c
LEFT JOIN facturas f ON c.ClienteID=f.ClienteID
GROUP BY c.ClienteID
ORDER BY c.ClienteID;
/*
6. Todas las facturas tienen una empresa de correo asociada (enviovia). Generar un
	listado con todas las empresas de correo, y la cantidad de facturas
	correspondientes. Realizar la consulta utilizando RIGHT JOIN.
*/
SELECT 
	c.CorreoID ID, 
    c.Compania, 
    COUNT(f.FacturaID) Cantidad
FROM
	facturas f
RIGHT JOIN correos c ON f.EnvioVia=c.CorreoID
GROUP BY c.CorreoID


	