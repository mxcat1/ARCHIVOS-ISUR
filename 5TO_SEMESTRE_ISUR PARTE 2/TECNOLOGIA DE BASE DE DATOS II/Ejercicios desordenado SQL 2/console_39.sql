-- SELECT      sys.databases.name AS [Base de Datos],
-- CONVERT(VARCHAR,SUM(size)*8/1024)+' MB' AS [Tamaño en disco]
-- FROM        sys.databases
-- JOIN        sys.master_files
-- ON          sys.databases.database_id=sys.master_files.database_id
-- where databases.name='Northwind'
-- GROUP BY    sys.databases.name
-- ORDER BY    sys.databases.name




declare @tabladb1 table (NombreBD varchar(max),[Tamaño en disco] int)

insert into @tabladb1 select name,size from sys.master_files where name like DB_NAME()+'%'
select * from @tabladb1;

SELECT DB_NAME() AS [Current Database];
GO