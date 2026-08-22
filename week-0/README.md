# Nädal 0 — Andmeanalüüsi töökeskkonna seadistamine

> **DACA — Andmeanalüütiku Karjäärikiirendi**  
> Arenduskeskkonna seadistamine, tööriistade liidestamine ja meeskonna onboarding.

## Ülevaade

Nädal 0 eesmärk oli luua tehniline alus järgnevateks andmeanalüüsi projektideks.

Seadistasin ja tutvusin töövahenditega, mida kasutatakse programmi jooksul andmebaasidega töötamiseks, SQL- ja Python-analüüsiks, versioonihalduseks ning projektide avaldamiseks.

Töökeskkonna eesmärk on ühendada erinevad tööriistad üheks terviklikuks andmeanalüüsi töövooks.

## Kasutatavad tehnoloogiad

| Tööriist | Kasutus |
|---|---|
| **Supabase / PostgreSQL** | Andmebaas ja andmete säilitamine |
| **Visual Studio Code** | Peamine arenduskeskkond |
| **SQLTools** | SQL päringute käivitamine VS Code'ist |
| **Python** | Andmete töötlemine ja analüüs |
| **Jupyter Notebook** | Interaktiivne Python-analüüs |
| **Git** | Lokaalne versioonihaldus |
| **GitHub** | Koodi, projektide ja portfoolio haldus |
| **NotebookLM** | Allikapõhine AI õppe- ja uurimiskeskkond |
| **Vercel** | Veebiprojektide deployment ja avaldamine |

---

## Töökeskkonna ülesehitus

Õppeprojektide jaoks loodud keskkond võimaldab liikuda andmebaasis olevatest lähteandmetest analüüsi ja versioonihalduseni.

```text
              Supabase / PostgreSQL
                       │
                       ▼
                    SQLTools
                       │
                       ▼
                   VS Code
              ┌────────┼────────┐
              │        │        │
             SQL     Python   Jupyter
              │        │        │
              └────────┼────────┘
                       │
                      Git
                       │
                       ▼
                    GitHub
                       │
                       ▼
                    Vercel
```

Selline ülesehitus võimaldab hoida SQL päringud, Python-koodi, dokumentatsiooni ja versioonihalduse ühe projekti sees.

---

## 1. Visual Studio Code

Visual Studio Code seadistasin peamiseks arenduskeskkonnaks.

VS Code'i kasutan programmi jooksul:

- SQL päringute kirjutamiseks;
- Python-koodi kirjutamiseks;
- Jupyter Notebook'idega töötamiseks;
- Git versioonihalduseks;
- andmebaasiühenduste kasutamiseks;
- projekti failide ja dokumentatsiooni haldamiseks.

Ühe keskse arenduskeskkonna kasutamine võimaldab hallata SQL-i, Pythonit, dokumentatsiooni ja Git'i samas projektis.

---

## 2. Git ja GitHub

Git´i seadistasin lokaalseks versioonihalduseks ning ühendasin GitHubiga.

GitHubis asub minu DACA õppeportfoolio:

```text
daca-portfolio/
│
├── week-0/
│   ├── README.md
│   ├── individual/
│   └── team/
│
└── ...
```

Õppeprojektides kasutan tavapärast Git töövoogu:

```bash
git status
git add
git commit
git push
```

GitHub võimaldab säilitada projektide ajalugu ning jälgida portfoolio arengut nädalate kaupa.

---

## 3. Supabase / PostgreSQL

Supabase on programmi andmebaasikeskkond, mis põhineb PostgreSQL-il.

Seda kasutatakse:

- andmete säilitamiseks;
- andmebaasi tabelite uurimiseks;
- SQL päringute tegemiseks;
- andmekvaliteedi kontrollimiseks;
- analüüsiks vajalike andmete leidmiseks.

SQL päringuid saab käivitada nii Supabase SQL Editoris kui ka VS Code'i kaudu.

---

## 4. SQLTools ja Supabase liidestamine

VS Code'i paigaldasin SQLTools ning lõin ühenduse Supabase PostgreSQL andmebaasiga.

```text
Supabase / PostgreSQL
          │
          │ andmebaasiühendus
          ▼
       SQLTools
          │
          ▼
       VS Code
          │
          ▼
      SQL failid
```

See võimaldab kirjutada ja käivitada SQL päringuid otse VS Code'is.

SQL päringud saab salvestada `.sql` failidena ning lisada Git versioonihaldusse koos ülejäänud projektiga.

---

## 5. Python keskkond

Pythoni seadistasin järgnevate andmeanalüüsi ülesannete jaoks.

Projektides kasutatakse eraldi virtuaalkeskkonda (`venv`), et projekti Python paketid oleksid süsteemi üldisest Python keskkonnast eraldatud.

