# -*- coding: utf-8 -*-
# CERMAT - Jednotna prijimaci zkouska 2026, MATEMATIKA 9B, 2. radny termin (ostry test).
# Ctyrlete obory, 9. rocnik. Kod testu: M9PBD26C0T02. 16 uloh, 50 bodu.
# Po rozdeleni izolovanych poduloh (2, 3, 4) je uloh 22.
# Zdroj odpovedi: klic spravnych reseni (KSR) + spravne vyplneny zaznamovy arch (VZA).

import math

# ---- SVG obrazky (bez ' a \) ----

# uloha 7: kruh rozdeleny na tri bile vysece (90 st.) a tri sede vysece (30 st.)
def _sectors7():
    cx, cy, r = 150, 150, 120
    def pt(a):
        return (round(cx + r*math.cos(math.radians(a)), 1), round(cy - r*math.sin(math.radians(a)), 1))
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 300" font-family="sans-serif">']
    s.append(f'<circle cx="{cx}" cy="{cy}" r="{r}" fill="#ffffff" stroke="#000" stroke-width="2"/>')
    for a1, a2 in [(90, 120), (210, 240), (330, 360)]:
        pts = [f'{cx},{cy}']
        n = 8
        for i in range(n+1):
            a = a1 + (a2-a1)*i/n
            x, y = pt(a); pts.append(f'{x},{y}')
        s.append(f'<polygon points="{" ".join(pts)}" fill="#b9b9b9"/>')
    for a in [0, 90, 120, 210, 240, 330]:
        x, y = pt(a); s.append(f'<line x1="{cx}" y1="{cy}" x2="{x}" y2="{y}" stroke="#000" stroke-width="1.5"/>')
    bx, by, br = 380, 150, 70
    p = [f'{bx},{by}']
    for i in range(9):
        a = 45 + 90*i/8
        x = round(bx + br*math.cos(math.radians(a)), 1); y = round(by - br*math.sin(math.radians(a)), 1)
        p.append(f'{x},{y}')
    s.append(f'<polygon points="{" ".join(p)}" fill="#ffffff" stroke="#000" stroke-width="1.5"/>')
    s.append(f'<path d="M{bx+12},{by} L{bx+12},{by-12} L{bx},{by-12}" fill="none" stroke="#000"/>')
    s.append(f'<text x="{bx}" y="{by+44}" font-size="12" text-anchor="middle">Jedna bila cast</text>')
    s.append('</svg>')
    return "".join(s)
SVG7 = _sectors7()

# uloha 9: vychozi obrazek - body A, O, P
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 260" font-family="sans-serif">
<rect x="6" y="6" width="408" height="248" fill="none" stroke="#ccc"/>
<text x="334" y="84" font-size="15" font-style="italic">P</text><text x="326" y="76" font-size="14">×</text>
<text x="162" y="122" font-size="15" font-style="italic">A</text><text x="154" y="134" font-size="14">×</text>
<text x="150" y="206" font-size="15" font-style="italic">O</text><text x="142" y="198" font-size="14">×</text>
</svg>"""

# uloha 10: vychozi obrazek - body A, B, D
SVG10 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 260" font-family="sans-serif">
<rect x="6" y="6" width="408" height="248" fill="none" stroke="#ccc"/>
<text x="176" y="120" font-size="15" font-style="italic">A</text><text x="168" y="132" font-size="14">×</text>
<text x="344" y="120" font-size="15" font-style="italic">B</text><text x="336" y="132" font-size="14">×</text>
<text x="112" y="216" font-size="15" font-style="italic">D</text><text x="120" y="208" font-size="14">×</text>
</svg>"""

