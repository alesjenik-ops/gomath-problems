# -*- coding: utf-8 -*-
# CERMAT - Jednotna prijimaci zkouska 2024, MATEMATIKA 7A (sestilete obory, 7. rocnik), 1. radny termin.
# Kod testu: M7PAD24C0T01. 16 uloh (po rozdeleni nezavislych poduloh 1 a 2 celkem 18 uloh).
# Zdroj odpovedi: klic spravnych reseni (KSR).
import math

# ---- SVG obrazky (bez apostrofu a zpetnych lomitek) ----

# uloha 3: ciselna osa se stejne velkymi dilky; C=index0, 1,4=index2, A=index6, 5,6=index8, B=index9 (dilek 0,7)
def _numline():
    ox = 44; s = 60; y = 120
    p = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 720 190" font-family="sans-serif">']
    x0 = ox - 24; x1 = ox + 10*s + 24
    p.append(f'<line x1="{x0}" y1="{y}" x2="{x1}" y2="{y}" stroke="#000" stroke-width="2"/>')
    p.append(f'<polygon points="{x1},{y} {x1-11},{y-6} {x1-11},{y+6}" fill="#000"/>')
    for i in range(11):
        x = ox + i*s
        p.append(f'<line x1="{x}" y1="{y-9}" x2="{x}" y2="{y+9}" stroke="#000" stroke-width="2"/>')
    p.append(f'<text x="{ox+0*s}" y="{y-18}" font-size="20" text-anchor="middle" font-style="italic">C</text>')
    p.append(f'<text x="{ox+6*s}" y="{y-18}" font-size="20" text-anchor="middle" font-style="italic">A</text>')
    p.append(f'<text x="{ox+9*s}" y="{y-18}" font-size="20" text-anchor="middle" font-style="italic">B</text>')
    p.append(f'<text x="{ox+2*s}" y="{y+30}" font-size="18" text-anchor="middle">1,4</text>')
    p.append(f'<text x="{ox+8*s}" y="{y+30}" font-size="18" text-anchor="middle">5,6</text>')
    p.append('</svg>')
    return "".join(p)
SVG3 = _numline()

# uloha 4: magicky ctverec 3x3; dane 1/15, 2/5, 1/3; sede pole (col2,row1) s otaznikem
def _magic():
    cell = 58; ox = 26; oy = 26; W = ox*2 + 3*cell
    p = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {W} {W}" font-family="sans-serif">']
    gx = ox + 2*cell; gy = oy + 1*cell
    p.append(f'<rect x="{gx}" y="{gy}" width="{cell}" height="{cell}" fill="#b9b9b9"/>')
    for i in range(4):
        p.append(f'<line x1="{ox+i*cell}" y1="{oy}" x2="{ox+i*cell}" y2="{oy+3*cell}" stroke="#000" stroke-width="2"/>')
        p.append(f'<line x1="{ox}" y1="{oy+i*cell}" x2="{ox+3*cell}" y2="{oy+i*cell}" stroke="#000" stroke-width="2"/>')
    def frac(col, row, n, d):
        cx = ox + col*cell + cell/2; cy = oy + row*cell + cell/2
        return (f'<text x="{cx}" y="{cy-4}" font-size="17" text-anchor="middle">{n}</text>'
                f'<line x1="{cx-14}" y1="{cy}" x2="{cx+14}" y2="{cy}" stroke="#000" stroke-width="1.5"/>'
                f'<text x="{cx}" y="{cy+17}" font-size="17" text-anchor="middle">{d}</text>')
    p.append(frac(1, 0, 1, 15))
    p.append(frac(2, 0, 2, 5))
    p.append(frac(1, 1, 1, 3))
    p.append(f'<text x="{gx+cell/2}" y="{gy+cell/2+7}" font-size="24" text-anchor="middle">?</text>')
    p.append('</svg>')
    return "".join(p)
SVG4 = _magic()

