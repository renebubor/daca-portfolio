# Nädal 4 — SQL agregatsioon

> **DACA — Andmeanalüütiku Karjäärikiirendi**  
> UrbanStyle'i müügi- ja turundusandmete koondanalüüs SQL agregatsioonide abil.

## Nädala eesmärk

Nädal 4 eesmärk oli liikuda üksikute kirjete analüüsimiselt koondnäitajate ja äriliste trendide leidmise juurde.

Fookuses olid SQL agregatsioonid ning nende kasutamine juhtimisotsuseid toetavate raportite koostamiseks.

Nädala jooksul õppisin kasutama:

- agregaatfunktsioone `COUNT()`, `SUM()`, `AVG()`, `MIN()` ja `MAX()`;
- `GROUP BY` klauslit andmete grupeerimiseks;
- `HAVING` klauslit grupeeritud tulemuste filtreerimiseks;
- CTE-sid (`WITH`) keerukamate päringute struktureerimiseks;
- window function'e trendide ja eelmiste perioodide võrdlemiseks;
- `DATE_TRUNC()` funktsiooni ajaperioodide moodustamiseks;
- mitme tabeli andmete ühendamist ja agregeerimist.

Minu Week 4 kodutöö koosnes kahest rollist:

- **Roll A — Müügi koondandmed**
- **Roll D — Turunduskampaaniate efektiivsus**

---

## Kasutatud tööriistad

| Tööriist | Kasutus |
|---|---|
| **Supabase / PostgreSQL** | UrbanStyle'i andmebaas |
| **Visual Studio Code** | SQL-failide kirjutamine ja haldamine |
| **Git** | Muudatuste lokaalne versioonihaldus |
| **GitHub** | Projekti ja portfoolio säilitamine |

---

## Analüüsi ülesehitus

Week 4 jooksul kasutasin erinevaid UrbanStyle'i andmetabeleid kahe analüüsivaldkonna uurimiseks.

```text
                     UrbanStyle
                         │
             ┌───────────┴───────────┐
             │                       │
             ▼                       ▼
        MÜÜGIANALÜÜS           TURUNDUSANALÜÜS
          Roll A                   Roll D
             │                       │
       sales + products      sales + customers
                                     +
                                  web_logs
             │                       │
             └───────────┬───────────┘
                         ▼
                   SQL agregatsioon
                         │
                         ▼
                 Koondnäitajad ja
                    ärijäreldused
```

Eesmärk ei olnud enam vaadata ainult üksikuid tehinguid, vaid koondada andmed sellisele tasemele, mille põhjal saab hinnata müügitrende ja turunduskanalite efektiivsust.

---

## Õpitud SQL käsud ja funktsioonid

| SQL käsk / funktsioon | Eesmärk |
|---|---|
| `GROUP BY` | Andmete grupeerimine |
| `HAVING` | Grupeeritud tulemuste filtreerimine |
| `COUNT()` | Kirjete arvu leidmine |
| `COUNT(DISTINCT ...)` | Unikaalsete väärtuste loendamine |
| `SUM()` | Väärtuste summeerimine |
| `AVG()` | Keskmise väärtuse arvutamine |
| `MIN()` | Väikseima väärtuse leidmine |
| `MAX()` | Suurima väärtuse leidmine |
| `ROUND()` | Arvulise tulemuse ümardamine |
| `DATE_TRUNC()` | Kuupäevade grupeerimine perioodideks |
| `WITH` / CTE | Päringu jagamine loogilisteks vaheetappideks |
| `LAG()` | Eelmise perioodi väärtuse leidmine |
| `OVER()` | Window function'i arvutusakna määramine |
| `PARTITION BY` | Window function'i tulemuste grupeerimine |
| `ORDER BY` | Tulemuste järjestamine |
| `JOIN` | Erinevate tabelite ühendamine |

---

## GROUP BY ja agregaatfunktsioonid

Week 4 üks olulisemaid teemasid oli `GROUP BY`.

Kui varasemates päringutes uurisin sageli üksikuid ridu, siis `GROUP BY` võimaldab koondada suure hulga tehinguid äriliselt tähenduslikeks gruppideks.

Näiteks saab müüki grupeerida:

- kuu järgi;
- tootekategooria järgi;
- turunduskanali järgi.

Grupeeritud andmetele saab rakendada agregaatfunktsioone:

```text
COUNT()  → mitu?
SUM()    → kui palju kokku?
AVG()    → kui suur keskmiselt?
MIN()    → milline oli väikseim?
MAX()    → milline oli suurim?
```

See võimaldab muuta suure hulga tehinguridu juhtimiseks kasutatavateks koondnäitajateks.

---

## WHERE ja HAVING erinevus

Week 4 jooksul õppisin eristama `WHERE` ja `HAVING` kasutamist.

```text
WHERE
  │
  └── filtreerib üksikud read
      ENNE grupeerimist

HAVING
  │
  └── filtreerib grupeeritud tulemused
      PÄRAST grupeerimist
```

