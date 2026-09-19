# Nädal 5 — Visualiseerimise disain Power BI-s

> **DACA — Andmeanalüütiku Karjäärikiirendi**  
> UrbanStyle'i andmete visualiseerimine erinevate stakeholder'ite vajaduste järgi.

## Nädala eesmärk

Nädal 5 eesmärk oli õppida muutma varasematel nädalatel analüüsitud ja agregeeritud andmed selgeteks ning äriliselt kasutatavateks visualiseeringuteks.

Fookuses ei olnud enam ainult õigete numbrite leidmine, vaid nende esitamine sellisel kujul, et erinevad kasutajad saaksid dashboard'ilt kiiresti enda jaoks vajaliku info.

UrbanStyle'i puhul vajasid erinevad stakeholder'id samadest andmetest erinevat vaadet:

- **Kristi / CEO** — kõrgtaseme KPI-d ja müügitrend;
- **Anna / turundus** — müügikanalid ja kliendihankimine;
- **Liis / operatsioonid** — müük kaupluste lõikes ja laoseis;
- **Investor** — ettevõtte peamised KPI-d ja koondvaade.

Minu individuaalne ülesanne oli:

**Roll B — Marketing Dashboard (Anna vaade)**

Lisaks koondasin Power BI tööfaili ka Rollide A, C ja D vaated, et erinevate stakeholder'ite analüüsid oleksid ühes terviklikus raportis.

---

## Kasutatud tööriistad

| Tööriist | Kasutus |
|---|---|
| **Power BI Desktop** | Dashboard'ide ja visualiseeringute loomine |
| **Supabase / PostgreSQL** | UrbanStyle'i lähteandmed |
| **Power Query** | Andmete laadimine ja ettevalmistamine |
| **DAX** | Mõõdikute ja KPI-de arvutamine |
| **SQL** | Andmete kontroll ja analüüs |
| **Git / GitHub** | Portfoolio ja projekti versioonihaldus |

---

## Nädala põhifookus — andmete visualiseerimine

Week 4 jooksul keskendusin koondnumbrite arvutamisele SQL-is.

Week 5 järgmine samm oli muuta need tulemused visuaalselt arusaadavaks:

```text
Andmebaas
    │
    ▼
Supabase / PostgreSQL
    │
    ▼
Power BI
    │
    ├── Andmemudel
    ├── DAX mõõdikud
    ├── KPI kaardid
    ├── Diagrammid
    └── Filtrid / slicerid
    │
    ▼
Stakeholder'i dashboard
    │
    ▼
Äriline järeldus
```

Oluline oli valida visualiseering vastavalt küsimusele, mitte kasutada diagramme ainult kujunduse pärast.

---

## Õpitud visualiseerimise põhimõtted

Week 5 jooksul õppisin rakendama järgmisi visualiseerimise põhimõtteid:

| Vajadus | Sobiv visualiseering |
|---|---|
| Trendi näitamine ajas | Joondiagramm |
| Kategooriate võrdlemine | Tulpdiagramm |
| Osakaalu näitamine tervikust | Sektordiagramm |
| Ühe olulise näitaja esitamine | KPI / Card |
| Kasutajapoolne filtreerimine | Slicer |

Lisaks õppisin pöörama tähelepanu:

- visuaalsele hierarhiale;
- õigete diagrammitüüpide valikule;
- selgetele pealkirjadele;
- telgede ja väärtuste arusaadavale vormingule;
- ühtsele värvipaletile;
- üleliigsete elementide eemaldamisele;
- dashboard'i mahutamisele ühele ekraanile;
- KPI-de paigutamisele kõige nähtavamasse piirkonda.

---

# Minu individuaalne töö — Roll B

## Marketing Dashboard — Anna vaade

Minu Week 5 põhiülesanne oli luua turundusjuhile Annale dashboard, mis aitaks hinnata:

- millised müügikanalid annavad kõige rohkem müüki;
- kuidas müük jaotub kanalite lõikes;
- kuidas muutub klientide lisandumine ajas;
- millised kanalid on kliendihankimise seisukohalt olulisemad.

Analüüsi aluseks olid järgmised andmetabelid:

- `sales`;
- `customers`.

---

## Turundusdashboard'i loogika

