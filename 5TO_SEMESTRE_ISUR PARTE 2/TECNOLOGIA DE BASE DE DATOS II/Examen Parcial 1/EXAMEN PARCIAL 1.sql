create or
alter procedure Pregunta1 @NombreProducto varchar(max)
as
begin
    select distinct c.ContactName,
                    sum(od.Quantity)
                        over (partition by c.ContactName,p.ProductName order by c.ContactName) CantidadaComprado
    from Customers c
             inner join Orders O on c.CustomerID = O.CustomerID
             inner join [Order Details] OD on O.OrderID = OD.OrderID
             inner join Products P on P.ProductID = OD.ProductID
    where p.ProductName = @NombreProducto
end
go;

execute Pregunta1 'CAMEMBERT PIERROT';

create or
alter function Pregunta3(@NombreCategoria as varchar(max))
    returns TABLE
        as
        return
            (
                select p.ProductName, p.UnitPrice
                from Products P
                         inner join Categories C2 on C2.CategoryID = P.CategoryID
                where C2.CategoryName = @NombreCategoria
            )
go;

select *
from dbo.Pregunta3('Beverages');

sp_help Products

create or
alter procedure Pregunta6(@NombreProducto nvarchar(80), @Discontinuado bit, @Proveedor int=null, @Categoria int =null,
                          @CantidadPorUnidad nvarchar(40)=null, @precio money =null, @UnidadesEnStock smallint=null,
                          @UnidadesEnOrden smallint=null, @ReordenarNivel smallint=null)
as
begin
    insert into Products
    values (@NombreProducto, @Proveedor, @Categoria, @CantidadPorUnidad, @precio, @UnidadesEnStock, @UnidadesEnOrden,
            @ReordenarNivel, @Discontinuado)
end
go;
exec dbo.Pregunta6 'Papitas', false;

create or
alter function Pregunta4(@NombreCliente varchar(max))
    returns date
as
begin
    declare @FechaUltimo date;
    select @FechaUltimo = max(o.OrderDate)
    from Customers C
             inner join Orders O on C.CustomerID = O.CustomerID
    where c.ContactName = @NombreCliente
    group by c.ContactName;
    return @FechaUltimo;
end

select dbo.Pregunta4('Paul Henriot');


sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO

sp_configure 'Database Mail XPs', 1;
GO
RECONFIGURE
GO

EXECUTE msdb.dbo.sysmail_add_profile_sp
        @profile_name = 'Notificaciones',
        @description = 'Perfil para mandar correos con correo del isur';
GO
EXECUTE msdb.dbo.sysmail_add_principalprofile_sp
        @profile_name = 'Notificaciones',
        @principal_name = 'public',
        @is_default = 1;
GO

EXECUTE msdb.dbo.sysmail_add_account_sp
        @account_name = 'Isur Email',
        @description = 'Correo que se manda para hacer notificaciones',
        @email_address = 'c.vilca.apaza@isur.edu.pe',
        @display_name = 'Correo Automatico',
        @mailserver_name = 'smtp.office365.com',
        @port = 587,
        @enable_ssl = 1,
        @username = 'c.vilca.apaza@isur.edu.pe',
        @password = 'XX@mxcat@XX';
GO

EXECUTE msdb.dbo.sysmail_add_profileaccount_sp
        @profile_name = 'Notificaciones',
        @account_name = 'Isur Email',
        @sequence_number =1;
GO

-- PARA BORRAR ANTERIORES CONFIGURACIONES
-- EXECUTE msdb.dbo.sysmail_delete_profileaccount_sp @profile_name = 'Notificaciones'
-- EXECUTE msdb.dbo.sysmail_delete_principalprofile_sp @profile_name = 'Notificaciones'
-- EXECUTE msdb.dbo.sysmail_delete_account_sp @account_name = 'Isur Email'
-- EXECUTE msdb.dbo.sysmail_delete_profile_sp @profile_name = 'Notificaciones'

CREATE or alter TRIGGER Enviar_EmailPregunta2
    ON database for DDL_DATABASE_LEVEL_EVENTS
    AS
BEGIN
    SET NOCOUNT ON;
    declare @body varchar(max);
    set @body =
                'Se a modificado o Eliminado una Funcion,Procedimiento o tabla para mas Informacion lea el siguiente reporte: Se Efectuo un ' +
                (select EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]', 'nvarchar(max)')) + ' Efectuado por: ' +
                (select EVENTDATA().value('(/EVENT_INSTANCE/LoginName)[1]', 'nvarchar(max)')) +
                ' Se hizo en la fecha: ' +
                (select EVENTDATA().value('(/EVENT_INSTANCE/PostTime)[1]', 'nvarchar(max)'))
    EXEC msdb.dbo.sp_send_dbmail
         @profile_name = 'Notificaciones',
         @recipients = 'mxcatmax@gmail.com',
         @subject = 'Evento Ocacionado',
         @body = @body;
END
GO;


declare
    @fec_inicio DateTime,
    @fec_fin DateTime
--Supongamos que quiero la primera quincena de Febrero
select @fec_inicio = '20110201', @fec_fin = '20110215';
WITH FECHAS(fecha) AS (
    SELECT @fec_inicio fecha
    UNION ALL
    SELECT DATEADD(day, 1, fecha) fecha
    FROM FECHAS
    WHERE fecha < @fec_fin
)
select fecha, format(fecha, 'dddd', 'es-pe')
from FECHAS
where format(fecha, 'dddd', 'es-pe') = 'lunes'
   or format(fecha, 'dddd', 'es-pe') = 'martes'
   or format(fecha, 'dddd', 'es-pe') = 'miércoles'
   or format(fecha, 'dddd', 'es-pe') = 'jueves'
   or format(fecha, 'dddd', 'es-pe') = 'viernes'


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


create or alter trigger Pregunta7
    on [Order Details]
    for delete
    as
begin
    declare @itemsOrderDetails bigint,@orderdetailelimado int;
    select @itemsOrderDetails = count(*)
    from [Order Details],
         deleted
    where [Order Details].OrderID = deleted.OrderID
    select @orderdetailelimado=deleted.OrderID from deleted;
    if (@itemsOrderDetails = 0)
        begin
            delete from Orders where Orders.OrderID = @orderdetailelimado;
        end
    else
    begin
        print 'Se elimino la orden '+ convert(varchar(max),@orderdetailelimado) +'Todavia quedan '+ convert(varchar(max),@itemsOrderDetails) +' de ordenes';
    end
end;

delete from [Order Details] where [Order Details].OrderID=10248 and [Order Details].ProductID=72;