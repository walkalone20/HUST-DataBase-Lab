-- 2) 投资积极且偏好理财类产品的客户

--   请用一条SQL语句实现该查询：

select
    distinct finance_cnt.pro_c_id as pro_c_id
from (
        select
            pro_c_id,
            if(
                count(distinct pro_pif_id),
                count(distinct pro_pif_id),
                null
            ) as finance_product
        from property
        where property.pro_type = 1
        group by
            property.pro_c_id
    ) finance_cnt, (
        select
            pro_c_id,
            if(
                count(distinct pro_pif_id),
                count(distinct pro_pif_id),
                null
            ) as fund
        from property
        where property.pro_type = 3
        group by
            property.pro_c_id
    ) fund_cnt
where
    finance_cnt.pro_c_id = fund_cnt.pro_c_id
    and finance_cnt.finance_product > fund_cnt.fund
    and finance_cnt.pro_c_id in (
        select pro_c_id
        from property
        group by pro_c_id
        having
            count(distinct pro_pif_id) >= 3
    )
order by pro_c_id;

/*  end  of  your code  */