-- CURSORES

-- 1.- Declarar el cursor
-- 2.- Abrir el cursor
-- 3.- Usar el cursor ==> fila por fila
-- 4.- Cerrar el Cursor
-- 5.- Borrar el cursor de memoria


-- TIpos de cursores
-- Microsoft SQL Server admite los siguientes 4 tipos de cursores.
-- STATIC
-- Un cursor estático llena el conjunto de resultados durante
-- la creación del cursor y el resultado de la consulta se almacena en
-- caché durante la vida útil del cursor. Un cursor estático puede moverse hacia adelante y hacia atrás.
-- FAST_FORWARD
-- Este es el tipo de cursor predeterminado. Es idéntico al
-- estático, excepto que solo puede desplazarse hacia adelante.
-- DINAMIC
-- En un cursor dinámico, las adiciones y eliminaciones son
-- visibles para otros en la fuente de datos mientras el cursor está abierto.
-- KEYSET
-- Esto es similar a un cursor dinámico, excepto que no
-- podemos ver registros que otros agreguen. Si otro usuario elimina un
-- registro, es inaccesible desde nuestro conjunto de registros.


-- Ejemplo de cursor


-- Declarar cursor
-- Si se declara de forward only o cualquier otro tipò
declare
    CUR_Productos cursor scroll for
select ProductID, ProductName, UnitPrice
from Products
-- Abrir Cursor
open CUR_Productos

-- Usar variables para mejorar el uso de cursores
declare @ID int, @Nombre varchar(40), @Precio money;

-- Recorrer Cursor variables
fetch next from CUR_Productos into @ID,@Nombre,@Precio;

print @ID;print @Nombre;

-- Recorrer Cursor
fetch next from CUR_Productos
-- Recorrer de forma prior
fetch prior from CUR_Productos

-- Recorrer un cursor con un bulce
fetch next from CUR_Productos
while @@fetch_status = 0
begin
    fetch next from CUR_Productos
end

-- cerrar cursor
close CUR_Productos

-- Borrar cursor
deallocate CUR_Productos



