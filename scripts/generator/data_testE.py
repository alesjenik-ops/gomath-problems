# -*- coding: utf-8 -*-
# Data: Cvičný TEST E (úlohy 1–16). Zdroj: Matematika - Zelený.
# Split: izolované poduúlohy 2,3,4,5,7 -> samostatné úlohy;
#        společný kontext 6,8,11,15,16 -> jedna úloha. SVG bez ' a \ (viz návod §9).

# ---------- SVG obrázky (bez apostrofů a zpětných lomítek) ----------

SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 300" font-family="sans-serif">
<text x="140" y="28" font-size="15" text-anchor="middle" font-weight="bold">Pohled na štít</text>
<polygon points="140,90 50,210 230,210" fill="none" stroke="#000" stroke-width="2.5"/>
<line x1="30" y1="90" x2="30" y2="210" stroke="#444" stroke-width="1"/>
<polygon points="30,90 26,98 34,98" fill="#444"/><polygon points="30,210 26,202 34,202" fill="#444"/>
<text x="18" y="153" font-size="14" text-anchor="middle" transform="rotate(-90 18 153)">4 m</text>
<line x1="50" y1="228" x2="230" y2="228" stroke="#444" stroke-width="1"/>
<polygon points="50,228 58,224 58,232" fill="#444"/><polygon points="230,228 222,224 222,232" fill="#444"/>
<text x="140" y="246" font-size="14" text-anchor="middle">6 m</text>
<text x="242" y="118" font-size="13">krokve</text>
<line x1="240" y1="114" x2="192" y2="150" stroke="#000" stroke-width="0.8"/>
<text x="390" y="28" font-size="15" text-anchor="middle" font-weight="bold">Pohled z boku</text>
<rect x="300" y="90" width="180" height="120" fill="none" stroke="#000" stroke-width="2"/>
<line x1="322" y1="90" x2="322" y2="210" stroke="#000" stroke-width="1"/>
<line x1="344" y1="90" x2="344" y2="210" stroke="#000" stroke-width="1"/>
<line x1="366" y1="90" x2="366" y2="210" stroke="#000" stroke-width="1"/>
<line x1="410" y1="90" x2="410" y2="210" stroke="#000" stroke-width="1"/>
<line x1="432" y1="90" x2="432" y2="210" stroke="#000" stroke-width="1"/>
<line x1="454" y1="90" x2="454" y2="210" stroke="#000" stroke-width="1"/>
<line x1="300" y1="118" x2="480" y2="118" stroke="#000" stroke-width="0.7"/>
<line x1="300" y1="146" x2="480" y2="146" stroke="#000" stroke-width="0.7"/>
<line x1="300" y1="174" x2="480" y2="174" stroke="#000" stroke-width="0.7"/>
<text x="470" y="80" font-size="13" text-anchor="end">prkna</text>
<line x1="452" y1="84" x2="420" y2="118" stroke="#000" stroke-width="0.8"/>
<line x1="300" y1="228" x2="480" y2="228" stroke="#444" stroke-width="1"/>
<polygon points="300,228 308,224 308,232" fill="#444"/><polygon points="480,228 472,224 472,232" fill="#444"/>
<text x="390" y="246" font-size="14" text-anchor="middle">10 m</text>
</svg>"""

SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 210" font-family="sans-serif">
<line x1="90" y1="60" x2="330" y2="150" stroke="#000" stroke-width="2.5"/>
<line x1="83" y1="48" x2="97" y2="72" stroke="#000" stroke-width="2"/>
<line x1="323" y1="138" x2="337" y2="162" stroke="#000" stroke-width="2"/>
<text x="76" y="58" font-size="18" font-weight="bold">A</text>
<text x="338" y="162" font-size="18" font-weight="bold">B</text>
<text x="196" y="98" font-size="15">6 cm</text>
</svg>"""

SVG10 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 330" font-family="sans-serif">
<line x1="90" y1="290" x2="340" y2="80" stroke="#000" stroke-width="2.5"/>
<line x1="82" y1="282" x2="98" y2="298" stroke="#000" stroke-width="2"/>
<line x1="332" y1="72" x2="348" y2="88" stroke="#000" stroke-width="2"/>
<text x="72" y="308" font-size="18" font-weight="bold">A</text>
<text x="350" y="82" font-size="18" font-weight="bold">B</text>
<text x="232" y="178" font-size="15">8 cm</text>
</svg>"""

SVG13 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 500" font-family="sans-serif">
<line x1="221" y1="490" x2="452" y2="80" stroke="#000" stroke-width="1.3" stroke-dasharray="6 5"/>
<polygon points="400,170 247,262 250,440 403,348" fill="none" stroke="#000" stroke-width="2.5"/>
<path d="M 420 135 A 42 42 0 0 1 366 191" fill="none" stroke="#000" stroke-width="1.2"/>
<text x="352" y="150" font-size="20" font-weight="bold">150°</text>
<path d="M 402 318 A 30 30 0 0 1 377 364" fill="none" stroke="#000" stroke-width="1.2"/>
<text x="372" y="352" font-size="22" font-weight="bold">?</text>
</svg>"""

