-- 19) 以日历表格式列出2022年2月每周每日基金购买总金额，输出格式如下：

-- week_of_trading Monday Tuesday Wednesday Thursday Friday

--               1

--               2

--               3

--               4

--   请用一条SQL语句实现该查询：

select
    week week_of_trading,
    sum(if(dayId = 0, amount, null)) Monday,
    sum(if(dayId = 1, amount, null)) Tuesday,
    sum(if(dayId = 2, amount, null)) Wednesday,
    sum(if(dayId = 3, amount, null)) Thursday,
    sum(if(dayId = 4, amount, null)) Friday
from (
        select
            week(pro_purchase_time) - 5 as week,
            weekday(pro_purchase_time) as dayId,
            sum(pro_quantity * f_amount) as amount
        from property, fund
        where
            pro_pif_id = f_id
            and pro_purchase_time like "2022-02-%"
            and pro_type = 3
        group by
            pro_purchase_time
    ) temp
group by week;

/*  end  of  your code  */