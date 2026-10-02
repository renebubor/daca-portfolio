# Nädal 7 — Python Pandas ja RFM kliendisegmenteerimine

> **DACA — Andmeanalüütiku Karjäärikiirendi**  
> UrbanStyle'i kliendiandmete laadimine, puhastamine ja RFM-põhine kliendisegmenteerimine Python pandas abil.

## Nädala eesmärk

Nädal 7 eesmärk oli liikuda SQL- ja Power BI-põhisest analüüsist edasi Pythonisse ning teha klienditaseme analüüs pandas DataFrame'ide abil.

UrbanStyle'i äriline küsimus oli:

**Kes on meie väärtuslikumad kliendid, millised kliendid on lojaalsed ning milliste klientide puhul on oht, et nad lõpetavad ostmise?**

Selleks kasutati RFM-metoodikat:

- **Recency** — kui hiljuti klient viimati ostis;
- **Frequency** — kui sageli klient ostab;
- **Monetary** — kui palju klient kokku kulutab.

Analüüsi eesmärk oli muuta müügi- ja kliendiandmed kliendisegmentideks, mida saab kasutada näiteks VIP-programmide, lojaalsuskampaaniate ja win-back tegevuste planeerimisel.

Minu grupitöö rollid olid:

- **Roll A — Data Loading**
- **Roll B — Data Cleaning**

Lisaks grupitöö kohustuslikule osale tegin individuaalselt läbi kogu RFM-analüüsi pipeline'i ning lisasin detailsema kliendisegmenteerimise.

---

## Kasutatud tööriistad

| Tööriist | Kasutus |
|---|---|
| **Python** | Andmete töötlemine ja analüüs |
| **pandas** | DataFrame'ide laadimine, ühendamine, puhastamine ja RFM-arvutused |
| **Jupyter Notebook** | Analüüsi, koodi ja tulemuste dokumenteerimine |
| **Supabase / PostgreSQL** | Müügi- ja kliendiandmete allikas |
| **CSV** | Alternatiivne andmeallikas ja RFM tulemuste eksport |
| **Plotly** | RFM tulemuste visualiseerimine |
| **VS Code** | Jupyter Notebook'ide ja projektifailide haldamine |
| **Git / GitHub** | Portfoolio ja versioonihaldus |

---

## Analüüsi töövoog

Week 7 jooksul ehitasin andmetöötluse pipeline'i, mis liigub algandmetest kliendisegmentideni.

```text
       sales + customers
              │
       ┌──────┴──────┐
       │             │
      CSV         Supabase
       │             │
       └──────┬──────┘
              ▼
       pandas DataFrame
              │
              ▼
           merge
              │
              ▼
       andmete puhastus
              │
       ┌──────┼─────────┐
       │      │         │
  duplikaadid NULL-id kuupäevad
       │      │         │
       └──────┼─────────┘
              ▼
      puhastatud andmed
              │
              ▼
        RFM arvutused
              │
       ┌──────┼───────┐
       │      │       │
   Recency Frequency Monetary
       │      │       │
       └──────┼───────┘
              ▼
          RFM skoor
              │
              ▼
      kliendisegmendid
              │
              ▼
      rfm_segments.csv
```

---

# Minu põhiülesanne — Roll A

## Andmete laadimine

Roll A eesmärk oli laadida UrbanStyle'i müügi- ja kliendiandmed pandas DataFrame'idesse, kontrollida nende struktuuri ning ühendada andmed edasiseks analüüsiks.

Tegin andmete laadimise läbi kahel erineval viisil:

1. **CSV failidest**
2. **Supabase andmelaost**

See võimaldas võrrelda lokaalse faili ja andmebaasi kasutamise töövoogu ning muuta notebook'i paindlikumaks erinevate andmeallikate suhtes.

---

## CSV-põhine laadimine

CSV variandis kasutasin lähteandmetena:

- `sales.csv`
- `customers.csv`

Andmed laadisin pandas DataFrame'idesse ning kontrollisin:

- DataFrame'i suurust (`shape`);
- veergude andmetüüpe (`dtypes`);
- esimesi ridu (`head()`);
- oluliste veergude olemasolu.

Andmete laadimiseks kasutasin pandas funktsiooni:

`pd.read_csv()`

---

## Supabase-põhine laadimine

Teises notebook'is laadisin samad andmed otse Supabase keskkonnast.

See võimaldab kasutada analüüsi lähteandmetena andmebaasi ilma CSV vahefailita.

