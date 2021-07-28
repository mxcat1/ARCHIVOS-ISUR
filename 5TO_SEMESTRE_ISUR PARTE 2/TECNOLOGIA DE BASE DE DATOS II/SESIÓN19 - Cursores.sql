/************************************
CURSORES:
Objeto en memoria similar a una Tabla

1.- Declarar el cursor
2.- Abrir el cursor
3.- Usar el cursor ==> Fila por Fila
4.- Cerrar el cursor
5.- Borrarlo de la memoria
************************************/

Declare CUR_Productos Cursor
For Select ProductID, 
		 productName, 
		 UnitPrice
    From   Products
    Order By UnitPrice Desc;

Declare 
	  @ID     Int, 
	  @Nombre VarChar(40), 
	  @Precio Money;

Open CUR_Productos;

Fetch Next From CUR_Productos Into 
							@ID, 
							@Nombre, 
							@Precio;--Lee el primer registro

While @@FETCH_STATUS = 0
	Begin
		Print @ID
		Print @Nombre
		Fetch Next From CUR_Productos Into 
							@ID, 
							@Nombre, 
							@Precio;
	End;
--Fetch Prior From CUR_Productos
--Print @@FETCH_STATUS

Close CUR_Productos;

Deallocate CUR_Productos;

/*EJEMPLO DE TRIGGER CON CURSOR*/
Go
Alter Trigger Alta_Clientes On Customers
For Insert
As
Begin
    Declare @ContactName varchar(40), @Email Varchar(30)
    Declare @Asunto Varchar(100)
    Declare CLINU Cursor For
	   Select ContactName, Email From inserted

    Open CLINU

    Fetch Next From CLINU Into @ContactName, @Email

    While @@FETCH_STATUS = 0
    Begin
	   Set @Asunto = 'Bienvenido ' + @ContactName
    exec msdb.dbo.sp_send_dbmail @Subject=@Asunto,
			 @Body = 'Saludos cordiales, nos complace......',
			 @Recipients= @Email
			 Fetch Next From CLINU Into @ContactName, @Email
    End
    Close CLINU
    Deallocate CLINU
End

Insert Into Customers(CustomerID, CompanyName, contactName, Email)
values ('ISUR4', 'Instituto del Sur', 'Pablo Grados', 'd.ponce.cornejo@isur.edu.pe'),
	   ('ISUR5', 'Instituto del Sur', 'Jose Pardo', 'd.ponce.cornejo@isur.edu.pe'),
	   ('ISUR6', 'Instituto del Sur', 'Angel Vela', 'd.ponce.cornejo@isur.edu.pe')