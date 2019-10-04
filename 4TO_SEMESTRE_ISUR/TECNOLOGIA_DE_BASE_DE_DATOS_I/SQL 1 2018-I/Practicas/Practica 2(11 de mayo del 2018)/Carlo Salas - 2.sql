/*
Listar todos los clientes donde la inicial de su nombre esten entre la A y la M con Between
*/

select *
from Customers C
where C.ContactName between 'A%' and 'N%' 
order by ContactName