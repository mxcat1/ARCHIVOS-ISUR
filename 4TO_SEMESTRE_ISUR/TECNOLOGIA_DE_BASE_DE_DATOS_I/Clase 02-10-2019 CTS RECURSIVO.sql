--CTS PARA RECURSIVIDAD

-- EMPLEADOS CON RECURSIVIDAD A ELLOS MISMO YA Q  UN EMPLEADO PUEDE SER JEFE DE OTROS
select EmployeeID,FirstName Nombre, ReportsTo
from Employees;

--PRIMER CTS CON RECURSIVIDAD

with Jerarquia
as
(
    --SELECT ANCLA
    select EmployeeID CodigoEmpleado,
           FirstName +' '+LastName Nombre,
           1 as Nivel,
           convert(varchar(max),row_number() over (order by LastName)) Numero_De_Orden
    from Employees
    where ReportsTo is null
    --FIN SELECT ANCLA
    UNION ALL
    --SELECT RECURSIVO
    select E.EmployeeID CodigoEmpleado,
           E.FirstName + ' ' + E.LastName Nombre,
           J.Nivel+1 Nivel,
           convert(varchar(max),J.Numero_De_Orden + '.' + convert(varchar(max),row_number() over (order by LastName)))
    from Employees E
    join Jerarquia J
        on J.CodigoEmpleado=E.ReportsTo
    --FIN SELECT RECURSIVO
)select replicate(' ',(Nivel-1)*5)+Numero_De_Orden + ' - ' + Nombre JerarquiaEmpleado
-- (' ',(Nivel-1)*5)+convert(varchar(2),Numero_De_Orden) + ' - ' + Nombre JerarquiaEmpleado
        --cast(CodigoEmpleado as varchar(2)) + Nombre
from Jerarquia
order by Numero_De_Orden;
--NOTA
--EN ESTE CASO LA CTS NECESITA UN UNION ALL POR REGLA
--NOTA2
-- EN UN CTS RECURSIVO PRIMERO SE EJECUTA EL ANCLA


--REPLICATE
select replicate('ISUR ',5)
--FIN REPLICATE


--INTRODUCCION TEMA DESPUES DE PARCIALES FUNCION DE VENTANAS
select row_number() over (order by  BirthDate),*
from Employees;