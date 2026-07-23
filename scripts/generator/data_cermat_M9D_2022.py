# -*- coding: utf-8 -*-
# CERMAT – Jednotná přijímací zkouška 2022, MATEMATIKA 9 (čtyřleté obory),
# varianta D (2. náhradní termín). Kód testu: M9PDD22C0T04.
# 16 úloh; po rozdělení izolovaných početních poduúloh (2, 3, 4, 5) celkem 21 úloh.
# Zdroj odpovědí: klíč správných řešení (KSR). Součet bodů 50.
# SVG obrázky bez apostrofů a zpětných lomítek; geometrie/tělesa schematicky.

# ---------- SVG obrázky ----------

# úloha 7: věž se dvěma schodišti a dvěma odpočívadly (schematicky)
SVG7 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 335" font-family="sans-serif">
<polygon points="175,72 295,72 235,34" fill="none" stroke="#999"/>
<line x1="175" y1="72" x2="175" y2="300" stroke="#999"/>
<line x1="295" y1="72" x2="295" y2="300" stroke="#999"/>
<line x1="150" y1="92" x2="295" y2="92" stroke="#000"/>
<line x1="175" y1="150" x2="295" y2="150" stroke="#000"/>
<line x1="175" y1="220" x2="295" y2="220" stroke="#000"/>
<line x1="150" y1="300" x2="345" y2="300" stroke="#000" stroke-width="2"/>
<line x1="212" y1="96" x2="212" y2="298" stroke="#444" stroke-dasharray="3 4"/>
<polygon points="212,96 208,107 216,107" fill="#444"/>
<line x1="258" y1="94" x2="258" y2="296" stroke="#444" stroke-dasharray="3 4"/>
<polygon points="258,296 254,285 262,285" fill="#444"/>
<text x="145" y="96" font-size="13" text-anchor="end">ochoz</text>
<text x="145" y="154" font-size="13" text-anchor="end">2. odpočívadlo</text>
<text x="145" y="224" font-size="13" text-anchor="end">1. odpočívadlo</text>
<text x="145" y="304" font-size="13" text-anchor="end">nádvoří</text>
<text x="207" y="320" font-size="12" text-anchor="middle">nahoru</text>
<text x="262" y="320" font-size="12" text-anchor="middle">dolů</text>
</svg>"""

# úloha 8: tmavý čtverec + 2 bílé trojúhelníky + 2 bílé lichoběžníky (schematicky)
SVG8 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 260" font-family="sans-serif">
<rect x="200" y="80" width="100" height="100" fill="#b8b8b8" stroke="#000"/>
<polygon points="200,80 200,180 150,130" fill="#fff" stroke="#000"/>
<polygon points="300,80 300,180 350,130" fill="#fff" stroke="#000"/>
<polygon points="200,80 300,80 285,45 215,45" fill="#fff" stroke="#000"/>
<polygon points="200,180 300,180 285,215 215,215" fill="#fff" stroke="#000"/>
</svg>"""

# úloha 9: výchozí obrázek – body A, S a přímka p (schematicky)
SVG9 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 235" font-family="sans-serif">
<line x1="40" y1="200" x2="390" y2="120" stroke="#000" stroke-width="2"/>
<text x="398" y="118" font-size="16" font-style="italic">p</text>
<line x1="150" y1="185" x2="150" y2="166" stroke="#000"/>
<text x="150" y="204" font-size="15" text-anchor="middle" font-style="italic">A</text>
<text x="255" y="88" font-size="15" text-anchor="middle">×</text>
<text x="255" y="76" font-size="15" text-anchor="middle" font-style="italic">S</text>
</svg>"""

# úloha 10: výchozí obrázek – body C, Q a přímka p (schematicky)
SVG10 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 255" font-family="sans-serif">
<line x1="60" y1="228" x2="380" y2="112" stroke="#000" stroke-width="2"/>
<text x="388" y="110" font-size="16" font-style="italic">p</text>
<text x="238" y="98" font-size="15" text-anchor="middle" font-style="italic">C</text>
<text x="238" y="112" font-size="15" text-anchor="middle">×</text>
<text x="150" y="122" font-size="15" text-anchor="middle" font-style="italic">Q</text>
<text x="150" y="136" font-size="15" text-anchor="middle">×</text>
</svg>"""

