# -*- coding: utf-8 -*-
# CERMAT – Přijímací zkoušky 2015, MATEMATIKA 7 (šestileté obory, 7. ročník), pilotní ročník.
# Kód testu: M7PZD15C0T01. 17 úloh v testu / 50 bodů; po rozdělení a sloučení podle
# sdílených výchozích textů 16 záznamů.
# Zdroj odpovědí: klíč správných řešení (KSR), ověřeno proti záznamovému archu (VZA).

# ---- SVG obrázky (bez apostrofu a zpětného lomítka) ----

def _frac(x, y, a, b, fs=13):
    w = 4 + 4 * max(len(str(a)), len(str(b)))
    return (f'<text x="{x}" y="{y-4}" font-size="{fs}" text-anchor="middle">{a}</text>'
            f'<line x1="{x-w}" y1="{y}" x2="{x+w}" y2="{y}" stroke="#000" stroke-width="1"/>'
            f'<text x="{x}" y="{y+14}" font-size="{fs}" text-anchor="middle">{b}</text>')


# úlohy 4-5: schéma přesunů osob A -> X / P -> X, Y
def _schema():
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 330" font-family="sans-serif">',
         '<defs><marker id="a" markerWidth="9" markerHeight="9" refX="8" refY="3" orient="auto">'
         '<path d="M0,0 L8,3 L0,6 z" fill="#000"/></marker></defs>']
    # uzly
    s.append('<ellipse cx="220" cy="45" rx="55" ry="22" fill="none" stroke="#000" stroke-width="2"/>')
    s.append('<text x="220" y="18" font-size="16" font-weight="bold" text-anchor="middle">A</text>')
    s.append('<ellipse cx="280" cy="165" rx="52" ry="21" fill="none" stroke="#000" stroke-width="2"/>')
    s.append('<text x="280" y="140" font-size="16" font-weight="bold" text-anchor="middle">P</text>')
    s.append('<text x="280" y="170" font-size="13" text-anchor="middle">60 osob</text>')
    s.append('<ellipse cx="110" cy="285" rx="55" ry="22" fill="none" stroke="#000" stroke-width="2"/>')
    s.append('<text x="110" y="258" font-size="16" font-weight="bold" text-anchor="middle">X</text>')
    s.append('<ellipse cx="360" cy="285" rx="55" ry="22" fill="none" stroke="#000" stroke-width="2"/>')
    s.append('<text x="360" y="258" font-size="16" font-weight="bold" text-anchor="middle">Y</text>')
    # sipky
    s.append('<line x1="205" y1="66" x2="122" y2="262" stroke="#000" stroke-width="2" marker-end="url(#a)"/>')
    s.append('<line x1="240" y1="64" x2="272" y2="143" stroke="#000" stroke-width="2" marker-end="url(#a)"/>')
    s.append('<line x1="255" y1="182" x2="140" y2="268" stroke="#000" stroke-width="2" marker-end="url(#a)"/>')
    s.append('<line x1="303" y1="184" x2="345" y2="261" stroke="#000" stroke-width="2" marker-end="url(#a)"/>')
    s.append(_frac(140, 150, 1, 3))
    s.append(_frac(275, 100, 2, 3))
    s.append(_frac(210, 220, 1, 3))
    s.append(_frac(345, 220, 2, 3))
    s.append('</svg>')
    return "".join(s)
SVG45 = _schema()

# úlohy 8-9: obdélníkový čtverečkovaný papír 48 cm x 32 cm, čtvereček 0,4 cm
def _papir():
    ox, oy, W, H = 60, 40, 360, 240
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 330" font-family="sans-serif">']
    s.append(f'<rect x="{ox}" y="{oy}" width="{W}" height="{H}" fill="none" stroke="#000" '
             'stroke-width="2" stroke-dasharray="10 6"/>')
    # vyznaceny roh se ctverecky (schematicky, 5 x 4 ctverecku)
    c = 22
    s.append(f'<rect x="{ox}" y="{oy}" width="{5*c}" height="{4*c}" fill="#c9c9c9" stroke="#000"/>')
    for i in range(6):
        s.append(f'<line x1="{ox+i*c}" y1="{oy}" x2="{ox+i*c}" y2="{oy+4*c}" stroke="#000"/>')
    for j in range(5):
        s.append(f'<line x1="{ox}" y1="{oy+j*c}" x2="{ox+5*c}" y2="{oy+j*c}" stroke="#000"/>')
    s.append(f'<line x1="{ox-8}" y1="{oy}" x2="{ox-8}" y2="{oy+c}" stroke="#000"/>')
    s.append(f'<text x="{ox-14}" y="{oy+16}" font-size="13" text-anchor="end">0,4 cm</text>')
    s.append(f'<line x1="{ox+6*c}" y1="{oy+2*c}" x2="{ox+8*c}" y2="{oy+2*c}" stroke="#000" stroke-width="1.5"/>')
    s.append(f'<path d="M{ox+8*c},{oy+2*c-5} L{ox+8*c+10},{oy+2*c} L{ox+8*c},{oy+2*c+5} z" fill="#000"/>')
    s.append(f'<line x1="{ox+2*c}" y1="{oy+5*c}" x2="{ox+2*c}" y2="{oy+7*c}" stroke="#000" stroke-width="1.5"/>')
    s.append(f'<path d="M{ox+2*c-5},{oy+7*c} L{ox+2*c},{oy+7*c+10} L{ox+2*c+5},{oy+7*c} z" fill="#000"/>')
    s.append(f'<text x="{ox+W+10}" y="{oy+H/2}" font-size="14">32 cm</text>')
    s.append(f'<text x="{ox+W/2}" y="{oy+H+22}" font-size="14" text-anchor="middle">48 cm</text>')
    s.append('</svg>')
    return "".join(s)
