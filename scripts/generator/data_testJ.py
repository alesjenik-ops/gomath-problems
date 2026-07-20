# -*- coding: utf-8 -*-
# Data: Cvičný TEST J (úlohy 1–16). Zdroj: Matematika - Zelený.
# Dělení podúloh dle návodu: izolované (2,3,4,5,7) -> samostatné úlohy;
# společný kontext (6,8,11,15,16) -> jedna úloha. SVG bez ' a \ (viz návod §9).

# ---------- SVG obrázky (bez apostrofů a zpětných lomítek) ----------

SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 450" font-family="sans-serif">
<rect x="90" y="70" width="330" height="300" fill="none" stroke="#000" stroke-width="2.5"/>
<text x="428" y="64" font-size="16" font-weight="bold">CÍL</text>
<text x="86" y="392" font-size="16" font-weight="bold" text-anchor="end">START</text>
<line x1="90" y1="398" x2="420" y2="398" stroke="#333" stroke-width="1.5"/>
<polygon points="420,398 410,393 410,403" fill="#333"/>
<text x="255" y="420" font-size="15" text-anchor="middle">Beranovi</text>
<line x1="66" y1="370" x2="66" y2="70" stroke="#333" stroke-width="1.5"/>
<polygon points="66,70 61,80 71,80" fill="#333"/>
<text x="52" y="220" font-size="15" text-anchor="middle" transform="rotate(-90 52 220)">Kozlovi</text>
<text x="255" y="235" font-size="15" text-anchor="middle">10 km</text>
<text x="180" y="225" font-size="15" text-anchor="middle" transform="rotate(-90 180 225)">10 km</text>
<circle cx="90" cy="196" r="6" fill="#888"/>
<circle cx="290" cy="370" r="6" fill="#888"/>
<line x1="90" y1="196" x2="290" y2="370" stroke="#000" stroke-width="1.5" stroke-dasharray="4 5"/>
</svg>"""

SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 380" font-family="sans-serif">
<text x="150" y="58" font-size="18" font-weight="bold" text-anchor="middle">S</text>
<line x1="150" y1="70" x2="120" y2="360" stroke="#000" stroke-width="2"/>
<text x="104" y="375" font-size="18" font-style="italic">q</text>
<line x1="150" y1="70" x2="400" y2="300" stroke="#000" stroke-width="2"/>
<text x="405" y="306" font-size="18" font-style="italic">p</text>
</svg>"""

SVG10 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 140" font-family="sans-serif">
<line x1="40" y1="72" x2="470" y2="72" stroke="#000" stroke-width="2"/>
<line x1="90" y1="60" x2="90" y2="84" stroke="#000" stroke-width="2"/>
<line x1="300" y1="60" x2="300" y2="84" stroke="#000" stroke-width="2"/>
<text x="84" y="106" font-size="18" font-weight="bold">A</text>
<text x="295" y="106" font-size="18" font-weight="bold">S</text>
<text x="478" y="78" font-size="18" font-style="italic">p</text>
<text x="195" y="52" font-size="14" text-anchor="middle">6 cm</text>
</svg>"""

SVG11 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 330" font-family="sans-serif">
<text x="110" y="30" font-size="16" font-weight="bold" text-anchor="middle">A</text>
<rect x="60" y="100" width="100" height="180" fill="#bdbdbd"/>
<rect x="60" y="40" width="100" height="240" fill="none" stroke="#000" stroke-width="2"/>
<text x="110" y="300" font-size="13" text-anchor="middle">60% LOUH</text>
<text x="110" y="316" font-size="12" text-anchor="middle">750 ml</text>
<text x="260" y="30" font-size="16" font-weight="bold" text-anchor="middle">B</text>
<rect x="210" y="160" width="100" height="120" fill="#dcdcdc"/>
<rect x="210" y="40" width="100" height="240" fill="none" stroke="#000" stroke-width="2"/>
<text x="260" y="300" font-size="13" text-anchor="middle">20% LOUH</text>
<text x="260" y="316" font-size="12" text-anchor="middle">500 ml</text>
<text x="410" y="30" font-size="16" font-weight="bold" text-anchor="middle">C</text>
<rect x="360" y="40" width="100" height="240" fill="#eeeeee"/>
<rect x="360" y="40" width="100" height="240" fill="none" stroke="#000" stroke-width="2"/>
<text x="410" y="300" font-size="12" text-anchor="middle">DESTILOVANÁ</text>
<text x="410" y="316" font-size="12" text-anchor="middle">VODA (1 l)</text>
</svg>"""

