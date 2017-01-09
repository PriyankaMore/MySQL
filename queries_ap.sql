use ap;
select * from ap.terms;
delete from ap.terms where terms_id=6;
insert into ap.terms value (6, 'Net due 120 days', 120);
replace into ap.terms value (6, 'Net due 120 days', 120);
create view v as SELECT * FROM ap.vendors where vendor_id=any (select vendor_id from ap.vendor_contacts);
select * from ap.v;
drop view ap.v