create or
alter procedure EnviarReporte @Anio int, @Mes int
as
begin
--     declare @Anio int=1997
--     declare @Mes int =5
    declare @texto varchar(max)=''
    declare @texto2 varchar(max)=''
    declare @Empleadoid int,@Mes_Nombre varchar(max),@Mes_Empleado int,@Anio_Empleado int,@Monto_Orden money,@Email_empleado varchar(max),@Empleado varchar(max),@EmailEnviar varchar(max),@EmpleadoEnviar varchar(max)
    declare @Empleados int,@contador int = 1
    select @Empleados = count(*) from Employees


    declare cursorMonto cursor for with cte1 as (select distinct E.EmployeeID,
                                                                 FirstName + ' ' + LastName                                                           Empleado,
                                                                 sum(o.Freight + os.Subtotal)
                                                                     over ( partition by FirstName + ' ' + LastName,year(OrderDate),month(OrderDate)) Monto,
                                                                 year(OrderDate)                                                                      Anio,
                                                                 month(OrderDate)                                                                     mes,
                                                                 Email,
                                                                 format(OrderDate, 'MMMM', 'es-ES')                                                   nombremes
                                                 from Orders O
                                                          inner join Employees E on E.EmployeeID = O.EmployeeID
                                                          inner join [Order Subtotals] OS on O.OrderID = OS.OrderID
                                                 union all
                                                 select distinct E.EmployeeID,
                                                                 FirstName + ' ' + LastName                                          Empleado,
                                                                 sum(o.Freight + os.Subtotal)
                                                                     over ( partition by FirstName + ' ' + LastName,year(OrderDate)) Monto,
                                                                 year(OrderDate)                                                     Anio,
                                                                 1,
                                                                 Email,
                                                                 '-'
                                                 from Orders O
                                                          inner join Employees E on E.EmployeeID = O.EmployeeID
                                                          inner join [Order Subtotals] OS on O.OrderID = OS.OrderID)
                                   select *
                                   from cte1
                                   order by 1, 4, 3 desc

    open cursorMonto


    while @contador <= @Empleados
        begin

            if @Anio_Empleado IS NOT NULL and @Anio_Empleado <= @Anio
                begin
                    if @Mes_Empleado <= @Mes or @Anio_Empleado < @Anio
                        begin
                            set @texto = @texto + @Empleado + ' - ' + @Mes_Nombre + ' - ' +
                                         convert(varchar(max), @Anio_Empleado) +
                                         ' - S/.' + convert(varchar(max), @Monto_Orden) + char(10)
                        end
                end

            fetch next from cursorMonto into @Empleadoid,@Empleado,@Monto_Orden,@Anio_Empleado,@Mes_Empleado,@Email_empleado,@Mes_Nombre
            set @EmailEnviar = @Email_empleado
            set @EmpleadoEnviar = @Empleado
            while @@FETCH_STATUS = 0 and @contador = @Empleadoid
                begin
                    if @Anio_Empleado <= @Anio
                        begin
                            if @Mes_Empleado <= @Mes or @Anio_Empleado < @Anio
                                begin
                                    set @texto = @texto + @Empleado + ' - ' + @Mes_Nombre + ' - ' +
                                                 convert(varchar(max), @Anio_Empleado) + ' - S/.' +
                                                 convert(varchar(max), @Monto_Orden) + char(10)
                                end
                        end

                    fetch next from cursorMonto into @Empleadoid,@Empleado,@Monto_Orden,@Anio_Empleado,@Mes_Empleado,@Email_empleado,@Mes_Nombre

                end

            set @texto2=''
            select @texto2 = @texto2 + Nombres + ' - ' + convert(varchar(max), Monto) + ' - ' + char(10)
            from (select top 5 e.FirstName + ' ' + e.LastName Nombres, sum(o.Freight + os.Subtotal) Monto, OrderDate
                  from Employees E
                           inner join Orders O on E.EmployeeID = O.EmployeeID
                           inner join [Order Subtotals] OS on O.OrderID = OS.OrderID
                  group by e.FirstName + ' ' + e.LastName, OrderDate
                  having year(OrderDate) = @Anio
                     and MONTH(OrderDate) = @Mes
                     and e.FirstName + ' ' + e.LastName = @EmpleadoEnviar order by 2 desc) tc1

            set @EmpleadoEnviar = concat('Reporte del Empleado - ', @EmpleadoEnviar)
            set @texto=@texto+char(10)+char(10)+@texto2
            EXEC msdb.dbo.sp_send_dbmail
                 @profile_name = 'Notificaciones',
                 @recipients = @EmailEnviar,
                 @subject = @EmpleadoEnviar,
                 @body = @texto

            set @texto = ''
            set @contador = @contador + 1
        end


    close cursorMonto
    deallocate cursorMonto


end

exec EnviarReporte 1996 , 12
