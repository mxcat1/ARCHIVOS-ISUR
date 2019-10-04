With Clientes_España
As(Select	C.CustomerID As ID,
		C.CompanyName As Empresa,
		C.ContactName As Contacto,
		C.City As Ciudad
From	Customers As C
Where	C.Country = 'Spain')
Select	*
From	Clientes_España