# úloha 11: tři útvary A, B, C ve čtvercové síti (schematicky podle testového sešitu)
def _grids():
    A = [[3,4],[2,5],[1,2,5,6],[1,3],[1,2,5,6],[2,5],[3,4]]
    B = [[],[2,3,5,6],[2,4,6],[1,7],[2,6],[2,3,5,6],[4]]
    C = [[5],[3,4],[3,5,7],[2,4,5,6],[5],[4],[]]
    cell = 20; cols = 8; rows = 7
    gw = cols*cell; gap = 40; oy = 30
    W = 3*gw + 2*gap + 20
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {W} {rows*cell+50}" font-family="sans-serif">']
    s.append('<g fill="#a9a9a9">')
    for gi,g in enumerate([A,B,C]):
        ox = 10 + gi*(gw+gap)
        for r,rowcells in enumerate(g):
            for c in rowcells:
                s.append(f'<rect x="{ox+(c-1)*cell}" y="{oy+r*cell}" width="{cell}" height="{cell}"/>')
    s.append('</g>')
    for gi,lab in enumerate(["A","B","C"]):
        ox = 10 + gi*(gw+gap)
        d = "".join(f'M{ox+i*cell} {oy}V{oy+rows*cell}' for i in range(cols+1))
        d += "".join(f'M{ox} {oy+j*cell}H{ox+gw}' for j in range(rows+1))
        s.append(f'<path d="{d}" fill="none" stroke="#000"/>')
        s.append(f'<text x="{ox+gw//2}" y="20" font-size="15" text-anchor="middle">{lab}</text>')
    s.append('</svg>')
    return "".join(s)
SVG11 = _grids()

# úloha 12: čtyřúhelník rozdělený na 2 tmavé rovnostranné trojúhelníky + bílý čtyřúhelník a trojúhelník
SVG12 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 575 250" font-family="sans-serif">
<polygon points="40,220 320,40 552,32 430,220" fill="#ffffff" stroke="#000" stroke-width="1.5"/>
<polygon points="250,220 320,40 552,32 430,220" fill="#c9c9c9" stroke="#000"/>
<line x1="320" y1="40" x2="430" y2="220" stroke="#000"/>
<line x1="250" y1="220" x2="245" y2="70" stroke="#000"/>
<line x1="247" y1="150" x2="320" y2="40" stroke="#000"/>
<text x="82" y="212" font-size="15">41°</text>
<text x="262" y="160" font-size="15">36°</text>
<text x="250" y="100" font-size="16" font-style="italic">φ</text>
</svg>"""

# úlohy 13–14: slepené těleso ze 4 trojbokých hranolů + jeden hranol (schematicky)
SVG13 = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 250" font-family="sans-serif">
<polygon points="395,60 470,60 470,88 395,88" fill="#ffffff" stroke="#000"/>
<polygon points="395,60 470,60 452,42" fill="#c9c9c9" stroke="#000"/>
<line x1="452" y1="42" x2="452" y2="70" stroke="#000" stroke-dasharray="3 3"/>
<line x1="470" y1="60" x2="470" y2="88" stroke="#000"/>
<polygon points="55,205 150,120 360,120 455,205" fill="#ffffff" stroke="#000" stroke-width="1.5"/>
<polygon points="55,205 150,120 108,205" fill="#c9c9c9" stroke="#000"/>
<polygon points="455,205 360,120 402,205" fill="#c9c9c9" stroke="#000"/>
<line x1="108" y1="205" x2="402" y2="205" stroke="#000"/>
<line x1="150" y1="120" x2="255" y2="205" stroke="#000" stroke-dasharray="3 3"/>
<line x1="360" y1="120" x2="255" y2="205" stroke="#000" stroke-dasharray="3 3"/>
</svg>"""

# ---------- Úlohy ----------

