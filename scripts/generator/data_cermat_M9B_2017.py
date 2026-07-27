# -*- coding: utf-8 -*-
# CERMAT – Jednotná přijímací zkouška 2017, MATEMATIKA 9 B (čtyřleté obory), 2. řádný termín.
# Kód testu: M9PBD17C0T02. 16 úloh (po rozdělení samostatných počtářských podúloh 19 úloh).
# Zdroj odpovědí: klíč správných řešení (KSR) + záznamový arch (VZA). Celkem 50 bodů.

# ---- SVG obrázky (bez ' a \) ----

# úloha 7: kružnice k (r = 5 cm) s vepsaným obdélníkem ABCD, delší strana 8 cm
SVG7 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 300" font-family="sans-serif">
<circle cx="200" cy="150" r="90" fill="none" stroke="#000" stroke-width="2"/>
<rect x="128" y="96" width="144" height="108" fill="none" stroke="#000" stroke-width="2"/>
<line x1="128" y1="96" x2="272" y2="204" stroke="#000"/>
<line x1="272" y1="96" x2="128" y2="204" stroke="#000"/>
<line x1="200" y1="150" x2="128" y2="204" stroke="#000"/>
<text x="200" y="90" font-size="14" text-anchor="middle">8 cm</text>
<text x="112" y="92" font-size="16" font-style="italic">D</text>
<text x="278" y="92" font-size="16" font-style="italic">C</text>
<text x="112" y="220" font-size="16" font-style="italic">A</text>
<text x="278" y="220" font-size="16" font-style="italic">B</text>
<text x="286" y="76" font-size="16" font-style="italic">k</text>
<text x="152" y="176" font-size="15" font-style="italic">r</text>
<text x="206" y="156" font-size="14">x</text>
<text x="206" y="172" font-size="15" font-style="italic">S</text>
</svg>"""

# úloha 9: výchozí obrázek – trojúhelník RST
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 240" font-family="sans-serif">
<polygon points="50,190 250,190 340,60" fill="none" stroke="#000" stroke-width="2"/>
<text x="40" y="210" font-size="16" font-style="italic">R</text>
<text x="246" y="210" font-size="16" font-style="italic">S</text>
<text x="346" y="52" font-size="16" font-style="italic">T</text>
</svg>"""

# úloha 10: kružnice k se středem S, přímka ji protíná v bodech C a D
SVG10 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 320" font-family="sans-serif">
<circle cx="210" cy="180" r="100" fill="none" stroke="#000" stroke-width="2"/>
<line x1="61" y1="130" x2="339" y2="90" stroke="#000" stroke-width="2"/>
<line x1="270" y1="100" x2="210" y2="180" stroke="#000"/>
<text x="272" y="90" font-size="16" font-style="italic">C</text>
<text x="112" y="126" font-size="16" font-style="italic">D</text>
<text x="304" y="212" font-size="16" font-style="italic">k</text>
<text x="204" y="186" font-size="14">x</text>
<text x="216" y="198" font-size="15" font-style="italic">S</text>
</svg>"""

# úloha 12: trojúhelník s úhly 52 a beta, uvnitř úsečka rovnoběžná s levým ramenem, úhel 88
SVG12 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 250" font-family="sans-serif">
<polygon points="40,220 440,220 185,35" fill="none" stroke="#000" stroke-width="2.5"/>
<line x1="150" y1="220" x2="255" y2="86" stroke="#000" stroke-width="2"/>
<path d="M 82 220 A 42 42 0 0 0 66 187" fill="none" stroke="#000"/>
<path d="M 398 220 A 42 42 0 0 1 406 195" fill="none" stroke="#000"/>
<path d="M 228 66 A 34 34 0 0 0 234 113" fill="none" stroke="#000"/>
<line x1="121" y1="129" x2="109" y2="120" stroke="#000" stroke-width="2"/>
<line x1="116" y1="136" x2="104" y2="126" stroke="#000" stroke-width="2"/>
<line x1="211" y1="155" x2="199" y2="145" stroke="#000" stroke-width="2"/>
<line x1="206" y1="161" x2="194" y2="151" stroke="#000" stroke-width="2"/>
<text x="90" y="205" font-size="16" text-anchor="middle">52°</text>
<text x="200" y="99" font-size="16" text-anchor="middle">88°</text>
<text x="386" y="208" font-size="17" text-anchor="middle" font-style="italic">β</text>
</svg>"""


