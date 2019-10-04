--Hacer un listado por cliente que me muestre cuando ha variado su compra mes a mes

Declare @Periodo varchar(1000)

	set @Periodo= ( select Periodo
                    from(
                    	select distinct  Format(O.OrderDate, 'MMMM yyyy') as Periodo,
                    	                 Year(O.OrderDate) as Anio,
                    					 MONTH(O.OrderDate)	as Mes			
                    	from Orders O ) T
                    Order by Anio, Mes
				for XML PAth(''))

set @Periodo= REPLACE(@Periodo, '</Periodo><Periodo>','],[')
set @Periodo = REPLACE(@Periodo, '<Periodo>','[')
set @Periodo = REPLACE(@Periodo, '</Periodo>',']')


exec('
select *
from(
	select CompanyName,
		   Periodo,
		   Coalesce(VariacionMonto,monto) as VariacionMonto
	from(
		select CompanyName,
			   Periodo,
			   Monto,
			   Monto - Lag(Monto,1)over(Partition by CompanyName order by CompanyName, Anio, Mes) as VariacionMonto
		from(
			select CompanyName,
				   Anio,
				   Mes,
				   Periodo,
				   isnull(round(Monto,2),0) as Monto
			from(
				select Periodos.CompanyName,
					   Periodos.Anio,
					   Periodos.Mes,
					   Periodos.Periodo,
					   Monto	   
				from(
					select T.CompanyName,
						   Anio,
						   Mes,
						   sum(Monto) as Monto
						from(
							select C.CompanyName,
								   Year(O.OrderDate) as Anio,
								   Month(O.OrderDate) as Mes,
								   Sum(OD.UnitPrice * OD.Quantity * (1-OD.Discount)) + O.Freight as Monto
							from Customers C join Orders O
							on C.CustomerID = O.CustomerID 
							join [Order Details] OD
							on O.OrderID = OD.OrderID
							group by C.CompanyName,
									 Year(O.OrderDate), 
									 Month(O.OrderDate),
									 O.Freight
						) as T
						group by T.CompanyName,
								 Anio,
								 Mes
				) as T2

					right join

					(select distinct C.CompanyName,
							Year(O.OrderDate) as Anio,
						   Month(O.OrderDate) as Mes,
						   format(O.OrderDate, ''MMMM yyyy'') as Periodo
					from Customers C cross join Orders O ) as Periodos
				on T2.CompanyName = Periodos.CompanyName and T2.Anio = Periodos.Anio and T2.Mes = Periodos.Mes
			) as NoNulos
		) as Total
	) as NoNulosVariacionMonto
) as Pivoteo
Pivot(sum(VariacionMonto) for Periodo in('+ @Periodo +')) as PVT
Order by CompanyName')



