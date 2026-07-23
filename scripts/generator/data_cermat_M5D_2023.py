# -*- coding: utf-8 -*-
# CERMAT - Jednotna prijimaci zkouska 2023, MATEMATIKA 5D (osmilete obory, 5. rocnik).
# Kod testu: M5PDD23C0T04. 14 uloh (po rozdeleni nezavislych poduloh 18 uloh).
# Zdroj odpovedi: klic spravnych reseni (KSR) k testu M5PDD23C0T04.

import math

# ---------- SVG obrazky (bez apostrofu a zpetnych lomitek) ----------

# uloha 2: cislena osa, 13 bodu / 12 dilku; cislo 20, body A, B, C
def _numline():
    y = 100; x0 = 40; dx = 40
    xs = [x0 + dx * i for i in range(13)]
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 150" font-family="sans-serif">']
    s.append(f'<line x1="18" y1="{y}" x2="548" y2="{y}" stroke="#000" stroke-width="2"/>')
    s.append(f'<polygon points="548,{y} 536,{y-6} 536,{y+6}" fill="#000"/>')
    for x in xs:
        s.append(f'<line x1="{x}" y1="{y-8}" x2="{x}" y2="{y+8}" stroke="#000" stroke-width="2"/>')
    s.append(f'<text x="{xs[7]}" y="{y-16}" font-size="15" text-anchor="middle">20</text>')
    for idx, lab in ((5, "A"), (9, "B"), (12, "C")):
        s.append(f'<text x="{xs[idx]}" y="{y+28}" font-size="15" text-anchor="middle" font-style="italic">{lab}</text>')
    s.append('</svg>')
    return "".join(s)
SVG2 = _numline()

# uloha 4: kruhovy denni diagram (6 useku po 4 h), sede = uvnitr
def _clock():
    cx, cy, R = 200, 150, 118
    def pt(a):
        r = math.radians(a)
        return (cx + R * math.sin(r), cy - R * math.cos(r))
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 300" font-family="sans-serif">']
    for a1, a2 in ((0, 60), (120, 180), (300, 360)):
        x1, y1 = pt(a1); x2, y2 = pt(a2)
        s.append(f'<path d="M{cx} {cy} L{x1:.1f} {y1:.1f} A{R} {R} 0 0 1 {x2:.1f} {y2:.1f} Z" fill="#c9c9c9"/>')
    s.append(f'<circle cx="{cx}" cy="{cy}" r="{R}" fill="none" stroke="#000" stroke-width="2"/>')
    for a in range(0, 360, 60):
        x, y = pt(a)
        s.append(f'<line x1="{cx}" y1="{cy}" x2="{x:.1f}" y2="{y:.1f}" stroke="#000" stroke-width="1"/>')
    for a, t in ((30, "I"), (90, "II"), (150, "III"), (210, "IV"), (270, "V"), (330, "VI")):
        r = math.radians(a); lx = cx + 0.62 * R * math.sin(r); ly = cy - 0.62 * R * math.cos(r)
        s.append(f'<text x="{lx:.1f}" y="{ly+4:.1f}" font-size="13" text-anchor="middle">{t}.</text>')
    s.append(f'<text x="{cx}" y="{cy-R-6}" font-size="12" text-anchor="middle">pulnoc</text>')
    s.append(f'<text x="{cx}" y="{cy+R+18}" font-size="12" text-anchor="middle">poledne</text>')
    x8, y8 = pt(120); s.append(f'<text x="{x8+8:.0f}" y="{y8+4:.0f}" font-size="12">8:00</text>')
    x16, y16 = pt(240); s.append(f'<text x="{x16-40:.0f}" y="{y16+4:.0f}" font-size="12">16:00</text>')
    s.append('</svg>')
    return "".join(s)
SVG4 = _clock()

