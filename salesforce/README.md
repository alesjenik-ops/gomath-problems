# GoMath — dávkový import úloh z GitHubu

Deploy balík se dvěma cestami importu. **Doporučená je `GoMathJsonImport`** —
funguje bez Named Credentialů.

Aktuálně je v repu **2 103 úloh** (Zelený 233 / CERMAT 1 870, ročníky 2015–2026):
- `scripts/json/` — 112 JSON souborů (jeden test = jeden soubor) + `index.json`
- `scripts/apex/` — 801 anonymních Apex skriptů (< 9 KB, pro ruční spouštění)

## Doporučená cesta: GoMathJsonImport (bez Named Credentialů)

```
GitHub API ──(1) index.json──► GoMathJsonImport (Batch, scope = 1)
                 (2) stáhne JSON jednoho testu
                 (3) vloží záznamy přímo DML (žádný executeAnonymous)
```

- Jediný callout jde na `api.github.com` — pokrývá ho Remote Site Setting
  `GitHub_API`, který je součástí balíku. **Žádný Named Credential.**
- Jeden soubor = jeden test (max ~22 úloh) = jedna transakce: ~5 DML na úlohu,
  bezpečně pod limity.
- **Idempotence**: existující úlohy (podle `Math_Problem__c.Name`) se přeskočí.
- Chyba souboru job nezhavaruje — soubor se odroluje (savepoint) a chyba se
  vypíše ve `finish()`.

### Nasazení

```bash
sf project deploy start -d salesforce/force-app -o <alias-orgu>
```

(nebo Workbench → migration → Deploy s hotovým zipem)

### Spuštění (Developer Console → Execute Anonymous)

```apex
GoMathJsonImport.dryRun();               // ověří GitHub, nic nevloží
GoMathJsonImport.run('cermat-M5A_2026'); // jeden test na zkoušku
GoMathJsonImport.run('cermat-');         // celý CERMAT
GoMathJsonImport.run();                  // všech 2 103 úloh

// s e-mailovým souhrnem:
GoMathJsonImport b = new GoMathJsonImport();
b.notifyEmail = 'ales.jenik@gmail.com';
Database.executeBatch(b, 1);
```

Průběh: Setup → Apex Jobs. Souhrn (`X souborů OK, vytvořeno N úloh, …`) je
v debug logu z `finish()`, případně v e-mailu.

### Parametry (instanční pole — serializují se s jobem)

| Pole | Výchozí | Význam |
|---|---|---|
| `githubBase` | `https://api.github.com` | pro privátní repo `callout:GoMath_GitHub` |
| `repoOwner` / `repoName` | `alesjenik-ops` / `gomath-problems` | zdrojový repozitář |
| `branch` | `claude/prepare-task-imports-sejoir` | větev |
| `indexPath` | `scripts/json/index.json` | seznam souborů k importu |
| `fileFilter` | – | jen cesty obsahující tento řetězec |
| `dryRunOnly` | `false` | jen stáhnout a rozparsovat |
| `notifyEmail` | – | komu poslat souhrn |

### Regenerace JSON dat

```bash
python3 scripts/generator/export_json.py   # z data_*.py vyrobí scripts/json/*
```

## Alternativní cesta: GoMathGitImport (executeAnonymous)

Starší varianta: stahuje hotové `.apex` skripty a spouští je přes Apex SOAP API.
Vyžaduje Named Credential `GoMath_Self` (batch si musí volat vlastní org, protože
v asynchronním Apexu nelze použít session pro API volání). Postup nastavení:
Connected App → Auth Provider (typ Salesforce) → Named Credential `GoMath_Self`
(Named Principal, OAuth 2.0, **Allow Merge Fields in HTTP Body zapnuto**).
Detaily v historii tohoto souboru — pro běžné použití preferuj GoMathJsonImport.

## Předpoklady v orgu

Objekty `Math_Problem__c`, `Problem_Version__c`, `Problem_Taxon__c`, `Taxon__c`,
třída `GoMathContent` (metoda `buildSearchText`) a na `Problem_Version__c` pole
`CERMAT_Code__c` (Text) a `Source_Year__c` (Číslo) — viz `scripts/README.md`.

## Nouzová cesta bez čehokoli

```bash
git clone -b claude/prepare-task-imports-sejoir https://github.com/alesjenik-ops/gomath-problems
for f in gomath-problems/scripts/apex/**/*.apex; do sf apex run -f "$f" -o <alias>; done
```
