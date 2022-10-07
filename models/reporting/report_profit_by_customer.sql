--it is table by default from dbt_project.yml so no need to configure

select
    customerid,
    segment,
    country,
    sum(orderprofit) as profit
from {{ ref('stg_orders') }}
group by
    customerid,
    segment,
    country