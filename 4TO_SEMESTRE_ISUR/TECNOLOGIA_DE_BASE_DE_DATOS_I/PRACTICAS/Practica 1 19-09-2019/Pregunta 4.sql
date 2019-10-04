-- 4.	Haz un listado que muestre el nombre del
-- empleado que ha sido condecorado MÁS VECES como el mejor empleado del año.

--TOTAL POR ORDEN

select o.OrderID,
       e.EmployeeID,
       e.FirstName,
       o.Freight,
       od.Discount,
       (sum((od.Quantity*od.UnitPrice)*(1-od.Discount)))+o.Freight TOTAL_POR_ORDEN,
       O.OrderDate
from Employees e
join Orders O
    on e.EmployeeID = O.EmployeeID
join [Order Details] OD
    on O.OrderID = OD.OrderID
group by e.EmployeeID,e.FirstName,o.OrderID,o.Freight,od.Discount,O.OrderDate;

--total por empleado

select *
from Employees;

select ORDEN_TOTAL.EmployeeID,
       ORDEN_TOTAL.FirstName,
       year(ORDEN_TOTAL.OrderDate) YEAR,
       count(ORDEN_TOTAL.TOTAL_POR_ORDEN) CANTIDAD_ORDENES,
       sum(ORDEN_TOTAL.TOTAL_POR_ORDEN) TOTAL_YEAR
from (select o.OrderID,
             e.EmployeeID,
             e.FirstName,
             o.Freight,
             od.Discount,
             (sum((od.Quantity * od.UnitPrice) * (1 - od.Discount))) + o.Freight TOTAL_POR_ORDEN,
             O.OrderDate
      from Employees e
               join Orders O
                    on e.EmployeeID = O.EmployeeID
               join [Order Details] OD
                    on O.OrderID = OD.OrderID
      group by e.EmployeeID, e.FirstName, o.OrderID, o.Freight, od.Discount, O.OrderDate) ORDEN_TOTAL
group by ORDEN_TOTAL.EmployeeID,year(ORDEN_TOTAL.OrderDate),ORDEN_TOTAL.FirstName;

select POR_YEAR.YEAR,
       max(POR_YEAR.TOTAL_YEAR)
from (select ORDEN_TOTAL.EmployeeID,
             ORDEN_TOTAL.FirstName,
             year(ORDEN_TOTAL.OrderDate)        YEAR,
             count(ORDEN_TOTAL.TOTAL_POR_ORDEN) CANTIDAD_ORDENES,
             sum(ORDEN_TOTAL.TOTAL_POR_ORDEN)   TOTAL_YEAR
      from (select o.OrderID,
                   e.EmployeeID,
                   e.FirstName,
                   o.Freight,
                   od.Discount,
                   (sum((od.Quantity * od.UnitPrice) * (1 - od.Discount))) + o.Freight TOTAL_POR_ORDEN,
                   O.OrderDate
            from Employees e
                     join Orders O
                          on e.EmployeeID = O.EmployeeID
                     join [Order Details] OD
                          on O.OrderID = OD.OrderID
            group by e.EmployeeID, e.FirstName, o.OrderID, o.Freight, od.Discount, O.OrderDate) ORDEN_TOTAL
      group by ORDEN_TOTAL.EmployeeID, year(ORDEN_TOTAL.OrderDate), ORDEN_TOTAL.FirstName) POR_YEAR
group by POR_YEAR.YEAR;


select ORDEN_TOTAL.EmployeeID,
       ORDEN_TOTAL.FirstName,
       year(ORDEN_TOTAL.OrderDate) YEAR,
       count(ORDEN_TOTAL.TOTAL_POR_ORDEN) CANTIDAD_ORDENES,
       sum(ORDEN_TOTAL.TOTAL_POR_ORDEN) TOTAL_YEAR
