#!/bin/bash

############################
#将dwd的数据统计到dm集市层
############################
yesterday=`date -d "1 days ago" "+%Y-%m-%d"`
two_days_ago=`date -d "2 days ago" "+%Y-%m-%d"`

hive -e "
set hive.exec.mode.local.auto=true;
from (
select
tmp.user_id user_id,
min(tmp.order_date) first_order_time,
max(tmp.order_date) last_order_time,
datediff('${yesterday}',min(tmp.order_date)) first_order_diff,
datediff('${yesterday}',max(tmp.order_date)) last_order_diff,
sum(tmp.no_order_30) no_order_30_cnt,
sum(tmp.no_amount_30) no_amount_30_cnt,
sum(tmp.no_order_60) no_order_60_cnt,
sum(tmp.no_amount_60) no_amount_60_cnt,
sum(tmp.no_order_90) no_order_90_cnt,
sum(tmp.no_amount_90) no_amount_90_cnt,

sum(tmp.in_order_30) in_order_30_cnt,
sum(tmp.in_amount_30) in_amount_30_cnt,
sum(tmp.in_order_60) in_order_60_cnt,
sum(tmp.in_amount_60) in_amount_60_cnt,
sum(tmp.in_order_90) in_order_90_cnt,
sum(tmp.in_amount_90) in_amount_90_cnt,

sum(tmp.in_amount_90)/sum(tmp.in_order_90)*1.0 in_order_avg,
max(tmp.amount) max_amount,
min(tmp.amount) min_amount,
sum(tmp.no_amount_90)/sum(tmp.no_order_90)*1.0 no_order_avg,
max(case when tmp.rn_addr_cnt = 1 then tmp.order_address end) common_order_address,
max(case when tmp.rn_paytype_cnt = 1 then tmp.pay_type end) common_pay_type,
sum(tmp.now_order)+if(max(dob.total_orders) is null,0,max(dob.total_orders)) now_order_cnt,
sum(tmp.now_amount)+if(max(dob.total_amount) is null,0,max(dob.total_amount)) now_amount_cnt

from (
select
odd.user_id user_id,
odd.order_date order_date,
case when datediff('${yesterday}',date(odd.order_date)) <= 30 and odd.trade_type = 1 then 1 else 0 end no_order_30, 
case when datediff('${yesterday}',date(odd.order_date)) <= 30 and odd.trade_type = 1 then odd.amount else 0 end no_amount_30, 
case when datediff('${yesterday}',date(odd.order_date)) <= 60 and odd.trade_type = 1 then 1 else 0 end no_order_60, 
case when datediff('${yesterday}',date(odd.order_date)) <= 60 and odd.trade_type = 1 then odd.amount else 0 end no_amount_60, 
case when datediff('${yesterday}',date(odd.order_date)) <= 90 and odd.trade_type = 1 then 1 else 0 end no_order_90, 
case when datediff('${yesterday}',date(odd.order_date)) <= 90 and odd.trade_type = 1 then odd.amount else 0 end no_amount_90, 
                    
case when datediff('${yesterday}',date(odd.order_date)) <= 30 then 1 else 0 end in_order_30, 
case when datediff('${yesterday}',date(odd.order_date)) <= 30 then odd.amount else 0 end in_amount_30, 
case when datediff('${yesterday}',date(odd.order_date)) <= 60 then 1 else 0 end in_order_60, 
case when datediff('${yesterday}',date(odd.order_date)) <= 60 then odd.amount else 0 end in_amount_60, 
case when datediff('${yesterday}',date(odd.order_date)) <= 90 then 1 else 0 end in_order_90, 
case when datediff('${yesterday}',date(odd.order_date)) <= 90 then odd.amount else 0 end in_amount_90, 
odd.amount amount,
case when datediff('${yesterday}',date(odd.order_date)) < 1 then 1 else 0 end now_order, 
case when datediff('${yesterday}',date(odd.order_date)) < 1 then odd.amount else 0 end now_amount, 
row_number() over(partition by odd.user_id order by (count(*) over(partition by odd.user_id,odd.addr_id)) desc) rn_addr_cnt,
odd.address order_address,
row_number() over(partition by odd.user_id order by (count(*) over(partition by odd.user_id,odd.pay_type)) desc) rn_paytype_cnt,
odd.pay_type pay_type
from bbp_dwd.dwd_us_order_detail_day odd
where odd.dt >  date_sub('${yesterday}',90)) tmp
left join bbp_dm.dm_order_basic dob
on dob.user_id = tmp.user_id and dob.dt = '${two_days_ago}' 
group by tmp.user_id ) res1
insert overwrite table bbp_dm.dm_order_basic partition(dt='${yesterday}')
select 
'${yesterday}',
*
;
"




