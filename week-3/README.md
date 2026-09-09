# Nädal 3 — SQL JOIN-id

> **DACA — Andmeanalüütiku Karjäärikiirendi**
> UrbanStyle'i erinevates tabelites olevate andmete ühendamine ja äriküsimustele vastamine SQL JOIN-ide abil.

## Nädala eesmärk

Nädal 3 eesmärk oli õppida ühendama erinevates tabelites paiknevaid andmeid ning koostama SQL-päringuid, mis annavad üksikute tabelite asemel terviklikuma ülevaate.

UrbanStyle'i andmebaasis paiknevad kliendi-, müügi- ja tooteandmed eraldi tabelites:

* `customers` — kliendi nimi, e-post, linn ja muud kliendiandmed;
* `sales` — müügitehingud, kuupäevad, kogused ja summad;
* `products` — toodete nimed, kategooriad ja hinnad;
* `inventory` — toodete laoseisud.

JOIN-ide abil saab need andmed omavahel siduda ning vastata näiteks küsimustele:

* Kes ostis?
* Mida klient ostis?
* Millisest linnast klient pärineb?
* Millised kliendid pole kunagi ostnud?
* Milliseid tooteid pole kunagi müüdud?
* Millised tootekategooriad müüvad erinevates linnades kõige rohkem?
* millised on toodete laoseisud?

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
    │
    │ product_id
    ▼
inventory
```
`sales` tabel seob müügitehingu kliendi ja tootega ning `inventory` võimaldab lisada analüüsi toodete laoseisu.

Selline tabelite ülesehitus võimaldab hoida erinevat tüüpi andmed eraldi, kuid JOIN-ide abil saab need analüüsi jaoks uuesti tervikuks ühendada.

---

## Õpitud SQL käsud ja konstruktsioonid

Week 3 jooksul õppisin kasutama SQL JOIN-e ning kombineerima neid varasematel nädalatel õpitud käskude ja funktsioonidega.

| SQL käsk / konstruktsioon | Eesmärk |
|---|---|
| `INNER JOIN` | Mõlemas tabelis sobivate kirjete ühendamine |
| `LEFT JOIN` | Kõigi vasaku tabeli kirjete säilitamine |
| `RIGHT JOIN` | Kõigi parema tabeli kirjete säilitamine |
| `ON` | Tabelite ühendamise tingimuse määramine |
| `AS` | Tabelite ja veergude aliased |
| `WHERE ... IS NULL` | Teises tabelis vasteta kirjete leidmine |
| `GROUP BY` | Ühendatud andmete grupeerimine |
| `COUNT()` | Kirjete või müükide loendamine |
| `SUM()` | Müügikoguste ja summade agregeerimine |
| `ORDER BY` | Tulemuste järjestamine |
| `LIMIT` | Tulemuste arvu piiramine |

---

## INNER JOIN

`INNER JOIN` võimaldab ühendada erinevate tabelite read ühise võtme alusel.

Tulemusse jäävad ainult need read, millel on mõlemas ühendatavas tabelis vastav kirje.

Näiteks saab `sales` ja `products` tabeli ühendamisel siduda müügitehingu konkreetse tootega ning analüüsida müüdud koguseid toodete ja kategooriate lõikes.

---

## LEFT JOIN

`LEFT JOIN` säilitab kõik vasakpoolse tabeli read ka siis, kui parempoolses tabelis vastavat kirjet ei ole.

Oluline õpitud muster oli:

`LEFT JOIN + WHERE ... IS NULL`

Selle abil saab leida kirjeid, millele teises tabelis vastet ei ole.

Näiteks saab selle meetodiga tuvastada tooted, mida ei ole kunagi müüdud.

---

## Mitme tabeli ühendamine

Week 3 jooksul õppisin ühendama ka rohkem kui kahte tabelit.

Minu individuaalses analüüsis olid olulised eelkõige:

```text
sales
  │
  ├──── products
  │
  └──── inventory
