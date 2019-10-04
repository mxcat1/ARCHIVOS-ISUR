-- INSERT DELETE UPDATE

-- INSERT SIMPLE DE UNA SOLA FILA

    --LIMITACIONES COMPOS MISMO ORDEN

insert into Territories
    values ('00000','PRUEBA',1);

--INSERT COMPUESTO CON LOS CAMPOS EN EL NOMBREMIENTO DE LOS CAMPOS NO SE PUEDE PONER IDENTYTIES

INSERT INTO Territories(RegionID,TerritoryID,TerritoryDescription)
    values (1,'1234','Prueba1');

        --VALORES POR DEFAULT => DEFAULT 'ALGO POR DEFECTO' U OPCIONALES => NULLS

INSERT INTO Employees(LastName,FirstName)
    values ('Pablo','Puert');
        --NO SE PUEDE USAR EN DOS TABLAS ALA VEZ
        SET IDENTITY_INSERT Employees OFF ; --PARA PODER INSERTAR LOS IDENTYTIES A MANO TMB

-- INSERT INTO Employees(EmployeeID,LastName,FirstName)
--     values (15,'Pablo','Puert');

--INSERT MULTIPLE

INSERT INTO Employees (LastName,FirstName)
    values ('Ponce','Diego'),
           ('Miranda','Julio'),
           ('Miranda','Julio');

--INSERT SELECT

INSERT INTO Suppliers(CompanyName,
                      ContactName,
                      ContactTitle,
                      Address,
                      City,
                      Region,
                      PostalCode,
                      Country,
                      Phone,
                      Fax)
            select CompanyName,
                   ContactName,
                   ContactTitle,
                   Address,
                   City,
                   Region,
                   PostalCode,
                   Country,
                   Phone,
                   Fax
            from Customers
            where Country='USA';

--SELECT INTO inserta datos en una tabla que no existe ya que lo crea

select CustomerID,
       CompanyName,
       ContactName,
       ContactTitle,
       Address,
       City,
       Region,
       PostalCode,
       Country,
       Phone,
       Fax
into tabla1 --#tabla1 significa tabla temporal con el numeral
from Customers c where c.Country='USA';





select *
from tabla1;

sp_help tabla1;
sp_help Suppliers;--para IDE sql magnament studio es ALT+F1 muestra toda la informacion de la tabla
sp_help Customers;
select *
from Suppliers;

select *
from Employees;


select * from Territories;