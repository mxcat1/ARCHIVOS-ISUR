declare @alumnos xml,@cursos xml

select @alumnos = N'
<Root>
    <Alumno Nombres="Juan" Apellidos="Miranda Juarez">
        <Curso Nombre="Matematica" Nota="17"/>
        <Curso Nombre="Base de Datos" Nota="9"/>
    </Alumno>
    <Alumno Nombres="Pedro" Apellidos="Valencia Melgar">
        <Curso Nombre="Programacion" Nota="11"/>
        <Curso Nombre="Base de Datos" Nota="12"/>
    </Alumno>
</Root>'

select Alumno=Alumnos.Item.value('@Nombres', 'varchar(50)'),
       Matematica= case Alumnos.Item.value('Curso[1]/@Nombre', 'varchar(50)')
                       when 'Matematica'
                           then Alumnos.Item.value('Curso[1]/@Nota', 'int')
                       else 0 end,
       [Base de Datos]= case Alumnos.Item.value('Curso[2]/@Nombre', 'varchar(50)')
                            when 'Base de Datos'
                                then Alumnos.Item.value('Curso[2]/@Nota', 'int')
                            else 0 end,
       Programacion= case Alumnos.Item.value('Curso[1]/@Nombre', 'varchar(50)')
                       when 'Programacion'
                           then Alumnos.Item.value('Curso[1]/@Nota', 'int')
                       else 0 end
from @alumnos.nodes('Root/Alumno') as Alumnos(Item)


