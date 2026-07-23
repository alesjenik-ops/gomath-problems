# -*- coding: utf-8 -*-
# CERMAT - Jednotna prijimaci zkouska 2019, MATEMATIKA 7 (sestilete obory, 7. rocnik), varianta A, 1. radny termin.
# Kod testu: M7PAD19C0T01. 16 uloh (50 bodu).
# Struktura: uloha 3 rozdelena na 3.1 a 3.2 (KSR boduje samostatne 2+2 b.); ulohy 13 a 14 slouceny (sdileny graf).
# Zdroj odpovedi: klic spravnych reseni (KSR); struktura overena vyplnenym/prazdnym zaznamovym archem (VZA).

# ---- SVG obrazky (bez ' a \) ----

# uloha 7: dve telesa z krychle o hrane 10 cm (kvadr 10x10x7 a hranol s lichobeznikovou podstavou 10 a 7)
SVG7 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 580 235" font-family="sans-serif" font-size="13">
<text x="105" y="18" text-anchor="middle">Prvni teleso</text>
<text x="420" y="18" text-anchor="middle">Druhe teleso</text>
<polygon points="40,150 150,150 150,205 40,205" fill="#efefef" stroke="#000" stroke-width="1.5"/>
<polygon points="40,150 70,122 180,122 150,150" fill="#f7f7f7" stroke="#000" stroke-width="1.5"/>
<polygon points="150,150 180,122 180,177 150,205" fill="#e3e3e3" stroke="#000" stroke-width="1.5"/>
<polygon points="40,122 70,94 180,94 150,122" fill="none" stroke="#999" stroke-width="1" stroke-dasharray="4 4"/>
<line x1="40" y1="150" x2="40" y2="122" stroke="#999" stroke-width="1" stroke-dasharray="4 4"/>
<line x1="150" y1="150" x2="150" y2="122" stroke="#999" stroke-width="1" stroke-dasharray="4 4"/>
<line x1="180" y1="122" x2="180" y2="94" stroke="#999" stroke-width="1" stroke-dasharray="4 4"/>
<line x1="70" y1="122" x2="70" y2="94" stroke="#999" stroke-width="1" stroke-dasharray="4 4"/>
<text x="95" y="223" text-anchor="middle">10 cm</text>
<text x="185" y="183">7 cm</text>
<polygon points="330,120 330,205 440,205 440,150" fill="#efefef" stroke="#000" stroke-width="1.5"/>
<polygon points="330,120 358,100 468,130 440,150" fill="#f7f7f7" stroke="#000" stroke-width="1.5"/>
<polygon points="440,150 468,130 468,185 440,205" fill="#e3e3e3" stroke="#000" stroke-width="1.5"/>
<text x="308" y="168">10 cm</text>
<text x="474" y="185">7 cm</text>
<text x="385" y="223" text-anchor="middle">10 cm</text>
</svg>"""

# uloha 8: bod P a uhel TCU (vrchol C, ramena CT svisle a CU sikmo dolu)
SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 300" font-family="sans-serif" font-size="14">
<line x1="70" y1="45" x2="70" y2="255" stroke="#000" stroke-width="1.6"/>
<line x1="70" y1="45" x2="395" y2="190" stroke="#000" stroke-width="1.6"/>
<text x="55" y="42" font-style="italic">C</text>
<text x="55" y="268" font-style="italic">T</text>
<text x="400" y="196" font-style="italic">U</text>
<line x1="64" y1="238" x2="76" y2="238" stroke="#000" stroke-width="1.6"/>
<line x1="368" y1="172" x2="378" y2="184" stroke="#000" stroke-width="1.6"/>
<line x1="140" y1="188" x2="152" y2="200" stroke="#000" stroke-width="1.8"/>
<line x1="152" y1="188" x2="140" y2="200" stroke="#000" stroke-width="1.8"/>
<text x="140" y="220" font-style="italic">P</text>
</svg>"""

