Select t1.CategoryName,t1.Cantidad_Productos_Activos,t2.Cantidad_Productos_Inactivos
from (

		select c.CategoryID,c.CategoryName,count(td.ProductID) as Cantidad_Productos_Activos
		from Categories as c join (Select p.ProductID,p.CategoryID
									from Products as p
									where p.Discontinued=0) as td
		on c.CategoryID=td.CategoryID
		group by c.CategoryID,c.CategoryName ) as T1 join 		

		(select c.CategoryID,c.CategoryName,count(td1.ProductID) as Cantidad_Productos_Inactivos
		from Categories as c left join (Select p.ProductID,p.CategoryID
									from Products as p
									where p.Discontinued=1) as td1
		on c.CategoryID=td1.CategoryID
		group by c.CategoryID,c.CategoryName ) as T2
on t1.CategoryID=t2.CategoryID


