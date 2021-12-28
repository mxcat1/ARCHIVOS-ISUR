-- Haz una consulta que muestre el total de ventas (sin cosiderar fletes) por cada categoría y por cada producto.
-- El listado de mostrar una especie de jerarquía entre productos y categorías, tal como puede verse en la siguiente imagen

select concat(0, convert(decimal(16, 2), c.CategoryID))                               ID,
       c.CategoryName,
       convert(decimal(16, 2), sum((od.UnitPrice * od.Quantity) * (1 - od.Discount))) TotalCAT
from [Order Details] OD
         inner join Products P on OD.ProductID = P.ProductID
         join Categories C on C.CategoryID = P.CategoryID
group by c.CategoryID, c.CategoryName

union all

select convert(decimal(16,2),C.CategoryID+(convert(decimal(16,2),row_number() over (partition by c.CategoryName order by c.CategoryName,p.ProductName))/100)) IDPro,
       concat('--------', p.ProductName)                                                                NombreProducto,
       convert(decimal(16, 2), sum((od.UnitPrice * od.Quantity) * (1 - od.Discount)))                   TotalPro
from [Order Details] OD
         inner join Products P on P.ProductID = OD.ProductID
         inner join Categories C on C.CategoryID = P.CategoryID
group by p.ProductID, p.ProductName, CategoryName, C.CategoryID;