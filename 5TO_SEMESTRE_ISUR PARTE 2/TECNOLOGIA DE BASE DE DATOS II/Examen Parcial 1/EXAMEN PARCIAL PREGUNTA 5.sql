--Haz una TVF que reciba dos fechas y 
--devuelva un listado de todos los días laborables (de lunes a viernes) 
--que hay entre las dos fechas. Haz una consulta donde uses la función.



create or
alter function Pregunta5(@fecha_inicio DateTime,
                         @fecha_fin DateTime)
    returns table
        return
            (
                WITH FECHAS(fecha) AS (
                    SELECT @fecha_inicio fecha
                    UNION ALL
                    SELECT DATEADD(day, 1, fecha) fecha
                    FROM FECHAS
                    WHERE fecha < @fecha_fin
                )
                select fecha, format(fecha, 'dddd', 'es-pe') Dia
                from FECHAS
                where format(fecha, 'dddd', 'es-pe') = 'lunes'
                   or format(fecha, 'dddd', 'es-pe') = 'martes'
                   or format(fecha, 'dddd', 'es-pe') = 'miércoles'
                   or format(fecha, 'dddd', 'es-pe') = 'jueves'
                   or format(fecha, 'dddd', 'es-pe') = 'viernes'
            );
go
select *
from dbo.Pregunta5('20210509', '20210515')

