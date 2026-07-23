# -*- coding: utf-8 -*-
# CERMAT – Jednotná přijímací zkouška 2022, MATEMATIKA 7 (šestileté obory), varianta C (1. náhradní termín).
# Kód testu: M7PCD22C0T03. 16 úloh testu; po rozdělení izolovaných podúloh (2.1/2.2, 3.1/3.2) 18 úloh.
# Zdroj odpovědí: klíč správných řešení (KSR). Záznamový arch (VZA) je prázdný formulář.

import math

# ---------- SVG obrázky (bez apostrofů a zpětných lomítek) ----------

# úloha 6: polička – tmavá obdélníková deska na dvou bílých pravoúhlých rovnoramenných trojúhelnících
SVG6 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 220" font-family="sans-serif">
<polygon points="60,70 400,70 360,110 100,110" fill="#9a9a9a" stroke="#000" stroke-width="1.5"/>
<polygon points="100,110 130,110 108,175" fill="#ffffff" stroke="#000" stroke-width="1.5"/>
<polygon points="360,110 388,110 366,175" fill="#ffffff" stroke="#000" stroke-width="1.5"/>
<line x1="60" y1="52" x2="400" y2="52" stroke="#444"/>
<polygon points="60,52 68,48 68,56" fill="#444"/><polygon points="400,52 392,48 392,56" fill="#444"/>
<text x="230" y="44" font-size="15" text-anchor="middle">36 cm</text>
<text x="230" y="205" font-size="12" text-anchor="middle" fill="#555">tmavý obdélník na dvou bílých pravoúhlých rovnoramenných trojúhelnících</text>
</svg>"""

# úloha 7: kvádr 6x4x5 rozdělený dvěma svislými řezy na tři trojboké hranoly
SVG7 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 260" font-family="sans-serif">
<polygon points="70,90 250,90 300,55 120,55" fill="#e6e6e6" stroke="#000" stroke-width="1.5"/>
<polygon points="70,90 250,90 250,210 70,210" fill="#dcdcdc" stroke="#000" stroke-width="1.5"/>
<polygon points="250,90 300,55 300,175 250,210" fill="#cfcfcf" stroke="#000" stroke-width="1.5"/>
<line x1="130" y1="90" x2="170" y2="55" stroke="#000" stroke-dasharray="4 3"/>
<line x1="190" y1="90" x2="240" y2="55" stroke="#000" stroke-dasharray="4 3"/>
<line x1="130" y1="90" x2="130" y2="210" stroke="#000"/>
<line x1="190" y1="90" x2="190" y2="210" stroke="#000"/>
<text x="52" y="155" font-size="14" text-anchor="end">5 cm</text>
<text x="160" y="230" font-size="14" text-anchor="middle">6 cm</text>
<text x="315" y="140" font-size="14">4 cm</text>
<text x="240" y="248" font-size="12" text-anchor="middle" fill="#555">dva svislé řezy dělí kvádr na tři trojboké hranoly</text>
</svg>"""

# úloha 8: body P, Q a přímka o
SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 320" font-family="sans-serif">
<rect x="8" y="8" width="444" height="304" fill="none" stroke="#bbb"/>
<line x1="150" y1="290" x2="410" y2="70" stroke="#000" stroke-width="2"/>
<text x="420" y="66" font-size="16" font-style="italic">o</text>
<text x="150" y="95" font-size="15" text-anchor="middle">×</text>
<text x="150" y="80" font-size="15" text-anchor="middle" font-style="italic">P</text>
<text x="120" y="205" font-size="15" text-anchor="middle">×</text>
<text x="120" y="225" font-size="15" text-anchor="middle" font-style="italic">Q</text>
</svg>"""

# úloha 9: body A, X a rovnoběžné přímky c, p
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 320" font-family="sans-serif">
<rect x="8" y="8" width="444" height="304" fill="none" stroke="#bbb"/>
<line x1="60" y1="90" x2="400" y2="90" stroke="#000" stroke-width="2"/>
<text x="40" y="95" font-size="16" font-style="italic">c</text>
<line x1="60" y1="150" x2="400" y2="150" stroke="#000" stroke-width="2"/>
<text x="40" y="155" font-size="16" font-style="italic">p</text>
<text x="255" y="215" font-size="15" text-anchor="middle">×</text>
<text x="255" y="233" font-size="15" text-anchor="middle" font-style="italic">X</text>
<text x="175" y="270" font-size="15" text-anchor="middle">×</text>
<text x="175" y="288" font-size="15" text-anchor="middle" font-style="italic">A</text>
</svg>"""