`WHERE` sobib näiteks kindla aasta müügitehingute valimiseks.

`HAVING` võimaldab aga pärast grupeerimist kuvada ainult need kategooriad või turunduskanalid, mis vastavad seatud koondtingimusele.

See erinevus on oluline, sest agregaatfunktsioonidel põhinevaid tingimusi ei saa tavaliselt lahendada tavalise `WHERE` klausliga.

---

## CTE — Common Table Expression

Week 4 jooksul õppisin kasutama CTE-sid ehk `WITH` klauslit.

CTE võimaldab jagada keerukama SQL-päringu väiksemateks ja arusaadavamateks etappideks.

Üldine loogika:

```text
Algandmed
    │
    ▼
   CTE
    │
    ▼
Vahearvutus
    │
    ▼
Lõpppäring
    │
    ▼
Analüüsi tulemus
```

CTE-d kasutasin nii müügitrendide kui ka turunduskanalite efektiivsuse analüüsimisel.

See muutis keerukamad päringud loetavamaks ning võimaldas arvutada esmalt vajalikud koondnäitajad ja kasutada neid seejärel lõppanalüüsis.

---

## Window functions

Tutvusin ka window function'itega, mis võimaldavad teha arvutusi ridade vahel ilma tulemusi üheks reaks kokku grupeerimata.

Oluline funktsioon oli:

`LAG()`

Selle abil saab võtta tulemusse eelmise perioodi väärtuse ning võrrelda seda jooksva perioodiga.

Näiteks:

```text
jaanuar   → käive
veebruar  → käive + jaanuari käive
märts     → käive + veebruari käive
...
```

Sellest saab omakorda arvutada:

- absoluutse muutuse;
- kuust-kuusse kasvu;
- kuust-kuusse kasvu protsendi.

See võimaldab lisaks koondnumbritele analüüsida ka trendi suunda.

---

# Roll A — Müügi koondandmed

Minu esimene Week 4 ülesanne oli koostada UrbanStyle'i müügi koondanalüüs.

Analüüsi aluseks olid:

- `sales`;
- `products`.

Eesmärk oli uurida müüki erinevatest vaatenurkadest ning koostada juhtimiseks sobivad koondnäitajad.

Analüüsi käigus uurisin:

- müüki kuude kaupa;
- tellimuste arvu;
- kogukäivet;
- keskmist tellimusväärtust;
- müüki tootekategooriate kaupa;
- kategooriate kogumüüki;
- kuiseid müügitrende;
- kuust-kuusse muutust.

---

## Müügi analüüsi loogika

```text
sales
  │
  ├── müügikuupäev
  ├── tellimused
  ├── kogused
  └── käive
       │
       ├──────── products
       │             │
       │         kategooria
       │
       ▼
 GROUP BY / HAVING
       │
       ▼
 Kuised koondnäitajad
       +
 Kategooriate analüüs
       │
       ▼
      CTE
       │
       ▼
  Müügitrendid
```

Kuupõhise analüüsi jaoks õppisin kasutama `DATE_TRUNC()` funktsiooni, millega saab üksikud müügikuupäevad grupeerida kuudeks.

See võimaldab võrrelda perioode ning leida näiteks parima ja nõrgima müügikuu.

---

# Roll D — Turunduskanalite efektiivsus

Minu teine Week 4 ülesanne oli analüüsida UrbanStyle'i turunduskanalite efektiivsust.

Analüüsi aluseks olid:

- `sales`;
- `customers`;
- `web_logs`.

`web_logs` tabel võimaldas siduda kliendid nende veebiliikluse allikatega ning analüüsida müüki turunduskanalite lõikes.

Analüüsi käigus uurisin:

- klientide arvu kanalite kaupa;
- tellimuste arvu;
- kogukäivet;
- keskmist tellimusväärtust;
- müüki kliendi kohta;
- kanalite efektiivsust;
- turunduskanalite kuiseid trende.

---

## Turundusanalüüsi loogika

```text
web_logs
    │
    │ customer_id
    ▼
customers
    │
    │ customer_id
    ▼
  sales
    │
    ▼
GROUP BY kanal
    │
    ├── kliendid
    ├── tellimused
    ├── kogukäive
    └── keskmine tellimus
    │
    ▼
   CTE
    │
    ▼
Müük kliendi kohta
    │
    ▼
Kanali efektiivsus
```

Turundusanalüüsi juures oli oluline mõista, et `web_logs.customer_id` võib olla `NULL`, sest kõik veebikülastajad ei ole tuvastatud kliendid.

Seetõttu tuleb JOIN-i tulemusi tõlgendades arvestada ka tellimuste ja veebikülastustega, millele ei ole võimalik turunduskanalit üheselt omistada.

---

## Mida õppisin

Week 4 jooksul õppisin:

