-- Clase 1 del Curso Base de Datos 2

-- Procedimiento Almacenado

-- Crear un Procedimiento Almacenado
create procedure ProductosXStock
as
begin
    select ProductName, UnitsInStock from Products order by UnitsInStock desc;
end;
GO

-- Modificar el Procedimiento almacenando

alter procedure ProductosXStock
as
begin
    select ProductID, ProductName, UnitsInStock from Products order by UnitsInStock desc;
end;

go

-- Para Obtener la info o el codigo de una procedimiento almacenado
Sp_Helptext ProductosXStock;
go
select *
from sys.procedures;
go

-- Eliminar El procedimiento Almacenado
drop procedure ProductosXStock;
go

-- Comando donde se combina el Create o el Alter
create or
alter procedure ProductosXStock
as
begin
    select ProductID, ProductName, UnitsInStock from Products order by UnitsInStock desc;
end;
go

-- Felxibilidad con variables y parametros
create or
alter procedure ProductosXStock @Letra as char(1), @Order as varchar(10)
as
begin
    select ProductID, ProductName, UnitsInStock
    from Products
    where ProductName like @Letra + '%'
    order by Iif(@Order = 'Stock', 'UnitsInStock', 'ProductName') desc;
end;
go

-- Argumentos obligatorios u opcionales
create or
alter procedure ProductosXStock @Letra as varchar(1)='' --Argumento de entrada opcional
as
begin
    select ProductID, ProductName, UnitsInStock
    from Products
    where ProductName like @Letra + '%'
    order by UnitsInStock desc;
end;
go

-- Argumentos de ENTRADA Y SALIDA
alter procedure ProductosXStock @Letra as varchar='', @Suma as BIGINT OUTPUT
as
begin
    select ProductID, ProductName, UnitsInStock
    from Products
    where ProductName like @Letra + '%'
    order by UnitsInStock desc;

    select @Suma = sum(UnitsInStock)
    from Products
    where ProductName like @Letra + '%'

end;
go
-- Sin el Ultimo Alter
exec ProductosXStock 'G', 'Stock';
go
/*Para ejecturar el procedimiento con un parametro de salida y uno de entrada es necesario
usar el output y declarar una variable donde se guardara dicho dato de salida */
declare @s bigint;
exec ProductosXStock 'G', @s output ;
select @s;
go

