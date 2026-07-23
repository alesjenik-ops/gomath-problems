# -*- coding: utf-8 -*-
# CERMAT – Jednotná přijímací zkouška 2022, MATEMATIKA 5A (osmileté obory, 5. ročník), 1. řádný termín.
# Kód testu: M5PAD22C0T01. 14 úloh (po rozdělení izolovaných poduúloh 17 úloh).
# Zdroj odpovědí: klíč správných řešení (KSR); struktura ověřena záznamovým archem (VZA).

# ---- SVG obrázky (bez znaků apostrof a zpětné lomítko) ----

# úloha 2: číselná osa, 9 bodů = 8 stejných dílků; A,B,C,D na 2.,3.,5.,7. bodě; nad C je 48
def _axis():
    y = 80
    xs = [40 + i * 60 for i in range(9)]
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 130" font-family="sans-serif">']
    s.append(f'<line x1="20" y1="{y}" x2="540" y2="{y}" stroke="#000" stroke-width="2"/>')
    s.append(f'<polygon points="540,{y} 528,{y-6} 528,{y+6}" fill="#000"/>')
    for x in xs:
        s.append(f'<line x1="{x}" y1="{y-8}" x2="{x}" y2="{y+8}" stroke="#000" stroke-width="2"/>')
    for idx, lab in {1: 'A', 2: 'B', 4: 'C', 6: 'D'}.items():
        s.append(f'<text x="{xs[idx]}" y="{y+26}" font-size="16" text-anchor="middle" font-style="italic">{lab}</text>')
    s.append(f'<text x="{xs[4]}" y="{y-16}" font-size="15" text-anchor="middle">48</text>')
    s.append('</svg>')
    return "".join(s)
SVG2 = _axis()

# úloha 4: skládaný sloupcový graf nehod (A–D po čtvrtletích) + celoroční sloupec E
# jisté hodnoty: 3. čtvrtletí A3 B6 C4 D2; součty A10 B12 C11 D13; E=12. Vnitřní dělení schematické.
def _bars4():
    data = [('A', (0, 3, 3, 4)), ('B', (2, 3, 6, 1)), ('C', (2, 3, 4, 2)), ('D', (3, 7, 2, 1))]
    fills = ['#ffffff', '#b8b8b8', '#e2e2e2', '#111111']
    x0, y0 = 70, 250; unit = 15; bw = 46; gap = 26
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 320" font-family="sans-serif">']
    s.append(f'<line x1="{x0}" y1="20" x2="{x0}" y2="{y0}" stroke="#000"/><line x1="{x0}" y1="{y0}" x2="520" y2="{y0}" stroke="#000"/>')
    for v in range(0, 15, 2):
        yy = y0 - v * unit
        s.append(f'<line x1="{x0-4}" y1="{yy}" x2="{x0}" y2="{yy}" stroke="#000"/><text x="{x0-8}" y="{yy+4}" font-size="10" text-anchor="end">{v}</text>')
    x = x0 + gap
    for name, seg in data:
        yb = y0
        for val, col in zip(seg, fills):
            h = val * unit
            if val > 0:
                s.append(f'<rect x="{x}" y="{yb-h}" width="{bw}" height="{h}" fill="{col}" stroke="#000"/>')
            yb -= h
        s.append(f'<text x="{x+bw/2}" y="{y0+16}" font-size="12" text-anchor="middle">{name}</text>')
        x += bw + gap
    h = 12 * unit
    s.append(f'<rect x="{x}" y="{y0-h}" width="{bw}" height="{h}" fill="#ffffff" stroke="#000"/>')
    s.append(f'<text x="{x+bw/2}" y="{y0+16}" font-size="12" text-anchor="middle">E</text>')
    s.append(f'<text x="30" y="135" font-size="11" text-anchor="middle" transform="rotate(-90 30 135)">Počet nehod</text>')
    s.append('</svg>')
    return "".join(s)
SVG4 = _bars4()

