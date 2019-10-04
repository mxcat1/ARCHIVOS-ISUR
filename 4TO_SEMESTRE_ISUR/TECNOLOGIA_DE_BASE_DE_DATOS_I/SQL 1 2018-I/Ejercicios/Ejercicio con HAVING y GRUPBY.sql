/*
Nombre de los productos que se han vendido en menos de 10 ordenes del 
primer trimestre cada año
*/

--FORMA CON TABLA DERIVADA
select P.ProductName,
        count(Ordenes.OrderID) as [Ordenes Limitadas]
from(
	select  OD.ProductID, O.OrderID, MONTH(O.OrderDate)as Mes, Year(O.OrderDate) as Anio
	from Orders O join [Order Details] OD
	 on O.OrderID = OD.OrderID
	Where Month(O.OrderDate) in (1,2,3)) as Ordenes

join Products P

on P.ProductID = Ordenes.ProductID
group by P.ProductName
having count(Ordenes.OrderID) < 10


--FORMA CON JOINS SIMPLES

select P.ProductName, 
	   count(*) as Cantidad
from Orders O 
    join [Order Details] as OD on O.OrderID = OD.OrderID
	join Products as P on P.ProductID = OD.ProductID
where DATEPART(QUARTER, O.OrderDate) = 1
group by P.ProductName
Having Count(*) < 10

--FORMA CON IN
select P.ProductName
from Products P
where P.ProductID in(
		select OD.ProductID
		from [Order Details] OD join Orders O
		on OD.OrderID = O.OrderID
		Where Month(O.OrderDate) in (1,2,3)
		group by OD.ProductID
		having count(OD.OrderID) < 10)

--FORMA CON EXISTS
select P.ProductName
from Products P
where exists (
		select OD.ProductID
		from [Order Details] OD join Orders O
		on OD.OrderID = O.OrderID
		Where Month(O.OrderDate) in (1,2,3)and
		P.ProductID = OD.ProductID
		group by OD.ProductID
		having count(OD.OrderID) < 10)


