-- First query top 5 brands by receipts scanned in the most recent month


select distinct(b.name) as Brand, count(b.brandCode) as Brand_Occurence 
from brands_new b inner join (
	select rew.receiptid, rew.brandCode
	from receipts_new r, rewardsreceiptitemlist_new rew
	where rew.receiptid = r._id
	and MONTH(str_to_date(r.dateScanned, '%Y-%m-%d %H:%i:%s')) = (select MONTH(max(str_to_date(dateScanned, '%Y-%m-%d %H:%i:%s'))) from receipts_new)
) rid 
on b.brandCode = rid.brandCode 
where rid.brandCode != ''
group by Brand
order by Brand_Occurence desc
limit 5;

-- Second query to final 

select distinct(b.name) as Brand, count(b.brandCode) as Brand_Occurence 
from brands_new b inner join (
	select rew.receiptid, rew.brandCode
	from receipts_new r, rewardsreceiptitemlist_new rew
	where rew.receiptid = r._id
	and MONTH(str_to_date(r.dateScanned, '%Y-%m-%d %H:%i:%s')) = (
		select month(max(str_to_date(rep.dateScanned, '%Y-%m-%d %H:%i:%s'))) from receipts_new rep
		where month(str_to_date(rep.dateScanned, '%Y-%m-%d %H:%i:%s')) < (select month(max(str_to_date(dateScanned, '%Y-%m-%d %H:%i:%s'))) from receipts_new)
	)
) rid 
on b.brandCode = rid.brandCode
where rid.brandCode != ''
group by Brand
order by Brand_Occurence desc
limit 5;


-- Comparison between first and second query:
/*
	-- 	I have used brandCode column from rewardsReceiptItemList and brands table to join. 
    -- 	When I ran the first query there were no results. But when I ran the second query, 
		for top 5 brands in the previous month, to compare the results I found one record
        of brand Viva that was a top brand.
*/

-- Third query

select if(
	(select avg(totalSpent) from receipts_new where rewardsReceiptStatus = 'FINISHED') > 
    (select avg(totalSpent) from receipts_new where rewardsReceiptStatus = 'REJECTED'), "total spent with rewardsReceiptStatus='ACCEPTED' is greater", "total spent with rewardsReceiptStatus='REJECTED' is greater"
) comparison;


-- Fourth Query

select if (
(
	select count(ril.receiptid) as total_items
	from rewardsreceiptitemlist_new ril join receipts_new r
	on ril.receiptid = r._id
	where rewardsReceiptStatus = 'FINISHED'
) > (
	select count(ril.receiptid) as total_items
	from rewardsreceiptitemlist_new ril join receipts_new r
	on ril.receiptid = r._id
	where rewardsReceiptStatus = 'REJECTED'
) ,
"Accepted is greater", "Rejected is greater"
);

-- Fifth query

select sum(rew.itemPrice) as total, b.name, b.brandCode
from rewardsreceiptitemlist_new rew join brands_new b 
on rew.brandCode = b.brandCode
where rew.receiptid in (
	select distinct(r._id) from users_new u join receipts_new r on u._id = r.userId
	where str_to_date(u.createdDate, '%Y-%m-%d %H:%i:%s') > curdate() - interval (dayofmonth(curdate()) - 1) day - interval 6 month
)
and b.brandCode != ''
group by b.name, b.brandCode
order by total desc
limit 1;

-- Sixth query

select count(rew.receiptid) as Most_transactions, b.name, b.brandCode
from rewardsreceiptitemlist_new rew join brands_new b 
on rew.brandCode = b.brandCode
where rew.receiptid in (
	select distinct(r._id) from users_new u join receipts_new r on u._id = r.userId
	where str_to_date(u.createdDate, '%Y-%m-%d %H:%i:%s') > curdate() - interval (dayofmonth(curdate()) - 1) day - interval 6 month
)
and b.brandCode != ''
group by b.name, b.brandCode
order by Most_transactions desc
limit 1;

