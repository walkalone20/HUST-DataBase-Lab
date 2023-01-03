-- 3) 查询购买了所有畅销理财产品的客户

--   请用一条SQL语句实现该查询：

select
    distinct pro_c_id
from property x
where not exists(
        select *
        from property y
        where pro_pif_id in (
                select pro_pif_id
                from property
                where pro_type = 1
                group by pro_pif_id
                having
                    count(distinct pro_c_id) > 2
            )
            and not exists(
                select *
                from property z
                where
                    z.pro_type = 1
                    and x.pro_c_id = z.pro_c_id
                    and y.pro_pif_id = z.pro_pif_id
            )
    )
order by pro_c_id;