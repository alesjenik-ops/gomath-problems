# Import úloh CERMAT do GoMathu (anonymní Apex)

Tato složka obsahuje **hotové anonymní Apex skripty** pro import úloh z didaktických
testů CERMAT (Jednotná přijímací zkouška, matematika, čtyřleté obory) do GoMathu –
podle návodu *„Návod: generování Apex skriptu pro import úloh"*.

## Co je hotové

Zdroj: <https://prijimacky.cermat.cz/menu/testova-zadani-k-procvicovani/testova-zadani-v-pdf/ctyrlete-obory-matematika>

Každý test má soubory `import-cermat-<TEST>-castN.apex` (např. `M9B-2026`).
**Zpracován celý dostupný český archiv 2015–2026** (matematika 9, čtyřleté obory).

| Test | Termín | Kód testu | Úloh |
|---|---|---|---|
| **M9A 2026** | 1. řádný | M9PAD26C0T01 | *už naimportováno dříve (přeskočeno)* |
| **M9B 2026** | 2. řádný | M9PBD26C0T02 | 16 |
| **M9C 2026** | 1. náhradní | M9PCD26C0T03 | 16 |
| **M9D 2026** | 2. náhradní | M9PDD26C0T04 | 16 |
| **M9A 2025** | 1. řádný | M9PAD25C0T01 | 16 |
| **M9B 2025** | 2. řádný | M9PBD25C0T02 | 16 |
| **M9C 2025** | 1. náhradní | M9PCD25C0T03 | 16 |
| **M9D 2025** | 2. náhradní | M9PDD25C0T04 | 16 |
| **M9A 2024** | 1. řádný | M9PAD24C0T01 | 16 |
| **M9B 2024** | 2. řádný | M9PBD24C0T02 | 16 |
| **M9C 2024** | 1. náhradní | M9PCD24C0T03 | 16 |
| **M9D 2024** | 2. náhradní | M9PDD24C0T04 | 16 |
| **M9A 2023** | 1. řádný | M9PAD23C0T01 | 16 |
| **M9B 2023** | 2. řádný | M9PBD23C0T02 | 16 |
| **M9C 2023** | náhradní | M9PCD23C0T03 | 16 |
| **M9D 2023** | druhý náhradní | M9PDD23C0T04 | 16 |
| **M9A 2022** | 1. řádný | M9PAD22C0T01 | 16 |
| **M9B 2022** | 2. řádný | M9PBD22C0T02 | 16 |
| **M9C 2022** | náhradní | M9PCD22C0T03 | 16 |
| **M9D 2022** | druhý náhradní | M9PDD22C0T04 | 16 |
| **M9A 2021** | 1. řádný | M9PAD21C0T01 | 16 |
| **M9B 2021** | 2. řádný | M9PBD21C0T02 | 16 |
| **M9C 2021** | náhradní | M9PCD21C0T03 | 16 |
| **M9D 2021** | druhý náhradní | M9PDD21C0T04 | 16 |
| **M9A 2020** | řádný (jediný, COVID) | M9PAD20C0T01 | 16 |
| **M9A 2019** | 1. řádný | M9PAD19C0T01 | 16 |
| **M9B 2019** | 2. řádný | M9PBD19C0T02 | 16 |
| **M9B 2017** | 2. řádný | M9PBD17C0T02 | 16 |
| **M9A 2015** | řádný | M9PZD15C0T01 | 17 |
| **M9I 2021** | ilustrační test | M9PID21C0T01 | 16 |
| **M9I 2020** | ilustrační test | M9PID20C0T01 | 16 |
| **M9I 2019** | ilustrační test | M9PID19C0T01 | 16 |
| **M9I 2018** | ilustrační test | M9PID18C0T01 | 16 |

Celkem **32 testů / 513 úloh** (kompletní testy včetně geometrie, konstrukcí,
grafů a tabulek). Odpovědi každé úlohy jsou ověřené proti oficiálnímu *Klíči
správných řešení* daného testu.

