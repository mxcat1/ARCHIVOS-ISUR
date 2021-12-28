-- Haz una consulta que muestre el total vendido por cada año y cada mes. Los meses deben salir en filas (uno debajo de otro)
-- y los años deben salir en las columnas. En la parte media debe salir el monto (con fletes y descuentos) vendido en cada mes/año.
-- Los años deben colocarse dinámicamente, es decir, si agregamos un nuevo año en orders, automáticamente deberá salir una nueva columna.
-- Los meses que no hayan ventas deben salir con cero en lugar de NULL.


declare
    @anionull varchar(max),@anio varchar(max);

select @anionull = string_agg(MA, ',')
from (select 'isnull('+quotename(Año)+',0) as '+quotename(Año) MA
      FROM (select distinct year(OrderDate) Año
            from Orders) TD1) TDA1A;
select @anio = string_agg(MA, ',')
from (select quotename(Año) MA
      FROM (select distinct year(OrderDate) Año
            from Orders) TD1) TDA1A;
select @anionull,@anio;

exec ('select Mes,'+@anionull+'
from (select distinct datename(yyyy, o.OrderDate)                                                            Anio,
                      datename(mm, o.OrderDate)                                                              Mes,
                      sum(((od.Quantity * od.UnitPrice) * (1 - od.Discount)) + o.Freight)
                          over ( partition by datename(mm, o.OrderDate) + ''-'' + datename(yyyy, o.OrderDate)) Total_MesAño
      from Orders O
               inner join [Order Details] OD on O.OrderID = OD.OrderID) TVA1 pivot ( sum(Total_MesAño) for Anio in ('+@anio+')) PVA1')

select Mes,isnull([1996],0) as [1996],isnull([1997],0) as [1997],isnull([1998],0) as [1998]
from (select distinct datename(yyyy, o.OrderDate)                                                            Anio,
                      datename(mm, o.OrderDate)                                                              Mes,
                      sum(((od.Quantity * od.UnitPrice) * (1 - od.Discount)) + o.Freight)
                          over ( partition by datename(mm, o.OrderDate) + '-' + datename(yyyy, o.OrderDate)) Total_MesAño
      from Orders O
               inner join [Order Details] OD on O.OrderID = OD.OrderID) TVA1 pivot ( sum(Total_MesAño) for Anio in ([1996],[1997],[1998])) PVA1
