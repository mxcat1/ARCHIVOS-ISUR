-- CONSULTAS POR MEDIO DE SELECT
-- utiliza expresiones y campos
-- el from contiene tablas

select
       ProductID,
       UPPER(ProductName) as "Producto Mayus",
       SupplierID,
       CategoryID,
       QuantityPerUnit,
       UnitPrice,
       UnitsInStock,
       UnitPrice*UnitsInStock as "Suma de unitp y units",
       UnitsOnOrder,
       ReorderLevel,
       Discontinued
from Products;

--mostrar el nombre de la categoria con los productos
--standar anciend sqlserver 89
select
       P.ProductID,
       P.ProductName,
       P.SupplierID,
       P.CategoryID,
       "Nombre de Categoria"=C.CategoryName,
       [Cantidad por Unidad]=P.QuantityPerUnit,
       P.UnitPrice,
       P.UnitsInStock,
       P.UnitsOnOrder,
       P.ReorderLevel,
       P.Discontinued
from Products   as P,
     Categories as C
where P.CategoryID=C.CategoryID;

-- order by

select
       P.ProductID,
       P.ProductName,
       P.SupplierID,
       P.CategoryID,
       "Nombre de Categoria"=C.CategoryName,
       P.QuantityPerUnit,
       P.UnitPrice,
       P.UnitsInStock,
       P.UnitsOnOrder,
       P.ReorderLevel,
       P.Discontinued
from Products   as P,
     Categories as C
where P.CategoryID=c.CategoryID
ORDER BY P.UnitPrice DESC;
-- clausula top sirve para devolver una cantidad especifica de registros
-- percent por porcentaje y with ties con repetidos
-- depende tambien del order by
select
       top 11 with ties
       P.ProductID,
       P.ProductName,
       P.SupplierID,
       P.CategoryID,
       "Nombre de Categoria"=C.CategoryName,
       P.QuantityPerUnit,
       P.UnitPrice,
       P.UnitsInStock,
       P.UnitsOnOrder,
       P.ReorderLevel,
       P.Discontinued
from Products   as P,
     Categories as C
where P.CategoryID=c.CategoryID
order by UnitPrice desc;


