/*
PROCEDIMIENTOS ALMACENADOS (STORED PROCEDURES)
- CREATE PROCEDURE
- ALTER PROCEDURE
- DROP PROCEDURE
- CREATE OR ALTER
- EXECUTE
- sp_HelpText

- Pueden tener argumentos
    - Obligatorios / Opcionales
    - Entrada / Salida

- Variables
    - Declarar - Nombre comienza con @ (Declare)
    - Asignar valor (Set/Select)
    - Mostrar (Select/Print)
- Bucles / Iteraciones / Repeticiones
    - While
    X Until
    X For
    X For Each

- Condicionales
    - If
    - Iif - Inmediate If
    - Case
    - CHOOSE
*/

Declare @Precio As Money, @NomProducto As Varchar(30)
Set @Precio = 50
Set @NomProducto = 'Impresora'
Select @Precio, @NomProducto
Select  @Precio = 18,
	   @NomProducto = 'Mouse'

Select @Precio, @NomProducto
Print @Precio
Print @NomProducto

Declare @Fecha As Date = '20210327'
Select @Fecha

Declare @Contador TinyInt = 0
While @Contador <= 100
Begin
    Print @Contador
    Set @Contador = @Contador + 1
End

Declare @Nota As TinyInt = 8
If @Nota >= 13
Begin
    Print 'Aprobado'
    Print 'FELICIDADES'
End
Else
Begin
    Print 'Desaprobado'
    Print 'UNA PENA....'
End

Declare @Nota1 As TinyInt = 3
Print Iif(@Nota1 >= 13, 'Aprobado', 'Reprobado')
Print Iif(@Nota1 >= 13, 'Felicidades', 'Qué Pena')

Select  *,
	   CHOOSE(CategoryID,'Beverages'			  ,
	   		  'Condiments'			  ,
	   		  'Confections'		  ,
	   		  'Dairy Products'		  ,
	   		  'Grains/Cereals'		  ,
	   		  'Meat/Poultry'		  ,
	   		  'Produce'			  ,
	   		  'Seafood')
			  ,
	   Case CategoryID
		  When 1 Then 'Beverages'
		  When 2 Then 'Condiments'
		  When 3 Then 'Confections'
		  When 4 Then 'Dairy Products'
		  When 5 Then 'Grains/Cereals'
		  When 6 Then 'Meat/Poultry'
		  When 7 Then 'Produce'
		  When 8 Then 'Seafood'
	   End
From	   Products

Select * From Categories

/*
    USANDO: VARIABLES, CONDICIONALES, BUCLES

    1 Chai
	   15/04/1997    ALFKI 4
	   19/04/1997    BONAP 8
    2 Vodka
	   1/2/1998     VINET 9
	   .
	   .
	   .
	   .
	   .

*/