select C.CustomerID, c.ContactName, c.ContactTitle, c.Country
from Customers C
where c.Country = 'Spain'
   or c.Country = 'Mexico';

 CREATE NONCLUSTERED INDEX Pregunta2 ON Customers (CustomerID,ContactName,ContactTitle,Country);