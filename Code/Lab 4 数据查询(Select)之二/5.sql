-- 5) 查询任意两个客户的相同理财产品数

--   请用一条SQL语句实现该查询：

select
    A.pro_c_id as pro_c_id,
    B.pro_c_id as pro_c_id,
    count(distinct A.pro_pif_id) as total_count
from property A, property B
where
    A.pro_type = 1
    and B.pro_type = 1
    and A.pro_c_id != B.pro_c_id
    and A.pro_pif_id = B.pro_pif_id
group by
    A.pro_c_id,
    B.pro_c_id
having
    count(distinct A.pro_pif_id) >= 2
order by A.pro_c_id;

/*  end  of  your code  */