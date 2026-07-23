# -*- coding: utf-8 -*-
# CERMAT - Jednotna prijimaci zkouska 2023, MATEMATIKA 7 (sestilete obory, 7. rocnik), test B.
# Kod testu: M7PBD23C0T02. 16 uloh (po rozdeleni nezavislych poduloh 18 uloh), 50 bodu.
# Zdroj odpovedi: klic spravnych reseni (KLIC_7B_2023.pdf).

# ---- SVG obrazky (bez apostrofu a zpetnych lomitek) ----

# uloha 4: dva diagramy s ovaly a operacemi ve smeru sipek
SVG4 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 260" font-family="sans-serif">
<text x="30" y="30" font-size="14" font-weight="bold">4.1</text>
<ellipse cx="90" cy="80" rx="34" ry="24" fill="none" stroke="#000"/><text x="90" y="87" font-size="18" text-anchor="middle">?</text>
<line x1="124" y1="80" x2="215" y2="80" stroke="#000"/><polygon points="215,80 206,76 206,84" fill="#000"/>
<text x="165" y="66" font-size="13" text-anchor="middle">: 4/3</text>
<ellipse cx="255" cy="80" rx="34" ry="24" fill="none" stroke="#000"/>
<line x1="255" y1="104" x2="255" y2="168" stroke="#000"/><polygon points="255,168 251,159 259,159" fill="#000"/>
<text x="275" y="140" font-size="13">. 0,2</text>
<ellipse cx="255" cy="200" rx="34" ry="24" fill="none" stroke="#000"/><text x="255" y="206" font-size="16" text-anchor="middle">18</text>
<text x="360" y="30" font-size="14" font-weight="bold">4.2</text>
<ellipse cx="400" cy="90" rx="32" ry="23" fill="none" stroke="#000"/>
<line x1="432" y1="90" x2="498" y2="90" stroke="#000"/><polygon points="498,90 489,86 489,94" fill="#000"/>
<text x="465" y="76" font-size="13" text-anchor="middle">. 3/4</text>
<ellipse cx="528" cy="90" rx="28" ry="22" fill="none" stroke="#000"/>
<line x1="524" y1="112" x2="490" y2="176" stroke="#000"/><polygon points="490,176 494,166 499,172" fill="#000"/>
<text x="524" y="150" font-size="13">. 8</text>
<ellipse cx="470" cy="200" rx="30" ry="22" fill="none" stroke="#000"/>
<line x1="443" y1="188" x2="392" y2="114" stroke="#000"/><polygon points="392,114 401,118 395,123" fill="#000"/>
<text x="400" y="165" font-size="13">: ?</text>
</svg>"""

# uloha 7: podstava (kosodelnik) a kolmy ctyrboky hranol - schematicky
SVG7 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 280" font-family="sans-serif">
<text x="110" y="30" font-size="13" text-anchor="middle">Podstava (kosodelnik)</text>
<polygon points="50,160 150,160 120,110 20,110" fill="none" stroke="#000" stroke-width="1.5"/>
<line x1="50" y1="160" x2="50" y2="110" stroke="#000" stroke-width="1" stroke-dasharray="4 3"/>
<rect x="50" y="152" width="8" height="8" fill="none" stroke="#000"/>
<text x="30" y="138" font-size="12">6 cm</text>
<text x="140" y="140" font-size="12">7 cm</text>
<text x="365" y="30" font-size="13" text-anchor="middle">Hranol</text>
<polygon points="330,245 430,245 400,195 300,195" fill="none" stroke="#000" stroke-width="1.5"/>
<polygon points="330,95 430,95 400,45 300,45" fill="none" stroke="#000" stroke-width="1.5"/>
<line x1="330" y1="245" x2="330" y2="95" stroke="#000" stroke-width="1.5"/>
<line x1="430" y1="245" x2="430" y2="95" stroke="#000" stroke-width="1.5"/>
<line x1="400" y1="195" x2="400" y2="45" stroke="#000" stroke-width="1.5"/>
<line x1="300" y1="195" x2="300" y2="45" stroke="#000" stroke-width="1" stroke-dasharray="4 3"/>
<text x="437" y="175" font-size="12">20 cm</text>
<text x="372" y="240" font-size="12">7 cm</text>
</svg>"""

