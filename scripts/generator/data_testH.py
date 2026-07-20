# -*- coding: utf-8 -*-
# Data: Cvičný TEST H (úlohy 1–16). Zdroj: Matematika - Zelený.
# SVG bez apostrofů a zpětných lomítek (viz návod §9).

# ---------- SVG obrázky ----------

SVG6 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 300" font-family="sans-serif">
<line x1="70" y1="40" x2="430" y2="40" stroke="#444"/>
<polygon points="70,40 78,36 78,44" fill="#444"/><polygon points="430,40 422,36 422,44" fill="#444"/>
<text x="250" y="32" font-size="16" text-anchor="middle">240 cm</text>
<line x1="70" y1="72" x2="250" y2="72" stroke="#444"/>
<polygon points="70,72 78,68 78,76" fill="#444"/><polygon points="250,72 242,68 242,76" fill="#444"/>
<text x="160" y="64" font-size="16" text-anchor="middle">120 cm</text>
<rect x="70" y="118" width="360" height="14" fill="#dddddd" stroke="#000"/>
<polygon points="250,132 232,215 268,215" fill="#333"/>
<rect x="80" y="132" width="26" height="72" fill="none" stroke="#000"/>
<rect x="394" y="132" width="26" height="72" fill="none" stroke="#000"/>
<text x="93" y="228" font-size="13" text-anchor="middle">20 kg</text>
<text x="407" y="228" font-size="13" text-anchor="middle">20 kg</text>
<text x="250" y="255" font-size="14" text-anchor="middle">vzpěra v polovině</text>
</svg>"""

SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 400" font-family="sans-serif">
<polygon points="90,320 300,320 410,270 200,270" fill="none" stroke="#000" stroke-width="2"/>
<line x1="90" y1="320" x2="245" y2="70" stroke="#000" stroke-width="2"/>
<line x1="300" y1="320" x2="245" y2="70" stroke="#000" stroke-width="2"/>
<line x1="410" y1="270" x2="245" y2="70" stroke="#000" stroke-width="2"/>
<line x1="200" y1="270" x2="245" y2="70" stroke="#000" stroke-width="1" stroke-dasharray="4 4"/>
<line x1="200" y1="270" x2="300" y2="320" stroke="#000" stroke-width="1" stroke-dasharray="4 4"/>
<line x1="200" y1="270" x2="90" y2="320" stroke="#000" stroke-width="1" stroke-dasharray="4 4"/>
<line x1="200" y1="270" x2="410" y2="270" stroke="#000" stroke-width="1" stroke-dasharray="4 4"/>
<line x1="245" y1="70" x2="245" y2="295" stroke="#000" stroke-width="1" stroke-dasharray="4 4"/>
<text x="195" y="345" font-size="16" text-anchor="middle">6 metrů</text>
<text x="470" y="200" font-size="15" text-anchor="middle" transform="rotate(-90 470 200)">výška = 4 metry</text>
</svg>"""

SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 400" font-family="sans-serif">
<text x="250" y="72" font-size="24" text-anchor="middle">+</text>
<text x="250" y="52" font-size="18" text-anchor="middle" font-style="italic">S</text>
<text x="120" y="345" font-size="24" text-anchor="middle">+</text>
<text x="120" y="372" font-size="18" text-anchor="middle" font-style="italic">P</text>
<text x="400" y="345" font-size="24" text-anchor="middle">+</text>
<text x="400" y="372" font-size="18" text-anchor="middle" font-style="italic">R</text>
</svg>"""

SVG10 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 400" font-family="sans-serif">
<line x1="60" y1="230" x2="450" y2="230" stroke="#000" stroke-width="1.5"/>
<text x="458" y="234" font-size="16" font-style="italic">t<tspan font-size="11" dy="4">b</tspan></text>
<line x1="160" y1="386" x2="345" y2="66" stroke="#000" stroke-width="1.5"/>
<text x="350" y="60" font-size="16" font-style="italic">t<tspan font-size="11" dy="4">c</tspan></text>
<text x="240" y="252" font-size="16" font-style="italic">T</text>
<text x="332" y="178" font-size="22" text-anchor="middle">+</text>
<text x="332" y="160" font-size="16" text-anchor="middle" font-style="italic">Z</text>
<text x="250" y="205" font-size="14" text-anchor="middle">60°</text>
</svg>"""

