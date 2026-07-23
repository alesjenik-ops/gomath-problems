# -*- coding: utf-8 -*-
# CERMAT – Jednotná přijímací zkouška 2021, MATEMATIKA 5 (osmileté obory, 5. ročník),
# varianta D (2. náhradní termín). Kód testu: M5PDD21C0T04.
# 14 úloh; po rozdělení izolovaných poduúloh 17 úloh.
# Zdroj odpovědí: klíč správných řešení (KSR); struktura ověřena záznamovým archem (VZA).

# ---- SVG obrázky (bez ' a \) ----

# úloha 2: číselná osa, 16 stejných dílků; dáno 45 (7. ryska), A (9. ryska), B (14. ryska)
def _numline():
    ox = 40; d = 30; y = 70; n = 16
    W = ox * 2 + n * d + 20
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {W} 120" font-family="sans-serif">']
    s.append(f'<line x1="{ox}" y1="{y}" x2="{ox+n*d+16}" y2="{y}" stroke="#000" stroke-width="2"/>')
    s.append(f'<polygon points="{ox+n*d+16},{y} {ox+n*d+4},{y-6} {ox+n*d+4},{y+6}" fill="#000"/>')
    for i in range(n + 1):
        x = ox + i * d
        s.append(f'<line x1="{x}" y1="{y-8}" x2="{x}" y2="{y+8}" stroke="#000" stroke-width="1.4"/>')
    for i, lab in [(6, "45"), (8, "A"), (13, "B")]:
        x = ox + i * d
        s.append(f'<text x="{x}" y="{y+30}" font-size="16" text-anchor="middle" font-style="italic">{lab}</text>')
    s.append('</svg>')
    return "".join(s)
SVG2 = _numline()

# úloha 6: obrazec ABCDEF = čtverec + rovnostranný (vlevo) + rovnoramenný (vpravo) trojúhelník
SVG6 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 260" font-family="sans-serif">
<polygon points="180,80 300,80 300,200 180,200" fill="none" stroke="#000" stroke-width="1.5"/>
<polygon points="180,80 80,140 180,200" fill="none" stroke="#000" stroke-width="1.5"/>
<polygon points="300,80 560,140 300,200" fill="none" stroke="#000" stroke-width="1.5"/>
<text x="168" y="74" font-size="15" font-style="italic">E</text>
<text x="304" y="74" font-size="15" font-style="italic">D</text>
<text x="166" y="218" font-size="15" font-style="italic">A</text>
<text x="300" y="218" font-size="15" font-style="italic">B</text>
<text x="60" y="144" font-size="15" font-style="italic">F</text>
<text x="568" y="144" font-size="15" font-style="italic">C</text>
</svg>"""

# úloha 7.1: body N, O, P
SVG7_1 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif">
<rect x="6" y="6" width="448" height="288" fill="none" stroke="#ccc"/>
<text x="184" y="110" font-size="16">×</text><text x="182" y="128" font-size="15" font-style="italic">O</text>
<text x="356" y="110" font-size="16">×</text><text x="354" y="128" font-size="15" font-style="italic">P</text>
<text x="206" y="196" font-size="16">×</text><text x="204" y="214" font-size="15" font-style="italic">N</text>
</svg>"""