from (select o.OrderID,
             e.EmployeeID,
             e.FirstName,
             o.Freight,
             od.Discount,
             (sum((od.Quantity * od.UnitPrice) * (1 - od.Discount))) + o.Freight TOTAL_POR_ORDEN,
             O.OrderDate
      from Employees e
               join Orders O
                    on e.EmployeeID = O.EmployeeID
               join [Order Details] OD
                    on O.OrderID = OD.OrderID
      group by e.EmployeeID, e.FirstName, o.OrderID, o.Freight, od.Discount, O.OrderDate) ORDEN_TOTAL,
     (select POR_YEAR.YEAR,
               max(POR_YEAR.TOTAL_YEAR) MAX_YEAR_TOTAL
        from (select ORDEN_TOTAL.EmployeeID,
                     ORDEN_TOTAL.FirstName,
                     year(ORDEN_TOTAL.OrderDate)        YEAR,
                     count(ORDEN_TOTAL.TOTAL_POR_ORDEN) CANTIDAD_ORDENES,
                     sum(ORDEN_TOTAL.TOTAL_POR_ORDEN)   TOTAL_YEAR
              from (select o.OrderID,
                           e.EmployeeID,
                           e.FirstName,
                           o.Freight,
                           od.Discount,
                           (sum((od.Quantity * od.UnitPrice) * (1 - od.Discount))) + o.Freight TOTAL_POR_ORDEN,
                           O.OrderDate
                    from Employees e
                             join Orders O
                                  on e.EmployeeID = O.EmployeeID
                             join [Order Details] OD
                                  on O.OrderID = OD.OrderID
                    group by e.EmployeeID, e.FirstName, o.OrderID, o.Freight, od.Discount, O.OrderDate) ORDEN_TOTAL
              group by ORDEN_TOTAL.EmployeeID, year(ORDEN_TOTAL.OrderDate), ORDEN_TOTAL.FirstName) POR_YEAR
        group by POR_YEAR.YEAR) MAX_POR_YEAR
group by ORDEN_TOTAL.EmployeeID,year(ORDEN_TOTAL.OrderDate),ORDEN_TOTAL.FirstName,MAX_POR_YEAR.YEAR,MAX_POR_YEAR.MAX_YEAR_TOTAL
having sum(ORDEN_TOTAL.TOTAL_POR_ORDEN)=MAX_POR_YEAR.MAX_YEAR_TOTAL AND year(ORDEN_TOTAL.OrderDate)=MAX_POR_YEAR.YEAR;


--OFICIAL

select LISTA_A.FirstName,
       count(LISTA_A.FirstName)
from (select ORDEN_TOTAL.EmployeeID,
             ORDEN_TOTAL.FirstName,
             year(ORDEN_TOTAL.OrderDate)        YEAR,
             count(ORDEN_TOTAL.TOTAL_POR_ORDEN) CANTIDAD_ORDENES,
             sum(ORDEN_TOTAL.TOTAL_POR_ORDEN)   TOTAL_YEAR
      from (select o.OrderID,
                   e.EmployeeID,
                   e.FirstName,
                   o.Freight,
                   od.Discount,
                   (sum((od.Quantity * od.UnitPrice) * (1 - od.Discount))) + o.Freight TOTAL_POR_ORDEN,
                   O.OrderDate
            from Employees e
                     join Orders O
                          on e.EmployeeID = O.EmployeeID
                     join [Order Details] OD
                          on O.OrderID = OD.OrderID
            group by e.EmployeeID, e.FirstName, o.OrderID, o.Freight, od.Discount, O.OrderDate) ORDEN_TOTAL,
           (select POR_YEAR.YEAR,
                   max(POR_YEAR.TOTAL_YEAR) MAX_YEAR_TOTAL
            from (select ORDEN_TOTAL.EmployeeID,
                         ORDEN_TOTAL.FirstName,
                         year(ORDEN_TOTAL.OrderDate)        YEAR,
                         count(ORDEN_TOTAL.TOTAL_POR_ORDEN) CANTIDAD_ORDENES,
                         sum(ORDEN_TOTAL.TOTAL_POR_ORDEN)   TOTAL_YEAR
                  from (select o.OrderID,
                               e.EmployeeID,
                               e.FirstName,
                               o.Freight,
                               od.Discount,
                               (sum((od.Quantity * od.UnitPrice) * (1 - od.Discount))) + o.Freight TOTAL_POR_ORDEN,
                               O.OrderDate
                        from Employees e
                                 join Orders O
                                      on e.EmployeeID = O.EmployeeID
                                 join [Order Details] OD
                                      on O.OrderID = OD.OrderID
                        group by e.EmployeeID, e.FirstName, o.OrderID, o.Freight, od.Discount, O.OrderDate) ORDEN_TOTAL
                  group by ORDEN_TOTAL.EmployeeID, year(ORDEN_TOTAL.OrderDate), ORDEN_TOTAL.FirstName) POR_YEAR
            group by POR_YEAR.YEAR) MAX_POR_YEAR
      group by ORDEN_TOTAL.EmployeeID, year(ORDEN_TOTAL.OrderDate), ORDEN_TOTAL.FirstName, MAX_POR_YEAR.YEAR,
               MAX_POR_YEAR.MAX_YEAR_TOTAL
      having sum(ORDEN_TOTAL.TOTAL_POR_ORDEN) = MAX_POR_YEAR.MAX_YEAR_TOTAL
         AND year(ORDEN_TOTAL.OrderDate) = MAX_POR_YEAR.YEAR) LISTA_A
