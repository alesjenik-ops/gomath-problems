# Apex importy úloh (GoMath)

Generované anonymní Apex skripty pro import cvičných testů do GoMathu
(dle `importulohapexnavod.md`). Zdroj všech úloh: **Matematika - Zelený**.

## Struktura

```
scripts/
├── apex/                      # hotové Apex skripty (Workbench → Apex Execute)
│   └── import-zeleny-testA-cast1..4.apex
└── generator/                 # Python generátor (kvůli spolehlivému escapování)
    ├── gen.py                 # kostra + skládání c.add(...) + dělení < 9 KB
    └── data_testA.py          # data úloh Testu A (+ SVG obrázky)
```

## Spuštění importu

Workbench → utilities → **Apex Execute** → vlož obsah `*.apex` → **Execute**.
V logu zkontroluj `System.debug('Vytvořeno úloh: …')`. Skripty jsou **idempotentní**
podle názvu úlohy (`Math_Problem__c.Name`) — opětovné spuštění nic nezduplikuje.
Části `-cast1..N` pouštěj samostatně (limit anonymního Apexu ~9 KB).

## Regenerace

```bash
cd scripts/generator
python3 data_testA.py     # zvaliduje ($ páry, JSON, SVG) a zapíše ./out/*.apex
```

## Rozdělení poduúloh

- **Izolované** poduúlohy (např. 7.1/7.2/7.3 „Vypočtěte") → samostatné úlohy.
- **Společný kontext** (výchozí text/obrázek, přiřazování, Ano/Ne) → jedna úloha,
  poduúlohy jako odstavce; odpovědi spojené středníkem.

## Poznámky k datům (Test A)

- Úlohy **1–5 nejsou v repu nafoceny** (fotky začínají úlohou 6) → nejsou v importu.
- Úlohy 9 a 10 jsou **konstrukční** — odpověď je popis konstrukce.
- Obrázky (park, Vennův diagram, úhly, čtverec+lichoběžník) jsou **překresleny do SVG**.
- Správné odpovědi převzaty z **klíče správných řešení** (IMG_3657–3658).
