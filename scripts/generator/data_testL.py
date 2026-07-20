# -*- coding: utf-8 -*-
# Data: Cvičný TEST L (úlohy 1–16). Zdroj: Matematika - Zelený.
# SVG bez apostrofů a zpětných lomítek (viz návod §9).

# ---------- SVG obrázky (bez apostrofů a zpětných lomítek) ----------

SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 400" font-family="sans-serif">
<polygon points="60,70 430,70 430,340" fill="#eef3ee" stroke="#000" stroke-width="2"/>
<rect x="410" y="70" width="20" height="20" fill="none" stroke="#000" stroke-width="1"/>
<text x="45" y="66" font-size="16" font-weight="bold" text-anchor="end">GALWAY</text>
<text x="438" y="66" font-size="16" font-weight="bold">AMELAND</text>
<text x="438" y="352" font-size="16" font-weight="bold">CRANCOT</text>
<text x="245" y="60" font-size="15" text-anchor="middle" font-style="italic">?</text>
<text x="440" y="215" font-size="15">750 km</text>
<text x="205" y="220" font-size="15" text-anchor="middle" transform="rotate(36 205 220)">1250 km</text>
</svg>"""

SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 120" font-family="sans-serif">
<line x1="60" y1="60" x2="400" y2="60" stroke="#000" stroke-width="2.5"/>
<line x1="60" y1="48" x2="60" y2="72" stroke="#000" stroke-width="2"/>
<line x1="400" y1="48" x2="400" y2="72" stroke="#000" stroke-width="2"/>
<text x="55" y="92" font-size="18" font-weight="bold" text-anchor="middle">A</text>
<text x="405" y="92" font-size="18" font-weight="bold" text-anchor="middle">B</text>
<text x="230" y="45" font-size="15" text-anchor="middle">8 cm</text>
</svg>"""

SVG10 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 380" font-family="sans-serif">
<polygon points="300,50 90,210 360,330" fill="none" stroke="#000" stroke-width="2.5"/>
<text x="305" y="42" font-size="18" font-weight="bold">S</text>
<text x="66" y="214" font-size="18" font-weight="bold">T</text>
<text x="368" y="348" font-size="18" font-weight="bold">U</text>
</svg>"""

SVG12 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 300 410" font-family="sans-serif">
<polygon points="120,50 180,50 240,340 60,340" fill="#dfe8ef" stroke="#000" stroke-width="2"/>
<ellipse cx="150" cy="340" rx="90" ry="16" fill="#cdd9e2" stroke="#000" stroke-width="2"/>
<ellipse cx="150" cy="50" rx="30" ry="7" fill="none" stroke="#000" stroke-width="1.5"/>
<text x="150" y="385" font-size="14" text-anchor="middle">váza (komolý kužel), výška 1 m</text>
</svg>"""

SVG13 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 360" font-family="sans-serif">
<polygon points="170,180 59.1,134.1 50,180 59.1,225.9 85.1,264.9 124.1,290.9 170,300 215.9,290.9 254.9,264.9 280.9,225.9 290,180 280.9,134.1" fill="#d9d9d9" stroke="#000" stroke-width="2.5"/>
<line x1="170" y1="180" x2="59.1" y2="134.1" stroke="#000" stroke-width="2.5"/>
<line x1="170" y1="180" x2="280.9" y2="134.1" stroke="#000" stroke-width="2.5"/>
<text x="170" y="162" font-size="15" text-anchor="middle">135°</text>
<line x1="50" y1="325" x2="290" y2="325" stroke="#444" stroke-width="1"/>
<text x="170" y="345" font-size="14" text-anchor="middle">8 m</text>
<text x="322" y="196" font-size="26" text-anchor="middle">=</text>
<rect x="375" y="90" width="110" height="170" fill="#d9d9d9" stroke="#000" stroke-width="2.5"/>
<text x="500" y="180" font-size="14" transform="rotate(-90 500 180)" text-anchor="middle">6,28 m</text>
<text x="430" y="285" font-size="15" text-anchor="middle" font-style="italic">x</text>
</svg>"""

SVG14 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 380" font-family="sans-serif">
<line x1="200" y1="200" x2="200" y2="60" stroke="#333" stroke-width="6"/>
<line x1="200" y1="200" x2="330" y2="275" stroke="#333" stroke-width="6"/>
<line x1="200" y1="200" x2="70" y2="275" stroke="#333" stroke-width="6"/>
<circle cx="200" cy="200" r="10" fill="#fff" stroke="#000" stroke-width="2"/>
<line x1="200" y1="130" x2="330" y2="130" stroke="#000" stroke-width="1" stroke-dasharray="4 4"/>
<line x1="200" y1="120" x2="200" y2="140" stroke="#000" stroke-width="1"/>
<line x1="330" y1="120" x2="330" y2="140" stroke="#000" stroke-width="1"/>
<text x="265" y="122" font-size="15" text-anchor="middle">25 m</text>
</svg>"""

