--Operadores
--IN
--EXISTS
--BETWEEN
--LIKE

--Ejercicios con IN
-- 1:LISTAR LOS PRODUCTOS QUE SEAN CEREALES O CONDIMENTOS

select P.ProductName,p.CategoryID,c.CategoryName
from Products P
JOIN Categories C
    on P.CategoryID = C.CategoryID
where c.CategoryName IN ('Condiments','Grains/Cereals');

    --Segunda forma
    select P.ProductName,p.CategoryID
    from Products P
    where P.CategoryID IN (select CategoryID from Categories as C
                            where c.CategoryName in('Condiments','Grains/Cereals'));
    --EJERCICIO CON EXISTS

    select P.ProductID,P.ProductName
    from Products p
    WHERE EXISTS(SELECT 1
                    FROM Categories C
                    where C.CategoryID=P.CategoryID
                            and (c.CategoryName='Condiments'
                            or c.CategoryName='Grains/Cereals'));

-- Operador BETWEEN

--MUESTRAME LOS PRODUCTOS Q CUESTEN ENTRE 10 Y 20 DOLARES

select *
from Products P
where P.UnitPrice between 10.00 and 20.00;

--Muestrame las ordenes q fueron realizadas entre una fecha y tal fecha

select *
from Orders
where OrderDate between '19961101' and '19961110';

--Muestrame los nombre de los productos que esten entre la c y la e
select *
from Products P
where p.ProductName between 'C' and 'E';
-- busca alfabeticamente
select *
from Products P
where p.ProductName between 'C' and 'Ez';

--OPERADOR LIKE significa como
-- devuelve los registros que se parescan a "algo"
-- COMODINES % ==> VARIOS CARACTERES
-- COMODINES _ ==> UN SOLO CARACTER
-- COMODINES ['CARACTERES' o 'CARACTER-CARACTER' o '^CARACTER'] ==> RANGO DE CARACTERES ESPECIFICOS
                    --      Caracteres hasta ==>-   Excepto==>^

    select * from Products P
    where p.ProductName like '%cho_o%'
    order by p.ProductName;

                --AGREGANDO UNA ALTERACION A LA TABLA PRODUCTS
                    insert into Products(ProductName)
                    values ('OZONO');

    select * from Products P
    where p.ProductName like '%o[CK]o%'
    order by p.ProductName;

                --AGREGANDO UNA ALTERACION A LA TABLA PRODUCTS
                    insert into Products(ProductName)
                    values ('CHOQOLATTE');

    select * from Products P
    where p.ProductName like '%o[C-Q]o%'
    order by p.ProductName;

    select * from Products P
    where p.ProductName like '%o[^C]o%'
    order by p.ProductName;

    --COLLATION CONJUNTO DE CARACTERES Q SE APLIC ALA BASE DE DATOS
    -- C=>Case
    -- A=>Accent
    -- S=>Sensitive
    -- I=>Insensitive
    -- C->S || I
    -- A->S !! I
    --EJEMPLO => CI ==>insensitivo a las mayusculas
    --EJEMPLO => AI ==>insensitivo a los acentos
    --EJEMPLO => AS ==>sensitivo a los acentos
-- CONSULTA SOLO SI LA BASE DE DATOS NO ESTA EN USO
    --alter database Northwind collate Modern_Spanish_CS_AS;
-- consulta para q sirva con cualquier collation
-- agregar collate Modern_Spanish_CI_AI