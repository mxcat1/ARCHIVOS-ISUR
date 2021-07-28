-- Transacciones

select @@trancount --INDICA CUANTAS TRASACCIONES HAY EN EJECUCION

--CREAR EL CAMPO DE SUBTOTAL EN ORDERS
-- Ejmplo donde en la tabla de ordes se le incluye
-- un campo llamado subtotal

-- Inicio de una trasaccion
begin transaction

-- Operaciones CUD (INSERT DELETE UPDATE)

insert into [Order Details]
values (11077, 5, 5, 17, 0.05);

update Orders
set Subtotal= (select sum(od.UnitPrice * od.Quantity * (1 - od.Discount))
from [Order Details] as OD where OrderID = 11077)
where Orders.OrderID = 11077

-- TODO ESTA OKEY?
    ---SI ES CORRECTO
    commit transaction
--  no hubo un error cancelar la transaccion(solo puede haber o un commit o un rollback)
--     rollback transaction

-- EJEMPLO 2 con error ya que se pone un producto con codigo 80 q no existe
-- Inicio de una trasaccion
begin transaction

-- Operaciones CUD (INSERT DELETE UPDATE)

begin try

    insert into [Order Details]
    values (11076, 80, 5, 17, 0.05);

    update Orders
    set Subtotal= (select sum(od.UnitPrice * od.Quantity * (1 - od.Discount))
    from [Order Details] as OD where OrderID = 11077)
    where Orders.OrderID = 11077

end try
begin catch
    rollback transaction
end catch

-- TODO ESTA OKEY?
    ---SI ES CORRECTO
if @@trancount>0
    commit transaction
--  no hubo un error cancelar la transaccion(solo puede haber o un commit o un rollback)
--     rollback transaction

----------------------------------------------------
-- Ejemplo 3

begin tran
    delete from [Order Details] where OrderID = 11076
    delete from Orders where OrderID = 11076
commit