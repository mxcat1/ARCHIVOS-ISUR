--EJE1
--listado de empleados

--  Empleados
--  ID
--  NOMBRE
--  APELLIDO

--  EMPLEADO        MIN META        MAX META        %CUMPLIDO
--  nomEMPLEADO     20000           250000          25
--  nomEMPLEADO     20000           250000          25
--  nomEMPLEADO     10000           100000          25
--  nomEMPLEADO     15000           150000          25
--  nomEMPLEADO     total           total           %100

select e.EmployeeID,
       e.FirstName + ' ' + e.LastName                                                                   NOMEMPLEADO,
       M.Periodo,
       M.Meta,
       sum(os.Subtotal + o.Freight) over ( partition by o.EmployeeID,o.OrderDate order by o.EmployeeID) MaxMeta
from Metas M
         join Employees E on M.Empleado = E.EmployeeID
         join Orders O on O.EmployeeID = E.EmployeeID
         join [Order Subtotals] OS on O.OrderID = OS.OrderID;

select o.EmployeeID,
       format(o.OrderDate, 'MMMM-yyyy') Periodo,
       sum(os.Subtotal + o.Freight)
from Orders O
         join [Order Subtotals] OS on O.OrderID = OS.OrderID
group by o.EmployeeID, format(o.OrderDate, 'MMMM-yyyy');


select m.Empleado                     CodigoEmpleado,
       e.FirstName + ' ' + e.LastName NomEmpleado,
       TotalesEmpleados.Periodo       PeriodoMeta,
       M.Meta                         MinMeta,
       TotalesEmpleados.Total         MaxMeta,
       (TotalesEmpleados.Total * 100) / sum(M.Meta) over ( partition by m.Empleado order by m.Empleado)
from (select o.EmployeeID,
             format(o.OrderDate, 'MMMM-yyyy') Periodo,
             sum(os.Subtotal + o.Freight)     Total
      from Orders O
               join [Order Subtotals] OS on O.OrderID = OS.OrderID
      group by o.EmployeeID, format(o.OrderDate, 'MMMM-yyyy')) TotalesEmpleados,
     Metas M
         join Employees E on M.Empleado = e.EmployeeID
where format(M.Periodo, 'MMMM-yyyy') = TotalesEmpleados.Periodo
  and TotalesEmpleados.EmployeeID = M.Empleado;

select m.Empleado                     CodigoEmpleado,
       e.FirstName + ' ' + e.LastName NomEmpleado,
       TotalesEmpleados.Periodo       PeriodoMeta,
       M.Meta                         MinMeta,
       TotalesEmpleados.Total         MaxMeta,
       case
           when TotalesEmpleados.Total > m.Meta then (TotalesEmpleados.Total * 100) /
                                                     sum(M.Meta) over ( partition by m.Empleado order by m.Empleado)
            else 0
        end

from (select o.EmployeeID,
             format(o.OrderDate, 'MMMM-yyyy') Periodo,
             sum(os.Subtotal + o.Freight)     Total
      from Orders O
               join [Order Subtotals] OS on O.OrderID = OS.OrderID
      group by o.EmployeeID, format(o.OrderDate, 'MMMM-yyyy')) TotalesEmpleados,
     Metas M
         join Employees E on M.Empleado = e.EmployeeID
where TotalesEmpleados.Periodo=format(M.Periodo, 'MMMM-yyyy')
  and TotalesEmpleados.EmployeeID = M.Empleado;
