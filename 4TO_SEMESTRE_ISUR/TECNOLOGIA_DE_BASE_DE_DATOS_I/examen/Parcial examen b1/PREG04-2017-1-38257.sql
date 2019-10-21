-- 4.- Elimina las ordenes que no tiene detalles de orden


delete O
output deleted.*
from Orders O
         left join [Order Details] OD
                    on O.OrderID = OD.OrderID
where OD.OrderID is null

