# -*- coding: utf-8 -*-
# CERMAT - Jednotna prijimaci zkouska 2024, MATEMATIKA 9B (ctyrlete obory, 9. rocnik).
# Kod testu: M9PBD24C0T02. 16 uloh (po rozdeleni nezavislych poduloh 20 uloh).
# Zdroj odpovedi: klic spravnych reseni (KSR).

# ---- SVG obrazky (bez ' a \) ----

# uloha 2: obdelnik/pravouhly trojuhelnik A-B-C, cesta Adama (A->B->C) a Oty (A->C)
SVG2 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 380 280" font-family="sans-serif">
<rect x="70" y="50" width="240" height="160" fill="#e2e2e2" stroke="#000" stroke-width="2"/>
<line x1="70" y1="210" x2="310" y2="50" stroke="#000" stroke-width="2"/>
<rect x="294" y="194" width="16" height="16" fill="none" stroke="#000"/>
<text x="56" y="226" font-size="16" font-style="italic">A</text>
<text x="308" y="228" font-size="16" font-style="italic">B</text>
<text x="314" y="46" font-size="16" font-style="italic">C</text>
<text x="190" y="228" font-size="14" text-anchor="middle">40 m</text>
<text x="320" y="134" font-size="14">30 m</text>
<text x="150" y="120" font-size="14">Ota</text>
<text x="205" y="202" font-size="14">Adam</text>
</svg>"""

# uloha 6: lichobeznik ABCD, uhlopricka BD je vyska (pravy uhel u B)
SVG6 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 280" font-family="sans-serif">
<polygon points="60,220 320,220 430,80 320,80" fill="none" stroke="#000" stroke-width="2"/>
<line x1="320" y1="220" x2="320" y2="80" stroke="#000" stroke-width="1.5" stroke-dasharray="5 5"/>
<rect x="304" y="204" width="16" height="16" fill="none" stroke="#000"/>
<text x="46" y="236" font-size="16" font-style="italic">A</text>
<text x="322" y="238" font-size="16" font-style="italic">B</text>
<text x="436" y="76" font-size="16" font-style="italic">C</text>
<text x="304" y="72" font-size="16" font-style="italic">D</text>
</svg>"""

# uloha 8: obrazce z velkych bilych a malych tmavych kruhu (1., 2., 3. obrazec)
def _pattern8():
    sp = 36
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 200" font-family="sans-serif">']
    s.append('<circle cx="60" cy="110" r="18" fill="#fff" stroke="#000" stroke-width="2"/>')
    s.append('<text x="60" y="40" font-size="14" text-anchor="middle" font-weight="bold">1. obrazec</text>')
    bx, by = 170, 92
    for i in range(2):
        for j in range(2):
            s.append(f'<circle cx="{bx+i*sp}" cy="{by+j*sp}" r="18" fill="#fff" stroke="#000" stroke-width="2"/>')
    s.append(f'<circle cx="{bx+18}" cy="{by+18}" r="6" fill="#8a8a8a" stroke="#000"/>')
    s.append('<text x="188" y="40" font-size="14" text-anchor="middle" font-weight="bold">2. obrazec</text>')
    cx0, cy0 = 320, 74
    for i in range(3):
        for j in range(3):
            s.append(f'<circle cx="{cx0+i*sp}" cy="{cy0+j*sp}" r="18" fill="#fff" stroke="#000" stroke-width="2"/>')
    for i in range(2):
        for j in range(2):
            s.append(f'<circle cx="{cx0+18+i*sp}" cy="{cy0+18+j*sp}" r="6" fill="#8a8a8a" stroke="#000"/>')
    s.append('<text x="356" y="40" font-size="14" text-anchor="middle" font-weight="bold">3. obrazec</text>')
    s.append('<text x="470" y="120" font-size="22">...</text>')
    s.append('</svg>')
    return "".join(s)
SVG8 = _pattern8()

