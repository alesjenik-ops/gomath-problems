# -*- coding: utf-8 -*-
# CERMAT - Jednotna prijimaci zkouska 2024, MATEMATIKA 7C (sestilete obory, 7. rocnik), 1. radny termin.
# Kod testu: M7PCD24C0T03. 16 uloh (po rozdeleni nezavislych poduloh 19 uloh).
# Zdroj odpovedi: klic spravnych reseni (KSR).

# ---- SVG obrazky (bez ' a \) ----

# uloha 5: tabulka casu orientacniho zavodu (5 tymu A-E)
def _race_table():
    cols = ["A", "B", "C", "D", "E"]
    start = ["14:30:00", "", "14:42:00", "", "14:54:00"]
    cil = ["15:17:46", "15:22:03", "15:30:32", "", "15:33:20"]
    vys = ["0:47:46", "", "", "0:49:40", ""]
    rows = [("Cas startu", start), ("Cas v cili", cil), ("Vysledny cas", vys)]
    lw = 128; cw = 90; x0 = 10; y0 = 10; rh = 34
    W = lw + 5 * cw
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {x0*2+W} {y0*2+rh*4}" font-family="sans-serif" font-size="14">']
    s.append(f'<rect x="{x0}" y="{y0}" width="{lw}" height="{rh}" fill="#ffffff" stroke="#000"/>')
    for j, c in enumerate(cols):
        cx = x0 + lw + j * cw
        s.append(f'<rect x="{cx}" y="{y0}" width="{cw}" height="{rh}" fill="#d9d9d9" stroke="#000"/>')
        s.append(f'<text x="{cx+cw/2:.0f}" y="{y0+rh/2+5:.0f}" text-anchor="middle" font-weight="bold">{c}</text>')
    for r, (label, vals) in enumerate(rows):
        ry = y0 + (r + 1) * rh
        s.append(f'<rect x="{x0}" y="{ry}" width="{lw}" height="{rh}" fill="#d9d9d9" stroke="#000"/>')
        s.append(f'<text x="{x0+7}" y="{ry+rh/2+5:.0f}" font-weight="bold" font-size="13">{label}</text>')
        for j, v in enumerate(vals):
            cx = x0 + lw + j * cw
            s.append(f'<rect x="{cx}" y="{ry}" width="{cw}" height="{rh}" fill="#ffffff" stroke="#000"/>')
            if v:
                s.append(f'<text x="{cx+cw/2:.0f}" y="{ry+rh/2+5:.0f}" text-anchor="middle">{v}</text>')
    s.append('</svg>')
    return "".join(s)
SVG5 = _race_table()

# uloha 6: obdelnikovy pozemek 26 m x 38 m (988 m2)
SVG6 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 300 290" font-family="sans-serif">
<rect x="100" y="55" width="110" height="180" fill="#eeeeee" stroke="#000" stroke-width="2"/>
<text x="155" y="45" font-size="15" text-anchor="middle">26 m</text>
<text x="155" y="150" font-size="15" text-anchor="middle">988 m²</text>
</svg>"""

# uloha 7: kvadr se ctvercovou podstavou a vyriznutym trojbokym hranolem (schematicky)
SVG7 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 300" font-family="sans-serif">
<line x1="120" y1="250" x2="280" y2="250" stroke="#000" stroke-width="2"/>
<line x1="280" y1="250" x2="280" y2="110" stroke="#000" stroke-width="2"/>
<line x1="280" y1="110" x2="120" y2="110" stroke="#000" stroke-width="2"/>
<line x1="120" y1="110" x2="120" y2="250" stroke="#000" stroke-width="2"/>
<line x1="280" y1="250" x2="338" y2="208" stroke="#000" stroke-width="2"/>
<line x1="338" y1="208" x2="338" y2="68" stroke="#000" stroke-width="2"/>
<line x1="338" y1="68" x2="280" y2="110" stroke="#000" stroke-width="2"/>
<line x1="120" y1="110" x2="178" y2="68" stroke="#000" stroke-width="2"/>
<line x1="178" y1="68" x2="338" y2="68" stroke="#000" stroke-width="2"/>
<line x1="120" y1="250" x2="178" y2="208" stroke="#555" stroke-width="1" stroke-dasharray="5 4"/>
<line x1="178" y1="208" x2="338" y2="208" stroke="#555" stroke-width="1" stroke-dasharray="5 4"/>
<line x1="178" y1="208" x2="178" y2="68" stroke="#555" stroke-width="1" stroke-dasharray="5 4"/>
<line x1="229" y1="89" x2="280" y2="110" stroke="#000" stroke-width="1.2"/>
<line x1="229" y1="89" x2="338" y2="68" stroke="#000" stroke-width="1.2"/>
<line x1="229" y1="229" x2="280" y2="250" stroke="#555" stroke-width="1" stroke-dasharray="3 3"/>
<line x1="229" y1="229" x2="338" y2="208" stroke="#555" stroke-width="1" stroke-dasharray="3 3"/>
<text x="112" y="266" font-size="14" font-style="italic">A</text>
<text x="284" y="266" font-size="14" font-style="italic">B</text>
<text x="344" y="214" font-size="14" font-style="italic">C</text>
<text x="182" y="222" font-size="14" font-style="italic">D</text>
<text x="106" y="108" font-size="14" font-style="italic">E</text>
<text x="284" y="108" font-size="14" font-style="italic">F</text>
<text x="344" y="66" font-size="14" font-style="italic">G</text>
<text x="164" y="66" font-size="14" font-style="italic">H</text>
<text x="222" y="245" font-size="13" font-style="italic">S</text>
<text x="216" y="86" font-size="13" font-style="italic">S´</text>
</svg>"""

