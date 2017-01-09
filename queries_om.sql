use om;
select * from om.orders;
delete from om.orders where order_id=832;
insert into om.orders value (832, 11, '2014-08-02', '2014-08-05');
replace into om.orders value (832, 13, '2014-08-02', '2014-08-05');
create view v as SELECT * FROM om.orders where order_id=any (select order_id from om.order_details);
select * from om.v;
drop view om.v