-- 4.- Elimina las ordenes que no tiene detalles de orden

-- paso 1

select *
into Orderscopia
from Orders;
select *
into [Order Details Copia]
from Orders;


select *
from Orderscopia O
    LEFT join [Order Details Copia] OD
        on O.OrderID = OD.OrderID
where OD.OrderID is null;

delete O
output deleted.*
from Orders O
         left join [Order Details] OD
                    on O.OrderID = OD.OrderID
where OD.OrderID is null

