--EJE1
--listar el monto total de las ordenes por cada ciudad region y pais
--ej,
--         Pais-Region Ciudad               Monto
-- 01 Brazik                            1000
--  01.01 RJ                        400
-- 01.01.01 Rio de Janeiro      400
--  01.02 SP                        600
-- 01.02.01 Campinas            200
-- 01.02.02 Campinas            100
-- 01.02.03 Campinas            300

with paices as (
    select TDA1.Number,
           TDA1.ShipCountry,
           case
               when last_value(TDA1.Region) over (partition by TDA1.ShipCountry order by TDA1.Number,TDA1.ShipCountry) is null and
                    TDA1.ShipCity is null
                   then '_'
               else TDA1.Region
               end NewRegion,
           case
               when TDA1.ShipCity is null
                   then '__'
               else TDA1.ShipCity
               end NewCiudad,
           TDA1.Monto
    from (select row_number() over (partition by o.ShipCountry order by o.ShipCountry) Number
                  ,
                 o.ShipCountry,
                 case
                     when o.ShipRegion is null and o.ShipCity is null then null
                     when o.ShipRegion is null and o.ShipCity is not null then '_'
                     else o.ShipRegion
                     end                                                                            Region,
                 o.ShipCity,
                 sum((os.Quantity * os.UnitPrice * (1 - os.Discount)) + o.Freight)                  Monto
          from Orders O
                   join [Order Details] OS
                        on O.OrderID = OS.OrderID
          group by rollup (o.ShipCountry, o.ShipRegion, o.ShipCity)) TDA1
), ejei as (
        --ANCHOR
    select distinct o.Number,
           o.ShipCountry,
           o.NewRegion,
           o.NewCiudad,
           1 Nivel
    from paices O
    where o.NewRegion='_'
        --RECURSIVO
    UNION ALL
    select os.Number,
           os.ShipCountry,
           os.NewRegion,
           os.NewCiudad,
           EJE.Nivel+1 Nivel
    from paices os join ejei EJE on os.Number=EJE.Number and os.NewRegion<>EJE.NewRegion
)select * from ejei option (maxrecursion 1000);