SVG14 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 420" font-family="sans-serif">
<circle cx="250" cy="190" r="141" fill="#c9c9c9" stroke="#000" stroke-width="2"/>
<circle cx="250" cy="190" r="100" fill="#ffffff" stroke="#000" stroke-width="2"/>
<rect x="150" y="90" width="200" height="200" fill="none" stroke="#000" stroke-width="1.3" stroke-dasharray="7 6"/>
<line x1="150" y1="352" x2="350" y2="352" stroke="#000" stroke-width="1"/>
<polygon points="150,352 158,348 158,356" fill="#000"/><polygon points="350,352 342,348 342,356" fill="#000"/>
<text x="250" y="378" font-size="16" text-anchor="middle">8 metrů</text>
</svg>"""

SVG16 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 560" font-family="sans-serif">
<line x1="60" y1="100" x2="440" y2="100" stroke="#000" stroke-width="3"/>
<polygon points="250,100 236,132 264,132" fill="#000"/>
<rect x="108" y="76" width="28" height="22" fill="none" stroke="#000" stroke-width="1.5"/>
<text x="122" y="92" font-size="15" text-anchor="middle">?</text>
<rect x="340" y="78" width="34" height="9" fill="none" stroke="#000" stroke-width="1.5"/>
<rect x="340" y="88" width="34" height="9" fill="none" stroke="#000" stroke-width="1.5"/>
<rect x="340" y="98" width="34" height="9" fill="none" stroke="#000" stroke-width="1.5"/>
<line x1="122" y1="58" x2="250" y2="58" stroke="#444" stroke-width="1"/>
<text x="186" y="53" font-size="13" text-anchor="middle">1,5 m</text>
<line x1="250" y1="48" x2="357" y2="48" stroke="#444" stroke-width="1"/>
<text x="304" y="43" font-size="13" text-anchor="middle">1 m</text>
<line x1="60" y1="230" x2="440" y2="230" stroke="#000" stroke-width="3"/>
<polygon points="250,230 236,262 264,262" fill="#000"/>
<rect x="150" y="206" width="28" height="22" fill="none" stroke="#000" stroke-width="1.5"/>
<text x="164" y="222" font-size="15" text-anchor="middle">?</text>
<rect x="340" y="208" width="34" height="9" fill="none" stroke="#000" stroke-width="1.5"/>
<rect x="340" y="218" width="34" height="9" fill="none" stroke="#000" stroke-width="1.5"/>
<rect x="340" y="228" width="34" height="9" fill="none" stroke="#000" stroke-width="1.5"/>
<line x1="164" y1="188" x2="250" y2="188" stroke="#444" stroke-width="1"/>
<text x="207" y="183" font-size="13" text-anchor="middle">0,9 m</text>
<line x1="250" y1="178" x2="357" y2="178" stroke="#444" stroke-width="1"/>
<text x="304" y="173" font-size="13" text-anchor="middle">1,2 m</text>
<line x1="60" y1="360" x2="440" y2="360" stroke="#000" stroke-width="3"/>
<polygon points="250,360 236,392 264,392" fill="#000"/>
<rect x="184" y="336" width="28" height="22" fill="none" stroke="#000" stroke-width="1.5"/>
<text x="198" y="352" font-size="15" text-anchor="middle">?</text>
<rect x="376" y="349" width="40" height="10" fill="none" stroke="#000" stroke-width="1.5"/>
<line x1="198" y1="318" x2="250" y2="318" stroke="#444" stroke-width="1"/>
<text x="224" y="313" font-size="13" text-anchor="middle">50 cm</text>
<line x1="250" y1="308" x2="395" y2="308" stroke="#444" stroke-width="1"/>
<text x="322" y="303" font-size="13" text-anchor="middle">2 m</text>
<line x1="60" y1="500" x2="440" y2="500" stroke="#000" stroke-width="3"/>
<polygon points="250,500 236,532 264,532" fill="#000"/>
<rect x="98" y="476" width="28" height="22" fill="none" stroke="#000" stroke-width="1.5"/>
<text x="112" y="492" font-size="15" text-anchor="middle">?</text>
<rect x="348" y="438" width="34" height="9" fill="none" stroke="#000" stroke-width="1.5"/>
<rect x="348" y="448" width="34" height="9" fill="none" stroke="#000" stroke-width="1.5"/>
<rect x="348" y="458" width="34" height="9" fill="none" stroke="#000" stroke-width="1.5"/>
<rect x="348" y="468" width="34" height="9" fill="none" stroke="#000" stroke-width="1.5"/>
<rect x="348" y="478" width="34" height="9" fill="none" stroke="#000" stroke-width="1.5"/>
<rect x="348" y="488" width="34" height="9" fill="none" stroke="#000" stroke-width="1.5"/>
<line x1="112" y1="458" x2="250" y2="458" stroke="#444" stroke-width="1"/>
<text x="181" y="453" font-size="13" text-anchor="middle">180 cm</text>
<line x1="250" y1="448" x2="365" y2="448" stroke="#444" stroke-width="1"/>
<text x="308" y="443" font-size="13" text-anchor="middle">1,5 m</text>
</svg>"""

