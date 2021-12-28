-- 1.- Haz un procedimiento almacenado que pida un precio de producto como argumento opcional.
-- El procedimiento debe mostrar todos los productos que cuesten menos que el precio pasado como argumento.
-- Si no se pone un precio entonces deberán salir todos los productos. Se debe mostrar el ID, nombre y precio de cada producto.

create or
alter procedure BusquedadPrecioProducto @PrecioProducto Money = 919999999999999
as
begin
    select ProductID, ProductName, UnitPrice from Products where UnitPrice < @PrecioProducto order by ProductID
end
go

exec BusquedadPrecioProducto 10;
exec BusquedadPrecioProducto ;