# úloha 7.2: polopřímka LS a bod U
SVG7_2 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif">
<rect x="6" y="6" width="448" height="288" fill="none" stroke="#ccc"/>
<line x1="330" y1="60" x2="430" y2="260" stroke="#000" stroke-width="2"/>
<line x1="374" y1="196" x2="392" y2="184" stroke="#000" stroke-width="1.4"/>
<text x="398" y="196" font-size="15" font-style="italic">S</text>
<text x="428" y="270" font-size="15" font-style="italic">L</text>
<text x="352" y="204" font-size="16">×</text><text x="350" y="222" font-size="15" font-style="italic">U</text>
</svg>"""

# úloha 8: tři útvary A, B, C ve čtvercové síti (8x6); zjištěné tmavé čtverce
def _grids():
    cell = 16; cols = 8; rows = 6; gap = 56; ox = 20; oy = 34
    gw = cols * cell
    figs = {'A': [(4, 0), (3, 1), (5, 1), (2, 2), (3, 3), (5, 3), (4, 4)],
            'B': [(2, 0), (1, 1), (2, 1), (3, 2), (4, 3), (4, 4), (5, 4), (6, 4), (5, 5)],
            'C': [(3, 1), (3, 2), (5, 2), (4, 3), (5, 3)]}
    W = ox * 2 + 3 * gw + 2 * gap
    rects = []; path = []; labels = []
    x0 = ox
    for name in ['A', 'B', 'C']:
        labels.append(f'<text x="{x0+gw//2}" y="{oy-12}" text-anchor="middle" font-weight="bold">{name}</text>')
        for (cx, cy) in figs[name]:
            rects.append(f'<rect x="{x0+cx*cell}" y="{oy+cy*cell}" width="{cell}" height="{cell}"/>')
        for i in range(cols + 1):
            xx = x0 + i * cell; path.append(f'M{xx} {oy}V{oy+rows*cell}')
        for j in range(rows + 1):
            yy = oy + j * cell; path.append(f'M{x0} {yy}H{x0+gw}')
        x0 += gw + gap
    return (f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {W} {oy+rows*cell+20}" font-family="sans-serif" font-size="15">'
            + '<g fill="#a9a9a9">' + ''.join(rects) + '</g>'
            + f'<path d="{"".join(path)}" fill="none" stroke="#000" stroke-width="0.8"/>'
            + ''.join(labels) + '</svg>')
SVG8 = _grids()

# úloha 9: sloupcový graf, 1.-3. kolo (25, 40, 20 bodů), 4. kolo neznámé; dílek grafu 5 bodů
def _bars9():
    x0 = 70; y0 = 250; unit = 4; bw = 46; gap = 28
    vals = [('1. kolo', 25, False), ('2. kolo', 40, False), ('3. kolo', 20, False), ('4. kolo', None, True)]
    W = 430; H = 300
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {W} {H}" font-family="sans-serif">']
    for v in range(0, 51, 5):
        yy = y0 - v * unit
        s.append(f'<line x1="{x0}" y1="{yy}" x2="{x0+4*(bw+gap)}" y2="{yy}" stroke="#bbb" stroke-width="0.8"/>')
    s.append(f'<line x1="{x0}" y1="30" x2="{x0}" y2="{y0}" stroke="#000" stroke-width="1.5"/>')
    s.append(f'<line x1="{x0}" y1="{y0}" x2="{x0+4*(bw+gap)}" y2="{y0}" stroke="#000" stroke-width="1.5"/>')
    x = x0 + gap
    for name, v, unk in vals:
        if unk:
            s.append(f'<rect x="{x}" y="{y0-30*unit}" width="{bw}" height="{30*unit}" fill="none" stroke="#888" stroke-width="1" stroke-dasharray="4 4"/>')
            s.append(f'<text x="{x+bw//2}" y="{y0-14*unit}" font-size="22" text-anchor="middle" font-weight="bold">?</text>')
        else:
            h = v * unit
            s.append(f'<rect x="{x}" y="{y0-h}" width="{bw}" height="{h}" fill="#666" stroke="#000"/>')
        s.append(f'<text x="{x+bw//2}" y="{y0+16}" font-size="12" text-anchor="middle">{name}</text>')
        x += bw + gap
    s.append('<text x="20" y="140" font-size="12" transform="rotate(-90 20 140)" text-anchor="middle">Počet bodů</text>')
    s.append(f'<text x="{x0-6}" y="{y0+4}" font-size="12" text-anchor="end">0</text>')
    s.append('</svg>')
    return "".join(s)
SVG9 = _bars9()

# úloha 10: stavba ze tří spojených kvádrů; výšky 6, 7, 5; šířky 3; hloubka 4
def _building():
    uy = 20; uw = 20; base = 230; dx = 34; dy = -24
    # (x_left, width_units, height_units)
    boxes = [(40, 3, 6), (100, 3, 7), (160, 3, 5)]
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 300" font-family="sans-serif">']
    s.append('<text x="150" y="20" font-size="14" text-anchor="middle">Stavba</text>')
    for (xl, wu, hu) in boxes:
        xr = xl + wu * uw; top = base - hu * uy
        s.append(f'<rect x="{xl}" y="{top}" width="{wu*uw}" height="{hu*uy}" fill="#fff" stroke="#000" stroke-width="1.4"/>')
        s.append(f'<polygon points="{xl},{top} {xr},{top} {xr+dx},{top+dy} {xl+dx},{top+dy}" fill="#f2f2f2" stroke="#000" stroke-width="1.2"/>')
    # pravá boční stěna nejpravějšího kvádru
    xr = 160 + 3 * uw; top = base - 5 * uy
    s.append(f'<polygon points="{xr},{top} {xr+dx},{top+dy} {xr+dx},{base+dy} {xr},{base}" fill="#e8e8e8" stroke="#000" stroke-width="1.2"/>')
    # kóty
    s.append(f'<text x="30" y="{base-60}" font-size="13" text-anchor="end">6</text>')
    s.append(f'<text x="{xr+dx+8}" y="{base+dy-40}" font-size="13">5</text>')
    s.append(f'<text x="{160+3*uw+6}" y="{base-5*uy-16}" font-size="13">2</text>')
    for cx in [70, 130, 190]:
        s.append(f'<text x="{cx}" y="{base+16}" font-size="13" text-anchor="middle">3</text>')
    s.append(f'<text x="{40+dx//2-6}" y="{base-6*uy+dy+6}" font-size="13">4</text>')
    s.append('</svg>')
    return "".join(s)
SVG10 = _building()

# úloha 12: plot z dlouhých a krátkých tyček s opěrami a patkami (schematicky)
SVG12 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 190" font-family="sans-serif">
<line x1="20" y1="150" x2="400" y2="150" stroke="#000" stroke-width="1.5"/>
<line x1="40" y1="60" x2="60" y2="150" stroke="#000" stroke-width="2"/>
<line x1="60" y1="60" x2="40" y2="150" stroke="#000" stroke-width="2"/>
<polygon points="40,150 34,160 46,160" fill="#888" stroke="#000"/>
<polygon points="60,150 54,160 66,160" fill="#888" stroke="#000"/>
<line x1="90" y1="72" x2="90" y2="150" stroke="#000"/>
<line x1="110" y1="74" x2="110" y2="150" stroke="#000"/>
<line x1="130" y1="76" x2="130" y2="150" stroke="#000"/>
<line x1="150" y1="78" x2="150" y2="150" stroke="#000"/>
<line x1="170" y1="80" x2="170" y2="150" stroke="#000"/>
<line x1="190" y1="82" x2="190" y2="150" stroke="#000"/>
<line x1="210" y1="84" x2="210" y2="150" stroke="#000"/>
<line x1="340" y1="70" x2="360" y2="150" stroke="#000" stroke-width="2"/>
<line x1="360" y1="70" x2="340" y2="150" stroke="#000" stroke-width="2"/>
<polygon points="340,150 334,160 346,160" fill="#888" stroke="#000"/>
<polygon points="360,150 354,160 366,160" fill="#888" stroke="#000"/>
<line x1="40" y1="66" x2="360" y2="90" stroke="#000" stroke-width="1.4"/>
<line x1="270" y1="176" x2="345" y2="158" stroke="#000" stroke-width="0.8"/>
<text x="230" y="182" font-size="12" text-anchor="end">patka</text>
</svg>"""

