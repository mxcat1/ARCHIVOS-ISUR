With CTE
As
(
	--Ancla/Semilla
	Select	Row_Number() Over (Order By C.CategoryName) As Codigo,
			C.CategoryName As Nombre
	From	Categories As C
	Union All
	--Recursiva
	Select	Dense_Rank() Over (Order By CA.CategoryName)+ Convert(Numeric(4,2), Row_Number() Over (partition by P.CategoryID Order By P.ProductName))/100 As Codigo,
			' --> ' + P.ProductName
	From	Products As P
			Join Categories As CA
				On CA.CategoryID = P.CategoryID
)
Select	*
From	CTE
Order By 1
------------------------
Select	'00' + Convert(Varchar(3), Dense_Rank() Over(Order By C.CategoryName)) ,
		C.CategoryName
From	Categories As C
Union
Select	Right('00' + Convert(Varchar(3), Dense_Rank() Over(Order By C.CategoryName)), 3) + '.' +
		Right('00' + Convert(Varchar(3), Row_Number() Over(Partition By C.CategoryName Order By P.ProductName)), 3),
		'--->' + P.ProductName
From	Products As P Join Categories As C
			On C.CategoryID = P.CategoryID
-------------------------------
With CTE
As
(
	--Ancla/Semilla
	Select	Convert(Varchar(7), Right('00' + Convert(Varchar(3), Row_Number() Over (Order By C.CategoryName)), 3)) As Codigo,
			Convert(nVarchar(45), C.CategoryName) As Nombre,
			C.CategoryID As ID,
			1 As Nivel
	From	Categories As C
	Union All
	--Recursiva
	Select	Convert(Varchar(7), CA.Codigo + '.' + Right('00' + Convert(Varchar(3), Row_Number() Over (Partition By CA.ID Order By P.CategoryID)), 3)),
			' --> ' + P.ProductName,
			P.ProductID,
			CA.Nivel + 1
	From	Products As P
			Join CTE As CA
				On CA.ID = P.CategoryID
	Where	CA.Nivel = 1
)
Select	Codigo, Nombre
From	CTE
Order By 1
