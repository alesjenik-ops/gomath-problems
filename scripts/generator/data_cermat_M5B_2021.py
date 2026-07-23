# -*- coding: utf-8 -*-
# CERMAT – Jednotná přijímací zkouška 2021, MATEMATIKA 5B (osmileté obory, 5. ročník),
# 2. řádný termín. Kód testu: M5PBD21C0T02. 14 úloh (po rozdělení izolovaných
# podúloh 17 úloh). Zdroj odpovědí: klíč správných řešení (KSR); počtářské přepočítány.

# ---- SVG obrázky (bez ' a \) ----

# úloha 2: číselná osa, deset dílků, A=72, C (neznámé), B=192; 0 se doplňuje
def _numline():
    ox = 40; oy = 72; d = 40; n = 10
    def X(i): return ox + i * d
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 130" font-family="sans-serif">']
    s.append(f'<line x1="{ox-8}" y1="{oy}" x2="{X(n)+24}" y2="{oy}" stroke="#000" stroke-width="2"/>')
    s.append(f'<polygon points="{X(n)+24},{oy} {X(n)+13},{oy-5} {X(n)+13},{oy+5}" fill="#000"/>')
    for i in range(n + 1):
        s.append(f'<line x1="{X(i)}" y1="{oy-7}" x2="{X(i)}" y2="{oy+7}" stroke="#000" stroke-width="2"/>')
    for i, top, bot in [(4, "A", "72"), (7, "C", ""), (9, "B", "192")]:
        s.append(f'<text x="{X(i)}" y="{oy-15}" font-size="17" text-anchor="middle" font-style="italic">{top}</text>')
        if bot:
            s.append(f'<text x="{X(i)}" y="{oy+27}" font-size="15" text-anchor="middle">{bot}</text>')
    s.append('</svg>')
    return "".join(s)
SVG2 = _numline()

# úloha 6: obrazce A (schod), B, C (trojúhelník), D (lichoběžník) – schematicky
SVG6 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 185" font-family="sans-serif">
<rect x="20" y="30" width="46" height="26" fill="none" stroke="#000"/>
<rect x="20" y="56" width="91" height="26" fill="none" stroke="#000"/>
<rect x="65" y="82" width="46" height="26" fill="none" stroke="#000"/>
<text x="65" y="128" font-size="14" text-anchor="middle">Obrazec A</text>
<rect x="150" y="30" width="26" height="91" fill="none" stroke="#000"/>
<rect x="104" y="95" width="46" height="26" fill="none" stroke="#000"/>
<rect x="176" y="56" width="46" height="26" fill="none" stroke="#000"/>
<text x="163" y="140" font-size="14" text-anchor="middle">Obrazec B</text>
<polygon points="256,30 300,30 300,110 283,155" fill="none" stroke="#000"/>
<line x1="283" y1="30" x2="283" y2="110" stroke="#000"/>
<line x1="283" y1="110" x2="300" y2="110" stroke="#000"/>
<text x="280" y="172" font-size="14" text-anchor="middle">Obrazec C</text>
<polygon points="345,30 430,30 410,112 367,112" fill="none" stroke="#000"/>
<line x1="371" y1="30" x2="379" y2="112" stroke="#000"/>
<line x1="404" y1="30" x2="398" y2="112" stroke="#000"/>
<text x="388" y="132" font-size="14" text-anchor="middle">Obrazec D</text>
</svg>"""

# úloha 7.1: výchozí obrázek – polopřímka PX a bod S
SVG71 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 250" font-family="sans-serif">
<line x1="40" y1="120" x2="430" y2="188" stroke="#000" stroke-width="2"/>
<line x1="40" y1="111" x2="40" y2="129" stroke="#000" stroke-width="2"/>
<text x="28" y="142" font-size="16" font-style="italic">P</text>
<line x1="322" y1="140" x2="332" y2="160" stroke="#000" stroke-width="2"/>
<text x="322" y="178" font-size="16" font-style="italic">X</text>
<text x="216" y="62" font-size="16" font-style="italic">S</text>
<text x="211" y="80" font-size="16">×</text>
</svg>"""

