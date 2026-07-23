# -*- coding: utf-8 -*-
# CERMAT - Jednotna prijimaci zkouska 2026, MATEMATIKA 7A (sestilete obory, 7. rocnik),
# 1. radny termin. Kod testu: M7PAD26C0T01. 16 uloh, 50 bodu.
# Po rozdeleni izolovanych "Vypoctete" poduloh (uloha 2) je 17 uloh.
# Zdroj odpovedi: klic spravnych reseni (KSR), overeno vyplnenym zaznamovym archem (VZA).

# ---- SVG obrazky (bez ' a \) ----

# uloha 5: dva rovnoramenne trojuhelniky ABC a EFG (ilustrativni)
SVG5 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 380" font-family="sans-serif">
<polygon points="150,320 330,320 240,60" fill="none" stroke="#000" stroke-width="2"/>
<line x1="150" y1="320" x2="330" y2="320" stroke="#000" stroke-width="1.5" stroke-dasharray="5 5"/>
<polygon points="380,150 290,330 480,320" fill="none" stroke="#000" stroke-width="2"/>
<line x1="380" y1="150" x2="290" y2="330" stroke="#000" stroke-width="1.5" stroke-dasharray="5 5"/>
<text x="236" y="52" font-size="15" font-style="italic">C</text>
<text x="136" y="336" font-size="15" font-style="italic">A</text>
<text x="332" y="336" font-size="15" font-style="italic">B</text>
<text x="386" y="150" font-size="15" font-style="italic">E</text>
<text x="276" y="348" font-size="15" font-style="italic">F</text>
<text x="484" y="322" font-size="15" font-style="italic">G</text>
<text x="230" y="96" font-size="15" font-style="italic">&#947;</text>
<text x="296" y="308" font-size="12">78&#176;</text>
<text x="364" y="176" font-size="15" font-style="italic">&#969;</text>
<text x="306" y="320" font-size="15" font-style="italic">&#966;</text>
</svg>"""

# uloha 6: obdelnik 30x20 cm zaplneny ctverecky 1x1 cm (schematicky roh + tri tecky)
SVG6 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 300" font-family="sans-serif">
<rect x="60" y="50" width="300" height="200" fill="none" stroke="#000" stroke-width="2"/>
<g fill="none" stroke="#000">
<rect x="60" y="50" width="20" height="20"/><rect x="80" y="50" width="20" height="20"/><rect x="100" y="50" width="20" height="20"/>
<rect x="60" y="70" width="20" height="20"/><rect x="80" y="70" width="20" height="20"/>
<rect x="60" y="90" width="20" height="20"/>
</g>
<text x="150" y="66" font-size="18">&#8230;</text>
<text x="105" y="140" font-size="18">&#8230;</text>
<text x="28" y="64" font-size="12">1 cm</text>
<text x="210" y="278" font-size="13" text-anchor="middle">30 cm</text>
<text x="368" y="154" font-size="13">20 cm</text>
</svg>"""

# uloha 8: poloprimky AP, AQ a primka c kolma k AP (vychozi obrazek)
SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 430" font-family="sans-serif">
<rect x="8" y="8" width="604" height="414" fill="none" stroke="#ccc"/>
<line x1="120" y1="300" x2="565" y2="406" stroke="#000" stroke-width="2"/>
<line x1="120" y1="300" x2="380" y2="72" stroke="#000" stroke-width="2"/>
<line x1="525" y1="95" x2="430" y2="495" stroke="#000" stroke-width="2"/>
<text x="100" y="306" font-size="16" font-style="italic">A</text>
<text x="548" y="424" font-size="16" font-style="italic">P</text>
<text x="384" y="70" font-size="16" font-style="italic">Q</text>
<text x="530" y="90" font-size="16" font-style="italic">c</text>
<text x="360" y="96" font-size="14">&#215;</text>
<line x1="516" y1="386" x2="532" y2="392" stroke="#000" stroke-width="1.5"/>
</svg>"""

# uloha 9: body A, M v rovine (vychozi obrazek)
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 320" font-family="sans-serif">
<rect x="8" y="8" width="444" height="304" fill="none" stroke="#ccc"/>
<text x="252" y="152" font-size="16">&#215;</text><text x="262" y="146" font-size="15" font-style="italic">M</text>
<text x="168" y="236" font-size="16">&#215;</text><text x="168" y="258" font-size="15" font-style="italic">A</text>
</svg>"""

