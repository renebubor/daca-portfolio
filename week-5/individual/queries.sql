--KAART A - CEO Dashboard
--kontrollpäring
--aasta ja kuude lõikes tulu leidmine
SELECT DATE_TRUNC('month', sale_date) AS kuu,
    SUM(total_price) AS tulu
FROM sales
GROUP BY kuu
ORDER BY kuu;
--KAART B - Marketing Dashboard
--kontrollpäring
-- müügikanalite lõikes klientide arvu ja kogutulu leidmine
SELECT s.channel,
    COUNT(DISTINCT s.customer_id) AS kliendid,
    SUM(s.total_price) AS tulu
FROM sales s
GROUP BY s.channel
ORDER BY tulu DESC;
--KAART C - Operations Dashboard
--kontrollpäringud
--poe asukohalõikes kogutulu ja tehingute arvu leidmine
SELECT store_location,
    SUM(total_price) AS tulu,
    COUNT(*) AS tehinguid
FROM sales
GROUP BY store_location
ORDER BY tulu DESC;
--kategooriate lõikes varude koguse leidmine
SELECT p.category,
    SUM(i.quantity_available) AS kogus
FROM inventory i
    JOIN products p ON i.product_id = p.product_id
GROUP BY p.category
ORDER BY kogus DESC;