--Haz una función escalar que reciba un cliente y 
--devuelva la fecha de la última compra de dicho cliente. 
--Luego haz una consulta donde uses la función.


create or
alter function Pregunta4(@NombreCliente varchar(max))
    returns date
as
begin
    declare @FechaUltimo date;
    select @FechaUltimo = max(o.OrderDate)
    from Customers C
             inner join Orders O on C.CustomerID = O.CustomerID
    where c.ContactName = @NombreCliente
    group by c.ContactName;
    return @FechaUltimo;
end

select dbo.Pregunta4('Paul Henriot');