# uloha 8: vychozi body A a S
SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 380 290" font-family="sans-serif">
<rect x="10" y="10" width="360" height="270" fill="none" stroke="#ccc"/>
<text x="250" y="118" font-size="15">×</text><text x="247" y="138" font-size="15" font-style="italic">S</text>
<text x="150" y="208" font-size="15">×</text><text x="147" y="228" font-size="15" font-style="italic">A</text>
</svg>"""

# uloha 9: sachovy stolek - seda deska, sachovnice, ctyri svisle pruhy (schematicky)
def _chess():
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 340 250" font-family="sans-serif">']
    s.append('<rect x="10" y="10" width="320" height="224" fill="#9a9a9a"/>')
    bx, by, cs = 106, 58, 16
    s.append(f'<rect x="{bx}" y="{by}" width="{8*cs}" height="{8*cs}" fill="#fff" stroke="#000"/>')
    for i in range(8):
        for j in range(8):
            if (i + j) % 2 == 0:
                s.append(f'<rect x="{bx+i*cs}" y="{by+j*cs}" width="{cs}" height="{cs}"/>')
    for sx in [26, 50, 278, 302]:
        s.append(f'<rect x="{sx}" y="10" width="16" height="224" fill="#e6e6e6" stroke="#000"/>')
        for k in range(10, 234, 32):
            s.append(f'<line x1="{sx}" y1="{k}" x2="{sx+16}" y2="{k+16}" stroke="#000"/>')
    s.append('</svg>')
    return "".join(s)
SVG9 = _chess()

# uloha 10: tri pohledy na stavbu (2D) + poznamka o prostorovych variantach
def _views():
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 200" font-family="sans-serif">']
    def grid(ox, oy, cells, label):
        out = [f'<text x="{ox+36}" y="{oy-8}" font-size="12" text-anchor="middle">{label}</text>']
        for (cx, cy) in cells:
            out.append(f'<rect x="{ox+cx*24}" y="{oy+(2-cy)*24}" width="24" height="24" fill="#cccccc" stroke="#000"/>')
        return out
    front = [(0, 0), (1, 0), (2, 0), (0, 1), (2, 1)]
    left = [(0, 0), (1, 0), (2, 0), (0, 1), (1, 1)]
    top = [(0, 0), (1, 1), (2, 1), (2, 2)]
    s += grid(40, 70, front, "pohled zepředu")
    s += grid(210, 70, left, "pohled zleva")
    s += grid(390, 70, top, "pohled shora")
    s.append('<text x="260" y="192" font-size="11" text-anchor="middle" fill="#666">Prostorové stavby A–E viz testový sešit.</text>')
    s.append('</svg>')
    return "".join(s)
SVG10 = _views()

# uloha 11: rovnobezky m, n proťate primkou p, primka k v bode B; uhly alpha, beta, 135, 31
SVG11 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 300" font-family="sans-serif">
<line x1="50" y1="170" x2="570" y2="170" stroke="#000" stroke-width="2"/>
<line x1="300" y1="70" x2="170" y2="260" stroke="#000" stroke-width="2"/>
<line x1="450" y1="70" x2="320" y2="260" stroke="#000" stroke-width="2"/>
<line x1="382" y1="170" x2="545" y2="80" stroke="#000" stroke-width="2"/>
<text x="298" y="62" font-size="15" font-style="italic">m</text>
<text x="448" y="62" font-size="15" font-style="italic">n</text>
<text x="548" y="82" font-size="15" font-style="italic">k</text>
<text x="558" y="184" font-size="15" font-style="italic">p</text>
<text x="252" y="160" font-size="15">α</text>
<text x="180" y="212" font-size="14">135°</text>
<text x="404" y="160" font-size="14">31°</text>
<text x="356" y="200" font-size="15">β</text>
<text x="388" y="188" font-size="14" font-style="italic">B</text>
</svg>"""

