# -*- coding: utf-8 -*-
# CERMAT - Jednotna prijimaci zkouska 2021, MATEMATIKA 7 D (sestilete obory, 7. rocnik),
# 2. nahradni termin. Kod testu: M7PDD21C0T04. 16 uloh CERMAT -> 17 uloh po rozdeleni uloh 1.1/1.2.
# Zdroj odpovedi: klic spravnych reseni (KSR); overeno vypoctem, VZA je prazdny zaznamovy arch.

# ---- SVG obrazky (bez apostrofu a zpetnych lomitek) ----

# uloha 7: pravouhly lichobeznik ABCD, pravy uhel u A
SVG7 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 300 232" font-family="sans-serif">
<polygon points="45,190 265,190 175,70 45,70" fill="none" stroke="#000" stroke-width="2"/>
<rect x="45" y="176" width="14" height="14" fill="none" stroke="#000" stroke-width="1"/>
<text x="33" y="66" font-size="15" font-weight="bold">D</text>
<text x="179" y="66" font-size="15" font-weight="bold">C</text>
<text x="31" y="204" font-size="15" font-weight="bold">A</text>
<text x="270" y="204" font-size="15" font-weight="bold">B</text>
<text x="150" y="207" font-size="12" text-anchor="middle">15 cm</text>
</svg>"""

# uloha 8: usecka LM (M nahore, L dole) a bod U vlevo
SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 300" font-family="sans-serif">
<line x1="255" y1="55" x2="300" y2="240" stroke="#000" stroke-width="2"/>
<line x1="248" y1="49" x2="262" y2="61" stroke="#000" stroke-width="2"/>
<line x1="293" y1="234" x2="307" y2="246" stroke="#000" stroke-width="2"/>
<text x="266" y="52" font-size="15" font-style="italic">M</text>
<text x="312" y="246" font-size="15" font-style="italic">L</text>
<text x="196" y="151" font-size="14">×</text>
<text x="192" y="168" font-size="15" font-style="italic">U</text>
</svg>"""

# uloha 9: body A (dole) a S (nad nim)
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 260" font-family="sans-serif">
<text x="205" y="100" font-size="14">×</text>
<text x="201" y="118" font-size="15" font-style="italic">S</text>
<text x="120" y="180" font-size="14">×</text>
<text x="116" y="198" font-size="15" font-style="italic">A</text>
</svg>"""


def _svg10():
    A = [(3, 0), (2, 1), (4, 1), (1, 2), (2, 3), (4, 3), (3, 4)]
    B = [(2, 0), (1, 1), (2, 1), (3, 2), (3, 3), (4, 4), (5, 4), (4, 5)]
    C = [(3, 1), (3, 2), (4, 2), (4, 3)]

    def grid(cells, label, tx):
        cell = 21
        cols = 7
        rows = 6
        ox = 4
        oy = 20
        s = ['<g transform="translate(' + str(tx) + ',0)">']
        for (c, r) in cells:
            s.append('<rect x="' + str(ox + c * cell) + '" y="' + str(oy + r * cell) +
                     '" width="' + str(cell) + '" height="' + str(cell) + '" fill="#b0b0b0"/>')
        for i in range(cols + 1):
            x = ox + i * cell
            s.append('<line x1="' + str(x) + '" y1="' + str(oy) + '" x2="' + str(x) +
                     '" y2="' + str(oy + rows * cell) + '" stroke="#000"/>')
        for j in range(rows + 1):
            y = oy + j * cell
            s.append('<line x1="' + str(ox) + '" y1="' + str(y) + '" x2="' + str(ox + cols * cell) +
                     '" y2="' + str(y) + '" stroke="#000"/>')
        s.append('<text x="' + str(ox + cols * cell / 2) + '" y="14" font-size="14" text-anchor="middle" font-weight="bold">' + label + '</text>')
        s.append('</g>')
        return "".join(s)

    body = grid(A, "A", 0) + grid(B, "B", 185) + grid(C, "C", 370)
    return '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 540 170" font-family="sans-serif">' + body + '</svg>'


SVG10 = _svg10()

# uloha 11: dve rovnobezne sikme primky (dvojite znacky) a dve pricky, uhly 62, fi, 66
SVG11 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 320" font-family="sans-serif">
<line x1="70" y1="42" x2="210" y2="300" stroke="#000" stroke-width="2"/>
<line x1="210" y1="42" x2="350" y2="300" stroke="#000" stroke-width="2"/>
<line x1="30" y1="122" x2="400" y2="72" stroke="#000" stroke-width="2"/>
<line x1="60" y1="252" x2="410" y2="202" stroke="#000" stroke-width="2"/>
<line x1="64" y1="36" x2="74" y2="50" stroke="#000" stroke-width="2"/>
<line x1="71" y1="36" x2="81" y2="50" stroke="#000" stroke-width="2"/>
<line x1="204" y1="36" x2="214" y2="50" stroke="#000" stroke-width="2"/>
<line x1="211" y1="36" x2="221" y2="50" stroke="#000" stroke-width="2"/>
<text x="118" y="122" font-size="15">62°</text>
<text x="248" y="108" font-size="17" font-style="italic">φ</text>
<text x="120" y="248" font-size="15">66°</text>
</svg>"""


