# -*- coding: utf-8 -*-
# CERMAT - Jednotna prijimaci zkouska 2023, MATEMATIKA 7 (sestilete obory, 7. rocnik).
# Kod testu: M7PCD23C0T03. 16 uloh (po rozdeleni nezavislych poduloh 19 uloh).
# Zdroj odpovedi: klic spravnych reseni (KLIC_7C_2023.pdf).

import math

# ---- SVG obrazky (bez ' a \) ----

# uloha 6: sestiuhelnik = ctverec + obdelnik + trojuhelnik (schematicky "domecek")
SVG6 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 210 170" font-family="sans-serif">
<polygon points="20,140 20,80 80,80 130,20 180,80 180,140" fill="none" stroke="#000" stroke-width="2"/>
<line x1="80" y1="80" x2="80" y2="140" stroke="#000" stroke-width="1.3"/>
<line x1="80" y1="80" x2="180" y2="80" stroke="#000" stroke-width="1.3"/>
<text x="50" y="115" font-size="11" text-anchor="middle">ctverec</text>
<text x="130" y="118" font-size="11" text-anchor="middle">obdelnik</text>
<text x="130" y="62" font-size="11" text-anchor="middle">trojuhelnik</text>
</svg>"""

# uloha 7: pravidelny ctyrboky hranol (kvadr se ctvercovou podstavou) - schematicky
SVG7 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 220 210" font-family="sans-serif">
<rect x="40" y="60" width="100" height="120" fill="none" stroke="#000" stroke-width="2"/>
<line x1="40" y1="60" x2="85" y2="20" stroke="#000" stroke-width="2"/>
<line x1="140" y1="60" x2="185" y2="20" stroke="#000" stroke-width="2"/>
<line x1="140" y1="180" x2="185" y2="140" stroke="#000" stroke-width="2"/>
<line x1="85" y1="20" x2="185" y2="20" stroke="#000" stroke-width="2"/>
<line x1="185" y1="20" x2="185" y2="140" stroke="#000" stroke-width="2"/>
<line x1="40" y1="180" x2="85" y2="140" stroke="#000" stroke-width="1.2" stroke-dasharray="4 4"/>
<line x1="85" y1="20" x2="85" y2="140" stroke="#000" stroke-width="1.2" stroke-dasharray="4 4"/>
<line x1="85" y1="140" x2="185" y2="140" stroke="#000" stroke-width="1.2" stroke-dasharray="4 4"/>
</svg>"""

# uloha 8: primka AB a primka p prochazejici bodem B (vychozi obrazek ke konstrukci)
SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 380" font-family="sans-serif">
<line x1="95" y1="345" x2="600" y2="130" stroke="#000" stroke-width="2"/>
<line x1="330" y1="30" x2="620" y2="250" stroke="#000" stroke-width="2"/>
<circle cx="160" cy="322" r="3" fill="#000"/><text x="150" y="342" font-size="15" font-style="italic">A</text>
<line x1="152" y1="316" x2="168" y2="328" stroke="#000" stroke-width="1"/>
<circle cx="518" cy="163" r="3" fill="#000"/><text x="524" y="158" font-size="15" font-style="italic">B</text>
<text x="612" y="248" font-size="15" font-style="italic">p</text>
</svg>"""

# uloha 9: body A, C a primka p prochazejici bodem C (vychozi obrazek ke konstrukci)
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 400" font-family="sans-serif">
<line x1="140" y1="64" x2="350" y2="386" stroke="#000" stroke-width="2"/>
<circle cx="170" cy="110" r="3" fill="#000"/><text x="150" y="112" font-size="15" font-style="italic">C</text>
<line x1="185" y1="100" x2="197" y2="116" stroke="#000" stroke-width="1"/>
<text x="242" y="298" font-size="15">x</text><text x="248" y="316" font-size="15" font-style="italic">A</text>
<text x="352" y="384" font-size="15" font-style="italic">p</text>
</svg>"""

