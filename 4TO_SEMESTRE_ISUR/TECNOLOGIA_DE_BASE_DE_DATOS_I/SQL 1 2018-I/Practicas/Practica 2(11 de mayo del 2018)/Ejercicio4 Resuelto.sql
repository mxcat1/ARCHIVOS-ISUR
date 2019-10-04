--Resolución del Ejercicio 4 de la práctica.
--Haré varias consultas "secuenciales" para que sean ejecutadas 1x1 e irnos acercando a la respuesta
--en cada uno de los pasos.
--En cada paso reutilizaremos la consulta usada en el paso anterior.
--Pondré explicaciones para un mejor entendimiento.

--ENUNCIADO
-----------
--4. Usando IN: Considerando la cantidad de órdenes realizadas por año y país,
--haz un listado de los clientes que viven en aquellos países en los cuales se han realizado
--menos de 7 órdenes en dos o más años.
--En el cuadro de ejemplo, solo deberían salir los clientes de los países que tienen un ícono verde.
--OJO: Deben salir los clientes argentinos.

--Cantidad de órdenes por año y país.
Select ShipCountry As Pais, Year(OrderDate) As Año, Count(*) As Cantidad
From	Orders
Group By ShipCountry, Year(OrderDate)
Order By 1,2

--Cantidad de órdenes por año y país donde hubo menos de 7 órdenes por año.
Select ShipCountry As Pais, Year(OrderDate) As Año, Count(*) As Cantidad
From	Orders
Group By ShipCountry, Year(OrderDate)
Having	Count(*) < 7
Order By 1,2

--Cantidad de años en donde cada país tuvo menos de 7 órdenes por año.
Select	Pais, Count(*) As Cantidad
From
		(Select ShipCountry As Pais, Year(OrderDate) As Año, Count(*) As Cantidad
		From	Orders
		Group By ShipCountry, Year(OrderDate)
		Having	Count(*) < 7) As TD1
Group By Pais

--Vemos que Argentina dice 1 pero ese dato es un ERROR!!!
--Está contando solo las 6 órdenes del año 1997 pero no está contando el año 1996
--La razón es que NO hay registros para Argentina 1996 así que el count simplemente
--ignoraría esa combinación, por lo tanto... la consulta anterior no me ayudará,
--tengo que replantearla completamente!!!.
--NECESITO "obligar" a SQL para que haya una fila que diga: Argentina - 1996 - 0
--NECESITO que haya un registro así.
--En la base de datos Northwind NO hay otra combinación País-Año faltante
--pero si la hubiese... necesitaría que esa combinación también aparezca en mis resultados.
--¿Cómo se logra?
--Quiero que salga una fila con la combinación de TODOS los países con TODOS los años para poder contarla.
--¿Recuerdas cómo? ¿Todos contra todos? ¿Te suena un... CROSS JOIN?
Select	*
From	(Select Distinct ShipCountry From Orders) As PAISES --Todos los países pero sin repetir
	CROSS JOIN (Select Distinct Year(OrderDate) As Año From Orders) As Años --Todos los años donde hubo órdenes (sin repet

--Ya tengo un listado de todos los países con todos los años
--¿Y si ahora cuento cuántas órdenes hubo en cada país en cada año?
Select	*,
		(Select Count(*) From Orders As O
		Where Year(O.OrderDate)= Años.Año --Solo cuento las órdenes de ese año
		And O.ShipCountry=Paises.ShipCountry --Y solo las de ese año
		) As Cantidad --Subconsulta
From	(Select Distinct ShipCountry From Orders) As PAISES --Todos los países pero sin repetir
	CROSS JOIN (Select Distinct Year(OrderDate) As Año From Orders) As Años --Todos los años donde hubo órdenes (sin repet
	--Tablas derivadas
Order By 1,2

--Ahora sí sé cuántas órdenes hubo en TODOS los países y en TODOS los años.
--Ahora cuento en cuántos de ellos hubo menos de 7 órdenes.
--La consulta anterior la uso como TABLA DERIVADA de ésta otra.
Select	ShipCountry, Count(*) As Años
From	(
		Select	*,
				(Select Count(*) From Orders As O
				Where Year(O.OrderDate)= Años.Año --Solo cuento las órdenes de ese año
				And O.ShipCountry=Paises.ShipCountry --Y solo las de ese año
				) As Cantidad --Subconsulta
		From	(Select Distinct ShipCountry From Orders) As PAISES --Todos los países pero sin repetir
			CROSS JOIN (Select Distinct Year(OrderDate) As Año From Orders) As Años --Todos los años donde hubo órdenes (sin repet
			--Tablas derivadas
		) As TablaDerivada
Where	Cantidad < 7
Group By ShipCountry

--Solo me interesan los que tienen menos de 7 años, uso la consulta anterior
Select	ShipCountry, Count(*) As Años
From	(
		Select	*,
				(Select Count(*) From Orders As O
				Where Year(O.OrderDate)= Años.Año --Solo cuento las órdenes de ese año
				And O.ShipCountry=Paises.ShipCountry --Y solo las de ese año
				) As Cantidad --Subconsulta
		From	(Select Distinct ShipCountry From Orders) As PAISES --Todos los países pero sin repetir
			CROSS JOIN (Select Distinct Year(OrderDate) As Año From Orders) As Años --Todos los años donde hubo órdenes (sin repet
			--Tablas derivadas
		) As TablaDerivada
Where	Cantidad < 7
Group By ShipCountry
Having	Count(*) >=2

--Finalmente... listo usando IN los clientes que viven en esos 8 países.
Select	*
From	Customers
Where	Country In (
			Select	ShipCountry
			From	(
					Select	*,
							(Select Count(*) From Orders As O
							Where Year(O.OrderDate)= Años.Año --Solo cuento las órdenes de ese año
							And O.ShipCountry=Paises.ShipCountry --Y solo las de ese año
							) As Cantidad --Subconsulta
					From	(Select Distinct ShipCountry From Orders) As PAISES --Todos los países pero sin repetir
						CROSS JOIN (Select Distinct Year(OrderDate) As Año From Orders) As Años --Todos los años donde hubo órdenes (sin repet
						--Tablas derivadas
					) As TablaDerivada
			Where	Cantidad < 7
			Group By ShipCountry
			Having	Count(*) >=2)
Order By Country