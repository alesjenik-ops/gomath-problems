# -*- coding: utf-8 -*-
# CERMAT - Jednotna prijimaci zkouska 2019, MATEMATIKA 5 B (osmilete obory, 5. rocnik),
# 2. radny termin. Kod testu: M5PBD19C0T02. 14 uloh (po rozdeleni izolovanych poduloh 17 uloh).
# Zdroj odpovedi: klic spravnych reseni (KSR). VZA je prazdna sablona zaznamoveho archu.

import math

# ---- SVG obrazky (bez ' a \) ----

# uloha 6: papirova paska se tremi prouzky ze ctverecku (schematicky)
def _tape():
    def rect(x, y, w, h, fill="none"):
        return f'<rect x="{x}" y="{y}" width="{w}" height="{h}" fill="{fill}" stroke="#000" stroke-width="1.4"/>'
    def vdash(x, y1, y2):
        return f'<line x1="{x}" y1="{y1}" x2="{x}" y2="{y2}"/>'
    y0, y1 = 36, 74
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 590 118" font-family="sans-serif">']
    s.append('<g stroke="#000" stroke-width="1" stroke-dasharray="3 3">'
             + "".join(vdash(x, y0, y1) for x in (74, 96))
             + "".join(vdash(140 + i * 31, y0, y1) for i in range(1, 10))
             + "".join(vdash(493 + i * 18, y0, y1) for i in range(1, 4))
             + '</g>')
    s.append('<text x="6" y="60" font-size="11">šířka</text>')
    s.append('<line x1="46" y1="36" x2="46" y2="74" stroke="#000"/><polygon points="46,36 43,43 49,43" fill="#000"/><polygon points="46,74 43,67 49,67" fill="#000"/>')
    s.append(rect(52, y0, 66, y1 - y0))
    s.append(rect(140, y0, 310, y1 - y0))
    s.append(rect(493, y0, 72, y1 - y0))
    s.append('<line x1="52" y1="86" x2="74" y2="86" stroke="#000"/><polygon points="52,86 57,83 57,89" fill="#000"/><polygon points="74,86 69,83 69,89" fill="#000"/>')
    s.append('<line x1="140" y1="86" x2="450" y2="86" stroke="#000"/><polygon points="140,86 145,83 145,89" fill="#000"/><polygon points="450,86 445,83 445,89" fill="#000"/>')
    s.append('<circle cx="480" cy="55" r="13" fill="#eee" stroke="#000"/><circle cx="480" cy="55" r="4" fill="#fff" stroke="#000"/>')
    s.append('<g font-size="11" text-anchor="middle"><text x="63" y="100">2 cm</text><text x="295" y="100">délka proužku</text></g>')
    s.append('<g font-size="12" text-anchor="middle"><text x="85" y="24">1. proužek</text><text x="295" y="24">2. proužek</text><text x="540" y="24">3. proužek</text></g>')
    s.append('<text x="574" y="60" font-size="14">…</text>')
    s.append('<text x="503" y="92" font-size="12">✂</text>')
    s.append('</svg>')
    return "".join(s)
SVG6 = _tape()

