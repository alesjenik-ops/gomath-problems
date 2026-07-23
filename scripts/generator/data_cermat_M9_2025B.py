# -*- coding: utf-8 -*-
# CERMAT - Jednotna prijimaci zkouska 2025, MATEMATIKA 9B (ctyrlete obory), 2. radny termin.
# Kod testu: M9PBD25C0T02. 16 uloh (po rozdeleni izolovanych poduloh 20 uloh).
# Zdroj odpovedi: klic spravnych reseni (KSR).

import math

# ---- SVG obrazky (bez ' a \) ----

# uloha 8: velky pravouhly lichobeznik (100/140/30) a jeho rozdeleni na mensi
# lichoznik a rovnobeznik. Meritko cca 1,2 px/cm (vyska schematicky zvyraznena).
SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 180" font-family="sans-serif">
<polygon points="20,140 188,140 140,86 20,86" fill="none" stroke="#000" stroke-width="2"/>
<text x="80" y="78" font-size="13" text-anchor="middle">100 cm</text>
<text x="104" y="158" font-size="13" text-anchor="middle">140 cm</text>
<text x="14" y="118" font-size="13" text-anchor="end">30 cm</text>
<rect x="20" y="128" width="12" height="12" fill="none" stroke="#000"/>
<polygon points="280,140 448,140 400,86 280,86" fill="none" stroke="#000" stroke-width="2"/>
<line x1="382" y1="140" x2="334" y2="86" stroke="#000" stroke-width="1.6"/>
<text x="303" y="78" font-size="11" text-anchor="middle">mensi lichobeznik</text>
<text x="405" y="132" font-size="11" text-anchor="middle">rovnobeznik</text>
<rect x="280" y="128" width="12" height="12" fill="none" stroke="#000"/>
</svg>"""

# uloha 9: body A, B, M v rovine (vychozi obrazek)
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 240" font-family="sans-serif">
<rect x="10" y="10" width="340" height="220" fill="none" stroke="#ccc"/>
<text x="188" y="112" font-size="15" text-anchor="middle">x</text>
<text x="188" y="100" font-size="14" text-anchor="middle" font-style="italic">M</text>
<text x="96" y="182" font-size="15" text-anchor="middle">x</text>
<text x="96" y="196" font-size="14" text-anchor="middle" font-style="italic">A</text>
<text x="256" y="172" font-size="15" text-anchor="middle">x</text>
<text x="256" y="186" font-size="14" text-anchor="middle" font-style="italic">B</text>
</svg>"""

# uloha 10: body A, D, M v rovine (vychozi obrazek)
SVG10 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 240" font-family="sans-serif">
<rect x="10" y="10" width="340" height="220" fill="none" stroke="#ccc"/>
<text x="250" y="118" font-size="15" text-anchor="middle">x</text>
<text x="250" y="106" font-size="14" text-anchor="middle" font-style="italic">M</text>
<text x="96" y="176" font-size="15" text-anchor="middle">x</text>
<text x="96" y="190" font-size="14" text-anchor="middle" font-style="italic">D</text>
<text x="152" y="194" font-size="15" text-anchor="middle">x</text>
<text x="152" y="208" font-size="14" text-anchor="middle" font-style="italic">A</text>
</svg>"""

# uloha 11: kruhovy diagram 6 druhu rostlin (uhly ve stupnich)
def _pie():
    cx, cy, r = 150, 150, 118
    secs = [(15, "#111111"), (60, "#d9d9d9"), (105, "#8f8f8f"),
            (90, "#b7b7b7"), (30, "#efefef"), (60, "#fbfbfb")]
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 300" font-family="sans-serif">']
    ang = 0.0
    for a, fill in secs:
        a0 = ang; a1 = ang + a
        x0 = cx + r*math.sin(math.radians(a0)); y0 = cy - r*math.cos(math.radians(a0))
        x1 = cx + r*math.sin(math.radians(a1)); y1 = cy - r*math.cos(math.radians(a1))
        large = 1 if a > 180 else 0
        s.append(f'<path d="M {cx} {cy} L {x0:.1f} {y0:.1f} A {r} {r} 0 {large} 1 {x1:.1f} {y1:.1f} Z" fill="{fill}" stroke="#000"/>')
        mid = math.radians((a0 + a1) / 2)
        lx = cx + 0.64*r*math.sin(mid); ly = cy - 0.64*r*math.cos(mid)
        s.append(f'<text x="{lx:.1f}" y="{ly:.1f}" font-size="11" text-anchor="middle">{a} st.</text>')
        ang = a1
    leg = [("Magnolie", "#d9d9d9"), ("Jablon", "#8f8f8f"), ("Ruze", "#b7b7b7"),
           ("Hortenzie", "#efefef"), ("Levandule", "#fbfbfb"), ("Bazalka", "#111111")]
    ly = 46
    for name, fill in leg:
        s.append(f'<rect x="300" y="{ly}" width="14" height="14" fill="{fill}" stroke="#000"/>')
        s.append(f'<text x="320" y="{ly+12}" font-size="12">{name}</text>')
        ly += 28
    s.append('</svg>')
    return "".join(s)
SVG11 = _pie()

# uloha 12: dva shodne rovnoramenne trojuhelniky a primka p (ilustrativni)
SVG12 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 190" font-family="sans-serif">
<line x1="20" y1="150" x2="440" y2="150" stroke="#000" stroke-width="1.5"/>
<text x="446" y="155" font-size="14" font-style="italic">p</text>
<polygon points="60,150 180,150 120,55" fill="none" stroke="#000" stroke-width="2"/>
<text x="120" y="74" font-size="12" text-anchor="middle">40 st.</text>
<polygon points="300,150 250,62 362,96" fill="none" stroke="#000" stroke-width="2"/>
<text x="286" y="143" font-size="14">a</text>
</svg>"""