SVG89 = _papir()

# úloha 10: trojúhelník RST, vrcholy R, S na přímce o
SVG10 = ('<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 320" font-family="sans-serif">'
         '<line x1="30" y1="234" x2="350" y2="272" stroke="#000" stroke-width="2"/>'
         '<line x1="120" y1="245" x2="360" y2="40" stroke="#000" stroke-width="2"/>'
         '<line x1="250" y1="260" x2="360" y2="40" stroke="#000" stroke-width="2"/>'
         '<text x="42" y="228" font-size="15" font-style="italic">o</text>'
         '<text x="112" y="268" font-size="15" font-style="italic">R</text>'
         '<text x="244" y="284" font-size="15" font-style="italic">S</text>'
         '<text x="364" y="34" font-size="15" font-style="italic">T</text>'
         '</svg>')

# úloha 12: čtverec ABCD rozdělený na dva bílé čtverce a dva tmavé obdélníky
def _ctverec():
    u, ox, oy = 30, 70, 40   # 1 cm = 30 px, strana 8 cm
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 320" font-family="sans-serif">']
    s.append(f'<rect x="{ox}" y="{oy}" width="{6*u}" height="{2*u}" fill="#9e9e9e" stroke="#000"/>')
    s.append(f'<rect x="{ox+6*u}" y="{oy}" width="{2*u}" height="{2*u}" fill="#fff" stroke="#000"/>')
    s.append(f'<rect x="{ox}" y="{oy+2*u}" width="{6*u}" height="{6*u}" fill="#fff" stroke="#000"/>')
    s.append(f'<rect x="{ox+6*u}" y="{oy+2*u}" width="{2*u}" height="{6*u}" fill="#bdbdbd" stroke="#000"/>')
    s.append(f'<rect x="{ox}" y="{oy}" width="{8*u}" height="{8*u}" fill="none" stroke="#000" stroke-width="2"/>')
    s.append(f'<text x="{ox-14}" y="{oy-8}" font-size="15" font-style="italic">D</text>')
    s.append(f'<text x="{ox+8*u+4}" y="{oy-8}" font-size="15" font-style="italic">C</text>')
    s.append(f'<text x="{ox-14}" y="{oy+8*u+18}" font-size="15" font-style="italic">A</text>')
    s.append(f'<text x="{ox+8*u+4}" y="{oy+8*u+18}" font-size="15" font-style="italic">B</text>')
    s.append(f'<text x="{ox+7*u}" y="{oy+u+5}" font-size="11" text-anchor="middle">o₁ = 8 cm</text>')
    s.append(f'<text x="{ox+3*u}" y="{oy+5*u}" font-size="12" text-anchor="middle">o₂ = 24 cm</text>')
    s.append('</svg>')
    return "".join(s)
SVG12 = _ctverec()

# úloha 13: síť krychle ve tvaru kříže (4 čtverce v řadě, 1 nad druhým a 1 pod třetím)
def _sit():
    a, ox, oy = 60, 60, 30
    cells = [(0, 1), (1, 1), (2, 1), (3, 1), (1, 0), (2, 2)]
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 240" font-family="sans-serif">']
    for cx, cy in cells:
        s.append(f'<rect x="{ox+cx*a}" y="{oy+cy*a}" width="{a}" height="{a}" '
                 'fill="#d9d9d9" stroke="#8a8a8a" stroke-dasharray="6 4"/>')
    s.append(f'<path d="M{ox},{oy+a} L{ox+a},{oy+a} L{ox+a},{oy} L{ox+2*a},{oy} L{ox+2*a},{oy+a} '
             f'L{ox+4*a},{oy+a} L{ox+4*a},{oy+2*a} L{ox+3*a},{oy+2*a} L{ox+3*a},{oy+3*a} '
             f'L{ox+2*a},{oy+3*a} L{ox+2*a},{oy+2*a} L{ox},{oy+2*a} z" '
             'fill="none" stroke="#000" stroke-width="2.5"/>')
    s.append('</svg>')
    return "".join(s)