# uloha 8: bod F a primka g (vychozi obrazek ke konstrukci)
SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 280" font-family="sans-serif">
<line x1="60" y1="90" x2="420" y2="150" stroke="#000" stroke-width="2"/>
<text x="428" y="152" font-size="16" font-style="italic">g</text>
<text x="178" y="236" font-size="15" font-style="italic">F</text>
<text x="193" y="229" font-size="14">x</text>
</svg>"""

# uloha 9: body S, Q a primka p (vychozi obrazek ke konstrukci)
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif">
<line x1="60" y1="150" x2="420" y2="90" stroke="#000" stroke-width="2"/>
<text x="428" y="88" font-size="16" font-style="italic">p</text>
<text x="150" y="206" font-size="15" font-style="italic">S</text>
<text x="165" y="200" font-size="14">x</text>
<text x="238" y="238" font-size="15" font-style="italic">Q</text>
<text x="253" y="231" font-size="14">x</text>
</svg>"""

# uloha 11: pravouhly trojuhelnik ABC rozdeleny useckami CD a DE - schematicky
SVG11 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 280" font-family="sans-serif">
<polygon points="80,240 430,240 80,70" fill="none" stroke="#000" stroke-width="1.5"/>
<line x1="80" y1="70" x2="200" y2="240" stroke="#000" stroke-width="1.5"/>
<line x1="200" y1="240" x2="205" y2="130" stroke="#000" stroke-width="1.5"/>
<rect x="80" y="228" width="12" height="12" fill="none" stroke="#000"/>
<rect x="188" y="228" width="12" height="12" fill="none" stroke="#000"/>
<text x="70" y="64" font-size="14" font-style="italic">C</text>
<text x="212" y="128" font-size="14" font-style="italic">E</text>
<text x="66" y="257" font-size="14" font-style="italic">A</text>
<text x="196" y="259" font-size="14" font-style="italic">D</text>
<text x="434" y="248" font-size="14" font-style="italic">B</text>
<text x="118" y="122" font-size="13">omega</text>
<text x="168" y="182" font-size="13">omega</text>
<text x="150" y="233" font-size="13">fi</text>
<text x="388" y="234" font-size="12">20 st.</text>
</svg>"""

# uloha 12: stavba z valcu - prostorove pohledy nelze verne prenest
SVG12 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 120" font-family="sans-serif">
<text x="260" y="52" font-size="13" text-anchor="middle">Stavba ze stejne velkych valcu tri barev - pohled zepredu a shora (viz testovy sesit).</text>
<text x="260" y="80" font-size="11" text-anchor="middle" fill="#666">Prostorove pohledy nelze verne prenest do SVG; posuzuje se podle originalu.</text>
</svg>"""

