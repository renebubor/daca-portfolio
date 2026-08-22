# Nädal 1 — SQL põhitõed ja müügiandmete uurimine

> **DACA — Andmeanalüütiku Karjäärikiirendi**  
> UrbanStyle'i müügiandmete uurimine SQL päringute abil.

## Nädala eesmärk

Nädal 1 eesmärk oli õppida SQL-i põhitõdesid ning rakendada neid praktilise andmestiku uurimiseks.

Analüüsi aluseks oli UrbanStyle'i `sales` tabel Supabase PostgreSQL andmebaasis. Eesmärk oli saada esmane ülevaade müügiandmete struktuurist, tehingutest, kaupluste asukohtadest, müügikanalitest ja andmekvaliteedist.

Minu ülesanne oli uurida:

- mitu rida on `sales` tabelis;
- millised veerud ja andmed tabelis on;
- millised kaupluste asukohad on esindatud;
- millised on suurimad ja väiksemad tehingud;
- kas andmetes esineb puuduvaid väärtusi.

---

## Kasutatud tööriistad

| Tööriist | Kasutus |
|---|---|
| **Supabase / PostgreSQL** | Analüüsitava andmestiku hoidmine |
| **SQL** | Andmete pärimine, filtreerimine ja grupeerimine |
| **Visual Studio Code** | SQL-failide kirjutamine ja haldamine |
| **SQLTools** | VS Code'i ühendamine PostgreSQL andmebaasiga |
| **Git** | Muudatuste lokaalne versioonihaldus |
| **GitHub** | Projekti ja portfoolio säilitamine |

---

## Analüüsi töövoog

Nädal 0 jooksul seadistatud arenduskeskkonda kasutasin Nädal 1 jooksul praktilise SQL-analüüsi tegemiseks.

```text
        UrbanStyle'i andmed
                │
                ▼
      Supabase / PostgreSQL
                │
                ▼
            SQLTools
                │
                ▼
             VS Code
                │
                ▼
          SQL päringud
                │
                ▼
       Analüüsi tulemused
                │
                ▼
               Git
                │
                ▼
             GitHub
```

SQL päringud salvestasin eraldi `.sql` faili ning projekti muudatusi haldasin Git versioonihalduse abil.

---

## Õpitud SQL käsud ja konstruktsioonid

Nädal 1 jooksul õppisin kasutama SQL-i põhilisi käske ja funktsioone.

| SQL käsk / funktsioon | Eesmärk |
|---|---|
| `SELECT` | Andmete valimine tabelist |
| `FROM` | Tabeli määramine, millest andmeid päritakse |
| `WHERE` | Andmete filtreerimine tingimuse alusel |
| `ORDER BY` | Tulemuste sorteerimine |
| `ASC` | Sorteerimine kasvavas järjekorras |
| `DESC` | Sorteerimine kahanevas järjekorras |
| `LIMIT` | Tagastatavate ridade arvu piiramine |
| `DISTINCT` | Unikaalsete väärtuste leidmine |
| `COUNT()` | Ridade või väärtuste loendamine |
| `GROUP BY` | Andmete grupeerimine |
| `IS NULL` | Puuduvate väärtuste leidmine |
| `IS NOT NULL` | Olemasolevate väärtuste kontrollimine |

Nende abil saab teha andmestiku esmase ülevaatuse, leida huvipakkuvaid kirjeid ning kontrollida andmekvaliteeti.

---

## Minu analüüs

Minu Week-1 individuaalne ülesanne keskendus UrbanStyle'i `sales` tabelile.

Analüüsi käigus uurisin:

- tabeli mahtu ja struktuuri;
- kaupluste asukohti;
- müügikanaleid;
- suurimaid ja väiksemaid tehinguid;
- puuduvaid väärtusi;
- puuduva `store_location` väärtuse seost müügikanaliga.

Mõned kasutatud SQL päringud koos selgitavate kommentaaridega asuvad failis:

[`individual/week1_sales_exploration.sql`](individual/week1_sales_exploration.sql)

SQL-koodi ei ole README-s eraldi dubleeritud, et hoida projekti dokumentatsioon ja lähtekood selgelt eraldatud.

---

