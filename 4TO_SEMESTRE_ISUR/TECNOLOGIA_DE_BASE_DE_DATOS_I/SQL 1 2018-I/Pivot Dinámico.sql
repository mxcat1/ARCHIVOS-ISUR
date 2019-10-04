--1 COALESCE
Declare	@Paises	Varchar(400)

Select Distinct ShipCountry
Into	#Paises
From Orders
Order By 1

Select	@Paises = Coalesce(@Paises + ',', '') + '[' + ShipCountry + ']'
From	#Paises

Drop Table #Paises

exec('Select	*
From	(Select	Year(O.OrderDate) As Año,
				Month(O.OrderDate) As Mes,
				Format(O.OrderDate, ''MMMM yyyy'', ''ES-pe'') As Periodo,
				ShipCountry As Pais,
				OrderID As ID
		From	Orders As O) As TSource
		Pivot(Count(ID) For Pais In ('+@Paises+')) As PT')

--2 XML
Declare	@Paises	Varchar(400)

Set @Paises = (
Select Replace(Replace(Replace(
(Select Distinct ShipCountry As Paises
From Orders
Order By 1
For XML Path('')), '<Paises>', '['),
'</Paises>', ']'), '][', '],['))


exec('Select	*
From	(Select	Year(O.OrderDate) As Año,
				Month(O.OrderDate) As Mes,
				Format(O.OrderDate, ''MMMM yyyy'', ''ES-pe'') As Periodo,
				ShipCountry As Pais,
				OrderID As ID
		From	Orders As O) As TSource
		Pivot(Count(ID) For Pais In ('+@Paises+')) As PT')