# uloha 9: tri dane body A, O, B
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 240" font-family="sans-serif">
<rect x="4" y="4" width="452" height="232" fill="none" stroke="#bbb"/>
<text x="215" y="96" font-size="15" font-style="italic">A</text>
<text x="211" y="112" font-size="15">x</text>
<text x="70" y="130" font-size="15" font-style="italic">O</text>
<text x="66" y="146" font-size="15">x</text>
<text x="362" y="130" font-size="15" font-style="italic">B</text>
<text x="358" y="146" font-size="15">x</text>
</svg>"""

# uloha 10: kruznice k se stredem S a body K, L
SVG10 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 380 320" font-family="sans-serif">
<rect x="4" y="4" width="372" height="312" fill="none" stroke="#bbb"/>
<circle cx="200" cy="140" r="110" fill="none" stroke="#000" stroke-width="2"/>
<text x="118" y="78" font-size="15" font-style="italic">k</text>
<text x="200" y="144" font-size="16">+</text>
<text x="214" y="138" font-size="15" font-style="italic">S</text>
<text x="88" y="230" font-size="15" font-style="italic">K</text>
<text x="104" y="232" font-size="15">x</text>
<text x="248" y="288" font-size="15">x</text>
<text x="262" y="290" font-size="15" font-style="italic">L</text>
</svg>"""

# uloha 13: primky k, l, m, n a trojuhelnik ABC s vyznacenymi uhly (ilustracni)
SVG13 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 490 260" font-family="sans-serif">
<line x1="88" y1="240" x2="182" y2="26" stroke="#000" stroke-width="1.6"/>
<line x1="120" y1="56" x2="452" y2="168" stroke="#000" stroke-width="1.6"/>
<line x1="66" y1="216" x2="462" y2="136" stroke="#000" stroke-width="1.6"/>
<line x1="400" y1="40" x2="400" y2="216" stroke="#000" stroke-width="1.6"/>
<text x="186" y="26" font-size="15" font-style="italic">k</text>
<text x="458" y="174" font-size="15" font-style="italic">l</text>
<text x="466" y="132" font-size="15" font-style="italic">m</text>
<text x="392" y="34" font-size="15" font-style="italic">n</text>
<text x="150" y="76" font-size="14" font-style="italic">C</text>
<text x="92" y="222" font-size="14" font-style="italic">A</text>
<text x="406" y="168" font-size="14" font-style="italic">B</text>
<text x="152" y="100" font-size="13">125°</text>
<text x="106" y="204" font-size="13">105°</text>
<text x="358" y="152" font-size="13">90°</text>
<text x="372" y="126" font-size="15" font-style="italic">a</text>
</svg>"""

# uloha 14: ctvercova sit se sedym pulkruhem, prumer AB, strana ctverce 2 cm
SVG14 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 300 220" font-family="sans-serif">
<path d="M 60 80 A 80 80 0 0 0 220 80 Z" fill="#b9b9b9" stroke="#000" stroke-width="1.5"/>
<g stroke="#000" stroke-width="1">
<line x1="60" y1="40" x2="220" y2="40"/>
<line x1="60" y1="80" x2="220" y2="80"/>
<line x1="60" y1="120" x2="220" y2="120"/>
<line x1="60" y1="160" x2="220" y2="160"/>
<line x1="60" y1="200" x2="220" y2="200"/>
<line x1="60" y1="40" x2="60" y2="200"/>
<line x1="100" y1="40" x2="100" y2="200"/>
<line x1="140" y1="40" x2="140" y2="200"/>
<line x1="180" y1="40" x2="180" y2="200"/>
<line x1="220" y1="40" x2="220" y2="200"/>
</g>
<text x="46" y="76" font-size="14" font-style="italic">A</text>
<text x="226" y="76" font-size="14" font-style="italic">B</text>
<line x1="240" y1="40" x2="240" y2="80" stroke="#000" stroke-width="1"/>
<text x="248" y="64" font-size="13">2 cm</text>
</svg>"""

