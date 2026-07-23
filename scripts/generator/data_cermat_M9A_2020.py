# -*- coding: utf-8 -*-
# CERMAT – Jednotná přijímací zkouška 2020, MATEMATIKA 9 A (čtyřleté obory, 9. ročník), 1. řádný termín.
# Kód testu: M9PAD20C0T01. 16 úloh CERMAT (po rozdělení izolovaných "Vypočtěte" podúloh 21 úloh).
# Zdroj odpovědí: klíč správných řešení (KSR) M9PAD20C0T01; struktura ověřena v testovém sešitu (TS).

# ---- SVG obrázky (bez ' a \) ----

# úloha 7: rotační válec, výška 50 cm, průměr podstavy 14 cm (podstavy bílé, plášť šedý)
SVG7 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 250 320" font-family="sans-serif">
<path d="M55 65 L55 255 A65 20 0 0 0 185 255 L185 65" fill="#cccccc" stroke="#000" stroke-width="2"/>
<ellipse cx="120" cy="65" rx="65" ry="20" fill="#ffffff" stroke="#000" stroke-width="2"/>
<line x1="55" y1="65" x2="185" y2="65" stroke="#000" stroke-width="0.8" stroke-dasharray="3 3"/>
<line x1="70" y1="34" x2="170" y2="34" stroke="#000" stroke-width="1"/>
<polygon points="70,34 78,30 78,38" fill="#000"/><polygon points="170,34 162,30 162,38" fill="#000"/>
<text x="120" y="26" font-size="15" text-anchor="middle">14 cm</text>
<line x1="210" y1="65" x2="210" y2="270" stroke="#000" stroke-width="1"/>
<polygon points="210,65 206,74 214,74" fill="#000"/><polygon points="210,270 206,261 214,261" fill="#000"/>
<text x="218" y="172" font-size="15">50 cm</text>
</svg>"""

# úloha 8: obdélníkový záhon 210x140 – vlevo tulipány (rohy + středy delších stran), vpravo vnitřní obdélník s narcisy
SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 250" font-family="sans-serif">
<rect x="40" y="45" width="230" height="150" fill="#eef4ea" stroke="#000" stroke-width="2"/>
<text x="155" y="218" font-size="13" text-anchor="middle">210 cm</text>
<text x="24" y="120" font-size="13" text-anchor="middle" transform="rotate(-90 24 120)">140 cm</text>
<text x="155" y="38" font-size="12" text-anchor="middle">105 cm</text>
<circle cx="40" cy="45" r="5" fill="#7a7a7a"/><circle cx="155" cy="45" r="5" fill="#7a7a7a"/><circle cx="270" cy="45" r="5" fill="#7a7a7a"/>
<circle cx="40" cy="195" r="5" fill="#7a7a7a"/><circle cx="155" cy="195" r="5" fill="#7a7a7a"/><circle cx="270" cy="195" r="5" fill="#7a7a7a"/>
<text x="155" y="240" font-size="10" text-anchor="middle" fill="#555">tulipány v rozích a uprostřed delší strany</text>
<rect x="360" y="45" width="230" height="150" fill="none" stroke="#000" stroke-width="1" stroke-dasharray="5 4"/>
<rect x="410" y="85" width="130" height="70" fill="#eef4ea" stroke="#000" stroke-width="2"/>
<text x="475" y="76" font-size="11" text-anchor="middle">25 cm</text>
<text x="380" y="124" font-size="10">25 cm</text><text x="548" y="124" font-size="10">25 cm</text>
<text x="475" y="180" font-size="10" text-anchor="middle" fill="#555">narcisy po 10 cm po obvodu vnitřního obdélníku</text>
<text x="475" y="216" font-size="13" text-anchor="middle">210 cm</text>
</svg>"""

