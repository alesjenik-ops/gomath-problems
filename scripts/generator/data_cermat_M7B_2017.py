# -*- coding: utf-8 -*-
# CERMAT – přijímací zkoušky 2017, MATEMATIKA 7 B (šestileté obory), 2. řádný termín.
# Kód testu: M7PBD17C0T02. 17 úloh (po rozdělení izolovaných podúloh 3 a 4 celkem 19 úloh).
# Zdroj odpovědí: klíč správných řešení (KSR), ověřeno se záznamovým archem (VZA). Celkem 50 bodů.

# ---- SVG obrázky (bez apostrofů a zpětných lomítek) ----

# úloha 6: plánek běžecké trati (přímka se stanovišti B, stánek, A, start/cíl)
SVG6 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 150" font-family="sans-serif">
<line x1="20" y1="60" x2="540" y2="60" stroke="#000" stroke-width="3"/>
<line x1="120" y1="46" x2="120" y2="74" stroke="#000" stroke-width="2"/>
<line x1="280" y1="46" x2="280" y2="74" stroke="#000" stroke-width="2"/>
<line x1="380" y1="46" x2="380" y2="74" stroke="#000" stroke-width="2"/>
<line x1="470" y1="46" x2="470" y2="74" stroke="#000" stroke-width="2"/>
<text x="120" y="36" font-size="15" text-anchor="middle" font-weight="bold">B</text>
<text x="280" y="36" font-size="15" text-anchor="middle">Stánek</text>
<text x="380" y="36" font-size="15" text-anchor="middle" font-weight="bold">A</text>
<line x1="520" y1="32" x2="496" y2="32" stroke="#000" stroke-width="2"/>
<polygon points="490,32 500,28 500,36" fill="#000"/>
<text x="526" y="37" font-size="14">Start</text>
<line x1="496" y1="90" x2="518" y2="90" stroke="#000" stroke-width="2"/>
<polygon points="524,90 514,86 514,94" fill="#000"/>
<text x="530" y="95" font-size="14">Cíl</text>
<path d="M120 84 L120 98 L380 98 L380 84" fill="none" stroke="#000"/>
<text x="250" y="120" font-size="14" text-anchor="middle">8 km</text>
</svg>"""

# úloha 8: akvárium tvaru kvádru s vodou (schematicky)
SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 330 210" font-family="sans-serif">
<polygon points="60,110 230,110 285,70 115,70" fill="#c9c9c9" stroke="#000"/>
<rect x="60" y="110" width="170" height="70" fill="#c9c9c9" stroke="#000"/>
<polygon points="230,110 285,70 285,140 230,180" fill="#b0b0b0" stroke="#000"/>
<polyline points="60,180 115,100 285,140" fill="none" stroke="#000" stroke-width="2" stroke-dasharray="6 5"/>
<polyline points="60,60 60,180 230,180 230,60" fill="none" stroke="#000" stroke-width="2"/>
<polyline points="60,60 115,20 285,20 230,60" fill="none" stroke="#000" stroke-width="2"/>
<polyline points="115,20 115,100" fill="none" stroke="#000" stroke-width="2"/>
<polyline points="285,20 285,140 230,180" fill="none" stroke="#000" stroke-width="2"/>
<line x1="230" y1="60" x2="285" y2="20" stroke="#000" stroke-width="2"/>
</svg>"""

# úloha 9: rovnoběžník ABCD (výchozí obrázek)
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 320" font-family="sans-serif">
<polygon points="250,40 420,110 250,270 80,200" fill="none" stroke="#000" stroke-width="2.5"/>
<text x="245" y="30" font-size="17" font-style="italic">C</text>
<text x="432" y="112" font-size="17" font-style="italic">B</text>
<text x="248" y="292" font-size="17" font-style="italic">A</text>
<text x="58" y="204" font-size="17" font-style="italic">D</text>
</svg>"""

# úloha 10: přímka p procházející bodem S a bod A (výchozí obrázek)
SVG10 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 260" font-family="sans-serif">
<line x1="30" y1="120" x2="430" y2="120" stroke="#000" stroke-width="2.5"/>
<text x="46" y="142" font-size="17" font-style="italic">p</text>
<line x1="230" y1="110" x2="230" y2="130" stroke="#000" stroke-width="2"/>
<text x="238" y="146" font-size="17" font-style="italic">S</text>
<text x="180" y="205" font-size="16" text-anchor="middle">×</text>
<text x="180" y="226" font-size="17" text-anchor="middle" font-style="italic">A</text>
</svg>"""

