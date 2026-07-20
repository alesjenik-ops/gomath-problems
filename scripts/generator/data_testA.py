# -*- coding: utf-8 -*-
# Data: Cvičný TEST A (úlohy 6–16). Zdroj: Matematika - Zelený.
# Pozn.: úlohy 1–5 nejsou v repu nafoceny. SVG bez ' a \ (viz návod §9).

# ---------- SVG obrázky (bez apostrofů a zpětných lomítek) ----------

SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 400" font-family="sans-serif">
<text x="250" y="30" font-size="18" text-anchor="middle">400 metrů</text>
<line x1="70" y1="45" x2="430" y2="45" stroke="#444" stroke-width="1"/>
<polygon points="70,45 78,41 78,49" fill="#444"/><polygon points="430,45 422,41 422,49" fill="#444"/>
<text x="30" y="205" font-size="18" text-anchor="middle" transform="rotate(-90 30 205)">300 metrů</text>
<line x1="45" y1="70" x2="45" y2="340" stroke="#444" stroke-width="1"/>
<polygon points="45,70 41,78 49,78" fill="#444"/><polygon points="45,340 41,332 49,332" fill="#444"/>
<rect x="70" y="70" width="360" height="270" fill="#e9efe6" stroke="#000" stroke-width="2.5"/>
<line x1="70" y1="70" x2="430" y2="340" stroke="#000" stroke-width="2" stroke-dasharray="3 6"/>
<text x="250" y="212" font-size="22" text-anchor="middle" font-style="italic">?</text>
<text x="250" y="330" font-size="16" text-anchor="middle" fill="#333">trávník</text>
<text x="360" y="250" font-size="15" text-anchor="middle" fill="#333">chodník</text>
</svg>"""

SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 200" font-family="sans-serif">
<line x1="40" y1="140" x2="380" y2="140" stroke="#000" stroke-width="2.5"/>
<text x="395" y="145" font-size="18" font-style="italic">p</text>
<line x1="210" y1="80" x2="210" y2="140" stroke="#000" stroke-width="1" stroke-dasharray="3 4"/>
<text x="222" y="115" font-size="15">2 cm</text>
<text x="210" y="72" font-size="18" text-anchor="middle" font-weight="bold">A</text>
<text x="210" y="86" font-size="18" text-anchor="middle">×</text>
</svg>"""

SVG10 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 380" font-family="sans-serif">
<polygon points="150,60 330,175 215,320 90,255" fill="none" stroke="#000" stroke-width="2.5"/>
<text x="142" y="52" font-size="18" font-weight="bold">D</text>
<text x="342" y="178" font-size="18" font-weight="bold">C</text>
<text x="220" y="342" font-size="18" font-weight="bold">B</text>
<text x="72" y="255" font-size="18" font-weight="bold">A</text>
<text x="222" y="262" font-size="18" font-weight="bold">S</text>
<text x="235" y="266" font-size="16">×</text>
</svg>"""

SVG11 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 470" font-family="sans-serif">
<circle cx="190" cy="195" r="150" fill="#3a3a3a" fill-opacity="0.85" stroke="#000"/>
<circle cx="350" cy="195" r="150" fill="#ffffff" fill-opacity="0" stroke="#000"/>
<circle cx="270" cy="320" r="150" fill="#000000" fill-opacity="0" stroke="#000"/>
<text x="150" y="60" font-size="20" font-weight="bold">SJEZDOVKY</text>
<text x="405" y="60" font-size="20" font-weight="bold">BĚŽKY</text>
<text x="205" y="460" font-size="20" font-weight="bold">SNOWBOARD</text>
<text x="135" y="185" font-size="22" fill="#fff" text-anchor="middle">27</text>
<text x="270" y="150" font-size="22" text-anchor="middle">6</text>
<text x="405" y="185" font-size="22" text-anchor="middle">3</text>
<text x="270" y="225" font-size="22" text-anchor="middle">3</text>
<text x="205" y="270" font-size="22" fill="#fff" text-anchor="middle">12</text>
<text x="335" y="270" font-size="22" text-anchor="middle">6</text>
<text x="270" y="360" font-size="22" text-anchor="middle">3</text>
</svg>"""

