-- Crear Procedimiento almacenado
-- que me pida como argumentos que
-- pagina quieres Nro Pagina(obligaatorio) y
-- el tamaño de la Pagina(opcional con 10 registros)
-- Tiene que listar los productos paginados,
-- el parametro de salida va a tener la sumatoria de Kardex valorado osea la sumatoria  del precio por la cantidad

create or
alter Procedure Paginacion @NroPagina bigint, @TamanioPagina bigint = 10, @sumaKardex decimal(16, 2) output
as
begin
    declare @paginado tinyint = @NroPagina * @TamanioPagina
    select * from Products order by ProductID offset @paginado rows fetch next @TamanioPagina rows only;

    select @sumaKardex = sum(SumaCantidadXPrecio)
    from (select sum(UnitPrice * UnitsInStock) SumaCantidadXPrecio
          from Products
          group by ProductID
          order by ProductID
          offset @paginado rows fetch next @TamanioPagina rows only) SumasTotales;

end
go;

declare @suma decimal(16, 2)
exec Paginacion 0, 10, @suma output
select @suma
go

-- Pruebas no Ejecutar
select *
from Products
order by ProductID
offset 10 rows fetch next 10 rows only;

select sum(sumas)
from (select sum(UnitPrice * UnitsInStock) sumas
      from Products
      group by ProductID, UnitsInStock, UnitPrice
      order by ProductID
      offset 50 rows fetch next 5 rows only
     ) SumasTotales;

select *
from Products
where ProductID between 50 and 55
order by ProductID


create or
alter Procedure Paginacion2 @NroPagina bigint, @TamanioPagina bigint = 10, @sumaKardex decimal(16, 2) output
as
begin
    declare @paginado tinyint = @NroPagina * @TamanioPagina
    select * from Products where ProductID between @paginado + 1 and @paginado + @TamanioPagina order by ProductID;

    select @sumaKardex = sum(SumaCantidadXPrecio)
    from (select sum(UnitPrice * UnitsInStock) SumaCantidadXPrecio
          from Products
          where ProductID between @paginado + 1 and @paginado + @TamanioPagina
          group by ProductID) SumasTotales;

end
go;

-- Set nocount on para q no salga la cantidad de filas afectadas o usadas
declare @suma decimal(16, 2)
exec Paginacion 0, 10, @suma output
select @suma
go;