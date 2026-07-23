# -*- coding: utf-8 -*-
# CERMAT - Jednotna prijimaci zkouska 2023, MATEMATIKA 7 (sestilete obory, 7. rocnik).
# Kod testu: M7PDD23C0T04. 16 uloh (po rozdeleni izolovanych podulohu 17 uloh).
# Zdroj odpovedi: klic spravnych reseni (KLIC).

import math

# ---- SVG obrazky (bez ' a \) ----

# uloha 3: ciselna osa, 13 bodu, 12 dilku; 20 nad bodem, body A, B, C
def _numline():
    x0 = 45; dx = 48; y = 80; n = 12
    endx = x0 + n * dx
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {endx+50} 140" font-family="sans-serif">']
    s.append(f'<line x1="{x0-10}" y1="{y}" x2="{endx+30}" y2="{y}" stroke="#000" stroke-width="1.5"/>')
    s.append(f'<polygon points="{endx+30},{y} {endx+20},{y-5} {endx+20},{y+5}" fill="#000"/>')
    s.append('<g stroke="#000">')
    for i in range(n + 1):
        x = x0 + i * dx
        s.append(f'<line x1="{x}" y1="{y-8}" x2="{x}" y2="{y+8}"/>')
    s.append('</g>')
    s.append(f'<text x="{x0+6*dx}" y="{y-16}" font-size="15" text-anchor="middle">20</text>')
    s.append('<g font-size="15" text-anchor="middle" font-style="italic">')
    for idx, lab in ((5, "A"), (8, "B"), (12, "C")):
        s.append(f'<text x="{x0+idx*dx}" y="{y+26}">{lab}</text>')
    s.append('</g></svg>')
    return "".join(s)
SVG3 = _numline()

# uloha 4: kruhovy diagram dne, 6 useku, sede useky I, IV, VI (uvnitr)
def _clock():
    cx, cy, R, ri = 170, 150, 100, 48
    def pt(r, ang):
        a = math.radians(ang)
        return (cx + r * math.sin(a), cy - r * math.cos(a))
    def f(p):
        return f"{p[0]:.1f} {p[1]:.1f}"
    gray = [(0, 60), (180, 240), (300, 360)]
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 340 300" font-family="sans-serif">']
    s.append('<g fill="#c9c9c9">')
    for a0, a1 in gray:
        s.append(f'<path d="M {cx} {cy} L {f(pt(R,a0))} A {R} {R} 0 0 1 {f(pt(R,a1))} Z"/>')
    s.append('</g>')
    s.append(f'<circle cx="{cx}" cy="{cy}" r="{ri}" fill="#fff"/>')
    s.append(f'<circle cx="{cx}" cy="{cy}" r="{R}" fill="none" stroke="#000"/>')
    s.append(f'<circle cx="{cx}" cy="{cy}" r="{ri}" fill="none" stroke="#000"/>')
    s.append('<g stroke="#000">')
    for k in range(6):
        pi = pt(ri, k * 60); po = pt(R, k * 60)
        s.append(f'<line x1="{pi[0]:.1f}" y1="{pi[1]:.1f}" x2="{po[0]:.1f}" y2="{po[1]:.1f}"/>')
    s.append('</g>')
    lab = ["I.", "II.", "III.", "IV.", "V.", "VI."]
    s.append('<g font-size="12" text-anchor="middle">')
    for k in range(6):
        pm = pt((R + ri) / 2, k * 60 + 30)
        s.append(f'<text x="{pm[0]:.1f}" y="{pm[1]+4:.1f}">{lab[k]}</text>')
    s.append(f'<text x="{cx}" y="40">pulnoc</text>')
    s.append(f'<text x="{cx}" y="278">poledne</text>')
    s.append('<text x="302" y="154">8:00</text>')
    s.append('<text x="40" y="154">16:00</text>')
    s.append('</g></svg>')
    return "".join(s)
SVG4 = _clock()

