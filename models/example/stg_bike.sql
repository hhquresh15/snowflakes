with bike as(
    select * from {{ source('my_source', 'bike') }}
)
select * from bike
