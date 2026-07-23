# -*- coding: utf-8 -*-
# CERMAT - Jednotna prijimaci zkouska 2025, MATEMATIKA 9A, 1. radny termin (ostry test).
# Kod testu: M9PAD25C0T01. 16 uloh (po rozdeleni nezavislych poduloh 20 uloh).
# Ctyrlete obory, 9. rocnik. Zdroj odpovedi: rozsireny klic spravnych reseni (KSR).

# ---- SVG obrazky (bez ' a \) ----

# uloha 5: ctvercovy pozemek (strana c), dum (svetle sedy obdelnik) vlevo nahore, rybnicek (tmavy) vpravo dole
SVG5 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 340 300" font-family="sans-serif">
<rect x="50" y="30" width="240" height="240" fill="none" stroke="#000" stroke-width="2"/>
<rect x="70" y="50" width="90" height="110" fill="#ededed" stroke="#000"/>
<polygon points="200,178 240,168 266,192 258,236 212,246 190,214" fill="#8a8a8a" stroke="#000"/>
<text x="166" y="108" font-size="14" font-style="italic">a</text>
<text x="110" y="176" font-size="14" font-style="italic">b</text>
<text x="298" y="154" font-size="14" font-style="italic">c</text>
<text x="167" y="288" font-size="14" font-style="italic">c</text>
</svg>"""

# uloha 7: primky p,q,r pretinajici se v R; s || r, s kolme na t; vyznacene uhly 30 a 130
SVG7 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 320" font-family="sans-serif">
<line x1="70" y1="150" x2="430" y2="150" stroke="#000" stroke-width="1.5"/><text x="436" y="155" font-size="15" font-style="italic">r</text>
<line x1="70" y1="240" x2="430" y2="240" stroke="#000" stroke-width="1.5"/><text x="436" y="245" font-size="15" font-style="italic">s</text>
<line x1="390" y1="110" x2="390" y2="272" stroke="#000" stroke-width="1.5"/><text x="396" y="285" font-size="15" font-style="italic">t</text>
<line x1="150" y1="258" x2="360" y2="50" stroke="#000" stroke-width="1.5"/><text x="150" y="272" font-size="15" font-style="italic">p</text>
<line x1="200" y1="272" x2="310" y2="48" stroke="#000" stroke-width="1.5"/><text x="205" y="286" font-size="15" font-style="italic">q</text>
<text x="256" y="146" font-size="15" font-style="italic">R</text>
<text x="222" y="170" font-size="12">30</text><text x="238" y="170" font-size="10">o</text>
<text x="282" y="172" font-size="12">130</text><text x="304" y="172" font-size="10">o</text>
<text x="152" y="232" font-size="14">a</text>
<text x="222" y="232" font-size="14">b</text>
<text x="330" y="92" font-size="14">g</text>
<rect x="378" y="228" width="12" height="12" fill="none" stroke="#000"/>
<text x="330" y="145" font-size="14">||</text><text x="330" y="236" font-size="14">||</text>
</svg>"""

# uloha 8: ctyruhelnikovy zahon s puntiky po obvodu + detail rozestupu 40 cm
SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 240" font-family="sans-serif">
<polygon points="70,40 200,46 214,180 46,182" fill="none" stroke="#000" stroke-width="1.5"/>
<circle cx="70" cy="40" r="3" fill="#000"/><circle cx="135" cy="43" r="3" fill="#000"/><circle cx="200" cy="46" r="3" fill="#000"/>
<circle cx="207" cy="113" r="3" fill="#000"/><circle cx="214" cy="180" r="3" fill="#000"/>
<circle cx="130" cy="181" r="3" fill="#000"/><circle cx="46" cy="182" r="3" fill="#000"/>
<circle cx="58" cy="111" r="3" fill="#000"/>
<text x="120" y="210" font-size="13" text-anchor="middle">zahon (4 strany)</text>
<circle cx="310" cy="90" r="9" fill="#ddd" stroke="#000"/><circle cx="370" cy="90" r="9" fill="#ddd" stroke="#000"/><circle cx="430" cy="90" r="9" fill="#ddd" stroke="#000"/>
<line x1="310" y1="115" x2="370" y2="115" stroke="#000"/><line x1="370" y1="115" x2="430" y2="115" stroke="#000"/>
<text x="340" y="130" font-size="12" text-anchor="middle">40 cm</text><text x="400" y="130" font-size="12" text-anchor="middle">40 cm</text>
</svg>"""

# uloha 9: ruznobezky p, q a bod R
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 260" font-family="sans-serif">
<line x1="120" y1="35" x2="285" y2="230" stroke="#000" stroke-width="1.5"/><text x="108" y="35" font-size="15" font-style="italic">q</text>
<line x1="55" y1="180" x2="365" y2="118" stroke="#000" stroke-width="1.5"/><text x="372" y="118" font-size="15" font-style="italic">p</text>
<text x="212" y="112" font-size="15" text-anchor="middle">x</text>
<text x="212" y="128" font-size="15" font-style="italic" text-anchor="middle">R</text>
</svg>"""

