# -*- coding: utf-8 -*-
# CERMAT – Přijímací zkoušky 2017, MATEMATIKA 7 A (šestileté obory, 7. ročník), 1. řádný termín.
# Kód testu: M7PAD17C0T01. 17 úloh v testu (po rozdělení nezávislých podúloh 3.1/3.2 celkem 18 záznamů), 50 bodů.
# Zdroj odpovědí: klíč správných řešení (KSR) + záznamový arch (VZA).

# ---- SVG obrázky (bez ' a \ ) ----

# úloha 5: dvě číselné osy s vyznačenými díly a šipkami (·2 a +36)
SVG5 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 720 200" font-family="sans-serif">
<line x1="40" y1="80" x2="330" y2="80" stroke="#000" stroke-width="2.5"/>
<line x1="90" y1="66" x2="90" y2="94" stroke="#000" stroke-width="2.5"/>
<line x1="150" y1="66" x2="150" y2="94" stroke="#000" stroke-width="2.5"/>
<line x1="210" y1="66" x2="210" y2="94" stroke="#000" stroke-width="2.5"/>
<line x1="270" y1="66" x2="270" y2="94" stroke="#000" stroke-width="2.5"/>
<text x="90" y="52" font-size="17" text-anchor="middle">A</text>
<text x="150" y="52" font-size="17" text-anchor="middle">B</text>
<text x="270" y="52" font-size="17" text-anchor="middle">36</text>
<path d="M90,96 Q180,168 266,102" fill="none" stroke="#000" stroke-width="2.5"/>
<polygon points="270,94 258,104 268,110" fill="#000"/>
<circle cx="180" cy="146" r="20" fill="#fff" stroke="#000" stroke-width="2.5"/>
<text x="180" y="153" font-size="16" text-anchor="middle" font-weight="bold">. 2</text>
<line x1="380" y1="80" x2="700" y2="80" stroke="#000" stroke-width="2.5"/>
<line x1="410" y1="66" x2="410" y2="94" stroke="#000" stroke-width="2.5"/>
<line x1="465" y1="66" x2="465" y2="94" stroke="#000" stroke-width="2.5"/>
<line x1="520" y1="66" x2="520" y2="94" stroke="#000" stroke-width="2.5"/>
<line x1="575" y1="66" x2="575" y2="94" stroke="#000" stroke-width="2.5"/>
<line x1="630" y1="66" x2="630" y2="94" stroke="#000" stroke-width="2.5"/>
<text x="465" y="52" font-size="17" text-anchor="middle">C</text>
<text x="575" y="52" font-size="17" text-anchor="middle">50</text>
<text x="630" y="52" font-size="17" text-anchor="middle">D</text>
<path d="M410,96 Q520,176 626,102" fill="none" stroke="#000" stroke-width="2.5"/>
<polygon points="630,94 618,104 628,110" fill="#000"/>
<circle cx="520" cy="152" r="22" fill="#fff" stroke="#000" stroke-width="2.5"/>
<text x="520" y="159" font-size="16" text-anchor="middle" font-weight="bold">+36</text>
</svg>"""

# úloha 8: papírový čtverec s odstřiženými rohy + složená krabice
SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 300" font-family="sans-serif">
<rect x="40" y="40" width="216" height="216" fill="#fff" stroke="#000" stroke-width="2.5"/>
<rect x="88" y="40" width="120" height="48" fill="#d9d9d9"/>
<rect x="88" y="208" width="120" height="48" fill="#d9d9d9"/>
<rect x="40" y="88" width="48" height="120" fill="#d9d9d9"/>
<rect x="208" y="88" width="48" height="120" fill="#d9d9d9"/>
<rect x="88" y="88" width="120" height="120" fill="#a8a8a8" stroke="#000" stroke-width="2"/>
<line x1="88" y1="40" x2="88" y2="256" stroke="#000" stroke-width="2" stroke-dasharray="8 6"/>
<line x1="208" y1="40" x2="208" y2="256" stroke="#000" stroke-width="2" stroke-dasharray="8 6"/>
<line x1="40" y1="88" x2="256" y2="88" stroke="#000" stroke-width="2" stroke-dasharray="8 6"/>
<line x1="40" y1="208" x2="256" y2="208" stroke="#000" stroke-width="2" stroke-dasharray="8 6"/>
<text x="44" y="74" font-size="13">4 dm²</text>
<text x="148" y="153" font-size="15" text-anchor="middle">25 dm²</text>
<polygon points="330,90 480,90 530,130 380,130" fill="#d9d9d9" stroke="#000" stroke-width="2.5"/>
<polygon points="330,90 380,130 380,210 330,170" fill="#e6e6e6" stroke="#000" stroke-width="2.5"/>
<polygon points="380,130 530,130 530,210 380,210" fill="#bdbdbd" stroke="#000" stroke-width="2.5"/>
<text x="455" y="245" font-size="14" text-anchor="middle">krabice</text>
</svg>"""

