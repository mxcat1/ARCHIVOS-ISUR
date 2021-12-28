-- OJO
-- Para ver informacion de un procedimiento o de los procedimientos almacenados

select*
from sys.procedures;
sp_HelpText CustOrderHist;
sp_Help CustOrderHist;


-- Para encriptar el codigo de un procedimiento almacenado
-- se utiliza with encryption

create procedure Prueba1
    with encryption
as
begin
    select * from Products
end;

    sp_HelpText Prueba1;
go

-- Tablas Temporales

select top 10 *
into #Productos_Mas_Caros
from Products
order by UnitPrice desc

select *
from #Productos_Mas_Caros
go

-- Saber el ID de una Tabla

select OBJECT_ID('Products');

