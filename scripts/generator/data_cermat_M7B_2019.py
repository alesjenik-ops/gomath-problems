# -*- coding: utf-8 -*-
# CERMAT - Jednotna prijimaci zkouska 2019, MATEMATIKA 7 (sestilete obory, 7. rocnik),
# varianta B (2. radny termin). Kod testu: M7PBD19C0T02. 16 uloh v testu
# (po rozdeleni izolovanych "Vypoctete" poduloh 2 a 3 -> 18 samostatnych uloh).
# Zdroj odpovedi: klic spravnych reseni (KSR); overeno vypoctem.
# SVG bez apostrofu a zpetnych lomitek (viz gen_cermat validace).

import math

# ---------------- SVG obrazky ----------------

# uloha 7: sklenena nadoba tvaru ctyrbokeho hranolu (podstava 6x6, vyska 10) s krychli na dne
SVG7 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 340 380" font-family="sans-serif">
<polygon points="70,100 230,100 230,320 70,320" fill="none" stroke="#000" stroke-width="2"/>
<polygon points="70,100 120,60 280,60 230,100" fill="none" stroke="#000" stroke-width="1.5"/>
<polygon points="230,100 280,60 280,280 230,320" fill="none" stroke="#000" stroke-width="1.5"/>
<line x1="120" y1="60" x2="120" y2="280" stroke="#000" stroke-width="1" stroke-dasharray="4 4"/>
<line x1="120" y1="280" x2="280" y2="280" stroke="#000" stroke-width="1" stroke-dasharray="4 4"/>
<line x1="120" y1="280" x2="70" y2="320" stroke="#000" stroke-width="1" stroke-dasharray="4 4"/>
<polygon points="170,278 230,278 230,320 170,320" fill="#c6c6c6" stroke="#000"/>
<polygon points="170,278 195,258 255,258 230,278" fill="#dcdcdc" stroke="#000"/>
<polygon points="230,278 255,258 255,300 230,320" fill="#adadad" stroke="#000"/>
<text x="30" y="215" font-size="15">10 cm</text>
<text x="130" y="345" font-size="15">6 cm</text>
<text x="240" y="330" font-size="15">6 cm</text>
</svg>"""

# uloha 8: svisla primka BC (B dole, C nahore), bod M vlevo
SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 300" font-family="sans-serif">
<line x1="300" y1="30" x2="300" y2="270" stroke="#000" stroke-width="2"/>
<line x1="292" y1="70" x2="308" y2="70" stroke="#000" stroke-width="2"/>
<text x="315" y="75" font-size="16" font-style="italic">C</text>
<line x1="292" y1="238" x2="308" y2="238" stroke="#000" stroke-width="2"/>
<text x="315" y="243" font-size="16" font-style="italic">B</text>
<text x="150" y="153" font-size="15" text-anchor="middle">x</text>
<text x="163" y="158" font-size="16" font-style="italic">M</text>
</svg>"""