# úloha 9: přímka AC (body A, C) a přímka b pod ní
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 280" font-family="sans-serif">
<line x1="55" y1="235" x2="405" y2="70" stroke="#000" stroke-width="2"/>
<text x="177" y="182" font-size="15">×</text><text x="158" y="180" font-size="16" font-style="italic">A</text>
<text x="333" y="108" font-size="15">×</text><text x="342" y="100" font-size="16" font-style="italic">C</text>
<line x1="55" y1="258" x2="415" y2="205" stroke="#000" stroke-width="2"/>
<text x="422" y="210" font-size="16" font-style="italic">b</text>
</svg>"""

# úloha 10: přímka o (osa) a body A, M
SVG10 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 320" font-family="sans-serif">
<line x1="235" y1="45" x2="180" y2="285" stroke="#000" stroke-width="2"/>
<text x="243" y="46" font-size="16" font-style="italic">o</text>
<text x="322" y="152" font-size="15">×</text><text x="330" y="172" font-size="16" font-style="italic">M</text>
<text x="197" y="260" font-size="15">×</text><text x="205" y="280" font-size="16" font-style="italic">A</text>
</svg>"""

# úloha 12: dvě rovnoběžky proťaté lomenou čárou; úhly α, 62°, 32°, 128°
SVG12 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 180" font-family="sans-serif">
<line x1="30" y1="40" x2="470" y2="40" stroke="#000" stroke-width="2"/>
<line x1="30" y1="150" x2="470" y2="150" stroke="#000" stroke-width="2"/>
<line x1="452" y1="33" x2="468" y2="33" stroke="#000"/><line x1="452" y1="47" x2="468" y2="47" stroke="#000"/>
<line x1="452" y1="143" x2="468" y2="143" stroke="#000"/><line x1="452" y1="157" x2="468" y2="157" stroke="#000"/>
<polyline points="70,40 130,150 250,40 360,150" fill="none" stroke="#000" stroke-width="2"/>
<text x="54" y="60" font-size="16" font-style="italic">α</text>
<text x="118" y="136" font-size="14">32°</text>
<text x="232" y="66" font-size="14">62°</text>
<text x="368" y="140" font-size="14">128°</text>
</svg>"""

# úloha 13: kolmý trojboký hranol ABCDEF, podstava pravoúhlý trojúhelník (odvěsny a, b), stěna ABED
SVG13 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 300" font-family="sans-serif">
<polygon points="70,250 250,250 250,90 70,90" fill="#f4f4f4" stroke="#000" stroke-width="2"/>
<line x1="70" y1="90" x2="205" y2="50" stroke="#000" stroke-width="2"/>
<line x1="250" y1="90" x2="205" y2="50" stroke="#000" stroke-width="2"/>
<line x1="205" y1="50" x2="205" y2="210" stroke="#000" stroke-width="1" stroke-dasharray="4 4"/>
<line x1="70" y1="250" x2="205" y2="210" stroke="#000" stroke-width="1" stroke-dasharray="4 4"/>
<line x1="250" y1="250" x2="205" y2="210" stroke="#000" stroke-width="1" stroke-dasharray="4 4"/>
<text x="56" y="92" font-size="15" font-style="italic">D</text><text x="256" y="92" font-size="15" font-style="italic">E</text>
<text x="200" y="44" font-size="15" font-style="italic">F</text>
<text x="58" y="267" font-size="15" font-style="italic">A</text><text x="252" y="267" font-size="15" font-style="italic">B</text>
<text x="212" y="226" font-size="15" font-style="italic">C</text>
<text x="128" y="242" font-size="14" font-style="italic">b</text><text x="232" y="242" font-size="14" font-style="italic">a</text>
</svg>"""

