

--DELETE

-- CREANDO UN BACKUP DE LA TABLA

select *
into EmployeeTerritoriesBackup
from EmployeeTerritories;

--DELETE SIMPLE SIEMPRE CON WHERE
delete
from EmployeeTerritories
where TerritoryID='01833';
--DATO BORRADO
select *
from EmployeeTerritories
where TerritoryID='01833';


--ELIMAR CON DELETE EN VARIAS TABLAS
    --SELECT DE LOS DE REINO UNIDO
    select *
    from EmployeeTerritories ET
        join Employees E
            on ET.EmployeeID = E.EmployeeID
    where e.Country='UK';

--DELETE DE MULTITABLAS

DELETE ET
    from EmployeeTerritories ET
        join Employees E
            on ET.EmployeeID = E.EmployeeID
    where e.Country='UK';

--NOTA
--EL DELETE PUEDE SER IGUAL AL SELECT SOLO CON ALGUNAS RESTRICCIONES
-- PUEDE TENER ALL LO DE UN SELECT

DELETE TOP (5) ET
    --SELECT TOP 5 *
    from EmployeeTerritories ET
        join Employees E
            on ET.EmployeeID = E.EmployeeID;

--VER LOS ELIMINADO DESPUES DE UN DELETE
--OPCION1 FORMA MANUAL SIN TENER MUCHO CONOCIMIENTO
    SELECT *
    into #TMP
    FROM EmployeeTerritories;


    DELETE TOP (5) ET
        --SELECT TOP 5 *
        from EmployeeTerritories ET
            join Employees E
                on ET.EmployeeID = E.EmployeeID;

    select *
    from #TMP
    except
    select *
    from EmployeeTerritories;


--OPCION2 CON OUTPUT con
-- deleted RECOJO
-- ALL LO QUE SE HA ELIMINADO EN UNA TABLA TEMPORAL

    DELETE TOP (5) ET
        --SELECT TOP 5 *
        OUTPUT deleted.*
        from EmployeeTerritories ET
            join Employees E
                on ET.EmployeeID = E.EmployeeID;


--UPDATE
--ACTUALIZA DATOS EN LAS TABLAS
-- SE PARECE UN POCO AL SELECT NO ES
-- IGUAL PERO ALGUNAS COSAS SI PUEDEN FUNCIONAR

SELECT * FROM Products WHERE UnitPrice>=100

--ACTUALIZANDO

UPDATE Products
SET UnitPrice=UnitPrice*1.1
OUTPUT inserted.ProductID,
        inserted.ProductName,
        deleted.ProductID,
        deleted.ProductName,
        deleted.UnitPrice,
        inserted.UnitPrice
WHERE UnitPrice>=100;

--UPDATE CON MAS DE UNA TABLA
--USANDO FROM

SELECT top (5) [O D].ProductID ID,
       sum([O D].Quantity) as Cantidad
from Products P
    join [Order Details] [O D]
        on P.ProductID = [O D].ProductID
group by [O D].ProductID
order by Cantidad DESC;

UPDATE P
set UnitPrice=UnitPrice*1.05
output inserted.ProductID,
        deleted.UnitPrice as Precio_Anterior,
        inserted.UnitPrice as Precio_Nuevo
FROM Products AS P
JOIN (SELECT top (5) [O D].ProductID ID,
                    sum([O D].Quantity) as Cantidad
      from Products P
               join [Order Details] [O D] on P.ProductID = [O D].ProductID
      group by [O D].ProductID
      order by Cantidad DESC) as MP
on P.ProductID=MP.ID;

