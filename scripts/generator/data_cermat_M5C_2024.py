# -*- coding: utf-8 -*-
# CERMAT – Jednotná přijímací zkouška 2024, MATEMATIKA 5C (osmileté obory, 5. ročník).
# Kód testu: M5PCD24C0T03. 14 úloh, 50 bodů (6 uzavřených 8–13, 8 otevřených 1–7 a 14).
# Po rozdělení nezávislých poduúloh (1.1/1.2, 4.1/4.2/4.3, 5.1/5.2) => 18 úloh.
# Zdroj odpovědí: klíč správných řešení (KLIC_5C_2024.pdf).

# ---- SVG obrázky (bez ' a \) ----

# úloha 3: součtový trojúhelník: horní [šedé, šedé, 8], prostřední [_, _], dolní [44]
SVG3 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 170" font-family="sans-serif">
<rect x="100" y="30" width="70" height="40" fill="#c9c9c9" stroke="#000"/>
<rect x="170" y="30" width="70" height="40" fill="#c9c9c9" stroke="#000"/>
<rect x="240" y="30" width="70" height="40" fill="#fff" stroke="#000"/>
<text x="275" y="56" font-size="18" text-anchor="middle">8</text>
<rect x="135" y="70" width="70" height="40" fill="#fff" stroke="#000"/>
<rect x="205" y="70" width="70" height="40" fill="#fff" stroke="#000"/>
<rect x="170" y="110" width="70" height="40" fill="#fff" stroke="#000"/>
<text x="205" y="136" font-size="18" text-anchor="middle">44</text>
</svg>"""

# úloha 6: číselná osa, 10 shodných úseků; 24 (index 2), A (3), B (5), 64 (7)
def _osa():
    x0 = 40; step = 40; y = 60
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 110" font-family="sans-serif">']
    s.append(f'<line x1="{x0}" y1="{y}" x2="{x0+10*step}" y2="{y}" stroke="#000" stroke-width="2"/>')
    for i in range(11):
        x = x0 + i*step
        s.append(f'<line x1="{x}" y1="{y-10}" x2="{x}" y2="{y+10}" stroke="#000"/>')
    labels = [(2, '24', False), (3, 'A', True), (5, 'B', True), (7, '64', False)]
    for idx, txt, ital in labels:
        x = x0 + idx*step
        st = ' font-style="italic"' if ital else ''
        s.append(f'<text x="{x}" y="{y+28}" font-size="15" text-anchor="middle"{st}>{txt}</text>')
    s.append('</svg>')
    return "".join(s)
SVG6 = _osa()

# úloha 7: přímka p (šikmá) a bod K nad ní
SVG7 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif">
<line x1="40" y1="245" x2="420" y2="85" stroke="#000" stroke-width="2"/>
<text x="432" y="82" font-size="16" font-style="italic">p</text>
<text x="200" y="122" font-size="16" font-style="italic" text-anchor="middle">K</text>
<text x="200" y="138" font-size="16" text-anchor="middle">×</text>
</svg>"""

# úloha 8: obrazec ve čtvercové síti 9x8; čtyři trojúhelníky A,B,C,D a svislý obdélník E (1x8)
def _fig8():
    ox, oy, cell = 30, 20, 22
    cx1, cx2 = ox+4*cell, ox+5*cell   # 118, 140 (obdélník E, 1 čtvereček)
    my = oy+4*cell                    # 108 (střední výška)
    right, bot = ox+9*cell, oy+8*cell # 228, 196
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 258 226" font-family="sans-serif">']
    for i in range(10):
        x = ox+i*cell
        s.append(f'<line x1="{x}" y1="{oy}" x2="{x}" y2="{bot}" stroke="#ccc"/>')
    for j in range(9):
        y = oy+j*cell
        s.append(f'<line x1="{ox}" y1="{y}" x2="{right}" y2="{y}" stroke="#ccc"/>')
    s.append(f'<polygon points="{ox},{oy} {cx1},{oy} {cx1},{my}" fill="#e3e3e3" stroke="#000"/>')
    s.append(f'<polygon points="{cx2},{oy} {right},{oy} {cx2},{my}" fill="#e3e3e3" stroke="#000"/>')
    s.append(f'<polygon points="{ox},{bot} {cx1},{bot} {cx1},{my}" fill="#e3e3e3" stroke="#000"/>')
    s.append(f'<polygon points="{cx2},{bot} {right},{bot} {cx2},{my}" fill="#e3e3e3" stroke="#000"/>')
    s.append(f'<rect x="{cx1}" y="{oy}" width="{cell}" height="{bot-oy}" fill="#f4f4f4" stroke="#000"/>')
    s.append('<text x="70" y="60" font-size="14" text-anchor="middle" font-weight="bold">A</text>')
    s.append('<text x="188" y="60" font-size="14" text-anchor="middle" font-weight="bold">C</text>')
    s.append('<text x="70" y="176" font-size="14" text-anchor="middle" font-weight="bold">B</text>')
    s.append('<text x="188" y="176" font-size="14" text-anchor="middle" font-weight="bold">D</text>')
    s.append('<text x="129" y="112" font-size="14" text-anchor="middle" font-weight="bold">E</text>')
    s.append('</svg>')
    return "".join(s)