# uloha 7: vychozi obrazek - bod O, primka p, kruznice k se stredem S, bod A na pruseciku
SVG7 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 330" font-family="sans-serif">
<circle cx="255" cy="140" r="90" fill="none" stroke="#000" stroke-width="1.6"/>
<line x1="45" y1="140" x2="445" y2="250" stroke="#000" stroke-width="1.6"/>
<text x="200" y="66" font-size="15" font-style="italic">k</text>
<text x="262" y="140" font-size="14">×</text><text x="270" y="150" font-size="14" font-style="italic">S</text>
<text x="162" y="175" font-size="14">×</text><text x="150" y="190" font-size="14" font-style="italic">A</text>
<text x="250" y="300" font-size="14">×</text><text x="258" y="312" font-size="14" font-style="italic">O</text>
<text x="448" y="256" font-size="15" font-style="italic">p</text>
</svg>"""

# uloha 8: ctvercova sit 6x6, ctverec rozdeleny na 3 trojuhelniky (A,B,C) a tmavy obrazec
def _grid8():
    u = 28; ox = 34; oy = 18
    def X(c): return ox + c * u
    def Y(c): return oy + c * u
    def poly(pts, fill):
        p = " ".join(f"{X(a)},{Y(b)}" for a, b in pts)
        return f'<polygon points="{p}" fill="{fill}"/>'
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 262 214" font-family="sans-serif">']
    s.append('<g stroke="#000" stroke-width="1.6">')
    s.append(poly([(1, 6), (4, 0), (6, 6)], "#333333"))   # tmavy obrazec (15)
    s.append(poly([(0, 0), (4, 0), (0, 6)], "#c9c9c9"))   # A (12)
    s.append(poly([(4, 0), (6, 0), (6, 6)], "#c9c9c9"))   # B (6)
    s.append(poly([(0, 6), (4, 0), (1, 6)], "#c9c9c9"))   # C (3)
    s.append('</g><g stroke="#888" stroke-width="0.6">')
    for i in range(7):
        s.append(f'<line x1="{X(i)}" y1="{Y(0)}" x2="{X(i)}" y2="{Y(6)}"/>')
        s.append(f'<line x1="{X(0)}" y1="{Y(i)}" x2="{X(6)}" y2="{Y(i)}"/>')
    s.append('</g>')
    s.append(f'<rect x="{X(0)}" y="{Y(0)}" width="{6 * u}" height="{6 * u}" fill="none" stroke="#000" stroke-width="2"/>')
    s.append('<g font-size="14" font-weight="bold">')
    s.append(f'<text x="{X(0.9)}" y="{Y(2.4)}">A</text>')
    s.append(f'<text x="{X(4.9)}" y="{Y(2.4)}">B</text>')
    s.append(f'<text x="{X(1.2)}" y="{Y(5.4)}">C</text></g>')
    s.append(f'<text x="{X(6) + 4}" y="{Y(5.7)}" font-size="10">1 cm²</text>')
    s.append('</svg>')
    return "".join(s)
SVG8 = _grid8()

# ulohy 11-12: kruhovy (kolacovy) graf zaku podle poctu sourozencu
def _pie():
    cx, cy, r = 210, 155, 92
    data = [('žáci se 3 sourozenci', 12, '#8a8a8a'),
            ('žáci bez sourozenců', 120, '#bdbdbd'),
            ('žáci s 1 sourozencem', 168, '#ffffff'),
            ('žáci se 2 sourozenci', 60, '#e4e4e4')]
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 320" font-family="sans-serif">']
    a0 = 0.0; labels = []
    for label, ang, col in data:
        a1 = a0 + ang
        x1 = cx + r * math.sin(math.radians(a0)); y1 = cy - r * math.cos(math.radians(a0))
        x2 = cx + r * math.sin(math.radians(a1)); y2 = cy - r * math.cos(math.radians(a1))
        large = 1 if ang > 180 else 0
        s.append(f'<path d="M {cx:.1f} {cy:.1f} L {x1:.1f} {y1:.1f} A {r} {r} 0 {large} 1 {x2:.1f} {y2:.1f} Z" fill="{col}" stroke="#000" stroke-width="1.4"/>')
        mid = (a0 + a1) / 2.0
        lx = cx + (r + 20) * math.sin(math.radians(mid)); ly = cy - (r + 20) * math.cos(math.radians(mid))
        labels.append((label, lx, ly)); a0 = a1
    for label, lx, ly in labels:
        anchor = "middle" if abs(lx - cx) < 26 else ("start" if lx > cx else "end")
        s.append(f'<text x="{lx:.1f}" y="{ly:.1f}" font-size="12" text-anchor="{anchor}">{label}</text>')
    s.append('</svg>')
    return "".join(s)
SVG_PIE = _pie()

# uloha 13: planky (shora / zepredu) - vzor a jina stavba se zakrytymi kartickami K, L, M
def _plany():
    cw, ch = 26, 24
    def table(ox, oy, rows, shade=()):
        cells = []; txt = []
        for r, (a, b) in enumerate(rows):
            for c, val in enumerate((a, b)):
                x = ox + c * cw; y = oy + r * ch
                fill = "#c9c9c9" if (r, c) in shade else "#fff"
                cells.append(f'<rect x="{x}" y="{y}" width="{cw}" height="{ch}" fill="{fill}"/>')
                txt.append(f'<text x="{x + cw / 2:.0f}" y="{y + ch / 2 + 5:.0f}">{val}</text>')
        return "".join(cells), "".join(txt)
    tabs = [table(30, 44, [('3', '2'), ('1', '0'), ('2', '1')]),
            table(140, 44, [('1', '0'), ('2', '1'), ('3', '2')]),
            table(290, 44, [('1', '3'), ('K', '3'), ('2', '1')], shade={(1, 0)}),
            table(400, 44, [('0', 'M'), ('2', '2'), ('3', 'L')], shade={(0, 1), (2, 1)})]
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 138" font-family="sans-serif">']
    s.append('<g stroke="#000" fill="#fff">')
    s.append("".join(c for c, _ in tabs))
    s.append('</g><g font-size="14" text-anchor="middle">')
    s.append("".join(t for _, t in tabs))
    s.append('</g><g font-size="11">')
    s.append('<text x="40" y="38">shora</text><text x="150" y="38">zepředu</text>')
    s.append('<text x="300" y="38">shora</text><text x="410" y="38">zepředu</text></g>')
    s.append('<g font-size="12" font-weight="bold"><text x="60" y="16">Vzor</text><text x="300" y="16">Jiná stavba</text></g>')
    s.append('</svg>')
    return "".join(s)
SVG13 = _plany()

# uloha 14: mozaika - kroky 1-4 (stridave sede/bile L-vrstvy), posledni vrstva carkovane
def _mozaika():
    u = 15
    G = "#b9b9b9"; W = "#ffffff"
    cells = []; labs = []
    ox = 20
    for m in range(1, 5):
        cols = m + 1
        for r in range(1, m + 1):
            for c in range(1, cols + 1):
                j = max(r, c - 1)
                fill = G if j % 2 == 1 else W
                dash = ' stroke-dasharray="3 2"' if j == m else ''
                x = ox + (cols - c) * u; y = 95 - r * u
                cells.append(f'<rect x="{x}" y="{y}" width="{u}" height="{u}" fill="{fill}"{dash}/>')
        labs.append(f'<text x="{ox + cols * u / 2:.0f}" y="115">{m}. krok</text>')
        ox += cols * u + 18
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 350 130" font-family="sans-serif">']
    s.append('<g stroke="#000" stroke-width="1">')
    s.append("".join(cells))
    s.append('</g>')
    s.append('<g font-size="11" text-anchor="middle">' + "".join(labs) + '</g>')
    s.append('<text x="300" y="60" font-size="16">…</text>')
    s.append(f'<text x="{ox + 6}" y="42" font-size="9">4. řada</text>')
    s.append(f'<text x="{ox + 6}" y="88" font-size="9">1. řada</text>')
    s.append('</svg>')
    return "".join(s)
SVG14 = _mozaika()


B = ['zs1']  # 5. rocnik ZS (prijimacky na osmilete obory); kod r5 v taxonomii neni

PROBLEMS = [
    {'name': 'CERMAT M5B 2019 – úloha 1.1',
     'zad': ['Vypočtěte: $9 + 9 \\cdot 7 - 7 + (7 + 7) \\cdot (9 - 9) =$'],
     'opts': None, 'ln': 2,
     'sol': ['Nejprve násobení: $9 \\cdot 7 = 63$ a $(7 + 7) \\cdot (9 - 9) = 14 \\cdot 0 = 0$. Poté $9 + 63 - 7 + 0 = 65$.'],
     'ans': '$65$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5B 2019 – úloha 1.2',
     'zad': ['Vypočtěte: $(105 + 105 + 105) : 3 - 105 : 7 =$'],
     'opts': None, 'ln': 2,
     'sol': ['$(105 + 105 + 105) : 3 - 105 : 7 = 315 : 3 - 15 = 105 - 15 = 90$.'],
     'ans': '$90$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5B 2019 – úloha 2.1',
     'zad': ['Doplňte do rámečku takové číslo (v metrech), aby platila rovnost:',
             '$12$ km $-\\ 6\\,000$ cm $=\\ \\square\\ $ m'],
     'opts': None, 'ln': 2,
     'sol': ['$12$ km $= 12\\,000$ m a $6\\,000$ cm $= 60$ m. Rozdíl $12\\,000 - 60 = 11\\,940$ m.'],
     'ans': '$11\\,940$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5B 2019 – úloha 2.2',
     'zad': ['Doplňte do rámečku takové číslo, aby platila rovnost:',
             '$120$ minut $=\\ \\square\\ \\cdot\\ 20$ sekund'],
     'opts': None, 'ln': 2,
     'sol': ['$120$ minut $= 7\\,200$ sekund; $7\\,200 : 20 = 360$. Tedy $120$ minut $= 360 \\cdot 20$ sekund.'],
     'ans': '$360$', 'pts': 2, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5B 2019 – úloha 3',
     'zad': ['Aleš má v pravé kapse o polovinu méně korun než v levé kapse. Kdyby přendal $40$ korun z levé kapsy do pravé, měl by v obou kapsách stejně.',
             '3.1 Vypočtěte, o kolik korun má Aleš v levé kapse více než v pravé.',
             '3.2 Vypočtěte, kolik korun má Aleš celkem v obou kapsách.'],
     'opts': None, 'ln': 2,
     'sol': ['Levá kapsa $L$, pravá $\\frac{L}{2}$. Po přendání $40$ Kč platí $L - 40 = \\frac{L}{2} + 40$, odtud $\\frac{L}{2} = 80$, tedy $L = 160$ Kč a pravá $80$ Kč.',
             '3.1 Rozdíl $160 - 80 = 80$ korun.',
             '3.2 Celkem $160 + 80 = 240$ korun.'],
     'ans': '3.1: o $80$ korun; 3.2: $240$ korun', 'pts': 3, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5B 2019 – úloha 4',
     'zad': ['Chovatel chová dospělé kočky a koťata. Kupuje jim univerzální granule balené vždy ve stejných pytlích. Za jeden den sežerou $3$ koťata stejné množství granulí jako $2$ dospělé kočky. Celý pytel granulí mají $2$ dospělé kočky přesně na $6$ dní. (Každá dospělá kočka sežere denně stejné množství granulí. Totéž platí o koťatech.)',
             '4.1 Vypočtěte, kolik koťat sežere za $1$ den stejné množství granulí jako $6$ dospělých koček.',
             '4.2 Vypočtěte, kolik dospělých koček sežere půl pytle granulí přesně za $3$ dny.',
             '4.3 Vypočtěte, na kolik dní má jeden pytel granulí $1$ kotě.'],
     'opts': None, 'ln': 3,
     'sol': ['Denní spotřeba: $3$ koťata $=$ $2$ kočky.',
             '4.1 $6$ koček odpovídá $3$ dvojicím koček, tj. $3 \\cdot 3 = 9$ koťat.',
             '4.2 Celý pytel má $2$ kočky na $6$ dní, tedy půl pytle na $3$ dny; půl pytle za $3$ dny proto sežerou $2$ kočky.',
             '4.3 Celý pytel $=$ spotřeba $2$ koček za $6$ dní $=$ spotřeba $3$ koťat za $6$ dní $=$ spotřeba $1$ kotěte za $18$ dní.'],
     'ans': '4.1: $9$ koťat; 4.2: $2$ kočky; 4.3: na $18$ dní', 'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5B 2019 – úloha 5',
     'zad': ['Děti měřily šířku hřiště pomocí tyčí dvou různých délek. Adam na celou šířku hřiště naskládal těsně za sebou $11$ dlouhých tyčí a $2$ krátké, zatímco Markéta $4$ dlouhé tyče a $23$ krátkých.',
             '5.1 Určete, kolik krátkých tyčí nahradí jednu dlouhou tyč.',
             '5.2 Určete, kolika krátkými tyčemi odměříme celou šířku hřiště.'],
     'opts': None, 'ln': 2,
     'sol': ['Šířka je v obou případech stejná: $11$ D $+ 2$ K $= 4$ D $+ 23$ K, odtud $7$ D $= 21$ K.',
             '5.1 Jednu dlouhou tyč nahradí $21 : 7 = 3$ krátké tyče.',
             '5.2 Šířka $= 11 \\cdot 3 + 2 = 35$ krátkých tyčí.'],
     'ans': '5.1: $3$ krátké tyče; 5.2: $35$ krátkými tyčemi', 'pts': 4, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5B 2019 – úloha 6',
     'zad': ['Na papírové pásce jsou vyznačeny shodné čtverečky. Adéla z pásky odstřihla $3$ proužky tvaru obdélníku, první proužek je nejkratší a třetí je nejdelší. Třetí proužek je šestkrát delší než první a skládá se jen z celých čtverečků. Druhý proužek je čtyřikrát delší než první a skládá se přesně z $10$ čtverečků. První proužek obsahuje kromě $2$ celých čtverečků ještě $2$ cm pásky.',
             '6.1 Určete počet čtverečků na třetím proužku.',
             '6.2 Určete v cm šířku papírové pásky.',
             '6.3 Určete v cm délku prvního proužku.'],
     'opts': None, 'ln': 3, 'svg': SVG6, 'fn': 'paska.svg',
     'alt': 'Papírová páska rozdělená na shodné čtverečky, tři odstřižené proužky (první, druhý, třetí) a vyznačená šířka pásky a údaj 2 cm u prvního proužku.',
     'cap': 'Schematický nákres papírové pásky se třemi proužky',
     'sol': ['Druhý proužek má $10$ čtverečků a je čtyřikrát delší než první, takže první proužek je dlouhý $2{,}5$ čtverečku.',
             '6.1 Třetí proužek je šestkrát delší než první: $6 \\cdot 2{,}5 = 15$ čtverečků.',
             '6.2 První proužek je $2$ čtverečky a $2$ cm, zároveň $2{,}5$ čtverečku; půl čtverečku je tedy $2$ cm, celý čtvereček (a tím i šířka pásky) $4$ cm.',
             '6.3 Délka prvního proužku $= 2{,}5 \\cdot 4 = 10$ cm.'],
     'ans': '6.1: $15$ čtverečků; 6.2: $4$ cm; 6.3: $10$ cm', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['planimetrie', 'modelovani', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5B 2019 – úloha 7.1 (konstrukce)',
     'zad': ['V rovině leží bod $O$, přímka $p$ a kružnice $k$ se středem $S$. Bod $A$ je jedním ze dvou průsečíků přímky $p$ a kružnice $k$ (viz obrázek).',
             'Bod $A$ je vrchol obdélníku $ABCD$. Strana $AB$ tohoto obdélníku leží na přímce $p$, bod $S$ leží uvnitř některé ze tří zbývajících stran obdélníku $ABCD$. Jeden krajní bod strany, která obsahuje bod $S$, leží na kružnici $k$.',
             'Sestrojte a označte písmeny chybějící vrcholy $B$, $C$, $D$ obdélníku $ABCD$ a obdélník narýsujte. Najděte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG7, 'fn': 'primka-kruznice.svg',
     'alt': 'Bod O, přímka p a kružnice k se středem S; bod A je průsečík přímky p a kružnice k.',
     'cap': 'Výchozí obrázek k úloze 7',
     'sol': ['Strana $AB$ leží na přímce $p$, strany $AD$ a $BC$ jsou kolmé k $p$ a strana $CD$ je s $p$ rovnoběžná. Střed $S$ leží uvnitř jedné z těchto tří stran a jeden její krajní bod leží na kružnici $k$. Sestrojením kolmic k $p$ a využitím polohy bodu $S$ a kružnice $k$ získáme dvě řešení – obdélníky $ABC_1D_1$ a $ABC_2D_2$.'],
     'ans': 'Konstrukce obdélníku $ABCD$; úloha má $2$ řešení (obdélníky $ABC_1D_1$ a $ABC_2D_2$) – viz nákres v klíči.',
     'pts': 3, 'mins': 6, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5B 2019 – úloha 7.2 (konstrukce)',
     'zad': ['V rovině leží bod $O$, přímka $p$ a kružnice $k$ se středem $S$. Bod $A$ je jedním ze dvou průsečíků přímky $p$ a kružnice $k$ (viz obrázek).',
             'Body $A$, $O$ jsou vrcholy trojúhelníku $AOP$. Vrchol $P$ tohoto trojúhelníku leží na přímce $p$. Strana $AO$ má stejnou délku jako jedna z dalších stran trojúhelníku $AOP$.',
             'Sestrojte a označte písmenem chybějící vrchol $P$ trojúhelníku $AOP$ a trojúhelník narýsujte. Najděte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG7, 'fn': 'primka-kruznice.svg',
     'alt': 'Bod O, přímka p a kružnice k se středem S; bod A je průsečík přímky p a kružnice k.',
     'cap': 'Výchozí obrázek k úloze 7',
     'sol': ['Strana $AO$ má stejnou délku jako $AP$, nebo jako $OP$. Je-li $|AP| = |AO|$, leží $P$ na kružnici se středem $A$ a poloměrem $|AO|$ a zároveň na přímce $p$. Je-li $|OP| = |AO|$, leží $P$ na kružnici se středem $O$ a poloměrem $|AO|$ a zároveň na přímce $p$. Celkem dostaneme tři různé polohy $P_1$, $P_2$, $P_3$.'],
     'ans': 'Konstrukce trojúhelníku $AOP$; úloha má $3$ řešení (vrcholy $P_1$, $P_2$, $P_3$ na přímce $p$) – viz nákres v klíči.',
     'pts': 3, 'mins': 6, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5B 2019 – úloha 8',
     'zad': ['Čtvercová síť je tvořena čtverečky o obsahu $1$ cm². Ve čtvercové síti je zakreslen čtverec, který je rozdělen na $3$ trojúhelníky a tmavý obrazec. Trojúhelníky jsou označeny písmeny $A$ až $C$. Vrcholy všech útvarů leží v mřížových bodech.',
             'Rozhodněte o každém z následujících tvrzení 8.1–8.3, zda je pravdivé (A), či nikoli (N).',
             '8.1 Obsah trojúhelníku $A$ je dvojnásobkem obsahu trojúhelníku $B$.',
             '8.2 Obsah celého čtverce je $12$krát větší než obsah trojúhelníku $C$.',
             '8.3 Obsah tmavého obrazce je větší než $15$ cm².'],
     'opts': None, 'ln': 0, 'svg': SVG8, 'fn': 'ctvercova-sit.svg',
     'alt': 'Čtverec 6 krát 6 ve čtvercové síti rozdělený na tři šedé trojúhelníky A, B, C a tmavý obrazec; jeden čtvereček má obsah 1 cm².',
     'cap': 'Schematický nákres (obsahy útvarů odpovídají zadání)',
     'sol': ['Čtverec má stranu $6$ cm, tedy obsah $36$ cm². Trojúhelníky mají obsah $A = 12$ cm², $B = 6$ cm² a $C = 3$ cm²; tmavý obrazec má $36 - 12 - 6 - 3 = 15$ cm².',
             '8.1 $12 = 2 \\cdot 6$ → Ano.',
             '8.2 $36 = 12 \\cdot 3$ → Ano.',
             '8.3 Tmavý obrazec má $15$ cm², což není více než $15$ cm² → Ne.'],
     'ans': '8.1: Ano; 8.2: Ano; 8.3: Ne', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['planimetrie', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5B 2019 – úloha 9',
     'zad': ['Umělec prodal v létě $72$ obrazů. Na podzim prodal o čtvrtinu obrazů méně než v létě. V zimě pak prodal jen osminu toho, co prodal v létě.',
             'Kolikrát více obrazů umělec prodal na podzim než v zimě?'],
     'opts': ['A) dvakrát', 'B) třikrát', 'C) čtyřikrát', 'D) pětkrát', 'E) šestkrát'], 'ln': 0,
     'sol': ['Podzim: $72 - \\frac{72}{4} = 72 - 18 = 54$ obrazů. Zima: $\\frac{72}{8} = 9$ obrazů. Poměr $54 : 9 = 6$.'],
     'ans': 'E) šestkrát', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5B 2019 – úloha 10',
     'zad': ['Do prázdného klobouku jsme vysypali červené a zelené kuličky, zelených bylo o $6$ více než červených. Pak jsme z klobouku vytáhli třetinu všech červených a třetinu všech zelených kuliček. V klobouku tak ubylo $12$ kuliček.',
             'Kolik červených kuliček v klobouku zbylo?'],
     'opts': ['A) $5$', 'B) $10$', 'C) $12$', 'D) $15$', 'E) jiný počet'], 'ln': 0,
     'sol': ['Červené $c$, zelené $c + 6$. Vytáhli třetinu obou: $\\frac{1}{3}(c + c + 6) = 12$, tj. $2c + 6 = 36$, $c = 15$. Zbylo červených $\\frac{2}{3} \\cdot 15 = 10$.'],
     'ans': 'B) $10$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5B 2019 – úloha 11',
     'zad': ['V grafu jsou všichni žáci třídy rozděleni podle počtu svých sourozenců do čtyř skupin. Ve třídě je celkem $30$ žáků a s nimi do třídy nechodí žádný z jejich sourozenců. Pouze jeden žák má $3$ sourozence. Skupina žáků se $2$ sourozenci tvoří šestinu žáků třídy. Žáků, kteří mají nějakého sourozence (jednoho, dva, nebo tři), je dvakrát více než těch, kteří žádného sourozence nemají.',
             'Kolik žáků třídy nemá žádného sourozence?'],
     'opts': ['A) $8$', 'B) $10$', 'C) $11$', 'D) $12$', 'E) $15$'], 'ln': 0,
     'svg': SVG_PIE, 'fn': 'graf-sourozenci.svg',
     'alt': 'Kruhový graf žáků třídy rozdělených podle počtu sourozenců do čtyř skupin: bez sourozenců, s 1, se 2 a se 3 sourozenci.',
     'cap': 'Rozdělení žáků třídy podle počtu sourozenců',
     'sol': ['Bez sourozenců je $b$ žáků, s nějakým sourozencem $2b$; celkem $3b = 30$, tedy $b = 10$.'],
     'ans': 'B) $10$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['statistika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5B 2019 – úloha 12',
     'zad': ['V grafu jsou všichni žáci třídy rozděleni podle počtu svých sourozenců do čtyř skupin. Ve třídě je celkem $30$ žáků a s nimi do třídy nechodí žádný z jejich sourozenců. Pouze jeden žák má $3$ sourozence. Skupina žáků se $2$ sourozenci tvoří šestinu žáků třídy. Žáků, kteří mají nějakého sourozence (jednoho, dva, nebo tři), je dvakrát více než těch, kteří žádného sourozence nemají.',
             'Kolik sourozenců mají dohromady všichni žáci třídy?'],
     'opts': ['A) $27$', 'B) $28$', 'C) $29$', 'D) $30$', 'E) jiný počet'], 'ln': 0,
     'svg': SVG_PIE, 'fn': 'graf-sourozenci.svg',
     'alt': 'Kruhový graf žáků třídy rozdělených podle počtu sourozenců do čtyř skupin: bez sourozenců, s 1, se 2 a se 3 sourozenci.',
     'cap': 'Rozdělení žáků třídy podle počtu sourozenců',
     'sol': ['Bez sourozenců $10$, se $2$ sourozenci $\\frac{30}{6} = 5$, se $3$ sourozenci $1$, s $1$ sourozencem $30 - 10 - 5 - 1 = 14$. Součet sourozenců $14 \\cdot 1 + 5 \\cdot 2 + 1 \\cdot 3 = 27$.'],
     'ans': 'A) $27$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['statistika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},
    {'name': 'CERMAT M5B 2019 – úloha 13',
     'zad': ['Na podložce stavíme různé stavby ze stejných krychliček. Každá krychlička stavby stojí buď na podložce, nebo na jiné krychličce. Stavbu popisujeme dvěma plánky.',
             'Na prvním plánku (shora) jsou v jednotlivých polích uvedeny počty krychliček nad sebou při pohledu shora. Na druhém plánku (zepředu) jsou počty krychliček za sebou při pohledu zepředu. Vlevo je uveden vzor, vpravo jiná stavba, na jejíchž pláncích jsou tři čísla zakryta šedými kartičkami $K$, $L$, $M$.',
             'Přiřaďte ke každé otázce (13.1–13.3) správnou odpověď (A–F).',
             '13.1 Jaké číslo je zakryté kartičkou $K$?',
             '13.2 Jaké číslo je zakryté kartičkou $L$?',
             '13.3 Jaký je součet čísel zakrytých kartičkami $L$ a $M$?'],
     'opts': ['A) $0$', 'B) $1$', 'C) $2$', 'D) $3$', 'E) $4$', 'F) $5$'], 'ln': 0,
     'svg': SVG13, 'fn': 'planky-krychlicky.svg',
     'alt': 'Plánky shora a zepředu: vzorová stavba a jiná stavba se třemi poli zakrytými kartičkami K, L, M.',
     'cap': 'Plánky stavby (shora a zepředu)',
     'sol': ['Plánek shora udává výšky sloupců krychliček, plánek zepředu počty krychliček v jednotlivých výškových hladinách při pohledu zepředu. Porovnáním obou plánků vyjde $K = 2$, $L = 3$ a $M = 2$.',
             '13.1 $K = 2$ → C.',
             '13.2 $L = 3$ → D.',
             '13.3 $L + M = 3 + 2 = 5$ → F.'],
     'ans': '13.1: C ($2$); 13.2: D ($3$); 13.3: F ($5$)', 'pts': 5, 'mins': 6, 'diff': '4',
     'codes': B + ['stereometrie', 'porozumeni', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
    {'name': 'CERMAT M5B 2019 – úloha 14',
     'zad': ['Obkladač vytváří obdélníkovou mozaiku z šedých a bílých čtvercových dlaždic stejné velikosti. V $1$. kroku položil vedle sebe dvě šedé dlaždice. Ve $2$. kroku dlaždice obklopil zleva a shora jednou vrstvou bílých dlaždic. Ve $3$. kroku sestavenou část obklopil zleva a shora jednou vrstvou šedých dlaždic a ve $4$. kroku zleva a shora jednou vrstvou bílých dlaždic.',
             'Každá přidaná vrstva má tvar písmene L. V dalších krocích se stejným způsobem přidává střídavě vrstva šedých a vrstva bílých dlaždic. V dokončené mozaice bude $20$ řad dlaždic.',
             '14.1 Určete, v kolikátém kroku přidá obkladač k mozaice $18$ dlaždic.',
             '14.2 Určete, kolik dlaždic dohromady bude obsahovat dokončená mozaika (s $20$ řadami).',
             '14.3 Určete, kolik šedých dlaždic bude v dokončené mozaice (s $20$ řadami) v $11$. řadě zdola.'],
     'opts': None, 'ln': 3, 'svg': SVG14, 'fn': 'mozaika.svg',
     'alt': 'Čtyři kroky vzniku mozaiky: střídavě přidávané L-vrstvy šedých a bílých dlaždic, poslední přidaná vrstva je vyznačena čárkovaně.',
     'cap': 'První čtyři kroky tvorby mozaiky',
     'sol': ['Po $k$. kroku má mozaika rozměr $k$ řad krát $k + 1$ sloupců; v $k$. kroku ($k \\ge 2$) přibude $2k$ dlaždic.',
             '14.1 $2k = 18 \\Rightarrow k = 9$, tedy v $9$. kroku.',
             '14.2 Dokončená mozaika má $20$ řad, tj. rozměr $20 \\times 21$, celkem $20 \\cdot 21 = 420$ dlaždic.',
             '14.3 V $11$. řadě zdola je $21$ dlaždic. Prvních $12$ (vzniklých v $11$. kroku, který je lichý) je šedých; z dalších sloupců přidaných v lichých krocích $13$, $15$, $17$, $19$ jsou šedé ještě $4$. Celkem $12 + 4 = 16$ šedých dlaždic.'],
     'ans': '14.1: v $9$. kroku; 14.2: $420$ dlaždic; 14.3: $16$ šedých dlaždic', 'pts': 4, 'mins': 7, 'diff': '4',
     'codes': B + ['posloupnosti', 'modelovani', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M5PBD19C0T02'
    gen.YEAR = 2019

    def dollars_ok(s): return s.count('$') % 2 == 0
    errors = []; names = set()
    for p in PROBLEMS:
        if p['name'] in names: errors.append('DUP název: ' + p['name'])
        names.add(p['name'])
        if 'M5B' not in p['name']: errors.append('Název bez M5B: ' + p['name'])
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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M5B-2019')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