# úlohy 13 a 14: krabice tvaru kvádru s krychličkami a řada krychliček
def _box():
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 280" font-family="sans-serif">',
         '<g stroke="#000" fill="#fff">',
         '<polygon points="40,90 80,60 240,60 200,90" fill="#f2f2f2" stroke-width="2"/>',
         '<polygon points="200,90 240,60 240,180 200,210" fill="#cfcfcf" stroke-width="2"/>',
         '<rect x="40" y="90" width="160" height="120" stroke-width="2"/>']
    for i in range(4):
        x = 44 + 32 * i
        s.append(f'<rect x="{x}" y="62" width="28" height="28"/>')
        s.append(f'<polygon points="{x},62 {x+12},51 {x+40},51 {x+28},62" fill="#f2f2f2"/>')
    s.append('<polygon points="168,62 180,51 180,79 168,90" fill="#e0e0e0"/>')
    for i in range(12):
        x = 60 + 20 * i
        s.append(f'<rect x="{x}" y="258" width="20" height="18"/>')
        s.append(f'<polygon points="{x},258 {x+8},250 {x+28},250 {x+20},258" fill="#f2f2f2"/>')
    s.append('</g><text x="60" y="242" font-size="13">Z naplněné krabice vytvoříme z krychliček jedinou řadu:</text>')
    s.append('<text x="308" y="274" font-size="18">...</text></svg>')
    return "".join(s)


SVG13 = _box()


# úloha 15.3: tabulka počtu žáků v devátých třídách
def _table():
    cols = [30, 150, 235, 320, 410]
    rows = [20, 52, 84, 116, 148]
    head = ['', '9. A', '9. B', 'Obě třídy']
    data = [['Chlapci', '11', '', ''], ['Dívky', '14', '', ''], ['Všichni žáci', '25', '', '50']]
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 170" font-family="sans-serif">']
    for x in cols:
        s.append(f'<line x1="{x}" y1="20" x2="{x}" y2="148" stroke="#000"/>')
    for y in rows:
        s.append(f'<line x1="30" y1="{y}" x2="410" y2="{y}" stroke="#000"/>')
    for i, t in enumerate(head):
        if t:
            s.append(f'<text x="{(cols[i]+cols[i+1])//2}" y="42" font-size="14" text-anchor="middle">{t}</text>')
    for r, row in enumerate(data):
        s.append(f'<text x="36" y="{rows[r+1]+22}" font-size="14">{row[0]}</text>')
        for i in (1, 2, 3):
            if row[i]:
                s.append(f'<text x="{(cols[i]+cols[i+1])//2}" y="{rows[r+1]+22}" font-size="14" text-anchor="middle">{row[i]}</text>')
    s.append('</svg>')
    return "".join(s)


SVG15 = _table()


# úloha 16: obrazce typu A (dotyk kratší stranou) a typu B (dotyk delší stranou)
def _rects():
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 280" font-family="sans-serif">',
         '<g fill="#f0f0f0" stroke="#000" stroke-width="2">']

    def rowA(y, n, x0=48):
        return [f'<rect x="{x0+60*i}" y="{y}" width="60" height="36"/>' for i in range(n)]

    def rowB(y, n, x0=300):
        return [f'<rect x="{x0+36*i}" y="{y}" width="36" height="60"/>' for i in range(n)]

    for y, n in ((18, 2), (98, 3)):
        s += rowA(y, n) + rowB(y - 12, n)
    s += rowA(188, 2) + rowA(188, 1, x0=214) + rowB(176, 2) + rowB(176, 1, x0=414)
    s.append('</g><g font-size="17" font-weight="bold">')
    for y in (42, 122, 212):
        s.append(f'<text x="20" y="{y}">A</text><text x="272" y="{y}">B</text>')
    s.append('</g><text x="180" y="212" font-size="18">...</text>')
    s.append('<text x="380" y="212" font-size="18">...</text></svg>')
    return "".join(s)


