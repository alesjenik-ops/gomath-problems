# -*- coding: utf-8 -*-
# CERMAT - Jednotna prijimaci zkouska 2024, MATEMATIKA 7 (sestilete obory, 7. rocnik).
# Kod testu: M7PDD24C0T04. 16 uloh (po rozdeleni nezavislych poduloh 18 uloh).
# Zdroj odpovedi: klic spravnych reseni (KSR). Nazev prefixu: CERMAT M7D 2024.

# ---- SVG obrazky (bez ' a \) ----

# uloha 7: sdruzeny sloupcovy graf odpracovanych hodin (kadernice sede, pedikerka bile)
def _graf7():
    days = [("pondeli",6,4),("utery",8,3),("streda",6,4),("ctvrtek",None,3),("patek",7,4),("sobota",4,4)]
    x0, ytop, ybot, unit = 60, 20, 290, 30
    bw, gap, groupw = 22, 6, 70
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 330" font-family="sans-serif">']
    s.append(f'<line x1="{x0}" y1="{ytop}" x2="{x0}" y2="{ybot}" stroke="#000"/>')
    s.append(f'<line x1="{x0}" y1="{ybot}" x2="500" y2="{ybot}" stroke="#000"/>')
    for v in range(0,10):
        y = ybot - v*unit
        s.append(f'<line x1="{x0-4}" y1="{y}" x2="{x0}" y2="{y}" stroke="#000"/>')
        s.append(f'<text x="{x0-8}" y="{y+4}" font-size="11" text-anchor="end">{v}</text>')
    x = x0 + 18
    for name, k, p in days:
        if k is not None:
            h = k*unit
            s.append(f'<rect x="{x}" y="{ybot-h}" width="{bw}" height="{h}" fill="#b8b8b8" stroke="#000"/>')
        else:
            s.append(f'<text x="{x+11}" y="{ybot-10}" font-size="16" text-anchor="middle">?</text>')
        hp = p*unit
        xp = x + bw + gap
        s.append(f'<rect x="{xp}" y="{ybot-hp}" width="{bw}" height="{hp}" fill="#ffffff" stroke="#000"/>')
        s.append(f'<text x="{x+25}" y="{ybot+16}" font-size="11" text-anchor="middle">{name}</text>')
        x += groupw
    s.append('<rect x="350" y="24" width="12" height="12" fill="#b8b8b8" stroke="#000"/><text x="368" y="34" font-size="11">kadernice</text>')
    s.append('<rect x="440" y="24" width="12" height="12" fill="#ffffff" stroke="#000"/><text x="458" y="34" font-size="11">pedikerka</text>')
    s.append('</svg>')
    return "".join(s)
SVG7 = _graf7()

# uloha 8: vychozi obrazek - primka p a bod A lezici mimo p
SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif">
<line x1="40" y1="240" x2="420" y2="120" stroke="#000" stroke-width="2"/>
<text x="404" y="112" font-size="16" font-style="italic">p</text>
<text x="205" y="150" font-size="15" font-style="italic" text-anchor="middle">A</text>
<text x="205" y="166" font-size="15" text-anchor="middle">x</text>
</svg>"""

# uloha 9: vychozi obrazek - body A a D
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 300" font-family="sans-serif">
<text x="150" y="118" font-size="15" font-style="italic" text-anchor="middle">D</text>
<text x="150" y="134" font-size="15" text-anchor="middle">x</text>
<text x="240" y="196" font-size="15" text-anchor="middle">x</text>
<text x="240" y="214" font-size="15" font-style="italic" text-anchor="middle">A</text>
</svg>"""

