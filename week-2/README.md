# Nädal 2: SQL Cleaning ehk andmete puhastamine

> **DACA — Andmeanalüütiku Karjäärikiirendi**  
> UrbanStyle'i andmekvaliteedi uurimine ja andmete puhastamine SQL-i abil.

## Nädala eesmärk

Nädal 2 eesmärk oli õppida tuvastama andmekvaliteedi probleeme ning kasutama SQL-i andmete kontrollimiseks, puhastamiseks ja ühtlustamiseks.

Analüüsi keskmes olid UrbanStyle'i andmebaasi `customers`, `sales` ja `products` tabelid.

Peamised andmekvaliteedi probleemid, mida uurisin:

- duplikaatsed kirjed;
- puuduvad ehk `NULL` väärtused;
- ebajärjekindlad tekstivormingud;
- erinevad kuupäevaformaadid;
- vales vormingus või ebaloogilised väärtused.

Oluline põhimõte oli, et andmete puhastamine peab toimuma kontrollitud töövoona:

```text
Tuvasta
   │
   ▼
Dokumenteeri
   │
   ▼
Testi
   │
   ▼
Paranda
   │
   ▼
Kontrolli tulemust
```

Enne andmete muutmist tuleb probleemid tuvastada ja dokumenteerida ning parandusi katsetada testandmetel. Alles pärast tulemuste kontrollimist saab muudatusi rakendada algandmetele.

---

## Kasutatud tööriistad

| Tööriist | Kasutus |
|---|---|
| **Supabase / PostgreSQL** | UrbanStyle'i andmebaas ja testandmed, samuti andmekvaliteedi kontroll ja puhastamine |
| **Visual Studio Code/SQLTools** | SQL-failide kirjutamine ja haldamine |
| **Git** | Muudatuste lokaalne versioonihaldus |
| **GitHub** | Projekti ja portfoolio säilitamine |

---

## Andmete puhastamise töövoog

Week 2 jooksul õppisin, et andmete puhastamine ei tähenda probleemsete kirjete kohest muutmist või kustutamist.

Turvaline töövoog on:

```text
        Algandmed
            │
            ▼
Andmete analüüs/probleemide tuvastamine
            │
            ▼
      Dokumenteerimine
            │
            ▼
       Testkoopia
            │
            ▼
 DELETE / UPDATE testimine
            │
            ▼
    Tulemuse kontroll
            │
            ▼
 Muudatuse rakendamine
```

Selline lähenemine vähendab riski, et puhastamise käigus kustutatakse või muudetakse olulisi andmeid.

---

## Õpitud SQL käsud ja funktsioonid

Week 2 jooksul õppisin kasutama SQL-i käske ja funktsioone, mis aitavad tuvastada ja parandada andmekvaliteedi probleeme.

| SQL käsk / funktsioon | Eesmärk |
|---|---|
| `GROUP BY` | Sarnaste väärtuste grupeerimine |
| `HAVING COUNT(*) > 1` | Duplikaatsete väärtuste tuvastamine |
| `ROW_NUMBER()` | Sama grupi kirjete nummerdamine |
| `PARTITION BY` | Ridade jagamine gruppidesse |
| `IS NULL` | Puuduvate väärtuste leidmine |
| `IS NOT NULL` | Olemasolevate väärtuste kontrollimine |
| `COALESCE()` | `NULL` väärtusele asendusväärtuse määramine |
| `NULLIF()` | Kindla väärtuse muutmine `NULL` väärtuseks |
| `CAST()` / `::` | Andmetüübi teisendamine |
| `TRIM()` | Üleliigsete tühikute eemaldamine |
| `UPPER()` | Teksti muutmine suurtähtedeks |
| `LOWER()` | Teksti muutmine väiketähtedeks |
| `INITCAP()` | Sõnade algustähtede muutmine suureks |
| `TO_CHAR()` | Kuupäeva või väärtuse vormindamine tekstiks |
| `TO_DATE()` | Teksti teisendamine kuupäevaks |
| `CASE` | Tingimusliku loogika rakendamine |
| `UPDATE` | Olemasolevate väärtuste muutmine |
| `DELETE` | Probleemsete kirjete eemaldamine |
| `CREATE TABLE ... AS` | Testkoopia loomine enne puhastamist |

