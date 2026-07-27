# -*- coding: utf-8 -*-
# CERMAT – Jednotná přijímací zkouška 2017, MATEMATIKA 9 A, 1. řádný termín (čtyřleté obory).
# Kód testu: M9PAD17C0T01. 16 úloh / 50 bodů (po rozdělení nezávislých podúloh 22 záznamů).
# Zdroj odpovědí: klíč správných řešení (KSR) + záznamový arch (VZA).

# ---- SVG obrázky (bez ' a \) ----

# úloha 6: výchozí tabulka (platby za vodu ve městech A a B)
def _tab6():
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 130" font-family="sans-serif" font-size="13">']
    xs = [20, 110, 330, 500]
    ys = [20, 62, 88, 114]
    s.append('<g stroke="#000" fill="none">')
    for x in xs:
        s.append(f'<line x1="{x}" y1="20" x2="{x}" y2="114"/>')
    for y in ys:
        s.append(f'<line x1="20" y1="{y}" x2="500" y2="{y}"/>')
    s.append('</g>')
    s.append('<text x="65" y="52" text-anchor="middle">Města</text>')
    s.append('<text x="220" y="38" text-anchor="middle">Platba (1x ročně)</text>')
    s.append('<text x="220" y="55" text-anchor="middle">za užívání vodovodní přípojky</text>')
    s.append('<text x="415" y="38" text-anchor="middle">Platba za 1 m³</text>')
    s.append('<text x="415" y="55" text-anchor="middle">spotřebované vody</text>')
    s.append('<text x="65" y="80" text-anchor="middle">A</text><text x="220" y="80" text-anchor="middle">0 Kč</text><text x="415" y="80" text-anchor="middle">72 Kč</text>')
    s.append('<text x="65" y="106" text-anchor="middle">B</text><text x="220" y="106" text-anchor="middle">990 Kč</text><text x="415" y="106" text-anchor="middle">61 Kč</text>')
    s.append('</svg>')
    return "".join(s)
SVG6 = _tab6()

# úloha 8: čtyřúhelník ABCD ze dvou pravoúhlých trojúhelníků (měřítko 20 px = 1 cm)
SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 340 340" font-family="sans-serif">
<g stroke="#000" stroke-width="2" fill="none">
<path d="M60,300 L140,300 L284,108 L60,240 Z"/><line x1="60" y1="240" x2="140" y2="300"/>
</g>
<g stroke="#000" stroke-width="1" fill="none">
<polygon points="60,290 70,290 70,300"/><polygon points="140,300 132,294 138,286 146,292"/>
</g>
<g font-size="15" font-style="italic">
<text x="48" y="318">A</text><text x="136" y="318">B</text><text x="292" y="102">C</text><text x="42" y="238">D</text>
</g>
<g font-size="13">
<text x="8" y="276">3 cm</text><text x="92" y="262">5 cm</text><text x="222" y="196">12 cm</text>
</g>
</svg>"""

# úloha 9: různoběžky o, p a bod L na přímce p
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 280" font-family="sans-serif">
<g stroke="#000" stroke-width="2">
<line x1="60" y1="240" x2="430" y2="240"/><line x1="150" y1="215" x2="400" y2="155"/>
<line x1="395" y1="232" x2="395" y2="248"/>
</g>
<g font-size="15" font-style="italic">
<text x="70" y="262">p</text><text x="408" y="152">o</text><text x="390" y="266">L</text>
</g>
</svg>"""