### Co v archivu chybí a proč

- **M9A 2017, M9A/M9B 2018, 2016 (řádné termíny):** CERMAT k nim na webu
  nezveřejnil český klíč správných řešení. Bez oficiálního klíče nelze odpovědi
  spolehlivě ověřit, proto tyto testy nejsou zahrnuty (zadání by šla přepsat, ale
  správnost odpovědí by nebyla garantovaná). Ilustrační testy 2018–2021 klíč mají,
  a jsou proto zpracované.
- **Ukrajinské a polské překlady** novějších ročníků jsou vynechány záměrně
  (import je pouze český).

### Poznámka k obrázkům a starším PDF

Část obrázků (grafy, perspektivní 3D náčrty, rastrové ikony) nejde vyříznout jako
čisté vektorové SVG. V takových případech jsou potřebná data (hodnoty grafu, úhly,
rozměry, tabulky) uvedena přímo v textu zadání i řešení, takže úloha zůstává plně
řešitelná; konstrukční a vektorové obrázky se extrahují jako SVG. U některých
starších testů (2015, 2017, 2018 ilustrační) mají popisky ve fontu privátní/řídicí
znaky, které by rozbily XML – tyto popisky se z SVG odstraní (nebo přemapují na
správný Unicode) a jejich obsah je popsán v textu.

## Jak spustit

Nejdřív musí být v orgu **jednou** spuštěný `seed-taxonomy.apex` (naplní fasety
a taxony), jinak se úlohy založí bez taxonomie. Pořadí testů ani částí nehraje roli
a všechny části jsou **idempotentní** – úloha, jejíž `Name` už existuje, se přeskočí,
takže se dají spouštět opakovaně bez duplicit.

Každý soubor `…-castN.apex` je **samostatný anonymní Apex** (má vlastní třídu `C`).
Nelze je proto slepit do jednoho běhu – spouští se jeden po druhém.

### A) Všechno najednou přes Salesforce CLI (doporučeno)

Nejjednodušší způsob, jak dostat celý archiv do orgu jedním příkazem:

```bash
# 1) jednorázové přihlášení do orgu (otevře prohlížeč)
sf org login web --alias gomath

# 2) jednou taxonomie (máte-li seed soubor po ruce)
sf apex run --file cesta/k/seed-taxonomy.apex --target-org gomath

# 3) všech 200 částí najednou
scripts/apex/run-all.sh gomath
```

`run-all.sh` projede všechny soubory `import-cermat-*.apex`, každý spustí jako
anonymní Apex (`sf apex run`, případně starší `sfdx force:apex:execute`), vypisuje
průběh `[i/200]` a na konci shrne případné chyby. Protože je vše idempotentní, dá se
skript po opravě klidně spustit znovu. (Salesforce CLI: <https://developer.salesforce.com/tools/salesforcecli>.)

### B) Automaticky z GitHubu (GitHub Actions)

V repu je workflow `.github/workflows/import-cermat.yml`, který se sám připojí
k repu (stáhne apexy), přihlásí se do orgu a spustí import – **spouští se ručně
tlačítkem**, nikdy nesjede sám.

Nastavení (jednorázově):

1. Získej přihlašovací URL svého orgu lokálně:
   ```bash
   sf org login web --alias gomath
   sf org display --target-org gomath --verbose --json
   ```
   Zkopíruj hodnotu `sfdxAuthUrl` (začíná `force://…`).
2. Na GitHubu: **Settings → Secrets and variables → Actions → New repository secret**,
   jméno **`SFDX_AUTH_URL`**, hodnota = to zkopírované `force://…`.
3. **Actions → „Import CERMAT úloh do Salesforce" → Run workflow.** (Volitelně
   zaškrtni seed taxonomie, je-li `seed-taxonomy.apex` v repu.)

