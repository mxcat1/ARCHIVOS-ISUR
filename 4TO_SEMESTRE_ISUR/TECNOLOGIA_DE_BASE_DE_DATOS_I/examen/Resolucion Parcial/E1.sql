/*1.	Haz un listado que muestre el ID
y nombre de los productos que se han
vendido �nicamente una vez durante
el a�o (cualquier a�o)	3 Ptos*/
Select 	OD.ProductID,
	P.ProductName
From	Orders As O
	Join [Order Details] As OD
		On O.OrderID = OD.OrderID
	Join Products As P
		On P.ProductID = OD.ProductID
Group by Year(O.OrderDate),
	OD.ProductID,
	P.ProductName
	Having Count(*) = 1