# úloha 10: skupinový sloupcový graf (zakoupené / vzrostlé / prodané) pro druhy A–D
def _bars10():
    groups = [('A', 14, 12, 7), ('B', 9, 9, 9), ('C', 8, 8, 4), ('D', 11, 8, 8)]
    x0, y0 = 62, 300; u = 15; bw = 17; gap = 3; ggap = 30
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 372" font-family="sans-serif">']
    s.append('<defs>')
    s.append('<pattern id="dot" width="6" height="6" patternUnits="userSpaceOnUse"><rect width="6" height="6" fill="#fff"/><circle cx="3" cy="3" r="1" fill="#000"/></pattern>')
    s.append('<pattern id="hatch" width="6" height="6" patternUnits="userSpaceOnUse"><rect width="6" height="6" fill="#fff"/><path d="M0,6 L6,0" stroke="#000" stroke-width="1"/></pattern>')
    s.append('</defs>')
    s.append(f'<line x1="{x0}" y1="34" x2="{x0}" y2="{y0}" stroke="#000"/><line x1="{x0}" y1="{y0}" x2="520" y2="{y0}" stroke="#000"/>')
    for v in range(0, 17, 2):
        y = y0 - v * u
        s.append(f'<line x1="{x0-4}" y1="{y}" x2="{x0}" y2="{y}" stroke="#000"/><text x="{x0-8}" y="{y+4}" font-size="11" text-anchor="end">{v}</text>')
    s.append('<text x="20" y="170" font-size="12" text-anchor="middle" transform="rotate(-90 20 170)">počet kusů rostlin</text>')
    x = x0 + ggap
    for name, a, b, c in groups:
        gstart = x
        for val, fill in ((a, 'url(#dot)'), (b, '#9a9a9a'), (c, 'url(#hatch)')):
            h = val * u
            s.append(f'<rect x="{x}" y="{y0-h}" width="{bw}" height="{h}" fill="{fill}" stroke="#000"/>')
            x += bw + gap
        cx = gstart + (3 * bw + 2 * gap) / 2
        s.append(f'<text x="{cx:.0f}" y="{y0+18}" font-size="13" text-anchor="middle">{name}</text>')
        x += ggap
    ly = 350
    s.append(f'<rect x="90" y="{ly-11}" width="13" height="13" fill="url(#dot)" stroke="#000"/><text x="108" y="{ly}" font-size="12">zakoupené</text>')
    s.append(f'<rect x="215" y="{ly-11}" width="13" height="13" fill="#9a9a9a" stroke="#000"/><text x="233" y="{ly}" font-size="12">vzrostlé</text>')
    s.append(f'<rect x="330" y="{ly-11}" width="13" height="13" fill="url(#hatch)" stroke="#000"/><text x="348" y="{ly}" font-size="12">prodané</text>')
    s.append('</svg>')
    return ''.join(s)
SVG10 = _bars10()

# úloha 11: čtyři přímky (dvě rovnoběžné, dvě kolmé), úhly 2α, 3α, β a pravý úhel
def _lines11():
    V1 = (180.0, 140.0)
    a = (0.6, -0.8)         # směr rovnoběžek (nahoru-vpravo)
    bd = (0.575, 0.818)     # směr příčné přímky B (dolů-vpravo)
    def pt(P, d, t): return (P[0] + d[0] * t, P[1] + d[1] * t)
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 400" font-family="sans-serif">']
    s.append('<rect x="6" y="6" width="608" height="388" fill="none" stroke="#bbb"/>')
    A_up = pt(V1, a, 95); A_dn = pt(V1, (-a[0], -a[1]), 120)
    s.append(f'<line x1="{A_dn[0]:.0f}" y1="{A_dn[1]:.0f}" x2="{A_up[0]:.0f}" y2="{A_up[1]:.0f}" stroke="#000" stroke-width="1.8"/>')
    tk = pt(V1, a, 80)
    s.append(f'<line x1="{tk[0]-6:.0f}" y1="{tk[1]-3:.0f}" x2="{tk[0]+2:.0f}" y2="{tk[1]-11:.0f}" stroke="#000"/>')
    s.append(f'<line x1="{tk[0]-2:.0f}" y1="{tk[1]+1:.0f}" x2="{tk[0]+6:.0f}" y2="{tk[1]-7:.0f}" stroke="#000"/>')
    B_up = pt(V1, (-bd[0], -bd[1]), 55); B_dn = pt(V1, bd, 215)
    s.append(f'<line x1="{B_up[0]:.0f}" y1="{B_up[1]:.0f}" x2="{B_dn[0]:.0f}" y2="{B_dn[1]:.0f}" stroke="#000" stroke-width="1.8"/>')
    V2 = pt(V1, bd, 120)
    cd = (0.818, -0.575)
    C_up = pt(V2, cd, 150); C_dn = pt(V2, (-cd[0], -cd[1]), 80)
    s.append(f'<line x1="{C_dn[0]:.0f}" y1="{C_dn[1]:.0f}" x2="{C_up[0]:.0f}" y2="{C_up[1]:.0f}" stroke="#000" stroke-width="1.8"/>')
    V3 = pt(V2, cd, 130)
    P2_up = pt(V3, a, 70); P2_dn = pt(V3, (-a[0], -a[1]), 55)
    s.append(f'<line x1="{P2_dn[0]:.0f}" y1="{P2_dn[1]:.0f}" x2="{P2_up[0]:.0f}" y2="{P2_up[1]:.0f}" stroke="#000" stroke-width="1.8"/>')
    tk2 = pt(V3, a, 58)
    s.append(f'<line x1="{tk2[0]-6:.0f}" y1="{tk2[1]-3:.0f}" x2="{tk2[0]+2:.0f}" y2="{tk2[1]-11:.0f}" stroke="#000"/>')
    s.append(f'<line x1="{tk2[0]-2:.0f}" y1="{tk2[1]+1:.0f}" x2="{tk2[0]+6:.0f}" y2="{tk2[1]-7:.0f}" stroke="#000"/>')
    q = 12
    p1 = pt(V2, cd, q); p2 = pt(V2, (-bd[0], -bd[1]), q); p3 = (p1[0] + (-bd[0]) * q, p1[1] + (-bd[1]) * q)
    s.append(f'<polyline points="{p1[0]:.0f},{p1[1]:.0f} {p3[0]:.0f},{p3[1]:.0f} {p2[0]:.0f},{p2[1]:.0f}" fill="none" stroke="#000"/>')
    s.append(f'<circle cx="{V2[0]:.0f}" cy="{V2[1]:.0f}" r="1.6" fill="#000"/>')
    s.append(f'<text x="{V1[0]+18:.0f}" y="{V1[1]-30:.0f}" font-size="15" font-style="italic">2α</text>')
    s.append(f'<text x="{V1[0]-42:.0f}" y="{V1[1]+2:.0f}" font-size="15" font-style="italic">3α</text>')
    s.append(f'<text x="{V3[0]-8:.0f}" y="{V3[1]+30:.0f}" font-size="15" font-style="italic">β</text>')
    s.append('</svg>')
    return ''.join(s)