# úloha 5: dvě váhy v rovnováze (schematicky)
SVG5 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 210" font-family="sans-serif">
<text x="20" y="20" font-size="12">1. váha (rovnovaha)</text>
<line x1="30" y1="60" x2="250" y2="60" stroke="#000" stroke-width="2"/>
<polygon points="140,60 132,88 148,88" fill="#999" stroke="#000"/>
<rect x="40" y="30" width="12" height="26" fill="#ccc" stroke="#000"/>
<rect x="56" y="30" width="12" height="26" fill="#ccc" stroke="#000"/>
<rect x="74" y="34" width="28" height="22" fill="#eee" stroke="#000"/>
<text x="88" y="49" font-size="11" text-anchor="middle">50 g</text>
<circle cx="180" cy="46" r="10" fill="none" stroke="#000"/>
<circle cx="205" cy="46" r="10" fill="none" stroke="#000"/>
<circle cx="230" cy="46" r="10" fill="none" stroke="#000"/>
<text x="20" y="130" font-size="12">2. váha (rovnovaha)</text>
<line x1="30" y1="170" x2="250" y2="170" stroke="#000" stroke-width="2"/>
<polygon points="140,170 132,198 148,198" fill="#999" stroke="#000"/>
<rect x="46" y="140" width="12" height="26" fill="#ccc" stroke="#000"/>
<rect x="66" y="144" width="28" height="22" fill="#eee" stroke="#000"/>
<text x="80" y="159" font-size="11" text-anchor="middle">70 g</text>
<circle cx="190" cy="156" r="10" fill="none" stroke="#000"/>
<circle cx="215" cy="156" r="10" fill="none" stroke="#000"/>
<text x="300" y="100" font-size="12">koule = kruh, valec = obdelnik</text>
</svg>"""

# úloha 6: jeden ze čtyř shodných trojúhelníků (strany 4, 13, 15 cm) – schematicky
SVG6 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 200" font-family="sans-serif">
<polygon points="40,160 300,160 360,60" fill="#d9d9d9" stroke="#000" stroke-width="2"/>
<text x="170" y="180" font-size="14" text-anchor="middle">13 cm</text>
<text x="342" y="118" font-size="14">4 cm</text>
<text x="150" y="100" font-size="14">15 cm</text>
<text x="40" y="30" font-size="12">Jeden ze ctyr shodnych trojuhelniku; obrazce A-D viz testovy sesit.</text>
</svg>"""

# úloha 7.1: výchozí obrázek – body P, S a přímka q
SVG7_1 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif">
<line x1="60" y1="250" x2="430" y2="150" stroke="#000" stroke-width="2"/>
<text x="436" y="150" font-size="16" font-style="italic">q</text>
<text x="330" y="150" font-size="15" text-anchor="middle">x</text>
<text x="330" y="138" font-size="15" text-anchor="middle" font-style="italic">S</text>
<text x="190" y="205" font-size="15" text-anchor="middle">x</text>
<text x="190" y="223" font-size="15" text-anchor="middle" font-style="italic">P</text>
</svg>"""

# úloha 7.2: výchozí obrázek – body A, T, V a přímka p procházející T, V
SVG7_2 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif">
<line x1="120" y1="70" x2="380" y2="250" stroke="#000" stroke-width="2"/>
<text x="384" y="264" font-size="16" font-style="italic">p</text>
<text x="150" y="95" font-size="15">x</text>
<text x="164" y="90" font-size="15" font-style="italic">V</text>
<text x="330" y="222" font-size="15">x</text>
<text x="344" y="217" font-size="15" font-style="italic">T</text>
<text x="215" y="250" font-size="15" text-anchor="middle">x</text>
<text x="215" y="268" font-size="15" text-anchor="middle" font-style="italic">A</text>
</svg>"""

# úloha 8: tři složité útvary v mřížové síti (schematická poznámka)
SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 170" font-family="sans-serif">
<rect x="10" y="24" width="540" height="120" fill="none" stroke="#ccc"/>
<text x="100" y="18" font-size="12" text-anchor="middle">1. utvar</text>
<text x="280" y="18" font-size="12" text-anchor="middle">2. utvar</text>
<text x="460" y="18" font-size="12" text-anchor="middle">3. utvar</text>
<text x="280" y="86" font-size="12" text-anchor="middle">Tri slozite utvary v mrizove siti (schematicky) - viz testovy sesit.</text>
<text x="280" y="110" font-size="11" text-anchor="middle" fill="#666">Osova soumernost se posuzuje podle originalu.</text>
</svg>"""

# úloha 13: prostorová tělesa slepená z krychlí (schematická poznámka)
SVG13 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 120" font-family="sans-serif">
<text x="280" y="52" font-size="13" text-anchor="middle">Telesa 13.1-13.3 slepena z krychli s otvory (smery P, B, H) - viz testovy sesit.</text>
<text x="280" y="80" font-size="11" text-anchor="middle" fill="#666">Prostorova telesa nelze verne prenest do SVG; posuzuje se podle originalu.</text>
</svg>"""

