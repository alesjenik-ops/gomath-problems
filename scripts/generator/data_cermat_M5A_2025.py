# -*- coding: utf-8 -*-
# CERMAT – Jednotná přijímací zkouška 2025, MATEMATIKA 5A, 1. řádný termín.
# Kód testu: M5PAD25C0T01. 14 úloh (po rozdělení izolovaných poduúloh 16 úloh).
# Zdroj odpovědí: rozšířený klíč správných řešení (KSR).

# ---- SVG obrázky (bez ' a \) ----

# úloha 2: tabulka 3x3 (čísla 0 až 8) + diagram se dvěma kroužky a šipkami
SVG2 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 220" font-family="sans-serif">
<text x="105" y="26" font-size="12" text-anchor="middle">2.1 tabulka (čísla 0 až 8)</text>
<line x1="30" y1="45" x2="180" y2="45" stroke="#000"/>
<line x1="30" y1="95" x2="180" y2="95" stroke="#000"/>
<line x1="30" y1="145" x2="180" y2="145" stroke="#000"/>
<line x1="30" y1="195" x2="180" y2="195" stroke="#000"/>
<line x1="30" y1="45" x2="30" y2="195" stroke="#000"/>
<line x1="80" y1="45" x2="80" y2="195" stroke="#000"/>
<line x1="130" y1="45" x2="130" y2="195" stroke="#000"/>
<line x1="180" y1="45" x2="180" y2="195" stroke="#000"/>
<rect x="80" y="95" width="50" height="50" fill="none" stroke="#000" stroke-width="3"/>
<text x="55" y="77" font-size="20" text-anchor="middle">0</text>
<text x="155" y="127" font-size="20" text-anchor="middle">2</text>
<text x="105" y="177" font-size="20" text-anchor="middle">1</text>
<text x="155" y="177" font-size="20" text-anchor="middle">3</text>
<text x="430" y="26" font-size="12" text-anchor="middle">2.2 diagram</text>
<circle cx="372" cy="120" r="30" fill="none" stroke="#000"/>
<circle cx="488" cy="120" r="30" fill="none" stroke="#000"/>
<path d="M 400 108 Q 430 78 460 108" fill="none" stroke="#000"/>
<polygon points="460,108 451,103 454,113" fill="#000"/>
<text x="430" y="72" font-size="14" text-anchor="middle">+ 90</text>
<path d="M 460 132 Q 430 162 400 132" fill="none" stroke="#000"/>
<polygon points="400,132 409,127 406,137" fill="#000"/>
<text x="430" y="180" font-size="14" text-anchor="middle">: 3</text>
</svg>"""

# úloha 6: domeček (šestiúhelník) -> střecha (lichoběžník ze 3 trojúhelníků) + přízemí (obdélník)
SVG6 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 170" font-family="sans-serif">
<polygon points="30,140 120,140 120,95 98,58 52,58 30,95" fill="none" stroke="#000" stroke-width="2"/>
<text x="75" y="122" font-size="12" text-anchor="middle">Domeček</text>
<polygon points="195,82 285,82 262,50 218,50" fill="none" stroke="#000" stroke-width="2"/>
<text x="240" y="72" font-size="12" text-anchor="middle">Střecha</text>
<rect x="195" y="95" width="90" height="30" fill="none" stroke="#000" stroke-width="2"/>
<text x="240" y="115" font-size="12" text-anchor="middle">Přízemí</text>
<polygon points="360,95 450,95 428,58 382,58" fill="none" stroke="#000" stroke-width="2"/>
<line x1="382" y1="58" x2="405" y2="95" stroke="#000" stroke-dasharray="4 4"/>
<line x1="428" y1="58" x2="405" y2="95" stroke="#000" stroke-dasharray="4 4"/>
<text x="405" y="118" font-size="11" text-anchor="middle" fill="#666">střecha = 3 trojúhelníky</text>
</svg>"""