SVG8 = _fig8()

# úloha 11: čtvercová síť 3x3 se šedým čtyřúhelníkem (obsah 4,5 čtverečku = polovina)
def _fig11():
    ox, oy, cell, N = 20, 20, 40, 3
    def P(gx, gy): return f'{ox+gx*cell},{oy+gy*cell}'
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 160 160" font-family="sans-serif">']
    s.append(f'<polygon points="{P(1,0)} {P(3,1)} {P(2,3)} {P(0,1)}" fill="#b9b9b9" stroke="#000" stroke-width="1.5"/>')
    for i in range(N+1):
        x = ox+i*cell
        s.append(f'<line x1="{x}" y1="{oy}" x2="{x}" y2="{oy+N*cell}" stroke="#000"/>')
    for j in range(N+1):
        y = oy+j*cell
        s.append(f'<line x1="{ox}" y1="{y}" x2="{ox+N*cell}" y2="{y}" stroke="#000"/>')
    s.append('</svg>')
    return "".join(s)
SVG11 = _fig11()

# úloha 12: schematický nákres sloupcového grafu (našetřené nad osou, utracené pod osou)
def _fig12():
    x0, y0, top, bot = 70, 170, 50, 260
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 340" font-family="sans-serif">']
    s.append(f'<line x1="{x0}" y1="{top}" x2="{x0}" y2="{bot}" stroke="#000"/>')
    s.append(f'<line x1="{x0}" y1="{y0}" x2="480" y2="{y0}" stroke="#000" stroke-width="1.5"/>')
    for v in (0, 100, 200, 300, 400):
        y = y0 - int(v*0.3)
        s.append(f'<line x1="{x0-4}" y1="{y}" x2="{x0}" y2="{y}" stroke="#000"/>')
        s.append(f'<text x="{x0-8}" y="{y+4}" font-size="10" text-anchor="end">{v}</text>')
    for v in (100, 200, 300):
        y = y0 + int(v*0.3)
        s.append(f'<line x1="{x0-4}" y1="{y}" x2="{x0}" y2="{y}" stroke="#000"/>')
        s.append(f'<text x="{x0-8}" y="{y+4}" font-size="10" text-anchor="end">{v}</text>')
    s.append('<text x="22" y="110" font-size="11" text-anchor="middle" transform="rotate(-90 22 110)">našetřené peníze</text>')
    s.append('<text x="22" y="225" font-size="11" text-anchor="middle" transform="rotate(-90 22 225)">utracené peníze</text>')
    months = ['leden', 'únor', 'březen', 'duben', 'květen', 'červen']
    for i, m in enumerate(months):
        cx = x0 + 45 + i*65
        s.append(f'<text x="{cx}" y="{bot+18}" font-size="10" text-anchor="middle">{m}</text>')
    s.append('<rect x="300" y="60" width="14" height="12" fill="#fff" stroke="#000"/><text x="320" y="70" font-size="11">Sára</text>')
    s.append('<rect x="300" y="78" width="14" height="12" fill="#dcdcdc" stroke="#000"/><text x="320" y="88" font-size="11">Dana (šrafovaně)</text>')
    s.append('<rect x="300" y="96" width="14" height="12" fill="#9a9a9a" stroke="#000"/><text x="320" y="106" font-size="11">Lukáš</text>')
    s.append('<text x="270" y="305" font-size="10" text-anchor="middle" fill="#555">Schematický nákres struktury grafu; přesné měsíční hodnoty viz testový sešit.</text>')
    s.append('</svg>')
    return "".join(s)