# uloha 13: krychle 4x4x4, sede krychlicky na uhlopricce steny (schematicky)
def _cube():
    ox, oy, c, dx, dy = 40, 70, 40, 55, -35
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 260" font-family="sans-serif">']
    for k in range(4):
        s.append(f'<rect x="{ox+k*c}" y="{oy+k*c}" width="{c}" height="{c}" fill="#b7b7b7" stroke="#000"/>')
    for i in range(5):
        s.append(f'<line x1="{ox+i*c}" y1="{oy}" x2="{ox+i*c}" y2="{oy+4*c}" stroke="#000"/>')
        s.append(f'<line x1="{ox}" y1="{oy+i*c}" x2="{ox+4*c}" y2="{oy+i*c}" stroke="#000"/>')
    s.append(f'<path d="M {ox} {oy} L {ox+dx} {oy+dy} L {ox+4*c+dx} {oy+dy} L {ox+4*c} {oy} Z" fill="none" stroke="#000"/>')
    s.append(f'<path d="M {ox+4*c} {oy} L {ox+4*c+dx} {oy+dy} L {ox+4*c+dx} {oy+dy+4*c} L {ox+4*c} {oy+4*c} Z" fill="none" stroke="#000"/>')
    s.append('<text x="180" y="248" font-size="11" text-anchor="middle" fill="#555">Schematicky nakres krychle 4 krat 4 krat 4 (sede na uhlopprickach sten).</text>')
    s.append('</svg>')
    return "".join(s)
SVG13 = _cube()