SVG13 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 430" font-family="sans-serif">
<circle cx="250" cy="235" r="175" fill="none" stroke="#777" stroke-width="1" stroke-dasharray="4 5"/>
<line x1="40" y1="235" x2="460" y2="235" stroke="#000" stroke-width="1.5" stroke-dasharray="6 6"/>
<polygon points="110,235 315,80 395,235 250,400" fill="none" stroke="#000" stroke-width="2.5"/>
<text x="128" y="222" font-size="19" font-weight="bold">165°</text>
<text x="355" y="220" font-size="20" font-style="italic">?</text>
<text x="402" y="262" font-size="19" font-weight="bold">138°</text>
</svg>"""

SVG14 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 370" font-family="sans-serif">
<rect x="40" y="40" width="280" height="280" fill="#c9c9c9" stroke="#000" stroke-width="2"/>
<polygon points="40,320 320,320 215,40 145,40" fill="#ffffff" stroke="#000" stroke-width="1.5"/>
<line x1="180" y1="40" x2="180" y2="320" stroke="#000" stroke-width="1.5" stroke-dasharray="7 6"/>
<text x="180" y="30" font-size="18" text-anchor="middle" font-style="italic">c</text>
<text x="180" y="345" font-size="18" text-anchor="middle" font-style="italic">a</text>
<text x="335" y="184" font-size="18" font-style="italic">a</text>
</svg>"""

# ---------- Úlohy ----------

CODES_BASE = ['zs2', 'r9']

