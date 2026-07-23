# -*- coding: utf-8 -*-
# CERMAT – Jednotná přijímací zkouška 2021, MATEMATIKA 5 C (osmileté obory, 5. ročník),
# 1. náhradní termín. Kód testu: M5PCD21C0T03.
# 14 úloh (po rozdělení izolovaných poduúloh 17 záznamů).
# Zdroj odpovědí: klíč správných řešení (KSR); ověřeno vůči záznamovému archu (VZA).

# ---- SVG obrázky (bez ' a \) ----

# úloha 6: Obrazec A (dům s komínem) a Obrazec B (svah se zuby) – schematicky
SVG6 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 250" font-family="sans-serif">
<text x="150" y="22" font-size="15" text-anchor="middle">Obrazec A</text>
<polygon points="150,45 250,150 50,150" fill="none" stroke="#000" stroke-width="2"/>
<rect x="215" y="70" width="28" height="80" fill="none" stroke="#000" stroke-width="2"/>
<line x1="215" y1="97" x2="243" y2="97" stroke="#000"/>
<line x1="215" y1="124" x2="243" y2="124" stroke="#000"/>
<rect x="115" y="150" width="70" height="82" fill="none" stroke="#000" stroke-width="2"/>
<text x="470" y="22" font-size="15" text-anchor="middle">Obrazec B</text>
<polygon points="360,215 360,150 378,150 378,132 396,132 396,150 420,150 420,132 438,132 438,150 462,150 600,215" fill="none" stroke="#000" stroke-width="2"/>
<rect x="470" y="120" width="26" height="26" fill="none" stroke="#000" stroke-width="1"/>
<line x1="470" y1="120" x2="496" y2="146" stroke="#000"/>
<text x="483" y="112" font-size="11" text-anchor="middle">malý čtverec</text>
</svg>"""

# úloha 7.1: body A, S a přímka p procházející bodem S
SVG7_1 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 300" font-family="sans-serif">
<line x1="60" y1="200" x2="470" y2="80" stroke="#000" stroke-width="2"/>
<text x="46" y="206" font-size="16" font-style="italic">p</text>
<line x1="294" y1="126" x2="306" y2="134" stroke="#000" stroke-width="1"/>
<text x="306" y="120" font-size="15" font-style="italic">S</text>
<line x1="244" y1="244" x2="256" y2="256" stroke="#000" stroke-width="2"/>
<line x1="256" y1="244" x2="244" y2="256" stroke="#000" stroke-width="2"/>
<text x="247" y="272" font-size="15" font-style="italic">A</text>
</svg>"""

