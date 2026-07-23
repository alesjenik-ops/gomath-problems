# -*- coding: utf-8 -*-
# CERMAT – Jednotná přijímací zkouška 2022, MATEMATIKA 5 C (osmileté obory, 5. ročník),
# 1. náhradní termín. Kód testu: M5PCD22C0T03. 14 úloh (po rozdělení izolovaných
# poduúloh 17 úloh). Zdroj odpovědí: klíč správných řešení (KSR), ověřeno záznamovým
# archem (VZA – potvrzuje rozdělení 1.1/1.2, 2.1/2.2, 3.1/3.2, ... a 1. náhradní termín 5C).

# ---- SVG obrázky (bez ' a \) ----

# úloha 7.1: body K, S a přímka q procházející bodem K
SVG7_1 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif">
<line x1="60" y1="150" x2="420" y2="240" stroke="#000" stroke-width="2"/>
<text x="66" y="146" font-size="16" font-style="italic">q</text>
<circle cx="150" cy="172" r="3" fill="#000"/>
<text x="142" y="192" font-size="15" font-style="italic">K</text>
<text x="330" y="150" font-size="15" text-anchor="middle">×</text>
<text x="340" y="150" font-size="15" font-style="italic">S</text>
</svg>"""

# úloha 7.2: body A, X a rovnoběžné přímky c, p
SVG7_2 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 320" font-family="sans-serif">
<line x1="60" y1="90" x2="400" y2="90" stroke="#000" stroke-width="2"/>
<text x="42" y="95" font-size="16" font-style="italic">c</text>
<line x1="60" y1="170" x2="400" y2="170" stroke="#000" stroke-width="2"/>
<text x="42" y="175" font-size="16" font-style="italic">p</text>
<text x="250" y="228" font-size="15" text-anchor="middle">×</text>
<text x="252" y="246" font-size="15" font-style="italic">X</text>
<text x="180" y="270" font-size="15" text-anchor="middle">×</text>
<text x="182" y="288" font-size="15" font-style="italic">A</text>
</svg>"""

# úloha 8: skupinový sloupcový graf (zakoupené/vzrostlé/prodané) pro druhy A–D
def _bars8():
    groups = [('A', 14, 12, 7), ('B', 9, 9, 9), ('C', 8, 8, 4), ('D', 11, 8, 8)]
    x0, y0 = 70, 280; u = 14.0; bw = 16; bgap = 3; ggap = 30
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 350" font-family="sans-serif">']
    s.append(f'<line x1="{x0}" y1="40" x2="{x0}" y2="{y0}" stroke="#000"/>')
    s.append(f'<line x1="{x0}" y1="{y0}" x2="520" y2="{y0}" stroke="#000"/>')
    for v in range(0, 17, 2):
        y = y0 - v * u
        s.append(f'<line x1="{x0-4}" y1="{y}" x2="{x0}" y2="{y}" stroke="#000"/><text x="{x0-8}" y="{y+4}" font-size="11" text-anchor="end">{v}</text>')
    s.append('<text x="26" y="150" font-size="12" text-anchor="middle" transform="rotate(-90 26 150)">počet kusů rostlin</text>')
    s.append('<defs><pattern id="hatch" width="6" height="6" patternUnits="userSpaceOnUse" patternTransform="rotate(45)"><rect width="6" height="6" fill="#ffffff"/><line x1="0" y1="0" x2="0" y2="6" stroke="#555" stroke-width="2"/></pattern></defs>')
    gx = x0 + ggap
    for name, za, vz, pr in groups:
        bx = gx
        for val, fill in ((za, '#ffffff'), (vz, '#8a8a8a'), (pr, 'url(#hatch)')):
            h = val * u
            s.append(f'<rect x="{bx}" y="{y0-h}" width="{bw}" height="{h}" fill="{fill}" stroke="#000"/>')
            bx += bw + bgap
        gw = 3 * bw + 2 * bgap
        s.append(f'<text x="{gx+gw/2}" y="{y0+16}" font-size="12" text-anchor="middle">{name}</text>')
        gx = bx + ggap
    ly = 320
    s.append(f'<rect x="150" y="{ly}" width="12" height="12" fill="#ffffff" stroke="#000"/><text x="168" y="{ly+11}" font-size="11">zakoupené</text>')
    s.append(f'<rect x="255" y="{ly}" width="12" height="12" fill="#8a8a8a" stroke="#000"/><text x="273" y="{ly+11}" font-size="11">vzrostlé</text>')
    s.append(f'<rect x="350" y="{ly}" width="12" height="12" fill="url(#hatch)" stroke="#000"/><text x="368" y="{ly+11}" font-size="11">prodané</text>')
    s.append('</svg>')
    return "".join(s)
