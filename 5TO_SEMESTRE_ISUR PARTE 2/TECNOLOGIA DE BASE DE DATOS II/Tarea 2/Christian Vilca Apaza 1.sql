-- 1.- Haz una función que reciba como argumento 3 números y los muestre ordenados de mayor a menor y separados por comas.
-- declare @se varchar(max)=''
-- -- set @se =(select top 3 CustomerID from Customers for json auto)
-- select top 3 @se=@se+','+CustomerID from Customers
-- print(len(@se))
-- print(substring(@se,2,len(@se)))
--
-- declare @tabla1 table (numero int)
-- insert into @tabla1 (numero) values(1),(2),(3)
-- select * from @tabla1 order by numero desc


create or alter function Ordenamiento(@n1 int,@n2 int,@n3 int)
returns varchar(max)
as begin
    declare @tabla1 table (numero int)
    declare @se varchar(max)=''
    insert into @tabla1 (numero) values(@n1),(@n2),(@n3)
    select @se=@se+','+convert(varchar(max),numero) from @tabla1 order by numero desc
    return substring(@se,2,len(@se))
end

print(dbo.Ordenamiento (5,8,10))