-- Search Engine
SELECT DISTINCT p.id AS 'Part ID',
	p.title AS 'Search Suggestion'
FROM parts p
WHERE p.title LIKE 'Ford % wheel %';

-- Available Vendors 
SELECT s.vendid, 
	p.title,
    s.price,
    s.quantity,
    p.cond
FROM stock s
INNER JOIN parts p
	ON s.partid=p.id
WHERE p.title= 'FORD FIESTA WZ STEEL WHEEL HUB CAP' AND p.cond like '%used';

-- Lowest price of part offered by vendor

SELECT p.title,s.vendid AS 'Vendor ID', min(s.price) AS 'Sorted by price', s.quantity AS 'Units in Stock'
FROM parts p
	INNER JOIN stock s
		ON s.partid=p.id
		WHERE p.title='FORD FIESTA WZ STEEL WHEEL HUB CAP'
        GROUP BY p.title,s.vendid, s.quantity
        ORDER BY min(s.price);


