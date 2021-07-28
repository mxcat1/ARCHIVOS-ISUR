
--Haz un trigger que envíe un correo al administrador del sistema cada 
--vez que se modifiquen o eliminen funciones, procedimientos o tablas. 
--El correo debe contener información de qué se hizo, quién lo hizo y cuándo.

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


