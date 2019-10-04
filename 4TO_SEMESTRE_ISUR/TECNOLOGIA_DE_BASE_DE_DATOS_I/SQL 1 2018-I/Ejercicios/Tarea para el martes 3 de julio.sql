select O.OrderID,
	   O.CustomerID,
	   O.OrderDate,
		  (select max(Ord.OrderDate)
			from Orders Ord
			Where Ord.OrderDate < O.OrderDate and O.CustomerID = ord.CustomerID) as [Fecha Anterior],
			(select min(Ord.OrderDate)
			from Orders Ord
			Where Ord.OrderDate > O.OrderDate and O.CustomerID = ord.CustomerID) as [Fecha Posterior]
		from Orders O
Order by CustomerID, OrderDate

