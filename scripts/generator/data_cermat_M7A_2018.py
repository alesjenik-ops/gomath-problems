# -*- coding: utf-8 -*-
# CERMAT - Jednotna prijimaci zkouska 2018, MATEMATIKA 7 (sestilete obory, 7. rocnik), varianta A, 1. radny termin.
# Kod testu: M7PAD18C0T01. 16 uloh (50 bodu).
# Struktura: uloha 3 rozdelena na 3.1 a 3.2 (KSR boduje samostatne 2+2 b.); ulohy 13 a 14 slouceny (sdileny graf).
# Zdroj odpovedi: klic spravnych reseni (KSR); struktura overena vyplnenym/prazdnym zaznamovym archem (VZA).

# ---- SVG obrazky (bez ' a \) ----

# uloha 5: farmar Maly (pytle po 30 kg) a Velky (pytle po 50 kg) - schematicka ilustrace
SVG5 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 190" font-family="sans-serif" font-size="13">
<text x="150" y="18" text-anchor="middle">Farmář Malý (pytle po 30 kg)</text>
<text x="420" y="18" text-anchor="middle">Farmář Velký (pytle po 50 kg)</text>
<rect x="30" y="30" width="250" height="140" fill="none" stroke="#000"/>
<rect x="300" y="30" width="250" height="140" fill="none" stroke="#000"/>
<g stroke="#000" fill="#f0f0f0">
<ellipse cx="70" cy="105" rx="19" ry="34"/><ellipse cx="118" cy="105" rx="19" ry="34"/><ellipse cx="166" cy="105" rx="19" ry="34"/>
</g>
<text x="200" y="112" font-size="18">...</text>
<rect x="232" y="118" width="34" height="42" fill="#b9b9b9" stroke="#000"/>
<text x="150" y="185" text-anchor="middle" font-size="12">zbývá 150 kg</text>
<g stroke="#000" fill="#f0f0f0">
<ellipse cx="345" cy="100" rx="23" ry="42"/><ellipse cx="410" cy="100" rx="23" ry="42"/><ellipse cx="475" cy="100" rx="23" ry="42"/>
</g>
<text x="510" y="108" font-size="18">...</text>
</svg>"""

# uloha 6: tri obdelniky s jednou stranou 68 cm a druhou stranou (?) rostouci
SVG6 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 200" font-family="sans-serif" font-size="13">
<rect x="80" y="30" width="24" height="120" fill="none" stroke="#000" stroke-width="1.5"/>
<text x="55" y="95" text-anchor="middle">68 cm</text>
<text x="92" y="170" text-anchor="middle">?</text>
<rect x="190" y="30" width="60" height="120" fill="none" stroke="#000" stroke-width="1.5"/>
<text x="165" y="95" text-anchor="middle">68 cm</text>
<text x="220" y="170" text-anchor="middle">?</text>
<text x="300" y="95" font-size="20">...</text>
<rect x="360" y="30" width="150" height="120" fill="none" stroke="#000" stroke-width="1.5"/>
<text x="535" y="95" text-anchor="middle">68 cm</text>
<text x="435" y="170" text-anchor="middle">?</text>
</svg>"""

# uloha 7: 10 svetlych kulicek (horni rada) a tmave kulicky (dalsi rady) + ...
def _kulicky():
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 175" font-family="sans-serif">']
    r = 16
    for i in range(10):
        cx = 42 + i * 52
        s.append(f'<circle cx="{cx}" cy="35" r="{r}" fill="#d8d8d8" stroke="#000"/>')
    for i in range(10):
        cx = 42 + i * 52
        s.append(f'<circle cx="{cx}" cy="85" r="{r}" fill="#555" stroke="#000"/>')
    for i in range(6):
        cx = 42 + i * 52
        s.append(f'<circle cx="{cx}" cy="135" r="{r}" fill="#555" stroke="#000"/>')
    s.append('<text x="360" y="144" font-size="24" font-weight="bold">...</text>')
    s.append('</svg>')
    return ''.join(s)
SVG7 = _kulicky()