# úloha 9: výchozí obrázek – pravoúhlý trojúhelník ABC
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 280" font-family="sans-serif">
<polygon points="120,230 430,200 330,60" fill="none" stroke="#000" stroke-width="2.5"/>
<text x="104" y="248" font-size="17" font-style="italic">A</text>
<text x="440" y="204" font-size="17" font-style="italic">B</text>
<text x="326" y="46" font-size="17" font-style="italic">C</text>
</svg>"""

# úloha 10: výchozí obrázek – přímka q, bod C na ní, bod P mimo ni
SVG10 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 300" font-family="sans-serif">
<line x1="60" y1="222" x2="470" y2="86" stroke="#000" stroke-width="2.5"/>
<text x="62" y="248" font-size="17" font-style="italic">q</text>
<line x1="372" y1="106" x2="386" y2="130" stroke="#000" stroke-width="2.5"/>
<text x="372" y="98" font-size="17" font-style="italic">C</text>
<text x="292" y="236" font-size="18" text-anchor="middle">x</text>
<text x="292" y="256" font-size="17" text-anchor="middle" font-style="italic">P</text>
</svg>"""

# úloha 11: čtverec (otočený) rozdělený na 8 shodných trojúhelníků – 5 tmavých, 3 světlé
SVG11 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 400" font-family="sans-serif">
<polygon points="200,30 115,115 200,200" fill="#cfcfcf"/>
<polygon points="30,200 115,115 200,200" fill="#cfcfcf"/>
<polygon points="30,200 200,200 285,285" fill="#cfcfcf"/>
<polygon points="30,200 285,285 115,285" fill="#cfcfcf"/>
<polygon points="115,285 285,285 200,370" fill="#cfcfcf"/>
<polygon points="200,30 200,200 285,115" fill="#fff"/>
<polygon points="285,115 200,200 370,200" fill="#fff"/>
<polygon points="370,200 200,200 285,285" fill="#fff"/>
<polygon points="30,200 200,30 370,200 200,370" fill="none" stroke="#000" stroke-width="3"/>
<line x1="200" y1="30" x2="200" y2="200" stroke="#000" stroke-width="2"/>
<line x1="115" y1="115" x2="200" y2="200" stroke="#000" stroke-width="2"/>
<line x1="30" y1="200" x2="200" y2="200" stroke="#000" stroke-width="2"/>
<line x1="285" y1="115" x2="200" y2="200" stroke="#000" stroke-width="2"/>
<line x1="370" y1="200" x2="200" y2="200" stroke="#000" stroke-width="2"/>
<line x1="285" y1="285" x2="200" y2="200" stroke="#000" stroke-width="2"/>
<line x1="285" y1="285" x2="30" y2="200" stroke="#000" stroke-width="2"/>
<line x1="285" y1="285" x2="115" y2="285" stroke="#000" stroke-width="2"/>
</svg>"""

# úloha 12: osově souměrný obrazec (trojúhelník + obdélník) s kótami
SVG12 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 330" font-family="sans-serif">
<polygon points="240,36 383,140 97,140" fill="#b5b5b5" stroke="#000" stroke-width="2.5"/>
<rect x="201" y="140" width="78" height="130" fill="#b5b5b5" stroke="#000" stroke-width="2.5"/>
<line x1="240" y1="20" x2="240" y2="308" stroke="#000" stroke-width="1.5" stroke-dasharray="14 5 3 5"/>
<text x="228" y="18" font-size="15" font-style="italic">o</text>
<line x1="240" y1="36" x2="470" y2="36" stroke="#000" stroke-width="1"/>
<line x1="97" y1="270" x2="470" y2="270" stroke="#000" stroke-width="1"/>
<line x1="440" y1="36" x2="440" y2="270" stroke="#000" stroke-width="1.5"/>
<polygon points="440,36 435,50 445,50" fill="#000"/><polygon points="440,270 435,256 445,256" fill="#000"/>
<text x="456" y="160" font-size="16">9 cm</text>
<line x1="70" y1="140" x2="70" y2="270" stroke="#000" stroke-width="1.5"/>
<polygon points="70,140 65,154 75,154" fill="#000"/><polygon points="70,270 65,256 75,256" fill="#000"/>
<line x1="70" y1="140" x2="97" y2="140" stroke="#000" stroke-width="1"/>
<text x="14" y="212" font-size="16">5 cm</text>
<line x1="279" y1="168" x2="383" y2="168" stroke="#000" stroke-width="1.5"/>
<polygon points="279,168 293,163 293,173" fill="#000"/><polygon points="383,168 369,163 369,173" fill="#000"/>
<text x="300" y="192" font-size="16">4 cm</text>
<line x1="201" y1="296" x2="240" y2="296" stroke="#000" stroke-width="1.5"/>
<polygon points="201,296 215,291 215,301" fill="#000"/><polygon points="240,296 226,291 226,301" fill="#000"/>
<text x="180" y="322" font-size="16">1,5 cm</text>
</svg>"""

