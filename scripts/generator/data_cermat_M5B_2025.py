# -*- coding: utf-8 -*-
# CERMAT - Jednotna prijimaci zkouska 2025, MATEMATIKA 5B, 2. radny termin.
# Kod testu: M5PBD25C0T02. 14 uloh (po rozdeleni izolovanych poduuloh 17 uloh).
# Zdroj odpovedi: rozsireny klic spravnych reseni (KSR) 2025.

# ---- SVG obrazky (bez ' a \) ----

# uloha 5: ctverecek + priklad obdelniku ze ctverecku (obvod 18 cm -> 7x2)
def _svg5():
    cell = 26; x0 = 250; y0 = 45
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 150" font-family="sans-serif">']
    s.append('<text x="55" y="30" font-size="13" text-anchor="middle">Ctverecek</text>')
    s.append(f'<rect x="42" y="55" width="{cell}" height="{cell}" fill="#d9d9d9" stroke="#000"/>')
    s.append('<text x="340" y="30" font-size="13" text-anchor="middle">Obdelnik vytvoreny ze ctverecku</text>')
    for i in range(7):
        for j in range(2):
            s.append(f'<rect x="{x0+i*cell}" y="{y0+j*cell}" width="{cell}" height="{cell}" fill="#d9d9d9" stroke="#000"/>')
    s.append('</svg>')
    return "".join(s)
SVG5 = _svg5()

# uloha 7.1: bod U a ruznobezne primky p, q
SVG7_1 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 260" font-family="sans-serif">
<line x1="60" y1="150" x2="430" y2="60" stroke="#000" stroke-width="2"/>
<text x="437" y="58" font-size="16" font-style="italic">p</text>
<line x1="70" y1="70" x2="410" y2="230" stroke="#000" stroke-width="2"/>
<text x="415" y="240" font-size="16" font-style="italic">q</text>
<text x="298" y="152" font-size="15">x</text>
<text x="312" y="152" font-size="15" font-style="italic">U</text>
</svg>"""

# uloha 7.2: bod K a ruznobezne primky r, s
SVG7_2 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif">
<line x1="70" y1="150" x2="430" y2="150" stroke="#000" stroke-width="2"/>
<text x="437" y="155" font-size="16" font-style="italic">s</text>
<line x1="130" y1="120" x2="380" y2="270" stroke="#000" stroke-width="2"/>
<text x="386" y="278" font-size="16" font-style="italic">r</text>
<text x="150" y="212" font-size="15">x</text>
<text x="150" y="230" font-size="15" font-style="italic">K</text>
</svg>"""

# uloha 8: skladany sloupcovy graf (Tomas, Pavel, Vera), pocet padesatikorun
def _svg8():
    data = [('Leden', 4, 2, 7), ('Unor', 3, 5, 3), ('Brezen', 3, 7, 2), ('Duben', 5, 2, 3)]
    x0, y0 = 70, 300; unit = 18; bw = 52; gap = 30
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 350" font-family="sans-serif">']
    s.append('<text x="260" y="24" font-size="14" text-anchor="middle" font-weight="bold">Nove vlozene mince</text>')
    s.append(f'<line x1="{x0}" y1="40" x2="{x0}" y2="{y0}" stroke="#000"/>')
    s.append(f'<line x1="{x0}" y1="{y0}" x2="460" y2="{y0}" stroke="#000"/>')
    for v in range(0, 15, 2):
        y = y0 - v * unit
        s.append(f'<line x1="{x0-4}" y1="{y}" x2="{x0}" y2="{y}" stroke="#000"/>')
        s.append(f'<text x="{x0-8}" y="{y+4}" font-size="11" text-anchor="end">{v}</text>')
    s.append('<text x="24" y="170" font-size="12" text-anchor="middle" transform="rotate(-90 24 170)">Pocet padesatikorun</text>')
    x = x0 + gap
    for name, t, p, v in data:
        yb = y0
        for val, col in ((t, '#7f7f7f'), (p, '#ffffff'), (v, '#cccccc')):
            h = val * unit
            s.append(f'<rect x="{x}" y="{yb-h}" width="{bw}" height="{h}" fill="{col}" stroke="#000"/>')
            yb -= h
        s.append(f'<text x="{x+bw/2}" y="{y0+16}" font-size="11" text-anchor="middle">{name}</text>')
        x += bw + gap
    s.append('<rect x="475" y="70" width="12" height="12" fill="#cccccc" stroke="#000"/><text x="492" y="80" font-size="11">Vera</text>')
    s.append('<rect x="475" y="90" width="12" height="12" fill="#ffffff" stroke="#000"/><text x="492" y="100" font-size="11">Pavel</text>')
    s.append('<rect x="475" y="110" width="12" height="12" fill="#7f7f7f" stroke="#000"/><text x="492" y="120" font-size="11">Tomas</text>')
    s.append('</svg>')
    return "".join(s)
