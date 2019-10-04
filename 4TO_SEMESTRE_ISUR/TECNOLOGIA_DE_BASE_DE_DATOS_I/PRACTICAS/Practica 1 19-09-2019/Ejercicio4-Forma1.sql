/*
4.	Haz un listado que muestre el nombre 
del empleado que ha sido condecorado 
MÁS VECES como el mejor empleado del año.
*/
Select	Top 1 Empleado As [Empleado MÁS condecorado]
From	(
		Select	*
		From	(	Select	*, (Select Max(Total)
								From	(
										Select Empleado, Año, Sum(Monto) As Total
									From (	Select	E.FirstName + ' ' + E.LastName As Empleado,
													Year(O.OrderDate) As Año,
													Round((	Select	Sum(OD.UnitPrice * OD.Quantity * (1-OD.Discount)) As Monto
															From	[Order Details] As OD
															Where	O.OrderID = OD.OrderID) + O.Freight, 2) As Monto
											From	Orders As O
													Join Employees As E
														On E.EmployeeID = O.EmployeeID) As TD1
											Where TD1.Año = TD2.Año
									Group by Empleado, Año) As TD3) As MontoMayorAño
					From	(
							Select Empleado, Año, Sum(Monto) As Total
							From (	Select	E.FirstName + ' ' + E.LastName As Empleado,
											Year(O.OrderDate) As Año,
											Round((	Select	Sum(OD.UnitPrice * OD.Quantity * (1-OD.Discount)) As Monto
													From	[Order Details] As OD
													Where	O.OrderID = OD.OrderID) + O.Freight, 2) As Monto
									From	Orders As O
											Join Employees As E
												On E.EmployeeID = O.EmployeeID) As TD1
							Group by Empleado, Año) As TD2) As TD4
		Where	Round(TD4.Total, 2) = Round(TD4.MontoMayorAño, 2)) As TD5
Group by Empleado
Order By Count(*) Desc