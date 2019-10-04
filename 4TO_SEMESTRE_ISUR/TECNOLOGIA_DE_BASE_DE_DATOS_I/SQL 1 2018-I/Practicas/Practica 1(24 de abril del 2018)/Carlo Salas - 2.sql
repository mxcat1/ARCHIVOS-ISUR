/*
2.Tabla Derivadas: Obtener un listado de las ordenes atendidas por el mejor empleado del año
*/

select distinct *
from Orders O
join (
		select EmployeeID, T3.Anio
		from(
				select EmployeeID,
					   Empleado,
					   Anio,
					   Monto,
					   DENSE_RANK()over(Partition by Anio Order by Monto desc) as Puesto
				from(
						select EmployeeID ,
							   Empleado,
							   Anio,
							   sum(Monto) as Monto

						from(

								select E.EmployeeID,
									   E.FirstName + ' ' + E.LastName as Empleado,
									   O.OrderID,
									   Year(O.OrderDate) as Anio,
									   round(sum(OD.UnitPrice * OD.Quantity * (1-OD.Discount)) + O.Freight,2) as Monto
								from Employees E join Orders O
								on E.EmployeeID = O.EmployeeID join [Order Details] OD
								on OD.OrderID = O.OrderID
								group by E.FirstName + ' ' + E.LastName, O.OrderID, O.Freight, Year(O.OrderDate),E.EmployeeID
								) as T
						group by Empleado, Anio, EmployeeID ) as T2) T3
		Where Puesto = 1) as Em
on O.EmployeeID = em.EmployeeID and Year(O.Orderdate) = em.Anio