SVG16 = _rects()

B = ['zs2', 'r9']  # 2. stupeň ZŠ, 9. ročník

PROBLEMS = [
    {'name': 'CERMAT M9B 2017 – úloha 1', 'zad': [
        'Určete číslo, které musíme odečíst od výrazu $\\sqrt{1+\\frac{9}{16}}$, abychom získali výsledek $0{,}5$.'],
     'opts': None, 'ln': 2,
     'sol': ['$\\sqrt{1+\\frac{9}{16}}=\\sqrt{\\frac{25}{16}}=\\frac{5}{4}$.',
             'Hledáme $x$, pro které $\\frac{5}{4}-x=\\frac{1}{2}$, tedy $x=\\frac{5}{4}-\\frac{2}{4}=\\frac{3}{4}$.'],
     'ans': '$\\frac{3}{4}$', 'pts': 1, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2017 – úloha 2.1', 'zad': ['Vypočtěte: $0{,}5:0{,}5^2=$'],
     'opts': None, 'ln': 2,
     'sol': ['$0{,}5^2=0{,}25$, tedy $0{,}5:0{,}25=2$.'],
     'ans': '$2$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2017 – úloha 2.2', 'zad': ['Vypočtěte: $6\\cdot\\frac{-15-6\\cdot(-2)}{2}=$'],
     'opts': None, 'ln': 2,
     'sol': ['V čitateli: $-15-6\\cdot(-2)=-15+12=-3$.',
             'Dále $6\\cdot\\frac{-3}{2}=6\\cdot(-1{,}5)=-9$.'],
     'ans': '$-9$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2017 – úloha 3.1', 'zad': [
        'Vypočtěte a výsledek zapište zlomkem v základním tvaru. Uveďte celý postup řešení.',
        '$2-\\frac{1}{3}-\\frac{1}{6}\\cdot\\frac{16}{3}=$'],
     'opts': None, 'ln': 4,
     'sol': ['Nejprve násobení: $\\frac{1}{6}\\cdot\\frac{16}{3}=\\frac{16}{18}=\\frac{8}{9}$.',
             'Pak $2-\\frac{1}{3}-\\frac{8}{9}=\\frac{18}{9}-\\frac{3}{9}-\\frac{8}{9}=\\frac{7}{9}$.'],
     'ans': '$\\frac{7}{9}$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2017 – úloha 3.2', 'zad': [
        'Vypočtěte a výsledek zapište zlomkem v základním tvaru. Uveďte celý postup řešení.',
        '$\\frac{\\frac{7}{10}-\\frac{2}{5}:\\frac{1}{10}}{20\\cdot\\frac{3}{10}}=$'],
     'opts': None, 'ln': 4,
     'sol': ['Čitatel: $\\frac{2}{5}:\\frac{1}{10}=\\frac{2}{5}\\cdot 10=4$, tedy $\\frac{7}{10}-4=\\frac{7}{10}-\\frac{40}{10}=-\\frac{33}{10}$.',
             'Jmenovatel: $20\\cdot\\frac{3}{10}=6$.',
             'Celkem $-\\frac{33}{10}:6=-\\frac{33}{60}=-\\frac{11}{20}$.'],
     'ans': '$-\\frac{11}{20}$', 'pts': 2, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2017 – úloha 4.1', 'zad': [
        'Zjednodušte. Výsledný výraz nesmí obsahovat závorky. Uveďte celý postup řešení.',
        '$(x-4)^2+(8-2x)\\cdot 2x=$'],
     'opts': None, 'ln': 4,
     'sol': ['$(x-4)^2=x^2-8x+16$.',
             '$(8-2x)\\cdot 2x=16x-4x^2$.',
             'Součet: $x^2-8x+16+16x-4x^2=-3x^2+8x+16$.'],
     'ans': '$-3x^2+8x+16$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2017 – úloha 4.2', 'zad': [
        'Zjednodušte. Výsledný výraz nesmí obsahovat závorky. Uveďte celý postup řešení.',
        '$(a+2a)\\cdot(a-2a)-(a-2a)=$'],
     'opts': None, 'ln': 4,
     'sol': ['V závorkách sečteme: $a+2a=3a$, $a-2a=-a$.',
             '$3a\\cdot(-a)-(-a)=-3a^2+a$, tedy $a-3a^2$.'],
     'ans': '$a-3a^2$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2017 – úloha 5.1', 'zad': [
        'Řešte rovnici. Uveďte celý postup řešení (zkoušku nezapisujte).',
        '$4x+1=4\\cdot(4x+0{,}25)$'],
     'opts': None, 'ln': 4,
     'sol': ['Roznásobíme pravou stranu: $4x+1=16x+1$.',
             'Odečteme $1$ a $4x$: $0=12x$, tedy $x=0$.'],
     'ans': '$x=0$', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2017 – úloha 5.2', 'zad': [
        'Řešte rovnici. Uveďte celý postup řešení (zkoušku nezapisujte).',
        '$\\frac{x-5}{2}+x=\\frac{2x}{3}-\\frac{5}{6}$'],
     'opts': None, 'ln': 4,
     'sol': ['Rovnici vynásobíme společným jmenovatelem $6$: $3(x-5)+6x=4x-5$.',
             '$3x-15+6x=4x-5$, tedy $9x-15=4x-5$.',
             '$5x=10$, tedy $x=2$.'],
     'ans': '$x=2$', 'pts': 2, 'mins': 5, 'diff': '3',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2017 – úloha 6', 'zad': [
        'V promítacím sále bylo přítomno 100 platících osob. Cena vstupenky pro dospělého je 200 Kč, pro dítě 150 Kč. V pokladně vybrali za vstupenky 16 000 Kč.',
        '6.1 Vypočtěte, o kolik procent je vstupenka pro dítě levnější než vstupenka pro dospělého.',
        '6.2 Vypočtěte, kolik dětí bylo v promítacím sále.',
        '6.3 Vypočtěte, kolik Kč vybrali v pokladně za vstupné pro dospělé.'],
     'opts': None, 'ln': 3,
     'sol': ['6.1 Rozdíl cen je $200-150=50$ Kč, což je $\\frac{50}{200}=0{,}25$, tedy o $25$ %.',
             '6.2 Je-li $d$ počet dětí, pak dospělých je $100-d$: $150d+200(100-d)=16\\,000$, tj. $20\\,000-50d=16\\,000$, odtud $d=80$.',
             '6.3 Dospělých bylo $100-80=20$, zaplatili $20\\cdot 200=4\\,000$ Kč.'],
     'ans': '6.1: o $25$ %; 6.2: $80$ dětí; 6.3: $4\\,000$ Kč', 'pts': 4, 'mins': 7, 'diff': '3',
     'codes': B + ['procenta', 'modelovani', 'slovni', 'bez-kalkulacky', 'finance']},

    {'name': 'CERMAT M9B 2017 – úloha 7', 'zad': [
        'Na kružnici $k$ s poloměrem $r=5$ cm ($r=|SA|$) leží vrcholy obdélníku $ABCD$. Delší strana obdélníku měří $8$ cm.',
        '7.1 Vypočtěte délku kružnice a výsledek v cm zaokrouhlete na desetiny.',
        '7.2 Vypočtěte v cm obvod obdélníku $ABCD$.'],
     'opts': None, 'ln': 3, 'svg': SVG7, 'fn': 'kruznice-obdelnik.svg',
     'alt': 'Kružnice k se středem S a poloměrem r, do níž je vepsán obdélník ABCD s delší stranou 8 cm.',
     'cap': 'Obdélník ABCD vepsaný kružnici k',
     'sol': ['7.1 $o=2\\pi r=2\\cdot 3{,}14\\cdot 5=31{,}4$ cm.',
             '7.2 Úhlopříčka obdélníku je průměr kružnice, tedy $10$ cm. Podle Pythagorovy věty je kratší strana $\\sqrt{10^2-8^2}=\\sqrt{36}=6$ cm.',
             'Obvod $=2\\cdot(8+6)=28$ cm.'],
     'ans': '7.1: $31{,}4$ cm; 7.2: $28$ cm', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2017 – úloha 8', 'zad': [
        'Doplňte na vyznačená místa čísla tak, aby platila rovnost:',
        '8.1 $3$ dm² $= 1$ dm² $+$ ___ cm²',
        '8.2 $1{,}2$ litru $=$ ___ dm³ $-$ $100$ cm³',
        '8.3 ___ $\\cdot\\ 1{,}5$ hodiny $+ 20$ minut $= 1$ hodina $5$ minut'],
     'opts': None, 'ln': 3,
     'sol': ['8.1 $3$ dm² $-1$ dm² $=2$ dm² $=200$ cm².',
             '8.2 $1{,}2$ litru $=1{,}2$ dm³ a $100$ cm³ $=0{,}1$ dm³, tedy hledané číslo je $1{,}2+0{,}1=1{,}3$.',
             '8.3 $1$ hodina $5$ minut $=65$ minut, $65-20=45$ minut; $1{,}5$ hodiny $=90$ minut a $45:90=0{,}5$.'],
     'ans': '8.1: $200$; 8.2: $1{,}3$; 8.3: $0{,}5$', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2017 – úloha 9 (konstrukce)', 'zad': [
        'V rovině leží trojúhelník $RST$ (viz obrázek).',
        'Sestrojte obraz $R_1S_1T_1$ trojúhelníku $RST$ ve středové souměrnosti se středem $S$. Všechny vrcholy trojúhelníku $R_1S_1T_1$ označte.'],
     'opts': None, 'ln': 0, 'svg': SVG9, 'fn': 'trojuhelnik-RST.svg',
     'alt': 'Trojúhelník RST v rovině; vrchol R vlevo dole, S uprostřed dole, T vpravo nahoře.',
     'cap': 'Výchozí obrázek k úloze 9',
     'sol': ['Střed souměrnosti $S$ je samodružný bod, proto $S_1=S$.',
             'Bod $R_1$ leží na přímce $RS$ na opačné polopřímce než $R$ a platí $|SR_1|=|SR|$.',
             'Bod $T_1$ leží na přímce $TS$ na opačné polopřímce než $T$ a platí $|ST_1|=|ST|$.',
             'Spojením bodů $R_1$, $S_1$, $T_1$ vznikne hledaný obraz.'],
     'ans': 'Trojúhelník $R_1S_1T_1$: $S_1=S$, bod $R_1$ na přímce $RS$ za bodem $S$ s $|SR_1|=|SR|$, bod $T_1$ na přímce $TS$ za bodem $S$ s $|ST_1|=|ST|$ – viz obrázek v klíči.',
     'pts': 2, 'mins': 4, 'diff': '2',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2017 – úloha 10 (konstrukce)', 'zad': [
        'Kružnici $k$ se středem $S$ protíná přímka ve dvou bodech $C$ a $D$ (viz obrázek).',
        'Body $C$, $D$ jsou vrcholy rovnoramenného lichoběžníku $ABCD$. Všechny čtyři vrcholy tohoto lichoběžníku leží na kružnici $k$. Vzdálenost chybějících vrcholů $A$, $B$ od přímky $CD$ je rovna poloměru $r=|SC|$ kružnice $k$.',
        '10.1 Sestrojte vrcholy $A$, $B$ lichoběžníku $ABCD$ a lichoběžník narýsujte.',
        '10.2 Sestrojte osu souměrnosti lichoběžníku $ABCD$ (pokud existuje) a označte ji $o$.',
        '10.3 Sestrojte výšku lichoběžníku $ABCD$ z vrcholu $D$ a označte ji $v$.'],
     'opts': None, 'ln': 0, 'svg': SVG10, 'fn': 'kruznice-secna.svg',
     'alt': 'Kružnice k se středem S, kterou protíná přímka v bodech C a D.',
     'cap': 'Výchozí obrázek k úloze 10',
     'sol': ['10.1 Sestrojíme rovnoběžku s přímkou $CD$ ve vzdálenosti $r=|SC|$, a to na té straně přímky $CD$, kde leží střed $S$. Její průsečíky s kružnicí $k$ jsou vrcholy $A$ a $B$. Protože $AB$ je rovnoběžná s $CD$ a obě jsou tětivy téže kružnice, je lichoběžník $ABCD$ rovnoramenný.',
             '10.2 Osa souměrnosti $o$ je společná osa obou rovnoběžných stran; je kolmá na $AB$ i $CD$ a prochází středem $S$.',
             '10.3 Výška $v$ z vrcholu $D$ je kolmice vedená z bodu $D$ k přímce $AB$ (její délka je rovna $r$).'],
     'ans': 'Vrcholy $A$, $B$ jsou průsečíky kružnice $k$ s rovnoběžkou s $CD$ vedenou ve vzdálenosti $r=|SC|$ na straně středu $S$; osa $o$ prochází $S$ kolmo k $AB$; výška $v$ je kolmice z $D$ k přímce $AB$ – viz obrázek v klíči.',
     'pts': 3, 'mins': 8, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2017 – úloha 11', 'zad': [
        'Balení, které obsahuje 15 kg granulí, vystačí čtyřem psům na 15 dnů. Všichni čtyři psi dostávají denně stejné množství granulí.',
        'Rozhodněte o každém z následujících tvrzení (11.1–11.3), zda je pravdivé (A), či nikoli (N).',
        '11.1 Jeden pes dostává denně 250 g granulí.',
        '11.2 Pouze dvěma psům by 15kg balení granulí vystačilo na 30 dnů.',
        '11.3 Jednomu psovi vystačí desetina 15kg balení granulí na 10 dnů.'],
     'opts': None, 'ln': 0,
     'sol': ['Jeden pes spotřebuje denně $15\\,000:(4\\cdot 15)=250$ g granulí.',
             '11.1 Ano.',
             '11.2 Dva psi spotřebují denně $500$ g, balení vystačí na $15\\,000:500=30$ dnů → Ano.',
             '11.3 Desetina balení je $1\\,500$ g, což jednomu psovi vystačí na $1\\,500:250=6$ dnů, ne na 10 → Ne.'],
     'ans': '11.1: Ano; 11.2: Ano; 11.3: Ne', 'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9B 2017 – úloha 12', 'zad': [
        'V trojúhelníku je vyznačen úhel $52^\\circ$ při levém vrcholu a úhel $\\beta$ při pravém vrcholu. Úsečka uvnitř trojúhelníku (vyznačená dvojicí shodných značek) je rovnoběžná s levou stranou trojúhelníku; svírá s pravou stranou trojúhelníku úhel $88^\\circ$.',
        'Jaká je velikost úhlu $\\beta$? Úhel neměřte, ale vypočtěte.'],
     'opts': ['A) $36^\\circ$', 'B) $38^\\circ$', 'C) $40^\\circ$', 'D) $48^\\circ$', 'E) jiný výsledek'],
     'ln': 0, 'svg': SVG12, 'fn': 'trojuhelnik-uhly.svg',
     'alt': 'Trojúhelník s úhlem 52 stupňů vlevo a úhlem beta vpravo, uvnitř úsečka rovnoběžná s levou stranou svírající s pravou stranou úhel 88 stupňů.',
     'cap': 'Výchozí obrázek k úloze 12',
     'sol': ['Vyznačená úsečka je rovnoběžná s levou stranou trojúhelníku, proto svírá se základnou souhlasný úhel $52^\\circ$.',
             'Úhel, který svírá tato úsečka s pravou stranou na druhou stranu, je vedlejší k úhlu $88^\\circ$, tedy $180^\\circ-88^\\circ=92^\\circ$.',
             'V menším trojúhelníku vpravo tak platí $\\beta=180^\\circ-52^\\circ-92^\\circ=36^\\circ$.'],
     'ans': 'A) $36^\\circ$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['planimetrie', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2017 – úloha 13', 'zad': [
        'Krabici tvaru kvádru lze naplnit až po okraj krychličkami s délkou hrany 2 cm. Na dno krabice se do jedné vrstvy naskládá bez mezer 20 krychliček a takové vrstvy mohou být v krabici nejvýše 4.',
        'Ze zcela naplněné krabice vyjmeme všechny krychličky a vytvoříme z nich jedinou řadu.',
        'Jak dlouhá bude řada?'],
     'opts': ['A) $0{,}8$ m', 'B) $1{,}6$ m', 'C) $2{,}0$ m', 'D) $2{,}4$ m', 'E) delší než $2{,}4$ m'],
     'ln': 0, 'svg': SVG13, 'fn': 'krabice-krychlicky.svg',
     'alt': 'Krabice tvaru kvádru naplňovaná krychličkami a řada krychliček vytvořená z obsahu krabice.',
     'cap': 'Krabice s krychličkami a řada krychliček',
     'sol': ['V krabici je $20\\cdot 4=80$ krychliček.',
             'Řada má délku $80\\cdot 2=160$ cm $=1{,}6$ m.'],
     'ans': 'B) $1{,}6$ m', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['stereometrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2017 – úloha 14', 'zad': [
        'Krabici tvaru kvádru lze naplnit až po okraj krychličkami s délkou hrany 2 cm. Na dno krabice se do jedné vrstvy naskládá bez mezer 20 krychliček a takové vrstvy mohou být v krabici nejvýše 4.',
        'Jaký je objem krabice?'],
     'opts': ['A) $160$ cm³', 'B) $320$ cm³', 'C) $480$ cm³', 'D) $640$ cm³', 'E) jiný objem'],
     'ln': 0, 'svg': SVG13, 'fn': 'krabice-krychlicky.svg',
     'alt': 'Krabice tvaru kvádru naplňovaná krychličkami a řada krychliček vytvořená z obsahu krabice.',
     'cap': 'Krabice s krychličkami a řada krychliček',
     'sol': ['Objem jedné krychličky je $2^3=8$ cm³.',
             'Krychliček je $20\\cdot 4=80$, objem krabice je tedy $80\\cdot 8=640$ cm³.'],
     'ans': 'D) $640$ cm³', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['stereometrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2017 – úloha 15', 'zad': [
        'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).',
        '15.1 Dvě plné lahve minerálky tvoří 5 % zásob. Kolik plných lahví minerálky tvoří čtvrtinu zásob?',
        '15.2 V autobusu jede 21 osob. Dětí je mezi nimi o třetinu více než dospělých. Kolik dospělých jede v autobusu?',
        '15.3 Tabulka udává počet žáků v devátých třídách. Mezi všemi žáky obou devátých tříd je 54 % dívek. Kolik chlapců je ve třídě 9. B?'],
     'opts': ['A) méně než 9', 'B) 9', 'C) 10', 'D) 11', 'E) 12', 'F) více než 12'],
     'ln': 0, 'svg': SVG15, 'fn': 'tabulka-zaci.svg',
     'alt': 'Tabulka počtu žáků: řádky Chlapci, Dívky, Všichni žáci; sloupce 9. A, 9. B, Obě třídy. Vyplněno 11, 14, 25 a 50.',
     'cap': 'Počet žáků v devátých třídách',
     'sol': ['15.1 $5$ % odpovídají $2$ lahvím, tedy $25$ % odpovídá $5\\cdot 2=10$ lahvím → C.',
             '15.2 Je-li dospělých $d$, dětí je $\\frac{4}{3}d$: $d+\\frac{4}{3}d=21$, tj. $\\frac{7}{3}d=21$, odtud $d=9$ → B.',
             '15.3 Dívek v obou třídách je $0{,}54\\cdot 50=27$, v 9. B tedy $27-14=13$. Žáků v 9. B je $50-25=25$, chlapců $25-13=12$ → E.'],
     'ans': '15.1: C ($10$ lahví); 15.2: B ($9$ dospělých); 15.3: E ($12$ chlapců)',
     'pts': 6, 'mins': 8, 'diff': '3',
     'codes': B + ['procenta', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9B 2017 – úloha 16', 'zad': [
        'Dva nebo více shodných obdélníků poskládáme těsně vedle sebe do jedné řady. Pokud se každé dva sousední obdélníky dotýkají kratší stranou, vznikne obrazec typu A, dotýkají-li se delší stranou, vznikne obrazec typu B.',
        'Platí: Obvody obrazců typu A a B složených ze dvou obdélníků se liší o 10 cm. Přidáme-li k oběma obrazcům další obdélníky, rozdíl mezi obvody obou obrazců se změní.',
        '16.1 Vypočtěte, o kolik cm se liší obvody obrazců A a B, obsahuje-li každý z nich tři obdélníky.',
        '16.2 Vypočtěte, o kolik cm se liší obvody obrazců A a B, obsahuje-li každý z nich šest obdélníků.',
        '16.3 Obvody obrazců A a B, které obsahují stejný počet obdélníků, se liší o 100 cm. Vypočtěte, z kolika obdélníků je složen jeden z těchto obrazců.'],
     'opts': None, 'ln': 3, 'svg': SVG16, 'fn': 'obrazce-AB.svg',
     'alt': 'Obrazce typu A (obdélníky vedle sebe dotýkající se kratší stranou) a typu B (dotýkající se delší stranou) pro dva, tři a více obdélníků.',
     'cap': 'Obrazce typu A a typu B',
     'sol': ['Označme delší stranu obdélníku $a$ a kratší $b$. Obrazec typu A z $n$ obdélníků má obvod $2(na+b)$, obrazec typu B obvod $2(a+nb)$.',
             'Rozdíl obvodů je $2(na+b)-2(a+nb)=2(n-1)(a-b)$.',
             'Pro $n=2$ je rozdíl $2(a-b)=10$ cm, tedy $a-b=5$ cm a obecně je rozdíl $10(n-1)$ cm.',
             '16.1 Pro $n=3$: $10\\cdot 2=20$ cm.',
             '16.2 Pro $n=6$: $10\\cdot 5=50$ cm.',
             '16.3 $10(n-1)=100$, tedy $n-1=10$ a $n=11$ obdélníků.'],
     'ans': '16.1: o $20$ cm; 16.2: o $50$ cm; 16.3: $11$ obdélníků', 'pts': 4, 'mins': 8, 'diff': '4',
     'codes': B + ['planimetrie', 'modelovani', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M9PBD17C0T02'
    gen.YEAR = 2017

    def dollars_ok(s): return s.count('$') % 2 == 0
    errors = []; names = set(); pts_total = 0
    for p in PROBLEMS:
        if p['name'] in names: errors.append('DUP název: ' + p['name'])
        names.add(p['name']); pts_total += p['pts']
        if not p['name'].startswith('CERMAT M9B 2017 – úloha '): errors.append('Špatný název: ' + p['name'])
        for t in [p['name'], p['ans']] + list(p['zad']) + list(p['sol']) + (p.get('opts') or []):
            if not dollars_ok(t): errors.append('Nepárový $: ' + t[:70])
        if p.get('svg') and ("'" in p['svg'] or '\\' in p['svg']):
            errors.append('SVG zakázaný znak: ' + p['name'])
        if p.get('svg') and not p.get('alt'): errors.append('Obrázek bez alt: ' + p['name'])
        for lbl, obj in (('content', gen.py_content_json(p)), ('solution', gen.py_solution_json(p)), ('answer', gen.py_answer_json(p))):
            try: json.loads(json.dumps(obj, ensure_ascii=False))
            except Exception as e: errors.append(f'JSON {lbl} {p["name"]}: {e}')
    if pts_total != 50: errors.append(f'Součet bodů je {pts_total}, má být 50')
    if errors:
        print('CHYBY:'); [print('  -', e) for e in errors]; sys.exit(1)
    print('Validace OK:', len(PROBLEMS), 'úloh, celkem', pts_total, 'bodů')
    outdir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'out')
    os.makedirs(outdir, exist_ok=True)
    tot = 0
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M9B-2017')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