# uloha 6: tri utvary A, B, C ve ctvercove siti (schematicky, jen tmave ctverce s cisly)
def _grids():
    cell = 18; oy = 42
    A = {1: (3, 1), 2: (2, 2), 3: (3, 2), 4: (4, 2), 5: (1, 3), 6: (2, 3), 7: (3, 3), 8: (4, 3), 9: (2, 4)}
    B = {1: (2, 1), 2: (3, 1), 3: (1, 2), 4: (2, 2), 5: (4, 2), 6: (5, 2), 7: (1, 3), 8: (3, 3),
         9: (5, 3), 10: (1, 4), 11: (2, 4), 12: (4, 4), 13: (2, 5), 14: (3, 5)}
    C = {1: (2, 1), 2: (2, 2), 3: (1, 3), 4: (3, 3), 5: (1, 4), 6: (3, 4), 7: (4, 4), 8: (2, 5), 9: (2, 6)}
    figs = [("A", 20, A), ("B", 175, B), ("C", 350, C)]
    rects = []; texts = []; labels = []
    for lab, ox, cells in figs:
        labels.append(f'<text x="{ox+2*cell}" y="{oy-16}" font-weight="bold">{lab}</text>')
        for num, (c, r) in cells.items():
            x = ox + (c - 1) * cell; y = oy + (r - 1) * cell
            rects.append(f'<rect x="{x}" y="{y}" width="{cell}" height="{cell}"/>')
            texts.append(f'<text x="{x+cell//2}" y="{y+cell//2+4}">{num}</text>')
    return ('<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 190" font-family="sans-serif" font-size="14" text-anchor="middle">'
            + '<g fill="#7a7a7a" stroke="#000">' + "".join(rects) + '</g>'
            + '<g font-size="10" fill="#fff">' + "".join(texts) + '</g>'
            + "".join(labels) + '</svg>')
SVG6 = _grids()

# uloha 7.1: body P, Q, R a primka a (vychozi obrazek)
SVG71 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 270" font-family="sans-serif">
<line x1="50" y1="200" x2="410" y2="238" stroke="#000" stroke-width="2"/>
<text x="58" y="192" font-size="15" font-style="italic">a</text>
<text x="207" y="108" font-size="15" font-style="italic">Q</text><text x="205" y="123" font-size="14">x</text>
<text x="168" y="150" font-size="15" font-style="italic">P</text><text x="182" y="150" font-size="14">x</text>
<text x="330" y="168" font-size="14">x</text><text x="342" y="168" font-size="15" font-style="italic">R</text>
</svg>"""

# uloha 7.2: usecka KL a bod U (vychozi obrazek)
SVG72 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 270" font-family="sans-serif">
<line x1="145" y1="225" x2="315" y2="80" stroke="#000" stroke-width="2"/>
<text x="322" y="78" font-size="15" font-style="italic">K</text>
<text x="126" y="236" font-size="15" font-style="italic">L</text>
<text x="238" y="158" font-size="15" font-style="italic">U</text><text x="250" y="160" font-size="14">x</text>
</svg>"""

