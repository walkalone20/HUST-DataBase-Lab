use finance1;

drop trigger if exists before_property_inserted;

-- 请在适当的地方补充代码，完成任务要求：

delimiter $$

CREATE TRIGGER BEFORE_PROPERTY_INSERTED BEFORE INSERT 
ON PROPERTY FOR EACH ROW BEGIN 
	declare message varchar(50);
	if (new.pro_type = 1) then if (
	    new.pro_pif_id not in (
	        select p_id
	        from finances_product
	    )
	) then
	set
	    message = concat(
	        "finances product #",
	        new.pro_pif_id,
	        " not found!"
	    );
	end if;
	elseif(new.pro_type = 2) then if (
	    new.pro_pif_id not in (
	        select i_id
	        from insurance
	    )
	) then
	set
	    message = concat(
	        "insurance #",
	        new.pro_pif_id,
	        " not found!"
	    );
	end if;
	elseif(new.pro_type = 3) then if (
	    new.pro_pif_id not in (
	        select f_id
	        from fund
	    )
	) then
	set
	    message = concat(
	        "fund #",
	        new.pro_pif_id,
	        " not found!"
	    );
	end if;
	else
	set
	    message = concat(
	        "type ",
	        new.pro_type,
	        " is illegal!"
	    );
	end if;
	if (message is not null) then SIGNAL SQLSTATE '45000'
	SET MESSAGE_TEXT = message;
	end if;
END$ 

$ 

delimiter ;