# -*- coding: utf-8 -*-
# CERMAT - Jednotna prijimaci zkouska 2023, MATEMATIKA 9C (ctyrlete obory, 9. rocnik).
# Kod testu: M9PCD23C0T03. 16 uloh (po rozdeleni nezavislych poduloh 22 uloh).
# Zdroj odpovedi: klic spravnych reseni (KLIC_9C_2023).

import math

# ---- SVG obrazky (bez apostrofu a zpetnych lomitek) ----

# uloha 7: rotacni valec (vyska 12 cm) s vepsanym kvadrem + samostatny kvadr 8x6x12
SVG7 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 540 230" font-family="sans-serif">
<ellipse cx="80" cy="120" rx="26" ry="72" fill="#eef4fa" stroke="#000"/>
<line x1="80" y1="48" x2="250" y2="48" stroke="#000"/>
<line x1="80" y1="192" x2="250" y2="192" stroke="#000"/>
<path d="M250 48 A26 72 0 0 1 250 192" fill="none" stroke="#000"/>
<rect x="66" y="82" width="150" height="78" fill="none" stroke="#000" stroke-dasharray="5 3"/>
<text x="160" y="216" font-size="12" text-anchor="middle">rotacni valec, vyska 12 cm</text>
<polygon points="330,92 430,92 430,168 330,168" fill="#eef4fa" stroke="#000"/>
<polygon points="330,92 365,64 465,64 430,92" fill="#eef4fa" stroke="#000"/>
<polygon points="430,92 465,64 465,140 430,168" fill="#eef4fa" stroke="#000"/>
<text x="318" y="134" font-size="12" text-anchor="end">6 cm</text>
<text x="380" y="186" font-size="12" text-anchor="middle">8 cm</text>
<text x="470" y="112" font-size="12">12 cm</text>
</svg>"""

# uloha 9: vychozi obrazek - primka AB a primka p protinajici se v bode B
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 300" font-family="sans-serif">
<line x1="60" y1="250" x2="360" y2="100" stroke="#000" stroke-width="1.5"/>
<line x1="200" y1="80" x2="380" y2="170" stroke="#000" stroke-width="1.5"/>
<line x1="83" y1="230" x2="97" y2="243" stroke="#000"/>
<text x="46" y="262" font-size="15" font-style="italic">A</text>
<text x="306" y="126" font-size="15" font-style="italic">B</text>
<text x="386" y="176" font-size="15" font-style="italic">p</text>
</svg>"""

