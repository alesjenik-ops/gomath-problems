# -*- coding: utf-8 -*-
# Data: Cvičný TEST G (úlohy 1–16). Zdroj: Matematika - Zelený.
# Dělení: izolované poduúlohy 2,3,4,5,7 -> samostatné úlohy; společný kontext 6,8,11,15,16 -> jedna úloha.
# SVG bez apostrofů a zpětných lomítek (viz návod §9).

# ---------- SVG obrázky (bez apostrofů a zpětných lomítek) ----------

SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 330" font-family="sans-serif">
<polygon points="40,280 160,120 347,50 467,210 280,280" fill="#eef3ea" stroke="#000000" stroke-width="2"/>
<line x1="280" y1="280" x2="160" y2="120" stroke="#000000" stroke-width="1.2"/>
<line x1="280" y1="280" x2="347" y2="50" stroke="#000000" stroke-width="1.2"/>
<text x="92" y="192" font-size="17" text-anchor="middle" transform="rotate(-53 92 192)">50 m</text>
<text x="160" y="303" font-size="17" text-anchor="middle">60 m</text>
</svg>"""

SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 240" font-family="sans-serif">
<line x1="110" y1="80" x2="315" y2="175" stroke="#999999" stroke-width="1" stroke-dasharray="4 5"/>
<text x="205" y="118" font-size="15" text-anchor="middle" fill="#333333">6 cm</text>
<line x1="100" y1="80" x2="120" y2="80" stroke="#000000" stroke-width="1.6"/>
<line x1="110" y1="70" x2="110" y2="90" stroke="#000000" stroke-width="1.6"/>
<text x="97" y="66" font-size="18" font-weight="bold" font-style="italic">P</text>
<line x1="305" y1="175" x2="325" y2="175" stroke="#000000" stroke-width="1.6"/>
<line x1="315" y1="165" x2="315" y2="185" stroke="#000000" stroke-width="1.6"/>
<text x="326" y="172" font-size="18" font-weight="bold" font-style="italic">R</text>
</svg>"""

SVG10 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 300 200" font-family="sans-serif">
<line x1="140" y1="100" x2="160" y2="100" stroke="#000000" stroke-width="1.8"/>
<line x1="150" y1="90" x2="150" y2="110" stroke="#000000" stroke-width="1.8"/>
<text x="166" y="98" font-size="18" font-weight="bold" font-style="italic">T</text>
</svg>"""

SVG11 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif">
<circle cx="55" cy="228" r="7" fill="#000000"/>
<text x="55" y="255" font-size="15" text-anchor="middle" font-weight="bold">my</text>
<ellipse cx="380" cy="80" rx="62" ry="38" fill="#cfe2f3" stroke="#2a6099" stroke-width="1.5"/>
<text x="380" y="85" font-size="15" text-anchor="middle" fill="#1a3c5a">jezero</text>
<path d="M 62 224 C 150 205 215 148 322 90" fill="none" stroke="#444444" stroke-width="2.2"/>
<path d="M 62 232 C 130 300 305 250 352 114" fill="none" stroke="#444444" stroke-width="2.2" stroke-dasharray="7 5"/>
<text x="168" y="146" font-size="14" fill="#333333">10 cm</text>
<text x="232" y="258" font-size="14" fill="#333333">8 cm</text>
</svg>"""

SVG12 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 400" font-family="sans-serif">
<polygon points="90,180 330,180 460,115 220,115" fill="#dcdcdc" stroke="#000000" stroke-width="2"/>
<polygon points="330,180 460,115 460,265 330,330" fill="#c4c4c4" stroke="#000000" stroke-width="2"/>
<polygon points="90,180 330,180 330,330 90,330" fill="#eeeeee" stroke="#000000" stroke-width="2"/>
<path d="M 150 330 L 150 270 A 60 60 0 0 1 270 270 L 270 330 Z" fill="#ffffff" stroke="#000000" stroke-width="2"/>
<path d="M 210 210 L 340 145" fill="none" stroke="#000000" stroke-width="1" stroke-dasharray="5 4"/>
<line x1="62" y1="180" x2="62" y2="330" stroke="#000000" stroke-width="1"/>
<text x="52" y="258" font-size="15" text-anchor="middle" transform="rotate(-90 52 258)">5 m</text>
<text x="126" y="306" font-size="14" text-anchor="middle">2 m</text>
<text x="292" y="278" font-size="14" text-anchor="middle" transform="rotate(-90 292 278)">4 m</text>
<text x="120" y="352" font-size="14" text-anchor="middle">2 m</text>
<text x="210" y="352" font-size="14" text-anchor="middle">4 m</text>
<text x="300" y="352" font-size="14" text-anchor="middle">2 m</text>
<text x="408" y="212" font-size="15" text-anchor="middle" transform="rotate(-27 408 212)">10 m</text>
</svg>"""

SVG13 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 290" font-family="sans-serif">
<polygon points="160,60 248,124 214,228 106,228 72,124" fill="#ffffff" stroke="#000000" stroke-width="2.5"/>
<path d="M 248 90 A 42 42 0 1 1 286 148" fill="none" stroke="#000000" stroke-width="1.5"/>
<text x="300" y="86" font-size="15" text-anchor="middle">vnější úhel</text>
</svg>"""