# uloha 5: kruhovy diagram - florbal 38 %, zadny 6 %, basketbal 16 %, tanecni 15 %, lezecka stena 25 %
def _pie():
    cx = 210; cy = 175; r = 120
    slices = [('zadny', 6), ('basketbal', 16), ('tanecni', 15), ('lezecka stena', 25), ('florbal', 38)]
    colors = ['#eeeeee', '#ffffff', '#9a9a9a', '#cccccc', '#dddddd']
    p = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 360" font-family="sans-serif">']
    ang = 0.0
    for (name, pct), col in zip(slices, colors):
        a1 = ang; a2 = ang + pct*3.6; ang = a2
        x1 = cx + r*math.sin(math.radians(a1)); y1 = cy - r*math.cos(math.radians(a1))
        x2 = cx + r*math.sin(math.radians(a2)); y2 = cy - r*math.cos(math.radians(a2))
        large = 1 if (a2 - a1) > 180 else 0
        p.append(f'<path d="M {cx} {cy} L {x1:.1f} {y1:.1f} A {r} {r} 0 {large} 1 {x2:.1f} {y2:.1f} Z" fill="{col}" stroke="#000" stroke-width="1.5"/>')
        am = (a1 + a2)/2
        lx = cx + 0.62*r*math.sin(math.radians(am)); ly = cy - 0.62*r*math.cos(math.radians(am))
        if name == 'florbal':
            p.append(f'<text x="{lx:.1f}" y="{ly:.1f}" font-size="14" text-anchor="middle" font-weight="bold">florbal</text>')
        else:
            p.append(f'<text x="{lx:.1f}" y="{ly-5:.1f}" font-size="12" text-anchor="middle">{name}</text>')
            p.append(f'<text x="{lx:.1f}" y="{ly+11:.1f}" font-size="12" text-anchor="middle">{pct} %</text>')
    p.append('</svg>')
    return "".join(p)
SVG5 = _pie()

# uloha 8: dana primka p (svisla, bod Y na ni) a bod A mimo primku
SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 320" font-family="sans-serif">
<line x1="285" y1="40" x2="285" y2="285" stroke="#000" stroke-width="2"/>
<line x1="277" y1="70" x2="293" y2="70" stroke="#000" stroke-width="2"/>
<text x="300" y="75" font-size="16" font-style="italic">Y</text>
<text x="296" y="278" font-size="16" font-style="italic">p</text>
<text x="150" y="182" font-size="16" text-anchor="middle">×</text>
<text x="150" y="200" font-size="16" text-anchor="middle" font-style="italic">A</text>
</svg>"""

# uloha 9: poloprimka BX a primka o
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 380 320" font-family="sans-serif">
<line x1="60" y1="255" x2="335" y2="180" stroke="#000" stroke-width="2"/>
<line x1="329" y1="172" x2="341" y2="188" stroke="#000" stroke-width="2"/>
<line x1="54" y1="248" x2="66" y2="262" stroke="#000" stroke-width="2"/>
<text x="46" y="264" font-size="16" font-style="italic">B</text>
<text x="345" y="180" font-size="16" font-style="italic">X</text>
<line x1="120" y1="70" x2="250" y2="300" stroke="#000" stroke-width="2"/>
<text x="108" y="66" font-size="16" font-style="italic">o</text>
</svg>"""

