Select	Top 1 Empleado
From	(
Select	E.FirstName + ' ' + E.LastName As Empleado,
		Datepart(Year, O.OrderDate) As Año,
		Sum(O.Freight + OS.Subtotal) As Total,
		Rank() Over(Partition By Datepart(Year, O.OrderDate) Order By Sum(O.Freight + OS.Subtotal) Desc) As Puesto
From	Orders As O
		Join [Order Subtotals] As OS
			On O.OrderID = OS.OrderID
		Join Employees As E
			On E.EmployeeID = O.EmployeeID
Group by E.FirstName + ' ' + E.LastName,
		Datepart(Year, O.OrderDate)) As TD1
Where	Puesto = 1
Group By Empleado
Order By Count(*) Desc