# -*- coding: utf-8 -*-
# CERMAT – Jednotná přijímací zkouška 2026, MATEMATIKA 7B (šestileté obory, 7. ročník),
# 2. řádný termín. Kód testu: M7PBD26C0T02. 16 úloh, 50 bodů.
# Po rozdělení nezávislých poduúloh (úloha 2.1 a 2.2) je zde 17 úloh.
# Zdroj odpovědí: klíč správných řešení (KSR), ověřeno vyplněným záznamovým archem (VZA).

# ---- SVG obrázky (bez ' a \) ----

# úloha 3: číselná osa – 8 bodů, 7 stejných dílků; první bod 40, A ve 4. dílku, B v 7. dílku
def _osa():
    x0 = 60; dx = 86; y = 100; n = 8
    pts = [x0 + i * dx for i in range(n)]
    W = pts[-1] + 60
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {W} 160" font-family="sans-serif">']
    s.append(f'<line x1="{x0-30}" y1="{y}" x2="{pts[-1]+40}" y2="{y}" stroke="#000" stroke-width="2"/>')
    s.append(f'<polygon points="{pts[-1]+40},{y} {pts[-1]+28},{y-6} {pts[-1]+28},{y+6}" fill="#000"/>')
    for px in pts:
        s.append(f'<line x1="{px}" y1="{y-9}" x2="{px}" y2="{y+9}" stroke="#000" stroke-width="2"/>')
    s.append(f'<text x="{pts[0]}" y="{y-18}" font-size="18" text-anchor="middle">40</text>')
    s.append(f'<text x="{pts[4]}" y="{y+32}" font-size="18" font-style="italic" text-anchor="middle">A</text>')
    s.append(f'<text x="{pts[7]}" y="{y+32}" font-size="18" font-style="italic" text-anchor="middle">B</text>')
    s.append('</svg>')
    return "".join(s)
SVG3 = _osa()

# úloha 4: rulička se stuhou; na volném konci se střídají bílé a červené proužky po 6 cm
def _stuha():
    y0 = 70; h = 30; seg = 40; nseg = 8; x0 = 130
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 180" font-family="sans-serif">']
    s.append('<circle cx="70" cy="85" r="48" fill="#e6e6e6" stroke="#000" stroke-width="2"/>')
    s.append('<circle cx="70" cy="85" r="14" fill="#fff" stroke="#000" stroke-width="2"/>')
    for i in range(nseg):
        col = '#ffffff' if i % 2 == 0 else '#b0b0b0'
        x = x0 + i * seg
        s.append(f'<rect x="{x}" y="{y0}" width="{seg}" height="{h}" fill="{col}" stroke="#000"/>')
    for i in range(2):
        x = x0 + i * seg
        yy = y0 + h + 22 + i * 22
        s.append(f'<line x1="{x}" y1="{yy}" x2="{x+seg}" y2="{yy}" stroke="#000"/>')
        s.append(f'<polygon points="{x},{yy} {x+8},{yy-4} {x+8},{yy+4}" fill="#000"/>')
        s.append(f'<polygon points="{x+seg},{yy} {x+seg-8},{yy-4} {x+seg-8},{yy+4}" fill="#000"/>')
        s.append(f'<text x="{x+seg/2}" y="{yy+16}" font-size="14" text-anchor="middle">6 cm</text>')
    s.append('</svg>')
    return "".join(s)
SVG4 = _stuha()

# úloha 6: záhon tvaru L (ABCDEF) – 6 stejných čtverců s obdélníkovými mezerami
def _lshape():
    sq = 40; g = 15
    # vertikální rameno: 4 čtverce + 3 mezery; horizontální: 3 čtverce + 2 mezery (rohový sdílený)
    bx = 40; by = 250; topY = by - (4 * sq + 3 * g)  # 250 - 205 = 45
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 240 290" font-family="sans-serif">']
    # čtverce vertikálního ramene
    yy = topY
    for i in range(4):
        s.append(f'<rect x="{bx}" y="{yy}" width="{sq}" height="{sq}" fill="#dcdcdc" stroke="#000"/>')
        yy += sq
        if i < 3:
            s.append(f'<rect x="{bx}" y="{yy}" width="{sq}" height="{g}" fill="#8f8f8f" stroke="#000"/>')
            yy += g
    # čtverce horizontálního ramene (bez rohového, ten už je nakreslen jako spodní vertikální)
    xx = bx + sq
    ytop = by - sq
    for i in range(2):
        s.append(f'<rect x="{xx}" y="{ytop}" width="{g}" height="{sq}" fill="#8f8f8f" stroke="#000"/>')
        xx += g
        s.append(f'<rect x="{xx}" y="{ytop}" width="{sq}" height="{sq}" fill="#dcdcdc" stroke="#000"/>')
        xx += sq
    # obrys ABCDEF
    A = (bx, topY); F = (bx + sq, topY); E = (bx + sq, by - sq)
    D = (xx, by - sq); C = (xx, by); B = (bx, by)
    pts = " ".join(f"{p[0]},{p[1]}" for p in [A, B, C, D, E, F])
    s.append(f'<polygon points="{pts}" fill="none" stroke="#000" stroke-width="2.5"/>')
    lbl = [('A', A[0]-12, A[1]-4), ('F', F[0]+4, F[1]-4), ('E', E[0]+4, E[1]-4),
           ('D', D[0]+4, D[1]-4), ('C', C[0]+4, C[1]+16), ('B', B[0]-12, B[1]+16)]
    for t, lx, ly in lbl:
        s.append(f'<text x="{lx}" y="{ly}" font-size="15" font-style="italic">{t}</text>')
    s.append('</svg>')
    return "".join(s)