# uloha 10: prstencovy (mezikruzni) graf oddilu A, B, C s pocty chlapcu a divek - schematicky
def _donut():
    cx, cy, rIn, rOut, rMid, rLab = 175, 180, 52, 130, 92, 28
    def pt(r, deg):
        a = math.radians(deg)
        return cx + r*math.cos(a), cy - r*math.sin(a)
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 360" font-family="sans-serif">']
    s.append(f'<circle cx="{cx}" cy="{cy}" r="{rOut}" fill="none" stroke="#000" stroke-width="1.6"/>')
    s.append(f'<circle cx="{cx}" cy="{cy}" r="{rIn}" fill="none" stroke="#000" stroke-width="1.6"/>')
    for deg in (90, 210, 330):
        xi, yi = pt(rIn, deg); xo, yo = pt(rOut, deg)
        s.append(f'<line x1="{xi:.0f}" y1="{yi:.0f}" x2="{xo:.0f}" y2="{yo:.0f}" stroke="#000" stroke-width="1.4"/>')
    for lab, deg in (('A', 30), ('C', 150), ('B', 270)):
        x, y = pt(rLab, deg)
        s.append(f'<text x="{x:.0f}" y="{y+5:.0f}" font-size="18" font-weight="bold" text-anchor="middle">{lab}</text>')
    entries = [('chlapci 9', 60), ('divky 7', 5), ('chlapci 3', 120), ('divky ?', 170), ('divky 4', 225), ('chlapci ?', 315)]
    for lab, deg in entries:
        x, y = pt(rMid, deg)
        s.append(f'<text x="{x:.0f}" y="{y+4:.0f}" font-size="12" text-anchor="middle">{lab}</text>')
    s.append('</svg>')
    return "".join(s)
SVG10 = _donut()