# uloha 9: kruznice k se stredem S, primka p, bod A (dolni prusecik)
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 340" font-family="sans-serif">
<circle cx="280" cy="155" r="120" fill="none" stroke="#000" stroke-width="2"/>
<text x="182" y="120" font-size="16" font-style="italic">k</text>
<text x="276" y="160" font-size="15" text-anchor="middle">x</text>
<text x="288" y="170" font-size="16" font-style="italic">S</text>
<line x1="40" y1="205" x2="440" y2="295" stroke="#000" stroke-width="2"/>
<text x="425" y="290" font-size="16" font-style="italic">p</text>
<text x="176" y="252" font-size="16" font-style="italic">A</text>
</svg>"""

# uloha 10: ctvercova sit 12x6, obdelnik delen na trojuhelniky A-E a tmavy petiuhelnik
def _grid10():
    u = 26; ox = 34; oy = 22; W, H = 12, 6
    x = lambda c: ox + c * u
    y = lambda r: oy + (H - r) * u
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {x(W)+80} {y(0)+42}" font-family="sans-serif">']
    pts = [(4, 2), (8, 4), (12, 3), (12, 0), (6, 0)]
    s.append('<polygon points="' + ' '.join(f'{x(a)},{y(b)}' for a, b in pts) + '" fill="#cfcfcf" stroke="none"/>')
    for c in range(W + 1):
        s.append(f'<line x1="{x(c)}" y1="{y(0)}" x2="{x(c)}" y2="{y(H)}" stroke="#c9c9c9" stroke-width="1"/>')
    for r in range(H + 1):
        s.append(f'<line x1="{x(0)}" y1="{y(r)}" x2="{x(W)}" y2="{y(r)}" stroke="#c9c9c9" stroke-width="1"/>')
    s.append(f'<rect x="{x(0)}" y="{y(H)}" width="{W*u}" height="{H*u}" fill="none" stroke="#000" stroke-width="2"/>')
    def ln(a, b, c, d):
        s.append(f'<line x1="{x(a)}" y1="{y(b)}" x2="{x(c)}" y2="{y(d)}" stroke="#000" stroke-width="1.6"/>')
    ln(0, 0, 12, 6)
    ln(0, 6, 6, 0)
    ln(0, 6, 12, 3)
    for lab, lx, ly in [('A', 1.3, 2.6), ('B', 4.4, 3.6), ('C', 6.9, 5.0), ('D', 9.6, 4.4), ('E', 3.5, 1.0)]:
        s.append(f'<text x="{x(lx)}" y="{y(ly)}" font-size="15" font-style="italic">{lab}</text>')
    s.append(f'<text x="{x(5.2)}" y="{y(0)+24}" font-size="13">12 cm</text>')
    s.append(f'<text x="{x(12)+8}" y="{y(3)+5}" font-size="13">6 cm</text>')
    s.append('</svg>')
    return "".join(s)
SVG10 = _grid10()

# uloha 11: dve rovnobezne primky, svisla primka kolma (pravy uhel), dve prusecnice, uhly
SVG11 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 285" font-family="sans-serif">
<line x1="60" y1="80" x2="445" y2="80" stroke="#000" stroke-width="2"/>
<line x1="60" y1="210" x2="445" y2="210" stroke="#000" stroke-width="2"/>
<line x1="405" y1="71" x2="415" y2="89" stroke="#000" stroke-width="1.4"/>
<line x1="413" y1="71" x2="423" y2="89" stroke="#000" stroke-width="1.4"/>
<line x1="405" y1="201" x2="415" y2="219" stroke="#000" stroke-width="1.4"/>
<line x1="413" y1="201" x2="423" y2="219" stroke="#000" stroke-width="1.4"/>
<line x1="95" y1="52" x2="95" y2="256" stroke="#000" stroke-width="2"/>
<path d="M95 98 L113 98 L113 80" fill="none" stroke="#000" stroke-width="1.3"/>
<circle cx="104" cy="89" r="1.6" fill="#000"/>
<line x1="95" y1="210" x2="368" y2="80" stroke="#000" stroke-width="2"/>
<line x1="198" y1="272" x2="368" y2="80" stroke="#000" stroke-width="2"/>
<text x="112" y="196" font-size="17" font-style="italic">a</text>
<text x="300" y="120" font-size="15">15°</text>
<text x="252" y="200" font-size="15">38°</text>
</svg>"""

# ulohy 13-14: kruhovy graf zaku podle poctu sourozencu (bez=10, 1=14, 2=5, 3=1)
def _pie():
    cx, cy, r = 205, 165, 92
    def pt(ang):
        a = math.radians(ang)
        return (cx + r * math.sin(a), cy - r * math.cos(a))
    def sector(a0, a1, fill):
        x0, y0 = pt(a0); x1, y1 = pt(a1)
        large = 1 if (a1 - a0) > 180 else 0
        return (f'<path d="M{cx},{cy} L{x0:.1f},{y0:.1f} '
                f'A{r},{r} 0 {large} 1 {x1:.1f},{y1:.1f} Z" '
                f'fill="{fill}" stroke="#000" stroke-width="1.2"/>')
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 330" font-family="sans-serif">']
    s.append(sector(0, 12, '#585858'))
    s.append(sector(12, 132, '#c9c9c9'))
    s.append(sector(132, 300, '#efefef'))
    s.append(sector(300, 360, '#ffffff'))
    s.append('<text x="205" y="22" font-size="13" text-anchor="middle">žáci se 3 sourozenci</text>')
    s.append('<text x="322" y="120" font-size="13">žáci bez sourozenců</text>')
    s.append('<text x="205" y="312" font-size="13" text-anchor="middle">žáci s 1 sourozencem</text>')
    s.append('<text x="8" y="95" font-size="13">žáci se 2 sourozenci</text>')
    s.append('</svg>')
    return "".join(s)
SVG_PIE = _pie()

