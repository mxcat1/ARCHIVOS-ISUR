-- 2.	Mostrar el nombre y el ID de los proveedores que nos
-- proveen menos productos. Si hubiera empates, deberán mostrarse todos los proveedores empatados.


select *
from Suppliers S;

select *
from Products;


select s.SupplierID,
       s.CompanyName,
       count(p.ProductName) [Cantidad PRODUCTO],
       p.ProductID
from Products P
join Suppliers S
    on P.SupplierID = S.SupplierID
group by s.SupplierID, s.CompanyName, p.ProductID;

select s.SupplierID,
       s.CompanyName,
       sum(CANTIDADPRODUCTO.[Cantidad PRODUCTO]) Cantidad
FROM Suppliers S,
     (select s.SupplierID,
               s.CompanyName,
               count(p.ProductName) [Cantidad PRODUCTO],
               p.ProductID
        from Products P
        join Suppliers S
            on P.SupplierID = S.SupplierID
        group by s.SupplierID, s.CompanyName, p.ProductID) CANTIDADPRODUCTO
where s.SupplierID=CANTIDADPRODUCTO.SupplierID
group by s.SupplierID, s.CompanyName;

select min(Cantidad.Cantidad)
from (select s.SupplierID,
             s.CompanyName,
             sum(CANTIDADPRODUCTO.[Cantidad PRODUCTO]) Cantidad
      FROM Suppliers S,
           (select s.SupplierID,
                   s.CompanyName,
                   count(p.ProductName) [Cantidad PRODUCTO],
                   p.ProductID
            from Products P
                     join Suppliers S
                          on P.SupplierID = S.SupplierID
            group by s.SupplierID, s.CompanyName, p.ProductID) CANTIDADPRODUCTO
      where s.SupplierID = CANTIDADPRODUCTO.SupplierID
      group by s.SupplierID, s.CompanyName) Cantidad;


--REAL Oficial

select s.SupplierID,
       s.CompanyName,
       sum(CANTIDADPRODUCTO.[Cantidad PRODUCTO]) Cantidad
FROM Suppliers S,
     (select s.SupplierID,
               s.CompanyName,
               count(p.ProductName) [Cantidad PRODUCTO],
               p.ProductID
        from Products P
        join Suppliers S
            on P.SupplierID = S.SupplierID
        group by s.SupplierID, s.CompanyName, p.ProductID) CANTIDADPRODUCTO
where s.SupplierID=CANTIDADPRODUCTO.SupplierID
group by s.SupplierID, s.CompanyName
having sum(CANTIDADPRODUCTO.[Cantidad PRODUCTO])=(select min(Cantidad.Cantidad)
                                                    from (select s.SupplierID,
                                                                 s.CompanyName,
                                                                 sum(CANTIDADPRODUCTO.[Cantidad PRODUCTO]) Cantidad
                                                          FROM Suppliers S,
                                                               (select s.SupplierID,
                                                                       s.CompanyName,
                                                                       count(p.ProductName) [Cantidad PRODUCTO]--,
--                                                                        p.ProductID
                                                                from Products P
                                                                         left join Suppliers S
                                                                              on P.SupplierID = S.SupplierID
                                                                group by s.SupplierID, s.CompanyName, p.ProductID) CANTIDADPRODUCTO
                                                          where s.SupplierID = CANTIDADPRODUCTO.SupplierID
                                                          group by s.SupplierID, s.CompanyName) Cantidad);

--FORMA DEL PROFESOR 1

select top 1 with ties s.SupplierID,
       s.CompanyName
from Suppliers S
left join Products P
    on S.SupplierID = P.SupplierID
group by s.SupplierID, s.CompanyName
order by count(p.ProductID);