SVG16 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 240" font-family="sans-serif">
<rect x="40" y="90" width="46" height="46" fill="#333"/>
<polygon points="63,100 78,128 48,128" fill="#fff"/>
<text x="63" y="82" font-size="13" text-anchor="middle" font-weight="bold">TÁBOR</text>
<text x="28" y="152" font-size="12">START / CÍL</text>
<rect x="440" y="66" width="58" height="48" fill="#bbb" stroke="#000"/>
<text x="469" y="56" font-size="13" text-anchor="middle" font-weight="bold">ŠKOLA</text>
<line x1="90" y1="104" x2="420" y2="90" stroke="#000" stroke-width="1.5"/>
<line x1="90" y1="120" x2="420" y2="106" stroke="#000" stroke-width="1.5"/>
<path d="M420 90 C 445 94 445 102 420 106" fill="none" stroke="#000" stroke-width="1.5"/>
<circle cx="405" cy="107" r="4" fill="#000"/>
<line x1="405" y1="107" x2="420" y2="98" stroke="#555" stroke-width="1"/>
<text x="300" y="140" font-size="12">místo setkání 50 m od obrátky</text>
</svg>"""

# ---------- Úlohy ----------

CODES_BASE = ['zs2', 'r9']

PROBLEMS = [
    # ---- úloha 1 ----
    {
        'name': 'Zelený L1 – pětinásobek odmocniny',
        'zad': ['Vypočtěte pětinásobek druhé odmocniny jedné čtvrtiny.'],
        'opts': None, 'ln': 1,
        'sol': ['$5\\cdot\\sqrt{\\frac{1}{4}}=5\\cdot\\frac{1}{2}=2{,}5$.'],
        'ans': '$2{,}5$',
        'pts': 1, 'mins': 2, 'diff': '2',
        'codes': CODES_BASE + ['mocniny-odmocniny', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 2 (2.1, 2.2 izolované) ----
    {
        'name': 'Zelený L2.1 – dělení mocnin desetinných čísel',
        'zad': ['Vypočtěte: $4:0{,}2^2-0{,}99:0{,}1^2=$'],
        'opts': None, 'ln': 2,
        'sol': ['$4:0{,}04-0{,}99:0{,}01=100-99=1$.'],
        'ans': '$1$',
        'pts': 1, 'mins': 2, 'diff': '2',
        'codes': CODES_BASE + ['desetinna-cisla', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    {
        'name': 'Zelený L2.2 – výraz s odmocninou',
        'zad': ['Vypočtěte: $\\frac{0{,}4^2}{0{,}01}-\\frac{\\sqrt{4}}{0{,}1}=$'],
        'opts': None, 'ln': 2,
        'sol': ['$\\frac{0{,}16}{0{,}01}-\\frac{2}{0{,}1}=16-20=-4$.'],
        'ans': '$-4$',
        'pts': 1, 'mins': 2, 'diff': '2',
        'codes': CODES_BASE + ['desetinna-cisla', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 3 (3.1, 3.2 izolované) ----
    {
        'name': 'Zelený L3.1 – zlomky a desetinné číslo',
        'zad': ['Vypočtěte a výsledek zapište smíšeným číslem: $\\frac{63}{5}:0{,}6-\\frac{96}{8}:\\frac{132}{24}=$'],
        'opts': None, 'ln': 2,
        'sol': ['$\\frac{63}{5}:\\frac{3}{5}=21$; $\\frac{96}{8}:\\frac{132}{24}=12\\cdot\\frac{24}{132}=\\frac{24}{11}$; $21-\\frac{24}{11}=\\frac{207}{11}=18\\frac{9}{11}$.'],
        'ans': '$18\\frac{9}{11}$',
        'pts': 1, 'mins': 3, 'diff': '3',
        'codes': CODES_BASE + ['zlomky', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    {
        'name': 'Zelený L3.2 – složený zlomek',
        'zad': ['Vypočtěte a výsledek zapište smíšeným číslem: $\\frac{\\frac{15}{4}-\\frac{71}{12}}{\\frac{21}{6}-\\frac{13}{3}}=$'],
        'opts': None, 'ln': 2,
        'sol': ['Čitatel: $\\frac{15}{4}-\\frac{71}{12}=\\frac{45-71}{12}=-\\frac{13}{6}$. Jmenovatel: $\\frac{21}{6}-\\frac{13}{3}=\\frac{21-26}{6}=-\\frac{5}{6}$. Podíl: $\\frac{-\\frac{13}{6}}{-\\frac{5}{6}}=\\frac{13}{5}=2\\frac{3}{5}$.'],
        'ans': '$2\\frac{3}{5}$',
        'pts': 1, 'mins': 3, 'diff': '3',
        'codes': CODES_BASE + ['zlomky', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 4 (4.1, 4.2 izolované) ----
    {
        'name': 'Zelený L4.1 – zjednodušení výrazu',
        'zad': ['Zjednodušte výraz: $\\frac{(a-2b)^2-(2a-b)^2}{3}+(a+b)\\cdot(a-b)=$'],
        'opts': None, 'ln': 3,
        'sol': ['$(a-2b)^2-(2a-b)^2=(a^2-4ab+4b^2)-(4a^2-4ab+b^2)=3b^2-3a^2$. Po dělení třemi: $b^2-a^2$. Přičteme $(a+b)(a-b)=a^2-b^2$: $b^2-a^2+a^2-b^2=0$.'],
        'ans': '$0$',
        'pts': 2, 'mins': 4, 'diff': '3',
        'codes': CODES_BASE + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    {
        'name': 'Zelený L4.2 – krácení výrazu',
        'zad': ['Zjednodušte výraz: $\\frac{(4-2x)\\cdot(3x-9)}{(x-2)\\cdot(3-x)}=$'],
        'opts': None, 'ln': 3,
        'sol': ['$4-2x=-2(x-2)$, $3x-9=3(x-3)$, $(x-2)(3-x)=-(x-2)(x-3)$. Zlomek: $\\frac{-2(x-2)\\cdot 3(x-3)}{-(x-2)(x-3)}=6$.'],
        'ans': '$6$',
        'pts': 2, 'mins': 3, 'diff': '3',
        'codes': CODES_BASE + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 5 (5.1, 5.2 izolované) ----
    {
        'name': 'Zelený L5.1 – lineární rovnice',
        'zad': ['Řešte rovnici: $\\frac{12-3\\cdot(6x-1)}{2}+\\frac{5x}{4}-2=\\frac{2\\cdot(x-2)}{8}$'],
        'opts': None, 'ln': 3,
        'sol': ['Vynásobíme čtyřmi: $2(15-18x)+5x-8=x-2$, tj. $30-36x+5x-8=x-2$, $22-31x=x-2$, $32x=24$, $x=\\frac{3}{4}$.'],
        'ans': '$x=\\frac{3}{4}$',
        'pts': 2, 'mins': 4, 'diff': '3',
        'codes': CODES_BASE + ['linearni-rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    {
        'name': 'Zelený L5.2 – rovnice s druhou mocninou',
        'zad': ['Řešte rovnici: $\\frac{a^2-2a+1}{9}=\\frac{1}{6}\\cdot\\left(12+\\frac{2}{3}a^2\\right)$'],
        'opts': None, 'ln': 3,
        'sol': ['Pravá strana: $2+\\frac{a^2}{9}$. Vynásobíme devíti: $a^2-2a+1=18+a^2$, tedy $-2a=17$, $a=-8{,}5$.'],
        'ans': '$a=-8{,}5$',
        'pts': 2, 'mins': 4, 'diff': '3',
        'codes': CODES_BASE + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 6 (výchozí text; 6.1+6.2 společný kontext) ----
    {
        'name': 'Zelený L6 – požární nádrž',
        'zad': [
            'Jmenuji se Pavel. Na návsi máme požární nádrž. Je to vlastně kvádr široký $9$ metrů a dlouhý $15$ metrů. Seshora do ní přitéká trubkou voda. Hladina vody v nádrži je zajištěna přepadem ve výši $20$ cm pod korunou hráze. Přepad umožňuje za normálních okolností, aby z nádrže odtékalo až $10$ litrů vody za sekundu. Jenže přepad někdo v noci ucpal, a snížil tak nejvyšší možný odtok z nádrže o $90\\,\\%$. V 5.30 h ráno začala nádrž přetékat. Rozhodl jsem se vypátrat, kdy k ucpání odtoku došlo. Nejprve jsem změřil, že do nádrže přitéká každou minutu $120$ litrů vody...',
            '6.1 Pomozte Pavlovi a vypočtěte, v kolik hodin došlo k ucpání odtoku.',
            '6.2 Vypočtěte, za jak dlouho po uvolnění odtoku klesne hladina vody v nádrži na obvyklou úroveň.',
        ],
        'opts': None, 'ln': 4,
        'sol': [
            '6.1 Po ucpání se odtok snížil o $90\\,\\%$ na $1$ l/s, tj. $60$ l/min; přítok je $120$ l/min. Hladina stoupá o $120-60=60$ l/min. Aby nádrž začala přetékat, musela hladina stoupnout o $20$ cm; objem $9\\cdot 15\\cdot 0{,}2=27$ m³ $=27\\,000$ l. To trvá $27\\,000:60=450$ min $=7{,}5$ h. Přetékat začala v 5.30, ucpání tedy nastalo o $7{,}5$ h dříve, ve 22.00 h.',
            '6.2 Po uvolnění odtéká $10$ l/s $=600$ l/min, přitéká $120$ l/min, hladina klesá o $600-120=480$ l/min. Nadbytek $27\\,000$ l zmizí za $27\\,000:480=56{,}25$ min $=56$ min $15$ s.',
        ],
        'ans': '6.1: ve 22.00 h; 6.2: za 56 minut a 15 sekund',
        'pts': 5, 'mins': 9, 'diff': '4',
        'codes': CODES_BASE + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
    },
    # ---- úloha 7 (7.1,7.2,7.3 izolované) ----
    {
        'name': 'Zelený L7.1 – úhel ručiček v půl třetí',
        'zad': ['Jaký úhel svírá na hodinovém ciferníku hodinová a minutová ručička v půl třetí?'],
        'opts': None, 'ln': 2,
        'sol': ['V půl třetí míří minutová ručička na číslici $6$ (poloha $180^\\circ$) a hodinová je uprostřed mezi $2$ a $3$, tj. v poloze $2{,}5\\cdot 30^\\circ=75^\\circ$. Ručičky svírají úhel $180^\\circ-75^\\circ=105^\\circ$.'],
        'ans': '$105^\\circ$',
        'pts': 1, 'mins': 3, 'diff': '3',
        'codes': CODES_BASE + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    {
        'name': 'Zelený L7.2 – spotřeba vody koupáním',
        'zad': ['Kolik m³ vody spotřebuje ročně naše $4$členná rodina koupáním, jestliže se každý z nás koupe jedenkrát denně a v průměru na $1$ koupání spotřebuje $100$ litrů vody? Počítejme s délkou roku $360$ dnů.'],
        'opts': None, 'ln': 2,
        'sol': ['Za den: $4\\cdot 100=400$ l. Za rok: $400\\cdot 360=144\\,000$ l $=144$ m³.'],
        'ans': '$144$ m³ vody',
        'pts': 1, 'mins': 3, 'diff': '2',
        'codes': CODES_BASE + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
    },
    {
        'name': 'Zelený L7.3 – čas odletu z Prahy',
        'zad': ['Jaký byl čas našeho odletu z pražského letiště, jestliže jsme v New Yorku přistáli ráno v 5.50 h newyorského času, cesta z Prahy trvala 11.20 hodin a v New Yorku zapadá (vychází) slunce o $6$ hodin později než v Praze?'],
        'opts': None, 'ln': 2,
        'sol': ['Rozdíl časových pásem je $6$ hodin (v Praze je o $6$ h více). Přílet 5.50 newyorského času odpovídá 11.50 pražského času. Odečteme dobu letu 11 h 20 min: 11.50 − 11.20 = 0.30 h. Odlet byl v 0.30 h středoevropského času.'],
        'ans': '0.30 h středoevropského času',
        'pts': 1, 'mins': 4, 'diff': '3',
        'codes': CODES_BASE + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
    },
    # ---- úloha 8 (výchozí text + obrázek; 8.1+8.2 společný kontext) ----
    {
        'name': 'Zelený L8 – Galway, Ameland, Crancot',
        'zad': [
            'Holandský ostrov Ameland a irské městečko Galway leží na $53$. rovnoběžce. Celková délka této rovnoběžky je přibližně $24\\,000$ km. Francouzské městečko Crancot je vzdálené od ostrova Ameland $750$ km a od irského Galway $1\\,250$ km. Spojnice těchto tří míst tvoří pravoúhlý trojúhelník.',
            '8.1 Vypočtěte, jaký je obvod trojúhelníku tvořeného spojnicemi těchto tří míst.',
            '8.2 Vypočtěte, za kolik minut vyjde slunce v Galway, jestliže právě nyní vychází nad ostrovem Ameland i městečkem Crancot.',
        ],
        'opts': None, 'ln': 4,
        'svg': SVG8, 'fn': 'ameland-galway.svg',
        'alt': 'Pravoúhlý trojúhelník se spojnicemi míst Galway, Ameland a Crancot; přepona Galway–Crancot je 1250 km, odvěsna Ameland–Crancot 750 km, pravý úhel je u Amelandu.',
        'cap': 'Mapka se spojnicemi tří míst (schematický nákres)',
        'sol': [
            '8.1 Pravý úhel je u Amelandu. Odvěsna Ameland–Crancot $=750$ km, přepona Galway–Crancot $=1\\,250$ km. Odvěsna Ameland–Galway $=\\sqrt{1\\,250^2-750^2}=\\sqrt{1\\,000\\,000}=1\\,000$ km. Obvod $=750+1\\,000+1\\,250=3\\,000$ km.',
            '8.2 Galway a Ameland leží na téže rovnoběžce ve vzdálenosti $1\\,000$ km. Celá rovnoběžka $24\\,000$ km odpovídá $24$ hodinám ($=1\\,440$ min). Slunce urazí $1\\,000$ km za $\\frac{1\\,000}{24\\,000}\\cdot 1\\,440=60$ minut.',
        ],
        'ans': '8.1: $3\\,000$ km; 8.2: za $60$ minut',
        'pts': 5, 'mins': 9, 'diff': '3',
        'codes': CODES_BASE + ['planimetrie', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
    },
    # ---- úloha 9 (konstrukce) ----
    {
        'name': 'Zelený L9 – pravoúhlý trojúhelník a dělicí přímka',
        'zad': [
            'V rovině leží úsečka $AB$ o délce $8$ cm.',
            'Sestrojte pravoúhlý trojúhelník $ABC$ s pravým úhlem u vrcholu $C$ tak, aby velikosti úhlů při vrcholech $A$ a $B$ byly v poměru $1:2$. Veďte trojúhelníkem přímku $p$ tak, aby rozdělila plochu trojúhelníku na dvě části, jejichž obsahy budou v poměru $1:3$.',
        ],
        'opts': None, 'ln': 0,
        'svg': SVG9, 'fn': 'usecka-ab.svg',
        'alt': 'Vodorovná úsečka AB dlouhá 8 cm s krajními body A a B.',
        'cap': 'Výchozí obrázek k úloze 9',
        'sol': [
            'Protože úhel u $C$ je pravý, leží $C$ na Thaletově kružnici nad průměrem $AB$. Úhly při $A$ a $B$ jsou v poměru $1:2$ a jejich součet je $90^\\circ$, tedy úhel u $A$ je $30^\\circ$ a u $B$ je $60^\\circ$. U bodu $A$ sestrojíme úhel $30^\\circ$; jeho rameno protne Thaletovu kružnici v bodě $C$. Přímku $p$ vedeme tak, aby oddělený útvar měl obsah rovný čtvrtině obsahu trojúhelníku (poměr $1:3$) — např. rovnoběžně s jednou stranou nebo přes vrchol tak, že dělí protější stranu v poměru $1:3$. Úloha má více řešení.',
        ],
        'ans': 'Konstrukce pravoúhlého trojúhelníku $ABC$ (úhly $30^\\circ$, $60^\\circ$, $90^\\circ$) na Thaletově kružnici nad $AB$ a přímky $p$ dělící obsah v poměru $1:3$; úloha má tři možná řešení (viz obrázky v klíči).',
        'pts': 2, 'mins': 7, 'diff': '4',
        'codes': CODES_BASE + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 10 (konstrukce) ----
    {
        'name': 'Zelený L10 – trojúhelník ze středních příček',
        'zad': [
            'V rovině leží trojúhelník $STU$.',
            'Sestrojte trojúhelník $ABC$, jehož střední příčky jsou strany trojúhelníku $STU$.',
        ],
        'opts': None, 'ln': 0,
        'svg': SVG10, 'fn': 'trojuhelnik-stu.svg',
        'alt': 'Trojúhelník STU s vrcholem S nahoře, T vlevo a U vpravo dole.',
        'cap': 'Výchozí obrázek k úloze 10',
        'sol': [
            'Trojúhelník $ABC$ je tzv. antikomplementární trojúhelník k $STU$: každým vrcholem trojúhelníku $STU$ vedeme rovnoběžku s protější stranou. Průsečíky těchto rovnoběžek jsou vrcholy $A$, $B$, $C$. Body $S$, $T$, $U$ jsou pak středy stran trojúhelníku $ABC$ a úsečky $ST$, $TU$, $US$ jeho středními příčkami.',
        ],
        'ans': 'Konstrukce trojúhelníku $ABC$, jehož středními příčkami jsou strany trojúhelníku $STU$ (vrcholy $A$, $B$, $C$ vzniknou vedením rovnoběžek s protějšími stranami $STU$; viz obrázek v klíči).',
        'pts': 2, 'mins': 5, 'diff': '3',
        'codes': CODES_BASE + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 11 (výchozí text; Ano/Ne 11.1–11.3 společný kontext) ----
    {
        'name': 'Zelený L11 – etapy závodu (Ano/Ne)',
        'zad': [
            'Délky prvních tří etap závodu byly ve vzájemném poměru $2:3:4$. Průměrná rychlost našeho vozu v jednotlivých etapách však byla v poměru $3:4:5$.',
            'Rozhodněte o každém z následujících tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).',
            '11.1 Třetí etapa nám trvala ve srovnání s první etapou o pětinu déle.',
            '11.2 Čas dosažený v první i druhé etapě byl stejný.',
            '11.3 Abychom dosáhli ve třetí etapě stejného času jako v první, museli bychom jet o $20\\,\\%$ rychleji, než jsme jeli.',
        ],
        'opts': None, 'ln': 0,
        'sol': [
            'Čas je podíl dráhy a rychlosti. V poměrových jednotkách: $t_1=\\frac{2}{3}$, $t_2=\\frac{3}{4}$, $t_3=\\frac{4}{5}$.',
            '11.1 $\\frac{t_3}{t_1}=\\frac{4/5}{2/3}=\\frac{12}{10}=1{,}2$, tj. o pětinu déle — pravda (A).',
            '11.2 $t_1=\\frac{2}{3}$ a $t_2=\\frac{3}{4}$ nejsou stejné — nepravda (N).',
            '11.3 Pro stejný čas jako v $1$. etapě při dráze $4$ je potřeba rychlost $\\frac{4}{2/3}=6$; jeli jsme rychlostí $5$, tedy o $\\frac{6}{5}=1{,}2$, o $20\\,\\%$ rychleji — pravda (A).',
        ],
        'ans': '11.1: Ano; 11.2: Ne; 11.3: Ano',
        'pts': 3, 'mins': 6, 'diff': '3',
        'codes': CODES_BASE + ['aritmetika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
    },
    # ---- úloha 12 (výběr z grafů + obrázek) ----
    {
        'name': 'Zelený L12 – napouštění vázy (graf)',
        'zad': [
            'Na obrázku je metr vysoká skleněná váza ve tvaru komolého kužele (širší u dna, užší nahoře). Do vázy napouštíme pomalu stejným proudem vodu a každou vteřinu zaznamenáváme do grafu výšku hladiny vody ve váze.',
            'Vyberte z pěti grafů (A–E) závislosti výšky vodního sloupce na době napouštění ten, který odpovídá podmínkám pokusu.',
        ],
        'opts': [
            'A) graf, kde výška roste nejprve rychle a postupně se růst zpomaluje',
            'B) graf, kde výška roste rovnoměrně (přímka)',
            'C) graf, kde výška roste nejprve pomalu a postupně stále rychleji',
            'D) graf tvaru písmene S (nejprve pomalu, uprostřed rychle, na konci opět pomalu)',
            'E) graf, kde výška roste nejprve rychle, pak pomaleji a nakonec opět rychleji',
        ],
        'ln': 0,
        'svg': SVG12, 'fn': 'vaza.svg',
        'alt': 'Skleněná váza tvaru komolého kužele, širší u dna a užší u hrdla, vysoká 1 metr.',
        'cap': 'Váza ve tvaru komolého kužele',
        'sol': [
            'Váza je širší u dna a užší nahoře, proto se stejným proudem plní spodní široká část pomalu (hladina stoupá zvolna) a horní úzká část rychle (hladina stoupá rychle). Výška hladiny tedy roste nejprve pomalu a postupně stále rychleji — graf je konkávní nahoru, odpovídá variantě C.',
        ],
        'ans': 'C) graf, kde výška roste nejprve pomalu a postupně stále rychleji',
        'pts': 2, 'mins': 4, 'diff': '3',
        'codes': CODES_BASE + ['funkce', 'porozumeni', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
    },
    # ---- úloha 13 (výběr z možností + obrázek) ----
    {
        'name': 'Zelený L13 – kruhová výseč a obdélník',
        'zad': [
            'Na obrázku je záhon tvaru kruhové výseče a záhon tvaru obdélníku. Obsahy ploch obou záhonů jsou stejné. Počítejte s $\\pi=3{,}14$.',
            'Jaké jsou rozměry obdélníkového záhonu, víme-li, že jedna strana je dlouhá $6{,}28$ metru?',
        ],
        'opts': ['A) $3$ metry', 'B) $5$ metrů', 'C) $6$ metrů', 'D) $8$ metrů', 'E) jiný výsledek'],
        'ln': 0,
        'svg': SVG13, 'fn': 'zahon.svg',
        'alt': 'Kruhová výseč o velikosti 225 stupňů (s výřezem 135 stupňů) a průměru 8 m má stejný obsah jako obdélník se stranou 6,28 m a neznámou stranou x.',
        'cap': 'Kruhová výseč a obdélník stejného obsahu (schematický nákres)',
        'sol': [
            'Výseč má velikost $360^\\circ-135^\\circ=225^\\circ$ a poloměr $4$ m (průměr $8$ m). Obsah $=\\frac{225}{360}\\cdot\\pi\\cdot 4^2=0{,}625\\cdot 3{,}14\\cdot 16=31{,}4$ m². Pro obdélník platí $6{,}28\\cdot x=31{,}4$, tedy $x=5$ m.',
        ],
        'ans': 'B) $5$ metrů',
        'pts': 2, 'mins': 5, 'diff': '3',
        'codes': CODES_BASE + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bezny-zivot'],
    },
    # ---- úloha 14 (výběr z možností + obrázek) ----
    {
        'name': 'Zelený L14 – rychlost špičky vrtule',
        'zad': [
            'Na obrázku je rotor (vrtule) větrné elektrárny. Průměr rotoru je $50$ metrů, délka vrtule tedy $25$ metrů.',
            'Jakou rychlostí se pohybuje špička vrtule, jestliže se rotor otáčí rychlostí $30$ otáček za minutu? Výsledek uveďte v m/s. Počítejte s $\\pi=3{,}14$.',
        ],
        'opts': ['A) $39{,}3$ m/s', 'B) $78{,}5$ m/s', 'C) $157{,}0$ m/s', 'D) $314{,}0$ m/s', 'E) jiný výsledek'],
        'ln': 0,
        'svg': SVG14, 'fn': 'rotor.svg',
        'alt': 'Rotor větrné elektrárny se třemi listy; délka jednoho listu (poloměr) je 25 m.',
        'cap': 'Rotor větrné elektrárny (schematický nákres)',
        'sol': [
            'Špička opíše kružnici o obvodu $o=2\\pi r=2\\cdot 3{,}14\\cdot 25=157$ m. Za minutu ($60$ s) urazí $30$ obvodů, tj. $30\\cdot 157=4\\,710$ m. Rychlost $=\\frac{4\\,710}{60}=78{,}5$ m/s.',
        ],
        'ans': 'B) $78{,}5$ m/s',
        'pts': 2, 'mins': 4, 'diff': '2',
        'codes': CODES_BASE + ['planimetrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'fyzika'],
    },
    # ---- úloha 15 (přiřazování 15.1–15.3 -> A–F; společná nabídka) ----
    {
        'name': 'Zelený L15 – procenta (přiřazování)',
        'zad': [
            'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).',
            '15.1 Z dětí narozených v roce 1936 bylo $52\\,\\%$ chlapečků a $48\\,\\%$ děvčátek. Ze všech narozených v tomto roce žila v roce 2017 již jen pouhá jedna čtvrtina, muži však ze žijících osmdesátníků tvořili jen $28\\,\\%$. Kolik $\\%$ ze zemřelých, kteří se narodili v roce 1936, tvořili muži?',
            '15.2 Do obou devítek – Áčka i Béčka – chodí stejný počet žáků. V naší třídě je ale jen $30\\,\\%$ kluků, zatímco v Béčku je jejich podíl dvakrát větší. Kolik $\\%$ deváťáků jsou chlapci?',
            '15.3 Manželé Vojta a Ivana Novákovi si za loňský rok dohromady vydělali o čtvrtinu více než v roce předchozím, tedy o $300\\,000$ korun. Vojta si proti předchozímu roku vloni polepšil o osminu a vydělal vloni o polovinu více než Ivana. O kolik $\\%$ si meziročně polepšila Ivana?',
        ],
        'opts': ['A) o $45\\,\\%$', 'B) o $50\\,\\%$', 'C) o $55\\,\\%$', 'D) o $60\\,\\%$', 'E) o $65\\,\\%$', 'F) jiný výsledek'],
        'ln': 0,
        'sol': [
            '15.1 Ze $100$ narozených: chlapců $52$, dívek $48$. Žije $\\frac{1}{4}$, tj. $25$; z nich mužů $28\\,\\%$, tj. $7$, žen $18$. Zemřelo $75$: mužů $52-7=45$, žen $48-18=30$. Podíl mužů mezi zemřelými $\\frac{45}{75}=60\\,\\%$ → D.',
            '15.2 Obě třídy mají stejný počet žáků. Chlapců je v Áčku $30\\,\\%$ a v Béčku dvakrát více, tj. $60\\,\\%$. Průměr $\\frac{30+60}{2}=45\\,\\%$ → A.',
            '15.3 Celkem loni $1\\,500\\,000$ Kč (o čtvrtinu, tj. o $300\\,000$ Kč, více než $1\\,200\\,000$ Kč). Loni $V_1=1{,}5\\cdot I_1$ a $V_1+I_1=1\\,500\\,000$, tedy $I_1=600\\,000$, $V_1=900\\,000$. Vojta si polepšil o osminu: $V_0=\\frac{8}{9}\\cdot 900\\,000=800\\,000$, takže $I_0=1\\,200\\,000-800\\,000=400\\,000$. Ivana: $\\frac{600\\,000}{400\\,000}=1{,}5$, polepšila si o $50\\,\\%$ → B.',
        ],
        'ans': '15.1: D (o $60\\,\\%$); 15.2: A (o $45\\,\\%$); 15.3: B (o $50\\,\\%$)',
        'pts': 6, 'mins': 9, 'diff': '4',
        'codes': CODES_BASE + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
    },
    # ---- úloha 16 (výchozí text + obrázek; 16.1+16.2 společný kontext) ----
    {
        'name': 'Zelený L16 – závod k táborové škole',
        'zad': [
            'Na prázdninovém táboře jsme běželi závod od tábora k místní škole a zpět. Celkově byla trať dlouhá $3\\,900$ metrů, start i cíl byly u brány tábora a v polovině trasy jsme se u školy obraceli zpět. Startovali jsme po dvojicích a já jsem běžel s Válečkem. Ten na mne od začátku ztrácel. Poté, co jsem obrátil u školy, potkali jsme se $50$ metrů od obrátky.',
            '16.1 Vypočtěte, kolik metrů bude chybět ještě Válečkovi do cíle v momentě, kdy do cíle doběhnu já. (Předpokládáme, že já i Váleček běžíme celou trasu stejnou rychlostí.)',
            '16.2 Vypočtěte, o kolik sekund po mně doběhne Váleček do cíle, jestliže já jsem dosáhl času 19:00 min.',
        ],
        'opts': None, 'ln': 4,
        'svg': SVG16, 'fn': 'zavod.svg',
        'alt': 'Schéma trati závodu od tábora ke škole a zpět; obrátka je u školy a místo setkání běžců je 50 m od obrátky.',
        'cap': 'Schéma závodní trati (schematický nákres)',
        'sol': [
            '16.1 Obrátka je v polovině, tj. na $1\\,950$ m. Když jsem já od obrátky uběhl $50$ m (celkem $2\\,000$ m), Váleček měl do obrátky ještě $50$ m, tj. uběhl $1\\,900$ m. Poměr rychlostí je $2\\,000:1\\,900=20:19$. Až doběhnu já $3\\,900$ m, Váleček uběhne $3\\,900\\cdot\\frac{19}{20}=3\\,705$ m, chybí mu $3\\,900-3\\,705=195$ m.',
            '16.2 Můj čas 19:00 min $=1\\,140$ s. Válečkův čas $=1\\,140\\cdot\\frac{20}{19}=1\\,200$ s. Doběhne o $1\\,200-1\\,140=60$ s později.',
        ],
        'ans': '16.1: $195$ m; 16.2: o $60$ s později',
        'pts': 5, 'mins': 8, 'diff': '3',
        'codes': CODES_BASE + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
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
    written = gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-zeleny-testL'))
    total = 0
    for path, sz, k in written:
        total += k
        flag = 'OK' if sz < 9000 else 'PŘES 9KB!'
        print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{flag}]')
    print('Celkem úloh:', total)
