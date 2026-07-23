# -*- coding: utf-8 -*-
# CERMAT - Jednotna prijimaci zkouska 2024, MATEMATIKA 9A (ctyrlete obory, 9. rocnik),
# 1. radny termin. Kod testu: M9PAD24C0T01. 16 uloh, max 50 bodu.
# Po rozdeleni nezavislych poduuloh (uloha 3, 4, 5) je zde 20 uloh.
# Zdroj odpovedi: klic spravnych reseni (KSR) MATEMATIKA 9A.

# ---- SVG obrazky (bez ' a \) ----

# uloha 2: sklenene tezitko -- rotacni valec r=10, v=12; vnitrni modry valec r=5, v=8
SVG2 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 300 250" font-family="sans-serif">
<ellipse cx="150" cy="45" rx="95" ry="20" fill="#f2f2f2" stroke="#000"/>
<line x1="55" y1="45" x2="55" y2="195" stroke="#000"/>
<line x1="245" y1="45" x2="245" y2="195" stroke="#000"/>
<path d="M55 195 A95 20 0 0 0 245 195" fill="none" stroke="#000"/>
<path d="M55 195 A95 20 0 0 1 245 195" fill="none" stroke="#000" stroke-dasharray="4 4"/>
<ellipse cx="150" cy="80" rx="45" ry="10" fill="#a9c1e0" stroke="#000"/>
<line x1="105" y1="80" x2="105" y2="158" stroke="#000"/>
<line x1="195" y1="80" x2="195" y2="158" stroke="#000"/>
<path d="M105 158 A45 10 0 0 0 195 158" fill="#a9c1e0" stroke="#000"/>
<path d="M105 158 A45 10 0 0 1 195 158" fill="none" stroke="#000" stroke-dasharray="3 3"/>
<text x="258" y="128" font-size="13">12 cm</text>
<text x="150" y="122" font-size="12" text-anchor="middle" fill="#333">8 cm</text>
</svg>"""

# uloha 6: pravouhly lichobeznik ABCD, pravy uhel pri B, AB=40, CD=28, uhlopricka AC=41
SVG6 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 280" font-family="sans-serif">
<polygon points="60,220 560,220 560,70 210,70" fill="none" stroke="#000" stroke-width="2"/>
<line x1="60" y1="220" x2="560" y2="70" stroke="#000"/>
<rect x="543" y="203" width="17" height="17" fill="none" stroke="#000"/>
<text x="46" y="238" font-size="16" font-style="italic">A</text>
<text x="566" y="238" font-size="16" font-style="italic">B</text>
<text x="566" y="66" font-size="16" font-style="italic">C</text>
<text x="192" y="66" font-size="16" font-style="italic">D</text>
<text x="300" y="242" font-size="14">40 cm</text>
<text x="360" y="60" font-size="14">28 cm</text>
<text x="330" y="150" font-size="14">41 cm</text>
</svg>"""

# uloha 8: sedy obrazec -- horni usecka 20 cm a dve shodne ctvrtkruznice (r=10) do bodu dole
SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 200" font-family="sans-serif">
<rect x="60" y="40" width="200" height="100" fill="none" stroke="#999" stroke-dasharray="4 4"/>
<line x1="160" y1="140" x2="160" y2="175" stroke="#999" stroke-dasharray="3 3"/>
<line x1="60" y1="40" x2="260" y2="40" stroke="#000" stroke-width="2"/>
<path d="M60 40 L260 40 A100 100 0 0 0 160 140 A100 100 0 0 0 60 40 Z" fill="#b9b9b9" stroke="#000" stroke-width="1.5"/>
<text x="160" y="30" font-size="13" text-anchor="middle">20 cm</text>
</svg>"""

# uloha 9: body C (nahore) a S (vpravo dole)
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 300" font-family="sans-serif">
<rect x="6" y="6" width="388" height="288" fill="none" stroke="#ccc"/>
<text x="150" y="98" font-size="15" text-anchor="middle">x</text>
<text x="150" y="82" font-size="15" text-anchor="middle" font-style="italic">C</text>
<text x="270" y="212" font-size="15" text-anchor="middle">x</text>
<text x="270" y="230" font-size="15" text-anchor="middle" font-style="italic">S</text>
</svg>"""

