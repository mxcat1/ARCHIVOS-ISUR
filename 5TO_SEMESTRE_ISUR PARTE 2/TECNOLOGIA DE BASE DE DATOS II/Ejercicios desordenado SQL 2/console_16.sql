-- 4.- Haz un procedimiento que reciba un argumento tipo tabla. En dicho argumento se pasarán nombres de países.
-- El procedimiento deberá mostrar el ID del cliente, nombre y país de origen.
-- Se deben mostrar todos los clientes de los países pasados en la tabla.

create type Pais as table
(
    NombrePais varchar(max)
)
go

create or
alter procedure ClientePaises (@Paises Pais readonly)
as
begin
    select CustomerID,ContactName, Country from Customers,@Paises where Country = NombrePais
end
go


declare @tabla1 as Pais
insert into @tabla1 (NombrePais) values ('Argentina'),('Austria'),('Belgium')


exec ClientePaises @tabla1