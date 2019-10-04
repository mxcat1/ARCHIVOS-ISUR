Select	O.OrderID,
		O.CustomerID,
		O.OrderDate,
		Lag(O.OrderDate, 1)
			Over(Partition By O.CustomerID
				Order By O.OrderDate) As Ultima_Orden,
		DateDiff(Day, Lag(O.OrderDate, 1)
			Over(Partition By O.CustomerID
				Order By O.OrderDate), O.OrderDate) As Dias,
			LAST_VALUE(O.OrderDate)
				Over(Partition By O.CustomerID
				Order By O.OrderDate
				Rows Between Unbounded Preceding And 1 Preceding) As USANDO_LAST,
		Lead(O.OrderDate, 1)
			Over(Partition By O.CustomerID
				Order By O.OrderDate) As Siguiente_Orden
From	Orders As O
--Order By O.OrderID