# uloha 8: primky b, c, d (b a c se protinaji, d je nad nimi)
SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 380" font-family="sans-serif" font-size="15">
<line x1="60" y1="72" x2="440" y2="72" stroke="#000" stroke-width="1.6"/>
<text x="60" y="94" font-style="italic">d</text>
<line x1="110" y1="300" x2="470" y2="170" stroke="#000" stroke-width="1.6"/>
<text x="476" y="172" font-style="italic">c</text>
<line x1="150" y1="110" x2="430" y2="350" stroke="#000" stroke-width="1.6"/>
<text x="436" y="352" font-style="italic">b</text>
</svg>"""

# uloha 9: usecka AD (A vlevo dole, D vpravo nahore) a bod S_BC (x) vpravo dole
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 290" font-family="sans-serif" font-size="15">
<line x1="90" y1="200" x2="320" y2="120" stroke="#000" stroke-width="1.8"/>
<line x1="84" y1="188" x2="96" y2="212" stroke="#000" stroke-width="1.6"/>
<line x1="314" y1="108" x2="326" y2="132" stroke="#000" stroke-width="1.6"/>
<text x="70" y="206" font-style="italic">A</text>
<text x="326" y="116" font-style="italic">D</text>
<line x1="344" y1="210" x2="356" y2="222" stroke="#000" stroke-width="1.6"/>
<line x1="356" y1="210" x2="344" y2="222" stroke="#000" stroke-width="1.6"/>
<text x="350" y="242" font-style="italic">S</text><text x="364" y="246" font-size="11">BC</text>
</svg>"""

# uloha 10: ctvercova sit 8x7, bile obrazce A (ctyruhelnik) a B (trojuhelnik), referencni ctvverecek 4 cm2
def _sit():
    cell = 34; ox = 30; oy = 20; W = 8; H = 7
    def P(cx, cy):
        return f'{ox + cx * cell},{oy + cy * cell}'
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {ox * 2 + W * cell} {oy * 2 + H * cell + 8}" font-family="sans-serif" font-size="15">']
    for i in range(W + 1):
        s.append(f'<line x1="{ox + i * cell}" y1="{oy}" x2="{ox + i * cell}" y2="{oy + H * cell}" stroke="#777"/>')
    for j in range(H + 1):
        s.append(f'<line x1="{ox}" y1="{oy + j * cell}" x2="{ox + W * cell}" y2="{oy + j * cell}" stroke="#777"/>')
    s.append(f'<rect x="{ox + 7 * cell}" y="{oy + 6 * cell}" width="{cell}" height="{cell}" fill="#b9b9b9" stroke="#000"/>')
    s.append(f'<polygon points="{P(0,1)} {P(6,1)} {P(3,4)} {P(1,4)}" fill="#ffffff" stroke="#000" stroke-width="2.2"/>')
    s.append(f'<polygon points="{P(6,1)} {P(8,1)} {P(5,5)}" fill="#ffffff" stroke="#000" stroke-width="2.2"/>')
    s.append(f'<text x="{ox + 2 * cell}" y="{oy * 1 + 2 * cell + 6}" font-weight="bold">A</text>')
    s.append(f'<text x="{ox + 6 * cell + 8}" y="{oy + 2 * cell}" font-weight="bold">B</text>')
    s.append(f'<text x="{ox + 7 * cell + cell // 2}" y="{oy + 7 * cell + 20}" text-anchor="middle" font-size="12">4 cm&#178;</text>')
    s.append('</svg>')
    return ''.join(s)
SVG10 = _sit()