SVG6 = _lshape()

# úloha 7: kvádr se šedými rovnoběžníky ve středech hran (schematický nákres)
SVG7 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 300 250" font-family="sans-serif">
<polygon points="60,80 120,40 240,40 180,80" fill="#f2f2f2" stroke="#000"/>
<polygon points="180,80 240,40 240,180 180,220" fill="#e2e2e2" stroke="#000"/>
<rect x="60" y="80" width="120" height="140" fill="#fafafa" stroke="#000"/>
<polygon points="120,80 180,150 120,220 60,150" fill="#9a9a9a" stroke="#000"/>
<polygon points="210,60 240,110 210,200 180,150" fill="#9a9a9a" fill-opacity="0.6" stroke="#000"/>
<text x="150" y="242" font-size="12" text-anchor="middle" fill="#555">schematický nákres kvádru</text>
</svg>"""

# úloha 8: body A, B, M v rovině
SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 300" font-family="sans-serif">
<rect x="10" y="10" width="480" height="280" fill="none" stroke="#ccc"/>
<text x="150" y="212" font-size="16">×</text><text x="146" y="230" font-size="15" font-style="italic">A</text>
<text x="250" y="150" font-size="16">×</text><text x="248" y="168" font-size="15" font-style="italic">M</text>
<text x="378" y="212" font-size="16">×</text><text x="376" y="230" font-size="15" font-style="italic">B</text>
</svg>"""

# úloha 9: přímka p a body Q, S
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 320" font-family="sans-serif">
<rect x="10" y="10" width="480" height="300" fill="none" stroke="#ccc"/>
<line x1="70" y1="150" x2="210" y2="300" stroke="#000" stroke-width="2"/>
<text x="60" y="150" font-size="16" font-style="italic">p</text>
<text x="280" y="90" font-size="16">×</text><text x="298" y="94" font-size="15" font-style="italic">Q</text>
<text x="300" y="220" font-size="16">×</text><text x="318" y="224" font-size="15" font-style="italic">S</text>
</svg>"""

# úloha 10: tabulka rozehraných a dohraných her
def _tab10():
    months = ['Leden', 'Únor', 'Březen', 'Duben', 'Květen', 'Červen']
    roz = [2, 1, 3, 1, 3, 1]; doh = [0, 2, 3, 5, 5, 7]
    x0 = 10; y0 = 10; lw = 170; cw = 72; rh = 32
    W = x0 + lw + 6 * cw + 10; H = y0 + 3 * rh + 10
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {W} {H}" font-family="sans-serif" font-size="13">']
    rows = [['Měsíc'] + months, ['Rozehraných her'] + [str(v) for v in roz], ['Dohraných her'] + [str(v) for v in doh]]
    for r in range(3):
        for cidx in range(7):
            cx = x0 if cidx == 0 else x0 + lw + (cidx - 1) * cw
            cwid = lw if cidx == 0 else cw
            cy = y0 + r * rh
            s.append(f'<rect x="{cx}" y="{cy}" width="{cwid}" height="{rh}" fill="none" stroke="#000"/>')
            anchor = 'start' if cidx == 0 else 'middle'
            tx = cx + 6 if cidx == 0 else cx + cwid / 2
            s.append(f'<text x="{tx}" y="{cy+rh/2+5}" text-anchor="{anchor}">{rows[r][cidx]}</text>')
    s.append('</svg>')
    return "".join(s)
SVG10 = _tab10()

# úloha 12: obdélníková podlaha 2 m x 1,25 m s dlaždičkami v rohu
SVG12 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 250" font-family="sans-serif">
<rect x="40" y="40" width="280" height="175" fill="none" stroke="#000" stroke-width="2"/>
<rect x="40" y="40" width="20" height="20" fill="none" stroke="#000"/>
<rect x="60" y="40" width="20" height="20" fill="none" stroke="#000"/>
<rect x="40" y="60" width="20" height="20" fill="none" stroke="#000"/>
<rect x="60" y="60" width="20" height="20" fill="none" stroke="#000"/>
<rect x="40" y="80" width="20" height="20" fill="none" stroke="#000"/>
<line x1="40" y1="232" x2="320" y2="232" stroke="#000"/>
<polygon points="40,232 50,228 50,236" fill="#000"/><polygon points="320,232 310,228 310,236" fill="#000"/>
<text x="180" y="248" font-size="14" text-anchor="middle">2 m</text>
<line x1="335" y1="40" x2="335" y2="215" stroke="#000"/>
<polygon points="335,40 331,50 339,50" fill="#000"/><polygon points="335,215 331,205 339,205" fill="#000"/>
<text x="343" y="132" font-size="14">1,25 m</text>
</svg>"""

