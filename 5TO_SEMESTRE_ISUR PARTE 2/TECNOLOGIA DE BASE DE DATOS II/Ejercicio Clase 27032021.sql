-- Ejercicio en Clase 1
/*
Mostrar un listado de los productos y cuando fueron vendidos ejemplo y mostrarlo con un print
Usando variables, condicionales y bucles

1 Chai
    12/04/1997 ALFKI 4
    19/04/1997 BONAP 8
2 Vodka
    1/2/1998 VINET 9
    *
    *
    *
*/

declare @NombreProducto as varchar(100), @FechaCompradorCantidad varchar(150),@Contador as tinyint = 1,@cantidadordenes as int,@contador2 as tinyint

declare @CantidadProductosTabla as tinyint = (select COUNT(ProductID) from Products)

while @Contador <= @CantidadProductosTabla
    begin
        set @NombreProducto = (select ProductName from Products where ProductID = @Contador)
        print convert(varchar,@Contador) + '- ' + @NombreProducto + char(13)
        set @contador2 = 1
        set @cantidadordenes = (select count(ProductName)
                                from (select row_number() over (order by ProductName) as                       IDData,
                                             o.OrderDate,
                                             CustomerID,
                                             ProductName,
                                             sum(Quantity)
                                                 over ( partition by OrderDate,ProductName order by OrderDate) Cantidad
                                      from Orders O
                                               inner join [Order Details] OD on O.OrderID = OD.OrderID
                                               inner join Products P on P.ProductID = OD.ProductID
                                      where ProductName = @NombreProducto) as tabla1)

        if @cantidadordenes > 0
            begin
                while @contador2 <= @cantidadordenes
                    begin
                        set @FechaCompradorCantidad =
                                (select convert(varchar, IDData) + '-. ' + convert(varchar, convert(date, Fecha)) +
                                        '   ' + Cliente + '   ' + convert(varchar, Cantidad)
                                 from (select row_number() over (order by ProductName) as                       IDData,
                                              o.OrderDate                                                       Fecha,
                                              CustomerID                                                        Cliente,
                                              ProductName,
                                              sum(Quantity)
                                                  over ( partition by OrderDate,ProductName order by OrderDate) Cantidad
                                       from Orders O
                                                inner join [Order Details] OD on O.OrderID = OD.OrderID
                                                inner join Products P on P.ProductID = OD.ProductID
                                       where ProductName = @NombreProducto) TablaMatriz1
                                 where IDData = @Contador2)
                        print convert(varchar,@Contador)+'.'+@FechaCompradorCantidad
                        set @contador2=@contador2+1
                    end

            end
        else
            begin
                print 'Sin Ordenes'
            end

        set @Contador = @Contador + 1
    end
go

select o.OrderDate, CustomerID, ProductName, sum(Quantity) over ( partition by OrderDate,ProductName order by OrderDate)
from Orders O
         inner join [Order Details] OD on O.OrderID = OD.OrderID
         inner join Products P on P.ProductID = OD.ProductID
where ProductName = 'Mozzarella di Giovanni'
  and CustomerID = 'LILAS'

select row_number() over (order by ProductName) as                                 IDData,
       o.OrderDate,
       CustomerID,
       ProductName,
       sum(Quantity) over ( partition by OrderDate,ProductName order by OrderDate) Cantidad
from Orders O
         inner join [Order Details] OD on O.OrderID = OD.OrderID
         inner join Products P on P.ProductID = OD.ProductID
where ProductName = 'Mozzarella di Giovanni'

select convert(varchar, IDData) + '-. ' + convert(varchar, convert(date, Fecha)) + '   ' + Cliente + '   ' +
       convert(varchar, Cantidad)
from (select row_number() over (order by ProductName) as                                 IDData,
             o.OrderDate                                                                 Fecha,
             CustomerID                                                                  Cliente,
             ProductName,
             sum(Quantity) over ( partition by OrderDate,ProductName order by OrderDate) Cantidad
      from Orders O
               inner join [Order Details] OD on O.OrderID = OD.OrderID
               inner join Products P on P.ProductID = OD.ProductID
      where ProductName = @NombreProducto) TablaMatriz1
where IDData = @Contador2

