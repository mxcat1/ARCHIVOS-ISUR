select *
from(
	select OrderID,
			   EmployeeID,
			   Fecha,
			   OrderDate,
			   Monto,
			   Acumulado,
			   Meta,  
			   Coalesce(convert(varchar(10),Meta),'No hay meta registrada para ese mes') as '¿LLegó a la meta?'
		from(
			select OrderID,
				   EmployeeID,
				   format(Fecha,'MMMM yyyy', 'ES-Pe') as Fecha,
				   OrderDate,
				   Monto,
				   sum(Monto)over(Partition by EmployeeID,Year(OrderDate),Month(OrderDate) order by OrderID) as Acumulado
			from(
				select O.OrderID,
					   O.EmployeeID,
					   O.OrderDate as Fecha,
					   O.OrderDate,
					   round((select sum(OD.Quantity * OD.UnitPrice * (1 - OD.Discount)) 
						from [Order Details] OD
						Where O.OrderID = OD.OrderID) + O.Freight,2) as Monto
				from Orders O) as T) as T2
			full join Metas
			on Metas.Periodo = T2.Fecha
		Where Meta is null

        UNION

		select OrderID,
			   EmployeeID,
			   Fecha,
			   OrderDate,
			   Monto,
			   Acumulado,
			   Meta,			  
			   IIF((Acumulado > Meta),'SI','NO') as '¿LLegó a la meta?'
		from(
			select OrderID,
				   EmployeeID,
				   format(Fecha,'MMMM yyyy', 'ES-Pe') as Fecha,
				   OrderDate,
				   Monto,	   
				   sum(Monto)over(Partition by EmployeeID,Year(OrderDate),Month(OrderDate) order by OrderID) as Acumulado
			from(
				select O.OrderID,
					   O.EmployeeID,
					   O.OrderDate as Fecha,
					   O.OrderDate,
					   round((select sum(OD.Quantity * OD.UnitPrice * (1 - OD.Discount)) 
						from [Order Details] OD
						Where O.OrderID = OD.OrderID) + O.Freight,2) as Monto
				from Orders O) as T) as T2
			full join Metas
			on Metas.Periodo = T2.Fecha
		Where Meta is not null
) T3
order by EmployeeID, OrderDate
