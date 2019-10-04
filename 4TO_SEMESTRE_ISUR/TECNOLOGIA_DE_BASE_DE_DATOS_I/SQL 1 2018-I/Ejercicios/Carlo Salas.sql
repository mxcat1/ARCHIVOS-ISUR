/*
Hacer un listado de productos(ID,Name,UnitPrice) que pertenezcan a cualquiera de las tres 
categorias con mas ventas(considera descuentos)
*/
select P.ProductID,
       P.ProductName,
	   P.UnitPrice
from Products P
where exists(
	select CategoryID
	from(
		select top 3 C.CategoryID,
			   C.CategoryName,
			   round(sum(OD.Quantity * OD.UnitPrice * (1-OD.Discount)),2) as Monto
		from Categories C
			 join Products P
			 on C.CategoryID = P.CategoryID join [Order Details] OD
			 on OD.ProductID = P.ProductID
		group by C.CategoryID,
				 C.CategoryName
		order by Monto Desc) as Categoria
		where P.CategoryID = Categoria.CategoryID)