# Week 8 - Team Python Data Pipeline

Meeskonna ühise töö käigus loodi UrbanStyle'i andmete töötlemiseks automatiseeritud Python-andmepipeline, mis laeb andmed Supabase'ist, puhastab ja töötleb need, koostab kokkuvõtted ning ekspordib tulemused failidesse.

Terviklik töövoog hõlmas:

- andmete laadimist Supabase'ist;
- andmete puhastamist ja valideerimist;
- müügi- ja kliendiandmete ühendamist;
- KPI-de ja nädalapõhiste koondnäitajate arvutamist;
- tulemuste visualiseerimist Plotly abil;
- tulemuste eksporti CSV- ja HTML-failidesse;
- kogu protsessi automatiseerimist ühe `pipeline.py` skripti abil;
- tegevuste ja võimalike vigade logimist.

## Minu panus

Minu ülesanne oli **Roll B - Data Processing** ehk `transform.py` faili loomine ja andmete töötlemise loogika ülesehitamine.

Minu vastutus oli müügiandmete puhastamine ja valideerimine, vigaste või puuduvate väärtuste eemaldamine, kuupäevade ja numbriliste väljade korrastamine ning müügi- ja kliendiandmete ühendamine edasiseks analüüsiks.

Lisaks koostasin transformatsiooni etapis nädalapõhised koondandmed ja KPI-d, mida kasutati hiljem visualiseerimisel ning eksporditavates väljundfailides.

## Meeskonna ühine väljund

Meeskonna lõpptulemuseks valmis modulaarne Python-andmepipeline, mille põhifailid olid:

- `data_fetcher.py` - andmete laadimine Supabase'ist;
- `transform.py` - andmete puhastamine, ühendamine ja töötlemine;
- `visualize_export.py` - visualiseerimine ning tulemuste eksport;
- `pipeline.py` - kogu töövoo käivitamine ja juhtimine;
- `config.yaml` - pipeline'i seadistuste hoidmine.

Pipeline'i käivitamisel luuakse automaatselt analüüsi tulemused CSV-failina, kaks HTML-visualiseeringut ning eraldi logifail pipeline'i töö jälgimiseks.

**Meeskonna lahendus:**
[Vaata Week 8 meeskonnatööd](lisa link)

**Näidisväljundid:**
[Vaata pipeline'i väljundeid](lisa link)