SVG13 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 320" font-family="sans-serif">
<polygon points="155,37 283,130 234,281 76,281 27,130" fill="#d9d9d9" stroke="#000" stroke-width="2"/>
<polygon points="283,130 491,281 234,281" fill="#ffffff" stroke="#000" stroke-width="2"/>
<text x="466" y="274" font-size="20" text-anchor="middle">?</text>
</svg>"""

SVG14 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 380 360" font-family="sans-serif">
<polygon points="40,330 160,330 160,270 220,270 220,330 340,330 340,210 280,210 280,150 340,150 340,30 220,30 220,90 160,90 160,30 40,30 40,150 100,150 100,210 40,210" fill="none" stroke="#000" stroke-width="2.5"/>
<polygon points="100,270 280,270 280,90 100,90" fill="none" stroke="#555" stroke-width="1" stroke-dasharray="5 4"/>
<line x1="40" y1="330" x2="160" y2="210" stroke="#555" stroke-width="1" stroke-dasharray="4 4"/>
<line x1="40" y1="210" x2="160" y2="330" stroke="#555" stroke-width="1" stroke-dasharray="4 4"/>
<line x1="220" y1="330" x2="340" y2="210" stroke="#555" stroke-width="1" stroke-dasharray="4 4"/>
<line x1="220" y1="210" x2="340" y2="330" stroke="#555" stroke-width="1" stroke-dasharray="4 4"/>
<line x1="220" y1="150" x2="340" y2="30" stroke="#555" stroke-width="1" stroke-dasharray="4 4"/>
<line x1="220" y1="30" x2="340" y2="150" stroke="#555" stroke-width="1" stroke-dasharray="4 4"/>
<line x1="40" y1="150" x2="160" y2="30" stroke="#555" stroke-width="1" stroke-dasharray="4 4"/>
<line x1="40" y1="30" x2="160" y2="150" stroke="#555" stroke-width="1" stroke-dasharray="4 4"/>
</svg>"""

