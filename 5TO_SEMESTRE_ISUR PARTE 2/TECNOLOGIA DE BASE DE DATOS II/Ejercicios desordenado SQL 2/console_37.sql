-- 1.- Crea un tipo de dato que sirva para almacenar un número de celular. Usa el tipo de dato en la creación de una tabla.


create type NroCelular from varchar(12) not null;

create table Persona
(
    IdPersona      int identity primary key,
    CelularPersona NroCelular DEFAULT '+00000000000'
)

-- 2.- Construye el índice ideal para mostrar el ID, nombre del producto y precio unitario
-- de todos los productos discontinuados y que se muestren ordenados por precio ascendentemente.

create table ProductosSinIndice
(
    ProductID    int         not null,
    ProductName  varchar(40) not null,
    UnitPrice    money,
    Discontinued bit
)

insert into ProductosSinIndice
select ProductID, ProductName, UnitPrice, Discontinued
from Products

-- Eliminar cache
dbcc FREEPROCCACHE WITH NO_INFOMSGS
-- Vaciar cache
dbcc dropcleanbuffers with no_infomsgs

-- Indice clustereado

create clustered index ProductosDiscontinuados on ProductosSinIndice (ProductName, Discontinued)

drop index ProductosDiscontinuados on ProductosSinIndice

-- Indice noclustereado

create nonclustered index ProductosDiscontinuados on ProductosSinIndice (ProductName, UnitPrice asc, Discontinued)

drop index ProductosDiscontinuados on ProductosSinIndice


select *
from ProductosSinIndice
where Discontinued = 1
order by UnitPrice

