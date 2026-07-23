# -*- coding: utf-8 -*-
# CERMAT – Jednotná přijímací zkouška 2021, MATEMATIKA 7 (šestileté obory, 7. ročník), varianta A, 1. řádný termín.
# Kód testu: M7PAD21C0T01. 16 úloh (po rozdělení izolovaných počtářských podúloh 19 úloh), 50 bodů.
# Zdroj odpovědí: klíč správných řešení (KSR). Ověřeno dopočtem.

# ---------- SVG obrázky (bez apostrofů a zpětných lomítek) ----------

# úloha 5: tabulka závodu v běhu na lyžích (A–F)
def _tab5():
    cols = [("A", "9:20:00", "9:43:15", "0:23:15"),
            ("B", "9:20:30", "9:43:05", ""),
            ("C", "9:21:00", "9:43:25", "0:22:25"),
            ("D", "9:21:30", "9:43:20", ""),
            ("E", "9:22:00", "", "0:23:05"),
            ("F", "9:22:30", "", "0:22:30")]
    rowlab = ["Závodník", "Čas při startu", "Čas v cíli", "Výsledný čas"]
    lw = 150; cw = 78; rh = 32; x0 = 8; y0 = 8
    W = lw + 6 * cw + 2 * x0; H = 4 * rh + 2 * y0
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {W} {H}" font-family="sans-serif" font-size="12">']
    for r in range(5):
        y = y0 + r * rh
        s.append(f'<line x1="{x0}" y1="{y}" x2="{x0 + lw + 6 * cw}" y2="{y}" stroke="#000"/>')
    s.append(f'<line x1="{x0}" y1="{y0}" x2="{x0}" y2="{y0 + 4 * rh}" stroke="#000"/>')
    s.append(f'<line x1="{x0 + lw}" y1="{y0}" x2="{x0 + lw}" y2="{y0 + 4 * rh}" stroke="#000"/>')
    for c in range(6):
        x = x0 + lw + (c + 1) * cw
        s.append(f'<line x1="{x}" y1="{y0}" x2="{x}" y2="{y0 + 4 * rh}" stroke="#000"/>')
    for r in range(4):
        s.append(f'<text x="{x0 + 6}" y="{y0 + r * rh + 21}">{rowlab[r]}</text>')
    for c in range(6):
        cx = x0 + lw + c * cw + cw / 2
        vals = list(cols[c])
        for r in range(4):
            if vals[r]:
                s.append(f'<text x="{cx}" y="{y0 + r * rh + 21}" text-anchor="middle">{vals[r]}</text>')
    s.append('</svg>')
    return "".join(s)
SVG5 = _tab5()

# úloha 6: vyhlídková trasa nádraží–jezero (schematicky)
SVG6 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 720 300" font-family="sans-serif" font-size="14">
<polyline points="60,250 210,150 410,255 500,175 690,265" fill="none" stroke="#000" stroke-width="2"/>
<circle cx="60" cy="250" r="5"/><circle cx="210" cy="150" r="5"/><circle cx="410" cy="255" r="5"/><circle cx="500" cy="175" r="5"/><circle cx="690" cy="265" r="5"/>
<text x="60" y="278" text-anchor="middle">nádraží</text>
<text x="210" y="138" text-anchor="middle">1. vyhlídka</text>
<text x="410" y="283" text-anchor="middle">studánka</text>
<text x="500" y="163" text-anchor="middle">2. vyhlídka</text>
<text x="690" y="290" text-anchor="middle">jezero</text>
</svg>"""

# úloha 7: vysoký skleněný kvádr, barevná vrstva 6 krychlí nahoře i dole (schematicky)
SVG7 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 280 400" font-family="sans-serif" font-size="13">
<polygon points="40,40 160,40 200,18 80,18" fill="#cccccc" stroke="#000"/>
<polygon points="160,40 200,18 200,360 160,382" fill="#dcdcdc" stroke="#000"/>
<rect x="40" y="40" width="120" height="342" fill="#f5f5f5" stroke="#000"/>
<rect x="40" y="40" width="40" height="44" fill="#8a8a8a" stroke="#000"/><rect x="80" y="40" width="40" height="44" fill="#bdbdbd" stroke="#000"/><rect x="120" y="40" width="40" height="44" fill="#8a8a8a" stroke="#000"/>
<rect x="40" y="338" width="40" height="44" fill="#bdbdbd" stroke="#000"/><rect x="80" y="338" width="40" height="44" fill="#8a8a8a" stroke="#000"/><rect x="120" y="338" width="40" height="44" fill="#bdbdbd" stroke="#000"/>
<line x1="210" y1="60" x2="242" y2="60" stroke="#000"/><text x="212" y="54">2 cm</text>
</svg>"""