# úloha 7.1: bod R a přímky p, q protínající se v bodě A
SVG7_1 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 360" font-family="sans-serif">
<rect x="10" y="10" width="620" height="340" fill="none" stroke="#ccc"/>
<line x1="70" y1="300" x2="610" y2="235" stroke="#000" stroke-width="2"/><text x="60" y="312" font-size="16" font-style="italic">p</text>
<line x1="255" y1="345" x2="320" y2="60" stroke="#000" stroke-width="2"/><text x="318" y="58" font-size="16" font-style="italic">q</text>
<text x="278" y="296" font-size="15" font-style="italic">A</text>
<text x="360" y="176" font-size="15" font-style="italic">R</text><text x="357" y="190" font-size="15">×</text>
</svg>"""

# úloha 7.2: bod S a různoběžné přímky m, n
SVG7_2 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 360" font-family="sans-serif">
<rect x="10" y="10" width="620" height="340" fill="none" stroke="#ccc"/>
<line x1="150" y1="290" x2="620" y2="110" stroke="#000" stroke-width="2"/><text x="158" y="300" font-size="16" font-style="italic">m</text>
<line x1="150" y1="250" x2="600" y2="350" stroke="#000" stroke-width="2"/><text x="158" y="248" font-size="16" font-style="italic">n</text>
<text x="405" y="156" font-size="15" font-style="italic">S</text><text x="402" y="170" font-size="15">×</text>
</svg>"""

# úloha 8: skládaný sloupcový graf (muži/ženy), počet členů oddílu 2015-2018
def _bars8():
    data = [("2015", 30, 35), ("2016", 45, 45), ("2017", 50, 50), ("2018", 45, 50)]
    x0, y0 = 70, 300; sc = 2.4; bw = 50; gap = 35
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 340" font-family="sans-serif">']
    s.append(f'<line x1="{x0}" y1="30" x2="{x0}" y2="{y0}" stroke="#000"/><line x1="{x0}" y1="{y0}" x2="480" y2="{y0}" stroke="#000"/>')
    for v in range(0, 111, 10):
        y = y0 - v * sc
        s.append(f'<line x1="{x0-4}" y1="{y}" x2="{x0}" y2="{y}" stroke="#000"/><text x="{x0-8}" y="{y+4}" font-size="10" text-anchor="end">{v}</text>')
    s.append(f'<text x="22" y="165" font-size="12" text-anchor="middle" transform="rotate(-90 22 165)">Počet členů</text>')
    x = x0 + gap
    for name, muzi, zeny in data:
        hm = muzi * sc; hz = zeny * sc
        s.append(f'<rect x="{x}" y="{y0-hm}" width="{bw}" height="{hm}" fill="#555" stroke="#000"/>')
        s.append(f'<rect x="{x}" y="{y0-hm-hz}" width="{bw}" height="{hz}" fill="#dcdcdc" stroke="#000"/>')
        s.append(f'<text x="{x+bw/2}" y="{y0+16}" font-size="11" text-anchor="middle">{name}</text>')
        x += bw + gap
    s.append('<rect x="410" y="70" width="14" height="14" fill="#dcdcdc" stroke="#000"/><text x="430" y="82" font-size="12">Ženy</text>')
    s.append('<rect x="410" y="92" width="14" height="14" fill="#555" stroke="#000"/><text x="430" y="104" font-size="12">Muži</text>')
    s.append('</svg>')
    return "".join(s)
SVG8 = _bars8()

# úlohy 11 a 12: čtvercová síť s trojúhelníkem ABC, čtvercem DEFG a trojúhelníkem KLM
def _grid1112():
    cell = 24; ox = 30; oy = 24; W = 16; H = 6
    def X(gx): return ox + gx * cell
    def Y(gy): return oy + (H - gy) * cell
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 190" font-family="sans-serif">']
    for i in range(W + 1):
        s.append(f'<line x1="{X(i)}" y1="{Y(0)}" x2="{X(i)}" y2="{Y(H)}" stroke="#bbb"/>')
    for j in range(H + 1):
        yy = oy + j * cell
        s.append(f'<line x1="{X(0)}" y1="{yy}" x2="{X(W)}" y2="{yy}" stroke="#bbb"/>')
    s.append(f'<polygon points="{X(0)},{Y(0)} {X(4)},{Y(0)} {X(2)},{Y(4)}" fill="#9a9a9a" stroke="#000" stroke-width="2"/>')
    s.append(f'<polygon points="{X(6)},{Y(1)} {X(8)},{Y(2)} {X(7)},{Y(4)} {X(5)},{Y(3)}" fill="#9a9a9a" stroke="#000" stroke-width="2"/>')
    s.append(f'<polygon points="{X(9)},{Y(1)} {X(14)},{Y(1)} {X(11)},{Y(3)}" fill="#9a9a9a" stroke="#000" stroke-width="2"/>')
    labels = [("A",0,0,-14,14),("B",4,0,4,16),("C",2,4,-4,-6),("D",6,1,-4,16),("E",8,2,6,4),
              ("F",7,4,-2,-6),("G",5,3,-14,4),("K",9,1,-12,14),("L",14,1,4,14),("M",11,3,-2,-6)]
    for t, gx, gy, dx, dy in labels:
        s.append(f'<text x="{X(gx)+dx}" y="{Y(gy)+dy}" font-size="13" font-style="italic">{t}</text>')
    s.append(f'<rect x="{X(15)}" y="{Y(1)}" width="{cell}" height="{cell}" fill="#d8d8d8" stroke="#bbb"/>')
    s.append(f'<text x="{X(15)+cell+3}" y="{Y(1)-cell/2+4}" font-size="9">1 cm²</text>')
    s.append('</svg>')
    return "".join(s)
