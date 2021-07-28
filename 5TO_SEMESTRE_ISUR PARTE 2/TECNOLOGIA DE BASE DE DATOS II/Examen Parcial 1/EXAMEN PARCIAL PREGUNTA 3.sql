
--Haz una TVF que reciba el nombre de una categoría y devuelva 
--todos los productos de la categoría (nombre y precio) Usa la TVF en una consulta

create or
alter function Pregunta3(@NombreCategoria as varchar(max))
    returns TABLE
        as
        return
            (
                select p.ProductName, p.UnitPrice
                from Products P
                         inner join Categories C2 on C2.CategoryID = P.CategoryID
                where C2.CategoryName = @NombreCategoria
            )
go;

select *
from dbo.Pregunta3('Beverages');
