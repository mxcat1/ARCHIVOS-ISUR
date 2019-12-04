Alter Procedure CREAR_Procedimientos
	@Tabla Varchar(40) = ''
As
Begin
	Declare	@Comando Varchar(MAX)

	Declare CURTablas Cursor For
	Select Name
	From	sys.Tables
	Where	Name = Case @Tabla
						When '' Then Name
						Else @Tabla
					End

	Open CURTablas
	Fetch Next From CURTablas Into @Tabla

	While @@FETCH_STATUS = 0
	Begin
		Set @Tabla = QuoteName(@Tabla)

		Begin /* SELECT TODO*/
			If Exists(Select * From Sys.procedures
					Where Name = Replace(Replace(Replace(@Tabla, '[', ''), ']', ''), ' ', '') + '_SelectTodo'
						And modify_date = create_date)
			Begin
				Set @Comando = 'Drop Procedure ' + Replace(Replace(Replace(@Tabla, '[', ''), ']', ''), ' ', '') + '_SelectTodo'
				exec (@Comando)
			End
			If Not Exists(Select * From Sys.procedures
					Where Name = Replace(Replace(Replace(@Tabla, '[', ''), ']', ''), ' ', '') + '_SelectTodo')
			Begin
				Set @Comando = 'Create Procedure ' + Replace(Replace(Replace(@Tabla, '[', ''), ']', ''), ' ', '') + '_SelectTodo
				As
				Begin
					Select * From ' + @Tabla + 
				';
				End'

				exec (@Comando)
			End
		End

		Begin /* SELECT UNO*/
			If Exists(Select * From Sys.procedures
					Where Name = Replace(Replace(Replace(@Tabla, '[', ''), ']', ''), ' ', '') + '_SelectUno'
						And modify_date = create_date)
			Begin
				Set @Comando = 'Drop Procedure ' + Replace(Replace(Replace(@Tabla, '[', ''), ']', ''), ' ', '') + '_SelectUno'
				exec (@Comando)
			End
			If Not Exists(Select * From Sys.procedures
					Where Name = Replace(Replace(Replace(@Tabla, '[', ''), ']', ''), ' ', '') + '_SelectUno')
			Begin
					select 
							col.[name]  + ' As ' + ty.name + '(' + Convert(varchar(5), col.max_length / Case ty.name
									When 'nchar' Then 2
									When 'nvarchar' Then 2
									When 'ntext' Then 2
								Else 1 End) + ')'
					from sys.tables tab
						inner join sys.indexes pk
							on tab.object_id = pk.object_id 
							and pk.is_primary_key = 1
						inner join sys.index_columns ic
							on ic.object_id = pk.object_id
							and ic.index_id = pk.index_id
						inner join sys.columns col
							on pk.object_id = col.object_id
							and col.column_id = ic.column_id
						Join sys.systypes As TY
							On col.system_type_id = TY.xtype
					Where tab.[name] = Replace(Replace(Replace(@Tabla, '[', ''), ']', ''), ' ', '')

				Set @Comando = 'Create Procedure ' + Replace(Replace(Replace(@Tabla, '[', ''), ']', ''), ' ', '') + '_SelectUno
					@VAR As Tipo(TAM)
				As
				Begin
					Select * From ' + @Tabla + 
				 ' Where CAMPO??? = @VALOR;
				End'

				exec (@Comando)
			End
		End

		Fetch Next From CURTablas Into @Tabla
	End
	Close CURTablas
	Deallocate CURTablas
End
Go
exec CREAR_Procedimientos