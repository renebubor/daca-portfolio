--web_logs andmete import ja kontroll
SELECT COUNT(*)
FROM web_logs --50 000 kirjet
    --ROLL D: Turunduskampaaniate ROI
    --1. Turunduskanalite koondandmed. Ühendan müügi, kliendid ja veebilogi kanalitega:
SELECT w.source AS turunduskanal,
    COUNT(DISTINCT c.customer_id) AS kliente,
    COUNT(DISTINCT o.sale_id) AS tellimusi,
    SUM(o.total_price) AS kogukäive,
    ROUND(AVG(o.total_price), 2) AS keskmine_tellimus
FROM sales o
    JOIN customers c ON o.customer_id = c.customer_id
    LEFT JOIN web_logs w ON c.customer_id = w.customer_id
GROUP BY w.source
ORDER BY kogukäive DESC;
--2. Kanali efektiivsus CTE-ga
WITH turunduskanali_myyk AS (
    -- CTE 1: kanali kogumüük 
    SELECT w.source AS turunduskanal,
        COUNT(DISTINCT o.sale_id) AS tellimusi,
        SUM(o.total_price) AS kogukäive
    FROM sales o
        JOIN customers c ON o.customer_id = c.customer_id
        LEFT JOIN web_logs w ON c.customer_id = w.customer_id
    GROUP BY w.source
    HAVING COUNT(DISTINCT o.sale_id) > 500 --rohkem kui 500 tellimust
),
unikaalsed_kliendid AS (
    -- CTE 2: kanali unikaalsete klientide arv
    SELECT w.source AS turunduskanal,
        COUNT(DISTINCT c.customer_id) AS kliente
    FROM customers c
        LEFT JOIN web_logs w ON c.customer_id = w.customer_id
    GROUP BY w.source
)
SELECT tm.turunduskanal,
    uk.kliente,
    tm.tellimusi,
    tm.kogukäive,
    ROUND(tm.kogukäive / NULLIF(uk.kliente, 0), 2) AS müük_per_klient
FROM turunduskanali_myyk tm
    JOIN unikaalsed_kliendid uk ON tm.turunduskanal = uk.turunduskanal
ORDER BY müük_per_klient DESC;
--3.Kampaaniate kuised trendid
SELECT w.source AS turunduskanal,
    DATE_TRUNC('month', o.sale_date) AS kuu,
    SUM(o.total_price) AS kogukäive,
    COUNT(DISTINCT o.customer_id) AS unikaalseid_kliente,
    COUNT(DISTINCT o.sale_id) AS tellimusi
FROM sales o
    JOIN customers c ON o.customer_id = c.customer_id
    LEFT JOIN web_logs w ON c.customer_id = w.customer_id
GROUP BY w.source,
    DATE_TRUNC('month', o.sale_date)
HAVING COUNT(DISTINCT o.sale_id) > 20 --vähem kui 20 tellimust välistatud
ORDER BY kuu,
    kogukäive DESC;
--4.Esitlus juhatusele:
/* Meie kõige efektiivsem kanal on kogukäibe järgi google_organic, mille keskmine tellimus on 286 €, toob z klienti kuus.*/
---
select *
from sales
limit 1;
WITH turunduskanali_myyk AS (
    -- CTE 1: kanali kogumüük 
    SELECT w.source AS turunduskanal,
        COUNT(DISTINCT o.sale_id) AS tellimusi,
        SUM(o.total_price) AS kogukäive,
        LAG(SUM(o.total_price)) OVER (
            PARTITION BY w.source
            ORDER BY DATE_TRUNC('month', o.sale_date)
        ) AS eelmise_kuu_käive
    FROM sales o
        JOIN customers c ON o.customer_id = c.customer_id
        LEFT JOIN web_logs w ON c.customer_id = w.customer_id
    GROUP BY w.source,
        o.sale_date
    HAVING COUNT(DISTINCT o.sale_id) > 10 --rohkem kui 10 tellimust
),
unikaalsed_kliendid AS (
    -- CTE 2: kanali unikaalsete klientide arv
    SELECT w.source AS turunduskanal,
        COUNT(DISTINCT c.customer_id) AS kliente
    FROM customers c
        LEFT JOIN web_logs w ON c.customer_id = w.customer_id
    GROUP BY w.source
)
SELECT tm.turunduskanal,
    uk.kliente,
    tm.tellimusi,
    tm.kogukäive,
    tm.eelmise_kuu_käive,
    ROUND(tm.kogukäive / NULLIF(uk.kliente, 0), 2) AS müük_per_klient
FROM turunduskanali_myyk tm
    JOIN unikaalsed_kliendid uk ON tm.turunduskanal = uk.turunduskanal
ORDER BY müük_per_klient DESC;