# -*- coding: utf-8 -*-
# CERMAT – Jednotná přijímací zkouška 2022, MATEMATIKA 7 (šestileté obory, 7. ročník), 2. řádný termín, varianta B.
# Kód testu: M7PBD22C0T02. 16 úloh (po rozdělení izolovaných poduúloh 19 úloh).
# Zdroj odpovědí: klíč správných řešení (KSR); uzavřené úlohy ověřeny dle záznamového archu (VZA).

# ---- SVG obrázky (bez ' a \) ----

# úloha 6: tabulka prodeje pšenice a ječmene (loni / letos)
SVG6 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 510 172" font-family="sans-serif" font-size="13">
<rect x="10" y="10" width="488" height="150" fill="none" stroke="#000"/>
<line x1="106" y1="10" x2="106" y2="160" stroke="#000"/>
<line x1="302" y1="10" x2="302" y2="160" stroke="#000"/>
<line x1="204" y1="44" x2="204" y2="160" stroke="#000"/>
<line x1="400" y1="44" x2="400" y2="160" stroke="#000"/>
<line x1="106" y1="44" x2="498" y2="44" stroke="#000"/>
<line x1="10" y1="92" x2="498" y2="92" stroke="#000"/>
<line x1="10" y1="126" x2="498" y2="126" stroke="#000"/>
<text x="204" y="32" text-anchor="middle">Loni</text>
<text x="400" y="32" text-anchor="middle">Letos</text>
<text x="155" y="64" text-anchor="middle">hmotnost</text>
<text x="155" y="80" text-anchor="middle">v tunách</text>
<text x="253" y="64" text-anchor="middle">cena v Kč</text>
<text x="253" y="80" text-anchor="middle">za tunu</text>
<text x="351" y="64" text-anchor="middle">hmotnost</text>
<text x="351" y="80" text-anchor="middle">v tunách</text>
<text x="449" y="64" text-anchor="middle">cena v Kč</text>
<text x="449" y="80" text-anchor="middle">za tunu</text>
<text x="16" y="112">Pšenice</text>
<text x="155" y="112" text-anchor="middle">200</text>
<text x="449" y="112" text-anchor="middle">5 800</text>
<text x="16" y="146">Ječmen</text>
<text x="155" y="146" text-anchor="middle">90</text>
<text x="253" y="146" text-anchor="middle">4 200</text>
<text x="449" y="146" text-anchor="middle">4 800</text>
</svg>"""

# úloha 7: hlava robota – velká krychle + 7 malých krychlí (schematicky)
def _cube(x, y, s, fill):
    d = int(s * 0.36)
    return (f'<polygon points="{x},{y} {x+d},{y-d} {x+s+d},{y-d} {x+s},{y}" fill="#eeeeee" stroke="#000"/>'
            f'<polygon points="{x+s},{y} {x+s+d},{y-d} {x+s+d},{y+s-d} {x+s},{y+s}" fill="#d5d5d5" stroke="#000"/>'
            f'<rect x="{x}" y="{y}" width="{s}" height="{s}" fill="{fill}" stroke="#000"/>')

def _robot():
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 300" font-family="sans-serif" font-size="12">']
    s.append(_cube(200, 100, 140, '#f5f5f5'))
    for (x, y) in [(150, 150), (150, 104), (252, 52), (250, 172), (392, 112), (392, 164), (252, 252)]:
        s.append(_cube(x, y, 26, '#a9a9a9'))
    s.append('</svg>')
    return "".join(s)
SVG7 = _robot()

# úloha 8: výchozí obrázek – přímka m a body P, S
SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 300" font-family="sans-serif" font-size="15">
<rect x="4" y="4" width="412" height="292" fill="none" stroke="#ccc"/>
<line x1="60" y1="70" x2="360" y2="250" stroke="#000" stroke-width="2"/>
<text x="48" y="76" font-style="italic">m</text>
<text x="180" y="205" text-anchor="middle">×</text>
<text x="180" y="222" text-anchor="middle" font-style="italic">P</text>
<text x="250" y="150" text-anchor="middle">×</text>
<text x="250" y="167" text-anchor="middle" font-style="italic">S</text>
</svg>"""

