/*
Crear una tabla que contenga las metas 
*/

select OrderID,
       EmployeeID,
	   Monto,
	   OrderDate,
	   sum(Monto)over(partition by Year(OrderDate),Month(OrderDate) order by OrderDate) as Acumulado
from(
	select distinct 
			O.OrderID,
			O.EmployeeID,
			round(sum(OD.Quantity * OD.UnitPrice * (1-OD.Discount))over(Partition by O.OrderID order by O.OrderID) +
			O.Freight,2) as Monto,
			O.OrderDate

	from Orders O join [Order Details] OD
	on O.OrderID = OD.OrderID) T

