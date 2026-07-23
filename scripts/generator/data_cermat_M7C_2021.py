# -*- coding: utf-8 -*-
# CERMAT – Jednotná přijímací zkouška 2021, MATEMATIKA 7 (šestileté obory), 1. náhradní termín (varianta C).
# Kód testu: M7PCD21C0T03. 16 úloh (po rozdělení izolovaných podúloh 19 úloh).
# Zdroj odpovědí: klíč správných řešení (KSR). Vyplněný záznamový arch (VZA) je prázdný formulář (bez značek).

import math

# ---- SVG obrázky (bez apostrofů a zpětných lomítek) ----

# úloha 6: schéma dvou tras S–K–C (snadná plná, náročná čárkovaná)
SVG6 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 240" font-family="sans-serif">
<text x="150" y="40" font-size="14">Snadná trasa</text>
<path d="M60 120 C 120 60 220 60 260 120" fill="none" stroke="#000" stroke-width="2"/>
<path d="M260 120 C 320 60 420 60 460 120" fill="none" stroke="#000" stroke-width="2"/>
<path d="M60 120 C 120 180 220 180 260 120" fill="none" stroke="#000" stroke-width="2" stroke-dasharray="5 5"/>
<path d="M260 120 C 320 180 420 180 460 120" fill="none" stroke="#000" stroke-width="2" stroke-dasharray="5 5"/>
<text x="150" y="212" font-size="14">Náročná trasa</text>
<circle cx="60" cy="120" r="3" fill="#000"/><text x="50" y="140" font-size="15" font-style="italic">S</text>
<circle cx="260" cy="120" r="3" fill="#000"/><text x="253" y="140" font-size="15" font-style="italic">K</text>
<circle cx="460" cy="120" r="3" fill="#000"/><text x="455" y="140" font-size="15" font-style="italic">C</text>
</svg>"""

# úloha 7: sestavený čtverec z dlaždic 18x8, odebrány 4 rohové dlaždice (32 dlaždic)
def _tiles():
    ox, oy = 25, 18; cw, ch = 34, 15; cols, rows = 4, 9
    W = ox * 2 + cols * cw; H = oy * 2 + rows * ch
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {W} {H}" font-family="sans-serif">']
    for r in range(rows):
        for c in range(cols):
            if (r == 0 or r == rows - 1) and (c == 0 or c == cols - 1):
                continue
            x = ox + c * cw; y = oy + r * ch
            s.append(f'<rect x="{x}" y="{y}" width="{cw}" height="{ch}" fill="#dfe6df" stroke="#333" stroke-width="1"/>')
    s.append(f'<text x="{ox + cols * cw / 2:.0f}" y="{H - 5}" font-size="12" text-anchor="middle">strana 72 cm</text>')
    s.append('</svg>')
    return "".join(s)
SVG7 = _tiles()

# úloha 8: výchozí obrázek – bod A na přímce c, bod M
SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 280" font-family="sans-serif">
<line x1="40" y1="120" x2="420" y2="205" stroke="#000" stroke-width="2"/>
<text x="425" y="210" font-size="15" font-style="italic">c</text>
<line x1="70" y1="120" x2="72" y2="134" stroke="#000" stroke-width="2"/>
<circle cx="71" cy="127" r="2.5" fill="#000"/><text x="60" y="150" font-size="15" font-style="italic">A</text>
<text x="332" y="92" font-size="15" font-style="italic">M</text><text x="328" y="108" font-size="14">x</text>
</svg>"""

# úloha 9: výchozí obrázek – body A, B, L
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 250" font-family="sans-serif">
<text x="185" y="150" font-size="14">x</text><text x="182" y="168" font-size="15" font-style="italic">L</text>
<text x="392" y="150" font-size="14">x</text><text x="389" y="168" font-size="15" font-style="italic">B</text>
<text x="150" y="205" font-size="14">x</text><text x="147" y="223" font-size="15" font-style="italic">A</text>
</svg>"""

# úloha 10: schéma obrazce A (dům se šipkou a komínem) a obrazce B (hradba s cimbuřím)
SVG10 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 250" font-family="sans-serif">
<text x="150" y="28" font-size="14" text-anchor="middle">Obrazec A</text>
<polygon points="55,110 150,45 245,110" fill="none" stroke="#000" stroke-width="2"/>
<polygon points="80,110 220,110 220,150 175,150 175,225 125,225 125,150 80,150" fill="none" stroke="#000" stroke-width="2"/>
<rect x="196" y="52" width="16" height="18" fill="none" stroke="#000" stroke-width="1.5"/>
<rect x="196" y="70" width="16" height="18" fill="none" stroke="#000" stroke-width="1.5"/>
<text x="400" y="28" font-size="14" text-anchor="middle">Obrazec B</text>
<polygon points="300,225 322,185 322,150 340,150 340,130 358,130 358,150 376,150 376,130 394,130 394,150 470,150 470,225" fill="none" stroke="#000" stroke-width="2"/>
</svg>"""

