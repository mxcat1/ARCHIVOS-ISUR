ALTER TABLE Customers
ADD Estado VARCHAR(30);
SELECT C.CustomerID, 
       C.CompanyName, 
       CONVERT(VARCHAR(30), '') AS Estado
INTO Clientes
FROM Customers C
WHERE 1 = 2;
UPDATE Customers
  SET 
      Estado = CASE
                   WHEN Phone IS NULL
                   THEN CASE
                            WHEN Fax IS NULL
                            THEN 'SIN FONO NI FAX'
                            ELSE 'SIN FONO'
                        END
                   ELSE CASE
                            WHEN Fax IS NULL
                            THEN 'SIN FAX'
                            ELSE ''
                        END
               END
OUTPUT Inserted.CustomerID, 
       Inserted.CompanyName, 
       inserted.Estado
       INTO Clientes
WHERE NOT(Phone IS NOT NULL
          AND Fax IS NOT NULL);
SELECT *
FROM Clientes;
SELECT *
FROM Customers;
DROP TABLE Clientes;
ALTER TABLE Customers DROP COLUMN Estado;