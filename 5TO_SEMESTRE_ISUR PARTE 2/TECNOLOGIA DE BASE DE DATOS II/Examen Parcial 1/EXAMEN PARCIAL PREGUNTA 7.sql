
--Haz un trigger que se dispare cuando se eliminan 
--ítems de órdenes de compra, si se han eliminado todos 
--los ítems entonces SQL debe borrar automáticamente la cabecera

create or alter trigger Pregunta7
    on [Order Details]
    for delete
    as
begin
    declare @itemsOrderDetails bigint,@orderdetailelimado int;
    select @itemsOrderDetails = count(*)
    from [Order Details],
         deleted
    where [Order Details].OrderID = deleted.OrderID
    select @orderdetailelimado=deleted.OrderID from deleted;
    if (@itemsOrderDetails = 0)
        begin
            delete from Orders where Orders.OrderID = @orderdetailelimado;
        end
    else
    begin
        print 'Se elimino la orden '+ convert(varchar(max),@orderdetailelimado) +'Todavia quedan '+ convert(varchar(max),@itemsOrderDetails) +' de ordenes';
    end
end;

delete from [Order Details] where [Order Details].OrderID=10248 and [Order Details].ProductID=72;