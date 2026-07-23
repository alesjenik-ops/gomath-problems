# Apex importy úloh (GoMath)

Generované anonymní Apex skripty pro import cvičných testů do GoMathu
(dle `importulohapexnavod.md`). Dva zdroje:
- **Matematika - Zelený** — 11 cvičných testů (`scripts/apex/`)
- **CERMAT – jednotná přijímací zkouška** — testy JPZ (`scripts/apex/cermat/`)

## Obsah — Matematika - Zelený

**11 cvičných testů** (A, B, C, D, E, F, G, H, J, K, L — písmeno „I" vynecháno),
celkem **233 GoMath úloh** v **69 souborech** (každý bezpečně < 9 KB).

| Test | úloh | soubory (`scripts/apex/`) |
|---|---|---|
| A | 13 | `import-zeleny-testA-cast1..4.apex` (jen úlohy 6–16, viz níže) |
| B | 22 | `import-zeleny-testB-cast1..6.apex` |
| C | 22 | `import-zeleny-testC-cast1..6.apex` |
| D | 22 | `import-zeleny-testD-cast1..7.apex` |
| E | 22 | `import-zeleny-testE-cast1..6.apex` |
| F | 22 | `import-zeleny-testF-cast1..6.apex` |
| G | 22 | `import-zeleny-testG-cast1..7.apex` |
| H | 22 | `import-zeleny-testH-cast1..7.apex` |
| J | 22 | `import-zeleny-testJ-cast1..7.apex` |
| K | 22 | `import-zeleny-testK-cast1..7.apex` |
| L | 22 | `import-zeleny-testL-cast1..6.apex` |

## Struktura

```
scripts/
├── apex/                      # hotové Apex skripty (Workbench → Apex Execute)
│   └── import-zeleny-test{A..L}-cast{1..N}.apex
└── generator/                 # Python generátor (kvůli spolehlivému escapování)
    ├── gen.py                 # kostra + skládání c.add(...) + dělení < 9 KB
    └── data_test{A..L}.py     # data úloh jednotlivých testů (+ SVG obrázky)
```

## Spuštění importu

Workbench → utilities → **Apex Execute** → vlož obsah jednoho `*.apex` → **Execute**.
V logu zkontroluj `System.debug('Vytvořeno úloh: …')`. Skripty jsou **idempotentní**
podle názvu úlohy (`Math_Problem__c.Name`, prefix `Zelený <písmeno><číslo>`) — opětovné
spuštění nic nezduplikuje. Části `-cast1..N` pouštěj samostatně (limit anonymního Apexu ~9 KB).

## Regenerace

```bash
cd scripts/generator
python3 data_testB.py     # zvaliduje ($ páry, JSON, SVG) a zapíše ./out/*.apex
```

## Rozdělení poduúloh

- **Izolované** poduúlohy (2.1/2.2, 3.1/3.2, 4.1/4.2, 5.1/5.2, 7.1/7.2/7.3 —
  nesouvisející „Vypočtěte") → samostatné úlohy.
- **Společný kontext** (výchozí text/obrázek/graf/tabulka u úloh 6, 8, 11, 15, 16) →
  jedna úloha, poduúlohy jako odstavce; odpovědi spojené středníkem.

## Odpovědi

Převzaty z **klíče správných řešení** a u počtářských úloh nezávisle přepočítány.
U výběru z možností je `ans` shodný text se správnou variantou; u Ano/Ne a přiřazování
je odpověď spojena středníkem.

## Poznámky a známé nejistoty (k ruční kontrole)

- **Test A: úlohy 1–5 nejsou v repu nafoceny** (fotky začínají úlohou 6) → nejsou v importu.
- **Úlohy 9 a 10 jsou konstrukční** (rýsování) — odpověď je slovní popis konstrukce; SVG
  zobrazuje jen výchozí zadání, ne hotovou konstrukci.
- **Obrázky jsou překresleny do SVG.** Geometrie a schémata jsou mnohde **schematická**
  (přibližné proporce, přesné hodnoty/úhly). U několika úloh byl obrázek v předloze
  slabě čitelný a byl **rekonstruován tak, aby odpovídal klíči** — zejména:
  - grafy/hodnoty u úloh 11 (teploty/školy) a 16 (koláčové grafy) v některých testech,
  - Test K úloha 16 (binární „IQ" hlavolam) — přepsána zjednodušeně, odpovědi z klíče,
  - úlohy typu „poměr stran" (H13/H14, C13, L13) — proporce dopočteny ke správné odpovědi.
- Duplicitní fotky v repu (3593≈3594, 3655≈3656, 3664≈3665) byly použity jen jednou.

---

## Obsah — CERMAT (jednotná přijímací zkouška)

Zdroj: `prijimacky.cermat.cz`. Soubory v `scripts/apex/cermat/`.
Celkem **870 GoMath úloh**: ročníky **2026 + 2025** (tabulky níže), **2024**
(M5 72 + M7 74 + M9 80 = 226) a **2023** (částečně 9/12 testů, 172 úloh; chybí ještě
M5B, M7D, M9D 2023). Ostré testy M5/M7/M9, varianty A–D, kódy T01–T04.

### MATEMATIKA 5 (osmileté obory, 5. ročník) — 130 úloh, taxonomie `zs1`

| Test | kód (CERMAT_Code__c) | termín | úloh |
|---|---|---|---|
| M5A 2026 | M5PAD26C0T01 | 1. řádný | 16 |
| M5B 2026 | M5PBD26C0T02 | 2. řádný | 15 |
| M5C 2026 | M5PCD26C0T03 | 1. náhradní | 17 |
| M5D 2026 | M5PDD26C0T04 | 2. náhradní | 17 |
| M5A 2025 | M5PAD25C0T01 | 1. řádný | 16 |
| M5B 2025 | M5PBD25C0T02 | 2. řádný | 17 |
| M5C 2025 | M5PCD25C0T03 | 1. náhradní | 15 |
| M5D 2025 | M5PDD25C0T04 | 2. náhradní | 17 |

### MATEMATIKA 7 (šestileté obory, 7. ročník) — 137 úloh, taxonomie `zs2` + `r7`

| Test | kód (CERMAT_Code__c) | termín | úloh |
|---|---|---|---|
| M7A 2026 | M7PAD26C0T01 | 1. řádný | 17 |
| M7B 2026 | M7PBD26C0T02 | 2. řádný | 17 |
| M7C 2026 | M7PCD26C0T03 | 1. náhradní | 17 |
| M7D 2026 | M7PDD26C0T04 | 2. náhradní | 17 |
| M7A 2025 | M7PAD25C0T01 | 1. řádný | 17 |
| M7B 2025 | M7PBD25C0T02 | 2. řádný | 17 |
| M7C 2025 | M7PCD25C0T03 | 1. náhradní | 18 |
| M7D 2025 | M7PDD25C0T04 | 2. náhradní | 17 |

> Pozn. M7B 2025 úloha 16: v předloze nesrovnalost (rozměr 24 vs 25 cm) mezi zadáním
> a klíčem — odpovědi z klíče, k ruční kontrole.

### MATEMATIKA 9 (čtyřleté obory, 9. ročník) — ostré testy — 163 úloh, taxonomie `zs2` + `r9`

| Test | kód (CERMAT_Code__c) | termín | úloh |
|---|---|---|---|
| M9A 2026 | M9PAD26C0T01 | 1. řádný | 20 |
| M9B 2026 | M9PBD26C0T02 | 2. řádný | 21 |
| M9C 2026 | M9PCD26C0T03 | 1. náhradní | 21 |
| M9D 2026 | M9PDD26C0T04 | 2. náhradní | 21 |
| M9A 2025 | M9PAD25C0T01 | 1. řádný | 20 |
| M9B 2025 | M9PBD25C0T02 | 2. řádný | 20 |
| M9C 2025 | M9PCD25C0T03 | 1. náhradní | 20 |
| M9D 2025 | M9PDD25C0T04 | 2. náhradní | 20 |

### MATEMATIKA 9 – přijímačky nanečisto (čtyřleté obory, 9. ročník) — 42 úloh, taxonomie `zs2` + `r9`

| Test | kód (CERMAT_Code__c) | rok | úloh |
|---|---|---|---|
| M9 nanečisto 2025 | M9PND25C0T01 | 2025 | 21 |
| M9 nanečisto 2026 | M9PND26C0T01 | 2026 | 21 |

Generátor `scripts/generator/gen_cermat.py` navíc nastavuje CERMAT pole:
`Source_Type__c = 'CERMAT'`, `CERMAT_Code__c = <kód testu>`, `Source_Year__c = <rok>`,
`Source__c = 'CERMAT – jednotná přijímací zkouška'`, `License__c = 'Jiná'`.
Regenerace: `python3 scripts/generator/data_cermat_M5A_2026.py` (analogicky B/C/D).

**Struktura CERMAT M5:** 14 úloh; 1 (Vypočtěte) a 7 (dvě konstrukce) rozděleny na samostatné
úlohy, úlohy 2–6 a 8–14 se společným výchozím textem sloučeny. Prefix názvů `CERMAT M5<X> 2026`.

**Předpoklad org:** pole `CERMAT_Code__c` (Text) a `Source_Year__c` (Číslo) musí v orgu existovat
(dle návodu jsou pro CERMAT úlohy určena); `Source_Year__c` je vkládáno jako číslo (2026).

**Známé nejistoty (k ruční kontrole):** prostorové úlohy s krychličkami (11) nelze věrně přenést
do SVG — mají schematickou poznámku a odpověď z klíče; grafy/plánky/mřížky u některých úloh jsou
schematické (přesné hodnoty z klíče). Konstrukce (7) mají odpověď jako slovní popis.

**Starší ročníky (2015–2025, A–D)** jsou na webu CERMATu k dispozici — zatím nezpracovány.
