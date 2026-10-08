# Nädal 8 — Python API-d ja automatiseeritud andmepipeline

> **DACA — Andmeanalüütiku Karjäärikiirendi**
> UrbanStyle'i andmete automaatne pärimine, töötlemine, visualiseerimine ja eksport Python pipeline'i abil.

## Nädala eesmärk

Nädal 8 eesmärk oli liikuda ühekordsest käsitsi käivitatavast analüüsist automatiseeritud ja modulaarselt üles ehitatud andmepipeline'i juurde.

Week 7 jooksul tehti kliendianalüüs Jupyter Notebook'is samm-sammult. Week 8 ülesanne oli muuta sarnane töövoog süsteemiks, kus erinevad etapid on jagatud eraldi Python moodulitesse ning kogu protsessi saab käivitada ühe käsuga.

Pipeline'i põhietapid olid:

```text
Supabase API
     │
     ▼
EXTRACT
data_fetcher.py
     │
     ▼
TRANSFORM
transform.py
     │
     ▼
VISUALIZE + EXPORT
visualize_export.py
     │
     ▼
ORCHESTRATE
pipeline.py
     │
     ▼
CSV + HTML + logid
```

Minu grupitöö ülesanne oli:

**Roll B — Data Processing (`transform.py`)**

Lisaks grupitöö rollile tegin individuaalselt läbi kõik pipeline'i etapid ning koostasin tervikliku töötava lahenduse.

---

## Kasutatud tehnoloogiad

| Tehnoloogia | Kasutus |
|---|---|
| **Python** | Pipeline'i moodulite programmeerimine |
| **pandas** | Andmete puhastamine, ühendamine ja agregeerimine |
| **Supabase Python API** | Andmete automaatne pärimine andmebaasist |
| **Plotly** | Analüüsi tulemuste visualiseerimine |
| **YAML** | Pipeline'i konfiguratsiooni eraldamine koodist |
| **python-dotenv** | Keskkonnamuutujate ja API võtmete turvaline laadimine |
| **logging** | Pipeline'i käigu ja vigade logimine |
| **VS Code** | Arenduskeskkond |
| **Git / GitHub** | Versioonihaldus ja portfoolio |

---

# Pipeline'i arhitektuur

Week 8 oluline osa oli õppida jagama suur protsess väiksemateks iseseisvateks mooduliteks.

```text
                   ┌─────────────────┐
                   │    Supabase     │
                   │   PostgreSQL    │
                   └────────┬────────┘
                            │
                            ▼
                   ┌─────────────────┐
                   │ data_fetcher.py │
                   │    EXTRACT      │
                   └────────┬────────┘
                            │
                            ▼
                   ┌─────────────────┐
                   │  transform.py   │
                   │   TRANSFORM     │
                   └────────┬────────┘
                            │
                            ▼
                ┌──────────────────────┐
                │ visualize_export.py  │
                │  VISUALIZE / EXPORT  │
                └──────────┬───────────┘
                           │
                           ▼
                    output failid

         pipeline.py
              │
              └── juhib kogu protsessi järjekorda

         config.yaml
              │
              └── pipeline'i konfiguratsioon
```

Selline ülesehitus muudab koodi lihtsamini testitavaks, hooldatavaks ja edasi arendatavaks.

---

# Minu grupitöö roll — Data Processing

## `transform.py`

Minu peamine vastutus grupitöös oli andmete transformeerimise mooduli koostamine.

`transform.py` ülesanne on võtta `data_fetcher.py` kaudu saadud DataFrame'id ning muuta need analüüsiks sobivaks.

Mooduli põhifunktsioonid hõlmavad:

- andmete puhastamist;
- duplikaatide eemaldamist;
- NULL väärtuste käsitlemist;
- kuupäevade teisendamist;
- andmete valideerimist;
- nädalaste koondnäitajate arvutamist;
- KPI-de arvutamist;
- müügi- ja kliendiandmete ühendamist.

---

## Andmete puhastamine

Transformatsioonietapi esimene ülesanne on kontrollida, et järgmised pipeline'i etapid saaksid kasutada usaldusväärseid andmeid.