---

## Duplikaatide tuvastamine

Üks Week 2 põhiteemasid oli duplikaatsete kirjete leidmine.

Õppisin kasutama kombinatsiooni:

`GROUP BY + HAVING COUNT(*) > 1`

See võimaldab leida väärtused, mis esinevad tabelis rohkem kui ühe korra.

Keerukamate duplikaatide puhul õppisin kasutama ka:

`ROW_NUMBER() OVER (PARTITION BY ...)`

Selle abil saab sama väärtusega kirjed nummerdada ning eristada alles jäetavat kirjet eemaldatavatest koopiatest.

Oluline oli mõista, et duplikaadi määratlus sõltub äriloogikast. Sama nimi ei tähenda alati sama klienti ning enne kirjete eemaldamist tuleb otsustada, millise tunnuse põhjal kirje tegelikult duplikaadiks loetakse.

---

## NULL väärtuste käsitlemine

Teine oluline teema oli puuduvate väärtuste analüüs.

Õppisin eristama kolme erinevat olukorda:

```text
NULL    → väärtus puudub või ei ole teada
''      → tühi tekstiväärtus
0       → arvuline väärtus null
```

Need väärtused ei tähenda andmebaasis sama asja.

Puuduvate väärtuste leidmiseks kasutasin:

`IS NULL` ja `IS NOT NULL`

Lisaks õppisin kasutama `COALESCE()` funktsiooni, mis võimaldab kuvada puuduva väärtuse asemel sobivat asendusväärtust.

Samuti õppisin, et `NULL` väärtused võivad mõjutada arvutusi ning seetõttu tuleb nende olemasolu kontrollida enne analüüsi tegemist.

---

## Teksti ja andmeformaatide ühtlustamine

Andmete puhastamisel uurisin ka ebajärjekindlaid tekstiväärtusi.

Näiteks võivad sama linna väärtused olla sisestatud erinevalt:

```text
Tallinn
tallinn
TALLINN
 Tallinn
```

Inimese jaoks tähendavad need sama linna, kuid andmebaasis võivad need olla erinevad väärtused.

Teksti puhastamiseks õppisin kasutama:

- `TRIM()` — eemaldab teksti algusest ja lõpust tühikud;
- `UPPER()` — muudab teksti suurtähtedeks;
- `LOWER()` — muudab teksti väiketähtedeks;
- `INITCAP()` — ühtlustab sõnade algustähed.

Näiteks võimaldab:

`INITCAP(TRIM(city))`

koondada erinevad linnanime kirjaviisid ühtsele kujule.

---

## Andmetüübid ja kuupäevad

Week 2 jooksul õppisin ka andmetüüpide teisendamist ja kuupäevade vormindamist.

Selleks kasutasin:

- `CAST()`;
- PostgreSQL-i `::` süntaksit;
- `TO_CHAR()`;
- `TO_DATE()`.

Andmetüübi kontrollimine on oluline, sest näiteks tekstina salvestatud arv või kuupäev võib põhjustada probleeme sorteerimisel, arvutamisel ja analüüsimisel.

Samuti võivad erinevad kuupäevaformaadid põhjustada väärtuste valet tõlgendamist.

---

## Minu analüüs

Week 2 praktilise töö käigus uurisin UrbanStyle'i kliendiandmete tabeli andmekvaliteeti ning rakendasin õpitud puhastamisvõtteid testandmetel.

Analüüsi käigus kontrollisin:

- duplikaatseid kliendikirjeid;
- duplikaatseid e-posti aadresse;
- puuduvaid kliendiandmeid;
- telefoninumbrite formaati;
- tekstiväljade ühtlust;
- erinevaid linnanimede kirjaviise;
- andmete parandamise võimalusi;
- duplikaatsete kirjete ohutut eemaldamist.

Puhastamisel lähtusin põhimõttest, et algandmeid ei muudeta enne, kui muudatus on testkoopial kontrollitud.

Kõik kasutatud SQL päringud koos kommentaaridega asuvad individuaalse töö ['SQL-failis'](week2/individual/week2_cuatomers_cleaning.sql)
ja olulisemad päringud ning muutmiskäsud ['cleaning_log'](week2/individual/cleaning_log.md)failis.