# úloha 13: tři nákresy s kroužky a výpočty (schematicky)
def _nakresy():
    r = 15
    circles = []      # normální kroužky (šedé)
    bolds = []        # silně ohraničené kroužky
    arcpaths = []     # oblouky
    txt = []          # popisky (operace, plus, šipky, čísla, názvy)

    def C(cx, cy, num='', bold=False):
        (bolds if bold else circles).append(f'<circle cx="{cx}" cy="{cy}" r="{r}"/>')
        if num:
            txt.append(f'<text x="{cx}" y="{cy+5}" text-anchor="middle" font-weight="bold">{num}</text>')

    def A(x1, x2, y, up, lab):
        y1 = y - r if up else y + r
        my = (y - r - 20) if up else (y + r + 20)
        ly = (y - r - 24) if up else (y + r + 27)
        arcpaths.append(f'M{x1} {y1}Q{(x1+x2)//2} {my} {x2} {y1}')
        txt.append(f'<text x="{(x1+x2)//2}" y="{ly}" text-anchor="middle">{lab}</text>')

    def sym(x, y, ch):
        txt.append(f'<text x="{x}" y="{y+5}" text-anchor="middle">{ch}</text>')

    def gadget(y, top, bot, boldpos, given):
        # kroužky: 40, 96, 144, 218 ; horní šipka 40->96, dolní 40->144
        C(40, y, given.get(0, ''), boldpos == 0)
        C(96, y, given.get(1, ''), boldpos == 1)
        C(144, y, given.get(2, ''), boldpos == 2)
        C(218, y, given.get(3, ''), boldpos == 3)
        A(40, 96, y, True, top); A(40, 144, y, False, bot)
        sym(120, y, '+'); sym(183, y, '→')

    def gadget2(y, top, bot, given, boldpos=None):
        # navazuje na kroužek 218: 274, 322, 396 ; horní 218->274, dolní 218->322
        C(274, y, given.get(0, ''), boldpos == 0)
        C(322, y, given.get(1, ''), boldpos == 1)
        C(396, y, given.get(2, ''), boldpos == 2)
        A(218, 274, y, True, top); A(218, 322, y, False, bot)
        sym(298, y, '+'); sym(361, y, '→')

    # 13.1 – jeden gadget, silně ohraničený je výsledek (poz. 3), ve spodním kroužku 18 (poz. 2)
    y = 52; txt.append(f'<text x="6" y="{y-30}">13.1</text>')
    gadget(y, '−1', '+6', 3, {2: '18'})

    # 13.2 – dva gadgety, bold horní kroužek první části (poz. 1); ve druhé horní kroužek 64
    y = 150; txt.append(f'<text x="6" y="{y-30}">13.2</text>')
    gadget(y, '+3', '−2', 1, {})
    gadget2(y, '+3', '−2', {0: '64'})

    # 13.3 – dva gadgety, bold dolní kroužek první části (poz. 2); ve druhé výsledek 120
    y = 248; txt.append(f'<text x="6" y="{y-30}">13.3</text>')
    gadget(y, '−3', '−5', 2, {})
    gadget2(y, '−3', '−5', {2: '120'})

    return ('<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 430 300" font-family="sans-serif" font-size="13">'
            + f'<path d="{"".join(arcpaths)}" fill="none" stroke="#000" stroke-width="1.1"/>'
            + '<g fill="#fff" stroke="#777" stroke-width="1.3">' + ''.join(circles) + '</g>'
            + '<g fill="#fff" stroke="#000" stroke-width="3">' + ''.join(bolds) + '</g>'
            + ''.join(txt) + '</svg>')
