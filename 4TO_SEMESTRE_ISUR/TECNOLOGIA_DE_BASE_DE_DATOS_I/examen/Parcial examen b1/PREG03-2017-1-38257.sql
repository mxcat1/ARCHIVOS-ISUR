-- 3.-HAZ UN LISTADO QUE MUESTRE EL EL ID Y EL NOMBRE DEL CLIENTE, EL PAIS DE LA VENTA Y EL MONTO TOTAL VENDIDO(CON FLETES Y DESCUENTO)
--, DEBE APARECER TAMBIEN EL TOTAL POR CADA PAIS Y EL TOTAL POR CADA CLEINTE

--paso 1
select O.OrderID,
       C.CustomerID,
       C.CompanyName,
       O.ShipCountry,
       sum((OD.UnitPrice*OD.Quantity)*(1-od.Discount)) + o.Freight Total
from Orders O
    join [Order Details] OD
        on O.OrderID = OD.OrderID
    join Customers C
        on O.CustomerID = C.CustomerID
group by o.OrderID,C.CustomerID, C.CompanyName, O.ShipCountry,o.Freight;