# úloha 10: body A, B, D v rovině
SVG10 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 430 330" font-family="sans-serif">
<g stroke="#000" stroke-width="2">
<line x1="70" y1="290" x2="182" y2="72"/><line x1="70" y1="290" x2="378" y2="167"/>
<line x1="157" y1="99" x2="175" y2="111"/><line x1="337" y1="176" x2="353" y2="164"/>
</g>
<g font-size="15" font-style="italic">
<text x="52" y="308">A</text><text x="148" y="92">D</text><text x="350" y="196">B</text>
</g>
</svg>"""

# úloha 12: rovnoramenný trojúhelník, vrcholový úhel 112°, úhel delta
SVG12 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 270" font-family="sans-serif">
<g stroke="#000" stroke-width="2" fill="none">
<line x1="105" y1="230" x2="450" y2="230"/><line x1="250" y1="142" x2="450" y2="142"/>
<line x1="120" y1="230" x2="250" y2="142"/><line x1="380" y1="230" x2="250" y2="142"/>
<line x1="410" y1="222" x2="410" y2="238"/><line x1="418" y1="222" x2="418" y2="238"/>
<line x1="410" y1="134" x2="410" y2="150"/><line x1="418" y1="134" x2="418" y2="150"/>
</g>
<g stroke="#000" stroke-width="1" fill="none">
<path d="M215,166 A42,42 0 1 1 292,142"/>
<path d="M228,164 A26,26 0 0 1 272,164"/>
<path d="M148,230 A28,28 0 0 0 141,214"/><path d="M352,230 A28,28 0 0 1 359,214"/>
</g>
<g font-size="16" font-style="italic">
<text x="244" y="92">δ</text><text x="146" y="224">α</text><text x="342" y="224">α</text>
</g>
<text x="250" y="182" font-size="14" text-anchor="middle">112°</text>
</svg>"""

