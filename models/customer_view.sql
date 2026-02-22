with payments as (
    select *
    from {{ref("stg_payments")}}
),
orders as (
    select *
    from {{ref('stg_orders')}}
),
customers as (
    select *
    from {{ref('stg_customers')}}
),
final as (
    select p.*,
            o.customer_id,
            c.first_name,
            c.last_name,
            o.order_date,
            o.status as order_status
    from payments p
    left join orders o
    on p.order_id=o.order_id
    left join customers c
    on o.customer_id=c.customer_id
)
select *
from final
-- select customer_id,
--         sum(amount) as total_amount,
--         sum(case when status='fail' then 1 else 0 end) as fail_count,
--         sum(case when status='success' then 1 else 0 end) as success_count
-- from final
-- group by customer_id
-- order by 2 desc,3 desc