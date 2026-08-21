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
SELECT DISTINCT channel
FROM sales;
-- leian kõik erinevad müügikanalid tabelis (online ja pood)
SELECT store_location,
    COUNT(*) AS tehinguid
FROM sales
GROUP BY store_location
ORDER BY tehinguid DESC;
-- leian kaupluse asukoha ja tehingute arvu, rühmitan asukoha järgi ja järjestan tehingute arvu järgi kahanevalt
SELECT *
FROM sales
WHERE total_price > 100
    AND store_location = 'Tallinn'
ORDER BY total_price DESC;
-- leian kõik tehingud, mis on suuremad kui 100 ja toimusid Tallinna kaupluses, järjestan summa järgi kahanevalt