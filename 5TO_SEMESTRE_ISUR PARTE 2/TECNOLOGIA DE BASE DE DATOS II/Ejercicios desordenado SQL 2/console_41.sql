select TABLE_NAME, COLUMN_NAME
from INFORMATION_SCHEMA.COLUMNS;


with eje4 as (
    select row_number() over (order by TABLE_NAME) n,convert(varchar(max),row_number() over (order by TABLE_NAME)) n1, tva1.TABLE_NAME nombretabla
    from (select distinct TABLE_NAME from INFORMATION_SCHEMA.COLUMNS) tva1
    union all
    select eje4.n,convert(varchar(max) ,'0'+eje4.n1+'.'+convert(varchar(max),row_number() over (order by COLUMN_NAME))) n2, COLUMN_NAME
    from (select COLUMN_NAME, TABLE_NAME from INFORMATION_SCHEMA.COLUMNS) c1 inner join eje4 on c1.TABLE_NAME=eje4.nombretabla)
select * from eje4 order by 1,3

