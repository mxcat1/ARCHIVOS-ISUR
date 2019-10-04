/*
Consulta de clientes que compran con frecuencias
*/

select O.OrderID, 
       O.CustomerID,
	   O.OrderID,
	   Round((select sum(OD.UnitPrice * OD.Quantity * (1-OD.Discount)) as Monto
	   from [Order Details] OD
	   Where O.OrderID = OD.OrderID),2) as Monto,	
	   Coalesce(Convert(varchar(20),(datediff(Day,(select max(O2.OrderDate)
	                 from Orders O2
					 Where O.CustomerID = O2.CustomerID and
					       O2.OrderDate < O.OrderDate), O.OrderDate))),'Primera Orden')
from Orders O 