# uloha 5: rovnoramenne vahy, vlevo velke+male, vpravo stredni+2 male
SVG5 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 210" font-family="sans-serif">
<polygon points="210,150 195,185 225,185" fill="#777" stroke="#000"/>
<g stroke="#000" fill="none" stroke-width="2">
<line x1="70" y1="120" x2="350" y2="120"/>
<line x1="210" y1="120" x2="210" y2="150"/>
<path d="M 70 150 A 40 40 0 0 0 150 150"/>
<path d="M 270 150 A 40 40 0 0 0 350 150"/>
</g>
<g stroke="#000"><line x1="110" y1="120" x2="110" y2="150"/><line x1="310" y1="120" x2="310" y2="150"/></g>
<g fill="#bcbcbc" stroke="#000">
<rect x="82" y="112" width="30" height="34"/>
<rect x="120" y="130" width="16" height="16"/>
<rect x="276" y="120" width="24" height="26"/>
<rect x="306" y="130" width="16" height="16"/>
<rect x="326" y="130" width="16" height="16"/>
</g>
<g stroke="#000" fill="none">
<path d="M 80 104 L 80 100 L 140 100 L 140 104"/>
<path d="M 274 104 L 274 100 L 344 100 L 344 104"/>
</g>
<g font-size="13" text-anchor="middle"><text x="110" y="95">100 g</text><text x="310" y="95">100 g</text></g>
</svg>"""

# uloha 7: tri utvary A, B, C ve ctvercove siti, cislovane sede ctverce
def _grids():
    cell = 18
    subs = {
        "A": [(3,1,1),(2,2,2),(3,2,3),(4,2,4),(2,3,5),(3,3,6),(4,3,7),(5,3,8),(3,4,9)],
        "B": [(3,1,1),(4,1,2),(2,2,3),(3,2,4),(5,2,5),(6,2,6),(2,3,7),(4,3,8),(6,3,9),(2,4,10),(3,4,11),(5,4,12),(3,5,13),(4,5,14)],
        "C": [(3,1,1),(3,2,2),(2,3,3),(4,3,4),(3,4,5),(5,4,6),(6,4,7),(3,5,8),(3,6,9)],
    }
    cols = 7; rows = 7; ox0 = 20; oy = 40; gap = 40
    W = cols * cell
    p = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {3*W+2*gap+40} {rows*cell+66}" font-family="sans-serif">']
    p.append('<g fill="#8a8a8a" stroke="#555">')
    for gi, name in enumerate("ABC"):
        ox = ox0 + gi * (W + gap)
        for c, r, _ in subs[name]:
            p.append(f'<rect x="{ox+(c-1)*cell}" y="{oy+(r-1)*cell}" width="{cell}" height="{cell}"/>')
    p.append('</g><g fill="#fff" font-size="10" text-anchor="middle">')
    for gi, name in enumerate("ABC"):
        ox = ox0 + gi * (W + gap)
        for c, r, lab in subs[name]:
            p.append(f'<text x="{ox+(c-1)*cell+9}" y="{oy+(r-1)*cell+12}">{lab}</text>')
    p.append('</g><g font-size="13" text-anchor="middle" font-weight="bold">')
    for gi, name in enumerate("ABC"):
        ox = ox0 + gi * (W + gap)
        p.append(f'<text x="{ox+W/2:.0f}" y="{oy-14}">{name}</text>')
    p.append('</g></svg>')
    return "".join(p)
SVG7 = _grids()

# uloha 8: primka a a body P, Q, R
SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 210" font-family="sans-serif">
<line x1="40" y1="150" x2="420" y2="178" stroke="#000" stroke-width="2"/>
<text x="45" y="140" font-size="15" font-style="italic">a</text>
<g font-size="14"><text x="246" y="86" font-style="italic">Q</text><text x="243" y="102">x</text>
<text x="186" y="116" font-style="italic">P</text><text x="198" y="120">x</text>
<text x="366" y="132" font-style="italic">R</text><text x="352" y="136">x</text></g>
</svg>"""

# uloha 9: primky b, c a bod A na primce b
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 240" font-family="sans-serif">
<g stroke="#000" stroke-width="2"><line x1="55" y1="120" x2="410" y2="90"/><line x1="55" y1="135" x2="410" y2="215"/></g>
<g font-size="15" font-style="italic"><text x="416" y="90">c</text><text x="416" y="216">b</text><text x="228" y="192">A</text></g>
<line x1="238" y1="170" x2="242" y2="184" stroke="#000"/>
</svg>"""

# uloha 10: sloupcovy graf brigadniku 2018-2022
def _bars10():
    years = [("2018",14,10,8),("2019",None,4,7),("2020",13,None,2),("2021",16,5,None),("2022",9,6,8)]
    x0 = 70; base = 150; unit = 6; slot = 78; bw = 20
    W = 630
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {W} 300" font-family="sans-serif">']
    s.append(f'<line x1="{x0}" y1="30" x2="{x0}" y2="255" stroke="#000"/>')
    s.append(f'<line x1="{x0}" y1="{base}" x2="470" y2="{base}" stroke="#000"/>')
    s.append('<g font-size="10" text-anchor="end">')
    for v in range(0, 21, 4):
        s.append(f'<text x="{x0-6}" y="{base-v*unit+3}">{v}</text>')
    for v in range(4, 17, 4):
        s.append(f'<text x="{x0-6}" y="{base+v*unit+3}">{v}</text>')
    s.append('</g>')
    for i, (yr, P, N, O) in enumerate(years):
        cx = x0 + i * slot + 16
        if P is not None:
            h = P * unit; s.append(f'<rect x="{cx}" y="{base-h}" width="{bw}" height="{h}" fill="#8a8a8a" stroke="#000"/>')
        if N is not None:
            h = N * unit; s.append(f'<rect x="{cx+bw+3}" y="{base-h}" width="{bw}" height="{h}" fill="#e2e2e2" stroke="#000"/>')
        if O is not None:
            h = O * unit; s.append(f'<rect x="{cx+bw//2+1}" y="{base}" width="{bw}" height="{h}" fill="#111" stroke="#000"/>')
        s.append(f'<text x="{cx+bw}" y="{base+72}" font-size="11" text-anchor="middle">{yr}</text>')
    lx = 478
    s.append('<g font-size="10">')
    s.append(f'<rect x="{lx}" y="42" width="12" height="12" fill="#8a8a8a" stroke="#000"/><text x="{lx+16}" y="52">z predch. roku</text>')
    s.append(f'<rect x="{lx}" y="60" width="12" height="12" fill="#e2e2e2" stroke="#000"/><text x="{lx+16}" y="70">nove prijati</text>')
    s.append(f'<rect x="{lx}" y="78" width="12" height="12" fill="#111" stroke="#000"/><text x="{lx+16}" y="88">odesli</text>')
    s.append('</g></svg>')
    return "".join(s)
SVG10 = _bars10()

# uloha 11: velky obdelnik delitelny na 2 obdelniky nebo 2 ctverce
SVG11 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 150" font-family="sans-serif">
<g fill="none" stroke="#000" stroke-width="2"><rect x="40" y="45" width="150" height="72"/><rect x="230" y="45" width="150" height="72"/></g>
<g stroke="#000"><line x1="40" y1="81" x2="190" y2="81"/><line x1="305" y1="45" x2="305" y2="117"/></g>
</svg>"""

