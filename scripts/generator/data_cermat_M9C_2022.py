# -*- coding: utf-8 -*-
# CERMAT – Jednotná přijímací zkouška 2022, MATEMATIKA 9, čtyřleté obory (9. ročník).
# Varianta C (1. náhradní termín). Kód testu: M9PCD22C0T03. 16 úloh v testu.
# Izolované podúlohy bez sdíleného kontextu (2, 3, 4, 5) rozděleny -> 21 samostatných úloh.
# Zdroj odpovědí: klíč správných řešení (KSR).

import math

# ---- SVG obrázky (bez ' a \) ----

# úloha 8: polička – tmavá obdélníková deska na dvou bílých trojúhelníkových podpěrách
SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 290" font-family="sans-serif">
<polygon points="125,150 175,115 150,250" fill="#ffffff" stroke="#000" stroke-width="1.5"/>
<polygon points="440,150 490,115 465,250" fill="#ffffff" stroke="#000" stroke-width="1.5"/>
<polygon points="120,150 435,150 495,115 180,115" fill="#565656" stroke="#000" stroke-width="1.6"/>
<text x="95" y="130" font-size="15" text-anchor="middle">9 cm</text>
<text x="505" y="190" font-size="15">15 cm</text>
</svg>"""

# úloha 9: body P, Q a přímka o
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 380" font-family="sans-serif">
<line x1="330" y1="345" x2="600" y2="110" stroke="#000" stroke-width="1.8"/>
<text x="600" y="102" font-size="16" font-style="italic">o</text>
<line x1="293" y1="93" x2="307" y2="107" stroke="#000" stroke-width="1.6"/>
<line x1="293" y1="107" x2="307" y2="93" stroke="#000" stroke-width="1.6"/>
<text x="300" y="83" font-size="16" font-style="italic">P</text>
<line x1="228" y1="243" x2="242" y2="257" stroke="#000" stroke-width="1.6"/>
<line x1="228" y1="257" x2="242" y2="243" stroke="#000" stroke-width="1.6"/>
<text x="235" y="278" font-size="16" font-style="italic">Q</text>
</svg>"""

