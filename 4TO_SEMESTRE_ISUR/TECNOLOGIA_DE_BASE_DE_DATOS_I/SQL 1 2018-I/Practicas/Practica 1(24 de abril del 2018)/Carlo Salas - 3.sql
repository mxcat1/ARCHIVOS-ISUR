/*
3.Listado de Productos que se hayan vendido a mas de 2 precios diferentes 
*/

select *
from Products P

join

(select OD.ProductID,
       count(distinct OD.UnitPrice) as [Precios Distintos]
from [Order Details] OD
group by OD.ProductID
having count(distinct OD.UnitPrice) > 2) as Detalle
on P.ProductID = Detalle.ProductID
