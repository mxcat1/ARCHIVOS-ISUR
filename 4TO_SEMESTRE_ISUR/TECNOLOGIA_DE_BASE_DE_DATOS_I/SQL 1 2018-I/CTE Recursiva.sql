With	CTE
As
(	--ANCHOR
	Select	EmployeeID,
			FirstName,
			LastName,
			1 As Nivel
	From	Employees As E
	Where	ReportsTo Is Null
	UNION ALL
	--RECURSIVE
	Select	Empleado.EmployeeID,
			Empleado.FirstName,
			Empleado.LastName,
			Jefe.Nivel + 1 As Nivel
	From	Employees As Empleado
			Join CTE As Jefe
			On Empleado.ReportsTo = Jefe.EmployeeID
)
Select	*
From	CTE