# uloha 16: mozaika - 4 kroky, vrstvy L stridave sede/bile, posledni vrstva carkovane
def _mosaic():
    u = 17; gap = 24; oy = 26
    def color(i, c):
        sr = 1 if i == 0 else i + 1
        sc = 1 if c <= 1 else c
        return '#b9b9b9' if max(sr, sc) % 2 == 1 else '#fff'
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 170" '
         'font-family="sans-serif"><g stroke="#000">']
    x = 22
    for K in range(1, 5):
        cols = K + 1; rows = K
        for i in range(rows):
            for c in range(cols):
                px = x + (cols - 1 - c) * u
                py = oy + (rows - 1 - i) * u
                s.append(f'<rect x="{px}" y="{py}" width="{u}" height="{u}" fill="{color(i, c)}"/>')
        x += cols * u + gap
    s.append('</g>')
    x = 22
    for K in range(1, 5):
        cols = K + 1; rows = K
        if K >= 2:
            s.append(f'<rect x="{x}" y="{oy}" width="{cols*u}" height="{rows*u}" '
                     f'fill="none" stroke="#000" stroke-dasharray="4 3"/>')
        s.append(f'<text x="{x+cols*u//2}" y="{oy+rows*u+16}" font-size="11" '
                 f'text-anchor="middle">{K}. krok</text>')
        x += cols * u + gap
    s.append(f'<text x="{x-16}" y="{oy+2*u}" font-size="17">…</text>')
    s.append(f'<text x="{x+2}" y="{oy+9}" font-size="10">4. řada</text>')
    s.append(f'<text x="{x+2}" y="{oy+4*u-3}" font-size="10">1. řada</text>')
    s.append('</svg>')
    return "".join(s)
SVG16 = _mosaic()

# ---------------- Ulohy ----------------

B = ['zs2', 'r7']  # 7. rocnik ZS / sestilete obory, prijimacky (varianta B)