def _svg12():
    unit = 17
    base = 230
    w = 44
    dx = 16
    dy = -11
    xs = [92, 136, 180]
    hs = [6, 7, 5]
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 380 260" font-family="sans-serif">']
    for x, h in zip(xs, hs):
        H = h * unit
        top = base - H
        s.append('<polygon points="' + str(x + w) + ',' + str(top) + ' ' + str(x + w + dx) + ',' + str(top + dy) +
                 ' ' + str(x + w + dx) + ',' + str(base + dy) + ' ' + str(x + w) + ',' + str(base) + '" fill="#c4c4c4" stroke="#000"/>')
        s.append('<polygon points="' + str(x) + ',' + str(top) + ' ' + str(x + dx) + ',' + str(top + dy) +
                 ' ' + str(x + w + dx) + ',' + str(top + dy) + ' ' + str(x + w) + ',' + str(top) + '" fill="#dedede" stroke="#000"/>')
        s.append('<rect x="' + str(x) + '" y="' + str(top) + '" width="' + str(w) + '" height="' + str(H) + '" fill="#f2f2f2" stroke="#000"/>')
    s.append('<text x="80" y="' + str(base - 3 * unit) + '" font-size="12" text-anchor="end">6</text>')
    s.append('<text x="' + str(136 + w / 2) + '" y="' + str(base - 7 * unit + dy - 4) + '" font-size="12" text-anchor="middle">7</text>')
    s.append('<text x="' + str(180 + w + dx + 4) + '" y="' + str(base - 2 * unit) + '" font-size="12">5</text>')
    for x in xs:
        s.append('<text x="' + str(x + w / 2) + '" y="' + str(base + 15) + '" font-size="11" text-anchor="middle">3</text>')
    s.append('<text x="248" y="60" font-size="12">Stavba</text>')
    s.append('</svg>')
    return "".join(s)


SVG12 = _svg12()


def _svg13():
    x0 = 70
    y0 = 220
    unit = 3.8
    bw = 40
    gap = 30
    vals = [('1. kolo', 25, False), ('2. kolo', 40, False), ('3. kolo', 20, False), ('4. kolo', None, True)]
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 270" font-family="sans-serif">']
    for v in range(0, 46, 5):
        y = y0 - v * unit
        s.append('<line x1="' + str(x0) + '" y1="' + str(y) + '" x2="380" y2="' + str(y) + '" stroke="#ccc"/>')
    s.append('<line x1="' + str(x0) + '" y1="40" x2="' + str(x0) + '" y2="' + str(y0) + '" stroke="#000" stroke-width="1.5"/>')
    s.append('<line x1="' + str(x0) + '" y1="' + str(y0) + '" x2="392" y2="' + str(y0) + '" stroke="#000" stroke-width="1.5"/>')
    x = x0 + gap
    for name, v, q in vals:
        if q:
            s.append('<rect x="' + str(x) + '" y="' + str(y0 - 45 * unit) + '" width="' + str(bw) +
                     '" height="' + str(45 * unit) + '" fill="none" stroke="#888" stroke-dasharray="4 4"/>')
            s.append('<text x="' + str(x + bw / 2) + '" y="' + str(y0 - 20 * unit) + '" font-size="16" text-anchor="middle" font-weight="bold">?</text>')
        else:
            h = v * unit
            s.append('<rect x="' + str(x) + '" y="' + str(y0 - h) + '" width="' + str(bw) +
                     '" height="' + str(h) + '" fill="#6b6b6b" stroke="#000"/>')
        s.append('<text x="' + str(x + bw / 2) + '" y="' + str(y0 + 16) + '" font-size="11" text-anchor="middle">' + name + '</text>')
        x += bw + gap
    s.append('<text x="22" y="130" font-size="12" transform="rotate(-90 22 130)" text-anchor="middle">Počet bodů</text>')
    s.append('<text x="' + str(x0 - 8) + '" y="' + str(y0 + 4) + '" font-size="12" text-anchor="end">0</text>')
    s.append('</svg>')
    return "".join(s)