# uloha 10: bod B a primky p, q pretinajici se v C
SVG10 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 300" font-family="sans-serif">
<line x1="175" y1="262" x2="268" y2="52" stroke="#000" stroke-width="1.5"/><text x="238" y="60" font-size="15" font-style="italic">p</text>
<line x1="292" y1="258" x2="258" y2="48" stroke="#000" stroke-width="1.5"/><text x="272" y="58" font-size="15" font-style="italic">q</text>
<text x="268" y="86" font-size="15" font-style="italic">C</text>
<text x="356" y="188" font-size="15" text-anchor="middle">x</text>
<text x="356" y="204" font-size="15" font-style="italic" text-anchor="middle">B</text>
</svg>"""

# uloha 11: prostorova telesa - schematicka poznamka (nelze verne prenest do SVG)
SVG11 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 130" font-family="sans-serif">
<text x="280" y="42" font-size="13" text-anchor="middle">Zakladni kvadr 1 cm x 2 cm x 3 cm; telesa M, N (ctyrboke hranoly)</text>
<text x="280" y="64" font-size="13" text-anchor="middle">a P, Q, R jsou slepena vzdy ze dvou zakladnich kvadru (viz testovy sesit).</text>
<text x="280" y="98" font-size="11" text-anchor="middle" fill="#666">Prostorova telesa nelze verne prenest do SVG; posuzuje se podle originalu.</text>
</svg>"""

# uloha 12: podelny rez bazenem (zona neplavcu 1 m, zona plavcu sikme dno 1 az 2 m)
SVG12 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 220" font-family="sans-serif">
<polygon points="50,60 420,60 420,150 240,110 50,110" fill="#dfeaf3" stroke="#000" stroke-width="1.5"/>
<line x1="240" y1="60" x2="240" y2="110" stroke="#888" stroke-width="1" stroke-dasharray="4 4"/>
<text x="145" y="45" font-size="12" text-anchor="middle">Zona pro neplavce</text>
<text x="330" y="45" font-size="12" text-anchor="middle">Zona pro plavce</text>
<text x="40" y="90" font-size="12" text-anchor="end">1 m</text>
<text x="430" y="140" font-size="12">2 m</text>
<text x="145" y="135" font-size="12" text-anchor="middle">20 m</text>
<text x="235" y="185" font-size="12" text-anchor="middle">40 m</text>
<line x1="50" y1="170" x2="420" y2="170" stroke="#000"/><line x1="50" y1="122" x2="240" y2="122" stroke="#000"/>
<text x="360" y="205" font-size="12" text-anchor="middle">sirka bazenu 10 m</text>
</svg>"""

# uloha 14: tabulka znamek
SVG14 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 80" font-family="sans-serif">
<rect x="15" y="12" width="410" height="52" fill="none" stroke="#000"/>
<line x1="15" y1="38" x2="425" y2="38" stroke="#000"/>
<line x1="125" y1="12" x2="125" y2="64" stroke="#000"/>
<line x1="185" y1="12" x2="185" y2="64" stroke="#000"/><line x1="245" y1="12" x2="245" y2="64" stroke="#000"/>
<line x1="305" y1="12" x2="305" y2="64" stroke="#000"/><line x1="365" y1="12" x2="365" y2="64" stroke="#000"/>
<text x="20" y="31" font-size="13">Znamka</text><text x="20" y="57" font-size="13">Pocet zaku</text>
<text x="155" y="31" font-size="13" text-anchor="middle">1</text><text x="215" y="31" font-size="13" text-anchor="middle">2</text><text x="275" y="31" font-size="13" text-anchor="middle">3</text><text x="335" y="31" font-size="13" text-anchor="middle">4</text><text x="395" y="31" font-size="13" text-anchor="middle">5</text>
<text x="155" y="57" font-size="13" text-anchor="middle" font-weight="bold">?</text><text x="335" y="57" font-size="13" text-anchor="middle">0</text><text x="395" y="57" font-size="13" text-anchor="middle">0</text>
</svg>"""