SVG13 = _nakresy()

B = ['zs1']  # 5. ročník ZŠ (přijímačky na osmileté obory); kód r5 v taxonomii není

PROBLEMS = [
    {'name': 'CERMAT M5D 2021 – úloha 1.1', 'zad': ['Vypočtěte: $(11\\,706-7\\,302):12=$'], 'opts': None, 'ln': 2,
     'sol': ['$(11\\,706-7\\,302):12 = 4\\,404:12 = 367$.'], 'ans': '$367$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5D 2021 – úloha 1.2', 'zad': ['Vypočtěte: $2\\cdot 1\\,600-585-85\\cdot 20=$'], 'opts': None, 'ln': 2,
     'sol': ['$3\\,200-585-1\\,700 = 915$.'], 'ans': '$915$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5D 2021 – úloha 2', 'zad': [
        'Na číselné ose je zobrazeno šestnáct stejných dílků, číslo $45$ a dvě neznámá čísla $A$ a $B$. Číslo $B$ je dvakrát větší než číslo $A$. Součet čísel $A$ a $B$ je stejný jako součet čísel $45$ a $C$.',
        '2.1 K odpovídajícímu bodu číselné osy zapište číslo $0$.',
        '2.2 K odpovídajícímu bodu číselné osy zapište číslo $C$.',
        'V záznamovém archu oba body na ose zvýrazněte.'],
     'opts': None, 'ln': 0, 'svg': SVG2, 'fn': 'cislena-osa.svg',
     'alt': 'Číselná osa se šestnácti stejnými dílky; vyznačeno je číslo 45 a body A a B.',
     'cap': 'Číselná osa k úloze 2',
     'sol': ['Vzdálenost mezi $A$ a $B$ je pět dílků; protože $B=2A$, odpovídá $A$ také pěti dílkům. Číslo $45$ je tři dílky vpravo od nuly, proto jeden dílek $=45:3=15$. Odtud $A=75$ a $B=150$.',
             '2.1 Číslo $0$ leží tři dílky vlevo od čísla $45$.',
             '2.2 Ze vztahu $A+B=45+C$ plyne $75+150=45+C$, tedy $C=180$; bod $C$ leží dva dílky vpravo od bodu $B$.'],
     'ans': '2.1: bod $0$ je tři dílky vlevo od čísla $45$; 2.2: $C=180$ (dva dílky vpravo od bodu $B$)',
     'pts': 3, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5D 2021 – úloha 3.1', 'zad': [
        'Telefonní hovor trval $8$ minut a $55$ sekund. Během hovoru blikala žárovka. Žárovka poprvé blikla po prvních $25$ sekundách hovoru a poté znovu po každých $25$ sekundách.',
        'Určete, kolikrát během celého hovoru blikla žárovka.'], 'opts': None, 'ln': 2,
     'sol': ['Hovor trval $8\\cdot 60+55=535$ sekund. Žárovka blikne v čase $25, 50, 75, \\ldots$ Počet bliknutí je $535:25=21$ (zbytek $10$), tedy $21$krát.'],
     'ans': '$21$krát', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5D 2021 – úloha 3.2', 'zad': [
        'Řeka Labe protéká pouze dvěma státy a délka celého jejího toku je $1\\,094$ km. V Německu je tok Labe o $352$ km delší než v České republice.',
        'Vypočtěte délku toku Labe v Německu.'], 'opts': None, 'ln': 2,
     'sol': ['Délka toku v České republice: $(1\\,094-352):2=371$ km. Délka toku v Německu: $371+352=723$ km.'],
     'ans': '$723$ km', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5D 2021 – úloha 4', 'zad': [
        'V dětské hře se smí provádět pouze následující nákupy: za $5$ mincí lze koupit $3$ autíčka, za $3$ mince lze koupit $4$ figurky.',
        '4.1 Amélie si chce koupit několik autíček a dvakrát tolik figurek. Určete nejmenší počet mincí, které k takovému nákupu potřebuje.',
        '4.2 Franta si chce koupit přesně o $10$ autíček více než figurek. Určete nejmenší počet mincí, které k takovému nákupu potřebuje.'],
     'opts': None, 'ln': 4,
     'sol': ['4.1 Autíčka se kupují po $3$, figurky po $4$. Počet figurek je dvojnásobek počtu autíček, proto počet autíček musí být sudý a dělitelný $3$, tedy nejméně $6$. Pak $6$ autíček ($2\\cdot 5=10$ mincí) a $12$ figurek ($3\\cdot 3=9$ mincí), celkem $19$ mincí.',
             '4.2 Počet figurek je násobek $4$, počet autíček násobek $3$ a o $10$ větší. Nejmenší řešení: $8$ figurek a $18$ autíček. Mince: $18$ autíček $=6\\cdot 5=30$, $8$ figurek $=2\\cdot 3=6$, celkem $36$ mincí.'],
     'ans': '4.1: $19$ mincí; 4.2: $36$ mincí', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5D 2021 – úloha 5', 'zad': [
        'Bílá krabička je prázdná, v zelené krabičce jsou jen zelené kuličky a v modré krabičce jsou jen modré kuličky. Modrých kuliček je $60$. Do bílé krabičky přendáme ze zelené a modré krabičky tolik kuliček, aby byl ve všech třech krabičkách stejný počet kuliček. Ze zelené krabičky tak musíme přendat o $9$ kuliček více než z modré krabičky.',
        '5.1 Určete počet všech zelených kuliček.',
        '5.2 Vypočtěte, kolik kuliček zůstane v modré krabičce.',
        '5.3 Vypočtěte, kolik zelených kuliček přendáme do bílé krabičky.'], 'opts': None, 'ln': 4,
     'sol': ['Po přendání je ve všech třech krabičkách stejný počet $t$. Z modré přendáme $m$ kuliček, ze zelené $m+9$. Modrá: $60-m=t$; bílá: $(m+9)+m=t$. Odtud $2m+9=60-m$, tedy $m=17$ a $t=43$.',
             '5.1 Zelených bylo $t+(m+9)=43+26=69$.',
             '5.2 V modré zůstane $t=43$ kuliček.',
             '5.3 Ze zelené přendáme $m+9=26$ kuliček.'],
     'ans': '5.1: $69$ zelených kuliček; 5.2: $43$ kuliček; 5.3: $26$ zelených kuliček',
     'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5D 2021 – úloha 6', 'zad': [
        'Obrazec $ABCDEF$ se skládá ze čtverce, rovnostranného a rovnoramenného trojúhelníku. Obvod čtverce je $24$ cm, obvod rovnoramenného trojúhelníku je o třetinu větší než obvod čtverce.',
        '6.1 Vypočtěte v cm obvod rovnostranného trojúhelníku.',
        '6.2 Vypočtěte v cm obvod rovnoramenného trojúhelníku.',
        '6.3 Vypočtěte v cm obvod celého obrazce $ABCDEF$.'],
     'opts': None, 'ln': 4, 'svg': SVG6, 'fn': 'obrazec-abcdef.svg',
     'alt': 'Obrazec ABCDEF: uprostřed čtverec, vlevo rovnostranný trojúhelník, vpravo rovnoramenný trojúhelník.',
     'cap': 'Obrazec ABCDEF',
     'sol': ['Strana čtverce je $24:4=6$ cm.',
             '6.1 Rovnostranný trojúhelník má stranu $6$ cm, obvod $3\\cdot 6=18$ cm.',
             '6.2 Obvod rovnoramenného trojúhelníku je o třetinu větší než $24$ cm, tj. $24+8=32$ cm.',
             '6.3 Ramena rovnoramenného trojúhelníku měří $(32-6):2=13$ cm. Obvod obrazce $=6+6+6+6+13+13=50$ cm (strany $AB$ a $DE$ čtverce, ramena $EF$ a $FA$ rovnostranného a ramena $BC$ a $CD$ rovnoramenného trojúhelníku).'],
     'ans': '6.1: $18$ cm; 6.2: $32$ cm; 6.3: $50$ cm', 'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5D 2021 – úloha 7.1 (konstrukce)', 'zad': [
        'V rovině leží body $N$, $O$, $P$ (viz obrázek).',
        'Body $N$, $O$ jsou středy protějších stran $AB$ a $CD$ obdélníku $ABCD$ a bod $P$ leží na straně $BC$ tohoto obdélníku.',
        'Sestrojte vrcholy obdélníku $ABCD$, označte je písmeny a obdélník narýsujte.'],
     'opts': None, 'ln': 0, 'svg': SVG7_1, 'fn': 'body-nop.svg',
     'alt': 'Tři body N, O, P v rovině.', 'cap': 'Výchozí obrázek k úloze 7.1',
     'sol': ['Přímka $NO$ je osou obdélníku kolmou ke stranám $AB$ a $CD$. V bodě $N$ vztyčíme kolmici k $NO$ (přímka $AB$), v bodě $O$ kolmici k $NO$ (přímka $CD$). Bodem $P$ vedeme rovnoběžku s $NO$ (přímka $BC$); ta protne přímku $AB$ ve vrcholu $B$ a přímku $CD$ ve vrcholu $C$. Vrchol $A$ je obrazem $B$ v souměrnosti podle $N$, vrchol $D$ obrazem $C$ podle $O$.'],
     'ans': 'Konstrukce obdélníku $ABCD$: $N$ střed strany $AB$, $O$ střed strany $CD$, $P$ na straně $BC$ (viz obrázek v klíči).',
     'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5D 2021 – úloha 7.2 (konstrukce)', 'zad': [
        'V rovině leží polopřímka $LS$ a bod $U$ (viz obrázek).',
        'Bod $L$ je vrchol rovnoramenného trojúhelníku $KLM$, bod $S$ je střed strany $LM$. V tomto trojúhelníku je každé z obou ramen dvakrát delší než základna. Bod $U$ leží uvnitř trojúhelníku $KLM$.',
        'Sestrojte vrcholy $K$, $M$ trojúhelníku $KLM$, označte je písmeny a trojúhelník narýsujte. Najděte všechna $3$ řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG7_2, 'fn': 'poloprimka-ls.svg',
     'alt': 'Polopřímka LS a bod U ležící vlevo od ní.', 'cap': 'Výchozí obrázek k úloze 7.2',
     'sol': ['Bod $S$ je střed $LM$, proto bod $M$ leží na polopřímce $LS$ tak, že $|LM|=2|LS|$. Podle toho, která strana je základna (ramena jsou dvakrát delší než základna), vznikají tři rovnoramenné trojúhelníky $KLM$; vrchol $K$ se v každém případě volí tak, aby bod $U$ ležel uvnitř trojúhelníku. Úloha má tři řešení $K_1$, $K_2$, $K_3$.'],
     'ans': 'Tři rovnoramenné trojúhelníky $KLM$ ($M$ na polopřímce $LS$, $|LM|=2|LS|$; vrcholy $K_1$, $K_2$, $K_3$) – viz obrázek v klíči.',
     'pts': 3, 'mins': 7, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5D 2021 – úloha 8', 'zad': [
        'Ve čtvercové síti jsou z tmavých čtverců složeny tři útvary $A$, $B$, $C$ (viz obrázek). Ke každému útvaru doplníme jediný tmavý čtverec tak, aby byl útvar osově souměrný a měl co nejvíce různých os souměrnosti (svislých, vodorovných nebo šikmých).',
        'Rozhodněte o každém z tvrzení 8.1–8.3, zda je pravdivé (A), či nikoli (N).',
        '8.1 Útvar $A$ doplněný o požadovaný čtverec má $4$ osy souměrnosti.',
        '8.2 Útvar $B$ doplněný o požadovaný čtverec má $2$ osy souměrnosti.',
        '8.3 Útvar $C$ doplněný o požadovaný čtverec má pouze $1$ osu souměrnosti.'],
     'opts': None, 'ln': 0, 'svg': SVG8, 'fn': 'utvary-abc.svg',
     'alt': 'Tři útvary A, B, C složené z tmavých čtverců ve čtvercové síti.',
     'cap': 'Útvary A, B, C ve čtvercové síti',
     'sol': ['8.1 Útvar $A$ lze doplnit jedním čtvercem na útvar se čtyřmi osami souměrnosti → Ano.',
             '8.2 Útvar $B$ doplněný jedním čtvercem nemá $2$ osy souměrnosti → Ne.',
             '8.3 Útvar $C$ doplněný jedním čtvercem nemá pouze jednu osu souměrnosti → Ne.'],
     'ans': '8.1: Ano; 8.2: Ne; 8.3: Ne', 'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['planimetrie', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5D 2021 – úloha 9', 'zad': [
        'Soutěž měla čtyři kola. V grafu jsou uvedeny výsledky družstva v prvních třech kolech. V $1.$ kole družstvo získalo o $15$ bodů méně než ve $2.$ kole. Ve $4.$ kole družstvo získalo o polovinu více bodů než ve $3.$ kole.',
        'Kolik bodů získalo družstvo ve $4.$ kole?'],
     'opts': ['A) $25$ bodů', 'B) $30$ bodů', 'C) $35$ bodů', 'D) $40$ bodů', 'E) jiný počet bodů'],
     'ln': 0, 'svg': SVG9, 'fn': 'graf-kola.svg',
     'alt': 'Sloupcový graf s počty bodů v 1., 2. a 3. kole; 4. kolo je označeno otazníkem.',
     'cap': 'Počet bodů v jednotlivých kolech',
     'sol': ['Z grafu: $1.$ kolo $25$ bodů, $2.$ kolo $40$ bodů (o $15$ více), $3.$ kolo $20$ bodů. Ve $4.$ kole je $20+\\frac{1}{2}\\cdot 20=30$ bodů.'],
     'ans': 'B) $30$ bodů', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['statistika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5D 2021 – úloha 10', 'zad': [
        'Všechny díly stavebnice jsou pravidelné čtyřboké hranoly s rozměry $1$ cm $\\times$ $1$ cm $\\times$ $2$ cm. Ve stavbě, která má podobu tří spojených kvádrů, jsou díly naskládány bez mezer tak, aby stavba obsahovala co největší počet stojících dílů. Stojící díl má dole čtvercovou stěnu, ležící díl nikoli. Rozměry v obrázku jsou v cm.',
        'Kolik ležících dílů stavba obsahuje?'],
     'opts': ['A) $0$', 'B) $6$', 'C) $12$', 'D) $18$', 'E) $24$'],
     'ln': 0, 'svg': SVG10, 'fn': 'stavba-kvadry.svg',
     'alt': 'Stavba ze tří spojených kvádrů o výškách 6, 7 a 5 cm, šířkách 3 cm a hloubce 4 cm.',
     'cap': 'Stavba ze tří spojených kvádrů',
     'sol': ['Každý kvádr má podstavu $3\\times 4=12$ sloupečků. Výšky kvádrů jsou $6$, $7$ a $5$ cm, stojící díl je vysoký $2$ cm. Ve sloupci sudé výšky ($6$) vystačí jen stojící díly. U výšek $7$ a $5$ (lichých) zbude nahoře vrstva vysoká $1$ cm o $12$ čtverečcích, kterou vyplní ležící díly: $12:2=6$ v každém z těchto dvou kvádrů, celkem $12$ ležících dílů.'],
     'ans': 'C) $12$', 'pts': 2, 'mins': 5, 'diff': '4',
     'codes': B + ['stereometrie', 'modelovani', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5D 2021 – úloha 11', 'zad': [
        'Provaz je $216$ cm dlouhý. Třetina tohoto provazu je dvakrát delší než nit. Nit rozstřihneme na tři stejně dlouhé části.',
        'O kolik cm je provaz delší než jedna část niti?'],
     'opts': ['A) o $108$ cm', 'B) o $168$ cm', 'C) o $180$ cm', 'D) o $204$ cm', 'E) o jiný počet cm'], 'ln': 0,
     'sol': ['Třetina provazu je $216:3=72$ cm, což je dvakrát délka niti, tedy nit měří $36$ cm. Jedna část niti je $36:3=12$ cm. Provaz je delší o $216-12=204$ cm.'],
     'ans': 'D) o $204$ cm', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5D 2021 – úloha 12', 'zad': [
        'Podél řeky byl z dlouhých a krátkých tyček postaven plot. Každá opěra je sestavena ze dvou dlouhých tyček opatřených patkami. Plot začíná i končí opěrou a opěry se pravidelně opakují. Mezi každými dvěma sousedními opěrami jsou už jen svislé tyčky bez patek, a to vždy tři dlouhé a čtyři krátké. Všech dlouhých tyček (s patkami i bez patek) je v celém plotu o $80$ více než krátkých.',
        'Kolik patek bylo použito na stavbu celého plotu?'],
     'opts': ['A) $156$ patek', 'B) $158$ patek', 'C) $160$ patek', 'D) $162$ patek', 'E) jiný počet patek'],
     'ln': 0, 'svg': SVG12, 'fn': 'plot.svg',
     'alt': 'Plot z dlouhých a krátkých tyček s opěrami opatřenými patkami.',
     'cap': 'Plot s opěrami (schematicky)',
     'sol': ['Nechť je $p$ opěr; mezer mezi nimi je $p-1$. Dlouhých tyček je $2p+3(p-1)=5p-3$, krátkých $4(p-1)=4p-4$. Z podmínky $(5p-3)-(4p-4)=80$ plyne $p+1=80$, tedy $p=79$. Každá opěra má $2$ patky, celkem $2\\cdot 79=158$ patek.'],
     'ans': 'B) $158$ patek', 'pts': 2, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5D 2021 – úloha 13', 'zad': [
        'V každém nákresu se do prázdných kroužků doplňují čísla podle vyznačených výpočtů. Z levého kroužku vznikne horní kroužek přičtením čísla u horní šipky a dolní kroužek přičtením čísla u dolní šipky (záporné číslo znamená odečtení). Do silně ohraničeného kroužku patří součet horního a dolního kroužku. Ve vzoru: z čísla $4$ vznikne $4+1=5$ a $4+3=7$, součet $5+7=12$.',
        'Přiřaďte ke každému nákresu (13.1–13.3) číslo (A–F), které patří do silně ohraničeného kroužku.',
        '13.1 U horní šipky je $-1$, u dolní šipky $+6$; ve spodním kroužku je číslo $18$. Silně ohraničený je výsledkový (poslední) kroužek.',
        '13.2 Nákres je dvojitý, v obou částech je u horní šipky $+3$ a u dolní $-2$. Silně ohraničený je horní kroužek první části; ve druhé části je v horním kroužku číslo $64$.',
        '13.3 Nákres je dvojitý, v obou částech je u horní šipky $-3$ a u dolní $-5$. Silně ohraničený je dolní kroužek první části; ve druhé části je ve výsledkovém kroužku číslo $120$.'],
     'opts': ['A) číslo menší než $30$', 'B) $30$', 'C) $31$', 'D) $32$', 'E) $33$', 'F) číslo větší než $33$'],
     'ln': 0, 'svg': SVG13, 'fn': 'nakresy.svg',
     'alt': 'Tři schematické nákresy s kroužky a šipkami označenými výpočty.',
     'cap': 'Nákresy k úloze 13',
     'sol': ['13.1 Označíme levý kroužek $x$. Spodní kroužek $x+6=18$, tedy $x=12$; horní $x-1=11$; výsledek $11+18=29$ → A.',
             '13.2 Ve druhé části $x_2+3=64$, tedy $x_2=61$; to je výsledek první části: $(x+3)+(x-2)=2x+1=61$, tedy $x=30$; silně ohraničený horní kroužek $x+3=33$ → E.',
             '13.3 Ve druhé části $2x_2-8=120$, tedy $x_2=64$; v první části $2x-8=64$, tedy $x=36$; silně ohraničený dolní kroužek $x-5=31$ → C.'],
     'ans': '13.1: A (číslo $29$); 13.2: E ($33$); 13.3: C ($31$)', 'pts': 5, 'mins': 6, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5D 2021 – úloha 14', 'zad': [
        'Do řady po sobě jdoucích kladných celých čísel přidáme za každé číslo dělitelné třemi toto číslo ještě jednou. Nová řada tak všechna čísla dělitelná třemi obsahuje dvakrát. V nové řadě je na $1.$ až $17.$ místě těchto $17$ čísel: $1, 2, 3, 3, 4, 5, 6, 6, 7, 8, 9, 9, 10, 11, 12, 12, 13, \\ldots$',
        '14.1 Určete, na kolikátém místě nové řady je číslo $100$.',
        '14.2 Určete, které číslo je na $100.$ místě nové řady.',
        '14.3 Určete, na kolika místech nové řady je mezi čísly $1$ až $101$ uvedeno sudé číslo.'],
     'opts': None, 'ln': 4,
     'sol': ['14.1 Před číslem $100$ je $33$ násobků tří ($3, 6, \\ldots, 99$), z nichž každý přidá jedno místo navíc. Číslo $100$ je proto na $100+33=133.$ místě.',
             '14.2 Čísla $1$ až $75$ zaberou $75+25=100$ míst (mezi nimi je $25$ násobků tří). Na $100.$ místě je tedy číslo $75$ (jeho druhý výskyt).',
             '14.3 Sudých čísel od $1$ do $101$ je $50$; z nich je $16$ dělitelných šesti (uvedených dvakrát): $6, 12, \\ldots, 96$. Sudá čísla zaberou $34\\cdot 1+16\\cdot 2=66$ míst.'],
     'ans': '14.1: na $133.$ místě; 14.2: $75$; 14.3: na $66$ místech', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['posloupnosti', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M5PDD21C0T04'
    gen.YEAR = 2021

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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M5D-2021')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
