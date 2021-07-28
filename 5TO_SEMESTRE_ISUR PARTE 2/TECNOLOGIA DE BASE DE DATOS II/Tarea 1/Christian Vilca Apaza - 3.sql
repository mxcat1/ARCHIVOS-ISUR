-- 3.- Haz un procedimiento almacenado que reciba un número y devuelva el factorial de dicho número.

create or
alter procedure Factorial @Num bigint, @resultado bigint output
as
begin
    if @Num = 1
        begin
            set @resultado = 1
            print @resultado
        end
    else
        begin
            set @Num = @Num - 1
            exec Factorial @Num, @resultado output
            set @resultado = (@Num+1) * @resultado
            print @resultado
        end
end
go

declare @res bigint
exec Factorial 10, @res output
select @res

