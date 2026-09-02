# Nädal 3 — SQL JOIN-id

> **DACA — Andmeanalüütiku Karjäärikiirendi**
> UrbanStyle'i erinevates tabelites olevate andmete ühendamine ja äriküsimustele vastamine SQL JOIN-ide abil.

## Nädala eesmärk

Nädal 3 eesmärk oli õppida ühendama erinevates tabelites paiknevaid andmeid ning koostama SQL-päringuid, mis annavad üksikute tabelite asemel terviklikuma ülevaate.

UrbanStyle'i andmebaasis paiknevad kliendi-, müügi- ja tooteandmed eraldi tabelites:

* `customers` — kliendi nimi, e-post, linn ja muud kliendiandmed;
* `sales` — müügitehingud, kuupäevad, kogused ja summad;
* `products` — toodete nimed, kategooriad ja hinnad.

JOIN-ide abil saab need andmed omavahel siduda ning vastata näiteks küsimustele:

* Kes ostis?
* Mida klient ostis?
* Millisest linnast klient pärineb?
* Millised kliendid pole kunagi ostnud?
* Milliseid tooteid pole kunagi müüdud?
* Millised tootekategooriad müüvad erinevates linnades kõige rohkem?

---

## Kasutatud tööriistad

| Tööriist                  | Kasutus                                      |
| ------------------------- | -------------------------------------------- |
| **Supabase / PostgreSQL** | UrbanStyle'i andmebaas                       |
| **Visual Studio Code**    | SQL-failide kirjutamine, haldamine ja analüüs|
| **Git**                   | Muudatuste lokaalne versioonihaldus          |
| **GitHub**                | Projekti ja portfoolio säilitamine           |

---

## Tabelite vahelised seosed

JOIN-ide kasutamiseks õppisin mõistma tabelite vahelisi seoseid ning **Primary Key (PK)** ja **Foreign Key (FK)** tähendust.

UrbanStyle'i andmebaasis seovad tabeleid peamiselt:

```text
customers
    │
    │ customer_id
    ▼
  sales
    │
    │ product_id
    ▼
 products
```

Näiteks:

* `customers.customer_id` identifitseerib kliendi;
* `sales.customer_id` viitab vastavale kliendile;
* `products.product_id` identifitseerib toote;
* `sales.product_id` viitab müüdud tootele.

Seega toimib `sales` tabel olulise ühenduspunktina kliendi- ja tooteandmete vahel.

---

## INNER JOIN

Õppisin kasutama `INNER JOIN`-i olukorras, kus soovin tulemusse ainult neid ridu, millel leidub mõlemas tabelis vastav kirje.

Näiteks:

```sql
SELECT
    c.first_name,
    c.last_name,
    c.city,
    s.sale_date,
    s.total_price
FROM sales s
INNER JOIN customers c
    ON s.customer_id = c.customer_id;
```

Sellise päringu puhul kuvatakse ainult kliendid, kellel on vastav müügitehing.

Kui kliendil pole ühtegi müüki, ei ilmu ta `INNER JOIN` tulemusse.

---

## LEFT JOIN

`LEFT JOIN` võimaldab säilitada kõik vasakpoolse tabeli read ka siis, kui parempoolses tabelis vastavat kirjet ei ole.

Näiteks:

```sql
SELECT
    c.first_name,
    c.last_name,
    s.sale_id
FROM customers c
LEFT JOIN sales s
    ON c.customer_id = s.customer_id;
```

Sellisel juhul kuvatakse kõik kliendid.

Kui kliendil pole ühtegi müüki, on tema müügiandmete väärtuseks `NULL`.

See aitab leida andmetest gruppe, mis tavalise `INNER JOIN` kasutamisel tulemusest välja jääksid.

---

## LEFT JOIN + WHERE IS NULL

Üks olulisemaid Week 3 jooksul õpitud mustreid oli:

```sql
LEFT JOIN ... WHERE ... IS NULL
```

Selle abil saab leida kirjeid, millele teises tabelis vastet ei ole.

Näiteks kliendid, kes pole kunagi ostnud:

```sql
SELECT
    c.first_name,
    c.last_name,
    c.email,
    c.city
FROM customers c
LEFT JOIN sales s
    ON c.customer_id = s.customer_id
WHERE s.sale_id IS NULL;
```

Sama loogikat saab kasutada näiteks:

* klientide leidmiseks, kellel pole oste;
* toodete leidmiseks, mida pole müüdud;
* töötajate leidmiseks, kellel pole projekte;
* muude puuduvate seoste tuvastamiseks.

---

## RIGHT JOIN

Tutvusin ka `RIGHT JOIN`-iga.

`RIGHT JOIN` on sisuliselt `LEFT JOIN`-i peegelpilt — see säilitab kõik parempoolse tabeli read.

Praktikas on sageli lihtsam muuta tabelite järjekorda ning kasutada `LEFT JOIN`-i, mistõttu kasutatakse `RIGHT JOIN`-i analüüsis harvem.

---

## Mitme tabeli ühendamine

Week 3 oluline osa oli õppida ühendama ühes päringus rohkem kui kahte tabelit.

Näiteks:

```sql
SELECT
    c.first_name || ' ' || c.last_name AS klient,
    c.city AS linn,
    s.sale_date AS müügi_kuupäev,
    p.product_name AS toode,
    p.category AS kategooria,
    s.quantity AS kogus,
    s.total_price AS rea_summa
FROM sales s
INNER JOIN customers c
    ON s.customer_id = c.customer_id
INNER JOIN products p
    ON s.product_id = p.product_id;
```

Selline päring ühendab kolm erinevat andmedomeeni:

```text
KLIENT + MÜÜK + TOODE
```

See võimaldab ühe päringuga näha, **kes ostis, mida ostis, millal ostis ja kui suure summa eest**.

---

## Tabelite aliased

Õppisin kasutama tabelite aliaseid, mis muudavad mitme tabeliga päringud oluliselt lühemaks ja loetavamaks.

Näiteks:

```sql
customers → c
sales     → s
products  → p
```

Selle asemel, et kirjutada:

```sql
customers.first_name
sales.total_price
```

saab kasutada:

```sql
c.first_name
s.total_price
```

Mitme JOIN-iga päringutes aitab see paremini jälgida, millisest tabelist iga veerg pärineb.

---

## JOIN-id koos agregeerimisega

JOIN-e saab kombineerida ka varem õpitud SQL-käskudega, näiteks:

* `GROUP BY`;
* `COUNT()`;
* `SUM()`;
* `ORDER BY`;
* `LIMIT`.

Näiteks saab ühendada `sales`, `customers` ja `products` tabelid ning arvutada müüki linnade ja tootekategooriate kaupa:

```sql
SELECT
    c.city AS linn,
    p.category AS kategooria,
    COUNT(s.sale_id) AS müüke,
    SUM(s.total_price) AS kogumüük
FROM sales s
INNER JOIN customers c
    ON s.customer_id = c.customer_id
INNER JOIN products p
    ON s.product_id = p.product_id
GROUP BY c.city, p.category
ORDER BY kogumüük DESC;
```

Selline päring ei ühenda enam lihtsalt tabeleid, vaid aitab vastata konkreetsele äriküsimusele.

---

## Mida õppisin

Week 3 jooksul õppisin:

* mõistma tabelite vahelisi seoseid;
* eristama `Primary Key` ja `Foreign Key` rolle;
* ühendama kahte tabelit `INNER JOIN` abil;
* kasutama `ON` klauslit õige ühendusvälja määramiseks;
* kasutama tabelite aliaseid;
* mõistma `INNER JOIN` ja `LEFT JOIN` erinevust;
* säilitama `LEFT JOIN` abil ka read, millel teises tabelis vastet pole;
* leidma puuduvaid seoseid `LEFT JOIN + WHERE IS NULL` abil;
* mõistma `RIGHT JOIN` tööpõhimõtet;
* ühendama ühes päringus kolme või enamat tabelit;
* kombineerima JOIN-e `GROUP BY`, `COUNT()` ja `SUM()` funktsioonidega;
* valima JOIN-i tüübi vastavalt äriküsimusele;
* liikuma üksikute tabelite analüüsimiselt tervikliku ärilise vaate koostamiseni.

