# -*- coding: utf-8 -*-
# Data: Cvičný TEST D (úlohy 1–16). Zdroj: Matematika - Zelený.
# SVG bez apostrofů a zpětných lomítek (viz návod §9).

# ---------- SVG obrázky ----------

SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 380" font-family="sans-serif"><polygon points="230,78 380,190 230,303 80,190" fill="#e9efe6" stroke="#000" stroke-width="2.5"/><line x1="80" y1="190" x2="380" y2="190" stroke="#444" stroke-width="1.5" stroke-dasharray="5 5"/><line x1="230" y1="78" x2="230" y2="303" stroke="#444" stroke-width="1.5" stroke-dasharray="5 5"/><text x="320" y="182" font-size="17" text-anchor="middle">16 m</text><text x="263" y="150" font-size="17" text-anchor="middle">12 m</text></svg>"""

SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 120" font-family="sans-serif"><line x1="50" y1="70" x2="410" y2="70" stroke="#000" stroke-width="1.5"/><line x1="120" y1="58" x2="120" y2="82" stroke="#000" stroke-width="2"/><line x1="360" y1="58" x2="360" y2="82" stroke="#000" stroke-width="2"/><text x="120" y="102" font-size="18" text-anchor="middle" font-style="italic" font-weight="bold">A</text><text x="360" y="102" font-size="18" text-anchor="middle" font-style="italic" font-weight="bold">D</text><text x="240" y="55" font-size="14" text-anchor="middle">8 cm</text></svg>"""

SVG10 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 320" font-family="sans-serif"><line x1="112" y1="82" x2="128" y2="98" stroke="#000" stroke-width="2"/><line x1="128" y1="82" x2="112" y2="98" stroke="#000" stroke-width="2"/><text x="98" y="86" font-size="18" font-style="italic" font-weight="bold">S</text><line x1="292" y1="242" x2="308" y2="258" stroke="#000" stroke-width="2"/><line x1="308" y1="242" x2="292" y2="258" stroke="#000" stroke-width="2"/><text x="282" y="274" font-size="18" font-style="italic" font-weight="bold">T</text></svg>"""

SVG11 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 375" font-family="sans-serif"><line x1="58" y1="20" x2="500" y2="20" stroke="#ccc" stroke-width="1"/><text x="50" y="25" font-size="13" text-anchor="end">16</text><line x1="58" y1="80" x2="500" y2="80" stroke="#ccc" stroke-width="1"/><text x="50" y="85" font-size="13" text-anchor="end">12</text><line x1="58" y1="140" x2="500" y2="140" stroke="#ccc" stroke-width="1"/><text x="50" y="145" font-size="13" text-anchor="end">8</text><line x1="58" y1="200" x2="500" y2="200" stroke="#ccc" stroke-width="1"/><text x="50" y="205" font-size="13" text-anchor="end">4</text><line x1="58" y1="260" x2="500" y2="260" stroke="#ccc" stroke-width="1"/><text x="50" y="265" font-size="13" text-anchor="end">0</text><line x1="58" y1="320" x2="500" y2="320" stroke="#ccc" stroke-width="1"/><text x="50" y="325" font-size="13" text-anchor="end">-4</text><line x1="58" y1="20" x2="58" y2="320" stroke="#000" stroke-width="1.5"/><line x1="58" y1="260" x2="500" y2="260" stroke="#000" stroke-width="1.5"/><rect x="62" y="260" width="20" height="30" fill="#bbb" stroke="#666" stroke-width="0.8"/><rect x="86" y="140" width="20" height="120" fill="#555" stroke="#222" stroke-width="0.8"/><text x="85" y="337" font-size="13" text-anchor="middle">Po</text><rect x="125" y="230" width="20" height="30" fill="#bbb" stroke="#666" stroke-width="0.8"/><rect x="149" y="50" width="20" height="210" fill="#555" stroke="#222" stroke-width="0.8"/><text x="148" y="337" font-size="13" text-anchor="middle">Út</text><rect x="188" y="245" width="20" height="15" fill="#bbb" stroke="#666" stroke-width="0.8"/><rect x="212" y="50" width="20" height="210" fill="#555" stroke="#222" stroke-width="0.8"/><text x="211" y="337" font-size="13" text-anchor="middle">St</text><rect x="251" y="260" width="20" height="15" fill="#bbb" stroke="#666" stroke-width="0.8"/><rect x="275" y="65" width="20" height="195" fill="#555" stroke="#222" stroke-width="0.8"/><text x="274" y="337" font-size="13" text-anchor="middle">Čt</text><rect x="314" y="260" width="20" height="30" fill="#bbb" stroke="#666" stroke-width="0.8"/><rect x="338" y="50" width="20" height="210" fill="#555" stroke="#222" stroke-width="0.8"/><text x="337" y="337" font-size="13" text-anchor="middle">Pá</text><rect x="377" y="260" width="20" height="45" fill="#bbb" stroke="#666" stroke-width="0.8"/><rect x="401" y="65" width="20" height="195" fill="#555" stroke="#222" stroke-width="0.8"/><text x="400" y="337" font-size="13" text-anchor="middle">So</text><rect x="440" y="260" width="20" height="45" fill="#bbb" stroke="#666" stroke-width="0.8"/><rect x="464" y="35" width="20" height="225" fill="#555" stroke="#222" stroke-width="0.8"/><text x="463" y="337" font-size="13" text-anchor="middle">Ne</text><rect x="150" y="352" width="16" height="12" fill="#bbb" stroke="#666"/><text x="170" y="362" font-size="12">nejnižší</text><rect x="300" y="352" width="16" height="12" fill="#555" stroke="#222"/><text x="320" y="362" font-size="12">nejvyšší</text></svg>"""

