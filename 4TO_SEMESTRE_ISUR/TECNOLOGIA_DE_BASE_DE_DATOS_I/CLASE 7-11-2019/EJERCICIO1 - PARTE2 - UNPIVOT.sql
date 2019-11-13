--Averiguo cuáles son los campos de la tabla para despivotear
Begin
Declare @Texto As Varchar(MAX)

Select	@Texto = String_Agg(QuoteName(Name), ',')
From	sys.columns
Where	object_id = Object_ID('Ventas')
		And column_id > 2
End;

--Ejecutar el unpivot
Begin
exec('
Select	Proveedor, Producto, Pais, Total
From	
		(Select	*
		From	Ventas) As Datos
Unpivot(Total
		For Pais In (' + @Texto + ')
		) As UPVT')
End