# uloha 12: trojuhelnik ABC, primka p (A, B), rovnobezka se stranou AC bodem B
SVG12 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 210" font-family="sans-serif">
<g stroke="#000" stroke-width="1.6" fill="none">
<line x1="185" y1="10" x2="360" y2="180"/>
<line x1="120" y1="180" x2="360" y2="180"/>
<line x1="230" y1="52" x2="120" y2="180"/>
<line x1="230" y1="52" x2="410" y2="52"/>
</g>
<g font-size="15" font-style="italic"><text x="230" y="44" text-anchor="middle">B</text><text x="366" y="192">A</text><text x="108" y="192">C</text></g>
<g font-size="13"><text x="333" y="174">&#945;</text><text x="138" y="174">&#946;</text><text x="228" y="76">&#946;</text><text x="150" y="172">&#947;</text>
<text x="188" y="46">2&#946;+&#947;</text><text x="252" y="70">30&#176;</text></g>
<g font-size="12"><text x="238" y="176">//</text><text x="316" y="49">//</text></g>
</svg>"""

# uloha 13: teleso ze 6 valcu - schematicka poznamka (prostorove teleso)
SVG13 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 120" font-family="sans-serif">
<text x="260" y="55" font-size="13" text-anchor="middle">Teleso ze 6 stejnych valcu a jeho pohledy A-E (viz testovy sesit).</text>
<text x="260" y="82" font-size="11" text-anchor="middle" fill="#666">Prostorove teleso nelze verne prenest do SVG; posuzuje se podle originalu.</text>
</svg>"""

# uloha 16: obrazce ze sedych trojuhelniku (1, 2, 3 patra) s puntiky
def _triangles():
    s = 22; h = 19; oy = 25
    figs = [(50, 1), (180, 2), (330, 3)]
    p = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 130" font-family="sans-serif">']
    p.append('<g fill="#c9c9c9" stroke="#555">')
    for ox, n in figs:
        def P(k, j, ox=ox):
            return (ox + (j - k / 2.0) * s, oy + k * h)
        for r in range(n):
            for i in range(r + 1):
                a = P(r, i); b = P(r + 1, i); c = P(r + 1, i + 1)
                p.append(f'<polygon points="{a[0]:.1f},{a[1]:.1f} {b[0]:.1f},{b[1]:.1f} {c[0]:.1f},{c[1]:.1f}"/>')
    p.append('</g><g fill="#000">')
    for ox, n in figs:
        def P(k, j, ox=ox):
            return (ox + (j - k / 2.0) * s, oy + k * h)
        for k in range(n + 1):
            for j in range(k + 1):
                q = P(k, j)
                p.append(f'<circle cx="{q[0]:.1f}" cy="{q[1]:.1f}" r="2.4"/>')
    p.append('</g><text x="428" y="72" font-size="22">...</text></svg>')
    return "".join(p)
SVG16 = _triangles()

B = ['zs2', 'r7']  # 7. rocnik ZS (sestilete obory)

