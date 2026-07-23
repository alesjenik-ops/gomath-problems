# -*- coding: utf-8 -*-
# CERMAT – Jednotná přijímací zkouška 2022, MATEMATIKA 5 (osmileté obory, 5. ročník),
# varianta D (2. náhradní termín). Kód testu: M5PDD22C0T04.
# 14 úloh; po rozdělení izolovaných poduúloh a samostatných konstrukcí 18 úloh.
# Zdroj odpovědí: klíč správných řešení (KSR), ověřeno záznamovým archem (VZA).

# ---- SVG obrázky (bez ' a \) ----

# úloha 3.1: obrazec – čtverec, dva rovnostranné trojúhelníky, dva obdélníky (schematický oblouk)
SVG31 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 340 210" font-family="sans-serif">
<polygon points="130,30 210,30 210,110 130,110" fill="none" stroke="#000" stroke-width="2"/>
<polygon points="130,30 130,110 65,70" fill="none" stroke="#000" stroke-width="2"/>
<polygon points="210,30 210,110 275,70" fill="none" stroke="#000" stroke-width="2"/>
<polygon points="65,70 130,110 100,190 35,150" fill="none" stroke="#000" stroke-width="2"/>
<polygon points="275,70 210,110 240,190 305,150" fill="none" stroke="#000" stroke-width="2"/>
<text x="170" y="80" font-size="12" text-anchor="middle">čtverec</text>
</svg>"""

# úloha 3.2: část čtvercové sítě (přesně: horní řada 1,2,3 a 5; střední 1-5; dolní 1-4)
def _grid32():
    cell = 34; ox = 8; oy = 8
    rows = {1: [1, 2, 3, 5], 2: [1, 2, 3, 4, 5], 3: [1, 2, 3, 4]}
    W = 5 * cell + 2 * ox; H = 3 * cell + 2 * oy
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {W} {H}" font-family="sans-serif">']
    for r, cols in rows.items():
        for c in cols:
            x = ox + (c - 1) * cell; y = oy + (r - 1) * cell
            s.append(f'<rect x="{x}" y="{y}" width="{cell}" height="{cell}" fill="none" stroke="#000" stroke-width="2"/>')
    s.append('</svg>')
    return "".join(s)
SVG32 = _grid32()

# úloha 4: VZOR + I. a II. nákres (kroužky, silně ohraničený čtvereček nahoře, dole součet 43)
def _svg4():
    def v(x):
        return "" if x is None else str(x)
    def circ(cx, cy, t):
        return f'<circle cx="{cx}" cy="{cy}" r="13" fill="none" stroke="#666"/><text x="{cx}" y="{cy+4}" font-size="12" text-anchor="middle">{v(t)}</text>'
    def sq(x, y, t, bold):
        w = "2.5" if bold else "1"
        return f'<rect x="{x}" y="{y}" width="26" height="26" fill="none" stroke="#000" stroke-width="{w}"/><text x="{x+13}" y="{y+17}" font-size="12" text-anchor="middle">{v(t)}</text>'
    def panel(ox, oy, title, a, b, top, bl, brc, br, bold):
        p = [f'<text x="{ox+80}" y="{oy-8}" font-size="12" text-anchor="middle">{title}</text>']
        p.append(circ(ox + 16, oy + 16, a) + circ(ox + 60, oy + 16, b))
        p.append(f'<text x="{ox+38}" y="{oy+21}" font-size="13" text-anchor="middle">+</text><text x="{ox+82}" y="{oy+21}" font-size="13" text-anchor="middle">=</text>')
        p.append(sq(ox + 96, oy + 3, top, bold))
        p.append(f'<text x="{ox+4}" y="{oy+44}" font-size="10">·3</text><text x="{ox+48}" y="{oy+44}" font-size="10">·4</text>')
        p.append(f'<line x1="{ox+16}" y1="{oy+30}" x2="{ox+16}" y2="{oy+54}" stroke="#000"/><line x1="{ox+60}" y1="{oy+30}" x2="{ox+60}" y2="{oy+54}" stroke="#000"/>')
        p.append(circ(ox + 16, oy + 70, bl) + circ(ox + 60, oy + 70, brc))
        p.append(f'<text x="{ox+38}" y="{oy+75}" font-size="13" text-anchor="middle">+</text><text x="{ox+82}" y="{oy+75}" font-size="13" text-anchor="middle">=</text>')
        p.append(sq(ox + 96, oy + 57, br, False))
        return "".join(p)
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 140" font-family="sans-serif">']
    s.append(panel(20, 30, "VZOR", 2, 3, 5, 6, 12, 18, False))
    s.append(panel(180, 30, "I. nákres", None, None, None, None, None, 43, True))
    s.append(panel(340, 30, "II. nákres", None, None, None, None, None, 43, True))
    s.append('</svg>')
    return "".join(s)
SVG4 = _svg4()

# úloha 5: dvě schodiště (vyšší/nižší) se čtyřmi úrovněmi a měřenými úseky 5.1–5.3
SVG5 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 445 300" font-family="sans-serif">
<line x1="150" y1="40" x2="300" y2="40" stroke="#000" stroke-width="2"/>
<line x1="150" y1="86" x2="300" y2="86" stroke="#000" stroke-width="2"/>
<line x1="150" y1="212" x2="300" y2="212" stroke="#000" stroke-width="2"/>
<line x1="150" y1="270" x2="300" y2="270" stroke="#000" stroke-width="2"/>
<text x="144" y="44" font-size="12" text-anchor="end">ochoz</text>
<text x="144" y="90" font-size="12" text-anchor="end">2. odpočívadlo</text>
<text x="144" y="216" font-size="12" text-anchor="end">1. odpočívadlo</text>
<text x="144" y="274" font-size="12" text-anchor="end">nádvoří</text>
<line x1="200" y1="270" x2="200" y2="40" stroke="#888" stroke-width="1" stroke-dasharray="3 3"/>
<line x1="250" y1="40" x2="250" y2="270" stroke="#888" stroke-width="1" stroke-dasharray="3 3"/>
<text x="200" y="30" font-size="11" text-anchor="middle">vyšší</text>
<text x="250" y="30" font-size="11" text-anchor="middle">nižší</text>
<line x1="345" y1="270" x2="345" y2="212" stroke="#000" stroke-width="1.5"/>
<polygon points="345,212 341,220 349,220" fill="#000"/>
<text x="352" y="245" font-size="12">5.1</text>
<line x1="382" y1="40" x2="382" y2="212" stroke="#000" stroke-width="1.5"/>
<polygon points="382,212 378,204 386,204" fill="#000"/>
<text x="389" y="128" font-size="12">5.2</text>
<line x1="418" y1="86" x2="418" y2="270" stroke="#000" stroke-width="1.5"/>
<polygon points="418,270 414,262 422,262" fill="#000"/>
<text x="425" y="182" font-size="12">5.3</text>
</svg>"""