# úloha 13: nádrž tvaru kvádru 1 m x 2 m x 1 m s hladinou vody
SVG13 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 270" font-family="sans-serif">
<polygon points="140,152 250,152 345,94 235,94" fill="#dcdcdc" stroke="none"/>
<g stroke="#000" stroke-width="1" fill="none" stroke-dasharray="5 4">
<line x1="235" y1="172" x2="235" y2="82"/><line x1="235" y1="172" x2="345" y2="172"/><line x1="235" y1="172" x2="140" y2="230"/>
</g>
<g stroke="#000" stroke-width="2" fill="none">
<rect x="140" y="140" width="110" height="90"/>
<path d="M140,140 L235,82 L345,82 L345,172 L250,230"/>
<line x1="250" y1="140" x2="345" y2="82"/>
</g>
<g stroke="#000" stroke-width="1" fill="none">
<line x1="368" y1="82" x2="368" y2="172"/>
<path d="M364,88 L368,80 L372,88" fill="#000"/><path d="M364,166 L368,174 L372,166" fill="#000"/>
</g>
<g font-size="14">
<text x="378" y="132">1 m</text><text x="300" y="212">2 m</text><text x="180" y="252">1 m</text>
</g>
</svg>"""

# úloha 16: trojúhelník + obrácený trojúhelník = kosočtverec (3 řady)
def _tri16():
    s, h = 22, 19
    G, W = '#c9c9c9', '#ffffff'
    out = []
    def poly(pts, fill):
        out.append(f'<polygon points="{pts}" fill="{fill}"/>')
    def up_tri(ax, ay, n):
        for i in range(1, n + 1):
            yt = ay + (i - 1) * h; yb = ay + i * h
            tl = ax - (i - 1) * s // 2; bl = ax - i * s // 2
            for k in range(i):
                poly(f'{tl+k*s},{yt} {bl+k*s},{yb} {bl+(k+1)*s},{yb}', G)
            for k in range(i - 1):
                poly(f'{tl+k*s},{yt} {tl+(k+1)*s},{yt} {bl+(k+1)*s},{yb}', W)
    def dn_tri(ax, ay, n):
        for i in range(1, n + 1):
            yt = ay + (i - 1) * h; yb = ay + i * h
            m = n - i + 1
            tl = ax - m * s // 2; bl = tl + s // 2
            for k in range(m):
                poly(f'{tl+k*s},{yt} {tl+(k+1)*s},{yt} {bl+k*s},{yb}', G)
            for k in range(m - 1):
                poly(f'{bl+k*s},{yb} {bl+(k+1)*s},{yb} {tl+(k+1)*s},{yt}', W)
    def rhomb(x0, y0, n):
        for i in range(1, n + 1):
            yt = y0 + (i - 1) * h; yb = y0 + i * h
            blx = x0 - i * (s // 2); tlx = blx + s // 2
            for m in range(n):
                poly(f'{blx+m*s},{yb} {blx+(m+1)*s},{yb} {tlx+m*s},{yt}', G if m < i else W)
            for m in range(n):
                poly(f'{tlx+m*s},{yt} {tlx+(m+1)*s},{yt} {blx+(m+1)*s},{yb}', W if m < i - 1 else G)
    up_tri(55, 20, 3); dn_tri(165, 20, 3); rhomb(280, 20, 3)
    body = '<g stroke="#000" stroke-width="1">' + "".join(out) + '</g>'
    return ('<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 95" font-family="sans-serif">'
            + body
            + '<g font-size="20" text-anchor="middle"><text x="108" y="58">+</text><text x="228" y="58">=</text></g></svg>')
SVG16 = _tri16()

B = ['zs2', 'r9']

PROBLEMS = [
    {'name': 'CERMAT M9A 2017 – úloha 1', 'zad': ['Vypočtěte, kolikrát větší jsou 4 setiny než 8 tisícin.'],
     'opts': None, 'ln': 2,
     'sol': ['4 setiny $=0{,}04$, 8 tisícin $=0{,}008$.', '$0{,}04:0{,}008=40:8=5$.'],
     'ans': '$5$krát', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2017 – úloha 2.1', 'zad': ['Vypočtěte: $\\sqrt{4\\cdot 0{,}25}=$'],
     'opts': None, 'ln': 2,
     'sol': ['$4\\cdot 0{,}25=1$, tedy $\\sqrt{1}=1$.'],
     'ans': '$1$', 'pts': 1, 'mins': 1, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2017 – úloha 2.2', 'zad': ['Vypočtěte: $1:0{,}2^2=$'],
     'opts': None, 'ln': 2,
     'sol': ['$0{,}2^2=0{,}04$; $1:0{,}04=100:4=25$.'],
     'ans': '$25$', 'pts': 1, 'mins': 1, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2017 – úloha 3.1', 'zad': [
        'Vypočtěte a výsledek zapište zlomkem v základním tvaru. Uveďte celý postup řešení.',
        '$0{,}2:\\frac{27}{25}-\\frac{2}{3}=$'],
     'opts': None, 'ln': 4,
     'sol': ['$0{,}2:\\frac{27}{25}=\\frac{1}{5}\\cdot\\frac{25}{27}=\\frac{5}{27}$.',
             '$\\frac{5}{27}-\\frac{2}{3}=\\frac{5}{27}-\\frac{18}{27}=-\\frac{13}{27}$.'],
     'ans': '$-\\frac{13}{27}$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2017 – úloha 3.2', 'zad': [
        'Vypočtěte a výsledek zapište zlomkem v základním tvaru. Uveďte celý postup řešení.',
        '$\\frac{\\frac{1}{5}-\\frac{3}{10}+\\frac{1}{4}\\cdot 2}{4}=$'],
     'opts': None, 'ln': 4,
     'sol': ['V čitateli: $\\frac{1}{4}\\cdot 2=\\frac{1}{2}$, tedy $\\frac{2}{10}-\\frac{3}{10}+\\frac{5}{10}=\\frac{4}{10}=\\frac{2}{5}$.',
             '$\\frac{2}{5}:4=\\frac{2}{20}=\\frac{1}{10}$.'],
     'ans': '$\\frac{1}{10}$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2017 – úloha 4.1', 'zad': [
        'Zjednodušte. Výsledný výraz nesmí obsahovat závorky. Uveďte celý postup řešení.',
        '$(a+a)\\cdot(1-a)-a\\cdot a=$'],
     'opts': None, 'ln': 4,
     'sol': ['$(a+a)=2a$, tedy $2a\\cdot(1-a)-a^2$.',
             '$2a-2a^2-a^2=2a-3a^2$.'],
     'ans': '$2a-3a^2$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2017 – úloha 4.2', 'zad': [
        'Zjednodušte. Výsledný výraz nesmí obsahovat závorky. Uveďte celý postup řešení.',
        '$\\frac{n-1}{2}-\\frac{2n-3}{4}=$'],
     'opts': None, 'ln': 4,
     'sol': ['Společný jmenovatel je 4: $\\frac{2(n-1)}{4}-\\frac{2n-3}{4}$.',
             '$\\frac{2n-2-2n+3}{4}=\\frac{1}{4}$.'],
     'ans': '$\\frac{1}{4}$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['vyrazy', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2017 – úloha 5.1', 'zad': [
        'Řešte rovnici. Uveďte celý postup řešení (zkoušku nezapisujte).',
        '$-\\frac{2}{3}\\cdot\\frac{x}{2}=\\frac{5}{12}$'],
     'opts': None, 'ln': 4,
     'sol': ['Vlevo zkrátíme: $-\\frac{2x}{6}=-\\frac{x}{3}$, tedy $-\\frac{x}{3}=\\frac{5}{12}$.',
             '$x=-\\frac{15}{12}=-\\frac{5}{4}$.'],
     'ans': '$x=-\\frac{5}{4}$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2017 – úloha 5.2', 'zad': [
        'Řešte rovnici. Uveďte celý postup řešení (zkoušku nezapisujte).',
        '$\\frac{x-2}{2}-x=2-\\frac{2x}{3}$'],
     'opts': None, 'ln': 4,
     'sol': ['Rovnici vynásobíme šesti: $3(x-2)-6x=12-4x$.',
             '$3x-6-6x=12-4x$, tedy $-3x-6=12-4x$.',
             '$-3x+4x=12+6$, tedy $x=18$.'],
     'ans': '$x=18$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2017 – úloha 6', 'zad': [
        'Výpočet ceny, kterou domácnosti zaplatí za vodu, se ve městech A a B liší. Ve městě A je platba za užívání vodovodní přípojky (1x ročně) $0$ Kč a platba za $1$ m³ spotřebované vody $72$ Kč. Ve městě B je platba za užívání vodovodní přípojky (1x ročně) $990$ Kč a platba za $1$ m³ spotřebované vody $61$ Kč.',
        'Celkový počet m³ vody, kterou spotřebuje domácnost za rok, označte $x$.',
        '6.1 V závislosti na veličině $x$ vyjádřete cenu (v Kč), kterou zaplatí za vodu domácnost ve městě A za jeden rok.',
        '6.2 V závislosti na veličině $x$ vyjádřete cenu (v Kč), kterou zaplatí za vodu domácnost ve městě B za jeden rok.',
        '6.3 Vypočtěte, při jaké roční spotřebě vody (v m³) by zaplatila za vodu domácnost v městech A a B stejně.'],
     'opts': None, 'ln': 3, 'svg': SVG6, 'fn': 'tabulka-voda.svg',
     'alt': 'Tabulka plateb za vodu ve městech A a B: roční platba za přípojku a cena za 1 m³ vody.',
     'cap': 'Výchozí tabulka k úloze 6',
     'sol': ['6.1 Město A: pouze spotřeba, tedy $72x$ Kč.',
             '6.2 Město B: paušál a spotřeba, tedy $(61x+990)$ Kč.',
             '6.3 $72x=61x+990$, tedy $11x=990$ a $x=90$ m³.'],
     'ans': '6.1: $72x$ Kč; 6.2: $(61x+990)$ Kč; 6.3: $90$ m³', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['rovnice', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9A 2017 – úloha 7.1', 'zad': [
        'Doplňte do rámečku číslo tak, aby platila rovnost:',
        '$0{,}75$ m² $=25$ cm² $+$ ____ cm²'],
     'opts': None, 'ln': 2,
     'sol': ['$0{,}75$ m² $=0{,}75\\cdot 10\\,000$ cm² $=7\\,500$ cm².', '$7\\,500-25=7\\,475$.'],
     'ans': '$7\\,475$', 'pts': 1, 'mins': 2, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2017 – úloha 7.2', 'zad': [
        'Doplňte do rámečku číslo tak, aby platila rovnost:',
        '$0{,}2$ dm³ $+$ ____ cm³ $=1$ litr'],
     'opts': None, 'ln': 2,
     'sol': ['$1$ litr $=1$ dm³ $=1\\,000$ cm³; $0{,}2$ dm³ $=200$ cm³.', '$1\\,000-200=800$.'],
     'ans': '$800$', 'pts': 1, 'mins': 2, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2017 – úloha 7.3', 'zad': [
        'Doplňte do rámečku číslo tak, aby platila rovnost:',
        '____ $\\cdot\\, 20$ minut $=8\\cdot 0{,}75$ hodiny'],
     'opts': None, 'ln': 2,
     'sol': ['$8\\cdot 0{,}75$ hodiny $=6$ hodin $=360$ minut.', '$360:20=18$.'],
     'ans': '$18$', 'pts': 1, 'mins': 2, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2017 – úloha 8', 'zad': [
        'Čtyřúhelník $ABCD$ je složen ze dvou pravoúhlých trojúhelníků $ABD$ a $BCD$ (pravé úhly jsou u vrcholů $A$ a $B$). Pro délky stran platí: $|AD|=3$ cm, $|BC|=12$ cm, $|BD|=5$ cm.',
        '8.1 Vypočtěte v cm délku strany $AB$.',
        '8.2 Vypočtěte v cm délku strany $CD$.',
        '8.3 Vypočtěte v cm² obsah čtyřúhelníku $ABCD$.'],
     'opts': None, 'ln': 3, 'svg': SVG8, 'fn': 'ctyruhelnik-abcd.svg',
     'alt': 'Čtyřúhelník ABCD složený z pravoúhlých trojúhelníků ABD a BCD s úhlopříčkou BD délky 5 cm.',
     'cap': 'Výchozí obrázek k úloze 8',
     'sol': ['8.1 V pravoúhlém trojúhelníku $ABD$: $|AB|=\\sqrt{5^2-3^2}=\\sqrt{16}=4$ cm.',
             '8.2 V pravoúhlém trojúhelníku $BCD$: $|CD|=\\sqrt{5^2+12^2}=\\sqrt{169}=13$ cm.',
             '8.3 $S=\\frac{3\\cdot 4}{2}+\\frac{5\\cdot 12}{2}=6+30=36$ cm².'],
     'ans': '8.1: $4$ cm; 8.2: $13$ cm; 8.3: $36$ cm²', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2017 – úloha 9', 'zad': [
        'V rovině leží různoběžky $o$, $p$ a bod $L$ na přímce $p$ (viz obrázek).',
        'Bod $L$ je vrchol rovnoramenného trojúhelníku $KLM$, přímka $o$ je osou souměrnosti tohoto trojúhelníku a strana $KL$ leží na přímce $p$.',
        'Sestrojte chybějící vrcholy $K$, $M$ trojúhelníku $KLM$ a trojúhelník narýsujte.'],
     'opts': None, 'ln': 0, 'svg': SVG9, 'fn': 'primky-op-bod-l.svg',
     'alt': 'Dvě různoběžné přímky o a p a bod L ležící na přímce p.',
     'cap': 'Výchozí obrázek k úloze 9',
     'sol': ['Osa souměrnosti trojúhelníku prochází jedním vrcholem; protože $K$ i $L$ leží na přímce $p$ a osa $o$ není kolmá k $p$, musí osa procházet vrcholem $K$.',
             'Vrchol $K$ je tedy průsečík přímek $o$ a $p$.',
             'Vrchol $M$ je obraz bodu $L$ v osové souměrnosti podle přímky $o$ (vedeme kolmici z $L$ k $o$ a naneseme stejnou vzdálenost na druhou stranu).',
             'Trojúhelník $KLM$ je rovnoramenný se základnou $LM$ a $|KL|=|KM|$.'],
     'ans': 'Vrchol $K$ je průsečík přímek $o$ a $p$; vrchol $M$ je obraz bodu $L$ v osové souměrnosti podle přímky $o$. Trojúhelník $KLM$ má rameno $KL$ na přímce $p$ (viz obrázek v klíči správných řešení).',
     'pts': 3, 'mins': 7, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2017 – úloha 10', 'zad': [
        'V rovině leží body $A$, $B$ a $D$ (viz obrázek).',
        'Body $A$, $B$ a $D$ jsou vrcholy pravoúhlého lichoběžníku $ABCD$.',
        'Sestrojte chybějící vrchol $C$ lichoběžníku $ABCD$ a lichoběžník narýsujte.'],
     'opts': None, 'ln': 0, 'svg': SVG10, 'fn': 'body-abd.svg',
     'alt': 'Tři body A, B a D v rovině, body D a B jsou vyznačeny křížkem na polopřímkách vycházejících z bodu A.',
     'cap': 'Výchozí obrázek k úloze 10',
     'sol': ['V lichoběžníku $ABCD$ jsou rovnoběžné strany $AB$ a $CD$.',
             'Bodem $D$ vedeme rovnoběžku se stranou $AB$.',
             'V bodě $B$ vztyčíme kolmici ke straně $AB$ (lichoběžník je pravoúhlý, pravé úhly jsou u vrcholů $B$ a $C$).',
             'Vrchol $C$ je průsečík této kolmice s rovnoběžkou vedenou bodem $D$.'],
     'ans': 'Vrchol $C$ je průsečík kolmice ke straně $AB$ vztyčené v bodě $B$ s rovnoběžkou se stranou $AB$ vedenou bodem $D$ (viz obrázek v klíči správných řešení).',
     'pts': 2, 'mins': 5, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2017 – úloha 11', 'zad': [
        'Maminka, tatínek, Ema a Ota váží dohromady $210$ kg. Maminka s tatínkem dohromady váží dvakrát více než Ema s Otou dohromady. Ota váží $45$ kg a maminka váží o pětinu více než Ota.',
        'Rozhodněte o každém z následujících tvrzení (11.1–11.3), zda je pravdivé (Ano), či nikoli (Ne).',
        '11.1 Ema s Otou váží dohromady $70$ kg.',
        '11.2 Maminka váží o $20$ kg více než Ema.',
        '11.3 Tatínek váží $86$ kg.'],
     'opts': None, 'ln': 0,
     'sol': ['Označme hmotnost dětí $d$; pak rodiče váží $2d$ a $d+2d=210$, tedy $d=70$ kg a rodiče $140$ kg.',
             '11.1 Ema s Otou váží $70$ kg → Ano.',
             'Ema váží $70-45=25$ kg. Maminka váží $45+\\frac{45}{5}=45+9=54$ kg.',
             '11.2 $54-25=29$ kg, ne $20$ kg → Ne.',
             '11.3 Tatínek váží $140-54=86$ kg → Ano.'],
     'ans': '11.1: Ano; 11.2: Ne; 11.3: Ano', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['rovnice', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9A 2017 – úloha 12', 'zad': [
        'V obrázku je rovnoramenný trojúhelník s vrcholovým úhlem o velikosti $112^\\circ$ a s úhly $\\alpha$ při základně. Vrcholem trojúhelníku prochází polopřímka rovnoběžná se základnou; úhel $\\delta$ je vyznačen v obrázku.',
        'Jaká je velikost úhlu $\\delta$? Úhly neměřte, ale vypočtěte.'],
     'opts': ['A) $192^\\circ$', 'B) $214^\\circ$', 'C) $236^\\circ$', 'D) $248^\\circ$', 'E) jiná velikost'],
     'ln': 0, 'svg': SVG12, 'fn': 'uhel-delta.svg',
     'alt': 'Rovnoramenný trojúhelník s úhlem 112 stupňů u vrcholu, s úhly alfa při základně a s vyznačeným úhlem delta u vrcholu.',
     'cap': 'Výchozí obrázek k úloze 12',
     'sol': ['Úhly při základně: $\\alpha=\\frac{180^\\circ-112^\\circ}{2}=34^\\circ$.',
             'Polopřímka vrcholem je rovnoběžná se základnou, proto úhel mezi ní a ramenem je střídavý úhel k $\\alpha$, tedy $34^\\circ$.',
             '$\\delta=360^\\circ-112^\\circ-34^\\circ=214^\\circ$.'],
     'ans': 'B) $214^\\circ$', 'pts': 2, 'mins': 4, 'diff': '4',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9A 2017 – úloha 13', 'zad': [
        'Nádrž s vodou má tvar kvádru o rozměrech $1$ m, $2$ m a $1$ m (viz obrázek). Zahrádkář naplnil vodou z nádrže 15 prázdných dvanáctilitrových konví, a hladina vody v nádrži tak klesla.',
        'O kolik cm klesla hladina vody v nádrži?'],
     'opts': ['A) o méně než $9$ cm', 'B) o $9$ cm', 'C) o $10$ cm', 'D) o $11$ cm', 'E) o více než $11$ cm'],
     'ln': 0, 'svg': SVG13, 'fn': 'nadrz-kvadr.svg',
     'alt': 'Nádrž tvaru kvádru s rozměry 1 m, 2 m a 1 m a se znázorněnou hladinou vody.',
     'cap': 'Výchozí obrázek k úloze 13',
     'sol': ['Odebraný objem: $15\\cdot 12=180$ litrů $=180$ dm³ $=0{,}18$ m³.',
             'Obsah dna nádrže: $1\\cdot 2=2$ m².',
             'Pokles hladiny: $0{,}18:2=0{,}09$ m $=9$ cm.'],
     'ans': 'B) o $9$ cm', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['stereometrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9A 2017 – úloha 14', 'zad': [
        'V lahvi je $1{,}5$ litru minerálky. Všechnu minerálku z lahve přelijeme do prázdných skleniček o objemu $\\frac{1}{3}$ litru. Kromě poslední skleničky budou všechny ostatní skleničky naplněné po okraj.',
        'Jakou část objemu poslední skleničky vyplní zbytek minerálky?'],
     'opts': ['A) $\\frac{1}{2}$', 'B) $\\frac{1}{3}$', 'C) $\\frac{1}{5}$', 'D) $\\frac{2}{3}$', 'E) jinou část'],
     'ln': 0,
     'sol': ['$1{,}5:\\frac{1}{3}=1{,}5\\cdot 3=4{,}5$.',
             'Plných skleniček je 4 a zbývá $1{,}5-4\\cdot\\frac{1}{3}=1{,}5-\\frac{4}{3}=\\frac{1}{6}$ litru.',
             '$\\frac{1}{6}:\\frac{1}{3}=\\frac{1}{2}$, tedy polovina objemu poslední skleničky.'],
     'ans': 'A) $\\frac{1}{2}$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9A 2017 – úloha 15', 'zad': [
        'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).',
        '15.1 Celkem $70\\,\\%$ z $520$ důchodců používá kartu do bankomatu. Kolik důchodců nepoužívá kartu do bankomatu?',
        '15.2 Do oddílu přibyli 3 noví členové a počet členů se tak zvýšil o $2\\,\\%$. Kolik členů má nyní oddíl?',
        '15.3 Ve sportovním gymnáziu hraje $20\\,\\%$ chlapců hokej a zbývajících $192$ chlapců florbal. Chlapci tvoří $60\\,\\%$ všech žáků tohoto gymnázia. Kolik dívek navštěvuje sportovní gymnázium?'],
     'opts': ['A) méně než $151$', 'B) $151$', 'C) $153$', 'D) $156$', 'E) $160$', 'F) více než $160$'],
     'ln': 0,
     'sol': ['15.1 Kartu nepoužívá $30\\,\\%$ z $520$, tedy $0{,}3\\cdot 520=156$ → D.',
             '15.2 $2\\,\\%$ původního počtu jsou 3 členové, původně tedy $150$ členů; nyní $150+3=153$ → C.',
             '15.3 $192$ chlapců je $80\\,\\%$ chlapců, chlapců je $192:0{,}8=240$. To je $60\\,\\%$ žáků, žáků je $240:0{,}6=400$. Dívek je $400-240=160$ → E.'],
     'ans': '15.1: D ($156$); 15.2: C ($153$); 15.3: E ($160$)', 'pts': 6, 'mins': 8, 'diff': '3',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9A 2017 – úloha 16', 'zad': [
        'V rovnostranném trojúhelníku se v jednotlivých řadách pravidelně střídají tmavé a bílé shodné trojúhelníčky. Ze dvou shodných trojúhelníků (jednoho postaveného a jednoho obráceného) je vytvořen kosočtverec. Obdobným způsobem lze z větších trojúhelníků vytvořit kosočtverec s větším počtem řad.',
        '16.1 Kosočtverec má v každé řadě 4 bílé trojúhelníčky. Určete počet tmavých trojúhelníčků v kosočtverci.',
        '16.2 Kosočtverec má v každé řadě 6 tmavých trojúhelníčků. Určete počet všech trojúhelníčků (bílých i tmavých) v kosočtverci.',
        '16.3 Kosočtverec má v každé řadě 21 tmavých trojúhelníčků. Určete počet všech trojúhelníčků (bílých i tmavých) v kosočtverci.'],
     'opts': None, 'ln': 3, 'svg': SVG16, 'fn': 'kosoctverec-trojuhelnicky.svg',
     'alt': 'Rovnostranný trojúhelník o třech řadách a obrácený trojúhelník tvoří kosočtverec o třech řadách po šesti trojúhelníčcích.',
     'cap': 'Vznik kosočtverce ze dvou shodných trojúhelníků (3 řady)',
     'sol': ['Kosočtverec o $n$ řadách má v každé řadě $2n$ trojúhelníčků: $n+1$ tmavých a $n-1$ bílých. Celkem má $2n^2$ trojúhelníčků.',
             '16.1 $n-1=4$, tedy $n=5$; tmavých je $n\\cdot(n+1)=5\\cdot 6=30$.',
             '16.2 $n+1=6$, tedy $n=5$; všech je $2\\cdot 5^2=50$.',
             '16.3 $n+1=21$, tedy $n=20$; všech je $2\\cdot 20^2=800$.'],
     'ans': '16.1: $30$ tmavých; 16.2: $50$ trojúhelníčků; 16.3: $800$ trojúhelníčků',
     'pts': 4, 'mins': 8, 'diff': '4',
     'codes': B + ['posloupnosti', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M9PAD17C0T01'
    gen.YEAR = 2017

    def dollars_ok(s): return s.count('$') % 2 == 0
    errors = []; names = set()
    for p in PROBLEMS:
        if p['name'] in names: errors.append('DUP název: ' + p['name'])
        names.add(p['name'])
        if not p['name'].startswith('CERMAT M9A 2017 – úloha '): errors.append('Špatný prefix: ' + p['name'])
        for t in [p['name'], p['ans']] + list(p['zad']) + list(p['sol']) + (p.get('opts') or []):
            if not dollars_ok(t): errors.append('Nepárový $: ' + t[:70])
        if p.get('svg') and ("'" in p['svg'] or '\\' in p['svg']):
            errors.append('SVG zakázaný znak: ' + p['name'])
        if p.get('svg') and not p.get('alt'): errors.append('Obrázek bez alt: ' + p['name'])
        for lbl, obj in (('content', gen.py_content_json(p)), ('solution', gen.py_solution_json(p)), ('answer', gen.py_answer_json(p))):
            try: json.loads(json.dumps(obj, ensure_ascii=False))
            except Exception as e: errors.append(f'JSON {lbl} {p["name"]}: {e}')
    tot_pts = sum(p['pts'] for p in PROBLEMS)
    if tot_pts != 50: errors.append(f'Součet bodů je {tot_pts}, má být 50')
    if errors:
        print('CHYBY:'); [print('  -', e) for e in errors]; sys.exit(1)
    print('Validace OK:', len(PROBLEMS), 'úloh, body celkem:', tot_pts)
    outdir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'out')
    os.makedirs(outdir, exist_ok=True)
    tot = 0
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M9A-2017')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