# uloha 8: sloupcovy graf poctu brigadniku 2018-2022 (tri udaje chybi = carkovane)
def _bars8():
    data = [("2018", 14, False, 10, False, 8, False),
            ("2019", 16, True, 4, False, 7, False),
            ("2020", 13, False, 5, True, 2, False),
            ("2021", 16, False, 5, False, 12, True),
            ("2022", 9, False, 6, False, 8, False)]
    x0 = 70; base = 150; sc = 6; bw = 12; step = 86
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 320" font-family="sans-serif">']
    s.append(f'<line x1="{x0}" y1="24" x2="{x0}" y2="252" stroke="#000" stroke-width="1.5"/>')
    s.append(f'<line x1="{x0}" y1="{base}" x2="512" y2="{base}" stroke="#000" stroke-width="1.5"/>')
    for v in range(4, 21, 4):
        yy = base - v * sc
        s.append(f'<line x1="{x0-4}" y1="{yy}" x2="{x0}" y2="{yy}" stroke="#000"/>')
        s.append(f'<text x="{x0-7}" y="{yy+4}" font-size="10" text-anchor="end">{v}</text>')
    for v in range(4, 17, 4):
        yy = base + v * sc
        s.append(f'<line x1="{x0-4}" y1="{yy}" x2="{x0}" y2="{yy}" stroke="#000"/>')
        s.append(f'<text x="{x0-7}" y="{yy+4}" font-size="10" text-anchor="end">{v}</text>')
    gx = x0 + 20
    for idx, (yr, g, gm, w, wm, b, bm) in enumerate(data):
        bx = gx + idx * step
        hg = g * sc
        if gm:
            s.append(f'<rect x="{bx}" y="{base-hg}" width="{bw}" height="{hg}" fill="none" stroke="#000" stroke-dasharray="3 3"/>')
        else:
            s.append(f'<rect x="{bx}" y="{base-hg}" width="{bw}" height="{hg}" fill="#8a8a8a" stroke="#000"/>')
        hw = w * sc; wx = bx + bw + 3
        if wm:
            s.append(f'<rect x="{wx}" y="{base-hw}" width="{bw}" height="{hw}" fill="none" stroke="#000" stroke-dasharray="3 3"/>')
        else:
            s.append(f'<rect x="{wx}" y="{base-hw}" width="{bw}" height="{hw}" fill="#ececec" stroke="#000"/>')
        hb = b * sc; kx = bx + (bw + 3) // 2
        if bm:
            s.append(f'<rect x="{kx}" y="{base}" width="{bw}" height="{hb}" fill="none" stroke="#000" stroke-dasharray="3 3"/>')
        else:
            s.append(f'<rect x="{kx}" y="{base}" width="{bw}" height="{hb}" fill="#111" stroke="#000"/>')
        s.append(f'<text x="{bx+bw}" y="266" font-size="11" text-anchor="middle">{yr}</text>')
    ly = 292
    s.append(f'<rect x="70" y="{ly}" width="12" height="12" fill="#8a8a8a" stroke="#000"/><text x="86" y="{ly+10}" font-size="10">z predchoziho roku</text>')
    s.append(f'<rect x="230" y="{ly}" width="12" height="12" fill="#ececec" stroke="#000"/><text x="246" y="{ly+10}" font-size="10">nove prijati</text>')
    s.append(f'<rect x="350" y="{ly}" width="12" height="12" fill="#111" stroke="#000"/><text x="366" y="{ly+10}" font-size="10">odesli na konci roku</text>')
    s.append('</svg>')
    return "".join(s)
SVG8 = _bars8()

