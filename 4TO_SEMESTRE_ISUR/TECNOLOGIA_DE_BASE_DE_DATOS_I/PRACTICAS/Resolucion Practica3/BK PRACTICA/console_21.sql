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

select
top 1
create_date
from sys.objects
order by 1 asc;

select
top 1
create_date
from sys.objects
order by 1 desc;

select format(create_date, 'MMMM-yyyy'), count(type_desc)
from sys.objects
group by create_date;
select format(create_date, 'MMMM-yyyy'), count(type_desc)
from sys.objects
group by format(create_date, 'MMMM-yyyy');

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
            order by 1 asc);

declare @fechas varchar(max);

WITH Fechas AS
         (
             SELECT
             TOP (DATEDIFF(month, @min, @max) + 1)
             n = ROW_NUMBER() OVER (ORDER BY [object_id])
             FROM sys.all_objects
         )
SELECT @fechas = string_agg(quotename(format(DATEADD(month, n - 1, @min), 'MMMM-yyyy')), ',')
FROM Fechas F
select @fechas;

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
                order by 1 asc);

    WITH Fechas AS
             (
                 SELECT
                 TOP (DATEDIFF(month, @min, @max) + 1)
                 n = ROW_NUMBER() OVER (ORDER BY [object_id])
                 FROM sys.all_objects
             ),
         Objetos as (
             select type_desc, format(convert(date, create_date), 'MMMM-yyyy') fecha
             from sys.objects
         )
    select fe FECHA, COUNT(type_desc) TIPO_OBJETO, type_desc
    from (SELECT format(DATEADD(month, n - 1, @min), 'MMMM-yyyy') fe
          FROM Fechas F) FA1
             left join Objetos O on FA1.fe = o.fecha
    group by fe, type_desc;
end;

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
    WITH Fechas AS
             (
                 SELECT
                 TOP (DATEDIFF(month, @min, @max) + 1)
                 n = ROW_NUMBER() OVER (ORDER BY [object_id])
                 FROM sys.all_objects
             ),
         Objetos as (
             select type_desc, format(convert(date, create_date), 'MMMM-yyyy') fecha
             from sys.objects
         )
    select *
    from (select type_desc otro,type_desc TIPO_OBJETO, fe FECHA
           from (SELECT format(DATEADD(month, n - 1, @min), 'MMMM-yyyy') fe
                 FROM Fechas F) FA1
                    left join Objetos O on FA1.fe = o.fecha
           ) P
              pivot (COUNT(TIPO_OBJETO) for FECHA in ([abril-2003],[mayo-2003],[junio-2003],[julio-2003],[agosto-2003],[septiembre-2003],[octubre-2003],[noviembre-2003],[diciembre-2003],[enero-2004],[febrero-2004],[marzo-2004],[abril-2004],[mayo-2004],[junio-2004],[julio-2004],[agosto-2004],[septiembre-2004],[octubre-2004],[noviembre-2004],[diciembre-2004],[enero-2005],[febrero-2005],[marzo-2005],[abril-2005],[mayo-2005],[junio-2005],[julio-2005],[agosto-2005],[septiembre-2005],[octubre-2005],[noviembre-2005],[diciembre-2005],[enero-2006],[febrero-2006],[marzo-2006],[abril-2006],[mayo-2006],[junio-2006],[julio-2006],[agosto-2006],[septiembre-2006],[octubre-2006],[noviembre-2006],[diciembre-2006],[enero-2007],[febrero-2007],[marzo-2007],[abril-2007],[mayo-2007],[junio-2007],[julio-2007],[agosto-2007],[septiembre-2007],[octubre-2007],[noviembre-2007],[diciembre-2007],[enero-2008],[febrero-2008],[marzo-2008],[abril-2008],[mayo-2008],[junio-2008],[julio-2008],[agosto-2008],[septiembre-2008],[octubre-2008],[noviembre-2008],[diciembre-2008],[enero-2009],[febrero-2009],[marzo-2009],[abril-2009],[mayo-2009],[junio-2009],[julio-2009],[agosto-2009],[septiembre-2009],[octubre-2009],[noviembre-2009],[diciembre-2009],[enero-2010],[febrero-2010],[marzo-2010],[abril-2010],[mayo-2010],[junio-2010],[julio-2010],[agosto-2010],[septiembre-2010],[octubre-2010],[noviembre-2010],[diciembre-2010],[enero-2011],[febrero-2011],[marzo-2011],[abril-2011],[mayo-2011],[junio-2011],[julio-2011],[agosto-2011],[septiembre-2011],[octubre-2011],[noviembre-2011],[diciembre-2011],[enero-2012],[febrero-2012],[marzo-2012],[abril-2012],[mayo-2012],[junio-2012],[julio-2012],[agosto-2012],[septiembre-2012],[octubre-2012],[noviembre-2012],[diciembre-2012],[enero-2013],[febrero-2013],[marzo-2013],[abril-2013],[mayo-2013],[junio-2013],[julio-2013],[agosto-2013],[septiembre-2013],[octubre-2013],[noviembre-2013],[diciembre-2013],[enero-2014],[febrero-2014],[marzo-2014],[abril-2014],[mayo-2014],[junio-2014],[julio-2014],[agosto-2014],[septiembre-2014],[octubre-2014],[noviembre-2014],[diciembre-2014],[enero-2015],[febrero-2015],[marzo-2015],[abril-2015],[mayo-2015],[junio-2015],[julio-2015],[agosto-2015],[septiembre-2015],[octubre-2015],[noviembre-2015],[diciembre-2015],[enero-2016],[febrero-2016],[marzo-2016],[abril-2016],[mayo-2016],[junio-2016],[julio-2016],[agosto-2016],[septiembre-2016],[octubre-2016],[noviembre-2016],[diciembre-2016],[enero-2017],[febrero-2017],[marzo-2017],[abril-2017],[mayo-2017],[junio-2017],[julio-2017],[agosto-2017],[septiembre-2017],[octubre-2017],[noviembre-2017],[diciembre-2017],[enero-2018],[febrero-2018],[marzo-2018],[abril-2018],[mayo-2018],[junio-2018],[julio-2018],[agosto-2018],[septiembre-2018],[octubre-2018],[noviembre-2018],[diciembre-2018],[enero-2019],[febrero-2019],[marzo-2019],[abril-2019],[mayo-2019],[junio-2019],[julio-2019],[agosto-2019],[septiembre-2019])) as
          PVT1;
end;

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
