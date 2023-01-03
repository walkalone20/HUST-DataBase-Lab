-- 1) 查询销售总额前三的理财产品

--   请用一条SQL语句实现该查询：

select
    2010 as pyear,
    rank() over(
        order by
            sum(
                property.pro_quantity * p_amount
            ) desc
    ) as rk,
    pro_pif_id as p_id,
    sum(
        property.pro_quantity * p_amount
    ) as sumamount
from
    property,
    finances_product
where
    property.pro_pif_id = finances_product.p_id
    and pro_type = 1
    and pro_purchase_time <= "2010-12-31"
    and pro_purchase_time >= "2010-01-01"
group by pro_pif_id
limit 3
union
select
    2011 as pyear,
    rank() over(
        order by
            sum(
                property.pro_quantity * p_amount
            ) desc
    ) as rk,
    pro_pif_id as p_id,
    sum(
        property.pro_quantity * p_amount
    ) as sumamount
from
    property,
    finances_product
where
    property.pro_pif_id = finances_product.p_id
    and pro_type = 1
    and pro_purchase_time <= "2011-12-31"
    and pro_purchase_time >= "2011-01-01"
group by pro_pif_id
limit 3;

/*  end  of  your code  */