# uloha 11: skladany sloupcovy graf - parkoviste (4 udaje chybi -> carkovane s ?)
def _parking():
    x0 = 56; y0 = 210; sc = 8; bw = 18
    days = [('Po', None, 14, 3), ('Ut', 16, 4, 7), ('St', None, None, 6),
            ('Ct', 16, 5, None), ('Pa', 9, 12, 3)]
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 540 400" font-family="sans-serif">']
    s.append(f'<line x1="{x0}" y1="30" x2="{x0}" y2="352" stroke="#000"/><line x1="{x0}" y1="{y0}" x2="520" y2="{y0}" stroke="#000"/>')
    for v in list(range(0, 21, 4)) + list(range(-4, -17, -4)):
        y = y0 - v*sc
        s.append(f'<line x1="{x0-4}" y1="{y}" x2="{x0}" y2="{y}" stroke="#000"/><text x="{x0-7}" y="{y+4}" font-size="10" text-anchor="end">{abs(v)}</text>')
    s.append(f'<text x="16" y="{y0}" font-size="11" text-anchor="middle" transform="rotate(-90 16 {y0})">Pocet aut</text>')
    dx = x0 + 28; slot = 92
    for name, sv, nv, ov in days:
        def bar(x, val, up, col):
            if val is None:
                h = 152 if up else 120
                y = y0 - h if up else y0
                ty = y0 - h - 4 if up else y0 + h + 12
                s.append(f'<rect x="{x}" y="{y}" width="{bw}" height="{h}" fill="none" stroke="#888" stroke-dasharray="4 3"/><text x="{x+9}" y="{ty}" font-size="12" text-anchor="middle">?</text>')
            else:
                h = val*sc
                y = y0 - h if up else y0
                s.append(f'<rect x="{x}" y="{y}" width="{bw}" height="{h}" fill="{col}" stroke="#000"/>')
        bar(dx, sv, True, '#7a7a7a')
        bar(dx+bw+4, nv, True, '#d8d8d8')
        bar(dx+11, ov, False, '#111')
        s.append(f'<text x="{dx+bw}" y="370" font-size="11" text-anchor="middle">{name}</text>')
        dx += slot
    ly = 388
    s.append(f'<rect x="60" y="{ly}" width="11" height="11" fill="#7a7a7a"/><text x="75" y="{ly+9}" font-size="9">zustala</text>')
    s.append(f'<rect x="150" y="{ly}" width="11" height="11" fill="#d8d8d8" stroke="#000"/><text x="165" y="{ly+9}" font-size="9">nove</text>')
    s.append(f'<rect x="220" y="{ly}" width="11" height="11" fill="#111"/><text x="235" y="{ly+9}" font-size="9">odjela</text>')
    s.append('</svg>')
    return "".join(s)
SVG11 = _parking()

# uloha 12: trojuhelnikovy diagram (magicky trojuhelnik), soucin na strane stejny
def _triangle12():
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 320" font-family="sans-serif">']
    TL = (120, 70); TR = (360, 70); B = (240, 275)
    def mid(p, q): return ((p[0]+q[0])/2, (p[1]+q[1])/2)
    mt = mid(TL, TR); ml = mid(TL, B); mr = mid(TR, B)
    for a, b in [(TL, TR), (TL, B), (TR, B)]:
        s.append(f'<line x1="{a[0]}" y1="{a[1]}" x2="{b[0]}" y2="{b[1]}" stroke="#000" stroke-width="1.5"/>')
    nodes = [(TL, ''), (TR, '8'), (B, ''), (mt, '6'), (ml, '4'), (mr, '5')]
    for (px, py), txt in nodes:
        s.append(f'<circle cx="{px}" cy="{py}" r="22" fill="#ffffff" stroke="#000" stroke-width="1.5"/>')
        if txt:
            s.append(f'<text x="{px}" y="{py+6}" font-size="18" text-anchor="middle">{txt}</text>')
    s.append('</svg>')
    return "".join(s)
SVG12 = _triangle12()

