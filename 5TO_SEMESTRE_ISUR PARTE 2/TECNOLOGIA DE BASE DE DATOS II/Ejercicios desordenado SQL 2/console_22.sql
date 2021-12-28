-- Haz 2 funciones.
--
-- La primera recibe dos fechas y muestra el ID de la Orden, ID del Cliente, Fecha y Monto (con fletes y descuentos) de las órdenes realizadas entre las dos fechas pasadas como parámetro.
--
-- La segunda no recibe argumentos y muestra el ID y Nombre de todos los clientes.
--
-- Finalmente, haz una consulta que use las dos funciones creadas anteriormente y que devuelva un listado similar al mostrado en la siguiente imagen.


-- Creacion de la Funcion 1
create or
alter function MontoFechas(@Fecha1 date, @Fecha2 date)
    returns @MontoFechas table
                         (
                             OrdenId    int,
                             ClienteId  char(5),
                             FechaOrden date,
                             Monto      money
                         )
as
begin
    insert into @MontoFechas
    select o.OrderID, o.CustomerID, o.OrderDate, sum(((od.UnitPrice * od.Quantity) * (1 - od.Discount))) + o.Freight
    from Orders O
             inner join [Order Details] OD on O.OrderID = OD.OrderId
    where OrderDate >= @fecha1
      and OrderDate <= @fecha2
    group by o.OrderID, o.CustomerID, o.OrderDate, o.Freight
    return
end
-- Prueba de la Funcion 1
select *
from dbo.MontoFechas('1996-09-18', '1998-04-09')
order by ClienteId

-- Creacion de la Funcion 2
create or
alter function IdNombreCliente()
    returns table
        return
            (
                select c.CustomerID, C.CompanyName
                from Customers C
            )

-- Prueba de la Funcion 2
select *
from dbo.IdNombreCliente()

---Parte final

with UnionFunciones as (
    select Clientes.CustomerID,' - '+Clientes.CompanyName as NombreCliente,null as fecha,null as monto
    from dbo.IdNombreCliente() as Clientes
    union all
    select top 1000 OrdenMonto.ClienteId,convert(varchar(max),OrdenMonto.OrdenId),OrdenMonto.FechaOrden,OrdenMonto.Monto
    from dbo.MontoFechas('1996-07-18', '1998-04-09') as OrdenMonto order by 2
) select * from UnionFunciones order by 1,2 asc
