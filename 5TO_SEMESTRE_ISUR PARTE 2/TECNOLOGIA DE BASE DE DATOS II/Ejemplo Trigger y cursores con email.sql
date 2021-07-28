-- Hacer que cada vez q se cree un cliente se envie un correo

create or alter trigger Alta_Clientes
    on Customers
    for insert
    as
begin
    declare @Asuto varchar(100)
    declare @ContactName varchar(100), @email varchar(30)
    declare CLINU cursor for select ContactName, Email from inserted
    open CLINU
    fetch next from CLINU into @ContactName,@email
    while @@FETCH_STATUS = 0
        begin
            set @Asuto = 'Bienvenido, ' + @ContactName

--             exec msdb.dbo.sp_send_dbmail @Subject=@Asuto, @Body='Saludos cordiales', @Recipients='c.vilca.apaza@isur.edu.pe'
            exec msdb.dbo.sp_send_dbmail @Subject=@Asuto, @Body='Saludos cordiales', @Recipients=@email
            fetch next from CLINU into @ContactName,@email
        end
    close CLINU
    deallocate CLINU
end