- koostama koondanalüüse suurest hulgast tehinguandmetest;
- kasutama agregaatfunktsioone `COUNT()`, `SUM()`, `AVG()`, `MIN()` ja `MAX()`;
- grupeerima andmeid `GROUP BY` abil;
- mõistma `WHERE` ja `HAVING` erinevust;
- filtreerima agregeeritud tulemusi `HAVING` abil;
- kasutama `COUNT(DISTINCT ...)` unikaalsete klientide leidmiseks;
- grupeerima kuupäevi `DATE_TRUNC()` abil;
- koostama CTE-sid keerukamate analüüside struktureerimiseks;
- kasutama `LAG()` window function'it perioodide võrdlemiseks;
- arvutama kuust-kuusse muutusi;
- ühendama agregatsiooni JOIN-idega;
- analüüsima müüki tootekategooriate lõikes;
- analüüsima turunduskanalite efektiivsust;
- siduma `sales`, `customers` ja `web_logs` andmeid;
- muutma SQL-päringute tulemused äriliselt tõlgendatavateks koondnäitajateks.

Kõige olulisem õppetund oli, et agregatsioon võimaldab muuta suure hulga üksikuid andmeridu juhtimiseks kasutatavaks informatsiooniks.

SQL-i eesmärk ei ole ainult andmete väljavõtmine, vaid nende koondamine sellisele tasemele, mille põhjal saab märgata trende, võrrelda erinevaid gruppe ja teha ärilisi otsuseid.

---

## Äriline tähendus

Week 4 analüüs ühendas kaks olulist vaatenurka:

```text
MÜÜK                         TURUNDUS
  │                              │
  ▼                              ▼
Kui palju müüsime?       Kust kliendid tulid?
Millal müüsime?          Milline kanal toimis?
Mida müüsime?            Kui palju kanal müüki tõi?
  │                              │
  └──────────────┬───────────────┘
                 ▼
           Äriline otsus
```

Müügianalüüs võimaldab hinnata ettevõtte müügitrende ja tootekategooriate tulemusi.

Turundusanalüüs aitab hinnata, millised kanalid on seotud suurema kliendiarvu, käibe või müügiga kliendi kohta.

Nende kahe analüüsi kombineerimine annab juhtkonnale parema ülevaate sellest, **mis müüki toimub ning milliste kanalitega see müük seotud on**.

---

## Week 4 failid

Week 4 portfoolio ülesehitus:

```text
week-4/
│
├── README.md
│
├── individual/
│   ├── week4_sales_aggregation.sql
│   ├── week4_marketing_aggregation.sql
│   └── UrbanStyle_käive.png
│
└── team/
    └── week4.md
```

### Individuaalne töö — Roll A

**Müügi koondandmed**

[individual/week4_sales_aggregation.sql]

SQL-päringud koos kommentaaridega müügi kuupõhise, kategooriapõhise ja trendianalüüsi kohta.

Analüüsi tulemused:

[individual/UrbanStyle_käive.png]

### Individuaalne töö — Roll D

**Turunduskanalite efektiivsus**

[individual/week4_marketing_aggregation.sql]

SQL-päringud koos kommentaaridega turunduskanalite koondnäitajate, efektiivsuse ja kuiste trendide analüüsimiseks.

---

## Meeskonnatöö

Meeskonnatöö eesmärk oli ühendada erinevate analüüsidomeenide tulemused üheks UrbanStyle'i agregatsiooniraportiks.

Meeskonna analüüs hõlmas:

- müügi koondandmeid;
- kliendigruppide analüüsi;
- inventuuristatistikat;
- turunduskanalite analüüsi.

Minu panus meeskonnatöösse oli:

**Roll A — müügi koondandmed**  
**Roll D — turunduskanalite efektiivsus**

[https://github.com/laura-johanson/urbanstyle-marketing-data/tree/c6ffae8ae752bd09d54eefcaed7e21318712ded9/week4]

**Meeskonna ühine töö:**  
[(https://github.com/laura-johanson/urbanstyle-marketing-data/blob/c6ffae8ae752bd09d54eefcaed7e21318712ded9/week4/teamwork.md)]

---

## AI kasutamine

Week 4 jooksul kasutasin AI-d SQL-päringute loogika kontrollimiseks, keerukamate CTE-de mõistmiseks ning agregatsioonipäringute ja tulemuste ärilise tõlgenduse täpsustamiseks.

AI oli abivahend päringute koostamisel ja kontrollimisel, kuid päringute tulemusi kontrollisin andmebaasis ning lõplikud järeldused tegin saadud andmete põhjal.

---

## Kokkuvõte

Week 4 jooksul õppisin SQL agregatsiooni abil muutma üksikud tehinguandmed juhtimiseks sobivateks koondnäitajateks.

Roll A raames analüüsisin UrbanStyle'i müüki kuude ja tootekategooriate lõikes ning kasutasin CTE-d ja window function'e müügitrendide hindamiseks.

Roll D raames ühendasin müügi-, kliendi- ja veebiliikluse andmed ning analüüsisin turunduskanalite efektiivsust klientide, tellimuste, käibe ja müügi kliendi kohta põhjal.

Week 4 oli oluline samm SQL-i tehnilisest kasutamisest **juhtimisotsuseid toetava koondanalüüsi koostamise suunas**.
