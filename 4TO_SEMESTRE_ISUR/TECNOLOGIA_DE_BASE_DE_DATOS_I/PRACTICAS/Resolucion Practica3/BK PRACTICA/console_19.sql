--EJERCICIOS

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

--EJE2
    --consultar metadata para hacer un tabla que contenga los objetos creados cuantos y la fecha del primer al ultimo objeto
    --ej

    --  OBJETOS     ABRIL-2019      MAYO-2019   JUNIO-2019      JULIO-2019      ...-2019        DICIEMBRE-2019
    --  TABLA           12              12          12              12              11              111
    --  VISTAS          11              15          11              0               0               0
    --  PROCEDIMIENTOS  11              15          11              0               0               0
    --  .               11              15          11              0               0               0
    --  .               11              15          11              0               0               0
    --  .               11              15          11              0               0               0

--EJE3
    --tranformar un tabla en un de conversiones
    --ej1

    --      MONEDA      RATIO
    --      USD         3.46
    --      EUR         4

    --TRANSFORMARLO EN

    --      MONEDA          EUR         PEN         USD
    --      EUR             1           4           ??
    --      PEN             0.?         1           0.?
    --      USD             0.?         3.46        1
    --