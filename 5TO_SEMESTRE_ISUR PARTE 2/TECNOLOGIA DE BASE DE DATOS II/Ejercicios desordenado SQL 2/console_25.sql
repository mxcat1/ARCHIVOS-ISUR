-- TRIGGER = DESENCADENADORES / DISPARADOR
-- TIPOS :
-- DML: INSERY - DELETE - UPDATE
-- DDL, CREATE - ALTER - DROP
-- LOGON: AL CONECTAR ALA BASE DE DATOS
-- EN: TABLA , BASE DE DATOS, SERVIDOR

--- Todos los triggers tiene un rollback un deshacer

-- TRIGGERS DE TABLA

-- Este primer trigger actualiza el campo monto de la tabla orders pero solo cuando se añade un nuevo registro en al tabla order details
-- el campo monto es llenado con tla suma total del order id con el que se a insertado un nuevo registro
create or alter trigger TRIG_PRUEBA1
    on [Order Details]
    for insert
    as
begin
    update O2
    set O2.Monto = Ordenes.Total
    from inserted as i
             join (select O.OrderID, sum(OD.Quantity * OD.UnitPrice * (1 - OD.Discount)) as Total
                   from Orders as O
                            join [Order Details] as OD on o.OrderID = OD.OrderID
                   group by O.OrderID) as Ordenes on i.OrderID = Ordenes.OrderID
             join Orders as O2 on O2.OrderID = i.OrderID
end
go;

-- trigger que hace un select de lo que se inserto con el comando insert
create or alter trigger TRIG_PRUEBA2
    on [Order Details]
    after insert
    as
begin
    select * from inserted
end
go;

-- En este caso no se hace el insert si no que solo se hace un select de lo que iva a insertarse en la tabla
create or alter trigger TRIG_PRUEBA2
    on [Order Details]
    instead of insert
    as
begin
    select * from inserted
end
go;


-- Este trigger nuevo en lugar de eliminar se hace un update en la tabla productos cambiado el campo de dicontinued
create or alter trigger TRIG_PRUEBA3
    on [Order Details]
    instead of delete
    as
begin
    update Products
    set Discontinued = 1
    from deleted as D
             join Products as P on D.ProductID = p.ProductID
end
go;