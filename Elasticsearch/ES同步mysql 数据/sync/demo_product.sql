-- 脚本不能用分号结束，还要在外层包裹语句
select `id`, `guid`,`product_name`, `create_time`,`modify_time` from `demo_product`  where `modify_time` >= :sql_last_value