SVG12 = _fig12()

B = ['zs1']  # 5. ročník ZŠ (přijímačky na osmileté obory)

PROBLEMS = [
    {'name': 'CERMAT M5C 2024 – úloha 1.1', 'zad': ['Vypočítejte: $(12\\cdot 12):6+12\\cdot 6=$'], 'opts': None, 'ln': 2,
     'sol': ['$(12\\cdot 12):6+12\\cdot 6=144:6+72=24+72=96$.'], 'ans': '$96$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B+['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5C 2024 – úloha 1.2', 'zad': ['Vypočítejte: $(1970+8\\cdot 23)-(1971-21:7)=$'], 'opts': None, 'ln': 2,
     'sol': ['$(1970+184)-(1971-3)=2154-1968=186$.'], 'ans': '$186$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B+['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5C 2024 – úloha 2', 'zad': [
        'Najděte a napište jednu číslici, kterou lze nahradit všechny hvězdičky tak, aby výpočet byl správný.',
        'Písemné sčítání dvou čtyřciferných čísel: číslo tvaru *36* plus číslo tvaru 1**8 se rovná 5 812. Každá hvězdička (*) představuje tutéž číslici.',
        'Do záznamového archu uveďte pouze chybějící číslici.'],
     'opts': None, 'ln': 2,
     'sol': ['Označme hledanou číslici $c$. Součet je $5\\,812$; po dosazení dostaneme $1\\,111\\cdot c+1\\,368=5\\,812$, tedy $1\\,111\\cdot c=4\\,444$ a $c=4$. Zkouška: $4\\,364+1\\,448=5\\,812$.'],
     'ans': '$4$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B+['aritmetika', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5C 2024 – úloha 3', 'zad': [
        'V součtovém trojúhelníku platí, že součet dvou čísel, která jsou v rámečcích v řádku vedle sebe, je vždy zapsán o řádek níže do rámečku, který s těmito oběma čísly sousedí. Například z čísel $1$, $2$, $3$ v horním řádku vznikne v dalším řádku $3$ a $5$ a v posledním řádku $8$.',
        'V daném součtovém trojúhelníku jsou v horním řádku dvě šedá pole a číslo $8$, v posledním řádku je číslo $44$. Do obou šedých polí patří stejné číslo.',
        'Jaké číslo musí být v obou šedých polích?'],
     'opts': None, 'ln': 2, 'svg': SVG3, 'fn': 'souctovy-trojuhelnik.svg',
     'alt': 'Součtový trojúhelník: horní řádek dvě šedá pole a číslo 8, prostřední řádek dvě prázdná pole, dolní řádek číslo 44.',
     'cap': 'Součtový trojúhelník',
     'sol': ['Označme číslo v šedých polích $x$. Horní řádek: $x$, $x$, $8$. Prostřední řádek: $x+x=2x$ a $x+8$. Poslední řádek: $2x+(x+8)=3x+8$. Má platit $3x+8=44$, tedy $3x=36$ a $x=12$.'],
     'ans': '$12$', 'pts': 3, 'mins': 4, 'diff': '3',
     'codes': B+['aritmetika', 'modelovani', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5C 2024 – úloha 4.1', 'zad': [
        'Jsou dána dvě čísla. Druhé číslo je polovinou čísla prvního. Součet těchto dvou čísel je $150$.',
        'Určete první i druhé číslo.'],
     'opts': None, 'ln': 2,
     'sol': ['Označme první číslo $a$, druhé $\\frac{a}{2}$. Platí $a+\\frac{a}{2}=150$, tj. $\\frac{3}{2}a=150$, odtud $a=100$ a druhé číslo je $50$.'],
     'ans': 'první číslo: $100$; druhé číslo: $50$', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B+['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5C 2024 – úloha 4.2', 'zad': [
        'Olga si z ušetřených peněz koupila knížku za $170$ Kč a čokoládu za $26$ Kč. Maminka jí pak přidala $100$ Kč na dárek pro babičku, který stál $180$ Kč. Poté, co Olga koupila babičce tento dárek, zbylo Olze $130$ Kč.',
        'Kolik měla Olga ušetřeno před nákupem knížky a čokolády?'],
     'opts': None, 'ln': 2,
     'sol': ['Označme úspory $u$. Platí $u-170-26+100-180=130$, tj. $u-276=130$, odtud $u=406$ Kč.'],
     'ans': '$406$ Kč', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B+['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'finance']},

    {'name': 'CERMAT M5C 2024 – úloha 4.3', 'zad': [
        'Na pastvině je dohromady $195$ zvířat – ovečky, kůzlátka a telátka. Oveček je o polovinu více než kůzlátek a zároveň je jich dvakrát více než telátek.',
        'Kolik je na poli oveček?'],
     'opts': None, 'ln': 2,
     'sol': ['Označme počet kůzlátek $k$. Oveček je $\\frac{3}{2}k$, telátek je polovina počtu oveček, tj. $\\frac{3}{4}k$. Dohromady $\\frac{3}{2}k+k+\\frac{3}{4}k=\\frac{13}{4}k=195$, odtud $k=60$. Oveček je $\\frac{3}{2}\\cdot 60=90$.'],
     'ans': '$90$ oveček', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B+['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5C 2024 – úloha 5.1', 'zad': [
        'Doplňte do rámečku takové číslo, aby platila rovnost.',
        '$1$ hodina $-\\;s\\;$ sekund $=30$ minut, kde $s$ je hledaný počet sekund.'],
     'opts': None, 'ln': 2,
     'sol': ['$1$ hodina $=3\\,600$ sekund, $30$ minut $=1\\,800$ sekund. Platí $3\\,600-s=1\\,800$, odtud $s=1\\,800$.'],
     'ans': '$1\\,800$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B+['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5C 2024 – úloha 5.2', 'zad': [
        'Doplňte do rámečku takové číslo, aby platila rovnost.',
        '$\\frac{1}{4}$ kilogramu $+\\,1\\,250$ gramů $-\\,100$ gramů $=1$ kilogram $+\\,g\\,$ gramů, kde $g$ je hledaný počet gramů.'],
     'opts': None, 'ln': 2,
     'sol': ['$\\frac{1}{4}$ kg $=250$ g. Levá strana: $250+1\\,250-100=1\\,400$ g. Pravá strana: $1$ kg $+g=1\\,000+g$. Z rovnosti $1\\,400=1\\,000+g$ plyne $g=400$.'],
     'ans': '$400$', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B+['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5C 2024 – úloha 6', 'zad': [
        'Na číselné ose je vyznačeno $10$ shodných úseků, čísla $24$ a $64$ a neznámá čísla $A$ a $B$ (viz obrázek).',
        '6.1 Určete neznámá čísla $A$ a $B$.',
        '6.2 Určete součin čísel $A$ a $B$.'],
     'opts': None, 'ln': 2, 'svg': SVG6, 'fn': 'ciselna-osa.svg',
     'alt': 'Číselná osa s deseti shodnými úseky, vyznačenými čísly 24 a 64 a neznámými čísly A a B mezi nimi.',
     'cap': 'Číselná osa k úloze 6',
     'sol': ['Mezi čísly $24$ a $64$ je $5$ shodných úseků, jeden úsek má hodnotu $(64-24):5=8$.',
             '6.1 $A=24+8=32$, $B=24+3\\cdot 8=48$.',
             '6.2 $A\\cdot B=32\\cdot 48=1\\,536$.'],
     'ans': '6.1: $A=32$, $B=48$; 6.2: $A\\cdot B=1\\,536$', 'pts': 4, 'mins': 4, 'diff': '3',
     'codes': B+['aritmetika', 'porozumeni', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5C 2024 – úloha 7', 'zad': [
        'V rovině leží přímka $p$ a bod $K$, který neleží na této přímce (viz obrázek).',
        '7.1 Narýsujte jeden čtverec $KLMN$ tak, aby body $L$ a $M$ ležely na přímce $p$.',
        '7.2 Do stejného obrázku narýsujte rovnoramenný trojúhelník $KZM$ tak, aby ramena trojúhelníku tvořily úsečky $KM$ a $KZ$ a zároveň bod $Z$ ležel na přímce $p$. Při hledání bodu $Z$ použijte kružítko.'],
     'opts': None, 'ln': 0, 'svg': SVG7, 'fn': 'primka-bod-K.svg',
     'alt': 'Přímka p vedená šikmo a bod K nad ní, který na přímce neleží.',
     'cap': 'Výchozí obrázek k úloze 7',
     'sol': ['7.1 Z bodu $K$ spustíme kolmici na přímku $p$; její pata je vrchol $L$. Bod $M$ leží na přímce $p$ tak, že $|LM|=|KL|$ (strana čtverce). Vrchol $N$ doplníme tak, aby $KLMN$ byl čtverec ($|KN|=|LM|$, $KN$ rovnoběžné s $LM$).',
             '7.2 Rameno $KM$ je již sestrojeno. Bod $Z$ na přímce $p$ najdeme tak, aby $|KZ|=|KM|$: kružnice se středem $K$ a poloměrem $|KM|$ protne přímku $p$ v bodě $Z$ (různém od $M$). Trojúhelník $KZM$ je pak rovnoramenný se základnou $ZM$.'],
     'ans': 'Konstrukce: 7.1 čtverec $KLMN$ ($L$ pata kolmice z $K$ na $p$, $M$ na $p$ s $|LM|=|KL|$); 7.2 bod $Z$ na $p$ s $|KZ|=|KM|$ (kružnice se středem $K$, poloměr $|KM|$), trojúhelník $KZM$ rovnoramenný – viz náčrt v klíči.',
     'pts': 6, 'mins': 10, 'diff': '4',
     'codes': B+['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5C 2024 – úloha 8', 'zad': [
        'Ve čtvercové síti je nakreslen obrazec, který se skládá z částí označených písmeny $A$, $B$, $C$, $D$ a $E$ a jehož vrcholy leží v mřížových bodech. Každý čtvereček čtvercové sítě má stranu délky $1$ cm a obsah $1$ cm² (viz obrázek).',
        'Rozhodněte o každém z následujících tvrzení 8.1–8.3, zda je pravdivé (A), či nikoli (N).',
        '8.1 Obvod části $E$ je $18$ cm.',
        '8.2 Obsah části $A$ je právě čtyřikrát větší než obsah části $B$.',
        '8.3 Obsah celého obrazce je větší než $60$ cm².'],
     'opts': None, 'ln': 0, 'svg': SVG8, 'fn': 'obrazec-sit.svg',
     'alt': 'Obrazec ve čtvercové síti složený z trojúhelníkových částí A, B, C, D a svislého úzkého obdélníku E.',
     'cap': 'Schematický nákres obrazce ve čtvercové síti',
     'sol': ['8.1 Část $E$ je úzký obdélník o rozměrech $1$ cm krát $8$ cm, jeho obvod je $2\\cdot(1+8)=18$ cm – pravdivé (A).',
             '8.2 Obsah části $A$ není přesně čtyřnásobkem obsahu části $B$ – nepravdivé (N).',
             '8.3 Celkový obsah obrazce není větší než $60$ cm² – nepravdivé (N).'],
     'ans': '8.1: A; 8.2: N; 8.3: N', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B+['planimetrie', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5C 2024 – úloha 9', 'zad': [
        'Kilogram broskví stojí $32$ Kč a kilogram jablek $28$ Kč. Petra koupila stejný počet kilogramů jablek jako broskví a utratila $720$ Kč.',
        'Kolik kilogramů broskví Petra koupila?'],
     'opts': ['A) $6$', 'B) $8$', 'C) $10$', 'D) $12$', 'E) jiný počet'], 'ln': 0,
     'sol': ['Za $1$ kg broskví a $1$ kg jablek zaplatí $32+28=60$ Kč. Petra utratila $720$ Kč, tj. $720:60=12$ kg broskví (a $12$ kg jablek).'],
     'ans': 'D) $12$', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B+['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5C 2024 – úloha 10', 'zad': [
        'Zuzana měla pytlík s bonbóny, kterých bylo méně než $60$. Bonbóny se rozhodla rozdělit rovným dílem mezi své kamarády. Beze zbytku je mohla rozdělit mezi $2$, $3$ nebo $4$ kamarády. Pokud by však měla kamarádů $7$ a chtěla bonbóny rozdělit mezi ně, zbyly by jí právě $3$ bonbóny.',
        'Kolik bonbónů měla Zuzana v pytlíku?'],
     'opts': ['A) $24$', 'B) $36$', 'C) $42$', 'D) $48$', 'E) $56$'], 'ln': 0,
     'sol': ['Počet je dělitelný $2$, $3$ i $4$, tedy dělitelný $12$, a menší než $60$: možnosti $12$, $24$, $36$, $48$. Po dělení číslem $7$ dává zbytek $3$ jen $24$ ($24=3\\cdot 7+3$).'],
     'ans': 'A) $24$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B+['aritmetika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5C 2024 – úloha 11', 'zad': [
        'Do čtvercové sítě je zakreslen šedý čtyřúhelník, jehož vrcholy leží v mřížových bodech. Na otázku, jakou část z plochy čtvercové sítě zabírá plocha šedého čtyřúhelníku, odpověděla Alena, že je to více než polovina. Blanka odpověděla, že čtyřúhelník zabírá jednu polovinu čtvercové sítě. Cecílie odpověděla, že jde o tři šestiny čtvercové sítě, a Darina uvedla jako odpověď tři pětiny čtvercové sítě (viz obrázek).',
        'Kdo odpověděl správně?'],
     'opts': ['A) Alena a Darina', 'B) Blanka a Cecílie', 'C) jenom Alena', 'D) jenom Darina', 'E) ani jedna z dívek'], 'ln': 0,
     'svg': SVG11, 'fn': 'ctyruhelnik-sit.svg',
     'alt': 'Čtvercová síť tři krát tři se šedým čtyřúhelníkem, jehož vrcholy leží v mřížových bodech.',
     'cap': 'Šedý čtyřúhelník ve čtvercové síti',
     'sol': ['Čtvercová síť má $3\\times 3=9$ čtverečků. Obsah šedého čtyřúhelníku je $4{,}5$ čtverečku, tj. $\\frac{4{,}5}{9}=\\frac{1}{2}$ sítě. Polovinu uvedla Blanka; tři šestiny $\\frac{3}{6}=\\frac{1}{2}$ uvedla Cecílie – obě odpověděly správně.'],
     'ans': 'B) Blanka a Cecílie', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B+['planimetrie', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5C 2024 – úloha 12', 'zad': [
        'Tři sourozenci Sára, Dana a Lukáš postupně šetřili každý do své pokladničky peníze, které dostávali. Zároveň si ze své pokladničky brali peníze na drobnosti pro sebe či dárky pro ostatní. Graf znázorňuje částky, které si jednotliví sourozenci našetřili (nad osou), nebo které utratili (pod osou) každý měsíc v první polovině roku (viz graf).',
        '12.1 Kolik peněz měl v pokladničce Lukáš na konci června, když víme, že $1$. ledna měl v pokladničce $600$ Kč? Vyberte z možností: A) $200$ Kč, B) $400$ Kč, C) $750$ Kč, D) $1\\,000$ Kč, E) Výsledek nelze určit.',
        '12.2 O kolik se změnila částka, kterou měla v pokladničce Sára, za první polovinu roku? Vyberte z možností: A) $400$ Kč, B) $650$ Kč, C) $750$ Kč, D) $1\\,250$ Kč, E) $1\\,800$ Kč.',
        '12.3 Kolik peněz dohromady měli všichni sourozenci na konci června, když víme, že Sára měla v pokladničce $1$. ledna $1\\,050$ Kč, Dana $750$ Kč a Lukáš $600$ Kč? Vyberte z možností: A) Výsledek nelze určit, B) $1\\,250$ Kč, C) $1\\,800$ Kč, D) $2\\,400$ Kč, E) $4\\,200$ Kč.'],
     'opts': None, 'ln': 0, 'svg': SVG12, 'fn': 'graf-pokladnicky.svg',
     'alt': 'Sloupcový graf našetřených (nad osou) a utracených (pod osou) částek tří sourozenců Sáry, Dany a Lukáše za měsíce leden až červen.',
     'cap': 'Schematický nákres grafu (přesné hodnoty viz testový sešit)',
     'sol': ['12.1 Součet Lukášových měsíčních změn (našetřené minus utracené) je $+400$ Kč; k počátečním $600$ Kč: $600+400=1\\,000$ Kč → D.',
             '12.2 Změna Sářiny částky za pololetí je nárůst o $650$ Kč → B.',
             '12.3 Sářiny, Danovy a Lukášovy změny za pololetí dají dohromady $+1\\,800$ Kč; s počátečními $1\\,050+750+600=2\\,400$ Kč je konečný stav $2\\,400+1\\,800=4\\,200$ Kč → E.'],
     'ans': '12.1: D) $1\\,000$ Kč; 12.2: B) $650$ Kč; 12.3: E) $4\\,200$ Kč', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B+['statistika', 'porozumeni', 'pocetni', 'bez-kalkulacky', 'finance']},

    {'name': 'CERMAT M5C 2024 – úloha 13', 'zad': [
        'Katka jezdí každé ráno do školy a odpoledne ze školy na kole. Cesta do školy je do kopce, takže Katce trvá dvakrát déle než cesta ze školy. Obě cesty dohromady trvají Katce každý den $33$ minut.',
        'Ke každé podúloze (13.1–13.3) přiřaďte správný výsledek (A–F).',
        '13.1 V kolik hodin ráno nejpozději musí Katka vyjíždět do školy, aby byla ve škole právě $10$ minut před začátkem vyučování, které začíná v $8{:}00$?',
        '13.2 V kolik hodin ráno musí Katka nejpozději vycházet pěšky do školy, pokud má její třída sraz před školou v $8{:}10$ a cesta do školy pěšky jí trvá dvakrát déle než na kole?',
        '13.3 Pokud venku prší, jede Katka do školy autobusem. Autobusem Katce trvá cesta do školy stejně dlouho, jako jí trvá cesta ze školy na kole. V kolik hodin jí autobus vyjíždí od domu, pokud ke škole autobus přijíždí v $7{:}43$?'],
     'opts': ['A) $7{:}24$', 'B) $7{:}26$', 'C) $7{:}28$', 'D) $7{:}30$', 'E) $7{:}32$', 'F) $7{:}34$'], 'ln': 0,
     'sol': ['Cesta do školy trvá dvakrát déle než ze školy a součet je $33$ min: cesta ze školy $=11$ min, cesta do školy $=22$ min.',
             '13.1 Ve škole být v $7{:}50$ (10 min před $8{:}00$); $7{:}50$ mínus $22$ min $=7{:}28$ → C.',
             '13.2 Pěšky do školy trvá $2\\cdot 22=44$ min; u školy být v $8{:}10$; $8{:}10$ mínus $44$ min $=7{:}26$ → B.',
             '13.3 Autobusem trvá cesta $11$ min (jako ze školy na kole); $7{:}43$ mínus $11$ min $=7{:}32$ → E.'],
     'ans': '13.1: C ($7{:}28$); 13.2: B ($7{:}26$); 13.3: E ($7{:}32$)', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B+['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5C 2024 – úloha 14', 'zad': [
        'Tereza a Pepa šli hrát kuličky. Tereza si přinesla jen červené kuličky, měla jich $40$. Pepa si přinesl jen modré kuličky. První hru vyhrál Pepa a od Terezy vyhrál jednu čtvrtinu jejích červených kuliček. Druhou hru vyhrála Tereza a získala tak od Pepy $16$ modrých kuliček. Po těchto dvou hrách měli Pepa i Tereza stejný počet kuliček.',
        '14.1 Kolik modrých kuliček měla Tereza po těchto dvou hrách?',
        '14.2 Kolik kuliček měli Tereza a Pepa dohromady?',
        '14.3 Kolik modrých kuliček si na začátku přinesl Pepa?'],
     'opts': None, 'ln': 3,
     'sol': ['14.1 Tereza získala ve druhé hře $16$ modrých kuliček a jiné modré nemá – má tedy $16$ modrých kuliček.',
             '14.2 Po hrách má Tereza $40-\\frac{40}{4}=30$ červených a $16$ modrých, celkem $46$ kuliček. Oba mají stejně, proto dohromady $2\\cdot 46=92$ kuliček.',
             '14.3 Celkový počet kuliček se nemění a je $40$ (Tereziny) plus Pepovy modré. Z $40+p=92$ plyne $p=52$ modrých kuliček.'],
     'ans': '14.1: $16$; 14.2: $92$; 14.3: $52$', 'pts': 6, 'mins': 7, 'diff': '4',
     'codes': B+['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M5PCD24C0T03'
    gen.YEAR = 2024

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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M5C-2024')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