SVG14 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 380" font-family="sans-serif">
<rect x="60" y="40" width="300" height="300" fill="#ffffff" stroke="#000000" stroke-width="0.8"/>
<path d="M 60 40 A 300 300 0 0 1 360 340 L 60 340 Z" fill="#b9b9b9" stroke="#000000" stroke-width="1.5"/>
<path d="M 60 190 A 150 150 0 0 1 210 340 L 60 340 Z" fill="#ffffff" stroke="#000000" stroke-width="1.5"/>
<line x1="60" y1="360" x2="210" y2="360" stroke="#000000" stroke-width="1.2"/>
<line x1="210" y1="360" x2="360" y2="360" stroke="#000000" stroke-width="1.2"/>
<line x1="60" y1="352" x2="60" y2="368" stroke="#000000" stroke-width="1.2"/>
<line x1="210" y1="352" x2="210" y2="368" stroke="#000000" stroke-width="1.2"/>
<line x1="360" y1="352" x2="360" y2="368" stroke="#000000" stroke-width="1.2"/>
<text x="135" y="378" font-size="16" text-anchor="middle" font-style="italic">a</text>
<text x="285" y="378" font-size="16" text-anchor="middle" font-style="italic">b</text>
</svg>"""

SVG16 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 720 430" font-family="sans-serif">
<text x="150" y="30" font-size="18" font-weight="bold" text-anchor="middle">CHLAPCI</text>
<text x="570" y="30" font-size="18" font-weight="bold" text-anchor="middle">DIVKY</text>
<path d="M 150 170 L 150 75 A 95 95 0 0 1 205.8 93.1 Z" fill="#d9d9d9" stroke="#ffffff" stroke-width="1.5"/>
<path d="M 150 170 L 205.8 93.1 A 95 95 0 0 1 226.9 114.2 Z" fill="#bdbdbd" stroke="#ffffff" stroke-width="1.5"/>
<path d="M 150 170 L 226.9 114.2 A 95 95 0 0 1 205.8 246.9 Z" fill="#9a9a9a" stroke="#ffffff" stroke-width="1.5"/>
<path d="M 150 170 L 205.8 246.9 A 95 95 0 0 1 73.1 225.8 Z" fill="#767676" stroke="#ffffff" stroke-width="1.5"/>
<path d="M 150 170 L 73.1 225.8 A 95 95 0 0 1 73.1 114.2 Z" fill="#515151" stroke="#ffffff" stroke-width="1.5"/>
<path d="M 150 170 L 73.1 114.2 A 95 95 0 0 1 150 75 Z" fill="#2b2b2b" stroke="#ffffff" stroke-width="1.5"/>
<text x="184.3" y="65.4" font-size="15" text-anchor="middle">10%</text>
<text x="228.5" y="92.5" font-size="15" text-anchor="middle">5%</text>
<text x="259.6" y="188.4" font-size="15" text-anchor="middle">25%</text>
<text x="132.6" y="280.6" font-size="15" text-anchor="middle">25%</text>
<text x="39" y="171" font-size="15" text-anchor="middle">20%</text>
<text x="99.6" y="72.1" font-size="15" text-anchor="middle">15%</text>
<path d="M 570 170 L 570 75 A 95 95 0 0 1 599.4 79.6 Z" fill="#d9d9d9" stroke="#ffffff" stroke-width="1.5"/>
<path d="M 570 170 L 599.4 79.6 A 95 95 0 0 1 625.8 93.1 Z" fill="#bdbdbd" stroke="#ffffff" stroke-width="1.5"/>
<path d="M 570 170 L 625.8 93.1 A 95 95 0 0 1 625.8 246.9 Z" fill="#9a9a9a" stroke="#ffffff" stroke-width="1.5"/>
<path d="M 570 170 L 625.8 246.9 A 95 95 0 0 1 479.6 140.6 Z" fill="#767676" stroke="#ffffff" stroke-width="1.5"/>
<path d="M 570 170 L 479.6 140.6 A 95 95 0 0 1 514.2 93.1 Z" fill="#515151" stroke="#ffffff" stroke-width="1.5"/>
<path d="M 570 170 L 514.2 93.1 A 95 95 0 0 1 570 75 Z" fill="#2b2b2b" stroke="#ffffff" stroke-width="1.5"/>
<text x="587.4" y="61.4" font-size="15" text-anchor="middle">5%</text>
<text x="620.4" y="72.1" font-size="15" text-anchor="middle">5%</text>
<text x="681" y="171" font-size="15" text-anchor="middle">30%</text>
<text x="504.8" y="260.8" font-size="15" text-anchor="middle">40%</text>
<text x="480.2" y="105.8" font-size="15" text-anchor="middle">10%</text>
<text x="535.7" y="65.4" font-size="15" text-anchor="middle">10%</text>
<rect x="230" y="330" width="20" height="20" fill="#d9d9d9" stroke="#000000" stroke-width="0.7"/>
<text x="257" y="345" font-size="15">mene nez 35</text>
<rect x="230" y="360" width="20" height="20" fill="#bdbdbd" stroke="#000000" stroke-width="0.7"/>
<text x="257" y="375" font-size="15">35 - 39 let</text>
<rect x="230" y="390" width="20" height="20" fill="#9a9a9a" stroke="#000000" stroke-width="0.7"/>
<text x="257" y="405" font-size="15">40 - 44 let</text>
<rect x="440" y="330" width="20" height="20" fill="#767676" stroke="#000000" stroke-width="0.7"/>
<text x="467" y="345" font-size="15">45 - 49 let</text>
<rect x="440" y="360" width="20" height="20" fill="#515151" stroke="#000000" stroke-width="0.7"/>
<text x="467" y="375" font-size="15">50 - 54 let</text>
<rect x="440" y="390" width="20" height="20" fill="#2b2b2b" stroke="#000000" stroke-width="0.7"/>
<text x="467" y="405" font-size="15">55 a vice let</text>
</svg>"""

