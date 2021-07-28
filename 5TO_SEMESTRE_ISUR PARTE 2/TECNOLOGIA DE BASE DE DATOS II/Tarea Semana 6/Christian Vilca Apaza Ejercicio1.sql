-- 1.-Haz una vista que muestre el nombre del cliente, el monto total que ha comprado (con fletes y descuentos)
-- y el nombre de los tres productos que el cliente ha comprado más.

create or alter view MontoClienteProducto
as
with CTE1A as (
    select Cliente, convert(money, sum(MontoComprado)) MontoTotal
    from (select c.CompanyName Cliente, sum((od.Quantity * od.UnitPrice) * (1 - od.Discount)) + o.Freight MontoComprado
          from Orders o
                   INNER JOIN [Order Details] OD on o.OrderID = OD.OrderID
                   inner join Customers C on C.CustomerID = o.CustomerID
          group by c.CompanyName, o.Freight
         ) ClienteCompra
    group by Cliente
    union all
    select CompanyName+' - Producto TOP: ' +ProductName,convert(money,MontoFinal)
    from (select row_number() over (partition by CompanyName order by CompanyName asc,MontoFinal desc ) ID,
                 CompanyName,
                 ProductName,
                 MontoFinal
          from (select distinct CompanyName,
                                ProductName,
                                sum(MontoProducto) over ( partition by CompanyName,ProductName) MontoFinal
                from (select c.CompanyName,
                             p.ProductName,
                             sum(((od.Quantity * od.UnitPrice) * (1 - od.Discount)) + o.Freight)
                                 over (partition by c.CompanyName,ProductName,O.OrderID) MontoProducto
                      from Orders O
                               inner join [Order Details] OD on O.OrderID = OD.OrderID
                               inner join Products P on P.ProductID = OD.ProductID
                               inner join Customers C on C.CustomerID = O.CustomerID) MontosProductoCliente) TVA1) ConsultaFinal
    where ID >= 1
      and ID <= 3
)select * from CTE1A

select * from MontoClienteProducto order by 1
