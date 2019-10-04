/*
3.CTE: Jerarquia de productos
*/

with CTE as(
select C.CategoryID as ID,
       Convert(varchar(100),C.CategoryName) as Nombre,
	   1 as nivel
from Categories C 

union all

select CTE.ID as ID,
       Convert(varchar(100),P.ProductName) as Nombre,
	   CTE.nivel + 1 as Nivel
from Products P join CTE
on P.CategoryID = CTE.ID
Where CTE.nivel < 2
) 
select distinct *
from CTE