# úloha 7.2: bod K a přímky a, b
SVG7_2 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 380" font-family="sans-serif">
<line x1="150" y1="150" x2="540" y2="92" stroke="#000" stroke-width="2"/>
<text x="132" y="150" font-size="16" font-style="italic">a</text>
<line x1="120" y1="118" x2="452" y2="360" stroke="#000" stroke-width="2"/>
<text x="104" y="150" font-size="16" font-style="italic">b</text>
<line x1="424" y1="184" x2="436" y2="196" stroke="#000" stroke-width="2"/>
<line x1="436" y1="184" x2="424" y2="196" stroke="#000" stroke-width="2"/>
<text x="440" y="206" font-size="15" font-style="italic">K</text>
</svg>"""

# úlohy 9 a 10: sloupcový graf cen bylin A:B:C = 4:5:7 (skutečné ceny neuvedeny)
def _graf():
    ox, oy, top = 70, 290, 40
    u = 20  # 1 jednotka
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 340" font-family="sans-serif">']
    s.append('<text x="70" y="28" font-size="14">Ceny bylin za 1 kg</text>')
    for v in range(2, 13, 2):
        y = oy - v * u
        s.append(f'<line x1="{ox}" y1="{y}" x2="380" y2="{y}" stroke="#bbb" stroke-width="1"/>')
    s.append(f'<line x1="{ox}" y1="{top}" x2="{ox}" y2="{oy}" stroke="#000" stroke-width="2"/>')
    s.append(f'<line x1="{ox}" y1="{oy}" x2="380" y2="{oy}" stroke="#000" stroke-width="2"/>')
    s.append(f'<text x="58" y="296" font-size="14">0</text>')
    for name, cx, val in (('A', 140, 4), ('B', 220, 5), ('C', 300, 7)):
        h = val * u
        s.append(f'<rect x="{cx-22}" y="{oy-h}" width="44" height="{h}" fill="#4d4d4d" stroke="#000"/>')
        s.append(f'<text x="{cx}" y="310" font-size="14" text-anchor="middle">{name}</text>')
    s.append('<text x="200" y="332" font-size="13" text-anchor="middle">Druh bylin</text>')
    s.append('</svg>')
    return "".join(s)
SVGgraf = _graf()

# úloha 12: ornament v čtvercové síti 9x9 (X = tmavý čtverec), s písmeny A–E
def _orn():
    grid = [
        "....X....",
        "..X.X.X..",
        ".X.X.X.X.",
        "...X.XX..",
        "XX..X..XX",
        "..XX.XX..",
        ".X.X.X.X.",
        "..X.X.X..",
        "....X....",
    ]
    labels = {(2, 3): 'B', (3, 6): 'C', (5, 2): 'A', (5, 6): 'D', (6, 5): 'E'}
    cell, ox, oy = 24, 12, 12
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 240 240" font-family="sans-serif">']
    for r in range(9):
        for c in range(9):
            x, y = ox + c * cell, oy + r * cell
            if grid[r][c] == 'X':
                s.append(f'<rect x="{x}" y="{y}" width="{cell}" height="{cell}" fill="#808080"/>')
            if (r, c) in labels:
                s.append(f'<text x="{x+cell/2}" y="{y+cell/2+5}" font-size="14" fill="#fff" text-anchor="middle">{labels[(r,c)]}</text>')
    for i in range(10):
        s.append(f'<line x1="{ox+i*cell}" y1="{oy}" x2="{ox+i*cell}" y2="{oy+9*cell}" stroke="#000" stroke-width="1.5"/>')
        s.append(f'<line x1="{ox}" y1="{oy+i*cell}" x2="{ox+9*cell}" y2="{oy+i*cell}" stroke="#000" stroke-width="1.5"/>')
    s.append('</svg>')
    return "".join(s)
SVGorn = _orn()

# úloha 13: tři nákresy staveb z krychliček – schematická poznámka
SVG13 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 150" font-family="sans-serif">
<text x="90" y="20" font-size="13" text-anchor="middle">Nákres 1</text>
<text x="280" y="20" font-size="13" text-anchor="middle">Nákres 2</text>
<text x="470" y="20" font-size="13" text-anchor="middle">Nákres 3</text>
<rect x="40" y="40" width="100" height="60" fill="#e6e6e6" stroke="#000"/>
<rect x="40" y="80" width="100" height="20" fill="#cccccc" stroke="#000"/>
<rect x="230" y="48" width="100" height="52" fill="#e6e6e6" stroke="#000"/>
<rect x="230" y="80" width="100" height="20" fill="#cccccc" stroke="#000"/>
<rect x="420" y="56" width="100" height="44" fill="#e6e6e6" stroke="#000"/>
<rect x="420" y="80" width="100" height="20" fill="#cccccc" stroke="#000"/>
<text x="90" y="118" font-size="12" text-anchor="middle">Klára</text>
<text x="280" y="118" font-size="12" text-anchor="middle">Mirek</text>
<text x="470" y="118" font-size="12" text-anchor="middle">Nora</text>
<text x="280" y="142" font-size="11" text-anchor="middle" fill="#666">Prostorové stavby z krychliček (schematicky) – posuzuje se podle originálu.</text>
</svg>"""

# úloha 14: tři nejmenší trojúhelníkové obrazce z tmavých šestiúhelníků (schematicky)
def _hex(cx, cy, r):
    a = 0.866 * r
    pts = f'{cx},{cy-r} {cx-a},{cy-r/2} {cx-a},{cy+r/2} {cx},{cy+r} {cx+a},{cy+r/2} {cx+a},{cy-r/2}'
    return f'<polygon points="{pts}" fill="#9a9a9a" stroke="#000" stroke-width="1"/>'

