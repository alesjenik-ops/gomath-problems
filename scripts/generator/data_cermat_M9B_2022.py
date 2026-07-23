# -*- coding: utf-8 -*-
# CERMAT – Jednotná přijímací zkouška 2022, MATEMATIKA 9 (čtyřleté obory), varianta B, 2. řádný termín.
# Kód testu: M9PBD22C0T02. 16 úloh (po rozdělení izolovaných početních podúloh 3–5 celkem 20 záznamů).
# Zdroj odpovědí: klíč správných řešení (KSR); struktura ověřena záznamovým archem (VZA).

# ---------- SVG obrázky (bez apostrofů a zpětných lomítek) ----------

# úloha 2: číselná osa s body A, B, C, D (B=10, C=22, D=52), poměr 7:3 pod B
SVG2 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 130" font-family="sans-serif">
<line x1="30" y1="70" x2="530" y2="70" stroke="#000" stroke-width="1.5"/>
<polygon points="530,70 519,65 519,75" fill="#000"/>
<line x1="95" y1="60" x2="95" y2="80" stroke="#000" stroke-width="1.5"/>
<line x1="330" y1="60" x2="330" y2="80" stroke="#000" stroke-width="1.5"/>
<line x1="385" y1="60" x2="385" y2="80" stroke="#000" stroke-width="1.5"/>
<line x1="495" y1="60" x2="495" y2="80" stroke="#000" stroke-width="1.5"/>
<text x="330" y="52" font-size="15" text-anchor="middle">10</text>
<text x="385" y="52" font-size="15" text-anchor="middle">22</text>
<text x="495" y="52" font-size="15" text-anchor="middle">52</text>
<text x="95" y="98" font-size="15" font-style="italic" text-anchor="middle">A</text>
<text x="330" y="98" font-size="15" font-style="italic" text-anchor="middle">B</text>
<text x="385" y="98" font-size="15" font-style="italic" text-anchor="middle">C</text>
<text x="495" y="98" font-size="15" font-style="italic" text-anchor="middle">D</text>
<text x="212" y="118" font-size="14" text-anchor="middle">7   :   3</text>
</svg>"""

# úloha 7: sloupcový graf – dívčí (tmavé) a chlapecké (světlé) týmy škol A–E; dva údaje chybí
def _chart7():
    x0, y0, u = 55, 280, 15
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 330" font-family="sans-serif">']
    s.append(f'<line x1="{x0}" y1="40" x2="{x0}" y2="{y0}" stroke="#000" stroke-width="1.5"/>')
    s.append(f'<line x1="{x0}" y1="{y0}" x2="500" y2="{y0}" stroke="#000" stroke-width="1.5"/>')
    for v in range(0, 17, 2):
        y = y0 - v*u
        s.append(f'<line x1="{x0}" y1="{y}" x2="500" y2="{y}" stroke="#e2e2e2"/>')
        s.append(f'<line x1="{x0-4}" y1="{y}" x2="{x0}" y2="{y}" stroke="#000"/>')
        s.append(f'<text x="{x0-8}" y="{y+4}" font-size="11" text-anchor="end">{v}</text>')
    s.append('<text x="18" y="155" font-size="12" text-anchor="middle" transform="rotate(-90 18 155)">počet bodů</text>')
    schools = [('A', 12, 6), ('B', 6, 14), ('C', None, 2), ('D', 4, None), ('E', 4, 6)]
    bw = 17
    gx = x0 + 25
    for name, dv, ch in schools:
        xd = gx
        if dv is None:
            s.append(f'<rect x="{xd}" y="{y0-30}" width="{bw}" height="30" fill="none" stroke="#888" stroke-dasharray="4 3"/>')
            s.append(f'<text x="{xd+bw/2}" y="{y0-38}" font-size="14" text-anchor="middle">?</text>')
        else:
            h = dv*u
            s.append(f'<rect x="{xd}" y="{y0-h}" width="{bw}" height="{h}" fill="#555" stroke="#000"/>')
        xc = gx + bw + 3
        if ch is None:
            s.append(f'<rect x="{xc}" y="{y0-30}" width="{bw}" height="30" fill="none" stroke="#888" stroke-dasharray="4 3"/>')
            s.append(f'<text x="{xc+bw/2}" y="{y0-38}" font-size="14" text-anchor="middle">?</text>')
        else:
            h = ch*u
            s.append(f'<rect x="{xc}" y="{y0-h}" width="{bw}" height="{h}" fill="#dcdcdc" stroke="#000"/>')
        s.append(f'<text x="{gx+bw+1}" y="{y0+16}" font-size="12" text-anchor="middle">{name}</text>')
        gx += 82
    s.append('<rect x="372" y="55" width="13" height="13" fill="#555" stroke="#000"/><text x="391" y="66" font-size="12">dívčí tým</text>')
    s.append('<rect x="372" y="74" width="13" height="13" fill="#dcdcdc" stroke="#000"/><text x="391" y="85" font-size="12">chlapecký tým</text>')
    s.append('</svg>')
    return "".join(s)
SVG7 = _chart7()

# úloha 8: čtverec ABCD (šedý) s vnořeným čtvercem KLMN (černým) a bílým čtvercem uvnitř
SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 300 280" font-family="sans-serif">
<rect x="55" y="35" width="200" height="200" fill="#cfcfcf" stroke="#000" stroke-width="1.5"/>
<text x="46" y="30" font-size="14" font-style="italic">D</text>
<text x="252" y="30" font-size="14" font-style="italic">C</text>
<text x="46" y="252" font-size="14" font-style="italic">A</text>
<text x="252" y="252" font-size="14" font-style="italic">B</text>
<polygon points="150,55 240,120 175,205 90,140" fill="#111" stroke="#000"/>
<polygon points="150,95 203,133 170,173 120,138" fill="#fff" stroke="#000"/>
<text x="150" y="48" font-size="13" font-style="italic" text-anchor="middle">N</text>
<text x="250" y="122" font-size="13" font-style="italic">M</text>
<text x="175" y="222" font-size="13" font-style="italic" text-anchor="middle">L</text>
<text x="76" y="142" font-size="13" font-style="italic">K</text>
</svg>"""