SVG12 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 390" font-family="sans-serif"><text x="120" y="150" font-size="13" text-anchor="middle" font-weight="bold">Pohled z průčelí</text><rect x="40" y="250" width="160" height="90" fill="none" stroke="#000" stroke-width="2"/><polygon points="40,250 120,170 200,250" fill="none" stroke="#000" stroke-width="2"/><polygon points="40,250 200,250 152,202 88,202" fill="#cfcfcf" stroke="#000" stroke-width="1"/><line x1="120" y1="170" x2="120" y2="202" stroke="#444" stroke-dasharray="3 3"/><text x="138" y="192" font-size="13">2 m</text><line x1="222" y1="170" x2="222" y2="250" stroke="#444" stroke-dasharray="4 4"/><text x="228" y="214" font-size="13">5 m</text><line x1="40" y1="356" x2="200" y2="356" stroke="#444" stroke-width="1"/><text x="120" y="372" font-size="13" text-anchor="middle">10 m</text><text x="400" y="150" font-size="13" text-anchor="middle" font-weight="bold">Pohled z boku</text><rect x="320" y="175" width="160" height="165" fill="none" stroke="#000" stroke-width="2"/><rect x="320" y="278" width="160" height="62" fill="#cfcfcf" stroke="#000" stroke-width="1"/><line x1="320" y1="356" x2="480" y2="356" stroke="#444" stroke-width="1"/><text x="400" y="372" font-size="13" text-anchor="middle">8 m</text></svg>"""

SVG13 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 380" font-family="sans-serif"><line x1="60" y1="255" x2="460" y2="45" stroke="#000" stroke-width="2"/><line x1="60" y1="255" x2="492" y2="300" stroke="#000" stroke-width="2"/><line x1="335" y1="348" x2="406" y2="58" stroke="#000" stroke-width="2"/><text x="112" y="243" font-size="16">30,25°</text><text x="366" y="312" font-size="16">105,2°</text><text x="416" y="98" font-size="22" font-style="italic">?</text></svg>"""

SVG16 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 432 236" font-family="sans-serif" font-size="15"><rect x="6" y="6" width="418" height="222" fill="none" stroke="#000" stroke-width="1.5"/><line x1="64" y1="6" x2="64" y2="228" stroke="#000"/><line x1="124" y1="32" x2="124" y2="228" stroke="#000"/><line x1="184" y1="32" x2="184" y2="228" stroke="#000"/><line x1="244" y1="32" x2="244" y2="228" stroke="#000"/><line x1="304" y1="32" x2="304" y2="228" stroke="#000"/><line x1="364" y1="32" x2="364" y2="228" stroke="#000"/><line x1="64" y1="32" x2="424" y2="32" stroke="#000"/><line x1="6" y1="60" x2="424" y2="60" stroke="#000"/><line x1="6" y1="88" x2="424" y2="88" stroke="#000"/><line x1="6" y1="116" x2="424" y2="116" stroke="#000"/><line x1="6" y1="144" x2="424" y2="144" stroke="#000"/><line x1="6" y1="172" x2="424" y2="172" stroke="#000"/><line x1="6" y1="200" x2="424" y2="200" stroke="#000"/><text x="35" y="26" text-anchor="middle" font-size="10">VŠICHNI</text><text x="35" y="40" text-anchor="middle" font-size="10">ŽÁCI</text><text x="35" y="54" text-anchor="middle" font-size="10">ČEŠTINA</text><text x="244" y="25" text-anchor="middle" font-weight="bold">MATEMATIKA</text><text x="94" y="52" text-anchor="middle" font-size="15">1</text><text x="154" y="52" text-anchor="middle" font-size="15">2</text><text x="214" y="52" text-anchor="middle" font-size="15">3</text><text x="274" y="52" text-anchor="middle" font-size="15">4</text><text x="334" y="52" text-anchor="middle" font-size="15">5</text><text x="394" y="52" text-anchor="middle" font-size="10">CELKEM</text><text x="35" y="79" text-anchor="middle" font-size="15">1</text><text x="94" y="79" text-anchor="middle">4</text><text x="154" y="79" text-anchor="middle">8</text><text x="214" y="79" text-anchor="middle">2</text><text x="394" y="79" text-anchor="middle">14</text><text x="35" y="107" text-anchor="middle" font-size="15">2</text><text x="94" y="107" text-anchor="middle">4</text><text x="154" y="107" text-anchor="middle">6</text><text x="214" y="107" text-anchor="middle">6</text><text x="274" y="107" text-anchor="middle">8</text><text x="394" y="107" text-anchor="middle">24</text><text x="35" y="135" text-anchor="middle" font-size="15">3</text><text x="94" y="135" text-anchor="middle">2</text><text x="154" y="135" text-anchor="middle">4</text><text x="214" y="135" text-anchor="middle">16</text><text x="274" y="135" text-anchor="middle">16</text><text x="334" y="135" text-anchor="middle">4</text><text x="394" y="135" text-anchor="middle">42</text><text x="35" y="163" text-anchor="middle" font-size="15">4</text><text x="154" y="163" text-anchor="middle">2</text><text x="214" y="163" text-anchor="middle">4</text><text x="274" y="163" text-anchor="middle">10</text><text x="334" y="163" text-anchor="middle">2</text><text x="394" y="163" text-anchor="middle">18</text><text x="35" y="191" text-anchor="middle" font-size="15">5</text><text x="334" y="191" text-anchor="middle">2</text><text x="394" y="191" text-anchor="middle">2</text><text x="35" y="219" text-anchor="middle" font-size="10">CELKEM</text><text x="94" y="219" text-anchor="middle">10</text><text x="154" y="219" text-anchor="middle">20</text><text x="214" y="219" text-anchor="middle">28</text><text x="274" y="219" text-anchor="middle">34</text><text x="334" y="219" text-anchor="middle">8</text><text x="394" y="219" text-anchor="middle">100</text></svg>"""