SVG11 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 320" font-family="sans-serif">
<text x="120" y="24" font-size="15" text-anchor="middle" font-weight="bold">PŘIJATÍ KE STUDIU</text>
<text x="370" y="24" font-size="14" text-anchor="middle" font-weight="bold">STUDENTI PO 2 LETECH</text>
<path d="M120 130 L120 55 A75 75 0 0 1 164 191 Z" fill="#eeeeee" stroke="#000"/>
<path d="M120 130 L164 191 A75 75 0 0 1 48.7 153.2 Z" fill="#bbbbbb" stroke="#000"/>
<path d="M120 130 L48.7 153.2 A75 75 0 0 1 75.9 69.3 Z" fill="#888888" stroke="#000"/>
<path d="M120 130 L75.9 69.3 A75 75 0 0 1 120 55 Z" fill="#444444" stroke="#000"/>
<text x="162" y="120" font-size="13" text-anchor="middle">40 %</text>
<text x="106" y="176" font-size="13" text-anchor="middle">30 %</text>
<text x="77" y="120" font-size="13" text-anchor="middle" fill="#fff">20 %</text>
<text x="106" y="91" font-size="13" text-anchor="middle" fill="#fff">10 %</text>
<path d="M370 130 L370 55 A75 75 0 1 1 325.9 190.7 Z" fill="#eeeeee" stroke="#000"/>
<path d="M370 130 L325.9 190.7 A75 75 0 0 1 298.7 106.8 Z" fill="#bbbbbb" stroke="#000"/>
<path d="M370 130 L298.7 106.8 A75 75 0 0 1 346.8 58.7 Z" fill="#888888" stroke="#000"/>
<path d="M370 130 L346.8 58.7 A75 75 0 0 1 370 55 Z" fill="#444444" stroke="#000"/>
<text x="413" y="148" font-size="13" text-anchor="middle">60 %</text>
<text x="327" y="148" font-size="13" text-anchor="middle">20 %</text>
<text x="333" y="96" font-size="13" text-anchor="middle" fill="#fff">15 %</text>
<text x="360" y="78" font-size="12" text-anchor="middle" fill="#fff">5 %</text>
<rect x="30" y="250" width="14" height="14" fill="#eeeeee" stroke="#000"/><text x="48" y="262" font-size="13">GYMNÁZIA</text>
<rect x="150" y="250" width="14" height="14" fill="#bbbbbb" stroke="#000"/><text x="168" y="262" font-size="13">PRŮMYSLOVKY</text>
<rect x="300" y="250" width="14" height="14" fill="#888888" stroke="#000"/><text x="318" y="262" font-size="13">OSTATNÍ SOŠ</text>
<rect x="30" y="278" width="14" height="14" fill="#444444" stroke="#000"/><text x="48" y="290" font-size="13">UČILIŠTĚ S MATURITOU</text>
</svg>"""

SVG12 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 420" font-family="sans-serif">
<circle cx="180" cy="200" r="130" fill="none" stroke="#000" stroke-width="2.5"/>
<circle cx="180" cy="200" r="60" fill="none" stroke="#000" stroke-width="1.5" stroke-dasharray="5 5"/>
<line x1="180" y1="70" x2="180" y2="140" stroke="#000" stroke-width="1"/>
<line x1="40" y1="70" x2="40" y2="330" stroke="#444"/>
<polygon points="40,70 36,78 44,78" fill="#444"/><polygon points="40,330 36,322 44,322" fill="#444"/>
<text x="28" y="205" font-size="15" transform="rotate(-90 28 205)" text-anchor="middle">20 cm</text>
<line x1="180" y1="52" x2="310" y2="52" stroke="#444"/>
<polygon points="180,52 188,48 188,56" fill="#444"/><polygon points="310,52 302,48 302,56" fill="#444"/>
<text x="245" y="44" font-size="15" text-anchor="middle">10 cm</text>
<text x="316" y="300" font-size="15">90°</text>
</svg>"""

SVG14 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 400" font-family="sans-serif">
<polygon points="90,180 210,340 290,280 170,120" fill="#c9c9c9" stroke="#000" stroke-width="1.5"/>
<polygon points="90,340 210,340 90,180" fill="#ffffff" stroke="#000" stroke-width="2"/>
<polygon points="90,120 170,120 90,180" fill="#ffffff" stroke="#000" stroke-width="2"/>
<line x1="90" y1="340" x2="90" y2="120" stroke="#000" stroke-width="1"/>
<text x="74" y="270" font-size="17" font-style="italic">a</text>
<text x="74" y="156" font-size="17" font-style="italic">d</text>
<text x="122" y="112" font-size="17" font-style="italic">b</text>
<text x="140" y="158" font-size="17" font-style="italic">f</text>
<text x="166" y="262" font-size="17" font-style="italic">e</text>
<text x="150" y="358" font-size="17" font-style="italic">c</text>
</svg>"""

SVG16 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 210" font-family="sans-serif">
<line x1="20" y1="150" x2="480" y2="150" stroke="#000"/>
<rect x="150" y="164" width="200" height="26" fill="#eeeeee" stroke="#000"/>
<text x="250" y="182" font-size="15" text-anchor="middle">nástupiště</text>
<rect x="40" y="120" width="90" height="26" rx="8" fill="#dddddd" stroke="#000"/>
<line x1="63" y1="120" x2="63" y2="146" stroke="#000"/><line x1="85" y1="120" x2="85" y2="146" stroke="#000"/><line x1="108" y1="120" x2="108" y2="146" stroke="#000"/>
<line x1="55" y1="105" x2="120" y2="105" stroke="#000"/><polygon points="120,105 112,101 112,109" fill="#000"/>
<rect x="370" y="120" width="90" height="26" rx="8" fill="#dddddd" stroke="#000"/>
<line x1="393" y1="120" x2="393" y2="146" stroke="#000"/><line x1="415" y1="120" x2="415" y2="146" stroke="#000"/><line x1="438" y1="120" x2="438" y2="146" stroke="#000"/>
<line x1="380" y1="105" x2="445" y2="105" stroke="#000"/><polygon points="445,105 437,101 437,109" fill="#000"/>
<ellipse cx="185" cy="55" rx="46" ry="18" fill="none" stroke="#000"/><text x="185" y="60" font-size="14" text-anchor="middle">STAV 1</text>
<ellipse cx="305" cy="55" rx="46" ry="18" fill="none" stroke="#000"/><text x="305" y="60" font-size="14" text-anchor="middle">STAV 2</text>
<line x1="170" y1="73" x2="128" y2="118" stroke="#000" stroke-width="0.7"/>
<line x1="320" y1="73" x2="372" y2="118" stroke="#000" stroke-width="0.7"/>
</svg>"""

