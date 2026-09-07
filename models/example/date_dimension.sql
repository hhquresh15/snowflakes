with cte as(
    select 
    to_timestamp(started_at) as started_at,
    date(to_timestamp(started_at)) as date_started_at,
    hour(to_timestamp(started_at)) as hour_started_at,
    case 
        when dayname(to_timestamp(started_at)) in ('Sat','Sun') then 'Weekend'
        else 'BusinessDay' end as Day_Type,
    case 
        when month(to_timestamp(started_at)) in (12,1,2) then 'Winter'
        when month(to_timestamp(started_at)) in (3,4,5) then 'Spring'
        when month(to_timestamp(started_at)) in (6,7,8) then 'Summer'
        else 'Autumn' end as Season_of_Year
    from {{ ref('stg_bike') }}
)
select * from cte