-- 1.- Haz un listado que muestre el id y el nombre de los
-- productos que se han vendido unicamente una vez durante el año (cualquier año)

--PASO1
select P.ProductID,P.ProductName,YEAR(o.OrderDate),count(p.ProductID)
from [Order Details] OD
    join Products P
        on OD.ProductID = P.ProductID
    join Orders O
        on OD.OrderID = O.OrderID
group by P.ProductID, P.ProductName,O.OrderDate
-- having count(p.ProductID)=1
order by count(p.ProductID);


select VendidoA.ProductID,
       VendidoA.ProductName,
       VendidoA.Año,
       count(VendidoA.Cantidad) CANTI_PORAÑO
from (select o.OrderID,
             P.ProductID,
             P.ProductName,
             YEAR(o.OrderDate) Año,
             count(p.ProductID) Cantidad
      from [Order Details] OD
               join Products P
                    on OD.ProductID = P.ProductID
               join Orders O
                    on OD.OrderID = O.OrderID
      group by P.ProductID, P.ProductName, O.OrderDate,O.OrderID) VendidoA
GROUP BY VendidoA.ProductID, VendidoA.ProductName,VendidoA.Año
having count(VendidoA.ProductID)=1;