group by LISTA_A.FirstName;


-- real oficial

select top 1
       LISTA_A.FirstName,
       count(LISTA_A.FirstName) CANTIDAD_DE_VECES_CONDECORADO
from (select ORDEN_TOTAL.EmployeeID,
             ORDEN_TOTAL.FirstName,
             year(ORDEN_TOTAL.OrderDate)        YEAR,
             count(ORDEN_TOTAL.TOTAL_POR_ORDEN) CANTIDAD_ORDENES,
             sum(ORDEN_TOTAL.TOTAL_POR_ORDEN)   TOTAL_YEAR
      from (select o.OrderID,
                   e.EmployeeID,
                   e.FirstName,
                   o.Freight,
                   od.Discount,
                   (sum((od.Quantity * od.UnitPrice) * (1 - od.Discount))) + o.Freight TOTAL_POR_ORDEN,
                   O.OrderDate
            from Employees e
                     join Orders O
                          on e.EmployeeID = O.EmployeeID
                     join [Order Details] OD
                          on O.OrderID = OD.OrderID
            group by e.EmployeeID, e.FirstName, o.OrderID, o.Freight, od.Discount, O.OrderDate) ORDEN_TOTAL,
           (select POR_YEAR.YEAR,
                   max(POR_YEAR.TOTAL_YEAR) MAX_YEAR_TOTAL
            from (select ORDEN_TOTAL.EmployeeID,
                         ORDEN_TOTAL.FirstName,
                         year(ORDEN_TOTAL.OrderDate)        YEAR,
                         count(ORDEN_TOTAL.TOTAL_POR_ORDEN) CANTIDAD_ORDENES,
                         sum(ORDEN_TOTAL.TOTAL_POR_ORDEN)   TOTAL_YEAR
                  from (select o.OrderID,
                               e.EmployeeID,
                               e.FirstName,
                               o.Freight,
                               od.Discount,
                               (sum((od.Quantity * od.UnitPrice) * (1 - od.Discount))) + o.Freight TOTAL_POR_ORDEN,
                               O.OrderDate
                        from Employees e
                                 join Orders O
                                      on e.EmployeeID = O.EmployeeID
                                 join [Order Details] OD
                                      on O.OrderID = OD.OrderID
                        group by e.EmployeeID, e.FirstName, o.OrderID, o.Freight, od.Discount, O.OrderDate) ORDEN_TOTAL
                  group by ORDEN_TOTAL.EmployeeID, year(ORDEN_TOTAL.OrderDate), ORDEN_TOTAL.FirstName) POR_YEAR
            group by POR_YEAR.YEAR) MAX_POR_YEAR
      group by ORDEN_TOTAL.EmployeeID, year(ORDEN_TOTAL.OrderDate), ORDEN_TOTAL.FirstName, MAX_POR_YEAR.YEAR,
               MAX_POR_YEAR.MAX_YEAR_TOTAL
      having sum(ORDEN_TOTAL.TOTAL_POR_ORDEN) = MAX_POR_YEAR.MAX_YEAR_TOTAL
         AND year(ORDEN_TOTAL.OrderDate) = MAX_POR_YEAR.YEAR) LISTA_A