SVG13 = _sit()

# úloha 14: dvě rovnoběžky, úhly 64°, 68°, alfa, beta
SVG14 = ('<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif">'
         '<line x1="55" y1="60" x2="420" y2="60" stroke="#000" stroke-width="2"/>'
         '<line x1="55" y1="260" x2="425" y2="260" stroke="#000" stroke-width="2"/>'
         '<line x1="200" y1="60" x2="102" y2="260" stroke="#000" stroke-width="2"/>'
         '<line x1="200" y1="60" x2="380" y2="260" stroke="#000" stroke-width="2"/>'
         '<line x1="298" y1="50" x2="298" y2="70" stroke="#000" stroke-width="2"/>'
         '<line x1="306" y1="50" x2="306" y2="70" stroke="#000" stroke-width="2"/>'
         '<line x1="238" y1="250" x2="238" y2="270" stroke="#000" stroke-width="2"/>'
         '<line x1="246" y1="250" x2="246" y2="270" stroke="#000" stroke-width="2"/>'
         '<path d="M145,60 A55,55 0 0 0 176,109" fill="none" stroke="#000" stroke-width="1.6"/>'
         '<path d="M182,96 A40,40 0 0 0 227,90" fill="none" stroke="#000" stroke-width="1.6"/>'
         '<path d="M142,260 A40,40 0 0 0 120,224" fill="none" stroke="#000" stroke-width="1.6"/>'
         '<path d="M340,260 A40,40 0 0 1 353,230" fill="none" stroke="#000" stroke-width="1.6"/>'
         '<text x="152" y="96" font-size="15">64°</text>'
         '<text x="192" y="112" font-size="15">68°</text>'
         '<text x="120" y="253" font-size="17" font-style="italic">α</text>'
         '<text x="346" y="253" font-size="17" font-style="italic">β</text>'
         '</svg>')

# úloha 15: sloupcový graf počtů chlapců a dívek v 7. třídách
def _graf():
    x0, yb, u = 62, 268, 11   # 1 dite = 11 px
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 540 330" font-family="sans-serif">']
    s.append('<text x="250" y="22" font-size="14" font-weight="bold" text-anchor="middle">'
             'Počty chlapců a dívek v 7. třídách</text>')
    for v in range(0, 21, 2):
        y = yb - v * u
        s.append(f'<line x1="{x0}" y1="{y}" x2="{440}" y2="{y}" stroke="#c8c8c8"/>')
        s.append(f'<text x="{x0-8}" y="{y+4}" font-size="11" text-anchor="end">{v}</text>')
    s.append(f'<line x1="{x0}" y1="40" x2="{x0}" y2="{yb}" stroke="#000"/>')
    s.append(f'<line x1="{x0}" y1="{yb}" x2="440" y2="{yb}" stroke="#000"/>')
    data = [('třída 7. A', 12, 14), ('třída 7. B', 18, 12), ('třída 7. C', 16, None)]
    gx = x0 + 22
    for name, ch, di in data:
        s.append(f'<rect x="{gx}" y="{yb-ch*u}" width="42" height="{ch*u}" fill="#fff" stroke="#000"/>')
        if di is None:
            s.append(f'<rect x="{gx+46}" y="{yb-6*u}" width="42" height="{6*u}" fill="#e8e8e8" '
                     'stroke="#000" stroke-dasharray="5 4"/>')
            s.append(f'<text x="{gx+67}" y="{yb-7*u}" font-size="17" font-weight="bold" '
                     'text-anchor="middle">?</text>')
        else:
            s.append(f'<rect x="{gx+46}" y="{yb-di*u}" width="42" height="{di*u}" fill="#8f8f8f" stroke="#000"/>')
        s.append(f'<text x="{gx+44}" y="{yb+18}" font-size="12" text-anchor="middle">{name}</text>')
        gx += 126
    s.append('<rect x="452" y="120" width="14" height="14" fill="#fff" stroke="#000"/>'
             '<text x="472" y="132" font-size="12">chlapci</text>')
    s.append('<rect x="452" y="145" width="14" height="14" fill="#8f8f8f" stroke="#000"/>'
             '<text x="472" y="157" font-size="12">dívky</text>')
    s.append('</svg>')
    return "".join(s)
SVG15 = _graf()