PROBLEMS = [
    {'name': 'CERMAT M7D 2023 - uloha 1',
     'zad': ['Hmotnosti dvou zavazi jsou v pomeru $3:5$ a lisi se o $600$ g.',
             'Vypoctete v gramech hmotnost lehciho zavazi.'],
     'opts': None, 'ln': 2,
     'sol': ['Pomer $3:5$, rozdil $5-3=2$ dily odpovidaji $600$ g, tj. jeden dil $=300$ g. Lehci zavazi $=3\\cdot 300=900$ g.'],
     'ans': '$900$ g', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7D 2023 - uloha 2.1',
     'zad': ['Vypoctete a vysledek zapiste zlomkem v zakladnim tvaru: $\\frac{9}{14}\\cdot\\left(2\\cdot\\frac{1}{6}-\\frac{3}{8}\\cdot 4\\right)=$'],
     'opts': None, 'ln': 3,
     'sol': ['$2\\cdot\\frac{1}{6}=\\frac{1}{3}$, $\\frac{3}{8}\\cdot 4=\\frac{3}{2}$; zavorka $=\\frac{1}{3}-\\frac{3}{2}=-\\frac{7}{6}$. Pak $\\frac{9}{14}\\cdot\\left(-\\frac{7}{6}\\right)=-\\frac{63}{84}=-\\frac{3}{4}$.'],
     'ans': '$-\\frac{3}{4}$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7D 2023 - uloha 2.2',
     'zad': ['Vypoctete a vysledek zapiste zlomkem v zakladnim tvaru: $\\dfrac{\\frac{6}{7}-\\frac{9}{14}}{\\frac{8}{7}+\\frac{6}{7}:\\frac{3}{2}}=$'],
     'opts': None, 'ln': 3,
     'sol': ['Citatel: $\\frac{6}{7}-\\frac{9}{14}=\\frac{12}{14}-\\frac{9}{14}=\\frac{3}{14}$. Jmenovatel: $\\frac{6}{7}:\\frac{3}{2}=\\frac{6}{7}\\cdot\\frac{2}{3}=\\frac{4}{7}$, pak $\\frac{8}{7}+\\frac{4}{7}=\\frac{12}{7}$. Celkem $\\frac{3}{14}:\\frac{12}{7}=\\frac{3}{14}\\cdot\\frac{7}{12}=\\frac{1}{8}$.'],
     'ans': '$\\frac{1}{8}$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7D 2023 - uloha 3',
     'zad': ['Na ciselne ose je vyznaceno $13$ bodu, ktere oddeluji $12$ stejnych dilku. V jednom z techto bodu je cislo $20$ a body $A$, $B$, $C$ predstavuji tri kladna cisla. Cislo v bode $C$ je souctem cisla v bode $A$ a cisla v bode $B$.',
             '3.1 Vyznacte na ciselne ose bod $P$, v nemz je cislo $0$.',
             '3.2 Urcete cislo v bode $B$.'],
     'opts': None, 'ln': 2, 'svg': SVG3, 'fn': 'ciselna-osa.svg',
     'alt': 'Ciselna osa se 13 body a 12 stejnymi dilky; vyznaceno cislo 20 a body A, B, C.',
     'cap': 'Vychozi obrazek k uloze 3',
     'sol': ['Body oddeluji stejne dilky. Ze vztahu $C=A+B$ a polohy cisla $20$ plyne, ze jeden dilek ma hodnotu $4$ (pak $A=16$, $B=28$, $C=44=16+28$).',
             '3.1 Bod $P$ (cislo $0$) lezi pet dilku vlevo od bodu s cislem $20$.',
             '3.2 Bod $B$ je o dva dilky (o $8$) vpravo od cisla $20$, tedy $B=28$.'],
     'ans': '3.1: bod $P$ je pet dilku vlevo od cisla $20$; 3.2: $B=28$', 'pts': 3, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'porozumeni', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7D 2023 - uloha 4',
     'zad': ['Male opicky maji pravidelny denni rezim (viz diagram). Po kazdem $4$hodinovem useku (I.-VI.) se u nich stridaji osetrovatele. Bile plochy predstavuji casti dne, ktere travi opicky venku, sede plochy casti dne, po ktere jsou uvnitr sveho pribytku. Dva $4$hodinove useky jsou rozdeleny, nebot jednu petinu z II. useku dne jsou opicky uvnitr pribytku, zatimco jednu sestinu ze VI. useku dne travi opicky venku.',
             '4.1 Urcete, v kolik hodin a minut opicky rano vylezaji z pribytku ven.',
             '4.2 Urcete, v kolik hodin a minut opicky vecer zalezaji do pribytku.',
             '4.3 Urcete, o kolik minut vice stravi kazdy den opicky uvnitr pribytku nez venku.'],
     'opts': None, 'ln': 3, 'svg': SVG4, 'fn': 'diagram-opicky.svg',
     'alt': 'Kruhovy diagram dne rozdeleny na sest 4hodinovych useku I az VI; pulnoc nahore, poledne dole, 8:00 vpravo, 16:00 vlevo.',
     'cap': 'Denni rezim opicek (schematicky nakres)',
     'sol': ['Usek II je $4:00$-$8:00$; jedna petina ($48$ min) na zacatku jsou opicky uvnitr, ven vylezaji v $4:48$.',
             '4.1 $4:48$.',
             'Usek VI je $20:00$-$24:00$; jedna sestina ($40$ min) na zacatku jsou venku, do pribytku zalezaji v $20:40$.',
             '4.2 $20:40$.',
             '4.3 Uvnitr: useky I a IV cele ($480$ min), z II $48$ min a z VI $200$ min, celkem $728$ min. Venku $1440-728=712$ min. Rozdil $728-712=16$ min.'],
     'ans': '4.1: $4:48$; 4.2: $20:40$; 4.3: o $16$ minut', 'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7D 2023 - uloha 5',
     'zad': ['Na miskach vah lezi jedno velke, jedno stredni a tri stejna mala zavazi. Hmotnost stredniho zavazi je o tretinu mensi nez hmotnost velkeho zavazi. Jedno velke a jedno male zavazi vazi dohromady $100$ g, stejne jako jedno stredni a dve mala zavazi.',
             '5.1 Urcete, kolikrat vetsi je hmotnost velkeho zavazi nez hmotnost maleho zavazi.',
             '5.2 Urcete, kolik gramu vazi stredni zavazi.'],
     'opts': None, 'ln': 2, 'svg': SVG5, 'fn': 'vahy-zavazi.svg',
     'alt': 'Rovnoramenne vahy: vlevo velke a male zavazi, vpravo stredni a dve mala zavazi; nad kazdou miskou 100 g.',
     'cap': 'Vychozi obrazek k uloze 5',
     'sol': ['Oznacme velke $V$, stredni $S$, male $m$. Plati $S=\\frac{2}{3}V$, $V+m=100$ a $S+2m=100$. Z poslednich dvou $V+m=S+2m$, tedy $V=S+m=\\frac{2}{3}V+m$, odkud $\\frac{1}{3}V=m$, tj. $V=3m$.',
             '5.1 Velke je $3$krat vetsi nez male.',
             '5.2 Z $S=\\frac{2}{3}V=2m$ a $V+m=100$ je $4m=100$, $m=25$ g, tedy $S=2m=50$ g.'],
     'ans': '5.1: $3$krat; 5.2: $50$ gramu', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['rovnice', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7D 2023 - uloha 6',
     'zad': ['Na parkovisti je presne $105$ parkovacich mist pro osobni auta. Zaparkuje-li na parkovisti autobus, obsadi vzdy $4$ parkovaci mista pro osobni auta. (Parkoviste tedy zcela zaplni napr. $101$ osobnich aut a jeden autobus.)',
             '6.1 Na zcela zaplnenem parkovisti je osobnich aut trikrat vice nez autobusu. Vypoctete, kolik je na parkovisti osobnich aut.',
             '6.2 Na zcela zaplnenem parkovisti je osobnich aut o ctvrtinu vice nez autobusu. Vypoctete, kolik je na parkovisti autobusu.'],
     'opts': None, 'ln': 4,
     'sol': ['6.1 Autobusu $b$, osobnich aut $3b$. Obsazena mista: $3b+4b=7b=105$, tedy $b=15$ a osobnich aut $3b=45$.',
             '6.2 Osobnich aut $\\frac{5}{4}b$: $\\frac{5}{4}b+4b=\\frac{21}{4}b=105$, tedy $b=20$ autobusu (a $25$ osobnich aut, $25+80=105$).'],
     'ans': '6.1: $45$ osobnich aut; 6.2: $20$ autobusu', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['rovnice', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7D 2023 - uloha 7',
     'zad': ['Ve ctvercove siti jsou z tmavych ctvercu slozeny tri utvary $A$, $B$, $C$. Z kazdeho utvaru vytvorime odebranim jedineho tmaveho ctverce novy utvar, ktery je osove soumerny podle nektere osy (svisle, vodorovne nebo sikme). Kazdy tmavy ctverec je oznacen cislem. Z utvaru $A$ lze vytvorit osove soumerny utvar bud odebranim ctverce $2$, nebo odebranim ctverce $8$.',
             '7.1 Urcete cisla ctvercu, jejichz odebranim vytvorime osove soumerny utvar z utvaru $B$ (najdete obe reseni).',
             '7.2 Urcete cisla ctvercu, jejichz odebranim vytvorime osove soumerny utvar z utvaru $C$ (najdete obe reseni).'],
     'opts': None, 'ln': 2, 'svg': SVG7, 'fn': 'utvary-abc.svg',
     'alt': 'Tri utvary A, B, C z tmavych ctvercu ve ctvercove siti, kazdy ctverec oznacen cislem.',
     'cap': 'Utvary A, B, C (vychozi obrazek)',
     'sol': ['7.1 Utvar $B$ je osove soumerny po odebrani ctverce $6$, nebo ctverce $10$.',
             '7.2 Utvar $C$ je osove soumerny po odebrani ctverce $1$, nebo ctverce $9$.'],
     'ans': '7.1: $6$; $10$; 7.2: $1$; $9$', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['planimetrie', 'porozumeni', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7D 2023 - uloha 8 (konstrukce)',
     'zad': ['V rovine lezi body $P$, $Q$, $R$ a primka $a$ (viz obrazek).',
             'Na primce $a$ lezi strana $AB$ ctverce $ABCD$. Dva ze tri bodu $P$, $Q$, $R$ lezi uvnitr dvou ruznych stran tohoto ctverce a treti bod lezi vne ctverce $ABCD$.',
             'Sestrojte vsechny vrcholy ctverce $ABCD$, oznacte je pismeny a ctverec narysujte. Najdete vsechna reseni.'],
     'opts': None, 'ln': 0, 'svg': SVG8, 'fn': 'body-pqr-a.svg',
     'alt': 'Primka a a tri body P, Q, R nad ni.',
     'cap': 'Vychozi obrazek k uloze 8',
     'sol': ['Strana $AB$ lezi na primce $a$, strany ctverce jsou k $a$ kolme, resp. rovnobezne. Dva z bodu $P$, $Q$, $R$ lezi na dvou ruznych stranach ctverce, treti vne. Sestrojenim kolmic k primce $a$ a prenesenim strany ctverce dostaneme vrcholy $A$, $B$, $C$, $D$. Uloha ma dve reseni ($A_1B_1C_1D_1$ a $A_2B_2C_2D_2$).'],
     'ans': 'Konstrukce ctverce $ABCD$ se stranou $AB$ na primce $a$ (dva body na stranach, jeden vne); dve reseni (viz nakres v klici).',
     'pts': 3, 'mins': 8, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7D 2023 - uloha 9 (konstrukce)',
     'zad': ['V rovine lezi primky $b$, $c$ a na primce $b$ lezi bod $A$ (viz obrazek).',
             'Bod $A$ je vrchol trojuhelniku $ABC$ s pravym uhlem pri vrcholu $A$. Na primce $b$ lezi vrchol $B$ a na primce $c$ lezi vrchol $C$ tohoto trojuhelniku. Velikost vnitrniho uhlu trojuhelniku $ABC$ pri vrcholu $C$ je $40^\\circ$.',
             'Sestrojte vrcholy $B$, $C$ trojuhelniku $ABC$, oznacte je pismeny a trojuhelnik narysujte. Najdete vsechna reseni.'],
     'opts': None, 'ln': 0, 'svg': SVG9, 'fn': 'primky-bc-a.svg',
     'alt': 'Dve primky b a c; na primce b lezi bod A.',
     'cap': 'Vychozi obrazek k uloze 9',
     'sol': ['V bode $A$ vztycime kolmici k primce $b$ (rameno $AC$ praveho uhlu). Vrchol $C$ je prusecik teto kolmice s primkou $c$. Vrchol $B$ lezi na primce $b$ tak, aby vnitrni uhel pri $C$ byl $40^\\circ$. Uloha ma dve reseni (vrcholy $B_1$, $B_2$).'],
     'ans': 'Konstrukce pravouhleho trojuhelniku $ABC$ (pravy uhel pri $A$, uhel pri $C$ roven $40^\\circ$); dve reseni $B_1$, $B_2$ (viz nakres v klici).',
     'pts': 3, 'mins': 8, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7D 2023 - uloha 10',
     'zad': ['Kazdy rok pracuji v parku jednak brigadnici, kteri tam pracovali v predchozim roce, jednak nove prijati brigadnici. Na konci kazdeho roku nekteri z nich z parku odchazeji a dalsi rok v nem nepracuji. V grafu jsou znazorneny pocty brigadniku v letech $2018$ az $2022$, tri udaje vsak chybi. Napr. v roce $2022$ pracovalo v parku $9$ brigadniku, kteri tam pracovali i v roce $2021$, a $6$ nove prijatych brigadniku. Z techto $15$ brigadniku jich $8$ na konci roku $2022$ odeslo.',
             'Rozhodnete o kazdem z nasledujicich tvrzeni 10.1-10.3, zda je pravdive (A), ci nikoli (N).',
             '10.1 V roce $2019$ pracovalo v parku $16$ brigadniku, kteri tam pracovali i v roce $2018$.',
             '10.2 V roce $2020$ pracovalo mene nez $7$ nove prijatych brigadniku.',
             '10.3 Na konci roku $2021$ z parku odeslo vice nez $12$ brigadniku.'],
     'opts': None, 'ln': 0, 'svg': SVG10, 'fn': 'graf-brigadnici.svg',
     'alt': 'Sloupcovy graf poctu brigadniku 2018-2022: z predchoziho roku, nove prijati a ti, kteri na konci roku odesli; tri udaje chybi.',
     'cap': 'Pocty brigadniku v letech 2018-2022',
     'sol': ['Pocet pracujicich v roce $Y$ = (loni pracujici) + (nove prijati); z predchoziho roku zustavaji ti, kdo neodesli. 2018: $14+10=24$, odeslo $8$, tedy 2019 pracovalo z predchoziho roku $24-8=16$.',
             '10.1 $16$ z predchoziho roku v 2019 -> Ano.',
             '10.2 V 2020 pracovalo celkem $16+2=18$ (z 2021 zbylo 16, odeslo 2), z toho z predchoziho roku $13$, nove prijatych $18-13=5<7$ -> Ano.',
             '10.3 V 2021 pracovalo $16+5=21$; do 2022 zustalo $9$, odeslo $21-9=12$, coz neni vice nez $12$ -> Ne.'],
     'ans': '10.1: Ano; 10.2: Ano; 10.3: Ne', 'pts': 4, 'mins': 7, 'diff': '3',
     'codes': B + ['statistika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7D 2023 - uloha 11',
     'zad': ['Velky obdelnik lze rozdelit na dva shodne mensi obdelniky nebo na dva ctverce. Obvod jednoho z mensich obdelniku je $30$ cm.',
             'Jaky je obvod velkeho obdelniku?'],
     'opts': ['A) mensi nez $36$ cm', 'B) $36$ cm', 'C) $40$ cm', 'D) $60$ cm', 'E) vetsi nez $60$ cm'],
     'ln': 0, 'svg': SVG11, 'fn': 'obdelnik-deleni.svg',
     'alt': 'Velky obdelnik rozdeleny jednou na dva mensi obdelniky, podruhe na dva ctverce.',
     'cap': 'Vychozi obrazek k uloze 11',
     'sol': ['Rozdeleni na dva ctverce znamena, ze delsi strana je dvojnasobek kratsi: $a=2b$. Mensi obdelnik (s polovicni vyskou) ma rozmery $a\\times\\frac{b}{2}=2b\\times\\frac{b}{2}$ a obvod $2\\left(2b+\\frac{b}{2}\\right)=5b=30$, tedy $b=6$ cm, $a=12$ cm. Obvod velkeho obdelniku $2(a+b)=2\\cdot 18=36$ cm.'],
     'ans': 'B) $36$ cm', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7D 2023 - uloha 12',
     'zad': ['Primka $p$ prochazi vrcholy $A$, $B$ trojuhelniku $ABC$, jehoz vnitrni uhly maji velikosti $\\alpha$, $\\beta$, $\\gamma$. Bodem $B$ prochazi rovnobezka se stranou $AC$. U vrcholu $B$ jsou vyznaceny uhly $2\\beta+\\gamma$ a $30^\\circ$ (viz obrazek).',
             'Jaka je velikost uhlu $\\gamma$? Velikosti uhlu nemerte, ale vypoctete.'],
     'opts': ['A) $115^\\circ$', 'B) $120^\\circ$', 'C) $135^\\circ$', 'D) $140^\\circ$', 'E) $150^\\circ$'],
     'ln': 0, 'svg': SVG12, 'fn': 'trojuhelnik-uhly.svg',
     'alt': 'Trojuhelnik ABC s primkou p vrcholy A, B a rovnobezkou se stranou AC bodem B; vyznacene uhly 2beta+gama, 30 stupnu, alfa, beta, gama.',
     'cap': 'Vychozi obrazek k uloze 12',
     'sol': ['Rovnobezka se stranou $AC$ vedena bodem $B$ vytvari stridave uhly: vyznaceny uhel $30^\\circ$ odpovida uhlu $\\alpha$, tedy $\\alpha=30^\\circ$. Z polohy uhlu u vrcholu $B$ na primce $p$ plyne $3\\beta+\\gamma=180^\\circ$. Se souctem $\\alpha+\\beta+\\gamma=180^\\circ$ dostaneme $\\beta+\\gamma=150^\\circ$; odectenim $\\beta=15^\\circ$ a $\\gamma=135^\\circ$.'],
     'ans': 'C) $135^\\circ$', 'pts': 2, 'mins': 5, 'diff': '4',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7D 2023 - uloha 13',
     'zad': ['Teleso na obrazku je slepeno ze $6$ stejnych valcu. V ucebnici je toto teleso zakresleno pri pohledu zprava, zleva, zezadu a shora.',
             'Ktery z obrazku (A-E) nemuze predstavovat zadny ze ctyr pohledu zakreslenych v ucebnici?'],
     'opts': ['A) obrazek A', 'B) obrazek B', 'C) obrazek C', 'D) obrazek D', 'E) obrazek E'],
     'ln': 0, 'svg': SVG13, 'fn': 'valce.svg',
     'alt': 'Teleso slepene ze sesti stejnych valcu (schematicka poznamka).',
     'cap': 'Prostorove teleso - viz testovy sesit',
     'sol': ['Porovnanim moznych pohledu (zprava, zleva, zezadu, shora) na teleso ze sesti valcu zjistime, ze jim neodpovida obrazek $D$.'],
     'ans': 'D) obrazek D', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['stereometrie', 'porozumeni', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7D 2023 - uloha 14',
     'zad': ['Kvetinarka vazala pouze dva druhy kytic - jednak se $3$ ruzemi, jednak s $5$ ruzemi. Kytic se $3$ ruzemi uvazala o $8$ mene nez kytic s $5$ ruzemi. Na vsechny kytice dohromady pouzila $128$ ruzi.',
             'Kolik kytic kvetinarka celkem uvazala?'],
     'opts': ['A) $30$ kytic', 'B) $32$ kytic', 'C) $34$ kytic', 'D) $36$ kytic', 'E) jiny pocet kytic'],
     'ln': 0,
     'sol': ['Kytic s $5$ ruzemi $x$, se $3$ ruzemi $x-8$. Ruze: $5x+3(x-8)=128$, tj. $8x-24=128$, $8x=152$, $x=19$. Celkem $19+(19-8)=19+11=30$ kytic.'],
     'ans': 'A) $30$ kytic', 'pts': 2, 'mins': 4, 'diff': '2',
     'codes': B + ['rovnice', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7D 2023 - uloha 15',
     'zad': ['Priradte ke kazde uloze (15.1-15.3) odpovidajici vysledek (A-F).',
             '15.1 Letos se na gymnazium prihlasilo $420$ uchazecu, coz je o $40\\,\\%$ vice, nez se jich prihlasilo loni. Kolik uchazecu se na gymnazium prihlasilo loni?',
             '15.2 On-line kurzu ceskeho jazyka se zucastnilo $180$ zaku, coz je o $25\\,\\%$ mene, nez se jich zucastnilo on-line kurzu matematiky. Kolik zaku se zucastnilo on-line kurzu matematiky?',
             '15.3 Vcera navstivilo plavecky bazen celkem $680$ dospelych, mezi nimiz bylo muzu o $30\\,\\%$ mene nez zen. Kolik muzu vcera navstivilo plavecky bazen?'],
     'opts': ['A) mene nez $240$', 'B) $240$', 'C) $260$', 'D) $280$', 'E) $300$', 'F) vice nez $300$'],
     'ln': 0,
     'sol': ['15.1 Loni $=420:1{,}4=300$ -> E.',
             '15.2 Matematika $=180:0{,}75=240$ -> B.',
             '15.3 Zeny $z$, muzi $0{,}7z$; $1{,}7z=680$, $z=400$, muzu $0{,}7\\cdot 400=280$ -> D.'],
     'ans': '15.1: E ($300$); 15.2: B ($240$); 15.3: D ($280$)', 'pts': 6, 'mins': 8, 'diff': '3',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7D 2023 - uloha 16',
     'zad': ['Obrazce tvaru trojuhelniku se sestavuji skladanim sedych trojuhelniku do pater (viz obrazek). Sede trojuhelniky maji ve vrcholech puntiky a na stranach stejne dlouhe usecky. V prvnim obrazci je pouze jeden sedy trojuhelnik a kazdy dalsi obrazec ma o jedno patro vice nez predchozi. Pro $1$, $2$, $3$ patra je sedych trojuhelniku $1$, $3$, $6$, puntiku $3$, $6$, $10$ a usecek $3$, $9$, $18$.',
             '16.1 Urcete pocet usecek v obrazci, ktery ma $5$ pater.',
             '16.2 Pocet usecek v poslednim a v predposlednim obrazci se lisi o $96$. Urcete, o kolik se lisi pocet puntiku v poslednim a predposlednim obrazci.',
             '16.3 V jednom obrazci je $300$ puntiku. Urcete pocet usecek v nasledujicim obrazci.'],
     'opts': None, 'ln': 3, 'svg': SVG16, 'fn': 'trojuhelniky-patra.svg',
     'alt': 'Tri obrazce z sedych trojuhelniku (1, 2 a 3 patra) s puntiky ve vrcholech.',
     'cap': '1., 2. a 3. obrazec',
     'sol': ['Pro $n$ pater: puntiku $\\frac{(n+1)(n+2)}{2}$, usecek $\\frac{3n(n+1)}{2}$.',
             '16.1 $n=5$: usecek $\\frac{3\\cdot 5\\cdot 6}{2}=45$.',
             '16.2 Rozdil usecek mezi sousednimi obrazci je $3n=96$, tedy $n=32$; rozdil puntiku je $n+1=33$.',
             '16.3 $\\frac{(n+1)(n+2)}{2}=300$ dava $n=23$; nasledujici obrazec ma $24$ pater a usecek $\\frac{3\\cdot 24\\cdot 25}{2}=900$.'],
     'ans': '16.1: $45$ usecek; 16.2: o $33$ puntiku; 16.3: $900$ usecek', 'pts': 4, 'mins': 7, 'diff': '3',
     'codes': B + ['posloupnosti', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M7PDD23C0T04'
    gen.YEAR = 2023

    def dollars_ok(s):
        return s.count('$') % 2 == 0
    errors = []
    names = set()
    for p in PROBLEMS:
        if p['name'] in names:
            errors.append('DUP nazev: ' + p['name'])
        names.add(p['name'])
        for t in [p['name'], p['ans']] + list(p['zad']) + list(p['sol']) + (p.get('opts') or []):
            if not dollars_ok(t):
                errors.append('Neparovy $: ' + t[:70])
        if p.get('svg') and ("'" in p['svg'] or '\\' in p['svg']):
            errors.append('SVG zakazany znak: ' + p['name'])
        if p.get('svg') and not p.get('alt'):
            errors.append('Obrazek bez alt: ' + p['name'])
        for lbl, obj in (('content', gen.py_content_json(p)), ('solution', gen.py_solution_json(p)), ('answer', gen.py_answer_json(p))):
            try:
                json.loads(json.dumps(obj, ensure_ascii=False))
            except Exception as e:
                errors.append(f'JSON {lbl} {p["name"]}: {e}')
    if errors:
        print('CHYBY:')
        for e in errors:
            print('  -', e)
        sys.exit(1)
    print('Validace OK:', len(PROBLEMS), 'uloh')
    outdir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'out')
    os.makedirs(outdir, exist_ok=True)
    tot = 0
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M7D-2023')):
        tot += k
        print(f'{os.path.basename(path)}: {sz} B, {k} uloh [{"OK" if sz<9000 else "PRES 9KB"}]')
    print('Celkem uloh:', tot)