# úloha 9: výchozí obrázek – přímka p bodem O a bod A
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 260" font-family="sans-serif" font-size="15">
<rect x="4" y="4" width="412" height="252" fill="none" stroke="#ccc"/>
<line x1="60" y1="200" x2="370" y2="70" stroke="#000" stroke-width="2"/>
<text x="48" y="212" font-style="italic">p</text>
<line x1="208" y1="128" x2="222" y2="142" stroke="#000"/>
<text x="224" y="150" font-style="italic">O</text>
<text x="330" y="150" text-anchor="middle">×</text>
<text x="330" y="167" text-anchor="middle" font-style="italic">A</text>
</svg>"""

# úloha 10: sloupcový graf – počty vyzkoušených žáků za deset dnů
def _graf():
    days = [('Po', '3. 1.', 3), ('Út', '4. 1.', 0), ('St', '5. 1.', 5), ('Čt', '6. 1.', 2), ('Pá', '7. 1.', 2),
            ('Po', '10. 1.', 6), ('Út', '11. 1.', 3), ('St', '12. 1.', 0), ('Čt', '13. 1.', 2), ('Pá', '14. 1.', 7)]
    x0, y0 = 70, 270; unit = 28; bw = 34; gap = 14
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 340" font-family="sans-serif" font-size="12">']
    s.append(f'<line x1="{x0}" y1="30" x2="{x0}" y2="{y0}" stroke="#000"/>')
    s.append(f'<line x1="{x0}" y1="{y0}" x2="590" y2="{y0}" stroke="#000"/>')
    for v in range(0, 9):
        y = y0 - v * unit
        s.append(f'<line x1="{x0-4}" y1="{y}" x2="{x0}" y2="{y}" stroke="#000"/>')
        s.append(f'<text x="{x0-9}" y="{y+4}" text-anchor="end">{v}</text>')
        if v > 0:
            s.append(f'<line x1="{x0}" y1="{y}" x2="590" y2="{y}" stroke="#eeeeee"/>')
    x = x0 + gap
    for d, dt, val in days:
        if val > 0:
            h = val * unit
            s.append(f'<rect x="{x}" y="{y0-h}" width="{bw}" height="{h}" fill="#8a8a8a" stroke="#000"/>')
        s.append(f'<text x="{x+bw/2}" y="{y0+16}" text-anchor="middle">{d}</text>')
        s.append(f'<text x="{x+bw/2}" y="{y0+30}" text-anchor="middle">{dt}</text>')
        x += bw + gap
    s.append(f'<line x1="317" y1="30" x2="317" y2="{y0}" stroke="#000" stroke-dasharray="3 4"/>')
    s.append(f'<text x="197" y="{y0+50}" text-anchor="middle">1. týden</text>')
    s.append(f'<text x="437" y="{y0+50}" text-anchor="middle">2. týden</text>')
    s.append('<text x="24" y="150" text-anchor="middle" transform="rotate(-90 24 150)">Počet vyzkoušených žáků</text>')
    s.append('</svg>')
    return "".join(s)
SVG10 = _graf()

# úloha 11: čtyřúhelník složený ze 4 trojúhelníků (schematicky)
SVG11 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 270" font-family="sans-serif" font-size="14">
<polygon points="70,45 445,150 240,240 70,240" fill="none" stroke="#000" stroke-width="1.6"/>
<line x1="70" y1="45" x2="240" y2="240" stroke="#000"/>
<line x1="70" y1="45" x2="300" y2="150" stroke="#000"/>
<line x1="240" y1="240" x2="300" y2="150" stroke="#000"/>
<line x1="445" y1="150" x2="240" y2="240" stroke="#000"/>
<text x="92" y="72">60°</text>
<text x="126" y="66" font-style="italic">φ</text>
<text x="86" y="214">60°</text>
<text x="120" y="232">28°</text>
<text x="388" y="152" font-style="italic">φ</text>
<rect x="288" y="150" width="11" height="11" fill="none" stroke="#000"/>
<rect x="229" y="217" width="11" height="11" fill="none" stroke="#000"/>
</svg>"""