# úloha 11: obrazec I (čtverec s výřezem) a obrazec II (čtverec s přilepeným obdélníkem)
SVG11 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 230" font-family="sans-serif">
<text x="105" y="34" font-size="15" text-anchor="middle" font-weight="bold">I</text>
<text x="330" y="34" font-size="15" text-anchor="middle" font-weight="bold">II</text>
<polygon points="30,45 180,45 180,70 130,70 130,170 180,170 180,195 30,195" fill="#d0d0d0" stroke="#000" stroke-width="2"/>
<text x="20" y="124" font-size="13" text-anchor="end">6 cm</text>
<text x="105" y="215" font-size="13" text-anchor="middle">6 cm</text>
<text x="120" y="124" font-size="13" text-anchor="end">4 cm</text>
<text x="156" y="186" font-size="13" text-anchor="middle">2 cm</text>
<line x1="196" y1="120" x2="244" y2="120" stroke="#000" stroke-width="2"/>
<polygon points="252,120 240,115 240,125" fill="#000"/>
<polygon points="260,45 410,45 410,195 260,195 260,170 210,170 210,70 260,70" fill="#d0d0d0" stroke="#000" stroke-width="2"/>
<text x="234" y="62" font-size="13" text-anchor="middle">2 cm</text>
<text x="420" y="124" font-size="13">6 cm</text>
<text x="335" y="215" font-size="13" text-anchor="middle">6 cm</text>
</svg>"""


# úloha 12: čtvercová síť (strana čtverce 5 cm) se dvěma tmavými trojúhelníky
def _grid12():
    c = 48
    ox, oy = 24, 24
    W, H = 8, 3
    def p(i, j):
        return f'{ox + i * c},{round(oy + j * c)}'
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 200" font-family="sans-serif">']
    s.append(f'<polygon points="{p(3,0)} {p(4,0.4)} {p(3,2)}" fill="#b8b8b8" stroke="#000" stroke-width="2"/>')
    s.append(f'<polygon points="{p(3,1)} {p(3,2)} {p(2,1.3)}" fill="#b8b8b8" stroke="#000" stroke-width="2"/>')
    for i in range(W + 1):
        s.append(f'<line x1="{ox+i*c}" y1="{oy}" x2="{ox+i*c}" y2="{oy+H*c}" stroke="#777" stroke-width="1.5"/>')
    for j in range(H + 1):
        s.append(f'<line x1="{ox}" y1="{oy+j*c}" x2="{ox+W*c}" y2="{oy+j*c}" stroke="#777" stroke-width="1.5"/>')
    s.append('<line x1="96" y1="26" x2="96" y2="70" stroke="#000" stroke-width="1.5"/>')
    s.append('<polygon points="96,22 92,32 100,32" fill="#000"/><polygon points="96,74 92,64 100,64" fill="#000"/>')
    s.append('<text x="88" y="54" font-size="14" text-anchor="end">5 cm</text>')
    s.append('<line x1="314" y1="48" x2="358" y2="48" stroke="#000" stroke-width="1.5"/>')
    s.append('<polygon points="310,48 320,44 320,52" fill="#000"/><polygon points="362,48 352,44 352,52" fill="#000"/>')
    s.append('<text x="336" y="38" font-size="14" text-anchor="middle">5 cm</text>')
    s.append('</svg>')
    return "".join(s)
SVG12 = _grid12()

# úloha 13: čtyřúhelník ABCD (rovnostranný ABC + rovnoramenný ACD)
SVG13 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 380 350" font-family="sans-serif">
<polygon points="147,75 308,201 319,321 210,270" fill="none" stroke="#000" stroke-width="2.5"/>
<line x1="210" y1="270" x2="308" y2="201" stroke="#000" stroke-width="1.5"/>
<text x="128" y="70" font-size="17" font-style="italic">D</text>
<text x="318" y="196" font-size="17" font-style="italic">C</text>
<text x="330" y="333" font-size="17" font-style="italic">B</text>
<text x="192" y="286" font-size="17" font-style="italic">A</text>
<text x="228" y="128" font-size="16" font-style="italic">b</text>
<text x="160" y="185" font-size="16" font-style="italic">b</text>
<text x="326" y="264" font-size="16" font-style="italic">a</text>
<text x="258" y="312" font-size="16" font-style="italic">a</text>
<path d="M175 100 A 40 40 0 0 0 165 118" fill="none" stroke="#000"/>
<text x="164" y="104" font-size="15">δ</text>
<path d="M278 214 A 40 40 0 0 0 296 246" fill="none" stroke="#000"/>
<text x="262" y="234" font-size="14">133°</text>
</svg>"""