# ulohy 12, 13, 14: sloupcovy graf odchylek vysky hladiny Vltavy od normalu (21 dni)
def _vltava():
    dev = [-30, -35, -40, -30, -20, -20, -15, -10, -5, 15, 20, 20, 30, None, 15, 10, 5, -5, -10, -15, -30]
    x0 = 54; y0 = 150; bw = 18; step = 26; u = 1.4
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 300" font-family="sans-serif">']
    for g in range(-40, 41, 10):
        y = y0 - g * u
        s.append(f'<line x1="{x0}" y1="{y:.0f}" x2="600" y2="{y:.0f}" stroke="#ddd"/>')
        s.append(f'<text x="{x0-6}" y="{y+4:.0f}" font-size="10" text-anchor="end">{g}</text>')
    s.append(f'<line x1="{x0}" y1="{y0}" x2="600" y2="{y0}" stroke="#000"/>')
    for i, v in enumerate(dev):
        cx = x0 + 8 + i * step
        s.append(f'<text x="{cx:.0f}" y="86" font-size="9">{i+1}</text>')
        if v is None:
            s.append(f'<rect x="{cx:.0f}" y="{y0-60:.0f}" width="{bw}" height="60" fill="none" stroke="#888" stroke-dasharray="3 3"/>')
            s.append(f'<text x="{cx+3:.0f}" y="{y0-28:.0f}" font-size="14">?</text>')
        else:
            h = v * u
            yy = y0 - h if v >= 0 else y0
            s.append(f'<rect x="{cx:.0f}" y="{yy:.0f}" width="{bw}" height="{abs(h):.0f}" fill="#8a8a8a"/>')
    s.append('</svg>')
    return "".join(s)
SVGG = _vltava()

B = ['zs2', 'r7']  # 7. rocnik ZS (sestilete obory)

