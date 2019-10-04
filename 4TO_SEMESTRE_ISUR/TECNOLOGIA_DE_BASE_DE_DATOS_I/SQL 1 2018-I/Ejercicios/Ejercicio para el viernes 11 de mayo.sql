/*
Usando el operador LIKE: Lista los clientes en cuyo nombre tengan las cinco vocales.
*/
select C.CompanyName
from Customers C 
where C.CompanyName like '%a%' and
		C.CompanyName like '%e%' and
		C.CompanyName like '%i%' and
		C.CompanyName like '%o%' and
		C.CompanyName like '%u%' 

/*
Usando el operador IN: Haz una lista de las órdenes que contengan
productos pertenecientes a 2 o 3 categorías diferentes.
*/

select *
from Orders O
where O.OrderID in(
      select OrderID
	  from(
		select OD.OrderID, 
			   count(distinct C.CategoryName) as Categorias
		from [Order Details] OD join Products P
		on OD.ProductID = P.ProductID join Categories C
		on P.CategoryID = C.CategoryID
		group by Od.OrderID
		having count(distinct C.CategoryName) between 2 and 3) Prod)



/*
Usando el operador EXISTS: Has un listado de las categorías en 
las que exista algún producto discontinuado (Discontinued=1)
*/

select *
from Categories C
where exists(
	select P.CategoryID
	from Products P
	where C.CategoryID = P.CategoryID and
	 P.Discontinued = 1)
