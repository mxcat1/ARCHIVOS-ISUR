/*
1.Saber las ordenes que no tienen detalle(insertar registros en ordenes) 
2.Listado de aquellos paises(Orders.ShipCountry), listado de paises(Suppliers.Country)
  que paises de Orders no estan en el listado de paises de Suppliers 
*/

--1
 insert into Orders(CustomerID,EmployeeID,ShipCountry, OrderDate) values('SIMOB',4,'Peru',getDate())
 insert into Orders(CustomerID,EmployeeID,ShipCountry, OrderDate) values('SIMOB',4,'Peru',getDate())
 insert into Orders(CustomerID,EmployeeID,ShipCountry, OrderDate) values('SIMOB',4,'Peru',getDate())
 insert into Orders(CustomerID,EmployeeID,ShipCountry, OrderDate) values('SIMOB',4,'Peru',getDate())


select *
from Orders O left join [Order Details] OD
on O.OrderID = OD.OrderID
where OD.OrderID is null


--2
select distinct s.Country as [Paises de Orders], O.ShipCountry as [Paises de Suppliers]
from Suppliers s right join Orders O
on S.Country = O.ShipCountry
where Country is null



