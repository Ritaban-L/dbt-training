{{
    config(
        materialized='table'
    )
}}

--select * from RAW.GLOBALMART.PRODUCT
select * from {{ source('globalmart', 'product') }}