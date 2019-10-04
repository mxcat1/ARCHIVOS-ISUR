--Resoluci�n del Ejercicio 4 de la pr�ctica.
--Har� varias consultas "secuenciales" para que sean ejecutadas 1x1 e irnos acercando a la respuesta
--en cada uno de los pasos.
--En cada paso reutilizaremos la consulta usada en el paso anterior.
--Pondr� explicaciones para un mejor entendimiento.

--ENUNCIADO
-----------
--4. Usando IN: Considerando la cantidad de �rdenes realizadas por a�o y pa�s,
--haz un listado de los clientes que viven en aquellos pa�ses en los cuales se han realizado
--menos de 7 �rdenes en dos o m�s a�os.
--En el cuadro de ejemplo, solo deber�an salir los clientes de los pa�ses que tienen un �cono verde.
--OJO: Deben salir los clientes argentinos.

--Cantidad de �rdenes por a�o y pa�s.
Select ShipCountry As Pais, Year(OrderDate) As A�o, Count(*) As Cantidad
From	Orders
Group By ShipCountry, Year(OrderDate)
Order By 1,2

--Cantidad de �rdenes por a�o y pa�s donde hubo menos de 7 �rdenes por a�o.
Select ShipCountry As Pais, Year(OrderDate) As A�o, Count(*) As Cantidad
From	Orders
Group By ShipCountry, Year(OrderDate)
Having	Count(*) < 7
Order By 1,2

--Cantidad de a�os en donde cada pa�s tuvo menos de 7 �rdenes por a�o.
Select	Pais, Count(*) As Cantidad
From
		(Select ShipCountry As Pais, Year(OrderDate) As A�o, Count(*) As Cantidad
		From	Orders
		Group By ShipCountry, Year(OrderDate)
		Having	Count(*) < 7) As TD1
Group By Pais

--Vemos que Argentina dice 1 pero ese dato es un ERROR!!!
--Est� contando solo las 6 �rdenes del a�o 1997 pero no est� contando el a�o 1996
--La raz�n es que NO hay registros para Argentina 1996 as� que el count simplemente
--ignorar�a esa combinaci�n, por lo tanto... la consulta anterior no me ayudar�,
--tengo que replantearla completamente!!!.
--NECESITO "obligar" a SQL para que haya una fila que diga: Argentina - 1996 - 0
--NECESITO que haya un registro as�.
--En la base de datos Northwind NO hay otra combinaci�n Pa�s-A�o faltante
--pero si la hubiese... necesitar�a que esa combinaci�n tambi�n aparezca en mis resultados.
--�C�mo se logra?
--Quiero que salga una fila con la combinaci�n de TODOS los pa�ses con TODOS los a�os para poder contarla.
--�Recuerdas c�mo? �Todos contra todos? �Te suena un... CROSS JOIN?
Select	*
From	(Select Distinct ShipCountry From Orders) As PAISES --Todos los pa�ses pero sin repetir
	CROSS JOIN (Select Distinct Year(OrderDate) As A�o From Orders) As A�os --Todos los a�os donde hubo �rdenes (sin repet

--Ya tengo un listado de todos los pa�ses con todos los a�os
--�Y si ahora cuento cu�ntas �rdenes hubo en cada pa�s en cada a�o?
Select	*,
		(Select Count(*) From Orders As O
		Where Year(O.OrderDate)= A�os.A�o --Solo cuento las �rdenes de ese a�o
		And O.ShipCountry=Paises.ShipCountry --Y solo las de ese a�o
		) As Cantidad --Subconsulta
From	(Select Distinct ShipCountry From Orders) As PAISES --Todos los pa�ses pero sin repetir
	CROSS JOIN (Select Distinct Year(OrderDate) As A�o From Orders) As A�os --Todos los a�os donde hubo �rdenes (sin repet
	--Tablas derivadas
Order By 1,2

--Ahora s� s� cu�ntas �rdenes hubo en TODOS los pa�ses y en TODOS los a�os.
--Ahora cuento en cu�ntos de ellos hubo menos de 7 �rdenes.
--La consulta anterior la uso como TABLA DERIVADA de �sta otra.
Select	ShipCountry, Count(*) As A�os
From	(
		Select	*,
				(Select Count(*) From Orders As O
				Where Year(O.OrderDate)= A�os.A�o --Solo cuento las �rdenes de ese a�o
				And O.ShipCountry=Paises.ShipCountry --Y solo las de ese a�o
				) As Cantidad --Subconsulta
		From	(Select Distinct ShipCountry From Orders) As PAISES --Todos los pa�ses pero sin repetir
			CROSS JOIN (Select Distinct Year(OrderDate) As A�o From Orders) As A�os --Todos los a�os donde hubo �rdenes (sin repet
			--Tablas derivadas
		) As TablaDerivada
Where	Cantidad < 7
Group By ShipCountry

--Solo me interesan los que tienen menos de 7 a�os, uso la consulta anterior
Select	ShipCountry, Count(*) As A�os
From	(
		Select	*,
				(Select Count(*) From Orders As O
				Where Year(O.OrderDate)= A�os.A�o --Solo cuento las �rdenes de ese a�o
				And O.ShipCountry=Paises.ShipCountry --Y solo las de ese a�o
				) As Cantidad --Subconsulta
		From	(Select Distinct ShipCountry From Orders) As PAISES --Todos los pa�ses pero sin repetir
			CROSS JOIN (Select Distinct Year(OrderDate) As A�o From Orders) As A�os --Todos los a�os donde hubo �rdenes (sin repet
			--Tablas derivadas
		) As TablaDerivada
Where	Cantidad < 7
Group By ShipCountry
Having	Count(*) >=2

--Finalmente... listo usando IN los clientes que viven en esos 8 pa�ses.
Select	*
From	Customers
Where	Country In (
			Select	ShipCountry
			From	(
					Select	*,
							(Select Count(*) From Orders As O
							Where Year(O.OrderDate)= A�os.A�o --Solo cuento las �rdenes de ese a�o
							And O.ShipCountry=Paises.ShipCountry --Y solo las de ese a�o
							) As Cantidad --Subconsulta
					From	(Select Distinct ShipCountry From Orders) As PAISES --Todos los pa�ses pero sin repetir
						CROSS JOIN (Select Distinct Year(OrderDate) As A�o From Orders) As A�os --Todos los a�os donde hubo �rdenes (sin repet
						--Tablas derivadas
					) As TablaDerivada
			Where	Cantidad < 7
			Group By ShipCountry
			Having	Count(*) >=2)
Order By Country