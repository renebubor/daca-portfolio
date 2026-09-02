--ROLL C: Müümata toodete ja inventuuri analüüs
--1. Leian tooted, mida pole kunagi müüdud:
-- LEFT JOIN: kõik tooted, ka need mis pole müüdud   
SELECT p.product_name,
    p.category,
    p.subcategory,
    p.retail_price,
    s.sale_id
FROM products p
    LEFT JOIN sales s ON p.product_id = s.product_id
WHERE s.sale_id IS NULL;
-- Kui sale_id on NULL, siis toodet pole kunagi müüdud!
--2. Loendan müümata tooted kokku:
SELECT COUNT(*) AS müümata_tooteid
FROM products p
    LEFT JOIN sales s ON p.product_id = s.product_id
WHERE s.sale_id IS NULL;
-- kokku sai 12 kirjet
--3. Leian enim müüdud tooted:
SELECT p.product_name,
    p.category,
    p.subcategory,
    COUNT(s.sale_id) AS müüdud_kordi,
    SUM(s.total_price) AS kogumüük
FROM products p
    INNER JOIN sales s ON p.product_id = s.product_id
GROUP BY p.product_id,
    p.product_name,
    p.category,
    p.subcategory
ORDER BY kogumüük DESC
LIMIT 10;
--4. Analüüsin kategooriate kaupa:
SELECT p.category,
    COUNT(DISTINCT p.product_id) AS tooteid,
    COUNT(s.sale_id) AS müüke,
    SUM(s.total_price) AS kogumüük
FROM products p
    LEFT JOIN sales s ON p.product_id = s.product_id
GROUP BY p.category
ORDER BY kogumüük DESC;
--5. Ühendan inventuuriga — millised tooted on laos?
SELECT p.product_name,
    p.category,
    i.location,
    i.quantity_available,
    i.reorder_point,
    CASE
        WHEN i.quantity_available <= i.reorder_point THEN 'TELLI JUURDE'
        ELSE 'OK'
    END AS staatus
FROM products p
    LEFT JOIN inventory i ON p.product_id = i.product_id
ORDER BY i.quantity_available ASC;
-----
--Ühendan kolm tabelit: leian tooted, mis on laos, aga pole kunagi müüdud — topelt kahju (laoseis + müümata)
SELECT p.product_name,
    p.category,
    p.retail_price,
    i.quantity_available,
    (p.retail_price * i.quantity_available) AS kinni_olev_raha
FROM products p
    LEFT JOIN sales s ON p.product_id = s.product_id
    LEFT JOIN inventory i ON p.product_id = i.product_id
WHERE s.sale_id IS NULL
    AND i.quantity_available > 0
ORDER BY kinni_olev_raha DESC;
--päring annab vastuseks, et andmed puuduvad