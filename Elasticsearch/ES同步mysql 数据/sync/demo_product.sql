-- 脚本不能用分号结束，还要在外层包裹语句，使用函数要加列名
select `id`, `product_name`,`product_style`,
        DATE_FORMAT(`create_time`,'%Y-%m-%d %H:%i:%s')create_time,DATE_FORMAT(`modify_time`,'%Y-%m-%d %H:%i:%s')modify_time,
        `description`,`price`, `count`,`produce_address` 
from `demo_product`  where `modify_time` >= :sql_last_value