# ---------- Úlohy ----------

CODES_BASE = ['zs2', 'r9']

PROBLEMS = [
    # ---- úloha 1 ----
    {
        'name': 'Zelený E1 – pětinásobek a polovina',
        'zad': ['Vypočtěte číslo, jehož pětinásobek je roven jeho jedné polovině.'],
        'opts': None, 'ln': 2,
        'sol': ['Označme hledané číslo $x$. Platí $5x=\\frac{1}{2}x$, tedy $5x-\\frac{1}{2}x=0$, odtud $\\frac{9}{2}x=0$, a proto $x=0$.'],
        'ans': '$0$',
        'pts': 1, 'mins': 2, 'diff': '2',
        'codes': CODES_BASE + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 2 (2.1, 2.2 izolované "Vypočtěte") ----
    {
        'name': 'Zelený E2.1 – desetinná čísla',
        'zad': ['Vypočtěte: $2{,}2:0{,}22-0{,}22:(0{,}1-0{,}078)+22=$'],
        'opts': None, 'ln': 2,
        'sol': ['$2{,}2:0{,}22=10$; $0{,}1-0{,}078=0{,}022$; $0{,}22:0{,}022=10$. Celkem $10-10+22=22$.'],
        'ans': '$22$',
        'pts': 1, 'mins': 2, 'diff': '2',
        'codes': CODES_BASE + ['desetinna-cisla', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    {
        'name': 'Zelený E2.2 – odmocnina a dělení',
        'zad': ['Vypočtěte: $\\sqrt{40:0{,}1}-0{,}5:0{,}1=$'],
        'opts': None, 'ln': 2,
        'sol': ['$40:0{,}1=400$; $\\sqrt{400}=20$; $0{,}5:0{,}1=5$. Celkem $20-5=15$.'],
        'ans': '$15$',
        'pts': 1, 'mins': 2, 'diff': '2',
        'codes': CODES_BASE + ['mocniny-odmocniny', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 3 (3.1, 3.2 izolované) ----
    {
        'name': 'Zelený E3.1 – zlomky se závorkou',
        'zad': ['Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\frac{1}{2}:\\frac{1}{3}-3\\frac{3}{4}\\cdot\\frac{2}{5}\\cdot\\left(\\frac{5}{6}-\\frac{4}{9}\\right)=$'],
        'opts': None, 'ln': 2,
        'sol': ['$\\frac{1}{2}:\\frac{1}{3}=\\frac{3}{2}$; $\\frac{5}{6}-\\frac{4}{9}=\\frac{7}{18}$; $\\frac{15}{4}\\cdot\\frac{2}{5}\\cdot\\frac{7}{18}=\\frac{7}{12}$. Celkem $\\frac{3}{2}-\\frac{7}{12}=\\frac{11}{12}$.'],
        'ans': '$\\frac{11}{12}$',
        'pts': 1, 'mins': 3, 'diff': '2',
        'codes': CODES_BASE + ['zlomky', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    {
        'name': 'Zelený E3.2 – složený zlomek',
        'zad': ['Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\dfrac{\\frac{3}{2}:\\frac{4}{3}-\\frac{3}{8}}{2-\\frac{7}{16}-\\frac{3}{4}}=$'],
        'opts': None, 'ln': 3,
        'sol': ['Čitatel: $\\frac{3}{2}:\\frac{4}{3}=\\frac{9}{8}$; $\\frac{9}{8}-\\frac{3}{8}=\\frac{3}{4}$. Jmenovatel: $2-\\frac{7}{16}-\\frac{3}{4}=\\frac{13}{16}$. Podíl: $\\frac{3}{4}:\\frac{13}{16}=\\frac{3}{4}\\cdot\\frac{16}{13}=\\frac{12}{13}$.'],
        'ans': '$\\frac{12}{13}$',
        'pts': 2, 'mins': 4, 'diff': '3',
        'codes': CODES_BASE + ['zlomky', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 4 (4.1, 4.2 izolované) ----
    {
        'name': 'Zelený E4.1 – rozdíl druhých mocnin',
        'zad': ['Zjednodušte výraz: $\\left(2+\\frac{a}{2}\\right)^2-\\left(\\frac{a}{2}-2\\right)^2=$'],
        'opts': None, 'ln': 2,
        'sol': ['Použijeme $X^2-Y^2=(X-Y)(X+Y)$ pro $X=2+\\frac{a}{2}$, $Y=\\frac{a}{2}-2$: $(X-Y)=4$, $(X+Y)=a$. Výsledek $4a$.'],
        'ans': '$4a$',
        'pts': 2, 'mins': 3, 'diff': '3',
        'codes': CODES_BASE + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    {
        'name': 'Zelený E4.2 – úprava výrazu se zlomky',
        'zad': ['Zjednodušte výraz: $\\frac{2\\cdot(x-2)^2}{3}-\\frac{(x+2)^2}{2}+5x-0{,}5=$'],
        'opts': None, 'ln': 3,
        'sol': ['Společný jmenovatel $6$: $\\frac{4x^2-16x+16}{6}-\\frac{3x^2+12x+12}{6}+\\frac{30x-3}{6}=\\frac{x^2+2x+1}{6}=\\frac{(x+1)^2}{6}$.'],
        'ans': '$\\frac{x^2+2x+1}{6}$ (tj. $\\frac{(x+1)^2}{6}$)',
        'pts': 2, 'mins': 5, 'diff': '3',
        'codes': CODES_BASE + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 5 (5.1, 5.2 izolované) ----
    {
        'name': 'Zelený E5.1 – lineární rovnice',
        'zad': ['Řešte rovnici: $3\\cdot\\left(x-\\frac{x}{2}-2\\right)-2x=1+\\frac{x}{2}$'],
        'opts': None, 'ln': 2,
        'sol': ['Levá strana: $3x-\\frac{3x}{2}-6-2x=x-\\frac{3x}{2}-6$. Vynásobíme $2$: $2x-3x-12=2+x$, tj. $-x-12=2+x$, odtud $-2x=14$, $x=-7$.'],
        'ans': '$x=-7$',
        'pts': 2, 'mins': 3, 'diff': '2',
        'codes': CODES_BASE + ['linearni-rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    {
        'name': 'Zelený E5.2 – rovnice se zlomky',
        'zad': ['Řešte rovnici: $\\frac{a-3}{2}+\\frac{a-2}{3}-\\frac{a-1}{4}=2a+4$'],
        'opts': None, 'ln': 3,
        'sol': ['Vynásobíme $12$: $6(a-3)+4(a-2)-3(a-1)=24a+48$, tj. $7a-23=24a+48$, odtud $-71=17a$, $a=-\\frac{71}{17}$.'],
        'ans': '$a=-\\frac{71}{17}$',
        'pts': 2, 'mins': 4, 'diff': '3',
        'codes': CODES_BASE + ['rovnice-se-zlomky', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 6 (výchozí text; 6.1+6.2 společný kontext) ----
    {
        'name': 'Zelený E6 – nádrže s olejem',
        'zad': [
            'V nedaleké chemičce došlo k havárii a ze dvou nádrží musí být odčerpán všechen olej. Včera se z každé z nich podařilo odčerpat $72$ hl. Díky tomu v nádrži A klesl objem oleje ze $41\\,\\%$ na $23\\,\\%$ jejího maximálního objemu a v nádrži B ze $73\\,\\%$ na $64\\,\\%$ jejího maximálního objemu.',
            '6.1 Vypočtěte, o kolik $\\%$ je větší nádrž B ve srovnání s nádrží A.',
            '6.2 Vypočtěte, za kolik dnů ode dneška budou obě nádrže prázdné, jestliže se předpokládá, že denně je možné z každé nádrže odčerpat nejvýše $128$ hl oleje.',
        ],
        'opts': None, 'ln': 4,
        'sol': [
            '6.1 V nádrži A odpovídá $72$ hl poklesu o $41-23=18\\,\\%$, tedy $V_A=72:0{,}18=400$ hl. V nádrži B poklesu o $73-64=9\\,\\%$, tedy $V_B=72:0{,}09=800$ hl. Nádrž B je $2$krát větší, tj. o $100\\,\\%$.',
            '6.2 Zbývá odčerpat: v A $0{,}23\\cdot400=92$ hl (do jednoho dne), v B $0{,}64\\cdot800=512$ hl, tj. $512:128=4$ dny. Obě nádrže budou prázdné za $4$ dny.',
        ],
        'ans': '6.1: o $100\\,\\%$; 6.2: za $4$ dny',
        'pts': 4, 'mins': 6, 'diff': '3',
        'codes': CODES_BASE + ['procenta', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
    },
    # ---- úloha 7 (7.1,7.2,7.3 izolované "Vypočtěte") ----
    {
        'name': 'Zelený E7.1 – balíčky do bedny',
        'zad': ['Kolik balíčků o objemu $25$ cm³ můžete umístit do bedny o objemu $0{,}5$ m³?'],
        'opts': None, 'ln': 2,
        'sol': ['$0{,}5$ m³ $=500\\,000$ cm³. Počet balíčků $500\\,000:25=20\\,000$.'],
        'ans': '$20\\,000$ balíčků',
        'pts': 1, 'mins': 2, 'diff': '2',
        'codes': CODES_BASE + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
    },
    {
        'name': 'Zelený E7.2 – vteřinová ručička',
        'zad': ['Kolikrát oběhne do půlnoci vteřinová ručička hodinový ciferník, jestliže je ráno a hodiny ukazují za pět minut čtvrt na šest?'],
        'opts': None, 'ln': 2,
        'sol': ['Za pět minut čtvrt na šest je $5{:}10$ ráno. Do půlnoci ($24{:}00$) zbývá $18$ hodin a $50$ minut, tj. $18\\cdot60+50=1\\,130$ minut. Vteřinová ručička oběhne ciferník jednou za minutu, tedy $1\\,130$krát.'],
        'ans': '$1\\,130$krát',
        'pts': 1, 'mins': 3, 'diff': '2',
        'codes': CODES_BASE + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
    },
    {
        'name': 'Zelený E7.3 – hmotnost sněhu',
        'zad': ['Jaká je hmotnost půl metru silné vrstvy sněhu na střeše o ploše $800$ m², víme-li, že rozpuštěním $1$ m³ vznikne $100$ litrů vody a $1$ dm³ vody váží $1$ kg? Výsledek uveďte v tunách.'],
        'opts': None, 'ln': 3,
        'sol': ['Objem sněhu: $0{,}5\\cdot800=400$ m³. Vody vznikne $400\\cdot100=40\\,000$ litrů $=40\\,000$ dm³, což váží $40\\,000$ kg $=40$ tun.'],
        'ans': '$40$ tun',
        'pts': 1, 'mins': 3, 'diff': '3',
        'codes': CODES_BASE + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
    },
    # ---- úloha 8 (výchozí text + obrázek; 8.1+8.2 společný kontext) ----
    {
        'name': 'Zelený E8 – krov střechy',
        'zad': [
            'Na obrázku vidíte schéma krovu nové střechy, kterou právě staví tesaři. Pohledem na štít má střecha tvar rovnoramenného trojúhelníku s vyznačenými rozměry (výška $4$ m, základna $6$ m), pohledem z boku je dlouhá $10$ metrů. Krov je sestaven z $9$ párů krokví.',
            '8.1 Vypočtěte celkovou délku trámů, ze kterých jsou sestaveny krokve na celé střeše.',
            '8.2 Vypočtěte, kolik kubických metrů prken je třeba na zakrytí střechy (tzv. poklop), víme-li, že tloušťka prken je $2{,}5$ cm.',
        ],
        'opts': None, 'ln': 4,
        'svg': SVG8, 'fn': 'krov.svg',
        'alt': 'Vlevo pohled na štít: rovnoramenný trojúhelník s výškou 4 m a základnou 6 m. Vpravo pohled z boku: obdélník dlouhý 10 m s krokvemi a prkny.',
        'cap': 'Schéma krovu střechy',
        'sol': [
            '8.1 Krokev je rameno trojúhelníku: $\\sqrt{3^2+4^2}=5$ m. Jeden pár krokví má $2\\cdot5=10$ m, celkem $9\\cdot10=90$ m trámů.',
            '8.2 Střecha má dvě obdélníkové plochy $5\\times10=50$ m², dohromady $100$ m². Objem prken $100\\cdot0{,}025=2{,}5$ m³.',
        ],
        'ans': '8.1: $90$ m trámů; 8.2: $2{,}5$ m³ prken',
        'pts': 4, 'mins': 8, 'diff': '3',
        'codes': CODES_BASE + ['planimetrie', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
    },
    # ---- úloha 9 (konstrukce – množina bodů) ----
    {
        'name': 'Zelený E9 – množina bodů kolem úsečky',
        'zad': [
            'V rovině leží úsečka $AB$ o délce $6$ cm.',
            'Vyznačte množinu všech bodů, jejichž vzdálenost od úsečky $AB$ není menší než $2$ cm a není větší než $4$ cm.',
        ],
        'opts': None, 'ln': 0,
        'svg': SVG9, 'fn': 'usecka-ab-6.svg',
        'alt': 'Úsečka AB o délce 6 cm v rovině, šikmo orientovaná.',
        'cap': 'Výchozí obrázek k úloze 9',
        'sol': [
            'Množina všech bodů ve vzdálenosti přesně $r$ od úsečky $AB$ je obrys „obdélníku se zaoblenými rohy" (dvě úsečky rovnoběžné s $AB$ ve vzdálenosti $r$ a dva půlkruhové oblouky se středy $A$ a $B$ o poloměru $r$). Hledaná množina je uzavřená plocha mezi takovými obrysy pro $r=2$ cm a $r=4$ cm.',
        ],
        'ans': 'Uzavřená plocha (mezikruží kolem úsečky) mezi dvěma soustřednými obrysy tvořenými úsečkami rovnoběžnými s $AB$ a oblouky se středy $A$, $B$, a to ve vzdálenostech $2$ cm a $4$ cm od úsečky $AB$ (viz obrázek v klíči).',
        'pts': 2, 'mins': 6, 'diff': '3',
        'codes': CODES_BASE + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 10 (konstrukce trojúhelníku) ----
    {
        'name': 'Zelený E10 – konstrukce trojúhelníku',
        'zad': [
            'V rovině leží úsečka $AB$ o délce $8$ cm.',
            'Sestrojte trojúhelník $ABC$, víme-li, že výška $v_a=6$ cm a těžnice $t_c=5$ cm.',
        ],
        'opts': None, 'ln': 0,
        'svg': SVG10, 'fn': 'usecka-ab-8.svg',
        'alt': 'Úsečka AB o délce 8 cm v rovině, šikmo orientovaná, bod A vlevo dole a bod B vpravo nahoře.',
        'cap': 'Výchozí obrázek k úloze 10',
        'sol': [
            'Strana $c=|AB|=8$ cm je dána; $S_c$ je střed úsečky $AB$. Bod $C$ leží na kružnici $k(S_c;5$ cm$)$ (těžnice $t_c$) a zároveň na tečně vedené z bodu $B$ ke kružnici $l(A;6$ cm$)$, neboť vzdálenost bodu $A$ od přímky $BC$ musí být rovna výšce $v_a=6$ cm. Průsečík určuje vrchol $C$.',
        ],
        'ans': 'Konstrukce trojúhelníku $ABC$: $C$ je průsečík kružnice $k(S_c;5$ cm$)$ a tečny z $B$ ke kružnici $l(A;6$ cm$)$; $S_c$ je střed $AB$ (viz obrázek v klíči).',
        'pts': 2, 'mins': 6, 'diff': '3',
        'codes': CODES_BASE + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 11 (výchozí text; 11.1–11.3 Ano/Ne společný kontext) ----
    {
        'name': 'Zelený E11 – žáci ze tří obcí',
        'zad': [
            'V naší škole jsou žáci ze tří obcí. Fryšavských je třikrát více než Kadovských, dětí ze Skleného je o polovinu méně než z Fryšavy.',
            'Rozhodněte o každém z následujících tvrzení 11.1–11.3, zda je pravdivé (Ano), či nikoli (Ne).',
            '11.1 Celkový počet žáků naší školy je vždy dělitelný $11$.',
            '11.2 Děti z Fryšavy tvoří více než polovinu žáků naší školy.',
            '11.3 Jestliže z Kadova dochází do naší školy $8$ žáků, pak je celkový počet žáků naší školy $88$.',
        ],
        'opts': None, 'ln': 0,
        'sol': [
            'Nechť Kadovských je $k$. Pak Fryšavských je $3k$ a ze Skleného $\\frac{3k}{2}$. Celkem $k+3k+\\frac{3k}{2}=\\frac{11k}{2}$ žáků.',
            '11.1 Aby byl počet ze Skleného celý, musí být $k$ sudé; pak $\\frac{11k}{2}=11\\cdot\\frac{k}{2}$ je vždy dělitelné $11$. Ano.',
            '11.2 Fryšavských je $3k$ z $\\frac{11k}{2}$, tj. $\\frac{6}{11}>\\frac{1}{2}$. Ano.',
            '11.3 Pro $k=8$ je celkem $\\frac{11\\cdot8}{2}=44$ žáků, nikoli $88$. Ne.',
        ],
        'ans': '11.1: Ano; 11.2: Ano; 11.3: Ne',
        'pts': 3, 'mins': 6, 'diff': '3',
        'codes': CODES_BASE + ['aritmetika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
    },
    # ---- úloha 12 (výběr z možností) ----
    {
        'name': 'Zelený E12 – kostky do válce',
        'zad': [
            'Válec o vnitřním průměru $20$ cm je naplněn vodou $2$ cm pod okraj válce. Do válce budeme vkládat ocelové kostky ve tvaru krychle o hraně $2$ cm. $\\pi=3{,}14$.',
            'Kolik kostek musíme vložit do válce, aby voda poprvé přetekla přes okraj válce?',
        ],
        'opts': ['A) $39$', 'B) $40$', 'C) $78$', 'D) $79$', 'E) jiný počet'],
        'ln': 0,
        'sol': [
            'Prázdný prostor nad hladinou: $\\pi r^2\\cdot2=3{,}14\\cdot10^2\\cdot2=628$ cm³. Jedna kostka vytlačí $2^3=8$ cm³ vody. $628:8=78{,}5$, takže $78$ kostek nestačí ($624$ cm³), $79$ kostek ($632$ cm³) vodu přelije.',
        ],
        'ans': 'D) $79$',
        'pts': 2, 'mins': 6, 'diff': '4',
        'codes': CODES_BASE + ['stereometrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 13 (výběr z možností + obrázek) ----
    {
        'name': 'Zelený E13 – úhel v kosočtverci',
        'zad': [
            'Na obrázku je vyznačen kosočtverec a naznačen úhel o velikosti $150^\\circ$ (mezi prodloužením úhlopříčky a stranou kosočtverce).',
            'Jak velký je úhel na obrázku označený symbolem „?".',
        ],
        'opts': ['A) $100^\\circ$', 'B) $110^\\circ$', 'C) $120^\\circ$', 'D) $150^\\circ$', 'E) jiný výsledek'],
        'ln': 0,
        'svg': SVG13, 'fn': 'kosoctverec.svg',
        'alt': 'Kosočtverec s vyznačenou úhlopříčkou; u horního vrcholu je mezi prodloužením úhlopříčky a stranou úhel 150°, u protějšího vrcholu je vnitřní úhel označený otazníkem.',
        'cap': 'Schematický nákres k úloze 13',
        'sol': [
            'Úhlopříčka půlí vrcholový úhel. Prodloužení úhlopříčky svírá se stranou úhel $150^\\circ$, takže úhlopříčka svírá se stranou $180^\\circ-150^\\circ=30^\\circ$; vrcholový úhel je $2\\cdot30^\\circ=60^\\circ$. Sousední vrcholový úhel kosočtverce (označený „?") je $180^\\circ-60^\\circ=120^\\circ$.',
        ],
        'ans': 'C) $120^\\circ$',
        'pts': 2, 'mins': 5, 'diff': '3',
        'codes': CODES_BASE + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 14 (výběr z možností + obrázek) ----
    {
        'name': 'Zelený E14 – mezikruží a čtverec',
        'zad': [
            'Na obrázku jsou dvě soustředné kružnice – vepsaná a opsaná čtverci o straně $8$ m.',
            'Vypočtěte poměr obsahu plochy šedě podbarveného mezikruží a obsahu plochy bílého kruhu.',
        ],
        'opts': ['A) $2:1$', 'B) $3:2$', 'C) $1:1$', 'D) $2:3$', 'E) jiný poměr'],
        'ln': 0,
        'svg': SVG14, 'fn': 'mezikruzi.svg',
        'alt': 'Čtverec o straně 8 m, do něhož je vepsána menší kružnice a jemuž je opsána větší kružnice; mezikruží mezi kružnicemi je šedé, vnitřní kruh bílý.',
        'cap': 'Dvě soustředné kružnice čtverce',
        'sol': [
            'Vepsaná kružnice má poloměr $r=\\frac{8}{2}=4$ m, opsaná $R=\\frac{8\\sqrt{2}}{2}=4\\sqrt{2}$ m. Mezikruží: $\\pi(R^2-r^2)=\\pi(32-16)=16\\pi$. Bílý kruh: $\\pi r^2=16\\pi$. Poměr $16\\pi:16\\pi=1:1$.',
        ],
        'ans': 'C) $1:1$',
        'pts': 2, 'mins': 5, 'diff': '3',
        'codes': CODES_BASE + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 15 (přiřazování 15.1–15.3 -> A–F) ----
    {
        'name': 'Zelený E15 – procenta (přiřazování)',
        'zad': [
            'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).',
            '15.1 V pravoúhlém trojúhelníku jsou velikosti vnitřních úhlů v poměru $3:2:1$. Prostřední úhel zvětšíme o třetinu. O jakou část musíme zmenšit nejmenší úhel, aby trojúhelník zůstal pravoúhlý?',
            '15.2 V obdélníku zvětšíme jednu stranu o čtvrtinu. O jakou část musíme zmenšit druhou stranu, aby obsah obdélníku zůstal zachován?',
            '15.3 V průběhu chemického pokusu klesá postupně a rovnoměrně objem lihu v baňce. Při prvním měření $4$ minuty po zahájení pokusu byl jeho objem o pětinu menší než při zahájení pokusu. O jakou část objemu zjištěného při prvním měření klesne objem lihu v baňce za dalších osm minut?',
        ],
        'opts': ['A) o $\\frac{3}{4}$', 'B) o $\\frac{2}{3}$', 'C) o $\\frac{1}{2}$', 'D) o $\\frac{1}{4}$', 'E) o $\\frac{1}{5}$', 'F) jiný výsledek'],
        'ln': 0,
        'sol': [
            '15.1 Úhly jsou $90^\\circ,60^\\circ,30^\\circ$. Prostřední zvětšíme o třetinu na $80^\\circ$ (o $20^\\circ$). Pravý úhel zůstává $90^\\circ$, takže nejmenší úhel je $180^\\circ-90^\\circ-80^\\circ=10^\\circ$; zmenšil se z $30^\\circ$ o $20^\\circ$, tj. o $\\frac{2}{3}$ → B.',
            '15.2 Strana krát $\\frac{5}{4}$; druhou vynásobíme $\\frac{4}{5}$, tj. zmenšíme o $\\frac{1}{5}$ → E.',
            '15.3 Rovnoměrný pokles $\\frac{1}{5}$ objemu za $4$ min. Za dalších $8$ min klesne o $2\\cdot\\frac{1}{5}=\\frac{2}{5}$ počátečního objemu. Vzhledem k prvnímu měření ($\\frac{4}{5}$ počátku) je to $\\frac{2/5}{4/5}=\\frac{1}{2}$ → C.',
        ],
        'ans': '15.1: B (o $\\frac{2}{3}$); 15.2: E (o $\\frac{1}{5}$); 15.3: C (o $\\frac{1}{2}$)',
        'pts': 6, 'mins': 9, 'diff': '4',
        'codes': CODES_BASE + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
    },
    # ---- úloha 16 (výchozí text + obrázek; houpačky/páky společný kontext) ----
    {
        'name': 'Zelený E16 – houpačky v rovnováze',
        'zad': [
            'Na obrázku jsou čtyři houpačky. Na pravé straně každé z nich jsou ve vyznačené vzdálenosti od vzpěry umístěny kameny, každý o hmotnosti $40$ kg (shora dolů $3$, $3$, $1$ a $6$ kamenů). Na levou stranu každé houpačky je třeba ve vyznačené vzdálenosti umístit kameny tak, aby houpačky zůstaly v rovnovážné poloze.',
            '16.1 Vypočtěte celkovou hmotnost kamenů potřebných k tomu, aby všechny čtyři houpačky byly v rovnovážné poloze.',
            '16.2 Vypočtěte, kolik bude třeba na vyvážení houpaček kamenů, víme-li, že máme k dispozici kameny o hmotnosti $40$ kg, $20$ kg a $10$ kg a desetikilogramových je třiapůlkrát více než kamenů o hmotnosti $20$ kg.',
        ],
        'opts': None, 'ln': 4,
        'svg': SVG16, 'fn': 'houpacky.svg',
        'alt': 'Čtyři páky (houpačky). Zleva vzdálenosti a počty kamenů: 1,5 m / 1 m (3 kameny); 0,9 m / 1,2 m (3 kameny); 50 cm / 2 m (1 kámen); 180 cm / 1,5 m (6 kamenů).',
        'cap': 'Čtyři houpačky s vyznačenými vzdálenostmi',
        'sol': [
            'Rovnováha páky: hmotnost krát vzdálenost vlevo = hmotnost krát vzdálenost vpravo.',
            '1. houpačka: $m\\cdot1{,}5=3\\cdot40\\cdot1\\Rightarrow m=80$ kg. 2.: $m\\cdot0{,}9=3\\cdot40\\cdot1{,}2\\Rightarrow m=160$ kg. 3.: $m\\cdot0{,}5=40\\cdot2\\Rightarrow m=160$ kg. 4.: $m\\cdot1{,}8=6\\cdot40\\cdot1{,}5\\Rightarrow m=200$ kg.',
            '16.1 Celkem $80+160+160+200=600$ kg.',
            '16.2 Nechť je $y$ kamenů po $20$ kg a $z=3{,}5y$ kamenů po $10$ kg a $x$ kamenů po $40$ kg. Z $40x+20y+10z=600$ a $z=3{,}5y$ dostaneme $y=8$, $z=28$, $x=4$. Celkem $4+8+28=40$ kamenů.',
        ],
        'ans': '16.1: $600$ kg; 16.2: $40$ kamenů',
        'pts': 6, 'mins': 9, 'diff': '4',
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
    written = gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-zeleny-testE'))
    total = 0
    for path, sz, k in written:
        total += k
        flag = 'OK' if sz < 9000 else 'PŘES 9KB!'
        print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{flag}]')
    print('Celkem úloh:', total)
