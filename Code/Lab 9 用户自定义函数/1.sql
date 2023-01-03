use finance1;

set global log_bin_trust_function_creators=1;

drop function IF EXISTS get_deposit;

/*
 用create function语句创建符合以下要求的函数：
 依据客户编号计算该客户所有储蓄卡的存款总额。
 函数名为：get_Records。函数的参数名可以自己命名:*/

delimiter $$

CREATE FUNCTION GET_DEPOSIT(CLIENT_ID INT) RETURNS 
NUMERIC(10, 2) BEGIN 
	return (
	        select sum(b_balance)
	        from bank_card
	        where b_type = "储蓄卡"
	        group by b_c_id
	        having b_c_id = client_id
	    );
END$ 

$ 

delimiter ;

select
    c_id_card,
    c_name,
    get_deposit(c_id) as total_deposit
from client
where
    get_deposit(c_id) >= 1000000
order by total_deposit desc;

/*  代码文件结束     */