# uloha 9: kruznice k se stredem S, primka p a bod D
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 430 330" font-family="sans-serif" font-size="14">
<circle cx="215" cy="160" r="135" fill="none" stroke="#000" stroke-width="1.6"/>
<text x="88" y="115" font-style="italic">k</text>
<line x1="65" y1="240" x2="390" y2="278" stroke="#000" stroke-width="1.6"/>
<text x="398" y="283" font-style="italic">p</text>
<line x1="209" y1="156" x2="221" y2="168" stroke="#000" stroke-width="1.6"/>
<line x1="221" y1="156" x2="209" y2="168" stroke="#000" stroke-width="1.6"/>
<text x="224" y="176" font-style="italic">S</text>
<line x1="252" y1="104" x2="264" y2="116" stroke="#000" stroke-width="1.6"/>
<line x1="264" y1="104" x2="252" y2="116" stroke="#000" stroke-width="1.6"/>
<text x="268" y="112" font-style="italic">D</text>
</svg>"""

# uloha 10: tri obrazce ze ctvercu a rovnoramennych trojuhelniku
SVG10 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 210" font-family="sans-serif" font-size="13">
<text x="95" y="20" text-anchor="middle">1. obrazec</text>
<text x="285" y="20" text-anchor="middle">2. obrazec</text>
<text x="470" y="20" text-anchor="middle">3. obrazec</text>
<rect x="60" y="150" width="40" height="40" fill="none" stroke="#000" stroke-width="1.5"/>
<rect x="100" y="150" width="40" height="40" fill="none" stroke="#000" stroke-width="1.5"/>
<rect x="100" y="110" width="40" height="40" fill="none" stroke="#000" stroke-width="1.5"/>
<rect x="215" y="150" width="40" height="40" fill="none" stroke="#000" stroke-width="1.5"/>
<rect x="255" y="150" width="40" height="40" fill="none" stroke="#000" stroke-width="1.5"/>
<rect x="295" y="150" width="40" height="40" fill="none" stroke="#000" stroke-width="1.5"/>
<polygon points="215,150 255,150 228,70" fill="none" stroke="#000" stroke-width="1.5"/>
<polygon points="255,150 335,150 268,95" fill="none" stroke="#000" stroke-width="1.5"/>
<rect x="425" y="150" width="40" height="40" fill="none" stroke="#000" stroke-width="1.5"/>
<rect x="465" y="150" width="40" height="40" fill="none" stroke="#000" stroke-width="1.5"/>
<line x1="425" y1="110" x2="425" y2="150" stroke="#000" stroke-width="1.5"/>
<line x1="465" y1="110" x2="465" y2="150" stroke="#000" stroke-width="1.5"/>
<polygon points="418,86 425,110 525,110" fill="none" stroke="#000" stroke-width="1.5"/>
</svg>"""