Kontrollitakse näiteks:

- kas vajalikud veerud on olemas;
- kas kuupäevad on õiges formaadis;
- kas andmetes esineb duplikaate;
- kas kriitilistes veergudes esineb NULL väärtusi;
- kas arvulised väärtused jäävad loogilisse vahemikku.

Puhastamisel kasutatakse pandas funktsioone ja meetodeid, näiteks:

```text
drop_duplicates()
dropna()
to_datetime()
astype()
```

Eesmärk ei ole ainult vigaste ridade eemaldamine, vaid kontrollida ka seda, et pipeline'i järgmised etapid saavad oodatud struktuuriga andmed.

---

## Nädalased koondnäitajad

Puhastatud müügiandmed agregeeritakse nädalate kaupa.

Näiteks arvutatakse:

- nädalane müügitulu;
- tellimuste arv;
- keskmine tellimuse väärtus.

Töövoog:

```text
Üksikud müügitehingud
          │
          ▼
     kuupäeva kontroll
          │
          ▼
    nädalateks jaotus
          │
          ▼
       agregatsioon
          │
          ▼
Nädalased koondnäitajad
```

See võimaldab järgmises etapis luua automaatselt müügitrendi visualiseeringuid.

---

## KPI-de arvutamine

`transform.py` arvutab ka pipeline'i peamised KPI-d.

Näiteks:

- **Total Revenue** — kogukäive;
- **Unique Customers** — unikaalsete klientide arv;
- **Average Order Value** — keskmine tellimuse väärtus.

KPI-de eraldi arvutamine võimaldab kasutada sama tulemust nii visualiseerimisel, ekspordil kui ka tulevikus näiteks automaatses raportis.

---

## Andmestike ühendamine

Pipeline'is tuleb ühendada erinevatest tabelitest pärinev info.

Näiteks:

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

Selleks kasutatakse pandas `merge()` funktsiooni.

Ühendatud andmestik võimaldab kasutada müügiandmete kõrval ka kliendiinfot.

---

# Individuaalne lisatöö — kogu pipeline

Kuigi minu grupitöö vastutus oli `transform.py`, tegin individuaalselt läbi ka ülejäänud pipeline'i etapid.

See võimaldas mul mõista mitte ainult ühe mooduli ülesannet, vaid kogu süsteemi andmevoogu.

---

## 1. `data_fetcher.py` — andmete pärimine

`data_fetcher.py` vastutab UrbanStyle'i andmete pärimise eest Supabase API kaudu.

Moodul pärib:

- müügiandmed;
- kliendiandmed;
- tooteandmed.

```text
Supabase
   │
   ▼
API päring
   │
   ▼
response.data
   │
   ▼
pandas DataFrame
```

Andmete laadimisel arvestasin ka suuremate andmemahtudega.

Kuna API päringul võib olla korraga tagastatavate ridade piirang, kasutatakse andmete laadimisel lehekülgede kaupa pärimist ehk pagination'it.

---

## 2. `transform.py` — andmete töötlemine

`transform.py` muudab API-st saadud toorandmed analüüsiks sobivaks.

Moodul vastutab:

- andmete puhastamise;
- valideerimise;
- kuupäevade töötlemise;
- andmete ühendamise;
- nädalase agregatsiooni;
- KPI-de arvutamise eest.

See moodul oli minu põhivastutus grupitöös.

---

## 3. `visualize_export.py` — visualiseerimine ja eksport

Järgmine etapp muudab transformeeritud tulemused kasutatavaks väljundiks.

Mooduli ülesanded on:

- nädalase müügitrendi visualiseerimine;
- KPI-de esitamine;
- töödeldud tulemuste eksport CSV faili;
- visualiseeringute eksport HTML faili;
- väljundkausta loomine.

```text
Transformeeritud andmed
          │
     ┌────┴─────┐
     │          │
     ▼          ▼
    CSV       Plotly
                │
                ▼
               HTML
```

HTML-väljund võimaldab interaktiivset Plotly diagrammi avada brauseris ilma Pythonit käivitamata.

