# -*- coding: utf-8 -*-
# CERMAT - Jednotna prijimaci zkouska 2026, MATEMATIKA 9A, 1. radny termin (ostry test).
# Kod testu: M9PAD26C0T01. 16 uloh (po rozdeleni nezavislych poduuloh 20 uloh).
# Zdroj odpovedi: klic spravnych reseni (KSR) + spravne vyplneny zaznamovy arch (VZA).

# ---- SVG obrazky (bez ' a \) ----

# uloha 6: cyklostezka Nadrazi -- Chata, celkova delka x
SVG6 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 120" font-family="sans-serif">
<text x="46" y="34" font-size="14">Nadrazi</text>
<text x="404" y="34" font-size="14">Chata</text>
<circle cx="55" cy="58" r="4" fill="#000"/>
<circle cx="435" cy="58" r="4" fill="#000"/>
<line x1="55" y1="58" x2="435" y2="58" stroke="#000" stroke-width="2"/>
<line x1="55" y1="84" x2="435" y2="84" stroke="#000" stroke-width="1"/>
<polygon points="55,84 66,80 66,88" fill="#000"/>
<polygon points="435,84 424,80 424,88" fill="#000"/>
<text x="245" y="102" font-size="16" text-anchor="middle" font-style="italic">x</text>
</svg>"""

# uloha 8: trojuhelnik ABC vepsany do kruznice k, AB prumer, q kolma, osa o
SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 380 300" font-family="sans-serif">
<circle cx="200" cy="160" r="120" fill="none" stroke="#000"/>
<line x1="80" y1="160" x2="320" y2="160" stroke="#000"/>
<line x1="80" y1="160" x2="108" y2="83" stroke="#000"/>
<line x1="320" y1="160" x2="108" y2="83" stroke="#000"/>
<line x1="108" y1="48" x2="108" y2="288" stroke="#000" stroke-dasharray="3 3"/>
<line x1="44" y1="112" x2="320" y2="160" stroke="#000" stroke-dasharray="7 3 2 3"/>
<rect x="108" y="150" width="10" height="10" fill="none" stroke="#000"/>
<circle cx="200" cy="160" r="2.5" fill="#000"/>
<text x="66" y="174" font-size="15" font-style="italic">A</text>
<text x="326" y="170" font-size="15" font-style="italic">B</text>
<text x="96" y="76" font-size="15" font-style="italic">C</text>
<text x="196" y="180" font-size="14" font-style="italic">S</text>
<text x="100" y="44" font-size="15" font-style="italic">q</text>
<text x="300" y="96" font-size="15" font-style="italic">k</text>
<text x="32" y="110" font-size="15" font-style="italic">o</text>
<text x="130" y="122" font-size="13">100°</text>
<text x="100" y="151" font-size="14">α</text>
<text x="286" y="151" font-size="14">φ</text>
</svg>"""

# uloha 9: bod A a dve ruznobezne primky b, c
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 300" font-family="sans-serif">
<line x1="30" y1="92" x2="372" y2="172" stroke="#000" stroke-width="2"/>
<line x1="150" y1="272" x2="242" y2="40" stroke="#000" stroke-width="2"/>
<text x="34" y="84" font-size="15" font-style="italic">c</text>
<text x="246" y="46" font-size="15" font-style="italic">b</text>
<text x="92" y="206" font-size="14" text-anchor="middle">×</text>
<text x="92" y="224" font-size="14" text-anchor="middle" font-style="italic">A</text>
</svg>"""

# uloha 10: bod A a primka o
SVG10 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 260" font-family="sans-serif">
<line x1="40" y1="80" x2="360" y2="182" stroke="#000" stroke-width="2"/>
<text x="44" y="72" font-size="15" font-style="italic">o</text>
<text x="196" y="206" font-size="14" text-anchor="middle">×</text>
<text x="196" y="224" font-size="14" text-anchor="middle" font-style="italic">A</text>
</svg>"""