# úloha 7.1: přímky a, b protínající se v C, bod M na b
SVG71 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 320" font-family="sans-serif">
<line x1="40" y1="234" x2="430" y2="156" stroke="#000" stroke-width="2"/>
<text x="437" y="154" font-size="16" font-style="italic">a</text>
<line x1="150" y1="284" x2="290" y2="88" stroke="#000" stroke-width="2"/>
<text x="295" y="82" font-size="16" font-style="italic">b</text>
<circle cx="210" cy="200" r="3" fill="#000"/>
<text x="198" y="218" font-size="15" font-style="italic">C</text>
<circle cx="250" cy="144" r="3" fill="#000"/>
<text x="258" y="140" font-size="15" font-style="italic">M</text>
<line x1="245" y1="134" x2="255" y2="154" stroke="#000" stroke-width="2"/>
</svg>"""

# úloha 7.2: bod F a různoběžné přímky g, h
SVG72 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif">
<line x1="40" y1="205" x2="430" y2="120" stroke="#000" stroke-width="2"/>
<text x="437" y="118" font-size="16" font-style="italic">g</text>
<line x1="60" y1="120" x2="380" y2="285" stroke="#000" stroke-width="2"/>
<text x="386" y="292" font-size="16" font-style="italic">h</text>
<text x="322" y="234" font-size="15" font-style="italic">F</text>
<text x="318" y="222" font-size="15">×</text>
</svg>"""

# úloha 8: tři útvary A, B, C ve čtvercové síti (schematické znázornění)
def _grid8():
    cell = 20; cols = 8; rows = 7; gap = 40
    A = [(4,1),(5,1),(3,2),(6,2),(2,3),(3,3),(6,3),(7,3),(2,4),(4,4),(2,5),(3,5),(6,5),(7,5),(3,6),(6,6),(4,7),(5,7)]
    B = [(2,2),(3,2),(5,2),(6,2),(2,3),(4,3),(6,3),(1,4),(8,4),(2,5),(6,5),(2,6),(3,6),(5,6),(6,6),(4,7)]
    Cc = [(5,2),(3,3),(4,3),(3,4),(5,4),(7,4),(2,5),(4,5),(5,5),(6,5),(5,6),(4,7)]
    grids = [('A', A), ('B', B), ('C', Cc)]
    gw = cols * cell
    W = len(grids) * gw + (len(grids) - 1) * gap + 40
    H = rows * cell + 60
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {W} {H}" font-family="sans-serif">']
    for gi, (label, cells) in enumerate(grids):
        ox = 20 + gi * (gw + gap); oy = 40
        s.append(f'<text x="{ox+gw/2}" y="{oy-14}" font-size="16" text-anchor="middle">{label}</text>')
        for (c, r) in cells:
            s.append(f'<rect x="{ox+(c-1)*cell}" y="{oy+(r-1)*cell}" width="{cell}" height="{cell}" fill="#9a9a9a"/>')
        dv = "".join(f"M{ox+i*cell} {oy}V{oy+rows*cell}" for i in range(cols + 1))
        dh = "".join(f"M{ox} {oy+j*cell}H{ox+gw}" for j in range(rows + 1))
        s.append(f'<path d="{dv}{dh}" stroke="#333" stroke-width="1" fill="none"/>')
    s.append('</svg>')
    return "".join(s)
