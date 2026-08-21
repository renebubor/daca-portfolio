SELECT COUNT(*) - COUNT(customer_id) AS puuduv_klient
FROM sales;
-- leian mitu rida on ilma kliendi id-ta (1487)
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
SELECT channel,
    COUNT(*) AS tehingute_arv
FROM sales
WHERE store_location is NULL
GROUP BY channel
ORDER BY tehingute_arv DESC;
-- leian kõik tehingud, mis on ilma kaupluse asukohata, rühmitan müügikanali järgi ja järjestan tehingute arvu järgi kahanevalt