SVG8 = _bars8()

# úloha 10: obdélník ze tří bílých čtverců, v každém tmavý čtverec (vrcholy ve středech stran)
SVG10 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 210 150" font-family="sans-serif">
<rect x="20" y="20" width="55" height="55" fill="#ffffff" stroke="#000"/>
<rect x="20" y="75" width="55" height="55" fill="#ffffff" stroke="#000"/>
<rect x="75" y="20" width="110" height="110" fill="#ffffff" stroke="#000"/>
<polygon points="47.5,20 75,47.5 47.5,75 20,47.5" fill="#9a9a9a" stroke="#000"/>
<polygon points="47.5,75 75,102.5 47.5,130 20,102.5" fill="#9a9a9a" stroke="#000"/>
<polygon points="130,20 185,75 130,130 75,75" fill="#9a9a9a" stroke="#000"/>
</svg>"""

# úlohy 11–12: čtvercová síť s obdélníkem (schematicky, kratší strana 9 cm = 10 mřížových bodů)
def _grid1112():
    d = 18; ox, oy = 80, 25
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 250" font-family="sans-serif">']
    for r in range(10):
        for c in range(5):
            s.append(f'<circle cx="{ox+c*d}" cy="{oy+r*d}" r="2.4" fill="#000"/>')
    s.append(f'<line x1="{ox}" y1="{oy}" x2="{ox}" y2="{oy+9*d}" stroke="#000" stroke-width="2"/>')
    s.append(f'<line x1="{ox}" y1="{oy}" x2="{ox+4*d}" y2="{oy}" stroke="#000" stroke-width="2"/>')
    s.append(f'<line x1="{ox-16}" y1="{oy}" x2="{ox-16}" y2="{oy+9*d}" stroke="#000"/>')
    s.append(f'<line x1="{ox-20}" y1="{oy}" x2="{ox-12}" y2="{oy}" stroke="#000"/>')
    s.append(f'<line x1="{ox-20}" y1="{oy+9*d}" x2="{ox-12}" y2="{oy+9*d}" stroke="#000"/>')
    s.append(f'<text x="{ox-22}" y="{oy+9*d/2+4}" font-size="12" text-anchor="end">9 cm</text>')
    s.append('<text x="245" y="150" font-size="22">…</text>')
    bx, by = 330, 150
    for r in range(3):
        for c in range(3):
            s.append(f'<circle cx="{bx+c*d}" cy="{by+r*d}" r="2.4" fill="#000"/>')
    s.append(f'<rect x="{bx}" y="{by}" width="{d}" height="{d}" fill="none" stroke="#000"/>')
    s.append(f'<text x="{bx+d+10}" y="{by+d+6}" font-size="11">1 cm²</text>')
    s.append('</svg>')
    return "".join(s)
SVG1112 = _grid1112()

# úloha 13: prostorová tělesa – pohledy zepředu/zprava (schematická poznámka)
SVG13 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 130" font-family="sans-serif">
<text x="280" y="42" font-size="13" text-anchor="middle">Ke každému návodu 13.1 až 13.3 je dán pohled zepředu a pohled zprava</text>
<text x="280" y="66" font-size="13" text-anchor="middle">(obrazce z krychliček) – viz testový sešit.</text>
<text x="280" y="96" font-size="11" text-anchor="middle" fill="#666">Prostorová tělesa nelze věrně přenést do SVG; posuzuje se podle originálu.</text>
</svg>"""