# uloha 13: krychle a nove teleso se ctyrmi rohovymi vyrezy (schematicky - prostorove teleso)
SVG13 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 210" font-family="sans-serif">
<text x="115" y="22" font-size="13" text-anchor="middle">Krychle</text>
<text x="382" y="22" font-size="13" text-anchor="middle">Nove teleso</text>
<polygon points="55,70 145,70 145,160 55,160" fill="#e8e8e8" stroke="#000" stroke-width="1.5"/>
<polygon points="55,70 90,45 180,45 145,70" fill="#f4f4f4" stroke="#000" stroke-width="1.5"/>
<polygon points="145,70 180,45 180,135 145,160" fill="#d5d5d5" stroke="#000" stroke-width="1.5"/>
<polygon points="320,70 410,70 410,160 320,160" fill="#e8e8e8" stroke="#000" stroke-width="1.5"/>
<polygon points="320,70 355,45 445,45 410,70" fill="#f4f4f4" stroke="#000" stroke-width="1.5"/>
<polygon points="410,70 445,45 445,135 410,160" fill="#d5d5d5" stroke="#000" stroke-width="1.5"/>
<rect x="320" y="70" width="16" height="16" fill="#ffffff" stroke="#000"/>
<rect x="394" y="70" width="16" height="16" fill="#ffffff" stroke="#000"/>
<rect x="320" y="144" width="16" height="16" fill="#ffffff" stroke="#000"/>
<rect x="394" y="144" width="16" height="16" fill="#ffffff" stroke="#000"/>
<text x="260" y="200" font-size="10" text-anchor="middle" fill="#666">Schematicky nakres prostoroveho telesa (viz testovy sesit).</text>
</svg>"""

# uloha 16: 1.-4. obrazec - stridave vkladane ctverce (bile/sede), vrcholy ve stredech stran
def _pattern16():
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 170" font-family="sans-serif">']
    W = '#ffffff'; G = '#b9b9b9'; h = 52
    centers = [(80, 95, 1), (230, 95, 2), (380, 95, 3), (530, 95, 4)]
    labels = ['1. obrazec', '2. obrazec', '3. obrazec', '4. obrazec']
    def sq_axis(cx, cy, hh): return [(cx-hh, cy-hh), (cx+hh, cy-hh), (cx+hh, cy+hh), (cx-hh, cy+hh)]
    def sq_diam(cx, cy, hh): return [(cx, cy-hh), (cx+hh, cy), (cx, cy+hh), (cx-hh, cy)]
    for (cx, cy, n), lab in zip(centers, labels):
        s.append(f'<text x="{cx}" y="30" font-size="12" text-anchor="middle">{lab}</text>')
        for lvl in range(1, n+1):
            hh = h / (2 ** ((lvl-1)//2))
            if lvl % 2 == 1:
                pts = sq_axis(cx, cy, hh); col = W
            else:
                pts = sq_diam(cx, cy, hh); col = G
            ptstr = ' '.join(f'{round(x,1)},{round(y,1)}' for x, y in pts)
            s.append(f'<polygon points="{ptstr}" fill="{col}" stroke="#000" stroke-width="1.2"/>')
    s.append('<text x="612" y="102" font-size="24">…</text>')
    s.append('</svg>')
    return "".join(s)
SVG16 = _pattern16()

B = ['zs2', 'r9']  # 9. rocnik ZS, ctyrlete obory (prijimacky)

PROBLEMS = [
    {'name': 'CERMAT M9B 2026 – úloha 1',
     'zad': ['Vypočtěte, o kolik cm² je plocha o obsahu $0{,}1$ m² větší než plocha o obsahu $20$ cm².'],
     'opts': None, 'ln': 2,
     'sol': ['Platí $0{,}1$ m² $=0{,}1\\cdot 10\\,000$ cm² $=1000$ cm². Rozdíl je $1000-20=980$ cm².'],
     'ans': 'o $980$ cm²', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2026 – úloha 2.1',
     'zad': ['Vypočtěte a výsledek zapište zlomkem v základním tvaru nebo celým číslem: $3\\cdot\\left(\\frac{2}{3}-\\frac{7}{9}\\right)+\\frac{2}{3}=$'],
     'opts': None, 'ln': 2,
     'sol': ['$\\frac{2}{3}-\\frac{7}{9}=\\frac{6}{9}-\\frac{7}{9}=-\\frac{1}{9}$; $3\\cdot\\left(-\\frac{1}{9}\\right)=-\\frac{1}{3}$; $-\\frac{1}{3}+\\frac{2}{3}=\\frac{1}{3}$.'],
     'ans': '$\\frac{1}{3}$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2026 – úloha 2.2',
     'zad': ['Vypočtěte a výsledek zapište zlomkem v základním tvaru nebo celým číslem: $1:\\frac{6}{5}-\\frac{1}{6}:5=$'],
     'opts': None, 'ln': 2,
     'sol': ['$1:\\frac{6}{5}=\\frac{5}{6}$; $\\frac{1}{6}:5=\\frac{1}{30}$; $\\frac{5}{6}-\\frac{1}{30}=\\frac{25}{30}-\\frac{1}{30}=\\frac{24}{30}=\\frac{4}{5}$.'],
     'ans': '$\\frac{4}{5}$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2026 – úloha 2.3',
     'zad': ['Vypočtěte a výsledek zapište zlomkem v základním tvaru nebo celým číslem (uveďte celý postup řešení): $\\frac{1-\\frac{1}{4}}{2\\cdot\\frac{5}{8}-2}=$'],
     'opts': None, 'ln': 3,
     'sol': ['Čitatel: $1-\\frac{1}{4}=\\frac{3}{4}$. Jmenovatel: $2\\cdot\\frac{5}{8}-2=\\frac{5}{4}-2=-\\frac{3}{4}$. Podíl: $\\frac{3}{4}:\\left(-\\frac{3}{4}\\right)=-1$.'],
     'ans': '$-1$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2026 – úloha 3.1',
     'zad': ['Upravte na co nejjednodušší tvar bez závorek: $5x-3x\\cdot 3-3\\cdot(-2x)=$'],
     'opts': None, 'ln': 2,
     'sol': ['$5x-9x+6x=2x$.'],
     'ans': '$2x$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2026 – úloha 3.2',
     'zad': ['Upravte a rozložte na součin vytknutím: $(a-2b)\\cdot b-b+2b^2=$'],
     'opts': None, 'ln': 2,
     'sol': ['$(a-2b)\\cdot b-b+2b^2=ab-2b^2-b+2b^2=ab-b=b\\cdot(a-1)$.'],
     'ans': '$b\\cdot(a-1)$', 'pts': 1, 'mins': 3, 'diff': '3',
     'codes': B + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2026 – úloha 3.3',
     'zad': ['Upravte na co nejjednodušší tvar bez závorek (uveďte celý postup řešení): $(3y+y)\\cdot(y-1)+(1-2y)\\cdot(2y+1)=$'],
     'opts': None, 'ln': 3,
     'sol': ['$(3y+y)\\cdot(y-1)=4y\\cdot(y-1)=4y^2-4y$; $(1-2y)\\cdot(2y+1)=1-4y^2$. Součet: $4y^2-4y+1-4y^2=1-4y$.'],
     'ans': '$1-4y$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2026 – úloha 4.1',
     'zad': ['Řešte rovnici (uveďte celý postup řešení): $\\frac{1}{2}\\cdot(3x+4)+5=\\frac{1}{2}\\cdot(2-x)$'],
     'opts': None, 'ln': 4,
     'sol': ['Vynásobíme dvěma: $(3x+4)+10=2-x$, tj. $3x+14=2-x$. Odtud $4x=-12$, tedy $x=-3$.'],
     'ans': '$x=-3$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2026 – úloha 4.2',
     'zad': ['Řešte rovnici (uveďte celý postup řešení): $\\frac{6+y}{5}=7-\\frac{8+5y}{20}$'],
     'opts': None, 'ln': 4,
     'sol': ['Vynásobíme dvaceti: $4\\cdot(6+y)=140-(8+5y)$, tj. $24+4y=132-5y$. Odtud $9y=108$, tedy $y=12$.'],
     'ans': '$y=12$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2026 – úloha 5',
     'zad': ['František dal do svého salátu obsahujícího $850$ g rajčat celkem $255$ g cukru. Podle receptu však do salátu patří na každých $250$ g rajčat pouze $25$ g cukru.',
             '5.1 Vypočtěte, kolik gramů cukru měl dát František podle receptu do svého salátu.',
             '5.2 Vypočtěte, o kolik procent více cukru dal František do svého salátu, než měl dát podle receptu.'],
     'opts': None, 'ln': 4,
     'sol': ['5.1 Na $850$ g rajčat připadá $\\frac{850}{250}\\cdot 25=3{,}4\\cdot 25=85$ g cukru.',
             '5.2 František dal $255$ g místo $85$ g, tj. $\\frac{255}{85}=3$násobek množství podle receptu. To je o $200\\,\\%$ více.'],
     'ans': '5.1: $85$ g; 5.2: o $200\\,\\%$ více', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9B 2026 – úloha 6',
     'zad': ['Na vánočním jarmarku prodávali ve stánku pouze čaj a punč. Čaj prodávali za $40$ korun a cena punče byla o $75\\,\\%$ vyšší než cena čaje.',
             '6.1 Vypočtěte v korunách cenu jednoho punče.',
             '6.2 Počet čajů, které dnes ve stánku prodali, označíme $x$. Vyjádřete výrazem s proměnnou $x$, kolik korun dnes ve stánku utržili za všechny prodané čaje.',
             '6.3 Ve stánku dnes prodali celkem $510$ nápojů a utržili za ně dohromady $29\\,700$ korun. Vypočtěte, kolik čajů prodali dnes ve stánku.'],
     'opts': None, 'ln': 4,
     'sol': ['6.1 Punč: $40\\cdot 1{,}75=70$ korun.',
             '6.2 Za všechny prodané čaje utržili $40x$ korun.',
             '6.3 Punčů bylo $510-x$. Rovnice $40x+70\\cdot(510-x)=29\\,700$ dává $40x+35\\,700-70x=29\\,700$, tj. $-30x=-6000$, tedy $x=200$. Prodali $200$ čajů.'],
     'ans': '6.1: $70$ korun; 6.2: $40x$; 6.3: $200$ čajů', 'pts': 4, 'mins': 7, 'diff': '3',
     'codes': B + ['rovnice', 'modelovani', 'slovni', 'bez-kalkulacky', 'finance']},

    {'name': 'CERMAT M9B 2026 – úloha 7',
     'zad': ['Kruh o poloměru $10$ cm je rozdělen na tři shodné bílé části a tři shodné šedé části jako na obrázku.',
             '7.1 Určete, kolikrát je obsah jedné bílé části kruhu větší než obsah jedné šedé části.',
             '7.2 Vypočtěte v cm obvod jedné bílé části kruhu. Výsledek zaokrouhlete na desetiny centimetru.'],
     'opts': None, 'ln': 3, 'svg': SVG7, 'fn': 'kruh-vysece.svg',
     'alt': 'Kruh rozdělený na tři shodné bílé kruhové výseče a tři shodné šedé výseče; jedna bílá výseč má pravý úhel u středu.',
     'cap': 'Schematický nákres (bílá výseč 90°, šedá výseč 30°)',
     'sol': ['7.1 Jedna bílá část je kruhová výseč se středovým úhlem $90^\\circ$, jedna šedá výseč má úhel $30^\\circ$ (tři výseče po $90^\\circ$ a tři po $30^\\circ$ dají dohromady $360^\\circ$). Poměr obsahů je $90:30=3$, bílá část je tedy $3$krát větší.',
             '7.2 Obvod bílé části tvoří dva poloměry a čtvrtkruhový oblouk: $2\\cdot 10+\\frac{1}{4}\\cdot 2\\pi\\cdot 10=20+5\\pi\\doteq 20+15{,}7=35{,}7$ cm.'],
     'ans': '7.1: $3$krát; 7.2: $35{,}7$ cm', 'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2026 – úloha 8',
     'zad': ['Délky dvou stran trojúhelníku $ABC$ jsou $a=7$ cm, $b=30$ cm. Obvod trojúhelníku $ABC$ v cm je vyjádřen celým číslem.',
             '8.1 Určete, kolik cm musí měřit strana $c$ trojúhelníku $ABC$, aby byl jeho obvod nejmenší možný.',
             '8.2 Určete, kolik cm musí měřit strana $c$ trojúhelníku $ABC$, aby byl jeho obvod největší možný.'],
     'opts': None, 'ln': 2,
     'sol': ['Podle trojúhelníkové nerovnosti platí $b-a<c<b+a$, tj. $23<c<37$. Strana $c$ je celé číslo.',
             '8.1 Nejmenší možná strana je $c=24$ cm (obvod $61$ cm).',
             '8.2 Největší možná strana je $c=36$ cm (obvod $73$ cm).'],
     'ans': '8.1: $24$ cm; 8.2: $36$ cm', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['planimetrie', 'porozumeni', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2026 – úloha 9 (konstrukce)',
     'zad': ['V rovině leží body $A$, $O$, $P$ (viz obrázek).',
             'Bod $A$ je vrchol pravidelného šestiúhelníku $ABCDEF$. Přímka $OP$ je osa strany $AB$ tohoto šestiúhelníku. Na polopřímce $OP$ leží střed souměrnosti $S$ šestiúhelníku $ABCDEF$.',
             'Sestrojte vrcholy $B$, $C$, $D$, $E$, $F$ šestiúhelníku $ABCDEF$, označte je písmeny a šestiúhelník narýsujte.'],
     'opts': None, 'ln': 0, 'svg': SVG9, 'fn': 'body-AOP.svg',
     'alt': 'Body A, O, P v rovině; O a P leží níže, bod A nad nimi.',
     'cap': 'Výchozí obrázek k úloze 9',
     'sol': ['Bod $B$ je obrazem bodu $A$ v osové souměrnosti podle přímky $OP$ (osa strany $AB$). Střed $S$ leží na přímce $OP$ ve vzdálenosti $|AB|$ od bodu $A$ (u pravidelného šestiúhelníku je poloměr kružnice opsané roven délce strany), sestrojíme ho jako průsečík kružnice se středem $A$ a poloměrem $|AB|$ s přímkou $OP$. Sestrojíme kružnici opsanou se středem $S$ a poloměrem $|SA|$; na ni od bodu $A$ postupně naneseme tětivy délky $|AB|$ a získáme vrcholy $C$, $D$, $E$, $F$. Šestiúhelník $ABCDEF$ narýsujeme.'],
     'ans': 'Konstrukce pravidelného šestiúhelníku $ABCDEF$ ($B$ obraz $A$ v osové souměrnosti podle $OP$; střed $S$ na $OP$ s $|SA|=|AB|$; vrcholy na kružnici opsané) – viz náčrt v klíči.',
     'pts': 2, 'mins': 7, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2026 – úloha 10 (konstrukce)',
     'zad': ['V rovině leží body $A$, $B$, $D$ (viz obrázek).',
             'Body $A$ a $B$ jsou vrcholy pravoúhlého trojúhelníku $ABC$ s pravým úhlem při vrcholu $C$. Body $B$ a $D$ jsou vrcholy pravoúhlého trojúhelníku $BCD$ s pravým úhlem při vrcholu $C$. Vrcholy $B$ a $C$ jsou společnými vrcholy obou trojúhelníků.',
             'Sestrojte vrchol $C$, označte ho písmenem a narýsujte trojúhelníky $ABC$ a $BCD$.'],
     'opts': None, 'ln': 0, 'svg': SVG10, 'fn': 'body-ABD.svg',
     'alt': 'Body A, B, D v rovině.',
     'cap': 'Výchozí obrázek k úloze 10',
     'sol': ['Bod $C$ vidí úsečku $AB$ pod pravým úhlem, leží tedy na Thaletově kružnici nad průměrem $AB$. Zároveň vidí úsečku $BD$ pod pravým úhlem, leží tedy na Thaletově kružnici nad průměrem $BD$. Vrchol $C$ je průsečík obou Thaletových kružnic různý od bodu $B$; ve správné konstrukci leží bod $C$ na polopřímce $DA$. Narýsujeme trojúhelníky $ABC$ a $BCD$.'],
     'ans': 'Konstrukce: $C$ je průsečík Thaletovy kružnice nad $AB$ a Thaletovy kružnice nad $BD$ (leží na polopřímce $DA$, úhel $DCB$ je pravý) – viz náčrt v klíči.',
     'pts': 3, 'mins': 7, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2026 – úloha 11',
     'zad': ['Na parkovišti mohou auta stát jeden den nebo zůstat zaparkovaná nepřetržitě více dnů. Na noc se parkoviště pro vjezd a výjezd uzavírá. V grafu jsou znázorněny počty aut na parkovišti v průběhu pěti dnů, čtyři údaje však chybí. Např. v pátek bylo na parkovišti již před otevřením $9$ aut, která tam zůstala z předchozích dnů, během dne přibylo $12$ nově zaparkovaných aut a z těchto $21$ aut $3$ auta odjela.',
             'Rozhodněte o každém z tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).',
             '11.1 V pondělí bylo na parkovišti již před otevřením právě $10$ aut.',
             '11.2 Ve středu na parkovišti nově zaparkovalo $9$ aut.',
             '11.3 Ve čtvrtek ukončilo parkování méně než $12$ aut.'],
     'opts': None, 'ln': 0, 'svg': SVG11, 'fn': 'graf-parkoviste.svg',
     'alt': 'Skládaný sloupcový graf počtu aut na parkovišti pondělí až pátek; tři sloupce na den (zůstala z předchozích dnů, nově zaparkovaná, odjela), čtyři hodnoty chybí.',
     'cap': 'Počty aut na parkovišti během pěti dnů (čtyři údaje chybí)',
     'sol': ['Ráno přítomná auta $=$ ráno předchozího dne $+$ nově zaparkovaná $-$ odjelá.',
             '11.1 Ráno v úterý bylo $16$ aut; v pondělí přibylo $14$ a odjela $3$, proto ráno v pondělí bylo $16-14+3=5$ aut. Tvrzení (10 aut) je nepravdivé → N.',
             '11.2 Návazností dnů (ráno St $=$ ráno Út $+$ nově Út $-$ odjelá Út) vyjde, že ve středu nově zaparkovalo $9$ aut → A.',
             '11.3 Ve čtvrtek platí $16+5-o=9$ (ráno v pátek), odtud $o=12$; odjelo $12$ aut, což není méně než $12$ → N.'],
     'ans': '11.1: N; 11.2: A; 11.3: N', 'pts': 4, 'mins': 7, 'diff': '3',
     'codes': B + ['statistika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9B 2026 – úloha 12',
     'zad': ['V trojúhelníkovém diagramu se do prázdných kroužků doplní taková kladná celá čísla, aby byl součin tří čísel na každé straně trojúhelníku stejný (viz obrázek).',
             'Jaký je součet obou čísel doplněných do prázdných kroužků diagramu?'],
     'opts': ['A) $11$', 'B) $14$', 'C) $19$', 'D) $22$', 'E) jiný součet'], 'ln': 0,
     'svg': SVG12, 'fn': 'diagram-trojuhelnik.svg',
     'alt': 'Trojúhelníkový diagram se šesti kroužky; na stranách jsou čísla 6, 8, 4, 5 a dva kroužky (horní levý a dolní) jsou prázdné.',
     'cap': 'Trojúhelníkový diagram (součin tří čísel na každé straně je stejný)',
     'sol': ['Označme horní levý kroužek $t$ a dolní kroužek $d$. Strany dávají součiny $t\\cdot 6\\cdot 8$, $8\\cdot 5\\cdot d$ a $t\\cdot 4\\cdot d$. Z rovnosti $48t=4td$ plyne $d=12$, z rovnosti $48t=40d$ pak $t=10$. Součet doplněných čísel je $10+12=22$.'],
     'ans': 'D) $22$', 'pts': 2, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2026 – úloha 13',
     'zad': ['Z krychle o hraně délky $10$ cm byly vyříznuty čtyři shodné malé krychličky o hraně délky $2$ cm. Vzniklo tak nové těleso (viz obrázek).',
             'Jaký je povrch nového tělesa?'],
     'opts': ['A) $552$ cm²', 'B) $584$ cm²', 'C) $600$ cm²', 'D) $616$ cm²', 'E) jiný povrch'], 'ln': 0,
     'svg': SVG13, 'fn': 'krychle-vyrezy.svg',
     'alt': 'Krychle o hraně 10 cm a nové těleso se čtyřmi vyříznutými rohovými krychličkami o hraně 2 cm (schematicky).',
     'cap': 'Schematický nákres (prostorové těleso, viz testový sešit)',
     'sol': ['Původní krychle má povrch $6\\cdot 10^2=600$ cm². Vyříznutím malé krychličky z rohu se z povrchu odeberou tři čtverce $2\\times 2$ (celkem $12$ cm²), ale současně se odkryjí tři nové stejně velké čtverce ($12$ cm²). Povrch se tedy nezmění. U všech čtyř rohových výřezů zůstává povrch $600$ cm².'],
     'ans': 'C) $600$ cm²', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['stereometrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2026 – úloha 14',
     'zad': ['Pomocí hrnku naléváme do prázdného kanystru vodu ze studánky. Po nalití $28$ hrnků plných vody bylo zaplněno sedm osmin objemu kanystru. Když jsme přilili ještě $1$ hrnek plný vody, do úplného zaplnění kanystru chybělo $1050$ ml vody.',
             'Jaký je objem hrnku?'],
     'opts': ['A) $350$ ml', 'B) $300$ ml', 'C) $245$ ml', 'D) $210$ ml', 'E) jiný objem'], 'ln': 0,
     'sol': ['Objem hrnku označme $h$, objem kanystru $V$. Platí $28h=\\frac{7}{8}V$, tedy $V=32h$. Po $29$ hrncích zbývá $V-29h=32h-29h=3h$, což je $1050$ ml. Odtud $h=350$ ml.'],
     'ans': 'A) $350$ ml', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['rovnice', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9B 2026 – úloha 15',
     'zad': ['Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).',
             '15.1 Bedna s jablky váží $20$ kg a je o $25\\,\\%$ těžší než bedna s hruškami. Kolik kg váží bedna s hruškami?',
             '15.2 Z nasbíraných jahod jsme $65\\,\\%$ použili na výrobu džemu, $20\\,\\%$ na výrobu sirupu a zbývající $3$ kg jsme zamrazili. Kolik kg jahod jsme použili na výrobu džemu?',
             '15.3 Celková hmotnost dvou zavazadel je $42$ kg. Menší zavazadlo je o $60\\,\\%$ lehčí než větší zavazadlo. O kolik kg se liší hmotnosti obou zavazadel?'],
     'opts': ['A) $12$ kg', 'B) $13$ kg', 'C) $15$ kg', 'D) $16$ kg', 'E) $18$ kg', 'F) jiný počet kg'], 'ln': 0,
     'sol': ['15.1 $20=1{,}25\\cdot h\\Rightarrow h=16$ kg → D.',
             '15.2 Zamražené $3$ kg tvoří $100\\,\\%-65\\,\\%-20\\,\\%=15\\,\\%$, celkem tedy $20$ kg; na džem $65\\,\\%$ z $20=13$ kg → B.',
             '15.3 Větší zavazadlo $v$, menší $0{,}4v$; $v+0{,}4v=42\\Rightarrow v=30$ kg, menší $12$ kg, rozdíl $30-12=18$ kg → E.'],
     'ans': '15.1: D ($16$ kg); 15.2: B ($13$ kg); 15.3: E ($18$ kg)', 'pts': 6, 'mins': 9, 'diff': '4',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9B 2026 – úloha 16',
     'zad': ['První obrazec je bílý čtverec. Druhý obrazec vznikne z prvního vložením menšího šedého čtverce, jehož vrcholy leží ve středech stran bílého čtverce. Další obrazce vznikají střídavým vkládáním stále menších bílých a šedých čtverců, jejichž vrcholy vždy leží ve středech stran čtverce vloženého v předchozím obrazci (viz obrázek). Druhý a každý další obrazec se skládá z bílých a šedých dílů. Např. třetí obrazec obsahuje $9$ dílů – $1$ bílý čtverec, $4$ šedé trojúhelníky a $4$ bílé trojúhelníky.',
             '16.1 Určete, kolik šedých dílů obsahuje 10. obrazec.',
             '16.2 Určete, kolikátý obrazec obsahuje $89$ bílých dílů.',
             '16.3 Vyjádřete zlomkem, jakou část obsahu 5. obrazce představuje obsah všech jeho šedých dílů dohromady.'],
     'opts': None, 'ln': 4, 'svg': SVG16, 'fn': 'obrazce-ctverce.svg',
     'alt': 'První až čtvrtý obrazec: do bílého čtverce se střídavě vkládají menší šedé a bílé čtverce s vrcholy ve středech stran.',
     'cap': '1., 2., 3. a 4. obrazec',
     'sol': ['Celkový počet dílů roste $1, 5, 9, 13, 17,\\dots$ (o $4$ na obrazec), tj. $4n-3$ dílů. Bílých a šedých dílů přibývá střídavě po $4$: pro $n$-tý obrazec je bílých dílů $2n$ (sudé $n$) nebo $2n-1$ (liché $n$), zbytek je šedý.',
             '16.1 V 10. obrazci je bílých $2\\cdot 10=20$ dílů z celkových $4\\cdot 10-3=37$, šedých je tedy $37-20=17$.',
             '16.2 Pro liché $n$ je bílých dílů $2n-1$; z rovnice $2n-1=89$ plyne $n=45$, tj. 45. obrazec.',
             '16.3 Obsah každého vloženého čtverce je poloviční oproti předchozímu. Šedé díly 5. obrazce mají obsah $\\frac{1}{4}+\\frac{1}{16}=\\frac{5}{16}$ obsahu celého obrazce.'],
     'ans': '16.1: $17$ šedých dílů; 16.2: 45. obrazec; 16.3: $\\frac{5}{16}$', 'pts': 4, 'mins': 8, 'diff': '4',
     'codes': B + ['posloupnosti', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M9PBD26C0T02'
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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M9-2026B')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
