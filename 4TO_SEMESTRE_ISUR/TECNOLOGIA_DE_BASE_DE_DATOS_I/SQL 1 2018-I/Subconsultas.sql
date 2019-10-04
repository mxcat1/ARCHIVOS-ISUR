select*,
      (select
       count(*)
        from Orders
        Where CustomerID = TD.ID
        )
from(
select C.CustomerID ID,
	   C.CompanyName Empresa,
	   C.ContactName + '(' + C.ContactTitle + ')' as "Cliente(Cargo)",
	   Country + ' - ' + Coalesce(Region + ' - ', '') + City as Lugar
from Customers C
where C.CompanyName like '%[αινσϊ]%') as TD
Where Lugar like '%-%-%'
