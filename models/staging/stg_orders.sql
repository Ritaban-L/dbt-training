select 
--creating surrrogate key using dbt_utils package imported in file packages.yml
{{ dbt_utils.surrogate_key(['o.orderid', 'c.customerid', 'p.productid']) }} as sk_orders,
--from raw orders
o.orderid,
o.orderdate,
o.shipdate,
o.shipmode,
o.ordersellingprice - o.ordercostprice as orderprofit,
o.ordercostprice,
o.ordersellingprice,
--from raw customer
c.customerid,
c.customername,
c.segment,
c.country,
--from raw product
p.productid,
p.category,
p.productname,
p.subcategory,
--calling predefined macro markup.sql
{{ markup('ordersellingprice', 'ordercostprice') }} as markup,
--column from seed file delivery_team.csv
d.delivery_team
from {{ ref('raw_orders') }} as o
left join {{ ref('raw_customer') }} as c
on o.customerid = c.customerid
left join {{ ref('raw_product') }} as p
on o.productid = p.productid
--adding the seed file delivery_team.csv
left join {{ ref('delivery_team') }} as d
on o.shipmode = d.shipmode

--if we wanted to run the macro limit_data_in_dev
--{{limit_data_in_dev('orderdate')}}