# uloha 14: rovnobezne primky m, n; pricky r, p; uhly alfa, 105 stupnu, beta, 2beta (ilustracni)
SVG14 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 340" font-family="sans-serif">
<line x1="60" y1="120" x2="300" y2="320" stroke="#000" stroke-width="2"/>
<line x1="200" y1="40" x2="440" y2="240" stroke="#000" stroke-width="2"/>
<line x1="30" y1="240" x2="470" y2="240" stroke="#000" stroke-width="2"/>
<line x1="250" y1="40" x2="410" y2="300" stroke="#000" stroke-width="2"/>
<text x="52" y="116" font-size="16" font-style="italic">n</text>
<text x="192" y="36" font-size="16" font-style="italic">m</text>
<text x="252" y="36" font-size="16" font-style="italic">r</text>
<text x="478" y="245" font-size="16" font-style="italic">p</text>
<text x="298" y="168" font-size="17">α</text>
<text x="166" y="226" font-size="15">105°</text>
<text x="176" y="264" font-size="16">2β</text>
<text x="350" y="228" font-size="16">β</text>
</svg>"""

# uloha 16: podstava hranolu (dva shodne kvadry 6x3 + jeden kvadr 3x3); obvod 36 cm, obsah 45 cm2
SVG16 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 340 350" font-family="sans-serif">
<polygon points="118,310 196,310 196,232 274,232 274,154 196,154 196,76 40,76 40,154 118,154" fill="#ffffff" stroke="#000" stroke-width="2"/>
<line x1="118" y1="154" x2="196" y2="154" stroke="#000" stroke-width="1" stroke-dasharray="5 4"/>
<line x1="196" y1="154" x2="196" y2="232" stroke="#000" stroke-width="1" stroke-dasharray="5 4"/>
<text x="118" y="66" font-size="15" text-anchor="middle">6 cm</text>
<text x="20" y="120" font-size="15" text-anchor="middle">3 cm</text>
<text x="96" y="245" font-size="15" text-anchor="middle">6 cm</text>
<text x="157" y="330" font-size="15" text-anchor="middle">3 cm</text>
<text x="292" y="197" font-size="15" text-anchor="middle">3 cm</text>
<text x="235" y="250" font-size="15" text-anchor="middle">3 cm</text>
</svg>"""

B = ['zs2', 'r7']  # 7. rocnik (sestilete obory / prijimacky na sestileta gymnazia)

