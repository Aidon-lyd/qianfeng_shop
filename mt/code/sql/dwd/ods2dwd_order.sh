#!/bin/bash

############################
#将ods中的订单相关表和维度进行退化到订单明细事实表中
############################
yesterday='2019-12-15'

hive -e "
set hive.exec.mode.local.auto=true;
insert overwrite table bbp_dwd.dwd_us_order_detail_day partition(dt='${yesterday}')
select
ouo.order_id,
ouo.order_no,
ouo.order_date,
ouo.user_id,
ouo.user_name,
ouo.order_money,
ouo.order_type,
ouo.order_status,
ouo.pay_status,
ouo.pay_type,
ouo.order_source,
ood.consignee,
ood.area_id,
ood.area_name,
ood.address,
ood.mobile,
ood.phone,
ood.coupon_id,
ood.coupon_money,
ood.carriage_money,
ood.create_time,
ood.addr_id,
dua.order_addr,
dua.user_order_flag,
dcc.id city_id,
dcc.city,
dcc.province,
obt.trade_id,
obt.amount,
obt.trade_type,
obt.trade_time
from bbp_ods.ods_us_order ouo
left join bbp_ods.ods_order_delivery ood
on ouo.order_id = ood.order_id
left join bbp_dim.dim_user_addr dua
on dua.addr_id = ood.addr_id
left join bbp_dim.dim_code_city dcc
on dcc.id = dua.arear_id
left join bbp_ods.ods_biz_trade obt
on obt.order_id = ouo.order_id
where ouo.dt = '${yesterday}'
;
"