Näiteks:

```text
project/
│
├── venv/
├── .env
├── analysis.py
├── notebook.ipynb
└── requirements.txt
```

Lokaalsed keskkonnafailid ja tundlikku infot sisaldavad failid jäetakse Git versioonihaldusest välja `.gitignore` abil.

```gitignore
venv/
.env
*.pyc
__pycache__/
```

See aitab vältida virtuaalkeskkonna failide ja võimalike ligipääsuandmete sattumist GitHubi.

---

## 6. Jupyter Notebook

Jupyter Notebooki seadistasin kasutamiseks VS Code'i sees.

Notebook'i kerneliks saab valida projekti Python virtuaalkeskkonna.

```text
VS Code
   │
   ├── Python
   │
   └── Jupyter Notebook
             │
             ▼
        Python venv
```

Jupyter Notebook võimaldab kombineerida:

- Python-koodi;
- analüüsi tulemusi;
- selgitavat teksti;
- hiljem ka visualiseeringuid.

See loob aluse dokumenteeritud ja korratavale andmeanalüüsile.

---

## 7. NotebookLM — minu Week 0 meeskonnaroll

Minu peamine roll Week 0 meeskonnatöös oli:

**C — NotebookLM Seadistaja**

Ülesandeks oli luua meeskonnale ühine NotebookLM õppekeskkond, mis kasutab vastuste koostamisel etteantud õppematerjale.

### Tehtud tegevused

- lõin meeskonna NotebookLM notebook'i;
- lisasin 4 CORE RAG lähtefaili;
- kontrollisin allikate töötlemist;
- genereerisin Audio Overview;
- testisin NotebookLM-i küsimustega;
- jagasin notebook'i meeskonnaga.

NotebookLM ülesanne aitas mõista allikapõhise AI kasutamist, kus vastuseid saab kontrollida konkreetsete alusdokumentide põhjal.

---

## 8. Vercel

Vercel kuulub programmi laiemasse arendustööriistade komplekti ning võimaldab veebipõhiseid projektiväljundeid avaldada.

Planeeritud töövoog:

```text
Lokaalne arendus
       │
       ▼
    VS Code
       │
       ▼
      Git
       │
       ▼
    GitHub
       │
       ▼
    Vercel
       │
       ▼
Avaldatud projekt
```

GitHubi ja Verceli ühendamine võimaldab tulevikus viia analüüsiprojekti lokaalsest arenduskeskkonnast avalikult ligipääsetava veebilahenduseni.

---

## Tööriistade omavaheline seos

Week 0 oluline õppetund oli mõista, et kasutatavad programmid ei ole eraldiseisvad tööriistad, vaid moodustavad ühise töövoo.

| Ühendus | Eesmärk |
|---|---|
| Supabase → SQLTools | Ligipääs PostgreSQL andmebaasile |
| SQLTools → VS Code | SQL päringute kirjutamine ja käivitamine |
| Python → VS Code | Andmete töötlemine ja analüüs |
| Jupyter → Python venv | Interaktiivne analüüs |
| VS Code → Git | Muudatuste versioonihaldus |
| Git → GitHub | Projekti ajaloo ja portfoolio säilitamine |
| GitHub → Vercel | Projekti deployment ja avaldamine |

---

## Mida õppisin

Week 0 keskendus eelkõige tervikliku andmeanalüüsi töökeskkonna mõistmisele ja seadistamisele.

Peamised õpikohad:

- arenduskeskkonna struktureeritud seadistamine;
- Git'i ja GitHubi kasutamine versioonihalduseks;
- VS Code'i ühendamine PostgreSQL andmebaasiga;
- SQLTools kasutamine;
- Python virtuaalkeskkonna seadistamine;
- Jupyter Notebook'i kasutamine VS Code'is;
- `.gitignore` kasutamine;
- ligipääsuandmete GitHubist eemal hoidmine;
- NotebookLM kasutamine allikapõhise AI tööriistana;
- erinevate tööriistade ühendamine terviklikuks töövooks.

Week 0 lõpptulemus oli tehniline alus, millele järgnevad SQL-i, Pythoni ja andmeanalüüsi portfoolioprojektid.

---

## Week 0 portfoolio struktuur

```text
week-0/
│
├── README.md
│
├── individual/
│   └── setup_screenshot.png
│
└── team/
    └── week0_team_summary.md
```

### Individuaalne töö

[`individual/setup_screenshot.png`](individual/setup_screenshot.png) 
Week 0 keskkonna seadistamise ekraanipilt.

### Meeskonnatöö

[`meeskonna töö viide week-0`](https://github.com/laura-johanson/urbanstyle-marketing-data/blob/f0f614533c8ed373a3f82aa2332dfdbc6509f5e0/week%200)


 