# úloha 9: výchozí obrázek – bod C a přímka q
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 240" font-family="sans-serif">
<line x1="60" y1="185" x2="360" y2="70" stroke="#000" stroke-width="1.5"/>
<text x="368" y="66" font-size="15" font-style="italic">q</text>
<text x="250" y="170" font-size="14" text-anchor="middle">×</text>
<text x="250" y="188" font-size="14" font-style="italic" text-anchor="middle">C</text>
</svg>"""

# úloha 10: výchozí obrázek – body A, C a přímka p
SVG10 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 300" font-family="sans-serif">
<line x1="120" y1="70" x2="360" y2="200" stroke="#000" stroke-width="1.5"/>
<text x="368" y="212" font-size="15" font-style="italic">p</text>
<text x="315" y="120" font-size="14" text-anchor="middle">×</text>
<text x="315" y="112" font-size="14" font-style="italic" text-anchor="middle">C</text>
<text x="120" y="240" font-size="14" text-anchor="middle">×</text>
<text x="120" y="258" font-size="14" font-style="italic" text-anchor="middle">A</text>
</svg>"""

# úloha 11: síť čtyřbokého hranolu (4 stěny v řadě + čtvercová podstava)
SVG11 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 220 170" font-family="sans-serif">
<text x="110" y="18" font-size="12" text-anchor="middle">Síť hranolu</text>
<rect x="40" y="30" width="30" height="90" fill="none" stroke="#000"/>
<rect x="70" y="30" width="30" height="90" fill="none" stroke="#000"/>
<rect x="100" y="30" width="30" height="90" fill="none" stroke="#000"/>
<rect x="130" y="30" width="30" height="90" fill="none" stroke="#000"/>
<rect x="130" y="120" width="30" height="30" fill="none" stroke="#000"/>
</svg>"""

# úloha 12: rotační válec a čtvercový plakát (plášť) – schematicky
SVG12 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 300 200" font-family="sans-serif">
<ellipse cx="90" cy="45" rx="45" ry="16" fill="#eee" stroke="#000"/>
<line x1="45" y1="45" x2="45" y2="150" stroke="#000"/>
<line x1="135" y1="45" x2="135" y2="150" stroke="#000"/>
<path d="M45,150 A45,16 0 0 0 135,150" fill="#eee" stroke="#000"/>
<text x="90" y="102" font-size="12" text-anchor="middle">válec</text>
<rect x="155" y="45" width="105" height="105" fill="#cfcfcf" stroke="#000"/>
<text x="207" y="100" font-size="12" text-anchor="middle">plakát</text>
</svg>"""