# uloha 11: uhly alfa, alfa+20, 2alfa, beta; dvojite znacky = rovnobezna ramena
SVG11 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 290" font-family="sans-serif" font-size="15">
<line x1="55" y1="175" x2="335" y2="70" stroke="#000" stroke-width="1.7"/>
<line x1="55" y1="175" x2="360" y2="262" stroke="#000" stroke-width="1.7"/>
<line x1="250" y1="92" x2="315" y2="285" stroke="#000" stroke-width="1.7"/>
<line x1="300" y1="240" x2="430" y2="222" stroke="#000" stroke-width="1.7"/>
<line x1="295" y1="80" x2="303" y2="62" stroke="#000" stroke-width="1.5"/>
<line x1="303" y1="83" x2="311" y2="65" stroke="#000" stroke-width="1.5"/>
<line x1="378" y1="228" x2="388" y2="212" stroke="#000" stroke-width="1.5"/>
<line x1="386" y1="231" x2="396" y2="215" stroke="#000" stroke-width="1.5"/>
<text x="255" y="128" font-style="italic">&#946;</text>
<text x="205" y="212">&#945; + 20&#176;</text>
<text x="322" y="215">2&#945;</text>
<text x="262" y="262" font-style="italic">&#945;</text>
</svg>"""

# ulohy 13-14: sloupcovy graf poctu zaku (vsichni / chlapci / divky), chybejici sloupce = ?
def _graf():
    years = [
        ('1. rok', 27, 15, 12, '', '', ''),
        ('2. rok', 25, None, 10, '', '?', ''),
        ('3. rok', 28, 16, None, '', '', '?'),
        ('4. rok', 30, None, 14, '', '?', ''),
        ('5. rok', 29, 16, 13, '', '', ''),
        ('6. rok', 22, None, 10, '', '?', ''),
    ]
    x0, y0 = 60, 300
    sc = 8.0
    gw = 150
    bw = 26
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 350" font-family="sans-serif" font-size="12">']
    s.append('<text x="18" y="170" transform="rotate(-90 18 170)" text-anchor="middle">Pocet zaku</text>')
    s.append(f'<line x1="{x0}" y1="20" x2="{x0}" y2="{y0}" stroke="#000"/>')
    s.append(f'<line x1="{x0}" y1="{y0}" x2="600" y2="{y0}" stroke="#000"/>')
    for v in range(0, 33, 4):
        y = y0 - v * sc
        s.append(f'<line x1="{x0-4}" y1="{y}" x2="{x0}" y2="{y}" stroke="#000"/>')
        s.append(f'<text x="{x0-8}" y="{y+4}" text-anchor="end">{v}</text>')
    x = x0 + 14
    for name, allv, boys, girls, fa, fb, fg in years:
        cols = [(allv, '#9a9a9a', fa), (boys, '#454545', fb), (girls, '#dcdcdc', fg)]
        bx = x
        for val, col, flag in cols:
            if val is not None:
                h = val * sc
                s.append(f'<rect x="{bx}" y="{y0-h}" width="{bw}" height="{h}" fill="{col}" stroke="#000" stroke-width="0.8"/>')
            if flag:
                s.append(f'<text x="{bx+bw/2}" y="{y0-100}" text-anchor="middle" font-size="16">?</text>')
            bx += bw + 2
        s.append(f'<text x="{x+ (3*bw+4)/2}" y="{y0+16}" text-anchor="middle">{name}</text>')
        x += 3 * bw + 4 + 12
    lx = 470
    s.append(f'<rect x="{lx}" y="40" width="12" height="12" fill="#9a9a9a" stroke="#000"/><text x="{lx+18}" y="50">Vsichni zaci</text>')
    s.append(f'<rect x="{lx}" y="60" width="12" height="12" fill="#454545" stroke="#000"/><text x="{lx+18}" y="70">Chlapci</text>')
    s.append(f'<rect x="{lx}" y="80" width="12" height="12" fill="#dcdcdc" stroke="#000"/><text x="{lx+18}" y="90">Divky</text>')
    s.append('</svg>')
    return ''.join(s)
SVG1314 = _graf()

# uloha 16: tri nejmensi ctvercove labyrinty (spiraly ze sirek)
def _spiral(cx, cy, step, rings):
    x, y = cx, cy
    pts = [(x, y)]
    dirs = [(step, 0), (0, -step), (-step, 0), (0, step)]
    di = 0
    seg = 1
    total = rings * 2
    while di < total + 1:
        dx, dy = dirs[di % 4]
        for _ in range(seg):
            x += dx
            y += dy
            pts.append((x, y))
        di += 1
        if di % 2 == 0:
            seg += 1
    return pts
def _laby():
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 210" font-family="sans-serif" font-size="14">']
    cfg = [(95, '1. labyrint', 1, 24), (275, '2. labyrint', 2, 18), (455, '3. labyrint', 3, 13)]
    for cx, lab, rings, step in cfg:
        pts = _spiral(cx, 120, step, rings)
        minx = min(px for px, py in pts); maxx = max(px for px, py in pts)
        cxm = (minx + maxx) / 2
        d = ' '.join(f'{px},{py}' for px, py in pts)
        s.append(f'<polyline points="{d}" fill="none" stroke="#000" stroke-width="2.6"/>')
        s.append(f'<text x="{cxm}" y="32" text-anchor="middle" font-weight="bold">{lab}</text>')
    s.append('</svg>')
    return ''.join(s)
SVG16 = _laby()

# ---- Ulohy ----

B = ['zs2', 'r7']  # 7. rocnik, sestilete obory

PROBLEMS = [
    {'name': 'CERMAT M7A 2019 – úloha 1',
     'zad': ['Vypočtěte, kolik procent je $150$ gramů ze tří čtvrtin kilogramu.'],
     'opts': None, 'ln': 2,
     'sol': ['Tři čtvrtiny kilogramu jsou $750$ g. Podíl $\\frac{150}{750}=\\frac{1}{5}=0{,}2$, tj. $20\\,\\%$.'],
     'ans': '$20\\,\\%$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['procenta', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2019 – úloha 2',
     'zad': ['Vypočtěte.',
             '2.1  $25\\cdot 0{,}2-0{,}2\\cdot 15=$',
             '2.2  $0{,}03:(-0{,}12)-0{,}5=$'],
     'opts': None, 'ln': 2,
     'sol': ['2.1 $25\\cdot 0{,}2-0{,}2\\cdot 15=5-3=2$.',
             '2.2 $0{,}03:(-0{,}12)-0{,}5=-0{,}25-0{,}5=-0{,}75$.'],
     'ans': '2.1: $2$; 2.2: $-0{,}75$', 'pts': 3, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2019 – úloha 3.1',
     'zad': ['Vypočtěte a výsledek zapište zlomkem v základním tvaru.',
             '$\\frac{6}{7}\\cdot\\left(\\frac{5}{6}-\\frac{3}{4}\\right)-1=$'],
     'opts': None, 'ln': 3,
     'sol': ['$\\frac{5}{6}-\\frac{3}{4}=\\frac{10-9}{12}=\\frac{1}{12}$; dále $\\frac{6}{7}\\cdot\\frac{1}{12}=\\frac{1}{14}$; a $\\frac{1}{14}-1=-\\frac{13}{14}$.'],
     'ans': '$-\\frac{13}{14}$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2019 – úloha 3.2',
     'zad': ['Vypočtěte a výsledek zapište zlomkem v základním tvaru.',
             '$\\dfrac{\\frac{9}{4}:\\frac{15}{2}}{3\\cdot\\frac{2}{15}+\\frac{2}{5}}=$'],
     'opts': None, 'ln': 3,
     'sol': ['Čitatel: $\\frac{9}{4}:\\frac{15}{2}=\\frac{9}{4}\\cdot\\frac{2}{15}=\\frac{3}{10}$. Jmenovatel: $3\\cdot\\frac{2}{15}+\\frac{2}{5}=\\frac{2}{5}+\\frac{2}{5}=\\frac{4}{5}$. Podíl: $\\frac{3}{10}:\\frac{4}{5}=\\frac{3}{10}\\cdot\\frac{5}{4}=\\frac{3}{8}$.'],
     'ans': '$\\frac{3}{8}$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2019 – úloha 4',
     'zad': ['4.1  Automobil široký $1\\,770$ mm jel v jízdním pruhu širokém $3$ m $25$ cm. Jízdní pruh se zúžil o půl metru. Vypočtěte, o kolik centimetrů je zúžený jízdní pruh širší než automobil.',
             '4.2  Cesta z Prahy do Žiliny autobusem trvala $6$ hodin a $20$ minut, vlakem jen $4$ hodiny a $45$ minut. Vypočtěte, o kolik minut trvala cesta autobusem déle než vlakem.'],
     'opts': None, 'ln': 3,
     'sol': ['4.1 Zúžený pruh $325-50=275$ cm; automobil $177$ cm; rozdíl $275-177=98$ cm.',
             '4.2 Autobus $6$ h $20$ min $=380$ min, vlak $4$ h $45$ min $=285$ min; rozdíl $380-285=95$ min.'],
     'ans': '4.1: o $98$ cm; 4.2: o $95$ minut', 'pts': 3, 'mins': 5, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7A 2019 – úloha 5',
     'zad': ['Martin má krok dlouhý $60$ cm a jeho tatínek $90$ cm. Od školy k nim domů vede jediná cesta a Martin na ní udělá $1\\,200$ kroků.',
             '5.1 Vypočtěte, kolik kroků na této cestě udělá tatínek.',
             '5.2 Tatínek vyrazil z domova naproti Martinovi, který šel touto cestou od školy domů. Než se setkali, udělali oba stejný počet kroků. Vypočtěte, kolik kroků udělal Martin od školy k místu setkání.'],
     'opts': None, 'ln': 3,
     'sol': ['5.1 Délka cesty $60\\cdot 1\\,200=72\\,000$ cm; tatínek $72\\,000:90=800$ kroků.',
             '5.2 Za stejný počet kroků $n$ ujdou dohromady celou cestu: $60n+90n=72\\,000$, tj. $150n=72\\,000$, $n=480$. Martin udělal $480$ kroků.'],
     'ans': '5.1: $800$ kroků; 5.2: $480$ kroků', 'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7A 2019 – úloha 6',
     'zad': ['Všechny modré a červené kuličky jsou rozděleny do tří stejně početných skupin A, B, C po $120$ kuličkách. Ve skupině A jsou jen modré kuličky a ve skupině B jen červené kuličky. Skupina C obsahuje čtvrtinu z celkového počtu modrých kuliček a zbytek červených.',
             '6.1 Určete počet modrých kuliček ve skupině C.',
             '6.2 Určete počet všech červených kuliček.',
             '6.3 Vyjádřete v základním tvaru poměr počtu modrých a počtu červených kuliček ve skupině C (v uvedeném pořadí).'],
     'opts': None, 'ln': 3,
     'sol': ['Celkem $3\\cdot 120=360$ kuliček. Skupina A má $120$ modrých a skupina C obsahuje čtvrtinu všech modrých, takže $120$ modrých ze skupiny A jsou $\\frac{3}{4}$ všech modrých. Všech modrých je $160$, všech červených $360-160=200$.',
             '6.1 Modrých v C je $\\frac{1}{4}\\cdot 160=40$.',
             '6.2 Všech červených je $200$.',
             '6.3 V C je $120-40=80$ červených; poměr modrých ku červeným $40:80=1:2$.'],
     'ans': '6.1: $40$; 6.2: $200$; 6.3: $1:2$', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2019 – úloha 7',
     'zad': ['Ze dvou krychlí s hranou délky $10$ cm jsme vytvořili dvě nová tělesa. První těleso vzniklo z krychle po odříznutí části tvaru kvádru. Druhé těleso vzniklo z krychle po odříznutí části tvaru trojbokého hranolu. Nejkratší hrana prvního i druhého tělesa měří $7$ cm (viz obrázek).',
             '7.1 Vypočtěte v cm³ objem prvního tělesa.',
             '7.2 Vypočtěte v cm³ objem druhého tělesa.'],
     'opts': None, 'ln': 3, 'svg': SVG7, 'fn': 'telesa.svg',
     'alt': 'Dvě tělesa vzniklá z krychle o hraně 10 cm: první odříznutím kvádru (nejkratší hrana 7 cm), druhé odříznutím trojbokého hranolu (nejkratší hrana 7 cm).',
     'cap': 'První a druhé těleso (schematicky)',
     'sol': ['7.1 První těleso je kvádr $10\\times 10\\times 7$: objem $10\\cdot 10\\cdot 7=700$ cm³.',
             '7.2 Druhé těleso je hranol s podstavou pravoúhlého lichoběžníku se základnami $10$ cm a $7$ cm a výškou $10$ cm; obsah podstavy $\\frac{10+7}{2}\\cdot 10=85$ cm², objem $85\\cdot 10=850$ cm³.'],
     'ans': '7.1: $700$ cm³; 7.2: $850$ cm³', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['stereometrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2019 – úloha 8',
     'zad': ['V rovině leží bod $P$ a úhel $TCU$ (viz obrázek).',
             '8.1 Sestrojte a označte písmenem $o$ osu úhlu $TCU$.',
             '8.2 Bod $C$ je vrchol rovnoramenného trojúhelníku $ABC$ se základnou $AB$. Ramena $AC$ a $BC$ tohoto trojúhelníku leží na polopřímkách $CT$ a $CU$. Bod $P$ leží na straně $AB$. Sestrojte a označte písmeny chybějící vrcholy trojúhelníku $ABC$ a trojúhelník narýsujte.'],
     'opts': None, 'ln': 0, 'svg': SVG8, 'fn': 'uhel-TCU.svg',
     'alt': 'Bod P a úhel TCU s vrcholem C a rameny CT a CU.',
     'cap': 'Výchozí obrázek k úloze 8',
     'sol': ['8.1 Osa $o$ úhlu $TCU$ prochází vrcholem $C$ a dělí úhel na dvě shodné části; je zároveň osou souměrnosti rovnoramenného trojúhelníku.',
             '8.2 Základna $AB$ rovnoramenného trojúhelníku je kolmá k ose $o$. Bodem $P$ vedeme kolmici k ose $o$; její průsečíky s polopřímkami $CT$ a $CU$ jsou vrcholy $A$ a $B$.'],
     'ans': 'Osa $o$ úhlu $TCU$ a rovnoramenný trojúhelník $ABC$ (základna $AB$ kolmá k ose $o$ a procházející bodem $P$; vrcholy $A$, $B$ na polopřímkách $CT$, $CU$) – viz obrázek v klíči.',
     'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2019 – úloha 9',
     'zad': ['V rovině leží kružnice $k$ se středem $S$, přímka $p$ a bod $D$ (viz obrázek).',
             'Bod $D$ je vrchol obdélníku $ABCD$. Na přímce $p$ leží strana $AB$ tohoto obdélníku. Vrchol $C$ leží na kružnici $k$. Sestrojte a označte písmeny chybějící vrcholy obdélníku $ABCD$ a obdélník narýsujte. Najděte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG9, 'fn': 'kruznice-p-D.svg',
     'alt': 'Kružnice k se středem S, přímka p a bod D nad přímkou.',
     'cap': 'Výchozí obrázek k úloze 9',
     'sol': ['Strana $AD$ je kolmá k přímce $p$, takže vrchol $A$ je pata kolmice z bodu $D$ na přímku $p$. Strana $DC$ je rovnoběžná s $p$; vrchol $C$ leží na rovnoběžce s $p$ vedené bodem $D$ a zároveň na kružnici $k$ – to dává dvě polohy. Vrchol $B$ je pata kolmice z $C$ na přímku $p$. Úloha má dvě řešení.'],
     'ans': 'Obdélník $ABCD$: $A$ je pata kolmice z $D$ na $p$; $C$ je průsečík rovnoběžky s $p$ vedené bodem $D$ a kružnice $k$; $B$ je pata kolmice z $C$ na $p$. Dvě řešení – viz obrázek v klíči.',
     'pts': 2, 'mins': 6, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2019 – úloha 10',
     'zad': ['Tři obrazce byly složeny z $9$ shodných čtverců a $3$ shodných rovnoramenných trojúhelníků. Obvod 1. obrazce je $32$ cm. (V 1. a 2. obrazci mají sousední čtverce a trojúhelníky společné vrcholy a nikde nepřečnívají.)',
             'Rozhodněte o každém z následujících tvrzení (10.1–10.3), zda je pravdivé (A), či nikoli (N).',
             '10.1 Obsah 1. obrazce je $48$ cm².',
             '10.2 Obvod 2. obrazce je větší než $48$ cm.',
             '10.3 Obvod 3. obrazce je $44$ cm.'],
     'opts': None, 'ln': 0, 'svg': SVG10, 'fn': 'tri-obrazce.svg',
     'alt': 'Tři obrazce ze shodných čtverců a rovnoramenných trojúhelníků: 1. obrazec tři čtverce do L, 2. obrazec řada tří čtverců se dvěma trojúhelníky, 3. obrazec dva čtverce, dvě svislé spojky a trojúhelník.',
     'cap': '1., 2. a 3. obrazec',
     'sol': ['1. obrazec tvoří tři čtverce a jeho obvod je $8$ stran čtverce: $8a=32$, tedy strana $a=4$ cm.',
             '10.1 Obsah $=3\\cdot a^2=3\\cdot 16=48$ cm². Pravda (A).',
             '10.2 Obvod 2. obrazce není větší než $48$ cm. Nepravda (N).',
             '10.3 Obvod 3. obrazce je $44$ cm. Pravda (A).'],
     'ans': '10.1: Ano; 10.2: Ne; 10.3: Ano', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['planimetrie', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2019 – úloha 11',
     'zad': ['Na obrázku jsou vyznačeny úhly $\\alpha$, $\\alpha+20^\\circ$, $2\\alpha$ a $\\beta$; dvojité značky vyznačují rovnoběžná ramena. Velikosti úhlů neměřte, ale vypočtěte.',
             'Jaká je velikost úhlu $\\beta$?'],
     'opts': ['A) menší než $75^\\circ$', 'B) $75^\\circ$', 'C) $80^\\circ$', 'D) $85^\\circ$', 'E) větší než $85^\\circ$'],
     'ln': 0, 'svg': SVG11, 'fn': 'uhly-beta.svg',
     'alt': 'Trojúhelník se dvěma rovnoběžnými rameny (dvojité značky); u dolního vrcholu úhly alfa, alfa + 20 stupňů a 2 alfa, u horního vrcholu úhel beta.',
     'cap': 'Výchozí obrázek k úloze 11',
     'sol': ['Rameno s dvojitou značkou u dolního vrcholu je rovnoběžné s horní stranou. Úhel $2\\alpha$ je střídavý (resp. souhlasný) s úhlem $\\beta$, proto $\\beta=2\\alpha$. Vnitřní úhel trojúhelníku u levého vrcholu je souhlasný s $\\alpha$ a u dolního vrcholu je $\\alpha+20^\\circ$. Součet vnitřních úhlů: $\\alpha+2\\alpha+(\\alpha+20^\\circ)=180^\\circ$, tj. $4\\alpha=160^\\circ$, $\\alpha=40^\\circ$. Odtud $\\beta=2\\alpha=80^\\circ$.'],
     'ans': 'C) $80^\\circ$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2019 – úloha 12',
     'zad': ['Na jaře se konal dětský plavecký závod smíšených štafet. Každá štafeta uplavala celkem $48$ bazénů. Ve štafetě A bylo o $6$ dívek více než chlapců. Každá dívka uplavala $1$ bazén a každý chlapec $2$ bazény.',
             'Kolik dětí bylo ve štafetě A?'],
     'opts': ['A) méně než $34$ dětí', 'B) $34$ dětí', 'C) $36$ dětí', 'D) $38$ dětí', 'E) více než $38$ dětí'],
     'ln': 0,
     'sol': ['Označíme počet chlapců $c$, dívek $c+6$. Uplavané bazény: $(c+6)\\cdot 1+c\\cdot 2=48$, tj. $3c+6=48$, $c=14$. Chlapců je $14$, dívek $20$, celkem $34$ dětí.'],
     'ans': 'B) $34$ dětí', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7A 2019 – úloha 13–14',
     'zad': ['Graf udává počty žáků jedné třídy v průběhu šesti let. Některé údaje v grafu chybí (označeny „?"). Pro každý rok platí, že počet všech žáků je součtem počtu chlapců a počtu dívek; po doplnění chybějících údajů odpovězte na otázky. Při řešení vycházejte pouze z doplněného grafu.',
             '13 Kolikrát došlo k meziroční změně počtu chlapců v období od 1. do 6. roku? A) jedenkrát; B) dvakrát; C) třikrát; D) čtyřikrát; E) pětkrát',
             '14 Ve kterém roce byl počet chlapců o čtvrtinu větší než počet dívek? A) v 1. roce; B) ve 2. roce; C) ve 3. roce; D) ve 4. roce; E) v 5. roce'],
     'opts': None, 'ln': 0, 'svg': SVG1314, 'fn': 'graf-zaci.svg',
     'alt': 'Sloupcový graf počtu žáků, chlapců a dívek v šesti letech; chybějící sloupce jsou označeny otazníkem.',
     'cap': 'Počty žáků, chlapců a dívek v průběhu šesti let',
     'sol': ['Doplnění (všichni = chlapci + dívky): chlapci po letech $15, 15, 16, 16, 16, 12$; dívky $12, 10, 12, 14, 13, 10$; všichni $27, 25, 28, 30, 29, 22$.',
             '13 Počet chlapců se změnil mezi 2. a 3. rokem a mezi 5. a 6. rokem, tedy dvakrát → B).',
             '14 Chlapců je o čtvrtinu více než dívek, když $15=1{,}25\\cdot 12$; to platí jen v 1. roce → A).'],
     'ans': '13: B) dvakrát; 14: A) v 1. roce', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['statistika', 'porozumeni', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7A 2019 – úloha 15',
     'zad': ['Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).',
             '15.1 Zájezd stojí $14\\,000$ korun. Prvnímu zákazníkovi byla poskytnuta $25\\,\\%$ sleva. Jaká byla cena zájezdu pro prvního zákazníka?',
             '15.2 Zájezd stojí $12\\,000$ korun. Cena zájezdu se skládá ze dvou položek: ceny za pobyt a ceny za dopravu. Cena za dopravu je stejná jako pětina ceny za pobyt. Jaká je cena za samotný pobyt?',
             '15.3 Cena zájezdu je $18\\,000$ korun. Předem je třeba zaplatit zálohu, která tvoří dvě třetiny ceny zájezdu. Cena za ubytování je stejná jako $75\\,\\%$ zálohy na zájezd. Jaká je cena za ubytování?'],
     'opts': ['A) $9\\,000$ korun', 'B) $9\\,500$ korun', 'C) $9\\,600$ korun', 'D) $10\\,000$ korun', 'E) $10\\,500$ korun', 'F) jiná cena'],
     'ln': 0,
     'sol': ['15.1 $14\\,000\\cdot 0{,}75=10\\,500$ korun → E).',
             '15.2 Pobyt $p$, doprava $\\frac{p}{5}$: $p+\\frac{p}{5}=12\\,000$, tj. $\\frac{6}{5}p=12\\,000$, $p=10\\,000$ korun → D).',
             '15.3 Záloha $\\frac{2}{3}\\cdot 18\\,000=12\\,000$; ubytování $0{,}75\\cdot 12\\,000=9\\,000$ korun → A).'],
     'ans': '15.1: E) $10\\,500$ korun; 15.2: D) $10\\,000$ korun; 15.3: A) $9\\,000$ korun', 'pts': 6, 'mins': 9, 'diff': '3',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'finance']},

    {'name': 'CERMAT M7A 2019 – úloha 16',
     'zad': ['Na čtvercové síti vytváříme ze sirek čtvercové labyrinty podle jednotných pravidel: každá sirka odděluje vždy dvě pole čtvercové sítě; sirky na sebe navazují, začínají ve středu labyrintu a končí v jeho levém dolním rohu; nejmenší labyrint je složen z $8$ sirek a obsahuje $4$ pole; při sestavování následujícího labyrintu se přidá nejmenší možný počet sirek. Na obrázku jsou tři nejmenší labyrinty.',
             '16.1 Vypočtěte, kolik polí čtvercové sítě obsahuje 4. labyrint.',
             '16.2 Vypočtěte, o kolik polí čtvercové sítě je 7. labyrint větší než 6. labyrint.',
             '16.3 Vypočtěte, kolik sirek musíme přidat, chceme-li zvětšit 9. labyrint na 10. labyrint.'],
     'opts': None, 'ln': 3, 'svg': SVG16, 'fn': 'labyrinty.svg',
     'alt': 'Tři nejmenší čtvercové labyrinty ze sirek jako spirály: 1. labyrint 2 krát 2 pole, 2. labyrint 4 krát 4 pole, 3. labyrint 6 krát 6 polí.',
     'cap': '1., 2. a 3. labyrint',
     'sol': ['$n$-tý labyrint je čtverec $2n\\times 2n$ polí, má tedy $(2n)^2=4n^2$ polí (1. má $4$, 2. má $16$, 3. má $36$). Počet sirek přidaných při přechodu na $n$-tý labyrint je $8n$.',
             '16.1 Počet polí 4. labyrintu $4\\cdot 4^2=64$.',
             '16.2 Rozdíl $4\\cdot 7^2-4\\cdot 6^2=196-144=52$ polí.',
             '16.3 Přechod na 10. labyrint: přidáme $8\\cdot 10=80$ sirek.'],
     'ans': '16.1: $64$ polí; 16.2: o $52$ polí; 16.3: $80$ sirek', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['posloupnosti', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M7PAD19C0T01'
    gen.YEAR = 2019

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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M7A-2019')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