# úloha 10: body A, X a rovnoběžné přímky c, p
SVG10 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 400" font-family="sans-serif">
<line x1="60" y1="95" x2="560" y2="95" stroke="#000" stroke-width="1.8"/>
<text x="44" y="100" font-size="16" font-style="italic">c</text>
<line x1="60" y1="180" x2="560" y2="180" stroke="#000" stroke-width="1.8"/>
<text x="44" y="185" font-size="16" font-style="italic">p</text>
<line x1="323" y1="248" x2="337" y2="262" stroke="#000" stroke-width="1.6"/>
<line x1="323" y1="262" x2="337" y2="248" stroke="#000" stroke-width="1.6"/>
<text x="330" y="282" font-size="16" font-style="italic">X</text>
<line x1="243" y1="323" x2="257" y2="337" stroke="#000" stroke-width="1.6"/>
<line x1="243" y1="337" x2="257" y2="323" stroke="#000" stroke-width="1.6"/>
<text x="250" y="357" font-size="16" font-style="italic">A</text>
</svg>"""

# úloha 11: skupinový sloupcový graf (zakoupené / vzrostlé / prodané) pro druhy A–D
def _bars11():
    groups = [('A', 14, 12, 7), ('B', 9, 9, 9), ('C', 8, 8, 4), ('D', 11, 8, 8)]
    x0 = 70; y0 = 300; k = 14; bw = 15; ingap = 3; grp_w = 3 * bw + 2 * ingap
    gstart = [100, 210, 320, 430]
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 360" font-family="sans-serif">']
    s.append('<defs>')
    s.append('<pattern id="d" width="6" height="6" patternUnits="userSpaceOnUse"><circle cx="3" cy="3" r="1.1" fill="#000"/></pattern>')
    s.append('<pattern id="h" width="6" height="6" patternUnits="userSpaceOnUse" patternTransform="rotate(45)"><line x1="0" y1="0" x2="0" y2="6" stroke="#000" stroke-width="1.3"/></pattern>')
    s.append('</defs>')
    s.append(f'<line x1="{x0}" y1="55" x2="{x0}" y2="{y0}" stroke="#000"/>')
    s.append(f'<line x1="{x0}" y1="{y0}" x2="515" y2="{y0}" stroke="#000"/>')
    for val in range(0, 17, 2):
        y = y0 - val * k
        s.append(f'<line x1="{x0-4}" y1="{y}" x2="{x0}" y2="{y}" stroke="#000"/><text x="{x0-8}" y="{y+4}" font-size="11" text-anchor="end">{val}</text>')
    s.append(f'<text x="24" y="175" font-size="12" text-anchor="middle" transform="rotate(-90 24 175)">pocet kusu rostlin</text>')
    fills = ['url(#d)', '#8a8a8a', 'url(#h)']
    for gi, (name, z, vz, pr) in enumerate(groups):
        gx = gstart[gi]
        for bi, val in enumerate((z, vz, pr)):
            bx = gx + bi * (bw + ingap); h = val * k
            s.append(f'<rect x="{bx}" y="{y0-h}" width="{bw}" height="{h}" fill="{fills[bi]}" stroke="#000"/>')
        s.append(f'<text x="{gx+grp_w/2}" y="{y0+18}" font-size="14" text-anchor="middle">{name}</text>')
    leg = [('url(#d)', 'zakoupené', 120), ('#8a8a8a', 'vzrostlé', 265), ('url(#h)', 'prodané', 400)]
    for fill, lab, lx in leg:
        s.append(f'<rect x="{lx}" y="336" width="14" height="12" fill="{fill}" stroke="#000"/><text x="{lx+18}" y="346" font-size="12">{lab}</text>')
    s.append('</svg>')
    return "".join(s)
SVG11 = _bars11()

# úloha 12: čtyři přímky (dvě rovnoběžné s ryskami, dvě na sebe kolmé), úhly 2α, 3α, β
def _fig12():
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 380" font-family="sans-serif">']
    lines = [((115, 261), (482, 127)), ((149, 89), (244, 352)), ((41, 209), (230, 62)), ((305, 231), (495, 83))]
    for (x1, y1), (x2, y2) in lines:
        s.append(f'<line x1="{x1}" y1="{y1}" x2="{x2}" y2="{y2}" stroke="#000" stroke-width="1.8"/>')
    def ticks(p1, p2):
        (x1, y1), (x2, y2) = p1, p2
        dx, dy = x2 - x1, y2 - y1; L = math.hypot(dx, dy); px, py = -dy / L, dx / L
        out = []
        for frac in (0.20, 0.26):
            cx = x1 + dx * frac; cy = y1 + dy * frac
            out.append(f'<line x1="{round(cx-6*px,1)}" y1="{round(cy-6*py,1)}" x2="{round(cx+6*px,1)}" y2="{round(cy+6*py,1)}" stroke="#000" stroke-width="1.6"/>')
        return out
    s += ticks((41, 209), (230, 62))
    s += ticks((305, 231), (495, 83))
    s.append('<polyline points="188,236 201,231 206,244" fill="none" stroke="#000" stroke-width="1.4"/>')
    s.append('<text x="166" y="86" font-size="16" font-style="italic">2α</text>')
    s.append('<text x="132" y="134" font-size="16" font-style="italic">3α</text>')
    s.append('<text x="414" y="150" font-size="16" font-style="italic">β</text>')
    s.append('</svg>')
    return "".join(s)
SVG12 = _fig12()

# úloha 13: kvádr 6×4×5 se dvěma svislými řezy (tři trojboké hranoly)
SVG13 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 300" font-family="sans-serif">
<polygon points="100,120 340,120 340,280 100,280" fill="#c9c9c9" stroke="#000" stroke-width="1.6"/>
<polygon points="100,120 170,75 410,75 340,120" fill="#dedede" stroke="#000" stroke-width="1.6"/>
<polygon points="340,120 410,75 410,235 340,280" fill="#bdbdbd" stroke="#000" stroke-width="1.6"/>
<line x1="100" y1="120" x2="290" y2="75" stroke="#000" stroke-width="1.2" stroke-dasharray="5 4"/>
<line x1="340" y1="120" x2="290" y2="75" stroke="#000" stroke-width="1.2" stroke-dasharray="5 4"/>
<text x="72" y="205" font-size="15" text-anchor="middle">5 cm</text>
<text x="220" y="300" font-size="15" text-anchor="middle">6 cm</text>
<text x="392" y="270" font-size="15">4 cm</text>
</svg>"""

