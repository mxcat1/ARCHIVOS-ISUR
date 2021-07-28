-- TVF MultiStatement

create or
alter function Fibo1(@NroElementos as int)
    returns @Elementos table
                       (
                           Nro   int,
                           Valor int
                       )
as
begin
    declare @Contador int,@valor int
    set @Contador = 1
    while @Contador <= @NroElementos
        begin
            if @Contador = 1
                set @valor = 0
            else
                if @Contador = 2
                    set @valor = 1
                else
                    set @valor = (select sum(Valor) from @Elementos where Nro >= @Contador - 2)
            insert into @Elementos values (@Contador, @valor)
            set @Contador = @Contador + 1
        end
    return
end;

select *
from dbo.Fibo1(15)


--------------------------------
--sumatoria lunes martes y miercoles


create or
alter function FechasOrdenes()
    returns @TablaDias table
                       (
                           Fecha date,
                           Dia   varchar(max)
                       )
as
begin
    insert into @TablaDias
    select distinct convert(date, O.OrderDate)                                  as fecha1,
                    convert(varchar(max), format(o.OrderDate, 'dddd', 'es-pe')) as dia1
    from Orders O
             inner join [Order Details] OD on O.OrderID = OD.OrderID
    where format(o.OrderDate, 'dddd', 'es-pe') in ('lunes', 'martes', 'miércoles')
    return
end;
go

select year(TablaDia.Fecha) Año, format(TablaMonto.fecha, 'MMMM', 'es-pe'), TablaMonto.monto
from (select * from dbo.FechasOrdenes()) as TablaDia
         inner join (select distinct convert(date, O.OrderDate) as   fecha,
                                     sum(((OD.UnitPrice * OD.Quantity) * (1 - OD.Discount)) + o.Freight)
                                         over (order by o.OrderDate) monto
                     from Orders O
                              inner join [Order Details] OD on O.OrderID = OD.OrderID) TablaMonto
                    on TablaDia.Fecha = TablaMonto.fecha

select *
from (select year(TablaDia.Fecha) Año, format(TablaMonto.fecha, 'MMMM', 'es-pe') Mes, TablaMonto.monto
      from (select * from dbo.FechasOrdenes()) as TablaDia
               inner join (select distinct convert(date, O.OrderDate) as   fecha,
                                           sum(((OD.UnitPrice * OD.Quantity) * (1 - OD.Discount)) + o.Freight)
                                               over (order by o.OrderDate) monto
                           from Orders O
                                    inner join [Order Details] OD on O.OrderID = OD.OrderID) TablaMonto
                          on TablaDia.Fecha = TablaMonto.fecha) as TablaTVC1 pivot ( sum(TablaTVC1.monto) for Mes IN ([Enero], [Febrero], [Marzo], [Abril], [Mayo], [Junio], [Julio], [Agosto], [Setiembre], [Octubre], [Noviembre], [Diciembre])) as pvt

create or
alter function TablaFuncionAñoMes()
    returns table
        return
            (
                select *
                from (select year(TablaDia.Fecha) Año, format(TablaMonto.fecha, 'MMMM', 'es-pe') Mes, TablaMonto.monto
                      from (select * from dbo.FechasOrdenes()) as TablaDia
                               inner join (select distinct convert(date, O.OrderDate) as       fecha,
                                                           sum(
                                                                   ((OD.UnitPrice * OD.Quantity) * (1 - OD.Discount)) + o.Freight)
                                                                   over (order by o.OrderDate) monto
                                           from Orders O
                                                    inner join [Order Details] OD on O.OrderID = OD.OrderID) TablaMonto
                                          on TablaDia.Fecha = TablaMonto.fecha) as TablaTVC1 pivot ( sum(TablaTVC1.monto) for Mes IN ([Enero], [Febrero], [Marzo], [Abril], [Mayo], [Junio], [Julio], [Agosto], [Setiembre], [Octubre], [Noviembre], [Diciembre])) as pvt
            )
go

select * from dbo.TablaFuncionAñoMes()