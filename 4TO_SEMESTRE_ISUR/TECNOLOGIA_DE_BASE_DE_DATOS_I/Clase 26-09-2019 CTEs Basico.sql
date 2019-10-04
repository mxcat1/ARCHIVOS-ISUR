--EXPRECIONES COMUNES DE TABLA CTE
--COMMON TABLE EXPRESSION
    --PARECIDO A UNA TABLA DERIVA
    --UTILIZADO EN RECURSIVIDAD

--sintaxis

-- WITH NOMBRE
-- AS
--     (
--         SELECT DE ALGO
--     )SELECT AL MISMO CTE CON EL NOMBRE DESPUES DE WITH

--EJEMPLO

with CTE_Clientes
AS
    (
        SELECT C.CustomerID AS CODIGO,
               c.CompanyName AS NOMBRE,
               c.Country AS PAIS
        FROM Customers AS C
    )select *
    from CTE_Clientes;

--EJEMPLO DE CTE MAS COMPLEJA CON JOIN O OTRAS SELECT

set language Spanish;
with CTE_VENTAS
AS
    (
        SELECT o.OrderID as ID,
               c.CompanyName as NOMBRE_CLIENTE,
--                format(o.OrderDate,'MMMM yyyy','ES-pe') AS FECHA_ORDEN,
               format(o.OrderDate,'MMMM yyyy') AS FECHA_ORDEN,
              ROUND(sum(od.Quantity*od.UnitPrice*(1-od.Discount))+o.Freight,2) as TOTAL_ORDEN
        FROM Orders AS O
        join [Order Details] AS OD
            ON O.OrderID=OD.OrderID
        join Customers as C
            on c.CustomerID=o.CustomerID
        group by o.OrderID,
                 c.CompanyName,
                 format(o.OrderDate,'MMMM yyyy'),
                 O.Freight
    )select ID,
            NOMBRE_CLIENTE,
            UPPER(FECHA_ORDEN) as MES_ANIO,
            TOTAL_ORDEN
    from CTE_VENTAS;