# ---------- Úlohy ----------

CODES_BASE = ['zs2', 'r9']

PROBLEMS = [
    # ---- úloha 1 (jedna otázka) ----
    {
        'name': 'Zelený G1 – osminásobek a pětina',
        'zad': ['Vypočtěte, kolikrát větší je osminásobek čísla $6{,}28$ než jeho pětina.'],
        'opts': None, 'ln': 1,
        'sol': ['Osminásobek je $8\\cdot 6{,}28=50{,}24$, pětina je $6{,}28:5=1{,}256$. Podíl $50{,}24:1{,}256=40$ (obecně $\\frac{8x}{x/5}=40$).'],
        'ans': '$40$krát',
        'pts': 1, 'mins': 2, 'diff': '2',
        'codes': CODES_BASE + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 2 (2.1, 2.2 izolované) ----
    {
        'name': 'Zelený G2.1 – zlomky a desetinná čísla',
        'zad': ['Vypočtěte: $\\frac{7}{5}:0{,}14-0{,}8:\\frac{1}{5}=$'],
        'opts': None, 'ln': 2,
        'sol': ['$\\frac{7}{5}:0{,}14=1{,}4:0{,}14=10$; $0{,}8:\\frac{1}{5}=0{,}8\\cdot 5=4$. Výsledek $10-4=6$.'],
        'ans': '$6$',
        'pts': 1, 'mins': 2, 'diff': '2',
        'codes': CODES_BASE + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    {
        'name': 'Zelený G2.2 – odmocnina a druhá mocnina',
        'zad': ['Vypočtěte: $\\frac{\\sqrt{0{,}04}}{0{,}1}\\cdot 0{,}5^2=$'],
        'opts': None, 'ln': 2,
        'sol': ['$\\sqrt{0{,}04}=0{,}2$, tedy $\\frac{0{,}2}{0{,}1}=2$. Dále $0{,}5^2=0{,}25$. Výsledek $2\\cdot 0{,}25=0{,}5$.'],
        'ans': '$0{,}5$',
        'pts': 1, 'mins': 2, 'diff': '2',
        'codes': CODES_BASE + ['mocniny-odmocniny', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 3 (3.1, 3.2 izolované; výsledek jako desetinné číslo) ----
    {
        'name': 'Zelený G3.1 – výraz se zlomky (desetinný výsledek)',
        'zad': ['Vypočtěte a výsledek zapište jako desetinné číslo: $\\frac{3}{8}-0{,}2\\cdot\\left(\\frac{9}{2}+3\\right):1{,}5=$'],
        'opts': None, 'ln': 2,
        'sol': ['$\\frac{9}{2}+3=7{,}5$; $0{,}2\\cdot 7{,}5=1{,}5$; $1{,}5:1{,}5=1$. Výsledek $\\frac{3}{8}-1=0{,}375-1=-0{,}625$.'],
        'ans': '$-0{,}625$',
        'pts': 1, 'mins': 3, 'diff': '2',
        'codes': CODES_BASE + ['zlomky', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    {
        'name': 'Zelený G3.2 – složený zlomek (desetinný výsledek)',
        'zad': ['Vypočtěte a výsledek zapište jako desetinné číslo: $\\dfrac{-\\frac{6}{5}+3\\frac{1}{5}}{2+\\frac{2}{3}}=$'],
        'opts': None, 'ln': 2,
        'sol': ['Čitatel: $-1{,}2+3{,}2=2$. Jmenovatel: $2+\\frac{2}{3}=\\frac{8}{3}$. Výsledek $2:\\frac{8}{3}=\\frac{6}{8}=0{,}75$.'],
        'ans': '$0{,}75$',
        'pts': 2, 'mins': 4, 'diff': '3',
        'codes': CODES_BASE + ['zlomky', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 4 (4.1, 4.2 izolované; zjednodušte) ----
    {
        'name': 'Zelený G4.1 – úprava výrazu',
        'zad': ['Zjednodušte: $(4x-y+3)\\cdot x-(y+x)\\cdot 5x=$'],
        'opts': None, 'ln': 2,
        'sol': ['$(4x-y+3)x=4x^2-xy+3x$; $(y+x)\\cdot 5x=5xy+5x^2$. Rozdíl $4x^2-xy+3x-5xy-5x^2=3x-6xy-x^2$.'],
        'ans': '$3x-6xy-x^2$',
        'pts': 2, 'mins': 3, 'diff': '3',
        'codes': CODES_BASE + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    {
        'name': 'Zelený G4.2 – úprava výrazu se zlomkem',
        'zad': ['Zjednodušte: $\\dfrac{(x^2-y^2)\\cdot(x+y)}{x-y}-2x^3y^2:yx^2=$'],
        'opts': None, 'ln': 2,
        'sol': ['$\\frac{x^2-y^2}{x-y}=x+y$, proto první člen $=(x+y)^2$. Dále $2x^3y^2:(yx^2)=2xy$. Výsledek $(x+y)^2-2xy=x^2+y^2$.'],
        'ans': '$x^2+y^2$',
        'pts': 2, 'mins': 4, 'diff': '3',
        'codes': CODES_BASE + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 5 (5.1, 5.2 izolované; řešte rovnici) ----
    {
        'name': 'Zelený G5.1 – lineární rovnice',
        'zad': ['Řešte rovnici: $3x-2=\\frac{1}{3}\\cdot(x-2)-(5-2x)$'],
        'opts': None, 'ln': 2,
        'sol': ['Vynásobíme třemi: $9x-6=(x-2)-3(5-2x)=7x-17$. Odtud $2x=-11$, tedy $x=-\\frac{11}{2}=-5{,}5$.'],
        'ans': '$x=-\\frac{11}{2}=-5{,}5$',
        'pts': 2, 'mins': 3, 'diff': '3',
        'codes': CODES_BASE + ['linearni-rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    {
        'name': 'Zelený G5.2 – lineární rovnice se zlomky',
        'zad': ['Řešte rovnici: $2{,}5a-16-\\dfrac{7{,}5a+2}{3}=\\dfrac{\\frac{7}{3}a-3}{2}$'],
        'opts': None, 'ln': 2,
        'sol': ['Vynásobíme šesti: $15a-96-2(7{,}5a+2)=3\\left(\\frac{7}{3}a-3\\right)$, tj. $15a-96-15a-4=7a-9$. Odtud $-100=7a-9$, $7a=-91$, $a=-13$.'],
        'ans': '$a=-13$',
        'pts': 2, 'mins': 4, 'diff': '3',
        'codes': CODES_BASE + ['linearni-rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 6 (výchozí text; 6.1+6.2 společný kontext) ----
    {
        'name': 'Zelený G6 – ředění lihu ve válcové nádobě',
        'zad': [
            'Do skleněné nádoby tvaru válce jsme nalili $500$ ml lihu o koncentraci $80\\,\\%$. Hladina dosáhla výšky $10$ cm. Postupně budeme do nádoby přilévat destilovanou vodu tak, abychom snížili koncentraci lihu na $10\\,\\%$.',
            '6.1 Vypočtěte, jak vysokou nádobu musíme zvolit, abychom ředění na $10\\,\\%$ mohli provést.',
            '6.2 Vypočtěte, jaké koncentrace lihu dosáhneme, budeme-li mít k dispozici pouze nádobu o výšce $40$ cm.',
        ],
        'opts': None, 'ln': 4,
        'sol': [
            '6.1 Čistého lihu je $500\\cdot 0{,}8=400$ ml a jeho množství se nemění. Pro koncentraci $10\\,\\%$ je celkový objem $400:0{,}1=4000$ ml. Protože $500$ ml odpovídá $10$ cm (tedy $50$ ml na $1$ cm), je potřebná výška $4000:50=80$ cm.',
            '6.2 V nádobě vysoké $40$ cm je nejvýše $40\\cdot 50=2000$ ml roztoku. Koncentrace lihu je $\\frac{400}{2000}=0{,}2=20\\,\\%$.',
        ],
        'ans': '6.1: nejméně $80$ cm; 6.2: $20\\,\\%$',
        'pts': 4, 'mins': 8, 'diff': '3',
        'codes': CODES_BASE + ['procenta', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
    },
    # ---- úloha 7 (7.1,7.2,7.3 izolované "Vypočtěte" -> 3 samostatné úlohy) ----
    {
        'name': 'Zelený G7.1 – hladina vody v nádrži',
        'zad': ['V jaké výšce bude hladina vody v nádrži, jestliže zmenšíme šířku a délku původní nádrže na čtvrtinu a v původní nádrži dosahovala voda do výšky $10$ cm? Výsledek uveďte v cm.'],
        'opts': None, 'ln': 2,
        'sol': ['Obsah dna se zmenší na $\\frac{1}{4}\\cdot\\frac{1}{4}=\\frac{1}{16}$. Při stejném objemu vody vzroste výška $16$krát: $10\\cdot 16=160$ cm.'],
        'ans': '$160$ cm',
        'pts': 1, 'mins': 3, 'diff': '2',
        'codes': CODES_BASE + ['stereometrie', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
    },
    {
        'name': 'Zelený G7.2 – žitná mouka na chleba',
        'zad': ['Kolik tun žitné mouky je potřeba k výrobě $6000$ dvoukilogramových bochníků chleba, víme-li, že na výrobu $1$ kg chleba je třeba $600$ g pšeničné a o polovinu méně žitné mouky? Výsledek uveďte v metrických centech.'],
        'opts': None, 'ln': 2,
        'sol': ['Chleba celkem: $6000\\cdot 2=12\\,000$ kg. Na $1$ kg chleba je žitné mouky $\\frac{1}{2}\\cdot 600=300$ g. Celkem $12\\,000\\cdot 0{,}3=3600$ kg $=36$ q (metrických centů).'],
        'ans': '$36$ q',
        'pts': 1, 'mins': 3, 'diff': '3',
        'codes': CODES_BASE + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
    },
    {
        'name': 'Zelený G7.3 – čas u toaletního stolku',
        'zad': ['Kolik dnů celkově stráví paní Ptáčková u toaletního stolku za $40$ let svého života, jestliže u něj denně sedí v průměru $15$ minut ráno a $5$ minut večer? Počítejte s délkou roku $360$ dnů.'],
        'opts': None, 'ln': 2,
        'sol': ['Denně $15+5=20$ minut. Za $40$ let: $20\\cdot 360\\cdot 40=288\\,000$ minut. To je $288\\,000:1440=200$ dnů (den má $1440$ minut).'],
        'ans': '$200$ dnů',
        'pts': 1, 'mins': 3, 'diff': '2',
        'codes': CODES_BASE + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
    },
    # ---- úloha 8 (výchozí text + obrázek; 8.1+8.2 společný kontext) ----
    {
        'name': 'Zelený G8 – pozemek ze tří trojúhelníků',
        'zad': [
            'Na obrázku je pozemek složený ze $3$ stejných parcel tvaru rovnoramenného trojúhelníku (základna $60$ m, ramena $50$ m). Majitel pozemku se rozhodl pozemek oplotit.',
            '8.1 Vypočtěte výměru pozemku v hektarech.',
            '8.2 Vypočtěte počet plotových sloupků, které bude třeba nainstalovat k montáži plotu okolo celého pozemku, víme-li, že vzdálenost mezi sousedními sloupky je $1$ metr.',
        ],
        'opts': None, 'ln': 4,
        'svg': SVG8, 'fn': 'pozemek.svg',
        'alt': 'Pozemek složený ze tří shodných rovnoramenných trojúhelníků se základnou 60 m a rameny 50 m.',
        'cap': 'Pozemek ze tří shodných trojúhelníkových parcel',
        'sol': [
            '8.1 Výška trojúhelníku k základně $60$ m je $\\sqrt{50^2-30^2}=40$ m, obsah jednoho $\\frac{1}{2}\\cdot 60\\cdot 40=1200$ m². Tři parcely mají $3\\cdot 1200=3600$ m² $=0{,}36$ ha.',
            '8.2 Obvod pozemku tvoří jedna základna $60$ m a čtyři ramena po $50$ m: $60+4\\cdot 50=260$ m. Při rozteči $1$ m je potřeba $260$ sloupků.',
        ],
        'ans': '8.1: $0{,}36$ ha; 8.2: $260$ sloupků',
        'pts': 4, 'mins': 8, 'diff': '3',
        'codes': CODES_BASE + ['planimetrie', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
    },
    # ---- úloha 9 (konstrukce – množina vrcholů obdélníků) ----
    {
        'name': 'Zelený G9 – množina vrcholů obdélníků PQRS',
        'zad': [
            'V rovině leží body $P$ a $R$ vzdálené od sebe $6$ cm.',
            'Vyznačte množinu vrcholů $Q$ a $S$ všech obdélníků $PQRS$.',
        ],
        'opts': None, 'ln': 0,
        'svg': SVG9, 'fn': 'body-PR.svg',
        'alt': 'Dva body P a R v rovině vzdálené 6 cm od sebe, každý označený křížkem.',
        'cap': 'Výchozí obrázek k úloze 9',
        'sol': [
            'V obdélníku $PQRS$ jsou $P$, $R$ protilehlé vrcholy (úhlopříčka). Úhly u $Q$ a $S$ jsou pravé, proto $Q$ i $S$ leží na Thaletově kružnici nad průměrem $PR$ (střed je střed úsečky $PR$, poloměr $3$ cm). Vynecháme body $P$, $R$ (útvar by degeneroval) a dva body, v nichž by $PQRS$ byl čtverec, nikoli obdélník.',
        ],
        'ans': 'Zvýrazněná Thaletova kružnice nad průměrem $PR$ (poloměr $3$ cm) s výjimkou bodů $P$, $R$ a dvou bodů, pro něž by $PQRS$ byl čtverec.',
        'pts': 2, 'mins': 6, 'diff': '3',
        'codes': CODES_BASE + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 10 (konstrukce – trojúhelník z těžnic) ----
    {
        'name': 'Zelený G10 – konstrukce trojúhelníku z těžnic',
        'zad': [
            'V rovině je dán bod $T$, který je těžištěm trojúhelníku $ABC$.',
            'Sestrojte trojúhelník $ABC$, víme-li, že jeho těžnice $t_a=9$ cm a $t_b=6$ cm spolu svírají pravý úhel.',
        ],
        'opts': None, 'ln': 0,
        'svg': SVG10, 'fn': 'teziste-T.svg',
        'alt': 'Bod T označený křížkem v rovině (těžiště hledaného trojúhelníku ABC).',
        'cap': 'Výchozí obrázek k úloze 10',
        'sol': [
            'Těžiště dělí těžnice v poměru $2:1$: $|TA|=\\frac{2}{3}\\cdot 9=6$ cm, $|TS_a|=3$ cm, $|TB|=\\frac{2}{3}\\cdot 6=4$ cm, $|TS_b|=2$ cm. V bodě $T$ sestrojíme pravý úhel, na jedno rameno naneseme $A$ a na opačnou polopřímku $S_a$, na druhé rameno $B$ a na opačnou polopřímku $S_b$. Bod $C$ dopočteme z toho, že $S_a$ je střed $BC$ a $S_b$ střed $AC$.',
        ],
        'ans': 'Konstrukce trojúhelníku $ABC$ s těžištěm $T$ (těžnice $t_a=9$ cm a $t_b=6$ cm svírají pravý úhel; $|TA|=6$, $|TB|=4$ cm), viz obrázek v klíči.',
        'pts': 2, 'mins': 6, 'diff': '4',
        'codes': CODES_BASE + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 11 (výchozí text + mapa; 11.1–11.3 Ano/Ne, společný kontext) ----
    {
        'name': 'Zelený G11 – dvě trasy k jezeru (mapa a měřítko)',
        'zad': [
            'Na mapě v měřítku $1:100\\,000$ vedou od nás k jezeru dvě trasy. Jedna měří $10$ cm, druhá o $2$ cm méně. Ve skutečnosti je to tak, že ať jdete jednou či druhou cestou, trvá vám to k jezeru dvě hodiny.',
            'Rozhodněte o každém z následujících tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).',
            '11.1 Jdete-li delší trasou, jdete o pětinu rychleji.',
            '11.2 Půjdete-li od jezera jinou trasou než k němu, bude výlet k jezeru a zpět $18$ km dlouhý.',
            '11.3 Na mapě $1:25\\,000$ budou ve srovnání s mapou v měřítku $1:100\\,000$ trasy o čtvrtinu delší.',
        ],
        'opts': None, 'ln': 0,
        'svg': SVG11, 'fn': 'trasy-jezero.svg',
        'alt': 'Schematická mapka: od výchozího bodu vedou k jezeru dvě trasy, delší 10 cm a kratší 8 cm (v měřítku mapy).',
        'cap': 'Schematický nákres dvou tras k jezeru',
        'sol': [
            'Skutečné délky: $10$ cm $=10$ km, $8$ cm $=8$ km. Obě trvají $2$ h, tedy rychlosti $5$ km/h a $4$ km/h.',
            '11.1 Delší trasou jdete $5$ km/h oproti $4$ km/h, tj. o čtvrtinu rychleji, ne o pětinu. Nepravdivé (Ne).',
            '11.2 Tam jednou a zpět druhou trasou: $10+8=18$ km. Pravdivé (Ano).',
            '11.3 Měřítko $1:25\\,000$ je $4$krát podrobnější, trasy jsou na mapě $4$krát delší, ne o čtvrtinu. Nepravdivé (Ne).',
        ],
        'ans': '11.1: Ne; 11.2: Ano; 11.3: Ne',
        'pts': 3, 'mins': 6, 'diff': '3',
        'codes': CODES_BASE + ['aritmetika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
    },
    # ---- úloha 12 (výběr z možností + obrázek) ----
    {
        'name': 'Zelený G12 – obklad viaduktu (obsah)',
        'zad': [
            'Na obrázku je betonové těleso viaduktu dlouhého $10$ m a širokého $8$ m. Výška viaduktu je $5$ metrů. V ose tělesa vede $4$ m široký a $4$ m vysoký průjezd (spodní část výšky $2$ m, nad ní půlkruhový oblouk). Vnitřek průjezdu i obě jeho čelní stěny jsou obloženy dlaždicemi.',
            'Jaký je obsah plochy obložené dlaždicemi? Výsledek zaokrouhlete na celé m² ($\\pi=3{,}14$).',
        ],
        'opts': ['A) $95$ m²', 'B) $114$ m²', 'C) $154$ m²', 'D) $209$ m²', 'E) jiný výsledek'],
        'ln': 0,
        'svg': SVG12, 'fn': 'viadukt.svg',
        'alt': 'Betonový viadukt 10 m dlouhý, 8 m široký, 5 m vysoký s průjezdem 4 m širokým a 4 m vysokým (obdélník 2 m a půlkruhový oblouk o poloměru 2 m).',
        'cap': 'Viadukt s klenutým průjezdem',
        'sol': [
            'Průřez průjezdu: obdélník $4\\times 2$ m a půlkruh o poloměru $2$ m, obsah $8+\\frac{1}{2}\\pi\\cdot 2^2=8+6{,}28=14{,}28$ m².',
            'Vnitřek průjezdu (dvě boční stěny po $2$ m a půlkruhový oblouk délky $\\pi\\cdot 2=6{,}28$ m) má obsah $(2+2+6{,}28)\\cdot 10=102{,}8$ m².',
            'Dvě čelní stěny: $2\\cdot(8\\cdot 5-14{,}28)=2\\cdot 25{,}72=51{,}44$ m². Celkem $102{,}8+51{,}44=154{,}24\\doteq 154$ m².',
        ],
        'ans': 'C) $154$ m²',
        'pts': 2, 'mins': 7, 'diff': '4',
        'codes': CODES_BASE + ['stereometrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
    },
    # ---- úloha 13 (výběr z možností + obrázek) ----
    {
        'name': 'Zelený G13 – součet vnějších úhlů n-úhelníku',
        'zad': [
            'Pro každý $n$-úhelník platí, že součet jeho vnitřních úhlů $=(n-2)\\cdot 180^\\circ$. Na obrázku je příklad jednoho z „vnějších" úhlů pětiúhelníku (doplněk vnitřního úhlu do plného úhlu $360^\\circ$).',
            'Který z $n$-úhelníků (A–E) má součet svých „vnějších" úhlů roven $1800^\\circ$?',
        ],
        'opts': ['A) pětiúhelník', 'B) šestiúhelník', 'C) sedmiúhelník', 'D) osmiúhelník', 'E) devítiúhelník'],
        'ln': 0,
        'svg': SVG13, 'fn': 'vnejsi-uhel.svg',
        'alt': 'Pětiúhelník s vyznačeným „vnějším" úhlem u jednoho vrcholu (úhel doplňující vnitřní úhel do 360 stupňů).',
        'cap': 'Schematický nákres „vnějšího" úhlu pětiúhelníku',
        'sol': [
            'Každý „vnější" úhel je $360^\\circ$ minus vnitřní úhel. Součet $=n\\cdot 360^\\circ-(n-2)\\cdot 180^\\circ=180^\\circ n+360^\\circ$. Z rovnice $180n+360=1800$ plyne $n=8$, tedy osmiúhelník.',
        ],
        'ans': 'D) osmiúhelník',
        'pts': 2, 'mins': 5, 'diff': '3',
        'codes': CODES_BASE + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 14 (výběr z možností + obrázek) ----
    {
        'name': 'Zelený G14 – kruhová výseč (poměr obsahů)',
        'zad': [
            'Na obrázku je $90^\\circ$ kruhová výseč rozdělená na bílou a šedou část. Délka $a$ a délka $b$ jsou si rovny.',
            'V jakém vzájemném poměru jsou obsahy bílé a šedé části kruhové výseče?',
        ],
        'opts': ['A) $2:3$', 'B) $1:2$', 'C) $1:3$', 'D) $1:4$', 'E) jiný poměr'],
        'ln': 0,
        'svg': SVG14, 'fn': 'kruhova-vysec.svg',
        'alt': 'Čtvrtkruh o poloměru a plus b; vnitřní čtvrtkruh o poloměru a je bílý, vnější mezikruhová část je šedá.',
        'cap': 'Kruhová výseč rozdělená na bílou a šedou část',
        'sol': [
            'Vnitřní bílá čtvrtkruhová část má poloměr $a$, obsah $\\frac{1}{4}\\pi a^2$. Celá výseč má poloměr $a+b=2a$, obsah $\\frac{1}{4}\\pi(2a)^2=\\pi a^2$. Šedá část $\\pi a^2-\\frac{1}{4}\\pi a^2=\\frac{3}{4}\\pi a^2$. Poměr bílá : šedá $=1:3$.',
        ],
        'ans': 'C) $1:3$',
        'pts': 2, 'mins': 4, 'diff': '3',
        'codes': CODES_BASE + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 15 (přiřazování 15.1–15.3 -> A–F; společná nabídka) ----
    {
        'name': 'Zelený G15 – přiřazování (slovní úlohy)',
        'zad': [
            'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).',
            '15.1 V krabici, do které se vejde nejvýše $30$ kuliček, jsou kuličky dvou barev. Modrých je o dvě více než červených. Polovina modrých kuliček je provrtaná, pětina červených je označena bílou barvou. Kolik je v krabici kuliček?',
            '15.2 Ještě v listopadu stál kolobřich $162$ korun, před Vánocemi však podražil o třetinu. Nyní, v lednu, koukám, že zase o třetinu zlevnil. Kolik korun je rozdíl mezi listopadovou a lednovou cenou kolobřichu?',
            '15.3 Do vedlejší devítky chodí o desetinu více žáků než do naší. V naší třídě ale třetina žáků propadá z matiky. Kolik žáků je v naší třídě, jestliže víme, že největší třída může mít podle zákona $33$ žáků?',
        ],
        'opts': ['A) $0$', 'B) $10$', 'C) $18$', 'D) $25$', 'E) $30$', 'F) jiný výsledek'],
        'ln': 0,
        'sol': [
            '15.1 Červených $c$, modrých $c+2$. Polovina modrých je celé číslo $\\Rightarrow c$ sudé; pětina červených celé $\\Rightarrow c$ dělitelné $5$; navíc $2c+2\\le 30$. Vyhovuje $c=10$, celkem $2\\cdot 10+2=22$ kuliček. To v nabídce není → F.',
            '15.2 Před Vánocemi $162\\cdot\\frac{4}{3}=216$ Kč, v lednu $216\\cdot\\frac{2}{3}=144$ Kč. Rozdíl $162-144=18$ Kč → C.',
            '15.3 Naše třída $n$: třetina propadá $\\Rightarrow n$ dělitelné $3$; vedlejší $\\frac{11}{10}n$ celé a nejvýše $33 \\Rightarrow n$ dělitelné $10$ a $n\\le 30$. Tedy $n=30$ (vedlejší $33$) → E.',
        ],
        'ans': '15.1: F (jiný výsledek, $22$); 15.2: C ($18$); 15.3: E ($30$)',
        'pts': 6, 'mins': 10, 'diff': '4',
        'codes': CODES_BASE + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'finance'],
    },
    # ---- úloha 16 (výchozí text + koláčové grafy; 16.1–16.3 společný kontext) ----
    {
        'name': 'Zelený G16 – věk maminek (koláčové grafy)',
        'zad': [
            'Do posledního ročníku chodí $100$ žáků, chlapců je však o třetinu méně než děvčat (tj. $40$ chlapců a $60$ dívek). Zaznamenali jsme, kolik procent chlapců a kolik procent dívek má mámu v určitém věku (pětileté intervaly), viz grafy.',
            'Na základě informací nahraďte v následujících větách (16.1–16.3) symbol ***** správným výrazem nebo číslem.',
            '16.1 Mírně přes jednu ***** žáků (chlapců i dívek dohromady) má mámu ve věku $50$ a více let.',
            '16.2 Celkem ***** $\\%$ z nás má mámu ve věku 40–49 let. Dívek je v této skupině o něco více než *****krát tolik.',
            '16.3 Téměř ***** všech žáků (chlapců i dívek dohromady) posledního ročníku má mámu mladší $40$ let.',
        ],
        'opts': None, 'ln': 4,
        'svg': SVG16, 'fn': 'vek-mamin.svg',
        'alt': 'Dva koláčové grafy: chlapci (10, 5, 25, 25, 20, 15 %) a dívky (5, 5, 30, 40, 10, 10 %) podle věku mámy v pětiletých intervalech od méně než 35 do 55 a více let.',
        'cap': 'Věk maminek chlapců a dívek posledního ročníku',
        'sol': [
            '16.1 Mámu $50$ a více let má u chlapců $35\\,\\%$ ze $40=14$, u dívek $20\\,\\%$ ze $60=12$; celkem $26$ ze $100$, tj. mírně přes jednu čtvrtinu.',
            '16.2 Věk 40–49 let: chlapci $50\\,\\%$ ze $40=20$, dívky $70\\,\\%$ ze $60=42$; celkem $62$ ze $100=62\\,\\%$. Dívek ($42$) je o něco více než dvakrát tolik co chlapců ($20$).',
            '16.3 Mámu mladší $40$ let má chlapců $15\\,\\%$ ze $40=6$, dívek $10\\,\\%$ ze $60=6$; celkem $12$ ze $100$, tj. téměř jednu osminu.',
        ],
        'ans': '16.1: čtvrtinu ($26\\,\\%$); 16.2: $62\\,\\%$, dvakrát; 16.3: osminu ($12\\,\\%$)',
        'pts': 6, 'mins': 10, 'diff': '4',
        'codes': CODES_BASE + ['statistika', 'porozumeni', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
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
    written = gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-zeleny-testG'))
    total = 0
    for path, sz, k in written:
        total += k
        flag = 'OK' if sz < 9000 else 'PŘES 9KB!'
        print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{flag}]')
    print('Celkem úloh:', total)