# uloha 10: vychozi obrazek - body A, C a primka p prochazejici bodem C
SVG10 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 320" font-family="sans-serif">
<line x1="90" y1="60" x2="330" y2="270" stroke="#000" stroke-width="1.5"/>
<line x1="98" y1="79" x2="114" y2="72" stroke="#000"/>
<text x="72" y="78" font-size="15" font-style="italic">C</text>
<text x="150" y="248" font-size="14" text-anchor="middle">x</text>
<text x="150" y="266" font-size="15" font-style="italic" text-anchor="middle">A</text>
<text x="338" y="284" font-size="15" font-style="italic">p</text>
</svg>"""

# uloha 11: kolacovy (mezikruzni) graf - oddily A, B, C; dva udaje chybi (?)
def _donut():
    cx, cy = 250, 165
    R, r = 118, 50
    def P(rad, ang):
        a = math.radians(ang - 90)
        return (cx + rad * math.cos(a), cy + rad * math.sin(a))
    segs = [('A', 0, 160, '#ffffff'), ('B', 160, 280, '#9a9a9a'), ('C', 280, 360, '#d8d8d8')]
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 330" font-family="sans-serif">']
    for label, a0, a1, fill in segs:
        large = 1 if (a1 - a0) > 180 else 0
        x1, y1 = P(R, a0)
        x2, y2 = P(R, a1)
        xi2, yi2 = P(r, a1)
        xi1, yi1 = P(r, a0)
        s.append(f'<path d="M{x1:.1f} {y1:.1f} A{R} {R} 0 {large} 1 {x2:.1f} {y2:.1f} L{xi2:.1f} {yi2:.1f} A{r} {r} 0 {large} 0 {xi1:.1f} {yi1:.1f} Z" fill="{fill}" stroke="#000"/>')
        mx, my = P((R + r) / 2, (a0 + a1) / 2)
        s.append(f'<text x="{mx:.0f}" y="{my:.0f}" font-size="16" text-anchor="middle" font-style="italic">{label}</text>')
    outs = [(45, 'chlapci 9'), (125, 'divky 7'), (205, 'chlapci ?'), (255, 'divky 4'), (300, 'chlapci 3'), (335, 'divky ?')]
    for ang, txt in outs:
        lx, ly = P(R + 26, ang)
        s.append(f'<text x="{lx:.0f}" y="{ly:.0f}" font-size="11" text-anchor="middle">{txt}</text>')
    s.append('</svg>')
    return "".join(s)
SVG11 = _donut()

# uloha 13: petiuhelnik ABCDE (rovnoramenny + rovnostranny + pravouhly trojuhelnik)
SVG13 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 300" font-family="sans-serif">
<polygon points="80,250 410,250 545,155 475,95 275,120" fill="none" stroke="#000" stroke-width="1.5"/>
<line x1="275" y1="120" x2="410" y2="250" stroke="#000"/>
<line x1="475" y1="95" x2="410" y2="250" stroke="#000"/>
<text x="64" y="266" font-size="15" font-style="italic">A</text>
<text x="405" y="272" font-size="15" font-style="italic">B</text>
<text x="556" y="158" font-size="15" font-style="italic">C</text>
<text x="478" y="86" font-size="15" font-style="italic">D</text>
<text x="255" y="116" font-size="15" font-style="italic">E</text>
<text x="118" y="243" font-size="13">55°</text>
<text x="466" y="128" font-size="14" font-style="italic">ω</text>
<rect x="515" y="150" width="11" height="11" fill="none" stroke="#000" transform="rotate(35 520 155)"/>
<text x="178" y="180" font-size="15">›</text>
<text x="474" y="206" font-size="15">›</text>
</svg>"""

