
declare @emp int

set @emp = (select count(*) from Employees E)


select CustomerID,
       ContactName,
	   CompanyName,
	   Phone,
	   (select FirstName +' '+LastName 
	    from Employees
		where EmployeeID = T.grupo ) as [Empleado Asignado]
from(
	select C.CustomerID,
		   C.ContactName,
		   C.CompanyName,
		   C.Phone,
		   ntile(@emp)over(order by CustomerID) as grupo
	from Customers C
	Where Phone is not null) T
