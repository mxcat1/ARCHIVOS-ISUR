--TAREA

--QUIERO VER UN LISTADO QUE ME DIGA POR CLIENTE QUE PRODUCTOS(NOMBRE) HA COMPRADO , PERIODO DE LA COMPRA(FECHA DE LA COMPRA EJM'MAR-96')
--EL MONTO DE LA COMPRA Y QUE SE VEA CONBINACIONES DE TODOS CONTRA TODOS
-- Y HAY QUE INCLUIR LOS CLIENTE QUE NO TE COMPRARON Y QUE DIGA QUE ESE CLIENTE COMPRO CERO
-- NOTA INCLUIR TODOS LOS CLIENTES POR CADA MES



SELECT C.CompanyName,
       P.ProductName,
       o.OrderDate,
       convert(varchar(100),month(o.OrderDate)) +'/'+ convert(varchar(100),year(o.OrderDate)) [Mes Año],
       (od.Quantity*od.UnitPrice) Total
FROM Customers C
join Orders O
    on C.CustomerID = O.CustomerID
join [Order Details] OD
    on O.OrderID = OD.OrderID
join Products P
    on OD.ProductID = P.ProductID
order by [Mes Año];

SELECT C.CompanyName,
       P.ProductName,
       o.OrderDate,
       convert(varchar(100),datename(month,(o.OrderDate))) +'/'+ convert(varchar(100),year(o.OrderDate)) [Mes Año],
       (od.Quantity*od.UnitPrice) Total,
       lista.Date
FROM (SELECT DATEADD(month ,number+1,'19951201') [Date]
        FROM master..spt_values
        WHERE type = 'P'
        AND DATEADD(DAY,number+1,'19960101') < '20001201') lista,Customers C
join Orders O
    on C.CustomerID = O.CustomerID
join [Order Details] OD
    on O.OrderID = OD.OrderID
join Products P
    on OD.ProductID = P.ProductID
where O.OrderDate=lista.Date
order by [Mes Año];


DECLARE @Date1 DATE, @Date2 DATE
SET @Date1 = '20150528'
SET @Date2 = '20160531'

SELECT DATEADD(month ,number+1,'20150528') [Date]
FROM master..spt_values
WHERE type = 'P'
AND DATEADD(DAY,number+1,'20150528') < '20160531'