SVG13 = _svg13()

# uloha 15.2: obdelnik 5x4 ve ctvercove siti, tmavy mnohouhelnik o obsahu 13 ctverecku
SVG15 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 260 216" font-family="sans-serif">
<polygon points="108,20 240,64 240,196 108,152 64,196 20,152" fill="#bcbcbc"/>
<g stroke="#8a8a8a" stroke-width="1">
<line x1="20" y1="20" x2="240" y2="20"/><line x1="20" y1="64" x2="240" y2="64"/><line x1="20" y1="108" x2="240" y2="108"/><line x1="20" y1="152" x2="240" y2="152"/><line x1="20" y1="196" x2="240" y2="196"/>
<line x1="20" y1="20" x2="20" y2="196"/><line x1="64" y1="20" x2="64" y2="196"/><line x1="108" y1="20" x2="108" y2="196"/><line x1="152" y1="20" x2="152" y2="196"/><line x1="196" y1="20" x2="196" y2="196"/><line x1="240" y1="20" x2="240" y2="196"/>
</g>
<polygon points="108,20 240,64 240,196 108,152 64,196 20,152" fill="none" stroke="#000" stroke-width="2.5"/>
<rect x="20" y="20" width="220" height="176" fill="none" stroke="#000" stroke-width="2"/>
</svg>"""


B = ['zs2', 'r7']  # 7. rocnik (sestilete obory), 2. stupen ZS

PROBLEMS = [
    {'name': 'CERMAT M7D 2021 – úloha 1.1',
     'zad': ['Vypočtěte: $-0{,}5\\cdot 0{,}2 - 0{,}1\\cdot(3-8)=$'],
     'opts': None, 'ln': 2,
     'sol': ['$-0{,}5\\cdot 0{,}2=-0{,}1$; $-0{,}1\\cdot(3-8)=-0{,}1\\cdot(-5)=0{,}5$. Výsledek $-0{,}1+0{,}5=0{,}4$.'],
     'ans': '$0{,}4$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7D 2021 – úloha 1.2',
     'zad': ['Vypočtěte: $\\dfrac{0{,}25}{0{,}025}:0{,}2=$'],
     'opts': None, 'ln': 2,
     'sol': ['$\\frac{0{,}25}{0{,}025}=10$; $10:0{,}2=50$.'],
     'ans': '$50$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7D 2021 – úloha 2',
     'zad': [
         'Řeka Labe protéká pouze dvěma státy a délka celého jejího toku je $1\\,094$ km. V Německu je tok Labe o $352$ km delší než v České republice.',
         '2.1 Vypočtěte délku toku Labe v Německu.',
         'Zahrada měla výměru $1\\,799$ m². Při stavbě nového plotu se posunutím sloupků výměra zahrady zvětšila o $250$ dm².',
         '2.2 Vypočtěte v m² novou výměru zahrady.'],
     'opts': None, 'ln': 2,
     'sol': [
         '2.1 Délka v ČR $=c$, v Německu $=c+352$. Pak $c+(c+352)=1\\,094$, tj. $2c=742$, $c=371$ km. V Německu $371+352=723$ km.',
         '2.2 $250$ dm² $=2{,}5$ m². Nová výměra $1\\,799+2{,}5=1\\,801{,}5$ m².'],
     'ans': '2.1: $723$ km; 2.2: $1\\,801{,}5$ m²', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7D 2021 – úloha 3',
     'zad': [
         'Vypočtěte a výsledek zapište zlomkem v základním tvaru. V obou částech úlohy uveďte postup řešení.',
         '3.1 $\\left(\\frac{5}{8}-\\frac{5}{12}\\right)\\cdot 4 - 2\\cdot\\left(\\frac{3}{4}-\\frac{2}{3}\\right)=$',
         '3.2 $\\dfrac{\\left(\\frac{27}{10}\\cdot\\frac{5}{9}-4\\right):3}{5}=$'],
     'opts': None, 'ln': 3,
     'sol': [
         '3.1 $\\frac{5}{8}-\\frac{5}{12}=\\frac{15-10}{24}=\\frac{5}{24}$, $\\frac{5}{24}\\cdot 4=\\frac{5}{6}$. Dále $\\frac{3}{4}-\\frac{2}{3}=\\frac{1}{12}$, $2\\cdot\\frac{1}{12}=\\frac{1}{6}$. Výsledek $\\frac{5}{6}-\\frac{1}{6}=\\frac{4}{6}=\\frac{2}{3}$.',
         '3.2 $\\frac{27}{10}\\cdot\\frac{5}{9}=\\frac{3}{2}$; $\\frac{3}{2}-4=-\\frac{5}{2}$; $\\left(-\\frac{5}{2}\\right):3=-\\frac{5}{6}$; $\\frac{-5/6}{5}=-\\frac{1}{6}$.'],
     'ans': '3.1: $\\frac{2}{3}$; 3.2: $-\\frac{1}{6}$', 'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7D 2021 – úloha 4',
     'zad': [
         'Na trati závodila $3$ autíčka. První autíčko ujelo závod za $1$ minutu a $42$ sekund. Druhé autíčko ujelo závod za dobu o třetinu kratší než první autíčko. První autíčko ujelo závod za dobu o třetinu kratší než třetí autíčko.',
         'Vypočtěte v minutách a sekundách, za jakou dobu ujelo závod',
         '4.1 druhé autíčko,',
         '4.2 třetí autíčko.'],
     'opts': None, 'ln': 3,
     'sol': [
         'První autíčko: $1$ min $42$ s $=102$ s.',
         '4.1 Druhé je o třetinu kratší: $\\frac{2}{3}\\cdot 102=68$ s $=1$ min $8$ s.',
         '4.2 První je o třetinu kratší než třetí, tj. $102=\\frac{2}{3}\\cdot t_3$, odtud $t_3=153$ s $=2$ min $33$ s.'],
     'ans': '4.1 druhé: $1$ min $8$ s; 4.2 třetí: $2$ min $33$ s', 'pts': 3, 'mins': 4, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7D 2021 – úloha 5',
     'zad': [
         'V dětské hře se smí provádět pouze následující nákupy: za $5$ mincí lze koupit $3$ autíčka; za $3$ mince lze koupit $4$ figurky.',
         '5.1 Amélie si chce koupit několik autíček a dvakrát tolik figurek. Určete nejmenší počet mincí, které k takovému nákupu potřebuje.',
         '5.2 Franta si chce koupit přesně o $10$ autíček více než figurek. Určete nejmenší počet mincí, které k takovému nákupu potřebuje.'],
     'opts': None, 'ln': 3,
     'sol': [
         'Autíčka se kupují po $3$ (za $5$ mincí), figurky po $4$ (za $3$ mince).',
         '5.1 Ať je autíček $3a$ a figurek $4b$; má platit $4b=2\\cdot 3a$, tj. $2b=3a$. Nejmenší řešení $a=2$, $b=3$ — $6$ autíček a $12$ figurek; mince $5\\cdot 2+3\\cdot 3=19$.',
         '5.2 $3a-4b=10$. Nejmenší nezáporné řešení $a=6$, $b=2$ ($18$ autíček, $8$ figurek); mince $5\\cdot 6+3\\cdot 2=36$.'],
     'ans': '5.1: $19$ mincí; 5.2: $36$ mincí', 'pts': 4, 'mins': 6, 'diff': '4',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7D 2021 – úloha 6',
     'zad': [
         'V bílé krabičce jsou jen bílé kuličky, v zelené jen zelené a v modré jen modré. Bílých kuliček je $12$ a modrých $60$. Do bílé krabičky přendáme ze zelené a modré krabičky tolik kuliček, aby byl ve všech třech krabičkách stejný počet kuliček. Ze zelené krabičky musíme přendat o $9$ kuliček více než z modré.',
         '6.1 Určete počet všech zelených kuliček.',
         '6.2 Vypočtěte, kolik kuliček zůstane v modré krabičce.',
         '6.3 Vypočtěte, kolik zelených kuliček přendáme do bílé krabičky.',
         'Ve všech částech úlohy uveďte postup řešení.'],
     'opts': None, 'ln': 4,
     'sol': [
         'Celkem je kuliček $12+G+60=72+G$; po přerovnání je v každé krabičce $\\frac{72+G}{3}$.',
         '6.1 Ze zelené přendáme $G-\\frac{72+G}{3}$, z modré $60-\\frac{72+G}{3}$; jejich rozdíl je $G-60=9$, tedy $G=69$ zelených kuliček.',
         '6.2 V každé krabičce bude $\\frac{72+69}{3}=47$; v modré zůstane $47$ kuliček.',
         '6.3 Ze zelené přendáme $69-47=22$ zelených kuliček (z modré $60-47=13$; rozdíl $9$).'],
     'ans': '6.1: $69$ zelených kuliček; 6.2: $47$ kuliček; 6.3: $22$ zelených kuliček', 'pts': 4, 'mins': 6, 'diff': '4',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7D 2021 – úloha 7',
     'zad': [
         'V pravoúhlém lichoběžníku $ABCD$ s pravým úhlem při vrcholu $A$ má základna $AB$ délku $15$ cm. Platí $|AB|:|CD|=3:2$ a $|AD|:|CD|=6:5$.',
         'Vypočtěte',
         '7.1 v cm délku strany $AD$,',
         '7.2 v cm² obsah lichoběžníku $ABCD$.',
         'V obou částech úlohy uveďte postup řešení.'],
     'opts': None, 'ln': 3, 'svg': SVG7, 'fn': 'lichobeznik.svg',
     'alt': 'Pravoúhlý lichoběžník ABCD s pravým úhlem u vrcholu A, dole základna AB = 15 cm, nahoře kratší základna CD.',
     'cap': 'Pravoúhlý lichoběžník ABCD',
     'sol': [
         'Z $|AB|:|CD|=3:2$ a $|AB|=15$ cm je $|CD|=15\\cdot\\frac{2}{3}=10$ cm.',
         '7.1 Z $|AD|:|CD|=6:5$ je $|AD|=10\\cdot\\frac{6}{5}=12$ cm.',
         '7.2 Výška lichoběžníku je $|AD|=12$ cm (pravý úhel u $A$). Obsah $S=\\frac{|AB|+|CD|}{2}\\cdot|AD|=\\frac{15+10}{2}\\cdot 12=150$ cm².'],
     'ans': '7.1: $|AD|=12$ cm; 7.2: $S=150$ cm²', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7D 2021 – úloha 8',
     'zad': [
         'V rovině leží úsečka $LM$ a bod $U$ (viz obrázek).',
         'Úsečka $LM$ je strana rovnoramenného trojúhelníku $KLM$. V tomto trojúhelníku je každé z obou ramen dvakrát delší než základna. Bod $U$ leží uvnitř trojúhelníku $KLM$.',
         'Sestrojte vrchol $K$ trojúhelníku $KLM$, označte jej písmenem a trojúhelník narýsujte. Najděte všechna $3$ řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG8, 'fn': 'usecka-LM-U.svg',
     'alt': 'Úsečka LM (bod M nahoře, bod L dole) a bod U ležící vlevo od úsečky.',
     'cap': 'Výchozí obrázek k úloze 8',
     'sol': [
         'Úsečka $LM$ může být buď základna (pak $|KL|=|KM|=2|LM|$ a $K$ leží na ose úsečky $LM$), nebo rameno (pak druhé rameno je shodné s $LM$ a základna je poloviční). Z těchto poloh vyhovují tři, u nichž bod $U$ leží uvnitř trojúhelníku — vrcholy $K_1$, $K_2$, $K_3$.'],
     'ans': 'Tři polohy vrcholu $K$ ($K_1$, $K_2$, $K_3$) rovnoramenného trojúhelníku $KLM$ s ramenem dvakrát delším než základna a s bodem $U$ uvnitř — viz obrázek v klíči.',
     'pts': 3, 'mins': 7, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7D 2021 – úloha 9',
     'zad': [
         'V rovině leží body $A$, $S$ (viz obrázek).',
         'Bod $A$ je vrchol obdélníku $ABCD$ a bod $S$ je střed tohoto obdélníku. Vrchol $C$ má od vrcholu $D$ i od středu $S$ stejnou vzdálenost, tedy $|CD|=|CS|$.',
         'Sestrojte vrcholy $B$, $C$, $D$ obdélníku $ABCD$, označte je písmeny a obdélník narýsujte. Najděte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG9, 'fn': 'body-AS.svg',
     'alt': 'Body A (níže vlevo) a S (výše) ležící v rovině.',
     'cap': 'Výchozí obrázek k úloze 9',
     'sol': [
         'Vrchol $C$ je obrazem $A$ ve středové souměrnosti se středem $S$ ($|SC|=|SA|$). V obdélníku je $|SC|=|SD|$; z podmínky $|CD|=|CS|$ je trojúhelník $SCD$ rovnostranný, takže bod $D$ získáme otočením $C$ kolem $S$ o $\\pm 60^\\circ$ — dvě polohy $D_1$, $D_2$. Vrchol $B$ je souměrný s $D$ podle $S$. Existují dvě řešení.'],
     'ans': 'Dvě řešení: $C$ je souměrné s $A$ podle středu $S$; trojúhelník $SCD$ je rovnostranný, proto dvě polohy $D_1$, $D_2$ (a $B_1$, $B_2$) — dva obdélníky, viz obrázek v klíči.',
     'pts': 3, 'mins': 7, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7D 2021 – úloha 10',
     'zad': [
         'Ve čtvercové síti jsou z tmavých čtverců složeny tři útvary $A$, $B$, $C$ (viz obrázek). Ke každému útvaru doplňte jediný tmavý čtverec tak, aby byl útvar osově souměrný a měl co nejvíce různých os souměrnosti.',
         'Rozhodněte o každém z tvrzení 10.1–10.3, zda je pravdivé (A), či nikoli (N).',
         '10.1 Útvar $A$ doplněný o požadovaný čtverec má $4$ osy souměrnosti.',
         '10.2 Útvar $B$ doplněný o požadovaný čtverec má $2$ osy souměrnosti.',
         '10.3 Útvar $C$ doplněný o požadovaný čtverec má pouze $1$ osu souměrnosti.'],
     'opts': None, 'ln': 0, 'svg': SVG10, 'fn': 'symetrie-ABC.svg',
     'alt': 'Tři čtvercové sítě s tmavými útvary označenými A, B a C.',
     'cap': 'Útvary A, B, C ve čtvercové síti',
     'sol': [
         '10.1 Útvar $A$ lze doplnit na obrazec se $4$ osami souměrnosti → Ano.',
         '10.2 Útvar $B$ doplněný o čtverec nemá $2$ osy souměrnosti (má jich méně) → Ne.',
         '10.3 Útvar $C$ doplněný o čtverec nemá pouze $1$ osu souměrnosti (má jich více) → Ne.'],
     'ans': '10.1: Ano; 10.2: Ne; 10.3: Ne', 'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['planimetrie', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7D 2021 – úloha 11',
     'zad': [
         'Na obrázku jsou dvě rovnoběžné přímky (vyznačené shodnými značkami) a dvě příčky. Jsou vyznačeny úhly $62^\\circ$ a $66^\\circ$.',
         'Jaká je velikost úhlu $\\varphi$? Velikosti úhlů neměřte, ale vypočtěte.'],
     'opts': ['A) $128^\\circ$', 'B) $126^\\circ$', 'C) $118^\\circ$', 'D) $114^\\circ$', 'E) jiná velikost'],
     'ln': 0, 'svg': SVG11, 'fn': 'uhly-fi.svg',
     'alt': 'Dvě rovnoběžné šikmé přímky se shodnými značkami a dvě příčky; vyznačené úhly 62°, φ a 66°.',
     'cap': 'Výchozí obrázek k úloze 11',
     'sol': [
         'Přímky se shodnými značkami jsou rovnoběžné, proto pomocí střídavých úhlů vznikne trojúhelník s vnitřními úhly $62^\\circ$, $66^\\circ$ a $180^\\circ-62^\\circ-66^\\circ=52^\\circ$. Úhel $\\varphi$ je vnějším úhlem tohoto trojúhelníku u vrcholu s úhlem $66^\\circ$, tedy $\\varphi=62^\\circ+52^\\circ=114^\\circ$ (rovněž $180^\\circ-66^\\circ$).'],
     'ans': 'D) $114^\\circ$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7D 2021 – úloha 12',
     'zad': [
         'Všechny díly stavebnice jsou pravidelné čtyřboké hranoly s rozměry $1$ cm $\\times$ $1$ cm $\\times$ $2$ cm. Ve stavbě, která má podobu tří spojených kvádrů, jsou díly naskládány bez mezer tak, aby stavba obsahovala co největší počet stojících dílů. Stojící díl má dole čtvercovou stěnu, ležící díl nikoli. Kvádry mají shodnou šířku $3$ cm a hloubku $4$ cm; jejich výšky jsou $6$ cm, $7$ cm a $5$ cm.',
         'Kolik ležících dílů stavba obsahuje?'],
     'opts': ['A) $0$', 'B) $6$', 'C) $12$', 'D) $18$', 'E) $24$'],
     'ln': 0, 'svg': SVG12, 'fn': 'stavba-kvadry.svg',
     'alt': 'Schematický nákres stavby ze tří spojených kvádrů o výškách 6, 7 a 5 cm, šířkách 3 cm a hloubce 4 cm.',
     'cap': 'Stavba ze tří kvádrů',
     'sol': [
         'Sloupce se snažíme zaplnit stojícími díly (výška $2$ cm). Ležící díly jsou nutné jen v nejvyšší vrstvě sloupce liché výšky. Kvádr výšky $6$ cm (sudá) → $0$ ležících dílů. Kvádry výšky $7$ cm a $5$ cm (liché) mají navrchu vrstvu $3\\times 4=12$ cm² vysokou $1$ cm, do níž se vejde $12:2=6$ ležících dílů. Celkem $6+6=12$.'],
     'ans': 'C) $12$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['stereometrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7D 2021 – úloha 13',
     'zad': [
         'Soutěž měla čtyři kola. V grafu jsou výsledky družstva v prvních třech kolech. Ve $2.$ kole družstvo získalo o $20$ bodů více než ve $3.$ kole. Počet bodů získaných v $1.$ kole je aritmetickým průměrem počtů bodů získaných ve zbývajících třech kolech.',
         'Kolik bodů získalo družstvo ve $4.$ kole?'],
     'opts': ['A) $15$ bodů', 'B) $20$ bodů', 'C) $25$ bodů', 'D) $30$ bodů', 'E) jiný počet bodů'],
     'ln': 0, 'svg': SVG13, 'fn': 'graf-kola.svg',
     'alt': 'Sloupcový graf počtu bodů v 1., 2. a 3. kole (25, 40 a 20 bodů); 4. kolo je neznámé.',
     'cap': 'Výsledky družstva v jednotlivých kolech',
     'sol': [
         'Z grafu: $1.$ kolo $25$ bodů, $2.$ kolo $40$ bodů, $3.$ kolo $20$ bodů ($40-20=20$ souhlasí). Protože $1.$ kolo je průměrem ostatních tří: $25=\\frac{40+20+x}{3}$, tj. $75=60+x$, $x=15$. Ve $4.$ kole $15$ bodů.'],
     'ans': 'A) $15$ bodů', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['statistika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7D 2021 – úloha 14',
     'zad': [
         'Ve třídě je o polovinu více chlapců než děvčat.',
         'Které z následujících tvrzení je pravdivé?'],
     'opts': [
         'A) Chlapci tvoří tři pětiny žáků třídy.',
         'B) Děvčata tvoří $33\\,\\%$ žáků třídy.',
         'C) Počet žáků třídy je trojnásobkem počtu děvčat.',
         'D) Počet dívek ve třídě je o polovinu menší než počet chlapců.',
         'E) Žádné z výše uvedených tvrzení není pravdivé.'],
     'ln': 0,
     'sol': [
         'Ať je děvčat $2k$; chlapců je o polovinu více, tj. $3k$. Žáků je celkem $5k$. Chlapci tvoří $\\frac{3k}{5k}=\\frac{3}{5}$, tedy tři pětiny žáků → pravdivé je tvrzení A.'],
     'ans': 'A) Chlapci tvoří tři pětiny žáků třídy.', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7D 2021 – úloha 15',
     'zad': [
         'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).',
         '15.1 V lednu navštívilo výstavu $350$ lidí, v únoru $420$ lidí. O kolik procent byla návštěvnost v únoru vyšší než v lednu?',
         '15.2 Obdélník i tmavý obrazec v něm mají všechny vrcholy v mřížových bodech čtvercové sítě (viz obrázek). O kolik procent je obsah tmavého obrazce menší než obsah obdélníku?',
         '15.3 Věra měla naspořeno $1\\,000$ korun. Nejprve si za $20\\,\\%$ úspor koupila tričko a potom $20\\,\\%$ ze zbývajících peněz utratila za knížku. O kolik procent bylo tričko dražší než knížka?'],
     'opts': ['A) o $0\\,\\%$', 'B) o $20\\,\\%$', 'C) o $25\\,\\%$', 'D) o $30\\,\\%$', 'E) o $35\\,\\%$', 'F) o jiný počet procent'],
     'ln': 0, 'svg': SVG15, 'fn': 'sit-obrazec.svg',
     'alt': 'Obdélník 5 krát 4 ve čtvercové síti s tmavým mnohoúhelníkem o obsahu 13 čtverečků.',
     'cap': 'Obrázek k úloze 15.2',
     'sol': [
         '15.1 Nárůst $420-350=70$ z $350$, tj. $\\frac{70}{350}=0{,}2=20\\,\\%$ → B.',
         '15.2 Obdélník má obsah $20$ čtverečků, tmavý obrazec $13$ čtverečků. Je menší o $\\frac{20-13}{20}=\\frac{7}{20}=35\\,\\%$ → E.',
         '15.3 Tričko $20\\,\\%$ z $1\\,000=200$ Kč; zbývá $800$ Kč, knížka $20\\,\\%$ z $800=160$ Kč. Tričko je dražší o $\\frac{200-160}{160}=\\frac{40}{160}=25\\,\\%$ → C.'],
     'ans': '15.1: B (o $20\\,\\%$); 15.2: E (o $35\\,\\%$); 15.3: C (o $25\\,\\%$)', 'pts': 6, 'mins': 9, 'diff': '4',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7D 2021 – úloha 16',
     'zad': [
         'Do řady po sobě jdoucích kladných celých čísel přidáme za každé číslo dělitelné třemi toto číslo ještě jednou. Nová řada tak všechna čísla dělitelná třemi obsahuje dvakrát. Na $1.$ až $17.$ místě je: $1, 2, 3, 3, 4, 5, 6, 6, 7, 8, 9, 9, 10, 11, 12, 12, 13, \\ldots$',
         'Určete',
         '16.1 na kolikátém místě nové řady je číslo $100$,',
         '16.2 které číslo je na $100.$ místě nové řady,',
         '16.3 na kolika místech nové řady je mezi čísly $1$ až $101$ uvedeno sudé číslo.'],
     'opts': None, 'ln': 3,
     'sol': [
         'Číslo $n$ zabírá v nové řadě $n+\\lfloor n/3\\rfloor$ míst (násobky tří dvakrát).',
         '16.1 Do čísla $100$ je míst $100+\\lfloor 100/3\\rfloor=100+33=133$; číslo $100$ je na $133.$ místě.',
         '16.2 Hledáme $n$ s $n+\\lfloor n/3\\rfloor=100$: pro $n=75$ je $75+25=100$ ($75$ je dělitelné třemi, stojí na $99.$ i $100.$ místě). Na $100.$ místě je číslo $75$.',
         '16.3 Sudých čísel od $1$ do $101$ je $50$; z nich jsou násobky šesti ($6,12,\\ldots,96$), tj. $16$ čísel, uvedeny dvakrát. Sudé číslo je tak na $50+16=66$ místech.'],
     'ans': '16.1: na $133.$ místě; 16.2: $75$; 16.3: na $66$ místech', 'pts': 4, 'mins': 7, 'diff': '4',
     'codes': B + ['posloupnosti', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M7PDD21C0T04'
    gen.YEAR = 2021

    def dollars_ok(s):
        return s.count('$') % 2 == 0
    errors = []
    names = set()
    for p in PROBLEMS:
        if p['name'] in names:
            errors.append('DUP název: ' + p['name'])
        names.add(p['name'])
        for t in [p['name'], p['ans']] + list(p['zad']) + list(p['sol']) + (p.get('opts') or []):
            if not dollars_ok(t):
                errors.append('Nepárový $: ' + t[:70])
        if p.get('svg') and ("'" in p['svg'] or '\\' in p['svg']):
            errors.append('SVG zakázaný znak: ' + p['name'])
        if p.get('svg') and not p.get('alt'):
            errors.append('Obrázek bez alt: ' + p['name'])
        for lbl, obj in (('content', gen.py_content_json(p)), ('solution', gen.py_solution_json(p)), ('answer', gen.py_answer_json(p))):
            try:
                json.loads(json.dumps(obj, ensure_ascii=False))
            except Exception as e:
                errors.append('JSON ' + lbl + ' ' + p['name'] + ': ' + str(e))
    if errors:
        print('CHYBY:')
        [print('  -', e) for e in errors]
        sys.exit(1)
    print('Validace OK:', len(PROBLEMS), 'úloh')
    outdir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'out')
    os.makedirs(outdir, exist_ok=True)
    tot = 0
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M7D-2021')):
        tot += k
        print(os.path.basename(path) + ': ' + str(sz) + ' B, ' + str(k) + ' úloh [' + ('OK' if sz < 9000 else 'PŘES 9KB') + ']')
    print('Celkem úloh:', tot)
