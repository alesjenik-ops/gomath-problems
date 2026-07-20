# Apex importy úloh (GoMath)

Generované anonymní Apex skripty pro import cvičných testů do GoMathu
(dle `importulohapexnavod.md`). Zdroj všech úloh: **Matematika - Zelený**.

## Obsah

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