---

## 4. `pipeline.py` — protsessi orkestreerimine

`pipeline.py` ühendab erinevad moodulid üheks terviklikuks protsessiks.

Pipeline käivitab etapid õiges järjekorras:

```text
FETCH
  │
  ▼
CLEAN
  │
  ▼
MERGE
  │
  ▼
AGGREGATE
  │
  ▼
CALCULATE KPI
  │
  ▼
VISUALIZE
  │
  ▼
EXPORT
```

Kogu protsessi saab käivitada terminalist ühe käsuga:

```bash
python pipeline.py
```

See oli Week 8 oluline erinevus võrreldes varasemate nädalatega — analüütik ei pea enam iga sammu käsitsi eraldi käivitama.

---

# Täiendatud lahendus

Lisaks kohustuslikule baastasemele täiendasin pipeline'i lahendust, et see oleks lähemal reaalsele automatiseeritud andmetöötlusele.

Täiendused hõlmasid muu hulgas:

- API vigade käsitlemist;
- retry-loogikat;
- andmete valideerimist;
- transformatsioonide logimist;
- pipeline'i etappide veakäsitlust;
- konfiguratsiooni eraldamist programmilogikast;
- väljundfailide automaatset loomist.

---

## Retry ja veakäsitlus

API või võrguühendus võib ajutiselt ebaõnnestuda.

Selle asemel, et kogu pipeline kohe lõpetada, saab päringut vajadusel uuesti proovida.

```text
API päring
    │
    ├── õnnestus → jätka
    │
    └── ebaõnnestus
             │
             ▼
           retry
             │
             ├── õnnestus → jätka
             └── ebaõnnestus → logi viga
```

Veakäsitlus aitab vältida olukorda, kus üks ajutine probleem põhjustab ebaselge programmi kokkujooksmise.

---

## Logimine

Pipeline'i automatiseerimisel ei piisa ainult sellest, et programm töötab.

Oluline on ka teada:

- millal pipeline käivitus;
- milline etapp parasjagu töötab;
- mitu rida töödeldi;
- millal protsess lõppes;
- millises etapis tekkis viga.

Selleks kasutatakse Python `logging` moodulit.

Näiteks:

```text
INFO  Pipeline started
INFO  Fetching sales data
INFO  Cleaning data
INFO  Calculating weekly aggregates
INFO  Exporting results
INFO  Pipeline completed

ERROR Transform step failed: ...
```

Logid muudavad automatiseeritud protsessi jälgitavaks ja lihtsustavad vigade leidmist.

---

## `config.yaml`

Pipeline'i seadistused eraldasin konfiguratsioonifaili.

```text
config.yaml
     │
     ├── päringu parameetrid
     ├── väljundkaustad
     ├── pipeline'i seaded
     └── muud konfiguratsioonid
```

Selle eelis on, et pipeline'i käitumist saab muuta ilma Python-koodi muutmata.

See muudab lahenduse hooldatavamaks ja vähendab hardcoded väärtuste hulka.

---

# Turvalisus

API-põhise pipeline'i loomisel on oluline hoida ligipääsuandmed lähtekoodist eraldi.

Supabase tunnused paiknevad `.env` failis ning neid loetakse Pythonis keskkonnamuutujatena.

```text
.env
 │
 ├── SUPABASE_URL
 └── SUPABASE_KEY
```

`.env` faili ei lisata GitHubi.

`.gitignore` peab sisaldama vähemalt:

```gitignore
.env
venv/
__pycache__/
*.pyc
```

Seega on repository's programmikood, kuid mitte tegelikud API võtmed.

---

## Miks modulaarne arhitektuur?

Kõige olulisem arhitektuuriline õppetund oli vastutuste eraldamine.

Ühe suure Python-faili asemel:

```text
üks suur skript
    │
    ├── API
    ├── puhastamine
    ├── arvutused
    ├── graafikud
    ├── eksport
    └── veakäsitlus
```

kasutasin eraldi mooduleid:

```text
data_fetcher.py
      │
      ▼
transform.py
      │
      ▼
visualize_export.py
      │
      ▼
pipeline.py
```

See muudab lahenduse:

- loetavamaks;
- testitavamaks;
- hooldatavamaks;
- korduvkasutatavamaks;
- lihtsamini laiendatavaks.

---

## Mida õppisin

Week 8 jooksul õppisin:

- kasutama Pythonit API-põhiseks andmete pärimiseks;
- töötama Supabase Python client'iga;
- teisendama API vastuseid pandas DataFrame'ideks;
- kasutama pagination'it suuremate andmemahtude korral;
- jagama andmetöötluse eraldi Python moodulitesse;
- kirjutama korduvkasutatavaid funktsioone;
- puhastama ja valideerima andmeid pandas abil;
- agregeerima ajapõhiseid andmeid nädalate kaupa;
- arvutama automaatselt KPI-sid;
- ühendama DataFrame'e `merge()` abil;
- looma Plotly visualiseeringuid automatiseeritud pipeline'is;
- eksportima tulemusi CSV- ja HTML-failidesse;
- ühendama moodulid üheks end-to-end pipeline'iks;
- kasutama `try/except` veakäsitlust;
- kasutama retry-loogikat;
- logima pipeline'i erinevaid etappe;
- eraldama konfiguratsiooni koodist YAML-faili;
- hoidma API võtmeid `.env` abil GitHubist eemal.

Kõige olulisem õppetund oli, et automatiseerimine ei tähenda lihtsalt olemasoleva koodi järjest käivitamist.

**Töötav pipeline peab olema modulaarne, kontrollitav, veakindel ja jälgitav.**

---

## Week 8 failid

Week 8 lähtekood asub `week-8/individual/` kaustas.

Pipeline'i käivitamisel loodud väljundfailid salvestatakse repository juurkaustas olevasse `output/` kausta.

```text
daca-portfolio/
│
├── output/
│   ├── weekly_results_....csv
│   ├── pipeline_notification_....xlsx
│   ├── weekly_revenue_....html
│   └── kpi_summary_....html
│
├── logs/
│   └── pipeline_....log
│
└── week-8/
    │
    ├── README.md
    │
    ├── individual/
    │   ├── config.yaml
    │   ├── data_fetcher.py
    │   ├── transform.py
    │   ├── visualize_export.py
    │   └── pipeline.py
    │
    └── team/
        └── week8_pipeline_demo.md
```

### Pipeline'i lähtekood

[`individual/data_fetcher.py`](individual/data_fetcher.py)

Pärib müügi-, kliendi- ja tooteandmed Supabase API kaudu.


[`individual/transform.py`](individual/transform.py)

Minu grupitöö põhiülesanne. Puhastab ja valideerib andmed, ühendab andmestikud ning arvutab vajalikud agregatsioonid ja KPI-d.


[`individual/visualize_export.py`](individual/visualize_export.py)

Loob töödeldud andmetest visualiseeringud ning valmistab ette väljundfailid.


[`individual/pipeline.py`](individual/pipeline.py)

Orkestreerib kogu protsessi alates andmete pärimisest kuni väljundfailide loomiseni.


[`individual/config.yaml`](individual/config.yaml)

Sisaldab pipeline'i konfiguratsiooni ja muudetavaid parameetreid.

### Pipeline'i väljundid

Käivitamisel luuakse repository juurkausta output/ kausta automaatselt analüüsi väljundfailid.

