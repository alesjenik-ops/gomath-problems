# -*- coding: utf-8 -*-
"""
Export všech datových souborů (Zelený + CERMAT) do JSON pro GoMathJsonImport.

Výstup: scripts/json/<test>.json (jeden soubor = jeden test) + scripts/json/index.json.
JSON dokument testu:
    {"source": ..., "sourceType": ..., "cermatCode": ...|null, "year": ...|null,
     "problems": [{name, zad, opts, ln, svg, fn, alt, cap, sol, ans, pts, mins, diff, codes}]}

CCODE/YEAR se u CERMAT souborů čtou regexem ze zdrojáku (jsou nastavené
v bloku `if __name__ == '__main__':`, který se při importu modulu nespustí).

Spuštění:  python3 scripts/generator/export_json.py
"""
import importlib.util
import json
import os
import re
import sys

GEN_DIR = os.path.dirname(os.path.abspath(__file__))
OUT_DIR = os.path.normpath(os.path.join(GEN_DIR, '..', 'json'))

CCODE_RE = re.compile(r"(?:gen|gen_cermat)\.CCODE\s*=\s*'([^']+)'")
YEAR_RE = re.compile(r"(?:gen|gen_cermat)\.YEAR\s*=\s*(\d{4})")

FIELDS = ['name', 'zad', 'opts', 'ln', 'svg', 'fn', 'alt', 'cap',
          'sol', 'ans', 'pts', 'mins', 'diff', 'codes']


def load_problems(path):
    spec = importlib.util.spec_from_file_location('data_mod', path)
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    return mod.PROBLEMS


def normalize(p):
    out = {}
    for f in FIELDS:
        v = p.get(f)
        if f == 'ln' and v is None:
            v = 0
        out[f] = v
    return out


def main():
    sys.path.insert(0, GEN_DIR)
    os.makedirs(OUT_DIR, exist_ok=True)

    docs = []  # (json_name, doc)
    for fn in sorted(os.listdir(GEN_DIR)):
        path = os.path.join(GEN_DIR, fn)
        if fn.endswith('_REFERENCE.py') or fn.endswith('_SCHEMA.py'):
            continue  # kopie vzorů pro subagenty, duplikují ostrá data
        if fn.startswith('data_test') and fn.endswith('.py'):
            key = 'zeleny-' + fn[len('data_'):-3]          # data_testA.py -> zeleny-testA
            src, stype, ccode, year = 'Matematika - Zelený', 'Jiné', None, None
        elif fn.startswith('data_cermat_') and fn.endswith('.py'):
            key = 'cermat-' + fn[len('data_cermat_'):-3]    # data_cermat_M5A_2026.py -> cermat-M5A_2026
            source_text = open(path, encoding='utf-8').read()
            mc, my = CCODE_RE.search(source_text), YEAR_RE.search(source_text)
            if not mc or not my:
                raise SystemExit(f'{fn}: nenalezen gen.CCODE / gen.YEAR')
            src, stype = 'CERMAT – jednotná přijímací zkouška', 'CERMAT'
            ccode, year = mc.group(1), int(my.group(1))
        else:
            continue

        problems = [normalize(p) for p in load_problems(path)]
        docs.append((key + '.json', {
            'source': src, 'sourceType': stype,
            'cermatCode': ccode, 'year': year,
            'problems': problems,
        }))

    # validace: unikátní názvy napříč všemi soubory
    seen, dups = set(), []
    total = 0
    for _, doc in docs:
        for p in doc['problems']:
            total += 1
            if p['name'] in seen:
                dups.append(p['name'])
            seen.add(p['name'])
    if dups:
        raise SystemExit('DUPLICITNÍ názvy: ' + '; '.join(dups[:10]))

    files = []
    for name, doc in docs:
        out_path = os.path.join(OUT_DIR, name)
        with open(out_path, 'w', encoding='utf-8') as f:
            json.dump(doc, f, ensure_ascii=False, separators=(',', ':'))
        files.append('scripts/json/' + name)
        print(f'  {name}: {len(doc["problems"])} úloh, {os.path.getsize(out_path)} B')

    with open(os.path.join(OUT_DIR, 'index.json'), 'w', encoding='utf-8') as f:
        json.dump({'files': files, 'totalProblems': total}, f, ensure_ascii=False, indent=1)

    print(f'\nCelkem: {len(files)} souborů, {total} úloh (unikátních názvů: {len(seen)})')


if __name__ == '__main__':
    main()
