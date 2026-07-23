# -*- coding: utf-8 -*-
# CERMAT – Jednotná přijímací zkouška 2026, MATEMATIKA 5C, 1. NÁHRADNÍ TERMÍN.
# Kód testu: M5PCD26C0T03. 14 úloh (po rozdělení izolovaných poduúloh 17 úloh).
# Zdroj odpovědí: klíč správných řešení (KSR) + vyplněný záznamový arch (VZA).

# ---- SVG obrázky (bez ' a \) ----

# obecný pomocník na kreslení tabulek
def _table(ox, oy, colw, rowh, cells, shade=()):
    xs = [ox]
    for w in colw:
        xs.append(xs[-1] + w)
    ys = [oy]
    for h in rowh:
        ys.append(ys[-1] + h)
    out = []
    for r in range(len(rowh)):
        for c in range(len(colw)):
            fill = "#d9d9d9" if (r, c) in shade else "#ffffff"
            out.append(f'<rect x="{xs[c]}" y="{ys[r]}" width="{colw[c]}" height="{rowh[r]}" fill="{fill}" stroke="#000"/>')
            t = cells[r][c]
            if t:
                out.append(f'<text x="{xs[c]+colw[c]/2}" y="{ys[r]+rowh[r]/2+4}" font-size="12" text-anchor="middle">{t}</text>')
    return "".join(out), xs[-1], ys[-1]

# úloha 4: tabulka závaží
def _svg4():
    body, xe, ye = _table(20, 20, [150, 70, 70, 70], [30, 30, 30],
        [["Závaží", "Malé", "Střední", "Velké"],
         ["Hmotnost 1 kusu", "15 g", "25 g", "50 g"],
         ["Počet kusů v sadě", "5", "", ""]])
    return f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {xe+20} {ye+20}" font-family="sans-serif">{body}</svg>'
SVG4 = _svg4()

# úloha 5: plánek pozemku ve čtvercové síti (schematicky)
def _plan():
    cell = 30; ox = 20; oy = 24; W = 8; H = 6
    ww = ox * 2 + W * cell + 70; hh = oy * 2 + H * cell
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {ww} {hh}" font-family="sans-serif">']
    for i in range(W + 1):
        s.append(f'<line x1="{ox+i*cell}" y1="{oy}" x2="{ox+i*cell}" y2="{oy+H*cell}" stroke="#bbb"/>')
    for j in range(H + 1):
        s.append(f'<line x1="{ox}" y1="{oy+j*cell}" x2="{ox+W*cell}" y2="{oy+j*cell}" stroke="#bbb"/>')
    s.append(f'<rect x="{ox}" y="{oy}" width="{W*cell}" height="{H*cell}" fill="none" stroke="#000"/>')
    # bazén (lichoběžník vlevo)
    s.append(f'<polygon points="{ox},{oy+cell} {ox+3*cell},{oy+2*cell} {ox+3*cell},{oy+3*cell} {ox},{oy+4*cell}" fill="#d0d0d0" stroke="#000"/>')
    s.append(f'<text x="{ox+8}" y="{oy+3*cell-4}" font-size="12">Bazén</text>')
    # šatny (šedý obdélník vpravo nahoře)
    s.append(f'<rect x="{ox+5*cell}" y="{oy}" width="{2*cell}" height="{cell}" fill="#9a9a9a" stroke="#000"/>')
    s.append(f'<text x="{ox+5*cell+6}" y="{oy+cell-9}" font-size="11">Šatny</text>')
    # dětské hřiště (osmiúhelník uprostřed)
    cx = ox + int(4.5 * cell); cy = oy + int(3.7 * cell); r = int(1.2 * cell); d = int(r * 0.6)
    pts = f"{cx-d},{cy-r} {cx+d},{cy-r} {cx+r},{cy-d} {cx+r},{cy+d} {cx+d},{cy+r} {cx-d},{cy+r} {cx-r},{cy+d} {cx-r},{cy-d}"
    s.append(f'<polygon points="{pts}" fill="#efefef" stroke="#000"/>')
    s.append(f'<text x="{cx}" y="{cy-2}" font-size="10" text-anchor="middle">Dětské</text>')
    s.append(f'<text x="{cx}" y="{cy+10}" font-size="10" text-anchor="middle">hřiště</text>')
    ay = oy + 4 * cell + cell // 2
    s.append(f'<line x1="{ox+W*cell+40}" y1="{ay}" x2="{ox+W*cell+4}" y2="{ay}" stroke="#000"/>')
    s.append(f'<polygon points="{ox+W*cell+4},{ay} {ox+W*cell+14},{ay-4} {ox+W*cell+14},{ay+4}" fill="#000"/>')
    s.append(f'<text x="{ox+W*cell+44}" y="{ay+4}" font-size="12">9 m²</text>')
    s.append("</svg>")
    return "".join(s)
