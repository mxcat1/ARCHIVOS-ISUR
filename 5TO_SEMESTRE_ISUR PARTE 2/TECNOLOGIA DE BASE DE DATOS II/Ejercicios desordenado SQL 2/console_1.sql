select O.OrderID, o.CustomerID, O.ShipCountry, os.Subtotal + o.Freight
from [Order Subtotals] OS
         join Orders O on O.OrderID = os.OrderID
         join Customers C on O.CustomerID = C.CustomerID;

select o.CustomerID, O.ShipCountry, sum(os.Subtotal + o.Freight)
from [Order Subtotals] OS
         join Orders O on O.OrderID = os.OrderID
         join Customers C on O.CustomerID = C.CustomerID
group by o.CustomerID, O.ShipCountry;

select DISTINCT o.ShipCountry,
                o.CustomerID,
                c.CompanyName,
                sum(os.Subtotal + o.Freight)
                    over ( partition by o.ShipCountry,o.CustomerID order by o.ShipCountry,o.CustomerID)
from [Order Subtotals] OS
         join Orders O on O.OrderID = os.OrderID
         join Customers C on O.CustomerID = C.CustomerID;

select row_number() over (partition by ShipCountry order by ShipCountry , Montototal desc ) Orden,
       ShipCountry,
       CustomerID,
       CompanyName,
       Montototal
from (select DISTINCT o.ShipCountry,
                      o.CustomerID,
                      c.CompanyName,
                      sum(os.Subtotal + o.Freight)
                          over ( partition by o.ShipCountry,o.CustomerID order by o.ShipCountry,o.CustomerID) Montototal
      from [Order Subtotals] OS
               join Orders O on O.OrderID = os.OrderID
               join Customers C on O.CustomerID = C.CustomerID) TDA1;

select ShipCountry Pais, CompanyName cLIENTE,Montototal
from (select row_number() over (partition by ShipCountry order by ShipCountry , Montototal desc ) Orden,
       ShipCountry,
       CustomerID,
       CompanyName,
       Montototal
from (select DISTINCT o.ShipCountry,
                      o.CustomerID,
                      c.CompanyName,
                      sum(os.Subtotal + o.Freight)
                          over ( partition by o.ShipCountry,o.CustomerID order by o.ShipCountry,o.CustomerID) Montototal
      from [Order Subtotals] OS
               join Orders O on O.OrderID = os.OrderID
               join Customers C on O.CustomerID = C.CustomerID) TDA1) TotalPaices
WHERE Orden=1;