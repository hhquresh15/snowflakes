{ 
    config(
        materialized = 'incremental',
        on_schema_change = 'fail'
    )
}}

with trips as(
    select 
    ride_id,
    date(to_timestamp(started_at)) as trip_date,
    start_station_id,
    end_station_id,
    member_casual,
    timestampdiff(second,to_timestamp(started_at),to_timestamp(ended_at)) as trip_duration_seconds
    from {{ ref('stg_bike') }}
)
select * from trips

{% if is_incremental() %}
    where trip_date > (select max(trip_date) from {{ this }})
{% endif %}

    select * from dbt_target.stg_bike;

    INSERT INTO dbt_target.stg_bike
(
    RIDE_ID,
    RIDEABLE_TYPE,
    STARTED_AT,
    ENDED_AT,
    START_STATION_NAME,
    START_STATION_ID,
    END_STATION_NAME,
    END_STATION_ID,
    START_LAT,
    START_LNG,
    END_LAT,
    END_LNG,
    MEMBER_CASUAL
)
VALUES
(
    'RIDE20190001001',
    'electric_bike',
    '2019-01-01 08:15:00.000',
    '2019-01-01 08:42:00.000',
    'Lyons Lane',
    'ST8867',
    'Villanueva Forge',
    'ST7017',
    40.68291686,
    -74.010137144,
    40.708797704,
    -74.033597219,
    'casual'
);
