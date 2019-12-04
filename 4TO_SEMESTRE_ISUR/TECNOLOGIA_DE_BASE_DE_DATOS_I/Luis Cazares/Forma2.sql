DECLARE @FechaInicio datetime,
        @FechaFin    datetime;

SELECT @FechaInicio = MIN(OrderDate), 
       @FechaFin    = MAX(OrderDate)
FROM Orders;

DECLARE @Columnas nvarchar(max) = '',
        @SQL      nvarchar(max);

--Generamos el código de las columnas
WITH 
E(n) AS( -- 10 filas
    SELECT n FROM (VALUES(0),(0),(0),(0),(0),(0),(0),(0),(0),(0))E(n)
),
E2(n) AS( -- 10x10 = 100 filas
    SELECT a.n FROM E a, E b
),
E4(n) AS( -- 100x100 = 10,000 filas
    SELECT a.n FROM E2 a, E2 b
),
cteTally(n) AS(
    SELECT TOP(DATEDIFF( MM, @FechaInicio, @FechaFin) + 1 ) --limitamos el número de filas
        ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) - 1 AS n  --Generamos los números del 0 a N
    FROM E4
),
cteMeses(Mes) AS(
    SELECT DATEADD(MM, DATEDIFF( MM, 0, @FechaInicio) + n, 0) Mes --Le sumamos N meses a la fecha inicial y los convertimos al primer día del mes.
    FROM cteTally
)
SELECT @Columnas =( SELECT CHAR(9) + N',SUM(CASE WHEN o.OrderDate >= ' + QUOTENAME( CONVERT( nchar(8), Mes, 112), '''') --Convertimos el mes actual a formato YYYYMMDD y le ponemos comillas
                            + N' AND o.OrderDate < ' + QUOTENAME( CONVERT( nchar(8), DATEADD( MM, 1, Mes), 112), '''') --Convertimos el mes siguiente a formato YYYYMMDD y le ponemos comillas
                            + N' THEN ( od.UnitPrice * od.Quantity ) * ( 1 - od.Discount ) + o.Freight ELSE 0 END) AS ' 
                            + QUOTENAME( DATENAME(MM, Mes) + '-' + DATENAME(YY, Mes)) + NCHAR(10)--Tomamos el nombre del mes y año y los ponemos entre corchetes
                FROM cteMeses
                FOR XML PATH(''), TYPE).value('./text()[1]', 'nvarchar(max)'); --Esta parte concatena todo en un XML y luego lo convierte en nvarchar(max)

--Juntamos las 3 partes de la consulta        
SELECT @SQL =  N'
    SELECT ISNULL( p.ProductName, ''Total'') AS Producto
           ,ISNULL( c.CategoryName, ''Global'') AS Categoria
           ,SUM(( od.UnitPrice * od.Quantity ) * ( 1 - od.Discount ) + o.Freight) TT
           ' + @Columnas + N'
    FROM   Products         AS P
    JOIN   Categories       AS C  ON P.CategoryID = C.CategoryID
    JOIN   [Order Details]  AS OD ON P.ProductID  = OD.ProductID
    JOIN   Orders           AS O  ON OD.OrderID   = O.OrderID
    WHERE o.OrderDate >= @FechaInicio
    AND   o.OrderDate <  @FechaFin
    GROUP BY c.CategoryName, p.ProductName WITH ROLLUP
    ORDER BY c.CategoryName, p.ProductName;';

EXECUTE sp_executesql @SQL, --Enviamos la consulta
                    N'@FechaInicio datetime, @FechaFin datetime', --Declaramos los parámetros
                    @FechaInicio, @FechaFin; --Enviamos los parámetros