# uloha 14: dvoupatrovy dort - dva valce (schematicky)
SVG14 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 340 240" font-family="sans-serif">
<ellipse cx="160" cy="200" rx="120" ry="20" fill="#eee" stroke="#000"/>
<path d="M 40 155 L 40 200 A 120 20 0 0 0 280 200 L 280 155" fill="#f4f4f4" stroke="#000"/>
<ellipse cx="160" cy="155" rx="120" ry="20" fill="#f4f4f4" stroke="#000"/>
<path d="M 70 110 L 70 155 A 90 16 0 0 0 250 155 L 250 110" fill="#fafafa" stroke="#000"/>
<ellipse cx="160" cy="110" rx="90" ry="16" fill="#fafafa" stroke="#000"/>
<text x="300" y="160" font-size="12">r = 8 cm</text>
<text x="300" y="112" font-size="12">r = 6 cm</text>
<text x="6" y="182" font-size="12">v = 5 cm</text>
</svg>"""

B = ['zs2', 'r9']  # 9. rocnik ZS (prijimacky na ctyrlete obory)

PROBLEMS = [
    {'name': 'CERMAT M9B 2025 - uloha 1', 'zad': [
        'Cena detske vstupenky do muzea je rovna dvema petinam ceny vstupenky pro dospeleho. Jeden dospely se tremi detmi zaplatil za vstupenky 330 korun.',
        'Vypoctete v korunach cenu jedne detske vstupenky.'],
     'opts': None, 'ln': 2,
     'sol': ['Cena pro dospeleho $d$, detska $\\frac{2}{5}d$. Rovnice $d+3\\cdot\\frac{2}{5}d=330$, tj. $\\frac{11}{5}d=330$, odtud $d=150$ korun. Detska vstupenka stoji $\\frac{2}{5}\\cdot 150=60$ korun.'],
     'ans': '$60$ korun', 'pts': 1, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'finance']},

    {'name': 'CERMAT M9B 2025 - uloha 2', 'zad': [
        'Vypoctete druhou odmocninu ze soucinu smisenych cisel $6\\frac{1}{4}$ a $2\\frac{7}{9}$. Vysledek zapiste zlomkem v zakladnim tvaru.'],
     'opts': None, 'ln': 2,
     'sol': ['$6\\frac{1}{4}=\\frac{25}{4}$, $2\\frac{7}{9}=\\frac{25}{9}$. Soucin $\\frac{25}{4}\\cdot\\frac{25}{9}=\\frac{625}{36}$. Odmocnina $\\sqrt{\\frac{625}{36}}=\\frac{25}{6}$.'],
     'ans': '$\\frac{25}{6}$', 'pts': 1, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2025 - uloha 3.1', 'zad': [
        'Vypoctete a vysledek zapiste zlomkem v zakladnim tvaru:',
        '$\\left(\\frac{11}{5}-\\frac{11}{6}\\right):\\left(-\\frac{1}{3}\\right)=$'],
     'opts': None, 'ln': 2,
     'sol': ['$\\frac{11}{5}-\\frac{11}{6}=\\frac{66-55}{30}=\\frac{11}{30}$. Deleni: $\\frac{11}{30}:\\left(-\\frac{1}{3}\\right)=\\frac{11}{30}\\cdot(-3)=-\\frac{11}{10}$.'],
     'ans': '$-\\frac{11}{10}$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2025 - uloha 3.2', 'zad': [
        'Vypoctete a vysledek zapiste zlomkem v zakladnim tvaru:',
        '$\\frac{20-\\sqrt{4\\cdot 3^2}}{3\\cdot\\sqrt{100-64}}:\\frac{4+3}{4\\cdot 3}=$'],
     'opts': None, 'ln': 3,
     'sol': ['Citatel $20-\\sqrt{4\\cdot 9}=20-6=14$, jmenovatel $3\\cdot\\sqrt{36}=18$, tedy $\\frac{14}{18}=\\frac{7}{9}$. Dale $\\frac{7}{9}:\\frac{7}{12}=\\frac{7}{9}\\cdot\\frac{12}{7}=\\frac{12}{9}=\\frac{4}{3}$.'],
     'ans': '$\\frac{4}{3}$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2025 - uloha 4.1', 'zad': [
        'Upravte na co nejjednodussi tvar bez zavorek:',
        '$x\\cdot 3x-2x\\cdot 3-(x-3)^2=$'],
     'opts': None, 'ln': 2,
     'sol': ['$3x^2-6x-(x^2-6x+9)=3x^2-6x-x^2+6x-9=2x^2-9$.'],
     'ans': '$2x^2-9$', 'pts': 1, 'mins': 3, 'diff': '2',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2025 - uloha 4.2', 'zad': [
        'Upravte a vysledny vyraz rozlozte na soucin vytknutim:',
        '$(2k)^2-k\\cdot(1+2k)=$'],
     'opts': None, 'ln': 2,
     'sol': ['$(2k)^2-k\\cdot(1+2k)=4k^2-k-2k^2=2k^2-k=k\\cdot(2k-1)$.'],
     'ans': '$k\\cdot(2k-1)$', 'pts': 1, 'mins': 3, 'diff': '2',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2025 - uloha 4.3', 'zad': [
        'Upravte na co nejjednodussi tvar bez zavorek:',
        '$7a\\cdot(a+3)+2\\cdot(1-3a)\\cdot(a+5)=$'],
     'opts': None, 'ln': 3,
     'sol': ['$7a\\cdot(a+3)=7a^2+21a$. $2\\cdot(1-3a)\\cdot(a+5)=2\\cdot(a+5-3a^2-15a)=2\\cdot(-3a^2-14a+5)=-6a^2-28a+10$. Soucet: $7a^2+21a-6a^2-28a+10=a^2-7a+10$.'],
     'ans': '$a^2-7a+10$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2025 - uloha 5.1', 'zad': [
        'Reste rovnici:',
        '$\\frac{7}{12}x+2\\cdot\\left(\\frac{3}{8}x-1\\right)=-3\\cdot\\left(\\frac{x}{9}+1\\right)$'],
     'opts': None, 'ln': 4,
     'sol': ['Roznasobenim: $\\frac{7}{12}x+\\frac{3}{4}x-2=-\\frac{1}{3}x-3$. Vlevo $\\frac{7}{12}x+\\frac{9}{12}x=\\frac{4}{3}x$. Rovnice $\\frac{4}{3}x-2=-\\frac{1}{3}x-3$, odtud $\\frac{5}{3}x=-1$, tedy $x=-\\frac{3}{5}$.'],
     'ans': '$x=-\\frac{3}{5}$', 'pts': 2, 'mins': 5, 'diff': '3',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2025 - uloha 5.2', 'zad': [
        'Reste soustavu rovnic:',
        '$6x+y=14$',
        '$3x+2y=1$'],
     'opts': None, 'ln': 4,
     'sol': ['Z prvni rovnice $y=14-6x$. Dosazenim: $3x+2(14-6x)=1$, tj. $3x+28-12x=1$, $-9x=-27$, $x=3$. Pak $y=14-18=-4$.'],
     'ans': '$x=3$; $y=-4$', 'pts': 2, 'mins': 5, 'diff': '3',
     'codes': B + ['rovnice', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2025 - uloha 6', 'zad': [
        'Cislo 231 lze rozlozit na soucin tri prvocisel $a\\cdot b\\cdot c$.',
        'Urcete:',
        '6.1 nejmensi z prvocisel $a$, $b$, $c$,',
        '6.2 soucet vsech tri prvocisel $a+b+c$,',
        '6.3 nejvetsi dvojciferne cislo, ktere je delitelem cisla 231.'],
     'opts': None, 'ln': 3,
     'sol': ['Rozklad $231=3\\cdot 7\\cdot 11$.',
             '6.1 Nejmensi prvocislo je $3$.',
             '6.2 Soucet $3+7+11=21$.',
             '6.3 Delitele cisla 231 jsou $1,3,7,11,21,33,77,231$; nejvetsi dvojciferny je $77$.'],
     'ans': '6.1: $3$; 6.2: $21$; 6.3: $77$', 'pts': 3, 'mins': 4, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2025 - uloha 7', 'zad': [
        'Farmar prodaval salaty za jednotnou cenu za kus a v prubehu tri dnu vsechny salaty prodal. Prvni den prodal tretinu vsech salatu, druhy den prodal o tretinu mene salatu nez prvni den a treti den prodal zbytek salatu.',
        '7.1 Za vsechny prodane salaty utrzil farmar celkem 5 400 korun. Vypoctete, kolik korun utrzil farmar za salaty prodane druhy den.',
        '7.2 Pocet vsech salatu, ktere farmar prodal, oznacime $x$. Vyjadrete vyrazem s promennou $x$, kolik salatu prodal farmar druhy den.',
        '7.3 Treti den prodal farmar 120 salatu. Urcete pocet vsech salatu, ktere farmar prodal.'],
     'opts': None, 'ln': 4,
     'sol': ['Prvni den $\\frac{1}{3}$ vsech, druhy den o tretinu mene, tj. $\\frac{2}{3}\\cdot\\frac{1}{3}=\\frac{2}{9}$ vsech, treti den zbytek $1-\\frac{1}{3}-\\frac{2}{9}=\\frac{4}{9}$ vsech.',
             '7.1 Na druhy den pripada $\\frac{2}{9}$ trzby: $\\frac{2}{9}\\cdot 5400=1200$ korun.',
             '7.2 Druhy den $\\frac{2}{9}x$ salatu.',
             '7.3 Treti den $\\frac{4}{9}x=120$, odtud $x=270$ salatu.'],
     'ans': '7.1: $1200$ korun; 7.2: $\\frac{2}{9}x$; 7.3: $270$ salatu', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9B 2025 - uloha 8', 'zad': [
        'Velky pravouhly lichobeznik, jehoz rozmery jsou uvedeny na obrazku vlevo, jsme jednou useckou rozdelili na mensi lichobeznik a rovnobeznik (obrazek vpravo). Oba tyto nove utvary (mensi lichobeznik a rovnobeznik) maji stejny obvod. Rozmery velkeho lichobezniku: kratsi zakladna $100$ cm, delsi zakladna $140$ cm, vyska (kolme rameno) $30$ cm.',
        '8.1 Vypoctete v cm^2 obsah velkeho pravouhleho lichobezniku.',
        '8.2 Vypoctete v cm obvod velkeho pravouhleho lichobezniku.',
        '8.3 Vypoctete v cm obvod rovnobezniku.'],
     'opts': None, 'ln': 3, 'svg': SVG8, 'fn': 'lichobeznik.svg',
     'alt': 'Vlevo velky pravouhly lichobeznik s rozmery 100 cm, 140 cm a 30 cm; vpravo jeho rozdeleni na mensi lichobeznik a rovnobeznik.',
     'cap': 'Schematicky nakres (rozmery dle zadani)',
     'sol': ['8.1 Obsah $\\frac{100+140}{2}\\cdot 30=120\\cdot 30=3600$ cm$^2$.',
             '8.2 Sikme rameno: vodorovny rozdil zakladen $140-100=40$ cm, svisly $30$ cm, tedy $\\sqrt{40^2+30^2}=50$ cm. Obvod $100+140+30+50=320$ cm.',
             '8.3 Rovnobeznik ma dve strany shodne se sikmym ramenem ($50$ cm) a dve strany delky $s$ (casti zakladen); mensi lichobeznik ma strany $30$ cm, $50$ cm a casti zakladen $100-s$ a $140-s$. Z rovnosti obvodu $2s+2\\cdot 50=30+50+(100-s)+(140-s)$, tj. $2s+100=320-2s$, plyne $s=55$ cm. Obvod rovnobezniku $2\\cdot 55+2\\cdot 50=210$ cm.'],
     'ans': '8.1: $3600$ cm$^2$; 8.2: $320$ cm; 8.3: $210$ cm', 'pts': 4, 'mins': 7, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2025 - uloha 9 (konstrukce)', 'zad': [
        'V rovine lezi body $A$, $B$, $M$ (viz obrazek).',
        'Body $A$, $B$ jsou vrcholy rovnoramenneho trojuhelniku $ABC$. Bod $M$ je uvnitr tohoto trojuhelniku a lezi na teznici $t_c$ na stranu $AB$. (Bod $M$ neni tezistem trojuhelniku $ABC$.)',
        'Sestrojte vrchol $C$ trojuhelniku $ABC$, oznacte ho pismenem a trojuhelnik narysujte. Najdete vsechna reseni.'],
     'opts': None, 'ln': 0, 'svg': SVG9, 'fn': 'body-ABM.svg',
     'alt': 'Body A, B a M v rovine; M lezi nad useckou AB.',
     'cap': 'Vychozi obrazek k uloze 9',
     'sol': ['Teznice $t_c$ spojuje stred $S$ strany $AB$ s vrcholem $C$; protoze na ni lezi bod $M$, sestrojime primku $l$ prochazejici stredem $S$ usecky $AB$ a bodem $M$ - na ni lezi hledany vrchol $C$. Trojuhelnik je rovnoramenny s ramenem $AB$: bud $|AC|=|AB|$ (vrchol $C_1$ jako prusecik primky $l$ s kruznici se stredem $A$ a polomerem $|AB|$), nebo $|BC|=|AB|$ (vrchol $C_2$ jako prusecik primky $l$ s kruznici se stredem $B$ a polomerem $|AB|$). Uloha ma dve reseni.'],
     'ans': 'Dve reseni: stred $S$ usecky $AB$, primka $l=SM$ nese vrchol $C$; $C_1$ na kruznici $(A;|AB|)$, $C_2$ na kruznici $(B;|AB|)$ - viz obrazek v klici.',
     'pts': 3, 'mins': 7, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2025 - uloha 10 (konstrukce)', 'zad': [
        'V rovine lezi body $A$, $D$, $M$ (viz obrazek).',
        'Body $A$, $D$ jsou vrcholy rovnobezniku $ABCD$. Na poloprimce $DM$ lezi jedna z uhlopricek tohoto rovnobezniku. Druha uhlopricka rovnobezniku $ABCD$ ma stejnou delku jako usecka $DM$.',
        'Sestrojte vrcholy $B$, $C$ rovnobezniku $ABCD$, oznacte je pismeny a rovnobeznik narysujte.'],
     'opts': None, 'ln': 0, 'svg': SVG10, 'fn': 'body-ADM.svg',
     'alt': 'Body A, D a M v rovine.',
     'cap': 'Vychozi obrazek k uloze 10',
     'sol': ['V rovnobezniku $ABCD$ se uhlopricky $AC$ a $BD$ puli ve stredu $S$. Uhlopricka $BD$ lezi na poloprimce $DM$, takze vrchol $B$ i stred $S$ lezi na poloprimce $DM$. Protoze $|AC|=|DM|$ a $S$ je stred usecky $AC$, plati $|AS|=\\frac{|DM|}{2}$; stred $S$ najdeme jako prusecik poloprimky $DM$ s kruznici se stredem $A$ a polomerem $\\frac{|DM|}{2}$. Vrchol $C$ je obrazem bodu $A$ ve stredove soumernosti se stredem $S$ (lezi na kruznici $(A;|DM|)$), vrchol $B$ obrazem bodu $D$ podle tehoz stredu. Uloha ma jedno reseni.'],
     'ans': 'Stred $S$ = prusecik poloprimky $DM$ s kruznici $\\left(A;\\frac{|DM|}{2}\\right)$; $C$ obraz $A$ podle $S$ (na kruznici $(A;|DM|)$), $B$ obraz $D$ podle $S$ - viz obrazek v klici.',
     'pts': 3, 'mins': 7, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2025 - uloha 11', 'zad': [
        'V zahrade se pestuje 6 druhu rostlin. Diagram udava, jakou cast osazene plochy zahrady zabiraji jednotlive druhy rostlin; v kazde casti se pestuje pouze jeden druh. Magnolie zabiraji plochu o rozloze 20 m^2. U nekterych vyseci je uvedena velikost prislusneho uhlu.',
        'Rozhodnete o kazdem z nasledujicich tvrzeni (11.1-11.3), zda je pravdive (A), ci nikoli (N).',
        '11.1 Jablone zabiraji o 15 m^2 vetsi plochu, nez zabiraji magnolie.',
        '11.2 Levandule a bazalka dohromady zabiraji 1,5krat vetsi plochu nez hortenzie.',
        '11.3 Ruze zabiraji plochu mensi nez 30 m^2.'],
     'opts': None, 'ln': 0, 'svg': SVG11, 'fn': 'graf-zahrada.svg',
     'alt': 'Kruhovy diagram sesti druhu rostlin s uhly vyseci; magnolie 60 stupnu, jablon 105, ruze 90, bazalka 15, hortenzie 30, levandule 60.',
     'cap': 'Rozdeleni plochy zahrady (velikosti uhlu ve stupnich)',
     'sol': ['Magnolie $60^\\circ$ odpovida $20$ m$^2$, tedy $1^\\circ=\\frac{1}{3}$ m$^2$ a cela zahrada $360^\\circ=120$ m$^2$. Jablon $105^\\circ=35$ m$^2$, ruze $90^\\circ=30$ m$^2$, levandule $60^\\circ=20$ m$^2$, hortenzie $30^\\circ=10$ m$^2$, bazalka $15^\\circ=5$ m$^2$.',
             '11.1 $35-20=15$ m$^2$, tedy pravdive (A).',
             '11.2 Levandule a bazalka $20+5=25$ m$^2$; $1{,}5\\cdot 10=15$ m$^2$. Protoze $25\\neq 15$, nepravdive (N).',
             '11.3 Ruze zabiraji $30$ m$^2$, coz neni mene nez $30$ m$^2$, tedy nepravdive (N).'],
     'ans': '11.1: A; 11.2: N; 11.3: N', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['statistika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9B 2025 - uloha 12', 'zad': [
        'V rovine lezi dva shodne rovnoramenne trojuhelniky a primka $p$ rovnobezna se zakladnou jednoho z nich. Druhy trojuhelnik ma prave jedno rameno rovnobezne s ramenem prvniho trojuhelniku. Uhel pri hlavnim vrcholu prvniho trojuhelniku ma velikost $40^\\circ$ (viz obrazek).',
        'Jaka je velikost uhlu $\\alpha$? Velikosti uhlu nemerte, ale vypoctete (obrazek je pouze ilustrativni).'],
     'opts': ['A) $160^\\circ$', 'B) $140^\\circ$', 'C) $130^\\circ$', 'D) $110^\\circ$', 'E) jina velikost'],
     'ln': 0, 'svg': SVG12, 'fn': 'trojuhelniky-p.svg',
     'alt': 'Dva shodne rovnoramenne trojuhelniky a vodorovna primka p; u prvniho vyznacen uhel 40 stupnu, u druheho uhel alfa.',
     'cap': 'Ilustrativni obrazek k uloze 12',
     'sol': ['Uhly pri zakladne rovnoramenneho trojuhelniku jsou $\\frac{180^\\circ-40^\\circ}{2}=70^\\circ$. Rameno druheho trojuhelniku je rovnobezne s ramenem prvniho, ktere svira se zakladnou (a tedy s primkou $p$) uhel $70^\\circ$. Uhel $\\alpha$ pri vrcholu druheho trojuhelniku na primce $p$ je rozdelen tuto rovnobezkou na dva uhly o velikosti $70^\\circ$, takze $\\alpha=70^\\circ+70^\\circ=140^\\circ$.'],
     'ans': 'B) $140^\\circ$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2025 - uloha 13', 'zad': [
        'Ze shodnych bilych a sedych krychlicek byla sestavena krychle tak, ze v kazde rade i v kazdem sloupci jsou 4 krychlicky. Sede krychlicky byly umisteny vzdy podel jedne ze dvou uhlopricek kazde steny krychle (viz obrazek). Vsechny zbyvajici krychlicky v krychli jsou bile.',
        'Jaky je pocet vsech bilych krychlicek v krychli?'],
     'opts': ['A) mene nez 36', 'B) 36', 'C) 48', 'D) 54', 'E) 72'],
     'ln': 0, 'svg': SVG13, 'fn': 'krychle.svg',
     'alt': 'Schematicky nakres krychle slozene ze 4 krat 4 krat 4 krychlicek se sedymi krychlickami na uhlopricce steny.',
     'cap': 'Schematicky nakres (prostorove teleso dle testoveho sesitu)',
     'sol': ['Krychle ma $4\\cdot 4\\cdot 4=64$ krychlicek. Sede lezi na uhlopricce kazde ze 6 sten, po 4 na stenu. Dve vnitrni krychlicky kazde stenove uhlopricky patri jen jedne stene: $2\\cdot 6=12$ sedych. Krajni krychlicky uhlopricek jsou rohove krychlicky krychle; pri danem rozmisteni jsou to 4 rohy (kazdy sdileny tremi stenami). Celkem sedych $12+4=16$, takze bilych $64-16=48$.'],
     'ans': 'C) $48$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['stereometrie', 'porozumeni', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M9B 2025 - uloha 14', 'zad': [
        'Na vyrobu dortu byly pouzity dve ruzne formy tvaru rotacniho valce. Polomer podstavy prvni formy je 8 cm a polomer podstavy druhe formy je o ctvrtinu mensi. Vyska obou forem je stejna, a to 5 cm. Dvoupatrovy dort je slozen z vetsiho a mensiho korpusu; kazdy korpus ma stejny objem jako forma, v niz byl upecen.',
        'Jaky je celkovy objem obou korpusu dvoupatroveho dortu?'],
     'opts': ['A) $350\\pi$ cm$^3$', 'B) $400\\pi$ cm$^3$', 'C) $450\\pi$ cm$^3$', 'D) $500\\pi$ cm$^3$', 'E) $550\\pi$ cm$^3$'],
     'ln': 0, 'svg': SVG14, 'fn': 'dort.svg',
     'alt': 'Schematicky nakres dvoupatroveho dortu ze dvou valcu, spodni s polomerem 8 cm a horni s polomerem 6 cm, oba vysoke 5 cm.',
     'cap': 'Schematicky nakres',
     'sol': ['Polomer druhe formy $8-\\frac{1}{4}\\cdot 8=6$ cm. Objem vetsiho korpusu $\\pi\\cdot 8^2\\cdot 5=320\\pi$ cm$^3$, mensiho $\\pi\\cdot 6^2\\cdot 5=180\\pi$ cm$^3$. Celkem $320\\pi+180\\pi=500\\pi$ cm$^3$.'],
     'ans': 'D) $500\\pi$ cm$^3$', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['stereometrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9B 2025 - uloha 15', 'zad': [
        'Na tabore bylo 80 deti, 5 vedoucich a 4 instruktori. Priradte ke kazde uloze (15.1-15.3) odpovidajici vysledek (A-F).',
        '15.1 Vedouci si vsechny deti rozdelili do stejne pocetnych oddilu; kazdy vedouci mel na starost jeden oddil. Kolik procent vsech deti mel na starost jeden vedouci?',
        '15.2 Na tabore bylo mladsich deti o jednu tretinu mene nez starsich deti. O kolik procent bylo starsich deti vice nez mladsich?',
        '15.3 Deti z tabora se vydaly do lesa na boruvky. Sla ctvrtina vsech chlapcu a polovina vsech divek, tedy chlapcu slo do lesa o 4 mene nez divek. Kolik procent vsech deti na tabore tvorily divky?'],
     'opts': ['A) $20\\,\\%$', 'B) $25\\,\\%$', 'C) $33\\,\\%$', 'D) $40\\,\\%$', 'E) $45\\,\\%$', 'F) $50\\,\\%$'],
     'ln': 0,
     'sol': ['15.1 Na jednoho z 5 vedoucich pripada $\\frac{80}{5}=16$ deti, tj. $\\frac{16}{80}=20\\,\\%$ -> A.',
             '15.2 Mladsich je $\\frac{2}{3}$ poctu starsich, takze starsich je oproti mladsim $\\frac{3}{2}$, tj. o $50\\,\\%$ vice -> F.',
             '15.3 Chlapcu $b$, divek $g$, $b+g=80$. Do lesa $\\frac{b}{4}=\\frac{g}{2}-4$, tj. $b=2g-16$. Dosazenim $2g-16+g=80$, $g=32$. Divky tvori $\\frac{32}{80}=40\\,\\%$ -> D.'],
     'ans': '15.1: A ($20\\,\\%$); 15.2: F ($50\\,\\%$); 15.3: D ($40\\,\\%$)', 'pts': 6, 'mins': 9, 'diff': '4',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M9B 2025 - uloha 16', 'zad': [
        'Mirek postupne odrikaval vsechna po sobe jdouci prirozena cisla od 1 do 1000. Za kazdym druhym cislem udelal kratkou pauzu, behem niz Zuzka rekla soucet poslednich dvou cisel, ktera vyslovil Mirek. Na zacatku tedy zaznela cisla: 1, 2, 3, 3, 4, 7, 5, 6, 11, ... (tucne vyslovila Zuzka cisla 3, 7, 11, ostatni Mirek).',
        '16.1 Urcete cislo, ktere zaznelo mezi cisly 24 a 25.',
        '16.2 Jako 90. v poradi bylo vysloveno cislo $C$, ktere pozdeji zaznelo jeste jednou. Urcete cislo, ktere bylo vysloveno bezprostredne predtim, nez podruhe zaznelo cislo $C$.',
        '16.3 Urcete nejvetsi cislo, ktere mezi prvnimi 150 vyslovenymi cisly zaznelo dvakrat.'],
     'opts': None, 'ln': 4,
     'sol': ['Cisla se odrikavaji po trojicich: v $k$-te trojici rekne Mirek cisla $2k-1$ a $2k$ a Zuzka jejich soucet $4k-1$.',
             '16.1 Cisla 24 a 25 jsou dve sousedni Mirkova cisla z ruznych trojic: $24=2\\cdot 12$ (konec 12. trojice), $25=2\\cdot 13-1$ (zacatek 13. trojice). Mezi nimi zazni Zuzcin soucet 12. trojice $4\\cdot 12-1=47$.',
             '16.2 Na 90. miste ($90=3\\cdot 30$) je Zuzcin soucet 30. trojice, tedy $C=4\\cdot 30-1=119$. Cislo 119 rekne pozdeji Mirek jako $2k-1=119$, tj. $k=60$ (prvni cislo 60. trojice). Bezprostredne predtim zazni Zuzcin soucet 59. trojice $4\\cdot 59-1=235$.',
             '16.3 Prvnich 150 cisel tvori 50 trojic. Dvakrat zazni cislo, ktere je zaroven Mirkovo (1 az 100) i Zuzcino ($4k-1$). Nejvetsi takove nejvyse 100 je $99=4\\cdot 25-1$ (Zuzka v 25. trojici) a zaroven $99=2\\cdot 50-1$ (Mirek v 50. trojici). Hledane cislo je $99$.'],
     'ans': '16.1: $47$; 16.2: $235$; 16.3: $99$', 'pts': 4, 'mins': 7, 'diff': '4',
     'codes': B + ['posloupnosti', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M9PBD25C0T02'
    gen.YEAR = 2025

    def dollars_ok(s): return s.count('$') % 2 == 0
    errors = []; names = set()
    for p in PROBLEMS:
        if p['name'] in names: errors.append('DUP nazev: ' + p['name'])
        names.add(p['name'])
        for t in [p['name'], p['ans']] + list(p['zad']) + list(p['sol']) + (p.get('opts') or []):
            if not dollars_ok(t): errors.append('Neparovy $: ' + t[:70])
        if p.get('svg') and ("'" in p['svg'] or '\\' in p['svg']):
            errors.append('SVG zakazany znak: ' + p['name'])
        if p.get('svg') and not p.get('alt'): errors.append('Obrazek bez alt: ' + p['name'])
        for lbl, obj in (('content', gen.py_content_json(p)), ('solution', gen.py_solution_json(p)), ('answer', gen.py_answer_json(p))):
            try: json.loads(json.dumps(obj, ensure_ascii=False))
            except Exception as e: errors.append(f'JSON {lbl} {p["name"]}: {e}')
    if errors:
        print('CHYBY:'); [print('  -', e) for e in errors]; sys.exit(1)
    print('Validace OK:', len(PROBLEMS), 'uloh')
    outdir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'out')
    os.makedirs(outdir, exist_ok=True)
    tot = 0
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M9-2025B')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} uloh [{"OK" if sz<9000 else "PRES 9KB"}]')
    print('Celkem uloh:', tot)