SVG16 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 180" font-family="sans-serif" font-size="14">
<rect x="90" y="10" width="400" height="160" fill="none" stroke="#000" stroke-width="1.5"/>
<line x1="90" y1="60" x2="490" y2="60" stroke="#000" stroke-width="1"/>
<line x1="90" y1="115" x2="490" y2="115" stroke="#000" stroke-width="1"/>
<line x1="160" y1="10" x2="160" y2="170" stroke="#000" stroke-width="1"/>
<line x1="230" y1="10" x2="230" y2="170" stroke="#000" stroke-width="1"/>
<line x1="300" y1="10" x2="300" y2="170" stroke="#000" stroke-width="1"/>
<line x1="405" y1="10" x2="405" y2="170" stroke="#000" stroke-width="1"/>
<text x="125" y="42" text-anchor="middle">rok</text>
<text x="195" y="42" text-anchor="middle">měsíc</text>
<text x="265" y="42" text-anchor="middle">den</text>
<text x="352" y="34" text-anchor="middle">Pořadové</text>
<text x="352" y="50" text-anchor="middle">číslo</text>
<text x="447" y="34" text-anchor="middle">Kontrolní</text>
<text x="447" y="50" text-anchor="middle">číslice</text>
<text x="45" y="92" text-anchor="middle" font-weight="bold">PETR</text>
<text x="125" y="92" text-anchor="middle">02</text>
<text x="195" y="92" text-anchor="middle">11</text>
<text x="265" y="92" text-anchor="middle">19</text>
<text x="352" y="92" text-anchor="middle">102</text>
<text x="447" y="92" text-anchor="middle">4</text>
<text x="45" y="147" text-anchor="middle" font-weight="bold">LUCIE</text>
<text x="125" y="147" text-anchor="middle">02</text>
<text x="195" y="147" text-anchor="middle">61</text>
<text x="265" y="147" text-anchor="middle">19</text>
<text x="352" y="147" text-anchor="middle">102</text>
<text x="447" y="147" text-anchor="middle">9</text>
</svg>"""

# ---------- Úlohy ----------

CODES_BASE = ['zs2', 'r9']

PROBLEMS = [
    # ---- úloha 1 (jedna otázka) ----
    {
        'name': 'Zelený J1 – přírůstek obsahu obdélníku',
        'zad': ['Naznačte, o kolik cm² ($x$) zvětšíte obsah obdélníku, jestliže jeho strany o délkách $a$ cm a $b$ cm zvětšíte o $2$ cm.'],
        'opts': None, 'ln': 2,
        'sol': ['Původní obsah je $a\\cdot b$. Nový obsah je $(a+2)(b+2)=ab+2a+2b+4$. Přírůstek $x=(a+2)(b+2)-ab=2a+2b+4$.'],
        'ans': 'o $2a+2b+4$ cm²',
        'pts': 2, 'mins': 3, 'diff': '2',
        'codes': CODES_BASE + ['vyrazy', 'modelovani', 'slovni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 2 (2.1, 2.2 izolované -> 2 samostatné úlohy) ----
    {
        'name': 'Zelený J2.1 – desetinné dělení',
        'zad': ['Vypočtěte: $5{,}2:4+0{,}13:0{,}1-0{,}52:0{,}2=$'],
        'opts': None, 'ln': 2,
        'sol': ['$5{,}2:4=1{,}3$; $0{,}13:0{,}1=1{,}3$; $0{,}52:0{,}2=2{,}6$. Tedy $1{,}3+1{,}3-2{,}6=0$.'],
        'ans': '$0$',
        'pts': 1, 'mins': 2, 'diff': '1',
        'codes': CODES_BASE + ['desetinna-cisla', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    {
        'name': 'Zelený J2.2 – odmocnina a mocnina',
        'zad': ['Vypočtěte: $(\\sqrt{36}:0{,}2-5^2)\\cdot\\frac{1}{5}=$'],
        'opts': None, 'ln': 2,
        'sol': ['$\\sqrt{36}=6$; $6:0{,}2=30$; $5^2=25$. Tedy $(30-25)\\cdot\\frac{1}{5}=5\\cdot\\frac{1}{5}=1$.'],
        'ans': '$1$',
        'pts': 1, 'mins': 2, 'diff': '2',
        'codes': CODES_BASE + ['mocniny-odmocniny', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 3 (3.1, 3.2 izolované -> 2 samostatné úlohy) ----
    {
        'name': 'Zelený J3.1 – zlomky se smíšeným číslem',
        'zad': ['Vypočtěte a výsledek zapište jako smíšené číslo: $\\frac{4}{5}:1\\frac{1}{5}-\\frac{2}{3}:\\frac{5}{18}=$'],
        'opts': None, 'ln': 2,
        'sol': ['$\\frac{4}{5}:\\frac{6}{5}=\\frac{4}{6}=\\frac{2}{3}$; $\\frac{2}{3}:\\frac{5}{18}=\\frac{2}{3}\\cdot\\frac{18}{5}=\\frac{12}{5}$. Tedy $\\frac{2}{3}-\\frac{12}{5}=\\frac{10-36}{15}=-\\frac{26}{15}=-1\\frac{11}{15}$.'],
        'ans': '$-1\\frac{11}{15}$',
        'pts': 1, 'mins': 3, 'diff': '2',
        'codes': CODES_BASE + ['zlomky', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    {
        'name': 'Zelený J3.2 – složený zlomek',
        'zad': ['Vypočtěte a výsledek zapište jako smíšené číslo: $\\frac{\\frac{2}{3}-\\frac{4}{5}}{0{,}6+\\frac{6}{12}}-\\frac{10}{11}=$'],
        'opts': None, 'ln': 2,
        'sol': ['Čitatel: $\\frac{2}{3}-\\frac{4}{5}=-\\frac{2}{15}$. Jmenovatel: $0{,}6+\\frac{6}{12}=\\frac{11}{10}$. Podíl: $-\\frac{2}{15}:\\frac{11}{10}=-\\frac{2}{15}\\cdot\\frac{10}{11}=-\\frac{4}{33}$. Nakonec $-\\frac{4}{33}-\\frac{10}{11}=-\\frac{4}{33}-\\frac{30}{33}=-\\frac{34}{33}=-1\\frac{1}{33}$.'],
        'ans': '$-1\\frac{1}{33}$',
        'pts': 1, 'mins': 4, 'diff': '3',
        'codes': CODES_BASE + ['zlomky', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 4 (4.1, 4.2 izolované -> 2 samostatné úlohy) ----
    {
        'name': 'Zelený J4.1 – roznásobení výrazu',
        'zad': ['Zjednodušte výraz: $2y\\cdot(3-4y)+(1-2y)^2\\cdot 2=$'],
        'opts': None, 'ln': 2,
        'sol': ['$2y(3-4y)=6y-8y^2$; $(1-2y)^2=1-4y+4y^2$, po vynásobení dvěma $2-8y+8y^2$. Součet: $6y-8y^2+2-8y+8y^2=2-2y$.'],
        'ans': '$2-2y$',
        'pts': 2, 'mins': 4, 'diff': '3',
        'codes': CODES_BASE + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    {
        'name': 'Zelený J4.2 – krácení lomeného výrazu',
        'zad': ['Zjednodušte výraz: $\\frac{2a^2-18}{27-18a+3a^2}=$'],
        'opts': None, 'ln': 2,
        'sol': ['Čitatel $2a^2-18=2(a-3)(a+3)$. Jmenovatel $3a^2-18a+27=3(a-3)^2$. Zlomek $\\frac{2(a-3)(a+3)}{3(a-3)^2}=\\frac{2}{3}\\cdot\\frac{a+3}{a-3}$ (pro $a\\neq 3$).'],
        'ans': '$\\frac{2}{3}\\cdot\\frac{a+3}{a-3}$',
        'pts': 2, 'mins': 4, 'diff': '3',
        'codes': CODES_BASE + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 5 (5.1, 5.2 izolované -> 2 samostatné úlohy) ----
    {
        'name': 'Zelený J5.1 – lineární rovnice se zlomky',
        'zad': ['Řešte rovnici: $\\frac{x-3}{4}-\\frac{x+1}{2}=\\frac{x}{2}-4$'],
        'opts': None, 'ln': 2,
        'sol': ['Vynásobíme $4$: $(x-3)-2(x+1)=2x-16$, tj. $-x-5=2x-16$, odtud $11=3x$, $x=\\frac{11}{3}$.'],
        'ans': '$x=\\frac{11}{3}$',
        'pts': 2, 'mins': 4, 'diff': '3',
        'codes': CODES_BASE + ['linearni-rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    {
        'name': 'Zelený J5.2 – rovnice s druhými mocninami',
        'zad': ['Řešte rovnici: $(d+2)\\cdot(d-3)+1=(d+1)^2$'],
        'opts': None, 'ln': 2,
        'sol': ['$d^2-d-6+1=d^2+2d+1$, tj. $-d-5=2d+1$, odtud $-6=3d$, $d=-2$.'],
        'ans': '$d=-2$',
        'pts': 2, 'mins': 3, 'diff': '2',
        'codes': CODES_BASE + ['linearni-rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 6 (výchozí text; 6.1+6.2 společný kontext -> jedna úloha) ----
    {
        'name': 'Zelený J6 – Vašek cestou do školy',
        'zad': [
            'Vašek si dnes cestou do školy přispíšil. Šel o čtvrtinu rychleji než obvykle, a byl také ve škole o $6$ minut dříve než obvykle. Zato zpátky se loudal. Odcházel v půl druhé, šel ve srovnání s ránem poloviční rychlostí a ještě si cestu proti ránu o čtvrtinu prodloužil přes les.',
            '6.1 Vypočtěte, kolik minut dnes Vaškovi trvala cesta do školy.',
            '6.2 V kolik hodin dorazil Vašek ze školy domů?',
        ],
        'opts': None, 'ln': 4,
        'sol': [
            '6.1 Obvyklá rychlost $v$, obvyklý čas $t$. Dnes rychlost $\\frac{5}{4}v$, čas $\\frac{4}{5}t$. Úspora $t-\\frac{4}{5}t=\\frac{1}{5}t=6$ min, tedy obvyklý čas $t=30$ min a dnešní cesta trvala $\\frac{4}{5}\\cdot 30=24$ minut.',
            '6.2 Ranní dnešní cesta trvala $24$ min (vzdálenost $d$, rychlost $s$, takže $\\frac{d}{s}=24$). Zpět jde poloviční rychlostí $\\frac{s}{2}$ po trase o čtvrtinu delší, tj. $\\frac{5}{4}d$. Čas $=\\frac{\\frac{5}{4}d}{\\frac{s}{2}}=\\frac{5}{2}\\cdot\\frac{d}{s}=\\frac{5}{2}\\cdot 24=60$ min. Odešel v $13{:}30$, doma byl v $14{:}30$ (v půl třetí).',
        ],
        'ans': '6.1: $24$ minut; 6.2: v půl třetí (ve $14{:}30$)',
        'pts': 4, 'mins': 8, 'diff': '4',
        'codes': CODES_BASE + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
    },
    # ---- úloha 7 (7.1,7.2,7.3 izolované "Vypočtěte" -> 3 samostatné úlohy) ----
    {
        'name': 'Zelený J7.1 – zpožďování hodinek',
        'zad': ['O kolik sekund za hodinu se zpožďují moje hodinky, jestliže jsem přesně týden po jejich seřízení zjistil, že proti přesnému času ukazují o $5$ minut a $36$ sekund méně?'],
        'opts': None, 'ln': 2,
        'sol': ['$5$ min $36$ s $=336$ s za týden. Týden má $7\\cdot 24=168$ hodin. $336:168=2$ s za hodinu.'],
        'ans': '$2$ s za hodinu',
        'pts': 1, 'mins': 3, 'diff': '2',
        'codes': CODES_BASE + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
    },
    {
        'name': 'Zelený J7.2 – naplnění bazénu',
        'zad': ['Za jak dlouho se naplní bazén vodou přitékající trubkou rychlostí $2$ litry za sekundu, jestliže objem bazénu je $20$ m³ a nyní je naplněn ze $40\\,\\%$? Dobu uveďte v hodinách a minutách (např. $3.40$ h).'],
        'opts': None, 'ln': 2,
        'sol': ['Zbývá naplnit $60\\,\\%$ z $20$ m³, tj. $12$ m³ $=12\\,000$ litrů. Čas $=12\\,000:2=6\\,000$ s $=100$ min $=1$ h $40$ min.'],
        'ans': '$1.40$ h',
        'pts': 1, 'mins': 3, 'diff': '2',
        'codes': CODES_BASE + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
    },
    {
        'name': 'Zelený J7.3 – množství deště na zahradu',
        'zad': ['Kolik hl vody napadlo včera na zahradu o ploše půl hektaru, jestliže se nám ve válcovitém zásobníku stojícím na zahradě za včerejšek zvýšila hladina vody o $2$ cm?'],
        'opts': None, 'ln': 2,
        'sol': ['Déšť zvedl hladinu všude stejně o $2$ cm $=0{,}02$ m. Plocha $0{,}5$ ha $=5\\,000$ m². Objem $=5\\,000\\cdot 0{,}02=100$ m³ $=1\\,000$ hl.'],
        'ans': '$1\\,000$ hl',
        'pts': 1, 'mins': 3, 'diff': '3',
        'codes': CODES_BASE + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
    },
    # ---- úloha 8 (výchozí text + obrázek; 8.1+8.2 společný kontext) ----
    {
        'name': 'Zelený J8 – Beranovi a Kozlovi na trase',
        'zad': [
            'Na startu turistické etapy se sešli Beranovi a Kozlovi. Rozhodli se, že vyrazí do cíle jinou cestou podle situačního plánku na obrázku. Odstartovali ve stejný okamžik. Rychlost chůze Beranových byla o třetinu vyšší než Kozlových. Čtverec má rozměry $10$ km $\\times$ $10$ km; Beranovi jdou spodní a pravou stranou, Kozlovi levou a horní stranou.',
            '8.1 Vypočtěte, jaká je vzdálenost mezi Beranovými a Kozlovými v okamžiku, kdy Beranovi ušli prvních $8$ km.',
            '8.2 Vypočtěte, jaká bude vzdálenost mezi Beranovými a Kozlovými po dvou hodinách chůze, víme-li, že Beranovi jdou rychlostí $8$ km/h.',
        ],
        'opts': None, 'ln': 4,
        'svg': SVG8, 'fn': 'trasa-ctverec.svg',
        'alt': 'Čtvercová trasa 10 km krát 10 km; Beranovi jdou spodní a pravou stranou, Kozlovi levou a horní stranou, čárkovaná úsečka spojuje jejich okamžité polohy.',
        'cap': 'Situační plánek trasy',
        'sol': [
            '8.1 Beranovi mají o třetinu vyšší rychlost, takže Kozlovi ujdou $\\frac{3}{4}$ dráhy Beranových. Když Beranovi ušli $8$ km (po spodní straně), Kozlovi ušli $\\frac{3}{4}\\cdot 8=6$ km (po levé straně). Vzdálenost $=\\sqrt{8^2+6^2}=\\sqrt{100}=10$ km.',
            '8.2 Za $2$ h ujdou Beranovi $16$ km: $10$ km spodní stranou a $6$ km nahoru po pravé straně. Kozlovi ujdou $\\frac{3}{4}\\cdot 16=12$ km: $10$ km levou stranou a $2$ km po horní straně. Vzdálenost $=\\sqrt{8^2+4^2}=\\sqrt{80}\\approx$ necelých $9$ km.',
        ],
        'ans': '8.1: $10$ km; 8.2: $\\sqrt{80}\\approx 8{,}9$ km (necelých $9$ km)',
        'pts': 4, 'mins': 8, 'diff': '3',
        'codes': CODES_BASE + ['planimetrie', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
    },
    # ---- úloha 9 (konstrukce – množina bodů) ----
    {
        'name': 'Zelený J9 – množina bodů k přímkám p, q',
        'zad': [
            'V rovině leží přímky $p$ a $q$, které se protínají v bodě $S$.',
            'Vyznačte množinu bodů, které jsou od přímky $q$ vzdáleny třikrát více než od přímky $p$.',
        ],
        'opts': None, 'ln': 0,
        'svg': SVG9, 'fn': 'primky-pq.svg',
        'alt': 'Dvě různoběžné přímky p a q protínající se v bodě S.',
        'cap': 'Výchozí obrázek k úloze 9',
        'sol': ['Hledaná množina leží na přímkách procházejících bodem $S$ (průsečík $p$ a $q$), protože pro každý bod takové přímky je poměr vzdáleností od $p$ a $q$ stálý. Sestrojíme bod, jehož vzdálenost od $p$ je $1$ díl a od $q$ jsou $3$ díly (např. průsečík rovnoběžky s $p$ ve vzdálenosti $1$ a rovnoběžky s $q$ ve vzdálenosti $3$), a spojíme jej s $S$. Řešením jsou dvě přímky procházející $S$ (viz obrázek v klíči).'],
        'ans': 'Dvě přímky procházející bodem $S$; jejich body mají od $q$ třikrát větší vzdálenost než od $p$ (viz konstrukce v klíči).',
        'pts': 2, 'mins': 6, 'diff': '3',
        'codes': CODES_BASE + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 10 (konstrukce – čtyřúhelník v kružnici) ----
    {
        'name': 'Zelený J10 – čtyřúhelník dělící kružnici 4:3:3:2',
        'zad': [
            'Na přímce $p$ leží body $A$ a $S$ vzdálené od sebe $6$ cm.',
            'Sestrojte čtyřúhelník $ABCD$ tak, aby jeho vrcholy rozdělily kružnici se středem $S$ opsanou čtyřúhelníku $ABCD$ na $4$ části, jejichž délky budou v poměru $4:3:3:2$.',
        ],
        'opts': None, 'ln': 0,
        'svg': SVG10, 'fn': 'primka-AS.svg',
        'alt': 'Přímka p s vyznačenými body A a S ve vzdálenosti 6 cm.',
        'cap': 'Výchozí obrázek k úloze 10',
        'sol': ['Kružnice má střed $S$ a poloměr $|SA|=6$ cm (bod $A$ na ní leží). Poměr oblouků $4:3:3:2$ dává dohromady $12$ dílů; jeden díl odpovídá středovému úhlu $\\frac{360^\\circ}{12}=30^\\circ$. Oblouky mají středové úhly $120^\\circ$, $90^\\circ$, $90^\\circ$ a $60^\\circ$. Od bodu $A$ postupně naneseme tyto úhly a získáme vrcholy $B$, $C$, $D$ (viz obrázek v klíči).'],
        'ans': 'Kružnice se středem $S$ a poloměrem $6$ cm; vrcholy dělí kružnici na oblouky se středovými úhly $120^\\circ$, $90^\\circ$, $90^\\circ$, $60^\\circ$ (poměr $4:3:3:2$) — viz konstrukce v klíči.',
        'pts': 2, 'mins': 6, 'diff': '4',
        'codes': CODES_BASE + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 11 (výchozí text + obrázek; 11.1–11.3 společný kontext) ----
    {
        'name': 'Zelený J11 – roztoky louhu (Ano/Ne)',
        'zad': [
            'V laboratoři máme k dispozici dvě litrové nádoby s louhem a litrovou nádobu C plnou destilované vody. V nádobě A je $750$ ml $60\\,\\%$ roztoku louhu, v nádobě B půl litru $20\\,\\%$ roztoku louhu.',
            'Rozhodněte o každém z následujících tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).',
            '11.1 Přelijeme-li maximální možný objem louhu z nádoby A do nádoby B a po promíchání přelijeme maximální možný objem louhu z nádoby B do nádoby A, bude v nádobě A $1$ litr $45\\,\\%$ roztoku louhu.',
            '11.2 Dolijeme-li nádobu B destilovanou vodou a po promíchání přelijeme z nádoby B do nádoby A maximální možný objem louhu, bude v nádobě A $1$ litr louhu o koncentraci $42{,}5\\,\\%$.',
            '11.3 Přelijeme-li z nádoby A do nádoby B $250$ ml roztoku a zbytek nádoby B doplníme destilovanou vodou, bude v nádobě B $1$ litr $25\\,\\%$ roztoku louhu.',
        ],
        'opts': None, 'ln': 0,
        'svg': SVG11, 'fn': 'nadoby-ABC.svg',
        'alt': 'Tři nádoby: A se 750 ml 60% louhu, B s 500 ml 20% louhu, C plná litrová nádoba destilované vody.',
        'cap': 'Výchozí nádoby A, B, C',
        'sol': [
            '11.1 Do B (volných $500$ ml) přelijeme $500$ ml z A ($60\\,\\%$): B má $1000$ ml a $100+300=400$ ml louhu, tj. $40\\,\\%$. Zpět do A (volných $750$ ml) přelijeme $750$ ml z B: A má $1000$ ml a $150+300=450$ ml louhu, tj. $45\\,\\%$. Pravda (A).',
            '11.2 Doplněním B vodou vznikne $1000$ ml o koncentraci $\\frac{100}{1000}=10\\,\\%$. Do A (volných $250$ ml) přelijeme $250$ ml: A má $1000$ ml a $450+25=475$ ml louhu, tj. $47{,}5\\,\\%$, nikoli $42{,}5\\,\\%$. Nepravda (N).',
            '11.3 Do B přelijeme $250$ ml z A ($60\\,\\%$): B má $750$ ml a $100+150=250$ ml louhu. Doplněním vodou na $1000$ ml je koncentrace $\\frac{250}{1000}=25\\,\\%$. Pravda (A).',
        ],
        'ans': '11.1: Ano; 11.2: Ne; 11.3: Ano',
        'pts': 3, 'mins': 8, 'diff': '4',
        'codes': CODES_BASE + ['procenta', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
    },
    # ---- úloha 12 (výběr z možností; výchozí text bez obrázku) ----
    {
        'name': 'Zelený J12 – hmotnost trubek plynovodu',
        'zad': [
            'Plynovod tvoří ocelové trubky o vnějším průměru $1$ metr. Stěny trubek jsou silné $1$ cm. Jeden m³ oceli váží $8$ tun. $\\pi=3{,}14$.',
            'Jaká je hmotnost trubek tvořících $1$ km dlouhý plynovod? Výsledek uveďte v tunách zaokrouhlených na jednotky.',
        ],
        'opts': ['A) $25$ tun', 'B) $249$ tun', 'C) $251$ tun', 'D) $2512$ tun', 'E) jiný výsledek'],
        'ln': 0,
        'sol': ['Vnější poloměr $R=0{,}5$ m, vnitřní $r=0{,}49$ m. Obsah mezikruží $S=\\pi(R^2-r^2)=3{,}14\\cdot(0{,}25-0{,}2401)=3{,}14\\cdot 0{,}0099\\approx 0{,}0311$ m². Objem oceli na $1000$ m: $V\\approx 31{,}1$ m³. Hmotnost $\\approx 31{,}1\\cdot 8\\approx 249$ tun.'],
        'ans': 'B) $249$ tun',
        'pts': 2, 'mins': 5, 'diff': '3',
        'codes': CODES_BASE + ['stereometrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
    },
    # ---- úloha 13 (výběr z možností + obrázek) ----
    {
        'name': 'Zelený J13 – úhel u pětiúhelníku a trojúhelníku',
        'zad': [
            'Na obrázku je útvar složený z pravidelného pětiúhelníku a trojúhelníku. Přitom platí, že součet vnitřních úhlů jakéhokoli $n$-úhelníku $=(n-2)\\cdot 180^\\circ$.',
            'Jak velký je úhel na obrázku označený symbolem „?"?',
        ],
        'opts': ['A) $18^\\circ$', 'B) $26^\\circ$', 'C) $36^\\circ$', 'D) $40^\\circ$', 'E) jiný výsledek'],
        'ln': 0,
        'svg': SVG13, 'fn': 'petiuhelnik-trojuhelnik.svg',
        'alt': 'Pravidelný pětiúhelník, k jeho pravé straně je připojen trojúhelník; u dolního pravého vrcholu trojúhelníku je úhel označený otazníkem.',
        'cap': 'Schematický nákres k úloze 13',
        'sol': ['Vnitřní úhel pravidelného pětiúhelníku je $\\frac{(5-2)\\cdot 180^\\circ}{5}=108^\\circ$. V trojúhelníku vznikají u společné strany dva úhly po $180^\\circ-108^\\circ=72^\\circ$. Hledaný úhel $?=180^\\circ-72^\\circ-72^\\circ=36^\\circ$.'],
        'ans': 'C) $36^\\circ$',
        'pts': 2, 'mins': 5, 'diff': '3',
        'codes': CODES_BASE + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 14 (výběr z možností + obrázek) ----
    {
        'name': 'Zelený J14 – obvod útvaru z prolnutých čtverců',
        'zad': [
            'Na obrázku je silnou čarou vyznačený útvar utvořený prolnutím $4$ stejných malých čtverců a jednoho velkého. Vrcholy velkého čtverce jsou průsečíky úhlopříček malých čtverců. Obsah velkého čtverce je $36$ cm², obsah jednoho každého malého čtverce je $16$ cm².',
            'Jaký je obvod útvaru ohraničeného silnou čarou?',
        ],
        'opts': ['A) $48$ cm', 'B) $56$ cm', 'C) $60$ cm', 'D) $64$ cm', 'E) jiný výsledek'],
        'ln': 0,
        'svg': SVG14, 'fn': 'ctverce-prolnuti.svg',
        'alt': 'Útvar z prolnutí čtyř malých čtverců a jednoho velkého; silná čára ohraničuje jejich sjednocení, čárkovaně jsou úhlopříčky malých čtverců a velký čtverec.',
        'cap': 'Prolnutí čtyř malých a jednoho velkého čtverce',
        'sol': ['Malý čtverec má stranu $\\sqrt{16}=4$ cm, velký stranu $\\sqrt{36}=6$ cm. Střediska malých čtverců (průsečíky úhlopříček) jsou vrcholy velkého čtverce, jsou tedy $6$ cm od sebe. Obvod silné čáry se skládá z osmi úseků délky $4$ cm a dvanácti úseků délky $2$ cm: $8\\cdot 4+12\\cdot 2=32+24=56$ cm.'],
        'ans': 'B) $56$ cm',
        'pts': 2, 'mins': 5, 'diff': '3',
        'codes': CODES_BASE + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 15 (přiřazování 15.1–15.3 -> A–F; společná nabídka) ----
    {
        'name': 'Zelený J15 – slovní úlohy (přiřazování)',
        'zad': [
            'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).',
            '15.1 Ve srovnání s letoškem jsme vloni prodávali metrák brambor o $200$ korun levněji. Proto jsou letos brambory o sedminu dražší než vloni. Za kolik korun jsme prodávali vloni $1$ kg brambor?',
            '15.2 Prázdnou nádrž jsme schopni naplnit jednou hadicí za $60$ minut. Naopak plnou nádrž jsme schopni vypustit za $30$ minut. Za kolik minut se naplní prázdná nádrž, jestli ji budeme souběžně plnit $6$ stejnými hadicemi a výpusť nádrže přitom bude zcela otevřená?',
            '15.3 Pepa na „fichtlu" a Vašek na kole si dali závod. Vyrazili ve stejný okamžik. Pepa dorazil do cíle za hodinu. Za kolik minut po Pepovi dorazil do cíle Vašek, který jel o třetinu pomaleji?',
        ],
        'opts': ['A) $12$', 'B) $14$', 'C) $15$', 'D) $18$', 'E) $20$', 'F) jiný výsledek'],
        'ln': 0,
        'sol': [
            '15.1 Letos $=$ vloni $+200$ Kč za metrák a zároveň letos $=\\frac{8}{7}\\cdot$ vloni. Tedy $\\frac{1}{7}\\cdot$ vloni $=200$, vloni $=1400$ Kč za metrák $=14$ Kč za $1$ kg → B.',
            '15.2 Přítok $6$ hadicemi je $\\frac{6}{60}=\\frac{1}{10}$ nádrže za minutu, výpusť $\\frac{1}{30}$ za minutu. Netto $\\frac{1}{10}-\\frac{1}{30}=\\frac{1}{15}$ za minutu, naplní se za $15$ min → C.',
            '15.3 Vašek jede $\\frac{2}{3}$ rychlostí Pepy, čas je nepřímo úměrný: $60\\cdot\\frac{3}{2}=90$ min. Po Pepovi dorazil o $90-60=30$ min později; $30$ není mezi A–E → F.',
        ],
        'ans': '15.1: B ($14$); 15.2: C ($15$); 15.3: F (jiný výsledek — $30$ minut)',
        'pts': 6, 'mins': 9, 'diff': '4',
        'codes': CODES_BASE + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
    },
    # ---- úloha 16 (výchozí text + tabulka; 16.1–16.3 společný kontext) ----
    {
        'name': 'Zelený J16 – rodné číslo (dělitelnost 11)',
        'zad': [
            'Rodné číslo má přiděleno každý občan ČR. Má deset číslic; prvních šest (před lomítkem) vyjadřuje datum narození a pohlaví (u žen se k číslu měsíce přičítá $50$), za lomítkem je třímístné pořadové číslo a poslední, desátá číslice je kontrolní. Kontrolní číslice doplňuje číslo tak, aby rozdíl mezi součtem číslic na lichých pozicích a součtem číslic na sudých pozicích byl dělitelný $11$ (tj. celé rodné číslo je dělitelné $11$). Na obrázku je příklad rodného čísla chlapce (Petr) a dívky (Lucie) narozených 19. listopadu 2002.',
            '16.1 Nahraďte v následujících 10místných kódech symboly △ a ▽ číslicemi tak, aby šlo o správné rodné číslo: Václav 62△▽19/1162; Anežka 84△611/003▽; Jolana 0052△0/▽215.',
            '16.2 Rozhodněte, které z následujících kódů nemohou být rodným číslem dané osoby, a uveďte proč: Igor 886212/1136; Marie 005231/0016; Honza 121212/1218.',
            '16.3 Vypočtěte, o kolik dnů je Petr mladší než Klára, jestliže Klára uvedla rodné číslo 045331/2134 a Petr 040611/0033. Ale mohli při tom udělat chybu.',
        ],
        'opts': None, 'ln': 4,
        'svg': SVG16, 'fn': 'rodne-cislo.svg',
        'alt': 'Tabulka rodných čísel Petra (021119/1024) a Lucie (026119/1029) s popisky rok, měsíc, den, pořadové číslo, kontrolní číslice.',
        'cap': 'Příklad rodného čísla chlapce a dívky',
        'sol': [
            '16.1 Václav: rozdíl součtů je △$-$▽, dělitelný $11$ jen pro △$=$▽; měsíc △▽ musí být $01$–$12$, tedy $11$: △$=1$, ▽$=1$ (621119/1162). Anežka (žena): měsíc △$6$ musí být $51$–$62$, tj. $56$ (△$=5$); z dělitelnosti pak ▽$=6$ (845611/0036). Jolana (žena): rok $00$, měsíc $52$ (únor), den △$0$ je $10$ nebo $20$; z dělitelnosti △$+$▽$=3$: △$=1$,▽$=2$ nebo △$=2$,▽$=1$.',
            '16.2 Igor: druhé dvojčíslí (měsíc) je $62$; pro muže nesmí být větší než $12$ — nemůže. Marie: měsíc $52$ (únor), den $31$ — $31$. únor neexistuje, nemůže. Honza: $121212/1218$ je platné (dělitelné $11$, datum existuje) — může.',
            '16.3 Rodné číslo Petra ($0406110033$) není dělitelné $11$ (rozdíl součtů je $-10$), je tedy chybné, a proto rozdíl věku nelze spolehlivě vypočítat.',
        ],
        'ans': '16.1: Václav △=1, ▽=1; Anežka △=5, ▽=6; Jolana △=1, ▽=2 nebo △=2, ▽=1. 16.2: Igor nemůže (měsíc nesmí být větší než 12), Marie nemůže (31. únor neexistuje), Honza může. 16.3: nelze vypočítat, protože rodné číslo Petra je chybné.',
        'pts': 6, 'mins': 10, 'diff': '4',
        'codes': CODES_BASE + ['aritmetika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
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
    written = gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-zeleny-testJ'))
    total = 0
    for path, sz, k in written:
        total += k
        flag = 'OK' if sz < 9000 else 'PŘES 9KB!'
        print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{flag}]')
    print('Celkem úloh:', total)
