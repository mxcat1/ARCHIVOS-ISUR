-- 2.-listado que saque los 3 mejores clientes en cada año con su cantidad de compra en dinero
-- que se muestre el año codigo del cliente y monto se mete en una tabla mejores clientes nueva tabla

-- paso 1

select *
from Customers C
join Orders O on C.CustomerID = O.CustomerID
join [Order Details] OD on O.OrderID = OD.OrderID;

-- paso2
select c.CustomerID,
       year(O.OrderDate) ANIO,
       sum((OD.UnitPrice*od.Quantity)-(1-OD.Discount))+o.Freight SUMA_TOTAL_COMPRA
from Customers C
join Orders O
 on C.CustomerID = O.CustomerID
join [Order Details] OD
on O.OrderID = OD.OrderID
group by year(O.OrderDate),O.Freight,c.CustomerID
order by 1 asc;

-- paso 3
select TD1.ANIO,
       TD1.CustomerID,
       sum(TD1.SUMA_TOTAL_COMPRA)
from (select c.CustomerID,
             year(O.OrderDate)                                                 ANIO,
             sum((OD.UnitPrice * od.Quantity) - (1 - OD.Discount)) + o.Freight SUMA_TOTAL_COMPRA
      from Customers C
               join Orders O
                    on C.CustomerID = O.CustomerID
               join [Order Details] OD
                    on O.OrderID = OD.OrderID
      group by year(O.OrderDate), O.Freight, c.CustomerID) TD1
group by TD1.ANIO, TD1.CustomerID;

--paso 4
select TOP 3 WITH TIES TD1_ANIO.ANIO,
        TD1_ANIO.CustomerID,
        TD1_ANIO.Total
-- into Mejore_Clientes
from (select TD1.ANIO,
             TD1.CustomerID,
             sum(TD1.SUMA_TOTAL_COMPRA) Total
      from (select c.CustomerID,
                   year(O.OrderDate) ANIO,
                   sum((OD.UnitPrice * od.Quantity) - (1 - OD.Discount)) + o.Freight SUMA_TOTAL_COMPRA
            from Customers C
                     join Orders O
                          on C.CustomerID = O.CustomerID
                     join [Order Details] OD
                          on O.OrderID = OD.OrderID
            group by year(O.OrderDate), O.Freight, c.CustomerID) TD1
      group by TD1.ANIO, TD1.CustomerID)TD1_ANIO
where TD1_ANIO.ANIO=1996
order by TD1_ANIO.Total desc;

--paso5

select year(o.OrderDate)
from Orders O
group by year(o.OrderDate);

--paso 6

with CTS_Mejoreclientes
as
(
    declare @anio int=1996;
      select TOP 3 WITH TIES TD1_ANIO.ANIO,
            TD1_ANIO.CustomerID,
            TD1_ANIO.Total
    -- into Mejore_Clientes
    from (select TD1.ANIO,
                 TD1.CustomerID,
                 sum(TD1.SUMA_TOTAL_COMPRA) Total
          from (select c.CustomerID,
                       year(O.OrderDate) ANIO,
                       sum((OD.UnitPrice * od.Quantity) - (1 - OD.Discount)) + o.Freight SUMA_TOTAL_COMPRA
                from Customers C
                         join Orders O
                              on C.CustomerID = O.CustomerID
                         join [Order Details] OD
                              on O.OrderID = OD.OrderID
                group by year(O.OrderDate), O.Freight, c.CustomerID) TD1
          group by TD1.ANIO, TD1.CustomerID)TD1_ANIO
    where TD1_ANIO.ANIO=1996
    order by TD1_ANIO.Total desc;
)select *
from CTS_Mejoreclientes

