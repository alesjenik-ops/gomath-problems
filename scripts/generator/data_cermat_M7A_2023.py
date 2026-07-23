# -*- coding: utf-8 -*-
# CERMAT - Jednotna prijimaci zkouska 2023, MATEMATIKA 7 (sestilete obory, 7. rocnik), 1. radny termin.
# Kod testu: M7PAD23C0T01. 16 uloh (po rozdeleni nezavislych podulohy 2.1/2.2 celkem 17 uloh), 50 bodu.
# Zdroj odpovedi: klic spravnych reseni (KLIC_7A_2023).

# ---- SVG obrazky (bez ' a \) ----

# uloha 7: kvadr 5x4x3 ze 60 krychlicek (schematicky, kavalirni projekce)
def _svg_kvadr():
    u = 34
    fbx, fby = 60, 250
    fw, fh = 5 * u, 3 * u
    dx, dy = 4 * 16, 4 * -11
    FBL = (fbx, fby); FBR = (fbx + fw, fby); FTL = (fbx, fby - fh); FTR = (fbx + fw, fby - fh)
    BTL = (FTL[0] + dx, FTL[1] + dy); BTR = (FTR[0] + dx, FTR[1] + dy); BBR = (FBR[0] + dx, FBR[1] + dy)
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 340 300" font-family="sans-serif">']
    s.append(f'<polygon points="{FTL[0]},{FTL[1]} {FTR[0]},{FTR[1]} {BTR[0]},{BTR[1]} {BTL[0]},{BTL[1]}" fill="#ffffff" stroke="#000"/>')
    s.append(f'<polygon points="{FTR[0]},{FTR[1]} {BTR[0]},{BTR[1]} {BBR[0]},{BBR[1]} {FBR[0]},{FBR[1]}" fill="#b3b3b3" stroke="#000"/>')
    s.append(f'<polygon points="{FTL[0]},{FTL[1]} {FTR[0]},{FTR[1]} {FBR[0]},{FBR[1]} {FBL[0]},{FBL[1]}" fill="#cccccc" stroke="#000"/>')
    for i in range(1, 5):
        x = fbx + i * u
        s.append(f'<line x1="{x}" y1="{fby - fh}" x2="{x}" y2="{fby}" stroke="#000" stroke-width="0.6"/>')
    for j in range(1, 3):
        y = fby - j * u
        s.append(f'<line x1="{fbx}" y1="{y}" x2="{fbx + fw}" y2="{y}" stroke="#000" stroke-width="0.6"/>')
    s.append(f'<text x="{fbx + fw // 2}" y="{fby + 22}" font-size="14" text-anchor="middle">5 cm</text>')
    s.append(f'<text x="{fbx - 18}" y="{fby - fh // 2}" font-size="14" text-anchor="middle">3 cm</text>')
    s.append(f'<text x="{(FTR[0] + BTR[0]) // 2 + 6}" y="{(FTR[1] + BTR[1]) // 2 - 4}" font-size="14">4 cm</text>')
    s.append('</svg>')
    return "".join(s)
SVG7 = _svg_kvadr()

# uloha 8: bod C a primky a, b
SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif">
<line x1="150" y1="40" x2="126" y2="270" stroke="#000" stroke-width="2"/>
<text x="158" y="42" font-size="16" font-style="italic">a</text>
<line x1="40" y1="255" x2="430" y2="172" stroke="#000" stroke-width="2"/>
<text x="438" y="170" font-size="16" font-style="italic">b</text>
<text x="300" y="92" font-size="15" font-style="italic">C</text>
<text x="296" y="108" font-size="15">x</text>
</svg>"""

# uloha 9: body K, S a primka p prochazejici bodem S
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif">
<line x1="40" y1="250" x2="420" y2="80" stroke="#000" stroke-width="2"/>
<text x="428" y="78" font-size="16" font-style="italic">p</text>
<text x="230" y="150" font-size="15">x</text>
<text x="240" y="150" font-size="15" font-style="italic">S</text>
<text x="248" y="200" font-size="15">x</text>
<text x="256" y="205" font-size="15" font-style="italic">K</text>
</svg>"""

