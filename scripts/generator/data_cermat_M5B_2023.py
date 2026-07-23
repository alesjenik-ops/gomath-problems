# -*- coding: utf-8 -*-
# CERMAT – Jednotná přijímací zkouška 2023, MATEMATIKA 5B (osmileté obory, 5. ročník).
# Kód testu: M5PBD23C0T02. 14 úloh (po rozdělení nezávislých poduúloh 18 úloh), 50 bodů.
# Zdroj odpovědí: klíč správných řešení (KLIC_5B_2023).

# ---- SVG obrázky (bez ' a \) ----

# úloha 6: obdélník 10x24 rozdělený úhlopříčkami + schematické obrazce A, B, C, D
SVG6 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 580 175" font-family="sans-serif">
<g fill="none" stroke="#000" stroke-width="1.5">
<rect x="26" y="30" width="40" height="96"/>
<line x1="26" y1="30" x2="66" y2="126"/>
<line x1="66" y1="30" x2="26" y2="126"/>
</g>
<text x="46" y="145" font-size="12" text-anchor="middle">10 cm</text>
<text x="16" y="80" font-size="12" text-anchor="middle" transform="rotate(-90 16 80)">24 cm</text>
<g fill="#cfcfcf" stroke="#000" stroke-width="1.2">
<polygon points="150,45 195,45 205,72 172,120 140,72"/>
<polygon points="250,120 320,120 285,45"/>
<polygon points="410,45 424,72 452,80 424,88 410,120 396,88 368,80 396,72"/>
<polygon points="480,105 545,72 565,95 500,128"/>
</g>
<g font-size="12" text-anchor="middle">
<text x="172" y="140">Obrazec A</text>
<text x="285" y="140">Obrazec B</text>
<text x="410" y="140">Obrazec C</text>
<text x="522" y="145">Obrazec D</text>
</g>
</svg>"""

# úloha 7.1: bod F a přímka g
SVG7_1 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 230" font-family="sans-serif">
<line x1="40" y1="60" x2="420" y2="130" stroke="#000" stroke-width="2"/>
<text x="426" y="132" font-size="16" font-style="italic">g</text>
<text x="150" y="190" font-size="15" font-style="italic">F</text>
<text x="162" y="184" font-size="14">×</text>
</svg>"""

