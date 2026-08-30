-- Asendan NULL nimed (tegelik vajadus puudub)
UPDATE customers_test
SET first_name = 'Tundmatu'
WHERE first_name IS NULL OR first_name = '';

-- Ühtlustan linnanimed INITCAP + TRIM abil (parandab 42 vale kujuga linnanime)
UPDATE customers_test
SET city = INITCAP(TRIM(city))
WHERE city != INITCAP(TRIM(city));

-- Kontrollin tulemust
SELECT city, COUNT(*) AS arv
FROM customers_test
GROUP BY city ORDER BY city;

-- Standardiseerin e-mailid väiketähtedeks
UPDATE customers_test
SET email = LOWER(TRIM(email))
WHERE email != LOWER(TRIM(email));

-- telefoni suunakoodi standardiseerimine -> +372
UPDATE customers_test
SET phone=
    CASE
        WHEN phone LIKE '+372%' THEN phone
        WHEN phone LIKE '372%' THEN '+' || phone
        WHEN LENGTH(phone) = 7 THEN '+372' || phone
        ELSE phone
    END
WHERE phone IS NOT NULL;


