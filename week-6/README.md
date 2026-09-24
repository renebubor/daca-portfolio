# Nädal 6 — Andmelugu ja Power BI dashboard'i viimistlemine

> **DACA — Andmeanalüütiku Karjäärikiirendi**  
> UrbanStyle'i asukohapõhiste dashboard'ide viimistlemine ja andmeloo jutustamine Power BI-s.

## Nädala eesmärk

Nädal 6 eesmärk oli arendada Week 5 jooksul loodud Power BI dashboard edasi viimistletud ja äriliselt mõtestatud lahenduseks.

Kui Week 5 keskendus eelkõige sobivate visualiseeringute loomisele, siis Week 6 fookus oli:

- dashboard'i kohandamine konkreetsele asukohale;
- andmeloo loomine;
- juhtidele mõeldud kokkuvõtte koostamine;
- annotatsioonide lisamine;
- eesmärgi- ja võrdlusjoonte kasutamine;
- KPI-de konteksti asetamine;
- visualiseeringute omavaheliste interaktsioonide teadlik juhtimine;
- Power BI raporti viimistlemine jagamisvalmis kujule.

Oluline küsimus ei olnud enam ainult:

**„Mida andmed näitavad?”**

vaid:

**„Miks see on oluline ja mida peaks selle põhjal tegema?”**

Minu individuaalne ülesanne oli:

**Roll C — Pärnu kaupluse dashboard + narratiiv**

---

## Kasutatud tööriistad

| Tööriist | Kasutus |
|---|---|
| **Power BI Desktop** | Dashboard'ide loomine ja viimistlemine |
| **Supabase / PostgreSQL** | UrbanStyle'i lähteandmed |
| **Power Query** | Andmete laadimine ja ettevalmistamine |
| **DAX** | Mõõdikute ja arvutuste loomine |
| **Power BI Analytics** | Viitejooned ja analüütilised elemendid |
| **Git / GitHub** | Portfoolio ja failide versioonihaldus |
| **AI tööriistad** | Analüüsi, DAX-i ja narratiivi kontroll ning täpsustamine |

---

## Week 5 → Week 6 areng

Week 5 jooksul valmis dashboard'i funktsionaalne prototüüp.

Week 6 eesmärk oli muuta see analüütiliseks looks:

```text
Week 5
Dashboard'i prototüüp
        │
        ▼
Diagrammid + KPI-d + slicerid
        │
        ▼
Week 6
Asukohapõhine analüüs
        │
        ├── annotatsioonid
        ├── viitejooned
        ├── juhtide kokkuvõte
        ├── äriline narratiiv
        └── tegevussoovitus
        │
        ▼
Viimistletud Power BI raport
```

Seega muutus dashboard lihtsalt andmete kuvamise vahendist otsustamist toetavaks tööriistaks.

---

## Andmeloo ülesehitus

Week 6 jooksul õppisin kasutama andmeloo koostamisel järgmist loogikat:

```text
ÜLESSEADE
    │
    ▼
KONFLIKT
    │
    ▼
ANDMED
    │
    ▼
LAHENDUS
    │
    ▼
TEGEVUS
```

### Ülesseade

Mis on analüüsitava asukoha taust ja roll UrbanStyle'i tegevuses?

### Konflikt

Milline probleem, muutus või küsimus vajab selgitamist?

### Andmed

Mida dashboard tegelikult näitab?

### Lahendus

Mida saadud tulemused aitavad mõista?

### Tegevus

Millise otsuse või järgmise analüüsi peaks tulemuse põhjal tegema?

Selline lähenemine aitab liikuda üksikute arvude esitamisest ärilise sõnumini.

---

# Minu individuaalne töö — Roll C

## Pärnu kaupluse dashboard

Minu Week 6 individuaalne ülesanne oli luua **Pärnu kaupluse interaktiivne dashboard koos andmelooga**.

Pärnu on UrbanStyle'i väikseim füüsiline kauplus ning selle müügis on nähtav hooajalisus.

Dashboard'i eesmärk oli uurida:

- kuidas Pärnu müük aasta jooksul muutub;
- kui suur roll on suvekuudel;
- millal toimub aasta müügitipp;
- millal on müük kõige madalam;
- millised tooted annavad kõige rohkem käivet;
- kuidas muutuvad tehingute arv ja keskmine tellimuse väärtus;
- milliseid perioode tuleks täiendavalt analüüsida.

---