## Peamised tulemused

Analüüsi tulemusena sain ülevaate UrbanStyle'i müügiandmete ülesehitusest ning kontrollisin andmestiku olulisemaid tunnuseid.

Peamised leiud:

- `sales` tabel sisaldab **15 234 tehingut**;
- tabelis on **12 veergu**;
- andmestikus on esindatud kaupluste asukohad **Tallinn, Tartu, Pärnu, NULL**;
- suurim tehing oli **2 170,40 €**;
- väikseim tehing oli **-1 405,32 €**;
- `store_location` väärtus puudus **5 204 tehingul**
- `customer_id` väärtus puudus **1 487 tehingul**.

### Andmekvaliteedi tähelepanek

Analüüsi käigus leidsin `store_location` veerus `NULL` väärtusi.

Puuduvate väärtuste täiendav uurimine müügikanalite lõikes võimaldas kontrollida, kas tegemist on andmekvaliteedi probleemiga või on füüsilise kaupluse asukoha puudumine seotud online-müügiga.

See näitas, et `NULL` väärtust ei tohiks automaatselt käsitleda veana. Andmekvaliteedi hindamisel tuleb arvestada ka andmete ärilist tähendust ja konteksti.

---

## Mida õppisin

Nädal 1 jooksul õppisin:

- koostama SQL päringuid andmestiku esmaseks uurimiseks;
- filtreerima ja sorteerima andmeid;
- leidma unikaalseid väärtusi;
- loendama ja grupeerima andmeid;
- tuvastama puuduvaid väärtusi;
- kontrollima andmekvaliteeti;
- tõlgendama SQL päringute tulemusi ärikontekstis;
- salvestama SQL päringuid dokumenteeritud `.sql` faili;
- kasutama Git'i ja GitHubi analüüsiprojekti versioonihalduseks.

Oluline õppetund oli, et SQL päringu tulemus ei ole veel iseenesest analüüs — tulemusi tuleb tõlgendada ning siduda analüüsitava ettevõtte ja andmete kontekstiga.

---

## Week 1 failid

```text
week-1/
│
├── README.md
│
├── individual/
│   ├── week1_sales_exploration.sql
│   ├── asukoht_tehingud_päring.png
│   └── Tln_müük.png
│
└── team/
    └── week1_data_landscape.md
```

### Individuaalne töö

[`individual/week1_sales_exploration.sql`](individual/week1_sales_exploration.sql)  
SQL päringud koos kommentaaridega, mida kasutasin `sales` tabeli uurimiseks.

[`individual/asukoht_tehingud_päring.png`](individual/asukoht_tehingud_päring.png)  
Ekraanipilt SQL päringu tulemusest kus on poodide asukohad ja neis tehtavate tehingute arv.
[`individual/Tln_müük.png`](individual/Tln_müük.png)  
Ekraanipilt SQL päringu tulemusest kus poe asukoht on Tallinn ja tehingu summa on suurem kui 100 eurot.

### Meeskonnatöö

Meeskonnatöö käigus ühendati erinevate UrbanStyle'i tabelite analüüside tulemused ühiseks andmemaastiku ülevaateks.

Minu panus meeskonnatöösse oli `sales` tabeli analüüs.

[`team/week1_data_landscape.md`](team/week1_data_landscape.md)  
Kokkuvõte ja viide meeskonna ühisele Week-1 tööle.

**Meeskonna ühine töö:**  
https://github.com/laura-johanson/urbanstyle-marketing-data/blob/a7baebb0cd97b02d736adce4ebacaac81554a3de/week%201

---

## Kokkuvõte

Nädal 1 jooksul rakendasin SQL-i põhitõdesid UrbanStyle'i müügiandmete praktiliseks uurimiseks.

Analüüs andis esmase ülevaate `sales` tabeli mahust, struktuurist, tehingutest, müügikanalitest ja andmekvaliteedist. Lisaks SQL-i tehnilisele kasutamisele oli oluline tulemuste tõlgendamine ärikontekstis.

Nädal 1 lõi aluse järgnevatele põhjalikumatele andmeanalüüsi ülesannetele, kus SQL päringuid saab kasutada keerukamate äriküsimuste lahendamiseks.