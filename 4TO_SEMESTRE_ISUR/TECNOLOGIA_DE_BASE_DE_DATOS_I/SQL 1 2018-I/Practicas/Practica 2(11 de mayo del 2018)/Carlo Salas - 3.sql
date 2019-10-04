/*
Listar todos los clientes donde la inicial de su nombre esten entre la A y la M con Like
*/

select *
from Customers C
where C.ContactName like '[A-M]%'
order by ContactName