SVG_GRID = _grid1112()

# úloha 13: tři tělesa slepená z krychlových kostek (schematicky)
def _dice():
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 175" font-family="sans-serif">']
    a = 32; d = 13
    def box(x, y):
        return (f'<rect x="{x}" y="{y}" width="{a}" height="{a}" fill="#ececec" stroke="#000"/>'
                f'<polygon points="{x},{y} {x+d},{y-d} {x+a+d},{y-d} {x+a},{y}" fill="#f6f6f6" stroke="#000"/>'
                f'<polygon points="{x+a},{y} {x+a+d},{y-d} {x+a+d},{y-d+a} {x+a},{y+a}" fill="#d6d6d6" stroke="#000"/>')
    s.append('<text x="80" y="30" font-size="12" text-anchor="middle">1. těleso</text>')
    s.append(box(50, 95)); s.append(box(50 + a, 95))
    s.append('<text x="250" y="30" font-size="12" text-anchor="middle">2. těleso</text>')
    s.append(box(200, 95)); s.append(box(200 + a, 95)); s.append(box(200 + 2 * a, 95))
    s.append('<text x="435" y="30" font-size="12" text-anchor="middle">3. těleso</text>')
    s.append(box(400, 95)); s.append(box(400 + a, 95)); s.append(box(400, 95 - a))
    s.append('<text x="260" y="165" font-size="10" text-anchor="middle" fill="#666">Schematický nákres tří těles (2, 3 a 3 kostky); posuzuje se podle testového sešitu.</text>')
    s.append('</svg>')
    return "".join(s)
SVG13 = _dice()

B = ['zs1']  # 5. ročník ZŠ (přijímačky na osmileté); kód r5 v taxonomii není