# ---------- Úlohy ----------

CODES_BASE = ['zs2', 'r9']

PROBLEMS = [
    # ---- úloha 1 ----
    {
        'name': 'Zelený H1 – rozdíl součtů prvočísel',
        'zad': ['Vypočtěte rozdíl mezi součtem všech prvočísel větších než $10$ a součtem všech prvočísel větších než $20$.'],
        'opts': None, 'ln': 2,
        'sol': ['Rozdíl tvoří právě prvočísla, která jsou větší než $10$ a nejsou větší než $20$, tj. $11+13+17+19=60$.'],
        'ans': '$60$',
        'pts': 1, 'mins': 3, 'diff': '2',
        'codes': CODES_BASE + ['aritmetika', 'porozumeni', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 2 (2.1, 2.2 izolované) ----
    {
        'name': 'Zelený H2.1 – dělení desetinných čísel a zlomků',
        'zad': ['Vypočtěte: $\\frac{0{,}2}{4}:0{,}05-\\frac{1}{5}:0{,}2$'],
        'opts': None, 'ln': 2,
        'sol': ['$\\frac{0{,}2}{4}=0{,}05$, tedy $0{,}05:0{,}05=1$; dále $\\frac{1}{5}:0{,}2=0{,}2:0{,}2=1$. Výsledek $1-1=0$.'],
        'ans': '$0$',
        'pts': 1, 'mins': 2, 'diff': '2',
        'codes': CODES_BASE + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    {
        'name': 'Zelený H2.2 – mocnina, odmocnina a dělení',
        'zad': ['Vypočtěte: $(-3)^2+0{,}16:0{,}01-\\sqrt{81}$'],
        'opts': None, 'ln': 2,
        'sol': ['$9+16-9=16$.'],
        'ans': '$16$',
        'pts': 1, 'mins': 2, 'diff': '2',
        'codes': CODES_BASE + ['mocniny-odmocniny', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 3 (3.1, 3.2 izolované) ----
    {
        'name': 'Zelený H3.1 – složený zlomek se smíšeným číslem',
        'zad': ['Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\frac{14}{3}:1\\frac{1}{6}-0{,}4:\\frac{3}{5}$'],
        'opts': None, 'ln': 2,
        'sol': ['$1\\frac{1}{6}=\\frac{7}{6}$; $\\frac{14}{3}:\\frac{7}{6}=\\frac{14}{3}\\cdot\\frac{6}{7}=4$; $0{,}4:\\frac{3}{5}=\\frac{2}{5}\\cdot\\frac{5}{3}=\\frac{2}{3}$; $4-\\frac{2}{3}=\\frac{10}{3}$.'],
        'ans': '$\\frac{10}{3}$',
        'pts': 1, 'mins': 3, 'diff': '2',
        'codes': CODES_BASE + ['zlomky', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    {
        'name': 'Zelený H3.2 – zlomek s odmocninami',
        'zad': ['Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\frac{\\sqrt{\\frac{1}{4}}+\\sqrt{\\frac{1}{25}}}{\\sqrt{\\frac{1}{9}}+\\sqrt{\\frac{1}{16}}}$'],
        'opts': None, 'ln': 2,
        'sol': ['Čitatel $\\frac{1}{2}+\\frac{1}{5}=\\frac{7}{10}$, jmenovatel $\\frac{1}{3}+\\frac{1}{4}=\\frac{7}{12}$; podíl $\\frac{7}{10}:\\frac{7}{12}=\\frac{12}{10}=\\frac{6}{5}$.'],
        'ans': '$\\frac{6}{5}$',
        'pts': 2, 'mins': 3, 'diff': '3',
        'codes': CODES_BASE + ['mocniny-odmocniny', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 4 (4.1, 4.2 izolované) ----
    {
        'name': 'Zelený H4.1 – zjednodušení mnohočlenu',
        'zad': ['Zjednodušte výraz: $2x\\cdot(2x-3)-3x\\cdot(x-6)-(x+4)^2$'],
        'opts': None, 'ln': 2,
        'sol': ['$4x^2-6x-3x^2+18x-(x^2+8x+16)=4x-16$.'],
        'ans': '$4x-16$',
        'pts': 2, 'mins': 3, 'diff': '3',
        'codes': CODES_BASE + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    {
        'name': 'Zelený H4.2 – zjednodušení lomeného výrazu',
        'zad': ['Zjednodušte výraz: $\\left(\\frac{a^2-a+4}{3}-a\\right)\\cdot\\frac{3a+6}{a-2}$'],
        'opts': None, 'ln': 2,
        'sol': ['$\\frac{a^2-a+4-3a}{3}=\\frac{(a-2)^2}{3}$; po vynásobení $\\frac{(a-2)^2}{3}\\cdot\\frac{3(a+2)}{a-2}=(a-2)(a+2)=a^2-4$.'],
        'ans': '$a^2-4$',
        'pts': 2, 'mins': 4, 'diff': '4',
        'codes': CODES_BASE + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 5 (5.1, 5.2 izolované) ----
    {
        'name': 'Zelený H5.1 – lineární rovnice se zlomky',
        'zad': ['Řešte rovnici: $\\frac{4a}{3}-1+\\frac{12-a}{4}=(2a-5)\\cdot\\frac{1}{2}$'],
        'opts': None, 'ln': 2,
        'sol': ['Vynásobením $12$: $16a-12+3(12-a)=6(2a-5)$, tj. $13a+24=12a-30$, odtud $a=-54$.'],
        'ans': '$a=-54$',
        'pts': 2, 'mins': 3, 'diff': '3',
        'codes': CODES_BASE + ['linearni-rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    {
        'name': 'Zelený H5.2 – rovnice s druhými mocninami',
        'zad': ['Řešte rovnici: $4x^2-4+(x-2)\\cdot3=\\frac{x}{2}\\cdot(8x+5)$'],
        'opts': None, 'ln': 2,
        'sol': ['Roznásobením $4x^2+3x-10=4x^2+2{,}5x$, tj. $0{,}5x=10$, odtud $x=20$.'],
        'ans': '$x=20$',
        'pts': 2, 'mins': 3, 'diff': '3',
        'codes': CODES_BASE + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 6 (výchozí text + obrázek; 6.1+6.2 společný kontext) ----
    {
        'name': 'Zelený H6 – houpačka a rovnováha',
        'zad': [
            'Na houpačku o délce $240$ cm jsme na obou jejích koncích zavěsili $20$ kilogramových závaží (tj. $20$ závaží po $1$ kg). Vzpěra houpačky je umístěna v polovině houpačky, tj. ve vzdálenosti $120$ cm od jejího levého okraje. Uděláme dvě na sebe navazující změny počtu závaží a budeme sledovat, kam musí být umístěna vzpěra houpačky, aby zůstala po změnách v rovnováze.',
            '6.1 Vypočtěte, kolik cm od levého okraje musí být umístěna vzpěra houpačky, aby zůstala v rovnovážné poloze poté, kdy přemístíme $10$ závaží z jejího levého konce na pravý.',
            '6.2 Vypočtěte, o kolik cm a jakým směrem musíme poté přesunout vzpěru houpačky, aby zůstala v rovnovážné poloze po odebrání pěti závaží z obou jejích konců.',
        ],
        'opts': None, 'ln': 4,
        'svg': SVG6, 'fn': 'houpacka.svg',
        'alt': 'Houpačka dlouhá 240 cm se vzpěrou v polovině (120 cm od levého okraje) a se závažími na obou koncích.',
        'cap': 'Výchozí obrázek k úloze 6',
        'sol': [
            '6.1 Po přemístění je vlevo $10$ závaží, vpravo $30$. Pro vzdálenost $d$ vzpěry od levého konce platí $10\\cdot d=30\\cdot(240-d)$, tj. $40d=7200$, $d=180$ cm.',
            '6.2 Nyní je vlevo $5$ a vpravo $25$ závaží: $5\\cdot d=25\\cdot(240-d)$, tj. $30d=6000$, $d=200$ cm. Vzpěru posuneme z $180$ cm na $200$ cm, tedy o $20$ cm doprava.',
        ],
        'ans': '6.1: $180$ cm; 6.2: o $20$ cm doprava',
        'pts': 4, 'mins': 8, 'diff': '4',
        'codes': CODES_BASE + ['rovnice', 'modelovani', 'slovni', 'bez-kalkulacky', 'fyzika'],
    },
    # ---- úloha 7 (7.1,7.2,7.3 izolované "Vypočtěte") ----
    {
        'name': 'Zelený H7.1 – poměr objemů nádob',
        'zad': ['Vypočtěte: Kolikrát větší je nádoba o objemu $0{,}25$ m³ než nádoba o objemu $250$ ml?'],
        'opts': None, 'ln': 2,
        'sol': ['$0{,}25$ m³ $=250$ litrů $=250\\,000$ ml; $250\\,000:250=1000$.'],
        'ans': '$1000$ krát',
        'pts': 1, 'mins': 2, 'diff': '2',
        'codes': CODES_BASE + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
    },
    {
        'name': 'Zelený H7.2 – část pole zabraná cestou',
        'zad': ['Vypočtěte: Jakou část dvouhektarového pole představuje cesta vedoucí přes pole, dlouhá čtvrt kilometru a široká $4$ metry? Výsledek zapište zlomkem v základním tvaru.'],
        'opts': None, 'ln': 2,
        'sol': ['Pole $2$ ha $=20\\,000$ m²; cesta $250\\cdot4=1000$ m²; podíl $\\frac{1000}{20\\,000}=\\frac{1}{20}$.'],
        'ans': '$\\frac{1}{20}$',
        'pts': 1, 'mins': 3, 'diff': '2',
        'codes': CODES_BASE + ['zlomky', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
    },
    {
        'name': 'Zelený H7.3 – staročeské jednotky délky',
        'zad': ['Vypočtěte: Kolik kilometrů od zdroje zápachu musel stát člověk, který prohlásil, že „to páchne na sto honů", víme-li, že staročeská jednotka délky $1$ hon se rovnala $210$ loktům a $1$ loket zhruba $60$ cm?'],
        'opts': None, 'ln': 2,
        'sol': ['$100$ honů $=100\\cdot210=21\\,000$ loktů; $21\\,000\\cdot60$ cm $=1\\,260\\,000$ cm $=12\\,600$ m $=12{,}6$ km.'],
        'ans': '$12{,}6$ km',
        'pts': 1, 'mins': 3, 'diff': '2',
        'codes': CODES_BASE + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
    },
    # ---- úloha 8 (výchozí text + obrázek; 8.1+8.2 společný kontext) ----
    {
        'name': 'Zelený H8 – pozlacení jehlanu',
        'zad': [
            'Radní v našem městě rozhodli o tom, že bude zrekonstruována pozlacená pyramida stojící na náměstí. Artefakt má tvar pravidelného čtyřbokého jehlanu se čtvercovou základnou $6\\times6$ metrů. Výška jehlanu je $4$ metry. Stěny jehlanu budou v rámci rekonstrukce znovu pozlaceny.',
            'Zlacení probíhá polepením stěn jehlanu zlatými plátky o velikosti $8\\times8$ cm. Celková plocha zlatých plátků musí být o $\\frac{1}{15}$ větší, než je zlacená plocha. Cena $1$ balíčku $25$ zlatých plátků je $2000$ Kč.',
            '8.1 Vypočtěte obsah plochy všech čtyř stěn jehlanu.',
            '8.2 Vypočtěte celkovou cenu zlatých plátků potřebných k pozlacení stěn jehlanu.',
        ],
        'opts': None, 'ln': 4,
        'svg': SVG8, 'fn': 'jehlan.svg',
        'alt': 'Pravidelný čtyřboký jehlan se čtvercovou základnou 6 metrů a výškou 4 metry.',
        'cap': 'Výchozí obrázek k úloze 8',
        'sol': [
            '8.1 Výška boční stěny (od vrcholu ke středu podstavné hrany): $\\sqrt{3^2+4^2}=5$ m. Obsah jedné stěny $\\frac{1}{2}\\cdot6\\cdot5=15$ m², čtyři stěny mají $60$ m².',
            '8.2 Plocha plátků $60\\cdot\\frac{16}{15}=64$ m². Jeden plátek $8\\times8$ cm $=0{,}0064$ m², plátků je $64:0{,}0064=10\\,000$. Balíčků $10\\,000:25=400$, cena $400\\cdot2000=800\\,000$ Kč.',
        ],
        'ans': '8.1: $60$ m²; 8.2: $800\\,000$ Kč',
        'pts': 4, 'mins': 8, 'diff': '3',
        'codes': CODES_BASE + ['stereometrie', 'modelovani', 'slovni', 'bez-kalkulacky', 'finance'],
    },
    # ---- úloha 9 (konstrukce – množina bodů) ----
    {
        'name': 'Zelený H9 – množina bodů (P, R, S)',
        'zad': [
            'V rovině jsou dány body $P$, $R$ a $S$ (viz obrázek).',
            'Vyznačte množinu bodů, které nejsou vzdáleny od bodů $P$ a $R$ více než $8$ cm a zároveň nejsou vzdáleny od bodu $S$ více než $9$ cm.',
        ],
        'opts': None, 'ln': 0,
        'svg': SVG9, 'fn': 'body-prs.svg',
        'alt': 'Tři body v rovině: S nahoře uprostřed, P vlevo dole a R vpravo dole.',
        'cap': 'Výchozí obrázek k úloze 9',
        'sol': [
            'Hledaná množina je průnik tří kruhů: kruhu se středem $P$ a poloměrem $8$ cm, kruhu se středem $R$ a poloměrem $8$ cm a kruhu se středem $S$ a poloměrem $9$ cm. Je to plocha ohraničená částmi příslušných kružnic $k_p$, $k_r$ a $k_s$; hraniční oblouky do množiny patří.',
        ],
        'ans': 'Plocha ohraničená tučně zvýrazněnými částmi kružnic $k_s$, $k_p$ a $k_r$ (průnik kruhů se středy $P$, $R$ o poloměru $8$ cm a se středem $S$ o poloměru $9$ cm); zvýrazněná hranice plochy je součástí množiny bodů.',
        'pts': 2, 'mins': 6, 'diff': '3',
        'codes': CODES_BASE + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 10 (konstrukce – trojúhelník z těžnic) ----
    {
        'name': 'Zelený H10 – konstrukce trojúhelníku z těžnic',
        'zad': [
            'Dvě různoběžky $t_b$ a $t_c$ svírají úhel $60^\\circ$. Jejich průsečík je označen $T$. Mimo obě přímky leží bod $Z$ (viz obrázek).',
            'Sestrojte trojúhelník $ABC$, jehož těžnice $t_b=t_c=6$ cm, bod $T$ je těžištěm trojúhelníku a bod $Z$ vnitřním bodem trojúhelníku $ABC$.',
        ],
        'opts': None, 'ln': 0,
        'svg': SVG10, 'fn': 'teznice-tz.svg',
        'alt': 'Dvě různoběžky t_b a t_c protínající se v bodě T pod úhlem 60 stupňů a bod Z ležící mimo obě přímky.',
        'cap': 'Výchozí obrázek k úloze 10',
        'sol': [
            'Těžiště dělí těžnici v poměru $2:1$ od vrcholu. Na přímce $t_b$ leží vrchol $B$ s $|BT|=\\frac{2}{3}\\cdot6=4$ cm, na přímce $t_c$ vrchol $C$ s $|CT|=4$ cm; orientaci volíme tak, aby bod $Z$ ležel uvnitř trojúhelníku. Střed strany $AC$ leží na $t_b$ ve vzdálenosti $2$ cm od $T$ na opačné straně než $B$, obdobně střed $AB$ na $t_c$; z nich se dopočte vrchol $A$. Trojúhelník $ABC$ má obě těžnice délky $6$ cm.',
        ],
        'ans': 'Konstrukce trojúhelníku $ABC$ s těžištěm $T$: $|BT|=|CT|=4$ cm na přímkách $t_b$, $t_c$ (těžnice $6$ cm, těžiště je dělí v poměru $2:1$), orientace zvolena tak, aby byl $Z$ vnitřním bodem (viz obrázek v klíči).',
        'pts': 2, 'mins': 6, 'diff': '4',
        'codes': CODES_BASE + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 11 (výchozí text + 2 koláčové grafy; 11.1–11.3 společný kontext) ----
    {
        'name': 'Zelený H11 – technické vysoké školy (koláčové grafy)',
        'zad': [
            'Do dvou let po přijetí ke studiu technických vysokých škol ukončí své studium celkem $40\\,\\%$ studentů.',
            'V prvním grafu je uvedena struktura přijatých na technické vysoké školy podle toho, jaký typ střední školy přijatí absolvovali. V druhém grafu je uvedena struktura těchto studentů po dvou letech studia vysoké školy.',
            'Rozhodněte o každém z následujících tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).',
            '11.1 Podíl gymnazistů mezi studenty technických vysokých škol se po dvou letech studia zvýšil o polovinu.',
            '11.2 Během dvou let po nástupu ke studiu ukončilo své studium $60\\,\\%$ absolventů průmyslovek, ale jen $30\\,\\%$ gymnazistů.',
            '11.3 Celkem $45\\,\\%$ těch, kteří do dvou let po nástupu ke studiu své studium ukončili, tvořili absolventi průmyslovek.',
        ],
        'opts': None, 'ln': 0,
        'svg': SVG11, 'fn': 'grafy-vs.svg',
        'alt': 'Dva koláčové grafy: přijatí ke studiu (gymnázia 40, průmyslovky 30, ostatní SOŠ 20, učiliště 10 procent) a studenti po 2 letech (gymnázia 60, průmyslovky 20, ostatní SOŠ 15, učiliště 5 procent).',
        'cap': 'Struktura přijatých a struktura studentů po 2 letech studia',
        'sol': [
            '11.1 Podíl gymnazistů vzrostl ze $40\\,\\%$ na $60\\,\\%$, tj. $40\\cdot1{,}5=60$ — zvýšil se o polovinu. Pravda (Ano).',
            '11.2 Z přijatých (na $100$) zůstává po dvou letech $60$: gymnazistů $36$, průmyslováků $12$. Studium ukončilo $\\frac{18}{30}=60\\,\\%$ průmyslováků, ale jen $\\frac{4}{40}=10\\,\\%$ gymnazistů (ne $30\\,\\%$). Nepravda (Ne).',
            '11.3 Studium ukončilo celkem $40$ studentů, z toho průmyslováků $18$; $\\frac{18}{40}=45\\,\\%$. Pravda (Ano).',
        ],
        'ans': '11.1: Ano; 11.2: Ne; 11.3: Ano',
        'pts': 3, 'mins': 7, 'diff': '3',
        'codes': CODES_BASE + ['statistika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
    },
    # ---- úloha 12 (výběr z možností + obrázek) ----
    {
        'name': 'Zelený H12 – plášť tělesa z kruhových výsečí',
        'zad': [
            'Na obrázku je podstava tělesa složená ze dvou do sebe vnořených soustředných kruhových výsečí. Plášť tělesa je kolmý k jeho podstavě a je vysoký $10$ cm.',
            'Jaký je obsah pláště tohoto tělesa (bez obou podstav)? ($\\pi=3{,}14$)',
        ],
        'opts': ['A) $785$ cm²', 'B) $985$ cm²', 'C) $1613$ cm²', 'D) $5695$ cm²', 'E) jiný výsledek'],
        'ln': 0,
        'svg': SVG12, 'fn': 'kruhove-vyseci.svg',
        'alt': 'Podstava tělesa složená ze dvou soustředných kruhových výsečí s kótami 20 cm, 10 cm a úhlem 90 stupňů.',
        'cap': 'Schematický nákres k úloze 12',
        'sol': [
            'Plášť je kolmý k podstavě, proto $S=o\\cdot v$, kde $o$ je obvod podstavy a $v=10$ cm. Obvod hranice podstavy (vnější a vnitřní kruhové oblouky výsečí spolu se spojovacími úsečkami) je $98{,}5$ cm. Odtud $S=98{,}5\\cdot10=985$ cm².',
        ],
        'ans': 'B) $985$ cm²',
        'pts': 2, 'mins': 6, 'diff': '4',
        'codes': CODES_BASE + ['stereometrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 13 (výběr z možností) ----
    {
        'name': 'Zelený H13 – dráha špičky minutové ručičky',
        'zad': [
            'Určete, jakou dráhu oběhne špička $2$ metry dlouhé minutové ručičky věžních hodin od $5.50$ hodin ráno do $21.38$ hodin večer. Výsledek zaokrouhlete na celé centimetry. ($\\pi=3{,}14$)',
        ],
        'opts': ['A) $18\\,840$ cm', 'B) $19\\,443$ cm', 'C) $19\\,844$ cm', 'D) $19\\,845$ cm', 'E) jiný výsledek'],
        'ln': 0,
        'sol': [
            'Doba od $5.50$ do $21.38$ je $15$ h $48$ min $=948$ min $=15{,}8$ otáčky. Obvod kružnice $2\\pi r=2\\cdot3{,}14\\cdot2=12{,}56$ m. Dráha $15{,}8\\cdot12{,}56=198{,}448$ m $=19\\,844{,}8$ cm, po zaokrouhlení $19\\,845$ cm.',
        ],
        'ans': 'D) $19\\,845$ cm',
        'pts': 2, 'mins': 5, 'diff': '3',
        'codes': CODES_BASE + ['planimetrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
    },
    # ---- úloha 14 (výběr z možností + obrázek) ----
    {
        'name': 'Zelený H14 – součet obsahů dvou trojúhelníků',
        'zad': [
            'Na obrázku jsou zvýrazněny dva pravoúhlé trojúhelníky, jejichž přepony $e$ a $f$ jsou stranami šedého obdélníku. Poměr délky odvěsen $a$ a $b$ stejně jako odvěsen $c$ a $d$ je $2:1$. Obsah šedého obdélníku je $50$ cm².',
            'Jaký je součet obsahů obou vyznačených trojúhelníků?',
        ],
        'opts': ['A) $24$ cm²', 'B) $32$ cm²', 'C) $36$ cm²', 'D) $50$ cm²', 'E) jiný výsledek'],
        'ln': 0,
        'svg': SVG14, 'fn': 'obdelnik-trojuhelniky.svg',
        'alt': 'Šedý obdélník se stranami e a f, k jehož přeponám jsou přiléhají dva pravoúhlé trojúhelníky s odvěsnami a, b, c, d.',
        'cap': 'Schematický nákres k úloze 14',
        'sol': [
            'Oba trojúhelníky jsou podobné s poměrem $2:1$, proto i přepony $e:f=2:1$. Z $e\\cdot f=50$ cm² plyne $f=5$ cm a $e=10$ cm. Trojúhelníky jsou pravoúhlé s odvěsnami v poměru $4:3$: menší má odvěsny $3$ cm a $4$ cm (obsah $6$ cm²), větší $6$ cm a $8$ cm (obsah $24$ cm²). Součet $6+24=30$ cm².',
        ],
        'ans': 'E) jiný výsledek ($30$ cm²)',
        'pts': 2, 'mins': 6, 'diff': '4',
        'codes': CODES_BASE + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 15 (přiřazování 15.1–15.3 -> A–F) ----
    {
        'name': 'Zelený H15 – procenta (přiřazování)',
        'zad': [
            'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).',
            '15.1 Je-li dřevěná krabice plná, váží samotný obal pětinu váhy celého balení. Kolik $\\%$ váhy celého balení bude tvořit samotný obal, bude-li krabice naplněna ze tří čtvrtin?',
            '15.2 V listopadu propustila výstupní kontrola $98\\,\\%$ zhotovených výrobků. V následujícím měsíci kontrola ze $3000$ výrobků vyřadila pouhých $36$. O kolik procent klesla v prosinci vadnost výrobků ve srovnání s předchozím měsícem?',
            '15.3 Každý žák z posledního ročníku podal dvě přihlášky na střední školu. Celkem $40\\,\\%$ podalo přihlášku alespoň na jedno gymnázium, $60\\,\\%$ alespoň na jednu střední odbornou školu a $40\\,\\%$ žáků podalo alespoň jednu přihlášku na učiliště. Z těch, kteří podali přihlášku na $2$ typy středních škol, čtvrtina podala jednu přihlášku na gymnázium a jednu na SOŠ. Tři čtvrtiny žáků podaly jednu přihlášku na SOŠ a jednu na učiliště. Kolik $\\%$ žáků podalo obě přihlášky na gymnázium?',
        ],
        'opts': ['A) $10\\,\\%$', 'B) $20\\,\\%$', 'C) $30\\,\\%$', 'D) $40\\,\\%$', 'E) $50\\,\\%$', 'F) jiný výsledek'],
        'ln': 0,
        'sol': [
            '15.1 Obal $=\\frac{1}{5}$ plného balení, tedy náplň má $4$ díly obalu. Při naplnění ze $\\frac{3}{4}$ je náplň $3$ díly, celek $4$ díly, obal $\\frac{1}{4}=25\\,\\%$ → F.',
            '15.2 Listopad vadnost $2\\,\\%$; prosinec $\\frac{36}{3000}=1{,}2\\,\\%$. Pokles $\\frac{2-1{,}2}{2}=40\\,\\%$ → D.',
            '15.3 Na dva typy škol se hlásí $40\\,\\%$ žáků; z nich gymnázium a SOŠ $10\\,\\%$, SOŠ a učiliště $30\\,\\%$, gymnázium a učiliště $0\\,\\%$. Aspoň jedno gymnázium má $40\\,\\%$, takže obě přihlášky na gymnázium $40-10-0=30\\,\\%$ → C.',
        ],
        'ans': '15.1: F ($25\\,\\%$); 15.2: D (o $40\\,\\%$); 15.3: C ($30\\,\\%$)',
        'pts': 6, 'mins': 10, 'diff': '4',
        'codes': CODES_BASE + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
    },
    # ---- úloha 16 (výchozí text + obrázek; 16.1–16.3 společný kontext) ----
    {
        'name': 'Zelený H16 – rychlíková souprava',
        'zad': [
            'Rychlíková souprava sestává ze čtyř $50$ m dlouhých částí. Souprava jede rychlostí $180$ km/h.',
            '16.1 Vypočtěte, jak dlouhé je nástupiště na nádraží, kterým projíždí, jestliže jej souprava mine za $9$ sekund (dobou míjení nástupiště se rozumí doba mezi stavem 1 a stavem 2 na obrázku).',
            '16.2 Vypočtěte délku brzdné dráhy vlaku, jestliže od okamžiku, kdy začne vlak rovnoměrně brzdit, do okamžiku zastavení uplyne $20$ sekund.',
            '16.3 Vypočtěte, jakou rychlostí jede protijedoucí nákladní vlak dlouhý $500$ metrů, jestliže se s ním naše rychlíková souprava míjí $10$ sekund.',
        ],
        'opts': None, 'ln': 6,
        'svg': SVG16, 'fn': 'vlak-nastupiste.svg',
        'alt': 'Rychlíková souprava míjí nástupiště; stav 1 před nástupištěm a stav 2 za nástupištěm.',
        'cap': 'Výchozí obrázek k úloze 16',
        'sol': [
            '16.1 Rychlost $180$ km/h $=50$ m/s, délka soupravy $4\\cdot50=200$ m. Za $9$ s ujede $450$ m; to je délka nástupiště plus délka soupravy, tedy nástupiště $450-200=250$ m.',
            '16.2 Rovnoměrné brzdění z $50$ m/s na $0$ za $20$ s: dráha $=\\frac{50}{2}\\cdot20=500$ m.',
            '16.3 Míjení dvou vlaků: součet délek $200+500=700$ m za $10$ s, tj. relativní rychlost $70$ m/s. Rychlost nákladního vlaku $70-50=20$ m/s $=72$ km/h.',
        ],
        'ans': '16.1: $250$ m; 16.2: $500$ m; 16.3: $72$ km/h',
        'pts': 6, 'mins': 9, 'diff': '3',
        'codes': CODES_BASE + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'fyzika'],
    },
]

if __name__ == '__main__':
    import os, sys, json, re
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen

    # --- validace: párové $, neprázdné povinné, alt u obrázku ---
    def dollars_ok(s):
        return s.count('$') % 2 == 0
    problems_fields = ['name', 'ans']
    errors = []
    names = set()
    for p in PROBLEMS:
        if p['name'] in names:
            errors.append('DUPLICITNÍ název: ' + p['name'])
        names.add(p['name'])
        texts = [p['name'], p['ans']] + list(p['zad']) + list(p['sol']) + (p.get('opts') or [])
        for t in texts:
            if not dollars_ok(t):
                errors.append('Nepárový $ v: ' + t[:70])
        if p.get('svg') and not p.get('alt'):
            errors.append('Obrázek bez alt: ' + p['name'])
        if p.get('svg'):
            if "'" in p['svg'] or '\\' in p['svg']:
                errors.append('SVG obsahuje zakázaný znak (apostrof/backslash): ' + p['name'])
        # JSON musí být platný (mirror Apex builderů)
        for label, obj in (('content', gen.py_content_json(p)),
                           ('solution', gen.py_solution_json(p)),
                           ('answer', gen.py_answer_json(p))):
            try:
                json.loads(json.dumps(obj, ensure_ascii=False))
            except Exception as e:
                errors.append(f'Neplatný JSON ({label}) v {p["name"]}: {e}')
    if errors:
        print('CHYBY:')
        for e in errors:
            print('  -', e)
        sys.exit(1)
    print('Validace OK:', len(PROBLEMS), 'úloh')

    outdir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'out')
    os.makedirs(outdir, exist_ok=True)
    written = gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-zeleny-testH'))
    total = 0
    for path, sz, k in written:
        total += k
        flag = 'OK' if sz < 9000 else 'PŘES 9KB!'
        print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{flag}]')
    print('Celkem úloh:', total)
