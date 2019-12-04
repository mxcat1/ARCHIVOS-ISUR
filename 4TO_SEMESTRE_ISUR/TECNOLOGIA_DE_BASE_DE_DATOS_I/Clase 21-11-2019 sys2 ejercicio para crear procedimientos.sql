--consultas sys de tablas del sistema

-- INFORMATION_SCHEMA.TABLES

select *
from INFORMATION_SCHEMA.TABLES;

select *
from INFORMATION_SCHEMA.COLUMNS;


--Ejercicio1 con metadata (sys)
--Crear Procedimientos para mis tablas

declare @Tabla varchar(40);

set @Tabla = 'Customers';

EXECUTE sp_executesql N'select *
from @Tabla',
    N'@Tabla varchar',@Tabla; --funcionana pero no con los q tiene espacio en blanco

select *
from sys.key_constraints join sys.tables on sys.key_constraints.parent_object_id=sys.tables.object_id;
select *
from syscolumns;

select *
from sys.indexes;

--sp_helptext sirve para ver el codigo de un procedimiento o vista