```text
Supabase
   │
   ▼
Python
   │
   ▼
pandas DataFrame
   │
   ▼
RFM pipeline
```

Supabase ligipääsuandmeid ei salvestata notebook'i ega GitHubi repository'sse, vaid neid hallatakse eraldi keskkonnamuutujate kaudu.

---

## Andmete ühendamine

`sales` ja `customers` tabelid ühendatakse `customer_id` kaudu.

Selleks kasutasin pandas `merge()` funktsiooni.

Kontseptuaalselt:

```text
sales
  │
  │ customer_id
  ▼
customers
  │
  ▼
ühendatud DataFrame
```

Ühendatud andmestik sisaldab korraga nii müügitehingute kui ka klientide infot ning on sisendiks järgmisele etapile — andmete puhastamisele.

---

# Minu põhiülesanne — Roll B

## Andmete puhastamine

Roll B eesmärk oli muuta ühendatud DataFrame RFM-analüüsi jaoks usaldusväärseks.

Puhastamise käigus kontrollisin ja töötlesin:

- duplikaate;
- puuduvaid väärtusi;
- kuupäevi;
- negatiivseid või vigaseid müügiväärtusi;
- andmetüüpe.

Oluline põhimõte oli, et puhastamine toimub pandas DataFrame'is ning lähteandmebaasi andmeid analüüsi käigus ei muudeta.

---

## Duplikaatide käsitlemine

Duplikaatide kontrollimisel lähtusin tehingu identifikaatorist.

Duplikaatide leidmiseks ja eemaldamiseks kasutasin pandas meetodeid:

- `duplicated()`;
- `drop_duplicates()`.

Oluline oli eemaldada duplikaadid tehingu identifikaatori järgi, mitte lihtsalt võrrelda tervet rida.

---

## NULL väärtuste käsitlemine

Kontrollisin puuduvaid väärtusi:

`isnull()`

RFM-analüüsi seisukohalt olulised veerud olid:

- `customer_id`;
- `sale_date`;
- `total_price`.

Puuduvate väärtustega read eemaldasin enne edasist analüüsi.

---

## Kuupäevade töötlemine

Müügikuupäeva teisendasin pandas datetime formaati:

`pd.to_datetime()`

See on oluline, sest RFM-analüüsi **Recency** arvutamisel tuleb leida iga kliendi viimane ostukuupäev ning arvutada sellest möödunud päevade arv.

---

## Vigaste väärtuste kontroll

Kontrollisin ka `total_price` väärtusi ning eemaldasin analüüsist negatiivsed müügisummad.

Pärast puhastamist koostasin puhastusraporti, kus kontrollisin:

- lõplikku ridade arvu;
- unikaalsete klientide arvu;
- kuupäevavahemikku;
- eemaldatud duplikaate;
- kriitiliste NULL väärtuste puudumist.

---

# Individuaalne lisatöö — kogu RFM pipeline

Kuigi minu grupitöö vastutus oli Roll A ja B, tegin individuaalsetes notebook'ides läbi ka järgmised analüüsietapid:

- RFM väärtuste arvutamine;
- RFM skooride määramine;
- kliendisegmentide loomine;
- segmentide analüüs;
- tulemuste visualiseerimine;
- segmentide eksport CSV faili.

See võimaldas mul mõista kogu analüüsi töövoogu algandmete laadimisest kuni äriliselt kasutatavate kliendisegmentideni.

---

## RFM analüüs

RFM mudelis arvutasin iga kliendi kohta kolm põhinäitajat.

### Recency

Näitab, mitu päeva on möödunud kliendi viimasest ostust.

```text
väiksem Recency
      ↓
klient ostis hiljuti
      ↓
kõrgem RFM skoor
```

Recency erineb Frequency ja Monetary näitajatest selle poolest, et väiksem väärtus on parem.

---

### Frequency

Näitab, mitu ostu klient analüüsiperioodil tegi.

Suurem ostude arv viitab aktiivsemale kliendisuhtele.

---

### Monetary

Näitab kliendi kogukulutust analüüsiperioodil.

Suurem Monetary väärtus tähendab, et klient on ettevõttele rahaliselt väärtuslikum.

---

## RFM skoorid

Recency, Frequency ja Monetary väärtused teisendasin skoorideks skaalal 1–5.

Selleks kasutasin pandas funktsiooni:

`pd.qcut()`

