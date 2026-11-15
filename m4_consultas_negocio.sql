--CONSULTA 1
--TOTAL FACTURADO, CANTIDAD DE PEDIDOS, TICKET PROMEDIO
SELECT 
MONTH(fecha_venta) AS mes,
SUM (precio_unitario * cantidad) AS total_facturado,
COUNT (*) AS cantidad_de_pedidos,
AVG (precio_unitario * cantidad) AS ticket_promedio
FROM Ventas
GROUP BY MONTH (fecha_venta);

--CONSULTA 2
--RANKING DE PRODUCTOS
SELECT TOP 5 id_producto, SUM (cantidad) AS unidades_vendidas, SUM (precio_unitario * cantidad) AS total_facturado
FROM Ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;

--CONSULTA 3
--CLIENTES RECURRENTES
SELECT id_cliente, COUNT (*) AS cantidad_de_pedidos, SUM (precio_unitario * cantidad) AS total_facturado
FROM Ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1;

--CONSULTA 4
--PRODUCTOS POR ENCIMA/POR DEBAJO DEL PROMEDIO
WITH totales_por_producto AS (
SELECT id_producto, SUM (precio_unitario * cantidad) AS total_facturado
FROM Ventas
GROUP BY id_producto
)
SELECT id_producto, total_facturado,
CASE 
WHEN total_facturado >= (SELECT AVG (total_facturado) FROM totales_por_producto) THEN 'Por encima'ELSE 'Por debajo'
END AS promedio
FROM totales_por_producto;

--BLOQUE DE CIERRE
--EL TICKET PROMEDIO ES DE 644.40
--EL PRODUCTO 1 ES EL QUE GENERO MAYOR FACTURACION EN EL PERIODO
--EL PRODUCTO 2 ES EL QUE TIENE MAS UNIDADES VENDIDAS EN EL PERIODO, ES DECIR, MAYOR ROTACION
--DE LOS CLIENTES RECURRENTES, EL 1 Y EL 5 SON LOS QUE GENERARON MAYOR FACTURACION
--EL PRODUCTO 1 Y 3 FACTURARON POR ENCIMA DEL PROMEDIO
