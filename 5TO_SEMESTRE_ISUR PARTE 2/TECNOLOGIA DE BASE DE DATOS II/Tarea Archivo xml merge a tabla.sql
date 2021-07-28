
-- Evento de curso
-- Nuestro proveedor nos envía los productos que vende en un archivo XML (inventa el contenido del archivo).
-- Dicho archivo nos sirve para actualizar nuestro catálogo de productos. El archivo XML tiene el código del
-- producto (es el código que el proveedor tiene internamente, no es el ProductID que tenemos en nuestra tabla),
-- tiene el nombre del producto (que servirá para hacer match con nuestra tabla) y el nuevo precio.
--
-- Se requiere un procedimiento almacenado que haga un Merge entre la tabla products y el archivo XML, igualando por el nombre.
--
-- * Si el producto está en el XML pero no en la tabla Products, entonces debe añadirse.
--
-- * Si el producto está en la tabla Products pero no en el XML, entonces deberá actualizarlo a Discontinued=1
--
-- * Si el producto está en el XML y también en la tabla, entonces se actualiza el precio.



-- OJO ESTOY UTILIZANDO UNA TABLA COPIA DE PRODUCTOS PARA NO ARRUINAR LA BASE ED DATOS DE NOTWIND

Create table ProductoTemp(
    ProductoID int primary key identity ,
    ProductoName varchar(150) not null ,
    UnitPrice money,
    Discontinued bit
)


insert into ProductoTemp
select p.ProductName, p.UnitPrice, p.Discontinued
from Products P

create or
alter procedure ConbinarXMLTabla
as
begin
    SELECT Archivo_XML.product.query('CodProducto').value('.', 'VARCHAR(20)') CodigoProducto,
           Archivo_XML.product.query('ProductName').value('.', 'VARCHAR(50)') NombreProducto,
           Archivo_XML.product.query('UnitPrice').value('.', 'money')         PrecioProducto
    FROM (SELECT CAST(Archivo_XML AS xml)
          FROM OPENROWSET(BULK 'C:\temporales\productos.xml', SINGLE_BLOB) AS T(Archivo_XML)) AS T(Archivo_XML)
             CROSS APPLY Archivo_XML.nodes('root/product') AS Archivo_XML (product);

    MERGE ProductoTemp as target
    USING (SELECT Archivo_XML.product.query('CodProducto').value('.', 'VARCHAR(20)') CodigoProducto,
                  Archivo_XML.product.query('ProductName').value('.', 'VARCHAR(50)') NombreProducto,
                  Archivo_XML.product.query('UnitPrice').value('.', 'money')         PrecioProducto
           FROM (SELECT CAST(Archivo_XML AS xml)
                 FROM OPENROWSET(BULK 'C:\temporales\productos.xml', SINGLE_BLOB) AS T(Archivo_XML)) AS T(Archivo_XML)
                    CROSS APPLY Archivo_XML.nodes('root/product') AS Archivo_XML (product)) as source
    ON (target.ProductoName = source.NombreProducto)
    WHEN MATCHED THEN
        update
        set target.UnitPrice=source.PrecioProducto
    WHEN NOT MATCHED BY TARGET THEN
        insert (ProductoName, UnitPrice, Discontinued)
        values (source.NombreProducto, source.PrecioProducto, 0)
    WHEN NOT MATCHED BY SOURCE THEN
        update set target.Discontinued = convert(bit,1) ;
end

select *
from ProductoTemp;
go

exec ConbinarXMLTabla;

select *
from ProductoTemp;
go