SVG8 = _grid8()

# úloha 10: vodorovný sloupcový graf (Petr, Standa – chybí; Radek 20, Tomáš 16)
def _graph():
    rows = [('Petr', None), ('Radek', 20), ('Standa', None), ('Tomáš', 16)]
    x0 = 90; y0 = 40; rh = 30; gap = 18; unit = 13; maxv = 28
    plot_h = len(rows) * (rh + gap)
    W = x0 + maxv * unit + 30; H = y0 + plot_h + 30
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {W} {H}" font-family="sans-serif">']
    s.append(f'<text x="{x0+maxv*unit/2}" y="26" font-size="14" text-anchor="middle">Počet kartiček</text>')
    for val in range(0, maxv + 1, 4):
        x = x0 + val * unit
        s.append(f'<line x1="{x}" y1="{y0}" x2="{x}" y2="{y0+plot_h}" stroke="#bbb" stroke-width="1"/>')
    s.append(f'<line x1="{x0}" y1="{y0}" x2="{x0}" y2="{y0+plot_h}" stroke="#000" stroke-width="2"/>')
    s.append(f'<text x="{x0}" y="{y0+plot_h+20}" font-size="13" text-anchor="middle">0</text>')
    for i, (name, val) in enumerate(rows):
        y = y0 + i * (rh + gap) + gap / 2
        s.append(f'<text x="{x0-8}" y="{y+rh*0.65}" font-size="13" text-anchor="end">{name}</text>')
        if val is None:
            yc = y + rh / 2
            s.append(f'<line x1="{x0}" y1="{yc}" x2="{x0+maxv*unit}" y2="{yc}" stroke="#777" stroke-width="1" stroke-dasharray="7 5"/>')
        else:
            s.append(f'<rect x="{x0}" y="{y}" width="{val*unit}" height="{rh}" fill="#9a9a9a" stroke="#000" stroke-width="1"/>')
    s.append('</svg>')
    return "".join(s)
SVG10 = _graph()

