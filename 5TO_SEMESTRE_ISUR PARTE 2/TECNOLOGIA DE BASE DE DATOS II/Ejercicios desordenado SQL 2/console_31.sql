-- DATOS XML

select *
from Customers
for xml path ('Cliente');

-- De xml a la base de datos

declare @Texto as xml
set @Texto = '
<root>
    <Cliente>
        <CustomerID>ALFKI</CustomerID>
        <CompanyName>Alfreds Futterkiste</CompanyName>
        <ContactName>MARIA ANDERS</ContactName>
        <ContactTitle>Sales Representative</ContactTitle>
        <Address>Obere Str. 57</Address>
        <City>Berlin</City>
        <PostalCode>12209</PostalCode>
        <Country>Germany</Country>
        <Phone>030-0074321</Phone>
        <Fax>030-0076545</Fax>
    </Cliente>
    <Cliente>
        <CustomerID>ANATR</CustomerID>
        <CompanyName>Ana Trujillo Emparedados y helados</CompanyName>
        <ContactName>ANA TRUJILLO</ContactName>
        <ContactTitle>Owner</ContactTitle>
        <Address>Avda. de la Constitución 2222</Address>
        <City>México D.F.</City>
        <PostalCode>05021</PostalCode>
        <Country>Mexico</Country>
        <Phone>(5) 555-4729</Phone>
        <Fax>(5) 555-3745</Fax>
    </Cliente>
    <Cliente>
        <CustomerID>ANTON</CustomerID>
        <CompanyName>Antonio Moreno Taquería</CompanyName>
        <ContactName>Antonio Moreno</ContactName>
        <ContactTitle>Owner</ContactTitle>
        <Address>Mataderos 2312</Address>
        <City>México D.F.</City>
        <PostalCode>05023</PostalCode>
        <Country>Mexico</Country>
        <Phone>(5) 555-3932</Phone>
    </Cliente>
</root>'

declare @Codigo int
-- para convertir xml en una tabla
exec sp_xml_preparedocument @Codigo OUTPUT, @Texto
-- o si no con OPENROWSET


-- Para acceder ala tabla q se creo a
-- aprtir del xml se usa la variable codigo que tiene el codigo de la tabla en memoria

select *
from openXML(@Codigo, '/root/Cliente', 2)
--              with (CustomerID varchar(5) '@CustomerID',Phone varchar(40) '@Phone',City varchar(40) '@City',Country varchar(40) '@Country')
             with (CustomerID varchar(5) ,Phone varchar(40) ,City varchar(40) ,Country varchar(40) )

exec sp_xml_removedocument @Codigo

-- CON @NODES

declare @Texto as xml
set @Texto = '
<root>
    <Cliente CustomerID="ALFKI" Address="Obere Str. 57">
    </Cliente>
</root>'

SELECT doc.col.value('@CustomerID','varchar(5)') CustomerID,doc.col.value('@Address','varchar(40)') Address FROM @Texto.nodes('/root/Cliente') doc(col)


declare @Texto as xml
set @Texto = '
<root>
    <Cliente>
        <CustomerID>ANTON</CustomerID>
        <Address>Mataderos 2312</Address>
    </Cliente>
</root>'


SELECT doc.col.value('CustomerID[1]','varchar(5)') CustomerID,doc.col.value('Address[1]','varchar(40)') Address FROM @Texto.nodes('/root/Cliente') doc(col)
-- OPENQUERY
-- utilizado paara ahcer consultas en servidores diferentes