B = ['zs2', 'r9']  # 9. ročník ZŠ, čtyřleté obory

PROBLEMS = [
    {'name':'CERMAT M9D 2022 – úloha 1','zad':[
        'Vypište všechny dělitele čísla $95$, které jsou větší než $1$ a menší než $95$.'],
     'opts':None,'ln':1,
     'sol':['$95=5\\cdot 19$. Dělitelé čísla $95$ jsou $1, 5, 19, 95$; mezi $1$ a $95$ tedy leží $5$ a $19$.'],
     'ans':'$5$; $19$','pts':1,'mins':2,'diff':'2',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9D 2022 – úloha 2.1','zad':[
        'Vypočtěte: $(-3)^2-5^2-4\\cdot(-4)=$'],
     'opts':None,'ln':2,
     'sol':['$(-3)^2-5^2-4\\cdot(-4)=9-25+16=0$.'],
     'ans':'$0$','pts':1,'mins':2,'diff':'2',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9D 2022 – úloha 2.2','zad':[
        'Vypočtěte: $(0{,}08-1):0{,}2=$'],
     'opts':None,'ln':2,
     'sol':['$(0{,}08-1):0{,}2=(-0{,}92):0{,}2=-4{,}6$.'],
     'ans':'$-4{,}6$','pts':1,'mins':2,'diff':'2',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9D 2022 – úloha 3.1','zad':[
        'Vypočtěte a výsledek zapište zlomkem v základním tvaru:',
        '$\\left(\\frac{12}{5}\\cdot\\frac{3}{20}-\\frac{3}{20}\\right):\\frac{7}{25}=$'],
     'opts':None,'ln':4,
     'sol':['$\\frac{12}{5}\\cdot\\frac{3}{20}=\\frac{9}{25}$; $\\frac{9}{25}-\\frac{3}{20}=\\frac{36-15}{100}=\\frac{21}{100}$; $\\frac{21}{100}:\\frac{7}{25}=\\frac{21}{100}\\cdot\\frac{25}{7}=\\frac{3}{4}$.'],
     'ans':'$\\frac{3}{4}$','pts':2,'mins':3,'diff':'3',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9D 2022 – úloha 3.2','zad':[
        'Vypočtěte a výsledek zapište zlomkem v základním tvaru:',
        '$\\frac{12}{2+\\frac{2}{3}}\\cdot\\frac{2\\cdot\\frac{2}{3}}{18}=$'],
     'opts':None,'ln':4,
     'sol':['$2+\\frac{2}{3}=\\frac{8}{3}$, tedy $\\frac{12}{8/3}=\\frac{9}{2}$. Dále $2\\cdot\\frac{2}{3}=\\frac{4}{3}$, tedy $\\frac{4/3}{18}=\\frac{2}{27}$. Součin $\\frac{9}{2}\\cdot\\frac{2}{27}=\\frac{1}{3}$.'],
     'ans':'$\\frac{1}{3}$','pts':2,'mins':4,'diff':'3',
     'codes':B+['aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9D 2022 – úloha 4.1','zad':[
        'Zjednodušte (výsledný výraz nesmí obsahovat závorky ani znak pro odmocninu):',
        '$(10x-8)-x\\cdot\\sqrt{100-64}=$'],
     'opts':None,'ln':2,
     'sol':['$\\sqrt{100-64}=\\sqrt{36}=6$, tedy $(10x-8)-6x=4x-8$.'],
     'ans':'$4x-8$','pts':1,'mins':2,'diff':'2',
     'codes':B+['vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9D 2022 – úloha 4.2','zad':[
        'Do rámečků doplňte chybějící čísla $a$, $b$ tak, aby platila rovnost $(y+a)^2=y^2+10y+b$.'],
     'opts':None,'ln':2,
     'sol':['$(y+a)^2=y^2+2ay+a^2$. Porovnáním $2a=10$, tedy $a=5$, a $b=a^2=25$.'],
     'ans':'$a=5$; $b=25$','pts':1,'mins':2,'diff':'2',
     'codes':B+['vyrazy','porozumeni','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9D 2022 – úloha 4.3','zad':[
        'Zjednodušte (výsledný výraz nesmí obsahovat závorky):',
        '$(6n+1)\\cdot(1-2n-4n)+(1-2n)\\cdot(-4n)=$'],
     'opts':None,'ln':4,
     'sol':['$1-2n-4n=1-6n$; $(6n+1)(1-6n)=1-36n^2$; $(1-2n)(-4n)=-4n+8n^2$. Součet $1-36n^2-4n+8n^2=-28n^2-4n+1$.'],
     'ans':'$-28n^2-4n+1$','pts':2,'mins':3,'diff':'3',
     'codes':B+['vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9D 2022 – úloha 5.1','zad':[
        'Řešte rovnici:',
        '$x+0{,}2\\cdot(5x+0{,}9)=x:5$'],
     'opts':None,'ln':4,
     'sol':['$x+x+0{,}18=0{,}2x$; $2x+0{,}18=0{,}2x$; $1{,}8x=-0{,}18$; $x=-0{,}1$.'],
     'ans':'$x=-0{,}1$','pts':2,'mins':3,'diff':'3',
     'codes':B+['rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9D 2022 – úloha 5.2','zad':[
        'Řešte rovnici:',
        '$7\\cdot\\frac{y-3}{6}-\\frac{6y+6}{9}=\\frac{1}{3}$'],
     'opts':None,'ln':4,
     'sol':['Vynásobením číslem $18$: $21(y-3)-2(6y+6)=6$; $21y-63-12y-12=6$; $9y=81$; $y=9$.'],
     'ans':'$y=9$','pts':2,'mins':4,'diff':'3',
     'codes':B+['rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9D 2022 – úloha 6','zad':[
        'Stejné činky jsou baleny po $6$ kusech do stejných krabic. V obchodě mají čtyři krabice s činkami: dvě jsou plné, dvě poloprázdné a vše dohromady váží $47$ kg. V každé poloprázdné krabici zůstaly jen $3$ činky. Obě poloprázdné krabice s činkami váží celkem $16$ kg.',
        'Vypočtěte, kolik kilogramů váží',
        '6.1 jedna plná krabice s činkami,',
        '6.2 jedna činka,',
        '6.3 jedna prázdná krabice.'],
     'opts':None,'ln':3,
     'sol':['Označme hmotnost jedné činky $c$ a prázdné krabice $b$. Poloprázdná krabice váží $b+3c$; dvě poloprázdné $2(b+3c)=16$, tj. $b+3c=8$. Všechny čtyři krabice $2(b+6c)+2(b+3c)=47$, tj. $4b+18c=47$.',
            'Z $2b+6c=16$ a $4b+18c=47$ plyne $6c=15$, tedy $c=2{,}5$ kg a $b=0{,}5$ kg.',
            '6.1 Plná krabice $b+6c=0{,}5+15=15{,}5$ kg. 6.2 Jedna činka $2{,}5$ kg. 6.3 Prázdná krabice $0{,}5$ kg.'],
     'ans':'6.1: $15{,}5$ kg; 6.2: $2{,}5$ kg; 6.3: $0{,}5$ kg','pts':3,'mins':5,'diff':'3',
     'codes':B+['rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M9D 2022 – úloha 7','zad':[
        'Z nádvoří se chodí nahoru na ochoz věže po $80$ stejných vyšších schodech, zpět dolů se chodí jiným schodištěm po $96$ stejných nižších schodech. Obě schodiště jsou ve dvou místech propojena odpočívadly. Václav šel z nádvoří nahoru a po $60$ schodech potkal na 2. odpočívadle Danu, která šla dolů. Když Dana sešla ještě o $30$ schodů níže, potkala na 1. odpočívadle Evu, která šla nahoru.',
        'Vypočtěte,',
        '7.1 kolik schodů sešla Dana dolů z ochozu, než potkala Václava,',
        '7.2 kolik schodů vyšla Eva nahoru z nádvoří, než potkala Danu.'],
     'opts':None,'ln':3,'svg':SVG7,'fn':'schodiste.svg',
     'alt':'Věž se dvěma schodišti (nahoru 80 schodů, dolů 96 schodů) a dvěma odpočívadly mezi nádvořím a ochozem.',
     'cap':'Věž se dvěma schodišti a odpočívadly (schematicky)',
     'sol':['2. odpočívadlo je ve výšce $\\frac{60}{80}=\\frac{3}{4}$ celkové výšky. 7.1 Z ochozu k němu vede $\\frac{1}{4}$ z $96$ nižších schodů, tj. $24$ schodů.',
            '1. odpočívadlo je o $30$ nižších schodů níže, tedy $24+30=54$ schodů od ochozu; to odpovídá výšce $1-\\frac{54}{96}=\\frac{42}{96}=\\frac{7}{16}$. 7.2 Eva k němu vyšla $\\frac{7}{16}$ z $80$ vyšších schodů, tj. $35$ schodů.'],
     'ans':'7.1: $24$ schodů; 7.2: $35$ schodů','pts':4,'mins':6,'diff':'4',
     'codes':B+['aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M9D 2022 – úloha 8','zad':[
        'Obrazec se skládá z tmavého čtverce, dvou shodných bílých rovnoramenných trojúhelníků a dvou shodných bílých lichoběžníků. S každou stranou čtverce splývá základna jednoho bílého útvaru. Tmavý čtverec má obsah $144$ cm², což je polovina obsahu celého obrazce. Jeden trojúhelník má obsah $30$ cm². Délka kratší základny lichoběžníku je $9$ cm.',
        'Vypočtěte v cm',
        '8.1 výšku na základnu rovnoramenného trojúhelníku,',
        '8.2 výšku lichoběžníku.'],
     'opts':None,'ln':3,'svg':SVG8,'fn':'obrazec.svg',
     'alt':'Tmavý čtverec uprostřed, dva bílé trojúhelníky vlevo a vpravo, dva bílé lichoběžníky nahoře a dole (schematicky).',
     'cap':'Obrazec z tmavého čtverce, dvou trojúhelníků a dvou lichoběžníků',
     'sol':['Strana čtverce je $\\sqrt{144}=12$ cm, což je základna každého bílého útvaru. Bílé útvary mají dohromady obsah $144$ cm² (polovina obrazce).',
            '8.1 Trojúhelník: $30=\\frac{1}{2}\\cdot 12\\cdot v$, tedy $v=5$ cm.',
            '8.2 Dva trojúhelníky mají $60$ cm², dva lichoběžníky tedy $144-60=84$ cm², jeden $42$ cm². Lichoběžník: $42=\\frac{12+9}{2}\\cdot v=10{,}5\\,v$, tedy $v=4$ cm.'],
     'ans':'8.1: $5$ cm; 8.2: $4$ cm','pts':3,'mins':5,'diff':'3',
     'codes':B+['planimetrie','vypocet','slovni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9D 2022 – úloha 9','zad':[
        'V rovině leží body $A$, $S$ a přímka $p$ procházející bodem $A$ (viz obrázek).',
        'Bod $A$ je vrchol rovnoběžníku $ABCD$, bod $S$ je střed tohoto rovnoběžníku. Na přímce $p$ leží vrchol $B$ rovnoběžníku $ABCD$. Úhel $ASB$ má velikost $120^\\circ$.',
        'Sestrojte vrcholy $B$, $C$, $D$ rovnoběžníku $ABCD$, označte je písmeny a rovnoběžník narýsujte.'],
     'opts':None,'ln':0,'svg':SVG9,'fn':'body-A-S-p.svg',
     'alt':'Přímka p procházející bodem A a bod S nad přímkou.',
     'cap':'Výchozí obrázek k úloze 9',
     'sol':['Vrchol $B$ leží na přímce $p$; sestrojíme jej tak, aby $|\\angle ASB|=120^\\circ$ (přenesením úhlu $120^\\circ$ při vrcholu $S$ k polopřímce $SA$). Bod $C$ je obraz bodu $A$ ve středové souměrnosti se středem $S$ (S je střed úhlopříčky $AC$), bod $D$ je obraz bodu $B$ podle $S$. Spojením vznikne rovnoběžník $ABCD$.'],
     'ans':'Konstrukce rovnoběžníku $ABCD$: $B$ na přímce $p$ s $|\\angle ASB|=120^\\circ$, $C$ obraz $A$ a $D$ obraz $B$ ve středové souměrnosti se středem $S$ (viz obrázek v klíči).',
     'pts':2,'mins':5,'diff':'3',
     'codes':B+['konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9D 2022 – úloha 10','zad':[
        'V rovině leží body $C$, $Q$ a přímka $p$ (viz obrázek).',
        'Bod $C$ je vrchol rovnoramenného trojúhelníku $ABC$ se základnou $AB$. Ramena mají délku $5$ cm. Na přímce $p$ leží jeden vrchol trojúhelníku $ABC$. Bodem $Q$ prochází osa souměrnosti trojúhelníku $ABC$.',
        'Sestrojte vrcholy $A$, $B$ trojúhelníku $ABC$, označte je písmeny a trojúhelník narýsujte. Najděte všechna řešení.'],
     'opts':None,'ln':0,'svg':SVG10,'fn':'body-C-Q-p.svg',
     'alt':'Body C a Q a přímka p pod nimi.',
     'cap':'Výchozí obrázek k úloze 10',
     'sol':['Osa souměrnosti rovnoramenného trojúhelníku prochází vrcholem $C$ a bodem $Q$, je to tedy přímka $CQ$. Vrcholy $A$, $B$ leží na kružnici $k$ se středem $C$ a poloměrem $5$ cm a jsou navzájem souměrné podle osy $CQ$. Vrchol ležící na přímce $p$ najdeme jako průsečík kružnice $k$ s přímkou $p$, druhý vrchol je jeho obrazem v osové souměrnosti podle $CQ$. Úloha má dvě řešení.'],
     'ans':'Dvě řešení. Osa souměrnosti je přímka $CQ$; body $A$, $B$ leží na kružnici se středem $C$ a poloměrem $5$ cm souměrně podle $CQ$, jeden z nich na přímce $p$ (viz obrázek v klíči).',
     'pts':3,'mins':6,'diff':'4',
     'codes':B+['konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9D 2022 – úloha 11','zad':[
        'Ve čtvercové síti jsou z tmavých čtverců složeny tři útvary $A$, $B$, $C$; každý z nich má pouze jednu osu souměrnosti. V každém útvaru přemístíme jediný tmavý čtverec tak, aby měl upravený útvar co nejvíce různých os souměrnosti (svislých, vodorovných nebo šikmých).',
        'Rozhodněte o každém z tvrzení 11.1–11.3, zda je pravdivé (Ano), či nikoli (Ne).',
        '11.1 Správně upravený útvar $A$ má pouze $2$ osy souměrnosti.',
        '11.2 Správně upravený útvar $B$ má pouze $2$ osy souměrnosti.',
        '11.3 Správně upravený útvar $C$ má pouze $1$ osu souměrnosti.'],
     'opts':None,'ln':0,'svg':SVG11,'fn':'utvary-ABC.svg',
     'alt':'Tři útvary A, B, C složené z tmavých čtverců ve čtvercové síti (schematicky podle testového sešitu).',
     'cap':'Výchozí útvary A, B, C (schematicky)',
     'sol':['Po nejvýhodnějším přemístění jediného čtverce získá útvar $A$ právě $2$ osy souměrnosti (tvrzení Ano). Útvar $B$ lze upravit tak, aby měl více než $2$ osy, proto tvrzení o pouze $2$ osách neplatí (Ne). Útvar $C$ lze upravit tak, aby měl více než $1$ osu, proto tvrzení o pouze $1$ ose neplatí (Ne).'],
     'ans':'11.1: Ano; 11.2: Ne; 11.3: Ne','pts':4,'mins':6,'diff':'3',
     'codes':B+['planimetrie','argumentace','slovni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9D 2022 – úloha 12','zad':[
        'Čtyřúhelník je rozdělen na dva tmavé rovnostranné trojúhelníky, jeden bílý čtyřúhelník a jeden bílý trojúhelník (viz obrázek). Jsou vyznačeny úhly $41^\\circ$ a $36^\\circ$.',
        'Jaká je velikost úhlu $\\varphi$? Velikosti úhlů neměřte, ale vypočtěte.'],
     'opts':['A) $105^\\circ$','B) $110^\\circ$','C) $115^\\circ$','D) $120^\\circ$','E) větší než $120^\\circ$'],
     'ln':0,'svg':SVG12,'fn':'ctyruhelnik-uhel.svg',
     'alt':'Čtyřúhelník rozdělený na dva tmavé rovnostranné trojúhelníky a bílý čtyřúhelník a trojúhelník; vyznačeny úhly 41°, 36° a hledaný úhel φ.',
     'cap':'Schematický nákres k úloze 12',
     'sol':['Tmavé trojúhelníky jsou rovnostranné (vnitřní úhly $60^\\circ$). Postupným dopočítáním úhlů (přímý úhel na spodní přímce, daný úhel $36^\\circ$ a úhly $60^\\circ$ rovnostranných trojúhelníků) vychází pro $\\varphi$ hodnota větší než $120^\\circ$ (přibližně $125^\\circ$).'],
     'ans':'E) větší než $120^\\circ$','pts':2,'mins':5,'diff':'4',
     'codes':B+['planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9D 2022 – úloha 13','zad':[
        'Podstavou trojbokého kolmého hranolu je pravoúhlý trojúhelník, jehož dvě delší strany měří $17$ cm a $15$ cm. Výška hranolu je $5$ cm. Obě podstavy hranolu jsou tmavé, ostatní stěny bílé. Ze čtyř těchto hranolů je slepeno těleso (viz obrázek), které má dvě shodné stěny tmavé a zbývající čtyři stěny bílé.',
        'Jaký obsah mají dohromady všechny bílé stěny slepeného tělesa?'],
     'opts':['A) menší než $300$ cm²','B) $300$ cm²','C) $330$ cm²','D) $470$ cm²','E) větší než $470$ cm²'],
     'ln':0,'svg':SVG13,'fn':'slepene-teleso.svg',
     'alt':'Těleso slepené ze čtyř trojbokých hranolů se dvěma tmavými a čtyřmi bílými stěnami; vpravo nahoře jeden trojboký hranol (schematicky).',
     'cap':'Slepené těleso a trojboký hranol (schematicky)',
     'sol':['Odvěsny pravoúhlé podstavy jsou $15$ cm a $8$ cm, neboť $15^2+8^2=17^2$. Bílé (obdélníkové) stěny slepeného tělesa mají dohromady obsah $470$ cm².'],
     'ans':'D) $470$ cm²','pts':2,'mins':5,'diff':'3',
     'codes':B+['stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9D 2022 – úloha 14','zad':[
        'Podstavou trojbokého kolmého hranolu je pravoúhlý trojúhelník s odvěsnami $15$ cm a $8$ cm (přepona $17$ cm) a výškou $5$ cm. Ze čtyř těchto hranolů je slepeno těleso (viz obrázek).',
        'Jaký je objem slepeného tělesa?'],
     'opts':['A) $960$ cm³','B) $1\\,200$ cm³','C) $1\\,280$ cm³','D) $1\\,360$ cm³','E) jiný objem'],
     'ln':0,'svg':SVG13,'fn':'slepene-teleso.svg',
     'alt':'Těleso slepené ze čtyř trojbokých hranolů (schematicky).',
     'cap':'Slepené těleso ze čtyř trojbokých hranolů (schematicky)',
     'sol':['Objem jednoho hranolu je $\\frac{1}{2}\\cdot 15\\cdot 8\\cdot 5=300$ cm³. Těleso je slepeno ze čtyř hranolů, jeho objem je $4\\cdot 300=1\\,200$ cm³.'],
     'ans':'B) $1\\,200$ cm³','pts':2,'mins':3,'diff':'2',
     'codes':B+['stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu']},

    {'name':'CERMAT M9D 2022 – úloha 15','zad':[
        'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).',
        '15.1 Do prosince roku 2020 prodělal covid-19 každý dvacátý Čech. Kolik procent Čechů prodělalo covid-19 do prosince roku 2020?',
        '15.2 Počet novorozenců tvořil v dubnu $\\frac{26}{25}$ počtu novorozenců v březnu. O kolik procent byl počet novorozenců v dubnu vyšší než v březnu?',
        '15.3 Teplá kapalina v nádobě po vychladnutí zmenšila svůj objem o $\\frac{2}{27}$. O kolik procent byl objem teplé kapaliny větší než objem vychladlé kapaliny?'],
     'opts':['A) $4\\,\\%$','B) $5\\,\\%$','C) $6\\,\\%$','D) $7\\,\\%$','E) $8\\,\\%$','F) jiný počet procent'],
     'ln':0,
     'sol':['15.1 Každý dvacátý je $\\frac{1}{20}=5\\,\\%$ → B.',
            '15.2 $\\frac{26}{25}=1{,}04$, tj. o $4\\,\\%$ více → A.',
            '15.3 Vychladlá kapalina má $\\frac{25}{27}$ objemu teplé; poměr teplá : vychladlá $=\\frac{27}{25}=1{,}08$, tj. o $8\\,\\%$ více → E.'],
     'ans':'15.1: B ($5\\,\\%$); 15.2: A ($4\\,\\%$); 15.3: E ($8\\,\\%$)','pts':6,'mins':8,'diff':'3',
     'codes':B+['procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot']},

    {'name':'CERMAT M9D 2022 – úloha 16','zad':[
        'Řada je vytvořena z celých čísel. První trojice čísel je $0, 1, 2$. Každou další trojici vytvoříme tak, že jednotlivá čísla z předchozí trojice zvětšíme o $1$. Na 1. až 18. místě jsou čísla $0, 1, 2, 1, 2, 3, 2, 3, 4, 3, 4, 5, 4, 5, 6, 5, 6, 7, \\ldots$',
        'Určete,',
        '16.1 na kolikátém místě řady je poprvé číslo $12$,',
        '16.2 na kolika místech řady je mezi prvními $125$ čísly uvedeno liché číslo,',
        '16.3 které číslo je na 152. místě řady.'],
     'opts':None,'ln':3,
     'sol':['$k$-tá trojice ($k=1,2,\\ldots$) je $(k-1,\\ k,\\ k+1)$ na místech $3k-2,\\ 3k-1,\\ 3k$.',
            '16.1 Číslo $12$ se poprvé objeví jako poslední člen trojice $k=11$: $(10,11,12)$ na místech $31,32,33$; tedy na 33. místě.',
            '16.2 Prvních $125$ míst tvoří trojice $1$ až $41$ (místa 1–123) a místa 124, 125 (čísla $41$, $42$). V trojici se sudým $k$ jsou $2$ lichá čísla, s lichým $k$ jedno; pro $k=1$ až $41$ je to $20\\cdot 2+21\\cdot 1=61$, plus liché $41$ na 124. místě, celkem $62$.',
            '16.3 Místo $152$ je v trojici $k=51$: $(50,51,52)$ na místech $151,152,153$; na 152. místě je číslo $51$.'],
     'ans':'16.1: na 33. místě; 16.2: na $62$ místech; 16.3: číslo $51$','pts':4,'mins':7,'diff':'4',
     'codes':B+['posloupnosti','argumentace','pocetni','bez-kalkulacky','bez-kontextu']},
]

if __name__ == '__main__':
    import os, sys, json
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import gen_cermat as gen
    gen.CCODE = 'M9PDD22C0T04'
    gen.YEAR = 2022

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
    for path, sz, k in gen.chunk_files(PROBLEMS, os.path.join(outdir, 'import-cermat-M9D-2022')):
        tot += k; print(f'{os.path.basename(path)}: {sz} B, {k} úloh [{"OK" if sz<9000 else "PŘES 9KB"}]')
    print('Celkem úloh:', tot)
