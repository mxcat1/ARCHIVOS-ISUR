/*
1.Subconsulta: Listado de productos(ID, Nombre, PrecioPromedio, Cantidad Unidades vendidas)
*/


select P.ProductID,
       P.ProductName,
      (select PrecioPromedio
		from( 
		select OD.ProductID,
		   sum(OD.UnitPrice) as PrecioPromedio   
		from [Order Details] OD
		where P.ProductID = OD.ProductID
		group by OD.ProductID)T) as [Precio Promedio],
		(select Cantidad
		from (
		select OD.ProductID,
			   sum(OD.Quantity) as Cantidad
		from [Order Details] OD
		where OD.ProductID = P.ProductID
		group by OD.ProductID) T ) as [Unidades Vendidas] 
from Products P







	