# ---------- Úlohy ----------

CODES_BASE = ['zs2', 'r9']

PROBLEMS = [
    # ---- úloha 1 ----
    {
        'name': 'Zelený D1 – rozdíl trojnásobků',
        'zad': ['Vypočtěte rozdíl trojnásobku čísla $1{,}5$ a trojnásobku čísla $-1{,}5$.'],
        'opts': None, 'ln': 1,
        'sol': ['$3\\cdot 1{,}5 - 3\\cdot(-1{,}5) = 4{,}5 + 4{,}5 = 9$.'],
        'ans': '$9$',
        'pts': 1, 'mins': 2, 'diff': '1',
        'codes': CODES_BASE + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 2 (2.1, 2.2 izolované) ----
    {
        'name': 'Zelený D2.1 – desetinná čísla, pořadí operací',
        'zad': ['Vypočtěte: $1{,}2:0{,}6\\cdot(0{,}5-0{,}4)+0{,}3\\cdot 0{,}2:0{,}1$'],
        'opts': None, 'ln': 1,
        'sol': ['$1{,}2:0{,}6=2$, $2\\cdot 0{,}1=0{,}2$; $0{,}3\\cdot 0{,}2=0{,}06$, $0{,}06:0{,}1=0{,}6$; celkem $0{,}2+0{,}6=0{,}8$.'],
        'ans': '$0{,}8$',
        'pts': 1, 'mins': 2, 'diff': '2',
        'codes': CODES_BASE + ['desetinna-cisla', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    {
        'name': 'Zelený D2.2 – mocnina a dělení desetinných čísel',
        'zad': ['Vypočtěte: $(0{,}25:0{,}5)^2:0{,}01$'],
        'opts': None, 'ln': 1,
        'sol': ['$0{,}25:0{,}5=0{,}5$; $0{,}5^2=0{,}25$; $0{,}25:0{,}01=25$.'],
        'ans': '$25$',
        'pts': 1, 'mins': 2, 'diff': '2',
        'codes': CODES_BASE + ['desetinna-cisla', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 3 (3.1, 3.2 izolované) ----
    {
        'name': 'Zelený D3.1 – zlomky, smíšené číslo',
        'zad': [
            'Vypočtěte a výsledek zapište jako smíšené číslo:',
            '$\\left(\\frac{5}{12}+2\\frac{1}{3}\\right):\\left(\\frac{1}{5}+\\frac{1}{6}\\right)$',
        ],
        'opts': None, 'ln': 2,
        'sol': ['$\\frac{5}{12}+\\frac{28}{12}=\\frac{33}{12}=\\frac{11}{4}$; $\\frac{1}{5}+\\frac{1}{6}=\\frac{11}{30}$; $\\frac{11}{4}:\\frac{11}{30}=\\frac{30}{4}=\\frac{15}{2}=7\\frac{1}{2}$.'],
        'ans': '$7\\frac{1}{2}$',
        'pts': 1, 'mins': 3, 'diff': '2',
        'codes': CODES_BASE + ['zlomky', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    {
        'name': 'Zelený D3.2 – složený zlomek, smíšené číslo',
        'zad': [
            'Vypočtěte a výsledek zapište jako smíšené číslo:',
            '$1-\\frac{\\frac{3}{8}-\\frac{4}{3}}{\\frac{5}{4}}$',
        ],
        'opts': None, 'ln': 2,
        'sol': ['$\\frac{3}{8}-\\frac{4}{3}=\\frac{9-32}{24}=-\\frac{23}{24}$; $-\\frac{23}{24}:\\frac{5}{4}=-\\frac{23}{30}$; $1-\\left(-\\frac{23}{30}\\right)=1\\frac{23}{30}$.'],
        'ans': '$1\\frac{23}{30}$',
        'pts': 2, 'mins': 4, 'diff': '3',
        'codes': CODES_BASE + ['zlomky', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 4 (4.1, 4.2 izolované) ----
    {
        'name': 'Zelený D4.1 – zjednodušení výrazu (druhá mocnina)',
        'zad': ['Zjednodušte výraz: $\\left(\\frac{3x}{2}-1\\right)^2\\cdot\\frac{2}{3}+2x$'],
        'opts': None, 'ln': 2,
        'sol': ['$\\left(\\frac{3x}{2}-1\\right)^2=\\frac{9x^2}{4}-3x+1$; po vynásobení $\\frac{2}{3}$: $\\frac{3x^2}{2}-2x+\\frac{2}{3}$; a $+2x$ dává $\\frac{3}{2}x^2+\\frac{2}{3}$.'],
        'ans': '$\\frac{3}{2}x^2+\\frac{2}{3}$',
        'pts': 2, 'mins': 3, 'diff': '3',
        'codes': CODES_BASE + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    {
        'name': 'Zelený D4.2 – zjednodušení lomeného výrazu',
        'zad': ['Zjednodušte výraz: $\\frac{(2x+1)\\cdot(2-x)+(x-2)\\cdot 5}{x-2}$'],
        'opts': None, 'ln': 2,
        'sol': ['Čitatel: $(2x+1)(2-x)+5(x-2)=-2x^2+3x+2+5x-10=-2x^2+8x-8=-2(x-2)^2$; po vydělení $(x-2)$: $-2(x-2)=4-2x$.'],
        'ans': '$4-2x$',
        'pts': 2, 'mins': 4, 'diff': '3',
        'codes': CODES_BASE + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 5 (5.1, 5.2 izolované) ----
    {
        'name': 'Zelený D5.1 – lineární rovnice se zlomky',
        'zad': ['Řešte rovnici: $\\frac{x+3}{2}-\\frac{2x+5}{3}=8$'],
        'opts': None, 'ln': 2,
        'sol': ['Vynásobíme $6$: $3(x+3)-2(2x+5)=48$; $3x+9-4x-10=48$; $-x-1=48$; $x=-49$.'],
        'ans': '$x=-49$',
        'pts': 2, 'mins': 3, 'diff': '3',
        'codes': CODES_BASE + ['linearni-rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    {
        'name': 'Zelený D5.2 – lineární rovnice se zlomky',
        'zad': ['Řešte rovnici: $0{,}5y+\\frac{3}{2}\\left(\\frac{y-2}{3}\\right)=\\frac{y-4}{2}$'],
        'opts': None, 'ln': 2,
        'sol': ['$0{,}5y+\\frac{y-2}{2}=\\frac{y-4}{2}$; vynásobíme $2$: $y+(y-2)=y-4$; $2y-2=y-4$; $y=-2$.'],
        'ans': '$y=-2$',
        'pts': 2, 'mins': 3, 'diff': '3',
        'codes': CODES_BASE + ['linearni-rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 6 (výchozí text; 6.1+6.2 společný kontext) ----
    {
        'name': 'Zelený D6 – omluvení z písemky (rovnice, poměr)',
        'zad': [
            'V naší třídě připadá na $4$ dívky $5$ chlapců. Ze včerejší písemky z matematiky se omluvila pětina chlapců a čtvrtina děvčat. Takže nás písemku psalo jen $21$.',
            '6.1 Neznámý celkový počet žáků ve třídě označte $y$ a sestavte rovnici pro výpočet celkového počtu žáků. Celkový počet omluvených vypočtěte.',
            '6.2 Vypočtěte poměr chlapců a dívek, kteří písemku z matematiky psali.',
        ],
        'opts': None, 'ln': 4,
        'sol': [
            '6.1 Dívek je $\\frac{4}{9}y$, chlapců $\\frac{5}{9}y$. Písemku psalo $\\frac{4}{5}$ chlapců a $\\frac{3}{4}$ dívek: $\\frac{5}{9}y\\cdot\\frac{4}{5}+\\frac{4}{9}y\\cdot\\frac{3}{4}=21$, tj. $\\frac{7}{9}y=21$, $y=27$. Omluvených je $27-21=6$.',
            '6.2 Psalo $\\frac{4}{5}\\cdot 15=12$ chlapců a $\\frac{3}{4}\\cdot 12=9$ dívek, poměr $12:9=4:3$.',
        ],
        'ans': '6.1: $21=\\frac{5}{9}y\\cdot\\frac{4}{5}+\\frac{4}{9}y\\cdot\\frac{3}{4}$, $y=27$, omluvených $6$; 6.2: $4:3$',
        'pts': 4, 'mins': 6, 'diff': '3',
        'codes': CODES_BASE + ['rovnice', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
    },
    # ---- úloha 7 (7.1,7.2,7.3 izolované "Vypočtěte") ----
    {
        'name': 'Zelený D7.1 – měřítko mapy, výměra louky',
        'zad': ['Jaká je výměra louky pana Trávníčka, jestliže na mapě s měřítkem $1:10\\,000$ je louka zobrazena jako čtyřúhelník o obsahu $8$ cm²? Skutečnou výměru louky uveďte v hektarech.'],
        'opts': None, 'ln': 2,
        'sol': ['Obsah na mapě $8$ cm², měřítko $1:10\\,000$. Skutečný obsah $=8\\cdot(10\\,000)^2$ cm² $=8\\cdot 10^8$ cm² $=80\\,000$ m² $=8$ ha.'],
        'ans': '$8$ hektarů',
        'pts': 1, 'mins': 3, 'diff': '2',
        'codes': CODES_BASE + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
    },
    {
        'name': 'Zelený D7.2 – čas startu závodu',
        'zad': ['Jaký byl čas hromadného startu cyklistického závodu, jestliže jeho vítěz dosáhl času 2.55:20 hod. a cílovou páskou projel v 16.02:10 hod.?'],
        'opts': None, 'ln': 2,
        'sol': ['Start = cíl − čas jízdy = 16:02:10 − 2:55:20 = 13:06:50.'],
        'ans': '13.06:50 h',
        'pts': 1, 'mins': 3, 'diff': '2',
        'codes': CODES_BASE + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
    },
    {
        'name': 'Zelený D7.3 – průměrná rychlost sprintera',
        'zad': ['Jakou průměrnou rychlostí běží sprinter, který v běhu na $100$ m dosáhne času $10{,}0$ s? Rychlost uveďte v km/h.'],
        'opts': None, 'ln': 2,
        'sol': ['$v=100:10=10$ m/s. Protože $1$ m/s $=3{,}6$ km/h, je $v=36$ km/h.'],
        'ans': '$36$ km/h',
        'pts': 1, 'mins': 2, 'diff': '2',
        'codes': CODES_BASE + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'fyzika'],
    },
    # ---- úloha 8 (výchozí text + obrázek; 8.1+8.2 společný kontext) ----
    {
        'name': 'Zelený D8 – zahrada tvaru kosočtverce',
        'zad': [
            'Pan Sádlo se rozhodl oplotit zahradu tvaru kosočtverce, jejíž protilehlé rohy jsou od sebe vzdáleny $12$ a $16$ metrů.',
            '8.1 Vypočtěte délku plotu.',
            '8.2 Vypočtěte výměru zahrady a výsledek uveďte v hektarech.',
        ],
        'opts': None, 'ln': 4,
        'svg': SVG8, 'fn': 'kosoctverec.svg',
        'alt': 'Kosočtverec s úhlopříčkami dlouhými 16 m a 12 m.',
        'cap': 'Zahrada tvaru kosočtverce s úhlopříčkami 12 m a 16 m',
        'sol': [
            '8.1 Úhlopříčky kosočtverce jsou $12$ m a $16$ m, jejich poloviny $6$ m a $8$ m. Strana $=\\sqrt{6^2+8^2}=10$ m. Obvod (délka plotu) $=4\\cdot 10=40$ m.',
            '8.2 Obsah $=\\frac{12\\cdot 16}{2}=96$ m² $=0{,}0096$ ha.',
        ],
        'ans': '8.1: $40$ m; 8.2: $0{,}0096$ ha',
        'pts': 4, 'mins': 7, 'diff': '3',
        'codes': CODES_BASE + ['planimetrie', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
    },
    # ---- úloha 9 (konstrukce – šestiúhelník) ----
    {
        'name': 'Zelený D9 – konstrukce nepravidelného šestiúhelníku',
        'zad': [
            'V rovině leží úsečka $AD$ o délce $8$ cm.',
            'Sestrojte nepravidelný šestiúhelník $ABCDEF$. Každý z jeho vrcholů $B$, $C$, $E$, $F$ je vzdálen od bodu $A$ $9$ cm a leží na jedné z přímek procházejících bodem $D$, které svírají s úsečkou $AD$ úhel $75^\\circ$.',
        ],
        'opts': None, 'ln': 0,
        'svg': SVG9, 'fn': 'usecka-AD.svg',
        'alt': 'Vodorovná úsečka AD délky 8 cm s krajními body A a D.',
        'cap': 'Výchozí obrázek k úloze 9',
        'sol': [
            'Sestrojíme úsečku $AD=8$ cm. Bodem $D$ vedeme dvě přímky $p$, $q$ svírající s přímkou $AD$ úhel $75^\\circ$. Kružnice se středem $A$ a poloměrem $9$ cm protne tyto přímky ve čtyřech bodech: $B$, $C$ (nad $AD$) a $E$, $F$ (pod $AD$). Šestiúhelník $ABCDEF$ dostaneme spojením vrcholů v pořadí $A, B, C, D, E, F$.',
        ],
        'ans': 'Konstrukce: bodem $D$ dvě přímky svírající s $AD$ úhel $75^\\circ$; kružnice se středem $A$ a poloměrem $9$ cm protne přímky ve vrcholech $B$, $C$, $E$, $F$; šestiúhelník $ABCDEF$ (viz obrázek v klíči).',
        'pts': 2, 'mins': 6, 'diff': '3',
        'codes': CODES_BASE + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 10 (konstrukce – lichoběžník) ----
    {
        'name': 'Zelený D10 – konstrukce lichoběžníku STUV',
        'zad': [
            'V rovině leží body $S$ a $T$ od sebe vzdálené $8$ cm.',
            'Sestrojte lichoběžník $STUV$ se základnou $ST$, jehož výška je $5$ cm, úhel $TUV$ má $75^\\circ$ a úhel $UVS$ $120^\\circ$.',
        ],
        'opts': None, 'ln': 0,
        'svg': SVG10, 'fn': 'body-ST.svg',
        'alt': 'Dva body S a T označené křížky, vzdálené 8 cm.',
        'cap': 'Výchozí obrázek k úloze 10',
        'sol': [
            'V lichoběžníku $STUV$ je $ST\\parallel UV$. Protože úhel $UVS=120^\\circ$, je úhel při vrcholu $S$ roven $180^\\circ-120^\\circ=60^\\circ$; protože úhel $TUV=75^\\circ$, je úhel při vrcholu $T$ roven $180^\\circ-75^\\circ=105^\\circ$. Sestrojíme základnu $ST=8$ cm a rovnoběžku ve vzdálenosti $5$ cm; ramena vedená z $S$ pod úhlem $60^\\circ$ a z $T$ pod úhlem $105^\\circ$ protnou rovnoběžku ve vrcholech $V$ a $U$.',
        ],
        'ans': 'Konstrukce lichoběžníku $STUV$: základna $ST=8$ cm, rovnoběžka ve vzdálenosti $5$ cm, úhel při $S$ $60^\\circ$ a při $T$ $105^\\circ$; ramena protnou rovnoběžku v $V$ a $U$ (viz obrázek v klíči).',
        'pts': 2, 'mins': 6, 'diff': '3',
        'codes': CODES_BASE + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 11 (výchozí graf; 11.1–11.3 Ano/Ne, společný kontext) ----
    {
        'name': 'Zelený D11 – graf denních teplot (Ano/Ne)',
        'zad': [
            'V grafu jsou zobrazeny nejvyšší a nejnižší denní teploty (ve stupních Celsia) v uplynulém týdnu.',
            'Rozhodněte o každém z následujících tvrzení 11.1–11.3, zda je pravdivé (Ano), či nikoli (Ne).',
            '11.1 Rozdíl mezi nejvyšší a nejnižší denní teplotou během týdne vzrostl o $80\\,\\%$.',
            '11.2 Průměrná nejvyšší denní teplota byla v uplynulém týdnu $12$ °C.',
            '11.3 Na počátku týdne vzrostla nejvyšší denní teplota během jednoho dne o $75\\,\\%$.',
        ],
        'opts': None, 'ln': 0,
        'svg': SVG11, 'fn': 'graf-teploty.svg',
        'alt': 'Sloupcový graf nejnižších a nejvyšších denních teplot pro sedm dní týdne (pondělí až neděle).',
        'cap': 'Nejvyšší a nejnižší denní teploty v uplynulém týdnu',
        'sol': [
            '11.1 V pondělí je rozdíl $8-(-2)=10$ °C, v neděli $15-(-3)=18$ °C. Nárůst $\\frac{18}{10}=1{,}8$, tj. o $80\\,\\%$. Pravdivé (Ano).',
            '11.2 Nejvyšší teploty jsou $8, 14, 14, 13, 14, 13, 15$; průměr $\\frac{91}{7}=13$ °C, nikoli $12$ °C. Nepravdivé (Ne).',
            '11.3 Z pondělí ($8$ °C) na úterý ($14$ °C) je nárůst $\\frac{14}{8}=1{,}75$, tj. o $75\\,\\%$. Pravdivé (Ano).',
        ],
        'ans': '11.1: Ano; 11.2: Ne; 11.3: Ano',
        'pts': 3, 'mins': 6, 'diff': '3',
        'codes': CODES_BASE + ['statistika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
    },
    # ---- úloha 12 (výběr z možností + obrázek) ----
    {
        'name': 'Zelený D12 – objem obytné části půdy',
        'zad': [
            'Dům je široký $10$ metrů a dlouhý $8$ metrů. Výška štítu střechy, který má tvar rovnoramenného trojúhelníku, je $5$ metrů. Prostor půdy je rozdělen ve výšce $2$ metry od hřebenu hambalkem.',
            'Jaký je objem obytné části půdy, která je vyznačena na obrázku šedým podkresem?',
        ],
        'opts': ['A) $84$ m³', 'B) $100$ m³', 'C) $168$ m³', 'D) $200$ m³', 'E) jiný výsledek'],
        'ln': 0,
        'svg': SVG12, 'fn': 'pudni-prostor.svg',
        'alt': 'Pohled z průčelí na dům se sedlovou střechou výšky 5 m a hambalkem 2 m pod hřebenem, obytná část půdy je šedě vyznačena; pohled z boku s délkou 8 m.',
        'cap': 'Půdní prostor rozdělený hambalkem',
        'sol': [
            'Hambalek je $2$ m pod hřebenem, tj. $3$ m nad podlahou půdy. Ve výšce $3$ m z $5$ m má štít šířku $10\\cdot\\frac{5-3}{5}=4$ m. Obytná část je lichoběžník se základnami $10$ m a $4$ m a výškou $3$ m: $S=\\frac{10+4}{2}\\cdot 3=21$ m². Objem $=21\\cdot 8=168$ m³.',
        ],
        'ans': 'C) $168$ m³',
        'pts': 2, 'mins': 5, 'diff': '3',
        'codes': CODES_BASE + ['stereometrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
    },
    # ---- úloha 13 (výběr z možností + obrázek) ----
    {
        'name': 'Zelený D13 – velikost úhlu z přímek',
        'zad': [
            'Na obrázku jsou přímky a vyznačené velikosti úhlů $30{,}25^\\circ$ a $105{,}2^\\circ$.',
            'Jak velký je úhel na obrázku označený symbolem „?“.',
        ],
        'opts': ["A) $105^\\circ\\,12'$", "B) $135^\\circ\\,27'$", "C) $135^\\circ\\,45'$", "D) $155^\\circ\\,27'$", 'E) jiný výsledek'],
        'ln': 0,
        'svg': SVG13, 'fn': 'uhly-primky.svg',
        'alt': 'Trojúhelník s úhlem 30,25° u levého dolního vrcholu a 105,2° u pravého dolního vrcholu; hledaný úhel označený otazníkem je u horního vrcholu.',
        'cap': 'Schematický nákres k úloze 13',
        'sol': [
            "Úhel označený „?“ je vnějším úhlem trojúhelníku a rovná se součtu dvou vnitřních úhlů při zbývajících vrcholech: $?=30{,}25^\\circ+105{,}2^\\circ=135{,}45^\\circ$. Protože $0{,}45^\\circ=27'$, je $?=135^\\circ\\,27'$.",
        ],
        'ans': "B) $135^\\circ\\,27'$",
        'pts': 2, 'mins': 5, 'diff': '3',
        'codes': CODES_BASE + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 14 (výběr z možností) ----
    {
        'name': 'Zelený D14 – poměr drah ručiček hodin',
        'zad': [
            'Délka vteřinové ručičky věžních hodin je stejná jako délka minutové ručičky a třikrát větší než délka ručičky hodinové.',
            'Jaký je poměr délky drah špičky hodinové, minutové a vteřinové ručičky, které urazí za $1$ hodinu?',
        ],
        'opts': ['A) $1:12:720$', 'B) $1:36:720$', 'C) $1:36:2160$', 'D) $1:60:3600$', 'E) jiný poměr'],
        'ln': 0,
        'sol': [
            'Označme délku hodinové ručičky $1$; minutová i vteřinová mají délku $3$. Za $1$ hodinu urazí špička hodinové $\\frac{1}{12}$ obvodu své kružnice, minutová $1$ obvod a vteřinová $60$ obvodů. Dráhy jsou úměrné součinu (délka $\\times$ počet otáček): $1\\cdot\\frac{1}{12} : 3\\cdot 1 : 3\\cdot 60 = \\frac{1}{12}:3:180$. Po vynásobení $12$: $1:36:2160$.',
        ],
        'ans': 'C) $1:36:2160$',
        'pts': 2, 'mins': 5, 'diff': '3',
        'codes': CODES_BASE + ['planimetrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
    },
    # ---- úloha 15 (přiřazování 15.1–15.3 -> A–F) ----
    {
        'name': 'Zelený D15 – procenta (přiřazování)',
        'zad': [
            'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).',
            '15.1 Páté kolo závodu projel Nico Rosberg o $5\\,\\%$ rychleji než první kolo. V každém dalším kole pak přidával ještě další $2$ km/h. V osmém kole jsme tak jeho „williamsu“ naměřili průměrných $216$ km/h. O kolik $\\%$ byla průměrná rychlost Rosberga v osmém kole vyšší ve srovnání s prvním kolem závodu?',
            '15.2 V letošním roce se nám podařilo proti loňsku snížit náklady o $20\\,\\%$. O kolik $\\%$ byly vloni náklady vyšší ve srovnání s letoškem?',
            '15.3 V posledních třech letech se cena elektřiny každým rokem (meziročně) zvýšila o $5\\,\\%$. O kolik $\\%$ je stávající cena elektřiny vyšší než před čtyřmi lety?',
        ],
        'opts': ['A) o $8\\,\\%$', 'B) o $10\\,\\%$', 'C) o $15\\,\\%$', 'D) o $16\\,\\%$', 'E) o $25\\,\\%$', 'F) jiný výsledek'],
        'ln': 0,
        'sol': [
            '15.1 V osmém kole $216=1{,}05v_1+6$ (tři přírůstky po $2$ km/h mezi $5.$ a $8.$ kolem), tedy $1{,}05v_1=210$, $v_1=200$ km/h. Nárůst $\\frac{216}{200}=1{,}08$, tj. o $8\\,\\%$ → A.',
            '15.2 Letos jsou náklady $0{,}8$ loňských. Loni byly vyšší o $\\frac{0{,}2}{0{,}8}=0{,}25$, tj. o $25\\,\\%$ → E.',
            '15.3 $1{,}05^3=1{,}157625$, tj. nárůst o $15{,}7625\\,\\%$; to není v nabídce → F.',
        ],
        'ans': '15.1: A (o $8\\,\\%$); 15.2: E (o $25\\,\\%$); 15.3: F (o $15{,}7625\\,\\%$)',
        'pts': 6, 'mins': 9, 'diff': '4',
        'codes': CODES_BASE + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'finance'],
    },
    # ---- úloha 16 (výchozí tabulka; 16.1–16.3 společný kontext) ----
    {
        'name': 'Zelený D16 – tabulka známek (průměr, procenta)',
        'zad': [
            'Žádná velká sláva. Tak takto dopadl náš ročník na vysvědčení z matematiky a češtiny. V tabulce je zaznamenán počet žáků, kteří dostali na vysvědčení příslušnou kombinaci známek (řádky = čeština, sloupce = matematika).',
            '16.1 Vypočtěte průměrnou známku z matematiky a z češtiny a určete, o kolik klasifikačních stupňů se od sebe liší průměrné známky z těchto předmětů.',
            '16.2 Vypočtěte, u kolika procent žáků se klasifikace z matematiky a klasifikace z češtiny lišila o více než jeden klasifikační stupeň.',
            '16.3 Vypočtěte, kolik procent žáků získalo z těchto dvou předmětů průměr lepší než $2{,}5$.',
        ],
        'opts': None, 'ln': 4,
        'svg': SVG16, 'fn': 'tabulka-znamek.svg',
        'alt': 'Tabulka počtu žáků podle kombinace známek z matematiky (sloupce 1 až 5) a z češtiny (řádky 1 až 5) s celkovými součty 100 žáků.',
        'cap': 'Počty žáků podle kombinace známek z matematiky a češtiny',
        'sol': [
            '16.1 Průměr z matematiky: $\\frac{1\\cdot 10+2\\cdot 20+3\\cdot 28+4\\cdot 34+5\\cdot 8}{100}=\\frac{310}{100}=3{,}1$. Průměr z češtiny: $\\frac{1\\cdot 14+2\\cdot 24+3\\cdot 42+4\\cdot 18+5\\cdot 2}{100}=\\frac{270}{100}=2{,}7$. Liší se o $0{,}4$ stupně.',
            '16.2 Žáci s rozdílem známek alespoň $2$: $2+8+(2+4)+2=18$, tj. $18\\,\\%$.',
            '16.3 Průměr lepší než $2{,}5$ znamená součet známek nejvýše $4$: $(4+8+2)+(4+6)+2=26$ žáků, tj. $26\\,\\%$.',
        ],
        'ans': '16.1: MA $3{,}1$, ČJ $2{,}7$, rozdíl $0{,}4$; 16.2: $18\\,\\%$; 16.3: $26\\,\\%$',
        'pts': 6, 'mins': 9, 'diff': '4',
        'codes': CODES_BASE + ['statistika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
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
    written = gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-zeleny-testD'))
    total = 0
    for path, sz, k in written:
        total += k
        flag = 'OK' if sz < 9000 else 'PŘES 9KB!'
        print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{flag}]')
    print('Celkem úloh:', total)
