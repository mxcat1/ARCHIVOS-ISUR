/*5.	Haz un listado que muestre
el nombre de los empleados 
que jamás le hayan vendido a 
clientes noruegos	3 Ptos*/
Select	FirstName + ' ' + lastName
From	Employees
Where	EmployeeID Not In (
			Select	O.EmployeeID
			From	Customers As C
					Join Orders As O
						On C.CustomerID = O.CustomerID
			Where	C.Country = 'Norway')