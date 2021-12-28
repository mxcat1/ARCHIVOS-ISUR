-- Haz un trigger que envíe un correo cada vez que se cree un cliente.
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
    @description = 'Perfil para mandar correos con correo del isur' ;
GO
EXECUTE msdb.dbo.sysmail_add_principalprofile_sp
    @profile_name = 'Notificaciones',
    @principal_name = 'public',
    @is_default = 1 ;
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
    @password = 'XX@mxcat159753@XX' ;
GO

EXECUTE msdb.dbo.sysmail_add_profileaccount_sp
    @profile_name = 'Notificaciones',
    @account_name = 'Isur Email',
    @sequence_number =1 ;
GO

-- PARA BORRAR ANTERIORES CONFIGURACIONES
-- EXECUTE msdb.dbo.sysmail_delete_profileaccount_sp @profile_name = 'Notificaciones'
-- EXECUTE msdb.dbo.sysmail_delete_principalprofile_sp @profile_name = 'Notificaciones'
-- EXECUTE msdb.dbo.sysmail_delete_account_sp @account_name = 'Isur Email'
-- EXECUTE msdb.dbo.sysmail_delete_profile_sp @profile_name = 'Notificaciones'

CREATE or alter TRIGGER Enviar_Email
    ON Customers
    for INSERT
    AS
BEGIN
    SET NOCOUNT ON;
    declare @body varchar(max);
    set @body = 'Se ha generado Registyrado un Nuevo Cliente: ' + (select ContactName from inserted for xml auto);
    EXEC msdb.dbo.sp_send_dbmail
         @profile_name = 'Notificaciones',
         @recipients = 'mxcat.xxtremxx@gmail.com',
         @subject = 'Nuevo Cliente Generado',
         @body = @body;
END
GO;
insert into Customers(CustomerID,CompanyName,ContactName) values ('ALFGJ','PeruanINC','Alfredo Guillen')

--     EXEC msdb.dbo.sp_send_dbmail
--          @profile_name = 'Notificaciones',
--          @recipients = 'c.vilca.apaza@isur.edu.pe',
--          @subject = 'Nuevo Cliente Generado',
--          @body = 'Se ha generado Registyrado un Nuevo Cliente: ';
--
-- sp_configure 'show advanced', 1;
-- GO
-- RECONFIGURE;
-- GO
-- sp_configure;
-- GO
-- SELECT * FROM msdb.dbo.sysmail_event_log;