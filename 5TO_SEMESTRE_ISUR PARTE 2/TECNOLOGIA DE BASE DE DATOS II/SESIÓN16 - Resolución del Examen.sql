/******************************************************************************
Haz un procedimiento almacenado que reciba el nombre de un producto 
y muestre un listado de cuántas unidades de dicho producto compró cada cliente.
Mostrar el nombre del cliente y la sumatoria de unidades compradas
 (Quantity), los registros deben estar ordenados descendentemente 
 por cantidad
******************************************************************************/

Alter Procedure Preg1 
			 @NombreProducto VarChar(40)
As
	Begin
		Select Customers.CompanyName, 
			  Sum([Order Details].Quantity) As Cantidad
		From   Customers
				  Inner Join Orders
			  On Customers.CustomerID = Orders.CustomerID
				  Inner Join [Order Details]
			  On Orders.OrderID = [Order Details].OrderID
				  Inner Join Products
			  On [Order Details].ProductID = Products.ProductID
		Where  Products.ProductName = @NombreProducto
		Group By Customers.CompanyName
		Order By 2 Desc;
	End;
		Go

Exec Preg1 
	'Queso Cabrales';
/*******************************************************************
Haz un procedimiento almacenado que reciba los datos de un producto 
	como parámetros e inserte un registro en la tabla de productos 
	con los valores suministrados
*******************************************************************/
Go

Alter Procedure Preg2 
			 @ProductName     VarChar(40), 
			 @SupplierID      Int, 
			 @CategoryID      Int, 
			 @QuantityPerUnit VarChar(20), 
			 @UnitPrice       Money, 
			 @UnitsInStock    SmallInt, 
			 @UnitsOnOrder    SmallInt, 
			 @ReorderLevel    SmallInt, 
			 @Discontinued    Bit
As
	Begin
		Begin
			Insert Into          Products ( ProductName, 
									  SupplierID, 
									  CategoryID, 
									  QuantityPerUnit, 
									  UnitPrice, 
									  UnitsInStock, 
									  UnitsOnOrder, 
									  ReorderLevel, 
									  Discontinued ) 
			Values
			(
				  @ProductName, 
				  @SupplierID, 
				  @CategoryID, 
				  @QuantityPerUnit, 
				  @UnitPrice, 
				  @UnitsInStock, 
				  @UnitsOnOrder, 
				  @ReorderLevel, 
				  @Discontinued
			);
		End;

		Exec Preg2 
			'Coca Cola', 
			3, 
			1, 
			'Caja x 12', 
			25, 
			300, 
			0, 
			50, 
			0;
		Select *
		From   Products;
	End;
		Go
/**********************************************************
	Haz una función escalar que reciba un cliente 
	y devuelva la fecha de la última compra de dicho cliente. 
	Luego haz una consulta donde uses la función.
**********************************************************/

Alter Function Preg3(
			@Cliente Char(5))
Returns Date
As
	Begin
		Return
		(
		    Select Max(OrderDate)
		    From   Orders
		    Where  CustomerID = @Cliente
			);
	End;
Go

Select CustomerID, 
	  CompanyName, 
	  ContactName, 
	  dbo.preg3(CustomerID)
From   Customers;
/**********************************************************************
Haz una TVF que reciba dos fechas y devuelva un listado de todos 
los días laborables (de lunes a viernes) que hay entre las dos fechas. 
Haz una consulta donde uses la función.
**********************************************************************/
Go

Alter Function Preg4(
			@Fecha1 Date, 
			@Fecha2 Date)
Returns @Fechas Table
(
				  Fecha Date
)
As
	Begin
		Declare 
			  @FechaActual As Date;

		Set @FechaActual = @Fecha1;
		While @FechaActual <= @Fecha2
			Begin
				If DatePart(WeekDay, @FechaActual) Between 2 And 6
					Begin
						Insert Into @Fechas
						Values
						(
							  @FechaActual
						)
				End;
				Set @FechaActual = DateAdd(Day, 1, @FechaActual);
			End;
		Return;
	End;
Go

Select *
From   dbo.Preg4('20210101', '20210521');
/************************************************************
Haz una TVF que reciba el nombre de una categoría y devuelva 
todos los productos de la categoría (nombre y precio) 
Usa la TVF en una consulta
************************************************************/
Go

Create Function Preg5
(
			 @NombreCategoria VarChar(15)
)
Returns Table
As
	Return
(
    Select P.ProductName, 
		 P.UnitPrice
    From   Products As P
			 Join Categories As C
		 On C.CategoryID = P.CategoryID
    Where  C.CategoryName = @NombreCategoria
	);
Go

Select *
From   dbo.Preg5('Condiments');
/**************************************************************************
Haz un trigger que envíe un correo al administrador del sistema 
cada vez que se modifiquen o eliminen funciones, procedimientos o tablas. 
El correo debe contener información de qué se hizo, quién lo hizo y cuándo.
**************************************************************************/
Go

Alter Trigger Preg6 On Database
For Alter_Function, Alter_Procedure, Alter_Table, Drop_Function, Drop_Procedure, Drop_Table
As
	Begin
		Declare 
			  @TextoCorreo VarChar(Max);
		Set @TextoCorreo = ' Se realizó un comando ' + EventData().value('(/EVENT_INSTANCE/EventType)[1]', 'nvarchar(max)') + ' en la base de datos';
		Set @TextoCorreo = @TextoCorreo + Char(10) + 'El objeto cambiado es: ' + EventData().value('(/EVENT_INSTANCE/ObjectName)[1]', 'nvarchar(max)');
		Set @TextoCorreo = @TextoCorreo + Char(10) + 'El cambio fue realizado por: ' + SUser_Name();
		Set @TextoCorreo = @TextoCorreo + Char(10) + 'Fue realizado el: ' + Format(GetDate(), 'dd/MM/yyyy');

		Exec msdb.dbo.sp_send_dbmail 
			@Recipients = 'dponce@isur.edu.pe', 
			@Body = @TextoCorreo;
	End;
/***************************************************************************************
Haz un trigger que se dispare cuando se eliminan ítems de órdenes de compra,
si se han eliminado todos los ítems entonces SQL debe borrar automáticamente la cabecera
***************************************************************************************/
Go

Alter Trigger Preg7 On [Order Details]
For Delete
As
	Begin
		Delete Orders
		Where  OrderID In
		(
		    Select O.OrderID
		    From   orders As O
					 Left Join [Order Details] As OD
				 On O.OrderID = OD.OrderID
		    Group By O.OrderID
		    Having Count(OD.OrderID) = 0
			);
	End;

		Select *
		From   Orders
		Where  OrderID = 11075;
		Select *
		From   [Order Details]
		Where  OrderID = 11075;

		Delete From [Order Details]
		Where       OrderID = 11075
				  And ProductID >= 3;