# uloha 10: primka AE a primka p procazejici bodem E; na AE vyznacen bod A
SVG10 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 320" font-family="sans-serif">
<rect x="6" y="6" width="388" height="308" fill="none" stroke="#ccc"/>
<line x1="40" y1="250" x2="370" y2="150" stroke="#000" stroke-width="2"/>
<line x1="150" y1="60" x2="300" y2="270" stroke="#000" stroke-width="2"/>
<text x="146" y="52" font-size="15" font-style="italic">p</text>
<text x="252" y="184" font-size="15" font-style="italic">E</text>
<line x1="116" y1="219" x2="126" y2="234" stroke="#000"/>
<text x="106" y="248" font-size="15" font-style="italic">A</text>
</svg>"""

# uloha 11: primky p, q, r tvorici trojuhelnik ABC (obrazek je ilustracni)
SVG11 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 300" font-family="sans-serif">
<line x1="70" y1="235" x2="300" y2="-5" stroke="#000"/>
<line x1="55" y1="168" x2="410" y2="250" stroke="#000"/>
<line x1="180" y1="-8" x2="405" y2="300" stroke="#000"/>
<text x="303" y="8" font-size="15" font-style="italic">p</text>
<text x="46" y="162" font-size="15" font-style="italic">q</text>
<text x="398" y="292" font-size="15" font-style="italic">r</text>
<text x="230" y="108" font-size="15">y</text>
<text x="138" y="200" font-size="15">a</text>
<text x="118" y="172" font-size="15">d</text>
<text x="332" y="228" font-size="15">b</text>
<text x="232" y="52" font-size="14" font-style="italic">C</text>
<text x="104" y="188" font-size="14" font-style="italic">A</text>
<text x="366" y="248" font-size="14" font-style="italic">B</text>
</svg>"""

# uloha 12: pentagonovy obrazec rozdeleny na 7 shodnych rovnoramennych trojuhelniku (schema)
SVG12 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 220" font-family="sans-serif">
<polygon points="180,185 35,130 55,80 100,50 150,38 210,38 260,50 305,80 325,130" fill="none" stroke="#000" stroke-width="2"/>
<line x1="180" y1="185" x2="55" y2="80" stroke="#777" stroke-dasharray="4 3"/>
<line x1="180" y1="185" x2="100" y2="50" stroke="#777" stroke-dasharray="4 3"/>
<line x1="180" y1="185" x2="150" y2="38" stroke="#777" stroke-dasharray="4 3"/>
<line x1="180" y1="185" x2="210" y2="38" stroke="#777" stroke-dasharray="4 3"/>
<line x1="180" y1="185" x2="260" y2="50" stroke="#777" stroke-dasharray="4 3"/>
<line x1="180" y1="185" x2="305" y2="80" stroke="#777" stroke-dasharray="4 3"/>
</svg>"""

# uloha 13: shodne ctverce A (2 obdelniky) a B (5 obdelniku)
SVG13 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 200" font-family="sans-serif">
<rect x="40" y="60" width="120" height="120" fill="none" stroke="#000" stroke-width="2"/>
<line x1="100" y1="60" x2="100" y2="180" stroke="#000"/>
<text x="100" y="46" font-size="14" text-anchor="middle">ctverec A</text>
<rect x="260" y="60" width="120" height="120" fill="none" stroke="#000" stroke-width="2"/>
<line x1="284" y1="60" x2="284" y2="180" stroke="#000"/>
<line x1="308" y1="60" x2="308" y2="180" stroke="#000"/>
<line x1="332" y1="60" x2="332" y2="180" stroke="#000"/>
<line x1="356" y1="60" x2="356" y2="180" stroke="#000"/>
<text x="320" y="46" font-size="14" text-anchor="middle">ctverec B</text>
</svg>"""