SVG5 = _plan()

# úloha 6: dva šestiúhelníky (schematicky)
SVG6 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 190" font-family="sans-serif">
<text x="120" y="24" font-size="12" text-anchor="middle">1. šestiúhelník</text>
<polygon points="30,100 120,45 210,100 120,155" fill="none" stroke="#000" stroke-width="1.5"/>
<polygon points="120,45 120,155 70,100" fill="#bdbdbd" stroke="#000"/>
<polygon points="120,45 120,155 170,100" fill="#bdbdbd" stroke="#000"/>
<line x1="120" y1="45" x2="120" y2="155" stroke="#000"/>
<text x="126" y="104" font-size="12">10 cm</text>
<text x="370" y="24" font-size="12" text-anchor="middle">2. šestiúhelník</text>
<polygon points="290,150 370,60 450,150" fill="none" stroke="#000" stroke-width="1.5"/>
<polygon points="290,150 370,60 370,150" fill="#bdbdbd" stroke="#000"/>
<polygon points="450,150 370,60 370,150" fill="#bdbdbd" stroke="#000"/>
<line x1="370" y1="60" x2="370" y2="150" stroke="#000"/>
<text x="316" y="166" font-size="11">10 cm</text>
<text x="398" y="166" font-size="11">10 cm</text>
</svg>"""

# úloha 7.1: body A, S a přímka p
SVG7_1 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 250" font-family="sans-serif">
<line x1="30" y1="215" x2="410" y2="85" stroke="#000" stroke-width="2"/>
<text x="416" y="82" font-size="16" font-style="italic">p</text>
<text x="86" y="197" font-size="15">×</text>
<text x="90" y="213" font-size="15" font-style="italic">A</text>
<text x="212" y="122" font-size="15">×</text>
<text x="216" y="114" font-size="15" font-style="italic">S</text>
</svg>"""

# úloha 7.2: body U, V a přímka k
SVG7_2 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 250" font-family="sans-serif">
<line x1="50" y1="210" x2="430" y2="150" stroke="#000" stroke-width="2"/>
<text x="436" y="150" font-size="16" font-style="italic">k</text>
<text x="146" y="126" font-size="15">×</text>
<text x="150" y="116" font-size="15" font-style="italic">U</text>
<text x="296" y="126" font-size="15">×</text>
<text x="300" y="116" font-size="15" font-style="italic">V</text>
</svg>"""

# úloha 8: skupinový sloupcový graf služeb dětí (kg -> počet dětí)
def _bars8():
    days = [("Pondělí", 2, 4, 1), ("Úterý", 1, 3, 3), ("Středa", 3, 3, 2), ("Čtvrtek", 1, 2, 3), ("Pátek", None, None, None)]
    x0 = 60; y0 = 210; u = 30; bw = 15
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 275" font-family="sans-serif">']
    s.append(f'<line x1="{x0}" y1="30" x2="{x0}" y2="{y0}" stroke="#000"/>')
    s.append(f'<line x1="{x0}" y1="{y0}" x2="540" y2="{y0}" stroke="#000"/>')
    for v in range(0, 6):
        y = y0 - v * u
        s.append(f'<line x1="{x0-4}" y1="{y}" x2="{x0}" y2="{y}" stroke="#000"/>')
        s.append(f'<text x="{x0-8}" y="{y+4}" font-size="11" text-anchor="end">{v}</text>')
    s.append(f'<text x="26" y="120" font-size="12" text-anchor="middle" transform="rotate(-90 26 120)">Počet dětí</text>')
    x = x0 + 22
    for name, a, b, cc in days:
        cx = x
        for val, col in ((a, "#555"), (b, "#dcdcdc"), (cc, "#9a9a9a")):
            if val is None:
                s.append(f'<rect x="{cx}" y="{y0-3*u}" width="{bw}" height="{3*u}" fill="none" stroke="#888" stroke-dasharray="3 3"/>')
            else:
                h = val * u
                s.append(f'<rect x="{cx}" y="{y0-h}" width="{bw}" height="{h}" fill="{col}" stroke="#000"/>')
            cx += bw + 2
        s.append(f'<text x="{x+(3*bw+4)/2}" y="{y0+16}" font-size="11" text-anchor="middle">{name}</text>')
        x += 3 * bw + 4 + 22
    lx = 120; ly = 252
    s.append(f'<rect x="{lx}" y="{ly}" width="12" height="12" fill="#555" stroke="#000"/><text x="{lx+16}" y="{ly+10}" font-size="11">Snídaně</text>')
    s.append(f'<rect x="{lx+95}" y="{ly}" width="12" height="12" fill="#dcdcdc" stroke="#000"/><text x="{lx+111}" y="{ly+10}" font-size="11">Oběd</text>')
    s.append(f'<rect x="{lx+175}" y="{ly}" width="12" height="12" fill="#9a9a9a" stroke="#000"/><text x="{lx+191}" y="{ly+10}" font-size="11">Večeře</text>')
    s.append("</svg>")
    return "".join(s)
SVG8 = _bars8()

# úloha 9: vzor násobící tabulky + tabulka Násobení s otazníkem
def _svg9():
    vbody, vxe, vye = _table(20, 44, [50, 50, 60, 50], [30, 30, 30, 30],
        [["", "", "b", ""],
         ["", "", "", ""],
         ["a", "", "a·b", ""],
         ["", "", "", ""]],
        shade={(0, 2), (1, 2), (2, 2), (3, 2), (2, 0), (2, 1), (2, 3)})
    nbody, nxe, nye = _table(270, 44, [52, 42, 42, 42, 42], [30, 30, 30, 30, 30],
        [["", "", "", "", ""],
         ["", "", "", "10", "15"],
         ["", "", "28", "", "21"],
         ["", "?", "", "", "18"],
         ["", "72", "32", "", ""]])
    w = max(vxe, nxe) + 20; h = max(vye, nye) + 20
    return (f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {w} {h}" font-family="sans-serif">'
            f'<text x="115" y="34" font-size="12" text-anchor="middle">Vzor pro násobení</text>'
            f'<text x="375" y="34" font-size="12" text-anchor="middle">Násobení</text>'
            f'{vbody}{nbody}</svg>')
SVG9 = _svg9()

# úloha 11: prostorová stavba z krychliček (jen schematická poznámka)
SVG11 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 120" font-family="sans-serif">
<text x="280" y="55" font-size="13" text-anchor="middle">Stavba ze stejných krychliček – 4 patra po 5 řadách (viz testový sešit).</text>
<text x="280" y="82" font-size="11" text-anchor="middle" fill="#666">Prostorové těleso nelze věrně přenést do SVG; posuzuje se podle originálu.</text>
</svg>"""