# úloha 17: plánek čtvercové sítě 6 x 6 s vodní plochou, start S a cíl C
def _planek():
    c, ox, oy, N = 48, 45, 25, 6
    def X(g): return ox + g * c
    def Y(g): return oy + (N - g) * c
    def poly(pts):
        p = " ".join(f"{X(a)},{Y(b)}" for a, b in pts)
        return f'<polygon points="{p}" fill="#bdbdbd"/>'
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {2*ox+N*c} {oy+N*c+45}" '
         'font-family="sans-serif">']
    s.append(poly([(0.5, 1.35), (5.6, 1.3), (5.8, 0.85), (5.5, 0.32), (0.7, 0.3), (0.42, 0.8)]))
    s.append(poly([(0.55, 2.6), (1.75, 2.5), (1.8, 1.3), (0.6, 1.3)]))
    s.append(poly([(4.05, 6.0), (4.75, 6.0), (4.8, 1.4), (4.0, 1.35)]))
    s.append(poly([(1.3, 5.82), (4.15, 6.0), (4.15, 5.25)]))
    s.append(poly([(4.75, 5.0), (5.6, 4.95), (5.75, 4.35), (4.75, 4.4)]))
    s.append(poly([(5.45, 6.0), (6.0, 6.0), (6.0, 4.55), (5.6, 4.6), (5.7, 5.5), (5.45, 5.5)]))
    for i in range(N + 1):
        s.append(f'<line x1="{X(i)}" y1="{Y(0)}" x2="{X(i)}" y2="{Y(N)}" stroke="#000"/>')
        s.append(f'<line x1="{X(0)}" y1="{Y(i)}" x2="{X(N)}" y2="{Y(i)}" stroke="#000"/>')
    s.append(f'<circle cx="{X(0)}" cy="{Y(0)}" r="5" fill="#000"/>')
    s.append(f'<text x="{X(0)-8}" y="{Y(0)+26}" font-size="16" font-style="italic" '
             'text-anchor="middle">S</text>')
    s.append(f'<circle cx="{X(5)}" cy="{Y(5)}" r="5" fill="#000"/>')
    s.append(f'<text x="{X(5)-16}" y="{Y(5)-8}" font-size="16" font-style="italic" '
             'text-anchor="middle">C</text>')
    s.append('</svg>')
    return "".join(s)
SVG17 = _planek()

B = ['zs2', 'r7']   # 2. stupeň ZŠ, 7. ročník (šestileté obory)
NC = 'bez-kalkulacky'