# úloha 14: kruhový diagram AKTIVITY (100 dětí, 3,6 stupně na dítě)
def _pie():
    import math
    cx, cy, r = 175, 130, 92
    data = [('kino', 32), ('fotbal', 16), ('plavání', 26), ('cyklistika', 8), ('lezení', 18)]
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 270" font-family="sans-serif">']
    s.append('<text x="175" y="24" font-size="15" text-anchor="middle" font-weight="bold">AKTIVITY</text>')
    a = -90.0
    for name, v in data:
        b = a + v * 3.6
        x1 = cx + r * math.cos(math.radians(a)); y1 = cy + r * math.sin(math.radians(a))
        x2 = cx + r * math.cos(math.radians(b)); y2 = cy + r * math.sin(math.radians(b))
        big = 1 if v * 3.6 > 180 else 0
        s.append(f'<path d="M {cx} {cy} L {x1:.0f} {y1:.0f} A {r} {r} 0 {big} 1 {x2:.0f} {y2:.0f} Z" fill="#fff" stroke="#000" stroke-width="1.5"/>')
        m = math.radians((a + b) / 2)
        lx = cx + (r + 22) * math.cos(m); ly = cy + (r + 22) * math.sin(m)
        anch = 'start' if math.cos(m) >= 0 else 'end'
        s.append(f'<text x="{lx:.0f}" y="{ly:.0f}" font-size="13" font-weight="bold" text-anchor="{anch}">{name}</text>')
        if name == 'lezení':
            s.append(f'<text x="{lx:.0f}" y="{ly+15:.0f}" font-size="13" text-anchor="{anch}">18 dětí</text>')
        if name == 'plavání':
            s.append(f'<text x="{lx:.0f}" y="{ly+15:.0f}" font-size="13" text-anchor="{anch}">26 dětí</text>')
        a = b
    s.append('</svg>')
    return "".join(s)
SVG14 = _pie()


# úloha 17: šedý čtverec/obdélník s bílými čtverci (1, 2 a 5 bílých čtverců)
def _white(n, ox, oy, s):
    H, W = n + 2, 2 * n + 1
    out = [f'<rect x="{ox}" y="{oy}" width="{W*s}" height="{H*s}" fill="#d0d0d0" stroke="#000" stroke-width="1.5"/>']
    def pt(x, y):
        return f'{ox+x*s},{oy+(H-y)*s}'
    for k in range(1, n + 1):
        pts = f'{pt(2*k-1, n+3-k)} {pt(2*k+1, n+2-k)} {pt(2*k, n-k)} {pt(2*k-2, n-k+1)}'
        out.append(f'<polygon points="{pts}" fill="#fff" stroke="#000" stroke-width="1.5"/>')
    out.append(f'<text x="{ox+s//2}" y="{oy-6}" font-size="12" text-anchor="middle">1</text>')
    out.append(f'<text x="{ox-6}" y="{oy+s+4}" font-size="12" text-anchor="end">2</text>')
    out.append(f'<text x="{ox+W*s+6}" y="{oy+s+4}" font-size="12">2</text>')
    out.append(f'<text x="{ox+W*s-s//2}" y="{oy+H*s+16}" font-size="12" text-anchor="middle">1</text>')
    return "".join(out)

def _fig17():
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 580 230" font-family="sans-serif">']
    s.append(_white(1, 30, 40, 22))
    s.append(_white(2, 160, 40, 22))
    s.append('<text x="300" y="120" font-size="20" text-anchor="middle">…</text>')
    s.append(_white(5, 320, 40, 22))
    s.append('<text x="570" y="120" font-size="20" text-anchor="middle">…</text>')
    s.append('<text x="290" y="222" font-size="12" text-anchor="middle">Rozměry v obrázcích jsou v cm.</text>')
    s.append('</svg>')
    return "".join(s)
SVG17 = _fig17()

B = ['zs2', 'r7']  # 7. ročník ZŠ – přijímačky na šestileté obory