# úloha 12: domeček – čtyři čtverce v řadě a trojúhelníková střecha, výška h
SVG12 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 340 250" font-family="sans-serif" font-size="14">
<rect x="40" y="150" width="60" height="60" fill="none" stroke="#000"/>
<rect x="100" y="150" width="60" height="60" fill="none" stroke="#000"/>
<rect x="160" y="150" width="60" height="60" fill="none" stroke="#000"/>
<rect x="220" y="150" width="60" height="60" fill="none" stroke="#000"/>
<polygon points="40,150 160,30 280,150" fill="none" stroke="#000" stroke-width="1.6"/>
<line x1="300" y1="30" x2="300" y2="210" stroke="#000"/>
<line x1="296" y1="30" x2="304" y2="30" stroke="#000"/>
<line x1="296" y1="210" x2="304" y2="210" stroke="#000"/>
<text x="311" y="126" font-style="italic">h</text>
</svg>"""

# úloha 13: obdélník rozdělený na 12 čtverců (S, M, L, XL), delší strana 260 cm (schematicky)
SVG13 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 260" font-family="sans-serif" font-size="15">
<rect x="40" y="30" width="390" height="180" fill="none" stroke="#000" stroke-width="1.6"/>
<line x1="250" y1="30" x2="250" y2="210" stroke="#000"/>
<text x="340" y="128" text-anchor="middle">XL</text>
<rect x="40" y="30" width="110" height="110" fill="none" stroke="#000"/>
<text x="95" y="92" text-anchor="middle">L</text>
<rect x="150" y="30" width="36" height="36" fill="none" stroke="#000"/>
<rect x="150" y="66" width="36" height="36" fill="none" stroke="#000"/>
<rect x="150" y="102" width="36" height="38" fill="none" stroke="#000"/>
<rect x="186" y="104" width="30" height="30" fill="none" stroke="#000"/>
<text x="201" y="124" text-anchor="middle" font-size="11">S</text>
<line x1="40" y1="140" x2="250" y2="140" stroke="#000"/>
<line x1="145" y1="140" x2="145" y2="210" stroke="#000"/>
<text x="92" y="180" text-anchor="middle">M</text>
<text x="198" y="180" text-anchor="middle">M</text>
<line x1="40" y1="230" x2="430" y2="230" stroke="#000"/>
<line x1="40" y1="226" x2="40" y2="234" stroke="#000"/>
<line x1="430" y1="226" x2="430" y2="234" stroke="#000"/>
<text x="235" y="250" text-anchor="middle">260 cm</text>
</svg>"""

# úloha 16: stavba z kostek – opakující se skupina sloupců 1(tmavá),2,3,4,3,2 (schematicky)
def _stavba():
    heights = [1, 2, 3, 4, 3, 2, 1, 2, 3, 4, 3, 2]
    dark = {0, 6}
    c = 14; x0 = 20; y0 = 200
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {x0*2+len(heights)*c} 230" font-family="sans-serif" font-size="11">']
    for i, h in enumerate(heights):
        for j in range(h):
            fill = '#9a9a9a' if (i in dark) else '#ffffff'
            y = y0 - (j + 1) * c
            s.append(f'<rect x="{x0+i*c}" y="{y}" width="{c}" height="{c}" fill="{fill}" stroke="#000"/>')
    s.append(f'<line x1="{x0}" y1="{y0}" x2="{x0+len(heights)*c}" y2="{y0}" stroke="#000" stroke-width="1.5"/>')
    s.append('</svg>')
    return "".join(s)
SVG16 = _stavba()

# ---- Úlohy ----

B = ['zs2', 'r7']  # 7. ročník ZŠ (šestileté obory)

