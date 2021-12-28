/*FUNCIONES
    -Devuelven una respuesta
    -Escalar
    -Table-valued fuction(TVF)
        -TVF INLINE
        -TVF MULTISTATEMNT
*/

create or
alter function Ordenes_Cliente(@Cod_Cliente as varchar(5))
    returns TABLE
        as
        return
            (
                select CustomerID, OrderID, Freight, ShipCity + ', ' + ShipCountry as Lugar
                from Orders
                where CustomerID = @Cod_Cliente
            )
go

select OrderID, Lugar
from dbo.Ordenes_Cliente('ALFKI');


-- Las TVF pueden ser usadas con otra tabla con el Cross Apply  o un outer Apply

-- cross apply es igual a un inner join
select c.CustomerID, C.CompanyName, c.City
from Customers as C
         Cross APPLY dbo.Ordenes_Cliente(c.CustomerID) as OC
where c.Country in ('Argentina', 'Brazil')
order by 1;


-- outer apply se parece a otro join
select c.CustomerID, C.CompanyName, c.City, oc.*
from Customers as C
         outer apply dbo.Ordenes_Cliente(c.CustomerID) as OC
where c.Country in ('France', 'Spain')
order by 1;

