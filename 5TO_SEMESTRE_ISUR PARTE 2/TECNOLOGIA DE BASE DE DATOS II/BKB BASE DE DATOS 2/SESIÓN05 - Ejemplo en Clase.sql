/*
    STORED PROCEDURES - Procedimientos Almacenados
    Create Procedure - Crear
    Alter Procedure - Modificar
    Drop Procedure - Eliminar
    exec - Ejecutar

    - Pueden recibir argumentos o parámetros
	   - Entrada / Salida
	   - Obligatorios / Opcionales

    - Para listar los procedimientos o su contenido:
	   - Sys.Procedures
	   - Sp_Help
	   - Sp_HelpText

    - Seguridad => ENCRIPTACION

    - Bucles		    => While
    - Condicionales	    => If, Case, Iif
    - Variables
	   - Declarar		   => Declare
	   - Asignar valor	   => Select / Set
    - Tablas
	   - Físicas
		  - Select Into => Cuando la tabla no existe
		  - Create Table + Insert => Cuando la tabla ya existe
	   - Temporales => #
*/

Declare @Nombre As varchar(15)
Select @Nombre = 'Sergio'
Print @Nombre
Set @Nombre = 'Augusto'
Print @Nombre

Select Top 10 * 
into Productos_Mas_Caros
from Products order By UnitPrice Desc

If Not OBJECT_ID('Productos_Mas_Caros') Is Null
Begin
    Drop Table Productos_Mas_Caros
End

Create Table Productos_Mas_Caros
    (ID int,
    Nombre varchar(30),
    Precio Money )

Insert into Productos_Mas_Caros
Select Top 10 ProductID, ProductName, UnitPrice 
from Products order By UnitPrice Desc

Select * from Productos_Mas_Caros

Select Top 10 * 
into #Productos_Mas_Caros
from Products order By UnitPrice Desc

Select * 
From #Productos_Mas_Caros

Drop Table #Productos_Mas_Caros