def _fig(n, ox, oy):
    rH, dx, dy = 15, 38, 36
    out = []
    halfW = (n - 1) / 2 * dx + rH + 12
    topY = oy - rH - 6
    apexY = topY + halfW * 1.9
    out.append(f'<polygon points="{ox-halfW},{topY} {ox+halfW},{topY} {ox},{apexY}" fill="none" stroke="#000" stroke-width="2"/>')
    R = 2 * n + 1
    for L in range(1, n + 1):
        cnt = n - L + 1
        y = oy + (L - 1) * dy
        for i in range(cnt):
            x = ox + (i - (cnt - 1) / 2) * dx
            out.append(_hex(x, y, rH))
    for row in range(1, R + 1):
        f = (row - 0.5) / R
        lx = ox + (ox - halfW - ox) * f
        ly = apexY + (topY - apexY) * f
        out.append(f'<text x="{lx-14}" y="{ly+4}" font-size="11" text-anchor="middle">{row}.</text>')
    return out

def _troj():
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 230" font-family="sans-serif">']
    s += _fig(1, 90, 55)
    s += _fig(2, 240, 55)
    s += _fig(3, 430, 55)
    s.append('<text x="590" y="120" font-size="20">…</text>')
    s.append('</svg>')
    return "".join(s)
SVGtroj = _troj()

B = ['zs1']  # 5. ročník ZŠ (přijímačky na osmileté obory); kód r5 v taxonomii není

