--EJE2
--consultar metadata para hacer un tabla que contenga los objetos creados cuantos y la fecha del primer al ultimo objeto
--ej

--  OBJETOS     ABRIL-2019      MAYO-2019   JUNIO-2019      JULIO-2019      ...-2019        DICIEMBRE-2019
--  TABLA           12              12          12              12              11              111
--  VISTAS          11              15          11              0               0               0
--  PROCEDIMIENTOS  11              15          11              0               0               0
--  .               11              15          11              0               0               0
--  .               11              15          11              0               0               0
--  .               11              15          11              0               0               0

--RESPUESTA


begin
    declare @max date;
    set @max = (select
                top 1
                create_date
                from sys.objects
                order by 1 desc);

    declare @min date;

    set @min = (select
                top 1
                create_date
                from sys.objects
                order by 1);
    declare @fechas varchar(max);

    WITH Fechas AS
             (
                 SELECT
                 TOP (DATEDIFF(month, @min, @max) + 1)
                 n = ROW_NUMBER() OVER (ORDER BY [object_id])
                 FROM sys.all_objects
             )
    SELECT @fechas = string_agg(quotename(format(DATEADD(month, n - 1, @min), 'MMMM-yyyy')), ',')
    FROM Fechas F;

    exec ('WITH Fechas AS
             (
                 SELECT
                 TOP (DATEDIFF(month, '''+@min+''', '''+@max+''') + 1)
                 n = ROW_NUMBER() OVER (ORDER BY [object_id])
                 FROM sys.all_objects
             ),
         Objetos as (
             select type_desc, format(convert(date, create_date), ''MMMM-yyyy'') fecha
             from sys.objects
         )
    select *
    from (select type_desc otro, type_desc TIPO_OBJETO, fe FECHA
          from (SELECT format(DATEADD(month, n - 1, '''+@min+'''), ''MMMM-yyyy'') fe
                FROM Fechas F) FA1
                   left join Objetos O on FA1.fe = o.fecha
          ) P
             pivot (COUNT(TIPO_OBJETO) for FECHA in ('+@fechas+')) as PVT1;');

end;