# uloha 13: teleso ze 6 valcu - schematicka poznamka (nelze verne prenest)
SVG13 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 110" font-family="sans-serif">
<text x="280" y="48" font-size="13" text-anchor="middle">Teleso slepene ze 6 stejnych valcu; prirazuji se pohledy zezadu, zleva a zespodu k obrazcum A-F.</text>
<text x="280" y="74" font-size="11" text-anchor="middle" fill="#666">Prostorove teleso a varianty A-F nelze verne prenest do SVG; posuzuje se podle testoveho sesitu.</text>
</svg>"""

# uloha 14: obrazce z sedych trojuhelniku s puntiky (1., 2., 3. obrazec)
def _triangles():
    side = 26; h = side * 0.866
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 200" font-family="sans-serif">']
    for x0, n in ((90, 1), (230, 2), (410, 3)):
        y0 = 40
        def Ppt(j, i):
            return (x0 + (i - j / 2.0) * side, y0 + j * h)
        for r in range(1, n + 1):
            for k in range(r):
                ax, ay = Ppt(r - 1, k); bx, by = Ppt(r, k); cx, cy = Ppt(r, k + 1)
                s.append(f'<polygon points="{ax:.1f},{ay:.1f} {bx:.1f},{by:.1f} {cx:.1f},{cy:.1f}" fill="#c9c9c9" stroke="#000" stroke-width="1"/>')
        for j in range(n + 1):
            for i in range(j + 1):
                px, py = Ppt(j, i)
                s.append(f'<circle cx="{px:.1f}" cy="{py:.1f}" r="3" fill="#000"/>')
        s.append(f'<text x="{x0:.0f}" y="{y0+n*h+24:.0f}" font-size="12" text-anchor="middle">{n}. obrazec</text>')
    s.append('<text x="530" y="105" font-size="20">...</text></svg>')
    return "".join(s)
SVG14 = _triangles()

B = ['zs1']  # 5. rocnik ZS (prijimacky na osmilete obory); kod r5 v taxonomii neni

PROBLEMS = [
    {'name': 'CERMAT M5D 2023 – úloha 1.1', 'zad': ['Vypočtěte: $(24\\cdot 26-24\\cdot 6):12-2=$'],
     'opts': None, 'ln': 2,
     'sol': ['$24\\cdot 26-24\\cdot 6=24\\cdot(26-6)=480$, dále $480:12-2=40-2=38$.'],
     'ans': '$38$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5D 2023 – úloha 1.2', 'zad': ['Vypočtěte: $(3+7\\cdot 13)\\cdot 5+15\\cdot 30=$'],
     'opts': None, 'ln': 2,
     'sol': ['$3+7\\cdot 13=94$, dále $94\\cdot 5+15\\cdot 30=470+450=920$.'],
     'ans': '$920$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5D 2023 – úloha 2', 'zad': [
        'Na číselné ose je vyznačeno 13 bodů, které oddělují 12 stejných dílků. V jednom z těchto bodů je číslo 20 a body $A$, $B$, $C$ představují tři kladná čísla. Číslo v bodě $C$ je součtem čísla v bodě $A$ a čísla v bodě $B$ (viz obrázek).',
        '2.1 Vyznačte na číselné ose bod $P$, v němž je číslo 0.',
        '2.2 Určete číslo v bodě $B$.'],
     'opts': None, 'ln': 2, 'svg': SVG2, 'fn': 'osa.svg',
     'alt': 'Číselná osa se 13 body (12 dílků); vyznačeno číslo 20 a body A, B, C.',
     'cap': 'Výchozí číselná osa k úloze 2',
     'sol': ['2.1 Bod $A$ je dva dílky vlevo od čísla 20, bod $B$ dva dílky vpravo a bod $C$ pět dílků vpravo (poslední bod). Z podmínky $C=A+B$ dostaneme pro velikost dílku $d$ rovnici $(20-2d)+(20+2d)=20+5d$, tedy $40=20+5d$ a $d=4$. Bod $P$ s číslem 0 leží pět dílků vlevo od čísla 20.',
             '2.2 $B=20+2\\cdot 4=28$.'],
     'ans': '2.1: bod $P$ (číslo 0) leží pět dílků vlevo od čísla 20; 2.2: $28$',
     'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['aritmetika', 'porozumeni', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5D 2023 – úloha 3.1', 'zad': [
        'Závod v hodu kládou měl dvě kola a zúčastnilo se jej 36 závodníků. V 1. kole házel každý závodník pouze jednou. Někteří závodníci postoupili do 2. kola, v němž házel každý z postupujících ještě dvakrát. Během celého závodu tak bylo provedeno celkem 64 hodů kládou.',
        'Vypočtěte, kolik závodníků postoupilo do druhého kola závodu.'],
     'opts': None, 'ln': 2,
     'sol': ['V 1. kole padlo 36 hodů. Na 2. kolo připadá $64-36=28$ hodů, kde každý postupující házel dvakrát; postoupilo tedy $28:2=14$ závodníků.'],
     'ans': '$14$ závodníků', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5D 2023 – úloha 3.2', 'zad': [
        'Cyklista během 5 dní ujel na kole celkem 200 km. První den ujel nejdelší trasu a každý další den ujel o 6 km méně než předchozí den (např. 4. den ujel o 6 km méně než 3. den).',
        'Vypočtěte, kolik km ujel cyklista první den.'],
     'opts': None, 'ln': 2,
     'sol': ['Označme trasu prvního dne $x$. Další dny: $x-6$, $x-12$, $x-18$, $x-24$. Součet $5x-60=200$, odtud $5x=260$ a $x=52$ km.'],
     'ans': '$52$ km', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5D 2023 – úloha 4', 'zad': [
        'Malé opičky mají pravidelný denní režim (viz diagram). Po každém 4hodinovém úseku (I.–VI.) se u nich střídají ošetřovatelé. V diagramu představují bílé plochy části dne, které tráví opičky venku, a šedé plochy části dne, po které jsou uvnitř svého příbytku. Dva 4hodinové úseky jsou v diagramu rozděleny, neboť jednu pětinu z II. úseku dne jsou opičky uvnitř příbytku, zatímco jednu šestinu ze VI. úseku dne tráví opičky venku.',
        '4.1 Určete, v kolik hodin a minut opičky ráno vylézají z příbytku ven.',
        '4.2 Určete, v kolik hodin a minut opičky večer zalézají do příbytku.',
        '4.3 Určete, o kolik minut více stráví každý den opičky uvnitř příbytku než venku.'],
     'opts': None, 'ln': 3, 'svg': SVG4, 'fn': 'diagram-den.svg',
     'alt': 'Kruhový denní diagram rozdělený na šest 4hodinových úseků I až VI; šedé části jsou uvnitř příbytku, bílé venku.',
     'cap': 'Schematický denní diagram (šedé = uvnitř příbytku)',
     'sol': ['4.1 II. úsek je 4:00–8:00. Jedna pětina úseku je $\\frac{4}{5}$ h $=48$ minut, tuto dobu jsou opičky ještě uvnitř; ven vylézají v 4:48.',
             '4.2 VI. úsek je 20:00–24:00. Jedna šestina úseku je $\\frac{4}{6}$ h $=40$ minut, tuto dobu jsou opičky ještě venku; do příbytku zalézají ve 20:40.',
             '4.3 Podle diagramu jsou opičky uvnitř úseky I a III celé a části úseků II ($48$ min) a VI ($200$ min): $240+240+48+200=728$ minut. Venku jsou $1440-728=712$ minut. Rozdíl je $728-712=16$ minut.'],
     'ans': '4.1: v 4:48; 4.2: ve 20:40; 4.3: o $16$ minut',
     'pts': 4, 'mins': 7, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5D 2023 – úloha 5', 'zad': [
        'Na miskách vah leží jedno velké, jedno střední a tři stejná malá závaží. Hmotnost středního závaží je o třetinu menší než hmotnost velkého závaží. Jedno velké a jedno malé závaží váží dohromady 100 g, stejně jako jedno střední a dvě malá závaží.',
        '5.1 Určete, kolikrát větší je hmotnost velkého závaží než hmotnost malého závaží.',
        '5.2 Určete, kolik gramů váží střední závaží.'],
     'opts': None, 'ln': 2, 'svg': None,
     'sol': ['5.1 Označme velké $V$, střední $S$, malé $m$. Platí $S=\\frac{2}{3}V$, dále $V+m=100$ a $S+2m=100$. Porovnáním $V+m=S+2m$ plyne $V-S=m$; protože $S=\\frac{2}{3}V$, je $\\frac{1}{3}V=m$, tedy $V=3m$ — velké závaží je $3$krát těžší než malé.',
             '5.2 Z $V+m=100$ a $V=3m$ plyne $4m=100$, $m=25$ g a $V=75$ g. Střední $S=\\frac{2}{3}\\cdot 75=50$ g.'],
     'ans': '5.1: $3$krát; 5.2: $50$ gramů', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5D 2023 – úloha 6', 'zad': [
        'Ve čtvercové síti jsou z tmavých čtverců složeny tři útvary A, B, C (viz obrázek). Z každého útvaru vytvoříme odebráním jediného tmavého čtverce nový útvar, který je osově souměrný podle některé osy (svislé, vodorovné nebo šikmé). V jednotlivých útvarech je každý tmavý čtverec označen číslem. Z útvaru A lze osově souměrný útvar vytvořit buď odebráním čtverce 2, nebo odebráním čtverce 8.',
        '6.1 Určete číslo čtverce, jehož odebráním vytvoříme osově souměrný útvar z útvaru B.',
        '6.2 Určete číslo čtverce, jehož odebráním vytvoříme osově souměrný útvar z útvaru C.',
        'V každé části úlohy najděte obě řešení.'],
     'opts': None, 'ln': 2, 'svg': SVG6, 'fn': 'utvary-abc.svg',
     'alt': 'Tři útvary A, B, C složené z tmavých čtverců ve čtvercové síti; každý čtverec je označen číslem.',
     'cap': 'Schematický nákres útvarů A, B, C (přesné rozmístění viz testový sešit)',
     'sol': ['6.1 Útvar B je osově souměrný po odebrání čtverce 6, nebo po odebrání čtverce 10.',
             '6.2 Útvar C je osově souměrný po odebrání čtverce 1, nebo po odebrání čtverce 9.'],
     'ans': '6.1: $6$; $10$; 6.2: $1$; $9$', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['planimetrie', 'porozumeni', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5D 2023 – úloha 7.1 (konstrukce)', 'zad': [
        'V rovině leží body $P$, $Q$, $R$ a přímka $a$ (viz obrázek).',
        'Na přímce $a$ leží strana $AB$ čtverce $ABCD$. Dva ze tří bodů $P$, $Q$, $R$ leží uvnitř dvou různých stran tohoto čtverce a třetí bod leží vně čtverce $ABCD$.',
        'Sestrojte všechny vrcholy čtverce $ABCD$, označte je písmeny a čtverec narýsujte. Najděte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG71, 'fn': 'body-pqr-a.svg',
     'alt': 'Body P, Q, R a přímka a v rovině.', 'cap': 'Výchozí obrázek k úloze 7.1',
     'sol': ['Strana $AB$ leží na přímce $a$, strany $BC$ a $AD$ jsou k ní kolmé, strana $CD$ je s ní rovnoběžná. Dva ze zadaných bodů leží na stranách čtverce, třetí vně. Sestrojíme kolmice k přímce $a$ a rovnoběžky s ní procházející danými body; jejich průsečíky určí vrcholy čtverce. Úloha má dvě řešení, čtverce $A_1B_1C_1D_1$ a $A_2B_2C_2D_2$ (viz obrázek v klíči).'],
     'ans': 'Dvě řešení – čtverce $A_1B_1C_1D_1$ a $A_2B_2C_2D_2$ se stranou $AB$ na přímce $a$ (viz obrázek v klíči).',
     'pts': 3, 'mins': 7, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5D 2023 – úloha 7.2 (konstrukce)', 'zad': [
        'V rovině leží úsečka $KL$ a bod $U$ (viz obrázek).',
        'Úsečka $KL$ je strana trojúhelníku $KLM$. Jedna ze dvou zbývajících stran tohoto trojúhelníku má stejnou délku jako strana $KL$ a druhá z nich prochází bodem $U$.',
        'Sestrojte vrchol $M$ trojúhelníku $KLM$, označte ho písmenem a trojúhelník narýsujte. Najděte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG72, 'fn': 'usecka-kl-u.svg',
     'alt': 'Úsečka KL a bod U v rovině.', 'cap': 'Výchozí obrázek k úloze 7.2',
     'sol': ['Vrchol $M$ leží na kružnici se středem v jednom krajním bodě úsečky $KL$ a poloměrem $|KL|$ (rovnost délek stran) a zároveň na přímce procházející druhým krajním bodem a bodem $U$. Pro střed $K$ je $M$ průsečík kružnice $k(K;|KL|)$ s přímkou $LU$, pro střed $L$ průsečík kružnice $k(L;|KL|)$ s přímkou $KU$. Odtud dvě řešení $M_1$ a $M_2$ (viz obrázek v klíči).'],
     'ans': 'Dvě řešení $M_1$, $M_2$: $M$ na kružnici $k(K;|KL|)$, resp. $k(L;|KL|)$, a na přímce $LU$, resp. $KU$ (viz obrázek v klíči).',
     'pts': 3, 'mins': 7, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5D 2023 – úloha 8', 'zad': [
        'Každý rok pracují v parku jednak brigádníci, kteří tam pracovali v předchozím roce, jednak nově přijatí brigádníci. Na konci každého roku někteří z nich odejdou a další rok už nepracují. V grafu jsou znázorněny počty brigádníků v letech 2018 až 2022, tři údaje však chybí. Např. v roce 2022 pracovalo v parku 9 brigádníků, kteří tam pracovali i v roce 2021, a 6 nově přijatých; z těchto 15 brigádníků jich 8 na konci roku 2022 odešlo.',
        'Rozhodněte o každém z následujících tvrzení 8.1–8.3, zda je pravdivé (A), či nikoli (N).',
        '8.1 V roce 2019 pracovalo v parku 16 brigádníků, kteří tam pracovali i v roce 2018.',
        '8.2 V roce 2020 pracovalo v parku méně než 7 nově přijatých brigádníků.',
        '8.3 Na konci roku 2021 z parku odešlo více než 12 brigádníků.'],
     'opts': None, 'ln': 0, 'svg': SVG8, 'fn': 'graf-brigadnici.svg',
     'alt': 'Sloupcový graf počtu brigádníků 2018 až 2022 (z předchozího roku, nově přijatí, odešlí na konci roku); tři sloupce chybí.',
     'cap': 'Počty brigádníků v letech 2018–2022 (tři údaje chybí)',
     'sol': ['8.1 Brigádníci z předchozího roku v roce 2019 $=$ (v 2018 celkem) $-$ (odešlí na konci 2018) $=(14+10)-8=16$. Tvrzení je pravdivé (Ano).',
             '8.2 V roce 2021 bylo z předchozího roku 16 brigádníků a na konci 2020 odešli 2, takže v roce 2020 pracovalo celkem $16+2=18$; z toho z předchozího roku 13, tedy nově přijatých $18-13=5$, což je méně než 7. Pravdivé (Ano).',
             '8.3 V roce 2022 bylo z předchozího roku 9, v roce 2021 pracovalo celkem $16+5=21$, na konci 2021 tedy odešlo $21-9=12$, ne více než 12. Nepravdivé (Ne).'],
     'ans': '8.1: Ano; 8.2: Ano; 8.3: Ne', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['statistika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5D 2023 – úloha 9', 'zad': [
        'Květinářka vázala pouze dva druhy kytic – jednak se 3 růžemi, jednak s 5 růžemi. Kytic se 3 růžemi uvázala o 8 méně než kytic s 5 růžemi. Na všechny kytice dohromady použila 128 růží.',
        'Kolik kytic květinářka celkem uvázala?'],
     'opts': ['A) 36 kytic', 'B) 34 kytic', 'C) 32 kytic', 'D) 30 kytic', 'E) 28 kytic'], 'ln': 0,
     'sol': ['Kytic s 5 růžemi je $x$, se 3 růžemi $x-8$. Růže: $5x+3(x-8)=128$, tj. $8x-24=128$, $x=19$. Celkem $19+(19-8)=30$ kytic.'],
     'ans': 'D) 30 kytic', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5D 2023 – úloha 10', 'zad': [
        'Anežka je o pětinu nižší než já, ale tatínek je o pětinu vyšší než já. Anežka měří o 60 cm méně než tatínek.',
        'Kolik cm měří Anežka?'],
     'opts': ['A) méně než 100 cm', 'B) 100 cm', 'C) 120 cm', 'D) 150 cm', 'E) více než 150 cm'], 'ln': 0,
     'sol': ['Moje výška $j$: Anežka $\\frac{4}{5}j$, tatínek $\\frac{6}{5}j$. Rozdíl $\\frac{6}{5}j-\\frac{4}{5}j=\\frac{2}{5}j=60$, tedy $j=150$ cm. Anežka $\\frac{4}{5}\\cdot 150=120$ cm.'],
     'ans': 'C) 120 cm', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5D 2023 – úloha 11', 'zad': [
        'Na parkovišti je přesně 105 parkovacích míst pro osobní auta. Zaparkuje-li na parkovišti autobus, obsadí vždy 4 parkovací místa pro osobní auta. (Parkoviště tedy zcela zaplní např. 101 osobních aut a jeden autobus.) Nyní je parkoviště zcela zaplněno, přitom osobních aut je na něm třikrát více než autobusů.',
        'O kolik se liší počet osobních aut a počet autobusů na parkovišti?'],
     'opts': ['A) o méně než 30', 'B) o 30', 'C) o 32', 'D) o 36', 'E) o více než 36'], 'ln': 0,
     'sol': ['Autobusů je $b$, osobních aut $3b$. Autobus zabere 4 místa, auto 1 místo: $4b+3b=7b=105$, tedy $b=15$ a aut je 45. Rozdíl $45-15=30$.'],
     'ans': 'B) o 30', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5D 2023 – úloha 12', 'zad': [
        'Velký obdélník lze rozdělit na dva stejné menší obdélníky nebo na dva čtverce (viz obrázek). Obvod jednoho z menších obdélníků je 30 cm.',
        'Jaký je obvod velkého obdélníku?'],
     'opts': ['A) menší než 36 cm', 'B) 36 cm', 'C) 40 cm', 'D) 60 cm', 'E) větší než 60 cm'], 'ln': 0,
     'svg': None,
     'sol': ['Rozdělení na dva čtverce znamená, že delší strana velkého obdélníku je dvojnásobek kratší: $W=2H$. Menší obdélník (polovina velkého) má rozměry $W\\times\\frac{H}{2}=2H\\times\\frac{H}{2}$ a obvod $2\\left(2H+\\frac{H}{2}\\right)=5H=30$, tedy $H=6$ cm a $W=12$ cm. Obvod velkého obdélníku je $2(12+6)=36$ cm.'],
     'ans': 'B) 36 cm', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5D 2023 – úloha 13', 'zad': [
        'Těleso na obrázku je slepeno ze 6 stejných válců. V zadání jsou dány pohledy na těleso shora a zprava.',
        'Ke každé situaci (13.1–13.3) přiřaďte odpovídající obrazec (A–F z testového sešitu).',
        '13.1 Pohled na těleso zezadu.',
        '13.2 Pohled na těleso zleva.',
        '13.3 Pohled na těleso zespodu.'],
     'opts': None, 'ln': 0, 'svg': SVG13, 'fn': 'teleso-valce.svg',
     'alt': 'Těleso slepené ze šesti stejných válců a schematická poznámka k variantám A–F.',
     'cap': 'Prostorové těleso ze 6 válců – varianty A–F viz testový sešit',
     'sol': ['Podle rozmístění 6 válců odpovídá pohled zezadu obrazci A, pohled zleva obrazci C a pohled zespodu obrazci E.'],
     'ans': '13.1: A; 13.2: C; 13.3: E', 'pts': 5, 'mins': 6, 'diff': '3',
     'codes': B + ['stereometrie', 'porozumeni', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5D 2023 – úloha 14', 'zad': [
        'Obrazce tvaru trojúhelníku se sestavují skládáním šedých trojúhelníků do pater (viz obrázek). Šedé trojúhelníky mají ve vrcholech puntíky a na stranách stejně dlouhé úsečky. V prvním obrazci je pouze jeden šedý trojúhelník a každý další obrazec má o jedno patro šedých trojúhelníků více než předchozí obrazec. Pro počet pater 1, 2, 3 platí: šedé trojúhelníky 1, 3, 6; puntíky 3, 6, 10; úsečky 3, 9, 18.',
        '14.1 Určete počet úseček v obrazci, který má 5 pater.',
        '14.2 Počet úseček v posledním a v předposledním obrazci se liší o 96. Určete, o kolik se liší počet puntíků v posledním a v předposledním obrazci.',
        '14.3 V jednom obrazci je 300 puntíků. Určete počet úseček v následujícím obrazci.'],
     'opts': None, 'ln': 3, 'svg': SVG14, 'fn': 'obrazce-trojuhelniky.svg',
     'alt': '1., 2. a 3. obrazec: šedé trojúhelníky skládané do pater s puntíky ve vrcholech.',
     'cap': '1., 2. a 3. obrazec',
     'sol': ['Obrazec s $n$ patry má úseček $U(n)=3\\cdot\\frac{n(n+1)}{2}$ a puntíků $P(n)=\\frac{(n+1)(n+2)}{2}$.',
             '14.1 $U(5)=3\\cdot\\frac{5\\cdot 6}{2}=45$ úseček.',
             '14.2 Rozdíl úseček sousedních obrazců je $U(n)-U(n-1)=3n=96$, tedy $n=32$. Rozdíl puntíků $P(n)-P(n-1)=n+1=33$.',
             '14.3 Z $P(n)=\\frac{(n+1)(n+2)}{2}=300$ plyne $(n+1)(n+2)=600$, tj. $n=23$. V následujícím obrazci ($n=24$) je $U(24)=3\\cdot\\frac{24\\cdot 25}{2}=900$ úseček.'],
     'ans': '14.1: $45$ úseček; 14.2: o $33$ puntíků; 14.3: $900$ úseček',
     'pts': 4, 'mins': 7, 'diff': '3',
     'codes': B + ['posloupnosti', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M5PDD23C0T04'
    gen.YEAR = 2023

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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M5D-2023')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
