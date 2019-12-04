Begin --'Declaro y pongo valores a las variables'
	Declare @Ceros Int;
	Declare @Años Varchar(MAX);

	Select @Años = String_AGG(Año, ',') From (Select Distinct Top 100 Percent QuoteName(DatePart(Year, OrderDate)) As Año
	From	Orders
	Order By 1) As TD

	Select @Ceros = Len(Nro)
	From
		(Select	Top 1
				Count(*) As Nro
	From	Employees
	Group By ReportsTo
	Order By 1 Desc) As TD;
End;
exec('With CTE
As
(
--ANCHOR
Select	E.EmployeeID As ID,
		Convert(VARCHAR(max), Coalesce(E.TitleOfCourtesy + '' '', '''') + 
		E.FirstName + '' '' + E.LastName + 
		Coalesce('' ('' + E.Title + '')'', '''')) As Empleado,
		0 As Nivel,
		Right(Replicate(''0'', ' + @Ceros + ') + Convert(Varchar(MAX), ROW_NUMBER() Over(Order By E.HireDate)),' + @Ceros + ') As Codigo
From	Employees As E
Where	IsNull(ReportsTo, -1)= -1
--Where	ReportsTo Is Null
--RECURSIVE
Union All
Select	E.EmployeeID As ID,
		Convert(varchar(max), REPLICATE('' '', (J.Nivel + 1) * 8) + Coalesce(E.TitleOfCourtesy + '' '', '''') + 
		E.FirstName + '' '' + E.LastName + 
		Coalesce('' ('' + E.Title + '')'', '''')) As Empleado,
		J.Nivel + 1,
		J.Codigo + ''.'' + Right(replicate(''0'', ' + @Ceros + ') + Convert(Varchar(MAX), ROW_NUMBER() Over(Order By E.HireDate)), ' + @Ceros + ')
From	Employees As E
		Join CTE As J
			On J.ID = E.ReportsTo
)
Select	*
From
(Select	E.Codigo,
		E.Empleado,
		IsNull(DateName(Year, O.OrderDate), ''Total'') As Año,
		Sum(OS.Subtotal + O.Freight) As Monto
From	CTE	As E
		Join Orders As O
			On E.ID = O.EmployeeID
		Join [Order Subtotals] As OS
			On O.OrderID = OS.OrderID
Group By E.Codigo,
		E.Empleado,
		DateName(Year, O.OrderDate)
		With Rollup
Having Not E.Codigo Is Null
		And Not E.Empleado Is Null) As TD
Pivot (Sum(Monto)
		For Año In (' + @Años + ', [Total])
		) As PVT
		Order By Codigo');
Go