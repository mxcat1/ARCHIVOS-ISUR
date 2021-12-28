/**4.		Muestra del sexto al décimo libro más costoso.**/

select title,price from titles order by price desc ;


select title as titulo,
       price
from titles
order by price desc
offset 0 rows fetch next 18 rows only;

select title as titulo,
       price
from titles
order by price desc
offset 5 rows fetch next 5 rows only;


/**1.       Muestra un listado donde se vea el nombre completo del empleado (nombre + apellido),
			el nombre de la editora donde trabaja y el nombre del cargo que desempeña.**/


select (fname + ' ' + lname) 'nombres y apellidos', jobs.job_desc, publishers.pub_name
from employee
         join jobs on employee.job_id = jobs.job_id
         join publishers on employee.pub_id = publishers.pub_id


select *
from employee
         join jobs
              on employee.job_id = jobs.job_id
where employee.job_id = 14


select distinct s.ord_num, s.ord_date
from sales s
order by ord_date
offset 0 rows fetch next 10 rows only;

select distinct top 10 s.ord_num, s.ord_date
from sales s
order by ord_date

select (au_fname + ' ' + au_lname) 'nombres y apellidos', titles.title
from authors a
         join titleauthor ta on a.au_id = ta.au_id
         join titles on titles.title_id = ta.title_id
order by title


select *
from authors a
         join titleauthor ta on a.au_id = ta.au_id
         join titles on titles.title_id = ta.title_id
order by title;


select sales.ord_num, sales.payterms from sales where sales.payterms='Net 30' or sales.payterms='Net 60';

select (e.lname + ' ' + e.fname) 'nombre y apellidos', year(e.hire_date) contratacion
from employee as e
where year(e.hire_date)>=1990 and year(e.hire_date)<1992
order by YEAR(hire_date)

select Libros=t.title
from titles as t join sales as sa on t.title_id = sa.title_id
where exists (select s.title_id, s.stor_id
              from sales as s
              group by s.title_id, s.stor_id)
group by t.title
having count(t.title)>1;

select sa.stor_id,count(sa.stor_id) over (partition by sa.title_id ) as [Cantidad de tienda], Libros=t.title
from titles as t join sales as sa on t.title_id = sa.title_id
group by sa.stor_id,sa.title_id, t.title
having count(sa.stor_id) over (partition by sa.title_id )>1;

select count(sa.stor_id) as [Cantidad de tienda], Libros=t.title
from titles as t join sales as sa on t.title_id = sa.title_id
group by t.title
having count(sa.stor_id)>1