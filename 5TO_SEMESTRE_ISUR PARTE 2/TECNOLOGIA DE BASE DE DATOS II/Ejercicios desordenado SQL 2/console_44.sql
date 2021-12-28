declare @clientes xml
select @clientes = N'
<Root>
    <Cliente>

        <CustomerID>ALFKI</CustomerID>

        <CompanyName>Alfreds Futterkiste</CompanyName>

        <ContactName>Maria Anders</ContactName>

    </Cliente>

    <Cliente>

        <CustomerID>ANATR</CustomerID>

        <CompanyName>Ana Trujillo Emparedados y helados</CompanyName>

        <ContactName>Ana Trujillo</ContactName>

    </Cliente>

    <Cliente>

        <CustomerID>ANTON</CustomerID>

        <CompanyName>Antonio Moreno Taquería</CompanyName>

        <ContactName>Antonio Moreno</ContactName>

    </Cliente>

    <Cliente>

        <CustomerID>AROUT</CustomerID>

        <CompanyName>Around the Horn</CompanyName>

        <ContactName>Thomas Hardy</ContactName>

    </Cliente>

    <Cliente>

        <CustomerID>BERGS</CustomerID>

        <CompanyName>Berglunds snabbköp</CompanyName>

        <ContactName>Christina Berglund</ContactName>

    </Cliente>

    <Cliente>

        <CustomerID>BLAUS</CustomerID>

        <CompanyName>Blauer See Delikatessen</CompanyName>

        <ContactName>Hanna Moos</ContactName>

    </Cliente>

    <Cliente>

        <CustomerID>BLOWS</CustomerID>

        <CompanyName>Blow Supercharge</CompanyName>

        <ContactName>Augusto Zavalaga</ContactName>

    </Cliente>

    <Cliente>

        <CustomerID>BOLID</CustomerID>

        <CompanyName>Bólido Comidas preparadas</CompanyName>

        <ContactName>Manuel Summer</ContactName>

    </Cliente>

    <Cliente>

        <CustomerID>BONAP</CustomerID>

        <CompanyName>Bon app''a</CompanyName>

        <ContactName>Laurence Lebihan</ContactName>

    </Cliente>

    <Cliente>

        <CustomerID>BOTTM</CustomerID>

        <CompanyName>Bottom-Dollar Markets</CompanyName>

        <ContactName>Elizabeth Lincoln</ContactName>

    </Cliente>

    <Cliente>

        <CustomerID>BSBEV</CustomerID>

        <CompanyName>B''s Beverages</CompanyName>

        <ContactName>Victoria Ashworth</ContactName>

    </Cliente>

    <Cliente>

        <CustomerID>CACTU</CustomerID>

        <CompanyName>Cactus Comidas para llevar</CompanyName>

        <ContactName>Patrick Gomez</ContactName>

    </Cliente>

    <Cliente>

        <CustomerID>CENTC</CustomerID>

        <CompanyName>Centro comercial Moctezuma</CompanyName>

        <ContactName>Francisco Changa</ContactName>

    </Cliente>

    <Cliente>

        <CustomerID>CHOPS</CustomerID>

        <CompanyName>Chop-suey Chinese</CompanyName>

        <ContactName>Yang Wang</ContactName>
    </Cliente>
    <Cliente>
        <CustomerID>COMMI</CustomerID>
        <CompanyName>Comércio Mineiro</CompanyName>
        <ContactName>Pedro Afonso</ContactName>
    </Cliente>
</Root>';

-- select CustomerID=Clientes.Item.value('CustomerID[1]', 'nchar(5)'),
--        CompanyName=Clientes.Item.value('CompanyName[1]', 'nvarchar(40)'),
--        ContactName=Clientes.Item.value('ContactName[1]', 'nvarchar(40)')
-- from @clientes.nodes('Root/Cliente') as Clientes(Item);

-- Create table CustomersTemp(
--     CustomerID nchar(5) primary key,
--     CompanyName nvarchar(40) not null ,
--     ContactName nvarchar(40) not null
-- )
--
-- insert into CustomersTemp select CustomerID,CompanyName,ContactName from Customers



merge Customers as target
using (select CustomerID=Clientes.Item.value('CustomerID[1]', 'nchar(5)'),
              CompanyName=Clientes.Item.value('CompanyName[1]', 'nvarchar(40)'),
              ContactName=Clientes.Item.value('ContactName[1]', 'nvarchar(40)')
       from @clientes.nodes('Root/Cliente') as Clientes(Item)) as source
on (target.CustomerID = source.CustomerID)
WHEN MATCHED THEN
    update
    set target.CompanyName=source.CompanyName, target.ContactName=source.ContactName
WHEN NOT MATCHED BY TARGET THEN
    insert (CustomerID, CompanyName, ContactName)
    values (source.CustomerID, source.CompanyName, source.ContactName);


select * from Customers