# úloha 7.2: body S, Q a přímka p
SVG7_2 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 220" font-family="sans-serif">
<line x1="40" y1="120" x2="440" y2="55" stroke="#000" stroke-width="2"/>
<text x="446" y="57" font-size="16" font-style="italic">p</text>
<text x="150" y="150" font-size="15" font-style="italic">S</text>
<text x="162" y="145" font-size="14">×</text>
<text x="222" y="182" font-size="15" font-style="italic">Q</text>
<text x="214" y="172" font-size="14">×</text>
</svg>"""

# úloha 8: čtvercová síť s obrazci A-F (schematicky)
def _grid8():
    ox, oy, c = 16, 16, 15
    COLS, ROWS = 24, 6
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {ox*2+COLS*c} {oy*2+ROWS*c}" font-family="sans-serif">']
    s.append('<g stroke="#bbb" stroke-width="1">')
    for i in range(COLS+1):
        x = ox+i*c
        s.append(f'<line x1="{x}" y1="{oy}" x2="{x}" y2="{oy+ROWS*c}"/>')
    for j in range(ROWS+1):
        y = oy+j*c
        s.append(f'<line x1="{ox}" y1="{y}" x2="{ox+COLS*c}" y2="{y}"/>')
    s.append('</g>')
    def P(col, row): return f'{ox+col*c},{oy+row*c}'
    s.append('<g fill="#fff" stroke="#000" stroke-width="1.6">')
    s.append(f'<polygon points="{P(1,1)} {P(5,1)} {P(1,3)}"/>')
    s.append(f'<rect x="{ox+9*c}" y="{oy+1*c}" width="{3*c}" height="{3*c}"/>')
    s.append(f'<polygon points="{P(17,1)} {P(17,5)} {P(20,5)}"/>')
    s.append('</g>')
    s.append('<g fill="#8a8a8a" stroke="#000" stroke-width="1.6">')
    s.append(f'<polygon points="{P(6,2)} {P(8,2)} {P(6,3)}"/>')
    s.append(f'<polygon points="{P(13,1)} {P(16,1)} {P(13,3)}"/>')
    s.append(f'<polygon points="{P(21,1)} {P(24,1)} {P(21,4)}"/>')
    s.append('</g>')
    s.append(f'<rect x="{ox+13*c}" y="{oy+1*c}" width="{3*c}" height="{2*c}" fill="none" stroke="#000" stroke-dasharray="4 3"/>')
    s.append('<g font-size="12" font-weight="bold" text-anchor="middle">')
    s.append(f'<text x="{ox+2*c}" y="{oy+2*c+2}">A</text>')
    s.append(f'<text x="{ox+7*c-4}" y="{oy+3*c-2}">B</text>')
    s.append(f'<text x="{ox+10*c+8}" y="{oy+3*c}">C</text>')
    s.append(f'<text x="{ox+14*c}" y="{oy+2*c+2}">D</text>')
    s.append(f'<text x="{ox+18*c}" y="{oy+4*c+4}">E</text>')
    s.append(f'<text x="{ox+22*c}" y="{oy+3*c}">F</text>')
    s.append('</g></svg>')
    return "".join(s)
SVG8 = _grid8()

# úloha 11: krychle s úsečkami a, b, c, d a pátou úsečkou 8 cm (schematicky)
SVG11 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 300 230" font-family="sans-serif">
<g fill="none" stroke="#999" stroke-width="1.2">
<rect x="70" y="80" width="120" height="120"/>
<line x1="70" y1="80" x2="125" y2="42"/>
<line x1="190" y1="80" x2="245" y2="42"/>
<line x1="190" y1="200" x2="245" y2="162"/>
<line x1="70" y1="200" x2="125" y2="162"/>
<line x1="125" y1="42" x2="245" y2="42"/>
<line x1="245" y1="42" x2="245" y2="162"/>
<line x1="125" y1="42" x2="125" y2="162"/>
<line x1="125" y1="162" x2="245" y2="162"/>
</g>
<g fill="none" stroke="#000" stroke-width="2">
<line x1="70" y1="80" x2="190" y2="200"/>
<line x1="70" y1="80" x2="245" y2="42"/>
<line x1="190" y1="80" x2="245" y2="162"/>
<line x1="70" y1="80" x2="70" y2="200"/>
<line x1="70" y1="200" x2="190" y2="200"/>
</g>
<g font-size="15" font-style="italic" text-anchor="middle">
<text x="58" y="145">c</text>
<text x="120" y="160">b</text>
<text x="130" y="216">a</text>
<text x="165" y="52">d</text>
</g>
<text x="230" y="118" font-size="13">8 cm</text>
</svg>"""

# úloha 12: prostorová stavba z válců (schematická poznámka)
SVG12 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 90" font-family="sans-serif">
<text x="280" y="35" font-size="13" text-anchor="middle">Stavba ze stejně velkých válců tří barev – pohled zepředu a shora (viz testový sešit).</text>
<text x="280" y="62" font-size="11" text-anchor="middle" fill="#666">Prostorovou stavbu nelze věrně přenést do SVG; posuzuje se podle originálu.</text>
</svg>"""

# úloha 14: 1., 2. a 3. obdélník z bílých a šedých trojúhelníků (schematicky)
SVG14 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 160" font-family="sans-serif">
<g stroke="#000" stroke-width="1.2" fill="#cfcfcf">
<rect x="30" y="55" width="40" height="24"/>
<rect x="120" y="45" width="80" height="40"/>
<rect x="250" y="35" width="120" height="56"/>
</g>
<g stroke="#000" stroke-width="0.8">
<line x1="30" y1="55" x2="70" y2="79"/><line x1="70" y1="55" x2="30" y2="79"/>
<line x1="120" y1="45" x2="200" y2="85"/><line x1="200" y1="45" x2="120" y2="85"/>
<line x1="160" y1="45" x2="160" y2="85"/>
<line x1="250" y1="35" x2="370" y2="91"/><line x1="370" y1="35" x2="250" y2="91"/>
<line x1="290" y1="35" x2="290" y2="91"/><line x1="330" y1="35" x2="330" y2="91"/>
</g>
<text x="398" y="70" font-size="26">...</text>
<g font-size="12" text-anchor="middle">
<text x="50" y="98">1. obdélník</text>
<text x="160" y="104">2. obdélník</text>
<text x="160" y="120">(6 bílých a 4 šedé čtverečky)</text>
<text x="310" y="108">3. obdélník</text>
</g>
</svg>"""

