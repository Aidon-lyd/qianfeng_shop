#!/bin/bash

############################
#将dwd的数据统计到dm集市层
############################
yesterday='2019-12-15'

hive -e "
set hive.exec.mode.local.auto=true;
insert overwrite table bbp_dm.dm_order_distribute partition(dt='${yesterday}')
select
odd.dt date_dt,
odd.province province,
odd.city city,
sum(case when odd.user_order_flag = 1 then 1 else 0 end) school_orders,
sum(case when odd.user_order_flag = 2 then 1 else 0 end) company_orders,
sum(case when odd.user_order_flag = 3 then 1 else 0 end) home_orders,
sum(case when hour(odd.order_date) between 0 and 5 then 1 else 0 end) orders_05_cnt,
sum(case when hour(odd.order_date) between 6 and 12 then 1 else 0 end) orders_612_cnt,
sum(case when hour(odd.order_date) between 13 and 15 then 1 else 0 end) orders_1315_cnt,
sum(case when hour(odd.order_date) between 16 and 20 then 1 else 0 end) orders_1620_cnt,
sum(case when hour(odd.order_date) between 21 and 24 then 1 else 0 end) orders_2124_cnt
from bbp_dwd.dwd_us_order_detail_day odd
where odd.dt = '${yesterday}'
group by odd.dt,odd.province,odd.city
;
"