group by LISTA_A.FirstName
order by 2 desc


--CORRECION DE LA PREGUNTA 4

--SUBTOTAL POR ORDEN DE LA TABLA ORDEN DETAIL

select sum(od.UnitPrice * od.Quantity * (1-od.Discount)) Subtotal
from [Order Details] OD;

    --SEGUNDA PARTE
    --SUBTOTAL POR CADA EMPLEADO AÑO Y SU SUBTOTAL
    select E.FirstName +' '+E.LastName Empleado,
           year(o.OrderDate) AÑO,
           ROUND((select sum(od.UnitPrice * od.Quantity * (1 - od.Discount)) Subtotal
            from [Order Details] OD
            where o.OrderID = OD.OrderID) + o.Freight,2) Monto
    from Orders O
    join Employees E
        on O.EmployeeID = E.EmployeeID;

    --- TERCERA PARTE

    --MONTO TOTAL POR AÑO Y POR EMPLEADO AGRUPADO POR EMPLEADO
    select Empleado,Año,sum(Monto) total
    from (select E.FirstName + ' ' + E.LastName Empleado,
                 year(o.OrderDate) AÑO,
                 ROUND((select sum(od.UnitPrice * od.Quantity * (1 - od.Discount)) Subtotal
                        from [Order Details] OD
                        where o.OrderID = OD.OrderID) + o.Freight, 2) Monto
          from Orders O
                   join Employees E
                        on O.EmployeeID = E.EmployeeID) TABLADERIVADA1
    group by Empleado, Año

        --CONTINUACION EN EL ARCHIVO EJERCICIO4
        --RESUELTO
        Select
        Top 1
        Empleado As [Empleado MÁS condecorado]
        From (
                 Select *
                 From (Select *,
                              (Select Max(Total)
                               From (
                                        Select Empleado, Año, Sum(Monto) As Total
                                        From (Select E.FirstName + ' ' + E.LastName                       As Empleado,
                                                     Year(O.OrderDate)                                    As Año,
                                                     Round((Select Sum(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) As Monto
                                                            From [Order Details] As OD
                                                            Where O.OrderID = OD.OrderID) + O.Freight, 2) As Monto
                                              From Orders As O
                                                       Join Employees As E
                                                            On E.EmployeeID = O.EmployeeID) As TD1
                                        Where TD1.Año = TD2.Año
                                        Group by Empleado, Año) As TD3) As MontoMayorAño
                       From (
                                Select Empleado, Año, Sum(Monto) As Total
                                From (Select E.FirstName + ' ' + E.LastName                       As Empleado,
                                             Year(O.OrderDate)                                    As Año,
                                             Round((Select Sum(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) As Monto
                                                    From [Order Details] As OD
                                                    Where O.OrderID = OD.OrderID) + O.Freight, 2) As Monto
                                      From Orders As O
                                               Join Employees As E
                                                    On E.EmployeeID = O.EmployeeID) As TD1
                                Group by Empleado, Año) As TD2) As TD4
                 Where Round(TD4.Total, 2) = Round(TD4.MontoMayorAño, 2)) As TD5
        Group by Empleado
        Order By Count(*) Desc



--SEGUNDA FORMA CORRECION DEL PA PREGUNTA 4

Select
Top 1
Empleado
From (
         Select E.FirstName + ' ' + E.LastName As Empleado,
                Datepart(Year, O.OrderDate)    As Año,
                Sum(O.Freight + OS.Subtotal)   As Total,
                Rank()
                        Over (Partition By Datepart(Year, O.OrderDate) Order By Sum(O.Freight + OS.Subtotal) Desc) As Puesto
         From Orders As O
                  Join [Order Subtotals] As OS
                       On O.OrderID = OS.OrderID
                  Join Employees As E
                       On E.EmployeeID = O.EmployeeID
         Group by E.FirstName + ' ' + E.LastName,
                  Datepart(Year, O.OrderDate)) As TD1
Where Puesto = 1
Group By Empleado
Order By Count(*) Desc