SVG11 = _lines11()

# úlohy 12–13: čtvercová síť se dvěma obdélníky, kratší strana 9 cm
def _grid1213():
    cell = 16; ox = 250; oy = 40
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 210" font-family="sans-serif">']
    for i in range(0, 13):
        s.append(f'<line x1="{ox+i*cell}" y1="{oy}" x2="{ox+i*cell}" y2="{oy+9*cell}" stroke="#ddd"/>')
    for j in range(0, 10):
        s.append(f'<line x1="{ox}" y1="{oy+j*cell}" x2="{ox+12*cell}" y2="{oy+j*cell}" stroke="#ddd"/>')
    s.append(f'<rect x="{ox}" y="{oy}" width="{11*cell}" height="{9*cell}" fill="none" stroke="#000" stroke-width="2"/>')
    for j in range(0, 10):
        s.append(f'<circle cx="{ox}" cy="{oy+j*cell}" r="2.2" fill="#000"/>')
    s.append(f'<line x1="{ox-18}" y1="{oy}" x2="{ox-18}" y2="{oy+9*cell}" stroke="#444"/>')
    s.append(f'<polygon points="{ox-18},{oy} {ox-22},{oy+8} {ox-14},{oy+8}" fill="#444"/>')
    s.append(f'<polygon points="{ox-18},{oy+9*cell} {ox-22},{oy+9*cell-8} {ox-14},{oy+9*cell-8}" fill="#444"/>')
    s.append(f'<text x="{ox-26}" y="{oy+9*cell//2+4}" font-size="13" text-anchor="end">9 cm</text>')
    s.append('<text x="240" y="200" font-size="11" text-anchor="middle" fill="#555">schéma: kratší strana 9 cm obsahuje 10 mřížových bodů</text>')
    s.append('</svg>')
    return ''.join(s)
SVG1213 = _grid1213()

# úloha 16: výsledný obrazec – schéma (m = 4): černé puntíky v průsečících, bílé puntíky na spodní přímce
def _fig16():
    m = 4; half = 26; ox = 250; oy = 150
    def XY(i, j):
        return (ox + (i + j - (m - 1)) * half, oy + (j - i) * half)
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 340" font-family="sans-serif">']
    for i in range(m):
        xa = ox + (2 * i - (m - 1) - (m - 1)) * half; ya = oy - (m - 1) * half
        xb = ox + (2 * i + (m - 1) - (m - 1)) * half; yb = oy + (m - 1) * half
        s.append(f'<line x1="{xa}" y1="{ya}" x2="{xb}" y2="{yb}" stroke="#000"/>')
    for j in range(m):
        xa = ox + (2 * j + (m - 1) - (m - 1)) * half; ya = oy - (m - 1) * half
        xb = ox + (2 * j - (m - 1) - (m - 1)) * half; yb = oy + (m - 1) * half
        s.append(f'<line x1="{xa}" y1="{ya}" x2="{xb}" y2="{yb}" stroke="#000"/>')
    for k in range(-(m - 1), m):
        allx = [ox + (2 * i + k - (m - 1)) * half for i in range(m)] + [ox + (2 * j - k - (m - 1)) * half for j in range(m)]
        y = oy + k * half
        s.append(f'<line x1="{min(allx)}" y1="{y}" x2="{max(allx)}" y2="{y}" stroke="#000"/>')
    for i in range(m):
        for j in range(m):
            x, y = XY(i, j)
            s.append(f'<circle cx="{x:.0f}" cy="{y:.0f}" r="3.4" fill="#000"/>')
    yb = oy + (m - 1) * half
    xs_bottom = sorted(set([ox + (2 * i + (m - 1) - (m - 1)) * half for i in range(m)] + [ox + (2 * j - (m - 1) - (m - 1)) * half for j in range(m)]))
    for x in xs_bottom:
        if abs(x - ox) < 1:
            continue
        s.append(f'<circle cx="{x:.0f}" cy="{yb:.0f}" r="3.6" fill="#fff" stroke="#000" stroke-width="1.4"/>')
    s.append('<text x="250" y="325" font-size="11" text-anchor="middle" fill="#555">schéma výsledného obrazce (černé průsečíky, bílé puntíky na spodní přímce)</text>')
    s.append('</svg>')
    return ''.join(s)