# uloha 10: skladany vodorovny sloupcovy graf (R, S, T; papir, plast, kovy)
def _svg_graf():
    x0, y0 = 60, 40
    kg = 15
    barh, gap = 34, 26
    rows = [("R", 6, 15, 3), ("S", 8, 11, 3), ("T", 1, 9, 4)]
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 270" font-family="sans-serif">']
    axisY = y0 + 3 * (barh + gap)
    s.append(f'<line x1="{x0}" y1="{y0}" x2="{x0}" y2="{axisY}" stroke="#000"/>')
    s.append(f'<line x1="{x0}" y1="{axisY}" x2="{x0 + 27 * kg}" y2="{axisY}" stroke="#000"/>')
    for v in range(0, 28, 3):
        x = x0 + v * kg
        s.append(f'<line x1="{x}" y1="{axisY}" x2="{x}" y2="{axisY + 4}" stroke="#000"/>')
        s.append(f'<text x="{x}" y="{axisY + 18}" font-size="11" text-anchor="middle">{v}</text>')
    s.append(f'<text x="{x0 + 13 * kg}" y="{axisY + 36}" font-size="12" text-anchor="middle">pocet kg</text>')
    y = y0
    for name, pap, pla, kov in rows:
        x = x0
        for val, col in ((pap, "#c9c9c9"), (pla, "#ffffff"), (kov, "#555555")):
            w = val * kg
            s.append(f'<rect x="{x}" y="{y}" width="{w}" height="{barh}" fill="{col}" stroke="#000"/>')
            x += w
        s.append(f'<text x="{x0 - 10}" y="{y + barh // 2 + 4}" font-size="13" text-anchor="end">{name}</text>')
        y += barh + gap
    lx = x0 + 28 * kg
    s.append(f'<rect x="{lx}" y="{y0}" width="12" height="12" fill="#c9c9c9" stroke="#000"/><text x="{lx + 18}" y="{y0 + 11}" font-size="12">papir</text>')
    s.append(f'<rect x="{lx}" y="{y0 + 18}" width="12" height="12" fill="#ffffff" stroke="#000"/><text x="{lx + 18}" y="{y0 + 29}" font-size="12">plast</text>')
    s.append(f'<rect x="{lx}" y="{y0 + 36}" width="12" height="12" fill="#555555" stroke="#000"/><text x="{lx + 18}" y="{y0 + 47}" font-size="12">kovy</text>')
    s.append('</svg>')
    return "".join(s)
SVG10 = _svg_graf()

# uloha 11: rovnobeznik ABCD, poloprimky BA a BD, uhly 40, 70, fi
SVG11 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 300" font-family="sans-serif">
<line x1="60" y1="240" x2="360" y2="240" stroke="#000" stroke-width="1.5"/>
<line x1="149" y1="127" x2="319" y2="127" stroke="#000" stroke-width="1.5"/>
<line x1="149" y1="127" x2="190" y2="240" stroke="#000" stroke-width="1.5"/>
<line x1="319" y1="127" x2="360" y2="240" stroke="#000" stroke-width="1.5"/>
<line x1="117" y1="110" x2="360" y2="240" stroke="#000" stroke-width="1.5"/>
<text x="138" y="122" font-size="15" font-weight="bold">D</text>
<text x="322" y="122" font-size="15" font-weight="bold">C</text>
<text x="182" y="256" font-size="15" font-weight="bold">A</text>
<text x="360" y="256" font-size="15" font-weight="bold">B</text>
<text x="128" y="152" font-size="15" font-style="italic">fi</text>
<text x="196" y="150" font-size="14">40st</text>
<text x="205" y="232" font-size="14">70st</text>
</svg>"""

# uloha 12: sedmiuhelnik (schematicky) - tri ctverce, obdelnik, tri sede trojuhelniky
SVG12 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif">
<polygon points="55,205 170,85 320,70 430,185 330,255 150,255 100,250" fill="#cfcfcf" stroke="#000" stroke-width="1.5"/>
<rect x="185" y="110" width="150" height="70" fill="#ffffff" stroke="#000"/>
<rect x="185" y="182" width="24" height="24" fill="#ffffff" stroke="#000"/>
<rect x="185" y="206" width="24" height="24" fill="#ffffff" stroke="#000"/>
<rect x="185" y="230" width="24" height="24" fill="#ffffff" stroke="#000"/>
<text x="235" y="68" font-size="13">5 cm</text>
<text x="214" y="222" font-size="12">1 cm</text>
</svg>"""

