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


select C.CustomerID,
       c.CompanyName,
       O.OrderID,
       year(o.OrderDate) Año,
       sum(os.Subtotal+o.Freight) Total,
       sum(os.Subtotal+o.Freight)
           over (
                    partition by year(o.OrderDate),c.CustomerID
                    order by year(o.OrderDate),c.CustomerID
                    rows between unbounded preceding and current row
                ) TotalAcumulado
from Customers C
    join Orders O
        on C.CustomerID = O.CustomerID
    join [Order Subtotals] OS
        on OS.OrderID=o.OrderID
group by C.CustomerID, c.CompanyName, O.OrderID, year(o.OrderDate), OS.Subtotal,o.Freight;

