{{ config(materialized = 'view') }}

with cte as(
    select 
    date(time) as daily_weather,
    weather,
    temp,
    pressure,
    humidity,
    clouds
    from {{ ref('stg_weather') }}
),
cte2 as(
    select 
    daily_weather,
    weather as dominant_weather,
    round(avg(temp),2) as avg_temp,
    round(avg(pressure),2) as avg_pressure,
    round(avg(humidity),2) as avg_humidity,
    round(avg(clouds),2) as avg_clouds
    from cte
    group by daily_weather,weather
    qualify row_number() over(partition by daily_weather order by count(weather) desc)=1
)
select * from cte2


----------------
