Select	P.ProductID,
		P.ProductName,
		(Select Top 1	O.CustomerID + ' - ' + C.CompanyName
						+ '(' + Convert(Varchar(5), Sum(Quantity)) + ')'
			From	Orders As O
				Join [Order Details] As OD	On O.OrderID = OD.OrderID
				Join Customers As C	On C.CustomerID = O.CustomerID
			Where	OD.ProductID = P.ProductID
			Group by O.CustomerID,C.CompanyName,OD.ProductID
			Order By Sum(Quantity) Desc
			) As Cliente
From	Products As P
Order By P.ProductID