# uloha 11: tri obrazce z obdelniku, ctvercu a rovnoramennych trojuhelniku (schematicky)
SVG11 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 260" font-family="sans-serif">
<text x="72" y="40" font-size="12" text-anchor="middle">1. obrazec</text>
<rect x="24" y="195" width="96" height="48" fill="none" stroke="#000"/>
<polygon points="24,195 72,195 48,141" fill="none" stroke="#000"/>
<polygon points="72,195 120,195 96,141" fill="none" stroke="#000"/>
<text x="290" y="40" font-size="12" text-anchor="middle">2. obrazec</text>
<rect x="266" y="147" width="48" height="96" fill="none" stroke="#000"/>
<rect x="266" y="99" width="48" height="48" fill="none" stroke="#000"/>
<polygon points="266,99 314,99 290,55" fill="none" stroke="#000"/>
<text x="470" y="40" font-size="12" text-anchor="middle">3. obrazec</text>
<rect x="422" y="195" width="96" height="48" fill="none" stroke="#000"/>
<rect x="422" y="147" width="48" height="48" fill="none" stroke="#000"/>
<rect x="470" y="147" width="48" height="48" fill="none" stroke="#000"/>
<polygon points="422,147 470,147 446,103" fill="none" stroke="#000"/>
<polygon points="470,147 518,147 494,103" fill="none" stroke="#000"/>
</svg>"""

# uloha 13: rovnobezky a, b a primky c, d, e s vyznacenymi uhly (ilustracni)
SVG13 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 300" font-family="sans-serif">
<line x1="40" y1="95" x2="430" y2="95" stroke="#000" stroke-width="1.5"/>
<text x="440" y="99" font-size="15" font-style="italic">b</text>
<line x1="40" y1="235" x2="452" y2="235" stroke="#000" stroke-width="1.5"/>
<text x="460" y="239" font-size="15" font-style="italic">a</text>
<line x1="120" y1="235" x2="300" y2="40" stroke="#000"/>
<line x1="230" y1="235" x2="270" y2="40" stroke="#000"/>
<line x1="360" y1="235" x2="210" y2="40" stroke="#000"/>
<text x="256" y="90" font-size="13" font-style="italic">B</text>
<text x="214" y="46" font-size="14" font-style="italic">e</text>
<text x="262" y="46" font-size="14" font-style="italic">d</text>
<text x="300" y="52" font-size="14" font-style="italic">c</text>
<text x="243" y="80" font-size="13">a</text>
<text x="252" y="122" font-size="13">b</text>
<text x="128" y="226" font-size="12">38</text>
<text x="226" y="258" font-size="12">75</text>
<text x="330" y="226" font-size="12">110</text>
</svg>"""

# uloha 14: ciselna osa se shodnymi dilky, body D, C, B, A (zleva doprava)
def _osa14():
    xs = [60,104,148,192,236,280,324,368]
    s = ['<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 130" font-family="sans-serif">']
    s.append('<line x1="24" y1="60" x2="416" y2="60" stroke="#000" stroke-width="1.5"/>')
    s.append('<polygon points="416,60 406,56 406,64" fill="#000"/>')
    s.append('<polygon points="24,60 34,56 34,64" fill="#000"/>')
    for x in xs:
        s.append(f'<line x1="{x}" y1="52" x2="{x}" y2="68" stroke="#000"/>')
    for x,lab in [(60,"D"),(236,"C"),(280,"B"),(368,"A")]:
        s.append(f'<text x="{x}" y="92" font-size="15" text-anchor="middle" font-style="italic">{lab}</text>')
    s.append('</svg>')
    return "".join(s)
SVG14 = _osa14()