PROBLEMS = [
    {'name': 'CERMAT M7B 2017 – úloha 1', 'zad': [
        'Vypočtěte:',
        '$20-0{,}6\\cdot(-0{,}8)-20+(-0{,}6\\cdot 8)=$'], 'opts': None, 'ln': 2,
     'sol': ['$20-0{,}6\\cdot(-0{,}8)=20+0{,}48=20{,}48$.',
             '$20{,}48-20=0{,}48$ a $-0{,}6\\cdot 8=-4{,}8$.',
             'Celkem $0{,}48+(-4{,}8)=-4{,}32$.'],
     'ans': '$-4{,}32$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2017 – úloha 2', 'zad': [
        'V zápisu výpočtu chybí poslední číslice u prvního čísla (tj. u dělence).',
        'Doplňte číslici tak, aby dělení vyšlo beze zbytku, a příklad vypočtěte:',
        '$490\\square : 12 =$'], 'opts': None, 'ln': 2,
     'sol': ['Číslo $490\\square$ musí být dělitelné 12, tedy 4 i 3 zároveň.',
             'Dělitelnost 4: poslední dvojčíslí $0\\square$ dělitelné 4, tj. číslice $0$, $4$ nebo $8$.',
             'Dělitelnost 3: ciferný součet $4+9+0+\\square=13+\\square$ dělitelný 3, tj. číslice $2$, $5$ nebo $8$.',
             'Vyhovuje jediná číslice $8$: $4\\,908:12=409$.'],
     'ans': '$4\\,908:12=409$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2017 – úloha 3.1', 'zad': [
        'Vypočtěte a výsledek uveďte zlomkem v základním tvaru.',
        '$\\frac{9}{16}:\\left(\\frac{1}{2}+\\frac{3}{4}+\\frac{5}{8}\\right)=$'], 'opts': None, 'ln': 3,
     'sol': ['V závorce převedeme na osminy: $\\frac{4}{8}+\\frac{6}{8}+\\frac{5}{8}=\\frac{15}{8}$.',
             'Dělení zlomkem: $\\frac{9}{16}:\\frac{15}{8}=\\frac{9}{16}\\cdot\\frac{8}{15}=\\frac{72}{240}=\\frac{3}{10}$.'],
     'ans': '$\\frac{3}{10}$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2017 – úloha 3.2', 'zad': [
        'Vypočtěte a výsledek uveďte zlomkem v základním tvaru.',
        '$\\frac{9\\cdot 5}{10\\cdot 6}-\\frac{9+5}{10+6}=$'], 'opts': None, 'ln': 3,
     'sol': ['$\\frac{9\\cdot 5}{10\\cdot 6}=\\frac{45}{60}=\\frac{3}{4}$ a $\\frac{9+5}{10+6}=\\frac{14}{16}=\\frac{7}{8}$.',
             '$\\frac{3}{4}-\\frac{7}{8}=\\frac{6}{8}-\\frac{7}{8}=-\\frac{1}{8}$.'],
     'ans': '$-\\frac{1}{8}$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2017 – úloha 4.1', 'zad': [
        'Vypočtěte, o kolik mm více je $1{,}8$ dm než $15$ mm.'], 'opts': None, 'ln': 2,
     'sol': ['$1{,}8$ dm $=180$ mm.', '$180-15=165$ mm.'],
     'ans': 'o $165$ mm', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2017 – úloha 4.2', 'zad': [
        'V cm² vypočtěte $\\frac{5}{6}$ z $0{,}48$ dm².'], 'opts': None, 'ln': 2,
     'sol': ['$\\frac{5}{6}$ z $0{,}48$ dm² $=0{,}48:6\\cdot 5=0{,}08\\cdot 5=0{,}4$ dm².',
             '$1$ dm² $=100$ cm², tedy $0{,}4$ dm² $=40$ cm².'],
     'ans': '$40$ cm²', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2017 – úloha 5', 'zad': [
        'Kuličky v sáčku se mohou rozdělit beze zbytku rovným dílem mezi 3 děti, 4 děti a také mezi 6 dětí. Kdyby se kuličky rozdělily rovným dílem mezi 5 dětí, tři kuličky by zbyly. Do sáčku se nevejde více než 100 kuliček.',
        '5.1 Určete počet kuliček v sáčku.',
        '5.2 Do sáčku přidáme tolik dalších kuliček, aby se kuličky v sáčku mohly rozdělit beze zbytku rovným dílem mezi 5 dětí a také 6 dětí, nikoli však mezi 4 děti. Určete nový počet kuliček v sáčku.'],
     'opts': None, 'ln': 3,
     'sol': ['5.1 Počet musí být dělitelný 3, 4 i 6, tedy je násobkem 12: $12, 24, 36, 48, 60, 72, 84, 96$.',
             'Zbytek po dělení pěti má být 3; to splňuje jen $48$ (a $48\\le 100$).',
             '5.2 Nový počet je dělitelný 5 i 6, tedy je násobkem 30 a je větší než 48: přichází v úvahu $60$ a $90$.',
             '$60$ je dělitelné 4, proto nevyhovuje; $90$ dělitelné 4 není a $90\\le 100$.'],
     'ans': '5.1: $48$ kuliček; 5.2: $90$ kuliček', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['aritmetika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7B 2017 – úloha 6', 'zad': [
        'Na plánku lyžařské běžecké trati jsou vyznačena stanoviště $A$, $B$, stánek a místo, v němž je start i cíl. Od startu běží závodníci ke stanovišti $B$, od něhož se stejnou cestou vrací do cíle. U stánku dostávají závodníci při cestě tam i zpět občerstvení. Vzdálenost stanovišť $A$ a $B$ je $8$ km.',
        '6.1 Stánek je o $2$ km blíž ke stanovišti $A$ než ke stanovišti $B$. Určete, kolik km musí závodníci uběhnout mezi prvním a druhým občerstvením.',
        '6.2 V okamžiku, kdy závodníci míjí místo $A$ poprvé, mají za sebou šestinu celého závodu. Určete v km délku celého závodu.'],
     'opts': None, 'ln': 3, 'svg': SVG6, 'fn': 'planek-trati.svg',
     'alt': 'Plánek trati: na přímce leží zleva stanoviště B, stánek, stanoviště A a místo startu i cíle; vzdálenost B a A je 8 km.',
     'cap': 'Plánek lyžařské běžecké trati',
     'sol': ['6.1 Je-li vzdálenost stánku od $A$ rovna $x$, pak od $B$ je $x+2$ a platí $x+(x+2)=8$, tedy $x=3$ km.',
             'Od stánku k $B$ je to $5$ km; mezi občerstvením závodník uběhne tam i zpět, tj. $2\\cdot 5=10$ km.',
             '6.2 Je-li vzdálenost startu od $A$ rovna $s$, je celý závod dlouhý $2\\cdot(s+8)$ km.',
             'Podle zadání $s=\\frac{1}{6}\\cdot 2\\cdot(s+8)$, tj. $3s=s+8$, odtud $s=4$ km.',
             'Délka závodu je $2\\cdot(4+8)=24$ km.'],
     'ans': '6.1: $10$ km; 6.2: $24$ km', 'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7B 2017 – úloha 7', 'zad': [
        'Tři stejně těžké bedny váží tolik jako pět stejných krabic. Nejtěžší náklad, který se smí naložit do výtahu, váží tolik jako 35 krabic.',
        '7.1 Určete největší počet beden, které se smí naložit do prázdného výtahu.',
        '7.2 Určete největší počet krabic, které se smí do výtahu přidat k 11 bednám.'],
     'opts': None, 'ln': 3,
     'sol': ['7.1 Tři bedny odpovídají pěti krabicím, tedy $35$ krabic odpovídá $35:5\\cdot 3=21$ bednám.',
             '7.2 $11$ beden váží jako $\\frac{11\\cdot 5}{3}=\\frac{55}{3}$ krabice.',
             'Zbývá $35-\\frac{55}{3}=\\frac{50}{3}=16\\frac{2}{3}$ krabice, celých krabic tedy nejvýše $16$.'],
     'ans': '7.1: $21$ beden; 7.2: $16$ krabic', 'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7B 2017 – úloha 8', 'zad': [
        'V akváriu tvaru kvádru se čtvercovou podstavou je voda napuštěna do výšky $2$ dm. Dno akvária má obsah $36$ dm².',
        '8.1 Vypočtěte v litrech objem vody v akváriu.',
        '8.2 Vypočtěte v dm² obsah všech ploch smáčených vodou (tj. dna a částí stěn).'],
     'opts': None, 'ln': 3, 'svg': SVG8, 'fn': 'akvarium.svg',
     'alt': 'Akvárium tvaru kvádru se čtvercovou podstavou, voda vyplňuje spodní část a její hladina je vyznačena.',
     'cap': 'Akvárium tvaru kvádru (schematicky)',
     'sol': ['8.1 $V=S_{\\text{dna}}\\cdot h=36\\cdot 2=72$ dm³ $=72$ litrů.',
             '8.2 Podstava je čtverec o obsahu $36$ dm², tedy strana měří $6$ dm.',
             'Smáčené jsou dno a čtyři obdélníky $6\\times 2$ dm: $36+4\\cdot 12=36+48=84$ dm².'],
     'ans': '8.1: $72$ litrů; 8.2: $84$ dm²', 'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['stereometrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7B 2017 – úloha 9', 'zad': [
        'V rovině leží rovnoběžník $ABCD$ (viz obrázek).',
        '9.1 Sestrojte střed $S$ rovnoběžníku $ABCD$.',
        '9.2 V rovnoběžníku $ABCD$ sestrojte všechny jeho výšky procházející středem $S$.',
        '9.3 V sestrojeném obrázku najděte a vyznačte libovolné dva pravé úhly.'],
     'opts': None, 'ln': 0, 'svg': SVG9, 'fn': 'rovnobeznik-ABCD.svg',
     'alt': 'Rovnoběžník ABCD s vrcholem C nahoře, B vpravo, A dole a D vlevo.',
     'cap': 'Výchozí obrázek k úloze 9',
     'sol': ['9.1 Střed $S$ je průsečík úhlopříček $AC$ a $BD$.',
             '9.2 Bodem $S$ vedeme kolmici ke straně $AB$ (a tím i ke straně $CD$) – výška $v_a$ – a kolmici ke straně $BC$ (a tím i ke straně $AD$) – výška $v_b$. Obě výšky procházejí středem $S$.',
             '9.3 Pravé úhly jsou v patách obou výšek, tj. tam, kde výšky protínají strany rovnoběžníku; vyznačíme libovolné dva z nich.'],
     'ans': 'Střed $S$ = průsečík úhlopříček $AC$ a $BD$; obě výšky $v_a$ (kolmá k $AB$ a $CD$) a $v_b$ (kolmá k $BC$ a $AD$) vedené bodem $S$; vyznačené dva pravé úhly v patách výšek – viz obrázek v klíči.',
     'pts': 3, 'mins': 7, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2017 – úloha 10', 'zad': [
        'V rovině leží body $A$, $S$ a přímka $p$ procházející bodem $S$ (viz obrázek).',
        'Bod $A$ je vrchol rovnoběžníku $ABCD$, bod $S$ je jeho střed. Jedna z úhlopříček rovnoběžníku $ABCD$ leží na přímce $p$. Úhlopříčka, která neleží na přímce $p$, je současně jednou z výšek rovnoběžníku $ABCD$.',
        'Sestrojte chybějící vrcholy $B$, $C$, $D$ rovnoběžníku $ABCD$ a rovnoběžník narýsujte.'],
     'opts': None, 'ln': 0, 'svg': SVG10, 'fn': 'primka-p-bod-A.svg',
     'alt': 'Vodorovná přímka p s vyznačeným bodem S a bod A ležící pod přímkou vlevo od bodu S.',
     'cap': 'Výchozí obrázek k úloze 10',
     'sol': ['Bod $A$ na přímce $p$ neleží, proto na $p$ leží úhlopříčka $BD$ a úhlopříčka $AC$ je výškou.',
             'Vrchol $C$ získáme jako obraz bodu $A$ ve středové souměrnosti se středem $S$ (tj. $S$ je střed úsečky $AC$).',
             'Protože $AC$ je výška, je $AC$ kolmá na strany $BC$ a $AD$. Bodem $C$ vedeme kolmici k $AC$; její průsečík s přímkou $p$ je vrchol $B$.',
             'Vrchol $D$ je obraz bodu $B$ ve středové souměrnosti se středem $S$. Zbývá narýsovat rovnoběžník $ABCD$.'],
     'ans': '$C$ = obraz $A$ ve středové souměrnosti se středem $S$; $B$ = průsečík přímky $p$ s kolmicí k $AC$ vedenou bodem $C$; $D$ = obraz $B$ podle středu $S$ – viz obrázek v klíči.',
     'pts': 3, 'mins': 8, 'diff': '4',
     'codes': B + ['konstrukce', 'modelovani', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2017 – úloha 11', 'zad': [
        'Z jednoho ze dvou shodných čtverců s délkou strany $6$ cm se odstřihl obdélník a přemístil se ke druhému čtverci. Rozměry obdélníku jsou $4$ cm a $2$ cm. Tak vznikly obrazce I a II (viz obrázek).',
        'Rozhodněte o každém z následujících tvrzení (11.1–11.3), zda je pravdivé (A), či nikoli (N).',
        '11.1 Obvod obrazce I je menší než obvod obrazce II.',
        '11.2 Obsah obrazce II je o $16$ cm² větší než obsah obrazce I.',
        '11.3 Obsah obrazce II je $\\frac{11}{7}$ obsahu obrazce I.'],
     'opts': None, 'ln': 0, 'svg': SVG11, 'fn': 'obrazce-I-II.svg',
     'alt': 'Obrazec I je čtverec 6 krát 6 cm s vyříznutým obdélníkem 2 krát 4 cm u pravé strany, obrazec II je čtverec 6 krát 6 cm s připojeným obdélníkem 2 krát 4 cm u levé strany.',
     'cap': 'Obrazec I a obrazec II',
     'sol': ['Obsah čtverce je $36$ cm², obsah odstřiženého obdélníku $4\\cdot 2=8$ cm².',
             'Obrazec I má obsah $36-8=28$ cm², obrazec II má obsah $36+8=44$ cm².',
             '11.1 Obvod I: $24-4+(2+4+2)=28$ cm; obvod II: $24-4+(2+4+2)=28$ cm. Obvody jsou stejné, tvrzení tedy neplatí → N.',
             '11.2 $44-28=16$ cm² → A.',
             '11.3 $\\frac{44}{28}=\\frac{11}{7}$ → A.'],
     'ans': '11.1: Ne; 11.2: Ano; 11.3: Ano', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['planimetrie', 'argumentace', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2017 – úloha 12', 'zad': [
        'Tmavý obrazec ve čtvercové síti se skládá ze dvou trojúhelníků. Strana čtverce sítě měří $5$ cm.',
        'Jaký je obsah tmavého obrazce?'],
     'opts': ['A) $37{,}5$ cm²', 'B) $38$ cm²', 'C) $38{,}5$ cm²', 'D) $39$ cm²', 'E) jiný obsah'],
     'ln': 0, 'svg': SVG12, 'fn': 'sit-trojuhelniky.svg',
     'alt': 'Čtvercová síť se čtvercem o straně 5 cm; tmavý obrazec tvoří dva trojúhelníky se společným vrcholem.',
     'cap': 'Tmavý obrazec ve čtvercové síti',
     'sol': ['Větší trojúhelník má svislou stranu dlouhou dva čtverce, tj. $10$ cm, a výšku k ní jeden čtverec, tj. $5$ cm: $S_1=\\frac{10\\cdot 5}{2}=25$ cm².',
             'Menší trojúhelník má svislou stranu $5$ cm a výšku $5$ cm: $S_2=\\frac{5\\cdot 5}{2}=12{,}5$ cm².',
             'Celkem $25+12{,}5=37{,}5$ cm².'],
     'ans': 'A) $37{,}5$ cm²', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2017 – úloha 13', 'zad': [
        'Čtyřúhelník $ABCD$ se skládá z rovnostranného trojúhelníku $ABC$ (strany $a$) a rovnoramenného trojúhelníku $ACD$ (ramena $b$). Vnitřní úhel čtyřúhelníku při vrcholu $C$ měří $133^\\circ$.',
        'Jaká je velikost úhlu $\\delta$ při vrcholu $D$? Úhel $\\delta$ neměřte, ale vypočtěte.'],
     'opts': ['A) menší než $34^\\circ$', 'B) $34^\\circ$', 'C) $36^\\circ$', 'D) $37^\\circ$', 'E) větší než $37^\\circ$'],
     'ln': 0, 'svg': SVG13, 'fn': 'ctyruhelnik-ABCD.svg',
     'alt': 'Čtyřúhelník ABCD složený z rovnostranného trojúhelníku ABC se stranami a a rovnoramenného trojúhelníku ACD s rameny b; u vrcholu C je vyznačen úhel 133 stupňů, u vrcholu D úhel delta.',
     'cap': 'Čtyřúhelník ABCD',
     'sol': ['V rovnostranném trojúhelníku $ABC$ je úhel $ACB=60^\\circ$.',
             'Proto úhel $ACD=133^\\circ-60^\\circ=73^\\circ$.',
             'Trojúhelník $ACD$ je rovnoramenný s rameny $b=|AD|=|CD|$, takže úhly při základně $AC$ jsou shodné: $|\\angle DAC|=|\\angle DCA|=73^\\circ$.',
             '$\\delta=180^\\circ-2\\cdot 73^\\circ=34^\\circ$.'],
     'ans': 'B) $34^\\circ$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2017 – úloha 14', 'zad': [
        'Každé ze 100 dětí uvedlo jednu aktivitu, kterou má ze všech nabízených aktivit nejraději. Výsledky jsou vyznačeny v diagramu: lezení uvedlo 18 dětí, plavání 26 dětí.',
        'Dále bylo zjištěno: dětí, které mají nejraději kino, je dvakrát více než těch, které mají nejraději fotbal; dětí, které mají nejraději fotbal, je dvakrát více než těch, které mají nejraději cyklistiku.',
        'Kolik dětí má nejraději fotbal?'],
     'opts': ['A) 10 dětí', 'B) 12 dětí', 'C) 14 dětí', 'D) 16 dětí', 'E) 18 dětí'],
     'ln': 0, 'svg': SVG14, 'fn': 'diagram-aktivity.svg',
     'alt': 'Kruhový diagram AKTIVITY rozdělený na pět výsečí: lezení (18 dětí), kino, fotbal, plavání (26 dětí) a cyklistika.',
     'cap': 'Diagram AKTIVITY (celkem 100 dětí)',
     'sol': ['Na kino, fotbal a cyklistiku připadá $100-18-26=56$ dětí.',
             'Označme cyklistiku $c$; pak fotbal $2c$ a kino $4c$, tedy $c+2c+4c=7c=56$, odtud $c=8$.',
             'Fotbal má nejraději $2c=16$ dětí.'],
     'ans': 'D) 16 dětí', 'pts': 2, 'mins': 4, 'diff': '2',
     'codes': B + ['statistika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7B 2017 – úloha 15', 'zad': [
        'Adam, Bořek a Cyril dostali za úkol vylepit 300 plakátů. Každý z chlapců má své stálé pracovní tempo. Kdyby pracoval každý sám, Adam by vylepil všechny plakáty za 4 hodiny a Bořek za 6 hodin.',
        'Ve skutečnosti Adam vylepoval plakáty jen 2 hodiny a Bořek 1 hodinu. Zbytek plakátů vylepil Cyril.',
        'Kolik plakátů vylepil Cyril?'],
     'opts': ['A) 60', 'B) 75', 'C) 100', 'D) 120', 'E) více než 120'], 'ln': 0,
     'sol': ['Adam vylepí $300:4=75$ plakátů za hodinu, za 2 hodiny tedy $150$ plakátů.',
             'Bořek vylepí $300:6=50$ plakátů za hodinu, za 1 hodinu tedy $50$ plakátů.',
             'Cyril vylepil $300-150-50=100$ plakátů.'],
     'ans': 'C) 100', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7B 2017 – úloha 16', 'zad': [
        'Přiřaďte ke každé úloze (16.1–16.3) odpovídající výsledek (A–F).',
        '16.1 Radek váží $28$ kg a Petr váží o $25\\,\\%$ více než Radek. Kolik kg váží Petr?',
        '16.2 Aby se snížila hmotnost zavazadla na $85\\,\\%$, muselo se z něj odebrat $6$ kg. Kolik kg váží odlehčené zavazadlo?',
        '16.3 Aleš váží $24$ kg, tedy o třetinu méně než Dan. Kolik kg váží Dan?'],
     'opts': ['A) méně než 33 kg', 'B) 33 kg', 'C) 34 kg', 'D) 35 kg', 'E) 36 kg', 'F) více než 36 kg'],
     'ln': 0,
     'sol': ['16.1 $25\\,\\%$ z $28$ kg je $7$ kg, tedy Petr váží $28+7=35$ kg → D.',
             '16.2 Odebraných $6$ kg odpovídá $15\\,\\%$ původní hmotnosti, tj. $1\\,\\%$ je $0{,}4$ kg a celek $40$ kg. Odlehčené zavazadlo váží $85\\,\\%$ ze $40$ kg, tj. $34$ kg (nebo $40-6=34$ kg) → C.',
             '16.3 Aleš váží dvě třetiny hmotnosti Dana: $\\frac{2}{3}d=24$, tedy $d=36$ kg → E.'],
     'ans': '16.1: D ($35$ kg); 16.2: C ($34$ kg); 16.3: E ($36$ kg)', 'pts': 6, 'mins': 7, 'diff': '3',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7B 2017 – úloha 17', 'zad': [
        'Uvnitř šedého čtverce je umístěn bílý čtverec. Vrcholy bílého čtverce rozdělují každou stranu šedého čtverce na dva úseky dlouhé $1$ cm a $2$ cm.',
        'Obdobným způsobem se umístí větší počet stejných bílých čtverců v řadě do šedého obdélníku. S přibývajícím počtem bílých čtverců se mění i délky stran šedého obdélníku. Rozměry v obrázcích jsou v cm.',
        '17.1 Určete délky stran šedého obdélníku se dvěma bílými čtverci.',
        '17.2 Určete délky stran šedého obdélníku s pěti bílými čtverci.',
        '17.3 Delší strana šedého obdélníku měří $185$ cm. Určete délku kratší strany tohoto obdélníku.'],
     'opts': None, 'ln': 3, 'svg': SVG17, 'fn': 'sede-obdelniky.svg',
     'alt': 'Tři obrázky: šedý čtverec 3 krát 3 cm s jedním bílým čtvercem, šedý obdélník se dvěma bílými čtverci a šedý obdélník s pěti bílými čtverci umístěnými v řadě.',
     'cap': 'Šedý čtverec a šedé obdélníky s bílými čtverci',
     'sol': ['U jednoho bílého čtverce je šedý útvar čtverec o straně $1+2=3$ cm.',
             'Každý další bílý čtverec posune obrazec o $2$ cm ve vodorovném a o $1$ cm ve svislém směru.',
             'Pro $n$ bílých čtverců je delší strana $2n+1$ cm a kratší strana $n+2$ cm.',
             '17.1 $n=2$: kratší $2+2=4$ cm, delší $2\\cdot 2+1=5$ cm.',
             '17.2 $n=5$: kratší $5+2=7$ cm, delší $2\\cdot 5+1=11$ cm.',
             '17.3 $2n+1=185$, tedy $n=92$; kratší strana měří $92+2=94$ cm.'],
     'ans': '17.1: $4$ cm a $5$ cm; 17.2: $7$ cm a $11$ cm; 17.3: $94$ cm', 'pts': 4, 'mins': 7, 'diff': '4',
     'codes': B + ['posloupnosti', 'argumentace', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M7PBD17C0T02'
    gen.YEAR = 2017

    def dollars_ok(s): return s.count('$') % 2 == 0
    errors = []; names = set(); pts_sum = 0
    for p in PROBLEMS:
        if p['name'] in names: errors.append('DUP název: ' + p['name'])
        names.add(p['name'])
        if 'M7B' not in p['name']: errors.append('Chybí M7B v názvu: ' + p['name'])
        pts_sum += p['pts']
        for t in [p['name'], p['ans']] + list(p['zad']) + list(p['sol']) + (p.get('opts') or []):
            if not dollars_ok(t): errors.append('Nepárový $: ' + t[:70])
        if p.get('svg') and ("'" in p['svg'] or '\\' in p['svg']):
            errors.append('SVG zakázaný znak: ' + p['name'])
        if p.get('svg') and not p.get('alt'): errors.append('Obrázek bez alt: ' + p['name'])
        for lbl, obj in (('content', gen.py_content_json(p)), ('solution', gen.py_solution_json(p)), ('answer', gen.py_answer_json(p))):
            try: json.loads(json.dumps(obj, ensure_ascii=False))
            except Exception as e: errors.append(f'JSON {lbl} {p["name"]}: {e}')
    if pts_sum != 50: errors.append(f'Součet bodů je {pts_sum}, má být 50')
    if errors:
        print('CHYBY:'); [print('  -', e) for e in errors]; sys.exit(1)
    print('Validace OK:', len(PROBLEMS), 'úloh, body celkem:', pts_sum)
    outdir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'out')
    os.makedirs(outdir, exist_ok=True)
    tot = 0
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M7B-2017')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