PROBLEMS = [
    {'name': 'CERMAT M7B 2022 – úloha 1', 'zad': [
        'Číslo $6$ je dělitelné číslem $3$ a při dělení číslem $5$ dává zbytek $1$.',
        'Najděte všechna čísla větší než $10$ a menší než $50$, která jsou dělitelná číslem $3$ a při dělení číslem $5$ dávají zbytek $1$.'],
     'opts': None, 'ln': 2,
     'sol': ['Hledáme čísla dělitelná třemi, která dávají po dělení pěti zbytek $1$ (tj. tvaru $5k+1$). V rozmezí $10<x<50$ vyhovují $21$ ($=3\\cdot7=5\\cdot4+1$) a $36$ ($=3\\cdot12=5\\cdot7+1$).'],
     'ans': '$21$; $36$', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2022 – úloha 2.1', 'zad': [
        'Doplňte do rámečku takové číslo, aby platila rovnost:',
        '$1$ hodina $= 20$ minut $+$ □ sekund'],
     'opts': None, 'ln': 2,
     'sol': ['$1$ hodina $=3600$ s, $20$ minut $=1200$ s, do rámečku patří $3600-1200=2400$.'],
     'ans': '$2\\,400$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2022 – úloha 2.2', 'zad': [
        'Doplňte do rámečku takové číslo, aby platila rovnost:',
        '$26$ m² $+$ □ dm² $= 36$ m² $- 18\\,000$ cm²'],
     'opts': None, 'ln': 2,
     'sol': ['$18\\,000$ cm² $=1{,}8$ m², pravá strana je $36-1{,}8=34{,}2$ m². Do rámečku patří $34{,}2-26=8{,}2$ m² $=820$ dm².'],
     'ans': '$820$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2022 – úloha 3.1', 'zad': [
        'Vypočtěte a výsledek zapište zlomkem v základním tvaru:',
        '$2\\cdot\\frac{7}{48}-\\frac{7}{8}=$'],
     'opts': None, 'ln': 3,
     'sol': ['$2\\cdot\\frac{7}{48}-\\frac{7}{8}=\\frac{7}{24}-\\frac{21}{24}=-\\frac{14}{24}=-\\frac{7}{12}$.'],
     'ans': '$-\\frac{7}{12}$', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2022 – úloha 3.2', 'zad': [
        'Vypočtěte a výsledek zapište zlomkem v základním tvaru:',
        '$\\frac{\\frac{6}{7}\\cdot\\frac{2}{3}}{\\frac{6}{7}+\\frac{2}{3}}=$'],
     'opts': None, 'ln': 3,
     'sol': ['Čitatel $\\frac{6}{7}\\cdot\\frac{2}{3}=\\frac{12}{21}$, jmenovatel $\\frac{6}{7}+\\frac{2}{3}=\\frac{18+14}{21}=\\frac{32}{21}$. Podíl $\\frac{12}{21}:\\frac{32}{21}=\\frac{12}{32}=\\frac{3}{8}$.'],
     'ans': '$\\frac{3}{8}$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2022 – úloha 4.1', 'zad': [
        'Od startovní čáry vyběhli současně $4$ běžci. Každý doběhl do cíle v jiném čase. Eda nebyl první ani poslední. Leoš se umístil těsně před Adamem a Adam doběhl později než Honza.',
        'Zapište běžce ve stejném pořadí, v jakém doběhli do cíle. Každého běžce označte počátečním písmenem jeho jména.'],
     'opts': None, 'ln': 2,
     'sol': ['Leoš doběhl těsně před Adamem (dvojice $L$, $A$ za sebou), Adam až za Honzou a Eda nebyl první ani poslední. Vyhovuje jediné pořadí $H$, $E$, $L$, $A$.'],
     'ans': 'H, E, L, A (Honza, Eda, Leoš, Adam)', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7B 2022 – úloha 4.2', 'zad': [
        'Na výletě bylo pětkrát více dětí než dospělých. Dospělých bylo o $60$ méně než dětí.',
        'Vypočtěte, kolik dětí bylo na výletě.'],
     'opts': None, 'ln': 2,
     'sol': ['Označme počet dospělých $d$. Dětí je $5d$ a zároveň o $60$ více: $5d=d+60$, tedy $4d=60$, $d=15$ dospělých a dětí $5\\cdot15=75$.'],
     'ans': '$75$ dětí', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7B 2022 – úloha 5', 'zad': [
        'V rekreační chatě je několik pokojů. V jednom pokoji jsou $2$ lůžka a v každém z ostatních pokojů jsou $\\frac{3}{10}$ všech lůžek, která jsou v rekreační chatě.',
        'Určete:',
        '5.1 počet všech lůžek v rekreační chatě,',
        '5.2 počet pokojů v rekreační chatě.'],
     'opts': None, 'ln': 2,
     'sol': ['Označme počet všech lůžek $L$ a počet pokojů $p$. Platí $2+(p-1)\\cdot\\frac{3}{10}L=L$. Pro $p=4$ vychází $2+3\\cdot\\frac{3}{10}L=L$, tj. $2=\\frac{1}{10}L$, tedy $L=20$ lůžek. Každý z ostatních pokojů má $\\frac{3}{10}\\cdot20=6$ lůžek, dohromady $2+3\\cdot6=20$; pokojů je $4$.'],
     'ans': '5.1: $20$ lůžek; 5.2: $4$ pokoje', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7B 2022 – úloha 6', 'zad': [
        'Tabulka udává některé údaje o loňském a letošním prodeji pšenice a ječmene.',
        '6.1 Letos se prodalo o polovinu méně pšenice než loni. Vypočtěte, kolik tun pšenice se prodalo letos.',
        '6.2 Loni se prodalo o polovinu více ječmene než letos. Vypočtěte, kolik tun ječmene se prodalo letos.',
        '6.3 Tuna pšenice byla i loni dražší než tuna ječmene. Jejich loňské ceny byly v poměru $4:3$. Vypočtěte, za kolik Kč se loni prodávala tuna pšenice.'],
     'opts': None, 'ln': 3, 'svg': SVG6, 'fn': 'tabulka-obili.svg',
     'alt': 'Tabulka prodeje pšenice a ječmene loni a letos: loni pšenice 200 tun, ječmen 90 tun za 4 200 Kč; letos pšenice 5 800 Kč za tunu, ječmen 4 800 Kč za tunu.',
     'cap': 'Prodej pšenice a ječmene (loni a letos)',
     'sol': ['6.1 Loni $200$ tun pšenice, letos o polovinu méně: $200-100=100$ tun.',
             '6.2 Letos $x$ tun ječmene, loni o polovinu více: $1{,}5x=90$, tedy $x=60$ tun.',
             '6.3 Loňské ceny pšenice a ječmene v poměru $4:3$; ječmen $4200$ Kč, pšenice $\\frac{4}{3}\\cdot4200=5600$ Kč za tunu.'],
     'ans': '6.1: $100$ tun; 6.2: $60$ tun; 6.3: $5\\,600$ Kč', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7B 2022 – úloha 7', 'zad': [
        'Dřevěná hlava robota byla slepena z jedné velké a $7$ shodných malých krychlí. Po slepení byly části vyčnívající z velké krychle obarveny na šedo, všechny ostatní plochy na bílo. (Bílá je i spodní stěna velké krychle, neobarvené zůstaly jen slepené plochy.)',
        'Jedna stěna malé krychle má obsah $9$ cm². Velká krychle má hranu délky $10$ cm.',
        'Vypočtěte:',
        '7.1 v cm² celkový obsah všech šedých ploch,',
        '7.2 v cm² celkový obsah všech bílých ploch,',
        '7.3 v cm³ objem celé hlavy robota (tj. objem všech krychlí dohromady).'],
     'opts': None, 'ln': 4, 'svg': SVG7, 'fn': 'robot.svg',
     'alt': 'Schematický nákres hlavy robota: velká krychle o hraně 10 cm, na jejíchž stěnách je nalepeno sedm malých krychlí se stěnou o obsahu 9 cm².',
     'cap': 'Hlava robota z velké a sedmi malých krychlí (schematicky)',
     'sol': ['Stěna malé krychle má $9$ cm², malá krychle tedy má hranu $3$ cm; velká krychle hranu $10$ cm.',
             '7.1 Šedé (vyčnívající) plochy tvoří dohromady $33$ stěn malých krychlí: $33\\cdot9=297$ cm².',
             '7.2 Bílé plochy: povrch velké krychle bez zakrytých míst $6\\cdot100-7\\cdot9=537$ cm² a $2$ stěny malých krychlí v rovině spodní stěny $2\\cdot9=18$ cm², celkem $537+18=555$ cm².',
             '7.3 Objem $=10^3+7\\cdot3^3=1000+189=1189$ cm³.'],
     'ans': '7.1: $297$ cm²; 7.2: $555$ cm²; 7.3: $1\\,189$ cm³', 'pts': 4, 'mins': 9, 'diff': '4',
     'codes': B + ['stereometrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2022 – úloha 8', 'zad': [
        'V rovině leží body $P$, $S$ a přímka $m$ (viz obrázek).',
        'Bod $S$ je střed kružnice $k$, která má poloměr $5$ cm. Bod $P$ je vrchol rovnostranného trojúhelníku $PQR$. Další vrchol tohoto trojúhelníku leží v průsečíku přímky $m$ s kružnicí $k$ a poslední vrchol trojúhelníku $PQR$ leží uvnitř kružnice $k$.',
        'Sestrojte vrcholy $Q$, $R$ trojúhelníku $PQR$, označte je písmeny a trojúhelník narýsujte. Najděte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG8, 'fn': 'primka-m-body.svg',
     'alt': 'Přímka m vedená z levého horního rohu dolů doprava, bod P pod přímkou vlevo a bod S nad přímkou uprostřed.',
     'cap': 'Výchozí obrázek k úloze 8',
     'sol': ['Bod $S$ je střed kružnice $k$ o poloměru $5$ cm — kružnici $k$ narýsujeme. Vrchol $Q$ leží v průsečíku přímky $m$ s kružnicí $k$; ta má dva průsečíky $Q_1$, $Q_2$. Trojúhelník $PQR$ je rovnostranný, proto třetí vrchol $R$ (uvnitř kružnice) sestrojíme jako průsečík kružnic se středy $P$ a $Q$ a poloměrem $|PQ|$. Úloha má dvě řešení.'],
     'ans': 'Dvě řešení: kružnice $k$ se středem $S$ a poloměrem $5$ cm, vrchol $Q$ v průsečíku přímky $m$ a kružnice $k$ ($Q_1$, $Q_2$), rovnostranné trojúhelníky $PQ_1R_1$ a $PQ_2R_2$ (viz obrázek v klíči).',
     'pts': 3, 'mins': 8, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2022 – úloha 9', 'zad': [
        'V rovině leží body $A$, $O$ a přímka $p$ procházející bodem $O$ (viz obrázek).',
        'Bod $A$ je vrchol obdélníku $ABCD$. Na přímce $p$ leží vrchol $C$ tohoto obdélníku. Bod $O$ je střed některé strany obdélníku $ABCD$.',
        'Sestrojte vrcholy $B$, $C$, $D$ obdélníku $ABCD$, označte je písmeny a obdélník narýsujte. Najděte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG9, 'fn': 'primka-p-body.svg',
     'alt': 'Přímka p vedená z levého dolního rohu nahoru doprava, na ní bod O, a bod A vpravo pod přímkou.',
     'cap': 'Výchozí obrázek k úloze 9',
     'sol': ['Bod $O$ (na přímce $p$) je střed některé strany obdélníku a vrchol $C$ leží na přímce $p$. Z podmínek pravých úhlů obdélníku a středu strany sestrojíme vrcholy $B$, $C$, $D$. Úloha má dvě řešení (obdélníky $AB_1C_1D_1$ a $AB_2C_2D_2$).'],
     'ans': 'Dvě řešení: obdélníky s vrcholem $A$, vrcholem $C$ na přímce $p$ a bodem $O$ jako středem některé strany (viz obrázek v klíči).',
     'pts': 3, 'mins': 8, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2022 – úloha 10', 'zad': [
        'V prvních dvou lednových týdnech učitel matematiky vyzkoušel všech $30$ žáků třídy 7. A, a to každého právě jednou. Graf udává počty žáků vyzkoušených v jednotlivých dnech.',
        'Rozhodněte o každém z následujících tvrzení (10.1–10.3), zda je pravdivé (A), či nikoli (N).',
        '10.1 V 1. týdnu učitel vyzkoušel dvě pětiny žáků třídy 7. A.',
        '10.2 Ve 2. týdnu učitel vyzkoušel v pátek sedmkrát více žáků než ve středu.',
        '10.3 V úterý 11. 1. učitel vyzkoušel čtvrtinu z těch žáků, kteří nebyli vyzkoušeni v žádném z předchozích dnů.'],
     'opts': None, 'ln': 0, 'svg': SVG10, 'fn': 'graf-vyzkouseni.svg',
     'alt': 'Sloupcový graf počtu vyzkoušených žáků v deseti dnech dvou lednových týdnů: 1. týden 3, 0, 5, 2, 2; 2. týden 6, 3, 0, 2, 7.',
     'cap': 'Počty vyzkoušených žáků v jednotlivých dnech',
     'sol': ['Počty vyzkoušených: 1. týden $3+0+5+2+2=12$, 2. týden $6+3+0+2+7=18$ (celkem $30$).',
             '10.1 $12$ je $\\frac{2}{5}$ z $30$ — pravda (A).',
             '10.2 V pátek $7$ žáků, ve středu $0$ žáků; $7$ není sedminásobek nuly — nepravda (N).',
             '10.3 Do úterý bylo vyzkoušeno $12+6=18$ žáků, nevyzkoušeno zbývá $30-18=12$; jejich čtvrtina je $3$, což odpovídá počtu vyzkoušených v úterý — pravda (A).'],
     'ans': '10.1: Ano; 10.2: Ne; 10.3: Ano', 'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['statistika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7B 2022 – úloha 11', 'zad': [
        'Čtyřúhelník se skládá ze $4$ trojúhelníků (viz obrázek).',
        'Jaká je velikost úhlu $\\varphi$? Velikosti úhlů neměřte, ale vypočtěte.'],
     'opts': ['A) menší než $16^\\circ$', 'B) $16^\\circ$', 'C) $18^\\circ$', 'D) $21^\\circ$', 'E) větší než $21^\\circ$'],
     'ln': 0, 'svg': SVG11, 'fn': 'ctyruhelnik-uhly.svg',
     'alt': 'Schematický nákres čtyřúhelníku složeného ze čtyř trojúhelníků s vyznačenými úhly 60°, 60°, 28°, dvěma pravými úhly a hledaným úhlem φ.',
     'cap': 'Čtyřúhelník složený ze čtyř trojúhelníků (schematicky)',
     'sol': ['Levý trojúhelník má u dvou vrcholů úhly $60^\\circ$ a $60^\\circ$, je tedy rovnostranný. Postupným užitím součtu úhlů v trojúhelníku, pravých úhlů vyznačených v obrázku a úhlu $28^\\circ$ dopočítáme hledaný úhel $\\varphi=16^\\circ$.'],
     'ans': 'B) $16^\\circ$', 'pts': 2, 'mins': 5, 'diff': '4',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2022 – úloha 12', 'zad': [
        'Domeček tvaru pětiúhelníku se skládá z trojúhelníku a čtyř shodných čtverců. Čtyři čtverce mají dohromady stejný obsah jako trojúhelník. Délka strany čtverce je $6$ cm.',
        'Jaká je výška domečku $h$?'],
     'opts': ['A) menší než $14$ cm', 'B) $14$ cm', 'C) $16$ cm', 'D) $18$ cm', 'E) větší než $18$ cm'],
     'ln': 0, 'svg': SVG12, 'fn': 'domecek.svg',
     'alt': 'Schematický nákres domečku ve tvaru pětiúhelníku: čtyři shodné čtverce v řadě a nad nimi trojúhelníková střecha; vpravo je vyznačena výška h.',
     'cap': 'Domeček z trojúhelníku a čtyř shodných čtverců (schematicky)',
     'sol': ['Obsah čtyř čtverců je $4\\cdot6^2=144$ cm², stejný obsah má i trojúhelníková střecha. Základna střechy je $4\\cdot6=24$ cm, proto pro její výšku $v$ platí $\\frac{1}{2}\\cdot24\\cdot v=144$, tj. $v=12$ cm. Výška domečku $h=6+12=18$ cm.'],
     'ans': 'D) $18$ cm', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2022 – úloha 13', 'zad': [
        'Obdélník je rozdělen na $12$ čtverců čtyř různých velikostí ($S$, $M$, $L$ a $XL$). Delší strana obdélníku měří $260$ cm.',
        'Jaký je obvod čtverce velikosti $L$?'],
     'opts': ['A) $240$ cm', 'B) $280$ cm', 'C) $320$ cm', 'D) $360$ cm', 'E) jiný obvod'],
     'ln': 0, 'svg': SVG13, 'fn': 'obdelnik-ctverce.svg',
     'alt': 'Schematický nákres obdélníku rozděleného na dvanáct čtverců čtyř velikostí (S, M, L, XL); delší strana obdélníku měří 260 cm.',
     'cap': 'Rozdělení obdélníku na 12 čtverců čtyř velikostí (schematicky)',
     'sol': ['Z rozdělení obdélníku (delší strana $260$ cm) na dvanáct čtverců čtyř velikostí vyplývá, že čtverec velikosti $L$ má stranu $80$ cm. Jeho obvod je $4\\cdot80=320$ cm.'],
     'ans': 'C) $320$ cm', 'pts': 2, 'mins': 5, 'diff': '4',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2022 – úloha 14', 'zad': [
        'V pohádkové říši se setkání draků zúčastnili pouze dvouhlaví a tříhlaví draci. Draků bylo celkem $52$ a dohromady měli $134$ hlav.',
        'O kolik se liší součet hlav všech tříhlavých draků od součtu hlav všech dvouhlavých draků?'],
     'opts': ['A) o méně než $22$ hlav', 'B) o $22$ hlav', 'C) o $30$ hlav', 'D) o $41$ hlav', 'E) o více než $41$ hlav'],
     'ln': 0,
     'sol': ['Dvouhlavých draků je $d_2$, tříhlavých $d_3$: $d_2+d_3=52$ a $2d_2+3d_3=134$. Odtud $d_3=134-2\\cdot52=30$ a $d_2=22$. Součet hlav tříhlavých je $3\\cdot30=90$, dvouhlavých $2\\cdot22=44$; liší se o $90-44=46$ hlav, což je více než $41$.'],
     'ans': 'E) o více než $41$ hlav', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['rovnice', 'modelovani', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2022 – úloha 15', 'zad': [
        'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).',
        '15.1 Ze sklizené mrkve se prodalo $960$ kg, a zbývalo tak ještě $40\\,\\%$ sklizené mrkve. Kolik kg mrkve bylo sklizeno?',
        '15.2 Během prosince ze skladu odvezli pětinu posypové soli, a ve skladu tak zbylo ještě $9\\,000$ kg posypové soli. Kolik kg posypové soli odvezli ze skladu během prosince?',
        '15.3 Obchodník nakoupil $12\\,000$ kg brambor. V říjnu z nich prodal $40\\,\\%$, v listopadu prodal $75\\,\\%$ zbytku a neprodané brambory daroval charitě. Kolik kg brambor daroval obchodník charitě?'],
     'opts': ['A) $1\\,600$ kg', 'B) $1\\,800$ kg', 'C) $2\\,000$ kg', 'D) $2\\,250$ kg', 'E) $2\\,400$ kg', 'F) více než $2\\,400$ kg'],
     'ln': 0,
     'sol': ['15.1 Prodaných $960$ kg je $60\\,\\%$ sklizně (zbývá $40\\,\\%$), sklizeno $960:0{,}6=1600$ kg → A.',
             '15.2 Odvezena $\\frac{1}{5}$, zbylé $\\frac{4}{5}$ jsou $9000$ kg, celkem $11\\,250$ kg; odvezeno $\\frac{1}{5}\\cdot11\\,250=2250$ kg → D.',
             '15.3 V říjnu prodáno $40\\,\\%$ z $12\\,000$ kg, zbývá $7200$ kg; v listopadu prodáno $75\\,\\%$, neprodáno $25\\,\\%$ z $7200=1800$ kg → B.'],
     'ans': '15.1: A ($1\\,600$ kg); 15.2: D ($2\\,250$ kg); 15.3: B ($1\\,800$ kg)', 'pts': 6, 'mins': 8, 'diff': '3',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7B 2022 – úloha 16', 'zad': [
        'Amélka, Viktorka a Zuzanka vytvářely stavby z kostek podle následujících pravidel:',
        'První sloupec stavby tvoří $1$ tmavá kostka a dalších $5$ sloupců je postaveno postupně ze $2$, $3$, $4$, $3$ a $2$ bílých kostek. Poté se sloupce opakují ve stejném pořadí, ale po dostavění kteréhokoliv sloupce lze stavbu ukončit.',
        'Např. stavba na obrázku má celkem $23$ sloupců, z nichž je $19$ sloupců bílých a $4$ tmavé.',
        '16.1 Amélčina stavba má celkem $42$ sloupců. Vypočtěte, kolik kostek (bílých i tmavých dohromady) obsahuje Amélčina stavba.',
        '16.2 Viktorčina stavba má $58$ bílých sloupců. Vypočtěte, kolik tmavých kostek obsahuje Viktorčina stavba.',
        '16.3 Zuzančina stavba obsahuje celkem $156$ kostek (bílých i tmavých dohromady). Vypočtěte, kolik sloupců má Zuzančina stavba.'],
     'opts': None, 'ln': 4, 'svg': SVG16, 'fn': 'stavba-kostky.svg',
     'alt': 'Schematický nákres stavby z kostek: opakující se skupiny sloupců o výškách 1 tmavé kostky a 2, 3, 4, 3, 2 bílých kostek.',
     'cap': 'Stavba z kostek — opakující se skupina šesti sloupců (schematicky)',
     'sol': ['Skupina šesti sloupců má výšky $1$ (tmavá), $2$, $3$, $4$, $3$, $2$ (bílé) kostek, tj. $1+2+3+4+3+2=15$ kostek na $6$ sloupců; z toho $1$ tmavá a $14$ bílých kostek, $1$ tmavý a $5$ bílých sloupců.',
             '16.1 $42$ sloupců $=7$ skupin, kostek $7\\cdot15=105$.',
             '16.2 $58$ bílých sloupců $=5\\cdot11+3$: po $11$ celých skupinách ($11$ tmavých sloupců) přibude v další skupině tmavý sloupec, celkem $12$ tmavých sloupců, tedy $12$ tmavých kostek.',
             '16.3 $156$ kostek: $10$ celých skupin $=150$ kostek ($60$ sloupců); zbývá $6$ kostek $=$ sloupce $1+2+3$ (tmavý a dva bílé), tj. další $3$ sloupce. Celkem $63$ sloupců.'],
     'ans': '16.1: $105$ kostek; 16.2: $12$ tmavých kostek; 16.3: $63$ sloupců', 'pts': 4, 'mins': 8, 'diff': '3',
     'codes': B + ['posloupnosti', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M7PBD22C0T02'
    gen.YEAR = 2022

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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M7B-2022')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
