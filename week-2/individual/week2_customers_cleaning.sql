--ROLL: Kliendiandmete puhastaja (Customer Data Cleaner)
--Ülesanne: Leida duplikaatsed e-mailid, puuduvad nimed ja ebajärjekindlad linnanimed customers tabelis. Luua test koopia, puhastada ja dokumenteerida.
--Sisend: Tabel: customers (Supabase)
--Väljund:Puhastamisraport (duplikaadid leitud, NULL-id leitud, formaadivead, soovitused) + SQL skript
--1.Testi koopia loomine
CREATE TABLE customers_test AS
SELECT *
FROM customers;
--ridade arvu kontroll
SELECT COUNT(*) AS ridade_arv
FROM customers_test;
SELECT COUNT(*) AS ridade_arv
FROM customers;
--mõlema päringu tulemus 3 150 rida, seega on identsed
--2.Leida duplikaatsed e-mailid
SELECT email,
    COUNT(*) AS koopiate_arv
FROM customers_test
GROUP BY email
HAVING COUNT(*) > 1
ORDER BY koopiate_arv DESC;
--antud päring annab lisaks koopiatele read, millel puudub e-maili aadress (380 vastet)
--lisan päringusse kirje, mis välistab NULL väärtused ja kirje mis summeerib ainulaatsete emailide arvu
SELECT COUNT(DISTINCT(email)) AS duplikaatsed_emailid
FROM(
        SELECT email,
            COUNT(*) AS koopiate_arv
        FROM customers_test
        WHERE email IS NOT NULL
        GROUP BY email
        HAVING COUNT(*) > 1
    );
/*Kui tühjad väljad välistada siis jääb 128 e-maili, millel on lisaks 130 duplikaati. (e-maile ja nende duplikaate on kokku 258 kirjet). 
 kustutada tuleb 130 duplikaati.*/
--eemaldamist vajavate e-mail ridade päring
SELECT SUM(koopiate_arv - 1) AS eemaldatavaid_ridu
FROM (
        SELECT email,
            COUNT(*) AS koopiate_arv
        FROM customers_test
        WHERE email IS NOT NULL
        GROUP BY email
        HAVING COUNT(*) > 1
    );
-- Eemaldame e-maili duplikaadid
-- Alles jääb väikseima customer_id-ga rida
DELETE FROM customers_test
WHERE customer_id IN (
        SELECT customer_id
        FROM (
                SELECT customer_id,
                    ROW_NUMBER() OVER (
                        PARTITION BY email
                        ORDER BY customer_id
                    ) AS rownumber
                FROM customers_test
                WHERE email IS NOT NULL
            ) AS duplikaadid
        WHERE rownumber > 1
    );
--3. Leian puuduvad nimed
SELECT COUNT(*) FILTER (
        WHERE first_name IS NULL
            OR first_name = ''
    ) AS null_eesnimi,
    COUNT(*) FILTER (
        WHERE last_name IS NULL
            OR last_name = ''
    ) AS null_perenimi
FROM customers_test;
--Tulemus 0 NULL eesnime, 0 NULL perenime
--4.Kontrollida linnade nimekujusid — kas on ebajärjekindlusi?
SELECT count(city) AS linnad_erikuju
FROM (
        SELECT city,
            COUNT(*) AS arv
        FROM customers_test
        GROUP BY city
        ORDER BY city
    );
--Erinevaid nimekujusid on 54 nimetusega
SELECT count(distinct initcap(trim(city))) AS linnad_tegelik_arv
FROM customers_test;
--Erinevaid linnu on kokku 12
--Linnanimede normaliseerimine
UPDATE customers_test
SET city = INITCAP(TRIM(LOWER(city)))
WHERE city IS NOT NULL;
--5.Kontrollida kontaktandmeid — puuduvad telefoninumbrid ja e-mailid:
SELECT COUNT(*) FILTER (
        WHERE phone IS NULL
            OR phone = ''
    ) AS null_telefon,
    COUNT(*) FILTER (
        WHERE email IS NULL
            OR email = ''
    ) AS null_email
FROM customers_test;
--Tulemus 0 NULL telefon, 380 NULL email
-----------
--andmete puhastamine
-- Asendan NULL nimed (tegelik vajadus puudub)
UPDATE customers_test
SET first_name = 'Tundmatu'
WHERE first_name IS NULL
    OR first_name = '';
-- Ühtlustan linnanimed INITCAP + TRIM abil (parandab 42 vale kujuga linnanime)
UPDATE customers_test
SET city = INITCAP(TRIM(city))
WHERE city != INITCAP(TRIM(city));
-- Standardiseerin e-mailid väiketähtedeks
UPDATE customers_test
SET email = LOWER(TRIM(email))
WHERE email != LOWER(TRIM(email));
-- Kontrollin tulemust
SELECT city,
    COUNT(*) AS arv
FROM customers_test
GROUP BY city
ORDER BY city;
-- Lisanäide: standardiseerin telefoninumbrid
SELECT phone,
    CASE
        WHEN phone LIKE '+372%' THEN phone
        WHEN phone LIKE '372%' THEN '+' || phone
        WHEN LENGTH(phone) = 7 THEN '+372' || phone
        ELSE phone
    END AS standardne_telefon
FROM customers_test
WHERE phone IS NOT NULL
LIMIT 10;
-----
--omapoolne lisauurimine
-- Lojaalsustasemete NULL arv
SELECT COUNT(*) FILTER (
        WHERE loyalty_tier IS NULL
            OR TRIM(loyalty_tier) = ''
    ) AS null_loyalty_tier
FROM customers_test;
-- kokku 1260 puuduvat taset
--duplikaatide tabel kõrvutatuna emailide alusel, et saaks hinnata millised read on tõelised duplikaadid
SELECT *
FROM customers_test
WHERE email IN (
        SELECT email
        FROM customers_test
        WHERE email IS NOT NULL
        GROUP BY email
        HAVING COUNT(*) > 1
    )
ORDER BY email;