B = ['zs1']  # 5. ročník ZŠ (přijímačky na osmileté)

PROBLEMS = [
    {'name': 'CERMAT M5B 2023 – úloha 1.1', 'zad': ['Vypočtěte: $28-3\\cdot 2+18:2=$'], 'opts': None, 'ln': 2,
     'sol': ['Podle pořadí operací: $28-6+9=31$.'], 'ans': '$31$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5B 2023 – úloha 1.2', 'zad': ['Vypočtěte: $(8\\cdot 125+25)\\cdot(440:20-5\\cdot 4)=$'], 'opts': None, 'ln': 2,
     'sol': ['$(1000+25)\\cdot(22-20)=1025\\cdot 2=2050$.'], 'ans': '$2\\,050$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5B 2023 – úloha 2.1', 'zad': ['Vypočtěte v centimetrech: $2$ m $72$ cm $-\\,520$ mm $+\\,100$ cm $=$'], 'opts': None, 'ln': 2,
     'sol': ['$2$ m $72$ cm $=272$ cm, $520$ mm $=52$ cm. Potom $272-52+100=320$ cm.'], 'ans': '$320$ cm', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5B 2023 – úloha 2.2', 'zad': ['Hodiny, které jdou přesně, ukazují čas 21:42. Vypočtěte, jaký čas budou ukazovat za 212 minut.'], 'opts': None, 'ln': 2,
     'sol': ['212 minut = 3 hodiny 32 minut. Čas 21:42 + 3:32 = 25:14; po překročení půlnoci (odečtení 24 hodin) ukazují hodiny 1:14.'], 'ans': '1:14', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5B 2023 – úloha 3', 'zad': [
        'Přečteme-li číslo 2 073 zprava, získáme číslo 3 702. Kladné celé číslo, které čteme zleva i zprava stejně, se nazývá palindromické číslo, např. 73 937. Určete:',
        '3.1 nejmenší pěticiferné palindromické číslo, ve kterém se vyskytují tři různé číslice,',
        '3.2 počet všech palindromických čísel větších než 34 643 a zároveň menších než 35 253,',
        '3.3 nejmenší kladné číslo, jehož přičtením k palindromickému číslu 73 937 získáme opět palindromické číslo.'],
     'opts': None, 'ln': 3,
     'sol': ['3.1 Menší čísla $10\\,001$ a $10\\,101$ mají jen dvě různé číslice; nejmenší se třemi různými číslicemi je $10\\,201$.',
             '3.2 Vyhovují čísla $34\\,743$, $34\\,843$, $34\\,943$, $35\\,053$, $35\\,153$, tedy $5$ čísel.',
             '3.3 Nejbližší větší palindromické číslo za $73\\,937$ je $74\\,047$; $74\\,047-73\\,937=110$.'],
     'ans': '3.1: $10\\,201$; 3.2: $5$ palindromických čísel; 3.3: $110$', 'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5B 2023 – úloha 4.1', 'zad': [
        'V aquaparku je zapůjčení županu o 30 korun dražší než zapůjčení osušky. Zapůjčení 5 osušek stojí stejně jako zapůjčení 3 županů.',
        'Vypočtěte, kolik korun stojí v aquaparku zapůjčení jednoho županu.'],
     'opts': None, 'ln': 3,
     'sol': ['Zapůjčení osušky $o$, županu $o+30$. Z rovnice $5o=3(o+30)$ plyne $2o=90$, tedy $o=45$. Zapůjčení jednoho županu stojí $45+30=75$ korun.'],
     'ans': '$75$ korun', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['rovnice', 'modelovani', 'slovni', 'bez-kalkulacky', 'finance']},

    {'name': 'CERMAT M5B 2023 – úloha 4.2', 'zad': [
        'Na plaveckém tréninku uplavali Jirka, Míša a Pavla dohromady 60 bazénů. Míša uplavala stejný počet bazénů jako Jirka, ale dvakrát více bazénů než Pavla.',
        'Vypočtěte, kolik bazénů uplavala na tréninku Míša.'],
     'opts': None, 'ln': 3,
     'sol': ['Pavla uplavala $p$ bazénů, Míša $2p$ a Jirka také $2p$. Dohromady $2p+2p+p=5p=60$, tedy $p=12$. Míša uplavala $2\\cdot 12=24$ bazénů.'],
     'ans': '$24$ bazénů', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['rovnice', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5B 2023 – úloha 5', 'zad': [
        'Šest kamarádů si v mobilní aplikaci posílalo různé vzkazy. Vytvořili si mezi sebou jednak všechny možné pětičlenné skupiny, jednak všechny možné dvoučlenné skupiny. Určete, kolik vytvořili:',
        '5.1 pětičlenných skupin,',
        '5.2 dvoučlenných skupin.'],
     'opts': None, 'ln': 2,
     'sol': ['5.1 Pětičlenná skupina vznikne vynecháním jednoho ze šesti kamarádů, tedy $6$ skupin.',
             '5.2 Dvoučlenných skupin (dvojic) je $\\frac{6\\cdot 5}{2}=15$.'],
     'ans': '5.1: $6$ pětičlenných skupin; 5.2: $15$ dvoučlenných skupin', 'pts': 3, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5B 2023 – úloha 6', 'zad': [
        'Obdélník se stranami délek $10$ cm a $24$ cm byl rozdělen úhlopříčkami na čtyři rovnoramenné trojúhelníky. Z takových čtyř trojúhelníků je sestaven každý z obrazců A, B, C, D (viz obrázek). Obvody obrazců A, B se liší o $4$ cm.',
        '6.1 Vypočtěte, kolik cm měří obvod obrazce A.',
        '6.2 Vypočtěte, o kolik cm se liší obvody obrazců B, C.',
        '6.3 Vypočtěte, kolik cm měří obvod obrazce D.'],
     'opts': None, 'ln': 3, 'svg': SVG6, 'fn': 'obdelnik-obrazce.svg',
     'alt': 'Obdélník 10 cm krát 24 cm rozdělený úhlopříčkami na čtyři rovnoramenné trojúhelníky a schematické obrazce A, B, C, D z těchto trojúhelníků.',
     'cap': 'Schematický nákres (obrazce A–D viz testový sešit)',
     'sol': ['Úhlopříčky obdélníku $10\\times 24$ mají délku $\\sqrt{10^2+24^2}=26$ cm a rozdělují ho na čtyři rovnoramenné trojúhelníky s rameny $13$ cm: dva se základnou $10$ cm a dva se základnou $24$ cm.',
             '6.1 Obvod obrazce A tvoří čtyři základny: $10+10+24+24=68$ cm.',
             '6.2 Obvod obrazce B je $10+10+13+13+13+13=72$ cm, obvod obrazce C je $24+24+13+13+13+13=100$ cm; liší se o $28$ cm.',
             '6.3 Obvod obrazce D tvoří šest ramen: $6\\cdot 13=78$ cm.'],
     'ans': '6.1: $68$ cm; 6.2: o $28$ cm; 6.3: $78$ cm', 'pts': 4, 'mins': 6, 'diff': '4',
     'codes': B + ['planimetrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5B 2023 – úloha 7.1 (konstrukce)', 'zad': [
        'V rovině leží bod $F$ a přímka $g$ (viz obrázek).',
        'Bod $F$ je vrchol rovnoramenného trojúhelníku $EFG$. Strana $EF$ tohoto trojúhelníku měří $5$ cm a leží na kolmici k přímce $g$. Na přímce $g$ leží vrchol $G$ trojúhelníku $EFG$.',
        'Sestrojte vrcholy $E$, $G$ trojúhelníku $EFG$, označte je písmeny a trojúhelník narýsujte. Najděte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG7_1, 'fn': 'bod-primka-g.svg',
     'alt': 'Bod F a přímka g v rovině; přímka g mírně klesá zleva doprava, bod F leží pod ní.',
     'cap': 'Výchozí obrázek k úloze 7.1',
     'sol': ['Vrchol $E$ leží na kolmici k přímce $g$ vedené bodem $F$, ve vzdálenosti $|EF|=5$ cm od bodu $F$ (na straně k přímce $g$). Trojúhelník $EFG$ je rovnoramenný s rameny $|EF|=|EG|=5$ cm, proto vrchol $G$ leží na kružnici se středem $E$ a poloměrem $5$ cm. Průsečíky této kružnice s přímkou $g$ dávají dvě polohy vrcholu $G$ (dvě řešení).'],
     'ans': 'Dvě řešení: $E$ je bod na kolmici k $g$ vedené bodem $F$ ve vzdálenosti $5$ cm od $F$; vrcholy $G_1$, $G_2$ jsou průsečíky kružnice se středem $E$ a poloměrem $5$ cm s přímkou $g$ (viz náčrt v klíči).',
     'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5B 2023 – úloha 7.2 (konstrukce)', 'zad': [
        'V rovině leží body $S$, $Q$ a přímka $p$ (viz obrázek).',
        'Na přímce $p$ leží vrcholy $C$, $D$ obdélníku $ABCD$. Bod $S$ je střed strany $AD$ tohoto obdélníku. Bodem $Q$ prochází úhlopříčka obdélníku $ABCD$ (spojnice jeho protějších vrcholů).',
        'Sestrojte všechny vrcholy obdélníku $ABCD$, označte je písmeny a obdélník narýsujte. Najděte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG7_2, 'fn': 'body-SQ-primka-p.svg',
     'alt': 'Body S, Q a přímka p v rovině; přímka p mírně stoupá zleva doprava, body S a Q leží pod ní.',
     'cap': 'Výchozí obrázek k úloze 7.2',
     'sol': ['Strana $CD$ leží na přímce $p$, strany $AD$ a $BC$ jsou k $p$ kolmé. Protože $S$ je střed strany $AD$ a bod $D$ leží na $p$, je vrchol $D$ patou kolmice z bodu $S$ na přímku $p$ a vrchol $A$ je obrazem bodu $D$ ve středové souměrnosti se středem $S$ (výška obdélníku je dvojnásobek vzdálenosti bodu $S$ od $p$). Úhlopříčka procházející bodem $Q$ je buď $AC$, nebo $BD$: v prvním případě protne přímka $AQ$ přímku $p$ ve vrcholu $C$, ve druhém protne přímka $DQ$ rovnoběžku s $p$ vedenou bodem $A$ ve vrcholu $B$. Úloha má dvě řešení.'],
     'ans': 'Dvě řešení: $D$ je pata kolmice z $S$ na $p$, $A$ je souměrné s $D$ podle $S$; zbývající vrchol se určí tak, aby úhlopříčka ($AC$, resp. $BD$) procházela bodem $Q$ (viz náčrt v klíči).',
     'pts': 3, 'mins': 7, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5B 2023 – úloha 8', 'zad': [
        'Ve čtvercové síti jsou zakresleny bílé obrazce A, C, E a tmavé obrazce B, D, F (viz obrázek). Vrcholy všech obrazců leží v mřížových bodech čtvercové sítě. Obsah obrazce C je $9$ cm².',
        'Rozhodněte o každém z následujících tvrzení (8.1–8.3), zda je pravdivé (A), či nikoli (N).',
        '8.1 Obsah obrazce B tvoří čtvrtinu obsahu obrazce A.',
        '8.2 Obsah obrazce C je třikrát větší než obsah obrazce D.',
        '8.3 Obsah obrazce E je o třetinu větší než obsah obrazce F.'],
     'opts': None, 'ln': 0, 'svg': SVG8, 'fn': 'ctvercova-sit.svg',
     'alt': 'Čtvercová síť s bílými obrazci A, C, E a tmavými obrazci B, D, F; obrazce jsou pravoúhlé trojúhelníky a čtverec s vrcholy v mřížových bodech.',
     'cap': 'Schematický nákres obrazců ve čtvercové síti (obsah C = 9 cm²)',
     'sol': ['Obrazec C je čtverec $3\\times 3$ čtverečky s obsahem $9$ cm², takže jeden čtvereček sítě má obsah $1$ cm². Obsahy obrazců: A $=4$ cm², B $=1$ cm², C $=9$ cm², D $=3$ cm², E $=6$ cm², F $=4{,}5$ cm².',
             '8.1 $B=1=\\frac{1}{4}\\cdot 4$, tj. čtvrtina obsahu A — pravdivé (A).',
             '8.2 $C=9=3\\cdot 3=3D$ — pravdivé (A).',
             '8.3 $E=6=4{,}5+\\frac{1}{3}\\cdot 4{,}5$, tj. o třetinu více než F — pravdivé (A).'],
     'ans': '8.1: Ano (A); 8.2: Ano (A); 8.3: Ano (A)', 'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['planimetrie', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5B 2023 – úloha 9', 'zad': [
        'Každá bytost na planetě Zorstar má právě tři nohy a zároveň má buď tři oči, nebo čtyři oči. Na náměstí se sešly bytosti, které měly dohromady $84$ nohou. Mezi nimi bylo tříokých bytostí o $8$ více než čtyřokých.',
        'Kolik očí měly dohromady všechny bytosti, které se sešly na náměstí?'],
     'opts': ['A) 94 očí', 'B) 96 očí', 'C) 102 očí', 'D) 122 očí', 'E) 130 očí'], 'ln': 0,
     'sol': ['Každá bytost má 3 nohy, dohromady $84$ nohou, tedy $84:3=28$ bytostí. Čtyřokých je $x$, tříokých $x+8$; z $x+(x+8)=28$ plyne $x=10$. Čtyřokých je $10$, tříokých $18$. Očí celkem $18\\cdot 3+10\\cdot 4=54+40=94$.'],
     'ans': 'A) 94 očí', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5B 2023 – úloha 10', 'zad': [
        'Sára, Lukáš, Dan a Adéla hráli hru, ve které získávali body. Sára získala stejný počet bodů jako Lukáš. Dan získal 60 bodů, což je o polovinu bodů více, než získali Sára a Lukáš dohromady, ale o čtvrtinu bodů méně, než získala Adéla.',
        'Který z grafů zobrazuje odpovídající počty bodů získaných ve hře?'],
     'opts': ['A) Sára a Lukáš po 30, Dan 60, Adéla přes 60',
              'B) Sára a Lukáš po 10, Dan 60, Adéla 45',
              'C) Sára a Lukáš po 10, Dan 60, Adéla přes 60',
              'D) Sára a Lukáš po 20, Dan 60, Adéla 80',
              'E) Sára a Lukáš po 20, Dan 60, Adéla 45'], 'ln': 0,
     'sol': ['Dan má $60$ bodů. $60$ je o polovinu více než součet bodů Sáry a Lukáše: $60=\\frac{3}{2}(S+L)$, tedy $S+L=40$, a protože $S=L$, je $S=L=20$. $60$ je o čtvrtinu méně než body Adély: $60=\\frac{3}{4}A$, tedy $A=80$. Hledaný graf: Sára $20$, Lukáš $20$, Dan $60$, Adéla $80$ — graf D.'],
     'ans': 'D) Sára a Lukáš po 20, Dan 60, Adéla 80', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['statistika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M5B 2023 – úloha 11', 'zad': [
        'Na dřevěné krychli bylo vyznačeno pět úseček. Čtyři z nich jsou označeny písmeny $a$, $b$, $c$, $d$; u páté úsečky je zapsána její skutečná délka $8$ cm (viz obrázek). Skutečné délky úseček na krychli můžeme vzájemně porovnat.',
        'Které z následujících tvrzení je chybné?'],
     'opts': ['A) Úsečka $a$ je stejně dlouhá jako úsečka $c$.',
              'B) Úsečka $b$ je stejně dlouhá jako úsečka $d$.',
              'C) Úsečka $b$ měří $8$ cm.',
              'D) Úsečka $c$ je kratší než $8$ cm.',
              'E) Úsečka $d$ je delší než $8$ cm.'], 'ln': 0, 'svg': SVG11, 'fn': 'krychle-usecky.svg',
     'alt': 'Krychle v náryse s vyznačenými úsečkami a (hrana), b (stěnová úhlopříčka), c (hrana), d (stěnová úhlopříčka) a pátou úsečkou délky 8 cm.',
     'cap': 'Schematický nákres krychle s vyznačenými úsečkami',
     'sol': ['Úsečky $b$ a $d$ jsou shodné s pátou úsečkou (jsou to stěnové úhlopříčky krychle), takže $|b|=|d|=8$ cm. Úsečka $d$ proto není delší než $8$ cm — tvrzení E je chybné. Úsečky $a$ a $c$ jsou hrany krychle, jsou navzájem shodné a kratší než $8$ cm, takže tvrzení A, B, C, D jsou pravdivá.'],
     'ans': 'E) Úsečka $d$ je delší než $8$ cm.', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['stereometrie', 'porozumeni', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5B 2023 – úloha 12', 'zad': [
        'Stavba byla vytvořena ze stejně velkých válců tří různých barev. Stavbu jsme zobrazili při pohledu zepředu a shora (viz testový sešit).',
        'Který z obrázků A–E může představovat pohled na stavbu zprava?'],
     'opts': ['A) obrázek A', 'B) obrázek B', 'C) obrázek C', 'D) obrázek D', 'E) obrázek E'], 'ln': 0, 'svg': SVG12, 'fn': 'stavba-valce.svg',
     'alt': 'Schematická poznámka k prostorové stavbě ze stejně velkých válců tří barev.',
     'cap': 'Prostorová stavba z válců – viz testový sešit',
     'sol': ['Porovnáním pohledu zepředu a shora s nabízenými možnostmi (poloha a barvy válců při pohledu zprava) vyhovuje pouze obrázek E.'],
     'ans': 'E) obrázek E', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['stereometrie', 'porozumeni', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5B 2023 – úloha 13', 'zad': [
        'V každém diagramu se stejné symboly nahradí stejným kladným celým číslem a do prázdného oválu se doplní takové celé číslo, aby byly všechny výpočty ve směru šipek správné. Vzor: z čísla $20$ vznikne šipkou $\\cdot\\,\\ast+10$ číslo $50$ a další šipkou $:\\ast-\\ast$ prázdný ovál; pro $\\ast=2$ se do oválu doplní $23$ (neboť $50:2-2=23$).',
        '13.1 Z čísla $4$ vznikne šipkou $\\cdot\\,\\bullet\\cdot\\,\\bullet$ číslo $100$ a další šipkou $:4-2\\cdot\\bullet$ prázdný ovál.',
        '13.2 Z prázdného oválu vznikne šipkou $:\\star+\\star$ číslo $10$ a další šipkou $\\cdot\\,\\star-\\star$ číslo $72$.',
        '13.3 Z čísla $480$ vznikne šipkou $:\\odot-10$ prázdný ovál a další šipkou $\\cdot\\,10-\\odot$ číslo $120$.',
        'Přiřaďte ke každému diagramu (13.1–13.3) číslo (A–F) doplněné do prázdného oválu.'],
     'opts': ['A) 13', 'B) 14', 'C) 15', 'D) 16', 'E) 17', 'F) jiné číslo'], 'ln': 0,
     'sol': ['13.1 $4\\cdot\\bullet\\cdot\\bullet=100\\Rightarrow \\bullet^2=25\\Rightarrow \\bullet=5$; ovál $=100:4-2\\cdot 5=25-10=15$ — C.',
             '13.2 $10\\cdot\\star-\\star=72\\Rightarrow 9\\star=72\\Rightarrow \\star=8$; do počátečního oválu patří $(10-8)\\cdot 8=2\\cdot 8=16$ — D.',
             '13.3 Prostřední ovál $=480:\\odot-10$ a $(480:\\odot-10)\\cdot 10-\\odot=120\\Rightarrow \\odot^2+220\\odot-4800=0\\Rightarrow \\odot=20$; ovál $=480:20-10=14$ — B.'],
     'ans': '13.1: C ($15$); 13.2: D ($16$); 13.3: B ($14$)', 'pts': 5, 'mins': 6, 'diff': '4',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M5B 2023 – úloha 14', 'zad': [
        'Základním dílkem je 1. obdélník rozdělený na jeden bílý čtvereček a šest stejně velkých trojúhelníků; bílé trojúhelníky přiléhají ke kratším stranám obdélníku, šedé k delším stranám. Spojováním základních dílků vytváříme větší obdélníky podle pravidel: k sobě přiléhají pouze trojúhelníky téže barvy a jejich spojením vznikají další čtverečky; delší strana obdélníku je vždy dvakrát delší než kratší strana; v 1. obdélníku přiléhá ke kratší straně jeden bílý trojúhelník a v každém dalším obdélníku vždy o jeden bílý trojúhelník více než v předchozím (viz obrázek). 2. obdélník obsahuje 6 bílých a 4 šedé čtverečky.',
        '14.1 Určete, kolik čtverečků (bílých i šedých dohromady) obsahuje 4. obdélník.',
        '14.2 Určete, kolik šedých čtverečků obsahuje obdélník se 45 bílými čtverečky.',
        '14.3 Určete, kolik bílých čtverečků obsahuje obdélník, ve kterém je bílých čtverečků o 7 více než šedých.'],
     'opts': None, 'ln': 3, 'svg': SVG14, 'fn': 'obdelniky-14.svg',
     'alt': 'První, druhý a třetí obdélník sestavené z bílých a šedých trojúhelníků a čtverečků, rostoucí velikosti.',
     'cap': 'Schematický nákres 1., 2. a 3. obdélníku',
     'sol': ['V $n$-tém obdélníku je bílých čtverečků $B=2n^2-n$ a šedých $G=2n^2-2n$ (pro $n=2$: $B=6$, $G=4$); celkem $B+G=4n^2-3n$ a rozdíl $B-G=n$.',
             '14.1 Pro $n=4$: $4\\cdot 4^2-3\\cdot 4=64-12=52$ čtverečků.',
             '14.2 Z $2n^2-n=45$ plyne $n=5$; šedých je $G=2\\cdot 25-10=40$.',
             '14.3 $B-G=n=7$, tedy $n=7$; bílých je $B=2\\cdot 49-7=91$.'],
     'ans': '14.1: $52$ čtverečků; 14.2: $40$ šedých čtverečků; 14.3: $91$ bílých čtverečků', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['posloupnosti', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M5PBD23C0T02'
    gen.YEAR = 2023

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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M5B-2023')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