# úloha 11: čtyři přímky (dvě rovnoběžné) s úhly alfa, 2alfa a 36 stupňů
SVG11 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 430 300" font-family="sans-serif">
<line x1="50" y1="135" x2="385" y2="90" stroke="#000" stroke-width="2"/>
<line x1="50" y1="248" x2="385" y2="203" stroke="#000" stroke-width="2"/>
<line x1="352" y1="98" x2="360" y2="106" stroke="#000" stroke-width="1.5"/>
<line x1="360" y1="96" x2="368" y2="104" stroke="#000" stroke-width="1.5"/>
<line x1="352" y1="211" x2="360" y2="219" stroke="#000" stroke-width="1.5"/>
<line x1="360" y1="209" x2="368" y2="217" stroke="#000" stroke-width="1.5"/>
<line x1="95" y1="60" x2="335" y2="258" stroke="#000" stroke-width="2"/>
<line x1="335" y1="72" x2="150" y2="292" stroke="#000" stroke-width="2"/>
<text x="150" y="118" font-size="16" font-style="italic">α</text>
<text x="228" y="172" font-size="16" font-style="italic">2α</text>
<text x="188" y="238" font-size="15">36°</text>
</svg>"""

# úlohy 12–13: vodorovný sloupcový graf cen bylin A=8, B=10, C=11 (dílků)
def _herbs():
    ox, oy = 70, 42; unit = 32; bh, gap = 38, 26
    rows = [('A', 8), ('B', 10), ('C', 11)]
    baseY = oy + 3 * (bh + gap)
    W = ox + 12 * unit + 40; H = baseY + 30
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {W} {H}" font-family="sans-serif">']
    s.append(f'<text x="{ox + 6 * unit}" y="24" font-size="14" text-anchor="middle">Ceny bylin za 1 kg</text>')
    for v in range(0, 13):
        x = ox + v * unit
        col = '#999' if v % 2 == 0 else '#ddd'
        s.append(f'<line x1="{x}" y1="{oy - 6}" x2="{x}" y2="{baseY}" stroke="{col}" stroke-width="1"/>')
        if v % 2 == 0:
            s.append(f'<text x="{x}" y="{baseY + 16}" font-size="11" text-anchor="middle">{v}</text>')
    y = oy
    for name, val in rows:
        s.append(f'<rect x="{ox}" y="{y}" width="{val * unit}" height="{bh}" fill="#5a5a5a" stroke="#000"/>')
        s.append(f'<text x="{ox - 12}" y="{y + bh / 2 + 5:.0f}" font-size="13" text-anchor="end">{name}</text>')
        y += bh + gap
    s.append(f'<line x1="{ox}" y1="{oy - 6}" x2="{ox}" y2="{baseY}" stroke="#000" stroke-width="1.5"/>')
    s.append(f'<line x1="{ox}" y1="{baseY}" x2="{ox + 12 * unit}" y2="{baseY}" stroke="#000" stroke-width="1.5"/>')
    cy = oy + 1.5 * (bh + gap)
    s.append(f'<text x="22" y="{cy:.0f}" font-size="12" text-anchor="middle" transform="rotate(-90 22 {cy:.0f})">Druh bylin</text>')
    s.append('</svg>')
    return "".join(s)
SVG12 = _herbs()

# úloha 14: podstava hranolu – čtverec 8x8 s oddělenými 4 trojúhelníky (odvěsny 3 a 4)
def _hexbase():
    sc = 16; ox, oy = 30, 22
    def px(cx): return ox + cx * sc
    def py(cy): return oy + cy * sc
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {ox * 2 + 8 * sc} {oy * 2 + 8 * sc + 20}" font-family="sans-serif">']
    s.append(f'<rect x="{px(0)}" y="{py(0)}" width="{8 * sc}" height="{8 * sc}" fill="#e8e8e8" stroke="#bbb" stroke-width="1"/>')
    pts = [(3, 0), (5, 0), (8, 4), (5, 8), (3, 8), (0, 4)]
    poly = " ".join(f"{px(a):.0f},{py(b):.0f}" for a, b in pts)
    s.append(f'<polygon points="{poly}" fill="#ffffff" stroke="#000" stroke-width="2"/>')
    s.append(f'<text x="{px(3.7):.0f}" y="{py(0)-4:.0f}" font-size="12">3 cm</text>')
    s.append(f'<text x="{px(0)-2:.0f}" y="{py(2.2):.0f}" font-size="12" text-anchor="end">4 cm</text>')
    s.append(f'<text x="{px(4):.0f}" y="{py(8)+16:.0f}" font-size="12" text-anchor="middle">8 cm</text>')
    s.append('</svg>')
    return "".join(s)
SVG14 = _hexbase()

# úloha 16: trojúhelníkový obrazec (7 řad) – tmavé šestiúhelníky a bílé trojúhelníky (schéma)
def _pat():
    R = 7; sd = 26; h = sd * math.sqrt(3) / 2
    ox, oy = 55, 18
    Ax = ox + R * sd / 2
    def gx(k, i): return round(ox + k * sd / 2 + i * sd)
    def gy(k): return round(oy + k * h)
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {round(ox * 2 + R * sd)} {round(oy * 2 + R * h)}" font-family="sans-serif">']
    # trojúhelníková mřížka jako jediná cesta (světlá)
    d = []
    for k in range(R):
        for i in range(R - k):
            d.append(f"M{gx(k,i)} {gy(k)}L{gx(k,i+1)} {gy(k)}")
            d.append(f"M{gx(k,i)} {gy(k)}L{gx(k+1,i)} {gy(k+1)}")
            d.append(f"M{gx(k,i+1)} {gy(k)}L{gx(k+1,i)} {gy(k+1)}")
    s.append(f'<path d="{"".join(d)}" fill="none" stroke="#bbb" stroke-width="1"/>')
    # tmavé šestiúhelníky: pás j (mezi řadami 2j a 2j+1) má j šestiúhelníků
    m = (R - 1) // 2
    ang = [0, 60, 120, 180, 240, 300]
    for j in range(1, m + 1):
        k = R - 2 * j
        for i in range(1, 2 * j, 2):
            cx = gx(k, i); cy = gy(k)
            hp = " ".join(f"{round(cx + sd * math.cos(math.radians(a)))},{round(cy + sd * math.sin(math.radians(a)))}" for a in ang)
            s.append(f'<polygon points="{hp}" fill="#8f8f8f" stroke="#000" stroke-width="1.2"/>')
    # obrys velkého trojúhelníku
    s.append(f'<polygon points="{gx(0,0)},{gy(0)} {gx(0,R)},{gy(0)} {round(Ax)},{gy(R)}" fill="none" stroke="#000" stroke-width="2"/>')
    # čísla řad 1..R (zdola)
    for r in range(1, R + 1):
        k = R - r
        s.append(f'<text x="{gx(k,0)-14}" y="{round(gy(k)+h*0.7)}" font-size="12">{r}.</text>')
    s.append('</svg>')
    return "".join(s)
SVG16 = _pat()

B = ['zs2', 'r7']  # 7. ročník, šestileté obory (přijímačky)

PROBLEMS = [
    {'name': 'CERMAT M7C 2021 – úloha 1',
     'zad': ['Zapište zlomkem v základním tvaru, jakou část litru tvoří $30\\,\\%$ ze čtvrtlitru.'],
     'opts': None, 'ln': 2,
     'sol': ['$30\\,\\%$ ze čtvrtlitru je $\\frac{30}{100}\\cdot\\frac{1}{4}=\\frac{3}{10}\\cdot\\frac{1}{4}=\\frac{3}{40}$ litru.'],
     'ans': '$\\frac{3}{40}$ litru', 'pts': 1, 'mins': 2, 'diff': '3',
     'codes': B + ['procenta', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7C 2021 – úloha 2.1',
     'zad': ['Doplňte do rámečku takové číslo, aby platila rovnost: $6{,}5-1{,}5:5=$ □'],
     'opts': None, 'ln': 2,
     'sol': ['$6{,}5-1{,}5:5=6{,}5-0{,}3=6{,}2$.'],
     'ans': '$6{,}2$', 'pts': 1, 'mins': 1, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7C 2021 – úloha 2.2',
     'zad': ['Doplňte do rámečku takové číslo, aby platila rovnost: □ $\\cdot 2 = 30 + 24\\cdot 0{,}4$.'],
     'opts': None, 'ln': 2,
     'sol': ['Pravá strana: $30+24\\cdot 0{,}4=30+9{,}6=39{,}6$. Hledané číslo je $39{,}6:2=19{,}8$.'],
     'ans': '$19{,}8$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7C 2021 – úloha 3.1',
     'zad': ['Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\left(\\frac{3}{4}+\\frac{13}{6}\\right)\\cdot\\left(\\frac{2}{5}-1\\right)=$'],
     'opts': None, 'ln': 2,
     'sol': ['$\\frac{3}{4}+\\frac{13}{6}=\\frac{9}{12}+\\frac{26}{12}=\\frac{35}{12}$; $\\frac{2}{5}-1=-\\frac{3}{5}$. Součin $\\frac{35}{12}\\cdot\\left(-\\frac{3}{5}\\right)=-\\frac{105}{60}=-\\frac{7}{4}$.'],
     'ans': '$-\\frac{7}{4}$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7C 2021 – úloha 3.2',
     'zad': ['Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\frac{\\frac{3}{5}\\cdot 2-4\\cdot\\frac{2}{7}}{2}=$'],
     'opts': None, 'ln': 2,
     'sol': ['$\\frac{3}{5}\\cdot 2=\\frac{6}{5}$; $4\\cdot\\frac{2}{7}=\\frac{8}{7}$; $\\frac{6}{5}-\\frac{8}{7}=\\frac{42-40}{35}=\\frac{2}{35}$. Po dělení dvěma: $\\frac{2}{35}:2=\\frac{1}{35}$.'],
     'ans': '$\\frac{1}{35}$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7C 2021 – úloha 4.1',
     'zad': ['Myslím si celé číslo, které je větší než $20$ a menší než $25$. Když k němu přičtu trojnásobek jiného celého čísla, dostanu $90$.',
             'Určete, které číslo si mohu myslet. Uveďte všechna řešení.'],
     'opts': None, 'ln': 2,
     'sol': ['Hledané číslo $n$ splňuje $20<n<25$, tedy $n\\in\\{21,22,23,24\\}$. Z rovnice $n+3k=90$ plyne, že $90-n$ musí být dělitelné třemi; protože $90$ je dělitelné třemi, musí být dělitelné třemi i $n$. Vyhovují čísla $21$ a $24$.'],
     'ans': '$21$; $24$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7C 2021 – úloha 4.2',
     'zad': ['Do prázdné mísy jsme dali máslo o hmotnosti $120$ g a přidali mouku a cukr. Suroviny v míse váží dohromady půl kilogramu. Cukru je v míse o $80$ g méně než mouky.',
             'Vypočtěte, kolik gramů mouky je v míse.'],
     'opts': None, 'ln': 2,
     'sol': ['Mouka a cukr váží $500-120=380$ g. Označíme hmotnost mouky $m$, pak cukru je $m-80$. Platí $m+(m-80)=380$, tedy $2m=460$ a $m=230$ g.'],
     'ans': '$230$ g', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7C 2021 – úloha 5',
     'zad': ['Dvě rekreační plavkyně Jana s Květou byly společně plavat. Každá uplavala $25$ bazénů. Obě začaly plavat současně a každá plavala svým stále stejným tempem. Jana uplavala $5$ bazénů za $7$ minut. Květa uplavala $10$ bazénů za čtvrt hodiny.',
             '5.1 Vypočtěte, o kolik sekund se lišily časy obou plavkyň na první obrátce (tj. po uplavání prvního bazénu).',
             '5.2 Určete, za jak dlouho uplavala $25$ bazénů pomalejší plavkyně. (Čas uveďte v minutách a sekundách, např. $5$ min $12$ s.)'],
     'opts': None, 'ln': 3,
     'sol': ['Jana uplave $1$ bazén za $\\frac{7}{5}$ min $=84$ s. Květa uplave $1$ bazén za $\\frac{15}{10}=1{,}5$ min $=90$ s.',
             '5.1 Rozdíl na první obrátce je $90-84=6$ s.',
             '5.2 Pomalejší je Květa ($90$ s na bazén); $25$ bazénů uplave za $25\\cdot 90=2250$ s $=37$ min $30$ s.'],
     'ans': '5.1: o $6$ sekund; 5.2: $37$ min $30$ s', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7C 2021 – úloha 6',
     'zad': ['Od startu $S$ do cíle $C$ vede jedna snadná cyklistická trasa údolími a druhá náročná přes kopce. Obě trasy se kříží v místě $K$.',
             'Po snadné trase ujedeme v první části od startu $S$ do místa $K$ $45$ km, což je o polovinu více, než ujedeme v druhé části od místa $K$ do cíle $C$.',
             'Náročná trasa je dlouhá $45$ km a její první část od startu $S$ do místa $K$ je o pětinu kratší než její druhá část od místa $K$ do cíle $C$.',
             'Vypočtěte, kolik km měří druhá část (od místa $K$ do cíle $C$)',
             '6.1 snadné trasy,',
             '6.2 náročné trasy.'],
     'opts': None, 'ln': 3, 'svg': SVG6, 'fn': 'trasy-skc.svg',
     'alt': 'Schéma snadné (plná čára) a náročné (čárkovaná) trasy mezi body S, K a C.',
     'cap': 'Snadná a náročná trasa se křižují v místě K',
     'sol': ['6.1 První část snadné trasy ($45$ km) je o polovinu delší než druhá část, tedy je jejím $1{,}5$násobkem: druhá část $=45:1{,}5=30$ km.',
             '6.2 Druhou část náročné trasy označíme $x$; první část je o pětinu kratší, tedy $\\frac{4}{5}x$. Celkem $\\frac{4}{5}x+x=\\frac{9}{5}x=45$, odtud $x=25$ km.'],
     'ans': '6.1: $30$ km; 6.2: $25$ km', 'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7C 2021 – úloha 7',
     'zad': ['Z celých dlaždic tvaru obdélníku o rozměrech $18$ cm a $8$ cm je sestaven nejmenší možný čtverec. Z každého ze čtyř rohů tohoto čtverce odebereme po jedné dlaždici a dostaneme nový útvar. (Jedna strana čtverce je rovnoběžná s delšími stranami všech dlaždic.)',
             'Vypočtěte',
             '7.1 v cm délku strany sestaveného čtverce,',
             '7.2 počet dlaždic v novém útvaru.'],
     'opts': None, 'ln': 3, 'svg': SVG7, 'fn': 'dlazdice-ctverec.svg',
     'alt': 'Čtverec sestavený z dlaždic (4 sloupce, 9 řad) se čtyřmi odebranými rohovými dlaždicemi.',
     'cap': 'Nový útvar po odebrání čtyř rohových dlaždic',
     'sol': ['7.1 Strana čtverce musí být násobkem $18$ i $8$. Nejmenší společný násobek čísel $18$ a $8$ je $72$, strana čtverce je tedy $72$ cm.',
             '7.2 Čtverec obsahuje $\\frac{72}{18}\\cdot\\frac{72}{8}=4\\cdot 9=36$ dlaždic. Po odebrání $4$ rohových dlaždic zbývá $36-4=32$ dlaždic.'],
     'ans': '7.1: $72$ cm; 7.2: $32$ dlaždic', 'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7C 2021 – úloha 8 (konstrukce)',
     'zad': ['V rovině leží body $A$, $M$. Bodem $A$ prochází přímka $c$ (viz obrázek).',
             'Bod $A$ je vrchol obdélníku $ABCD$. Vrchol $C$ tohoto obdélníku leží na přímce $c$ a jeho vzdálenost od bodu $M$ je polovinou vzdálenosti bodu $A$ od bodu $M$. Vrchol $D$ obdélníku $ABCD$ leží na polopřímce $AM$.',
             'Sestrojte vrcholy $B$, $C$, $D$ obdélníku $ABCD$, označte je písmeny a obdélník narýsujte. Najděte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG8, 'fn': 'body-A-M-primka-c.svg',
     'alt': 'Bod A ležící na přímce c a bod M mimo přímku.',
     'cap': 'Výchozí obrázek k úloze 8',
     'sol': ['Vrchol $C$ leží na přímce $c$ a zároveň na kružnici se středem $M$ a poloměrem $\\frac{1}{2}|AM|$; ta protíná přímku $c$ ve dvou bodech $C_1$, $C_2$. Strana $AD$ leží na polopřímce $AM$, proto je vrchol $D$ patou kolmice spuštěné z bodu $C$ na přímku $AM$. Vrchol $B$ doplníme tak, aby $ABCD$ byl obdélník. Úloha má dvě řešení.'],
     'ans': 'Dvě řešení: $C_1$, $C_2$ jsou průsečíky přímky $c$ s kružnicí se středem $M$ a poloměrem $\\frac{1}{2}|AM|$; $D$ je pata kolmice z $C$ na přímku $AM$, $B$ doplňuje obdélník $ABCD$ (viz obrázek v klíči).',
     'pts': 3, 'mins': 7, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7C 2021 – úloha 9 (konstrukce)',
     'zad': ['V rovině leží body $A$, $B$, $L$ (viz obrázek).',
             'Body $A$, $B$ jsou vrcholy trojúhelníku $ABC$. Osy vnitřních úhlů $BAC$ a $ABC$ tohoto trojúhelníku procházejí bodem $L$.',
             'Sestrojte vrchol $C$ trojúhelníku $ABC$, označte ho písmenem a trojúhelník narýsujte.'],
     'opts': None, 'ln': 0, 'svg': SVG9, 'fn': 'body-A-B-L.svg',
     'alt': 'Tři body A, B a L v rovině.',
     'cap': 'Výchozí obrázek k úloze 9',
     'sol': ['Bod $L$ je průsečíkem os vnitřních úhlů při vrcholech $A$ a $B$. Přímka $AL$ je osou úhlu $BAC$, proto polopřímka $AC$ vznikne osovou souměrností polopřímky $AB$ podle přímky $AL$. Obdobně polopřímka $BC$ vznikne osovou souměrností polopřímky $BA$ podle přímky $BL$. Průsečík polopřímek $AC$ a $BC$ je hledaný vrchol $C$.'],
     'ans': 'Vrchol $C$ je průsečík obrazů polopřímek $AB$ a $BA$ v osových souměrnostech podle přímek $AL$ a $BL$ (viz obrázek v klíči).',
     'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7C 2021 – úloha 10',
     'zad': ['Na vytvoření obrazce můžeme použít velké a malé čtverce a trojúhelníky. Malý čtverec má stranu délky $2$ cm. Velký čtverec lze složit z $9$ malých čtverců. Malý (velký) trojúhelník získáme rozstřižením malého (velkého) čtverce na dvě poloviny.',
             'Rozhodněte o každém z následujících tvrzení (10.1–10.3), zda je pravdivé (A), či nikoli (N).',
             '10.1 Obrazec A lze beze zbytku rozstříhat na $41$ malých trojúhelníků.',
             '10.2 Obsah obrazce B je o $4$ cm² větší než obsah obrazce A.',
             '10.3 Obsah obrazce B je o $50$ cm² větší než obsah velkého čtverce.'],
     'opts': None, 'ln': 0, 'svg': SVG10, 'fn': 'obrazce-A-B.svg',
     'alt': 'Obrazec A ve tvaru domu se šipkou a komínem a obrazec B ve tvaru hradby s cimbuřím.',
     'cap': 'Obrazec A a obrazec B',
     'sol': ['Malý čtverec má obsah $2\\cdot 2=4$ cm², malý trojúhelník tedy $2$ cm². Velký čtverec má obsah $9\\cdot 4=36$ cm². Sečtením dílů má obrazec A obsah $82$ cm² a obrazec B obsah $86$ cm².',
             '10.1 $82:2=41$ malých trojúhelníků – obrazec A na ně lze rozstříhat → Ano.',
             '10.2 $86-82=4$ cm² → Ano.',
             '10.3 $86-36=50$ cm² → Ano.'],
     'ans': '10.1: Ano; 10.2: Ano; 10.3: Ano', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['planimetrie', 'argumentace', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7C 2021 – úloha 11',
     'zad': ['V rovině leží čtyři přímky, z nichž dvě jsou rovnoběžné (viz obrázek). Ve vyznačených místech jsou úhly $\\alpha$, $2\\alpha$ a $36^\\circ$.',
             'Jaká je velikost úhlu $\\alpha$? Velikosti úhlů neměřte, ale vypočtěte.'],
     'opts': ['A) $18^\\circ$', 'B) $36^\\circ$', 'C) $44^\\circ$', 'D) $48^\\circ$', 'E) jiná velikost'],
     'ln': 0, 'svg': SVG11, 'fn': 'ctyri-primky-uhly.svg',
     'alt': 'Dvě rovnoběžné přímky protnuté dvěma různoběžkami; vyznačené úhly alfa, dvojnásobek alfa a 36 stupňů.',
     'cap': 'Čtyři přímky, dvě z nich rovnoběžné',
     'sol': ['Přímka svírající s horní rovnoběžkou úhel $\\alpha$ svírá stejný úhel $\\alpha$ i s dolní rovnoběžkou (střídavé úhly). Trojúhelník ohraničený dolní rovnoběžkou a oběma různoběžkami má vnitřní úhly $\\alpha$, $36^\\circ$ a $2\\alpha$ (vrcholový k vyznačenému úhlu). Jejich součet je $180^\\circ$: $\\alpha+36^\\circ+2\\alpha=180^\\circ$, tedy $3\\alpha=144^\\circ$ a $\\alpha=48^\\circ$.'],
     'ans': 'D) $48^\\circ$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7C 2021 – úloha 12',
     'zad': ['Farma vykupuje tři druhy léčivých bylin A, B, C. Výkupní cenu za $1$ kg každé z bylin znázorňuje graf (skutečná cena v korunách není uvedena).',
             'Chlapci ze skautského oddílu nasbírali $12$ kg byliny B, dívky sbíraly bylinu A. Dívky dostaly za nasbírané byliny stejnou částku jako chlapci.',
             'Kolik kg byliny A nasbíraly dívky?'],
     'opts': ['A) $8$ kg', 'B) $10$ kg', 'C) $11$ kg', 'D) $14$ kg', 'E) $15$ kg'],
     'ln': 0, 'svg': SVG12, 'fn': 'graf-ceny-bylin.svg',
     'alt': 'Vodorovný sloupcový graf cen bylin: A odpovídá 8 dílkům, B 10 dílkům, C 11 dílkům.',
     'cap': 'Výkupní ceny bylin za 1 kg',
     'sol': ['Z grafu odpovídá cena byliny A $8$ dílkům a byliny B $10$ dílkům. Chlapci utržili $12\\cdot 10=120$ dílků. Dívky za bylinu A dostaly stejně, tedy $120:8=15$ kg.'],
     'ans': 'E) $15$ kg', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['statistika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7C 2021 – úloha 13',
     'zad': ['Farma vykupuje tři druhy léčivých bylin A, B, C. Výkupní cenu za $1$ kg každé z bylin znázorňuje graf (skutečná cena v korunách není uvedena).',
             'Vedoucí skautského oddílu nasbírala $2$ kg byliny A a $1$ kg byliny C. Za nasbírané byliny A dostala o $30$ korun více než za byliny C.',
             'Kolik korun celkem dostala vedoucí za nasbírané byliny?'],
     'opts': ['A) $108$ korun', 'B) $135$ korun', 'C) $162$ korun', 'D) $189$ korun', 'E) více než $190$ korun'],
     'ln': 0, 'svg': SVG12, 'fn': 'graf-ceny-bylin.svg',
     'alt': 'Vodorovný sloupcový graf cen bylin: A odpovídá 8 dílkům, B 10 dílkům, C 11 dílkům.',
     'cap': 'Výkupní ceny bylin za 1 kg',
     'sol': ['Z grafu odpovídá cena byliny A $8$ dílkům a byliny C $11$ dílkům. Za $2$ kg byliny A dostala $16$ dílků, za $1$ kg byliny C $11$ dílků; rozdíl $16-11=5$ dílků odpovídá $30$ korunám, tedy $1$ dílek $=6$ korun. Celkem $(16+11)\\cdot 6=27\\cdot 6=162$ korun.'],
     'ans': 'C) $162$ korun', 'pts': 2, 'mins': 5, 'diff': '3',
     'codes': B + ['statistika', 'modelovani', 'slovni', 'bez-kalkulacky', 'finance']},

    {'name': 'CERMAT M7C 2021 – úloha 14',
     'zad': ['Kolmý šestiboký hranol byl vytvořen opracováním krychle o hraně délky $8$ cm. Podstava hranolu vznikne ze čtvercové stěny původní krychle oddělením $4$ shodných pravoúhlých trojúhelníků s odvěsnami délek $3$ cm a $4$ cm. Výška hranolu je $8$ cm.',
             'Jaký je objem šestibokého hranolu?'],
     'opts': ['A) $128$ cm³', 'B) $320$ cm³', 'C) $416$ cm³', 'D) $488$ cm³', 'E) jiný objem'],
     'ln': 0, 'svg': SVG14, 'fn': 'podstava-hranolu.svg',
     'alt': 'Čtvercová stěna 8 krát 8 cm s vepsaným šestiúhelníkem po oddělení čtyř rohových trojúhelníků s odvěsnami 3 cm a 4 cm.',
     'cap': 'Podstava šestibokého hranolu',
     'sol': ['Obsah čtvercové stěny je $8\\cdot 8=64$ cm². Každý oddělený trojúhelník má obsah $\\frac{1}{2}\\cdot 3\\cdot 4=6$ cm², čtyři z nich $24$ cm². Podstava má obsah $64-24=40$ cm². Objem hranolu je $40\\cdot 8=320$ cm³.'],
     'ans': 'B) $320$ cm³', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['stereometrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7C 2021 – úloha 15',
     'zad': ['Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).',
             '15.1 V domově pro seniory je $120$ klientů a $84$ z nich bylo očkováno. Kolik procent klientů domova pro seniory nebylo očkováno?',
             '15.2 Vláďa má $40$ kartiček. Roman má o čtvrtinu kartiček více než Vláďa. O kolik procent má Vláďa méně kartiček než Roman?',
             '15.3 Cena za víkendový pobyt činila $2\\,000$ korun a zahrnovala pouze dopravu, ubytování a stravování. Cena dopravy tvořila čtvrtinu ceny pobytu, ubytování stálo $800$ korun. Kolik procent ceny pobytu tvořila cena stravování?'],
     'opts': ['A) $20\\,\\%$', 'B) $25\\,\\%$', 'C) $30\\,\\%$', 'D) $33\\,\\%$', 'E) $35\\,\\%$', 'F) jiný počet procent'],
     'ln': 0,
     'sol': ['15.1 Neočkováno bylo $120-84=36$ klientů; $\\frac{36}{120}=0{,}30=30\\,\\%$ → C.',
             '15.2 Roman má $40\\cdot 1{,}25=50$ kartiček. Vláďa má o $50-40=10$ méně; $\\frac{10}{50}=20\\,\\%$ → A.',
             '15.3 Doprava $\\frac{1}{4}\\cdot 2\\,000=500$ Kč, ubytování $800$ Kč, stravování $2\\,000-500-800=700$ Kč; $\\frac{700}{2\\,000}=0{,}35=35\\,\\%$ → E.'],
     'ans': '15.1: C ($30\\,\\%$); 15.2: A ($20\\,\\%$); 15.3: E ($35\\,\\%$)', 'pts': 6, 'mins': 8, 'diff': '3',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7C 2021 – úloha 16',
     'zad': ['Trojúhelníkové obrazce se podle vzoru sestavují z tmavých šestiúhelníků a bílých trojúhelníků. Šestiúhelník se skládá ze $6$ shodných tmavých trojúhelníků. Jednotlivé řady obrazce jsou očíslovány vždy od nejkratší (č. 1) po nejdelší.',
             'Obrazec má $19$ řad. Určete počet',
             '16.1 bílých trojúhelníků v $9.$ řadě,',
             '16.2 tmavých trojúhelníků v $16.$ řadě,',
             '16.3 tmavých šestiúhelníků v celém obrazci.'],
     'opts': None, 'ln': 3, 'svg': SVG16, 'fn': 'trojuhelnikovy-obrazec.svg',
     'alt': 'Trojúhelníkový obrazec o 7 řadách složený z tmavých šestiúhelníků a bílých trojúhelníků, řady číslovány zdola.',
     'cap': 'Trojúhelníkový obrazec (schéma prvních řad)',
     'sol': ['V $r$-té řadě je celkem $2r-1$ malých trojúhelníků. Tmavých je v sudé řadě $\\frac{3r}{2}$, v liché řadě (kromě první) $\\frac{3(r-1)}{2}$; ostatní jsou bílé.',
             '16.1 Řada $9$ (lichá): tmavých $\\frac{3\\cdot 8}{2}=12$, celkem $2\\cdot 9-1=17$, bílých $17-12=5$.',
             '16.2 Řada $16$ (sudá): tmavých $\\frac{3\\cdot 16}{2}=24$.',
             '16.3 Šestiúhelníky tvoří pásy; mezi řadami $2j$ a $2j+1$ je $j$ šestiúhelníků. Pro $19$ řad je pásů $9$, celkem $1+2+\\dots+9=\\frac{9\\cdot 10}{2}=45$ šestiúhelníků.'],
     'ans': '16.1: $5$ bílých trojúhelníků; 16.2: $24$ tmavých trojúhelníků; 16.3: $45$ tmavých šestiúhelníků',
     'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['posloupnosti', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M7PCD21C0T03'
    gen.YEAR = 2021

    def dollars_ok(s): return s.count('$') % 2 == 0
    errors = []; names = set()
    for p in PROBLEMS:
        if p['name'] in names: errors.append('DUP název: ' + p['name'])
        names.add(p['name'])
        if 'M7C' not in p['name']: errors.append('Název bez M7C: ' + p['name'])
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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M7C-2021')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