## Pärnu dashboard'i ülesehitus

Minu Pärnu vaates kasutasin mitut tüüpi visualiseeringuid:

```text
Pärnu dashboard
│
├── KPI kaardid
│
├── Müügitulu trend
│
├── TOP 5 tooted
│
├── Hooajaline müük
│
├── Annotatsioonid
└── Viitejooned
```

### Müügitulu trend

Joondiagramm näitab Pärnu müügi muutumist ajas.

Diagrammile lisatud annotatsioonid aitavad olulisi perioode kiiresti märgata.

Pärnu andmetes paistavad selgelt välja:

- iga-aastane müügitipp augustis;
- madalseis jaanuaris;
- suveperioodi tugevam müük.

Dashboard'is kasutasin lisaks viitejooni, mis võimaldavad tegelikku tulemust võrrelda eesmärgi ja keskmise müügitasemega.

---

## Hooajalisuse analüüs

Pärnu puhul oli peamine analüüsiteema hooajalisus.

Analüüs näitas, et suvekuud on oluline müügiperiood, kuid Pärnu kauplus ei sõltu ainult suvest.

Suvekuud moodustavad ligikaudu **30% aastamüügist**, samal ajal püsib müük arvestataval tasemel ka ülejäänud aasta jooksul.

Kõige selgem müügitipp toimub augustis ning madalaim periood on jaanuar.

See tähendab, et Pärnu puhul on hooajalisus oluline, kuid kaupluse äriline potentsiaal ei piirdu ainult suvehooajaga.

---

## Tehingute arv ja keskmine ostukorv

Dashboard'i analüüsimisel oli oluline vaadata lisaks käibele ka tehingute arvu ja keskmist tellimuse väärtust.

2024. aasta analüüsis suurenes tehingute arv kiiremini kui käive.

See viitab sellele, et suurem külastuste või ostude arv ei pruugi automaatselt tähendada samas tempos kasvavat käivet.

Üks võimalik selgitus on väiksem keskmine ostukorv.

Seetõttu tuleks müügikasvu hindamisel vaadata korraga vähemalt:

- käivet;
- tehingute arvu;
- keskmist tellimuse väärtust.

---

## Annotatsioonid

Week 6 üks oluline täiendus oli annotatsioonide kasutamine.

Annotatsiooni eesmärk ei ole lihtsalt korrata diagrammil olevat väärtust, vaid selgitada, **miks konkreetne andmepunkt väärib tähelepanu**.

Pärnu dashboard'is tõin näiteks välja:

- iga-aastase müügitipu augustis;
- jaanuari madalseisu;
- nõrgema juunikuu võimaliku seose ilmastiku ja külastatavusega.

Oluline on eristada andmetest kinnitatud tulemust ja hüpoteesi.

Näiteks ilmastiku võimalik mõju külastatavusele on **edasise analüüsi hüpotees**, mitte olemasolevate müügiandmete põhjal tõestatud põhjus.

---

## Viitejooned

Dashboard'ile lisasin viitejooned, mis annavad müüginumbritele konteksti.

Näiteks saab tegelikku kuukäivet võrrelda:

- eesmärgiga;
- keskmise kuukäibega.

Pärnu müügitrendi juures kasutasin eesmärgijoont:

**€15 000 kuus**

ning keskmise müügi võrdlusjoont.

Viitejoon aitab kasutajal ühe pilguga mõista, kas tulemus on tavapärasest või eesmärgist kõrgem või madalam.

---

## Pärnu andmelugu

Pärnu müük on hooajaline, kuid mitte ainult suvest sõltuv.

Suvekuud moodustavad ligikaudu 30% aastamüügist ning müük püsib arvestataval tasemel ka ülejäänud aasta jooksul. Selgeim madalseis on jaanuaris, samas kui augustis saavutatakse aasta tipp.

2024. aastal kasvas tehingute arv kiiremini kui käive, mis viitab väiksema keskmise ostukorvi võimalikule mõjule.

Järgmisena tuleks uurida, kas nõrgemate perioodide tulemused on seotud külastatavuse, kohaliku turunduse, konkurentsi või tootevalikuga.

---

## „Ja mis siis?” põhimõte

Week 6 oluline õppetund oli kontrollida iga dashboard'il oleva näitaja puhul:

**„Ja mis siis?”**

Näiteks:

```text
Nõrk:

"Pärnu müügitipp on augustis."


Tugevam:

"Pärnu müügitipp on augustis.
See viitab selgele hooajalisele nõudlusele,
mida saab kasutada varude ja turunduse
planeerimisel."
```

Eesmärk on siduda number võimaliku ärilise otsusega.

---

## Power BI raporti tervik

Minu Week 6 Power BI fail sisaldab kogu meeskonna nelja asukohavaadet:

```text
urbanstyle_week6_dashboard_Rene.pbix
│
├── Pärnu dashboard
│     └── Roll C — minu individuaalne ülesanne
│
├── Tallinna dashboard
│     └── Roll A
│
├── Tartu dashboard
│     └── Roll B
│
└── Online dashboard
      └── Roll D
```

Selline lahendus võimaldab võrrelda nelja erinevat UrbanStyle'i müügikanalit ja asukohta ühe Power BI faili sees.

Igal vaatel on oma asukohapõhine fookus, kuid kasutatakse sama andmemudelit ja ühtset kujundusloogikat.

---

## Power BI tehnilised oskused

Week 6 jooksul täiendasin ka Power BI tehnilisi oskusi.

Õppisin või rakendasin:

- page-level filtreid;
- KPI-kaarte;
- annotatsioone;
- constant/reference line'e;
- DAX mõõdikuid;
- conditional formatting'u põhimõtteid;
- visualiseeringute interaktsioonide juhtimist;
- slicerite kasutamist;
- raportilehtede struktureerimist;
- erinevate stakeholder'i vaadete loomist ühe andmemudeli peale.

---

## DAX ja mõõdikud

Week 6 jooksul süvenes Power BI-s ka mõõdikute kasutamine.

Oluline erinevus oli:

```text
Calculated Column
        │
        └── arvutatakse iga rea kohta

Measure
        │
        └── arvutatakse vastavalt
            aktiivsele filtrikontekstile
```

Mõõdikud võimaldavad luua dünaamilisi KPI-sid, mis reageerivad raporti filtritele ja sliceritele.

Näiteks saab mõõdikutega arvutada:

- kogukäivet;
- keskmist tellimuse väärtust;
- tehingute arvu;
- kasvumäära;
- osakaalusid.

---

## Interaktiivsus

Dashboard'i loomisel õppisin, et Power BI visualiseeringute omavahelisi seoseid tuleb teadlikult juhtida.

Kõik visualiseeringud ei pea tingimata kõiki teisi visuaale filtreerima.

Näiteks võib olla vajalik, et:

- detailne diagramm filtreerib teist analüüsidiagrammi;
- KPI kaart jääb samal ajal muutumatuks ja näitab kogu vaate koondnäitajat.

Selline interaktsioonide seadistamine muudab raporti kasutaja jaoks arusaadavamaks ja väldib eksitavat konteksti.

---

## Dashboard'i viimistlemine

Week 6 eesmärk oli muuta dashboard prototüübist professionaalsemaks analüüsivahendiks.

Viimistlemisel pöörasin tähelepanu:

- visuaalsele hierarhiale;
- KPI-de nähtavusele;
- selgetele diagrammipealkirjadele;
- ühtsele värvikasutusele;
- annotatsioonide paigutusele;
- viitejoonte kasutamisele;
- üleliigse visuaalse müra vähendamisele;
- ühe ekraani põhimõttele.

Dashboard peab võimaldama kasutajal kõige olulisema olukorra kiiresti ära tunda.

---

## Mida õppisin

Week 6 jooksul õppisin:

- muutma dashboard'i visualiseeringud terviklikuks andmelooks;
- looma asukohapõhiseid dashboard'e;
- analüüsima hooajalisust;
- eristama fakti ja analüütilist hüpoteesi;
- kasutama annotatsioone oluliste muutuste selgitamiseks;
- kasutama viitejooni tulemuste konteksti asetamiseks;
- koostama juhtidele mõeldud lühikokkuvõtet;
- rakendama „Ja mis siis?” põhimõtet;
- siduma andmetest saadud tulemuse võimaliku ärilise tegevusega;
- kasutama DAX mõõdikuid;
- juhtima visualiseeringute interaktsioone;
- struktureerima mitme lehega Power BI raportit;
- viimistlama raportit stakeholder'ile sobivaks.

Kõige olulisem õppetund oli, et professionaalne dashboard ei piirdu numbrite ja diagrammidega.