PROBLEMS = [
    # ---- úloha 6 (výchozí text; 6.1+6.2 společný kontext -> jedna úloha) ----
    {
        'name': 'Zelený A6 – matematická olympiáda',
        'zad': [
            'V krajském kole matematické olympiády naše škola nedopadla nejhůř. Petr Mazánek z 8. A a ještě s jedním dalším účastníkem skončili na třetím sdíleném místě, a za sebou tak nechali čtyři pětiny soutěžících. Lepších než Petr bylo jen $15\\,\\%$ účastníků.',
            '6.1 Neznámý počet všech účastníků krajského kola matematické olympiády označte $x$ a sestavte rovnici pro jeho výpočet. Počet účastníků vypočtěte.',
            '6.2 Vypočtěte, kolik účastníků se umístilo lépe než Mazánek z 8. A.',
        ],
        'opts': None, 'ln': 4,
        'sol': [
            '6.1 Lepších je $15\\,\\%$, horších $\\frac{4}{5}=80\\,\\%$, na třetím místě jsou 2 účastníci. Rovnice: $x=0{,}15x+\\frac{4}{5}x+2$, odtud $0{,}05x=2$, tedy $x=40$.',
            '6.2 Lépe se umístilo $15\\,\\%$ ze $40$, tj. $6$ účastníků.',
        ],
        'ans': '6.1: $x=0{,}15x+\\frac{4}{5}x+2$, $x=40$; 6.2: $6$',
        'pts': 4, 'mins': 6, 'diff': '3',
        'codes': CODES_BASE + ['rovnice', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
    },
    # ---- úloha 7 (7.1,7.2,7.3 izolované "Vypočtěte" -> 3 samostatné úlohy) ----
    {
        'name': 'Zelený A7.1 – Dan na kole',
        'zad': ['Kolik km ujede Dan na kole za $2$ hodiny nepřetržité jízdy, pokud jeho průměrná rychlost dosahuje $5$ m/s?'],
        'opts': None, 'ln': 2,
        'sol': ['$5$ m/s $=18$ km/h. Za $2$ hodiny ujede $2\\cdot 18=36$ km.'],
        'ans': '$36$ km',
        'pts': 1, 'mins': 3, 'diff': '2',
        'codes': CODES_BASE + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'fyzika'],
    },
    {
        'name': 'Zelený A7.2 – lahve piva',
        'zad': ['Kolik půllitrových lahví piva lze naplnit z tanku o objemu $20$ m³, který je naplněn z jedné čtvrtiny?'],
        'opts': None, 'ln': 2,
        'sol': ['Naplněná část: $\\frac{1}{4}\\cdot 20 = 5$ m³ $=5000$ litrů. Půllitrových lahví: $5000:0{,}5=10\\,000$.'],
        'ans': '$10\\,000$ lahví',
        'pts': 1, 'mins': 3, 'diff': '2',
        'codes': CODES_BASE + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
    },
    {
        'name': 'Zelený A7.3 – uhlí kolečkem',
        'zad': [
            'Kolik km ujde Petr s kolečkem, než složí $42$ metráků uhlí, víme-li, že v průměru se na jedno kolečko vejde $40$ kg uhlí a otvor do uhelného sklepa je od hromady uhlí vzdálen $50$ m?',
        ],
        'opts': None, 'ln': 2,
        'sol': ['$42$ q $=4200$ kg $\\Rightarrow 4200:40=105$ koleček. Každé kolečko tam a zpět $2\\cdot 50=100$ m, celkem $105\\cdot 100=10\\,500$ m $=10{,}5$ km.'],
        'ans': '$10{,}5$ km',
        'pts': 1, 'mins': 4, 'diff': '3',
        'codes': CODES_BASE + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
    },
    # ---- úloha 8 (výchozí text + obrázek; 8.1+8.2 společný kontext) ----
    {
        'name': 'Zelený A8 – zkratka přes park',
        'zad': [
            'Na obrázku je vidět obdélníkový park pokrytý trávníkem o rozměrech $300$ m $\\times$ $400$ m. Okolo něj vede chodník. Mnozí včetně Pepy si však cestu do školy okolo parku zkracují po diagonále pěšinou vyšlapanou v trávníku. Pepa tudy chodí 2krát denně $200$ dnů v roce.',
            '8.1 Vypočtěte, jak dlouhou trasu Pepa ušetří používáním této zkratky za $1$ rok.',
            '8.2 Vypočtěte, kolik času ušetří Pepa touto zkratkou za $1$ rok, chodí-li průměrnou rychlostí $4$ km/h.',
        ],
        'opts': None, 'ln': 4,
        'svg': SVG8, 'fn': 'park.svg',
        'alt': 'Obdélníkový park 400 m krát 300 m s úhlopříčnou vyšlapanou cestou a obvodovým chodníkem.',
        'cap': 'Obdélníkový park s úhlopříčnou zkratkou',
        'sol': [
            '8.1 Chodník okolo dvou stran: $300+400=700$ m. Úhlopříčka: $\\sqrt{300^2+400^2}=500$ m. Úspora na jednu cestu $700-500=200$ m. Za rok: $200\\cdot 2\\cdot 200=80\\,000$ m $=80$ km.',
            '8.2 $80$ km při $4$ km/h trvá $80:4=20$ hodin.',
        ],
        'ans': '8.1: $80$ km; 8.2: $20$ hodin',
        'pts': 4, 'mins': 8, 'diff': '3',
        'codes': CODES_BASE + ['planimetrie', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
    },
    # ---- úloha 9 (konstrukce – množina bodů) ----
    {
        'name': 'Zelený A9 – množina bodů (p, A)',
        'zad': [
            'V rovině leží přímka $p$ a bod $A$ vzdálený od přímky $p$ $2$ cm.',
            'Vyznačte množinu bodů, které nejsou od přímky $p$ vzdáleny více než $1$ cm a zároveň nejsou od bodu $A$ vzdáleny více než $3$ cm.',
        ],
        'opts': None, 'ln': 0,
        'svg': SVG9, 'fn': 'primka-bod.svg',
        'alt': 'Vodorovná přímka p a bod A ve vzdálenosti 2 cm nad přímkou.',
        'cap': 'Výchozí obrázek k úloze 9',
        'sol': [
            'Hledaná množina je průnik dvou útvarů: pásu všech bodů do vzdálenosti $1$ cm od přímky $p$ (mezi dvěma rovnoběžkami $p_1$, $p_2$) a kruhu se středem $A$ a poloměrem $3$ cm. Řešením je „čočka" ohraničená obloukem kružnice a rovnoběžkou $p_1$.',
        ],
        'ans': 'Konstrukce: průnik pásu do $1$ cm od přímky $p$ (mezi rovnoběžkami $p_1$, $p_2$) a kruhu se středem $A$ o poloměru $3$ cm (viz obrázek v klíči).',
        'pts': 2, 'mins': 6, 'diff': '3',
        'codes': CODES_BASE + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 10 (konstrukce – středová souměrnost) ----
    {
        'name': 'Zelený A10 – středová souměrnost čtyřúhelníku',
        'zad': [
            'V rovině leží čtyřúhelník $ABCD$ a bod $S$.',
            'Sestrojte obraz čtyřúhelníku $ABCD$ ve středové souměrnosti se středem $S$.',
        ],
        'opts': None, 'ln': 0,
        'svg': SVG10, 'fn': 'ctyruhelnik-S.svg',
        'alt': 'Čtyřúhelník ABCD a bod S ležící v jeho blízkosti.',
        'cap': 'Výchozí obrázek k úloze 10',
        'sol': [
            'Každý vrchol zobrazíme ve středové souměrnosti se středem $S$: bod $X\'$ leží na polopřímce opačné k $SX$ tak, že $|SX\'|=|SX|$. Spojením obrazů $A\'B\'C\'D\'$ vznikne hledaný čtyřúhelník (shodný s původním, otočený o $180^\\circ$).',
        ],
        'ans': 'Konstrukce obrazu $A\'B\'C\'D\'$ ve středové souměrnosti se středem $S$ (viz obrázek v klíči).',
        'pts': 2, 'mins': 5, 'diff': '2',
        'codes': CODES_BASE + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 11 (výchozí text + Venn; 11.1–11.3 společný kontext) ----
    {
        'name': 'Zelený A11 – lyžařský kurz (Vennův diagram)',
        'zad': [
            'Na lyžařský kurz nás z celého ročníku jelo pouze $60$. Měli jsme si s sebou vzít buď sjezdovky, nebo snowboard, nebo běžky, popř. libovolnou kombinaci tohoto lyžařského „nádobíčka". Večer jsme si udělali statistiku, jak jsme vybaveni, a zakreslili vše do grafu. Z něj vidíme např. to, že $27$ žáků si vzalo jenom sjezdovky, zatímco $12$ žáků si vzalo sjezdovky a snowboard a $3$ žáci k tomu ještě běžky.',
            'Rozhodněte o každém z následujících tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).',
            '11.1 Každý čtvrtý účastník kurzu si s sebou nevzal sjezdovky.',
            '11.2 Na běžky mohly vyrazit nejvýše tři šestičlenné skupiny.',
            '11.3 $45\\,\\%$ účastníků mohlo během kurzu vystřídat dva lyžařské sporty, aniž by si museli půjčovat vybavení od spolužáků.',
        ],
        'opts': None, 'ln': 0,
        'svg': SVG11, 'fn': 'venn-lyze.svg',
        'alt': 'Vennův diagram tří množin sjezdovky, běžky, snowboard s počty 27, 6, 3, 3, 12, 6, 3.',
        'cap': 'Vybavení účastníků kurzu',
        'sol': [
            '11.1 Sjezdovky nemá $3+6+3=12$ z $60$, tj. $\\frac{12}{60}=\\frac{1}{5}$, ne každý čtvrtý. Tvrzení je nepravdivé (Ne).',
            '11.2 Běžky má $6+3+3+6=18$ žáků, tj. právě tři šestičlenné skupiny. Pravdivé (Ano).',
            '11.3 Dva sporty (dvě z vybavení) má $12+6+6+3=27$ žáků; $\\frac{27}{60}=45\\,\\%$. Pravdivé (Ano).',
        ],
        'ans': '11.1: Ne; 11.2: Ano; 11.3: Ano',
        'pts': 3, 'mins': 6, 'diff': '3',
        'codes': CODES_BASE + ['statistika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
    },
    # ---- úloha 12 (výběr z možností) ----
    {
        'name': 'Zelený A12 – kancelářská budova (hranol)',
        'zad': [
            'Nová kancelářská budova má tvar hranolu vysokého $100$ metrů s podstavou pravoúhlého trojúhelníku o obsahu $2400$ m². Délky stěn budovy svírající pravý úhel jsou v poměru $4:3$.',
            'Jaký je obsah plochy všech tří stěn budovy?',
        ],
        'opts': ['A) $12\\,000$ m²', 'B) $14\\,000$ m²', 'C) $21\\,000$ m²', 'D) $24\\,000$ m²', 'E) jiný obsah'],
        'ln': 0,
        'sol': [
            'Odvěsny v poměru $4:3$, tj. $4k$ a $3k$: $\\frac{1}{2}\\cdot 4k\\cdot 3k=2400\\Rightarrow 6k^2=2400\\Rightarrow k=20$. Odvěsny $80$ m a $60$ m, přepona $\\sqrt{80^2+60^2}=100$ m. Obvod podstavy $80+60+100=240$ m, tři obdélníkové stěny mají obsah $240\\cdot 100=24\\,000$ m².',
        ],
        'ans': 'D) $24\\,000$ m²',
        'pts': 2, 'mins': 6, 'diff': '3',
        'codes': CODES_BASE + ['stereometrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot'],
    },
    # ---- úloha 13 (výběr z možností + obrázek) ----
    {
        'name': 'Zelený A13 – tětivový čtyřúhelník (úhly)',
        'zad': [
            'Do kružnice je vepsán čtyřúhelník. Na obrázku jsou vyznačeny známé velikosti úhlů.',
            'Jak velký je úhel na obrázku označený symbolem „?"?',
        ],
        'opts': ['A) $105^\\circ$', 'B) $112^\\circ$', 'C) $117^\\circ$', 'D) $132^\\circ$', 'E) jiný výsledek'],
        'ln': 0,
        'svg': SVG13, 'fn': 'tetivovy-ctyruhelnik.svg',
        'alt': 'Čtyřúhelník vepsaný do kružnice; u dvou vrcholů jsou vyznačeny vnější úhly 165° a 138°, u jednoho vrcholu úhel označený otazníkem.',
        'cap': 'Schematický nákres k úloze 13',
        'sol': [
            'Z vnějších úhlů získáme vnitřní úhly čtyřúhelníku u příslušných vrcholů: $180^\\circ-165^\\circ=15^\\circ$ a $180^\\circ-138^\\circ=42^\\circ$. V tětivovém čtyřúhelníku je součet protilehlých úhlů $180^\\circ$; dopočtem hledaný úhel $?=117^\\circ$.',
        ],
        'ans': 'C) $117^\\circ$',
        'pts': 2, 'mins': 5, 'diff': '3',
        'codes': CODES_BASE + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 14 (výběr z možností + obrázek) ----
    {
        'name': 'Zelený A14 – čtverec a lichoběžník',
        'zad': [
            'Na obrázku je čtverec o straně $a=8$ cm a rovnoramenný lichoběžník o základnách rovných straně čtverce, resp. její jedné čtvrtině.',
            'Jaký je poměr obsahu šedé a bílé plochy čtverce?',
        ],
        'opts': ['A) $3:8$', 'B) $5:8$', 'C) $3:5$', 'D) $5:3$', 'E) jiný poměr'],
        'ln': 0,
        'svg': SVG14, 'fn': 'ctverec-lichobeznik.svg',
        'alt': 'Čtverec o straně a se vepsaným rovnoramenným lichoběžníkem (bílým); zbytek čtverce je šedý.',
        'cap': 'Čtverec se vepsaným lichoběžníkem',
        'sol': [
            'Lichoběžník (bílý) má základny $a=8$ cm a $\\frac{a}{4}=2$ cm a výšku $a=8$ cm: $S_{b}=\\frac{8+2}{2}\\cdot 8=40$ cm². Čtverec má $S=64$ cm², šedá plocha $64-40=24$ cm². Poměr šedá : bílá $=24:40=3:5$.',
        ],
        'ans': 'C) $3:5$',
        'pts': 2, 'mins': 5, 'diff': '3',
        'codes': CODES_BASE + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
    },
    # ---- úloha 15 (přiřazování 15.1–15.3 -> A–F; společná nabídka) ----
    {
        'name': 'Zelený A15 – procenta (přiřazování)',
        'zad': [
            'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).',
            '15.1 V listopadu naše firma vyplatila na mzdách $800\\,000$ korun a v prosinci o $200\\,000$ korun víc. Současně ale v prosinci počet zaměstnanců firmy klesl ve srovnání s listopadem o jednu pětinu. O kolik $\\%$ se v prosinci zvýšila průměrná mzda ve srovnání s listopadem?',
            '15.2 Poté, kdy obchod pana Křápka snížil cenu másla o $10\\,\\%$ a vedlejší prodejna paní Skočdopolové dokonce o celou čtvrtinu, prodávají oba máslo za stejnou cenu. O kolik $\\%$ bylo máslo před zlevněním u paní Skočdopolové dražší než u pana Křápka?',
            '15.3 V roce 2015 se počet uchazečů o studium na naší škole meziročně snížil o desetinu. Rok na to jsme otevřeli nové obory a zájem se zvýšil proti předchozímu roku o celou polovinu. O kolik $\\%$ se zvýšil počet uchazečů v roce 2016 ve srovnání s rokem 2014?',
        ],
        'opts': ['A) o $20\\,\\%$', 'B) o $25\\,\\%$', 'C) o $30\\,\\%$', 'D) o $35\\,\\%$', 'E) o $50\\,\\%$', 'F) jiný výsledek'],
        'ln': 0,
        'sol': [
            '15.1 Průměrná mzda XI: $\\frac{800\\,000}{n}$; XII: $\\frac{1\\,000\\,000}{0{,}8n}=\\frac{1\\,250\\,000}{n}$. Nárůst $\\frac{1\\,250\\,000}{800\\,000}=1{,}5625$, tj. o $56{,}25\\,\\%$ → F.',
            '15.2 $0{,}9K=0{,}75S\\Rightarrow \\frac{S}{K}=1{,}2$, máslo bylo o $20\\,\\%$ dražší → A.',
            '15.3 $0{,}9\\cdot 1{,}5=1{,}35$, tj. nárůst o $35\\,\\%$ → D.',
        ],
        'ans': '15.1: F (o $56{,}25\\,\\%$); 15.2: A (o $20\\,\\%$); 15.3: D (o $35\\,\\%$)',
        'pts': 6, 'mins': 9, 'diff': '4',
        'codes': CODES_BASE + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'finance'],
    },
    # ---- úloha 16 (výchozí text; číselné řady 16.1–16.3 společný kontext) ----
    {
        'name': 'Zelený A16 – číselné řady',
        'zad': [
            'V následujících třech příkladech 16.1–16.3 jsou čísla v číselných řadách uspořádána vždy podle nějakého pravidla. V každé řadě však dvě z čísel chybí a jsou na jejich místě symboly ■ a ■■. Nahraďte symboly ■ a ■■ čísly odpovídajícími pravidlu příslušné řady.',
            '16.1  ■ … $5$ … $10$ … $8$ … $16$ … ■■ … $28$ … $26$ … $52$',
            '16.2  $1$ … $1$ … $2$ … $3$ … $5$ … $8$ … ■ … ■■ … $34$ … $55$ … $89$',
            '16.3  $123$ … $35$ … $234$ … $57$ … $345$ … ■ … $456$ … $911$ … ■■',
        ],
        'opts': None, 'ln': 4,
        'sol': [
            '16.1 Operace se pravidelně střídají $-2$ a $\\times 2$: $7\\;(-2)\\;5\\;(\\times 2)\\;10\\;(-2)\\;8\\;(\\times 2)\\;16\\;(-2)\\;14\\;(\\times 2)\\;28\\;(-2)\\;26\\;(\\times 2)\\;52$. Proto ■ $=7$ a ■■ $=14$.',
            '16.2 Fibonacciova posloupnost: každé číslo je součtem dvou předchozích. $8+5=13$, $13+8=21$. ■ $=13$, ■■ $=21$.',
            '16.3 Na lichých místech jsou trojice po sobě jdoucích číslic $123,\\ 234,\\ 345,\\ 456,\\ 567$ → ■■ $=567$. Na sudých místech jsou spojená po sobě jdoucí lichá čísla ($3$–$5$, $5$–$7$, $7$–$9$, $9$–$11$), tj. $35,\\ 57,\\ 79,\\ 911$ → ■ $=79$.',
        ],
        'ans': '16.1: ■ $=7$, ■■ $=14$; 16.2: ■ $=13$, ■■ $=21$; 16.3: ■ $=79$, ■■ $=567$',
        'pts': 6, 'mins': 8, 'diff': '3',
        'codes': CODES_BASE + ['posloupnosti', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu'],
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
    written = gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-zeleny-testA'))
    total = 0
    for path, sz, k in written:
        total += k
        flag = 'OK' if sz < 9000 else 'PŘES 9KB!'
        print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{flag}]')
    print('Celkem úloh:', total)
