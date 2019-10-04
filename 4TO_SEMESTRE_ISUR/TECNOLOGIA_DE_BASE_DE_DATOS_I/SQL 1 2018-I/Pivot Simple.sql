Select	Periodo,
		 Round([Dairy Products] , 2)  As [Dairy Products],
		 Round([Grains/Cereals] , 2)  As [Grains/Cereals]
		, Round([Produce]		 , 2)  As [Produce]
		, Round([Seafood]		 , 2)  As [Seafood]
		, Round([Condiments]	 , 2)  As [Condiments]
		, Round([Confections]	 , 2)  As [Confections]
		, Round([Beverages]		 , 2)  As [Beverages]
		, Round([Meat/Poultry]	 , 2)  As [Meat/Poultry]
From
(SELECT     C.CategoryName,
			Format(O.OrderDate, 'MMMM yyyy', 'ES-pe') As Periodo,
			Year(O.OrderDate) As Año,
			Month(O.OrderDate) As Mes,
			OD.Quantity * OD.UnitPrice * (1-OD.Discount)+(O.Freight/Count(*) Over(partition by O.OrderID Order By O.OrderID)) As Monto
FROM            Orders AS O INNER JOIN
                         [Order Details] AS OD ON O.OrderID = OD.OrderID INNER JOIN
                         Products AS P ON OD.ProductID = P.ProductID INNER JOIN
                         Categories AS C ON P.CategoryID = C.CategoryID) As Datos

Pivot ( Sum(Monto) For categoryName In ([Dairy Products],
										 [Grains/Cereals]
										, [Produce]
										, [Seafood]
										, [Condiments]
										, [Confections]
										, [Beverages]
										, [Meat/Poultry])

) As PT
Order By Año, Mes