# uloha 10: 6 ornamentu A-F ve ctvercove siti (schematicke zastupne tvary)
def _ornaments():
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 320" font-family="sans-serif">']
    s.append('<g stroke="#e2e2e2" stroke-width="1">')
    for i in range(20):
        x = 20 + i * 30
        s.append(f'<line x1="{x}" y1="20" x2="{x}" y2="300"/>')
    for j in range(10):
        y = 20 + j * 30
        s.append(f'<line x1="20" y1="{y}" x2="590" y2="{y}"/>')
    s.append('</g>')
    s.append('<g fill="none" stroke="#000" stroke-width="2">')
    # A: tvar E (jedna vodorovna osa)
    s.append('<polyline points="135,55 70,55 70,125 135,125"/><line x1="70" y1="90" x2="120" y2="90"/>')
    # B: petiuhelnik dum (jedna svisla osa)
    s.append('<polygon points="270,110 330,110 330,72 300,50 270,72"/>')
    # C: sipka vzhuru (jedna svisla osa)
    s.append('<polygon points="500,50 522,120 500,102 478,120"/>')
    # D: obdelnik s uhloprickami (dve osy)
    s.append('<rect x="60" y="180" width="80" height="60"/><line x1="60" y1="180" x2="140" y2="240"/><line x1="140" y1="180" x2="60" y2="240"/>')
    # E: kruznice s vepsanym ctvercem (ctyri osy)
    s.append('<circle cx="300" cy="210" r="35"/><polygon points="300,175 335,210 300,245 265,210"/>')
    # F: dve pulkruznice tvaru S (zadna osa)
    s.append('<path d="M 465 210 A 17 17 0 0 1 499 210 A 17 17 0 0 0 533 210"/>')
    s.append('</g>')
    s.append('<g font-size="15" text-anchor="middle">')
    for lab, x, y in [('A',100,42),('B',300,42),('C',500,42),('D',100,296),('E',300,296),('F',500,296)]:
        s.append(f'<text x="{x}" y="{y}">{lab}</text>')
    s.append('</g></svg>')
    return "".join(s)
SVG10 = _ornaments()

# uloha 11: sloupcovy graf znamek (1..5 -> 6,5,2,3,4)
def _bars11():
    data = [(1,6),(2,5),(3,2),(4,3),(5,4)]
    x0, y0 = 60, 250; sc = 25; bw = 40; gap = 24
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 300" font-family="sans-serif">']
    s.append(f'<line x1="{x0}" y1="40" x2="{x0}" y2="{y0}" stroke="#000"/><line x1="{x0}" y1="{y0}" x2="380" y2="{y0}" stroke="#000"/>')
    for v in range(0, 9, 2):
        y = y0 - v * sc
        s.append(f'<line x1="{x0-4}" y1="{y}" x2="380" y2="{y}" stroke="#ddd"/><text x="{x0-8}" y="{y+4}" font-size="11" text-anchor="end">{v}</text>')
    x = x0 + gap
    for znamka, poc in data:
        h = poc * sc
        s.append(f'<rect x="{x}" y="{y0-h}" width="{bw}" height="{h}" fill="#c9c9c9" stroke="#000"/>')
        s.append(f'<text x="{x+bw/2}" y="{y0+16}" font-size="12" text-anchor="middle">{znamka}</text>')
        x += bw + gap
    s.append('<text x="220" y="284" font-size="12" text-anchor="middle">Znamka z testu</text>')
    s.append('<text x="18" y="150" font-size="12" text-anchor="middle" transform="rotate(-90 18 150)">Pocet znamek</text>')
    s.append('</svg>')
    return "".join(s)
SVG11 = _bars11()