PROBLEMS = [
    {'name': 'CERMAT M7B 2019 – úloha 1',
     'zad': ['Vypočtěte v minutách jednu dvacetinu z 12 hodin.'],
     'opts': None, 'ln': 2,
     'sol': ['$12$ hodin $=720$ minut. Jedna dvacetina je $720:20=36$ minut.'],
     'ans': '$36$ minut', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2019 – úloha 2.1',
     'zad': ['Vypočtěte: $0{,}5\\cdot 1{,}2 + 0{,}02$'],
     'opts': None, 'ln': 2,
     'sol': ['$0{,}5\\cdot 1{,}2=0{,}6$, tedy $0{,}6+0{,}02=0{,}62$.'],
     'ans': '$0{,}62$', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2019 – úloha 2.2',
     'zad': ['Vypočtěte: $\\dfrac{10}{0{,}5}-\\dfrac{0{,}5}{10}$'],
     'opts': None, 'ln': 2,
     'sol': ['$\\frac{10}{0{,}5}=20$ a $\\frac{0{,}5}{10}=0{,}05$, tedy $20-0{,}05=19{,}95$.'],
     'ans': '$19{,}95$', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2019 – úloha 3.1',
     'zad': ['Vypočtěte a výsledek zapište zlomkem v základním tvaru: '
             '$2-\\dfrac{6}{5}\\left(\\dfrac{11}{6}-\\dfrac{4}{9}\\right)$'],
     'opts': None, 'ln': 3,
     'sol': ['$\\frac{11}{6}-\\frac{4}{9}=\\frac{33-8}{18}=\\frac{25}{18}$; '
             '$\\frac{6}{5}\\cdot\\frac{25}{18}=\\frac{5}{3}$; $2-\\frac{5}{3}=\\frac{1}{3}$.'],
     'ans': '$\\frac{1}{3}$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2019 – úloha 3.2',
     'zad': ['Vypočtěte a výsledek zapište zlomkem v základním tvaru: '
             '$\\dfrac{\\frac{1}{4}\\cdot\\frac{3}{2}+\\frac{5}{2}}'
             '{\\frac{1}{4}+\\frac{3}{2}\\cdot\\frac{5}{2}}$'],
     'opts': None, 'ln': 3,
     'sol': ['Čitatel: $\\frac{1}{4}\\cdot\\frac{3}{2}+\\frac{5}{2}=\\frac{3}{8}+\\frac{20}{8}=\\frac{23}{8}$. '
             'Jmenovatel: $\\frac{1}{4}+\\frac{3}{2}\\cdot\\frac{5}{2}=\\frac{1}{4}+\\frac{15}{4}=4$. '
             'Podíl: $\\frac{23}{8}:4=\\frac{23}{32}$.'],
     'ans': '$\\frac{23}{32}$', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2019 – úloha 4',
     'zad': ['Aleš má v pravé kapse o polovinu méně korun než v levé kapse. '
             'Kdyby přendal 40 korun z levé kapsy do pravé, měl by v obou kapsách stejně.',
             '4.1 Vypočtěte, o kolik korun má Aleš v levé kapse více než v pravé.',
             '4.2 Vypočtěte, kolik korun má Aleš celkem v obou kapsách.'],
     'opts': None, 'ln': 3,
     'sol': ['Levá kapsa $L$, pravá $\\frac{L}{2}$. Po přendání 40 Kč: $L-40=\\frac{L}{2}+40$, '
             'odtud $\\frac{L}{2}=80$, tedy $L=160$ Kč a pravá $80$ Kč.',
             '4.1 Rozdíl $L-\\frac{L}{2}=160-80=80$ korun.',
             '4.2 Celkem $160+80=240$ korun.'],
     'ans': '4.1: o $80$ korun; 4.2: $240$ korun', 'pts': 3, 'mins': 5, 'diff': '2',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7B 2019 – úloha 5',
     'zad': ['Chovatel chová dospělé kočky a koťata a kupuje jim univerzální granule balené vždy '
             've stejných pytlích. Za jeden den sežerou 3 koťata stejné množství granulí jako '
             '2 dospělé kočky. Dospělá kočka má jeden pytel granulí přesně na 12 dní. '
             '(Každá dospělá kočka sežere denně stejně, totéž platí o koťatech.)',
             '5.1 Vypočtěte, na kolik dní mají jeden pytel granulí 3 koťata.',
             '5.2 Vypočtěte, na kolik dní mají jeden pytel granulí 3 koťata společně s 1 dospělou kočkou.',
             '5.3 Vypočtěte, kolik koťat sežere jeden pytel granulí přesně za 1 den.'],
     'opts': None, 'ln': 4,
     'sol': ['Dospělá kočka sežere denně $\\frac{1}{12}$ pytle. 3 koťata sežerou denně tolik co '
             '2 kočky, tj. $\\frac{2}{12}=\\frac{1}{6}$ pytle.',
             '5.1 $1:\\frac{1}{6}=6$ dní.',
             '5.2 Denní spotřeba 3 koťat a 1 kočky $=\\frac{1}{6}+\\frac{1}{12}=\\frac{1}{4}$ pytle, '
             'tj. $1:\\frac{1}{4}=4$ dny.',
             '5.3 Jedno kotě sežere denně $\\frac{1}{18}$ pytle, takže jeden pytel za den sní '
             '$18$ koťat.'],
     'ans': '5.1: na $6$ dní; 5.2: na $4$ dny; 5.3: $18$ koťat', 'pts': 5, 'mins': 7, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7B 2019 – úloha 6',
     'zad': ['Sestry Soňa a Táňa s kamarádkou Radkou pracovaly v létě na brigádě. Výplatu si '
             'rozdělily podle odpracované doby. Radka si vydělala 3 000 korun. Výplata obou sester '
             'dohromady a výplata Radky byly (v tomto pořadí) v poměru $5:2$. Výplata Soni byla '
             'o jednu osminu menší než výplata její sestry Táni.',
             '6.1 Vypočtěte, kolik korun si vydělala všechna tři děvčata dohromady.',
             '6.2 Vyjádřete v základním tvaru poměr výplat Soni a Táni (v tomto pořadí).',
             '6.3 Vypočtěte, kolik korun si vydělala Soňa.'],
     'opts': None, 'ln': 4,
     'sol': ['6.1 Sestry dohromady : Radka $=5:2$, Radka $=3000$ Kč, tedy sestry '
             '$\\frac{5}{2}\\cdot 3000=7500$ Kč. Celkem $7500+3000=10\\,500$ korun.',
             '6.2 Soňa $=$ Táňa $-\\frac{1}{8}$ Táni $=\\frac{7}{8}$ Táni, poměr Soňa : Táňa $=7:8$.',
             '6.3 Soňa a Táňa mají dohromady $7500$ Kč v poměru $7:8$ (15 dílů), '
             'Soňa $=\\frac{7}{15}\\cdot 7500=3500$ korun.'],
     'ans': '6.1: $10\\,500$ korun; 6.2: $7:8$; 6.3: $3\\,500$ korun', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7B 2019 – úloha 7',
     'zad': ['Na dně skleněné nádoby tvaru čtyřbokého hranolu je položena ocelová krychle. '
             'Krychle zakrývá čtvrtinu čtvercového dna nádoby. Nádoba s krychlí je po okraj '
             'naplněna vodou. Rozměry nádoby jsou v obrázku (podstava $6$ cm $\\times$ $6$ cm, '
             'výška $10$ cm). Tloušťku stěn nádoby zanedbáváme.',
             'Vypočtěte v cm³ objem vody v nádobě s krychlí.'],
     'opts': None, 'ln': 4, 'svg': SVG7, 'fn': 'nadoba-krychle.svg',
     'alt': 'Skleněná nádoba tvaru hranolu s podstavou 6 cm krát 6 cm a výškou 10 cm, na dně leží krychle.',
     'cap': 'Nádoba s krychlí (schematicky)',
     'sol': ['Objem nádoby $=6\\cdot 6\\cdot 10=360$ cm³. Krychle zakrývá čtvrtinu dna, tj. '
             '$\\frac{1}{4}\\cdot 36=9$ cm², hrana krychle je $3$ cm a její objem $3^3=27$ cm³. '
             'Objem vody $=360-27=333$ cm³.'],
     'ans': '$333$ cm³', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['stereometrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7B 2019 – úloha 8 (konstrukce)',
     'zad': ['V rovině leží přímka $BC$ a mimo ni bod $M$ (viz obrázek).',
             'Úsečka $BC$ je rameno rovnoramenného trojúhelníku $ABC$. Bod $M$ leží na ose '
             'souměrnosti tohoto trojúhelníku.',
             '8.1 Sestrojte a označte písmenem osu souměrnosti $o$ trojúhelníku $ABC$.',
             '8.2 Sestrojte a označte písmenem chybějící vrchol $A$ trojúhelníku $ABC$ a trojúhelník '
             'narýsujte. Najděte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG8, 'fn': 'primka-bc-m.svg',
     'alt': 'Svislá přímka s vyznačenými body B (dole) a C (nahoře) a bod M vlevo od přímky.',
     'cap': 'Výchozí obrázek k úloze 8',
     'sol': ['Protože $BC$ je rameno, je hlavním vrcholem (vrcholem u základny naproti) buď $B$, '
             'nebo $C$; osa souměrnosti prochází hlavním vrcholem a bodem $M$. Vrchol $A$ je obrazem '
             'druhého krajního bodu úsečky $BC$ v osové souměrnosti podle této osy.',
             'Řešení 1: osa $o_1$ je přímka $BM$, vrchol $A_1$ je obrazem bodu $C$ podle $o_1$.',
             'Řešení 2: osa $o_2$ je přímka $CM$, vrchol $A_2$ je obrazem bodu $B$ podle $o_2$.'],
     'ans': 'Dvě řešení: osa $o_1=BM$ a $A_1$ jako obraz $C$; osa $o_2=CM$ a $A_2$ jako obraz $B$ '
            '(vrcholy $A_1$, $A_2$ – viz obrázek v klíči).',
     'pts': 3, 'mins': 7, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2019 – úloha 9 (konstrukce)',
     'zad': ['V rovině leží přímka $p$ a kružnice $k$ se středem $S$. Bod $A$ je jedním ze dvou '
             'průsečíků přímky $p$ a kružnice $k$ (viz obrázek).',
             'Bod $A$ je vrchol obdélníku $ABCD$. Strana $AB$ leží na přímce $p$, bod $S$ leží '
             'uvnitř některé ze tří zbývajících stran obdélníku $ABCD$. Jeden krajní bod strany, '
             'která obsahuje bod $S$, leží na kružnici $k$.',
             'Sestrojte a označte písmeny chybějící vrcholy $B$, $C$, $D$ obdélníku $ABCD$ '
             'a obdélník narýsujte. Najděte všechna řešení.'],
     'opts': None, 'ln': 0, 'svg': SVG9, 'fn': 'primka-kruznice-a.svg',
     'alt': 'Kružnice k se středem S a přímka p, která kružnici protíná; bod A je dolní průsečík.',
     'cap': 'Výchozí obrázek k úloze 9',
     'sol': ['Strana $AB$ leží na přímce $p$, strany $AD$ a $BC$ jsou k $p$ kolmé. Bod $S$ leží '
             'uvnitř jedné ze stran $BC$, $CD$, $DA$ a jeden krajní bod této strany leží na '
             'kružnici $k$; z těchto podmínek se dopočtou vrcholy $B$, $C$, $D$. Úloha má '
             'dvě řešení.'],
     'ans': 'Dvě řešení – obdélníky $AB_1C_1D_1$ a $AB_2C_2D_2$ (strana $AB$ na přímce $p$, '
            'vrcholy $B$, $C$, $D$ – viz obrázek v klíči).',
     'pts': 2, 'mins': 6, 'diff': '3',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2019 – úloha 10',
     'zad': ['Čtvercová síť je tvořena čtverečky s délkou strany 1 cm. Ve čtvercové síti je '
             'zakreslen obdélník $12$ cm $\\times$ $6$ cm rozdělený na 5 trojúhelníků $A$ až $E$ '
             'a tmavý obrazec. Vrcholy všech útvarů leží v mřížových bodech.',
             'Rozhodněte o každém z následujících tvrzení (10.1–10.3), zda je pravdivé (A), '
             'či nikoli (N).',
             '10.1 Obsahy trojúhelníků $A$, $C$ jsou stejné.',
             '10.2 Obsah celého obdélníku je 12krát větší než obsah trojúhelníku $D$.',
             '10.3 Obsah tmavého obrazce je větší než $24$ cm².'],
     'opts': None, 'ln': 0, 'svg': SVG10, 'fn': 'sit-trojuhelniky.svg',
     'alt': 'Obdélník 12 krát 6 na čtvercové síti rozdělený třemi úsečkami na trojúhelníky A až E a šedý pětiúhelník.',
     'cap': 'Obdélník rozdělený na útvary (obsahy v cm²)',
     'sol': ['Obsahy (v cm²): $A=12$, $B=12$, $C=12$, $D=6$, $E=6$, tmavý obrazec $=72-48=24$.',
             '10.1 $A=C=12$ cm² → Ano.',
             '10.2 Obdélník $=72$ cm² $=12\\cdot 6=12\\cdot D$ → Ano.',
             '10.3 Tmavý obrazec má obsah přesně $24$ cm², není větší než $24$ cm² → Ne.'],
     'ans': '10.1: Ano; 10.2: Ano; 10.3: Ne', 'pts': 4, 'mins': 5, 'diff': '3',
     'codes': B + ['planimetrie', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2019 – úloha 11',
     'zad': ['Na obrázku jsou dvě rovnoběžné přímky (označené shodnými značkami), svislá přímka '
             'k nim kolmá a dvě různoběžky. Jsou vyznačeny úhly $15^\\circ$, $38^\\circ$ '
             'a hledaný úhel $\\alpha$.',
             'Jaká je velikost úhlu $\\alpha$? Velikosti úhlů neměřte, ale vypočtěte.'],
     'opts': ['A) menší než $53^\\circ$', 'B) $53^\\circ$', 'C) $63^\\circ$', 'D) $67^\\circ$',
              'E) větší než $67^\\circ$'],
     'ln': 0, 'svg': SVG11, 'fn': 'uhly-rovnobezky.svg',
     'alt': 'Dvě rovnoběžné vodorovné přímky, svislá kolmá přímka s pravým úhlem a dvě různoběžky svírající úhly 15° a 38°; hledaný úhel alfa.',
     'cap': 'Výchozí obrázek k úloze 11',
     'sol': ['Různoběžka svírá s rovnoběžkami úhel $38^\\circ$. Mezi oběma různoběžkami je '
             '$15^\\circ$, takže druhá různoběžka svírá s rovnoběžkami $38^\\circ-15^\\circ=23^\\circ$. '
             'Svislá přímka je k rovnoběžkám kolmá, proto $\\alpha=90^\\circ-23^\\circ=67^\\circ$.'],
     'ans': 'D) $67^\\circ$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2019 – úloha 12',
     'zad': ['Do prázdného klobouku jsme vysypali červené a zelené kuličky, zelených bylo o 6 více '
             'než červených. Pak jsme z klobouku vytáhli třetinu všech červených a třetinu všech '
             'zelených kuliček. V klobouku tak ubylo 12 kuliček.',
             'Kolik červených kuliček v klobouku zbylo?'],
     'opts': ['A) 5', 'B) 10', 'C) 12', 'D) 15', 'E) jiný počet'],
     'ln': 0,
     'sol': ['Vytažená třetina všech kuliček je 12, takže všech kuliček bylo $36$. '
             'Červené $c$, zelené $c+6$: $c+(c+6)=36\\Rightarrow c=15$. V klobouku zbyly '
             'dvě třetiny červených, tj. $\\frac{2}{3}\\cdot 15=10$.'],
     'ans': 'B) 10', 'pts': 2, 'mins': 3, 'diff': '3',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2019 – úloha 13',
     'zad': ['V grafu jsou všichni žáci třídy rozděleni podle počtu svých sourozenců do čtyř '
             'skupin. Ve třídě je celkem 30 žáků a s nimi do třídy nechodí žádný z jejich '
             'sourozenců. Pouze jeden žák má 3 sourozence. Skupina žáků se 2 sourozenci tvoří '
             'šestinu žáků třídy. Žáků, kteří mají nějakého sourozence (jednoho, dva, nebo tři), '
             'je dvakrát více než těch, kteří žádného sourozence nemají.',
             'Kolik žáků třídy nemá žádného sourozence?'],
     'opts': ['A) 8', 'B) 10', 'C) 11', 'D) 12', 'E) 15'],
     'ln': 0, 'svg': SVG_PIE, 'fn': 'graf-sourozenci.svg',
     'alt': 'Kruhový graf rozdělení 30 žáků podle počtu sourozenců na čtyři výseče (bez, 1, 2, 3 sourozenci).',
     'cap': 'Rozdělení žáků podle počtu sourozenců',
     'sol': ['Nechť žáků bez sourozence je $x$; žáků s aspoň jedním sourozencem je $2x$, '
             'dohromady $3x=30$, tedy $x=10$.'],
     'ans': 'B) 10', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['statistika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7B 2019 – úloha 14',
     'zad': ['V grafu jsou všichni žáci třídy rozděleni podle počtu svých sourozenců do čtyř '
             'skupin. Ve třídě je celkem 30 žáků a s nimi do třídy nechodí žádný z jejich '
             'sourozenců. Pouze jeden žák má 3 sourozence. Skupina žáků se 2 sourozenci tvoří '
             'šestinu žáků třídy. Žáků, kteří mají nějakého sourozence, je dvakrát více než těch, '
             'kteří žádného sourozence nemají.',
             'Kolik sourozenců mají dohromady všichni žáci třídy?'],
     'opts': ['A) 27', 'B) 28', 'C) 29', 'D) 30', 'E) jiný počet'],
     'ln': 0, 'svg': SVG_PIE, 'fn': 'graf-sourozenci.svg',
     'alt': 'Kruhový graf rozdělení 30 žáků podle počtu sourozenců na čtyři výseče (bez, 1, 2, 3 sourozenci).',
     'cap': 'Rozdělení žáků podle počtu sourozenců',
     'sol': ['Bez sourozence $10$, se 2 sourozenci $\\frac{30}{6}=5$, se 3 sourozenci $1$, '
             'tedy s 1 sourozencem $30-10-5-1=14$. Sourozenců dohromady '
             '$14\\cdot 1+5\\cdot 2+1\\cdot 3=27$.'],
     'ans': 'A) 27', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['statistika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7B 2019 – úloha 15',
     'zad': ['Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).',
             '15.1 Z přednášky na dvě a půl hodiny zbývá ještě 60 minut do konce. Kolik procent '
             'přednášky již uběhlo?',
             '15.2 Z času na test uběhlo teprve 27 minut a zbývá ještě 63 minut. Kolik procent '
             'času na test ještě zbývá?',
             '15.3 Všichni tři členové družstva se bez prodlev vystřídali při plnění soutěžního '
             'úkolu. První člen vyčerpal 30 % celkového soutěžního času, druhý potřeboval ještě '
             'o 10 minut více než první a na třetího zbylo už jen 10 minut. Kolik procent '
             'celkového soutěžního času potřeboval druhý člen?'],
     'opts': ['A) $50\\,\\%$', 'B) $55\\,\\%$', 'C) $60\\,\\%$', 'D) $65\\,\\%$', 'E) $70\\,\\%$',
              'F) jiný počet procent'],
     'ln': 0,
     'sol': ['15.1 Přednáška trvá $150$ min, uběhlo $150-60=90$ min, tj. '
             '$\\frac{90}{150}=60\\,\\%$ → C.',
             '15.2 Celkem $27+63=90$ min, zbývá $\\frac{63}{90}=70\\,\\%$ → E.',
             '15.3 Celkový čas $T$: $0{,}3T+(0{,}3T+10)+10=T\\Rightarrow 0{,}4T=20\\Rightarrow T=50$ min. '
             'Druhý $0{,}3\\cdot 50+10=25$ min, tj. $\\frac{25}{50}=50\\,\\%$ → A.'],
     'ans': '15.1: C ($60\\,\\%$); 15.2: E ($70\\,\\%$); 15.3: A ($50\\,\\%$)',
     'pts': 6, 'mins': 9, 'diff': '3',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7B 2019 – úloha 16',
     'zad': ['Obkladač vytváří obdélníkovou mozaiku z šedých a bílých čtvercových dlaždic stejné '
             'velikosti. V 1. kroku položil vedle sebe dvě šedé dlaždice. Ve 2. kroku dlaždice '
             'obklopil zleva a shora jednou vrstvou bílých dlaždic, ve 3. kroku zleva a shora '
             'jednou vrstvou šedých dlaždic a ve 4. kroku zleva a shora jednou vrstvou bílých '
             'dlaždic. Každá přidaná vrstva má tvar L. V dalších krocích se střídavě přidává '
             'vrstva šedých a vrstva bílých dlaždic. V dokončené mozaice bude 20 řad dlaždic.',
             '16.1 Určete, v kolikátém kroku přidá obkladač k mozaice 18 dlaždic.',
             '16.2 Určete, kolik dlaždic dohromady bude obsahovat dokončená mozaika (s 20 řadami).',
             '16.3 Určete, kolik šedých dlaždic bude v dokončené mozaice (s 20 řadami) '
             'v 11. řadě zdola.'],
     'opts': None, 'ln': 4, 'svg': SVG16, 'fn': 'mozaika.svg',
     'alt': 'Čtyři kroky stavby mozaiky: v každém kroku se ke tvaru přidá L-vrstva dlaždic, poslední vrstva je čárkovaná.',
     'cap': 'Prvních pět kroků stavby mozaiky (1.–4. krok)',
     'sol': ['Po $k$-tém kroku má mozaika $k$ řad a $k+1$ sloupců, celkem $k(k+1)$ dlaždic. '
             'V $k$-tém kroku (pro $k\\ge 2$) přibude $k(k+1)-(k-1)k=2k$ dlaždic.',
             '16.1 $2k=18\\Rightarrow k=9$, tedy v 9. kroku.',
             '16.2 Dokončená mozaika má 20 řad, tj. $k=20$: $20\\cdot 21=420$ dlaždic.',
             '16.3 11. řada zdola vznikla v 11. kroku a měla nejdříve 12 šedých dlaždic '
             '(11. krok je lichý). V krocích 12–20 přibude do této řady vždy 1 dlaždice zleva; '
             'šedé přidají liché kroky 13, 15, 17, 19 (4 dlaždice). Šedých je celkem $12+4=16$.'],
     'ans': '16.1: v 9. kroku; 16.2: $420$ dlaždic; 16.3: $16$ šedých dlaždic',
     'pts': 4, 'mins': 7, 'diff': '3',
     'codes': B + ['posloupnosti', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M7PBD19C0T02'
    gen.YEAR = 2019

    def dollars_ok(s): return s.count('$') % 2 == 0
    errors = []; names = set()
    for p in PROBLEMS:
        if p['name'] in names: errors.append('DUP název: ' + p['name'])
        names.add(p['name'])
        if 'M7B' not in p['name']: errors.append('Chybí M7B v názvu: ' + p['name'])
        for t in [p['name'], p['ans']] + list(p['zad']) + list(p['sol']) + (p.get('opts') or []):
            if not dollars_ok(t): errors.append('Nepárový $: ' + t[:70])
        if p.get('svg') and ("'" in p['svg'] or '\\' in p['svg']):
            errors.append('SVG zakázaný znak: ' + p['name'])
        if p.get('svg') and not p.get('alt'): errors.append('Obrázek bez alt: ' + p['name'])
        for lbl, obj in (('content', gen.py_content_json(p)), ('solution', gen.py_solution_json(p)),
                         ('answer', gen.py_answer_json(p))):
            try: json.loads(json.dumps(obj, ensure_ascii=False))
            except Exception as e: errors.append(f'JSON {lbl} {p["name"]}: {e}')
    if errors:
        print('CHYBY:'); [print('  -', e) for e in errors]; sys.exit(1)
    print('Validace OK:', len(PROBLEMS), 'úloh')
    outdir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'out')
    os.makedirs(outdir, exist_ok=True)
    tot = 0
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M7B-2019')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