# uloha 11: kruhovy diagram (ryze 35 %, cukr 25 %, kava 20 %, banany 20 %)
SVG11 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 220" font-family="sans-serif">
<defs><pattern id="h" width="8" height="8" patternUnits="userSpaceOnUse" patternTransform="rotate(45)">
<line x1="0" y1="0" x2="0" y2="8" stroke="#555" stroke-width="2.5"/></pattern></defs>
<path d="M140,120 L140,40 A80,80 0 0 1 204.7,167 Z" fill="url(#h)" stroke="#000"/>
<path d="M140,120 L204.7,167 A80,80 0 0 1 93,184.7 Z" fill="#ffffff" stroke="#000"/>
<path d="M140,120 L93,184.7 A80,80 0 0 1 63.9,95.3 Z" fill="#d0d0d0" stroke="#000"/>
<path d="M140,120 L63.9,95.3 A80,80 0 0 1 140,40 Z" fill="#6a6a6a" stroke="#000"/>
<text x="168" y="104" font-size="13">35 %</text>
<text x="120" y="168" font-size="13">25 %</text>
<rect x="250" y="56" width="14" height="14" fill="url(#h)" stroke="#000"/><text x="270" y="68" font-size="13">ryze</text>
<rect x="250" y="82" width="14" height="14" fill="#ffffff" stroke="#000"/><text x="270" y="94" font-size="13">cukr</text>
<rect x="250" y="108" width="14" height="14" fill="#d0d0d0" stroke="#000"/><text x="270" y="120" font-size="13">kava</text>
<rect x="250" y="134" width="14" height="14" fill="#6a6a6a" stroke="#000"/><text x="270" y="146" font-size="13">banany</text>
</svg>"""

# uloha 13: rovnoramenny trojuhelnik KLM, zakladna LM = 16 cm nahore, vrchol K dole
SVG13 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 260 200" font-family="sans-serif">
<polygon points="40,44 220,44 130,180" fill="none" stroke="#000" stroke-width="2"/>
<text x="28" y="40" font-size="15" font-style="italic">L</text>
<text x="224" y="40" font-size="15" font-style="italic">M</text>
<text x="130" y="196" font-size="15" text-anchor="middle" font-style="italic">K</text>
<text x="130" y="34" font-size="13" text-anchor="middle">16 cm</text>
</svg>"""

# uloha 14: dva pravidelne ctyrboke hranoly (vyssi a nizsi), rozdil vysek ?
SVG14 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 210" font-family="sans-serif">
<text x="92" y="20" font-size="13" text-anchor="middle">1. hranol</text>
<text x="272" y="20" font-size="13" text-anchor="middle">2. hranol</text>
<rect x="62" y="50" width="46" height="120" fill="#dcdcdc" stroke="#000"/>
<polygon points="62,50 80,36 126,36 108,50" fill="#eeeeee" stroke="#000"/>
<polygon points="108,50 126,36 126,156 108,170" fill="#cccccc" stroke="#000"/>
<rect x="242" y="110" width="46" height="60" fill="#dcdcdc" stroke="#000"/>
<polygon points="242,110 260,96 306,96 288,110" fill="#eeeeee" stroke="#000"/>
<polygon points="288,110 306,96 306,156 288,170" fill="#cccccc" stroke="#000"/>
<text x="85" y="188" font-size="13" text-anchor="middle" font-style="italic">a</text>
<text x="265" y="188" font-size="13" text-anchor="middle" font-style="italic">a</text>
<text x="314" y="140" font-size="13" font-style="italic">a</text>
<line x1="150" y1="36" x2="150" y2="96" stroke="#000" stroke-dasharray="3 3"/>
<text x="158" y="72" font-size="15">?</text>
</svg>"""

# uloha 15: zakladni kvadr a tri prostorova telesa A, B, C (schematicka poznamka)
SVG15 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 120" font-family="sans-serif">
<text x="240" y="52" font-size="13" text-anchor="middle">Zakladni kvadr 2 cm × 1 cm × 1 cm; telesa A, B, C slozena z nekolika kvadru (viz testovy sesit).</text>
<text x="240" y="82" font-size="11" text-anchor="middle" fill="#666">Prostorova telesa nelze verne prenest do SVG; posuzuje se podle originalu.</text>
</svg>"""