B = ['zs2', 'r9']  # 9. rocnik ZS (ctyrlete obory)

PROBLEMS = [
    {'name': 'CERMAT M9A 2024 – úloha 1', 'zad': [
        'Pět švadlen, které šijí oblečení, pracují stejným tempem. Tyto švadleny splní danou zakázku za $24$ hodin.',
        'Za jakou dobu splní o polovinu větší zakázku čtyři švadleny?'],
     'opts': None, 'ln': 2,
     'sol': ['Práce na zakázce odpovídá $5\\cdot 24=120$ švadlenohodinám. Zakázka o polovinu větší představuje $1{,}5\\cdot 120=180$ švadlenohodin. Čtyři švadleny ji splní za $180:4=45$ hodin.'],
     'ans': '$45$ hodin', 'pts': 1, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9A 2024 – úloha 2', 'zad': [
        'Skleněné těžítko má tvar rotačního válce s poloměrem podstavy $10$ cm a výškou $12$ cm. Vnější část těžítka je z čirého skla, uvnitř je část z modrého skla, která má také tvar rotačního válce, a to s poloměrem podstavy $5$ cm a výškou $8$ cm.',
        'Vypočítejte objem čirého skla v těžítku. Výsledek zaokrouhlete na desítky cm³. Pro výpočet použijte zaokrouhlenou hodnotu čísla $\\pi$ z tabulky ($\\pi \\approx 3{,}14$).'],
     'opts': None, 'ln': 3, 'svg': SVG2, 'fn': 'tezitko-valec.svg',
     'alt': 'Rotační válec (těžítko) s vnitřním menším válcem z modrého skla.',
     'cap': 'Schematický nákres těžítka (rozměry dle zadání)',
     'sol': ['Objem celého válce: $V=\\pi\\cdot 10^2\\cdot 12=3{,}14\\cdot 100\\cdot 12=3768$ cm³. Objem modrého válce: $V_m=\\pi\\cdot 5^2\\cdot 8=3{,}14\\cdot 25\\cdot 8=628$ cm³. Objem čirého skla: $3768-628=3140$ cm³.'],
     'ans': '$3\\,140$ cm³', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['stereometrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9A 2024 – úloha 3.1', 'zad': [
        'Vypočítejte a výsledek zapište zlomkem v základním tvaru. Uveďte celý postup řešení.',
        '$\\left(2:\\dfrac{3}{2}\\right):\\dfrac{1}{2}+\\left(\\dfrac{5}{6}:\\dfrac{3}{4}\\right):\\dfrac{2}{3}=$'],
     'opts': None, 'ln': 3,
     'sol': ['$\\left(2:\\frac{3}{2}\\right):\\frac{1}{2}=\\frac{4}{3}:\\frac{1}{2}=\\frac{8}{3}$. Dále $\\left(\\frac{5}{6}:\\frac{3}{4}\\right):\\frac{2}{3}=\\frac{10}{9}:\\frac{2}{3}=\\frac{10}{9}\\cdot\\frac{3}{2}=\\frac{5}{3}$. Součet: $\\frac{8}{3}+\\frac{5}{3}=\\frac{13}{3}$.'],
     'ans': '$\\dfrac{13}{3}$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2024 – úloha 3.2', 'zad': [
        'Vypočítejte a výsledek zapište zlomkem v základním tvaru. Uveďte celý postup řešení.',
        '$\\dfrac{\\frac{13}{10}-1{,}4}{\\frac{2}{15}+\\frac{1}{6}}=$'],
     'opts': None, 'ln': 3,
     'sol': ['Čitatel: $\\frac{13}{10}-1{,}4=1{,}3-1{,}4=-\\frac{1}{10}$. Jmenovatel: $\\frac{2}{15}+\\frac{1}{6}=\\frac{4}{30}+\\frac{5}{30}=\\frac{9}{30}=\\frac{3}{10}$. Podíl: $-\\frac{1}{10}:\\frac{3}{10}=-\\frac{1}{3}$.'],
     'ans': '$-\\dfrac{1}{3}$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2024 – úloha 4.1', 'zad': [
        'Zjednodušte (výsledný výraz nesmí obsahovat závorky):',
        '$\\left(a-\\dfrac{a}{4}\\right)^2=$'],
     'opts': None, 'ln': 2,
     'sol': ['$\\left(a-\\frac{a}{4}\\right)^2=\\left(\\frac{3a}{4}\\right)^2=\\frac{9}{16}a^2$.'],
     'ans': '$\\dfrac{9}{16}a^2$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2024 – úloha 4.2', 'zad': [
        'Rozložte na součin podle vzorce:',
        '$9a^2-16=$'],
     'opts': None, 'ln': 2,
     'sol': ['$9a^2-16=(3a)^2-4^2=(3a-4)\\cdot(3a+4)$.'],
     'ans': '$(3a-4)\\cdot(3a+4)$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2024 – úloha 4.3', 'zad': [
        'Zjednodušte a výsledek rozložte na součin vytýkáním. Uveďte celý postup řešení.',
        '$(c-5)\\cdot(2-3c)-(c-2c)\\cdot 3c-c\\cdot 7=$'],
     'opts': None, 'ln': 3,
     'sol': ['$(c-5)\\cdot(2-3c)=-3c^2+17c-10$; $-(c-2c)\\cdot 3c=-(-c)\\cdot 3c=3c^2$; $-c\\cdot 7=-7c$. Součet: $-3c^2+17c-10+3c^2-7c=10c-10=10\\cdot(c-1)$.'],
     'ans': '$10\\cdot(c-1)$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2024 – úloha 5.1', 'zad': [
        'Řešte rovnici. Uveďte celý postup řešení. Zkoušku nezapisujte.',
        '$-2\\cdot(x+4)-3\\cdot(x+1)^2=x\\cdot(2-3x)$'],
     'opts': None, 'ln': 4,
     'sol': ['$-2x-8-3(x^2+2x+1)=2x-3x^2$; $-3x^2-8x-11=2x-3x^2$; $-8x-11=2x$; $-11=10x$; $x=-\\frac{11}{10}=-1{,}1$.'],
     'ans': '$x=-1{,}1$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2024 – úloha 5.2', 'zad': [
        'Řešte rovnici. Uveďte celý postup řešení. Zkoušku nezapisujte.',
        '$6-\\dfrac{3-2y}{5}\\cdot 2=4y$'],
     'opts': None, 'ln': 4,
     'sol': ['Vynásobíme pěti: $30-2\\cdot(3-2y)=20y$; $30-6+4y=20y$; $24+4y=20y$; $24=16y$; $y=\\frac{24}{16}=\\frac{3}{2}$.'],
     'ans': '$y=\\dfrac{3}{2}$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2024 – úloha 6', 'zad': [
        'Pravoúhlý lichoběžník $ABCD$ se základnami $AB$ a $CD$ má pravý úhel při vrcholu $B$. Základna $AB$ má délku $40$ cm, základna $CD$ délku $28$ cm a úhlopříčka $AC$ délku $41$ cm.',
        '6.1 Vypočítejte obsah lichoběžníku $ABCD$. Výsledek uveďte v cm².',
        '6.2 Vypočítejte délku ramene $AD$. Výsledek uveďte v cm.'],
     'opts': None, 'ln': 4, 'svg': SVG6, 'fn': 'lichobeznik-ABCD.svg',
     'alt': 'Pravoúhlý lichoběžník ABCD s pravým úhlem při B, základnami AB rovnou 40 cm a CD rovnou 28 cm a úhlopříčkou AC rovnou 41 cm.',
     'cap': 'Pravoúhlý lichoběžník ABCD',
     'sol': ['6.1 Pravý úhel je při $B$, proto výška $BC$ je odvěsna pravoúhlého trojúhelníku $ABC$ s přeponou $AC=41$ cm a odvěsnou $AB=40$ cm: $BC=\\sqrt{41^2-40^2}=\\sqrt{81}=9$ cm. Obsah: $S=\\frac{AB+CD}{2}\\cdot BC=\\frac{40+28}{2}\\cdot 9=34\\cdot 9=306$ cm².',
            '6.2 Vodorovný rozdíl základen je $40-28=12$ cm, výška $9$ cm, proto rameno $AD=\\sqrt{12^2+9^2}=\\sqrt{225}=15$ cm.'],
     'ans': '6.1: $306$ cm²; 6.2: $15$ cm', 'pts': 4, 'mins': 7, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2024 – úloha 7', 'zad': [
        'Žáci třídy 8. B se dělí na dvě skupiny podle toho, zda chodí na němčinu, nebo na angličtinu. V obou skupinách je stejný počet žáků. Ve třídě je $14$ chlapců a $5$ z nich chodí na angličtinu. Na němčinu chodí $4$ dívky.',
        '7.1 Kolik dívek celkem chodí na angličtinu?',
        '7.2 Kolik má třída 8. B celkem žáků?'],
     'opts': None, 'ln': 4,
     'sol': ['Na němčinu chodí $14-5=9$ chlapců a $4$ dívky, skupina němčiny má tedy $13$ žáků. Obě skupiny jsou stejně velké, takže i angličtina má $13$ žáků.',
            '7.1 V angličtině je $5$ chlapců, tedy dívek $13-5=8$.',
            '7.2 Celkem $13+13=26$ žáků.'],
     'ans': '7.1: $8$ dívek; 7.2: $26$ žáků', 'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9A 2024 – úloha 8', 'zad': [
        'Šedý obrazec je ohraničen úsečkou délky $20$ cm a dvěma shodnými čtvrtkružnicemi (viz obrázek). Pro výpočet použijte zaokrouhlenou hodnotu čísla $\\pi$ z tabulky ($\\pi \\approx 3{,}14$).',
        '8.1 Vypočítejte obsah šedého obrazce. Výsledek uveďte v cm² a zaokrouhlete ho na celé cm².',
        '8.2 Vypočítejte obvod šedého obrazce. Výsledek uveďte v cm a zaokrouhlete ho na celé cm.'],
     'opts': None, 'ln': 4, 'svg': SVG8, 'fn': 'sedy-obrazec.svg',
     'alt': 'Šedý obrazec s vodorovnou horní úsečkou délky 20 cm, jehož boky tvoří dvě shodné čtvrtkružnice sbíhající se do bodu dole.',
     'cap': 'Schematický nákres šedého obrazce',
     'sol': ['Poloměr obou čtvrtkružnic je polovina úsečky, tj. $r=10$ cm. Obsah získáme jako obdélník $20\\times 10=200$ cm² zmenšený o dvě čtvrtkružnice (dohromady půlkruh) $\\frac{1}{2}\\pi r^2=\\frac{1}{2}\\cdot 3{,}14\\cdot 100=157$ cm²; tedy $200-157=43$ cm².',
            '8.2 Obvod tvoří úsečka $20$ cm a dva čtvrtkruhové oblouky, dohromady půlkružnice $\\pi r=3{,}14\\cdot 10=31{,}4$ cm; $20+31{,}4=51{,}4$ cm, po zaokrouhlení $51$ cm.'],
     'ans': '8.1: $43$ cm²; 8.2: $51$ cm', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2024 – úloha 9 (konstrukce)', 'zad': [
        'V rovině leží body $C$ a $S$ (viz obrázek). Bod $C$ je vrchol rovnostranného trojúhelníku $ABC$. Bod $S$ je středem strany $AB$.',
        'Sestrojte vrcholy $A$, $B$ rovnostranného trojúhelníku $ABC$ a trojúhelník narýsujte.'],
     'opts': None, 'ln': 0, 'svg': SVG9, 'fn': 'body-CS.svg',
     'alt': 'Dva body v rovině: bod C nahoře a bod S vpravo dole.',
     'cap': 'Výchozí obrázek k úloze 9',
     'sol': ['V rovnostranném trojúhelníku je spojnice vrcholu $C$ se středem $S$ protější strany kolmá na tuto stranu, proto přímka $AB$ je kolmice k $CS$ vedená bodem $S$. Protože výška rovnostranného trojúhelníku svírá s ramenem úhel $30^\\circ$, sestrojíme z bodu $C$ polopřímku svírající s $CS$ úhel $30^\\circ$; její průsečík s kolmicí je vrchol $A$. Bod $B$ je souměrný s $A$ podle středu $S$ ($|SB|=|SA|$). Trojúhelník $ABC$ narýsujeme.'],
     'ans': 'Přímka $AB$ je kolmice k $CS$ v bodě $S$; vrcholy $A$, $B$ leží na této kolmici tak, že $|\\angle SCA|=|\\angle SCB|=30^\\circ$ a $S$ je střed $AB$ (viz náčrt konstrukce v klíči).',
     'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2024 – úloha 10 (konstrukce)', 'zad': [
        'V rovině leží přímka $AE$ a přímka $p$ procházející bodem $E$ (viz obrázek). Bod $A$ je vrchol obdélníku $ABCD$. Vrchol $B$ leží na přímce $AE$ a vrchol $C$ na přímce $p$. Úhlopříčka $BD$ obdélníku $ABCD$ má stejnou délku jako úsečka $AE$.',
        'Sestrojte vrcholy $B$, $C$, $D$ obdélníku $ABCD$, označte je písmeny a obdélník narýsujte.'],
     'opts': None, 'ln': 0, 'svg': SVG10, 'fn': 'primky-AE-p.svg',
     'alt': 'Přímka AE a přímka p procházející bodem E; na přímce AE je vyznačen bod A.',
     'cap': 'Výchozí obrázek k úloze 10',
     'sol': ['Úhlopříčky obdélníku jsou shodné, proto $|AC|=|BD|=|AE|$. Vrchol $C$ tedy leží na kružnici se středem $A$ a poloměrem $|AE|$ a zároveň na přímce $p$: $C=k(A;|AE|)\\cap p$. Vrchol $B$ je pata kolmice z bodu $C$ na přímku $AE$ (úhel při $B$ je pravý). Vrchol $D$ doplníme jako průsečík kolmice k $AE$ v bodě $A$ a kolmice k $AB$ v bodě $C$, aby $ABCD$ byl obdélník.'],
     'ans': 'Vrchol $C$: $k(A;|AE|)\\cap p$; vrchol $B$: pata kolmice z $C$ na přímku $AE$; vrchol $D$ doplníme na obdélník $ABCD$ (viz náčrt konstrukce v klíči).',
     'pts': 3, 'mins': 7, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2024 – úloha 11', 'zad': [
        'V rovině leží přímky $p$, $q$ a $r$, jejichž průsečíky tvoří vrcholy trojúhelníku $ABC$ (viz obrázek). Jsou dány úhly $\\beta=23^\\circ$ a $\\delta=107^\\circ$.',
        'Jaká je velikost rozdílu úhlů $\\gamma-\\alpha$? Velikosti úhlů neměřte, ale vypočítejte (obrázek je ilustrační).'],
     'opts': ['A) $10^\\circ$', 'B) $11^\\circ$', 'C) $12^\\circ$', 'D) $13^\\circ$', 'E) jiná velikost'], 'ln': 0,
     'svg': SVG11, 'fn': 'primky-pqr.svg',
     'alt': 'Tři přímky p, q, r tvořící trojúhelník ABC; u vrcholu A úhly delta a alfa, u vrcholu C úhel gama, u vrcholu B úhel beta.',
     'cap': 'Schematický nákres (obrázek je ilustrační)',
     'sol': ['Úhly $\\alpha$ a $\\delta$ jsou vedlejší (leží na přímce $q$ u vrcholu $A$), proto $\\alpha=180^\\circ-\\delta=180^\\circ-107^\\circ=73^\\circ$. V trojúhelníku $ABC$ platí $\\gamma=180^\\circ-\\alpha-\\beta=180^\\circ-73^\\circ-23^\\circ=84^\\circ$. Rozdíl $\\gamma-\\alpha=84^\\circ-73^\\circ=11^\\circ$.'],
     'ans': 'B) $11^\\circ$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2024 – úloha 12', 'zad': [
        'Obrazec je možné rozstříhat na $7$ shodných rovnoramenných trojúhelníků (viz obrázek). Obvod jednoho takového trojúhelníku je $30$ cm.',
        'Jaký je obvod obrazce?'],
     'opts': ['A) $55$ cm', 'B) $60$ cm', 'C) $66$ cm', 'D) $72$ cm', 'E) $90$ cm'], 'ln': 0,
     'svg': SVG12, 'fn': 'obrazec-7-troj.svg',
     'alt': 'Pětiúhelníkový obrazec rozdělený čárkovanými úsečkami z vnitřního bodu na sedm shodných rovnoramenných trojúhelníků.',
     'cap': 'Schematický nákres obrazce',
     'sol': ['Rovnoramenný trojúhelník má základnu $z$ a ramena délky $r$, přičemž $2r+z=30$ cm. Obvod obrazce tvoří sedm základen a dvě krajní ramena, tedy $7z+2r$. Podle obrázku jsou ramena dvakrát delší než základna ($r=2z$), z čehož $2\\cdot 2z+z=30$, $5z=30$, $z=6$ cm a $r=12$ cm. Obvod obrazce: $7\\cdot 6+2\\cdot 12=42+24=66$ cm.'],
     'ans': 'C) $66$ cm', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['planimetrie', 'porozumeni', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2024 – úloha 13', 'zad': [
        'Máme shodné čtverce $A$ a $B$. Čtverec $A$ je rozdělen na dva shodné obdélníky, čtverec $B$ na pět shodných obdélníků (viz obrázek). Obvod jednoho ze dvou obdélníků ve čtverci $A$ je o $6$ cm větší než obvod jednoho z pěti obdélníků ve čtverci $B$.',
        'Jaký je obvod jednoho ze čtverců $A$ nebo $B$?'],
     'opts': ['A) $40$ cm', 'B) $72$ cm', 'C) $80$ cm', 'D) $96$ cm', 'E) $128$ cm'], 'ln': 0,
     'svg': SVG13, 'fn': 'ctverce-AB.svg',
     'alt': 'Dva shodné čtverce: čtverec A rozdělený svislou čarou na dva obdélníky, čtverec B rozdělený na pět svislých obdélníků.',
     'cap': 'Čtverec A a čtverec B',
     'sol': ['Označme stranu čtverce $s$. Obdélník ve čtverci $A$ má rozměry $s\\times\\frac{s}{2}$, obvod $2\\left(s+\\frac{s}{2}\\right)=3s$. Obdélník ve čtverci $B$ má rozměry $s\\times\\frac{s}{5}$, obvod $2\\left(s+\\frac{s}{5}\\right)=\\frac{12s}{5}$. Rozdíl: $3s-\\frac{12s}{5}=\\frac{3s}{5}=6$, odtud $s=10$ cm. Obvod čtverce je $4s=40$ cm.'],
     'ans': 'A) $40$ cm', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2024 – úloha 14', 'zad': [
        'Vynásobíme-li neznámé číslo dvěma a odečteme-li od výsledku $135$, získáme polovinu hodnoty neznámého čísla.',
        'Jaká je hodnota neznámého čísla?'],
     'opts': ['A) $270$', 'B) $170$', 'C) $135$', 'D) $90$', 'E) jiný výsledek'], 'ln': 0,
     'sol': ['Označme neznámé číslo $x$. Rovnice: $2x-135=\\frac{x}{2}$, tj. $2x-\\frac{x}{2}=135$, $\\frac{3x}{2}=135$, $x=90$.'],
     'ans': 'D) $90$', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['rovnice', 'modelovani', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2024 – úloha 15', 'zad': [
        'Půdorys domu má tvar obdélníku. Šířka domu je $10$ metrů. V plánu je tato šířka vyznačena úsečkou o délce $10$ cm. Délka domu je v plánu zakreslena jako úsečka o délce $2$ dm.',
        'Rozhodněte o každém z následujících tvrzení 15.1–15.3, zda je pravdivé (A), či nikoli (N).',
        '15.1 Měřítko plánu je $1:1000$.',
        '15.2 Skutečná délka domu je $20$ m.',
        '15.3 Obsah obdélníku na plánu a obsah půdorysu domu jsou v poměru $1:100$.'],
     'opts': None, 'ln': 0,
     'sol': ['15.1 Skutečná šířka $10$ m $=1000$ cm je v plánu $10$ cm, měřítko je tedy $10:1000=1:100$, nikoli $1:1000$ → Ne.',
            '15.2 Délka v plánu $2$ dm $=20$ cm; při měřítku $1:100$ je skutečná délka $20\\cdot 100=2000$ cm $=20$ m → Ano.',
            '15.3 Poměr obsahů je druhá mocnina měřítka, tj. $1:100^2=1:10\\,000$, nikoli $1:100$ → Ne.'],
     'ans': '15.1: Ne; 15.2: Ano; 15.3: Ne', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['planimetrie', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9A 2024 – úloha 16', 'zad': [
        'Přiřaďte ke každé úloze (16.1–16.3) odpovídající výsledek (A–F).',
        '16.1 Pan Novák si vypůjčil $20\\,000$ Kč na jeden rok. Po roce vrátí věřiteli vypůjčenou částku, a navíc mu zaplatí úrok ve výši $13{,}5\\,\\%$ z vypůjčené částky. Kolik korun celkem věřiteli vrátí?',
        '16.2 Paní Dlouhá na začátku roku vložila do banky $1\\,000\\,000$ Kč s roční úrokovou sazbou $2{,}5\\,\\%$. Výnosy z úroků jsou zdaněny srážkovou daní. Kolik korun získá paní Dlouhá navíc ke svému vkladu za jeden rok, bude-li jí odečtena daň z úroků $15\\,\\%$?',
        '16.3 Kolo v obchodě stálo $20\\,000$ Kč. Nejdříve bylo zlevněno o $10\\,\\%$ z původní ceny, po měsíci bylo zdraženo o $10\\,\\%$ z nové ceny. Jaká byla výsledná cena kola po zlevnění i zdražení?'],
     'opts': ['A) $22\\,700$ Kč', 'B) $21\\,350$ Kč', 'C) $21\\,250$ Kč', 'D) $20\\,000$ Kč', 'E) $19\\,800$ Kč', 'F) jiný výsledek'], 'ln': 0,
     'sol': ['16.1 Úrok $13{,}5\\,\\%$ z $20\\,000=2\\,700$ Kč; celkem vrátí $20\\,000+2\\,700=22\\,700$ Kč → A.',
            '16.2 Úrok $2{,}5\\,\\%$ z $1\\,000\\,000=25\\,000$ Kč; po zdanění $15\\,\\%$ zůstane $25\\,000\\cdot 0{,}85=21\\,250$ Kč → C.',
            '16.3 Po zlevnění $20\\,000\\cdot 0{,}9=18\\,000$ Kč, po zdražení $18\\,000\\cdot 1{,}1=19\\,800$ Kč → E.'],
     'ans': '16.1: A ($22\\,700$ Kč); 16.2: C ($21\\,250$ Kč); 16.3: E ($19\\,800$ Kč)', 'pts': 6, 'mins': 8, 'diff': '3',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'finance']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M9PAD24C0T01'
    gen.YEAR = 2024

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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M9A-2024')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
