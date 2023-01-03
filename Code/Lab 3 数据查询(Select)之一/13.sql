-- 13) 综合客户表(client)、资产表(property)、理财产品表(finances_product)、

--     保险表(insurance)、基金表(fund)和投资资产表(property)，

--     列出所有客户的编号、名称和总资产，总资产命名为total_property。

--     总资产为储蓄卡余额，投资总额，投资总收益的和，再扣除信用卡透支的金额

--     (信用卡余额即为透支金额)。客户总资产包括被冻结的资产。

--    请用一条SQL语句实现该查询：

select
    c_id,
    c_name,
    ifnull(sum(profit), 0) as total_property
from client
    left join (
        select
            pro_c_id,
            pro_quantity * p_amount + pro_income as profit
        from
            property,
            finances_product
        where
            pro_pif_id = p_id
            and pro_type = 1
        union all
        select
            pro_c_id,
            pro_quantity * i_amount + pro_income as profit
        from
            property,
            insurance
        where
            pro_pif_id = i_id
            and pro_type = 2
        union all
        select
            pro_c_id,
            pro_quantity * f_amount + pro_income as profit
        from property, fund
        where
            pro_pif_id = f_id
            and pro_type = 3
        union all
        select
            b_c_id,
            sum(
                if(
                    b_type = "储蓄卡",
                    b_balance,
                    - b_balance
                )
            ) as profit
        from bank_card
        group by
            b_c_id
    ) pro on c_id = pro.pro_c_id
group by c_id;

/*  end  of  your code  */