**Hea dashboard aitab kasutajal mõista, mis toimub, miks see võib oluline olla ja milline võiks olla järgmine tegevus.**

---

## Äriline tähendus

Pärnu analüüs näitas, et hooajalisus on oluline, kuid seda ei tohiks käsitleda ainsa müüki mõjutava tegurina.

```text
Müügitulemus
     │
     ├── hooajalisus
     ├── külastatavus
     ├── keskmine ostukorv
     ├── tootevalik
     ├── kohalik turundus
     └── konkurents
```

Dashboard aitab tuvastada **millal** muutus toimub.

Selleks, et selgitada **miks** see toimub, võib olla vaja täiendavaid andmeid.

See eristus on oluline, sest visualiseeringus nähtav korrelatsioon ei tõesta automaatselt põhjuslikku seost.

---

## Week 6 failid

Soovituslik portfoolio struktuur:

```text
week-6/
│
├── README.md
│
├── individual/
│   ├── urbanstyle_week6_dashboard_Rene.pbix
│   ├── Dashboard_screenshot.png
│   ├── urbanstyle_dashboard_export.pdf
│   ├── week6_parnu_narrative.md
│   └── week6_executive_summary.md
│
└── team/
    └── week6_team_combined_view.md
```

### Power BI tööfail

[`individual/urbanstyle_week6_dashboard_Rene.pbix`](individual/urbanstyle_week6_dashboard_Rene.pbix)

Power BI raport sisaldab UrbanStyle'i nelja asukohavaadet:

- Pärnu;
- Tallinn;
- Tartu;
- Online.

Minu individuaalne ülesanne oli **Roll C — Pärnu kaupluse dashboard ja narratiiv**.

### Pärnu dashboard

[`individual/week6_parnu_dashboard_screenshot.png`](individual/week6_parnu_dashboard_screenshot.png)

Ekraanipilt minu Pärnu dashboard'ist.

[`individual/urbanstyle_dashboard_export.pdf`](individual/urbanstyle_dashboard_export.pdf)

PDF kujul väljavõte minu koostatud Power BI dashboardidest.

### Andmelugu

[`individual/week6_parnu_narrative.md`](individual/week6_parnu_narrative.md)

Pärnu analüüsi põhjal koostatud lühike andmelugu.

### Executive Summary

[`individual/week6_executive_summary.md`](individual/week6_executive_summary.md)

Pärnu dashboard'i peamised järeldused juhtidele.

---

## Meeskonnatöö

Meeskonnatöö käigus analüüsiti UrbanStyle'i nelja asukohta eraldi ning tulemused ühendati terviklikuks koondvaateks.

Analüüs hõlmas:

- Tallinna kauplust;
- Tartu kauplust;
- Pärnu kauplust;
- e-poodi.

Minu panus oli:

**Roll C — Pärnu kaupluse dashboard + narratiiv**

[`team/week6_team_combined_view.md`](team/week6_team_combined_view.md)

Week 6 meeskonnatöö lühikokkuvõte ja viide ühisele väljundile.

**Meeskonna ühine töö:**  
[Lisa siia meeskonna GitHubi / Google Slides / ühise töö link]

---

## AI kasutamine

Week 6 jooksul kasutasin AI-d Power BI visualiseeringute, DAX-i ja dashboard'i ülesehituse kontrollimiseks ning Pärnu andmeloo ja äriliste järelduste täpsustamiseks.

AI aitas genereerida ja hinnata võimalikke selgitusi, kuid eristasin andmetest kinnitatud tulemused hüpoteesidest ning kontrollisin lõplikud järeldused Power BI-s olemasolevate andmete põhjal.

---

## Kokkuvõte

Week 6 jooksul liikusin dashboard'i loomisest edasi andmeloo jutustamise juurde.

Minu individuaalne Roll C keskendus Pärnu kauplusele, kus analüüsi peamine teema oli hooajalisus. Dashboard näitas augustikuist müügitippu, jaanuari madalseisu ning seda, et suvekuud moodustavad ligikaudu 30% aastamüügist.

Annotatsioonide, KPI-de ja viitejoonte abil muutus dashboard lihtsast visualiseeringute kogumist ärilist konteksti selgitavaks analüüsiks.

Week 6 kõige olulisem õppetund oli, et **andmeanalüütiku töö ei lõpe küsimusega „mida andmed näitavad?”, vaid jätkub küsimustega „miks see on oluline?” ja „mida peaksime nüüd tegema?”**.
