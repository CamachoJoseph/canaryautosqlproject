-- Total Revenue of vendor
SELECT v.vendid AS 'Vendor ID',
	sum(oi.grandtotal) AS 'Revenue'
FROM orderitem oi
	INNER JOIN vendor v
		ON oi.vendid=v.vendid
	GROUP BY oi.vendid;

-- Total Orders for vendor
SELECT v.vendid AS 'Vendor ID',
	count(oi.orderitemid) AS 'Total Orders'
FROM orderitem oi
	INNER JOIN vendor v
		ON oi.vendid=v.vendid
	GROUP BY oi.vendid;
    
-- Total Parts listed by vendor	 (different parts, not quantity)
SELECT v.vendid AS 'Vendor ID',
	count(s.partid) AS 'Total Parts Listed'
FROM vendor v
	INNER JOIN stock s
		ON v.vendid=s.vendid
	GROUP BY s.vendid;
    
-- Vendors whose Subscription will end soon( 30 days from current date, sorted by days left )
SELECT v.vendid AS 'Vendor ID', 
	DATEDIFF(v.subscriptionEndsOn,CURDATE()) AS 'Subscription Expires In(Days)'
FROM vendor v 
WHERE DATEDIFF(v.subscriptionEndsOn,CURDATE())<30
ORDER BY `Subscription Expires In(Days)`;
