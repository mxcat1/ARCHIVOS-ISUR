-- 3.-hacer un update a una tabla y crear un campo llamado estado en la tabla customers
-- 	-el update debe actualizar los datos a los q solo tiene telefono y no tiene
-- 	fax en el cual el campo estado le debe colocar "sin fax"
-- 	-si tiene fax pero no hay telefono colocar en estado "sin telefono"
-- 	-si no tiene ninguno en estado colocar "sin medios de comunicacion"
-- 	-al final que de un listado de todos los clientes cambiados
-- 	y ese listado se guarda en una tabla llamada clientes

--crear campo

select * into CustomersPrueba from Customers;
select * into CustomersPruebaPrueba from CustomersPrueba;
alter table Customers add State varchar(200);

drop table CustomersPrueba;
drop table CustomersPruebaPrueba;

CREATE TABLE [LISTADO DE CLIENTES CAMBIADOS](
    Cliente_cambiado varchar(5),
    Cliente_Estado_Antiguo varchar(200),
    Cliente_Estado_Nuevo varchar(200)
)

update CustomersPrueba
set CustomersPrueba.State=(case when Phone is null and Fax is null then 'Sin Medios de Comunicacion' when Phone is not null and Fax is null then 'Sin Fax' when Phone is null and Fax is not null then 'Sin Telefono' end)
output inserted.CustomerID,
        inserted.State,
        deleted.State
into [LISTADO DE CLIENTES CAMBIADOS]
where (Phone is null and Fax is null) or (Phone is not null and Fax is null) or (Phone is null and Fax is not null);


