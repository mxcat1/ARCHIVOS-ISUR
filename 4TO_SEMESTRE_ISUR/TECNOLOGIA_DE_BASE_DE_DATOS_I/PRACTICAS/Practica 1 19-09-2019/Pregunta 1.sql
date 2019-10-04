
-- 1.	Mostrar los territorios que NO son atendidos por ningún empleado.

select * from Territories;

select * from Employees;

select *
from EmployeeTerritories
order by 1;
--REAL
select distinct t.TerritoryDescription
from Territories T
left outer join EmployeeTerritories ET
    on T.TerritoryID = ET.TerritoryID
where et.TerritoryID is null;
--FORMA CON COUNT Y LEFT OUTER JOIN
select distinct t.TerritoryDescription--,
--                 COUNT(ET.TerritoryID)
from Territories T
left outer join EmployeeTerritories ET
    on T.TerritoryID = ET.TerritoryID
GROUP BY t.TerritoryDescription
HAVING COUNT(ET.TerritoryID)=0;
--FORMA CON COUNT SIN HAVING

select TerritoryDescription
from (select distinct t.TerritoryDescription,
                      COUNT(ET.TerritoryID) Cantidad
      from Territories T
               left outer join EmployeeTerritories ET
                               on T.TerritoryID = ET.TerritoryID
      GROUP BY t.TerritoryDescription) TERR
where Cantidad=0;

--REAL OTRA FORMA
select *
from Territories t
where t.TerritoryID not in (select ET.TerritoryID from EmployeeTerritories ET);

-- 3ER FORMA
select *
from Territories t
where Not EXISTS(select 1 from EmployeeTerritories ET where et.TerritoryID=t.TerritoryID);

--4TA FORMA
select t.TerritoryDescription
from Territories T
EXCEPT
select t.TerritoryDescription
from Territories T
join EmployeeTerritories ET
    on T.TerritoryID = ET.TerritoryID