# uloha 12: tri primky protinajici vodorovnou primku; uhly 60, 40, 30 a alfa, beta, gama, delta
SVG12 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 360" font-family="sans-serif" font-size="15">
<line x1="20" y1="250" x2="505" y2="250" stroke="#000" stroke-width="1.6"/>
<line x1="95" y1="340" x2="185" y2="35" stroke="#000" stroke-width="1.6"/>
<line x1="120" y1="250" x2="430" y2="124" stroke="#000" stroke-width="1.6"/>
<line x1="175" y1="55" x2="495" y2="290" stroke="#000" stroke-width="1.6"/>
<text x="150" y="228" font-size="13">60&#176;</text>
<text x="188" y="244" font-style="italic">&#946;</text>
<text x="96" y="278" font-style="italic">&#947;</text>
<text x="158" y="92" font-style="italic">&#948;</text>
<text x="290" y="150" font-size="13">40&#176;</text>
<text x="352" y="150" font-style="italic">&#945;</text>
<text x="408" y="242" font-size="13">30&#176;</text>
</svg>"""

# ulohy 13-14: sloupcovy graf nasporene castky tridy za 1 az 6 mesicu; 6. mesic neznamy (?)
def _graf():
    x0 = 70; base = 330; topY = 40; vmax = 2400
    sc = (base - topY) / float(vmax)
    data = [('za 1 měsíc', 100), ('za 2 měsíce', 300), ('za 3 měsíce', 600),
            ('za 4 měsíce', 1000), ('za 5 měsíců', 1500), ('za 6 měsíců', None)]
    bw = 44; gap = 24
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 380" font-family="sans-serif" font-size="12">']
    s.append('<text x="290" y="22" text-anchor="middle" font-size="15">Naspořená částka třídy 7. A</text>')
    s.append('<text x="18" y="200" transform="rotate(-90 18 200)" text-anchor="middle">Počet korun</text>')
    s.append(f'<line x1="{x0}" y1="{topY}" x2="{x0}" y2="{base}" stroke="#000"/>')
    s.append(f'<line x1="{x0}" y1="{base}" x2="540" y2="{base}" stroke="#000"/>')
    for v in range(0, vmax + 1, 200):
        y = base - v * sc
        s.append(f'<line x1="{x0}" y1="{y}" x2="540" y2="{y}" stroke="#e2e2e2"/>')
        if v % 400 == 0:
            s.append(f'<line x1="{x0 - 4}" y1="{y}" x2="{x0}" y2="{y}" stroke="#000"/>')
            s.append(f'<text x="{x0 - 8}" y="{y + 4}" text-anchor="end">{v}</text>')
    x = x0 + gap
    for name, val in data:
        if val is None:
            s.append(f'<rect x="{x}" y="{topY}" width="{bw}" height="{base - topY}" fill="none" stroke="#bbb" stroke-dasharray="4 4"/>')
            s.append(f'<text x="{x + bw / 2}" y="{(topY + base) / 2}" text-anchor="middle" font-size="26" font-weight="bold">?</text>')
        else:
            h = val * sc
            s.append(f'<rect x="{x}" y="{base - h}" width="{bw}" height="{h}" fill="#9a9a9a" stroke="#000"/>')
        s.append(f'<text x="{x + bw / 2}" y="{base + 16}" text-anchor="middle" font-size="11">{name}</text>')
        x += bw + gap
    s.append('</svg>')
    return ''.join(s)
SVG1314 = _graf()

# ---- Ulohy ----

B = ['zs2', 'r7']  # 7. rocnik, sestilete obory

PROBLEMS = [
    {'name': 'CERMAT M7A 2018 – úloha 1',
     'zad': ['Zapište zlomkem v základním tvaru dvě pětiny z $\\frac{30}{24}$.'],
     'opts': None, 'ln': 2,
     'sol': ['Dvě pětiny z $\\frac{30}{24}$: $\\frac{2}{5}\\cdot\\frac{30}{24}=\\frac{60}{120}=\\frac{1}{2}$.'],
     'ans': '$\\frac{1}{2}$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2018 – úloha 2',
     'zad': ['Vypočtěte.',
             '2.1  $5\\cdot 0{,}6:0{,}012=$',
             '2.2  $50-[2{,}7-(28{,}3+2{,}7)\\cdot 0]-28{,}3=$'],
     'opts': None, 'ln': 2,
     'sol': ['2.1 $5\\cdot 0{,}6=3$, dále $3:0{,}012=250$.',
             '2.2 $(28{,}3+2{,}7)\\cdot 0=0$, takže $50-[2{,}7-0]-28{,}3=50-2{,}7-28{,}3=19$.'],
     'ans': '2.1: $250$; 2.2: $19$', 'pts': 3, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2018 – úloha 3.1',
     'zad': ['Vypočtěte a výsledek zapište zlomkem v základním tvaru.',
             '$\\frac{4}{3}+3\\cdot\\left(\\frac{1}{3}-\\frac{3}{5}\\right)=$'],
     'opts': None, 'ln': 3,
     'sol': ['$\\frac{1}{3}-\\frac{3}{5}=\\frac{5-9}{15}=-\\frac{4}{15}$; $3\\cdot\\left(-\\frac{4}{15}\\right)=-\\frac{4}{5}$; $\\frac{4}{3}-\\frac{4}{5}=\\frac{20-12}{15}=\\frac{8}{15}$.'],
     'ans': '$\\frac{8}{15}$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2018 – úloha 3.2',
     'zad': ['Vypočtěte a výsledek zapište zlomkem v základním tvaru.',
             '$\\dfrac{\\frac{5}{6}\\cdot\\frac{4}{35}}{1+\\frac{1}{3}-\\frac{2}{7}}=$'],
     'opts': None, 'ln': 3,
     'sol': ['Čitatel: $\\frac{5}{6}\\cdot\\frac{4}{35}=\\frac{20}{210}=\\frac{2}{21}$. Jmenovatel: $1+\\frac{1}{3}-\\frac{2}{7}=\\frac{21+7-6}{21}=\\frac{22}{21}$. Podíl: $\\frac{2}{21}:\\frac{22}{21}=\\frac{2}{22}=\\frac{1}{11}$.'],
     'ans': '$\\frac{1}{11}$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2018 – úloha 4',
     'zad': ['Doplňte do rámečku takové číslo, aby platila rovnost.',
             '4.1  $2$ m² $-\\,50$ cm² $=\\;?\\;$ dm²',
             '4.2  $(5-?)$ minuty $-\\,15$ sekund $=75$ sekund'],
     'opts': None, 'ln': 2,
     'sol': ['4.1 $2$ m² $=200$ dm² a $50$ cm² $=0{,}5$ dm²; $200-0{,}5=199{,}5$ dm².',
             '4.2 $75+15=90$ sekund $=1{,}5$ minuty; z rovnosti $5-?=1{,}5$ plyne $?=3{,}5$.'],
     'ans': '4.1: $199{,}5$; 4.2: $3{,}5$', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2018 – úloha 5',
     'zad': ['Farmář Malý plní svou úrodu pšenice do malých pytlů. Do každého pytle se vejde $30$ kg pšenice. Již tři čtvrtiny své úrody má v pytlích a na hromadě mu zbývá posledních $150$ kg pšenice. Farmář Velký má o polovinu větší úrodu pšenice než farmář Malý. Celou svou úrodu již uskladnil ve velkých pytlích, do každého nasypal $50$ kg pšenice.',
             '5.1 Vypočtěte, kolik malých pytlů pšenice již farmář Malý naplnil.',
             '5.2 Vypočtěte, v kolika velkých pytlích uskladnil celou svou úrodu farmář Velký.'],
     'opts': None, 'ln': 3, 'svg': SVG5, 'fn': 'pytle.svg',
     'alt': 'Schéma: vlevo pytle farmáře Malého se zbývající hromadou 150 kg, vpravo pytle farmáře Velkého.',
     'cap': 'Výchozí obrázek k úloze 5 (schematicky)',
     'sol': ['Zbývajících $150$ kg je jedna čtvrtina úrody Malého, celá úroda je tedy $4\\cdot 150=600$ kg; v pytlích má tři čtvrtiny, tj. $\\frac{3}{4}\\cdot 600=450$ kg.',
             '5.1 Malých pytlů po $30$ kg: $450:30=15$ pytlů.',
             '5.2 Úroda Velkého $=1{,}5\\cdot 600=900$ kg; velkých pytlů po $50$ kg: $900:50=18$ pytlů.'],
     'ans': '5.1: $15$ pytlů; 5.2: $18$ pytlů', 'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7A 2018 – úloha 6',
     'zad': ['Papírový obdélník je možné beze zbytku rozstříhat na čtverce se stranou délky $17$ cm. Jedna strana tohoto obdélníku měří $68$ cm, druhá strana měří méně než $100$ cm.',
             '6.1 Určete v cm obvod nejmenšího z možných obdélníků.',
             '6.2 Určete, na kolik čtverců s délkou strany $17$ cm je možné rozstříhat největší z možných obdélníků.'],
     'opts': None, 'ln': 3, 'svg': SVG6, 'fn': 'obdelniky.svg',
     'alt': 'Tři obdélníky s jednou stranou 68 cm a druhou stranou označenou otazníkem, rostoucí zleva doprava.',
     'cap': 'Výchozí obrázek k úloze 6 (schematicky)',
     'sol': ['Strana $68$ cm $=4\\cdot 17$ cm. Druhá strana je násobkem $17$ cm menším než $100$ cm, tedy $17$, $34$, $51$, $68$ nebo $85$ cm.',
             '6.1 Nejmenší obdélník má rozměry $68$ cm $\\times 17$ cm; obvod $=2\\cdot(68+17)=170$ cm.',
             '6.2 Největší obdélník má rozměry $68$ cm $\\times 85$ cm, tj. $4\\times 5=20$ čtverců.'],
     'ans': '6.1: $170$ cm; 6.2: $20$ čtverců', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2018 – úloha 7',
     'zad': ['Na stole bylo $10$ světlých kuliček a o něco více tmavých kuliček. Eva a Ivo si rozdělili všech $10$ světlých kuliček tak, že Eva si vzala o $4$ kuličky více než Ivo. Eva si pak vzala ještě několik tmavých kuliček a Ivo si jich vzal dvakrát více než Eva. Dohromady obě děti odebraly jen tolik tmavých kuliček, aby měly celkový počet kuliček stejný.',
             '7.1 Vypočtěte, kolik světlých kuliček si vzala Eva.',
             '7.2 Vypočtěte, kolik tmavých kuliček si vzal Ivo.',
             '7.3 Vypočtěte, kolik kuliček si celkem vzala Eva.'],
     'opts': None, 'ln': 3, 'svg': SVG7, 'fn': 'kulicky.svg',
     'alt': 'Deset světlých kuliček v horní řadě a pod nimi tmavé kuličky (o něco více), řada pokračuje.',
     'cap': 'Výchozí obrázek k úloze 7',
     'sol': ['7.1 Světlých je $10$, Eva má o $4$ více než Ivo: $E+I=10$, $E=I+4$, tedy $I=3$ a $E=7$. Eva si vzala $7$ světlých kuliček.',
             '7.2 Eva má $7$, Ivo $3$ světlé. Eva vezme $x$ tmavých, Ivo $2x$ tmavých. Stejné celkové počty: $7+x=3+2x$, tedy $x=4$; Ivo si vzal $2x=8$ tmavých kuliček.',
             '7.3 Eva má celkem $7+4=11$ kuliček.'],
     'ans': '7.1: $7$; 7.2: $8$; 7.3: $11$', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2018 – úloha 8',
     'zad': ['V rovině leží přímky $b$, $c$, $d$ (viz obrázek).',
             'V průsečíku přímek $b$, $c$ je vrchol $A$ obdélníku $ABCD$. Vrchol $B$ téhož obdélníku leží na přímce $b$, vrchol $C$ na přímce $c$ a vrchol $D$ na přímce $d$.',
             'Sestrojte chybějící vrcholy obdélníku $ABCD$, označte je písmeny a obdélník narýsujte.'],
     'opts': None, 'ln': 0, 'svg': SVG8, 'fn': 'primky-bcd.svg',
     'alt': 'Tři přímky b, c, d v rovině; přímky b a c se protínají, přímka d je nad nimi.',
     'cap': 'Výchozí obrázek k úloze 8',
     'sol': ['Vrchol $A$ je průsečík přímek $b$ a $c$. Strana $AB$ leží na přímce $b$, proto je strana $AD$ kolmá k $b$: v bodě $A$ sestrojíme kolmici k přímce $b$ a její průsečík s přímkou $d$ je vrchol $D$. Bodem $D$ vedeme rovnoběžku s přímkou $b$; její průsečík s přímkou $c$ je vrchol $C$. Vrchol $B$ leží na přímce $b$ (jako pata kolmice z $C$ k $b$, resp. $B=A+(C-D)$).'],
     'ans': 'Obdélník $ABCD$: $A$ je průsečík přímek $b$ a $c$; $D$ leží na přímce $d$ na kolmici k $b$ v bodě $A$; $C$ je na přímce $c$ na rovnoběžce s $b$ vedené bodem $D$; $B$ leží na přímce $b$. Viz obrázek v klíči.',
     'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2018 – úloha 9',
     'zad': ['V rovině leží úsečka $AD$ a bod $S_{BC}$ (viz obrázek). Body $A$, $D$ jsou vrcholy rovnoběžníku $ABCD$, bod $S_{BC}$ je střed strany $BC$ tohoto rovnoběžníku.',
             '9.1 Sestrojte přímku $p$, na níž leží chybějící vrcholy $B$, $C$ rovnoběžníku $ABCD$.',
             '9.2 Sestrojte střed $S$ rovnoběžníku.',
             '9.3 Sestrojte chybějící vrcholy rovnoběžníku $ABCD$ a rovnoběžník narýsujte.'],
     'opts': None, 'ln': 0, 'svg': SVG9, 'fn': 'usecka-AD-SBC.svg',
     'alt': 'Úsečka AD (A vlevo dole, D vpravo nahoře) a bod S_BC vyznačený křížkem vpravo pod úsečkou.',
     'cap': 'Výchozí obrázek k úloze 9',
     'sol': ['9.1 V rovnoběžníku je $BC$ rovnoběžná s $AD$; přímka $p$ je tedy rovnoběžka s přímkou $AD$ vedená bodem $S_{BC}$.',
             '9.2 Střed $S$ rovnoběžníku je střed úsečky spojující střed strany $AD$ a bod $S_{BC}$ (leží také na úhlopříčce $AC$).',
             '9.3 Protože $BC$ je rovnoběžná a stejně dlouhá jako $AD$ a $S_{BC}$ je střed $BC$, naneseme na přímku $p$ na obě strany od $S_{BC}$ polovinu délky $AD$; dostaneme vrcholy $B$ a $C$. Rovnoběžník $ABCD$ narýsujeme.'],
     'ans': 'Přímka $p$ je rovnoběžka s $AD$ vedená bodem $S_{BC}$; na ni od $S_{BC}$ naneseme na obě strany $\\frac{1}{2}|AD|$ (vrcholy $B$, $C$); střed $S$ je střed úsečky $S_{AD}S_{BC}$. Viz obrázek v klíči.',
     'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2018 – úloha 10',
     'zad': ['Čtvercová síť je tvořena čtverečky s obsahem $4$ cm². Ve čtvercové síti jsou zakresleny bílé obrazce $A$, $B$ s vrcholy v mřížových bodech (viz obrázek).',
             'Rozhodněte o každém z následujících tvrzení (10.1–10.3), zda je pravdivé (A), či nikoli (N).',
             '10.1 Obsah obrazce $A$ je $40$ cm².',
             '10.2 Obsah obrazce $B$ je třikrát menší než obsah obrazce $A$.',
             '10.3 Obvod obrazce $B$ je o $8$ cm menší než obvod obrazce $A$.'],
     'opts': None, 'ln': 0, 'svg': SVG10, 'fn': 'sit-AB.svg',
     'alt': 'Čtvercová síť 8 krát 7 čtverečků s bílými obrazci A (čtyřúhelník vlevo) a B (úzký trojúhelník vpravo); vpravo dole je vyznačen čtvereček o obsahu 4 cm².',
     'cap': 'Bílé obrazce A a B ve čtvercové síti',
     'sol': ['Jeden čtvereček má obsah $4$ cm² (strana $2$ cm). Obrazec $A$ zabírá $12$ čtverečků, tj. $12\\cdot 4=48$ cm²; obrazec $B$ zabírá $4$ čtverečky, tj. $4\\cdot 4=16$ cm².',
             '10.1 Obsah obrazce $A$ je $48$ cm², nikoli $40$ cm² → Ne.',
             '10.2 Platí $48:16=3$, obsah obrazce $B$ je třikrát menší než obsah obrazce $A$ → Ano.',
             '10.3 Obvody obou obrazců určíme z obrázku (strana čtverečku měří $2$ cm); obvod obrazce $B$ je o $8$ cm menší než obvod obrazce $A$ → Ano.'],
     'ans': '10.1: Ne; 10.2: Ano; 10.3: Ano', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['planimetrie', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2018 – úloha 11',
     'zad': ['V $7$ h začalo pršet. Dešťová voda stékala ze střechy do jímky s dutinou tvaru kvádru. Kvádr má podstavu o rozměrech $50$ cm $\\times 40$ cm a výšku $70$ cm. Před deštěm sahala voda v jímce do výšky $10$ cm. Při dešti se za každou minutu objem vody v jímce zvětšil o $5$ litrů.',
             'Kdy začala jímka přetékat?'],
     'opts': ['A) v 7 h 20 min', 'B) v 7 h 24 min', 'C) v 7 h 28 min', 'D) v 7 h 30 min', 'E) v jiném okamžiku'],
     'ln': 0,
     'sol': ['Jímka je plná při výšce $70$ cm; doplnit je třeba $70-10=60$ cm. Objem $=50\\cdot 40\\cdot 60=120\\,000$ cm³ $=120$ litrů. Při přírůstku $5$ litrů za minutu to trvá $120:5=24$ minut, tedy jímka začala přetékat v $7$ h $24$ min.'],
     'ans': 'B) v 7 h 24 min', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['stereometrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7A 2018 – úloha 12',
     'zad': ['Na obrázku jsou vyznačeny úhly o velikostech $60^\\circ$, $40^\\circ$, $30^\\circ$ a neznámé úhly $\\alpha$, $\\beta$, $\\gamma$, $\\delta$. Velikosti úhlů neměřte.',
             'Jaký je součet velikostí $\\alpha+\\beta+\\gamma+\\delta$?'],
     'opts': ['A) menší než $340^\\circ$', 'B) $340^\\circ$', 'C) $350^\\circ$', 'D) $360^\\circ$', 'E) větší než $360^\\circ$'],
     'ln': 0, 'svg': SVG12, 'fn': 'uhly.svg',
     'alt': 'Tři přímky protínající vodorovnou přímku a navzájem; vyznačeny úhly 60°, 40°, 30° a neznámé úhly alfa, beta, gama, delta.',
     'cap': 'Výchozí obrázek k úloze 12',
     'sol': ['Neznámé úhly $\\alpha$, $\\beta$, $\\gamma$, $\\delta$ se dopočítají z označených úhlů $60^\\circ$, $40^\\circ$, $30^\\circ$ pomocí součtu vnitřních úhlů trojúhelníku ($180^\\circ$) a vlastností vedlejších a vrcholových úhlů. Součet vychází $\\alpha+\\beta+\\gamma+\\delta=360^\\circ$.'],
     'ans': 'D) $360^\\circ$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2018 – úloha 13–14',
     'zad': ['Třída 7. A s $20$ žáky spořila půl roku na podporu adoptovaného hrocha. Všichni žáci přispívali rovným dílem, ale každý měsíc vyšší částkou; příspěvek žáka se každý měsíc zvyšoval o stejnou částku. Z grafu lze vyčíst, jak v průběhu pěti měsíců narůstala naspořená částka celé třídy 7. A (např. za $3$ měsíce třída naspořila celkem $600$ korun).',
             '13 O kolik korun se každý měsíc zvýšil příspěvek každého žáka třídy 7. A? A) o 5 korun; B) o 10 korun; C) o 15 korun; D) o 20 korun; E) o více než 20 korun',
             '14 Kolika korunami přispěl každý žák během půl roku (celkem za 6 měsíců)? A) méně než 100 korunami; B) 100 korunami; C) 105 korunami; D) 110 korunami; E) více než 110 korunami'],
     'opts': None, 'ln': 0, 'svg': SVG1314, 'fn': 'graf-uspory.svg',
     'alt': 'Sloupcový graf naspořené částky třídy za 1 až 6 měsíců: 100, 300, 600, 1000, 1500 korun; sloupec za 6 měsíců je označen otazníkem.',
     'cap': 'Naspořená částka třídy 7. A',
     'sol': ['Z grafu: naspořeno celkem za 1 až 5 měsíců je $100$, $300$, $600$, $1000$, $1500$ korun. Měsíční přírůstky celé třídy jsou $100$, $200$, $300$, $400$, $500$ korun, tedy každý měsíc o $100$ korun více.',
             '13 Přírůstek celé třídy roste o $100$ korun měsíčně; na jednoho z $20$ žáků připadá $100:20=5$ korun → A).',
             '14 Za $6$ měsíců naspoří třída celkem $1500+600=2100$ korun; na žáka $2100:20=105$ korun → C).'],
     'ans': '13: A) o 5 korun; 14: C) 105 korunami', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['statistika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7A 2018 – úloha 15',
     'zad': ['Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).',
             '15.1 Snížení ceny svetru o $20\\,\\%$ znamená zlevnění o $90$ korun. Jaká je cena zlevněného svetru?',
             '15.2 Kalkulačka stojí $400$ korun. Při zakoupení $4$ kusů kalkulaček se získává $20\\,\\%$ sleva z celkové ceny čtyř kalkulaček. Jaká je průměrná cena jedné kalkulačky zakoupené se slevou?',
             '15.3 Výrobek s $20\\,\\%$ přirážkou stojí $360$ korun. Jaká je cena výrobku bez přirážky?'],
     'opts': ['A) nižší než $300$ korun', 'B) $300$ korun', 'C) $320$ korun', 'D) $340$ korun', 'E) $360$ korun', 'F) vyšší než $360$ korun'],
     'ln': 0,
     'sol': ['15.1 $20\\,\\%$ ceny je $90$ korun, tedy $100\\,\\%=450$ korun; zlevněná cena $450-90=360$ korun → E).',
             '15.2 Cena čtyř kalkulaček je $4\\cdot 400=1600$ korun, se slevou $20\\,\\%$: $1600\\cdot 0{,}8=1280$ korun; na jednu $1280:4=320$ korun → C).',
             '15.3 $120\\,\\%$ ceny je $360$ korun, tedy $100\\,\\%=360:1{,}2=300$ korun → B).'],
     'ans': '15.1: E) $360$ korun; 15.2: C) $320$ korun; 15.3: B) $300$ korun', 'pts': 6, 'mins': 9, 'diff': '3',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'finance']},

    {'name': 'CERMAT M7A 2018 – úloha 16',
     'zad': ['Na obrazovce počítače jsou dvě čísla – jedno v modrém a druhé v červeném poli. Na počátku jsou obě čísla stejná. Při každém pípnutí se obě čísla zvětší – v modrém poli o $1$ a v červeném o $3$. V jednu chvíli se na obrazovce objeví v modrém poli číslo $49$ a současně v červeném poli číslo $129$.',
             '16.1 Určete, jaké číslo je v modrém poli na počátku.',
             '16.2 Určete číslo v modrém poli v okamžiku, kdy je o $30$ menší než číslo v červeném poli.',
             '16.3 Určete číslo v červeném poli v okamžiku, kdy je součet čísel v obou polích $2\\,018$.'],
     'opts': None, 'ln': 3,
     'sol': ['Po $n$ pípnutích je v modrém poli $p+n$ a v červeném $p+3n$, kde $p$ je počáteční číslo. Z $p+n=49$ a $p+3n=129$ plyne $2n=80$, tedy $n=40$ a $p=9$.',
             '16.1 Na počátku je v modrém poli číslo $9$.',
             '16.2 Rozdíl polí je po $k$ pípnutích $2k$; z $2k=30$ plyne $k=15$, v modrém poli je $9+15=24$.',
             '16.3 Součet $=(9+k)+(9+3k)=18+4k=2\\,018$, tedy $k=500$; v červeném poli je $9+3\\cdot 500=1\\,509$.'],
     'ans': '16.1: $9$; 16.2: $24$; 16.3: $1\\,509$', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M7PAD18C0T01'
    gen.YEAR = 2018

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
    tot_pts = sum(p['pts'] for p in PROBLEMS)
    print('Součet bodů:', tot_pts)
    outdir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'out')
    os.makedirs(outdir, exist_ok=True)
    tot = 0
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M7A-2018')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