# uloha 16: bily ctverec obklopeny pasem obdelnicku - tmavy (uzsi pas) a svetly (sirsi pas), schematicky
SVG16 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 200" font-family="sans-serif">
<rect x="40" y="30" width="150" height="150" fill="#8f8f8f" stroke="#000"/>
<rect x="70" y="60" width="90" height="90" fill="#fff" stroke="#000"/>
<text x="115" y="196" font-size="12" text-anchor="middle">tmavy obrazec (uzsi pas)</text>
<rect x="280" y="20" width="170" height="170" fill="#e2e2e2" stroke="#000"/>
<rect x="325" y="65" width="80" height="80" fill="#fff" stroke="#000"/>
<text x="365" y="196" font-size="12" text-anchor="middle">svetly obrazec (sirsi pas)</text>
</svg>"""

B = ['zs2', 'r9']  # 9. rocnik ZS (ctyrlete obory); stupen zs2

PROBLEMS = [
    {'name': 'CERMAT M9A 2025 - uloha 1', 'zad': [
        'Vypoctete, kolikrat je soucet cisel $16$ a $4$ vetsi nez druha odmocnina ze soucinu cisel $16$ a $4$.'],
     'opts': None, 'ln': 2,
     'sol': ['Soucet $16+4=20$. Soucin $16\\cdot 4=64$, druha odmocnina $\\sqrt{64}=8$. Podil $20:8=2{,}5$.'],
     'ans': '$2{,}5$krat', 'pts': 1, 'mins': 2, 'diff': '1',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2025 - uloha 2.1', 'zad': [
        'Vypoctete a vysledek zapiste zlomkem v zakladnim tvaru: $(-3)\\cdot\\left(\\frac{3}{4}-\\frac{5}{6}\\right)=$'],
     'opts': None, 'ln': 2,
     'sol': ['$\\frac{3}{4}-\\frac{5}{6}=\\frac{9}{12}-\\frac{10}{12}=-\\frac{1}{12}$; pak $(-3)\\cdot\\left(-\\frac{1}{12}\\right)=\\frac{3}{12}=\\frac{1}{4}$.'],
     'ans': '$\\frac{1}{4}$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2025 - uloha 2.2', 'zad': [
        'Vypoctete a vysledek zapiste zlomkem v zakladnim tvaru; uvedte cely postup reseni.',
        '$\\dfrac{\\;\\frac{\\sqrt{25}}{\\sqrt{2\\cdot 2}}\\;}{\\;\\frac{3\\cdot(3^2-2\\cdot 2)}{\\sqrt{5^2-4^2}}\\;}=$'],
     'opts': None, 'ln': 4,
     'sol': ['Citatel $\\frac{\\sqrt{25}}{\\sqrt{2\\cdot 2}}=\\frac{5}{2}$. Jmenovatel $\\frac{3\\cdot(3^2-2\\cdot 2)}{\\sqrt{5^2-4^2}}=\\frac{3\\cdot(9-4)}{\\sqrt{25-16}}=\\frac{15}{3}=5$. Celkem $\\frac{5}{2}:5=\\frac{5}{2}\\cdot\\frac{1}{5}=\\frac{1}{2}$.'],
     'ans': '$\\frac{1}{2}$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2025 - uloha 3.1', 'zad': [
        'Do ramecku doplnte takova cisla, aby platila rovnost: $(a+\\square)^2=a^2+18a+\\square$. Uvedte cisla doplnena do rameckU.'],
     'opts': None, 'ln': 2,
     'sol': ['Podle vzorce $(a+b)^2=a^2+2ab+b^2$ je $2b=18$, tedy $b=9$; druhe cislo je $b^2=81$.'],
     'ans': '$9$; $81$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2025 - uloha 3.2', 'zad': [
        'Upravte na co nejjednodussi tvar bez zavorek: $2-(n+2)\\cdot(-n)+(3-n)\\cdot(n+1)=$'],
     'opts': None, 'ln': 2,
     'sol': ['$-(n+2)\\cdot(-n)=n^2+2n$; $(3-n)(n+1)=-n^2+2n+3$. Celkem $2+n^2+2n-n^2+2n+3=4n+5$.'],
     'ans': '$4n+5$', 'pts': 1, 'mins': 3, 'diff': '3',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2025 - uloha 3.3', 'zad': [
        'Upravte a vysledny vyraz rozlozte na soucin pomoci vzorce; uvedte cely postup reseni. $x\\cdot(18-x)+9\\cdot(16-2x)=$'],
     'opts': None, 'ln': 4,
     'sol': ['$x\\cdot(18-x)+9\\cdot(16-2x)=18x-x^2+144-18x=144-x^2$. Podle vzorce $a^2-b^2=(a+b)(a-b)$: $144-x^2=(12-x)(12+x)$.'],
     'ans': '$(12-x)\\cdot(12+x)$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2025 - uloha 4.1', 'zad': [
        'Reste rovnici; uvedte cely postup reseni (zkousku nezapisujte).',
        '$7\\cdot\\left(\\frac{4}{7}-\\frac{x}{10}\\right)-5\\cdot\\left(\\frac{x}{25}-\\frac{16}{5}\\right)=\\frac{1}{10}x$'],
     'opts': None, 'ln': 4,
     'sol': ['$4-\\frac{7x}{10}-\\frac{x}{5}+16=\\frac{x}{10}$, tj. $20-\\frac{9x}{10}=\\frac{x}{10}$. Odtud $20=\\frac{10x}{10}=x$, tedy $x=20$.'],
     'ans': '$x=20$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2025 - uloha 4.2', 'zad': [
        'Reste rovnici; uvedte cely postup reseni (zkousku nezapisujte). $y-(y+5)\\cdot 0{,}1=0{,}9y+0{,}5$'],
     'opts': None, 'ln': 4,
     'sol': ['$y-0{,}1y-0{,}5=0{,}9y+0{,}5$, tj. $0{,}9y-0{,}5=0{,}9y+0{,}5$. Po odecteni $0{,}9y$ zbude $-0{,}5=0{,}5$, coz neplati. Rovnice nema reseni.'],
     'ans': 'Rovnice nema reseni.', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['rovnice', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2025 - uloha 5', 'zad': [
        'Na obrazku je planek pozemku, na kterem se nachazi dum a rybnicek. Pozemek ma tvar ctverce s delkou strany $c=30$ m. Svetle sedy obdelnik predstavuje pudorys domu a tmavsi obrazec predstavuje rybnicek. Pudorys domu ma petkrat mensi obsah, nez je celkova rozloha pozemku.',
        '5.1 Delka domu $a$ je rovna polovine delky strany pozemku $c$. Urcete sirku domu $b$.',
        '5.2 Rozloha rybnicku predstavuje $18\\,\\%$ celkove rozlohy pozemku. Vypoctete v m2 rozlohu volne casti pozemku, na niz neni ani dum, ani rybnicek.'],
     'opts': None, 'ln': 3, 'svg': SVG5, 'fn': 'pozemek.svg',
     'alt': 'Planek ctvercoveho pozemku o strane c; vlevo nahore svetle sedy obdelnik (dum) se stranami a, b, vpravo dole tmavy obrazec (rybnicek).',
     'cap': 'Schematicky planek pozemku',
     'sol': ['5.1 Rozloha pozemku $30\\cdot 30=900$ m2. Pudorys domu $900:5=180$ m2. Delka $a=c:2=15$ m, tedy sirka $b=180:15=12$ m.',
             '5.2 Rybnicek $0{,}18\\cdot 900=162$ m2. Volna cast $900-180-162=558$ m2.'],
     'ans': '5.1: $b=12$ m; 5.2: $558$ m2', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9A 2025 - uloha 6', 'zad': [
        'Zahradni sud ma tvar rotacniho valce. Dno sudu ma obsah $1500$ cm2.',
        '6.1 Pri desti stoupla hladina vody v sudu o $10$ mm. Vypoctete, kolik litrU vody pribylo v sudu behem tohoto deste.',
        '6.2 Pri silnem lijaku v sudu pribyly $3$ litry vody. Vypoctete, o kolik mm stoupla hladina vody v sudu behem tohoto silneho lijaku.'],
     'opts': None, 'ln': 3,
     'sol': ['6.1 $10$ mm $=1$ cm; objem $=1500\\cdot 1=1500$ cm3 $=1{,}5$ litru.',
             '6.2 $3$ litry $=3000$ cm3; vyska $=3000:1500=2$ cm $=20$ mm.'],
     'ans': '6.1: $1{,}5$ litru; 6.2: $20$ mm', 'pts': 2, 'mins': 4, 'diff': '2',
     'codes': B + ['stereometrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9A 2025 - uloha 7', 'zad': [
        'V rovine lezi primky $p$, $q$, $r$, ktere se protinaji v bode $R$, a primky $s$, $t$, pro ktere plati $s\\parallel r$ a $s\\perp t$. U bodu $R$ jsou vyznaceny uhly $30^\\circ$ a $130^\\circ$ (viz obrazek).',
        'Vypoctete ve stupnich velikost uhlu:',
        '7.1 $\\alpha$,   7.2 $\\beta$,   7.3 $\\gamma$.',
        'Velikosti uhlU nemerte, ale vypoctete (obrazek je pouze ilustrativni).'],
     'opts': None, 'ln': 3, 'svg': SVG7, 'fn': 'primky-uhly.svg',
     'alt': 'Primky p, q, r protinajici se v bode R; rovnobezka s a kolmice t; vyznacene uhly 30 a 130 stupnu a hledane uhly alfa, beta, gama.',
     'cap': 'Vychozi obrazek k uloze 7 (ilustrativni)',
     'sol': ['7.1 Protoze $s\\parallel r$, je $\\alpha$ stridavy uhel k vyznacenemu $30^\\circ$, tedy $\\alpha=30^\\circ$.',
             '7.2 Uhel mezi primkou $q$ a primkou $r$ je vedlejsi k vyznacenemu $130^\\circ$, tj. $50^\\circ$; z rovnobeznosti $s\\parallel r$ je $\\beta=50^\\circ$.',
             '7.3 Primka $t$ je kolma k $r$, proto $\\gamma=90^\\circ+\\beta=90^\\circ+50^\\circ=140^\\circ$.'],
     'ans': '7.1: $\\alpha=30^\\circ$; 7.2: $\\beta=50^\\circ$; 7.3: $\\gamma=140^\\circ$', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2025 - uloha 8', 'zad': [
        'Zahon v parku ma tvar ctyruhelniku, jehoz tri strany jsou stejne dlouhe. Kazda z techto tri stran je o ctvrtinu kratsi, nez je ctvrta strana ctyruhelniku. Po obvodu zahonu je ve stejnych rozestupech vysazeno celkem $65$ rostlin, z nichz je po jedne rostline i v kazdem rohu zahonu. Rozestupy mezi rostlinami meri $40$ cm.',
        '8.1 Vypoctete v metrech obvod zahonu.',
        '8.2 Urcete, o kolik se lisi pocet rostlin na nejdelsi strane zahonu od poctu rostlin na protejsi strane zahonu.',
        '8.3 Po obvodu zahonu se pravidelne stridaji stejne pocetne skupinky cervene kvetoucich rostlin s dvojicemi bile kvetoucich rostlin. Urcete nejmensi mozny pocet cervene kvetoucich rostlin po obvodu zahonu.'],
     'opts': None, 'ln': 4, 'svg': SVG8, 'fn': 'zahon.svg',
     'alt': 'Ctyruhelnikovy zahon s rostlinami (puntiky) rozmistenymi po obvodu v rozestupech 40 cm.',
     'cap': 'Schematicky nakres zahonu s rozestupy rostlin',
     'sol': ['8.1 Rostliny tvori uzavrenou linii, rozestupU je tedy $65$. Obvod $=65\\cdot 0{,}4=26$ m.',
             '8.2 Nejdelsi strana $L$ a tri strany $\\frac{3}{4}L$: $L+3\\cdot\\frac{3}{4}L=\\frac{13}{4}L=26$, tedy $L=8$ m a kratsi strany $6$ m. Rostlin na nejdelsi strane $8:0{,}4=20$, na protejsi kratsi strane $6:0{,}4=15$; rozdil $20-15=5$.',
             '8.3 Opakuje se skupinka $k$ cervenych a dvojice bilych, tj. $65=m\\cdot(k+2)$. Nejmene cervenych je pri nejvetsim $m$: $65=13\\cdot 5$, tj. $m=13$, $k=3$; cervenych $65-2\\cdot 13=39$.'],
     'ans': '8.1: $26$ m; 8.2: o $5$ rostlin; 8.3: $39$ cervene kvetoucich rostlin', 'pts': 4, 'mins': 8, 'diff': '4',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9A 2025 - uloha 9 (konstrukce)', 'zad': [
        'V rovine lezi ruznobezky $p$, $q$ a bod $R$ (viz obrazek).',
        '9.1 Sestrojte osu vetsiho uhlu, ktery sviraji primky $p$, $q$, a oznacte ji pismenem $o$.',
        '9.2 Na primkach $p$, $q$ lezi vsechny ctyri vrcholy obdelniku $KLMN$. Bod $R$ lezi uvnitr strany $MN$ tohoto obdelniku. Sestrojte vrcholy obdelniku $KLMN$, oznacte je pismeny a obdelnik narysujte.'],
     'opts': None, 'ln': 0, 'svg': SVG9, 'fn': 'primky-pqR.svg',
     'alt': 'Dve ruznobezne primky p a q a bod R lezici v rovine.',
     'cap': 'Vychozi obrazek k uloze 9',
     'sol': ['9.1 Osa $o$ vetsiho z uhlU sevrenych primkami $p$, $q$ prochazi jejich prusecikem a je osou soumernosti obou primek.',
             '9.2 Obdelnik $KLMN$ je soumerny podle osy $o$ a jeho vrcholy lezi na primkach $p$, $q$. Bodem $R$ vedeme kolmici k ose $o$; ta protne primky $p$, $q$ ve vrcholech $M$, $N$ (strana $MN$ prochazi bodem $R$). Vrcholy $K$, $L$ jsou obrazy $M$, $N$ v osove soumernosti podle $o$. Obdelnik $KLMN$ narysujeme.'],
     'ans': '9.1: osa $o$ vetsiho uhlu primek $p$, $q$; 9.2: obdelnik $KLMN$ soumerny podle osy $o$, strana $MN$ prochazi bodem $R$ (viz nakres v klici).',
     'pts': 3, 'mins': 8, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2025 - uloha 10 (konstrukce)', 'zad': [
        'V rovine lezi bod $B$ a primky $p$, $q$, ktere se protinaji v bode $C$ (viz obrazek). Body $B$, $C$ jsou vrcholy trojuhelniku $ABC$. Na primce $p$ lezi vyska $v_c$ na stranu $c$ a na primce $q$ lezi teznice $t_c$ na stranu $c$ tohoto trojuhelniku.',
        'Sestrojte vrchol $A$ trojuhelniku $ABC$, oznacte ho pismenem a trojuhelnik narysujte.'],
     'opts': None, 'ln': 0, 'svg': SVG10, 'fn': 'bodB-pq.svg',
     'alt': 'Bod B a dve primky p, q protinajici se v bode C.',
     'cap': 'Vychozi obrazek k uloze 10',
     'sol': ['Strana $c=AB$ je kolma k vysce $v_c$, tedy k primce $p$; primku $AB$ proto vedeme bodem $B$ kolmo k $p$. Prusecik primky $AB$ s primkou $q$ (na niz lezi teznice $t_c$) je stred $S$ strany $AB$. Vrchol $A$ je obraz bodu $B$ ve stredove soumernosti se stredem $S$ ($|SA|=|SB|$).'],
     'ans': 'Primka $AB$ prochazi bodem $B$ kolmo k $p$; jeji prusecik s $q$ je stred $S$ strany $AB$ a vrchol $A$ je obraz $B$ podle stredu $S$ (viz nakres v klici).',
     'pts': 2, 'mins': 7, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2025 - uloha 11', 'zad': [
        'Zakladni kvadr ma delky hran $1$ cm, $2$ cm a $3$ cm. Kazde z teles $M$, $N$, $P$, $Q$, $R$ bylo slepeno ze dvou zakladnich kvadrU; telesa $M$, $N$ jsou ctyrboke hranoly (viz testovy sesit).',
        'Rozhodnete o kazdem z nasledujicich tvrzeni (11.1-11.3), zda je pravdive (A), ci nikoli (N).',
        '11.1 Soucet delek vsech hran jednoho zakladniho kvadru je $24$ cm.',
        '11.2 Povrchy hranolU $M$ a $N$ se lisi o $6$ cm2.',
        '11.3 Vsechna tri telesa $P$, $Q$, $R$ maji stejny povrch.'],
     'opts': None, 'ln': 0, 'svg': SVG11, 'fn': 'telesa-kvadry.svg',
     'alt': 'Zakladni kvadr a telesa M, N, P, Q, R slepena ze dvou kvadrU (schematicka poznamka).',
     'cap': 'Prostorova telesa - viz testovy sesit',
     'sol': ['11.1 Kvadr ma soucet delek hran $4\\cdot(1+2+3)=24$ cm. Pravda (A).',
             '11.2 Hranoly slozene ze dvou kvadrU maji povrchy $32$ cm2 a $38$ cm2, lisi se o $6$ cm2. Pravda (A).',
             '11.3 Kazde z teles $P$, $Q$, $R$ vzniklo slepenim dvou kvadrU podel shodne steny; slepena plocha je stejna, proto maji stejny povrch. Pravda (A).'],
     'ans': '11.1: Ano; 11.2: Ano; 11.3: Ano', 'pts': 4, 'mins': 7, 'diff': '3',
     'codes': B + ['stereometrie', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2025 - uloha 12', 'zad': [
        'Bazen ma delku $40$ metrU a sirku $10$ metrU. Hloubka bazenu neni vsude stejna (viz obrazek). V cele zone pro neplavce je hloubka $1$ m. Zona pro plavce ma sikme dno a hloubka bazenu se v ni postupne zvetsi z $1$ m na $2$ m.',
        'Jaky je objem bazenu?'],
     'opts': ['A) $500$ m3', 'B) $550$ m3', 'C) $600$ m3', 'D) $650$ m3', 'E) jiny objem'], 'ln': 0,
     'svg': SVG12, 'fn': 'bazen.svg',
     'alt': 'Podelny rez bazenem: zona pro neplavce s hloubkou 1 m a zona pro plavce se sikmym dnem od 1 m do 2 m.',
     'cap': 'Schematicky rez bazenem',
     'sol': ['Podelny rez: zona pro neplavce (delka $20$ m, hloubka $1$ m) ma obsah $20$ m2; zona pro plavce (lichobeznik s hloubkami $1$ m a $2$ m na delce $20$ m) ma obsah $\\frac{1+2}{2}\\cdot 20=30$ m2. Celkem rez $50$ m2, objem $=50\\cdot 10=500$ m3.'],
     'ans': 'A) $500$ m3', 'pts': 2, 'mins': 5, 'diff': '3',
     'codes': B + ['stereometrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9A 2025 - uloha 13', 'zad': [
        'U Pelhrimova se letos poradaly detske tabory ve dvou terminech. Pocet nabizenych mist byl v obou terminech stejny. Seslo se celkem $375$ prihlasek. V prvnim terminu pocet prihlasek prekrocil pocet nabizenych mist o petinu, ve druhem terminu o $30\\,\\%$.',
        'Kolik prihlasek celkem muselo byt kvUli nedostatku mist odmitnuto?'],
     'opts': ['A) $65$ prihlasek', 'B) $75$ prihlasek', 'C) $80$ prihlasek', 'D) $85$ prihlasek', 'E) jiny pocet prihlasek'], 'ln': 0,
     'sol': ['Nabizenych mist v kazdem terminu je $m$. Prihlasek $1{,}2m+1{,}3m=2{,}5m=375$, tedy $m=150$. Odmitnuto $0{,}2m+0{,}3m=0{,}5m=0{,}5\\cdot 150=75$.'],
     'ans': 'B) $75$ prihlasek', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9A 2025 - uloha 14', 'zad': [
        'Test z matematiky psalo $20$ zakU. Nejhorsi znamka byla $3$. Pocet jednicek a dvojek byl stejny. Aritmeticky prumer znamek vsech zakU byl $1{,}8$. Znamky $4$ a $5$ nedostal nikdo.',
        'Kolik zakU dostalo z testu znamku $1$?'],
     'opts': ['A) $5$ zakU', 'B) $6$ zakU', 'C) $7$ zakU', 'D) $8$ zakU', 'E) $9$ zakU'], 'ln': 0,
     'svg': SVG14, 'fn': 'tabulka-znamky.svg',
     'alt': 'Tabulka: znamky 1 az 5 a pocet zakU; u znamky 1 je otaznik, u znamek 4 a 5 je 0.',
     'cap': 'Tabulka znamek',
     'sol': ['NechT jednicek i dvojek je $a$ a trojek $t$. Pak $2a+t=20$ a prumer $\\frac{1\\cdot a+2\\cdot a+3\\cdot t}{20}=1{,}8$, tj. $3a+3t=36$, tedy $a+t=12$. Odectenim $a=8$.'],
     'ans': 'D) $8$ zakU', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['statistika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9A 2025 - uloha 15', 'zad': [
        'Priradte ke kazde uloze (15.1-15.3) odpovidajici vysledek (A-F).',
        '15.1 Pri slavnostnim zahajeni souteze nastoupilo na hriste $10$ druzstev po $11$ hracich a vsichni organizatori souteze. Dohromady tak nastoupilo $200$ osob. Kolik procent osob nastoupenych na hristi tvorili organizatori?',
        '15.2 Souteze se ucastnilo $20$ triclennych druzstev. V kazdem z nich byl alespon jeden muz a alespon jedna zena. Druzstev s jednim muzem bylo ctyrikrat vice nez druzstev s jednou zenou. Kolik procent soutezicich tvorily zeny?',
        '15.3 Na atletickem preboru soutezil kazdy atlet prave v jedne ze tri disciplin. V hodu ostepem soutezilo $12$ atletU. SkokanU bylo o $40\\,\\%$ mene nez bezcU, ale o $50\\,\\%$ vice nez osteparU. Kolik procent vsech soutezicich atletU tvorili bezci?'],
     'opts': ['A) $40\\,\\%$', 'B) $45\\,\\%$', 'C) $50\\,\\%$', 'D) $55\\,\\%$', 'E) $60\\,\\%$', 'F) vice nez $60\\,\\%$'], 'ln': 0,
     'sol': ['15.1 HracU $10\\cdot 11=110$, organizatorU $200-110=90$; $\\frac{90}{200}=45\\,\\%$ -> B.',
             '15.2 Celkem $60$ soutezicich. Druzstev s jednou zenou (dva muzi) je $x$, s jednim muzem (dve zeny) $4x$; $5x=20$, $x=4$. Zen $2\\cdot 16+1\\cdot 4=36$; $\\frac{36}{60}=60\\,\\%$ -> E.',
             '15.3 OsteparU $12$, skokanU $1{,}5\\cdot 12=18$, bezcU $18:0{,}6=30$; celkem $60$, bezcU $\\frac{30}{60}=50\\,\\%$ -> C.'],
     'ans': '15.1: B ($45\\,\\%$); 15.2: E ($60\\,\\%$); 15.3: C ($50\\,\\%$)', 'pts': 6, 'mins': 9, 'diff': '4',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9A 2025 - uloha 16', 'zad': [
        'Vytvarime tmave a svetle obrazce tvaru ctverce. Kazdy obsahuje jeden bily ctverec obklopeny pasem z nekolika shodnych obdelnicku o rozmerech $2$ cm a $3$ cm. U tmavych obrazcU je pas z obdelnicku vzdy uzsi (obdelnicky prilehaji kratsi stranou), u svetlych sirsi (prilehaji delsi stranou). Obrazec popisujeme tremi cisly: pocet obdelnicku, delka strany bileho ctverce a delka strany celeho obrazce (v cm). Napr. tmave obrazce: $(4;1;5)$, $(8;4;8)$, $(12;7;11)$; svetly obrazec: $(8;1;7)$.',
        '16.1 Delka strany tmaveho obrazce je $20$ cm. Urcete pocet obdelnicku v obrazci.',
        '16.2 Delka strany tmaveho i svetleho obrazce je $23$ cm. Urcete, o kolik se lisi pocet obdelnicku v techto dvou obrazcich.',
        '16.3 Tmavy i svetly obrazec maji stejny pocet obdelnicku, ale delky stran bilych ctvercU se v techto obrazcich lisi o $10$ cm. Urcete pocet obdelnicku v tmavem obrazci.'],
     'opts': None, 'ln': 4, 'svg': SVG16, 'fn': 'obrazce-pas.svg',
     'alt': 'Bily ctverec obklopeny pasem obdelnicku: tmavy obrazec s uzsim pasem a svetly obrazec s sirsim pasem (schematicky).',
     'cap': 'Schematicky nakres tmaveho a svetleho obrazce',
     'sol': ['U tmaveho obrazce je strana $s=w+4$ (pas siroky $2$ cm) a pocet obdelnicku $n=\\frac{s^2-w^2}{6}=\\frac{(w+4)^2-w^2}{6}=\\frac{8w+16}{6}$. U svetleho je $s=w+6$ (pas siroky $3$ cm) a $n=\\frac{(w+6)^2-w^2}{6}=2w+6$.',
             '16.1 Tmavy: $w=20-4=16$, $n=\\frac{8\\cdot 16+16}{6}=\\frac{144}{6}=24$.',
             '16.2 Tmavy: $w=19$, $n=\\frac{8\\cdot 19+16}{6}=28$; svetly: $w=17$, $n=2\\cdot 17+6=40$; rozdil $40-28=12$.',
             '16.3 Z $n=\\frac{8w_t+16}{6}$ plyne $w_t=\\frac{3n-8}{4}$, ze svetleho $w_s=\\frac{n-6}{2}$; rozdil $w_t-w_s=\\frac{n+4}{4}=10$, tedy $n=36$.'],
     'ans': '16.1: $24$ obdelnicku; 16.2: o $12$ obdelnicku; 16.3: $36$ obdelnicku', 'pts': 4, 'mins': 8, 'diff': '4',
     'codes': B + ['planimetrie', 'modelovani', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M9PAD25C0T01'
    gen.YEAR = 2025

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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M9-2025A')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} uloh [{"OK" if sz<9000 else "PRES 9KB"}]')
    print('Celkem uloh:', tot)
