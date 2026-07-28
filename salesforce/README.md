# GoMath — dávkový import úloh z GitHubu

Deploy balík s třídou `GoMathGitImport`: batch, který stáhne vygenerované anonymní
Apex skripty z tohoto repozitáře (`scripts/apex/**.apex`) a spustí je v orgu.

Aktuálně je v repu **2 103 úloh** v **801 skriptech** (Zelený 233 / CERMAT 1 870, ročníky 2015–2026).

## Jak to funguje

```
GitHub API ──(1) výpis .apex souborů──┐
                                      ▼
                            GoMathGitImport (Batch, scope = 1)
                                      │
              (2) stáhne obsah souboru┤
                                      │
              (3) executeAnonymous ───┴──► Apex SOAP API vlastního orgu
```

- **scope = 1** je záměr: každý soubor jde přes `executeAnonymous`, tedy do **vlastní
  transakce** s vlastními governor limity. Limity se tak nesčítají napříč 801 skripty.
- **SOAP, ne Tooling REST**: skripty mají až ~9 KB a v REST variantě se kód předává
  v URL — po enkódování by překročil limit délky URI.
- **Idempotence**: skripty samy přeskakují úlohy, které už v orgu jsou (podle
  `Math_Problem__c.Name`). Opakované spuštění nic nezduplikuje, takže batch lze bez
  obav pustit znovu po opravě chyb.
- Chyba jednoho souboru **nezhavaruje** celý job — zaznamená se do `failures`
  a vypíše v `finish()`.

## Nasazení

```bash
sf project deploy start -d salesforce/force-app -o <alias-orgu>
# nebo přes manifest:
sf project deploy start -x salesforce/manifest/package.xml -o <alias-orgu>
```

## Nastavení před prvním spuštěním

### 1. Named Credential `GoMath_Self` (volání vlastního orgu)

Potřeba proto, že v asynchronním Apexu nelze použít `UserInfo.getSessionId()` pro API volání.

1. Setup → **App Manager** → New Connected App
   - Enable OAuth Settings, Callback URL `https://login.salesforce.com/services/oauth2/callback`
   - Scopes: `Manage user data via APIs (api)`, `Perform requests at any time (refresh_token, offline_access)`
   - Po uložení si poznač **Consumer Key** a **Consumer Secret**
2. Setup → **Auth. Providers** → New → typ **Salesforce**
   - Consumer Key/Secret z kroku 1, Default Scopes: `api refresh_token offline_access`
   - Ulož a poznač si vygenerovanou **Callback URL** → vrať ji do Connected App
3. Setup → **Named Credentials** → New Legacy
   - Label/Name: `GoMath_Self`
   - URL: My Domain URL orgu, např. `https://mojefirma.my.salesforce.com`
   - Identity Type: **Named Principal**, Authentication Protocol: **OAuth 2.0**
   - Authentication Provider: z kroku 2, **Start Authentication Flow on Save** ✔
   - **Allow Merge Fields in HTTP Body** ✔ ← nutné, třída vkládá `{!$Credential.OAuthToken}`
     do SOAP hlavičky
   - Generate Authorization Header: může zůstat vypnuté

> Uživatel, kterým se flow autorizuje, musí mít práva na vytváření
> `Math_Problem__c` / `Problem_Version__c` / `Problem_Taxon__c` a na ContentVersion.

### 2. Přístup na GitHub

**Veřejný repozitář** (současný stav) — stačí nasazený Remote Site Setting `GitHub_API`
a v Execute Anonymous přepnout základ na přímou URL:

```apex
GoMathGitImport.GITHUB_BASE = 'https://api.github.com';
GoMathGitImport.run();
```

**Privátní repozitář** — Named Credential `GoMath_GitHub`:
- URL: `https://api.github.com`
- Identity Type: Named Principal, Authentication Protocol: **Password Authentication**
- Username: GitHub login, Password: Personal Access Token (scope `repo`)
- Custom header `Authorization` = `Bearer {!$Credential.Password}` (Generate Authorization Header vypnout)

Pak není potřeba nic přepínat — třída míří na `callout:GoMath_GitHub` ve výchozím stavu.

## Spuštění

Developer Console → Debug → **Open Execute Anonymous Window**:

```apex
// 1) nanečisto — ověří přístup a stáhne soubory, ale nic nevytvoří
GoMathGitImport.dryRun();

// 2) jeden test na zkoušku
GoMathGitImport.run('cermat/import-cermat-M5A-2026');

// 3) celý CERMAT
GoMathGitImport.run('scripts/apex/cermat/');

// 4) úplně všechno (Zelený + CERMAT, 801 souborů)
GoMathGitImport.run();

// varianta s e-mailovým souhrnem a jinou větví
GoMathGitImport b = new GoMathGitImport();
b.branch = 'main';
b.notifyEmail = 'ales.jenik@gmail.com';
Database.executeBatch(b, 1);
```

Průběh: Setup → **Apex Jobs**. Souhrn (`X OK, Y chyb`) je v debug logu z `finish()`,
případně v e-mailu.

## Parametry

| Pole | Výchozí | Význam |
|---|---|---|
| `repoOwner` / `repoName` | `alesjenik-ops` / `gomath-problems` | zdrojový repozitář |
| `branch` | `claude/prepare-task-imports-sejoir` | větev |
| `pathPrefix` | `scripts/apex/` | prohledávaná složka |
| `fileFilter` | – | zpracují se jen cesty obsahující tento řetězec |
| `dryRunOnly` | `false` | jen stáhnout, nespouštět |
| `notifyEmail` | – | komu poslat souhrn |
| `GITHUB_BASE` (static) | `callout:GoMath_GitHub` | lze přepnout na `https://api.github.com` |
| `SELF_BASE` (static) | `callout:GoMath_Self` | Named Credential vlastního orgu |

## Předpoklady v orgu

Objekty `Math_Problem__c`, `Problem_Version__c`, `Problem_Taxon__c`, `Taxon__c`,
třída `GoMathContent` (metoda `buildSearchText`) a na `Problem_Version__c` pole
`CERMAT_Code__c` (Text) a `Source_Year__c` (Number) — viz `scripts/README.md`.

## Odhad doby běhu

801 souborů × (stažení + executeAnonymous) ≈ jednotky hodin. Batch běží na pozadí,
lze ho kdykoli zastavit (Apex Jobs → Abort) a spustit znovu — už naimportované
úlohy se přeskočí.

## Alternativa bez callloutů

Pokud by nastavení Named Credentialu bylo na obtíž, skripty jdou pořád spouštět ručně
přes Workbench (Apex Execute) nebo z příkazové řádky:

```bash
for f in scripts/apex/cermat/*.apex; do sf apex run -f "$f" -o <alias>; done
```