Kõige olulisem õppetund oli, et JOIN ei ole lihtsalt viis tabelite tehniliseks ühendamiseks. **JOIN võimaldab siduda erinevates tabelites olevad andmed üheks tervikuks ja vastata küsimustele, millele ühe tabeli põhjal vastata ei saa.**

---

## JOIN-i valimine

| Äriküsimus                                    | Sobiv lahendus              |
| --------------------------------------------- | --------------------------- |
| Näita kliente, kes on ostnud                  | `INNER JOIN`                |
| Näita kõiki kliente, ka neid, kes pole ostnud | `LEFT JOIN`                 |
| Leia kliendid, kes pole kunagi ostnud         | `LEFT JOIN + WHERE IS NULL` |
| Leia tooted, mida pole kunagi müüdud          | `LEFT JOIN + WHERE IS NULL` |
| Näita klienti, müüki ja toodet koos           | Mitme tabeli `JOIN`         |

See aitas mõista, et JOIN-i tüüp tuleb valida mitte tehnilise eelistuse, vaid selle järgi, **millisele küsimusele soovin andmetest vastust saada**.

---

## Äriline tõlgendus

JOIN-ide kasutamine võimaldas liikuda tehnilisest andmete vaatamisest ärilise analüüsi suunas.

Näiteks saab ühendatud andmete põhjal:

* leida kõige väärtuslikumad kliendid;
* analüüsida klientide ostukäitumist;
* võrrelda tootekategooriate müüki linnade lõikes;
* tuvastada registreerunud kliendid, kes pole veel ostnud;
* leida tooted, mida pole kunagi müüdud;
* suunata turunduskampaaniaid kliendi asukoha ja ostueelistuste järgi.

See näitas, miks relatsioonilises andmebaasis hoitakse infot erinevates tabelites, kuid analüüsi tegemisel tuleb need andmed sageli uuesti omavahel siduda.

---

## Week 3 failid

```text
week-3/
│
├── README.md
│
├── individual/
│   ├── week3_roll_c_tooted_inventuur.sql
|   ├── enimmüüdud_tooted.png
|   ├── lao_väljavõte.png
|   ├── müük_kategooriate_kaupa.png
|   └── müümata_tooted.png
│
└── team/
    └── week3_team_summary.md
```

### Individuaalne töö

[`individual/week3_roll_c_tooted_inventuur.sql`](individual/week3_roll_c_tooted_inventuur.sql)

SQL-päringud koos kommentaaridega, mida kasutasin `INNER JOIN`, `LEFT JOIN` ja mitme tabeli JOIN-ide harjutamiseks ning UrbanStyle'i andmete analüüsimiseks.

### Meeskonnatöö

Meeskonnatöö käigus kasutati JOIN-e UrbanStyle'i erinevates tabelites olevate andmete ühendamiseks ning tulemuste põhjal äriliste järelduste tegemiseks.

Individuaalse töö käigus õpitud JOIN-ide kasutamine oli sisendiks meeskonna ühisele analüüsile.

[`team/week3_team_summary.md`](team/week3_team_summary.md)

Kokkuvõte Week 3 meeskonnatööst ning meeskonna analüüsi peamistest tulemustest.

**Meeskonna ühine töö:**
link siia...

---

## Kokkuvõte

Week 3 jooksul õppisin ühendama SQL JOIN-ide abil erinevates tabelites paiknevaid andmeid.

`INNER JOIN` võimaldas leida omavahel sobivad kirjed, `LEFT JOIN` säilitada ka vasteta kirjed ning `LEFT JOIN + WHERE IS NULL` tuvastada näiteks kliente, kes pole kunagi ostnud, või tooteid, mida pole müüdud.

Mitme tabeli ühendamise abil sain siduda kliendi-, müügi- ja tooteandmed üheks tervikuks ning kasutada tulemusi konkreetsetele äriküsimustele vastamiseks.

Week 3 oli oluline samm üksikute SQL-päringute kirjutamiselt **seotud andmete põhjal tervikliku ärianalüüsi koostamise suunas**.

