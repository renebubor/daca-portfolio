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
WITH kliendi_kanal AS (
    SELECT customer_id,
        source AS turunduskanal
    FROM (
            SELECT customer_id,
                source,
                ROW_NUMBER() OVER (
                    PARTITION BY customer_id
                    ORDER BY visit_date
                ) AS rn
            FROM web_logs
            WHERE source IS NOT NULL
        ) x
    WHERE rn = 1
)
SELECT kk.turunduskanal,
    COUNT(DISTINCT s.customer_id) AS kliente,
    COUNT(s.sale_id) AS tellimusi,
    SUM(s.total_price) AS kogukäive,
    ROUND(
        SUM(s.total_price) / NULLIF(COUNT(DISTINCT s.customer_id), 0),
        2
    ) AS müük_per_klient
FROM sales s
    LEFT JOIN kliendi_kanal kk ON s.customer_id = kk.customer_id
GROUP BY kk.turunduskanal
ORDER BY kogukäive DESC;
--4.Esitlus juhatusele:
/* Meie kõige efektiivsem kanal on kogukäibe järgi google_organic, mille keskmine tellimus on 1024,7 €.*/