PROBLEMS = [
    {'name': 'CERMAT M7A 2024 – úloha 1.1',
     'zad': ['Máme čísla $A$ a $B$. $A=1{,}6$; $B=-1{,}2$.',
             'Kolikrát je součet $A+B$ menší než rozdíl $A-B$?'],
     'opts': None, 'ln': 2,
     'sol': ['Součet $A+B=1{,}6+(-1{,}2)=0{,}4$, rozdíl $A-B=1{,}6-(-1{,}2)=2{,}8$. Podíl $2{,}8:0{,}4=7$.'],
     'ans': '$7$krát', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2024 – úloha 1.2',
     'zad': ['Napište desetinné číslo, které je o $0{,}093$ menší než $\\frac{7}{8}$.'],
     'opts': None, 'ln': 2,
     'sol': ['$\\frac{7}{8}=0{,}875$; $0{,}875-0{,}093=0{,}782$.'],
     'ans': '$0{,}782$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2024 – úloha 2.1',
     'zad': ['Vypočítejte a výsledek zapište zlomkem v základním tvaru.',
             '$\\dfrac{\\left(\\frac{5}{8}-\\frac{1}{6}\\right):\\frac{11}{12}}{4\\cdot\\frac{7}{8}}=$'],
     'opts': None, 'ln': 2,
     'sol': ['Čitatel: $\\frac{5}{8}-\\frac{1}{6}=\\frac{15-4}{24}=\\frac{11}{24}$; $\\frac{11}{24}:\\frac{11}{12}=\\frac{11}{24}\\cdot\\frac{12}{11}=\\frac{1}{2}$. Jmenovatel: $4\\cdot\\frac{7}{8}=\\frac{7}{2}$. Celkem $\\frac{1}{2}:\\frac{7}{2}=\\frac{1}{2}\\cdot\\frac{2}{7}=\\frac{1}{7}$.'],
     'ans': '$\\frac{1}{7}$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2024 – úloha 2.2',
     'zad': ['Vypočítejte a výsledek zapište zlomkem v základním tvaru.',
             '$2{,}5-\\frac{7}{8}\\cdot\\frac{4}{5}-\\frac{27}{18}:\\frac{15}{9}=$'],
     'opts': None, 'ln': 2,
     'sol': ['$\\frac{7}{8}\\cdot\\frac{4}{5}=\\frac{28}{40}=\\frac{7}{10}$; $\\frac{27}{18}:\\frac{15}{9}=\\frac{3}{2}\\cdot\\frac{3}{5}=\\frac{9}{10}$. Pak $2{,}5-\\frac{7}{10}-\\frac{9}{10}=\\frac{25}{10}-\\frac{7}{10}-\\frac{9}{10}=\\frac{9}{10}$.'],
     'ans': '$\\frac{9}{10}$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2024 – úloha 3',
     'zad': ['Na číselné ose se stejně velkými dílky jsou označeny obrazy čísel $1{,}4$ a $5{,}6$ a obrazy neznámých čísel $A$, $B$, $C$.',
             '3.1 Zapište hodnotu čísla $C$.',
             '3.2 Zapište, kolikrát je číslo $B$ větší než číslo $1{,}4$.',
             '3.3 Vypočítejte rozdíl $B-A$.'],
     'opts': None, 'ln': 3, 'svg': SVG3, 'fn': 'cisel-osa.svg',
     'alt': 'Ciselna osa se stejne velkymi dilky, oznacene body C, 1,4, A, 5,6, B.',
     'cap': 'Číselná osa (dílek $0{,}7$)',
     'sol': ['Mezi $1{,}4$ a $5{,}6$ je 6 dílků, takže jeden dílek je $\\frac{5{,}6-1{,}4}{6}=0{,}7$.',
             '3.1 $C$ leží 2 dílky vlevo od $1{,}4$: $C=1{,}4-2\\cdot 0{,}7=0$.',
             '3.2 $B=1{,}4+7\\cdot 0{,}7=6{,}3$; $6{,}3:1{,}4=4{,}5$.',
             '3.3 $A=1{,}4+4\\cdot 0{,}7=4{,}2$; $B-A=6{,}3-4{,}2=2{,}1$.'],
     'ans': '3.1: $C=0$; 3.2: $4{,}5$krát; 3.3: $B-A=2{,}1$', 'pts': 3, 'mins': 4, 'diff': '2',
     'codes': B + ['aritmetika', 'porozumeni', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2024 – úloha 4',
     'zad': ['Na obrázku je částečně vyplněný tzv. magický čtverec, pro který platí: součet všech tří zlomků je stejný v každém řádku, sloupci i v každé úhlopříčce a rovná se $1$.',
             'Jaký zlomek se nachází v šedém poli?'],
     'opts': None, 'ln': 2, 'svg': SVG4, 'fn': 'magicky-ctverec.svg',
     'alt': 'Magicky ctverec 3x3; vyplneno 1/15 a 2/5 v hornim radku, 1/3 uprostred; sede pole vpravo uprostred.',
     'cap': 'Částečně vyplněný magický čtverec',
     'sol': ['Levý horní roh (řádek 1): $y+\\frac{1}{15}+\\frac{2}{5}=1\\Rightarrow y=\\frac{8}{15}$. Z úhlopříčky $\\frac{8}{15}+\\frac{1}{3}+z=1\\Rightarrow z=\\frac{2}{15}$ (pravý dolní roh). Pravý sloupec: $\\frac{2}{5}+x+\\frac{2}{15}=1\\Rightarrow x=1-\\frac{8}{15}=\\frac{7}{15}$.'],
     'ans': '$\\frac{7}{15}$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2024 – úloha 5',
     'zad': ['V kruhovém diagramu je vyznačeno, kolik dětí z jedné základní školy navštěvuje jednotlivé kroužky a kolik dětí této školy nechodí do žádného kroužku. Víme, že na florbal chodí $114$ dětí a každé dítě navštěvuje nejvýše jeden kroužek.',
             '5.1 Kolik dětí navštěvuje nějaký kroužek?',
             '5.2 Kolik dětí chodí na basketbal?'],
     'opts': None, 'ln': 2, 'svg': SVG5, 'fn': 'kruhovy-diagram.svg',
     'alt': 'Kruhovy diagram: florbal, zadny 6 %, basketbal 16 %, tanecni 15 %, lezecka stena 25 %.',
     'cap': 'Kruhový diagram návštěvnosti kroužků',
     'sol': ['Na florbal připadá $100\\,\\%-(6+16+15+25)\\,\\%=38\\,\\%$, což je $114$ dětí, tedy $1\\,\\%=3$ děti a celkem $300$ dětí.',
             '5.1 Do žádného kroužku nechodí $6\\,\\%$, tj. $18$ dětí; nějaký kroužek navštěvuje $300-18=282$ dětí.',
             '5.2 Basketbal $16\\,\\%$ z $300$ je $48$ dětí.'],
     'ans': '5.1: $282$ dětí; 5.2: $48$ dětí', 'pts': 4, 'mins': 5, 'diff': '2',
     'codes': B + ['statistika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7A 2024 – úloha 6',
     'zad': ['Počet sportovců na závodech byl více než $1$ a zároveň méně než $90$. Pořadatel chtěl sportovce seřadit do slavnostního průvodu, ale ať je rozděloval do dvojic, trojic, čtveřic nebo pětic, vždy mu jeden sportovec zbyl.',
             'Kolik sportovců se sešlo na závodech?'],
     'opts': None, 'ln': 2,
     'sol': ['Počet zmenšený o $1$ musí být dělitelný $2$, $3$, $4$ i $5$, tedy dělitelný $\\mathrm{lcm}(2,3,4,5)=60$. V rozsahu od $2$ do $89$ vyhovuje jen $60+1=61$.'],
     'ans': '$61$ sportovců', 'pts': 3, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7A 2024 – úloha 7',
     'zad': ['V útulku mají $5$ štěňat. Krmení zvířat probíhá každý den odpoledne. $2.$ dubna ráno otevřeli $10$kg balení granulí pro psy, které těmto pěti štěňatům dohromady vystačí na $16$ dní. $8.$ dubna ráno bylo do útulku přivezeno $1$ štěně a $2$ dospělí psi. Víme, že každý dospělý pes sní za den dvojnásobek dávky určené pro štěně.',
             'Kolikátého dubna byli naposledy psi a štěňata krmeni granulemi z tohoto balení?'],
     'opts': None, 'ln': 2,
     'sol': ['Balení vystačí na $5\\cdot 16=80$ denních dávek pro štěně. Od $2.$ do $7.$ dubna (6 dnů krmení) sní $5$ štěňat $6\\cdot 5=30$ dávek, zbývá $50$ dávek. Od $8.$ dubna je zvířat $6$ štěňat a $2$ dospělí psi, tj. $6+2\\cdot 2=10$ dávek denně. Zbylých $50$ dávek vystačí na $50:10=5$ dnů, tedy $8.$ až $12.$ dubna.'],
     'ans': '$12.$ dubna', 'pts': 3, 'mins': 6, 'diff': '4',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7A 2024 – úloha 8 (konstrukce)',
     'zad': ['Je dána přímka $p$ a bod $A$, který neleží na přímce $p$ (viz obrázek). Na přímce $p$ leží bod $Y$.',
             'Sestrojte pravoúhlý lichoběžník $ABCD$, pokud platí: rameno kolmé k základně $AB$ leží na přímce $p$; strana $AB$ má stejnou délku jako strana $AD$; strana $AB$ je dvakrát delší než strana $BC$; bod $C$ leží na polopřímce $BY$.',
             'Najděte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG8, 'fn': 'primka-p-bod-A.svg',
     'alt': 'Svisla primka p s bodem Y a bod A mimo primku.',
     'cap': 'Výchozí obrázek k úloze 8',
     'sol': ['Bod $B$ je pata kolmice vedené z bodu $A$ k přímce $p$ (tj. $AB\\perp p$). Bod $C$ leží na přímce $p$ tak, že $|BC|=\\frac{1}{2}|AB|$ (kružnice se středem $B$ a poloměrem $\\frac{1}{2}|AB|$). Bodem $C$ vedeme rovnoběžku s přímkou $AB$; bod $D$ na ní leží ve vzdálenosti $|AD|=|AB|$ od $A$ (kružnice se středem $A$ a poloměrem $|AB|$). Průsečíky dávají dvě řešení - lichoběžníky $ABCD_1$ a $ABCD_2$.'],
     'ans': 'Dvě řešení: $B$ pata kolmice z $A$ na $p$, $|BC|=\\frac{1}{2}|AB|$ na přímce $p$, $CD\\parallel AB$, $|AD|=|AB|$ - lichoběžníky $ABCD_1$ a $ABCD_2$ (viz náčrt v klíči).',
     'pts': 3, 'mins': 7, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2024 – úloha 9 (konstrukce)',
     'zad': ['V rovině leží polopřímka $BX$ a přímka $o$ (viz obrázek). Bod $B$ je vrchol rovnoramenného trojúhelníku $ABC$. Přímka $o$ je osou strany $BC$ trojúhelníku. Bod $A$ leží na polopřímce $BX$.',
             'Sestrojte rovnoramenný trojúhelník $ABC$ se základnou $AC$.'],
     'opts': None, 'ln': 0, 'svg': SVG9, 'fn': 'poloprimka-BX-o.svg',
     'alt': 'Poloprimka BX a primka o v rovine.',
     'cap': 'Výchozí obrázek k úloze 9',
     'sol': ['Přímka $o$ je osou strany $BC$, proto je bod $C$ obrazem bodu $B$ v osové souměrnosti podle přímky $o$ (z $B$ spustíme kolmici na $o$, pata $B_0$ je střed $BC$ a $|B_0C|=|B_0B|$). Trojúhelník má základnu $AC$ a ramena $AB$, $CB$, tedy $|AB|=|CB|$. Bod $A$ je průsečík polopřímky $BX$ s kružnicí se středem $B$ a poloměrem $|BC|$.'],
     'ans': 'Bod $C$ je obraz $B$ v osové souměrnosti podle přímky $o$; bod $A$ leží na polopřímce $BX$ ve vzdálenosti $|BC|$ od $B$ (tj. $|AB|=|CB|$) - viz náčrt v klíči.',
     'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2024 – úloha 10',
     'zad': ['Na letním táboře jsou kromě dětí také instruktoři, vedoucí, kuchařky a jeden zdravotník. Počet zdravotníků a počet kuchařek je v poměru $1:4$, počet kuchařek a vedoucích $1:2$, počet vedoucích a instruktorů $1:2$ a počet instruktorů a dětí $1:4$. Všichni jsou ubytováni ve $47$ stanech. Zdravotník je ve stanu sám, ostatní jsou ubytováni po dvou.',
             'Rozhodněte o každém z následujících tvrzení 10.1-10.3, zda je pravdivé (A), či nikoli (N).',
             '10.1 Na táboře je dohromady $22$ vedoucích a instruktorů.',
             '10.2 Instruktorů je $4$krát více než kuchařek.',
             '10.3 Na táboře je celkem $64$ dětí.'],
     'opts': None, 'ln': 0,
     'sol': ['Z poměrů: zdravotník $1$, kuchařky $4$, vedoucí $8$, instruktoři $16$, děti $64$. Celkem $93$ osob; zdravotník sám ($1$ stan) a zbývajících $92$ po dvou ($46$ stanů) dává $47$ stanů - souhlasí.',
             '10.1 Vedoucí a instruktoři: $8+16=24\\ne 22$ - N.',
             '10.2 Instruktoři $16=4\\cdot 4$ kuchařky - A.',
             '10.3 Dětí je $64$ - A.'],
     'ans': '10.1: N; 10.2: A; 10.3: A', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7A 2024 – úloha 11',
     'zad': ['V ohradě pobíhali králíci a slepice. Králíků bylo o $5$ méně než slepic. Králíci a slepice měli dohromady $106$ nohou a $37$ hlav.',
             'Kolik bylo v ohradě slepic?'],
     'opts': ['A) $16$', 'B) $18$', 'C) $19$', 'D) $20$', 'E) $21$'], 'ln': 0,
     'sol': ['Označme počet slepic $s$ a králíků $s-5$. Z počtu hlav: $s+(s-5)=37\\Rightarrow 2s=42\\Rightarrow s=21$ (králíků $16$). Kontrola nohou: $2\\cdot 21+4\\cdot 16=42+64=106$ - souhlasí.'],
     'ans': 'E) $21$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['rovnice', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7A 2024 – úloha 12',
     'zad': ['Charitativní závod startoval ve $14{:}00$ ($14$ hodin). Závodit se mohlo pěšky nebo s využitím libovolného dopravního prostředku. Jana se rozhodla pro chůzi a šla rychlostí $4$ kilometry za hodinu, Petra jela na kolečkových bruslích, Roman jel na kole a Adam běžel. Roman byl pětkrát rychlejší než Jana a v cíli byl ve $14{:}30$. Adamův běh byl třikrát rychlejší než chůze Jany, ale $40$ minut po startu se Adam zranil a zbytek závodu absolvoval chůzí stejnou rychlostí jako Jana. Do cíle přišel $5$ minut před Petrou.',
             'V kolik hodin se dostal do cíle Adam?'],
     'opts': ['A) $14{:}30$', 'B) $14{:}45$', 'C) $15{:}00$', 'D) $15{:}10$', 'E) $15{:}15$'], 'ln': 0,
     'sol': ['Roman jel rychlostí $5\\cdot 4=20$ km/h a za $30$ minut ujel délku trati $10$ km. Adam běžel rychlostí $3\\cdot 4=12$ km/h; za prvních $40$ minut ($\\frac{2}{3}$ h) uběhl $8$ km. Zbývající $2$ km šel rychlostí $4$ km/h, tj. $30$ minut. Celkem $40+30=70$ minut, do cíle dorazil v $15{:}10$.'],
     'ans': 'D) $15{:}10$', 'pts': 2, 'mins': 5, 'diff': '4',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7A 2024 – úloha 13',
     'zad': ['Kolikrát je obsah obdélníku o straně $a=36$ cm a straně $b=12$ cm větší než obsah čtverce se stranou délky $6$ cm?'],
     'opts': ['A) $3$krát', 'B) $6$krát', 'C) $7{,}5$krát', 'D) $12$krát', 'E) $12{,}5$krát'], 'ln': 0,
     'sol': ['Obsah obdélníku $36\\cdot 12=432$ cm², obsah čtverce $6\\cdot 6=36$ cm². Podíl $432:36=12$.'],
     'ans': 'D) $12$krát', 'pts': 2, 'mins': 2, 'diff': '1',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2024 – úloha 14',
     'zad': ['Přímky $m$, $n$ jsou rovnoběžné (viz obrázek). V obrázku jsou vyznačeny úhly $\\alpha$, $105^\\circ$, $\\beta$ a $2\\beta$.',
             'Jaká je velikost úhlu $\\alpha$? Velikosti úhlů neměřte, ale vypočítejte (obrázek je ilustrační).'],
     'opts': ['A) $145^\\circ$', 'B) $110^\\circ$', 'C) $105^\\circ$', 'D) $75^\\circ$', 'E) $35^\\circ$'], 'ln': 0,
     'svg': SVG14, 'fn': 'rovnobezky-uhly.svg',
     'alt': 'Dve rovnobezne primky m, n a dve pricky r, p; vyznacene uhly alfa, 105 stupnu, beta a 2beta.',
     'cap': 'Ilustrační obrázek k úloze 14',
     'sol': ['Z úhlů u přímky s vyznačeným úhlem $105^\\circ$ plyne $3\\beta=105^\\circ$, tedy $\\beta=35^\\circ$ a $2\\beta=70^\\circ$. Úhel $\\alpha$ je přilehlý k úhlu $2\\beta$ u rovnoběžek $m$, $n$ (jejich součet je $180^\\circ$), takže $\\alpha=180^\\circ-70^\\circ=110^\\circ$.'],
     'ans': 'B) $110^\\circ$', 'pts': 2, 'mins': 4, 'diff': '4',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2024 – úloha 15',
     'zad': ['Přiřaďte ke každé úloze (15.1-15.3) odpovídající výsledek (A-F).',
             '15.1 Koupaliště během letošního léta navštívilo $680$ návštěvníků, což je $80\\,\\%$ všech návštěvníků za celý minulý rok. Kolik návštěvníků přišlo na koupaliště v loňském roce?',
             '15.2 S cestovní kanceláří vycestovalo v červnu $330$ klientů, což bylo o $40\\,\\%$ méně než v měsíci červenci. Kolik klientů vycestovalo s cestovní kanceláří v červenci?',
             '15.3 Na mapě s měřítkem $1:3\\,000$ je vyznačen čtvercový pozemek o straně $15$ cm. Jaká je skutečná délka strany tohoto pozemku v metrech?'],
     'opts': ['A) $450$', 'B) $550$', 'C) $650$', 'D) $750$', 'E) $850$', 'F) jiný výsledek'], 'ln': 0,
     'sol': ['15.1 $680$ je $80\\,\\%$, tj. $100\\,\\%=680:0{,}8=850$ - E.',
             '15.2 $330$ je $60\\,\\%$ červencové hodnoty, tj. $330:0{,}6=550$ - B.',
             '15.3 $15$ cm $\\cdot\\,3\\,000=45\\,000$ cm $=450$ m - A.'],
     'ans': '15.1: E ($850$); 15.2: B ($550$); 15.3: A ($450$)', 'pts': 6, 'mins': 7, 'diff': '3',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7A 2024 – úloha 16',
     'zad': ['Hranol o výšce $15$ cm se skládá ze dvou shodných kvádrů s obdélníkovou podstavou a jednoho kvádru se čtvercovou podstavou. Podstava hranolu i s rozměry je na obrázku.',
             '16.1 Vypočítejte povrch tělesa. Výsledek uveďte v cm².',
             '16.2 Vypočítejte objem tělesa. Výsledek uveďte v cm³.'],
     'opts': None, 'ln': 2, 'svg': SVG16, 'fn': 'podstava-hranolu.svg',
     'alt': 'Podstava hranolu slozena ze dvou obdelniku 6 krat 3 cm a jednoho ctverce 3 krat 3 cm.',
     'cap': 'Podstava hranolu s rozměry',
     'sol': ['Obsah podstavy: dva obdélníky $6\\cdot 3$ a jeden čtverec $3\\cdot 3$, tj. $18+18+9=45$ cm². Obvod podstavy je $36$ cm.',
             '16.1 Povrch $=2\\cdot 45+36\\cdot 15=90+540=630$ cm².',
             '16.2 Objem $=45\\cdot 15=675$ cm³.'],
     'ans': '16.1: $630$ cm²; 16.2: $675$ cm³', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['stereometrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M7PAD24C0T01'
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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M7A-2024')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} uloh [{"OK" if sz<9000 else "PRES 9KB"}]')
    print('Celkem uloh:', tot)
