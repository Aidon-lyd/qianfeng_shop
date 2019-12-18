#!/bin/bash

##########################
#½á¹û¿â
#########################

CREATE TABLE `order_distribute` (
  `dt` varchar(10) NOT NULL DEFAULT '0',
  `province` varchar(10) NOT NULL DEFAULT '0',
  `city` varchar(10) NOT NULL DEFAULT '0',
  `school_orders` int(11)(11) NOT NULL DEFAULT '0',
  `company_order` int(11)(11) NOT NULL DEFAULT '0',
  `home_order` int(11)(11) NOT NULL DEFAULT '0',
  `hour0_5_order` int(11)(11) NOT NULL DEFAULT '0',
  `hour6_12_order` int(11)(11) NOT NULL DEFAULT '0',
  `hour13_15_order` int(11)(11) NOT NULL DEFAULT '0',
  `hour16_20_order` int(11)(11) NOT NULL DEFAULT '0',
  `hour21_24_order` int(11)(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`dt`,`province`,`city`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS dm_order_basic (
date_dt varchar(20),
user_id varchar(20),
first_order_time varchar(20),
last_order_time varchar(20),
first_order_diff int(11),
last_order_diff int(11),
no_order_30_cnt int(11),
no_amount_30_cnt double(11,3),
no_order_60_cnt int(11),
no_amount_60_cnt double(11,3),
no_order_90_cnt int(11),
no_amount_90_cnt double(11,3),
in_order_30_cnt int(11),
in_amount_30_cnt double(11,3),
in_order_60_cnt int(11),
in_amount_60_cnt double(11,3),
in_order_90_cnt int(11),
in_amount_90_cnt double(11,3),
in_order_avg double(11,3),
max_amount double(11,3),
min_amount double(11,3),
no_order_avg double(11,3),
common_order_address varchar(50),
common_pay_type int(11),
total_orders int(11),
total_amount double(11,3),
PRIMARY KEY (`date_dt`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

"


