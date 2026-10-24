-- Roll D: müügi kirjeldav analüüs turunduskanalite lõikes.
-- Päringud on lugemiseks. Kampaaniakulusid ei kasutata; ROI-d ei arvutata.

-- 1. Veebilogi kirjete arv.
SELECT COUNT(*) AS veebikylastusi
FROM web_logs;

-- 2. Kontroll: ühel kliendil võib olla mitu veebikülastust.
-- Müügi otseühendus nende ridadega kordaks samu müügisummasid.
-- COUNT(DISTINCT sale_id) ei parandaks sellise JOIN-i SUM(total_price) tulemust.
SELECT customer_id,
    COUNT(*) AS kylastusi
FROM web_logs
WHERE customer_id IS NOT NULL
GROUP BY customer_id
HAVING COUNT(*) > 1
ORDER BY kylastusi DESC;

-- 3. Valime kliendile ühe kanali: esimese teadaoleva allika külastusaja järgi.
-- Sama külastusaja korral otsustab source tähestikuline järjekord.
-- See on kirjeldav omistamisreegel kogu olemasoleva veebiajaloo põhjal,
-- mitte tõend, et külastus toimus enne ostu või põhjustas ostu.
WITH kliendi_kanal AS (
    SELECT customer_id,
        source AS turunduskanal
    FROM (
            SELECT customer_id,
                source,
                ROW_NUMBER() OVER (
                    PARTITION BY customer_id
                    ORDER BY visit_date ASC NULLS LAST, source ASC
                ) AS rn
            FROM web_logs
            WHERE source IS NOT NULL
                AND customer_id IS NOT NULL
        ) AS jarjestatud_kylastused
    WHERE rn = 1
)
SELECT kk.turunduskanal,
    COUNT(DISTINCT s.customer_id) AS kliente,
    COUNT(s.sale_id) AS myygiridu,
    SUM(s.total_price) AS kogukaive,
    ROUND(AVG(s.total_price), 2) AS keskmine_myygirea_summa,
    ROUND(
        SUM(s.total_price) / NULLIF(COUNT(DISTINCT s.customer_id), 0),
        2
    ) AS myyk_per_klient
FROM sales s
    LEFT JOIN kliendi_kanal kk ON s.customer_id = kk.customer_id
GROUP BY kk.turunduskanal
ORDER BY kogukaive DESC;

-- NULL kanal tähendab, et müügireale ei leitud kliendi kaudu sobivat allikat.
-- See grupp säilib LEFT JOIN-iga ja kuulub samuti kogukäibe kontrolli.
-- myygiridu loendab sale_id väärtusi; see ei loenda invoice_id järgi arveid.
-- myyk_per_klient on käive ühe ostnud kliendi kohta, mitte keskmine tellimus.
-- Kanalite käivete summa peab kattuma alloleva lähteandmete kogukäibega.
SELECT COUNT(sale_id) AS myygiridu,
    SUM(total_price) AS kogukaive
FROM sales;