# úloha 14: 1., 2. a 3. obrazec (čtverec a obdélníky)
SVG14 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 130" font-family="sans-serif">
<text x="50" y="22" font-size="12" text-anchor="middle">1. obrazec</text>
<rect x="20" y="32" width="60" height="60" fill="none" stroke="#000"/>
<text x="175" y="22" font-size="12" text-anchor="middle">2. obrazec</text>
<rect x="130" y="32" width="60" height="60" fill="none" stroke="#000"/>
<rect x="190" y="32" width="30" height="60" fill="none" stroke="#000"/>
<line x1="190" y1="62" x2="220" y2="62" stroke="#000"/>
<text x="325" y="22" font-size="12" text-anchor="middle">3. obrazec</text>
<rect x="270" y="32" width="60" height="60" fill="none" stroke="#000"/>
<rect x="330" y="32" width="30" height="60" fill="none" stroke="#000"/>
<line x1="330" y1="62" x2="360" y2="62" stroke="#000"/>
<rect x="360" y="32" width="20" height="60" fill="none" stroke="#000"/>
<line x1="360" y1="52" x2="380" y2="52" stroke="#000"/>
<line x1="360" y1="72" x2="380" y2="72" stroke="#000"/>
<text x="405" y="68" font-size="20">…</text>
</svg>"""

B = ['zs1']  # 5. ročník ZŠ (přijímačky na osmileté); kód r5 v taxonomii není

PROBLEMS = [
    {'name': 'CERMAT M5C 2026 – úloha 1.1', 'zad': ['Vypočtěte: $84:4-4\\cdot 5=$'], 'opts': None, 'ln': 2,
     'sol': ['Podle pořadí operací: $84:4-4\\cdot 5 = 21-20 = 1$.'], 'ans': '$1$', 'pts': 1, 'mins': 1, 'diff': '1',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5C 2026 – úloha 1.2', 'zad': ['Vypočtěte: $2\\,000:40-(4\\cdot 13):4=$'], 'opts': None, 'ln': 2,
     'sol': ['$2\\,000:40-(4\\cdot 13):4 = 50-52:4 = 50-13 = 37$.'], 'ans': '$37$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5C 2026 – úloha 1.3', 'zad': ['Vypočtěte: $384:16-(6+30:6)=$'], 'opts': None, 'ln': 2,
     'sol': ['$384:16-(6+30:6) = 24-(6+5) = 24-11 = 13$.'], 'ans': '$13$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5C 2026 – úloha 2', 'zad': [
        'Pan Červený strávil jízdou v autě přesně 7 hodin, než dojel do cíle. Svou jízdu autem zahájil ráno v 7:44 a přerušil ji jen jednou, když si udělal pauzu na oběd. Z auta vystoupil ve 12:02 a do auta se vrátil za 38 minut. Pak pokračoval v jízdě až do cíle.',
        'Určete, kdy pan Červený dorazil do cíle. Výsledek zapište ve tvaru hodiny : minuty.'],
     'opts': None, 'ln': 2,
     'sol': ['Před obědem jel od 7:44 do 12:02, tj. 4 hodiny 18 minut. Pauza trvala 38 minut, do auta se vrátil ve 12:40.',
             'Zbývalo odjet ještě 7 hodin − 4 hodiny 18 minut = 2 hodiny 42 minut. Od 12:40 tedy dojel v 12:40 + 2:42 = 15:22.'],
     'ans': 'V 15:22 (tj. ve 3:22 odpoledne)', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5C 2026 – úloha 3', 'zad': [
        'V třídní knize je zapsán seznam všech 26 žáků 5. A. Žádní dva žáci v 5. A nemají stejné příjmení.',
        '3.1 Počet žáků zapsaných v seznamu před Janem Novákem je čtyřikrát větší než počet žáků zapsaných za ním. Určete, kolik žáků je v seznamu zapsáno za Janem Novákem.',
        '3.2 Počet žáků zapsaných v seznamu za Anežkou Klímovou je o 7 větší než počet žáků zapsaných před ní. Určete, na kolikátém místě je v seznamu zapsaná Anežka Klímová.'],
     'opts': None, 'ln': 2,
     'sol': ['3.1 Kromě Jana Nováka je v seznamu $26-1 = 25$ žáků. Za ním je $x$ žáků, před ním $4x$: $4x+x = 25$, tedy $x = 5$. Za Janem Novákem je $5$ žáků.',
             '3.2 Kromě Anežky Klímové je $25$ žáků: před ní $y$, za ní $y+7$. Platí $y+(y+7) = 25$, tedy $y = 9$. Před ní je $9$ žáků, je zapsaná na $10.$ místě.'],
     'ans': '3.1: $5$ žáků; 3.2: na $10.$ místě', 'pts': 3, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5C 2026 – úloha 4', 'zad': [
        'Sadu tvoří 27 závaží. Celková hmotnost všech závaží v sadě je 1 kg. Sada obsahuje pouze malá, střední a velká závaží, viz tabulka.',
        '4.1 Určete počet velkých závaží v sadě.',
        '4.2 Určete v gramech celkovou hmotnost všech středních závaží v sadě.'],
     'opts': None, 'ln': 2, 'svg': SVG4, 'fn': 'zavazi.svg',
     'alt': 'Tabulka s hmotností jednoho kusu a počtem malých, středních a velkých závaží.', 'cap': 'Tabulka závaží',
     'sol': ['Malá závaží mají hmotnost $5\\cdot 15 = 75$ g. Na střední a velká zbývá $1000-75 = 925$ g a $27-5 = 22$ kusů.',
             '4.1 Označme počet velkých $v$ a středních $m$: $m+v = 22$ a $25m+50v = 925$. Z toho $m+2v = 37$, tedy $v = 15$. Velkých závaží je $15$.',
             '4.2 Středních je $m = 22-15 = 7$, jejich hmotnost je $7\\cdot 25 = 175$ g.'],
     'ans': '4.1: $15$ velkých závaží; 4.2: $175$ gramů', 'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5C 2026 – úloha 5', 'zad': [
        'Na obrázku je plánek pozemku. Plánek je rozdělen čtvercovou sítí a obsahuje obrazce, které představují půdorysy tří objektů – bazénu, šaten a dětského hřiště. Všechny tyto obrazce mají vrcholy v mřížových bodech sítě. Jeden čtvereček čtvercové sítě v plánku představuje ve skutečnosti čtverec o obsahu 9 m².',
        '5.1 Vypočtěte v m² skutečný obsah půdorysu objektu, který zabírá na pozemku největší plochu.',
        '5.2 Vypočtěte v m² obsah celé části pozemku, která není obsazena žádným ze tří uvedených objektů.'],
     'opts': None, 'ln': 2, 'svg': SVG5, 'fn': 'planek.svg',
     'alt': 'Plánek pozemku ve čtvercové síti s bazénem, šatnami a dětským hřištěm.', 'cap': 'Schematický nákres (jeden čtvereček = 9 m²)',
     'sol': ['Jeden čtvereček má obsah $9$ m².',
             '5.1 Objekt s největší plochou zabírá $8$ čtverečků, tj. $8\\cdot 9 = 72$ m².',
             '5.2 Volná část pozemku zabírá $27$ čtverečků, tj. $27\\cdot 9 = 243$ m².'],
     'ans': '5.1: $72$ m²; 5.2: $243$ m²', 'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5C 2026 – úloha 6', 'zad': [
        'První šestiúhelník se skládá ze dvou stejných bílých rovnostranných trojúhelníků a dvou šedých trojúhelníků. Oba šedé trojúhelníky jsou stejné. Trojúhelníky přeskládáme do druhého šestiúhelníku (viz obrázek). Nejdelší strana šedého trojúhelníku měří 10 cm. Obvod prvního šestiúhelníku je 40 cm a obvod druhého šestiúhelníku je 46 cm.',
        '6.1 Určete v cm délku jedné strany bílého rovnostranného trojúhelníku.',
        '6.2 Určete v cm délku nejkratší strany šedého trojúhelníku.',
        '6.3 Určete v cm rozdíl obvodů jednoho šedého a jednoho bílého trojúhelníku.'],
     'opts': None, 'ln': 3, 'svg': SVG6, 'fn': 'sestiuhelniky.svg',
     'alt': 'První a druhý šestiúhelník složené ze dvou bílých rovnostranných a dvou šedých trojúhelníků.', 'cap': 'Schematický nákres dvou šestiúhelníků',
     'sol': ['Bílý trojúhelník je rovnostranný se stranou $a$. Šedý trojúhelník má nejdelší stranu $10$ cm.',
             'Z obvodů obou šestiúhelníků (prvního $40$ cm a druhého $46$ cm) vychází strana bílého trojúhelníku $a = 7$ cm; strany šedého trojúhelníku jsou pak $6$ cm, $7$ cm a $10$ cm.',
             '6.1 Strana bílého trojúhelníku měří $7$ cm.',
             '6.2 Nejkratší strana šedého trojúhelníku měří $6$ cm.',
             '6.3 Obvod šedého trojúhelníku je $6+7+10 = 23$ cm, obvod bílého $3\\cdot 7 = 21$ cm; liší se o $2$ cm.'],
     'ans': '6.1: $7$ cm; 6.2: $6$ cm; 6.3: o $2$ cm', 'pts': 5, 'mins': 6, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5C 2026 – úloha 7.1 (konstrukce)', 'zad': [
        'V rovině leží body $A$, $S$ a přímka $p$ procházející bodem $A$ (viz obrázek).',
        'Bod $A$ je vrchol trojúhelníku $ABC$. Bod $S$ je střed strany $AC$ tohoto trojúhelníku. Na přímce $p$ leží střed $P$ strany $BC$ trojúhelníku $ABC$. Body $P$ a $S$ mají od vrcholu $C$ stejnou vzdálenost.',
        'Sestrojte vrchol $C$, střed $P$ a vrchol $B$, označte je písmeny a narýsujte trojúhelník $ABC$. Najděte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG7_1, 'fn': 'body-AS-p.svg',
     'alt': 'Body A a S a přímka p procházející bodem A.', 'cap': 'Výchozí obrázek k úloze 7.1',
     'sol': ['$S$ je střed strany $AC$, proto vrchol $C$ je obraz bodu $A$ ve středové souměrnosti se středem $S$ (bod $C$ leží na polopřímce $AS$ za bodem $S$, $|SC| = |AS|$).',
             'Body $P$ a $S$ mají od $C$ stejnou vzdálenost, tedy $|CP| = |CS|$. Střed $P$ je průsečík přímky $p$ s kružnicí se středem $C$ a poloměrem $|CS|$; ta protne přímku $p$ ve dvou bodech $P_1$, $P_2$.',
             '$P$ je střed strany $BC$, proto vrchol $B$ je obraz bodu $C$ ve středové souměrnosti se středem $P$ ($|PB| = |PC|$). Dostaneme dvě řešení s vrcholy $B_1$, $B_2$.'],
     'ans': 'Dvě řešení. $C$ je obraz $A$ podle středu $S$; střed $P$ je průsečík přímky $p$ s kružnicí se středem $C$ a poloměrem $|CS|$ (body $P_1$, $P_2$); vrchol $B$ je obraz $C$ podle středu $P$ – viz náčrt v klíči.',
     'pts': 3, 'mins': 6, 'diff': '4', 'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5C 2026 – úloha 7.2 (konstrukce)', 'zad': [
        'V rovině leží body $U$, $V$ a přímka $k$ (viz obrázek).',
        'Bod $U$ leží uvnitř strany $KN$ obdélníku $KLMN$. Na přímce $k$ leží strana $KL$ tohoto obdélníku. Všechny čtyři vrcholy obdélníku $KLMN$ mají od bodu $V$ stejnou vzdálenost.',
        'Sestrojte všechny vrcholy obdélníku $KLMN$, označte je písmeny a obdélník narýsujte.'],
     'opts': None, 'ln': 0, 'svg': SVG7_2, 'fn': 'body-UV-k.svg',
     'alt': 'Body U a V a přímka k.', 'cap': 'Výchozí obrázek k úloze 7.2',
     'sol': ['Strana $KN$ je kolmá k přímce $k$ (jde o obdélník) a prochází bodem $U$. Vrchol $K$ je proto pata kolmice spuštěné z bodu $U$ na přímku $k$.',
             'Všechny vrcholy mají od $V$ stejnou vzdálenost, takže $V$ je střed obdélníku. Kružnice se středem $V$ a poloměrem $|VK|$ protne přímku $k$ v druhém vrcholu $L$.',
             'Vrcholy $M$ a $N$ jsou obrazy vrcholů $K$ a $L$ ve středové souměrnosti se středem $V$. Tak vznikne obdélník $KLMN$.'],
     'ans': '$K$ je pata kolmice z $U$ na přímku $k$; $V$ je střed obdélníku, $L$ je druhý průsečík kružnice se středem $V$ a poloměrem $|VK|$ s přímkou $k$; $M$, $N$ jsou obrazy $K$, $L$ podle středu $V$ – viz náčrt v klíči.',
     'pts': 3, 'mins': 7, 'diff': '4', 'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5C 2026 – úloha 8', 'zad': [
        'Tábor začal v pondělí snídaní a skončil v pátek po obědě. U každého jídla pomáhala v kuchyni služba. U snídaně měly mít službu vždy 4 osoby, u oběda 5 osob a u večeře také 5 osob. Každé z 35 dětí mělo službu v kuchyni právě jednou za celý tábor. Požadovaný počet osob vždy doplnili instruktoři a ti pak měli službu společně s dětmi. Přitom každý instruktor měl službu v kuchyni nejvýše jedenkrát za den. V grafu je uveden pouze rozpis služeb dětí, oba páteční údaje chybí.',
        'Rozhodněte o každém z následujících tvrzení 8.1–8.3, zda je pravdivé (A), nebo nepravdivé (N).',
        '8.1 V pátek mělo službu v kuchyni celkem 9 dětí.',
        '8.2 U každého jídla měli službu v kuchyni společně s dětmi nejvýše 3 instruktoři.',
        '8.3 Instruktorů muselo být na táboře nejméně 8.'],
     'opts': None, 'ln': 0, 'svg': SVG8, 'fn': 'graf-sluzby.svg',
     'alt': 'Skupinový sloupcový graf služeb dětí u snídaně, oběda a večeře od pondělí do čtvrtka; páteční údaje chybí.', 'cap': 'Rozpis služeb dětí (počet dětí)',
     'sol': ['Každé z 35 dětí mělo službu právě jednou. Součet dětských služeb od pondělí do čtvrtka je $7+12+9 = 28$, v pátek tedy $35-28 = 7$ dětí.',
             '8.1 V pátek mělo službu $7$ dětí, ne $9$ → N.',
             '8.2 Instruktoři doplňují do 4 (snídaně) a 5 (oběd i večeře). V pondělí u večeře mělo službu jen $1$ dítě, doplnili tedy $4$ instruktoři – tj. více než $3$ → N.',
             '8.3 Denní počty služeb instruktorů jsou Po $7$, Út $7$, St $6$, Čt $8$, Pá $7$; každý instruktor má nejvýše jednu službu za den, proto jich muselo být nejméně $8$ → A.'],
     'ans': '8.1: N; 8.2: N; 8.3: A', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['statistika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5C 2026 – úloha 9', 'zad': [
        'Do příslušného pole tabulky patří vždy součin kladného celého čísla uvedeného ve stejném řádku vlevo a kladného celého čísla uvedeného ve stejném sloupci nahoře (viz vzor).',
        'Které číslo patří do tabulky vpravo na místo otazníku?'],
     'opts': ['A) 42', 'B) 48', 'C) 54', 'D) 60', 'E) 81'], 'ln': 0, 'svg': SVG9, 'fn': 'nasobeni.svg',
     'alt': 'Vzor násobící tabulky a tabulka Násobení s doplněnými součiny a otazníkem.', 'cap': 'Vzor a tabulka Násobení',
     'sol': ['V každém poli je součin čísla vlevo v řádku a čísla nahoře ve sloupci. Z daných součinů dopočteme činitele: řádky mají činitele $5$, $7$, $6$, $8$ a sloupce $9$, $4$, $2$, $3$.',
             'Na místě otazníku je součin $6\\cdot 9 = 54$.'],
     'ans': 'C) 54', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'porozumeni', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5C 2026 – úloha 10', 'zad': [
        'V tiskárně stojí vytisknutí 100 stránek 252 korun (cena za tisk každé stránky je stejná). Pro společný projekt si žáci nechali vytisknout celkem 150 stránek. Na projektu se podílelo 6 žáků a na zaplacení tisku se složili rovným dílem.',
        'Kolika korunami přispěl na tisk jeden žák?'],
     'opts': ['A) 42 korunami', 'B) 63 korunami', 'C) 67 korunami', 'D) 84 korunami', 'E) jiným počtem korun'], 'ln': 0,
     'sol': ['Cena za $1$ stránku: $252:100 = 2{,}52$ Kč. Za $150$ stránek: $150\\cdot 2{,}52 = 378$ Kč. Na $6$ žáků rovným dílem: $378:6 = 63$ Kč.'],
     'ans': 'B) 63 korunami', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'finance']},
    {'name': 'CERMAT M5C 2026 – úloha 11', 'zad': [
        'Matěj postavil stavbu ze stejně velkých krychliček (viz obrázek). Stavba má čtyři patra a v každém patře jsou krychličky naskládány v 5 řadách. V každém vyšším patře má kterákoli řada vždy o 2 krychličky méně než řada pod ní.',
        'Kolik krychliček celkem obsahuje Matějova stavba?'],
     'opts': ['A) 124 krychliček', 'B) 120 krychliček', 'C) 116 krychliček', 'D) 108 krychliček', 'E) méně než 108 krychliček'], 'ln': 0,
     'svg': SVG11, 'fn': 'stavba.svg',
     'alt': 'Prostorová stavba ze stejných krychliček o čtyřech patrech (schematická poznámka).', 'cap': 'Prostorová stavba – viz testový sešit',
     'sol': ['V 1. patře je $42$ krychliček. V každém vyšším patře má každá z 5 řad o 2 krychličky méně, tedy celé patro o $10$ krychliček méně: $42$, $32$, $22$, $12$.',
             'Celkem $42+32+22+12 = 108$ krychliček.'],
     'ans': 'D) 108 krychliček', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['stereometrie', 'porozumeni', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5C 2026 – úloha 12', 'zad': [
        'Alena vytvořila ze stejných sirek trojúhelníky a čtverce. Na každý trojúhelník použila 3 sirky a na každý čtverec 4 sirky, přitom žádná sirka nebyla společná pro dva útvary. Na všechny útvary použila celkem 90 sirek. Čtverců Alena vytvořila o dva méně než trojúhelníků.',
        'Kolik útvarů (trojúhelníků a čtverců) Alena celkem vytvořila?'],
     'opts': ['A) 24 útvarů', 'B) 25 útvarů', 'C) 26 útvarů', 'D) 28 útvarů', 'E) jiný počet útvarů'], 'ln': 0,
     'sol': ['Označme počet trojúhelníků $t$ a čtverců $s = t-2$. Sirek je $3t+4s = 90$, tedy $3t+4(t-2) = 90$, $7t = 98$, $t = 14$ a $s = 12$.',
             'Celkem $14+12 = 26$ útvarů.'],
     'ans': 'C) 26 útvarů', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['rovnice', 'modelovani', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5C 2026 – úloha 13', 'zad': [
        'Sourozenci Jitka, Klára a Max dostali od babičky po 40 čokoládových mincích. Jitka snědla jen 8 svých mincí. Klára snědla už 16 svých mincí. Max má ještě všech 40 mincí.',
        'Přiřaďte ke každé nedokončené větě (13.1–13.3) chybějící část (A–F) tak, aby vzniklo pravdivé tvrzení.',
        '13.1 Jitka má…',
        '13.2 Klára má…',
        '13.3 Max má…'],
     'opts': ['A) dvakrát více mincí, než má jeden ze zbývajících sourozenců.',
              'B) o čtvrtinu více mincí, než má jeden ze zbývajících sourozenců.',
              'C) méně mincí, než snědli všichni tři sourozenci dohromady.',
              'D) o třetinu méně mincí, než snědl jeden ze zbývajících sourozenců.',
              'E) třikrát více mincí, než snědli dohromady oba zbývající sourozenci.',
              'F) o polovinu méně mincí, než mají zbývající dva sourozenci dohromady.'], 'ln': 0,
     'sol': ['Jitka má $40-8 = 32$ mincí, Klára $40-16 = 24$ mincí, Max $40$ mincí.',
             '13.1 Klára a Max mají dohromady $24+40 = 64$; polovina je $32$, tj. Jitka má o polovinu méně → F.',
             '13.2 Jitka a Max snědli dohromady $8+0 = 8$; trojnásobek je $24$ = počet Klářiných mincí → E.',
             '13.3 Jitka má $32$ mincí; o čtvrtinu více je $32+8 = 40$ = počet Maxových mincí → B.'],
     'ans': '13.1: F; 13.2: E; 13.3: B', 'pts': 5, 'mins': 6, 'diff': '3',
     'codes': B + ['aritmetika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5C 2026 – úloha 14', 'zad': [
        'První obrazec je čtverec. Druhý obrazec má tvar obdélníku a vznikl z prvního obrazce přidáním dvou menších čtverců. Každý další obrazec má opět tvar obdélníku a vznikne tak, že u kratší strany předchozího obrazce přidáme tolik menších čtverců, kolikátý obrazec vytváříme (viz obrázek). Např. 3. obrazec vznikl z 2. obrazce přidáním tří menších čtverců. Obvod 2. obrazce měří 300 cm.',
        '14.1 Vypočtěte, kolik cm měří strana 1. obrazce.',
        '14.2 Vypočtěte, o kolik cm se liší obvod 4. obrazce a obvod 5. obrazce.',
        '14.3 Vypočtěte, kolik cm měří obvod 6. obrazce.'],
     'opts': None, 'ln': 3, 'svg': SVG14, 'fn': 'obrazce.svg',
     'alt': 'První obrazec čtverec, druhý a třetí obrazec obdélníky vzniklé přidáním menších čtverců.', 'cap': '1., 2. a 3. obrazec',
     'sol': ['Kratší strana každého obrazce má stále délku strany 1. obrazce $a$. K vytvoření $k$-tého obrazce přidáme $k$ menších čtverců o straně $a/k$, čímž se delší strana prodlouží o $a/k$.',
             '14.1 Obvod 2. obrazce: čtverec o straně $a$ se prodlouží o $a/2$, obvod je $2\\cdot(a+\\frac{3a}{2}) = 5a = 300$, tedy $a = 60$ cm.',
             '14.2 Delší strana: 4. obrazec $60+30+20+15 = 125$ cm, 5. obrazec $125+12 = 137$ cm. Obvody jsou $2\\cdot(60+125) = 370$ cm a $2\\cdot(60+137) = 394$ cm; liší se o $24$ cm.',
             '14.3 6. obrazec: delší strana $137+10 = 147$ cm, obvod $2\\cdot(60+147) = 414$ cm.'],
     'ans': '14.1: $60$ cm; 14.2: o $24$ cm; 14.3: $414$ cm', 'pts': 4, 'mins': 7, 'diff': '4',
     'codes': B + ['posloupnosti', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M5PCD26C0T03'
    gen.YEAR = 2026

    def dollars_ok(s): return s.count('$') % 2 == 0
    errors = []; names = set()
    for p in PROBLEMS:
        if p['name'] in names: errors.append('DUP název: ' + p['name'])
        names.add(p['name'])
        for t in [p['name'], p['ans']] + list(p['zad']) + list(p['sol']) + (p.get('opts') or []):
            if not dollars_ok(t): errors.append('Nepárový $: ' + t[:70])
        if p.get('svg') and ("'" in p['svg'] or '\\' in p['svg']):
            errors.append('SVG zakázaný znak: ' + p['name'])
        if p.get('svg') and not p.get('alt'): errors.append('Obrázek bez alt: ' + p['name'])
        for lbl, obj in (('content', gen.py_content_json(p)), ('solution', gen.py_solution_json(p)), ('answer', gen.py_answer_json(p))):
            try: json.loads(json.dumps(obj, ensure_ascii=False))
            except Exception as e: errors.append(f'JSON {lbl} {p["name"]}: {e}')
    if errors:
        print('CHYBY:'); [print('  -', e) for e in errors]; sys.exit(1)
    print('Validace OK:', len(PROBLEMS), 'úloh')
    outdir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'out')
    os.makedirs(outdir, exist_ok=True)
    tot = 0
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M5C-2026')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