# úloha 14: pyramidy z 1..4 řad, střídají se tmavé a bílé řady
def _pyramids():
    cell = 16; base_y = 150
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 175" font-family="sans-serif">']
    ox = 20
    for k in range(1, 5):
        w = k * cell
        for row in range(1, k + 1):
            row_w = row * cell
            rx = ox + (w - row_w) / 2
            ry = base_y - (k - row + 1) * cell
            fill = '#9a9a9a' if row % 2 == 1 else '#ffffff'
            for cN in range(row):
                s.append(f'<rect x="{rx+cN*cell}" y="{ry}" width="{cell}" height="{cell}" fill="{fill}" stroke="#000"/>')
        ox += w + 26
    s.append(f'<text x="{ox+4}" y="{base_y-cell}" font-size="22">...</text>')
    s.append('</svg>')
    return "".join(s)
SVG14 = _pyramids()

B = ['zs1']  # 5. ročník ZŠ (přijímačky na osmileté obory)

PROBLEMS = [
    {'name': 'CERMAT M5A 2022 – úloha 1.1', 'zad': ['Vypočtěte: $(2\\cdot 243-18):(10\\cdot 165\\cdot 0+20:5)=$'], 'opts': None, 'ln': 2,
     'sol': ['Čitatel: $2\\cdot 243-18=486-18=468$. Jmenovatel: $10\\cdot 165\\cdot 0+20:5=0+4=4$. Podíl $468:4=117$.'],
     'ans': '$117$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2022 – úloha 1.2', 'zad': ['Vypočtěte: $4\\cdot(540-360)-(8\\cdot 180-5\\cdot 180)=$'], 'opts': None, 'ln': 2,
     'sol': ['$4\\cdot 180-(1440-900)=720-540=180$.'],
     'ans': '$180$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2022 – úloha 2', 'zad': [
        'Na číselné ose je zobrazeno devět bodů oddělujících osm stejných dílků. Body $A$, $B$, $C$, $D$ představují čtyři čísla. V bodě $C$ je číslo $48$, které je trojnásobkem čísla v bodě $B$.',
        '2.1 Určete číslo v bodě $A$.',
        '2.2 Určete číslo v bodě $D$.'],
     'opts': None, 'ln': 2, 'svg': SVG2, 'fn': 'osa.svg',
     'alt': 'Číselná osa s devíti body (osm stejných dílků); body A, B, C, D a nad bodem C číslo 48.',
     'cap': 'Číselná osa s body A, B, C, D',
     'sol': ['Bod $B$: $48:3=16$. Body $B$ a $C$ jsou od sebe dva dílky, takže jeden dílek $=(48-16):2=16$.',
             '2.1 Bod $A$ je o jeden dílek vlevo od $B$: $16-16=0$.',
             '2.2 Bod $D$ je o dva dílky vpravo od $C$: $48+2\\cdot 16=80$.'],
     'ans': '2.1: $0$; 2.2: $80$', 'pts': 4, 'mins': 4, 'diff': '2',
     'codes': B + ['aritmetika', 'porozumeni', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2022 – úloha 3.1', 'zad': [
        'Neznámé číslo je větší než 1. Když ho vynásobíme samo sebou, dostaneme číslo o 17 menší než devítinásobek čísla 9.',
        'Určete neznámé číslo.'],
     'opts': None, 'ln': 2,
     'sol': ['Devítinásobek čísla 9 je $9\\cdot 9=81$; o 17 méně je $81-17=64$. Hledáme číslo, jehož druhá mocnina je $64$, a které je větší než 1: $8\\cdot 8=64$, tedy číslo je $8$.'],
     'ans': '$8$', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2022 – úloha 3.2', 'zad': [
        'V každé bedýnce je 6 lahví se sirupem. Každá lahev obsahuje půl litru sirupu. Ve všech bedýnkách je celkem 321 litrů sirupu.',
        'Určete počet bedýnek se sirupem.'],
     'opts': None, 'ln': 2,
     'sol': ['V jedné bedýnce je $6\\cdot 0{,}5=3$ litry sirupu. Počet bedýnek $=321:3=107$.'],
     'ans': '$107$ bedýnek', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5A 2022 – úloha 4', 'zad': [
        'Graf udává počet nehod, k nimž došlo v obcích A, B, C, D v jednotlivých čtvrtletích loňského roku, a celoroční počet nehod v obci E. V obci E nebyla ve 4. čtvrtletí žádná nehoda, ve 2. čtvrtletí bylo dvakrát více nehod než v 1. čtvrtletí a ve 3. čtvrtletí byl stejný počet nehod jako v 1. čtvrtletí. (První pololetí se skládá z 1. a 2. čtvrtletí, druhé pololetí ze 3. a 4. čtvrtletí.)',
        '4.1 Určete celkový počet nehod, k nimž došlo ve 3. čtvrtletí v obcích A, B, C a D.',
        '4.2 Určete, o kolik nehod více se v prvním pololetí stalo v obci D než v obci A.',
        '4.3 Určete počet nehod, k nimž došlo ve 2. čtvrtletí v obci E.'],
     'opts': None, 'ln': 0, 'svg': SVG4, 'fn': 'graf-nehody.svg',
     'alt': 'Skládaný sloupcový graf počtu nehod v obcích A až D po čtvrtletích a celoroční sloupec obce E (celkem 12).',
     'cap': 'Schematický nákres grafu (součty a 3. čtvrtletí dle klíče)',
     'sol': ['4.1 Ve 3. čtvrtletí: A $3$, B $6$, C $4$, D $2$; celkem $3+6+4+2=15$ nehod.',
             '4.2 V 1. pololetí (1. a 2. čtvrtletí) měla obec A $3$ nehody a obec D $10$ nehod; rozdíl je $7$ nehod.',
             '4.3 Celoroční počet v obci E je $12$; při rozložení 1. čtvrtletí $=x$, 2. čtvrtletí $=2x$, 3. čtvrtletí $=x$, 4. čtvrtletí $=0$ platí $4x=12$, tedy $x=3$ a 2. čtvrtletí $=2\\cdot 3=6$ nehod.'],
     'ans': '4.1: $15$ nehod; 4.2: o $7$ nehod; 4.3: $6$ nehod', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['statistika', 'porozumeni', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5A 2022 – úloha 5', 'zad': [
        'Na miskách vah leží koule, válce a závaží; obě váhy jsou v rovnováze. Na první váze jsou dva válce a závaží $50$ g v rovnováze se třemi koulemi. Na druhé váze je jeden válec a závaží $70$ g v rovnováze se dvěma koulemi.',
        '5.1 Vypočtěte, kolik gramů váží jedna koule.',
        '5.2 Vypočtěte, kolik gramů váží jeden válec.'],
     'opts': None, 'ln': 2, 'svg': SVG5, 'fn': 'vahy.svg',
     'alt': 'Dvě rovnoramenné váhy v rovnováze: dva válce a závaží 50 g proti třem koulím; jeden válec a závaží 70 g proti dvěma koulím.',
     'cap': 'Schematický nákres dvou vah v rovnováze',
     'sol': ['Označme hmotnost jedné koule $k$ a jednoho válce $v$ (v gramech). První váha: $2v+50=3k$. Druhá váha: $v+70=2k$.',
             '5.1 Z druhé rovnice $v=2k-70$; dosazením do první $2(2k-70)+50=3k$, tj. $4k-90=3k$, odtud $k=90$ g.',
             '5.2 Válec: $v=2\\cdot 90-70=110$ g.'],
     'ans': '5.1: $90$ g; 5.2: $110$ g', 'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['rovnice', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5A 2022 – úloha 6', 'zad': [
        'Každý z obrazců A, B, C, D má obsah $96$ cm² a skládá se ze čtyř stejných trojúhelníků. V trojúhelníku mají dvě kratší strany délky $4$ cm a $13$ cm. Obvod obrazce B je o $4$ cm menší než obvod obrazce C.',
        '6.1 Vypočtěte v cm² obsah jednoho trojúhelníku.',
        '6.2 Vypočtěte v cm obvod obrazce A.',
        '6.3 Vypočtěte v cm obvod jednoho trojúhelníku.',
        '6.4 Vypočtěte v cm obvod obrazce D.'],
     'opts': None, 'ln': 0, 'svg': SVG6, 'fn': 'obrazce.svg',
     'alt': 'Jeden ze čtyř shodných trojúhelníků se stranami 4 cm, 13 cm a 15 cm; obrazce A–D jsou z těchto trojúhelníků složeny.',
     'cap': 'Schematický nákres trojúhelníku (obrazce A–D viz sešit)',
     'sol': ['6.1 Obsah jednoho trojúhelníku $=96:4=24$ cm².',
             '6.3 Trojúhelník má obsah $24$ cm² a dvě nejkratší strany $4$ cm a $13$ cm; třetí (nejdelší) strana je $15$ cm. Obvod jednoho trojúhelníku $=4+13+15=32$ cm.',
             '6.2 V obrazci A se do obvodu započítají jen strany na okraji (slepené strany se nepočítají); obvod obrazce A $=60$ cm.',
             '6.4 Obdobně obvod obrazce D $=46$ cm.'],
     'ans': '6.1: $24$ cm²; 6.2: $60$ cm; 6.3: $32$ cm; 6.4: $46$ cm', 'pts': 4, 'mins': 7, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2022 – úloha 7.1 (konstrukce)', 'zad': [
        'V rovině leží body $P$, $S$ a přímka $q$ (viz obrázek).',
        'Bod $P$ je vrchol trojúhelníku $PQR$. Na přímce $q$ leží vrchol $Q$ tohoto trojúhelníku. Vrcholy $P$ a $Q$ leží na téže kružnici se středem $S$. Bod $S$ je zároveň středem strany $QR$.',
        'Sestrojte vrcholy $Q$, $R$ trojúhelníku $PQR$, označte je písmeny a trojúhelník narýsujte. Najděte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG7_1, 'fn': 'primka-q.svg',
     'alt': 'Body P a S a přímka q v rovině.', 'cap': 'Výchozí obrázek k úloze 7.1',
     'sol': ['Sestrojíme kružnici se středem $S$ a poloměrem $|SP|$. Vrchol $Q$ je průsečík této kružnice s přímkou $q$; kružnici protíná ve dvou bodech $Q_1$, $Q_2$.',
             'Protože $S$ je střed strany $QR$, leží $R$ na polopřímce opačné k $SQ$ tak, že $|SR|=|SQ|$ (bod $R$ je obraz $Q$ ve středové souměrnosti se středem $S$). Úloha má dvě řešení.'],
     'ans': 'Dvě řešení. $Q$ je průsečík kružnice se středem $S$ a poloměrem $|SP|$ s přímkou $q$ ($Q_1$, $Q_2$); $R$ je souměrný s $Q$ podle středu $S$ (viz obrázek v klíči).',
     'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2022 – úloha 7.2 (konstrukce)', 'zad': [
        'V rovině leží body $A$, $T$, $V$ a přímka $p$ procházející body $T$, $V$ (viz obrázek).',
        'Bod $A$ je vrchol čtverce $ABCD$. Přímka $p$ protíná stranu $AB$ tohoto čtverce v bodě $T$ a stranu $CD$ v bodě $V$.',
        'Sestrojte vrcholy $B$, $C$, $D$ čtverce $ABCD$, označte je písmeny a čtverec narýsujte.'],
     'opts': None, 'ln': 0, 'svg': SVG7_2, 'fn': 'primka-p.svg',
     'alt': 'Body A, T, V a přímka p procházející body T a V.', 'cap': 'Výchozí obrázek k úloze 7.2',
     'sol': ['Strana $AB$ leží na přímce $AT$ (prochází body $A$ a $T$). Strana $CD$ je s ní rovnoběžná, prochází bodem $V$ a je od $AB$ vzdálena o délku strany čtverce.',
             'Délka strany čtverce $|AB|$ se proto rovná vzdálenosti bodu $V$ od přímky $AT$. Bod $B$ naneseme na polopřímku $AT$ v této vzdálenosti; ve vrcholech $A$ a $B$ vztyčíme kolmice k $AB$ a doplníme vrcholy $D$ a $C$ tak, aby $ABCD$ byl čtverec.'],
     'ans': 'Strana $AB$ leží na přímce $AT$ a její délka je rovna vzdálenosti bodu $V$ od přímky $AT$; kolmicemi v $A$ a $B$ doplníme vrcholy $B$, $C$, $D$ (viz obrázek v klíči).',
     'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2022 – úloha 8', 'zad': [
        'Ve čtvercové síti jsou zakresleny tři útvary (1., 2. a 3. útvar), jejichž vrcholy leží v mřížových bodech (viz obrázek).',
        'Rozhodněte o každém z útvarů 8.1–8.3, zda je osově souměrný (Ano), či nikoli (Ne).',
        '8.1 1. útvar',
        '8.2 2. útvar',
        '8.3 3. útvar'],
     'opts': None, 'ln': 0, 'svg': SVG8, 'fn': 'utvary.svg',
     'alt': 'Tři složité útvary ve čtvercové síti s vrcholy v mřížových bodech (schematická poznámka).',
     'cap': 'schematický nákres',
     'sol': ['8.1 První útvar má osu souměrnosti, je osově souměrný → Ano.',
             '8.2 Druhý útvar žádnou osu souměrnosti nemá → Ne.',
             '8.3 Třetí útvar žádnou osu souměrnosti nemá → Ne.'],
     'ans': '8.1: Ano; 8.2: Ne; 8.3: Ne', 'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['planimetrie', 'porozumeni', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2022 – úloha 9', 'zad': [
        'Petr šel z domova do sportovní haly. Každou pětinu cesty ušel za stejnou dobu. Když ušel první pětinu cesty od domova, jeho hodinky ukazovaly čas 14:54. Když mu k hale zbývala ještě pětina cesty, ukazovaly hodinky čas 15:12.',
        'Jaký čas ukazovaly Petrovy hodinky, když vycházel z domova?'],
     'opts': ['A) méně než 14:35', 'B) 14:35', 'C) 14:42', 'D) 14:48', 'E) více než 14:48'], 'ln': 0,
     'sol': ['Od konce první pětiny (14:54) do začátku poslední (páté) pětiny (15:12) uplynulo $18$ minut a Petr ušel tři pětiny cesty. Jedna pětina trvá $18:3=6$ minut. Z domova vyšel o $6$ minut dříve než ve 14:54, tedy ve 14:48.'],
     'ans': 'D) 14:48', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5A 2022 – úloha 10', 'zad': [
        'Všechny děti z oddílu se rozdělily do čtyřčlenných hlídek. V každé hlídce byla jediná dívka. V oddílu je celkem 36 chlapců.',
        'Kolik dětí je v oddílu?'],
     'opts': ['A) 48 dětí', 'B) 45 dětí', 'C) 42 dětí', 'D) 40 dětí', 'E) jiný počet dětí'], 'ln': 0,
     'sol': ['V každé čtyřčlenné hlídce je $1$ dívka a $3$ chlapci. Počet hlídek $=36:3=12$. Dětí celkem $=12\\cdot 4=48$.'],
     'ans': 'A) 48 dětí', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5A 2022 – úloha 11', 'zad': [
        'Na Dračí horu přiletěli dvouhlaví a tříhlaví draci. Dohromady měli 115 hlav. Dvouhlavých draků přiletělo o 35 více než tříhlavých.',
        'Kolik draků přiletělo na Dračí horu?'],
     'opts': ['A) 53 draků', 'B) 50 draků', 'C) 44 draků', 'D) 40 draků', 'E) jiný počet draků'], 'ln': 0,
     'sol': ['Nechť tříhlavých draků je $t$, dvouhlavých $t+35$. Počet hlav: $2(t+35)+3t=115$, tj. $5t+70=115$, odtud $t=9$. Draků celkem $=9+(9+35)=9+44=53$.'],
     'ans': 'A) 53 draků', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['rovnice', 'modelovani', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2022 – úloha 12', 'zad': [
        'Na stadionu se konalo hromadné vystoupení dětí. Cvičil stejný počet děvčat i chlapců. Na začátku vystoupení všechna děvčata vytvořila devítičlenné skupiny a všichni chlapci šestičlenné skupiny. Děvčata vytvořila o 30 skupin méně než chlapci.',
        'Kolik skupin vytvořily na začátku vystoupení všechny děti?'],
     'opts': ['A) méně než 70 skupin', 'B) 70 skupin', 'C) 90 skupin', 'D) 150 skupin', 'E) více než 150 skupin'], 'ln': 0,
     'sol': ['Počet děvčat i chlapců označme $n$. Skupin děvčat je $\\frac{n}{9}$, skupin chlapců $\\frac{n}{6}$. Platí $\\frac{n}{6}-\\frac{n}{9}=30$, tj. $\\frac{n}{18}=30$, odtud $n=540$. Skupin celkem $=\\frac{540}{9}+\\frac{540}{6}=60+90=150$.'],
     'ans': 'D) 150 skupin', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['rovnice', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5A 2022 – úloha 13', 'zad': [
        'Ze stejných kostek tvaru krychle se slepují tělesa. Skrz každou kostku je provrtaný jeden otvor. Kostky mohou být otočeny třemi směry: otvor směřuje zepředu dozadu ($P$), z boku na druhý bok ($B$), nebo shora dolů ($H$). Otvory jsou vyznačeny dvěma způsoby: světlé otvory vedou skrz naskrz celým tělesem, tmavé otvory jsou uvnitř tělesa uzavřeny jinou kostkou. V ukázkovém tělese jsou $2$ kostky ve směru $P$, $1$ kostka ve směru $B$ a $2$ kostky ve směru $H$.',
        'Přiřaďte ke každému tělesu (13.1–13.3) počty kostek otočených v daném směru (A–F). Tělesa 13.1, 13.2, 13.3 viz testový sešit.'],
     'opts': ['A) $1P + 3B + 2H$', 'B) $1P + 2B + 3H$', 'C) $2P + 2B + 2H$', 'D) $2P + 1B + 3H$', 'E) $3P + 1B + 2H$', 'F) jiné počty'], 'ln': 0,
     'svg': SVG13, 'fn': 'kostky.svg',
     'alt': 'Tři prostorová tělesa slepená z krychlí s otvory ve směrech P, B, H (schematická poznámka).',
     'cap': 'schematický nákres',
     'sol': ['13.1 → E ($3P + 1B + 2H$).', '13.2 → C ($2P + 2B + 2H$).', '13.3 → B ($1P + 2B + 3H$).'],
     'ans': '13.1: E ($3P + 1B + 2H$); 13.2: C ($2P + 2B + 2H$); 13.3: B ($1P + 2B + 3H$)', 'pts': 5, 'mins': 6, 'diff': '4',
     'codes': B + ['stereometrie', 'porozumeni', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2022 – úloha 14', 'zad': [
        'Pyramida se skládá ze shodných čtverců. Horní řadu tvoří vždy jeden tmavý čtverec. V pyramidě s více než jedním čtvercem se pravidelně střídají řady s tmavými a řady s bílými čtverci. Každá další řada má vždy o $1$ čtverec více než řada nad ní (viz obrázek).',
        '14.1 Pyramida má $10$ řad. Určete, o kolik se liší počet tmavých a bílých čtverců v pyramidě.',
        '14.2 Pyramida má $73$ řad. Určete, o kolik se liší počet tmavých a bílých čtverců v pyramidě.',
        '14.3 V pyramidě je o $101$ bílých čtverců méně než tmavých čtverců. Určete, kolik řad má pyramida.'],
     'opts': None, 'ln': 3, 'svg': SVG14, 'fn': 'pyramida.svg',
     'alt': 'Pyramidy z 1, 2, 3 a 4 řad shodných čtverců; liché řady jsou tmavé, sudé bílé, každá řada má o jeden čtverec více.',
     'cap': 'Pyramidy z 1 až 4 řad',
     'sol': ['V $n$-té řadě (shora) je $n$ čtverců; liché řady jsou tmavé, sudé bílé.',
             '14.1 Pro $10$ řad: tmavé $1+3+5+7+9=25$, bílé $2+4+6+8+10=30$; liší se o $5$ čtverců.',
             '14.2 Pro $73$ řad: tmavých $1+3+\\dots+73=37^2=1369$, bílých $2+4+\\dots+72=36\\cdot 37=1332$; liší se o $37$ čtverců.',
             '14.3 Při lichém počtu řad $R$ převažují tmavé čtverce o $\\frac{R+1}{2}$. Z rovnice $\\frac{R+1}{2}=101$ plyne $R=201$ řad.'],
     'ans': '14.1: o $5$ čtverců; 14.2: o $37$ čtverců; 14.3: $201$ řad', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['posloupnosti', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M5PAD22C0T01'
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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M5A-2022')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
