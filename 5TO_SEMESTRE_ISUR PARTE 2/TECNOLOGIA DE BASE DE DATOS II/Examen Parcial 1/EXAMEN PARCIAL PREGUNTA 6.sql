--Haz un procedimiento almacenado que reciba 
--los datos de un producto como parámetros e 
--inserte un registro en la tabla de productos con los valores suministrados

create or
alter procedure Pregunta6(@NombreProducto nvarchar(80), @Discontinuado bit, @Proveedor int=null, @Categoria int =null,
                          @CantidadPorUnidad nvarchar(40)=null, @precio money =null, @UnidadesEnStock smallint=null,
                          @UnidadesEnOrden smallint=null, @ReordenarNivel smallint=null)
as
begin
    insert into Products
    values (@NombreProducto, @Proveedor, @Categoria, @CantidadPorUnidad, @precio, @UnidadesEnStock, @UnidadesEnOrden,
            @ReordenarNivel, @Discontinuado)
end
go;
exec dbo.Pregunta6 'Papitas', false;