# úloha 13: lichoběžník ABCD s úhly 93 stupňů, 27 stupňů, pravým úhlem u C a úhlem beta
SVG13 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 220" font-family="sans-serif">
<polygon points="70,170 380,170 300,50 100,50" fill="none" stroke="#000" stroke-width="2.5"/>
<line x1="70" y1="170" x2="300" y2="50" stroke="#000" stroke-width="2.5"/>
<g fill="none" stroke="#000" stroke-width="1.6">
<path d="M93,79 A30,30 0 0,1 130,50"/>
<path d="M254,50 A46,46 0 0,1 259,71"/>
<path d="M346,170 A34,34 0 0,1 361,142"/>
</g>
<text x="106" y="94" font-size="15">93°</text>
<text x="226" y="76" font-size="15">27°</text>
<circle cx="295" cy="72" r="3.5" fill="#000"/>
<text x="336" y="162" font-size="15" font-style="italic">β</text>
<text x="60" y="192" font-size="16" font-style="italic">A</text>
<text x="380" y="192" font-size="16" font-style="italic">B</text>
<text x="300" y="40" font-size="16" font-style="italic">C</text>
<text x="90" y="40" font-size="16" font-style="italic">D</text>
</svg>"""


# úlohy 14 a 15: pruhový graf – počet dnů (doma 9, na chatě 12, ostatní chybí)
def _graf():
    rows = [("doma", 9), ("na táboře", 0), ("u babičky", 0), ("u kamarádky", 0), ("na chatě", 12)]
    x0, y0, u, rh = 180, 30, 15, 38
    yb = y0 + 5 * rh
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 285" font-family="sans-serif">']
    s.append('<g stroke="#999" stroke-width="0.8">')
    s += [f'<line x1="{x0+i*u}" y1="{y0}" x2="{x0+i*u}" y2="{yb}"/>' for i in range(1, 28, 2)]
    s.append('</g><g stroke="#555" stroke-width="1.4">')
    s += [f'<line x1="{x0+i*u}" y1="{y0}" x2="{x0+i*u}" y2="{yb}"/>' for i in range(0, 29, 2)]
    s.append('</g><g fill="none" stroke="#000" stroke-width="1.6">')
    s += [f'<rect x="{x0}" y="{y0+j*rh}" width="{28*u}" height="{rh}"/>' for j in range(5)]
    s.append('</g><g font-size="14" text-anchor="end">')
    s += [f'<text x="{x0-10}" y="{y0+j*rh+24}">{r[0]}</text>' for j, r in enumerate(rows)]
    s.append('</g><g fill="#c9c9c9" stroke="#000" stroke-width="1.6">')
    s += [f'<rect x="{x0}" y="{y0+j*rh+10}" width="{r[1]*u}" height="18"/>' for j, r in enumerate(rows) if r[1]]
    s.append('</g><g font-size="13" text-anchor="middle">')
    s += [f'<text x="{x0+v*u}" y="{yb+20}">{v}</text>' for v in range(0, 29, 2)]
    s.append(f'<text x="{x0+14*u}" y="{yb+44}" font-size="14">počet dnů</text></g></svg>')
    return "".join(s)


SVG14 = _graf()

B = ['zs2', 'r7']

PROBLEMS = [
    {'name': 'CERMAT M7A 2017 – úloha 1', 'zad': ['Vypočtěte:', '$(-3-2)\\cdot(21-3\\cdot 8)=$'], 'opts': None, 'ln': 2,
     'sol': ['V závorkách: $-3-2=-5$ a $21-3\\cdot 8=21-24=-3$.', 'Součin: $(-5)\\cdot(-3)=15$.'],
     'ans': '$15$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2017 – úloha 2', 'zad': ['Vypočtěte:', '$0{,}25\\cdot 400+0{,}4:0{,}01=$'], 'opts': None, 'ln': 2,
     'sol': ['$0{,}25\\cdot 400=100$, $0{,}4:0{,}01=40$.', 'Celkem $100+40=140$.'],
     'ans': '$140$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2017 – úloha 3.1', 'zad': [
        'Vypočtěte a výsledek uveďte zlomkem v základním tvaru. Uveďte postup řešení.',
        '$\\frac{5}{4}\\cdot\\left(\\frac{1}{5}+\\frac{3}{7}\\right)=$'], 'opts': None, 'ln': 5,
     'sol': ['V závorce: $\\frac{1}{5}+\\frac{3}{7}=\\frac{7}{35}+\\frac{15}{35}=\\frac{22}{35}$.',
             'Součin: $\\frac{5}{4}\\cdot\\frac{22}{35}=\\frac{110}{140}=\\frac{11}{14}$.'],
     'ans': '$\\frac{11}{14}$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2017 – úloha 3.2', 'zad': [
        'Vypočtěte a výsledek uveďte zlomkem v základním tvaru. Uveďte postup řešení.',
        '$\\frac{1:\\frac{3}{2}+\\frac{1}{3}}{\\frac{5}{6}+\\frac{1}{4}}=$'], 'opts': None, 'ln': 5,
     'sol': ['Čitatel: $1:\\frac{3}{2}+\\frac{1}{3}=\\frac{2}{3}+\\frac{1}{3}=1$.',
             'Jmenovatel: $\\frac{5}{6}+\\frac{1}{4}=\\frac{10}{12}+\\frac{3}{12}=\\frac{13}{12}$.',
             'Podíl: $1:\\frac{13}{12}=\\frac{12}{13}$.'],
     'ans': '$\\frac{12}{13}$', 'pts': 2, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2017 – úloha 4', 'zad': [
        'Vyškrtnutím tří číslic z osmiciferného čísla $42\\,680\\,153$ vznikne pěticiferné číslo (např. vyškrtnutím číslic 6, 0, 1 dostaneme $42\\,853$).',
        'Vyškrtněte tři číslice tak, abyste dostali:',
        '4.1 co nejmenší číslo;',
        '4.2 co nejmenší číslo dělitelné pěti.'], 'opts': None, 'ln': 3,
     'sol': ['4.1 Pořadí číslic se zachovává. Na první místo lze dostat nejméně 2 (vyškrtneme 4), pak co nejdříve 0 (vyškrtneme 6 a 8): zbývá $20\\,153$.',
             '4.2 Číslo musí končit číslicí 0, nebo 5. Konec na 0 dává $42\\,680$; konec na 5 dává nejméně $26\\,015$ (vyškrtneme 4, 8 a poslední 3). Menší je $26\\,015$.'],
     'ans': '4.1: $20\\,153$; 4.2: $26\\,015$', 'pts': 2, 'mins': 5, 'diff': '4',
     'codes': B + ['aritmetika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2017 – úloha 5', 'zad': [
        'Na první číselné ose jsou vyznačeny tři stejně velké díly, na druhé ose čtyři. $A$, $B$, $C$, $D$ představují čtyři neznámá čísla. Šipka na první ose znamená vynásobení dvěma, šipka na druhé ose přičtení čísla 36.',
        '5.1 Určete neznámá čísla $A$ a $B$.',
        '5.2 Určete neznámá čísla $C$ a $D$.'], 'opts': None, 'ln': 4,
     'svg': SVG5, 'fn': 'ciselne-osy.svg',
     'alt': 'Dvě číselné osy: na první díly s body A, B a 36 a šipka krát 2, na druhé díly s body C, 50 a D a šipka plus 36.',
     'cap': 'Výchozí obrázek k úloze 5',
     'sol': ['5.1 Šipka vede z bodu $A$ do čísla 36, tedy $2A=36$, $A=18$. Tři stejné díly mezi 18 a 36 mají velikost $(36-18):3=6$, proto $B=18+6=24$.',
             '5.2 Šipka vede z prvního dílku do bodu $D$, tedy $D$ je o 36 větší; čtyři díly odpovídají 36, jeden díl je $36:4=9$. Z čísla 50 (čtvrtý dílek) plyne $D=50+9=59$ a $C=50-2\\cdot 9=32$.'],
     'ans': '5.1: $A=18$; $B=24$; 5.2: $C=32$; $D=59$', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2017 – úloha 6', 'zad': [
        'Tři různé tyče měří 24 cm, 60 cm a 84 cm. Úkolem je rozřezat beze zbytku všechny tři tyče na co nejmenší počet stejně dlouhých dílů. Po rozřezání tyčí se všechny plochy vzniklé po řezu obarví.',
        '6.1 Vypočtěte v cm délku jednoho dílu.',
        '6.2 Určete, kolik dílů bude třeba obarvit z obou stran.'], 'opts': None, 'ln': 4,
     'sol': ['6.1 Nejmenší počet dílů dostaneme při největší možné délce dílu, tj. $D(24;60;84)=12$ cm.',
             '6.2 Počty dílů: $24:12=2$, $60:12=5$, $84:12=7$. Z obou stran se barví jen vnitřní díly, tedy $0+3+5=8$ dílů.'],
     'ans': '6.1: $12$ cm; 6.2: $8$ dílů', 'pts': 2, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7A 2017 – úloha 7', 'zad': [
        'Běžec udržuje stálé tempo. Každých $0{,}2$ km uběhne za 45 s. Uveďte postup řešení.',
        '7.1 Určete v minutách a sekundách, za jak dlouho uběhne 1 km.',
        '7.2 Určete počet metrů, které uběhne za 9 minut.'], 'opts': None, 'ln': 6,
     'sol': ['7.1 $1$ km $=5\\cdot 0{,}2$ km, tedy $5\\cdot 45$ s $=225$ s $=3$ min $45$ s.',
             '7.2 $9$ min $=540$ s $=12\\cdot 45$ s, tedy $12\\cdot 0{,}2$ km $=2{,}4$ km $=2\\,400$ m.'],
     'ans': '7.1: $3$ min $45$ s; 7.2: $2\\,400$ m', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7A 2017 – úloha 8', 'zad': [
        'V každém rohu papírového čtverce odstřihneme bílý čtverec o obsahu $4$ dm². Přehneme hrany, složíme krabici a spoje přelepíme izolepou. Dno krabice má obsah $25$ dm². Uveďte postup řešení.',
        '8.1 Vypočtěte v dm obvod papírového čtverce (před odstřižením v rozích).',
        '8.2 Vypočtěte v dm³ objem krabice.'], 'opts': None, 'ln': 6,
     'svg': SVG8, 'fn': 'krabice.svg',
     'alt': 'Papírový čtverec s odstřiženými rohovými čtverci o obsahu 4 dm² a vyznačeným dnem o obsahu 25 dm², vedle složená krabice.',
     'cap': 'Výchozí obrázek k úloze 8',
     'sol': ['8.1 Dno má obsah $25$ dm², jeho strana je $5$ dm. Odstřižený čtverec má obsah $4$ dm², jeho strana (= výška krabice) je $2$ dm. Strana papírového čtverce je $2+5+2=9$ dm, obvod $4\\cdot 9=36$ dm.',
             '8.2 Objem $=25\\cdot 2=50$ dm³.'],
     'ans': '8.1: $36$ dm; 8.2: $50$ dm³', 'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['stereometrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7A 2017 – úloha 9 (konstrukce)', 'zad': [
        'V rovině leží pravoúhlý trojúhelník $ABC$ (viz obrázek).',
        '9.1 Vrcholy trojúhelníku $ABC$ jsou současně vrcholy rovnoběžníku $ABCD$. Sestrojte chybějící vrchol $D$ rovnoběžníku $ABCD$ a rovnoběžník narýsujte.',
        '9.2 V trojúhelníku $ABC$ sestrojte výšku na stranu $AB$. Průsečík výšky a přímky $AB$ označte $P$. Bod $P$ se nazývá pata výšky.',
        '9.3 V trojúhelníku $ABD$ sestrojte výšku na stranu $AB$ a patu výšky označte $Q$.'], 'opts': None, 'ln': 0,
     'svg': SVG9, 'fn': 'trojuhelnik-abc.svg',
     'alt': 'Pravoúhlý trojúhelník ABC v rovině s vrcholy A vlevo dole, B vpravo a C nahoře.',
     'cap': 'Výchozí obrázek k úloze 9',
     'sol': ['9.1 V rovnoběžníku $ABCD$ platí $AB \\parallel DC$ a $AD \\parallel BC$. Vrchol $D$ leží v průsečíku rovnoběžky s $AB$ vedené bodem $C$ a rovnoběžky s $BC$ vedené bodem $A$.',
             '9.2 Výška z vrcholu $C$ je kolmice k přímce $AB$ procházející bodem $C$; její průsečík s přímkou $AB$ je pata výšky $P$ (leží uvnitř strany $AB$).',
             '9.3 Výška trojúhelníku $ABD$ na stranu $AB$ je kolmice k přímce $AB$ vedená bodem $D$; pata výšky $Q$ leží na přímce $AB$ vně strany $AB$ (za bodem $A$).'],
     'ans': 'Rovnoběžník $ABCD$ ($D$ je průsečík rovnoběžky s $AB$ bodem $C$ a rovnoběžky s $BC$ bodem $A$), pata výšky $P$ na straně $AB$ z vrcholu $C$ a pata výšky $Q$ na přímce $AB$ z vrcholu $D$ – viz obrázek v klíči.',
     'pts': 3, 'mins': 7, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2017 – úloha 10 (konstrukce)', 'zad': [
        'V rovině leží přímka $q$, na ní bod $C$ a mimo ni bod $P$ (viz obrázek).',
        'Bod $C$ je vrchol pravoúhlého trojúhelníku $ABC$ s pravým úhlem při vrcholu $C$. Strana $AC$ leží na přímce $q$. Bod $P$ je pata výšky na stranu $AB$.',
        'Sestrojte chybějící vrcholy $A$, $B$ trojúhelníku $ABC$ a trojúhelník narýsujte.'], 'opts': None, 'ln': 0,
     'svg': SVG10, 'fn': 'primka-q.svg',
     'alt': 'Přímka q stoupající zleva doprava, bod C na přímce a bod P pod přímkou.',
     'cap': 'Výchozí obrázek k úloze 10',
     'sol': ['Bod $P$ je pata výšky z vrcholu $C$, proto je $CP$ kolmá na stranu $AB$. Narýsujeme úsečku $CP$.',
             'Bodem $P$ vedeme kolmici k přímce $CP$ – na ní leží strana $AB$. Průsečík této kolmice s přímkou $q$ je vrchol $A$.',
             'Bodem $C$ vedeme kolmici k přímce $q$ (pravý úhel při vrcholu $C$); její průsečík s přímkou $AB$ je vrchol $B$. Trojúhelník $ABC$ narýsujeme.'],
     'ans': 'Konstrukce trojúhelníku $ABC$: $AB$ je kolmice k $CP$ vedená bodem $P$, $A$ je průsečík této kolmice s přímkou $q$, $B$ je průsečík kolmice k $q$ v bodě $C$ s přímkou $AB$ – viz obrázek v klíči.',
     'pts': 3, 'mins': 7, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2017 – úloha 11', 'zad': [
        'Čtverec je rozdělen na tmavé a světlé díly. Všechny díly mají stejný obsah. Podíl tmavé (světlé) části ve čtverci lze vyjádřit zlomkem nebo desetinným číslem.',
        'Rozhodněte o každém z následujících tvrzení (11.1–11.3), zda je pravdivé (A), či nikoli (N).',
        '11.1 Zlomek vyjadřující podíl tmavé části ve čtverci je roven součtu $\\frac{1}{2}+\\frac{1}{8}$.',
        '11.2 Světlá část tvoří $0{,}3$ čtverce.',
        '11.3 Když $\\frac{1}{5}$ tmavé části nahradíme světlou, světlá část vyplní $\\frac{1}{2}$ čtverce.'], 'opts': None, 'ln': 0,
     'svg': SVG11, 'fn': 'ctverec-dily.svg',
     'alt': 'Čtverec otočený o 45 stupňů rozdělený na osm shodných trojúhelníků, z nichž pět je tmavých a tři světlé.',
     'cap': 'Výchozí obrázek k úloze 11',
     'sol': ['Čtverec je rozdělen na 8 dílů stejného obsahu, z nichž 5 je tmavých a 3 světlé. Tmavá část je $\\frac{5}{8}$, světlá $\\frac{3}{8}$.',
             '11.1 $\\frac{1}{2}+\\frac{1}{8}=\\frac{5}{8}$ – souhlasí, tvrzení je pravdivé (A).',
             '11.2 $\\frac{3}{8}=0{,}375\\neq 0{,}3$ – tvrzení není pravdivé (N).',
             '11.3 $\\frac{1}{5}$ z $\\frac{5}{8}$ je $\\frac{1}{8}$; světlá část pak tvoří $\\frac{3}{8}+\\frac{1}{8}=\\frac{4}{8}=\\frac{1}{2}$ – pravdivé (A).'],
     'ans': '11.1: Ano; 11.2: Ne; 11.3: Ano', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['planimetrie', 'argumentace', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2017 – úloha 12', 'zad': [
        'Obrazec se skládá z trojúhelníku a obdélníku. Obrazec je osově souměrný podle osy souměrnosti $o$. Celková výška obrazce je $9$ cm, výška obdélníku je $5$ cm, vzdálenost osy $o$ od boční strany obdélníku je $1{,}5$ cm a vzdálenost boční strany obdélníku od krajního vrcholu trojúhelníku je $4$ cm.',
        'Jaký je obsah obrazce?'],
     'opts': ['A) $37$ cm²', 'B) $38$ cm²', 'C) $39$ cm²', 'D) $40$ cm²', 'E) větší než $40$ cm²'], 'ln': 0,
     'svg': SVG12, 'fn': 'obrazec-osa.svg',
     'alt': 'Osově souměrný obrazec: trojúhelník nahoře a obdélník dole, s kótami 9 cm, 5 cm, 4 cm a 1,5 cm.',
     'cap': 'Výchozí obrázek k úloze 12',
     'sol': ['Obdélník: šířka $2\\cdot 1{,}5=3$ cm, výška $5$ cm, obsah $3\\cdot 5=15$ cm².',
             'Trojúhelník: základna $2\\cdot(1{,}5+4)=11$ cm, výška $9-5=4$ cm, obsah $\\frac{11\\cdot 4}{2}=22$ cm².',
             'Celkem $15+22=37$ cm².'],
     'ans': 'A) $37$ cm²', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2017 – úloha 13', 'zad': [
        'Rovinný obrazec $ABCD$ je lichoběžník se základnami $AB$ a $DC$. Je narýsována úhlopříčka $AC$. Úhel při vrcholu $D$ má velikost $93^\\circ$, úhel $DCA$ má velikost $27^\\circ$ a úhel $ACB$ je pravý.',
        'Jaká je velikost úhlu $\\beta$ při vrcholu $B$? Úhel $\\beta$ neměřte, ale vypočtěte.'],
     'opts': ['A) menší než $55^\\circ$', 'B) $55^\\circ$', 'C) $57^\\circ$', 'D) $60^\\circ$', 'E) $63^\\circ$'], 'ln': 0,
     'svg': SVG13, 'fn': 'lichobeznik.svg',
     'alt': 'Lichoběžník ABCD s úhlopříčkou AC, úhlem 93 stupňů u D, úhlem 27 stupňů mezi DC a AC, pravým úhlem u C a úhlem beta u B.',
     'cap': 'Výchozí obrázek k úloze 13',
     'sol': ['Protože $DC \\parallel AB$, jsou úhly $DCA$ a $CAB$ střídavé, tedy $|\\angle CAB|=27^\\circ$.',
             'V trojúhelníku $ABC$ platí $27^\\circ+90^\\circ+\\beta=180^\\circ$, tedy $\\beta=63^\\circ$.'],
     'ans': 'E) $63^\\circ$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7A 2017 – úloha 14', 'zad': [
        'Katka strávila prázdniny na několika místech. Nejprve byla doma. Na táboře strávila o třetinu více času než doma. U babičky byla o čtvrtinu kratší dobu než na táboře. Pak zůstala u kamarádky. Od ní odjela na chatu, kde pobývala o polovinu delší dobu než u kamarádky. V grafu je vyznačen tmavými pásy počet dnů strávených doma (9 dnů) a na chatě (12 dnů), další údaje chybí.',
        'Kolik dnů strávila Katka u babičky?'],
     'opts': ['A) 6 dnů', 'B) 7 dnů', 'C) 8 dnů', 'D) 9 dnů', 'E) jiný počet dnů'], 'ln': 0,
     'svg': SVG14, 'fn': 'graf-prazdniny.svg',
     'alt': 'Pruhový graf s pěti řádky (doma, na táboře, u babičky, u kamarádky, na chatě); vyplněny jsou jen pruhy doma 9 dnů a na chatě 12 dnů, osa 0 až 28 dnů.',
     'cap': 'Počet dnů strávených na jednotlivých místech',
     'sol': ['Doma $9$ dnů. Na táboře o třetinu více: $9+3=12$ dnů.',
             'U babičky o čtvrtinu kratší dobu než na táboře: $12-3=9$ dnů.'],
     'ans': 'D) 9 dnů', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['statistika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7A 2017 – úloha 15', 'zad': [
        'Katka strávila prázdniny na několika místech. Nejprve byla doma. Na táboře strávila o třetinu více času než doma. U babičky byla o čtvrtinu kratší dobu než na táboře. Pak zůstala u kamarádky. Od ní odjela na chatu, kde pobývala o polovinu delší dobu než u kamarádky. V grafu je vyznačen tmavými pásy počet dnů strávených doma (9 dnů) a na chatě (12 dnů), další údaje chybí.',
        'Kolik dnů strávila Katka u kamarádky?'],
     'opts': ['A) 6 dnů', 'B) 7 dnů', 'C) 8 dnů', 'D) 9 dnů', 'E) jiný počet dnů'], 'ln': 0,
     'svg': SVG14, 'fn': 'graf-prazdniny.svg',
     'alt': 'Pruhový graf s pěti řádky (doma, na táboře, u babičky, u kamarádky, na chatě); vyplněny jsou jen pruhy doma 9 dnů a na chatě 12 dnů, osa 0 až 28 dnů.',
     'cap': 'Počet dnů strávených na jednotlivých místech',
     'sol': ['Na chatě byla o polovinu déle než u kamarádky, tedy chata $=1{,}5\\cdot$ kamarádka.',
             'Z grafu chata $=12$ dnů, proto u kamarádky $12:1{,}5=8$ dnů.'],
     'ans': 'C) 8 dnů', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['statistika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7A 2017 – úloha 16', 'zad': [
        'Přiřaďte ke každé úloze (16.1–16.3) odpovídající výsledek (A–F).',
        '16.1 Ve třídě je 16 chlapců a 9 dívek. Kolik procent žáků třídy tvoří dívky?',
        '16.2 Z plné bonboniéry dostal Radek $\\frac{2}{5}$ bonbónů a Ivan $\\frac{1}{4}$ bonbónů. Kolik procent z původního počtu bonbónů v bonboniéře zbylo?',
        '16.3 V oddílu se zvýšil počet členů ze 40 na 58. O kolik procent se zvýšil počet členů?'],
     'opts': ['A) $30\\;\\%$', 'B) $35\\;\\%$', 'C) $36\\;\\%$', 'D) $40\\;\\%$', 'E) $45\\;\\%$', 'F) jiný výsledek'], 'ln': 0,
     'sol': ['16.1 Žáků celkem $16+9=25$; dívky $\\frac{9}{25}=\\frac{36}{100}=36\\;\\%$ → C.',
             '16.2 Zbylo $1-\\frac{2}{5}-\\frac{1}{4}=\\frac{20-8-5}{20}=\\frac{7}{20}=35\\;\\%$ → B.',
             '16.3 Přírůstek $58-40=18$; $\\frac{18}{40}=0{,}45=45\\;\\%$ → E.'],
     'ans': '16.1: C ($36\\;\\%$); 16.2: B ($35\\;\\%$); 16.3: E ($45\\;\\%$)', 'pts': 6, 'mins': 7, 'diff': '3',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7A 2017 – úloha 17', 'zad': [
        'Obrazovka monitoru je prázdná. Po zaznění zvukového signálu se každou sedmou sekundu objeví na obrazovce 4 nová kolečka. Každou jedenáctou sekundu naopak 3 kolečka z obrazovky zmizí. Pokud by měly obě akce proběhnout ve stejném okamžiku, počet koleček na obrazovce se nezmění.',
        '17.1 Určete počet koleček na obrazovce 1 minutu po zaznění zvukového signálu.',
        '17.2 Určete počet koleček na obrazovce 5 minut po zaznění zvukového signálu.'], 'opts': None, 'ln': 6,
     'sol': ['17.1 Za 60 s nastane přidání v časech $7,14,\\ldots,56$, tj. $8\\times$, a ubrání v časech $11,22,\\ldots,55$, tj. $5\\times$. Společný okamžik (násobek 77) nenastane. Koleček je $8\\cdot 4-5\\cdot 3=32-15=17$.',
             '17.2 Za 300 s: přidání $300:7=42$ krát, ubrání $300:11=27$ krát, společné okamžiky (násobky 77) jsou 3 (77, 154, 231) a ty se neprojeví.',
             'Koleček je $(42-3)\\cdot 4-(27-3)\\cdot 3=39\\cdot 4-24\\cdot 3=156-72=84$.'],
     'ans': '17.1: $17$ koleček; 17.2: $84$ koleček', 'pts': 4, 'mins': 8, 'diff': '4',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M7PAD17C0T01'
    gen.YEAR = 2017

    def dollars_ok(s): return s.count('$') % 2 == 0
    errors = []; names = set()
    for p in PROBLEMS:
        if p['name'] in names: errors.append('DUP název: ' + p['name'])
        names.add(p['name'])
        if 'M7A' not in p['name']: errors.append('Chybí M7A v názvu: ' + p['name'])
        for t in [p['name'], p['ans']] + list(p['zad']) + list(p['sol']) + (p.get('opts') or []):
            if not dollars_ok(t): errors.append('Nepárový $: ' + t[:70])
        if p.get('svg') and ("'" in p['svg'] or '\\' in p['svg']):
            errors.append('SVG zakázaný znak: ' + p['name'])
        if p.get('svg') and not p.get('alt'): errors.append('Obrázek bez alt: ' + p['name'])
        for lbl, obj in (('content', gen.py_content_json(p)), ('solution', gen.py_solution_json(p)), ('answer', gen.py_answer_json(p))):
            try: json.loads(json.dumps(obj, ensure_ascii=False))
            except Exception as e: errors.append(f'JSON {lbl} {p["name"]}: {e}')
    body = sum(p['pts'] for p in PROBLEMS)
    if body != 50: errors.append(f'Součet bodů je {body}, má být 50')
    if errors:
        print('CHYBY:'); [print('  -', e) for e in errors]; sys.exit(1)
    print('Validace OK:', len(PROBLEMS), 'úloh, body celkem:', body)
    outdir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'out')
    os.makedirs(outdir, exist_ok=True)
    tot = 0
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M7A-2017')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
