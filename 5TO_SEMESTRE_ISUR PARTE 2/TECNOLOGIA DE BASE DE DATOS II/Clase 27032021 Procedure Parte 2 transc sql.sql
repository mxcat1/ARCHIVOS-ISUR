-- Clase 2 del Curso Base de Datos 2

-- Procedimiento Almacenado Parte 2

-- Declarar Variables

declare @Precio as MONEY, @NomProducto as varchar(30)
-- Dar valor ala variable
set @Precio = 50
set @NomProducto = 'Impresora'
-- Otra forma de dar un valor alas variables
select @Precio = 50, @NomProducto = 'Impresora'
select @Precio, @NomProducto
go

-- Bucles while
declare @contador bigint = 0
while @contador <= 100
    begin
        print @contador
        set @contador = @contador + 1
    end
go

-- Condicionales IF, Iif, Case, Choice(Posible condicional)

-- IF

declare @Nota tinyint = 11

if @Nota >= 13
    Begin
        print 'Aprobado'
        print 'hola'
    end
else
    begin
        print 'Desaprovado'
        print 'Una Pena......'
    end
go

-- Iif
declare @Nota tinyint = 17
print IIF(@Nota >= 13, 'Aprobado' + CHAR(13) + 'Felicidades', 'Reprobado' + CHAR(13) + 'Que Pena')
go

-- CASE

select *,
       case CategoryID
           when 1 then 'Beveranges'
           when 2 then 'Condiments'
           when 3 then 'Confections'
           when 4 then 'Dairy Products'
           when 5 then 'Grains'
           when 6 then 'Meat'
           when 7 then 'Produce'
           when 8 then 'seafood'
           end
from Products;

go

-- CHOOSE
select *,
       CHOOSE(CategoryID, 'Beverages',
              'Condiments',
              'Confections',
              'Dairy Products',
              'Grains/Cereals',
              'Meat/Poultry',
              'Produce',
              'Seafood'
           )
from Products;
go
