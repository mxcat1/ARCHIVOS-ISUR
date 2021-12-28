-- 2.- Haz un procedimiento almacenado que reciba un argumento obligatorio.
-- El argumento es el nombre de una tabla y el procedimiento deberá hacer un "Select *" a la tabla pasada como argumento.
-- Si se pasa un nombre de tabla que no existe en la base de datos, entonces deberá mostrarse un mensaje que diga "La tabla no existe"

create or
alter procedure MostrarTabla @NombreTabla varchar(MAX)
as
begin
    begin try
        exec ('select * from ' + @NombreTabla)
    end try
    begin catch
        declare @severity int = ERROR_SEVERITY(), @estado smallint=ERROR_STATE()
        print 'Tabla no encontrada'
        raiserror ('Tabla no encontrada',@severity,@estado)
    end catch
end
go
exec MostrarTabla 'p';

-- declare @N varchar(max) = 'p'
-- select @N
--     exec ('select * from ' +@N)
--
-- begin try
--     declare @N varchar(max) = 'p'
--     exec ('select * from ' +@N)
-- end try
-- begin catch
--     print 'Tabla no encontrada'
-- end catch