PROBLEMS = [
    {'name': 'CERMAT M7A 2015 – úloha 1', 'zad': [
        'Doplňte do rámečku takové číslo, aby platila rovnost:',
        '$\\square \\cdot 10-15=-85$'],
     'opts': None, 'ln': 2,
     'sol': ['$\\square \\cdot 10 = -85+15 = -70$, tedy $\\square = -70:10 = -7$.'],
     'ans': '$-7$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', NC, 'bez-kontextu']},

    {'name': 'CERMAT M7A 2015 – úloha 2', 'zad': [
        'Doplňte do rámečku takové číslo, aby platila rovnost:',
        '$3{,}2+0{,}01\\cdot \\square = 3{,}5$'],
     'opts': None, 'ln': 2,
     'sol': ['$0{,}01\\cdot \\square = 3{,}5-3{,}2 = 0{,}3$, tedy $\\square = 0{,}3:0{,}01 = 30$.'],
     'ans': '$30$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', NC, 'bez-kontextu']},

    {'name': 'CERMAT M7A 2015 – úloha 3.1', 'zad': [
        'Vypočtěte a výsledek uveďte zlomkem v základním tvaru:',
        '$5\\cdot \\left(0{,}5-\\frac{3}{5}\\right)=$'],
     'opts': None, 'ln': 2,
     'sol': ['$0{,}5=\\frac{1}{2}$, tedy $\\frac{1}{2}-\\frac{3}{5}=\\frac{5}{10}-\\frac{6}{10}=-\\frac{1}{10}$.',
             '$5\\cdot \\left(-\\frac{1}{10}\\right)=-\\frac{5}{10}=-\\frac{1}{2}$.'],
     'ans': '$-\\frac{1}{2}$', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', NC, 'bez-kontextu']},

    {'name': 'CERMAT M7A 2015 – úloha 3.2', 'zad': [
        'Vypočtěte a výsledek uveďte zlomkem v základním tvaru:',
        '$\\dfrac{\\frac{2}{5}-\\frac{5}{2}}{-3}=$'],
     'opts': None, 'ln': 2,
     'sol': ['Čitatel: $\\frac{2}{5}-\\frac{5}{2}=\\frac{4}{10}-\\frac{25}{10}=-\\frac{21}{10}$.',
             '$-\\frac{21}{10}:(-3)=\\frac{21}{30}=\\frac{7}{10}$.'],
     'ans': '$\\frac{7}{10}$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', NC, 'bez-kontextu']},

    {'name': 'CERMAT M7A 2015 – úloha 4–5', 'zad': [
        'Všechny osoby skupiny A postupně přešly na stanoviště X nebo Y tak, jak znázorňuje schéma.',
        'Ze skupiny A odešla $\\frac{1}{3}$ osob na stanoviště X, zbytek osob se přesunul na přechodné stanoviště P.',
        'Na přechodné stanoviště P se dostalo 60 osob. Z něj pak přešla $\\frac{1}{3}$ osob na stanoviště X, ostatní na stanoviště Y.',
        '4.1 Určete konečný počet osob na stanovišti Y.',
        '4.2 Určete původní počet osob ve skupině A.',
        '5.1 Vyjádřete zlomkem v základním tvaru, jaká část osob skupiny A se dostala na stanoviště X.',
        '5.2 Vyjádřete zlomkem v základním tvaru, jaká část osob skupiny A se dostala na stanoviště Y.'],
     'opts': None, 'ln': 3, 'svg': SVG45, 'fn': 'schema-stanoviste.svg',
     'alt': 'Schéma: ze skupiny A vede jedna třetina na stanoviště X a dvě třetiny na přechodné stanoviště P se 60 osobami; z P jde jedna třetina na X a dvě třetiny na Y.',
     'cap': 'Schéma přesunů osob',
     'sol': ['Na P se dostaly $\\frac{2}{3}$ osob skupiny A, což je 60 osob, tedy $A=60:\\frac{2}{3}=90$ osob.',
             '4.1 Z P přešly na Y dvě třetiny: $\\frac{2}{3}\\cdot 60=40$ osob.',
             '4.2 Skupina A měla $90$ osob.',
             '5.1 Na X: přímo $\\frac{1}{3}\\cdot 90=30$ a z P $\\frac{1}{3}\\cdot 60=20$, celkem $50$ osob, tj. $\\frac{50}{90}=\\frac{5}{9}$.',
             '5.2 Na Y: $40$ osob z $90$, tj. $\\frac{40}{90}=\\frac{4}{9}$.'],
     'ans': '4.1: $40$ osob; 4.2: $90$ osob; 5.1: $\\frac{5}{9}$; 5.2: $\\frac{4}{9}$',
     'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', NC, 'bezny-zivot']},

    {'name': 'CERMAT M7A 2015 – úloha 6', 'zad': [
        'Pavel měl sraz s kamarádem. Z postele vstal hned po zazvonění budíku.',
        'Ranní hygienu zvládl za $\\frac{1}{5}$ hodiny, 5 minut se oblékal, snídal $\\frac{1}{3}$ hodiny a cesta na sraz mu trvala $\\frac{1}{10}$ hodiny.',
        'Na sraz přišel v 9:20.',
        '6.1 Vypočtěte, kolik minut Pavlovi trvala ranní hygiena.',
        '6.2 Vypočtěte, kolik minut uplynulo od zazvonění budíku k příchodu Pavla na sraz.',
        '6.3 Vypočtěte, v kolik hodin zazvonil budík.'],
     'opts': None, 'ln': 3,
     'sol': ['6.1 $\\frac{1}{5}$ hodiny $=\\frac{60}{5}=12$ minut.',
             '6.2 Snídaně $\\frac{1}{3}\\cdot 60=20$ min, cesta $\\frac{1}{10}\\cdot 60=6$ min. Celkem $12+5+20+6=43$ minut.',
             '6.3 $9{:}20$ mínus $43$ minut je $8{:}37$.'],
     'ans': '6.1: $12$ minut; 6.2: $43$ minut; 6.3: v $8{:}37$', 'pts': 3, 'mins': 5, 'diff': '2',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', NC, 'bezny-zivot']},

    {'name': 'CERMAT M7A 2015 – úloha 7', 'zad': [
        'Na tribuně je 840 sportovních diváků. Dospělých je mezi nimi o 420 více než dětí.',
        '7.1 Vypočtěte, kolik dospělých bylo mezi sportovními diváky.',
        '7.2 Určete v základním tvaru poměr počet dětí : počet dospělých.'],
     'opts': None, 'ln': 3,
     'sol': ['Označme počet dětí $d$. Pak $d+(d+420)=840$, tedy $2d=420$ a $d=210$ dětí.',
             '7.1 Dospělých je $210+420=630$.',
             '7.2 $210:630=1:3$.'],
     'ans': '7.1: $630$ dospělých; 7.2: $1:3$', 'pts': 3, 'mins': 4, 'diff': '2',
     'codes': B + ['rovnice', 'modelovani', 'slovni', NC, 'bezny-zivot']},

    {'name': 'CERMAT M7A 2015 – úloha 8–9', 'zad': [
        'Čtverečkovaný papír tvaru obdélníku je potištěn čarami, které rozdělují plochu na malé čtverečky se stranou délky 0,4 cm. Rozměry papíru jsou 48 cm a 32 cm.',
        '8 Určete počet všech malých čtverečků na čtverečkovaném papíře.',
        '9 Obtažením některých čar je možné celou plochu čtverečkovaného papíru rozdělit na větší shodné čtverce. Určete nejmenší počet shodných čtverců pokrývajících celou plochu papíru.'],
     'opts': None, 'ln': 3, 'svg': SVG89, 'fn': 'ctverecky-papir.svg',
     'alt': 'Obdélníkový papír o rozměrech 48 cm a 32 cm, v rohu je vyznačena část sítě čtverečků se stranou 0,4 cm.',
     'cap': 'Čtverečkovaný papír (schematicky)',
     'sol': ['8 Podél delší strany $48:0{,}4=120$ čtverečků, podél kratší $32:0{,}4=80$ čtverečků. Celkem $120\\cdot 80=9\\,600$ čtverečků.',
             '9 Strana většího čtverce musí dělit 48 i 32; největší taková délka je $D(48;32)=16$ cm.',
             'Papír pak pokryje $(48:16)\\cdot(32:16)=3\\cdot 2=6$ čtverců.'],
     'ans': '8: $9\\,600$ malých čtverečků; 9: $6$ shodných čtverců', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'slovni', NC, 'bezny-zivot']},

    {'name': 'CERMAT M7A 2015 – úloha 10 (konstrukce)', 'zad': [
        'V rovině je dán trojúhelník $RST$. Vrcholy $R$, $S$ leží na přímce $o$ (viz obrázek).',
        '10.1 Sestrojte bod $P$, který je obrazem bodu $R$ ve středové souměrnosti se středem $S$.',
        '10.2 Sestrojte bod $O$, který je obrazem bodu $T$ v osové souměrnosti s osou $o$.',
        '10.3 Sestrojte chybějící vrchol $Q$ rovnoběžníku $OPQR$ a rovnoběžník narýsujte.'],
     'opts': None, 'ln': 0, 'svg': SVG10, 'fn': 'trojuhelnik-rst.svg',
     'alt': 'Trojúhelník RST, vrcholy R a S leží na přímce o, vrchol T je nad přímkou.',
     'cap': 'Výchozí obrázek k úloze 10',
     'sol': ['10.1 Bod $P$ leží na polopřímce $RS$ za bodem $S$ tak, že $|SP|=|RS|$ (bod $S$ je střed úsečky $RP$).',
             '10.2 Bod $O$ získáme jako obraz $T$ v osové souměrnosti podle $o$: z $T$ vedeme kolmici k $o$ a naneseme stejnou vzdálenost na druhou stranu.',
             '10.3 V rovnoběžníku $OPQR$ platí, že úhlopříčky se půlí; vrchol $Q$ doplníme tak, aby $QR \\parallel OP$ a $PQ \\parallel RO$. Body $R$, $P$ leží na přímce $o$, body $O$ a $Q$ na opačných stranách od $o$.'],
     'ans': 'Konstrukce podle klíče: $S$ je střed úsečky $RP$; $O$ je obraz $T$ v osové souměrnosti podle $o$; $Q$ doplňuje rovnoběžník $OPQR$ (kosočtverečný útvar s vrcholy $O$ dole a $Q$ nahoře).',
     'pts': 6, 'mins': 8, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', NC, 'bez-kontextu']},

    {'name': 'CERMAT M7A 2015 – úloha 11', 'zad': [
        'Rozhodněte o každém z následujících výpočtů (11.1–11.3), zda je proveden správně (A), či nikoli (N).',
        '11.1 3 kg $-$ 20 g $=$ 280 g',
        '11.2 5 km $-$ 72 m $=$ 4 928 m',
        '11.3 14 m² $+$ 3,2 dm² $+$ 5 cm² $=$ 140 325 cm²'],
     'opts': None, 'ln': 0,
     'sol': ['11.1 $3$ kg $=3\\,000$ g, tedy $3\\,000-20=2\\,980$ g, nikoli 280 g → Ne.',
             '11.2 $5$ km $=5\\,000$ m, tedy $5\\,000-72=4\\,928$ m → Ano.',
             '11.3 $14$ m² $=140\\,000$ cm², $3{,}2$ dm² $=320$ cm²; $140\\,000+320+5=140\\,325$ cm² → Ano.'],
     'ans': '11.1: Ne; 11.2: Ano; 11.3: Ano', 'pts': 3, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'argumentace', 'pocetni', NC, 'bez-kontextu']},

    {'name': 'CERMAT M7A 2015 – úloha 12', 'zad': [
        'Čtverec $ABCD$ je dvěma úsečkami rozdělen na čtyři části: čtverec s obvodem 8 cm, čtverec s obvodem 24 cm a dva tmavé obdélníky.',
        'Rozhodněte o každém z následujících tvrzení (12.1–12.3), zda je pravdivé (A), či nikoli (N).',
        '12.1 Oba tmavé obdélníky jsou shodné.',
        '12.2 Obvod čtverce $ABCD$ je 36 cm.',
        '12.3 Obsah plochy tvořené oběma bílými čtverci je 40 cm².'],
     'opts': None, 'ln': 0, 'svg': SVG12, 'fn': 'ctverec-abcd.svg',
     'alt': 'Čtverec ABCD rozdělený dvěma úsečkami na malý bílý čtverec vpravo nahoře, velký bílý čtverec vlevo dole a dva tmavé obdélníky.',
     'cap': 'Rozdělení čtverce ABCD',
     'sol': ['Malý čtverec má stranu $8:4=2$ cm, velký čtverec stranu $24:4=6$ cm. Strana čtverce $ABCD$ je $2+6=8$ cm.',
             '12.1 Oba tmavé obdélníky mají rozměry $6$ cm a $2$ cm, jsou tedy shodné → Ano.',
             '12.2 Obvod $ABCD$ je $4\\cdot 8=32$ cm, nikoli 36 cm → Ne.',
             '12.3 Obsah bílých čtverců je $2^2+6^2=4+36=40$ cm² → Ano.'],
     'ans': '12.1: Ano; 12.2: Ne; 12.3: Ano', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['planimetrie', 'argumentace', 'slovni', NC, 'bez-kontextu']},

    {'name': 'CERMAT M7A 2015 – úloha 13', 'zad': [
        'Obrazec, který představuje síť krychle, má obvod 28 cm (viz obrázek).',
        'Jaký je objem krychle?'],
     'opts': ['A) méně než 9 cm³', 'B) 9 cm³', 'C) 16 cm³', 'D) 27 cm³', 'E) více než 27 cm³'],
     'ln': 0, 'svg': SVG13, 'fn': 'sit-krychle.svg',
     'alt': 'Síť krychle tvaru kříže: čtyři čtverce v řadě, jeden čtverec nad druhým z nich a jeden pod třetím z nich.',
     'cap': 'Síť krychle',
     'sol': ['Síť má 6 čtverců; sdílených (vnitřních) hran je 5, takže obvod tvoří $6\\cdot 4-2\\cdot 5=14$ hran.',
             'Platí $14a=28$, tedy $a=2$ cm.',
             'Objem krychle je $V=2^3=8$ cm³, což je méně než 9 cm³.'],
     'ans': 'A) méně než 9 cm³', 'pts': 2, 'mins': 4, 'diff': '4',
     'codes': B + ['stereometrie', 'porozumeni', 'slovni', NC, 'bez-kontextu']},

    {'name': 'CERMAT M7A 2015 – úloha 14', 'zad': [
        'Na obrázku jsou dvě rovnoběžné přímky (vyznačeny shodnými značkami) a trojúhelník s úhly $\\alpha$ a $\\beta$. U společného vrcholu na horní přímce jsou vyznačeny úhly $64^\\circ$ a $68^\\circ$.',
        'Jakou velikost má úhel $\\beta$?'],
     'opts': ['A) $32^\\circ$', 'B) $36^\\circ$', 'C) $42^\\circ$', 'D) $48^\\circ$', 'E) jinou velikost'],
     'ln': 0, 'svg': SVG14, 'fn': 'uhly-rovnobezky.svg',
     'alt': 'Dvě rovnoběžné přímky; z vrcholu na horní přímce vedou dvě polopřímky k dolní přímce, u vrcholu jsou úhly 64 stupňů a 68 stupňů, u dolní přímky úhly alfa a beta.',
     'cap': 'Výchozí obrázek k úloze 14',
     'sol': ['U vrcholu na horní přímce je přímý úhel: zbývající úhel má velikost $180^\\circ-64^\\circ-68^\\circ=48^\\circ$.',
             'Tento úhel a úhel $\\beta$ jsou střídavé úhly u rovnoběžek, proto $\\beta=48^\\circ$.'],
     'ans': 'D) $48^\\circ$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', NC, 'bez-kontextu']},

    {'name': 'CERMAT M7A 2015 – úloha 15', 'zad': [
        'V grafu jsou znázorněny počty dětí ve všech 7. třídách školy kromě počtu dívek v 7. C.',
        'Počet dětí v 7. C je aritmetickým průměrem počtu dětí v 7. A a 7. B.',
        'Kolik dívek je ve třídě 7. C?'],
     'opts': ['A) méně než 12', 'B) 12', 'C) 13', 'D) 14', 'E) více než 14'],
     'ln': 0, 'svg': SVG15, 'fn': 'graf-tridy.svg',
     'alt': 'Sloupcový graf počtů chlapců a dívek ve třídách 7. A (12 a 14), 7. B (18 a 12) a 7. C (16 chlapců, počet dívek neznámý).',
     'cap': 'Počty chlapců a dívek v 7. třídách',
     'sol': ['V 7. A je $12+14=26$ dětí, v 7. B je $18+12=30$ dětí.',
             'Průměr: $(26+30):2=28$ dětí v 7. C.',
             'Chlapců je v 7. C 16, tedy dívek je $28-16=12$.'],
     'ans': 'B) 12', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['statistika', 'vypocet', 'slovni', NC, 'bezny-zivot']},

    {'name': 'CERMAT M7A 2015 – úloha 16', 'zad': [
        'Přiřaďte ke každé úloze (16.1–16.3) odpovídající výsledek (A–F).',
        '16.1 Které číslo získáme zvětšením čísla 400 o 20 %?',
        '16.2 Které číslo se po odečtení čísla 100 zmenší o 20 %?',
        '16.3 Které číslo je třeba zvětšit o 20 %, aby vzniklo číslo 540?'],
     'opts': ['A) 400', 'B) 432', 'C) 450', 'D) 480', 'E) 500', 'F) žádné z uvedených'],
     'ln': 0,
     'sol': ['16.1 $400\\cdot 1{,}2=480$ → D.',
             '16.2 Odečtení 100 znamená zmenšení o 20 %, tedy $0{,}2x=100$ a $x=500$ → E.',
             '16.3 $1{,}2x=540$, tedy $x=540:1{,}2=450$ → C.'],
     'ans': '16.1: D ($480$); 16.2: E ($500$); 16.3: C ($450$)', 'pts': 6, 'mins': 6, 'diff': '3',
     'codes': B + ['procenta', 'vypocet', 'pocetni', NC, 'bez-kontextu']},

    {'name': 'CERMAT M7A 2015 – úloha 17', 'zad': [
        'Na cestě od startu $S$ do cíle $C$ kolem vodní plochy je možné postupovat pouze po čarách čtvercové sítě.',
        '17.1 Zakreslete jednu cestu, která vede kolem vodní plochy z $S$ do $C$ a má nejkratší možnou délku.',
        '17.2 Pokud existuje větší počet různých cest kolem vodní plochy z $S$ do $C$ s nejkratší možnou délkou, další dvě z těchto cest zakreslete.',
        '17.3 Určete počet všech různých cest z $S$ do $C$ kolem vodní plochy, které mají nejkratší možnou délku.'],
     'opts': None, 'ln': 2, 'svg': SVG17, 'fn': 'planek-cesty.svg',
     'alt': 'Plánek čtvercové sítě 6 krát 6 s šedou vodní plochou; start S je v levém dolním rohu, cíl C je vpravo nahoře.',
     'cap': 'Plánek s vodní plochou (schematicky)',
     'sol': ['Cesta se vede jen po čarách sítě a nesmí vstoupit do vodní plochy; nejkratší cesty postupují stále směrem k cíli (bez zacházek).',
             '17.1 a 17.2 Stačí zakreslit tři různé nejkratší cesty (viz obrázky v klíči správných řešení).',
             '17.3 Postupným počítáním možností v jednotlivých uzlech sítě vyjde, že různých nejkratších cest je $8$.'],
     'ans': '17.1 a 17.2: zakreslení tří různých nejkratších cest kolem vodní plochy (viz klíč); 17.3: $8$ cest',
     'pts': 4, 'mins': 8, 'diff': '4',
     'codes': B + ['kombinatorika', 'argumentace', 'slovni', NC, 'bezny-zivot']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M7PZD15C0T01'
    gen.YEAR = 2015

    def dollars_ok(s): return s.count('$') % 2 == 0
    errors = []; names = set()
    for p in PROBLEMS:
        if p['name'] in names: errors.append('DUP název: ' + p['name'])
        names.add(p['name'])
        if not p['name'].startswith('CERMAT M7A 2015 – úloha '):
            errors.append('Špatný prefix: ' + p['name'])
        for t in [p['name'], p['ans']] + list(p['zad']) + list(p['sol']) + (p.get('opts') or []):
            if not dollars_ok(t): errors.append('Nepárový $: ' + t[:70])
        if p.get('svg') and ("'" in p['svg'] or '\\' in p['svg']):
            errors.append('SVG zakázaný znak: ' + p['name'])
        if p.get('svg') and not p.get('alt'): errors.append('Obrázek bez alt: ' + p['name'])
        for lbl, obj in (('content', gen.py_content_json(p)), ('solution', gen.py_solution_json(p)), ('answer', gen.py_answer_json(p))):
            try: json.loads(json.dumps(obj, ensure_ascii=False))
            except Exception as e: errors.append(f'JSON {lbl} {p["name"]}: {e}')
    total = sum(p['pts'] for p in PROBLEMS)
    if total != 50:
        errors.append(f'Součet bodů {total} != 50 (dle KSR)')
    if errors:
        print('CHYBY:'); [print('  -', e) for e in errors]; sys.exit(1)
    print('Validace OK:', len(PROBLEMS), 'úloh, body celkem:', total)
    outdir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'out')
    os.makedirs(outdir, exist_ok=True)
    tot = 0
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M7A-2015')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