> ⚠️ **Repo je veřejné.** `SFDX_AUTH_URL` je přihlašovací tajemství k tvému orgu –
> **nikdy ho nedávej do souboru ani commitu**, jen do *Actions Secrets* (ty se
> v logu ani forkům nezobrazí). Kdyby přesto uniklo, hned zneplatni:
> `sf org logout --target-org gomath`. Samotné `.apex` soubory nic citlivého
> neobsahují, veřejné být můžou.

### C) Ručně přes Workbench (bez CLI)

1. **Workbench → utilities → Apex Execute.**
2. Vlož obsah jednoho souboru `…-castN.apex` a klikni **Execute**.
3. V logu zkontroluj `System.debug('Vytvořeno úloh: …')`.
4. Opakuj pro **všechny části** daného testu (cast1, cast2, …).

## Co skript nastavuje

Každá úloha → `Math_Problem__c` + jedna publikovaná `Problem_Version__c`
(`Status__c='Publikováno'`, `Visibility__c='Organizace'`, `Answer_Type__c='Text'`),
M:N vazby `Problem_Taxon__c` na taxonomii a u obrázkových úloh `ContentVersion`
(SVG) + `ContentDocumentLink`.

CERMAT metadata:

- `Source_Type__c = 'CERMAT'`
- `Source__c` = např. `CERMAT – Jednotná přijímací zkouška 2026, 2. řádný termín (M9B)`
- `CERMAT_Code__c` = kód testového sešitu (např. `M9PBD26C0T02`)
- `Source_Year__c` = `2026`
- `License__c = 'Jiná'` (autorská práva CZVV)

> **Pozn. k polím `CERMAT_Code__c` a `Source_Year__c`:** návod je pro CERMAT úlohy
> předepisuje. Pokud by v orgu neexistovala, skript se nezkompiluje – pak stačí
> v `generator/gen.py` (v `HEADER` a v podpisu metody `add`) tyto dva sloupce odebrat
> a znovu vygenerovat, nebo je ručně smazat z řádku `Problem_Version__c(... )` v `.apex`.

## Obrázky

Geometrie, grafy, náčrty i tabulka jsou **věrné předlohy vyříznuté z originálního
PDF jako vektorové SVG** (přesná geometrie, žádné hádání), přegenerované do
kompaktního tvaru bez fontového balastu, bez `'` a `\` (bezpečné do Apex literálu).
Konstrukční úlohy obsahují výchozí obrázek se zadanými body; jako „odpověď" je uveden
popis konstrukce (typ *Konstrukce nebo důkaz* v jednotném textovém formátu).

## Velikost souborů

Návod doporučuje držet skripty pod ~9 KB. Textové úlohy jsou seskupené do sdílených
částí; úloha s velkým obrázkem (síť tělesa, hustá mřížka, věž se schodišti) má vlastní
část, která může být ~11–13 KB. To je hluboko pod skutečným limitem anonymního Apexu
(řádově > 100 KB), takže spuštění projde; ~9 KB v návodu je bezpečná rezerva, ne tvrdý
limit.

## Regenerace / další ročníky (`generator/`)

Úlohy se píšou v Pythonu s **přirozeným LaTeXem** (raw stringy); generátor sám zdvojí
`\`, ošetří `'`, ověří párování `$…$` a platnost JSON a rozdělí výstup do částí.

```
generator/
  fig.py                # PDF region → kompaktní čisté SVG (vektory + popisky)
  gen.py                # kostra + validace + rozdělení do -castN.apex
  build_M9<X>_<rok>.py  # data jednoho testu (jeden soubor na test)
```

Pro každý test existuje jeden `build_…py` (např. `build_M9B_2026.py`,
`build_M9A_2015.py`, `build_M9I_2019.py`). Spouští se z kořene repozitáře
(potřebuje `pymupdf`, `cairosvg` a stažené PDF v `work/pdf/`), např.
`python3 scripts/apex/generator/build_M9B_2026.py`. Skript ověří párování `$…$`,
platnost JSON, rozdělí výstup do částí a přepíše odpovídající `import-cermat-…apex`.
Odpovědi jsou ověřené proti oficiálnímu *Klíči správných řešení* (KSR) daného testu.