# úloha 11: dva pohledy na těžítko (shora: kruh se šedým čtvercem; zepředu: obdélník se šedým trojúhelníkem)
SVG11 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 200" font-family="sans-serif">
<text x="95" y="24" font-size="13" text-anchor="middle">Pohled shora</text>
<circle cx="95" cy="115" r="60" fill="none" stroke="#000" stroke-width="2"/>
<rect x="60" y="80" width="70" height="70" fill="#cfcfcf" stroke="#000" stroke-width="1.5"/>
<text x="300" y="24" font-size="13" text-anchor="middle">Pohled zepředu</text>
<rect x="250" y="55" width="100" height="120" fill="none" stroke="#000" stroke-width="2"/>
<polygon points="258,55 342,55 300,168" fill="#cfcfcf" stroke="#000" stroke-width="1.5"/>
</svg>"""

# úloha 12: stavba (schematicky, oblique) a pohled zepředu (schodiště klesající vpravo)
def _svg12():
    def cube(x, y, s):
        dx = 15; dy = -11
        top = f'<polygon points="{x},{y} {x+dx},{y+dy} {x+s+dx},{y+dy} {x+s},{y}" fill="#efefef" stroke="#000" stroke-width="1.4"/>'
        right = f'<polygon points="{x+s},{y} {x+s+dx},{y+dy} {x+s+dx},{y+s+dy} {x+s},{y+s}" fill="#d8d8d8" stroke="#000" stroke-width="1.4"/>'
        front = f'<rect x="{x}" y="{y}" width="{s}" height="{s}" fill="#ffffff" stroke="#000" stroke-width="1.4"/>'
        return top + right + front
    out = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 220" font-family="sans-serif">']
    out.append('<text x="110" y="24" font-size="13" text-anchor="middle">Stavba</text>')
    sc = 40
    # zadní/horní krychličky nejdřív, přední naposledy
    out.append(cube(50, 52, sc))
    out.append(cube(50, 92, sc)); out.append(cube(92, 92, sc))
    out.append(cube(50, 132, sc)); out.append(cube(92, 132, sc)); out.append(cube(134, 132, sc))
    out.append('<text x="330" y="24" font-size="13" text-anchor="middle">Pohled zepředu</text>')
    fc = 34; fx = 290; fy = 66
    fv = {1: [1], 2: [1, 2], 3: [1, 2, 3]}
    for r, cols in fv.items():
        for c in cols:
            out.append(f'<rect x="{fx+(c-1)*fc}" y="{fy+(r-1)*fc}" width="{fc}" height="{fc}" fill="none" stroke="#000" stroke-width="1.6"/>')
    out.append('</svg>')
    return "".join(out)
SVG12 = _svg12()

B = ['zs1']  # 5. ročník ZŠ (osmileté obory); kód r5 se v taxonomii nepoužívá

PROBLEMS = [
    {'name': 'CERMAT M5D 2022 – úloha 1.1',
     'zad': ['Doplňte do rámečku takové číslo, aby platila rovnost:', '$96 - 3 \\cdot \\square = 18 + 36 : 3$'],
     'opts': None, 'ln': 1,
     'sol': ['$18 + 36 : 3 = 18 + 12 = 30$. Tedy $3 \\cdot \\square = 96 - 30 = 66$, a proto $\\square = 22$.'],
     'ans': '$22$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5D 2022 – úloha 1.2',
     'zad': ['Doplňte do rámečku takové číslo, aby platila rovnost:', '$(96 : 3 - \\square) \\cdot 2 = 2 \\cdot 18$'],
     'opts': None, 'ln': 1,
     'sol': ['$2 \\cdot 18 = 36$, tedy $96 : 3 - \\square = 18$. Protože $96 : 3 = 32$, je $\\square = 32 - 18 = 14$.'],
     'ans': '$14$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5D 2022 – úloha 2.1',
     'zad': ['Měsíc vyšel nad obzor včera večer v 18:17 a zapadl dnes ráno v 9:48.',
             'Vypočtěte, jak dlouho byl měsíc nad obzorem. Výsledek uveďte v hodinách a minutách.'],
     'opts': None, 'ln': 2,
     'sol': ['Od 18:17 do půlnoci je $5$ h $43$ min, od půlnoci do 9:48 je $9$ h $48$ min. Celkem $14$ h $91$ min, tj. $15$ h $31$ min.'],
     'ans': '$15$ hodin $31$ minut', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5D 2022 – úloha 2.2',
     'zad': ['Vypočtěte v metrech:', '$\\frac{1}{20}$ kilometru $+\\ 34\\,000$ centimetrů $=$'],
     'opts': None, 'ln': 2,
     'sol': ['$\\frac{1}{20}$ km $=50$ m a $34\\,000$ cm $=340$ m. Součet je $50 + 340 = 390$ m (tj. $39\\,000$ cm).'],
     'ans': '$390$ metrů', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5D 2022 – úloha 3.1',
     'zad': ['Obrazec se skládá ze čtverce, dvou rovnostranných trojúhelníků a dvou stejných obdélníků. (Sousední útvary mají společnou jednu stranu.)',
             'Obvod celého obrazce je $54$ cm a délka strany čtverce je $5$ cm.',
             'Vypočtěte v cm obvod jednoho obdélníku.'],
     'opts': None, 'ln': 2, 'svg': SVG31, 'fn': 'obrazec.svg',
     'alt': 'Obrazec ve tvaru oblouku – uprostřed čtverec, po stranách dva rovnostranné trojúhelníky a dva obdélníky (schematicky).',
     'cap': 'Schematický nákres obrazce',
     'sol': ['Všechny útvary mají jednu stranu dlouhou $5$ cm. Na obvodu obrazce leží šest stran délky $5$ cm a čtyři delší strany obdélníků délky $x$: $6 \\cdot 5 + 4x = 54$, tedy $4x = 24$ a $x = 6$ cm (delší strana obdélníku). Obvod jednoho obdélníku je $2 \\cdot (5 + 6) = 22$ cm.'],
     'ans': '$22$ cm', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5D 2022 – úloha 3.2',
     'zad': ['Na obrázku je zakreslena část čtvercové sítě.',
             'Určete počet všech čtverců, u kterých jsou zakresleny všechny strany.'],
     'opts': None, 'ln': 2, 'svg': SVG32, 'fn': 'ctvercova-sit.svg',
     'alt': 'Část čtvercové sítě: horní řada čtverečky ve sloupcích 1, 2, 3 a 5, střední řada sloupce 1 až 5, dolní řada sloupce 1 až 4.',
     'cap': 'Část čtvercové sítě',
     'sol': ['Čtverců $1\\times 1$ je $13$, čtverců $2\\times 2$ je $5$ a jeden čtverec $3\\times 3$. Celkem $13 + 5 + 1 = 19$ čtverců.'],
     'ans': '$19$ čtverců', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['planimetrie', 'porozumeni', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5D 2022 – úloha 4',
     'zad': ['Do prázdných kroužků a čtverečků se v souladu s uvedenými výpočty doplňují pouze celá čísla větší než 0. Horní dvě čísla se sčítají do silně ohraničeného čtverečku, každé z nich se násobí ($\\cdot 3$ vlevo, $\\cdot 4$ vpravo) a dolní dvě čísla dávají součet $43$.',
             'Doplňte taková čísla, aby byl součet v silně ohraničeném čtverečku',
             '4.1 v I. nákresu co nejmenší,',
             '4.2 ve II. nákresu co největší.'],
     'opts': None, 'ln': 2, 'svg': SVG4, 'fn': 'nakresy.svg',
     'alt': 'Vzor a dva prázdné nákresy: nahoře dva kroužky a silně ohraničený čtvereček pro jejich součet, dole dva kroužky (trojnásobek a čtyřnásobek) se součtem 43.',
     'cap': 'Vzor a nákresy I a II',
     'sol': ['Označíme horní čísla $a$ (vlevo) a $b$ (vpravo). Dole platí $3a + 4b = 43$. Řešení v celých kladných číslech jsou $(a,b) = (1,10), (5,7), (9,4), (13,1)$, takže součet $a + b$ nabývá hodnot $11, 12, 13, 14$.',
             '4.1 Nejmenší součet je $11$ (pro $a = 1$, $b = 10$).',
             '4.2 Největší součet je $14$ (pro $a = 13$, $b = 1$).'],
     'ans': '4.1: $11$; 4.2: $14$', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5D 2022 – úloha 5',
     'zad': ['Z nádvoří se chodí nahoru na ochoz věže po $120$ stejných vyšších schodech, zpět na nádvoří se chodí dolů jiným schodištěm po $180$ stejných nižších schodech. Obě schodiště jsou ve dvou místech propojena odpočívadly.',
             'Mezi 1. odpočívadlem a ochozem je třikrát více vyšších schodů než mezi nádvořím a 1. odpočívadlem. (Totéž platí o nižších schodech.) Z nádvoří na 2. odpočívadlo vede směrem nahoru $96$ vyšších schodů.',
             'Vypočtěte,',
             '5.1 kolik vyšších schodů vede směrem nahoru z nádvoří na 1. odpočívadlo,',
             '5.2 kolik nižších schodů vede směrem dolů z ochozu na 1. odpočívadlo,',
             '5.3 kolik nižších schodů vede směrem dolů z 2. odpočívadla na nádvoří.'],
     'opts': None, 'ln': 3, 'svg': SVG5, 'fn': 'schodiste.svg',
     'alt': 'Schéma věže se čtyřmi úrovněmi (nádvoří, 1. odpočívadlo, 2. odpočívadlo, ochoz) a dvěma schodišti (vyšší a nižší) s vyznačenými úseky 5.1, 5.2 a 5.3.',
     'cap': 'Schéma schodišť s odpočívadly',
     'sol': ['5.1 Vyšších schodů z nádvoří na 1. odpočívadlo je $x$, na úsek k ochozu $3x$; dohromady $x + 3x = 120$, tedy $x = 30$.',
             '5.2 U nižších schodů platí stejný poměr: z nádvoří na 1. odpočívadlo $y$, dále $3y$, celkem $4y = 180$, tedy $y = 45$. Z ochozu dolů na 1. odpočívadlo je $180 - 45 = 135$ nižších schodů.',
             '5.3 2. odpočívadlo je ve výšce $96$ vyšších schodů, tj. $\\frac{96}{120} = \\frac{4}{5}$ celkové výšky. Nižších schodů z 2. odpočívadla na nádvoří je $\\frac{4}{5} \\cdot 180 = 144$.'],
     'ans': '5.1: $30$ vyšších schodů; 5.2: $135$ nižších schodů; 5.3: $144$ nižších schodů',
     'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5D 2022 – úloha 6',
     'zad': ['Stejné zahradní dlaždice se skládají na stejné dřevěné palety. Plná paleta obsahuje $10$ kusů dlaždic. Dvě plné palety s dlaždicemi váží dohromady $340$ kg. Jedna paleta se $4$ dlaždicemi váží $80$ kg.',
             'Vypočtěte, kolik kg váží',
             '6.1 jedna dlaždice,',
             '6.2 jedna prázdná paleta.'],
     'opts': None, 'ln': 2,
     'sol': ['6.1 Jedna plná paleta (10 dlaždic) váží $340 : 2 = 170$ kg. Rozdíl oproti paletě se 4 dlaždicemi je $170 - 80 = 90$ kg a připadá na $10 - 4 = 6$ dlaždic, takže jedna dlaždice váží $90 : 6 = 15$ kg.',
             '6.2 Prázdná paleta váží $80 - 4 \\cdot 15 = 80 - 60 = 20$ kg.'],
     'ans': '6.1: $15$ kg; 6.2: $20$ kg', 'pts': 3, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5D 2022 – úloha 7.1 (konstrukce)',
     'zad': ['V rovině leží přímky $a$, $b$, které se protínají v bodě $C$. Na přímce $b$ leží bod $M$ (viz obrázek).',
             'Bod $C$ je vrchol obdélníku $ABCD$. Vrchol $A$ tohoto obdélníku leží na přímce $a$. Úsečka $AM$ je dvakrát delší než úsečka $CM$. Vrchol $B$ obdélníku $ABCD$ leží na přímce $b$.',
             'Sestrojte vrcholy $A$, $B$, $D$ obdélníku $ABCD$, označte je písmeny a obdélník narýsujte. Najděte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG71, 'fn': 'primky-ab.svg',
     'alt': 'Dvě přímky a a b protínající se v bodě C; na přímce b leží bod M.',
     'cap': 'Výchozí obrázek k úloze 7.1',
     'sol': ['Strana $BC$ leží na přímce $b$ (obsahuje body $B$ i $C$), proto je strana $AB$ kolmá k přímce $b$ a vrchol $A$ leží na přímce $a$. Bod $A$ určíme z podmínky $|AM| = 2\\cdot|CM|$: sestrojíme kružnici se středem $M$ a poloměrem $2\\cdot|CM|$; její dva průsečíky s přímkou $a$ jsou vrcholy $A_1$, $A_2$. Z každého bodu $A$ spustíme kolmici na přímku $b$ (pata je vrchol $B$) a doplníme obdélník. Úloha má dvě řešení.'],
     'ans': 'Dvě řešení: obdélníky $A_1BCD_1$ a $A_2BCD_2$; vrchol $A$ leží na přímce $a$ a splňuje $|AM| = 2\\cdot|CM|$, strana $BC$ leží na přímce $b$ (viz obrázek v klíči).',
     'pts': 3, 'mins': 7, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5D 2022 – úloha 7.2 (konstrukce)',
     'zad': ['V rovině leží bod $F$ a různoběžné přímky $g$, $h$ (viz obrázek).',
             'Bod $F$ je vrchol trojúhelníku $FGH$. Na přímce $g$ leží vrchol $G$, na přímce $h$ leží vrchol $H$. Obě strany $FG$ i $GH$ mají stejnou délku, a to $5$ cm.',
             'Sestrojte vrcholy $G$, $H$ trojúhelníku $FGH$, označte je písmeny a trojúhelník narýsujte. Najděte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG72, 'fn': 'body-F-gh.svg',
     'alt': 'Bod F a dvě různoběžné přímky g a h.',
     'cap': 'Výchozí obrázek k úloze 7.2',
     'sol': ['Vrchol $G$ leží na přímce $g$ a zároveň $|FG| = 5$ cm, proto jej najdeme jako průsečík přímky $g$ s kružnicí se středem $F$ a poloměrem $5$ cm. Vrchol $H$ leží na přímce $h$ a $|GH| = 5$ cm, proto jej najdeme jako průsečík přímky $h$ s kružnicí se středem $G$ a poloměrem $5$ cm; ta protíná přímku $h$ ve dvou bodech $H_1$, $H_2$. Úloha má dvě řešení – trojúhelníky $FGH_1$ a $FGH_2$.'],
     'ans': 'Dvě řešení: $G$ na přímce $g$ ve vzdálenosti $5$ cm od $F$; body $H_1$, $H_2$ na přímce $h$ ve vzdálenosti $5$ cm od $G$ (trojúhelníky $FGH_1$, $FGH_2$) – viz obrázek v klíči.',
     'pts': 3, 'mins': 7, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5D 2022 – úloha 8',
     'zad': ['Ve čtvercové síti jsou z tmavých čtverců složeny tři útvary $A$, $B$, $C$. Každý z nich má pouze jednu osu souměrnosti. V každém útvaru přemístíme jediný tmavý čtverec tak, aby měl upravený útvar co nejvíce různých os souměrnosti (svislých, vodorovných nebo šikmých).',
             'Rozhodněte o každém z tvrzení 8.1–8.3, zda je pravdivé (A), či nikoli (N).',
             '8.1 Správně upravený útvar $A$ má pouze 2 osy souměrnosti.',
             '8.2 Správně upravený útvar $B$ má pouze 2 osy souměrnosti.',
             '8.3 Správně upravený útvar $C$ má pouze 1 osu souměrnosti.'],
     'opts': None, 'ln': 0, 'svg': SVG8, 'fn': 'utvary-abc.svg',
     'alt': 'Tři útvary A, B, C složené z šedých čtverců ve čtvercové síti (schematicky).',
     'cap': 'Útvary A, B, C ve čtvercové síti',
     'sol': ['8.1 Útvar $A$ lze přemístěním jednoho čtverce upravit tak, aby měl přesně 2 osy souměrnosti – tvrzení je pravdivé (A).',
             '8.2 Nejlepší úpravou útvaru $B$ vznikne útvar s více než 2 osami souměrnosti, takže tvrzení o pouze 2 osách je nepravdivé (N).',
             '8.3 Nejlepší úpravou útvaru $C$ vznikne útvar s více než 1 osou souměrnosti, takže tvrzení o pouze 1 ose je nepravdivé (N).'],
     'ans': '8.1: Ano; 8.2: Ne; 8.3: Ne', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['planimetrie', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5D 2022 – úloha 9',
     'zad': ['Ve stánku mají celkem $140$ krabiček s čaji. Všechny jsou naskládány do sloupečků po čtyřech krabičkách. V $10$ sloupečcích jsou pouze krabičky s černými čaji a v každém ze zbývajících sloupečků je jedna krabička s černým čajem a $3$ krabičky s ovocnými čaji.',
             'Kolik krabiček s ovocnými čaji mají ve stánku?'],
     'opts': ['A) 30 krabiček', 'B) 40 krabiček', 'C) 75 krabiček', 'D) 100 krabiček', 'E) jiný počet krabiček'],
     'ln': 0,
     'sol': ['Sloupečků je $140 : 4 = 35$. Z toho $10$ je jen s černým čajem, zbývá $25$ smíšených sloupečků a v každém jsou $3$ ovocné krabičky: $25 \\cdot 3 = 75$.'],
     'ans': 'C) 75 krabiček', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5D 2022 – úloha 10',
     'zad': ['Čtyři chlapci (Petr, Radek, Standa a Tomáš) sbírají kartičky s hokejisty. V grafu některé údaje chybí (u Petra a Standy). Standa má o polovinu méně kartiček než Tomáš a oba dohromady mají $24$ kartiček. Petr má o $5$ kartiček více než Radek.',
             'O kolik se liší počet Petrových a Standových kartiček?'],
     'opts': ['A) o 1 kartičku', 'B) o 8 kartiček', 'C) o 10 kartiček', 'D) o 17 kartiček', 'E) o jiný počet kartiček'],
     'ln': 0, 'svg': SVG10, 'fn': 'graf-karticky.svg',
     'alt': 'Vodorovný sloupcový graf počtu kartiček: řádky Petr a Standa jsou prázdné (chybí), Radek má 20 a Tomáš 16 kartiček.',
     'cap': 'Počet kartiček (některé údaje chybí)',
     'sol': ['Standa má polovinu toho co Tomáš a spolu mají $24$: Tomáš $= 16$, Standa $= 8$. Z grafu má Radek $20$ kartiček, tedy Petr $= 20 + 5 = 25$. Rozdíl Petrových a Standových kartiček je $25 - 8 = 17$.'],
     'ans': 'D) o 17 kartiček', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['statistika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5D 2022 – úloha 11',
     'zad': ['Těžítko je vyrobeno ze skla – část ze šedého skla, zbytek z průhledného skla. Na obrázku jsou dva pohledy na toto těžítko (shora a zepředu).',
             'Který popis těžítka je v souladu s uvedenými podmínkami?'],
     'opts': ['A) Ve skleněné krychli je šedý kužel.', 'B) Ve skleněném válci je šedý jehlan.', 'C) Ve skleněném kvádru je šedý jehlan.', 'D) Ve skleněném válci je šedý kužel.', 'E) Ve skleněném kuželi je šedý kvádr.'],
     'ln': 0, 'svg': SVG11, 'fn': 'tezitko.svg',
     'alt': 'Pohled shora: kruh se šedým čtvercem uvnitř. Pohled zepředu: obdélník se šedým trojúhelníkem s vrcholem dolů.',
     'cap': 'Dva pohledy na těžítko',
     'sol': ['Pohled shora je kruh, takže vnější těleso je válec. Šedá část je při pohledu shora čtverec a při pohledu zepředu trojúhelník, což odpovídá jehlanu. Správně je válec se šedým jehlanem.'],
     'ans': 'B) Ve skleněném válci je šedý jehlan.', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['stereometrie', 'porozumeni', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5D 2022 – úloha 12',
     'zad': ['Na podložce je postavena stavba ze $6$ stejných krychliček a $2$ stejných kvádrů. Na obrázku je stavba a její pohled zepředu.',
             'Který z obrázků (A–E) může představovat pohled na stavbu zezadu?'],
     'opts': ['A) obrázek A', 'B) obrázek B', 'C) obrázek C', 'D) obrázek D', 'E) žádný z uvedených obrázků'],
     'ln': 0, 'svg': SVG12, 'fn': 'stavba.svg',
     'alt': 'Schematická stavba (schodiště klesající vpravo) a její pohled zepředu; obrázky A–E jsou v testovém sešitu.',
     'cap': 'Stavba a pohled zepředu (obrázky A–E viz testový sešit)',
     'sol': ['Pohled zezadu je zrcadlově obrácený pohled zepředu, tedy schodiště stoupající na opačnou stranu. Tomu odpovídá obrázek $A$.'],
     'ans': 'A) obrázek A', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['stereometrie', 'porozumeni', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5D 2022 – úloha 13',
     'zad': ['Přiřaďte ke každé úloze (13.1–13.3) odpovídající výsledek (A–F).',
             '13.1 Do 1. třídy chodí $24$ žáků, přitom chlapců je dvakrát více než dívek. Kolik chlapců chodí do 1. třídy?',
             '13.2 Do 2. třídy chodí $25$ žáků. Když chyběli $3$ chlapci a $2$ dívky, bylo mezi přítomnými chlapců o $4$ více než dívek. Kolik chlapců chodí do 2. třídy?',
             '13.3 Do 3. třídy chodí chlapců o pětinu méně než dívek. Počty dívek a chlapců se liší o $3$. Kolik chlapců chodí do 3. třídy?'],
     'opts': ['A) 12 chlapců', 'B) 13 chlapců', 'C) 14 chlapců', 'D) 15 chlapců', 'E) 16 chlapců', 'F) jiný počet chlapců'],
     'ln': 0,
     'sol': ['13.1 Dívek $d$, chlapců $2d$, celkem $3d = 24$, tedy $d = 8$ a chlapců je $16$ → E.',
             '13.2 Chlapců $c$, dívek $25 - c$. Přítomných: $(c - 3) - (25 - c - 2) = 4$, tedy $2c - 26 = 4$ a $c = 15$ → D.',
             '13.3 Chlapci mají $\\frac{4}{5}$ počtu dívek, rozdíl je $\\frac{1}{5}$ dívek $= 3$, tedy dívek je $15$ a chlapců $12$ → A.'],
     'ans': '13.1: E (16 chlapců); 13.2: D (15 chlapců); 13.3: A (12 chlapců)',
     'pts': 5, 'mins': 7, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5D 2022 – úloha 14',
     'zad': ['Řada je vytvořena z celých čísel. První trojice čísel je $0, 1, 2$. Každou další trojici vytvoříme tak, že jednotlivá čísla z předchozí trojice zvětšíme o $1$.',
             'Na 1. až 18. místě jsou čísla: $0, 1, 2, 1, 2, 3, 2, 3, 4, 3, 4, 5, 4, 5, 6, 5, 6, 7, \\ldots$',
             'Určete,',
             '14.1 na kolikátém místě řady je poprvé číslo $12$,',
             '14.2 na kolika místech řady je mezi prvními $125$ čísly uvedeno liché číslo,',
             '14.3 které číslo je na 152. místě řady.'],
     'opts': None, 'ln': 3,
     'sol': ['$k$-tá trojice je $(k-1,\\ k,\\ k+1)$ a zaujímá místa $3k-2$ až $3k$.',
             '14.1 Číslo $12$ se poprvé objeví jako poslední člen $11.$ trojice $(10, 11, 12)$, tedy na místě $3 \\cdot 11 = 33$.',
             '14.2 Mezi prvními $125$ místy je $41$ celých trojic (místa 1–123) a začátek $42.$ trojice. V liché trojici je $1$ liché číslo, v sudé jsou $2$: $21 \\cdot 1 + 20 \\cdot 2 = 61$; z $42.$ trojice $(41, 42, \\ldots)$ přibude ještě $1$ liché číslo. Celkem $62$.',
             '14.3 $152 = 3 \\cdot 50 + 2$, jde tedy o druhý člen $51.$ trojice $(50, 51, 52)$, což je číslo $51$.'],
     'ans': '14.1: na 33. místě; 14.2: na 62 místech; 14.3: 51',
     'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['posloupnosti', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M5PDD22C0T04'
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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M5D-2022')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
