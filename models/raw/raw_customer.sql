{{
    config(
        materialized='table'
    )
}}

--select * from RAW.GLOBALMART.CUSTOMER
select * from {{ source('globalmart', 'customer') }}