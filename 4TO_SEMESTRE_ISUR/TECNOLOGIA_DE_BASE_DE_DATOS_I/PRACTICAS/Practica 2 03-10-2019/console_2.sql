-- 1.-ver las compras en dinero (con fletes y descuento) cada año de cada cliente
-- donde se muestre codigo nombre año1 año2 año3 ...

--paso 1
select *
from Customers C
join Orders O on C.CustomerID = O.CustomerID
join [Order Details] [O D] on O.OrderID = [O D].OrderID
WHERE C.CustomerID='WOLZA';

--paso 2
select c.CustomerID,
       c.CompanyName,
       year(O.OrderDate) ANIO,
       sum((OD.UnitPrice*od.Quantity)-(1-OD.Discount))+o.Freight SUMA_TOTAL_COMPRA
from Customers C
join Orders O
 on C.CustomerID = O.CustomerID
join [Order Details] OD
on O.OrderID = OD.OrderID
group by year(O.OrderDate),O.Freight, c.CompanyName, c.CustomerID
order by 2 desc;

--paso3

select POR_ANIO.CustomerID,
       POR_ANIO.CompanyName,
       POR_ANIO.ANIO,
       SUM(POR_ANIO.SUMA_TOTAL_COMPRA) Total_Por_Anio
from (select c.CustomerID,
             c.CompanyName,
             year(O.OrderDate) ANIO,
             sum((OD.UnitPrice * od.Quantity) - (1 - OD.Discount)) + o.Freight SUMA_TOTAL_COMPRA
      from Customers C
               join Orders O
                    on C.CustomerID = O.CustomerID
               join [Order Details] OD
                    on O.OrderID = OD.OrderID
      group by year(O.OrderDate), O.Freight, c.CompanyName, c.CustomerID) POR_ANIO
group by POR_ANIO.CustomerID, POR_ANIO.CompanyName, POR_ANIO.ANIO;