# uloha 15: sloupcovy graf - chlapci (srafovane) a divky (sede)
def _bars15():
    cats = [('M', 7, 4), ('Cj', 2, 6), ('Aj', 5, 8), ('Tv', 7, 5), ('Vv', 4, 2)]
    x0, y0 = 60, 250
    unit, bw, gap = 24, 18, 22
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 300" font-family="sans-serif">']
    s.append('<defs><pattern id="hatch" width="6" height="6" patternUnits="userSpaceOnUse"><rect width="6" height="6" fill="#fff"/><line x1="0" y1="3" x2="6" y2="3" stroke="#000" stroke-width="1"/></pattern></defs>')
    s.append(f'<line x1="{x0}" y1="30" x2="{x0}" y2="{y0}" stroke="#000"/>')
    s.append(f'<line x1="{x0}" y1="{y0}" x2="430" y2="{y0}" stroke="#000"/>')
    for v in range(0, 10):
        y = y0 - v * unit
        s.append(f'<line x1="{x0-4}" y1="{y}" x2="{x0}" y2="{y}" stroke="#000"/><text x="{x0-8}" y="{y+4}" font-size="11" text-anchor="end">{v}</text>')
    x = x0 + gap
    for name, ch, di in cats:
        s.append(f'<rect x="{x}" y="{y0-ch*unit}" width="{bw}" height="{ch*unit}" fill="url(#hatch)" stroke="#000"/>')
        s.append(f'<rect x="{x+bw}" y="{y0-di*unit}" width="{bw}" height="{di*unit}" fill="#b0b0b0" stroke="#000"/>')
        s.append(f'<text x="{x+bw}" y="{y0+16}" font-size="12" text-anchor="middle">{name}</text>')
        x += 2 * bw + gap
    s.append('<rect x="335" y="40" width="14" height="14" fill="url(#hatch)" stroke="#000"/><text x="355" y="52" font-size="12">chlapci</text>')
    s.append('<rect x="335" y="60" width="14" height="14" fill="#b0b0b0" stroke="#000"/><text x="355" y="72" font-size="12">divky</text>')
    s.append('</svg>')
    return "".join(s)
SVG15 = _bars15()

# ---- Ulohy ----

B = ['zs2', 'r9']  # 9. rocnik ZS (ctyrlete obory)