SVG16 = _fig16()

# ---------- Úlohy ----------

B = ['zs2', 'r7']  # 7. ročník, šestileté obory (2. stupeň ZŠ / nižší gymnázium)

PROBLEMS = [
    {'name': 'CERMAT M7C 2022 – úloha 1',
     'zad': ['Vypočtěte: $\\dfrac{10\\cdot 10\\cdot(10\\cdot 10-1)}{10\\cdot 10\\cdot 10+10\\cdot 10}=$'],
     'opts': None, 'ln': 2,
     'sol': ['Čitatel $100\\cdot 99=9\\,900$, jmenovatel $1\\,000+100=1\\,100$; podíl $9\\,900:1\\,100=9$.'],
     'ans': '$9$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7C 2022 – úloha 2.1',
     'zad': ['Z kabelu dlouhého $5{,}1$ metru jsme uřízli tři půlmetrové kusy a zbytek jsme rozdělili na $12$ stejně dlouhých dílů. Určete, kolik centimetrů měří jeden díl.'],
     'opts': None, 'ln': 2,
     'sol': ['Tři půlmetrové kusy měří $3\\cdot 0{,}5=1{,}5$ m. Zbytek $5{,}1-1{,}5=3{,}6$ m $=360$ cm. Jeden díl $360:12=30$ cm.'],
     'ans': '$30$ cm', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7C 2022 – úloha 2.2',
     'zad': ['Cesta na kole z Roztok do Neratovic trvá $1$ hodinu a $50$ minut. S využitím přívozu se doba cestování zkrátí o $40\\,\\%$. Vypočtěte, kolik minut trvá cesta z Roztok do Neratovic s využitím přívozu.'],
     'opts': None, 'ln': 2,
     'sol': ['$1$ h $50$ min $=110$ min. Zkrácení o $40\\,\\%$ je $0{,}4\\cdot 110=44$ min. Cesta s přívozem trvá $110-44=66$ min.'],
     'ans': '$66$ min', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7C 2022 – úloha 3.1',
     'zad': ['Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\dfrac{1}{3}\\cdot\\left(5-\\dfrac{13}{5}\\right):20=$'],
     'opts': None, 'ln': 3,
     'sol': ['$5-\\dfrac{13}{5}=\\dfrac{12}{5}$; dále $\\dfrac{1}{3}\\cdot\\dfrac{12}{5}=\\dfrac{12}{15}=\\dfrac{4}{5}$; a nakonec $\\dfrac{4}{5}:20=\\dfrac{4}{100}=\\dfrac{1}{25}$.'],
     'ans': '$\\dfrac{1}{25}$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7C 2022 – úloha 3.2',
     'zad': ['Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\dfrac{\\frac{2}{3}-\\frac{3}{2}}{\\frac{2}{3}:\\frac{3}{2}}=$'],
     'opts': None, 'ln': 3,
     'sol': ['Čitatel: $\\dfrac{2}{3}-\\dfrac{3}{2}=\\dfrac{4-9}{6}=-\\dfrac{5}{6}$. Jmenovatel: $\\dfrac{2}{3}:\\dfrac{3}{2}=\\dfrac{2}{3}\\cdot\\dfrac{2}{3}=\\dfrac{4}{9}$. Podíl: $-\\dfrac{5}{6}:\\dfrac{4}{9}=-\\dfrac{5}{6}\\cdot\\dfrac{9}{4}=-\\dfrac{45}{24}=-\\dfrac{15}{8}$.'],
     'ans': '$-\\dfrac{15}{8}$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7C 2022 – úloha 4',
     'zad': [
        'Po jarních prázdninách postupně onemocnělo mnoho žáků. V pondělí chyběla $\\frac{1}{6}$ všech žáků školy. V úterý byla nemocná již $\\frac{1}{4}$ všech žáků školy. V pátek byla ve škole už jen $\\frac{1}{3}$ všech žáků školy, tedy $80$ nejodolnějších žáků. Všichni ostatní žáci školy byli nemocní.',
        '4.1 Vypočtěte, kolik žáků měla škola.',
        '4.2 Vypočtěte, kolik žáků bylo v pondělí ve škole.',
        '4.3 Vypočtěte, o kolik nemocných žáků bylo v pátek více než v úterý.'],
     'opts': None, 'ln': 3,
     'sol': [
        '4.1 V pátek byla ve škole $\\frac{1}{3}$ žáků $=80$, tedy celkem $80\\cdot 3=240$ žáků.',
        '4.2 V pondělí chybělo $\\frac{1}{6}$ z $240$, tj. $40$ žáků; ve škole bylo $240-40=200$ žáků.',
        '4.3 V úterý bylo nemocných $\\frac{1}{4}$ z $240=60$ žáků, v pátek $240-80=160$ žáků; rozdíl $160-60=100$ žáků.'],
     'ans': '4.1: $240$ žáků; 4.2: $200$ žáků; 4.3: o $100$ žáků',
     'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7C 2022 – úloha 5',
     'zad': [
        'Pro soutěž Malování na chodník bylo připraveno celkem $300$ kříd zabalených v krabičkách dvou velikostí – menších a větších. V krabičkách téže velikosti byl vždy stejný počet kříd. Menších krabiček bylo pouze $5$ a celkem v nich bylo tolik kříd jako ve $3$ větších krabičkách. Každá z větších krabiček obsahovala $10$ kříd.',
        '5.1 Určete počet kříd v jedné menší krabičce.',
        '5.2 Určete počet všech větších krabiček s křídami.'],
     'opts': None, 'ln': 2,
     'sol': [
        '5.1 Ve $3$ větších krabičkách je $3\\cdot 10=30$ kříd; tolik je i v $5$ menších, tedy v jedné menší $30:5=6$ kříd.',
        '5.2 V menších krabičkách je celkem $30$ kříd, ve větších $300-30=270$ kříd; větších krabiček je $270:10=27$.'],
     'ans': '5.1: $6$ kříd; 5.2: $27$ větších krabiček',
     'pts': 3, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7C 2022 – úloha 6',
     'zad': [
        'Poličku na zeď tvoří tmavá obdélníková deska podepřená dvěma stejnými bílými trojúhelníkovými deskami. Tloušťku desek zanedbáváme. Bílý trojúhelník má obsah $50$ cm², je pravoúhlý a rovnoramenný. Rameno trojúhelníku má stejnou délku jako kratší strana obdélníku. Delší strana tmavého obdélníku měří $36$ cm.',
        '6.1 Vypočtěte v cm obvod obdélníku.',
        '6.2 Vypočtěte v cm² obsah obdélníku.'],
     'opts': None, 'ln': 2, 'svg': SVG6, 'fn': 'policka.svg',
     'alt': 'Tmavá obdélníková deska poličky podepřená dvěma bílými pravoúhlými rovnoramennými trojúhelníky; delší strana desky měří 36 cm.',
     'cap': 'Schematický nákres poličky',
     'sol': [
        'Pravoúhlý rovnoramenný trojúhelník s rameny (odvěsnami) délky $r$ má obsah $\\frac{1}{2}r^2=50$, tedy $r^2=100$ a $r=10$ cm. Kratší strana obdélníku je $10$ cm.',
        '6.1 Obvod $=2\\cdot(36+10)=92$ cm.',
        '6.2 Obsah $=36\\cdot 10=360$ cm².'],
     'ans': '6.1: $92$ cm; 6.2: $360$ cm²',
     'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7C 2022 – úloha 7',
     'zad': [
        'Kvádr o rozměrech $6$ cm, $4$ cm a $5$ cm jsme dvěma svislými řezy rozdělili na tři kolmé trojboké hranoly (viz obrázek).',
        '7.1 Vypočtěte v cm² povrch kvádru.',
        '7.2 Ze tří trojbokých hranolů vybereme ten, který má největší objem. Vypočtěte v cm³ objem vybraného trojbokého hranolu.'],
     'opts': None, 'ln': 4, 'svg': SVG7, 'fn': 'kvadr-hranoly.svg',
     'alt': 'Kvádr o rozměrech 6 cm, 4 cm a 5 cm rozdělený dvěma svislými řezy na tři trojboké hranoly.',
     'cap': 'Kvádr rozdělený na tři trojboké hranoly',
     'sol': [
        '7.1 Povrch kvádru $=2\\cdot(6\\cdot 4+6\\cdot 5+4\\cdot 5)=2\\cdot(24+30+20)=148$ cm².',
        '7.2 Řezy jsou svislé, výška všech hranolů je $5$ cm. Podstavy vzniknou rozdělením obdélníku $6\\times 4$ (obsah $24$ cm²); největší podstava má obsah $12$ cm². Objem $=12\\cdot 5=60$ cm³.'],
     'ans': '7.1: $148$ cm²; 7.2: $60$ cm³',
     'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['stereometrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7C 2022 – úloha 8 (konstrukce)',
     'zad': [
        'V rovině leží body $P$, $Q$ a přímka $o$ (viz obrázek).',
        'Body $P$, $Q$ jsou vrcholy trojúhelníku $PQR$. Přímka $o$ je osou některé strany tohoto trojúhelníku.',
        'Sestrojte vrchol $R$ trojúhelníku $PQR$, označte ho písmenem a trojúhelník narýsujte. Najděte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG8, 'fn': 'body-PQ-o.svg',
     'alt': 'Body P a Q a šikmá přímka o v rovině.',
     'cap': 'Výchozí obrázek k úloze 8',
     'sol': [
        'Přímka $o$ může být osou strany $PR$, nebo osou strany $QR$. Je-li $o$ osou $PR$, je vrchol $R$ obrazem bodu $P$ v osové souměrnosti s osou $o$ (řešení $R_1$). Je-li $o$ osou $QR$, je vrchol $R$ obrazem bodu $Q$ v osové souměrnosti s osou $o$ (řešení $R_2$). Úloha má dvě řešení.'],
     'ans': 'Dvě řešení: $R_1$ je obraz bodu $P$ a $R_2$ je obraz bodu $Q$ v osové souměrnosti s osou $o$ (viz obrázek v klíči).',
     'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7C 2022 – úloha 9 (konstrukce)',
     'zad': [
        'V rovině leží body $A$, $X$ a rovnoběžné přímky $c$, $p$ (viz obrázek).',
        'Bod $A$ je vrchol obdélníku $ABCD$. Bod $X$ leží uvnitř strany $AB$ obdélníku. Na přímce $c$ leží vrchol $C$ obdélníku $ABCD$ a na přímce $p$ jeden ze zbývajících dvou vrcholů obdélníku.',
        'Sestrojte vrcholy $B$, $C$, $D$ obdélníku $ABCD$, označte je písmeny a obdélník narýsujte. Najděte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG9, 'fn': 'body-AX-cp.svg',
     'alt': 'Body A a X a dvě rovnoběžné vodorovné přímky c a p v rovině.',
     'cap': 'Výchozí obrázek k úloze 9',
     'sol': [
        'Strana $AB$ leží na přímce $AX$; strana $AD$ je k ní kolmá. Vrchol $C$ leží na přímce $c$ a jeden z vrcholů $B$, $D$ leží na přímce $p$. Rozborem obou možností (na přímce $p$ leží buď $B$, nebo $D$) a využitím rovnoběžnosti $c\\parallel p$ dostaneme dvě polohy obdélníku – $AB_1C_1D_1$ a $AB_2C_2D_2$. Úloha má dvě řešení.'],
     'ans': 'Dvě řešení – obdélníky $AB_1C_1D_1$ a $AB_2C_2D_2$ ($C$ na přímce $c$, jeden ze zbývajících vrcholů na přímce $p$); viz obrázek v klíči.',
     'pts': 3, 'mins': 7, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7C 2022 – úloha 10',
     'zad': [
        'Zahrádkář zakoupil několik kusů rostlin od každého ze čtyř druhů $A$, $B$, $C$ a $D$. Některé zakoupené rostliny uschly, ostatní vzrostly. Většinu vzrostlých rostlin zahrádkář později prodal. Graf udává počty zakoupených, vzrostlých a prodaných kusů rostlin jednotlivých druhů.',
        'Rozhodněte o každém z tvrzení 10.1–10.3, zda je pravdivé (A), či nikoli (N).',
        '10.1 Zahrádkáři zůstalo celkem $9$ neprodaných kusů vzrostlých rostlin.',
        '10.2 Zahrádkář zakoupil o polovinu více kusů rostlin, než jich prodal.',
        '10.3 Zahrádkář prodal všechny zakoupené kusy jen u jednoho druhu rostlin.'],
     'opts': None, 'ln': 0, 'svg': SVG10, 'fn': 'graf-rostliny.svg',
     'alt': 'Skupinový sloupcový graf počtu zakoupených, vzrostlých a prodaných kusů rostlin druhů A, B, C, D.',
     'cap': 'Počty rostlin podle druhů (kusy)',
     'sol': [
        'Z grafu: $A$ – zakoupené $14$, vzrostlé $12$, prodané $7$; $B$ – $9$, $9$, $9$; $C$ – $8$, $8$, $4$; $D$ – $11$, $8$, $8$.',
        '10.1 Neprodané vzrostlé: $(12-7)+(9-9)+(8-4)+(8-8)=5+0+4+0=9$ → Ano.',
        '10.2 Zakoupených $14+9+8+11=42$, prodaných $7+9+4+8=28$; $42=1{,}5\\cdot 28$, tj. o polovinu více → Ano.',
        '10.3 Prodané se rovnají zakoupeným jen u druhu $B$ ($9=9$) → Ano.'],
     'ans': '10.1: Ano; 10.2: Ano; 10.3: Ano',
     'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['statistika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7C 2022 – úloha 11',
     'zad': [
        'V rovině leží čtyři přímky, z nichž dvě jsou rovnoběžné a zbývající dvě jsou na sebe kolmé (viz obrázek). U jednoho průsečíku jsou vyznačeny úhly $2\\alpha$ a $3\\alpha$, u jiného průsečíku úhel $\\beta$.',
        'Jaká je velikost úhlu $\\beta$? Velikosti úhlů neměřte, ale vypočtěte.'],
     'opts': ['A) menší než $20^\\circ$', 'B) $20^\\circ$', 'C) $28^\\circ$', 'D) $34^\\circ$', 'E) větší než $34^\\circ$'],
     'ln': 0, 'svg': SVG11, 'fn': 'ctyri-primky-uhly.svg',
     'alt': 'Čtyři přímky – dvě rovnoběžné a dvě navzájem kolmé; vyznačené úhly 2 alfa, 3 alfa, beta a jeden pravý úhel.',
     'cap': 'Schematický nákres k úloze 11',
     'sol': [
        'Úhly $2\\alpha$ a $3\\alpha$ jsou vedlejší (leží při téže přímce), proto $2\\alpha+3\\alpha=180^\\circ$, tedy $5\\alpha=180^\\circ$ a $\\alpha=36^\\circ$. Šikmá přímka svírá s rovnoběžkami úhel $2\\alpha=72^\\circ$. Druhá šikmá přímka je na ni kolmá, a proto s rovnoběžkami svírá úhel $\\beta=90^\\circ-72^\\circ=18^\\circ$, což je méně než $20^\\circ$.'],
     'ans': 'A) menší než $20^\\circ$',
     'pts': 2, 'mins': 4, 'diff': '4',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7C 2022 – úloha 12',
     'zad': [
        'Ve čtvercové síti sestrojíme dva obdélníky s vrcholy v mřížových bodech podle vzoru na obrázku. Kratší strana obdélníku má vždy délku $9$ cm a obsahuje $10$ mřížových bodů.',
        'První sestrojený obdélník obsahuje celkem $120$ mřížových bodů (včetně mřížových bodů po jeho obvodu). Jaký je obsah tohoto obdélníku?'],
     'opts': ['A) $90$ cm²', 'B) $99$ cm²', 'C) $108$ cm²', 'D) $120$ cm²', 'E) jiný obsah'],
     'ln': 0, 'svg': SVG1213, 'fn': 'ctvercova-sit-obdelniky.svg',
     'alt': 'Čtvercová síť se dvěma obdélníky; kratší strana měří 9 cm a obsahuje 10 mřížových bodů.',
     'cap': 'Schematický nákres k úlohám 12 a 13',
     'sol': [
        'Kratší strana má $10$ mřížových bodů, tedy $9$ dílků po $1$ cm (rozteč sítě je $1$ cm). Celkem $120$ mřížových bodů $=10\\times 12$, delší strana má tedy $12$ bodů, tj. $11$ cm. Obsah $=9\\cdot 11=99$ cm².'],
     'ans': 'B) $99$ cm²',
     'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7C 2022 – úloha 13',
     'zad': [
        'Ve čtvercové síti sestrojíme dva obdélníky s vrcholy v mřížových bodech podle vzoru na obrázku. Kratší strana obdélníku má vždy délku $9$ cm a obsahuje $10$ mřížových bodů.',
        'Obvod druhého sestrojeného obdélníku je $120$ cm. Kolik mřížových bodů celkem obsahuje tento obdélník (včetně mřížových bodů po jeho obvodu)?'],
     'opts': ['A) $500$', 'B) $510$', 'C) $520$', 'D) $530$', 'E) jiný počet'],
     'ln': 0, 'svg': SVG1213, 'fn': 'ctvercova-sit-obdelniky.svg',
     'alt': 'Čtvercová síť se dvěma obdélníky; kratší strana měří 9 cm a obsahuje 10 mřížových bodů.',
     'cap': 'Schematický nákres k úlohám 12 a 13',
     'sol': [
        'Rozteč sítě je $1$ cm (kratší strana $9$ cm má $10$ bodů). Obvod $=2\\cdot(9+b)=120$, tedy $9+b=60$ a $b=51$ cm. Delší strana má $52$ mřížových bodů, kratší $10$. Celkem $10\\cdot 52=520$ mřížových bodů.'],
     'ans': 'C) $520$',
     'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7C 2022 – úloha 14',
     'zad': [
        'Hruškový král rozdělil podle zásluh všechny zlaté hrušky mezi tři rytíře. Jednu sedminu všech hrušek získal první rytíř, druhý získal o $42$ hrušek více než první a třetí získal třikrát více hrušek než první.',
        'Kolik zlatých hrušek dohromady získali první a druhý rytíř?'],
     'opts': ['A) $54$', 'B) $56$', 'C) $70$', 'D) $84$', 'E) jiný počet'],
     'ln': 0,
     'sol': [
        'Označme počet hrušek prvního rytíře $x$; celkem je pak $7x$. Druhý má $x+42$, třetí $3x$. Ze součtu $x+(x+42)+3x=7x$ plyne $5x+42=7x$, tedy $2x=42$ a $x=21$. První a druhý mají dohromady $x+(x+42)=21+63=84$ hrušek.'],
     'ans': 'D) $84$',
     'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7C 2022 – úloha 15',
     'zad': [
        'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).',
        '15.1 Když firma odvezla do spalovny $60\\,\\%$ odpadu, zbylo jí ještě $1\\,200$ kg odpadu. Kolik kg odpadu firma odvezla do spalovny?',
        '15.2 Stejné dlaždice byly umístěny ve stejném počtu na dvou paletách. Již se prodaly dvě pětiny dlaždic z první palety a $10\\,\\%$ dlaždic z druhé palety. Hmotnost všech těchto prodaných dlaždic byla $750$ kg. Kolik kg váží dosud neprodané dlaždice z obou palet?',
        '15.3 Ve sběrných surovinách vykoupili v létě $1\\,500$ kg kovů, což je o $50\\,\\%$ více než na jaře a o $50\\,\\%$ méně než na podzim. O kolik kg kovů vykoupili na podzim více než na jaře?'],
     'opts': ['A) $1\\,500$ kg', 'B) $1\\,800$ kg', 'C) $2\\,000$ kg', 'D) $2\\,100$ kg', 'E) $2\\,250$ kg', 'F) jiný počet kg'],
     'ln': 0,
     'sol': [
        '15.1 Zbylých $1\\,200$ kg je $40\\,\\%$; $100\\,\\%=3\\,000$ kg, odvezeno $60\\,\\%=1\\,800$ kg → B.',
        '15.2 Prodané: $\\frac{2}{5}M+0{,}1M=0{,}5M=750$ kg, tedy $M=1\\,500$ kg na paletu, obě palety $3\\,000$ kg; neprodané $3\\,000-750=2\\,250$ kg → E.',
        '15.3 Léto $1\\,500$ kg $=1{,}5\\cdot$ jaro → jaro $1\\,000$ kg; léto $=0{,}5\\cdot$ podzim → podzim $3\\,000$ kg; rozdíl $3\\,000-1\\,000=2\\,000$ kg → C.'],
     'ans': '15.1: B ($1\\,800$ kg); 15.2: E ($2\\,250$ kg); 15.3: C ($2\\,000$ kg)',
     'pts': 6, 'mins': 8, 'diff': '4',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7C 2022 – úloha 16',
     'zad': [
        'Výsledný obrazec vytvoříme takto: (1) Na vodorovné přímce sestrojíme několik stejně vzdálených bodů (černých puntíků). (2) Prvním černým puntíkem vedeme dvě různoběžné šikmé přímky; druhým a každým dalším černým puntíkem vedeme rovnoběžky s oběma těmito přímkami. (3) Všechny nově vzniklé průsečíky označíme černými puntíky a těmi vedeme vodorovné přímky. (4) Na spodní vodorovné přímce označíme všechny nově vzniklé průsečíky bílými puntíky.',
        '16.1 Výsledný obrazec obsahuje celkem $36$ černých puntíků. Určete počet všech vodorovných přímek v tomto obrazci.',
        '16.2 Výsledný obrazec obsahuje celkem $49$ vodorovných přímek. Určete počet bílých puntíků na spodní vodorovné přímce tohoto obrazce.',
        '16.3 Výsledný obrazec má na spodní vodorovné přímce celkem $64$ bílých puntíků. Určete počet všech černých puntíků v tomto obrazci.'],
     'opts': None, 'ln': 3, 'svg': SVG16, 'fn': 'obrazec-puntiky.svg',
     'alt': 'Schéma výsledného obrazce: dvě rodiny šikmých rovnoběžek a vodorovné přímky, černé puntíky v průsečících a bílé puntíky na spodní přímce.',
     'cap': 'Schematický nákres výsledného obrazce',
     'sol': [
        'Je-li na horní přímce $m$ výchozích bodů, vznikne $m^2$ černých puntíků, $2m-1$ vodorovných přímek a $2m-2$ bílých puntíků na spodní přímce.',
        '16.1 $m^2=36\\Rightarrow m=6$; vodorovných přímek $2\\cdot 6-1=11$.',
        '16.2 $2m-1=49\\Rightarrow m=25$; bílých puntíků $2\\cdot 25-2=48$.',
        '16.3 $2m-2=64\\Rightarrow m=33$; černých puntíků $33^2=1\\,089$.'],
     'ans': '16.1: $11$ vodorovných přímek; 16.2: $48$ bílých puntíků; 16.3: $1\\,089$ černých puntíků',
     'pts': 4, 'mins': 6, 'diff': '4',
     'codes': B + ['posloupnosti', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M7PCD22C0T03'
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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M7C-2022')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