# úloha 14: rotační válec ležící naležato (plášť tmavý, podstavy bílé)
SVG14 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 220" font-family="sans-serif">
<rect x="110" y="45" width="220" height="130" fill="#565656" stroke="none"/>
<ellipse cx="110" cy="110" rx="26" ry="65" fill="#565656" stroke="#000" stroke-width="1.6"/>
<line x1="110" y1="45" x2="330" y2="45" stroke="#000" stroke-width="1.6"/>
<line x1="110" y1="175" x2="330" y2="175" stroke="#000" stroke-width="1.6"/>
<ellipse cx="330" cy="110" rx="26" ry="65" fill="#ffffff" stroke="#000" stroke-width="1.6"/>
</svg>"""

# úloha 16: schematický výsledný obrazec (m=3): černé puntíky (m^2), vodorovné přímky (2m-1),
# bílé puntíky na spodní přímce (2m-2)
def _fig16():
    m = 3; X0 = 250; Yc = 108; sx = 55; sy = 40
    def X(u): return round(X0 + (u - 2) * sx, 1)
    def Y(v): return round(Yc + v * sy, 1)
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 210" font-family="sans-serif">']
    v1, v2 = -1.4, 1.4
    for i in range(1, m + 1):
        s.append(f'<line x1="{X(i+v1)}" y1="{Y(v1)}" x2="{X(i+v2)}" y2="{Y(v2)}" stroke="#000" stroke-width="1.3"/>')
    for j in range(1, m + 1):
        s.append(f'<line x1="{X(j-v1)}" y1="{Y(v1)}" x2="{X(j-v2)}" y2="{Y(v2)}" stroke="#000" stroke-width="1.3"/>')
    for kk in range(-2, 3):
        v = kk / 2.0
        s.append(f'<line x1="130" y1="{Y(v)}" x2="370" y2="{Y(v)}" stroke="#000" stroke-width="1.3"/>')
    for i in range(1, m + 1):
        for j in range(1, m + 1):
            u = (i + j) / 2.0; v = (j - i) / 2.0
            s.append(f'<circle cx="{X(u)}" cy="{Y(v)}" r="4.5" fill="#000"/>')
    for u in (0, 1, 3, 4):
        s.append(f'<circle cx="{X(u)}" cy="{Y(1)}" r="4.5" fill="#ffffff" stroke="#000" stroke-width="1.4"/>')
    s.append('</svg>')
    return "".join(s)
SVG16 = _fig16()

B = ['zs2', 'r9']

PROBLEMS = [
    {'name': 'CERMAT M9C 2022 – úloha 1',
     'zad': ['Vypočtěte: $\\dfrac{10^{2}\\cdot(10^{2}-1)}{10\\cdot 10^{2}+10^{2}}=$'],
     'opts': None, 'ln': 2,
     'sol': ['Čitatel $10^{2}\\cdot(10^{2}-1)=100\\cdot 99=9\\,900$, jmenovatel $10\\cdot 10^{2}+10^{2}=1\\,000+100=1\\,100$. Podíl $9\\,900:1\\,100=9$.'],
     'ans': '$9$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2022 – úloha 2.1',
     'zad': ['Z kabelu dlouhého $5{,}1$ metru jsme uřízli tři půlmetrové kusy a zbytek jsme rozdělili na 12 stejně dlouhých dílů.',
             'Určete, kolik centimetrů měří jeden díl.'],
     'opts': None, 'ln': 2,
     'sol': ['Kabel měří $510$ cm, tři půlmetrové kusy $3\\cdot 50=150$ cm. Zbytek $510-150=360$ cm rozdělíme na 12 dílů: $360:12=30$ cm.'],
     'ans': '$30$ cm', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9C 2022 – úloha 2.2',
     'zad': ['Vypočtěte, kolik minut jsou tři pětiny z 1 hodiny 50 minut.'],
     'opts': None, 'ln': 2,
     'sol': ['$1$ hodina $50$ minut $=110$ minut. Tři pětiny: $\\dfrac{3}{5}\\cdot 110=66$ minut.'],
     'ans': '$66$ minut', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9C 2022 – úloha 3.1',
     'zad': ['Vypočtěte a výsledek zapište zlomkem v základním tvaru.',
             '$\\dfrac{1}{3}\\cdot\\left(5-\\dfrac{13}{5}\\right):20=$'],
     'opts': None, 'ln': 3,
     'sol': ['$5-\\dfrac{13}{5}=\\dfrac{25-13}{5}=\\dfrac{12}{5}$. Dále $\\dfrac{1}{3}\\cdot\\dfrac{12}{5}=\\dfrac{12}{15}=\\dfrac{4}{5}$ a $\\dfrac{4}{5}:20=\\dfrac{4}{100}=\\dfrac{1}{25}$.'],
     'ans': '$\\dfrac{1}{25}$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2022 – úloha 3.2',
     'zad': ['Vypočtěte a výsledek zapište zlomkem v základním tvaru.',
             '$\\dfrac{\\frac{2}{3}-\\frac{3}{2}}{\\frac{2}{3}:\\frac{3}{2}}=$'],
     'opts': None, 'ln': 3,
     'sol': ['Čitatel: $\\dfrac{2}{3}-\\dfrac{3}{2}=\\dfrac{4-9}{6}=-\\dfrac{5}{6}$. Jmenovatel: $\\dfrac{2}{3}:\\dfrac{3}{2}=\\dfrac{2}{3}\\cdot\\dfrac{2}{3}=\\dfrac{4}{9}$. Podíl: $-\\dfrac{5}{6}:\\dfrac{4}{9}=-\\dfrac{5}{6}\\cdot\\dfrac{9}{4}=-\\dfrac{45}{24}=-\\dfrac{15}{8}$.'],
     'ans': '$-\\dfrac{15}{8}$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2022 – úloha 4.1',
     'zad': ['Upravte a rozložte na součin vytknutím:', '$(4+x)\\cdot x+2x^{2}=$'],
     'opts': None, 'ln': 2,
     'sol': ['$(4+x)\\cdot x+2x^{2}=4x+x^{2}+2x^{2}=3x^{2}+4x=x\\cdot(4+3x)$.'],
     'ans': '$x\\cdot(4+3x)$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2022 – úloha 4.2',
     'zad': ['Zjednodušte (výsledný výraz nesmí obsahovat závorky):', '$(y-3y)\\cdot(y+3y)=$'],
     'opts': None, 'ln': 2,
     'sol': ['$(y-3y)\\cdot(y+3y)=(-2y)\\cdot(4y)=-8y^{2}$.'],
     'ans': '$-8y^{2}$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2022 – úloha 4.3',
     'zad': ['Zjednodušte (výsledný výraz nesmí obsahovat závorky):', '$(-n-1)^{2}+(1+4n)\\cdot(1+4n)=$'],
     'opts': None, 'ln': 3,
     'sol': ['$(-n-1)^{2}=n^{2}+2n+1$, $(1+4n)^{2}=16n^{2}+8n+1$. Součet $=17n^{2}+10n+2$.'],
     'ans': '$17n^{2}+10n+2$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2022 – úloha 5.1',
     'zad': ['Řešte rovnici:', '$3\\cdot(2x-1)+\\dfrac{2}{3}=\\dfrac{2}{3}-(x+3)$'],
     'opts': None, 'ln': 3,
     'sol': ['$6x-3+\\dfrac{2}{3}=\\dfrac{2}{3}-x-3$. Po odečtení $\\dfrac{2}{3}$: $6x-3=-x-3$, tedy $6x=-x$, $7x=0$ a $x=0$.'],
     'ans': '$x=0$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2022 – úloha 5.2',
     'zad': ['Řešte rovnici:', '$\\dfrac{y+1}{6}-\\dfrac{3y}{2}=2+\\dfrac{0{,}5-y}{3}$'],
     'opts': None, 'ln': 3,
     'sol': ['Vynásobíme 6: $(y+1)-9y=12+2\\cdot(0{,}5-y)$, tj. $-8y+1=13-2y$. Odtud $-6y=12$ a $y=-2$.'],
     'ans': '$y=-2$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2022 – úloha 6',
     'zad': ['V hruškovém království získal každý princ tolik zlatých hrušek, kolik si zasloužil. První princ získal nejméně hrušek. Druhý princ získal o třetinu více hrušek než první princ a třetí princ o 12 hrušek více než první princ. Počet zlatých hrušek, které získal první princ, označíme $x$.',
             '6.1 Vyjádřete výrazem s proměnnou $x$, kolik hrušek získal druhý princ.',
             '6.2 Vyjádřete výrazem s proměnnou $x$, kolik hrušek získal třetí princ.',
             '6.3 První a třetí princ získali dohromady dvakrát více hrušek než druhý princ. Vypočtěte, kolik hrušek získal první princ.'],
     'opts': None, 'ln': 3,
     'sol': ['6.1 O třetinu více než $x$: $x+\\dfrac{1}{3}x=\\dfrac{4}{3}x$.',
             '6.2 O 12 více než $x$: $x+12$.',
             '6.3 Rovnice $x+(x+12)=2\\cdot\\dfrac{4}{3}x$, tj. $2x+12=\\dfrac{8}{3}x$. Odtud $12=\\dfrac{2}{3}x$ a $x=18$.'],
     'ans': '6.1: $\\dfrac{4}{3}x$; 6.2: $x+12$; 6.3: $18$ hrušek', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['rovnice', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9C 2022 – úloha 7',
     'zad': ['Pro soutěž Malování na chodník bylo připraveno celkem 300 kříd zabalených v krabičkách dvou velikostí – menších a větších. V krabičkách téže velikosti byl vždy stejný počet kříd. Menších krabiček bylo pouze 5 a celkem v nich bylo tolik kříd jako ve 3 větších krabičkách. Každá z větších krabiček obsahovala 10 kříd.',
             '7.1 Určete počet kříd v jedné menší krabičce.',
             '7.2 Určete počet všech větších krabiček s křídami.'],
     'opts': None, 'ln': 2,
     'sol': ['7.1 Ve 3 větších krabičkách je $3\\cdot 10=30$ kříd, tolik je i v 5 menších krabičkách. Jedna menší krabička: $30:5=6$ kříd.',
             '7.2 V menších krabičkách je $5\\cdot 6=30$ kříd, ve větších tedy $300-30=270$ kříd. Počet větších krabiček: $270:10=27$.'],
     'ans': '7.1: $6$ kříd; 7.2: $27$ větších krabiček', 'pts': 3, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9C 2022 – úloha 8',
     'zad': ['Poličku na zeď tvoří tmavá obdélníková deska podepřená dvěma stejnými bílými trojúhelníkovými deskami. Tloušťku desek zanedbáváme.',
             '8.1 Tmavý obdélník má obsah $270$ cm² a jeho kratší strana měří $9$ cm. Vypočtěte v cm obvod obdélníku.',
             '8.2 Oba bílé trojúhelníky jsou pravoúhlé. V trojúhelníku má jedna odvěsna délku $9$ cm a nejdelší strana měří $15$ cm. Vypočtěte v cm² obsah jednoho trojúhelníku.'],
     'opts': None, 'ln': 3, 'svg': SVG8, 'fn': 'policka.svg',
     'alt': 'Polička – tmavá obdélníková deska podepřená dvěma bílými pravoúhlými trojúhelníkovými deskami.',
     'cap': 'Schematický nákres poličky (rozměry dle zadání)',
     'sol': ['8.1 Delší strana obdélníku: $270:9=30$ cm. Obvod $=2\\cdot(9+30)=78$ cm.',
             '8.2 Druhá odvěsna: $\\sqrt{15^{2}-9^{2}}=\\sqrt{225-81}=\\sqrt{144}=12$ cm. Obsah $=\\dfrac{9\\cdot 12}{2}=54$ cm².'],
     'ans': '8.1: $78$ cm; 8.2: $54$ cm²', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9C 2022 – úloha 9',
     'zad': ['V rovině leží body $P$, $Q$ a přímka $o$ (viz obrázek).',
             'Body $P$, $Q$ jsou vrcholy trojúhelníku $PQR$. Přímka $o$ je osou některé strany tohoto trojúhelníku.',
             'Sestrojte vrchol $R$ trojúhelníku $PQR$, označte ho písmenem a trojúhelník narýsujte. Najděte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG9, 'fn': 'body-pq-o.svg',
     'alt': 'Body P a Q a přímka o vedená šikmo v rovině.',
     'cap': 'Výchozí obrázek k úloze 9',
     'sol': ['Přímka $o$ může být osou strany $PR$, nebo osou strany $QR$. Je-li $o$ osou strany $PR$, je vrchol $R_{1}$ obrazem bodu $P$ v osové souměrnosti podle přímky $o$. Je-li $o$ osou strany $QR$, je vrchol $R_{2}$ obrazem bodu $Q$ v osové souměrnosti podle přímky $o$. Úloha má dvě řešení.'],
     'ans': 'Dvě řešení: $R_{1}$ je obraz bodu $P$ a $R_{2}$ obraz bodu $Q$ v osové souměrnosti podle přímky $o$ (viz obrázek v klíči).',
     'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['planimetrie', 'konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2022 – úloha 10',
     'zad': ['V rovině leží body $A$, $X$ a rovnoběžné přímky $c$, $p$ (viz obrázek).',
             'Bod $A$ je vrchol obdélníku $ABCD$. Bod $X$ leží uvnitř strany $AB$ obdélníku. Na přímce $c$ leží vrchol $C$ obdélníku $ABCD$ a na přímce $p$ jeden ze zbývajících dvou vrcholů obdélníku.',
             'Sestrojte vrcholy $B$, $C$, $D$ obdélníku $ABCD$, označte je písmeny a obdélník narýsujte. Najděte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG10, 'fn': 'body-ax-cp.svg',
     'alt': 'Body A a X a dvě rovnoběžné vodorovné přímky c a p v rovině.',
     'cap': 'Výchozí obrázek k úloze 10',
     'sol': ['Strana $AB$ leží na přímce $AX$, ostatní strany obdélníku jsou k ní kolmé, resp. rovnoběžné. Vrchol $C$ leží na přímce $c$ a jeden z vrcholů $B$, $D$ na přímce $p$. Vyhovují dva obdélníky – s vrcholy $B_{1}C_{1}D_{1}$ a $B_{2}C_{2}D_{2}$. Úloha má dvě řešení.'],
     'ans': 'Dvě řešení – obdélníky $AB_{1}C_{1}D_{1}$ a $AB_{2}C_{2}D_{2}$ (strana $AB$ na přímce $AX$, vrchol $C$ na přímce $c$, jeden z vrcholů $B$, $D$ na přímce $p$) – viz obrázek v klíči.',
     'pts': 3, 'mins': 7, 'diff': '4',
     'codes': B + ['planimetrie', 'konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2022 – úloha 11',
     'zad': ['Zahrádkář zakoupil několik kusů rostlin od každého ze čtyř druhů A, B, C a D. Některé zakoupené rostliny uschly, ostatní vzrostly. Většinu vzrostlých rostlin zahrádkář později prodal. Graf udává počty zakoupených, vzrostlých a prodaných kusů rostlin jednotlivých druhů.',
             'Rozhodněte o každém z následujících tvrzení (11.1–11.3), zda je pravdivé (A), či nikoli (N).',
             '11.1 Zahrádkáři zůstalo celkem 9 neprodaných kusů vzrostlých rostlin.',
             '11.2 Zahrádkář zakoupil o polovinu více kusů rostlin, než jich prodal.',
             '11.3 Zahrádkář prodal všechny zakoupené kusy jen u jednoho druhu rostlin.'],
     'opts': None, 'ln': 0, 'svg': SVG11, 'fn': 'graf-rostliny.svg',
     'alt': 'Skupinový sloupcový graf – zakoupené, vzrostlé a prodané kusy rostlin druhů A, B, C, D.',
     'cap': 'Počty zakoupených, vzrostlých a prodaných kusů rostlin',
     'sol': ['Z grafu: A – zakoupené 14, vzrostlé 12, prodané 7; B – 9, 9, 9; C – 8, 8, 4; D – 11, 8, 8.',
             '11.1 Neprodané vzrostlé $(12-7)+(9-9)+(8-4)+(8-8)=5+0+4+0=9$. Pravdivé (A).',
             '11.2 Zakoupeno $14+9+8+11=42$, prodáno $7+9+4+8=28$; $42=1{,}5\\cdot 28$, tedy o polovinu více. Pravdivé (A).',
             '11.3 Prodané se rovnají zakoupeným jen u druhu B ($9=9$). Pravdivé (A).'],
     'ans': '11.1: Ano; 11.2: Ano; 11.3: Ano', 'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['statistika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9C 2022 – úloha 12',
     'zad': ['V rovině leží čtyři přímky, z nichž dvě jsou rovnoběžné a zbývající dvě jsou na sebe kolmé (viz obrázek).',
             'Jaká je velikost úhlu $\\beta$? Velikosti úhlů neměřte, ale vypočtěte.'],
     'opts': ['A) menší než $20^\\circ$', 'B) $20^\\circ$', 'C) $28^\\circ$', 'D) $34^\\circ$', 'E) větší než $34^\\circ$'],
     'ln': 0, 'svg': SVG12, 'fn': 'ctyri-primky.svg',
     'alt': 'Čtyři přímky – dvě rovnoběžné (s ryskami) a dvě na sebe kolmé; vyznačeny úhly 2α, 3α a β.',
     'cap': 'Schematický nákres k úloze 12',
     'sol': ['Úhly $2\\alpha$ a $3\\alpha$ jsou vedlejší, tedy $2\\alpha+3\\alpha=180^\\circ$, odtud $\\alpha=36^\\circ$ a $2\\alpha=72^\\circ$. Rovnoběžka svírá s jednou z kolmých přímek úhel $72^\\circ$, a proto s druhou (na ni kolmou) přímkou úhel $90^\\circ-72^\\circ=18^\\circ$. Vzhledem k rovnoběžnosti je $\\beta=18^\\circ$, tj. menší než $20^\\circ$.'],
     'ans': 'A) menší než $20^\\circ$', 'pts': 2, 'mins': 5, 'diff': '4',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2022 – úloha 13',
     'zad': ['Kvádr o rozměrech $6$ cm, $4$ cm a $5$ cm jsme dvěma svislými řezy rozdělili na tři kolmé trojboké hranoly. Z těchto trojbokých hranolů vybereme ten, který má největší objem (viz obrázek).',
             'Jaký je objem vybraného trojbokého hranolu?'],
     'opts': ['A) $40$ cm³', 'B) $60$ cm³', 'C) $80$ cm³', 'D) $120$ cm³', 'E) jiný objem'],
     'ln': 0, 'svg': SVG13, 'fn': 'kvadr-hranoly.svg',
     'alt': 'Kvádr 6×4×5 cm rozdělený dvěma svislými řezy na tři trojboké hranoly.',
     'cap': 'Kvádr rozdělený na tři trojboké hranoly',
     'sol': ['Podstavou každého hranolu je trojúhelník v obdélníku $6\\times 4$ cm (obsah $24$ cm²), výška hranolů je $5$ cm. Největší podstavu má trojúhelník o obsahu poloviny obdélníku, tj. $12$ cm². Objem $=12\\cdot 5=60$ cm³.'],
     'ans': 'B) $60$ cm³', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['stereometrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2022 – úloha 14',
     'zad': ['Penál má tvar rotačního válce. Poloměr podstavy válce je $5$ cm a výška válce $20$ cm. Obě podstavy válce jsou bílé a plášť válce je tmavý (viz obrázek).',
             'Kolikrát větší je obsah pláště válce než obsah jedné podstavy?'],
     'opts': ['A) 4krát', 'B) 6krát', 'C) 8krát', 'D) 10krát', 'E) 20krát'],
     'ln': 0, 'svg': SVG14, 'fn': 'valec-penal.svg',
     'alt': 'Ležící rotační válec s tmavým pláštěm a bílou podstavou (penál).',
     'cap': 'Válec – penál (plášť tmavý, podstavy bílé)',
     'sol': ['Obsah pláště $S_{pl}=2\\pi r v=2\\pi\\cdot 5\\cdot 20=200\\pi$ cm². Obsah jedné podstavy $S_{p}=\\pi r^{2}=25\\pi$ cm². Poměr $200\\pi:25\\pi=8$.'],
     'ans': 'C) 8krát', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['stereometrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2022 – úloha 15',
     'zad': ['Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).',
             '15.1 Když firma odvezla do spalovny $60\\,\\%$ odpadu, zbylo jí ještě $1\\,200$ kg odpadu. Kolik kg odpadu firma odvezla do spalovny?',
             '15.2 Stejné dlaždice byly umístěny ve stejném počtu na dvou paletách. Již se prodaly dvě pětiny dlaždic z první palety a $10\\,\\%$ dlaždic z druhé palety. Hmotnost všech těchto prodaných dlaždic byla $750$ kg. Kolik kg váží dosud neprodané dlaždice z obou palet?',
             '15.3 Ve sběrných surovinách vykoupili v létě $1\\,500$ kg kovů, což je o $50\\,\\%$ více než na jaře a o $50\\,\\%$ méně než na podzim. O kolik kg kovů vykoupili na podzim více než na jaře?'],
     'opts': ['A) $1\\,500$ kg', 'B) $1\\,800$ kg', 'C) $2\\,000$ kg', 'D) $2\\,100$ kg', 'E) $2\\,250$ kg', 'F) jiný počet kg'],
     'ln': 0,
     'sol': ['15.1 Zbylých $1\\,200$ kg je $40\\,\\%$ odpadu, celý odpad $\\dfrac{1\\,200}{0{,}4}=3\\,000$ kg; odvezeno $60\\,\\%$, tj. $1\\,800$ kg → B.',
             '15.2 Prodáno $\\dfrac{2}{5}+\\dfrac{1}{10}=\\dfrac{1}{2}$ obsahu jedné palety $=750$ kg, jedna paleta váží $1\\,500$ kg, obě $3\\,000$ kg. Neprodané $3\\,000-750=2\\,250$ kg → E.',
             '15.3 Jaro $\\dfrac{1\\,500}{1{,}5}=1\\,000$ kg, podzim $\\dfrac{1\\,500}{0{,}5}=3\\,000$ kg. Rozdíl $3\\,000-1\\,000=2\\,000$ kg → C.'],
     'ans': '15.1: B ($1\\,800$ kg); 15.2: E ($2\\,250$ kg); 15.3: C ($2\\,000$ kg)', 'pts': 6, 'mins': 9, 'diff': '4',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9C 2022 – úloha 16',
     'zad': ['Výsledný obrazec vytvoříme takto: na vodorovné přímce sestrojíme několik stejně vzdálených bodů (černých puntíků); prvním černým puntíkem vedeme dvě různoběžné šikmé přímky a druhým a každým dalším černým puntíkem vedeme rovnoběžky s oběma těmito přímkami; všechny nově vzniklé průsečíky označíme černými puntíky a těmi vedeme vodorovné přímky; na spodní vodorovné přímce označíme všechny nově vzniklé průsečíky bílými puntíky (viz obrázek).',
             '16.1 Výsledný obrazec obsahuje celkem 36 černých puntíků. Určete počet všech vodorovných přímek v tomto obrazci.',
             '16.2 Výsledný obrazec obsahuje celkem 49 vodorovných přímek. Určete počet bílých puntíků na spodní vodorovné přímce tohoto obrazce.',
             '16.3 Výsledný obrazec má na spodní vodorovné přímce celkem 64 bílých puntíků. Určete počet všech černých puntíků v tomto obrazci.'],
     'opts': None, 'ln': 3, 'svg': SVG16, 'fn': 'obrazec-puntiky.svg',
     'alt': 'Schematický výsledný obrazec: síť šikmých a vodorovných přímek s černými puntíky v průsečících a bílými puntíky na spodní přímce.',
     'cap': 'Schematický výsledný obrazec (příklad pro 3 výchozí body)',
     'sol': ['Označme $m$ počet výchozích černých puntíků na horní přímce. Šikmé přímky tvoří dvě rodiny po $m$ přímkách, jejich průsečíky dávají celkem $m^{2}$ černých puntíků; vodorovných přímek je $2m-1$ a bílých puntíků na spodní přímce je $2m-2$.',
             '16.1 $m^{2}=36\\Rightarrow m=6$; vodorovných přímek $2\\cdot 6-1=11$.',
             '16.2 $2m-1=49\\Rightarrow m=25$; bílých puntíků $2\\cdot 25-2=48$.',
             '16.3 $2m-2=64\\Rightarrow m=33$; černých puntíků $33^{2}=1\\,089$.'],
     'ans': '16.1: $11$ vodorovných přímek; 16.2: $48$ bílých puntíků; 16.3: $1\\,089$ černých puntíků', 'pts': 4, 'mins': 8, 'diff': '4',
     'codes': B + ['posloupnosti', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M9PCD22C0T03'
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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M9C-2022')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
