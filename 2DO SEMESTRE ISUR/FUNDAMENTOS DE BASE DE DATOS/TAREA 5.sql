
---consulta con select para sacar la suma total de productos  
---adquiridos en un orden

select sum(od.Quantity*od.UnitPrice
-round(od.Quantity*od.UnitPrice*od.Discount,1)) Total  
from [Order Details] OD
where od.OrderID=10248
group by od.OrderID

---funcion con el select

create function Total(@id int)
returns numeric(18,2)
as 
begin
return (select sum(od.Quantity*od.UnitPrice
-round(od.Quantity*od.UnitPrice*od.Discount,1))
+o.Freight Total  
from [Order Details] OD,Orders O
where od.OrderID=@id and OD.OrderID=o.OrderID
group by od.OrderID,o.Freight) 
end

----drop para elimininar la funcion total

drop function Total

----prueba de la funcion total

declare @total1 numeric (18,2)
set @total1=dbo.Total(10248)
print @total1

---tabla nueva q guarda el total y el id de la orden

create table ordernes_Total(
OrderId int primary key,
Total numeric (18,2) null default 0
)

---insert para copiar los datos de las ordenes antiguas con el total

insert into ordernes_Total(OrderId,Total)
select od.OrderID,sum(od.Quantity*od.UnitPrice
-round(od.Quantity*od.UnitPrice*od.Discount,1))
+o.Freight Total 
from [Order Details] OD,Orders O
where od.OrderID=o.OrderID
group by od.OrderID,o.Freight

delete ordernes_Total


----traigger para que cuando se inserte un nuevo registro en la tabla [Order Details]
----se actualice el total de dicha orden en la tabla ordernes total

create trigger actualizar_total
on[Order Details]
after insert
as
declare @id int = (select inserted.OrderID from inserted)
declare @total numeric (18,2)
set @total=(dbo.Total (@id))
update ordernes_Total set Total=@total
where OrderId=@id

drop trigger actualizar_total


----funcion para sacar el precio unitario de un producto segun su id

create function preciounitario(@idpro int)
returns money
as begin
return (select p.UnitPrice from Products P 
where P.ProductID=@idpro)
end


----trigger para cuando se inserte un nuevo registro en la tabla orders 
----se genere un registro automatico en la tabla ordenes_total con el id de la orden y el total que solo
----seria el freight o costo de envio 

create trigger nueva_orden
on Orders
after insert
as
declare @id int=(select inserted.OrderID from inserted)
declare @total numeric (18,2)=
(select inserted.Freight from inserted)
insert into ordernes_Total values
(@id,@total)

drop trigger nueva_orden

---pruebas

insert into [Order Details] values 
(11079,2,dbo.preciounitario (2),2,0)

select * from ordernes_Total

insert into Orders values 
('RATTC',1,GETDATE(),GETDATE()+30,GETDATE()+3,2,10.30
,'asdasda','asdasdasda','12asa','loqsea','123456','USA')

select * from Orders