# uloha 16: rada obdelniku z bilych ctverecku a sedych trojuhelniku - schematicky
SVG16 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 190" font-family="sans-serif">
<rect x="30" y="60" width="44" height="22" fill="none" stroke="#000"/>
<line x1="30" y1="60" x2="52" y2="82" stroke="#999"/><line x1="52" y1="60" x2="74" y2="82" stroke="#999"/>
<text x="52" y="102" font-size="12" text-anchor="middle">1. obdelnik</text>
<rect x="150" y="46" width="90" height="45" fill="none" stroke="#000"/>
<line x1="150" y1="46" x2="195" y2="91" stroke="#999"/><line x1="195" y1="46" x2="240" y2="91" stroke="#999"/>
<line x1="172" y1="46" x2="150" y2="68" stroke="#999"/><line x1="240" y1="68" x2="217" y2="91" stroke="#999"/>
<text x="195" y="110" font-size="12" text-anchor="middle">2. obdelnik</text>
<text x="195" y="126" font-size="11" text-anchor="middle">(6 bilych a 4 sede ctverecky)</text>
<rect x="320" y="34" width="140" height="70" fill="none" stroke="#000"/>
<line x1="320" y1="34" x2="390" y2="104" stroke="#999"/><line x1="390" y1="34" x2="460" y2="104" stroke="#999"/>
<text x="390" y="122" font-size="12" text-anchor="middle">3. obdelnik</text>
<text x="486" y="72" font-size="18">...</text>
</svg>"""


# uloha 10: ctvercova sit s bilymi obrazci A, C, E a tmavymi B, D, F
def _grid10():
    cell = 16
    ox = 25
    oy = 30
    W = 30
    H = 5
    w_px = ox * 2 + W * cell
    h_px = oy + 34 + H * cell
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {w_px} {h_px}" font-family="sans-serif">']
    for i in range(W + 1):
        x = ox + i * cell
        s.append(f'<line x1="{x}" y1="{oy}" x2="{x}" y2="{oy + H * cell}" stroke="#ccc" stroke-width="1"/>')
    for j in range(H + 1):
        y = oy + j * cell
        s.append(f'<line x1="{ox}" y1="{y}" x2="{ox + W * cell}" y2="{y}" stroke="#ccc" stroke-width="1"/>')

    def pt(cx, cy):
        return f'{ox + cx * cell},{oy + cy * cell}'

    # A: bily trojuhelnik, odvesny 4 a 2 -> obsah 4
    s.append(f'<polygon points="{pt(1,1)} {pt(5,1)} {pt(1,3)}" fill="#fff" stroke="#000" stroke-width="1.5"/>')
    s.append(f'<text x="{ox + 2 * cell}" y="{oy + 1.85 * cell}" font-size="11">A</text>')
    # B: tmavy trojuhelnik, odvesny 2 a 1 -> obsah 1
    s.append(f'<polygon points="{pt(7,2)} {pt(9,2)} {pt(7,3)}" fill="#4a4a4a" stroke="#000" stroke-width="1.5"/>')
    s.append(f'<text x="{ox + 9.3 * cell}" y="{oy + 2.7 * cell}" font-size="11">B</text>')
    # C: bily ctverec 3x3 -> obsah 9
    s.append(f'<rect x="{ox + 11 * cell}" y="{oy + 1 * cell}" width="{3 * cell}" height="{3 * cell}" fill="#fff" stroke="#000" stroke-width="1.5"/>')
    s.append(f'<text x="{ox + 12.3 * cell}" y="{oy + 2.9 * cell}" font-size="11">C</text>')
    # D: tmavy trojuhelnik, odvesny 3 a 2 -> obsah 3
    s.append(f'<polygon points="{pt(16,1)} {pt(19,1)} {pt(16,3)}" fill="#4a4a4a" stroke="#000" stroke-width="1.5"/>')
    s.append(f'<text x="{ox + 16.3 * cell}" y="{oy + 1.9 * cell}" font-size="11" fill="#fff">D</text>')
    # E: bily trojuhelnik, odvesny 4 a 2 -> obsah 4
    s.append(f'<polygon points="{pt(21,3)} {pt(25,3)} {pt(21,1)}" fill="#fff" stroke="#000" stroke-width="1.5"/>')
    s.append(f'<text x="{ox + 21.5 * cell}" y="{oy + 2.7 * cell}" font-size="11">E</text>')
    # F: tmavy trojuhelnik, odvesny 3 a 2 -> obsah 3
    s.append(f'<polygon points="{pt(26,3)} {pt(29,3)} {pt(26,1)}" fill="#4a4a4a" stroke="#000" stroke-width="1.5"/>')
    s.append(f'<text x="{ox + 26.3 * cell}" y="{oy + 2.7 * cell}" font-size="11" fill="#fff">F</text>')
    s.append('</svg>')
    return "".join(s)


SVG10 = _grid10()

B = ['zs2', 'r7']  # 7. rocnik ZS (sestilete obory)

PROBLEMS = [
    {'name': 'CERMAT M7B 2023 - uloha 1',
     'zad': ['Hodiny, ktere jdou presne, ukazuji cas 21:42. Vypoctete, jaky cas budou ukazovat za 212 minut.'],
     'opts': None, 'ln': 1,
     'sol': ['Plati 212 minut = 3 hodiny a 32 minut. K casu 21:42 pricteme 3 hodiny a 32 minut a dostaneme 25:14, tedy 1:14.'],
     'ans': '1:14', 'pts': 1, 'mins': 2, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7B 2023 - uloha 2.1',
     'zad': ['Vypoctete a vysledek zapiste zlomkem v zakladnim tvaru: $\\frac{10}{13}\\cdot\\left(\\frac{7}{10}-\\frac{3}{8}\\right):2=$'],
     'opts': None, 'ln': 3,
     'sol': ['$\\frac{7}{10}-\\frac{3}{8}=\\frac{28-15}{40}=\\frac{13}{40}$; $\\frac{10}{13}\\cdot\\frac{13}{40}=\\frac{1}{4}$; $\\frac{1}{4}:2=\\frac{1}{8}$.'],
     'ans': '$\\frac{1}{8}$', 'pts': 2, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2023 - uloha 2.2',
     'zad': ['Vypoctete a vysledek zapiste zlomkem v zakladnim tvaru: $\\dfrac{\\frac{27}{28}\\cdot\\frac{2}{9}}{1-\\frac{5}{3}+\\frac{2}{7}}=$'],
     'opts': None, 'ln': 3,
     'sol': ['Citatel: $\\frac{27}{28}\\cdot\\frac{2}{9}=\\frac{3}{14}$. Jmenovatel: $1-\\frac{5}{3}+\\frac{2}{7}=\\frac{21-35+6}{21}=-\\frac{8}{21}$. Podil: $\\frac{3}{14}:\\left(-\\frac{8}{21}\\right)=\\frac{3}{14}\\cdot\\left(-\\frac{21}{8}\\right)=-\\frac{9}{16}$.'],
     'ans': '$-\\frac{9}{16}$', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2023 - uloha 3',
     'zad': ['Prectene-li cislo 2 073 zprava, ziskame cislo 3 702. Kladne cele cislo, ktere cteme zleva i zprava stejne, se nazyva palindromicke cislo, napriklad 73 937.',
             '3.1 Urcete nejmensi peticiferne palindromicke cislo, ve kterem se vyskytuji tri ruzne cislice.',
             '3.2 Urcete nejmensi kladne cislo, jehoz prictenim k palindromickemu cislu 73 937 ziskame opet palindromicke cislo.'],
     'opts': None, 'ln': 2,
     'sol': ['3.1 Peticiferny palindrom ma tvar $\\overline{abcba}$. Nejmensi ma $a=1$ a $b=0$; aby byly tri ruzne cislice, je nejmensi vyhovujici $c=2$. Hledane cislo je $10\\,201$.',
             '3.2 Nejblizsi vyssi palindromicke cislo za $73\\,937$ je $74\\,047$; hledane cislo je $74\\,047-73\\,937=110$.'],
     'ans': '3.1: $10\\,201$; 3.2: $110$', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'argumentace', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2023 - uloha 4',
     'zad': ['Cisla v ovalech musi byt kladna a vsechny vypocty provedene ve smeru sipek musi byt spravne. Vzor: z cisla $3$ vznikne po operaci $\\cdot 2$ cislo $6$ a po operaci $+3$ cislo $9$.',
             '4.1 Urcete cislo, ktere bude v diagramu misto otazniku (viz obrazek vlevo).',
             '4.2 Urcete cislo, ktere bude v diagramu misto otazniku (viz obrazek vpravo).'],
     'opts': None, 'ln': 2, 'svg': SVG4, 'fn': 'diagramy.svg',
     'alt': 'Dva diagramy s ovaly spojenymi sipkami s operacemi; v kazdem je jeden otaznik.',
     'cap': 'Vychozi diagramy k uloze 4',
     'sol': ['4.1 Z posledniho ovalu: hodnota pred operaci $\\cdot 0{,}2$ je $18:0{,}2=90$. Pred operaci $:\\frac{4}{3}$ je $90\\cdot\\frac{4}{3}=120$. Otaznik je $120$.',
             '4.2 Oznacme levy oval $a$. Pravy oval je $a\\cdot\\frac{3}{4}$, dolni oval je $a\\cdot\\frac{3}{4}\\cdot 8=6a$. Posledni operace $:\\,?$ vrati zpet $a$, tedy $6a:?=a$ a $?=6$.'],
     'ans': '4.1: $120$; 4.2: $6$', 'pts': 3, 'mins': 5, 'diff': '3',
     'codes': B + ['aritmetika', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2023 - uloha 5.1',
     'zad': ['V aquaparku je zapujceni zupanu o 30 korun drazsi nez zapujceni osusky. Zapujceni 5 osusek stoji stejne jako zapujceni 3 zupanu. Vypoctete, kolik korun stoji v aquaparku zapujceni jednoho zupanu.'],
     'opts': None, 'ln': 3,
     'sol': ['Oznacme cenu osusky $o$; zupan stoji $o+30$. Plati $5o=3(o+30)=3o+90$, tedy $2o=90$ a $o=45$. Zupan stoji $45+30=75$ korun.'],
     'ans': '$75$ korun', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['rovnice', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7B 2023 - uloha 5.2',
     'zad': ['Na plaveckem treninku uplavali Jirka, Misa a Pavla dohromady 126 bazenu. Misa uplavala o tretinu vice bazenu nez Jirka a dvakrat vice bazenu nez Pavla. Vypoctete, kolik bazenu uplavala na treninku Misa.'],
     'opts': None, 'ln': 3,
     'sol': ['Necht Misa uplavala $m$ bazenu. Protoze $m$ je o tretinu vice nez pocet Jirky, uplavala Jirka $\\frac{3}{4}m$; Pavla uplavala $\\frac{1}{2}m$. Soucet $\\frac{3}{4}m+m+\\frac{1}{2}m=\\frac{9}{4}m=126$, odtud $m=56$.'],
     'ans': '$56$ bazenu', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['rovnice', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7B 2023 - uloha 6',
     'zad': ['Sest kamaradu si v mobilni aplikaci posilalo ruzne vzkazy. Vytvorili si mezi sebou jednak vsechny mozne peticlenne skupiny, jednak vsechny mozne dvouclenne skupiny.',
             '6.1 Urcete, kolik vytvorili peticlennych skupin.',
             '6.2 Urcete, kolik vytvorili dvouclennych skupin.'],
     'opts': None, 'ln': 2,
     'sol': ['6.1 Peticlenna skupina vznikne vynechanim jednoho ze sesti kamaradu, takovych skupin je $6$.',
             '6.2 Dvouclennych skupin je $\\frac{6\\cdot 5}{2}=15$.'],
     'ans': '6.1: $6$ peticlennych skupin; 6.2: $15$ dvouclennych skupin', 'pts': 3, 'mins': 3, 'diff': '2',
     'codes': B + ['aritmetika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7B 2023 - uloha 7',
     'zad': ['Kolmy ctyrboky hranol ma vysku 20 cm. Podstavou hranolu je kosodelnik s obvodem 30 cm. Delka jedne strany kosodelniku je 7 cm a vyska kosodelniku na sousedni stranu meri 6 cm.',
             '7.1 Vypoctete v cm soucet delek vsech hran hranolu.',
             '7.2 Vypoctete v cm3 objem hranolu.'],
     'opts': None, 'ln': 4, 'svg': SVG7, 'fn': 'hranol.svg',
     'alt': 'Kosodelnik se stranou 7 cm a vyskou 6 cm a kolmy ctyrboky hranol vysky 20 cm.',
     'cap': 'Schematicky nakres podstavy a hranolu',
     'sol': ['7.1 Strany kosodelniku jsou 7 cm a 8 cm, protoze $2\\cdot(7+8)=30$. Hranol ma 8 podstavnych hran o souctu $2\\cdot 30=60$ cm a 4 bocni hrany po 20 cm o souctu $80$ cm. Celkem $60+80=140$ cm.',
             '7.2 Obsah podstavy je $8\\cdot 6=48$ cm2 (strana 8 cm a prislusna vyska 6 cm). Objem je $48\\cdot 20=960$ cm3.'],
     'ans': '7.1: $140$ cm; 7.2: $960$ cm3', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['stereometrie', 'vypocet', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2023 - uloha 8 (konstrukce)',
     'zad': ['V rovine lezi bod $F$ a primka $g$ (viz obrazek).',
             'Bod $F$ je vrchol rovnoramenneho trojuhelniku $EFG$. Strana $EF$ tohoto trojuhelniku meri 5 cm a lezi na kolmici k primce $g$. Na primce $g$ lezi vrchol $G$ trojuhelniku $EFG$.',
             'Sestrojte vrcholy $E$, $G$ trojuhelniku $EFG$, oznacte je pismeny a trojuhelnik narysujte. Najdete vsechna reseni.'],
     'opts': None, 'ln': 0, 'svg': SVG8, 'fn': 'bod-F-primka-g.svg',
     'alt': 'Bod F a primka g mirne klesajici zleva doprava.',
     'cap': 'Vychozi obrazek k uloze 8',
     'sol': ['Sestrojime kruznici se stredem $F$ a polomerem 5 cm. Vrchol $E$ je prusecik teto kruznice s kolmici spustenou z bodu $F$ k primce $g$ (na strane primky $g$). Vrchol $G$ je prusecik kruznice s primkou $g$; jsou dve polohy $G_1$ a $G_2$, trojuhelnik $EFG$ je rovnoramenny, protoze $|FE|=|FG|=5$ cm. Uloha ma dve reseni.'],
     'ans': 'Dve reseni: $|FE|=|FG|=5$ cm; bod $E$ na kolmici z $F$ k primce $g$, vrcholy $G_1$ a $G_2$ jako pruseciky kruznice se stredem $F$ a polomerem 5 cm s primkou $g$ (viz nakres v klici).',
     'pts': 3, 'mins': 6, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2023 - uloha 9 (konstrukce)',
     'zad': ['V rovine lezi body $S$, $Q$ a primka $p$ (viz obrazek).',
             'Na primce $p$ lezi vrcholy $C$, $D$ obdelniku $ABCD$. Bod $S$ je stred strany $AD$ tohoto obdelniku. Bodem $Q$ prochazi uhlopricka obdelniku $ABCD$.',
             'Sestrojte vsechny vrcholy obdelniku $ABCD$, oznacte je pismeny a obdelnik narysujte. Najdete vsechna reseni.'],
     'opts': None, 'ln': 0, 'svg': SVG9, 'fn': 'body-S-Q-primka-p.svg',
     'alt': 'Primka p mirne stoupajici a pod ni body S a Q.',
     'cap': 'Vychozi obrazek k uloze 9',
     'sol': ['Protoze $CD$ lezi na primce $p$ a strana $AD$ je na ni kolma, je vrchol $D$ pata kolmice spustene z bodu $S$ na primku $p$ a vrchol $A$ je obrazem $D$ ve stredove soumernosti se stredem $S$ (nebot $S$ je stred $AD$). Vrchol $C$ lezi na primce $p$ tak, aby uhlopricka prochazela bodem $Q$, a vrchol $B$ doplnime do obdelniku. Podle toho, kterou uhloprickou prochazi bod $Q$, dostavame dve reseni ($C_1, B_1$ a $C_2, B_2$).'],
     'ans': 'Dve reseni: $D$ pata kolmice z $S$ na $p$, $A$ obraz $D$ ve stredove soumernosti podle $S$, $C$ na $p$ tak, aby uhlopricka prosla bodem $Q$, $B$ doplnen do obdelniku (polohy $C_1, B_1$ a $C_2, B_2$) - viz nakres v klici.',
     'pts': 3, 'mins': 7, 'diff': '4',
     'codes': B + ['konstrukce', 'porozumeni', 'konstrukcni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2023 - uloha 10',
     'zad': ['Ve ctvercove siti jsou zakresleny bile obrazce A, C, E a tmave obrazce B, D, F. Vrcholy vsech obrazcu lezi v mrizovych bodech ctvercove site.',
             'Rozhodnete o kazdem z nasledujicich tvrzeni 10.1-10.3, zda je pravdive (Ano), ci nikoli (Ne).',
             '10.1 Obsah obrazce B je ctvrtinou obsahu obrazce A.',
             '10.2 Obsah obrazce C je trikrat vetsi nez obsah obrazce D.',
             '10.3 Obsah obrazce E je o tretinu vetsi nez obsah obrazce F.'],
     'opts': None, 'ln': 0, 'svg': SVG10, 'fn': 'sit-obrazce.svg',
     'alt': 'Ctvercova sit s bilymi obrazci A, C, E a tmavymi obrazci B, D, F.',
     'cap': 'Schematicky nakres (obsahy dle klice)',
     'sol': ['10.1 Obsahy: $S_A=4$, $S_B=1$ ctverecky; $1=\\frac{1}{4}\\cdot 4$, tvrzeni je pravdive (Ano).',
             '10.2 Obsahy: $S_C=9$, $S_D=3$ ctverecky; $9=3\\cdot 3$, tvrzeni je pravdive (Ano).',
             '10.3 Obsahy: $S_E=4$, $S_F=3$ ctverecky; $4=3+\\frac{1}{3}\\cdot 3$, tj. o tretinu vice, tvrzeni je pravdive (Ano).'],
     'ans': '10.1: Ano; 10.2: Ano; 10.3: Ano', 'pts': 4, 'mins': 6, 'diff': '3',
     'codes': B + ['planimetrie', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2023 - uloha 11',
     'zad': ['Pravouhly trojuhelnik $ABC$ je dvema useckami $CD$ a $DE$ rozdelen na tri trojuhelniky, z nichz dva jsou take pravouhle (viz obrazek). Uhly oznacene $\\omega$ jsou shodne.',
             'Jaka je velikost uhlu $\\varphi$? Velikosti uhlu nemerte, ale vypoctete.'],
     'opts': ['A) mensi nez $55^\\circ$', 'B) $55^\\circ$', 'C) $65^\\circ$', 'D) $75^\\circ$', 'E) vetsi nez $75^\\circ$'],
     'ln': 0, 'svg': SVG11, 'fn': 'trojuhelnik-uhly.svg',
     'alt': 'Pravouhly trojuhelnik ABC rozdeleny useckami CD a DE na tri trojuhelniky s vyznacenymi uhly omega, fi a 20 stupnu.',
     'cap': 'Schematicky nakres k uloze 11',
     'sol': ['Trojuhelnik $ABC$ ma pravy uhel u vrcholu $A$ a uhel pri vrcholu $B$ je $20^\\circ$, proto $\\angle ACB=70^\\circ$. Usecky $CD$ a $DE$ vytvareji dva pravouhle vnitrni trojuhelniky; z rovnosti vyznacenych uhlu $\\omega$ a ze souctu uhlu vyjde hledany uhel $\\varphi$ vetsi nez $75^\\circ$.'],
     'ans': 'E) vetsi nez $75^\\circ$', 'pts': 2, 'mins': 4, 'diff': '4',
     'codes': B + ['planimetrie', 'vypocet', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2023 - uloha 12',
     'zad': ['Stavba byla vytvorena ze stejne velkych valcu tri ruznych barev. Stavba je v testovem sesitu zobrazena pri pohledu zepredu a shora.',
             'Ktery z obrazku A-E v testovem sesitu muze predstavovat pohled na stavbu zprava?'],
     'opts': ['A) obrazek A', 'B) obrazek B', 'C) obrazek C', 'D) obrazek D', 'E) obrazek E'],
     'ln': 0, 'svg': SVG12, 'fn': 'stavba-valce.svg',
     'alt': 'Schematicka poznamka ke stavbe z valcu (pohledy nelze verne prenest).',
     'cap': 'Prostorova stavba - viz testovy sesit',
     'sol': ['Z pohledu zepredu a shora urcime rozmisteni a barvy valcu; pohledu na stavbu zprava odpovida obrazek E.'],
     'ans': 'E) obrazek E', 'pts': 2, 'mins': 4, 'diff': '4',
     'codes': B + ['stereometrie', 'porozumeni', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2023 - uloha 13',
     'zad': ['Kazda bytost na planete Zorstar ma prave tri nohy a zaroven ma bud tri, nebo ctyri oci. Na namesti se sesly bytosti, ktere mely dohromady 84 nohou. Mezi nimi bylo triokych bytosti o 8 vice nez ctyrokych.',
             'Kolik oci mely dohromady vsechny bytosti, ktere se sesly na namesti?'],
     'opts': ['A) 94 oci', 'B) 96 oci', 'C) 102 oci', 'D) 122 oci', 'E) 130 oci'],
     'ln': 0,
     'sol': ['Bytosti je $84:3=28$. Oznacme ctyroke $c$, triokych je pak $c+8$. Plati $c+(c+8)=28$, tedy $c=10$ a triokych je $18$. Oci je celkem $3\\cdot 18+4\\cdot 10=54+40=94$.'],
     'ans': 'A) 94 oci', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['rovnice', 'modelovani', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2023 - uloha 14',
     'zad': ['Sara, Lukas, Dan a Adela hrali hru, ve ktere ziskavali body. Sara ziskala stejny pocet bodu jako Lukas. Dan ziskal 60 bodu, coz je o polovinu bodu vice, nez ziskali Sara a Lukas dohromady, ale o ctvrtinu bodu mene, nez ziskala Adela.',
             'Ktery z grafu A-E v testovem sesitu zobrazuje odpovidajici pocty bodu ziskanych ve hre?'],
     'opts': ['A) Sara 30, Lukas 30, Dan 60, Adela asi 72',
              'B) Sara 10, Lukas 10, Dan 60, Adela asi 45',
              'C) Sara 10, Lukas 10, Dan 60, Adela asi 72',
              'D) Sara 20, Lukas 20, Dan 60, Adela asi 80',
              'E) Sara 20, Lukas 20, Dan 60, Adela asi 45'],
     'ln': 0,
     'sol': ['Z podminky $60=\\frac{3}{2}(S+L)$ plyne $S+L=40$, tedy $S=L=20$. Z podminky $60=\\frac{3}{4}A$ (Dan ma o ctvrtinu mene nez Adela) plyne $A=80$. Hodnotam Sara 20, Lukas 20, Dan 60, Adela 80 odpovida graf D.'],
     'ans': 'D) Sara 20, Lukas 20, Dan 60, Adela asi 80', 'pts': 2, 'mins': 4, 'diff': '3',
     'codes': B + ['statistika', 'modelovani', 'slovni', 'bez-kalkulacky', 'bez-kontextu']},

    {'name': 'CERMAT M7B 2023 - uloha 15',
     'zad': ['Priradte ke kazde uloze (15.1-15.3) odpovidajici vysledek (A-F).',
             '15.1 Castka 200 tisic korun vyclenena na odmeny byla rozdelena mezi dve oddeleni. Prvni oddeleni dostalo z teto castky 130 tisic korun. Kolik procent z vyclenene castky dostalo druhe oddeleni?',
             '15.2 Maminka umyla 40 % oken v dome. Ze zbyvajicich 12 oken v dome jich 9 umyl tatinek. Kolik procent oken v dome umyl tatinek?',
             '15.3 Jonas si z kapesneho koupil pouze knihu a mic. Za knihu utratil ctvrtinu kapesneho a za mic pak utratil 20 % zbytku kapesneho. Vse, co z kapesneho neutratil, ulozil do kasicky. Kolik procent kapesneho ulozil Jonas do kasicky?'],
     'opts': ['A) mene nez 35 %', 'B) 35 %', 'C) 45 %', 'D) 55 %', 'E) 60 %', 'F) vice nez 60 %'],
     'ln': 0,
     'sol': ['15.1 Druhe oddeleni dostalo $200-130=70$ tisic korun, tj. $\\frac{70}{200}=35\\,\\%$ vyclenene castky -> B.',
             '15.2 Zbyvajicich 12 oken je $60\\,\\%$ vsech oken, celkem je tedy $20$ oken; tatinek umyl $\\frac{9}{20}=45\\,\\%$ -> C.',
             '15.3 Kniha $25\\,\\%$, zbytek $75\\,\\%$; mic $20\\,\\%$ ze $75\\,\\%$, tj. $15\\,\\%$. Do kasicky ulozil $75\\,\\%-15\\,\\%=60\\,\\%$ -> E.'],
     'ans': '15.1: B (35 %); 15.2: C (45 %); 15.3: E (60 %)', 'pts': 6, 'mins': 9, 'diff': '4',
     'codes': B + ['procenta', 'vypocet', 'slovni', 'bez-kalkulacky', 'bezny-zivot']},

    {'name': 'CERMAT M7B 2023 - uloha 16',
     'zad': ['Zakladnim dilkem je 1. obdelnik, ktery je rozdeleny na bily ctverecek a sest stejne velkych trojuhelniku - bile prilehaji ke kratsim stranam obdelniku a sede k delsim stranam. Spojovanim zakladnich dilku vytvarime vetsi obdelniky podle pravidel: prilehaji k sobe pouze trojuhelniky teze barvy a jejich spojenim vznikaji dalsi ctverecky; delsi strana obdelniku je vzdy dvakrat delsi nez kratsi strana; v prvnim obdelniku prileha ke kratsi strane jeden bily trojuhelnik a v kazdem dalsim obdelniku vzdy o jeden bily trojuhelnik vice. Druhy obdelnik obsahuje 6 bilych a 4 sede ctverecky.',
             '16.1 Urcete, kolik ctverecku (bilych i sedych dohromady) obsahuje 4. obdelnik.',
             '16.2 Urcete, kolik sedych ctverecku obsahuje obdelnik se 45 bilymi ctverecky.',
             '16.3 Urcete, kolik bilych ctverecku obsahuje obdelnik, ve kterem je bilych ctverecku o 7 vice nez sedych.'],
     'opts': None, 'ln': 2, 'svg': SVG16, 'fn': 'obdelniky.svg',
     'alt': 'Rada obdelniku (1. az 3.) z bilych ctverecku a sedych trojuhelniku, delsi strana dvakrat delsi nez kratsi.',
     'cap': 'Schematicky nakres rady obdelniku',
     'sol': ['Pro $n$-ty obdelnik plati: pocet bilych ctverecku $B(n)=2n^2-n$, pocet sedych ctverecku $S(n)=2n^2-2n$ (overeni pro $n=2$: $B=6$, $S=4$).',
             '16.1 Celkem $B(4)+S(4)=(2\\cdot 16-4)+(2\\cdot 16-8)=28+24=52$ ctverecku.',
             '16.2 Z $2n^2-n=45$ plyne $n=5$, pak $S(5)=2\\cdot 25-10=40$ sedych ctverecku.',
             '16.3 Rozdil $B(n)-S(n)=n=7$, tedy $B(7)=2\\cdot 49-7=91$ bilych ctverecku.'],
     'ans': '16.1: $52$ ctverecku; 16.2: $40$ sedych ctverecku; 16.3: $91$ bilych ctverecku', 'pts': 4, 'mins': 8, 'diff': '4',
     'codes': B + ['posloupnosti', 'argumentace', 'pocetni', 'bez-kalkulacky', 'bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M7PBD23C0T02'
    gen.YEAR = 2023

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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M7B-2023')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} uloh [{"OK" if sz<9000 else "PRES 9KB"}]')
    print('Celkem uloh:', tot)