# úloha 14: pravoúhlý trojúhelník (odvěsny 12 a 6 cm), dvě svislé úsečky dělí delší odvěsnu 6+4+2; tmavý prostřední útvar
SVG14 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 260" font-family="sans-serif">
<polygon points="40,220 400,220 400,40" fill="none" stroke="#000" stroke-width="2"/>
<polygon points="220,220 340,220 340,70 220,130" fill="#c2c2c2" stroke="#000" stroke-width="1.5"/>
<line x1="220" y1="220" x2="220" y2="130" stroke="#000" stroke-width="1.5"/>
<line x1="340" y1="220" x2="340" y2="70" stroke="#000" stroke-width="1.5"/>
<line x1="416" y1="40" x2="416" y2="220" stroke="#000" stroke-width="1"/>
<polygon points="416,40 412,50 420,50" fill="#000"/><polygon points="416,220 412,210 420,210" fill="#000"/>
<text x="424" y="135" font-size="14">6 cm</text>
<text x="130" y="240" font-size="13" text-anchor="middle">6 cm</text>
<text x="280" y="240" font-size="13" text-anchor="middle">4 cm</text>
<text x="370" y="240" font-size="13" text-anchor="middle">2 cm</text>
</svg>"""

# úloha 16: dvě nejmenší čtvercová města (2x2 domy / 3x3 domy), ulice šedě
SVG16 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 540 210" font-family="sans-serif">
<rect x="70" y="30" width="12" height="94" fill="#c8c8c8"/>
<rect x="30" y="70" width="94" height="12" fill="#c8c8c8"/>
<rect x="40" y="40" width="30" height="30" fill="#ffffff" stroke="#000"/>
<rect x="82" y="40" width="30" height="30" fill="#ffffff" stroke="#000"/>
<rect x="40" y="82" width="30" height="30" fill="#ffffff" stroke="#000"/>
<rect x="82" y="82" width="30" height="30" fill="#ffffff" stroke="#000"/>
<text x="77" y="150" font-size="12" text-anchor="middle">4 domy</text>
<text x="77" y="166" font-size="12" text-anchor="middle">2 ulice</text>
<text x="77" y="182" font-size="12" text-anchor="middle">1 křižovatka</text>
<rect x="300" y="30" width="12" height="136" fill="#c8c8c8"/>
<rect x="342" y="30" width="12" height="136" fill="#c8c8c8"/>
<rect x="260" y="70" width="136" height="12" fill="#c8c8c8"/>
<rect x="260" y="112" width="136" height="12" fill="#c8c8c8"/>
<rect x="270" y="40" width="30" height="30" fill="#ffffff" stroke="#000"/>
<rect x="312" y="40" width="30" height="30" fill="#ffffff" stroke="#000"/>
<rect x="354" y="40" width="30" height="30" fill="#ffffff" stroke="#000"/>
<rect x="270" y="82" width="30" height="30" fill="#ffffff" stroke="#000"/>
<rect x="312" y="82" width="30" height="30" fill="#ffffff" stroke="#000"/>
<rect x="354" y="82" width="30" height="30" fill="#ffffff" stroke="#000"/>
<rect x="270" y="124" width="30" height="30" fill="#ffffff" stroke="#000"/>
<rect x="312" y="124" width="30" height="30" fill="#ffffff" stroke="#000"/>
<rect x="354" y="124" width="30" height="30" fill="#ffffff" stroke="#000"/>
<text x="327" y="180" font-size="12" text-anchor="middle">9 domů</text>
<text x="327" y="196" font-size="12" text-anchor="middle">4 ulice, 4 křižovatky</text>
</svg>"""

B = ['zs2', 'r9']  # 9. ročník ZŠ, čtyřleté obory (přijímačky M9)

