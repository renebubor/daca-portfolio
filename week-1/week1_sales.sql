SELECT COUNT(*) AS ridade_arv
FROM sales;
-- leian ridade arvu tabelis (15234)
SELECT *
FROM sales
LIMIT 10;
--millised veerud ja andmed on tabelis
SELECT *
FROM sales
WHERE store_location = 'Tallinn'
ORDER BY sale_date DESC
LIMIT 15;
--ainult Tallinna kaupluse tehingud
SELECT *
FROM sales
ORDER BY total_price DESC
LIMIT 10;
--10 suurimat tehingut summa järgi
SELECT *
FROM sales
ORDER BY total_price ASC
LIMIT 10;
--10 väikseimat tehingut summa järgi
SELECT COUNT(*) - COUNT(customer_id) AS puuduv_klient
FROM sales;
-- leian mitu rida on ilma kliendi id-ta (1487)