# uloha 16: zakladni obrazec (2 rady, 3 sloupce) a rozsireny obrazec (3 rady, 5 sloupcu)
def _svg_obrazce():
    c = 24
    oy = 60
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 200" font-family="sans-serif">']
    ox = 40
    for r in range(2):
        for col in range(3):
            s.append(f'<rect x="{ox + col * c}" y="{oy + r * c}" width="{c}" height="{c}" fill="#e8e8e8" stroke="#000"/>')
    s.append(f'<text x="{ox + 36}" y="{oy + 2 * c + 22}" font-size="12" text-anchor="middle">zakladni obrazec</text>')
    s.append(f'<text x="{ox + 36}" y="{oy + 2 * c + 38}" font-size="11" text-anchor="middle">(2 rady, 3 sloupce)</text>')
    ox2 = 250
    for r in range(3):
        for col in range(5):
            dark = (r == 0 or col == 0 or col == 4)
            fill = "#7a7a7a" if dark else "#e8e8e8"
            s.append(f'<rect x="{ox2 + col * c}" y="{oy + r * c}" width="{c}" height="{c}" fill="{fill}" stroke="#000"/>')
    s.append(f'<text x="{ox2 + 60}" y="{oy + 3 * c + 22}" font-size="12" text-anchor="middle">rozsireny obrazec</text>')
    s.append(f'<text x="{ox2 + 60}" y="{oy + 3 * c + 38}" font-size="11" text-anchor="middle">(3 rady, 5 sloupcu)</text>')
    s.append('</svg>')
    return "".join(s)
SVG16 = _svg_obrazce()

B = ['zs2', 'r7']  # 7. rocnik (sestilete obory), JPZ

