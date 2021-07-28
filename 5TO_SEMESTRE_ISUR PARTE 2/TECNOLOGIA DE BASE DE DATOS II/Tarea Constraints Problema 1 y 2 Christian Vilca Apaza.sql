-- 1.- Valida que en la tabla empleados, el campo del teléfono (HomePhone) deba ser ingresado con 2 o 3 números entre paréntesis,
-- seguido de un espacio en blanco, tres números, un guión y 4 números (tal como están los datos actualmente)


ALTER TABLE Employees
    add CONSTRAINT chk_phone CHECK (Employees.HomePhone like
                                    '%[(][0-9][0-9][0-9][)][ ][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9]'
        or Employees.HomePhone like '%[(][0-9][0-9][)][ ][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9]')


-- 2.- Valida que el campo Title of Courtesy de la tabla employees contenga Mr., Mrs., Ms., o Dr..
-- Solo deben aceptarse esos valores.


ALTER TABLE Employees
    add constraint chkTitleOfCourtesy check (Employees.TitleOfCourtesy like '[MD][rs][s.]' or
                                             Employees.TitleOfCourtesy like '[MD][rs][s][.]')