# úloha 14: výsledný obrazec (schematicky, 3 výchozí body): šikmé rovnoběžky, vodorovné přímky, puntíky
SVG14 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 230" font-family="sans-serif">
<line x1="130" y1="45" x2="330" y2="45" stroke="#000"/>
<line x1="130" y1="80" x2="330" y2="80" stroke="#000"/>
<line x1="130" y1="115" x2="330" y2="115" stroke="#000"/>
<line x1="130" y1="150" x2="330" y2="150" stroke="#000"/>
<line x1="115" y1="185" x2="345" y2="185" stroke="#000"/>
<line x1="150" y1="115" x2="230" y2="45" stroke="#000"/>
<line x1="190" y1="150" x2="270" y2="80" stroke="#000"/>
<line x1="230" y1="185" x2="310" y2="115" stroke="#000"/>
<line x1="150" y1="115" x2="230" y2="185" stroke="#000"/>
<line x1="190" y1="80" x2="270" y2="150" stroke="#000"/>
<line x1="230" y1="45" x2="310" y2="115" stroke="#000"/>
<circle cx="230" cy="45" r="3.5" fill="#000"/>
<circle cx="190" cy="80" r="3.5" fill="#000"/>
<circle cx="270" cy="80" r="3.5" fill="#000"/>
<circle cx="150" cy="115" r="3.5" fill="#000"/>
<circle cx="230" cy="115" r="3.5" fill="#000"/>
<circle cx="310" cy="115" r="3.5" fill="#000"/>
<circle cx="190" cy="150" r="3.5" fill="#000"/>
<circle cx="270" cy="150" r="3.5" fill="#000"/>
<circle cx="230" cy="185" r="3.5" fill="#000"/>
<circle cx="150" cy="185" r="4" fill="#ffffff" stroke="#000"/>
<circle cx="190" cy="185" r="4" fill="#ffffff" stroke="#000"/>
<circle cx="270" cy="185" r="4" fill="#ffffff" stroke="#000"/>
<circle cx="310" cy="185" r="4" fill="#ffffff" stroke="#000"/>
</svg>"""

B = ['zs1']  # 5. ročník ZŠ (přijímačky na osmileté obory); kód r5 v taxonomii není

PROBLEMS = [
    {'name': 'CERMAT M5C 2022 – úloha 1.1',
     'zad': ['Doplňte do rámečku takové číslo, aby byl výpočet správný: $\\square : 21 + 6 = 14$.'],
     'opts': None, 'ln': 2,
     'sol': ['Z $\\square : 21 + 6 = 14$ plyne $\\square : 21 = 8$, tedy $\\square = 8 \\cdot 21 = 168$.'],
     'ans': '$168$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5C 2022 – úloha 1.2',
     'zad': ['Doplňte do rámečku takové číslo, aby byl výpočet správný: $213 : \\square = 14$, zbytek $3$.'],
     'opts': None, 'ln': 2,
     'sol': ['Podíl beze zbytku je $213 - 3 = 210$. Pak $210 : \\square = 14$, tedy $\\square = 210 : 14 = 15$.'],
     'ans': '$15$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5C 2022 – úloha 2.1',
     'zad': ['Z kabelu dlouhého $610$ centimetrů jsme uřízli pět půlmetrových kusů a zbytek jsme rozdělili na $9$ stejně dlouhých dílů.',
             'Určete, kolik centimetrů měří jeden díl.'],
     'opts': None, 'ln': 2,
     'sol': ['Pět půlmetrových kusů $= 5 \\cdot 50 = 250$ cm. Zbytek $610 - 250 = 360$ cm, jeden díl $360 : 9 = 40$ cm.'],
     'ans': '$40$ centimetrů', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5C 2022 – úloha 2.2',
     'zad': ['Cesta na kole z Roztok do Neratovic trvá $1$ hodinu a $50$ minut. S využitím přívozu se doba cestování zkrátí o tři čtvrtě hodiny.',
             'Vypočtěte, kolik minut trvá cesta z Roztok do Neratovic s využitím přívozu.'],
     'opts': None, 'ln': 2,
     'sol': ['$1$ hodina a $50$ minut $= 110$ minut. Tři čtvrtě hodiny $= 45$ minut. Cesta trvá $110 - 45 = 65$ minut (tj. $1$ hodinu a $5$ minut).'],
     'ans': '$65$ minut', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5C 2022 – úloha 3',
     'zad': ['Kapli si během dne prohlédlo celkem $630$ návštěvníků. Na každou prohlídku šla stejně početná skupina návštěvníků, kterou doprovázel vždy jeden z $5$ průvodců. Každý průvodce provedl $4$ skupiny návštěvníků dopoledne a $2$ skupiny odpoledne.',
             '3.1 Vypočtěte, kolik návštěvníků bylo v jedné skupině.',
             '3.2 Vypočtěte, kolik návštěvníků si kapli prohlédlo během dopoledne.'],
     'opts': None, 'ln': 2,
     'sol': ['3.1 Skupin celkem: $5 \\cdot (4 + 2) = 30$. V jedné skupině $630 : 30 = 21$ návštěvníků.',
             '3.2 Dopoledne bylo $5 \\cdot 4 = 20$ skupin, tj. $20 \\cdot 21 = 420$ návštěvníků.'],
     'ans': '3.1: $21$ návštěvníků; 3.2: $420$ návštěvníků', 'pts': 4, 'mins': 4, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5C 2022 – úloha 4',
     'zad': ['Pro soutěž Malování na chodník bylo připraveno celkem $300$ kříd zabalených v krabičkách dvou velikostí – menších a větších. V krabičkách téže velikosti byl vždy stejný počet kříd. Menších krabiček bylo pouze $5$ a celkem v nich bylo tolik kříd jako ve $3$ větších krabičkách. Každá z větších krabiček obsahovala $10$ kříd.',
             '4.1 Určete počet kříd v jedné menší krabičce.',
             '4.2 Určete počet všech větších krabiček s křídami.'],
     'opts': None, 'ln': 2,
     'sol': ['4.1 Ve $3$ větších krabičkách je $3 \\cdot 10 = 30$ kříd, tolik je i v $5$ menších. Jedna menší má $30 : 5 = 6$ kříd.',
             '4.2 V menších krabičkách je celkem $30$ kříd, ve větších tedy $300 - 30 = 270$ kříd. Větších krabiček je $270 : 10 = 27$.'],
     'ans': '4.1: $6$ kříd; 4.2: $27$ větších krabiček', 'pts': 4, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5C 2022 – úloha 5',
     'zad': ['Displej byl zapnutý $10$ hodin. Na počátku se na displeji zobrazilo číslo $51\\,436$ a každou další sekundu se zobrazilo číslo o $1$ větší. Číslo zobrazené na displeji bylo buď oranžové, nebo zelené. Zelená byla právě ta čísla, která čteme zleva i zprava stejně, např. $62\\,526$.',
             '5.1 Ze všech zelených čísel, která se zobrazila na displeji, určete nejmenší.',
             '5.2 Ze všech zelených čísel, která se zobrazila na displeji, určete největší.'],
     'opts': None, 'ln': 2,
     'sol': ['Za $10$ hodin se zobrazí $10 \\cdot 3600 = 36\\,000$ čísel, tedy od $51\\,436$ do $87\\,435$. Zelená jsou pětimístná čísla tvaru $\\overline{abcba}$.',
             '5.1 Nejmenší takové číslo nemenší než $51\\,436$ je $51\\,515$.',
             '5.2 Největší takové číslo nejvýše $87\\,435$ je $87\\,378$.'],
     'ans': '5.1: $51\\,515$; 5.2: $87\\,378$', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5C 2022 – úloha 6',
     'zad': ['Po jarních prázdninách postupně onemocnělo mnoho žáků. V pondělí chyběla $\\frac{1}{6}$ všech žáků školy. V úterý byla nemocná již $\\frac{1}{4}$ všech žáků školy. V pátek byla ve škole už jen $\\frac{1}{3}$ všech žáků školy, tedy $80$ nejodolnějších žáků. Všichni ostatní žáci školy byli nemocní.',
             '6.1 Vypočtěte, kolik žáků měla škola.',
             '6.2 Vypočtěte, kolik žáků bylo v pondělí ve škole.',
             '6.3 Vypočtěte, o kolik nemocných žáků bylo v pátek více než v úterý.'],
     'opts': None, 'ln': 3,
     'sol': ['6.1 V pátek je ve škole $\\frac{1}{3}$ všech žáků, což je $80$. Škola má $3 \\cdot 80 = 240$ žáků.',
             '6.2 V pondělí chybí $\\frac{1}{6}$, ve škole je $\\frac{5}{6}$ žáků: $\\frac{5}{6} \\cdot 240 = 200$ žáků.',
             '6.3 V úterý nemocných $\\frac{1}{4} \\cdot 240 = 60$. V pátek nemocných $240 - 80 = 160$. Rozdíl $160 - 60 = 100$ žáků.'],
     'ans': '6.1: $240$ žáků; 6.2: $200$ žáků; 6.3: o $100$ žáků', 'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5C 2022 – úloha 7.1 (konstrukce)',
     'zad': ['V rovině leží body $K$, $S$ a přímka $q$ procházející bodem $K$ (viz obrázek).',
             'Bod $K$ je vrchol trojúhelníku $KLM$. Všechny tři vrcholy $K$, $L$, $M$ tohoto trojúhelníku leží na kružnici se středem $S$. Na přímce $q$ leží ještě druhý vrchol trojúhelníku $KLM$ a třetí vrchol leží na přímce $s$, která prochází bodem $S$ a je kolmá k přímce $q$.',
             'Sestrojte vrcholy $L$, $M$ trojúhelníku $KLM$, označte je písmeny a trojúhelník narýsujte. Najděte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG7_1, 'fn': 'primka-q.svg',
     'alt': 'Body K a S a přímka q procházející bodem K.', 'cap': 'Výchozí obrázek k úloze 7.1',
     'sol': ['Sestrojíme kružnici se středem $S$ a poloměrem $|SK|$. Přímka $q$ protne tuto kružnici (kromě bodu $K$) v bodě $L$. Přímka $s$ vedená bodem $S$ kolmo k $q$ protne kružnici ve dvou bodech $M_1$, $M_2$; každý z nich dává jedno řešení trojúhelníku $KLM$. Dvě řešení.'],
     'ans': 'Kružnice se středem $S$ a poloměrem $|SK|$; $L$ je druhý průsečík přímky $q$ s kružnicí; třetí vrchol leží na přímce $s$ (kolmá k $q$ v bodě $S$) a na kružnici – dvě polohy $M_1$, $M_2$. Dvě řešení (viz obrázek v klíči).',
     'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5C 2022 – úloha 7.2 (konstrukce)',
     'zad': ['V rovině leží body $A$, $X$ a rovnoběžné přímky $c$, $p$ (viz obrázek).',
             'Bod $A$ je vrchol obdélníku $ABCD$. Bod $X$ leží uvnitř strany $AB$ obdélníku. Na přímce $c$ leží vrchol $C$ obdélníku $ABCD$ a na přímce $p$ jeden ze zbývajících dvou vrcholů obdélníku.',
             'Sestrojte vrcholy $B$, $C$, $D$ obdélníku $ABCD$, označte je písmeny a obdélník narýsujte. Najděte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG7_2, 'fn': 'primky-cp.svg',
     'alt': 'Body A a X a dvě rovnoběžné přímky c a p.', 'cap': 'Výchozí obrázek k úloze 7.2',
     'sol': ['Strana $AB$ leží na přímce určené body $A$ a $X$. Zbývající strany jsou k ní kolmé. Vrchol $C$ hledáme na přímce $c$ tak, aby jeden ze zbývajících vrcholů ($B$, nebo $D$) ležel na přímce $p$; úloha má dvě řešení (polohy $C_1$, $C_2$).'],
     'ans': 'Strana $AB$ leží na přímce $AX$; vrchol $C$ na přímce $c$, jeden ze zbývajících vrcholů na přímce $p$. Dvě řešení – polohy $C_1$, $C_2$ (s vrcholy $B_1$, $D_1$ / $B_2$, $D_2$) – viz obrázek v klíči.',
     'pts': 3, 'mins': 7, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5C 2022 – úloha 8',
     'zad': ['Zahrádkář zakoupil několik kusů rostlin od každého ze čtyř druhů $A$, $B$, $C$ a $D$. Některé zakoupené rostliny uschly, ostatní vzrostly. Většinu vzrostlých rostlin zahrádkář později prodal. Graf udává počty zakoupených, vzrostlých a prodaných kusů rostlin jednotlivých druhů.',
             'Rozhodněte o každém z následujících tvrzení 8.1–8.3, zda je pravdivé (A), či nikoli (N).',
             '8.1 Zahrádkáři zůstalo celkem $9$ neprodaných kusů vzrostlých rostlin.',
             '8.2 Zahrádkář zakoupil o polovinu více kusů rostlin, než jich prodal.',
             '8.3 Zahrádkář prodal všechny zakoupené kusy jen u jednoho druhu rostlin.'],
     'opts': None, 'ln': 0, 'svg': SVG8, 'fn': 'graf-rostliny.svg',
     'alt': 'Skupinový sloupcový graf: pro druhy A, B, C, D počty zakoupených, vzrostlých a prodaných kusů rostlin.',
     'cap': 'Počty zakoupených, vzrostlých a prodaných kusů rostlin jednotlivých druhů',
     'sol': ['Z grafu: A $(14; 12; 7)$, B $(9; 9; 9)$, C $(8; 8; 4)$, D $(11; 8; 8)$ (zakoupené; vzrostlé; prodané).',
             '8.1 Neprodané vzrostlé: $(12-7)+(9-9)+(8-4)+(8-8)=5+0+4+0=9$ → Ano.',
             '8.2 Zakoupené celkem $14+9+8+11=42$, prodané $7+9+4+8=28$; $28 \\cdot 1{,}5 = 42$ → Ano.',
             '8.3 Prodané $=$ zakoupené jen u druhu B ($9=9$) → Ano.'],
     'ans': '8.1: Ano; 8.2: Ano; 8.3: Ano', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['statistika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5C 2022 – úloha 9',
     'zad': ['Hruškový král rozdělil podle zásluh všechny zlaté hrušky mezi tři rytíře. Druhý rytíř dostal o $24$ hrušek více než první rytíř a třetí rytíř dostal dvakrát více hrušek než první rytíř. Druhý a třetí rytíř dostali dohromady šestkrát více hrušek než první rytíř.',
             'Kolik zlatých hrušek rozdělil král mezi tři rytíře?'],
     'opts': ['A) $36$', 'B) $42$', 'C) $48$', 'D) $56$', 'E) jiný počet'], 'ln': 0,
     'sol': ['První rytíř má $p$, druhý $p+24$, třetí $2p$. Druhý a třetí dohromady $6p$: $(p+24)+2p=6p$, odtud $24=3p$, tedy $p=8$. Rozděleno $8+32+16=56$ hrušek.'],
     'ans': 'D) $56$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5C 2022 – úloha 10',
     'zad': ['Obdélník je sestaven z bílého čtverce o obsahu $120$ cm² a dvou menších bílých čtverců. Uvnitř každého bílého čtverce je zakreslen tmavý čtverec, jehož vrcholy dělí všechny strany tohoto bílého čtverce na poloviny.',
             'Jaký je celkový obsah všech tří tmavých čtverců v obdélníku?'],
     'opts': ['A) $60$ cm²', 'B) $75$ cm²', 'C) $90$ cm²', 'D) $105$ cm²', 'E) $120$ cm²'], 'ln': 0,
     'svg': SVG10, 'fn': 'ctverce.svg',
     'alt': 'Obdélník složený z velkého bílého čtverce a dvou menších; v každém je tmavý čtverec s vrcholy ve středech stran.',
     'cap': 'Obdélník se třemi bílými a třemi tmavými čtverci',
     'sol': ['Tmavý čtverec s vrcholy ve středech stran má poloviční obsah než bílý čtverec, v němž leží. Velký bílý čtverec má $120$ cm², každý menší $120 : 4 = 30$ cm² (jeho strana je poloviční). Tmavé čtverce: $\\frac{120}{2}+\\frac{30}{2}+\\frac{30}{2}=60+15+15=90$ cm².'],
     'ans': 'C) $90$ cm²', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5C 2022 – úloha 11',
     'zad': ['Ve čtvercové síti sestrojíme dva obdélníky s vrcholy v mřížových bodech podle vzoru na obrázku. Kratší strana obdélníku má vždy délku $9$ cm a obsahuje $10$ mřížových bodů. Nejmenší čtverec s vrcholy v mřížových bodech má obsah $1$ cm².',
             'První sestrojený obdélník obsahuje celkem $120$ mřížových bodů (včetně mřížových bodů po jeho obvodu). Jaký je obsah tohoto obdélníku?'],
     'opts': ['A) $90$ cm²', 'B) $99$ cm²', 'C) $108$ cm²', 'D) $120$ cm²', 'E) jiný obsah'], 'ln': 0,
     'svg': SVG1112, 'fn': 'sit-obdelnik.svg',
     'alt': 'Čtvercová síť s obdélníkem; kratší strana 9 cm obsahuje 10 mřížových bodů, nejmenší čtverec má obsah 1 cm na druhou.',
     'cap': 'Čtvercová síť s obdélníky (vzor k úlohám 11 a 12)',
     'sol': ['Kratší strana $9$ cm má $10$ mřížových bodů. Počet mřížových bodů obdélníku je $(9+1) \\cdot (b+1)$, kde $b$ je délka delší strany v cm. Z $10 \\cdot (b+1) = 120$ plyne $b+1 = 12$, tedy $b = 11$ cm. Obsah $= 9 \\cdot 11 = 99$ cm².'],
     'ans': 'B) $99$ cm²', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5C 2022 – úloha 12',
     'zad': ['Ve čtvercové síti sestrojíme dva obdélníky s vrcholy v mřížových bodech podle vzoru na obrázku. Kratší strana obdélníku má vždy délku $9$ cm a obsahuje $10$ mřížových bodů. Nejmenší čtverec s vrcholy v mřížových bodech má obsah $1$ cm².',
             'Obvod druhého sestrojeného obdélníku je $120$ cm. Kolik mřížových bodů celkem obsahuje tento obdélník (včetně mřížových bodů po jeho obvodu)?'],
     'opts': ['A) $500$', 'B) $510$', 'C) $520$', 'D) $530$', 'E) jiný počet'], 'ln': 0,
     'svg': SVG1112, 'fn': 'sit-obdelnik.svg',
     'alt': 'Čtvercová síť s obdélníkem; kratší strana 9 cm obsahuje 10 mřížových bodů, nejmenší čtverec má obsah 1 cm na druhou.',
     'cap': 'Čtvercová síť s obdélníky (vzor k úlohám 11 a 12)',
     'sol': ['Kratší strana je $9$ cm. Z obvodu $2 \\cdot (9 + b) = 120$ plyne $9 + b = 60$, tedy $b = 51$ cm. Počet mřížových bodů $= (9+1) \\cdot (51+1) = 10 \\cdot 52 = 520$.'],
     'ans': 'C) $520$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5C 2022 – úloha 13',
     'zad': ['Ze stejně velkých krychliček lepíme těleso podle návodu. Návod obsahuje zobrazení tělesa při pohledu zepředu a při pohledu zprava. Těleso slepené podle vzorového návodu může obsahovat nejvíce $12$ krychliček; podle téhož návodu lze slepit i těleso z menšího počtu krychliček (vynechat lze např. některé tmavé krychličky).',
             'Přiřaďte ke každému návodu (13.1–13.3) největší počet krychliček (A–F), z nichž může být těleso slepeno. Pohledy zepředu a zprava pro 13.1–13.3 viz testový sešit.'],
     'opts': ['A) $11$ krychliček', 'B) $12$ krychliček', 'C) $13$ krychliček', 'D) $14$ krychliček', 'E) $15$ krychliček', 'F) jiný počet krychliček'], 'ln': 0,
     'svg': SVG13, 'fn': 'krychlicky.svg',
     'alt': 'Schematická poznámka: pohledy zepředu a zprava pro návody 13.1 až 13.3 (tělesa z krychliček).',
     'cap': 'Návody – pohledy zepředu a zprava (viz testový sešit)',
     'sol': ['Podle zadaných pohledů zepředu a zprava (viz testový sešit) je největší možný počet krychliček: 13.1 $= 11$ (A), 13.2 $= 15$ (E), 13.3 $= 14$ (D).'],
     'ans': '13.1: A ($11$ krychliček); 13.2: E ($15$ krychliček); 13.3: D ($14$ krychliček)', 'pts': 5, 'mins': 7, 'diff': '4',
     'codes': B + ['stereometrie', 'porozumeni', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5C 2022 – úloha 14',
     'zad': ['Výsledný obrazec vytvoříme následujícím postupem: 1. Na vodorovné přímce sestrojíme několik stejně vzdálených bodů (černých puntíků). 2. Prvním černým puntíkem vedeme dvě různoběžné šikmé přímky; druhým a každým dalším černým puntíkem vedeme rovnoběžky s oběma těmito přímkami. 3. Všechny nově vzniklé průsečíky označíme černými puntíky a těmi vedeme vodorovné přímky. 4. Na spodní vodorovné přímce označíme všechny nově vzniklé průsečíky bílými puntíky.',
             '14.1 Výsledný obrazec obsahuje celkem $36$ černých puntíků. Určete počet všech vodorovných přímek v tomto obrazci.',
             '14.2 Výsledný obrazec obsahuje celkem $49$ vodorovných přímek. Určete počet bílých puntíků na spodní vodorovné přímce tohoto obrazce.',
             '14.3 Výsledný obrazec má na spodní vodorovné přímce celkem $64$ bílých puntíků. Určete počet všech černých puntíků v tomto obrazci.'],
     'opts': None, 'ln': 3, 'svg': SVG14, 'fn': 'puntiky.svg',
     'alt': 'Schematický výsledný obrazec: dvě soustavy rovnoběžných šikmých přímek, vodorovné přímky, černé puntíky v průsečících a bílé puntíky na spodní přímce.',
     'cap': 'Výsledný obrazec (schematicky)',
     'sol': ['Označme $n$ počet výchozích černých puntíků na první vodorovné přímce. Pak je celkem $n^2$ černých puntíků, $2n-1$ vodorovných přímek a $2n-2$ bílých puntíků na spodní přímce.',
             '14.1 $n^2 = 36 \\Rightarrow n = 6$; vodorovných přímek $2 \\cdot 6 - 1 = 11$.',
             '14.2 $2n-1 = 49 \\Rightarrow n = 25$; bílých puntíků $2 \\cdot 25 - 2 = 48$.',
             '14.3 $2n-2 = 64 \\Rightarrow n = 33$; černých puntíků $33^2 = 1\\,089$.'],
     'ans': '14.1: $11$ vodorovných přímek; 14.2: $48$ bílých puntíků; 14.3: $1\\,089$ černých puntíků', 'pts': 4, 'mins': 7, 'diff': '4',
     'codes': B + ['posloupnosti', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M5PCD22C0T03'
    gen.YEAR = 2022

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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M5C-2022')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