# uloha 16: podstavy tri hranolu (ctverec, trojuhelnik, kosodelnik) s rozmery
SVG16 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 230" font-family="sans-serif">
<text x="90" y="28" font-size="12" text-anchor="middle">1. hranol</text>
<rect x="50" y="66" width="80" height="80" fill="none" stroke="#000"/>
<text x="40" y="110" font-size="13" font-style="italic" text-anchor="end">a</text>
<text x="90" y="162" font-size="13" font-style="italic" text-anchor="middle">a</text>
<text x="90" y="196" font-size="11" text-anchor="middle">a = 4 cm</text>
<text x="290" y="28" font-size="12" text-anchor="middle">2. hranol</text>
<polygon points="230,146 350,146 290,56" fill="none" stroke="#000"/>
<line x1="290" y1="146" x2="290" y2="56" stroke="#000" stroke-dasharray="4 4"/>
<text x="250" y="102" font-size="13" font-style="italic">c</text>
<text x="324" y="102" font-size="13" font-style="italic">b</text>
<text x="290" y="164" font-size="13" font-style="italic" text-anchor="middle">a</text>
<text x="298" y="120" font-size="11">va</text>
<text x="290" y="196" font-size="11" text-anchor="middle">a = 6, b = 5, c = 5, va = 4 cm</text>
<text x="480" y="28" font-size="12" text-anchor="middle">3. hranol</text>
<polygon points="430,146 510,146 540,86 460,86" fill="none" stroke="#000"/>
<line x1="510" y1="146" x2="510" y2="86" stroke="#000" stroke-dasharray="4 4"/>
<text x="470" y="164" font-size="13" font-style="italic" text-anchor="middle">a</text>
<text x="536" y="120" font-size="13" font-style="italic">b</text>
<text x="516" y="120" font-size="11">va</text>
<text x="480" y="196" font-size="11" text-anchor="middle">a = 6, b = 4, va = 3 cm</text>
</svg>"""

B = ['zs2', 'r7']  # 7. rocnik (sestilete obory)

PROBLEMS = [
    {'name':'CERMAT M7D 2024 – úloha 1','zad':[
        'Zapište zlomkem v základním tvaru, jakou část metru tvoří $40\\,\\%$ z poloviny metru.'],
     'opts':None,'ln':2,
     'sol':['$40\\,\\%$ z poloviny metru je $0{,}4\\cdot\\frac{1}{2}\\text{ m}=\\frac{2}{5}\\cdot\\frac{1}{2}\\text{ m}=\\frac{1}{5}\\text{ m}$. Hledaná část metru je $\\frac{1}{5}$.'],
     'ans':'$\\frac{1}{5}$','pts':1,'mins':2,'diff':'2',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7D 2024 – úloha 2.1','zad':[
        'Vypočítejte a výsledek zapište zlomkem v základním tvaru. Uveďte celý postup řešení.',
        '$\\left(\\frac{2}{3}-\\frac{2}{5}\\right)\\cdot\\left(-\\frac{7}{8}-1\\right)=$'],
     'opts':None,'ln':3,
     'sol':['$\\frac{2}{3}-\\frac{2}{5}=\\frac{10-6}{15}=\\frac{4}{15}$ a $-\\frac{7}{8}-1=-\\frac{15}{8}$.',
            'Součin $\\frac{4}{15}\\cdot\\left(-\\frac{15}{8}\\right)=-\\frac{4}{8}=-\\frac{1}{2}$.'],
     'ans':'$-\\frac{1}{2}$','pts':2,'mins':3,'diff':'3',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7D 2024 – úloha 2.2','zad':[
        'Vypočítejte a výsledek zapište zlomkem v základním tvaru. Uveďte celý postup řešení.',
        '$\\dfrac{\\frac{3}{4}\\cdot 5-\\frac{5}{6}\\cdot 3}{5}=$'],
     'opts':None,'ln':3,
     'sol':['Čitatel: $\\frac{3}{4}\\cdot 5-\\frac{5}{6}\\cdot 3=\\frac{15}{4}-\\frac{15}{6}=\\frac{15}{4}-\\frac{5}{2}=\\frac{15-10}{4}=\\frac{5}{4}$.',
            'Poté $\\frac{5}{4}:5=\\frac{5}{4}\\cdot\\frac{1}{5}=\\frac{1}{4}$.'],
     'ans':'$\\frac{1}{4}$','pts':2,'mins':3,'diff':'3',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7D 2024 – úloha 3.1','zad':[
        'Doplňte do rámečku takové číslo, aby platila rovnost.',
        '$6\\cdot 1{,}2+1{,}8:3=\\square$'],
     'opts':None,'ln':2,
     'sol':['$6\\cdot 1{,}2=7{,}2$ a $1{,}8:3=0{,}6$. Součet je $7{,}2+0{,}6=7{,}8$.'],
     'ans':'$7{,}8$','pts':1,'mins':2,'diff':'2',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7D 2024 – úloha 3.2','zad':[
        'Doplňte do rámečku takové číslo, aby platila rovnost.',
        '$\\square\\cdot 4=0{,}6\\cdot 50+28\\cdot 0{,}8$'],
     'opts':None,'ln':2,
     'sol':['Pravá strana: $0{,}6\\cdot 50+28\\cdot 0{,}8=30+22{,}4=52{,}4$. Hledané číslo je $52{,}4:4=13{,}1$.'],
     'ans':'$13{,}1$','pts':1,'mins':2,'diff':'2',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7D 2024 – úloha 4','zad':[
        'V září přivezli do skladu brambory. V říjnu je skladníci třídili. Jednu osminu z přivezených brambor vyhodili, jednu čtvrtinu z přivezených brambor vybrali na sadbu, což bylo $400$ kg, a zbytek brambor byl určen k prodeji.',
        '4.1 Kolik kilogramů brambor přivezli v září do skladu?',
        '4.2 Kolik kilogramů brambor skladníci vyhodili?',
        '4.3 Kolik kilogramů brambor bylo určeno k prodeji?'],
     'opts':None,'ln':3,
     'sol':['4.1 Čtvrtina přivezených brambor je $400$ kg, celkem tedy přivezli $4\\cdot 400=1600$ kg.',
            '4.2 Vyhodili osminu, tj. $\\frac{1}{8}\\cdot 1600=200$ kg.',
            '4.3 K prodeji zbylo $1600-200-400=1000$ kg.'],
     'ans':'4.1: $1600$ kg; 4.2: $200$ kg; 4.3: $1000$ kg','pts':6,'mins':7,'diff':'3',
     'codes':B+['aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M7D 2024 – úloha 5','zad':[
        'Sadař měl v chladírně $1$ tunu jablek určených k moštování a k prodeji do obchodů. Jablek určených k prodeji bylo třikrát více než jablek určených k moštování. Jablka určená k prodeji sadař prodával za cenu $14$ Kč za jeden kilogram a prodalo se jich $70\\,\\%$. Jablka určená k moštování sadař prodával za cenu $8$ Kč za jeden kilogram a prodalo se jich $80\\,\\%$. Neprodaná jablka se odvezla s dopravou zdarma ke zkrmení. Uveďte u obou podúloh celý postup řešení.',
        '5.1 Kolik korun utržil sadař za svá prodaná jablka?',
        '5.2 Kolik korun by sadař utržil za jablka odvezená ke zkrmení, kdyby je prodal?'],
     'opts':None,'ln':4,
     'sol':['$1$ tuna $=1000$ kg. Poměr prodej : moštování $=3:1$, tedy k prodeji je $750$ kg a k moštování $250$ kg.',
            '5.1 Prodáno: $70\\,\\%$ ze $750$ kg $=525$ kg za $14$ Kč $=7350$ Kč; $80\\,\\%$ z $250$ kg $=200$ kg za $8$ Kč $=1600$ Kč. Celkem $7350+1600=8950$ Kč.',
            '5.2 Ke zkrmení: $30\\,\\%$ ze $750$ kg $=225$ kg (za $14$ Kč) $=3150$ Kč; $20\\,\\%$ z $250$ kg $=50$ kg (za $8$ Kč) $=400$ Kč. Celkem $3150+400=3550$ Kč.'],
     'ans':'5.1: $8950$ Kč; 5.2: $3550$ Kč','pts':4,'mins':8,'diff':'3',
     'codes':B+['procenta','modelovani','slovni','bez-kalkulacky','finance']},

    {'name':'CERMAT M7D 2024 – úloha 6','zad':[
        'V kině je celkem $280$ dospělých diváků, žen je o $120$ více než mužů.',
        '6.1 Kolik je v kině žen?',
        '6.2 Jaký je poměr počtu žen k počtu mužů?'],
     'opts':None,'ln':2,
     'sol':['6.1 Nechť mužů je $m$, žen pak $m+120$. Dohromady $2m+120=280$, odtud $m=80$ a žen $80+120=200$.',
            '6.2 Poměr počtu žen k počtu mužů $200:80=5:2$.'],
     'ans':'6.1: $200$ žen; 6.2: $5:2$','pts':2,'mins':3,'diff':'2',
     'codes':B+['aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M7D 2024 – úloha 7','zad':[
        'Kadeřnice a pedikérka si pronajaly společně provozovnu a dohodly se, že veškeré náklady na provoz si rozdělí podle času, po který provozovnu využívají. V grafu je zobrazen počet hodin, které kadeřnice a pedikérka odpracují za týden (v neděli nepracují). Počet odpracovaných hodin kadeřnice za čtvrtek v grafu není uveden.',
        '7.1 Kolik hodin pracuje ve čtvrtek kadeřnice, když průměrně od pondělí do soboty pracuje $6$ hodin denně?',
        '7.2 Jestliže dohromady za týden za náklady na provoz zaplatí pedikérka s kadeřnicí $17\\,400$ Kč, kolik korun z této částky zaplatí pedikérka?'],
     'opts':None,'ln':3,'svg':SVG7,'fn':'graf-hodiny.svg',
     'alt':'Sdružený sloupcový graf odpracovaných hodin kadeřnice a pedikérky od pondělí do soboty; sloupec kadeřnice za čtvrtek chybí.',
     'cap':'Počet odpracovaných hodin za týden',
     'sol':['7.1 Za $6$ dnů při průměru $6$ h je celkem $36$ h. Uvedené dny kadeřnice: $6+8+6+7+4=31$ h, ve čtvrtek tedy $36-31=5$ h.',
            '7.2 Kadeřnice odpracuje $36$ h, pedikérka $4+3+4+3+4+4=22$ h, dohromady $58$ h. Na $1$ h připadá $17\\,400:58=300$ Kč, pedikérka zaplatí $22\\cdot 300=6600$ Kč.'],
     'ans':'7.1: $5$ hodin; 7.2: $6600$ Kč','pts':4,'mins':7,'diff':'3',
     'codes':B+['statistika','modelovani','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M7D 2024 – úloha 8 (konstrukce)','zad':[
        'Je dána přímka $p$ a bod $A$ ležící mimo přímku $p$ (viz obrázek).',
        'Sestrojte rovnoramenný trojúhelník $ABC$ se základnou $BC$, pokud platí: Bod $C$ leží na přímce $r$ rovnoběžné s přímkou $p$ a procházející bodem $A$. Výška k základně měří $4$ cm. Průsečík výšky se stranou $BC$ leží na přímce $p$.',
        'Najděte všechna řešení.'],
     'opts':None,'ln':0,'svg':SVG8,'fn':'primka-p-bod-A.svg',
     'alt':'Šikmá přímka p a bod A ležící nad přímkou p.','cap':'Výchozí obrázek k úloze 8',
     'sol':['Bodem $A$ vedeme přímku $r$ rovnoběžnou s $p$ (na ní leží $C$). Pata výšky $X$ leží na $p$ a $|AX|=4$ cm, proto je $X$ průsečíkem kružnice $k(A;4\\text{ cm})$ s přímkou $p$ (dvě polohy $X$, $X\'$).',
            'V bodě $X$ vztyčíme kolmici $q$ k úsečce $AX$; její průsečík s přímkou $r$ je vrchol $C$. Protože $X$ je střed základny $BC$, naneseme na kolmici $q$ na opačnou stranu od $C$ délku $|XB|=|XC|$ a získáme $B$.',
            'Úloha má dvě řešení – trojúhelníky $ABC$ a $AB\'C\'$.'],
     'ans':'Dvě řešení: pata výšky $X$ je průsečík kružnice $k(A;4\\text{ cm})$ s přímkou $p$, vrchol $C$ leží na rovnoběžce $r$ s $p$ bodem $A$ a $X$ je střed $BC$; trojúhelníky $ABC$ a $AB\'C\'$ (viz náčrt v klíči).',
     'pts':4,'mins':8,'diff':'4','codes':B+['konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7D 2024 – úloha 9 (konstrukce)','zad':[
        'Jsou dány body $A$ a $D$ (viz obrázek).',
        'Sestrojte lichoběžník $ABCD$ se základnami $AB$ a $CD$, pokud platí: Délka strany $AB$ je stejná jako délka strany $AD$. Velikost vnitřního úhlu $DAB$ je $130^\\circ$. Poměr velikostí stran $AB:CD$ je $2:3$.'],
     'opts':None,'ln':0,'svg':SVG9,'fn':'body-A-D.svg',
     'alt':'Body A a D v rovině.','cap':'Výchozí obrázek k úloze 9',
     'sol':['U vrcholu $A$ sestrojíme úhel $DAB=130^\\circ$. Na jeho druhém rameni naneseme $|AB|=|AD|$ (kružnice $k_1(A;|AD|)$), čímž získáme vrchol $B$.',
            'Základny jsou rovnoběžné, vedeme proto bodem $D$ přímku $p\\parallel AB$. Na ní leží vrchol $C$ tak, že $|CD|=\\frac{3}{2}|AB|$ (kružnice $k_2(D;\\frac{3}{2}|AB|)$).',
            'Spojením vrcholů získáme lichoběžník $ABCD$. Úloha má i druhé, osově souměrné řešení (nebylo předmětem hodnocení).'],
     'ans':'$|AB|=|AD|$, $\\angle DAB=130^\\circ$, $CD\\parallel AB$ a $|CD|=\\frac{3}{2}|AB|$; lichoběžník $ABCD$ (viz náčrt v klíči).',
     'pts':3,'mins':7,'diff':'3','codes':B+['konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7D 2024 – úloha 10','zad':[
        'Hotel zpoplatňuje ubytování stálou sazbou za osobu a noc. Ubytování pro $4$ lidi na $10$ nocí stojí $56\\,000$ Kč.',
        'Rozhodněte o každém z následujících tvrzení 10.1–10.3, zda je pravdivé (A), či nikoli (N).',
        '10.1 Jeden člověk zaplatí za ubytování na $5$ nocí $7\\,000$ Kč.',
        '10.2 Tři lidé zaplatí za ubytování na $8$ nocí $33\\,600$ Kč.',
        '10.3 Dva lidé zaplatí za ubytování na $20$ nocí $54\\,000$ Kč.'],
     'opts':None,'ln':0,
     'sol':['Sazba za osobu a noc je $56\\,000:(4\\cdot 10)=1400$ Kč.',
            '10.1 $1\\cdot 5\\cdot 1400=7000$ Kč → A.',
            '10.2 $3\\cdot 8\\cdot 1400=33\\,600$ Kč → A.',
            '10.3 $2\\cdot 20\\cdot 1400=56\\,000$ Kč, nikoli $54\\,000$ Kč → N.'],
     'ans':'10.1: A; 10.2: A; 10.3: N','pts':3,'mins':4,'diff':'2',
     'codes':B+['aritmetika','argumentace','slovni','bez-kalkulacky','finance']},

    {'name':'CERMAT M7D 2024 – úloha 11','zad':[
        'Klára vystřihla z papíru $3$ shodné obdélníky, $4$ shodné čtverce a $5$ shodných rovnoramenných trojúhelníků. Sestavila z nich tři obrazce. Obvod $1.$ obrazce je $40$ cm. (V žádném obrazci se útvary nepřekrývají.)',
        'Rozhodněte o každém z následujících tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).',
        '11.1 Obvod $2.$ obrazce je větší než obvod $1.$ obrazce.',
        '11.2 Obsah každého z obdélníků je roven $32$ cm².',
        '11.3 Obvod $3.$ obrazce je $48$ cm.'],
     'opts':None,'ln':0,'svg':SVG11,'fn':'tri-obrazce.svg',
     'alt':'Tři obrazce složené z obdélníků, čtverců a rovnoramenných trojúhelníků (schematický nákres).',
     'cap':'Schematický nákres tří obrazců (1., 2. a 3. obrazec)',
     'sol':['Z rozměrů útvarů a daného obvodu $1.$ obrazce ($40$ cm) plyne, že čtverec má stranu $4$ cm, obdélník rozměry $8$ cm $\\times$ $4$ cm a rovnoramenný trojúhelník rameno $6$ cm.',
            '11.1 Obvod $2.$ obrazce je také $40$ cm, není tedy větší → N.',
            '11.2 Obsah obdélníku je $8\\cdot 4=32$ cm² → A.',
            '11.3 Obvod $3.$ obrazce je $48$ cm → A.'],
     'ans':'11.1: N; 11.2: A; 11.3: A','pts':3,'mins':6,'diff':'3',
     'codes':B+['planimetrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7D 2024 – úloha 12','zad':[
        'Petr a Pavel četli stejnou knihu. Petr přečetl za každý den kromě posledního $28$ stránek. Pavel přečetl za každý den kromě posledního $35$ stránek. Na poslední den oběma zbylo $5$ stránek.',
        'Kolik stránek nejméně musí kniha mít?'],
     'opts':['A) $70$','B) $75$','C) $140$','D) $145$','E) $155$'],'ln':0,
     'sol':['Počet stránek zmenšený o posledních $5$ musí být dělitelný $28$ i $35$. Nejmenší společný násobek je $\\mathrm{nsn}(28,35)=140$. Kniha má tedy nejméně $140+5=145$ stránek.'],
     'ans':'D) $145$','pts':2,'mins':4,'diff':'3',
     'codes':B+['aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M7D 2024 – úloha 13','zad':[
        'Jsou dány rovnoběžky $a$ a $b$ a přímky $c$, $d$ a $e$, které se protínají s přímkou $b$ v bodě $B$ (viz obrázek).',
        'Jaký je součet velikostí úhlů $\\alpha$ a $\\beta$? Velikosti úhlů neměřte, ale vypočítejte (obrázek je ilustrační).'],
     'opts':['A) $74^\\circ$','B) $73^\\circ$','C) $72^\\circ$','D) $71^\\circ$','E) $70^\\circ$'],'ln':0,
     'svg':SVG13,'fn':'uhly-rovnobezky.svg',
     'alt':'Rovnoběžky a a b a tři přímky c, d, e procházející bodem B; u přímky a jsou vyznačeny úhly 38, 75 a 110 stupňů, u bodu B úhly alfa a beta.',
     'cap':'Schematický nákres k úloze 13 (ilustrační)',
     'sol':['Protože $a\\parallel b$, svírají přímky $c$, $d$, $e$ s oběma rovnoběžkami stejné úhly (souhlasné, resp. střídavé úhly).',
            'Úhel $\\alpha$ je mezi přímkami $c$ a $d$ a úhel $\\beta$ mezi přímkami $d$ a $e$, takže $\\alpha+\\beta$ je úhel mezi přímkami $c$ a $e$. Ten dopočteme z úhlů u přímky $a$: $\\alpha+\\beta=110^\\circ-38^\\circ=72^\\circ$.'],
     'ans':'C) $72^\\circ$','pts':2,'mins':5,'diff':'3',
     'codes':B+['planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7D 2024 – úloha 14','zad':[
        'Číselná osa je rozdělena na shodné dílky. Písmena $A$, $B$, $C$ a $D$ představují celá čísla. Víme, že $A+B=8$ a $A+C=4$ (viz obrázek).',
        'Jaký je součet čísel $D$ a $C$?'],
     'opts':['A) $24$','B) $12$','C) $-12$','D) $-16$','E) $-24$'],'ln':0,
     'svg':SVG14,'fn':'ciselna-osa.svg',
     'alt':'Číselná osa rozdělená na shodné dílky s vyznačenými body D, C, B, A (zleva doprava).',
     'cap':'Číselná osa (schematický nákres)',
     'sol':['Z rovností $A+B=8$ a $A+C=4$ plyne $B-C=4$. Body $B$ a $C$ jsou na ose vzdáleny jeden dílek, jeden dílek tedy odpovídá hodnotě $4$.',
            'Z osy pak $A=8$, $B=0$, $C=-4$ a $D=-20$. Součet $D+C=-20+(-4)=-24$.'],
     'ans':'E) $-24$','pts':2,'mins':4,'diff':'3',
     'codes':B+['aritmetika','porozumeni','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M7D 2024 – úloha 15','zad':[
        'V září byla cena trička $240$ Kč.',
        'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).',
        '15.1 V říjnu bylo toto tričko zdraženo na $300$ Kč. O kolik $\\%$ bylo v říjnu zdraženo?',
        '15.2 V prosinci bylo toto tričko zlevněno o $90$ Kč z říjnové ceny $300$ Kč. Kolik $\\%$ činila sleva?',
        '15.3 O kolik $\\%$ bylo tričko po prosincové slevě levnější než v září?'],
     'opts':['A) $12{,}5\\,\\%$','B) $25\\,\\%$','C) $30\\,\\%$','D) $32{,}5\\,\\%$','E) $37{,}5\\,\\%$','F) $40\\,\\%$'],'ln':0,
     'sol':['15.1 Zdražení o $300-240=60$ Kč z $240$ Kč, tj. $\\frac{60}{240}=25\\,\\%$ → B.',
            '15.2 Sleva $90$ Kč z $300$ Kč, tj. $\\frac{90}{300}=30\\,\\%$ → C.',
            '15.3 Prosincová cena je $300-90=210$ Kč; oproti září ($240$ Kč) o $30$ Kč levnější, tj. $\\frac{30}{240}=12{,}5\\,\\%$ → A.'],
     'ans':'15.1: B ($25\\,\\%$); 15.2: C ($30\\,\\%$); 15.3: A ($12{,}5\\,\\%$)','pts':6,'mins':8,'diff':'3',
     'codes':B+['procenta','vypocet','slovni','bez-kalkulacky','finance']},

    {'name':'CERMAT M7D 2024 – úloha 16','zad':[
        'Jsou dány hranoly s podstavou čtverce, trojúhelníku a kosodélníku. Všechny hranoly jsou vysoké $20$ cm. Rozměry podstav: $1.$ hranol – čtverec se stranou $a=4$ cm; $2.$ hranol – trojúhelník $a=6$ cm, $b=5$ cm, $c=5$ cm, $v_a=4$ cm; $3.$ hranol – kosodélník $a=6$ cm, $b=4$ cm, $v_a=3$ cm.',
        'V jakém poměru jsou objemy těchto hranolů? Poměr udejte v pořadí $1.$ hranol $:2.$ hranol $:3.$ hranol.'],
     'opts':None,'ln':2,'svg':SVG16,'fn':'podstavy-hranolu.svg',
     'alt':'Podstavy tří hranolů: čtverec, trojúhelník a kosodélník s vyznačenými rozměry.',
     'cap':'Podstavy hranolů (výška hranolů 20 cm)',
     'sol':['Všechny hranoly mají stejnou výšku $20$ cm, poměr objemů je proto roven poměru obsahů podstav.',
            'Čtverec: $S_1=4^2=16$ cm². Trojúhelník: $S_2=\\frac{a\\cdot v_a}{2}=\\frac{6\\cdot 4}{2}=12$ cm². Kosodélník: $S_3=a\\cdot v_a=6\\cdot 3=18$ cm².',
            'Poměr $16:12:18=8:6:9$.'],
     'ans':'$8:6:9$','pts':2,'mins':5,'diff':'3',
     'codes':B+['stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M7PDD24C0T04'
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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M7D-2024')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