SVG8 = _svg8()

# uloha 9: tabulka souctu/soucinu 3x4
def _svg9():
    cw = [70, 70, 70, 86]; rh = 42; x0 = 20; y0 = 20
    rows = [['', '29', '', '23 374'], ['11', '', '', '14 850'], ['682', '783', '650', '']]
    gray = {(0, 3), (1, 3), (2, 0), (2, 1), (2, 2), (2, 3)}
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 340 160" font-family="sans-serif">']
    y = y0
    for r in range(3):
        x = x0
        for cix in range(4):
            w = cw[cix]
            fill = '#cccccc' if (r, cix) in gray else '#ffffff'
            s.append(f'<rect x="{x}" y="{y}" width="{w}" height="{rh}" fill="{fill}" stroke="#000"/>')
            val = rows[r][cix]
            if val:
                s.append(f'<text x="{x+w/2}" y="{y+rh/2+5}" font-size="14" text-anchor="middle">{val}</text>')
            x += w
        y += rh
    s.append('</svg>')
    return "".join(s)
SVG9 = _svg9()

# ulohy 10-11: rovnostranny trojuhelnikovy zahon rozdeleny na mensi trojuhelniky
def _svg_zahon():
    A = (160, 40); B = (60, 210); C = (260, 210)
    def mid(P, Q, t): return (P[0] + (Q[0] - P[0]) * t, P[1] + (Q[1] - P[1]) * t)
    ab1 = mid(A, B, 1 / 3); ab2 = mid(A, B, 2 / 3)
    ac1 = mid(A, C, 1 / 3); ac2 = mid(A, C, 2 / 3)
    bc1 = mid(B, C, 1 / 3); bc2 = mid(B, C, 2 / 3)
    m2 = ((ab2[0] + ac2[0]) / 2, ab2[1])
    def poly(pts, fill):
        p = " ".join(f"{round(px,1)},{round(py,1)}" for px, py in pts)
        return f'<polygon points="{p}" fill="{fill}" stroke="#000"/>'
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 240" font-family="sans-serif">']
    light = '#e6e6e6'; dark = '#8f8f8f'
    for tri in ([A, ab1, ac1], [ab1, ab2, m2], [ac1, m2, ac2], [ab2, B, bc1], [m2, bc1, bc2], [ac2, bc2, C]):
        s.append(poly(tri, light))
    for tri in ([ab1, ac1, m2], [ab2, m2, bc1], [m2, ac2, bc2]):
        s.append(poly(tri, dark))
    s.append('<text x="150" y="234" font-size="11" text-anchor="middle" fill="#555">6 zlutych (svetle) a 3 fialove (tmave) trojuhelniky - schematicky</text>')
    s.append('</svg>')
    return "".join(s)
SVG_ZAHON = _svg_zahon()