PROBLEMS = [
    {'name': 'CERMAT M5C 2021 – úloha 1.1',
     'zad': ['Doplňte do rámečku takové číslo, aby platila rovnost:',
             '$6\\,200-1\\,550:5=\\square+10$'],
     'opts': None, 'ln': 2,
     'sol': ['$6\\,200-1\\,550:5=6\\,200-310=5\\,890$. Musí platit $5\\,890=\\square+10$, tedy do rámečku patří $5\\,880$.'],
     'ans': '$5\\,880$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5C 2021 – úloha 1.2',
     'zad': ['Doplňte do rámečku takové číslo, aby platila rovnost:',
             '$\\square\\cdot 2=3\\,050+240\\cdot 4$'],
     'opts': None, 'ln': 2,
     'sol': ['Pravá strana: $3\\,050+240\\cdot 4=3\\,050+960=4\\,010$. Z $\\square\\cdot 2=4\\,010$ plyne, že do rámečku patří $2\\,005$.'],
     'ans': '$2\\,005$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5C 2021 – úloha 2.1',
     'zad': ['Myslím si celé číslo, které je větší než $20$ a menší než $25$. Když k němu přičtu trojnásobek jiného celého čísla, dostanu $90$.',
             'Určete, které číslo si mohu myslet. Uveďte všechna řešení.'],
     'opts': None, 'ln': 2,
     'sol': ['Hledané číslo $n$ je z $\\{21,22,23,24\\}$ a platí $n+3k=90$ pro celé $k$, tj. rozdíl $90-n$ musí být dělitelný $3$. To splňují $n=21$ (pak $3k=69$) a $n=24$ (pak $3k=66$).'],
     'ans': '$21$; $24$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5C 2021 – úloha 2.2',
     'zad': ['Do prázdné mísy jsme dali máslo o hmotnosti $120$ g a přidali mouku a cukr. Suroviny v míse váží dohromady půl kilogramu. Cukru je v míse o $80$ g méně než mouky.',
             'Vypočtěte, kolik gramů mouky je v míse.'],
     'opts': None, 'ln': 2,
     'sol': ['Mouka a cukr váží $500-120=380$ g. Je-li mouky $m$ gramů, je cukru $m-80$ gramů, tedy $m+(m-80)=380$, odtud $2m=460$ a $m=230$ g (cukru je pak $150$ g).'],
     'ans': '$230$ g', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5C 2021 – úloha 3',
     'zad': ['Dvě rekreační plavkyně Jana s Květou byly společně plavat. Každá uplavala $25$ bazénů. Obě začaly plavat současně a každá plavala svým stále stejným tempem. Jana uplavala $5$ bazénů za $7$ minut. Květa uplavala $10$ bazénů za čtvrt hodiny.',
             '3.1 Vypočtěte, o kolik sekund se lišily časy obou plavkyň na první obrátce (tj. po uplavání prvního bazénu).',
             '3.2 Určete, za jak dlouho uplavala $25$ bazénů pomalejší plavkyně. (Čas uveďte v minutách a sekundách, např. $5$ min $12$ s.)'],
     'opts': None, 'ln': 3,
     'sol': ['Jana uplave $1$ bazén za $7:5=1{,}4$ min $=84$ s, Květa za $15:10=1{,}5$ min $=90$ s.',
             '3.1 Rozdíl časů na první obrátce je $90-84=6$ s.',
             '3.2 Pomalejší je Květa; $25$ bazénů uplave za $25\\cdot 90=2\\,250$ s $=37$ min $30$ s.'],
     'ans': '3.1: o $6$ sekund; 3.2: $37$ min $30$ s', 'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5C 2021 – úloha 4',
     'zad': ['Lukáš vyhrál nad Matějem $20$ kuliček, ale pak někde $14$ kuliček ztratil. Potom přišla Karla, která měla $90$ kuliček. Když pětinu z nich rozdělila rovným dílem mezi oba chlapce, měli všichni tři stejný počet kuliček.',
             '4.1 Vypočtěte, kolik kuliček zbylo Karle.',
             '4.2 Vypočtěte, kolik kuliček měl Lukáš před výhrou nad Matějem.',
             '4.3 Vypočtěte, kolik kuliček měl Matěj před prohrou s Lukášem.'],
     'opts': None, 'ln': 3,
     'sol': ['Karla rozdělila pětinu z $90$, tj. $18$ kuliček (po $9$ každému chlapci), a zbylo jí $90-18=72$. Po rozdělení mají všichni tři po $72$ kuličkách.',
             '4.1 Karle zbylo $72$ kuliček.',
             '4.2 Lukáš: $x+20-14+9=72\\Rightarrow x=57$ kuliček před výhrou.',
             '4.3 Matěj: $y-20+9=72\\Rightarrow y=83$ kuliček před prohrou.'],
     'ans': '4.1: $72$ kuliček; 4.2: $57$ kuliček; 4.3: $83$ kuliček', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5C 2021 – úloha 5',
     'zad': ['$5$ talířků a $2$ hrnky váží stejně jako $2$ mísy. $1$ mísa váží stejně jako $3$ hrnky.',
             '5.1 Vypočtěte, kolik talířků váží stejně jako $4$ hrnky.',
             '5.2 Vypočtěte, kolik talířků váží stejně jako $4$ mísy.'],
     'opts': None, 'ln': 2,
     'sol': ['Z $1$ mísa $=3$ hrnky plyne $2$ mísy $=6$ hrnků. Pak $5$ talířků $+2$ hrnky $=6$ hrnků, tedy $5$ talířků $=4$ hrnky.',
             '5.1 $4$ hrnky $=5$ talířků.',
             '5.2 $4$ mísy $=12$ hrnků $=3\\cdot(4$ hrnky$)=3\\cdot 5=15$ talířků.'],
     'ans': '5.1: $5$ talířků; 5.2: $15$ talířků', 'pts': 3, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5C 2021 – úloha 6',
     'zad': ['Na vytvoření obrazce můžeme použít velké a malé čtverce a trojúhelníky. Malý čtverec má obsah $4$ cm². Velký čtverec lze složit z $9$ malých čtverců. Trojúhelníky získáme rozstřižením malého nebo velkého čtverce na dvě poloviny.',
             '6.1 Vypočtěte v cm² obsah obrazce A.',
             '6.2 Vypočtěte v cm² obsah obrazce B.'],
     'opts': None, 'ln': 2, 'svg': SVG6, 'fn': 'obrazce-ab.svg',
     'alt': 'Obrazec A ve tvaru domku s komínem a obrazec B ve tvaru svahu se zuby, sestavené z čtverců a trojúhelníků (schematicky).',
     'cap': 'Obrazec A a obrazec B',
     'sol': ['Malý čtverec má $4$ cm², velký $9\\cdot 4=36$ cm²; jejich poloviny (trojúhelníky) mají $2$ cm², resp. $18$ cm². Součtem obsahů použitých dílů:',
             '6.1 Obrazec A má obsah $82$ cm².',
             '6.2 Obrazec B má obsah $104$ cm².'],
     'ans': '6.1: $82$ cm²; 6.2: $104$ cm²', 'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5C 2021 – úloha 7.1 (konstrukce)',
     'zad': ['V rovině leží body $A$, $S$ a přímka $p$ procházející bodem $S$ (viz obrázek).',
             'Bod $A$ je vrchol trojúhelníku $ABC$, jehož strana $AC$ měří $4$ cm. Oba vrcholy $B$, $C$ tohoto trojúhelníku leží na přímce $p$. Bod $S$ je střed strany $BC$.',
             'Sestrojte vrcholy $B$, $C$ trojúhelníku $ABC$, označte je písmeny a trojúhelník narýsujte. Najděte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG7_1, 'fn': 'body-a-s-p.svg',
     'alt': 'Bod A, bod S a přímka p procházející bodem S; A leží pod přímkou p.',
     'cap': 'Výchozí obrázek k úloze 7.1',
     'sol': ['Vrchol $C$ leží na přímce $p$ a zároveň na kružnici se středem $A$ a poloměrem $4$ cm — to dává dvě polohy $C_1$, $C_2$. Bod $B$ je obrazem $C$ ve středové souměrnosti se středem $S$ (protože $S$ je střed $BC$). Vzniknou dva trojúhelníky $ABC$.'],
     'ans': 'Dvě řešení: $C$ je průsečík přímky $p$ s kružnicí se středem $A$ a poloměrem $4$ cm; bod $B$ je obrazem bodu $C$ ve středové souměrnosti se středem $S$ (viz obrázek v klíči).',
     'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5C 2021 – úloha 7.2 (konstrukce)',
     'zad': ['V rovině leží bod $K$ a přímky $a$, $b$ (viz obrázek).',
             'Bod $K$ je vrchol obdélníku $KLMN$. Jedna strana tohoto obdélníku leží na některé z přímek $a$, $b$ a zbývající vrchol obdélníku leží na druhé z těchto přímek.',
             'Sestrojte vrcholy $L$, $M$, $N$ obdélníku $KLMN$, označte je písmeny a obdélník narýsujte. Najděte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG7_2, 'fn': 'primky-a-b-k.svg',
     'alt': 'Bod K a dvě různoběžné přímky a, b; bod K leží mimo obě přímky.',
     'cap': 'Výchozí obrázek k úloze 7.2',
     'sol': ['Jedna strana obdélníku leží na jedné z přímek a zbývající vrchol leží na druhé přímce. Podle toho, na které z přímek $a$, $b$ leží strana obdélníku, vzniknou dvě řešení $KLMN$ (sestrojí se kolmice z bodů a přenesou odpovídající vzdálenosti).'],
     'ans': 'Dvě řešení: obdélník $KLMN$ s jednou stranou na jedné z přímek $a$, $b$ a čtvrtým vrcholem na druhé přímce (viz obrázek v klíči).',
     'pts': 3, 'mins': 6, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5C 2021 – úloha 8',
     'zad': ['Děti sbírají kartičky pokémonů. Petr má $12$ kartiček a Pavel má o $\\frac{1}{3}$ kartiček více než Petr. Marek má o $\\frac{1}{8}$ kartiček více než Nela. Počty kartiček Marka a Nely se liší o $6$. Alice má $45$ kartiček a Bára $30$ kartiček.',
             'Rozhodněte o každém z následujících tvrzení (8.1–8.3), zda je pravdivé (A), či nikoli (N).',
             '8.1 Petr a Pavel mají dohromady méně než $28$ kartiček.',
             '8.2 Marek má $54$ kartiček.',
             '8.3 Alice má o jednu třetinu kartiček více než Bára.'],
     'opts': None, 'ln': 0,
     'sol': ['Pavel $=12+\\frac{1}{3}\\cdot 12=16$; z rozdílu $6$ ($=\\frac{1}{8}$ Nely) je Nela $=48$ a Marek $=54$.',
             '8.1 $12+16=28$, což není méně než $28$ → Ne.',
             '8.2 Marek má $54$ kartiček → Ano.',
             '8.3 O třetinu více než Bára je $30+10=40\\ne 45$ → Ne.'],
     'ans': '8.1: Ne; 8.2: Ano; 8.3: Ne', 'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5C 2021 – úloha 9',
     'zad': ['Farma vykupuje tři druhy léčivých bylin A, B, C. Výkupní cenu za $1$ kg každé z bylin znázorňuje graf, i když skutečná cena v korunách není uvedena.',
             'Vedoucí skautského oddílu nasbírala $2$ kg byliny A a $1$ kg byliny B. Za nasbírané byliny A dostala o $60$ korun více než za byliny B.',
             'Kolik korun celkem dostala vedoucí za nasbírané byliny?'],
     'opts': ['A) $130$ korun', 'B) $195$ korun', 'C) $260$ korun', 'D) $390$ korun', 'E) více než $390$ korun'],
     'ln': 0, 'svg': SVGgraf, 'fn': 'graf-byliny.svg',
     'alt': 'Sloupcový graf výkupních cen bylin A, B, C za 1 kg; sloupce v poměru výšek 4 : 5 : 7.',
     'cap': 'Ceny bylin za 1 kg',
     'sol': ['Z grafu jsou ceny v poměru A : B : C $=4:5:7$. Označme jednotku $j$: $2\\cdot 4j-1\\cdot 5j=3j=60$ Kč, tedy $j=20$ Kč. Celkem $2\\cdot 4j+5j=13j=13\\cdot 20=260$ Kč.'],
     'ans': 'C) $260$ korun', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['statistika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5C 2021 – úloha 10',
     'zad': ['Farma vykupuje tři druhy léčivých bylin A, B, C. Výkupní cenu za $1$ kg každé z bylin znázorňuje graf, i když skutečná cena v korunách není uvedena.',
             'Chlapci ze skautského oddílu nasbírali $14$ kg byliny B, dívky sbíraly bylinu C. Dívky dostaly za nasbírané byliny stejnou částku jako chlapci.',
             'Kolik kg byliny C nasbíraly dívky?'],
     'opts': ['A) $5$ kg', 'B) $7$ kg', 'C) $8$ kg', 'D) $9$ kg', 'E) $10$ kg'],
     'ln': 0, 'svg': SVGgraf, 'fn': 'graf-byliny.svg',
     'alt': 'Sloupcový graf výkupních cen bylin A, B, C za 1 kg; sloupce v poměru výšek 4 : 5 : 7.',
     'cap': 'Ceny bylin za 1 kg',
     'sol': ['Z grafu je poměr výkupních cen B : C $=5:7$. Za stejnou částku platí $14\\cdot 5=x\\cdot 7$ (množství je nepřímo úměrné ceně), tedy $x=\\frac{14\\cdot 5}{7}=10$ kg.'],
     'ans': 'E) $10$ kg', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['statistika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5C 2021 – úloha 11',
     'zad': ['Na táboře dostalo ke svačině každé mladší dítě $1$ housku a každé starší dítě $3$ housky. Ke svačině tak všem $70$ dětem rozdali celkem $100$ housek.',
             'O kolik více bylo na táboře mladších dětí než starších dětí?'],
     'opts': ['A) o $10$', 'B) o $20$', 'C) o $30$', 'D) o $40$', 'E) o $50$'],
     'ln': 0,
     'sol': ['Označme $m$ mladších a $s$ starších dětí: $m+s=70$ a $m+3s=100$. Odečtením $2s=30$, tedy $s=15$ a $m=55$. Mladších je o $55-15=40$ více.'],
     'ans': 'D) o $40$', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5C 2021 – úloha 12',
     'zad': ['Do čtvercové sítě jsme naskládali tmavé čtverce, a vytvořili tak ornament, který není souměrný podle žádné osy. Některé čtverce jsou označeny písmeny (viz obrázek).',
             'Odebráním jednoho ze čtverců A, B, C, D, nebo E vytvoříme nový ornament. Nový ornament buď je, nebo není souměrný podle některé osy (svislé, vodorovné nebo šikmé).',
             'Který z označených čtverců odebereme, aby ani nový ornament nebyl souměrný podle žádné osy?'],
     'opts': ['A) čtverec A', 'B) čtverec B', 'C) čtverec C', 'D) čtverec D', 'E) čtverec E'],
     'ln': 0, 'svg': SVGorn, 'fn': 'ornament.svg',
     'alt': 'Ornament z tmavých čtverců v síti 9 krát 9, pět čtverců je označeno písmeny A až E.',
     'cap': 'Ornament v čtvercové síti',
     'sol': ['Odebráním čtverce $D$ zůstane ornament, který stále není souměrný podle žádné osy (svislé, vodorovné ani šikmé). U ostatních čtverců by nový ornament některou osu souměrnosti získal.'],
     'ans': 'D) čtverec $D$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['planimetrie', 'porozumeni', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5C 2021 – úloha 13',
     'zad': ['Na podložce byla ze stejných krychliček postavena velká krychle, která měla $4$ vrstvy po $16$ krychličkách. Klára odebrala z velké krychle několik krychliček, aby vytvořila stavbu podle nákresu 1. Mirek odebral z Klářiny stavby několik krychliček, aby vytvořil stavbu podle nákresu 2. Nora odebrala z Mirkovy stavby několik krychliček, aby vytvořila stavbu podle nákresu 3. (Děti krychličky pouze odebíraly, s ostatními krychličkami nehýbaly.)',
             'Přiřaďte ke každé otázce (13.1–13.3) správnou odpověď (A–F).',
             '13.1 Kolik krychliček odebrala Klára z velké krychle?',
             '13.2 Kolik nejvíce krychliček mohl Mirek odebrat z Klářiny stavby?',
             '13.3 Kolik nejméně krychliček musela Nora odebrat z Mirkovy stavby?'],
     'opts': ['A) $7$', 'B) $6$', 'C) $5$', 'D) $4$', 'E) $3$', 'F) jiný počet'],
     'ln': 0, 'svg': SVG13, 'fn': 'krychle-nakresy.svg',
     'alt': 'Tři nákresy postupně zmenšovaných staveb z krychliček (Klára, Mirek, Nora) – schematicky.',
     'cap': 'Nákres 1, 2 a 3 (schematicky)',
     'sol': ['Velká krychle má $4\\cdot 16=64$ krychliček; z porovnání nákresů:',
             '13.1 Klára odebrala $7$ krychliček → A.',
             '13.2 Mirek mohl odebrat nejvíce $5$ krychliček → C.',
             '13.3 Nora musela odebrat nejméně $6$ krychliček → B.'],
     'ans': '13.1: A ($7$); 13.2: C ($5$); 13.3: B ($6$)', 'pts': 5, 'mins': 5, 'diff': '3',
     'codes': B + ['stereometrie', 'porozumeni', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5C 2021 – úloha 14',
     'zad': ['Trojúhelníkové obrazce se podle vzoru sestavují z tmavých šestiúhelníků a bílých trojúhelníků. Šestiúhelník se skládá ze $6$ shodných tmavých trojúhelníků. Na obrázku jsou tři nejmenší trojúhelníkové obrazce. Jednotlivé řady obrazce jsou očíslovány vždy od nejkratší po nejdelší.',
             'Obrazec má $19$ řad. Určete počet:',
             '14.1 bílých trojúhelníků v 9. řadě.',
             '14.2 tmavých trojúhelníků v 16. řadě.',
             '14.3 tmavých šestiúhelníků v celém obrazci.'],
     'opts': None, 'ln': 3, 'svg': SVGtroj, 'fn': 'trojuhelniky.svg',
     'alt': 'Tři nejmenší trojúhelníkové obrazce z tmavých šestiúhelníků uspořádaných do trojúhelníku, řady číslované od nejkratší.',
     'cap': '1., 2. a 3. nejmenší obrazec',
     'sol': ['V $k$-té řadě je $2k-1$ malých trojúhelníků. Bílých je pro lichou řadu $\\frac{k+1}{2}$, pro sudou řadu $\\frac{k-2}{2}$; tmavých je zbytek, tj. pro lichou $\\frac{3(k-1)}{2}$ a pro sudou $\\frac{3k}{2}$.',
             '14.1 Řada $9$ (lichá): bílých $\\frac{9+1}{2}=5$.',
             '14.2 Řada $16$ (sudá): tmavých $\\frac{3\\cdot 16}{2}=24$.',
             '14.3 Šestiúhelníky tvoří $9$ řad po $1,2,\\dots,9$, celkem $1+2+\\dots+9=45$ šestiúhelníků (tj. $45\\cdot 6=270$ tmavých trojúhelníků).'],
     'ans': '14.1: $5$ bílých trojúhelníků; 14.2: $24$ tmavých trojúhelníků; 14.3: $45$ tmavých šestiúhelníků',
     'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['posloupnosti', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M5PCD21C0T03'
    gen.YEAR = 2021

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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M5C-2021')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