---

## Mida õppisin

Week 2 jooksul õppisin:

- tuvastama andmetes duplikaate;
- määratlema, millise tunnuse järgi kirjeid duplikaatideks lugeda;
- kasutama `GROUP BY` ja `HAVING` konstruktsioone duplikaatide leidmiseks;
- kasutama `ROW_NUMBER()` ja `PARTITION BY` funktsioone kirjete eristamiseks;
- leidma ja analüüsima `NULL` väärtusi;
- mõistma erinevust `NULL`, tühja stringi ja `0` vahel;
- kasutama `COALESCE()` ja `NULLIF()` funktsioone;
- puhastama tekstivälju `TRIM()`, `UPPER()`, `LOWER()` ja `INITCAP()` abil;
- teisendama andmetüüpe `CAST()` abil;
- ühtlustama kuupäevade formaate;
- kasutama `CASE` tingimusloogikat;
- looma testtabelit enne andmete muutmist;
- kasutama `UPDATE` käsku andmete parandamiseks;
- kasutama `DELETE` käsku kontrollitud duplikaatide eemaldamiseks;
- kontrollima pärast puhastamist, kas muudatus andis soovitud tulemuse.

Kõige olulisem õppetund oli, et andmete puhastamine ei ole ainult SQL-käskude kirjutamine.

Enne andmete muutmist tuleb mõista, **miks probleem tekkis, millised read vajavad muutmist ning milline on muudatuse mõju andmetele ja hilisemale analüüsile**.

---

## Andmekvaliteedi äriline tähendus

Andmekvaliteedi probleemid võivad otseselt mõjutada analüüsi tulemusi.

Näiteks võivad:

- duplikaatsed müügitehingud näidata tegelikust suuremat müügitulu;
- puuduvad kliendiandmed takistada kliendianalüüsi;
- erinevalt kirjutatud linnanimed jagada ühe piirkonna mitmeks eraldi grupiks;
- ebakorrektsed formaadid põhjustada vigaseid arvutusi või aruandeid.

Seetõttu on andmete puhastamine oluline samm enne analüüsi ja visualiseerimist.

---

## Week 2 failid

```text
week-2/
│
├── README.md
│
├── individual/
│   ├── week2_customers_cleaning.sql
│   ├── week2_customers_report.md
│   ├── customers_puhastamisraport.png
│   └── cleaning_log.md
│
└── team/
    └── week2_team_cleaning_report.md
```

### Individuaalne töö

[`individual/week2_customers_cleaning.sql'](individual/week2_customers_cleaning.sql)  
SQL päringud koos kommentaaridega, mida kasutasin andmekvaliteedi uurimiseks ja andmete puhastamiseks.

### Meeskonnatöö

Meeskonnatöö käigus ühendati individuaalsete analüüside tulemused ning koostati ülevaade UrbanStyle'i andmekvaliteedist ja puhastamisvajadusest.

Minu individuaalse analüüsi tulemused olid sisendiks meeskonna ühisele tööle.

[`team/week2_team_cleaning_report.md'](team/week2_team_cleaning_report.md)  
Kokkuvõte ja viide meeskonna ühisele Week 2 tööle.

**Meeskonna ühine töö:**  
[`meeskonna töö viide week-2`](https://github.com/laura-johanson/urbanstyle-marketing-data/tree/9eaa9b8820ee04cffe97bdfdcb1c90c8220ad10a/week2)

---

## Kokkuvõte

Week 2 jooksul liikusin andmete esmasest uurimisest edasi andmekvaliteedi probleemide tuvastamise ja parandamise juurde.

Õppisin leidma duplikaate ja puuduvaid väärtusi, ühtlustama teksti- ja kuupäevaformaate ning kasutama SQL-i andmete kontrollitud puhastamiseks.

Kõige olulisem põhimõte oli turvaline puhastamise töövoog: **tuvasta probleem, dokumenteeri see, testi parandust koopial, kontrolli tulemust ja alles seejärel rakenda muudatus algandmetele**.

See loob aluse usaldusväärsele andmeanalüüsile, sest analüüsi ja aruandluse kvaliteet sõltub otseselt lähteandmete kvaliteedist.