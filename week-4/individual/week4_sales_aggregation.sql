--ROLL:Müügi koondandmed (Sales Aggregation)
--1.Müük kuude kaupa
SELECT DATE_TRUNC('month', sale_date) AS kuu,
    COUNT(sale_id) AS tellimuste_arv,
    SUM(total_price) AS kogukäive,
    ROUND(AVG(total_price), 2) AS keskmine_tellimus
FROM sales
WHERE sale_date >= '2024-01-01'
GROUP BY DATE_TRUNC('month', sale_date)
ORDER BY kuu;
--2.Müük kategooriate kaupa
SELECT p.category,
    COUNT(DISTINCT p.product_id) AS toodete_arv,
    SUM(s.total_price) AS kogumüük,
    ROUND(AVG(s.total_price), 2) AS keskmine_hind
FROM sales s
    JOIN products p ON s.product_id = p.product_id
GROUP BY p.category
HAVING SUM(s.total_price) > 400000
ORDER BY kogumüük DESC;
--3.Kuised trendid CTE-ga
WITH kuu_myyk AS (
    SELECT DATE_TRUNC('month', sale_date) AS kuu,
        SUM(total_price) AS käive
    FROM sales
    WHERE sale_date >= '2024-01-01'
    GROUP BY DATE_TRUNC('month', sale_date)
)
SELECT kuu,
    käive,
    LAG(käive) OVER (
        ORDER BY kuu
    ) AS eelmine_kuu,
    käive - LAG(käive) OVER (
        ORDER BY kuu
    ) AS muutus
FROM kuu_myyk
ORDER BY kuu;
/* Suurima käibega kuu oli detsember 2024, kui käive ületas 170 tuh.eurot. Väikseima käibega kuu oli mai 2026, kui käive oli ainult 78 eurot. Juhatusele peaks mainima, et 2024 aasta on korraliku kasvuga aasta. 2025 aasta algab paremini, kuid alates märtsist kuni novembrini andmed puuduvad täielikult. Detsembri ja 2026 aasta käive on kukkunud tohutult. Tuleks kontrollida kuhu on kadunud 2025 andmed ja 2026 andmete õigsust */
--Lisan eelnevale väljavõttele protsentuaalse muutuse veeru
WITH kuu_myyk AS (
    SELECT DATE_TRUNC('month', sale_date) AS kuu,
        SUM(total_price) AS käive
    FROM sales
    WHERE sale_date >= '2024-01-01'
    GROUP BY DATE_TRUNC('month', sale_date)
)
SELECT kuu,
    käive,
    LAG(käive) OVER (
        ORDER BY kuu
    ) AS eelmine_kuu,
    käive - LAG(käive) OVER (
        ORDER BY kuu
    ) AS muutus,
    ROUND(
        (
            käive - LAG(käive) OVER (
                ORDER BY kuu
            )
        ) / LAG(käive) OVER (
            ORDER BY kuu
        ) * 100,
        1
    ) AS kasvu_protsent --Lisatud veerg
FROM kuu_myyk
ORDER BY kuu;