PROBLEMS = [
    {'name': 'CERMAT M7C 2024 – úloha 1',
     'zad': ['Sedmina neznámého čísla je $7$.', 'Vypočítejte sedminásobek neznámého čísla.'],
     'opts': None, 'ln': 2,
     'sol': ['Sedmina čísla je $7$, proto neznámé číslo je $7\\cdot 7=49$. Sedminásobek je $49\\cdot 7=343$.'],
     'ans': '$343$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7C 2024 – úloha 2.1',
     'zad': ['Vypočítejte a výsledek zapište zlomkem v základním tvaru. Uveďte celý postup řešení.',
             '$\\frac{4}{5}-\\frac{7}{4}\\cdot\\left(2-\\frac{4}{7}\\right)=$'],
     'opts': None, 'ln': 3,
     'sol': ['V závorce $2-\\frac{4}{7}=\\frac{10}{7}$. Dále $\\frac{7}{4}\\cdot\\frac{10}{7}=\\frac{10}{4}=\\frac{5}{2}$. Nakonec $\\frac{4}{5}-\\frac{5}{2}=\\frac{8}{10}-\\frac{25}{10}=-\\frac{17}{10}$.'],
     'ans': '$-\\frac{17}{10}$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7C 2024 – úloha 2.2',
     'zad': ['Vypočítejte a výsledek zapište zlomkem v základním tvaru. Uveďte celý postup řešení.',
             '$\\dfrac{\\frac{4}{9}\\cdot 2}{\\frac{5}{3}:3+3}=$'],
     'opts': None, 'ln': 3,
     'sol': ['Čitatel: $\\frac{4}{9}\\cdot 2=\\frac{8}{9}$. Jmenovatel: $\\frac{5}{3}:3+3=\\frac{5}{9}+3=\\frac{32}{9}$. Podíl $\\frac{8}{9}:\\frac{32}{9}=\\frac{8}{32}=\\frac{1}{4}$.'],
     'ans': '$\\frac{1}{4}$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7C 2024 – úloha 3.1',
     'zad': ['Vypočítejte. Uveďte celý postup řešení.', '$0{,}7\\cdot 0{,}8+0{,}8\\cdot 1{,}3=$'],
     'opts': None, 'ln': 3,
     'sol': ['$0{,}7\\cdot 0{,}8+0{,}8\\cdot 1{,}3=0{,}56+1{,}04=1{,}6$. (Nebo $0{,}8\\cdot(0{,}7+1{,}3)=0{,}8\\cdot 2=1{,}6$.)'],
     'ans': '$1{,}6$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7C 2024 – úloha 3.2',
     'zad': ['Vypočítejte. Uveďte celý postup řešení.', '$1{,}5+0{,}5\\cdot(12-8)-2{,}5:5=$'],
     'opts': None, 'ln': 3,
     'sol': ['$1{,}5+0{,}5\\cdot(12-8)-2{,}5:5=1{,}5+0{,}5\\cdot 4-0{,}5=1{,}5+2-0{,}5=3$.'],
     'ans': '$3$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7C 2024 – úloha 4.1',
     'zad': ['Od rybníka k hradu vedou dvě turistické cesty. Modrá je o třetinu kratší než červená. Obě cesty se liší o $3$ km.',
             'Jaká je délka červené trasy? Výsledek uveďte v kilometrech.'],
     'opts': None, 'ln': 3,
     'sol': ['Modrá je $\\frac{2}{3}$ délky červené, rozdíl délek je $\\frac{1}{3}$ červené. Platí $\\frac{1}{3}$ červené $=3$ km, tedy červená $=9$ km.'],
     'ans': '$9$ km', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7C 2024 – úloha 4.2',
     'zad': ['Na sídlišti se stala porucha vodovodního potrubí, proto byla ráno přistavena cisterna s pitnou vodou o objemu $40$ hektolitrů. Podnikatel z ní v průběhu dne odčerpal vodu do dvou barelů po $1\\,250$ litrech. Do večera ještě lidé odebrali $70$ dvacetilitrových kanystrů.',
             'Kolik litrů vody zbylo večer v přistavené cisterně?'],
     'opts': None, 'ln': 3,
     'sol': ['$40$ hektolitrů $=4000$ litrů. Podnikatel odčerpal $2\\cdot 1250=2500$ l, lidé odebrali $70\\cdot 20=1400$ l. Zbylo $4000-2500-1400=100$ l.'],
     'ans': '$100$ litrů', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7C 2024 – úloha 5',
     'zad': ['Ve třídě 9. B se vytvořilo 5 týmů, které se zúčastnily orientačního závodu. Týmy startovaly v 6minutových rozestupech. Údaje o časech naleznete v tabulce ve tvaru h:min:s (viz obrázek).',
             '5.1 Jaký je výsledný čas vítěze? Výsledek uveďte ve tvaru h:min:s.',
             '5.2 Na kolikátém místě skončil tým A?',
             '5.3 Jaký rozdíl byl v dosažených časech mezi vítězným týmem a týmem, co se umístil na posledním místě? Výsledek uveďte v minutách a sekundách.'],
     'opts': None, 'ln': 4, 'svg': SVG5, 'fn': 'zavod-tabulka.svg',
     'alt': 'Tabulka časů startu, časů v cíli a výsledných časů pěti týmů A až E.',
     'cap': 'Výsledky orientačního závodu (h:min:s)',
     'sol': ['Týmy startovaly po $6$ minutách: A $14{:}30{:}00$, B $14{:}36{:}00$, C $14{:}42{:}00$, D $14{:}48{:}00$, E $14{:}54{:}00$.',
             '5.1 Výsledný čas E $=15{:}33{:}20-14{:}54{:}00=0{:}39{:}20$, což je nejlepší (vítěz).',
             '5.2 Výsledné časy: E $0{:}39{:}20$, B $0{:}46{:}03$, A $0{:}47{:}46$, C $0{:}48{:}32$, D $0{:}49{:}40$. Tým A skončil třetí.',
             '5.3 Poslední je tým D ($0{:}49{:}40$), vítěz E ($0{:}39{:}20$); rozdíl je $10$ min $20$ s.'],
     'ans': '5.1: $0{:}39{:}20$; 5.2: $3.$ místo; 5.3: $10$ min $20$ s', 'pts': 3, 'mins': 6, 'diff': '3',
     'codes': B + ['statistika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7C 2024 – úloha 6',
     'zad': ['Rodina Novotných si koupila pozemek ve tvaru obdélníku na stavbu domu. Plocha pozemku je $988$ m² a kratší strana měří $26$ m (viz obrázek). Pozemek chtějí oplotit tak, aby spotřebovali co nejméně sloupků a mezi dvěma sousedními sloupky po celém obvodu byla vždy stejná mezera, kterou lze změřit v celých metrech.',
             'Kolik sloupků musí rodina Novotných koupit, aby bylo možné za uvedených podmínek pozemek oplotit?'],
     'opts': None, 'ln': 2, 'svg': SVG6, 'fn': 'pozemek.svg',
     'alt': 'Obdélníkový pozemek o obsahu 988 m² s kratší stranou 26 m.',
     'cap': 'Pozemek rodiny Novotných',
     'sol': ['Delší strana pozemku je $988:26=38$ m, obvod $2\\cdot(26+38)=128$ m. Aby sloupků bylo co nejméně a mezera byla stejná v celých metrech (i v rozích), musí mezera dělit obě strany; největší taková je největší společný dělitel čísel $26$ a $38$, tj. $2$ m. Počet sloupků $128:2=64$.'],
     'ans': '$64$ sloupků', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['planimetrie', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7C 2024 – úloha 7',
     'zad': ['Z kvádru se čtvercovou podstavou byl vyříznut trojboký hranol. Body $S$ a $S^{\\prime}$ jsou průsečíky úhlopříček podstav tohoto kvádru (viz obrázek). Platí $|AB|=8$ cm, $|AE|=1{,}3$ dm.',
             '7.1 Vypočítejte povrch kvádru $ABCDEFGH$. Výsledek uveďte v dm².',
             '7.2 Vypočítejte objem hranolu s podstavou $ABSCD$. Výsledek uveďte v cm³.'],
     'opts': None, 'ln': 4, 'svg': SVG7, 'fn': 'kvadr-hranol.svg',
     'alt': 'Kvádr se čtvercovou podstavou ABCD a horní podstavou EFGH s vyříznutým trojbokým hranolem; S a S´ jsou průsečíky úhlopříček podstav.',
     'cap': 'Kvádr s vyříznutým trojbokým hranolem (schematický nákres)',
     'sol': ['Podstava je čtverec se stranou $|AB|=8$ cm $=0{,}8$ dm, výška $|AE|=1{,}3$ dm.',
             '7.1 Povrch $=2\\cdot 0{,}8^2+4\\cdot 0{,}8\\cdot 1{,}3=1{,}28+4{,}16=5{,}44$ dm².',
             '7.2 Vyříznutý trojboký hranol má podstavu (trojúhelník $SBC$) o obsahu $\\frac{1}{2}\\cdot 8\\cdot 4=16$ cm² a výšku $13$ cm, tedy objem $16\\cdot 13=208$ cm³. Hranol s podstavou $ABSCD$ (pětiúhelník) má objem $8\\cdot 8\\cdot 13-208=832-208=624$ cm³.'],
     'ans': '7.1: $5{,}44$ dm²; 7.2: $624$ cm³', 'pts': 4, 'mins': 7, 'diff': '3',
     'codes': B + ['stereometrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7C 2024 – úloha 8 (konstrukce)',
     'zad': ['Jsou zadány body $A$ a $S$ (viz obrázek).',
             'Bod $A$ je vrchol kosodélníku $ABCD$ a bod $S$ je průsečík úhlopříček kosodélníku $ABCD$, které svírají úhel $120^\\circ$. Délka úhlopříčky $BD$ je stejná jako délka úsečky $AS$.',
             'Sestrojte kosodélník $ABCD$. Nalezněte všechna možná řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG8, 'fn': 'body-AS.svg',
     'alt': 'Body A a S v rovině.', 'cap': 'Výchozí obrázek k úloze 8',
     'sol': ['Sestrojíme přímku $AS$ a kružnici $k_1(S; |AS|)$; její průsečík s přímkou $AS$ je vrchol $C$, takže $S$ je střed úhlopříčky $AC$.',
             'Bodem $S$ vedeme přímku $p$ svírající s $AC$ úhel $120^\\circ$. Protože $|BD|=|AS|$ a $S$ je střed úhlopříčky $BD$, sestrojíme kružnici $k_2\\left(S; \\frac{1}{2}|AS|\\right)$.',
             'Průsečíky $k_2$ s přímkou $p$ jsou vrcholy $B$ a $D$. Úloha má dvě řešení: kosodélníky $AB_1CD_1$ a $AB_2CD_2$.'],
     'ans': 'Dvě řešení: $S$ je střed úhlopříčky $AC$ ($C$ na $k_1(S;|AS|)$), úhlopříčka $BD$ leží na přímce procházející $S$ pod úhlem $120^\\circ$ k $AC$, $|SB|=|SD|=\\frac{1}{2}|AS|$; kosodélníky $AB_1CD_1$ a $AB_2CD_2$ (viz obrázek v klíči).',
     'pts': 3, 'mins': 7, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7C 2024 – úloha 9',
     'zad': ['Adam se rozhodl, že si vyrobí originální šachový stolek. Koupil si černou a bílou samolepící folii a šedý stůl o rozměrech $80$ cm a $56$ cm polepil tak, jak je znázorněno na obrázku. Šachovnice je tvořena čtverci o straně $4$ cm, pruh je tvořený kosodélníky a trojúhelníky a má šířku $4$ cm.',
             '9.1 Kolik procent z celé desky stolu překrývá 1 pruh?',
             '9.2 V jakém poměru je nepolepená část desky stolu k celé desce stolu?',
             '9.3 V jakém poměru jsou černé a bílé plochy na desce stolu?'],
     'opts': None, 'ln': 4, 'svg': SVG9, 'fn': 'sachovy-stolek.svg',
     'alt': 'Šedá deska stolu s šachovnicí uprostřed a čtyřmi svislými pruhy (schematicky).',
     'cap': 'Šachový stolek (schematický nákres)',
     'sol': ['Deska stolu má obsah $80\\cdot 56=4480$ cm².',
             '9.1 Jeden pruh je $4$ cm $\\times\\, 56$ cm $=224$ cm², což je $\\frac{224}{4480}=0{,}05=5\\,\\%$ desky.',
             '9.2 Šachovnice ($32\\times 32$ cm) má obsah $1024$ cm², čtyři pruhy $4\\cdot 224=896$ cm². Polepeno je $1920$ cm², nepolepeno $4480-1920=2560$ cm². Poměr nepolepené k celé desce je $2560:4480=4:7$.',
             '9.3 Na šachovnici je stejně černých i bílých polí a i v pruzích se černá a bílá plocha rovnají, proto černé : bílé $=1:1$.'],
     'ans': '9.1: $5\\,\\%$; 9.2: $4:7$; 9.3: $1:1$', 'pts': 3, 'mins': 7, 'diff': '4',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7C 2024 – úloha 10',
     'zad': ['Petr postavil ze sedmi stejných kostek stavbu. Nakreslil si tři pohledy na stavbu: zepředu, zleva a shora (viz obrázek).',
             'Kterou z uvedených staveb (A–E) Petr viděl tak, jak je uvedeno ve výchozím textu? Prostorové stavby A–E jsou v testovém sešitě.'],
     'opts': ['A) stavba A', 'B) stavba B', 'C) stavba C', 'D) stavba D', 'E) stavba E'],
     'ln': 0, 'svg': SVG10, 'fn': 'pohledy.svg',
     'alt': 'Tři pohledy na stavbu ze sedmi kostek: zepředu, zleva a shora.',
     'cap': 'Pohledy na stavbu (prostorové varianty A–E viz testový sešit)',
     'sol': ['Porovnáním tří pohledů (zepředu, zleva, shora) se stavbou ze sedmi kostek odpovídá těleso $C$. Prostorová tělesa $A$–$E$ nelze věrně přenést do náčrtu; posuzuje se podle originálu v testovém sešitě.'],
     'ans': 'C) stavba C', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['stereometrie', 'porozumeni', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7C 2024 – úloha 11',
     'zad': ['Přímky $m$, $n$ jsou rovnoběžné. Přímky $k$, $n$ a $p$ se protínají v bodě $B$ (viz obrázek).',
             'Jaký je součet velikostí úhlů $\\alpha$ a $\\beta$? Velikosti úhlů neměřte, ale vypočítejte (obrázek je ilustrační).'],
     'opts': ['A) $101^\\circ$', 'B) $121^\\circ$', 'C) $132^\\circ$', 'D) $137^\\circ$', 'E) jiná velikost'],
     'ln': 0, 'svg': SVG11, 'fn': 'uhly-mnkp.svg',
     'alt': 'Rovnoběžky m a n proťaté přímkou p, přímka k v bodě B; vyznačené úhly alfa, beta, 135° a 31°.',
     'cap': 'Ilustrační obrázek k úloze 11',
     'sol': ['Přímka $p$ je příčkou rovnoběžek $m$ a $n$. Úhel $\\alpha$ je vedlejší k úhlu $135^\\circ$, proto $\\alpha=180^\\circ-135^\\circ=45^\\circ$; stejný úhel svírají s přímkou $p$ i rovnoběžky $m$, $n$.',
             'V bodě $B$ svírá přímka $k$ s přímkou $p$ úhel $31^\\circ$. Úhel $\\beta$ pak má velikost $45^\\circ+31^\\circ=76^\\circ$.',
             'Součet je $\\alpha+\\beta=45^\\circ+76^\\circ=121^\\circ$.'],
     'ans': 'B) $121^\\circ$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7C 2024 – úloha 12',
     'zad': ['Graf znázorňuje výšku hladiny Vltavy v průběhu tří týdnů z července. Výška hladiny vody se uvádí zaokrouhlená po $5$ cm. Nula znamená normální stav – výšku hladiny $120$ cm. Údaj ze $14.$ července není uveden (viz obrázek).',
             'Jak vysoko dosahovala hladina vody $14.$ července, jestliže průměrná hodnota výšky hladiny vody za uvedených $21$ dní byla $115$ cm?'],
     'opts': ['A) $120$ cm', 'B) $145$ cm', 'C) $160$ cm', 'D) $165$ cm', 'E) $225$ cm'],
     'ln': 0, 'svg': SVGG, 'fn': 'vltava-graf.svg',
     'alt': 'Sloupcový graf odchylek výšky hladiny Vltavy od normálu pro 21 dní; údaj ze 14. dne není uveden.',
     'cap': 'Výška hladiny Vltavy (odchylka od normálu v cm)',
     'sol': ['Průměrná výška za $21$ dní je $115$ cm, tj. o $5$ cm pod normálem ($120$ cm). Součet odchylek za $21$ dní je $-5\\cdot 21=-105$ cm.',
             'Součet odchylek ostatních $20$ dní (z grafu) je $-150$ cm, proto odchylka $14.$ dne je $-105-(-150)=45$ cm.',
             'Hladina $14.$ července byla $120+45=165$ cm.'],
     'ans': 'D) $165$ cm', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['statistika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7C 2024 – úloha 13',
     'zad': ['Graf znázorňuje výšku hladiny Vltavy v průběhu tří týdnů z července; nula je normální stav $120$ cm a výška se uvádí po $5$ cm (viz obrázek).',
             'Jak se za deset dní od $4.\\,7.$ do $13.\\,7.$ v průměru lišila hladina vody oproti normálu? Pro tento výpočet použijte při poklesu hladiny pod normál číslo záporné, při stoupnutí nad normál číslo kladné dle grafu.'],
     'opts': ['A) Hladina byla o $2{,}5$ cm níže oproti normálu.',
              'B) Hladina byla o $1{,}5$ cm níže oproti normálu.',
              'C) Hladina se oproti normálu nelišila.',
              'D) Hladina byla o $1{,}5$ cm výše oproti normálu.',
              'E) Hladina byla o $2{,}5$ cm výše oproti normálu.'],
     'ln': 0, 'svg': SVGG, 'fn': 'vltava-graf.svg',
     'alt': 'Sloupcový graf odchylek výšky hladiny Vltavy od normálu pro 21 dní; údaj ze 14. dne není uveden.',
     'cap': 'Výška hladiny Vltavy (odchylka od normálu v cm)',
     'sol': ['Odchylky od normálu ve dnech $4.$–$13.$ července (v cm): $-30,-20,-20,-15,-10,-5,15,20,20,30$.',
             'Součet je $-15$ cm, průměr za $10$ dní je $-15:10=-1{,}5$ cm.',
             'Hladina byla v průměru o $1{,}5$ cm níže oproti normálu.'],
     'ans': 'B) o $1{,}5$ cm níže oproti normálu', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['statistika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7C 2024 – úloha 14',
     'zad': ['Graf znázorňuje výšku hladiny Vltavy v průběhu tří týdnů z července; nula je normální stav $120$ cm (viz obrázek). Část Vltavy je pro vodáky splavná až od $135$ cm a za ten den na ni může nejvýše $50$ kajaků po $3$ lidech a $10$ raftů po $6$ lidech.',
             'Rozhodněte o každém z tvrzení 14.1–14.3, zda je pravdivé (A), či nikoli (N).',
             '14.1 Vltava byla splavná méně než $23\\,\\%$ sledovaných dnů.',
             '14.2 Na Vltavu se za uvedené období mohlo dostat nejvýše $1\\,260$ lidí.',
             '14.3 $13.\\,7.$ mohla nastat situace, že lidé na raftech tvořili alespoň $30\\,\\%$ vodáků.'],
     'opts': None, 'ln': 0, 'svg': SVGG, 'fn': 'vltava-graf.svg',
     'alt': 'Sloupcový graf odchylek výšky hladiny Vltavy od normálu pro 21 dní; údaj ze 14. dne není uveden.',
     'cap': 'Výška hladiny Vltavy (odchylka od normálu v cm)',
     'sol': ['Splavná je od $135$ cm, tj. při odchylce aspoň $+15$ cm. To platí ve dnech $10.$, $11.$, $12.$, $13.$, $14.$ (odchylka $+45$) a $15.$, celkem $6$ dnů z $21$.',
             '14.1 $6$ z $21$ dnů je $\\frac{6}{21}\\approx 28{,}6\\,\\%$, což není méně než $23\\,\\%$, tvrzení je nepravdivé (N).',
             '14.2 Za den je na řece nejvýše $50\\cdot 3+10\\cdot 6=210$ lidí, za $6$ splavných dnů nejvýše $6\\cdot 210=1\\,260$ lidí, tvrzení je pravdivé (A).',
             '14.3 Rafty pojmou nejvýše $60$ lidí; při dostatečně malém počtu kajakářů mohou rafťáci tvořit aspoň $30\\,\\%$ (např. $60$ z $200$ vodáků), tvrzení je pravdivé (A).'],
     'ans': '14.1: N; 14.2: A; 14.3: A', 'pts': 3, 'mins': 6, 'diff': '4',
     'codes': B + ['statistika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7C 2024 – úloha 15',
     'zad': ['Babička si vzpomíná na výborný čaj proti kašli, ale zapomněla poměry, ve kterých se bylinky míchají. Vzpomíná si, že čaj byl z lipového květu, jitrocele a mateřídoušky. Lipový květ k jitroceli byl v poměru $2:3$ a jitrocel k mateřídoušce také v poměru $2:3$.',
             'Rozhodněte o každém z tvrzení 15.1–15.3, zda je pravdivé (A), či nikoli (N).',
             '15.1 Babička přidávala ke $100$ g lipového květu $150$ g jitrocele.',
             '15.2 Lipový květ k mateřídoušce bude v poměru $2:3$.',
             '15.3 Babička přidávala k $200$ g lipového květu $450$ g mateřídoušky.'],
     'opts': None, 'ln': 0,
     'sol': ['Lipový květ : jitrocel $=2:3$ a jitrocel : mateřídouška $=2:3$. Sjednocením přes jitrocel dostaneme lipový květ : jitrocel : mateřídouška $=4:6:9$.',
             '15.1 Lipový květ : jitrocel $=2:3=100:150$, ke $100$ g lipového květu tedy $150$ g jitrocele, tvrzení je pravdivé (A).',
             '15.2 Lipový květ : mateřídouška $=4:9\\ne 2:3$, tvrzení je nepravdivé (N).',
             '15.3 Lipový květ : mateřídouška $=4:9$; ke $200$ g lipového květu je $200\\cdot\\frac{9}{4}=450$ g mateřídoušky, tvrzení je pravdivé (A).'],
     'ans': '15.1: A; 15.2: N; 15.3: A', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['procenta', 'argumentace', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7C 2024 – úloha 16',
     'zad': ['Jana naplánovala pro sebe a svou kamarádku Olinu výlet. Jedna třetina cesty vedla po rovině, tři čtvrtiny zbytku do kopce a posledních $800$ m z kopce.',
             '16.1 Jaká byla délka celé cesty? Výsledek uveďte v kilometrech.',
             '16.2 Cesta byla vyznačena na mapě s měřítkem $1:24\\,000$. Jak dlouhá byla cesta na této mapě? Výsledek uveďte v centimetrech.',
             '16.3 $40\\,\\%$ cesty nesla batoh Jana. Kolik kilometrů nesla batoh Jana? Výsledek zaokrouhlete na desetiny kilometrů.'],
     'opts': None, 'ln': 4,
     'sol': ['Rovinou vede $\\frac{1}{3}$ cesty, zbývají $\\frac{2}{3}$. Do kopce jsou $\\frac{3}{4}$ zbytku, tj. $\\frac{3}{4}\\cdot\\frac{2}{3}=\\frac{1}{2}$ cesty. Z kopce zbývá $\\frac{1}{4}\\cdot\\frac{2}{3}=\\frac{1}{6}$ cesty, a to je $800$ m.',
             '16.1 Celá cesta $=6\\cdot 800=4800$ m $=4{,}8$ km.',
             '16.2 $4{,}8$ km $=480\\,000$ cm; na mapě $480\\,000:24\\,000=20$ cm.',
             '16.3 $40\\,\\%$ ze $4{,}8$ km je $1{,}92$ km $\\approx 1{,}9$ km.'],
     'ans': '16.1: $4{,}8$ km; 16.2: $20$ cm; 16.3: $1{,}9$ km', 'pts': 6, 'mins': 8, 'diff': '4',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M7PCD24C0T03'
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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M7C-2024')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
