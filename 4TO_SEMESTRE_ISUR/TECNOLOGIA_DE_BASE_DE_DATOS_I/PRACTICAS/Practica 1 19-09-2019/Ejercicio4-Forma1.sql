/*
4.	Haz un listado que muestre el nombre 
del empleado que ha sido condecorado 
M�S VECES como el mejor empleado del a�o.
*/
Select	Top 1 Empleado As [Empleado M�S condecorado]
From	(
		Select	*
		From	(	Select	*, (Select Max(Total)
								From	(
										Select Empleado, A�o, Sum(Monto) As Total
									From (	Select	E.FirstName + ' ' + E.LastName As Empleado,
													Year(O.OrderDate) As A�o,
													Round((	Select	Sum(OD.UnitPrice * OD.Quantity * (1-OD.Discount)) As Monto
															From	[Order Details] As OD
															Where	O.OrderID = OD.OrderID) + O.Freight, 2) As Monto
											From	Orders As O
													Join Employees As E
														On E.EmployeeID = O.EmployeeID) As TD1
											Where TD1.A�o = TD2.A�o
									Group by Empleado, A�o) As TD3) As MontoMayorA�o
					From	(
							Select Empleado, A�o, Sum(Monto) As Total
							From (	Select	E.FirstName + ' ' + E.LastName As Empleado,
											Year(O.OrderDate) As A�o,
											Round((	Select	Sum(OD.UnitPrice * OD.Quantity * (1-OD.Discount)) As Monto
													From	[Order Details] As OD
													Where	O.OrderID = OD.OrderID) + O.Freight, 2) As Monto
									From	Orders As O
											Join Employees As E
												On E.EmployeeID = O.EmployeeID) As TD1
							Group by Empleado, A�o) As TD2) As TD4
		Where	Round(TD4.Total, 2) = Round(TD4.MontoMayorA�o, 2)) As TD5
Group by Empleado
Order By Count(*) Desc