```
Nende tabelite ühendamine võimaldas analüüsida müüki koos tooteinfo ja laoseisuga.

See annab üksikute tabelite vaatamisest oluliselt terviklikuma pildi ning võimaldab siduda omavahel näiteks:

```text
TOODE + MÜÜK + LAOSEIS
```
## Minu individuaalne töö — Roll C: tooted ja inventuur

Minu Week 3 individuaalse töö fookus oli UrbanStyle'i **toodete, müügi ja inventuuri analüüs**.

Analüüsi aluseks olid peamiselt:

- `products`;
- `sales`;
- `inventory`.

JOIN-ide ja agregeerimise abil uurisin toodete müüki ning laoseisu erinevatest vaatenurkadest.

Analüüsi tulemused hõlmasid:

- enim müüdud toodete leidmist;
- müügi analüüsimist tootekategooriate kaupa;
- müümata toodete tuvastamist;
- laoandmete ja toodete ühendamist;
- toodete laoseisust ülevaate koostamist.

Kõik analüüsis kasutatud SQL-päringud koos kommentaaridega asuvad failis:

[`individual/week3_roll_c_tooted_inventuur.sql`](individual/week3_roll_c_tooted_inventuur.sql)

---

## Analüüsi tulemused

SQL-päringute tulemused on dokumenteeritud eraldi ekraanipiltidena.

### Enim müüdud tooted

[`individual/enimmüüdud_tooted.png`](individual/enimmüüdud_tooted.png)

Ülevaade toodetest, mida müüdi analüüsitavas andmestikus kõige rohkem.

### Müük kategooriate kaupa

[`individual/müük_kategooriate_kaupa.png`](individual/müük_kategooriate_kaupa.png)

Ülevaade müügitulemustest erinevate tootekategooriate lõikes.

### Müümata tooted

[`individual/müümata_tooted.png`](individual/müümata_tooted.png)

Analüüs toodetest, millele müügiandmetes vastavat tehingut ei leitud.

### Lao väljavõte

[`individual/lao_väljavõte.png`](individual/lao_väljavõte.png)

Ülevaade toodete laoandmetest ja laoseisust.

---

## Mida õppisin

Week 3 jooksul õppisin:

* mõistma relatsioonilise andmebaasi tabelite vahelisi seoseid;
* eristama Primary Key ja Foreign Key rolle;
* ühendama tabeleid ühiste võtmete kaudu;
* kasutama `INNER JOIN`-i sobivate kirjete ühendamiseks;
* kasutama `LEFT JOIN`-i kõigi vasaku tabeli kirjete säilitamiseks;
* kasutama `LEFT JOIN + WHERE IS NULL` mustrit vasteta kirjete leidmiseks;
* mõistma `RIGHT JOIN` tööpõhimõtet;
* kasutama tabelite aliaseid SQL-päringute loetavuse parandamiseks;
* ühendama rohkem kui kahte tabelit;
* kombineerima JOIN-e `GROUP BY`, `COUNT()` ja `SUM()` funktsioonidega;
* ühendama müügi-, toote- ja laoandmeid;
* analüüsima toodete müüki ja laoseisu ühe tervikuna;
* tõlgendama JOIN-päringute tulemusi ärilisest vaatenurgast.

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
* suunata turunduskampaaniaid kliendi asukoha ja ostueelistuste järgi;
* hinnata toodete laoseisu;
* tuvastada võimalikke aeglaselt liikuvaid varusid;
* toetada varude planeerimise ja ostujuhtimise otsuseid.

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
    └── week3.md
```

### Individuaalne töö

[`individual/week3_roll_c_tooted_inventuur.sql`](individual/week3_roll_c_tooted_inventuur.sql)  
Minu Roll C SQL-päringud toodete, müügi ja inventuuri analüüsimiseks.

Analüüsi tulemused:

- [`enimmüüdud_tooted.png`](individual/enimmüüdud_tooted.png)
- [`müük_kategooriate_kaupa.png`](individual/müük_kategooriate_kaupa.png)
- [`müümata_tooted.png`](individual/müümata_tooted.png)
- [`lao_väljavõte.png`](individual/lao_väljavõte.png)

### Meeskonnatöö

Meeskonnatöö käigus ühendati erinevate rollide analüüsid terviklikumaks UrbanStyle'i andmeanalüüsiks.

Minu panus meeskonnatöösse oli **Roll C — toodete, müügi ja inventuuri analüüs**.

[`team/week3.md`](team/week3.md)  
Week 3 meeskonnatöö kokkuvõte.

**Meeskonna ühine töö:**
[(https://github.com/laura-johanson/urbanstyle-marketing-data/tree/c6ffae8ae752bd09d54eefcaed7e21318712ded9/week3)]

---

## Kokkuvõte

Week 3 jooksul õppisin SQL JOIN-ide abil ühendama erinevates tabelites paiknevaid andmeid.

Minu Roll C analüüs keskendus `products`, `sales` ja `inventory` tabelitele. Nende ühendamise abil sain analüüsida enim müüdud tooteid, müüki kategooriate kaupa, müümata tooteid ning toodete laoseisu.

Week 3 oli oluline samm üksikute tabelite analüüsimiselt seotud andmete põhjal terviklikuma ärianalüüsi koostamise suunas.

