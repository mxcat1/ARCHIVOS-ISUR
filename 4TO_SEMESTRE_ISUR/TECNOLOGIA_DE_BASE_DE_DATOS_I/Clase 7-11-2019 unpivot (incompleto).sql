--UNPIVOT


select ProductName,DatosAle.*
from Products,(select FLOOR(rand()*(101-1)+1) Na) DatosAle;

select *
from DatosUnpivot;

select *
from (select *
from DatosUnpivot) TD1
    unpivot (
    Monto for Mes in ([Enero],[Febrero],[Marzo],[Abril],[Mayo],[Junio],[Julio],[Agosto],[Setiembre],[Octubre],[Noviembre],[Diciembre])
         ) as UPV1;


--Ejericio 1

select s.CompanyName AS PROVEDORES,
       P.ProductName AS PRODUCTO,
       O.ShipCountry AS PAIS,
       (od.Quantity*od.UnitPrice) * (1-od.Discount) as Monto
from [Order Details] OD join Orders O on OD.OrderID = O.OrderID
join Products P on OD.ProductID = P.ProductID join Suppliers S on P.SupplierID = S.SupplierID;

declare @columns varchar(max);
SET @columns = STUFF(
 (
 SELECT
   ',' + QUOTENAME(LTRIM(Pais))
 FROM
   (SELECT DISTINCT ShipCountry As Pais
    FROM Orders
   ) AS T
 ORDER BY
 Pais
 FOR XML PATH('')
 ), 1, 1, '');

print stuff('Arequipa',4,3,'??');

-- remplaza desde un texto despues se indica la posicion luego cuantas va a cambiar y por ultimo con que lo va a cambiar

print @columns;

select STRING_AGG(Pais,',')
from (SELECT DISTINCT quotename(ShipCountry) As Pais
    FROM Orders) TD1;

-- Tarea quiero saber por cada producto cuanto se a vendido cada mes
--EJM

--NOMBRE PRODUCTO       Enero 1996      Febrero 1996      Marzo 1996      Abril 1996      Mayo 1996     ETC....         TOTAL POR AÑO Y MES Y CATEGORIA PRODUCTO
-- Categoria 1          Total           Total               Total           Total           Total       ETC...          Total
--Manzana               50              1500                1110            111             1111        ETC..           Total
--Manzana               50              1500                1110            111             1111        ETC..           Total
--Manzana               50              1500                1110            111             1111        ETC..           Total
-- Categoria 2          Total           Total               Total           Total           Total       ETC...          Total
--Manzana               50              1500                1110            111             1111        ETC..           Total
--Manzana               50              1500                1110            111             1111        ETC..           Total
--Manzana               50              1500                1110            111             1111        ETC..           Total
