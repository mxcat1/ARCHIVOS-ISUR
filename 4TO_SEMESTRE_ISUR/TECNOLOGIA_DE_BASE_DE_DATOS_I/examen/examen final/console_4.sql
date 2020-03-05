-- 2.-

select format(o.OrderDate, 'MMMM-yyyy') fechafromato1, OrderDate, (os.Subtotal + o.Freight)
from Orders o
         join [Order Subtotals] OS on o.OrderID = os.OrderID
         right join (select format(fecha, 'MMMM-yyyy')                             fechanormal,
                            case when (os.Subtotal + o.Freight) IS NULL then 0 end montoa
                     from Orders o
                              right join (select dateadd(month, -12, o.OrderDate) fecha
                                          from Orders o) mesesantes on o.OrderDate = mesesantes.fecha
                              left join [Order Subtotals] os on o.OrderID = os.OrderID) tda1
                    on tda1.fechanormal = o.fechanormal;

select dateadd(month, -12, o.OrderDate) fecha
from Orders o;

select format(fecha, 'MMMM-yyyy') fechanormal, case when (os.Subtotal + o.Freight) IS NULL then 0 end
from Orders o
         right join (select dateadd(month, -12, o.OrderDate) fecha
                     from Orders o) mesesantes on o.OrderDate = mesesantes.fecha
         left join [Order Subtotals] os on o.OrderID = os.OrderID;


select case when (tda1.fechafromato1) is null then 'Sin Fecha' else (tda1.fechafromato1) end Fecha1,
       case when (tda1.monto) is null then 0 else (tda1.monto) end                           MontoFecha1,
       tda2.fechanormal                                                                      Fecha2,
       tda2.montoa                                                                           MontoFecha2,
       case when (tda1.monto) is null then 0 else (tda1.monto) end - tda2.montoa             Diferencia,
       sum(tda1.monto) over ( partition by year(tda1.OrderDate) order by year(tda1.OrderDate)) totalaño
from (select format(o.OrderDate, 'MMMM-yyyy') fechafromato1, OrderDate, (os.Subtotal + o.Freight) monto
      from Orders o
               join [Order Subtotals] OS on o.OrderID = os.OrderID) tda1
         left join
     (select format(fecha, 'MMMM-yyyy')                                                            fechanormal,
             fecha,
             o.OrderDate,
             case when (os.Subtotal + o.Freight) IS NULL then 0 else (os.Subtotal + o.Freight) end montoa
      from Orders o
               right join (select dateadd(month, -12, o.OrderDate) fecha,OrderDate
                           from Orders o) mesesantes on o.OrderDate = mesesantes.OrderDate
               left join [Order Subtotals] os on o.OrderID = os.OrderID) tda2 on tda1.OrderDate = tda2.OrderDate;