```text
           sales
             │
             ├── channel
             ├── total_price
             └── customer_id
             │
             ▼
          customers
             │
             ├── registration_date
             └── customer_id
             │
             ▼
         Power BI mudel
             │
       ┌─────┴─────┐
       ▼           ▼
 Müügikanalid   Kliendihankimine
       │           │
       ▼           ▼
 Tulpdiagramm   Ajatrend
       │           │
       └─────┬─────┘
             ▼
     Marketing Dashboard
```

---

## Müügikanalite analüüs

Üks dashboard'i põhivaateid oli müügi võrdlemine kanalite lõikes.

Visualiseeringu eesmärk oli näidata kiiresti, millised kanalid annavad suurema osa müügist.

Selle jaoks sobib tulpdiagramm, sest erinevate kategooriate väärtusi on lihtne omavahel võrrelda.

Diagrammi koostamisel pöörasin tähelepanu sellele, et:

- kanalid oleksid selgelt eristatavad;
- väärtused oleksid õigesti vormindatud;
- kategooriad oleksid loogiliselt järjestatud;
- pealkiri selgitaks kohe diagrammi sisu.

---

## Kliendihankimine ajas

Teine oluline vaade keskendus klientide lisandumisele ajas.

Ajatrendi visualiseerimine võimaldab näha:

- millistel perioodidel lisandus rohkem kliente;
- kas klientide lisandumine suureneb või väheneb;
- kas trendis esineb hooajalisust või ebatavalisi muutusi.

Ajatrendi jaoks kasutasin joondiagrammi, mis võimaldab muutusi perioodide lõikes lihtsalt jälgida.

---

## Power BI raporti tervikvaade

Kuigi minu individuaalne vastutus oli **Roll B**, sisaldab minu Week 5 Power BI fail ka teiste põhivaadete lahendusi.

Raportis on esindatud:

### Roll A — CEO Dashboard

Kristi kõrgtaseme juhtimisvaade:

- müügitulu kokku;
- klientide arv;
- keskmine tellimuse summa;
- käibe kasv;
- müügitulu trend.

### Roll B — Marketing Dashboard

Minu individuaalne töö:

- müük müügikanalite lõikes;
- uute klientide lisandumine.

### Roll C — Operations Dashboard

Operatsioonide vaade:

- müük müügikohtade lõikes;
- müügi osakaal asukohtade lõikes;
- laoseis kategoorite lõikes.

### Roll D — Investor Dashboard

Koondvaade, mis ühendab peamised ettevõtte KPI-d ning Rollide A, B ja C olulisemad leiud.

---

## Dashboard'i disain

Dashboard'ide kujundamisel lähtusin sellest, et visuaalid peavad toetama informatsiooni mõistmist, mitte tähelepanu endale tõmbama.

Rakendasin järgmisi põhimõtteid:

- selge ja ühtne paigutus;
- piiratud värvipalett;
- üleliigsete gridline'ide ja dekoratiivsete elementide eemaldamine;
- KPI-de esiletõstmine;
- diagrammide loogiline järjestamine;
- sarnaste elementide ühtne vormistus;
- selged ja kirjeldavad pealkirjad;
- sobivad slicerid andmete filtreerimiseks.

Dashboard peab võimaldama kasutajal mõista peamist olukorda võimalikult kiiresti.

---

## Data-ink ratio

Üks Week 5 oluline põhimõte oli **data-ink ratio** ehk visualiseeringus peaks võimalikult suur osa nähtavast infost kandma tegelikku andmesõnumit.

Seetõttu eemaldasin võimalusel:

- ebavajalikud raamid;
- üleliigsed gridline'id;
- dekoratiivsed elemendid;
- korduva info;
- visuaalid, mis ei aidanud vastata stakeholder'i küsimusele.

Eesmärk oli jätta dashboard'ile ainult otsustamiseks vajalik info.

---

## Interaktiivsus

Power BI võimaldab staatilise raporti asemel luua interaktiivse analüüsikeskkonna.

Dashboard'i kasutamisel saab andmeid filtreerida näiteks:

- aasta;
- kvartali;
- kuu;
- asukoha;
- kategooria

järgi.

Slicerid ja visualiseeringute omavahelised seosed võimaldavad kasutajal vaadata sama analüüsi erinevate nurkade alt.

---

## Mida õppisin

Week 5 jooksul õppisin:

- looma Power BI-s terviklikku raportit;
- valima visualiseeringu vastavalt äriküsimusele;
- kasutama KPI-kaarte olulisemate näitajate esitamiseks;
- koostama joondiagramme trendide näitamiseks;
- koostama tulpdiagramme kategooriate võrdlemiseks;
- kasutama sektordiagrammi osa-terviku suhte esitamiseks;
- kasutama slicereid interaktiivseks filtreerimiseks;
- struktureerima dashboard'i erinevate stakeholder'ite vajaduste järgi;
- rakendama visuaalset hierarhiat;
- kasutama ühtset värvipaletti;
- vähendama üleliigset visuaalset müra;
- siduma visualiseeringu konkreetse äriküsimusega;
- looma ühest Power BI andmemudelist mitu erineva eesmärgiga raportivaadet.

Kõige olulisem õppetund oli, et hea dashboard ei näita võimalikult palju andmeid.

Hea dashboard näitab **õigele kasutajale õiget infot õigel kujul**.

---

## Äriline tähendus

Sama ettevõtte andmed võivad erinevate kasutajate jaoks tähendada erinevaid küsimusi.

```text
CEO
 │
 └── Kas ettevõte kasvab?

Turundusjuht
 │
 └── Millised kanalid töötavad?

Operatsioonide juht
 │
 └── Kas kaupa on õigetes kohtades piisavalt?

Investor
 │
 └── Milline on ettevõtte tervikpilt?
```

See näitas, et andmeanalüütiku ülesanne ei ole ainult numbrite arvutamine.

Oluline on mõista, **kes analüüsi kasutab, millise otsuse tegemiseks ta seda vajab ja milline visualiseering aitab tal vastuse kõige kiiremini leida**.

---

## Week 5 failid

Week 5 portfoolio struktuur:

```text
week-5/
│
├── README.md
│
├── individual/
│   ├── urbanstyle_week5_dashboard_all.pbix
│   ├── queries.sql
│   └── Marketing_Dashboard.png
│
└── team/
    └── week5.md
```

### Power BI tööfail

['urbanstyle_week5_dashboard_all.pbix'](urbanstyle_week5_dashboard_all.pbix)

Power BI raport sisaldab Rollide A, B, C ja D lahendusi.

Minu individuaalne kodutöö oli **Roll B — Marketing Dashboard**, ülejäänud vaated on lisatud samasse raportisse tervikliku UrbanStyle'i Power BI lahenduse kujundamiseks.

### Power BI tööfaili andmete kontroll

['queries.sql'](queries.sql)

Dashboardi andmete kontrolliks kasutasin SQL päringuid

### Dashboard'i ekraanipilt

['Marketing_Dashboard.png'](Marketing_Dashboard.png)

Ekraanipilt näitab minu Week 5 Power BI töö tulemust.

---
## Meeskonnatöö

Meeskonnatöö käigus loodi erinevatele stakeholder'itele eraldi dashboard'i vaated ning nende peamised tulemused ühendati terviklikuks UrbanStyle'i ülevaateks.

Minu panus meeskonnatöösse oli:

**Roll B — Marketing Dashboard (Anna vaade)**

[`team/week5.md`](team/week5.md)

Week 5 meeskonnatöö lühikokkuvõte ja viide ühisele väljundile.

**Meeskonna ühine töö:**  
[https://github.com/laura-johanson/urbanstyle-marketing-data/tree/89eba75c52d646af3e5ca5514d49fb4bfeab6967/week5]

---

## AI kasutamine

Week 5 jooksul kasutasin AI-d Power BI lahenduste, DAX mõõdikute ja visualiseeringute loogika kontrollimiseks ning dashboard'i kujunduse ja paigutuse täpsustamiseks.

AI aitas leida võimalikke lahendusi, kuid visualiseeringud, arvutused ja tulemused kontrollisin Power BI-s tegelike andmete põhjal.

---

## Kokkuvõte

Week 5 jooksul liikusin SQL-põhisest andmeanalüüsist tulemuste visuaalse esitamise juurde Power BI-s.

Minu individuaalne Roll B keskendus turundusdashboard'ile, mille eesmärk oli näidata müügikanalite tulemusi ja kliendihankimise trende.

Lisaks sisaldab minu Power BI raport Rollide A, C ja D vaateid, mistõttu moodustab fail terviklikuma UrbanStyle'i juhtimisraporti erinevate stakeholder'ite jaoks.

Week 5 kõige olulisem õppetund oli, et visualiseerimise eesmärk ei ole lihtsalt muuta andmeid ilusaks, vaid **muuta analüüsi tulemus kiiresti mõistetavaks ja otsustamiseks kasutatavaks**.