# ulohy 13-14: papir s odstrizenymi ctverci a slozena krabicka (kvadr)
SVG1314 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 240" font-family="sans-serif">
<text x="135" y="22" font-size="12" text-anchor="middle">Papir s odstrizenymi ctverci</text>
<text x="415" y="22" font-size="12" text-anchor="middle">Slozena krabicka</text>
<rect x="60" y="50" width="160" height="120" fill="none" stroke="#999" stroke-width="1" stroke-dasharray="3 3"/>
<polygon points="80,50 200,50 200,70 220,70 220,150 200,150 200,170 80,170 80,150 60,150 60,70 80,70" fill="#d8d8d8" stroke="#000" stroke-width="1.5"/>
<text x="140" y="196" font-size="13" font-style="italic">a</text>
<text x="230" y="114" font-size="13" font-style="italic">b</text>
<text x="196" y="132" font-size="13" font-style="italic">c</text>
<g fill="none" stroke="#000" stroke-width="1.5">
<polygon points="330,120 460,120 460,160 330,160"/>
<polyline points="330,120 358,100 488,100 460,120"/>
<line x1="488" y1="100" x2="488" y2="140"/>
<line x1="460" y1="160" x2="488" y2="140"/>
</g>
<text x="378" y="178" font-size="13" font-style="italic">a = 14 cm</text>
<text x="474" y="128" font-size="13" font-style="italic">b</text>
<text x="497" y="126" font-size="13" font-style="italic">c</text>
</svg>"""

# uloha 16: 1., 2. a 3. obrazec - soustredne kruznice a rovnobezne primky s puntiky
def _obrazce():
    import math
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 240" font-family="sans-serif">']
    cy = 130; u = 18
    for cx, label, n in [(90,'1. obrazec',1),(250,'2. obrazec',2),(430,'3. obrazec',3)]:
        for r in range(1, n+1):
            s.append(f'<circle cx="{cx}" cy="{cy}" r="{u*r}" fill="none" stroke="#000"/>')
        for r in range(1, n+1):
            lx = cx + u*r
            s.append(f'<line x1="{lx}" y1="{cy-72}" x2="{lx}" y2="{cy+72}" stroke="#000"/>')
            for R in range(r, n+1):
                if R == r:
                    s.append(f'<circle cx="{lx}" cy="{cy}" r="3" fill="#000"/>')
                else:
                    dy = round(u*math.sqrt(R*R - r*r), 1)
                    s.append(f'<circle cx="{lx}" cy="{cy-dy}" r="3" fill="#000"/>')
                    s.append(f'<circle cx="{lx}" cy="{cy+dy}" r="3" fill="#000"/>')
        s.append(f'<text x="{cx}" y="24" font-size="12" text-anchor="middle">{label}</text>')
    s.append('<text x="558" y="136" font-size="20">&#8230;</text></svg>')
    return "".join(s)
SVG16 = _obrazce()

B = ['zs2', 'r7']  # 7. rocnik ZS (sestilete obory), stupen zs2 + rocnik r7

PROBLEMS = [
    {'name':'CERMAT M7A 2026 - uloha 1','zad':[
        'Veslarka trenuje na trenazeru a udrzuje stale stejne tempo. Na displeji vidi, ze za 1 minutu a 30 sekund ujela na trenazeru 350 m.',
        'Vypoctete v metrech vzdalenost, kterou veslarka pri danem tempu ujede na trenazeru za 6 minut.'],
     'opts':None,'ln':2,
     'sol':['Za 1 minutu a 30 sekund (tj. 90 s) ujede 350 m. 6 minut je 4-krat vice nez 90 s, proto ujede $4\\cdot 350=1400$ m.'],
     'ans':'$1400$ metru','pts':1,'mins':2,'diff':'2',
     'codes':B+['aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M7A 2026 - uloha 2.1','zad':[
        'Vypoctete a vysledek zapiste zlomkem v zakladnim tvaru.',
        '$3{,}6\\cdot\\left(\\frac{7}{12}-\\frac{5}{9}\\right)-1=$'],
     'opts':None,'ln':3,
     'sol':['$\\frac{7}{12}-\\frac{5}{9}=\\frac{21}{36}-\\frac{20}{36}=\\frac{1}{36}$; $3{,}6\\cdot\\frac{1}{36}=\\frac{1}{10}$; $\\frac{1}{10}-1=-\\frac{9}{10}$.'],
     'ans':'$-\\frac{9}{10}$','pts':2,'mins':3,'diff':'2',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7A 2026 - uloha 2.2','zad':[
        'Vypoctete a vysledek zapiste zlomkem v zakladnim tvaru.',
        '$\\frac{2-\\frac{10}{7}}{2:\\frac{5}{7}-\\frac{2}{5}}=$'],
     'opts':None,'ln':3,
     'sol':['Citatel: $2-\\frac{10}{7}=\\frac{14}{7}-\\frac{10}{7}=\\frac{4}{7}$. Jmenovatel: $2:\\frac{5}{7}-\\frac{2}{5}=\\frac{14}{5}-\\frac{2}{5}=\\frac{12}{5}$. Podil: $\\frac{4}{7}:\\frac{12}{5}=\\frac{4}{7}\\cdot\\frac{5}{12}=\\frac{5}{21}$.'],
     'ans':'$\\frac{5}{21}$','pts':2,'mins':4,'diff':'3',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7A 2026 - uloha 3','zad':[
        'Zapiste vsechny dvojice ruznych prvocisel, jejichz soucet je 24.'],
     'opts':None,'ln':3,
     'sol':['Rozklady cisla 24 na soucet dvou ruznych prvocisel: $5+19$, $7+17$, $11+13$. (Dvojice $1$ a $23$ se nepovazuje za reseni, protoze $1$ neni prvocislo.)'],
     'ans':'$5$ a $19$; $7$ a $17$; $11$ a $13$','pts':3,'mins':4,'diff':'3',
     'codes':B+['aritmetika','argumentace','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7A 2026 - uloha 4','zad':[
        'V aquaparku ziskavaji deti v plaveckych soutezich zetony, za ktere mohou koupit volne jizdy na tobogánu nebo na clunu po divoke rece, avsak pouze podle nasledujicich dvou pravidel: za 4 zetony se kupuji 3 jizdy na tobogánu, za 15 zetonu se kupuji 2 jizdy na clunu.',
        '4.1 Petr ziskal 70 zetonu. Za vsechny tyto zetony koupil 4 jizdy na clunu a urcity pocet jizd na tobogánu. Urcete, kolik jizd na tobogánu Petr koupil.',
        '4.2 Nela za vsechny sve ziskane zetony koupila nekolik jizd na clunu a dvakrat tolik jizd na tobogánu. Urcete nejmensi mozny pocet zetonu, ktere musela Nela ziskat.'],
     'opts':None,'ln':4,
     'sol':['4.1 Za 4 jizdy na clunu zaplati Petr $2\\cdot 15=30$ zetonu. Zbyva $70-30=40$ zetonu na tobogán, tj. $\\frac{40}{4}\\cdot 3=30$ jizd na tobogánu.',
            '4.2 Jizdy na clunu jsou po 2 (za 15 zetonu), jizdy na tobogánu po 3 (za 4 zetony). Nela koupila $c$ jizd na clunu a $2c$ na tobogánu; $c$ musi byt sude a soucasne $2c$ delitelne 3, tedy $c$ delitelne 6. Nejmensi $c=6$: clun $6$ jizd $=3\\cdot 15=45$ zetonu, tobogán $12$ jizd $=4\\cdot 4=16$ zetonu, celkem $45+16=61$ zetonu.'],
     'ans':'4.1: $30$ jizd na tobogánu; 4.2: $61$ zetonu','pts':3,'mins':6,'diff':'3',
     'codes':B+['aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M7A 2026 - uloha 5','zad':[
        'Na obrazku jsou dva rovnoramenne trojuhelniky $ABC$ a $EFG$. Jejich zakladny $AB$ a $EF$ jsou vyznaceny carkovane. Strany $AB$ a $FG$ jsou navzajem rovnobezne, stejne jako strany $BC$ a $EG$. Velikosti nekterych uhlu jsou uvedeny v obrazku.',
        'Urcete ve stupnich velikost uhlu $\\gamma$ (5.1), $\\varphi$ (5.2) a $\\omega$ (5.3).',
        'Velikosti uhlu nemerte, ale vypoctete (obrazek je pouze ilustrativni).'],
     'opts':None,'ln':3,'svg':SVG5,'fn':'trojuhelniky-uhly.svg',
     'alt':'Dva rovnoramenne trojuhelniky ABC a EFG se spolecne oznacenymi uhly gama, fi, omega a uhlem 78 stupnu.','cap':'Vychozi obrazek k uloze 5 (ilustrativni)',
     'sol':['5.1 Trojuhelnik $ABC$ je rovnoramenny se zakladnou $AB$, uhel pri zakladne je $78^\\circ$, proto $\\gamma=180^\\circ-2\\cdot 78^\\circ=24^\\circ$.',
            '5.2 Protoze $FG\\parallel AB$ a $EG\\parallel BC$, ma uhel $EGF$ stejnou velikost jako uhel $ABC$, tj. $78^\\circ$. Trojuhelnik $EFG$ je rovnoramenny se zakladnou $EF$, proto $\\varphi=(180^\\circ-78^\\circ):2=51^\\circ$.',
            '5.3 Uhel $\\omega$ je vedlejsi k zakladnovemu uhlu pri vrcholu $E$ (velikost $51^\\circ$), proto $\\omega=180^\\circ-51^\\circ=129^\\circ$.'],
     'ans':'5.1: $\\gamma=24^\\circ$; 5.2: $\\varphi=51^\\circ$; 5.3: $\\omega=129^\\circ$','pts':4,'mins':6,'diff':'3',
     'codes':B+['planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7A 2026 - uloha 6','zad':[
        'Matej mel cervene, modre, zelene a zlute samolepici ctverecky o strane delky 1 cm. Vsemi temito ctverecky presne zaplnil cely obdelnik o rozmerech 20 cm a 30 cm. (Nalepene ctverecky se neprekryvaji a nejsou mezi nimi zadne mezery.)',
        'Ze vsech nalepenych ctverecku je petina cervenych a ze zbyvajicich ctverecku je tretina modrych. Zelenych ctverecku je o 20 mene nez zlutych.',
        '6.1 Vypoctete, kolik cervenych a modrych ctverecku dohromady Matej nalepil.',
        '6.2 Vyjadrete zlomkem v zakladnim tvaru, jakou cast obdelniku zaplnily zelene ctverecky.'],
     'opts':None,'ln':3,'svg':SVG6,'fn':'obdelnik-ctverecky.svg',
     'alt':'Obdelnik 30 krat 20 cm castecne zaplneny ctverecky 1 krat 1 cm v levem hornim rohu, se treni teckami naznacujicimi pokracovani.','cap':'Schematicky nakres (rozmery dle zadani)',
     'sol':['Celkem je $20\\cdot 30=600$ ctverecku.',
            '6.1 Cervenych je $\\frac{1}{5}\\cdot 600=120$. Ze zbyvajicich $600-120=480$ je modrych $\\frac{1}{3}\\cdot 480=160$. Dohromady $120+160=280$ ctverecku.',
            '6.2 Zelene a zlute dohromady $480-160=320$. Zelenych $z$, zlutych $z+20$: $z+(z+20)=320\\Rightarrow z=150$. Cast obdelniku $\\frac{150}{600}=\\frac{1}{4}$.'],
     'ans':'6.1: $280$ ctverecku; 6.2: $\\frac{1}{4}$','pts':4,'mins':6,'diff':'3',
     'codes':B+['aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M7A 2026 - uloha 7','zad':[
        'V pekarne pecou vsechny babovky podle stejneho receptu. Podle tohoto receptu spotrebuji na kazdych 6 babovek 840 g cukru.',
        '7.1 Vypoctete, kolik gramu cukru spotrebuji v pekarne na 21 babovek.',
        '7.2 Vypoctete, na kolik babovek v pekarne spotrebuji presne 7 kg cukru.',
        '7.3 Na kazdou vanocku spotrebuji v pekarne o 25 % mene cukru nez na babovku. Na vsechny vanocky spotrebovali v pekarne tolik cukru jako na 27 babovek. Vypoctete, kolik vanocek v pekarne upekli.'],
     'opts':None,'ln':4,
     'sol':['Na 1 babovku pripada $840:6=140$ g cukru.',
            '7.1 $21\\cdot 140=2940$ g cukru.',
            '7.2 $7$ kg $=7000$ g; $7000:140=50$ babovek.',
            '7.3 Na 1 vanocku $140\\cdot 0{,}75=105$ g cukru. Na 27 babovek je $27\\cdot 140=3780$ g; pocet vanocek $3780:105=36$.'],
     'ans':'7.1: $2940$ gramu; 7.2: $50$ babovek; 7.3: $36$ vanocek','pts':4,'mins':7,'diff':'3',
     'codes':B+['aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M7A 2026 - uloha 8 (konstrukce)','zad':[
        'V rovine lezi poloprimky $AP$, $AQ$ a primka $c$ kolma k poloprimce $AP$ (viz obrazek).',
        'Bod $A$ je vrchol rovnobezniku $ABCD$. Na poloprimce $AP$ lezi vrchol $B$ tohoto rovnobezniku, na poloprimce $AQ$ vrchol $D$ a na primce $c$ vrchol $C$. Vyska na stranu $AB$ rovnobezniku $ABCD$ meri 4 cm.',
        'Sestrojte vrcholy $B$, $C$, $D$ rovnobezniku $ABCD$, oznacte je pismeny a rovnobeznik narysujte.'],
     'opts':None,'ln':0,'svg':SVG8,'fn':'poloprimky-AP-AQ-c.svg',
     'alt':'Poloprimky AP a AQ z bodu A a primka c kolma k poloprimce AP.','cap':'Vychozi obrazek k uloze 8',
     'sol':['Strana $AB$ lezi na poloprimce $AP$. Vyska na $AB$ je vzdalenost strany $DC$ od primky $AB$, tedy 4 cm. Vrcholy $D$ a $C$ proto lezi na rovnobezce $r$ s poloprimkou $AP$ ve vzdalenosti 4 cm (na strane, kde je bod $Q$).',
            'Vrchol $D$ je prusecik rovnobezky $r$ s poloprimkou $AQ$. Vrchol $C$ je prusecik primky $c$ s rovnobezkou $r$ (v rovnobezniku je $DC\\parallel AB$). Vrchol $B$ lezi na poloprimce $AP$ tak, aby $ABCD$ byl rovnobeznik, tj. $|AB|=|DC|$ a $AB\\parallel DC$.'],
     'ans':'Konstrukce rovnobezniku $ABCD$: vrcholy $D$ a $C$ lezi na rovnobezce s $AP$ ve vzdalenosti 4 cm ($D$ na poloprimce $AQ$, $C$ na primce $c$), vrchol $B$ na poloprimce $AP$ tak, aby $ABCD$ byl rovnobeznik. Viz obrazek v klici.',
     'pts':2,'mins':6,'diff':'3','codes':B+['konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7A 2026 - uloha 9 (konstrukce)','zad':[
        'V rovine lezi body $A$, $M$ (viz obrazek).',
        'Body $A$, $M$ jsou vrcholy rovnostranneho trojuhelniku $AMC$. Body $A$, $C$ jsou zaroven vrcholy trojuhelniku $ABC$. Bod $M$ lezi uvnitr strany $BC$ trojuhelniku $ABC$ a strana $BC$ je dvakrat delsi nez strana $AC$.',
        'Sestrojte vrcholy $B$, $C$ trojuhelniku $ABC$, oznacte je pismeny a trojuhelnik narysujte. Najdete vsechna reseni.'],
     'opts':None,'ln':0,'svg':SVG9,'fn':'body-AM.svg',
     'alt':'Body A a M v rovine.','cap':'Vychozi obrazek k uloze 9',
     'sol':['Sestrojime rovnostranny trojuhelnik $AMC$: vrchol $C$ je prusecik kruznic se stredy $A$ a $M$ a polomerem $|AM|$. Existuji dve polohy $C_1$, $C_2$.',
            'Protoze $|MC|=|AC|$ a $|BC|=2|AC|$, je bod $M$ stred strany $BC$; vrchol $B$ lezi na poloprimce $CM$ za bodem $M$ ve vzdalenosti $|CM|$. Uloha ma dve reseni.'],
     'ans':'Dve reseni: rovnostranny trojuhelnik $AMC$ (dve polohy $C_1$, $C_2$), $M$ je stred strany $BC$, $|BC|=2|AC|$. Viz obrazek v klici.',
     'pts':3,'mins':7,'diff':'4','codes':B+['konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7A 2026 - uloha 10','zad':[
        'Ve ctvercove siti je zakresleno 6 ornamentu oznacenych pismeny A az F. Kruznice v ornamentu E ma stred v mrizovem bode a prochazi ctyrmi mrizovymi body. Kazda pulkruznice v ornamentu F ma stred i krajni body v mrizovych bodech. Ostatni utvary ve vsech ornamentech maji vrcholy v mrizovych bodech.',
        'Rozhodnete o kazdem z nasledujicich tvrzeni (10.1-10.3), zda je pravdive (A), ci nikoli (N).',
        '10.1 Ornament E ma celkem 2 osy soumernosti.',
        '10.2 Kazdy z ornamentu A, B, C a D ma jen jednu osu soumernosti.',
        '10.3 Primek, ktere jsou osami soumernosti jednotlivych ornamentu A az F, je dohromady presne 9.'],
     'opts':None,'ln':0,'svg':SVG10,'fn':'ornamenty.svg',
     'alt':'Sest ornamentu A az F ve ctvercove siti - schematicke zastupne tvary.','cap':'Schematicky nakres ornamentu A az F',
     'sol':['10.1 Ornament E (kruznice s vepsanym ctvercem) ma 4 osy soumernosti, ne 2 - nepravdive (N).',
            '10.2 Ornament D (obdelnik s uhloprickami) ma 2 osy soumernosti, takze tvrzeni, ze kazdy z A, B, C, D ma jen jednu osu, je nepravdive (N).',
            '10.3 Pocty os: A $1$, B $1$, C $1$, D $2$, E $4$, F $0$; dohromady $1+1+1+2+4+0=9$ - pravdive (A).'],
     'ans':'10.1: N; 10.2: N; 10.3: A','pts':4,'mins':6,'diff':'3',
     'codes':B+['planimetrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7A 2026 - uloha 11','zad':[
        'Vsichni zaci 7. A psali test z matematiky. V grafu jsou uvedeny pocty jednotlivych znamek, ktere tito zaci z testu ziskali.',
        'Jaky je aritmeticky prumer ziskanych znamek?'],
     'opts':['A) $2{,}7$','B) $3{,}0$','C) $3{,}7$','D) $4{,}0$','E) jiny prumer'],'ln':0,'svg':SVG11,'fn':'graf-znamky.svg',
     'alt':'Sloupcovy graf poctu znamek: znamka 1 sestkrat, 2 petkrat, 3 dvakrat, 4 trikrat, 5 ctyrikrat.','cap':'Pocty jednotlivych znamek z testu',
     'sol':['Pocty znamek: $1\\to 6$, $2\\to 5$, $3\\to 2$, $4\\to 3$, $5\\to 4$; celkem $20$ zaku. Soucet znamek $1\\cdot 6+2\\cdot 5+3\\cdot 2+4\\cdot 3+5\\cdot 4=54$. Prumer $54:20=2{,}7$.'],
     'ans':'A) $2{,}7$','pts':2,'mins':3,'diff':'2',
     'codes':B+['statistika','vypocet','pocetni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M7A 2026 - uloha 12','zad':[
        'Zaci se na skolnim sportovnim dni rozdelili do tri skupin A, B, C. (Pocet zaku ve skupinach A, B a C oznacime ve stejnem poradi pismeny $A$, $B$ a $C$.) Pro pocty zaku plati pomery $A:B=7:9$ a $B:C=4:7$. Ve skupine B je o 16 zaku vice nez ve skupine A.',
        'O kolik se lisi pocet zaku ve skupine B a ve skupine C?'],
     'opts':['A) o 24 zaku','B) o 48 zaku','C) o 54 zaku','D) o 72 zaku','E) o jiny pocet zaku'],'ln':0,
     'sol':['Sjednotime pomery pres $B$: $A:B=28:36$ a $B:C=36:63$, tedy $A:B:C=28:36:63$. Rozdil $B-A=8$ dilu $=16$ zaku, tj. $1$ dil $=2$ zaci. Rozdil $C-B=63-36=27$ dilu $=54$ zaku.'],
     'ans':'C) o 54 zaku','pts':2,'mins':5,'diff':'3',
     'codes':B+['aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M7A 2026 - uloha 13','zad':[
        'Tvrdy papir tvaru obdelniku ma obsah 198 cm². Z rohu tohoto papiru odstrihneme ctyri shodne ctverce, cimz se jeho obsah zmensi o 16 cm². Potom z papiru slozime krabicku tvaru kvadru, jehoz nejdelsi hrana meri 14 cm (viz obrazek). Tloustku papiru neuvazujte.',
        'Jakou delku mela delsi strana papiru pred odstrizenim ctvercu?'],
     'opts':['A) 16 cm','B) 18 cm','C) 20 cm','D) 22 cm','E) jinou delku'],'ln':0,'svg':SVG1314,'fn':'papir-krabicka.svg',
     'alt':'Papir tvaru krize po odstrizeni ctyr rohovych ctvercu a slozena krabicka tvaru kvadru s hranou a rovnou 14 cm.','cap':'Papir s odstrizenymi ctverci a slozena krabicka',
     'sol':['Ctyri shodne ctverce maji obsah $16$ cm², tj. jeden ctverec $4$ cm², jeho strana $c=2$ cm. Dno krabicky ma rozmery $a\\times b$, vyska $c=2$ cm; nejdelsi hrana $a=14$ cm. Delsi strana papiru $=a+2c=14+4=18$ cm.'],
     'ans':'B) 18 cm','pts':2,'mins':5,'diff':'3',
     'codes':B+['planimetrie','vypocet','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M7A 2026 - uloha 14','zad':[
        'Tvrdy papir tvaru obdelniku ma obsah 198 cm². Z rohu tohoto papiru odstrihneme ctyri shodne ctverce, cimz se jeho obsah zmensi o 16 cm². Potom z papiru slozime krabicku tvaru kvadru, jehoz nejdelsi hrana meri 14 cm (viz obrazek). Tloustku papiru neuvazujte.',
        'Jaky je objem krabicky?'],
     'opts':['A) 168 cm³','B) 196 cm³','C) 308 cm³','D) 396 cm³','E) jiny objem'],'ln':0,'svg':SVG1314,'fn':'papir-krabicka.svg',
     'alt':'Papir tvaru krize po odstrizeni ctyr rohovych ctvercu a slozena krabicka tvaru kvadru s hranou a rovnou 14 cm.','cap':'Papir s odstrizenymi ctverci a slozena krabicka',
     'sol':['Strana odstrizenych ctvercu $c=2$ cm. Delsi strana papiru $18$ cm, kratsi $198:18=11$ cm. Dno krabicky $a=18-4=14$ cm, $b=11-4=7$ cm, vyska $c=2$ cm. Objem $14\\cdot 7\\cdot 2=196$ cm³.'],
     'ans':'B) 196 cm³','pts':2,'mins':3,'diff':'2',
     'codes':B+['stereometrie','vypocet','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M7A 2026 - uloha 15','zad':[
        'Brigadnici presadili v zahradnictvi vsechny sazenice rajcat za tri dny. Po prvnim dni zbyvalo k presazeni jeste 60 % vsech sazenic rajcat. Po druhem dni byl celkovy pocet presazenych sazenic rajcat o polovinu vetsi nez po prvnim dni. Treti den bylo presazeno zbyvajicich 216 sazenic rajcat. Brigadnice Jarka presadila za uvedene tri dny celkem 162 sazenic rajcat.',
        'Priradte ke kazde otazce (15.1-15.3) spravnou odpoved (A-F). Kolik procent z celkoveho poctu sazenic rajcat...',
        '15.1 bylo presazeno druhy den?',
        '15.2 bylo presazeno treti den?',
        '15.3 presadila brigadnice Jarka?'],
     'opts':['A) 20 %','B) 25 %','C) 30 %','D) 35 %','E) 40 %','F) jiny pocet procent'],'ln':0,
     'sol':['Po 1. dni presazeno $100\\,\\%-60\\,\\%=40\\,\\%$. Po 2. dni celkem $1{,}5\\cdot 40\\,\\%=60\\,\\%$.',
            '15.1 Druhy den $60\\,\\%-40\\,\\%=20\\,\\%$ -> A.',
            '15.2 Treti den zbyvajicich $100\\,\\%-60\\,\\%=40\\,\\%$ -> E. (Odpovida $216$ sazenicim, celkem $216:0{,}4=540$ sazenic.)',
            '15.3 Jarka $\\frac{162}{540}=0{,}3=30\\,\\%$ -> C.'],
     'ans':'15.1: A (20 %); 15.2: E (40 %); 15.3: C (30 %)','pts':6,'mins':9,'diff':'4',
     'codes':B+['procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M7A 2026 - uloha 16','zad':[
        'V prvnim obrazci je nakreslena jedna kruznice a jedna primka, ktera ma s touto kruznici prave jeden spolecny bod. V kazdem dalsim obrazci pribude jedna kruznice a jedna primka. Vsechny kruznice maji stred ve stejnem bode, ale kazda nova kruznice ma vetsi polomer nez ta predchozi. Vsechny primky jsou navzajem rovnobezne a kazda nova primka ma prave jeden spolecny bod s novou kruznici. V kazdem spolecnem bode primky a kruznice je puntik (viz obrazek). Napr. ve tretim obrazci je 9 puntiku.',
        '16.1 Urcete, kolik puntiku je v 5. obrazci.',
        '16.2 Urcete, o kolik se lisi pocet vsech puntiku v 8. obrazci a v 9. obrazci.',
        '16.3 Urcete, v kolikatem obrazci je o 171 puntiku vice nez v predchozim obrazci.'],
     'opts':None,'ln':3,'svg':SVG16,'fn':'obrazce-puntiky.svg',
     'alt':'1., 2. a 3. obrazec: soustredne kruznice a rovnobezne primky s puntiky ve spolecnych bodech.','cap':'1., 2. a 3. obrazec',
     'sol':['V $n$-tem obrazci je puntiku $1+3+5+\\dots+(2n-1)=n^2$ (3. obrazec: $9=3^2$).',
            '16.1 $5^2=25$ puntiku.',
            '16.2 $9^2-8^2=81-64=17$ puntiku.',
            '16.3 $n^2-(n-1)^2=2n-1=171\\Rightarrow n=86$; v 86. obrazci.'],
     'ans':'16.1: $25$ puntiku; 16.2: o $17$ puntiku; 16.3: v $86.$ obrazci','pts':4,'mins':6,'diff':'3',
     'codes':B+['posloupnosti','argumentace','pocetni','bez-kalkulacky','bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M7PAD26C0T01'
    gen.YEAR = 2026

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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M7A-2026')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} uloh [{"OK" if sz<9000 else "PRES 9KB"}]')
    print('Celkem uloh:', tot)
