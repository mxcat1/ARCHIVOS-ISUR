Select	Year(OrderDate) As Año,
		Sum(Freight) As Fletes
From	Orders
Group By Year(OrderDate)
Order By 1

---------------------------
Select	Year(OrderDate) As Año,
		Max(Acumulado) As Flete
From	(
		Select	Sum(Freight)
					Over (Partition By Year(OrderDate)
							Order By OrderID) As Acumulado,
				*
		From	Orders) As TD1
Group By Year(OrderDate)
Order By Año

---------------------------
Select	Distinct Year(OrderDate) As Año,
		Max(Acumulado) 
			Over(Partition By Year(OrderDate) Order By Year(OrderDate)) As Flete
From	(
		Select	Sum(Freight)
					Over (Partition By Year(OrderDate)
							Order By OrderID) As Acumulado,
				*
		From	Orders) As TD1

---------------------------
Select	Distinct Year(OrderDate),
		LAST_VALUE(Acumulado) Over(
					Partition By Year(OrderDate)
					Order By Year(OrderDate))
From
	(
Select	Sum(Freight)
Over (Partition By Year(OrderDate)
		Order By OrderID) As Acumulado,
		*
From	Orders) As TD3
-----------------------------
Select	Year(OrderDate)As Año,
		Acumulado
From	(
Select	Rank() Over(Partition By Year(OrderDate)
					Order By Acumulado Desc) As Puesto,*
From
(
Select	Sum(Freight)
Over (Partition By Year(OrderDate)
		Order By OrderID) As Acumulado,
		*
From	Orders) As TD4) As TD5
Where Puesto = 1
Order By Year(OrderDate)

-----------------------------
	Select	Distinct Sum(Freight)
	Over (Partition By Year(OrderDate)
			Order By Year(OrderDate)) As Acumulado,
			Year(OrderDate)
	From	Orders
----------------------------

Select	Distinct Year(OrderDate), Sum(Freight)
Over (Partition By Year(OrderDate)
		Order By OrderID
		Rows Between Unbounded Preceding  And Unbounded Following
		) As Acumulado
From	Orders
Order By 1
--------------------------------
---- La ultima está a medias!!!
Select	Year(OrderDate), Sum(Freight)
Over (Partition By Year(OrderDate)
		Order By OrderID
		Range Between Current Row And Unbounded Following
		) As Acumulado, *
From	Orders
Order By OrderID