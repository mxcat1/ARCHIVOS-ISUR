--Ejercicio pivot unpivot clase

--CTS RECURSIVA CON PIVOT

--Para sacar la cantidad de ceros y de right



with CTE as (
    --Ancla

    select e.EmployeeID,
           1                                          Jerarquia,
           '0'+ convert(varchar(max),row_number() over (order by e.HireDate)) AS CodigoJerarquico,
           convert(varchar(max),coalesce(e.TitleOfCourtesy + ' ', '') + e.FirstName + ' ' + e.LastName +
           coalesce(' (' + e.Title + ')', ''))      as Empleado
    from Employees E
    where ReportsTo is null

          --Recursiva

    union ALL

    select e.EmployeeID,
           j.Jerarquia + 1,
           j.CodigoJerarquico +'.'+'0'+convert(varchar(max),row_number() over (order by e.HireDate)) AS CodigoJerarquico,
           replicate('  ',(j.Jerarquia +1)*2)+ convert(varchar(max),coalesce(e.TitleOfCourtesy + ' ', '') + e.FirstName + ' ' + e.LastName +
           coalesce(' (' + e.Title + ')', ''))      as Empleado
    from Employees E
             join CTE as J on E.ReportsTo = J.EmployeeID
)
select *
from CTE order by CodigoJerarquico;

