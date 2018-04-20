--1.-En una consulta mostrar el nombre y apellidos de las 
--	personas nacidas en el mes de marzo

select pernombre,perapellido,convert(date,perfecnac,101) 
from Persona
 where month(perfecnac)=3

--2.-Mostrar el nombre y apellido de los clientes y 
--el numero de prestamo solo de aquellos prestamos 
--cuyo importe sea mayor a 4.5

select c.clinombre+' '+c.cliapellido 'NOMBRES Y APELLIDOS CLIENTE', 
PC.presnumero 'NUMERO DEL PRESTAMO'
from Cliente C 
	inner join Prestamo_Cabecera PC 
		on (PC.clicodigo=C.clicodigo) 
	inner join Prestamo_detalle PD 
		on (PD.presnumero=PC.presnumero)
where PD.presimporte>4.5

--3.-Mostrar el nombre y apellidos de los clientes 
--que no tienen telefono fijo

select * from Cliente where Cliente.clitelfijo is null

--4.-Mostrar en una consulta loa 
--cantidad de peliculas existentes.

select COUNT(*) from Pelicula

--5.-Mostrar en una consulta el numero de prestamo;
--la fecha, la cantidad de detalles y 
--el total de importe realizado.

select PC.presnumero,PC.presfecha
,COUNT(*) 'CANTIDAD DE DETALLES'
,SUM(PD.presimporte) 'SUMA DE IMPORTES' 
from Prestamo_Cabecera PC 
	inner join Prestamo_detalle PD 
	on (PD.presnumero=PC.presnumero)
	group by PC.presnumero,pc.presfecha
	order by (pc.presnumero) asc

--6.-En una consulta mostrar, el nombre de la pelicula y 
--la cantidad de ejemplares que tiene.

select P.pelnombre 'NOMBRE DE LA PELICULA'
,count(E.ejemnumero) 'CANTIDADA DE EJEMPLARES' 
from Pelicula P 
	inner join Ejemplar E 
	on (E.pelcodigo=P.pelcodigo)
	group by P.pelnombre
	order by P.pelnombre asc

--7.-Mostrar el nombre del genero y la cantidad 
--de peliculas, asociadas a cada genero.

select G.gennombre 'NOMBRE DEL GENERO'
,count(P.pelgenero) 'CANTIDAD DE PELICULAS'
from Pelicula P 
	inner join Genero G 
	on P.pelgenero=G.gencodigo
	group by (G.gennombre)
	order by g.gennombre asc