PROBLEMS = [
    {'name': 'CERMAT M9B 2024 - uloha 1', 'zad': [
        'Josef ma delku kroku $75$ cm, Nada ma krok dlouhy $60$ cm. Josef i Nada kazdy usli $10\\,000$ kroku.',
        'O kolik kilometru usel Josef vice nez Nada?'],
     'opts': None, 'ln': 2,
     'sol': ['Josef: $75 \\cdot 10\\,000 = 750\\,000$ cm $=7{,}5$ km. Nada: $60 \\cdot 10\\,000 = 600\\,000$ cm $=6$ km. Rozdil: $7{,}5-6=1{,}5$ km.'],
     'ans': '$1{,}5$ km', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9B 2024 - uloha 2', 'zad': [
        'Adam a Ota jdou z mista $A$ do mista $C$. Kazdy jde jinou cestou tak, jak je vyznaceno na obrazku. Adam jde z mista $A$ do mista $C$ po rovnych silnicich pres misto $B$, Ota jde zkratkou primo z $A$ do $C$. Strana $AB$ meri $40$ m, strana $BC$ meri $30$ m a uhel u vrcholu $B$ je pravy.',
        'O kolik procent je Adamova cesta delsi nez cesta, kterou jde Ota?'],
     'opts': None, 'ln': 2, 'svg': SVG2, 'fn': 'cesta-adam-ota.svg',
     'alt': 'Obdelnikova mapa: Adam jde z A pres B do C po stranach 40 m a 30 m s pravym uhlem u B, Ota jde primo z A do C po uhlopricce.',
     'cap': 'Cesty Adama a Oty (schematicky nakres)',
     'sol': ['Otova cesta (uhlopricka): $\\sqrt{40^2+30^2}=\\sqrt{2500}=50$ m. Adamova cesta: $40+30=70$ m. Pomer $\\frac{70}{50}=1{,}4$, Adamova cesta je tedy o $40\\,\\%$ delsi.'],
     'ans': 'o $40\\,\\%$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9B 2024 - uloha 3.1', 'zad': [
        'Vypocitejte a vysledek zapiste zlomkem v zakladnim tvaru. Uvedte cely postup reseni.',
        '$\\left(\\frac{3}{4}+\\frac{4}{3}\\right)\\cdot\\left(\\frac{2}{3}-\\frac{6}{5}\\right)=$'],
     'opts': None, 'ln': 3,
     'sol': ['$\\frac{3}{4}+\\frac{4}{3}=\\frac{9+16}{12}=\\frac{25}{12}$, $\\frac{2}{3}-\\frac{6}{5}=\\frac{10-18}{15}=-\\frac{8}{15}$. Soucin: $\\frac{25}{12}\\cdot\\left(-\\frac{8}{15}\\right)=-\\frac{200}{180}=-\\frac{10}{9}$.'],
     'ans': '$-\\frac{10}{9}$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2024 - uloha 3.2', 'zad': [
        'Vypocitejte a vysledek zapiste zlomkem v zakladnim tvaru. Uvedte cely postup reseni.',
        '$\\frac{\\frac{5}{9}-\\frac{3}{2}:\\frac{3}{5}}{\\frac{2}{3}+\\frac{1}{6}-\\frac{7}{12}}=$'],
     'opts': None, 'ln': 3,
     'sol': ['Citatel: $\\frac{5}{9}-\\frac{3}{2}:\\frac{3}{5}=\\frac{5}{9}-\\frac{3}{2}\\cdot\\frac{5}{3}=\\frac{5}{9}-\\frac{5}{2}=\\frac{10-45}{18}=-\\frac{35}{18}$. Jmenovatel: $\\frac{2}{3}+\\frac{1}{6}-\\frac{7}{12}=\\frac{8+2-7}{12}=\\frac{3}{12}=\\frac{1}{4}$. Podil: $-\\frac{35}{18}:\\frac{1}{4}=-\\frac{35}{18}\\cdot 4=-\\frac{70}{9}$.'],
     'ans': '$-\\frac{70}{9}$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2024 - uloha 4.1', 'zad': [
        'Umocnete:',
        '$(-3-2x)^2=$'],
     'opts': None, 'ln': 2,
     'sol': ['Podle vzorce $(a+b)^2=a^2+2ab+b^2$ s $a=-3$ a $b=-2x$: $9+12x+4x^2$.'],
     'ans': '$9+12x+4x^2$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2024 - uloha 4.2', 'zad': [
        'Upravte a rozlozte na soucin podle vzorce:',
        '$6\\,400-(x^2-3\\,600)=$'],
     'opts': None, 'ln': 2,
     'sol': ['$6\\,400-(x^2-3\\,600)=6\\,400-x^2+3\\,600=10\\,000-x^2=(100-x)\\cdot(100+x)$.'],
     'ans': '$(100-x)\\cdot(100+x)$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2024 - uloha 4.3', 'zad': [
        'Zjednoduste (vysledny vyraz nesmi obsahovat zavorky). Uvedte cely postup reseni.',
        '$(3x+1)^2-x\\cdot 7x-(2x-5)\\cdot(x+4)=$'],
     'opts': None, 'ln': 3,
     'sol': ['$(3x+1)^2=9x^2+6x+1$; $x\\cdot 7x=7x^2$; $(2x-5)(x+4)=2x^2+3x-20$. Celkem: $9x^2+6x+1-7x^2-(2x^2+3x-20)=3x+21$.'],
     'ans': '$3x+21$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2024 - uloha 5.1', 'zad': [
        'Reste rovnici (zkousku nezapisujte). Uvedte cely postup reseni.',
        '$1{,}6:2-\\frac{x}{2}=3\\cdot 0{,}7x+3{,}4$'],
     'opts': None, 'ln': 4,
     'sol': ['$1{,}6:2-\\frac{x}{2}=3\\cdot 0{,}7x+3{,}4$, tj. $0{,}8-0{,}5x=2{,}1x+3{,}4$. Odtud $0{,}8-3{,}4=2{,}1x+0{,}5x$, tedy $-2{,}6=2{,}6x$ a $x=-1$.'],
     'ans': '$x=-1$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2024 - uloha 5.2', 'zad': [
        'Reste rovnici (zkousku nezapisujte). Uvedte cely postup reseni.',
        '$\\frac{5-2y}{3}+\\frac{y}{9}=\\frac{3-y}{6}$'],
     'opts': None, 'ln': 4,
     'sol': ['Rovnici vynasobime $18$: $6(5-2y)+2y=3(3-y)$, tj. $30-12y+2y=9-3y$, $30-10y=9-3y$, $21=7y$, $y=3$.'],
     'ans': '$y=3$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2024 - uloha 6', 'zad': [
        'Ctyruhelnik $ABCD$ je takovy lichobeznik se zakladnami $AB$ a $CD$, ze usecka $BD$ je jeho vyska. Pro delky stran plati $|AD|=17$ cm, $|BD|=8$ cm, obsah trojuhelniku $BCD$ je $S_{BCD}=24$ cm$^2$.',
        '6.1 Vypocitejte obsah lichobezniku $ABCD$. Vysledek uvedte v cm$^2$.',
        '6.2 Vypocitejte obvod lichobezniku $ABCD$. Vysledek uvedte v cm.'],
     'opts': None, 'ln': 4, 'svg': SVG6, 'fn': 'lichobeznik-abcd.svg',
     'alt': 'Lichobeznik ABCD se zakladnami AB a CD a uhloprickou BD, ktera je vyskou a svira s AB pravy uhel.',
     'cap': 'Lichobeznik ABCD (schematicky nakres)',
     'sol': ['6.1 Trojuhelnik $ABD$ ma pravy uhel u $B$: $|AB|=\\sqrt{17^2-8^2}=\\sqrt{225}=15$ cm. Z $S_{BCD}=\\frac{1}{2}\\cdot|CD|\\cdot|BD|=24$ plyne $|CD|=\\frac{2\\cdot 24}{8}=6$ cm. Obsah lichobezniku: $\\frac{|AB|+|CD|}{2}\\cdot|BD|=\\frac{15+6}{2}\\cdot 8=84$ cm$^2$.',
            '6.2 $|BC|=\\sqrt{|CD|^2+|BD|^2}=\\sqrt{6^2+8^2}=10$ cm. Obvod: $|AB|+|BC|+|CD|+|DA|=15+10+6+17=48$ cm.'],
     'ans': '6.1: $84$ cm$^2$; 6.2: $48$ cm', 'pts': 4, 'mins': 7, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2024 - uloha 7', 'zad': [
        'Petr sbira modely aut. Druhy rok nasbiral o polovinu poctu modelu aut vice, nez ktere nasbiral prvni rok. Treti rok nasbiral $72$ modelu. Pocet modelu, ktere Petr nasbiral v prvnim roce, oznacte $x$.',
        '7.1 V zavislosti na velicine $x$ vyjadrete, kolik modelu nasbiral Petr behem druheho roku.',
        '7.2 Vypocitejte, kolik modelu nasbiral Petr behem prvniho roku, pokud za tri roky nasbiral $217$ modelu.'],
     'opts': None, 'ln': 3,
     'sol': ['7.1 Druhy rok nasbiral o polovinu vice nez prvni rok ($x$): $x+\\frac{1}{2}x=1{,}5x$.',
            '7.2 Za tri roky: $x+1{,}5x+72=217$, tj. $2{,}5x=145$, tedy $x=58$ modelu.'],
     'ans': '7.1: $1{,}5x$; 7.2: $58$ modelu', 'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['rovnice', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9B 2024 - uloha 8', 'zad': [
        'Obrazce jsou tvoreny z velkych bilych a malych tmavych kruhu podle urciteho pravidla. Prvni obrazec tvori jeden velky bily kruh. Druhy obrazec tvori ctyri bile kruhy, jejichz stredy tvori vrcholy ctverce, a jeden tmavy kruh uprostred. Kazde dva sousedni kruhy maji spolecny prave jeden bod. Treti obrazec tvori devet bilych kruhu a ctyri kruhy tmave. Danym zpusobem sestavujeme dalsi obrazce.',
        '8.1 Kolik velkych bilych kruhu obsahuje osmy obrazec?',
        '8.2 Kolikaty obrazec obsahuje $361$ malych tmavych kruhu?'],
     'opts': None, 'ln': 3, 'svg': SVG8, 'fn': 'obrazce-kruhy.svg',
     'alt': 'Prvni, druhy a treti obrazec: velke bile kruhy usporadane do ctverce (1, 4 a 9 kruhu) s malymi tmavymi kruhy v dotykovych bodech (0, 1 a 4 kruhy).',
     'cap': 'Obrazce z bilych a tmavych kruhu (1., 2. a 3. obrazec)',
     'sol': ['8.1 Pocet velkych bilych kruhu v $n$-tem obrazci je $n^2$ (postupne $1,4,9,\\ldots$). Osmy obrazec: $8^2=64$.',
            '8.2 Pocet malych tmavych kruhu v $n$-tem obrazci je $(n-1)^2$ (postupne $0,1,4,\\ldots$). Z $(n-1)^2=361$ plyne $n-1=19$, tedy $n=20$; jde o $20.$ obrazec.'],
     'ans': '8.1: $64$ velkych bilych kruhu; 8.2: $20.$ obrazec', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['posloupnosti', 'modelovani', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2024 - uloha 9 (konstrukce)', 'zad': [
        'V rovine jsou dany body $A$, $B$ a $O$. Body $A$, $B$ jsou vrcholy kosoctverce $ABCD$. Vrchol $C$ kosoctverce lezi na primce $OA$.',
        'Sestrojte kosoctverec $ABCD$.'],
     'opts': None, 'ln': 0, 'svg': SVG9, 'fn': 'body-aob.svg',
     'alt': 'Tri dane body v rovine: A nahore uprostred, O vlevo a B vpravo.',
     'cap': 'Vychozi obrazek k uloze 9',
     'sol': ['Sestrojime usecku $AB$ a poloprimku $OA$. Kruznice $k_1$ se stredem $B$ a polomerem $|AB|$ protne poloprimku $OA$ ve vrcholu $C$ (plati $|BC|=|AB|$). Bodem $C$ vedeme primku $p$ rovnobeznou s $AB$; kruznice $k_2$ se stredem $C$ a polomerem $|AB|$ protne $p$ ve vrcholu $D$. Ctyruhelnik $ABCD$ je hledany kosoctverec.'],
     'ans': 'Konstrukce kosoctverce $ABCD$: $C$ je prusecik poloprimky $OA$ s kruznici $(B; |AB|)$, bod $D$ doplnime tak, aby $CD \\parallel AB$ a $|CD|=|AB|$ (viz nakres v klici).',
     'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2024 - uloha 10 (konstrukce)', 'zad': [
        'V rovine je dana kruznice $k$ se stredem $S$ a body $K$, $L$. Body $K$, $L$ jsou vrcholy rovnoramenneho trojuhelniku $KLM$ se zakladnou $LM$.',
        'Sestrojte rovnoramenny trojuhelnik $KLM$, lezi-li bod $M$ na kruznici $k$. Naleznete vsechna reseni.'],
     'opts': None, 'ln': 0, 'svg': SVG10, 'fn': 'kruznice-k-kl.svg',
     'alt': 'Kruznice k se stredem S a dva dane body K vlevo dole a L vpravo dole vne kruznice.',
     'cap': 'Vychozi obrazek k uloze 10',
     'sol': ['Ramena rovnoramenneho trojuhelniku jsou $KL$ a $KM$, proto $|KM|=|KL|$. Sestrojime kruznici $m$ se stredem $K$ a polomerem $|KL|$. Jeji pruseciky s danou kruznici $k$ jsou body $M_1$ a $M_2$. Dostavame dve reseni: trojuhelniky $KLM_1$ a $KLM_2$.'],
     'ans': 'Dve reseni: bod $M$ je prusecik kruznice $k$ s kruznici $(K; |KL|)$ (body $M_1$, $M_2$) - trojuhelniky $KLM_1$ a $KLM_2$ (viz nakres v klici).',
     'pts': 3, 'mins': 7, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2024 - uloha 11', 'zad': [
        'Hracka stala $250$ korun. Nejdrive byla zdrazena o $40\\,\\%$ oproti puvodni cene, po mesici pak byla zlevnena o $40\\,\\%$ z nove ceny.',
        'Kolik stala hracka po teto dvoji uprave cen?'],
     'opts': ['A) $200$ Kc', 'B) $210$ Kc', 'C) $230$ Kc', 'D) $250$ Kc', 'E) $280$ Kc'], 'ln': 0,
     'sol': ['Po zdrazeni: $250\\cdot 1{,}4=350$ Kc. Po zlevneni o $40\\,\\%$ z nove ceny: $350\\cdot 0{,}6=210$ Kc.'],
     'ans': 'B) $210$ Kc', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'finance']},

    {'name': 'CERMAT M9B 2024 - uloha 12', 'zad': [
        'Pekar na trhu prodaval male a velke kolacky. Velky kolacek byl o polovinu drazsi nez maly kolacek a stal $30$ Kc. Velke kolacky prodal pekar vsechny a utrzil za ne $3\\,000$ Kc. Desetinu malych kolacku neprodal a za prodane male kolacky utrzil $3\\,600$ Kc.',
        'Kolik pekar puvodne privezl na trh malych kolacku?'],
     'opts': ['A) $100$', 'B) $180$', 'C) $200$', 'D) $240$', 'E) jiny pocet'], 'ln': 0,
     'sol': ['Velky kolacek je o polovinu drazsi nez maly a stoji $30$ Kc, tedy maly stoji $20$ Kc. Za prodane male kolacky pekar utrzil $3\\,600$ Kc, tj. $3\\,600:20=180$ prodanych malych kolacku. To je $\\frac{9}{10}$ vsech (desetinu neprodal), takze puvodne privezl $180:\\frac{9}{10}=200$ malych kolacku.'],
     'ans': 'C) $200$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'finance']},

    {'name': 'CERMAT M9B 2024 - uloha 13', 'zad': [
        'V rovine lezi primky $k$, $l$, $m$ a $n$. Pruseciky primek $k$, $l$ a $m$ tvori vrcholy trojuhelniku $ABC$. Bodem $B$ prochazi take primka $n$. Na obrazku jsou vyznaceny uhly $125^\\circ$ u vrcholu $C$, $105^\\circ$ u vrcholu $A$ a pravy uhel u vrcholu $B$; hledany uhel je oznacen $\\alpha$.',
        'Jaka je velikost uhlu $\\alpha$? Velikosti uhlu nemerte, ale vypocitejte (obrazek je ilustracni).'],
     'opts': ['A) $55^\\circ$', 'B) $50^\\circ$', 'C) $45^\\circ$', 'D) $40^\\circ$', 'E) $35^\\circ$'], 'ln': 0,
     'svg': SVG13, 'fn': 'primky-uhly.svg',
     'alt': 'Trojuhelnik ABC tvoreny primkami k, l, m a primka n prochazejici vrcholem B; vyznacene uhly 125 stupnu u C, 105 stupnu u A, pravy uhel a uhel alfa u B.',
     'cap': 'Schematicky nakres k uloze 13 (ilustracni)',
     'sol': ['Vnitrni uhly trojuhelniku: u $A$ je $180^\\circ-105^\\circ=75^\\circ$, u $C$ je $180^\\circ-125^\\circ=55^\\circ$, u $B$ tedy $180^\\circ-75^\\circ-55^\\circ=50^\\circ$. Primka $n$ svira s primkou $l$ pravy uhel, proto $\\alpha=90^\\circ-50^\\circ=40^\\circ$.'],
     'ans': 'D) $40^\\circ$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2024 - uloha 14', 'zad': [
        'Ve ctvercove siti je zakreslen sedy obrazec - pulkruh s prumerem $AB$. Body $A$ a $B$ lezi v mrizovych bodech. Delka strany ctverce ve ctvercove siti je $2$ cm.',
        'Jaky je obsah sede casti? Pro vypocet pouzijte zaokrouhlenou hodnotu cisla $\\pi\\doteq 3{,}14$.'],
     'opts': ['A) $20{,}28$ cm$^2$', 'B) $22{,}56$ cm$^2$', 'C) $24{,}56$ cm$^2$', 'D) $25{,}12$ cm$^2$', 'E) $30{,}24$ cm$^2$'], 'ln': 0,
     'svg': SVG14, 'fn': 'sit-pulkruh.svg',
     'alt': 'Ctvercova sit se stranou ctverce 2 cm a sedym pulkruhem s prumerem AB lezicim na mrizove primce.',
     'cap': 'Sedy pulkruh ve ctvercove siti (schematicky nakres)',
     'sol': ['Prumer $|AB|$ odpovida ctyrem stranam ctvercove site, tj. $|AB|=4\\cdot 2=8$ cm, polomer $r=4$ cm. Obsah pulkruhu: $\\frac{1}{2}\\pi r^2=\\frac{1}{2}\\cdot 3{,}14\\cdot 16=25{,}12$ cm$^2$.'],
     'ans': 'D) $25{,}12$ cm$^2$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2024 - uloha 15', 'zad': [
        'Zaci $9.$ rocniku mezi sebou provedli statisticky pruzkum. Kazdy zak volil svuj nejoblibenejsi predmet, pricemz kazdy si zvolil prave jeden. Vysledky hlasovani jsou zaznamenany v grafu (chlapci - srafovane, divky - sede) pro predmety M, Cj, Aj, Tv, Vv.',
        'Rozhodnete o kazdem z nasledujicich tvrzeni 15.1-15.3, zda je pravdive (A), ci nikoli (N).',
        '15.1 V $9.$ rocniku je stejny pocet divek jako chlapcu.',
        '15.2 Cesky jazyk volilo vice nez $16\\,\\%$ vsech zaku $9.$ rocniku.',
        '15.3 Pocet chlapcu, kteri volili matematiku, je o $75\\,\\%$ vetsi nez pocet devcat, ktera volila take matematiku.'],
     'opts': None, 'ln': 0, 'svg': SVG15, 'fn': 'graf-predmety.svg',
     'alt': 'Sloupcovy graf poctu chlapcu (srafovane) a divek (sede) pro predmety M, Cj, Aj, Tv, Vv s hodnotami chlapci 7, 2, 5, 7, 4 a divky 4, 6, 8, 5, 2.',
     'cap': 'Nejoblibenejsi predmety - chlapci a divky',
     'sol': ['Chlapci celkem: $7+2+5+7+4=25$, divky celkem: $4+6+8+5+2=25$.',
            '15.1 Pocty jsou stejne (25 a 25) - Ano (A).',
            '15.2 Cesky jazyk volilo $2+6=8$ zaku z $50$, tj. $\\frac{8}{50}=16\\,\\%$; neni to vice nez $16\\,\\%$ - Ne (N).',
            '15.3 Matematiku volilo $7$ chlapcu a $4$ divky; $\\frac{7}{4}=1{,}75$, tj. o $75\\,\\%$ vice - Ano (A).'],
     'ans': '15.1: A (Ano); 15.2: N (Ne); 15.3: A (Ano)', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['statistika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9B 2024 - uloha 16', 'zad': [
        'Priradte ke kazde uloze (16.1-16.3) odpovidajici vysledek (A-F).',
        '16.1 Lyzarsky pobyt stal celkem $7\\,000$ Kc. Cena zahrnovala dopravu, ubytovani a listek na vlek. Doprava tvorila desetinu celkove ceny, $60\\,\\%$ ceny stalo ubytovani. Kolik procent ceny pobytu tvorila cena listku na vlek?',
        '16.2 Cena ucebnice matematiky se snizila na castku $1\\,500$ Kc z puvodnich $2\\,000$ Kc. Kolik procent cinila sleva?',
        '16.3 Petr privezl nemocnemu kamaradovi darek ze zahranicniho zajezdu za $40$ EUR. Celkem mel vymeneno $200$ EUR. Kolik procent z vymenenych EUR tvorila cena darku?'],
     'opts': ['A) $15\\,\\%$', 'B) $20\\,\\%$', 'C) $25\\,\\%$', 'D) $30\\,\\%$', 'E) $40\\,\\%$', 'F) jiny vysledek'], 'ln': 0,
     'sol': ['16.1 Listek na vlek: $100\\,\\%-10\\,\\%-60\\,\\%=30\\,\\%$ -> D.',
            '16.2 Sleva: $\\frac{2\\,000-1\\,500}{2\\,000}=\\frac{500}{2\\,000}=25\\,\\%$ -> C.',
            '16.3 $\\frac{40}{200}=20\\,\\%$ -> B.'],
     'ans': '16.1: D ($30\\,\\%$); 16.2: C ($25\\,\\%$); 16.3: B ($20\\,\\%$)', 'pts': 6, 'mins': 6, 'diff': '3',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'finance']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M9PBD24C0T02'
    gen.YEAR = 2024

    def dollars_ok(s): return s.count('$') % 2 == 0
    errors = []; names = set()
    for p in PROBLEMS:
        if p['name'] in names: errors.append('DUP nazev: ' + p['name'])
        names.add(p['name'])
        for t in [p['name'], p['ans']] + list(p['zad']) + list(p['sol']) + (p.get('opts') or []):
            if not dollars_ok(t): errors.append('Neparovy $: ' + t[:70])
        if p.get('svg') and ("'" in p['svg'] or '\\' in p['svg']):
            errors.append('SVG zakazany znak: ' + p['name'])
        if p.get('svg') and not p.get('alt'): errors.append('Obrazek bez alt: ' + p['name'])
        for lbl, obj in (('content', gen.py_content_json(p)), ('solution', gen.py_solution_json(p)), ('answer', gen.py_answer_json(p))):
            try: json.loads(json.dumps(obj, ensure_ascii=False))
            except Exception as e: errors.append(f'JSON {lbl} {p["name"]}: {e}')
    if errors:
        print('CHYBY:'); [print('  -', e) for e in errors]; sys.exit(1)
    print('Validace OK:', len(PROBLEMS), 'uloh')
    outdir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'out')
    os.makedirs(outdir, exist_ok=True)
    tot = 0
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M9B-2024')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} uloh [{"OK" if sz<9000 else "PRES 9KB"}]')
    print('Celkem uloh:', tot)
