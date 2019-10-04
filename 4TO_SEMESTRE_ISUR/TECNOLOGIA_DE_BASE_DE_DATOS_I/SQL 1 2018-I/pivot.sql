
select *
from
	(select format(OrderDate,'MMMM' ,'ES-pe') as periodo,
				e.FirstName + '' + e.LastName as Empleado,
				o.ShipCountry as Pais
			   --datepart(month,OrderDate),
			  -- month(orderdate),
			  --datename(month,orderDate),
			  --case DATEPART(month,orderdate)
			  --when 1 then 'enero'
			  --when 2 then 'febrero'
			  --end
		from Orders as o
			 join Employees as e
			 on o.EmployeeID=e.EmployeeID)as Origen
 pivot(count(Pais)
        for periodo in ([Enero],[Febrero],[Marzo],[Abril],[Mayo],[Junio],[Julio],
		[Agostol],[Setimbre],[Octubre],[Noviembre],[Diciembre])) as PT

---------
with TablaCTE as 
		(select format(OrderDate,'MMMM' ,'ES-pe') as periodo,
					e.FirstName + '' + e.LastName as Empleado,
					o.ShipCountry as Pais
			  
			from Orders as o
				 join Employees as e
				 on o.EmployeeID=e.EmployeeID
	)

	select * from TablaCTE
	 pivot(count(Pais)
			for periodo in ([Enero],[Febrero],[Marzo],[Abril],[Mayo],[Junio],[Julio],
			[Agostol],[Setimbre],[Octubre],[Noviembre],[Diciembre])) as PT

	-------------
	select *
	INTO  OrdenesXPeriodo

		    from
			(select format(OrderDate,'MMMM' ,'ES-pe') as periodo,
						e.FirstName + '' + e.LastName as Empleado,
						o.ShipCountry as Pais
			
				from Orders as o
					 join Employees as e
					 on o.EmployeeID=e.EmployeeID)as Origen
		    pivot(count(Pais)
				for periodo in ([Enero],[Febrero],[Marzo],[Abril],[Mayo],[Junio],[Julio],
				[Agostol],[Setimbre],[Octubre],[Noviembre],[Diciembre])) as PT


select *
from OrdenesXPeriodo