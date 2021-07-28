-- Funciones
-- Toda funcion te da un tipo de respuesta
-- tambien puede darte una tabla entera como respuesta(TVF)

-- por su origen
-- integradas built in
-- funciones definidas por el usuario


-- FUNCIONES DELE SISTEMA
select DATEPART(WEEK, '20210416')

-- Crear Funciones
--     CREATE FUNCTION
-- Actualizar Funciones
--     Alter FUNCTION
-- Eliminar Funciones
--     Drop FUNCTION


CREATE OR
ALTER FUNCTION Sumatoria(@A as int =1, @B as int=2, @C as int=3)
    returns int
as
begin
    return @A + @B + @C
end

select dbo.Sumatoria(4, default, default)
go

-- Ejemplo de Recuerdo

create or
alter function CalcularTotal(@preciouni as money, @cantidad as int, @desc as float)
    returns money
as
begin
    return @preciouni * @cantidad * (1 - @desc)
end

select OrderID, dbo.CalcularTotal(UnitPrice, Quantity, Discount)
from [Order Details]


-- select ContactName from Customers where ContactName COLLATE Latin1_General_CS_AS LIKE '[A-Z][ABCDEFGHIJKLMNOPQRSTUVWYZ]%'
-- select ContactName from Customers where ContactName collate Latin1_General_CS_AS LIKE '[MA][A-Z]%'
-- select ContactName from Customers where ContactName LIKE upper('[A-Z][A-Z]%')

---fibonacci

create or
alter function fibonacci(@num bigint)
    returns varchar(max)
begin
    declare @fibo varchar(max)=''
    if (@num = 1)
        begin
            set @fibo = convert(varchar(max), 1)

        end
    else
        begin
            if (@num = 0)
                begin
                    set @fibo = convert(varchar(max), 0)
                end
            else
                begin
                    set @fibo = @fibo + convert(varchar(max),
                            (convert(int, dbo.fibonacci(@num - 1)) + convert(int, dbo.fibonacci(@num - 2))))
                end
        end
    return @fibo
end

declare @fibo varchar(max)='',@conta bigint=0
while(@conta < 10)
    begin
        set @fibo = @fibo+',' + dbo.fibonacci(@conta)
        set @conta = @conta + 1
    end

print (@fibo)


-- Funciones Escalares