Frequency puhul kasutasin enne kvintiilide moodustamist ka `rank()` meetodit, sest paljudel klientidel võib olla sama ostude arv.

Lõplik RFM skoor moodustub kolme komponendi põhjal:

```text
RFM Score
   │
   ├── R_score
   ├── F_score
   └── M_score
```

---

## Kliendisegmenteerimine

RFM skooride põhjal jagasin kliendid erinevatesse segmentidesse.

Põhitaseme segmentatsioonis kasutatakse näiteks:

- **VIP Champions**
- **Loyal Customers**
- **Potential**
- **At Risk**
- **Lost**

Segmentide eesmärk on muuta RFM numbrid äriliselt kasutatavaks informatsiooniks.

Näiteks:

| Segment | Võimalik tegevus |
|---|---|
| **VIP Champions** | VIP-pakkumised ja early access |
| **Loyal Customers** | Lojaalsusprogramm ja preemiad |
| **Potential** | Cross-sell ja kliendisuhte kasvatamine |
| **At Risk** | Win-back kampaania |
| **Lost** | Tagasivõitmise viimane pakkumine |

---

# Edasijõudnute lisatöö — detailsem segmentatsioon

Lisaks grupitöös kasutatud põhisegmentatsioonile tegin individuaalselt ka detailsema kliendisegmenteerimise.

Täiendatud lahenduses lisasin rohkem kliendigruppe, et eristada paremini erineva ostukäitumisega kliente.

Täiendavate segmentidena kasutasin näiteks:

- **New Customers**
- **Regular Customers**

Detailsem segmentatsioon võimaldab vältida olukorda, kus väga erineva käitumisega kliendid satuvad liiga laia ühise segmendi alla.
See loob turunduse jaoks täpsema aluse, sest uuele kliendile ja regulaarselt ostvale kliendile ei ole mõistlik teha sama tüüpi kampaaniat.

---

## Segmentide eksport

RFM analüüsi lõpptulemuse eksportisin faili:

[`individual/rfm_segments.csv`](individual/rfm_segments.csv)

CSV-väljund võimaldab kasutada segmente edasi näiteks:

- turunduskampaaniates;
- CRM süsteemis;
- Power BI analüüsis;
- personaliseeritud kliendikommunikatsioonis.

---

## Kaks andmete laadimise lahendust

Individuaalses töös koostasin kaks eraldi notebook'i.

### CSV-põhine lahendus

[`individual/week7_csv_rfm.ipynb`](individual/week7_csv_rfm.ipynb)

Sisaldab:

- `sales.csv` laadimist;
- `customers.csv` laadimist;
- DataFrame'ide ühendamist;
- andmete puhastamist;
- RFM analüüsi;
- kliendisegmenteerimist;
- tulemuste visualiseerimist;
- detailsemat segmentatsiooni.

### Supabase-põhine lahendus

[`individual/week7_supabase_rfm.ipynb`](individual/week7_supabase_rfm.ipynb)

Rakendab sama analüüsiloogikat, kuid andmed laaditakse otse Supabase andmebaasist.

See näitab, et sama analüütilist pipeline'i saab kasutada sõltumata sellest, kas andmeallikas on lokaalne CSV või andmebaas.

---

## Mida õppisin

Week 7 jooksul õppisin:

- kasutama Jupyter Notebook'i analüütilise töövahendina;
- laadima CSV-faile `pd.read_csv()` abil;
- laadima andmeid Supabase andmebaasist;
- kontrollima DataFrame'i struktuuri `shape`, `dtypes` ja `head()` abil;
- ühendama DataFrame'e `merge()` abil;
- leidma ja eemaldama duplikaate;
- käsitlema puuduvaid väärtusi;
- teisendama kuupäevi `pd.to_datetime()` abil;
- kontrollima vigaseid arvulisi väärtusi;
- koostama puhastusraportit;
- kasutama `groupby()` funktsiooni klienditaseme analüüsiks;
- arvutama Recency, Frequency ja Monetary näitajaid;
- kasutama `qcut()` funktsiooni skooride moodustamiseks;
- kasutama `rank()` meetodit korduvate Frequency väärtuste korral;
- looma kliendisegmente;
- eksportima analüüsi tulemusi CSV faili;
- visualiseerima RFM tulemusi Plotly abil;
- koostama detailsemat kliendisegmenteerimist.

Kõige olulisem õppetund oli tervikliku andmepipeline'i mõistmine:

**analüüsi kvaliteet sõltub otseselt sellest, kui korrektselt on andmed enne analüüsi laaditud, ühendatud ja puhastatud.**

---

## Äriline tähendus

RFM-analüüs muudab tehinguandmed klienditaseme informatsiooniks.

```text
Tehingud
   │
   ▼
Kliendikäitumine
   │
   ▼
RFM näitajad
   │
   ▼
Kliendisegmendid
   │
   ▼
Erinevad tegevused
```

Näiteks:

- VIP-klientidele saab pakkuda eksklusiivseid eeliseid;
- lojaalsetele klientidele lojaalsusprogrammi;
- uutele klientidele onboarding-kommunikatsiooni;
- At Risk klientidele win-back kampaaniat;
- kaotatud klientidele viimast tagasivõitmise pakkumist.

RFM võimaldab seega liikuda ühetaolisest massiturundusest kliendikäitumisel põhineva sihitud kommunikatsiooni poole.

---

## Week 7 failid

Minu Week 7 portfoolio struktuur:

```text
week-7/
│
├── README.md
│
├── individual/
│   ├── customers.csv
│   ├── sales.csv
│   ├── rfm_segments.csv
│   ├── week7_csv_rfm.ipynb
│   └── week7_supabase_rfm.ipynb
│
└── team/
    └── [meeskonna ühine notebook / kokkuvõte]
```

### Lähteandmed

[`individual/sales.csv`](individual/sales.csv)  
UrbanStyle'i müügiandmed CSV-põhise analüüsi jaoks.

[`individual/customers.csv`](individual/customers.csv)  
UrbanStyle'i kliendiandmed CSV-põhise analüüsi jaoks.

### Individuaalsed notebook'id

[`individual/week7_csv_rfm.ipynb`](individual/week7_csv_rfm.ipynb)  
Täielik RFM pipeline CSV-andmeallika põhjal.

[`individual/week7_supabase_rfm.ipynb`](individual/week7_supabase_rfm.ipynb)  
Täielik RFM pipeline Supabase andmeallika põhjal.

### Analüüsi väljund

[`individual/rfm_segments.csv`](individual/rfm_segments.csv)  
RFM analüüsi tulemus koos kliendisegmentidega.

---

## Meeskonnatöö

Meeskonnatöö käigus koostati üks terviklik RFM pipeline:

```text
Roll A
Data Loading
     │
     ▼
Roll B
Data Cleaning
     │
     ▼
Roll C
RFM Analysis
     │
     ▼
Roll D
Visualization
```

Minu panus meeskonnatöösse oli:

**Roll A — Data Loading**  
**Roll B — Data Cleaning**

Minu ülesanne oli tagada, et järgmised analüüsietapid saaksid kasutada korrektselt laaditud, ühendatud ja puhastatud andmeid.

Meeskonna ühine väljund:

[Lisa siia `team` kaustas oleva notebook'i või meeskonna GitHubi link]

---

## AI kasutamine

Week 7 jooksul kasutasin AI-d pandas koodi, andmete puhastamise loogika ja RFM analüüsi kontrollimiseks ning erinevate lahendusvariantide võrdlemiseks.

AI aitas muu hulgas mõista `qcut()` ja `rank()` kasutamist, RFM skooride loogikat ning detailsema kliendisegmenteerimise ülesehitust. Lõplikud tulemused kontrollisin Jupyter Notebook'is tegelike andmete põhjal.

---

## Kokkuvõte

Week 7 jooksul liikusin dashboard-põhisest analüüsist klienditaseme analüüsi juurde Python pandas abil.

Minu grupitöö põhirollid olid **Data Loading ja Data Cleaning**, mille käigus laadisin müügi- ja kliendiandmed, ühendasin need ning valmistasin andmestiku ette RFM-analüüsiks.

Individuaalselt tegin läbi kogu RFM-pipeline'i kahel viisil — CSV-failidest ja otse Supabase andmebaasist laaditud andmetega.

Lisaks põhitaseme RFM segmentatsioonile koostasin detailsema lahenduse, kus kliendid jagatakse rohkematesse segmentidesse. See võimaldab kliendikäitumist täpsemalt eristada ning annab turundusele parema aluse sihitud tegevuste planeerimiseks.

Week 7 kõige olulisem õppetund oli, et **andmeanalüüs ei alga RFM-valemist ega diagrammist — see algab usaldusväärsest andmete laadimisest ja puhastamisest**.