PROBLEMS = [
    {'name': 'CERMAT M5A 2025 – úloha 1.1', 'zad': [
        'Doplňte do rámečku takové číslo, aby platila rovnost:',
        '$\\square : 11 = (5 + 5\\cdot 20) - 101$'], 'opts': None, 'ln': 2,
     'sol': ['Pravá strana: $5 + 5\\cdot 20 - 101 = 5 + 100 - 101 = 4$. Pak $\\square : 11 = 4$, tedy $\\square = 4\\cdot 11 = 44$.'],
     'ans': '$44$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2025 – úloha 1.2', 'zad': [
        'Doplňte do rámečku takové číslo, aby platila rovnost:',
        '$(188 - 152) : \\left(1 + \\square\\right) = 4 + 20 : 4$'], 'opts': None, 'ln': 2,
     'sol': ['Pravá strana: $4 + 20 : 4 = 4 + 5 = 9$. Levá strana: $(188 - 152) : (1 + \\square) = 36 : (1 + \\square)$. Z $36 : (1 + \\square) = 9$ plyne $1 + \\square = 4$, tedy $\\square = 3$.'],
     'ans': '$3$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2025 – úloha 2', 'zad': [
        '2.1 Tabulka má obsahovat všechna celá čísla od 0 do 8. Do prázdných polí tabulky se doplní chybějící čísla tak, aby byl součet v každém sloupci i v každém řádku stejný. Určete číslo, které patří do prostředního pole tabulky.',
        '2.2 V diagramu se do prázdných kroužků doplní taková čísla, aby byly všechny výpočty provedené ve směru šipek správné. Určete obě čísla doplněná do prázdných kroužků.'],
     'opts': None, 'ln': 2, 'svg': SVG2, 'fn': 'tabulka-diagram.svg',
     'alt': 'Tabulka 3 krát 3 s čísly 0, 2, 1, 3 a zvýrazněným prostředním polem; diagram se dvěma kroužky a šipkami plus 90 a děleno 3.',
     'cap': 'Doplňovaná tabulka (2.1) a diagram se šipkami (2.2)',
     'sol': ['2.1 Součet čísel 0 až 8 je $36$, v každém řádku i sloupci tedy $36 : 3 = 12$. Doplněním vyjde prostřední pole $6$ (řádky $0, 5, 7$; $4, 6, 2$; $8, 1, 3$).',
             '2.2 Levý kroužek $x$, pravý $x + 90$; při návratu dělíme třemi: $(x + 90) : 3 = x$, odtud $x + 90 = 3x$, $x = 45$ a $x + 90 = 135$.'],
     'ans': '2.1: $6$; 2.2: $45$; $135$', 'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2025 – úloha 3', 'zad': [
        'Mirek má menší jízdní kolo než jeho táta. Mirek na rovné cestě zjišťoval, kolikrát se u obou jízdních kol otočí přední kolo, jestliže obě jízdní kola urazí stejnou vzdálenost. Když se Mirkovo přední kolo otočilo 30krát, tátovo přední kolo se otočilo jen 25krát.',
        'Mirek a jeho táta urazili na svých jízdních kolech stejnou vzdálenost. Vypočtěte, kolikrát se otočilo Mirkovo přední kolo,',
        '3.1 jestliže se tátovo přední kolo otočilo 30krát,',
        '3.2 jestliže tátovo přední kolo vykonalo o 30 otáček méně než Mirkovo přední kolo.'],
     'opts': None, 'ln': 2,
     'sol': ['Poměr počtu otáček Mirkova a tátova předního kola je při stejné dráze $30 : 25 = 6 : 5$ (menší kolo se otočí vícekrát).',
             '3.1 Když se tátovo kolo otočí $30$krát, Mirkovo se otočí $30\\cdot\\frac{6}{5} = 36$krát.',
             '3.2 Je-li Mirkovo $M$ a tátovo $M - 30$, platí $M : (M - 30) = 6 : 5$, tj. $5M = 6(M - 30)$, $M = 180$. Mirkovo kolo se otočilo $180$krát.'],
     'ans': '3.1: $36$krát; 3.2: $180$krát', 'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5A 2025 – úloha 4', 'zad': [
        'Velká kulička váží 30 gramů a malá kulička váží 20 gramů. Anička položila na prázdnou váhu určitý počet velkých kuliček a dvojnásobný počet malých kuliček. Váha ukázala celkovou hmotnost 560 gramů.',
        '4.1 Určete počet všech kuliček (malých i velkých dohromady) položených na váze.',
        '4.2 Určete v gramech celkovou hmotnost všech malých kuliček položených na váze.'],
     'opts': None, 'ln': 2,
     'sol': ['Velkých kuliček je $n$, malých $2n$. Hmotnost: $30n + 20\\cdot 2n = 70n = 560$, tedy $n = 8$.',
             '4.1 Celkem $n + 2n = 3n = 24$ kuliček.',
             '4.2 Malých kuliček je $16$, jejich hmotnost je $16\\cdot 20 = 320$ g.'],
     'ans': '4.1: $24$ kuliček; 4.2: $320$ g', 'pts': 3, 'mins': 4, 'diff': '2',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5A 2025 – úloha 5', 'zad': [
        'Náš dům má tři patra a bydlí v něm celkem 11 dětí. V prvním a druhém patře bydlí dohromady 8 dětí. Ve druhém patře bydlí jen dívky. V prvním a třetím patře bydlí dohromady 5 chlapců a 3 dívky. Ze všech chlapců z našeho domu pouze 3 chlapci nebydlí ve třetím patře.',
        '5.1 Vypočtěte, kolik chlapců bydlí ve druhém patře.',
        '5.2 Vypočtěte, kolik dětí bydlí v prvním patře.',
        '5.3 Vypočtěte, kolik dívek bydlí v našem domě.'],
     'opts': None, 'ln': 3,
     'sol': ['5.1 Ve druhém patře bydlí jen dívky, chlapců tam bydlí $0$ (žádný chlapec).',
             '5.2 V prvním a druhém patře je $8$ dětí, celkem je jich $11$, ve třetím patře tedy $11 - 8 = 3$ děti. V prvním a třetím patře je dohromady $5 + 3 = 8$ dětí, v prvním patře proto $8 - 3 = 5$ dětí.',
             '5.3 V prvním a třetím patře je $5$ chlapců, ve druhém $0$; protože jen $3$ chlapci nebydlí ve třetím patře, v prvním patře jsou $3$ chlapci a ve třetím $5 - 3 = 2$. Celkem chlapců $5$, dívek je tedy $11 - 5 = 6$.'],
     'ans': '5.1: žádný chlapec; 5.2: $5$ dětí; 5.3: $6$ dívek', 'pts': 5, 'mins': 6, 'diff': '3',
     'codes': B + ['aritmetika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5A 2025 – úloha 6', 'zad': [
        'Šestiúhelník tvaru domečku má obvod 24 cm. Domeček lze rozdělit na dva čtyřúhelníky – střechu a přízemí. Oba tyto čtyřúhelníky mají stejný obvod. Střecha je složena ze tří rovnostranných trojúhelníků, přízemí má tvar obdélníku.',
        '6.1 Vypočtěte v cm obvod čtyřúhelníku představujícího střechu.',
        '6.2 Vypočtěte v cm délku kratší strany obdélníku představujícího přízemí.'],
     'opts': None, 'ln': 2, 'svg': SVG6, 'fn': 'domecek.svg',
     'alt': 'Domeček (šestiúhelník) rozdělený na střechu (lichoběžník ze tří rovnostranných trojúhelníků) a přízemí (obdélník).',
     'cap': 'Schematický nákres domečku, střechy a přízemí',
     'sol': ['Strana rovnostranného trojúhelníku ať je $s$, kratší strana obdélníku (přízemí) $h$; delší strana obdélníku i spodní základna střechy má délku $2s$.',
             'Střecha (lichoběžník) má obvod $2s + s + s + s = 5s$, přízemí (obdélník) obvod $2\\cdot(2s + h) = 4s + 2h$. Mají být stejné: $5s = 4s + 2h$, tedy $s = 2h$.',
             'Obvod domečku (šestiúhelníku) je $2s + 2h + 3s = 5s + 2h = 24$. Dosazením $s = 2h$: $12h = 24$, $h = 2$, $s = 4$.',
             '6.1 Obvod střechy $= 5s = 20$ cm.',
             '6.2 Kratší strana přízemí $= h = 2$ cm.'],
     'ans': '6.1: $20$ cm; 6.2: $2$ cm', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2025 – úloha 7.1 (konstrukce)', 'zad': [
        'V rovině leží bod $R$ a přímky $p$, $q$, které se protínají v bodě $A$ (viz obrázek).',
        'Bod $A$ je vrchol obdélníku $ABCD$. Na jedné z přímek $p$, $q$ leží vrchol $B$ a na druhé přímce vrchol $C$ tohoto obdélníku. Bodem $R$ prochází strana $BC$ obdélníku $ABCD$.',
        'Sestrojte vrcholy $B$, $C$, $D$ obdélníku $ABCD$, označte je písmeny a obdélník narýsujte. Najděte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG7_1, 'fn': 'primky-pq.svg',
     'alt': 'Bod R a dvě různoběžné přímky p, q protínající se v bodě A.',
     'cap': 'Výchozí obrázek k úloze 7.1',
     'sol': ['Bod $A$ je průsečík přímek $p$, $q$. Strana $AB$ leží na jedné z přímek a strana $BC$ je na ni kolmá a prochází bodem $R$; bod $B$ je tedy pata kolmice spuštěné z bodu $R$ na tuto přímku. Průsečík této kolmice (přímky $BR$) s druhou přímkou je vrchol $C$. Vrchol $D$ doplníme tak, aby $ABCD$ byl obdélník.',
             'Bod $B$ může ležet na přímce $p$, nebo na přímce $q$, proto úloha má dvě řešení.'],
     'ans': 'Dvě řešení. $A$ je průsečík přímek $p$, $q$; $B$ je pata kolmice z bodu $R$ na jednu z přímek, $C$ je průsečík této kolmice s druhou přímkou, $D$ doplní obdélník $ABCD$ (viz náčrt v klíči).',
     'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2025 – úloha 7.2 (konstrukce)', 'zad': [
        'V rovině leží bod $S$ a různoběžné přímky $m$, $n$ (viz obrázek).',
        'Na přímce $m$ leží strana $EF$ trojúhelníku $EFG$ a na přímce $n$ leží strana $EG$ tohoto trojúhelníku. Bod $S$ má od všech tří vrcholů trojúhelníku $EFG$ stejnou vzdálenost.',
        'Sestrojte vrcholy trojúhelníku $EFG$, označte je písmeny a trojúhelník narýsujte.'],
     'opts': None, 'ln': 0, 'svg': SVG7_2, 'fn': 'primky-mn.svg',
     'alt': 'Bod S a dvě různoběžné přímky m, n.',
     'cap': 'Výchozí obrázek k úloze 7.2',
     'sol': ['Bod $E$ je průsečík přímek $m$, $n$ (leží na obou stranách $EF$ i $EG$). Bod $S$ je stejně vzdálen od všech vrcholů, je to tedy střed kružnice opsané. Sestrojíme kružnici se středem $S$ a poloměrem $SE$; její druhý průsečík s přímkou $m$ je vrchol $F$ a druhý průsečík s přímkou $n$ je vrchol $G$. Trojúhelník $EFG$ narýsujeme.'],
     'ans': 'Bod $E$ je průsečík přímek $m$, $n$; kružnice se středem $S$ a poloměrem $SE$ protne přímku $m$ v bodě $F$ a přímku $n$ v bodě $G$; trojúhelník $EFG$ (viz náčrt v klíči).',
     'pts': 2, 'mins': 5, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2025 – úloha 8', 'zad': [
        'Graf udává počet všech členů (mužů a žen) turistického oddílu sledovaný v letech 2015–2018.',
        'Rozhodněte o každém z následujících tvrzení 8.1–8.3, zda je pravdivé (A), či nikoli (N).',
        '8.1 Počet mužů v turistickém oddílu byl v roce 2015 o jednu třetinu menší než v roce 2016.',
        '8.2 Počet členů turistického oddílu byl v roce 2017 o jednu devítinu větší než v roce 2016.',
        '8.3 Ve sledovaném období se počet žen v turistickém oddílu poprvé snížil oproti předchozímu roku až v roce 2018.'],
     'opts': None, 'ln': 0, 'svg': SVG8, 'fn': 'graf-oddil.svg',
     'alt': 'Skládaný sloupcový graf počtu členů (muži, ženy) turistického oddílu v letech 2015 až 2018.',
     'cap': 'Počet členů oddílu v letech 2015–2018',
     'sol': ['Z grafu: muži $30, 45, 50, 45$; celkem členů $65, 90, 100, 95$; ženy $35, 45, 50, 50$ (roky 2015 až 2018).',
             '8.1 Třetina z $45$ je $15$; $45 - 15 = 30 =$ počet mužů v roce 2015. Tvrzení platí (A).',
             '8.2 Devítina z $90$ je $10$; $90 + 10 = 100 =$ počet členů v roce 2017. Tvrzení platí (A).',
             '8.3 Ženy: $35, 45, 50, 50$ – meziročně nikdy neklesly (v roce 2018 zůstal počet stejný). Tvrzení neplatí (N).'],
     'ans': '8.1: A (Ano); 8.2: A (Ano); 8.3: N (Ne)', 'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['statistika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5A 2025 – úloha 9', 'zad': [
        'Farmář měl původně 7 krav. Každá z nich nadojila denně 15 litrů mléka. Farmář 5 svých krav prodal, ale přikoupil několik dalších krav. Každá z přikoupených krav nadojí denně 20 litrů mléka. Celkové množství mléka, které původních 7 farmářových krav nadojilo za dva dny, všechny nynější farmářovy krávy dohromady nadojí za jeden den.',
        'Kolik krav farmář přikoupil?'],
     'opts': ['A) 9 krav', 'B) 10 krav', 'C) 12 krav', 'D) 14 krav', 'E) jiný počet krav'], 'ln': 0,
     'sol': ['Původních $7$ krav nadojí za dva dny $7\\cdot 15\\cdot 2 = 210$ litrů. Po prodeji zbyly $2$ původní krávy ($2\\cdot 15 = 30$ litrů za den) a $k$ přikoupených ($20$ litrů za den). Z rovnice $30 + 20k = 210$ plyne $k = 9$.'],
     'ans': 'A) 9 krav', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5A 2025 – úloha 10', 'zad': [
        'Maminka rozdělila peníze mezi své tři děti. Janě dala pětinu celkové částky, Ivo dostal dvakrát více peněz než Jana a zbylých 240 korun dala maminka Evě.',
        'Kolik korun celkem rozdělila maminka mezi své tři děti?'],
     'opts': ['A) 480 korun', 'B) 600 korun', 'C) 700 korun', 'D) 720 korun', 'E) 840 korun'], 'ln': 0,
     'sol': ['Jana dostala $\\frac{1}{5}$ celku, Ivo dvakrát více, tj. $\\frac{2}{5}$ celku; dohromady $\\frac{3}{5}$. Na Evu zbyly $\\frac{2}{5}$ celku, což je $240$ korun. Celek $= 240 : \\frac{2}{5} = 600$ korun.'],
     'ans': 'B) 600 korun', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5A 2025 – úloha 11', 'zad': [
        'Ve čtvercové síti jsou zakresleny trojúhelníky $ABC$, $KLM$ a čtverec $DEFG$. Vrcholy všech těchto obrazců leží v mřížových bodech. Každý čtvereček čtvercové sítě má stranu délky 1 cm a obsah 1 cm².',
        'O kolik cm se liší obvod trojúhelníku $ABC$ a obvod čtverce $DEFG$?'],
     'opts': ['A) o méně než 2 cm', 'B) o 2 cm', 'C) o 3 cm', 'D) o 4 cm', 'E) o jinou délku'], 'ln': 0,
     'svg': SVG_GRID, 'fn': 'sit-obrazce.svg',
     'alt': 'Čtvercová síť s trojúhelníkem ABC, čtvercem DEFG a trojúhelníkem KLM; vrcholy v mřížových bodech.',
     'cap': 'Obrazce ve čtvercové síti (schematicky)',
     'sol': ['Trojúhelník $ABC$ je rovnoramenný se základnou $AB = 4$ cm a rameny délky $\\sqrt{2^2 + 4^2} = 2\\sqrt{5}$ cm; jeho obvod je $4 + 4\\sqrt{5}$ cm. Čtverec $DEFG$ má stranu $\\sqrt{1^2 + 2^2} = \\sqrt{5}$ cm, obvod $4\\sqrt{5}$ cm. Rozdíl obvodů je $(4 + 4\\sqrt{5}) - 4\\sqrt{5} = 4$ cm.'],
     'ans': 'D) o 4 cm', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2025 – úloha 12', 'zad': [
        'Ve čtvercové síti jsou zakresleny trojúhelníky $ABC$, $KLM$ a čtverec $DEFG$. Vrcholy všech těchto obrazců leží v mřížových bodech. Každý čtvereček čtvercové sítě má stranu délky 1 cm a obsah 1 cm².',
        'O kolik cm² se liší obsah trojúhelníku $ABC$ a obsah trojúhelníku $KLM$?'],
     'opts': ['A) o 1 cm²', 'B) o 2 cm²', 'C) o 3 cm²', 'D) o 4 cm²', 'E) o jiný obsah'], 'ln': 0,
     'svg': SVG_GRID, 'fn': 'sit-obrazce.svg',
     'alt': 'Čtvercová síť s trojúhelníkem ABC, čtvercem DEFG a trojúhelníkem KLM; vrcholy v mřížových bodech.',
     'cap': 'Obrazce ve čtvercové síti (schematicky)',
     'sol': ['Obsah trojúhelníku $ABC$ je $\\frac{1}{2}\\cdot 4\\cdot 4 = 8$ cm². Obsah trojúhelníku $KLM$ je $5$ cm². Obsahy se liší o $8 - 5 = 3$ cm².'],
     'ans': 'C) o 3 cm²', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2025 – úloha 13', 'zad': [
        'Kostka tvaru krychle má na třech stěnách po 1 tečce a na zbývajících třech stěnách po 3 tečkách. Součet počtu teček na protějších stěnách je vždy 4. Počet všech teček na povrchu kostky je tedy 12. Z takovýchto kostek slepíme tři tělesa. Kostky před slepováním vhodně natočíme, aby byly splněny následující podmínky: první těleso má na svém povrchu co nejvíce teček a zbývající dvě tělesa co nejméně teček. První těleso jsou 2 kostky v řadě, druhé těleso 3 kostky v řadě, třetí těleso 3 kostky ve tvaru L.',
        'Přiřaďte ke každému tělesu (13.1–13.3) počet všech teček na jeho povrchu (A–F).',
        '13.1 První těleso',
        '13.2 Druhé těleso',
        '13.3 Třetí těleso'],
     'opts': ['A) méně než 20 teček', 'B) 20 teček', 'C) 22 teček', 'D) 24 teček', 'E) 26 teček', 'F) 28 teček'], 'ln': 0,
     'svg': SVG13, 'fn': 'telesa-kostky.svg',
     'alt': 'Tři tělesa slepená z krychlových kostek: dvě kostky, tři kostky v řadě a tři kostky ve tvaru L (schematicky).',
     'cap': 'Schematický nákres tří těles',
     'sol': ['Každá kostka má $12$ teček; na protějších stěnách je součet $4$ (naproti $1$ je vždy $3$). Slepené stěny se skryjí.',
             '13.1 První těleso (2 kostky, co nejvíce teček): skryjeme dvě stěny s $1$ tečkou, tedy $2$; na povrchu $2\\cdot 12 - 2 = 22$ teček → C.',
             '13.2 Druhé těleso (řada 3 kostek, co nejméně): prostřední kostka má slepené protilehlé stěny (součet $4$), krajní kostky po jedné stěně se $3$ tečkami; skryto $4 + 3 + 3 = 10$; na povrchu $36 - 10 = 26$ teček → E.',
             '13.3 Třetí těleso (tvar L, co nejméně): rohová kostka má slepené dvě sousední stěny, obě mohou mít po $3$ tečkách; skryto $3 + 3 + 3 + 3 = 12$; na povrchu $36 - 12 = 24$ teček → D.'],
     'ans': '13.1: C (22 teček); 13.2: E (26 teček); 13.3: D (24 teček)', 'pts': 5, 'mins': 6, 'diff': '4',
     'codes': B + ['stereometrie', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5A 2025 – úloha 14', 'zad': [
        'Poutník měl u sebe 54 dukátů, stejně jako kouzelník. Kouzelník mu prozradil kouzlo: Když mi dáš právě tolik dukátů, abys měl polovinu toho, co budu mít i s darovanými dukáty já, zbytek tvých dukátů se zdvojnásobí a budeme mít opět stejně. Pokud to však zkusíš, ale nedokážeš, o všechny dukáty přijdeš.',
        '14.1 Poutník dal kouzelníkovi správný počet dukátů a zbytek dukátů se mu zdvojnásobil. Určete, kolik dukátů dal poutník kouzelníkovi.',
        '14.2 Protože kouzlo poprvé fungovalo, poutník jej použil ještě jednou. Vypočtěte, kolik dukátů měl poutník, když se kouzlo vyplnilo podruhé.',
        '14.3 Poutník kouzla několikrát využil. Když si správně spočítal, že už pomocí kouzla nemůže další dukáty získat a že by při dalším pokusu určitě o všechny přišel, dál nepokračoval. Vypočtěte, kolik dukátů měl poutník, když se s kouzelníkem rozloučil.'],
     'opts': None, 'ln': 3,
     'sol': ['Poutník i kouzelník mají po $54$ dukátech. Poutník dá $x$ dukátů; pak má $54 - x$, což má být polovina kouzelníkových $54 + x$: $54 - x = \\frac{54 + x}{2}$, odtud $x = 18$. Poté se zbytek poutníkových dukátů zdvojnásobí.',
             '14.1 Poutník dal kouzelníkovi $18$ dukátů (zbylo mu $36$, po zdvojnásobení $72$; kouzelník má také $72$).',
             '14.2 Podruhé z $72$ dukátů dá $24$, zbylých $48$ se zdvojnásobí na $96$; poutník má $96$ dukátů (i kouzelník $96$).',
             '14.3 Oba mají postupně $54, 72, 96, 128$ dukátů. Z $128$ už nelze dát celý potřebný počet dukátů ($128$ není dělitelné třemi), poutník tedy skončil se $128$ dukáty.'],
     'ans': '14.1: $18$ dukátů; 14.2: $96$ dukátů; 14.3: $128$ dukátů', 'pts': 4, 'mins': 7, 'diff': '4',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M5PAD25C0T01'
    gen.YEAR = 2025

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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M5A-2025')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
