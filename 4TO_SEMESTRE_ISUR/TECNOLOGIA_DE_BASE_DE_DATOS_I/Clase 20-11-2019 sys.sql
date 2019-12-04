--Metadata -> SON LOS DAOS ACERCA DE LOS DATOS
-- Tablas SYS

    ---sysobjects para consultar los objetos de una base de datos
    select *
    from sysobjects;

    --sys.objects

    select *
    from sys.objects
    order by type, name;

    select *
    from sys.objects
    where parent_object_id=965578478
    order by type, name;

    --syscolumns

    select *
    from syscolumns;
    
    --sys.columns

    select *
    from sys.columns;
    
    --sys.tables
    select *
    from sys.tables;

    --sys.procedures
    
    select *
    from sys.procedures;
    
    --sys.views

    select *
    from sys.views;
    
    --sys.databases_files

    select *
    from sys.database_files;


--Procedimientos almacenado para trabajar con la metadata

    --SP_WHO -> permite ver las conecciones q hay

    sp_who;

    --SP_WHO2
    sp_who2;

    --