# uloha 12: stavebnice - krychle K a hranol H, dva stejne velke kvadry (schematicky)
SVG12 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 170" font-family="sans-serif">
<rect x="40" y="40" width="30" height="30" fill="#e8e8e8" stroke="#000"/>
<text x="55" y="90" font-size="12" text-anchor="middle">K</text>
<rect x="110" y="25" width="30" height="45" fill="#e8e8e8" stroke="#000"/>
<text x="125" y="90" font-size="12" text-anchor="middle">H</text>
<text x="330" y="45" font-size="12" text-anchor="middle">Adamuv a Markuv kvadr jsou stejne velke kvadry.</text>
<text x="330" y="68" font-size="11" text-anchor="middle" fill="#666">Adam pouzil jen hranoly (H), Markuv kvadr obsahuje hranoly i krychle (K).</text>
<text x="260" y="125" font-size="11" text-anchor="middle" fill="#666">Prostorova telesa jsou zde jen schematicka; posuzuje se podle testoveho sesitu.</text>
</svg>"""

# uloha 13: ctvercova sit se 7 obrazci (schematicky)
def _svg13():
    ox, oy, cell = 20, 20, 22; cols, rows = 13, 7
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {ox*2+cols*cell} {oy*2+rows*cell}" font-family="sans-serif">']
    for i in range(cols + 1):
        s.append(f'<line x1="{ox+i*cell}" y1="{oy}" x2="{ox+i*cell}" y2="{oy+rows*cell}" stroke="#ddd"/>')
    for j in range(rows + 1):
        s.append(f'<line x1="{ox}" y1="{oy+j*cell}" x2="{ox+cols*cell}" y2="{oy+j*cell}" stroke="#ddd"/>')
    def P(i, j): return f"{ox+i*cell},{oy+j*cell}"
    s.append(f'<polygon points="{P(1,1)} {P(1,4)} {P(3,1)}" fill="#808080" stroke="#000"/>')
    s.append(f'<polygon points="{P(4,1)} {P(6,1)} {P(6,0.5)} {P(7,1.5)} {P(6,2.5)} {P(6,2)} {P(4,2)}" fill="#eee" stroke="#000"/>')
    s.append(f'<polygon points="{P(3,3)} {P(5,2)} {P(6,4)} {P(4,5)}" fill="#eee" stroke="#000"/>')
    s.append(f'<polygon points="{P(9,4)} {P(9,2)} {P(10,1)} {P(11,2)} {P(11,4)}" fill="#eee" stroke="#000"/>')
    s.append(f'<polygon points="{P(6,5)} {P(8,4)} {P(10,5)} {P(8,6)}" fill="#eee" stroke="#000"/>')
    s.append(f'<polygon points="{P(1,6)} {P(5,6)} {P(3,5)}" fill="#eee" stroke="#000"/>')
    s.append(f'<polygon points="{P(9,6)} {P(12,6)} {P(12,4)}" fill="#eee" stroke="#000"/>')
    s.append(f'<rect x="{ox+(cols-1)*cell}" y="{oy+(rows-1)*cell}" width="{cell}" height="{cell}" fill="#bbb" stroke="#000"/>')
    s.append(f'<text x="{ox+cols*cell-8}" y="{oy+rows*cell+14}" font-size="10" text-anchor="end">1 cm2</text>')
    s.append('</svg>')
    return "".join(s)
SVG13 = _svg13()

# uloha 14: prvni, druhy a treti obrazec (schematicky)
def _svg14():
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 190" font-family="sans-serif">']
    def grid(ox, oy, w, h, c, label):
        out = [f'<text x="{ox+w/2}" y="{oy-8}" font-size="12" text-anchor="middle">{label}</text>']
        out.append(f'<rect x="{ox}" y="{oy}" width="{w}" height="{h}" fill="#f6f6f6" stroke="#000" stroke-width="1.5"/>')
        i = ox + c
        while i < ox + w:
            out.append(f'<line x1="{i}" y1="{oy}" x2="{i}" y2="{oy+h}" stroke="#ccc"/>'); i += c
        j = oy + c
        while j < oy + h:
            out.append(f'<line x1="{ox}" y1="{j}" x2="{ox+w}" y2="{j}" stroke="#ccc"/>'); j += c
        return "".join(out)
    s.append(grid(30, 55, 60, 60, 15, '1. obrazec'))
    s.append('<rect x="30" y="55" width="60" height="15" fill="#808080" stroke="#000"/>')
    s.append('<rect x="75" y="70" width="15" height="45" fill="#808080" stroke="#000"/>')
    s.append(grid(150, 45, 90, 90, 15, '2. obrazec'))
    s.append(grid(300, 40, 90, 96, 15, '3. obrazec'))
    s.append('</svg>')
    return "".join(s)
SVG14 = _svg14()

B = ['zs1']  # 5. rocnik ZS (prijimacky na osmilete); kod r5 v taxonomii neni

_ZAHON = [
    'Zahon ma tvar rovnostranneho trojuhelniku. Cely zahon je osazen zlute a fialove kvetoucimi rostlinami, a to ve stejnych rozestupech. Po jedne rostline je i v kazdem vrcholu trojuhelniku. Ze vsech rostlin na zahone je $39$ rostlin rozmisteno po obvodu zahonu.',
    'Zlute kvetouci rostliny vytvareji v zahonu $6$ stejnych zlutych rovnostrannych trojuhelniku. Fialove kvetouci rostliny tvori $3$ fialove rovnostranne trojuhelniky. Kazdy fialovy trojuhelnik ma o $1$ radu rostlin vice nez zluty trojuhelnik.',
]

PROBLEMS = [
    {'name': 'CERMAT M5B 2025 - uloha 1.1', 'zad': [
        'Kdyz nezname cislo vydelim sedmi, pak prictu cislo 3 a vysledek zdvojnasobim, dostanu cislo 20.',
        'Urcete nezname cislo.'], 'opts': None, 'ln': 2,
     'sol': ['Oznacme nezname cislo $x$. Plati $(x:7+3)\\cdot 2=20$, tedy $x:7+3=10$, $x:7=7$, a proto $x=49$.'],
     'ans': '$49$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['rovnice', 'vypocet', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5B 2025 - uloha 1.2', 'zad': [
        'Nezname cislo zvetsene o jednu jeho polovinu se rovna 198.',
        'Urcete nezname cislo.'], 'opts': None, 'ln': 2,
     'sol': ['Nezname cislo $x$ zvetsene o polovinu je $x+\\frac{x}{2}=\\frac{3}{2}x=198$, odtud $x=198\\cdot\\frac{2}{3}=132$.'],
     'ans': '$132$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['rovnice', 'vypocet', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5B 2025 - uloha 1.3', 'zad': [
        'Soucet dvou neznamych cisel je 109 a jejich rozdil je 13.',
        'Urcete obe neznama cisla.'], 'opts': None, 'ln': 2,
     'sol': ['Vetsi cislo $=\\frac{109+13}{2}=61$, mensi cislo $=\\frac{109-13}{2}=48$. Hledana cisla jsou $48$ a $61$.'],
     'ans': '$48$; $61$', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['rovnice', 'vypocet', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5B 2025 - uloha 2', 'zad': [
        'Doplnte do ramecku takove cislo, aby platila rovnost.',
        '2.1 $18$ m - $15$ dm + [ ] cm = $20$ m',
        '2.2 $4\\cdot$ [ ] g - $3$ kg = $\\frac{1}{5}$ kg',
        '2.3 $\\frac{1}{4}$ h + [ ] s = $20$ min'], 'opts': None, 'ln': 3,
     'sol': [
        '2.1 $18$ m $=1800$ cm, $15$ dm $=150$ cm, $20$ m $=2000$ cm; doplnene cislo $=2000-1800+150=350$.',
        '2.2 $\\frac{1}{5}$ kg $=200$ g, $3$ kg $=3000$ g; $4\\cdot$ [ ] $=3000+200=3200$, doplnene cislo $=800$.',
        '2.3 $\\frac{1}{4}$ h $=15$ min $=900$ s, $20$ min $=1200$ s; doplnene cislo $=1200-900=300$.'],
     'ans': '2.1: $350$; 2.2: $800$; 2.3: $300$', 'pts': 3, 'mins': 4, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5B 2025 - uloha 3', 'zad': [
        'Na snurku jsme navlekali koralky. Koralky na snurce jsme rozdelili do ctyr skupin. Na pocatku snurky i za kazdou skupinou jsme vytvorili uzlik. Prvni skupina ma nejmensi pocet koralku. Kazda dalsi skupina ma 4krat vice koralku nez skupina pred ni. Ve treti skupine je 32 koralku.',
        '3.1 Vypoctete, kolik koralku je celkem navleceno na snurce.',
        '3.2 Urcete, kolikrat vice koralku ma ctvrta skupina nez druha skupina.',
        '3.3 Na cele snurce se od pocatku pravidelne stridaji 4 cerne a 1 bily koralek. Vypoctete, kolik cernych koralku je ve ctvrte skupine.'],
     'opts': None, 'ln': 4,
     'sol': [
        'Pocty koralku ve skupinach tvori geometrickou posloupnost s kvocientem $4$. Treti skupina ma $32$ koralku, proto prvni ma $32:16=2$, druha $8$, treti $32$ a ctvrta $128$ koralku.',
        '3.1 Celkem $2+8+32+128=170$ koralku.',
        '3.2 Ctvrta skupina ma $128$, druha $8$; $128:8=16$krat vice.',
        '3.3 Ctvrta skupina jsou koralky na pozicich $43$ az $170$. Bile koralky jsou na pozicich delitelnych peti, tj. $45, 50, \\dots, 170$ (celkem $26$). Cernych je proto $128-26=102$.'],
     'ans': '3.1: $170$ koralku; 3.2: $16$krat; 3.3: $102$ cernych koralku', 'pts': 5, 'mins': 7, 'diff': '3',
     'codes': B + ['posloupnosti', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5B 2025 - uloha 4', 'zad': [
        'V restauraci byla na cely vecer zarezervovana ctvrtina vsech stolu, coz byly 4 stoly pro ctyri hosty a 5 stolu pro dva hosty.',
        '4.1 Urcete celkovy pocet stolu v restauraci.',
        '4.2 Ze vsech stolu v restauraci je polovina stolu pro dva hosty, tretina stolu je pro tri hosty a ostatni stoly jsou pro ctyri hosty. Vypoctete, kolik mist pro hosty je celkem u vsech stolu v restauraci.'],
     'opts': None, 'ln': 3,
     'sol': [
        '4.1 Zarezervovano bylo $4+5=9$ stolu, coz je ctvrtina vsech; celkem tedy $4\\cdot 9=36$ stolu.',
        '4.2 Pro dva hosty je $\\frac{1}{2}\\cdot 36=18$ stolu, pro tri hosty $\\frac{1}{3}\\cdot 36=12$ stolu, pro ctyri hosty zbyva $36-18-12=6$ stolu. Mist celkem: $18\\cdot 2+12\\cdot 3+6\\cdot 4=36+36+24=96$.'],
     'ans': '4.1: $36$ stolu; 4.2: $96$ mist', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5B 2025 - uloha 5', 'zad': [
        'Na papir lepime stejne samolepici ctverecky, ktere maji stranu delky $1$ cm a obsah $1$ cm2. Vytvarime tak ruzne obdelniky, z nichz kazdy ma obvod $18$ cm. Jeden z takovych obdelniku je na obrazku. Sousedni ctverecky v obdelniku maji vzdy jednu stranu spolecnou.',
        '5.1 Vypoctete, kolik cm meri nejdelsi mozna strana takoveho obdelniku.',
        '5.2 Urcete, kolik navzajem ruznych obsahu maji vsechny takove obdelniky.',
        '5.3 Vypoctete v cm2, jaky je nejvetsi mozny obsah takoveho obdelniku.'],
     'opts': None, 'ln': 4, 'svg': SVG5, 'fn': 'obdelnik-ctverecky.svg',
     'alt': 'Jeden samolepici ctverecek a priklad obdelniku slozeneho ze ctverecku o obvodu 18 cm.',
     'cap': 'Ctverecek a obdelnik ze ctverecku',
     'sol': [
        'Obvod $18$ cm znamena, ze soucet delek dvou sousednich stran je $9$ cm. Strany jsou cela cisla: $1+8$, $2+7$, $3+6$, $4+5$.',
        '5.1 Nejdelsi mozna strana je $8$ cm (obdelnik $1\\times 8$).',
        '5.2 Obsahy jsou $1\\cdot 8=8$, $2\\cdot 7=14$, $3\\cdot 6=18$ a $4\\cdot 5=20$; tedy $4$ ruzne obsahy.',
        '5.3 Nejvetsi obsah ma obdelnik $4\\times 5$, tj. $20$ cm2.'],
     'ans': '5.1: $8$ cm; 5.2: $4$ ruzne obsahy; 5.3: $20$ cm2', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5B 2025 - uloha 6', 'zad': [
        'Karel a Mirka zapsali na tabuli dve ruzna dvojciferna cisla. Karel ve svem cisle zapsal na miste desitek cislici o 3 vetsi nez Mirka, ale na miste jednotek cislici o 2 mensi nez Mirka.',
        '6.1 Vypoctete, o kolik se lisi Karlovo a Mircino cislo.',
        '6.2 Zapsana cisla se lisi o tretinu Karlova cisla. Urcete, jake cislo zapsala na tabuli Mirka.'],
     'opts': None, 'ln': 3,
     'sol': [
        'Mircino cislo ma na miste desitek $d$ a na miste jednotek $j$, tedy $10d+j$. Karlovo cislo je $10(d+3)+(j-2)=10d+j+28$.',
        '6.1 Cisla se lisi o $28$.',
        '6.2 Rozdil $28$ je tretinou Karlova cisla, proto Karlovo cislo je $3\\cdot 28=84$ a Mircino je $84-28=56$.'],
     'ans': '6.1: o $28$; 6.2: $56$', 'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5B 2025 - uloha 7.1 (konstrukce)', 'zad': [
        'V rovine lezi bod $U$ a ruznobezne primky $p$, $q$ (viz obrazek).',
        'Na primkach $p$, $q$ lezi dve strany pravouhleho trojuhelniku $ABC$. Treti strana $BC$ tohoto trojuhelniku prochazi bodem $U$.',
        'Sestrojte vrcholy trojuhelniku $ABC$, oznacte je pismeny a trojuhelnik narysujte. Najdete vsechna reseni.'],
     'opts': None, 'ln': 0, 'svg': SVG7_1, 'fn': 'primky-pq-U.svg',
     'alt': 'Bod U a dve ruznobezne primky p a q.', 'cap': 'Vychozi obrazek k uloze 7.1',
     'sol': [
        'Vrchol $A$ je prusecik primek $p$ a $q$; jedna odvesna lezi na $p$, druha na $q$. Pravy uhel je u vrcholu $B$ (resp. $C$), a proto strana $BC$ je kolma k jedne z primek. Bodem $U$ vedeme kolmici k primce $q$ - protne $q$ v bode $B$ a primku $p$ v bode $C$ (pravy uhel u $B$). Druhe reseni dostaneme kolmici z bodu $U$ k primce $p$. Existuji dve reseni.'],
     'ans': 'Dve reseni. $A$ je prusecik primek $p$ a $q$; strana $BC$ prochazi bodem $U$ a je kolma k jedne z primek (pravy uhel v $B$, resp. $C$) - viz obrazek v klici.',
     'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5B 2025 - uloha 7.2 (konstrukce)', 'zad': [
        'V rovine lezi bod $K$ a ruznobezne primky $r$, $s$ (viz obrazek).',
        'Bod $K$ je vrchol obdelniku $KLMN$. Strana $KL$ tohoto obdelniku je rovnobezna s primkou $r$. Na primce $s$ lezi stred $S$ strany $KN$ a vrchol $M$ obdelniku $KLMN$.',
        'Sestrojte bod $S$ a vrcholy $L$, $M$, $N$ obdelniku $KLMN$, oznacte je pismeny a obdelnik narysujte.'],
     'opts': None, 'ln': 0, 'svg': SVG7_2, 'fn': 'primky-rs-K.svg',
     'alt': 'Bod K a dve ruznobezne primky r a s.', 'cap': 'Vychozi obrazek k uloze 7.2',
     'sol': [
        'Strana $KN$ je kolma ke strane $KL$, a protoze $KL$ je rovnobezna s $r$, je $KN$ kolma k $r$. Bodem $K$ vedeme kolmici k primce $r$; jeji prusecik s primkou $s$ je stred $S$ strany $KN$. Vrchol $N$ je soumerny s bodem $K$ podle stredu $S$ (na teze kolmici, $|SN|=|SK|$). Vrchol $M$ je prusecik primky $s$ s rovnobezkou s primkou $r$ vedenou bodem $N$. Vrchol $L$ dostaneme jako prusecik rovnobezky s $r$ vedene bodem $K$ a kolmice k $r$ vedene bodem $M$. Obdelnik $KLMN$ narysujeme.'],
     'ans': 'Kolmice z $K$ k $r$ protne $s$ ve stredu $S$ strany $KN$; $N$ je obraz $K$ ve stredu $S$; $M$ je prusecik $s$ s rovnobezkou s $r$ bodem $N$, $L$ doplnime na obdelnik - viz obrazek v klici.',
     'pts': 3, 'mins': 6, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5B 2025 - uloha 8', 'zad': [
        'Vera, Pavel a Tomas setrili po dobu ctyr mesicu pouze padesatikorunove mince a vsechny nasetrene mince vkladali do kasicky. Graf udava pocet minci, ktere deti vlozily do kasicky v jednotlivych mesicich.',
        'Rozhodnete o kazdem z nasledujicich tvrzeni 8.1-8.3, zda je pravdive (A), ci nikoli (N).',
        '8.1 Vera vlozila do kasicky v lednu tolik korun, kolik nasetrila behem zbyvajicich tri mesicu dohromady.',
        '8.2 V unoru vlozili do kasicky Pavel s Verou dohromady trikrat vice korun nez Tomas.',
        '8.3 Tomas vlozil v dubnu do kasicky vice nez jednu devitinu vsech penez, ktere nasetrily za uvedene ctyri mesice vsechny tri deti dohromady.'],
     'opts': None, 'ln': 0, 'svg': SVG8, 'fn': 'graf-mince.svg',
     'alt': 'Skladany sloupcovy graf poctu padesatikorun vlozenych Verou, Pavlem a Tomasem v lednu az dubnu.',
     'cap': 'Nove vlozene mince (pocet padesatikorun)',
     'sol': [
        'Z grafu (pocty minci, leden az duben): Tomas $4, 3, 3, 5$; Pavel $2, 5, 7, 2$; Vera $7, 3, 2, 3$.',
        '8.1 Vera v lednu $7$ minci, ve zbyvajicich mesicich $3+2+3=8$ minci; $7\\neq 8$, tvrzeni je nepravdive (N).',
        '8.2 V unoru Pavel a Vera dohromady $5+3=8$ minci, Tomas $3$ mince; $3\\cdot 3=9\\neq 8$, tvrzeni je nepravdive (N).',
        '8.3 Celkem vsech minci $13+11+12+10=46$; devitina je $\\frac{46}{9}\\approx 5{,}1$. Tomas v dubnu $5$ minci, coz neni vice nez $\\frac{46}{9}$, tvrzeni je nepravdive (N).'],
     'ans': '8.1: N; 8.2: N; 8.3: N', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['statistika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5B 2025 - uloha 9', 'zad': [
        'Do prazdnych bilych poli tabulky patri cisla $27$, $50$, $62$ a jeste jedno nezname cislo. Kazde cislo v sedem poli tabulky je soucin cisel v prislusnem radku nebo sloupci (viz tabulka).',
        'Jake je nezname cislo, ktere patri do tabulky?'],
     'opts': ['A) $13$', 'B) $16$', 'C) $23$', 'D) $26$', 'E) jine cislo'], 'ln': 0,
     'svg': SVG9, 'fn': 'tabulka-souciny.svg',
     'alt': 'Tabulka 3 krat 4; seda pole obsahuji souciny cisel v radku nebo sloupci, bila pole obsahuji 29, 11 a doplnovana cisla.',
     'cap': 'Tabulka soucinu',
     'sol': ['Z prvniho sloupce: $682=11\\cdot ?$, tedy horni bile pole je $62$. Z druheho sloupce: $783=29\\cdot ?$, tedy $27$. Ve tretim sloupci je soucin dvou bilych poli $650$. Zbyvaji cisla $50$ a nezname; $650:50=13$, proto nezname cislo je $13$. Kontrola radku: $62\\cdot 29\\cdot 13=23\\,374$ a $11\\cdot 27\\cdot 50=14\\,850$.'],
     'ans': 'A) $13$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5B 2025 - uloha 10', 'zad': _ZAHON + [
        'Kolik zlute kvetoucich rostlin vytvari jeden zluty trojuhelnik?'],
     'opts': ['A) $6$ rostlin', 'B) $9$ rostlin', 'C) $10$ rostlin', 'D) $12$ rostlin', 'E) $15$ rostlin'], 'ln': 0,
     'svg': SVG_ZAHON, 'fn': 'zahon-10.svg',
     'alt': 'Rovnostranny trojuhelnikovy zahon rozdeleny na mensi zlute a fialove rovnostranne trojuhelniky.',
     'cap': 'Rozmisteni trojuhelniku na zahone (schematicky nakres)',
     'sol': [
        'Na obvodu je $39$ rostlin; kazda strana zahonu ma tedy $39:3+1=14$ rostlin a $13$ rozestupu. Celkem je na zahone $\\frac{14\\cdot 15}{2}=105$ rostlin.',
        'Zluty trojuhelnik ma $4$ rostliny na strane (tj. $3$ rozestupy), a proto $\\frac{4\\cdot 5}{2}=10$ rostlin.'],
     'ans': 'C) $10$ rostlin', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5B 2025 - uloha 11', 'zad': _ZAHON + [
        'Kolik fialove kvetoucich rostlin je vysazeno na celem zahonu?'],
     'opts': ['A) $36$ rostlin', 'B) $45$ rostlin', 'C) $48$ rostlin', 'D) $51$ rostlin', 'E) vice nez $51$ rostlin'], 'ln': 0,
     'svg': SVG_ZAHON, 'fn': 'zahon-11.svg',
     'alt': 'Rovnostranny trojuhelnikovy zahon rozdeleny na mensi zlute a fialove rovnostranne trojuhelniky.',
     'cap': 'Rozmisteni trojuhelniku na zahone (schematicky nakres)',
     'sol': [
        'Fialovy trojuhelnik ma o jednu radu vice nez zluty, tj. $5$ rostlin na strane ($4$ rozestupy): $\\frac{5\\cdot 6}{2}=15$ rostlin. Fialove trojuhelniky jsou $3$, dohromady $3\\cdot 15=45$ rostlin. Kontrola: $6\\cdot 10+3\\cdot 15=60+45=105$ rostlin.'],
     'ans': 'B) $45$ rostlin', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5B 2025 - uloha 12', 'zad': [
        'Ve stavebnici jsou dva druhy kostek - krychle (K) a hranol (H), ktery lze slozit ze dvou krychli. Adam a Marek postavili ze stavebnice dva stejne velke kvadry (viz obrazek). Zatimco Adam pouzil jen hranoly, Markuv kvadr obsahuje jak hranoly, tak krychle.',
        'Jaky je nejvetsi mozny pocet hranolu (H) v kvadru, ktery postavil Marek?'],
     'opts': ['A) $2$ hranoly', 'B) $6$ hranolu', 'C) $7$ hranolu', 'D) $8$ hranolu', 'E) jiny pocet hranolu'], 'ln': 0,
     'svg': SVG12, 'fn': 'stavebnice.svg',
     'alt': 'Krychle K, hranol H slozeny ze dvou krychli a dva stejne velke kvadry Adama a Marka (schematicky).',
     'cap': 'Stavebnice - krychle a hranoly (schematicky nakres)',
     'sol': ['Adamuv kvadr je slozen jen z hranolu, jeho objem odpovida $18$ krychlim (kvadr $3\\times 3\\times 2$ krychle), tedy $9$ hranolu. Markuv kvadr ma stejny objem $18$ krychli a musi obsahovat aspon jednu krychli. Objem $18$ je sudy, takze krychli musi byt sudy pocet, nejmene $2$; zbytek tvori hranoly: $\\frac{18-2}{2}=8$ hranolu. Nejvetsi mozny pocet hranolu je $8$.'],
     'ans': 'D) $8$ hranolu', 'pts': 2, 'mins': 5, 'diff': '4',
     'codes': B + ['stereometrie', 'porozumeni', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5B 2025 - uloha 13', 'zad': [
        'Ve ctvercove siti je zakresleno $7$ obrazcu, ktere maji vrcholy v mrizovych bodech. Kazdy ctverecek ctvercove site ma stranu delky $1$ cm a obsah $1$ cm2 (viz obrazek).',
        'Priradte ke kazde otazce (13.1-13.3) spravnou odpoved (A-F).',
        '13.1 Kolik obrazcu ma obsah $3$ cm2?',
        '13.2 Kolik obrazcu je osove soumernych alespon podle jedne osy soumernosti?',
        '13.3 Kolik svetlych obrazcu ma stejny obvod jako tmavy trojuhelnik?'],
     'opts': ['A) zadny obrazec', 'B) $1$ obrazec', 'C) $2$ obrazce', 'D) $3$ obrazce', 'E) $4$ obrazce', 'F) $5$ obrazcu'], 'ln': 0,
     'svg': SVG13, 'fn': 'obrazce-sit.svg',
     'alt': 'Ctvercova sit se sedmi obrazci s vrcholy v mrizovych bodech; jeden trojuhelnik je tmavy, ostatni obrazce jsou svetle.',
     'cap': 'Sedm obrazcu ve ctvercove siti (schematicky nakres)',
     'sol': [
        'Odpovedi vychazeji z porovnani obrazcu v siti podle klice.',
        '13.1 Obsah $3$ cm2 ma $5$ obrazcu -> F.',
        '13.2 Osove soumerne jsou $4$ obrazce -> E.',
        '13.3 Stejny obvod jako tmavy trojuhelnik maji $3$ svetle obrazce -> D.'],
     'ans': '13.1: F ($5$ obrazcu); 13.2: E ($4$ obrazce); 13.3: D ($3$ obrazce)', 'pts': 5, 'mins': 7, 'diff': '3',
     'codes': B + ['planimetrie', 'porozumeni', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5B 2025 - uloha 14', 'zad': [
        'Pripojovanim ctverecku k velkemu bilemu ctverci vytvarime obrazce (viz obrazek). Prvni obrazec ma tvar ctverce a vznikl pripojenim $7$ mensich tmavych ctverecku. Postupnym pripojenim dalsich $20$ ctverecku dvou ruznych velikosti byl z prvniho obrazce vytvoren druhy, ktery ma take tvar ctverce. Treti obrazec vznikl z druheho pripojenim dalsich $11$ ctverecku a ma tvar obdelniku. Prvni obrazec ma obvod $80$ cm.',
        '14.1 Vypoctete v cm obvod druheho obrazce.',
        '14.2 Vypoctete, o kolik cm se lisi delky sousednich stran tretiho obrazce.',
        '14.3 Na obrazku je silne vyznacena uzavrena lomena cara, ktera kopiruje strany ctverecku ve tretim obrazci. Urcete v cm celkovou delku teto lomene cary.'],
     'opts': None, 'ln': 4, 'svg': SVG14, 'fn': 'obrazce-ctverce.svg',
     'alt': 'Prvni obrazec (ctverec), druhy obrazec (vetsi ctverec) a treti obrazec (obdelnik) vytvorene pripojovanim ctverecku.',
     'cap': 'Prvni, druhy a treti obrazec (schematicky nakres)',
     'sol': [
        'Prvni obrazec je ctverec o obvodu $80$ cm, tedy o strane $20$ cm.',
        '14.1 Druhy obrazec je ctverec o strane $30$ cm; jeho obvod je $4\\cdot 30=120$ cm.',
        '14.2 Treti obrazec je obdelnik o rozmerech $30$ cm $\\times\\,32$ cm; sousedni strany se lisi o $32-30=2$ cm.',
        '14.3 Souctem delek jednotlivych useku lomene cary podle obrazku vyjde $134$ cm.'],
     'ans': '14.1: $120$ cm; 14.2: o $2$ cm; 14.3: $134$ cm', 'pts': 4, 'mins': 7, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M5PBD25C0T02'
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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M5B-2025')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} uloh [{"OK" if sz<9000 else "PRES 9KB"}]')
    print('Celkem uloh:', tot)
