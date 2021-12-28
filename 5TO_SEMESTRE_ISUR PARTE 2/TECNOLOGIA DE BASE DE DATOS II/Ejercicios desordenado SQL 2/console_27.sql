-- TRIGGERS DE BASE DE DATOS
-- Este trigger controla DDL CREATE ALTER DROP

-- Este trigger retorna un xml con todos los datos del evento que lo desencadeno
-- en este caso puede ser cuando creas una tabla o cuando eliminas una tabla
create or alter trigger TRIG_1
    on database for create_table,drop_table
    as
begin
    select EVENTDATA()
end
go;

--create table XXXXXXXX(ID int,Nombre varchar(40))

-- Esta cosulta muestra todos los eventos que puede haber en el momento de hacer una accion en una base de datos
select *
from sys.trigger_event_types
--as type where type_name like '%CREATE%'


-- TRIGGERS DE SERVIDOR

create or alter trigger TRIG_2
    on all server
    for Create_Database
    as
begin
    select EVENTDATA()
end

-- create database Prueba

-- TRIGGERS DE LOGON
create table Logueos
(
    ID         UNIQUEIDENTIFIER,
    Daos       XML,
    Fecha      DATE,
    Aplicacion varchar(max)
)

create or alter trigger TRIG_3
    on all server
    for logon
    as
begin
    declare @app varchar(max)
    set @app = PROGRAM_NAME()
--     if @app = 'Microsoft Office'
--         ROLLBACK   ----IF QUE ME NIEGA LACONECCION ALA ABSE DE DATOS POR EXCEL O CUALQUIER PROGRAMA DEL APQUETE OFFICE
    ---Practicamente el rollback niega la ejecucion del evento que desencadeno un trigger
    insert into Northwind.dbo.Logueos
    values (NEWID(), EVENTDATA(), GETDATE(), @app)
end

select *
from Northwind.dbo.Logueos