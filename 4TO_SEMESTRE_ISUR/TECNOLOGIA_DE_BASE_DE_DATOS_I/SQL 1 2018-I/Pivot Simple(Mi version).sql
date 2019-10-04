select  Periodo,
       round([Dairy Products],2)as  [Dairy Products] ,
	   round([Grains/Cereals],2)as  [Grains/Cereals],
       round([Produce],		  2)as  [Produce]      ,
       round([Seafood],		  2)as  [Seafood]      ,
       round([Condiments],	  2)as  [Condiments]      ,
       round([Confections],	  2)as  [Confections]      ,
       round([Beverages],	  2)as  [Beverages]      ,
       round([Meat/Poultry],2) as [Meat/Poultry]
from(
	select Periodo,
	       CategoryName,
		   (Freight/count(*)over(partition by OrderID)) + SubTotal as Total
	from(
		select format(O.OrderDate, 'MMMM yyyy', 'ES-PE') as Periodo,
			   O.OrderID,
			   C.CategoryName,
			   O.Freight,
			   OD.Quantity * OD.UnitPrice *(1-OD.Discount) as SubTotal
		from Orders O join [Order Details] OD 
		on O.OrderID = OD.OrderID 
		join Products P 
		on OD.ProductID = P.ProductID 
		join Categories C 
		on P.CategoryID = C.CategoryID
		) ST
	) P
pivot(sum(Total) for CategoryName in ([Dairy Products],
[Grains/Cereals],
[Produce],
[Seafood],
[Condiments],
[Confections],
[Beverages],
[Meat/Poultry]
)) as PVT