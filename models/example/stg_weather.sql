with weather as (
 select * from {{source('my_source', 'weather') }}    
)
    select * from weather 