# uloha 12: petiuhelnik ABCDE (rovnoramenny + rovnostranny + pravouhly trojuhelnik)
SVG12 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 340" font-family="sans-serif">
<polygon points="60,300 360,300 470,180 410,110 160,150" fill="none" stroke="#000" stroke-width="2"/>
<line x1="360" y1="300" x2="160" y2="150" stroke="#000" stroke-width="1.3"/>
<line x1="360" y1="300" x2="410" y2="110" stroke="#000" stroke-width="1.3"/>
<text x="52" y="318" font-size="15" font-style="italic">A</text>
<text x="360" y="320" font-size="15" font-style="italic">B</text>
<text x="478" y="184" font-size="15" font-style="italic">C</text>
<text x="410" y="102" font-size="15" font-style="italic">D</text>
<text x="140" y="150" font-size="15" font-style="italic">E</text>
<text x="98" y="292" font-size="13">55 st.</text>
<text x="392" y="140" font-size="15">omega</text>
<rect x="452" y="176" width="9" height="9" fill="none" stroke="#000" stroke-width="1"/>
</svg>"""

# ulohy 13-14: tri modely krychli (Denisa 2x2x2, Emil 3x3x3, Filip 4x4x4) - schematicky
def _cube(ox, oy, s):
    d = round(s*0.42)
    out = []
    out.append(f'<rect x="{ox}" y="{oy}" width="{s}" height="{s}" fill="none" stroke="#000" stroke-width="1.6"/>')
    out.append(f'<rect x="{ox+d}" y="{oy-d}" width="{s}" height="{s}" fill="none" stroke="#000" stroke-width="1.2"/>')
    for cx, cy in ((ox, oy), (ox+s, oy), (ox+s, oy+s), (ox, oy+s)):
        out.append(f'<line x1="{cx}" y1="{cy}" x2="{cx+d}" y2="{cy-d}" stroke="#000" stroke-width="1.2"/>')
    return "".join(out)
SVG_CUBES = ('<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 540 210" font-family="sans-serif">'
    + _cube(30, 110, 44) + '<text x="60" y="185" font-size="12" text-anchor="middle">Denisin model</text>'
    + _cube(170, 100, 64) + '<text x="212" y="185" font-size="12" text-anchor="middle">Emiluv model</text>'
    + _cube(330, 95, 84) + '<text x="382" y="185" font-size="12" text-anchor="middle">Filipuv model</text>'
    + '<text x="500" y="130" font-size="30" text-anchor="middle">?</text>'
    + '<text x="270" y="30" font-size="11" text-anchor="middle" fill="#666">Schematicky nakres modelu krychli (viz testovy sesit).</text>'
    + '</svg>')

# uloha 16: obrazce ze sedych (male) a bilych (2x) ctverecku - 1. a 2. obrazec
def _pattern():
    g = 18
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 180" font-family="sans-serif">']
    def obrazec(ox, b, l, bottomY, label):
        oy = bottomY - l*g
        white_cols = (b-1)//2; white_rows = (l-1)//2
        for i in range(white_cols):
            for j in range(white_rows):
                s.append(f'<rect x="{ox+g+i*2*g}" y="{oy+j*2*g}" width="{2*g}" height="{2*g}" fill="#fff" stroke="#000" stroke-width="1.2"/>')
        for cidx in range(b):
            s.append(f'<rect x="{ox+cidx*g}" y="{oy+(l-1)*g}" width="{g}" height="{g}" fill="#b9b9b9" stroke="#000" stroke-width="0.8"/>')
        for ridx in range(l):
            s.append(f'<rect x="{ox}" y="{oy+ridx*g}" width="{g}" height="{g}" fill="#b9b9b9" stroke="#000" stroke-width="0.8"/>')
        s.append(f'<text x="{ox+b*g/2:.0f}" y="{bottomY+18}" font-size="12" text-anchor="middle">{label}</text>')
    obrazec(30, 5, 3, 140, "1. obrazec")
    obrazec(200, 7, 5, 140, "2. obrazec")
    s.append('<text x="410" y="115" font-size="22">...</text></svg>')
    return "".join(s)
SVG16 = _pattern()

B = ['zs2', 'r7']  # 2. stupen ZS, 7. rocnik (sestilete obory)

PROBLEMS = [
    {'name':'CERMAT M7C 2023 - uloha 1','zad':[
        'Vypoctete, kolikrat je soucet cisel $0{,}2$ a $0{,}5$ vetsi nez jejich soucin.'],
     'opts':None,'ln':2,
     'sol':['Soucet: $0{,}2+0{,}5=0{,}7$. Soucin: $0{,}2\\cdot 0{,}5=0{,}1$. Podil $0{,}7:0{,}1=7$, soucet je tedy $7$krat vetsi nez soucin.'],
     'ans':'$7$krat','pts':1,'mins':2,'diff':'2',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7C 2023 - uloha 2.1','zad':[
        'Vypoctete a vysledek zapiste zlomkem v zakladnim tvaru:',
        '$\\left(\\dfrac{2}{7}-\\dfrac{4}{7}\\cdot 2\\right):2=$'],
     'opts':None,'ln':4,
     'sol':['$\\dfrac{4}{7}\\cdot 2=\\dfrac{8}{7}$, tedy $\\dfrac{2}{7}-\\dfrac{8}{7}=-\\dfrac{6}{7}$. Po deleni dvema: $-\\dfrac{6}{7}:2=-\\dfrac{6}{14}=-\\dfrac{3}{7}$.'],
     'ans':'$-\\dfrac{3}{7}$','pts':2,'mins':3,'diff':'2',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7C 2023 - uloha 2.2','zad':[
        'Vypoctete a vysledek zapiste zlomkem v zakladnim tvaru:',
        '$\\dfrac{\\frac{3}{4}+\\frac{4}{3}}{\\frac{5}{7}\\cdot\\frac{14}{3}}=$'],
     'opts':None,'ln':4,
     'sol':['Citatel: $\\dfrac{3}{4}+\\dfrac{4}{3}=\\dfrac{9+16}{12}=\\dfrac{25}{12}$. Jmenovatel: $\\dfrac{5}{7}\\cdot\\dfrac{14}{3}=\\dfrac{10}{3}$. Podil: $\\dfrac{25}{12}:\\dfrac{10}{3}=\\dfrac{25}{12}\\cdot\\dfrac{3}{10}=\\dfrac{75}{120}=\\dfrac{5}{8}$.'],
     'ans':'$\\dfrac{5}{8}$','pts':2,'mins':4,'diff':'3',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7C 2023 - uloha 3.1','zad':[
        'Adam, Beta i Cyril sbiraji karticky s pokemony. Adam jich ma o $50$ vice nez Beta a Cyril jich ma o $20$ mene nez Beta. Adam jich ma dvakrat vice nez Cyril.',
        'Vypoctete, kolik karticek s pokemony ma Beta.'],
     'opts':None,'ln':3,
     'sol':['Oznacme pocet Betinych karticek $b$. Pak Adam ma $b+50$ a Cyril ma $b-20$. Z podminky $b+50=2\\cdot(b-20)$ dostaneme $b+50=2b-40$, tedy $b=90$.'],
     'ans':'$90$ karticek','pts':2,'mins':3,'diff':'2',
     'codes':B+['rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M7C 2023 - uloha 3.2','zad':[
        'V obchode prodavaji sberatelske karticky v baleních jednak po ctyrech, jednak po sedmi kartickach. Behem tydne prodali celkem $224$ karticek, pricemz baleni po ctyrech kartickach prodali o $10$ mene nez baleni po sedmi kartickach.',
        'Vypoctete, kolik baleni sberatelskych karticek behem tydne celkem prodali.'],
     'opts':None,'ln':3,
     'sol':['Oznacme pocet baleni po sedmi $x$; baleni po ctyrech je pak $x-10$. Plati $7x+4(x-10)=224$, tedy $11x-40=224$, $11x=264$, $x=24$. Baleni po ctyrech je $14$. Celkem $24+14=38$ baleni.'],
     'ans':'$38$ baleni','pts':2,'mins':4,'diff':'3',
     'codes':B+['rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M7C 2023 - uloha 4','zad':[
        'Vitek, Ondra a Rudolf jeli spolecne autem k mori. Kazdy z nich odridil cast trasy. Vitek odridil tretinu cele trasy, Ondra dve petiny cele trasy a zbytek trasy odridil Rudolf.',
        '4.1 Vyjadrete zlomkem, jakou cast trasy odridil Rudolf.',
        '4.2 Rudolf odridil o $60$ km mene nez Vitek. Vypoctete, kolik km merila cela trasa.'],
     'opts':None,'ln':3,
     'sol':['4.1 Rudolf odridil $1-\\dfrac{1}{3}-\\dfrac{2}{5}=\\dfrac{15-5-6}{15}=\\dfrac{4}{15}$ cele trasy.',
            '4.2 Vitek odridil $\\dfrac{1}{3}=\\dfrac{5}{15}$, Rudolf $\\dfrac{4}{15}$; rozdil je $\\dfrac{1}{15}$ trasy a odpovida $60$ km. Cela trasa meri $15\\cdot 60=900$ km.'],
     'ans':'4.1: $\\dfrac{4}{15}$; 4.2: $900$ km','pts':3,'mins':5,'diff':'3',
     'codes':B+['aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M7C 2023 - uloha 5.1','zad':[
        'Zavodnik ubehl celou trasu za $3$ hodiny. Behem prvni hodiny ubehl tretinu cele trasy. Behem posledni hodiny ubehl jen $9$ km, coz byla ctvrtina cele trasy.',
        'Vypoctete, kolik km ubehl zavodnik behem druhe hodiny.'],
     'opts':None,'ln':4,
     'sol':['Posledni hodina ($9$ km) je ctvrtina trasy, cela trasa meri $4\\cdot 9=36$ km. Prvni hodina: $\\dfrac{1}{3}\\cdot 36=12$ km. Druha hodina: $36-12-9=15$ km.'],
     'ans':'$15$ km','pts':2,'mins':3,'diff':'2',
     'codes':B+['aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M7C 2023 - uloha 5.2','zad':[
        'Pavel, Rosta a Sofie se jako triclenna stafeta prihlasili na charitativni beh dlouhy $36$ km. Trasu behu si rozdelili na tri ruzne dlouhe useky. Rosta vsak onemocnel, proto polovinu jeho useku ubehl Pavel a druhou polovinu Sofie. Ve skutecnosti tak Pavel ubehl o tretinu delsi usek, nez mel puvodne ubehnout, a Sofie o ctvrtinu delsi usek, nez mela puvodne ubehnout.',
        'Vypoctete, kolik km mel puvodne ubehnout Rosta.'],
     'opts':None,'ln':4,
     'sol':['Oznacme puvodni useky $p$ (Pavel), $s$ (Sofie), $r$ (Rosta); $p+s+r=36$. Pavel navic ubehl $\\dfrac{r}{2}$, coz je tretina jeho useku: $\\dfrac{r}{2}=\\dfrac{p}{3}$, tedy $p=\\dfrac{3r}{2}$. Sofie navic ubehla $\\dfrac{r}{2}$, coz je ctvrtina jejiho useku: $\\dfrac{r}{2}=\\dfrac{s}{4}$, tedy $s=2r$. Dosazenim: $\\dfrac{3r}{2}+2r+r=36$, tj. $\\dfrac{9r}{2}=36$, $r=8$.'],
     'ans':'$8$ km','pts':2,'mins':6,'diff':'4',
     'codes':B+['aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M7C 2023 - uloha 6','zad':[
        'Sestiuhelnik na obrazku se sklada z rovnoramenneho trojuhelniku, obdelniku a ctverce. Zakladna rovnoramenneho trojuhelniku splyva s delsi stranou obdelniku a rameno tohoto trojuhelniku je o $1$ cm delsi nez strana ctverce. Obvod ctverce je stejny jako obvod trojuhelniku, ale o $8$ cm mensi nez obvod obdelniku.',
        '6.1 Vypoctete, o kolik cm se lisi delka a sirka obdelniku.',
        '6.2 Vypoctete, kolik cm meri rameno rovnoramenneho trojuhelniku.'],
     'opts':None,'ln':3,'svg':SVG6,'fn':'sestiuhelnik.svg',
     'alt':'Sestiuhelnik slozeny ze ctverce (vlevo), obdelniku (vpravo) a trojuhelniku (nahore).',
     'cap':'Schematicky nakres sestiuhelniku',
     'sol':['Oznacme stranu ctverce $a$. Rameno trojuhelniku je $a+1$, jeho zakladna se rovna delsi strane obdelniku $d$; kratsi strana obdelniku je rovna strane ctverce $a$.',
            'Obvod ctverce = obvod trojuhelniku: $4a=d+2(a+1)$, tj. $d=2a-2$. Obvod ctverce je o $8$ mensi nez obvod obdelniku: $4a=2(d+a)-8$, tj. $d=a+4$. Z rovnic $2a-2=a+4$ plyne $a=6$ a $d=10$.',
            '6.1 Delka a sirka obdelniku se lisi o $d-a=10-6=4$ cm.',
            '6.2 Rameno trojuhelniku meri $a+1=7$ cm.'],
     'ans':'6.1: o $4$ cm; 6.2: $7$ cm','pts':3,'mins':6,'diff':'3',
     'codes':B+['planimetrie','modelovani','slovni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7C 2023 - uloha 7','zad':[
        'Povrch pravidelneho ctyrbokeho hranolu je $144$ cm². Obsah plaste tohoto hranolu je dvakrat vetsi nez obsah jedne jeho ctvercove podstavy. (Plast tohoto hranolu tvori ctyri shodne bocni steny.)',
        '7.1 Vypoctete v cm delku strany ctvercove podstavy.',
        '7.2 Vypoctete v cm² obsah jedne bocni steny hranolu.',
        '7.3 Vypoctete v cm³ objem hranolu.'],
     'opts':None,'ln':3,'svg':SVG7,'fn':'hranol.svg',
     'alt':'Pravidelny ctyrboky hranol (kvadr se ctvercovou podstavou) v kosem promitani.',
     'cap':'Schematicky nakres hranolu',
     'sol':['Povrch $=2\\cdot S_p+S_{pl}$, kde plast $S_{pl}=2S_p$. Tedy $144=2S_p+2S_p=4S_p$, odkud $S_p=36$ cm².',
            '7.1 Strana podstavy $a=\\sqrt{36}=6$ cm.',
            '7.2 Plast $S_{pl}=2\\cdot 36=72$ cm², jedna ze ctyr shodnych bocnich sten ma obsah $72:4=18$ cm².',
            '7.3 Z $a\\cdot v=18$ a $a=6$ plyne vyska $v=3$ cm; objem $V=S_p\\cdot v=36\\cdot 3=108$ cm³.'],
     'ans':'7.1: $6$ cm; 7.2: $18$ cm²; 7.3: $108$ cm³','pts':3,'mins':6,'diff':'3',
     'codes':B+['stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7C 2023 - uloha 8 (konstrukce)','zad':[
        'V rovine lezi primka $AB$ a primka $p$ prochazejici bodem $B$ (viz obrazek).',
        'Usecka $AB$ je strana pravouhleho lichobezniku $ABCD$. Vrchol $C$ tohoto lichobezniku lezi na primce $p$, uhloprícka $AC$ ma stejnou delku jako strana $AB$ lichobezniku $ABCD$.',
        'Sestrojte vrcholy $C$, $D$ lichobezniku $ABCD$, oznacte je pismeny a lichobeznik narysujte. Najdete vsechna reseni.'],
     'opts':None,'ln':0,'svg':SVG8,'fn':'primka-ab-p.svg',
     'alt':'Primka AB (s vyznacenym bodem A) a primka p prochazejici bodem B.',
     'cap':'Vychozi obrazek k uloze 8',
     'sol':['Vrchol $C$ lezi na primce $p$ a zaroven na kruznici se stredem $A$ a polomerem $|AB|$ (protoze $|AC|=|AB|$); tim je bod $C$ urcen. Vrchol $D$ doplnime tak, aby $ABCD$ byl pravouhly lichobeznik. Uloha ma dve reseni - lichobezniky s vrcholem $D_1$ a $D_2$ (viz nacrt v klici).'],
     'ans':'Konstrukce pravouhleho lichobezniku $ABCD$: $C$ je prusecik primky $p$ s kruznici se stredem $A$ a polomerem $|AB|$; dve reseni $D_1$, $D_2$ (viz nacrt v klici).',
     'pts':3,'mins':7,'diff':'4',
     'codes':B+['konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7C 2023 - uloha 9 (konstrukce)','zad':[
        'V rovine lezi body $A$, $C$ a primka $p$ prochazejici bodem $C$ (viz obrazek).',
        'Usecka $AC$ je zakladna rovnoramenneho trojuhelniku $ABC$. Na primce $p$ lezi jedna ze tri vysek tohoto trojuhelniku.',
        '9.1 Sestrojte osu soumernosti trojuhelniku $ABC$ a oznacte ji pismenem $o$.',
        '9.2 Sestrojte vrchol $B$ trojuhelniku $ABC$, oznacte ho pismenem a trojuhelnik narysujte.'],
     'opts':None,'ln':0,'svg':SVG9,'fn':'body-ac-p.svg',
     'alt':'Body A, C a primka p prochazejici bodem C.',
     'cap':'Vychozi obrazek k uloze 9',
     'sol':['9.1 Osa soumernosti rovnoramenneho trojuhelniku se zakladnou $AC$ je osa $o$ usecky $AC$ (kolmice v jejim stredu).',
            '9.2 Na primce $p$ (prochazejici bodem $C$) lezi vyska z vrcholu $C$, proto je $p\\perp AB$. Stranu $AB$ sestrojime jako kolmici k primce $p$ vedenou bodem $A$; vrchol $B$ je prusecik teto kolmice s osou $o$ (viz nacrt v klici).'],
     'ans':'Osa $o$ je osa usecky $AC$; vrchol $B$ je prusecik osy $o$ s kolmici k primce $p$ vedenou bodem $A$ (viz nacrt v klici).',
     'pts':3,'mins':6,'diff':'3',
     'codes':B+['konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7C 2023 - uloha 10','zad':[
        'Na tabore je kazde dite zarazeno do jednoho ze tri oddilu $A$, $B$ a $C$. V oddile $A$ je dvakrat vice deti nez v oddile $C$. Pomer poctu deti v oddile $A$ ku poctu deti v oddile $B$ je $4:3$. Graf udava pocty chlapcu a divek v jednotlivych oddilech, dva udaje vsak chybi.',
        'Rozhodnete o kazdem z nasledujicich tvrzeni 10.1-10.3, zda je pravdive (A), ci nikoli (N).',
        '10.1 V oddile $C$ je $5$ divek.',
        '10.2 V oddile $B$ je chlapcu o polovinu vice nez divek.',
        '10.3 Na tabore je divek o petinu mene nez chlapcu.'],
     'opts':None,'ln':0,'svg':SVG10,'fn':'graf-oddily.svg',
     'alt':'Prstencovy graf tri oddilu A, B, C s pocty chlapcu a divek; dva udaje (divky v C, chlapci v B) chybi.',
     'cap':'Schematicky nakres grafu (dva udaje chybi)',
     'sol':['V oddile $A$ je $9+7=16$ deti. Oddil $C$ ma polovinu, tj. $8$ deti; z toho $3$ chlapci, takze divek je $8-3=5$ -> 10.1 A.',
            'Pomer $A:B=4:3$ dava $B=\\dfrac{3}{4}\\cdot 16=12$ deti; z toho $4$ divky, tedy chlapcu $12-4=8$. To je dvakrat vice nez divek (ne o polovinu vice) -> 10.2 N.',
            'Celkem divek $7+4+5=16$, chlapcu $9+8+3=20$. Petina z $20$ je $4$ a $20-4=16$ -> divek je o petinu mene nez chlapcu -> 10.3 A.'],
     'ans':'10.1: A (ano); 10.2: N (ne); 10.3: A (ano)','pts':4,'mins':6,'diff':'3',
     'codes':B+['statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M7C 2023 - uloha 11','zad':[
        'V obchode s orisky michaji smes arasidu a mandli a prodavaji ji v ruzne velkych baleních. Sto gramu teto smesi se prodava za $20$ korun, pricemz sto gramu arasidu stoji $10$ korun. Tereza si koupila $800$gramove baleni teto smesi. V takovem baleni je vzdy $300$ g arasidu. Cena smesi zavisi pouze na hmotnosti a cene pouzitych surovin.',
        'Kolik korun stoji sto gramu mandli?'],
     'opts':['A) $26$ korun','B) $27$ korun','C) $28$ korun','D) $29$ korun','E) jiny pocet korun'],'ln':0,
     'sol':['Baleni $800$ g stoji $8\\cdot 20=160$ korun. Arasidy ($300$ g) stoji $3\\cdot 10=30$ korun, takze $500$ g mandli stoji $160-30=130$ korun. Sto gramu mandli stoji $130:5=26$ korun.'],
     'ans':'A) $26$ korun','pts':2,'mins':4,'diff':'3',
     'codes':B+['aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M7C 2023 - uloha 12','zad':[
        'Petiuhelnik $ABCDE$ se sklada z rovnoramenneho, rovnostranneho a pravouhleho trojuhelniku. Zakladnou rovnoramenneho trojuhelniku je strana $AB$. Strany $BC$ a $AE$ petiuhelniku jsou rovnobezne. Uhel pri vrcholu $A$ ma velikost $55^\\circ$.',
        'Jaka je velikost uhlu $\\omega$ pri vrcholu $D$? Velikosti uhlu nemerte, ale vypoctete.'],
     'opts':['A) $65^\\circ$','B) $70^\\circ$','C) $75^\\circ$','D) $80^\\circ$','E) jina velikost'],'ln':0,
     'svg':SVG12,'fn':'petiuhelnik.svg',
     'alt':'Petiuhelnik ABCDE rozdeleny uhloprickami z vrcholu B na tri trojuhelniky; uhel 55 stupnu u A, uhel omega u D, pravy uhel u C.',
     'cap':'Vychozi obrazek k uloze 12',
     'sol':['Trojuhelnik $ABE$ je rovnoramenny se zakladnou $AB$, proto $|\\angle ABE|=|\\angle EAB|=55^\\circ$. Protoze $AE\\parallel BC$, je $|\\angle ABC|=180^\\circ-55^\\circ=125^\\circ$. Trojuhelnik $EBD$ je rovnostranny, tedy $|\\angle EBD|=60^\\circ$, a proto $|\\angle DBC|=125^\\circ-55^\\circ-60^\\circ=10^\\circ$. Trojuhelnik $BCD$ je pravouhly s pravym uhlem u vrcholu $C$, takze $\\omega=|\\angle BDC|=90^\\circ-10^\\circ=80^\\circ$.'],
     'ans':'D) $80^\\circ$','pts':2,'mins':6,'diff':'4',
     'codes':B+['planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7C 2023 - uloha 13','zad':[
        'Stavebnice obsahuje stejne dlouhe drevene tycky a plastove kulicky se sesti dirami, do nichz lze tycky pripevnovat. Denisa vytvorila z $8$ kulicek a $12$ tycek model nejmensi mozne krychle. Emil vytvoril model druhe nejmensi krychle; jeho model obsahuje celkem $27$ kulicek a $54$ tycek. Filip vytvoril stejnym zpusobem model treti nejmensi krychle, ktery obsahuje celkem $144$ tycek.',
        'Kolik kulicek celkem obsahuje Filipuv model krychle?'],
     'opts':['A) $36$ kulicek','B) $48$ kulicek','C) $56$ kulicek','D) $64$ kulicek','E) jiny pocet kulicek'],'ln':0,
     'svg':SVG_CUBES,'fn':'krychle-modely-13.svg',
     'alt':'Tri modely krychli ze zvetsujicim se poctem kulicek (Denisin, Emiluv, Filipuv).',
     'cap':'Schematicky nakres (prostorova telesa nelze verne prenest)',
     'sol':['Modely tvori mrizku kulicek. Denisin model ma $2\\times 2\\times 2=8$ kulicek, Emiluv $3\\times 3\\times 3=27$ kulicek. Filipuv (treti nejmensi) ma $4\\times 4\\times 4=64$ kulicek.'],
     'ans':'D) $64$ kulicek','pts':2,'mins':3,'diff':'2',
     'codes':B+['stereometrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7C 2023 - uloha 14','zad':[
        'Stavebnice obsahuje stejne dlouhe drevene tycky a plastove kulicky se sesti dirami. Denisa vytvorila z $8$ kulicek a $12$ tycek model nejmensi mozne krychle. Emil vytvoril model druhe nejmensi krychle ($27$ kulicek, $54$ tycek). Filip vytvoril model treti nejmensi krychle, ktery obsahuje celkem $144$ tycek.',
        'Kolik tycek lezi na hranach Filipovy krychle?'],
     'opts':['A) mene nez $36$ tycek','B) $36$ tycek','C) $40$ tycek','D) $48$ tycek','E) vice nez $48$ tycek'],'ln':0,
     'svg':SVG_CUBES,'fn':'krychle-modely-14.svg',
     'alt':'Tri modely krychli ze zvetsujicim se poctem kulicek (Denisin, Emiluv, Filipuv).',
     'cap':'Schematicky nakres (prostorova telesa nelze verne prenest)',
     'sol':['Filipova krychle ma kazdou hranu rozdelenou na tri shodne useky. Krychle ma $12$ hran, na kazde lezi $3$ tycky, dohromady $12\\cdot 3=36$ tycek na hranach.'],
     'ans':'B) $36$ tycek','pts':2,'mins':3,'diff':'3',
     'codes':B+['stereometrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7C 2023 - uloha 15','zad':[
        'Priradte ke kazde uloze (15.1-15.3) odpovidajici vysledek (A-F).',
        '15.1 Encyklopedie ma o $25$ % vice stran nez atlas, ktery ma $200$ stran. Kolik stran ma encyklopedie?',
        '15.2 Roza cte knihu, ktera ma $500$ stran. Pocet stran, ktere Roza jiz precetla, je o $50$ % vetsi nez pocet stran, ktere dosud neprecetla. Kolik stran knihy Roza dosud neprecetla?',
        '15.3 V knihovne jsou nektere knihy psane nemecky, jine anglicky a ostatni cesky. Nemecky psanych je $30$ knih, coz je $10$ % vsech knih v knihovne. Anglicky psane knihy tvori petinu vsech knih v knihovne. Kolik je v knihovne cesky psanych knih?'],
     'opts':['A) mene nez $210$','B) $210$','C) $220$','D) $240$','E) $250$','F) jiny pocet'],'ln':0,
     'sol':['15.1 $200\\cdot 1{,}25=250$ stran -> E.',
            '15.2 Neprecteno $x$, precteno $1{,}5x$; $x+1{,}5x=500$, tj. $2{,}5x=500$, $x=200$. Protoze $200<210$ -> A.',
            '15.3 Nemecky $30$ knih je $10$ %, vsech knih je $300$. Anglicky je petina, tj. $60$ knih. Cesky je $300-30-60=210$ knih -> B.'],
     'ans':'15.1: E ($250$); 15.2: A (mene nez $210$, tj. $200$); 15.3: B ($210$)','pts':6,'mins':8,'diff':'3',
     'codes':B+['procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M7C 2023 - uloha 16','zad':[
        'Kazdy obrazec tvaru obdelniku je slozen z malych sedych ctverecku a vetsich bilych ctverecku. Vsechny sede ctverecky jsou stejne a jsou poskladany do spodni rady a do leveho sloupce. Zbytek obrazce tvori bile ctverecky. Kazdy bily ctverecek ma dvakrat delsi stranu nez sedy. Prvni obrazec ma ve spodni rade $5$ sedych ctverecku a v levem sloupci $3$ sede ctverecky. Sklada se celkem z $9$ ctverecku (bilych i sedych dohromady). Kazdy dalsi obrazec ma oproti predchozimu vzdy o $2$ sede ctverecky vice jak ve spodni rade, tak i v levem sloupci.',
        '16.1 Obrazec ma ve spodni rade $41$ sedych ctverecku. Urcete pocet bilych ctverecku v obrazci.',
        '16.2 V obrazci je $90$ bilych ctverecku. Urcete pocet sedych ctverecku v obrazci.',
        '16.3 Pocet vsech ctverecku (bilych i sedych dohromady) v poslednim a v predposlednim obrazci se lisi o $106$. Urcete pocet sedych ctverecku v poslednim obrazci.'],
     'opts':None,'ln':3,'svg':SVG16,'fn':'obrazce-ctverecky.svg',
     'alt':'Prvni obrazec (spodni rada 5, levy sloupec 3) a druhy obrazec (spodni rada 7, levy sloupec 5) ze sedych a bilych ctverecku.',
     'cap':'1. a 2. obrazec (schematicky nakres)',
     'sol':['V $n$-tem obrazci ma spodni rada $2n+3$ sedych a levy sloupec $2n+1$ sedych ctverecku; sedych je celkem $(2n+3)+(2n+1)-1=4n+3$. Bile ctverecky vyplnuji obdelnik o rozmerech $(2n+2)\\times 2n$ malych ctverecku, tj. $(n+1)\\cdot n$ bilych ctverecku. Vsech ctverecku je $(4n+3)+(n^2+n)=n^2+5n+3$.',
            '16.1 Ze spodni rady $2n+3=41$ plyne $n=19$; bilych je $(n+1)\\cdot n=20\\cdot 19=380$.',
            '16.2 Bilych $(n+1)\\cdot n=90$ dava $n=9$ (protoze $10\\cdot 9=90$); sedych je $4n+3=4\\cdot 9+3=39$.',
            '16.3 Rozdil poctu vsech ctverecku posledniho a predposledniho obrazce je $(n^2+5n+3)-((n-1)^2+5(n-1)+3)=2n+4$. Z $2n+4=106$ plyne $n=51$; sedych je $4\\cdot 51+3=207$.'],
     'ans':'16.1: $380$ bilych ctverecku; 16.2: $39$ sedych ctverecku; 16.3: $207$ sedych ctverecku','pts':4,'mins':8,'diff':'4',
     'codes':B+['posloupnosti','argumentace','pocetni','bez-kalkulacky','bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M7PCD23C0T03'
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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M7C-2023')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} uloh [{"OK" if sz<9000 else "PRES 9KB"}]')
    print('Celkem uloh:', tot)
