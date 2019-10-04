With	Jerarquia
As
(
--Ancla
Select	EmployeeID As ID,
		Convert(Varchar(80), FirstName + ' ' + LastName) As Nombre,
		1 As Nivel,
		Convert(Varchar(29), Row_Number() Over(Order By LastName)) As Orden
From	Employees
Where	ReportsTo Is Null
	
Union All
--Recursiva
Select	EmployeeID,
		Convert(Varchar(80), REPLICATE(' ',J.Nivel * 5) + FirstName + ' ' + LastName),
		J.Nivel + 1,
		Convert(Varchar(29), J.Orden + '.' + Convert(varchar(2), Row_Number() Over(Order By LastName)))
From	Employees As E
		Join Jerarquia As J
			On E.ReportsTo = J.ID
)Select	Nombre
From	Jerarquia
Order By Orden