# CSV väljund
[`../output/weekly_results_....csv`](../output/weekly_results_20261007.csv)
Sisaldab pipeline'i poolt arvutatud nädalasi koondandmeid, mida saab kasutada edasiseks analüüsiks või teistesse süsteemidesse laadimiseks.
# Exceli väljund
[`../output/weekly_results_....xlsx`](../output/weekly_results_20261007.xlsx)
Exceli väljund sisaldab pipeline'i genereeritud kokkuvõtlikku infot jagamiseks või edasiseks töötlemiseks.
# Nädalase käibe visualiseering
[`../output/weekly_revenue_....html`](../output/weekly_revenue_20261007.html)
Interaktiivne Plotly visualiseering nädalase müügitulu muutusest.
HTML-faili saab avada otse veebibrauseris.
# KPI kokkuvõte
[`../output/kpi_summary_....html`](../output/kpi_summary_20261007.html)
Interaktiivne HTML-väljund, mis kuvab pipeline'i arvutatud peamised KPI-d.
# Logifail
[`../logs/pipeline_....log`](../logs/pipeline_20261007.log)
Logifail salvestab pipeline'i käivituse käigus toimunud etapid ja võimalikud veateated.
Logi abil saab kontrollida näiteks:
- millal pipeline käivitus;
- millal andmete pärimine algas ja lõppes;
- millal transformatsioonid käivitati;
- millal väljundfailid loodi;
- mitu kirjet töödeldi;
- kas mõnes etapis tekkis hoiatus või viga;
- kas pipeline lõpetas töö edukalt.

Oluline erinevus võrreldes varasemate nädalatega on see, et väljundfaile ei koostata enam käsitsi.
pipeline.py käivitamisel:
1. päritakse andmed;
2. andmed puhastatakse ja transformeeritakse;
3. arvutatakse koondnäitajad ja KPI-d;
4. luuakse visualiseeringud;
5. tulemused eksporditakse CSV-, Exceli- ja HTML-failidesse;
6. kogu protsessi käik salvestatakse logifaili.
See teeb pipeline'i mitte ainult korratavaks, vaid ka jälgitavaks — hiljem on võimalik kontrollida, millal protsess käivitus, millised etapid õnnestusid ja kus tekkis võimalik viga.

---

## Meeskonnatöö

Meeskonnatöö käigus ehitati neljast moodulist terviklik UrbanStyle'i automatiseeritud pipeline:

```text
Roll A
data_fetcher.py
      │
      ▼
Roll B
transform.py
      │
      ▼
Roll C
visualize_export.py
      │
      ▼
Roll D
pipeline.py
```

Minu panus meeskonnatöösse oli:

**Roll B — Data Processing (`transform.py`)**

Minu mooduli ülesanne oli võtta API-st pärinevad andmed, puhastada ja valideerida need ning arvutada järgmiste etappide jaoks vajalikud agregatsioonid ja KPI-d.

[`team/week8_pipeline_demo.md`](team/week8_pipeline_demo.md)

Week 8 meeskonnatöö kokkuvõte ja viide ühisele pipeline'i väljundile.

**Meeskonna ühine töö:**
[`meeskonna töö viide week-8`](https://github.com/laura-johanson/urbanstyle-marketing-data/tree/8570c1a67cad89691be021840bd08d58e6f94a08/week8)

---

## AI kasutamine

Week 8 jooksul kasutasin AI-d Python moodulite ülesehituse, pandas transformatsioonide, veakäsitluse ning pipeline'i integratsiooni kontrollimiseks ja vigade leidmiseks.

AI aitas analüüsida ka moodulite vahelisi sõltuvusi ja tehnilisi veateateid. Lõplikku lahendust kontrollisin pipeline'i tervikliku käivitamisega ning parandasin koodi vastavalt tegelikele käivitustulemustele.

---

## Kokkuvõte

Week 8 jooksul liikusin ühekordsest Python-analüüsist modulaarse ja automatiseeritud andmepipeline'i loomiseni.

Minu grupitöö põhivastutus oli `transform.py`, mis puhastab ja valideerib andmed, ühendab andmestikud ning arvutab nädalased koondnäitajad ja KPI-d.

Individuaalselt tegin läbi kogu pipeline'i — alates Supabase API-st andmete pärimisest kuni visualiseerimise, ekspordi ja protsessi orkestreerimiseni. Lisaks rakendasin tootmisvalmidusele suunatud täiendusi, nagu pagination, veakäsitlus, retry-loogika, logimine ja konfiguratsiooni eraldamine.

Week 8 kõige olulisem õppetund oli üleminek mõtteviisilt **„skript töötab”** mõtteviisile **„süsteem töötab usaldusväärselt ja korratavalt”**.