# úloha 7.2: výchozí obrázek – přímka p a úsečka AB
SVG72 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 275" font-family="sans-serif">
<line x1="70" y1="70" x2="410" y2="150" stroke="#000" stroke-width="2"/>
<text x="418" y="156" font-size="16" font-style="italic">p</text>
<line x1="110" y1="240" x2="360" y2="240" stroke="#000" stroke-width="2"/>
<line x1="180" y1="233" x2="180" y2="247" stroke="#000" stroke-width="2"/>
<text x="176" y="266" font-size="16" font-style="italic">A</text>
<line x1="290" y1="233" x2="290" y2="247" stroke="#000" stroke-width="2"/>
<text x="286" y="266" font-size="16" font-style="italic">B</text>
</svg>"""

# úloha 8: sloupcový graf (Dívky, Chlapci) x (Škola A tmavá, Škola B světlá)
def _bars8():
    x0, y0 = 60, 300; sc = 1.8; bw = 34
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 350" font-family="sans-serif">']
    s.append(f'<line x1="{x0}" y1="30" x2="{x0}" y2="{y0}" stroke="#000"/><line x1="{x0}" y1="{y0}" x2="430" y2="{y0}" stroke="#000"/>')
    for v in range(0, 141, 20):
        y = y0 - v * sc
        s.append(f'<line x1="{x0-4}" y1="{y}" x2="{x0}" y2="{y}" stroke="#000"/><text x="{x0-8}" y="{y+4}" font-size="11" text-anchor="end">{v}</text>')
    gx = x0 + 44
    for name, va, vb in [("Dívky", 90, 80), ("Chlapci", 60, 120)]:
        s.append(f'<rect x="{gx}" y="{y0-va*sc:.0f}" width="{bw}" height="{va*sc:.0f}" fill="#1a1a1a" stroke="#000"/>')
        s.append(f'<rect x="{gx+bw+6}" y="{y0-vb*sc:.0f}" width="{bw}" height="{vb*sc:.0f}" fill="#c9c9c9" stroke="#000"/>')
        s.append(f'<text x="{gx+bw}" y="{y0+16}" font-size="13" text-anchor="middle">{name}</text>')
        gx += 2 * bw + 74
    s.append('<text x="30" y="170" font-size="12" text-anchor="middle" transform="rotate(-90 30 170)">Počet dětí</text>')
    s.append('<rect x="360" y="60" width="13" height="13" fill="#1a1a1a" stroke="#000"/><text x="379" y="71" font-size="12">Škola A</text>')
    s.append('<rect x="360" y="82" width="13" height="13" fill="#c9c9c9" stroke="#000"/><text x="379" y="93" font-size="12">Škola B</text>')
    s.append('</svg>')
    return "".join(s)
SVG8 = _bars8()

# úlohy 9 a 10: tabulka bodů (některé údaje chybí)
def _table910():
    cols = [82, 78, 78, 78, 78]; xs = [10]
    for w in cols:
        xs.append(xs[-1] + w)
    ys = [10, 42, 74, 106, 138]
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 410 158" font-family="sans-serif">']
    for x in xs:
        s.append(f'<line x1="{x}" y1="{ys[0]}" x2="{x}" y2="{ys[-1]}" stroke="#000"/>')
    for y in ys:
        s.append(f'<line x1="{xs[0]}" y1="{y}" x2="{xs[-1]}" y2="{y}" stroke="#000"/>')
    def cell(c, r, t, bold=False):
        cx = (xs[c] + xs[c + 1]) / 2; cy = (ys[r] + ys[r + 1]) / 2 + 4
        w = ' font-weight="bold"' if bold else ''
        s.append(f'<text x="{cx:.0f}" y="{cy:.0f}" font-size="11" text-anchor="middle"{w}>{t}</text>')
    for c, t in enumerate(["Třída", "1. kolo", "2. kolo", "3. kolo", "Součet"]):
        cell(c, 0, t, True)
    cell(0, 1, "5. A"); cell(1, 1, "34"); cell(3, 1, "52")
    cell(0, 2, "5. B"); cell(4, 2, "138")
    cell(0, 3, "Obě třídy")
    s.append('</svg>')
    return "".join(s)
SVG910 = _table910()

# úloha 12: pět tmavých útvarů A–E ve čtvercové síti (schematicky)
def _grid12():
    c = 16; ox = 15; oy = 25; cols = 27; rows = 6
    W = ox * 2 + cols * c; H = oy + rows * c + 18
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {W} {H}" font-family="sans-serif">']
    for i in range(cols + 1):
        s.append(f'<line x1="{ox+i*c}" y1="{oy}" x2="{ox+i*c}" y2="{oy+rows*c}" stroke="#dcdcdc"/>')
    for j in range(rows + 1):
        s.append(f'<line x1="{ox}" y1="{oy+j*c}" x2="{ox+cols*c}" y2="{oy+j*c}" stroke="#dcdcdc"/>')
    def plus(col, row, label):
        X = ox + col * c; Y = oy + row * c
        pts = [(X-c, Y-c/2), (X-c, Y+c/2), (X-c/2, Y+c/2), (X-c/2, Y+c), (X+c/2, Y+c),
               (X+c/2, Y+c/2), (X+c, Y+c/2), (X+c, Y-c/2), (X+c/2, Y-c/2), (X+c/2, Y-c),
               (X-c/2, Y-c), (X-c/2, Y-c/2)]
        p = " ".join(f"{a:.0f},{b:.0f}" for a, b in pts)
        s.append(f'<polygon points="{p}" fill="#9a9a9a" stroke="#000"/>')
        s.append(f'<text x="{X:.0f}" y="{Y+5:.0f}" font-size="12" text-anchor="middle" font-weight="bold">{label}</text>')
    def irr(col, row, label):
        X = ox + col * c; Y = oy + row * c
        pts = [(X-c, Y-c), (X+c/2, Y-c), (X+c/2, Y-c/2), (X+c, Y-c/2), (X+c, Y+c/2),
               (X, Y+c/2), (X, Y+c), (X-c, Y+c)]
        p = " ".join(f"{a:.0f},{b:.0f}" for a, b in pts)
        s.append(f'<polygon points="{p}" fill="#9a9a9a" stroke="#000"/>')
        s.append(f'<text x="{X:.0f}" y="{Y+5:.0f}" font-size="12" text-anchor="middle" font-weight="bold">{label}</text>')
    plus(3, 3, "A"); plus(8, 3, "B"); plus(13, 3, "C"); plus(18, 3, "D"); irr(23, 3, "E")
    s.append('</svg>')
    return "".join(s)
SVG12 = _grid12()

# úloha 13: tabulky staveb (ukázka a 3 stavby), K, L, M zvýrazněny
def _tab13():
    c = 28; oy = 44; ox = 12; gap = 26
    tabs = [("1. stavba", [["5", "K", "3"], ["1", "3", "2"], ["", "2", ""]]),
            ("2. stavba", [["10", "1", "7"], ["", "5", ""], ["2", "L", "6"]]),
            ("3. stavba", [["7", "3", ""], ["", "M", "6"], ["4", "8", "7"]])]
    tw = 3 * c
    W = ox * 2 + 3 * tw + 2 * gap; H = oy + 3 * c + 18
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {W} {H}" font-family="sans-serif">']
    x = ox
    for title, grid in tabs:
        s.append(f'<text x="{x+tw/2:.0f}" y="{oy-14}" font-size="13" text-anchor="middle">{title}</text>')
        for r in range(3):
            for col in range(3):
                v = grid[r][col]
                if v == "":
                    continue
                cx = x + col * c; cy = oy + r * c
                hl = v in ("K", "L", "M")
                fill = "#cfcfcf" if hl else "#ffffff"
                s.append(f'<rect x="{cx:.0f}" y="{cy}" width="{c}" height="{c}" fill="{fill}" stroke="#000"/>')
                fw = ' font-weight="bold"' if hl else ''
                s.append(f'<text x="{cx+c/2:.0f}" y="{cy+c*0.66:.0f}" font-size="13" text-anchor="middle"{fw}>{v}</text>')
        x += tw + gap
    s.append('</svg>')
    return "".join(s)
SVG13 = _tab13()

# úloha 14: dvě lišty se žárovkami (kratší 4, delší 6); na počátku nesvítí
def _lights14():
    d = 22; r = 8
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 270 120" font-family="sans-serif">']
    s.append('<text x="10" y="36" font-size="12">kratší lišta:</text>')
    for i in range(4):
        fill = "#9a9a9a" if i == 0 else "#ffffff"
        s.append(f'<circle cx="{110+i*d}" cy="32" r="{r}" fill="{fill}" stroke="#000"/>')
    s.append('<text x="10" y="86" font-size="12">delší lišta:</text>')
    for i in range(6):
        fill = "#9a9a9a" if i == 0 else "#ffffff"
        s.append(f'<circle cx="{110+i*d}" cy="82" r="{r}" fill="{fill}" stroke="#000"/>')
    s.append('</svg>')
    return "".join(s)
SVG14 = _lights14()

B = ['zs1']  # 5. ročník ZŠ (přijímačky na osmileté obory); kód r5 v taxonomii není

PROBLEMS = [
    {'name': 'CERMAT M5B 2021 – úloha 1.1', 'zad': ['Vypočtěte: $5+15\\cdot(10-4)-15:5=$'], 'opts': None, 'ln': 2,
     'sol': ['Podle pořadí operací: $5+15\\cdot 6-3=5+90-3=92$.'], 'ans': '$92$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5B 2021 – úloha 1.2', 'zad': ['Vypočtěte: $55\\cdot 16+45\\cdot 16-50\\cdot 16=$'], 'opts': None, 'ln': 2,
     'sol': ['Vytkneme $16$: $16\\cdot(55+45-50)=16\\cdot 50=800$.'], 'ans': '$800$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5B 2021 – úloha 2', 'zad': [
        'Na číselné ose je zobrazeno deset stejných dílků, číslo $A=72$, číslo $B=192$ a neznámé číslo $C$ (viz obrázek).',
        '2.1 Určete číslo $C$.',
        '2.2 K odpovídajícímu bodu číselné osy zapište číslo $0$ a bod na ose zvýrazněte.'],
     'opts': None, 'ln': 2, 'svg': SVG2, 'fn': 'osa.svg',
     'alt': 'Číselná osa s deseti stejnými dílky; body A (72), C a B (192).', 'cap': 'Číselná osa k úloze 2',
     'sol': ['Deset dílků, mezi $A=72$ a $B=192$ jsou tři dílky k $C$ a dva dílky dále k $B$; jeden dílek $=(192-72):5=24$.',
             '2.1 $C=72+3\\cdot 24=144$.',
             '2.2 Číslo $0$ odpovídá bodu o tři dílky vlevo od $A$ (o hodnotu $72$).'],
     'ans': '2.1: $C=144$; 2.2: bod $0$ leží o tři dílky vlevo od bodu $A$ (viz obrázek v klíči)',
     'pts': 3, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'porozumeni', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5B 2021 – úloha 3.1', 'zad': [
        'Kabel dlouhý $13$ m a $8$ cm rozdělíme na šest stejných dílů.',
        'Vypočtěte v cm délku jednoho dílu.'], 'opts': None, 'ln': 2,
     'sol': ['$13$ m $8$ cm $=1308$ cm; jeden díl $=1308:6=218$ cm.'], 'ans': '$218$ cm', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5B 2021 – úloha 3.2', 'zad': [
        'Při příjezdu na letiště bylo ohlášené zpoždění odletu letadla $1$ hodina a $50$ minut, ale nakonec bylo zpoždění šestkrát delší.',
        'Vypočtěte v hodinách, jaké bylo nakonec zpoždění odletu letadla.'], 'opts': None, 'ln': 2,
     'sol': ['$1$ h $50$ min $=110$ min; šestkrát delší $=6\\cdot 110=660$ min $=11$ hodin.'], 'ans': '$11$ hodin', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5B 2021 – úloha 4', 'zad': [
        'V dětské hře se smí provádět pouze tyto nákupy: za $5$ mincí lze koupit $6$ panáčků, za $20$ mincí lze koupit $9$ zvířátek.',
        '4.1 Žofie koupila $12$ panáčků a určitý počet zvířátek. Za panáčky a zvířátka zaplatila celkem $90$ mincí. Určete, kolik zvířátek koupila.',
        '4.2 Pepa si chce koupit stejný počet panáčků jako zvířátek. Určete nejmenší počet mincí, které k takovému nákupu potřebuje.'],
     'opts': None, 'ln': 3,
     'sol': ['4.1 $12$ panáčků $=2\\cdot 6$, tj. $2\\cdot 5=10$ mincí. Na zvířátka zbývá $90-10=80$ mincí $=4\\cdot 20$, tedy $4\\cdot 9=36$ zvířátek.',
             '4.2 Stejný počet panáčků i zvířátek musí být dělitelný $6$ i $9$, nejmenší je $18$. $18$ panáčků $=3\\cdot 5=15$ mincí, $18$ zvířátek $=2\\cdot 20=40$ mincí, celkem $55$ mincí.'],
     'ans': '4.1: $36$ zvířátek; 4.2: $55$ mincí', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5B 2021 – úloha 5', 'zad': [
        'V zelené krabičce jsou jen zelené kuličky, v bílé jen bílé a v modré jen modré. Dohromady je v nich $180$ kuliček. Modrých kuliček je o $10$ více než bílých. Aby byl ve všech třech krabičkách stejný počet kuliček, ze zelené krabičky vyndáme $40$ kuliček a rozdělíme je do zbývajících dvou krabiček.',
        '5.1 Určete počet všech zelených kuliček.',
        '5.2 Určete, kolik zelených kuliček přendáme do bílé krabičky.',
        '5.3 Určete počet všech modrých kuliček.'], 'opts': None, 'ln': 3,
     'sol': ['Stejný počet ve všech třech krabičkách je $180:3=60$. Zelená krabička má po odebrání $40$ kuliček $60$, proto zelených je $60+40=100$.',
             'Bílých $b$, modrých $b+10$; do bílé a modré se rozdělí $40$: $(60-b)+(60-(b+10))=40$, odtud $b=35$, modrých $45$.',
             '5.1 $100$ zelených; 5.2 do bílé přendáme $60-35=25$ zelených; 5.3 modrých je $45$.'],
     'ans': '5.1: $100$ zelených kuliček; 5.2: $25$ zelených kuliček; 5.3: $45$ modrých kuliček',
     'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5B 2021 – úloha 6', 'zad': [
        'Každý velký obdélník má rozměry $2$ cm a $7$ cm a obsah $14$ cm². Rozstřižením velkého obdélníku vznikne buď dvojice menších obdélníků (1. dvojice), nebo dvojice shodných trojúhelníků (2. dvojice). Každý z obrazců A, B, C, D je sestaven z jednoho velkého obdélníku a z 1. nebo 2. dvojice (viz obrázek).',
        '6.1 Vypočtěte v cm² obsah obrazce A.',
        '6.2 Vypočtěte v cm obvod obrazce A.',
        '6.3 Vypočtěte v cm obvod obrazce B.',
        '6.4 Vypočtěte, o kolik cm se liší obvody obrazců C a D.'],
     'opts': None, 'ln': 4, 'svg': SVG6, 'fn': 'obrazce.svg',
     'alt': 'Obrazce A, B, C, D sestavené z velkého obdélníku a z dvojice menších obdélníků nebo trojúhelníků.',
     'cap': 'Obrazce A–D (schematicky)',
     'sol': ['6.1 Obrazec A tvoří velký obdélník ($14$ cm²) a 1. dvojice, která má také obsah $14$ cm². Obsah $=14+14=28$ cm².',
             '6.2 Obrazec A je schodovitý útvar z obdélníků $2$ cm × $7$ cm a dvou obdélníků $2$ cm × $3{,}5$ cm; jeho obvod je $26$ cm.',
             '6.3 Obrazec B je složen ze stejných obdélníků v jiném uspořádání; jeho obvod je $32$ cm.',
             '6.4 Obrazce C a D jsou sestaveny z velkého obdélníku a 2. dvojice (dvou trojúhelníků); jejich obvody se liší o $10$ cm.'],
     'ans': '6.1: $28$ cm²; 6.2: $26$ cm; 6.3: $32$ cm; 6.4: o $10$ cm', 'pts': 4, 'mins': 7, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5B 2021 – úloha 7.1 (konstrukce)', 'zad': [
        'V rovině leží polopřímka $PX$ a bod $S$ (viz obrázek).',
        'Bod $S$ je střed jedné strany obdélníku $ABCD$. Na polopřímce $PX$ leží strana $AB$ tohoto obdélníku a její délka je dvakrát větší než délka sousední strany $BC$.',
        'Sestrojte vrcholy obdélníku $ABCD$, označte je písmeny a obdélník narýsujte. Najděte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG71, 'fn': 'poloprimka-S.svg',
     'alt': 'Polopřímka PX a bod S ležící nad ní.', 'cap': 'Výchozí obrázek k úloze 7.1',
     'sol': ['Bod $S$ je střed jedné strany obdélníku a platí $|AB|=2\\cdot|BC|$. Úloha má dvě řešení podle toho, které strany je $S$ středem; sestrojí se dva obdélníky $A_1B_1C_1D_1$ a $A_2B_2C_2D_2$ se stranou $AB$ na polopřímce $PX$ (viz obrázek v klíči).'],
     'ans': 'Dvě řešení – obdélníky $A_1B_1C_1D_1$ a $A_2B_2C_2D_2$ se stranou $AB$ na polopřímce $PX$, $|AB|=2\\cdot|BC|$, bod $S$ střed jedné strany (viz obrázek v klíči).',
     'pts': 3, 'mins': 6, 'diff': '4', 'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5B 2021 – úloha 7.2 (konstrukce)', 'zad': [
        'V rovině leží přímka $p$ a úsečka $AB$ (viz obrázek).',
        'Úsečka $AB$ tvoří jednu stranu rovnostranného trojúhelníku $ABC$. Vrchol $C$ trojúhelníku $ABC$ je současně vrcholem trojúhelníku $CDE$. Strany $CD$ a $CE$ trojúhelníku $CDE$ mají stejnou délku jako úsečka $AB$. Strana $DE$ leží na přímce $p$.',
        'Sestrojte vrcholy $C$, $D$, $E$ trojúhelníku $CDE$, označte je písmeny a trojúhelník narýsujte.'],
     'opts': None, 'ln': 0, 'svg': SVG72, 'fn': 'primka-AB.svg',
     'alt': 'Přímka p a pod ní úsečka AB s krajními body A a B.', 'cap': 'Výchozí obrázek k úloze 7.2',
     'sol': ['Sestrojíme rovnostranný trojúhelník $ABC$ (vrchol $C$ jako průsečík oblouků o poloměru $|AB|$ se středy $A$ a $B$). Z bodu $C$ narýsujeme kružnici o poloměru $|AB|$; její průsečíky s přímkou $p$ jsou body $D$ a $E$. Trojúhelník $CDE$ je rovnoramenný s $|CD|=|CE|=|AB|$ a stranou $DE$ na přímce $p$.'],
     'ans': 'Konstrukce: rovnostranný trojúhelník $ABC$, poté $D$, $E$ jako průsečíky kružnice se středem $C$ a poloměrem $|AB|$ s přímkou $p$ (viz obrázek v klíči).',
     'pts': 3, 'mins': 6, 'diff': '3', 'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5B 2021 – úloha 8', 'zad': [
        'V grafu jsou znázorněny počty dívek a počty chlapců v jazykových školách A a B. Ve škole A je v každé třídě $10$ dětí a ve škole B je v každé třídě $20$ dětí (viz graf).',
        'Rozhodněte o každém z následujících tvrzení (8.1–8.3), zda je pravdivé (A), či nikoli (N).',
        '8.1 Ve škole A je o polovinu méně chlapců než ve škole B.',
        '8.2 Ve škole B je o třetinu více chlapců než dívek.',
        '8.3 Ve škole B je o třetinu méně tříd než ve škole A.'],
     'opts': None, 'ln': 0, 'svg': SVG8, 'fn': 'graf-skoly.svg',
     'alt': 'Sloupcový graf počtů dívek a chlapců ve školách A a B.', 'cap': 'Počty dětí ve školách A a B',
     'sol': ['8.1 Chlapců ve škole A je $60$, ve škole B $120$; $60$ je polovina ze $120$, tvrzení platí → Ano.',
             '8.2 Ve škole B je $120$ chlapců a $80$ dívek; $120$ je o polovinu (ne o třetinu) více → Ne.',
             '8.3 Škola A: $90+60=150$ dětí po $10$ → $15$ tříd; škola B: $80+120=200$ dětí po $20$ → $10$ tříd; $10$ je o třetinu méně než $15$ → Ano.'],
     'ans': '8.1: Ano; 8.2: Ne; 8.3: Ano', 'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['statistika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5B 2021 – úloha 9', 'zad': [
        'Třídy 5. A a 5. B se zúčastnily soutěže o třech kolech. V tabulce jsou počty bodů získané v jednotlivých kolech, některé údaje chybí (viz tabulka).',
        'Třída 5. A získala nejméně bodů v 1. kole a nejvíce bodů ve 3. kole. Počet bodů získaných ve 2. kole se od obou zbývajících kol liší o stejný počet bodů.',
        'Kolik bodů získaly dohromady obě třídy?'],
     'opts': ['A) méně než 264 bodů', 'B) 264 bodů', 'C) 267 bodů', 'D) 270 bodů', 'E) více než 270 bodů'],
     'ln': 0, 'svg': SVG910, 'fn': 'tabulka-body.svg',
     'alt': 'Tabulka bodů tříd 5. A a 5. B ve třech kolech; některé buňky jsou prázdné.', 'cap': 'Body v soutěži (k úlohám 9 a 10)',
     'sol': ['Ve 2. kole se 5. A liší od $34$ i od $52$ stejně, tedy $\\frac{34+52}{2}=43$. Součet 5. A $=34+43+52=129$. Obě třídy $=129+138=267$ bodů.'],
     'ans': 'C) 267 bodů', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5B 2021 – úloha 10', 'zad': [
        'Třídy 5. A a 5. B se zúčastnily soutěže o třech kolech (viz tabulka).',
        'Třída 5. B získala ve 2. kole o $6$ bodů méně než v 1. kole a ve 3. kole dvakrát více bodů než v 1. kole.',
        'Kolik bodů získaly dohromady obě třídy v 1. kole soutěže?'],
     'opts': ['A) 67 bodů', 'B) 70 bodů', 'C) 78 bodů', 'D) 82 bodů', 'E) jiný počet bodů'],
     'ln': 0, 'svg': SVG910, 'fn': 'tabulka-body.svg',
     'alt': 'Tabulka bodů tříd 5. A a 5. B ve třech kolech; některé buňky jsou prázdné.', 'cap': 'Body v soutěži (k úlohám 9 a 10)',
     'sol': ['5. B v 1. kole $b$: $b+(b-6)+2b=138$, tj. $4b=144$, $b=36$. Obě třídy v 1. kole $=34+36=70$ bodů.'],
     'ans': 'B) 70 bodů', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5B 2021 – úloha 11', 'zad': [
        'Na $23$denní tábor přivezl vedoucí malým skautům $16$ sáčků po $30$ bonbonech. Během tábora dal každému malému skautovi celkem $21$ bonbonů, a zbyly mu tak už jen bonbony v posledním načatém sáčku.',
        'Kolik bonbonů zbylo vedoucímu v posledním načatém sáčku?'],
     'opts': ['A) 18', 'B) 19', 'C) 20', 'D) 21', 'E) 22'], 'ln': 0,
     'sol': ['Celkem $16\\cdot 30=480$ bonbonů. $480=21\\cdot 22+18$, tj. $22$ skautům dal po $21$ bonbonech (celkem $462$) a v posledním načatém sáčku zbylo $18$ bonbonů.'],
     'ans': 'A) 18', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5B 2021 – úloha 12', 'zad': [
        'Ve čtvercové síti leží pět tmavých útvarů A–E. Vrcholy všech útvarů leží v mřížových bodech. Některé útvary jsou souměrné podle osy (svislé, vodorovné nebo šikmé).',
        'Který útvar není souměrný podle žádné osy?'],
     'opts': ['A) útvar A', 'B) útvar B', 'C) útvar C', 'D) útvar D', 'E) útvar E'],
     'ln': 0, 'svg': SVG12, 'fn': 'utvary-sit.svg',
     'alt': 'Pět tmavých útvarů A–E ve čtvercové síti (schematicky).', 'cap': 'Útvary A–E ve čtvercové síti',
     'sol': ['Útvary A, B, C, D mají alespoň jednu osu souměrnosti; útvar E nemá žádnou osu souměrnosti.'],
     'ans': 'E) útvar E', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['planimetrie', 'porozumeni', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5B 2021 – úloha 13', 'zad': [
        'Na podložce stavíme stavby ze stejně velkých krychliček. Číslo v tabulce udává počet krychliček ve sloupci nad sebou (počet pater). V tabulkách tří staveb jsou kartičkami K, L a M zakryta tři čísla (viz obrázek).',
        'Přiřaďte ke každé otázce (13.1–13.3) správnou odpověď (A–F).',
        '13.1 V 1. stavbě je celkem $24$ krychliček. Jaké číslo je zakryto kartičkou K?',
        '13.2 Ve 2. stavbě se počet krychliček v 5. a 6. patře liší o $2$ krychličky. Jaké číslo je zakryto kartičkou L?',
        '13.3 Ve 3. stavbě je v nejvyšších třech patrech celkem $9$ krychliček. Jaké číslo je zakryto kartičkou M?'],
     'opts': ['A) menší než 4', 'B) 4', 'C) 5', 'D) 6', 'E) 7', 'F) větší než 7'],
     'ln': 0, 'svg': SVG13, 'fn': 'stavby.svg',
     'alt': 'Tabulky ukázkové stavby a tří staveb s počty pater; v tabulkách jsou zakryta čísla K, L, M.', 'cap': 'Tabulky staveb k úloze 13',
     'sol': ['13.1 Součet čísel v 1. stavbě $=5+K+3+1+3+2+2=16+K=24$, tedy $K=8$ (větší než 7) → F.',
             '13.2 V 5. patře jsou sloupce s výškou aspoň $5$, v 6. patře s výškou aspoň $6$. Rozdíl je $2$ pouze pro $L=5$ → C.',
             '13.3 Tři nejvyšší patra (6., 7. a 8.) mají dohromady $9$ krychliček jen pro $M=6$ → D.'],
     'ans': '13.1: F ($K=8$); 13.2: C ($L=5$); 13.3: D ($M=6$)', 'pts': 5, 'mins': 7, 'diff': '3',
     'codes': B + ['stereometrie', 'porozumeni', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5B 2021 – úloha 14', 'zad': [
        'Na kratší liště jsou $4$ žárovky a na delší liště je $6$ žárovek; na počátku žádná žárovka nesvítí. V 1. sekundě se na obou lištách rozsvítí první žárovka zleva, ve 2. sekundě ještě druhá atd. Jakmile jsou na liště rozsvíceny všechny žárovky, od další sekundy postupně zhasínají ve stejném pořadí; jakmile zhasnou všechny, od další sekundy se opět rozsvěcují. Cyklus se u každé lišty stále opakuje (viz obrázek).',
        'Určete:',
        '14.1 v kolikáté sekundě bude poprvé na kratší liště rozsvíceno více žárovek než na delší liště,',
        '14.2 kolik žárovek bude rozsvíceno na delší liště v 57. sekundě,',
        '14.3 kolik žárovek bude dohromady rozsvíceno na obou lištách v 91. sekundě.'],
     'opts': None, 'ln': 3, 'svg': SVG14, 'fn': 'zarovky.svg',
     'alt': 'Kratší lišta se čtyřmi a delší lišta se šesti žárovkami; na počátku svítí první žárovka zleva.', 'cap': 'Dvě lišty se žárovkami',
     'sol': ['Kratší lišta má periodu $8$ s s počty žárovek $1,2,3,4,3,2,1,0$; delší lišta periodu $12$ s s počty $1,2,3,4,5,6,5,4,3,2,1,0$.',
             '14.1 Porovnáním počtů je kratší lišta poprvé napřed v 11. sekundě (kratší $3$, delší $1$).',
             '14.2 $57=4\\cdot 12+9$; v 9. kroku periody delší lišty svítí $3$ žárovky.',
             '14.3 $91=11\\cdot 8+3$ → kratší $3$; $91=7\\cdot 12+7$ → delší $5$; dohromady $3+5=8$ žárovek.'],
     'ans': '14.1: v 11. sekundě; 14.2: 3 žárovky; 14.3: 8 žárovek', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['posloupnosti', 'modelovani', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M5PBD21C0T02'
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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M5B-2021')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