# uloha 14: pravidelny ctyrboky hranol (kvadr se ctvercovou podstavou), schematicky
SVG14 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 260 170" font-family="sans-serif">
<polygon points="40,90 180,90 180,140 40,140" fill="#eef4fa" stroke="#000"/>
<polygon points="40,90 90,55 230,55 180,90" fill="#eef4fa" stroke="#000"/>
<polygon points="180,90 230,55 230,105 180,140" fill="#eef4fa" stroke="#000"/>
<line x1="40" y1="140" x2="90" y2="105" stroke="#000" stroke-dasharray="4 3"/>
<line x1="90" y1="105" x2="230" y2="105" stroke="#000" stroke-dasharray="4 3"/>
<line x1="90" y1="105" x2="90" y2="55" stroke="#000" stroke-dasharray="4 3"/>
</svg>"""

# uloha 16: obrazce z malych sedych ctverecku (spodni rada + levy sloupec) a velkych bilych
def _squares():
    u = 16
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 200" font-family="sans-serif">']
    def obrazec(ox, oy, cols, rows, label):
        for i in range(cols):
            s.append(f'<rect x="{ox + i * u}" y="{oy + (rows - 1) * u}" width="{u}" height="{u}" fill="#c9c9c9" stroke="#000"/>')
        for j in range(rows):
            s.append(f'<rect x="{ox}" y="{oy + j * u}" width="{u}" height="{u}" fill="#c9c9c9" stroke="#000"/>')
        for a in range((cols - 1) // 2):
            for b in range((rows - 1) // 2):
                s.append(f'<rect x="{ox + u + a * 2 * u}" y="{oy + b * 2 * u}" width="{2 * u}" height="{2 * u}" fill="#ffffff" stroke="#000"/>')
        s.append(f'<text x="{ox + cols * u // 2}" y="{oy + rows * u + 18}" font-size="12" text-anchor="middle">{label}</text>')
    obrazec(30, 25, 5, 3, '1. obrazec')
    obrazec(200, 25, 7, 5, '2. obrazec')
    s.append('<text x="410" y="90" font-size="22" text-anchor="middle">…</text>')
    s.append('</svg>')
    return "".join(s)
SVG16 = _squares()

B = ['zs2', 'r9']  # 9. rocnik ZS (ctyrlete obory); stupen zs2, rocnik r9

PROBLEMS = [
    {'name': 'CERMAT M9C 2023 – úloha 1', 'zad': [
        'Vypočtěte, kolikrát je součet čísel $0{,}2$ a $0{,}5$ větší než jejich součin.'],
     'opts': None, 'ln': 2,
     'sol': ['Součet je $0{,}2+0{,}5=0{,}7$, součin je $0{,}2\\cdot 0{,}5=0{,}1$. Podíl $0{,}7:0{,}1=7$, součet je tedy $7$krát větší.'],
     'ans': '$7$krát', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2023 – úloha 2.1', 'zad': [
        'Vypočtěte: $4+6:2-5\\cdot(-3+5)=$'],
     'opts': None, 'ln': 2,
     'sol': ['$4+6:2-5\\cdot(-3+5)=4+3-5\\cdot 2=4+3-10=-3$.'],
     'ans': '$-3$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2023 – úloha 2.2', 'zad': [
        'Vypočtěte: $\\sqrt{1{,}3^2-1{,}2^2}=$'],
     'opts': None, 'ln': 2,
     'sol': ['$\\sqrt{1{,}3^2-1{,}2^2}=\\sqrt{1{,}69-1{,}44}=\\sqrt{0{,}25}=0{,}5$.'],
     'ans': '$0{,}5$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2023 – úloha 3.1', 'zad': [
        'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $3\\cdot\\frac{2}{7}-\\frac{2}{7}=$'],
     'opts': None, 'ln': 2,
     'sol': ['$3\\cdot\\frac{2}{7}-\\frac{2}{7}=\\frac{6}{7}-\\frac{2}{7}=\\frac{4}{7}$.'],
     'ans': '$\\frac{4}{7}$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2023 – úloha 3.2', 'zad': [
        'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $1-\\frac{14}{5}:2=$'],
     'opts': None, 'ln': 2,
     'sol': ['$\\frac{14}{5}:2=\\frac{14}{10}=\\frac{7}{5}$, proto $1-\\frac{7}{5}=\\frac{5}{5}-\\frac{7}{5}=-\\frac{2}{5}$.'],
     'ans': '$-\\frac{2}{5}$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2023 – úloha 3.3', 'zad': [
        'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\frac{\\frac{3}{4}+\\frac{4}{3}}{\\frac{5}{7}\\cdot\\frac{14}{3}}=$'],
     'opts': None, 'ln': 3,
     'sol': ['Čitatel: $\\frac{3}{4}+\\frac{4}{3}=\\frac{9}{12}+\\frac{16}{12}=\\frac{25}{12}$. Jmenovatel: $\\frac{5}{7}\\cdot\\frac{14}{3}=\\frac{70}{21}=\\frac{10}{3}$. Podíl: $\\frac{25}{12}:\\frac{10}{3}=\\frac{25}{12}\\cdot\\frac{3}{10}=\\frac{75}{120}=\\frac{5}{8}$.'],
     'ans': '$\\frac{5}{8}$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2023 – úloha 4.1', 'zad': [
        'Rozložte na součin podle vzorce: $4a^2-9=$'],
     'opts': None, 'ln': 2,
     'sol': ['$4a^2-9=(2a)^2-3^2=(2a+3)\\cdot(2a-3)$.'],
     'ans': '$(2a+3)\\cdot(2a-3)$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2023 – úloha 4.2', 'zad': [
        'Zjednodušte (výsledný výraz nesmí obsahovat závorky): $(2x-1)\\cdot\\frac{1}{2}-x=$'],
     'opts': None, 'ln': 2,
     'sol': ['$(2x-1)\\cdot\\frac{1}{2}-x=x-\\frac{1}{2}-x=-\\frac{1}{2}$.'],
     'ans': '$-\\frac{1}{2}$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2023 – úloha 4.3', 'zad': [
        'Zjednodušte (výsledný výraz nesmí obsahovat závorky): $(4n-3)^2-4n\\cdot(4n-3)=$'],
     'opts': None, 'ln': 3,
     'sol': ['Vytkneme společný činitel $(4n-3)$: $(4n-3)\\cdot[(4n-3)-4n]=(4n-3)\\cdot(-3)=-12n+9$. (Roznásobením: $16n^2-24n+9-(16n^2-12n)=-12n+9$.)'],
     'ans': '$-12n+9$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2023 – úloha 5.1', 'zad': [
        'Řešte rovnici: $0{,}3\\cdot(2x+1)=0{,}2x-0{,}7$'],
     'opts': None, 'ln': 4,
     'sol': ['$0{,}6x+0{,}3=0{,}2x-0{,}7$; po úpravě $0{,}4x=-1$, tedy $x=-2{,}5$.'],
     'ans': '$x=-2{,}5$', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2023 – úloha 5.2', 'zad': [
        'Řešte rovnici: $y+\\frac{5y}{6}=\\frac{2y-1}{4}+\\frac{y+1}{2}$'],
     'opts': None, 'ln': 4,
     'sol': ['Rovnici vynásobíme dvanácti: $12y+10y=3\\cdot(2y-1)+6\\cdot(y+1)$, tj. $22y=6y-3+6y+6$, tedy $22y=12y+3$. Odtud $10y=3$ a $y=0{,}3$.'],
     'ans': '$y=0{,}3$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2023 – úloha 6', 'zad': [
        'Vítek, Rudolf a Ondra jeli společně autem k moři. Každý z nich odřídil část trasy. Vítek odřídil třetinu celé trasy, Rudolf odřídil o $60$ km méně než Vítek a Ondra odřídil zbývající dvě pětiny celé trasy. Celá trasa měřila $x$ km.',
        '6.1 Vyjádřete výrazem s proměnnou $x$, kolik km trasy odřídil Rudolf.',
        '6.2 Vypočtěte, kolik km měřila celá trasa.'],
     'opts': None, 'ln': 4,
     'sol': ['6.1 Vítek odřídil $\\frac{x}{3}$ km, Rudolf o $60$ km méně, tedy $\\frac{x}{3}-60$ km. (Totéž je zbytek trasy $x-\\frac{x}{3}-\\frac{2x}{5}=\\frac{4}{15}x$.)',
            '6.2 Z rovnosti $\\frac{x}{3}-60=\\frac{4}{15}x$ po vynásobení patnácti dostaneme $5x-900=4x$, tedy $x=900$. Celá trasa měřila $900$ km.'],
     'ans': '6.1: $\\frac{x}{3}-60$ (tj. $\\frac{4}{15}x$); 6.2: $900$ km', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['rovnice', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9C 2023 – úloha 7', 'zad': [
        'Rotační válec má výšku $12$ cm. Odstraněním čtyř částí vytvoříme z tohoto válce kvádr s rozměry $8$ cm, $6$ cm a $12$ cm. Všechny hrany kvádru leží na povrchu válce (viz obrázek).',
        'Pro výpočet použijte hodnotu $\\pi\\doteq 3{,}14$.',
        '7.1 Vypočtěte v cm poloměr podstavy válce.',
        '7.2 Vypočtěte v cm³ objem válce. Výsledek zaokrouhlete na desítky cm³.'],
     'opts': None, 'ln': 4, 'svg': SVG7, 'fn': 'valec-kvadr.svg',
     'alt': 'Rotační válec s výškou 12 cm a vepsaným kvádrem, vedle samostatný kvádr s rozměry 8 cm, 6 cm a 12 cm.',
     'cap': 'Válec a z něj vytvořený kvádr (schematický nákres)',
     'sol': ['7.1 Podstavou kvádru je obdélník o stranách $8$ cm a $6$ cm vepsaný do podstavy válce; jeho úhlopříčka je průměrem kruhu: $\\sqrt{8^2+6^2}=\\sqrt{100}=10$ cm. Poloměr je tedy $r=5$ cm.',
            '7.2 Objem válce $V=\\pi r^2 h=3{,}14\\cdot 5^2\\cdot 12=3{,}14\\cdot 300=942\\doteq 940$ cm³.'],
     'ans': '7.1: $r=5$ cm; 7.2: $V\\doteq 940$ cm³', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['stereometrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2023 – úloha 8', 'zad': [
        'V obchodě s oříšky prodávají různé směsi. Jejich cena závisí pouze na hmotnosti a ceně použitých surovin. Ceny surovin za $1$ kg: arašídy $80$ korun, kešu $280$ korun, mandle $200$ korun. (Např. $200$gramové balení směsi obsahující $50$ g kešu a $150$ g mandlí stojí $44$ korun, tedy $1$ kg této směsi stojí $220$ korun.)',
        '8.1 Dvoukilogramové balení směsi arašídů a mandlí obsahuje $800$ gramů arašídů a $1\\,200$ gramů mandlí. Vypočtěte, kolik korun stojí jeden kilogram této směsi.',
        '8.2 Jiná směs obsahuje pouze arašídy a kešu, přičemž $1$ kg této směsi stojí $200$ korun. Velké balení této směsi obsahuje $500$ gramů arašídů. Vypočtěte, kolik gramů kešu obsahuje velké balení této směsi.'],
     'opts': None, 'ln': 4,
     'sol': ['8.1 Dvoukilogramové balení stojí $0{,}8\\cdot 80+1{,}2\\cdot 200=64+240=304$ korun. Jeden kilogram tedy stojí $304:2=152$ korun.',
            '8.2 Ať balení obsahuje $a$ kg arašídů a $k$ kg kešu. Z ceny $\\frac{80a+280k}{a+k}=200$ plyne $80a+280k=200a+200k$, tj. $80k=120a$, tedy $k=1{,}5a$. Pro $a=500$ g je $k=750$ g.'],
     'ans': '8.1: $152$ korun; 8.2: $750$ gramů', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9C 2023 – úloha 9 (konstrukce)', 'zad': [
        'V rovině leží přímka $AB$ a přímka $p$ procházející bodem $B$ (viz obrázek).',
        'Úsečka $AB$ je strana pravoúhlého lichoběžníku $ABCD$. Vrchol $C$ tohoto lichoběžníku leží na přímce $p$, úhlopříčka $AC$ má stejnou délku jako strana $AB$ lichoběžníku $ABCD$.',
        'Sestrojte vrcholy $C$, $D$ lichoběžníku $ABCD$, označte je písmeny a lichoběžník narýsujte. Najděte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG9, 'fn': 'primka-AB-p.svg',
     'alt': 'Přímka AB vedená od bodu A vlevo dole šikmo vzhůru a přímka p protínající ji v bodě B.',
     'cap': 'Výchozí obrázek k úloze 9',
     'sol': ['Úhlopříčka $AC$ má délku $|AB|$, proto vrchol $C$ leží na kružnici $k(A;|AB|)$. Zároveň $C$ leží na přímce $p$, takže $C$ je průsečík přímky $p$ s kružnicí $k$ — vzniknou dvě polohy $C_1$, $C_2$.',
            'Základnami lichoběžníku jsou rovnoběžné strany $AB$ a $CD$; protože jde o pravoúhlý lichoběžník, je rameno $AD$ kolmé k $AB$. Vrchol $D$ je proto průsečík kolmice k $AB$ vedené bodem $A$ s rovnoběžkou s $AB$ vedenou bodem $C$. Úloha má dvě řešení ($D_1$, $D_2$).'],
     'ans': 'Dvě řešení: $C$ je průsečík přímky $p$ s kružnicí $k(A;|AB|)$ (polohy $C_1$, $C_2$); dále $AB\\parallel CD$ a $AD\\perp AB$, takže $D$ je průsečík kolmice k $AB$ v bodě $A$ s rovnoběžkou s $AB$ bodem $C$. Viz obrázek v klíči.',
     'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2023 – úloha 10 (konstrukce)', 'zad': [
        'V rovině leží body $A$, $C$ a přímka $p$ procházející bodem $C$ (viz obrázek).',
        'Úsečka $AC$ je základna rovnoramenného trojúhelníku $ABC$. Na přímce $p$ leží jedna ze tří výšek tohoto trojúhelníku.',
        '10.1 Sestrojte osu souměrnosti trojúhelníku $ABC$ a označte ji písmenem $o$.',
        '10.2 Sestrojte vrchol $B$ trojúhelníku $ABC$, označte ho písmenem a trojúhelník narýsujte.'],
     'opts': None, 'ln': 0, 'svg': SVG10, 'fn': 'body-AC-p.svg',
     'alt': 'Šikmá přímka p, na ní bod C nahoře označený tečkou, a bod A pod přímkou označený křížkem.',
     'cap': 'Výchozí obrázek k úloze 10',
     'sol': ['10.1 Rovnoramenný trojúhelník se základnou $AC$ je souměrný podle osy úsečky $AC$; tuto osu sestrojíme a označíme $o$ (prochází vrcholem $B$).',
            '10.2 Přímka $p$ prochází bodem $C$ a leží na ní jedna z výšek, jde tedy o výšku z vrcholu $C$ na stranu $AB$; platí $AB\\perp p$. Vrchol $B$ najdeme jako průsečík osy $o$ s kolmicí k přímce $p$ vedenou bodem $A$.'],
     'ans': '10.1: osa $o$ je osa úsečky $AC$ (prochází vrcholem $B$). 10.2: přímka $p$ je výška z vrcholu $C$, proto $AB\\perp p$ a vrchol $B$ je průsečík osy $o$ s kolmicí k $p$ vedenou bodem $A$. Viz obrázek v klíči.',
     'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2023 – úloha 11', 'zad': [
        'Na táboře je každé dítě zařazeno do jednoho ze tří oddílů $A$, $B$ a $C$. V oddíle $A$ je dvakrát více dětí než v oddíle $C$. Poměr počtu dětí v oddíle $A$ ku počtu dětí v oddíle $B$ je $4:3$. Graf udává počty chlapců a dívek v jednotlivých oddílech, dva údaje však chybí (viz obrázek).',
        'Rozhodněte o každém z následujících tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).',
        '11.1 V oddíle $C$ je $5$ dívek.',
        '11.2 V oddíle $B$ je chlapců o polovinu více než dívek.',
        '11.3 Na táboře je dívek o pětinu méně než chlapců.'],
     'opts': None, 'ln': 0, 'svg': SVG11, 'fn': 'graf-oddily.svg',
     'alt': 'Mezikružní (koláčový) graf tří oddílů A, B, C s počty chlapců a dívek; u oddílu A je 9 chlapců a 7 dívek, u oddílu B jsou 4 dívky, u oddílu C jsou 3 chlapci, dva údaje chybí.',
     'cap': 'Počty chlapců a dívek v oddílech (dva údaje chybí)',
     'sol': ['Oddíl $A$ má $9$ chlapců a $7$ dívek, celkem $16$ dětí. Oddíl $C$ má poloviční počet, tj. $8$ dětí; z toho $3$ chlapci, takže dívek je $8-3=5$. Poměr $A:B=4:3$ dává $B=\\frac{3}{4}\\cdot 16=12$ dětí; z toho $4$ dívky, takže chlapců je $12-4=8$.',
            '11.1 V oddíle $C$ je $5$ dívek — pravdivé (Ano).',
            '11.2 V oddíle $B$ je $8$ chlapců a $4$ dívky; chlapců je dvakrát více (o $100\\,\\%$), ne o polovinu — nepravdivé (Ne).',
            '11.3 Dívek je celkem $7+4+5=16$ a chlapců $9+8+3=20$; $16$ je o pětinu (o $4$) méně než $20$ — pravdivé (Ano).'],
     'ans': '11.1: Ano; 11.2: Ne; 11.3: Ano', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['statistika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9C 2023 – úloha 12', 'zad': [
        'Ve vlakové soupravě jsou pouze stejně dlouhé vagony a jedna lokomotiva. Lokomotiva je o čtvrtinu kratší než jeden vagon a její délka tvoří jednu sedmnáctinu délky celé vlakové soupravy.',
        'Kolik vagonů je celkem ve vlakové soupravě?'],
     'opts': ['A) $10$ vagonů', 'B) $11$ vagonů', 'C) $12$ vagonů', 'D) $13$ vagonů', 'E) jiný počet vagonů'],
     'ln': 0,
     'sol': ['Délku vagonu označme $1$, pak lokomotiva má délku $\\frac{3}{4}$. Je-li ve vlaku $n$ vagonů, souprava má délku $n+\\frac{3}{4}$ a lokomotiva tvoří její sedmnáctinu: $\\frac{3}{4}=\\frac{1}{17}\\cdot\\left(n+\\frac{3}{4}\\right)$. Odtud $17\\cdot\\frac{3}{4}=n+\\frac{3}{4}$, tj. $n=\\frac{51}{4}-\\frac{3}{4}=\\frac{48}{4}=12$.'],
     'ans': 'C) $12$ vagonů', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9C 2023 – úloha 13', 'zad': [
        'Pětiúhelník $ABCDE$ se skládá z rovnoramenného, rovnostranného a pravoúhlého trojúhelníku. Základnou rovnoramenného trojúhelníku je strana $AB$. Strany $BC$ a $AE$ pětiúhelníku jsou rovnoběžné. Vnitřní úhel při vrcholu $A$ má velikost $55^\\circ$ (viz obrázek).',
        'Jaká je velikost úhlu $\\omega$? Velikosti úhlů neměřte, ale vypočtěte.'],
     'opts': ['A) $65^\\circ$', 'B) $70^\\circ$', 'C) $75^\\circ$', 'D) $80^\\circ$', 'E) jiná velikost'],
     'ln': 0, 'svg': SVG13, 'fn': 'petiuhelnik.svg',
     'alt': 'Pětiúhelník ABCDE rozdělený na tři trojúhelníky; u vrcholu A je úhel 55 stupňů, u vrcholu C je pravý úhel a u vrcholu D je hledaný úhel omega.',
     'cap': 'Pětiúhelník ABCDE (schematický nákres)',
     'sol': ['Rovnoramenný trojúhelník $ABE$ má základnu $AB$, proto $|\\angle EAB|=|\\angle EBA|=55^\\circ$. Prostřední trojúhelník $EBD$ je rovnostranný, tedy $|\\angle EBD|=60^\\circ$.',
            'Protože $BC\\parallel AE$, je vnitřní úhel pětiúhelníku při vrcholu $B$ roven $180^\\circ-55^\\circ=125^\\circ$. Skládá se z úhlů $\\angle ABE=55^\\circ$, $\\angle EBD=60^\\circ$ a $\\angle DBC$, proto $|\\angle DBC|=125^\\circ-55^\\circ-60^\\circ=10^\\circ$.',
            'Trojúhelník $BCD$ je pravoúhlý s pravým úhlem u vrcholu $C$, takže $\\omega=|\\angle BDC|=90^\\circ-10^\\circ=80^\\circ$.'],
     'ans': 'D) $80^\\circ$', 'pts': 2, 'mins': 5, 'diff': '4',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2023 – úloha 14', 'zad': [
        'Povrch pravidelného čtyřbokého hranolu je $144$ cm². Obsah pláště tohoto hranolu je dvakrát větší než obsah jedné jeho čtvercové podstavy. (Plášť tohoto hranolu tvoří čtyři shodné boční stěny.) Viz obrázek.',
        'Jaký je objem hranolu?'],
     'opts': ['A) $72$ cm³', 'B) $108$ cm³', 'C) $144$ cm³', 'D) $216$ cm³', 'E) jiný objem'],
     'ln': 0, 'svg': SVG14, 'fn': 'hranol.svg',
     'alt': 'Pravidelný čtyřboký hranol (kvádr se čtvercovou podstavou) nakreslený schematicky.',
     'cap': 'Pravidelný čtyřboký hranol (schematický nákres)',
     'sol': ['Podstavou je čtverec o hraně $a$, výška hranolu je $v$. Obsah podstavy je $a^2$, obsah pláště $4av$. Ze zadání $4av=2a^2$, tedy $v=\\frac{a}{2}$.',
            'Povrch $S=2a^2+4av=2a^2+2a^2=4a^2=144$, odtud $a^2=36$, $a=6$ cm a $v=3$ cm. Objem $V=a^2\\cdot v=36\\cdot 3=108$ cm³.'],
     'ans': 'B) $108$ cm³', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['stereometrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9C 2023 – úloha 15', 'zad': [
        'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).',
        '15.1 Encyklopedie má o $25\\,\\%$ více stran než atlas, který má $200$ stran. Kolik stran má encyklopedie?',
        '15.2 Róza čte knihu, která má $500$ stran. Počet stran, které Róza již přečetla, je o $50\\,\\%$ větší než počet stran, které dosud nepřečetla. Kolik stran knihy Róza dosud nepřečetla?',
        '15.3 V knihovně jsou některé knihy psané německy, jiné anglicky a ostatní česky. Německy psaných je $30$ knih, což je $10\\,\\%$ všech knih v knihovně. Anglicky psané knihy tvoří pětinu všech knih v knihovně. Kolik je v knihovně česky psaných knih?'],
     'opts': ['A) méně než $210$', 'B) $210$', 'C) $220$', 'D) $240$', 'E) $250$', 'F) jiný počet'],
     'ln': 0,
     'sol': ['15.1 Encyklopedie má $200\\cdot 1{,}25=250$ stran — možnost E.',
            '15.2 Nepřečtených stran označme $n$, přečtených je $1{,}5n$; $n+1{,}5n=500$, tj. $2{,}5n=500$, tedy $n=200$. Róza nepřečetla $200$ stran (méně než $210$) — možnost A.',
            '15.3 Německých je $30$, což je $10\\,\\%$, takže celkem je $300$ knih. Anglických je $\\frac{1}{5}\\cdot 300=60$. Česky psaných je $300-30-60=210$ — možnost B.'],
     'ans': '15.1: E ($250$); 15.2: A (méně než $210$, tj. $200$); 15.3: B ($210$)', 'pts': 6, 'mins': 8, 'diff': '3',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9C 2023 – úloha 16', 'zad': [
        'Každý obrazec tvaru obdélníku je složen z malých šedých čtverečků a větších bílých čtverečků. Všechny šedé čtverečky jsou stejné a jsou poskládány do spodní řady a do levého sloupce. Zbytek obrazce tvoří bílé čtverečky. Každý bílý čtvereček má dvakrát delší stranu než šedý. První obrazec má ve spodní řadě $5$ šedých čtverečků a v levém sloupci $3$ šedé čtverečky a skládá se celkem z $9$ čtverečků (bílých i šedých dohromady). Každý další obrazec má oproti předchozímu vždy o $2$ šedé čtverečky více jak ve spodní řadě, tak i v levém sloupci (viz obrázek).',
        '16.1 Obrazec má ve spodní řadě $41$ šedých čtverečků. Určete počet bílých čtverečků v obrazci.',
        '16.2 V obrazci je $90$ bílých čtverečků. Určete počet šedých čtverečků v obrazci.',
        '16.3 Počet všech čtverečků (bílých i šedých dohromady) v posledním a v předposledním obrazci se liší o $106$. Určete počet šedých čtverečků v posledním obrazci.'],
     'opts': None, 'ln': 5, 'svg': SVG16, 'fn': 'obrazce-ctverecky.svg',
     'alt': '1. a 2. obrazec: obdélníky složené z malých šedých čtverečků ve spodní řadě a v levém sloupci a z větších bílých čtverečků vyplňujících zbytek.',
     'cap': '1. a 2. obrazec',
     'sol': ['V $n$-tém obrazci je ve spodní řadě $2n+3$ šedých čtverečků a v levém sloupci $2n+1$; šedých je celkem $(2n+3)+(2n+1)-1=4n+3$. Bílá oblast má šířku $2n+2$ a výšku $2n$ malých čtverečků, což je $\\frac{2n+2}{2}\\cdot\\frac{2n}{2}=n\\cdot(n+1)$ bílých čtverečků.',
            '16.1 Ze spodní řady $2n+3=41$ plyne $n=19$. Bílých je $19\\cdot 20=380$.',
            '16.2 Z $n\\cdot(n+1)=90$ plyne $n=9$; šedých je $4\\cdot 9+3=39$.',
            '16.3 Počet všech čtverečků v $n$-tém obrazci je $n\\cdot(n+1)+4n+3=n^2+5n+3$; rozdíl dvou po sobě jdoucích obrazců je $2n+4=106$, odkud $n=51$. Šedých je $4\\cdot 51+3=207$.'],
     'ans': '16.1: $380$ bílých čtverečků; 16.2: $39$ šedých čtverečků; 16.3: $207$ šedých čtverečků', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['posloupnosti', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M9PCD23C0T03'
    gen.YEAR = 2023

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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M9C-2023')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
