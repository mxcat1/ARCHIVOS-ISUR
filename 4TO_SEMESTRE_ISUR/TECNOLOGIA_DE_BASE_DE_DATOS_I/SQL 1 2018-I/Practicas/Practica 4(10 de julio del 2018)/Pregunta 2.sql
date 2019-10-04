Declare @Paises varchar(8000)

Set @Paises = (Select Distinct C.Country
               from Customers C
			   Order by 1
			   For XML Path(''))


set @Paises = REPLACE(@Paises, '</Country><Country>',',')
set @Paises = REPLACE(@Paises, '<Country>','')
set @Paises = REPLACE(@Paises, '</Country>','')

print @Paises 

exec('
select [Etiquetas de fila],
       OrderDate,
	   Paises,
	   Cantidad
from(select *
     from Hoja1) as H 
Unpivot(Cantidad for Paises in
(' + @Paises + ')) as UPVT')

--Modifique el nombre de la tabla Hoja1$ a Hoja1

