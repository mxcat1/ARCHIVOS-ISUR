-- 3.- Haz una función RECURSIVA que pida un número y devuelva la sumatoria de todos los números desde el 1 hasta el ingresado como parámetro de la función.
-- la función devolverá un número (la suma)

create or
alter function sumatorias(@numero bigint)
    returns bigint
begin
    declare @suma bigint = 0
    if (@numero = 1)
        begin
            set @suma = 1
        end
    else
        begin
            set @suma = @numero + dbo.sumatorias(@numero - 1)
        end
    return @suma
end

print (dbo.sumatorias(4))