# úloha 16: pravidla výměny dílů (schematický nákres)
SVG16 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 210" font-family="sans-serif" font-size="12">
<rect x="20" y="20" width="70" height="34" fill="#d8d8d8" stroke="#000"/>
<text x="110" y="42" font-size="18">to</text>
<rect x="150" y="16" width="40" height="16" fill="#d8d8d8" stroke="#000"/>
<rect x="200" y="16" width="40" height="16" fill="#d8d8d8" stroke="#000"/>
<rect x="150" y="40" width="40" height="16" fill="#d8d8d8" stroke="#000"/>
<rect x="200" y="40" width="40" height="16" fill="#d8d8d8" stroke="#000"/>
<text x="260" y="42" font-size="12">1 deska = 4 prkna</text>
<rect x="20" y="90" width="40" height="16" fill="#d8d8d8" stroke="#000"/>
<rect x="66" y="90" width="40" height="16" fill="#d8d8d8" stroke="#000"/>
<text x="120" y="102" font-size="18">to</text>
<rect x="150" y="80" width="90" height="6" fill="#c8c8c8" stroke="#000"/>
<rect x="150" y="90" width="90" height="6" fill="#c8c8c8" stroke="#000"/>
<rect x="150" y="100" width="90" height="6" fill="#c8c8c8" stroke="#000"/>
<rect x="150" y="110" width="90" height="6" fill="#c8c8c8" stroke="#000"/>
<rect x="150" y="120" width="90" height="6" fill="#c8c8c8" stroke="#000"/>
<text x="260" y="102" font-size="12">2 prkna = 5 tyčí</text>
<text x="20" y="165" font-size="12">1 kus ohrady = 3 prkna + 2 tyče</text>
</svg>"""

B = ['zs2', 'r7']  # 7. ročník ZŠ / šestileté obory (JPZ 2026)

PROBLEMS = [
    {'name': 'CERMAT M7B 2026 – úloha 1', 'zad': [
        'Ve větší krabičce je 200 kusů papírových kapesníků, což je o čtvrtinu více než v menší krabičce.',
        'Vypočtěte, kolik kusů papírových kapesníků je v menší krabičce.'],
     'opts': None, 'ln': 2,
     'sol': ['Menší krabička má $x$ kusů, větší o čtvrtinu více: $x + \\frac{1}{4}x = \\frac{5}{4}x = 200$, tedy $x = 200 \\cdot \\frac{4}{5} = 160$.'],
     'ans': '$160$ kusů', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7B 2026 – úloha 2.1', 'zad': [
        'Vypočtěte a výsledek zapište zlomkem v základním tvaru:',
        '$5 \\cdot \\frac{4}{25} - 3 + 3 : \\frac{5}{3} =$'],
     'opts': None, 'ln': 3,
     'sol': ['$5 \\cdot \\frac{4}{25} = \\frac{4}{5}$ a $3 : \\frac{5}{3} = 3 \\cdot \\frac{3}{5} = \\frac{9}{5}$.',
             'Celkem $\\frac{4}{5} - 3 + \\frac{9}{5} = \\frac{4 + 9}{5} - 3 = \\frac{13}{5} - \\frac{15}{5} = -\\frac{2}{5}$.'],
     'ans': '$-\\frac{2}{5}$', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2026 – úloha 2.2', 'zad': [
        'Vypočtěte a výsledek zapište zlomkem v základním tvaru:',
        '$\\frac{3 \\cdot \\frac{9}{100} + 1 : 100}{\\frac{4}{5} + \\frac{2}{50}} =$'],
     'opts': None, 'ln': 4,
     'sol': ['Čitatel: $3 \\cdot \\frac{9}{100} + 1 : 100 = \\frac{27}{100} + \\frac{1}{100} = \\frac{28}{100}$.',
             'Jmenovatel: $\\frac{4}{5} + \\frac{2}{50} = \\frac{40}{50} + \\frac{2}{50} = \\frac{42}{50}$.',
             'Podíl: $\\frac{28}{100} : \\frac{42}{50} = \\frac{28}{100} \\cdot \\frac{50}{42} = \\frac{28}{84} = \\frac{1}{3}$.'],
     'ans': '$\\frac{1}{3}$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2026 – úloha 3', 'zad': [
        'Na číselné ose je zobrazeno 8 bodů oddělujících 7 stejných dílků. V prvním z těchto bodů je číslo 40 a body $A$, $B$ představují další dvě čísla. Součet čísel v bodech $A$, $B$ je 168.',
        'Určete: 3.1 hodnotu, které odpovídá jeden dílek na číselné ose; 3.2 číslo v bodě $A$; 3.3 číslo v bodě $B$.'],
     'opts': None, 'ln': 3, 'svg': SVG3, 'fn': 'osa.svg',
     'alt': 'Číselná osa s osmi body a sedmi stejnými dílky; první bod je 40, bod A ve čtvrtém dílku a bod B v sedmém dílku.',
     'cap': 'Číselná osa s body A a B',
     'sol': ['Bod $A$ je vzdálen 4 dílky a bod $B$ 7 dílků od prvního bodu. Označme dílek $d$: $A = 40 + 4d$, $B = 40 + 7d$.',
             'Součet: $(40 + 4d) + (40 + 7d) = 80 + 11d = 168$, odtud $11d = 88$, tedy $d = 8$.',
             '3.1 jeden dílek $= 8$; 3.2 $A = 40 + 4 \\cdot 8 = 72$; 3.3 $B = 40 + 7 \\cdot 8 = 96$.'],
     'ans': '3.1: $8$; 3.2: $72$; 3.3: $96$', 'pts': 3, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2026 – úloha 4', 'zad': [
        'Na papírové ruličce je navinuta stuha delší než 9 m. Na volném konci stuhy je bílý proužek délky 6 cm, následuje červený proužek délky 6 cm a dále se tyto proužky pravidelně střídají. Od volného konce jsme odměřili a odstřihli část stuhy délky 1,7 metru na pomlázku.',
        'Určete: 4.1 kolik červených proužků je na odstřižené části stuhy na pomlázku; 4.2 kolik cm měří první necelý proužek na volném konci stuhy navinuté na ruličce po odstřižení části stuhy.'],
     'opts': None, 'ln': 3, 'svg': SVG4, 'fn': 'stuha.svg',
     'alt': 'Rulička s navinutou stuhou; na volném konci se pravidelně střídají bílé a červené proužky po 6 cm.',
     'cap': 'Stuha se střídajícími se proužky po 6 cm',
     'sol': ['Odstřižená část měří $170$ cm. Proužky po $6$ cm: $170 : 6 = 28$ celých proužků (dohromady $168$ cm) a zbylé $2$ cm patří $29.$ proužku.',
             '4.1 Bílý, červený, bílý, ... – červené jsou sudé proužky ($2., 4., \\ldots, 28.$), tj. $14$ červených. Necelý $29.$ proužek je bílý.',
             '4.2 Odstřihli jsme $2$ cm z $29.$ (bílého) proužku, na ruličce z něj zbývá $6 - 2 = 4$ cm.'],
     'ans': '4.1: $14$ červených proužků; 4.2: $4$ cm', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7B 2026 – úloha 5', 'zad': [
        'Farmář dal všechny sklizené cukety do beden. Naplnil 4 malé, 3 střední a 1 velkou bednu. Ve všech malých bednách byl stejný počet cuket, v každé střední bedně bylo o 30 cuket více než v malé bedně a ve velké bedně bylo 120 cuket. Ve skladu si farmář ponechal jednu velkou, jednu střední a jednu malou bednu s cuketami a zbývajících 310 cuket z ostatních beden prodal.',
        'Určete: 5.1 počet cuket v jedné malé bedně; 5.2 celkový počet cuket, které farmář sklidil.'],
     'opts': None, 'ln': 3,
     'sol': ['Malá bedna $x$ cuket, střední $x + 30$, velká $120$. Prodal cukety ze $3$ malých a $2$ středních beden: $3x + 2(x + 30) = 310$, tj. $5x + 60 = 310$, odtud $x = 50$.',
             '5.1 V jedné malé bedně je $50$ cuket.',
             '5.2 Celkem $4 \\cdot 50 + 3 \\cdot 80 + 120 = 200 + 240 + 120 = 560$ cuket.'],
     'ans': '5.1: $50$ cuket; 5.2: $560$ cuket', 'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['rovnice', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7B 2026 – úloha 6', 'zad': [
        'Záhon ve tvaru písmene L tvoří obrazec $ABCDEF$. Obrazec je rozdělen na 6 stejných čtverců, mezi nimiž jsou mezery tvaru obdélníku (viz obrázek). Všechny tyto obdélníky jsou stejné. Lomená čára $DEF$, která se skládá z úseček $DE$ a $EF$, má délku 550 cm. Lomená čára $ABC$, která se skládá z úseček $AB$ a $BC$, má délku 710 cm.',
        'Určete v cm: 6.1 délku úsečky $DE$; 6.2 obvod jednoho čtverce; 6.3 délku úsečky $AB$.'],
     'opts': None, 'ln': 3, 'svg': SVG6, 'fn': 'zahon-L.svg',
     'alt': 'Obrazec ABCDEF ve tvaru písmene L složený ze šesti stejných čtverců oddělených stejnými obdélníkovými mezerami.',
     'cap': 'Schematický nákres záhonu ve tvaru L',
     'sol': ['Označme stranu čtverce $s$ a šířku mezery $g$. Pak $DE = 2s + 2g$, $EF = 3s + 3g$, tedy $DEF = 5s + 5g = 550$. Dále $AB = 4s + 3g$, $BC = 3s + 2g$, tedy $ABC = 7s + 5g = 710$.',
             'Odečtením rovnic $5s + 5g = 550$ a $7s + 5g = 710$ dostaneme $2s = 160$, tj. $s = 80$ cm a $g = 30$ cm.',
             '6.1 $DE = 2 \\cdot 80 + 2 \\cdot 30 = 220$ cm.',
             '6.2 Obvod jednoho čtverce $= 4 \\cdot 80 = 320$ cm.',
             '6.3 $AB = 4 \\cdot 80 + 3 \\cdot 30 = 410$ cm.'],
     'ans': '6.1: $220$ cm; 6.2: $320$ cm; 6.3: $410$ cm', 'pts': 4, 'mins': 7, 'diff': '4',
     'codes': B + ['planimetrie', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7B 2026 – úloha 7', 'zad': [
        'Kvádr má podstavu o obsahu 54 cm². Obsahy tří stěn, které mají společný vrchol, jsou v poměru $6 : 15 : 10$. Nejmenší obsah z těchto tří stěn má podstava kvádru.',
        '7.1 Vypočtěte v cm² povrch celého kvádru.',
        '7.2 Obě podstavy kvádru jsou bílé. Na každé ze čtyř bočních stěn kvádru je šedý rovnoběžník, který má vrcholy ve středech hran kvádru (viz obrázek). Vypočtěte v cm² obsah všech čtyř šedých rovnoběžníků dohromady.'],
     'opts': None, 'ln': 4, 'svg': SVG7, 'fn': 'kvadr.svg',
     'alt': 'Kvádr, na jehož čtyřech bočních stěnách jsou šedé rovnoběžníky s vrcholy ve středech hran.',
     'cap': 'Schematický nákres kvádru se šedými rovnoběžníky',
     'sol': ['7.1 Nejmenší stěna (podstava) odpovídá $6$ dílům poměru a má $54$ cm², takže $1$ díl $= 54 : 6 = 9$ cm². Povrch tvoří dvě sady těchto tří stěn, tj. $2 \\cdot (6 + 15 + 10) = 62$ dílů. Povrch $= 62 \\cdot 9 = 558$ cm².',
             '7.2 Plášť (čtyři boční stěny) $= 558 - 2 \\cdot 54 = 450$ cm². Rovnoběžník spojující středy hran boční stěny má poloviční obsah než tato stěna, proto všechny čtyři dohromady mají $\\frac{1}{2} \\cdot 450 = 225$ cm².'],
     'ans': '7.1: $558$ cm²; 7.2: $225$ cm²', 'pts': 4, 'mins': 7, 'diff': '4',
     'codes': B + ['stereometrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2026 – úloha 8 (konstrukce)', 'zad': [
        'V rovině leží body $A$, $B$, $M$ (viz obrázek).',
        'Body $A$, $B$ jsou vrcholy kosočtverce $ABCD$. Bod $M$ leží na některé z úhlopříček tohoto kosočtverce.',
        'Sestrojte vrcholy $C$, $D$ kosočtverce $ABCD$, označte je písmeny a kosočtverec narýsujte. Najděte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG8, 'fn': 'body-ABM.svg',
     'alt': 'Body A, B (dole) a M (mezi nimi výše) v rovině.',
     'cap': 'Výchozí obrázek k úloze 8',
     'sol': ['Kosočtverec $ABCD$ má všechny strany shodné s $AB$; úhlopříčky $AC$ a $BD$ se navzájem půlí a jsou na sebe kolmé. Bod $M$ leží na jedné z úhlopříček, což dává dvě řešení.',
             '1. řešení ($M$ na úhlopříčce $AC$): vrchol $C$ je průsečík přímky $AM$ s kružnicí se středem $B$ a poloměrem $|AB|$. Vrchol $D$ doplníme tak, aby střed $S$ úhlopříčky $AC$ byl zároveň středem $BD$.',
             '2. řešení ($M$ na úhlopříčce $BD$): vrchol $D$ je průsečík přímky $BM$ s kružnicí se středem $A$ a poloměrem $|AB|$; vrchol $C$ doplníme tak, aby střed $BD$ byl zároveň středem $AC$.'],
     'ans': 'Dvě řešení podle toho, zda $M$ leží na úhlopříčce $AC$ (vrcholy $C_1$, $D_1$), nebo na úhlopříčce $BD$ (vrcholy $C_2$, $D_2$) – viz obrázek v klíči.',
     'pts': 3, 'mins': 7, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2026 – úloha 9 (konstrukce)', 'zad': [
        'V rovině leží přímka $p$ a body $Q$, $S$ (viz obrázek).',
        'Bod $S$ je střed základny $AB$ rovnoramenného trojúhelníku $ABC$. Základna $AB$ je kolmá na přímku $p$ a vrchol $A$ leží na přímce $p$. Vrchol $C$ trojúhelníku $ABC$ leží na přímce $AQ$.',
        'Sestrojte vrcholy trojúhelníku $ABC$, označte je písmeny a trojúhelník narýsujte.'],
     'opts': None, 'ln': 0, 'svg': SVG9, 'fn': 'primka-QS.svg',
     'alt': 'Přímka p a body Q a S v rovině.',
     'cap': 'Výchozí obrázek k úloze 9',
     'sol': ['Přímka $AB$ je kolmá na $p$ a prochází bodem $S$; její průsečík s přímkou $p$ je vrchol $A$. Vrchol $B$ je obrazem $A$ ve středové souměrnosti se středem $S$ (bod $S$ je střed $AB$).',
             'Trojúhelník je rovnoramenný se základnou $AB$, proto vrchol $C$ leží na ose základny, tj. na kolmici k $AB$ vedené bodem $S$ (na rovnoběžce s $p$ procházející bodem $S$). Vrchol $C$ je průsečík této osy s přímkou $AQ$.'],
     'ans': 'Vrchol $A$ je průsečík kolmice k $p$ vedené bodem $S$ s přímkou $p$; $B$ je souměrný s $A$ podle $S$; vrchol $C$ leží na průsečíku přímky $AQ$ s osou úsečky $AB$ – viz obrázek v klíči.',
     'pts': 2, 'mins': 6, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2026 – úloha 10', 'zad': [
        'Vojta dostal na začátku ledna k narozeninám novou herní konzoli a společně s ní i dvě hry. Obě hry začal v lednu hrát. V průběhu následujících měsíců získával další nové hry. Tabulka udává, kolik her získaných v tomto roce měl Vojta na konci uvedeného měsíce stále ještě rozehraných a kolik her měl již dohraných. Např. na konci června měl Vojta rozehranou jen 1 hru, zatímco dalších 7 her získaných v tomto roce již stihl do konce června dohrát.',
        'Rozhodněte o každém z následujících tvrzení 10.1–10.3, zda je pravdivé (A), či nikoli (N).',
        '10.1 V únoru Vojta dohrál alespoň jednu z her rozehraných v lednu.',
        '10.2 V březnu Vojta rozehrál pouze dvě nové hry.',
        '10.3 V květnu Vojta dohrál stejný počet her jako v dubnu.'],
     'opts': None, 'ln': 0, 'svg': SVG10, 'fn': 'tabulka-hry.svg',
     'alt': 'Tabulka počtu rozehraných a dohraných her na konci měsíců leden až červen: rozehraných 2, 1, 3, 1, 3, 1; dohraných 0, 2, 3, 5, 5, 7.',
     'cap': 'Počet rozehraných a dohraných her na konci měsíce',
     'sol': ['Na konci měsíce je celkem získaných her rovno součtu rozehraných a dohraných (dohrané se sčítají): leden $2$, únor $3$, březen $6$, duben $6$, květen $8$, červen $8$.',
             '10.1 Do konce února Vojta dohrál $2$ hry, přičemž kromě dvou lednových měl k dispozici jen $1$ novou únorovou hru; alespoň jednu lednovou hru tedy dohrál. Pravdivé (A).',
             '10.2 V březnu přibyly $6 - 3 = 3$ nové hry, ne dvě. Nepravdivé (N).',
             '10.3 V dubnu dohrál $5 - 3 = 2$ hry, v květnu $5 - 5 = 0$ her; počty se liší. Nepravdivé (N).'],
     'ans': '10.1: A; 10.2: N; 10.3: N', 'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['statistika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7B 2026 – úloha 11', 'zad': [
        'Na výrobu jednoho trička z recyklovaného materiálu je potřeba 5 plastových lahví. Při školní sběrové akci se podařilo nasbírat 1 200 plastových lahví, z nichž bylo pro výrobu triček 15 % nepoužitelných. Ze všech použitelných lahví se vyrobila trička.',
        'Kolik triček se vyrobilo z nasbíraných lahví?'],
     'opts': ['A) více než 204 triček', 'B) 204 triček', 'C) 180 triček', 'D) 104 triček', 'E) méně než 104 triček'],
     'ln': 0,
     'sol': ['Použitelných lahví je $85\\,\\%$ z $1\\,200$, tj. $0{,}85 \\cdot 1\\,200 = 1\\,020$. Z nich se vyrobilo $1\\,020 : 5 = 204$ triček.'],
     'ans': 'B) 204 triček', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7B 2026 – úloha 12', 'zad': [
        'Podlaha komory má tvar obdélníku o rozměrech 1,25 m a 2 m. Celá podlaha je vydlážděna dlaždičkami tvaru čtverce o obsahu 25 cm². Mezery mezi dlaždičkami neuvažujte.',
        'Kolik dlaždiček je na podlaze komory?'],
     'opts': ['A) 1000 dlaždiček', 'B) 500 dlaždiček', 'C) 400 dlaždiček', 'D) 100 dlaždiček', 'E) jiný počet dlaždiček'],
     'ln': 0, 'svg': SVG12, 'fn': 'podlaha.svg',
     'alt': 'Obdélníková podlaha o rozměrech 2 m krát 1,25 m vydlážděná čtvercovými dlaždičkami.',
     'cap': 'Schematický nákres podlahy komory',
     'sol': ['Podlaha má rozměry $125$ cm $\\times 200$ cm, tj. obsah $25\\,000$ cm². Jedna dlaždička má obsah $25$ cm². Počet dlaždiček $= 25\\,000 : 25 = 1\\,000$.'],
     'ans': 'A) 1000 dlaždiček', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['planimetrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7B 2026 – úloha 13', 'zad': [
        'Tři nádrže A, B, C mají stejný objem. K naplnění jednotlivých nádrží se používá různý počet čerpadel, která vždy pracují po celou dobu společně. Všechna čerpadla mají stejný výkon a ten se během jejich práce nemění. Prázdnou nádrž A zcela naplnilo 6 takových čerpadel za 40 minut.',
        'Prázdná nádrž B se zcela naplnila za dobu o polovinu delší než nádrž A. Kolik čerpadel bylo použito k naplnění nádrže B?'],
     'opts': ['A) 2 čerpadla', 'B) 3 čerpadla', 'C) 4 čerpadla', 'D) 9 čerpadel', 'E) 12 čerpadel'],
     'ln': 0,
     'sol': ['Objem nádrže je stejný, proto součin počtu čerpadel a doby je konstantní: $6 \\cdot 40 = 240$. Nádrž B se plnila $40 + 20 = 60$ minut, čerpadel bylo $240 : 60 = 4$.'],
     'ans': 'C) 4 čerpadla', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7B 2026 – úloha 14', 'zad': [
        'Tři nádrže A, B, C mají stejný objem. K naplnění se používá různý počet čerpadel se stejným neměnným výkonem, která pracují společně. Prázdnou nádrž A zcela naplnilo 6 čerpadel za 40 minut.',
        'Prázdná nádrž C se zcela naplnila za dobu o 25 % kratší než nádrž A. Kolik procent objemu nádrže C se zaplnilo během prvních 18 minut?'],
     'opts': ['A) $36\\,\\%$', 'B) $54\\,\\%$', 'C) $60\\,\\%$', 'D) $72\\,\\%$', 'E) jiný počet procent'],
     'ln': 0,
     'sol': ['Nádrž C se plnila o $25\\,\\%$ kratší dobu, tj. $40 \\cdot 0{,}75 = 30$ minut. Za prvních $18$ minut se zaplnilo $\\frac{18}{30} = 0{,}6 = 60\\,\\%$ objemu.'],
     'ans': 'C) $60\\,\\%$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7B 2026 – úloha 15', 'zad': [
        'V divadelním sále je celkem 300 míst. Při večerním představení obsadili muži 108 míst, ženy 120 míst a ostatní místa zůstala neobsazena.',
        'Přiřaďte ke každé otázce (15.1–15.3) správnou odpověď (A–F).',
        '15.1 Kolik procent všech míst zůstalo při večerním představení neobsazeno?',
        '15.2 Všechna obsazená místa byla zaplacena. Kromě nich byla zaplacena ještě jedna šestina neobsazených míst, neboť někteří předplatitelé kvůli nemoci nepřišli. Kolik procent všech míst nebylo na večerním představení zaplaceno?',
        '15.3 O kolik procent méně bylo na večerním představení mužů než žen?'],
     'opts': ['A) $10\\,\\%$', 'B) $15\\,\\%$', 'C) $18\\,\\%$', 'D) $20\\,\\%$', 'E) $24\\,\\%$', 'F) jiný počet procent'],
     'ln': 0,
     'sol': ['Neobsazená místa: $300 - 108 - 120 = 72$.',
             '15.1 $\\frac{72}{300} = 24\\,\\%$ míst zůstalo neobsazeno → E.',
             '15.2 Zaplaceno bylo $228$ obsazených míst a navíc šestina neobsazených, tj. $\\frac{72}{6} = 12$ míst; celkem $240$. Nezaplaceno zůstalo $300 - 240 = 60$ míst, tj. $\\frac{60}{300} = 20\\,\\%$ → D.',
             '15.3 Mužů bylo o $120 - 108 = 12$ méně než žen, tj. $\\frac{12}{120} = 10\\,\\%$ → A.'],
     'ans': '15.1: E ($24\\,\\%$); 15.2: D ($20\\,\\%$); 15.3: A ($10\\,\\%$)', 'pts': 6, 'mins': 9, 'diff': '4',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7B 2026 – úloha 16', 'zad': [
        'V počítačové hře se vyměňují desky, prkna a tyče pouze podle následujících pravidel: jednu desku lze vyměnit za 4 prkna; libovolnou dvojici prken lze vyměnit za 5 tyčí. Z vyměněných dílů vytváříme ohradu: na 1 kus ohrady potřebujeme 3 prkna a 2 tyče. K dispozici máme pouze desky a postupně je měníme za díly k ohradě.',
        '16.1 Určete, kolik nejméně desek potřebujeme na 3 kusy ohrady.',
        '16.2 Celkem 6 desek použijeme k vytvoření co největšího počtu kusů ohrady. Určete, které nepoužité díly nám zbudou a v jakém počtu.',
        '16.3 Máme k dispozici 19 desek. Určete, kolik nejvíce kusů ohrady můžeme vytvořit.'],
     'opts': None, 'ln': 4, 'svg': SVG16, 'fn': 'hra-dily.svg',
     'alt': 'Pravidla výměny: 1 deska za 4 prkna, 2 prkna za 5 tyčí; 1 kus ohrady je z 3 prken a 2 tyčí.',
     'cap': 'Schematický nákres pravidel výměny dílů',
     'sol': ['Pravidla: $1$ deska $= 4$ prkna, $2$ prkna $= 5$ tyčí, $1$ kus ohrady $= 3$ prkna $+ 2$ tyče.',
             '16.1 Na $3$ kusy ohrady je potřeba $9$ prken (přímo) a $6$ tyčí. Na $6$ tyčí je nutné vyměnit $4$ prkna (dvě výměny po $5$ tyčích dávají $10$ tyčí). Celkem $9 + 4 = 13$ prken; $3$ desky dají jen $12$ prken, proto jsou potřeba $4$ desky ($16$ prken).',
             '16.2 Z $6$ desek je $24$ prken. Nejvíce vznikne $6$ kusů ohrady: $18$ prken přímo a $6$ prken vyměníme za $15$ tyčí ($3$ výměny). Ohrady spotřebují $6 \\cdot 2 = 12$ tyčí, zbudou tedy $3$ tyče (prkna i desky se spotřebují beze zbytku).',
             '16.3 Z $19$ desek je $76$ prken. Pro $n$ kusů ohrady je potřeba $3n$ prken přímo a na $2n$ tyčí další výměny po $2$ prknech. Pro $n = 20$: $60 + 16 = 76$ prken (přesně vychází); $n = 21$ by vyžadovalo $81$ prken. Nejvíce lze vytvořit $20$ kusů ohrady.'],
     'ans': '16.1: $4$ desky; 16.2: zbudou $3$ tyče; 16.3: $20$ kusů ohrady', 'pts': 4, 'mins': 8, 'diff': '4',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M7PBD26C0T02'
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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M7B-2026')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