PROBLEMS = [
    {'name': 'CERMAT M9A 2020 – úloha 1',
     'zad': ['Vypočtěte: $(-0{,}4)^2 + 0{,}3^2 =$'],
     'opts': None, 'ln': 2,
     'sol': ['$(-0{,}4)^2 = 0{,}16$, $0{,}3^2 = 0{,}09$; součet $0{,}16 + 0{,}09 = 0{,}25$.'],
     'ans': '$0{,}25$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2020 – úloha 2.1',
     'zad': ['Z dvouhodinové přednášky již tři pětiny uplynuly.',
             'Vypočtěte, kolik minut zbývá do konce přednášky.'],
     'opts': None, 'ln': 2,
     'sol': ['Dvě hodiny $=120$ minut. Zbývá $\\frac{2}{5}$ přednášky, tj. $\\frac{2}{5}\\cdot 120 = 48$ minut.'],
     'ans': '$48$ minut', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9A 2020 – úloha 2.2',
     'zad': ['Objemy dvou laboratorních nádob jsou $V_1 = 9\\,500$ mm³, $V_2 = 0{,}001$ m³.',
             'Vypočtěte, o kolik cm³ se liší objemy $V_1$, $V_2$ těchto laboratorních nádob.'],
     'opts': None, 'ln': 2,
     'sol': ['$V_1 = 9\\,500$ mm³ $= 9{,}5$ cm³ (neboť $1$ cm³ $= 1000$ mm³). $V_2 = 0{,}001$ m³ $= 1000$ cm³. Rozdíl $1000 - 9{,}5 = 990{,}5$ cm³.'],
     'ans': 'o $990{,}5$ cm³', 'pts': 1, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9A 2020 – úloha 3.1',
     'zad': ['Vypočtěte a výsledek zapište zlomkem v základním tvaru:',
             '$\\left(\\frac{1}{4}+\\frac{5}{6}\\right)\\cdot\\left(\\frac{5}{13}-\\frac{1}{2}\\right) =$'],
     'opts': None, 'ln': 3,
     'sol': ['$\\frac{1}{4}+\\frac{5}{6}=\\frac{3+10}{12}=\\frac{13}{12}$; $\\frac{5}{13}-\\frac{1}{2}=\\frac{10-13}{26}=-\\frac{3}{26}$. Součin $\\frac{13}{12}\\cdot\\left(-\\frac{3}{26}\\right)=-\\frac{39}{312}=-\\frac{1}{8}$.'],
     'ans': '$-\\frac{1}{8}$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2020 – úloha 3.2',
     'zad': ['Vypočtěte a výsledek zapište zlomkem v základním tvaru:',
             '$\\frac{\\frac{6}{5}}{\\frac{7}{6}\\cdot 4 - 4\\cdot\\frac{5}{12}} =$'],
     'opts': None, 'ln': 3,
     'sol': ['Jmenovatel: $\\frac{7}{6}\\cdot 4 = \\frac{28}{6}=\\frac{14}{3}$; $4\\cdot\\frac{5}{12}=\\frac{20}{12}=\\frac{5}{3}$; $\\frac{14}{3}-\\frac{5}{3}=\\frac{9}{3}=3$. Celý výraz $\\frac{6/5}{3}=\\frac{6}{15}=\\frac{2}{5}$.'],
     'ans': '$\\frac{2}{5}$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2020 – úloha 4.1',
     'zad': ['Rozložte na součin:', '$p^2 - 16 =$'],
     'opts': None, 'ln': 2,
     'sol': ['$p^2-16 = p^2 - 4^2 = (p-4)(p+4)$.'],
     'ans': '$(p-4)(p+4)$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2020 – úloha 4.2',
     'zad': ['Umocněte a zjednodušte (výsledný výraz nesmí obsahovat závorky):', '$(2x+5)^2 =$'],
     'opts': None, 'ln': 2,
     'sol': ['$(2x+5)^2 = (2x)^2 + 2\\cdot 2x\\cdot 5 + 5^2 = 4x^2 + 20x + 25$.'],
     'ans': '$4x^2 + 20x + 25$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2020 – úloha 4.3',
     'zad': ['Zjednodušte (výsledný výraz nesmí obsahovat závorky):',
             '$(2n+6)\\cdot(4n-5) + (3-5)\\cdot 2n - 5n\\cdot(n-2n) =$'],
     'opts': None, 'ln': 3,
     'sol': ['$(2n+6)(4n-5)=8n^2+14n-30$; $(3-5)\\cdot 2n = -4n$; $-5n\\cdot(n-2n)=-5n\\cdot(-n)=5n^2$. Součet $8n^2+14n-30-4n+5n^2 = 13n^2+10n-30$.'],
     'ans': '$13n^2 + 10n - 30$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2020 – úloha 5.1',
     'zad': ['Řešte rovnici:', '$3{,}2 - 0{,}5x - 1 = 0{,}6 - 1{,}3x$'],
     'opts': None, 'ln': 3,
     'sol': ['$2{,}2 - 0{,}5x = 0{,}6 - 1{,}3x$; $-0{,}5x + 1{,}3x = 0{,}6 - 2{,}2$; $0{,}8x = -1{,}6$; $x = -2$.'],
     'ans': '$x = -2$', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2020 – úloha 5.2',
     'zad': ['Řešte rovnici:', '$\\frac{5y+3}{8} - \\frac{y}{2} = \\frac{4-y}{5} + \\frac{2y-1}{10}$'],
     'opts': None, 'ln': 4,
     'sol': ['Vynásobíme rovnici číslem $40$: $5(5y+3) - 20y = 8(4-y) + 4(2y-1)$; $25y+15-20y = 32-8y+8y-4$; $5y+15 = 28$; $5y = 13$; $y = \\frac{13}{5}$.'],
     'ans': '$y = \\frac{13}{5}$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2020 – úloha 6',
     'zad': ['Tři vázy mají různé velikosti. Objem velké vázy je o polovinu větší než objem střední vázy. Objem střední vázy je čtyřikrát větší než objem malé vázy. Neznámý objem střední vázy označte $x$.',
             '6.1 V závislosti na veličině $x$ vyjádřete objem velké vázy.',
             '6.2 V závislosti na veličině $x$ vyjádřete objem malé vázy.',
             '6.3 Všechny tři vázy dohromady mají objem $5{,}5$ litru. Vypočtěte v litrech objem střední vázy.'],
     'opts': None, 'ln': 4,
     'sol': ['6.1 Velká váza je o polovinu větší než střední: $x + \\frac{x}{2} = \\frac{3x}{2}$.',
             '6.2 Střední váza je čtyřikrát větší než malá, tedy malá má objem $\\frac{x}{4}$.',
             '6.3 $\\frac{3x}{2} + x + \\frac{x}{4} = 5{,}5$; $\\frac{6x+4x+x}{4} = \\frac{11x}{4} = 5{,}5$; $11x = 22$; $x = 2$ litry.'],
     'ans': '6.1: $\\frac{3x}{2}$; 6.2: $\\frac{x}{4}$; 6.3: $2$ litry', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['rovnice', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9A 2020 – úloha 7',
     'zad': ['Škrabací sloupek pro kočky má tvar rotačního válce. Válec má výšku $50$ cm a jeho podstava má průměr $14$ cm. Obě podstavy jsou bílé, plášť válce je šedý. (Za $\\pi$ dosazujte $\\frac{22}{7}$.)',
             '7.1 Vypočtěte v cm² obsah jedné podstavy válce.',
             '7.2 Vypočtěte v cm² obsah pláště válce.'],
     'opts': None, 'ln': 4, 'svg': SVG7, 'fn': 'valec.svg',
     'alt': 'Rotační válec o výšce 50 cm a průměru podstavy 14 cm; podstavy bílé, plášť šedý.',
     'cap': 'Škrabací sloupek ve tvaru válce',
     'sol': ['7.1 Poloměr $r = 7$ cm. Obsah podstavy $S = \\pi r^2 = \\frac{22}{7}\\cdot 7^2 = 22\\cdot 7 = 154$ cm².',
             '7.2 Plášť $S_{pl} = \\pi d \\cdot v = \\frac{22}{7}\\cdot 14 \\cdot 50 = 22\\cdot 2\\cdot 50 = 2\\,200$ cm².'],
     'ans': '7.1: $154$ cm²; 7.2: $2\\,200$ cm²', 'pts': 3, 'mins': 4, 'diff': '3',
     'codes': B + ['stereometrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9A 2020 – úloha 8',
     'zad': ['Obdélníkový záhon má rozměry $210$ cm a $140$ cm (viz obrázek). Rozměry rostlin zanedbáváme.',
             '8.1 Záhon bude po obvodu osázen tulipány ve stejných rozestupech. Rozestupy mezi sousedními tulipány musí být co největší, přitom tulipán musí být v každém rohu záhonu a také uprostřed delší strany. Vypočtěte v cm rozestup mezi sousedními tulipány.',
             '8.2 Uvnitř záhonu je vyznačen menší obdélník. V jeho rozích a po jeho obvodu budou v 10centimetrových rozestupech vysázeny narcisy. Každý narcis bude vzdálen $25$ cm od nejbližšího okraje záhonu. Vypočtěte, kolik narcisů bude vysázeno.'],
     'opts': None, 'ln': 4, 'svg': SVG8, 'fn': 'zahon.svg',
     'alt': 'Vlevo obdélníkový záhon 210 krát 140 cm s tulipány v rozích a uprostřed delších stran; vpravo vnitřní obdélník s narcisy po 10 cm, 25 cm od okrajů záhonu.',
     'cap': 'Rozmístění tulipánů a narcisů na záhonu',
     'sol': ['8.1 Rozestup musí dělit délku $140$ cm i vzdálenost $105$ cm (roh – střed delší strany). Největší společný dělitel čísel $105$ a $140$ je $35$, rozestup je tedy $35$ cm.',
             '8.2 Vnitřní obdélník má rozměry $(210-2\\cdot 25)\\times(140-2\\cdot 25) = 160\\times 90$ cm, jeho obvod je $2\\cdot(160+90)=500$ cm. Při rozestupu $10$ cm je narcisů $500:10 = 50$.'],
     'ans': '8.1: $35$ cm; 8.2: $50$ narcisů', 'pts': 4, 'mins': 7, 'diff': '4',
     'codes': B + ['planimetrie', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9A 2020 – úloha 9',
     'zad': ['V rovině leží přímka $AC$ a přímka $b$ (viz obrázek). Body $A$, $C$ jsou vrcholy trojúhelníku $ABC$. Na přímce $b$ leží vrchol $B$. Délka těžnice $t_b$ na stranu $AC$ je $6$ cm.',
             'Sestrojte vrchol $B$ trojúhelníku $ABC$, označte jej písmenem a trojúhelník narýsujte. Najděte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG9, 'fn': 'primka-ac-b.svg',
     'alt': 'Přímka AC se dvěma vyznačenými body A a C a pod ní samostatná přímka b.',
     'cap': 'Výchozí obrázek k úloze 9',
     'sol': ['Sestrojíme střed $S_{AC}$ strany $AC$. Těžnice $t_b$ spojuje vrchol $B$ se středem $S_{AC}$ a má délku $6$ cm, proto $B$ leží na kružnici se středem $S_{AC}$ a poloměrem $6$ cm. Průsečíky této kružnice s přímkou $b$ dávají dvě řešení $B_1$, $B_2$.'],
     'ans': 'Střed $S_{AC}$ úsečky $AC$; vrchol $B$ je průsečík přímky $b$ s kružnicí se středem $S_{AC}$ a poloměrem $6$ cm. Dvě řešení $B_1$, $B_2$ (viz obrázek v klíči).',
     'pts': 2, 'mins': 6, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2020 – úloha 10',
     'zad': ['V rovině leží přímka $o$ a body $A$, $M$ (viz obrázek). Bod $A$ je vrchol rovnoramenného lichoběžníku $ABCD$, bod $M$ je střed jeho ramene $BC$. Přímka $o$ je osou lichoběžníku $ABCD$.',
             'Sestrojte vrcholy $B$, $C$, $D$ lichoběžníku $ABCD$, označte je písmeny a lichoběžník narýsujte.'],
     'opts': None, 'ln': 0, 'svg': SVG10, 'fn': 'osa-a-m.svg',
     'alt': 'Šikmá přímka o a dva body A a M ležící po její straně.',
     'cap': 'Výchozí obrázek k úloze 10',
     'sol': ['Vrchol $B$ je obrazem bodu $A$ v osové souměrnosti podle osy $o$ (osa souměrnosti rovnoramenného lichoběžníku zaměňuje $A$ a $B$). Bod $M$ je střed ramene $BC$, proto vrchol $C$ získáme jako obraz bodu $B$ ve středové souměrnosti se středem $M$ ($|MC| = |MB|$). Vrchol $D$ je obrazem bodu $C$ v osové souměrnosti podle osy $o$. Spojením bodů $A$, $B$, $C$, $D$ vznikne hledaný rovnoramenný lichoběžník.'],
     'ans': 'Konstrukce: $B$ obraz $A$ v osové souměrnosti podle $o$; $C$ obraz $B$ ve středové souměrnosti se středem $M$; $D$ obraz $C$ podle $o$; lichoběžník $ABCD$ (viz obrázek v klíči).',
     'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2020 – úloha 11',
     'zad': ['Všichni pracovníci natírají plot stejným tempem. Polovinu plotu by natřeli všichni pracovníci společně za $6$ hodin.',
             'Rozhodněte o každém z následujících tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).',
             '11.1 Celý plot by natřeli všichni pracovníci společně za $9$ hodin.',
             '11.2 Polovinu plotu by natřela třetina pracovníků společně za $18$ hodin.',
             '11.3 Čtvrtinu plotu by natřela čtvrtina pracovníků společně za $12$ hodin.'],
     'opts': None, 'ln': 0,
     'sol': ['11.1 Celý plot je dvojnásobek poloviny, všichni jej natřou za $2\\cdot 6 = 12$ hodin, ne za $9$ → Ne.',
             '11.2 Na stejnou práci (polovinu plotu) potřebuje třetina pracovníků třikrát delší čas: $3\\cdot 6 = 18$ hodin → Ano.',
             '11.3 Čtvrtinu plotu natřou všichni za $\\frac{6}{2}=3$ hodiny; čtvrtina pracovníků potřebuje čtyřikrát déle: $4\\cdot 3 = 12$ hodin → Ano.'],
     'ans': '11.1: Ne; 11.2: Ano; 11.3: Ano', 'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9A 2020 – úloha 12',
     'zad': ['Dvě rovnoběžné přímky protíná lomená čára; jsou vyznačeny úhly $62^\\circ$, $32^\\circ$ a $128^\\circ$ (viz obrázek). Velikosti úhlů neměřte, ale vypočtěte.',
             'Jaká je velikost úhlu $\\alpha$?'],
     'opts': ['A) menší než $98^\\circ$', 'B) $98^\\circ$', 'C) $100^\\circ$', 'D) $102^\\circ$', 'E) větší než $102^\\circ$'],
     'ln': 0, 'svg': SVG12, 'fn': 'uhly-rovnobezky.svg',
     'alt': 'Dvě rovnoběžné vodorovné přímky proťaté lomenou čárou; vyznačené úhly α, 62°, 32° a 128°.',
     'cap': 'Výchozí obrázek k úloze 12',
     'sol': ['Vedeme-li vrcholy lomené čáry rovnoběžky s oběma danými přímkami a použijeme střídavé úhly, dostaneme $\\alpha = 128^\\circ - 62^\\circ + 32^\\circ = 98^\\circ$. (Vnitřní úhel u dolní přímky je $180^\\circ - 128^\\circ = 52^\\circ$.)'],
     'ans': 'B) $98^\\circ$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2020 – úloha 13',
     'zad': ['Podstavou kolmého trojbokého hranolu $ABCDEF$ je pravoúhlý trojúhelník s odvěsnami délek $a = 9$ cm a $b = 12$ cm. Obsah největší boční stěny $ABED$ je $300$ cm² (viz obrázek).',
             'Jaký je povrch hranolu?'],
     'opts': ['A) $828$ cm²', 'B) $888$ cm²', 'C) $936$ cm²', 'D) $1\\,008$ cm²', 'E) $1\\,080$ cm²'],
     'ln': 0, 'svg': SVG13, 'fn': 'hranol.svg',
     'alt': 'Kolmý trojboký hranol ABCDEF s pravoúhlou trojúhelníkovou podstavou (odvěsny a, b) a obdélníkovou boční stěnou ABED.',
     'cap': 'Kolmý trojboký hranol ABCDEF',
     'sol': ['Přepona podstavy $c = \\sqrt{9^2+12^2} = \\sqrt{225} = 15$ cm. Největší stěna leží na přeponě: $300 = 15\\cdot v \\Rightarrow v = 20$ cm (výška hranolu). Obsah podstavy $S_p = \\frac{1}{2}\\cdot 9\\cdot 12 = 54$ cm². Plášť $= (9+12+15)\\cdot 20 = 36\\cdot 20 = 720$ cm². Povrch $= 2\\cdot 54 + 720 = 828$ cm².'],
     'ans': 'A) $828$ cm²', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['stereometrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2020 – úloha 14',
     'zad': ['Pravoúhlý trojúhelník s odvěsnami délek $12$ cm a $6$ cm je dvěma úsečkami rovnoběžnými s kratší odvěsnou rozdělen na tři rovinné útvary. Úsečky rozdělily delší odvěsnu na tři úseky délek $6$ cm, $4$ cm a $2$ cm (viz obrázek).',
             'Jaký je obsah tmavého útvaru?'],
     'opts': ['A) $16$ cm²', 'B) $18$ cm²', 'C) $20$ cm²', 'D) $21$ cm²', 'E) jiný obsah'],
     'ln': 0, 'svg': SVG14, 'fn': 'trojuhelnik-utvary.svg',
     'alt': 'Pravoúhlý trojúhelník s odvěsnami 12 cm a 6 cm rozdělený dvěma svislými úsečkami; prostřední (tmavý) útvar je vyznačen šedě.',
     'cap': 'Rozdělení trojúhelníku na tři útvary',
     'sol': ['Výška útvaru roste od nulového vrcholu lineárně ($y = \\frac{x}{2}$). Dělící úsečky jsou ve vzdálenostech $6$ cm a $10$ cm od tohoto vrcholu a mají délky $3$ cm a $5$ cm. Tmavý (prostřední) útvar je lichoběžník se základnami $3$ cm a $5$ cm a výškou $4$ cm: $S = \\frac{3+5}{2}\\cdot 4 = 16$ cm².'],
     'ans': 'A) $16$ cm²', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2020 – úloha 15',
     'zad': ['Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).',
             '15.1 Roční čtenářský poplatek již zaplatilo $40\\,\\%$ všech čtenářů knihovny, a poplatek tak musí zaplatit ještě zbývajících $264$ čtenářů. Kolik čtenářů má knihovna?',
             '15.2 Do školní družiny se přihlásilo $540$ žáků, což je o pětinu více, než činí kapacita družiny. Kolik žáků činí kapacita družiny?',
             '15.3 Do školního tanečního kroužku chodí $25$ žáků, což je $5\\,\\%$ všech žáků školy. Kroužek juda navštěvuje $20$ žáků školy, přičemž čtvrtina z nich chodí navíc do tanečního kroužku. Kolik žáků školy nechodí ani do tanečního kroužku, ani do kroužku juda?'],
     'opts': ['A) $400$', 'B) $420$', 'C) $440$', 'D) $450$', 'E) $460$', 'F) jiný počet'],
     'ln': 0,
     'sol': ['15.1 Zbývajících $264$ čtenářů odpovídá $60\\,\\%$; $100\\,\\% = \\frac{264}{0{,}6} = 440$ → C.',
             '15.2 $540$ je $120\\,\\%$ kapacity; kapacita $= \\frac{540}{1{,}2} = 450$ → D.',
             '15.3 Celkem žáků $\\frac{25}{0{,}05} = 500$. Do juda chodí $20$, z toho $\\frac{1}{4}\\cdot 20 = 5$ i do tance. Aspoň jeden kroužek: $25 + 20 - 5 = 40$. Ani jeden: $500 - 40 = 460$ → E.'],
     'ans': '15.1: C ($440$); 15.2: D ($450$); 15.3: E ($460$)', 'pts': 6, 'mins': 8, 'diff': '4',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9A 2020 – úloha 16',
     'zad': ['V počítačové hře má každé čtvercové město tyto vlastnosti: čtverečky představují domy a ve všech řadách i sloupcích je jich stejný počet; mezi každými dvěma sousedními domy prochází jedna přímá ulice spojující protější okraje města; každé dvě navzájem kolmé ulice mají společnou křižovatku. Nejmenší města (viz obrázek): $4$ domy – $2$ ulice – $1$ křižovatka; $9$ domů – $4$ ulice – $4$ křižovatky.',
             '16.1 Určete, kolik křižovatek je ve městě se $36$ domy.',
             '16.2 Určete, kolik ulic je ve městě se $36$ křižovatkami.',
             '16.3 Určete, kolik domů je ve městě se $36$ ulicemi.'],
     'opts': None, 'ln': 0, 'svg': SVG16, 'fn': 'ctvercova-mesta.svg',
     'alt': 'Dvě nejmenší čtvercová města: 2 krát 2 domy (2 ulice, 1 křižovatka) a 3 krát 3 domy (4 ulice, 4 křižovatky).',
     'cap': 'Dvě nejmenší čtvercová města',
     'sol': ['Má-li město $n$ domů v řadě, je domů $n^2$, ulic $2(n-1)$ a křižovatek $(n-1)^2$.',
             '16.1 $36$ domů $\\Rightarrow n = 6$; křižovatek $(6-1)^2 = 25$.',
             '16.2 $36$ křižovatek $\\Rightarrow (n-1)^2 = 36$, tedy $n = 7$; ulic $2\\cdot(7-1) = 12$.',
             '16.3 $36$ ulic $\\Rightarrow 2(n-1) = 36$, tedy $n = 19$; domů $19^2 = 361$.'],
     'ans': '16.1: $25$ křižovatek; 16.2: $12$ ulic; 16.3: $361$ domů', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['posloupnosti', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M9PAD20C0T01'
    gen.YEAR = 2020

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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M9A-2020')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
