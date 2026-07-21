# Import úloh CERMAT do GoMathu (anonymní Apex)

Tato složka obsahuje **hotové anonymní Apex skripty** pro import úloh z didaktických
testů CERMAT (Jednotná přijímací zkouška, matematika, čtyřleté obory) do GoMathu –
podle návodu *„Návod: generování Apex skriptu pro import úloh"*.

## Co je hotové

Zdroj: <https://prijimacky.cermat.cz/menu/testova-zadani-k-procvicovani/testova-zadani-v-pdf/ctyrlete-obory-matematika>

| Test | Termín | Kód testu | Úloh | Souborů |
|---|---|---|---|---|
| **M9A 2026** | 1. řádný | M9PAD26C0T01 | — | *už naimportováno dříve (přeskočeno)* |
| **M9B 2026** | 2. řádný | M9PBD26C0T02 | 16 | `import-cermat-M9B-2026-cast1..8.apex` |
| **M9C 2026** | 1. náhradní | M9PCD26C0T03 | 16 | `import-cermat-M9C-2026-cast1..9.apex` |
| **M9D 2026** | 2. náhradní | M9PDD26C0T04 | 16 | `import-cermat-M9D-2026-cast1..9.apex` |

Celkem **48 úloh** (kompletní testy včetně geometrie, konstrukcí, grafů a tabulek).
Starší ročníky (2025, 2024, … 2015) jsou připravené ke zpracování stejnou cestou –
viz `generator/`.

## Jak spustit

1. **Workbench → utilities → Apex Execute.**
2. Vlož obsah jednoho souboru `…-castN.apex` a klikni **Execute**.
3. V logu zkontroluj `System.debug('Vytvořeno úloh: …')`.
4. Opakuj pro **všechny části** daného testu (cast1, cast2, …). Části jsou nezávislé
   a **idempotentní** – úloha, jejíž `Name` už existuje, se přeskočí, takže se dají
   spouštět opakovaně bez duplicit.

Pořadí testů ani částí nehraje roli. Nejdřív musí být v orgu jednou spuštěný
`seed-taxonomy.apex` (naplní fasety a taxony), jinak se úlohy založí bez taxonomie.

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
částí; úlohy s velkým obrázkem (graf, hranol) mají vlastní část, která může být
~9–11 KB. To je pod skutečným limitem anonymního Apexu (řádově > 100 KB), takže
spuštění projde; ~9 KB v návodu je bezpečná rezerva, ne tvrdý limit.

## Regenerace / další ročníky (`generator/`)

Úlohy se píšou v Pythonu s **přirozeným LaTeXem** (raw stringy); generátor sám zdvojí
`\`, ošetří `'`, ověří párování `$…$` a platnost JSON a rozdělí výstup do částí.

```
generator/
  fig.py              # PDF region → kompaktní čisté SVG (vektory + popisky)
  gen.py              # kostra + validace + rozdělení do -castN.apex
  build_M9B_2026.py   # data testu B (2. řádný 2026)
  build_M9C_2026.py   # data testu C (1. náhradní 2026)
  build_M9D_2026.py   # data testu D (2. náhradní 2026)
```

Spouští se z kořene repozitáře (potřebuje `pymupdf`, `cairosvg` a stažené PDF
v `work/pdf/`), např. `python3 scripts/apex/generator/build_M9B_2026.py`.
Odpovědi jsou ověřené proti oficiálnímu *Klíči správných řešení* (KSR) daného testu.