# úloha 8: výchozí obrázek – body B, P a přímka q
SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 340" font-family="sans-serif" font-size="15">
<line x1="150" y1="60" x2="330" y2="300" stroke="#000" stroke-width="2"/>
<text x="336" y="302" font-style="italic">q</text>
<line x1="242" y1="208" x2="258" y2="192" stroke="#000"/><text x="266" y="206">B</text>
<text x="190" y="164" font-style="italic">P</text><text x="188" y="180">×</text>
</svg>"""

# úloha 9: výchozí obrázek – přímka AC a bod M
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif" font-size="15">
<line x1="60" y1="245" x2="400" y2="105" stroke="#000" stroke-width="2"/>
<text x="96" y="240" font-style="italic">A</text><text x="90" y="252">×</text>
<text x="362" y="108" font-style="italic">C</text><text x="346" y="122">×</text>
<text x="238" y="200" font-style="italic">M</text><text x="234" y="185">×</text>
</svg>"""

# úloha 10: obrazce A a B – schodovité útvary ze dvou čtverců (schematicky, výsledek dle klíče)
def _obrazce():
    A = ["##...", ".##..", "..##.", "...##"]
    B = ["####..", ".####.", "..####", "...###", "....##", ".....#"]
    def draw(grid, ox, oy, u):
        out = []
        for r, row in enumerate(grid):
            for c, ch in enumerate(row):
                if ch == "#":
                    out.append(f'<rect x="{ox + c * u}" y="{oy + r * u}" width="{u}" height="{u}" fill="#e6e6e6" stroke="#000" stroke-width="1.5"/>')
        return "".join(out)
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 250" font-family="sans-serif" font-size="14">']
    s.append('<text x="120" y="22" text-anchor="middle">Obrazec A</text>')
    s.append(draw(A, 40, 40, 40))
    s.append('<text x="410" y="22" text-anchor="middle">Obrazec B</text>')
    s.append(draw(B, 320, 40, 30))
    s.append('</svg>')
    return "".join(s)
SVG10 = _obrazce()

