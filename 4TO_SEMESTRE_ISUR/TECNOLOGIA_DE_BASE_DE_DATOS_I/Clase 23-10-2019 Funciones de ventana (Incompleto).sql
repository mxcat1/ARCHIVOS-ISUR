-- rangos en over funciones de agregado

select sum(UnitsInStock)
           over ( partition by CategoryID
               order by UnitPrice desc
               rows between unbounded preceding and current row ),
       UnitsInStock,
       CategoryID,
       UnitPrice
from Products;

--partition es para q lo agrupe por una columno q tu desees
--order by para q lo ordene por el una columna
-- y rows between unbounded preceding and current row es para q si hay repetidos en el campo ordenado
-- no lo tome como uno
-- sino q tome desde el inicio hasta el actual


--EJEMPLO2

select COUNT(UnitsInStock)
           over ( partition by CategoryID
               order by UnitPrice DESC
               rows between current row AND unbounded FOLLOWING ),
       UnitsInStock,
       CategoryID,
       UnitPrice
from Products;

--EN ROW SE PUES USAR current row = EN LA FILA ACTUAL
--unbounded FOLLOWING AL FINAL DELA PARTICION
--unbounded preceding AL INICIO DE LA PARTICION


-- EJEMPLO 2 CON NUMEROS

select SUM(UnitsInStock)
           over ( partition by CategoryID
               order by UnitPrice DESC
               rows between 2 PRECEDING AND 3 FOLLOWING ),
       UnitsInStock,
       CategoryID,
       UnitPrice
from Products;

--EN ESTE EJEMPLO EL LA PARTE DE rows between 2 PRECEDING AND 3 FOLLOWING
-- NOS DICE Q SUME LOS 2 ANTES Y TMB LOS 3 DESPUES
-- practicamente tmb me dice q se situe en 2 filas antes del actual y sume hasta la 3 fila despues del actual

--NOTA
-- unbounded preceding
-- unbounded FOLLOWING
-- current row
-- "Numero" preceding
-- "Numero" FOLLOWING



-- Ejerciocio 1
-- Listar las ordenes por cada cliente
--que contega id del cliente o nombre del cliente , el id de la orden , el año de la orden y el monto con fletes y descuento

--el total debe ser el acumulado del monto del cliente de ese año
-- se reinicia por cada cliente y por cada año

--ejm     Clienteid             Id          AÑO         Monto           Total
--          ALFKI               10248       1996        100             100
--          ALFKI               10241       1996        200             300
--          ALFKI               10243       1996        100             400
--          ALFKI               10248       1996        200             600
--          ALFKI               10241       1997        100             100
--          ALFKI               10248       1997        100             200
--          ALFKF               10248       1997        100             100
--          ALFKF               10248       1997        100             200
--          ALFKF               10248       1997        100             300