B = ['zs2', 'r9']  # 9. rocnik ZS (prijimacky na ctyrlete obory)

PROBLEMS = [
    {'name': 'CERMAT M9A 2026 – úloha 1', 'zad': [
        'Pro čísla $A$, $B$, $C$ platí: $A=\\frac{2}{9}+\\frac{5}{18}$; $B=\\frac{2}{9}:\\frac{5}{18}$; číslo $C$ je aritmetický průměr čísel $A$ a $B$.',
        'Zapište zlomkem v základním tvaru:',
        '1.1 číslo $A$,',
        '1.2 číslo $B$,',
        '1.3 číslo $C$.'],
     'opts': None, 'ln': 3,
     'sol': ['1.1 $A=\\frac{2}{9}+\\frac{5}{18}=\\frac{4}{18}+\\frac{5}{18}=\\frac{9}{18}=\\frac{1}{2}$.',
             '1.2 $B=\\frac{2}{9}:\\frac{5}{18}=\\frac{2}{9}\\cdot\\frac{18}{5}=\\frac{36}{45}=\\frac{4}{5}$.',
             '1.3 $C=\\frac{1}{2}\\left(\\frac{1}{2}+\\frac{4}{5}\\right)=\\frac{1}{2}\\cdot\\frac{13}{10}=\\frac{13}{20}$.'],
     'ans': '1.1: $A=\\frac{1}{2}$; 1.2: $B=\\frac{4}{5}$; 1.3: $C=\\frac{13}{20}$', 'pts': 3, 'mins': 4, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2026 – úloha 2.1', 'zad': ['Vypočtěte: $(-1{,}5-1)\\cdot(-1{,}5+1)=$'],
     'opts': None, 'ln': 2,
     'sol': ['$(-2{,}5)\\cdot(-0{,}5)=1{,}25$.'], 'ans': '$1{,}25$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2026 – úloha 2.2',
     'zad': ['Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\frac{\\frac{25}{28}\\cdot\\left(-\\frac{2}{5}\\right)}{\\frac{6}{7}:2+1}=$'],
     'opts': None, 'ln': 3,
     'sol': ['Čitatel: $\\frac{25}{28}\\cdot\\left(-\\frac{2}{5}\\right)=-\\frac{50}{140}=-\\frac{5}{14}$. Jmenovatel: $\\frac{6}{7}:2+1=\\frac{3}{7}+1=\\frac{10}{7}$.',
             'Podíl: $-\\frac{5}{14}:\\frac{10}{7}=-\\frac{5}{14}\\cdot\\frac{7}{10}=-\\frac{35}{140}=-\\frac{1}{4}$.'],
     'ans': '$-\\frac{1}{4}$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2026 – úloha 3.1', 'zad': ['Vypočtěte pro $a=7$: $9a^2-6a+1=$'],
     'opts': None, 'ln': 2,
     'sol': ['$9\\cdot 7^2-6\\cdot 7+1=441-42+1=400$. (Také $9a^2-6a+1=(3a-1)^2=(3\\cdot 7-1)^2=20^2=400$.)'],
     'ans': '$400$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2026 – úloha 3.2', 'zad': ['Upravte a rozložte na součin užitím vzorce: $1-2n+2n\\cdot(1-8n)=$'],
     'opts': None, 'ln': 2,
     'sol': ['$1-2n+2n-16n^2=1-16n^2=(1+4n)\\cdot(1-4n)$.'], 'ans': '$(1+4n)\\cdot(1-4n)$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2026 – úloha 3.3', 'zad': ['Upravte na co nejjednodušší tvar bez závorek: $(x+2)\\cdot(1-x)-2x\\cdot\\left(-\\frac{1}{2}\\right)\\cdot x=$'],
     'opts': None, 'ln': 2,
     'sol': ['$(x+2)(1-x)=x+2-x^2-2x=-x^2-x+2$. Dále $-2x\\cdot\\left(-\\frac{1}{2}\\right)\\cdot x=x^2$. Součet: $-x^2-x+2+x^2=2-x$.'],
     'ans': '$2-x$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2026 – úloha 4.1', 'zad': ['Řešte rovnici: $0{,}5-(5-x)\\cdot 0{,}5=0{,}5\\cdot(1-9x)$'],
     'opts': None, 'ln': 4,
     'sol': ['Vynásobíme dvěma: $1-(5-x)=1-9x$, tj. $1-5+x=1-9x$, $-4+x=1-9x$, $10x=5$, tedy $x=0{,}5$.'],
     'ans': '$x=0{,}5$', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2026 – úloha 4.2', 'zad': ['Řešte soustavu rovnic: $3x-y=11$; $3x+2y=-4$.'],
     'opts': None, 'ln': 4,
     'sol': ['Odečtením první rovnice od druhé: $3y=-15$, tj. $y=-5$. Dosazením do první: $3x-(-5)=11$, $3x=6$, $x=2$.'],
     'ans': '$x=2$; $y=-5$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2026 – úloha 5', 'zad': [
        'Větší sud má o třetinu větší objem než menší sud. Objem většího sudu je $360$ litrů.',
        'Vypočtěte v litrech objem menšího sudu.'],
     'opts': None, 'ln': 3,
     'sol': ['Větší sud má objem $\\frac{4}{3}$ objemu menšího sudu: $\\frac{4}{3}\\cdot V=360$, tedy $V=360\\cdot\\frac{3}{4}=270$ litrů.'],
     'ans': '$270$ litrů', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9A 2026 – úloha 6', 'zad': [
        'Cyklostezka začíná u nádraží a končí u chaty. Petr vyjel od nádraží po této cyklostezce, ujel dvě třetiny její délky a zastavil u stánku s občerstvením. Tam zjistil, že ztratil telefon. Našel ho, až když se vrátil o čtvrtinu vzdálenosti, kterou předtím ujel od nádraží ke stánku. Pak pokračoval po cyklostezce až k chatě. Délku celé cyklostezky označíme $x$.',
        '6.1 Vyjádřete výrazem s proměnnou $x$ délku cyklostezky mezi stánkem a chatou.',
        '6.2 Vyjádřete výrazem s proměnnou $x$ délku cyklostezky mezi stánkem a místem, kde Petr našel svůj telefon.',
        '6.3 Ve chvíli, kdy našel svůj telefon, zbývalo Petrovi k chatě ještě $24$ km. Vypočtěte, kolik km Petr celkem najezdil, než se dostal od nádraží k chatě.'],
     'opts': None, 'ln': 4, 'svg': SVG6, 'fn': 'cyklostezka.svg',
     'alt': 'Úsečka znázorňující cyklostezku od nádraží k chatě, celá délka označená x.', 'cap': 'Výchozí obrázek k úloze 6',
     'sol': ['6.1 Mezi stánkem a chatou zbývá $x-\\frac{2}{3}x=\\frac{1}{3}x=\\frac{x}{3}$.',
             '6.2 Vzdálenost stánku a místa nálezu je čtvrtina úseku nádraží–stánek: $\\frac{1}{4}\\cdot\\frac{2}{3}x=\\frac{x}{6}$.',
             '6.3 Místo nálezu je od nádraží $\\frac{2}{3}x-\\frac{x}{6}=\\frac{x}{2}$; k chatě odtud zbývá $x-\\frac{x}{2}=\\frac{x}{2}=24$ km, tedy $x=48$ km. Petr najezdil $\\frac{2}{3}x+\\frac{x}{6}+\\frac{x}{2}=32+8+24=64$ km.'],
     'ans': '6.1: $\\frac{x}{3}$; 6.2: $\\frac{x}{6}$; 6.3: $64$ km', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9A 2026 – úloha 7', 'zad': [
        'Adam běžel 10kilometrový okruh stálým tempem a uběhl jej za $50$ minut. Bára běžela pouze 9kilometrový okruh rovněž stálým tempem (jiným než Adam). Adam i Bára vyběhli ve stejném okamžiku a po $30$ minutách běhu jim oběma zbývala do cíle stejná vzdálenost.',
        '7.1 Vypočtěte, kolik km uběhla Bára za $30$ minut.',
        '7.2 Vypočtěte, za kolik minut uběhla svůj okruh Bára.'],
     'opts': None, 'ln': 3,
     'sol': ['7.1 Adam běží $\\frac{10}{50}=0{,}2$ km/min, za $30$ min uběhne $6$ km a zbývají mu $4$ km. Stejně tak Báře zbývají $4$ km, uběhla tedy $9-4=5$ km.',
             '7.2 Bára běží $\\frac{5}{30}=\\frac{1}{6}$ km/min; celý okruh $9$ km uběhne za $9:\\frac{1}{6}=54$ minut.'],
     'ans': '7.1: $5$ km; 7.2: $54$ minut', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'fyzika']},

    {'name': 'CERMAT M9A 2026 – úloha 8', 'zad': [
        'Na obrázku je trojúhelník $ABC$. Přímka $o$ je osou jeho vnitřního úhlu při vrcholu $B$. Přímka $q$ prochází vrcholem $C$ a je kolmá ke straně $AB$ tohoto trojúhelníku. Na straně $AB$ leží střed $S$ kružnice $k$ opsané trojúhelníku $ABC$. Velikosti některých úhlů jsou uvedeny v obrázku.',
        'Vypočtěte ve stupních velikost úhlu:',
        '8.1 $\\varphi$,',
        '8.2 $\\alpha$.',
        'Velikosti úhlů neměřte, ale vypočtěte (obrázek je pouze ilustrativní).'],
     'opts': None, 'ln': 2, 'svg': SVG8, 'fn': 'kruznice-opsana.svg',
     'alt': 'Trojúhelník ABC vepsaný do kružnice k se středem S na straně AB (průměr), přímka q kolmá k AB ve vrcholu C, osa o vnitřního úhlu při B, vyznačené úhly 100°, φ a α.',
     'cap': 'Schematický nákres k úloze 8 (obrázek je pouze ilustrativní)',
     'sol': ['Střed $S$ kružnice opsané leží na straně $AB$, proto je $AB$ průměr a podle Thaletovy věty $|\\angle ACB|=90^\\circ$. Přímka $q$ je kolmá ke straně $AB$.',
             '8.1 Přímky $o$ a $q$ svírají úhel $100^\\circ$; protože $q\\perp AB$, svírá osa $o$ se stranou $AB$ úhel $\\varphi=100^\\circ-90^\\circ=10^\\circ$.',
             '8.2 Osa $o$ půlí vnitřní úhel při vrcholu $B$, takže $|\\angle ABC|=2\\varphi=20^\\circ$. V pravoúhlém trojúhelníku pak $\\alpha=90^\\circ-20^\\circ=70^\\circ$.'],
     'ans': '8.1: $\\varphi=10^\\circ$; 8.2: $\\alpha=70^\\circ$', 'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2026 – úloha 9 (konstrukce)', 'zad': [
        'V rovině leží bod $A$ a přímky $b$, $c$ (viz obrázek).',
        'Bod $A$ je vrchol trojúhelníku $ABC$. Strana $AB$ tohoto trojúhelníku je kolmá k přímce $b$ a vrchol $B$ leží na přímce $b$. Strana $BC$ je o $2$ cm delší než strana $AB$ a vrchol $C$ leží na přímce $c$.',
        'Sestrojte vrcholy $B$, $C$ trojúhelníku $ABC$, označte je písmeny a trojúhelník narýsujte. Najděte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG9, 'fn': 'primky-bc.svg',
     'alt': 'Bod A a dvě různoběžné přímky b a c.', 'cap': 'Výchozí obrázek k úloze 9',
     'sol': ['Vrchol $B$ je pata kolmice spuštěné z bodu $A$ na přímku $b$ (protože $AB\\perp b$ a $B$ leží na $b$). Délka $|AB|$ je tím dána.',
             'Vrchol $C$ leží na přímce $c$ a zároveň na kružnici se středem $B$ a poloměrem $|BC|=|AB|+2$ cm. Průsečíky této kružnice s přímkou $c$ dávají dvě řešení $C_1$, $C_2$.'],
     'ans': 'Dvě řešení: $B$ je pata kolmice z bodu $A$ na přímku $b$; $C$ je průsečík přímky $c$ s kružnicí se středem $B$ a poloměrem $|AB|+2$ cm (body $C_1$, $C_2$) – viz obrázek v klíči.',
     'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2026 – úloha 10 (konstrukce)', 'zad': [
        'V rovině leží bod $A$ a přímka $o$ (viz obrázek).',
        'Bod $A$ je vrchol rovnoběžníku $ABCD$. Přímka $o$ je osou souměrnosti tohoto rovnoběžníku a leží na ní vrcholy $B$, $D$. Úhlopříčka $BD$ rovnoběžníku $ABCD$ je dvakrát delší než úhlopříčka $AC$.',
        'Sestrojte vrcholy $B$, $C$, $D$ rovnoběžníku $ABCD$, označte je písmeny a rovnoběžník narýsujte.'],
     'opts': None, 'ln': 0, 'svg': SVG10, 'fn': 'primka-o.svg',
     'alt': 'Bod A a přímka o.', 'cap': 'Výchozí obrázek k úloze 10',
     'sol': ['Protože osa souměrnosti $o$ prochází vrcholy $B$, $D$, je $ABCD$ kosočtverec; úhlopříčka $BD$ leží na $o$ a úhlopříčka $AC$ je na ni kolmá. Vrchol $C$ je obrazem bodu $A$ v osové souměrnosti podle přímky $o$; střed $O$ (průsečík úhlopříček) je pata kolmice z $A$ na $o$.',
             'Platí $|AC|=2\\cdot|AO|$ a $|BD|=2\\cdot|AC|$, takže $|OB|=|OD|=\\frac{|BD|}{2}=|AC|$. Body $B$, $D$ tedy leží na přímce $o$ ve vzdálenosti $|AC|$ od bodu $O$ na obě strany.'],
     'ans': 'Vrchol $C$ je obraz bodu $A$ v osové souměrnosti podle $o$; střed $O$ je pata kolmice z $A$ na $o$. Body $B$, $D$ leží na $o$ ve vzdálenosti $|AC|$ od $O$ na obě strany (protože $|BD|=2\\cdot|AC|$). $ABCD$ je kosočtverec – viz obrázek v klíči.',
     'pts': 2, 'mins': 5, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2026 – úloha 11', 'zad': [
        'Náklad na lodi se skládá pouze ze čtyř druhů zboží – rýže, cukru, kávy a banánů. Loď veze $36$ tun banánů a $36$ tun kávy. Diagram udává, jaký podíl na celkové hmotnosti nákladu mají jednotlivé druhy zboží (rýže $35\\,\\%$, cukr $25\\,\\%$).',
        'Rozhodněte o každém z následujících tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).',
        '11.1 Káva a banány tvoří dohromady dvě pětiny celkové hmotnosti nákladu.',
        '11.2 Poměr hmotnosti kávy ku hmotnosti rýže je $4:7$.',
        '11.3 Loď veze $63$ tun rýže.'],
     'opts': None, 'ln': 0, 'svg': SVG11, 'fn': 'diagram-naklad.svg',
     'alt': 'Kruhový diagram podílu druhů zboží na hmotnosti nákladu: rýže 35 % (šrafovaný díl), cukr 25 %, dále díly pro kávu a banány.',
     'cap': 'Podíl druhů zboží na hmotnosti nákladu',
     'sol': ['Z diagramu rýže $35\\,\\%$, cukr $25\\,\\%$; na kávu a banány zbývá $100-35-25=40\\,\\%$. Kávy i banánů je stejně ($36$ t), proto káva $=$ banány $=20\\,\\%$. Z $20\\,\\%=36$ t plyne celková hmotnost $180$ t.',
             '11.1 Káva + banány $=72$ t $=\\frac{2}{5}\\cdot 180$ t → pravdivé (A).',
             '11.2 Rýže $=35\\,\\%$ z $180$ t $=63$ t; $36:63=4:7$ → pravdivé (A).',
             '11.3 Rýže $=63$ t → pravdivé (A).'],
     'ans': '11.1: A (Ano); 11.2: A (Ano); 11.3: A (Ano)', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['statistika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9A 2026 – úloha 12', 'zad': [
        'Na parkovišti je $15$ míst vyhrazeno pro zásobování. Zatímco loni tato místa představovala jednu dvacetinu celkové kapacity parkoviště, letos díky rozšíření parkoviště představují tato místa pouze $4\\,\\%$ celkové kapacity.',
        'O kolik parkovacích míst se díky rozšíření parkoviště zvětšila jeho celková kapacita?'],
     'opts': ['A) o $25$ míst', 'B) o $50$ míst', 'C) o $75$ míst', 'D) o $125$ míst', 'E) o jiný počet míst'], 'ln': 0,
     'sol': ['Loni: $15$ míst $=\\frac{1}{20}$ kapacity, tedy kapacita $15\\cdot 20=300$ míst. Letos: $15$ míst $=4\\,\\%$ kapacity, tedy kapacita $\\frac{15}{0{,}04}=375$ míst. Zvětšení o $375-300=75$ míst.'],
     'ans': 'C) o $75$ míst', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9A 2026 – úloha 13', 'zad': [
        'Rovnoramenný trojúhelník $KLM$ se základnou $LM$ délky $16$ cm má obvod $50$ cm.',
        'Jaký je obsah trojúhelníku $KLM$?'],
     'opts': ['A) $120$ cm²', 'B) $136$ cm²', 'C) $240$ cm²', 'D) $272$ cm²', 'E) jiný obsah'], 'ln': 0,
     'svg': SVG13, 'fn': 'trojuhelnik-klm.svg',
     'alt': 'Rovnoramenný trojúhelník KLM se základnou LM délky 16 cm nahoře a vrcholem K dole.', 'cap': 'Výchozí obrázek k úloze 13',
     'sol': ['Ramena: $|KL|=|KM|=\\frac{50-16}{2}=17$ cm. Výška na základnu: $v=\\sqrt{17^2-8^2}=\\sqrt{289-64}=\\sqrt{225}=15$ cm. Obsah $S=\\frac{1}{2}\\cdot 16\\cdot 15=120$ cm².'],
     'ans': 'A) $120$ cm²', 'pts': 2, 'mins': 4, 'diff': '2',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2026 – úloha 14', 'zad': [
        'První i druhý pravidelný čtyřboký hranol mají podstavnou hranu délky $a=3$ cm. První hranol má o $72$ cm² větší povrch než druhý hranol.',
        'O kolik cm se liší výšky obou hranolů?'],
     'opts': ['A) o $8$ cm', 'B) o $6$ cm', 'C) o $5$ cm', 'D) o $4$ cm', 'E) o $3$ cm'], 'ln': 0,
     'svg': SVG14, 'fn': 'hranoly.svg',
     'alt': 'Dva pravidelné čtyřboké hranoly se stejnou podstavnou hranou a; první je vyšší, rozdíl výšek je označen otazníkem.', 'cap': 'Schematický nákres dvou hranolů',
     'sol': ['Povrch pravidelného čtyřbokého (čtvercového) hranolu: $S=2a^2+4a\\cdot v$. Rozdíl povrchů závisí jen na výškách: $4a\\cdot v_1-4a\\cdot v_2=4\\cdot 3\\cdot(v_1-v_2)=12\\cdot(v_1-v_2)=72$, tedy $v_1-v_2=6$ cm.'],
     'ans': 'B) o $6$ cm', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['stereometrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2026 – úloha 15', 'zad': [
        'Na podložce stojí základní kvádr o rozměrech $2$ cm, $1$ cm a $1$ cm a další tři tělesa $A$, $B$, $C$, která jsme postavili z několika základních kvádrů (viz obrázek).',
        'Přiřaďte ke každé otázce (15.1–15.3) správnou odpověď (A–F).',
        '15.1 O kolik procent větší je objem tělesa $B$ než objem tělesa $A$?',
        '15.2 O kolik procent menší je objem tělesa $B$ než objem tělesa $C$?',
        '15.3 Ze základního kvádru odřízneme část, která přesně zaplní otvor uvnitř tělesa $C$. O kolik procent se zvětší objem tělesa $C$ zaplněním otvoru touto částí?'],
     'opts': ['A) o $10\\,\\%$', 'B) o $25\\,\\%$', 'C) o $33\\,\\%$', 'D) o $40\\,\\%$', 'E) o $50\\,\\%$', 'F) o více než $50\\,\\%$'], 'ln': 0,
     'svg': SVG15, 'fn': 'telesa-abc.svg',
     'alt': 'Základní kvádr 2 cm krát 1 cm krát 1 cm a tři prostorová tělesa A, B, C složená ze základních kvádrů.',
     'cap': 'Prostorová tělesa – schematický nákres (viz testový sešit)',
     'sol': ['Základní kvádr má objem $2\\cdot 1\\cdot 1=2$ cm³. Těleso $A$ je složeno ze $2$ kvádrů ($4$ cm³), těleso $B$ ze $3$ kvádrů ($6$ cm³) a těleso $C$ z $5$ kvádrů ($10$ cm³).',
             '15.1 $\\frac{6-4}{4}=\\frac{1}{2}=50\\,\\%$ → E.',
             '15.2 $\\frac{10-6}{10}=\\frac{2}{5}=40\\,\\%$ → D.',
             '15.3 Otvor uvnitř tělesa $C$ má objem $1$ cm³; zaplněním se objem zvětší o $\\frac{1}{10}=10\\,\\%$ → A.'],
     'ans': '15.1: E (o $50\\,\\%$); 15.2: D (o $40\\,\\%$); 15.3: A (o $10\\,\\%$)', 'pts': 6, 'mins': 8, 'diff': '4',
     'codes': B + ['stereometrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2026 – úloha 16', 'zad': [
        'Po spuštění automatu začali dva roboti Jas a Dok plnit prázdnou nádobu míčky a třetí robot Pat začal míčky odebírat. Jas dal do nádoby v každé sekundě $1$ míček, Dok dal do nádoby v každé druhé sekundě $2$ míčky najednou a Pat v každé páté sekundě z nádoby $5$ míčků najednou odebral.',
        '16.1 Určete počet míčků v nádobě na konci 14. sekundy po spuštění automatu.',
        '16.2 Určete, v kolikáté sekundě po spuštění počet míčků v nádobě poprvé překročil $30$.',
        '16.3 V některých sekundách se oproti předchozí sekundě změnil počet míčků v nádobě celkem o $3$. Určete počet míčků v nádobě v okamžiku, kdy k této změně došlo právě po třicáté.'],
     'opts': None, 'ln': 4,
     'sol': ['Za každou sekundu přibude $1$ míček (Jas), v každé sudé sekundě navíc $2$ (Dok) a v každé páté sekundě $5$ ubude (Pat). Počet míčků po $n$-té sekundě je $n+2\\cdot\\left\\lfloor\\frac{n}{2}\\right\\rfloor-5\\cdot\\left\\lfloor\\frac{n}{5}\\right\\rfloor$.',
             '16.1 Po 14. sekundě: $14+2\\cdot 7-5\\cdot 2=14+14-10=18$ míčků.',
             '16.2 Postupným sčítáním počet poprvé překročí $30$ na konci 28. sekundy (je tam $31$ míčků).',
             '16.3 Změna o $+3$ nastává právě v sudých sekundách, které nejsou dělitelné pěti. Třicátá taková sekunda je 74. sekunda; počet míčků je $74+2\\cdot 37-5\\cdot 14=74+74-70=78$.'],
     'ans': '16.1: $18$ míčků; 16.2: ve $28.$ sekundě; 16.3: $78$ míčků (v $74.$ sekundě)', 'pts': 4, 'mins': 8, 'diff': '4',
     'codes': B + ['posloupnosti', 'modelovani', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M9PAD26C0T01'
    gen.YEAR = 2026

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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M9-2026A')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