# úloha 11: rovnoběžník ABCD a rovnoramenný trojúhelník BEC
SVG11 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 320" font-family="sans-serif" font-size="15">
<polygon points="60,280 250,280 340,150 150,150" fill="none" stroke="#000" stroke-width="2"/>
<polygon points="250,280 340,150 440,280" fill="none" stroke="#000" stroke-width="2"/>
<text x="52" y="298">A</text><text x="244" y="298">B</text><text x="438" y="298">E</text>
<text x="140" y="144">D</text><text x="336" y="144">C</text>
<text x="166" y="178">114°</text><text x="330" y="184" font-style="italic">φ</text>
</svg>"""

# úlohy 12–13: skládaný sloupcový graf prodeje triček a mikin (A–C)
def _bars():
    data = [("A", 12, 4), ("B", 10, 20), ("C", 20, 6)]  # (obchod, mikiny, tricka)
    x0, y0 = 70, 300; unit = 8; bw = 60; gap = 50
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 360" font-family="sans-serif" font-size="12">']
    s.append(f'<line x1="{x0}" y1="20" x2="{x0}" y2="{y0}" stroke="#000"/>')
    s.append(f'<line x1="{x0}" y1="{y0}" x2="420" y2="{y0}" stroke="#000"/>')
    for v in range(0, 33, 4):
        y = y0 - v * unit
        s.append(f'<line x1="{x0 - 4}" y1="{y}" x2="{x0}" y2="{y}" stroke="#000"/><text x="{x0 - 8}" y="{y + 4}" text-anchor="end">{v}</text>')
    x = x0 + gap
    for name, mik, tri in data:
        hm = mik * unit; ht = tri * unit
        s.append(f'<rect x="{x}" y="{y0 - hm}" width="{bw}" height="{hm}" fill="#ffffff" stroke="#000"/>')
        s.append(f'<rect x="{x}" y="{y0 - hm - ht}" width="{bw}" height="{ht}" fill="#b0b0b0" stroke="#000"/>')
        s.append(f'<text x="{x + bw / 2}" y="{y0 + 16}" text-anchor="middle">{name}</text>')
        x += bw + gap
    s.append('<rect x="350" y="40" width="14" height="14" fill="#b0b0b0" stroke="#000"/><text x="370" y="52">Trička</text>')
    s.append('<rect x="350" y="62" width="14" height="14" fill="#ffffff" stroke="#000"/><text x="370" y="74">Mikiny</text>')
    s.append('<text x="18" y="165" transform="rotate(-90 18 165)" text-anchor="middle" font-size="11">Počet prodaných kusů</text>')
    s.append('</svg>')
    return "".join(s)
SVG1213 = _bars()

# úloha 16: obrazce z puntíků uspořádaných ve čtvercích (1.–3. obrazec)
def _dots():
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 200" font-family="sans-serif" font-size="13">']
    def dot(x, y):
        return f'<circle cx="{x}" cy="{y}" r="3.5" fill="#000"/>'
    sp = 22
    s.append('<text x="60" y="36" text-anchor="middle">1.</text>')
    s.append(dot(60, 108))
    s.append('<text x="160" y="36" text-anchor="middle">2.</text>')
    ox, oy = 138, 76
    for i in range(3):
        for j in range(3):
            if i in (0, 2) or j in (0, 2):
                s.append(dot(ox + j * sp, oy + i * sp))
    s.append('<text x="332" y="36" text-anchor="middle">3.</text>')
    ox, oy = 288, 54
    for i in range(5):
        for j in range(5):
            if i in (0, 4) or j in (0, 4):
                s.append(dot(ox + j * sp, oy + i * sp))
    s.append(dot(ox + 2 * sp, oy + 2 * sp))
    s.append('<text x="470" y="112" font-size="20">…</text>')
    s.append('</svg>')
    return "".join(s)
SVG16 = _dots()

# ---------- Úlohy ----------

B = ['zs2', 'r7']  # 7. ročník, šestileté obory

PROBLEMS = [
    {'name': 'CERMAT M7A 2021 – úloha 1',
     'zad': ['Vypočtěte v dm² tři pětiny ze $4$ m².'],
     'opts': None, 'ln': 2,
     'sol': ['$4$ m² $=400$ dm². Tři pětiny: $\\frac{3}{5}\\cdot 400=240$ dm².'],
     'ans': '$240$ dm²', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2021 – úloha 2.1',
     'zad': ['Vypočtěte: $0{,}5+1{,}5\\cdot(10-4)-1{,}5:5=$'],
     'opts': None, 'ln': 2,
     'sol': ['$0{,}5+1{,}5\\cdot 6-0{,}3=0{,}5+9-0{,}3=9{,}2$.'],
     'ans': '$9{,}2$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2021 – úloha 2.2',
     'zad': ['Vypočtěte: $0{,}4\\cdot 0{,}3-0{,}3\\cdot 1{,}6=$'],
     'opts': None, 'ln': 2,
     'sol': ['$0{,}12-0{,}48=-0{,}36$.'],
     'ans': '$-0{,}36$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2021 – úloha 3.1',
     'zad': ['Vypočtěte a výsledek zapište zlomkem v základním tvaru.',
             '$\\frac{1}{3}-\\frac{6}{5}\\cdot\\left(\\frac{5}{4}-\\frac{5}{6}\\right)=$'],
     'opts': None, 'ln': 3,
     'sol': ['V závorce: $\\frac{5}{4}-\\frac{5}{6}=\\frac{15-10}{12}=\\frac{5}{12}$.',
             'Součin: $\\frac{6}{5}\\cdot\\frac{5}{12}=\\frac{1}{2}$. Celkem $\\frac{1}{3}-\\frac{1}{2}=-\\frac{1}{6}$.'],
     'ans': '$-\\frac{1}{6}$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2021 – úloha 3.2',
     'zad': ['Vypočtěte a výsledek zapište zlomkem v základním tvaru.',
             '$\\dfrac{\\frac{3}{10}}{\\frac{7}{2}:2+2}=$'],
     'opts': None, 'ln': 3,
     'sol': ['Jmenovatel: $\\frac{7}{2}:2+2=\\frac{7}{4}+2=\\frac{15}{4}$.',
             'Podíl: $\\frac{3}{10}:\\frac{15}{4}=\\frac{3}{10}\\cdot\\frac{4}{15}=\\frac{12}{150}=\\frac{2}{25}$.'],
     'ans': '$\\frac{2}{25}$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2021 – úloha 4.1',
     'zad': ['Když neznámé číslo vynásobíme třemi, dostaneme stejné číslo, jako když vydělíme třemi číslo $234$.',
             'Určete neznámé číslo.'],
     'opts': None, 'ln': 2,
     'sol': ['$3x=234:3=78$, tedy $x=78:3=26$.'],
     'ans': '$26$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['rovnice', 'modelovani', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2021 – úloha 4.2',
     'zad': ['Adéla, Zora a Olda postupně zametli $1$ km dlouhý chodník. První část zametla Adéla, Zora pak zametla o $120$ m kratší část než Adéla a Olda zametl dvakrát delší část chodníku než Zora. (Každou část zametala pouze jedna osoba.)',
             'Vypočtěte, kolik metrů chodníku zametla Adéla.'],
     'opts': None, 'ln': 3,
     'sol': ['Adéla $a$, Zora $a-120$, Olda $2(a-120)$. Rovnice: $a+(a-120)+2(a-120)=1000$, tj. $4a-360=1000$, $a=340$.',
             'Adéla zametla $340$ m (Zora $220$ m, Olda $440$ m).'],
     'ans': '$340$ m', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['rovnice', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7A 2021 – úloha 5',
     'zad': ['Závod mladších žáků v běhu na lyžích absolvovalo $6$ závodníků (A–F). První závodník vyběhl na trať v $9$ hodin $20$ minut, další vybíhali v půlminutových intervalech. Zvítězil závodník, který strávil na trati nejkratší dobu (má nejlepší výsledný čas). Časy v tabulce jsou ve tvaru h:min:s.',
             '5.1 Vypočtěte výsledný čas vítěze závodu (v minutách a sekundách).',
             '5.2 Určete, na kolikátém místě se umístil závodník, který proběhl cílem jako první.',
             '5.3 Uveďte písmena všech závodníků, kteří proběhli cílem později než závodník D.'],
     'opts': None, 'ln': 3, 'svg': SVG5, 'fn': 'zavod-tabulka.svg',
     'alt': 'Tabulka časů závodníků A až F: čas při startu, čas v cíli a výsledný čas (některé buňky prázdné).',
     'cap': 'Výchozí tabulka k úloze 5 (časy ve tvaru h:min:s)',
     'sol': ['Chybějící výsledné časy: B $9{:}43{:}05-9{:}20{:}30=0{:}22{:}35$, D $9{:}43{:}20-9{:}21{:}30=0{:}21{:}50$.',
             '5.1 Nejkratší čas má D: $21$ min $50$ s.',
             '5.2 Cílem první proběhl B (čas v cíli $9{:}43{:}05$); podle výsledných časů se umístil na $4.$ místě (D, C, F, B, E, A).',
             '5.3 Později než D ($9{:}43{:}20$) proběhli cílem C ($9{:}43{:}25$), E a F ($9{:}45{:}05$, resp. $9{:}45{:}00$): C, E, F.'],
     'ans': '5.1: $21$ min $50$ s; 5.2: na $4.$ místě; 5.3: C, E, F',
     'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'porozumeni', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7A 2021 – úloha 6',
     'zad': ['Matěj prošel celou vyhlídkovou trasu, která vede od nádraží k jezeru. Od nádraží k první vyhlídce ušel $\\frac{1}{6}$ trasy. Po dalších $5{,}5$ km chůze se dostal k druhé vyhlídce. Od ní mu k jezeru zbývaly už jen $\\frac{2}{9}$ trasy. Ještě $1$ km před druhou vyhlídkou se Matěj zastavil u studánky.',
             '6.1 Vypočtěte, kolik km ušel Matěj od nádraží k první vyhlídce.',
             '6.2 Vyjádřete zlomkem v základním tvaru, jakou část trasy Matěj ušel od nádraží ke studánce.'],
     'opts': None, 'ln': 4, 'svg': SVG6, 'fn': 'trasa.svg',
     'alt': 'Schematická trasa od nádraží přes 1. vyhlídku, studánku a 2. vyhlídku k jezeru.',
     'cap': 'Výchozí obrázek k úloze 6 (schematicky)',
     'sol': ['Úsek mezi vyhlídkami je $5{,}5$ km a tvoří $1-\\frac{1}{6}-\\frac{2}{9}=\\frac{11}{18}$ celé trasy. Celá trasa $t=5{,}5:\\frac{11}{18}=9$ km.',
             '6.1 K první vyhlídce: $\\frac{1}{6}\\cdot 9=1{,}5$ km.',
             '6.2 Od nádraží ke druhé vyhlídce je $1{,}5+5{,}5=7$ km, studánka je o $1$ km blíž, tj. $6$ km, což je $\\frac{6}{9}=\\frac{2}{3}$ trasy.'],
     'ans': '6.1: $1{,}5$ km; 6.2: $\\frac{2}{3}$ trasy',
     'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7A 2021 – úloha 7',
     'zad': ['Horní část skleněného kvádru tvoří $6$ krychlí z barevného skla umístěných v jedné vrstvě; každá krychle má hranu délky $2$ cm. Stejná vrstva krychlí tvoří také spodní část kvádru. Obě vrstvy barevných krychlí dohromady zaujímají $20\\,\\%$ objemu celého kvádru. Zbytek kvádru je z bílého skla.',
             'Vypočtěte:',
             '7.1 v cm³ objem jedné vrstvy barevných krychlí,',
             '7.2 v cm délku nejdelší hrany celého kvádru,',
             '7.3 v cm² povrch celého kvádru.'],
     'opts': None, 'ln': 4, 'svg': SVG7, 'fn': 'kvadr.svg',
     'alt': 'Vysoký skleněný kvádr s vrstvou šesti barevných krychlí nahoře i dole.',
     'cap': 'Výchozí obrázek k úloze 7 (schematicky)',
     'sol': ['7.1 Jedna vrstva: $6$ krychlí po $2^3=8$ cm³, tj. $6\\cdot 8=48$ cm³.',
             '7.2 Obě vrstvy $=96$ cm³ $=20\\,\\%$, celý kvádr má $96:0{,}2=480$ cm³. Podstava vrstvy je obdélník $6\\times 4$ cm (obsah $24$ cm²), takže výška kvádru $=480:24=20$ cm; to je nejdelší hrana.',
             '7.3 Kvádr $6\\times 4\\times 20$ cm: $S=2\\,(6\\cdot 4+6\\cdot 20+4\\cdot 20)=2\\,(24+120+80)=448$ cm².'],
     'ans': '7.1: $48$ cm³; 7.2: $20$ cm; 7.3: $448$ cm²',
     'pts': 4, 'mins': 7, 'diff': '3',
     'codes': B + ['stereometrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2021 – úloha 8',
     'zad': ['V rovině leží body $B$, $P$ a přímka $q$ procházející bodem $B$ (viz obrázek).',
             'Bod $B$ je vrchol rovnoběžníku $ABCD$. Úhlopříčky $AC$ a $BD$ jsou na sebe kolmé a protínají se v bodě $P$. Strana $BC$ leží na přímce $q$.',
             'Sestrojte vrcholy $A$, $C$, $D$ rovnoběžníku $ABCD$, označte je písmeny a rovnoběžník narýsujte.'],
     'opts': None, 'ln': 0, 'svg': SVG8, 'fn': 'body-B-P-q.svg',
     'alt': 'Přímka q s vyznačeným bodem B a samostatný bod P vlevo od přímky.',
     'cap': 'Výchozí obrázek k úloze 8',
     'sol': ['Vrchol $C$ leží na přímce $q$ a zároveň na kolmici k přímce $BP$ vedené bodem $P$ (úhlopříčky jsou kolmé): $C$ je průsečík této kolmice s $q$. Vrchol $A$ je obraz $C$ ve středové souměrnosti se středem $P$ ($P$ je střed úhlopříčky $AC$). Vrchol $D$ je obraz $B$ ve středové souměrnosti se středem $P$.'],
     'ans': 'Konstrukce rovnoběžníku $ABCD$: $C$ je průsečík přímky $q$ s kolmicí k $BP$ v bodě $P$, $A$ je obraz $C$ a $D$ obraz $B$ ve středové souměrnosti se středem $P$ (viz obrázek v klíči).',
     'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2021 – úloha 9',
     'zad': ['V rovině leží přímka $AC$ a bod $M$ (viz obrázek).',
             'Úsečka $AC$ je strana trojúhelníku $ABC$ a bod $M$ leží uvnitř tohoto trojúhelníku. Výška $v_b$ na stranu $AC$ měří $5$ cm. Velikost vnitřního úhlu při vrcholu $C$ je $120^\\circ$.',
             'Sestrojte vrchol $B$ trojúhelníku $ABC$, označte jej písmenem a trojúhelník narýsujte.'],
     'opts': None, 'ln': 0, 'svg': SVG9, 'fn': 'primka-AC-M.svg',
     'alt': 'Přímka procházející body A a C a bod M ležící pod ní.',
     'cap': 'Výchozí obrázek k úloze 9',
     'sol': ['Sestrojíme rovnoběžku s přímkou $AC$ ve vzdálenosti $5$ cm na té straně, kde leží $M$ (množina bodů výšky). Ve vrcholu $C$ sestrojíme rameno úhlu $ACB=120^\\circ$. Průsečík tohoto ramene s rovnoběžkou je vrchol $B$.'],
     'ans': 'Konstrukce vrcholu $B$: $B$ je průsečík ramene úhlu $ACB=120^\\circ$ s rovnoběžkou se stranou $AC$ vedenou ve vzdálenosti $5$ cm (na straně bodu $M$) – viz obrázek v klíči.',
     'pts': 3, 'mins': 6, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2021 – úloha 10',
     'zad': ['Na vytvoření každého obrazce použijeme beze zbytku dva čtverce o straně délky $6$ cm. Čtverce rozstříháme a ze všech získaných dílů sestavíme obrazec, jehož strany (úsečky po obvodu) mají pouze dvě různé délky (viz obrázek).',
             'Rozhodněte o každém z následujících tvrzení (10.1–10.3), zda je pravdivé (A), či nikoli (N).',
             '10.1 Nejdelší strana obrazce A je o třetinu kratší než nejdelší strana obrazce B.',
             '10.2 Obvod obrazce A je roven součtu obvodů obou čtverců, z nichž byl vytvořen.',
             '10.3 Obvod obrazce A je větší než obvod obrazce B.'],
     'opts': None, 'ln': 0, 'svg': SVG10, 'fn': 'obrazce-AB.svg',
     'alt': 'Dva schodovité obrazce A a B složené z jednotkových čtverců (schematicky).',
     'cap': 'Obrazce A a B (schematicky, obsah každého je 72 cm²)',
     'sol': ['Obrazec A je schodovitý útvar z osmi čtverců o straně $3$ cm (obsah $8\\cdot 9=72$ cm²): nejdelší strana $6$ cm, obvod $18\\cdot 3=54$ cm. Obrazec B je z osmnácti čtverců o straně $2$ cm (obsah $18\\cdot 4=72$ cm²): nejdelší strana $8$ cm, obvod $24\\cdot 2=48$ cm.',
             '10.1 $6$ cm proti $8$ cm je o čtvrtinu (ne o třetinu) kratší → Ne.',
             '10.2 Obvod A $=54$ cm, součet obvodů čtverců $=2\\cdot 24=48$ cm → Ne.',
             '10.3 Obvod A $=54$ cm $>48$ cm $=$ obvod B → Ano.'],
     'ans': '10.1: Ne; 10.2: Ne; 10.3: Ano',
     'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['planimetrie', 'argumentace', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2021 – úloha 11',
     'zad': ['V rovině leží rovnoběžník $ABCD$ a rovnoramenný trojúhelník $BEC$ se základnou $BE$. Body $A$, $B$, $E$ leží na jedné přímce. Vnitřní úhel rovnoběžníku při vrcholu $D$ má velikost $114^\\circ$ (viz obrázek).',
             'Jaká je velikost úhlu $\\varphi$ (úhel $BCE$)? Velikosti úhlů neměřte, ale vypočtěte.'],
     'opts': ['A) $66^\\circ$', 'B) $57^\\circ$', 'C) $54^\\circ$', 'D) $48^\\circ$', 'E) jiná velikost'],
     'ln': 0, 'svg': SVG11, 'fn': 'rovnobeznik-trojuhelnik.svg',
     'alt': 'Rovnoběžník ABCD s úhlem 114° u vrcholu D a rovnoramenný trojúhelník BEC s úhlem φ u vrcholu C; body A, B, E na jedné přímce.',
     'cap': 'Výchozí obrázek k úloze 11',
     'sol': ['Protilehlé úhly rovnoběžníku jsou shodné, takže úhel $ABC$ je roven úhlu při vrcholu $D$, tj. $114^\\circ$. Body $A$, $B$, $E$ leží na přímce, proto úhel $CBE=180^\\circ-114^\\circ=66^\\circ$.',
             'Trojúhelník $BEC$ je rovnoramenný se základnou $BE$, úhly při základně jsou shodné: $|\\angle CBE|=|\\angle CEB|=66^\\circ$. Úhel při vrcholu $C$ je $\\varphi=180^\\circ-2\\cdot 66^\\circ=48^\\circ$.'],
     'ans': 'D) $48^\\circ$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2021 – úloha 12',
     'zad': ['Stejná trička a stejné mikiny se prodávaly ve $3$ obchodech (A–C) za různé ceny. Graf udává počty prodaných kusů, tabulka některé ceny a tržby: cena trička v obchodě B je $180$ Kč; tržba za trička v A je $1\\,000$ Kč; cena mikiny v A je $500$ Kč; tržba za mikiny je v A $6\\,000$ Kč a v C $7\\,200$ Kč. Tričko se v obchodě C prodávalo o $40$ Kč levněji než v obchodě A. V obchodě B utržili za prodaná trička tolik korun jako za prodané mikiny.',
             'Kolik korun utržili v obchodě C za všechna prodaná trička?'],
     'opts': ['A) $960$ Kč', 'B) $1\\,050$ Kč', 'C) $1\\,260$ Kč', 'D) $1\\,740$ Kč', 'E) více než $1\\,740$ Kč'],
     'ln': 0, 'svg': SVG1213, 'fn': 'graf-tricka-mikiny.svg',
     'alt': 'Skládaný sloupcový graf počtu prodaných triček a mikin v obchodech A, B, C (A 12 a 4, B 10 a 20, C 20 a 6).',
     'cap': 'Počty prodaných kusů v obchodech A–C (mikiny bílé, trička šedá)',
     'sol': ['V A: mikin $6\\,000:500=12$ (graf), triček $16-12=4$; cena trička v A $=1\\,000:4=250$ Kč.',
             'Cena trička v C $=250-40=210$ Kč, prodaných triček v C je $26-20=6$; tržba $6\\cdot 210=1\\,260$ Kč.'],
     'ans': 'C) $1\\,260$ Kč', 'pts': 2, 'mins': 5, 'diff': '3',
     'codes': B + ['statistika', 'porozumeni', 'slovni', 'bez-kalkulacky', 'finance']},

    {'name': 'CERMAT M7A 2021 – úloha 13',
     'zad': ['Vycházejte z téhož výchozího textu, grafu a tabulky jako u úlohy 12 (prodej triček a mikin ve $3$ obchodech A–C).',
             'O kolik korun se lišila cena jedné mikiny v obchodech B a C?'],
     'opts': ['A) o $20$ Kč', 'B) o $40$ Kč', 'C) o $60$ Kč', 'D) o $90$ Kč', 'E) ceny se nelišily'],
     'ln': 0, 'svg': SVG1213, 'fn': 'graf-tricka-mikiny.svg',
     'alt': 'Skládaný sloupcový graf počtu prodaných triček a mikin v obchodech A, B, C (A 12 a 4, B 10 a 20, C 20 a 6).',
     'cap': 'Počty prodaných kusů v obchodech A–C (mikiny bílé, trička šedá)',
     'sol': ['Obchod C: mikin $20$ (graf), tržba $7\\,200$ Kč, cena mikiny $7\\,200:20=360$ Kč.',
             'Obchod B: triček $20$ po $180$ Kč $=3\\,600$ Kč $=$ tržba za mikiny; mikin je $10$, cena mikiny $3\\,600:10=360$ Kč. Ceny mikin v B i C jsou $360$ Kč, tedy stejné.'],
     'ans': 'E) ceny se nelišily', 'pts': 2, 'mins': 5, 'diff': '3',
     'codes': B + ['statistika', 'porozumeni', 'slovni', 'bez-kalkulacky', 'finance']},

    {'name': 'CERMAT M7A 2021 – úloha 14',
     'zad': ['V cukrárně mají zabaleno celkem $80$ zákusků buď v malých krabičkách po $2$ zákuscích, nebo ve velkých krabičkách po $3$ zákuscích. Malých krabiček je o $10$ více než velkých.',
             'Kolik krabiček se zákusky (malých i velkých dohromady) mají v cukrárně?'],
     'opts': ['A) $24$', 'B) $34$', 'C) $38$', 'D) $40$', 'E) jiný počet'],
     'ln': 0,
     'sol': ['Velkých $v$, malých $v+10$: $2(v+10)+3v=80$, tj. $5v+20=80$, $v=12$. Malých $22$, celkem $12+22=34$ krabiček.'],
     'ans': 'B) $34$', 'pts': 2, 'mins': 4, 'diff': '2',
     'codes': B + ['rovnice', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7A 2021 – úloha 15',
     'zad': ['Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).',
             '15.1 Nemocnice obdržela $50\\,000$ dávek vakcíny a $92\\,\\%$ jich již použila k očkování. Kolik dávek vakcíny nemocnici zbývá?',
             '15.2 Prováděla se kontrola kvality všech pamětních mincí. Požadovanou kvalitu nemělo $10\\,\\%$ mincí, zbývajících $2\\,700$ mincí bylo v pořádku. Kolik pamětních mincí bylo celkem zkontrolováno?',
             '15.3 Hořká čokoláda tvořila $24\\,\\%$ celkového množství vyrobené čokolády, mléčné se vyrobilo o polovinu více než hořké a oříškové $1\\,120$ kg. Kolik kilogramů čokolády se celkem vyrobilo?'],
     'opts': ['A) $2\\,800$', 'B) $3\\,000$', 'C) $3\\,200$', 'D) $3\\,600$', 'E) $4\\,000$', 'F) jiný počet'],
     'ln': 0,
     'sol': ['15.1 Zbývá $8\\,\\%$ z $50\\,000$, tj. $0{,}08\\cdot 50\\,000=4\\,000$ dávek → E.',
             '15.2 Kvalitních je $90\\,\\%=2\\,700$, celek $2\\,700:0{,}9=3\\,000$ mincí → B.',
             '15.3 Hořká $24\\,\\%$, mléčná $36\\,\\%$, dohromady $60\\,\\%$; oříšková je $40\\,\\%=1\\,120$ kg, celek $1\\,120:0{,}4=2\\,800$ kg → A.'],
     'ans': '15.1: E ($4\\,000$); 15.2: B ($3\\,000$); 15.3: A ($2\\,800$)',
     'pts': 6, 'mins': 9, 'diff': '3',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7A 2021 – úloha 16',
     'zad': ['První obrazec tvoří jediný puntík. V dalších obrazcích jsou puntíky uspořádány ve čtvercích. Strana hraničního čtverce druhého obrazce obsahuje $3$ puntíky a u každého následujícího obrazce má vždy o $2$ puntíky více (např. strana $5.$ obrazce má $9$ puntíků). Počínaje třetím obrazcem vidíme uvnitř hraničního čtverce vždy celý obrazec s pořadovým číslem o $2$ menším. Počty puntíků: $1.$ obrazec $1$, $2.$ obrazec $8$, $3.$ obrazec $17$, $4.$ obrazec $32$, $5.$ obrazec $49$.',
             'Určete:',
             '16.1 kolik puntíků obsahuje jedna strana hraničního čtverce $10.$ obrazce,',
             '16.2 o kolik se liší počty puntíků v $9.$ a $11.$ obrazci,',
             '16.3 u kolikátého obrazce se počty puntíků v okolních dvou obrazcích (těsně před a těsně za ním) liší o $120$.'],
     'opts': None, 'ln': 4, 'svg': SVG16, 'fn': 'puntiky.svg',
     'alt': 'První až třetí obrazec: jeden puntík, čtvercový rám z 8 puntíků a čtvercový rám z 16 puntíků s jedním puntíkem uprostřed.',
     'cap': '1., 2. a 3. obrazec (schematicky)',
     'sol': ['Strana hraničního čtverce $n$-tého obrazce má $2n-1$ puntíků. Počet puntíků $P(n)$ splňuje $P(n)=4(2n-2)+P(n-2)$, takže rozdíl sousedních přes jeden je $P(n+1)-P(n-1)=8n$.',
             '16.1 Strana $10.$ obrazce: $2\\cdot 10-1=19$ puntíků.',
             '16.2 $P(11)-P(9)=8\\cdot 10=80$ puntíků.',
             '16.3 $P(n+1)-P(n-1)=8n=120\\Rightarrow n=15$; jde o $15.$ obrazec.'],
     'ans': '16.1: $19$ puntíků; 16.2: o $80$ puntíků; 16.3: u $15.$ obrazce',
     'pts': 4, 'mins': 7, 'diff': '4',
     'codes': B + ['posloupnosti', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M7PAD21C0T01'
    gen.YEAR = 2021

    def dollars_ok(s):
        return s.count('$') % 2 == 0
    errors = []; names = set()
    for p in PROBLEMS:
        if p['name'] in names:
            errors.append('DUP název: ' + p['name'])
        names.add(p['name'])
        for t in [p['name'], p['ans']] + list(p['zad']) + list(p['sol']) + (p.get('opts') or []):
            if not dollars_ok(t):
                errors.append('Nepárový $: ' + t[:70])
        if p.get('svg') and ("'" in p['svg'] or '\\' in p['svg']):
            errors.append('SVG zakázaný znak: ' + p['name'])
        if p.get('svg') and not p.get('alt'):
            errors.append('Obrázek bez alt: ' + p['name'])
        for lbl, obj in (('content', gen.py_content_json(p)), ('solution', gen.py_solution_json(p)), ('answer', gen.py_answer_json(p))):
            try:
                json.loads(json.dumps(obj, ensure_ascii=False))
            except Exception as e:
                errors.append(f'JSON {lbl} {p["name"]}: {e}')
    if errors:
        print('CHYBY:'); [print('  -', e) for e in errors]; sys.exit(1)
    print('Validace OK:', len(PROBLEMS), 'úloh')
    outdir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'out')
    os.makedirs(outdir, exist_ok=True)
    tot = 0
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M7A-2021')):
        tot += k
        print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz < 9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