# úloha 13: čtyři přímky (dvě rovnoběžné, s ryskami), úhly 110°, 100° a α – schematicky
SVG13 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 280" font-family="sans-serif">
<line x1="60" y1="250" x2="180" y2="40" stroke="#000" stroke-width="1.5"/>
<line x1="240" y1="250" x2="360" y2="40" stroke="#000" stroke-width="1.5"/>
<line x1="40" y1="150" x2="330" y2="255" stroke="#000" stroke-width="1.5"/>
<line x1="120" y1="255" x2="360" y2="120" stroke="#000" stroke-width="1.5"/>
<line x1="112" y1="118" x2="126" y2="125" stroke="#000"/>
<line x1="117" y1="110" x2="131" y2="117" stroke="#000"/>
<line x1="292" y1="118" x2="306" y2="125" stroke="#000"/>
<line x1="297" y1="110" x2="311" y2="117" stroke="#000"/>
<text x="118" y="188" font-size="15">110°</text>
<text x="278" y="150" font-size="15">100°</text>
<text x="205" y="232" font-size="15" font-style="italic">α</text>
</svg>"""

# úloha 16: čtvercová síť s obdélníkem 8x4, hvězdičky ve vnitřních mřížových bodech
def _grid16():
    ox, oy, c, W, H = 25, 25, 30, 8, 4
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 300 200" font-family="sans-serif">']
    s.append(f'<rect x="{ox}" y="{oy}" width="{W*c}" height="{H*c}" fill="none" stroke="#000" stroke-width="2"/>')
    for i in range(W+1):
        s.append(f'<line x1="{ox+i*c}" y1="{oy}" x2="{ox+i*c}" y2="{oy+H*c}" stroke="#bbb"/>')
    for j in range(H+1):
        s.append(f'<line x1="{ox}" y1="{oy+j*c}" x2="{ox+W*c}" y2="{oy+j*c}" stroke="#bbb"/>')
    for i in range(1, W):
        for j in range(1, H):
            cx, cy = ox + i*c, oy + j*c
            inner = (1 < i < W-1) and (1 < j < H-1)
            ch = '☆' if inner else '★'
            fill = '#fff' if inner else '#333'
            s.append(f'<text x="{cx}" y="{cy+5}" font-size="16" text-anchor="middle" fill="{fill}">{ch}</text>')
    s.append(f'<line x1="{ox+W*c-30}" y1="{oy+H*c+16}" x2="{ox+W*c}" y2="{oy+H*c+16}" stroke="#000"/>')
    s.append(f'<text x="{ox+W*c-15}" y="{oy+H*c+30}" font-size="11" text-anchor="middle">1 cm</text>')
    s.append('</svg>')
    return "".join(s)
SVG16 = _grid16()

# ---------- Úlohy ----------

B = ['zs2', 'r9']

PROBLEMS = [
    # ---- úloha 1 (Vypočtěte – samostatné) ----
    {'name': 'CERMAT M9B 2022 – úloha 1',
     'zad': ['Vypočtěte: $(-6)^2-3\\cdot(-3)=$'],
     'opts': None, 'ln': 2,
     'sol': ['$(-6)^2=36$, $3\\cdot(-3)=-9$; tedy $36-(-9)=36+9=45$.'],
     'ans': '$45$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    # ---- úloha 2 (sdílený kontext – číselná osa) ----
    {'name': 'CERMAT M9B 2022 – úloha 2',
     'zad': [
        'Body $A$, $B$, $C$ a $D$ představují čtyři čísla na číselné ose. Bod $B$ dělí (zleva) úsečku $AC$ v poměru $7:3$. Bod $B$ představuje číslo $10$, bod $C$ číslo $22$ a bod $D$ číslo $52$.',
        '2.1 Určete, v jakém poměru dělí bod $C$ (zleva) úsečku $BD$. Poměr zapište v základním tvaru.',
        '2.2 Určete číslo, které na číselné ose představuje bod $A$.'],
     'opts': None, 'ln': 2, 'svg': SVG2, 'fn': 'ciselna-osa.svg',
     'alt': 'Číselná osa s body A, B, C, D; nad B je 10, nad C je 22, nad D je 52, pod B je poměr 7:3.',
     'cap': 'Body A, B, C, D na číselné ose',
     'sol': [
        '2.1 $|BC|=22-10=12$, $|CD|=52-22=30$; poměr $|BC|:|CD|=12:30=2:5$.',
        '2.2 Úsek $|BC|=12$ odpovídá 3 dílům poměru $7:3$, jeden díl je $4$, tedy $|AB|=7\\cdot4=28$; číslo bodu $A$ je $10-28=-18$.'],
     'ans': '2.1: $2:5$; 2.2: $-18$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    # ---- úloha 3 (izolované početní podúlohy – zlomky) ----
    {'name': 'CERMAT M9B 2022 – úloha 3.1',
     'zad': ['Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\frac{7}{5}\\cdot\\frac{3}{8}\\cdot\\frac{10}{21}+\\frac{3}{10}=$'],
     'opts': None, 'ln': 4,
     'sol': ['Součin: $\\frac{7\\cdot3\\cdot10}{5\\cdot8\\cdot21}=\\frac{210}{840}=\\frac{1}{4}$. Poté $\\frac{1}{4}+\\frac{3}{10}=\\frac{5}{20}+\\frac{6}{20}=\\frac{11}{20}$.'],
     'ans': '$\\frac{11}{20}$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M9B 2022 – úloha 3.2',
     'zad': ['Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\frac{\\frac{1}{4}-\\frac{5}{8}}{3\\cdot\\frac{5}{12}}=$'],
     'opts': None, 'ln': 4,
     'sol': ['Čitatel: $\\frac{1}{4}-\\frac{5}{8}=\\frac{2}{8}-\\frac{5}{8}=-\\frac{3}{8}$. Jmenovatel: $3\\cdot\\frac{5}{12}=\\frac{15}{12}=\\frac{5}{4}$. Podíl: $-\\frac{3}{8}:\\frac{5}{4}=-\\frac{3}{8}\\cdot\\frac{4}{5}=-\\frac{3}{10}$.'],
     'ans': '$-\\frac{3}{10}$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    # ---- úloha 4 (izolované podúlohy – výrazy) ----
    {'name': 'CERMAT M9B 2022 – úloha 4.1',
     'zad': ['Upravte a rozložte na součin vytknutím: $x\\cdot x-x+2x^2=$'],
     'opts': None, 'ln': 2,
     'sol': ['$x\\cdot x-x+2x^2=x^2+2x^2-x=3x^2-x=x\\cdot(3x-1)$.'],
     'ans': '$x\\cdot(3x-1)$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M9B 2022 – úloha 4.2',
     'zad': ['Umocněte a zjednodušte (výsledný výraz nesmí obsahovat závorky): $(5b-0{,}4a)^2=$'],
     'opts': None, 'ln': 2,
     'sol': ['$(5b)^2-2\\cdot5b\\cdot0{,}4a+(0{,}4a)^2=25b^2-4ab+0{,}16a^2$.'],
     'ans': '$25b^2-4ab+0{,}16a^2$', 'pts': 1, 'mins': 3, 'diff': '3',
     'codes': B + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M9B 2022 – úloha 4.3',
     'zad': ['Zjednodušte (výsledný výraz nesmí obsahovat závorky): $(2n-3)\\cdot(4n-2)+(n-3)\\cdot(n+3)=$'],
     'opts': None, 'ln': 3,
     'sol': ['$(2n-3)(4n-2)=8n^2-4n-12n+6=8n^2-16n+6$; $(n-3)(n+3)=n^2-9$. Součet: $8n^2-16n+6+n^2-9=9n^2-16n-3$.'],
     'ans': '$9n^2-16n-3$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    # ---- úloha 5 (izolované podúlohy – rovnice) ----
    {'name': 'CERMAT M9B 2022 – úloha 5.1',
     'zad': ['Řešte rovnici: $5\\cdot(0{,}2x+1)=(8-6x):2$'],
     'opts': None, 'ln': 4,
     'sol': ['$x+5=4-3x$; $x+3x=4-5$; $4x=-1$; $x=-\\frac{1}{4}$.'],
     'ans': '$x=-\\frac{1}{4}$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M9B 2022 – úloha 5.2',
     'zad': ['Řešte rovnici: $\\frac{y-5}{2}+\\frac{3-y}{6}=1-\\frac{2y}{3}$'],
     'opts': None, 'ln': 4,
     'sol': ['Vynásobíme šesti: $3(y-5)+(3-y)=6-4y$; $3y-15+3-y=6-4y$; $2y-12=6-4y$; $6y=18$; $y=3$.'],
     'ans': '$y=3$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    # ---- úloha 6 (sdílený kontext – kuličky) ----
    {'name': 'CERMAT M9B 2022 – úloha 6',
     'zad': [
        'V krabici jsou pouze jednobarevné kuličky, a to zelené, červené a modré. Čtvrtina všech kuliček je zelených, šestina všech kuliček je červených, modrých kuliček je o $20$ více než červených.',
        '6.1 Vypočtěte, kolik kuliček je v krabici.',
        '6.2 Vypočtěte, o kolik se liší počty zelených a červených kuliček v krabici.'],
     'opts': None, 'ln': 3,
     'sol': [
        '6.1 Počet kuliček $x$: zelené $\\frac{x}{4}$, červené $\\frac{x}{6}$, modré $\\frac{x}{6}+20$. Rovnice $\\frac{x}{4}+\\frac{x}{6}+\\frac{x}{6}+20=x$, tj. $\\frac{x}{4}+\\frac{x}{3}+20=x$; po vynásobení 12: $3x+4x+240=12x$, $5x=240$, $x=48$.',
        '6.2 Zelené $\\frac{48}{4}=12$, červené $\\frac{48}{6}=8$; liší se o $12-8=4$ kuličky.'],
     'ans': '6.1: $48$ kuliček; 6.2: o $4$ kuličky', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['rovnice', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    # ---- úloha 7 (sdílený kontext – graf, aritmetický průměr) ----
    {'name': 'CERMAT M9B 2022 – úloha 7',
     'zad': [
        'Soutěže se zúčastnilo 5 škol $A$, $B$, $C$, $D$, $E$. Každou školu reprezentovaly dva týmy – jeden dívčí a jeden chlapecký. Výsledky týmů jsou uvedeny v grafu; dva údaje chybí.',
        '7.1 Výsledek dívčího týmu školy $C$ byl stejný jako aritmetický průměr výsledků dívčích týmů škol $A$ a $B$. Vypočtěte aritmetický průměr výsledků všech pěti dívčích týmů.',
        '7.2 Aritmetický průměr výsledků všech pěti chlapeckých týmů je $8$ bodů. Určete, kolik bodů získal chlapecký tým školy $D$.'],
     'opts': None, 'ln': 3, 'svg': SVG7, 'fn': 'graf-tymy.svg',
     'alt': 'Sloupcový graf výsledků dívčích (tmavé) a chlapeckých (světlé) týmů škol A až E; dívčí tým školy C a chlapecký tým školy D chybí.',
     'cap': 'Výsledky týmů jednotlivých škol (počet bodů)',
     'sol': [
        '7.1 Dívčí: $A=12$, $B=6$, $C=\\frac{12+6}{2}=9$, $D=4$, $E=4$; průměr $\\frac{12+6+9+4+4}{5}=\\frac{35}{5}=7$ bodů.',
        '7.2 Chlapecký: $A=6$, $B=14$, $C=2$, $E=6$; součet všech pěti je $5\\cdot8=40$, tedy $D=40-(6+14+2+6)=12$ bodů.'],
     'ans': '7.1: $7$ bodů; 7.2: $12$ bodů', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['statistika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    # ---- úloha 8 (sdílený kontext – vnořené čtverce) ----
    {'name': 'CERMAT M9B 2022 – úloha 8',
     'zad': [
        'Bílý čtverec má obsah $9$ cm², černá plocha uvnitř čtverce $KLMN$ má obsah $16$ cm² a šedá plocha uvnitř čtverce $ABCD$ má obsah $56$ cm². Bílý čtverec leží uvnitř čtverce $KLMN$ a ten uvnitř čtverce $ABCD$.',
        '8.1 Vypočtěte v cm délku strany $KL$.',
        '8.2 Vypočtěte v cm obvod čtverce $ABCD$.'],
     'opts': None, 'ln': 3, 'svg': SVG8, 'fn': 'vnorene-ctverce.svg',
     'alt': 'Šedý čtverec ABCD, uvnitř něj natočený černý čtverec KLMN a uvnitř něj bílý čtverec.',
     'cap': 'Vnořené čtverce ABCD, KLMN a bílý čtverec',
     'sol': [
        '8.1 Čtverec $KLMN$ má obsah $16+9=25$ cm², tedy $|KL|=\\sqrt{25}=5$ cm.',
        '8.2 Čtverec $ABCD$ má obsah $56+25=81$ cm², jeho strana je $\\sqrt{81}=9$ cm, obvod $4\\cdot9=36$ cm.'],
     'ans': '8.1: $5$ cm; 8.2: $36$ cm', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    # ---- úloha 9 (konstrukce – rovnoramenný trojúhelník) ----
    {'name': 'CERMAT M9B 2022 – úloha 9',
     'zad': [
        'V rovině leží bod $C$ a přímka $q$ (viz obrázek).',
        'Bod $C$ je vrchol rovnoramenného trojúhelníku $ABC$ se základnou $AB$. Základna $AB$ leží na přímce $q$ a má délku $6$ cm.',
        'Sestrojte vrcholy $A$, $B$ trojúhelníku $ABC$, označte je písmeny a trojúhelník narýsujte.'],
     'opts': None, 'ln': 0, 'svg': SVG9, 'fn': 'bod-primka-q.svg',
     'alt': 'Přímka q stoupající zleva doprava a bod C ležící pod přímkou.',
     'cap': 'Výchozí obrázek k úloze 9',
     'sol': [
        'Patou kolmice vedené z bodu $C$ k přímce $q$ je střed $M$ základny $AB$. Na přímce $q$ naneseme na obě strany od $M$ vzdálenost $3$ cm a získáme vrcholy $A$ a $B$ (aby $|AB|=6$ cm). Spojením s bodem $C$ vznikne rovnoramenný trojúhelník $ABC$.'],
     'ans': 'Konstrukce: $M$ je pata kolmice z $C$ na $q$ (střed $AB$); $A$ a $B$ leží na $q$ ve vzdálenosti $3$ cm od $M$ na obě strany, $|AB|=6$ cm (viz obrázek v klíči).',
     'pts': 2, 'mins': 5, 'diff': '2',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    # ---- úloha 10 (konstrukce – rovnoběžník) ----
    {'name': 'CERMAT M9B 2022 – úloha 10',
     'zad': [
        'V rovině leží body $A$, $C$ a přímka $p$ (viz obrázek).',
        'Body $A$, $C$ jsou vrcholy rovnoběžníku $ABCD$, jehož dvě strany jsou rovnoběžné s přímkou $p$. Jedna z úhlopříček rovnoběžníku $ABCD$ je k přímce $p$ kolmá.',
        '10.1 Sestrojte střed $S$ rovnoběžníku $ABCD$ a označte ho písmenem.',
        '10.2 Sestrojte vrcholy $B$, $D$ rovnoběžníku $ABCD$, označte je písmeny a rovnoběžník narýsujte.'],
     'opts': None, 'ln': 0, 'svg': SVG10, 'fn': 'body-primka-p.svg',
     'alt': 'Přímka p klesající zleva doprava, bod C vpravo nahoře a bod A vlevo dole.',
     'cap': 'Výchozí obrázek k úloze 10',
     'sol': [
        '10.1 Střed $S$ je střed úhlopříčky $AC$ (průsečík úhlopříček rovnoběžníku).',
        '10.2 Bodem $S$ vedeme kolmici k přímce $p$; na ní leží úhlopříčka $BD$. Vrchol $B$ je průsečík této kolmice s rovnoběžkou s $p$ vedenou bodem $A$, vrchol $D$ je s ním souměrný podle $S$ (průsečík kolmice s rovnoběžkou s $p$ vedenou bodem $C$). Rovnoběžník $ABCD$ narýsujeme.'],
     'ans': 'Konstrukce: $S$ střed úsečky $AC$; úhlopříčka $BD$ leží na kolmici k $p$ vedené bodem $S$; $B$ a $D$ jsou průsečíky této kolmice s rovnoběžkami s $p$ vedenými body $A$ a $C$ (viz obrázek v klíči).',
     'pts': 3, 'mins': 7, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    # ---- úloha 11 (sdílený kontext – hranol, Ano/Ne) ----
    {'name': 'CERMAT M9B 2022 – úloha 11',
     'zad': [
        'Ze tří stejných dřevěných krychlí byl slepen čtyřboký hranol, jehož síť má obsah $126$ cm² (viz obrázek).',
        'Rozhodněte o každém z následujících tvrzení 11.1–11.3, zda je pravdivé (Ano), či nikoli (Ne).',
        '11.1 Povrch hranolu je 14krát větší než obsah stěny jedné krychle.',
        '11.2 Síť krychle má obsah $42$ cm².',
        '11.3 Nejkratší hrana hranolu měří $3$ cm.'],
     'opts': None, 'ln': 0, 'svg': SVG11, 'fn': 'sit-hranolu.svg',
     'alt': 'Síť čtyřbokého hranolu: čtyři stejné obdélníkové stěny v řadě a jedna čtvercová podstava.',
     'cap': 'Síť čtyřbokého hranolu',
     'sol': [
        'Hranol má rozměry $a\\times a\\times 3a$, kde $a$ je hrana krychle. Povrch (síť) $=2a^2+4\\cdot 3a^2=14a^2=126$, tedy $a^2=9$ a $a=3$ cm.',
        '11.1 Povrch hranolu $=14a^2$, obsah stěny krychle $=a^2$; podíl je $14$ → pravdivé (Ano).',
        '11.2 Síť (povrch) krychle $=6a^2=6\\cdot9=54$ cm², ne $42$ cm² → nepravdivé (Ne).',
        '11.3 Nejkratší hrana hranolu je $a=3$ cm → pravdivé (Ano).'],
     'ans': '11.1: Ano; 11.2: Ne; 11.3: Ano', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['stereometrie', 'argumentace', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    # ---- úloha 12 (výběr z možností – válec) ----
    {'name': 'CERMAT M9B 2022 – úloha 12',
     'zad': [
        'Reklamní plochu pro vylepování plakátů tvoří plášť rotačního válce. Podstava válce má poloměr $50$ cm. Plakát, který přesně pokryje celou reklamní plochu, má tvar čtverce (viz obrázek).',
        'Jaká je výška válce? Výsledek je zaokrouhlen na celé cm.'],
     'opts': ['A) $157$ cm', 'B) $236$ cm', 'C) $314$ cm', 'D) $390$ cm', 'E) větší než $390$ cm'],
     'ln': 0, 'svg': SVG12, 'fn': 'valec-plakat.svg',
     'alt': 'Rotační válec, vedle něj čtvercový plakát tvořící plášť válce.',
     'cap': 'Válcová reklamní plocha a čtvercový plakát',
     'sol': [
        'Rozvinutý plášť je obdélník o šířce rovné obvodu podstavy $o=2\\pi r=2\\pi\\cdot50=100\\pi\\doteq314$ cm a o výšce rovné výšce válce. Aby byl plakát čtvercový, musí být výška válce rovna obvodu podstavy, tedy $\\doteq314$ cm.'],
     'ans': 'C) $314$ cm', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['stereometrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    # ---- úloha 13 (výběr z možností – úhly u rovnoběžek) ----
    {'name': 'CERMAT M9B 2022 – úloha 13',
     'zad': [
        'V rovině leží čtyři přímky, z nichž dvě jsou rovnoběžné (viz obrázek). Vyznačeny jsou úhly $110^\\circ$ a $100^\\circ$ a hledaný úhel $\\alpha$.',
        'Jaká je velikost úhlu $\\alpha$? Velikosti úhlů neměřte, ale vypočtěte.'],
     'opts': ['A) menší než $120^\\circ$', 'B) $120^\\circ$', 'C) $130^\\circ$', 'D) $150^\\circ$', 'E) větší než $150^\\circ$'],
     'ln': 0, 'svg': SVG13, 'fn': 'ctyri-primky-uhly.svg',
     'alt': 'Čtyři přímky, dvě z nich rovnoběžné (s ryskami); vyznačeny úhly 110°, 100° a úhel α.',
     'cap': 'Schematický nákres k úloze 13',
     'sol': [
        'Přímky protínající rovnoběžky svírají s nimi u příslušných vrcholů vnitřní úhly trojúhelníku $180^\\circ-110^\\circ=70^\\circ$ a $180^\\circ-100^\\circ=80^\\circ$. Třetí vnitřní úhel trojúhelníku je $180^\\circ-70^\\circ-80^\\circ=30^\\circ$; úhel $\\alpha$ je jeho vedlejší úhel, tedy $\\alpha=180^\\circ-30^\\circ=150^\\circ$.'],
     'ans': 'D) $150^\\circ$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    # ---- úloha 14 (výběr z možností – výraz) ----
    {'name': 'CERMAT M9B 2022 – úloha 14',
     'zad': [
        'V knihovně je $k$ polic. V každé polici je o $8$ knih více, než je v knihovně polic. ($k$ může nabývat různých kladných celých hodnot.)',
        'Který výraz vyjadřuje celkový počet knih v knihovně?'],
     'opts': ['A) $k^2+8k$', 'B) $k^2+16k+64$', 'C) $k^2+64$', 'D) $2k+8$', 'E) $8k$'],
     'ln': 0,
     'sol': [
        'Počet polic je $k$, v každé polici je $k+8$ knih. Celkem $k\\cdot(k+8)=k^2+8k$ knih.'],
     'ans': 'A) $k^2+8k$', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['vyrazy', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    # ---- úloha 15 (přiřazování – procenta) ----
    {'name': 'CERMAT M9B 2022 – úloha 15',
     'zad': [
        'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).',
        '15.1 Včera stála sekačka $20\\,000$ korun a dnes je její cena pouze $8\\,000$ korun. O kolik procent byla snížena cena sekačky?',
        '15.2 První skupina poseče čtvrtinu louky a druhá skupina $60\\,\\%$ zbývající části louky. Poslední část louky zůstane neposečená. Kolik procent louky zůstane neposečeno?',
        '15.3 Nedávno byly zdraženy hřebíky. Částka, za kterou jsme dříve koupili $120$ hřebíků, nyní vystačí jen na $80$ hřebíků. O kolik procent byly hřebíky zdraženy?'],
     'opts': ['A) méně než $30\\,\\%$', 'B) $30\\,\\%$', 'C) $40\\,\\%$', 'D) $50\\,\\%$', 'E) $60\\,\\%$', 'F) jiný počet procent'],
     'ln': 0,
     'sol': [
        '15.1 Snížení $\\frac{20\\,000-8\\,000}{20\\,000}=\\frac{12\\,000}{20\\,000}=0{,}6=60\\,\\%$ → E.',
        '15.2 Poseká se $\\frac{1}{4}=25\\,\\%$ a $60\\,\\%$ ze zbývajících $\\frac{3}{4}$, tj. $0{,}6\\cdot75\\,\\%=45\\,\\%$; neposečeno zůstane $75\\,\\%-45\\,\\%=30\\,\\%$ → B.',
        '15.3 Za stejnou částku nyní koupíme $80$ místo $120$ hřebíků; cena jednoho vzrostla v poměru $\\frac{120}{80}=1{,}5$, tj. o $50\\,\\%$ → D.'],
     'ans': '15.1: E (o $60\\,\\%$); 15.2: B ($30\\,\\%$); 15.3: D (o $50\\,\\%$)', 'pts': 6, 'mins': 8, 'diff': '3',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    # ---- úloha 16 (sdílený kontext – čtvercová síť, hvězdičky) ----
    {'name': 'CERMAT M9B 2022 – úloha 16',
     'zad': [
        'Ve čtvercové síti (krok $1$ cm) vytváříme různé obdélníky s vrcholy v mřížových bodech. Na obrázku je jeden z možných obdélníků, a to s rozměry $8$ cm a $4$ cm. Uvnitř obdélníku zakreslíme v každém mřížovém bodě hvězdičku. Hvězdičky nejblíže hranici obdélníku budou tmavé a ostatní bílé.',
        '16.1 Určete počet všech hvězdiček v obdélníku s rozměry $81$ cm a $20$ cm.',
        '16.2 Obdélník, jehož jeden rozměr je $50$ cm, obsahuje celkem $9\\,800$ hvězdiček. Určete v cm druhý rozměr tohoto obdélníku.',
        '16.3 Vypočtěte, o kolik se liší počty bílých a tmavých hvězdiček v obdélníku s rozměry $41$ cm a $23$ cm.'],
     'opts': None, 'ln': 3, 'svg': SVG16, 'fn': 'sit-hvezdicky.svg',
     'alt': 'Obdélník 8 krát 4 ve čtvercové síti, ve vnitřních mřížových bodech hvězdičky; hvězdičky u hranice tmavé, vnitřní bílé.',
     'cap': 'Obdélník 8 cm krát 4 cm s hvězdičkami ve vnitřních mřížových bodech',
     'sol': [
        'Hvězdičky leží ve vnitřních mřížových bodech: v obdélníku o rozměrech $m$ cm a $n$ cm jich je $(m-1)(n-1)$; tmavé jsou body na okraji této vnitřní mřížky, bílých je $(m-3)(n-3)$.',
        '16.1 $(81-1)(20-1)=80\\cdot19=1520$ hvězdiček.',
        '16.2 $(50-1)(x-1)=9\\,800$, tj. $49(x-1)=9\\,800$, $x-1=200$, $x=201$ cm.',
        '16.3 Celkem $(41-1)(23-1)=40\\cdot22=880$. Bílé $(41-3)(23-3)=38\\cdot20=760$, tmavé $880-760=120$; liší se o $760-120=640$ hvězdiček.'],
     'ans': '16.1: $1520$ hvězdiček; 16.2: $201$ cm; 16.3: o $640$ hvězdiček', 'pts': 4, 'mins': 8, 'diff': '4',
     'codes': B + ['posloupnosti', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M9PBD22C0T02'
    gen.YEAR = 2022

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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M9B-2022')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
