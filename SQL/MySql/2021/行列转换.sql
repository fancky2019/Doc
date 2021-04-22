select s_name,

max(if(course="数学",score,0)) as 数学,  -- 如果统计个数 用sum (if(course="数学",1,0))

max(if(course='语文',score,0)) as 语文,

max(if(course='英语',score,0)) as 英语,

sum(score) as 总分  -- 求和

from grade group by s_name;


-- 条数
-- sum(if(sign_in_status='202',1,0)) as ' sign_in_status_count202', -- 
--  count(sign_in_status) sign_in_status_count_total


-- sqlsever 可以利用 sum( case when then 1
--                        case when then 0) 来进行统计求和
   