-- 2.- Haz una función que reciba un argumento de texto y devuelva si la palabra o frase es palíndroma. La respuesta debe ser booleana.


create or
alter function EsPolidroma(@se varchar(max))
    returns bit
begin
    declare @conta int =len(@se)
    declare @se2 varchar(max)=''

    while (@conta >= 1)
        begin
            set @se2 = @se2 + (substring(@se, @conta, 1))
            set @conta = @conta - 1
        end
    if @se=@se2
    begin
        return 1
    end
    return 0
end

print(dbo.EsPolidroma ('hyola'))