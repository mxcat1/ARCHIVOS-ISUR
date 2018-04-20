----a.	Elabore un procedimiento almacenado que me permita 
----actualizar el teléfono de un cliente

create procedure actualizar_telefono(@id nchar(5),@telefono nvarchar(24))
as 
begin
update Customers set Phone=@telefono
where CustomerID=@id
end
exec actualizar_telefono 'ALFKI','030-0074322'



----b.	Elabore un procedimiento almacenado que me retorne 
----la cantidad de órdenes que se han efectuado para una región.
select count(lista.RegionID) from
(select o.OrderID,r.RegionID,r.RegionDescription from Orders o inner join Employees E ON
O.EmployeeID=E.EmployeeID INNER JOIN EmployeeTerritories ET
on et.EmployeeID =E.EmployeeID 
inner join Territories T 
on et.TerritoryID=t.TerritoryID
INNER JOIN Region r
ON T.RegionID=R.RegionID
group by OrderID,r.RegionID,r.RegionDescription
) lista
--group by lista.RegionID
where lista.RegionID=1
where lista.RegionDescription='Eastern  
                                         '
create procedure ordenes_region(@region nchar(50))
as begin
select count(lista.RegionID) from
(select o.OrderID,r.RegionID,r.RegionDescription from Orders o inner join Employees E ON
O.EmployeeID=E.EmployeeID INNER JOIN EmployeeTerritories ET
on et.EmployeeID =E.EmployeeID 
inner join Territories T 
on et.TerritoryID=t.TerritoryID
INNER JOIN Region r
ON T.RegionID=R.RegionID
group by OrderID,r.RegionID,r.RegionDescription
) lista
--group by lista.RegionID
where lista.RegionDescription=@region
end

exec dbo.ordenes_region 'Eastern'

----c.	Cree una tabla resumen compuesta por las columnas 
----SupplierID y Total; donde se registre automáticamente la cantidad d
----e productos provistos por un proveedor; esta tablita deberá ser 
----actualizada cada vez que se registre un nuevo producto en la tabla Products; 
----si en la tablita ya existe el proveedor, entonces el total correspondiente a 
----ese proveedor deberá ser actualizado no creado nuevamente.

create table resumen (
SuppliersID int Primary key,
Total numeric(18,0) not null
)
create function idsupplier(@id int)
returns int
as begin 
return (select SuppliersID from resumen where SuppliersID=@id)

end
create function totalproductos(@id int)
returns numeric (18,0)
as begin 
return (select count(ProductID)  from Products where SupplierID= @id)
end
select dbo.idsupplier(1)

create trigger product_supplier
on Products
after insert
as
declare @ids int = (select SupplierID from inserted)
declare @idr int
exec @idr = idsupplier @ids
declare @total numeric 
exec @total=totalproductos @ids
if @ids=@idr
begin
update resumen set Total=@total
where SuppliersID=@ids
end 
else
begin
insert into resumen values(@ids,@total)
end
drop trigger product_supplier

insert into Products values ('papitas3',2,1,'1,50 gr',1.00,100,0,15,0)
delete Products where ProductID=1080