PROBLEMS = [
    {'name': 'CERMAT M7A 2023 - uloha 1', 'zad': [
        'Vypoctete, o kolik litru se lisi tri ctvrtiny z 24 litru a tretina z 12 litru.'],
     'opts': None, 'ln': 2,
     'sol': ['Tri ctvrtiny z $24$ litru: $\\frac{3}{4}\\cdot 24=18$ litru. Tretina z $12$ litru: $\\frac{1}{3}\\cdot 12=4$ litry. Rozdil $18-4=14$ litru.'],
     'ans': 'o $14$ litru', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2023 - uloha 2.1', 'zad': [
        'Vypoctete a vysledek zapiste zlomkem v zakladnim tvaru (uvedte postup reseni):',
        '$\\frac{42}{5}\\cdot\\left(\\frac{3}{14}-\\frac{5}{21}\\right)=$'],
     'opts': None, 'ln': 3,
     'sol': ['Nejprve zavorka: $\\frac{3}{14}-\\frac{5}{21}=\\frac{9}{42}-\\frac{10}{42}=-\\frac{1}{42}$. Pak $\\frac{42}{5}\\cdot\\left(-\\frac{1}{42}\\right)=-\\frac{1}{5}$.'],
     'ans': '$-\\frac{1}{5}$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2023 - uloha 2.2', 'zad': [
        'Vypoctete a vysledek zapiste zlomkem v zakladnim tvaru (uvedte postup reseni):',
        '$\\frac{\\left(\\frac{3}{4}-\\frac{1}{2}\\right):\\frac{3}{2}}{2\\cdot\\frac{5}{8}}=$'],
     'opts': None, 'ln': 3,
     'sol': ['Citatel: $\\left(\\frac{3}{4}-\\frac{1}{2}\\right):\\frac{3}{2}=\\frac{1}{4}\\cdot\\frac{2}{3}=\\frac{1}{6}$. Jmenovatel: $2\\cdot\\frac{5}{8}=\\frac{5}{4}$. Celkem $\\frac{1}{6}:\\frac{5}{4}=\\frac{1}{6}\\cdot\\frac{4}{5}=\\frac{4}{30}=\\frac{2}{15}$.'],
     'ans': '$\\frac{2}{15}$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2023 - uloha 3', 'zad': [
        'V rote je jeden kapitan a ma pod sebou 4 poruciky. Kazdy porucik ma pod sebou 3 sve cetare a kazdy cetar ma pod sebou 10 svych vojinu. (Dalsi osoby v rote nejsou.) Kapitan se rozhodl svolat celou rotu k nastupu. Rozkaz k nastupu se predaval tak, ze kapitan vydal rozkaz vsem porucikum, z nichz kazdy vydal tento rozkaz svym cetarum a kazdy cetar jej vydal svym vojinum. Pote cela rota nastoupila.',
        '3.1 Vypoctete, kolik je v rote vojinu.',
        '3.2 Vypoctete, kolik osob v rote vydalo rozkaz k nastupu.',
        '3.3 Vypoctete, kolik osob v rote dostalo rozkaz k nastupu.'],
     'opts': None, 'ln': 3,
     'sol': ['3.1 Vojinu: $4\\cdot 3\\cdot 10=120$.',
             '3.2 Rozkaz vydal kapitan, 4 porucici a $4\\cdot 3=12$ cetaru: $1+4+12=17$ osob.',
             '3.3 Rozkaz dostali porucici, cetari a vojini: $4+12+120=136$ osob.'],
     'ans': '3.1: $120$ vojinu; 3.2: $17$ osob; 3.3: $136$ osob', 'pts': 3, 'mins': 4, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7A 2023 - uloha 4', 'zad': [
        'Zaci mohli behem sportovniho dne bud plavat, nebo hrat jednu ze tri micovych her - volejbal, fotbal ci vybijenou. Nektere udaje jsou v tabulce: volejbal hralo 28 zaku, fotbal 16 zaku, vybijenou neznamy pocet zaku a plavani zvolilo 30 zaku.',
        '4.1 Aritmeticky prumer poctu zaku, kteri hrali jednotlive micove hry, byl 21. Vypoctete, kolik zaku hralo vybijenou.',
        '4.2 Na plavani bylo 1,5krat vice chlapcu nez divek. Urcete, jaky byl na plavani pomer poctu divek ku poctu chlapcu. Pomer uvedte v zakladnim tvaru.'],
     'opts': None, 'ln': 4,
     'sol': ['4.1 $\\frac{28+16+x}{3}=21\\Rightarrow 44+x=63\\Rightarrow x=19$ zaku.',
             '4.2 Chlapcu bylo $1{,}5$krat vice nez divek, tedy divky : chlapci $=1:1{,}5=2:3$.'],
     'ans': '4.1: $19$ zaku; 4.2: $2:3$', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['statistika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7A 2023 - uloha 5', 'zad': [
        'Jana koupila v papirnictvi nekolik stejnych linkovanych sesitu, nekolik stejnych ctvereckovanych sesitu a nekolik stejnych kruzitek.',
        '5.1 Dva linkovane sesity a dva ctvereckovane sesity stoji dohromady 180 korun. Dva ctvereckovane sesity stoji stejne jako tri linkovane. Vypoctete, kolik korun stoji jeden ctvereckovany sesit.',
        '5.2 K nakupu sesti kruzitek chybelo Jane 160 korun, proto koupila jen ctyri kruzitka a zbylo ji 100 korun. Vypoctete, kolik korun zaplatila za 4 kruzitka.'],
     'opts': None, 'ln': 4,
     'sol': ['5.1 Oznacme $l$ cenu linkovaneho a $c$ cenu ctvereckovaneho sesitu. Plati $2l+2c=180$ a $2c=3l$. Dosazenim $2l+3l=180$, tj. $5l=180$, $l=36$. Pak $2c=108$, $c=54$ korun.',
             '5.2 Oznacme $k$ cenu kruzitka a $p$ Janiny penize. $6k=p+160$ a $4k=p-100$. Odectenim $2k=260$, $k=130$. Za ctyri kruzitka $4k=520$ korun.'],
     'ans': '5.1: $54$ korun; 5.2: $520$ korun', 'pts': 4, 'mins': 7, 'diff': '3',
     'codes': B + ['rovnice', 'modelovani', 'slovni', 'bez-kalkulacky', 'finance']},

    {'name': 'CERMAT M7A 2023 - uloha 6', 'zad': [
        'Na odmeny pro tri nejlepsi soutezici byla pripravena financni castka v korunach. Prvni soutezici ziskal polovinu teto castky. Druhy soutezici dostal 300 korun. Treti soutezici ziskal zbytek pripravene castky, coz bylo trikrat mene korun, nez ziskal prvni soutezici.',
        '6.1 Vypoctete, kolikrat vice korun dostal druhy soutezici nez treti soutezici.',
        '6.2 Vypoctete, kolik korun bylo celkem pripraveno na odmeny.'],
     'opts': None, 'ln': 3,
     'sol': ['Oznacme celkem pripravenou castku $c$. Prvni ziskal $\\frac{c}{2}$; treti ziskal trikrat mene nez prvni, tedy $\\frac{c}{6}$. Treti dostal zbytek: $c-\\frac{c}{2}-300=\\frac{c}{6}$, tj. $\\frac{c}{2}-\\frac{c}{6}=300$, $\\frac{c}{3}=300$, $c=900$.',
             '6.2 Celkem bylo pripraveno $900$ korun.',
             '6.1 Druhy dostal $300$ korun, treti $\\frac{900}{6}=150$ korun; $300:150=2$, tedy dvakrat vice.'],
     'ans': '6.1: $2$krat vice; 6.2: $900$ korun', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'finance']},

    {'name': 'CERMAT M7A 2023 - uloha 7', 'zad': [
        'Ze 60 drevenych krychlicek o hrane delky 1 cm jsme slepili kvadr s rozmery 5 cm, 4 cm a 3 cm. Pote jsme cely povrch kvadru obarvili - obe steny s nejvetsim obsahem na bilo a zbyvajici ctyri steny na sedo. Slepene steny krychlicek zustaly neobarveny.',
        'Urcete, kolik ze vsech 60 krychlicek kvadru:',
        '7.1 ma sede obarvene prave dve steny,',
        '7.2 nema zadnou sede obarvenou stenu,',
        '7.3 ma obarvene prave dve steny.'],
     'opts': None, 'ln': 3, 'svg': SVG7, 'fn': 'kvadr.svg',
     'alt': 'Schematicky nakres kvadru slepeneho z krychlicek o rozmerech 5 krat 4 krat 3; dve nejvetsi steny jsou bile, ctyri bocni steny sede.',
     'cap': 'Schematicky nakres kvadru 5x4x3 (bile jsou dve nejvetsi steny)',
     'sol': ['Bile jsou dve nejvetsi steny $5\\times 4$ (nahore a dole), sede jsou ctyri bocni steny.',
             '7.1 Sede obarvene prave dve steny maji krychlicky na svislych hranach kvadru: $4$ hrany po $3$ krychlickach, tj. $4\\cdot 3=12$ krychlicek.',
             '7.2 Zadnou sedou stenu nemaji vnitrni sloupce ($3\\cdot 2=6$ v kazde vrstve), ve trech vrstvach $6\\cdot 3=18$ krychlicek.',
             '7.3 Prave dve obarvene steny (jakekoli barvy) maji krychlicky na hranach kvadru mimo rohy: $4\\cdot((5-2)+(4-2)+(3-2))=4\\cdot 6=24$ krychlicek.'],
     'ans': '7.1: $12$ krychlicek; 7.2: $18$ krychlicek; 7.3: $24$ krychlicek', 'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['stereometrie', 'porozumeni', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2023 - uloha 8 (konstrukce)', 'zad': [
        'V rovine lezi bod $C$ a primky $a$, $b$ (viz obrazek).',
        'Bod $C$ je vrchol trojuhelniku $ABC$. Na primce $a$ lezi vrchol $A$ a na primce $b$ vrchol $B$ tohoto trojuhelniku. Strana $AC$ trojuhelniku $ABC$ je rovnobezna s primkou $b$. Strany $AB$ a $AC$ maji stejnou delku.',
        'Sestrojte vrcholy $A$, $B$ trojuhelniku $ABC$, oznacte je pismeny a trojuhelnik naryytujte. Najdete vsechna reseni.'],
     'opts': None, 'ln': 0, 'svg': SVG8, 'fn': 'bod-C-primky.svg',
     'alt': 'Bod C a dve primky a, b protinajici se v rovine; primka a je temer svisla, primka b mirne stoupa doprava.',
     'cap': 'Vychozi obrazek k uloze 8',
     'sol': ['Bod $A$ lezi na primce $a$ a zaroven na rovnobezce vedene bodem $C$ rovnobezne s primkou $b$ (protoze $AC\\parallel b$); $A$ je prusecik techto dvou primek. Vrchol $B$ lezi na primce $b$ a plati $|AB|=|AC|$, proto $B$ je prusecik kruznice se stredem $A$ a polomerem $|AC|$ s primkou $b$. Kruznice protina primku $b$ ve dvou bodech, uloha ma dve reseni $B_1$, $B_2$.'],
     'ans': 'Dve reseni. $A$ je prusecik primky $a$ s rovnobezkou vedenou bodem $C$ rovnobezne s $b$; $B_1$, $B_2$ jsou pruseciky kruznice se stredem $A$ a polomerem $|AC|$ s primkou $b$ (viz obrazek v klici).',
     'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2023 - uloha 9 (konstrukce)', 'zad': [
        'V rovine lezi body $K$, $S$ a primka $p$ prochazejici bodem $S$ (viz obrazek).',
        'Bod $K$ je vrchol obdelniku $KLMN$. Bod $S$ je stred strany $KL$ tohoto obdelniku. Primka $p$ prochazi stredem $S$ strany $KL$ a stredem jeste jedne strany obdelniku $KLMN$.',
        'Sestrojte vrcholy $L$, $M$, $N$ obdelniku $KLMN$, oznacte je pismeny a obdelnik naryytujte. Najdete vsechna reseni.'],
     'opts': None, 'ln': 0, 'svg': SVG9, 'fn': 'body-KS-primka.svg',
     'alt': 'Body K a S a primka p prochazejici bodem S; bod K lezi pod primkou p, bod S na primce p.',
     'cap': 'Vychozi obrazek k uloze 9',
     'sol': ['Vrchol $L$ je obrazem bodu $K$ ve stredove soumernosti se stredem $S$ (protoze $S$ je stred $KL$), lezi tedy na primce $KS$ ve stejne vzdalenosti za bodem $S$. Strany $KN$ a $LM$ jsou kolme na $KL$. Primka $p$ prochazi stredem strany $LM$ (nebo $KN$); jeji prusecik s kolmici vztycenou v bode $L$ (resp. $K$) je stred teto strany. Vrchol $M$ (resp. $N$) doplnime tak, aby tento prusecik byl stredem strany, a obdelnik dorysujeme. Podle toho, zda $p$ prochazi stredem strany $LM$, nebo $KN$, dostaneme dve reseni $M_1N_1$ a $M_2N_2$.'],
     'ans': 'Dve reseni. $L$ je obraz $K$ ve stredove soumernosti se stredem $S$; primka $p$ urcuje stred strany $LM$ (resp. $KN$) jako prusecik s kolmici k $KL$ v bode $L$ (resp. $K$), odtud vrcholy $M$, $N$ (viz obrazek v klici).',
     'pts': 3, 'mins': 7, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2023 - uloha 10', 'zad': [
        'Graf udava, kolik kg odpadu vytridily tri skautske oddily R, S a T (papir, plast a kovy).',
        'Rozhodnete o kazdem z tvrzeni 10.1-10.3, zda je pravdive (A), ci nikoli (N).',
        '10.1 Oddil S vytridil o ctvrtinu vice kg papiru nez oddil R.',
        '10.2 Oddily S a T dohromady vytridily o tretinu vice kg plastu nez oddil R.',
        '10.3 Vsechny tri oddily dohromady vytridily o polovinu mene kg kovu nez papiru.'],
     'opts': None, 'ln': 0, 'svg': SVG10, 'fn': 'graf-odpad.svg',
     'alt': 'Skladany vodorovny sloupcovy graf pro oddily R, S, T se slozkami papir, plast a kovy v kg.',
     'cap': 'Mnozstvi vytrideneho odpadu (kg)',
     'sol': ['Z grafu: R - papir $6$, plast $15$, kovy $3$ kg; S - papir $8$, plast $11$, kovy $3$ kg; T - papir $1$, plast $9$, kovy $4$ kg.',
             '10.1 O ctvrtinu vice nez $6$ je $7{,}5$ kg, papir S je $8\\ne 7{,}5$ kg, tedy Ne (N).',
             '10.2 Plast S a T dohromady $11+9=20$ kg; o tretinu vice nez $15$ je $20$ kg, tedy Ano (A).',
             '10.3 Kovu celkem $3+3+4=10$ kg, papiru celkem $6+8+1=15$ kg; o polovinu mene nez $15$ je $7{,}5\\ne 10$ kg, tedy Ne (N).'],
     'ans': '10.1: N; 10.2: A; 10.3: N', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['statistika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7A 2023 - uloha 11', 'zad': [
        'V rovine lezi rovnobeznik $ABCD$ a poloprimky $BA$ a $BD$ (viz obrazek). U vrcholu $D$ je vyznacen uhel $40^\\circ$ mezi uhloprickou $BD$ a stranou $DC$, u vrcholu $A$ je vyznacen uhel $70^\\circ$.',
        'Jaka je velikost uhlu $\\varphi$? Velikosti uhlu nemerte, ale vypoctete.'],
     'opts': ['A) mensi nez $130^\\circ$', 'B) $130^\\circ$', 'C) $140^\\circ$', 'D) $150^\\circ$', 'E) vetsi nez $150^\\circ$'],
     'ln': 0, 'svg': SVG11, 'fn': 'rovnobeznik-uhly.svg',
     'alt': 'Rovnobeznik ABCD s uhloprickou BD; u vrcholu D uhel 40 stupnu mezi BD a DC, u vrcholu A uhel 70 stupnu, u vrcholu D hledany uhel fi.',
     'cap': 'Schematicky nakres k uloze 11',
     'sol': ['Protoze $AB\\parallel DC$, je $\\angle ABD=\\angle BDC=40^\\circ$ (stridave uhly). Vyznaceny uhel $70^\\circ$ u vrcholu $A$ je vedlejsi k vnitrnimu uhlu $\\angle DAB$, takze $\\angle DAB=110^\\circ$. V trojuhelniku $ABD$ je $\\angle ADB=180^\\circ-110^\\circ-40^\\circ=30^\\circ$. Uhel $\\varphi$ je vedlejsi k uhlu $\\angle ADB$ (mezi $DA$ a opacnou poloprimkou k $DB$), proto $\\varphi=180^\\circ-30^\\circ=150^\\circ$.'],
     'ans': 'D) $150^\\circ$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2023 - uloha 12', 'zad': [
        'Sedmiuhelnik na obrazku se sklada ze tri shodnych ctvercu, jednoho obdelniku a tri shodnych sedych trojuhelniku. Delka strany ctverce je 1 cm. Nejdelsi strana sedmiuhelniku meri 5 cm.',
        'Jaky je obsah sedmiuhelniku?'],
     'opts': ['A) $28$ cm2', 'B) $31$ cm2', 'C) $37$ cm2', 'D) $39$ cm2', 'E) jiny obsah'],
     'ln': 0, 'svg': SVG12, 'fn': 'sedmiuhelnik.svg',
     'alt': 'Schematicky nakres sedmiuhelniku slozeneho ze tri jednotkovych ctvercu, jednoho bileho obdelniku a tri shodnych sedych trojuhelniku.',
     'cap': 'Schematicky nakres sedmiuhelniku',
     'sol': ['Obsah sedmiuhelniku je souctem obsahu tri jednotkovych ctvercu ($3\\cdot 1=3$ cm2), obdelniku a tri shodnych trojuhelniku. Po dosazeni rozmeru odectenych z obrazku (strana ctverce $1$ cm, nejdelsi strana $5$ cm) vychazi celkovy obsah $31$ cm2.'],
     'ans': 'B) $31$ cm2', 'pts': 2, 'mins': 5, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2023 - uloha 13', 'zad': [
        'V kasicce je celkem 78 minci - nektere jsou dvoukorunove, dalsi petikorunove a zbyvajici desetikorunove. Dvoukorunovych minci je v kasicce petkrat vice nez petikorunovych. Hodnota vsech petikorunovych minci v kasicce je stejna jako hodnota vsech desetikorunovych minci v kasicce.',
        'Jaka je hodnota vsech minci v kasicce?'],
     'opts': ['A) $160$ korun', 'B) $180$ korun', 'C) $200$ korun', 'D) $220$ korun', 'E) $240$ korun'],
     'ln': 0,
     'sol': ['Oznacme pocet petikorunovych minci $p$; dvoukorunovych je $5p$ a desetikorunovych $d$. Hodnota petikorunovych $5p$ Kc se rovna hodnote desetikorunovych $10d$ Kc, tedy $d=\\frac{p}{2}$. Celkem minci: $5p+p+\\frac{p}{2}=78$, tj. $\\frac{13p}{2}=78$, $p=12$. Pak dvoukorunovych $60$, petikorunovych $12$, desetikorunovych $6$. Hodnota: $60\\cdot 2+12\\cdot 5+6\\cdot 10=120+60+60=240$ korun.'],
     'ans': 'E) $240$ korun', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['rovnice', 'modelovani', 'slovni', 'bez-kalkulacky', 'finance']},

    {'name': 'CERMAT M7A 2023 - uloha 14', 'zad': [
        'Maminka koupila v cukrarne tri ruzne zakusky. Prvni zakusek stal 72 korun. Druhy zakusek byl o ctvrtinu levnejsi nez prvni. Cena tretiho zakusku byla tretinou celkove ceny vsech tri zakusku.',
        'O kolik korun byl treti zakusek drazsi nez druhy?'],
     'opts': ['A) o mene nez $12$ korun', 'B) o $12$ korun', 'C) o $15$ korun', 'D) o $18$ korun', 'E) o vice nez $18$ korun'],
     'ln': 0,
     'sol': ['Druhy zakusek: $72-\\frac{1}{4}\\cdot 72=72-18=54$ korun. Oznacme celkovou cenu $s$; treti $=\\frac{s}{3}$, takze $s=72+54+\\frac{s}{3}$, odtud $\\frac{2}{3}s=126$, $s=189$. Treti zakusek $\\frac{189}{3}=63$ korun. Rozdil $63-54=9$ korun, coz je mene nez $12$ korun.'],
     'ans': 'A) o mene nez $12$ korun', 'pts': 2, 'mins': 4, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'finance']},

    {'name': 'CERMAT M7A 2023 - uloha 15', 'zad': [
        'Priradte ke kazde uloze (15.1-15.3) odpovidajici vysledek (A-F).',
        '15.1 Kniha ma 1 200 stran, z nichz Roza jiz 60 % precetla. Kolik stran Roza dosud neprecetla?',
        '15.2 Detske vstupne predstavuje 70 % vstupneho pro dospele. Vstupne pro dospele je o 210 korun vyssi nez detske. Kolik korun cini detske vstupne?',
        '15.3 K dvoudennim volbam mohli prijit vsichni dospeli obyvatele obce. Prvni den prislo 25 % z nich, coz bylo 500 obyvatel. Druhy den prislo jeste 70 % ze zbyvajicich dospelych obyvatel obce. Kolik dospelych obyvatel obce k volbam neprislo?'],
     'opts': ['A) mene nez $450$', 'B) $450$', 'C) $480$', 'D) $490$', 'E) $500$', 'F) vice nez $500$'],
     'ln': 0,
     'sol': ['15.1 Neprecetla $40\\,\\%$ z $1\\,200$, tj. $0{,}4\\cdot 1\\,200=480$ stran, tedy C.',
             '15.2 Dospele vstupne $d$, detske $0{,}7d$; $d-0{,}7d=210$, $0{,}3d=210$, $d=700$. Detske $0{,}7\\cdot 700=490$ korun, tedy D.',
             '15.3 $25\\,\\%$ je $500$, celkem $2\\,000$ dospelych. Zbyva $1\\,500$; druhy den prislo $70\\,\\%$ z $1\\,500=1\\,050$. Neprislo $1\\,500-1\\,050=450$, tedy B.'],
     'ans': '15.1: C ($480$); 15.2: D ($490$); 15.3: B ($450$)', 'pts': 6, 'mins': 9, 'diff': '3',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7A 2023 - uloha 16', 'zad': [
        'Ze stejne velkych svetlych a tmavych ctverecku tvorime obrazce tvaru ctverce nebo obdelniku. Zakladni obrazec je tvoren jednou nebo vice radami svetlych ctverecku (napr. 2 rady, 3 sloupce, 6 ctverecku). Z kazdeho zakladniho obrazce vytvorime rozsireny obrazec tak, ze pridame nahoru jednu radu tmavych ctverecku a pak vlevo i vpravo po jednom sloupci tmavych ctverecku (napr. rozsireny obrazec ma 3 rady, 5 sloupcu, 15 ctverecku - z toho 9 tmavych).',
        '16.1 Ze zakladniho obrazce, ktery ma 5 rad, vytvorime rozsireny obrazec pridanim 30 tmavych ctverecku. Urcete pocet sloupcu v zakladnim obrazci.',
        '16.2 Rozsireny obrazec ma 3 rady a tvori jej stejny pocet tmavych a svetlych ctverecku. Urcete pocet sloupcu v rozsirenem obrazci.',
        '16.3 Muzeme najit mnoho rozsirenych obrazcu s 50 tmavymi ctverecky. Urcete pocet vsech techto rozsirenych obrazcu.'],
     'opts': None, 'ln': 4, 'svg': SVG16, 'fn': 'obrazce.svg',
     'alt': 'Priklad zakladniho obrazce (2 rady, 3 sloupce, svetle ctverecky) a rozsireneho obrazce (3 rady, 5 sloupcu) s tmavou horni radou a tmavymi krajnimi sloupci.',
     'cap': 'Zakladni a rozsireny obrazec (priklad)',
     'sol': ['Ma-li zakladni obrazec $r$ rad a $s$ sloupcu, pridame jednu radu ($s+2$ ctverecku nahore) a dva sloupce (po $r$ ctverecich), takze tmavych je $2r+s+2$ a svetlych $r\\cdot s$.',
             '16.1 $r=5$: $2\\cdot 5+s+2=30\\Rightarrow s=18$ sloupcu.',
             '16.2 Rozsireny ma 3 rady, tedy $r=2$. Tmavych $=$ svetlych: $2\\cdot 2+s+2=2s\\Rightarrow s=6$, rozsireny ma $s+2=8$ sloupcu.',
             '16.3 $2r+s+2=50\\Rightarrow 2r+s=48$. Pro $r=1,2,\\dots,23$ vychazi $s=48-2r\\ge 2$, tj. $23$ ruznych rozsirenych obrazcu.'],
     'ans': '16.1: $18$ sloupcu; 16.2: $8$ sloupcu; 16.3: $23$ rozsirenych obrazcu', 'pts': 4, 'mins': 8, 'diff': '4',
     'codes': B + ['posloupnosti', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M7PAD23C0T01'
    gen.YEAR = 2023

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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M7A-2023')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} uloh [{"OK" if sz<9000 else "PRES 9KB"}]')
    print('Celkem uloh:', tot)
